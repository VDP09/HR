<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EmpHire.aspx.vb" Inherits="Web_CJEmployeeInfo.EmpHire" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../assets/plugins/boostrapv3/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../pages/css/pages.css" rel="stylesheet" />
    <title>Employee New Hire / Re-Hire</title>
    <script src="../Scripts/NumberFormat.js"></script>
    <httphandlers> 
			<add verb="*" path="MetaBuilders_WebControls_DynamicListBoxResourceHandler.axd" 
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
                                'If you want to go outside this range, submit request with rate in the above range and then call HR to change before processing.');
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
                        // lstJobCode.Add(intJobCode, cmbJobCode.options(cmbJobCode.selectedIndex).text + '  |  ' + formatNumber(txtPayRate.value, '0.00') + '  |  Primary' + '  *');
                        var option = document.createElement("OPTION");
                        option.innerHTML = cmbJobCode.options(cmbJobCode.selectedIndex).text + '  |  ' + formatNumber(txtPayRate.value, '0.00') + '  |  Primary' + '  *';
                        option.value = intJobCode;
                        lstJobCode.appendChild(option);
                    }
                }
                else {
                    //  lstJobCode.Add(intJobCode, cmbJobCode.options(cmbJobCode.selectedIndex).text + '  |  ' + formatNumber(txtPayRate.value, '0.00') + '  *');
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
                // lstJobCode.Remove(lstJobCode.options.selectedIndex);  //options[lstJobCode.selectedIndex] = null;
                for (var i = 0; i < lstJobCode.options.length; i++) {
                    if (lstJobCode.options[i].selected == true) {
                        lstJobCode.removeChild(lstJobCode.options[i]);
                    }
                }
            }
        }

        function TrimString(sInString) {
            sInString = sInString.replace(/^\s+/g, "");// strip leading
            return sInString.replace(/\s+$/g, "");// strip trailing
        }

        function AddRemoveGroup(i) {
            var lstEmpGroups;
            var lstAllGroups;

            lstEmpGroups = document.getElementById("lstEmpGroups");
            lstAllGroups = document.getElementById("lstAllGroups");

            if (i == 0) {
                var j = lstAllGroups.selectedIndex;
                lstEmpGroups.Add(0, lstAllGroups.options(j).text);
                lstAllGroups.Remove(lstAllGroups.options.selectedIndex);

                //lstEmpGroups.options[lstEmpGroups.length]=new Option(lstAllGroups.options(j).text, 0);
                //lstAllGroups.options[j] = null;
            }
            else if (i == 1) {
                var j = lstEmpGroups.selectedIndex;
                lstAllGroups.Add(0, lstEmpGroups.options(j).text);	//options[lstAllGroups.length]=new Option(lstEmpGroups.options(j).text, 0);
                lstEmpGroups.Remove(lstEmpGroups.options.selectedIndex); //lstEmpGroups.options[j] = null;
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

        function UpdateLegalName() {
            var txtFName;
            var txtMName;
            var txtLName;
            var txtLegalName;
            var strLegal;

            txtFName = document.getElementById("txtFName");
            txtLName = document.getElementById("txtLName");
            txtMName = document.getElementById("txtMName");
            txtLegalName = document.getElementById("txtLegalName");

            strLegal = txtFName.value;
            if (!isBlank(txtMName.value))
                strLegal = strLegal + ' ' + txtMName.value;

            strLegal = strLegal + ' ' + txtLName.value;
            txtLegalName.value = strLegal;
        }

        function ValidateData() {
            var strAlert;
            var strConfirm;
            var strConfirm1;

            var cmbUnit;
            //var cmbManager;
            var txtFName;
            var txtLName;
            var txtAdd1;
            var txtCity;
            var cmbState;
            var txtZip;
            var txtHomePh;
            var cmbGender;
            var txtSSN;
            var cmbSalStatus;
            var txtHireDate;
            var txtLegalName;
            var cmbEthnicity;
            var cmbEmpReferral;
            var cmbI9Status;

            var cmbFedMarital;
            var cmbStateMarital;
            var txtFedExempNo;
            var txtStateExempNo;
            var txtId;
            var chkFedClEx;
            var chkStateClEx;

            var cmbA4Ded;
            var txtBirthDate;
            var cmbCompany;

            var cmbEducation;
            var cmbRecruiter;

            var blnFoundPrimary;
            var j;
            var strItem;
            var strItemValues;
            var lstJobCode;

            /*				
            var txtClockId;
            var txtLoginName;
            var txtWorkEmail;
            var lstGroup;
            var chkADS;
            var chkADS1;
            */

            //cmbUnit = document.getElementById("cmbStore");
            //cmbManager =document.getElementById("cmbManager");
            txtFName = document.getElementById("txtFName");
            txtLName = document.getElementById("txtLName");
            txtAdd1 = document.getElementById("txtAdd1");
            txtCity = document.getElementById("txtCity");
            cmbState = document.getElementById("cmbState");
            txtZip = document.getElementById("txtZip");
            txtHomePh = document.getElementById("txtHomePh");
            cmbGender = document.getElementById("cmbGender");
            txtSSN = document.getElementById("txtSSN");
            cmbSalStatus = document.getElementById("cmbSalaryStatus");
            txtHireDate = document.getElementById("txtHireDate");
            txtLegalName = document.getElementById("txtLegalName");
            cmbEthnicity = document.getElementById("cmbEthnicity");
            cmbEmpReferral = document.getElementById("cmbEmpReferral");
            cmbI9Status = document.getElementById("cmbI9Status");

            cmbFedMarital = document.getElementById("cmbFedMarital");
            cmbStateMarital = document.getElementById("cmbStateMarital");
            txtFedExempNo = document.getElementById("txtFedExempNo");
            txtStateExempNo = document.getElementById("txtStateExempNo");
            txtId = document.getElementById("txtId");
            chkFedClEx = document.getElementById("chkFedClEx");
            chkStateClEx = document.getElementById("chkStateClEx");

            cmbA4Ded = document.getElementById("cmbA4Ded");
            txtBirthDate = document.getElementById("txtBirthDate");
            cmbCompany = document.getElementById("cmbCompany");

            cmbEducation = document.getElementById("cmbEducation");
            cmbRecruiter = document.getElementById("cmbRecruiter");

            /*
            txtClockId = document.getElementById("txtClockId");
            txtLoginName = document.getElementById("txtLoginName");
            txtWorkEmail = document.getElementById("txtWorkEmail");
            lstGroup = document.getElementById("lstEmpGroups");
            */

            blnFoundPrimary = false;
            lstJobCode = document.getElementById("lstJobCode");

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

            //Update Legal Name in case it is not updated
            UpdateLegalName();

            if (isBlank(txtFName.value) || isBlank(txtLName.value) ||
                isBlank(txtAdd1.value) || isBlank(txtCity.value) ||
                isBlank(cmbState.options(cmbState.selectedIndex).text) ||
                isBlank(txtZip.value) ||
                isBlank(txtHomePh.value) ||
                isBlank(cmbGender.options(cmbGender.selectedIndex).text) ||
                isBlank(txtSSN.value) ||
                isBlank(cmbSalStatus.options(cmbSalStatus.selectedIndex).text) ||
                isBlank(txtHireDate.value) || isBlank(txtLegalName.value) ||
                isBlank(cmbEthnicity.options(cmbEthnicity.selectedIndex).text) ||
                isBlank(cmbEmpReferral.options(cmbEmpReferral.selectedIndex).text) ||
                isBlank(cmbI9Status.options(cmbI9Status.selectedIndex).text) ||
                isBlank(cmbFedMarital.options(cmbFedMarital.selectedIndex).text) ||
                isBlank(cmbStateMarital.options(cmbStateMarital.selectedIndex).text) ||
                isBlank(txtFedExempNo.value) ||
                isBlank(txtStateExempNo.value) ||
                isBlank(txtBirthDate.value) ||
                isBlank(cmbEducation.options(cmbEducation.selectedIndex).text) ||
                isBlank(cmbRecruiter.options(cmbRecruiter.selectedIndex).text)) {
                strAlert = 'Following are required fields .. Please check it out' +
                            '\n' + '\n' +
                            'First Name' + '\n' + 'Last Name' +
                            '\n' + 'Address1' + '\n' + 'City' + '\n' + 'State' +
                            '\n' + 'Zip' + '\n' + 'Gender' + '\n' + 'SSN' +
                            '\n' + 'Home Phone' +
                            '\n' + 'Birth Date' + '\n' + 'Salary Status' +
                            '\n' + 'Hire Date' + '\n' + 'Legal Name' + '\n' + 'Ethnicity' +
                            '\n' + 'How Employee Referred' + '\n' + 'I-9 Status' + '\n' +
                            'Marital Status' + '\n' + '# of Exemptions' +
                            '\n' + 'Education' +
                            '\n' + 'Recruiter';

                alert(strAlert);
                return false;
            }

            //Check hire date ..
            if (!CheckDateEff(txtHireDate.value)) {
                alert('Invalid Hire Date .. Please check it out');
                return false;
            }


            if (frmEmpHire.txtSecCode.value == 8) {
                var cmbStore;
                cmbStore = document.getElementById("cmbStore");

                if (isBlank(cmbStore.options(cmbStore.selectedIndex).text)) {
                    strAlert = 'Follwing field is required .. Please check it out' +
                                '\n' + '\n' + 'Store';
                    alert(strAlert);
                    return false;
                }
            }

            //Check only when posting request ..
            if (frmEmpHire.txtSecCode.value == 5 || frmEmpHire.txtSecCode.value == 6 ||
                frmEmpHire.txtSecCode.value == 7) {
                if (isBlank(cmbCompany.options(cmbCompany.selectedIndex).text)) {
                    strAlert = 'Following is required field .. Please check it out' +
                                '\n' + '\n' + 'Company';
                    alert(strAlert);
                    return false;
                }
            }


            if (cmbI9Status.options(cmbI9Status.selectedIndex).text == 'Employment Authorization' ||
                cmbI9Status.options(cmbI9Status.selectedIndex).text == 'Permanent Resident Card' ||
                cmbI9Status.options(cmbI9Status.selectedIndex).text == 'Refugee') {
                var txtExpDate;
                var txtAlienNo;

                txtExpDate = document.getElementById("txtExpDate");
                txtAlienNo = document.getElementById("txtAlienNo");

                if (cmbI9Status.options(cmbI9Status.selectedIndex).text == 'Employment Authorization' ||
                    cmbI9Status.options(cmbI9Status.selectedIndex).text == 'Permanent Resident Card') {
                    if (isBlank(txtExpDate.value) || isBlank(txtAlienNo.value)) {
                        alert('Following fields are required for the selected I-9 status .. Please check it out' +
                            '\n' + '\n' + 'Exp. Date' + '\n' + 'Alien #');
                        return false;
                    }
                }


                if (cmbI9Status.options(cmbI9Status.selectedIndex).text == 'Refugee' &&
                    isBlank(txtAlienNo.value)) {
                    alert('Following fields are required for the selected I-9 status .. Please check it out' +
                        '\n' + '\n' + 'Alien #');
                    return false;
                }
            }

            //Employee can not claim Exempt and put # of Exemptions
            //same time. It has to be either one.
            if ((chkFedClEx.checked && txtFedExempNo.value > 0) ||
                (chkStateClEx.checked && txtStateExempNo.value > 0)) {
                alert('Employee can not Claim Exempt and have # of Exemptions together. It has to be either one .. Please check it out');
                return false;
            }

            //A4 Ded should be blank if state is not AZ
            if (!isBlank(cmbA4Ded.options(cmbA4Ded.selectedIndex).text) &&
                cmbState.options(cmbState.selectedIndex).text != 'AZ') {
                alert('Employee can claim A4 Deductions only if he/she lives in AZ .. Please check it out');
                return false;
            }

            //# of Exemptions should be numeric
            if ((txtFedExempNo.value - 0 != txtFedExempNo.value) ||
                (txtStateExempNo.value - 0 != txtStateExempNo.value)) {
                alert('# of Exemptions should be numeric .. Please check it out');
                return false;
            }

            //Check to see if worker is minor and needs work permit in CA Only
            if (cmbState.options(cmbState.selectedIndex).text == 'CA') {
                var d1;
                var d2;
                var Day;
                var Month;
                var Year;
                var BDay;
                var BMonth;
                var BYear;
                var Minor;

                var txtWPExpDate;
                txtWPExpDate = document.getElementById("txtWPExpDate");

                d1 = new Date();
                d2 = new Date(txtBirthDate.value);

                //d3 = new Date();
                //d3.setTime(d1.getTime() - d2.getTime());
                //timediff = d3.getTime();

                //alert(d3.getFullYear());

                Day = d1.getDate();
                Month = d1.getMonth() + 1;
                Year = d1.getFullYear();

                BDay = d2.getDate();
                BMonth = d2.getMonth() + 1;
                BYear = d2.getFullYear();

                //alert(d2.getFullYear());
                //alert(d2.getMonth());
                //alert(d2.getDate());
                //days = Math.floor(timediff / (1000 * 60 * 60 * 24)); 
                //alert(days);
                //alert(365*18);

                Minor = false;

                if (Year - BYear < 18) {
                    Minor = true;
                }
                else if (Year - BYear == 18) {
                    if (Month < BMonth) {
                        Minor = true;
                    }
                    else if (Month == BMonth) {
                        if (Day < BDay) {
                            Minor = true;
                        }
                    }
                }

                if (Minor && isBlank(txtWPExpDate.value)) {
                    alert('Employee is under 18 years .. Following field is required .. Please check it out' +
                        '\n' + '\n' + 'Work Permit Expiration Date');
                    return false;
                }

                /*
                if((days < (365*18)) && isBlank(txtWPExpDate.value))
                {
                    alert('Employee is under 18 years .. Following field is required .. Please check it out' +
                        '\n' + '\n' + 'Work Permit Expiration Date');
                    return false;
                }
                */
            }


            if (txtId.value > 0)		// Posting mode
            {
                var txtLoginName;
                var txtWorkEmail;
                var txtDispName;
                var chkNeedsLogin;

                txtLoginName = document.getElementById("txtLoginName");
                txtWorkEmail = document.getElementById("txtWorkEmail");
                txtDispName = document.getElementById("txtDispName");
                chkNeedsLogin = document.getElementById("chkNeedsLogin");

                if (chkNeedsLogin.checked) {
                    if (isBlank(txtLoginName.value) || isBlank(txtWorkEmail.value) ||
                        isBlank(txtDispName.value)) {
                        alert('Following are required if employee needs windows login .. Please check it out' +
                            '\n' + 'Login Name' + '\n' + 'Work Email' + '\n' + 'Display Name');
                        return false;
                    }
                }
            }


            /*
            //chkADS - Create Login
            //chkADS1 - Remove Login
            
            if((txtClockId.value == '0') || (isBlank(txtLoginName.value) && isBlank(txtWorkEmail.value)))
            {
                //alert('came 1');
                chkADS = document.getElementById("chkADS");
            
                if(chkADS.checked)
                    if(isBlank(txtLoginName.value) || isBlank(txtWorkEmail.value))
                    {
                        strAlert = 'Following fields are required, if you want to create windows login' +
                            '\n' + '\n' + 'Login Name' +
                            '\n' + 'Work Email';
                        alert(strAlert);
                        return false;
                    }
            }
            else
            {
                //alert('came 1');
                chkADS1 = document.getElementById("chkADS1");
            
                if(!chkADS1.checked)
                    if(isBlank(txtLoginName.value) || isBlank(txtWorkEmail.value))
                    {
                        strAlert = 'Following fields are required .. Please check it out' +
                            '\n' + '\n' + 'Login Name' +
                            '\n' + 'Work Email';
                        alert(strAlert);
                        return false;
                    }
            }
            
            
            
            if(cmbStatus.value == 'Terminated')
            {
                if(isBlank(txtTermDate.value))
                {
                    alert('Term. Date is required, when employee is terminated .. Please check it out');
                    return false;
                }
                else
                {
                    strConfirm1 = 'Employee will be Terminated .. Proceed ?';
                }	
            }
            else
            {
                strConfirm1 = '';
            }
                
            //alert('came 0');
            //return true;
            
            if((txtClockId.value == '0') || (isBlank(txtLoginName.value) && isBlank(txtWorkEmail.value)))
            {
                //alert('came 1');
                if(!isBlank(strConfirm1))
                {
                    strConfirm = 'Save Changes ?' + '\n' + '\n' + strConfirm1;
                }
                else
                {
                    if(chkADS.checked)
                        strConfirm = 'Save Changes ?' + '\n' + '\n' + 'Windows Login will be CREATED .. Proceed ?';
                    else
                        strConfirm = 'Save Changes ?' + '\n' + '\n' + 'Windows Login will NOT BE CREATED .. Proceed ?';
                }
            }	
            else
            {
                if(!isBlank(strConfirm1))
                {
                    strConfirm = 'Save Changes ?' + '\n' + '\n' + strConfirm1;
                }
                else
                {
                    if(chkADS1.checked)
                        strConfirm = 'Save Changes ?' + '\n' + '\n' + 'Windows Login will be REMOVED .. Proceed ?';
                    else
                        strConfirm = 'Save Changes ?';
                }
            }
            */

            return true;
        }

        function ValidateSubmit() {
            if (ValidateData())
                if (confirm('Submit Request ?' + '\n' + '\n' + 'If you click OK, DO NOT CLOSE this window until you see message'))
                    return true;
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

        function ValidateUpdate() {
            if (ValidateData())
                if (confirm('Update Request ?'))
                    return true;
                else
                    return false;

            return false;

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
            function CheckDateEff(dd) {
                var d1;
                var d2;
                var d3;
                var DateEff;

                DateEff = new Date(dd);
                d1 = new Date();
                d2 = new Date();

                d1.setMonth(d1.getMonth() + 2);
                d2.setMonth(d2.getMonth() - 2);

                if (DateEff > d1 && DateEff < d2)
                    return false;
                else
                    return true;
            }
            function LoginChecked() {

                //alert('came');
                //return false;

                /*
                var txtId;
                txtId = document.getElementById("txtFName");
                */

                //alert(frmEmpHire.txtId.value);
                //return true;


                if (frmEmpHire.txtId.value > 0)
                    return true;
                else
                    return false;
            }

            function UpdateBenefitDate() {
                var txtHireDate;
                var txtBenefitDate;

                txtHireDate = document.getElementById("txtHireDate");
                txtBenefitDate = document.getElementById("txtBenefitDate");

                txtBenefitDate.value = txtHireDate.value;
            }
        }
    </script>
</head>
<body bgcolor="#FFF">
    <form id="frmEmpHire" method="post" runat="server">
        <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>

        <!-- START CONTAINER FLUID -->
        <div class="container-fluid container-fixed-lg">
            <!-- START PANEL -->
            <div class="panel panel-transparent">

                <div class="row" style="text-align: center; color: #069; font-family: 'Monotype Corsiva'; font-weight: bold; font-size: 25px; margin-top: 4px;">
                    Employee New Hire / Re-Hire
                </div>

                <div class="blue_line"></div>

                <div class="row">
                    <div class="row" id="tblClockId" runat="server">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-11">
                                    ClockId :
                                </div>
                                <div class="col-sm-5">
                                    <asp:TextBox ID="txtClockId" runat="server" Enabled="False" ForeColor="Black" Preset="phone" CssClass="form-control" Width="136px"></asp:TextBox>
                                </div>
                                <div class="col-sm-3">
                                    ReHire ?
                                </div>
                                <div class="col-sm-1">
                                    <asp:CheckBox ID="chkReHire" runat="server" Enabled="false" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" id="tblCompany" runat="server" style="margin-top: 5px;">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-11">
                                    Company :
                                </div>
                                <div class="col-sm-11">
                                    <asp:DropDownList ID="cmbCompany" runat="server" Width="138px" CssClass="form-control" BackColor="#E7E6E6"></asp:DropDownList>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" style="margin-top: 5px;">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-11">
                                    Store :
                                </div>
                                <div class="col-sm-5">
                                    <asp:TextBox ID="txtStore" runat="server" Enabled="False" ForeColor="Black" CssClass="form-control" Width="136px"></asp:TextBox>
                                    <asp:DropDownList ID="cmbStore" runat="server" Width="138px" CssClass="form-control" BackColor="#E7E6E6"></asp:DropDownList>
                                </div>
                                <div class="col-sm-3">
                                    Employee's Manager
                                </div>
                                <div class="col-sm-3">
                                    <asp:DropDownList ID="cmbManager" runat="server" Width="184px" CssClass="form-control"></asp:DropDownList>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-12" style="color: white; height: 25px; font-weight: 100; font-size: 13px; margin-top: 8px; margin-bottom: 6px; text-align: center; background-color: #069;">
                                    Demographic(First,&nbsp;Middle &amp; Last name must match SS Card)
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-1">
                                    First
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <asp:TextBox ID="txtFName" runat="server" Width="160px" BackColor="#E7E6E6" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="col-sm-1" style="margin-left: 13px;">
                                    Middle
                                </div>
                                <div class="col-sm-2">
                                    <div class="form-group">
                                        <asp:TextBox ID="txtMName" runat="server" Width="120px" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-sm-2" style="margin-left: 13px;">
                                    Last
                                </div>
                                <div class="col-sm-2">
                                    <div class="form-group">
                                        <asp:TextBox ID="txtLName" runat="server" Width="120px" BackColor="#E7E6E6" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-1">
                                    Address1
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <asp:TextBox ID="txtAdd1" runat="server" CssClass="form-control" Width="160px" BackColor="#E7E6E6"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="col-sm-1" style="margin-left: 13px;">
                                    Apt. #
                                </div>
                                <div class="col-sm-2">
                                    <div class="form-group">
                                        <asp:TextBox ID="txtAdd2" runat="server" CssClass="form-control" Width="120px"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-sm-2" style="margin-left: 13px;">
                                    City
                                </div>
                                <div class="col-sm-2">
                                    <div class="form-group">
                                        <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" Width="120px" BackColor="#E7E6E6"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-1">
                                    State
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <asp:DropDownList ID="cmbState" runat="server" Width="120px" CssClass="form-control" BackColor="#E7E6E6"></asp:DropDownList>
                                    </div>
                                </div>

                                <div class="col-sm-1" style="margin-left: 13px;">
                                    Zip
                                </div>
                                <div class="col-sm-2">
                                    <div class="form-group">
                                        <asp:TextBox ID="txtZip" runat="server" CssClass="form-control" Width="120px" BackColor="#E7E6E6"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-sm-2" style="margin-left: 13px;">
                                    Nick Name
                                </div>
                                <div class="col-sm-2">
                                    <div class="form-group">
                                        <asp:TextBox ID="txtDispName" runat="server" CssClass="form-control" Width="120px"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-1">
                                    Gender
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <asp:DropDownList ID="cmbGender" runat="server" Width="120px" CssClass="form-control" BackColor="#E7E6E6"></asp:DropDownList>
                                    </div>
                                </div>

                                <div class="col-sm-1" style="margin-left: 13px;">
                                    SSN
                                </div>
                                <div class="col-sm-2">
                                    <div class="form-group">
                                        <asp:TextBox ID="txtSSN" runat="server" Preset="ssn" CssClass="form-control" Width="120px" BackColor="#E7E6E6"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-sm-2" style="margin-left: 13px;">
                                    Birth Date
                                </div>
                                <div class="col-sm-2">
                                    <div class="form-group">
                                        <asp:TextBox ID="txtBirthDate" runat="server" Preset="shortdate" CssClass="form-control" Width="120px" BackColor="#E7E6E6"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-1">
                                </div>
                                <div class="col-sm-3">
                                </div>

                                <div class="col-sm-1" style="margin-left: 13px;">
                                </div>
                                <div class="col-sm-4">
                                    <asp:CheckBox ID="chkSSNOk" runat="server"></asp:CheckBox>
                                    <asp:Label ID="Label1" runat="server" Text="Original SS Card Seen"></asp:Label>
                                </div>
                                <div class="col-sm-1" style="margin-left: 13px;">
                                </div>
                                <div class="col-sm-2">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-12" style="color: white; height: 25px; font-weight: 100; font-size: 13px; margin-top: 8px; margin-bottom: 6px; text-align: center; background-color: #069;">
                                    Contact
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-2">
                                    Work Phone
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <asp:TextBox ID="txtWorkPh" runat="server" Preset="phone" CssClass="form-control" Width="152px"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-sm-1">
                                    <strong>x</strong>
                                </div>
                                <div class="col-sm-2">
                                    <asp:TextBox ID="txtWorkExt" runat="server" CssClass="form-control" Width="64px"></asp:TextBox>
                                </div>
                                <div class="col-sm-2" style="margin-left: 13px;">
                                    Home Phone
                                </div>
                                <div class="col-sm-2">
                                    <div class="form-group">
                                        <asp:TextBox ID="txtHomePh" runat="server" Preset="phone" CssClass="form-control" Width="152px" BackColor="#E7E6E6"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-2">
                                    Cell Phone
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <asp:TextBox ID="txtCellPh" runat="server" Preset="phone" CssClass="form-control" Width="152px"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-sm-1">
                                </div>
                                <div class="col-sm-2">
                                </div>
                                <div class="col-sm-2" style="margin-left: 13px;">
                                    Personal Email
                                </div>
                                <div class="col-sm-2">
                                    <div class="form-group">
                                        <asp:TextBox ID="txtPEmail" runat="server" CssClass="form-control" Width="152px"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-12" style="color: white; height: 25px; font-weight: 100; font-size: 13px; margin-top: 8px; margin-bottom: 6px; text-align: center; background-color: #069;">
                                    Work
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-2">
                                    Hire Date
                                </div>
                                <div class="col-sm-2">
                                    <div class="form-group">
                                        <asp:TextBox ID="txtHireDate" runat="server" Preset="shortdate" CssClass="form-control" Width="104px" BackColor="#E7E6E6"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-sm-2">
                                    Salary Status
                                </div>
                                <div class="col-sm-2">
                                    <asp:DropDownList ID="cmbSalaryStatus" runat="server" Width="112px" CssClass="form-control" BackColor="#E7E6E6"></asp:DropDownList>
                                </div>
                                <div class="col-sm-2" style="margin-left: 13px;">
                                    Job Title
                                </div>
                                <div class="col-sm-2">
                                    <div class="form-group">
                                        <asp:DropDownList ID="cmbJobTitle" runat="server" Width="161px" CssClass="form-control"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-2">
                                    Benefit Date
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <asp:TextBox ID="txtBenefitDate" runat="server" Preset="shortdate" CssClass="form-control" Width="104px"></asp:TextBox>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <table id="Table7" border="0" cellspacing="0" cellpadding="0" width="100%">
                                    <tr>
                                        <td style="HEIGHT: 2px" width="100%" colspan="6" align="center"><font size="1">&nbsp;</font></td>
                                    </tr>
                                    <tr>
                                        <td style="HEIGHT: 83px" width="100%" colspan="6" align="center">
                                            <table style="WIDTH: 650px; HEIGHT: 110px" id="Table25" border="2" cellspacing="0" bordercolor="#669999"
                                                cellpadding="0" width="650">
                                                <tr>
                                                    <td style="WIDTH: 304px" valign="top">
                                                        <table style="WIDTH: 302px; HEIGHT: 57px" id="Table26" border="0" cellspacing="0" cellpadding="0"
                                                            width="302">
                                                            <tr>
                                                                <td style="HEIGHT: 21px" bgcolor="#006699" align="center">
                                                                    <asp:Label ID="lblDepartment" runat="server" Font-Bold="True" Font-Names="Microsoft Sans Serif"
                                                                        Width="304px" Font-Size="XX-Small" BackColor="#006699" ForeColor="White"> Employee's Departments - Pay Rates</asp:Label></td>
                                                            </tr>
                                                            <tr>
                                                                <td style="HEIGHT: 16px" align="center"><font color="black" size="1" face="MS Sans Serif">Department&nbsp; 
																			| &nbsp;Pay Rate ($)&nbsp; |&nbsp; Primary</font></td>
                                                            </tr>
                                                            <tr>
                                                                <td align="center"><%--<mb:dynamiclistbox id="lstJobCode" runat="server" Font-Names="Verdana" Width="288px" Height="67px"
																			Font-Size="XX-Small" BackColor="PapayaWhip"></mb:dynamiclistbox>--%>
                                                                    <asp:ListBox ID="lstJobCode" runat="server" CssClass="form-control" Width="288px" Height="74px"></asp:ListBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="HEIGHT: 27px" align="left"><font size="1" face="Verdana">&nbsp; * 
																			Modified&nbsp;&nbsp;&nbsp;&nbsp; </font>
                                                                    <input style="FONT-FAMILY: 'Microsoft Sans Serif';" class="btn-form"
                                                                        id="cmdRemoveJobCode" onclick="AddRemoveJobCode(1);" value="Remove Department" type="button" name="cmdRemoveJobCode"></td>
                                                            </tr>
                                                            <tr><td style="height:5px;"></td></tr>
                                                        </table>
                                                    </td>
                                                    <td valign="top">
                                                        <table style="WIDTH: 338px; HEIGHT: 60px" id="Table27" border="0" cellspacing="0" cellpadding="0"
                                                            width="338">
                                                            <tr>
                                                                <td style="HEIGHT: 21px" bgcolor="#006699" align="center"><font color="white" size="1" face="Microsoft Sans Serif"><STRONG>Add&nbsp;Department 
																				- Pay Rate</STRONG></font></td>
                                                            </tr>
                                                            <tr>
                                                                <td style="HEIGHT: 105px">
                                                                    <table style="WIDTH: 338px; HEIGHT: 36px" id="Table28" border="0" cellspacing="0" cellpadding="2"
                                                                        width="338">
                                                                        <tr>
                                                                            <td style="WIDTH: 82px; HEIGHT: 5px"><font size="2" face="Arial"><STRONG><FONT size="1" face="MS Sans Serif"><STRONG><FONT size="2" face="Arial"><STRONG><FONT size="1" face="MS Sans Serif"><STRONG>&nbsp; 
																													Department</STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></font></td>
                                                                            <td style="HEIGHT: 5px">
                                                                                <asp:DropDownList ID="cmbJobCode" runat="server" Width="240px" CssClass="form-control"></asp:DropDownList></td>
                                                                        </tr>
                                                                        <tr><td style="height:5px;"></td></tr>
                                                                        <tr>
                                                                            <td style="WIDTH: 82px; HEIGHT: 4px"><font size="2" face="Arial"><STRONG><FONT size="1" face="MS Sans Serif"><STRONG><FONT size="2" face="Arial"><STRONG><FONT size="1" face="MS Sans Serif"><STRONG>&nbsp; 
																													Pay Rate ($)</STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></font></td>
                                                                            <td style="HEIGHT: 4px">
                                                                                <asp:TextBox ID="txtPayRate" runat="server" Preset="currency" Width="136px" CssClass="form-control"></asp:TextBox></td>
                                                                        </tr>
                                                                        <tr><td style="height:5px;"></td></tr>
                                                                        <tr>
                                                                            <td style="WIDTH: 82px"><font size="2" face="Arial"><STRONG><FONT size="1" face="MS Sans Serif"><STRONG><FONT size="2" face="Arial"><STRONG><FONT size="1" face="MS Sans Serif"><STRONG>&nbsp; 
																													Primary ?</STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></font></td>
                                                                            <td>
                                                                                <asp:CheckBox ID="chkPrimary" runat="server"></asp:CheckBox></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="WIDTH: 82px"></td>
                                                                            <td>
                                                                                <input style="FONT-FAMILY: 'Microsoft Sans Serif';" class="btn-form"
                                                                                    id="cmdAddNewJob" onclick="AddRemoveJobCode(0);" value="<< Add" type="button" name="cmdAddNewJob"></td>
                                                                        </tr>
                                                                        <tr><td style="height:5px;"></td></tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="HEIGHT: 23px" valign="bottom" width="100%" colspan="6" align="center"><font size="2" face="Arial"><STRONG><FONT size="2" face="Arial"><STRONG><FONT size="1" face="MS Sans Serif"><STRONG><FONT size="2" face="Arial"><STRONG><FONT size="1" face="MS Sans Serif"><STRONG><asp:checkbox id="chkNeedsLogin" runat="server" Enabled="False" Font-Bold="True" Font-Names="Microsoft Sans Serif"
																							Font-Size="XX-Small" AutoPostBack="True"></asp:checkbox>&nbsp;</STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></font>
                                            <asp:Label ID="Label2" runat="server" Text="This employee will use computer (Not Aloha) and needs computer Login"></asp:Label>
                                        </td>
                                   
                                         </tr>
                                </table>
                            </div>
                        </div>
                    </div>


                    <div id="tblADS" runat="server">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-12" style="color: white; height: 25px; font-weight: 100; font-size: 13px; margin-top: 8px; margin-bottom: 6px; text-align: center; background-color: #069;">
                                        ADS / Network Related (Only If Employee Requires Computer Login)
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-2">
                                        Login Name
                                    </div>
                                    <div class="col-sm-3">
                                        <div class="form-group">
                                            <asp:TextBox ID="txtLoginName" runat="server" CssClass="form-control" Width="208px" BackColor="#E7E6E6"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                    </div>

                                    <div class="col-sm-2" style="margin-left: 13px;">
                                        Work Email
                                    </div>
                                    <div class="col-sm-2">
                                        <div class="form-group">
                                            <asp:TextBox ID="txtWorkEmail" runat="server" CssClass="form-control" Width="208px" BackColor="#E7E6E6"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-5" style="color: #069;">
                                        Employee's Groups :
                                    </div>
                                    <div class="col-sm-1">
                                    </div>
                                    <div class="col-sm-5" style="margin-left: 35px; color: #069;">
                                        Other Available Groups :
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-5">
                                        <asp:ListBox ID="lstEmpGroups" Width="288px" Height="74px" runat="server"></asp:ListBox>
                                    </div>
                                    <div class="col-sm-1" style="margin-top: -14px;">
                                        <asp:Button ID="cmdAddGroup" runat="server" Width="40px" Text="<" CssClass="btn-form" Style="margin-left: 17px;"></asp:Button>

                                        <asp:Button ID="cmdRemoveGroup" runat="server" Width="40px" Text=">" CssClass="btn-form" Style="margin-left: 17px;"></asp:Button>
                                    </div>

                                    <div class="col-sm-5" style="margin-left: 35px; color: #069;">
                                        <asp:ListBox ID="lstAllGroups" runat="server" Width="290px" Height="74px"></asp:ListBox>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-12" style="color: white; height: 25px; font-weight: 100; font-size: 13px; margin-top: 8px; margin-bottom: 6px; text-align: center; background-color: #069;">
                                    Other
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-6">
                                    Legal Name (Must Match SS Card)
                                </div>
                                <div class="col-sm-6">
                                    Ethnicity
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-6">
                                    <asp:TextBox ID="txtLegalName" runat="server" Enabled="False" CssClass="form-control" Width="280px" BackColor="#E7E6E6"></asp:TextBox>
                                </div>
                                <div class="col-sm-6">
                                    <asp:DropDownList ID="cmbEthnicity" runat="server" Width="219px" CssClass="form-control" BackColor="#E7E6E6"></asp:DropDownList>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-6">
                                    How Was Employee Referred to Claim Jumper
                                </div>
                                <div class="col-sm-6">
                                    Work Permit Expiration Date
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-6">
                                    <asp:DropDownList ID="cmbEmpReferral" runat="server" Width="280px" CssClass="form-control" BackColor="#E7E6E6"></asp:DropDownList>
                                </div>
                                <div class="col-sm-6">
                                    <asp:TextBox ID="txtWPExpDate" runat="server" Preset="shortdate" CssClass="form-control" Width="216px"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-6">
                                    Education
                                </div>
                                <div class="col-sm-6">
                                    Recruiter
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-6">
                                    <asp:DropDownList Style="Z-INDEX: 0" ID="cmbEducation" CssClass="form-control" runat="server" Width="280px" BackColor="#E7E6E6"></asp:DropDownList>
                                </div>
                                <div class="col-sm-6">
                                    <asp:DropDownList Style="Z-INDEX: 0" ID="cmbRecruiter" CssClass="form-control" runat="server" Width="219px" BackColor="#E7E6E6"></asp:DropDownList>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-6">
                                    Previous Company (i.e. Starbucks or First Job etc.)
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-6">
                                    <asp:TextBox Style="Z-INDEX: 0" ID="txtPrevCompany" runat="server" CssClass="form-control" Width="272px"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-12" style="color: white; height: 25px; font-weight: 100; font-size: 13px; margin-top: 8px; margin-bottom: 6px; text-align: center; background-color: #069;">
                                    I-9 Information
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-5">
                                    I-9 Status
                                </div>
                                <div class="col-sm-3">
                                    Exp. Date
                                </div>
                                <div class="col-sm-4">
                                    Comments
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-5">
                                    <asp:DropDownList ID="cmbI9Status" runat="server" Width="264px" CssClass="form-control" BackColor="#E7E6E6"></asp:DropDownList>
                                </div>
                                <div class="col-sm-3">                         
                                    <asp:TextBox ID="txtExpDate" runat="server" Preset="shortdate" CssClass="form-control" Width="89px"></asp:TextBox>
                                    Alien #
                                    <asp:TextBox ID="txtAlienNo" runat="server" CssClass="form-control" Width="89px"></asp:TextBox>
                                </div>
                                <div class="col-sm-4">
                                    <asp:TextBox ID="txtI9Notes" runat="server" Width="232px" Height="44px" CssClass="form-control" TextMode="MultiLine"></asp:TextBox></td>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-12" style="color: white; height: 25px; font-weight: 100; font-size: 13px; margin-top: 8px; margin-bottom: 6px; text-align: center; background-color: #069;">
                                    W-4 Information
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-3">
                                </div>
                                <div class="col-sm-3">
                                    State Taxes
                                </div>
                                <div class="col-sm-4">
                                    Federal Taxes
                                </div>
                                <div class="col-sm-3">
                                    Comments:
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div style="float: left; width: 75%;">
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-3">
                                        Marital Status
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:DropDownList Style="Z-INDEX: 0" ID="cmbStateMarital" runat="server" Width="137px" CssClass="form-control" BackColor="#E7E6E6"></asp:DropDownList>
                                    </div>
                                    <div class="col-sm-2">
                                        <asp:DropDownList Style="Z-INDEX: 0" ID="cmbFedMarital" runat="server" Width="137px" CssClass="form-control" BackColor="#E7E6E6"></asp:DropDownList>
                                    </div>

                                </div>
                                <div class="row" style="margin-top:5px;">
                                    <div class="col-sm-3">
                                        # of Exemptions
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:TextBox Style="Z-INDEX: 0" ID="txtStateExempNo" CssClass="form-control" runat="server" Width="136px" BackColor="#E7E6E6">0</asp:TextBox>
                                    </div>
                                    <div class="col-sm-2">
                                        <asp:TextBox Style="Z-INDEX: 0" ID="txtFedExempNo" runat="server" CssClass="form-control" Width="136px" BackColor="#E7E6E6">0</asp:TextBox>
                                    </div>
                                </div>
                                <div class="row" style="margin-top:5px;">
                                    <div class="col-sm-3">
                                        Additional Amt ($)
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:TextBox Style="Z-INDEX: 0" ID="txtStateDed" runat="server" Preset="currency" CssClass="form-control" Width="136px">0.00</asp:TextBox>
                                    </div>
                                    <div class="col-sm-2">
                                        <asp:TextBox Style="Z-INDEX: 0" ID="txtFedDed" runat="server" Preset="currency" Width="136px" CssClass="form-control">0.00</asp:TextBox>
                                    </div>
                                </div>
                                <div class="row" style="margin-top:5px;">
                                    <div class="col-sm-3">
                                        Emp. Claims Exempt
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:CheckBox Style="Z-INDEX: 0" ID="chkStateClEx" runat="server" Width="112px" ToolTip="Rupesh"></asp:CheckBox>
                                    </div>
                                    <div class="col-sm-2">
                                        <asp:CheckBox Style="Z-INDEX: 0" ID="chkFedClEx" runat="server" Width="99px" ToolTip="Rupesh"></asp:CheckBox>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-3">
                                        A-4 Form (%)
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:DropDownList Style="Z-INDEX: 0" ID="cmbA4Ded" CssClass="form-control" runat="server" Width="88px"></asp:DropDownList>
                                        (AZ Only)
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div style="float: right; width: 25%;">
                            <div class="row" style="padding-right: 400px;">
                                <asp:TextBox Style="Z-INDEX: 0" ID="txtW4Notes" runat="server" Width="192px" Height="100px" TextMode="MultiLine"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                    <div class="row" id="tblUndoGMApproval" runat="server">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-3">
                                    Undo Approval Notes
                                </div>
                                <div class="col-sm-6">
                                    <asp:TextBox ID="txtUndoNotes" runat="server" Width="552px" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="blue_line"></div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <asp:Button ID="cmdPost" runat="server" CssClass="btn-form1" Width="110px" Text="Post"></asp:Button>
                                <asp:Button ID="cmdUpdate" runat="server" Width="110px" CssClass="btn-form1" Text="Update"></asp:Button>
                                <asp:Button ID="cmdApprove" runat="server" CssClass="btn-form1" Width="110px" Text="Approve"></asp:Button>
                                <asp:Button ID="cmdDeny" runat="server" CssClass="btn-form1" Width="110px" Text="Deny"></asp:Button>
                                <asp:Button ID="cmdSubmit" runat="server" CssClass="btn-form1" Width="110px" Text="Submit"></asp:Button>
                                <input style="WIDTH: 110px;" id="cmdExit" onclick="window.close();" class="btn-form1" value="Exit" type="button" name="cmdExit">
                                <asp:Button ID="cmdReview" runat="server" CssClass="btn-form1" Width="129px" Text="Send For Review" Visible="False"></asp:Button>
                            </div>
                        </div>
                    </div>

                    <div>
                        <asp:TextBox ID="txtHState" runat="server" Width="32px" Height="16px" Visible="False"></asp:TextBox>
                        <asp:TextBox ID="txtHStore" runat="server" Width="32px" Height="16px" Visible="False"></asp:TextBox>
                        <asp:TextBox ID="txtHJobCode" runat="server" Width="32px" Height="16px" Visible="False"></asp:TextBox>
                        <asp:TextBox ID="txtHJobTitle" runat="server" Width="32px" Height="16px" Visible="False"></asp:TextBox>
                        <asp:TextBox ID="txtHManager" runat="server" Width="32px" Height="16px" Visible="False"></asp:TextBox>
                        <asp:TextBox ID="txtHGender" runat="server" Width="32px" Height="16px" Visible="False"></asp:TextBox>
                        <asp:TextBox ID="txtHSalaryStatus" runat="server" Width="32px" Height="16px" Visible="False"></asp:TextBox>
                        <asp:TextBox ID="txtHEthnicity" runat="server" Width="32px" Height="16px" Visible="False"></asp:TextBox>
                        <asp:TextBox ID="txtHI9Status" runat="server" Width="32px" Height="16px" Visible="False"></asp:TextBox>
                        <asp:TextBox ID="txtHFedMarital" runat="server" Width="32px" Height="16px" Visible="False"></asp:TextBox>
                        <asp:TextBox ID="txtHA4Ded" runat="server" Width="32px" Height="16px" Visible="False"></asp:TextBox>
                        <asp:TextBox ID="txtHEmpReferral" runat="server" Width="32px" Height="16px" Visible="False"></asp:TextBox>
                        <asp:TextBox ID="txtManClockId" runat="server" Width="24px" Height="16px" Visible="False"></asp:TextBox>
                        <input style="WIDTH: 23px; HEIGHT: 14px" id="txtSecCode" size="1" type="hidden" name="txtSecCode" runat="server">
                        <input style="WIDTH: 23px; HEIGHT: 14px" id="txtChangeTypeId" size="1" type="hidden" name="txtChangeTypeId" runat="server" />
                        <asp:TextBox ID="txtECId" runat="server" Width="35px" Height="14px" Visible="False"></asp:TextBox>
                        <input style="WIDTH: 27px; HEIGHT: 14px" id="txtId" size="1" type="hidden" name="txtId" runat="server">
                        <asp:ListBox ID="lstOldJobCode" runat="server" Visible="false"></asp:ListBox>
                        <asp:TextBox Style="Z-INDEX: 0" ID="txtHStateMarital" runat="server" Width="32px" Height="16px" Visible="False"></asp:TextBox>
                        <asp:TextBox Style="Z-INDEX: 0" ID="txtHEducation" runat="server" Width="32px" Height="16px" Visible="False"></asp:TextBox>
                        <asp:TextBox Style="Z-INDEX: 0" ID="txtHRecruiter" runat="server" Width="32px" Height="16px" Visible="False"></asp:TextBox>
                    </div>

                </div>
            </div>
            <!-- END PANEL -->
        </div>
        <!-- END CONTAINER FLUID -->

    </form>
</body>
</html>
