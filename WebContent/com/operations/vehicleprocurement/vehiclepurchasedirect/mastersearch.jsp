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
   SCOPED UI: Cash Receipts Style (Bulletproofed)
========================================================= */
body {
    margin: 0;
    background: #fff;
}

/* UI WRAPPER: Bulletproofed with ID to block legacy CSS leaks */
#search.modern-ui {
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    font-size: 12px !important;
    color: #333;
    padding: 10px;
}

#search.modern-ui .search-panel {
    background: #fff;
    border: 1px solid #c5d3e0;
    border-radius: 8px;
    padding: 15px 10px;
    margin-bottom: 12px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.04);
}

/* Table rules locked to exact font sizes */
#search.modern-ui table {
    border-collapse: separate;
    border-spacing: 4px 10px;
    width: 100%;
}

#search.modern-ui td {
    font-size: 12px !important;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    vertical-align: middle;
}

#search.modern-ui td[align="right"] {
    color: #444 !important;
    font-weight: 600 !important;
    padding-right: 5px;
}

/* Master Input Heights - Forced to 24px and standard font */
#search.modern-ui input[type="text"] {
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

#search.modern-ui input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
    box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.1);
}

/* Master Button Appearance */
#search.modern-ui .myButton {
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    font-weight: 700 !important;
    font-size: 12px !important;
    height: 26px !important;
    line-height: 24px !important;
    padding: 0 20px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff !important;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    transition: all 0.2s ease;
    box-shadow: 0 1px 2px rgba(59, 130, 246, 0.3);
    text-transform: uppercase;
}

#search.modern-ui .myButton:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%);
    transform: translateY(-1px);
}

#search.modern-ui .grid-container {
    background: #fff;
    border: 1px solid #c5d3e0;
    border-radius: 6px;
    overflow: hidden;
}
</style>

<script type="text/javascript">
$(document).ready(function () { 
    /* Initialize JQX to match 24px input height */
    $("#datess").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy", value:null}); 
    
    /* Sync JQX internal styling to match the new strict fonts */
    setTimeout(function () {
        $(".jqx-datetimeinput").css({"border-color": "#b8c6d8", "border-radius": "3px"});
        $(".jqx-datetimeinput input").css({
            "line-height": "24px", 
            "font-size": "12px", 
            "font-family": "'Segoe UI', 'Roboto', 'Arial', sans-serif",
            "font-weight": "normal"
        });
        $(".jqx-datetimeinput .jqx-action-button").css({"height": "24px"});
    }, 100);
});   
           
function loadSearchs() {
    var docnoss = document.getElementById("docnoss").value || "";
    var accountss = document.getElementById("accountss").value || "";
    var accnamesss = document.getElementById("accnamess").value || "";
    var datess = $('#datess').jqxDateTimeInput('val') || "";
    var aa = "yes";
    
    getdata(docnoss, accountss, accnamesss, datess, aa);
}

function getdata(docnoss, accountss, accnamess, datess, aa){
    /* Using encodeURIComponent for safest handling of spaces/chars in URLs */
    $("#refreshdivs").load('submasterSearch.jsp?docnoss=' + encodeURIComponent(docnoss) + 
                          '&accountss=' + encodeURIComponent(accountss) + 
                          '&accnamess=' + encodeURIComponent(accnamess) + 
                          '&datess=' + encodeURIComponent(datess) + 
                          '&aa=' + aa);
}
</script>
</head>

<body bgcolor="#FFFFFF">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%">
            <tr>
                <td width="6%" align="right">Date</td>
                <td width="14%">
                    <div id="datess" name="datess" value='<s:property value="datess"/>'></div>
                </td>

                <td width="21%" align="right">Doc No</td>
                <td width="32%">
                    <input type="text" name="docnoss" id="docnoss" value='<s:property value="docnoss"/>'>
                </td>

                <td width="27%" align="center" rowspan="2">
                    <input type="button" name="searchs" id="searchs" class="myButton" value="Search" onclick="loadSearchs()">
                </td>
            </tr>

            <tr>
                <td align="right">Account</td>
                <td>
                    <input type="text" name="accountss" id="accountss" value='<s:property value="accountss"/>'>
                </td>

                <td align="right">Account Name</td>
                <td>
                    <input type="text" name="accnamess" id="accnamess" value='<s:property value="accnamess"/>'>
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="refreshdivs">
            <jsp:include page="submasterSearch.jsp" />
        </div>
    </div>

</div>

</body>
</html>