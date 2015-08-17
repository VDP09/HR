Imports System.Drawing
Imports Web_CJEmployeeInfo.Web_CJEmployeeInfo

Public Class UpdateEditPunch
    Inherits System.Web.UI.Page

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
            Dim objData As clsData
            Dim intBCount As Integer
            Dim i As Integer
            Dim intReturnCode As Integer

            Dim blnInvalidInserted As Boolean

            cmdBack.Visible = False
            intBCount = Request.Form("txtBCount") - 1

            'Check if Punch Details are modified
            If Request.Form("cmbPunchReason") <> "" Or _
                Request.Form("txtDecTips") <> Request.Form("txtHDecTips") Or _
                Request.Form("cmbJobCode") <> Request.Form("txtHJobCode") Or _
                Request.Form("txtSales") <> Request.Form("txtHSales") Or _
                Request.Form("txtUpdateType") = "New" Then

                objData = New clsData
                objData.ConnectionString = Application("ConnString")    'Application("MSConnStr")

                With objData
                    .AppendOutputParm()
                    Dim clockid As Integer = Request.Form("txtClockId")
                    .AppendParameter("@ClockId", "Integer", 4, Request.Form("txtClockId"))
                    Dim dob As Date = Request.Form("txtDOB")
                    .AppendParameter("@DOB", "Date", 8, Request.Form("txtDOB"))
                    Dim unit As Integer = Request.Form("txtUnit")
                    .AppendParameter("@Unit", "Integer", 4, Request.Form("txtUnit"))
                    Dim shiftid As Integer = Request.Form("txtShift")
                    .AppendParameter("@ShiftId", "Integer", 4, Request.Form("txtShift"))
                    Dim timein As String = GetTimeFormat(Request.Form("txtHPunchIN"), Request.Form("txtMPunchIN"))
                    .AppendParameter("@TimeIN", "Char", 5, GetTimeFormat(Request.Form("txtHPunchIN"), Request.Form("txtMPunchIN")))
                    Dim timeout As String = GetTimeFormat(Request.Form("txtHPunchOUT"), Request.Form("txtMPunchOUT"))
                    .AppendParameter("@TimeOUT", "Char", 5, GetTimeFormat(Request.Form("txtHPunchOUT"), Request.Form("txtMPunchOUT")))
                    Dim oldtimein As String = GetTimeFormat(Request.Form("txtHHPunchIN"), Request.Form("txtHHPunchIN"))
                    .AppendParameter("@OLDTimeIN", "Char", 5, GetTimeFormat(Request.Form("txtHHPunchIN"), Request.Form("txtHMPunchIN")))
                    Dim oldtimeout As String = GetTimeFormat(Request.Form("txtHHPunchOUT"), Request.Form("txtHMPunchOUT"))
                    .AppendParameter("@OLDTimeOUT", "Char", 5, GetTimeFormat(Request.Form("txtHHPunchOUT"), Request.Form("txtHMPunchOUT")))
                    .AppendParameter("@RType", "Char", 1, "A")

                    If Request.Form("txtUpdateType") = "New" Then
                        .AppendParameter("@ReasonId", "Integer", 4, 0)
                    ElseIf Request.Form("cmbPunchReason") <> "" Then
                        .AppendParameter("@ReasonId", "Integer", 4, Request.Form("cmbPunchReason"))
                    Else
                        .AppendParameter("@ReasonId", "Integer", 4, Request.Form("cmbDeptReason"))
                    End If

                    .AppendParameter("@AppendInValid", "Bit", 1, 1)
                    .AppendParameter("@BreakId", "Integer", 4, 0)
                    .AppendParameter("@ManLogin", "Char", 50, Request.Form("txtManClockId"))
                    .AppendParameter("@DecTips", "Currency", 8, Request.Form("txtDecTips"))
                    .AppendParameter("@Sales", "Currency", 8, Request.Form("txtSales"))
                    .AppendParameter("@UpdateType", "Char", 10, Request.Form("txtUpdateType"))
                    .AppendParameter("@JobCode", "Integer", 4, Request.Form("cmbJobCode"))
                    .AppendParameter("@BPaid", "Char", 1, "")
                End With

                If Not objData.ExecuteCommand("UpdateEditPunches1") Then
                    lblUpdateStatus.Text = objData.ErrMsg
                    Exit Sub
                Else
                    intReturnCode = objData.ReturnCode

                    If intReturnCode = -1 Then  'Time overlaps with other shift
                        lblUpdateStatus.ForeColor = Color.Red
                        lblUpdateStatus.Text = "Punch Time range you entered, overlaps with another shift .. Please check it out"
                        cmdBack.Visible = True

                        Exit Sub
                    End If
                End If

                blnInvalidInserted = True
                objData = Nothing
            End If

            For i = 1 To intBCount
                If Request.Form("cmbBReason" & i) <> "" Or _
                    Request.Form("txtUpdateType") = "New" Then

                    objData = New clsData
                    objData.ConnectionString = Application("ConnString")    'Application("MSConnStr")

                    With objData
                        .AppendOutputParm()
                        .AppendParameter("@ClockId", "Integer", 4, Request.Form("txtClockId"))
                        .AppendParameter("@DOB", "Date", 8, Request.Form("txtDOB"))
                        .AppendParameter("@Unit", "Integer", 4, Request.Form("txtUnit"))
                        .AppendParameter("@ShiftId", "Integer", 4, Request.Form("txtShift"))
                        .AppendParameter("@TimeIN", "Char", 5, GetTimeFormat(Request.Form("txtHBIN" & i), Request.Form("txtMBIN" & i)))
                        .AppendParameter("@TimeOUT", "Char", 5, GetTimeFormat(Request.Form("txtHBOUT" & i), Request.Form("txtMBOUT" & i)))

                        If i <= Request.Form("txtOBCount") Then 'Original breaks
                            .AppendParameter("@OLDTimeIN", "Char", 5, GetTimeFormat(Request.Form("txtHHBIN" & i), Request.Form("txtHMBIN" & i)))
                            .AppendParameter("@OLDTimeOUT", "Char", 5, GetTimeFormat(Request.Form("txtHHBOUT" & i), Request.Form("txtHMBOUT" & i)))
                        Else    'New added breaks
                            .AppendParameter("@OLDTimeIN", "Char", 5, "0:0")
                            .AppendParameter("@OLDTimeOUT", "Char", 5, "0:0")
                        End If

                        .AppendParameter("@RType", "Char", 1, "B")
                        .AppendParameter("@ReasonId", "Integer", 4, Request.Form("cmbBReason" & i))

                        If Not blnInvalidInserted Then
                            .AppendParameter("@AppendInValid", "Bit", 1, 1)
                            blnInvalidInserted = True
                        Else
                            .AppendParameter("@AppendInValid", "Bit", 1, 0)
                        End If

                        .AppendParameter("@BreakId", "Integer", 4, i)
                        .AppendParameter("@ManLogin", "Char", 50, Request.Form("txtManClockId"))
                        .AppendParameter("@DecTips", "Currency", 8, Request.Form("txtDecTips"))
                        .AppendParameter("@Sales", "Currency", 8, Request.Form("txtSales"))
                        .AppendParameter("@UpdateType", "Char", 10, Request.Form("txtUpdateType"))
                        .AppendParameter("@JobCode", "Integer", 4, Request.Form("cmbJobCode"))
                        .AppendParameter("@BPaid", "Char", 1, Request.Form("cmbBPaid" & i).Substring(0, 1))
                    End With

                    If Not objData.ExecuteCommand("UpdateEditPunches1") Then
                        lblUpdateStatus.Text = objData.ErrMsg
                        Exit Sub
                    End If

                    objData = Nothing

                End If
            Next

            'Update break waivers
            objData = New clsData
            objData.ConnectionString = Application("ConnString")    'Application("MSConnStr")

            With objData
                .AppendOutputParm()
                .AppendParameter("@ClockId", "Integer", 4, Request.Form("txtClockId"))
                .AppendParameter("@DOB", "Date", 8, Request.Form("txtDOB"))
                .AppendParameter("@Unit", "Integer", 4, Request.Form("txtUnit"))

                If Request.Form("chkWaive") = "on" Then
                    .AppendParameter("@Waive", "Integer", 4, 1)
                Else
                    .AppendParameter("@Waive", "Integer", 4, 0)
                End If

                .AppendParameter("@ManClockId", "Char", 50, Request.Form("txtManClockId"))
            End With

            If Not objData.ExecuteCommand("UpdateAdjustBreakWaiver") Then
                lblUpdateStatus.Text = objData.ErrMsg
                Exit Sub
            End If

            objData = Nothing


            lblUpdateStatus.Text = "Changes have been updated successfully"

            Dim strScript As String
            strScript = "<SCRIPT>window.opener.document.forms(0).txtLoadForm.value = 1; window.opener.document.forms(0).submit(1); self.close();</SCRIPT>"
            Page.RegisterClientScriptBlock("CloseMeSubmit", strScript)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Function GetTimeFormat(ByVal intHour As Integer, ByVal intMin As Integer) As String
        Try

            Dim strHour As String
            Dim strMin As String

            If intHour = 0 And intMin = 0 Then
                GetTimeFormat = "0:0"
            Else

                If intHour < 10 Then
                    strHour = "0" & intHour
                Else
                    strHour = intHour
                End If

                If intMin < 10 Then
                    strMin = "0" & intMin
                Else
                    strMin = intMin
                End If

                GetTimeFormat = strHour & ":" & strMin
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Function

End Class