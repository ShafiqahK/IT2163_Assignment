<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SITConnect.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login Form</title>
    <script src="https://www.google.com/recaptcha/api.js?render="></script>
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
          <h1 style="text-align: center">Login</h1>
                    <p style="text-align: center">
                        <asp:Label ID="Label1" runat="server" Text="Username:"></asp:Label>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:TextBox ID="tb_username" runat="server"></asp:TextBox>
                    </p>
                    <p style="text-align: center">
                        <asp:Label ID="Label2" runat="server" Text="Password:"></asp:Label>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:TextBox ID="tb_password" runat="server" TextMode="Password"></asp:TextBox>
                    </p>
                    <p style="text-align: center">
                        <asp:Label ID="lbl_checker" runat="server" ForeColor="Red"></asp:Label>
                    </p>
                    <input type="hidden" id="g-recaptcha-response" name="g-recaptcha-response"/>
                    <p style="text-align: center">
                        <strong>
                        <asp:Button ID="btn_login" runat="server" OnClick="btn_login_Click" Text="Login" Font-Bold="True" Width="70px" />
                        </strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>
                        <asp:Button ID="btn_register" runat="server" Font-Bold="True" OnClick="btn_register_Click" Text="Register" />
                        </strong>
                    </p>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         </td>
         </tr>
         </table>
        </div>
    </form>
    <script>
        grecaptcha.ready(function () {
            grecaptcha.execute('', { action: 'Login' }).then(function (token) {
                document.getElementById("g-recaptcha-response").value = token;
            });
        });
    </script>
</body>
</html>
