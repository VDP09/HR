<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ChangeW4.aspx.vb" Inherits="Web_CJEmployeeInfo.ChangeW4" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Change W4</title>
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
    <meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
    <meta name="vs_defaultClientScript" content="JavaScript">
    <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
    <style>
        .mask
        {
            BEHAVIOR: url("mask_vbs.htc");
        }
    </style>
    <script language="javascript">

        function ValidateData() {
            var cmbFedMaritalStatus;
            var cmbStateMaritalStatus;
            //var chkClaimSingle;
            var txtFedDed;
            var txtStateDed;
            var txtFedExempNo;
            var txtStateExempNo;
            var chkFedClEx;
            var chkStateClEx;
            var cmbA4;

            var txtEffDate;
            var txtChangeReason;

            var txtOldFedMaritalStatus;
            var txtOldStateMaritalStatus;
            //var chkOldClaimSingle;
            var txtOldFedDed;
            var txtOldStateDed;
            var txtOldFedExempNo;
            var txtOldStateExempNo;
            var chkOldFedClEx;
            var chkOldStateClEx;
            var txtOldA4;
            //var txtHomeState;

            var d1;
            var intDay;

            cmbFedMaritalStatus = document.getElementById("cmbFedMaritalStatus");
            cmbStateMaritalStatus = document.getElementById("cmbStateMaritalStatus");
            //chkClaimSingle = document.getElementById("chkClaimSingle");
            txtFedDed = document.getElementById("txtFedDed");
            txtStateDed = document.getElementById("txtStateDed");
            txtFedExempNo = document.getElementById("txtFedExempNo");
            txtStateExempNo = document.getElementById("txtStateExempNo");
            chkFedClEx = document.getElementById("chkFedClEx");
            chkStateClEx = document.getElementById("chkStateClEx");
            cmbA4 = document.getElementById("cmbA4");

            txtOldFedMaritalStatus = document.getElementById("txtOldFedMaritalStatus");
            txtOldStateMaritalStatus = document.getElementById("txtOldStateMaritalStatus");
            //chkOldClaimSingle = document.getElementById("chkOldClaimSingle");
            txtOldFedDed = document.getElementById("txtOldFedDed");
            txtOldStateDed = document.getElementById("txtOldStateDed");
            txtOldFedExempNo = document.getElementById("txtOldFedExempNo");
            txtOldStateExempNo = document.getElementById("txtOldStateExempNo");
            chkOldFedClEx = document.getElementById("chkOldFedClEx");
            chkOldStateClEx = document.getElementById("chkOldStateClEx");
            txtOldA4 = document.getElementById("txtOldA4");
            //txtHomeState = document.getElementById("HomeState");

            txtEffDate = document.getElementById("txtEffDate");
            txtChangeReason = document.getElementById("txtChangeReason");

            //alert(chkOldClaimSingle.checked);

            if (cmbFedMaritalStatus.options(cmbFedMaritalStatus.selectedIndex).text == txtOldFedMaritalStatus.value &&
                cmbStateMaritalStatus.options(cmbStateMaritalStatus.selectedIndex).text == txtOldStateMaritalStatus.value &&
                TrimString(txtFedDed.value) == txtOldFedDed.value &&
                TrimString(txtStateDed.value) == txtOldStateDed.value &&
                TrimString(txtFedExempNo.value) == txtOldFedExempNo.value &&
                TrimString(txtStateExempNo.value) == txtOldStateExempNo.value &&
                chkFedClEx.checked == chkOldFedClEx.checked &&
                chkStateClEx.checked == chkOldStateClEx.checked &&
                cmbA4.options(cmbA4.selectedIndex).text == txtOldA4.value) {
                alert('Atleast one field must be changed .. Please check it out');
                return false;
            }

            //alert('rupesh');

            if (isBlank(cmbFedMaritalStatus.options(cmbFedMaritalStatus.selectedIndex).text) ||
                isBlank(cmbStateMaritalStatus.options(cmbStateMaritalStatus.selectedIndex).text) ||
                isBlank(txtFedExempNo.value) ||
                isBlank(txtStateExempNo.value) ||
                isBlank(txtEffDate.value) ||
                isBlank(txtChangeReason.value)) {
                alert('Following fields are required .. Please check it out' +
                    '\n' + '\n' + 'Marital Status' + '\n' + '# of Exemptions' +
                    '\n' + 'Effective Date' + '\n' + 'Change Reason');

                return false;
            }

            if (!CheckDateEff(txtEffDate.value)) {
                alert('Invalid Date Effective .. Please check it out');
                return false;
            }

            //Employee can not claim Exempt and put # of Exemptions
            //same time. It has to be either one.
            if ((chkFedClEx.checked && txtFedExempNo.value > 0) ||
                (chkStateClEx.checked && txtStateExempNo.value > 0)) {
                alert('Employee can not Claim Exempt and have # of Exemptions together. It has to be either one .. Please check it out');
                return false;
            }

            //A4 Ded should be blank if state is not AZ
            if (!isBlank(cmbA4.options(cmbA4.selectedIndex).text) &&
                frmW4.txtHomeState.value != 'AZ') {
                alert('Employee can claim A4 Deductions only if he/she lives in AZ .. Please check it out');
                return false;
            }

            //# of Exemptions should be numeric
            if ((txtFedExempNo.value - 0 != txtFedExempNo.value) ||
                (txtStateExempNo.value - 0 != txtStateExempNo.value)) {
                alert('# of Exemptions should be numeric .. Please check it out');
                return false;
            }

            //Check for 1st or 16 day of effective date			
            /*
            d1 = new Date(txtEffDate.value);
            intDay = d1.getDate();
            if(intDay != 1 && intDay != 16)
            {
                alert('W4 change effective date must be 1st or 16th of the month .. Please check it out');
                return false;
            }
            */

            //Check for first date of biweekly payroll schedule
            var d1;
            var d2;
            var found;
            var strAlert;
            d1 = new Date(txtEffDate.value);
            d2 = new Date('4/21/2010');

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
                d2 = new Date('4/21/2010');

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
            if (ValidateData())
                if (confirm('Submit Request ?' + '\n' + '\n' + 'Date Effective : ' + document.getElementById("txtEffDate").value))
                    return true;
                else
                    return false;

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

    </script>
</head>
<body bgcolor="#a8d4a8">
    <form id="frmW4" method="post" runat="server">
        <table style="Z-INDEX: 101; POSITION: absolute; TOP: 8px; LEFT: 8px" id="Table1" border="0"
            cellspacing="0" cellpadding="0" width="650">
            <tr>
                <td style="HEIGHT: 1px" align="center"><font color="darkgreen" size="5" face="Monotype Corsiva"><STRONG>Change 
								W4 Information</STRONG></font></td>
            </tr>
            <tr>
                <td>
                    <hr color="darkgreen" size="2" width="100%">
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:Label ID="lblEmp" runat="server" Font-Bold="True" Font-Size="X-Small" Font-Names="Microsoft Sans Serif"
                        Width="605px"></asp:Label></td>
            </tr>
            <tr>
                <td>
                    <hr color="darkgreen" size="2" width="100%">
                </td>
            </tr>
            <tr>
                <td style="HEIGHT: 28px"><font color="darkgreen" size="2" face="MS Sans Serif"><STRONG>Employee's 
								Existing Information :</STRONG></font></td>
            </tr>
            <tr>
                <td style="HEIGHT: 116px">
                    <table id="Table3" border="0" cellspacing="0" cellpadding="0" width="100%">
                        <tr>
                            <td style="WIDTH: 463px">
                                <table id="Table5" border="0" cellspacing="0" cellpadding="0" width="100%">
                                    <tr>
                                        <td style="WIDTH: 112px; HEIGHT: 21px"></td>
                                        <td style="WIDTH: 138px; HEIGHT: 21px"><font size="1" face="MS Sans Serif"><STRONG>State 
														Taxes</STRONG></font></td>
                                        <td style="HEIGHT: 21px"><font size="1" face="MS Sans Serif"><STRONG>Federal Taxes</STRONG></font></td>
                                    </tr>
                                    <tr>
                                        <td style="WIDTH: 112px; HEIGHT: 21px"><font size="1" face="MS Sans Serif"><STRONG>Marital 
														Status</STRONG></font></td>
                                        <td style="WIDTH: 138px; HEIGHT: 21px">
                                            <asp:TextBox ID="txtOldStateMaritalStatus" runat="server" Font-Size="X-Small" Font-Names="Arial"
                                                Width="128px" Height="20px" BorderStyle="Solid" BorderWidth="1px" BackColor="WhiteSmoke" Enabled="False"></asp:TextBox></td>
                                        <td style="HEIGHT: 21px">
                                            <asp:TextBox Style="Z-INDEX: 0" ID="txtOldFedMaritalStatus" runat="server" Font-Size="X-Small"
                                                Font-Names="Arial" Width="128px" Height="20px" BorderStyle="Solid" BorderWidth="1px" BackColor="WhiteSmoke" Enabled="False"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td style="WIDTH: 112px"><font size="1" face="MS Sans Serif"><STRONG># of Exemptions</STRONG></font></td>
                                        <td style="WIDTH: 138px">
                                            <asp:TextBox ID="txtOldStateExempNo" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="128px"
                                                Height="20px" BorderStyle="Solid" BorderWidth="1px" BackColor="WhiteSmoke" Enabled="False"></asp:TextBox></td>
                                        <td>
                                            <asp:TextBox Style="Z-INDEX: 0" ID="txtOldFedExempNo" runat="server" Font-Size="X-Small" Font-Names="Arial"
                                                Width="128px" Height="20px" BorderStyle="Solid" BorderWidth="1px" BackColor="WhiteSmoke"
                                                Enabled="False"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td style="WIDTH: 112px"><font size="1" face="MS Sans Serif"><STRONG>Additional Amt ($)</STRONG></font></td>
                                        <td style="WIDTH: 138px">
                                            <asp:TextBox ID="txtOldStateDed" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="128px"
                                                Height="20px" BorderStyle="Solid" BorderWidth="1px" BackColor="WhiteSmoke" Enabled="False"></asp:TextBox></td>
                                        <td>
                                            <asp:TextBox Style="Z-INDEX: 0" ID="txtOldFedDed" runat="server" Font-Size="X-Small" Font-Names="Arial"
                                                Width="128px" Height="20px" BorderStyle="Solid" BorderWidth="1px" BackColor="WhiteSmoke"
                                                Enabled="False"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td style="WIDTH: 112px; HEIGHT: 22px"><font size="1" face="MS Sans Serif"><STRONG>EE 
														Claims Exempt</STRONG></font></td>
                                        <td style="WIDTH: 138px; HEIGHT: 22px">
                                            <asp:CheckBox Style="Z-INDEX: 0" ID="chkOldStateClEx" runat="server" Font-Bold="True" Font-Size="XX-Small"
                                                Font-Names="Microsoft Sans Serif" Width="163px" Enabled="False" ToolTip="Rupesh"></asp:CheckBox></td>
                                        <td style="HEIGHT: 22px">
                                            <asp:CheckBox ID="chkOldFedClEx" runat="server" Font-Bold="True" Font-Size="XX-Small" Font-Names="Microsoft Sans Serif"
                                                Width="163px" Enabled="False" ToolTip="Rupesh"></asp:CheckBox></td>
                                    </tr>
                                    <tr>
                                        <td style="WIDTH: 112px"><font size="1" face="MS Sans Serif"><STRONG>A4 Form (%)</STRONG></font></td>
                                        <td style="WIDTH: 138px">
                                            <asp:TextBox ID="txtOldA4" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="128px"
                                                Height="20px" BorderStyle="Solid" BorderWidth="1px" BackColor="WhiteSmoke" Enabled="False"></asp:TextBox></td>
                                        <td><font size="1" face="MS Sans Serif"><STRONG>(AZ&nbsp;Only)</STRONG></font></td>
                                    </tr>
                                </table>
                            </td>
                            <td valign="top">
                                <table id="Table6" border="0" cellspacing="0" cellpadding="0" width="100%">
                                    <tr>
                                        <td style="HEIGHT: 20px"><font size="1" face="MS Sans Serif"><STRONG>W4 Notes</STRONG></font></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:TextBox ID="txtOldW4Notes" runat="server" Width="176px" Height="116px" BackColor="WhiteSmoke"
                                                Enabled="False" TextMode="MultiLine"></asp:TextBox></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <hr color="darkgreen" size="2" width="100%">
                </td>
            </tr>
            <tr>
                <td style="HEIGHT: 27px"><font color="darkgreen" size="2" face="MS Sans Serif"><STRONG>Employee's 
								New Information :</STRONG></font></td>
            </tr>
            <tr>
                <td>
                    <table id="Table2" border="0" cellspacing="0" cellpadding="0" width="100%">
                        <tr>
                            <td style="WIDTH: 463px">
                                <table id="Table7" border="0" cellspacing="0" cellpadding="0" width="100%">
                                    <tr>
                                        <td style="WIDTH: 113px; HEIGHT: 21px"></td>
                                        <td style="WIDTH: 138px; HEIGHT: 21px"><font size="1" face="MS Sans Serif"><STRONG>State 
														Taxes</STRONG></font></td>
                                        <td style="HEIGHT: 21px"><font size="1" face="MS Sans Serif"><STRONG>Federal Taxes</STRONG></font></td>
                                    </tr>
                                    <tr>
                                        <td style="WIDTH: 113px; HEIGHT: 21px"><font size="1" face="MS Sans Serif"><STRONG>Marital 
														Status</STRONG></font></td>
                                        <td style="WIDTH: 138px; HEIGHT: 21px">
                                            <asp:DropDownList ID="cmbStateMaritalStatus" runat="server" Width="130px" Height="20px" BackColor="#FFFFC0"></asp:DropDownList></td>
                                        <td style="HEIGHT: 21px">
                                            <asp:DropDownList Style="Z-INDEX: 0" ID="cmbFedMaritalStatus" runat="server" Width="130px" Height="20px"
                                                BackColor="#FFFFC0">
                                            </asp:DropDownList></td>
                                    </tr>
                                    <tr>
                                        <td style="WIDTH: 113px"><font size="1" face="MS Sans Serif"><STRONG># of Exemptions</STRONG></font></td>
                                        <td style="WIDTH: 138px">
                                            <asp:TextBox Style="Z-INDEX: 0" ID="txtStateExempNo" runat="server" Font-Size="X-Small" Font-Names="Arial"
                                                Width="128px" Height="20px" BorderStyle="Solid" BorderWidth="1px" BackColor="#FFFFC0"></asp:TextBox></td>
                                        <td>
                                            <asp:TextBox Style="Z-INDEX: 0" ID="txtFedExempNo" runat="server" Font-Size="X-Small" Font-Names="Arial"
                                                Width="128px" Height="20px" BorderStyle="Solid" BorderWidth="1px" BackColor="#FFFFC0"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td style="WIDTH: 113px; HEIGHT: 9px"><font size="1" face="MS Sans Serif"><STRONG>Additional 
														Amt ($)</STRONG></font></td>
                                        <td style="WIDTH: 138px; HEIGHT: 9px">
                                            <asp:TextBox ID="txtStateDed" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="128px"
                                                Height="20px" BorderStyle="Solid" BorderWidth="1px" BackColor="White" CssClass="mask" Preset="currency"></asp:TextBox></td>
                                        <td style="HEIGHT: 9px">
                                            <asp:TextBox Style="Z-INDEX: 0" ID="txtFedDed" runat="server" Font-Size="X-Small" Font-Names="Arial"
                                                Width="128px" Height="20px" BorderStyle="Solid" BorderWidth="1px" BackColor="White" CssClass="mask" Preset="currency"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td style="WIDTH: 113px"><font size="1" face="MS Sans Serif"><STRONG>EE Claims Exempt</STRONG></font></td>
                                        <td style="WIDTH: 138px">
                                            <asp:CheckBox Style="Z-INDEX: 0" ID="chkStateClEx" runat="server" Font-Bold="True" Font-Size="XX-Small"
                                                Font-Names="Microsoft Sans Serif" Width="163px" ToolTip="Rupesh"></asp:CheckBox></td>
                                        <td>
                                            <asp:CheckBox ID="chkFedClEx" runat="server" Font-Bold="True" Font-Size="XX-Small" Font-Names="Microsoft Sans Serif"
                                                Width="163px" ToolTip="Rupesh"></asp:CheckBox></td>
                                    </tr>
                                    <tr>
                                        <td style="WIDTH: 113px"><font size="1" face="MS Sans Serif"><STRONG>A4 Form (%)</STRONG></font></td>
                                        <td style="WIDTH: 138px">
                                            <asp:DropDownList ID="cmbA4" runat="server" Width="130px" Height="20px" BackColor="White"></asp:DropDownList></td>
                                        <td><font size="1" face="MS Sans Serif"><STRONG>(AZ&nbsp;Only)</STRONG></font></td>
                                    </tr>
                                </table>
                            </td>
                            <td valign="top">
                                <table id="Table8" border="0" cellspacing="0" cellpadding="0" width="100%">
                                    <tr>
                                        <td style="HEIGHT: 20px"><font size="1" face="MS Sans Serif"><STRONG>W4 Notes</STRONG></font></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:TextBox ID="txtW4Notes" runat="server" Width="176px" Height="114px" BackColor="White" TextMode="MultiLine"></asp:TextBox></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="HEIGHT: 18px">
                    <hr color="darkgreen" size="2" width="100%">
                </td>
            </tr>
            <tr>
                <td>
                    <table id="Table4" border="0" cellspacing="0" cellpadding="0" width="100%">
                        <tr>
                            <td style="WIDTH: 125px; HEIGHT: 13px" valign="top"><font size="2" face="Arial"><STRONG><FONT size="1" face="MS Sans Serif"><STRONG><FONT size="2" face="Arial"><STRONG><FONT size="1" face="MS Sans Serif"><STRONG>Effective 
																	Date</STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></font></td>
                            <td style="HEIGHT: 13px">
                                <asp:TextBox ID="txtEffDate" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="136px"
                                    Height="20px" BorderStyle="Solid" BorderWidth="1px" BackColor="#FFFFC0" CssClass="mask" Preset="shortdate"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="WIDTH: 125px; HEIGHT: 51px" valign="top"><font size="2" face="Arial"><STRONG><FONT size="1" face="MS Sans Serif"><STRONG><FONT size="2" face="Arial"><STRONG><FONT size="1" face="MS Sans Serif"><STRONG>Reason 
																	For Change</STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></font></td>
                            <td style="HEIGHT: 51px">
                                <asp:TextBox ID="txtChangeReason" runat="server" Width="504px" Height="46px" BackColor="#FFFFC0"
                                    TextMode="MultiLine"></asp:TextBox></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table id="tblUndo" border="0" cellspacing="0" cellpadding="0" width="100%" runat="server">
                        <tr>
                            <td style="WIDTH: 125px" valign="top"><font size="2" face="Arial"><STRONG><FONT size="1" face="MS Sans Serif"><STRONG><FONT size="2" face="Arial"><STRONG><FONT size="1" face="MS Sans Serif"><STRONG>Email&nbsp;Notes 
																	to&nbsp;Requester</STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></font></td>
                            <td>
                                <asp:TextBox ID="txtUndoNotes" runat="server" Width="504px" Height="38px" TextMode="MultiLine"></asp:TextBox></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <hr color="darkgreen" size="2" width="100%">
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
                    <input style="WIDTH: 110px; FONT-FAMILY: Arial; HEIGHT: 24px; FONT-SIZE: x-small; FONT-WEIGHT: bold"
                        id="cmdExit" onclick="window.close();" value="Exit" type="button" name="cmdExit">
                    <asp:TextBox ID="txtClockId" runat="server" Width="29px" Visible="False"></asp:TextBox><asp:TextBox ID="txtId" runat="server" Width="29px" Visible="False"></asp:TextBox><asp:TextBox ID="txtHStateMaritalStatus" runat="server" Width="32px" Height="16px" Visible="False"></asp:TextBox><asp:TextBox ID="txtManClockId" runat="server" Width="24px" Height="16px" Visible="False"></asp:TextBox><asp:TextBox ID="txtHA4" runat="server" Width="32px" Height="16px" Visible="False"></asp:TextBox><input style="WIDTH: 21px; HEIGHT: 22px" id="txtHomeState" size="1" type="hidden" name="txtHomeState"
                        runat="server"><input style="WIDTH: 32px; HEIGHT: 14px" id="txtEmpName" size="1" type="hidden" name="txtEmpName"
                            runat="server">
                    <asp:TextBox Style="Z-INDEX: 0" ID="txtHFedMaritalStatus" runat="server" Width="32px" Height="16px"
                        Visible="False"></asp:TextBox></td>
            </tr>
        </table>
        &nbsp;
    </form>
</body>
</html>
