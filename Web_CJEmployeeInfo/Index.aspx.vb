Imports Web_CJEmployeeInfo.Web_CJEmployeeInfo

Public Class Index
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Call LoadUser()
            If txtSecCode.Text = 3 Or txtSecCode.Text = 4 Or _
                txtSecCode.Text = 5 Or txtSecCode.Text = 6 Or _
                txtSecCode.Text = 7 Or txtSecCode.Text = 9 Then

                Response.Redirect("~/Web_Forms/ManageEmpRequests.aspx?QH=0")

            ElseIf txtSecCode.Text = 1 Or txtSecCode.Text = 2 Or _
                txtSecCode.Text = 8 Or txtSecCode.Text = 10 Then
                Response.Redirect("~/Web_Forms/StoreEmployee.aspx")
            Else
                Response.Redirect("~/Web_Forms/AccessDenied.aspx")
            End If
        End If
    End Sub

    Private Sub LoadUser()
        Dim lngClockId As Long
        Dim objADS As clsADS
        Dim strDomainUser As String

        Try
            'Get user's login name
            'Dim strDomainUser As String = User.Identity.Name.Replace("\", "/")
            strDomainUser = ""

            strDomainUser = System.Web.HttpContext.Current.User.Identity.Name.Replace("\", "/")
            strDomainUser = strDomainUser.Substring(strDomainUser.LastIndexOf("/") + 1)

            'Response.Write(strDomainUser)
            'strDomainUser = "PPP"

            objADS = New clsADS
            With objADS
                .UserLogin = strDomainUser
                .LoadUser()
                lngClockId = Val(.GetAttribute("employeeid"))

                'For Testing
                'lngClockId = 22205


                Call LoadEmpSecurity(lngClockId)
            End With

            objADS = Nothing

        Catch e As Exception
            Response.Redirect("~/GeneralError.aspx?E=" & "LoadUser: Error getting data from AD. Login: " & strDomainUser & " | " & e.Message)
        End Try
    End Sub

    Private Sub LoadEmpSecurity(ByVal lngClockId As Long)
        Dim objGeneral As clsGeneral

        objGeneral = New clsGeneral
        With objGeneral
            .ConnectionString = Application("ConnString")
            .ClockId = lngClockId
            If Not .GetEmpSecurity Then
                txtSecCode.Text = 0
            Else
                txtSecCode.Text = .SecCode
            End If
        End With

        objGeneral = Nothing
    End Sub

End Class
