﻿<%@ Page Title="Error 404" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="errorPage_404.aspx.cs" Inherits="Practical_Assignment.Error_Pages.errorPage_404" %>
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
        <h1 runat="server">Page not found.</h1>
        <h1 runat="server">404.</h1>
        <h3 runat="server">Sorry about this. Go back to Home Page?</h3>
    </div>
    <asp:Button ID="backBtn" runat="server" Text="Go back." OnClick="backBtn_Click" CssClass="button"/>


   
</asp:Content>
