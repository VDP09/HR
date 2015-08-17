Imports Web_CJEmployeeInfo


Namespace Web_CJEmployeeInfo

    Public Class clsGeneral
        Dim objData As clsData
        Dim dsData As DataSet

        Dim strConnString As String
        Dim lngClockId As Long
        Dim strUnitCity As String

        Dim strAdd1 As String
        Dim strAdd2 As String
        Dim strCity As String
        Dim strState As String
        Dim strZip As String
        Dim strHomePh As String
        Dim strEmpName As String
        Dim strStoreState As String

        Dim intUnit As Integer
        Dim intSecCode As Integer
        Dim blnHourly As Integer
        Dim intLeaveEmpType As Integer

        Dim strEmailTo As String
        Dim strEmailFrom As String
        Dim strEmailSubject As String
        Dim strEmailBody As String


        Public WriteOnly Property ConnectionString() As String
            Set(ByVal Value As String)
                strConnString = Value
            End Set
        End Property

        Public WriteOnly Property ClockId() As String
            Set(ByVal Value As String)
                lngClockId = Value
            End Set
        End Property

        Public ReadOnly Property UnitCity() As String
            Get
                UnitCity = strUnitCity
            End Get
        End Property


        Public ReadOnly Property Add1() As String
            Get
                Add1 = strAdd1
            End Get
        End Property

        Public ReadOnly Property Add2() As String
            Get
                Add2 = strAdd2
            End Get
        End Property

        Public ReadOnly Property City() As String
            Get
                City = strCity
            End Get
        End Property

        Public ReadOnly Property State() As String
            Get
                State = strState
            End Get
        End Property

        Public ReadOnly Property Zip() As String
            Get
                Zip = strZip
            End Get
        End Property

        Public ReadOnly Property HomePh() As String
            Get
                HomePh = strHomePh
            End Get
        End Property

        Public ReadOnly Property EmpName() As String
            Get
                EmpName = strEmpName
            End Get
        End Property

        Public ReadOnly Property StoreState() As String
            Get
                StoreState = strStoreState
            End Get
        End Property

        Public ReadOnly Property Unit() As Integer
            Get
                Unit = intUnit
            End Get
        End Property

        Public ReadOnly Property SecCode() As Integer
            Get
                SecCode = intSecCode
            End Get
        End Property

        Public ReadOnly Property HourlyFlag() As Boolean
            Get
                HourlyFlag = blnHourly
            End Get
        End Property

        Public ReadOnly Property LeaveEmpType() As Integer
            Get
                LeaveEmpType = intLeaveEmpType
            End Get
        End Property

        Public WriteOnly Property EmailTo() As String
            Set(ByVal Value As String)
                strEmailTo = Value
            End Set
        End Property

        Public WriteOnly Property EmailFrom() As String
            Set(ByVal Value As String)
                strEmailFrom = Value
            End Set
        End Property

        Public WriteOnly Property EmailSubject() As String
            Set(ByVal Value As String)
                strEmailSubject = Value
            End Set
        End Property

        Public WriteOnly Property EmailBody() As String
            Set(ByVal Value As String)
                strEmailBody = Value
            End Set
        End Property





        Public Function GetEmpDetails() As String

            objData = New clsData

            Try
                objData.ConnectionString = strConnString

                If Not objData.GetRset("GetEmpDetails " & lngClockId) Then
                    'MessageBox.Show(objData.ErrMsg)
                Else
                    dsData = objData.RecSet
                End If

                Dim i As DataRow
                Dim strEmp As String

                For Each i In dsData.Tables("DataSet").Rows()
                    strEmp = lngClockId & " - " & i("FName") & " " & FixNull(i("LName"))
                    strEmp = strEmp & " | Store : " & FixNull(i("Unit"))
                    strEmp = strEmp & " | Hire Date : " & FixNull(i("DateLastHire"))
                    'strEmp = strEmp & " | Status : " & FixNull(i("EmpStatus"))

                    strUnitCity = FixNull(i("UnitCity"))
                    strAdd1 = FixNull(i("Address1"))
                    strAdd2 = FixNull(i("Address2"))
                    strCity = FixNull(i("City"))
                    strState = FixNull(i("State"))
                    strZip = FixNull(i("Zip"))
                    strHomePh = FixNull(i("HomePh"))
                    strEmpName = i("FName") & " " & i("LName")
                    intUnit = FixNull(i("Unit"))
                Next

                dsData = Nothing
                objData = Nothing

                GetEmpDetails = strEmp

            Catch ex As Exception
                GetEmpDetails = ex.ToString()
            End Try

        End Function

        Public Function GetEmpSecurity() As Boolean
            objData = New clsData

            Try
                objData.ConnectionString = strConnString

                If Not objData.GetRset("GetEmpSecurity " & lngClockId) Then
                    GetEmpSecurity = False
                Else
                    GetEmpSecurity = True
                    dsData = objData.RecSet

                    Dim i As DataRow
                    intUnit = 0
                    intSecCode = 0

                    For Each i In dsData.Tables("DataSet").Rows()
                        intUnit = i("Unit")
                        intSecCode = i("SecCode")
                        blnHourly = i("HourlyFlag")
                        intLeaveEmpType = i("LeaveEmpType")
                        strStoreState = i("StoreState")
                    Next
                End If

                objData = Nothing
                dsData = Nothing

            Catch ex As Exception
                intUnit = 0
                intSecCode = 0
                blnHourly = False

                GetEmpSecurity = False
            End Try
        End Function

        Private Function FixNull(ByVal dbvalue) As String
            If dbvalue Is DBNull.Value Then
                Return ""
            Else
                Return dbvalue.ToString
            End If
        End Function

        Public Function SendEMail(Optional ByVal intPriority As Integer = 0)
            'Send email
            Dim objMail As New System.Web.Mail.MailMessage

            With objMail
                .To = strEmailTo
                .From = strEmailFrom
                .Bcc = strEmailFrom & "; rupeshp@ClaimJumper.com"
                .BodyFormat = Mail.MailFormat.Text
                .Subject = strEmailSubject
                .Body = strEmailBody

                If intPriority = 1 Then
                    .Priority = Mail.MailPriority.High
                End If
            End With

            System.Web.Mail.SmtpMail.SmtpServer = "mail.claimjumper.com" '"Express"   '"10.0.0.11" '"64.165.138.17"   '"www.claimjumper.com" '"express.claimjumper.com"
            System.Web.Mail.SmtpMail.Send(objMail)

            objMail = Nothing
        End Function
    End Class

End Namespace
