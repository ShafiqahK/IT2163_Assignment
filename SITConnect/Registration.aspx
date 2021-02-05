<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="SITConnect.Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Registration</title>
    <script type="text/javascript">
        function validate() {
            var str = document.getElementById('<%=tb_pwd.ClientID %>').value;

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
            var pwd = document.getElementById('<%=tb_pwd.ClientID %>').value;
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
            color: #FF0000;
        }
        .auto-style3 {
            font-size: xx-large;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        
        <div>
            <h6>
                <asp:Label ID="Label1" runat="server" CssClass="auto-style3" Text="SITConnect"></asp:Label>
            </h6>
            <br />
            <table>
                <tr>

                <td class="auto-style1">
          <h1 style="text-align: center">Create Account</h1>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;


        <asp:Label ID="lbl_fname" runat="server" Text="First Name:"></asp:Label>
        
                    <span class="auto-style2">*</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        
        <asp:TextBox ID="tb_fname" runat="server" ></asp:TextBox>
                    &nbsp;&nbsp;&nbsp;
                    <br />
        <p>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="lbl_lname" runat="server" Text="Last Name:"></asp:Label>
            <span class="auto-style2">*</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="tb_lname" runat="server"></asp:TextBox>
        </p>
&nbsp;<asp:Label ID="lbl_creditcardnum" runat="server" Text="Credit Card Number:"></asp:Label>
            <span class="auto-style2">*</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:TextBox ID="tb_creditcardnum" runat="server" TextMode="Number"></asp:TextBox>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <br />
                    <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Label ID="lbl_cvv" runat="server" Text="CVV:"></asp:Label>
            <span class="auto-style2">*</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:TextBox ID="tb_cvv" runat="server" TextMode="Number"></asp:TextBox>
&nbsp;<p>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="lbl_email" runat="server" Text="Email:"></asp:Label>
            <span class="auto-style2">*</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="tb_email" runat="server" TextMode="Email"></asp:TextBox>
        </p>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lbl_password" runat="server" Text="Password:"></asp:Label>
                    <span class="auto-style2">*</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="tb_pwd" runat="server" TextMode="Password" onkeyup="javascript:validate()"></asp:TextBox>
                    <br />
                    <asp:Label ID="lbl_pwdchecker" runat="server"></asp:Label>
                    <p>
            <asp:Label ID="lbl_confirmpassword" runat="server" Text="Confirm Password:"></asp:Label>
            <span class="auto-style2">*</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="tb_confirmpwd" runat="server" TextMode="Password" onkeyup="javascript:matchPassword()"></asp:TextBox>
        &nbsp;&nbsp;
        <br />
                        <asp:Label ID="lbl_pwdchecker2" runat="server"></asp:Label>
        </p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Label ID="lbl_dob" runat="server" Text="Date of Birth:"></asp:Label>
                    <span class="auto-style2">*</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="tb_dob" runat="server" TextMode="Date"></asp:TextBox>
                    &nbsp;<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br />
                    <asp:Label ID="lbl_fieldchecker" runat="server" ForeColor="Red"></asp:Label>
&nbsp;<p>
            <asp:Button ID="btn_create" runat="server" Text="Create Account" OnClick="btn_create_Click" />
        </p>
         </td>
         </tr>
         </table>
        </div>

    </form>
</body>
</html>
