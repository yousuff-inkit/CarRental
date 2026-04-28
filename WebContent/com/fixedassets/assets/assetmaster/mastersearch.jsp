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
   SCOPED UI: Strict Pixel Grid Alignment & Modern Inputs
========================================================= */
body {
    margin: 0;
    background-color: #fff;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif; 
}

.modern-ui {
    font-size: 12px;
    color: #333;
    padding: 10px;
    box-sizing: border-box;
    width: 100%;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

/* Master Input Heights - Explicit Font Family Added */
.modern-ui input[type="text"],
.modern-ui select {
    height: 24px !important;
    border: 1px solid #b8c6d8;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 12px;
    font-weight: normal !important; 
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
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
    padding: 15px 10px;
    margin-bottom: 10px;
}

/* Table Alignment - STRICT PERCENTAGE GRID */
.modern-ui table {
    border-collapse: separate;
    border-spacing: 5px 8px; 
    width: 100%;
    table-layout: fixed; /* Locks columns from squishing */
}

.modern-ui td {
    vertical-align: middle;
    padding: 0;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: 600;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Modern Search Button */
.modern-ui .myButton {
    height: 26px !important; 
    line-height: 24px !important;
    padding: 0 30px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #fff !important;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 12px;
    font-weight: bold; 
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
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
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <colgroup>
                <col width="10%" /> <col width="20%" /> <col width="10%" /> <col width="20%" /> <col width="12%" /> <col width="28%" /> </colgroup>
            
            <tr>
                <td class="lbl-right">Doc No</td>
                <td>
                    <input type="text" name="sdocno" id="sdocno" autocomplete="off" value='<s:property value="sdocno"/>'>
                </td>
                
                <td class="lbl-right">Asset Id</td>
                <td>
                    <input type="text" name="assetidss" id="assetidss" autocomplete="off" value='<s:property value="assetidss"/>'>
                </td>
                
                <td class="lbl-right">Asset Name</td>
                <td>
                    <input type="text" id="assetnamess" name="assetnamess" autocomplete="off" value='<s:property value="assetnamess"/>'>
                </td>
            </tr>

            <tr>
                <td class="lbl-right">Asset Group</td>
                <td colspan="3">
                    <input type="text" name="assetgroupss" id="assetgroupss" autocomplete="off" value='<s:property value="assetgroupss"/>'>
                </td>
                
                <td></td>
                
                <td align="right" valign="middle">
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