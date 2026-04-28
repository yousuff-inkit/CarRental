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

/* Master Input Heights - Forced to 24px */
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
    padding: 12px 10px;
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
    padding: 0 25px;
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
    function loadSearchs() {
        var formdetailcode = document.getElementById("formdetailcode") ? document.getElementById("formdetailcode").value : "";
        var seachdoc = document.getElementById("seachdoc").value || "";
        var fleetnoss = document.getElementById("fleetnoss").value || "";
        var flnames = document.getElementById("flnamess").value || "";
        var regnoss = document.getElementById("regnoss").value || "";
        var aa = "yes";

        getdatas(seachdoc, fleetnoss, flnames, regnoss, aa, formdetailcode);
    }

    function getdatas(seachdoc, fleetnoss, flname, regnoss, aa, formdetailcode){ 
        /* Properly encoded URL parameters */
        $("#submastersearchs").load('submastersearch.jsp?fleetnoss=' + encodeURIComponent(fleetnoss) + 
                                   '&seachdoc=' + encodeURIComponent(seachdoc) + 
                                   '&flnames=' + encodeURIComponent(flname) + 
                                   '&regnoss=' + encodeURIComponent(regnoss) + 
                                   '&aa=' + aa + 
                                   "&formdetailcode=" + encodeURIComponent(formdetailcode));
    }
</script>
</head>

<body style="background-color: #fff; margin: 0;">
<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <colgroup>
                <col width="10%" /> <col width="25%" /> <col width="10%" /> <col width="25%" /> <col width="30%" /> </colgroup>
            
            <tr>
                <td class="lbl-right">Doc NO</td> 
                <td>
                    <input type="text" name="seachdoc" id="seachdoc" autocomplete="off" value='<s:property value="seachdoc"/>'>
                </td> 
                
                <td class="lbl-right">Fleet</td> 
                <td>
                    <input type="text" name="fleetnoss" id="fleetnoss" autocomplete="off" value='<s:property value="fleetnoss"/>'>
                </td>

                <td rowspan="2" align="center" valign="middle">
                    <input type="button" id="searchdata" value="Search" class="myButton" onclick="loadSearchs();">
                </td>
            </tr>

            <tr>
                <td class="lbl-right">Reg No</td>
                <td>
                    <input type="text" name="regnoss" id="regnoss" autocomplete="off" value='<s:property value="regnoss"/>'>
                </td>
                
                <td class="lbl-right">Name</td>
                <td>
                    <input type="text" name="flnamess" id="flnamess" autocomplete="off" value='<s:property value="flnamess"/>'>
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="submastersearchs">
            <jsp:include page="submastersearch.jsp"></jsp:include> 
        </div>
    </div>

</div>
</body>
</html>