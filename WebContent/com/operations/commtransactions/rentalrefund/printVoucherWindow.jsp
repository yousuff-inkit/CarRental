<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<style>
/* =========================================================
   SCOPED UI: Clean UI Panel Design for Print Modal
   * All rules are prefixed with .modern-ui to prevent bleeding! *
========================================================= */

.modern-ui {
    font-family: Arial, sans-serif;
    color: #333;
    font-size: 12px;
    padding: 20px;
    background-color: #f4f6f9;
    height: 100%;
    box-sizing: border-box;
    display: flex;
    align-items: center;
    justify-content: center;
}

/* Panel Styling */
.modern-ui .modern-panel {
    border: 1px solid #e1e4e8;
    padding: 40px 30px;
    background: #fff;
    border-radius: 4px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.05);
    display: flex;
    justify-content: center;
    gap: 30px;
    width: 100%;
    max-width: 400px;
}

/* Action Buttons */
.modern-ui .myButton {
    font-weight: bold;
    font-size: 13px;
    height: 32px !important;
    padding: 0px 25px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    box-shadow: 0 1px 2px rgba(59, 130, 246, 0.2);
    min-width: 120px;
}

.modern-ui .myButton:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%);
}

.modern-ui .myButton:disabled {
    background: #cccccc;
    color: #666666;
    cursor: not-allowed;
    box-shadow: none;
}
</style>

<script type="text/javascript">
$(document).ready(function() {
    if ($("#txtdoctype").val() == "CPV") {
        $('#btncheque').attr('disabled', true);
    } else {
        $('#btncheque').attr('disabled', false);
    }
});

function printVoucher() {
    var url = document.URL;
    var reurl = url.split("saveRentalRefund");
    
    // Note: txtsrno & brchName are expected to be in the parent window
    if(document.getElementById("txtsrno")) {
        $("#txtsrno").prop("disabled", false);
    }
    
    var srno = document.getElementById("txtsrno") ? document.getElementById("txtsrno").value : "";
    var branch = document.getElementById("brchName") ? document.getElementById("brchName").value : "";

    var win = window.open(reurl[0]+"printRentalRefund?srno="+srno+"&branch="+branch, "_blank", "top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
    win.focus();
}
    
function printCheque(){
    var url = document.URL;
    var reurl = url.split("saveRentalRefund");
    
    // Note: docno, txtdoctype & brchName are expected to be in the parent window
    if(document.getElementById("docno")) {
        $("#docno").prop("disabled", false);  
    }
    
    var docno = document.getElementById("docno") ? document.getElementById("docno").value : "";
    var dtype = document.getElementById("txtdoctype") ? document.getElementById("txtdoctype").value : "";
    var branch = document.getElementById("brchName") ? document.getElementById("brchName").value : "";

    var win = window.open(reurl[0]+"printRefundCheque?docno="+docno+"&dtype="+dtype+"&branch="+branch, "_blank", "top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
    win.focus();
}
</script>

<div id="search" class="modern-ui">
    <div class="modern-panel">
        <input type="button" name="btnvoucher" id="btnvoucher" class="myButton" value="Voucher" onclick="printVoucher();">
        <input type="button" name="btncheque" id="btncheque" class="myButton" value="Cheque" onclick="printCheque();">
    </div>
</div>