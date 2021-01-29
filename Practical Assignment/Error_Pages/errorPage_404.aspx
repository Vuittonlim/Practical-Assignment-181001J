<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="errorPage_404.aspx.cs" Inherits="Practical_Assignment.Error_Pages.errorPage_404" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <meta charset="utf-8" />
    <title></title>
    <style>
        .errorMsg{
            text-align:center;
            padding: 30px;
            font-size: 60px;
        }
    </style>
</head>
<body>
    <div class="errorMsg">
        <form runat="server">
              <h1 runat="server">Page not found.</h1>
        <h1 runat="server">404.</h1>
        <h3 runat="server">Sorry about this. Go back to Login Page?</h3>
        <asp:Button ID="backBtn" runat="server" Text="Go back." OnClick="backBtn_Click"/>
        </form>
    </div>
</body>
</html>
