using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;

namespace Practical_Assignment
{
    public partial class Registration : System.Web.UI.Page
    {
        string MyDBConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["PracAssignmentDBConnection"].ConnectionString;
        static string finalHash;
        static string salt;
        byte[] Key;
        byte[] IV;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        private int checkPassword(string Password)
        {
            int score = 0;
            // Score 0 is vey weak
            // if length of password is less than 8 chars

            if (Password.Length < 8)
            {
                return 1;
            }
            else
            {
                score = 1;
            }

            if (Regex.IsMatch(Password, "[a-z]"))
            {
                score++;
            }

            if (Regex.IsMatch(Password, "[A-Z]"))
            {
                score++;
            }

            if (Regex.IsMatch(Password, "[0-9]"))
            {
                score++;
            }

            if (Regex.IsMatch(Password, "[^a-zA-Z0-9_.]"))
            {
                score++;
            }

            return score;
        }

        protected int validateInputs(string fName, string lName, string email, string dateOfBirth)
        {
            string FName = HttpUtility.HtmlEncode(fName);
            string LName = HttpUtility.HtmlEncode(lName);
            string Email = HttpUtility.HtmlEncode(email);
            string DateOfBirth = HttpUtility.HtmlEncode(dateOfBirth);
            //string emailPattern = @"^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$";
            //string emailPattern = @"^\w + ([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$";
            //string namePattern = /@"^(?:\p{L}+')?\w+\s?,\s?(?:\p{L}+')?\w+$"*/;
            //string datePattern = @"^(0[1-9]|[12]\d|3[01])/(0[1-9]|1[0-2])/(\d{2})$";
            int score = 0;
 
            if (!Regex.IsMatch(FName, @"^([a-zA-Z]+?)([-\s'][a-zA-Z]+)*?$") || !Regex.IsMatch(LName, @"^([a-zA-Z]+?)([-\s'][a-zA-Z]+)*?$"))
            {
                lbl_errorMsg.ForeColor = Color.Red;
                lbl_errorMsg.Text = "Name not valid.";
                score += 1;
                System.Diagnostics.Debug.WriteLine("name",score);
                return score;
            }

            if (!Regex.IsMatch(Email, @"^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$"))
            {
                lbl_errorMsg.ForeColor = Color.Red;
                lbl_errorMsg.Text = "Email not valid.";
                score += 1;
                System.Diagnostics.Debug.WriteLine("email", score);
                return score;

            }
            if (!Regex.IsMatch(DateOfBirth, @"^(0[1-9]|[12]\d|3[01])/(0[1-9]|1[0-2])/(\d{2})$"))
            {
                lbl_errorMsg.ForeColor = Color.Red;
                lbl_errorMsg.Text = "Date of birth not valid.";
                System.Diagnostics.Debug.WriteLine("date", score);
                score += 1;
                return score;

            }

            else if (Regex.IsMatch(FName, @"^([a-zA-Z]+?)([-\s'][a-zA-Z]+)*?$") && Regex.IsMatch(LName, @"^([a-zA-Z]+?)([-\s'][a-zA-Z]+)*?$") && Regex.IsMatch(Email, @"^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$") && Regex.IsMatch(DateOfBirth, @"^(0[1-9]|[12]\d|3[01])/(0[1-9]|1[0-2])/(\d{2})$"))
            {
                return score;
            }
            return score;

        }

        protected bool validateCreditCard(string card)
        {
            //if(card[0] == 5 || card[0] == 4 || card[0] == 3)
            //{
            //    return true;
            //}
            //return false; 
            try
            {
                System.Diagnostics.Debug.WriteLine(card[0]);
                if (card[0].ToString() == "5" || card[0].ToString() == "4" || card[0].ToString() == "3")
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch
            {
                return false;

            }
        }

        protected void btn_register_Click(object sender, EventArgs e)
        {
            if (tb_fName.Text == "" || tb_lName.Text == "" || tb_creditCardNum.Text == "" || tb_securityCode.Text == "" || tb_passSet.Text == "" || tb_cardName.Text == "" || tb_email.Text == "" || tb_dob.Text == "")
            {
                lbl_errorMsg.ForeColor = Color.Red;
                lbl_errorMsg.Text = "Please enter all fields before proceeding.";
            }
            int scores = checkPassword(tb_passSet.Text);
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
            lbl_pwdChecker.Text = "Status: " + status;
            if (scores < 4)
            {
                lbl_pwdChecker.ForeColor = Color.Red;
                return;
            }
            int inputs = validateInputs(tb_fName.Text, tb_lName.Text, tb_email.Text, tb_dob.Text);
            bool creditCard = validateCreditCard(tb_creditCardNum.Text);
            if (inputs == 0 && creditCard)
            {
                //lbl_pwdChecker.ForeColor = Color.Green;
                SqlConnection con = new SqlConnection(MyDBConnectionString);
                SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Account where Email = @paraEmail");
                SqlDataAdapter sda = new SqlDataAdapter();
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@paraEmail", tb_email.Text.ToString().Trim());
                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();
                int userCount = (int)cmd.ExecuteScalar();
                if (userCount > 0)  // if user exists
                {
                    lbl_errorMsg.ForeColor = Color.Red;
                    lbl_errorMsg.Text = "Account associated with email exists.";
                }
                else
                {
                    string pwd = tb_passSet.Text.Trim();

                    RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
                    byte[] saltByte = new byte[8];

                    rng.GetBytes(saltByte);
                    salt = Convert.ToBase64String(saltByte);

                    SHA512Managed hashing = new SHA512Managed();

                    string pwdWithSalt = pwd + salt;
                    byte[] plainHash = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwd));
                    byte[] hashWithSalt = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwdWithSalt));

