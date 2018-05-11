using AjaxControlToolkit;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace BasicCascadingDropdowns
{
    /// <summary>
    /// Summary description for CascadingService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class CascadingService : System.Web.Services.WebService
    {
        private List<CascadingDropDownNameValue> GetData(string query)
        {
            List<CascadingDropDownNameValue> values = new List<CascadingDropDownNameValue>();

            //Step 1: Get the connection string and open a connection to the database
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ToString());
            conn.Open();

            //Step 2: Always check that it opened, if it didn't provide 
            // a user friendly error message.
            if (conn != null)
            {
                //Step 3: Create the Sql Command, it's like creating a 
                // a MsSql select command.
                SqlCommand comm = new SqlCommand();

                //CommandType can be either a select or a stored procedure
                // if you choose text, you have to type out the select.
                // if you choose stored procedure all you have to do is 
                // type in the name of the stored procedure.
                comm.CommandType = CommandType.Text;
                comm.CommandText = query;
                comm.Connection = conn;
                comm.ExecuteNonQuery();

                //Step 4: Create a sql reader, that gathers the information from 
                // the database so you can add it to the Cascading Dropdown list
                using (SqlDataReader reader = comm.ExecuteReader())
                {
                    //Step 5: loop through the reader and add the values to the CascadingDropDownNameValue list
                    while (reader.Read())
                    {
                        values.Add(new CascadingDropDownNameValue {
                            name = reader[0].ToString(),
                            value = reader[1].ToString()
                        });
                    }

                    //Step 6: Close All Connections down.
                    reader.Close();
                    conn.Close();

                    return values;
                }
            }
            else
            {
                return null;
            }
        }

        [WebMethod]
        public CascadingDropDownNameValue[] GetCountries(string knownCategoryValues)
        {
            //This will very from person to person depending on the database
            // or if there is a stored procedure that will be getting the information
            string query = "SELECT * FROM Person.CountryRegion";

            List<CascadingDropDownNameValue> countries = GetData(query);

            return countries.ToArray();
        }

        [WebMethod]
        public CascadingDropDownNameValue[] GetStates(string knownCategoryValues)
        {
            // The knownCategoryValues is the countyID or CountryRegionCode 
            // that is being passed from the ddlCountry dropdown
            string country = Convert.ToString(CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues));

            //This will very from person to person depending on the database
            // or if there is a stored procedure that will be getting the information
            string query = "SELECT * FROM Person.CountryRegion";

            List<CascadingDropDownNameValue> states = GetData(query);

            return states.ToArray();
        }

        [WebMethod]
        public CascadingDropDownNameValue[] GetCities(string knownCategoryValues)
        {
            // The knownCategoryValues is the stateID or StateProvinceID 
            // that is being passed from the ddlCountry dropdown
            string state = Convert.ToString(CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues));

            //This will very from person to person depending on the database
            // or if there is a stored procedure that will be getting the information
            string query = "SELECT * FROM Person.CountryRegion";

            List<CascadingDropDownNameValue> cities = GetData(query);

            return cities.ToArray();
        }
    }
}
