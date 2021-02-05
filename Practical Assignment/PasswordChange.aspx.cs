using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Practical_Assignment
{
    public partial class PasswordChange : System.Web.UI.Page
    {
        string MyDBConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["PracAssignmentDBConnection"].ConnectionString;
        static string finalHash;
        static string salt;
        byte[] Key;
        byte[] IV;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["LoggedIn"] != null && Session["AuthToken"] != null && Request.Cookies["AuthToken"] != null)
            {
                if (!Session["AuthToken"].ToString().Equals(Request.Cookies["AuthToken"].Value))
                {
                    Response.Redirect("Login.aspx", false);
                }
                else
                {
                    if (Session["Expired"].ToString() == "Expired")
                    {
                        lbl_errorMsg.Visible = true;
                        lbl_errorMsg.ForeColor = Color.Red;
                        lbl_errorMsg.Text = "Password has expired. Please change password.";

                    }
                    else if(Session["Expired"].ToString() == "Not yet")
                    {
                        lbl_errorMsg.Visible = false;
                    }
                    else if (Session["Expired"].ToString() == "Can't change yet")
                    {
                        lbl_errorMsg.Visible = true;
                        lbl_errorMsg.ForeColor = Color.Blue;
                        lbl_errorMsg.Text = "Unable to change password for the first 5 minutes of new password. Please try again later.";
                        lbl_oldPass.Visible = false;
                        lbl_newPass.Visible = false;
                        lbl_newPassCfm.Visible = false;
                        btn_changePass.Visible = false;
                        tb_oldPass.Visible = false;
                        tb_newPass.Visible = false;
                        tb_newPassCfm.Visible = false;
                        lbl_passMsg.Visible = false;
                    }
                }
            }
            else
            {
                Response.Redirect("Login.aspx", false);

            }
        }
        protected string getDBHash(string suppliedEmail)
        {
            string h = null;

            SqlConnection con = new SqlConnection(MyDBConnectionString);
            string sql = "SELECT PasswordHash FROM Account WHERE Email = @paraEmail";
            SqlCommand command = new SqlCommand(sql, con);
            command.Parameters.AddWithValue("@paraEmail", suppliedEmail);

            try
            {
                con.Open();

                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        if (reader["PasswordHash"] != null)
                        {
                            if (reader["PasswordHash"] != DBNull.Value)
                            {
                                h = reader["PasswordHash"].ToString();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally
            {
                con.Close();
            }
            return h;
        }

        protected string getDBSalt(string suppliedEmail)
        {
            string s = null;
            SqlConnection con = new SqlConnection(MyDBConnectionString);
            string sql = "SELECT PasswordSalt FROM Account WHERE Email = @paraEmail";
            SqlCommand command = new SqlCommand(sql, con);
            command.Parameters.AddWithValue("@paraEmail", suppliedEmail);

            try
            {
                con.Open();

                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        if (reader["PasswordSalt"] != null)
                        {
                            if (reader["PasswordSalt"] != DBNull.Value)
                            {
                                s = reader["PasswordSalt"].ToString();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally
            {
                con.Close();
            }
            return s;

        }

        protected int validatePassword(string password)
        {
            int scores = checkPassword(password);
            string status = "";
            switch (scores)
            {
                case 1:
                    status = "Very Weak";
                    break;

                case 2:
                    status = "Weak";
                    break;

                case 3:
                    status = "Medium";
                    break;

                case 4:
                    status = "Strong";
                    break;

                case 5:
                    status = "Excellent";
                    break;

                default:
                    break;
            }
            lbl_passMsg.Text = "Status: " + status;
            return scores;
        }

        protected int checkPassword(string Password)
        {
            string symbols = @"[!@#$%^&*()_+=\[{\]};:<>|./?,-]";
            int regexScore = 0;
            // Score 0 is vey weak
            // if length of password is less than 8 chars

            if (Password.Length < 8)
            {
                return 1;
            }
            else
            {
                regexScore = 1;
            }

            if (Regex.IsMatch(Password, "[a-z]"))
            {
                regexScore++;
            }

            if (Regex.IsMatch(Password, "[A-Z]"))
            {
                regexScore++;
            }

            if (Regex.IsMatch(Password, "[0-9]"))
            {
                regexScore++;
            }

            if (Regex.IsMatch(Password, symbols))
            {
                regexScore++;
            }

            return regexScore;
        }

        protected void registerNewPass(string userEmail, string oldHash, string oldSalt, string newHash, string newSalt, DateTime currentTime)
        {

            try
            {
                string updateHistResult = updateDBPassHist(userEmail, oldHash, oldSalt);
                string updateResult = updateDB(userEmail, newHash, newSalt, currentTime);
                if (updateResult == "Success" && updateHistResult == "Success")
                {
                    Session.Clear();
                    Session.Abandon();
                    Session.RemoveAll();
                    if (Request.Cookies["ASP.NET_SessionId"] != null)
                    {
                        Response.Cookies["ASP.NET_SessionId"].Value = string.Empty;
                        Response.Cookies["ASP.NET_SessionId"].Expires = DateTime.Now.AddMonths(-20);
                    }

                    if (Response.Cookies["AuthToken"] != null)
                    {
                        Response.Cookies["AuthToken"].Value = string.Empty;
                        Response.Cookies["AuthToken"].Expires = DateTime.Now.AddMonths(-20);
                    }
                    Response.Redirect("Default.aspx", true);
                }
            }
            catch
            {
            }
        }
               
      

        protected string checkPassHashHist(string userEmail, string newFinalHash)
        {
            string h = null;

            SqlConnection con = new SqlConnection(MyDBConnectionString);
            string sql = "SELECT OldPassHash FROM Account WHERE Email = @paraEmail";
            SqlCommand command = new SqlCommand(sql, con);
            command.Parameters.AddWithValue("@paraEmail", userEmail);

            try
            {
                con.Open();

                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        if (reader["OldPassHash"] != null)
                        {
                            if (reader["OldPassHash"] != DBNull.Value)
                            {
                                if (reader["OldPassHash"].ToString() != newFinalHash)  // if current doesnt matches the older hash hist
                                {
                                    h = reader["OldPassHash"].ToString(); 
                                }
                                else
                                {
                                    System.Diagnostics.Debug.WriteLine("Current matches the older hash");   // should match if want to do pass history
                                }
                            }
                        }
                    }
                }
            }
            catch
            {
                //throw new Exception(ex.ToString());
                lbl_errorMsg.Visible = true;
                lbl_errorMsg.Text = "New password cannot be same as any recent passwords. Please try again.";
            }
            finally
            {
                con.Close();
            }
            return h;
        }

        protected string checkPassSaltHist(string userEmail, string salt)
        {
            string s = null;
            SqlConnection con = new SqlConnection(MyDBConnectionString);
            string sql = "SELECT OldPassSalt FROM Account WHERE Email = @paraEmail";
            SqlCommand command = new SqlCommand(sql, con);
            command.Parameters.AddWithValue("@paraEmail", userEmail);

            try
            {
                con.Open();

                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        if (reader["OldPassSalt"] != null)
                        {
                            if (reader["OldPassSalt"] != DBNull.Value)
                            {
                                if (reader["OldPassSalt"].ToString() != salt)   // if current doesnt matches the salt hist
                                {
                                    s = reader["OldPassSalt"].ToString();
                                }
                            }
                        }
                    }
                }
            }
            catch
            {
                lbl_errorMsg.Visible = true;
                lbl_errorMsg.Text = "Updating of password failed. Please try again.";
            }
            finally
            {
                con.Close();
            }
            return s;
        }

        protected string updateDB(string userEmail, string finalHash, string salt, DateTime currentTime)  // replace current passwordhash and passwordsalt with new hash and salt
        {

            try
            {
                using (SqlConnection con = new SqlConnection(MyDBConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("UPDATE Account SET PasswordHash = @paraPasswordHash, PasswordSalt = @paraPasswordSalt, PasswordUsedTime = @PasswordTime where Email = @paraEmail"))
                    {
                        using (SqlDataAdapter sda = new SqlDataAdapter())
                        {
                            cmd.CommandType = CommandType.Text;
                            cmd.Parameters.AddWithValue("@paraPasswordHash", finalHash);
                            cmd.Parameters.AddWithValue("@paraPasswordSalt", salt);
                            cmd.Parameters.AddWithValue("@paraEmail", userEmail);
                            cmd.Parameters.AddWithValue("@PasswordTime", currentTime);
                            cmd.Connection = con;
                            con.Open();
                            cmd.ExecuteNonQuery();
                            con.Close();
                        }
                    }
                }
                return "Success";
            }
            catch
            {
                lbl_errorMsg.Text = "Updating of password failed. Please try again.";
                return "Failed";
            }
        }

        protected string updateDBPassHist(string userEmail, string oldHash, string salt)  // replace oldpassword hash and oldpassword columns with the current hash and salt
        {
            try
            {
                using (SqlConnection con = new SqlConnection(MyDBConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("UPDATE Account SET OldPassHash = @OldParaPasswordHash, OldPassSalt = @OldParaPasswordSalt where Email = @paraEmail"))
                    {
                        using (SqlDataAdapter sda = new SqlDataAdapter())
                        {
                            cmd.CommandType = CommandType.Text;
 
                            cmd.Parameters.AddWithValue("@OldParaPasswordHash", oldHash);
                            cmd.Parameters.AddWithValue("@OldParaPasswordSalt", salt);
                            cmd.Parameters.AddWithValue("@paraEmail", userEmail);
                            cmd.Connection = con;
                            con.Open();
                            cmd.ExecuteNonQuery();
                            con.Close();
                        }
                    }
                }
                return "Success";
            }
            catch
            {
                lbl_errorMsg.Visible = true;
                lbl_errorMsg.Text = "Updating of password failed. Please try again.";
                return "Failed";
            }
        }

        protected string checkPassAge(string suppliedEmail)
        {

            SqlConnection con = new SqlConnection(MyDBConnectionString);
            string sql = "SELECT PasswordUsedTime FROM Account WHERE Email = @paraEmail";
            SqlCommand command = new SqlCommand(sql, con);
            command.Parameters.AddWithValue("@paraEmail", suppliedEmail);
            string result = null;

            try
            {
                con.Open();

                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        if (reader["PasswordUsedTime"] != null)
                        {
                            if (reader["PasswordUsedTime"] != DBNull.Value)
                            {
                                string time = reader["PasswordUsedTime"].ToString();
                                DateTime passwordTime = Convert.ToDateTime(reader["PasswordUsedTime"]);
                                DateTime currentTime = DateTime.ParseExact(DateTime.Now.ToString("dd/MM/yyyy HH:mm tt"), "dd/MM/yyyy HH:mm tt", CultureInfo.InvariantCulture);
                                //int duration = currentTime.Minute - passwordTime.Minute;
                                TimeSpan difference = currentTime.Subtract(passwordTime);
                                double duration = difference.TotalMinutes;
                                if (duration >= 15)
                                {
                                    result = "Max";
                                }
                                else
                                {
                                    result = "All good";
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally
            {
                con.Close();
            }
            return result;
        }


        protected void btn_changePass_Click(object sender, EventArgs e)
        {
            if (tb_oldPass.Text == "" || tb_newPass.Text == "")
            {
                lbl_errorMsg.Visible = true;
                lbl_errorMsg.Text = "Please enter all fields.";
                lbl_errorMsg.ForeColor = Color.Red;
            }
            else
            {
                string email = Session["LoggedIn"].ToString();
                SHA512Managed hashing = new SHA512Managed();
                RijndaelManaged cipher = new RijndaelManaged();
                cipher.GenerateKey();
                Key = cipher.Key;
                IV = cipher.IV;
                string dbHash = getDBHash(email);   // get current hash CURRENT PASS
                string dbSalt = getDBSalt(email);   // get current salt CURRENT PASS

                if (dbSalt != null && dbSalt.Length > 0 && dbHash != null && dbHash.Length > 0) /// IF CURRENT NOT EMPTY
                {
                    string pwdWithSalt = tb_oldPass.Text.ToString() + dbSalt;   
                    byte[] hashWithSalt = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwdWithSalt));
                    string userHash = Convert.ToBase64String(hashWithSalt);
                    if (userHash.Equals(dbHash))    // if old pass that user typed matches the one found in db
                    {
                        int passwordScore = validatePassword(tb_newPass.Text);

                        if (passwordScore <= 4)
                        {
                            lbl_errorMsg.Visible = true;
                            lbl_errorMsg.Text = "New Password invalid. Please try again.";
                            lbl_errorMsg.ForeColor = Color.Red;
                        }
                        else if (passwordScore > 4)  // New password that user wants pass the regex test
                        {
                            if (tb_newPass.Text == tb_oldPass.Text)  // New pass match old pass, reject
                            {
                                lbl_errorMsg.Visible = true;
                                lbl_errorMsg.Text = "New Password should not be the same as the current password.";
                                lbl_errorMsg.ForeColor = Color.Red;
                            }
                            else
                            {
                                if (tb_newPass.Text == tb_newPassCfm.Text) // new pass match cfm new pass
                                {

                                    RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
                                    //byte[] saltByte = new byte[8];

                                    //rng.GetBytes(saltByte);
                                    //salt = Convert.ToBase64String(saltByte);

                                    SHA512Managed newPassHashing = new SHA512Managed();
                                    string newPwdWithSalt = tb_newPass.Text + dbSalt; // new pass with same db salt as others
                                    //byte[] newPlainHash = newPassHashing.ComputeHash(Encoding.UTF8.GetBytes(tb_newPass.Text));
                                    byte[] newHashwithSalt = newPassHashing.ComputeHash(Encoding.UTF8.GetBytes(newPwdWithSalt)); // hash new pass
                                    string newfinalHash = Convert.ToBase64String(newHashwithSalt);

                                    RijndaelManaged newCipher = new RijndaelManaged();
                                    newCipher.GenerateKey();
                                    Key = newCipher.Key;
                                    IV = newCipher.IV;

                                    string time = DateTime.Now.ToString("dd/MM/yyyy HH:mm");
                                    DateTime currentTime = DateTime.ParseExact(time, "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture);

                                    string dbHashHist = checkPassHashHist(email, newfinalHash); // check if new hash matches older hash
                                    //string dbSaltHist = checkPassSaltHist(email, dbSalt);

                                    //if (dbHashHist != null && dbSaltHist != null)       // if new password hash and salt is all good
                                    if (dbHashHist != null)       // if new password hash and salt is all good
                                    {
                                        registerNewPass(email, dbHash, dbSalt, newfinalHash, dbSalt, currentTime);
                                    }
                                    else 
                                    {
                                        lbl_errorMsg.Visible = true;
                                        lbl_errorMsg.Text = "New Password should not be used recently.";
                                        lbl_errorMsg.ForeColor = Color.Red;
                                    }

                                }
                                else
                                {
                                    lbl_errorMsg.Visible = true;
                                    lbl_errorMsg.Text = "New Passwords don't match.";
                                    lbl_errorMsg.ForeColor = Color.Red;
                                }
                            }
                        }
                                
                    }
                    else
                    {
                        lbl_errorMsg.Visible = true;
                        lbl_errorMsg.Text = "Old Password entered is wrong.";
                        lbl_errorMsg.ForeColor = Color.Red;
                    }
                }
            }
        }
    }
}