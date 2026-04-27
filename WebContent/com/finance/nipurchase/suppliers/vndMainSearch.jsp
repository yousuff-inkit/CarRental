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
   SCOPED UI: Segoe UI Font & Clean White Search Panel
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
}

/* Master Input Styles */
.modern-ui input[type="text"],
.modern-ui select {
    height: 24px !important;
    border: 1px solid #BDBDBD;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 12px; 
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
    background-color: #FFD6FF; /* Client master focus color */
}

/* Panel Styling - Clean White Panel */
.modern-ui .search-panel {
    background-color: #fff !important; 
    border: 1px solid #BDBDBD;
    border-radius: 4px;
    padding: 12px;
    margin-bottom: 10px;
    width: 100%;
    box-sizing: border-box;
}

/* Table Alignment - Strict Grid Mapping */
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
    color: #222;
    font-size: 12px; 
    font-weight: 600;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Search Button - Standard Blue */
.modern-ui .myButton {
    height: 26px;
    padding: 0 20px;
    background-color: #0056b3;
    color: #ffffff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 12px;
    font-weight: bold;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    transition: all 0.2s;
}

.modern-ui .myButton:hover {
    background-color: #004494;
}

/* Grid Container */
.modern-ui .grid-container {
    border: 1px solid #BDBDBD;
    background: #fff;
    overflow: hidden;
    width: 100%;
}
</style>

<script type="text/javascript">
$(document).ready(function () {}); 

function loadSearch() {
    var vndname=document.getElementById("txtvendorsname").value || "";
    var vndaccno=document.getElementById("txtaccountno").value || "";
    var vndmob=document.getElementById("txtmobile").value || "";
    var vndtel=document.getElementById("txttelephone").value || "";

    getdata(vndname,vndaccno,vndmob,vndtel);
}

function getdata(vndname,vndaccno,vndmob,vndtel){
    /* Upgraded to encodeURIComponent for safe parameter passing */
    $("#refreshdiv").load('vndMainSearchGrid.jsp?vndname=' + encodeURIComponent(vndname) + 
                          '&vndaccno=' + encodeURIComponent(vndaccno) + 
                          '&vndmob=' + encodeURIComponent(vndmob) + 
                          '&vndtel=' + encodeURIComponent(vndtel));
}
</script>

</head>
<body style="background-color: #fff; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="lbl-right" width="8%">Name</td>
                <td width="35%">
                    <input type="text" name="txtvendorsname" id="txtvendorsname" autocomplete="off" value='<s:property value="txtvendorsname"/>'>
                </td>
                
                <td class="lbl-right" width="10%">A/C No.</td>
                <td width="22%">
                    <input type="text" name="txtaccountno" id="txtaccountno" autocomplete="off" value='<s:property value="txtaccountno"/>'>
                </td>
                
                <td width="25%" align="center" rowspan="2" valign="middle">
                    <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch(); return false;">
                </td>
            </tr>
            
            <tr>
                <td class="lbl-right">Mob No.</td>
                <td>
                    <input type="text" name="txtmobile" id="txtmobile" autocomplete="off" value='<s:property value="txtmobile"/>'>
                </td>
                
                <td class="lbl-right">Tel No.</td>
                <td>
                    <input type="text" name="txttelephone" id="txttelephone" autocomplete="off" value='<s:property value="txttelephone"/>'>
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="refreshdiv">
            <jsp:include page="vndMainSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>