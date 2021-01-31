<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Practical_Assignment._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron" runat="server">
        <h1>SITConnect</h1>
        <p class="lead">SITConnect is a stationary store that provide allow staff and students to purchase stationaries. </p>
        <p runat="server" id="loginBtnHome"><a href="Login" class="btn btn-primary btn-lg">Login &raquo;</a></p>
        <p runat="server">
            <asp:Button ID="btn_changePass" runat="server" OnClick="btn_changePass_Click" Text="Change Password" />
        </p>
    </div>

</asp:Content>
