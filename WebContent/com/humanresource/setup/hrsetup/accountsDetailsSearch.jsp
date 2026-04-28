<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

<style>
/* =========================================================
   SCOPED UI: Strict Pixel Grid Alignment & Modern Inputs
========================================================= */
body {
    margin: 0;
    background-color: #fff;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif; 
}

.modern-ui {
    font-size: 12px;
    color: #333;
    padding: 10px;
    box-sizing: border-box;
    width: 100%;
}

/* Master Input Styles */
.modern-ui input[type="text"],
.modern-ui select {
    height: 24px !important;
    border: 1px solid #BDBDBD;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 12px; 
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    box-sizing: border-box;
    background-color: #fff;
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus {
    border-color: #007bff;
    outline: none;
}

/* Panel Styling */
.modern-ui .search-panel {
    background-color: #fff !important; 
    border: 1px solid #BDBDBD;
    border-radius: 4px;
    padding: 12px 10px;
    margin-bottom: 10px;
    width: 100%;
    box-sizing: border-box;
}

/* Table Alignment - STRICT PERCENTAGE GRID */
.modern-ui table {
    border-collapse: separate;
    border-spacing: 5px 8px; 
    width: 100%;
    table-layout: fixed; /* Locks columns from squishing */
}

.modern-ui td {
    vertical-align: middle;
    padding: 0;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #222;
    font-size: 12px; 
    font-weight: 600;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Search Button - Standard Blue */
.modern-ui .myButton {
    height: 26px;
    padding: 0 20px;
    background-color: #0056b3;
    color: #ffffff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 12px;
    font-weight: bold;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    transition: all 0.2s;
}

.modern-ui .myButton:hover {
    background-color: #004494;
}

/* Grid Container */
.modern-ui .grid-container {
    border: 1px solid #BDBDBD;
    background: #fff;
    overflow: hidden;
    width: 100%;
}
</style>

<script type="text/javascript">
    $(document).ready(function () {}); 
    
    function loadAccountSearch() {
        var accountsno = document.getElementById("txtaccountsno").value || "";
        var accountsname = document.getElementById("txtaccountsname").value || "";
        
        /* Safety check for formdetailcode (usually inherited from parent) */
        var formcode = "";
        if(document.getElementById("formdetailcode")) {
            formcode = document.getElementById("formdetailcode").value;
        }
        var check = 1;

        getAccountDetails(accountsno, accountsname, check, formcode);
    }
        
    function getAccountDetails(accountsno, accountsname, check, formcode){
         /* Safely encoding URI components */
         $("#refreshAccountDetailsDiv").load(
             "accountsDetailsFromGrid.jsp?accountno=" + encodeURIComponent(accountsno) + 
             '&accountname=' + encodeURIComponent(accountsname) + 
             '&check=' + check + 
             '&formcode=' + encodeURIComponent(formcode)
         );
    }
</script>
</head>

<body style="background-color: #fff; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <colgroup>
                <col width="12%" /> <col width="23%" /> <col width="12%" /> <col width="33%" /> <col width="20%" /> </colgroup>
            
            <tr>
                <td class="lbl-right">Account No</td>
                <td>
                    <input type="text" name="txtaccountsno" id="txtaccountsno" autocomplete="off" value='<s:property value="txtaccountsno"/>'>
                </td>
                
                <td class="lbl-right">Account Name</td>
                <td>
                    <input type="text" name="txtaccountsname" id="txtaccountsname" autocomplete="off" value='<s:property value="txtaccountsname"/>'>
                </td>
                
                <td align="center" valign="middle">
                    <input type="button" name="btnAccountSearch" id="btnAccountSearch" class="myButton" value="Search" onclick="loadAccountSearch();">
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="refreshAccountDetailsDiv">
            <jsp:include page="accountsDetailsFromGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>