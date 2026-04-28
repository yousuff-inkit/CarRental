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
    $(document).ready(function () {
        /* Standardized Date Input size */
        $("#searchdate").jqxDateTimeInput({
            width : '100%',
            height : '24px',
            formatString : "dd.MM.yyyy",
            value:null
        });

        /* Force internal alignment for JQX Date Input */
        setTimeout(function () {
            $(".jqx-datetimeinput").css({"border-color": "#b8c6d8", "border-radius": "3px"});
            $(".jqx-datetimeinput").find("input").css({
                "line-height": "24px", "font-size": "12px", 
                "font-family": "'Segoe UI', 'Roboto', 'Arial', sans-serif", "padding": "0 6px"
            });
            $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
        }, 100);
    }); 

    function mainloadSearch() {
        var searchdate = $('#searchdate').jqxDateTimeInput('val') || "";
        var docno = document.getElementById("searchdocno").value || "";
        var name = document.getElementById("searchname").value || "";
        var acno = document.getElementById("searchacno").value || "";
        var mobile = document.getElementById("searchmobile").value || "";
        
        getdata(searchdate, docno, name, acno, mobile);
    }

    function getdata(searchdate, docno, name, acno, mobile){
        $("#srefreshdiv").load('clientSearch.jsp?searchdate=' + encodeURIComponent(searchdate) + 
                              '&docno=' + encodeURIComponent(docno) + 
                              '&name=' + encodeURIComponent(name) + 
                              '&acno=' + encodeURIComponent(acno) + 
                              '&mobile=' + encodeURIComponent(mobile) + '&id=1');
    }
</script>
</head>

<body style="background-color: #fff; margin: 0;">
<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <colgroup>
                <col width="8%" />  <col width="16%" /> <col width="8%" />  <col width="16%" /> <col width="8%" />  <col width="18%" /> <col width="8%" />  <col width="18%" /> </colgroup>
            
            <tr>
                <td class="lbl-right">Doc No</td>
                <td>
                    <input type="text" name="searchdocno" id="searchdocno" autocomplete="off">
                </td>
                
                <td class="lbl-right">Date</td>
                <td>
                    <div id="searchdate" name="searchdate"></div>
                </td>
                
                <td class="lbl-right">Mobile</td>
                <td>
                    <input type="text" name="searchmobile" id="searchmobile" autocomplete="off">
                </td>

                <td colspan="2"></td>
            </tr>
            
            <tr>
                <td class="lbl-right">Name</td>
                <td colspan="3">
                    <input type="text" name="searchname" id="searchname" autocomplete="off">
                </td>
                
                <td class="lbl-right">A/c No</td>
                <td>
                    <input type="text" name="searchacno" id="searchacno" autocomplete="off">
                </td>

                <td colspan="2" align="right">
                    <input type="button" name="btnSearchExt" id="btnSearchExt" class="myButton" value="Search" onClick="mainloadSearch();">
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="srefreshdiv">
            <jsp:include page="clientSearch.jsp" /> 
        </div>
    </div>

</div>
</body>
</html>