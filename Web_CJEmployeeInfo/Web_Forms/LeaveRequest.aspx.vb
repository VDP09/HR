Imports Web_CJEmployeeInfo.Web_CJEmployeeInfo
Public Class LeaveRequest
    Inherits System.Web.UI.Page

    Dim objData As clsData
    Dim dsData As DataSet

    Dim strError As String
    Dim strStatus As String
#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub


    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Not Page.IsPostBack Then
                txtClockId.Value = Request.Item("ClockId")
                txtLRId.Value = Request.Item("LRId")
                txtManClockId.Value = Request.Item("MId")
                txtHR.Value = Request.Item("HR")
                txtUnit.Value = Request.Item("Unit")
                txtPosted.Value = Request.Item("Posted")

                'Leave Emp Types
                ' 1 - MO Salary
                ' 2 - Store Salary
                ' 3 - MO Hourly
                ' 4 - OAs
                ' 5 - AKMs
                txtEmpType.Value = Request.Item("ET")

                Call LoadLeaveTypes()

                'txtLRId.Value = 0
                'txtLRDId.Value = 0
                'txtClockId.Value = 0
                'txtManClockId.Value = 15863
                'txtHR.Value = 1

                'MO Salary
                If txtEmpType.Value = 1 Then
                    lblDaysOff.Text = "Weekend/Holiday Days"
                    'txtDaysOff.Enabled = False
                    cmdTotalTime.Value = "Calculate Total Days Except Weekend/Holiday"

                    'Store Salary
                ElseIf txtEmpType.Value = 2 Then
                    cmdTotalTime.Value = "Calculate Total Days Except Days Off"

                ElseIf txtEmpType.Value = 3 Or txtEmpType.Value = 4 Then    'MO Hourly, OA
                    lblTR.Text = "Time Requested (Hrs)"
                    lblTR1.Text = "  Leave Time (Hrs)"
                    lblDaysOff.Text = "Weekend/Holiday Hours"
                    'txtDaysOff.Enabled = False
                    cmdTotalTime.Value = "Calculate Total Hours Except Weekend/Holiday"

                ElseIf txtEmpType.Value = 5 Then    'AKMs
                    lblTR.Text = "Time Requested (Hrs)"
                    lblTR1.Text = "  Leave Time (Hrs)"

                    lblDaysOff.Text = "Enter your # of Non-Vacation Hours Off in the range"
                    'txtDaysOff.Enabled = False
                    cmdTotalTime.Value = "Calculate Total Hours Except Non-Vacation Hours"
                End If

                If Request.Item("LRId") > 0 Then
                    If Request.Item("Posted") = 2 Then
                        lblHead.Text = "Update Leave Request"
                    Else
                        lblHead.Text = "Process Leave Request"
                    End If

                    cmdDeny.Visible = True
                    cmdApprove.Visible = True
                    cmdSubmit.Visible = False
                    'Call LoadEmpVacationSickInfo()

                    'Load request data
                    Call LoadData()
                Else
                    cmdDeny.Visible = False
                    cmdApprove.Visible = False
                    cmdSubmit.Visible = True
                End If

                If txtLRId.Value > 0 Or txtHR.Value > 0 Then
                    cmdLeaveHist1.Visible = True
                Else
                    cmdLeaveHist1.Visible = False
                End If

                If txtClockId.Value = 0 Then
                    tblEmp.Visible = True
                    lblTitle.Visible = False
                    Call LoadManEmployee()
                Else
                    tblEmp.Visible = False
                    Call LoadEmpVacationSickInfo()
                End If

                If txtHR.Value = 1 Then
                    tblHR.Visible = True
                    cmdApprove.Visible = False
                    cmdDeny.Visible = False
                    If txtLRId.Value > 0 Then
                        cmdSubmit.Visible = True
                        cmdSubmit.Text = "Post"

                        cmdDeny.Visible = True
                        cmdApprove.Visible = True
                        cmdApprove.Text = "Undo Approval"

                        If Request.Item("St") = 0 Then
                            cmdApprove.Enabled = False
                            cmdSubmit.Text = "Approve & Post"
                        End If

                        If Request.Item("Posted") = 2 Then
                            'cmdApprove.Enabled = False
                            'cmdDeny.Enabled = False
                            cmdSubmit.Text = "Update"
                        End If
                    End If
                Else
                    tblHR.Visible = False
                    tblUndoApproval.Visible = False
                End If


                txtSDate.Attributes.Add("onfocus", "getCalendarFor(this,163,100,1);")
                txtEDate.Attributes.Add("onfocus", "getCalendarFor(this,163,125,1);")

                cmdApprove.Attributes.Add("onclick", "if(ValidateApprove()){return true} else {return false};")
                cmdSubmit.Attributes.Add("onclick", "if(ValidateSubmit()){return true} else {return false};")
                cmdDeny.Attributes.Add("onclick", "if(confirm('Deny Request ? It is not recoverable .. Proceed ?')){return true;} else {return false;}")
                cmdLeaveHist1.Attributes.Add("onclick", "ViewLeaveHist1();")
                txtActualHrs.Attributes.Add("onChange", "DisplayDays();")
                txtDaysOff.Attributes.Add("onChange", "DisplayDays();")

                txtVacationHrs.Attributes.Add("onChange", "DisplayDays();")
                txtSickHrs.Attributes.Add("onChange", "DisplayDays();")
                txtUnPaidHrs.Attributes.Add("onChange", "DisplayDays();")

                txtFMLAHrs.Attributes.Add("onChange", "DisplayDays();")
                txtDay30Hrs.Attributes.Add("onChange", "DisplayDays();")
                txtDay60Hrs.Attributes.Add("onChange", "DisplayDays();")
                txtPregHrs.Attributes.Add("onChange", "DisplayDays();")
                txtWorkCompHrs.Attributes.Add("onChange", "DisplayDays();")

                txtFMLAEDate.Attributes.Add("onChange", "DisplayFMLA();")
                txtFMLASDate.Attributes.Add("onChange", "DisplayFMLA();")
                txtDay30SDate.Attributes.Add("onChange", "DisplayDay30();")
                txtDay30EDate.Attributes.Add("onChange", "DisplayDay30();")
                txtDay60SDate.Attributes.Add("onChange", "DisplayDay60();")
                txtDay60EDate.Attributes.Add("onChange", "DisplayDay60();")
                txtPregSDate.Attributes.Add("onChange", "DisplayPreg();")
                txtPregEDate.Attributes.Add("onChange", "DisplayPreg();")
                txtWorkCompSDate.Attributes.Add("onChange", "DisplayWorkComp();")
                txtWorkCompEDate.Attributes.Add("onChange", "DisplayWorkComp();")

                cmbEmp.Attributes.Add("onchange", "SelectEmp();")
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub
    Private Sub LoadManEmployee()
        Try
            objData = New clsData
            Dim i As DataRow
            Dim j As Integer

            objData.ConnectionString = Application("ConnString")

            If Not objData.GetRset("GetManEmpList " & txtManClockId.Value) Then
                'MessageBox.Show(objData.ErrMsg)
            Else
                dsData = objData.RecSet
            End If

            cmbEmp.Items.Insert(0, New ListItem("", "0"))
            j = 1
            For Each i In dsData.Tables("DataSet").Rows
                With cmbEmp
                    .Items.Insert(j, New ListItem(i(2) & "  |  " & i(3), i(5)))
                End With
                j = j + 1
            Next

            objData = Nothing
            dsData = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Sub LoadEmpVacationSickInfo()
        Try
            objData = New clsData
            Dim i As DataRow
            Dim strTitle As String
            Dim strTitle1 As String

            objData.ConnectionString = Application("ConnString")

            If Not objData.GetRset("GetReportEmpVacationSick " & txtClockId.Value) Then
                'MessageBox.Show(objData.ErrMsg)
            Else
                dsData = objData.RecSet
            End If

            For Each i In dsData.Tables("DataSet").Rows()

                'MO salary, Store Salary
                If txtEmpType.Value = 1 Or txtEmpType.Value = 2 Then
                    strTitle = i("ClockId") & " - " & i("EmpName") _
                                & "  |  " & i("JobDesc") _
                                & "  |  Last Hire Date : " & i("DateHire") _
                                & "  |  Benefit Date : " & i("DateBenefit")

                    strTitle1 = "Vacation Left : " & i("DaysLeft") & " Days" _
                                & "  |  Sick Left : " & i("SickDaysLeft") & " Days"

                Else    'MO Hourly, AKMs, OAs
                    strTitle = i("ClockId") & " - " & i("EmpName") _
                                & "  |  " & i("JobDesc") _
                                & "  |  Last Hire Date : " & i("DateHire") _
                                & "  |  Benefit Date : " & i("DateBenefit")

                    strTitle1 = "Vacation Left : " & i("HrsLeft") & " Hrs"

                    If txtEmpType.Value <> 4 Then
                        strTitle1 = strTitle1 & "  |  Sick Left : " & i("SickHrsLeft") & " Hrs"
                    End If
                End If

                lblTitle.Text = strTitle
                lblTitle1.Text = strTitle1
            Next

            dsData = Nothing
            objData = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Sub LoadData()
        Try
            Dim blnDays As Boolean

            objData = New clsData

            objData.ConnectionString = Application("ConnString")

            If Not objData.GetRset("GetLeaveRequestDetails " & txtLRId.Value) Then
                'MessageBox.Show(objData.ErrMsg)
            Else
                dsData = objData.RecSet
            End If

            If txtEmpType.Value = 1 Or txtEmpType.Value = 2 Then
                blnDays = True
            End If

            Dim i As DataRow
            For Each i In dsData.Tables("DataSet").Rows

                cmbEmp.SelectedValue = i("ClockId")
                txtClockId.Value = i("ClockId")
                txtSDate.Text = i("Start_Date")
                txtEDate.Text = i("End_Date")

                If blnDays Then
                    txtActualHrs.Text = FixNull(i("Total_Days"))
                    If txtEmpType.Value <> 4 Then
                        lblADays.Text = FixNull(i("Total_Time")) & " Hrs"
                    End If
                Else
                    txtActualHrs.Text = FixNull(i("Total_Time"))
                    lblADays.Text = FixNull(i("Total_Days")) & " Days"
                End If

                txtTotalHrs.Value = FixNull(i("DateDiff"))

                If blnDays Then
                    txtDaysOff.Text = FixNull(i("Total_WEndsDays"))
                    If txtEmpType.Value <> 4 Then
                        lblDaysOff1.Text = FixNull(i("Total_WEnds")) & " Hrs"
                    End If
                Else
                    txtDaysOff.Text = FixNull(i("Total_WEnds"))
                    lblDaysOff1.Text = FixNull(i("Total_WEndsDays")) & " Days"
                End If

                chkIntFMLA.Checked = i("int_FMLA")
                txtComments.Text = FixNull(i("Notes"))

                txtLRDId.Value = i("LRD_Id")

                If i("VSubType_Id") > 0 Then
                    cmbVacation.SelectedValue = i("VSubType_Id")
                End If

                If blnDays Then
                    txtVacationHrs.Text = FixNull(i("V_Days"))
                    If txtEmpType.Value <> 4 Then
                        lblVDays.Text = FixNull(i("V_Hrs")) & " Hrs"
                    End If
                Else
                    txtVacationHrs.Text = FixNull(i("V_Hrs"))
                    lblVDays.Text = FixNull(i("V_Days")) & " Days"
                End If

                If i("SSubType_Id") > 0 Then
                    cmbSick.SelectedValue = i("SSubType_Id")
                End If

                If blnDays Then
                    txtSickHrs.Text = FixNull(i("S_Days"))
                    If txtEmpType.Value <> 4 Then
                        lblSDays.Text = FixNull(i("S_Hrs")) & " Hrs"
                    End If
                Else
                    txtSickHrs.Text = FixNull(i("S_Hrs"))
                    lblSDays.Text = FixNull(i("S_Days")) & " Days"
                End If

                If i("USubType_Id") > 0 Then
                    cmbUnPaid.SelectedValue = i("USubType_Id")
                End If

                If blnDays Then
                    txtUnPaidHrs.Text = FixNull(i("U_Days"))
                    If txtEmpType.Value <> 4 Then
                        lblUDays.Text = FixNull(i("U_Hrs")) & " Hrs"
                    End If
                Else
                    txtUnPaidHrs.Text = FixNull(i("U_Hrs"))
                    lblUDays.Text = FixNull(i("U_Days")) & " Days"
                End If

                If txtHR.Value > 0 Then
                    chkFMLA.Checked = i("Flag_FMLA")

                    txtFMLAHrs.Text = FixNull(i("FMLA_Hrs"))
                    If txtFMLAHrs.Text > 0 Then
                        lblFDays.Text = FixNull(i("FMLA_Days")) & " Days"
                    End If

                    txtFMLASDate.Text = FixNull(i("FMLA_SDate"))
                    txtFMLAEDate.Text = FixNull(i("FMLA_EDate"))

                    chk30Day.Checked = i("Flag_30Day")
                    txtDay30Hrs.Text = FixNull(i("Day30_Hrs"))
                    If txtDay30Hrs.Text > 0 Then
                        lbl30Days.Text = FixNull(i("Day30_Days")) & " Days"
                    End If
                    txtDay30SDate.Text = FixNull(i("Day30_SDate"))
                    txtDay30EDate.Text = FixNull(i("Day30_EDate"))

                    chk60Day.Checked = i("Flag_60Day")
                    txtDay60Hrs.Text = FixNull(i("Day60_Hrs"))
                    If txtDay60Hrs.Text > 0 Then
                        lbl60Days.Text = FixNull(i("Day60_Days")) & " Days"
                    End If
                    txtDay60SDate.Text = FixNull(i("Day60_SDate"))
                    txtDay60EDate.Text = FixNull(i("Day60_EDate"))

                    chkPregnancy.Checked = i("Flag_Pregnancy")
                    txtPregHrs.Text = FixNull(i("Preg_Hrs"))
                    If txtPregHrs.Text > 0 Then
                        lblPDays.Text = FixNull(i("Preg_Days")) & " Days"
                    End If
                    txtPregSDate.Text = FixNull(i("Preg_SDate"))
                    txtPregEDate.Text = FixNull(i("Preg_EDate"))

                    chkWorkComp.Checked = i("Flag_WorkComp")
                    txtWorkCompHrs.Text = FixNull(i("WorkComp_Hrs"))
                    If txtWorkCompHrs.Text > 0 Then
                        lblWDays.Text = FixNull(i("WorkComp_Days")) & " Days"
                    End If

                    txtWorkCompSDate.Text = FixNull(i("WorkComp_SDate"))
                    txtWorkCompEDate.Text = FixNull(i("WorkComp_EDate"))

                End If
            Next

            'Don't allow to change employee
            cmbEmp.Enabled = False

            objData = Nothing
            dsData = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Function FixNull(ByVal dbvalue) As String
        Try
            If dbvalue Is DBNull.Value Then
                Return ""
            Else
                Return dbvalue.ToString
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Function

    Private Sub LoadLeaveTypes()
        Try
            objData = New clsData
            Dim i As DataRow
            Dim intVacation As Integer
            Dim intSick As Integer
            Dim intUnpaid As Integer

            objData.ConnectionString = Application("ConnString")

            If Not objData.GetRset("GetLeaveSubTypeList") Then
                'MessageBox.Show(objData.ErrMsg)
            Else
                dsData = objData.RecSet
            End If

            intVacation = 0
            intSick = 0
            intUnpaid = 0

            cmbVacation.Items.Insert(0, New ListItem("", "0"))
            cmbSick.Items.Insert(0, New ListItem("", "0"))
            cmbUnPaid.Items.Insert(0, New ListItem("", "0"))

            For Each i In dsData.Tables("DataSet").Rows
                If i("LeaveType") = "Vacation" Then
                    cmbVacation.Items.Insert(intVacation + 1, New ListItem(i("LeaveSubType"), i("Id")))
                    intVacation = intVacation + 1
                End If
                If i("LeaveType") = "Sick" Then
                    cmbSick.Items.Insert(intSick + 1, New ListItem(i("LeaveSubType"), i("Id")))
                    intSick = intSick + 1
                End If

                If i("LeaveType") = "Unpaid" Then
                    cmbUnPaid.Items.Insert(intUnpaid + 1, New ListItem(i("LeaveSubType"), i("Id")))
                    intUnpaid = intUnpaid + 1
                End If
            Next

            objData = Nothing
            dsData = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Sub cmdSubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdSubmit.Click
        Try
            Dim strScript As String

            If cmdSubmit.Text = "Submit" Then   'Update Data
                If Not UpdateData() Then
                    Call DisplayResultPage()
                Else
                    'Send email only if employee is submitting request
                    'If txtManClockId.Value <= 0 And txtHR.Value <= 0 Then
                    Call SendEMail()
                    'End If
                End If

                strScript = "<SCRIPT>window.opener.document.forms(0).submit(); self.close();</SCRIPT>"
                Page.RegisterClientScriptBlock("CloseMeSubmit", strScript)

            ElseIf cmdSubmit.Text = "Update" Then    'Update Data
                If Not UpdateData() Then
                    Call DisplayResultPage()
                End If

                strScript = "<SCRIPT>window.opener.document.forms(0).txtLoadForm.value = 1; window.opener.document.forms(0).submit(); self.close();</SCRIPT>"
                Page.RegisterClientScriptBlock("CloseMeSubmit", strScript)

            Else    'Post data
                If UpdateData() Then
                    If Not PostRequest() Then
                        Call DisplayResultPage()
                    End If
                Else
                    Call DisplayResultPage()
                End If

                strScript = "<SCRIPT>window.opener.document.forms(0).txtLoadForm.value = 1; window.opener.document.forms(0).submit(1); self.close();</SCRIPT>"
                Page.RegisterClientScriptBlock("CloseMeSubmit", strScript)
            End If

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Function PostRequest() As Boolean
        Try
            objData = New clsData
            objData.ConnectionString = Application("ConnString")

            With objData
                .AppendOutputParm()
                .AppendParameter("@LRId", "Integer", 4, txtLRId.Value)
                .AppendParameter("@ClockId", "Integer", 4, txtManClockId.Value)
            End With

            If Not objData.ExecuteCommand("PostLeaveRequest") Then
                Call DisplayStatus(objData.ErrMsg, True)
                PostRequest = False
            Else
                'Call SendEmail(3, chkReHire.Checked)
                Call DisplayStatus("Leave Request has been posted successfully", False)
                PostRequest = True
            End If

            objData = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Function

    Private Sub DisplayStatus(ByVal strMessage As String, ByVal blnError As Boolean)
        Try

            'lblStatus.Text = strMessage

            If blnError Then
                'lblStatus.ForeColor = Color.Red
                If strError <> "" Then
                    strError = strError & " | " & Replace(strMessage, vbCrLf, "-")
                Else
                    strError = Replace(strMessage, vbCrLf, "-")
                End If
            Else
                If strStatus <> "" Then
                    strStatus = strStatus & " | " & strMessage
                Else
                    strStatus = strMessage
                End If

                'lblStatus.ForeColor = Color.Green
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Sub DisplayResultPage()
        Try
            Dim strURL As String

            If strError <> "" Then
                strURL = "E=1&EM=" & strError & "&M=" & strStatus
            Else
                strURL = "E=0&EM=" & strError & "&M=" & strStatus
            End If

            Response.Redirect("Result.aspx?" & strURL)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Function UpdateData() As Boolean
        Try

            Dim objData As clsData
            Dim blnDays As Boolean

            objData = New clsData
            objData.ConnectionString = Application("ConnString")

            'Populate ClockId field if it is 0 (Manager creating request for employee)
            'If txtClockId.Value = 0 Then
            '    txtClockId.Value = cmbEmp.SelectedValue
            'End If

            'If txtEmpType.Value = 1 Or txtEmpType.Value = 2 Or _
            '    txtEmpType.Value = 4 Then
            If txtEmpType.Value = 1 Or txtEmpType.Value = 2 Then
                blnDays = True
            End If

            With objData
                .AppendOutputParm()
                .AppendParameter("@LRId", "Integer", 4, txtLRId.Value)
                .AppendParameter("@ClockId", "Integer", 4, txtClockId.Value)
                .AppendParameter("@EmpType", "Integer", 4, txtEmpType.Value)
                .AppendParameter("@SDate", "Date", 8, txtSDate.Text)
                .AppendParameter("@EDate", "Date", 8, txtEDate.Text)

                If blnDays Then
                    .AppendParameter("@TotalTime", "Decimal", 4, txtActualHrs.Text * 8)

                    If txtDaysOff.Text = "" Then
                        .AppendParameter("@TotalWEnds", "Decimal", 4, 0)
                    Else
                        .AppendParameter("@TotalWEnds", "Decimal", 4, txtDaysOff.Text * 8)
                    End If

                Else
                    .AppendParameter("@TotalTime", "Decimal", 4, txtActualHrs.Text)

                    If txtDaysOff.Text = "" Then
                        .AppendParameter("@TotalWEnds", "Decimal", 4, 0)
                    Else
                        .AppendParameter("@TotalWEnds", "Decimal", 4, txtDaysOff.Text)
                    End If
                End If

                .AppendParameter("@FlagIntFMLA", "Bit", 1, chkIntFMLA.Checked)

                If txtManClockId.Value = 0 Then
                    .AppendParameter("@CreatedBy", "Integer", 4, txtClockId.Value)
                Else
                    .AppendParameter("@CreatedBy", "Integer", 4, txtManClockId.Value)
                End If

                .AppendParameter("@Notes", "Char", 5000, txtComments.Text)

                .AppendParameter("@LRDId", "Integer", 4, txtLRDId.Value)
                .AppendParameter("@VSubTypeId", "Integer", 4, cmbVacation.SelectedValue)

                If blnDays Then
                    .AppendParameter("@VHrs", "Decimal", 4, IIf(txtVacationHrs.Text = "", 0, txtVacationHrs.Text * 8))
                Else
                    .AppendParameter("@VHrs", "Decimal", 4, IIf(txtVacationHrs.Text = "", 0, txtVacationHrs.Text))
                End If

                .AppendParameter("@SSubTypeId", "Integer", 4, cmbSick.SelectedValue)

                If blnDays Then
                    .AppendParameter("@SHrs", "Decimal", 4, IIf(txtSickHrs.Text = "", 0, txtSickHrs.Text * 8))
                Else
                    .AppendParameter("@SHrs", "Decimal", 4, IIf(txtSickHrs.Text = "", 0, txtSickHrs.Text))
                End If

                .AppendParameter("@USubTypeId", "Integer", 4, cmbUnPaid.SelectedValue)

                If blnDays Then
                    .AppendParameter("@UHrs", "Decimal", 4, IIf(txtUnPaidHrs.Text = "", 0, txtUnPaidHrs.Text * 8))
                Else
                    .AppendParameter("@UHrs", "Decimal", 4, IIf(txtUnPaidHrs.Text = "", 0, txtUnPaidHrs.Text))
                End If

                .AppendParameter("@FlagFMLA", "Integer", 4, chkFMLA.Checked)
                .AppendParameter("@FMLAHrs", "Decimal", 4, IIf(txtFMLAHrs.Text = "", 0, txtFMLAHrs.Text))
                .AppendParameter("@FMLASDate", "Date", 8, IIf(txtFMLASDate.Text = "", DBNull.Value, txtFMLASDate.Text))
                .AppendParameter("@FMLAEDate", "Date", 8, IIf(txtFMLAEDate.Text = "", DBNull.Value, txtFMLAEDate.Text))

                .AppendParameter("@Flag30Day", "Integer", 4, chk30Day.Checked)
                .AppendParameter("@Day30Hrs", "Decimal", 4, IIf(txtDay30Hrs.Text = "", 0, txtDay30Hrs.Text))
                .AppendParameter("@Day30SDate", "Date", 8, IIf(txtDay30SDate.Text = "", DBNull.Value, txtDay30SDate.Text))
                .AppendParameter("@Day30EDate", "Date", 8, IIf(txtDay30EDate.Text = "", DBNull.Value, txtDay30EDate.Text))

                .AppendParameter("@Flag60Day", "Integer", 4, chk60Day.Checked)
                .AppendParameter("@Day60Hrs", "Decimal", 4, IIf(txtDay60Hrs.Text = "", 0, txtDay60Hrs.Text))
                .AppendParameter("@Day60SDate", "Date", 8, IIf(txtDay60SDate.Text = "", DBNull.Value, txtDay60SDate.Text))
                .AppendParameter("@Day60EDate", "Date", 8, IIf(txtDay60EDate.Text = "", DBNull.Value, txtDay60EDate.Text))

                .AppendParameter("@FlagPregnancy", "Integer", 4, chkPregnancy.Checked)
                .AppendParameter("@PregHrs", "Decimal", 4, IIf(txtPregHrs.Text = "", 0, txtPregHrs.Text))
                .AppendParameter("@PregSDate", "Date", 8, IIf(txtPregSDate.Text = "", DBNull.Value, txtPregSDate.Text))
                .AppendParameter("@PregEDate", "Date", 8, IIf(txtPregEDate.Text = "", DBNull.Value, txtPregEDate.Text))

                .AppendParameter("@FlagWorkComp", "Integer", 4, chkWorkComp.Checked)
                .AppendParameter("@WorkCompHrs", "Decimal", 4, IIf(txtWorkCompHrs.Text = "", 0, txtWorkCompHrs.Text))
                .AppendParameter("@WorkCompSDate", "Date", 8, IIf(txtWorkCompSDate.Text = "", DBNull.Value, txtWorkCompSDate.Text))
                .AppendParameter("@WorkCompEDate", "Date", 8, IIf(txtWorkCompEDate.Text = "", DBNull.Value, txtWorkCompEDate.Text))
            End With

            If Not objData.ExecuteCommand("UpdateLeaveRequest") Then
                Call DisplayStatus(objData.ErrMsg, True)
                UpdateData = False
            Else
                If objData.ReturnCode = -1 Then
                    Call DisplayStatus("Leave Request overlaps other request, please check Leave History report", True)
                    UpdateData = False
                Else
                    If txtLRId.Value = "0" Then
                        'Call SendMail()
                        Call DisplayStatus("Leave Request has been submitted successfully", False)
                    Else
                        Call DisplayStatus("Leave Request has been updated successfully", False)
                    End If

                    UpdateData = True
                End If
            End If

            lblStatus.Text = strStatus
            objData = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Function

    Private Sub cmdDelete_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        Try
            Dim objData As clsData
            Dim strStatus As String

            objData = New clsData
            objData.ConnectionString = Application("ConnString")

            With objData
                .AppendOutputParm()
                '.AppendParameter("@RId", "Integer", 4, txtRId.Text)
            End With

            If Not objData.ExecuteCommand("RemoveLeaveRequest") Then
                strStatus = objData.ErrMsg
            Else
                If objData.ReturnCode = -1 Then
                    strStatus = "Can not remove request .. It has been in process"
                Else
                    strStatus = "Request has been deleted successfully"
                End If
            End If

            lblStatus.Text = strStatus

            'Reset page
            txtSDate.Text = ""
            txtEDate.Text = ""
            txtActualHrs.Text = ""

            objData = Nothing

            Dim strScript As String
            strScript = "<SCRIPT>window.opener.document.forms(0).submit(); self.close();</SCRIPT>"
            Page.RegisterClientScriptBlock("CloseMeDelete", strScript)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Sub SendEMail()
        Try

            'Get Email addresses
            objData = New clsData
            Dim i As DataRow
            Dim strEmpName As String
            Dim strEmpEmail As String
            Dim strManEmail As String
            Dim strLeaveType As String
            Dim strTotalTime As String
            Dim objGeneral As clsGeneral

            objData.ConnectionString = Application("ConnString")

            If Not objData.GetRset("GetManEmailAddress " & txtClockId.Value) Then
                'MessageBox.Show(objData.ErrMsg)
            Else
                dsData = objData.RecSet
            End If

            For Each i In dsData.Tables("DataSet").Rows
                strEmpName = FixNull(i(0))
                strEmpEmail = FixNull(i(1))
                strManEmail = FixNull(i(2))
            Next

            objData = Nothing
            dsData = Nothing


            If strEmpEmail <> "" And strManEmail <> "" Then
                strLeaveType = GetLeaveTypes()

                If txtEmpType.Value = 3 Then
                    strTotalTime = (((txtActualHrs.Text + 0) + (txtDaysOff.Text + 0)) / 8) & " Days"
                ElseIf txtEmpType.Value = 4 Then
                    strTotalTime = ((txtActualHrs.Text + 0) + (txtDaysOff.Text + 0)) & " Hrs"
                ElseIf txtEmpType.Value = 5 Then
                    strTotalTime = (((txtActualHrs.Text + 0) + (txtDaysOff.Text + 0)) / 8) & " Days"
                Else
                    strTotalTime = ((txtActualHrs.Text + 0) + (txtDaysOff.Text + 0)) & " Days"
                End If

                'Send email
                objGeneral = New clsGeneral
                With objGeneral
                    .EmailTo = strManEmail
                    .EmailFrom = strEmpName & "(" & strEmpEmail & ")"
                    .EmailSubject = "Leave Request"
                    If txtManClockId.Value > 0 Or txtHR.Value > 0 Then
                        .EmailBody = "I just submitted a new Leave Request for following employee ... " & vbCrLf & vbCrLf _
                            & "Employee   : " & txtClockId.Value & " - " & cmbEmp.SelectedItem.Text & vbCrLf _
                            & "For Dates  : " & txtSDate.Text & " - " & txtEDate.Text & vbCrLf _
                            & "Total Days : " & strTotalTime & vbCrLf _
                            & "Leave Type : " & strLeaveType & vbCrLf _
                            & "Comments   : " & txtComments.Text & vbCrLf & vbCrLf & vbCrLf _
                            & "This email is generated automatically through HR Express based on certain action."
                    Else
                        .EmailBody = "I just submitted a new Leave Request as follows ... " & vbCrLf & vbCrLf _
                            & "ClockId    : " & txtClockId.Value & vbCrLf _
                            & "For Dates  : " & txtSDate.Text & " - " & txtEDate.Text & vbCrLf _
                            & "Total Days : " & strTotalTime & vbCrLf _
                            & "Leave Type : " & strLeaveType & vbCrLf _
                            & "Comments   : " & txtComments.Text & vbCrLf & vbCrLf & vbCrLf _
                            & "This email is generated automatically through HR Express based on certain action."
                    End If

                    .SendEMail()
                End With
            End If

            objGeneral = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Function GetLeaveTypes() As String
        Try
            Dim strLT As String
            Dim dblVac As Double
            Dim dblSick As Double
            Dim dblUnPaid As Double

            dblVac = txtVacationHrs.Text
            dblSick = txtSickHrs.Text
            dblUnPaid = txtUnPaidHrs.Text

            If txtEmpType.Value = 5 Then
                dblVac = dblVac / 8
                dblSick = dblSick / 8
                dblUnPaid = dblUnPaid / 8

            ElseIf txtEmpType.Value = 3 Then
                dblVac = dblVac / 8
                dblSick = dblSick / 8
                dblUnPaid = dblUnPaid / 8
            End If

            If dblVac > 0 Then
                strLT = "Vacation (" & (dblVac)

                'For OAs
                If txtEmpType.Value = 4 Then
                    strLT = strLT & " Hrs)"
                Else
                    strLT = strLT & ")"
                End If
            End If

            If dblSick > 0 Then
                If strLT = "" Then
                    strLT = "Sick (" & (dblSick)
                Else
                    strLT = strLT & " / " & "Sick (" & (dblSick)
                End If

                'For OAs
                If txtEmpType.Value = 4 Then
                    strLT = strLT & " Hrs)"
                Else
                    strLT = strLT & ")"
                End If
            End If

            If dblUnPaid > 0 Then
                If strLT = "" Then
                    strLT = "UnPaid (" & (dblUnPaid)
                Else
                    strLT = strLT & " / " & "UnPaid (" & (dblUnPaid)
                End If

                'For OAs
                If txtEmpType.Value = 4 Then
                    strLT = strLT & " Hrs)"
                Else
                    strLT = strLT & ")"
                End If
            End If

            GetLeaveTypes = strLT
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Function

    Private Sub SendEMailDenial()
        Try

            'Get Email addresses
            objData = New clsData
            Dim i As DataRow
            Dim strManName As String
            Dim strManEmail As String
            Dim strEmpEmail As String
            Dim strLeaveType As String
            Dim objGeneral As clsGeneral

            objData.ConnectionString = Application("ConnString")

            If Not objData.GetRset("GetEmailForLeaveDenial " & txtClockId.Value & "," & txtManClockId.Value) Then
                'MessageBox.Show(objData.ErrMsg)
            Else
                dsData = objData.RecSet
            End If

            For Each i In dsData.Tables("DataSet").Rows
                strManName = i(0)
                strManEmail = i(1)
                strEmpEmail = i(2)
            Next

            objData = Nothing
            dsData = Nothing

            If strEmpEmail <> "" And strManEmail <> "" Then
                'Send email
                strLeaveType = GetLeaveTypes()

                objGeneral = New clsGeneral
                With objGeneral
                    .EmailTo = strEmpEmail
                    .EmailFrom = strManName & "(" & strManEmail & ")"
                    .EmailSubject = "Leave Request Denial"
                    .EmailBody = "Your following Leave request is denied ..." & vbCrLf & vbCrLf _
                                & "Leave Type : " & strLeaveType & vbCrLf _
                                & "For Dates  : " & txtSDate.Text & " - " & txtEDate.Text & vbCrLf _
                                & "Comments   : " & txtComments.Text & vbCrLf & vbCrLf & vbCrLf _
                                & "This email is generated automatically through HR Express based on certain action."

                    .SendEMail(1)
                End With
            End If

            objGeneral = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Public Function GetTotalBDays() As String
        Try
            Return "return false;"
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Function

    Private Sub cmdApprove_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdApprove.Click
        Try
            Dim objData As clsData
            Dim strStatus As String

            'Save any changes made at the time of approval
            If cmdApprove.Text = "Approve" Then
                If UpdateData() Then
                    objData = New clsData
                    objData.ConnectionString = Application("ConnString")

                    With objData
                        .AppendOutputParm()
                        .AppendParameter("@LRId", "Integer", 4, txtLRId.Value)
                        .AppendParameter("@AppStatus", "Integer", 4, 1)
                        .AppendParameter("@ManClockId", "Integer", 4, txtManClockId.Value)
                        .AppendParameter("@Comments", "Char", 5000, txtComments.Text)
                    End With

                    If Not objData.ExecuteCommand("UpdateLeaveRequestApproval") Then
                        Call DisplayStatus(objData.ErrMsg, True)
                        Call DisplayResultPage()
                    Else
                        'ProcessLeaveRequest = True
                    End If

                    objData = Nothing

                    Dim strScript As String
                    strScript = "<SCRIPT>window.opener.document.forms(0).submit(); self.close();</SCRIPT>"
                    Page.RegisterClientScriptBlock("CloseMeApprove", strScript)
                Else
                    Call DisplayResultPage()
                End If

            Else    'Undo Approval for HR
                If Not UpdateUndoManApproval() Then
                    Call DisplayResultPage()
                    Exit Sub
                Else
                    'Send an email back to Manager
                    Call SendUndoManApprovalEmail()
                End If
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Sub SendUndoManApprovalEmail()
        Try
            Dim i As DataRow
            Dim strHRManName As String
            Dim strHRManEmail As String
            Dim strEmailList As String
            Dim strBody As String
            Dim objGeneral As clsGeneral
            Dim strEmpName As String
            Dim strLeaveType As String

            objData = New clsData

            'Get Email addresses
            objData.ConnectionString = Application("ConnString")

            If Not objData.GetRset("GetEmailsForUndoManLeaveApproval " & txtManClockId.Value & "," & txtLRId.Value) Then
                'MessageBox.Show(objData.ErrMsg)
                Exit Sub
            Else
                dsData = objData.RecSet
            End If

            For Each i In dsData.Tables("DataSet").Rows
                strHRManName = FixNull(i(0))
                strHRManEmail = FixNull(i(1))
                strEmailList = FixNull(i(2))
                strEmpName = FixNull(i(3))
            Next

            objData = Nothing
            dsData = Nothing

            If Trim(strHRManEmail) = "" Or Trim(strEmailList) = "" Then
                Exit Sub
            End If

            'Get leave types
            strLeaveType = GetLeaveTypes()

            'Send email
            objGeneral = New clsGeneral
            With objGeneral
                .EmailTo = strEmailList
                .EmailFrom = strHRManName & "(" & strHRManEmail & ")"

                strBody = "Your following approved Leave Request has been sent back to you, please read notes below and approve/deny request again."

                strBody = strBody & vbCrLf & vbCrLf _
                        & "Clock Id      : " & txtClockId.Value & vbCrLf _
                        & "Employee Name : " & strEmpName & vbCrLf _
                        & "Leave Type    : " & strLeaveType & vbCrLf _
                        & "For Dates     : " & txtSDate.Text & " - " & txtEDate.Text & vbCrLf _
                        & "Notes         : " & txtUndoNotes.Text _
                        & vbCrLf & vbCrLf & vbCrLf _
                        & "This email is generated automatically through HR Express based on certain action."

                .EmailBody = strBody
                .SendEMail(1)
            End With

            objGeneral = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Function UpdateUndoManApproval() As Boolean
        Try
            objData = New clsData
            objData.ConnectionString = Application("ConnString")

            With objData
                .AppendOutputParm()
                .AppendParameter("@LRId", "Integer", 4, txtLRId.Value)
            End With

            If Not objData.ExecuteCommand("UpdateUndoManLeaveApproval") Then
                Call DisplayStatus(objData.ErrMsg, True)
                UpdateUndoManApproval = False
            Else
                UpdateUndoManApproval = True
            End If

            objData = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Function

    Private Sub cmdDeny_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdDeny.Click
        Try
            Dim objData As clsData
            Dim strStatus As String

            objData = New clsData
            objData.ConnectionString = Application("ConnString")

            With objData
                .AppendOutputParm()
                .AppendParameter("@LRId", "Integer", 4, txtLRId.Value)
                .AppendParameter("@AppStatus", "Integer", 4, 2)
                .AppendParameter("@ManClockId", "Integer", 4, txtManClockId.Value)
                .AppendParameter("@Comments", "Char", 5000, txtComments.Text)
            End With

            If Not objData.ExecuteCommand("UpdateLeaveRequestApproval") Then
                strStatus = objData.ErrMsg
                'ProcessLeaveRequest = False
            Else
                'ProcessLeaveRequest = True
                'send denial email
                Call SendEMailDenial()
            End If

            objData = Nothing

            Dim strScript As String
            strScript = "<SCRIPT>window.opener.document.forms(0).txtLoadForm.value = 1; window.opener.document.forms(0).submit(1); self.close();</SCRIPT>"
            Page.RegisterClientScriptBlock("CloseMeSubmit", strScript)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub
End Class