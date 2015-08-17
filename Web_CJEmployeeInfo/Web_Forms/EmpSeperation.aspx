<%@ Page Language="vb" EnableEventValidation="false" AutoEventWireup="false" CodeBehind="EmpSeperation.aspx.vb" Inherits="Web_CJEmployeeInfo.EmpSeperation" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../assets/plugins/boostrapv3/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../pages/css/pages.css" rel="stylesheet" />
    <title>Terminate Employee</title>
    <meta content="False" name="vs_showGrid">
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
            var txtSepDate;
            var txtSepNotified;
            var txtLastWork;
            var txtSepDesc;
            //var txtOtherDesc;
            var cmbSepReason;
            var cmbSepCat;
            //var cmbSepSubCat;

            txtSepDate = document.getElementById("txtSepDate");
            txtSepNotified = document.getElementById("txtSepNotified");
            txtLastWork = document.getElementById("txtLastWork");
            txtSepDesc = document.getElementById("txtSepDesc");
            //txtOtherDesc = document.getElementById("txtOtherDesc");
            cmbSepReason = document.getElementById("cmbSepReason");
            cmbSepCat = document.getElementById("cmbSepCat");
            //cmbSepSubCat = document.getElementById("cmbSepSubCat");

            if (isBlank(txtSepDate.value) ||
                isBlank(txtSepNotified.value) ||
                isBlank(txtLastWork.value) ||
                isBlank(txtSepDesc.value) ||
                isBlank(cmbSepReason.options(cmbSepReason.selectedIndex).text) ||
                isBlank(cmbSepCat.options(cmbSepCat.selectedIndex).text)) {
                alert('Following are required fields .. Please check it out' +
                    '\n' + '\n' + 'Seperation Date' + '\n' + 'Date Last Worked'
                    + '\n' + 'Date Seperation Notified' + '\n' + 'Seperation Reason'
                    + '\n' + 'Please Clarify'
                    + '\n' + 'Circumstances Leading to Seperation');

                //+ '\n' + 'Please Clarify Further'

                return false;
            }

            if (!CheckDateEff(txtSepDate.value)) {
                alert('Invalid Separation Date .. Please check it out');
                return false;
            }

            if (cmbSepReason.options(cmbSepReason.selectedIndex).text == 'Involuntary') {
                var txtHRApproval;
                var txtOtherDesc;

                txtHRApproval = document.getElementById("txtHRApproval");
                txtOtherDesc = document.getElementById("txtOtherDesc");

                if (isBlank(txtHRApproval.value) || isBlank(txtOtherDesc.value)) {
                    alert('Following fields are required for the selected Separation Reason' +
                        '\n' + '\n' + 'HR Approval By' + '\n' + 'For final pay, payroll should add following hours');

                    return false;
                }
            }

            //alert('came');
            //alert(cmbSepSubCat.selectedIndex);

            frmSep.txtCatId.value = cmbSepCat.options(cmbSepCat.selectedIndex).value;
            frmSep.txtCatName.value = cmbSepCat.options(cmbSepCat.selectedIndex).text;

            /*
            if(cmbSepSubCat.selectedIndex >= 0)
                frmSep.txtSubCatId.value = cmbSepSubCat.options(cmbSepSubCat.selectedIndex).value;
            else
                frmSep.txtSubCatId.value = ''; 
            */

            return true;
        }

        function ValidateSig() {
            var txtManName;
            var txtManName2;
            var strAlert;
            var blnCheckSig;

            txtManName = document.getElementById("txtManName");
            txtManName2 = document.getElementById("txtManName2");
            blnCheckSig = false;

            if (frmSep.txtId.value <= 0) {
                var chkSignLater;
                chkSignLater = document.getElementById("chkSignLater");

                if (!chkSignLater.checked)
                    blnCheckSig = true;
            }

            if ((frmSep.txtId.value > 0) || blnCheckSig) {
                if ((frmSep.SigPlus.NumberOfTabletPoints <= 0) ||
                    (frmSep.SigPlus1.NumberOfTabletPoints <= 0) ||
                    (frmSep.SigPlus2.NumberOfTabletPoints <= 0) ||
                    isBlank(txtManName.value) ||
                    isBlank(txtManName2.value)) {
                    strAlert = 'Following are required .. Please check it out'
                        + '\n' + '\n' + 'Employee Signature'
                        + '\n' + '1st Witness Manager Signature'
                        + '\n' + '1st Witness Manager Name'
                        + '\n' + '2nd Witness Manager Signature'
                        + '\n' + '2nd Witness Manager Name';

                    if (frmSep.txtId.value <= 0)
                        strAlert = strAlert + '\n' + '\n' + 'If you want to get signatures later, Please check "Will Get Signatures Later" box';

                    alert(strAlert);
                    return false;
                }
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

        function GetNameAddChangeURL() {
            var strURL;
            var txtClockId;

            //txtClockId = document.getElementById("txtClockId");
            //alert('rupesh');

            strURL = 'ChangeNameAdd.aspx?Id=0&CId=' + frmSep.txtClockId.value;
            window.open(strURL, '2', 'resizable=no,top=5, left=5, width=680,height=480,scrollbars=yes,menubar=no,toolbar=no');
        }

        function OnClear() {
            frmSep.SigPlus.ClearTablet(); //Clears the signature, in case of error or mistake
            OnSign();
        }

        function OnSign() {
            frmSep.SigPlus1.TabletState = 0;
            frmSep.SigPlus2.TabletState = 0;
            frmSep.SigPlus.TabletState = 1; //Turns tablet on
        }

        function OnClear1() {
            frmSep.SigPlus1.ClearTablet(); //Clears the signature, in case of error or mistake
            OnSign1();
        }

        function OnSign1() {
            frmSep.SigPlus.TabletState = 0;
            frmSep.SigPlus2.TabletState = 0;
            frmSep.SigPlus1.TabletState = 1; //Turns tablet on
        }

        function OnClear2() {
            frmSep.SigPlus2.ClearTablet(); //Clears the signature, in case of error or mistake
            OnSign2();
        }

        function OnSign2() {
            frmSep.SigPlus.TabletState = 0;
            frmSep.SigPlus1.TabletState = 0;
            frmSep.SigPlus2.TabletState = 1; //Turns tablet on
        }

        function LoadSig() {
            if (frmSep.txtEmpSig.value != '') {
                frmSep.SigPlus.JustifyX = 10;
                frmSep.SigPlus.JustifyY = 10;
                frmSep.SigPlus.AutoKeyStart();
                frmSep.SigPlus.AutoKeyData = "Rupesh Patel";
                frmSep.SigPlus.AutoKeyFinish();
                frmSep.SigPlus.EncryptionMode = 2;
                frmSep.SigPlus.SigCompressionMode = 1;
                frmSep.SigPlus.DisplayPenWidth = 8;
                frmSep.SigPlus.JustifyMode = 0;
                frmSep.SigPlus.SigString = frmSep.txtEmpSig.value;
            }

            if (frmSep.txtManSig.value != '') {
                frmSep.SigPlus1.JustifyX = 10;
                frmSep.SigPlus1.JustifyY = 10;
                frmSep.SigPlus1.AutoKeyStart();
                frmSep.SigPlus1.AutoKeyData = "Rupesh Patel";
                frmSep.SigPlus1.AutoKeyFinish();
                frmSep.SigPlus1.EncryptionMode = 2;
                frmSep.SigPlus1.SigCompressionMode = 1;
                frmSep.SigPlus1.DisplayPenWidth = 8;
                frmSep.SigPlus1.JustifyMode = 0;
                frmSep.SigPlus1.SigString = frmSep.txtManSig.value;
            }

            if (frmSep.txtManSig2.value != '') {
                frmSep.SigPlus2.JustifyX = 10;
                frmSep.SigPlus2.JustifyY = 10;
                frmSep.SigPlus2.AutoKeyStart();
                frmSep.SigPlus2.AutoKeyData = "Rupesh Patel";
                frmSep.SigPlus2.AutoKeyFinish();
                frmSep.SigPlus2.EncryptionMode = 2;
                frmSep.SigPlus2.SigCompressionMode = 1;
                frmSep.SigPlus2.DisplayPenWidth = 8;
                frmSep.SigPlus2.JustifyMode = 0;
                frmSep.SigPlus2.SigString = frmSep.txtManSig2.value;
            }

            //When all signatures got, don't allow them
            //to modify
            if (frmSep.txtEmpSig.value != '') {
                frmSep.cmdSign.disabled = true;
                frmSep.cmdClear.disabled = true;

                frmSep.cmdSign1.disabled = true;
                frmSep.cmdClear1.disabled = true;

                frmSep.cmdSign2.disabled = true;
                frmSep.cmdClear2.disabled = true;
            }
        }

        function ValidateSubmit() {
            if (ValidateData())
                // commented by hemangini on 12/8/2015
                //if (ValidateSig())
                //    if (confirm('Submit Request ?' + '\n' + '\n' + 'Separation Date : ' + document.getElementById("txtSepDate").value)) {
                //        if (frmSep.SigPlus.NumberOfTabletPoints > 0) {
                //            frmSep.SigPlus.TabletState = 0; //Turns tablet off
                //            frmSep.SigPlus.AutoKeyStart();
                //            frmSep.SigPlus.AutoKeyData = "Rupesh Patel";
                //            frmSep.SigPlus.AutoKeyFinish();
                //            frmSep.SigPlus.EncryptionMode = 2;
                //            frmSep.SigPlus.SigCompressionMode = 1;
                //            frmSep.txtEmpSig.value = frmSep.SigPlus.SigString;
                //        }

                //        if (frmSep.SigPlus1.NumberOfTabletPoints > 0) {
                //            frmSep.SigPlus1.TabletState = 0; //Turns tablet off
                //            frmSep.SigPlus1.AutoKeyStart();
                //            frmSep.SigPlus1.AutoKeyData = "Rupesh Patel";
                //            frmSep.SigPlus1.AutoKeyFinish();
                //            frmSep.SigPlus1.EncryptionMode = 2;
                //            frmSep.SigPlus1.SigCompressionMode = 1;
                //            frmSep.txtManSig.value = frmSep.SigPlus1.SigString;
                //        }

                //        if (frmSep.SigPlus2.NumberOfTabletPoints > 0) {
                //            frmSep.SigPlus2.TabletState = 0; //Turns tablet off
                //            frmSep.SigPlus2.AutoKeyStart();
                //            frmSep.SigPlus2.AutoKeyData = "Rupesh Patel";
                //            frmSep.SigPlus2.AutoKeyFinish();
                //            frmSep.SigPlus2.EncryptionMode = 2;
                //            frmSep.SigPlus2.SigCompressionMode = 1;
                //            frmSep.txtManSig2.value = frmSep.SigPlus2.SigString;
                //        }

                //        return true;
                //    }
                //    else
                //        return false;

                //return false;
            return true;
        }

        function ValidateUpdate() {
            if (ValidateData())
                if (ValidateSig())
                    if (confirm('Update Request ?')) {
                        if (frmSep.SigPlus.NumberOfTabletPoints > 0) {
                            frmSep.SigPlus.TabletState = 0; //Turns tablet off
                            frmSep.SigPlus.AutoKeyStart();
                            frmSep.SigPlus.AutoKeyData = "Rupesh Patel";
                            frmSep.SigPlus.AutoKeyFinish();
                            frmSep.SigPlus.EncryptionMode = 2;
                            frmSep.SigPlus.SigCompressionMode = 1;
                            frmSep.txtEmpSig.value = frmSep.SigPlus.SigString;
                        }

                        if (frmSep.SigPlus1.NumberOfTabletPoints > 0) {
                            frmSep.SigPlus1.TabletState = 0; //Turns tablet off
                            frmSep.SigPlus1.AutoKeyStart();
                            frmSep.SigPlus1.AutoKeyData = "Rupesh Patel";
                            frmSep.SigPlus1.AutoKeyFinish();
                            frmSep.SigPlus1.EncryptionMode = 2;
                            frmSep.SigPlus1.SigCompressionMode = 1;
                            frmSep.txtManSig.value = frmSep.SigPlus1.SigString;
                        }

                        if (frmSep.SigPlus2.NumberOfTabletPoints > 0) {
                            frmSep.SigPlus2.TabletState = 0; //Turns tablet off
                            frmSep.SigPlus2.AutoKeyStart();
                            frmSep.SigPlus2.AutoKeyData = "Rupesh Patel";
                            frmSep.SigPlus2.AutoKeyFinish();
                            frmSep.SigPlus2.EncryptionMode = 2;
                            frmSep.SigPlus2.SigCompressionMode = 1;
                            frmSep.txtManSig2.value = frmSep.SigPlus2.SigString;
                        }

                        return true;
                    }
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
                    if (confirm('Undo Approval for this request ?'))
                        return true;
                    else
                        return false;
                }
            }
            return false;
        }

        function SignLater() {
            var chkSignLater;
            var txtManName;
            var txtManName2;

            chkSignLater = document.getElementById("chkSignLater");
            txtManName = document.getElementById("txtManName");
            txtManName2 = document.getElementById("txtManName2");

            if (chkSignLater.checked) {
                //alert('Rupesh');
                frmSep.cmdClear.disabled = true;
                frmSep.cmdClear1.disabled = true;
                frmSep.cmdClear2.disabled = true;

                frmSep.cmdSign.disabled = true;
                frmSep.cmdSign1.disabled = true;
                frmSep.cmdSign2.disabled = true;

                txtManName.disabled = true;
                txtManName2.disabled = true;
            }
            else {
                frmSep.cmdClear.disabled = false;
                frmSep.cmdClear1.disabled = false;
                frmSep.cmdClear2.disabled = false;

                frmSep.cmdSign.disabled = false;
                frmSep.cmdSign1.disabled = false;
                frmSep.cmdSign2.disabled = false;

                txtManName.disabled = false;
                txtManName2.disabled = false;
            }
        }

    </script>
