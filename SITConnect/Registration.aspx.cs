using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
using System.Drawing;

using System.Security.Cryptography;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace SITConnect
{
    public partial class Registration : System.Web.UI.Page
    {
        string ASDBConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ASDBConnection"].ConnectionString;
        static string finalHash;
        static string salt;
        byte[] Key;
        byte[] IV;


        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_create_Click(object sender, EventArgs e)
        {
            //DateTime dob = Convert.ToDateTime(tb_dob.Text);
            //DateTime today = DateTime.Today;
            //int age = (today.Year - dob.Year);

            if (string.IsNullOrEmpty(tb_fname.Text) && string.IsNullOrEmpty(tb_lname.Text) && string.IsNullOrEmpty(tb_creditcardnum.Text) && string.IsNullOrEmpty(tb_cvv.Text) && string.IsNullOrEmpty(tb_email.Text) && string.IsNullOrEmpty(tb_pwd.Text) && string.IsNullOrEmpty(tb_confirmpwd.Text) && string.IsNullOrEmpty(tb_dob.Text))
            {
                lbl_fieldchecker.Text = "Please fill in the mandatory fields";
            }

            else if (tb_creditcardnum.Text.Length != 16)
            {
                lbl_fieldchecker.Text = "Invalid credit card number";
            }

            else if (tb_cvv.Text.Length != 3)
            {
                lbl_fieldchecker.Text = "Invalid CVV number";
            }

            else if (tb_pwd.Text.Length < 8 && Regex.IsMatch(tb_pwd.Text, @"^([^0-9]*|[^A-Z]|[^a-z]|[^a-zA-Z0-9])$"))
            {
                lbl_fieldchecker.Text = "Password is not complex enough";
            }

            else if (DateTime.Now.Year - Convert.ToDateTime(tb_dob.Text).Year < 18)
            {
                lbl_fieldchecker.Text = "Age must be 18 and above";
            }

            else
            {
                //Response.Redirect("Login.aspx");
                string pwd = HttpUtility.HtmlEncode(tb_pwd.Text.ToString().Trim()); 
                //Generate random "salt"
                RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
                byte[] saltByte = new byte[8];
                //Fills array of bytes with a cryptographically strong sequence of random values.
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

                createAccount();
            }
           
        }

        public void createAccount()
        {
            using (SqlConnection con = new SqlConnection(ASDBConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("INSERT INTO Account VALUES(@firstName, @lastName, @cardNum, @cvv, @email, @passwordHash, @passwordSalt, @dob, @IV, @key)"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.Parameters.AddWithValue("@firstName", HttpUtility.HtmlEncode(tb_fname.Text.Trim()));
                        cmd.Parameters.AddWithValue("@lastName", HttpUtility.HtmlEncode(tb_lname.Text.Trim()));
                        cmd.Parameters.AddWithValue("@cardNum", Convert.ToBase64String(encryptData(HttpUtility.HtmlEncode(tb_creditcardnum.Text.Trim()))));
                        cmd.Parameters.AddWithValue("@cvv", Convert.ToBase64String(encryptData(HttpUtility.HtmlEncode(tb_cvv.Text.Trim()))));
                        cmd.Parameters.AddWithValue("@email", HttpUtility.HtmlEncode(tb_email.Text.Trim()));
                        cmd.Parameters.AddWithValue("@passwordHash", finalHash);
                        cmd.Parameters.AddWithValue("@passwordSalt", salt);
                        cmd.Parameters.AddWithValue("@dob", HttpUtility.HtmlEncode(tb_dob.Text.Trim()));
                        cmd.Parameters.AddWithValue("@IV", Convert.ToBase64String(IV));
                        cmd.Parameters.AddWithValue("@key", Convert.ToBase64String(Key));
                        cmd.Connection = con;

                        try
                        {
                            con.Open();
                            cmd.ExecuteNonQuery();
                            
                        }

                        catch (Exception)
                        {
                            //throw new Exception(ex.ToString());
                            lbl_fieldchecker.Text = "Please contact the administrator. We apologise for any inconvenience.";
                        }
                        finally
                        {
                            con.Close();
                        }
                    }
                }
            }

            Response.Redirect("Login.aspx");
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


                //Encrypt
                //cipherText = encryptTransform.TransformFinalBlock(plainText, 0, plainText.Length);
                //cipherString = Convert.ToBase64String(cipherText);
                //Console.WriteLine("Encrypted Text: " + cipherString);

            }
            catch (Exception)
            {
                lbl_fieldchecker.Text = "Please contact the administrator. We apologise for any inconvenience.";
            }

            finally { }
            return cipherText;
        }


    }
}