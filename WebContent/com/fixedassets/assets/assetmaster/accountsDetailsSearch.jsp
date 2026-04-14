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
SCOPED UI: Compact Search Modal Layout
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
.modern-ui input[type="text"],
.modern-ui select {
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

.modern-ui input[type="text"]:focus,
.modern-ui select:focus {
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

.modern-ui table {
    border-collapse: collapse;
    width: 100%;
}

.modern-ui td {
    padding: 4px 5px;
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
		 document.getElementById("txtnewdate").value = $('#masterdate').val() || "";
	}); 
	
	function loadClientAccountSearch() {
        var clientaccountno = document.getElementById("accountsno").value || "";
        var clientaccountname = document.getElementById("accountsname").value || "";
        var clientmobile = document.getElementById("clientmobileno").value || "";
        var curr = document.getElementById("txtcurrencies").value || "";
        var date = document.getElementById("txtnewdate").value || "";
        var checked = 1;

        getClientAccountDetails(clientaccountno, clientaccountname, clientmobile, curr, date, checked);
	}
		
	function getClientAccountDetails(clientaccountno, clientaccountname, clientmobile, curr, date, checked){
        /* Used encodeURIComponent to safely handle spaces and special characters */
		 $("#refreshClientAccountDiv").load("accountDetailsSearchGrid.jsp?accountno=" + encodeURIComponent(clientaccountno) + 
                                            '&accountname=' + encodeURIComponent(clientaccountname) + 
                                            '&mobile=' + encodeURIComponent(clientmobile) + 
                                            '&currency=' + encodeURIComponent(curr) + 
                                            '&date=' + date + 
                                            '&check=' + checked);
	}
</script>

</head>
<body style="background-color: #fff; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
            <tr>
                <td class="lbl-right" width="10%">Account No</td>
                <td width="25%">
                    <input type="text" name="accountsno" id="accountsno" value='<s:property value="accountsno"/>'>
                </td>
                
                <td class="lbl-right" width="10%">Currency</td>
                <td width="15%">
                    <input type="text" name="txtcurrencies" id="txtcurrencies" value='<s:property value="txtcurrencies"/>'>
                    <input type="hidden" name="txtatypes" id="txtatypes" value='<s:property value="txtatypes"/>'>
                    <input type="hidden" name="txtdocumenttypes" id="txtdocumenttypes" value='<s:property value="txtdocumenttypes"/>'>
                </td>
                
                <td class="lbl-right" width="10%">Mobile</td>
                <td width="30%">
                    <input type="text" name="clientmobileno" id="clientmobileno" value='<s:property value="clientmobileno"/>'>
                    <input type="hidden" name="txtcreditdebit" id="txtcreditdebit" value='<s:property value="txtcreditdebit"/>'>
                    <input type="hidden" name="txtnewdate" id="txtnewdate" value='<s:property value="txtnewdate"/>'>
                </td>
            </tr>

            <tr>
                <td class="lbl-right" style="padding-top: 8px;">Account Name</td>
                <td colspan="3" style="padding-top: 8px;">
                    <input type="text" name="accountsname" id="accountsname" value='<s:property value="accountsname"/>'>
                </td>
                
                <td colspan="2" align="center" valign="middle" style="padding-top: 8px;">
                    <input type="button" name="btnClientAccountSearch" id="btnClientAccountSearch" class="myButton" value="Search" onclick="loadClientAccountSearch(); return false;">
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="refreshClientAccountDiv">
            <jsp:include page="accountDetailsSearchGrid.jsp" />
        </div>
    </div>

</div>

</body>
</html>