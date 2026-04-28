<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>

<style type="text/css">
/* =========================================================
   SCOPED UI: Cash Receipts Style (Safe Overlay)
========================================================= */
body {
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    margin: 0;
    background: #f5f7fa;
}

/* UI WRAPPER: Protects outer elements from layout changes */
.modern-ui {
    font-size: 12px;
    color: #333;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    padding: 10px;
}

.modern-ui .search-panel {
    background: #fff;
    border: 1px solid #c5d3e0;
    border-radius: 8px;
    padding: 15px 10px;
    margin-bottom: 12px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.04);
}

/* Exact Original Table Layout Kept Intact */
.modern-ui table {
    border-collapse: separate;
    border-spacing: 4px 10px;
    width: 100%;
}

.modern-ui td {
    font-size: 12px;
    vertical-align: middle;
}

.modern-ui td[align="right"] {
    color: #444;
    padding-right: 5px;
}

.modern-ui td[align="right"] b {
    font-weight: 600; /* Modernizes the bold tags you already have */
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"] {
    height: 24px !important;
    font-size: 12px;
    border: 1px solid #b8c6d8;
    border-radius: 3px;
    padding: 2px 6px;
    box-sizing: border-box;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    transition: border-color 0.2s;
    background-color: #ffffff;
}

.modern-ui input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
    box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.1);
}

/* Master Button Appearance */
.modern-ui .myButton {
    font-weight: 700;
    font-size: 12px;
    height: 26px !important;
    line-height: 24px !important;
    padding: 0 20px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    transition: all 0.2s ease;
    box-shadow: 0 1px 2px rgba(59, 130, 246, 0.3);
    text-transform: uppercase;
}

.modern-ui .myButton:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%);
    transform: translateY(-1px);
}

.modern-ui .grid-container {
    background: #fff;
    border: 1px solid #c5d3e0;
    border-radius: 6px;
    overflow: hidden;
}
</style>

<script type="text/javascript">
$(document).ready(function () {
    /* Initialize JQX to match 24px input height */
    $("#searchdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy", value:null});
    
    /* Sync JQX internal styling */
    setTimeout(function () {
        $(".jqx-datetimeinput").css({"border-color": "#b8c6d8", "border-radius": "3px"});
        $(".jqx-datetimeinput input").css({"line-height": "24px", "font-size": "12px", "font-family": "'Segoe UI', 'Roboto', 'Arial', sans-serif"});
        $(".jqx-datetimeinput .jqx-action-button").css({"height": "24px"});
    }, 100);
}); 

function mainloadSearch() {
    var fleetno = document.getElementById("searchfleet").value;
    var docno = document.getElementById("searchdocno").value;
    var regno = document.getElementById("searchregno").value;
    var fleetname = document.getElementById("searchfleetname").value;
    var searchdate = $('#searchdate').jqxDateTimeInput('val');
    var engine = document.getElementById("searchengine").value;
    var chassis = document.getElementById("searchchassis").value;
    getdata(fleetno, docno, regno, fleetname, searchdate, engine, chassis);
}

function getdata(fleetno, docno, regno, fleetname, searchdate, engine, chassis){
    $("#srefreshdiv").load('subMainSearch.jsp?fleetno='+fleetno+'&docno='+docno+'&regno='+regno+'&fleetname='+fleetname+'&searchdate='+searchdate+'&id=1&engine='+engine+'&chassis='+chassis);
}
</script>
</head>

<body bgcolor="#FFFFFF">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%">
            <tr>
                <td width="8%" align="right"><b>Fleet No</b></td>
                <td width="17%">
                    <input type="text" name="searchfleet" id="searchfleet" value='<s:property value="searchfleet"/>' style="width:95%;">
                </td>

                <td width="10%" align="right"><b>Fleet Name</b></td>
                <td width="25%">
                    <input type="text" name="searchfleetname" id="searchfleetname" value='<s:property value="searchfleetname"/>' style="width:98%;">
                </td>

                <td width="10%" align="right"><b>Engine No</b></td>
                <td width="15%">
                    <input type="text" name="searchengine" id="searchengine" value='<s:property value="searchengine"/>' style="width:95%;">
                </td>

                <td width="10%" align="right"><b>Chassis No</b></td>
                <td width="15%">
                    <input type="text" name="searchchassis" id="searchchassis" value='<s:property value="searchchassis"/>' style="width:95%;">
                </td>
            </tr>

            <tr>
                <td align="right"><b>Doc No</b></td>
                <td>
                    <input type="text" name="searchdocno" id="searchdocno" value='<s:property value="searchdocno"/>' style="width:95%;">
                </td>

                <td align="right"><b>Date</b></td>
                <td style="padding-right: 2%;">
                    <div id="searchdate" name="searchdate"></div>
                </td>

                <td align="right"><b>Reg No</b></td>
                <td>
                    <input type="text" name="searchregno" id="searchregno" style="width:95%;">
                </td>

                <td colspan="2" align="center">
                    <input type="button" name="btninvsearch" id="btninvsearch" class="myButton" value="Search" onclick="mainloadSearch();">
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="srefreshdiv">
            <jsp:include page="subMainSearch.jsp" />
        </div>
    </div>

</div>

</body>
</html>