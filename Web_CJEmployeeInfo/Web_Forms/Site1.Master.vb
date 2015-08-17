Imports Web_CJEmployeeInfo.Web_CJEmployeeInfo

Public Class Site1
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        LoadUser()

    End Sub

    Private Sub LoadUser()
        Try
            Dim strFullName As String
            Dim objADS As clsADS
            Dim ManClockID As String
            'Get user's login name
            Dim strDomainUser As String = System.Web.HttpContext.Current.User.Identity.Name.Replace("\", "/")
            strDomainUser = strDomainUser.Substring(strDomainUser.LastIndexOf("/") + 1)

            objADS = New clsADS
            With objADS
                .UserLogin = strDomainUser
                .LoadUser()
                strFullName = .GetAttribute("name")
                ManClockID = .GetAttribute("employeeid")
            End With
            objADS = Nothing
            Call LoadEmpSecurity(ManClockID)
            lblUser.Text = strFullName

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Sub LoadEmpSecurity(ByVal lngClockId As Long)
        Try
            Dim objGeneral As clsGeneral

            objGeneral = New clsGeneral
            Dim Unit As String

            With objGeneral
                .ConnectionString = Application("ConnString")
                .ClockId = lngClockId
                If Not .GetEmpSecurity Then
                   
                Else
                    Unit = .Unit
                End If
            End With

            lblStore.Text = "My Store : " & Unit

            objGeneral = Nothing
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

End Class