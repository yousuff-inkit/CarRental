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

<script type="text/javascript">
	$(document).ready(function () {}); 
	
	function loadAccountSearch() {
        var accountsno = document.getElementById("txtaccountsno").value || "";
        var accountsname = document.getElementById("txtaccountsname").value || "";
        var dates = $('#todate').val() || "";
        var check = 1;

        getAccountDetails(accountsno, accountsname, dates, check);
	}
		
	function getAccountDetails(accountsno, accountsname, dates, check){
        /* Safely encode URI components instead of basic string replace */
        $("#refreshAccountDetailsDiv").load("accountDetailsSearchGrid.jsp?accountno=" + encodeURIComponent(accountsno) + 
                                            '&accountname=' + encodeURIComponent(accountsname) + 
                                            '&dates=' + encodeURIComponent(dates) + 
                                            '&check=' + chk);
	}
</script>

<style type="text/css">
/* =========================================================
   SCOPED UI: Cash Receipts Style (Bulletproofed with Borders)
========================================================= */
body {
    margin: 0;
    background-color: #f5f7fa; /* Soft background so the white panels pop */
}

/* UI WRAPPER: Bulletproofed with ID to block legacy CSS leaks */
#search.modern-ui {
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    font-size: 12px !important;
    color: #333;
    padding: 10px;
    background-color: #f5f7fa;
}

/* THE BORDERS: White Panel for Search Inputs */
#search.modern-ui .search-panel {
    background: #fff;
    border: 1px solid #c5d3e0;
    border-radius: 8px;
    padding: 15px 10px;
    margin-bottom: 12px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.04);
}

/* THE BORDERS: White Panel for Results */
#search.modern-ui .grid-container {
    background: #fff;
    border: 1px solid #c5d3e0;
    border-radius: 8px;
    padding: 5px;
    min-height: 50px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.04);
}

/* Table rules locked to exact spacing and font sizes */
#search.modern-ui table {
    border-collapse: separate;
    border-spacing: 4px 10px; /* Modern compact spacing */
    width: 100%;
}

#search.modern-ui td {
    font-size: 12px !important;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    vertical-align: middle;
}

/* KILLS ANY EXTERNAL COLORS FROM BODY.CSS & ENSURES NORMAL WEIGHT */
#search.modern-ui td[align="right"] {
    color: #000000 !important; 
    font-weight: normal !important;
    background-color: transparent !important; 
    background: none !important;
    padding-right: 5px;
    white-space: nowrap;
    cursor: default;
}

/* Master Input Heights - Forced to 24px and standard font */
#search.modern-ui input[type="text"] {
    height: 24px !important;
    font-size: 12px !important;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    font-weight: normal !important;
    border: 1px solid #b8c6d8;
    border-radius: 3px;
    padding: 2px 6px;
    box-sizing: border-box;
    transition: border-color 0.2s;
    background-color: #ffffff !important;
    max-width: 100%;
}

#search.modern-ui input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
    box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.1);
}

/* Master Button Appearance - MADE SMALL AND COMPACT */
#search.modern-ui .myButton {
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    font-weight: 700 !important;
    font-size: 11px !important; /* Slightly smaller text for compact button */
    height: 24px !important; /* Matched exactly to input height */
    line-height: 22px !important;
    padding: 0 15px !important;
    width: 80px !important; /* Locked small width */
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%) !important;
    color: #ffffff !important;
    border: 1px solid #083a8a !important;
    border-radius: 3px;
    cursor: pointer;
    box-shadow: 0 1px 2px rgba(59, 130, 246, 0.3);
    text-align: center;
    text-transform: uppercase;
}

#search.modern-ui .myButton:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%) !important;
    transform: translateY(-1px);
}

#refreshAccountDetailsDiv {
    margin-top: 5px;
}
</style>
</head>

<body bgcolor="#f5f7fa">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%">
          <tr>
            <td width="10%" align="right">Account No</td>
            <td width="51%">
                <input type="text" name="txtaccountsno" id="txtaccountsno" style="width:70%;" value='<s:property value="txtaccountsno"/>'>
            </td>
            <td width="39%" align="left" style="padding-left: 8px;">
                <input type="button" name="btnAccountSearch" id="btnAccountSearch" class="myButton" value="Search" onclick="loadAccountSearch();">
            </td>
          </tr>
          <tr>
            <td align="right">Account Name</td>
            <td colspan="2">
                <input type="text" name="txtaccountsname" id="txtaccountsname" style="width:70%;" value='<s:property value="txtaccountsname"/>'>
            </td>
          </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="refreshAccountDetailsDiv">
            <jsp:include page="accountDetailsSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>