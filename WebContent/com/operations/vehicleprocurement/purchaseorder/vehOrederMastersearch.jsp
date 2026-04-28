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
	$(document).ready(function () { 
		/* Initialize JQX */ 	
	    $("#datess").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy", value:null}); 
        
        /* Sync JQX internal styling */
        setTimeout(function () {
            $(".jqx-datetimeinput").css({"border-color": "#b8c6d8", "border-radius": "3px"});
            $(".jqx-datetimeinput input").css({"line-height": "24px", "font-size": "12px", "font-family": "'Segoe UI', 'Roboto', 'Arial', sans-serif"});
            $(".jqx-datetimeinput .jqx-action-button").css({"height": "24px"});
        }, 100);
	});   
		   
	function loadSearchs() {
		var docnoss = document.getElementById("docnoss").value || "";
		var accountss = document.getElementById("accountss").value || "";
		var accnamesss = document.getElementById("accnamess").value || "";
		var datess = $('#datess').jqxDateTimeInput('val') || "";
		var reftypess = document.getElementById("reftypess").value || "";
		var aa = "yes";
        
		getdata(docnoss, accountss, accnamesss, datess, reftypess, aa);
	}

	function getdata(docnoss, accountss, accnamess, datess, reftypess, aa){
        /* Safely encode URI components instead of basic string replace */
		$("#refreshdivs").load('submasterSearch.jsp?docnoss=' + encodeURIComponent(docnoss) + 
                                            '&accountss=' + encodeURIComponent(accountss) + 
                                            '&accnamess=' + encodeURIComponent(accnamess) + 
                                            '&datess=' + encodeURIComponent(datess) + 
                                            '&reftypess=' + encodeURIComponent(reftypess) + 
                                            '&aa=' + aa);
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

#refreshdivs {
    margin-top: 5px;
}
</style>
</head>

<body bgcolor="#f5f7fa">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%">
            <tr>
                <td width="60px" align="right">Date</td>
                <td width="135px">
                    <div id="datess" name="datess" value='<s:property value="datess"/>'></div>
                </td>

                <td width="80px" align="right">Doc No</td>
                <td width="130px">
                    <input type="text" name="docnoss" id="docnoss" value='<s:property value="docnoss"/>'>
                </td>

                <td width="60px" align="right">Type</td>
                <td width="150px">
                    <select name="reftypess" id="reftypess" style="width: 100%;">
                        <option value="">--select--</option>
                        <option value="DIR">DIR</option>
                        <option value="VPR">VPR</option>
                    </select>
                </td>
                <td>&nbsp;</td> 
            </tr>

            <tr>
                <td align="right">Account</td>
                <td>
                    <input type="text" name="accountss" id="accountss" value='<s:property value="accountss"/>'>
                </td>

                <td align="right">Account Name</td>
                <td colspan="3"> 
                    <div style="display: flex; gap: 10px; align-items: center;">
                        <input type="text" name="accnamess" id="accnamess" style="width: 250px;" value='<s:property value="accnamess"/>'>
                        <input type="button" name="searchs" id="searchs" class="myButton" value="Search" onclick="loadSearchs()">
                    </div>
                </td>
                <td>&nbsp;</td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="refreshdivs">
            <jsp:include page="submasterSearch.jsp" />
        </div>
    </div>

</div>

</body>
</html>