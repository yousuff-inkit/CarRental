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
    width: 70px; /* Locks label widths for perfect vertical alignment */
}

/* Panel Styling */
.modern-ui .modern-panel {
    border: 1px solid #e1e4e8;
    padding: 20px 15px 10px 15px;
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
    $("#receiptdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy", value:null});

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
    var accountName=document.getElementById("txtaccountname").value;
    var mobno=document.getElementById("mobno").value;
    var srNo=document.getElementById("txtdocumentsrno").value;
    var date=document.getElementById("receiptdate").value;
    var total=document.getElementById("txtamounttotal").value;
    var refNo=document.getElementById("txtreferenceno").value;

    getdata(accountName,mobno,srNo,date,total,refNo);
}

function getdata(accountName,mobno,srNo,date,total,refNo){
    $("#refreshdiv").load('rrvMainSearchGrid.jsp?accountName='+accountName.replace(/ /g, "%20")+'&mobile='+mobno+'&srNo='+srNo+'&date='+date+'&total='+total+'&refNo='+refNo);
}
</script>

<div id="search" class="modern-ui">

    <div class="modern-panel">
        
        <div style="display: flex; gap: 30px;">
            
            <div style="flex: 1; display: flex; flex-direction: column;">
                <div class="field-row">
                    <label class="lbl-right">Date</label>
                    <div style="flex: 1;">
                        <div id="receiptdate" name="receiptdate" value='<s:property value="receiptdate"/>'></div>
                        <input type="hidden" name="hidreceiptdate" id="hidreceiptdate" value='<s:property value="hidreceiptdate"/>'>
                    </div>
                </div>
                <div class="field-row">
                    <label class="lbl-right">A/C Name</label>
                    <input type="text" name="txtaccountname" id="txtaccountname" class="input-full" autocomplete="off" value='<s:property value="txtaccountname"/>'>
                </div>
                <div class="field-row" style="margin-bottom: 0;">
                    <label class="lbl-right">Mobile</label>
                    <input type="text" name="mobno" id="mobno" class="input-full" autocomplete="off" value='<s:property value="mobno"/>'>
                </div>
            </div>

            <div style="flex: 1; display: flex; flex-direction: column;">
                <div class="field-row">
                    <label class="lbl-right">RR No</label>
                    <input type="text" name="txtdocumentsrno" id="txtdocumentsrno" class="input-full" autocomplete="off" value='<s:property value="txtdocumentsrno"/>'>
                </div>
                <div class="field-row">
                    <label class="lbl-right">Total</label>
                    <input type="text" name="txtamounttotal" id="txtamounttotal" class="input-full" autocomplete="off" value='<s:property value="txtamounttotal"/>'>
                </div>
                <div class="field-row" style="margin-bottom: 0;">
                    <label class="lbl-right">Ref No</label>
                    <input type="text" name="txtreferenceno" id="txtreferenceno" class="input-full" autocomplete="off" value='<s:property value="txtreferenceno"/>'>
                </div>
            </div>

            <div style="display: flex; align-items: flex-start; padding-top: 0px;">
                <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch();">
            </div>

        </div>

    </div>

    <div class="grid-container">
        <div id="refreshdiv">
            <jsp:include page="rrvMainSearchGrid.jsp" />
        </div>
    </div>

</div>