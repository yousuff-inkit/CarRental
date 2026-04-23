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
   SCOPED UI: Compact Search Modal Layout (Pure White & Segoe UI)
========================================================= */
body {
    margin: 0;
    background-color: #fff;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
}

.modern-ui {
    font-size: 12px;
    color: #333;
    padding: 10px;
    box-sizing: border-box;
    width: 100%;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
}

/* Master Input Heights - Forced to 24px and Font Enforced */
.modern-ui input[type="text"],
.modern-ui select {
    height: 24px !important;
    border: 1px solid #b8c6d8;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 12px;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
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

/* Panel Styling - Pure White */
.modern-ui .search-panel {
    background-color: #fff !important; 
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
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Modern Search Button - Font Enforced */
.modern-ui .myButton {
    height: 24px !important; 
    line-height: 22px !important;
    padding: 0 20px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #fff !important;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 12px;
    font-weight: bold;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
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
	function loadSearchs() {
		var fleetno = document.getElementById("fleetno").value || "";
		var regno = document.getElementById("regno").value || "";
		var flnames = document.getElementById("flname").value || "";
		var color = document.getElementById("color").value || "";
		var group = document.getElementById("group").value || "";
	
		var aa = "yes";
		getdata(fleetno, regno, flnames, color, group, aa);
	}
	
	function getdata(fleetno, regno, flname, color, group, aa){
        /* Used encodeURIComponent to safely handle spaces and special characters */
		 $("#refreshdivs").load('subvehinfo.jsp?fleetno=' + encodeURIComponent(fleetno) + 
                                '&regno=' + encodeURIComponent(regno) + 
                                '&flname=' + encodeURIComponent(flname) + 
                                '&color=' + encodeURIComponent(color) + 
                                '&group=' + encodeURIComponent(group) + 
                                '&aa=' + encodeURIComponent(aa));
	}
</script>

</head>
<body style="background-color: #fff; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
            <tr>
                <td class="lbl-right" width="8%">Fleet</td>
                <td width="20%">
                    <input type="text" name="fleetno" id="fleetno" value='<s:property value="fleetno"/>'>
                </td>
                
                <td class="lbl-right" width="8%">Reg No</td>
                <td width="20%">
                    <input type="text" name="regno" id="regno" value='<s:property value="regno"/>'>
                </td>
                
                <td class="lbl-right" width="8%">Name</td>
                <td width="30%">
                    <input type="text" name="flname" id="flname" value='<s:property value="flname"/>'>
                </td>
            </tr>

            <tr>
                <td class="lbl-right" style="padding-top: 8px;">Color</td>
                <td style="padding-top: 8px;">
                    <input type="text" name="color" id="color" value='<s:property value="color"/>'>
                </td>
                
                <td class="lbl-right" style="padding-top: 8px;">Group</td>
                <td style="padding-top: 8px;">
                    <input type="text" name="group" id="group" value='<s:property value="group"/>'>
                </td>
                
                <td colspan="2" align="right" valign="middle" style="padding-top: 8px;">
                    <input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search" onclick="loadSearchs(); return false;">
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="refreshdivs">
            <jsp:include page="subvehinfo.jsp"></jsp:include> 
        </div>
    </div>

</div>

</body>
</html>