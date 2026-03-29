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
.modern-ui .input-sm { width: 100px !important; }
.modern-ui .input-md { width: 140px !important; }
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

/* Checkbox Label Styling */
.modern-ui .chk-container {
    display: flex;
    align-items: center;
    gap: 4px;
    cursor: pointer;
    color: #444;
    font-size: 12px;
    font-weight: bold;
    margin: 0;
}

.modern-ui .chk-container input {
    margin: 0;
    padding: 0;
}

/* Panel Styling (Title removed for cleaner popup) */
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
    font-size: 11px;
    height: 24px !important;
    padding: 0px 16px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
}

.modern-ui .myButton:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%);
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
    // Initialization if needed
}); 

function mainloadSearch() {
    var sclnames=document.getElementById("SCl_name").value;
    var smob=document.getElementById("Sl_mob").value;
    var rno=document.getElementById("rno").value;
    var flno=document.getElementById("flno").value;
    var sregno=document.getElementById("sregno").value;
    var lponumber=document.getElementById("lponumber").value;
    var sclname = sclnames.replace(/ /g, "%20");
    
    var bchk=0;
    if(document.getElementById("branch_chk").checked){  
        bchk=1;
    }
    
    // Note: brchName is likely in the parent window calling this popup
    var brhid=$('#brchName').val() || "";
    
    $("#srefreshdiv").load('submainSearch.jsp?sclname='+sclname+'&smob='+smob+'&rno='+rno+'&flno='+flno+'&sregno='+sregno+'&lponumber='+lponumber+'&branch_chk='+bchk+'&brhid='+brhid+'&check=1');
}
</script>
</head>

<body>
<div id="search" class="modern-ui">

    <div class="modern-panel">
        
        <div class="field-row">
            <label class="lbl-right" style="width: 50px;">Name</label>
            <input type="text" name="SCl_name" id="SCl_name" class="input-full" style="max-width: 400px;" value='<s:property value="SCl_name"/>'>

            <label class="lbl-right" style="width: 40px;">MOB</label>
            <input type="text" name="Sl_mob" id="Sl_mob" class="input-md" value='<s:property value="Sl_mob"/>'>

            <label class="chk-container" style="margin-left: 15px;">
                <input type="checkbox" id="branch_chk" name="branch_chk" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                All Branch
            </label>

            <div style="margin-left: auto; padding-right: 5px;">
                <input type="button" name="mbtnrasearch" id="mbtnrasearch" class="myButton" value="Search" onclick="mainloadSearch();">
            </div>
        </div>

        <div class="field-row" style="margin-bottom: 0;">
            <label class="lbl-right" style="width: 50px;">Doc NO</label>
            <input type="text" name="rno" id="rno" class="input-md" value='<s:property value="rno"/>'>

            <label class="lbl-right" style="width: 55px;">Fleet NO</label>
            <input type="text" name="flno" id="flno" class="input-full" value='<s:property value="flno"/>'>

            <label class="lbl-right" style="width: 50px;">Reg NO</label>
            <input type="text" id="sregno" name="sregno" class="input-sm" value='<s:property value="sregno"/>'>

            <label class="lbl-right" style="width: 40px;">LPO#</label>
            <input type="text" name="lponumber" id="lponumber" class="input-sm" value='<s:property value="lponumber"/>'>
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