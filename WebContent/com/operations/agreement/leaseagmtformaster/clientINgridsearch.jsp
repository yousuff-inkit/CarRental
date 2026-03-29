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
    /* Upgraded to 24px height to match Master UI standard */
    $("#dr_DOB").jqxDateTimeInput({ width: '120px', height: '24px', formatString:"dd.MM.yyyy", value:null});

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

function loadSearch() {
    var clientnamess=document.getElementById("Cl_name").value;
    var mob=document.getElementById("Cl_mob").value;
    var lcno=document.getElementById("dr_Licence").value;
    var passno=document.getElementById("dr_Passport").value;
    var nation=document.getElementById("dr_Nation").value;
    var dob=$('#dr_DOB').jqxDateTimeInput('val'); // FIXED: Safely grab JQX date value
    
    // Note: masterrefnocldocno is likely in the parent window calling this popup
    var masterrefnocldocno=$('#masterrefnocldocno').val() || "";
    var clname = clientnamess.replace(/ /g, "%20");

    getdata(clname,mob,lcno,passno,nation,dob,masterrefnocldocno);
}

function getdata(clname,mob,lcno,passno,nation,dob,masterrefnocldocno){
    $("#refreshdiv").load('clientinfo.jsp?clname='+clname+'&mob='+mob+'&lcno='+lcno+'&passno='+passno+'&nation='+nation+'&dob='+dob+'&masterrefnocldocno='+masterrefnocldocno+'&id='+1);
}
</script>

<div id="search" class="modern-ui">

    <div class="modern-panel">
        
        <div class="field-row">
            <label class="lbl-right" style="width: 70px;">Name</label>
            <input type="text" name="Cl_name" id="Cl_name" class="input-full" style="max-width: 400px;" value='<s:property value="Cl_name"/>'>

            <label class="lbl-right" style="width: 50px;">MOB</label>
            <input type="text" name="Cl_mob" id="Cl_mob" class="input-md" value='<s:property value="Cl_mob"/>'>

            <div style="margin-left: auto; padding-right: 5px;">
                <input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search" onclick="loadSearch();">
            </div>
        </div>

        <div class="field-row" style="margin-bottom: 0;">
            <label class="lbl-right" style="width: 70px;">Licence#</label>
            <input type="text" name="dr_Licence" id="dr_Licence" class="input-md" value='<s:property value="dr_Licence"/>'>

            <label class="lbl-right" style="width: 70px;">Passport#</label>
            <input type="text" name="dr_Passport" id="dr_Passport" class="input-md" value='<s:property value="dr_Passport"/>'>

            <label class="lbl-right" style="width: 70px;">Nationality</label>
            <input type="text" id="dr_Nation" name="dr_Nation" class="input-sm" value='<s:property value="dr_Nation"/>'>

            <label class="lbl-right" style="width: 40px;">DOB</label>
            <div style="width: 120px;">
                <div id="dr_DOB" name="dr_DOB" value='<s:property value="dr_DOB"/>'></div>
            </div>
            <input type="hidden" name="hiddr_DOB" id="hiddr_DOB" value='<s:property value="hiddr_DOB"/>'>
        </div>

    </div>

    <div class="grid-container">
        <div id="refreshdiv">
            <jsp:include page="clientinfo.jsp"></jsp:include> 
        </div>
    </div>

</div>