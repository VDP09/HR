Public Class Result
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

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Put user code to initialize the page here
        txtStatus.Text = Request("E")

        If txtStatus.Text = 0 Then
            cmdBack.Visible = False

            Dim strscript As String
            strscript = "<SCRIPT>var message='Function Disabled';" _
                & "function clickIE4(){" _
                & "if (event.button==2){" _
                & "alert(message);" _
                & "return false;	}}" _
                & "function clickNS4(e){" _
                & "if (document.layers||document.getElementById&&!document.all){" _
                & "if (e.which==2||e.which==3){" _
                & "alert(message);" _
                & "return false; }}}" _
                & "if (document.layers){" _
                & "document.captureEvents(Event.MOUSEDOWN);" _
                & "document.onmousedown=clickNS4;}" _
                & "else if (document.all&&!document.getElementById){" _
                & "document.onmousedown=clickIE4;}" _
                & "document.oncontextmenu=new Function('alert(message);return false')</SCRIPT>"

            Page.RegisterClientScriptBlock("DisableRightClick", strscript)

        End If

        'lblMessage.Text = Request("M")  '.Replace("|", Chr(13))
        lblMessage.InnerHtml = Request("M").Replace("|", "<P>")

        'lblError.Text = Request("EM")
        lblError.InnerHtml = Request("EM").Replace("|", "<P>")
    End Sub

End Class