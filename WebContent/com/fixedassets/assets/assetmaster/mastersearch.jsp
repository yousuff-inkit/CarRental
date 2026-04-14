<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

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
		// Any setup code needed
	}); 

	function mainloadSearch() {
		var sdocno = document.getElementById("sdocno").value || "";
		var assetid = document.getElementById("assetidss").value || "";
		var assetname = document.getElementById("assetnamess").value || "";
		var assetgroup = document.getElementById("assetgroupss").value || "";
		var chk = "yes";
		
		getdata(assetname, assetid, sdocno, assetgroup, chk);
	}
	
	function getdata(assetname, assetid, sdocno, assetgroup, chk){
        /* Used encodeURIComponent to safely handle spaces and special characters */
		$("#srefreshdiv").load('submasterSearch.jsp?assetname=' + encodeURIComponent(assetname) + 
                               '&assetid=' + encodeURIComponent(assetid) + 
                               '&sdocno=' + encodeURIComponent(sdocno) + 
                               '&assetgroup=' + encodeURIComponent(assetgroup) + 
                               '&chk=' + chk);
	}
</script>

</head>
<body style="background-color: #fff; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
            <tr>
                <td class="lbl-right" width="8%">Doc No</td>
                <td width="20%">
                    <input type="text" name="sdocno" id="sdocno" value='<s:property value="sdocno"/>'>
                </td>
                
                <td class="lbl-right" width="10%">Asset Id</td>
                <td width="25%">
                    <input type="text" name="assetidss" id="assetidss" value='<s:property value="assetidss"/>'>
                </td>
                
                <td class="lbl-right" width="10%">Asset Name</td>
                <td width="27%">
                    <input type="text" id="assetnamess" name="assetnamess" value='<s:property value="assetnamess"/>'>
                </td>
            </tr>

            <tr>
                <td class="lbl-right" style="padding-top: 8px;">Asset Group</td>
                <td colspan="4" style="padding-top: 8px;">
                    <input type="text" name="assetgroupss" id="assetgroupss" value='<s:property value="assetgroupss"/>' style="width: 50%;">
                </td>
                
                <td align="center" valign="middle" style="padding-top: 8px;">
                    <input type="button" name="mbtnrasearch" id="mbtnrasearch" class="myButton" value="Search" onclick="mainloadSearch(); return false;">
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="srefreshdiv">
            <jsp:include page="submasterSearch.jsp" />
        </div>
    </div>

</div>

</body>
</html>