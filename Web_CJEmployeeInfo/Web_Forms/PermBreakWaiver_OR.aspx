<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PermBreakWaiver_OR.aspx.vb" Inherits="Web_CJEmployeeInfo.PermBreakWaiver_OR" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PermBreakWaiver_OR</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <script language="javascript">
        function ValidateSubmit() {
            if (ValidateData())
                //if (ValidateSig())
                //    if (confirm('Submit Form ?')) {
                //        if (frmPB.SigPlus1.NumberOfTabletPoints > 0) {
                //            frmPB.SigPlus1.TabletState = 0; //Turns tablet off
                //            frmPB.SigPlus1.AutoKeyStart();
                //            frmPB.SigPlus1.AutoKeyData = "Rupesh Patel";
                //            frmPB.SigPlus1.AutoKeyFinish();
                //            frmPB.SigPlus1.EncryptionMode = 2;
                //            frmPB.SigPlus1.SigCompressionMode = 1;
                //            frmPB.txtSig1.value = frmPB.SigPlus1.SigString;
                //        }

                //        if (frmPB.SigPlus2.NumberOfTabletPoints > 0) {
                //            frmPB.SigPlus2.TabletState = 0; //Turns tablet off
                //            frmPB.SigPlus2.AutoKeyStart();
                //            frmPB.SigPlus2.AutoKeyData = "Rupesh Patel";
                //            frmPB.SigPlus2.AutoKeyFinish();
                //            frmPB.SigPlus2.EncryptionMode = 2;
                //            frmPB.SigPlus2.SigCompressionMode = 1;
                //            frmPB.txtSig2.value = frmPB.SigPlus2.SigString;
                //        }
                //        return true;
                //    }
                //    else
                //        return false;

            return true;
        }

        function ValidateData() {
            var txtEffDate;
            txtEffDate = document.getElementById("txtEffDate");

            if (isBlank(txtEffDate.value)) {
                alert('Following are required fields .. Please check it out' +
                    '\n' + '\n' + 'Date Effective');

                return false;
            }

            if (!CheckDateEff())
                return false;
            else
                return true;
        }

        function CheckDateEff() {
            var txtEffDate;
            var dd;
            txtEffDate = document.getElementById("txtEffDate");

            d1 = new Date(txtEffDate.value);
            d2 = new Date('1/3/2007');
            dd = new Date();

            found = 0;

            while (d2 <= d1) {
                if (d1.toDateString() == d2.toDateString()) {
                    found = 1;
                    break;
                }

                d2.setDate(d2.getDate() + 14);
            }

            if ((found == 0) || (d1 < dd)) {
                var d3;
                var d4;

                d3 = new Date();
                d4 = new Date();
                d1 = new Date(txtEffDate.value);
                d2 = new Date('1/3/2007');

                d3.setDate(d3.getDate() - 60);
                d4.setDate(d4.getDate() + 60);

                strAlert = '';

                while (d2 <= d4) {
                    if ((d2 >= d3) && (d2 >= dd))
                        strAlert = strAlert + '\n' + (d2.getMonth() + 1) + '/' + d2.getDate() + '/' + d2.getYear();

                    d2.setDate(d2.getDate() + 14);
                }

                alert('Effective Date must be 1st date of next scheduled payroll period .. Please select from following.' + '\n' + strAlert);
                return false;
            }
            else
                return true;
        }

        function ValidateSig() {
            var txtManName;
            var strAlert;

            txtManName = document.getElementById("txtManName");

            if ((frmPB.SigPlus1.NumberOfTabletPoints <= 0) ||
                (frmPB.SigPlus2.NumberOfTabletPoints <= 0) ||
                    isBlank(txtManName.value)) {
                strAlert = 'Following are required .. Please check it out'
                    + '\n' + '\n' + 'Employee Signature'
                    + '\n' + 'Manager Signature'
                    + '\n' + 'Manager Name';

                alert(strAlert);
                return false;
            }

            return true;
        }

        function isBlank(s) {
            if ((s == null) || (s.length == 0) || s == "")
                return true;

            for (var i = 0; i < s.length; i++) {
                var c = s.charAt(i);
                if ((c != ' ') && (c != '\n') && (c != '\t')) return false;
            }
            return true;
        }

        function OnClear1() {
            frmPB.SigPlus1.ClearTablet(); //Clears the signature, in case of error or mistake
            OnSign1();
        }

        function OnSign1() {
            frmPB.SigPlus2.TabletState = 0;
            frmPB.SigPlus1.TabletState = 1; //Turns tablet on
        }

        function OnClear2() {
            frmPB.SigPlus2.ClearTablet(); //Clears the signature, in case of error or mistake
            OnSign2();
        }

        function OnSign2() {
            frmPB.SigPlus1.TabletState = 0;
            frmPB.SigPlus2.TabletState = 1; //Turns tablet on
        }

        function PrintWin() {
            var WebBrowser = '<OBJECT ID="WebBrowser1" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>';

            document.body.insertAdjacentHTML('beforeEnd', WebBrowser);
            WebBrowser1.ExecWB(6, -1);
            WebBrowser1.outerHTML = "";
        }

    </script>
