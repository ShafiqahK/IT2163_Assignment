<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="SITConnect.ChangePassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Change Password</title>
    <script type="text/javascript">
        function validate() {
            var str = document.getElementById('<%=tb_newpwd.ClientID %>').value;

            if (str.length < 8) {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password length must be at least 8 characters";
                document.getElementById("lbl_pwdchecker").style.color = "Red";
                return ("too_short");
            }

            else if (str.search(/[0-9]/) == -1) {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password require at least 1 digit";
                document.getElementById("lbl_pwdchecker").style.color = "Red";
                return ("no_number");
            }

            else if (str.search(/[a-z]/) == -1) {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password require at least 1 lowercase letter";
                document.getElementById("lbl_pwdchecker").style.color = "Red";
                return ("no_Lletters");
            }

            else if (str.search(/[A-Z]/) == -1) {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password require at least 1 uppercase letter";
                document.getElementById("lbl_pwdchecker").style.color = "Red";
                return ("no_Uletters");
            }

            else if (str.search(/[^a-zA-Z0-9]/) == -1) {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password require at least 1 special character";
                document.getElementById("lbl_pwdchecker").style.color = "Red";
                return ("got_space");
            }

            else {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password is strong";
                document.getElementById("lbl_pwdchecker").style.color = "Blue";
            }
        }

        function matchPassword() {
            var pwd = document.getElementById('<%=tb_newpwd.ClientID %>').value;
            var pwd2 = document.getElementById('<%=tb_confirmpwd.ClientID %>').value;

            if (pwd != pwd2) {
                document.getElementById("lbl_pwdchecker2").innerHTML = "Password do not match";
                document.getElementById("lbl_pwdchecker2").style.color = "Red";
                return ("not_same");
            }
            else {
                document.getElementById("lbl_pwdchecker2").innerHTML = "";
            }
        }

    </script>
    <script src="https://www.google.com/recaptcha/api.js?render=6LfwqT8aAAAAAO9_wAitIFslznSsMcMJvtvWbAFB"></script>
    <style>
        body{
            display:flex;
            justify-content:center;
            align-items:center;
        }
        table{
            border:1px solid black;
        }
        .auto-style1{
            text-align:center;
            width: 570px;
        }
        
        .auto-style2 {
            font-size: xx-large;
        }
        .auto-style3 {
            text-align: left;
        }
        
        </style>
</head>
<body>
    <form id="form1" runat="server">
        <h6 class="auto-style3">
            <asp:Label ID="Label3" runat="server" CssClass="auto-style2" Text="SITConnect"></asp:Label>
            <br />
        </h6>
        <div>
            <table>
                <tr>

                <td class="auto-style1">
          <h1 style="text-align: center">Change Password</h1>
                    <p style="text-align: center">
                        <asp:Label ID="Label4" runat="server" Text="New Password:"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:TextBox ID="tb_newpwd" runat="server" onkeyup="javascript:validate()"></asp:TextBox>
                    </p>
                    <p>
                        <asp:Label ID="lbl_pwdchecker" runat="server"></asp:Label>
                    </p>
                    <p>
                        <asp:Label ID="Label5" runat="server" Text="Confirm Password:"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:TextBox ID="tb_confirmpwd" runat="server" onkeyup="javascript:matchPassword()"></asp:TextBox>
                    </p>
                    <p>
&nbsp;
                        <asp:Label ID="lbl_pwdchecker2" runat="server"></asp:Label>
                    </p>
                    <p style="text-align: center">
                        <asp:Button ID="btn_change" runat="server" Text="Change" OnClick="btn_change_Click" />
                    </p>
                    
         </td>
         </tr>
         </table>
        </div>
    </form>
</body>
</html>