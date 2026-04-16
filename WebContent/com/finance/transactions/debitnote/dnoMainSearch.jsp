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

/* Search Button - Modern Blue matched to Client Master */
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
        /* Date left untouched at 15px height */
		$("#debitdate").jqxDateTimeInput({ width: '110px', height: '15px', formatString:"dd.MM.yyyy", value:null});
	}); 

	function loadSearch() {
		var docNo = document.getElementById("txtdocumentno").value || "";
		var date = $('#debitdate').jqxDateTimeInput('val') || "";
		var accId = document.getElementById("txtaccountid").value || "";
		var accName = document.getElementById("txtaccountname").value || "";
		var amounts = document.getElementById("txtamounts").value || "";
        var description = document.getElementById("txtdescriptions").value || "";
	    var check = 1;
	    
        /* Preserved your specific logic for amount inversion safely */
        var amount = "";
        if(amounts !== "") {
            amount = (parseFloat(amounts) * -1);
        }
        
		getdata(docNo, date, accId, accName, amount, description, check);
	}
	
	function getdata(docNo, date, accId, accName, amount, description, check){
         /* Upgraded to encodeURIComponent to handle spaces & special chars safely */
		 $("#refreshdiv").load('dnoMainSearchGrid.jsp?docNo=' + encodeURIComponent(docNo) + 
                               '&date=' + date + 
                               '&accId=' + encodeURIComponent(accId) + 
                               '&accName=' + encodeURIComponent(accName) + 
                               '&amount=' + encodeURIComponent(amount) + 
                               '&description=' + encodeURIComponent(description) + 
                               '&check=' + check);
	}
</script>
</head>

<body style="background-color: #fff; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="lbl-right" width="10%">Doc No</td>
                <td width="20%">
                    <input type="text" name="txtdocumentno" id="txtdocumentno" value='<s:property value="txtdocumentno"/>'>
                </td>
                
                <td class="lbl-right" width="10%">Date</td>
                <td width="15%">
                    <div id="debitdate" name="debitdate" value='<s:property value="debitdate"/>'></div>
                    <input type="hidden" name="hiddebitdate" id="hiddebitdate" value='<s:property value="hiddebitdate"/>'>
                </td>
                
                <td class="lbl-right" width="10%">A/C No.</td>
                <td width="20%">
                    <input type="text" name="txtaccountid" id="txtaccountid" value='<s:property value="txtaccountid"/>'>
                </td>
                
                <td width="15%" align="center" rowspan="2">
                    <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch(); return false;">
                </td>
            </tr>
            <tr>
                <td class="lbl-right">A/C Name</td>
                <td>
                    <input type="text" name="txtaccountname" id="txtaccountname" value='<s:property value="txtaccountname"/>'>
                </td>
                
                <td class="lbl-right">Amount</td>
                <td>
                    <input type="text" name="txtamounts" id="txtamounts" value='<s:property value="txtamounts"/>'>
                </td>
                
                <td class="lbl-right">Description</td>
                <td>
                    <input type="text" name="txtdescriptions" id="txtdescriptions" value='<s:property value="txtdescriptions"/>'>
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="refreshdiv">
            <jsp:include page="dnoMainSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>