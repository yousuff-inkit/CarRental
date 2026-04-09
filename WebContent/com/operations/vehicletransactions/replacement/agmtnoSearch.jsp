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
        /* COMPACT DATE/TIME SIZING (120px width, 24px height) */
		$("#searchdate").jqxDateTimeInput({ width: '120px', height: '24px', formatString:"dd.MM.yyyy", value:null});
		
        /* Force internal alignment AFTER render */
        setTimeout(function () {
            $(".jqx-datetimeinput").find("input").css({
                "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
                "font-family": "Arial, sans-serif", "padding": "0 6px", "box-sizing":"border-box"
            });
            $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
        }, 0);
	});

	function loadSearch() {
		var docnosearch1 = document.getElementById("docnosearch").value || "";
		var fleetsearch = document.getElementById("fleetsearch").value || "";
		var regnosearch = document.getElementById("regnosearch").value || "";
		var clientsearch = document.getElementById("clientsearch").value || "";
	 	var searchdate = $('#searchdate').jqxDateTimeInput('val') || "";
        
        // Safely pull from parent document elements if they exist
	 	var agmttype = document.getElementById("cmbrentaltype") ? document.getElementById("cmbrentaltype").value : "";
		var mobilesearch = document.getElementById("mobilesearch").value || "";
		var agmtbranch1 = document.getElementById("cmbagmtbranch") ? document.getElementById("cmbagmtbranch").value.trim() : "";
 		
		getdata(docnosearch1, fleetsearch, regnosearch, clientsearch, searchdate, mobilesearch, agmttype, agmtbranch1);
	}
 	
	function getdata(docnosearch, fleetsearch, regnosearch, clientsearch, searchdate, mobilesearch, agmttype, agmtbranch1) {
        /* Safely encode URI components to prevent special character crashes */
        var targetUrl = "gridAgmtSearch.jsp?agmttype=" + encodeURIComponent(agmttype) + 
                        "&docno=" + encodeURIComponent(docnosearch) + 
                        "&fleet=" + encodeURIComponent(fleetsearch) + 
                        "&regno=" + encodeURIComponent(regnosearch) + 
                        "&client=" + encodeURIComponent(clientsearch) + 
                        "&date=" + encodeURIComponent(searchdate) + 
                        "&mobile=" + encodeURIComponent(mobilesearch) + 
                        "&agmtbranch1=" + encodeURIComponent(agmtbranch1);
                        
		$("#loadAgmtSearch").load(targetUrl);
	}
</script>

</head>
<body style="background-color: #fff; margin: 0;">

<div class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
            <tr>
                <td class="lbl-right" width="10%">Doc No</td>
                <td width="15%">
                    <input type="text" name="docnosearch" id="docnosearch" value='<s:property value="docnosearch"/>'>
                </td>
                <td class="lbl-right" width="10%">Fleet</td>
                <td width="15%">
                    <input type="text" name="fleetsearch" id="fleetsearch" value='<s:property value="fleetsearch"/>'>
                </td>
                <td class="lbl-right" width="10%">Reg No</td>
                <td width="15%">
                    <input type="text" name="regnosearch" id="regnosearch" value='<s:property value="regnosearch"/>'>
                </td>
                <td class="lbl-right" width="10%">License No</td>
                <td width="15%">
                    <input type="text" name="licensesearch" id="licensesearch" value='<s:property value="licensesearch"/>'>
                </td>
            </tr>
            
            <tr>
                <td class="lbl-right" style="padding-top: 10px;">Client</td>
                <td style="padding-top: 10px;">
                    <input type="text" name="clientsearch" id="clientsearch" value='<s:property value="clientsearch"/>'>
                </td>
                <td class="lbl-right" style="padding-top: 10px;">Date</td>
                <td style="padding-top: 10px;">
                    <div id="searchdate" name="searchdate" value='<s:property value="searchdate"/>'></div>
                    <input type="hidden" name="hidsearchdate" id="hidsearchdate" value='<s:property value="hidsearchdate"/>'>
                </td>
                <td class="lbl-right" style="padding-top: 10px;">Mobile</td>
                <td style="padding-top: 10px;">
                    <input type="text" name="mobilesearch" id="mobilesearch" value='<s:property value="mobilesearch"/>'>
                </td>
                <td colspan="2" align="center" style="padding-top: 10px;">
                    <input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search" onclick="loadSearch();">
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="loadAgmtSearch">
            <jsp:include page="gridAgmtSearch.jsp" />
        </div>
    </div>

</div>

</body>
</html>