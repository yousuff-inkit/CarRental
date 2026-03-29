<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<style>
/* =========================================================
   SCOPED UI: Perfectly Aligned Column Grid
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

.modern-ui .input-sm { width: 100px !important; }
.modern-ui .input-md { width: 140px !important; }
.modern-ui .input-full { width: 100% !important; flex: 1; }

.modern-ui input[type="text"]:focus, 
.modern-ui select:focus {
    border-color: #007bff;
    outline: none;
}

/* Layout Utilities for Strict Alignment */
.modern-ui .field-row {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 12px;
    width: 100%;
}

.modern-ui .lbl-right {
    text-align: right;
    color: #444;
    font-size: 12px;
    font-weight: bold;
    white-space: nowrap;
    width: 60px; /* Locks label widths for perfect vertical alignment */
}

/* Panel Styling */
.modern-ui .modern-panel {
    border: 1px solid #e1e4e8;
    padding: 20px 15px 15px 15px;
    background: #fff;
    border-radius: 4px;
    margin-bottom: 15px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.05);
}

/* Search Button */
.modern-ui .myButton {
    font-weight: bold;
    font-size: 12px;
    height: 28px !important;
    padding: 0px 20px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    box-shadow: 0 1px 2px rgba(59, 130, 246, 0.2);
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
    var sclname=document.getElementById("SCl_name").value;
    var smob=document.getElementById("Sl_mob").value;
    var rno=document.getElementById("rno").value;
    var flno=document.getElementById("flno").value;
    var sregno=document.getElementById("sregno").value;
    
    // Note: cmbratype and txtcldocno are likely in the parent window calling this popup
    var rentaltype = document.getElementById("cmbratype") ? document.getElementById("cmbratype").value : "";
    var clientId = document.getElementById("txtcldocno") ? document.getElementById("txtcldocno").value : "";

    getdata(sclname,smob,rno,flno,sregno,rentaltype,clientId);
}

function getdata(sclname,smob,rno,flno,sregno,rentaltype,clientId){
    $("#srefreshdiv").load('agreementDetailsSearchGrid.jsp?sclname='+sclname.replace(/ /g, "%20")+'&smob='+smob+'&rno='+rno+'&flno='+flno+'&sregno='+sregno+'&rentaltype='+rentaltype+'&clientId='+clientId);
}
</script>

<div id="search" class="modern-ui">

    <div class="modern-panel">
        
        <div class="field-row">
            <label class="lbl-right">Name</label>
            <input type="text" name="SCl_name" id="SCl_name" class="input-full" style="max-width: 400px;" autocomplete="off" value='<s:property value="SCl_name"/>'>

            <label class="lbl-right" style="width: 40px;">Mob</label>
            <input type="text" name="Sl_mob" id="Sl_mob" class="input-md" autocomplete="off" value='<s:property value="Sl_mob"/>'>

            <label class="lbl-right">Reg No</label>
            <input type="text" id="sregno" name="sregno" class="input-md" autocomplete="off" value='<s:property value="sregno"/>'>
        </div>

        <div class="field-row" style="margin-bottom: 0;">
            <label class="lbl-right">Doc No</label>
            <input type="text" name="rno" id="rno" class="input-md" autocomplete="off" value='<s:property value="rno"/>'>
            
            <label class="lbl-right" style="width: 55px;">Fleet No</label>
            <input type="text" name="flno" id="flno" class="input-md" autocomplete="off" value='<s:property value="flno"/>'>

            <div style="margin-left: auto;">
                <input type="button" name="mbtnrasearch" id="mbtnrasearch" class="myButton" value="Search" onclick="mainloadSearch();">
            </div>
        </div>

    </div>

    <div class="grid-container">
        <div id="srefreshdiv">
            <jsp:include page="agreementDetailsSearchGrid.jsp" />
        </div>
    </div>

</div>