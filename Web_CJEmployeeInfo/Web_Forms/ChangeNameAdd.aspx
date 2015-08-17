<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ChangeNameAdd.aspx.vb" Inherits="Web_CJEmployeeInfo.ChangeNameAdd" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../assets/plugins/boostrapv3/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../pages/css/pages.css" rel="stylesheet" />
    <title>Change Name / Address</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <style>
        .mask
        {
            BEHAVIOR: url("mask_vbs.htc");
        }
    </style>
    <script language="javascript">

        function ValidateData() {
            var txtLName;
            var txtFName;
            var txtMName;
            var txtAdd1;
            var txtAdd2;
            var txtCity;
            var txtZip;
            var cmbState;
            var txtHomePh;
            var txtEffDate;
            var txtChangeReason;

            var txtOldLName;
            var txtOldFName;
            var txtOldMName;
            var txtOldAdd1;
            var txtOldAdd2;
            var txtOldCity;
            var txtOldZip;
            var txtOldState;
            var txtOldHomePh;


            txtLName = document.getElementById("txtLName");
            txtFName = document.getElementById("txtFName");
            txtMName = document.getElementById("txtMName");
            txtAdd1 = document.getElementById("txtAdd1");
            txtAdd2 = document.getElementById("txtAdd2");
            txtCity = document.getElementById("txtCity");
            txtZip = document.getElementById("txtZip");
            cmbState = document.getElementById("cmbState");
            txtHomePh = document.getElementById("txtHomePh");

            txtOldLName = document.getElementById("txtOldLName");
            txtOldFName = document.getElementById("txtOldFName");
            txtOldMName = document.getElementById("txtOldMName");
            txtOldAdd1 = document.getElementById("txtOldAdd1");
            txtOldAdd2 = document.getElementById("txtOldAdd2");
            txtOldCity = document.getElementById("txtOldCity");
            txtOldZip = document.getElementById("txtOldZip");
            txtOldState = document.getElementById("txtOldState");
            txtOldHomePh = document.getElementById("txtOldHomePh");

            txtEffDate = document.getElementById("txtEffDate");
            txtChangeReason = document.getElementById("txtChangeReason");

            if (TrimString(txtFName.value) == txtOldFName.value &&
                TrimString(txtMName.value) == txtOldMName.value &&
                TrimString(txtLName.value) == txtOldLName.value &&
                TrimString(txtAdd1.value) == txtOldAdd1.value &&
                TrimString(txtAdd2.value) == txtOldAdd2.value &&
                TrimString(txtCity.value) == txtOldCity.value &&
                cmbState.options(cmbState.selectedIndex).text == txtOldState.value &&
                TrimString(txtZip.value) == txtOldZip.value &&
                TrimString(txtHomePh.value) == txtOldHomePh.value) {
                alert('Atleast one field must be changed .. Please check it out')
                return false;
            }

            if (isBlank(txtLName.value) || isBlank(txtFName.value) ||
                isBlank(txtAdd1.value) ||
                isBlank(txtCity.value) ||
                isBlank(txtZip.value) ||
                isBlank(cmbState.options(cmbState.selectedIndex).text) ||
                isBlank(txtEffDate.value) || isBlank(txtChangeReason.value)) {
                alert('Following fields are required .. Please check it out' +
                    '\n' + '\n' + 'First Name' + '\n' +
                    'Last Name' + '\n' + 'Address 1' + '\n' +
                    'City' + '\n' + 'State' + '\n' + 'Zip' + '\n' +
                    'Effective Date' + '\n' + 'Reason For Change');

                return false;
            }

            if (!CheckDateEff(txtEffDate.value)) {
                alert('Invalid Date Effective .. Please check it out');
                return false;
            }

            return true;
        }

        function CheckDateEff(dd) {
            var d1;
            //var d2;
            var DateEff;

            DateEff = new Date(dd);
            d1 = new Date();
            //d2 = new Date();

            d1.setMonth(d1.getMonth() + 2);
            //d2.setMonth(d2.getMonth() - 2);

            if (DateEff > d1)	// || DateEff < d2)
                return false;
            else
                return true;
        }

        function isBlank(s) {
            if ((s == null) || (s.length == 0) || s == "")
                return true;

            for (var i = 0; i < s.length; i++) {
                var c = s.charAt(i);
                if ((c != ' ') && (c != '\n') && (c != '\t')) return false;
            }
            return true;
        }

        function TrimString(sInString) {
            sInString = sInString.replace(/^\s+/g, "");// strip leading
            return sInString.replace(/\s+$/g, "");// strip trailing
        }

        function ValidateSubmit() {
            if (ValidateData())
                if (confirm('Submit Request ?' + '\n' + '\n' + 'Date Effective : ' + document.getElementById("txtEffDate").value))
                    return true;
                else
                    return false;

            return false;
        }

        function ValidatePost() {
            if (ValidateData())
                if (confirm('Post Request ?'))
                    return true;
                else
                    return false;

            return false;
        }

        function ValidateDelete() {
            if (confirm('Delete Request ?'))
                return true;
            else
                return false;
        }

        function ValidateEmailReq() {
            var txtUndoNotes;

            txtUndoNotes = document.getElementById("txtUndoNotes");

            if (isBlank(txtUndoNotes.value)) {
                alert('Please write something in Email Notes');
                return false;
            }
            else {
                if (confirm('Send Email to Requester ?'))
                    return true;
                else
                    return false;
            }
        }

    </script>
