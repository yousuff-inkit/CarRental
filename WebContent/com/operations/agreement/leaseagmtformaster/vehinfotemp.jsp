<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

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
    // Any initialization logic can go here
}); 

function loadSearchss() {
    var fleetno=document.getElementById("fleetno1").value;
    var regno=document.getElementById("regno1").value;
    var flnames=document.getElementById("flname1").value;
    var color=document.getElementById("color1").value;
    var group=document.getElementById("group1").value;
    
    // Safety check for parent element
    if($('#hidmasterrefno').length > 0) {
        $('#hidmasterrefno').attr('disabled',false);
    }
    
    var masterrefno=$('#hidmasterrefno').val() || "";
    var flname = flnames.replace(/ /g, "%20");
    var aa="yes";
    
    getdata(fleetno,regno,flname,color,group,aa,masterrefno);
}

function getdata(fleetno,regno,flname,color,group,aa,masterrefno){
    $("#refreshdivss").load('subtempfleetsearch.jsp?fleetno='+fleetno+'&regno='+regno+'&flname='+flname+'&color='+color+'&group='+group+'&aa='+aa+'&masterrefno='+masterrefno);
}
</script>

<div id="search" class="modern-ui">

    <div class="modern-panel">
        
        <div class="field-row">
            <label class="lbl-right" style="width: 50px;">Fleet</label>
            <input type="text" name="fleetno1" id="fleetno1" class="input-md" value='<s:property value="fleetno1"/>'>

            <label class="lbl-right" style="width: 60px;">Reg No</label>
            <input type="text" name="regno1" id="regno1" class="input-md" value='<s:property value="regno1"/>'>

            <label class="lbl-right" style="width: 50px;">Name</label>
            <input type="text" name="flname1" id="flname1" class="input-full" style="max-width: 300px;" value='<s:property value="flname1"/>'>
        </div>

        <div class="field-row" style="margin-bottom: 0;">
            <label class="lbl-right" style="width: 50px;">Color</label>
            <input type="text" name="color1" id="color1" class="input-md" value='<s:property value="color1"/>'>

            <label class="lbl-right" style="width: 60px;">Group</label>
            <input type="text" name="group1" id="group1" class="input-md" value='<s:property value="group1"/>'>

            <div style="margin-left: auto; padding-right: 5px;">
                <input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search" onclick="loadSearchss();">
            </div>
        </div>

    </div>

    <div class="grid-container">
        <div id="refreshdivss">
            <jsp:include page="subtempfleetsearch.jsp"></jsp:include> 
        </div>
    </div>

</div>