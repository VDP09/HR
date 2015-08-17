<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ChangeEFT.aspx.vb" Inherits="Web_CJEmployeeInfo.ChangeEFT" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Change Direct Deposit</title>
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

        function ValidateData() {
            var txtOAT1;
            var txtOAN1;
            var txtORN1;
            var txtOAmt1;

            var txtOAT2;
            var txtOAN2;
            var txtORN2;
            var txtOAmt2;

            var txtOAT3;
            var txtOAN3;
            var txtORN3;
            var txtOAmt3;

            var txtOAT4;
            var txtOAN4;
            var txtORN4;
            var txtOAmt4;

            var txtOAT5;
            var txtOAN5;
            var txtORN5;
            var txtOAmt5;

            var cmbAT1;
            var txtAN1;
            var txtRN1;
            var txtAmt1;

            var cmbAT2;
            var txtAN2;
            var txtRN2;
            var txtAmt2;

            var cmbAT3;
            var txtAN3;
            var txtRN3;
            var txtAmt3;

            var cmbAT4;
            var txtAN4;
            var txtRN4;
            var txtAmt4;

            var cmbAT5;
            var txtAN5;
            var txtRN5;
            var txtAmt5;

            var txtEffDate;
            var txtChangeReason;

            var d1;
            var intDay;

            txtOAT1 = document.getElementById("txtOAT1");
            txtOAN1 = document.getElementById("txtOAN1");
            txtORN1 = document.getElementById("txtORN1");
            txtOAmt1 = document.getElementById("txtOAmt1");

            txtOAT2 = document.getElementById("txtOAT2");
            txtOAN2 = document.getElementById("txtOAN2");
            txtORN2 = document.getElementById("txtORN2");
            txtOAmt2 = document.getElementById("txtOAmt2");

            txtOAT3 = document.getElementById("txtOAT3");
            txtOAN3 = document.getElementById("txtOAN3");
            txtORN3 = document.getElementById("txtORN3");
            txtOAmt3 = document.getElementById("txtOAmt3");

            txtOAT4 = document.getElementById("txtOAT4");
            txtOAN4 = document.getElementById("txtOAN4");
            txtORN4 = document.getElementById("txtORN4");
            txtOAmt4 = document.getElementById("txtOAmt4");

            txtOAT5 = document.getElementById("txtOAT5");
            txtOAN5 = document.getElementById("txtOAN5");
            txtORN5 = document.getElementById("txtORN5");
            txtOAmt5 = document.getElementById("txtOAmt5");

            cmbAT1 = document.getElementById("cmbAT1");
            txtAN1 = document.getElementById("txtAN1");
            txtRN1 = document.getElementById("txtRN1");
            txtAmt1 = document.getElementById("txtAmt1");

            cmbAT2 = document.getElementById("cmbAT2");
            txtAN2 = document.getElementById("txtAN2");
            txtRN2 = document.getElementById("txtRN2");
            txtAmt2 = document.getElementById("txtAmt2");

            cmbAT3 = document.getElementById("cmbAT3");
            txtAN3 = document.getElementById("txtAN3");
            txtRN3 = document.getElementById("txtRN3");
            txtAmt3 = document.getElementById("txtAmt3");

            cmbAT4 = document.getElementById("cmbAT4");
            txtAN4 = document.getElementById("txtAN4");
            txtRN4 = document.getElementById("txtRN4");
            txtAmt4 = document.getElementById("txtAmt4");

            cmbAT5 = document.getElementById("cmbAT5");
            txtAN5 = document.getElementById("txtAN5");
            txtRN5 = document.getElementById("txtRN5");
            txtAmt5 = document.getElementById("txtAmt5");

            txtEffDate = document.getElementById("txtEffDate");
            txtChangeReason = document.getElementById("txtChangeReason");

            if (TrimString(txtAN1.value) == '') {
                cmbAT1.selectedIndex = 0;
                txtRN1.value = '';
                txtAmt1.value = '';
            }

            if (TrimString(txtAN2.value) == '') {
                //cmbAT2.options(cmbAT2.selectedIndex).text = '';
                cmbAT2.selectedIndex = 0;
                txtRN2.value = '';
                txtAmt2.value = '';
            }

            if (TrimString(txtAN3.value) == '') {
                cmbAT3.selectedIndex = 0;
                txtRN3.value = '';
                txtAmt3.value = '';
            }

            if (TrimString(txtAN4.value) == '') {
                cmbAT4.selectedIndex = 0;
                txtRN4.value = '';
                txtAmt4.value = '';
            }

            if (TrimString(txtAN5.value) == '') {
                cmbAT5.selectedIndex = 0;
                txtRN5.value = '';
                txtAmt5.value = '';
            }

            if (cmbAT1.options(cmbAT1.selectedIndex).text == txtOAT1.value &&
                TrimString(txtAN1.value) == txtOAN1.value &&
                TrimString(txtRN1.value) == txtORN1.value &&
                (TrimString(txtAmt1.value) - 0) == txtOAmt1.value &&

                cmbAT2.options(cmbAT2.selectedIndex).text == txtOAT2.value &&
                TrimString(txtAN2.value) == txtOAN2.value &&
                TrimString(txtRN2.value) == txtORN2.value &&
                (TrimString(txtAmt2.value) - 0) == txtOAmt2.value &&

                cmbAT3.options(cmbAT3.selectedIndex).text == txtOAT3.value &&
                TrimString(txtAN3.value) == txtOAN3.value &&
                TrimString(txtRN3.value) == txtORN3.value &&
                (TrimString(txtAmt3.value) - 0) == txtOAmt3.value &&

                cmbAT4.options(cmbAT4.selectedIndex).text == txtOAT4.value &&
                TrimString(txtAN4.value) == txtOAN4.value &&
                TrimString(txtRN4.value) == txtORN4.value &&
                (TrimString(txtAmt4.value) - 0) == txtOAmt4.value &&

                cmbAT5.options(cmbAT5.selectedIndex).text == txtOAT5.value &&
                TrimString(txtAN5.value) == txtOAN5.value &&
                TrimString(txtRN5.value) == txtORN5.value &&
                (TrimString(txtAmt5.value) - 0) == txtOAmt5.value) {
                alert('Atleast one field must be changed .. Please check it out');
                return false;
            }

            if (TrimString(txtAN1.value) != '' &&
                (cmbAT1.options(cmbAT1.selectedIndex).text == '' ||
                TrimString(txtRN1.value) == '' ||
                TrimString(txtAmt1.value) == '')) {
                alert('All fields in Line 1 are required .. Please check it out');
                return false;
            }

            if (TrimString(txtAN2.value) != '' &&
                (cmbAT2.options(cmbAT2.selectedIndex).text == '' ||
                TrimString(txtRN2.value) == '' ||
                TrimString(txtAmt2.value) == '')) {
                alert('All fields in Line 2 are required .. Please check it out');
                return false;
            }

            if (TrimString(txtAN3.value) != '' &&
                (cmbAT3.options(cmbAT3.selectedIndex).text == '' ||
                TrimString(txtRN3.value) == '' ||
                TrimString(txtAmt3.value) == '')) {
                alert('All fields in Line 3 are required .. Please check it out');
                return false;
            }

            if (TrimString(txtAN4.value) != '' &&
                (cmbAT4.options(cmbAT4.selectedIndex).text == '' ||
                TrimString(txtRN4.value) == '' ||
                TrimString(txtAmt4.value) == '')) {
                alert('All fields in Line 4 are required .. Please check it out');
                return false;
            }

            if (TrimString(txtAN5.value) != '' &&
                (cmbAT5.options(cmbAT5.selectedIndex).text == '' ||
                TrimString(txtRN5.value) == '' ||
                TrimString(txtAmt5.value) == '')) {
                alert('All fields in Line 5 are required .. Please check it out');
                return false;
            }

            if ((txtAN5.value != '' && txtAN4.value == '') ||
                (txtAN4.value != '' && txtAN3.value == '') ||
                (txtAN3.value != '' && txtAN2.value == '') ||
                (txtAN2.value != '' && txtAN1.value == '')) {
                alert('Accounts must be entered in sequence .. Please check it out');
                return false;
            }

            //Validate required fields
            if (isBlank(txtEffDate.value) || isBlank(txtChangeReason.value) ||
                (frmEFT.SigPlus.NumberOfTabletPoints <= 0)) {
                alert('Following are required fields .. Please check it out' +
                    '\n' + '\n' + 'Effective Date' + '\n' + 'Change Reason' +
                    '\n' + 'Employee Signature');

                return false;
            }

            if (!CheckDateEff(txtEffDate.value)) {
                alert('Invalid Date Effective .. Please check it out');
                return false;
            }

            //Check for 1st or 16 day of effective date			
            /*
            d1 = new Date(txtEffDate.value);
            intDay = d1.getDate();
            if(intDay != 1 && intDay != 16)
            {
                alert('Direct Deposit Change Effective Date must be 1st or 16th of the month .. Please check it out');
                return false;
            }
            */

            //Check for first date of biweekly payroll schedule
            var d1;
            var d2;
            var found;
            var strAlert;
            d1 = new Date(txtEffDate.value);
            d2 = new Date('1/3/2007');

            found = 0;

            while (d2 <= d1) {
                if (d1.toDateString() == d2.toDateString()) {
                    found = 1;
                    break;
                }

                //d2 = new Date(d2.getTime() + 14*24*60*60*1000);
                d2.setDate(d2.getDate() + 14);
            }

            if (found == 0) {
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
                    if (d2 >= d3)
                        strAlert = strAlert + '\n' + (d2.getMonth() + 1) + '/' + d2.getDate() + '/' + d2.getYear();

                    d2.setDate(d2.getDate() + 14);
                }

                alert('Effective Date must be 1st date of a scheduled payroll period .. Please select from following.' + '\n' + strAlert);
                return false;
            }


            return true;
        }

        function CheckDateEff(dd) {
            var d1;
            //var d2;
            var DateEff;

            DateEff = new Date(dd);
            d1 = new Date();
            //d2 = new Date();

            d1.setMonth(d1.getMonth() + 2);
            //d2.setMonth(d2.getMonth() - 2);

            if (DateEff > d1)	// || DateEff < d2)
                return false;
            else
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

        function TrimString(sInString) {
            sInString = sInString.replace(/^\s+/g, "");// strip leading
            return sInString.replace(/\s+$/g, "");// strip trailing
        }

        function ValidateSubmit() {
            if (ValidateData()) {
                if (confirm('Submit Request ?' + '\n' + '\n' + 'Date Effective : ' + document.getElementById("txtEffDate").value)) {
                    if (frmEFT.SigPlus.NumberOfTabletPoints > 0) {
                        frmEFT.SigPlus.TabletState = 0; //Turns tablet off
                        frmEFT.SigPlus.AutoKeyStart();

                        frmEFT.SigPlus.AutoKeyData = "Rupesh Patel";
                        frmEFT.SigPlus.AutoKeyFinish();
                        frmEFT.SigPlus.EncryptionMode = 2;
                        frmEFT.SigPlus.SigCompressionMode = 1;

                        frmEFT.txtEmpSig.value = frmEFT.SigPlus.SigString;
                    }

                    return true;
                }
                else
                    return false;
            }

            return false;
        }

        function ValidatePost() {
            if (ValidateData())
                if (confirm('Post Request ?'))
                    return true;
                else
                    return false;

            return false;
        }

        function ValidateDelete() {
            if (confirm('Delete Request ?'))
                return true;
            else
                return false;
        }

        function ValidateEmailReq() {
            var txtUndoNotes;

            txtUndoNotes = document.getElementById("txtUndoNotes");

            if (isBlank(txtUndoNotes.value)) {
                alert('Please write something in Email Notes');
                return false;
            }
            else {
                if (confirm('Send Email to Requester ?'))
                    return true;
                else
                    return false;
            }
        }

        function OnClear() {
            frmEFT.SigPlus.ClearTablet(); //Clears the signature, in case of error or mistake
        }

        function OnSign() {
            frmEFT.SigPlus.TabletState = 1; //Turns tablet on
        }

        function LoadSig() {
            if (frmEFT.txtEmpSig.value != '') {
                frmEFT.SigPlus.JustifyX = 10;
                frmEFT.SigPlus.JustifyY = 10;
                frmEFT.SigPlus.AutoKeyStart();
                frmEFT.SigPlus.AutoKeyData = "Rupesh Patel";
                frmEFT.SigPlus.AutoKeyFinish();
                frmEFT.SigPlus.EncryptionMode = 2;
                frmEFT.SigPlus.SigCompressionMode = 1;
                frmEFT.SigPlus.DisplayPenWidth = 8;
                frmEFT.SigPlus.JustifyMode = 0;
                frmEFT.SigPlus.SigString = frmEFT.txtEmpSig.value;
            }

            if (frmEFT.txtId.value != 0) {
                frmEFT.cmdSign.disabled = true;
                frmEFT.cmdClear.disabled = true;
            }
        }

    </script>
</head>
<body bgcolor="#ccd0fa" onload="LoadSig();">
    <form id="frmEFT" method="post" runat="server">
        <table id="Table1" style="Z-INDEX: 101; LEFT: 8px; POSITION: absolute; TOP: 8px" cellspacing="0"
            cellpadding="0" width="650" border="0">
            <tr>
                <td style="HEIGHT: 1px" align="center"><font face="Monotype Corsiva" color="#006699" size="5"><STRONG>Change&nbsp;Direct 
								Deposit&nbsp;Information</STRONG></font></td>
            </tr>
            <tr>
                <td>
                    <hr width="100%" color="#006699" size="2">
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:Label ID="lblEmp" runat="server" Font-Bold="True" Font-Size="X-Small" Font-Names="Microsoft Sans Serif"
                        Width="605px"></asp:Label></td>
            </tr>
            <tr>
                <td>
                    <hr width="100%" color="#006699" size="2">
                </td>
            </tr>
            <tr>
                <td style="HEIGHT: 28px"><font face="MS Sans Serif" color="#006699" size="2"><STRONG>Employee's 
								Existing Information :</STRONG></font></td>
            </tr>
            <tr>
                <td>
                    <table id="Table3" bordercolor="#006699" cellspacing="0" cellpadding="0" width="100%" border="1">
                        <tr>
                            <td style="WIDTH: 58px; HEIGHT: 18px" align="center" colspan="1" rowspan="1"><font face="MS Sans Serif" size="1"><STRONG>Priority</STRONG></font></td>
                            <td style="WIDTH: 121px; HEIGHT: 18px" align="center" colspan="1" rowspan="1"><font face="MS Sans Serif" size="1"><STRONG>Account 
											Type</STRONG></font></td>
                            <td style="WIDTH: 150px; HEIGHT: 18px" align="center" colspan="1" rowspan="1"><font face="MS Sans Serif" size="1"><STRONG>Account 
											#</STRONG></font></td>
                            <td style="WIDTH: 145px; HEIGHT: 18px" align="center" colspan="1" rowspan="1"><font face="MS Sans Serif" size="1"><STRONG>Routing 
											#</STRONG></font></td>
                            <td style="WIDTH: 110px; HEIGHT: 18px" align="center" colspan="1" rowspan="1"><font face="MS Sans Serif" size="1"><STRONG>Amount 
											($)</STRONG></font></td>
                        </tr>
                        <tr>
                            <td style="WIDTH: 58px; HEIGHT: 18px" align="center"><font face="MS Sans Serif" size="1"><STRONG>1</STRONG></font></td>
                            <td style="WIDTH: 121px; HEIGHT: 18px" align="center">
                                <asp:TextBox ID="txtOAT1" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="98px"
                                    Height="20px" BackColor="WhiteSmoke" Enabled="False" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
                            <td style="WIDTH: 150px; HEIGHT: 18px" align="center">
                                <asp:TextBox ID="txtOAN1" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="139px"
                                    Height="20px" BackColor="WhiteSmoke" Enabled="False" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
                            <td style="WIDTH: 145px; HEIGHT: 18px" align="center">
                                <asp:TextBox ID="txtORN1" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="139px"
                                    Height="20px" BackColor="WhiteSmoke" Enabled="False" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
                            <td style="WIDTH: 110px; HEIGHT: 18px" align="center">
                                <asp:TextBox ID="txtOAmt1" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="86px"
                                    Height="20px" BackColor="WhiteSmoke" Enabled="False" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="WIDTH: 58px; HEIGHT: 18px" align="center"><font face="MS Sans Serif" size="1"><STRONG>2</STRONG></font></td>
                            <td style="WIDTH: 121px; HEIGHT: 18px" align="center">
                                <asp:TextBox ID="txtOAT2" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="98px"
                                    Height="20px" BackColor="WhiteSmoke" Enabled="False" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
                            <td style="WIDTH: 150px; HEIGHT: 18px" align="center">
                                <asp:TextBox ID="txtOAN2" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="139px"
                                    Height="20px" BackColor="WhiteSmoke" Enabled="False" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
                            <td style="WIDTH: 145px; HEIGHT: 18px" align="center">
                                <asp:TextBox ID="txtORN2" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="139px"
                                    Height="20px" BackColor="WhiteSmoke" Enabled="False" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
                            <td style="WIDTH: 110px; HEIGHT: 18px" align="center">
                                <asp:TextBox ID="txtOAmt2" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="86px"
                                    Height="20px" BackColor="WhiteSmoke" Enabled="False" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="WIDTH: 58px; HEIGHT: 18px" align="center"><font face="MS Sans Serif" size="1"><STRONG>3</STRONG></font></td>
                            <td style="WIDTH: 121px; HEIGHT: 18px" align="center">
                                <asp:TextBox ID="txtOAT3" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="98px"
                                    Height="20px" BackColor="WhiteSmoke" Enabled="False" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
                            <td style="WIDTH: 150px; HEIGHT: 18px" align="center">
                                <asp:TextBox ID="txtOAN3" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="139px"
                                    Height="20px" BackColor="WhiteSmoke" Enabled="False" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
                            <td style="WIDTH: 145px; HEIGHT: 18px" align="center">
                                <asp:TextBox ID="txtORN3" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="139px"
                                    Height="20px" BackColor="WhiteSmoke" Enabled="False" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
                            <td style="WIDTH: 110px; HEIGHT: 18px" align="center">
                                <asp:TextBox ID="txtOAmt3" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="86px"
                                    Height="20px" BackColor="WhiteSmoke" Enabled="False" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="WIDTH: 58px; HEIGHT: 18px" align="center"><font face="MS Sans Serif" size="1"><STRONG>4</STRONG></font></td>
                            <td style="WIDTH: 121px; HEIGHT: 18px" align="center">
                                <asp:TextBox ID="txtOAT4" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="98px"
                                    Height="20px" BackColor="WhiteSmoke" Enabled="False" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
                            <td style="WIDTH: 150px; HEIGHT: 18px" align="center">
                                <asp:TextBox ID="txtOAN4" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="139px"
                                    Height="20px" BackColor="WhiteSmoke" Enabled="False" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
                            <td style="WIDTH: 145px; HEIGHT: 18px" align="center">
                                <asp:TextBox ID="txtORN4" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="139px"
                                    Height="20px" BackColor="WhiteSmoke" Enabled="False" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
                            <td style="WIDTH: 110px; HEIGHT: 18px" align="center">
                                <asp:TextBox ID="txtOAmt4" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="86px"
                                    Height="20px" BackColor="WhiteSmoke" Enabled="False" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="WIDTH: 58px; HEIGHT: 18px" align="center"><font face="MS Sans Serif" size="1"><STRONG>5</STRONG></font></td>
                            <td style="WIDTH: 121px; HEIGHT: 18px" align="center">
                                <asp:TextBox ID="txtOAT5" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="98px"
                                    Height="20px" BackColor="WhiteSmoke" Enabled="False" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
                            <td style="WIDTH: 150px; HEIGHT: 18px" align="center">
                                <asp:TextBox ID="txtOAN5" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="139px"
                                    Height="20px" BackColor="WhiteSmoke" Enabled="False" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
                            <td style="WIDTH: 145px; HEIGHT: 18px" align="center">
                                <asp:TextBox ID="txtORN5" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="139px"
                                    Height="20px" BackColor="WhiteSmoke" Enabled="False" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
                            <td style="WIDTH: 110px; HEIGHT: 18px" align="center">
                                <asp:TextBox ID="txtOAmt5" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="86px"
                                    Height="20px" BackColor="WhiteSmoke" Enabled="False" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <hr width="100%" color="#006699" size="2">
                </td>
            </tr>
            <tr>
                <td style="HEIGHT: 27px"><font face="MS Sans Serif" color="#006699" size="2"><STRONG>Employee's 
								New Information : <FONT color="#000000" size="1">(Enter 0 in Amount field to 
									indicate whole/rest of the amount)</FONT></STRONG></font></td>
            </tr>
            <tr>
                <td align="center">
                    <table id="Table2" bordercolor="#006699" cellspacing="0" cellpadding="0" width="100%" border="1">
                        <tr>
                            <td style="WIDTH: 58px; HEIGHT: 18px" align="center" colspan="1" rowspan="1"><font face="MS Sans Serif" size="1"><STRONG>Priority</STRONG></font></td>
                            <td style="WIDTH: 121px; HEIGHT: 18px" align="center" colspan="1" rowspan="1"><font face="MS Sans Serif" size="1"><STRONG>Account 
											Type</STRONG></font></td>
                            <td style="WIDTH: 150px; HEIGHT: 18px" align="center" colspan="1" rowspan="1"><font face="MS Sans Serif" size="1"><STRONG>Account 
											#</STRONG></font></td>
                            <td style="WIDTH: 145px; HEIGHT: 18px" align="center" colspan="1" rowspan="1"><font face="MS Sans Serif" size="1"><STRONG>Routing 
											#</STRONG></font></td>
                            <td style="WIDTH: 110px; HEIGHT: 18px" align="center" colspan="1" rowspan="1"><font face="MS Sans Serif" size="1"><STRONG>Amount 
											($)</STRONG></font></td>
                        </tr>
                        <tr>
                            <td style="WIDTH: 58px; HEIGHT: 18px" align="center"><font face="MS Sans Serif" size="1"><STRONG>1</STRONG></font></td>
                            <td style="WIDTH: 121px; HEIGHT: 18px" align="center">
                                <asp:DropDownList ID="cmbAT1" runat="server" Width="106px"></asp:DropDownList></td>
                            <td style="WIDTH: 150px; HEIGHT: 18px" align="center">
                                <asp:TextBox ID="txtAN1" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="139px"
                                    Height="20px" BackColor="White" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
                            <td style="WIDTH: 145px; HEIGHT: 18px" align="center">
                                <asp:TextBox ID="txtRN1" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="139px"
                                    Height="20px" BackColor="White" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
                            <td style="WIDTH: 110px; HEIGHT: 18px" align="center">
                                <asp:TextBox ID="txtAmt1" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="86px"
                                    Height="20px" BackColor="White" BorderStyle="Solid" BorderWidth="1px" CssClass="mask" Preset="currency"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="WIDTH: 58px; HEIGHT: 18px" align="center"><font face="MS Sans Serif" size="1"><STRONG>2</STRONG></font></td>
                            <td style="WIDTH: 121px; HEIGHT: 18px" align="center">
                                <asp:DropDownList ID="cmbAT2" runat="server" Width="106px"></asp:DropDownList></td>
                            <td style="WIDTH: 150px; HEIGHT: 18px" align="center">
                                <asp:TextBox ID="txtAN2" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="139px"
                                    Height="20px" BackColor="White" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
                            <td style="WIDTH: 145px; HEIGHT: 18px" align="center">
                                <asp:TextBox ID="txtRN2" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="139px"
                                    Height="20px" BackColor="White" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
                            <td style="WIDTH: 110px; HEIGHT: 18px" align="center">
                                <asp:TextBox ID="txtAmt2" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="86px"
                                    Height="20px" BackColor="White" BorderStyle="Solid" BorderWidth="1px" CssClass="mask" Preset="currency"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="WIDTH: 58px; HEIGHT: 18px" align="center"><font face="MS Sans Serif" size="1"><STRONG>3</STRONG></font></td>
                            <td style="WIDTH: 121px; HEIGHT: 18px" align="center">
                                <asp:DropDownList ID="cmbAT3" runat="server" Width="106px"></asp:DropDownList></td>
                            <td style="WIDTH: 150px; HEIGHT: 18px" align="center">
                                <asp:TextBox ID="txtAN3" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="139px"
                                    Height="20px" BackColor="White" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
                            <td style="WIDTH: 145px; HEIGHT: 18px" align="center">
                                <asp:TextBox ID="txtRN3" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="139px"
                                    Height="20px" BackColor="White" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
                            <td style="WIDTH: 110px; HEIGHT: 18px" align="center">
                                <asp:TextBox ID="txtAmt3" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="86px"
                                    Height="20px" BackColor="White" BorderStyle="Solid" BorderWidth="1px" CssClass="mask" Preset="currency"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="WIDTH: 58px; HEIGHT: 18px" align="center"><font face="MS Sans Serif" size="1"><STRONG>4</STRONG></font></td>
                            <td style="WIDTH: 121px; HEIGHT: 18px" align="center">
                                <asp:DropDownList ID="cmbAT4" runat="server" Width="106px"></asp:DropDownList></td>
                            <td style="WIDTH: 150px; HEIGHT: 18px" align="center">
                                <asp:TextBox ID="txtAN4" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="139px"
                                    Height="20px" BackColor="White" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
                            <td style="WIDTH: 145px; HEIGHT: 18px" align="center">
                                <asp:TextBox ID="txtRN4" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="139px"
                                    Height="20px" BackColor="White" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
                            <td style="WIDTH: 110px; HEIGHT: 18px" align="center">
                                <asp:TextBox ID="txtAmt4" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="86px"
                                    Height="20px" BackColor="White" BorderStyle="Solid" BorderWidth="1px" CssClass="mask" Preset="currency"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="WIDTH: 58px; HEIGHT: 18px" align="center"><font face="MS Sans Serif" size="1"><STRONG>5</STRONG></font></td>
                            <td style="WIDTH: 121px; HEIGHT: 18px" align="center">
                                <asp:DropDownList ID="cmbAT5" runat="server" Width="106px"></asp:DropDownList></td>
                            <td style="WIDTH: 150px; HEIGHT: 18px" align="center">
                                <asp:TextBox ID="txtAN5" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="139px"
                                    Height="20px" BackColor="White" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
                            <td style="WIDTH: 145px; HEIGHT: 18px" align="center">
                                <asp:TextBox ID="txtRN5" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="139px"
                                    Height="20px" BackColor="White" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
                            <td style="WIDTH: 110px; HEIGHT: 18px" align="center">
                                <asp:TextBox ID="txtAmt5" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="86px"
                                    Height="20px" BackColor="White" BorderStyle="Solid" BorderWidth="1px" CssClass="mask" Preset="currency"></asp:TextBox></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table id="Table4" cellspacing="0" cellpadding="0" width="100%" border="0">
                        <tr>
                            <td style="WIDTH: 125px; HEIGHT: 13px" valign="top">&nbsp;</td>
                            <td style="HEIGHT: 13px"><font color="#990066" size="2"><STRONG>
											<asp:Label id="lblVoidCheck" runat="server" Width="512px" Visible="False">>> If you are changing bank, Please send a copy of voided check to Main Office <<<</asp:Label></STRONG></font></td>
                        </tr>
                        <tr>
                            <td style="WIDTH: 125px; HEIGHT: 13px" valign="top"><font face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG>Effective 
																	Date</STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></font></td>
                            <td style="HEIGHT: 13px">
                                <asp:TextBox ID="txtEffDate" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="136px"
                                    Height="20px" BackColor="#FFFFC0" BorderStyle="Solid" BorderWidth="1px" CssClass="mask" Preset="shortdate"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="WIDTH: 125px; HEIGHT: 51px" valign="top"><font face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG>Reason 
																	For Change</STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></font></td>
                            <td style="HEIGHT: 51px">
                                <asp:TextBox ID="txtChangeReason" runat="server" Width="504px" Height="46px" BackColor="#FFFFC0"
                                    TextMode="MultiLine"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="WIDTH: 125px; HEIGHT: 5px" valign="top"><font face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG>Employee 
																	Signature</STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></font></td>
                            <td style="HEIGHT: 5px">
                                <table id="Table5" cellspacing="0" cellpadding="0" width="100%" border="0">
                                    <tr>
                                        <td style="WIDTH: 338px">
                                            <table id="Table6" bordercolor="#006699" cellspacing="0" cellpadding="0" border="1">
                                                <tr>
                                                    <td>
                                                        <object id="SigPlus" style="LEFT: 0px; WIDTH: 300px; TOP: 0px; HEIGHT: 100px; BACKGROUND-COLOR: papayawhip"
                                                            height="60" classid="clsid:69A40DA3-4D42-11D0-86B0-0000C025864A" name="SigPlus" viewastext>
                                                            <param name="_Version" value="131095">
                                                            <param name="_ExtentX" value="7938">
                                                            <param name="_ExtentY" value="2646">
                                                            <param name="_StockProps" value="0">
                                                        </object>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                            <table id="Table7" style="WIDTH: 202px; HEIGHT: 65px" cellspacing="0" cellpadding="0" width="202"
                                                border="0">
                                                <tr>
                                                    <td>
                                                        <input id="cmdSign" style="FONT-WEIGHT: bold; FONT-SIZE: xx-small; WIDTH: 56px; FONT-FAMILY: 'Microsoft Sans Serif'; HEIGHT: 24px"
                                                            onclick="OnSign()" type="button" value="Sign" name="cmdSign"></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <input id="cmdClear" style="FONT-WEIGHT: bold; FONT-SIZE: xx-small; WIDTH: 56px; FONT-FAMILY: 'Microsoft Sans Serif'; HEIGHT: 24px"
                                                            onclick="OnClear()" type="button" value="Clear" name="cmdClear"></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table id="tblUndo" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
                        <tr>
                            <td style="WIDTH: 125px" valign="top"><font face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG>Email&nbsp;Notes 
																	to&nbsp;Requester</STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></font></td>
                            <td>
                                <asp:TextBox ID="txtUndoNotes" runat="server" Width="504px" Height="38px" TextMode="MultiLine"></asp:TextBox></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <hr width="100%" color="#006699" size="2">
                </td>
            </tr>
            <tr>
                <td style="HEIGHT: 35px" align="center">
                    <asp:Button ID="cmdEmailReq" runat="server" Font-Bold="True" Font-Size="X-Small" Font-Names="Arial"
                        Width="121px" Height="24px" Text="Email Requester"></asp:Button>&nbsp;
						<asp:Button ID="cmdDelete" runat="server" Font-Bold="True" Font-Size="X-Small" Font-Names="Arial"
                            Width="110px" Height="24px" Text="Delete"></asp:Button>&nbsp;<asp:Button ID="cmdSubmit" runat="server" Font-Bold="True" Font-Size="X-Small" Font-Names="Arial"
                                Width="110px" Height="24px" Text="Submit" DESIGNTIMEDRAGDROP="1348"></asp:Button><asp:Button ID="cmdPost" runat="server" Font-Bold="True" Font-Size="X-Small" Font-Names="Arial"
                                    Width="110px" Height="24px" Text="Post"></asp:Button>&nbsp;
                    <input id="cmdExit" style="FONT-WEIGHT: bold; FONT-SIZE: x-small; WIDTH: 110px; FONT-FAMILY: Arial; HEIGHT: 24px"
                        onclick="window.close();" type="button" value="Exit" name="cmdExit">
                    <asp:TextBox ID="txtClockId" runat="server" Width="29px" Visible="False"></asp:TextBox><asp:TextBox ID="txtManClockId" runat="server" Width="24px" Height="16px" Visible="False"></asp:TextBox><asp:TextBox ID="txtEFTCId1" runat="server" Width="32px" Height="16px" Visible="False"></asp:TextBox><asp:TextBox ID="txtEFTCId2" runat="server" Width="17px" Height="16px" Visible="False"></asp:TextBox><asp:TextBox ID="txtEFTCId3" runat="server" Width="17px" Height="16px" Visible="False"></asp:TextBox><asp:TextBox ID="txtEFTCId4" runat="server" Width="17px" Height="16px" Visible="False"></asp:TextBox><asp:TextBox ID="txtEFTCId5" runat="server" Width="17px" Height="16px" Visible="False"></asp:TextBox><input id="txtEmpName" style="WIDTH: 30px; HEIGHT: 14px" type="hidden" size="1" name="txtEmpName"
                        runat="server"><input id="txtEmpSig" style="WIDTH: 30px; HEIGHT: 14px" type="hidden" size="1" name="txtEmpSig"
                            runat="server"><input id="txtId" style="WIDTH: 30px; HEIGHT: 14px" type="hidden" size="1" name="txtId"
                                runat="server"></td>
            </tr>
        </table>
    </form>
</body>
</html>
