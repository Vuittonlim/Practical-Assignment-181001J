<%@ Page Title="Success" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LoginSuccess.aspx.cs" Inherits="Practical_Assignment.LoginSuccess" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .successMsg{
            text-align:center;
            padding: 30px;
            font-size: 80px;
            color: black;
            font-weight: bold;
            margin-top: 10%;
        }
    
        .button{
            font-size: 30px;
            text-align: center;
        }
            
        .actions{
            margin-left: auto;
            margin-right: auto;
            text-align:center;
        }

    </style>


    <div class="successMsg">
        <h1 runat="server">Login Successful.</h1>
        <h3 runat="server">Welcome!</h3>
    </div>
    <div class="actions">
        <asp:Button ID="backBtn" runat="server" Text="Change Password" CssClass="button" OnClick="backBtn_Click"/>
        <asp:Button ID="btn_logout" runat="server" OnClick="btn_logout_Click" Text="Logout" CssClass="button" />
    </div>

   
</asp:Content>
