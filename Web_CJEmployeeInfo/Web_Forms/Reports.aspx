<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Web_Forms/Site1.Master" CodeBehind="Reports.aspx.vb" Inherits="Web_CJEmployeeInfo.Reports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .line
        {
            height: 1px;
            width: 100%;
            float: left;
            background-color: lightgray;
            margin: 20px 0px;
        }
    </style>
    <script language="javascript">

        function ViewReport() {
            var txtSDate;
            var txtEDate;
            var optDateCreated;
            var optDateEff;
            var optDatePosted;
            var strURL;
            var strReportName;
            var optReqHistory;
            var optNewHire;
            var optDeptPayChanges;
            var optSep;
            var optTransfers;
            var optNameAdd;
            var optSepDetails;
            var optEmpHistory;

            var optW4;
            var optI9;
            var optEFT;
            var optMisc;
            var optFindEmp;

            var txtEmpClockId;
            var intReport;
            var lstStore;
            var chkMan;
            var intClockId;
            var cmbApp;
            var cmbPost;

            var strSDate;
            var strEDate;

            optReqHistory = document.getElementById("optReqHistory");
            optNewHire = document.getElementById("optNewHire");
            optDeptPayChanges = document.getElementById("optDeptPayChanges");
            optSep = document.getElementById("optSep");
            optTransfers = document.getElementById("optTransfers");
            optNameAdd = document.getElementById("optNameAdd");
            optSepDetails = document.getElementById("optSepDetails");
            optEmpHistory = document.getElementById("optEmpHistory");

            optW4 = document.getElementById("optW4");
            optI9 = document.getElementById("optI9");
            optEFT = document.getElementById("optEFT");
            optMisc = document.getElementById("optMisc");
            optFindEmp = document.getElementById("optFindEmp");

            txtSDate = document.getElementById("txtSDate");
            txtEDate = document.getElementById("txtEDate");
            txtEmpClockId = document.getElementById("txtEmpClockId");

            optDateCreated = document.getElementById("optDateCreated");
            optDateEff = document.getElementById("optDateEff");
            optDatePosted = document.getElementById("optDatePosted");

            lstStore = document.getElementById("lstStore");
            chkMan = document.getElementById("chkMan");

            cmbApp = document.getElementById("cmbApp");
            cmbPost = document.getElementById("cmbPost");


            //Check ClockId
            if (!optFindEmp.checked) {
                if (!isBlank(txtEmpClockId.value)) {
                    if (txtEmpClockId.value - 0 != txtEmpClockId.value) {
                        alert('Invalid Clock Id .. Please check it out');
                        return false;
                    }
                    else
                        intClockId = txtEmpClockId.value;
                }
                else
                    intClockId = 0;
            }


            var strStoreList;
            strStoreList = '';
            for (var i = 0; i < lstStore.options.length; i++) {
                if (lstStore.options[i].selected) {
                    if (lstStore.options[i].value == 0) {
                        strStoreList = '';
                        break;
                    }

                    if (strStoreList == '')
                        strStoreList = lstStore.options[i].value;
                    else
                        strStoreList = strStoreList + ', ' + lstStore.options[i].value;
                }
            }

            //alert(strStoreList);
            //return false;

            if (optSepDetails.checked || optEmpHistory.checked ||
                optFindEmp.checked)
                intReport = 1;
            else
                intReport = 0;

            if (intReport == 0) {
                if (isBlank(txtSDate.value) && isBlank(txtEDate.value) &&
                    intClockId == 0) {
                    alert('Following are required fields .. Please check it out' +
                        '\n' + '\n' + 'Start Date' + '\n' + 'End Date' + '\n' + '\n' +
                        'OR' + '\n' + 'Clock Id');
                    return false;
                }
                else if (!isBlank(txtSDate.value) && isBlank(txtEDate.value)) {
                    var d1;
                    var intDay;
                    var intMonth;
                    var intYear;

                    d1 = new Date(txtSDate.value);
                    intDay = d1.getDate();
                    intMonth = d1.getMonth() + 1; // It always returns 0-11
                    intYear = d1.getFullYear();

                    if (intDay >= 16) {
                        if (intMonth == 4 || intMonth == 6 || intMonth == 9 ||
                            intMonth == 11)
                            txtEDate.value = intMonth + '/30/' + intYear;

                        else if (intMonth == 2)
                            if (intYear % 4 == 0)
                                txtEDate.value = '2/29/' + intYear;
                            else
                                txtEDate.value = '2/28/' + intYear;
                        else
                            txtEDate.value = intMonth + '/31/' + intYear;
                    }
                    else
                        txtEDate.value = intMonth + '/15/' + intYear;
                }
                else if (isBlank(txtSDate.value) && !isBlank(txtEDate.value)) {
                    txtSDate.value = '1/1/1900';
                }

                //alert(optReqHistory.checked);

                //Assign default date range if they are blank and 
                //clock id is populated
                if (isBlank(txtSDate.value) && isBlank(txtEDate.value)) {
                    strSDate = '1/1/1900';
                    strEDate = '12/31/2050';
                }
                else {
                    strSDate = txtSDate.value;
                    strEDate = txtEDate.value;
                }

                if (optReqHistory.checked)
                    strReportName = 'EmpRequestList';
                else if (optNewHire.checked)
                    strReportName = 'EmpHire';
                else if (optNameAdd.checked)
                    strReportName = 'NameAddChanges';
                else if (optDeptPayChanges.checked)
                    strReportName = 'PayDeptChanges';
                else if (optTransfers.checked)
                    strReportName = 'EmpTransfers';
                else if (optSep.checked)
                    strReportName = 'EmpSeparations';
                else if (optW4.checked)
                    strReportName = 'W4Changes';
                else if (optI9.checked)
                    strReportName = 'I9Changes';
                else if (optEFT.checked)
                    strReportName = 'EFTChanges';
                else if (optMisc.checked)
                    strReportName = 'MiscChanges';


                strURL = 'http://Goldmine/reportserver?/HRExpress/' + strReportName +
                        '&rs:Command=Render' +
                        '&rc:Zoom=100&rc:Parameters=false' +
                        '&StartDate=' + strSDate +
                        '&EndDate=' + strEDate;

                //alert(optDateCreated.checked);

                if (optDateCreated.checked)
                    strURL = strURL + '&DateType=Cre';
                else if (optDatePosted.checked)
                    strURL = strURL + '&DateType=Pos';
                else
                    strURL = strURL + '&DateType=Eff';

                strURL = strURL + '&ClockId=' + frmReport.txtClockId.value
                                + '&SecCode=' + frmReport.txtSecCode.value
                                + '&StoreList=' + strStoreList
                                + '&ManFlag=' + chkMan.checked
                                + '&EmpClockId=' + intClockId
                                + '&AppStatus=' + cmbApp.options(cmbApp.selectedIndex).value
                                + '&PostStatus=' + cmbPost.options(cmbPost.selectedIndex).value;

                //alert(strURL);
                //return false;

                window.open(strURL, 'www', 'resizable=yes,top=10, left=10, width=750,height=550,scrollbars=yes,menubar=no,toolbar=no');
            }

            else {
                if (optFindEmp.checked && isBlank(txtEmpClockId.value)) {
                    alert('Following is required field .. Please check it out' +
                        '\n' + '\n' + 'Clock Id/Emp Name');
                    return false;
                }

                else {
                    if (intClockId == 0) {
                        alert('Following is required field .. Please check it out' +
                            '\n' + '\n' + 'Clock Id');
                        return false;
                    }
                }

                if (optSepDetails.checked)	//Separation Details
                {
                    strURL = 'EmpSepList.aspx?CId=' + intClockId;
                    window.open(strURL, 'wSepDetails', 'resizable=yes,top=10, left=10, width=650,height=350,scrollbars=yes,menubar=no,toolbar=no');
                }

                else if (optFindEmp.checked)	//Find Employee
                {
                    strURL = 'http://Goldmine/reportserver?/HRExpress/FindEmployee' +
                            '&rs:Command=Render' +
                            '&rc:Zoom=100&rc:Parameters=false' +
                            '&Item=' + frmReport.txtEmpClockId.value;

                    window.open(strURL, 'wFindEmp', 'resizable=yes,top=10, left=10, width=750,height=550,scrollbars=yes,,menubar=no,toolbar=no');
                }

                else		//Employee History
                {
                    strURL = 'http://Goldmine/reportserver?/HRExpress/EmpHistory' +
                            '&rs:Command=Render' +
                            '&rc:Zoom=100&rc:Parameters=false' +
                            '&ClockId=' + frmReport.txtClockId.value +
                            '&EmpClockId=' + intClockId +
                            '&SecCode=' + frmReport.txtSecCode.value;

                    window.open(strURL, 'wEmpHistory', 'resizable=yes,top=10, left=10, width=750,height=550,scrollbars=yes,,menubar=no,toolbar=no');
                }
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

        function DisplayHelpWin() {
            var strURL;

            //alert('Rupesh');
            strURL = 'CJ HR Express_UG.htm';
            window.open(strURL, '20', 'resizable=no,top=5, left=5, width=750,height=600,scrollbars=yes,,menubar=no,toolbar=no');
        }

        function ChangeLabel() {
            var optFindEmp;
            optFindEmp = document.getElementById("optFindEmp");

            if (optFindEmp.checked)
                document.getElementById("lblClockId").innerHTML = 'ClockId / Name / SSN';
            else
                document.getElementById("lblClockId").innerHTML = 'Clock Id';
        }

    </script>

    <form id="frmReport" method="post" runat="server">
        <!-- START CONTAINER FLUID -->
        <div class="container-fluid container-fixed-lg">
            <!-- START PANEL -->
            <div class="panel panel-transparent">
                <div class="row">
                    <div style="float: left;">
                        <div class="col-sm-12">
                            <div style="color: #069; font-size: large; font-weight: bold;text-decoration:underline;">
                                Select Report :
                            </div>
                            <br />

                            <asp:RadioButton ID="optReqHistory" runat="server" GroupName="Reports" Checked="True"></asp:RadioButton>
                            <asp:Label ID="Label1" runat="server" Text="View Requests Summary (All Requests)"></asp:Label>
                            <br />
                            <asp:RadioButton ID="optNewHire" runat="server" GroupName="Reports"></asp:RadioButton>
                            <asp:Label ID="Label2" runat="server" Text="New Hires / ReHires"></asp:Label>
                            <br />
                            <asp:RadioButton ID="optDeptPayChanges" runat="server" GroupName="Reports"></asp:RadioButton>
                            <asp:Label ID="Label3" runat="server" Text="Department / Pay Rate Changes"></asp:Label>
                            <br />
                            <asp:RadioButton ID="optSep" runat="server" GroupName="Reports"></asp:RadioButton>
                            <asp:Label ID="Label4" runat="server" Text="Separations"></asp:Label>
                            <br />
                            <asp:RadioButton ID="optTransfers" runat="server" GroupName="Reports"></asp:RadioButton>
                            <asp:Label ID="Label5" runat="server" Text="Transfers"></asp:Label>
                            <br />
                            <asp:RadioButton ID="optNameAdd" runat="server" GroupName="Reports"></asp:RadioButton>
                            <asp:Label ID="Label6" runat="server" Text="Name / Address Changes"></asp:Label>
                            <br />
                            <asp:RadioButton ID="optW4" runat="server" GroupName="Reports"></asp:RadioButton>
                            <asp:Label ID="Label7" runat="server" Text="W4 Changes"></asp:Label>
                            <br />
                            <asp:RadioButton ID="optI9" runat="server" GroupName="Reports"></asp:RadioButton>
                            <asp:Label ID="Label8" runat="server" Text="I-9 Changes"></asp:Label>
                            <br />
                            <asp:RadioButton ID="optEFT" runat="server" GroupName="Reports"></asp:RadioButton>
                            <asp:Label ID="Label9" runat="server" Text="Direct Deposit (EFT) Changes"></asp:Label>
                            <br />
                            <asp:RadioButton ID="optMisc" runat="server" GroupName="Reports"></asp:RadioButton>
                            <asp:Label ID="Label10" runat="server" Text="Misc. Changes"></asp:Label>
                            <br />
                            <br />
                            <asp:RadioButton ID="optFindEmp" runat="server" GroupName="Reports"></asp:RadioButton>
                            <asp:Label ID="Label11" runat="server" Text="Find Employee from Name or ClockId or SSN"></asp:Label>
                            <br />
                            <asp:RadioButton ID="optSepDetails" runat="server" GroupName="Reports"></asp:RadioButton>
                            <asp:Label ID="Label12" runat="server" Text="Separation Details"></asp:Label>
                            <br />
                            <asp:RadioButton ID="optEmpHistory" runat="server" GroupName="Reports"></asp:RadioButton>
                            <asp:Label ID="Label13" runat="server" Text="Employee History"></asp:Label>
                        </div>
                    </div>
                    <div style="float: right; width: 50%;">
                        <div class="col-sm-12">
                            <div style="color: #069; font-size: large; font-weight: bold;text-decoration:underline;">
                                Enter Parameters :    
                            </div>
                           <br />
                        </div>
                        <div class="col-sm-4">
                            <asp:RadioButton ID="optDateCreated" runat="server" GroupName="DateType" Checked="True"></asp:RadioButton>
                            <asp:Label ID="Label14" runat="server" Text="Date Created"></asp:Label>  
                        </div>
                        <div class="col-sm-8">   
                            <strong><asp:Label ID="Label15" runat="server" Text="Start Date"></asp:Label></strong>&nbsp
                                <asp:TextBox ID="txtSDate" runat="server" Preset="shortdate" Width="100px" CssClass="form-control1"></asp:TextBox>
                        </div>
                        <br />
                        <br />
                         <div class="col-sm-4">
                            <asp:RadioButton ID="optDateEff" runat="server" GroupName="DateType"></asp:RadioButton>
                            <asp:Label ID="Label16" runat="server" Text="Date Effective"></asp:Label>  
                        </div>
                        <div class="col-sm-8">   
                            <strong><asp:Label ID="Label17" runat="server" Text="End Date"></asp:Label></strong> &nbsp&nbsp
                                <asp:TextBox ID="txtEDate" runat="server" Preset="shortdate" Width="100px" CssClass="form-control1"></asp:TextBox>
                        </div>
                        <br />
                         <div class="col-sm-4">
                            <asp:RadioButton ID="optDatePosted" runat="server" GroupName="DateType"></asp:RadioButton>
                            <asp:Label ID="Label18" runat="server" Text="Date Posted"></asp:Label>  
                        </div>
                        <div class="line"></div>   
                        <div class="col-sm-4">
                            <asp:Label ID="lblClockId" runat="server" Text="Clock ID"></asp:Label>  
                        </div>
                        <div class="col-sm-8">
                             <asp:textbox id="txtEmpClockId" runat="server" CssClass="form-control" Width="160px"></asp:textbox>
                        </div>
                         <br />
                        <br />
                        <div class="col-sm-4">
                          <strong> Approval Status  </strong>
                        </div>
                        <div class="col-sm-8">
                             <asp:dropdownlist id="cmbApp" runat="server" CssClass="form-control" Width="160px"></asp:dropdownlist>
                        </div>
                         <br />
                        <br />
                        <div class="col-sm-4">
                           <strong> Post Status </strong>
                        </div>
                        <div class="col-sm-8">
                             <asp:dropdownlist id="cmbPost" runat="server" CssClass="form-control" Width="160px"></asp:dropdownlist>
                        </div>
                         <br />
                        <br />
                        <div class="col-sm-4">
                         <strong> Salaried Only </strong>
                        </div>
                        <div class="col-sm-8">
                            <asp:CheckBox ID="chkMan" runat="server" />
                        </div>
                        <br />
                        <br />
                        <div class="col-sm-4">
                            <strong> Select Store </strong>
                        </div>
                        <div class="col-sm-8">
                            <asp:listbox id="lstStore" runat="server" Height="108px" Font-Size="8pt" Width="160px" SelectionMode="Multiple"></asp:listbox>
                        </div>
                    </div>
                </div>
                <br />
                <div style="text-align:center;">
                    <input id="cmdViewReport" type="button" value="View Report" class="btn-form" name="cmdViewReport">   <%--onclick="ViewReport();"--%>
                </div>

            </div>
            <!-- END PANEL -->
        </div>
        <!-- END CONTAINER FLUID -->
    </form>
</asp:Content>