                    finalHash = Convert.ToBase64String(hashWithSalt);

                    RijndaelManaged cipher = new RijndaelManaged();
                    cipher.GenerateKey();
                    Key = cipher.Key;
                    IV = cipher.IV;

                    string expiryMonth = ddl_expiryMonth.SelectedValue;
                    string expiryYear = ddl_expiryYear.SelectedValue;
                    string expiryDate = String.Format("{0}{1}", expiryMonth, expiryYear);
                    createAccount();
                    Response.Redirect("Login.aspx", true);
                }

            }

        }
        
        public void createAccount()
        {

            try
            {
                using (SqlConnection con = new SqlConnection(MyDBConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("INSERT INTO Account VALUES (@Fname,@Lname,@CreditCardNum,@CreditCardSCode,@CardholderName,@ExpiryDate,@PasswordHash,@PasswordSalt,@Email,@DateOfBirth,@AccStatus)"))
                    {
                        using (SqlDataAdapter sda = new SqlDataAdapter())
                        {
                            string expiryMonth = ddl_expiryMonth.SelectedValue;
                            string expiryYear = ddl_expiryYear.SelectedValue; 
                            string expiryDate = String.Format("{0}{1}", expiryMonth, expiryYear);

                            DateTime dob = DateTime.ParseExact(tb_dob.Text.ToString(),"dd/MM/yy", CultureInfo.InvariantCulture);
                            System.Diagnostics.Debug.WriteLine(tb_dob.Text.ToString());
                            System.Diagnostics.Debug.WriteLine(dob);
                            System.Diagnostics.Debug.WriteLine(dob.ToShortDateString(), CultureInfo.InvariantCulture);
                            cmd.CommandType = CommandType.Text;
                            cmd.Parameters.AddWithValue("@Fname", tb_fName.Text.Trim());
                            cmd.Parameters.AddWithValue("@Lname", tb_lName.Text.Trim());
                            cmd.Parameters.AddWithValue("@CreditCardNum", Convert.ToBase64String(encryptData(tb_creditCardNum.Text.Trim())));
                            cmd.Parameters.AddWithValue("@CreditCardSCode", Convert.ToBase64String(encryptData(tb_securityCode.Text.Trim())));
                            cmd.Parameters.AddWithValue("@CardholderName", tb_cardName.Text.Trim());
                            cmd.Parameters.AddWithValue("@ExpiryDate", expiryDate);
                            cmd.Parameters.AddWithValue("@PasswordHash", finalHash);
                            cmd.Parameters.AddWithValue("@PasswordSalt", salt);
                            cmd.Parameters.AddWithValue("@Email", tb_email.Text.Trim());
                            cmd.Parameters.AddWithValue("@DateOfBirth", dob);
                            cmd.Parameters.AddWithValue("@AccStatus", "A"); // A for active account, L for locked account
                            cmd.Connection = con;
                            con.Open();
                            cmd.ExecuteNonQuery();
                            con.Close();
                        }
                    }
                }
            }
            catch
            {
                lbl_errorMsg.Text = "Fields entered invalid. Please try again.";
            }
        }

        protected byte[] encryptData(string data)
        {
            byte[] cipherText = null;
            try
            {
                RijndaelManaged cipher = new RijndaelManaged();
                cipher.IV = IV;
                cipher.Key = Key;
                ICryptoTransform encryptTransform = cipher.CreateEncryptor();
                //ICryptoTransform decryptTransform = cipher.CreateDecryptor();
                byte[] plainText = Encoding.UTF8.GetBytes(data);
                cipherText = encryptTransform.TransformFinalBlock(plainText, 0, plainText.Length);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally { }
            return cipherText;
        }

    }
}