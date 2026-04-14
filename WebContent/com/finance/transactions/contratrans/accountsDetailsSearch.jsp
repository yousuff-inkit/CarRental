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
   SCOPED UI: Compact Search Modal Layout (Table-Based)
========================================================= */
body {
    margin: 0;
    background-color: #fff;
    font-family: Arial, sans-serif;
}

.modern-ui {
    font-size: 12px;
    color: #333;
    padding: 10px;
    box-sizing: border-box;
    width: 100%;
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"] {
    height: 24px !important;
    border: 1px solid #b8c6d8;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box;
    background-color: #fff;
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
}

/* Panel Styling */
.modern-ui .search-panel {
    background-color: #f4f7fb;
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    padding: 15px;
    margin-bottom: 10px;
}

/* Table Alignment */
.modern-ui table {
    border-collapse: separate;
    border-spacing: 5px 8px; 
    width: 100%;
}

.modern-ui td {
    vertical-align: middle;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Modern Search Button */
.modern-ui .myButton {
    height: 26px;
    padding: 0 20px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #fff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 12px;
    font-weight: bold;
    box-shadow: 0 1px 2px rgba(59, 130, 246, 0.3);
    transition: all 0.2s;
    text-transform: uppercase;
}

.modern-ui .myButton:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%);
    transform: translateY(-1px);
}

/* Data Grid Container */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}
</style>

<script type="text/javascript">
	$(document).ready(function () {
		document.getElementById("txtfromtypes").value = document.getElementById("cmbtype") ? document.getElementById("cmbtype").value : "";
		document.getElementById("txttotypes").value = document.getElementById("cmbtotype") ? document.getElementById("cmbtotype").value : "";
		document.getElementById("txtfromto").value = document.getElementById("txtfromorto") ? document.getElementById("txtfromorto").value : "";
		document.getElementById("txtnewdates").value = $('#maindate').val() || "";
	}); 
	
	function loadAccountSearch() {
        var accountsno = document.getElementById("txtaccountsno").value || "";
        var accountsname = document.getElementById("txtaccountsname").value || "";
        var currs = document.getElementById("txtaccountcurrency").value || "";
        var fromto = document.getElementById("txtfromto").value || "";
        var dates = document.getElementById("txtnewdates").value || "";
        var check = 1;
        var type = "";
        
        if(fromto == "2"){
            type = document.getElementById("txtfromtypes").value || "";
        }
        else if(fromto == "3"){
            type = document.getElementById("txttotypes").value || "";
        }

        getAccountDetails(accountsno, accountsname, currs, fromto, type, dates, check);
	}
		
	function getAccountDetails(accountsno, accountsname, currs, fromto, type, dates, check){
        /* Safely encodes all parameters including spaces and special characters */
		 $("#refreshAccountDetailsDiv").load("accountDetailsSearchGrid.jsp?accountno=" + encodeURIComponent(accountsno) +
                                             "&accountname=" + encodeURIComponent(accountsname) +
                                             "&currency=" + encodeURIComponent(currs) +
                                             "&type=" + encodeURIComponent(type) +
                                             "&fromto=" + encodeURIComponent(fromto) +
                                             "&dates=" + encodeURIComponent(dates) +
                                             "&check=" + check);
	}
</script>
</head>

<body style="background-color: #fff; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="lbl-right" width="15%">Account No</td>
                <td width="25%">
                    <input type="text" name="txtaccountsno" id="txtaccountsno" value='<s:property value="txtaccountsno"/>'>
                </td>
                
                <td class="lbl-right" width="10%">Currency</td>
                <td width="25%">
                    <input type="text" name="txtaccountcurrency" id="txtaccountcurrency" value='<s:property value="txtaccountcurrency"/>'>
                    <input type="hidden" name="txtfromtypes" id="txtfromtypes" value='<s:property value="txtfromtypes"/>'>
                    <input type="hidden" name="txttotypes" id="txttotypes" value='<s:property value="txttotypes"/>'>
                    <input type="hidden" name="txtfromto" id="txtfromto" value='<s:property value="txtfromto"/>'>
                    <input type="hidden" name="txtnewdates" id="txtnewdates" value='<s:property value="txtnewdates"/>'>
                </td>
                
                <td width="25%" align="center" rowspan="2">
                    <input type="button" name="btnAccountSearch" id="btnAccountSearch" class="myButton" value="Search" onclick="loadAccountSearch(); return false;">
                </td>
            </tr>
            <tr>
                <td class="lbl-right">Account Name</td>
                <td colspan="3">
                    <input type="text" name="txtaccountsname" id="txtaccountsname" value='<s:property value="txtaccountsname"/>'>
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