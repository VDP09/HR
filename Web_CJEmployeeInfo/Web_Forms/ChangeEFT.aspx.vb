Imports Web_CJEmployeeInfo.Web_CJEmployeeInfo

Public Class ChangeEFT
    Inherits System.Web.UI.Page

    Dim objData As clsData
    Dim dsData As DataSet
    Dim strError As String
    Dim strStatus As String
    Dim objGeneral As clsGeneral

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
                txtClockId.Text = Request.Item("CId")
                txtId.Value = Request.Item("Id")

                Call LoadEmpDetails()
                Call LoadAccountTypes()

                Call LoadEFTInfo()

                Call GetManClockId()

                If txtId.Value > 0 Then
                    Call LoadReqDetails()

                    cmdSubmit.Visible = False
                    cmdPost.Visible = True
                    cmdDelete.Visible = True
                    cmdEmailReq.Visible = True
                    tblUndo.Visible = True
                Else
                    cmdSubmit.Visible = True
                    lblVoidCheck.Visible = True
                    cmdPost.Visible = False
                    cmdDelete.Visible = False
                    cmdEmailReq.Visible = False
                    tblUndo.Visible = False
                End If

                cmdSubmit.Attributes.Add("onclick", "if(ValidateSubmit()){this.value = 'Please Wait'; this.disabled=true; " & GetPostBackEventReference(cmdSubmit).ToString & "} else{return false;}")
                cmdPost.Attributes.Add("onclick", "if(ValidatePost()){this.value = 'Please Wait'; this.disabled=true; " & GetPostBackEventReference(cmdPost).ToString & "} else{return false;}")
                cmdDelete.Attributes.Add("onclick", "if(ValidateDelete()){this.value = 'Please Wait'; this.disabled=true; " & GetPostBackEventReference(cmdDelete).ToString & "} else{return false;}")
                cmdEmailReq.Attributes.Add("onclick", "if(ValidateEmailReq()){this.value = 'Please Wait'; this.disabled=true; " & GetPostBackEventReference(cmdEmailReq).ToString & "} else{return false;}")
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Sub LoadEmpDetails()
        Try
            objGeneral = New clsGeneral

            With objGeneral
                .ConnectionString = Application("ConnString")
                .ClockId = txtClockId.Text

                lblEmp.Text = objGeneral.GetEmpDetails
                txtEmpName.Value = objGeneral.EmpName
            End With

            objGeneral = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Sub LoadAccountTypes()
        Try
            With cmbAT1
                .Items.Insert(0, New ListItem("", ""))
                .Items.Insert(1, New ListItem("Checking", "C"))
                .Items.Insert(2, New ListItem("Saving", "S"))
            End With

            With cmbAT2
                .Items.Insert(0, New ListItem("", ""))
                .Items.Insert(1, New ListItem("Checking", "C"))
                .Items.Insert(2, New ListItem("Saving", "S"))
            End With

            With cmbAT3
                .Items.Insert(0, New ListItem("", ""))
                .Items.Insert(1, New ListItem("Checking", "C"))
                .Items.Insert(2, New ListItem("Saving", "S"))
            End With

            With cmbAT4
                .Items.Insert(0, New ListItem("", ""))
                .Items.Insert(1, New ListItem("Checking", "C"))
                .Items.Insert(2, New ListItem("Saving", "S"))
            End With

            With cmbAT5
                .Items.Insert(0, New ListItem("", ""))
                .Items.Insert(1, New ListItem("Checking", "C"))
                .Items.Insert(2, New ListItem("Saving", "S"))
            End With
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Sub LoadEFTInfo()
        Try
            objData = New clsData
            dsData = New DataSet
            Dim i As DataRow
            Dim j As Integer

            objData.ConnectionString = Application("ConnString")

            If Not objData.GetRset("GetEmpEFTDetails " & txtClockId.Text) Then
                Response.Write(objData.ErrMsg)
            Else
                dsData = objData.RecSet
            End If

            j = 1

            For Each i In dsData.Tables("DataSet").Rows()

                If j = 1 Then
                    txtOAT1.Text = FixNull(i("AcctType"))
                    txtOAN1.Text = FixNull(i("AcctNo"))
                    txtORN1.Text = FixNull(i("RoutNo"))
                    txtOAmt1.Text = FixNull(i("EFTAmount"))

                    If txtId.Value <= 0 Then
                        cmbAT1.SelectedValue = FixNull(i("AcctTypeId"))
                        txtAN1.Text = FixNull(i("AcctNo"))
                        txtRN1.Text = FixNull(i("RoutNo"))
                        txtAmt1.Text = FixNull(i("EFTAmount"))
                    End If
                End If

                If j = 2 Then
                    txtOAT2.Text = FixNull(i("AcctType"))
                    txtOAN2.Text = FixNull(i("AcctNo"))
                    txtORN2.Text = FixNull(i("RoutNo"))
                    txtOAmt2.Text = FixNull(i("EFTAmount"))

                    If txtId.Value <= 0 Then
                        cmbAT2.SelectedValue = FixNull(i("AcctTypeId"))
                        txtAN2.Text = FixNull(i("AcctNo"))
                        txtRN2.Text = FixNull(i("RoutNo"))
                        txtAmt2.Text = FixNull(i("EFTAmount"))
                    End If
                End If

                If j = 3 Then
                    txtOAT3.Text = FixNull(i("AcctType"))
                    txtOAN3.Text = FixNull(i("AcctNo"))
                    txtORN3.Text = FixNull(i("RoutNo"))
                    txtOAmt3.Text = FixNull(i("EFTAmount"))

                    If txtId.Value <= 0 Then
                        cmbAT3.SelectedValue = FixNull(i("AcctTypeId"))
                        txtAN3.Text = FixNull(i("AcctNo"))
                        txtRN3.Text = FixNull(i("RoutNo"))
                        txtAmt3.Text = FixNull(i("EFTAmount"))
                    End If
                End If

                If j = 4 Then
                    txtOAT4.Text = FixNull(i("AcctType"))
                    txtOAN4.Text = FixNull(i("AcctNo"))
                    txtORN4.Text = FixNull(i("RoutNo"))
                    txtOAmt4.Text = FixNull(i("EFTAmount"))

                    If txtId.Value <= 0 Then
                        cmbAT4.SelectedValue = FixNull(i("AcctTypeId"))
                        txtAN4.Text = FixNull(i("AcctNo"))
                        txtRN4.Text = FixNull(i("RoutNo"))
                        txtAmt4.Text = FixNull(i("EFTAmount"))
                    End If
                End If

                If j = 5 Then
                    txtOAT5.Text = FixNull(i("AcctType"))
                    txtOAN5.Text = FixNull(i("AcctNo"))
                    txtORN5.Text = FixNull(i("RoutNo"))
                    txtOAmt5.Text = FixNull(i("EFTAmount"))

                    If txtId.Value <= 0 Then
                        cmbAT5.SelectedValue = FixNull(i("AcctTypeId"))
                        txtAN5.Text = FixNull(i("AcctNo"))
                        txtRN5.Text = FixNull(i("RoutNo"))
                        txtAmt5.Text = FixNull(i("EFTAmount"))
                    End If
                End If

                j = j + 1
            Next

            dsData = Nothing
            objData = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Sub LoadReqDetails()
        Try
            objData = New clsData
            dsData = New DataSet
            Dim i As DataRow
            Dim j As Integer

            objData.ConnectionString = Application("ConnString")

            If Not objData.GetRset("GetRequestDetails 13," & txtId.Value) Then
                Response.Write(objData.ErrMsg)
            Else
                dsData = objData.RecSet
            End If

            j = 1
            For Each i In dsData.Tables("DataSet").Rows()

                If j = 1 And FixNull(i("AcctNo")) <> "" Then
                    txtEFTCId1.Text = FixNull(i("EFTCId"))
                    cmbAT1.SelectedValue = FixNull(i("AcctTypeId"))
                    txtAN1.Text = FixNull(i("AcctNo"))
                    txtRN1.Text = FixNull(i("RoutNo"))
                    txtAmt1.Text = FixNull(i("EFTAmount"))
                End If

                If j = 2 And FixNull(i("AcctNo")) <> "" Then
                    txtEFTCId2.Text = FixNull(i("EFTCId"))
                    cmbAT2.SelectedValue = FixNull(i("AcctTypeId"))
                    txtAN2.Text = FixNull(i("AcctNo"))
                    txtRN2.Text = FixNull(i("RoutNo"))
                    txtAmt2.Text = FixNull(i("EFTAmount"))
                End If

                If j = 3 And FixNull(i("AcctNo")) <> "" Then
                    txtEFTCId3.Text = FixNull(i("EFTCId"))
                    cmbAT3.SelectedValue = FixNull(i("AcctTypeId"))
                    txtAN3.Text = FixNull(i("AcctNo"))
                    txtRN3.Text = FixNull(i("RoutNo"))
                    txtAmt3.Text = FixNull(i("EFTAmount"))
                End If

                If j = 4 And FixNull(i("AcctNo")) <> "" Then
                    txtEFTCId4.Text = FixNull(i("EFTCId"))
                    cmbAT4.SelectedValue = FixNull(i("AcctTypeId"))
                    txtAN4.Text = FixNull(i("AcctNo"))
                    txtRN4.Text = FixNull(i("RoutNo"))
                    txtAmt4.Text = FixNull(i("EFTAmount"))
                End If

                If j = 5 And FixNull(i("AcctNo")) <> "" Then
                    txtEFTCId5.Text = FixNull(i("EFTCId"))
                    cmbAT5.SelectedValue = FixNull(i("AcctTypeId"))
                    txtAN5.Text = FixNull(i("AcctNo"))
                    txtRN5.Text = FixNull(i("RoutNo"))
                    txtAmt5.Text = FixNull(i("EFTAmount"))
                End If

                txtEffDate.Text = FixNull(i("Eff_Date"))
                txtEffDate.ToolTip = txtEffDate.Text

                txtChangeReason.Text = FixNull(i("Change_Reason"))
                txtChangeReason.ToolTip = txtChangeReason.Text

                txtEmpSig.Value = FixNull(i("EmpSig"))

                j = j + 1
            Next

            dsData = Nothing
            objData = Nothing
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
            Return False
        End Try
    End Function

    Protected Sub cmdSubmit_Click(sender As Object, e As EventArgs) Handles cmdSubmit.Click
        Try
            If txtManClockId.Text > 0 Then
                Call UpdateData(txtManClockId.Text)
            Else
                Call DisplayStatus("ClockId not stored in ADS .. Please check it out", True)
            End If

            Call DisplayResultPage()
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Function UpdateData(ByVal lngClockId As Long) As Boolean
        Try
            Dim intReturnCode As Integer

            objData = New clsData
            objData.ConnectionString = Application("ConnString")

            With objData
                .AppendOutputParm()

                .AppendParameter("@ECId", "Integer", 4, txtId.Value)
                .AppendParameter("@ChangeTypeId", "Integer", 4, 13)
                .AppendParameter("@ClockId", "Integer", 4, txtClockId.Text)
                .AppendParameter("@ChangeReason", "Char", 1000, txtChangeReason.Text)
                .AppendParameter("@EffDate", "Date", 4, txtEffDate.Text)

                '.AppendParameter("@EFTCId1", "Integer", 4, txtEFTCId1.Text)
                .AppendParameter("@PriorityId1", "Integer", 4, 1)
                .AppendParameter("@AcctType1", "Char", 5, cmbAT1.SelectedValue)
                .AppendParameter("@AcctNo1", "Char", 50, txtAN1.Text)
                .AppendParameter("@RoutNo1", "Char", 50, txtRN1.Text)
                .AppendParameter("@EFTAmount1", "Currency", 8, IIf(txtAmt1.Text = "", 0, txtAmt1.Text))

                '.AppendParameter("@EFTCId2", "Integer", 4, txtEFTCId2.Text)
                .AppendParameter("@PriorityId2", "Integer", 4, 2)
                .AppendParameter("@AcctType2", "Char", 5, cmbAT2.SelectedValue)
                .AppendParameter("@AcctNo2", "Char", 50, txtAN2.Text)
                .AppendParameter("@RoutNo2", "Char", 50, txtRN2.Text)
                .AppendParameter("@EFTAmount2", "Currency", 8, IIf(txtAmt2.Text = "", 0, txtAmt2.Text))

                '.AppendParameter("@EFTCId3", "Integer", 4, txtEFTCId3.Text)
                .AppendParameter("@PriorityId3", "Integer", 4, 3)
                .AppendParameter("@AcctType3", "Char", 5, cmbAT3.SelectedValue)
                .AppendParameter("@AcctNo3", "Char", 50, txtAN3.Text)
                .AppendParameter("@RoutNo3", "Char", 50, txtRN3.Text)
                .AppendParameter("@EFTAmount3", "Currency", 8, IIf(txtAmt3.Text = "", 0, txtAmt3.Text))

                '.AppendParameter("@EFTCId4", "Integer", 4, txtEFTCId4.Text)
                .AppendParameter("@PriorityId4", "Integer", 4, 4)
                .AppendParameter("@AcctType4", "Char", 5, cmbAT4.SelectedValue)
                .AppendParameter("@AcctNo4", "Char", 50, txtAN4.Text)
                .AppendParameter("@RoutNo4", "Char", 50, txtRN4.Text)
                .AppendParameter("@EFTAmount4", "Currency", 8, IIf(txtAmt4.Text = "", 0, txtAmt4.Text))

                '.AppendParameter("@EFTCId5", "Integer", 4, txtEFTCId5.Text)
                .AppendParameter("@PriorityId5", "Integer", 4, 5)
                .AppendParameter("@AcctType5", "Char", 5, cmbAT5.SelectedValue)
                .AppendParameter("@AcctNo5", "Char", 50, txtAN5.Text)
                .AppendParameter("@RoutNo5", "Char", 50, txtRN5.Text)
                .AppendParameter("@EFTAmount5", "Currency", 8, IIf(txtAmt5.Text = "", 0, txtAmt5.Text))

                .AppendParameter("@EmpId", "Integer", 4, txtManClockId.Text)
                .AppendParameter("@EmpSig", "Char", 6000, txtEmpSig.Value)
                .AppendParameter("@EmpName", "Char", 100, txtEmpName.Value)
            End With

            If Not objData.ExecuteCommand("UpdateEmpEFT") Then
                Call DisplayStatus(objData.ErrMsg, True)
                UpdateData = False
            Else
                intReturnCode = objData.ReturnCode

                If intReturnCode = -1 Then  'Request is already made
                    Call DisplayStatus("There is similar request pending for this employee | You can not make another request until the existing gets posted | Please check Direct Deposit Changes report to get more details", True)
                    UpdateData = False
                Else

                    If txtId.Value = 0 Then
                        Call DisplayStatus("Request has been submitted successfully", False)
                    Else
                        Call DisplayStatus("Request has been updated successfully", False)
                    End If

                    UpdateData = True
                End If
            End If

            objData = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Function

    Private Function GetValue(ByVal DBValue As String, ByVal DBType As String) As Object
        Try
            If Trim(DBValue) = "" Then
                If DBType = "Date" Then
                    Return DBNull.Value
                Else
                    Return ""
                End If
            Else
                If DBType = "Date" Then
                    If IsDate(Trim(DBValue)) Then
                        Return CDate(Trim(DBValue))
                    Else
                        Return DBNull.Value
                    End If
                ElseIf DBType = "Phone" Then
                    Dim strVal As String
                    strVal = Replace(Replace(Replace(Replace(Replace(Replace(DBValue, "(", ""), ")", ""), "/", ""), "\", ""), "-", ""), " ", "")
                    If IsNumeric(strVal) Then
                        Return strVal
                    Else
                        Return ""
                    End If
                Else
                    Return StrConv(Trim(DBValue), VbStrConv.ProperCase)
                End If
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
            Return False
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

    Protected Sub cmdPost_Click(sender As Object, e As EventArgs) Handles cmdPost.Click
        Try
            If txtManClockId.Text <= 0 Then
                Call DisplayStatus("ClockId is not stored in ADS .. Please check it out", True)
                Call DisplayResultPage()
                Exit Sub
            End If

            'Check for any updates
            If Not UpdateData(txtManClockId.Text) Then
                Call DisplayResultPage()
                Exit Sub
            End If

            objData = New clsData
            objData.ConnectionString = Application("ConnString")

            With objData
                .AppendOutputParm()
                .AppendParameter("@ECId", "Integer", 4, txtId.Value)
                .AppendParameter("@ChangeTypeId", "Integer", 4, 13)
                .AppendParameter("@EmpId", "Integer", 4, txtManClockId.Text)
            End With

            If Not objData.ExecuteCommand("PostRequest") Then
                Call DisplayStatus(objData.ErrMsg, True)
                Call DisplayResultPage()
            Else
                If objData.ReturnCode = -1 Then
                    Call DisplayStatus("Request is NOT Posted. There is a pending " _
                        & "request which is created earlier than this request. Post " _
                        & "that request first and then post this request", True)

                    Call DisplayResultPage()
                End If

                'Call DisplayStatus("Request has been posted successfully", False)
            End If

            objData = Nothing

            Dim strScript As String
            strScript = "<SCRIPT>window.opener.document.forms(0).txtLoadForm.value = 1; window.opener.document.forms(0).submit(1); self.close();</SCRIPT>"
            Page.RegisterClientScriptBlock("CloseMeSubmit", strScript)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Function CheckADSAccount() As Boolean
        Try
            Dim objADS As clsADS
            objADS = New clsADS

            With objADS
                .UserLogin = ""
                .UserClockId = txtClockId.Text

                If .LoadUser Then
                    CheckADSAccount = True
                End If
            End With

            objADS = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
            Return False
        End Try
    End Function

    Private Sub GetManClockId()
        Try
            Dim objADS As clsADS
            Dim strClockId As String

            'Get user's login name
            Dim strDomainUser As String = User.Identity.Name.Replace("\", "/")
            strDomainUser = strDomainUser.Substring(strDomainUser.LastIndexOf("/") + 1)

            objADS = New clsADS
            With objADS
                .UserLogin = strDomainUser
                .LoadUser()

                'Get Employee Security
                strClockId = .GetAttribute("employeeid")
            End With

            If Trim(strClockId) <> "" Then
                txtManClockId.Text = strClockId
            Else
                txtManClockId.Text = 0
            End If

            objADS = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Protected Sub cmdDelete_Click(sender As Object, e As EventArgs) Handles cmdDelete.Click
        Try
            If txtManClockId.Text <= 0 Then
                Call DisplayStatus("ClockId not stored in ADS .. Please check it out", True)
                Call DisplayResultPage()
                Exit Sub
            End If

            'Deny (Delete) request, so it will go away from the queue
            If Not UpdateGMApproval(2, txtManClockId.Text) Then
                Call DisplayResultPage()
                Exit Sub
            End If

            'Script to close this window and refresh parent window
            Dim strScript As String
            strScript = "<SCRIPT>window.opener.document.forms(0).txtLoadForm.value = 1; window.opener.document.forms(0).submit(); self.close();</SCRIPT>"
            Page.RegisterClientScriptBlock("CloseMeDeny", strScript)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Function UpdateGMApproval(ByVal intStatus As Integer, ByVal lngClockId As Long) As Boolean
        Try
            objData = New clsData
            objData.ConnectionString = Application("ConnString")

            With objData
                .AppendOutputParm()
                .AppendParameter("@ECId", "Integer", 4, txtId.Value)
                .AppendParameter("@Status", "Integer", 4, intStatus)
                .AppendParameter("@EmpId", "Integer", 4, lngClockId)
            End With

            If Not objData.ExecuteCommand("UpdateGMApproval") Then
                Call DisplayStatus(objData.ErrMsg, True)
                UpdateGMApproval = False
            Else
                UpdateGMApproval = True
            End If

            objData = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
            Return False
        End Try
    End Function

    Private Function UpdateUndoGMApproval() As Boolean
        Try
            objData = New clsData
            objData.ConnectionString = Application("ConnString")

            With objData
                .AppendOutputParm()
                .AppendParameter("@ECId", "Integer", 4, txtId.Value)
            End With

            If Not objData.ExecuteCommand("UpdateUndoGMApproval") Then
                Call DisplayStatus(objData.ErrMsg, True)
                UpdateUndoGMApproval = False
            Else
                UpdateUndoGMApproval = True
            End If

            objData = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
            Return False
        End Try
    End Function

    Private Sub SendUndoGMApprovalEmail()
        Try
            Dim i As DataRow
            Dim strEmpName As String
            Dim strEmpEmail As String
            Dim strEmailList As String
            Dim strBody As String
            Dim objGeneral As clsGeneral

            objData = New clsData

            'Get Email addresses
            objData.ConnectionString = Application("ConnString")

            If Not objData.GetRset("GetEmailsForUndoGMApproval " & txtManClockId.Text & "," & txtId.Value) Then
                'MessageBox.Show(objData.ErrMsg)
                Exit Sub
            Else
                dsData = objData.RecSet
            End If

            For Each i In dsData.Tables("DataSet").Rows
                strEmpName = FixNull(i(0))
                strEmpEmail = FixNull(i(1))
                strEmailList = FixNull(i(2))
            Next

            objData = Nothing
            dsData = Nothing

            If Trim(strEmpEmail) = "" Or Trim(strEmailList) = "" Then
                Exit Sub
            End If

            'Send email
            objGeneral = New clsGeneral
            With objGeneral
                .EmailTo = strEmailList
                .EmailFrom = strEmpName & "(" & strEmpEmail & ")"

                .EmailSubject = "Direct Deposit Change - Review Again"
                strBody = "Your request for Direct Deposit change has been sent back to you, please read notes below and take appropriate action."

                strBody = strBody & vbCrLf & vbCrLf _
                        & "Clock Id      : " & txtClockId.Text & vbCrLf _
                        & "Employee Name : " & txtEmpName.Value & vbCrLf _
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


    Protected Sub cmdEmailReq_Click(sender As Object, e As EventArgs) Handles cmdEmailReq.Click
        Try
            If txtManClockId.Text <= 0 Then
                Call DisplayStatus("ClockId not stored in ADS .. Please check it out", True)
                Call DisplayResultPage()
                Exit Sub
            End If

            'Send an email back to the requester and mark request as sent for review
            'so it displayed in different color
            If Not UpdateUndoGMApproval() Then
                Call DisplayResultPage()
                Exit Sub
            Else
                'Send an email back to the requester
                Call SendUndoGMApprovalEmail()
            End If

            'Script to close this window and refresh parent window
            Dim strScript As String
            strScript = "<SCRIPT>window.opener.document.forms(0).txtLoadForm.value = 1; window.opener.document.forms(0).submit(); self.close();</SCRIPT>"
            Page.RegisterClientScriptBlock("CloseMeDeny", strScript)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub
End Class