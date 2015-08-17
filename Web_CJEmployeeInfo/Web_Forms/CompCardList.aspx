<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CompCardList.aspx.vb" Inherits="Web_CJEmployeeInfo.CompCardList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employee Comp Cards</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<script language="javascript">
		    function OpenNewWin() {
		        var strURL;

		        strURL = 'CompCard.aspx?CId=0&CN=&RN=&A=true&ClockId=' + document.getElementById("txtClockId").value +
						'&MClockId=' + document.getElementById("txtManClockId").value;

		        //alert(strURL);

		        window.open(strURL, 'newCompCard', 'resizable=no,top=15, left=15, width=530,height=150,scrollbars=yes');
		    }
		</script>
</head>
<body>
    <body bgColor="azure">
		<form id="Form1" method="post" runat="server">
			<TABLE id="Table1" style="Z-INDEX: 101; LEFT: 8px; WIDTH: 614px; POSITION: absolute; TOP: 8px; HEIGHT: 112px"
				cellSpacing="1" cellPadding="1" width="614" border="0">
				<TR>
					<TD style="HEIGHT: 3px" align="center"><STRONG><FONT face="Monotype Corsiva" color="#3399ff" size="6">Employee 
								Comp Card</FONT></STRONG></TD>
				</TR>
				<TR>
					<TD style="HEIGHT: 10px" align="center">
						<HR width="100%" color="#3399ff" SIZE="2">
						<asp:label id="lblEmp" runat="server" ForeColor="#3399FF" Font-Bold="True" Width="589px"></asp:label></TD>
				</TR>
				<TR>
					<TD style="HEIGHT: 9px"></TD>
				</TR>
				<TR>
					<TD style="HEIGHT: 44px" align="center"><asp:datagrid id="grdCompCard" runat="server" Width="608px" Height="8px" Font-Size="XX-Small"
							Font-Names="Microsoft Sans Serif" PageSize="5" CellPadding="2" BorderStyle="None" BackColor="White" BorderWidth="1px" BorderColor="#CCCCCC"
							AutoGenerateColumns="False" HorizontalAlign="Center">
							<FooterStyle ForeColor="#000066" BackColor="White"></FooterStyle>
							<SelectedItemStyle Font-Bold="True" ForeColor="White" BackColor="#669999"></SelectedItemStyle>
							<AlternatingItemStyle BackColor="#E0E0E0"></AlternatingItemStyle>
							<ItemStyle ForeColor="#000066"></ItemStyle>
							<HeaderStyle Font-Size="XX-Small" Font-Bold="True" ForeColor="White" BackColor="#006699"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn HeaderText="Edit">
									<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
									<ItemStyle HorizontalAlign="Center" Width="10%"></ItemStyle>
									<ItemTemplate>
										<a href='javascript:<%# GetPopupScript(DataBinder.Eval(Container.DataItem, "Card_Id"), DataBinder.Eval(Container.DataItem, "Card_No"), DataBinder.Eval(Container.DataItem, "CompCard_Role"), DataBinder.Eval(Container.DataItem, "Flag_Active") ) %>'>
											Edit</a>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn Visible="False" HeaderText="Card_Id">
									<HeaderStyle HorizontalAlign="Center" Width="0%"></HeaderStyle>
									<ItemStyle HorizontalAlign="Center"></ItemStyle>
									<ItemTemplate>
										<asp:Label ID="Id" Text='<%# DataBinder.Eval(Container.DataItem, "Card_Id") %>' Runat=server />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn Visible="True" HeaderText="Card No">
									<HeaderStyle HorizontalAlign="Center" Width="30%"></HeaderStyle>
									<ItemStyle HorizontalAlign="Center"></ItemStyle>
									<ItemTemplate>
										<asp:Label ID="CardNo" Text='<%# DataBinder.Eval(Container.DataItem, "Card_No") %>' Runat=server />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn Visible="False" HeaderText="RoleNo">
									<HeaderStyle HorizontalAlign="Center" Width="0%"></HeaderStyle>
									<ItemStyle HorizontalAlign="Center"></ItemStyle>
									<ItemTemplate>
										<asp:Label ID="RoleNo" Text='<%# DataBinder.Eval(Container.DataItem, "CompCard_Role") %>' Runat=server />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn Visible="True" HeaderText="Role">
									<HeaderStyle HorizontalAlign="Center" Width="50%"></HeaderStyle>
									<ItemStyle HorizontalAlign="Center"></ItemStyle>
									<ItemTemplate>
										<asp:Label ID="RoleDesc" Text='<%# DataBinder.Eval(Container.DataItem, "Role_Desc") %>' Runat=server />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="Active ?">
									<HeaderStyle HorizontalAlign="Center" Width="15%"></HeaderStyle>
									<ItemStyle HorizontalAlign="Center"></ItemStyle>
									<ItemTemplate>
										<asp:CheckBox ID="FlagActive" Checked='<%# DataBinder.Eval(Container.DataItem, "Flag_Active") %>' Enabled =False Runat=server />
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
							<PagerStyle VerticalAlign="Middle" Font-Size="X-Small" Font-Bold="True" HorizontalAlign="Center"
								ForeColor="#000066" BackColor="White" PageButtonCount="20" Mode="NumericPages"></PagerStyle>
						</asp:datagrid></TD>
				</TR>
				<TR>
					<TD style="HEIGHT: 40px" align="center"><INPUT id="cmdNew" style="FONT-WEIGHT: bold; FONT-SIZE: x-small; WIDTH: 134px; FONT-FAMILY: Arial; HEIGHT: 24px"
							onclick="OpenNewWin();" type="button" value="New Comp Card" name="cmdNew" runat="server">&nbsp;
						<INPUT id="cmdExit" style="FONT-WEIGHT: bold; FONT-SIZE: x-small; WIDTH: 76px; FONT-FAMILY: Arial; HEIGHT: 24px"
							onclick="window.close();" type="button" value="Exit" name="cmdExit">&nbsp; <INPUT id="txtClockId" style="WIDTH: 24px; HEIGHT: 22px" type="hidden" size="1" name="txtClockId"
							runat="server"><INPUT id="txtManClockId" style="WIDTH: 24px; HEIGHT: 22px" type="hidden" size="1" name="txtManClockId"
							runat="server"></TD>
				</TR>
				<TR>
					<TD align="center"></TD>
				</TR>
			</TABLE>
		</form>
	</body>
</body>
</html>
