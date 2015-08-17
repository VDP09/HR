Imports Web_CJEmployeeInfo.Web_CJEmployeeInfo

Public Class PermBreakWaiver
    Inherits System.Web.UI.Page

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

    Dim objdata As clsData
    Dim strError As String
    Dim strStatus As String
    Dim dsData As DataSet

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Not IsPostBack Then
                'get request variables
                txtClockId.Text = Request("CId")
                txtBreakType.Text = Request("BT")
                txtStatus.Text = Request("S")
                txtEmpname.Text = Request("Emp")
                txtPBWId.Text = Request("PBWId")

                'Change status of form based on the values passed
                If txtBreakType.Text = 1 Then  'under 6 hours
                    tblTitle1.Visible = True
                    tblTitle2.Visible = False

                    tblBody1.Visible = True
                    lblBody1.InnerText = "I, " & txtEmpname.Text & ", and Claim Jumper Restaurants, LLC agree that my work shifts may occasionally be six (6) hours or less.  For that reason, I request to give up (waive) my unpaid meal period when I work a shift of six (6) hours or less."
                    tblBody2.Visible = False

                    tblBody3.Visible = True
                    lblBody3.InnerText = "Yo, " & txtEmpname.Text & ", y Claim Jumper Restaurants, LLC estamos de acuerdo que mi horario de trabajo a veces es de seis (6) horas o menos.  Por esa razón, renuncio voluntariamente a mi período de comida sin pago cuando trabajo un turno de menos de seis (6) horas."
                    tblBody4.Visible = False
                Else                            'Between 10-12 hours
                    tblTitle1.Visible = False
                    tblTitle2.Visible = True

                    tblBody1.Visible = False
                    tblBody2.Visible = True
                    lblBody2.InnerText = "I, " & txtEmpname.Text & ", and Claim Jumper Restaurants, LLC agree that my work shifts are sometimes over ten hours (10), but less than twelve (12).  For that reason, I request to give up (waive) my second unpaid meal period when I work a shift of more than ten (10), but less than twelve (12) hours."

                    tblBody3.Visible = False
                    tblBody4.Visible = True
                    lblBody4.InnerText = "Yo, " & txtEmpname.Text & ", y Claim Jumper Restaurants, LLC estamos de acuerdo que mi horario de trabajo a veces es mas de diez (10) horas, pero menos de doce (12).  Por esa razón, renuncio voluntariamente a mi segundo período de comida sin pago cuando trabajo un turno de mas de diez (10), pero menos de doce (12) horas."
                End If

                If txtPBWId.Text <= 0 Then
                    If txtStatus.Text = "2" Or txtStatus.Text = "" Then
                        txtStatus.Text = 1
                        tblRevoke.Visible = False
                    Else
                        txtStatus.Text = 2
                        tblRevoke.Visible = True
                    End If
                End If

                If txtPBWId.Text > 0 Then
                    cmdSubmit.Visible = False
                    Call LoadSignatures()

                    If txtStatus.Text = "1" Then
                        tblRevoke.Visible = False
                    Else
                        tblRevoke.Visible = False
                    End If
                End If

                cmdSubmit.Attributes.Add("onclick", "if(ValidateSubmit()){this.value = 'Please Wait'; this.disabled=true; " & GetPostBackEventReference(cmdSubmit).ToString & "} else{return false;}")
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Sub LoadSignatures()
        Try
            objdata = New clsData
            dsData = New DataSet
            Dim i As DataRow
            Dim j As Integer

            objdata.ConnectionString = Application("ConnString")

            If Not objdata.GetRset("GetPermBreakWaiverDetails " & txtPBWId.Text) Then
                Response.Write(objdata.ErrMsg)
            Else
                dsData = objdata.RecSet
            End If

            j = 0
            For Each i In dsData.Tables("DataSet").Rows()

                txtEffDate.Text = i("DateEff")

                'First line should be employee signature
                If j = 0 Then
                    txtSig1.Text = i("PersonSig")
                Else
                    txtSig2.Text = i("PersonSig")
                    txtManname.Text = i("Person")
                End If

                j = j + 1
            Next i

            dsData = Nothing
            objdata = Nothing
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

                .AppendParameter("@ClockId", "Integer", 4, txtClockId.Text)
                .AppendParameter("@BreakType", "Integer", 4, txtBreakType.Text)
                .AppendParameter("@WaiveFlag", "Integer", 4, txtStatus.Text)
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
                    Call DisplayStatus("Permanent Break Waiver form is already submitted for this employee .. Please click on the 'Edit' link if you want to edit that.", True)
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