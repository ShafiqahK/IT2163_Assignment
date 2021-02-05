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
    public partial class Homepage : System.Web.UI.Page
    {
        string ASDBConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ASDBConnection"].ConnectionString;
       

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
                    string email = Session["LoggedIn"].ToString();
                    lbl_message.Text = "Welcome to SITConnect, " + getName(email) + ". Start adding the stationaries you need into your cart.";
                    btn_logout.Visible = true;
                }
            }

            else
            {
                Response.Redirect("Login.aspx", false);
            }
        }

            

        protected void btn_logout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Session.RemoveAll();

            Response.Redirect("Login.aspx", false);

            if (Request.Cookies["ASP.NET_SessionId"] != null)
            {
                Response.Cookies["ASP.NET_SessionId"].Value = string.Empty;
                Response.Cookies["ASP.NET_SessionId"].Expires = DateTime.Now.AddMonths(-20);
            }

            if (Request.Cookies["AuthToken"] != null)
            {
                Response.Cookies["AuthToken"].Value = string.Empty;
                Response.Cookies["AuthToken"].Expires = DateTime.Now.AddMonths(-20);
            }

        }

        protected string getName(string email)
        {
            string n = null;
            SqlConnection connection = new SqlConnection(ASDBConnectionString);
            string sql = "SELECT firstName, lastName FROM Account WHERE email=@EMAIL";
            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@EMAIL", email);
            try
            {
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {

                    while (reader.Read())
                    {
                        if (reader["firstName"] != null && reader["lastName"] !=null)
                        {
                            if (reader["firstName"] != DBNull.Value && reader["lastName"] != DBNull.Value)
                            {
                                n = reader["firstName"].ToString() + reader["lastName"].ToString();
                            }
                        }
                    }

                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally { connection.Close(); }
            return n;
        }

        protected void btn_changepwd_Click(object sender, EventArgs e)
        {
            Response.Redirect("ChangePassword.aspx");
        }
    }
}