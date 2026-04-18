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
   SCOPED UI: Segoe UI Font & Clean White Search Panel
========================================================= */
body {
    margin: 0;
    background-color: #fff; /* Main background white */
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
.modern-ui input[type="text"] {
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

.modern-ui input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
    background-color: #FFD6FF; /* Client master focus color */
}

/* Panel Styling - Clean White Panel */
.modern-ui .search-panel {
    background-color: #fff !important; 
    border: 1px solid #BDBDBD;
    border-radius: 4px;
    padding: 12px;
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
    color: #222;
    font-size: 12px; 
    font-weight: 600;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Search Button - Modern Blue */
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
}

.modern-ui .myButton:hover {
    background-color: #004494;
}

/* Grid Container */
.modern-ui .grid-container {
    border: 1px solid #BDBDBD;
    background: #fff;
}
</style>

<script type="text/javascript">
	$(document).ready(function () {
        /* Even if hidden, keeping the height formatted properly */
		$("#txtaccperiod").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy"});
        
        if (document.getElementById("cmbacctype")) {
		    document.getElementById("txtatypes").value = document.getElementById("cmbacctype").value;
        }
		
        if (window.parent && window.parent.txtaccountperiodfrom) {
		    var year = window.parent.txtaccountperiodfrom.value;
		    var newDate = year.split('-');
		    if (newDate.length === 3) {
                year = newDate[1] + "-" + newDate[0] + "-" + newDate[2];
		        $('#txtaccperiod').jqxDateTimeInput('setDate', new Date(year));
            }
        }
	}); 

	function loadClientAccountSearch() {
        var clientaccountno   = document.getElementById("accountsno").value || "";
        var clientaccountname = document.getElementById("accountsname").value || "";
        var clientmobile      = document.getElementById("clientmobileno").value || "";
        var curr              = document.getElementById("txtcurrencies").value || "";
        var accounttype       = document.getElementById("txtatypes").value || "";
        var date              = document.getElementById("txtaccperiod").value || "";
        var checked           = 1;

        getClientAccountDetails(clientaccountno, clientaccountname, clientmobile, curr, accounttype, date, checked);
	}
		
	function getClientAccountDetails(clientaccountno, clientaccountname, clientmobile, curr, accounttype, date, checked){
        /* Upgraded to encodeURIComponent to handle spaces & special chars safely */
		$("#refreshClientAccountDiv").load("clientAccountDetailsSearchGrid.jsp?accountno=" + encodeURIComponent(clientaccountno) +
            '&accountname=' + encodeURIComponent(clientaccountname) +
            '&mobile=' + encodeURIComponent(clientmobile) +
            '&currency=' + encodeURIComponent(curr) +
            '&atype=' + encodeURIComponent(accounttype) +
            '&date=' + date +
            '&check=' + checked
        );
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
                    <input type="text" name="accountsno" id="accountsno" autocomplete="off" value='<s:property value="accountsno"/>'>
                </td>
                
                <td class="lbl-right" width="15%">Currency</td>
                <td width="25%">
                    <input type="text" name="txtcurrencies" id="txtcurrencies" autocomplete="off" value='<s:property value="txtcurrencies"/>'>
                    
                    <input type="hidden" name="txtatypes" id="txtatypes" value='<s:property value="txtatypes"/>'>
                    <div hidden="true" id="txtaccperiod" name="txtaccperiod" value='<s:property value="txtaccperiod"/>'></div>
                </td>
                
                <td width="20%" rowspan="2" align="center">
                    <input type="button" name="btnClientAccountSearch" id="btnClientAccountSearch" class="myButton" value="Search" onclick="loadClientAccountSearch(); return false;">
                </td>
            </tr>
            <tr>
                <td class="lbl-right">Account Name</td>
                <td>
                    <input type="text" name="accountsname" id="accountsname" autocomplete="off" value='<s:property value="accountsname"/>'>
                </td>
                
                <td class="lbl-right">Mobile</td>
                <td>
                    <input type="text" name="clientmobileno" id="clientmobileno" autocomplete="off" value='<s:property value="clientmobileno"/>'>
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="refreshClientAccountDiv">
            <jsp:include page="clientAccountDetailsSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>