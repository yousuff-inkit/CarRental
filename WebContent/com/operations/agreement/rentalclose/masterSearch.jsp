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
    border-collapse: separate;
    border-spacing: 5px 8px; /* Restored spacing to prevent squishing */
    width: 100%;
}

.modern-ui td {
    padding: 2px 5px;
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
    margin-right: 15px; /* Push button away from checkbox */
}

.modern-ui input[type="checkbox"] {
    margin: 0;
    cursor: pointer;
}

/* Modern Search Button - Font Enforced */
.modern-ui .myButton {
    height: 26px !important; /* Slightly taller than input for visual hierarchy */
    line-height: 24px !important;
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
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="lbl-right" width="8%">Name</td>
                <td width="30%" colspan="3">
                    <input type="text" name="SCl_name" id="SCl_name" value='<s:property value="SCl_name"/>'>
                </td>
                
                <td class="lbl-right" width="8%">MOB</td>
                <td width="15%">
                    <input type="text" name="Sl_mob" id="Sl_mob" value='<s:property value="Sl_mob"/>'>
                </td>
                
                <td class="lbl-right" width="8%">MRA</td>
                <td width="15%">
                    <input type="text" id="smra" name="smra" value='<s:property value="smra"/>'>
                </td>
            </tr>

            <tr>
                <td class="lbl-right">Doc NO</td>
                <td width="15%">
                    <input type="text" name="rno" id="rno" value='<s:property value="rno"/>'>
                </td>
                
                <td class="lbl-right" width="10%">Fleet NO</td>
                <td width="15%">
                    <input type="text" name="flno" id="flno" value='<s:property value="flno"/>'>
                </td>
                
                <td class="lbl-right">Reg NO</td>
                <td>
                    <input type="text" id="sregno" name="sregno" value='<s:property value="sregno"/>'>
                </td>
                
                <td colspan="2" align="right" valign="middle">
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