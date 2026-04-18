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
    background-color: #fff; /* Main background white */
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
.modern-ui input[type="text"] {
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

.modern-ui input[type="text"]:focus {
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
}

/* Layout Utilities */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
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

/* Search Button - Modern Blue matched to Client Master */
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
}

.modern-ui .myButton:hover {
    background-color: #004494;
}

/* Grid Container */
.modern-ui .grid-container {
    border: 1px solid #BDBDBD;
    background: #fff;
}
</style>

<script type="text/javascript">
$(document).ready(function () {
    /* Formatted heights to 24px to match modern UI */
    $("#roledate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", value:null, theme: 'energyblue'});

    /* Force internal alignment AFTER render */
    setTimeout(function () {
        $("#roledate").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "12px", 
            "font-family": "Arial, sans-serif", 
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $("#roledate").find(".jqx-action-button").css({
            "top": "0px",
            "height": "24px"
        });
    }, 0);
}); 

function loadSearch() {
    var rolename = document.getElementById("txtuserrolename").value || "";
    var docNo    = document.getElementById("txtdocno").value || "";
    var date     = $('#roledate').jqxDateTimeInput('val') || "";
    getdata(rolename, docNo, date);
}

function getdata(rolename, docNo, date){
    $("#refreshdiv").load('ubiMainSearchGrid.jsp?rolename=' + encodeURIComponent(rolename) + 
                          '&docNo=' + encodeURIComponent(docNo) + 
                          '&date=' + date);
}
</script>
</head>

<body style="background-color: #fff; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">
        
        <div style="display: flex; gap: 15px; align-items: flex-start;">
            <div style="flex: 1;">
                <div class="field-row">
                    <label class="lbl-right" style="width: 80px;">Date</label>
                    <div style="width: 120px;">
                        <div id="roledate" name="roledate" value='<s:property value="roledate"/>'></div>
                        <input type="hidden" name="hidroledate" id="hidroledate" value='<s:property value="hidroledate"/>'>
                    </div>

                    <label class="lbl-right" style="width: 80px; margin-left: 20px;">Doc No</label>
                    <input type="text" name="txtdocno" id="txtdocno" value='<s:property value="txtdocno"/>' style="width: 150px;">
                </div>

                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width: 80px;">Name</label>
                    <input type="text" name="txtuserrolename" id="txtuserrolename" style="flex: 1;" value='<s:property value="txtuserrolename"/>'>
                </div>
            </div>

            <div style="display: flex; align-items: center; justify-content: center; padding: 10px;">
                <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch(); return false;">
            </div>
        </div>

    </div>

    <div class="grid-container">
        <div id="refreshdiv">
            <jsp:include page="ubiMainSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>