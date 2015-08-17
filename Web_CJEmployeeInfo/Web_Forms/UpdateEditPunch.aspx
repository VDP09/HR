<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="UpdateEditPunch.aspx.vb" Inherits="Web_CJEmployeeInfo.UpdateEditPunch" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>UpdateEditPunch</title>
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
    <meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
    <meta name="vs_defaultClientScript" content="JavaScript">
    <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
    <script language="javascript">
        function CloseWindow() {
            //var i;
            //window.opener.document.forms(0).submit(); 
            //self.close();

            //window.opener.document.forms(0).txtLoadForm.value = 1; 
            //window.opener.document.forms(0).submit(1); 
            //i = setTimeout('window.close();',1000);

            self.close();
        }
    </script>
</head>
<body>
    <form id="Form1" method="post" runat="server" onfocus="CloseWindow();">
        <table id="Table1" style="Z-INDEX: 102; LEFT: 8px; WIDTH: 600px; POSITION: absolute; TOP: 8px; HEIGHT: 128px"
            cellspacing="0" cellpadding="0" width="600" border="0">
            <tr>
                <td style="HEIGHT: 51px" align="center">
                    <asp:Label ID="lblUpdateStatus" runat="server" ForeColor="#004000" Font-Bold="True" Font-Size="Small"
                        Font-Names="Arial" Height="5px" Width="642px"></asp:Label></td>
            </tr>
            <tr>
                <td style="HEIGHT: 22px" align="center">&nbsp;</td>
            </tr>
            <tr>
                <td align="center">
                    <input id="cmdBack" style="WIDTH: 100px; HEIGHT: 24px" onclick="history.back();" type="button"
                        value="<  Go Back" name="cmdBack" runat="server">&nbsp;&nbsp;<input style="WIDTH: 74px; HEIGHT: 24px" onclick="CloseWindow();" type="button" value="Close"></td>
            </tr>
        </table>
    </form>
</body>
</html>
