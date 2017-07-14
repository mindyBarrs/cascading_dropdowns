using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BasicCascadingDropdowns
{
    public partial class Ajax : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
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
                    comm.CommandText = "SELECT * FROM Person.CountryRegion";
                    comm.Connection = conn;
                    comm.ExecuteNonQuery();

                    //Step 4: Create a sql adapter, that gathers the information from 
                    // the database so you can add it to a Data Set
                    SqlDataAdapter da = new SqlDataAdapter(comm);
                    DataSet ds = new DataSet();
                    da.Fill(ds);

                    //Step 5: Close the connection to the database
                    conn.Close();

                    //Step 6: Create a List or a dictionay and add the dataset to it.
                    Dictionary<string, string> cdblist = new Dictionary<string, string>();

                    foreach (DataRow dtRow in ds.Tables[0].Rows)
                    {
                        cdblist.Add(dtRow["Name"].ToString(), dtRow["CountryRegionCode"].ToString());
                    }

                    //Step 7: Bind the List or dictionary to the dropdownlist
                    ddlCountry.DataSource = cdblist;
                    ddlCountry.DataTextField = "Key";
                    ddlCountry.DataValueField = "Value";
                    ddlCountry.DataBind();
                }
                else
                {

                }
            }
        }

        protected void ddlCountry_SelectedIndexChanged(object sender, EventArgs e)
        {
            //This is the parameter being passed from the first dropdown
            string countryID = ddlCountry.SelectedValue;

            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ToString());
            conn.Open();

            if (countryID != null && conn != null)
            {
                SqlCommand comm = new SqlCommand("SELECT * FROM Person.StateProvince WHERE CountryRegionCode = @CountryRegionCode", conn);
                comm.CommandType = CommandType.Text;
                comm.Parameters.AddWithValue("@CountryRegionCode", countryID);
                comm.ExecuteNonQuery();

                SqlDataAdapter da = new SqlDataAdapter(comm);
                DataSet ds = new DataSet();
                da.Fill(ds);
                conn.Close();

                Dictionary<string, int> provinces = new Dictionary<string, int>();

                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    provinces.Add(Convert.ToString(dr["Name"]), Convert.ToInt32(dr["StateProvinceID"]));
                }

                ddlStates.DataSource = provinces;
                ddlStates.DataTextField = "Key";
                ddlStates.DataValueField = "Value";
                ddlStates.DataBind();
            }
        }

        protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
        {
            int provID = Convert.ToInt32(ddlStates.SelectedValue);

            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ToString());
            conn.Open();

            if (provID > 0 && conn != null)
            {
                SqlCommand comm = new SqlCommand();
                comm.CommandType = CommandType.Text;
                comm.CommandText = "SELECT DISTINCT City, StateProvinceID, PostalCode FROM Person.Address WHERE StateProvinceID = @StateProvinceID";
                comm.Connection = conn;
                comm.Parameters.AddWithValue("@StateProvinceID", provID);
                comm.ExecuteNonQuery();

                SqlDataAdapter da = new SqlDataAdapter(comm);
                DataSet ds = new DataSet();
                da.Fill(ds);
                conn.Close();

                Dictionary<string, string> cities = new Dictionary<string, string>();

                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    cities.Add(dr["City"].ToString(), dr["City"].ToString());
                }

                ddlCity.DataSource = cities;
                ddlCity.DataTextField = "Key";
                ddlCity.DataValueField = "Value";
                ddlCity.DataBind();
            }
        }
    }
}