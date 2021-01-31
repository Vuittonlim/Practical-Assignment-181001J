<%@ Page Title="Register account" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="Practical_Assignment.Registration" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.inputmask/3.3.4/jquery.inputmask.bundle.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <script type="text/javascript">

        function validate() {
            var str = document.getElementById('<%=tb_passSet.ClientID %>').value;

            if (str.length < 8) {
                document.getElementById("<%=lbl_pwdChecker.ClientID%>").innerHTML = "Password length must be at least 8 characters.";
                document.getElementById("<%=lbl_pwdChecker.ClientID%>").style.color = "Red";
                return ("Too_short");
            }
            else if (str.search(/[0-9]/) == -1) {
                document.getElementById("<%=lbl_pwdChecker.ClientID%>").innerHTML = "Password requires at least 1 number!";
                document.getElementById("<%=lbl_pwdChecker.ClientID%>").style.color = "Red";
                return ("No_num");
            }
            else if (str.search(/[A-Z]/) == -1) {
                document.getElementById("<%=lbl_pwdChecker.ClientID%>").innerHTML = "Password should contain uppercase letters!";
                document.getElementById("<%=lbl_pwdChecker.ClientID%>").style.color = "Red";
                return ("No_upper");
            }
            else if (str.search(/[a-z]/) == -1) {
                document.getElementById("<%=lbl_pwdChecker.ClientID%>").innerHTML = "Password should contain lowercase letters!";
                document.getElementById("<%=lbl_pwdChecker.ClientID%>").style.color = "Red";
                return ("No_lower");
            }
            else if (str.search(/[!@#$%^&*(),.?":{}|<>]/) == -1) {
                document.getElementById("<%=lbl_pwdChecker.ClientID%>").innerHTML = "Password should contain  at least 1 special character!";
                document.getElementById("<%=lbl_pwdChecker.ClientID%>").style.color = "Red";
                return ("No_regex");
            }
            document.getElementById("<%=lbl_pwdChecker.ClientID%>").innerHTML = "Excellent!";
            document.getElementById("<%=lbl_pwdChecker.ClientID%>").style.color = "Blue";
        }

        function allowNumbersAndSpace(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode;
            //allowing numbers, left key(37) right key(39) backspace(8) delete(46) and hyphen(45)
            var length = $('#<%=tb_creditCardNum.ClientID%>').val().length;
            if (((charCode == 37 || charCode == 39 || charCode == 8 || charCode == 46) || !(charCode > 31 && (charCode < 48 || charCode > 57))) && length < 19) {
                return true;
            }
            else {
                return false;
            }

        }
        $(document).ready(function one() {

            $('#<%=tb_creditCardNum.ClientID%>').on('keypress', function one() {
                var temp = $(this).val();
                if (temp.length == 4 || temp.length == 9 || temp.length == 14) {
                    $('#<%=tb_creditCardNum.ClientID%>').val(temp + ' ');
                }
            });


            $('#<%=tb_creditCardNum.ClientID%>').on('blur', function one() {
                var regex = /^[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{4}$/;
                var cardNumber = $(this).val();
                
            });

        });


        function allowNumbersAndSlash(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode;
            //allowing numbers, left key(37) right key(39) backspace(8) delete(46) and hyphen(45)
            var length = $('#<%=tb_dob.ClientID%>').val().length;
            if (((charCode == 37 || charCode == 39 || charCode == 8 || charCode == 46) || !(charCode > 31 && (charCode < 48 || charCode > 57))) && length < 10) {
                return true;
            }
            else {
                return false;
            }

        }
        $(document).ready(function two() {

            $('#<%=tb_dob.ClientID%>').on('keypress', function two() {
            var temp = $(this).val();
            if (temp.length == 2 || temp.length == 5) {
                $('#<%=tb_dob.ClientID%>').val(temp + '/');
            }
        });


            $('#<%=tb_dob.ClientID%>').on('blur', function two() {
                    var regex = /^[0-9]{2}-[0-9]{2}-[0-9]{2}$/;
                    var date = $(this).val();

                });

            });

    </script>

   

    <style type="text/css">
        .auto-style38 {
            width: 754px;
            height: 569px;
        }
        .auto-style75 {
            height: 35px;
            width: 100px;
        }
        .auto-style76 {
            height: 35px;
            width: 24px;
        }
        .auto-style77 {
            height: 35px;
            width: 48px;
        }
        .auto-style78 {
            height: 35px;
            width: 260px;
        }
        .auto-style79 {
            height: 35px;
            width: 128px;
        }
        .auto-style80 {
            height: 36px;
            width: 100px;
        }
        .auto-style81 {
            height: 36px;
            width: 24px;
        }
        .auto-style82 {
            height: 36px;
            width: 48px;
        }
        .auto-style83 {
            height: 36px;
            width: 260px;
        }
        .auto-style84 {
            height: 36px;
            width: 128px;
        }
    </style>

    <table class="auto-style38" style="margin-right: auto; margin-left: auto;">
            <tr>
                <td class="auto-style75"></td>
                <td class="auto-style76"></td>
                <td class="auto-style77"></td>
                <td class="auto-style78"></td>
                <td class="auto-style79"></td>
            </tr>
            <tr>
                <td class="auto-style75" style="text-align: center; font-weight: bold; font-size: x-large;">Registration</td>
                <td class="auto-style76" style="text-align: center; ">
                    <asp:Label ID="lbl_errorMsg" runat="server" Font-Size="18px"></asp:Label>
                </td>
                <td style="text-align: center; font-weight: bold;" class="auto-style77">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;</td>
                <td class="auto-style78"></td>
                <td class="auto-style79"></td>
            </tr>
            <tr>
                <td class="auto-style75">&nbsp;</td>
                <td class="auto-style76">&nbsp;</td>
                <td class="auto-style77">&nbsp;</td>
                <td class="auto-style78">&nbsp;</td>
                <td class="auto-style79">&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style75">
                    <asp:Label ID="lbl_fName" runat="server" Text="First Name: " Font-Size="18px"></asp:Label>
                </td>
                <td class="auto-style76">
                    <asp:TextBox ID="tb_fName" runat="server" Width="178px"></asp:TextBox>
                </td>
                <td class="auto-style77">&nbsp;</td>
                <td class="auto-style78">
                    <asp:Label ID="lbl_lName" runat="server" Text="Last&amp;nbsp;Name: " BorderColor="White" Font-Size="18px"></asp:Label>
                </td>
                <td class="auto-style79">
                    <asp:TextBox ID="tb_lName" runat="server" Width="178px"></asp:TextBox>
                </td>
            </tr>

            <tr>
                <td class="auto-style75">&nbsp;</td>
                <td class="auto-style76">&nbsp;</td>
                <td class="auto-style77">&nbsp;</td>
                <td class="auto-style78">&nbsp;</td>
                <td class="auto-style79">&nbsp;</td>
            </tr>

            <tr>
                <td class="auto-style75">
                    <asp:Label ID="lbl_creditCardNum" runat="server" Text="Credit Card Number: " Font-Size="18px"></asp:Label>
                </td>
                <td class="auto-style76">
                    <asp:TextBox ID="tb_creditCardNum" runat="server" Width="323px" Onkeypress="return allowNumbersAndSpace(event)"></asp:TextBox>
                    <asp:Label ID="Label1" runat="server" Text="No hyphens/spaces between digits." Font-Size="16px"></asp:Label>     
                    </td>
                    <td class="auto-style77">&nbsp;</td>
                <td class="auto-style78">
                    <asp:Label ID="lbl_securityCode" runat="server" Text="Security&amp;nbsp;Code: " Font-Size="18px"></asp:Label>
                </td>
                <td class="auto-style79">
                    <asp:TextBox ID="tb_securityCode" runat="server"  MaxLength="3"></asp:TextBox>
                </td>
            </tr>

            <tr>
                <td class="auto-style80">&nbsp;</td>
                <td class="auto-style81">&nbsp;</td>
                <td class="auto-style82">&nbsp;</td>
                <td class="auto-style83">&nbsp;</td>
                <td class="auto-style84">&nbsp;</td>
            </tr>

            <tr>
                <td class="auto-style80">
                    <asp:Label ID="lbl_cardName" runat="server" Text="Cardholder Name: " Font-Size="18px"></asp:Label>
                </td>
                <td class="auto-style81">
                    <asp:TextBox ID="tb_cardName" runat="server" Width="323px"></asp:TextBox>
                </td>
                <td class="auto-style82"></td>
                <td class="auto-style83">
                    <asp:Label ID="lbl_expiry" runat="server" Text="Expiry Date: " Font-Size="18px"></asp:Label>
                </td>
                <td class="auto-style84">
                    <asp:DropDownList ID="ddl_expiryMonth" runat="server">
                        <asp:ListItem Value="01">Jan</asp:ListItem>
                        <asp:ListItem Value="02">Feb</asp:ListItem>
                        <asp:ListItem Value="03">Mar</asp:ListItem>
                        <asp:ListItem Value="04">Apr</asp:ListItem>
                        <asp:ListItem Value="05">May</asp:ListItem>
                        <asp:ListItem Value="06">Jun</asp:ListItem>
                        <asp:ListItem Value="07">Jul</asp:ListItem>
                        <asp:ListItem Value="08">Aug</asp:ListItem>
                        <asp:ListItem Value="09">Sept</asp:ListItem>
                        <asp:ListItem Value="10">Oct</asp:ListItem>
                        <asp:ListItem Value="11">Nov</asp:ListItem>
                        <asp:ListItem Value="12">Dec</asp:ListItem>
                    </asp:DropDownList>
                    <asp:DropDownList ID="ddl_expiryYear" runat="server">
                        <asp:ListItem>21</asp:ListItem>
                        <asp:ListItem>22</asp:ListItem>
                        <asp:ListItem>23</asp:ListItem>
                        <asp:ListItem>24</asp:ListItem>
                        <asp:ListItem>25</asp:ListItem>
                        <asp:ListItem>26</asp:ListItem>
                        <asp:ListItem>27</asp:ListItem>
                        <asp:ListItem>28</asp:ListItem>
                        <asp:ListItem>29</asp:ListItem>
                        <asp:ListItem>30</asp:ListItem>
                        <asp:ListItem>31</asp:ListItem>
                        <asp:ListItem>32</asp:ListItem>
                        <asp:ListItem>33</asp:ListItem>
                        <asp:ListItem>34</asp:ListItem>
                        <asp:ListItem>35</asp:ListItem>
                        <asp:ListItem>36</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>

            <tr>
                <td class="auto-style80"></td>
                <td class="auto-style81"></td>
                <td class="auto-style82"></td>
                <td class="auto-style83"></td>
                <td class="auto-style84">&nbsp;</td>
            </tr>

            <tr>
                <td class="auto-style80">
                    <asp:Label ID="lbl_passSet" runat="server" Text="Set&amp;nbsp;Password: " Font-Size="18px"></asp:Label>
                </td>
                <td class="auto-style81">
                    <asp:TextBox ID="tb_passSet" runat="server" onkeyup="javascript:validate()" TextMode="Password" Width="323px"></asp:TextBox>
                </td>
                <td class="auto-style82">&nbsp;</td>
                <td class="auto-style83">
                    <asp:Label ID="lbl_email" runat="server" Text="Email: " Font-Size="18px"></asp:Label>
                </td>
                <td class="auto-style84">
                    <asp:TextBox ID="tb_email" runat="server" TextMode="Email" Width="323px"></asp:TextBox>
                </td>
            </tr>

            <tr>
                <td class="auto-style80">&nbsp;</td>
                <td class="auto-style81">
                    <asp:Label ID="lbl_pwdChecker" runat="server" Font-Size="16px"></asp:Label>
                </td>
                <td class="auto-style82">&nbsp;</td>
                <td class="auto-style83">&nbsp;</td>
                <td class="auto-style84">&nbsp;</td>
            </tr>

            <tr>
                <td class="auto-style80">
                    <asp:Label ID="lbl_dob" runat="server" Text="Date&amp;nbsp;of&amp;nbsp;Birth: " Font-Size="18px"></asp:Label>
                </td>
                <td class="auto-style81">
                    <asp:TextBox ID="tb_dob" runat="server" Width="323px" Onkeypress="return allowNumbersAndSlash(event)"></asp:TextBox>
                </td>
                <td class="auto-style82">&nbsp;</td>
                <td class="auto-style83">&nbsp;</td>
                <td class="auto-style84">&nbsp;</td>
            </tr>

            <tr>
                <td class="auto-style80">&nbsp;</td>
                <td class="auto-style81">
                    <asp:Label ID="dateFormat" runat="server" Text="(DD/MM/YYYY)" Font-Size="16px"></asp:Label>
                </td>
                <td class="auto-style82">&nbsp;</td>
                <td class="auto-style83">&nbsp;</td>
                <td class="auto-style84">&nbsp;</td>
            </tr>

            <tr>
                <td class="auto-style80">&nbsp;</td>
                <td class="auto-style81">&nbsp;</td>
                <td class="auto-style82">&nbsp;</td>
                <td class="auto-style83">&nbsp;</td>
                <td class="auto-style84">
                    &nbsp;</td>
            </tr>

            <tr>
                <td class="auto-style80">&nbsp;</td>
                <td class="auto-style81">
                    <asp:Button ID="btn_register" runat="server" Text="Register" OnClick="btn_register_Click" Font-Size="18px" />
                </td>
                <td class="auto-style82">&nbsp;</td>
                <td class="auto-style83">&nbsp;</td>
                <td class="auto-style84">
                    &nbsp;</td>
            </tr>

        </table>
</asp:Content>
