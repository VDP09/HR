Imports Web_CJEmployeeInfo.Web_CJEmployeeInfo

Public Class NewShift
    Inherits System.Web.UI.Page
    Dim objData As clsData
    Dim dsData As DataSet
    Dim dsEditReason As DataSet

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GetPunchData()
    End Sub

    Private Sub GetPunchData()
        Try
            'Display punch data in grid
            objData = New clsData
            Dim i As Integer
            Dim strUnit As String
            Dim intUnit As Integer
            Dim strTimeIN As String
            Dim strTimeOUT As String

            Dim intAddBCount As Integer
            Dim intSecCode As Integer

            strUnit = Request.Item("Unit")
            intSecCode = Request.Item("SC")

            intUnit = strUnit 'CType(strUnit.Substring(0, strUnit.IndexOf("-") - 1), Integer)

            intAddBCount = Request.Item("AddNew")

            'Title
            Response.Write("<form name=frmNewShift method=post action='UpdateEditPunch.aspx' onSubmit='return ValidateFormData();'>")
            Response.Write("<table width='100%'cellspacing=0 cellpadding=0")
            Response.Write("<tr><td align=center><FONT face='Monotype Corsiva' color='#006699' size=5><b>Add New Shift</b></font></td></tr>")
            Response.Write("<tr><td align=center><font face='Arial' size=2><b>" & Request.Item("EName") _
                & "</b></td></tr>")


            'Line
            Response.Write("<tr><td align=center><hr SIZE=2 color='#006699'></td></tr>")

            'Add Break
            Response.Write("<tr><td>")
            Response.Write("<table width='100%' cellspacing=0 cellpadding=0>")
            Response.Write("<tr align=left><td width='85%'><font face=arial size=2>Click this button " _
                & "to add a Break. You can click it multiple times to add more breaks.</font></td>" _
                & "<td width='7%' align=center><font face='wingdings' size=6><B>F</B></font></td>" _
                & "<td><input style='FONT-WEIGHT: bold; FONT-SIZE: x-small; FONT-FAMILY: Arial; width:100px' type=button value='Add Break' name=cmdAddBreak onclick='AddNew();'>")
            Response.Write("</td></tr></table>")
            Response.Write("</td></tr>")


            'First Table (Dept, Date, Tips, Sales)
            Response.Write("<tr><td align=center>")
            Response.Write("<table width='100%' border = 1 cellspacing=0 cellpadding=1 bgColor='powderblue'>")
            Response.Write("<tr align=center><td width='20%'><font face=arial size=2><b>Date Worked</b></font></td>" _
                            & "<td align=center width='40%'><font face=arial size=2><b>Department</b></font></td>" _
                            & "<td align=center width='20%'><font face=arial size=2><b>Dec Tips ($)</b></font></td>" _
                            & "<td align=center width='20%'><font face=arial size=2><b>Sales ($)</b></font></td></tr>")

            Response.Write("<tr>")
            Response.Write("<td align=center><input type=text Preset=shortdate Class=mask style='FONT-WEIGHT: bold; FONT-FAMILY:Courier New; BORDER-TOP: 1px solid; BORDER-RIGHT: 1px solid; BORDER-LEFT: 1px solid; BORDER-BOTTOM: 1px solid; width=100px; TEXT-ALIGN: left; BACKGROUND-COLOR:PapayaWhip' name=txtDOB></td>")
            Response.Write("<td align=center><select name=cmbJobCode style='width=200px; FONT-SIZE:11px; BACKGROUND-COLOR:PapayaWhip'>" & GetJobCodeList(intSecCode) & "</select></td>")
            Response.Write("<td align=center><input type=text Preset=currency Class=mask style='FONT-WEIGHT: bold; FONT-FAMILY:Courier New; BORDER-TOP: 1px solid; BORDER-RIGHT: 1px solid; BORDER-LEFT: 1px solid; BORDER-BOTTOM: 1px solid; width=70px; TEXT-ALIGN: left;' name=txtDecTips value=0></td>")
            Response.Write("<td align=center><input type=text Preset=currency Class=mask style='FONT-WEIGHT: bold; FONT-FAMILY:Courier New; BORDER-TOP: 1px solid; BORDER-RIGHT: 1px solid; BORDER-LEFT: 1px solid; BORDER-BOTTOM: 1px solid; width=70px; TEXT-ALIGN: left;' name=txtSales value=0></td></tr>")
            Response.Write("</table></td></tr>")

            'Space
            Response.Write("<tr><td><font size='1px'>&nbsp;</font></td></tr>")


            'Headings
            Response.Write("<tr><td>")
            Response.Write("<table width='100%' border = 1 cellspacing=0 cellpadding=1 bgColor='powderblue'>")
            Response.Write("<tr align=center><td width='25%'>&nbsp;</td>" _
                            & "<td align=center width='15%'><font face=arial size=2><b>Time IN ( hh:mm )</b></font></td>" _
                            & "<td align=center width='15%'><font face=arial size=2><b>Time OUT ( hh:mm )</b></font></td>" _
                            & "<td align=center width='15%'><font face=arial size=2><b>Time Elapsed ( hh:mm )</b></font></td>" _
                            & "<td align=center width='15%'><font face=arial size=2><b>Paid ?</b></font></td></tr>")


            'Display Punch details
            Response.Write("<tr align=center><td><font face=arial size=2><b>Punch Details</b></font></td>" _
                & "<td><input type=text class='txtbox' maxLength=2 name=txtHPunchIN>" _
                & " <B>:</B> <input type=text class='txtbox' maxLength=2 name=txtMPunchIN></td>" _
                & "<td><input type=text class='txtbox' maxLength=2 name=txtHPunchOUT>" _
                & " <B>:</B> <input type=text class='txtbox' maxLength=2 name=txtMPunchOUT></td>" _
                & "<td><b><input type=text class='txtboxDisp' name=txtPETime Disabled></b></td>" _
                & "<td>&nbsp;</td></tr>")

            'onchange='Validate();'

            'Add additional breaks
            i = 1
            While i <= intAddBCount
                Response.Write("<tr align=center><td><font face=arial size=2><b>Break - " & i & "</b></font></td>" _
                    & "<td><input type=text class='txtbox' maxLength=2 name=txtHBIN" & i & " value=''>" _
                    & " <B>:</B> <input type=text class='txtbox' maxLength=2 name=txtMBIN" & i & " value=''></td>" _
                    & "<td><input type=text class='txtbox' maxLength=2 name=txtHBOUT" & i & " value=''>" _
                    & " <B>:</B> <input type=text class='txtbox' maxLength=2 name=txtMBOUT" & i & " value=''></td>" _
                    & "<td><b><input type=text class='txtboxDisp' name=txtBETime" & i & " value='' Disabled></b></td>" _
                    & "<td><select name=cmbBPaid" & i & " style='width=60px; FONT-SIZE:11px'>" & GetPaidUnPaidList() & "</select></td></tr>")


                i = i + 1
            End While

            'Total Paid Time
            Response.Write("</table></td></tr>")
            Response.Write("<tr><td align=center>")
            Response.Write("<table><tr>")
            Response.Write("<td align=right width='440px'><font face=arial size=2><b>Total Paid Time ( hh:mm )</b></font>&nbsp;</td><td align=left width='200px'><input type=text class='txtboxDisp' name=txtTotPaid Disabled></td>")

            If Request.Item("PBW") = 1 Then
                Response.Write("</tr></table>")
                Response.Write("</td></tr>")
                Response.Write("<tr><td align=center><font face=arial size=2><b>Employee has signed Both Permanent Break Waivers</b></font></td></tr>")

            ElseIf Request.Item("PBW") = 2 Then 'Not CA store
                Response.Write("</tr></table>")
                Response.Write("</td></tr>")

            Else
                Response.Write("</tr><tr><td align=right width='440px'><font face=arial size=2><b>Waive Unpaid Missed Break, If Any</b></font>&nbsp;</td><td align=left width='200px'><input type=checkbox name=chkWaive checked><font face=arial size=1 color=red>&nbsp;&nbsp;(Employee must have signed the daily break waiver form)</font></td>")
                Response.Write("</tr></table>")
                Response.Write("</td></tr>")
            End If

            'Line
            Response.Write("<tr><td><hr SIZE=2 color='#006699'></td></tr>")

            'Buttons
            Response.Write("<tr><td align=center><input type=button style='FONT-WEIGHT: bold; FONT-SIZE: x-small; FONT-FAMILY: Arial; width:190px' value='Calculate Total Paid Time' name=cmdRecalETime onclick='RecalElapsedTime();'>" _
                & "&nbsp;&nbsp;<input style='FONT-WEIGHT: bold; FONT-SIZE: x-small; FONT-FAMILY: Arial; width:100px' type=submit value='Update' name=cmdSubmit >" _
                & "&nbsp;&nbsp;<input style='FONT-WEIGHT: bold; FONT-SIZE: x-small; FONT-FAMILY: Arial; width:100px' type=button value='Reset' name=cmdReset onclick='ResetPage();'>" _
                & "&nbsp;&nbsp;<input style='FONT-WEIGHT: bold; FONT-SIZE: x-small; FONT-FAMILY: Arial; width:100px' type=button value='Exit' name=cmdExit onclick='window.close();'>" _
                & "</td></tr>")

            'Message
            Response.Write("<tr><td align=center>&nbsp;</td></tr>")
            Response.Write("<tr><td align=center style='color:#f00; FONT-FAMILY: Arial; FONT-WEIGHT: bold;'><DIV id=divMessage></DIV></td></tr>")


            Response.Write("</table>")

            'Hidden fields
            Response.Write("<input type=hidden name=txtBCount value=" & intAddBCount + 1 & ">")
            Response.Write("<input type=hidden name=txtUnit value=" & intUnit & ">")
            Response.Write("<input type=hidden name=txtClockId value=" & Request.Item("ClockId") & ">")
            Response.Write("<input type=hidden name=txtEName value='" & Request.Item("EName") & "'>")
            Response.Write("<input type=hidden name=txtUnit1 value='" & Request.Item("Unit") & "'>")
            Response.Write("<input type=hidden name=txtManClockId value='" & Request.Item("MCId") & "'>")
            Response.Write("<input type=hidden name=txtUpdateType value='New'>")

            Response.Write("</form>")
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Sub

    Private Function GetPaidUnPaidList(Optional ByVal strPaid As String = "Yes") As String
        Try

            Dim strList As String

            If strPaid = "Yes" Then
                strList = "<option value='Yes' selected>Paid</option>" _
                    & "<option value='No'>UnPaid</option>"
            Else
                strList = "<option value='Yes'>Paid</option>" _
                    & "<option value='No' selected>UnPaid</option>"
            End If

            GetPaidUnPaidList = strList
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Function

    Private Function GetJobCodeList(ByVal intSC As Integer) As String
        Try
            Dim strList As String
            objData = New clsData
            Dim i As DataRow

            objData.ConnectionString = Application("ConnString")

            If Not objData.GetRset("GetStoreJobCodeList " & intSC) Then
                'MessageBox.Show(objData.ErrMsg)
            Else
                dsData = objData.RecSet
            End If

            strList = "<option value=0 selected></option>"

            For Each i In dsData.Tables("DataSet").Rows
                strList = strList & "<option value=" & i(0) & ">" & i(1) & "</option>"
            Next i

            objData = Nothing
            dsData = Nothing

            GetJobCodeList = strList
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "alert", "alert('" + ex.Message.Replace(Environment.NewLine, " ").Replace("'", " ") + "');", True)
        End Try
    End Function

End Class