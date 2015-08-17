Imports System.Drawing
Imports Web_CJEmployeeInfo.Web_CJEmployeeInfo

Public Class PermBreakWaiverList
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents Button1 As System.Web.UI.HtmlControls.HtmlInputButton
    Protected WithEvents Hidden1 As System.Web.UI.HtmlControls.HtmlInputHidden


    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Dim objData As clsData
    Dim dsData As DataSet

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Not IsPostBack Then
                If Not Page.IsPostBack Then
                    txtClockId.Text = Request("CId")
                    txtStoreState.Text = Request("US")

                    Call LoadBWList()
                Else
                    If txtLoadForm.Text = "1" Then
                        Call LoadBWList()
                        txtLoadForm.Text = "0"
                    End If
                End If

                If txtStoreState.Text = "CA" Then
                    cmd6Hrs.Visible = True
                    cmd1012Hrs.Visible = True
                    cmd68Hrs.Visible = False
                ElseIf txtStoreState.Text = "OR" Then
                    cmd6Hrs.Visible = False
                    cmd1012Hrs.Visible = False
                    cmd68Hrs.Visible = True
                Else
                    cmd6Hrs.Visible = False
                    cmd1012Hrs.Visible = False
                    cmd68Hrs.Visible = False
                End If
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Sub LoadBWList()
        Try
            Dim i As DataRow
            Dim Row As DataGridItem
            Dim blnNoWaivers As Boolean

            objData = New clsData
            dsData = New DataSet

            objData.ConnectionString = Application("ConnString")

            If Not objData.GetRset("GetPermBreakWaiverHistory " & txtClockId.Text) Then
                'MessageBox.Show(objData.ErrMsg)
            Else
                dsData = objData.RecSet
            End If

            blnNoWaivers = True

            'Get and display employee name first
            If dsData.Tables("DataSet").Rows.Count <= 0 Then
                lblEmp.Text = "No employee found by this Clock Id .. Please check it out"
            Else
                txt6Hrs.Text = ""
                txt1012Hrs.Text = ""

                For Each i In dsData.Tables("DataSet").Rows()
                    lblEmp.Text = txtClockId.Text & " - " & i("Employee")
                    txtEmpName.Text = i("Employee")

                    'Make sure atleast one waiver is present
                    If i("BreakType1") > 0 Then
                        blnNoWaivers = False
                    End If

                    Exit For
                Next i
            End If

            'Delete the row if not a single waiver is present
            If blnNoWaivers Then
                dsData.Tables("DataSet").Rows.Clear()
            End If

            grdBW.DataSource = dsData.Tables("DataSet")
            grdBW.DataBind()


            If grdBW.Items.Count >= 1 Then
                For Each Row In grdBW.Items
                    If CType(Row.FindControl("BreakType1"), Label).Text = "1" Then    'For CA Only
                        Row.BackColor = Color.FromName("#f0f0f0")             '#ffffab

                        If txt6Hrs.Text = "" Then
                            txt6Hrs.Text = CType(Row.FindControl("Status1"), Label).Text
                        End If

                    ElseIf CType(Row.FindControl("BreakType1"), Label).Text = "2" Then    'For CA Only
                        Row.BackColor = Color.FromName("#bce8f1")      '#eaffab

                        If txt1012Hrs.Text = "" Then
                            txt1012Hrs.Text = CType(Row.FindControl("Status1"), Label).Text
                        End If

                    ElseIf CType(Row.FindControl("BreakType1"), Label).Text = "3" Then 'For OR only
                        Row.BackColor = Color.FromName("#bce8f1")           ' #eaffab

                        If txt6Hrs.Text = "" Then
                            txt6Hrs.Text = CType(Row.FindControl("Status1"), Label).Text
                        End If
                    End If

                Next
            End If

            objData = Nothing
            dsData = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Public Function GetPopupScript(ByVal lngPBWId As Long, ByVal intStatus As Integer, ByVal intBType As Integer) As String
        Try
            Dim strURL As String
            Dim strOptions As String

            strURL = "PermBreakWaiver.aspx?PBWId=" & lngPBWId & _
                        "&CId=" & txtClockId.Text & "&Emp=" & txtEmpName.Text & _
                        "&S=" & intStatus & "&BT=" & intBType

            strOptions = "top=5,left=5,scrollbars=yes,resizable=no,width=750,height=725"

            Return "var w111 = window.open(""" & _
                                strURL & """, null, """ & strOptions & """);"
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Function

End Class