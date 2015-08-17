Imports Web_CJEmployeeInfo.Web_CJEmployeeInfo
Public Class ChangeDepRate
    Inherits System.Web.UI.Page

    Dim objData As New clsData
    Dim objGeneral As New clsGeneral
    Dim dsData As New DataSet
    Dim strError As String
    Dim strStatus As String
    Dim strPrimaryJobCode As String

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
                txtClockId.Value = Request.Item("CId")
                txtFormType.Value = Request.Item("FT")
                txtId.Value = Request.Item("Id")

                tblCompany.Visible = False
                tblGMUndoApproval.Visible = False

                tblPendReq1.Visible = False

                If txtFormType.Value = 0 Then     'Change Department - Pay Rate
                    tblStore.Visible = False
                    tblTempLocation.Visible = False
                    'tblLine.Visible = False
                    lblHead.Text = "Change Department - Pay Rate"
                    txtChangeReason.Visible = False
                    cmbChangeReason.Visible = True

                    Call LoadChangeReason()

                    'On request create time, check for any pending requests
                    If txtId.Value <= 0 Then
                        Call CheckPendingRequests()
                    End If

                Else                            'Employee Transfer
                    lblHead.Text = "Transfer Employee"
                    txtChangeReason.Visible = True
                    cmbChangeReason.Visible = False
                    Call LoadStores()
                End If

                Call LoadEmpDetails()
                Call LoadEmpJobCodes()

                Call GetManClockId()
                Call LoadEmpSecurity()
                Call LoadJobCodes()

                If txtId.Value > 0 Then
                    tblDepartment.Visible = True
                    lblDepartment.Text = "Requested Department - Pay Rate :"

                    'Allow GM, AGM & HR Admin to approve/deny requests
                    If txtSecCode.Value = 3 Or txtSecCode.Value = 4 Or _
                        txtSecCode.Value = 9 Or txtSecCode.Value = 10 Then
                        cmdApprove.Visible = True
                        cmdDeny.Visible = True
                        cmdPost.Visible = False
                        cmdSubmit.Visible = False
                        'cmdreview.visible = false
                    Else
                        cmdApprove.Visible = False
                        cmdDeny.Visible = False

                        cmdPost.Visible = True
                        'cmdReview.Visible = True
                        cmdSubmit.Visible = False

                        If txtFormType.Value > 0 Then      'Employee transfer form
                            tblCompany.Visible = True
                            Call LoadCompany()
                        End If
                    End If

                    'Allow Payroll Payroll Admin, HR Supervisor to deny 
                    'Request before post
                    If txtSecCode.Value = 5 Or txtSecCode.Value = 6 Then
                        cmdDeny.Visible = True
                        cmdDeny.Text = "Undo Approval"
                        tblGMUndoApproval.Visible = True
                    End If

                Else
                    'tblDepartment.Visible = False
                    cmdPost.Visible = False
                    'cmdReview.Visible = False
                    cmdSubmit.Visible = True
                    cmdApprove.Visible = False
                    cmdDeny.Visible = False
                End If

                '------commented by hemangini on 11/8/2015
                'If txtFormType.Value = 0 And txtId.Value = 0 Then
                '    tblLine.Visible = False
                'Else
                '    tblLine.Visible = True
                'End If
                '----------------------------

                cmdSubmit.Attributes.Add("onclick", "if(ValidateSubmit()){this.value = 'Please Wait'; this.disabled=true; " & GetPostBackEventReference(cmdSubmit).ToString & "} else{return false;}")
                cmdPost.Attributes.Add("onclick", "if(ValidatePost()){this.value = 'Please Wait'; this.disabled=true; " & GetPostBackEventReference(cmdPost).ToString & "} else{return false;}")
                cmdApprove.Attributes.Add("onclick", "if(ValidateApproveDeny(1)){this.value = 'Please Wait'; this.disabled=true; " & GetPostBackEventReference(cmdApprove).ToString & "} else{return false;}")
                cmdDeny.Attributes.Add("onclick", "if(ValidateApproveDeny(2)){this.value = 'Please Wait'; this.disabled=true; " & GetPostBackEventReference(cmdDeny).ToString & "} else{return false;}")
                cmdViewPendReq.Attributes.Add("onclick", "ViewPendReq();")
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

            With cmbToStore
                .DataSource = Application("Store") 'dsData.Tables("DataSet")
                .DataTextField = "Store"
                .DataValueField = "StoreNo"
                .DataBind()
                .Items.Insert(0, New ListItem("", "0"))
            End With

            'If txtFormType.Value > 0 Then
            '    With cmbTempUnit
            '        .DataSource = dsData.Tables("DataSet")
            '        .DataTextField = "Store"
            '        .DataValueField = "StoreNo"
            '        .DataBind()
            '        .Items.Insert(0, New ListItem("", "0"))
            '    End With
            'End If

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
    Private Sub LoadEmpDetails()
        Try
            objGeneral = New clsGeneral

            With objGeneral
                .ConnectionString = Application("ConnString")
                .ClockId = txtClockId.Value

                lblEmp.Text = objGeneral.GetEmpDetails
                txtEmpName.Value = objGeneral.EmpName
                txtEmpUnit.Value = objGeneral.Unit

                If txtFormType.Value = 1 Then    'Transfer Employee
                    txtFromStore.Text = .UnitCity
                End If
            End With

            objGeneral = Nothing
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
                .ClockId = txtManClockId.Value
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
    Private Sub LoadJobCodes()
        Try
            If txtSecCode.Value <= 4 Then
                objData = New clsData
                dsData = New DataSet

                objData.ConnectionString = Application("ConnString")

                If Not objData.GetRset("GetAllJobCodeListWithPayRange " & txtEmpUnit.Value) Then
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
    Private Sub LoadChangeReason()
        Try
            'objData = New clsData

            'objData.ConnectionString = Application("ConnString")

            'If Not objData.GetRset("GetItemList 'PayRateChange'") Then
            '    'MessageBox.Show(objData.ErrMsg)
            'Else
            '    dsData = objData.RecSet
            'End If

            With cmbChangeReason
                .DataSource = Application("ChangeReason") 'dsData.Tables("DataSet")
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
    Private Sub CheckPendingRequests()
        Try
            Dim lngReturnCode As Long

            objData = New clsData
            objData.ConnectionString = Application("ConnString")

            With objData
                .AppendOutputParm()
                .AppendParameter("@ClockId", "Integer", 4, txtClockId.Value)
            End With

            If Not objData.ExecuteCommand("CheckPedingDepRateReq") Then
                Call DisplayStatus(objData.ErrMsg, True)
            Else
                lngReturnCode = objData.ReturnCode
            End If

            objData = Nothing

            If lngReturnCode = 1 Then
                lblPendingReq.Text = "There is a similar request pending for this employee. It is recommended that you wait until this pending request gets processed."
                tblPendReq1.Visible = True
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub
    Private Sub LoadEmpJobCodes()
        Try
            Dim i As DataRow
            Dim j As Integer
            objData = New clsData

            objData.ConnectionString = Application("ConnString")

            If Not objData.GetRset("GetEmpJobCode " & txtClockId.Value) Then
                'MessageBox.Show(objData.ErrMsg)
            Else
                dsData = objData.RecSet
            End If

            If txtId.Value = 0 Then  ' New Request
                j = 0
                For Each i In dsData.Tables("DataSet").Rows
                    If i("Primary") Then
                        lstJobCode.Items.Insert(j, New ListItem(i("JobCode") & "  |  " & i("PayRate") & "  |  Primary", i("JobCode")))
                        lstOldJobCode.Items.Insert(j, New ListItem(i("JobCode") & "  |  " & i("PayRate") & "  |  Primary", i("JobCode")))
                    Else
                        lstJobCode.Items.Insert(j, New ListItem(i("JobCode") & "  |  " & i("PayRate"), i("JobCode")))
                        lstOldJobCode.Items.Insert(j, New ListItem(i("JobCode") & "  |  " & i("PayRate"), i("JobCode")))
                    End If
                    j = j + 1
                Next

                grdDept.DataSource = dsData.Tables("DataSet")
                grdDept.DataBind()

            Else                    ' Modify Request ü
                grdDept.DataSource = dsData.Tables("DataSet")
                grdDept.DataBind()
                Call LoadRequestDetails()
            End If

            objData = Nothing
            dsData = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub
    Private Sub LoadRequestDetails()
        Try
            Dim i As DataRow
            Dim j As Integer
            objData = New clsData

            objData.ConnectionString = Application("ConnString")

            If txtFormType.Value = 0 Then 'Department/payrate change
                If Not objData.GetRset("GetRequestDetails 3," & txtId.Value) Then
                    'MessageBox.Show(objData.ErrMsg)
                Else
                    dsData = objData.RecSet
                End If

                For Each i In dsData.Tables("DataSet").Rows
                    txtEffDate.Text = FixNull(i("Eff_Date"))
                    txtEffDate.ToolTip = txtEffDate.Text

                    'txtChangeReason.Text = FixNull(i("Change_Reason"))
                    'txtChangeReason.ToolTip = txtChangeReason.Text
                    cmbChangeReason.SelectedValue = FixNull(i("Change_ReasonId"))
                    txtHChangeReason.Text = cmbChangeReason.SelectedValue

                    txtEmpSig.Value = FixNull(i("Person_Sig"))
                    Exit For
                Next

            Else                        ' Employee Transfer
                If Not objData.GetRset("GetRequestDetails 4," & txtId.Value) Then
                    'MessageBox.Show(objData.ErrMsg)
                Else
                    dsData = objData.RecSet
                End If

                For Each i In dsData.Tables("DataSet").Rows
                    txtEffDate.Text = FixNull(i("Eff_Date"))
                    txtEffDate.ToolTip = txtEffDate.Text

                    txtChangeReason.Text = FixNull(i("Change_Reason"))
                    txtChangeReason.ToolTip = txtChangeReason.Text

                    cmbToStore.SelectedValue = FixNull(i("Unit"))
                    txtHToStore.Text = cmbToStore.SelectedValue

                    cmbTempUnit.SelectedValue = i("TempUnit")
                    txtHTempUnit.Text = cmbTempUnit.SelectedValue

                    txtTempSDate.Text = FixNull(i("TempSDate"))
                    txtTempSDate.ToolTip = txtTempSDate.Text

                    txtTempEDate.Text = FixNull(i("TempEDate"))
                    txtTempEDate.ToolTip = txtTempEDate.Text

                    txtEmpSig.Value = FixNull(i("Person_Sig"))
                    Exit For
                Next
            End If

            j = 0
            For Each i In dsData.Tables("DataSet").Rows
                If i("Primary") Then
                    If i("RowModified") = 1 Then
                        lstJobCode.Items.Insert(j, New ListItem(i("JobCode") & "  |  " & i("PayRate") & "  |  Primary  *", i("JobCode")))
                        lstOldJobCode.Items.Insert(j, New ListItem(i("JobCode") & "  |  " & i("PayRate") & "  |  Primary  *", i("JobCode")))
                    Else
                        lstJobCode.Items.Insert(j, New ListItem(i("JobCode") & "  |  " & i("PayRate") & "  |  Primary", i("JobCode")))
                        lstOldJobCode.Items.Insert(j, New ListItem(i("JobCode") & "  |  " & i("PayRate") & "  |  Primary", i("JobCode")))
                    End If
                Else
                    If i("RowModified") = 1 Then
                        lstJobCode.Items.Insert(j, New ListItem(i("JobCode") & "  |  " & i("PayRate") & "  *", i("JobCode")))
                        lstOldJobCode.Items.Insert(j, New ListItem(i("JobCode") & "  |  " & i("PayRate") & "  *", i("JobCode")))
                    Else
                        lstJobCode.Items.Insert(j, New ListItem(i("JobCode") & "  |  " & i("PayRate"), i("JobCode")))
                        lstOldJobCode.Items.Insert(j, New ListItem(i("JobCode") & "  |  " & i("PayRate"), i("JobCode")))

                    End If
                End If
                j = j + 1
            Next

            objData = Nothing
            dsData = Nothing
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
                strPrimaryJobCode = strDummy(0) 'For ADS saving
            Else
                objJD(i).blnPrimary = False
            End If

            objJD(i).intStatus = intStatus
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub
    Private Function SaveEmpChanges(ByVal lngClockId As Long) As Long
        Try
            Dim lngReturnCode As Long

            If txtFormType.Value = 0 Then 'Department/Payrate change
                objData = New clsData
                objData.ConnectionString = Application("ConnString")

                With objData
                    .AppendOutputParm()
                    .AppendParameter("@ECId", "Integer", 4, txtId.Value)
                    .AppendParameter("@ChangeTypeId", "Integer", 4, 3)  'Job Department Change
                    .AppendParameter("@ClockId", "Integer", 4, txtClockId.Value)
                    .AppendParameter("@ChangeReason", "Char", 1000, "")
                    .AppendParameter("@ChangeReasonId", "Integer", 4, cmbChangeReason.SelectedValue)
                    .AppendParameter("@EffDate", "Date", 4, txtEffDate.Text)
                    .AppendParameter("@EmpId", "Integer", 4, lngClockId)
                End With

                If Not objData.ExecuteCommand("UpdateEmpChanges") Then
                    Call DisplayStatus(objData.ErrMsg, True)
                Else
                    If txtId.Value = 0 Then
                        lngReturnCode = objData.ReturnCode
                    Else
                        lngReturnCode = txtId.Value  'assign existing id
                    End If
                End If

            Else        'Employee Transfer
                lngReturnCode = UpdateEmpTransfer(lngClockId)

                If lngReturnCode = -1 Then
                    Call DisplayStatus("Transfer request has already been made for this employee | Please check Transfer report to get more details | You can not submit second transfer request, when the first one is open", True)
                    lngReturnCode = 0
                Else
                    If txtId.Value > 0 Then
                        lngReturnCode = txtId.Value
                    End If
                End If
            End If

            objData = Nothing
            Return lngReturnCode
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Function
    Private Function SaveJobCodes(ByVal lngECId As Long) As Boolean
        Try
            Dim i As Integer
            Dim blnSuccess As Boolean

            For i = 0 To objJD.Length - 1
                objData = New clsData
                objData.ConnectionString = Application("ConnString")

                With objData
                    .AppendOutputParm()
                    .AppendParameter("@ECId", "Integer", 4, lngECId)
                    .AppendParameter("@JobCode", "Integer", 4, objJD(i).intJobCode)
                    .AppendParameter("@PayRate", "Currency", 4, objJD(i).dblPayRate)
                    .AppendParameter("@Primary", "Bit", 1, objJD(i).blnPrimary)
                    .AppendParameter("@EJCAction", "Integer", 4, objJD(i).intStatus)
                End With

                If Not objData.ExecuteCommand("UpdateEmpJobChanges") Then
                    Call DisplayStatus(objData.ErrMsg, True)
                    blnSuccess = False
                Else
                    blnSuccess = True
                End If

                objData = Nothing
            Next

            'Check all job codes and add any missing ones
            'Do not overwrite main office changes only store users
            If blnSuccess And txtSecCode.Value <= 4 Then
                objData = New clsData
                objData.ConnectionString = Application("ConnString")

                With objData
                    .AppendOutputParm()
                    .AppendParameter("@ECId", "Integer", 4, lngECId)
                    If txtFormType.Value = 0 Then
                        .AppendParameter("@ChangeTypeId", "Integer", 4, 3)
                    Else
                        .AppendParameter("@ChangeTypeId", "Integer", 4, 4)
                    End If
                End With

                If Not objData.ExecuteCommand("UpdateReqCheckJobCodes") Then
                    Call DisplayStatus(objData.ErrMsg, True)
                    SaveJobCodes = False
                Else
                    SaveJobCodes = True
                End If

                objData = Nothing
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Function
    Private Function SaveSignatures(ByVal lngECId As Long) As Boolean
        Try
            'Update signatures
            objData = New clsData
            objData.ConnectionString = Application("ConnString")

            With objData
                .AppendOutputParm()
                .AppendParameter("@ECId", "Integer", 4, lngECId)
                .AppendParameter("@ClockId", "Integer", 4, txtClockId.Value)
                .AppendParameter("@PSig", "Char", 6000, txtEmpSig.Value)
            End With

            If Not objData.ExecuteCommand("UpdateEmpChangeSig") Then
                Call DisplayStatus(objData.ErrMsg, True)
                SaveSignatures = False
            Else
                SaveSignatures = True
            End If

            objData = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Function
    Private Sub cmdSubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdSubmit.Click
        Try
            If txtManClockId.Value > 0 Then
                If UpdateData(txtManClockId.Value) Then
                    ''   Call SendEmail(1)
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
            Dim blnIsPageDirty As Boolean
            Dim blnIsJobCodeDirty As Boolean
            Dim lngId As Long

            Dim i As Integer
            Dim blnChanges As Boolean

            'Prepare list for any job code changes
            '-----------------------comment for test
            Call CreateJobCodeChangeList()
            '     CreateJobCodeChangeList_Test()
            If txtId.Value = 0 Then  ' New Request

                'Check if there are job changes otherwise 
                'don't submit request
                blnChanges = False
                For i = 0 To objJD.Length - 1
                    If objJD(i).intStatus > 0 Then
                        blnChanges = True
                        Exit For
                    End If
                Next i

                If txtFormType.Value = 1 Or (txtFormType.Value = 0 And blnChanges) Then
                    lngId = SaveEmpChanges(lngClockId)
                    If lngId > 0 Then
                        If SaveJobCodes(lngId) Then
                            If SaveSignatures(lngId) Then
                                Call DisplayStatus("Request has been submitted successfully", False)
                                UpdateData = True
                            End If
                        End If
                    Else
                        UpdateData = False
                    End If
                Else
                    Call DisplayStatus("No changes are made to Pay Rate/Department .. Please check it out", True)
                End If
            Else                    ' Modify Request
                blnIsPageDirty = IsPageDirty()
                blnIsJobCodeDirty = IsJobCodeDirty()

                If blnIsPageDirty Or blnIsJobCodeDirty Then
                    lngId = SaveEmpChanges(lngClockId)
                    If blnIsJobCodeDirty And lngId > 0 Then
                        If SaveJobCodes(lngId) Then
                            Call DisplayStatus("Request has been updated successfully", False)
                            UpdateData = True
                        End If
                    Else
                        If lngId > 0 Then
                            Call DisplayStatus("Request has been updated successfully", False)
                            UpdateData = True
                        End If
                    End If
                End If
            End If
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

    Private Sub CreateJobCodeChangeList()
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
    End Sub
    Private Sub CreateJobCodeChangeList_Test()
        Dim i As Integer
        Dim j As Integer
        Dim blnFound As Boolean
        Dim strItem As String
        Dim strItemOld As String

        For i = 0 To lstJobCode.Items.Count - 1
            blnFound = False
            strItem = Trim(lstJobCode.Items(i).Text.Replace("*", ""))

            For j = 0 To lstOldJobCode.Items.Count - 1
                strItemOld = Trim(lstJobCode.Items(j).Text.Replace("*", ""))

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

        For i = 0 To lstJobCode.Items.Count - 1
            blnFound = False

            strItemOld = Trim(lstJobCode.Items(i).Text.Replace("*", ""))

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
    End Sub
    Private Function UpdateEmpTransfer(ByVal lngClockId As Long) As Long
        objData = New clsData
        objData.ConnectionString = Application("ConnString")

        With objData
            .AppendOutputParm()

            .AppendParameter("@ECId", "Integer", 4, txtId.Value)
            .AppendParameter("@ChangeTypeId", "Integer", 4, 4)
            .AppendParameter("@ClockId", "Integer", 4, txtClockId.Value)
            .AppendParameter("@ChangeReason", "Char", 1000, txtChangeReason.Text)
            .AppendParameter("@EffDate", "Date", 4, txtEffDate.Text)

            .AppendParameter("@Unit", "Integer", 4, cmbToStore.SelectedValue)
            .AppendParameter("@TempUnit", "Integer", 4, 0)
            .AppendParameter("@TempSDate", "Date", 4, GetValue(txtTempSDate.Text, "Date"))
            .AppendParameter("@TempEDate", "Date", 4, GetValue(txtTempEDate.Text, "Date"))

            .AppendParameter("@Notes", "Char", 2000, "")
            .AppendParameter("@EmpSig", "Char", 6000, "")
            .AppendParameter("@EmpId", "Integer", 4, lngClockId)
        End With

        If Not objData.ExecuteCommand("UpdateEmpTransfer") Then
            Call DisplayStatus(objData.ErrMsg, True)
            'UpdateEmpTransfer = -1
        Else
            UpdateEmpTransfer = objData.ReturnCode
        End If

        objData = Nothing
    End Function

    Private Function FixNull(ByVal dbvalue) As String
        If dbvalue Is DBNull.Value Then
            Return ""
        Else
            Return dbvalue.ToString
        End If
    End Function

    Private Function GetValue(ByVal DBValue As String, ByVal DBType As String) As Object
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
                Return Trim(DBValue)
            End If
        End If
    End Function

    Private Sub DisplayStatus(ByVal strMessage As String, ByVal blnError As Boolean)

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

    End Sub

    Private Sub DisplayResultPage()
        Dim strURL As String

        If strError <> "" Then
            strURL = "E=1&EM=" & strError & "&M=" & strStatus
        Else
            strURL = "E=0&EM=" & strError & "&M=" & strStatus
        End If

        Response.Redirect("Result.aspx?" & strURL)
    End Sub

    Private Sub cmdPost_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdPost.Click

        If txtManClockId.Value <= 0 Then
            Call DisplayStatus("ClockId is not stored in ADS .. Please check it out", True)
            Call DisplayResultPage()
            Exit Sub
        End If

        'If employee transfer then save company
        If txtFormType.Value > 0 Then
            If Not UpdateCompany() Then
                Call DisplayStatus("Error updating company .. Please contact IT", True)
                Call DisplayResultPage()
                Exit Sub
            End If
        End If

        'Save changes first if any
        Call UpdateData(txtManClockId.Value)

        'Save ADS Groups
        'If CheckADSAccount() Then
        '    Call UpdateADSJobCode()

        '    'Transfer employee, Remove old groups 
        '    'and assign new groups
        '    If txtFormType.Value <> 0 Then
        '        'Call SaveGroups()
        '    End If
        'End If

        'Post Request
        objData = New clsData
        objData.ConnectionString = Application("ConnString")

        With objData
            .AppendOutputParm()
            .AppendParameter("@ECId", "Integer", 4, txtId.Value)
            If txtFormType.Value = 0 Then    ' Department/Pay Rate change
                .AppendParameter("@ChangeTypeId", "Integer", 4, 3)
            Else    ' Emp Transfer
                .AppendParameter("@ChangeTypeId", "Integer", 4, 4)
            End If
            .AppendParameter("@EmpId", "Integer", 4, txtManClockId.Value)
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
                Call SendEmail(3)
            End If
        End If

        objData = Nothing

        Dim strScript As String
        strScript = "<SCRIPT>window.opener.document.forms(0).txtLoadForm.value = 1; window.opener.document.forms(0).submit(); self.close();</SCRIPT>"
        Page.RegisterClientScriptBlock("CloseMeSubmit", strScript)
    End Sub

    Private Function CheckADSAccount() As Boolean
        Dim objADS As clsADS
        objADS = New clsADS

        With objADS
            .UserLogin = ""
            .UserClockId = txtClockId.Value

            If .LoadUser Then
                CheckADSAccount = True
            End If
        End With

        objADS = Nothing
    End Function

    Private Sub UpdateADSJobCode()
        Dim objADS As clsADS

        objADS = New clsADS

        With objADS
            .UserLogin = ""
            .UserClockId = txtClockId.Value

            If Not .LoadUser Then
                Call DisplayStatus("UpdateAdSFields : " & objADS.ErrMsg, True)
                Exit Sub
            End If

            .AddAttribute("department", strPrimaryJobCode)

            If Not .SaveAttributes() Then
                Call DisplayStatus("UpdateADSFields : " & objADS.ErrMsg, True)
            End If

        End With
        objADS = Nothing
    End Sub

    Private Function IsPageDirty() As Boolean
        If txtFormType.Value = 0 Then 'Department /Pay Rate Change

            If txtEffDate.Text <> txtEffDate.ToolTip Or _
                Trim(cmbChangeReason.SelectedValue) <> txtHChangeReason.Text Then

                IsPageDirty = True
            End If

        Else                        ' Employee Transfer
            If txtEffDate.Text <> txtEffDate.ToolTip Or _
                Trim(txtChangeReason.Text) <> txtChangeReason.ToolTip Or _
                cmbToStore.SelectedValue <> txtHToStore.Text Or _
                cmbTempUnit.SelectedValue <> txtHTempUnit.Text Or _
                txtTempSDate.Text <> txtTempSDate.ToolTip Or _
                txtTempEDate.Text <> txtTempEDate.ToolTip Then

                IsPageDirty = True
            End If
        End If
    End Function

    Private Function IsJobCodeDirty() As Boolean
        Dim i As Integer
        For i = 0 To objJD.Length - 1
            If objJD(i).intStatus = 1 Or objJD(i).intStatus = 2 Then
                IsJobCodeDirty = True
                Exit Function
            End If
        Next
    End Function

    Private Sub cmdReview_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdReview.Click
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
                txtManClockId.Value = strClockId
            Else
                txtManClockId.Value = 0
            End If

            objADS = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Sub cmdApprove_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdApprove.Click

        If txtManClockId.Value <= 0 Then
            Call DisplayStatus("ClockId not stored in ADS .. Please check it out", True)
            Call DisplayResultPage()
            Exit Sub
        End If

        'Update for any changes before
        'approving request
        Call UpdateData(txtManClockId.Value)

        'Approve request
        If Not UpdateGMApproval(1, txtManClockId.Value) Then
            Call DisplayResultPage()
            Exit Sub
        Else
            Call SendEmail(2)
        End If

        'Script to close this window and refresh parent window
        Dim strScript As String
        strScript = "<SCRIPT>window.opener.document.forms(0).txtLoadForm.value = 1; window.opener.document.forms(0).submit(); self.close();</SCRIPT>"
        Page.RegisterClientScriptBlock("CloseMeApprove", strScript)
    End Sub

    Private Sub cmdDeny_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdDeny.Click

        If txtManClockId.Value <= 0 Then
            Call DisplayStatus("ClockId not stored in ADS .. Please check it out", True)
            Call DisplayResultPage()
            Exit Sub
        End If

        'Do not update request and deny it directly
        If cmdDeny.Text = "Deny" Then
            If Not UpdateGMApproval(2, txtManClockId.Value) Then
                Call DisplayResultPage()
                Exit Sub
            End If
        Else    'Undo Approval and send request for review again
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
    End Sub

    Private Function UpdateUndoGMApproval() As Boolean
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
    End Function

    Private Function UpdateGMApproval(ByVal intStatus As Integer, ByVal lngClockId As Long) As Boolean
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
            'If intStatus = 1 Then
            'Call DisplayStatus("Request has been Approved successfully", False)
            'Else
            '    Call DisplayStatus("Request has been Denied successfully", False)
            'End If
            UpdateGMApproval = True
        End If

        objData = Nothing
    End Function

    Private Sub SendUndoGMApprovalEmail()
        Dim i As DataRow
        Dim strEmpName As String
        Dim strEmpEmail As String
        Dim strEmailList As String
        Dim strBody As String
        Dim objGeneral As clsGeneral

        objData = New clsData

        'Get Email addresses
        objData.ConnectionString = Application("ConnString")

        If Not objData.GetRset("GetEmailsForUndoGMApproval " & txtManClockId.Value & "," & txtId.Value) Then
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

            If txtFormType.Value = 0 Then
                .EmailSubject = "Dept/PayRate Change - Review Again"
                strBody = "Your approved request for Dept/Pay Rate Change has been sent back to you, please read notes below and approve/deny request again."
            Else
                .EmailSubject = "Transfer - Review Again"
                strBody = "Your approved request for Transfer has been sent back to you, please read notes below and approve/deny request again."
            End If

            strBody = strBody & vbCrLf & vbCrLf _
                    & "Clock Id      : " & txtClockId.Value & vbCrLf _
                    & "Employee Name : " & txtEmpName.Value & vbCrLf _
                    & "Notes         : " & txtUndoNotes.Text _
                    & vbCrLf & vbCrLf & vbCrLf _
                    & "This email is generated automatically through HR Express based on certain action."

            .EmailBody = strBody
            .SendEMail(1)
        End With

        objGeneral = Nothing
    End Sub

    Private Function SendEmail(ByVal intProcessStep As Integer) As Boolean
        Dim j As Integer
        Dim i As DataRow
        Dim strEmpName As String
        Dim strEmpEmail As String
        Dim strEmailList As String
        Dim strBody As String
        Dim objGeneral As clsGeneral
        Dim intUnit As Integer

        Dim strJobCodeList As String
        Dim strNewDeptList As String
        Dim strOldDeptList As String

        For j = 0 To objJD.Length - 1
            If strJobCodeList = "" Then
                strJobCodeList = objJD(j).intJobCode
            Else
                strJobCodeList = strJobCodeList & "," & objJD(j).intJobCode
            End If
        Next

        For j = 0 To lstJobCode.Items.Count - 1
            If strNewDeptList = "" Then
                strNewDeptList = Trim(lstJobCode.Items(j).Text.Substring(0, lstJobCode.Items(j).Text.IndexOf("|") - 1))
            Else
                strNewDeptList = strNewDeptList & " | " & Trim(lstJobCode.Items(j).Text.Substring(0, lstJobCode.Items(j).Text.IndexOf("|") - 1))
            End If
        Next

        For j = 0 To lstOldJobCode.Items.Count - 1
            If strOldDeptList = "" Then
                strOldDeptList = Trim(lstOldJobCode.Items(j).Text.Substring(0, lstOldJobCode.Items(j).Text.IndexOf("|") - 1))
            Else
                strOldDeptList = strOldDeptList & " | " & Trim(lstOldJobCode.Items(j).Text.Substring(0, lstOldJobCode.Items(j).Text.IndexOf("|") - 1))
            End If
        Next

        objData = New clsData

        'Get Email addresses
        objData.ConnectionString = Application("ConnString")

        If txtFormType.Value = 0 Then
            If Not objData.GetRset("GetEmailsForDeptPayChange " & txtManClockId.Value & ",'" & strJobCodeList & "'," & txtEmpUnit.Value & "," & intProcessStep) Then
                'MessageBox.Show(objData.ErrMsg)
                Exit Function
            Else
                dsData = objData.RecSet
            End If
        Else
            If Not objData.GetRset("GetEmailsForTransfer " & txtManClockId.Value & ",'" & strJobCodeList & "'," & txtEmpUnit.Value & "," & intProcessStep) Then
                'MessageBox.Show(objData.ErrMsg)
                Exit Function
            Else
                dsData = objData.RecSet
            End If
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

            If txtFormType.Value = 0 Then       'Dept Pay Change
                .EmailSubject = "Dept/PayRate Change From Store - " & intUnit

                If intProcessStep = 1 Then
                    strBody = "I just created a Dept/PayRate Change request for following employee."
                ElseIf intProcessStep = 2 Then
                    strBody = "I just approved a Dept/PayRate Change request for following employee."
                Else
                    strBody = "I just processed a Dept/PayRate Change request for following employee."
                End If

                strBody = strBody & vbCrLf & vbCrLf _
                        & "Clock Id        : " & txtClockId.Value & vbCrLf _
                        & "Employee Name   : " & txtEmpName.Value & vbCrLf _
                        & "Date Effective  : " & txtEffDate.Text & vbCrLf _
                        & "Change Reason   : " & cmbChangeReason.SelectedItem.Text & vbCrLf _
                        & "Old Departments : " & strOldDeptList & vbCrLf _
                        & "New Departments : " & strNewDeptList _
                        & vbCrLf & vbCrLf & vbCrLf _
                        & "This email is generated automatically through HR Express based on certain action."
            Else
                .EmailSubject = "Transfer From Store - " & intUnit

                If intProcessStep = 1 Then
                    strBody = "I just created a Transfer request for following employee."
                ElseIf intProcessStep = 2 Then
                    strBody = "I just approved a Transfer request for following employee."
                Else
                    strBody = "I just processed a Transfer request for following employee."
                End If

                strBody = strBody & vbCrLf & vbCrLf _
                    & "Clock Id        : " & txtClockId.Value & vbCrLf _
                    & "Employee Name   : " & txtEmpName.Value & vbCrLf _
                    & "From Store      : " & txtFromStore.Text & vbCrLf _
                    & "To Store        : " & cmbToStore.SelectedItem.Text & vbCrLf _
                    & "Date Effective  : " & txtEffDate.Text & vbCrLf _
                    & "Old Departments : " & strOldDeptList & vbCrLf _
                    & "New Departments : " & strNewDeptList & vbCrLf _
                    & vbCrLf & vbCrLf & vbCrLf _
                    & "This email is generated automatically through HR Express based on certain action."

                '& "Temp Store      : " & cmbTempUnit.SelectedItem.Text & vbCrLf _
                '& "From Date       : " & txtTempSDate.Text & vbCrLf _
                '& "To Date         : " & txtTempEDate.Text & vbCrLf _
                '& "Transfer Notes  : " & txtChangeReason.Text _

            End If

            .EmailBody = strBody
            .SendEMail()
        End With

        objGeneral = Nothing
    End Function
End Class