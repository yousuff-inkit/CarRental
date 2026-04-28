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
	function loadAccountSearch() {
		var accountsno = document.getElementById("txtaccountsno2").value || "";
		var accountsname = document.getElementById("txtaccountsname2").value || "";
		var currs = document.getElementById("txtaccountcurrency2").value || "";
		var check = "bankaac";
	
		getAccountDetails(accountsno, accountsname, currs, check);
	}
		
	function getAccountDetails(accountsno, accountsname, currs, check){
        /* Safely encode URI components instead of basic string replace */
		$("#bankdiv").load("bankaccSubgrid.jsp?accountno=" + encodeURIComponent(accountsno) + 
                                           '&accountname=' + encodeURIComponent(accountsname) + 
                                           '&currency=' + encodeURIComponent(currs) + 
                                           '&check=' + check);
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

#search.modern-ui td[align="right"] {
    color: #444 !important;
    font-weight: 600 !important;
    padding-right: 5px;
    white-space: nowrap;
}

/* Master Input Heights - Forced to 24px and standard font */
#search.modern-ui input[type="text"],
#search.modern-ui select {
    height: 24px !important;
    font-size: 12px !important;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    font-weight: normal !important;
    border: 1px solid #b8c6d8;
    border-radius: 3px;
    padding: 2px 6px;
    box-sizing: border-box;
    width: 100%;
    transition: border-color 0.2s;
    background-color: #ffffff;
    max-width: 100%;
}

#search.modern-ui input[type="text"]:focus,
#search.modern-ui select:focus {
    border-color: #007bff;
    outline: none;
    box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.1);
}

/* Master Button Appearance */
#search.modern-ui .myButton {
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    font-weight: 700 !important;
    font-size: 12px !important;
    height: 26px !important;
    line-height: 24px !important;
    padding: 0 20px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%) !important;
    color: #ffffff !important;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    transition: all 0.2s ease;
    box-shadow: 0 1px 2px rgba(59, 130, 246, 0.3);
    text-transform: uppercase;
    text-align: center;
}

#search.modern-ui .myButton:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%) !important;
    transform: translateY(-1px);
}

#bankdiv {
    margin-top: 5px;
}
</style>
</head>

<body bgcolor="#f5f7fa">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0">
          <tr>
            <td width="12%" align="right">Account No</td>
            <td width="28%">
                <input type="text" name="txtaccountsno2" id="txtaccountsno2" value='<s:property value="txtaccountsno2"/>'>
            </td>
            <td width="10%" align="right">Currency</td>
            <td width="25%">
                <input type="text" name="txtaccountcurrency2" id="txtaccountcurrency2" style="width: 60%;" value='<s:property value="txtaccountcurrency2"/>'>
            </td>
            <td width="25%" rowspan="2" align="center">
                <input type="button" name="btnAccountSearch" id="btnAccountSearch" class="myButton" value="Search" onclick="loadAccountSearch();">
            </td>
          </tr>
          <tr>
            <td align="right">Account Name</td>
            <td colspan="3">
                <input type="text" name="txtaccountsname2" id="txtaccountsname2" style="width: 98%;" value='<s:property value="txtaccountsname2"/>'>
            </td>
          </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="bankdiv">
            <jsp:include page="bankaccSubgrid.jsp" />
        </div>
    </div>

</div>

</body>
</html>