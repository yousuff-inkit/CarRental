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

/* Restored Table Alignment */
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
        /* Upgraded height to 24px for Modern UI */
		$("#requestdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy", value:null});
		
        /* Force internal alignment AFTER render */
        setTimeout(function () {
            $(".jqx-datetimeinput").find("input").css({
                "margin-top": "0px", 
                "line-height": "24px", 
                "font-size": "12px", 
                "font-family": "Arial, sans-serif",
                "padding": "0 6px", 
                "box-sizing":"border-box"
            });
            $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
        }, 0);
	}); 

	function loadSearch() {
		var partyname = document.getElementById("txtpartyname").value || "";
		var docNo = document.getElementById("txtdocno").value || "";
		var date = $('#requestdate').jqxDateTimeInput('val') || "";
		var raType = document.getElementById("cmbrenttype").value || "";
		var raNo = document.getElementById("txtaggno").value || "";
	    
        var branchElem = document.getElementById("brchName");
	    var branch = branchElem ? branchElem.value : "";
	    
		getdata(partyname, docNo, date, raType, raNo, branch);
	}
	
	function getdata(partyname, docNo, date, raType, raNo, branch){
        /* Used encodeURIComponent to safely handle spaces and special characters */
		$("#refreshdiv").load('oreMainSearchGrid.jsp?partyname=' + encodeURIComponent(partyname) + 
                              '&docNo=' + encodeURIComponent(docNo) + 
                              '&date=' + date + 
                              '&raType=' + encodeURIComponent(raType) + 
                              '&raNo=' + encodeURIComponent(raNo) + 
                              '&branch=' + encodeURIComponent(branch));
	}
</script>
</head>

<body style="background-color: #fff; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="lbl-right" width="8%">Date</td>
                <td width="20%">
                    <div id="requestdate" name="requestdate" value='<s:property value="requestdate"/>'></div>
                    <input type="hidden" name="hidrequestdate" id="hidrequestdate" value='<s:property value="hidrequestdate"/>'>
                </td>
                
                <td class="lbl-right" width="12%">RA Type</td>
                <td width="20%">
                    <select id="cmbrenttype" name="cmbrenttype" value='<s:property value="cmbrenttype"/>'>
                        <option value="">--Select--</option>
                        <option value="RAG">Rental</option>
                        <option value="LAG">Lease</option>
                    </select>
                    <input type="hidden" id="hidcmbrenttype" name="hidcmbrenttype" value='<s:property value="hidcmbrenttype"/>'/>
                </td>
                
                <td class="lbl-right" width="15%">Agg. No.</td>
                <td width="25%">
                    <input type="text" name="txtaggno" id="txtaggno" value='<s:property value="txtaggno"/>'>
                </td>
            </tr>
            
            <tr>
                <td class="lbl-right">Name</td>
                <td>
                    <input type="text" name="txtpartyname" id="txtpartyname" value='<s:property value="txtpartyname"/>'>
                </td>
                
                <td class="lbl-right">Doc No</td>
                <td>
                    <input type="text" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'>
                </td>
                
                <td colspan="2" align="right">
                    <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch(); return false;">
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="refreshdiv">
            <jsp:include page="oreMainSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>