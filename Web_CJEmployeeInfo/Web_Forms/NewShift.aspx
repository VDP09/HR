<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="NewShift.aspx.vb" Inherits="Web_CJEmployeeInfo.NewShift" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add New Shift</title>
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

        function ValidateTime() {
            var d1;
            var d2;
            var dd1;
            var dd2;
            var i;
            var j;

            //Check for blank values and valid time format

            //Check Punch Details				
            d1 = new Date('1/1/1900 ' + frmNewShift.txtHPunchIN.value + ':' + frmNewShift.txtMPunchIN.value)
            d2 = new Date('1/1/1900 ' + frmNewShift.txtHPunchOUT.value + ':' + frmNewShift.txtMPunchOUT.value)

            //alert(frmNewShift.txtHPunchOUT.value + ':' + frmNewShift.txtMPunchOUT.value);
            //alert(d2);

            if (d1 > d2)
                d2 = new Date('1/2/1900 ' + frmNewShift.txtHPunchOUT.value + ':' + frmNewShift.txtMPunchOUT.value)

            if (isNaN(d1.getHours()) || !isTime(frmNewShift.txtHPunchIN.value + ':' + frmNewShift.txtMPunchIN.value)) {
                alert('Invalid Time IN for Punch Details .. Please check it out');
                return false;
            }
            else if (isNaN(d2.getHours()) || !isTime(frmNewShift.txtHPunchOUT.value + ':' + frmNewShift.txtMPunchOUT.value)) {
                alert('Invalid Time OUT for Punch Details .. Please check it out');
                return false;
            }

            /*
            else if (d1>d2){
                alert('Time IN can not be greater than Time OUT for Punch Details .. Please check it out');
                return false;
            }
            */

            //Check Break Details
            j = frmNewShift.txtBCount.value - 1;

            for (i = 1; i <= j; i++) {

                dd1 = new Date('1/1/1900 ' + eval("frmNewShift.txtHBIN" + i + ".value") + ':' + eval("frmNewShift.txtMBIN" + i + ".value"))
                dd2 = new Date('1/1/1900 ' + eval("frmNewShift.txtHBOUT" + i + ".value") + ':' + eval("frmNewShift.txtMBOUT" + i + ".value"))

                if (isNaN(dd1.getHours()) || !isTime(eval("frmNewShift.txtHBIN" + i + ".value") + ':' + eval("frmNewShift.txtMBIN" + i + ".value"))) {
                    alert('Invalid Time IN for Break - ' + i + ' .. Please check it out');
                    return false;
                }
                else if (isNaN(dd2.getHours()) || !isTime(eval("frmNewShift.txtHBOUT" + i + ".value") + ':' + eval("frmNewShift.txtMBOUT" + i + ".value"))) {
                    alert('Invalid Time OUT for Break - ' + i + ' .. Please check it out');
                    return false;
                }

                if (dd1 < d1)
                    dd1 = new Date('1/2/1900 ' + eval("frmNewShift.txtHBIN" + i + ".value") + ':' + eval("frmNewShift.txtMBIN" + i + ".value"));

                if (dd2 < d1)
                    dd2 = new Date('1/2/1900 ' + eval("frmNewShift.txtHBOUT" + i + ".value") + ':' + eval("frmNewShift.txtMBOUT" + i + ".value"));

                if (dd1 > dd2) {
                    alert('Time IN can not be greater than Time OUT for Break - ' + i + ' .. Please check it out');
                    return false;
                }

                //Check if the break falls between punch in/out
                if (dd1 < d1 || dd1 > d2) {
                    alert('Time IN for Break - ' + i + ' must be between Punch Time IN-OUT .. Please check it out');
                    return false;
                }

                if (dd2 < d1 || dd2 > d2) {
                    alert('Time OUT for Break - ' + i + ' must be between Punch Time IN-OUT .. Please check it out');
                    return false;
                }

                //Check Dec Tips
                if ((frmNewShift.txtDecTips.value - 0) != frmNewShift.txtDecTips.value) {
                    alert('Invalid Declared Tips .. Please check it out');
                    return false;
                }
            }

            return true;
        }


        function CheckTotPaidTime() {
            var d1;

            d1 = new Date('1/1/1900 ' + frmNewShift.txtTotPaid.value);

            if (isNaN(d1.getHours()) || !isTime(frmNewShift.txtTotPaid.value)) {
                alert('Invalid Total Paid Time .. Please check it out');
                return false;
            }

            return true;
        }

        function ValidateFormData() {
            //RecalElapsedTime();
            var strConfirm;

            if (ValidateOtherData())
                if (ValidateTime()) {
                    RecalElapsedTime();

                    if (CheckTotPaidTime()) {
                        strConfirm = 'Update Changes ?' +
                            '\n' + '\n' + 'Total Paid Time (hh:mm) - ' + frmNewShift.txtTotPaid.value;

                        if (confirm(strConfirm)) {
                            frmNewShift.cmdRecalETime.disabled = true;
                            frmNewShift.cmdReset.disabled = true;
                            frmNewShift.cmdExit.disabled = true;
                            frmNewShift.cmdAddBreak.disabled = true;

                            frmNewShift.cmdSubmit.value = 'Please Wait';
                            frmNewShift.cmdSubmit.disabled = true;
                            document.getElementById("divMessage").innerHTML = '.. DO NOT Close this window, it will close by itself ..';
                            return true;
                        }
                        else
                            return false;
                    }
                }

            return false;
        }

        function ValidateOtherData() {
            if (isblank(frmNewShift.txtDOB.value) ||
                isblank(frmNewShift.cmbJobCode.options(frmNewShift.cmbJobCode.selectedIndex).text)) {
                alert('Following are required fields .. Please check it out' +
                    '\n' + '\n' + 'Date Worked' + '\n' + 'Department');
                return false;
            }
            else
                return true;
        }

        function isTime(s) {
            var i;
            var c;
            var hr;
            var min;
            var j;

            if (s.length < 3)
                return false;

            j = s.indexOf(':');
            if (j < 0)
                return false;

            hr = s.substring(0, j);
            if (isblank(hr))
                return false;

            for (i = 0; i < hr.length; i++) {
                c = hr.charAt(i);
                if (!isDigit(c))
                    return false;
            }

            min = s.substring(j + 1, 5);
            if (isblank(min))
                return false;

            for (i = 0; i < min.length; i++) {
                c = min.charAt(i);
                if (!isDigit(c))
                    return false;
            }

            if ((hr == 0) && (min == 0))
                return false;

            return true;
        }

        function CalcTotalPaidTime() {
            var i;
            var TotMin;
            var min;
            var hour;
            var j;
            var s;
            var k;
            var strMin;

            s = frmNewShift.txtPETime.value;
            j = s.indexOf(':');

            hour = eval(s.substring(0, j));
            min = eval(s.substring(j + 1, 5));

            TotMin = (hour * 60) + min;

            k = frmNewShift.txtBCount.value - 1;



            for (i = 1; i <= k; i++) {
                if (eval("frmNewShift.cmbBPaid" + i + ".options(frmNewShift.cmbBPaid" + i + ".selectedIndex).value") == 'No') {
                    s = eval("frmNewShift.txtBETime" + i + ".value");

                    if (s != '') {
                        j = s.indexOf(':');

                        hour = eval(s.substring(0, j));
                        min = eval(s.substring(j + 1, 5));

                        TotMin = TotMin - (hour * 60) - min;
                    }
                }
            }

            min = TotMin % 60;

            if (min < 10)
                strMin = '0' + min;
            else
                strMin = min;

            //alert((TotMin - (TotMin % 60))/60 + ':' + strMin);

            frmNewShift.txtTotPaid.value = (TotMin - (TotMin % 60)) / 60 + ':' + strMin;
        }

        function isDigit(c) {
            return ((c >= "0") && (c <= "9"))
        }

        function isblank(s) {
            if ((s == null) || (s.length == 0) || s == "")
                return true;

            for (var i = 0; i < s.length; i++) {
                var c = s.charAt(i);
                if ((c != ' ') && (c != '\n') && (c != '\t')) return false;
            }
            return true;
        }

        function DateDiff(t1, t2) {
            date1 = new Date('1/1/1900 ' + t1);
            date2 = new Date('1/1/1900 ' + t2);
            diff = new Date();

            if (date1 > date2)
                date2 = new Date('1/2/1900 ' + t2);

            // sets difference date to difference of first date and second date
            diff.setTime(Math.abs(date1.getTime() - date2.getTime()));

            timediff = diff.getTime();

            weeks = Math.floor(timediff / (1000 * 60 * 60 * 24 * 7));
            timediff -= weeks * (1000 * 60 * 60 * 24 * 7);

            days = Math.floor(timediff / (1000 * 60 * 60 * 24));
            timediff -= days * (1000 * 60 * 60 * 24);

            hours = Math.floor(timediff / (1000 * 60 * 60));
            timediff -= hours * (1000 * 60 * 60);

            mins = Math.floor(timediff / (1000 * 60));
            timediff -= mins * (1000 * 60);

            secs = Math.floor(timediff / 1000);
            timediff -= secs * 1000;

            var strMin;
            if (mins < 10)
                strMin = '0' + mins;
            else
                strMin = mins;

            return hours + ':' + strMin;
        }

        function RecalElapsedTime() {
            if (!ValidateTime())
                return false;

            var i;
            var j;
            var k;
            var strName;


            //Recalculate Punch Time IN/OUT
            frmNewShift.txtPETime.value = DateDiff(frmNewShift.txtHPunchIN.value + ':' + frmNewShift.txtMPunchIN.value, frmNewShift.txtHPunchOUT.value + ':' + frmNewShift.txtMPunchOUT.value);

            //Recalculate breaks
            j = frmNewShift.length;

            for (i = 0; i <= j - 1; i++) {
                strName = frmNewShift.elements[i].name;
                if (strName.indexOf("BETime") > -1) {
                    k = strName.substring(strName.length - 1, strName.length);
                    frmNewShift.elements[i].value = DateDiff(eval("frmNewShift.txtHBIN" + k + ".value") + ':' + eval("frmNewShift.txtMBIN" + k + ".value"), eval("frmNewShift.txtHBOUT" + k + ".value") + ':' + eval("frmNewShift.txtMBOUT" + k + ".value"));
                }
            }

            CalcTotalPaidTime();
        }

        function AddNew() {
            var str;
            str = 'NewShift.aspx?ClockId=' + frmNewShift.txtClockId.value + '&EName=' + frmNewShift.txtEName.value + '&MCId=' + frmNewShift.txtManClockId.value + '&Unit=' + frmNewShift.txtUnit.value + '&AddNew=' + frmNewShift.txtBCount.value;
            //alert(str);
            location.href = str;
        }

        function ResetPage() {
            var str;
            str = 'NewShift.aspx?ClockId=' + frmNewShift.txtClockId.value + '&EName=' + frmNewShift.txtEName.value + '&MCId=' + frmNewShift.txtManClockId.value + '&Unit=' + frmNewShift.txtUnit.value + '&AddNew=0';
            location.href = str;
        }

    </script>
    <link href="ua.css" rel="stylesheet">
</head>
<body bottommargin="5" bgcolor="lavender" topmargin="5">
    <form id="Form1" method="post" runat="server">
        <div>
        </div>
    </form>
</body>
</html>