</head>
<body>  <%-- onload="OnSign1();"--%>
    <form id="frmPB" method="post" runat="server">
        <div style="padding-left: 100px; padding-right: 50px;">

            <div style="text-align: center;">
                <asp:Image ID="Image1" runat="server" Height="80px" ImageUrl="~/Images/CJ.JPG" Width="614px"></asp:Image>
            </div>
            <hr width="100%" size="1">
            <div style="text-align: center;">
                <strong><u>REQUEST AND AGREEMENT TO WAIVE MEAL PERIODS (OR Only)</u></strong>
            </div>
            <div>
                I understand that pursuant to Oregon law I am 
				entitled to receive an unpaid meal period of not less than 30 minutes during 
				which I am relieved of all duties for each work period of not less than six 
				hours or more than eight hours.
            </div>

            <div style="height: 12px;">
            </div>

            <div>
                In addition, I understand that I am entitled 
				to receive a paid rest period of not less than ten minutes for every segment of 
				four hours or major part thereof worked in one work period.
            </div>

            <div style="height: 12px;">
            </div>

            <div>
                I am at least 18 years of age and am employed as a meal and/or beverage server.
            </div>

            <div style="height: 12px;">
            </div>

            <div>
                I request to waive meal periods to which i am entitled under the law.
            </div>

            <div style="height: 12px;">
            </div>

            <div>
                I make this request voluntarily and have not been required or coerced by any person to waive the meal periods to which I am entitled.
            </div>

            <div style="height: 12px;">
            </div>

            <div>
                I understand that either my employer or I may revoke this request by providing at least seven (7) calendar days written notice to the other.
            </div>

            <div style="height: 12px;">
            </div>

            <div>
                I understand that by waiving my meal periood, I will not be relieved of all duties, however, I also understand that I must be provided a reasonable opportunity to consume food during any workshift of six hours or longer while continuing to work and that I must be paid for this time.
            </div>

            <div style="height: 12px;">
            </div>

            <div>
                I understand that I may not be required to work longer than eight hours without receiving a 30-minute unpaid meal period in which I am completely relieved of all duties.
            </div>

            <div style="height: 12px;">
            </div>

            <div>
                I understand that I may not waive the ten-minute rest periods to which I am entitled by law.
            </div>

            <div style="height: 12px;">
            </div>
            <div style="height: 12px;">
            </div>

            <div style="text-align: center;">
                *******************************************************************************
            </div>

            <div>
                <div style="float: left; padding-left: 45px;" id="tblRevoke" runat="server">
                    <font face="Wingdings" size="5">x</font>
                    <strong>Revoke Agreement</strong>
                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                </div>
                <div style="float: right; padding-right: 190px;">
                    <strong>Date Effective :</strong>
                    <asp:TextBox ID="txtEffDate" runat="server" Height="20px" Width="104px" CssClass="mask" Preset="shortdate"
                        Font-Names="Arial" Font-Size="X-Small" BackColor="PapayaWhip" BorderWidth="1px" BorderStyle="Solid"></asp:TextBox>
                </div>
            </div>

            <br />
            <br />

            <div style="margin-left: 60px;">
                <strong>Employee Signature</strong>
                &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                <asp:Button ID="cmdSign1" runat="server" Text="Sign" OnClientClick="javascript:Onsign1();" />
                <asp:Button ID="cmdClear1" runat="server" Text="Clear" OnClientClick="javascript:OnClear1();" />
                &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                <strong>Manager Signature</strong>
                &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                <asp:Button ID="cmdSign2" runat="server" Text="Sign" OnClientClick="javascript:Onsign2();" />
                <asp:Button ID="cmdClear2" runat="server" Text="Clear" OnClientClick="javascript:OnClear2();" />

                <br />
                <object style="WIDTH: 300px; HEIGHT: 100px; TOP: 0px; LEFT: 0px" id="SigPlus1" name="SigPlus1"
                    classid="clsid:69A40DA3-4D42-11D0-86B0-0000C025864A" height="60">
                    <param name="_Version" value="131095">
                    <param name="_ExtentX" value="7937">
                    <param name="_ExtentY" value="2645">
                    <param name="_StockProps" value="0">
                </object>
                &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                <object style="WIDTH: 300px; HEIGHT: 100px; TOP: 0px; LEFT: 0px" id="SigPlus2" name="SigPlus2"
                    classid="clsid:69A40DA3-4D42-11D0-86B0-0000C025864A" height="60">
                    <param name="_Version" value="131095">
                    <param name="_ExtentX" value="7937">
                    <param name="_ExtentY" value="2645">
                    <param name="_StockProps" value="0">
                </object>
                <br />
                <strong>Employee Name </strong>
                <asp:TextBox ID="txtEmp" runat="server" Height="20px" Width="180px" Font-Names="Arial" Font-Size="X-Small"
                    BackColor="PapayaWhip" BorderWidth="1px" BorderStyle="Solid" Enabled="False"></asp:TextBox>
                &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                <strong>Manager Name </strong>
                <asp:TextBox ID="txtManname" runat="server" Height="20px" Width="184px" Font-Names="Arial" Font-Size="X-Small"
                    BackColor="PapayaWhip" BorderWidth="1px" BorderStyle="Solid"></asp:TextBox>
            </div>

            <div style="text-align: center;">
                <asp:Button ID="cmdSubmit" runat="server" Width="100px" Text="Submit" Font-Bold="true"></asp:Button>
                &nbsp&nbsp
               <asp:Button ID="cmdPrint" runat="server" Width="100px" Text="Print" Font-Bold="true" OnClientClick="javascript:PrintWin();"></asp:Button>
                &nbsp&nbsp
                <asp:Button ID="cmdExit" runat="server" Width="100px" Text="Exit" Font-Bold="true" OnClientClick="window.close();"></asp:Button>
            </div>

            <div>
                <asp:TextBox ID="txtClockId" runat="server" Style="display: none;"></asp:TextBox>
                <asp:TextBox ID="txtEmpname" runat="server" Style="display: none;"></asp:TextBox>
                <asp:TextBox ID="txtEmpSig" runat="server" Style="display: none;"></asp:TextBox>
                <asp:TextBox ID="txtStatus" runat="server" Style="display: none;"></asp:TextBox>
                <asp:TextBox ID="txtSig1" runat="server" Style="display: none;"></asp:TextBox>
                <asp:TextBox ID="txtSig2" runat="server" Style="display: none;"></asp:TextBox>
            </div>

        </div>
    </form>
</body>
</html>
