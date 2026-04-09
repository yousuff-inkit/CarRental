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

/* Checkbox specific fix */
.modern-ui input[type="checkbox"] {
    margin: 0;
    padding: 0;
    vertical-align: middle;
}

/* Compact Width Classes */
.modern-ui .input-xs { width: 60px !important; }
.modern-ui .input-sm { width: 100px !important; }
.modern-ui .input-md { width: 140px !important; }
.modern-ui .input-lg { width: 200px !important; }
.modern-ui .input-xl { width: 300px !important; }
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
    $("#searchdate").jqxDateTimeInput({ width: '125px', height: '24px',formatString:"dd.MM.yyyy",value:null});
    
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

function mainloadSearch() {
    var sclname=document.getElementById("SCl_name").value;
    var smob=document.getElementById("Sl_mob").value;
    var rno=document.getElementById("rno").value;
    var flno=document.getElementById("flno").value;
    var sregno=document.getElementById("sregno").value;
    var searchdate=$('#searchdate').jqxDateTimeInput('val');
    
    // Safety check in case brchName doesn't exist on this popup
    var branch = "";
    if(document.getElementById("brchName")){
        branch=document.getElementById("brchName").value;
    }
    
    var allbranch = "";
    if(document.getElementById("branch_chk")){
        allbranch=document.getElementById("branch_chk").value;
    }
    
    getdata(sclname,smob,rno,flno,sregno,searchdate,branch,allbranch);
}

function getdata(sclname,smob,rno,flno,sregno,searchdate,branch,allbranch){
    $("#srefreshdiv").load('submainSearch.jsp?sclname='+sclname+'&smob='+smob+'&rno='+rno+'&flno='+flno+'&sregno='+sregno+'&searchdate='+searchdate+'&branch='+branch+'&allbranch='+allbranch);
}
</script>
</head>
<body>

<div id="search" class="modern-ui">

    <div class="modern-panel">
        
        <div class="field-row">
            <label class="lbl-right" style="width: 60px;">Name</label>
            <input type="text" name="SCl_name" id="SCl_name" class="input-lg" style="flex: 1; max-width: 350px;" value='<s:property value="SCl_name"/>'>

            <label class="lbl-right" style="width: 40px; margin-left: 10px;">MOB</label>
            <input type="text" name="Sl_mob" id="Sl_mob" class="input-md" value='<s:property value="Sl_mob"/>'>

            <label class="lbl-right" style="width: 40px; margin-left: 10px;">Date</label>
            <div style="width: 125px;">
                <div id="searchdate" name="searchdate"></div>
            </div>
        </div>

        <div class="field-row" style="margin-bottom: 0;">
            <label class="lbl-right" style="width: 60px;">Agmt NO</label>
            <input type="text" name="rno" id="rno" class="input-md" value='<s:property value="rno"/>'>

            <label class="lbl-right" style="width: 60px; margin-left: 10px;">Fleet NO</label>
            <input type="text" name="flno" id="flno" class="input-md" value='<s:property value="flno"/>'>

            <label class="lbl-right" style="width: 50px; margin-left: 10px;">Reg NO</label>
            <input type="text" id="sregno" name="sregno" class="input-md" value='<s:property value="sregno"/>'>

            <div style="margin-left: auto; display: flex; align-items: center; gap: 15px;">
                <div style="display: flex; align-items: center; gap: 5px;">
                    <input type="checkbox" id="branch_chk" name="branch_chk" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)">   
                    <label for="branch_chk" style="margin: 0; font-size: 12px; font-weight: bold; color: #444; cursor: pointer;">All Branch</label>
                </div>
                
                <input type="button" name="mbtnrasearch" id="mbtnrasearch" class="myButton" value="Search" onclick="mainloadSearch();">
            </div>
        </div>

    </div>

    <div class="grid-container">
        <div id="srefreshdiv">
            <jsp:include page="submainSearch.jsp"></jsp:include> 
        </div>
    </div>

</div>

</body>
</html>