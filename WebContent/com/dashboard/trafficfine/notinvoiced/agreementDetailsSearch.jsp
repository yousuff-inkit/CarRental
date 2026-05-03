<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

<style type="text/css">
/* =========================================================
   SCOPED UI: Modern Search Popup Style
========================================================= */
body {
    margin: 0;
    background-color: #f5f7fa; 
}

#search.modern-ui {
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    font-size: 12px !important;
    color: #333;
    padding: 10px;
    background-color: #f5f7fa;
}

.modern-ui .search-panel {
    background: #fff;
    border: 1px solid #c5d3e0;
    border-radius: 8px;
    padding: 12px 10px;
    margin-bottom: 12px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.04);
}

.modern-ui .grid-container {
    background: #fff;
    border: 1px solid #c5d3e0;
    border-radius: 8px;
    padding: 5px;
    min-height: 50px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.04);
}

/* Table layout */
.modern-ui table {
    border-collapse: separate;
    border-spacing: 4px 8px; 
    width: 100%;
}

.modern-ui td {
    font-size: 12px !important;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    vertical-align: middle;
}

.modern-ui td[align="right"] {
    color: #444 !important;
    font-weight: 600 !important;
    padding-right: 8px;
    white-space: nowrap;
}

.modern-ui .formfont {
    font-size: 12px;
    font-weight: 600;
    cursor: default;
    color: #444;
}

/* Master Input Heights */
.modern-ui input[type="text"] {
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
}

.modern-ui input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
    box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.1);
}

/* Buttons */
.modern-ui .myButton {
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    font-weight: 700 !important;
    font-size: 12px !important;
    height: 24px !important; 
    line-height: 22px !important;
    padding: 0 15px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%) !important;
    color: #ffffff !important;
    border: 1px solid #083a8a; 
    border-radius: 3px;
    cursor: pointer;
    box-shadow: 0 1px 2px rgba(59, 130, 246, 0.3);
    text-align: center;
    width: 100%;
}

.modern-ui .myButton:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%) !important;
}
</style>

<script type="text/javascript">
$(document).ready(function () {}); 

function mainloadSearch() {
    var sclname = document.getElementById("SCl_name").value;
    var smob = document.getElementById("Sl_mob").value;
    var rno = document.getElementById("rno").value;
    var flno = document.getElementById("flno").value;
    var sregno = document.getElementById("sregno").value;
    
    // Safety check to handle if these exist in the parent document (common in popups)
    var cmbbranchEle = document.getElementById("cmbbranch");
    var cmbbranch = cmbbranchEle ? cmbbranchEle.value : "";
    
    var rentaltypeEle = document.getElementById("rentaltype");
    var rentaltype = rentaltypeEle ? rentaltypeEle.value : "";
    
    getdata(sclname, smob, rno, flno, sregno, rentaltype, cmbbranch);
}

function getdata(sclname, smob, rno, flno, sregno, rentaltype, cmbbranch){
    $("#srefreshdiv").load('agreementDetailsSearchGrid.jsp?sclname=' + encodeURIComponent(sclname) + 
        '&smob=' + encodeURIComponent(smob) + 
        '&rno=' + encodeURIComponent(rno) + 
        '&flno=' + encodeURIComponent(flno) + 
        '&sregno=' + encodeURIComponent(sregno) + 
        '&rentaltype=' + encodeURIComponent(rentaltype) + 
        '&branch=' + encodeURIComponent(cmbbranch));
}
</script>
</head>

<body bgcolor="#f5f7fa">
<div id="search" class="modern-ui">

    <!-- SEARCH FORM -->
    <div class="search-panel">
        <table width="100%" cellpadding="0" cellspacing="0">
            <colgroup>
                <col width="8%">  <col width="25%">
                <col width="8%">  <col width="25%">
                <col width="8%">  <col width="26%">
            </colgroup>

            <!-- Row 1 -->
            <tr>
                <td align="right"><label class="formfont">Name</label></td>
                <td align="left">
                    <input type="text" name="SCl_name" id="SCl_name" value='<s:property value="SCl_name"/>'>
                </td>

                <td align="right"><label class="formfont">Mob</label></td>
                <td align="left">
                    <input type="text" name="Sl_mob" id="Sl_mob" value='<s:property value="Sl_mob"/>'>
                </td>
                
                <td align="right"><label class="formfont">Reg No</label></td>
                <td align="left">
                    <input type="text" name="sregno" id="sregno" value='<s:property value="sregno"/>'>
                </td>
            </tr>

            <!-- Row 2 -->
            <tr>
                <td align="right"><label class="formfont">Doc No</label></td>
                <td align="left">
                    <input type="text" name="rno" id="rno" value='<s:property value="rno"/>'>
                </td>

                <td align="right"><label class="formfont">Fleet No</label></td>
                <td align="left">
                    <input type="text" name="flno" id="flno" value='<s:property value="flno"/>'>
                </td>

                <td align="center" colspan="2">
                    <button type="button" name="mbtnrasearch" id="mbtnrasearch" class="myButton" onclick="mainloadSearch();">
                        Search
                    </button>
                </td>
            </tr>
        </table>
    </div>

    <!-- GRID -->
    <div class="grid-container">
        <div id="srefreshdiv">
            <jsp:include page="agreementDetailsSearchGrid.jsp"></jsp:include> 
        </div>
    </div>

</div>
</body>
</html>