<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PasswordChange.aspx.cs" Inherits="Practical_Assignment.PasswordChange" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">

        function validate() {
            var str = document.getElementById('<%=tb_newPass.ClientID %>').value;

            if (str.length < 8) {
                document.getElementById("<%=lbl_passMsg.ClientID%>").innerHTML = "Password length must be at least 8 characters.";
                document.getElementById("<%=lbl_passMsg.ClientID%>").style.color = "Red";
                return ("Too_short");
            }
            else if (str.search(/[0-9]/) == -1) {
                document.getElementById("<%=lbl_passMsg.ClientID%>").innerHTML = "Password requires at least 1 number!";
                document.getElementById("<%=lbl_passMsg.ClientID%>").style.color = "Red";
                return ("No_num");
            }
            else if (str.search(/[A-Z]/) == -1) {
                document.getElementById("<%=lbl_passMsg.ClientID%>").innerHTML = "Password should contain uppercase letters!";
                document.getElementById("<%=lbl_passMsg.ClientID%>").style.color = "Red";
                return ("No_upper");
            }
            else if (str.search(/[a-z]/) == -1) {
                document.getElementById("<%=lbl_passMsg.ClientID%>").innerHTML = "Password should contain lowercase letters!";
                document.getElementById("<%=lbl_passMsg.ClientID%>").style.color = "Red";
                return ("No_lower");
            }
            else if (str.search(/[!@#$%^&*(),.?":{}|<>]/) == -1) {
                document.getElementById("<%=lbl_passMsg.ClientID%>").innerHTML = "Password should contain  at least 1 special character!";
                document.getElementById("<%=lbl_passMsg.ClientID%>").style.color = "Red";
                return ("No_regex");
            }
            document.getElementById("<%=lbl_passMsg.ClientID%>").innerHTML = "Excellent!";
            document.getElementById("<%=lbl_passMsg.ClientID%>").style.color = "Blue";
        }
        </script>
    <table class="nav-justified" style="margin-right: auto; margin-left: auto;">
        <tr>
            <td style="width: 362px">&nbsp;</td>
            <td class="modal-sm" style="width: 108px">&nbsp;</td>
            <td style="width: 4px">&nbsp;</td>
            <td style="width: 408px">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 362px">&nbsp;</td>
            <td class="modal-sm" style="width: 108px">&nbsp;</td>
            <td style="width: 4px">&nbsp;</td>
            <td style="width: 408px">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 362px">&nbsp;</td>
            <td class="modal-sm" style="font-weight: bold; font-size: large; width: 108px;">Password Change</td>
            <td style="width: 4px">&nbsp;</td>
            <td style="width: 408px">
                <asp:Label ID="lbl_errorMsg" runat="server"></asp:Label>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 362px">&nbsp;</td>
            <td class="modal-sm" style="width: 108px">&nbsp;</td>
            <td style="width: 4px">&nbsp;</td>
            <td style="width: 408px">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 362px">&nbsp;</td>
            <td class="modal-sm" style="width: 108px">
                <asp:Label ID="lbl_oldPass" runat="server" Text="Old&amp;nbsp;Password:"></asp:Label>
            </td>
            <td style="width: 4px">&nbsp;</td>
            <td style="width: 408px">
                <asp:TextBox ID="tb_oldPass" runat="server" TextMode="Password" Width="300px"></asp:TextBox>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 362px">&nbsp;</td>
            <td class="modal-sm" style="width: 108px">&nbsp;</td>
            <td style="width: 4px">&nbsp;</td>
            <td style="width: 408px">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 362px">&nbsp;</td>
            <td class="modal-sm" style="width: 108px">
                <asp:Label ID="lbl_newPass" runat="server" Text="New&amp;nbsp;Password: "></asp:Label>
            </td>
            <td style="width: 4px">&nbsp;</td>
            <td style="width: 408px">
                <asp:TextBox ID="tb_newPass" runat="server" TextMode="Password" Width="300px" onkeyup="javascript:validate()" ></asp:TextBox>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 362px">&nbsp;</td>
            <td class="modal-sm" style="width: 108px">&nbsp;</td>
            <td style="width: 4px">&nbsp;</td>
            <td style="width: 408px">
                <asp:Label ID="lbl_passMsg" runat="server"></asp:Label>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 362px">&nbsp;</td>
            <td class="modal-sm" style="width: 108px">
                <asp:Label ID="lbl_newPassCfm" runat="server" Text="New&amp;nbsp;Password Confirm: "></asp:Label>
            </td>
            <td style="width: 4px">&nbsp;</td>
            <td style="width: 408px">
                <asp:TextBox ID="tb_newPassCfm" runat="server" TextMode="Password" Width="300px"></asp:TextBox>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 362px">&nbsp;</td>
            <td class="modal-sm" style="width: 108px">&nbsp;</td>
            <td style="width: 4px">&nbsp;</td>
            <td style="width: 408px">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 362px">&nbsp;</td>
            <td class="modal-sm" style="width: 108px">&nbsp;</td>
            <td style="width: 4px">&nbsp;</td>
            <td style="width: 408px">
                <asp:Button ID="btn_changePass" runat="server" Text="Change Password" OnClick="btn_changePass_Click" />
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 362px">&nbsp;</td>
            <td class="modal-sm" style="width: 108px">&nbsp;</td>
            <td style="width: 4px">&nbsp;</td>
            <td style="width: 408px">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>

</asp:Content>
