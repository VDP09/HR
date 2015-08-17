<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PermBreakWaiver.aspx.vb" Inherits="Web_CJEmployeeInfo.PermBreakWaiver" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PermBreakWaiver</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <style>
        .mask
        {
            BEHAVIOR: url("mask_vbs.htc");
        }
    </style>
    <script language="javascript">
        function ValidateSubmit() {
            if (ValidateData())
                if (ValidateSig())
                    if (confirm('Submit Form ?')) {
                        if (frmPB.SigPlus1.NumberOftabletPoints > 0) {
                            frmPB.SigPlus1.tabletState = 0; //Turns tablet off
                            frmPB.SigPlus1.AutoKeyStart();
                            frmPB.SigPlus1.AutoKeyData = "Rupesh Patel";
                            frmPB.SigPlus1.AutoKeyFinish();
                            frmPB.SigPlus1.EncryptionMode = 2;
                            frmPB.SigPlus1.SigCompressionMode = 1;
                            frmPB.txtSig1.value = frmPB.SigPlus1.SigString;
                        }

                        if (frmPB.SigPlus2.NumberOftabletPoints > 0) {
                            frmPB.SigPlus2.tabletState = 0; //Turns tablet off
                            frmPB.SigPlus2.AutoKeyStart();
                            frmPB.SigPlus2.AutoKeyData = "Rupesh Patel";
                            frmPB.SigPlus2.AutoKeyFinish();
                            frmPB.SigPlus2.EncryptionMode = 2;
                            frmPB.SigPlus2.SigCompressionMode = 1;
                            frmPB.txtSig2.value = frmPB.SigPlus2.SigString;
                        }
                        return true;
                    }
                    else
                        return false;

            return false;
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
            var txtManname;
            var strAlert;

            txtManname = document.getElementById("txtManname");

            if ((frmPB.SigPlus1.NumberOftabletPoints <= 0) ||
                (frmPB.SigPlus2.NumberOftabletPoints <= 0) ||
                    isBlank(txtManname.value)) {
                strAlert = 'Following are required .. Please check it out'
                    + '\n' + '\n' + 'Employee Signature'
                    + '\n' + 'Manager Signature'
                    + '\n' + 'Manager name';

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
            frmPB.SigPlus1.Cleartablet(); //Clears the signature, in case of error or mistake
            OnSign1();
        }

        function OnSign1() {
            if (frmPB.txtSig1.value != '') {
                frmPB.SigPlus1.JustifyX = 10;
                frmPB.SigPlus1.JustifyY = 10;
                frmPB.SigPlus1.AutoKeyStart();
                frmPB.SigPlus1.AutoKeyData = "Rupesh Patel";
                frmPB.SigPlus1.AutoKeyFinish();
                frmPB.SigPlus1.EncryptionMode = 2;
                frmPB.SigPlus1.SigCompressionMode = 1;
                frmPB.SigPlus1.DisplayPenWidth = 8;
                frmPB.SigPlus1.JustifyMode = 0;
                frmPB.SigPlus1.SigString = frmPB.txtSig1.value;

                frmPB.SigPlus2.JustifyX = 10;
                frmPB.SigPlus2.JustifyY = 10;
                frmPB.SigPlus2.AutoKeyStart();
                frmPB.SigPlus2.AutoKeyData = "Rupesh Patel";
                frmPB.SigPlus2.AutoKeyFinish();
                frmPB.SigPlus2.EncryptionMode = 2;
                frmPB.SigPlus2.SigCompressionMode = 1;
                frmPB.SigPlus2.DisplayPenWidth = 8;
                frmPB.SigPlus2.JustifyMode = 0;
                frmPB.SigPlus2.SigString = frmPB.txtSig2.value;
            }

            else {
                frmPB.SigPlus2.tabletState = 0;
                frmPB.SigPlus1.tabletState = 1; //Turns tablet on
            }
        }

        function OnClear2() {
            frmPB.SigPlus2.Cleartablet(); //Clears the signature, in case of error or mistake
            OnSign2();
        }

        function OnSign2() {
            frmPB.SigPlus1.tabletState = 0;
            frmPB.SigPlus2.tabletState = 1; //Turns tablet on
        }

        function PrintWin() {
            var WebBrowser = '<object ID="WebBrowser1" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></object>';

            document.body.insertAdjacentHTML('beforeEnd', WebBrowser);
            WebBrowser1.ExecWB(6, -1);
            WebBrowser1.outerhtml = "";
        }

    </script>
</head>
<body onload="OnSign1();">
    <form id="frmPB" method="post" runat="server">
        <div>

            <div style="text-align: center;">
                <asp:Image ID="Image1" runat="server" Height="80px" ImageUrl="~/Images/CJ.JPG" Width="614px"></asp:Image>
            </div>
            <div style="text-align: center;" id="tblTitle1" runat="server">
                <strong><u>AGREEMENT TO WAIVE MEAL PERIOD WITH SHIFTS UNDER SIX HOURS</u></strong>
                <br />
                <i style="mso-bidi-font-style: normal"><span lang="ES-trAD" style="font-size: 10pt; mso-ansi-language: ES-trAD">ACUERDO 
															DE RENUNCIAR PERÍODO DE LA COMIDA </span></i><i style="mso-bidi-font-style: normal">
                                                                <span lang="ES-trAD" style="font-FAMILY: 'Times New Roman'; font-size: 10pt; mso-ansi-language: ES-trAD; mso-fareast-font-family: 'Times New Roman'; mso-fareast-language: EN-US; mso-bidi-language: AR-SA">DURANTE TURNO DE MENOS DE SEIS HORAS</span></i>

            </div>
            <div style="text-align: center;" id="tblTitle2" runat="server">
                <strong><u>AGREEMENT TO WAIVE MEAL PERIOD WITH SHIFTS&nbsp;OVER 10 BUT UNDER 12 HOURS</u></strong>
                <br />
                <i style="mso-bidi-font-style: normal"><span lang="ES-trAD" style="font-FAMILY: 'Times New Roman'; font-size: 10pt; mso-ansi-language: ES-trAD; mso-fareast-font-family: 'Times New Roman'; mso-fareast-language: EN-US; mso-bidi-language: AR-SA">
                    <i style="mso-bidi-font-style: normal"><span style="font-size: 10pt">ACUERDO DE RENUNCIAR PERÍODO DE LA COMIDA </span></i><i style="mso-bidi-font-style: normal">
                        <span style="font-FAMILY: 'Times New Roman'; font-size: 10pt; mso-ansi-language: EN-US; mso-fareast-font-family: 'Times New Roman'; mso-fareast-language: EN-US; mso-bidi-language: AR-SA">DURANTE TURNO DE MAS DE DIEZ, PER MENOS DE DOCE HORAS</span></i>
                </span></i>
            </div>
            <div id="tblBody1" runat="server">
                <div id="lblBody1" style="WIDTH: 626px; DISPLAY: inline; HEIGHT: 19px" runat="server">
                    &nbsp;
                </div>
            </div>
            <div id="tblBody2" runat="server">
                <div id="lblBody2" style="WIDTH: 626px; DISPLAY: inline; HEIGHT: 19px" runat="server">
                    &nbsp;
                </div>
            </div>
            <div style="width: 626px; display: inline; height: 19px; text-align: center;">
                <p>
                    <span style="font-FAMILY: 'Times New Roman'; font-size: 10pt; mso-ansi-language: EN-US; mso-fareast-font-family: 'Times New Roman'; mso-fareast-language: EN-US; mso-bidi-language: AR-SA">I 
					understand and agree that I may cancel this Agreement at any time by speaking 
					with my manager, electronically signing this form, with the 
					checked&nbsp;“Revoke” box.<span style="mso-spacerun: yes">&nbsp; </span>I also 
					understand and agree that Claim Jumper Restaurants may cancel this Agreement 
					based on business needs including, but not limited to a change in my duties, 
					the operations of my department, or a change in my schedule that would allow me 
					to have an unpaid meal period.</span>
                </p>
            </div>
            <div style="height: 5px;">
            </div>
            <div style="text-align: center;">
                <span style="font-FAMILY: 'Times New Roman'; font-size: 10pt; mso-ansi-language: EN-US; mso-fareast-font-family: 'Times New Roman'; mso-fareast-language: EN-US; mso-bidi-language: AR-SA">I 
			        have read and understand the above, and I freely and voluntarily request to 
			        enter into this Agreement.</span>
            </div>
            <div style="text-align: center; height: 12px;">
                *******************************************************************************
            </div>
            <div id="tblBody3" runat="server">
                <div id="lblBody3" style="WIDTH: 626px; DISPLAY: inline; HEIGHT: 18px" runat="server">
                    &nbsp;
                </div>
            </div>
            <div id="tblBody4" runat="server">
                <div id="lblBody4" style="WIDTH: 626px; DISPLAY: inline; HEIGHT: 18px" runat="server">
                    &nbsp;
                </div>
            </div>
            <div style="WIDTH: 626px; DISPLAY: inline; HEIGHT: 15px; text-align: center;">
                <span style="font-FAMILY: 'Times New Roman'; font-size: 10pt; mso-ansi-language: EN-US; mso-fareast-font-family: 'Times New Roman'; mso-fareast-language: EN-US; mso-bidi-language: AR-SA"><span lang="ES-trAD" style="font-FAMILY: 'Times New Roman'; font-size: 10pt; mso-ansi-language: ES-trAD; mso-fareast-font-family: 'Times New Roman'; mso-fareast-language: EN-US; mso-bidi-language: AR-SA">Yo 
				entiendo y convengo que yo puedo cancelar este<span style="mso-spacerun: yes">&nbsp;
                </span>acuerdo en cualquier momento hablando con mi supervisor, 
				electrónicamente firmando esta forma, y marcando la caja “Revoke.”<span style="mso-spacerun: yes">&nbsp;
                </span>También entiendo y convengo que Claim Jumper Restaurants puede cancelar 
				este Acuerdo basado en necesidades del negocio incluyendo, pero no limitado a 
				un cambio en mis deberes, las operaciones de mi departamento, o un cambio en mi 
				horario que me permitiría tomar un período de comida sin pago.</span></span>
            </div>
            <div style="height: 5px;">
            </div>
            <div style="text-align: center;">
                <span style="font-FAMILY: 'Times New Roman'; font-size: 10pt; mso-ansi-language: EN-US; mso-fareast-font-family: 'Times New Roman'; mso-fareast-language: EN-US; mso-bidi-language: AR-SA"><span lang="ES-trAD" style="font-FAMILY: 'Times New Roman'; font-size: 10pt; mso-ansi-language: ES-trAD; mso-fareast-font-family: 'Times New Roman'; mso-fareast-language: EN-US; mso-bidi-language: AR-SA">He 
				leído y entiendo el antedicho,<span style="mso-spacerun: yes">&nbsp; </span>libremente 
				y voluntariamente solicito entrar en este Acuerdo.</span></span>
            </div>

            <div style="text-align: center; height: 9px;">
                *******************************************************************************
            </div>
            <br />
            <div style="text-align: left; padding-left: 145px;">
                <div style="float:left;" id="tblRevoke" runat="server">
                    <font face="Wingdings" size="5">x</font>
                    <strong>Revoke Agreement</strong>
                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                </div>
                <div style="float:right;padding-right:290px;">
                    <strong>Date Effective :</strong>
                    <asp:TextBox ID="txtEffDate" runat="server" Height="20px" Width="104px" CssClass="mask" Preset="shortdate"
                        Font-Names="Arial" Font-Size="X-Small" BackColor="PapayaWhip" BorderWidth="1px" BorderStyle="Solid"></asp:TextBox>
                </div>
            </div>
            <br />
            <br />
            <div style="margin-left: 145px;">
                <strong>Employee Signature</strong>
                &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                <asp:Button ID="cmdSign1" runat="server" Text="Sign" OnClientClick="javascript:Onsign1();" />
                <asp:Button ID="cmdClear1" runat="server" Text="Clear" OnClientClick="javascript:OnClear1();" />
                &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
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
                &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                <object style="WIDTH: 300px; HEIGHT: 100px; TOP: 0px; LEFT: 0px" id="SigPlus2" name="SigPlus2"
                    classid="clsid:69A40DA3-4D42-11D0-86B0-0000C025864A" height="60">
                    <param name="_Version" value="131095">
                    <param name="_ExtentX" value="7937">
                    <param name="_ExtentY" value="2645">
                    <param name="_StockProps" value="0">
                </object>
                <br />
                <div style="float: right; padding-right: 115px;">
                    <strong>Manager Name </strong>
                    <asp:TextBox ID="txtManname" runat="server" Height="20px" Width="211px" Font-Names="Arial" Font-Size="X-Small"
                        BackColor="PapayaWhip" BorderWidth="1px" BorderStyle="Solid"></asp:TextBox>
                </div>

            </div>

            <br />

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
                <asp:TextBox ID="txtBreakType" runat="server" Style="display: none;"></asp:TextBox>
                <asp:TextBox ID="txtStatus" runat="server" Style="display: none;"></asp:TextBox>
                <asp:TextBox ID="txtSig1" runat="server" Style="display: none;"></asp:TextBox>
                <asp:TextBox ID="txtSig2" runat="server" Style="display: none;"></asp:TextBox>
                <asp:TextBox ID="txtPBWId" runat="server" Style="display: none;"></asp:TextBox>

            </div>

        </div>
    </form>
</body>
</html>
