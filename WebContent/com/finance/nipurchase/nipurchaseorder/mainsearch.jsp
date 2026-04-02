<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<style>
/* =========================================================
SCOPED UI: Clean UI Panel Design for Search Modal
* All rules are prefixed with .modern-ui to prevent bleeding! *
========================================================= */

.modern-ui {
    font-family: Arial, sans-serif;
    color: #333;
    font-size: 12px;
    padding: 10px;
    background-color: #f4f6f9;
    height: 100%;
    box-sizing: border-box;
}

/* Master Input Heights - Set to 24px */
.modern-ui input[type="text"], 
.modern-ui select {
    height: 24px !important;
    border: 1px solid #ccc;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box;
    background-color: #fff;
    color: #333;
}

.modern-ui input[type="text"]:focus, 
.modern-ui select:focus {
    border-color: #007bff;
    outline: none;
}

/* Layout Utilities */
.modern-ui .field-row {
    display: flex;
    align-items: center;
    gap: 15px; /* Spacing between input groups */
    margin-bottom: 12px;
    flex-wrap: wrap;
}

.modern-ui .input-group {
    display: flex;
    align-items: center;
    gap: 8px; /* Spacing between label and input */
}

.modern-ui .lbl-right {
    text-align: right;
    color: #444;
    font-size: 12px;
    font-weight: bold;
    white-space: nowrap;
}

/* Panel Styling */
.modern-ui .modern-panel {
    border: 1px solid #e1e4e8;
    padding: 15px;
    background: #fff;
    border-radius: 4px;
    margin-bottom: 15px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.05);
}

/* Search Button */
.modern-ui .myButton {
    font-weight: bold;
    font-size: 12px;
    height: 24px !important;
    padding: 0px 16px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    box-shadow: 0 1px 2px rgba(59, 130, 246, 0.3);
    transition: all 0.2s ease;
}

.modern-ui .myButton:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%);
    transform: translateY(-1px);
}

/* Grid Container */
.modern-ui .grid-container {
    background: #fff;
    border: 1px solid #e1e4e8;
    padding: 2px;
    min-height: 200px;
}
</style>

<script type="text/javascript">
$(document).ready(function () { 
    /* Upgraded height to 24px for Modern UI */
    $("#datess").jqxDateTimeInput({ width: '125px', height: '24px', formatString:"dd.MM.yyyy", value:null}); 
    
    /* Force internal alignment AFTER render */
    setTimeout(function () {
        $(".jqx-datetimeinput").find("input").css({
            "margin-top": "0px", 
            "line-height": "24px", 
            "font-size": "12px", 
            "font-family": "Arial, sans-serif",
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
    }, 0);
});   
           
function loadSearchs() {
    var docnoss = document.getElementById("docnoss").value;
    var accountss = document.getElementById("accountss").value;
    var accnamesss = document.getElementById("accnamess").value;
    var datess = $('#datess').jqxDateTimeInput('val'); // Safely grabbing JQX value
    
    var accnamess = accnamesss.replace(/ /g, '%20'); // Handled globally via regex just in case
    var aa = "yes";
    
    getdata(docnoss,accountss,accnamess,datess,aa);
}

function getdata(docnoss,accountss,accnamess,datess,aa){
    $("#refreshdivs").load('Subsearch.jsp?docnoss='+docnoss+'&accountss='+accountss+'&accnamess='+accnamess+'&datess='+datess+'&aa='+aa);
}
</script>

</head>
<body>

<div id="search" class="modern-ui">

    <div class="modern-panel">
        
        <div class="field-row">
            <div class="input-group">
                <label class="lbl-right" style="width: 50px;">Doc No</label>
                <input type="text" name="docnoss" id="docnoss" style="width: 140px;" value='<s:property value="docnoss"/>'>
            </div>
            
            <div class="input-group">
                <label class="lbl-right" style="width: 60px;">Account</label>
                <input type="text" name="accountss" id="accountss" style="width: 140px;" value='<s:property value="accountss"/>'>
            </div>
            
            <div class="input-group" style="flex: 1;">
                <label class="lbl-right" style="width: 90px;">Account Name</label>
                <input type="text" name="accnamess" id="accnamess" style="width: 100%; max-width: 350px;" value='<s:property value="accnamess"/>'>
            </div>
        </div>

        <div class="field-row" style="margin-bottom: 0;">
            <div class="input-group">
                <label class="lbl-right" style="width: 50px;">Date</label>
                <div style="width: 125px;">
                    <div id="datess" name="datess" value='<s:property value="datess"/>'></div>
                </div>
            </div>

            <div style="margin-left: auto;">
                <input type="button" name="searchs" id="searchs" class="myButton" value="Search" onclick="loadSearchs()">
            </div>
        </div>

    </div>

    <div class="grid-container">
        <div id="refreshdivs">
            <jsp:include page="Subsearch.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>