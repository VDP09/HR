Public Class Reports
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim lblnm As Label = CType(Master.FindControl("lblnm"), Label)
            lblnm.Text = "Reports"
        End If
    End Sub

End Class