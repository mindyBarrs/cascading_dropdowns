<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Ajax.aspx.cs" Inherits="BasicCascadingDropdowns.Ajax" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <h1>Ajax Cascading Dropdown Lists</h1>

        <p class="lead">
            This is another way to create cascading dropdownlists, but this way doesn't make the page re-load
            everytime a selection is made. The way this is accomplished is by using the update panel that is 
            lacted in the toolbox under Ajax extenctions. 
        </p>
    </div>

    <div class="">
        <div class="row">
            <%--This script manger always need to be on a the page that is using the update panel or 
            on the Master page
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>--%>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" ViewStateMode="Enabled">
                <ContentTemplate>
                    <div class="col-md-4">
                        <asp:Label runat="server" CssClass="control-label">Select a country:</asp:Label>

                        <asp:DropDownList ID="ddlCountry" CssClass="form-control" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCountry_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>

                    <div class="col-md-4">
                        <asp:Label runat="server" CssClass="control-label">Select a state/province:</asp:Label>

                        <asp:DropDownList ID="ddlStates" CssClass="form-control" runat="server" AutoPostBack="true" 
                            placeholder="please select a state/province..." OnSelectedIndexChanged="ddlState_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>

                    <div class="col-md-4">
                        <asp:Label runat="server" CssClass="control-label">Select a city:</asp:Label>

                        <asp:DropDownList ID="ddlCity" CssClass="form-control" runat="server">
                        </asp:DropDownList>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
