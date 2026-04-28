<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

<script type="text/javascript">
$(document).ready(function () {
    if(($('#lbldetailname').text()=='Accounts Statement AP')){
        $('#txtatype').val('AP');$('#txtcontactno').attr('readonly', false );
    }else if(($('#lbldetailname').text()=='Accounts Statement AR')){
        $('#txtatype').val('AR');$('#txtcontactno').attr('readonly', false );
    }else if(($('#lbldetailname').text()=='Accounts Statement GL')){
        $('#txtatype').val('GL');$('#txtcontactno').attr('readonly', true );
    }else if(($('#lbldetailname').text()=='Accounts Statement HR')){
        $('#txtatype').val('HR');$('#txtcontactno').attr('readonly', true );
    }
}); 

function loadSearch() {
    var partyname = document.getElementById("txtpartyname").value || "";
    var accNo = document.getElementById("txtaccountno").value || "";
    var contactNo = document.getElementById("txtcontactno").value || "";
    var atype = document.getElementById("txtatype").value || "";
    var chk = 1;
    
    getdata(atype, partyname, accNo, contactNo, chk);
}

function getdata(atype, partyname, accNo, contactNo, chk){
    /* Safely encode URI components instead of basic string replace */
    $("#refreshdiv").load('accountsDetailsGrid.jsp?atype=' + encodeURIComponent(atype) + 
                                          '&partyname=' + encodeURIComponent(partyname) + 
                                          '&accNo=' + encodeURIComponent(accNo) + 
                                          '&contactNo=' + encodeURIComponent(contactNo) + 
                                          '&chk=' + chk);
}
</script>

<style type="text/css">
/* =========================================================
   SCOPED UI: Cash Receipts Style (Bulletproofed with Borders)
========================================================= */
body {
    margin: 0;
    background-color: #f4f7f9; /* Matched master layout background */
}

/* UI WRAPPER: Bulletproofed with ID to block legacy CSS leaks */
#search.modern-ui {
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    font-size: 12px !important;
    color: #333;
    padding: 10px;
    background-color: #f4f7f9;
}

/* THE BORDERS: White Panel for Search Inputs */
#search.modern-ui .search-panel {
    background: #fff;
    border: 1px solid #e3e8ee; /* Matched .filter-card border */
    border-radius: 8px;
    padding: 15px 10px;
    margin-bottom: 12px;
}

/* THE BORDERS: White Panel for Results */
#search.modern-ui .grid-container {
    background: #fff;
    border: 1px solid #e3e8ee;
    border-radius: 8px;
    padding: 5px;
    min-height: 50px;
}

/* Table rules locked to exact spacing and font sizes */
#search.modern-ui table {
    border-collapse: separate;
    border-spacing: 0 10px; /* Matched .filter-table spacing */
    width: 100%;
}

#search.modern-ui td {
    font-size: 12px !important;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    vertical-align: middle;
}

/* KILLS ANY EXTERNAL COLORS AND MATCHES .label-cell */
#search.modern-ui td[align="right"] {
    color: #4e5e71 !important; 
    font-weight: 600 !important;
    background-color: transparent !important; 
    background: none !important;
    padding-right: 12px;
    white-space: nowrap;
    cursor: default;
}

/* Master Input Heights - Forced to 24px and standard font */
#search.modern-ui input[type="text"] {
    height: 24px !important;
    font-size: 12px !important;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    font-weight: normal !important;
    border: 1px solid #ccd6e0; /* Matched standard input border */
    border-radius: 4px;        /* Matched standard input radius */
    padding: 2px 8px;
    box-sizing: border-box;
    transition: border-color 0.2s;
    background-color: #ffffff !important;
    max-width: 100%;
}

#search.modern-ui input[type="text"]:focus {
    border-color: #2563eb;
    outline: none;
}

/* Master Button Appearance - Matched to .btn-submit */
#search.modern-ui .myButton {
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    font-weight: 600 !important;
    font-size: 13px !important;
    height: 30px !important; 
    line-height: 30px !important;
    padding: 0 20px;
    background-color: #2563eb !important;
    color: #ffffff !important;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    text-align: center;
    white-space: nowrap;
}

#search.modern-ui .myButton:hover {
    background-color: #1d4ed8 !important;
}

#refreshdiv {
    margin-top: 5px;
}
</style>
</head>

<body bgcolor="#f4f7f9">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%">
          <tr>
            <td align="right" width="10%">Name</td>
            <td colspan="2">
                <input type="text" name="txtpartyname" id="txtpartyname" style="width:100%;" value='<s:property value="txtpartyname"/>'>
            </td>
            <td width="20%" align="center" style="padding-left: 10px;">
                <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch();">
            </td>
          </tr>
          <tr>
            <td align="right">Account</td>
            <td width="30%">
                <input type="text" name="txtaccountno" id="txtaccountno" style="width:100%;" value='<s:property value="txtaccountno"/>'>
            </td>
            <td width="15%" align="right">Contact No.</td>
            <td width="45%" colspan="2">
                <input type="text" name="txtcontactno" id="txtcontactno" style="width:100%;" value='<s:property value="txtcontactno"/>'>
                <input type="hidden" name="txtatype" id="txtatype" value='<s:property value="txtatype"/>'>
            </td>   
          </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="refreshdiv">
            <jsp:include page="accountsDetailsGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>