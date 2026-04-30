<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

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
$(document).ready(function(e) {
    // Standardized height to 24px and width to 100%
    $("#detaildate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy", value:null});
});

function funSearchDetail(){
    <%
    String reftype=request.getParameter("reftype")==null?"":request.getParameter("reftype").toString();
    String branch=request.getParameter("branch")==null?"":request.getParameter("branch").toString();
    %>
    var reftype='<%=reftype%>';
    var branch='<%=branch%>';
    var docno=document.getElementById("detaildocno").value;
    var fleetno=document.getElementById("detailfleetno").value;
    var regno=document.getElementById("detailregno").value;
    var date=$('#detaildate').jqxDateTimeInput('val');
    
    $('#docdiv').load('docSearch.jsp?reftype='+reftype+'&branch='+branch+'&docno='+docno+'&fleetno='+fleetno+'&regno='+regno+'&date='+date+'&mode=1');
}
</script>
</head>

<body bgcolor="#f5f7fa">
<div id="search" class="modern-ui">

    <!-- SEARCH FORM -->
    <div class="search-panel">
        <table width="100%">
            <colgroup>
                <col width="10%"> <col width="23%">
                <col width="10%"> <col width="23%">
                <col width="10%"> <col width="24%">
            </colgroup>

            <!-- Row 1 -->
            <tr>
                <td align="right"><label class="formfont">Date</label></td>
                <td align="left">
                    <div id="detaildate"></div>
                </td>

                <td align="right"><label class="formfont">Ref Doc No</label></td>
                <td align="left">
                    <input type="text" name="detaildocno" id="detaildocno">
                </td>

                <td align="right"><label class="formfont">Fleet No</label></td>
                <td align="left">
                    <input type="text" name="detailfleetno" id="detailfleetno">
                </td>
            </tr>

            <!-- Row 2 -->
            <tr>
                <td align="right"><label class="formfont">Reg No</label></td>
                <td align="left">
                    <input type="text" name="detailregno" id="detailregno">
                </td>

                <td colspan="4" align="right">
                    <button type="button" id="btndetail" class="myButton" onclick="funSearchDetail();" style="width: 120px; float: right;">
                        Search
                    </button>
                </td>
            </tr>
        </table>
    </div>

    <!-- GRID -->
    <div class="grid-container">
        <div id="docdiv">
            <jsp:include page="docSearch.jsp"></jsp:include>
        </div>
    </div>

</div>
</body>
