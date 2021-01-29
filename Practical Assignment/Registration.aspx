<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="Practical_Assignment.Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Registration</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.maskedinput/1.4.1/jquery.maskedinput.js"></script>
    <script type="text/javascript">

        function validate() {
            var str = document.getElementById('<%=tb_passSet.ClientID %>').value;

            if (str.length < 8) {
                document.getElementById("lbl_pwdChecker").innerHTML = "Password length must be at least 8 characters.";
                document.getElementById("lbl_pwdChecker").style.color = "Red";
                return ("Too_short");
            }
            else if (str.search(/[0-9]/) == -1) {
                document.getElementById("lbl_pwdChecker").innerHTML = "Password requires at least 1 number!";
                document.getElementById("lbl_pwdChecker").style.color = "Red";
                return ("No_num");
            }
            else if (str.search(/[A-Z]/) == -1) {
                document.getElementById("lbl_pwdChecker").innerHTML = "Password should contain uppercase letters!";
                document.getElementById("lbl_pwdChecker").style.color = "Red";
                return ("No_upper");
            }
            else if (str.search(/[a-z]/) == -1) {
                document.getElementById("lbl_pwdChecker").innerHTML = "Password should contain lowercase letters!";
                document.getElementById("lbl_pwdChecker").style.color = "Red";
                return ("No_lower");
            }
            else if (str.search(/[!@#$%^&*(),.?":{}|<>]/) == -1) {
                document.getElementById("lbl_pwdChecker").innerHTML = "Password should contain  at least 1 special character!";
                document.getElementById("lbl_pwdChecker").style.color = "Red";
                return ("No_regex");
            }
            document.getElementById("lbl_pwdChecker").innerHTML = "Excellent!";
            document.getElementById("lbl_pwdChecker").style.color = "Blue";
        }



        document.getElementById('<%=tb_creditCardNum.ClientID %>').onkeypress = verify;


        function isKeyValid(key) {
            if (key > 47 && key < 58) return true
            else if (key === 45) return true;
            else return false;
        }
        function isValidCard(arr, isDash) {
            const last = arr[arr.length - 1];
            if (last.length === 4 && !isDash) return false;
            else if (isDash && last.length !== 4) return false;
            else if (isDash && arr.length === 4) return false;
            else return true;
        }
        function verify(e) {
            const key = e.keyCode || e.which;
            const isDash = key === 45;
            const val = e.target.value;
            const input = val.split('-');
            if (!isKeyValid(key) || !isValidCard(input, isDash)) {
                return e.preventDefault();
            }
            // ...do something
        }

  
        
    </script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>

    <style type="text/css">
        .auto-style9 {
            height: 20px;
            width: 128px;
        }
        .auto-style10 {
            height: 19px;
            width: 128px;
        }
        .auto-style12 {
            height: 9px;
            width: 128px;
        }
        .auto-style13 {
            height: 10px;
            width: 128px;
        }
        .auto-style14 {
            width: 100px;
        }
        .auto-style15 {
            height: 20px;
            width: 100px;
        }
        .auto-style16 {
            height: 19px;
            width: 100px;
        }
        .auto-style17 {
            height: 11px;
            width: 100px;
        }
        .auto-style18 {
            height: 9px;
            width: 100px;
        }
        .auto-style19 {
            height: 10px;
            width: 100px;
        }
        .auto-style21 {
            height: 20px;
            width: 83px;
        }
        .auto-style22 {
            height: 19px;
            width: 83px;
        }
        .auto-style24 {
            height: 9px;
            width: 83px;
        }
        .auto-style25 {
            height: 10px;
            width: 83px;
        }
        .auto-style26 {
            width: 83px;
        }
        .auto-style27 {
            width: 90px;
            height: 19px;
        }
        .auto-style29 {
            height: 11px;
            width: 83px;
        }
        .auto-style30 {
            height: 20px;
            width: 90px;
        }
        .auto-style32 {
            height: 9px;
            width: 90px;
        }
        .auto-style33 {
            height: 10px;
            width: 90px;
        }
        .auto-style34 {
            width: 90px;
        }
        .auto-style36 {
            height: 11px;
            width: 90px;
        }
        .auto-style38 {
            width: 754px;
        }
        .auto-style39 {
            width: 128px;
        }
        .auto-style40 {
            height: 11px;
            width: 128px;
        }
    </style>
</head>
<body>
    <form id="regForm" runat="server">
        <table class="auto-style38" style="margin-right: auto; margin-left: auto;">
            <tr>
                <td class="auto-style14">&nbsp;</td>
                <td class="auto-style26">&nbsp;</td>
                <td class="auto-style26">&nbsp;</td>
                <td class="auto-style34">&nbsp;</td>
                <td class="auto-style39">&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style15"></td>
                <td class="auto-style21"></td>
                <td class="auto-style21"></td>
                <td class="auto-style30"></td>
                <td class="auto-style9"></td>
            </tr>
            <tr>
                <td class="auto-style16" style="text-align: center; font-weight: bold;">Registration</td>
                <td class="auto-style22" style="text-align: center; ">
                    <asp:Label ID="lbl_errorMsg" runat="server"></asp:Label>
                </td>
                <td style="text-align: center; font-weight: bold;" class="auto-style22">&nbsp;</td>
                <td class="auto-style27"></td>
                <td class="auto-style10"></td>
            </tr>
            <tr>
                <td class="auto-style14">&nbsp;</td>
                <td class="auto-style26">&nbsp;</td>
                <td class="auto-style26">&nbsp;</td>
                <td class="auto-style34">&nbsp;</td>
                <td class="auto-style39">&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style17">
                    <asp:Label ID="lbl_fName" runat="server" Text="First Name: "></asp:Label>
                </td>
                <td class="auto-style29">
                    <asp:TextBox ID="tb_fName" runat="server"></asp:TextBox>
                </td>
                <td class="auto-style29">&nbsp;</td>
                <td class="auto-style36">
                    <asp:Label ID="lbl_lName" runat="server" Text="Last Name: "></asp:Label>
                </td>
                <td class="auto-style40">
                    <asp:TextBox ID="tb_lName" runat="server"></asp:TextBox>
                </td>
            </tr>

            <tr>
                <td class="auto-style17">&nbsp;</td>
                <td class="auto-style29">&nbsp;</td>
                <td class="auto-style29">&nbsp;</td>
                <td class="auto-style36">&nbsp;</td>
                <td class="auto-style40">&nbsp;</td>
            </tr>

            <tr>
                <td class="auto-style17">
                    <asp:Label ID="lbl_creditCardNum" runat="server" Text="Credit Card Number: "></asp:Label>
                </td>
                <td class="auto-style29">
                    <asp:TextBox ID="tb_creditCardNum" runat="server" Width="323px"></asp:TextBox>
                    <asp:Label ID="Label1" runat="server" Text="No hyphens/spaces between digits."></asp:Label>     
                    </td>
                    <td class="auto-style29">&nbsp;</td>
                <td class="auto-style36">
                    <asp:Label ID="lbl_securityCode" runat="server" Text="Security Code: "></asp:Label>
                </td>
                <td class="auto-style40">
                    <asp:TextBox ID="tb_securityCode" runat="server"></asp:TextBox>
                </td>
            </tr>

            <tr>
                <td class="auto-style17">&nbsp;</td>
                <td class="auto-style29">&nbsp;</td>
                <td class="auto-style29">&nbsp;</td>
                <td class="auto-style36">&nbsp;</td>
                <td class="auto-style40">&nbsp;</td>
            </tr>

            <tr>
                <td class="auto-style18">
                    <asp:Label ID="lbl_cardName" runat="server" Text="Cardholder Name: "></asp:Label>
                </td>
                <td class="auto-style24">
                    <asp:TextBox ID="tb_cardName" runat="server" Width="323px"></asp:TextBox>
                </td>
                <td class="auto-style24"></td>
                <td class="auto-style32">
                    <asp:Label ID="lbl_expiry" runat="server" Text="Expiry Date: "></asp:Label>
                </td>
                <td class="auto-style12">
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
                <td class="auto-style19"></td>
                <td class="auto-style25"></td>
                <td class="auto-style25"></td>
                <td class="auto-style33"></td>
                <td class="auto-style13">&nbsp;</td>
            </tr>

            <tr>
                <td class="auto-style17">
                    <asp:Label ID="lbl_passSet" runat="server" Text="Set Password: "></asp:Label>
                </td>
                <td class="auto-style29">
                    <asp:TextBox ID="tb_passSet" runat="server" onkeyup="javascript:validate()" TextMode="Password"></asp:TextBox>
                </td>
                <td class="auto-style29">&nbsp;</td>
                <td class="auto-style36">
                    <asp:Label ID="lbl_email" runat="server" Text="Email: "></asp:Label>
                </td>
                <td class="auto-style40">
                    <asp:TextBox ID="tb_email" runat="server" TextMode="Email"></asp:TextBox>
                </td>
            </tr>

            <tr>
                <td class="auto-style17">&nbsp;</td>
                <td class="auto-style29">
                    <asp:Label ID="lbl_pwdChecker" runat="server"></asp:Label>
                </td>
                <td class="auto-style29">&nbsp;</td>
                <td class="auto-style36">&nbsp;</td>
                <td class="auto-style40">&nbsp;</td>
            </tr>

            <tr>
                <td class="auto-style17">
                    <asp:Label ID="lbl_dob" runat="server" Text="Date of Birth: "></asp:Label>
                </td>
                <td class="auto-style29">
                    <asp:TextBox ID="tb_dob" runat="server"></asp:TextBox>
                </td>
                <td class="auto-style29">&nbsp;</td>
                <td class="auto-style36">&nbsp;</td>
                <td class="auto-style40">&nbsp;</td>
            </tr>

            <tr>
                <td class="auto-style17">&nbsp;</td>
                <td class="auto-style29">
                    <asp:Label ID="dateFormat" runat="server" Text="(DD/MM/YY)"></asp:Label>
                </td>
                <td class="auto-style29">&nbsp;</td>
                <td class="auto-style36">&nbsp;</td>
                <td class="auto-style40">&nbsp;</td>
            </tr>

            <tr>
                <td class="auto-style17">&nbsp;</td>
                <td class="auto-style29">&nbsp;</td>
                <td class="auto-style29">&nbsp;</td>
                <td class="auto-style36">&nbsp;</td>
                <td class="auto-style40">
                    <asp:Button ID="btn_register" runat="server" Text="Register" OnClick="btn_register_Click" />
                </td>
            </tr>

        </table>

    </form>

</body>
</html>
