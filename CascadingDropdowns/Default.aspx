<%@ Page Title="Cascading Dropdowns" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BasicCascadingDropdowns._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="sdCity" runat="server" ConnectionString='<%$ ConnectionStrings:AdventureWorks2012_DataConnectionString %>' SelectCommand="SELECT [City], [StateProvinceID], [PostalCode] FROM Person.Address WHERE ([StateProvinceID] = @StateProvinceID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlState" PropertyName="SelectedValue" Name="StateProvinceID" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsState" runat="server" ConnectionString='<%$ ConnectionStrings:AdventureWorks2012_DataConnectionString %>' SelectCommand="SELECT StateProvinceID, CountryRegionCode, Name FROM Person.StateProvince WHERE (CountryRegionCode = @CountryRegionCode)">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlCountry" PropertyName="SelectedValue" Name="CountryRegionCode" Type="String"></asp:ControlParameter>
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsCountry" runat="server" ConnectionString='<%$ ConnectionStrings:AdventureWorks2012_DataConnectionString %>' SelectCommand="SELECT * FROM Person.CountryRegion"></asp:SqlDataSource>
    
    <div class="jumbotron">
        <h1>Basic Cascading Dropdown Lists</h1>
        <p class="lead">
            This is the Basic way to create cascading dropdowns, the one main downside is 
            that the page needs to reload the page everytime the user makes a selection in 
            the dropdown.
        </p>
    </div>

    <div class="">
        <div class="col-md-12 alert alert-info">
            <p>The dropdowns below were created in the most basic way, and the data that fills 
            the dropdowns are from sql datasources which is on of the ways the get information 
            into a dropdown. The downside of doing it that way is that you have to create a 
            sql datasoure for each dropdown. </p>

            <p>
                The database that was used doesn't have states/provinces for every country and 
                it also doesn't have cites for every state/province. So I have listed a country 
                and state that will work. 
            </p>

            <div class="row">
                <div class="col-lg-5">
                    <ul class="">
                        <li>
                            Country: United States
                        </li>

                        <li>
                            State/Province: Washington
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-4">
                <asp:Label runat="server" CssClass="control-label">Select a country:</asp:Label>

                <asp:DropDownList ID="ddlCountry" CssClass="form-control" runat="server" DataSourceID="sdsCountry" 
                    DataTextField="Name" DataValueField="CountryRegionCode" 
                    AutoPostBack="True">
                </asp:DropDownList>
            </div>

            <div class="col-md-4">
                <asp:Label runat="server" CssClass="control-label">Select a state/province:</asp:Label>

                <asp:DropDownList ID="ddlState" CssClass="form-control" runat="server" DataSourceID="sdsState"
                    DataTextField="Name" DataValueField="StateProvinceID"
                    AutoPostBack="True" placeholder="please select a state/province...">
                </asp:DropDownList>
            </div>

            <div class="col-md-4">
                <asp:Label runat="server" CssClass="control-label">Select a city:</asp:Label>

                <asp:DropDownList ID="ddlCity" CssClass="form-control" runat="server" DataSourceID="sdCity"
                    DataTextField="City" DataValueField="City" AutoPostBack="True">
                </asp:DropDownList>
            </div>
        </div>
    </div>
</asp:Content>