</head>
<body bgcolor="#FFF">
    <form id="form1" method="post" runat="server">

        <!-- START CONTAINER FLUID -->
        <div class="container-fluid container-fixed-lg">
            <!-- START PANEL -->
            <div class="panel panel-transparent">

                <div class="row" style="text-align: center; color: #069; font-family: 'Monotype Corsiva'; font-weight: bold; font-size: 25px; margin-top: 4px;">
                    Change Name / Address
                </div>

                <div class="blue_line"></div>

                <div class="row">
                    <div class="col-sm-12" style="text-align: center;">
                        <asp:Label ID="lblEmp" runat="server" Width="605px" Font-Names="Microsoft Sans Serif" Font-Size="Small"
                            Font-Bold="True"></asp:Label>
                    </div>
                    <div class="blue_line"></div>

                    <div class="row1">
                        <div class="col-sm-12" style="color: #069; font-weight: bold; font-size: 13px; margin-top: -6px; margin-bottom: 6px;">
                            Employee's Existing Information :
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-1">
                                    <div class="panel-title"><strong>First :</strong></div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <asp:TextBox ID="txtOldFName" runat="server" Width="160px" ForeColor="Black" Enabled="false" CssClass="form-control"></asp:TextBox>
                                        <%--BackColor="#E7E6E6"--%>
                                    </div>
                                </div>

                                <div class="col-sm-1" style="margin-left: 7px;">
                                    <strong>Middle : </strong>
                                </div>
                                <div class="col-sm-2">
                                    <div class="form-group">
                                        <asp:TextBox ID="txtOldMName" runat="server" Width="100px" ForeColor="Black" CssClass="form-control" Enabled="False"></asp:TextBox>
                                        <%--BackColor="#E7E6E6"--%>
                                    </div>
                                </div>
                                <div class="col-sm-11">
                                    <strong>Last :</strong>
                                </div>
                                <div class="col-sm-2">

                                    <div class="form-group">
                                        <asp:TextBox ID="txtOldLName" runat="server" Width="120px" ForeColor="Black" Enabled="False" CssClass="form-control"></asp:TextBox>
                                        <%-- BackColor="#E7E6E6"--%>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-1">
                                    <div class="panel-title"><strong>Add 1 : </strong></div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <asp:TextBox ID="txtOldAdd1" runat="server" Width="160px" ForeColor="Black" CssClass="form-control" Enabled="False"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="col-sm-1" style="margin-left: 7px;">
                                    <strong>Apt # :</strong>
                                </div>
                                <div class="col-sm-2">
                                    <div class="form-group">
                                        <asp:TextBox ID="txtOldAdd2" runat="server" Width="100px" ForeColor="Black" CssClass="form-control" Enabled="False"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-sm-11">
                                    <strong>City :</strong>
                                </div>
                                <div class="col-sm-2">
                                    <div class="form-group">
                                        <asp:TextBox ID="txtOldCity" runat="server" Width="120px" ForeColor="Black" CssClass="form-control" Enabled="False"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-1">
                                    <div class="panel-title"><strong>State : </strong></div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <asp:TextBox ID="txtOldState" runat="server" Width="120px" ForeColor="Black" CssClass="form-control" Enabled="False"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="col-sm-1" style="margin-left: 7px;">
                                    <strong>Zip : </strong>
                                </div>
                                <div class="col-sm-2">
                                    <div class="form-group">
                                        <asp:TextBox ID="txtOldZip" runat="server" Width="100px" ForeColor="Black" CssClass="form-control" Enabled="False"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-sm-11">
                                    <strong>Home Ph : </strong>
                                </div>
                                <div class="col-sm-2">
                                    <div class="form-group">
                                        <asp:TextBox ID="txtOldHomePh" runat="server" Width="120px" ForeColor="Black" CssClass="form-control" Enabled="False"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

                <div class="blue_line"></div>
                <div class="row">
                    <div class="col-sm-12" style="color: #069; font-weight: bold; font-size: 13px; margin-top: -6px; margin-bottom: 6px;">
                        Employee's New Information :
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-12">
                        <div class="row">
                            <div class="col-sm-1">
                                <div class="panel-title"><strong>First : </strong></div>
                            </div>
                            <div class="col-sm-3">
                                <div class="form-group">
                                    <asp:TextBox ID="txtFName" runat="server" Width="160px" BackColor="#E7E6E6" CssClass="form-control"></asp:TextBox>
                                    <%--BackColor="#E7E6E6"--%>
                                </div>
                            </div>

                            <div class="col-sm-1" style="margin-left: 7px;">
                                <strong>Middle :</strong>
                            </div>
                            <div class="col-sm-2">
                                <div class="form-group">
                                    <asp:TextBox ID="txtMName" runat="server" Width="100px" CssClass="form-control"></asp:TextBox>
                                    <%--BackColor="#E7E6E6"--%>
                                </div>
                            </div>
                            <div class="col-sm-11">
                                <strong>Last :</strong>
                            </div>
                            <div class="col-sm-2">
                                <div class="form-group">
                                    <asp:TextBox ID="txtLName" runat="server" Width="120px" BackColor="#E7E6E6" CssClass="form-control"></asp:TextBox>
                                    <%-- BackColor="#E7E6E6"--%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-12">
                        <div class="row">
                            <div class="col-sm-1">
                                <div class="panel-title"><strong>Add 1 : </strong></div>
                            </div>
                            <div class="col-sm-3">
                                <div class="form-group">
                                    <asp:TextBox ID="txtAdd1" runat="server" Width="160px" BackColor="#E7E6E6" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>

                            <div class="col-sm-1" style="margin-left: 7px;">
                                <strong>Apt # :</strong>
                            </div>
                            <div class="col-sm-2">
                                <div class="form-group">
                                    <asp:TextBox ID="txtAdd2" runat="server" Width="100px" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-sm-11">
                                <strong>City :</strong>
                            </div>
                            <div class="col-sm-2">
                                <div class="form-group">
                                    <asp:TextBox ID="txtCity" runat="server" Width="120px" BackColor="#E7E6E6" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-12">
                        <div class="row">
                            <div class="col-sm-1">
                                <div class="panel-title"><strong>State :</strong></div>
                            </div>
                            <div class="col-sm-3">
                                <div class="form-group">
                                    <asp:DropDownList ID="cmbState" runat="server" Width="120px" BackColor="#E7E6E6" CssClass="form-control"></asp:DropDownList>
                                </div>
                            </div>

                            <div class="col-sm-1" style="margin-left: 7px;">
                                <strong>Zip :</strong>
                            </div>
                            <div class="col-sm-2">
                                <div class="form-group">
                                    <asp:TextBox ID="txtZip" runat="server" Width="100px" BackColor="#E7E6E6" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-sm-11">
                                <strong>Home Ph :</strong>
                            </div>
                            <div class="col-sm-2">
                                <div class="form-group">
                                    <asp:TextBox ID="txtHomePh" runat="server" Width="120px" CssClass="form-control" Preset="phone"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="blue_line"></div>

                <div class="row">
                    <div class="col-sm-12">
                        <div class="row">
                            <div class="col-sm-2">
                                <div class="panel-title"><strong>Effective Date :  </strong></div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group" style="padding-left: 42px;">
                                    <asp:TextBox ID="txtEffDate" BackColor="#E7E6E6" runat="server" Width="136px" CssClass="form-control" Preset="shortdate"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-12">
                        <div class="row">
                            <div class="col-sm-3">
                                <div class="panel-title"><strong>Reason For Change : </strong></div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <asp:TextBox ID="txtChangeReason" BackColor="#E7E6E6" runat="server" Width="504px" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="tblUndo" runat="server">
                    <strong>Email Notes to  Requester</strong>
                    <asp:TextBox ID="txtUndoNotes" runat="server" CssClass="form-control" Width="504px" Height="38px" TextMode="MultiLine"></asp:TextBox>
                </div>

                <div class="blue_line"></div>

                <div class="row">
                    <div class="col-sm-12">
                        <div class="">
                            <asp:Button ID="cmdEmailReq" runat="server" Width="121px" CssClass="btn-form1" Text="Email Requester"></asp:Button>
                            <asp:Button ID="cmdDelete" runat="server" Width="110px" CssClass="btn-form1" Text="Delete"></asp:Button>
                            <asp:Button ID="cmdSubmit" runat="server" Width="110px" CssClass="btn-form1" Text="Submit"></asp:Button>
                            <asp:Button ID="cmdPost" runat="server" Width="110px" CssClass="btn-form1" Text="Post"></asp:Button>
                            <asp:Button ID="cmdExit" runat="server" Width="110px" CssClass="btn-form1" Text="Exit" OnClientClick="javascript:window.close();"></asp:Button>
                            <asp:TextBox ID="txtClockId" runat="server" Width="29px" Visible="False"></asp:TextBox>
                            <asp:TextBox ID="txtId" runat="server" Width="29px" Visible="False"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <div style="text-align: center; width: 70%;">
                    <asp:TextBox ID="txtHState" runat="server" Width="32px" Height="16px" Visible="False"></asp:TextBox>
                    <asp:TextBox ID="txtManClockId" runat="server" Width="24px" Height="16px" Visible="False"></asp:TextBox>
                    <asp:Button ID="cmdReview" runat="server" Width="129px" CssClass="btn-form" Text="Send For Review" Visible="False"></asp:Button>
                </div>

            </div>
            <!-- END PANEL -->
        </div>
        <!-- END CONTAINER FLUID -->

    </form>
</body>
</html>
