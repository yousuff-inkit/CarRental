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
    // These variables read from the parent window's inputs
    if(document.getElementById("txtforsearch")) {
        if(document.getElementById("txtforsearch").value=="1"){
           document.getElementById("txtatypes").value="AR";
        }else if(document.getElementById("txtforsearch").value=="2"){
           document.getElementById("txtatypes").value="AR";
        }
        document.getElementById("txtcreditdebit").value=document.getElementById("txtforsearch").value;
    }
    
    if(document.getElementById("formdetailcode")) {
        document.getElementById("txtdocumenttypes").value=document.getElementById("formdetailcode").value;
    }
    
    if($('#maindate').length > 0) {
        document.getElementById("txtnewdate").value=$('#maindate').val();
    }
}); 

function loadClientAccountSearch() {
    var clientaccountno=document.getElementById("accountsno").value;
    var clientaccountname=document.getElementById("accountsname").value;
    var clientmobile=document.getElementById("clientmobileno").value;
    var curr=document.getElementById("txtcurrencies").value;
    var accounttype=document.getElementById("txtatypes").value;
    var code=document.getElementById("txtdocumenttypes").value;
    var debitcredit=document.getElementById("txtcreditdebit").value;
    var date=document.getElementById("txtnewdate").value;
    var checked = 1;

    getClientAccountDetails(clientaccountno,clientaccountname,clientmobile,curr,accounttype,code,debitcredit,date,checked);
}
    
function getClientAccountDetails(clientaccountno,clientaccountname,clientmobile,curr,accounttype,code,debitcredit,date,checked){
     $("#refreshClientAccountDiv").load("../../clientAccountDetailsSearchGrid.jsp?accountno="+clientaccountno+'&accountname='+clientaccountname.replace(/ /g, "%20")+'&mobile='+clientmobile+'&currency='+curr+'&atype='+accounttype+'&dtype='+code+'&debitcredit='+debitcredit+'&date='+date+'&check='+checked);
}
</script>

<div id="search" class="modern-ui">

    <div class="modern-panel">
        
        <div class="field-row">
            <label class="lbl-right" style="width: 80px;">Account No</label>
            <input type="text" name="accountsno" id="accountsno" class="input-md" value='<s:property value="accountsno"/>'>

            <label class="lbl-right" style="width: 60px;">Currency</label>
            <input type="text" name="txtcurrencies" id="txtcurrencies" class="input-sm" value='<s:property value="txtcurrencies"/>'>

            <label class="lbl-right" style="width: 50px;">Mobile</label>
            <input type="text" name="clientmobileno" id="clientmobileno" class="input-full" style="max-width: 150px;" value='<s:property value="clientmobileno"/>'>
        </div>

        <div class="field-row" style="margin-bottom: 0;">
            <label class="lbl-right" style="width: 80px;">Account Name</label>
            <input type="text" name="accountsname" id="accountsname" class="input-full" style="max-width: 400px;" value='<s:property value="accountsname"/>'>

            <div style="margin-left: auto; padding-right: 5px;">
                <input type="button" name="btnClientAccountSearch" id="btnClientAccountSearch" class="myButton" value="Search" onclick="loadClientAccountSearch();">
            </div>
        </div>

    </div>

    <input type="hidden" name="txtatypes" id="txtatypes" value='<s:property value="txtatypes"/>'>
    <input type="hidden" name="txtdocumenttypes" id="txtdocumenttypes" value='<s:property value="txtdocumenttypes"/>'>
    <input type="hidden" name="txtnewdate" id="txtnewdate" value='<s:property value="txtnewdate"/>'>
    <input type="hidden" name="txtcreditdebit" id="txtcreditdebit" value='<s:property value="txtcreditdebit"/>'>

    <div class="grid-container">
        <div id="refreshClientAccountDiv">
            <jsp:include page="clientAccountDetailsSearchGrid.jsp" />
        </div>
    </div>

</div>