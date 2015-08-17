<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ChangeI9.aspx.vb" Inherits="Web_CJEmployeeInfo.ChangeI9" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Change I9</title>
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

            var cmbI9Status;
            var txtExpDate;
            var txtAlienNo;

            var txtEffDate;
            var txtChangeReason;

            var txtOldI9Status;
            var txtOldExpDate;
            var txtOldAlienNo;


            cmbI9Status = document.getElementById("cmbI9Status");
            txtExpDate = document.getElementById("txtExpDate");
            txtAlienNo = document.getElementById("txtAlienNo");

            txtOldI9Status = document.getElementById("txtOldI9Status");
            txtOldExpDate = document.getElementById("txtOldExpDate");
            txtOldAlienNo = document.getElementById("txtOldAlienNo");

            txtEffDate = document.getElementById("txtEffDate");
            txtChangeReason = document.getElementById("txtChangeReason");

            if (cmbI9Status.options(cmbI9Status.selectedIndex).text == txtOldI9Status.value &&
                TrimString(txtExpDate.value) == txtOldExpDate.value &&
                TrimString(txtAlienNo.value) == txtOldAlienNo.value) {
                alert('Atleast one field must be changed .. Please check it out')
                return false;
            }

            if (isBlank(cmbI9Status.options(cmbI9Status.selectedIndex).text) ||
                isBlank(txtEffDate.value) ||
                isBlank(txtChangeReason.value)) {
                alert('Following fields are required .. Please check it out' +
                    '\n' + '\n' + 'I-9 Status' +
                    '\n' + 'Effective Date' +
                    '\n' + 'Change Reason');

                return false;
            }

            if (!CheckDateEff(txtEffDate.value)) {
                alert('Invalid Date Effective ... Please check it out');
                return false;
            }

            //Exp Date and Alien No are required
            if (cmbI9Status.options(cmbI9Status.selectedIndex).text == 'Employment Authorization' ||
                cmbI9Status.options(cmbI9Status.selectedIndex).text == 'Permanent Resident Card') {
                if (isBlank(txtExpDate.value) || isBlank(txtAlienNo.value)) {
                    alert('Following fields are required for the selected I-9 status .. Please check it out' +
                        '\n' + '\n' + 'Exp. Date' + '\n' + 'Alien #');
                    return false;
                }
            }

            //Alien No is required
            if (cmbI9Status.options(cmbI9Status.selectedIndex).text == 'Refugee' &&
                isBlank(txtAlienNo.value)) {
                alert('Following fields are required for the selected I-9 status .. Please check it out' +
                    '\n' + '\n' + 'Alien #');
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
<body bgcolor="#eae2be">
    <form id="Form1" method="post" runat="server">
        <table id="Table1" style="Z-INDEX: 101; LEFT: 8px; POSITION: absolute; TOP: 8px" cellspacing="0"
            cellpadding="0" width="650" border="0">
            <tr>
                <td style="HEIGHT: 1px" align="center"><font face="Monotype Corsiva" color="saddlebrown" size="5"><STRONG>Change&nbsp;I-9 
								Information</STRONG></font></td>
            </tr>
            <tr>
                <td>
                    <hr width="100%" color="saddlebrown" size="2">
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:Label ID="lblEmp" runat="server" Font-Bold="True" Font-Size="X-Small" Font-Names="Microsoft Sans Serif"
                        Width="605px"></asp:Label></td>
            </tr>
            <tr>
                <td>
                    <hr width="100%" color="saddlebrown" size="2">
                </td>
            </tr>
            <tr>
                <td style="HEIGHT: 28px"><font face="MS Sans Serif" color="saddlebrown" size="2"><STRONG>Employee's 
								Existing Information :</STRONG></font></td>
            </tr>
            <tr>
                <td>
                    <table id="Table3" cellspacing="0" cellpadding="0" width="100%" border="0">
                        <tr>
                            <td style="WIDTH: 401px" width="401">
                                <table id="Table5" cellspacing="0" cellpadding="0" width="100%" border="0">
                                    <tr>
                                        <td style="WIDTH: 70px"><font face="MS Sans Serif" size="1"><STRONG>I-9 Status</STRONG></font></td>
                                        <td>
                                            <asp:TextBox ID="txtOldI9Status" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="280px"
                                                Height="20px" BackColor="WhiteSmoke" Enabled="False" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td style="WIDTH: 70px"><font face="MS Sans Serif" size="1"><STRONG>Exp. Date</STRONG></font></td>
                                        <td>
                                            <asp:TextBox ID="txtOldExpDate" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="144px"
                                                Height="20px" BackColor="WhiteSmoke" Enabled="False" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td style="WIDTH: 70px"><font face="MS Sans Serif" size="1"><STRONG>Alien No</STRONG></font></td>
                                        <td>
                                            <asp:TextBox ID="txtOldAlienNo" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="144px"
                                                Height="20px" BackColor="WhiteSmoke" Enabled="False" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
                                    </tr>
                                </table>
                            </td>
                            <td valign="top" colspan="1" rowspan="1">
                                <table id="Table6" cellspacing="0" cellpadding="0" width="100%" border="0">
                                    <tr>
                                        <td><font face="MS Sans Serif" size="1"><STRONG>I-9&nbsp;Notes</STRONG></font></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:TextBox ID="txtOldI9Notes" runat="server" Width="232px" TextMode="MultiLine" Height="56px"
                                                BackColor="WhiteSmoke" Enabled="False"></asp:TextBox></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <hr width="100%" color="saddlebrown" size="2">
                </td>
            </tr>
            <tr>
                <td style="HEIGHT: 27px"><font face="MS Sans Serif" color="saddlebrown" size="2"><STRONG>Employee's 
								New Information :</STRONG></font></td>
            </tr>
            <tr>
                <td>
                    <table id="Table2" cellspacing="0" cellpadding="0" width="100%" border="0">
                        <tr>
                            <td style="WIDTH: 401px" width="401">
                                <table id="Table7" cellspacing="0" cellpadding="0" width="100%" border="0">
                                    <tr>
                                        <td style="WIDTH: 70px"><font face="MS Sans Serif" size="1"><STRONG>I-9 Status</STRONG></font></td>
                                        <td>
                                            <asp:DropDownList ID="cmbI9Status" runat="server" Width="280px" Height="20px" BackColor="#FFFFC0"></asp:DropDownList></td>
                                    </tr>
                                    <tr>
                                        <td style="WIDTH: 70px"><font face="MS Sans Serif" size="1"><STRONG>Exp. Date</STRONG></font></td>
                                        <td>
                                            <asp:TextBox ID="txtExpDate" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="144px"
                                                Height="20px" BackColor="White" BorderStyle="Solid" BorderWidth="1px" Preset="shortdate"
                                                CssClass="mask"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td style="WIDTH: 70px"><font face="MS Sans Serif" size="1"><STRONG>Alien No</STRONG></font></td>
                                        <td>
                                            <asp:TextBox ID="txtAlienNo" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="144px"
                                                Height="20px" BackColor="White" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
                                    </tr>
                                </table>
                            </td>
                            <td valign="top" colspan="1" rowspan="1">
                                <table id="Table8" cellspacing="0" cellpadding="0" width="100%" border="0">
                                    <tr>
                                        <td><font face="MS Sans Serif" size="1"><STRONG>I-9&nbsp;Notes</STRONG></font></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:TextBox ID="txtI9Notes" runat="server" Width="232px" TextMode="MultiLine" Height="56px"
                                                BackColor="White"></asp:TextBox></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="HEIGHT: 18px">
                    <hr width="100%" color="saddlebrown" size="2">
                </td>
            </tr>
            <tr>
                <td>
                    <table id="Table4" cellspacing="0" cellpadding="0" width="100%" border="0">
                        <tr>
                            <td style="WIDTH: 125px; HEIGHT: 13px" valign="top"><font face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG>Effective 
																	Date</STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></font></td>
                            <td style="HEIGHT: 13px">
                                <asp:TextBox ID="txtEffDate" runat="server" Font-Size="X-Small" Font-Names="Arial" Width="136px"
                                    Height="20px" BackColor="#FFFFC0" Preset="shortdate" CssClass="mask" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td style="WIDTH: 125px; HEIGHT: 51px" valign="top"><font face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG>Reason 
																	For Change</STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></font></td>
                            <td style="HEIGHT: 51px">
                                <asp:TextBox ID="txtChangeReason" runat="server" Width="504px" TextMode="MultiLine" Height="46px"
                                    BackColor="#FFFFC0"></asp:TextBox></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table id="tblUndo" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
                        <tr>
                            <td style="WIDTH: 126px" valign="top"><font face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG>Email&nbsp;Notes 
																	to&nbsp;Requester</STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></font></td>
                            <td>
                                <asp:TextBox ID="txtUndoNotes" runat="server" Width="504px" Height="38px" TextMode="MultiLine"></asp:TextBox></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <hr width="100%" color="saddlebrown" size="2">
                </td>
            </tr>
            <tr>
                <td style="HEIGHT: 35px" align="center">
                    <asp:Button ID="cmdEmailReq" runat="server" Width="121px" Font-Names="Arial" Font-Size="X-Small"
                        Font-Bold="True" Height="24px" Text="Email Requester"></asp:Button>&nbsp;
						<asp:Button ID="cmdDelete" runat="server" Width="110px" Font-Names="Arial" Font-Size="X-Small"
                            Font-Bold="True" Height="24px" Text="Delete"></asp:Button>&nbsp;<asp:Button ID="cmdSubmit" runat="server" Font-Bold="True" Font-Size="X-Small" Font-Names="Arial"
                                Width="110px" Height="24px" Text="Submit" DESIGNTIMEDRAGDROP="1348"></asp:Button><asp:Button ID="cmdPost" runat="server" Font-Bold="True" Font-Size="X-Small" Font-Names="Arial"
                                    Width="110px" Height="24px" Text="Post"></asp:Button>&nbsp;
                    <input id="cmdExit" style="FONT-WEIGHT: bold; FONT-SIZE: x-small; WIDTH: 110px; FONT-FAMILY: Arial; HEIGHT: 24px"
                        onclick="window.close();" type="button" value="Exit" name="cmdExit">
                    <asp:TextBox ID="txtClockId" runat="server" Width="29px" Visible="False"></asp:TextBox><asp:TextBox ID="txtId" runat="server" Width="29px" Visible="False"></asp:TextBox><asp:TextBox ID="txtManClockId" runat="server" Width="24px" Height="16px" Visible="False"></asp:TextBox><asp:TextBox ID="txtHI9Status" runat="server" Width="32px" Height="16px" Visible="False"></asp:TextBox><input id="txtEmpName" style="WIDTH: 30px; HEIGHT: 14px" type="hidden" size="1" name="txtEmpName"
                        runat="server"></td>
            </tr>
        </table>
        &nbsp;
    </form>
</body>
</html>
