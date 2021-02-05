using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Security.Cryptography;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace SITConnect
{
    public partial class Login : System.Web.UI.Page
    {
        string ASDBConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ASDBConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_login_Click(object sender, EventArgs e)
        {
            string pwd = HttpUtility.HtmlEncode(tb_password.Text.ToString().Trim());
            string username = HttpUtility.HtmlEncode(tb_username.Text.ToString().Trim());

            if (string.IsNullOrEmpty(pwd) && string.IsNullOrEmpty(username))
            {
                lbl_checker.Text = "Inputs are invalid";
            }

            else
            {
                SHA512Managed hashing = new SHA512Managed();
                string dbHash = getDBHash(username);
                string dbSalt = getDBSalt(username);

                try
                {
                    if (dbSalt != null && dbSalt.Length > 0 && dbHash != null && dbHash.Length > 0)
                    {
                        string pwdWithSalt = pwd + dbSalt;
                        byte[] hashWithSalt = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwdWithSalt));
                        string userHash = Convert.ToBase64String(hashWithSalt);

                        if (userHash.Equals(dbHash))
                        {
                            Session["LoggedIn"] = HttpUtility.HtmlEncode(tb_username.Text.Trim());

                            string guid = Guid.NewGuid().ToString();
                            Session["AuthToken"] = guid;

                            Response.Cookies.Add(new HttpCookie("AuthToken", guid));
                            Response.Redirect("Homepage.aspx", false);
                        }

                        else
                        {
                            lbl_checker.Text = "Username or password is not valid. Please try again.";
                            
                            //Response.Redirect("Login.aspx", false);
                        }

                    }

                    else
                    {
                        lbl_checker.Text = "Inputs are invalid";
                    }
                }

                catch (Exception)
                {
                    tb_username.Text = " ";
                    tb_password.Text = " ";
                    lbl_checker.Text = "Please contact the administrator. We apologise for any inconvenience.";
                }

                finally { }
            }
        }

        protected string getDBHash(string username)
        {
            string h = null;
            SqlConnection connection = new SqlConnection(ASDBConnectionString);
            string sql = "SELECT passwordHash FROM Account WHERE email=@USERNAME";
            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@USERNAME", username);
            try
            {
                connection.Open();
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
            catch (Exception)
            {
                lbl_checker.Text = "Please contact the administrator. We apologise for any inconvenience.";
            }
            finally { connection.Close(); }
            return h;
        }


        protected string getDBSalt(string username)
        {
            string s = null;
            SqlConnection connection = new SqlConnection(ASDBConnectionString);
            string sql = "SELECT passwordSalt FROM Account WHERE email=@USERNAME";
            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@USERNAME", username);
            try
            {
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        if (reader["PASSWORDSALT"] != null)
                        {
                            if (reader["PASSWORDSALT"] != DBNull.Value)
                            {
                                s = reader["PASSWORDSALT"].ToString();
                            }
                        }
                    }
                }
            }
            catch (Exception)
            {
                lbl_checker.Text = "Please contact the administrator. We apologise for any inconvenience.";
            }
            finally { connection.Close(); }
            return s;
        }

        protected void btn_register_Click(object sender, EventArgs e)
        {
            Response.Redirect("Registration.aspx");
        }
    }
}