Namespace Web_CJEmployeeInfo

    Public Class clsData

        Private connDatabase As SqlClient.SqlConnection
        Private cdDatabase As SqlClient.SqlCommand
        Private adpDatabase As SqlClient.SqlDataAdapter
        Private dsDatabase As DataSet
        Private drDatabase As SqlClient.SqlDataReader
        Private prmData As SqlClient.SqlParameter

        Private strErrMsg As String
        Private intReturnCode As Integer
        Private strConnString As String

        Public WriteOnly Property ConnectionString() As String
            Set(ByVal Value As String)
                strConnString = Value
            End Set
        End Property

        Public ReadOnly Property ErrMsg() As String
            Get
                ErrMsg = strErrMsg
            End Get
        End Property

        Public ReadOnly Property ReturnCode() As Integer
            Get
                ReturnCode = intReturnCode
            End Get
        End Property

        Public ReadOnly Property RecSet() As DataSet
            Get
                RecSet = dsDatabase
            End Get
        End Property

        Public Sub New()
            MyBase.New()
            cdDatabase = New SqlClient.SqlCommand
            adpDatabase = New SqlClient.SqlDataAdapter
        End Sub

        Protected Overrides Sub Finalize()
            connDatabase = Nothing
            cdDatabase = Nothing
            adpDatabase = Nothing
            dsDatabase = Nothing
            drDatabase = Nothing
            prmData = Nothing

            MyBase.Finalize()
        End Sub

        Public Function AppendParameter(ByVal strPName As String, ByVal strPDataType As String, ByVal intPLength As Short, ByVal strPValue As Object) As Object
            If strPDataType = "Char" Then
                prmData = cdDatabase.Parameters.Add(strPName, SqlDbType.VarChar, intPLength)
                prmData.Value = CType(strPValue, String)
            ElseIf strPDataType = "Integer" Then
                prmData = cdDatabase.Parameters.Add(strPName, SqlDbType.Int, 4)
                prmData.Value = CType(strPValue, Integer)
            ElseIf strPDataType = "Bit" Then
                prmData = cdDatabase.Parameters.Add(strPName, SqlDbType.Bit, 1)
                prmData.Value = strPValue
            ElseIf strPDataType = "Date" Then
                prmData = cdDatabase.Parameters.Add(strPName, SqlDbType.DateTime, 8)
                prmData.Value = strPValue
            ElseIf strPDataType = "Currency" Then
                prmData = cdDatabase.Parameters.Add(strPName, SqlDbType.Money, 8)
                prmData.Value = strPValue
            ElseIf strPDataType = "Decimal" Then
                prmData = cdDatabase.Parameters.Add(strPName, SqlDbType.Decimal)
                prmData.Value = strPValue
            End If
        End Function

        Public Function AppendOutputParm() As Object
            'Append one output parameter for return error code
            prmData = cdDatabase.Parameters.Add("@ReturnCode", SqlDbType.Int, 4)
            prmData.Direction = ParameterDirection.Output
        End Function

        Public Function ExecuteCommand(ByVal strProcName As String) As Boolean

            On Error GoTo ErrHand

            If Not SetDataBaseConnection() Then
                ExecuteCommand = False
            Else

                With cdDatabase
                    .CommandText = strProcName
                    .CommandType = CommandType.StoredProcedure
                    .Connection = connDatabase
                    .ExecuteNonQuery()
                End With

                intReturnCode = cdDatabase.Parameters("@ReturnCode").Value
                ExecuteCommand = True
            End If

            Call CloseDatabaseConn()

            Exit Function

ErrHand:
            ExecuteCommand = False

            If Err.Number = -2147217873 Then
                strErrMsg = "Duplicate record .. Please check it out"
            Else
                strErrMsg = "Following error occured .. Please contact your Network Administrator" & Chr(13) & Chr(13) & Err.Number & " - " & Err.Description
            End If
        End Function

        Public Function GetRset(ByVal strSQL As String) As Boolean

            On Error GoTo ErrHand

            dsDatabase = New DataSet("DataSet")

            If Not SetDataBaseConnection() Then
                GetRset = False
                Exit Function
            End If

            With cdDatabase
                .CommandText = strSQL
                .CommandType = CommandType.Text
                .Connection = connDatabase
            End With

            adpDatabase.SelectCommand = cdDatabase
            adpDatabase.Fill(dsDatabase, "DataSet")

            'drDatabase = cdDatabase.ExecuteReader
            GetRset = True

            Call CloseDatabaseConn()
            Exit Function

ErrHand:
            strErrMsg = "Following error occurred .. Please contact your Network Admin" & Chr(13) & Chr(13) & Err.Number & " - " & Err.Description

        End Function

        Private Function SetDataBaseConnection() As Boolean
            'Set global database connection
            On Error GoTo ErrHand

            connDatabase = New SqlClient.SqlConnection

            With connDatabase
                .ConnectionString = strConnString
                .Open()
            End With

            SetDataBaseConnection = True
            Exit Function

ErrHand:
            If Err.Number = -2147217843 Then
                strErrMsg = "Invalid User Name or Password .. Please check it out"
            ElseIf Err.Number = -2147467259 Then
                strErrMsg = "Invalid Server or Database .. Please check it out"
            Else
                strErrMsg = "There is an error connecting Database .. Please Contact your program vendor " & Chr(13) & Err.Number & " - " & Err.Description
            End If

            SetDataBaseConnection = False
        End Function

        Private Sub CloseDatabaseConn()
            'Close database connection
            connDatabase.Close()
            connDatabase.Dispose()
        End Sub
    End Class
End Namespace
