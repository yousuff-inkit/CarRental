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

/* Compact Width Classes */
.modern-ui .input-xs { width: 60px !important; }
.modern-ui .input-sm { width: 100px !important; }
.modern-ui .input-md { width: 140px !important; }
.modern-ui .input-lg { width: 200px !important; }
.modern-ui .input-full { width: 100% !important; flex: 1; }

.modern-ui input[type="text"]:focus, 
.modern-ui select:focus {
    border-color: #007bff;
    outline: none;
}

/* Layout Utilities */
.modern-ui .field-row {
    display: flex;
    align-items: center;
    gap: 8px;
    margin-bottom: 12px;
    flex-wrap: wrap;
}

.modern-ui .lbl-right {
    text-align: right;
    color: #444;
    font-size: 12px;
    font-weight: bold;
    white-space: nowrap;
    padding-right: 5px;
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
    $("#agmtsearchdate").jqxDateTimeInput({ width: '125px', height: '24px',formatString:"dd.MM.yyyy",value:null});
    
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

function loadagmtSearch() {
    var docnosearch1=document.getElementById("agmtdocnosearch").value;
    var fleetsearch=document.getElementById("agmtfleetsearch").value;
    var regnosearch=document.getElementById("agmtregnosearch").value;
    var clientsearch=document.getElementById("agmtclientsearch").value;
    var searchdate=$('#agmtsearchdate').jqxDateTimeInput('val');
    var agmttype=document.getElementById("cmbagmttype").value;
    var license=document.getElementById("agmtlicensesearch").value;
    var mobilesearch=document.getElementById("agmtmobilesearch").value;
    
    $('#brchName').prop('disabled',false);
    var branch=$('#brchName').val();
    $('#brchName').prop('disabled',true);
    
    getdata(docnosearch1,fleetsearch,regnosearch,clientsearch,searchdate,mobilesearch,agmttype,license,branch);
}

function getdata(docnosearch,fleetsearch,regnosearch,clientsearch,searchdate,mobilesearch,agmttype,license,branch){
    $("#agmtloadAgmtSearch").load("gridAgmtSearch.jsp?agmttype="+agmttype+"&docno="+docnosearch+"&fleet="+fleetsearch+"&regno="+regnosearch+"&client="+clientsearch+"&date="+searchdate+"&mobile="+mobilesearch+"&license="+license+'&branch='+branch);
}
</script>
</head>
<body>

<div id="search" class="modern-ui">

    <div class="modern-panel">
        
        <div class="field-row">
            <label class="lbl-right" style="width: 50px;">Doc No</label>
            <input type="text" name="agmtdocnosearch" id="agmtdocnosearch" class="input-sm" value='<s:property value="agmtdocnosearch"/>'>

            <label class="lbl-right" style="width: 40px;">Fleet</label>
            <input type="text" name="agmtfleetsearch" id="agmtfleetsearch" class="input-sm" value='<s:property value="agmtfleetsearch"/>'>

            <label class="lbl-right" style="width: 50px;">Reg No</label>
            <input type="text" name="agmtregnosearch" id="agmtregnosearch" class="input-sm" value='<s:property value="agmtregnosearch"/>'>

            <label class="lbl-right" style="width: 70px;">License No</label>
            <input type="text" name="agmtlicensesearch" id="agmtlicensesearch" class="input-md" value='<s:property value="agmtlicensesearch"/>'>
        </div>

        <div class="field-row" style="margin-bottom: 0;">
            <label class="lbl-right" style="width: 50px;">Client</label>
            <input type="text" name="agmtclientsearch" id="agmtclientsearch" class="input-md" value='<s:property value="agmtclientsearch"/>'>

            <label class="lbl-right" style="width: 40px;">Date</label>
            <div style="width: 125px;">
                <div id="agmtsearchdate" name="agmtsearchdate" value='<s:property value="agmtsearchdate"/>'></div>
                <input type="hidden" name="hidagmtsearchdate" id="hidagmtsearchdate" value='<s:property value="hidagmtsearchdate"/>'>
            </div>

            <label class="lbl-right" style="width: 50px;">Mobile</label>
            <input type="text" name="agmtmobilesearch" id="agmtmobilesearch" class="input-md" value='<s:property value="agmtmobilesearch"/>'>

            <div style="margin-left: auto;">
                <input type="button" name="btnagmtrasearch" id="btnagmtrasearch" class="myButton" value="Search" onclick="loadagmtSearch();">
            </div>
        </div>

    </div>

    <div class="grid-container">
        <div id="agmtloadAgmtSearch">
            <jsp:include page="gridAgmtSearch.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>