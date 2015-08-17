Imports Web_CJEmployeeInfo.Web_CJEmployeeInfo

Public Class PermBreakWaiver_OR
    Inherits System.Web.UI.Page

    Dim objdata As clsData
    Dim strError As String
    Dim strStatus As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Not Page.IsPostBack Then
                'get request variables
                txtClockId.Text = Request("CId")
                'txtBreakType.Value = 3 'Request("BT")
                txtStatus.Text = Request("S")
                txtEmpname.Text = Request("Emp")
                txtEmp.Text = Request("Emp")

                If txtStatus.Text = "2" Or txtStatus.Text = "" Then
                    txtStatus.Text = 1
                    tblRevoke.Visible = False
                Else
                    txtStatus.Text = 2
                    tblRevoke.Visible = True
                End If

                cmdSubmit.Attributes.Add("onclick", "if(ValidateSubmit()){this.value = 'Please Wait'; this.disabled=true; " & GetPostBackEventReference(cmdSubmit).ToString & "} else{return false;}")
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Protected Sub cmdSubmit_Click(sender As Object, e As EventArgs) Handles cmdSubmit.Click
        Try
            Dim intReturnCode As Integer

            objdata = New clsData
            objdata.ConnectionString = Application("ConnString")

            With objdata
                .AppendOutputParm()

                .AppendParameter("@ClockId", "Integer", 4, Val(txtClockId.Text))
                .AppendParameter("@BreakType", "Integer", 4, 3)
                .AppendParameter("@WaiveFlag", "Integer", 4, Val(txtStatus.Text))
                .AppendParameter("@DateEff", "Date", 4, txtEffDate.Text)
                .AppendParameter("@Person1", "Char", 100, txtEmpname.Text)
                .AppendParameter("@Sig1", "Char", 6000, txtSig1.Text)
                .AppendParameter("@Person2", "Char", 100, txtManname.Text)
                .AppendParameter("@Sig2", "Char", 6000, txtSig2.Text)

            End With

            If Not objdata.ExecuteCommand("UpdatePermBreakWaiver") Then
                Call DisplayStatus(objdata.ErrMsg, True)
            Else
                intReturnCode = objdata.ReturnCode

                If intReturnCode = -1 Then  'Request is already made
                    Call DisplayStatus("Permanent Break Waiver form is already submitted for this employee", True)
                ElseIf intReturnCode = -2 Then
                    Call DisplayStatus("Employee is under 18 years. Can not sign break waiver", True)
                Else
                    Call DisplayStatus("Permanent Break Waiver form submitted successfully", False)
                End If
            End If

            objdata = Nothing

            'Script to close this window and refresh parent window
            Dim strScript As String
            strScript = "<SCRIPT>window.opener.document.forms(0).txtLoadForm.value = 1; window.opener.document.forms(0).submit(); self.close();</SCRIPT>"
            Page.RegisterClientScriptBlock("CloseMeSubmit", strScript)
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

End Class