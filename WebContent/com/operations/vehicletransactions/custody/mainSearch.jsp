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
    /* Upgraded to 24px height to match Master UI standard */
    $("#searchdate").jqxDateTimeInput({ width: '110px', height: '24px', formatString:"dd.MM.yyyy", value:null});

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
    var sclnames=document.getElementById("searchclient").value;
    var reftype=document.getElementById("cmbsearchrtype").value;
    var searchdate=$('#searchdate').jqxDateTimeInput('val');
    var agmtno=document.getElementById("searchagmtno").value;
    var fleetno=document.getElementById("searchfleetno").value;
    var docno=document.getElementById("searchdocno").value;

    var client = sclnames.replace(/ /g, "%20");
    getdata(client,reftype,searchdate,agmtno,fleetno,docno);
}

function getdata(client,reftype,searchdate,agmtno,fleetno,docno){
    $("#srefreshdiv").load('subMainSearch.jsp?client='+client+'&reftype='+reftype+'&searchdate='+searchdate+'&agmtno='+agmtno+'&fleetno='+fleetno+'&docno='+docno);
}
</script>

<div id="search" class="modern-ui">

    <div class="modern-panel">
        
        <div class="field-row">
            <label class="lbl-right" style="width: 50px;">Name</label>
            <input type="text" name="searchclient" id="searchclient" class="input-full" value='<s:property value="searchclient"/>'>

            <label class="lbl-right" style="width: 40px;">Type</label>
            <select name="cmbsearchrtype" id="cmbsearchrtype" class="input-md">
                <option value="">--Select--</option>
                <option value="RAG">Rental</option>
                <option value="LAG">Lease</option>
            </select>

            <label class="lbl-right" style="width: 40px;">Date</label>
            <div style="width: 110px;">
                <div id="searchdate" name="searchdate" value='<s:property value="searchdate"/>'></div>
            </div>
        </div>

        <div class="field-row" style="margin-bottom: 0;">
            <label class="lbl-right" style="width: 50px;">Agmt No</label>
            <input type="text" name="searchagmtno" id="searchagmtno" class="input-md" value='<s:property value="searchagmtno"/>'>

            <label class="lbl-right" style="width: 50px;">Fleet No</label>
            <input type="text" name="searchfleetno" id="searchfleetno" class="input-md" value='<s:property value="searchfleetno"/>'>

            <label class="lbl-right" style="width: 50px;">Doc No</label>
            <input type="text" name="searchdocno" id="searchdocno" class="input-md" value='<s:property value="searchdocno"/>'>

            <div style="margin-left: auto; padding-right: 5px;">
                <input type="button" name="mbtnrasearch" id="mbtnrasearch" class="myButton" value="Search" onclick="mainloadSearch();">
            </div>
        </div>

    </div>

    <div class="grid-container">
        <div id="srefreshdiv">
            <jsp:include page="subMainSearch.jsp" />
        </div>
    </div>

</div>