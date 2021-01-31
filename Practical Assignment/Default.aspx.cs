using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Practical_Assignment
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["loggedIn"] != null && Session["AuthToken"] != null && Request.Cookies["AuthToken"] != null)
            {
                loginBtnHome.Visible = false;
                btn_changePass.Visible = true;
            }
            else
            {
                loginBtnHome.Visible = true;
                btn_changePass.Visible = false;
            }
        }

        protected void btn_changePass_Click(object sender, EventArgs e)
        {
            Response.Redirect("PasswordChange.aspx", false);

        }
    }
}