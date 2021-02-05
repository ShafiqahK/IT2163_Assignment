<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Homepage.aspx.cs" Inherits="SITConnect.Homepage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Home</title>
    <style type="text/css">
        .auto-style1 {
            text-align: center;
        }
        .auto-style3 {
            font-size: medium;
        }
        .auto-style7 {
            font-size: x-large;
        }
        .auto-style8 {
            font-size: medium;
            font-weight: bold;
        }
        .auto-style9 {
            text-align: center;
            font-size: xx-large;
        }
        .auto-style10 {
            font-size: xx-large;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="auto-style1">
            <h6 class="auto-style9">SITConnect<strong>&nbsp;
                </strong></h6>
            <p class="auto-style9">
                <asp:Label ID="lbl_message" runat="server" CssClass="auto-style7"></asp:Label>
            </p>
            <p class="auto-style10">
                <strong><em>
                <asp:Button ID="btn_changepwd" runat="server" CssClass="auto-style8" Text="Change Password" OnClick="btn_changepwd_Click" />
&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btn_logout" runat="server" CssClass="auto-style3" Font-Bold="True" Text="Logout" OnClick="btn_logout_Click" />
                &nbsp;&nbsp;&nbsp;&nbsp; </em>
                </strong>
            </p>
        </div>
    </form>
</body>
</html>
