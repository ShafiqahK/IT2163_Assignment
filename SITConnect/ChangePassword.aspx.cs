using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SITConnect
{
    public partial class ChangePassword : System.Web.UI.Page
    {
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
                    btn_change.Visible = true;
                }
            }

            else
            {
                Response.Redirect("Login.aspx", false);
            }
        }

        protected void btn_change_Click(object sender, EventArgs e)
        {
            Response.Redirect("Homepage.aspx");
        }
    }
}