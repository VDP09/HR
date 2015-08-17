Imports System.Drawing
Imports Web_CJEmployeeInfo.Web_CJEmployeeInfo

Partial Class ManageEmpRequests
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
        Try
            If Not IsPostBack Then
                txtQH.Text = Request("QH")
                Dim lblnm As Label = CType(Master.FindControl("lblnm"), Label)

                If txtQH.Text = 1 Then
                    lblTitle1.Text = "Update Requests"
                    lblnm.Text = "Update Requests"
                Else
                    lblTitle1.Text = "Process Requests"
                    lblnm.Text = "Process Requests"
                End If

                Call LoadUser()
                Call LoadRequestType()

                If txtSecCode.Text <= 4 Or txtSecCode.Text = 10 Then
                    cmbStore.Visible = False
                    lblStore.Visible = False
                    lblAppOnly.Visible = False
                    chkApproved.Visible = False
                    chkManOnly.Visible = False
                Else
                    Call LoadStores()
                End If

                If txtSecCode.Text = 8 Or txtSecCode.Text = 9 Then
                    chkApproved.Enabled = False
                End If

                'Display links according to security code
                If txtSecCode.Text = 5 Or txtSecCode.Text = 6 Then
                    'txtSecCode.Value = 7 Then

                    hlinkEnterReq.NavigateUrl = ""
                    hlinkUpdateQuickHires.NavigateUrl = ""

                    hlinkProcessReq.NavigateUrl = ""
                    hlinkProcessReq.ForeColor = Color.Red

                ElseIf txtSecCode.Text = 7 Then
                    'hlinkEnterReq.NavigateUrl = ""
                    hlinkUpdateQuickHires.NavigateUrl = ""

                    hlinkProcessReq.NavigateUrl = ""
                    hlinkProcessReq.ForeColor = Color.Red
                Else
                    If txtSecCode.Text = 1 Or txtSecCode.Text = 2 Or _
                        txtSecCode.Text = 8 Then 'Or txtSecCode.Value = 10 Then

                        hlinkUpdateQuickHires.NavigateUrl = ""
                        hlinkUpdateQuickHires.ForeColor = Color.Red
                        hlinkProcessReq.NavigateUrl = ""

                    ElseIf txtSecCode.Text = 3 Or txtSecCode.Text = 4 Or _
                        txtSecCode.Text = 9 Or txtSecCode.Text = 10 Then

                        If txtQH.Text = 0 Then
                            hlinkProcessReq.NavigateUrl = ""
                            hlinkProcessReq.ForeColor = Color.Red
                        Else
                            hlinkUpdateQuickHires.NavigateUrl = ""
                            hlinkUpdateQuickHires.ForeColor = Color.Red
                        End If
                    End If
                End If

                If txtSecCode.Text = 6 Or txtSecCode.Text = 7 Or _
                    txtSecCode.Text = 8 Or txtSecCode.Text = 9 Then
                    cmdMoveOA.Visible = True
                Else
                    cmdMoveOA.Visible = False
                End If

                If txtSecCode.Text = 6 Or txtSecCode.Text = 8 Then
                    tblMoveEditSubmit.Visible = True
                Else
                    tblMoveEditSubmit.Visible = False
                End If

                cmdGetReq.Attributes.Add("onclick", "if(ValidateData()){return true;} else{return false;}")
            Else
                'Only refresh page if any request is processed and
                'also set the flag
                If txtLoadForm.Text = "1" Then
                    Call LoadRequests(txtSort.Text)
                    txtLoadForm.Text = "0"
                End If

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
                .Items.Insert(0, New ListItem("All Stores", "0"))
            End With
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
        'objData = Nothing
        'dsData = Nothing
    End Sub

    Private Sub LoadUser()
        Try
            Dim strFullName As String
            Dim objADS As clsADS
            Dim lngClockId As Long

            'Get user's login name
            Dim strDomainUser As String = User.Identity.Name.Replace("\", "/")
            strDomainUser = strDomainUser.Substring(strDomainUser.LastIndexOf("/") + 1)

            objADS = New clsADS
            With objADS
                .UserLogin = strDomainUser
                .LoadUser()
                strFullName = .GetAttribute("name")

                'Get Employee Security
                lngClockId = .GetAttribute("employeeid")
                Call LoadEmpSecurity(lngClockId)

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
                    txtManClockId.Text = lngClockId
                End If
            End With

            lblStore1.Text = "My Store : " & txtUnit.Text

            objGeneral = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Sub LoadRequestType()
        Try
            With cmbReqType
                If txtQH.Text = 1 Then
                    'show only quick sep to RMs
                    If txtSecCode.Text = 10 Then
                        .Items.Insert(0, New ListItem("Quick Separation", "7"))
                    Else
                        .Items.Insert(0, New ListItem("All Incomplete Requests", "8"))
                        .Items.Insert(1, New ListItem("Quick Hire", "6"))
                        .Items.Insert(2, New ListItem("Quick Separation", "7"))
                    End If
                Else
                    .Items.Insert(0, New ListItem("All Requests", "0"))

                    If txtSecCode.Text = 3 Or txtSecCode.Text = 4 Or _
                        txtSecCode.Text = 9 Or txtSecCode.Text = 10 Then        'GM, AGM, HR Admin, RM

                        .Items.Insert(1, New ListItem("New Hire / ReHire", "1"))
                        .Items.Insert(2, New ListItem("Pay Rate / Department Changes", "3"))
                        .Items.Insert(3, New ListItem("Transfers", "4"))
                        .Items.Insert(4, New ListItem("Separations", "5"))
                    End If

                    If txtSecCode.Text = 5 Then        'PR
                        .Items.Insert(1, New ListItem("New Hire / ReHire", "1"))
                        .Items.Insert(2, New ListItem("Pay Rate / Department Changes", "3"))
                        .Items.Insert(3, New ListItem("Transfers", "4"))
                        .Items.Insert(4, New ListItem("W4 Changes", "11"))
                        .Items.Insert(5, New ListItem("EFT Changes", "13"))
                    End If

                    If txtSecCode.Text = 7 Then        'HR
                        .Items.Insert(1, New ListItem("Name / Address Changes", "2"))
                        .Items.Insert(2, New ListItem("Separations", "5"))
                        '.Items.Insert(3, New ListItem("W4 Changes", "11"))
                        .Items.Insert(3, New ListItem("I9 Changes", "12"))
                        '.Items.Insert(5, New ListItem("EFT Changes", "13"))
                        .Items.Insert(4, New ListItem("Misc. Changes", "14"))
                    End If

                    If txtSecCode.Text = 6 Then 'PR Admin
                        .Items.Insert(1, New ListItem("New Hire / ReHire", "1"))
                        .Items.Insert(2, New ListItem("Name / Address Changes", "2"))
                        .Items.Insert(3, New ListItem("Pay Rate / Department Changes", "3"))
                        .Items.Insert(4, New ListItem("Transfers", "4"))
                        .Items.Insert(5, New ListItem("Separations", "5"))

                        .Items.Insert(6, New ListItem("W4 Changes", "11"))
                        .Items.Insert(7, New ListItem("I9 Changes", "12"))
                        .Items.Insert(8, New ListItem("EFT Changes", "13"))
                        .Items.Insert(9, New ListItem("Misc. Changes", "14"))

                    End If
                End If
            End With
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Sub LoadRequests(ByVal strSort As String)
        Try
            'grdReq.CurrentPageIndex = 0
            'Call GetReqList(strSort)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

End Class
