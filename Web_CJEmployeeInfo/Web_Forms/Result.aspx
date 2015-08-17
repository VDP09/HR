<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Result.aspx.vb" Inherits="Web_CJEmployeeInfo.Result" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>HR Express - Result</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <script language="javascript">
        function CloseWindow() {
            var i;

            //txtStatus = document.getElementById("txtStatus");
            //alert('rupesh');
            //alert(frmResult.txtStatus.value);

            if (frmResult.txtStatus.value == 0) {
                //alert('rupesh1');
                //frmResult.cmdBack.style.visibility = false;
                //i = setTimeout('window.close();', 4000);
            }
            else {
                //frmResult.cmdBack.style.visibility = true;
            }
        }
    </script>
</head>
<body>
    <form id="form1" method="post" runat="server">
        <div style="text-align: center;">
            <div id="lblMessage" style="DISPLAY: inline; FONT-WEIGHT: normal; FONT-SIZE: 18px; WIDTH: 629px; COLOR: green; FONT-FAMILY: 'Comic Sans MS', Verdana; HEIGHT: 24px"
                runat="server">
                Label
            </div>
            <br />
            <div id="lblError" style="DISPLAY: inline; FONT-SIZE: 18px; WIDTH: 622px; COLOR: red; FONT-FAMILY: 'Comic Sans MS', Verdana; HEIGHT: 24px" runat="server">Label</div>
            <br />
            <asp:Button ID="cmdBack" runat="server" Text="> Back" OnClientClick="javascript:history.back();" />
            &nbsp&nbsp
            <asp:Button ID="btnClose" runat="server" Text="Close" OnClientClick="javascript :window.close();" />
            <asp:TextBox ID="txtStatus" runat="server" Style="display: none;"></asp:TextBox>
        </div>
    </form>
</body>
</html>
