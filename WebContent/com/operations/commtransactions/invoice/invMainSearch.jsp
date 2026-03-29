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
}

.modern-ui .lbl-right {
    text-align: right;
    color: #444;
    font-size: 12px;
    font-weight: bold;
    white-space: nowrap;
    width: 65px; /* Locks label widths for perfect vertical alignment */
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
    /* Upgraded to 24px height to match Master UI standard */
    $("#searchdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy", value:null});
    
    funChangeDeletedInv();

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

function funChangeDeletedInv(){
    if(document.getElementById("chkdeletedinv").checked==true){
        document.getElementById("hidchkdeletedinv").value="1";
    }
    else{
        document.getElementById("hidchkdeletedinv").value="0";
    }
}

function mainloadSearch() {
    if(document.getElementById("searchagmtno").value!=""){
        if(document.getElementById("searchcmbagmttype").value==""){
            document.getElementById("errormsg").innerText="";
            document.getElementById("errormsg").innerText="Agreement Type is Mandatory";
            return false;
        }
    }
    document.getElementById("errormsg").innerText="";
    
    var client=document.getElementById("searchclient").value;
    var cmbagmttype=document.getElementById("searchcmbagmttype").value;
    var agmtno=document.getElementById("searchagmtno").value;
    var docno=document.getElementById("searchdocno").value;
    var searchdate=$('#searchdate').jqxDateTimeInput('val');
    
    // Note: brchName is likely in the parent window calling this popup
    if(document.getElementById("brchName")) {
        document.getElementById("brchName").disabled=false;
    }
    var searchbranch=$('#brchName').val() || "";
    
    var chkdeletedinv=$('#hidchkdeletedinv').val();
    
    getdata(client,cmbagmttype,agmtno,docno,searchdate,searchbranch,chkdeletedinv);
}

function getdata(client,cmbagmttype,agmtno,docno,searchdate,searchbranch,chkdeletedinv){
    $("#srefreshdiv").load('subMainSearch.jsp?client='+client+'&cmbagmttype='+cmbagmttype+'&agmtno='+agmtno+'&docno='+docno+'&searchdate='+searchdate+'&branch='+searchbranch+'&chkdeletedinv='+chkdeletedinv+'&id=1');
}
</script>

<div id="search" class="modern-ui">

    <div class="modern-panel">
        
        <div style="display: flex; gap: 30px;">
            
            <div style="flex: 1; display: flex; flex-direction: column;">
                <div class="field-row">
                    <label class="lbl-right">Date</label>
                    <div style="flex: 1;">
                        <div id="searchdate" name="searchdate"></div>
                    </div>
                </div>
                <div class="field-row">
                    <label class="lbl-right">Client</label>
                    <input type="text" name="searchclient" id="searchclient" class="input-full" value='<s:property value="searchclient"/>'>
                </div>
                <div class="field-row" style="margin-bottom: 0;">
                    <label class="lbl-right">Agmt No</label>
                    <input type="text" name="searchagmtno" id="searchagmtno" class="input-full" value='<s:property value="searchagmtno"/>'>
                </div>
            </div>

            <div style="flex: 1; display: flex; flex-direction: column;">
                <div class="field-row">
                    <label class="lbl-right">Doc No</label>
                    <input type="text" name="searchdocno" id="searchdocno" class="input-full" value='<s:property value="searchdocno"/>'>
                </div>
                <div class="field-row">
                    <label class="lbl-right">Ref Type</label>
                    <select name="searchcmbagmttype" id="searchcmbagmttype" class="input-full">
                        <option value="">--Select--</option>
                        <option value="RAG">Rental</option>
                        <option value="LAG">Lease</option>
                    </select>
                </div>
                <div class="field-row" style="margin-bottom: 0;">
                    <label class="lbl-right"></label> <label class="chk-container">
                        <input type="checkbox" name="chkdeletedinv" id="chkdeletedinv" onchange="funChangeDeletedInv();">
                        Deleted Invoices
                    </label>
                    <input type="hidden" name="hidchkdeletedinv" id="hidchkdeletedinv" value="0">
                </div>
            </div>

            <div style="display: flex; align-items: flex-start;">
                <input type="button" name="btninvsearch" id="btninvsearch" class="myButton" value="Search" onClick="mainloadSearch();">
            </div>

        </div>

    </div>

    <div class="grid-container">
        <div id="srefreshdiv">
            <jsp:include page="subMainSearch.jsp" />
        </div>
    </div>

</div>