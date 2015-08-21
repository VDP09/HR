function ValidateData() {

    var txtEmpClockId = $("#txtEmpClockId").val();

    if (txtEmpClockId - 0 != txtEmpClockId) {
        alert('Invalid Clock Id .. Please check it out');
        return false;
    }

    return true;
}

function DisplayHelpWin() {
    var strURL;

    //alert('Rupesh');
    strURL = 'CJ HR Express_UG.htm';
    window.open(strURL, '20', 'resizable=no,top=5, left=5, width=750,height=560,scrollbars=yes,menubar=no,toolbar=no');
}

function OpenOAMoveWin() {
    var strURL;

    strURL = 'MoveOATemp.aspx';
    window.open(strURL, '21', 'resizable=no,top=5, left=5, width=690,height=450,scrollbars=yes,menubar=no,toolbar=no');
}

function OpenNewWin(i) {
    var strURL;
    
    if (i == 1)	//Edit Punch Window
    {
        strURL = 'EmpEditPunch.aspx?Unit=' + frmMER.txtUnit.value +
            '&ManCId=' + frmMER.txtManClockId.value +
            '&SC=' + frmMER.txtSecCode.value;

        window.open(strURL, 'wEditPunch', 'resizable=no,top=5, left=5, width=810,height=650,scrollbars=yes,menubar=no,toolbar=no');
    }

    else if (i == 2)	//Submit Payroll window
    {
        strURL = 'SubmitPayroll.aspx?Unit=' + frmMER.txtUnit.value +
            '&ManCId=' + frmMER.txtManClockId.value +
            '&SC=' + frmMER.txtSecCode.value;

        window.open(strURL, 'wSubmitPrl', 'resizable=no,top=5, left=5, width=680,height=500,scrollbars=yes,menubar=no,toolbar=no');
    }
}

$().ready(function () { 
    
});