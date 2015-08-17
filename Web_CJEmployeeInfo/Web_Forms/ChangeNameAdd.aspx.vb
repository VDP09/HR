Imports Web_CJEmployeeInfo.Web_CJEmployeeInfo

Public Class ChangeNameAdd
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
        If Not IsPostBack Then
            txtClockId.Text = Request.Item("CId")
            txtId.Text = Request.Item("Id")

            Call LoadEmpDetails()
            Call LoadStates()
            Call LoadNameAdd()

            Call GetManClockId()

            If Val(txtId.Text) > 0 Then
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
    End Sub

    Private Sub LoadEmpDetails()
        Try

            objGeneral = New clsGeneral

            With objGeneral
                .ConnectionString = Application("ConnString")
                .ClockId = txtClockId.Text

                lblEmp.Text = objGeneral.GetEmpDetails
            End With

            objGeneral = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Sub LoadStates()
        Try

            'objData = New clsData

            'objData.ConnectionString = Application("ConnString")

            'If Not objData.GetRset("GetItemList 'State'") Then
            '    'MessageBox.Show(objData.ErrMsg)
            'Else
            '    dsData = objData.RecSet
            'End If

            With cmbState
                .DataSource = Application("State") 'dsData.Tables("DataSet")
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

    Private Sub LoadNameAdd()
        Try

            objData = New clsData
            dsData = New DataSet
            Dim i As DataRow

            objData.ConnectionString = Application("ConnString")

            If Not objData.GetRset("GetEmpDetails " & txtClockId.Text) Then
                Response.Write(objData.ErrMsg)
            Else
                dsData = objData.RecSet
            End If

            For Each i In dsData.Tables("DataSet").Rows()
                txtOldFName.Text = FixNull(i("FName"))
                txtFName.Text() = FixNull(i("FName"))

                txtOldLName.Text = FixNull(i("LName"))
                txtLName.Text = FixNull(i("LName"))

                txtOldMName.Text = FixNull(i("MName"))
                txtMName.Text = FixNull(i("MName"))

                txtOldAdd1.Text = FixNull(i("Address1"))
                txtAdd1.Text = FixNull(i("Address1"))

                txtOldAdd2.Text = FixNull(i("Address2"))
                txtAdd2.Text = FixNull(i("Address2"))

                txtOldCity.Text = FixNull(i("City"))
                txtCity.Text = FixNull(i("City"))

                txtOldState.Text = FixNull(i("State"))
                cmbState.SelectedValue = FixNull(i("StateId"))

                txtOldZip.Text = FixNull(i("Zip"))
                txtZip.Text = FixNull(i("Zip"))

                txtOldHomePh.Text = FixNull(i("HomePh"))
                txtHomePh.Text = FixNull(i("HomePh"))
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

            If Not objData.GetRset("GetRequestDetails 2," & txtId.Text) Then
                Response.Write(objData.ErrMsg)
            Else
                dsData = objData.RecSet
            End If

            For Each i In dsData.Tables("DataSet").Rows()
                txtFName.Text = FixNull(i("FName"))
                txtFName.ToolTip = txtFName.Text

                txtLName.Text = FixNull(i("LName"))
                txtLName.ToolTip = txtLName.Text

                txtMName.Text = FixNull(i("MName"))
                txtMName.ToolTip = txtMName.Text

                txtAdd1.Text = FixNull(i("Add1"))
                txtAdd1.ToolTip = txtAdd1.Text

                txtAdd2.Text = FixNull(i("Add2"))
                txtAdd2.ToolTip = txtAdd2.Text

                txtCity.Text = FixNull(i("City"))
                txtCity.ToolTip = txtCity.Text

                cmbState.SelectedValue = i("State_Id")
                txtHState.Text = cmbState.SelectedValue

                txtZip.Text = FixNull(i("Zip"))
                txtZip.ToolTip = txtZip.Text

                txtHomePh.Text = FixNull(i("Home_Ph"))
                txtHomePh.ToolTip = txtHomePh.Text

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
            Return ""
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

    Private Function UpdateData(ByVal lngClockId As Long) As Boolean
        Try
            Dim intReturnCode As Integer

            objData = New clsData
            objData.ConnectionString = Application("ConnString")

            With objData
                .AppendOutputParm()

                .AppendParameter("@ECId", "Integer", 4, txtId.Text)
                .AppendParameter("@ChangeTypeId", "Integer", 4, 2)
                .AppendParameter("@ClockId", "Integer", 4, txtClockId.Text)
                .AppendParameter("@ChangeReason", "Char", 1000, txtChangeReason.Text)
                .AppendParameter("@EffDate", "Date", 4, txtEffDate.Text)
                .AppendParameter("@FName", "Char", 50, GetValue(txtFName.Text, "String"))
                .AppendParameter("@MName", "Char", 50, GetValue(txtMName.Text, "String"))
                .AppendParameter("@LName", "Char", 50, GetValue(txtLName.Text, "String"))
                .AppendParameter("@Add1", "Char", 100, GetValue(txtAdd1.Text, "String"))
                .AppendParameter("@Add2", "Char", 100, GetValue(txtAdd2.Text, "String"))
                .AppendParameter("@City", "Char", 100, GetValue(txtCity.Text, "String"))
                .AppendParameter("@StateId", "Integer", 4, cmbState.SelectedValue)
                .AppendParameter("@Zip", "Char", 10, Trim(txtZip.Text))

                .AppendParameter("@Gender", "Char", 1, "")
                .AppendParameter("@SSN", "Char", 10, "")
                .AppendParameter("@JobTitleId", "Integer", 4, 0)
                .AppendParameter("@Unit", "Integer", 4, 0)
                .AppendParameter("@WorkPh", "Char", 10, "")
                .AppendParameter("@WorkExt", "Char", 5, "")
                .AppendParameter("@CellPh", "Char", 10, "")
                .AppendParameter("@HomePh", "Char", 10, GetValue(txtHomePh.Text, "Phone"))

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

                .AppendParameter("@FedMaritalStatusId", "Integer", 4, 0)
                .AppendParameter("@StateMaritalStatusId", "Integer", 4, 0)
                '.AppendParameter("@ClaimSingle", "Bit", 1, 0)
                .AppendParameter("@FedDed", "Currency", 4, 0)
                .AppendParameter("@StateDed", "Currency", 4, 0)
                .AppendParameter("@FedExempNo", "Integer", 4, 0)
                .AppendParameter("@StateExempNo", "Integer", 4, 0)
                .AppendParameter("@FedClaimExempt", "Bit", 1, 0)
                .AppendParameter("@StateClaimExempt", "Bit", 1, 0)
                .AppendParameter("@A4Ded", "Currency", 4, 0)
                .AppendParameter("@W4Notes", "Char", 1000, "")

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
                    Call DisplayStatus("There is similar request pending for this employee | You can not make another request until the existing gets posted | Please check Name/Add Changes report to get more details", True)
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
            Return False
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
                    'Don't apply formating while posting. This will eliminage
                    'multiple upper case characters in string problem
                    If txtId.Text > 0 Then
                        Return Trim(DBValue)
                    Else
                        Return StrConv(Trim(DBValue), VbStrConv.ProperCase)
                    End If
                End If
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
            Return ""
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

    Private Sub UpdateADSFields()
        Try
            Dim objADS As clsADS

            objADS = New clsADS

            With objADS
                .UserLogin = ""
                .UserClockId = txtClockId.Text

                If Not .LoadUser Then
                    Call DisplayStatus("UpdateAdSFields : " & objADS.ErrMsg, True)
                    Exit Sub
                End If

                .AddAttribute("GivenName", txtFName.Text)
                .AddAttribute("sn", txtLName.Text)
                .AddAttribute("StreedAddress", txtAdd1.Text & ", " & txtAdd2.Text)
                .AddAttribute("l", txtCity.Text)
                .AddAttribute("st", cmbState.SelectedItem.Text)
                .AddAttribute("PostalCode", txtZip.Text)

                'If Trim(txtWorkExt.Text) <> "" Then
                '    .AddAttribute("telephonenumber", txtWorkPh.Text & " x" & txtWorkExt.Text)
                'Else
                '    .AddAttribute("telephonenumber", txtWorkPh.Text)
                'End If

                '.AddAttribute("mobile", txtCellPh.Text)

                If Not .SaveAttributes() Then
                    Call DisplayStatus("UpdateADSFields : " & objADS.ErrMsg, True)
                End If

            End With
            objADS = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Function IsPageDirty() As Boolean
        Try
            If Trim(txtFName.Text) <> Trim(txtFName.ToolTip) Or _
                Trim(txtLName.Text) <> Trim(txtLName.ToolTip) Or _
                Trim(txtMName.Text) <> Trim(txtMName.ToolTip) Or _
                Trim(txtAdd1.Text) <> Trim(txtAdd1.ToolTip) Or _
                Trim(txtAdd2.Text) <> Trim(txtAdd2.ToolTip) Or _
                Trim(txtCity.Text) <> Trim(txtCity.ToolTip) Or _
                cmbState.SelectedValue <> txtHState.Text Or _
                Trim(txtZip.Text) <> Trim(txtZip.ToolTip) Or _
                Trim(txtHomePh.Text) <> Trim(txtHomePh.ToolTip) Or _
                Trim(txtEffDate.Text) <> Trim(txtEffDate.ToolTip) Or _
                Trim(txtChangeReason.Text) <> Trim(txtChangeReason.ToolTip) Then

                IsPageDirty = True
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
            Return False
        End Try
    End Function

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
            Return False
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

                .EmailSubject = "Name/Add Change - Review Again"
                strBody = "Your request for Name/Add change has been sent back to you, please read notes below and take appropriate action."

                strBody = strBody & vbCrLf & vbCrLf _
                        & "Clock Id      : " & txtClockId.Text & vbCrLf _
                        & "Employee Name : " & txtFName.Text & " " & txtLName.Text & vbCrLf _
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

            'Save ADS Groups
            'If CheckADSAccount() Then
            '    Call UpdateADSFields()
            'End If

            objData = New clsData
            objData.ConnectionString = Application("ConnString")

            With objData
                .AppendOutputParm()
                .AppendParameter("@ECId", "Integer", 4, txtId.Text)
                .AppendParameter("@ChangeTypeId", "Integer", 4, 2)
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
                Else
                    Call DisplayStatus("Request has been posted successfully", False)
                End If
            End If

            objData = Nothing

            Dim strScript As String
            strScript = "<SCRIPT>window.opener.document.forms(0).txtLoadForm.value = 1; window.opener.document.forms(0).submit(1); self.close();</SCRIPT>"
            Page.RegisterClientScriptBlock("CloseMeSubmit", strScript)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Protected Sub cmdReview_Click(sender As Object, e As EventArgs) Handles cmdReview.Click
        Try
            objData = New clsData
            objData.ConnectionString = Application("ConnString")

            With objData
                .AppendOutputParm()
                .AppendParameter("@ECId", "Integer", 4, txtId.Text)
            End With

            If Not objData.ExecuteCommand("SendForReview") Then
                Call DisplayStatus(objData.ErrMsg, True)
            Else
                Call DisplayStatus("Request has been sent for review successfully", False)
            End If

            objData = Nothing
            Call DisplayResultPage()
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub
End Class