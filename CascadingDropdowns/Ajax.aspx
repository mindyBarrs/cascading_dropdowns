<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Ajax.aspx.cs" Inherits="BasicCascadingDropdowns.Ajax" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cascadingDropdown" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <h1>Ajax Cascading Dropdown Lists</h1>
        
        <p class="lead">
            This is another way to create Cascading Dropdowns, by using an Ajax Control Toolkit and 
            a web service to handle the ajax calls.
        </p>
    </div>

    <div class="">
         <div class="col-md-12 alert alert-info">
            <p>The dropdowns below were created in the most basic way, and the data that fills 
            the dropdowns are from sql datasources which is on of the ways the get information 
            into a dropdown. The downside of doing it that way is that you have to create a 
            sql datasoure for each dropdown. </p>
            <br />
            <br />
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
            <%--
                There only needs to be one Toolkit Script Manager on the page, if you have
                a site master you can add it there and you wont need it to add it to everypage 
                you want to use it on.

                <cascadingDropdown:ToolkitScriptManager ID="tsManager" runat="server">
                </cascadingDropdown:ToolkitScriptManager>
            --%>

            <div class="col-md-4">
                <asp:Label runat="server" CssClass="control-label">Select a country:</asp:Label>

                <asp:DropDownList ID="ddlCountry" CssClass="form-control" runat="server" placeholder="please select a country...">
                </asp:DropDownList>
                <cascadingDropdown:CascadingDropDown ID="ddlCountries" TargetControlID="ddlCountry" PromptText="please select a country..."
                     runat="server" ServicePath="CascadingService.asmx" ServiceMethod="GetCountries" Category="CountryRegionCode">
                </cascadingDropdown:CascadingDropDown>
                
                <%--
                    *   TargetControlID is the name of the dropdown control that you have added to the page
                    *   ServicePath is the name of the web service you have created and will be using
                    *   ServiceMethod is the class in the web service that will add the info to the dropdownlist control
                    *   Category is what the value will be for each item in the dropdownlist
                --%>
            </div>

            <div class="col-md-4">
                <asp:Label runat="server" CssClass="control-label">Select a state/province:</asp:Label>

                <asp:DropDownList ID="ddlState" CssClass="form-control" runat="server" placeholder="please select a state/province...">
                </asp:DropDownList>
                <cascadingDropdown:CascadingDropDown ID="ddlStates" TargetControlID="ddlState" PromptText="please select a state/province..."
                     runat="server" ParentControlID="ddlCountry" ServicePath="CascadingService.asmx" ServiceMethod="GetStates" Category="StateProvinceID">
                </cascadingDropdown:CascadingDropDown>
                <%-- ParentControlID is the id of the dropdown that be used to help get the info --%>
            </div>

            <div class="col-md-4">
                <asp:Label runat="server" CssClass="control-label">Select a city:</asp:Label>

                <asp:DropDownList ID="ddlCity" CssClass="form-control" runat="server"  placeholder="please select a city...">
                </asp:DropDownList>
                <cascadingDropdown:CascadingDropDown ID="ddlCities" TargetControlID="ddlCity" PromptText="please select a country..."
                     runat="server" ServicePath="CascadingService.asmx" ParentControlID="ddlState" ServiceMethod="GetCities" Category="City">
                </cascadingDropdown:CascadingDropDown>
            </div>
        </div>
    </div>
</asp:Content>