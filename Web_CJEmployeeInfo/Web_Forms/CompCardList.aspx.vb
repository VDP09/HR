Imports Web_CJEmployeeInfo.Web_CJEmployeeInfo
Public Class CompCardList
    Inherits System.Web.UI.Page

    Dim objData As clsData
    Protected WithEvents Hidden1 As System.Web.UI.HtmlControls.HtmlInputHidden
    Public dsData As DataSet


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
                txtManClockId.Value = Request.Item("MId")

                Call LoadCompCards()
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub
    Private Sub LoadCompCards()
        Try
            Dim i As DataRow
            Dim blnDisplay As Boolean
            Dim intAmount As Integer
            Dim intFreq As Integer
            Dim intRole As Integer

            objData = New clsData

            objData.ConnectionString = Application("ConnString")

            If Not objData.GetRset("GetCompCardDetails " & txtClockId.Value) Then
                'MessageBox.Show(objData.ErrMsg)
            Else
                dsData = objData.RecSet
            End If


            blnDisplay = False

            If dsData.Tables("DataSet").Rows.Count > 0 Then

                'Display first row and then exit
                For Each i In dsData.Tables("DataSet").Rows
                    lblEmp.Text = i("ClockId") & " - " & i("EmpName") & " | Unit : " & i("Unit") & " | Dept : " & i("JobDesc") & " | Status : " & i("Status")
                    lblEmp.ForeColor = Drawing.Color.FromName("#3399ff")
                    'Color.FromName("#3399ff")

                    Exit For
                Next

                If (i("Card_No") <> "") Then
                    grdCompCard.DataSource = dsData
                    grdCompCard.DataBind()
                End If

            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Public Function GetPopupScript(ByVal lngId As Long, ByVal strCardNo As String, ByVal intRoleNo As Integer, ByVal blnActive As Boolean) As String
        Try
            Dim strURL As String
            Dim strOptions As String

            strURL = "CompCard.aspx?CId=" & lngId & "&CN=" & strCardNo & "&RN=" & intRoleNo & "&A=" & blnActive & "&ClockId=" & txtClockId.Value & "&MClockId=" & txtManClockId.Value
            strOptions = "scrollbars=yes,resizable=no,width=530,height=150"

            Return "var w = window.open(""" & _
                             strURL & """, null, """ & strOptions & """);"
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Function
    
End Class