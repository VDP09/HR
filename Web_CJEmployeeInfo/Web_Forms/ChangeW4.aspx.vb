Imports Web_CJEmployeeInfo.Web_CJEmployeeInfo

Public Class ChangeW4
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
                txtId.Text = Request.Item("Id")

                Call LoadEmpDetails()
                Call LoadMarital()
                Call LoadA4Form()

                Call LoadW4Info()

                Call GetManClockId()

                If txtId.Text > 0 Then
                    Call LoadReqDetails()
                    cmdSubmit.Visible = False
                    cmdPost.Visible = True
                    cmdDelete.Visible = True
                    cmdEmailReq.Visible = True
                    tblUndo.Visible = True
                Else
                    cmdSubmit.Visible = True
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

    Private Sub LoadMarital()
        Try
            'objData = New clsData

            'objData.ConnectionString = Application("ConnString")

            'If Not objData.GetRset("GetItemList 'MaritalStatus'") Then
            '    'MessageBox.Show(objData.ErrMsg)
            'Else
            '    dsData = objData.RecSet
            'End If

            With cmbFedMaritalStatus
                .DataSource = Application("FedMaritalStatus") 'dsData.Tables("DataSet")
                .DataTextField = "Item_Val"
                .DataValueField = "ItemDetail_Id"
                .DataBind()
            End With

            With cmbStateMaritalStatus
                .DataSource = Application("StateMaritalStatus") 'dsData.Tables("DataSet")
                .DataTextField = "Item_Val"
                .DataValueField = "ItemDetail_Id"
                .DataBind()
            End With

            'objData = Nothing
            'dsData = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Sub LoadA4Form()
        Try

            'objData = New clsData

            'objData.ConnectionString = Application("ConnString")

            'If Not objData.GetRset("GetItemList 'A4Ded'") Then
            '    'MessageBox.Show(objData.ErrMsg)
            'Else
            '    dsData = objData.RecSet
            'End If

            With cmbA4
                .DataSource = Application("A4Ded") 'dsData.Tables("DataSet")
                .DataTextField = "Item_Val"
                .DataValueField = "Item_Val"
                .DataBind()
                .Items.Insert(0, New ListItem("", "-1"))
            End With

            'objData = Nothing
            'dsData = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Sub LoadW4Info()
        Try
            objData = New clsData
            dsData = New DataSet
            Dim i As DataRow

            objData.ConnectionString = Application("ConnString")

            If Not objData.GetRset("GetEmpW4I9Details " & txtClockId.Text) Then
                Response.Write(objData.ErrMsg)
            Else
                dsData = objData.RecSet
            End If

            For Each i In dsData.Tables("DataSet").Rows()
                txtOldStateMaritalStatus.Text = FixNull(i("StateMaritalStatus"))
                cmbStateMaritalStatus.SelectedValue = FixNull(i("StateMaritalStatusId"))

                txtOldFedMaritalStatus.Text = FixNull(i("FedMaritalStatus"))
                cmbFedMaritalStatus.SelectedValue = FixNull(i("FedMaritalStatusId"))

                'chkOldClaimSingle.Checked = FixNull(i("ClaimSingle"))
                'chkClaimSingle.Checked = FixNull(i("ClaimSingle"))

                txtOldFedDed.Text = FixNull(i("FedDed"))
                txtFedDed.Text = FixNull(i("FedDed"))

                txtOldStateDed.Text = FixNull(i("StateDed"))
                txtStateDed.Text = FixNull(i("StateDed"))

                txtOldStateExempNo.Text = FixNull(i("StateExempNo"))
                txtStateExempNo.Text = FixNull(i("StateExempNo"))

                txtOldFedExempNo.Text = FixNull(i("FedExempNo"))
                txtFedExempNo.Text = FixNull(i("FedExempNo"))

                chkOldStateClEx.Checked = FixNull(i("StateClaimExempt"))
                chkStateClEx.Checked = FixNull(i("StateClaimExempt"))

                chkOldFedClEx.Checked = FixNull(i("FedClaimExempt"))
                chkFedClEx.Checked = FixNull(i("FedClaimExempt"))

                'txtOldA4.Text = FixNull(i("A4Ded"))
                'cmbA4.SelectedValue = IIf(i("A4Ded") > 0, Format(i("A4Ded"), "00"), "")
                'cmbA4. = CInt(i("A4Ded"))

                If i("A4Ded") Is DBNull.Value Then
                    cmbA4.SelectedValue = -1
                Else
                    If i("A4Ded") = 0 Then
                        cmbA4.SelectedValue = 0
                    Else
                        cmbA4.SelectedValue = CDbl(i("A4Ded"))
                    End If
                End If
                txtOldA4.Text = cmbA4.SelectedItem.Text

                txtOldW4Notes.Text = FixNull(i("W4Notes"))
                txtW4Notes.Text = FixNull(i("W4Notes"))

                txtHomeState.Value = FixNull(i("HomeState"))
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

            objData.ConnectionString = Application("ConnString")

            If Not objData.GetRset("GetRequestDetails 11," & txtId.Text) Then
                Response.Write(objData.ErrMsg)
            Else
                dsData = objData.RecSet
            End If

            For Each i In dsData.Tables("DataSet").Rows()
                cmbStateMaritalStatus.SelectedValue = FixNull(i("StateMaritalStatusId"))
                txtHStateMaritalStatus.Text = cmbStateMaritalStatus.SelectedValue

                cmbFedMaritalStatus.SelectedValue = FixNull(i("FedMaritalStatusId"))
                txtHFedMaritalStatus.Text = cmbFedMaritalStatus.SelectedValue

                'chkClaimSingle.Checked = FixNull(i("ClaimSingle"))
                'chkClaimSingle.ToolTip = chkClaimSingle.Checked

                txtFedDed.Text = FixNull(i("FedDed"))
                txtFedDed.ToolTip = txtFedDed.Text

                txtStateDed.Text = FixNull(i("StateDed"))
                txtStateDed.ToolTip = txtStateDed.Text

                txtStateExempNo.Text = FixNull(i("StateExempNo"))
                txtStateExempNo.ToolTip = txtStateExempNo.Text

                txtFedExempNo.Text = FixNull(i("FedExempNo"))
                txtFedExempNo.ToolTip = txtFedExempNo.Text

                chkStateClEx.Checked = FixNull(i("StateClaimExempt"))
                chkStateClEx.ToolTip = chkStateClEx.Checked

                chkFedClEx.Checked = FixNull(i("FedClaimExempt"))
                chkFedClEx.ToolTip = chkFedClEx.Checked

                If i("A4Ded") Is DBNull.Value Then
                    cmbA4.SelectedValue = -1
                Else
                    If i("A4Ded") = 0 Then
                        cmbA4.SelectedValue = 0
                    Else
                        cmbA4.SelectedValue = CDbl(i("A4Ded"))
                    End If
                End If

                txtHA4.Text = cmbA4.SelectedValue

                txtW4Notes.Text = FixNull(i("W4Notes"))

                txtEffDate.Text = FixNull(i("Eff_Date"))
                txtEffDate.ToolTip = txtEffDate.Text

                txtChangeReason.Text = FixNull(i("Change_Reason"))
                txtChangeReason.ToolTip = txtChangeReason.Text
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

                .AppendParameter("@ECId", "Integer", 4, txtId.Text)
                .AppendParameter("@ChangeTypeId", "Integer", 4, 11)
                .AppendParameter("@ClockId", "Integer", 4, txtClockId.Text)
                .AppendParameter("@ChangeReason", "Char", 1000, txtChangeReason.Text)
                .AppendParameter("@EffDate", "Date", 4, txtEffDate.Text)
                .AppendParameter("@FName", "Char", 50, "")
                .AppendParameter("@MName", "Char", 50, "")
                .AppendParameter("@LName", "Char", 50, "")
                .AppendParameter("@Add1", "Char", 100, "")
                .AppendParameter("@Add2", "Char", 100, "")
                .AppendParameter("@City", "Char", 100, "")
                .AppendParameter("@StateId", "Integer", 4, 0)
                .AppendParameter("@Zip", "Char", 10, "")

                .AppendParameter("@Gender", "Char", 1, "")
                .AppendParameter("@SSN", "Char", 10, "")
                .AppendParameter("@JobTitleId", "Integer", 4, 0)
                .AppendParameter("@Unit", "Integer", 4, 0)
                .AppendParameter("@WorkPh", "Char", 10, "")
                .AppendParameter("@WorkExt", "Char", 5, "")
                .AppendParameter("@CellPh", "Char", 10, "")
                .AppendParameter("@HomePh", "Char", 10, "")

                .AppendParameter("@NeedLogin", "Bit", 1, 0)
                .AppendParameter("@DispName", "Char", 100, "")
                .AppendParameter("@LoginName", "Char", 50, "")
                .AppendParameter("@WorkEmail", "Char", 100, "")
                .AppendParameter("@ManClockId", "Integer", 4, 0)
                .AppendParameter("@JobCode", "Integer", 4, 0)
                .AppendParameter("@PayRate", "Currency", 4, 0)
                .AppendParameter("@DateBen", "Date", 4, DBNull.Value)
                .AppendParameter("@DateBirth", "Date", 4, DBNull.Value)
                .AppendParameter("@DateWPExp", "Date", 4, DBNull.Value)
                .AppendParameter("@HourlyFlag", "Bit", 1, 0)

                .AppendParameter("@LegalName", "Char", 100, "")
                .AppendParameter("@EthnicityId", "Integer", 4, 0)
                .AppendParameter("@EmpRefId", "Integer", 4, 0)
                .AppendParameter("@I9StatusId", "Integer", 4, 0)
                .AppendParameter("@DateExp", "Date", 4, DBNull.Value)
                .AppendParameter("@AlienNo", "Char", 20, "")
                .AppendParameter("@I9Notes", "Char", 1000, "")

                .AppendParameter("@FedMaritalStatusId", "Integer", 4, cmbFedMaritalStatus.SelectedValue)
                .AppendParameter("@StateMaritalStatusId", "Integer", 4, cmbStateMaritalStatus.SelectedValue)
                '.AppendParameter("@ClaimSingle", "Bit", 1, chkClaimSingle.Checked)
                .AppendParameter("@FedDed", "Currency", 4, IIf(Trim(txtFedDed.Text) = "", 0, txtFedDed.Text))
                .AppendParameter("@StateDed", "Currency", 4, IIf(Trim(txtStateDed.Text) = "", 0, txtStateDed.Text))
                .AppendParameter("@FedExempNo", "Integer", 4, txtFedExempNo.Text)
                .AppendParameter("@StateExempNo", "Integer", 4, txtStateExempNo.Text)
                .AppendParameter("@FedClaimExempt", "Bit", 1, chkFedClEx.Checked)
                .AppendParameter("@StateClaimExempt", "Bit", 1, chkStateClEx.Checked)
                .AppendParameter("@A4Ded", "Currency", 4, IIf(cmbA4.SelectedValue = -1, DBNull.Value, cmbA4.SelectedValue))
                .AppendParameter("@W4Notes", "Char", 1000, txtW4Notes.Text)

                .AppendParameter("@TempUnit", "Integer", 4, 0)
                .AppendParameter("@TempSDate", "Date", 4, DBNull.Value)
                .AppendParameter("@TempEDate", "Date", 4, DBNull.Value)
                .AppendParameter("@Notes", "Char", 2000, "")
                .AppendParameter("@EmpSig", "Char", 6000, "")
                .AppendParameter("@EmpId", "Integer", 4, lngClockId)

                .AppendParameter("@SSNOk", "Bit", 1, 0)
                .AppendParameter("@PEmail", "Char", 100, "")

                .AppendParameter("@EducationId", "Integer", 4, 0)
                .AppendParameter("@RecruiterId", "Integer", 4, 0)
                .AppendParameter("@PrevCompany", "char", 200, "")
            End With

            If Not objData.ExecuteCommand("UpdateEmpDemoChanges") Then
                Call DisplayStatus(objData.ErrMsg, True)
                UpdateData = False
            Else
                intReturnCode = objData.ReturnCode

                If intReturnCode = -1 Then  'Request is already made
                    Call DisplayStatus("There is similar request pending for this employee | You can not make another request until the existing gets posted | Please check W4 Changes report to get more details", True)
                    UpdateData = False
                Else
                    If txtId.Text = 0 Then
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
            If IsPageDirty() Then
                If Not UpdateData(txtManClockId.Text) Then
                    Call DisplayResultPage()
                    Exit Sub
                End If
            End If

            objData = New clsData
            objData.ConnectionString = Application("ConnString")

            With objData
                .AppendOutputParm()
                .AppendParameter("@ECId", "Integer", 4, txtId.Text)
                .AppendParameter("@ChangeTypeId", "Integer", 4, 11)
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
        End Try
    End Function

    Private Function IsPageDirty() As Boolean
        Try
            If Trim(cmbFedMaritalStatus.SelectedValue) <> Trim(txtHFedMaritalStatus.Text) Or _
                Trim(cmbStateMaritalStatus.SelectedValue) <> Trim(txtHStateMaritalStatus.Text) Or _
                Trim(txtFedDed.Text) <> Trim(txtFedDed.ToolTip) Or _
                Trim(txtStateDed.Text) <> Trim(txtStateDed.ToolTip) Or _
                Trim(txtFedExempNo.Text) <> Trim(txtFedExempNo.ToolTip) Or _
                Trim(txtStateExempNo.Text) <> Trim(txtStateExempNo.ToolTip) Or _
                chkFedClEx.Checked <> chkFedClEx.ToolTip Or _
                chkStateClEx.Checked <> chkStateClEx.ToolTip Or _
                cmbA4.SelectedValue <> txtHA4.Text Or _
                Trim(txtEffDate.Text) <> Trim(txtEffDate.ToolTip) Or _
                Trim(txtChangeReason.Text) <> Trim(txtChangeReason.ToolTip) Then

                IsPageDirty = True
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Function

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
                .AppendParameter("@ECId", "Integer", 4, txtId.Text)
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
        End Try
    End Function

    Private Function UpdateUndoGMApproval() As Boolean
        Try

            objData = New clsData
            objData.ConnectionString = Application("ConnString")

            With objData
                .AppendOutputParm()
                .AppendParameter("@ECId", "Integer", 4, txtId.Text)
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

            If Not objData.GetRset("GetEmailsForUndoGMApproval " & txtManClockId.Text & "," & txtId.Text) Then
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

                .EmailSubject = "W4 Change - Review Again"
                strBody = "Your request for W4 change has been sent back to you, please read notes below and take appropriate action."

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