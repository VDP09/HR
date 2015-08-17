<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ChangeDepRate.aspx.vb" Inherits="Web_CJEmployeeInfo.ChangeDepRate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../assets/plugins/boostrapv3/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../pages/css/pages.css" rel="stylesheet" />
    <title>Change Department/Rate or Transfer Employee</title>
    <script src="../Scripts/NumberFormat.js"></script>
    <httphandlers> 
			<add verb="*" 
			path="MetaBuilders_WebControls_DynamicListBoxResourceHandler.axd" 
			type="MetaBuilders.WebControls.DynamicListBoxResourceHandler,MetaBuilders.WebControls.DynamicListBox" 
			validate="false"> 
	 </httphandlers>
    <script language="javascript">

        function AddRemoveJobCode(i) {
            var lstJobCode;
            var cmbJobCode;
            var txtPayRate;
            var chkPrimary;
            var blnFoundPrimary;

            //var intPayRate;

            blnFoundPrimary = false;

            lstJobCode = document.getElementById("lstJobCode");
            cmbJobCode = document.getElementById("cmbJobCode");
            txtPayRate = document.getElementById("txtPayRate");
            chkPrimary = document.getElementById("chkPrimary");

            if (i == 0)	// Add Job Code
            {
                var strItem;
                var strItemValues;

                if (isBlank(txtPayRate.value) || isBlank(cmbJobCode.value)) {
                    alert('Invalid Department / Pay Rate .. Please check it out');
                    return false;
                }

                if (txtPayRate.value - 0 != txtPayRate.value) {
                    alert('Invalid Pay Rate .. Please check it out');
                    return false;
                }


                //Parse through existing items to check for duplicates
                //alert(lstJobCode.length);

                for (var j = 0; j <= lstJobCode.options.length - 1; j++) {
                    strItem = lstJobCode.options(j).text;
                    strItemValues = strItem.split('|');

                    //alert(strItemValues.length);

                    if (strItemValues.length == 3)
                        blnFoundPrimary = true;

                    if (TrimString(strItemValues[0]) == TrimString(cmbJobCode.options(cmbJobCode.selectedIndex).text)) {
                        alert('Duplicate Department .. Please check it out');
                        return false;
                    }
                }

                //lstJobCode.options[lstJobCode.length]=new Option(cmbJobCode.options(cmbJobCode.selectedIndex).text + '  |  ' + txtPayRate.value, cmbJobCode.value, false);		
                //alert(cmbJobCode.options(cmbJobCode.selectedIndex).text);
                /*
                if(txtPayRate.value > 15000)
                    intPayRate = txtPayRate.value / 24;
                else
                    intPayRate = txtPayRate.value;
                */


                //Check for pay range if exist
                var intJobCode;
                var strPayRange;
                strItem = cmbJobCode.options(cmbJobCode.selectedIndex).value;

                //alert(cmbJobCode.options(cmbJobCode.selectedIndex).value);
                //alert(strItem);

                if (strItem.indexOf('|') > 0) {
                    strItemValues = strItem.split('|');

                    intJobCode = strItemValues[0];
                    strPayRange = strItemValues[1].split('-');

                    if (txtPayRate.value >= (strPayRange[0] - 0) && txtPayRate.value <= (strPayRange[1] - 0)) {
                        //Correct rate
                    }
                    else {
                        alert('Pay Rate for the selected department should be in the following range .. Please check it out' + '\n' + '\n' +
                                'Minimum ($) : ' + strPayRange[0] + '\n' +
                                'Maximum ($) : ' + strPayRange[1] + '\n' + '\n' +
                                'If you want to go outside this range, submit request with rate in the above range and then call HR to change it before processing.');
                        return false;
                    }
                }
                else
                    intJobCode = cmbJobCode.options(cmbJobCode.selectedIndex).value;



                if (chkPrimary.checked) {
                    if (blnFoundPrimary) {
                        alert('Primary department already exists .. Please check it out');
                        return false;
                    }
                    else {
                        var option = document.createElement("OPTION");
                        option.innerHTML = cmbJobCode.options(cmbJobCode.selectedIndex).text + '  |  ' + formatNumber(txtPayRate.value, '0.00') + '  |  Primary' + '  *';
                        option.value = intJobCode;
                        lstJobCode.appendChild(option);
                        //lstJobCode.Add(intJobCode, cmbJobCode.options(cmbJobCode.selectedIndex).text + '  |  ' + formatNumber(txtPayRate.value, '0.00') + '  |  Primary' + '  *');
                    }
                }
                else {
                    //lstJobCode.Add(intJobCode, cmbJobCode.options(cmbJobCode.selectedIndex).text + '  |  ' + formatNumber(txtPayRate.value, '0.00') + '  *');
                    var option = document.createElement("OPTION");
                    option.innerHTML = cmbJobCode.options(cmbJobCode.selectedIndex).text + '  |  ' + parseFloat(txtPayRate.value).toFixed(2) + '  *';
                    option.value = intJobCode;
                    lstJobCode.appendChild(option);
                }
                cmbJobCode.selectedIndex = -1;
                txtPayRate.value = '';
                chkPrimary.checked = false;
            }

            else		// Remove Job Code
            {
                //lstJobCode.Remove(lstJobCode.options.selectedIndex);
                for (var i = 0; i < lstJobCode.options.length; i++) {
                    if (lstJobCode.options[i].selected == true) {
                        lstJobCode.removeChild(lstJobCode.options[i]);
                    }
                }
                //options[lstJobCode.selectedIndex] = null;
            }
        }
        function ValidateData() {
            var lstJobCode;
            var txtEffDate;
            var txtEmpSig;
            var j;
            var strItem;
            var strItemValues;
            var blnFoundPrimary;

            blnFoundPrimary = false;
            lstJobCode = document.getElementById("lstJobCode");
            txtEffDate = document.getElementById("txtEffDate");
            txtEmpSig = document.getElementById("txtEmpSig");


            if (lstJobCode.length == 0) {
                alert('Atleast one Department is required .. Please check it out');
                return false;
            }

            for (var j = 0; j <= lstJobCode.length - 1; j++) {
                strItem = lstJobCode.options(j).text;
                strItemValues = strItem.split('|');

                if (strItemValues.length == 3)
                    blnFoundPrimary = true;
            }


            if (!blnFoundPrimary) {
                alert('Primary Department is required .. Please check it out');
                return false;
            }


            if (frmDepRate.txtFormType.value == 0)	//If Job/Payrate change form
            {
                var d1;
                var intDay;
                var cmbChangeReason;

                cmbChangeReason = document.getElementById("cmbChangeReason");

                //Check for first date of biweekly payroll schedule
                if (frmDepRate.txtSecCode.value <= 5) {
                    var d2;
                    var found;
                    var strAlert;
                    d1 = new Date(txtEffDate.value);
                    d2 = new Date('1/3/2007');

                    found = 0;

                    while (d2 <= d1) {
                        //alert(d2);
                        //alert(d1.toDateString());

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
                        d2 = new Date('1/3/2007');

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



                    //d1 = new Date(txtEffDate.value);
                    //intDay = d1.getDate();
                    //if(intDay != 1 && intDay != 16)
                    //{
                    //	alert('Pay Rate/Department change effective date must be 1st or 16th of the month .. Please check it out');
                    //	return false;
                    //}
                }


                if (frmDepRate.txtId.value != 0) {
                    if (isBlank(txtEffDate.value) ||
                        isBlank(cmbChangeReason.options(cmbChangeReason.selectedIndex).text)) {
                        alert('Following are required fields .. Please check it out' +
                            '\n' + '\n' + 'Effective Date' + '\n' +
                            'Change Reason');

                        return false;
                    }
                }
                else {
                    if (isBlank(txtEffDate.value) ||
                        isBlank(cmbChangeReason.options(cmbChangeReason.selectedIndex).text) ||
                        (frmDepRate.SigPlus.NumberOfTabletPoints <= 0)) {
                        alert('Following are required fields .. Please check it out' +
                            '\n' + '\n' + 'Effective Date' + '\n' +
                            'Change Reason' + '\n' +
                            'Employee Signature');

                        return false;
                    }
                }
            }

            if (frmDepRate.txtFormType.value == 1)	//If transfer form
            {
                //alert('came');
                var cmbTempUnit;
                var txtTempSDate;
                var txtTempEDate;
                var d1;
                var d2;
                var d3;
                var cmbToStore;
                var txtFromStore;
                var txtChangeReason;



                cmbTempUnit = document.getElementById("cmbTempUnit");
                txtTempSDate = document.getElementById("txtTempSDate");
                txtTempEDate = document.getElementById("txtTempEDate");
                cmbToStore = document.getElementById("cmbToStore");
                txtFromStore = document.getElementById("txtFromStore");
                txtChangeReason = document.getElementById("txtChangeReason");

                //Check for company field when posting only
                if (frmDepRate.txtSecCode.value == 5 || frmDepRate.txtSecCode.value == 6 ||
                    frmDepRate.txtSecCode.value == 7) {
                    var cmbCompany;
                    cmbCompany = document.getElementById("cmbCompany");

                    if (isBlank(cmbCompany.options(cmbCompany.selectedIndex).text)) {
                        alert('Company is required .. Please check it out');
                        return false;
                    }
                }

                if (isBlank(cmbToStore.options(cmbToStore.selectedIndex).text)) {
                    alert('To Store is required .. Please check it out');
                    return false;
                }

                if (txtFromStore.value == cmbToStore.options(cmbToStore.selectedIndex).text) {
                    alert('From Store and To Store can not be same .. Please check it out');
                    return false;
                }

                /*
                if(!isBlank(cmbTempUnit.options(cmbTempUnit.selectedIndex).text) &&
                    (isBlank(txtTempSDate.value) || isBlank(txtTempEDate.value)))
                {
                    alert('Follwing fields are required together .. Please check it out' + '\n' + '\n' +
                            'Temporary Store' + '\n' + 'From Date' +'\n' + 'To Date');
                    return false;
                }
                    
                if(!isBlank(cmbTempUnit.options(cmbTempUnit.selectedIndex).text))
                {
                    d1 = new Date(txtTempSDate.value);
                    d2 = new Date(txtTempEDate.value);
                    d3 = new Date(txtEffDate.value);
                    
                    if(d1 > d2)
                    {
                        alert('From Date can not be greater than To Date .. Please check it out');
                        return false;
                    }
                    
                    d1 = new Date(txtEffDate.value);
                    d2 = new Date(txtTempEDate.value);
                    diff  = new Date();

                    // sets difference date to difference of first date and second date
                    diff.setTime(d1.getTime() - d2.getTime());
                    timediff = diff.getTime();
                    
                    days = Math.floor(timediff / (1000 * 60 * 60 * 24)); 
                    
                    if(days != 1)
                    {
                        alert('To Date should be 1 day less than Effective Date .. Please check it out');
                        return false;
                    }
                    
                    if(cmbToStore.options(cmbToStore.selectedIndex).text == cmbTempUnit.options(cmbTempUnit.selectedIndex).text)
                    {
                        alert('Temporary Store can not be same as To Store .. Please check it out');
                        return false;
                    }

                }
                */


                if (isBlank(txtEffDate.value) ||
                    isBlank(txtChangeReason.value)) {
                    alert('Following are required fields .. Please check it out' +
                        '\n' + '\n' + 'Effective Date' + '\n' + 'Change Reason');

                    return false;
                }

                //if(frmDepRate.txtId.value != 0)
                //{
                /*
                }
                else
                {
                    if(isBlank(txtEffDate.value) ||
                        isBlank(txtChangeReason.value) ||
                        (frmDepRate.SigPlus.NumberOfTabletPoints <= 0))
                    {
                        alert('Following are required fields .. Please check it out' +
                            '\n' + '\n' + 'Effective Date' + '\n' +
                            'Change Reason' + '\n' +
                            'Employee Signature');
                    
                        return false;
                    }	
                }
                */

            }

            if (!CheckDateEff(txtEffDate.value)) {
                alert('Invalid Date Effective .. Please check it out');
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

        function IsNumeric(sText) {
            var ValidChars = "0123456789.";
            var IsNumber = true;
            var Char;


            for (i = 0; i < sText.length && IsNumber == true; i++) {
                Char = sText.charAt(i);
                if (ValidChars.indexOf(Char) == -1) {
                    IsNumber = false;
                }
            }
            return IsNumber;
        }

        function OnClear() {
            frmDepRate.SigPlus.ClearTablet(); //Clears the signature, in case of error or mistake
        }

        function OnSign() {
            frmDepRate.SigPlus.TabletState = 1; //Turns tablet on
        }

        function LoadSig() {
            if (frmDepRate.txtEmpSig.value != '') {
                frmDepRate.SigPlus.JustifyX = 10;
                frmDepRate.SigPlus.JustifyY = 10;
                frmDepRate.SigPlus.AutoKeyStart();
                frmDepRate.SigPlus.AutoKeyData = "Rupesh Patel";
                frmDepRate.SigPlus.AutoKeyFinish();
                frmDepRate.SigPlus.EncryptionMode = 2;
                frmDepRate.SigPlus.SigCompressionMode = 1;
                frmDepRate.SigPlus.DisplayPenWidth = 8;
                frmDepRate.SigPlus.JustifyMode = 0;
                frmDepRate.SigPlus.SigString = frmDepRate.txtEmpSig.value;
            }

            if (frmDepRate.txtId.value != 0) {
                frmDepRate.cmdSign.disabled = true;
                frmDepRate.cmdClear.disabled = true;
            }
        }

        function ValidateSubmit() {
            if (ValidateData()) {
                if (confirm('Submit Request ?' + '\n' + '\n' + 'Date Effective : ' + document.getElementById("txtEffDate").value)) {
                    if (frmDepRate.SigPlus.NumberOfTabletPoints > 0) {
                        frmDepRate.SigPlus.TabletState = 0; //Turns tablet off
                        frmDepRate.SigPlus.AutoKeyStart();

                        frmDepRate.SigPlus.AutoKeyData = "Rupesh Patel";
                        frmDepRate.SigPlus.AutoKeyFinish();
                        frmDepRate.SigPlus.EncryptionMode = 2;
                        frmDepRate.SigPlus.SigCompressionMode = 1;

                        frmDepRate.txtEmpSig.value = frmDepRate.SigPlus.SigString;
                    }
                    return true;
                }
                else {
                    return false;
                }
            }

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

        function ValidateApproveDeny(i) {
            if (i == 1) {
                if (ValidateData())
                    if (confirm('Approve Request ?'))
                        return true;
                    else
                        return false;
            }

            else {
                var cmdDeny;
                cmdDeny = document.getElementById("cmdDeny");

                if (cmdDeny.value == 'Deny') {
                    if (confirm('Deny Request ?'))
                        return true;
                    else
                        return false;
                }
                else {
                    if (confirm('Undo Approval on this request ?'))
                        return true;
                    else
                        return false;
                }
            }
            return false;
        }

        function ViewPendReq() {
            //alert('rup');

            var strDate;
            var Date1;
            var strURL;

            Date1 = new Date();
            strDate = (Date1.getMonth() + 1) + '/' + Date1.getDate() + '/' + Date1.getFullYear();

            //alert(frmDepRate.txtClockId.value);

            strURL = 'http://Goldmine/reportserver?/HRExpress/PayDeptChanges' +
                        '&rs:Command=Render' +
                        '&rc:Zoom=100&rc:Parameters=false' +
                        '&StartDate=1/1/1900' +
                        '&EndDate=' + strDate +
                        '&DateType=Cre' +
                        '&ClockId=' + frmDepRate.txtManClockId.value +
                        '&SecCode=' + frmDepRate.txtSecCode.value +
                        '&StoreList=' +
                        '&ManFlag=False' +
                        '&EmpClockId=' + frmDepRate.txtClockId.value +
                        '&AppStatus=3' +
                        '&PostStatus=3';

            //alert(strURL);
            //return false;

            window.open(strURL, 'wPendReq', 'resizable=yes,top=10, left=10, width=650,height=300,scrollbars=yes,fullscreen=no');
        }
    </script>
</head>
<body bgcolor="#99cccc" onload="LoadSig();">
    <form id="frmDepRate" method="post" runat="server">
        <!-- START CONTAINER FLUID -->
        <div class="container-fluid container-fixed-lg">
            <!-- START PANEL -->
            <div class="panel panel-transparent">
                <div class="row" style="text-align: center; color: #069; font-family: 'Monotype Corsiva'; font-weight: bold; font-size: 25px; margin-top: 4px;">
                    <asp:Label ID="lblHead" runat="server" ForeColor="#006699"></asp:Label>
                </div>

                <div class="blue_line"></div>

                <div class="row">
                    <div class="col-sm-12" style="text-align: center;">
                        <asp:Label ID="lblEmp" runat="server" Width="605px" Font-Names="Microsoft Sans Serif" Font-Size="Small"
                            Font-Bold="True"></asp:Label>
                    </div>
                    <div class="blue_line"></div>

                    <div id="tblPendReq1" runat="server">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-1">
                                        <font face="Wingdings" color="darkred" size="6"><STRONG>F</STRONG></font>
                                    </div>
                                    <div class="col-sm-8" style="text-align: center">
                                        <asp:Label ID="lblPendingReq" runat="server" ForeColor="#069" Font-Bold="True" Width="485px">Label</asp:Label>
                                    </div>
                                    <div class="col-sm-3">
                                        <asp:Button ID="cmdViewPendReq" runat="server" CssClass="btn-form" Text="View Pending Requests"></asp:Button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <table id="Table5" cellspacing="0" cellpadding="2" width="100%" border="0">
                                    <tr>
                                        <td align="center">
                                            <table id="tblStore" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
                                                <tr>
                                                    <td style="WIDTH: 80px"><font face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG>From 
																				Store</STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></font></td>
                                                    <td>
                                                        <asp:TextBox ID="txtFromStore" runat="server" Width="174px" CssClass="form-control" ForeColor="Black" Enabled="False" BackColor="#E7E6E6"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr><td style="height:5px;"></td></tr>
                                                <tr>
                                                    <td style="WIDTH: 80px"><font face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG>To 
																				Store</STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></font></td>
                                                    <td>
                                                        <asp:DropDownList ID="cmbToStore" runat="server" Width="176px" CssClass="form-control" BackColor="#E7E6E6"></asp:DropDownList>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="tblCompany" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
                                                <tr><td style="height:5px;"></td></tr>
                                                <tr>
                                                    <td style="WIDTH: 80px"><font face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG>Company</STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></font></td>
                                                    <td>
                                                        <asp:DropDownList ID="cmbCompany" runat="server" Width="176px" CssClass="form-control" BackColor="#E7E6E6"></asp:DropDownList>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td align="center">
                                            <table id="tblDepartment" style="WIDTH: 366px; HEIGHT: 8px" cellspacing="0" cellpadding="0"
                                                width="366" border="0" runat="server" top="-5">
                                                <tr>
                                                    <td style="HEIGHT: 15px" align="center"><font face="MS Sans Serif" color="#336699" size="1"><STRONG>Employee's 
														Existing Departments - Pay Rates</STRONG></font></td>
                                                </tr>
                                                <tr>
                                                    <td style="HEIGHT: 29px" align="center">
                                                        <asp:DataGrid ID="grdDept" runat="server" Width="337px" Font-Names="Microsoft Sans Serif" Font-Size="XX-Small"
                                                            Height="12px" BorderStyle="Solid" BorderWidth="1px" BackColor="White" PageSize="5" CellPadding="2" BorderColor="#CCCCCC" AutoGenerateColumns="False">
                                                            <FooterStyle ForeColor="#000066" BackColor="White"></FooterStyle>
                                                            <SelectedItemStyle Font-Bold="True" ForeColor="White" BackColor="#669999"></SelectedItemStyle>
                                                            <ItemStyle ForeColor="#000066"></ItemStyle>
                                                            <HeaderStyle Font-Bold="True" ForeColor="White" BackColor="#006699"></HeaderStyle>
                                                            <Columns>
                                                                <asp:TemplateColumn HeaderText="Job Code">
                                                                    <HeaderStyle HorizontalAlign="Center" Width="55%"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="JobCode" Text='<%# DataBinder.Eval(Container.DataItem, "JobCode") %>' runat="server" />
                                                                    </ItemTemplate>
                                                                </asp:TemplateColumn>
                                                                <asp:TemplateColumn HeaderText="Pay Rate ($)">
                                                                    <HeaderStyle HorizontalAlign="Center" Width="25%"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="PayRate" Text='<%# DataBinder.Eval(Container.DataItem, "PayRate") %>' runat="server" />
                                                                    </ItemTemplate>
                                                                </asp:TemplateColumn>
                                                                <asp:TemplateColumn HeaderText="Primary ?">
                                                                    <HeaderStyle HorizontalAlign="Center" Width="20%"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Center" Font-Name="Arial" ForeColor="#009999" Font-Bold="True"
                                                                        Font-Size="9"></ItemStyle>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="Primary" Font-Name="Arial" Text='<%# DataBinder.Eval(Container.DataItem, "PrimaryPicture") %>' runat="server" />
                                                                    </ItemTemplate>
                                                                </asp:TemplateColumn>
                                                            </Columns>
                                                            <PagerStyle HorizontalAlign="Center" ForeColor="#000066" BackColor="White" Mode="NumericPages"></PagerStyle>
                                                        </asp:DataGrid>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="HEIGHT: 3px" align="center" width="100%" colspan="2">
                                            <table id="tblLine" style="HEIGHT: 8px" cellspacing="0" cellpadding="0" width="100%" border="0"
                                                runat="server">
                                                <tr>
                                                    <td align="left">
                                                        <div class="blue_line"></div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                   
                                </table>
                            </div>
                        </div>

                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <table id="Table6" bordercolor="#006699" cellspacing="0" cellpadding="0" width="100%" border="2">
                                    <tr>
                                        <td style="WIDTH: 45%;" valign="top">
                                            <table id="Table7" cellspacing="0" cellpadding="0" top="0" width="100%" border="0">
                                                <tr>
                                                    <td style="HEIGHT: 21px" align="center" bgcolor="#006699">
                                                        <asp:Label ID="lblDepartment" runat="server" ForeColor="White" Font-Bold="True" Width="291px"
                                                            Font-Names="Microsoft Sans Serif" Font-Size="XX-Small" BackColor="#006699">Employee's New Departments - Pay Rates :</asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="HEIGHT: 16px" align="center"><font face="MS Sans Serif" color="black" size="1">Department&nbsp; 
													| &nbsp;Pay Rate ($)&nbsp; |&nbsp; Primary</font></td>
                                                </tr>
                                                <tr>
                                                    <%--<TD align="center"><mb:dynamiclistbox id="lstJobCode" runat="server" Width="288px" Font-Names="Verdana" Font-Size="XX-Small"
													Height="67px" BackColor="PapayaWhip"></mb:dynamiclistbox></TD>--%>
                                                    <td align="center">
                                                        <asp:ListBox ID="lstJobCode" runat="server" Width="288px" CssClass="form-control"></asp:ListBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="HEIGHT: 27px" align="left"><font face="Verdana" size="1">&nbsp; * 
													Modified&nbsp;&nbsp;&nbsp;&nbsp; </font>
                                                        <input id="cmdRemoveJobCode" class="btn-form" onclick="AddRemoveJobCode(1);" type="button" value="Remove Department" name="cmdExit"></td>
                                                </tr>
                                                 <tr><td style="height:5px;"></td></tr>
                                            </table>
                                        </td>
                                        <td valign="top" style="width:55%;">
                                            <table id="Table8" style="WIDTH: 100%; HEIGHT: 84px" cellspacing="0" cellpadding="0" width="338"
                                                border="0">
                                                <tr>
                                                    <td style="HEIGHT: 21px" align="center" bgcolor="#006699"><font face="Microsoft Sans Serif" color="white" size="1"><STRONG>Add&nbsp;/ 
														Modify Department - Pay Rate :</STRONG></font></td>
                                                </tr>
                                                <tr>
                                                    <td style="HEIGHT: 105px">
                                                        <table id="Table9" cellspacing="0" cellpadding="2" width="100%" border="0">
                                                            <tr>
                                                                <td style="WIDTH: 82px"><font face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG>&nbsp; 
																							Department</STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></font></td>
                                                                <td>
                                                                    <asp:DropDownList ID="cmbJobCode" runat="server" Width="240px" CssClass="form-control"></asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr><td style="height:5px;"></td></tr>
                                                            <tr>
                                                                <td style="WIDTH: 82px"><font face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG>&nbsp; 
																							Pay Rate ($)</STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></font></td>
                                                                <td>
                                                                    <asp:TextBox ID="txtPayRate" runat="server" Width="136px" CssClass="form-control" preset="currency"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="WIDTH: 82px"><font face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG>&nbsp; 
																							Primary ?</STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></font></td>
                                                                <td>
                                                                    <asp:CheckBox ID="chkPrimary" runat="server"></asp:CheckBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="WIDTH: 82px"></td>
                                                                <td>
                                                                    <input id="cmdAddNewJob" onclick="AddRemoveJobCode(0);" type="button" value="<< Add" name="cmdExit" class="btn-form"></td>
                                                            </tr>
                                                            <tr><td style="height:5px;"></td></tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row" style="margin-top:5px;">
                        <div class="col-sm-12">
                            <div class="row">
                                <table id="tblTempLocation" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
                                    
                                     <tr>
                                        <td style="WIDTH: 105px"><font face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG>Temporary 
																	Store</STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></font></td>
                                        <td style="WIDTH: 206px">
                                            <asp:DropDownList ID="cmbTempUnit" runat="server" CssClass="form-control" Width="176px" Enabled="False" BackColor="#E7E6E6"></asp:DropDownList>
                                        </td>
                                        <td style="WIDTH: 64px"><font face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG>From 
																	Date</STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></font></td>
                                        <td style="WIDTH: 115px">
                                            <asp:TextBox ID="txtTempSDate" runat="server" CssClass="form-control" Width="80px" Enabled="False" BackColor="#E7E6E6" preset="shortdate"></asp:TextBox>
                                        </td>
                                        <td style="WIDTH: 52px"><font face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG>To 
																	Date</STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></font></td>
                                        <td>
                                            <asp:TextBox ID="txtTempEDate" runat="server" Width="80px" CssClass="form-control" Enabled="False" BackColor="#E7E6E6" preset="shortdate"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="100%" colspan="6">
                                            <div class="blue_line"></div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <table id="Table4" cellspacing="0" cellpadding="0" width="100%" border="0">
                                    <tr>
                                        <td style="WIDTH: 125px; HEIGHT: 12px" valign="middle"><font face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG>Effective 
																	Date</STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></font></td>
                                        <td style="HEIGHT: 12px">
                                            <asp:TextBox ID="txtEffDate" runat="server" Width="136px" CssClass="form-control" BackColor="#E7E6E6" preset="shortdate"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr><td style="height:5px;"></td></tr>
                                    <tr>
                                        <td style="WIDTH: 125px; HEIGHT: 27px" valign="middle"><font face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG>Reason 
																	For Change</STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></font></td>
                                        <td style="HEIGHT: 27px">
                                            <asp:TextBox ID="txtChangeReason" runat="server" Width="512px" BackColor="#E7E6E6" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                            <asp:DropDownList ID="cmbChangeReason" runat="server" Width="192px" CssClass="form-control" BackColor="#E7E6E6"></asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="WIDTH: 125px; HEIGHT: 8px" valign="top"><font face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG>Employee 
																	Signature</STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></font></td>
                                        <td style="HEIGHT: 8px">
                                            <table id="Table2" cellspacing="0" cellpadding="0" width="100%" border="0">
                                                <tr>
                                                    <td style="WIDTH: 338px">
                                                        <table bordercolor="#006699" cellspacing="0" cellpadding="0" border="1">
                                                            <tr>
                                                                <td>
                                                                    <object style="BACKGROUND-COLOR: papayawhip; WIDTH: 300px; HEIGHT: 100px; TOP: 0px; LEFT: 0px"
                                                                        id="SigPlus" name="SigPlus" classid="clsid:69A40DA3-4D42-11D0-86B0-0000C025864A" height="60"
                                                                        viewastext>
                                                                        <param name="_Version" value="131095">
                                                                        <param name="_ExtentX" value="7937">
                                                                        <param name="_ExtentY" value="2645">
                                                                        <param name="_StockProps" value="0">
                                                                    </object>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td>
                                                        <table id="Table3" style="WIDTH: 202px; HEIGHT: 65px" cellspacing="0" cellpadding="0" width="202"
                                                            border="0">
                                                            <tr>
                                                                <td>
                                                                    <input id="cmdSign" style="WIDTH: 56px;" class="btn-form" onclick="OnSign()" type="button" value="Sign" name="cmdSign"></td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <input id="cmdClear" style="WIDTH: 56px;" onclick="OnClear()" class="btn-form" type="button" value="Clear" name="cmdClear"></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <table id="tblGMUndoApproval" style="WIDTH: 650px; HEIGHT: 56px" cellspacing="0" cellpadding="0"
                                    width="650" border="0" runat="server">
                                    <tr>
                                        <td style="WIDTH: 124px"><font face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG>Undo 
																	Approval Notes</STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></font></td>
                                        <td>
                                            <asp:TextBox ID="txtUndoNotes" runat="server" Width="512px" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>

                    <div>
                        <div class="blue_line"></div>
                        <%--<mb:dynamiclistbox id="lstOldJobCode" runat="server" Width="24px" Font-Names="Microsoft Sans Serif"
							Font-Size="XX-Small" Height="23px" ></mb:dynamiclistbox>--%>
                        <%--<asp:ListBox  ID="lstOldJobCode" runat="server"Width="24px" Font-Names="Microsoft Sans Serif" Font-Size="XX-Small" Height="23px" ></asp:ListBox>--%>
                        <asp:ListBox ID="lstOldJobCode" runat="server" Width="24px" Font-Names="Microsoft Sans Serif" Font-Size="XX-Small" Visible="false" Height="23px"></asp:ListBox>
                        <asp:TextBox ID="txtHTempUnit" runat="server" Width="20px" Height="16px" Visible="False"></asp:TextBox>
                        <input id="txtFormType" style="WIDTH: 23px; HEIGHT: 14px" type="hidden" size="1" name="txtFormType"
                            runat="server"><input id="txtId" style="WIDTH: 16px; HEIGHT: 14px" type="hidden" size="1" name="txtId"
                                runat="server">
                        <asp:TextBox ID="txtHToStore" runat="server" Width="16px" Height="16px" Visible="False"></asp:TextBox>
                        <input id="txtEmpSig" style="WIDTH: 30px; HEIGHT: 14px" type="hidden" size="1" name="txtEmpSig"
                            runat="server"><input id="txtSecCode" style="WIDTH: 23px; HEIGHT: 14px" type="hidden" size="1" name="txtSecCode"
                                runat="server">
                        <asp:TextBox ID="txtHChangeReason" runat="server" Width="16px" Height="16px" Visible="False"></asp:TextBox>
                        <input id="txtEmpName" style="WIDTH: 30px; HEIGHT: 14px" type="hidden" size="1" name="txtEmpName"
                            runat="server"><input id="txtEmpUnit" style="WIDTH: 30px; HEIGHT: 14px" type="hidden" size="1" name="txtEmpUnit"
                                runat="server"><input id="txtClockId" style="WIDTH: 23px; HEIGHT: 14px" type="hidden" size="1" name="txtClockId"
                                    runat="server"><input id="txtManClockId" style="WIDTH: 23px; HEIGHT: 14px" type="hidden" size="1" name="txtManClockId"
                                        runat="server">
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div>
                                <asp:Button ID="cmdPost" runat="server" Width="110px" CssClass="btn-form1" Text="Post"></asp:Button>
                                <asp:Button ID="cmdApprove" runat="server" Width="110px" CssClass="btn-form1" Text="Approve"></asp:Button>
                                &nbsp;
						<asp:Button ID="cmdDeny" runat="server" Width="110px" CssClass="btn-form1" Text="Deny"></asp:Button>
                                <asp:Button ID="cmdSubmit" runat="server" Width="110px" CssClass="btn-form1" Text="Submit"></asp:Button>
                                &nbsp;
                            <input id="cmdExit" style="WIDTH: 110px;" onclick="window.close();" class="btn-form1" type="button" value="Exit" name="cmdExit">
                                <asp:Button ID="cmdReview" runat="server" Width="129px" CssClass="btn-form1" Text="Send For Review" Visible="False"></asp:Button>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
            <!-- END PANEL -->
        </div>
        <!-- END CONTAINER FLUID -->

    </form>
</body>

<%--    <div>
            <div>
                <asp:Label ID="lblHead" runat="server" ForeColor="#006699"></asp:Label>
            </div>
            <div>
                <asp:Label ID="lblEmp" runat="server" Font-Bold="True" Width="605px" Font-Names="Microsoft Sans Serif"
                    Font-Size="X-Small"></asp:Label>
            </div>
            <div>
                <asp:Label ID="lblPendingReq" runat="server" ForeColor="#C00000" Font-Bold="True" Width="485px"
                    Font-Names="Microsoft Sans Serif" Font-Size="X-Small">Label</asp:Label>
            </div>
            <div>
                <asp:Button ID="cmdViewPendReq" runat="server" Font-Bold="True" Width="126px" Font-Size="XX-Small"
                    Height="24px" Text="View Pending Requests" BorderStyle="Groove"></asp:Button>
            </div>
            <div>
                <asp:TextBox ID="txtFromStore" runat="server" Width="174px" Font-Names="Arial" Font-Size="X-Small"
                    Height="20px" BorderStyle="Solid" BorderWidth="1px" Enabled="False" BackColor="WhiteSmoke"></asp:TextBox>
            </div>
            <div style="WIDTH: 80px">
                <font face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG>To 
			Store</STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></font>
                <asp:DropDownList ID="cmbToStore" runat="server" Width="176px" Height="20px" BackColor="PapayaWhip"></asp:DropDownList>
            </div>
            <div style="WIDTH: 80px">
                <font face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG>Company</STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></font>
                <asp:DropDownList ID="cmbCompany" runat="server" Width="176px" Height="20px" BackColor="PapayaWhip"></asp:DropDownList>
            </div>
            <div style="HEIGHT: 15px" align="center">
                <font face="MS Sans Serif" color="#336699" size="1"><STRONG>Employee's 
														Existing Departments - Pay Rates</STRONG></font>
            </div>
            <div>
                <asp:GridView ID="grv_chnanedate_rate" runat="server">
                    <FooterStyle ForeColor="#000066" BackColor="White"></FooterStyle>
                    <SelectedRowStyle Font-Bold="True" ForeColor="White" BackColor="#669999"></SelectedRowStyle>
                    <itemstyle forecolor="#000066"></itemstyle>
                    <HeaderStyle Font-Bold="True" ForeColor="White" BackColor="#006699"></HeaderStyle>
                    <Columns>
                        <asp:TemplateField HeaderText="Job Code">
                            <HeaderStyle HorizontalAlign="Center" Width="55%"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                            <ItemTemplate>
                                <asp:Label ID="JobCode" Text='<%# DataBinder.Eval(Container.DataItem, "JobCode") %>' runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Pay Rate ($)">
                            <HeaderStyle HorizontalAlign="Center" Width="25%"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                            <ItemTemplate>
                                <asp:Label ID="PayRate" Text='<%# DataBinder.Eval(Container.DataItem, "PayRate") %>' runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Primary ?">
                            <HeaderStyle HorizontalAlign="Center" Width="20%"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Center" Font-Names="Arial" ForeColor="#009999" Font-Bold="True"
                                Font-Size="9"></ItemStyle>
                            <ItemTemplate>
                                <asp:Label ID="Primary" Font-Name="Arial" Text='<%# DataBinder.Eval(Container.DataItem, "PrimaryPicture") %>' runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle HorizontalAlign="Center" ForeColor="#000066" BackColor="White" Mode="NumericPages"></PagerStyle>
                </asp:GridView>
            </div>
            <div>
                <asp:Label ID="lblDepartment" runat="server" ForeColor="White" Font-Bold="True" Width="291px"
                    Font-Names="Microsoft Sans Serif" Font-Size="XX-Small" BackColor="#006699">Employee's New Departments - Pay Rates :</asp:Label>
            </div>
            <div style="HEIGHT: 16px" align="center">
                <font face="MS Sans Serif" color="black" size="1">Department&nbsp; 
													| &nbsp;Pay Rate ($)&nbsp; |&nbsp; Primary</font>
            </div>
            <div>
                <asp:ListBox ID="lstJobCode" runat="server" Width="288px" Font-Names="Verdana" Font-Size="XX-Small"></asp:ListBox>
            </div>
            <div>
                <asp:Button ID="Button1" runat="server" Font-Bold="True" Width="126px" Font-Size="XX-Small"
                    Height="24px" Text="View Pending Requests" BorderStyle="Groove"></asp:Button>
            </div>
            <div>
                <td style="WIDTH: 80px"><font face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG>From 
																				Store</STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></font></td>
                <asp:TextBox ID="Textbox1" runat="server" Width="174px" Font-Names="Arial" Font-Size="X-Small"
                    Height="20px" BorderStyle="Solid" BorderWidth="1px" Enabled="False" BackColor="WhiteSmoke"></asp:TextBox>
            </div>
            <div> <style="WIDTH: 80px" ><FONT face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG>To 
																				Store</STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></FONT>
											<asp:dropdownlist id="Dropdownlist1" runat="server" Width="176px" Height="20px" BackColor="PapayaWhip"></asp:dropdownlist>
            </div>
        </div>--%>
</html>
