<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginSuccess.aspx.cs" Inherits="Practical_Assignment.LoginSuccess" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Success"></asp:Label>
        </div>
        <asp:Button ID="btn_logout" runat="server" OnClick="btn_logout_Click" Text="logout" />
    </form>
</body>
</html>
