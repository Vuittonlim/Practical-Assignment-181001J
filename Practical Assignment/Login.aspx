<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Practical_Assignment.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style type="text/css">

        .auto-style38 {
            width: 754px;
        }
        .auto-style14 {
            width: 100px;
        }
        .auto-style7 {
            width: 258px;
        }
        .auto-style26 {
            width: 83px;
        }
        .auto-style34 {
            width: 90px;
        }
        .auto-style39 {
            width: 128px;
        }
        .auto-style15 {
            height: 20px;
            width: 100px;
        }
        .auto-style2 {
            height: 20px;
            width: 258px;
        }
        .auto-style21 {
            height: 20px;
            width: 83px;
        }
        .auto-style30 {
            height: 20px;
            width: 90px;
        }
        .auto-style9 {
            height: 20px;
            width: 128px;
        }
        .auto-style16 {
            height: 19px;
            width: 100px;
        }
        .auto-style3 {
            height: 19px;
            width: 258px;
        }
        .auto-style22 {
            height: 19px;
            width: 83px;
        }
        .auto-style27 {
            width: 90px;
            height: 19px;
        }
        .auto-style10 {
            height: 19px;
            width: 128px;
        }
        .auto-style17 {
            height: 11px;
            width: 100px;
        }
        .auto-style4 {
            height: 11px;
            width: 258px;
        }
        .auto-style29 {
            height: 11px;
            width: 83px;
        }
        .auto-style36 {
            height: 11px;
            width: 90px;
        }
        .auto-style40 {
            height: 11px;
            width: 128px;
        }
        .auto-style18 {
            height: 9px;
            width: 100px;
        }
        .auto-style5 {
            height: 9px;
            width: 258px;
        }
        .auto-style24 {
            height: 9px;
            width: 83px;
        }
        .auto-style32 {
            height: 9px;
            width: 90px;
        }
        .auto-style12 {
            height: 9px;
            width: 128px;
        }
        .auto-style19 {
            height: 10px;
            width: 100px;
        }
        .auto-style6 {
            height: 10px;
            width: 258px;
        }
        .auto-style25 {
            height: 10px;
            width: 83px;
        }
        .auto-style33 {
            height: 10px;
            width: 90px;
        }
        .auto-style13 {
            height: 10px;
            width: 128px;
        }
        </style>
    <script src="https://www.google.com/recaptcha/api.js?render=6LfI_D0aAAAAACkWRN1rpDGoJyeYQQIMDpNOLwBq"></script>
    <script>
        grecaptcha.ready(function () {
            grecaptcha.execute(' 6LfI_D0aAAAAACkWRN1rpDGoJyeYQQIMDpNOLwBq ', { action: 'Login' }).then(function (token) {
                document.getElementById("g-recaptcha-response").value = token;
            });
        });
    </script>
        <table class="auto-style38" style="margin-right: auto; margin-left: auto;">
            <tr>
                <td class="auto-style14">&nbsp;</td>
                <td class="auto-style7">&nbsp;</td>
                <td class="auto-style26">&nbsp;</td>
                <td class="auto-style34">&nbsp;</td>
                <td class="auto-style39">&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style15"></td>
                <td class="auto-style2"></td>
                <td class="auto-style21"></td>
                <td class="auto-style30"></td>
                <td class="auto-style9"></td>
            </tr>
            <tr>
                <td class="auto-style16" style="text-align: left; font-weight: bold; font-size: x-large;">Login</td>
                <td class="auto-style3" style="text-align: center; ">
                    <asp:Label ID="loginMsg" runat="server" Font-Size="18px"></asp:Label>
                </td>
                <td style="text-align: center; font-weight: bold;" class="auto-style22">&nbsp;</td>
                <td class="auto-style27"></td>
                <td class="auto-style10"></td>
            </tr>
            <tr>
                <td class="auto-style14">&nbsp;</td>
                <td class="auto-style7">&nbsp;</td>
                <td class="auto-style26">&nbsp;</td>
                <td class="auto-style34">&nbsp;</td>
                <td class="auto-style39">&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style17">
                    <asp:Label ID="lbl_fName" runat="server" Text="Email:" Font-Size="18px"></asp:Label>
                </td>
                <td class="auto-style4">
                    <asp:TextBox ID="tb_emailLogin" runat="server" TextMode="Email" Width="323px"></asp:TextBox>
                </td>
                <td class="auto-style29">&nbsp;</td>
                <td class="auto-style36">
                </td>
                <td class="auto-style40">
                    &nbsp;</td>
            </tr>

            <tr>
                <td class="auto-style17">&nbsp;</td>
                <td class="auto-style4">&nbsp;</td>
                <td class="auto-style29">&nbsp;</td>
                <td class="auto-style36">&nbsp;</td>
                <td class="auto-style40">&nbsp;</td>
            </tr>

            <tr>
                <td class="auto-style17">
                    <asp:Label ID="lbl_password" runat="server" Text="Password: " Font-Size="18px"></asp:Label>
                </td>
                <td class="auto-style4">
                    <asp:TextBox ID="tb_passwordLogin" runat="server" Width="323px" TextMode="Password"></asp:TextBox>
                    <asp:Label ID="errorMsg" runat="server" Font-Size="16px"></asp:Label>
                </td>
                <td class="auto-style29">&nbsp;</td>
                <td class="auto-style36">
                    &nbsp;</td>
                <td class="auto-style40">
                    &nbsp;</td>
            </tr>

            <tr>
                <td class="auto-style17">&nbsp;</td>
                <td class="auto-style4">&nbsp;</td>
                <td class="auto-style29">&nbsp;</td>
                <td class="auto-style36">&nbsp;</td>
                <td class="auto-style40">&nbsp;</td>
            </tr>

            <tr>
                <td class="auto-style18">
                    &nbsp;</td>
                <td class="auto-style5">
                    &nbsp;</td>
                <td class="auto-style24"></td>
                <td class="auto-style32">
                    &nbsp;</td>
                <td class="auto-style12">
                    &nbsp;</td>
            </tr>

            <tr>
                <td class="auto-style19"></td>
                <td class="auto-style6">
                    <asp:Button ID="btn_login" runat="server" Text="Login" OnClick="btn_login_Click" Font-Size="18px"/>
                </td>
                <td class="auto-style25"></td>
                <td class="auto-style33"></td>
                <td class="auto-style13">&nbsp;</td>
            </tr>

            <tr>
                <td class="auto-style17">
                    &nbsp;</td>
                <td class="auto-style4">
                    &nbsp;</td>
                <td class="auto-style29">&nbsp;</td>
                <td class="auto-style36">
                    &nbsp;</td>
                <td class="auto-style40">
                    &nbsp;</td>
            </tr>

            <tr>
                <td class="auto-style17"></td>
                <td class="auto-style4">
                    &nbsp;</td>
                <td class="auto-style29"></td>
                <td class="auto-style36"></td>
                <td class="auto-style40"></td>
            </tr>

            <tr>
                <td class="auto-style17">
                    &nbsp;</td>
                <td class="auto-style4">
                    &nbsp;</td>
                <td class="auto-style29">&nbsp;</td>
                <td class="auto-style36">&nbsp;</td>
                <td class="auto-style40">&nbsp;</td>
            </tr>

            <tr>
                <td class="auto-style17">&nbsp;</td>
                <td class="auto-style4">&nbsp;</td>
                <td class="auto-style29"><input type="hidden" id="g-recaptcha-response" name="g-recaptcha-response"/>
</td>
                <td class="auto-style36">&nbsp;</td>
                <td class="auto-style40">&nbsp;</td>
            </tr>

            <tr>
                <td class="auto-style17">&nbsp;</td>
                <td class="auto-style4">&nbsp;</td>
                <td class="auto-style29">&nbsp;</td>
                <td class="auto-style36">&nbsp;</td>
                <td class="auto-style40">
                    &nbsp;</td>
            </tr>

        </table>

</asp:Content>
