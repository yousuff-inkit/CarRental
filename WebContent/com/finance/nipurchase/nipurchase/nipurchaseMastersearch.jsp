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
.modern-ui input[type="text"], .modern-ui select {
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

.modern-ui input[type="text"]:focus, .modern-ui select:focus {
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
	    $("#datess").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy", value:null}); 
	});   
		   
	function loadSearchs() {
		var docnoss = document.getElementById("docnoss").value || "";
		var accountss = document.getElementById("accountss").value || "";
		var accnamess = document.getElementById("accnamess").value || "";
		var datess = $('#datess').jqxDateTimeInput('val') || "";
		var reftypess = document.getElementById("reftypess").value || "";
		var description = document.getElementById("description").value || "";
	    var aa = "yes";
	    
		getdata(docnoss, accountss, accnamess, datess, reftypess, aa, description);
	}
	
	function getdata(docnoss, accountss, accnamess, datess, reftypess, aa, description){
         /* Upgraded to encodeURIComponent to handle spaces & special chars safely */
		 $("#refreshdivs").load('submasterSearch.jsp?docnoss=' + encodeURIComponent(docnoss) + 
                                '&accountss=' + encodeURIComponent(accountss) + 
                                '&accnamess=' + encodeURIComponent(accnamess) + 
                                '&datess=' + datess + 
                                '&reftypess=' + encodeURIComponent(reftypess) + 
                                '&aa=' + aa + 
                                '&description=' + encodeURIComponent(description));
	}
</script>
</head>

<body style="background-color: #fff; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="lbl-right" width="8%">Doc No</td>
                <td width="20%">
                    <input type="text" name="docnoss" id="docnoss" value='<s:property value="docnoss"/>'>
                </td>
                
                <td class="lbl-right" width="10%">Account</td>
                <td width="20%">
                    <input type="text" name="accountss" id="accountss" value='<s:property value="accountss"/>'>
                </td>
                
                <td class="lbl-right" width="12%">Account Name</td>
                <td width="30%">
                    <input type="text" name="accnamess" id="accnamess" value='<s:property value="accnamess"/>'>
                </td>
            </tr>
            <tr>
                <td class="lbl-right">Date</td>
                <td>
                    <div id="datess" name="datess" value='<s:property value="datess"/>'></div>
                </td>
                
                <td class="lbl-right">Description</td>
                <td>
                    <input type="text" name="description" id="description" value='<s:property value="description"/>'>
                </td>
                
                <td class="lbl-right">Type</td>
                <td>
                    <div style="display: flex; gap: 5px; align-items: center;">
                        <select name="reftypess" id="reftypess" value='<s:property value="reftypess"/>' style="width: 100px;">
                            <option value="">--select--</option>
                            <option value="DIR">DIR</option>
                            <option value="NPO">NPO</option>
                        </select>
                        <input type="button" name="searchs" id="searchs" class="myButton" value="Search" onclick="loadSearchs(); return false;">
                    </div>
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="refreshdivs">
            <jsp:include page="submasterSearch.jsp"/>
        </div>
    </div>

</div>

</body>
</html>