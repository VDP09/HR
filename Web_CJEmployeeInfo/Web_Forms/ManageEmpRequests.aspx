<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ManageEmpRequests.aspx.vb" MasterPageFile="~/Web_Forms/Site1.Master" Inherits="Web_CJEmployeeInfo.ManageEmpRequests" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .col-sm-21
        {
            width: 14%;
        }

        .col-sm-31
        {
            width: 20%;
        }
    </style>
   <%-- <title>HR Express - Process Requests</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">--%>
    <style>
        .mask
        {
            BEHAVIOR: url("mask_vbs.htc");
        }
    </style>
   

    <form id="form1" runat="server">

        <!-- START CONTAINER FLUID -->
        <div class="container-fluid container-fixed-lg">
            <!-- START PANEL -->
            <div class="panel panel-transparent">

                <div style="display: none;">
                    <asp:Label ID="lblTitle1" runat="server" Width="152px"></asp:Label>
                    <asp:Label ID="lblStore1" runat="server" Width="327px" ForeColor="#3366CC" Font-Names="Arial"
                        Font-Size="X-Small" Font-Bold="True" Height="8px"></asp:Label>
                </div>

                <div class="row">
                    <div class="col-sm-12">
                        <div class="row">
                            <div class="col-sm-2">
                                <div class="panel-title">Request Type :</div>
                            </div>
                            <div class="col-sm-3">
                                <%--<form role="form">--%>
                                <div class="form-group ">
                                    <asp:DropDownList ID="cmbReqType" CssClass="form-control" runat="server" Width="150px"></asp:DropDownList>
                                </div>
                                <%-- </form>--%>
                            </div>
                            <div class="col-sm-2">
                                <asp:RadioButton ID="optDateC" runat="server" Checked="True" GroupName="DateType" Style="font-weight: normal;"></asp:RadioButton>
                                <asp:Label ID="lbldc" runat="server" Text="Date Created"></asp:Label>
                            </div>
                            <div class="col-sm-2">
                                <asp:Label ID="lblstartdate" runat="server" Text="Start Date" Width="90px"></asp:Label>
                            </div>
                            <div class="col-sm-2">
                                <asp:Label ID="lblenddate" runat="server" Text="End Date" Width="90px"></asp:Label>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-12">
                        <div class="row">
                            <div class="col-sm-2">
                                <div class="panel-title">Clock ID :</div>
                            </div>
                            <div class="col-sm-3">
                                <%--<form role="form">--%>
                                <div class="form-group ">
                                    <asp:TextBox ID="txtEmpClockId" CssClass="form-control" runat="server" Width="150px" ClientIDMode="Static"></asp:TextBox>
                                </div>
                                <%-- </form>--%>
                            </div>
                            <div class="col-sm-2">
                                <asp:RadioButton ID="optDateE" runat="server" GroupName="DateType"></asp:RadioButton>
                                <asp:Label ID="lbldeff" runat="server" Text="Date Effective"></asp:Label>
                            </div>
                            <div class="col-sm-2">
                                <asp:TextBox ID="txtSDate" CssClass="form-control" runat="server" Width="100px"></asp:TextBox>
                            </div>
                            <div class="col-sm-2">
                                <asp:TextBox ID="txtEDate" CssClass="form-control" runat="server" Width="100px"></asp:TextBox>
                            </div>
                            <div class="col-sm-2">
                                <asp:Button ID="cmdGetReq" runat="server" CssClass="btn-form1" Text="Get Requests"></asp:Button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-12">
                        <div class="row">
                            <div class="col-sm-2">
                                <div class="panel-title">
                                    <asp:Label ID="lblStore" runat="server">Store :</asp:Label></div>
                            </div>
                            <div class="col-sm-3">
                                <%--<form role="form">--%>
                                <div class="form-group ">
                                    <asp:DropDownList ID="cmbStore" CssClass="form-control" runat="server" Width="150px"></asp:DropDownList>
                                </div>
                                <%-- </form>--%>
                            </div>
                            <div class="col-sm-2">
                                <asp:CheckBox ID="chkApproved" runat="server"></asp:CheckBox>
                                <asp:Label ID="lblAppOnly" runat="server">Approved Only</asp:Label>
                            </div>
                            <div class="col-sm-2">
                                <asp:CheckBox ID="chkManOnly" runat="server"></asp:CheckBox>
                                <asp:Label ID="lblsal" runat="server">Salaried Only</asp:Label>
                            </div>
                            <div class="col-sm-2">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="gray_line"></div>
                </div>

                <div>
                    <%--<asp:DataGrid ID="grdReq" runat="server" Font-Names="Microsoft Sans Serif" Font-Size="XX-Small"
                Height="10px" HorizontalAlign="Center" AutoGenerateColumns="False" BorderColor="#CCCCCC" BorderWidth="1px" BackColor="White" BorderStyle="None"
                AllowPaging="True" CellPadding="2" PageSize="25" AllowSorting="True">
                <FooterStyle ForeColor="#000066" BackColor="White"></FooterStyle>
                <SelectedItemStyle Font-Bold="True" ForeColor="White" BackColor="#669999"></SelectedItemStyle>
                <AlternatingItemStyle BackColor="#E0E0E0"></AlternatingItemStyle>
                <ItemStyle ForeColor="#000066"></ItemStyle>
                <HeaderStyle Font-Size="XX-Small" Font-Bold="True" ForeColor="White" BackColor="#006699"></HeaderStyle>
                <Columns>
                    <asp:TemplateColumn HeaderText="Process">
                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Center" Width="4%"></ItemStyle>
                        <ItemTemplate>
                            <a href='javascript:<%# GetPopupScript(DataBinder.Eval(Container.DataItem, "Id"), DataBinder.Eval(Container.DataItem, "ClockId"), DataBinder.Eval(Container.DataItem, "ReqTypeId"), DataBinder.Eval(Container.DataItem, "EmpType")) %>'>Process</a>
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn Visible="False" HeaderText="Id">
                        <HeaderStyle HorizontalAlign="Center" Width="0%"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                        <ItemTemplate>
                            <asp:Label ID="Id" Text='<%# DataBinder.Eval(Container.DataItem, "Id") %>' runat="server" />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn Visible="False" HeaderText="EmpType">
                        <HeaderStyle HorizontalAlign="Center" Width="0%"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                        <ItemTemplate>
                            <asp:Label ID="EmpType" Text='<%# DataBinder.Eval(Container.DataItem, "EmpType") %>' runat="server" />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn Visible="False" HeaderText="ReqTypeId">
                        <HeaderStyle HorizontalAlign="Center" Width="0%"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                        <ItemTemplate>
                            <asp:Label ID="ReqTypeId" Text='<%# DataBinder.Eval(Container.DataItem, "ReqTypeId") %>' runat="server" />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn SortExpression="ReqType" HeaderText="Request Type">
                        <HeaderStyle HorizontalAlign="Center" Width="14%"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                        <ItemTemplate>
                            <asp:Label ID="ReqType" Text='<%# DataBinder.Eval(Container.DataItem, "ReqType") %>' runat="server" />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn Visible="False" HeaderText="GMApp">
                        <HeaderStyle HorizontalAlign="Center" Width="0%"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                        <ItemTemplate>
                            <asp:Label ID="GMApp" Text='<%# DataBinder.Eval(Container.DataItem, "GMApp") %>' runat="server" />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn SortExpression="ClockId" HeaderText="Clock Id">
                        <HeaderStyle HorizontalAlign="Center" Width="6%"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                        <ItemTemplate>
                            <asp:Label ID="ClockId" Text='<%# DataBinder.Eval(Container.DataItem, "ClockId") %>' runat="server" />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn SortExpression="EmpName" HeaderText="Employee Name">
                        <HeaderStyle HorizontalAlign="Center" Width="17%"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                        <ItemTemplate>
                            <asp:Label ID="EmpName" Text='<%# DataBinder.Eval(Container.DataItem, "EmpName") %>' runat="server" />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn SortExpression="ReqDate1" HeaderText="Request Date">
                        <HeaderStyle HorizontalAlign="Center" Width="11%"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                        <ItemTemplate>
                            <asp:Label ID="ReqDate" Text='<%# DataBinder.Eval(Container.DataItem, "ReqDate") %>' runat="server" />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn Visible="False" HeaderText="Request Date1">
                        <HeaderStyle HorizontalAlign="Center" Width="1%"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                        <ItemTemplate>
                            <asp:Label ID="ReqDate1" Text='<%# DataBinder.Eval(Container.DataItem, "ReqDate1") %>' runat="server" />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn SortExpression="EffDate1" HeaderText="Effective Date">
                        <HeaderStyle HorizontalAlign="Center" Width="8%"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                        <ItemTemplate>
                            <asp:Label ID="EffDate" Text='<%# DataBinder.Eval(Container.DataItem, "EffDate") %>' runat="server" />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn Visible="False" HeaderText="Effective Date1">
                        <HeaderStyle HorizontalAlign="Center" Width="1%"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                        <ItemTemplate>
                            <asp:Label ID="EffDate1" Text='<%# DataBinder.Eval(Container.DataItem, "EffDate1") %>' runat="server" />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn SortExpression="ReqStore" HeaderText="From Store">
                        <HeaderStyle HorizontalAlign="Center" Width="4%"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                        <ItemTemplate>
                            <asp:Label ID="ReqStore" Text='<%# DataBinder.Eval(Container.DataItem, "ReqStore") %>' runat="server" />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn SortExpression="ReqBy" HeaderText="Request By">
                        <HeaderStyle HorizontalAlign="Center" Width="13%"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                        <ItemTemplate>
                            <asp:Label ID="ReqBy" Text='<%# DataBinder.Eval(Container.DataItem, "ReqBy") %>' runat="server" />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn Visible="False" HeaderText="Need Review">
                        <HeaderStyle HorizontalAlign="Center" Width="1%"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                        <ItemTemplate>
                            <asp:Label ID="NeedReview" Text='<%# DataBinder.Eval(Container.DataItem, "NeedReview") %>' runat="server" />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                </Columns>
                <PagerStyle VerticalAlign="Middle" Font-Size="X-Small" Font-Bold="True" HorizontalAlign="Center"
                    ForeColor="#000066" BackColor="White" PageButtonCount="20" Mode="NumericPages"></PagerStyle>
            </asp:DataGrid>--%>
                </div>

                .     
                <div id="tblMoveEditSubmit" runat="server">
                    <asp:Button ID="cmdMoveOA" runat="server" Text="Move OA" />
                    <asp:Button ID="cmdEditPunch" runat="server" Text="Edit Punch" />
                    <asp:Button ID="cmdSubmitPayroll" runat="server" Text="Submit Payroll" />
                </div>

                <div>
                    <asp:TextBox ID="txtSelChanged" runat="server" Style="display: none;"></asp:TextBox>
                    <asp:TextBox ID="txtSort" runat="server" Style="display: none;"></asp:TextBox>
                    <asp:TextBox ID="txtLoadForm" runat="server" Style="display: none;"></asp:TextBox>
                    <asp:TextBox ID="txtManClockId" runat="server" Style="display: none;"></asp:TextBox>
                    <asp:TextBox ID="txtQH" runat="server" Style="display: none;"></asp:TextBox>
                    <asp:TextBox ID="txtSecCode" runat="server" Style="display: none;" Text="1"></asp:TextBox>
                    <asp:TextBox ID="txtUnit" runat="server" Style="display: none;"></asp:TextBox>
                </div>



            </div>
            <!-- END PANEL -->
        </div>
        <!-- END CONTAINER FLUID -->

        <div style="display: none">
            <asp:HyperLink ID="hlinkEnterReq" runat="server" ForeColor="Blue" NavigateUrl="StoreEmployee.aspx">Enter Status Change Requests</asp:HyperLink>
            &nbsp&nbsp&nbsp&nbsp
            <asp:HyperLink ID="hlinkUpdateQuickHires" runat="server" ForeColor="Blue">Update Requests</asp:HyperLink>
            &nbsp&nbsp&nbsp&nbsp
            <asp:HyperLink ID="hlinkProcessReq" runat="server" ForeColor="Blue">Process Requests</asp:HyperLink>
            &nbsp&nbsp&nbsp&nbsp
            <asp:HyperLink ID="hlinkReports" runat="server" ForeColor="Blue">Reports</asp:HyperLink>
            &nbsp&nbsp&nbsp&nbsp
            <asp:LinkButton ID="lbtnHelp" runat="server" ForeColor="Blue" OnClientClick="javascript:DisplayHelpWin();">Help</asp:LinkButton>
        </div>


    </form>
     <script src="../Scripts/WebForms/ManageEmpRequests.aspx.js"></script>

</asp:Content>



