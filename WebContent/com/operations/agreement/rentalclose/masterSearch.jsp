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

/* Checkbox Alignment */
.modern-ui .chk-label {
    display: inline-flex;
    align-items: center;
    gap: 5px;
    font-size: 12px;
    font-weight: bold;
    color: #444;
    cursor: pointer;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
}

.modern-ui input[type="checkbox"] {
    margin: 0;
    cursor: pointer;
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

.jqx-grid-header {
    background: linear-gradient(180deg, #e9ecef 0%, #dee2e6 100%) !important;
    border-color: #ced4da !important;
    color: #212529 !important;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

.jqx-grid-column-header {
    background: transparent !important;
    color: #212529 !important;
    font-weight: 700 !important;
    font-size: 11px !important;
    text-align: left !important;
    border-color: #ced4da !important;
}

.jqx-grid-column-header a:link,
.jqx-grid-column-header a:visited {
    color: #212529 !important;
    text-align: left !important;
}

.jqx-grid-column-header > div > div {
    text-align: left !important;
    padding-left: 6px !important;
}


.jqx-grid-cell {
    background: #ffffff;
    border-color: #dee2e6 !important; 
    border-width: 0px 0px 1px 0px !important;
    color: #1f2937;
    font-size: 11px !important;
    text-align: left !important;
}

.jqx-grid-cell-left-align {
    text-align: left !important;
    padding-left: 6px !important;
    margin-left: 0px !important;
}

.jqx-grid-cell-middle-align {
    text-align: left !important;
    padding-left: 6px !important;
}

.jqx-grid-cell-right-align {
    text-align: right !important;
    padding-right: 6px !important;
}


.jqx-grid-cell-alt {
    background: #f1f3f5 !important; 
}


.jqx-grid-cell-hover {
    background: #dee2e6 !important; 
    border-color: #ced4da !important;
    color: #000000 !important;
}

.jqx-grid-cell-selected {
    background: #adb5bd !important; 
    color: #ffffff !important;
    border-color: #868e96 !important;
}

.jqx-grid-table .jqx-grid-cell {
    border-width: 0px 0px 1px 0px !important;
    border-color: #dee2e6 !important;
}


.jqx-grid {
    border: 1px solid #adb5bd !important; 
    border-radius: 8px !important;
    overflow: hidden !important;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1) !important;
}


.jqx-grid-cell-sort {
    background-color: #e9ecef !important;
}
.jqx-grid-cell-sort-alt {
    background-color: #dee2e6 !important;
}

.jqx-grid-cell-filter,
.jqx-grid-cell-filter-alt {
    background-color: #f1f3f5 !important;
}

.jqx-grid-cell-pinned,
.jqx-grid-cell-pinned-alt {
    background-color: #e9ecef !important;
}


.jqx-grid-pager {
    background: #e9ecef !important; 
    border-top: 1px solid #ced4da !important;
    padding: 4px !important;
}

.jqx-grid-column-menubutton {
    opacity: 0.5;
    transition: opacity 0.2s;
}
.jqx-grid-column-menubutton:hover {
    opacity: 1;
}


.jqx-scrollbar-state-normal {
    background: #f1f3f5 !important;
}
.jqx-scrollbar-thumb-state-normal,
.jqx-scrollbar-thumb-state-normal-horizontal {
    background: #868e96 !important; 
    border-color: #868e96 !important;
    border-radius: 4px !important;
}
.jqx-scrollbar-thumb-state-hover,
.jqx-scrollbar-thumb-state-hover-horizontal {
    background: #495057 !important; 
    border-radius: 4px !important;
}

</style>

<script type="text/javascript">
	$(document).ready(function () {
	
	}); 

	function mainloadSearch() {
		var sclname = document.getElementById("SCl_name").value || "";
		var smob = document.getElementById("Sl_mob").value || "";
		var rno = document.getElementById("rno").value || "";
		var flno = document.getElementById("flno").value || "";
		var sregno = document.getElementById("sregno").value || "";
		var smra = document.getElementById("smra").value || "";
		
        /* Added safety check in case brchName doesn't exist on this popup */
        var branchElem = document.getElementById("brchName");
		var branch = branchElem ? branchElem.value : "";
		
        var allbranch = document.getElementById("branch_chk").value || "0";
        
		getdata(sclname, smob, rno, flno, sregno, smra, branch, allbranch);
	}
    
	function getdata(sclname, smob, rno, flno, sregno, smra, branch, allbranch){
        /* Used encodeURIComponent to safely handle spaces and special characters */
		$("#srefreshdiv").load('submainSearch.jsp?sclname=' + encodeURIComponent(sclname) + 
                                '&smob=' + encodeURIComponent(smob) + 
                                '&rno=' + encodeURIComponent(rno) + 
                                '&flno=' + encodeURIComponent(flno) + 
                                '&sregno=' + encodeURIComponent(sregno) + 
                                '&smra=' + encodeURIComponent(smra) + 
                                '&branch=' + encodeURIComponent(branch) + 
                                '&allbranch=' + allbranch);
	}
</script>

</head>
<body style="background-color: #fff; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
            <tr>
                <td class="lbl-right" width="8%">Name</td>
                <td width="40%" colspan="3">
                    <input type="text" name="SCl_name" id="SCl_name" value='<s:property value="SCl_name"/>'>
                </td>
                
                <td class="lbl-right" width="8%">MOB</td>
                <td width="20%">
                    <input type="text" name="Sl_mob" id="Sl_mob" value='<s:property value="Sl_mob"/>'>
                </td>
                
                <td class="lbl-right" width="8%">MRA</td>
                <td width="16%">
                    <input type="text" id="smra" name="smra" value='<s:property value="smra"/>'>
                </td>
            </tr>

            <tr>
                <td class="lbl-right" style="padding-top: 8px;">Doc NO</td>
                <td width="15%" style="padding-top: 8px;">
                    <input type="text" name="rno" id="rno" value='<s:property value="rno"/>'>
                </td>
                
                <td class="lbl-right" width="10%" style="padding-top: 8px;">Fleet NO</td>
                <td width="15%" style="padding-top: 8px;">
                    <input type="text" name="flno" id="flno" value='<s:property value="flno"/>'>
                </td>
                
                <td class="lbl-right" style="padding-top: 8px;">Reg NO</td>
                <td style="padding-top: 8px;">
                    <input type="text" id="sregno" name="sregno" value='<s:property value="sregno"/>'>
                </td>
                
                <td colspan="2" align="right" valign="middle" style="padding-top: 8px; display: flex; justify-content: flex-end; align-items: center; gap: 15px;">
                    <label class="chk-label">
                        <input type="checkbox" id="branch_chk" name="branch_chk" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                        All Branch
                    </label>
                    <input type="button" name="mbtnrasearch" id="mbtnrasearch" class="myButton" value="Search" onclick="mainloadSearch(); return false;">
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="srefreshdiv">
            <jsp:include page="submainSearch.jsp"></jsp:include> 
        </div>
    </div>

</div>

</body>
</html>