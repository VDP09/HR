Imports System.Web
Imports System.Web.SessionState
Imports Web_CJEmployeeInfo.Web_CJEmployeeInfo

Public Class Global_asax
    Inherits HttpApplication

    Dim objData As clsData
    Dim dsData As DataSet

#Region " Component Designer Generated Code "

    Public Sub New()
        MyBase.New()

        'This call is required by the Component Designer.
        InitializeComponent()

        'Add any initialization after the InitializeComponent() call

    End Sub

    'Required by the Component Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Component Designer
    'It can be modified using the Component Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        components = New System.ComponentModel.Container()
    End Sub

#End Region

    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        'HRE database conn string
        'Application("ConnString") = "database=Employee;Server=Motherlode;" _
        '& "User Id=EmployeeAdmin;password=lotusr"

        'Application("ConnString") = "database=Employee;Server=main\sqlserver2008;" _
        '& "User Id=sa;password="

        Application("ConnString") = "database=KSD_EMPLOYEE;Server=main\sqlserver2008;" _
        & "User Id=sa;password="


        'Mineshaft conn string
        'Application("MSConnStr") = "server=Motherlode;uid=rupeshp;pwd=rupesh;database=Mineshaft"

        'Application("ConnString") = "database=Employee;Server=CJ-DEVELOPER;" _
        '        & "User Id=gradmin;password=cjcorp"

        'Final user
        ' User: HRExpressApp
        ' Password : appnumber1
        'For Mineshaft
        ' User: MineshaftApp
        ' Password: appnumber2


        'Get List Values ------------------------------------------------


        'Pay Rate Change Reasons
        objData = New clsData

        objData.ConnectionString = Application("ConnString")

        If Not objData.GetRset("GetItemList 'PayRateChange'") Then
            'MessageBox.Show(objData.ErrMsg)
        Else
            dsData = objData.RecSet
        End If

        Application("ChangeReason") = dsData

        objData = Nothing
        dsData = Nothing


        'Job Codes
        objData = New clsData

        objData.ConnectionString = Application("ConnString")

        If Not objData.GetRset("GetAllJobCodeList") Then
            'MessageBox.Show(objData.ErrMsg)
        Else
            dsData = objData.RecSet
        End If

        Application("JobCode") = dsData

        dsData = Nothing
        objData = Nothing


        'Store Job Codes
        objData = New clsData

        objData.ConnectionString = Application("ConnString")

        If Not objData.GetRset("GetStoreJobCodeList") Then
            'MessageBox.Show(objData.ErrMsg)
        Else
            dsData = objData.RecSet
        End If

        Application("StoreJobCode") = dsData

        objData = Nothing
        dsData = Nothing


        'Company
        objData = New clsData

        objData.ConnectionString = Application("ConnString")

        If Not objData.GetRset("GetItemList 'Company'") Then
            'MessageBox.Show(objData.ErrMsg)
        Else
            dsData = objData.RecSet
        End If

        Application("Company") = dsData

        dsData = Nothing
        objData = Nothing


        'Store List
        objData = New clsData

        objData.ConnectionString = Application("ConnString")

        If Not objData.GetRset("GetAllStoreList") Then
            'MessageBox.Show(objData.ErrMsg)
        Else
            dsData = objData.RecSet
        End If

        Application("Store") = dsData

        objData = Nothing
        dsData = Nothing


        'States
        objData = New clsData

        objData.ConnectionString = Application("ConnString")

        If Not objData.GetRset("GetItemList 'State'") Then
            'MessageBox.Show(objData.ErrMsg)
        Else
            dsData = objData.RecSet
        End If

        Application("State") = dsData

        objData = Nothing
        dsData = Nothing

        objData = New clsData


        'I9 Status
        objData.ConnectionString = Application("ConnString")

        If Not objData.GetRset("GetItemList 'I9Status'") Then
            'MessageBox.Show(objData.ErrMsg)
        Else
            dsData = objData.RecSet
        End If

        Application("I9Status") = dsData

        objData = Nothing
        dsData = Nothing


        'Federal Marital Status
        objData = New clsData

        objData.ConnectionString = Application("ConnString")

        If Not objData.GetRset("GetItemList 'FedMaritalStatus'") Then
            'MessageBox.Show(objData.ErrMsg)
        Else
            dsData = objData.RecSet
        End If

        Application("FedMaritalStatus") = dsData

        objData = Nothing
        dsData = Nothing

        'State Marital Status
        objData = New clsData

        objData.ConnectionString = Application("ConnString")

        If Not objData.GetRset("GetItemList 'StateMaritalStatus'") Then
            'MessageBox.Show(objData.ErrMsg)
        Else
            dsData = objData.RecSet
        End If

        Application("StateMaritalStatus") = dsData

        objData = Nothing
        dsData = Nothing


        'A4 Ded
        objData = New clsData

        objData.ConnectionString = Application("ConnString")

        If Not objData.GetRset("GetItemList 'A4Ded'") Then
            'MessageBox.Show(objData.ErrMsg)
        Else
            dsData = objData.RecSet
        End If

        Application("A4Ded") = dsData

        objData = Nothing
        dsData = Nothing


        'Job Titles
        objData = New clsData

        objData.ConnectionString = Application("ConnString")

        If Not objData.GetRset("GetItemList 'JobTitle'") Then
            'MessageBox.Show(objData.ErrMsg)
        Else
            dsData = objData.RecSet
        End If

        Application("JobTitle") = dsData

        objData = Nothing
        dsData = Nothing


        'Ethnicity
        objData = New clsData

        objData.ConnectionString = Application("ConnString")

        If Not objData.GetRset("GetItemList 'Ethnicity'") Then
            'MessageBox.Show(objData.ErrMsg)
        Else
            dsData = objData.RecSet
        End If

        Application("Ethnicity") = dsData

        objData = Nothing
        dsData = Nothing


        'Emp Referral
        objData = New clsData

        objData.ConnectionString = Application("ConnString")

        If Not objData.GetRset("GetItemList 'EmpReferral'") Then
            'MessageBox.Show(objData.ErrMsg)
        Else
            dsData = objData.RecSet
        End If

        Application("EmpReferral") = dsData

        objData = Nothing
        dsData = Nothing


        'Seperation Reason list
        objData = New clsData
        objData.ConnectionString = Application("ConnString")

        If Not objData.GetRset("GetItemList 'EmpSeperation'") Then
            'MessageBox.Show(objData.ErrMsg)
        Else
            dsData = objData.RecSet
        End If

        Application("EmpSeperation") = dsData

        objData = Nothing
        dsData = Nothing

        'Seperation Sub Reasons list
        objData = New clsData
        objData.ConnectionString = Application("ConnString")

        If Not objData.GetRset("GetItemCatList") Then
            'MessageBox.Show(objData.ErrMsg)
        Else
            dsData = objData.RecSet
        End If

        Application("SepCatList") = dsData

        dsData = Nothing
        objData = Nothing

        'Education list
        objData = New clsData
        objData.ConnectionString = Application("ConnString")

        If Not objData.GetRset("GetItemList 'Education'") Then
            'MessageBox.Show(objData.ErrMsg)
        Else
            dsData = objData.RecSet
        End If

        Application("Education") = dsData

        objData = Nothing
        dsData = Nothing

        'Recruiter list
        objData = New clsData
        objData.ConnectionString = Application("ConnString")

        If Not objData.GetRset("GetItemList 'Recruiter'") Then
            'MessageBox.Show(objData.ErrMsg)
        Else
            dsData = objData.RecSet
        End If

        Application("Recruiter") = dsData

        objData = Nothing
        dsData = Nothing


        ''Seperation Reason's sub categories
        'objData = New clsData
        'objData.ConnectionString = Application("ConnString")

        'If Not objData.GetRset("GetItemSubCatList") Then
        '    'MessageBox.Show(objData.ErrMsg)
        'Else
        '    dsData = objData.RecSet
        'End If

        'Application("SepSubCatList") = dsData

        'dsData = Nothing
        'objData = Nothing
    End Sub

    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires when the session is started
        Session("ClockId") = ""
        Session("SecCode") = ""
        Session("Unit") = ""
    End Sub

    Sub Application_BeginRequest(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires at the beginning of each request
    End Sub

    Sub Application_AuthenticateRequest(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires upon attempting to authenticate the use
    End Sub

    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires when an error occurs
    End Sub

    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires when the application ends
        'Clean up application level variables

        Application("ChangeReason") = Nothing
        Application("JobCode") = Nothing
        Application("Company") = Nothing
        Application("Store") = Nothing
        Application("State") = Nothing
        Application("I9Status") = Nothing
        Application("MaritalStatus") = Nothing
        Application("A4Ded") = Nothing
        Application("JobTitle") = Nothing
        Application("Ethnicity") = Nothing
        Application("EmpReferral") = Nothing
        Application("EmpSeperation") = Nothing
        Application("SepCatList") = Nothing
        Application("SepSubCatList") = Nothing

        Application("ConnString") = ""
    End Sub
End Class
