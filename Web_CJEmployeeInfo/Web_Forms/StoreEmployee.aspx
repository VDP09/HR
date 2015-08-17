<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="StoreEmployee.aspx.vb" MasterPageFile="~/Web_Forms/Site1.Master" Inherits="Web_CJEmployeeInfo.StoreEmployee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <title>HR Express - Enter Status Change Requests</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">

    <style>
        .dispaly
        {
            display: none;
            border: none !important;
        }
    </style>

    <script language="javascript">

        function ValidateData() {
            var cmbQuickSearch;
            var txtQuickSearch;
            var cmbJobCode;

            cmbQuickSearch = document.getElementById("<%=cmbQuickSearch.ClientID%>");
            txtQuickSearch = document.getElementById("<%=txtQuickSearch.ClientID%>");
            cmbJobCode = document.getElementById("<%=cmbJobCode.ClientID%>");

            //alert(cmbQuickSearch.options(cmbQuickSearch.selectedIndex).text);
            //alert(cmbJobCode.options(cmbJobCode.selectedIndex).text);
            //alert(txtQuickSearch.value);

            if (isBlank(cmbQuickSearch.options(cmbQuickSearch.selectedIndex).text) ||
                isBlank(txtQuickSearch.value)) {
                if (isBlank(cmbJobCode.options(cmbJobCode.selectedIndex).text)) {
                    alert('Atleast one search criteria is required .. Please check it out');
                    return false;
                }
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

        function ChangeRowColor(row) {
            var grdEmp;

            grdEmp = document.getElementById("<%=grdEmp.ClientID%>");

            var txtClockId = document.getElementById("<%=txtClockId.ClientID%>");
            var txtJobCode = document.getElementById("<%=txtJobCode.ClientID%>");
            var txtEName = document.getElementById("<%=txtEName.ClientID%>");
            var txtAllowEFT = document.getElementById("<%=txtAllowEFT.ClientID%>");
            var txtAllowBW = document.getElementById("<%=txtAllowBW.ClientID%>");
            var txtLeaveEmpType = document.getElementById("<%=txtLeaveEmpType.ClientID%>");
            var txtPBW = document.getElementById("<%=txtPBW.ClientID%>");
            var txtNewHireStatus = document.getElementById("<%=txtNewHireStatus.ClientID%>");


            var rowindex = row.rowIndex;
            //var customerId = row1.cells[0].innerHTML;
            //var rowIndex = row.parentNode.parentNode.parentNode.rowIndex;



            var ClockId = grdEmp.rows[rowindex].cells[0].children[0];
            var JobCode = grdEmp.rows[rowindex].cells[8].children[0];
            var First = grdEmp.rows[rowindex].cells[1].children[0];
            var Last = grdEmp.rows[rowindex].cells[3].children[0];
            var AllowEFT = grdEmp.rows[rowindex].cells[9].children[0];
            var LeaveEmpType = grdEmp.rows[rowindex].cells[10].children[0];
            var HourlyFlag = grdEmp.rows[rowindex].cells[13].children[0];
            var PermBW = grdEmp.rows[rowindex].cells[12].children[0];
            var NewHireStatus = grdEmp.rows[rowindex].cells[11].children[0];

            //#ffffff

            for (var i = 1; i <= (grdEmp.rows.length - 1) ; i++) {
                //grdEmp.style.backgroundColor='White';
                grdEmp.rows(i).style.color = 'gray';
            }

            row.style.color = "Red";
            //row.backgroundColor = "Red";
            //row1.DefaultCellStyle.backgroundColor = 'Red';
            //row.style.ChangeRowColor = 'Red';
            var row1 = row.parentNode.parentNode
            //grdEmp.rows[rowindex].style.ChangeRowColor = 'Red';

            txtClockId.value = ClockId.innerHTML;
            txtJobCode.value = JobCode.innerHTML;
            //txtEName.value = ClockId.innerHTML & "-" & Replace(First.innerHTML, "'", "") & Replace(Last.innerHTML, "'", "");
            txtEName.value = ClockId.innerHTML + "-" + First.innerHTML + Last.innerHTML;
            txtAllowEFT.value = AllowEFT.innerHTML;
            txtLeaveEmpType.value = LeaveEmpType.innerHTML;
            txtAllowBW.value = HourlyFlag.innerHTML;
            txtPBW.value = PermBW.innerHTML;
            txtNewHireStatus.value = NewHireStatus.innerHTML;


        }

        function OpenNewWin(i) {
            var strURL;

            //alert(txtStore.value);
            //return false;

            var txtStore;

            txtStore = document.getElementById("<%=txtStore.ClientID%>");
            var txtNewHireStatus = document.getElementById("<%=txtNewHireStatus.ClientID%>");
            var txtUnit = document.getElementById("<%=txtUnit.ClientID%>");
            var txtManClockId = document.getElementById("<%=txtManClockId.ClientID%>");
            var txtUnit = document.getElementById("<%=txtUnit.ClientID%>");
            var txtSecCode = document.getElementById("<%=txtSecCode.ClientID%>");
            var txtClockId = document.getElementById("<%=txtClockId.ClientID%>");
            var txtStoreState = document.getElementById("<%=txtStoreState.ClientID%>");
            var txtPBW = document.getElementById("<%=txtPBW.ClientID%>");
            var txtEName = document.getElementById("<%=txtEName.ClientID%>");
            var txtLeaveEmpType = document.getElementById("<%=txtLeaveEmpType.ClientID%>");
            var txtAllowBW = document.getElementById("<%=txtAllowBW.ClientID%>");

            if (txtNewHireStatus.value == 1 && i != 8 && i != 16) {
                alert('Selected employee is a pending new hire, this request can not be created.');
                return 0;
            }

            if (i == 0)	//New Hire
            {
                strURL = 'EmpHire.aspx?Id=0&Unit=' + txtStore.value;
                window.open(strURL, '11', 'resizable=no,top=5, left=10, width=800,height=680,scrollbars=yes,menubar=no,toolbar=no');
                //  window.open("",strURL)
            }
            else if (i == 6)	// Quick Hire
            {
                strURL = 'EmpQuickHire.aspx?Unit=' + txtStore.value;
                window.open(strURL, '17', 'resizable=no,top=5, left=10, width=685,height=450,scrollbars=yes,menubar=no,toolbar=no');
            }

            else if (i == 7)	//Edit Punch Window
            {
                strURL = 'EmpEditPunch.aspx?Unit=' + txtUnit.value +
                    '&ManCId=' + txtManClockId.value +
                    '&SC=' + txtSecCode.value;

                window.open(strURL, '16', 'resizable=no,top=5, left=10, width=810,height=650,scrollbars=yes,menubar=no,toolbar=no');
            }

            else if (i == 9)	//Submit Payroll window
            {
                strURL = 'SubmitPayroll.aspx?Unit=' + txtUnit.value +
                    '&ManCId=' + txtManClockId.value +
                    '&SC=' + txtSecCode.value;

                window.open(strURL, 'wSubmitPrl', 'resizable=no,top=5, left=10, width=680,height=600,scrollbars=yes,menubar=no,toolbar=no');
            }

            else if (i == 10)	//Break Waiver window
            {
                strURL = 'BreakWaiver.aspx?Unit=' + txtUnit.value +
                    '&ManCId=' + txtManClockId.value;

                window.open(strURL, 'BW', 'resizable=no,top=5, left=10, width=780,height=550,scrollbars=yes,menubar=no,toolbar=no');
            }

            else if (txtClockId.value == '') {
                alert('Please select employee from the list');
                return false;
            }

            if (i == 1) {
                if (CheckSecurity(3)) {
                    strURL = 'ChangeDepRate.aspx?Id=0&CId=' + txtClockId.value + '&FT=0';
                    window.open(strURL, '12', 'resizable=no,top=5, left=10, width=800,height=650,scrollbars=yes,menubar=no,toolbar=no');
                }
                else
                    alert('You are not authorized to change Pay Rate/Department of the selected employee .. Please check it out');

                /*
                var ParmA;
                var ParmB;
                var ParmC;
                var MyArgs = new Array(ParmA, ParmB, ParmC);
                var WinSettings = "center:yes;resizable:no;dialogHeight:520px;dialogWidth:680px";
                var MyArgs = window.showModalDialog(strURL, '', WinSettings);
                */
            }
            else if (i == 2) //Name Add
            {
                strURL = 'ChangeNameAdd.aspx?Id=0&CId=' + txtClockId.value;
                window.open(strURL, '13', 'resizable=no,top=5, left=10, width=845,height=460,scrollbars=yes,menubar=no,toolbar=no');  //width:680px
            }

            else if (i == 3) // Benefit
            {
                strURL = 'ChangeBenefit.aspx?CId=' + txtClockId.value;
                window.open(strURL, '14', 'resizable=no,top=5, left=10, width=680,height=530,scrollbars=yes,menubar=no,toolbar=no');
            }

            else if (i == 4) // Dep/Rate
            {
                if (CheckSecurity(4)) {
                    strURL = 'ChangeDepRate.aspx?Id=0&CId=' + txtClockId.value + '&FT=1';
                    window.open(strURL, '15', 'resizable=no,top=5, left=10, width=800,height=650,scrollbars=yes,menubar=no,toolbar=no');
                }
                else
                    alert('You are not authorized to transfer selected employee .. Please check it out');
            }

            else if (i == 5)	//Seperation
            {
                if (CheckSecurity(5)) {
                    strURL = 'EmpSeperation.aspx?Id=0&CId=' + txtClockId.value;
                    window.open(strURL, '16', 'resizable=no,top=5, left=10, width=820,height=700,scrollbars=yes,menubar=no,toolbar=no');
                }
                else
                    alert('You are not authorized to separate selected employee .. Please check it out');
            }

            else if (i == 8)	// New Shift Window
            {
                var PBW;
                if (txtStoreState.value == 'CA')
                    PBW = txtPBW.value;
                else
                    PBW = 2;

                txtURL = 'NewShift.aspx?ClockId=' + txtClockId.value + '&EName=' + txtEName.value + '&MCId=' + txtManClockId.value + '&Unit=' + txtUnit.value + '&AddNew=0&PBW=' + PBW;
                window.open(txtURL, 'wNewShift', 'resizable=no,top=5, left=10, width=670,height=400,scrollbars=yes,menubar=no,toolbar=no');
            }

            else if (i == 11)	// Change W4
            {
                strURL = 'ChangeW4.aspx?Id=0&CId=' + txtClockId.value;
                window.open(strURL, '21', 'resizable=no,top=5, left=10, width=680,height=550,scrollbars=yes,menubar=no,toolbar=no');
            }

            else if (i == 12) // Change I9
            {
                strURL = 'ChangeI9.aspx?Id=0&CId=' + txtClockId.value;
                window.open(strURL, '22', 'resizable=no,top=5, left=10, width=680,height=460,scrollbars=yes,menubar=no,toolbar=no');
            }

            else if (i == 13)	// Change EFT
            {
                if (frmStoreEmp.txtAllowEFT.value == 1) {
                    strURL = 'ChangeEFT.aspx?Id=0&CId=' + txtClockId.value;
                    window.open(strURL, '23', 'resizable=no,top=5, left=10, width=680,height=690,scrollbars=yes,menubar=no,toolbar=no');
                }
                else {
                    alert('Direct Deposit is not allowed for this employee');
                    return false;
                }
            }

            else if (i == 14)	// Change Misc.
            {
                strURL = 'MiscChanges.aspx?Id=0&CId=' + txtClockId.value;
                window.open(strURL, '24', 'resizable=no,top=5, left=10, width=680,height=550,scrollbars=yes,menubar=no,toolbar=no');
            }

            else if (i == 15)	// Leave Request
            {
                strURL = 'LeaveRequest.aspx?LRId=0&HR=1&ClockId=' + txtClockId.value + '&MId=' + txtManClockId.value + '&Unit=' + txtUnit.value + '&ET=' + txtLeaveEmpType.value;
                window.open(strURL, 'LeaveReq', 'resizable=no,top=5, left=10, width=685,height=550,scrollbars=yes,menubar=no,toolbar=no');
            }

            else if (i == 16)	// Permanent Break Waiver
            {
                if (txtAllowBW.value == 1) {
                    strURL = 'PermBreakWaiverList.aspx?CId=' + txtClockId.value + '&US=' + txtStoreState.value;
                    window.open(strURL, 'PBW', 'resizable=no,top=5, left=10, width=670,height=350,scrollbars=yes,menubar=no,toolbar=no');
                }
                else {
                    alert('Permanent Break Waiver forms are only for HOURLY employees ..');
                    return false;
                }
            }

            else if (i == 17)	// Comp Card
            {
                strURL = 'CompCardList.aspx?CId=' + txtClockId.value + '&MId=' + txtManClockId.value;
                //alert(strURL);
                window.open(strURL, 'CompCard', 'resizable=no,top=5, left=10, width=645,height=300,scrollbars=yes,menubar=no,toolbar=no');
            }

        }


        function CheckSecurity(i) {
            //Based on certain job codes, check if the person logged in
            //is allowed for the operation

            var intSecCode;
            var intJobCode;

            var txtSecCode = document.getElementById("<%=txtSecCode.ClientID%>");
            var txtJobCode = document.getElementById("<%=txtJobCode.ClientID%>");

            intSecCode = txtSecCode.value;
            intJobCode = txtJobCode.value;

            //Only allow main office OA to do pay rate, transfer and separations
            //for store OAs (Job code 80) & Lead cook - 51
            if (intJobCode == 1) {
                if (i == 5)	//Separations, allow everybody
                    return true;
                else
                    if (intSecCode == 8 || intSecCode == 9)
                        return true;
                    else
                        return false;
            }

                //Only allow RMs and Main Office OA to change pay rate, transfer &
                //separations of all store managers				
            else if (intJobCode == 2) {
                if (intSecCode == 10 || intSecCode == 8 || intSecCode == 9)
                    return true;
                else
                    return false;
            }
            else
                return true;
        }


        function ClickSearch(i) {
            //alert('rupesh');

            var cmbJobCode;
            var cmbQuickSearch;
            var txtQuickSearch;

            //cmbJobCode = document.getElementById("cmbJobCode");
            cmbJobCode = document.getElementById("<%=cmbJobCode.ClientID%>");
            cmbQuickSearch = document.getElementById("<%=cmbQuickSearch.ClientID%>");
            txtQuickSearch = document.getElementById("<%=txtQuickSearch.ClientID%>");

            if (i == 2)	// Department is selected
            {
                if (!isBlank(cmbJobCode.options(cmbJobCode.selectedIndex).text)) {
                    cmbQuickSearch.selectedIndex = '';
                    txtQuickSearch.value = '';
                }
            }

            else if (i == 1) {
                if (!isBlank(cmbQuickSearch.options(cmbQuickSearch.selectedIndex).text)) {
                    cmbJobCode.selectedIndex = '';
                }
            }
        }

        function DisplayHelpWin() {
            var strURL;

            //alert('Rupesh');
            strURL = 'CJ HR Express_UG.htm';
            window.open(strURL, '20', 'resizable=no,top=5, left=5, width=750,height=600,scrollbars=yes,menubar=no,toolbar=no');
        }

    </script>

    <form id="frmStoreEmp" runat="server">

        <!-- START CONTAINER FLUID -->
        <div class="container-fluid container-fixed-lg">     
                <%--<asp:Label ID="lblTitle" runat="server" Text="Enter Status Change Requests"></asp:Label>
                <br />--%>
            <asp:Label ID="Label1" runat="server" Text=" Enter Status Change Requests" Style="padding-left: 200px; display: none;"></asp:Label>
            <asp:Label ID="lblStore" runat="server" Text="" Style="padding-left: 485px; display: none;"></asp:Label>
            <!-- START PANEL -->
            <div class="panel panel-transparent">

                <div class="row">
                    <div class="col-sm-6">
                        <div class="row">
                            <div class="col-sm-4">
                                <div class="panel-title">Enter Search Criteria </div>
                            </div>
                            <div class="col-sm-4">
                                <%--<form role="form">--%>
                                <div class="form-group ">
                                    <asp:DropDownList ID="cmbQuickSearch" CssClass="form-control" runat="server" Width="126px"></asp:DropDownList>
                                </div>
                                <%-- </form>--%>
                            </div>
                            <div class="col-sm-4">
                                <asp:TextBox ID="txtQuickSearch" CssClass="form-control" runat="server" Width="120px"></asp:TextBox>
                            </div>
                        </div>

                    </div>
                    <div class="col-sm-6">
                        <div class="row">
                            <div class="col-sm-1">
                                <span class="orcrcle">or</span>
                            </div>
                            <div class="col-sm-4">
                                <div class="panel-title">Select Department </div>
                            </div>
                            <div class="col-sm-6">
                                <form role="form">
                                    <div class="form-group ">
                                        <asp:DropDownList ID="cmbJobCode" CssClass="form-control" data-init-plugin="select2" runat="server"></asp:DropDownList>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-12">
                        <div class="btngroup">
                            <asp:Button ID="cmdFindEmp" runat="server" CssClass="btn-form" Text="Get Employees"></asp:Button>
                            <INPUT id="cmdNewEmp" onclick="OpenNewWin(0);" type="button" class="btn-form" value="New Hire / ReHire" name="cmdNewEmp" runat="server">
                            <%--<asp:Button ID="cmdNewEmp" runat="server" CssClass="btn-form" Text="New Hire / ReHire" OnClientClick="javascript:OpenNewWin(0);" />--%>
                            <INPUT id="cmdQHire" onclick="OpenNewWin(6);" class="btn-form" type="button" value="Quick Hire" name="cmdQHire" runat="server">
                            <%--<asp:Button ID="cmdQHire" runat="server" CssClass="btn-form" Text="Quick Hire" OnClientClick="javascript:OpenNewWin(6);" />--%>
                            <%--<asp:Button ID="cmdEditPunch" runat="server" CssClass="btn-form" Text="Edit Punch" OnClientClick="javascript:OpenNewWin(7);" />
                            <asp:Button ID="cmdBreakWaiver" runat="server" CssClass="btn-form" Text="Break Waiver" OnClientClick="javascript:OpenNewWin(10);" />
                            <asp:Button ID="cmdSubmitPayroll" runat="server" CssClass="btn-form" Text="Submit Payroll" OnClientClick="javascript:OpenNewWin(9);" />--%>
                            <INPUT id="cmdEditPunch" onclick="OpenNewWin(7);" type="button" class="btn-form" value="Edit Punch" name="cmdEditPunch" runat="server">
                            <INPUT id="cmdBreakWaiver" onclick="OpenNewWin(10);" class="btn-form" type="button" value="Break Waiver" name="cmdBreakWaiver" runat="server">
                             <INPUT id="cmdSubmitPayroll" onclick="OpenNewWin(9);" class="btn-form" type="button" value="Submit Payroll" name="cmdSubmitPayroll" runat="server">
                        </div>
                    </div>
                </div>

                <asp:TextBox ID="txtClockId" runat="server" Style="display: none;"></asp:TextBox>
                <asp:TextBox ID="txtStore" runat="server" Style="display: none;"></asp:TextBox>
                <asp:TextBox ID="txtUnit" runat="server" Style="display: none;"></asp:TextBox>
                <asp:TextBox ID="txtSecCode" runat="server" Style="display: none;"></asp:TextBox>
                <asp:TextBox ID="txtJobCode" runat="server" Style="display: none;"></asp:TextBox>
                <asp:TextBox ID="txtManClockId" runat="server" Style="display: none;"></asp:TextBox>
                <asp:TextBox ID="txtEName" runat="server" Style="display: none;"></asp:TextBox>
                <asp:TextBox ID="txtAllowEFT" runat="server" Style="display: none;"></asp:TextBox>
                <asp:TextBox ID="txtLeaveEmpType" runat="server" Style="display: none;"></asp:TextBox>
                <asp:TextBox ID="txtAllowBW" runat="server" Style="display: none;"></asp:TextBox>
                <asp:TextBox ID="txtStoreState" runat="server" Style="display: none;"></asp:TextBox>
                <asp:TextBox ID="txtPBW" runat="server" Style="display: none;"></asp:TextBox>
                <asp:TextBox ID="txtNewHireStatus" runat="server" Style="display: none;"></asp:TextBox>


                <div class="panel-heading">
                    <div class="panel-title">
                        <%-- Table With Footer--%>
                    </div>
                    <div class="clearfix"></div>
                </div>
                <div class="panel-body">
                    <asp:DataGrid ID="grdEmp" runat="server" AutoGenerateColumns="False" AllowPaging="True" CssClass="table table-hover demo-table-dynamic" BorderStyle="None">
                        <Columns>
                            <asp:TemplateColumn HeaderText="Clock Id" HeaderStyle-CssClass="Header">
                                <ItemTemplate>
                                    <asp:Label ID="ClockId" Text='<%# DataBinder.Eval(Container.DataItem, "ClockId") %>' runat="server" />
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="First Name">
                                <ItemTemplate>
                                    <asp:Label ID="First" Text='<%# DataBinder.Eval(Container.DataItem, "First") %>' runat="server" />
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="Middle Name">
                                <ItemTemplate>
                                    <asp:Label ID="Middle" Text='<%# DataBinder.Eval(Container.DataItem, "Middle") %>' runat="server" />
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="Last Name">
                                <ItemTemplate>
                                    <asp:Label ID="Last" Text='<%# DataBinder.Eval(Container.DataItem, "Last") %>' runat="server" />
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="Store">
                                <ItemTemplate>
                                    <asp:Label ID="Store" Text='<%# DataBinder.Eval(Container.DataItem, "Store") %>' runat="server" />
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="Primary Department">
                                <ItemTemplate>
                                    <asp:Label ID="Department" Text='<%# DataBinder.Eval(Container.DataItem, "Department") %>' runat="server" />
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="Gender">
                                <ItemTemplate>
                                    <asp:Label ID="Gender" Text='<%# DataBinder.Eval(Container.DataItem, "Gender") %>' runat="server" />
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="Hire Date">
                                <ItemTemplate>
                                    <asp:Label ID="DateHire" Text='<%# DataBinder.Eval(Container.DataItem, "DateHire") %>' runat="server" />
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn ItemStyle-CssClass="dispaly" HeaderStyle-CssClass="dispaly"><%--Visible="False" HeaderText="Job Code"--%>
                                <ItemTemplate>
                                    <asp:Label ID="JobCode" Text='<%# DataBinder.Eval(Container.DataItem, "JobCode") %>' runat="server" Width="0px" Style="display: none;" />
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn ItemStyle-CssClass="dispaly" HeaderStyle-CssClass="dispaly"><%--Visible="False" HeaderText="Allow EFT"--%>
                                <ItemTemplate>
                                    <asp:Label ID="AllowEFT" Text='<%# DataBinder.Eval(Container.DataItem, "AllowEFT") %>' runat="server" Width="0px" Style="display: none;" />
                                </ItemTemplate>
                                <ItemStyle Width="0%" />
                            </asp:TemplateColumn>
                            <asp:TemplateColumn ItemStyle-CssClass="dispaly" HeaderStyle-CssClass="dispaly"><%--Visible="False" HeaderText="LeaveEmpType" --%>
                                <ItemTemplate>
                                    <asp:Label ID="LeaveEmpType" Text='<%# DataBinder.Eval(Container.DataItem, "LeaveEmpType") %>' Width="0px" runat="server" Style="display: none;" />
                                </ItemTemplate>
                                <ItemStyle Width="0%" />
                            </asp:TemplateColumn>
                            <asp:TemplateColumn ItemStyle-CssClass="dispaly" HeaderStyle-CssClass="dispaly"><%-- Visible="False" HeaderText="NewHireStatus"--%>
                                <ItemTemplate>
                                    <asp:Label ID="NewHireStatus" Text='<%# DataBinder.Eval(Container.DataItem, "NewHireStatus") %>' Width="0px" runat="server" Style="display: none;" />
                                </ItemTemplate>
                                <ItemStyle Width="0%" />
                            </asp:TemplateColumn>
                            <asp:TemplateColumn ItemStyle-CssClass="dispaly" HeaderStyle-CssClass="dispaly"><%--Visible="False" HeaderText="PermBW" --%>
                                <ItemTemplate>
                                    <asp:Label ID="PermBW" Text='<%# DataBinder.Eval(Container.DataItem, "PermBW")%>' runat="server" Width="0px" Style="display: none;" />
                                </ItemTemplate>
                                <ItemStyle Width="0%" />
                            </asp:TemplateColumn>
                            <asp:TemplateColumn ItemStyle-CssClass="dispaly" HeaderStyle-CssClass="dispaly"><%-- Visible="False" HeaderText="HourlyFlag"--%>
                                <ItemTemplate>
                                    <asp:Label ID="HourlyFlag" Text='<%# DataBinder.Eval(Container.DataItem, "HourlyFlag")%>' runat="server" Width="0px" Style="display: none;" />
                                </ItemTemplate>
                                <ItemStyle Width="0%" />
                            </asp:TemplateColumn>
                        </Columns>
                        <PagerStyle VerticalAlign="Middle" Font-Size="X-Small" Font-Bold="True" HorizontalAlign="Center"
                            ForeColor="#000066" BackColor="White" PageButtonCount="20" Mode="NumericPages"></PagerStyle>
                    </asp:DataGrid>
                </div>

                <div id="tblButtons" runat="server">
                    <div style="text-align: center; font-weight: bold;">
                        <br />
                        Select Employee above and click any of following to change status
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="btngroup">   
                                <input id="cmdPayChange" type="button" name="cmdPayChange" style="width:166px;" value="Change Pay / Dept" class="btn-form" runat="server" onclick="OpenNewWin(1);"/>       
                                <input id="cmdNameAdd" type="button" name="cmdNameAdd" style="width:166px;" value="Change Name / Add" class="btn-form" runat="server" onclick="OpenNewWin(2);"/>       
                                <input id="cmdTransEmp" type="button" name="cmdTransEmp" style="width:166px;" value="Transfer Employee" class="btn-form" runat="server" onclick="OpenNewWin(4);"/>       
                                <input id="cmdSepEmp" type="button" name="cmdSepEmp" style="width:166px;" value="Separate Employee" class="btn-form" runat="server" onclick="OpenNewWin(5);"/>       
                                
                                <%--<asp:Button ID="cmdPayChange" runat="server" CssClass="btn-form" Text="Change Pay / Dept" Width="166px" OnClientClick="javascript:OpenNewWin(1);" />--%>
                                <%--<asp:Button ID="cmdNameAdd" runat="server" CssClass="btn-form" Text="Change Name / Add" Width="166px" OnClientClick="javascript:OpenNewWin(2);" />
                                <asp:Button ID="cmdTransEmp" runat="server" CssClass="btn-form" Text="Transfer Employee" Width="166px" OnClientClick="javascript:OpenNewWin(4);" />
                                <asp:Button ID="cmdSepEmp" runat="server" CssClass="btn-form" Text="Separate Employee" Width="166px" OnClientClick="javascript:OpenNewWin(5);" />--%>
                                <br />

                                <input id="cmdPBW" type="button" name="cmdPBW" style="width:166px;" value="Perm. Break Waiver" class="btn-form" runat="server" onclick="OpenNewWin(16);"/>       
                                <input id="cmdAddNewShift" type="button" name="cmdAddNewShift" style="width:166px;" value="Add New Shift" class="btn-form" runat="server" onclick="OpenNewWin(8);"/>       
                                <input id="cmdChangeW4" type="button" name="cmdChangeW4" style="width:166px;" value="Change W4" class="btn-form" runat="server" onclick="OpenNewWin(11);"/>       
                                <input id="cmdChangeI9" type="button" name="cmdChangeI9" style="width:166px;" value="Change I-9" class="btn-form" runat="server" onclick="OpenNewWin(12);"/>       

                                <%--<asp:Button ID="cmdPBW" runat="server" CssClass="btn-form" Text="Perm. Break Waiver" Width="166px" OnClientClick="javascript:OpenNewWin(16);" />
                                <asp:Button ID="cmdAddNewShift" runat="server" CssClass="btn-form" Text="Add New Shift" Width="166px" OnClientClick="javascript:OpenNewWin(8);" />
                                <asp:Button ID="cmdChangeW4" runat="server" CssClass="btn-form" Text="Change W4" Width="166px" OnClientClick="javascript:OpenNewWin(11);" />
                                <asp:Button ID="cmdChangeI9" runat="server" CssClass="btn-form" Text="Change I-9" Width="166px" OnClientClick="javascript:OpenNewWin(12);" />--%>
                                <br />
                                <asp:Button ID="cmdChangeEFT" runat="server" CssClass="btn-form" Text="Change Direct Deposit" Width="166px" OnClientClick="javascript:OpenNewWin(13);" />
                                <asp:Button ID="cmdChangeMisc" runat="server" CssClass="btn-form" Text="Change Misc." Width="166px" OnClientClick="javascript:OpenNewWin(14);" />
                                <asp:Button ID="cmdLeaveReq" runat="server" CssClass="btn-form" Text="Leave Request" Width="166px" OnClientClick="javascript:OpenNewWin(15);" />
                                <asp:Button ID="cmdCompCard" runat="server" CssClass="btn-form" Text="Comp Card" Width="166px" OnClientClick="javascript:OpenNewWin(17);" />
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <!-- END PANEL -->


        </div>
        <!-- END CONTAINER FLUID -->

        <div style="display: none;">
            <asp:HyperLink ID="hlinkEnterReq" runat="server" ForeColor="Blue">Enter Status Change Requests</asp:HyperLink>
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

</asp:Content>
