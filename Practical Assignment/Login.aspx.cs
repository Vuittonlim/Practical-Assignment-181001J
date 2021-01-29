using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;

namespace Practical_Assignment
{
    public partial class Login : System.Web.UI.Page
    {
        private string MyDBConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["PracAssignmentDBConnection"].ConnectionString;
        private byte[] Key;
        private byte[] IV;
        static string finalHash;
        static string salt;
        public string success { get; set; }
        public List<string> ErrorMessage { get; set; }

        private static int loginCount;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public bool ValidateCaptcha()
        {
            bool result = true;

            // When user submits the recaptcha form, the user gets a response POST parameter.
            string captchaResponse = Request.Form["g-recaptcharesponse"];

            // To send a GET request to Google along with the response and Secret Key.
            HttpWebRequest req = (HttpWebRequest)WebRequest.Create
                ("https://www.google.com/recaptcha/api/siteverify?secret=6LfI_D0aAAAAAJXxu0qpicoxBiTEzm0wglkf3bQK &response=" + captchaResponse);

            try
            {
                // Codes to receive the Response in JSON format from Google server
                using (WebResponse wResponse = req.GetResponse())
                {
                    using (StreamReader readStream = new StreamReader(wResponse.GetResponseStream()))
                    {
                        // The response in JSON Format
                        string jsonResponse = readStream.ReadToEnd();

                        JavaScriptSerializer js = new JavaScriptSerializer();

                        // Create a jsonObject to handle the response eg success or error
                        // Deserialize json
                        Login jsonObject = js.Deserialize<Login>(jsonResponse);
                    }
                }
                return result;
            }
            catch (WebException ex)
            {
                throw ex;
            }
        }

        protected string checkAccStatus(string email)
        {
            try
            {
                // To see if account is locked
                SqlConnection con = new SqlConnection(MyDBConnectionString);
                string getAccCmd = "SELECT * FROM Account where Email = @paraEmail";
                SqlDataAdapter sda = new SqlDataAdapter(Convert.ToString(getAccCmd), con);
                sda.SelectCommand.Parameters.AddWithValue("@paraEmail", email);
                DataSet ds = new DataSet();
                sda.Fill(ds);

                int rec_cnt = ds.Tables[0].Rows.Count;
                string accStatus = "";
                if (rec_cnt == 1)
                {
                    DataRow row = ds.Tables[0].Rows[0];
                    accStatus = row["AccStatus"].ToString();
                }
                return accStatus;
            }
            catch (SqlException ex)
            {
                // User not found
                throw new Exception(ex.ToString());
            }

        }

        protected void lockAcc(string email)
        {
            SqlConnection con = new SqlConnection(MyDBConnectionString);
            loginMsg.Visible = true;
            loginMsg.Text = "Account lockout. Please try again later.";
            SqlCommand lockAccCmd = new SqlCommand("UPDATE Account SET AccStatus = @paraAccStatus where Email = @paraEmail");
            lockAccCmd.CommandType = CommandType.Text;
            lockAccCmd.Parameters.AddWithValue("paraAccStatus", "L");
            lockAccCmd.Parameters.AddWithValue("@paraEmail", email);
            lockAccCmd.Connection = con;
            con.Open();
            lockAccCmd.ExecuteNonQuery();
            con.Close();
        }

        protected void btn_login_Click(object sender, EventArgs e)
        {
            if (tb_emailLogin.Text == "" || tb_passwordLogin.Text == "")    // check if fields are entered
            {
                loginMsg.Text = "Please enter all fields.";
            }
            else if (ValidateCaptcha())
            {
                try
                {
                    SqlConnection con = new SqlConnection(MyDBConnectionString);
                    SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Account where Email = @paraEmail");
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@paraEmail", tb_emailLogin.Text.Trim());
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    int userCount = (int)cmd.ExecuteScalar();
                    con.Close();
                    if (userCount > 0)  // if user exists
                    {
                        string pwd = tb_passwordLogin.Text.ToString().Trim();
                        string email = tb_emailLogin.Text.ToString().Trim();
                        SHA512Managed hashing = new SHA512Managed();
                        RijndaelManaged cipher = new RijndaelManaged();
                        cipher.GenerateKey();
                        Key = cipher.Key;
                        IV = cipher.IV;
                        string dbHash = getDBHash(email);
                        string dbSalt = getDBSalt(email);
                        string AccStatus = checkAccStatus(tb_emailLogin.Text.ToString().Trim());

                        if (dbSalt != null && dbSalt.Length > 0 && dbHash != null && dbHash.Length > 0)
                        {
                            string pwdWithSalt = pwd + dbSalt;
                            byte[] hashWithSalt = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwdWithSalt));
                            string userHash = Convert.ToBase64String(hashWithSalt);
                            if (AccStatus == "A") // if account is not locked
                            {
                                if (userHash.Equals(dbHash)) // if pass match
                                {
                                    Session["LoggedIn"] = tb_emailLogin.Text.ToString().Trim();
                                    string guid = Guid.NewGuid().ToString();
                                    Session["AuthToken"] = guid;

                                    Response.Cookies.Add(new HttpCookie("AuthToken", guid));
                                    Response.Redirect("LoginSuccess233.aspx?=" + HttpUtility.UrlEncode(HttpUtility.HtmlEncode(tb_emailLogin.Text)), false);
                                }
                                else if (!userHash.Equals(dbHash)) // if pass don't match
                                {
                                    if (loginCount < 3)
                                    {
                                        loginMsg.Visible = true;
                                        loginMsg.Text = "Account details invalid. Please try again.";
                                        loginCount++;
                                    }

                                    else if (loginCount >= 3)
                                    {
                                        lockAcc(tb_emailLogin.Text.Trim());
                                    }
                                }

                            }

                            else if (AccStatus == "L") // Account locked
                            {
                                loginMsg.Visible = true;
                                loginMsg.Text = "Account lockout. Please try again later.";
                            }
                        }
                    }
                    else if (userCount == 0)
                    {
                        loginMsg.Text = "Account doesn't exist. Please try again.";
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.ToString());
                }
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
    }
}