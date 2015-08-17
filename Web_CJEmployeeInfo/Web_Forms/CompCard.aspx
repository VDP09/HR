<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CompCard.aspx.vb" Inherits="Web_CJEmployeeInfo.CompCard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    		<title>Comp Card</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<script language="javascript">
		    function ValidateSubmit() {
		        var txtCardNo;

		        txtCardNo = document.getElementById("txtCardNo");

		        if (isBlank(txtCardNo.value)) {
		            alert('Card No. is required .. Please check it out');
		            return false;
		        }
		        else if (txtCardNo.value.length != 13) {
		            alert('Card No. must be 13 characters long .. Please check it out');
		            return false;
		        }
		        else {
		            if (confirm('Update Changes ?'))
		                return true;
		            else
		                return false;
		        }
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

		</script>
</head>
<body>
    <form id="Form1" method="post" runat="server">
			<TABLE id="Table1" style="Z-INDEX: 101; LEFT: 8px; WIDTH: 496px; POSITION: absolute; TOP: 8px; HEIGHT: 126px"
				cellSpacing="1" cellPadding="1" width="496" border="0">
				<TR>
					<TD style="WIDTH: 86px"><STRONG>Card No</STRONG></TD>
					<TD>
						<asp:TextBox id="txtCardNo" runat="server"></asp:TextBox></TD>
				</TR>
				<TR>
					<TD style="WIDTH: 86px"><STRONG>Card Role</STRONG></TD>
					<TD>
						<asp:DropDownList id="cmbRole" runat="server" Width="392px"></asp:DropDownList></TD>
				</TR>
				<TR>
					<TD style="WIDTH: 86px"><STRONG>Active ?</STRONG></TD>
					<TD>
						<asp:CheckBox id="chkActive" runat="server"></asp:CheckBox></TD>
				</TR>
				<TR>
					<TD style="WIDTH: 86px; HEIGHT: 8px"></TD>
					<TD style="HEIGHT: 8px">&nbsp;</TD>
				</TR>
				<TR>
					<TD style="WIDTH: 86px"></TD>
					<TD>
						<asp:Button id="cmdUpdate" runat="server" Text="Update" Width="80px" Font-Bold="True"></asp:Button>&nbsp;
						<INPUT id="cmdExit" style="FONT-WEIGHT: bold; FONT-SIZE: x-small; WIDTH: 80px; FONT-FAMILY: Arial; HEIGHT: 24px"
							onclick="window.close();" type="button" value="Exit" name="cmdExit">&nbsp; <INPUT id="txtClockId" style="WIDTH: 24px; HEIGHT: 22px" type="hidden" size="1" name="txtClockId"
							runat="server"> <INPUT id="txtManClockId" style="WIDTH: 24px; HEIGHT: 22px" type="hidden" size="1" name="txtManClockId"
							runat="server"> <INPUT id="txtCardId" style="WIDTH: 24px; HEIGHT: 22px" type="hidden" size="1" name="txtCardId"
							runat="server"></TD>
				</TR>
			</TABLE>
		</form>
</body>
</html>
