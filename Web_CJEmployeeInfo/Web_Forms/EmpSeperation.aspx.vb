Imports Web_CJEmployeeInfo.Web_CJEmployeeInfo

Public Class EmpSeperation
    Inherits System.Web.UI.Page

    Dim objGeneral As clsGeneral
    Dim objData As clsData
    Dim strError As String
    Dim strStatus As String
    Dim dsData As DataSet

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

        
        If Not IsPostBack Then
            txtClockId.Text = Request.Item("CId")
            txtId.Text = Request.Item("Id")

            Call LoadEmpDetails()
            Call LoadSepReason()

            Call GetManClockId()
            Call LoadEmpSecurity()

            tblUndoGMApproval.Visible = False

            If txtId.Text > 0 Then
                Call LoadReqDetails()
                tblSignLater.Visible = False

                If txtChangeTypeId.Text = 7 Then   'Quick Sep
                    cmdApprove.Visible = False
                    cmdDeny.Visible = False
                    cmdPost.Visible = False
                    cmdSubmit.Visible = False
                    cmdUpdate.Visible = True
                Else
                    'Allow GM, AGM and HR Admin to approve/deny requests
                    If txtSecCode.Text = 3 Or txtSecCode.Text = 4 Or _
                        txtSecCode.Text = 9 Or txtSecCode.Text = 10 Then

                        cmdApprove.Visible = True
                        cmdDeny.Visible = True
                        cmdPost.Visible = False
                        cmdSubmit.Visible = False
                        tblAdd.Visible = False
                        cmdUpdate.Visible = False
                    Else
                        cmdSubmit.Visible = False
                        cmdPost.Visible = True
                        tblAdd.Visible = False
                        cmdApprove.Visible = False
                        cmdDeny.Visible = False
                        cmdUpdate.Visible = False
                    End If

                    'Allow Payroll, Payroll Admin, HR Supervisor to undo approval
                    'before post
                    If txtSecCode.Text = 5 Or txtSecCode.Text = 6 Then
                        cmdDeny.Visible = True
                        cmdDeny.Text = "Undo Approval"
                        tblUndoGMApproval.Visible = True
                    End If
                End If
            Else
                'Get Last day worked from Mineshaft -> AdjTime 
                'first time only
                Call LoadLastDayWorked()

                cmdSubmit.Visible = True
                cmdPost.Visible = False
                cmdApprove.Visible = False
                cmdDeny.Visible = False
                cmdUpdate.Visible = False
            End If

            Call LoadSepCategories()

            cmdSubmit.Attributes.Add("onclick", "if(ValidateSubmit()){this.value = 'Please Wait'; this.disabled=true; " & GetPostBackEventReference(cmdSubmit).ToString & "} else{return false;}")
            cmdUpdate.Attributes.Add("onclick", "if(ValidateUpdate()){this.value = 'Please Wait'; this.disabled=true; " & GetPostBackEventReference(cmdUpdate).ToString & "} else{return false;}")
            cmdPost.Attributes.Add("onclick", "if(ValidatePost()){this.value = 'Please Wait'; this.disabled=true; " & GetPostBackEventReference(cmdPost).ToString & "} else{return false;}")
            cmdApprove.Attributes.Add("onclick", "if(ValidateApproveDeny(1)){this.value = 'Please Wait'; this.disabled=true; " & GetPostBackEventReference(cmdApprove).ToString & "} else{return false;}")
            cmdDeny.Attributes.Add("onclick", "if(ValidateApproveDeny(2)){this.value = 'Please Wait'; this.disabled=true; " & GetPostBackEventReference(cmdDeny).ToString & "} else{return false;}")
            cmbSepReason.Attributes.Add("onchange", "GetCat(this);")
            'cmbSepCat.Attributes.Add("onchange", "GetSubCat(this);")
                'chkSignLater.Attributes.Add("onclick", "SignLater();")    commented by hemangini on 12/8/2015
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Sub LoadEmpDetails()
        Try
            objGeneral = New clsGeneral
            Dim strAdd As String

            With objGeneral
                .ConnectionString = Application("ConnString")
                .ClockId = txtClockId.Text

                lblEmp.Text = objGeneral.GetEmpDetails

                'txtAdd1.Text = .Add1
                'txtAdd2.Text = .Add2
                'txtCity.Text = .City
                'txtState.Text = .State
                'txtZip.Text = .Zip
                'txtHomePh.Text = .HomePh
                txtEmpName.Text = .EmpName
                txtEmpUnit.Text = .Unit

                strAdd = .Add1
                If .Add2 <> "" Then
                    strAdd = strAdd & ", " & .Add2
                End If

                lblEmpAdd.Text = strAdd & ", " & .City & ", " & .State & " " & .Zip
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
                .ClockId = txtManClockId.Text
                If Not .GetEmpSecurity Then
                    txtSecCode.Text = 0
                Else
                    txtSecCode.Text = .SecCode
                    'txtUnit.Value = .Unit
                End If
            End With

            objGeneral = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Sub LoadSepReason()
        Try
            'objData = New clsData
            'objData.ConnectionString = Application("ConnString")

            'If Not objData.GetRset("GetItemList 'EmpSeperation'") Then
            '    'MessageBox.Show(objData.ErrMsg)
            'Else
            '    dsData = objData.RecSet
            'End If

            With cmbSepReason
                .DataSource = Application("EmpSeperation") 'dsData.Tables("DataSet")
                .DataTextField = "Item_Val"
                .DataValueField = "ItemDetail_Id"
                .DataBind()
                .Items.Insert(0, New ListItem("", ""))
            End With

            'objData = Nothing
            'dsData = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Sub LoadLastDayWorked()
        Try
            Dim i As DataRow
            objData = New clsData
            objData.ConnectionString = Application("ConnString")

            If Not objData.GetRset("GetLastDayWorked " & txtClockId.Text) Then
                'MessageBox.Show(objData.ErrMsg)
            Else
                dsData = objData.RecSet
            End If

            For Each i In dsData.Tables("DataSet").Rows()
                txtLastWork.Text = i("LastDOB")
            Next

            objData = Nothing
            dsData = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Sub LoadSepCategories()
        Try
        Dim strJS As String
        Dim dsCatList As DataSet
        'Dim dsSubCatList As DataSet
        Dim i As DataRow
        Dim j As Integer
        Dim k As DataRow

        'Get Seperation Reason's categories
        dsCatList = Application("SepCatList")

        'objData = New clsData
        'objData.ConnectionString = Application("ConnString")

        'If Not objData.GetRset("GetItemCatList") Then
        '    'MessageBox.Show(objData.ErrMsg)
        'Else
        '    dsCatList = objData.RecSet
        'End If

        'objData = Nothing

        'Get Seperation Reason's sub categories
        'dsSubCatList = Application("SepSubCatList")

        'objData = New clsData
        'objData.ConnectionString = Application("ConnString")

        'If Not objData.GetRset("GetItemSubCatList") Then
        '    'MessageBox.Show(objData.ErrMsg)
        'Else
        '    dsSubCatList = objData.RecSet
        'End If

        'objData = Nothing


        'strJS = "<Script Language='JavaScript'>" & _
        '    "function GetCat(elem){" & vbCrLf & _
        '    "var cmbSepReason;" & _
        '    "var cmbSepCat;" & _
        '    "var cmbSepSubCat;" & _
        '    "cmbSepReason = document.getElementById('cmbSepReason');" & _
        '    "cmbSepCat = document.getElementById('cmbSepCat');" & _
        '    "cmbSepSubCat = document.getElementById('cmbSepSubCat');" & _
        '    "for (var i = cmbSepCat.options.length; i >= 0; i--){" & vbCrLf & _
        '    "cmbSepCat.options[i] = null;}"

        strJS = "<Script Language='JavaScript'>" & _
            "function GetCat(elem){" & vbCrLf & _
            "var cmbSepReason;" & _
            "var cmbSepCat;" & _
            "cmbSepReason = document.getElementById('cmbSepReason');" & _
            "cmbSepCat = document.getElementById('cmbSepCat');" & _
            "for (var i = cmbSepCat.options.length; i >= 0; i--){" & vbCrLf & _
            "cmbSepCat.options[i] = null;}"

        For j = 0 To cmbSepReason.Items.Count - 1

            If cmbSepReason.Items(j).Value <> "" Then
                strJS = strJS & "if (elem.options[elem.selectedIndex].value == " & Chr(34) & cmbSepReason.Items(j).Value & Chr(34) & "){" & vbCrLf

                For Each i In dsCatList.Tables("DataSet").Rows()

                    If i("ItemDetail_Id") = cmbSepReason.Items(j).Value Then

                        strJS = strJS & _
                            "cmbSepCat.options[cmbSepCat.options.length] = new Option(" & Chr(34) & _
                            i("Cat_Desc") & Chr(34) & "," & i("Cat_Id") & ");"
                    End If
                Next
                strJS = strJS & "} "

            End If
        Next

        strJS = strJS & " } </script>"
        'strJS = strJS & " GetSubCat(cmbSepCat);} </script>"

        RegisterStartupScript("VV", strJS)

        'Function for Sep Reason Sub Category
        'strJS = "<Script Language='JavaScript'>" & _
        '    "function GetSubCat(elem){" & vbCrLf & _
        '    "var cmbSepCat;" & _
        '    "var cmbSepSubCat;" & _
        '    "cmbSepCat = document.getElementById('cmbSepCat');" & _
        '    "cmbSepSubCat = document.getElementById('cmbSepSubCat');" & _
        '    "for (var i = cmbSepSubCat.options.length; i >= 0; i--){" & vbCrLf & _
        '    "cmbSepSubCat.options[i] = null;}"





        'For Each k In dsCatList.Tables("DataSet").Rows()

        '    strJS = strJS & "if (elem.options[elem.selectedIndex].value == " & Chr(34) & k("Cat_Id") & Chr(34) & "){" & vbCrLf

        '    For Each i In dsSubCatList.Tables("DataSet").Rows()

        '        If i("Cat_Id") = k("Cat_Id") Then

        '            strJS = strJS & _
        '                "cmbSepSubCat.options[cmbSepSubCat.options.length] = new Option(" & Chr(34) & _
        '                i("SubCat_Desc") & Chr(34) & "," & Chr(34) & i("SubCat_Id") & Chr(34) & ");"
        '        End If
        '    Next
        '    strJS = strJS & "} "
        'Next

        'strJS = strJS & "} </script>"

        'RegisterStartupScript("VV1", strJS)

        'Populate category and subCategory when
        'opening up record
            If txtId.Text > 0 Then
                j = 0
                For Each i In dsCatList.Tables("DataSet").Rows
                    If i("ItemDetail_Id") = cmbSepReason.SelectedValue Then
                        cmbSepCat.Items.Insert(j, New ListItem(i("Cat_Desc"), i("Cat_Id")))
                        j = j + 1
                    End If
                Next

                If txtCatId.Text > 0 Then
                    cmbSepCat.SelectedValue = txtCatId.Text
                End If

                'If txtCatId.Value > 0 Then
                '    cmbSepCat.SelectedValue = txtCatId.Value

                '    j = 0
                '    For Each i In dsSubCatList.Tables("DataSet").Rows
                '        If i("Cat_Id") = txtCatId.Value Then
                '            cmbSepSubCat.Items.Insert(j, New ListItem(i("SubCat_Desc"), i("SubCat_Id")))
                '            j = j + 1
                '        End If
                '    Next

                '    If txtSubCatId.Value > 0 Then
                '        cmbSepSubCat.SelectedValue = txtSubCatId.Value
                '    End If
                'End If

            End If

        dsCatList = Nothing
            'dsSubCatList = Nothing

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

            If Not objData.GetRset("GetRequestDetails 5," & txtId.Text) Then
                Response.Write(objData.ErrMsg)
            Else
                dsData = objData.RecSet
            End If

            For Each i In dsData.Tables("DataSet").Rows()

                txtChangeTypeId.Text = i("ChangeTypeId")

                txtSepDate.Text = FixNull(i("Date_Sep"))
                txtSepDate.ToolTip = txtSepDate.Text

                txtSepNotified.Text = FixNull(i("Date_Notified"))
                txtSepNotified.ToolTip = txtSepNotified.Text

                txtLastWork.Text = FixNull(i("Date_LastWork"))
                txtLastWork.ToolTip = txtLastWork.Text

                cmbSepReason.SelectedValue = FixNull(i("Sep_ReasonId"))
                txtHSepReason.Text = cmbSepReason.SelectedValue

                txtCatId.Text = i("Sep_CatId")
                txtHCatId.Text = txtCatId.Text

                'txtSubCatId.Value = i("Sep_SubCatId")
                'txtHSubCatId.Value = txtSubCatId.Value

                txtSepDesc.Text = FixNull(i("Sep_Desc"))
                txtSepDesc.ToolTip = txtSepDesc.Text

                txtOtherDesc.Text = FixNull(i("Other_Desc"))
                txtOtherDesc.ToolTip = txtOtherDesc.Text

                txtEmpComm.Text = FixNull(i("Emp_Comm"))
                txtEmpComm.ToolTip = txtEmpComm.Text

                chkMailFinalWages.Checked = IIf(i("Mail_FinalWages") = 0, False, True)
                chkMailFinalWages.ToolTip = chkMailFinalWages.Checked

                txtHRApproval.Text = FixNull(i("Sep_AppBy"))
                txtHRApproval.ToolTip = txtHRApproval.Text

                chkFax.Checked = IIf(i("Sep_FaxReport") = 0, False, True)
                chkFax.ToolTip = chkFax.Checked

                Exit For
            Next

            '-------commented by hemangini on 12/8/2015
            ''Load Signatures
            'If txtChangeTypeId.Text <> 7 Then
            '    j = 0
            '    For Each i In dsData.Tables("DataSet").Rows()
            '        If FixNull(i("Person_Name")) = txtEmpName.Text Then
            '            txtEmpSig.Text = FixNull(i("Person_Sig"))
            '        Else
            '            If j = 1 Then   '2nd signature
            '                txtManSig.Text = FixNull(i("Person_Sig"))
            '                txtManName.Text = FixNull(i("Person_Name"))
            '                txtManName.Enabled = False
            '            Else            '3rd signature
            '                txtManSig2.Text = FixNull(i("Person_Sig"))
            '                txtManName2.Text = FixNull(i("Person_Name"))
            '                txtManName2.Enabled = False
            '            End If
            '        End If
            '        j = j + 1
            '    Next i
            'End If
            '------------------------------------

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

    Protected Sub cmdSubmit_Click(sender As Object, e As EventArgs) Handles cmdSubmit.Click
        Try
            'Check if signatures are present
            If Not chkSignLater.Checked And (txtEmpSig.Text = "" Or txtManSig.Text = "" Or txtManSig2.Text = "") Then
                lblError.Visible = True
                lblError.Text = "Error : Employee and Managers' signatures are required .. Please check it out"
                Exit Sub
            End If

            If txtManClockId.Text > 0 Then
                If chkSignLater.Checked Then
                    If UpdateData(txtManClockId.Text, False) Then
                        Call SendEmail(1)
                    End If
                Else
                    '------------commented by hemangini on 12/8/2015
                    'If UpdateData(txtManClockId.Text, True) Then
                    '    Call SendEmail(1)
                    'End If
                    '-------------------------------------
                End If
            Else
                Call DisplayStatus("ClockId not stored in ADS .. Please check it out", True)
            End If

            Call DisplayResultPage()
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Function UpdateData(ByVal lngClockId As Long, ByVal blnUpdateSig As Boolean) As Boolean
        Try
            Dim intReturnCode As Integer

            objData = New clsData
            objData.ConnectionString = Application("ConnString")

            With objData
                .AppendOutputParm()

                .AppendParameter("@ECId", "Integer", 4, Val(txtId.Text))

                If txtId.Text <= 0 And chkSignLater.Checked Then
                    .AppendParameter("@ChangeTypeId", "Integer", 4, 7)  'Quick Sep Code - 7
                Else
                    .AppendParameter("@ChangeTypeId", "Integer", 4, 5)  'Full Sep Code - 5
                End If

                .AppendParameter("@ClockId", "Integer", 4, txtClockId.Text)
                .AppendParameter("@ChangeReason", "Char", 1000, "")
                .AppendParameter("@EffDate", "Date", 4, txtSepDate.Text)
                .AppendParameter("@DateSep", "Date", 4, txtSepDate.Text)
                .AppendParameter("@DateNotified", "Date", 4, txtSepNotified.Text)

                'Make last day work today if the check box is checked
                'only when request is created first
                If txtId.Text <= 0 Then
                    If chkFax.Checked Then
                        txtLastWork.Text = Today
                    End If
                End If

                .AppendParameter("@DateLastWork", "Date", 4, txtLastWork.Text)
                .AppendParameter("@SepReasonId", "Integer", 4, cmbSepReason.SelectedValue)
                .AppendParameter("@SepCatId", "Integer", 4, Val(txtCatId.Text))

                '.AppendParameter("@SepSubCatId", "Integer", 4, IIf(txtSubCatId.Value = "", 0, txtSubCatId.Value))
                .AppendParameter("@SepSubCatId", "Integer", 4, 0)

                .AppendParameter("@SepDesc", "Char", 2000, txtSepDesc.Text)
                .AppendParameter("@OtherDesc", "Char", 2000, txtOtherDesc.Text)
                .AppendParameter("@EmpComm", "Char", 2000, txtEmpComm.Text)
                .AppendParameter("@MailFinalWages", "Bit", 1, chkMailFinalWages.Checked)
                .AppendParameter("@SepAppBy", "Char", 50, txtHRApproval.Text)
                .AppendParameter("@FaxReport", "Bit", 1, chkFax.Checked)

                If blnUpdateSig Then
                    '--------------commented by hemangini on 12/8/2015
                    '.AppendParameter("@EmpSig", "Char", 6000, txtEmpSig.Text)
                    '.AppendParameter("@ManSig", "Char", 6000, txtManSig.Text)
                    '.AppendParameter("@ManName", "Char", 200, txtManName.Text)
                    '.AppendParameter("@ManSig2", "Char", 6000, txtManSig2.Text)
                    '.AppendParameter("@ManName2", "Char", 200, txtManName2.Text)
                    '-------------------------------------------------------------
                Else
                    .AppendParameter("@EmpSig", "Char", 6000, "")
                    .AppendParameter("@ManSig", "Char", 6000, "")
                    .AppendParameter("@ManName", "Char", 200, "")
                    .AppendParameter("@ManSig2", "Char", 6000, "")
                    .AppendParameter("@ManName2", "Char", 200, "")
                End If

                .AppendParameter("@EmpId", "Integer", 4, lngClockId)
            End With

            If Not objData.ExecuteCommand("UpdateEmpSeperation") Then
                Call DisplayStatus(objData.ErrMsg, True)
                Return False
            Else
                intReturnCode = objData.ReturnCode

                If intReturnCode = -1 Then  'Request is already made
                    Call DisplayStatus("Separation request has already been made for this employee | Please check Separation report to get more details", True)
                    Return False
                ElseIf intReturnCode = -2 Then   'Emp is on leave and can not be separated
                    Call DisplayStatus("Employee is on leave | Can not separate employee", True)
                    Return False
                ElseIf intReturnCode = -3 Then   'Signatures are missing
                    Call DisplayStatus("Employee and Managers' signatures are required .. Please check it out", True)
                    Return False
                Else

                    If txtId.Text = 0 Then
                        Call DisplayStatus("Request has been submitted successfully", False)
                    Else
                        Call DisplayStatus("Request has been updated successfully", False)
                    End If

                    Return True
                End If
            End If

            objData = Nothing
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

    Private Function SendEmail(ByVal intProcessStep As Integer) As Boolean
        Try

            Dim j As Integer
            Dim i As DataRow
            Dim strEmpName As String
            Dim strEmpEmail As String
            Dim strEmailList As String
            Dim strBody As String
            Dim objGeneral As clsGeneral
            Dim intUnit As Integer
            Dim strHireDate As String
            Dim strAddress As String
            Dim strPEmail As String
            Dim strPrimJob As String
            Dim strCardNo As String

            objData = New clsData

            'Get Email addresses
            objData.ConnectionString = Application("ConnString")

            If Not objData.GetRset("GetEmailsForSeparation " & txtManClockId.Text & "," & txtClockId.Text & "," & txtEmpUnit.Text & "," & intProcessStep) Then
                Exit Function
            Else
                dsData = objData.RecSet
            End If

            For Each i In dsData.Tables("DataSet").Rows
                strEmpName = FixNull(i(0))
                strEmpEmail = FixNull(i(1))
                intUnit = FixNull(i(2))
                strEmailList = FixNull(i(3))
                strHireDate = FixNull(i(4))
                strPEmail = FixNull(i(5))
                strPrimJob = FixNull(i(6))
                strCardNo = FixNull(i(7))
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

                .EmailSubject = "Separation From Store - " & intUnit

                If intProcessStep = 1 Then
                    If chkMailFinalWages.Checked Then
                        strBody = "I just submitted a Separation request for following employee. Please mail final wages to the following address."

                        'Get Latest address
                        objData = New clsData
                        objData.ConnectionString = Application("ConnString")

                        If Not objData.GetRset("GetEmpAddress " & txtClockId.Text) Then
                            Exit Function
                        Else
                            dsData = objData.RecSet
                        End If

                        For Each i In dsData.Tables("DataSet").Rows
                            strAddress = FixNull(i("FName")) & " " & FixNull(i("LName")) _
                                    & vbCrLf & FixNull(i("Add1")) & " " & FixNull(i("Add2")) _
                                    & vbCrLf & FixNull(i("City")) & ", " & FixNull(i("State")) _
                                    & " " & FixNull(i("Zip"))
                        Next

                        objData = Nothing
                        dsData = Nothing

                        strBody = strBody & vbCrLf & vbCrLf & strAddress
                    Else
                        strBody = "I just submitted a Separation request for following employee. Please mail final wages to the Store - " & intUnit '& " (Employee Requests a Cash Paid Out)."
                    End If

                    If chkFax.Checked Then
                        strBody = strBody & vbCrLf & vbCrLf & _
                                "Employee worked today, I faxed report to payroll."
                    End If

                ElseIf intProcessStep = 2 Then
                    strBody = "I just approved a Separation request for following employee."
                Else
                    strBody = "I just processed a Separation request for following employee."
                End If

                strBody = strBody & vbCrLf & vbCrLf _
                        & "Clock Id         : " & txtClockId.Text & vbCrLf _
                        & "Employee Name    : " & txtEmpName.Text & vbCrLf _
                        & "Date Separation  : " & txtSepDate.Text & vbCrLf _
                        & "Date Last Hire   : " & strHireDate & vbCrLf _
                        & "Date Last Worked : " & txtLastWork.Text & vbCrLf _
                        & "Date Gave Notice : " & txtSepNotified.Text & vbCrLf _
                        & "Separation Type  : " & cmbSepReason.SelectedItem.Text & " - " & txtCatName.Text & vbCrLf _
                        & "HR Approval By   : " & txtHRApproval.Text & vbCrLf _
                        & "Primary Job Code : " & strPrimJob & vbCrLf _
                        & "Personal Email   : " & strPEmail

                If intProcessStep = 1 Then
                    strBody = strBody & vbCrLf & "Final Pay Notes  : " & txtOtherDesc.Text
                End If

                If intProcessStep = 1 And strCardNo <> "" Then
                    strBody = strBody & vbCrLf & "Comp Cards       : " & strCardNo
                End If

                strBody = strBody & vbCrLf & vbCrLf & vbCrLf _
                        & "This email is generated automatically through HR Express based on certain action."

                .EmailBody = strBody
                .SendEMail()
            End With

            objGeneral = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Function

    Private Sub SendMailToPayroll()
        Try
            'Get Email addresses
            objData = New clsData
            Dim i As DataRow
            Dim strEmpName As String
            Dim strEmpEmail As String
            Dim strPayrollEmailList As String
            Dim intUnit As Integer
            Dim strBody As String
            Dim strDateHire As String

            objData.ConnectionString = Application("ConnString")

            If Not objData.GetRset("GetEmailsForSeperation " & txtManClockId.Text & "," & txtClockId.Text) Then
                'MessageBox.Show(objData.ErrMsg)
            Else
                dsData = objData.RecSet
            End If

            For Each i In dsData.Tables("DataSet").Rows
                strEmpName = FixNull(i(0))
                strEmpEmail = FixNull(i(1))
                intUnit = i(2)
                strPayrollEmailList = FixNull(i(3))
                strDateHire = FixNull(i(4))
            Next

            objData = Nothing
            dsData = Nothing

            If Trim(strEmpEmail) = "" Or Trim(strPayrollEmailList) = "" Then
                Exit Sub
            End If

            'Send email
            Dim objMail As New System.Web.Mail.MailMessage

            With objMail
                .To = strPayrollEmailList
                .From = strEmpName & "(" & strEmpEmail & ")"

                .BodyFormat = Mail.MailFormat.Text
                .Subject = "Final Pay Out / From Store - " & intUnit

                If chkMailFinalWages.Checked Then
                    strBody = "I just submitted a separation request for following employee. Please mail final wages to his/her address in the system."
                Else
                    strBody = "I just submitted a separation request for following employee. Please mail final wages to the Store - " & intUnit & " (Employee Requests a Cash Paid Out)."
                End If

                strBody = strBody & vbCrLf & vbCrLf _
                        & "Clock Id         : " & txtClockId.Text & vbCrLf _
                        & "Employee Name    : " & txtEmpName.Text & vbCrLf _
                        & "Date Last Hire   : " & strDateHire & vbCrLf _
                        & "Date Last Worked : " & txtLastWork.Text & vbCrLf _
                        & "Separation Type  : " & cmbSepReason.SelectedItem.Text & vbCrLf _
                        & "HR Approval By   : " & txtHRApproval.Text & vbCrLf _
                        & "Final Pay Notes  : " & txtOtherDesc.Text

                .Body = strBody
            End With

            System.Web.Mail.SmtpMail.SmtpServer = "www.claimjumper.com"
            System.Web.Mail.SmtpMail.Send(objMail)

            objMail = Nothing
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

            If IsPageDirty() Then
                If Not UpdateData(txtManClockId.Text, False) Then
                    Call DisplayResultPage()
                    Exit Sub
                End If
            End If

            objData = New clsData
            objData.ConnectionString = Application("ConnString")

            With objData
                .AppendOutputParm()
                .AppendParameter("@ECId", "Integer", 4, txtId.Text)
                .AppendParameter("@ChangeTypeId", "Integer", 4, 5)
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
                    Call SendEmail(3)
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
            If Trim(txtSepDate.Text) <> Trim(txtSepDate.ToolTip) Or _
                Trim(txtLastWork.Text) <> Trim(txtLastWork.ToolTip) Or _
                Trim(txtSepNotified.Text) <> Trim(txtSepNotified.ToolTip) Or _
                txtHSepReason.Text <> cmbSepReason.SelectedValue Or _
                Trim(txtSepDesc.Text) <> Trim(txtSepDesc.ToolTip) Or _
                Trim(txtOtherDesc.Text) <> Trim(txtOtherDesc.ToolTip) Or _
                Trim(txtEmpComm.Text) <> Trim(txtEmpComm.ToolTip) Or _
                chkMailFinalWages.Checked <> chkMailFinalWages.ToolTip Or _
                chkFax.Checked <> chkFax.ToolTip Or _
                Trim(txtHRApproval.Text) <> Trim(txtHRApproval.ToolTip) Or _
                txtCatId.Text <> txtHCatId.Text Then
                'txtSubCatId.Value <> txtHSubCatId.Value Then

                IsPageDirty = True
            Else
                IsPageDirty = False
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
            Return False
        End Try
    End Function

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

    Protected Sub cmdApprove_Click(sender As Object, e As EventArgs) Handles cmdApprove.Click
        Try
            If txtManClockId.Text <= 0 Then
                Call DisplayStatus("ClockId not stored in ADS .. Please check it out", True)
                Call DisplayResultPage()
                Exit Sub
            End If

            'Check if signatures are present
            If txtEmpSig.Text = "" Or txtManSig.Text = "" Or txtManSig2.Text = "" Then
                lblError.Visible = True
                lblError.Text = "Error : Employee and Managers' signatures are required .. Please check it out"
                Exit Sub
            End If

            'Update for any changes before
            'approving request
            If IsPageDirty() Then
                Call UpdateData(txtManClockId.Text, False)
            End If

            'Approve request
            If Not UpdateGMApproval(1, txtManClockId.Text) Then
                Call DisplayResultPage()
                Exit Sub
            Else
                Call SendEmail(2)
            End If

            'Script to close this window and refresh parent window
            Dim strScript As String
            strScript = "<SCRIPT>window.opener.document.forms(0).txtLoadForm.value = 1; window.opener.document.forms(0).submit(); self.close();</SCRIPT>"
            Page.RegisterClientScriptBlock("CloseMeApprove", strScript)
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
            Return False
        End Try
    End Function

    Protected Sub cmdDeny_Click(sender As Object, e As EventArgs) Handles cmdDeny.Click
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
                Else
                    Call SendRequestDeniedEmail()
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
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub


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
                .EmailSubject = "Separation - Review Again"

                strBody = "Your approved request for Separation has been sent back to you, please read notes below and approve/deny request again."

                strBody = strBody & vbCrLf & vbCrLf _
                        & "Clock Id      : " & txtClockId.Text & vbCrLf _
                        & "Employee Name : " & txtEmpName.Text & vbCrLf _
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

    Private Sub SendRequestDeniedEmail()
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

            If Not objData.GetRset("GetEmailsForSepDenied " & txtManClockId.Text & "," & txtId.Text) Then
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
                .EmailSubject = "Separation - Denied"

                strBody = "Following Separation request has been denied, for reason please read notes below ..."

                strBody = strBody & vbCrLf & vbCrLf _
                        & "Clock Id         : " & txtClockId.Text & vbCrLf _
                        & "Employee Name    : " & txtEmpName.Text & vbCrLf _
                        & "Employee Unit    : " & txtEmpUnit.Text & vbCrLf _
                        & "Date Separation  : " & txtSepDate.Text & vbCrLf _
                        & "Notes            : " & txtUndoNotes.Text _
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

    Protected Sub cmdUpdate_Click(sender As Object, e As EventArgs) Handles cmdUpdate.Click
        Try
            'Check if signatures are present
            If txtEmpSig.Text = "" Or txtManSig.Text = "" Or txtManSig2.Text = "" Then
                lblError.Visible = True
                lblError.Text = "Error : Employee and Managers' signatures are required .. Please check it out"
                Exit Sub
            End If

            If txtManClockId.Text > 0 Then
                Call UpdateData(txtManClockId.Text, True)
                'Call SendMailToPayroll()
            Else
                Call DisplayStatus("ClockId not stored in ADS .. Please check it out", True)
                Call DisplayResultPage()
            End If

            'Script to close this window and refresh parent window
            Dim strScript As String
            strScript = "<SCRIPT>window.opener.document.forms(0).txtLoadForm.value = 1; window.opener.document.forms(0).submit(); self.close();</SCRIPT>"
            Page.RegisterClientScriptBlock("CloseMeApprove", strScript)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub
End Class