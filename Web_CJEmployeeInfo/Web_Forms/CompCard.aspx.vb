Imports Web_CJEmployeeInfo.Web_CJEmployeeInfo
Public Class CompCard
    Inherits System.Web.UI.Page
#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents cmdNew As System.Web.UI.HtmlControls.HtmlInputButton
    Protected WithEvents lblEmp As System.Web.UI.WebControls.Label
    Protected WithEvents grdCompCard As System.Web.UI.WebControls.DataGrid


    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region
    Dim objData As clsData
    Dim dsData As DataSet
    Dim strError As String
    Dim strStatus As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Not Page.IsPostBack Then
                LoadCompCardRoles()

                txtCardId.Value = Request.Item("CId")
                txtCardNo.Text = Request.Item("CN")

                If Request.Item("RN") <> "" Then
                    cmbRole.SelectedValue = Request.Item("RN")
                End If

                If Request.Item("A") <> "" Then
                    chkActive.Checked = Request.Item("A")
                End If

                txtClockId.Value = Request.Item("ClockId")
                txtManClockId.Value = Request.Item("MClockId")
            End If
            cmdUpdate.Attributes.Add("onclick", "if(ValidateSubmit()){return true} else {return false};")
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Sub LoadCompCardRoles()
        Try
            objData = New clsData

            objData.ConnectionString = Application("ConnString")

            If Not objData.GetRset("GetCompCardRolesList") Then
                'Error
            Else
                dsData = objData.RecSet

                With cmbRole
                    .DataSource = dsData.Tables("DataSet")
                    .DataTextField = "Role_Desc1"
                    .DataValueField = "Role_No"
                    .DataBind()
                End With
            End If

            dsData = Nothing
            objData = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Sub cmdUpdate_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdUpdate.Click
        Try
            Dim strScript As String

            objData = New clsData
            objData.ConnectionString = Application("ConnString")

            With objData
                .AppendOutputParm()
                .AppendParameter("@CardId", "Integer", 4, txtCardId.Value)
                .AppendParameter("@ClockId", "Integer", 4, txtClockId.Value)
                .AppendParameter("@CardNo", "Char", 30, txtCardNo.Text)
                .AppendParameter("@RoleNo", "Integer", 4, cmbRole.SelectedValue)
                .AppendParameter("@FlagActive", "Bit", 1, chkActive.Checked)
                .AppendParameter("@ManClockId", "Integer", 4, txtManClockId.Value)
            End With

            If Not objData.ExecuteCommand("UpdateCompCard") Then
                Call DisplayStatus(objData.ErrMsg, True)
            End If

            objData = Nothing

            strScript = "<SCRIPT>window.opener.document.forms(0).submit(1); self.close();</SCRIPT>"
            Page.RegisterClientScriptBlock("CloseMeSubmit", strScript)
            LoadCompCardRoles()
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
End Class