</head>
<body bgcolor="#FFF">   <%-- onload="LoadSig();" commented by hemangini on 12/8/2015--%>  
    <form id="frmSep" runat="server">
        <asp:ScriptManager ID="sm" runat="server" EnablePageMethods="true" ValidateRequestMode="Disabled"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>

                <!-- START CONTAINER FLUID -->
                <div class="container-fluid container-fixed-lg">
                    <!-- START PANEL -->
                    <div class="panel panel-transparent">

                        <div class="row" style="text-align: center; color: #069; font-family: 'Monotype Corsiva'; font-weight: bold; font-size: 25px; margin-top: 4px;">
                            Separate Employee
                        </div>

                        <div class="blue_line"></div>

                        <div class="row">
                            <div class="col-sm-12" style="text-align: center;">
                                <asp:Label ID="lblEmp" runat="server" Font-Bold="True" Width="605px"></asp:Label></strong>
                            </div>
                            <div class="blue_line"></div>
                            <div class="col-sm-12" style="text-align: center;">
                                <asp:Label ID="lblError" runat="server" Font-Bold="True" Visible="False" ForeColor="Red"></asp:Label>
                            </div>
                            <br />

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <%--<div class="panel-title"></div>--%>
                                            Seperation Date
                                        </div>
                                        <div class="col-sm-3">
                                            Date Last Worked
                                        </div>

                                        <div class="col-sm-4">
                                            Date Employee Gave Notice
                                        </div>

                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <asp:TextBox ID="txtSepDate" runat="server" Width="150px" Preset="shortdate" CssClass="form-control" BackColor="#E7E6E6"></asp:TextBox>
                                        </div>

                                        <div class="col-sm-3">
                                            <asp:TextBox ID="txtLastWork" runat="server" Width="150px" Preset="shortdate" CssClass="form-control" BackColor="#E7E6E6"></asp:TextBox>
                                        </div>

                                        <div class="col-sm-4">
                                            <asp:TextBox ID="txtSepNotified" runat="server" Width="200px" Preset="shortdate" CssClass="form-control" BackColor="#E7E6E6"></asp:TextBox>
                                        </div>

                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="row">
                                        <div class="col-sm-3">
                                            Seperation Reason
                                        </div>

                                        <div class="col-sm-4">
                                            Please Clarify
                                        </div>

                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <asp:DropDownList ID="cmbSepReason" runat="server" Width="152px" CssClass="form-control" BackColor="#E7E6E6"></asp:DropDownList>
                                        </div>
                                        <div class="col-sm-4">
                                            <asp:DropDownList ID="cmbSepCat" runat="server" Width="368px" CssClass="form-control" BackColor="#E7E6E6"></asp:DropDownList>
                                            <asp:DropDownList ID="cmbSepSubCat" runat="server" Width="64px" Visible="False" CssClass="form-control" BackColor="#E7E6E6"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            Describe the circumstance(s) leading to separation :
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <asp:TextBox ID="txtSepDesc" runat="server" Width="640px" CssClass="form-control" BackColor="#E7E6E6" TextMode="MultiLine"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            For final pay, Payroll should add the following hours
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <asp:TextBox ID="txtOtherDesc" runat="server" Width="380px" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                        </div>
                                        <div class="col-sm-5">
                                            <asp:CheckBox ID="chkFax" runat="server" Height="3px"></asp:CheckBox>
                                            <asp:Label ID="Label1" runat="server" Text="Employee worked today, I am faxing report to payroll"></asp:Label>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            Comments :
                                        </div>

                                        <div class="col-sm-2">
                                            HR Approval By :
                                        </div>

                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <asp:TextBox ID="txtEmpComm" runat="server" Width="380px" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                        </div>

                                        <div class="col-sm-2">
                                            <asp:TextBox ID="txtHRApproval" runat="server" Width="150px" CssClass="form-control" BackColor="#E7E6E6"></asp:TextBox>
                                        </div>

                                    </div>
                                </div>
                            </div>

                            <div class="blue_line"></div>

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <asp:CheckBox ID="chkMailFinalWages" runat="server" Font-Bold="True" Font-Names="Microsoft Sans Serif" Width="100px" Height="3px"></asp:CheckBox>
                                            <asp:Label ID="Label2" runat="server" Text="Employee verbally requested final wages be sent to the following address"></asp:Label>
                                        </div>

                                        <div class="col-sm-5" id="tblAdd" runat="server">
                                            <font face="Wingdings" color="#336699" size="5"><STRONG>F</STRONG></font>
                                            If different Address,<a onclick="GetNameAddChangeURL();" href="javascript: return true;">
                                            Click Here</a>to change it first
                                        </div>

                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="row">
                                        <div class="col-sm-4">
                                            <asp:Label ID="lblEmpAdd" runat="server" Font-Bold="True" Font-Size="XX-Small" Font-Names="Microsoft Sans Serif"
                                                Width="624px" ForeColor="CornflowerBlue" Height="8px"></asp:Label>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="blue_line"></div>

                            <div class="col-sm-12" style="text-align: center;" id="tblSignLater" runat="server">
                                <asp:CheckBox ID="chkSignLater" runat="server" Font-Bold="True" Font-Size="X-Small" Font-Names="Microsoft Sans Serif"></asp:CheckBox>
                                <asp:Label ID="Label3" runat="server" Text="Will Get Signatures Later"></asp:Label>
                            </div>

                            <div class="blue_line"></div>

                           <%-- <div class="row">
                                <div class="col-sm-12">
                                    <div class="row">
                                        <div class="col-sm-2">
                                            Employee Signature
                                        </div>
                                        <div class="col-sm-3">
                                            <asp:Button ID="cmdSign" runat="server" CssClass="btn-form" Text="Sign" OnClientClick="javascript:OnSign();" />
                                            <asp:Button ID="cmdClear" runat="server" CssClass="btn-form" Text="Clear" OnClientClick="javascript:OnClear();" />
                                        </div>
                                        <div class="col-sm-3">
                                            1st Witness Manager Signature
                                            <asp:Button ID="cmdSign1" runat="server" CssClass="btn-form" Text="Sign" OnClientClick="javascript:OnSign1();" />&nbsp&nbsp
                                            <asp:Button ID="cmdClear1" runat="server" CssClass="btn-form" Text="Clear" OnClientClick="javascript:OnClear1();" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <object style="WIDTH: 300px; HEIGHT: 100px; TOP: 0px; LEFT: 0px" id="SigPlus" name="SigPlus"
                                                classid="clsid:69A40DA3-4D42-11D0-86B0-0000C025864A" height="60" viewastext>
                                                <param name="_Version" value="131095">
                                                <param name="_ExtentX" value="7937">
                                                <param name="_ExtentY" value="2645">
                                                <param name="_StockProps" value="0">
                                            </object>
                                        </div>
                                        <div class="col-sm-3">
                                            <object style="WIDTH: 300px; HEIGHT: 100px; TOP: 0px; LEFT: 0px" id="SigPlus1" name="SigPlus1"
                                                classid="clsid:69A40DA3-4D42-11D0-86B0-0000C025864A" height="60" viewastext>
                                                <param name="_Version" value="131095">
                                                <param name="_ExtentX" value="7937">
                                                <param name="_ExtentY" value="2645">
                                                <param name="_StockProps" value="0">
                                            </object>
                                            <br />
                                            Manager Name
                                            <asp:TextBox ID="txtManName" runat="server" CssClass="form-control" Width="211px" BackColor="#E7E6E6"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="row">
                                        <div class="col-sm-2">
                                            2nd Witness Manager Signature
                                        </div>
                                        <div class="col-sm-3">
                                            <asp:Button ID="cmdSign2" runat="server" CssClass="btn-form" Text="Sign" OnClientClick="javascript:OnSign2();" />&nbsp&nbsp
                                             <asp:Button ID="cmdClear2" runat="server" CssClass="btn-form" Text="Clear" OnClientClick="javascript:OnClear2();" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="row">
                                        <object style="WIDTH: 300px; HEIGHT: 100px; TOP: 0px; LEFT: 0px" id="SigPlus2" name="SigPlus2"
                                            classid="clsid:69A40DA3-4D42-11D0-86B0-0000C025864A" height="60" viewastext>
                                            <param name="_Version" value="131095">
                                            <param name="_ExtentX" value="7937">
                                            <param name="_ExtentY" value="2645">
                                            <param name="_StockProps" value="0">
                                        </object>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="row">
                                        <div class="col-sm-1">
                                            Manager Name
                                            <asp:TextBox ID="txtManName2" runat="server" CssClass="form-control" Width="211px" BackColor="#E7E6E6"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>--%>

                            <div>
                                <asp:TextBox ID="txtHSepReason" runat="server" Width="16px" Visible="False" Height="16px"></asp:TextBox>
                                <asp:TextBox ID="txtEmpSig" runat="server" Style="display: none;"></asp:TextBox>
                                <asp:TextBox ID="txtManSig" runat="server" Style="display: none;"></asp:TextBox>
                                <asp:TextBox ID="txtId" runat="server" Style="display: none;"></asp:TextBox>
                                <asp:TextBox ID="txtEmpName" runat="server" Width="16px" Visible="False"></asp:TextBox>
                                <asp:TextBox ID="txtSecCode" runat="server" Style="display: none;"></asp:TextBox>
                                <asp:TextBox ID="txtManClockId" runat="server" Width="24px" Visible="False" Height="17px"></asp:TextBox>
                                <asp:TextBox ID="txtClockId" runat="server" Style="display: none;"></asp:TextBox>
                                <asp:TextBox ID="txtCatId" runat="server" Style="display: none;"></asp:TextBox>
                                <asp:TextBox ID="txtSubCatId" runat="server" Style="display: none;"></asp:TextBox>
                                <asp:TextBox ID="txtHCatId" runat="server" Style="display: none;"></asp:TextBox>
                                <asp:TextBox ID="txtHSubCatId" runat="server" Style="display: none;"></asp:TextBox>
                                <asp:TextBox ID="txtManSig2" runat="server" Style="display: none;"></asp:TextBox>
                                <asp:TextBox ID="txtChangeTypeId" runat="server" Style="display: none;"></asp:TextBox>
                                <asp:TextBox ID="txtEmpUnit" runat="server" Style="display: none;"></asp:TextBox>
                                <asp:TextBox ID="txtCatName" runat="server" Style="display: none;"></asp:TextBox>
                            </div>

                            <div class="row" id="tblUndoGMApproval" runat="server">
                                <div class="col-sm-12">
                                    <div class="row">
                                        <div class="col-sm-2">
                                            Undo Approval Notes
                                        </div>
                                        <div class="col-sm-3">
                                            <asp:TextBox ID="txtUndoNotes" runat="server" Width="512px" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="blue_line"></div>
                            </div>

                            <%--<div class="blue_line"></div>--%>

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="">
                                        <asp:Button ID="cmdPost" runat="server" Width="110px" CssClass="btn-form" Text="Post"></asp:Button>
                                        <asp:Button ID="cmdApprove" runat="server" Width="110px" CssClass="btn-form" Text="Approve"></asp:Button>
                                        <asp:Button ID="cmdUpdate" runat="server" Width="110px" CssClass="btn-form" Text="Update"></asp:Button>
                                        <asp:Button ID="cmdDeny" runat="server" Width="110px" CssClass="btn-form" Text="Deny"></asp:Button>
                                        <asp:Button ID="cmdSubmit" runat="server" Width="110px" CssClass="btn-form" Text="Submit"></asp:Button>
                                        <asp:Button ID="cmdExit" runat="server" Width="110px" CssClass="btn-form" Text="Exit" OnClientClick="javascript:window.close();"></asp:Button>
                                        <asp:Button ID="cmdReview" runat="server" Width="110px" Visible="false" CssClass="btn-form" Text="Send For Review"></asp:Button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END PANEL -->
                </div>
                <!-- END CONTAINER FLUID -->
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</body>
</html>
