<%@ Page Title="Error" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="errorPage_Generic.aspx.cs" Inherits="Practical_Assignment.Error_Pages.errorPage_Generic" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .errorMsg{
            text-align:center;
            padding: 30px;
            font-size: 80px;
            color: white;
            font-weight: bold;
            margin-top: 10%;
        }
        body {
            background-image:url('../Images/error404.jpg');
            background-repeat:no-repeat;
            background-attachment:fixed;
            background-size: 100%;

        }
        .button{
            text-align: center;
            margin-left: auto;
            margin-right: auto;
            display: block;
            font-size: 30px;
        }
    </style>


    <div class="errorMsg">
        <h1 runat="server" >We don't know what went wrong, and we are truly sorry.</h1>
        <h3 runat="server">Go back to Home Page?</h3>
    </div>
    <asp:Button ID="backBtn" runat="server" Text="Go back." OnClick="backBtn_Click" CssClass="button"/>


   
</asp:Content>
