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
$(document).ready(function () { 
    /* Force width to 100% so it perfectly fits the table cell */
    $("#datess").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy", value:null}); 
    
    /* Force internal alignment AFTER render */
    setTimeout(function () {
        $(".jqx-datetimeinput").css({"margin-top": "0px", "border-color": "#BDBDBD", "border-radius": "3px"});
        $(".jqx-datetimeinput").find("input").css({
            "margin-top": "0px", 
            "line-height": "24px", 
            "font-size": "12px", 
            "font-family": "'Segoe UI', 'Roboto', 'Arial', sans-serif",
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
    }, 100);
});            

function loadSearchs() {
    var docnoss = document.getElementById("docnoss").value || "";
    var accountss = document.getElementById("accountss").value || "";
    var accnamess = document.getElementById("accnamess").value || "";
    var datess = $('#datess').jqxDateTimeInput('val') || ""; 
    var aa = "yes";
    
    getdata(docnoss,accountss,accnamess,datess,aa);
}

function getdata(docnoss,accountss,accnamess,datess,aa){
    /* Upgraded to encodeURIComponent for safe parameter passing */
    $("#refreshdivs").load('Subsearch.jsp?docnoss=' + encodeURIComponent(docnoss) + 
                           '&accountss=' + encodeURIComponent(accountss) + 
                           '&accnamess=' + encodeURIComponent(accnamess) + 
                           '&datess=' + datess + 
                           '&aa=' + aa);
}
</script>

</head>
<body style="background-color: #fff; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="lbl-right" width="8%">Doc No</td>
                <td width="20%">
                    <input type="text" name="docnoss" id="docnoss" value='<s:property value="docnoss"/>'>
                </td>
                
                <td class="lbl-right" width="10%">Account</td>
                <td width="20%">
                    <input type="text" name="accountss" id="accountss" value='<s:property value="accountss"/>'>
                </td>
                
                <td class="lbl-right" width="12%">Account Name</td>
                <td width="30%">
                    <input type="text" name="accnamess" id="accnamess" value='<s:property value="accnamess"/>'>
                </td>
            </tr>
            
            <tr>
                <td class="lbl-right">Date</td>
                <td>
                    <div id="datess" name="datess" value='<s:property value="datess"/>'></div>
                </td>
                
                <td colspan="3"></td>
                
                <td align="right">
                    <input type="button" name="searchs" id="searchs" class="myButton" value="Search" onclick="loadSearchs()">
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="refreshdivs">
            <jsp:include page="Subsearch.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>