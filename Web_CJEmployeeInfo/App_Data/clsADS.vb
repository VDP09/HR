Namespace Web_CJEmployeeInfo

    Public Class clsADS

        'Private Const _FOREST = 5                       'Default for a Forest objectClass
        'Private Const _DOMAINCHILD = 13                 'Default for a Domain objectClass
        'Private Const _UNIVERSAL_SECURITY = -2147483640
        'Private Const _GLOBAL_SECURITY = -2147483646

        Private objADS As System.DirectoryServices.DirectoryEntry
        Private objUserInfo As System.DirectoryServices.DirectoryEntry
        Private objGroup As System.DirectoryServices.DirectoryEntry
        Private strUserLogin As String
        Private strUserClockId As String
        Private strGroup As String
        Private strUserAttributes() As UserProperty
        Private strErrMsg As String

        Private Structure UserProperty
            Dim strPName As String
            Dim strPValue As String
        End Structure

        Public Property UserLogin()
            Get
                UserLogin = strUserLogin
            End Get
            Set(ByVal Value)
                strUserLogin = Value
            End Set
        End Property

        Public Property UserClockId()
            Get
                UserClockId = strUserClockId
            End Get
            Set(ByVal Value)
                strUserClockId = Value
            End Set
        End Property

        Public Property ErrMsg()
            Get
                ErrMsg = strErrMsg
            End Get
            Set(ByVal Value)
                strErrMsg = Value
            End Set
        End Property

        Public Property Group()
            Get
                Group = strGroup
            End Get
            Set(ByVal Value)
                strGroup = Value
            End Set
        End Property

        Public Function GetAttribute(ByVal strPName As String) As String
            Return CheckForNothing(objUserInfo.Properties(strPName).Value)
        End Function

        Public Function AddAttribute(ByVal strAtt As String, ByVal strAttVal As String)
            Dim i As Integer

            If strUserAttributes Is Nothing Then
                i = 1
            Else
                i = strUserAttributes.GetUpperBound(0)
                i = i + 1
            End If

            ReDim Preserve strUserAttributes(i)
            strUserAttributes(i - 1).strPName = strAtt
            strUserAttributes(i - 1).strPValue = strAttVal
        End Function

        Private Function GetADsObject(ByVal ADsType As String, ByVal ADsName As String, ByVal LDAP As Boolean) As Boolean

            Dim strFilter As String

            Try
                If ADsType = "person" Then
                    If strUserLogin = "" Then
                        strFilter = "(&(ObjectClass={0})(employeeid={1}))"
                    Else
                        strFilter = "(&(ObjectClass={0})(sAMAccountName={1}))"
                    End If
                Else
                    strFilter = "(&(ObjectClass={0})(sAMAccountName={1}))"
                End If

                Dim ADsFilter As String = String.Format(strFilter, ADsType, ADsName)
                Dim ADsRoot = GetObject("GC://rootDSE")
                Dim strRootForest As String

                'Get RootDomain
                If LDAP Then
                    strRootForest = "LDAP://" & ADsRoot.get("rootDomainNamingContext")
                Else
                    strRootForest = "GC://" & ADsRoot.get("rootDomainNamingContext")
                End If

                Dim root As New System.DirectoryServices.DirectoryEntry(strRootForest)
                root.AuthenticationType = System.DirectoryServices.AuthenticationTypes.Delegation

                Dim searcher As New System.DirectoryServices.DirectorySearcher(root)
                searcher.SearchScope = System.DirectoryServices.SearchScope.Subtree
                searcher.ReferralChasing = System.DirectoryServices.ReferralChasingOption.All
                'searcher.PropertiesToLoad.AddRange(LoadProps)
                searcher.Filter = ADsFilter

                Dim search As System.DirectoryServices.SearchResult = searcher.FindOne()
                'Dim search As System.DirectoryServices.SearchResult = searcher.FindAll

                'Dim ADsObject As System.DirectoryServices.DirectoryEntry
                objADS = search.GetDirectoryEntry
                Return True
            Catch ex As Exception
                ErrMsg = "GetADsObject : " & ex.ToString()
                Return False
            End Try

        End Function

        Public Function LoadUser() As Boolean
            If strUserLogin <> "" Then
                If GetADsObject("person", strUserLogin, True) Then
                    objUserInfo = objADS
                    LoadUser = True
                Else
                    LoadUser = False
                End If
            Else
                If GetADsObject("person", strUserClockId, True) Then
                    objUserInfo = objADS
                    LoadUser = True
                Else
                    LoadUser = False
                End If
            End If
        End Function

        Public Function LoadGroup() As Boolean
            If GetADsObject("group", strGroup, True) Then
                objGroup = objADS
                LoadGroup = True
            Else
                LoadGroup = False
            End If
        End Function

        Public Function SaveAttributes() As Boolean
            Dim i As Integer

            If Not objUserInfo Is Nothing Then
                Try
                    objUserInfo.AuthenticationType = System.DirectoryServices.AuthenticationTypes.Delegation
                    'userInfo.Username = "rupeshp@claimjumper.com"
                    'userInfo.Password = ""

                    With objUserInfo
                        'Set properties
                        For i = 0 To strUserAttributes.GetUpperBound(0) - 1
                            .Properties(strUserAttributes(i).strPName).Value = strUserAttributes(i).strPValue
                        Next

                        'Save changes
                        .CommitChanges()
                    End With

                    Return True
                Catch e As Exception
                    ErrMsg = e.ToString()
                    Return False
                End Try
            End If

            objUserInfo = Nothing
        End Function

        Public Function GetUserGroups() As String()
            Dim i As Integer
            Dim strGroups() As String

            If Not objUserInfo Is Nothing Then
                objUserInfo.AuthenticationType = System.DirectoryServices.AuthenticationTypes.Delegation

                Dim iCount As Integer = objUserInfo.Properties("MemberOf").Count
                If iCount > 0 Then
                    For i = 0 To iCount - 1
                        Dim gADs As String = objUserInfo.Properties("MemberOf").Item(i)
                        Dim myGroup As String = Left(gADs, (InStr(gADs, ",") - 1))
                        ReDim Preserve strGroups(i)
                        strGroups(i) = myGroup.Replace("CN=", "")
                    Next
                End If
            End If

            Return strGroups
        End Function

        Public Function AddToGroup() As Boolean
            If Not objGroup Is Nothing And Not objUserInfo Is Nothing Then
                Try
                    objUserInfo.AuthenticationType = System.DirectoryServices.AuthenticationTypes.Delegation
                    objGroup.AuthenticationType = System.DirectoryServices.AuthenticationTypes.Delegation

                    'If Not IsMember(usr, grp) Then
                    Dim strDisName As String = objUserInfo.Properties("distinguishedName").Value
                    objGroup.Properties("Member").Add(strDisName)
                    objGroup.CommitChanges()
                    'End If
                    Return True
                Catch e As Exception
                    ErrMsg = e.ToString()
                    Return False
                End Try
            End If
        End Function

        Public Function RemoveFromGroup() As Boolean
            If Not objGroup Is Nothing And Not objUserInfo Is Nothing Then
                Try
                    objUserInfo.AuthenticationType = System.DirectoryServices.AuthenticationTypes.Delegation
                    objGroup.AuthenticationType = System.DirectoryServices.AuthenticationTypes.Delegation

                    'If Not IsMember(usr, grp) Then
                    Dim strDisName As String = objUserInfo.Properties("distinguishedName").Value
                    objGroup.Properties("Member").Remove(strDisName)
                    objGroup.CommitChanges()
                    'End If
                    Return True
                Catch e As Exception
                    ErrMsg = e.ToString()
                    Return False
                End Try
            End If
        End Function

        Public Function GetGroupUsers() As String()
            Dim strUsers() As String
            Dim intCount As Integer
            Dim strFullLine As String
            Dim strGroupUser As String
            Dim i As Integer

            If Not objGroup Is Nothing Then
                objGroup.AuthenticationType = System.DirectoryServices.AuthenticationTypes.Delegation
                intCount = objGroup.Properties("Member").Count
                If intCount > 0 Then
                    For i = 0 To intCount - 1
                        strFullLine = objGroup.Properties("Member").Item(i)
                        strGroupUser = Left(strFullLine, (InStr(strFullLine, ",") - 1))
                        ReDim Preserve strUsers(i)
                        strUsers(i) = strGroupUser.Replace("CN=", "")
                    Next
                End If
            End If
            Return strUsers
        End Function

        Public Function GetAllGroups() As String()
            Dim strResult() As String
            Dim ADsRoot = GetObject("GC://rootDSE")
            Dim strRootForest As String
            Dim objSearch As New System.DirectoryServices.DirectorySearcher
            Dim colQueryResults As System.DirectoryServices.SearchResultCollection
            Dim objResult As System.DirectoryServices.SearchResult
            Dim i As Integer

            strRootForest = "LDAP://" & ADsRoot.get("rootDomainNamingContext")
            objSearch.SearchRoot = New System.DirectoryServices.DirectoryEntry(strRootForest)
            objSearch.Filter = "(&(objectclass=group)(objectcategory=group))"
            objSearch.SearchScope = System.DirectoryServices.SearchScope.Subtree
            objSearch.PropertiesToLoad.Add("cn")
            colQueryResults = objSearch.FindAll()

            i = 0
            For Each objResult In colQueryResults
                ReDim Preserve strResult(i)
                strResult(i) = objResult.Properties("cn")(0)
                i = i + 1
            Next

            Return strResult
        End Function

        Private Function GetAllUsers() As String()
            Dim strResult() As String
            Dim ADsRoot = GetObject("GC://rootDSE")
            Dim strRootForest As String
            Dim objSearch As New System.DirectoryServices.DirectorySearcher
            Dim colQueryResults As System.DirectoryServices.SearchResultCollection
            Dim objResult As System.DirectoryServices.SearchResult
            Dim i As Integer

            strRootForest = "LDAP://" & ADsRoot.get("rootDomainNamingContext")
            objSearch.SearchRoot = New System.DirectoryServices.DirectoryEntry(strRootForest)
            objSearch.Filter = "(&(objectclass=user)(objectcategory=person))"
            objSearch.SearchScope = System.DirectoryServices.SearchScope.Subtree
            objSearch.PropertiesToLoad.Add("cn")
            colQueryResults = objSearch.FindAll()

            i = 0
            For Each objResult In colQueryResults
                ReDim Preserve strResult(i)
                strResult(i) = objResult.Properties("cn")(0)
                i = i + 1
            Next

            Return strResult
        End Function

        Public Function ResetPassword(ByVal strNewPass As String) As Boolean
            Dim i As Integer
            'Dim strResult() As String
            'Dim strP As String

            If Not objUserInfo Is Nothing Then
                Try
                    objUserInfo.AuthenticationType = System.DirectoryServices.AuthenticationTypes.Delegation
                    objUserInfo.Invoke("SetPassword", strNewPass)
                    objUserInfo.CommitChanges()
                    ResetPassword = True
                Catch ex As Exception
                    ErrMsg = ex.ToString()
                    ResetPassword = False
                End Try

                'i = 0
                'For Each strP In objUserInfo.Properties.PropertyNames
                '    ReDim Preserve strResult(i)
                '    strResult(i) = strP 'objUserInfo.Properties.Item(i).Value
                '    i = i + 1
                'Next
            End If
        End Function

        Public Function CreateUser(ByVal strLogin As String) As Boolean

            Try
                Dim Adsobject As New System.DirectoryServices.DirectoryEntry("LDAP://CN=Users,dc=claimjumper,dc=com", "appladmin", "adminappl")
                'Dim Adsobject As New System.DirectoryServices.DirectoryEntry("LDAP://CN=Users,dc=claimjumper,dc=com")

                Adsobject.AuthenticationType = DirectoryServices.AuthenticationTypes.Delegation

                Dim cc As System.DirectoryServices.DirectoryEntry
                cc = Adsobject.Children.Add("CN=" & strLogin, "user")

                cc.Properties("sAMAccountName").Add(strLogin)
                cc.Properties("description").Add("")
                cc.Properties("employeeid").Add(strUserClockId)
                cc.CommitChanges()
                CreateUser = True

            Catch ex As Exception
                ErrMsg = ex.ToString()
                CreateUser = False
            End Try

        End Function

        Public Function UnlockUserAccount() As Boolean
            If Not objUserInfo Is Nothing Then
                Try
                    objUserInfo.AuthenticationType = System.DirectoryServices.AuthenticationTypes.Delegation
                    objUserInfo.Invoke("IsAccountLocked", "False")
                    objUserInfo.CommitChanges()
                    UnlockUserAccount = True
                Catch ex As Exception
                    ErrMsg = ex.ToString()
                    UnlockUserAccount = False
                End Try
            End If
        End Function

        Private Function CheckForNothing(ByVal value As Object) As String
            If value Is Nothing Then
                Return ""
            Else
                Return value.ToString
            End If
        End Function

        Protected Overrides Sub Finalize()
            objUserInfo = Nothing
            objGroup = Nothing
            objADS = Nothing
            MyBase.Finalize()
        End Sub

    End Class

End Namespace
