using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;

using OfficeAppTaskPaneWeb.Utilities;

namespace OfficeAppTaskPaneWeb.Pages
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                AADAuthHelper.CurrentHostType = HttpContext.Current.Request.QueryString["_host_Info"];
                AADAuthHelper.StoreAuthorizationCodeFromRequest(this.Request);
            }
        }

        [WebMethod]
        public static string GetHostType()
        {
            return Utilities.AADAuthHelper.CurrentHostType;
        }

        [WebMethod]
        public static string GetAuthorizeUrl()
        {
            if (!AADAuthHelper.IsAuthorized)
            {
                return AADAuthHelper.AuthorizeUrl;
            }

            return string.Empty;
        }

        [WebMethod]
        public static string[][] GetData()
        {
            var accessToken = AADAuthHelper.EnsureValidAccessToken(HttpContext.Current);
            // Replace the value with your SAP OData endpoint stem and OData query parameters.
            return DataGetter.GetDataMatrix("https://stem_of_SAP_OData_endpoint/some_data_collection?$top=5&$skip=1", accessToken);
        }
    }
}