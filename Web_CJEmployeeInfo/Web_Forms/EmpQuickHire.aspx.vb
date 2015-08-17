Imports Web_CJEmployeeInfo.Web_CJEmployeeInfo
Imports System.Web.UI.WebControls.ListBox
Imports System.Web.VirtualPathUtility
'Imports System.Web.UI.IPostBackDataHandler
'Imports System.INamingContainer
Public Class EmpQuickHire
    Inherits System.Web.UI.Page
    Dim objData As New clsData
    Dim dsData As New DataSet

    Dim strError As String
    Dim strStatus As String

    Structure JobDepartment
        Dim intJobCode As Integer
        Dim dblPayRate As Double
        Dim blnPrimary As Boolean
        Dim intStatus As Integer
    End Structure

    Dim objJD() As JobDepartment

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

                txtStore.Text = Request.Item("Unit")

                Call LoadSalaryStatus()
                Call LoadGender()
                Call GetManClockId()

                Call LoadEmpSecurity()
                Call LoadJobCodes()

                If txtSecCode.Value = 8 Then
                    tblStore.Visible = True
                    Call loadStores()
                Else
                    tblStore.Visible = False
                End If

                'Display defaults
                txtHireDate.Text = Today

                cmdSubmit.Attributes.Add("onclick", "if(ValidateSubmit()){this.value = 'Please Wait'; this.disabled=true; " & GetPostBackEventReference(cmdSubmit).ToString & "} else{return false;}")
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub
    Private Sub LoadStores()
        Try
            'objData = New clsData

            'objData.ConnectionString = Application("ConnString")

            'If Not objData.GetRset("GetAllStoreList") Then
            '    'MessageBox.Show(objData.ErrMsg)
            'Else
            '    dsData = objData.RecSet
            'End If

            With cmbStore
                .DataSource = Application("Store") 'dsData.Tables("DataSet")
                .DataTextField = "Store"
                .DataValueField = "StoreNo"
                .DataBind()
                .Items.Insert(0, New ListItem("", "0"))
            End With

            'objData = Nothing
            'dsData = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Sub LoadSalaryStatus()
        Try
            With cmbSalaryStatus
                .Items.Insert(0, New ListItem("Hourly", "1"))
                .Items.Insert(1, New ListItem("Salary", "0"))
            End With
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Sub LoadJobCodes()
        Try
            'Get job codes with pay range only for store people.
            If txtSecCode.Value <= 4 Then

                objData = New clsData

                objData.ConnectionString = Application("ConnString")

                If Not objData.GetRset("GetAllJobCodeListWithPayRange " & txtStore.Text) Then
                    'MessageBox.Show(objData.ErrMsg)
                Else
                    dsData = objData.RecSet
                End If

                With cmbJobCode
                    .DataSource = dsData.Tables("DataSet")
                    .DataTextField = "JobDesc"
                    .DataValueField = "PayRange"
                    .DataBind()
                    .Items.Insert(0, New ListItem("", ""))
                End With

                objData = Nothing
                dsData = Nothing
            Else
                With cmbJobCode
                    .DataSource = Application("JobCode") 'dsData.Tables("DataSet")
                    .DataTextField = "JobDesc"
                    .DataValueField = "JobCode"
                    .DataBind()
                    .Items.Insert(0, New ListItem("", ""))
                End With
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Sub LoadEmpSecurity()
        Try
            Dim objGeneral As clsGeneral

            objGeneral = New clsGeneral
            With objGeneral
                .ConnectionString = Application("ConnString")
                .ClockId = txtManClockId.Text
                If Not .GetEmpSecurity Then
                    txtSecCode.Value = 0
                Else
                    txtSecCode.Value = .SecCode
                    'txtUnit.Value = .Unit
                End If
            End With

            objGeneral = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

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

    Private Sub cmdSubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdSubmit.Click
        Try
            If txtManClockId.Text > 0 Then
                If UpdateData(txtManClockId.Text) Then
                    'Update Job Codes
                    'Call UpdateJobCodes()
                End If
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
                .AppendParameter("@ECId", "Integer", 4, 0)
                .AppendParameter("@ChangeTypeId", "Integer", 4, 6)
                .AppendParameter("@ClockId", "Integer", 4, 0)
                .AppendParameter("@ChangeReason", "Char", 2000, "")
                .AppendParameter("@EffDate", "Date", 4, GetValue(txtHireDate.Text, "Date"))
                .AppendParameter("@FName", "Char", 50, GetValue(txtFName.Text, "String"))
                .AppendParameter("@MName", "Char", 50, GetValue(txtMName.Text, "String"))
                .AppendParameter("@LName", "Char", 50, GetValue(txtLName.Text, "String"))
                .AppendParameter("@Add1", "Char", 200, "")
                .AppendParameter("@Add2", "Char", 200, "")
                .AppendParameter("@City", "Char", 100, "")
                .AppendParameter("@StateId", "Integer", 4, 0)
                .AppendParameter("@Zip", "Char", 10, "")
                .AppendParameter("@Gender", "Char", 1, cmbGender.SelectedValue)
                .AppendParameter("@SSN", "Char", 10, GetValue(txtSSN.Text, "Phone"))
                .AppendParameter("@JobTitleId", "Integer", 4, 0)

                If txtSecCode.Value = 8 Then 'Read from list box
                    .AppendParameter("@Unit", "Integer", 4, cmbStore.SelectedValue)
                Else
                    .AppendParameter("@Unit", "Integer", 4, txtStore.Text)
                End If

                .AppendParameter("@WorkPh", "Char", 10, "")
                .AppendParameter("@WorkExt", "Char", 5, "")
                .AppendParameter("@CellPh", "Char", 10, "")
                .AppendParameter("@HomePh", "Char", 10, "")
                .AppendParameter("@NeedLogin", "Bit", 1, False)
                .AppendParameter("@DispName", "Char", 100, GetValue(txtDispName.Text, "String"))
                .AppendParameter("@LoginName", "Char", 50, "")
                .AppendParameter("@WorkEmail", "Char", 100, "")
                .AppendParameter("@ManClockId", "Integer", 4, 0)
                .AppendParameter("@JobCode", "Integer", 4, 0)
                .AppendParameter("@PayRate", "Currency", 4, 0)

                'By default benefit date will be same as hire date
                .AppendParameter("@DateBen", "Date", 5, GetValue(txtHireDate.Text, "Date"))
                .AppendParameter("@DateBirth", "Date", 5, DBNull.Value)
                .AppendParameter("@DateWPExp", "Date", 5, DBNull.Value)
                .AppendParameter("@HourlyFlag", "Bit", 1, CBool(cmbSalaryStatus.SelectedValue))
                .AppendParameter("@LegalName", "Char", 100, GetLegalName())
                .AppendParameter("@EthnicityId", "Integer", 4, 0)
                .AppendParameter("@EmpRefId", "Integer", 4, 0)
                .AppendParameter("@I9StatusId", "Integer", 4, 0)
                .AppendParameter("@DateExp", "Date", 4, DBNull.Value)
                .AppendParameter("@AlienNo", "Char", 20, "")
                .AppendParameter("@I9Notes", "Char", 1000, "")

                .AppendParameter("@FedMaritalStatusId", "Integer", 4, 0)
                .AppendParameter("@StateMaritalStatusId", "Integer", 4, 0)
                '.AppendParameter("@ClaimSingle", "Bit", 1, False)
                .AppendParameter("@FedDed", "Currency", 4, 0)
                .AppendParameter("@StateDed", "Currency", 4, 0)
                .AppendParameter("@FedExempNo", "Integer", 4, 0)
                .AppendParameter("@StateExempNo", "Integer", 4, 0)
                .AppendParameter("@FedClaimExempt", "Bit", 1, False)
                .AppendParameter("@StateClaimExempt", "Bit", 1, False)
                .AppendParameter("@A4Ded", "Currency", 4, DBNull.Value)
                .AppendParameter("@W4Notes", "Char", 1000, "")

                .AppendParameter("@TempUnit", "Integer", 4, 0)
                .AppendParameter("@TempSDate", "Date", 4, DBNull.Value)
                .AppendParameter("@TempEDate", "Date", 4, DBNull.Value)

                .AppendParameter("@Notes", "Char", 2000, "")
                .AppendParameter("@EmpSig", "Char", 6000, "")
                .AppendParameter("@EmpId", "Integer", 4, lngClockId)

                .AppendParameter("@SSNOk", "Bit", 1, chkSSNOk.Checked)
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
                txtClockId.Text = Math.Abs(intReturnCode)

                If intReturnCode = -1 Then  'Request is already made
                    Call DisplayStatus("New Hire request has already been made for this employee | Please check New Hire report to get more details", True)
                    UpdateData = False
                Else
                    'Update Job Code Details
                    Call CreateJobCodeChangeList()
                    Call UpdateJobCodes()

                    If intReturnCode < 0 Then      'It is Rehire
                        'Send email to HR Dept about rehire
                        'Call SendReHireMailToHR()
                        Call SendEmail(1, True)

                        Call DisplayStatus("Request has been submitted successfully | Employee is ReHire | Clock Id : " & Math.Abs(intReturnCode), False)
                    Else                                'It is New Hire
                        Call SendEmail(1, False)
                        Call DisplayStatus("Request has been submitted successfully | Employee is New Hire | Clock Id : " & Math.Abs(intReturnCode), False)
                    End If

                    'Call DisplayStatus("New Hire request has been submitted successfully .. Clock Id : " & objData.ReturnCode, False)
                    'txtClockId.Text = objData.ReturnCode
                    UpdateData = True
                End If
            End If

            objData = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Function

    Private Function GetLegalName() As String
        Try
            Dim strLegal As String

            strLegal = Trim(txtFName.Text)

            If Trim(txtMName.Text) <> "" Then
                strLegal = strLegal & " " & Trim(txtMName.Text)
            End If

            strLegal = strLegal & " " & Trim(txtLName.Text)
            GetLegalName = GetValue(strLegal, "String")
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Function

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

    Private Sub LoadGender()
        Try
            With cmbGender
                .Items.Insert(0, New ListItem("", ""))
                .Items.Insert(1, New ListItem("Male", "M"))
                .Items.Insert(2, New ListItem("Female", "F"))
            End With
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Function UpdateJobCodes() As Boolean
        Try
            Dim lngECId As Long
            Dim i As DataRow
            Dim j As Integer
            Dim blnSuccess As Boolean

            objData = New clsData
            dsData = New DataSet

            lngECId = 0

            objData.ConnectionString = Application("ConnString")

            If Not objData.GetRset("GetReqId 6," & txtClockId.Text) Then
                Response.Write(objData.ErrMsg)
            Else
                dsData = objData.RecSet
            End If

            For Each i In dsData.Tables("DataSet").Rows()
                lngECId = i("EC_Id")
            Next

            dsData = Nothing
            objData = Nothing

            'Save job codes
            If lngECId > 0 Then
                For j = 0 To objJD.Length - 1
                    objData = New clsData
                    objData.ConnectionString = Application("ConnString")

                    With objData
                        .AppendOutputParm()
                        .AppendParameter("@ECId", "Integer", 4, lngECId)
                        .AppendParameter("@JobCode", "Integer", 4, objJD(j).intJobCode)
                        .AppendParameter("@PayRate", "Currency", 4, objJD(j).dblPayRate)
                        .AppendParameter("@Primary", "Bit", 1, objJD(j).blnPrimary)
                        .AppendParameter("@EJCAction", "Integer", 4, objJD(j).intStatus)
                    End With

                    If Not objData.ExecuteCommand("UpdateEmpJobChanges") Then
                        Call DisplayStatus(objData.ErrMsg, True)
                        blnSuccess = False
                    Else
                        blnSuccess = True
                    End If

                    objData = Nothing
                Next

                'Check job codes and add missing ones
                If blnSuccess Then
                    objData = New clsData
                    objData.ConnectionString = Application("ConnString")

                    With objData
                        .AppendOutputParm()
                        .AppendParameter("@ECId", "Integer", 4, lngECId)
                        .AppendParameter("@ChangeTypeId", "Integer", 4, 6)
                    End With

                    If Not objData.ExecuteCommand("UpdateReqCheckJobCodes") Then
                        Call DisplayStatus(objData.ErrMsg, True)
                        UpdateJobCodes = False
                    Else
                        UpdateJobCodes = True
                    End If

                    objData = Nothing
                End If
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Function

    Private Sub CreateJobCodeChangeList()
        Try
            Dim i As Integer
            Dim j As Integer
            Dim strItem As String
            Dim strItemOld As String

            For i = 0 To lstJobCode.Items.Count - 1
                strItem = Trim(lstJobCode.Items(i).Text.Replace("*", ""))
                Call AddToList(strItem, 1)
            Next
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Sub AddToList(ByVal strItem As String, ByVal intStatus As Integer)
        Try
            Dim strDummy() As String
            Dim i As Integer

            If objJD Is Nothing Then
                i = 0
            Else
                i = objJD.Length
            End If

            ReDim Preserve objJD(i)

            strDummy = strItem.Split("|")

            objJD(i).intJobCode = strDummy(0).Substring(0, strDummy(0).IndexOf("-") - 1)
            objJD(i).dblPayRate = IIf(Trim(strDummy(1)) = "", 0, Trim(strDummy(1)))

            If strDummy.Length = 3 Then
                objJD(i).blnPrimary = True
                'strPrimaryJobCode = strDummy(0) 'For ADS saving
            Else
                objJD(i).blnPrimary = False
            End If

            objJD(i).intStatus = intStatus
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Sub SendReHireMailToHR()
        Try

            objData = New clsData
            Dim i As DataRow
            Dim strEmpName As String
            Dim strEmpEmail As String
            Dim strEmailList As String
            Dim intUnit As Integer
            Dim strBody As String

            'Get Email addresses
            objData.ConnectionString = Application("ConnString")

            If Not objData.GetRset("GetEmailsForReHire " & txtManClockId.Text) Then
                'MessageBox.Show(objData.ErrMsg)
                Exit Sub
            Else
                dsData = objData.RecSet
            End If

            For Each i In dsData.Tables("DataSet").Rows
                strEmpName = FixNull(i(0))
                strEmpEmail = FixNull(i(1))
                intUnit = i(2)
                strEmailList = FixNull(i(3))
            Next

            objData = Nothing
            dsData = Nothing

            If Trim(strEmpEmail) = "" Or Trim(strEmailList) = "" Then
                Exit Sub
            End If

            'Send email
            Dim objMail As New System.Web.Mail.MailMessage

            With objMail
                .To = strEmailList
                .From = strEmpName & "(" & strEmpEmail & ")"

                .BodyFormat = Mail.MailFormat.Text
                .Subject = "ReHire From Store - " & intUnit

                strBody = "I just submitted a ReHire request for following employee."

                strBody = strBody & vbCrLf & vbCrLf _
                        & "Clock Id : " & txtClockId.Text & vbCrLf _
                        & "Employee Name : " & txtFName.Text & " " & txtLName.Text & vbCrLf _
                        & "SSN : " & txtSSN.Text & vbCrLf _
                        & "Hire Date : " & txtHireDate.Text

                .Body = strBody
            End With

            System.Web.Mail.SmtpMail.SmtpServer = "www.claimjumper.com"
            System.Web.Mail.SmtpMail.Send(objMail)

            objMail = Nothing
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

    Private Function SendEmail(ByVal intProcessStep As Integer, ByVal blnReHire As Boolean) As Boolean
        Try
            Dim j As Integer
            Dim i As DataRow
            Dim strEmpName As String
            Dim strEmpEmail As String
            Dim strEmailList As String
            Dim strBody As String
            Dim objGeneral As clsGeneral
            Dim intUnit As Integer
            Dim intFromUnit As Integer

            Dim strJobCodeList As String
            Dim strDeptList As String

            For j = 0 To objJD.Length - 1
                If strJobCodeList = "" Then
                    strJobCodeList = objJD(j).intJobCode
                Else
                    strJobCodeList = strJobCodeList & "," & objJD(j).intJobCode
                End If
            Next

            'Prepare job code list for email
            For j = 0 To lstJobCode.Items.Count - 1
                If strDeptList = "" Then
                    strDeptList = Trim(lstJobCode.Items(j).Text.Substring(0, lstJobCode.Items(j).Text.IndexOf("|") - 1))
                Else
                    strDeptList = strDeptList & " | " & Trim(lstJobCode.Items(j).Text.Substring(0, lstJobCode.Items(j).Text.IndexOf("|") - 1))
                End If
            Next

            If txtSecCode.Value = 8 Then 'Read from list box
                intFromUnit = cmbStore.SelectedValue
            Else
                intFromUnit = txtStore.Text
            End If

            objData = New clsData

            'Get Email addresses
            objData.ConnectionString = Application("ConnString")

            If Not objData.GetRset("GetEmailsForHire " & txtManClockId.Text & ",'" & strJobCodeList & "'," & intFromUnit & "," & intProcessStep) Then
                'MessageBox.Show(objData.ErrMsg)
                Exit Function
            Else
                dsData = objData.RecSet
            End If

            For Each i In dsData.Tables("DataSet").Rows
                strEmpName = FixNull(i(0))
                strEmpEmail = FixNull(i(1))
                intUnit = FixNull(i(2))
                strEmailList = FixNull(i(3))
            Next

            objData = Nothing
            dsData = Nothing

            If Trim(strEmpEmail) = "" Or Trim(strEmailList) = "" Then
                Exit Function
            End If

            'Send email
            objGeneral = New clsGeneral
            With objGeneral
                .EmailTo = strEmailList
                .EmailFrom = strEmpName & "(" & strEmpEmail & ")"

                If blnReHire Then
                    .EmailSubject = "ReHire From Store - " & intUnit
                    If intProcessStep = 1 Then
                        strBody = "I just created a ReHire request for following employee."
                    ElseIf intProcessStep = 2 Then
                        strBody = "I just approved a ReHire request for following employee."
                    Else
                        strBody = "I just processed a ReHire request for following employee."
                    End If
                Else
                    .EmailSubject = "New Hire From Store - " & intUnit
                    If intProcessStep = 1 Then
                        strBody = "I just created a New Hire request for following employee."
                    ElseIf intProcessStep = 2 Then
                        strBody = "I just approved a New Hire request for following employee."
                    Else
                        strBody = "I just processed a New Hire request for following employee."
                    End If
                End If

                strBody = strBody & vbCrLf & vbCrLf _
                        & "Clock Id      : " & txtClockId.Text & vbCrLf _
                        & "Employee Name : " & txtFName.Text & " " & txtLName.Text & vbCrLf _
                        & "Hire Date     : " & txtHireDate.Text & vbCrLf _
                        & "Departments   : " & strDeptList _
                        & vbCrLf & vbCrLf & vbCrLf _
                        & "This email is generated automatically through HR Express based on certain action."

                ' & "SSN           : " & txtSSN.Text & vbCrLf _

                .EmailBody = strBody
                .SendEMail()
            End With

            objGeneral = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Function
End Class