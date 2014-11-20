<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="OfficeAppTaskPaneWeb.Pages.Default" Async="true"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=Edge" />
    <script src="https://appsforoffice.microsoft.com/lib/1.1/hosted/office.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-1.9.1.js" type="text/javascript"></script>
    <link href="../App/App.css" rel="stylesheet" type="text/css" />
    <script src="../App/App.js" type="text/javascript"></script>

    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptMgr" runat="server" EnablePageMethods="true"></asp:ScriptManager>
    </form>
    <div>
        <button id="set-data-to-selection">Get data from SAP</button>
    </div>

    <script type="text/javascript">
        $(document).ready(function () {
            app.initialize();
            $('#set-data-to-selection').click(setDataToSelection);

            Office.initialize = function (reason) {
                PageMethods.GetHostType(redirectToAuthenticate);
            };
        });

        function redirectToAuthenticate(hostType)
        {
            PageMethods.GetAuthorizeUrl(function (value) {
                if (value) {
                    if (hostType === "client")
                        window.open(value);
                    else
                        window.location = value;
                }
            });
        }

        function setDataToSelection() {
            PageMethods.GetData(function (value) {
                if (value) {
                    Office.context.document.setSelectedDataAsync(value, { coercionType: "matrix" }, function (asyncResult) {
                        var error = asyncResult.error;
                        if (asyncResult.status === "failed") {
                            app.showNotification("Error", error.name + ": " + error.message);
                        }
                    });
                }
            });
        }
    </script>
</body>
</html>
