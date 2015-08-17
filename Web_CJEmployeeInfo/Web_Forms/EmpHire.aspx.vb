Imports Web_CJEmployeeInfo.Web_CJEmployeeInfo
Public Class EmpHire
    Inherits System.Web.UI.Page
#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents chkCitizen As System.Web.UI.WebControls.CheckBox
    Protected WithEvents chkEmpAuth As System.Web.UI.WebControls.CheckBox
    Protected WithEvents chkPermRes As System.Web.UI.WebControls.CheckBox
    Protected WithEvents chkRegAlien As System.Web.UI.WebControls.CheckBox
    Protected WithEvents chkTempRes As System.Web.UI.WebControls.CheckBox


    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

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
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            If Not Page.IsPostBack Then

                txtId.Value = Request.Item("Id")
                txtStore.Text = Request.Item("Unit")

                'Call LoadStores()
                Call LoadManagers()
                Call LoadStates()
                Call LoadJobTitles()

                Call LoadSalaryStatus()
                Call LoadGender()
                Call LoadEthnicity()
                Call LoadEmpReferral()
                Call LoadMaritalStatus()
                Call LoadI9Status()
                Call LoadA4Ded()
                Call LoadEducation()
                Call LoadRecruiter()

                Call GetManClockId()
                Call LoadEmpSecurity()
                Call LoadCompany()

                tblCompany.Visible = False
                tblUndoGMApproval.Visible = False

                If txtId.Value > 0 Then
                    Call LoadEmpHireReq()

                    If txtChangeTypeId.Value = 6 Then
                        cmdApprove.Visible = False
                        cmdDeny.Visible = False
                        cmdPost.Visible = False
                        cmdSubmit.Visible = False
                        cmdUpdate.Visible = True

                        'Allow GM, AGM & MO OA to deny the request without updating
                        If txtSecCode.Value = 3 Or txtSecCode.Value = 4 Or _
                            txtSecCode.Value = 8 Or txtSecCode.Value = 10 Then
                            cmdDeny.Visible = True
                        End If
                    Else
                        'Allow GM, AGM & HR Admin to approve/deny request
                        If txtSecCode.Value = 3 Or txtSecCode.Value = 4 Or _
                            txtSecCode.Value = 9 Or txtSecCode.Value = 10 Then

                            cmdApprove.Visible = True
                            cmdDeny.Visible = True
                            cmdPost.Visible = False
                            cmdSubmit.Visible = False
                            cmdUpdate.Visible = False
                        Else
                            cmdSubmit.Visible = False
                            cmdPost.Visible = True
                            'cmdReview.Visible = True
                            cmdApprove.Visible = False
                            cmdDeny.Visible = False
                            cmdUpdate.Visible = False
                            tblCompany.Visible = True
                        End If

                        'Allow Payroll Admin, HR Supervisor and payroll dept to undo GM Approval 
                        'before post
                        If txtSecCode.Value = 5 Or txtSecCode.Value = 6 Then
                            cmdDeny.Visible = True
                            cmdDeny.Text = "Undo Approval"
                            tblUndoGMApproval.Visible = True
                        End If
                    End If
                Else
                    cmdSubmit.Visible = True
                    cmdPost.Visible = False
                    'cmdReview.Visible = False
                    tblADS.Visible = False            '---------
                    tblClockId.Visible = False
                    cmdApprove.Visible = False
                    cmdDeny.Visible = False
                    cmdUpdate.Visible = False

                    'Display defaults
                    txtHireDate.Text = Today
                    txtBenefitDate.Text = Today
                End If


                Call LoadJobCodes()


                'Allow to view store list to Main Office OA
                If txtSecCode.Value = 8 Then
                    cmbStore.Visible = True
                    txtStore.Visible = False
                    Call LoadStores()
                Else
                    cmbStore.Visible = False
                End If

                cmdSubmit.Attributes.Add("onclick", "if(ValidateSubmit()){this.value = 'Please Wait'; this.disabled=true; " & GetPostBackEventReference(cmdSubmit).ToString & "} else{return false;}")
                cmdPost.Attributes.Add("onclick", "if(ValidatePost()){this.value = 'Please Wait'; this.disabled=true; " & GetPostBackEventReference(cmdPost).ToString & "} else{return false;}")
                cmdUpdate.Attributes.Add("onclick", "if(ValidateUpdate()){this.value = 'Please Wait'; this.disabled=true; " & GetPostBackEventReference(cmdUpdate).ToString & "} else{return false;}")
                cmdApprove.Attributes.Add("onclick", "if(ValidateApproveDeny(1)){this.value = 'Please Wait'; this.disabled=true; " & GetPostBackEventReference(cmdApprove).ToString & "} else{return false;}")
                cmdDeny.Attributes.Add("onclick", "if(ValidateApproveDeny(2)){this.value = 'Please Wait'; this.disabled=true; " & GetPostBackEventReference(cmdDeny).ToString & "} else{return false;}")

                txtFName.Attributes.Add("onblur", "UpdateLegalName();")
                txtMName.Attributes.Add("onblur", "UpdateLegalName();")
                txtLName.Attributes.Add("onblur", "UpdateLegalName();")

                txtHireDate.Attributes.Add("onblur", "UpdateBenefitDate();")

                'chkNeedsLogin.Attributes.Add("OnClick", "return true;")
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
                .Items.Insert(0, New ListItem("", ""))
            End With

            'objData = Nothing
            'dsData = Nothing
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
                .Items.Insert(0, New ListItem("", "0"))
            End With

            'objData = Nothing
            'dsData = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub
    Private Sub LoadJobTitles()
        Try
            'objData = New clsData

            'objData.ConnectionString = Application("ConnString")

            'If Not objData.GetRset("GetItemList 'JobTitle'") Then
            '    'MessageBox.Show(objData.ErrMsg)
            'Else
            '    dsData = objData.RecSet
            'End If

            With cmbJobTitle
                .DataSource = Application("JobTitle") 'dsData.Tables("DataSet")
                .DataTextField = "Item_Val"
                .DataValueField = "ItemDetail_Id"
                .DataBind()
                .Items.Insert(0, New ListItem("", "0"))
            End With

            'objData = Nothing
            'dsData = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub
    Private Sub LoadManagers()
        Try

            objData = New clsData

            objData.ConnectionString = Application("ConnString")

            If Not objData.GetRset("GetAllManagerList") Then
                'MessageBox.Show(objData.ErrMsg)
            Else
                dsData = objData.RecSet
            End If

            With cmbManager
                .DataSource = dsData.Tables("DataSet")
                .DataTextField = "ManName"
                .DataValueField = "ClockId"
                .DataBind()
                .Items.Insert(0, New ListItem("", "0"))
            End With

            objData = Nothing
            dsData = Nothing
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
                    .Items.Insert(0, New ListItem("", "0"))
                End With

                objData = Nothing
                dsData = Nothing

            Else
                With cmbJobCode
                    .DataSource = Application("JobCode") 'dsData.Tables("DataSet")
                    .DataTextField = "JobDesc"
                    .DataValueField = "JobCode"
                    .DataBind()
                    .Items.Insert(0, New ListItem("", "0"))
                End With
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub
    Private Sub LoadEthnicity()
        Try
            'objData = New clsData

            'objData.ConnectionString = Application("ConnString")

            'If Not objData.GetRset("GetItemList 'Ethnicity'") Then
            '    'MessageBox.Show(objData.ErrMsg)
            'Else
            '    dsData = objData.RecSet
            'End If

            With cmbEthnicity
                .DataSource = Application("Ethnicity") 'dsData.Tables("DataSet")
                .DataTextField = "Item_Val"
                .DataValueField = "ItemDetail_Id"
                .DataBind()
                .Items.Insert(0, New ListItem("", "0"))
            End With

            'objData = Nothing
            'dsData = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub
    Private Sub LoadCompany()
        Try
            'objData = New clsData

            'objData.ConnectionString = Application("ConnString")

            'If Not objData.GetRset("GetItemList 'Company'") Then
            '    'MessageBox.Show(objData.ErrMsg)
            'Else
            '    dsData = objData.RecSet
            'End If

            With cmbCompany
                .DataSource = Application("Company") 'dsData.Tables("DataSet")
                .DataTextField = "Item_Val"
                .DataValueField = "ItemDetail_Id"
                .DataBind()
                .Items.Insert(0, New ListItem("", "0"))
            End With

            'objData = Nothing
            'dsData = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub
    Private Sub LoadEmpReferral()
        Try
            'objData = New clsData

            'objData.ConnectionString = Application("ConnString")

            'If Not objData.GetRset("GetItemList 'EmpReferral'") Then
            '    'MessageBox.Show(objData.ErrMsg)
            'Else
            '    dsData = objData.RecSet
            'End If

            With cmbEmpReferral
                .DataSource = Application("EmpReferral") 'dsData.Tables("DataSet")
                .DataTextField = "Item_Val"
                .DataValueField = "ItemDetail_Id"
                .DataBind()
                .Items.Insert(0, New ListItem("", "0"))
            End With

            'objData = Nothing
            'dsData = Nothing
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
                    'txtStore.Text = .Unit
                End If
            End With

            objGeneral = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub
    Private Sub LoadMaritalStatus()
        Try
            'objData = New clsData

            'objData.ConnectionString = Application("ConnString")

            'If Not objData.GetRset("GetItemList 'MaritalStatus'") Then
            '    'MessageBox.Show(objData.ErrMsg)
            'Else
            '    dsData = objData.RecSet
            'End If

            'Load State marital status
            With cmbStateMarital
                .DataSource = Application("StateMaritalStatus") 'dsData.Tables("DataSet")
                .DataTextField = "Item_Val"
                .DataValueField = "ItemDetail_Id"
                .DataBind()
                .Items.Insert(0, New ListItem("", "0"))
            End With

            'Load Federal marital status
            With cmbFedMarital
                .DataSource = Application("FedMaritalStatus") 'dsData.Tables("DataSet")
                .DataTextField = "Item_Val"
                .DataValueField = "ItemDetail_Id"
                .DataBind()
                .Items.Insert(0, New ListItem("", "0"))
            End With

            'objData = Nothing
            'dsData = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub
    Private Sub LoadI9Status()
        Try
            'objData = New clsData

            'objData.ConnectionString = Application("ConnString")

            'If Not objData.GetRset("GetItemList 'I9Status'") Then
            '    'MessageBox.Show(objData.ErrMsg)
            'Else
            '    dsData = objData.RecSet
            'End If

            With cmbI9Status
                .DataSource = Application("I9Status") 'dsData.Tables("DataSet")
                .DataTextField = "Item_Val"
                .DataValueField = "ItemDetail_Id"
                .DataBind()
                .Items.Insert(0, New ListItem("", "0"))
            End With

            'objData = Nothing
            'dsData = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub
    Private Sub LoadA4Ded()
        Try
            'objData = New clsData

            'objData.ConnectionString = Application("ConnString")

            'If Not objData.GetRset("GetItemList 'A4Ded'") Then
            '    'MessageBox.Show(objData.ErrMsg)
            'Else
            '    dsData = objData.RecSet
            'End If

            With cmbA4Ded
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
    Private Sub LoadEducation()
        Try
            With cmbEducation
                .DataSource = Application("Education")
                .DataTextField = "Item_Val"
                .DataValueField = "ItemDetail_Id"
                .DataBind()
                .Items.Insert(0, New ListItem("", "0"))
            End With
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub
    Private Sub LoadRecruiter()
        Try
            With cmbRecruiter
                .DataSource = Application("Recruiter")
                .DataTextField = "Item_Val"
                .DataValueField = "ItemDetail_Id"
                .DataBind()
                .Items.Insert(0, New ListItem("", "0"))
            End With

            'cmbRecruiter.SelectedIndex = 1
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
                    If txtSecCode.Value = 5 Or txtSecCode.Value = 6 Or _
                        txtSecCode.Value = 7 Then
                        Return Trim(DBValue)
                    Else
                        Return StrConv(Trim(DBValue), VbStrConv.ProperCase)
                    End If
                End If
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Function
    Private Sub LoadEmpHireReq()
        Try
            objData = New clsData
            dsData = New DataSet
            Dim i As DataRow
            Dim j As Integer

            objData.ConnectionString = Application("ConnString")

            If Not objData.GetRset("GetRequestDetails 1," & txtId.Value) Then
                Response.Write(objData.ErrMsg)
            Else
                dsData = objData.RecSet
            End If

            For Each i In dsData.Tables("DataSet").Rows()

                txtChangeTypeId.Value = i("ChangeTypeId")

                txtClockId.Text = FixNull(i("ClockId"))
                chkReHire.Checked = i("ReHire1")

                If txtSecCode.Value = 8 Then
                    cmbStore.SelectedValue = FixNull(i("Unit"))
                    cmbStore.Enabled = False
                Else
                    txtStore.Text = FixNull(i("Unit"))
                End If

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

                cmbState.SelectedValue = FixNull(i("State_Id"))
                txtHState.Text = cmbState.SelectedValue

                txtZip.Text = FixNull(i("Zip"))
                txtZip.ToolTip = txtZip.Text

                txtDispName.Text = FixNull(i("Disp_Name"))
                txtDispName.ToolTip = txtDispName.Text

                cmbGender.SelectedValue = FixNull(i("Gender"))
                txtHGender.Text = cmbGender.SelectedValue

                txtSSN.Text = FixNull(i("SSN1"))
                txtSSN.ToolTip = txtSSN.Text

                cmbJobTitle.SelectedValue = FixNull(i("Job_TitleId"))
                txtHJobTitle.Text = cmbJobTitle.SelectedValue

                txtHomePh.Text = FixNull(i("Home_Ph1"))
                txtHomePh.ToolTip = txtHomePh.Text

                txtWorkPh.Text = FixNull(i("Work_Ph1"))
                txtWorkPh.ToolTip = txtWorkPh.Text

                txtWorkExt.Text = FixNull(i("Work_Ext"))
                txtWorkExt.ToolTip = txtWorkExt.Text

                txtCellPh.Text = FixNull(i("Cell_Ph1"))
                txtCellPh.ToolTip = txtCellPh.Text


                cmbManager.SelectedValue = FixNull(i("Man_ClockId"))
                txtHManager.Text = cmbManager.SelectedValue

                'cmbJobCode.SelectedValue = FixNull(i("Job_Code"))
                'txtHJobCode.Text = cmbJobCode.SelectedValue

                'txtPayRate.Text = FixNull(i("Pay_Rate"))
                'txtPayRate.ToolTip = txtPayRate.Text

                txtBenefitDate.Text = FixNull(i("Date_Benefit1"))
                txtBenefitDate.ToolTip = txtBenefitDate.Text

                txtBirthDate.Text = FixNull(i("Date_Birth1"))
                txtBirthDate.ToolTip = txtBirthDate.Text

                txtWPExpDate.Text = FixNull(i("Date_WPExp1"))
                txtWPExpDate.ToolTip = txtWPExpDate.Text

                cmbSalaryStatus.SelectedValue = IIf(i("Hourly_Flag"), 1, 0)
                txtHSalaryStatus.Text = cmbSalaryStatus.SelectedValue

                txtLegalName.Text = FixNull(i("Legal_Name"))
                txtLegalName.ToolTip = txtLegalName.Text

                cmbEthnicity.SelectedValue = FixNull(i("Ethnicity_Id"))
                txtHEthnicity.Text = cmbEthnicity.SelectedValue

                cmbEmpReferral.SelectedValue = FixNull(i("Emp_ReferralId"))
                txtHEmpReferral.Text = cmbEmpReferral.SelectedValue

                cmbI9Status.SelectedValue = FixNull(i("I9Status_Id"))
                txtHI9Status.Text = cmbI9Status.SelectedValue

                txtExpDate.Text = FixNull(i("Date_Exp1"))
                txtExpDate.ToolTip = txtExpDate.Text

                txtAlienNo.Text = FixNull(i("Alien_No"))
                txtAlienNo.ToolTip = txtAlienNo.Text

                txtI9Notes.Text = FixNull(i("I9_Notes"))
                txtI9Notes.ToolTip = txtI9Notes.Text

                cmbFedMarital.SelectedValue = FixNull(i("FedMarital_StatusId"))
                txtHFedMarital.Text = cmbFedMarital.SelectedValue

                cmbStateMarital.SelectedValue = FixNull(i("StateMarital_StatusId"))
                txtHStateMarital.Text = cmbStateMarital.SelectedValue

                'chkClaimSingle.Checked = FixNull(i("Claim_Single"))
                'chkClaimSingle.ToolTip = chkClaimSingle.Checked

                txtFedDed.Text = FixNull(i("Fed_Ded"))
                txtFedDed.ToolTip = txtFedDed.Text

                txtStateDed.Text = FixNull(i("State_Ded"))
                txtStateDed.ToolTip = txtStateDed.Text

                txtFedExempNo.Text = FixNull(i("FedExemp_No"))
                txtFedExempNo.ToolTip = txtFedExempNo.Text

                txtStateExempNo.Text = FixNull(i("StateExemp_No"))
                txtStateExempNo.ToolTip = txtStateExempNo.Text

                chkFedClEx.Checked = FixNull(i("FedClaim_Exempt"))
                chkFedClEx.ToolTip = chkFedClEx.Checked

                chkStateClEx.Checked = FixNull(i("StateClaim_Exempt"))
                chkStateClEx.ToolTip = chkStateClEx.Checked

                If i("A4_Ded") Is DBNull.Value Then
                    cmbA4Ded.SelectedValue = -1
                Else
                    If i("A4_Ded") = 0 Then
                        cmbA4Ded.SelectedValue = 0
                    Else
                        cmbA4Ded.SelectedValue = CDbl(i("A4_Ded"))
                    End If
                End If

                txtHA4Ded.Text = cmbA4Ded.SelectedValue

                txtW4Notes.Text = FixNull(i("W4_Notes"))
                txtW4Notes.ToolTip = txtW4Notes.Text

                txtHireDate.Text = FixNull(i("Eff_Date1"))
                txtHireDate.ToolTip = txtHireDate.Text

                chkNeedsLogin.Checked = i("Need_Login")
                chkNeedsLogin.ToolTip = chkNeedsLogin.Checked

                chkSSNOk.Checked = i("SSN_Ok")
                chkSSNOk.ToolTip = chkSSNOk.Checked

                If i("Need_Login") Then
                    tblADS.Visible = True

                    txtLoginName.Text = FixNull(i("Login_Name"))
                    txtLoginName.ToolTip = txtLoginName.Text

                    txtWorkEmail.Text = FixNull(i("Work_Email"))
                    txtWorkEmail.ToolTip = txtWorkEmail.Text

                Else
                    tblADS.Visible = False
                End If

                txtPEmail.Text = FixNull(i("Personal_Email"))
                txtPEmail.ToolTip = txtPEmail.Text

                cmbEducation.SelectedValue = FixNull(i("Education_Id"))
                txtHEducation.Text = cmbEducation.SelectedValue

                cmbRecruiter.SelectedValue = FixNull(i("Recruiter_Id"))
                txtHRecruiter.Text = cmbRecruiter.SelectedValue

                txtPrevCompany.Text = FixNull(i("Prev_Company"))
                txtPrevCompany.ToolTip = txtPrevCompany.Text

                Exit For
            Next

            j = 0
            For Each i In dsData.Tables("DataSet").Rows
                If i("Primary") Then
                    lstJobCode.Items.Insert(j, New ListItem(i("JobCode") & "  |  " & i("PayRate") & "  |  Primary  *", i("JobCode")))
                    lstOldJobCode.Items.Insert(j, New ListItem(i("JobCode") & "  |  " & i("PayRate") & "  |  Primary  *", i("JobCode")))
                Else
                    lstJobCode.Items.Insert(j, New ListItem(i("JobCode") & "  |  " & i("PayRate") & "  *", i("JobCode")))
                    lstOldJobCode.Items.Insert(j, New ListItem(i("JobCode") & "  |  " & i("PayRate") & "  *", i("JobCode")))
                End If
                j = j + 1
            Next

            dsData = Nothing
            objData = Nothing
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
    Private Sub cmdSubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdSubmit.Click
        Try
            If txtManClockId.Text > 0 Then
                If UpdateData(txtManClockId.Text) Then
                    'Update Departments
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
                .AppendParameter("@ECId", "Integer", 4, txtId.Value)
                .AppendParameter("@ChangeTypeId", "Integer", 4, 1)
                .AppendParameter("@ClockId", "Integer", 4, 0)
                .AppendParameter("@ChangeReason", "Char", 2000, "")
                .AppendParameter("@EffDate", "Date", 4, GetValue(txtHireDate.Text, "Date"))
                .AppendParameter("@FName", "Char", 50, GetValue(txtFName.Text, "String"))
                .AppendParameter("@MName", "Char", 50, GetValue(txtMName.Text, "String"))
                .AppendParameter("@LName", "Char", 50, GetValue(txtLName.Text, "String"))
                .AppendParameter("@Add1", "Char", 200, GetValue(txtAdd1.Text, "String"))
                .AppendParameter("@Add2", "Char", 200, GetValue(txtAdd2.Text, "String"))
                .AppendParameter("@City", "Char", 100, GetValue(txtCity.Text, "String"))
                .AppendParameter("@StateId", "Integer", 4, cmbState.SelectedValue)
                .AppendParameter("@Zip", "Char", 10, GetValue(txtZip.Text, "String"))
                .AppendParameter("@Gender", "Char", 1, cmbGender.SelectedValue)
                .AppendParameter("@SSN", "Char", 10, GetValue(txtSSN.Text, "Phone"))
                .AppendParameter("@JobTitleId", "Integer", 4, cmbJobTitle.SelectedValue)

                If txtSecCode.Value = 8 Then
                    .AppendParameter("@Unit", "Integer", 4, cmbStore.SelectedValue)
                Else
                    .AppendParameter("@Unit", "Integer", 4, txtStore.Text)
                End If

                .AppendParameter("@WorkPh", "Char", 10, GetValue(txtWorkPh.Text, "Phone"))
                .AppendParameter("@WorkExt", "Char", 5, GetValue(txtWorkExt.Text, "String"))
                .AppendParameter("@CellPh", "Char", 10, GetValue(txtCellPh.Text, "Phone"))
                .AppendParameter("@HomePh", "Char", 10, GetValue(txtHomePh.Text, "Phone"))
                .AppendParameter("@NeedLogin", "Bit", 1, chkNeedsLogin.Checked)
                .AppendParameter("@DispName", "Char", 100, GetValue(txtDispName.Text, "String"))
                .AppendParameter("@LoginName", "Char", 50, txtLoginName.Text)
                .AppendParameter("@WorkEmail", "Char", 100, txtWorkEmail.Text)
                .AppendParameter("@ManClockId", "Integer", 4, cmbManager.SelectedValue)
                .AppendParameter("@JobCode", "Integer", 4, 0)
                .AppendParameter("@PayRate", "Currency", 4, 0)
                .AppendParameter("@DateBen", "Date", 5, GetValue(txtBenefitDate.Text, "Date"))
                .AppendParameter("@DateBirth", "Date", 5, GetValue(txtBirthDate.Text, "Date"))
                .AppendParameter("@DateWPExp", "Date", 5, GetValue(txtWPExpDate.Text, "Date"))
                .AppendParameter("@HourlyFlag", "Bit", 1, CBool(cmbSalaryStatus.SelectedValue))
                .AppendParameter("@LegalName", "Char", 100, GetLegalName())
                .AppendParameter("@EthnicityId", "Integer", 4, cmbEthnicity.SelectedValue)
                .AppendParameter("@EmpRefId", "Integer", 4, cmbEmpReferral.SelectedValue)
                .AppendParameter("@I9StatusId", "Integer", 4, cmbI9Status.SelectedValue)
                .AppendParameter("@DateExp", "Date", 4, GetValue(txtExpDate.Text, "Date"))

                If txtId.Value <= 0 Then  'When request is created add A if it is not present
                    If Trim(txtAlienNo.Text) <> "" And _
                        UCase(Left(txtAlienNo.Text, 1)) <> "A" Then
                        .AppendParameter("@AlienNo", "Char", 20, "A" & Trim(txtAlienNo.Text))
                    Else
                        .AppendParameter("@AlienNo", "Char", 20, Trim(txtAlienNo.Text))
                    End If
                Else
                    .AppendParameter("@AlienNo", "Char", 20, txtAlienNo.Text)
                End If

                .AppendParameter("@I9Notes", "Char", 1000, txtI9Notes.Text)

                'W4 info -------
                .AppendParameter("@FedMaritalStatusId", "Integer", 4, cmbFedMarital.SelectedValue)
                .AppendParameter("@StateMaritalStatusId", "Integer", 4, cmbStateMarital.SelectedValue)
                '.AppendParameter("@ClaimSingle", "Bit", 1, chkClaimSingle.Checked)
                .AppendParameter("@FedDed", "Currency", 4, IIf(Trim(txtFedDed.Text) = "", 0, txtFedDed.Text))
                .AppendParameter("@StateDed", "Currency", 4, IIf(Trim(txtStateDed.Text) = "", 0, txtStateDed.Text))
                .AppendParameter("@FedExempNo", "Integer", 4, txtFedExempNo.Text)
                .AppendParameter("@StateExempNo", "Integer", 4, txtStateExempNo.Text)
                .AppendParameter("@FedClaimExempt", "Bit", 1, chkFedClEx.Checked)
                .AppendParameter("@StateClaimExempt", "Bit", 1, chkStateClEx.Checked)
                .AppendParameter("@A4Ded", "Currency", 4, IIf(cmbA4Ded.SelectedValue = -1, DBNull.Value, cmbA4Ded.SelectedValue))
                .AppendParameter("@W4Notes", "Char", 1000, txtW4Notes.Text)

                .AppendParameter("@TempUnit", "Integer", 4, 0)
                .AppendParameter("@TempSDate", "Date", 4, DBNull.Value)
                .AppendParameter("@TempEDate", "Date", 4, DBNull.Value)

                .AppendParameter("@Notes", "Char", 2000, "")
                .AppendParameter("@EmpSig", "Char", 6000, "")
                .AppendParameter("@EmpId", "Integer", 4, lngClockId)

                .AppendParameter("@SSNOk", "Bit", 1, chkSSNOk.Checked)
                .AppendParameter("@PEmail", "Char", 100, txtPEmail.Text)

                .AppendParameter("@EducationId", "Integer", 4, cmbEducation.SelectedValue)
                .AppendParameter("@RecruiterId", "Integer", 4, cmbRecruiter.SelectedValue)
                .AppendParameter("@PrevCompany", "char", 200, txtPrevCompany.Text)
            End With

            If Not objData.ExecuteCommand("UpdateEmpDemoChanges") Then
                Call DisplayStatus(objData.ErrMsg, True)
                UpdateData = False
            Else
                intReturnCode = objData.ReturnCode

                If txtId.Value = 0 Then     'It is new request, for Submit

                    If intReturnCode = -1 Then  'Request is already made
                        Call DisplayStatus("New Hire request has already been made for this employee | Please check New Hire report to get more details", True)
                        UpdateData = False

                    ElseIf intReturnCode = -2 Then   'Employee is active
                        Call DisplayStatus("New Hire request can not be created for an active employee .. Please check it out.", True)
                        UpdateData = False

                    Else
                        txtClockId.Text = Math.Abs(intReturnCode)

                        'Update Job Code Details
                        Call CreateJobCodeChangeList()
                        Call UpdateJobCodes()

                        If intReturnCode < 0 Then      'It is Rehire
                            'Send email
                            Call SendEmail(1, True)
                            Call DisplayStatus("Request has been submitted successfully | Employee is ReHire | Clock Id : " & Math.Abs(intReturnCode), False)
                        Else                            'It is New Hire
                            Call SendEmail(1, False)
                            Call DisplayStatus("Request has been submitted successfully | Employee is New Hire | Clock Id : " & Math.Abs(intReturnCode), False)
                        End If

                        UpdateData = True
                        'Call DisplayStatus("New Hire request has been submitted successfully .. Clock Id : " & objData.ReturnCode, False)
                    End If

                Else    'For Approve, Post
                    Call DisplayStatus("Request has been updated successfully", False)
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
    Private Function UpdateCompany() As Boolean
        Try
            objData = New clsData
            objData.ConnectionString = Application("ConnString")

            With objData
                .AppendOutputParm()
                .AppendParameter("@ECId", "Integer", 4, txtId.Value)
                .AppendParameter("@CompanyId", "Integer", 4, cmbCompany.SelectedValue)
            End With

            If Not objData.ExecuteCommand("UpdateCompany") Then
                Call DisplayStatus(objData.ErrMsg, True)
                UpdateCompany = False
            Else
                UpdateCompany = True
            End If

            objData = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Function
    Private Sub cmdPost_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPost.Click
        Try
            If txtManClockId.Text <= 0 Then
                Call DisplayStatus("ClockId not stored in ADS .. Please check it out", True)
                Call DisplayResultPage()
                Exit Sub
            End If

            'Update Company first
            If Not UpdateCompany() Then
                Call DisplayStatus("Error updating company .. Please check it out", True)
                Call DisplayResultPage()
                Exit Sub
            End If

            'Check if any field is updated before posting
            If IsPageDirty() Then
                If Not UpdateData(txtManClockId.Text) Then
                    Call DisplayResultPage()
                    Exit Sub
                End If
            End If

            'Update any job code changes
            Call CreateJobCodeChangeList()
            If IsJobCodeDirty() Then
                Call UpdateJobCodes()
            End If


            'Save to Active Directory
            If chkNeedsLogin.Checked Then
                'If CheckADSAccount() Then
                'Call UpdateADSFields()
                'Call SaveGroups()
                'End If

                'Temporary fix, send an email to Network admin to create login &
                'email address

            End If

            objData = New clsData
            objData.ConnectionString = Application("ConnString")

            With objData
                .AppendOutputParm()
                .AppendParameter("@ECId", "Integer", 4, txtId.Value)
                .AppendParameter("@ChangeTypeId", "Integer", 4, 1)
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

                    Call SendEmail(3, chkReHire.Checked)
                    Call DisplayStatus("Request has been posted successfully", False)
                End If
            End If

            objData = Nothing

            Dim strScript As String
            strScript = "<SCRIPT>window.opener.document.forms(0).txtLoadForm.value = 1; window.opener.document.forms(0).submit(); self.close();</SCRIPT>"
            Page.RegisterClientScriptBlock("CloseMeSubmit", strScript)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub
    Private Function IsPageDirty() As Boolean
        Try
            If cmbManager.SelectedValue <> txtHManager.Text Or _
                Trim(txtFName.Text) <> Trim(txtFName.ToolTip) Or _
                Trim(txtMName.Text) <> Trim(txtMName.ToolTip) Or _
                Trim(txtLName.Text) <> Trim(txtLName.ToolTip) Or _
                Trim(txtAdd1.Text) <> Trim(txtAdd1.ToolTip) Or _
                Trim(txtAdd2.Text) <> Trim(txtAdd2.ToolTip) Or _
                Trim(txtCity.Text) <> Trim(txtCity.ToolTip) Or _
                cmbState.SelectedValue <> txtHState.Text Or _
                Trim(txtZip.Text) <> Trim(txtZip.ToolTip) Or _
                cmbGender.SelectedValue <> txtHGender.Text Or _
                Trim(txtSSN.Text) <> Trim(txtSSN.ToolTip) Or _
                Trim(txtBirthDate.Text) <> Trim(txtBirthDate.ToolTip) Or _
                Trim(txtWPExpDate.Text) <> Trim(txtWPExpDate.ToolTip) Or _
                Trim(txtWorkPh.Text) <> Trim(txtWorkPh.ToolTip) Or _
                Trim(txtWorkExt.Text) <> Trim(txtWorkExt.ToolTip) Or _
                Trim(txtHomePh.Text) <> Trim(txtHomePh.ToolTip) Or _
                Trim(txtCellPh.Text) <> Trim(txtCellPh.ToolTip) Or _
                cmbSalaryStatus.SelectedValue <> txtHSalaryStatus.Text Or _
                cmbJobTitle.SelectedValue <> txtHJobTitle.Text Or _
                Trim(txtBenefitDate.Text) <> Trim(txtBenefitDate.ToolTip) Or _
                Trim(txtHireDate.Text) <> Trim(txtHireDate.ToolTip) Or _
                Trim(txtLoginName.Text) <> Trim(txtLoginName.ToolTip) Or _
                Trim(txtWorkEmail.Text) <> Trim(txtWorkEmail.ToolTip) Or _
                Trim(txtDispName.Text) <> Trim(txtDispName.ToolTip) Or _
                Trim(txtLegalName.Text) <> Trim(txtLegalName.ToolTip) Or _
                cmbEthnicity.SelectedValue <> txtHEthnicity.Text Or _
                cmbEmpReferral.SelectedValue <> Trim(txtHEmpReferral.Text) Or _
                cmbI9Status.SelectedValue <> txtHI9Status.Text Or _
                Trim(txtAlienNo.Text) <> Trim(txtAlienNo.ToolTip) Or _
                Trim(txtExpDate.Text) <> Trim(txtExpDate.ToolTip) Or _
                Trim(txtI9Notes.Text) <> Trim(txtI9Notes.ToolTip) Or _
                cmbFedMarital.SelectedValue <> txtHFedMarital.Text Or _
                cmbStateMarital.SelectedValue <> txtHStateMarital.Text Or _
                Trim(txtFedDed.Text) <> Trim(txtFedDed.ToolTip) Or _
                Trim(txtStateDed.Text) <> Trim(txtStateDed.ToolTip) Or _
                Trim(txtFedExempNo.Text) <> Trim(txtFedExempNo.ToolTip) Or _
                Trim(txtStateExempNo.Text) <> Trim(txtStateExempNo.ToolTip) Or _
                chkFedClEx.Checked <> chkFedClEx.ToolTip Or _
                chkStateClEx.Checked <> chkStateClEx.ToolTip Or _
                cmbA4Ded.SelectedValue <> Trim(txtHA4Ded.Text) Or _
                Trim(txtW4Notes.Text) <> Trim(txtW4Notes.ToolTip) Or _
                chkSSNOk.Checked <> chkSSNOk.ToolTip Or _
                Trim(txtPEmail.Text) <> Trim(txtPEmail.ToolTip) Or _
                cmbEducation.SelectedValue <> txtHEducation.Text Or _
                cmbRecruiter.SelectedValue <> txtHRecruiter.Text Or _
                txtPrevCompany.Text <> txtPrevCompany.ToolTip Then

                IsPageDirty = True
            Else
                IsPageDirty = False
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Function
    Private Sub cmdReview_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdReview.Click
        Try
            objData = New clsData
            objData.ConnectionString = Application("ConnString")

            With objData
                .AppendOutputParm()
                .AppendParameter("@ECId", "Integer", 4, txtId.Value)
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

                .AddAttribute("sAMAccountName", txtLoginName.Text)
                .AddAttribute("displayName", txtDispName.Text)
                .AddAttribute("employeeid", txtClockId.Text)
                .AddAttribute("GivenName", txtFName.Text)
                .AddAttribute("sn", txtLName.Text)
                .AddAttribute("StreedAddress", txtAdd1.Text & ", " & txtAdd2.Text)
                .AddAttribute("l", txtCity.Text)
                .AddAttribute("st", cmbState.SelectedItem.Text)
                .AddAttribute("PostalCode", txtZip.Text)
                .AddAttribute("telephonenumber", txtWorkPh.Text)
                .AddAttribute("mail", txtWorkEmail.Text)
                .AddAttribute("physicalDeliveryOfficeName", txtStore.Text)
                '.AddAttribute("department", cmbJobCode.SelectedValue.ToString & " - " & cmbJobCode.SelectedItem.Text)
                .AddAttribute("title", cmbJobTitle.SelectedItem.Text)
                .AddAttribute("mobile", txtCellPh.Text)

                If cmbManager.SelectedValue > 0 Then
                    Dim strMan As String
                    strMan = GetManager()
                    If strMan <> "" Then
                        .AddAttribute("manager", strMan)
                    End If
                End If

                If Not .SaveAttributes() Then
                    Call DisplayStatus("UpdateADSFields : " & objADS.ErrMsg, True)
                End If

            End With
            objADS = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub
    Private Function GetManager() As String
        Try
            Dim objADS As clsADS
            objADS = New clsADS

            With objADS
                .UserLogin = ""
                .UserClockId = cmbManager.SelectedValue
                If .LoadUser Then
                    GetManager = .GetAttribute("distinguishedName")
                Else
                    GetManager = ""
                End If
            End With

            objADS = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Function
    Private Function CheckADSAccount() As Boolean
        Try
            Dim objADS As clsADS
            objADS = New clsADS

            With objADS
                .UserLogin = ""
                .UserClockId = txtClockId.Text

                If Not .LoadUser Then
                    If Not .CreateUser(Trim(txtLoginName.Text)) Then
                        Call DisplayStatus("CheckADSAccount : " & objADS.ErrMsg, True)
                        Exit Function
                    End If

                    If .LoadUser Then
                        .ResetPassword("cjmain")    ' Default password
                    End If
                End If

            End With

            objADS = Nothing
            CheckADSAccount = True
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Function
    Private Sub SaveGroups()
        Try
            Dim i As Integer

            For i = 0 To lstEmpGroups.Items.Count - 1
                Call AddRemoveGroup(lstEmpGroups.Items(i).Text, True)
            Next
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub
    Private Sub AddRemoveGroup(ByVal strGroup As String, ByVal blnAdd As Boolean)
        Try
            Dim objADS As clsADS
            objADS = New clsADS

            With objADS
                .UserLogin = ""
                .UserClockId = txtClockId.Text
                If Not .LoadUser() Then
                    Call DisplayStatus("AddRemoveGroup : " & objADS.ErrMsg, True)
                    Exit Sub
                End If

                .Group = strGroup
                If Not .LoadGroup() Then
                    Call DisplayStatus("AddRemoveGroup : " & objADS.ErrMsg, True)
                    Exit Sub
                End If

                If blnAdd Then
                    If Not .AddToGroup() Then
                        Call DisplayStatus("AddRemoveGroup : " & objADS.ErrMsg, True)
                    End If
                Else
                    If Not .RemoveFromGroup() Then
                        Call DisplayStatus("AddRemoveGroup : " & objADS.ErrMsg, True)
                    End If
                End If
            End With

            objADS = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub
    Private Sub chkNeedsLogin_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles chkNeedsLogin.CheckedChanged
        Try
            If txtId.Value > 0 Then
                If chkNeedsLogin.Checked Then
                    tblADS.Visible = True
                Else
                    tblADS.Visible = False
                End If
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub
    Private Sub cmdApprove_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdApprove.Click
        Try
            If txtManClockId.Text <= 0 Then
                Call DisplayStatus("ClockId not stored in ADS .. Please check it out", True)
                Call DisplayResultPage()
                Exit Sub
            End If

            'Update for any changes before
            'approving request
            If IsPageDirty() Then
                If Not UpdateData(txtManClockId.Text) Then
                    Call DisplayResultPage()
                    Exit Sub
                End If
            End If

            'Update any job code changes
            Call CreateJobCodeChangeList()
            If IsJobCodeDirty() Then
                Call UpdateJobCodes()
            End If

            'Approve request
            If Not UpdateGMApproval(1, txtManClockId.Text) Then
                Call DisplayResultPage()
                Exit Sub
            Else
                Call SendEmail(2, chkReHire.Checked)
            End If

            'Script to close this window and refresh parent window
            Dim strScript As String
            strScript = "<SCRIPT>window.opener.document.forms(0).txtLoadForm.value = 1; window.opener.document.forms(0).submit(); self.close();</SCRIPT>"
            Page.RegisterClientScriptBlock("CloseMeApprove", strScript)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub
    Private Sub cmdDeny_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdDeny.Click
        Try
            If txtManClockId.Text <= 0 Then
                Call DisplayStatus("ClockId not stored in ADS .. Please check it out", True)
                Call DisplayResultPage()
                Exit Sub
            End If

            'Do not update request and deny it directly
            If cmdDeny.Text = "Deny" Then
                If Not UpdateGMApproval(2, txtManClockId.Text) Then
                    Call DisplayResultPage()
                    Exit Sub
                End If
            Else 'Undo GM Approval, so he can review it again
                If Not UpdateUndoGMApproval() Then
                    Call DisplayResultPage()
                    Exit Sub
                Else
                    'Send an email back to GM and OA
                    Call SendUndoGMApprovalEmail()
                End If
            End If

            'Script to close this window and refresh parent window
            Dim strScript As String
            strScript = "<SCRIPT>window.opener.document.forms(0).txtLoadForm.value = 1; window.opener.document.forms(0).submit(); self.close();</SCRIPT>"
            Page.RegisterClientScriptBlock("CloseMeDeny", strScript)
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
    Private Sub cmdUpdate_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdUpdate.Click
        Try
            If txtManClockId.Text <= 0 Then
                Call DisplayStatus("ClockId not stored in ADS .. Please check it out", True)
                Call DisplayResultPage()
                Exit Sub
            End If

            If Not UpdateData(txtManClockId.Text) Then
                Call DisplayResultPage()
                Exit Sub
            Else
                Call CreateJobCodeChangeList()
                If IsJobCodeDirty() Then
                    Call UpdateJobCodes()
                End If
            End If

            Dim strScript As String
            strScript = "<SCRIPT>window.opener.document.forms(0).txtLoadForm.value = 1; window.opener.document.forms(0).submit(); self.close();</SCRIPT>"
            Page.RegisterClientScriptBlock("CloseMeSubmit", strScript)
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

            'Get ECId, if not present from ClockId
            If txtId.Value <= 0 Then

                objData.ConnectionString = Application("ConnString")

                If Not objData.GetRset("GetReqId 1," & txtClockId.Text) Then
                    Response.Write(objData.ErrMsg)
                Else
                    dsData = objData.RecSet
                End If

                For Each i In dsData.Tables("DataSet").Rows()
                    lngECId = i("EC_Id")
                Next

                dsData = Nothing
                objData = Nothing
            Else
                lngECId = txtId.Value
            End If

            'Save job codes
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

            'Check updated job codes and add missing ones
            'Do not overwrite main office changes
            If blnSuccess And txtSecCode.Value <= 4 Then
                objData = New clsData
                objData.ConnectionString = Application("ConnString")

                With objData
                    .AppendOutputParm()
                    .AppendParameter("@ECId", "Integer", 4, lngECId)
                    .AppendParameter("@ChangeTypeId", "Integer", 4, 1)
                End With

                If Not objData.ExecuteCommand("UpdateReqCheckJobCodes") Then
                    Call DisplayStatus(objData.ErrMsg, True)
                    UpdateJobCodes = False
                Else
                    UpdateJobCodes = True
                End If
            End If

            objData = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Function
    Private Sub CreateJobCodeChangeList()
        Try
            Dim i As Integer
            Dim j As Integer
            Dim blnFound As Boolean
            Dim strItem As String
            Dim strItemOld As String

            For i = 0 To lstJobCode.Items.Count - 1
                blnFound = False
                strItem = Trim(lstJobCode.Items(i).Text.Replace("*", ""))

                For j = 0 To lstOldJobCode.Items.Count - 1
                    strItemOld = Trim(lstOldJobCode.Items(j).Text.Replace("*", ""))

                    If strItem = strItemOld Then
                        Call AddToList(strItem, 0)
                        blnFound = True
                        Exit For
                    End If
                Next

                If Not blnFound Then
                    Call AddToList(strItem, 1)
                End If
            Next

            For i = 0 To lstOldJobCode.Items.Count - 1
                blnFound = False

                strItemOld = Trim(lstOldJobCode.Items(i).Text.Replace("*", ""))

                For j = 0 To lstJobCode.Items.Count - 1
                    strItem = Trim(lstJobCode.Items(j).Text.Replace("*", ""))

                    If strItemOld = strItem Then
                        blnFound = True
                        Exit For
                    End If
                Next

                If Not blnFound Then
                    Call AddToList(strItemOld, 2)
                End If
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
    Private Function IsJobCodeDirty() As Boolean
        Try
            Dim i As Integer
            For i = 0 To objJD.Length - 1
                If objJD(i).intStatus = 1 Or objJD(i).intStatus = 2 Then
                    'If objJD(i).intStatus = 2 Then
                    IsJobCodeDirty = True
                    Exit Function
                End If
            Next
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Function
    Private Sub SendReHireMailToHR()
        Try
            Dim i As DataRow
            Dim strEmpName As String
            Dim strEmpEmail As String
            Dim strEmailList As String
            Dim intUnit As Integer
            Dim strBody As String
            Dim objGeneral As clsGeneral

            objData = New clsData

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
            objGeneral = New clsGeneral
            With objGeneral
                .EmailTo = strEmailList
                .EmailFrom = strEmpName & "(" & strEmpEmail & ")"
                .EmailSubject = "ReHire From Store - " & intUnit

                strBody = "I just submitted a ReHire request for following employee."

                strBody = strBody & vbCrLf & vbCrLf _
                        & "Clock Id      : " & txtClockId.Text & vbCrLf _
                        & "Employee Name : " & txtFName.Text & " " & txtLName.Text & vbCrLf _
                        & "SSN           : " & txtSSN.Text & vbCrLf _
                        & "Last Hire Date: " & txtHireDate.Text

                .EmailBody = strBody
                .SendEMail()
            End With

            objGeneral = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub
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
                .EmailSubject = "New Hire/ReHire - Review Again"

                strBody = "Your approved request for New Hire/ReHire has been sent back to you, please read notes below and approve/deny request again."

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

            Dim blnNeedsLogin As Boolean

            'prepare job code list for sp
            blnNeedsLogin = False
            For j = 0 To objJD.Length - 1
                If strJobCodeList = "" Then
                    strJobCodeList = objJD(j).intJobCode
                Else
                    strJobCodeList = strJobCodeList & "," & objJD(j).intJobCode
                End If

                'If objJD(j).intJobCode <> 1 And objJD(j).intJobCode <> 2 _
                ' And objJD(j).intJobCode <> 3 And objJD(j).intJobCode <> 4 _
                ' And objJD(j).intJobCode <> 5 And objJD(j).intJobCode <> 6 _
                ' And objJD(j).intJobCode <> 7 And objJD(j).intJobCode <> 8 _
                ' And objJD(j).intJobCode <> 9 And objJD(j).intJobCode <> 10 _
                ' And objJD(j).intJobCode <> 11 And objJD(j).intJobCode <> 13 _
                ' And objJD(j).intJobCode <> 15 And objJD(j).intJobCode <> 16 _
                ' And objJD(j).intJobCode <> 17 And objJD(j).intJobCode <> 51 Then

                '    blnNeedsLogin = True
                'End If
            Next

            'Prepare job code list for email
            For j = 0 To lstJobCode.Items.Count - 1
                If strDeptList = "" Then
                    strDeptList = Trim(lstJobCode.Items(j).Text.Substring(0, lstJobCode.Items(j).Text.IndexOf("|") - 1))
                Else
                    strDeptList = strDeptList & " | " & Trim(lstJobCode.Items(j).Text.Substring(0, lstJobCode.Items(j).Text.IndexOf("|") - 1))
                End If
            Next


            If txtSecCode.Value = 8 Then
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

            If Trim(strEmpEmail) <> "" And Trim(strEmailList) <> "" Then

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

                    '& "SSN           : " & txtSSN.Text & vbCrLf _

                    .EmailBody = strBody
                    .SendEMail()
                End With

                objGeneral = Nothing

            End If


            'strEmpName = ""
            'strEmpEmail = ""
            'intUnit = 0
            'strEmailList = ""

            ''Send an email to network admins if the employee needs login and email
            ''based on his job code
            'If blnNeedsLogin Then
            '    objData = New clsData

            '    'Get Email addresses
            '    objData.ConnectionString = Application("ConnString")

            '    If Not objData.GetRset("GetEmailsForCompLogin " & txtManClockId.Text) Then
            '        'MessageBox.Show(objData.ErrMsg)
            '        Exit Function
            '    Else
            '        dsData = objData.RecSet
            '    End If

            '    For Each i In dsData.Tables("DataSet").Rows
            '        strEmpName = FixNull(i(0))
            '        strEmpEmail = FixNull(i(1))
            '        intUnit = FixNull(i(2))
            '        strEmailList = FixNull(i(3))
            '    Next

            '    objData = Nothing
            '    dsData = Nothing

            '    If Trim(strEmpEmail) = "" Or Trim(strEmailList) = "" Then

            '        'Send email
            '        objGeneral = New clsGeneral
            '        With objGeneral
            '            .EmailTo = strEmailList
            '            .EmailFrom = strEmpName & "(" & strEmpEmail & ")"

            '            If blnReHire Then
            '                .EmailSubject = "ReHire From Store - " & intUnit
            '                If intProcessStep = 1 Then
            '                    strBody = "I just created a ReHire request for following employee."
            '                ElseIf intProcessStep = 2 Then
            '                    strBody = "I just approved a ReHire request for following employee."
            '                Else
            '                    strBody = "I just processed a ReHire request for following employee."
            '                End If
            '            Else
            '                .EmailSubject = "New Hire From Store - " & intUnit
            '                If intProcessStep = 1 Then
            '                    strBody = "I just created a New Hire request for following employee."
            '                ElseIf intProcessStep = 2 Then
            '                    strBody = "I just approved a New Hire request for following employee."
            '                Else
            '                    strBody = "I just processed a New Hire request for following employee."
            '                End If
            '            End If

            '            strBody = strBody & vbCrLf & vbCrLf _
            '                    & "Clock Id      : " & txtClockId.Text & vbCrLf _
            '                    & "Employee Name : " & txtFName.Text & " " & txtLName.Text & vbCrLf _
            '                    & "SSN           : " & txtSSN.Text & vbCrLf _
            '                    & "Hire Date     : " & txtHireDate.Text & vbCrLf _
            '                    & "Departments   : " & strDeptList _
            '                    & vbCrLf & vbCrLf & vbCrLf _
            '                    & "This email is generated automatically through HR Express based on certain action."

            '            .EmailBody = strBody
            '            .SendEMail()
            '        End With

            '        objGeneral = Nothing

            '    End If
            'End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Function
End Class