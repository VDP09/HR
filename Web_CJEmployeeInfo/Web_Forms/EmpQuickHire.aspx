<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EmpQuickHire.aspx.vb" Inherits="Web_CJEmployeeInfo.EmpQuickHire" %>
<%@ Register TagPrefix="mb" Namespace="MetaBuilders.WebControls" Assembly="MetaBuilders.WebControls.DynamicListBox" %> 
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employee Quick Hire</title>
    <link href="../assets/plugins/boostrapv3/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../pages/css/pages.css" rel="stylesheet" />
    <script src="../Scripts/NumberFormat.js"></script>
    <httpHandlers> 
			<add verb="*" 
			path="MetaBuilders_WebControls_DynamicListBoxResourceHandler.axd" 
			type="MetaBuilders.WebControls.DynamicListBoxResourceHandler,MetaBuilders.WebControls.DynamicListBox" 
			validate="false"> 
	 </httpHandlers> 
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

                        var option = document.createElement("OPTION");
                        option.innerHTML = cmbJobCode.options(cmbJobCode.selectedIndex).text + '  |  ' + formatNumber(txtPayRate.value, '0.00') + '  |  Primary' + '  *';
                        option.value = intJobCode;
                        lstJobCode.appendChild(option);

                        //lstJobCode.Add(intJobCode, cmbJobCode.options(cmbJobCode.selectedIndex).text + '  |  ' + formatNumber(txtPayRate.value, '0.00') + '  |  Primary' + '  *');
                                              
                    }
                }
                else {
                    var option = document.createElement("OPTION");
                    option.innerHTML = cmbJobCode.options(cmbJobCode.selectedIndex).text + '  |  ' + parseFloat(txtPayRate.value).toFixed(2) + '  *';
                    option.value = intJobCode;
                    lstJobCode.appendChild(option);
                    //lstJobCode.add(intJobCode, cmbJobCode.options(cmbJobCode.selectedIndex).text + '  |  ' + parseFloat(txtPayRate.value).toFixed(2) + '  *');
                }

                cmbJobCode.selectedIndex = -1;
                txtPayRate.value = '';
                chkPrimary.checked = false;
            }

            else		// Remove Job Code
            {

                for (var i = 0; i < lstJobCode.options.length; i++) {
                    if (lstJobCode.options[i].selected == true) {
                        lstJobCode.removeChild(lstJobCode.options[i]);
                    }
                }

                //lstJobCode.Remove(lstJobCode.options.selectedIndex);  //options[lstJobCode.selectedIndex] = null;
            }
        }

        function TrimString(sInString) {
            sInString = sInString.replace(/^\s+/g, "");// strip leading
            return sInString.replace(/\s+$/g, "");// strip trailing
        }

        function ValidateSubmit() {
            var strAlert;

            var txtFName;
            var txtLName;
            var cmbGender;
            var txtSSN;
            var cmbSalStatus;
            var txtHireDate;

            var blnFoundPrimary;
            var j;
            var strItem;
            var strItemValues;
            var lstJobCode;

            blnFoundPrimary = false;
            lstJobCode = document.getElementById("lstJobCode");

            if (lstJobCode.length == 0) {
                alert('Atleast one Department is required .. Please check it out');
                return false;
            }

            for (var j = 0; j <= lstJobCode.options.length - 1; j++) {
                strItem = lstJobCode.options(j).text;
                strItemValues = strItem.split('|');

                if (strItemValues.length == 3)
                    blnFoundPrimary = true;
            }

            if (!blnFoundPrimary) {
                alert('Primary Department is required .. Please check it out');
                return false;
            }

            txtFName = document.getElementById("txtFName");
            txtLName = document.getElementById("txtLName");
            cmbGender = document.getElementById("cmbGender");
            txtSSN = document.getElementById("txtSSN");
            cmbSalStatus = document.getElementById("cmbSalaryStatus");
            txtHireDate = document.getElementById("txtHireDate");

            if (isBlank(txtFName.value) || isBlank(txtLName.value) ||
				isBlank(cmbGender.options(cmbGender.selectedIndex).text) ||
				isBlank(txtSSN.value) ||
				isBlank(cmbSalStatus.options(cmbSalStatus.selectedIndex).text) ||
				isBlank(txtHireDate.value)) {
                strAlert = 'Following are required fields .. Please check it out' +
							'\n' + '\n' +
							'First Name' + '\n' + 'Last Name' +
							'\n' + 'Gender' + '\n' + 'SSN' +
							'\n' + 'Salary Status' +
							'\n' + 'Hire Date';

                alert(strAlert);
                return false;
            }

            if (!CheckDateEff(txtHireDate.value)) {
                alert('Invalid Hire Date .. Please check it out');
                return false;
            }

            if (frmQHire.txtSecCode.value == 8) {
                var cmbStore;
                cmbStore = document.getElementById("cmbStore");

                if (isBlank(cmbStore.options(cmbStore.selectedIndex).text)) {
                    strAlert = 'Following is a required field .. Please check it out' +
                                '\n' + '\n' + 'Employee Unit';

                    alert(strAlert);
                    return false;
                }
            }

            if (confirm('Submit Request ?' + '\n' + '\n' + 'If you click OK, DO NOT close this window until you see message'))
                return true;
            else
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

            if (DateEff > d1 || DateEff < d2)
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

		</script>
    <style type="text/css">
        .auto-style1
        {
            width: 86px;
            height: 10px;
        }
        .auto-style2
        {
            width: 162px;
            height: 10px;
        }
        .auto-style3
        {
            width: 75px;
            height: 10px;
        }
        .auto-style4
        {
            width: 132px;
            height: 10px;
        }
        .auto-style5
        {
            width: 78px;
            height: 10px;
        }
        .auto-style6
        {
            height: 10px;
        }
    </style>
</head>
<body bgColor="#FFF">
		<form id="frmQHire" method="post" runat="server">
			<TABLE id="Table1" style="Z-INDEX: 101; LEFT: 8px; WIDTH: 649px; POSITION: absolute; TOP: 8px; HEIGHT: 80px; Design_Time_Lock: True"
				cellSpacing="0" cellPadding="0" width="649" border="0" Design_Time_Lock="True">
				<TR>
					<TD style="HEIGHT: 3px" align="center"><FONT face="Monotype Corsiva"><STRONG id="STRONG1"><FONT face="Monotype Corsiva" color="#006699" size="5"><STRONG>Employee 
										Quick Hire</STRONG></FONT></STRONG></FONT></TD>
				</TR>
				<TR>
					<TD style="HEIGHT: 30px">
						<HR width="100%" color="#006699" SIZE="2">
						<TABLE id="tblStore" cellSpacing="0" cellPadding="2" width="100%" border="0" runat="server">
							<TR>
								<TD style="WIDTH: 85px" align="left"><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG>Employee 
													Unit </STRONG></FONT></STRONG></FONT>
								</TD>
								<TD><asp:dropdownlist id="cmbStore" runat="server" CssClass="form-control" BackColor="#E7E6E6" Width="138px"></asp:dropdownlist></TD>   <%--PapayaWhip--%>
							</TR>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD style="HEIGHT: 5px">
						<TABLE id="Table4" style="WIDTH: 648px; HEIGHT: 32px" cellSpacing="0" cellPadding="2" width="648"
							border="0">
							<TR>
								<TD style="WIDTH: 86px"><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG>First 
													Name</STRONG></FONT></STRONG></FONT></TD>
								<TD style="WIDTH: 162px"><asp:textbox id="txtFName" runat="server" CssClass="form-control" BackColor="#E7E6E6" Width="136px"></asp:textbox></TD>  <%-- PapayaWhip--%>
								<TD style="WIDTH: 75px"><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG>Middle&nbsp;Name</STRONG></FONT></STRONG></FONT></STRONG></FONT></TD>
								<TD style="WIDTH: 132px"><asp:textbox id="txtMName" runat="server" CssClass="form-control" Width="104px"></asp:textbox></TD>
								<TD style="WIDTH: 78px"><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG>Last&nbsp;Name</STRONG></FONT></STRONG></FONT></TD>
								<TD><asp:textbox id="txtLName" runat="server" CssClass="form-control" BackColor="#E7E6E6" Width="96px"></asp:textbox></TD>     <%--PapayaWhip--%>
							</TR>
                           <tr style="height:5px;"><td></td></tr>
							<TR>
								<TD class="auto-style1"><FONT face="MS Sans Serif" size="1"><STRONG>Nick Name</STRONG></FONT></TD>
								<TD class="auto-style2"><asp:textbox id="txtDispName" CssClass="form-control" runat="server" Width="136px"></asp:textbox></TD>
								<TD class="auto-style3"><FONT face="MS Sans Serif" size="1"><STRONG>Hire Date</STRONG></FONT></TD>
								<TD class="auto-style4"><asp:textbox id="txtHireDate" runat="server" CssClass="form-control" BackColor="#E7E6E6" Width="104px" Preset="shortdate"></asp:textbox></TD>    <%--PapayaWhip--%>
								<TD class="auto-style5"><FONT face="MS Sans Serif" size="1"><STRONG>Gender</STRONG></FONT></TD>
								<TD class="auto-style6"><asp:dropdownlist id="cmbGender" runat="server" CssClass="form-control" BackColor="#E7E6E6" Width="98px"></asp:dropdownlist></TD>  <%-- PapayaWhip--%>
							</TR>
                            <tr style="height:5px;"><td></td></tr>
							<TR>
								<TD style="WIDTH: 86px"><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG>Salary 
															Status</STRONG></FONT></STRONG></FONT></STRONG></FONT></TD>
								<TD style="WIDTH: 162px"><asp:dropdownlist id="cmbSalaryStatus" runat="server" CssClass="form-control" BackColor="#E7E6E6" Width="138px"></asp:dropdownlist></TD>   <%-- PapayaWhip--%>
								<TD style="WIDTH: 75px"><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG>SSN</STRONG></FONT></STRONG></FONT></STRONG></FONT></TD>
								<TD style="WIDTH: 132px"><asp:textbox id="txtSSN" runat="server" BackColor="#E7E6E6" Width="104px" CssClass="form-control" Preset="ssn"></asp:textbox></TD>   <%--PapayaWhip--%>
								<TD style="WIDTH: 78px"><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG><asp:checkbox id="chkSSNOk" runat="server" Font-Size="XX-Small" Font-Names="Microsoft Sans Serif"
																		 Font-Bold="True"></asp:checkbox><asp:Label ID="Label1" runat="server" Text="SS # OK"></asp:Label></STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></FONT></TD>
								<%--<TD></TD>--%>
							</TR>
							<TR>
								<TD style="WIDTH: 70px" colSpan="6"><FONT size="1">&nbsp;</FONT></TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD align="center">
						<TABLE id="Table25" style="WIDTH: 650px; HEIGHT: 110px" borderColor="#006699" cellSpacing="0"
							cellPadding="0" width="650" border="2">
							<TR>
								<TD style="WIDTH: 325px;" valign="top">
									<TABLE id="Table26" style="WIDTH: 302px; HEIGHT: 57px" cellSpacing="0" cellPadding="0"
										width="302" border="0">
										<TR>
											<TD style="HEIGHT: 21px" align="center" bgColor="#006699"><asp:label id="lblDepartment" runat="server" BackColor="#006699" Font-Size="XX-Small"
													Font-Names="Microsoft Sans Serif" Font-Bold="True" ForeColor="White"> Employee's Departments - Pay Rates</asp:label></TD>
										</TR>
										<TR>
											<TD style="HEIGHT: 16px" align="center"><FONT face="MS Sans Serif" color="black" size="1">Department&nbsp; 
													| &nbsp;Pay Rate ($)&nbsp; |&nbsp; Primary</FONT></TD>
										</TR>
										<TR>
											<TD align="center"><%--<mb:dynamiclistbox id="lstJobCode" runat="server" BackColor="PapayaWhip" Width="288px" Height="67px"
													Font-Size="XX-Small" Font-Names="Verdana"></mb:dynamiclistbox>--%>
                                                <asp:ListBox ID="lstJobCode" runat="server" BackColor="#E7E6E6" Width="288px" Height="67px" Font-Size="XX-Small" Font-Names="Verdana" ></asp:ListBox>   <%--BackColor:PapayaWhip--%>
                                                 

											</TD>
										</TR>
                                        
										<TR>
											<TD style="HEIGHT: 27px" align="left"><FONT face="Verdana" size="1">&nbsp; * 
													Modified&nbsp;&nbsp;&nbsp;&nbsp; </FONT><INPUT id="cmdRemoveJobCode" onclick="AddRemoveJobCode(1);" type="button" value="Remove Department" name="cmdRemoveJobCode" class="btn-form"></TD>
										</TR>
                                         <tr style="width:5px;"><td></td></tr>
									</TABLE>
								</TD>
								<TD style="WIDTH: 325px;" vAlign="top">
									<TABLE id="Table27" style="WIDTH: 338px; HEIGHT: 60px" cellSpacing="0" cellPadding="0"
										width="338" border="0">
										<TR>
											<TD style="HEIGHT: 21px;width:305px;" align="center" bgColor="#006699"><FONT face="Microsoft Sans Serif" color="white" size="1"><STRONG>Add&nbsp;Department 
														- Pay Rate</STRONG></FONT></TD>
										</TR>
										<TR>
											<TD style="HEIGHT: 105px">
												<TABLE id="Table28" style="WIDTH: 338px; HEIGHT: 36px" cellSpacing="0" cellPadding="2"
													width="338" border="0">
													<TR>
														<TD style="WIDTH: 82px; HEIGHT: 5px"><FONT face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG>&nbsp; 
																							Department</STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></FONT></TD>
														<TD style="HEIGHT: 5px"><asp:dropdownlist id="cmbJobCode" CssClass="form-control" runat="server" Width="240px"></asp:dropdownlist></TD>
													</TR>
                                                    <tr style="height:5px;"></tr>
													<TR>
														<TD style="WIDTH: 82px; HEIGHT: 4px"><FONT face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG>&nbsp; 
																							Pay Rate ($)</STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></FONT></TD>
														<TD style="HEIGHT: 4px"><asp:textbox id="txtPayRate" runat="server" Width="136px" CssClass="form-control" Preset="currency"></asp:textbox></TD>
													</TR>
													<TR>
														<TD style="WIDTH: 82px"><FONT face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG><FONT face="Arial" size="2"><STRONG><FONT face="MS Sans Serif" size="1"><STRONG>&nbsp; 
																							Primary ?</STRONG></FONT></STRONG></FONT></STRONG></FONT></STRONG></FONT></TD>
														<TD><asp:checkbox id="chkPrimary" runat="server"></asp:checkbox></TD>
													</TR>
													<TR>
														<TD style="WIDTH: 82px"></TD>
														<TD>
                                                            <%--<asp:Button ID="cmdAddNewJob" runat="server" Text="<< Add" Width="120px" CssClass="btn-form" OnClientClick="javascript:AddRemoveJobCode(0);"/>--%>
                                                            <INPUT id="cmdAddNewJob" onclick="AddRemoveJobCode(0);" type="button" class="btn-form" value="<< Add" name="cmdAddNewJob"></TD>
													</TR>
                                                    <tr style="width:5px;"><td></td></tr>
												</TABLE>
											</TD>
										</TR>
									</TABLE>
								</TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD style="HEIGHT: 40px" align="center"><asp:button id="cmdSubmit" runat="server" Width="100px" CssClass="btn-form" Text="Submit" Font-Bold="True"></asp:button>
							<INPUT id="cmdExit" onclick="window.close();" type="button" class="btn-form" style="width:100px;" value="Exit" name="cmdExit">&nbsp;
						<asp:textbox id="txtECId" runat="server" Width="35px" Height="14px" Visible="False"></asp:textbox><INPUT id="txtSecCode" style="WIDTH: 23px; HEIGHT: 14px" type="hidden" size="1" name="txtSecCode"
							runat="server">
						<asp:textbox id="txtManClockId" runat="server" Width="24px" Height="16px" Visible="False"></asp:textbox><asp:textbox id="txtStore" runat="server" Width="24px" Height="16px" Visible="False"></asp:textbox><asp:textbox id="txtClockId" runat="server" Width="24px" Height="16px" Visible="False"></asp:textbox></TD>
				</TR>
			</TABLE>
		</form>
	</body>
</html>
