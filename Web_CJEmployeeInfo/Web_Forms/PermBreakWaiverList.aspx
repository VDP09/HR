<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PermBreakWaiverList.aspx.vb" Inherits="Web_CJEmployeeInfo.PermBreakWaiverList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../assets/plugins/boostrapv3/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../pages/css/pages.css" rel="stylesheet" />
    <title>Permanent Break Waiver List</title>
    <meta content="False" name="vs_showGrid">
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <script language="javascript">
        function OpenWin(i) {
            var strURL;

            if (i == 1) // Under 6 Hours, For CA Only
                strURL = 'PermBreakWaiver.aspx?CId=' + frmPBWList.txtClockId.value +
                        '&BT=1&S=' + frmPBWList.txt6Hrs.value + '&Emp=' + frmPBWList.txtEmpName.value +
                        '&PBWId=0';

            else if (i == 2)	// Between 10-12 hours, For CA only
                strURL = 'PermBreakWaiver.aspx?CId=' + frmPBWList.txtClockId.value +
                        '&BT=2&S=' + frmPBWList.txt1012Hrs.value + '&Emp=' + frmPBWList.txtEmpName.value +
                        '&PBWId=0';

            else		// Between 6-8 hours, For OR Only
                strURL = 'PermBreakWaiver_OR.aspx?CId=' + frmPBWList.txtClockId.value +
                        '&BT=3&S=' + frmPBWList.txt6Hrs.value + '&Emp=' + frmPBWList.txtEmpName.value +
                        '&PBWId=0';

            //alert(strURL);

            window.open(strURL, 'PBWForms', 'resizable=no,top=5, left=5, width=750,height=725,scrollbars=yes,menubar=no,toolbar=no');
            //window.open(strURL,'PBWForms','top=5, left=5, width=750,height=560');
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
<body bgcolor="#FFF">
    <form id="frmPBWList" method="post" runat="server">

        <!-- START CONTAINER FLUID -->
        <div class="container-fluid container-fixed-lg">
            <!-- START PANEL -->
            <div class="panel panel-transparent">

                <div class="row" style="text-align: center; color: #069; font-family: 'Monotype Corsiva'; font-weight: bold; font-size: 25px; margin-top: 4px;">
                    Permanent Break Waiver Forms
                </div>

                <div class="blue_line"></div>

                <div class="row">
                    <div class="col-sm-12" style="text-align: center;">
                        <asp:Label ID="lblEmp" runat="server" Width="605px" Font-Names="Microsoft Sans Serif" Font-Size="Small" Font-Bold="true"></asp:Label>
                    </div>
                </div>

                <div class="blue_line"></div>

                <div>
                    <asp:DataGrid ID="grdBW" runat="server" Width="616px" Font-Size="XX-Small" CellPadding="2" BorderStyle="Solid"
                         BorderWidth="1px" BorderColor="#CCCCCC" AutoGenerateColumns="False" HorizontalAlign="Center" Height="12px"
                        Font-Names="Microsoft Sans Serif">
                        <FooterStyle ForeColor="#000066" BackColor="White"></FooterStyle>
                        <SelectedItemStyle Font-Bold="True" ForeColor="White" BackColor="#669999"></SelectedItemStyle>
                        <ItemStyle ForeColor="#000066"></ItemStyle>
                       <HeaderStyle BackColor="#006699" ForeColor="White"/>
                        <Columns>
                            <asp:TemplateColumn Visible="False" HeaderText="BreakType1">
                                <HeaderStyle HorizontalAlign="Center" Width="1%"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                <ItemTemplate>
                                    <asp:Label ID="BreakType1" Text='<%# DataBinder.Eval(Container.DataItem, "BreakType1") %>' runat="server" />
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn Visible="False" HeaderText="PBWId">
                                <HeaderStyle HorizontalAlign="Center" Width="1%"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                <ItemTemplate>
                                    <asp:Label ID="PBWId" Text='<%# DataBinder.Eval(Container.DataItem, "PBWId") %>' runat="server" />
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="Edit">
                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" Width="4%"></ItemStyle>
                                <ItemTemplate>
                                    <a href='javascript:<%# GetPopupScript(DataBinder.Eval(Container.DataItem, "PBWId"), DataBinder.Eval(Container.DataItem, "Status1"), DataBinder.Eval(Container.DataItem, "BreakType1")) %>'>Edit</a>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="Break Type">
                                <HeaderStyle HorizontalAlign="Center" Width="25%"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                <ItemTemplate>
                                    <asp:Label ID="BreakType" Text='<%# DataBinder.Eval(Container.DataItem, "BreakType") %>' runat="server" />
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn Visible="False" HeaderText="Status1">
                                <HeaderStyle HorizontalAlign="Center" Width="0%"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                <ItemTemplate>
                                    <asp:Label ID="Status1" Text='<%# DataBinder.Eval(Container.DataItem, "Status1") %>' runat="server" />
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="Status">
                                <HeaderStyle HorizontalAlign="Center" Width="15%"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                <ItemTemplate>
                                    <asp:Label ID="Status" Text='<%# DataBinder.Eval(Container.DataItem, "Status") %>' runat="server" />
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="Date Effective">
                                <HeaderStyle HorizontalAlign="Center" Width="15%"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                <ItemTemplate>
                                    <asp:Label ID="DateEff" Text='<%# DataBinder.Eval(Container.DataItem, "DateEff") %>' runat="server" />
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="Date Created">
                                <HeaderStyle HorizontalAlign="Center" Width="15%"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                <ItemTemplate>
                                    <asp:Label ID="DateCreated" Text='<%# DataBinder.Eval(Container.DataItem, "DateCreated") %>' runat="server" />
                                </ItemTemplate>
                            </asp:TemplateColumn>
                        </Columns>
                        <PagerStyle Font-Bold="True" HorizontalAlign="Center" ForeColor="#000066" BackColor="White"
                            Mode="NumericPages"></PagerStyle>
                    </asp:DataGrid>
                </div>

                <div class="blue_line"></div>

                <div class="row" style="text-align: center; color: #069; font-weight: bold; font-size: 12px;">
                    To Sign/Rovoke Waiver Form Select Shift Duration Type Below
                </div>
              
                <div class="row" style="text-align:center;margin-top:10px;">
                    <div class="col-sm-12">
                        <div class="">
                            <asp:Button ID="cmd6Hrs" runat="server" Text="Under 6 Hrs" CssClass="btn-form1" OnClientClick="javascript:OpenWin(1);" />
                            <asp:Button ID="cmd1012Hrs" runat="server" Text="Between 10-12 Hrs" CssClass="btn-form1" OnClientClick="javascript:OpenWin(2);" />
                            <asp:Button ID="cmd68Hrs" runat="server" Text="Between 6 - 8 Hrs" CssClass="btn-form1" OnClientClick="javascript:OpenWin(3);" />
                            <asp:Button ID="cmdExit" runat="server" Text="Exit" CssClass="btn-form1" OnClientClick="window.close();" />
                        </div>
                    </div>
                </div>

                <asp:TextBox ID="txtStoreState" runat="server" Style="display: none;"></asp:TextBox>
                <asp:TextBox ID="txtLoadForm" runat="server" Style="display: none;"></asp:TextBox>
                <asp:TextBox ID="txtClockId" runat="server" Style="display: none;"></asp:TextBox>
                <asp:TextBox ID="txt6Hrs" runat="server" Style="display: none;"></asp:TextBox>
                <asp:TextBox ID="txt1012Hrs" runat="server" Style="display: none;"></asp:TextBox>
                <asp:TextBox ID="txtEmpName" runat="server" Style="display: none;"></asp:TextBox>

            </div>
            <!-- END PANEL -->
        </div>
        <!-- END CONTAINER FLUID -->

    </form>


    <div>
    </div>

</body>
</html>
