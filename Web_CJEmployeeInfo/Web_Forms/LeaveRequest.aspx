<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LeaveRequest.aspx.vb" Inherits="Web_CJEmployeeInfo.LeaveRequest" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>Leave Request</title>
		<meta content="False" name="vs_showGrid">
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<STYLE>.mask { BEHAVIOR: url("mask_vbs.htc") }
		</STYLE>
		<script language="javascript" src="pupdate.js"></script>
		<script language="javascript">

		    function SelectEmp() {
		        var cmbEmp;
		        var strValue;
		        var Arr;

		        cmbEmp = document.getElementById("cmbEmp");
		        strValue = cmbEmp.options(cmbEmp.selectedIndex).value;

		        if (strValue == '')
		            return false;

		        Arr = strValue.split("-");

		        frmLR.txtClockId.value = Arr[0];
		        frmLR.txtUnit.value = Arr[1];
		        frmLR.txtEmpType.value = Arr[2];

		        //alert(strValue);
		        //alert(frmLR.txtEmpType.value);

		        //MO Salary
		        if (frmLR.txtEmpType.value == 1) {
		            document.getElementById("lblTR").innerHTML = 'Time Requested (Days)';
		            document.getElementById("lblTR1").innerHTML = 'Leave Time (Days)';
		            document.getElementById("lblDaysOff").innerHTML = 'Weekend/Holiday Days';
		            //document.getElementById("txtDaysOff").disabled = true;
		            document.getElementById("cmdTotalTime").value = 'Calculate Total Days Except Weekend/Holiday';
		        }

		            //Store Salary
		        else if (frmLR.txtEmpType.value == 2)	// || frmLR.txtEmpType.value == 4)
		        {
		            document.getElementById("lblTR").innerHTML = 'Time Requested (Days)';
		            document.getElementById("lblTR1").innerHTML = 'Leave Time (Days)';
		            document.getElementById("lblDaysOff").innerHTML = 'Enter your # of Non-Vacation Days Off in the range';
		            //document.getElementById("txtDaysOff").disabled = true;
		            document.getElementById("cmdTotalTime").value = 'Calculate Total Days Except Days Off';
		            //alert('came');
		        }

		            //MO Hourly, OAs
		        else if (frmLR.txtEmpType.value == 3 || frmLR.txtEmpType.value == 4) {
		            document.getElementById("lblTR").innerHTML = 'Time Requested (Hrs)';
		            document.getElementById("lblTR1").innerHTML = 'Leave Time (Hrs)';
		            document.getElementById("lblDaysOff").innerHTML = 'Weekend/Holiday Hours';
		            //document.getElementById("txtDaysOff").disabled = true;
		            document.getElementById("cmdTotalTime").value = 'Calculate Total Hours Except Weekend/Holiday';
		        }

		            //AKMs
		        else if (frmLR.txtEmpType.value == 5) //AKMs
		        {
		            document.getElementById("lblTR").innerHTML = 'Time Requested (Hrs)';
		            document.getElementById("lblTR1").innerHTML = 'Leave Time (Hrs)';
		            document.getElementById("lblDaysOff").innerHTML = 'Enter your # of Non-Vacation Hours Off in the range';
		            document.getElementById("cmdTotalTime").value = 'Calculate Total Hours Except Non-Vacation Hours';
		        }

		        //Reset Page
		        document.getElementById("txtSDate").value = '';
		        document.getElementById("txtEDate").value = '';
		        document.getElementById("txtDaysOff").value = '';
		        document.getElementById("lblDaysOff1").innerHTML = '';
		        document.getElementById("txtActualHrs").value = '';
		        document.getElementById("lblADays").innerHTML = '';

		        document.getElementById("txtVacationHrs").value = '';
		        document.getElementById("lblVDays").innerHTML = '';
		        document.getElementById("txtSickHrs").value = '';
		        document.getElementById("lblSDays").innerHTML = '';
		        document.getElementById("txtUnPaidHrs").value = '';
		        document.getElementById("lblUDays").innerHTML = '';
		    }


		    function ValidateDates() {
		        var d1;
		        var d2;

		        d1 = new Date(document.getElementById("txtSDate").value);
		        d2 = new Date(document.getElementById("txtEDate").value);

		        //alert(d1);

		        if (isNaN(d1.getHours()) || isNaN(d2.getHours())) {
		            alert('Invalid First Day Off or Last Day Off .. Please check it out');
		            return false;
		        }
		        else {
		            if (d1 > d2) {
		                alert('First Day Off can not be greater than Last Day Off .. Please check it out')
		                return false;
		            }
		            else
		                return true;
		        }
		    }

		    function isDigit(c) {
		        return ((c >= "0") && (c <= "9"))
		    }

		    function isInteger(s) {
		        var i;

		        for (i = 0; i < s.length; i++) {
		            var c = s.charAt(i);

		            if (!isDigit(c)) return false;
		        }

		        // All characters are numbers
		        return true;
		    }

		    function isWholeNumber(s) {
		        var i;
		        var s1;
		        var s2;

		        i = s.indexOf('.');
		        if (i == -1)
		            return true

		        s1 = s.substring(0, i);
		        s2 = s.substring(i + 1, s.length);

		        if (s2 > 0)
		            return false;
		        else
		            return true;
		        //alert(s1);
		        //alert(s2);
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



		    function isTime(s) {   /*
			var i;
			var c;
			var hr;
			var min;
			var j;
			
			if (s.length < 3)
				return false;
			
			j = s.indexOf(':');
			if(j < 0)
				return false;
								
			hr = s.substring(0,j);
			if (isblank(hr))
					return false;
			
			for (i = 0; i < hr.length; i++)
			{   
				c = hr.charAt(i);
				if (!isDigit(c)) 
					return false;
			}
			
			min = s.substring(j+1,5);
			if (isblank(min))
				return false;
			
			for (i = 0; i < min.length; i++)
			{   
				c = min.charAt(i);
				if (!isDigit(c)) 
					return false;
			}
			
			if ((hr == 0) && (min == 0))
				return false;
				
			return true;
			*/
		    }

		    function ValidateData() {
		        var txtActualHrs;
		        var txtVacationHrs;
		        var txtSickHrs;
		        var txtUnPaidHrs;
		        var cmbVacation;
		        var cmbSick;
		        var cmbUnPaid;
		        var txtDaysOff;

		        txtActualHrs = document.getElementById("txtActualHrs");
		        txtVacationHrs = document.getElementById("txtVacationHrs");
		        txtSickHrs = document.getElementById("txtSickHrs");
		        txtUnPaidHrs = document.getElementById("txtUnPaidHrs");
		        cmbVacation = document.getElementById("cmbVacation");
		        cmbSick = document.getElementById("cmbSick");
		        cmbUnPaid = document.getElementById("cmbUnPaid");
		        txtDaysOff = document.getElementById("txtDaysOff");

		        //GetTotalDays(0);
		        //DisplayTotalHrs();

		        if (!GetTotalDateDiff())
		            return false;

		        if (!CheckHrs())
		            return false;


		        //alert('rupesh');

		        /*
                var cmbLeaveType;
                cmbLeaveType = document.getElementById("cmbLeaveType");
                
                if(cmbLeaveType.options(cmbLeaveType.selectedIndex).text == 'Makeup')
                {
                    if(!isTime(document.getElementById("txtMakeupTime").value))
                    {
                        alert('Invalid Makeup Time .. Please check it out');
                        return false;
                    }
                    if(!CheckMakeupTimeDate())
                        return false;
                }
                else
                {			
                */

		        if (isBlank(txtVacationHrs.value))
		            txtVacationHrs.value = 0;

		        if (isBlank(txtSickHrs.value))
		            txtSickHrs.value = 0;

		        if (isBlank(txtUnPaidHrs.value))
		            txtUnPaidHrs.value = 0;

		        if (isBlank(txtDaysOff.value))
		            txtDaysOff.value = 0;

		        //alert((txtVacationDays.value-0) + (txtSickDays.value-0) + (txtUnPaidDays.value-0));
		        //alert(txtActualDays.value);

		        if ((txtVacationHrs.value - 0) != txtVacationHrs.value) {
		            alert('Invalid Vacation Time Taken .. Please check it out');
		            return false;
		        }

		        if ((txtSickHrs.value - 0) != txtSickHrs.value) {
		            alert('Invalid Sick Time Taken .. Please check it out');
		            return false;
		        }

		        if ((txtUnPaidHrs.value - 0) != txtUnPaidHrs.value) {
		            alert('Invalid UnPaid Time Taken .. Please check it out');
		            return false;
		        }

		        if (((txtVacationHrs.value - 0) + (txtSickHrs.value - 0) + (txtUnPaidHrs.value - 0)) != (txtActualHrs.value - 0)) {
		            alert('Sum of Vacation, Sick & UnPaid Time must be equal to Time Requested .. Please check it out');
		            return false;
		        }

		        if (txtVacationHrs.value > 0 && isBlank(cmbVacation.options(cmbVacation.selectedIndex).text)) {
		            alert('Please specify Vacation reason');
		            return false;
		        }

		        if (txtSickHrs.value > 0 && isBlank(cmbSick.options(cmbSick.selectedIndex).text)) {
		            alert('Please specify Sick reason');
		            return false;
		        }

		        if (txtUnPaidHrs.value > 0 && isBlank(cmbUnPaid.options(cmbUnPaid.selectedIndex).text)) {
		            alert('Please specify UnPaid reason');
		            return false;
		        }

		        //For manager check if employee is selected
		        //alert(frmLR.txtManClockId.value);

		        if (frmLR.txtManClockId.value > 0) {
		            var txtLRId;
		            var txtHR;

		            txtLRId = document.getElementById("txtLRId");

		            if (txtLRId.value == 0 && frmLR.txtHR.value <= 0) {
		                var cmbEmp;
		                cmbEmp = document.getElementById("cmbEmp");

		                if (isBlank(cmbEmp.options(cmbEmp.selectedIndex).text)) {
		                    alert('Please select employee');
		                    return false;
		                }
		            }
		        }

		        //alert('rupesh');
		        if ((frmLR.txtHR.value - 0) == 1) {
		            var chkFMLA;
		            var txtFMLAHrs;
		            var txtFMLASDate;
		            var txtFMLAEDate;

		            var chk30Day;
		            var txtDay30Hrs;
		            var txtDay30SDate;
		            var txtDay30EDate;

		            var chk60Day;
		            var txtDay60Hrs;
		            var txtDay60SDate;
		            var txtDay60EDate;

		            var chkPregnancy;
		            var txtPregHrs;
		            var txtPregSDate;
		            var txtPregEDate;

		            var chkWorkComp;
		            var txtWorkCompHrs;
		            var txtWorkCompSDate;
		            var txtWorkCompEDate;

		            var d1;
		            var d2;

		            chkFMLA = document.getElementById("chkFMLA");
		            txtFMLAHrs = document.getElementById("txtFMLAHrs");
		            txtFMLASDate = document.getElementById("txtFMLASDate");
		            txtFMLAEDate = document.getElementById("txtFMLAEDate");

		            chk30Day = document.getElementById("chk30Day");
		            txtDay30Hrs = document.getElementById("txtDay30Hrs");
		            txtDay30SDate = document.getElementById("txtDay30SDate");
		            txtDay30EDate = document.getElementById("txtDay30EDate");

		            chk60Day = document.getElementById("chk60Day");
		            txtDay60Hrs = document.getElementById("txtDay60Hrs");
		            txtDay60SDate = document.getElementById("txtDay60SDate");
		            txtDay60EDate = document.getElementById("txtDay60EDate");

		            chkPregnancy = document.getElementById("chkPregnancy");
		            txtPregHrs = document.getElementById("txtPregHrs");
		            txtPregSDate = document.getElementById("txtPregSDate");
		            txtPregEDate = document.getElementById("txtPregEDate");

		            chkWorkComp = document.getElementById("chkWorkComp");
		            txtWorkCompHrs = document.getElementById("txtWorkCompHrs");
		            txtWorkCompSDate = document.getElementById("txtWorkCompSDate");
		            txtWorkCompEDate = document.getElementById("txtWorkCompEDate");


		            if (chkFMLA.checked) {
		                if ((txtFMLAHrs.value - 0 <= 0) || isBlank(txtFMLASDate.value) ||
                            isBlank(txtFMLAEDate.value)) {
		                    alert('FMLA Time, Start Date & End Date are required .. Please check it out');
		                    return false;
		                }

		                if ((txtFMLAHrs.value - 0) != txtFMLAHrs.value) {
		                    alert('Invalid FMLA Time .. Please check it out');
		                    return false;
		                }

		                d1 = new Date(document.getElementById("txtFMLASDate").value);
		                d2 = new Date(document.getElementById("txtFMLAEDate").value);

		                if (d1 > d2) {
		                    alert('FMLA Start Date can not be greater than End Date .. Please check it out');
		                    return false;
		                }
		            }

		            if (chk30Day.checked) {
		                if ((txtDay30Hrs.value - 0 <= 0) || isBlank(txtDay30SDate.value) ||
                            isBlank(txtDay30EDate.value)) {
		                    alert('30 Day Time, Start Date & End Date are required .. Please check it out');
		                    return false;
		                }

		                if ((txtDay30Hrs.value - 0) != txtDay30Hrs.value) {
		                    alert('Invalid 30 Day Time .. Please check it out');
		                    return false;
		                }

		                d1 = new Date(document.getElementById("txtDay30SDate").value);
		                d2 = new Date(document.getElementById("txtDay30EDate").value);

		                if (d1 > d2) {
		                    alert('30 Day Start Date can not be greater than End Date .. Please check it out');
		                    return false;
		                }

		            }

		            if (chk60Day.checked) {
		                if ((txtDay60Hrs.value - 0 <= 0) || isBlank(txtDay60SDate.value) ||
                            isBlank(txtDay60EDate.value)) {
		                    alert('60 Day Time, Start Date & End Date are required .. Please check it out');
		                    return false;
		                }

		                if ((txtDay60Hrs.value - 0) != txtDay60Hrs.value) {
		                    alert('Invalid 60 Day Days .. Please check it out');
		                    return false;
		                }

		                d1 = new Date(document.getElementById("txtDay60SDate").value);
		                d2 = new Date(document.getElementById("txtDay60EDate").value);

		                if (d1 > d2) {
		                    alert('60 Day Start Date can not be greater than End Date .. Please check it out');
		                    return false;
		                }

		            }

		            if (chkPregnancy.checked) {
		                if ((txtPregHrs.value - 0 <= 0) || isBlank(txtPregSDate.value) ||
                            isBlank(txtPregEDate.value)) {
		                    alert('Pregnancy Time, Start Date & End Date are required .. Please check it out');
		                    return false;
		                }

		                if ((txtPregHrs.value - 0) != txtPregHrs.value) {
		                    alert('Invalid Pregnancy Days .. Please check it out');
		                    return false;
		                }

		                d1 = new Date(document.getElementById("txtPregSDate").value);
		                d2 = new Date(document.getElementById("txtPregEDate").value);

		                if (d1 > d2) {
		                    alert('Pregnancy Start Date can not be greater than End Date .. Please check it out');
		                    return false;
		                }

		            }

		            if (chkWorkComp.checked) {
		                if ((txtWorkCompHrs.value - 0 <= 0) || isBlank(txtWorkCompSDate.value) ||
                            isBlank(txtWorkCompEDate.value)) {
		                    alert('Workman Comp Time, Start Date & End Date are required .. Please check it out');
		                    return false;
		                }

		                if ((txtWorkCompHrs.value - 0) != txtWorkCompHrs.value) {
		                    alert('Invalid Workman Comp Time .. Please check it out');
		                    return false;
		                }

		                d1 = new Date(document.getElementById("txtWorkCompSDate").value);
		                d2 = new Date(document.getElementById("txtWorkCompEDate").value);

		                if (d1 > d2) {
		                    alert('Workman Comp Start Date can not be greater than End Date .. Please check it out');
		                    return false;
		                }
		            }
		        }

		        return true;
		    }


		    function ValidateSubmit() {
		        if (ValidateData()) {
		            var strTitle;
		            var strSubmit;
		            strTitle = document.getElementById("cmdSubmit").value;

		            //alert(strTitle);

		            /*
                    if(strTitle == 'Submit' || strTitle == 'Update')
                    {
                    */

		            if (strTitle == 'Submit')
		                strSubmit = 'Submit Request ?';
		            else if (strTitle == 'Update')
		                strSubmit = 'Update Request ?';
		            else
		                strSubmit = 'Post Request ?';


		            //MO Salary, Store Salary
		            //if(frmLR.txtEmpType.value == 1 || frmLR.txtEmpType.value == 2 ||
		            //	frmLR.txtEmpType.value == 4)  
		            if (frmLR.txtEmpType.value == 1 || frmLR.txtEmpType.value == 2) {
		                strSubmit = strSubmit + '\n' + '\n' +
								'Total Time Difference : ' + (frmLR.txtTotalHrs.value / 8) + ' Days' + '\n' +
								'Time Requested         : ' + document.getElementById("txtActualHrs").value + ' Days' + '\n' +
								'Days Off/Weekends   : ' + document.getElementById("txtDaysOff").value + ' Days';
		            }

		                //MO Hourly, AKMs, OAs
		            else if (frmLR.txtEmpType == 3 || frmLR.txtEmpType.value == 5 || frmLR.txtEmpType.value == 4) {
		                strSubmit = strSubmit + '\n' + '\n' +
								'Total Time Difference : ' + frmLR.txtTotalHrs.value + ' Hrs' + '\n' +
								'Time Requested         : ' + document.getElementById("txtActualHrs").value + ' Hrs' + '\n' +
								'Days Off/Weekends   : ' + document.getElementById("txtDaysOff").value + ' Hrs';
		            }

		            if (confirm(strSubmit)) {
		                document.getElementById("cmdSubmit").innerText = 'Please Wait';
		                return true;
		            }
		            else
		                return false;
		            /*
                    }
    
                    else
                    {
                        if(confirm('Post Request ?'))
                        {
                            document.getElementById("cmdSubmit").innerText = 'Please Wait';
                            return true;
                        }
                        else
                            return false;
                    }
                    */
		        }
		    }

		    function ValidateApprove() {
		        if (ValidateData()) {
		            //alert('rupesh');

		            if (document.getElementById("cmdApprove").value == 'Approve') {
		                if (confirm('Approve Request ?')) {
		                    document.getElementById("cmdApprove").innerText = 'Please Wait';
		                    return true;
		                }
		                else
		                    return false;
		            }
		            else {
		                if (confirm('Undo Approval? If the request is posted, it will be unposted .. Proceed?')) {
		                    document.getElementById("cmdApprove").innerText = 'Please Wait';
		                    return true;
		                }
		                else
		                    return false;
		            }
		        }
		    }

		    function CheckHrs() {
		        var txtEmpType;

		        var txtActualHrs;
		        var txtVacationHrs;
		        var txtSickHrs;
		        var txtUnPaidHrs;
		        var txtDaysOff;

		        txtVacationHrs = document.getElementById("txtVacationHrs");
		        txtSickHrs = document.getElementById("txtSickHrs");
		        txtUnPaidHrs = document.getElementById("txtUnPaidHrs");

		        txtEmpType = document.getElementById("txtEmpType");
		        txtActualHrs = document.getElementById("txtActualHrs");
		        txtDaysOff = document.getElementById("txtDaysOff");

		        /*
                if(!ValidateDates())
                    return false;
                
                var date1;
                var date2;
                var TotDays;
                var i;
                
                date1 = new Date(document.getElementById("txtSDate").value);
                date2 = new Date(document.getElementById("txtEDate").value);
                
                //alert(date1);
                
                i = date1;
                TotDays = 0;
                
                while(i <= date2)
                {
                    TotDays++;
                    i = new Date(Date.parse(i) + (1000*60*60*24));
                }
                */

		        if ((txtActualHrs.value - 0) != txtActualHrs.value) {
		            alert('Invalid Time Requested .. Please check it out');
		            return false;
		        }

		        if (isBlank(txtActualHrs.value)) {
		            alert('Time Requested can not be blank .. Please check it out');
		            return false;
		        }

		        if (txtActualHrs.value == 0) {
		            alert('Time Requested can not be zero .. Please check it out');
		            return false;
		        }

		        if (txtEmpType.value == 1 || txtEmpType.value == 2) // || txtEmpType.value == 4) 
		        {
		            if (!isWholeNumber(txtActualHrs.value)) {
		                alert('Time Requested must be whole number .. Please check it out');
		                return false;
		            }

		            if (txtVacationHrs.value > 0 && !isWholeNumber(txtVacationHrs.value)) {
		                alert('Vacation Time Requested must be whole number .. Please check it out');
		                return false;
		            }

		            if (txtSickHrs.value > 0 && !isWholeNumber(txtSickHrs.value)) {
		                alert('Sick Time Requested must be whole number .. Please check it out');
		                return false;
		            }

		            if (txtUnPaidHrs.value > 0 && !isWholeNumber(txtUnPaidHrs.value)) {
		                alert('UnPaid Time Requested must be whole number .. Please check it out');
		                return false;
		            }
		        }

		        //MO Salary, Store Salary
		        if (txtEmpType.value == 1 || txtEmpType.value == 2) // || txtEmpType.value == 4)
		        {
		            //alert((txtActualHrs.value*8) + (txtDaysOff.value*8));
		            //alert(frmLR.txtTotalHrs.value-0);

		            if ((txtActualHrs.value * 8) + (txtDaysOff.value * 8) != (frmLR.txtTotalHrs.value - 0)) {
		                alert('Time Requested + Your Days Off/Weekends must be equal to Total Time Difference of Date Range .. Please check it out');
		                return false;
		            }
		        }

		            //MO Hourly, AKMs, OAs
		        else if (txtEmpType.value == 3 || txtEmpType.value == 5 || txtEmpType.value == 4) {
		            if ((txtActualHrs.value - 0) + (txtDaysOff.value - 0) > (frmLR.txtTotalHrs.value - 0)) {
		                alert('Time Requested can not be greater than Total Time Difference of Date Range + Your Days Off/Weekends .. Please check it out');
		                return false;
		            }

		            if ((frmLR.txtTotalHrs.value - 0) - ((txtActualHrs.value - 0) + (txtDaysOff.value - 0)) >= 8) {
		                alert('Difference between Time Requested + Your hours Off/Weekends and Total Time Difference of Date Range can not be more than 8 hours .. Please check it out');
		                return false;
		            }

		        }

		        return true;
		    }

		    function CheckMakeupTimeDate()	//----------------------------------------------------------------------
		    {
		        /*
                var date1;
                var date2;
                var i;
                var j;
                
                date1 = new Date(document.getElementById("txtSDate").value);
                date2 = new Date(document.getElementById("txtEDate").value);
                
                i = date2.getDay() - date1.getDay();
                i = 1000*60*60*24*i;
                j = new Date(Date.parse(date1) + i)
                
                //alert(Date.parse(j));
                //alert(Date.parse(date2));
                
                if(Date.parse(date2) != Date.parse(j))
                {
                    alert('Makeup Time must be within same week .. Please check it out');
                    return false;
                }
                else
                    return true;
                */
		    }

		    function ChangeLabel() //-----------------------------------------------------------------------------
		    {
		        /*
                var cmbLeaveType;
                cmbLeaveType = document.getElementById("cmbLeaveType");
                
                //alert(cmbLeaveType.options(cmbLeaveType.selectedIndex).text);
                
                if(cmbLeaveType.options(cmbLeaveType.selectedIndex).text == 'Makeup')
                {
                    document.getElementById("lblSDate").innerHTML = 'Time Taken On';
                    document.getElementById("lblEDate").innerHTML = 'To Be Made Up On';
                    document.getElementById("txtTotalDays").value = '';
                    document.getElementById("txtActualDays").value = '';
                    document.getElementById("txtActualDays").disabled = true;
                    //Form1.cmdCalculate.disabled = true;
                    document.getElementById("txtMakeupTime").disabled = false;
                }
                else
                {
                    document.getElementById("lblSDate").innerHTML = 'Start Date';
                    document.getElementById("lblEDate").innerHTML = 'End Date';
                    document.getElementById("txtActualDays").disabled = false;
                    //Form1.cmdCalculate.disabled = false;
                    document.getElementById("txtMakeupTime").value = '';
                    document.getElementById("txtMakeupTime").disabled = true;
                }
                
                
                alert('rupesh');
                alert(document.getElementById("lblHead").text);
                
                if(document.getElementById("txtRId").value == '0')
                    document.getElementById("cmdDelete").disabled = true;
                */

		    }

		    function ViewLeaveHist() //---------------------------------------------------------------------------
		    {
		        var strURL;
		        var cmbEmp;

		        cmbEmp = document.getElementById("cmbEmp");

		        if (isBlank(cmbEmp.options(cmbEmp.selectedIndex).text)) {
		            alert('Please select employee from the list');
		            return false;
		        }

		        else {
		            strURL = 'http://Goldmine/reportserver?/HRExpress/EmpLeaveHistory' +
                            '&rs:Command=Render' +
                            '&rc:Zoom=100&rc:Parameters=false' +
                            '&ClockId=' + frmLR.txtClockId.value;

		            //alert(strURL);
		            //return false;

		            window.open(strURL, 'wLeaveHist', 'resizable=yes,top=10, left=10, width=650,height=400,scrollbars=yes,menubar=no,toolbar=no');
		        }
		    }

		    function ViewLeaveHist1() //----------------------------------------------------------------------------
		    {
		        var strURL;

		        strURL = 'http://Goldmine/reportserver?/HRExpress/EmpLeaveHistory' +
                        '&rs:Command=Render' +
                        '&rc:Zoom=100&rc:Parameters=false' +
                        '&ClockId=' + frmLR.txtClockId.value;

		        //alert(strURL);
		        //return false;

		        window.open(strURL, 'wLeaveHist1', 'resizable=yes,top=10, left=10, width=650,height=400,scrollbars=yes,menubar=no,toolbar=no');
		    }

		    function GetTotalDays(k) //-------------------------------------------------------------------------------
		    {

		        var date1;
		        var date2;
		        var TotDays;
		        var i;

		        date1 = new Date(document.getElementById("txtSDate").value);
		        date2 = new Date(document.getElementById("txtEDate").value);

		        //alert(date1);

		        i = date1;
		        TotDays = 0;

		        while (i <= date2) {
		            //alert(i);
		            if ((k == 0) || ((i.getDay() != 0) && (i.getDay() != 6)))
		                TotDays++;

		            //i = new Date(Date.parse(i) + (1000*60*60*24));
		            i.setDate(i.getDate() + 1);
		        }

		        /*
                document.getElementById("txtTotalDays").value = TotDays; 
                document.getElementById("txtTotalHrs").value = (TotDays*8); 
                
                if(document.getElementById("txtActualDays").value == '')
                {
                    document.getElementById("txtActualDays").value = TotDays; 
                    document.getElementById("txtActualHrs").value = (TotDays*8); 
                }
                */

		        return TotDays;
		    }

		    function DisplayDays() //-------------------------------------------------------------------------------
		    {
		        // Display Days as soon as hours gets changed
		        //var txtUnit;
		        var txtEmpType;

		        //txtUnit = document.getElementById("txtUnit");
		        txtEmpType = document.getElementById("txtEmpType");

		        //MO Hourly, OAs, AKMs
		        if (txtEmpType.value == 3 || txtEmpType.value == 4 || txtEmpType.value == 5) {
		            document.getElementById("lblADays").innerHTML = (document.getElementById("txtActualHrs").value / 8).toFixed(2) + ' Days';
		            document.getElementById("lblVDays").innerHTML = (document.getElementById("txtVacationHrs").value / 8).toFixed(2) + ' Days';
		            document.getElementById("lblSDays").innerHTML = (document.getElementById("txtSickHrs").value / 8).toFixed(2) + ' Days';
		            document.getElementById("lblUDays").innerHTML = (document.getElementById("txtUnPaidHrs").value / 8).toFixed(2) + ' Days';
		            document.getElementById("lblDaysOff1").innerHTML = (document.getElementById("txtDaysOff").value / 8).toFixed(2) + ' Days';
		        }

		            //MO Salary, Store Salary
		        else if (txtEmpType.value == 1 || txtEmpType.value == 2) {
		            document.getElementById("lblADays").innerHTML = (document.getElementById("txtActualHrs").value * 8).toFixed(2) + ' Hrs';
		            document.getElementById("lblVDays").innerHTML = (document.getElementById("txtVacationHrs").value * 8).toFixed(2) + ' Hrs';
		            document.getElementById("lblSDays").innerHTML = (document.getElementById("txtSickHrs").value * 8).toFixed(2) + ' Hrs';
		            document.getElementById("lblUDays").innerHTML = (document.getElementById("txtUnPaidHrs").value * 8).toFixed(2) + ' Hrs';
		            document.getElementById("lblDaysOff1").innerHTML = (document.getElementById("txtDaysOff").value * 8).toFixed(2) + ' Hrs';
		        }

		        //AKMs
		        /*else if(txtEmpType.value == 5)
                {
                    document.getElementById("lblADays").innerHTML = (document.getElementById("txtActualHrs").value/9).toFixed(2) + ' Days';
                    document.getElementById("lblVDays").innerHTML = (document.getElementById("txtVacationHrs").value/9).toFixed(2) + ' Days';
                    document.getElementById("lblSDays").innerHTML = (document.getElementById("txtSickHrs").value/9).toFixed(2) + ' Days';
                    document.getElementById("lblUDays").innerHTML = (document.getElementById("txtUnPaidHrs").value/9).toFixed(2) + ' Days';
                }*/

		        //OAs
		        /*else if(txtEmpType.value == 4)
                {
                    document.getElementById("lblADays").innerHTML = '';
                    document.getElementById("lblVDays").innerHTML = '';
                    document.getElementById("lblSDays").innerHTML = '';
                    document.getElementById("lblUDays").innerHTML = '';
                }*/

		        if ((frmLR.txtHR.value - 0) > 0) {
		            document.getElementById("lblFDays").innerHTML = (document.getElementById("txtFMLAHrs").value / 8).toFixed(2) + ' Days';
		            document.getElementById("lbl30Days").innerHTML = (document.getElementById("txtDay30Hrs").value / 8).toFixed(2) + ' Days';
		            document.getElementById("lbl60Days").innerHTML = (document.getElementById("txtDay60Hrs").value / 8).toFixed(2) + ' Days';
		            document.getElementById("lblPDays").innerHTML = (document.getElementById("txtPregHrs").value / 8).toFixed(2) + ' Days';
		            document.getElementById("lblWDays").innerHTML = (document.getElementById("txtWorkCompHrs").value / 8).toFixed(2) + ' Days';
		        }
		    }


		    function GetTotalDateDiff() //--------------------------------------------------------------------------
		    {
		        var DateDiff;
		        var txtEmpType;

		        txtEmpType = document.getElementById("txtEmpType");

		        if (!ValidateDates())
		            return false;

		        DateDiff = GetTotalDays(0);
		        //alert(DateDiff);

		        /*if(txtEmpType.value == 5) //AKMs @ 9 Hrs/day
                    frmLR.txtTotalHrs.value = DateDiff*9;
                else*/

		        frmLR.txtTotalHrs.value = DateDiff * 8;

		        return true;
		    }

		    function DisplayTotalHrs() //----------------------------------------------------------------------------
		    {
		        //var txtUnit;
		        var txtEmpType;
		        var TotalDays;
		        var TotalDays1;

		        if (!GetTotalDateDiff())
		            return false;

		        //txtUnit = document.getElementById("txtUnit");
		        txtEmpType = document.getElementById("txtEmpType");
		        TotalDays1 = frmLR.txtTotalHrs.value / 8;

		        //alert(TotalDays1);

		        // MO Salary, MO Hourly
		        if (txtEmpType.value == 1 || txtEmpType.value == 3) {
		            // Main Office People, calculate except weekends
		            TotalDays = GetTotalDays(1);

		            //alert(TotalDays);
		            if (txtEmpType.value == 3) {
		                document.getElementById("txtActualHrs").value = TotalDays * 8;
		                document.getElementById("lblADays").innerHTML = TotalDays + ' Days';
		                document.getElementById("txtDaysOff").value = (TotalDays1 - TotalDays) * 8;
		                document.getElementById("lblDaysOff1").innerHTML = (TotalDays1 - TotalDays) + ' Days';
		            }
		            else {
		                document.getElementById("txtActualHrs").value = TotalDays;
		                document.getElementById("lblADays").innerHTML = TotalDays * 8 + ' Hrs';
		                document.getElementById("txtDaysOff").value = (TotalDays1 - TotalDays);
		                document.getElementById("lblDaysOff1").innerHTML = ((TotalDays1 - TotalDays) * 8) + ' Hrs';
		            }
		        }

		            //Store Salary
		        else if (txtEmpType.value == 2) // || txtEmpType.value == 4)
		        {
		            // Store people
		            var DaysOff;
		            varDaysOff = document.getElementById("txtDaysOff").value;

		            if (varDaysOff == '')
		                varDaysOff = 0;

		            TotalDays = GetTotalDays(0);

		            TotalDays = TotalDays - varDaysOff;

		            document.getElementById("txtActualHrs").value = TotalDays;
		            if (txtEmpType.value == 2) {
		                document.getElementById("lblADays").innerHTML = TotalDays * 8 + ' Hrs';
		                document.getElementById("lblDaysOff1").innerHTML = (varDaysOff * 8) + ' Hrs';
		            }
		        }

		            //OAs, AKMs
		        else if (txtEmpType.value == 4 || txtEmpType.value == 5) {
		            var DaysOff;
		            varDaysOff = document.getElementById("txtDaysOff").value;

		            if (varDaysOff == '')
		                varDaysOff = 0;

		            TotalDays = GetTotalDays(0);
		            TotalDays = (TotalDays * 8) - varDaysOff;

		            document.getElementById("txtActualHrs").value = TotalDays;
		            document.getElementById("lblADays").innerHTML = TotalDays / 8 + ' Days';
		            document.getElementById("lblDaysOff1").innerHTML = (varDaysOff / 8) + ' Days';
		        }

		        //AKMs	@ 9 Hrs/Day
		        /*else if(txtEmpType.value == 5)
                {
                    var DaysOff;
                    varDaysOff = document.getElementById("txtDaysOff").value;
                    
                    if(varDaysOff == '')
                        varDaysOff = 0;
                    
                    TotalDays = GetTotalDays(0);
                    TotalDays = (TotalDays*9) - varDaysOff;
                    
                    document.getElementById("txtActualHrs").value = TotalDays;
                    document.getElementById("lblADays").innerHTML = (TotalDays/9) + ' Days';
                    document.getElementById("lblDaysOff1").innerHTML = (varDaysOff/9) + ' Days';
                }*/

		    }

		    function DisplayWEnds() {
		        if (frmLR.txtUnit.value == 90) {
		            var TotalDays;
		            var TotalDays1;
		            var Diff;

		            TotalDays = GetTotalDays(0);
		            TotalDays1 = GetTotalDays(1);

		            Diff = TotalDays - TotalDays1;

		            if (frmLR.txtHourly.value == 1) {
		                document.getElementById("txtDaysOff").value = Diff * 8;
		                document.getElementById("lblDaysOff1").innerHTML = Diff + ' Days';
		            }
		            else {
		                document.getElementById("txtDaysOff").value = Diff;
		                document.getElementById("lblDaysOff1").innerHTML = (Diff * 8) + ' Hrs';
		            }
		        }
		    }

		    function Temp1() {
		        var TotalDays;

		        TotalDays = GetTotalDays(1);

		        alert(TotalDays);
		    }

		    function DisplayFMLA() {
		        var txtEmpType;
		        var txtFMLASDate;
		        var txtFMLAEDate;

		        txtEmpType = document.getElementById("txtEmpType");
		        txtFMLASDate = document.getElementById("txtFMLASDate");
		        txtFMLAEDate = document.getElementById("txtFMLAEDate");

		        //alert(isBlank(txtFMLASDate.value));
		        //alert(isBlank(txtFMLAEDate.value));

		        if (!isBlank(txtFMLASDate.value) && !isBlank(txtFMLAEDate.value)) {
		            d1 = new Date(txtFMLASDate.value);
		            d2 = new Date(txtFMLAEDate.value);

		            if (d1 > d2) {
		                alert('FMLA Start Date can not be greater than End Date .. Please check it out');
		                return false;
		            }


		            var TotDays;
		            var i;

		            i = d1;
		            TotDays = 0;
		            while (i <= d2) {
		                TotDays++;
		                i.setDate(i.getDate() + 1);
		            }

		            if (txtEmpType.value == 1 || txtEmpType.value == 2) {
		                document.getElementById("txtFMLAHrs").value = TotDays;
		                document.getElementById("lblFDays").innerHTML = (TotDays * 8) + ' Hrs';
		            }
		            else {
		                document.getElementById("txtFMLAHrs").value = TotDays * 8;
		                document.getElementById("lblFDays").innerHTML = TotDays + ' Days';
		            }
		        }

		    }


		    function DisplayDay30() {
		        var txtEmpType;
		        var txtDay30SDate;
		        var txtDay30EDate;

		        txtEmpType = document.getElementById("txtEmpType");
		        txtDay30SDate = document.getElementById("txtDay30SDate");
		        txtDay30EDate = document.getElementById("txtDay30EDate");

		        if (!isBlank(txtDay30SDate.value) && !isBlank(txtDay30EDate.value)) {
		            d1 = new Date(txtDay30SDate.value);
		            d2 = new Date(txtDay30EDate.value);

		            if (d1 > d2) {
		                alert('Day 30 Start Date can not be greater than End Date .. Please check it out');
		                return false;
		            }


		            var TotDays;
		            var i;

		            i = d1;
		            TotDays = 0;
		            while (i <= d2) {
		                TotDays++;
		                i.setDate(i.getDate() + 1);
		            }

		            if (txtEmpType.value == 1 || txtEmpType.value == 2) {
		                document.getElementById("txtDay30Hrs").value = TotDays;
		                document.getElementById("lbl30Days").innerHTML = (TotDays * 8) + ' Hrs';
		            }
		            else {
		                document.getElementById("txtDay30Hrs").value = TotDays * 8;
		                document.getElementById("lbl30Days").innerHTML = TotDays + ' Days';
		            }
		        }

		    }


		    function DisplayDay60() {
		        var txtEmpType;
		        var txtDay60SDate;
		        var txtDay60EDate;

		        txtEmpType = document.getElementById("txtEmpType");
		        txtDay60SDate = document.getElementById("txtDay60SDate");
		        txtDay60EDate = document.getElementById("txtDay60EDate");

		        if (!isBlank(txtDay60SDate.value) && !isBlank(txtDay60EDate.value)) {
		            d1 = new Date(txtDay60SDate.value);
		            d2 = new Date(txtDay60EDate.value);

		            if (d1 > d2) {
		                alert('Day 60 Start Date can not be greater than End Date .. Please check it out');
		                return false;
		            }


		            var TotDays;
		            var i;

		            i = d1;
		            TotDays = 0;
		            while (i <= d2) {
		                TotDays++;
		                i.setDate(i.getDate() + 1);
		            }

		            if (txtEmpType.value == 1 || txtEmpType.value == 2) {
		                document.getElementById("txtDay60Hrs").value = TotDays;
		                document.getElementById("lbl60Days").innerHTML = (TotDays * 8) + ' Hrs';
		            }
		            else {
		                document.getElementById("txtDay60Hrs").value = TotDays * 8;
		                document.getElementById("lbl60Days").innerHTML = TotDays + ' Days';
		            }
		        }

		    }


		    function DisplayPreg() {
		        var txtEmpType;
		        var txtPregSDate;
		        var txtPregEDate;

		        txtEmpType = document.getElementById("txtEmpType");
		        txtPregSDate = document.getElementById("txtPregSDate");
		        txtPregEDate = document.getElementById("txtPregEDate");

		        if (!isBlank(txtPregSDate.value) && !isBlank(txtPregEDate.value)) {
		            d1 = new Date(txtPregSDate.value);
		            d2 = new Date(txtPregEDate.value);

		            if (d1 > d2) {
		                alert('Pregnancy Start Date can not be greater than End Date .. Please check it out');
		                return false;
		            }


		            var TotDays;
		            var i;

		            i = d1;
		            TotDays = 0;
		            while (i <= d2) {
		                TotDays++;
		                i.setDate(i.getDate() + 1);
		            }

		            if (txtEmpType.value == 1 || txtEmpType.value == 2) {
		                document.getElementById("txtPregHrs").value = TotDays;
		                document.getElementById("lblPDays").innerHTML = (TotDays * 8) + ' Hrs';
		            }
		            else {
		                document.getElementById("txtPregHrs").value = TotDays * 8;
		                document.getElementById("lblPDays").innerHTML = TotDays + ' Days';
		            }
		        }

		    }

		    function DisplayWorkComp() {
		        var txtEmpType;
		        var txtWorkCompSDate;
		        var txtWorkCompEDate;

		        txtEmpType = document.getElementById("txtEmpType");
		        txtWorkCompSDate = document.getElementById("txtWorkCompSDate");
		        txtWorkCompEDate = document.getElementById("txtWorkCompEDate");

		        if (!isBlank(txtWorkCompSDate.value) && !isBlank(txtWorkCompEDate.value)) {
		            d1 = new Date(txtWorkCompSDate.value);
		            d2 = new Date(txtWorkCompEDate.value);

		            if (d1 > d2) {
		                alert('Workman Comp Start Date can not be greater than End Date .. Please check it out');
		                return false;
		            }


		            var TotDays;
		            var i;

		            i = d1;
		            TotDays = 0;
		            while (i <= d2) {
		                TotDays++;
		                i.setDate(i.getDate() + 1);
		            }

		            if (txtEmpType.value == 1 || txtEmpType.value == 2) {
		                document.getElementById("txtWorkCompHrs").value = TotDays;
		                document.getElementById("lblWDays").innerHTML = (TotDays * 8) + ' Hrs';
		            }
		            else {
		                document.getElementById("txtWorkCompHrs").value = TotDays * 8;
		                document.getElementById("lblWDays").innerHTML = TotDays + ' Days';
		            }
		        }

		    }


		</script>
</head>
    <%--onload="DisplayWEnds();"--%>
<body bottomMargin="2" bgColor="lavender" leftMargin="5" topMargin="2" rightMargin="5">
		<form id="frmLR" method="post" runat="server">
			<TABLE id="Table3" style="LEFT: 8px; POSITION: absolute; TOP: 8px" cellSpacing="0" cellPadding="0"
				border="0">
				<TR>
					<TD style="WIDTH: 661px; HEIGHT: 9px" align="center" height="9"><FONT face="Monotype Corsiva" size="6"><STRONG><asp:label id="lblHead" runat="server" Font-Size="Large" Font-Bold="True" Width="343px" Height="12px"
									ForeColor="DarkSlateBlue">New Leave Request</asp:label></STRONG></FONT></TD>
				</TR>
				<TR>
					<TD style="WIDTH: 661px; HEIGHT: 1px" align="center" height="1"><asp:label id="lblTitle" runat="server" Font-Size="XX-Small" Font-Bold="True" Width="630px"
							ForeColor="DarkSlateBlue" Font-Names="Microsoft Sans Serif">Label</asp:label></TD>
				</TR>
				<TR>
					<TD style="WIDTH: 661px; HEIGHT: 4px" align="center" height="4">
						<asp:label id="lblTitle1" runat="server" ForeColor="DarkSlateBlue" Width="630px" Font-Bold="True"
							Font-Size="XX-Small" Font-Names="Microsoft Sans Serif">Label</asp:label></TD>
				</TR>
				<TR>
					<TD style="WIDTH: 661px; HEIGHT: 21px" align="left" height="21">
						<HR style="WIDTH: 96.97%; COLOR: #000099; HEIGHT: 2px" width="96.97%" SIZE="2">
					</TD>
				</TR>
				<TR>
					<TD style="WIDTH: 661px; HEIGHT: 1px" align="center" height="1">
						<TABLE id="tblEmp" style="WIDTH: 661px; HEIGHT: 8px" cellSpacing="0" cellPadding="0" width="661"
							border="0" runat="server">
							<TR>
								<TD style="WIDTH: 156px; HEIGHT: 17px" align="left"><FONT face="Arial" size="2"><STRONG>Select 
											Employee&nbsp;&nbsp; </STRONG></FONT>
								</TD>
								<TD style="HEIGHT: 17px"><asp:dropdownlist id="cmbEmp" runat="server" Width="296px"></asp:dropdownlist>&nbsp;<INPUT id="cmdLeaveHist" style="FONT-WEIGHT: bold; FONT-SIZE: 11px; WIDTH: 136px; HEIGHT: 24px"
										onclick="ViewLeaveHist();" type="button" value="View Leave History" name="cmdLeaveHist"></TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD style="WIDTH: 661px; HEIGHT: 211px" align="center" height="211">
						<TABLE id="Table2" style="WIDTH: 661px; HEIGHT: 176px" cellSpacing="0" cellPadding="1"
							width="661" border="0">
							<TR>
								<TD id="TD1" style="WIDTH: 134px; HEIGHT: 4px" align="left" width="134"><FONT face="Arial" size="2"><STRONG>First 
											Day Off </STRONG></FONT>
								</TD>
								<TD style="WIDTH: 122px; HEIGHT: 4px"><asp:textbox id="txtSDate" runat="server" Font-Size="X-Small" Width="96px" BorderStyle="Solid"
										Preset="shortdate" CssClass="mask"></asp:textbox></TD>
								<TD style="HEIGHT: 4px" vAlign="bottom" align="left"><FONT size="2"><asp:label id="lblDaysOff" runat="server" Width="296px">Enter your # of Non-Vacation Days Off in the range</asp:label></FONT></TD>
								<TD style="HEIGHT: 4px"></TD>
							</TR>
							<TR>
								<TD id="TD2" style="WIDTH: 134px; HEIGHT: 15px" width="134"><FONT face="Arial" size="2"><STRONG>Last 
											Day Off</STRONG></FONT></TD>
								<TD style="WIDTH: 122px; HEIGHT: 15px"><asp:textbox id="txtEDate" runat="server" Font-Size="X-Small" Width="96px" BorderStyle="Solid"
										Preset="shortdate" CssClass="mask"></asp:textbox></TD>
								<TD style="HEIGHT: 15px" vAlign="middle" align="left"><asp:textbox id="txtDaysOff" runat="server" Font-Size="X-Small" Font-Bold="True" Width="48px"
										Height="22px" BorderStyle="Solid"></asp:textbox>&nbsp;
									<asp:label id="lblDaysOff1" runat="server" Font-Size="XX-Small" Width="104px" Font-Names="Microsoft Sans Serif"></asp:label></TD>
								<TD style="HEIGHT: 15px"></TD>
							</TR>
							<TR>
								<TD style="WIDTH: 134px; HEIGHT: 29px"><FONT face="Arial" size="2"><STRONG><FONT face="Arial" size="2"><STRONG><asp:label id="lblTR" runat="server" Width="152px">Time Requested (Days)</asp:label></STRONG></FONT></STRONG></FONT></TD>
								<TD style="WIDTH: 122px; HEIGHT: 29px"><asp:textbox id="txtActualHrs" runat="server" Font-Bold="True" Width="48px" BorderStyle="Solid"></asp:textbox>&nbsp;
									<asp:label id="lblADays" runat="server" Font-Size="XX-Small" Width="56px" Font-Names="Microsoft Sans Serif"></asp:label></TD>
								<TD style="HEIGHT: 29px" vAlign="middle" align="left" colSpan="1" rowSpan="1"><FONT size="1"><INPUT id="cmdTotalTime" style="FONT-WEIGHT: bold; FONT-SIZE: 11px; WIDTH: 312px; HEIGHT: 20px"
											onclick="DisplayTotalHrs();" type="button" value="Calculate Days" name="cmdTotalTime" runat="server"></FONT></TD>
								<TD style="HEIGHT: 29px"></TD>
							</TR>
							<TR>
								<TD style="WIDTH: 134px; HEIGHT: 52px" vAlign="top" width="134">
									<P><FONT face="Arial" size="2"><STRONG>Select Leave Type&nbsp;&nbsp; &nbsp; </STRONG></FONT>
										<FONT face="Arial" size="2"><STRONG><FONT size="1">(Break down&nbsp;Time&nbsp; Requested, 
													entered above)</FONT></STRONG></FONT>
									</P>
								</TD>
								<TD style="WIDTH: 134px; HEIGHT: 52px" vAlign="top" borderColor="black" width="134"
									colSpan="3">
									<TABLE id="Table5" style="WIDTH: 440px; HEIGHT: 105px" borderColor="#003399" cellSpacing="0"
										cellPadding="2" width="440" border="1">
										<TR>
											<TD style="WIDTH: 92px; HEIGHT: 9px" align="center" bgColor="#6699cc"><FONT face="Arial" size="2"><STRONG>Leave&nbsp;Type</STRONG></FONT></TD>
											<TD style="WIDTH: 171px; HEIGHT: 9px" vAlign="middle" align="left" bgColor="#6699cc"
												colSpan="1" rowSpan="1"><FONT face="Arial" size="2"><STRONG><asp:label id="lblTR1" runat="server" Width="160px">Leave Time (Days)</asp:label></STRONG></FONT></TD>
											<TD style="HEIGHT: 9px" align="center" bgColor="#6699cc" colSpan="1" rowSpan="1"><FONT face="Arial" size="2"><STRONG>Specify</STRONG></FONT></TD>
										</TR>
										<TR>
											<TD style="WIDTH: 92px; HEIGHT: 25px" align="center" bgColor="#99c4dc"><FONT face="Arial" size="2"><STRONG>Vacation</STRONG></FONT></TD>
											<TD style="WIDTH: 171px; HEIGHT: 25px" align="center" bgColor="#99c4dc" colSpan="1"
												rowSpan="1"><asp:textbox id="txtVacationHrs" runat="server" Font-Size="XX-Small" Width="71px" Font-Names="Microsoft Sans Serif"
													BorderStyle="Solid"></asp:textbox>&nbsp;
												<asp:label id="lblVDays" runat="server" Font-Size="XX-Small" Width="72px" Font-Names="Microsoft Sans Serif"></asp:label><FONT size="2"></FONT></TD>
											<TD style="HEIGHT: 25px" align="center" bgColor="#99c4dc" colSpan="1" rowSpan="1"><asp:dropdownlist id="cmbVacation" runat="server" Font-Size="XX-Small" Width="140px"></asp:dropdownlist></TD>
										</TR>
										<TR>
											<TD style="WIDTH: 92px; HEIGHT: 14px" align="center" bgColor="#99c4dc" colSpan="1" rowSpan="1"><FONT face="Arial" size="2"><STRONG>Sick</STRONG></FONT></TD>
											<TD style="WIDTH: 171px; HEIGHT: 14px" align="center" bgColor="#99c4dc" colSpan="1"
												rowSpan="1"><asp:textbox id="txtSickHrs" runat="server" Font-Size="XX-Small" Width="71px" Font-Names="Microsoft Sans Serif"
													BorderStyle="Solid"></asp:textbox>&nbsp;
												<asp:label id="lblSDays" runat="server" Font-Size="XX-Small" Width="72px" Font-Names="Microsoft Sans Serif"></asp:label></TD>
											<TD style="HEIGHT: 14px" align="center" bgColor="#99c4dc" colSpan="1" rowSpan="1"><asp:dropdownlist id="cmbSick" runat="server" Font-Size="XX-Small" Width="140px"></asp:dropdownlist></TD>
										</TR>
										<TR>
											<TD style="WIDTH: 92px; HEIGHT: 18px" align="center" bgColor="#99c4dc" colSpan="1" rowSpan="1"><FONT face="Arial" size="2"><STRONG>Unpaid</STRONG></FONT></TD>
											<TD style="WIDTH: 171px; HEIGHT: 18px" align="center" bgColor="#99c4dc" colSpan="1"
												rowSpan="1"><asp:textbox id="txtUnPaidHrs" runat="server" Font-Size="XX-Small" Width="72px" Font-Names="Microsoft Sans Serif"
													BorderStyle="Solid"></asp:textbox>&nbsp;
												<asp:label id="lblUDays" runat="server" Font-Size="XX-Small" Width="72px" Font-Names="Microsoft Sans Serif"></asp:label></TD>
											<TD style="HEIGHT: 18px" align="center" bgColor="#99c4dc" colSpan="1" rowSpan="1"><asp:dropdownlist id="cmbUnPaid" runat="server" Font-Size="XX-Small" Width="140px"></asp:dropdownlist></TD>
										</TR>
									</TABLE>
								</TD>
							</TR>
							<TR>
								<TD style="WIDTH: 134px; HEIGHT: 6px" vAlign="top" width="134"></TD>
								<TD style="WIDTH: 134px; HEIGHT: 6px" vAlign="top" borderColor="#000000" width="134"
									colSpan="3"><asp:checkbox id="chkIntFMLA" runat="server" Font-Size="X-Small" Width="320px" BorderStyle="None"
										Text="I am interested in FMLA (LOA for Sick &amp; Unpaid Only)"></asp:checkbox></TD>
							</TR>
							<TR>
								<TD style="WIDTH: 161px; HEIGHT: 2px" vAlign="top" colSpan="4">
									<TABLE id="tblHR" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server">
										<TR>
											<TD style="WIDTH: 162px" vAlign="top" noWrap width="162"><FONT face="Arial" size="2"><STRONG>HR 
														Break Down</STRONG></FONT></TD>
											<TD>
												<TABLE id="tblHR1" style="WIDTH: 464px; HEIGHT: 28px" borderColor="#003399" cellSpacing="0"
													cellPadding="2" width="464" border="1">
													<TR>
														<TD style="WIDTH: 33px; HEIGHT: 3px" align="center" bgColor="#6699cc" colSpan="1" rowSpan="1">&nbsp;</TD>
														<TD style="WIDTH: 125px; HEIGHT: 3px" align="center" bgColor="#6699cc" colSpan="1" rowSpan="1"><FONT face="Arial" size="2"><STRONG>Type</STRONG></FONT></TD>
														<TD style="WIDTH: 155px; HEIGHT: 3px" align="left" bgColor="#6699cc"><FONT face="Arial" size="2"><STRONG>&nbsp;Time 
																	Taken (Hrs.)</STRONG></FONT></TD>
														<TD style="WIDTH: 68px; HEIGHT: 3px" align="center" bgColor="#6699cc"><FONT face="Arial" size="2"><STRONG>Start 
																	Date</STRONG></FONT></TD>
														<TD style="HEIGHT: 3px" align="center" bgColor="#6699cc"><FONT face="Arial" size="2"><STRONG>End 
																	Date</STRONG></FONT></TD>
													</TR>
													<TR>
														<TD style="WIDTH: 33px; HEIGHT: 9px" align="center"><asp:checkbox id="chkFMLA" runat="server" Font-Size="XX-Small"></asp:checkbox></TD>
														<TD style="WIDTH: 125px; HEIGHT: 9px" align="left"><FONT face="Arial" size="2"><STRONG>FMLA</STRONG></FONT></TD>
														<TD style="WIDTH: 155px; HEIGHT: 9px" align="center"><asp:textbox id="txtFMLAHrs" runat="server" Font-Size="XX-Small" Width="48px" Font-Names="Microsoft Sans Serif"
																BorderStyle="Solid"></asp:textbox><asp:label id="lblFDays" runat="server" Font-Size="XX-Small" Width="72px" Font-Names="Microsoft Sans Serif"></asp:label></TD>
														<TD style="WIDTH: 68px; HEIGHT: 9px" align="center"><asp:textbox id="txtFMLASDate" runat="server" Font-Size="XX-Small" Width="65px" Font-Names="Microsoft Sans Serif"
																BorderStyle="Solid" Preset="shortdate" CssClass="mask"></asp:textbox></TD>
														<TD style="HEIGHT: 9px" align="center"><asp:textbox id="txtFMLAEDate" runat="server" Font-Size="XX-Small" Width="65px" Font-Names="Microsoft Sans Serif"
																BorderStyle="Solid" Preset="shortdate" CssClass="mask"></asp:textbox></TD>
													</TR>
													<TR>
														<TD style="WIDTH: 33px; HEIGHT: 17px" align="center"><asp:checkbox id="chk30Day" runat="server" Font-Size="XX-Small"></asp:checkbox></TD>
														<TD style="WIDTH: 125px; HEIGHT: 17px" align="left" colSpan="1" rowSpan="1"><FONT face="Arial" size="2"><STRONG>30 
																	Day</STRONG></FONT></TD>
														<TD style="WIDTH: 155px; HEIGHT: 17px" align="center"><asp:textbox id="txtDay30Hrs" runat="server" Font-Size="XX-Small" Width="48px" Font-Names="Microsoft Sans Serif"
																BorderStyle="Solid"></asp:textbox><asp:label id="lbl30Days" runat="server" Font-Size="XX-Small" Width="72px" Font-Names="Microsoft Sans Serif"></asp:label></TD>
														<TD style="WIDTH: 68px; HEIGHT: 17px" align="center"><asp:textbox id="txtDay30SDate" runat="server" Font-Size="XX-Small" Width="65px" Font-Names="Microsoft Sans Serif"
																BorderStyle="Solid" Preset="shortdate" CssClass="mask"></asp:textbox></TD>
														<TD style="HEIGHT: 17px" align="center"><asp:textbox id="txtDay30EDate" runat="server" Font-Size="XX-Small" Width="65px" Font-Names="Microsoft Sans Serif"
																BorderStyle="Solid" Preset="shortdate" CssClass="mask"></asp:textbox></TD>
													</TR>
													<TR>
														<TD style="WIDTH: 33px; HEIGHT: 17px" align="center"><asp:checkbox id="chk60Day" runat="server" Font-Size="XX-Small"></asp:checkbox></TD>
														<TD style="WIDTH: 125px; HEIGHT: 17px" align="left" colSpan="1" rowSpan="1"><FONT face="Arial" size="2"><STRONG>60 
																	Day</STRONG></FONT></TD>
														<TD style="WIDTH: 155px; HEIGHT: 17px" align="center"><asp:textbox id="txtDay60Hrs" runat="server" Font-Size="XX-Small" Width="48px" Font-Names="Microsoft Sans Serif"
																BorderStyle="Solid"></asp:textbox><asp:label id="lbl60Days" runat="server" Font-Size="XX-Small" Width="72px" Font-Names="Microsoft Sans Serif"></asp:label></TD>
														<TD style="WIDTH: 68px; HEIGHT: 17px" align="center"><asp:textbox id="txtDay60SDate" runat="server" Font-Size="XX-Small" Width="65px" Font-Names="Microsoft Sans Serif"
																BorderStyle="Solid" Preset="shortdate" CssClass="mask"></asp:textbox></TD>
														<TD style="HEIGHT: 17px" align="center"><asp:textbox id="txtDay60EDate" runat="server" Font-Size="XX-Small" Width="65px" Font-Names="Microsoft Sans Serif"
																BorderStyle="Solid" Preset="shortdate" CssClass="mask"></asp:textbox></TD>
													</TR>
													<TR>
														<TD style="WIDTH: 33px; HEIGHT: 17px" align="center"><asp:checkbox id="chkPregnancy" runat="server" Font-Size="XX-Small"></asp:checkbox></TD>
														<TD style="WIDTH: 125px; HEIGHT: 17px" align="left" colSpan="1" rowSpan="1"><FONT face="Arial" size="2"><STRONG>Pregnancy</STRONG></FONT></TD>
														<TD style="WIDTH: 155px; HEIGHT: 17px" align="center"><asp:textbox id="txtPregHrs" runat="server" Font-Size="XX-Small" Width="48px" Font-Names="Microsoft Sans Serif"
																BorderStyle="Solid"></asp:textbox><asp:label id="lblPDays" runat="server" Font-Size="XX-Small" Width="72px" Font-Names="Microsoft Sans Serif"></asp:label></TD>
														<TD style="WIDTH: 68px; HEIGHT: 17px" align="center"><asp:textbox id="txtPregSDate" runat="server" Font-Size="XX-Small" Width="65px" Font-Names="Microsoft Sans Serif"
																BorderStyle="Solid" Preset="shortdate" CssClass="mask"></asp:textbox></TD>
														<TD style="HEIGHT: 17px" align="center"><asp:textbox id="txtPregEDate" runat="server" Font-Size="XX-Small" Width="65px" Font-Names="Microsoft Sans Serif"
																BorderStyle="Solid" Preset="shortdate" CssClass="mask"></asp:textbox></TD>
													</TR>
													<TR>
														<TD style="WIDTH: 33px; HEIGHT: 17px" align="center"><asp:checkbox id="chkWorkComp" runat="server" Font-Size="XX-Small"></asp:checkbox></TD>
														<TD style="WIDTH: 125px; HEIGHT: 17px" align="left" colSpan="1" rowSpan="1"><FONT face="Arial" size="2"><STRONG>Workman 
																	Comp</STRONG></FONT></TD>
														<TD style="WIDTH: 155px; HEIGHT: 17px" align="center"><asp:textbox id="txtWorkCompHrs" runat="server" Font-Size="XX-Small" Width="48px" Font-Names="Microsoft Sans Serif"
																BorderStyle="Solid"></asp:textbox><asp:label id="lblWDays" runat="server" Font-Size="XX-Small" Width="72px" Font-Names="Microsoft Sans Serif"></asp:label></TD>
														<TD style="WIDTH: 68px; HEIGHT: 17px" align="center"><asp:textbox id="txtWorkCompSDate" runat="server" Font-Size="XX-Small" Width="65px" Font-Names="Microsoft Sans Serif"
																BorderStyle="Solid" Preset="shortdate" CssClass="mask"></asp:textbox></TD>
														<TD style="HEIGHT: 17px" align="center"><asp:textbox id="txtWorkCompEDate" runat="server" Font-Size="XX-Small" Width="65px" Font-Names="Microsoft Sans Serif"
																BorderStyle="Solid" Preset="shortdate" CssClass="mask"></asp:textbox></TD>
													</TR>
												</TABLE>
											</TD>
										</TR>
									</TABLE>
								</TD>
							</TR>
							<TR>
								<TD style="WIDTH: 137px; HEIGHT: 3px" vAlign="middle" width="137"><FONT face="Arial" size="2"><STRONG>Comments</STRONG></FONT></TD>
								<TD style="WIDTH: 134px; HEIGHT: 3px" width="134" colSpan="3"><asp:textbox id="txtComments" runat="server" Width="440px" Height="56px" BorderStyle="Solid"
										TextMode="MultiLine"></asp:textbox></TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD style="WIDTH: 661px; HEIGHT: 15px" align="left" height="15">
						<TABLE id="tblUndoApproval" style="WIDTH: 632px; HEIGHT: 47px" cellSpacing="0" cellPadding="0"
							width="632" border="0" runat="server">
							<TR>
								<TD style="WIDTH: 163px"><FONT face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG>Undo 
																	Approval Notes</STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></FONT></TD>
								<TD><asp:textbox id="txtUndoNotes" runat="server" Width="440px" Height="38px" TextMode="MultiLine"></asp:textbox></TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD style="WIDTH: 661px; HEIGHT: 13px" align="left" colSpan="1" rowSpan="1">
						<HR style="WIDTH: 96.05%; COLOR: #000099; HEIGHT: 2px" width="96.05%" SIZE="2">
					</TD>
				</TR>
				<TR>
					<TD style="WIDTH: 661px; HEIGHT: 24px" align="center" height="24"><asp:button id="cmdApprove" runat="server" Font-Size="X-Small" Font-Bold="True" Width="129px"
							Font-Names="Arial" Text="Approve"></asp:button>&nbsp;
						<asp:button id="cmdDeny" runat="server" Font-Size="X-Small" Font-Bold="True" Width="84px" Font-Names="Arial"
							Text="Deny"></asp:button>&nbsp; <INPUT id="cmdLeaveHist1" style="FONT-WEIGHT: bold; FONT-SIZE: x-small; WIDTH: 147px; FONT-FAMILY: Arial; HEIGHT: 24px"
							onclick="window.returnValue = 0; window.close();" type="button" value="View Leave History" name="cmdLeaveHist1" runat="server">&nbsp;
						<asp:button id="cmdSubmit" runat="server" Font-Size="X-Small" Font-Bold="True" Width="134px"
							Font-Names="Arial" Text="Submit"></asp:button>&nbsp; <INPUT id="cmdExit" style="FONT-WEIGHT: bold; FONT-SIZE: x-small; WIDTH: 69px; FONT-FAMILY: Arial; HEIGHT: 24px"
							onclick="window.returnValue = 0; window.close();" type="button" value="Exit" name="cmdExit"><INPUT id="txtClockId" style="WIDTH: 26px; HEIGHT: 22px" type="hidden" size="1" name="txtClockId"
							runat="server"><INPUT id="txtLRId" style="WIDTH: 26px; HEIGHT: 22px" type="hidden" size="1" name="txtLRId"
							runat="server"><INPUT id="txtLRDId" style="WIDTH: 26px; HEIGHT: 22px" type="hidden" size="1" value="0"
							name="txtLRDId" runat="server"><INPUT id="txtManClockId" style="WIDTH: 26px; HEIGHT: 22px" type="hidden" size="1" name="txtManId"
							runat="server"><INPUT id="txtHR" style="WIDTH: 26px; HEIGHT: 22px" type="hidden" size="1" name="txtHR"
							runat="server"><INPUT id="txtUnit" style="WIDTH: 26px; HEIGHT: 22px" type="hidden" size="1" name="txtUnit"
							runat="server"><INPUT id="txtEmpType" style="WIDTH: 26px; HEIGHT: 22px" type="hidden" size="1" name="txtEmpType"
							runat="server"><INPUT id="txtTotalHrs" style="WIDTH: 26px; HEIGHT: 22px" type="hidden" size="1" name="txtTotalHrs"
							runat="server"><INPUT id="txtPosted" style="WIDTH: 26px; HEIGHT: 22px" type="hidden" size="1" name="txtPosted"
							runat="server"></TD>
				</TR>
				<TR>
					<TD style="WIDTH: 661px; HEIGHT: 31px" align="center" height="31"><asp:label id="lblStatus" runat="server" Font-Size="X-Small" Font-Bold="True" Width="598px"
							ForeColor="#004000" Font-Names="Arial"></asp:label></TD>
				</TR>
			</TABLE>
			&nbsp;
		</form>
		<!-- PopUp Calendar BEGIN -->
		<script language="JavaScript">
		    if (document.all) {
		        document.writeln("<div id=\"PopUpCalendar\" style=\"position:absolute; left:0px; top:0px; z-index:7; width:200px; height:77px; overflow: visible; visibility: hidden; background-color: #FFFFFF; border: 1px none #000000\" onMouseOver=\"if(ppcTI){clearTimeout(ppcTI);ppcTI=false;}\" onMouseOut=\"ppcTI=setTimeout(\'hideCalendar()\',500)\">");
		        document.writeln("<div id=\"monthSelector\" style=\"position:absolute; left:0px; top:0px; z-index:9; width:181px; height:27px; overflow: visible; visibility:inherit\">");
		    }
		    else if (document.layers) {
		        document.writeln("<layer id=\"PopUpCalendar\" pagex=\"0\" pagey=\"0\" width=\"200\" height=\"200\" z-index=\"100\" visibility=\"hide\" bgcolor=\"#FFFFFF\" onMouseOver=\"if(ppcTI){clearTimeout(ppcTI);ppcTI=false;}\" onMouseOut=\"ppcTI=setTimeout('hideCalendar()',500)\">");
		        document.writeln("<layer id=\"monthSelector\" left=\"0\" top=\"0\" width=\"181\" height=\"27\" z-index=\"9\" visibility=\"inherit\">");
		    }
		    else {
		        document.writeln("<p><font color=\"#FF0000\"><b>Error ! The current browser is either too old or too modern (usind DOM document structure).</b></font></p>");
		    }
		</script>
		<noscript>
			<font color="#ff0000"><b>JavaScript is not activated !</b></font></noscript>
		<table cellSpacing="1" borderColorDark="#000000" cellPadding="2" width="200" borderColorLight="#000000"
			border="1">
			<form name="ppcMonthList">
				<TBODY>
					<tr>
						<td align="center" bgColor="#cccccc"><A onmouseover="window.status=' ';return true;" href="javascript:moveMonth('Back')"><font face="Arial, Helvetica, sans-serif" color="#000000" size="2"><b>&lt;&nbsp;</b></font></A><font face="MS Sans Serif, sans-serif" size="1">
								<select style="FONT-SIZE: 9pt; FONT-FAMILY: 'MS Sans Serif', sans-serif" onmouseout="if(ppcIE){window.event.cancelBubble = true;}"
									onchange="switchMonth(this.options[this.selectedIndex].value)" name="sItem">
									<option value="0">2000 • January</option>
									<option value="1">2000 • February</option>
									<option value="2" selected>2000 • March</option>
									<option value="3">2000 • April</option>
									<option value="4">2000 • May</option>
									<option value="5">2000 • June</option>
									<option value="6">2000 • July</option>
									<option value="7">2000 • August</option>
									<option value="8">2000 • September</option>
									<option value="9">2000 • October</option>
									<option value="10">2000 • November</option>
									<option value="11">2000 • December</option>
									<option value="0">2001 • January</option>
									<option value="1">2001 • February</option>
									<option value="2">2001 • March</option>
								</select></font><A onmouseover="window.status=' ';return true;" href="javascript:moveMonth('Forward')"><font face="Arial, Helvetica, sans-serif" color="#000000" size="2"><b>&nbsp;&gt;</b></font></A></td>
					</tr>
			</form>
			</TBODY></table>
		<table cellSpacing="1" borderColorDark="#000000" cellPadding="2" width="200" borderColorLight="#000000"
			border="1">
			<tr align="center" bgColor="#cccccc">
				<td width="20" bgColor="#ffffcc"><b><font face="MS Sans Serif, sans-serif" size="1">Su</font></b></td>
				<td width="20"><b><font face="MS Sans Serif, sans-serif" size="1">Mo</font></b></td>
				<td width="20"><b><font face="MS Sans Serif, sans-serif" size="1">Tu</font></b></td>
				<td width="20"><b><font face="MS Sans Serif, sans-serif" size="1">We</font></b></td>
				<td width="20"><b><font face="MS Sans Serif, sans-serif" size="1">Th</font></b></td>
				<td width="20"><b><font face="MS Sans Serif, sans-serif" size="1">Fr</font></b></td>
				<td width="20" bgColor="#ffffcc"><b><font face="MS Sans Serif, sans-serif" size="1">Sa</font></b></td>
			</tr>
		</table>
		<script language="JavaScript">
		    if (document.all) {
		        document.writeln("</div>");
		        document.writeln("<div id=\"monthDays\" style=\"position:absolute; left:0px; top:52px; z-index:8; width:200px; height:17px; overflow: visible; visibility:inherit; background-color: #FFFFFF; border: 1px none #000000\">&nbsp;</div></div>");
		    }
		    else if (document.layers) {
		        document.writeln("</layer>");
		        document.writeln("<layer id=\"monthDays\" left=\"0\" top=\"52\" width=\"200\" height=\"17\" z-index=\"8\" bgcolor=\"#FFFFFF\" visibility=\"inherit\">&nbsp;</layer></layer>");
		    }
		    else {/*NOP*/ }
		</script>
		<!-- PopUp Calendar END -->
	</body>
</html>
