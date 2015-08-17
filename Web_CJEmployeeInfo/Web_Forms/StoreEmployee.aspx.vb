Imports System.Drawing
Imports Web_CJEmployeeInfo.Web_CJEmployeeInfo


Public Class StoreEmployee
    Inherits System.Web.UI.Page

    Dim objData As clsData
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
        If Not IsPostBack Then
            Call LoadUser()

            Call LoadQuickSearch()
            Call LoadDepartments()

            tblButtons.Visible = False

            'Display links according to security code
            hlinkEnterReq.NavigateUrl = ""
            hlinkEnterReq.ForeColor = Color.Red

            If txtSecCode.Text = 1 Or txtSecCode.Text = 2 Or _
                txtSecCode.Text = 8 Then 'Or txtSecCode.Value = 10 Then
                hlinkProcessReq.NavigateUrl = ""
            End If

            If txtSecCode.Text = 7 Then
                hlinkUpdateQuickHires.NavigateUrl = ""

                'cmdEditPunch.Enabled = False
                'cmdBreakWaiver.Enabled = False
                'cmdSubmitPayroll.Enabled = False

                cmdEditPunch.Disabled = True
                cmdBreakWaiver.Disabled = True
                cmdSubmitPayroll.Disabled = True

                cmdPayChange.Disabled = True
                cmdTransEmp.Disabled = True
                cmdSepEmp.Disabled = True
                'cmdPayChange.Enabled = False
                'cmdTransEmp.Enabled = False
                'cmdSepEmp.Enabled = False

                cmdPBW.Disabled = True
                cmdAddNewShift.Disabled = True
                cmdChangeW4.Disabled = True
                cmdChangeI9.Disabled = True

                'cmdPBW.Enabled = False
                'cmdAddNewShift.Enabled = False
                'cmdChangeW4.Enabled = False
                'cmdChangeI9.Enabled = False
                cmdChangeEFT.Enabled = False
                cmdLeaveReq.Enabled = False

                'hlinkProcessReq.NavigateUrl = ""
                'hlinkProcessReq.ForeColor = Color.White
            End If


            'Do not allow managers to enter New Hire, Name/Add Change, Transfer Emp
            'If txtSecCode.Value = 1 Then
            '    cmdNameAdd.Disabled = True
            '    cmdTransEmp.Disabled = True
            '    cmdNewEmp.Disabled = True
            'End If

            'Do not allow RMs to do new hire
            If txtSecCode.Text = 10 Then
                'cmdNewEmp.Enabled = False
                'cmdQHire.Enabled = False
                cmdQHire.Disabled = True
                cmdNewEmp.Disabled = True
            End If

            'Edit punch and submit Payroll modules
            'If txtSecCode.Value <= 4 And _
            '    (txtUnit.Value = 15 Or txtUnit.Value = 20 Or txtUnit.Value = 23 Or _
            '    txtUnit.Value = 37 Or txtUnit.Value = 29 Or txtUnit.Value = 32 Or _
            '    txtUnit.Value = 94) Then

            '    cmdEditPunch.Disabled = False
            '    cmdSubmitPayroll.Disabled = False
            '    cmdAddNewShift.Disabled = False
            'Else
            '    cmdEditPunch.Disabled = True
            '    cmdSubmitPayroll.Disabled = True
            '    cmdAddNewShift.Disabled = True
            'End If

            'Don't allow OAs to separate any employee
            If txtSecCode.Text = 2 Then
                'cmdSepEmp.Enabled = False
                cmdSepEmp.Disabled = True
            End If

            'Only allow GM/AGM & OA to view/change W4, I9, EFT & Misc.
            'If txtSecCode.Value = 1 Then
            '    cmdChangeW4.Disabled = True
            '    cmdChangeI9.Disabled = True
            '    cmdChangeEFT.Disabled = True
            '    cmdChangeMisc.Disabled = True
            'End If

            'Show leave request only to HR
            If txtSecCode.Text = 8 Then
                cmdLeaveReq.Enabled = False
            Else
                cmdLeaveReq.Enabled = True
            End If

            'Show Comp cards to HR
            If txtSecCode.Text = 7 Or txtSecCode.Text = 8 Or txtSecCode.Text = 9 Then
                cmdCompCard.Visible = True
            Else
                cmdCompCard.Visible = False
            End If

            'Break Waivers only to OA, GM, AGM and Jeannette
            'and california only
            If txtStoreState.Text = "CA" And (txtSecCode.Text = 1 Or txtSecCode.Text = 2 Or txtSecCode.Text = 3 Or _
                txtSecCode.Text = 4 Or txtSecCode.Text = 8) Then
                'cmdBreakWaiver.Enabled = True
                cmdBreakWaiver.Disabled = False
            Else
                'cmdBreakWaiver.Enabled = False
                cmdBreakWaiver.Disabled = True
            End If

            'Perm break waiver to everybody
            'and CA, OR only
            If txtStoreState.Text = "CA" Or txtStoreState.Text = "OR" Then
                'cmdPBW.Enabled = True
                cmdPBW.Disabled = False
            Else
                'cmdPBW.Enabled = False
                cmdPBW.Disabled = True
            End If

            cmdFindEmp.Attributes.Add("onclick", "if(ValidateData()){return true;} else{return false;}")
            cmbJobCode.Attributes.Add("onchange", "ClickSearch(2);")
            cmbQuickSearch.Attributes.Add("onchange", "ClickSearch(1);")
            Dim lblnm As Label = CType(Master.FindControl("lblnm"), Label)
            lblnm.Text = "Enter Status Change Requests"
        End If
    End Sub

    Private Sub LoadUser()
        Try
            Dim strFullName As String
            Dim objADS As clsADS

            'Get user's login name
            Dim strDomainUser As String = User.Identity.Name.Replace("\", "/")
            strDomainUser = strDomainUser.Substring(strDomainUser.LastIndexOf("/") + 1)

            objADS = New clsADS
            With objADS
                .UserLogin = strDomainUser
                .LoadUser()
                strFullName = .GetAttribute("name")
                txtManClockId.Text = .GetAttribute("employeeid")
                'For Testing
                'strFullName = "Lala"
                'txtManClockId.Value = 22205

                Call LoadEmpSecurity(txtManClockId.Text)
            End With
            objADS = Nothing

            'lblTitle.Text = "User : " & strFullName & "  "
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Sub LoadEmpSecurity(ByVal lngClockId As Long)
        Try
            Dim objGeneral As clsGeneral

            objGeneral = New clsGeneral
            With objGeneral
                .ConnectionString = Application("ConnString")
                .ClockId = lngClockId
                If Not .GetEmpSecurity Then
                    txtSecCode.Text = 0
                Else
                    txtSecCode.Text = .SecCode
                    txtUnit.Text = .Unit
                    txtStoreState.Text = .StoreState
                End If
            End With

            lblStore.Text = "My Store : " & txtUnit.Text

            objGeneral = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Sub LoadDepartments()
        Try
            objData = New clsData
            Dim dsData As DataSet

            objData.ConnectionString = Application("ConnString")

            If Not objData.GetRset("GetStoreDepartments " & txtSecCode.Text & "," & txtUnit.Text & "," & txtManClockId.Text) Then
                'MessageBox.Show(objData.ErrMsg)
            Else
                dsData = objData.RecSet
                With cmbJobCode
                    .DataSource = dsData.Tables("DataSet")
                    .DataTextField = "DeptDesc"
                    .DataValueField = "DeptId"
                    .DataBind()
                End With

                'For Each i In dsData.Tables("DataSet").Rows()
                'txtStore.Value = i("Unit")
                'Exit For
                'Next
                txtStore.Text = txtUnit.Text
            End If

            objData = Nothing
            dsData = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Sub LoadQuickSearch()
        Try
            With cmbQuickSearch.Items
                .Insert(0, New ListItem("", ""))
                .Insert(1, New ListItem("Clock Id", "ClockId"))
                .Insert(2, New ListItem("First Name", "FName"))
                .Insert(3, New ListItem("Last Name", "LName"))
                .Insert(4, New ListItem("SSN", "SSN"))
            End With
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Protected Sub cmdFindEmp_Click(sender As Object, e As EventArgs) Handles cmdFindEmp.Click
        Try
            grdEmp.CurrentPageIndex = 0
            Call GetEmpList()
            tblButtons.Visible = True
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Sub GetEmpList()
        Try
            Dim strCriteria As String

            If cmbQuickSearch.SelectedValue <> "" Then
                If cmbQuickSearch.SelectedValue = "ClockId" Then
                    strCriteria = "a.ClockId=" & txtQuickSearch.Text
                Else
                    strCriteria = "a." & cmbQuickSearch.SelectedValue & " LIKE '" & txtQuickSearch.Text & "%'"
                End If
            Else
                strCriteria = "a.Job_Code=" & cmbJobCode.SelectedValue
            End If

            objData = New clsData
            Dim dvData As DataView

            objData.ConnectionString = Application("ConnString")

            If Not objData.GetRset("GetEmpList " & Chr(34) & strCriteria & Chr(34) & "," & txtSecCode.Text & "," & txtUnit.Text & "," & txtManClockId.Text) Then
                'MessageBox.Show(objData.ErrMsg)
            Else
                dsData = objData.RecSet
            End If

            dvData = New DataView(dsData.Tables("DataSet"))
            grdEmp.DataSource = dvData
            grdEmp.DataBind()

            If dvData.Table.Rows.Count <= 10 Then
                grdEmp.PagerStyle.Visible = False
            Else
                grdEmp.PagerStyle.Visible = True
            End If

            objData = Nothing
            dsData = Nothing

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Public Function GetPopupScript(ByVal url As String, ByVal options As String) As String
        Try
            Return "var w = window.open(""" & _
                        url & """, null, """ & options & """);"
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
            Return False
        End Try
    End Function

    Protected Sub grdEmp_PageIndexChanged(source As Object, e As DataGridPageChangedEventArgs) Handles grdEmp.PageIndexChanged
        Try
            grdEmp.CurrentPageIndex = e.NewPageIndex
            Call GetEmpList()
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Sub grdEmp_ItemCreated(ByVal sender As System.Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdEmp.ItemCreated

        If (e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem) Then

            'e.Item.Attributes.Add("onmouseover", "this.style.color='#008A8C'; this.style.cursor='hand'")
            'e.Item.Attributes.Add("onmouseout", "this.style.color='black'")

            'e.Item.Attributes.Add("onmouseover", "this.style.fontWeight='Bold'; this.style.cursor='hand'")  commented
            'e.Item.Attributes.Add("onmouseout", "this.style.fontWeight='Normal'")                           commented

            'e.Item.Attributes.Add("onmousedown", "this.style.color='Red';this.style.cursor='hand'")

            'e.Item.Attributes.Add("onmouseover", "this.style.backgroundColor='#008A8C';this.style.cursor='hand'")
            'e.Item.Attributes.Add("onmouseout", "this.style.backgroundColor='#ffffff'")
            'ElseIf (e.Item.ItemType = ListItemType.AlternatingItem) Then
            'e.Item.Attributes.Add("onmouseover", "this.style.backgroundColor='#ffffff';this.style.cursor='hand'")
            'e.Item.Attributes.Add("onmouseout", "this.style.backgroundColor='#EEEEEE'")
        End If

    End Sub

    Private Sub grdEmp_ItemDataBound(ByVal sender As System.Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles grdEmp.ItemDataBound
        If (e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem) Then
            'e.Item.Attributes.Add("onclick", "this.style.backgroundColor='beige'; txtClock.value=" & e.Item.DataItem("ClockId") & ";")

            'e.Item.Attributes.Add("onclick", "ChangeRowColor(this); frmStoreEmp.txtClockId.value=" & e.Item.DataItem("ClockId") & "; frmStoreEmp.txtJobCode.value=" & e.Item.DataItem("JobCode") & "; frmStoreEmp.txtEName.value='" & e.Item.DataItem("ClockId") & " - " & Replace(e.Item.DataItem("First"), "'", "") & " " & Replace(e.Item.DataItem("Last"), "'", "") & "'; frmStoreEmp.txtAllowEFT.value=" & e.Item.DataItem("AllowEFT") & "; frmStoreEmp.txtLeaveEmpType.value=" & e.Item.DataItem("LeaveEmpType") & "; frmStoreEmp.txtAllowBW.value=" & e.Item.DataItem("HourlyFlag") & "; frmStoreEmp.txtPBW.value=" & e.Item.DataItem("PermBW") & "; frmStoreEmp.txtNewHireStatus.value=" & e.Item.DataItem("NewHireStatus") & ";")

            e.Item.Attributes.Add("onclick", "ChangeRowColor(this);")


            'Dim LL As DropDownList
            'LL = e.Item.FindControl("lstQty")

            'With LL.Items
            '    .Insert(0, New ListItem("", ""))
            '    .Insert(1, New ListItem("Clock Id", "ClockId"))
            '    .Insert(2, New ListItem("First Name", "FName"))
            '    .Insert(3, New ListItem("Last Name", "LName"))
            '    .Insert(4, New ListItem("SSN", "SSN"))
            'End With
            'LL.DataBind()
        End If
    End Sub

End Class

