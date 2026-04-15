<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<style>
/* =========================================================
   SCOPED UI: Centered Print Modal Layout
========================================================= */
.print-modal-body {
    margin: 0;
    background-color: #ffffff; /* Clean white for the popup */
    font-family: Arial, sans-serif;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100%;
    min-height: 180px; /* Gives it vertical space to center nicely in the popup */
    padding: 20px;
    box-sizing: border-box;
}

.button-container {
    display: flex;
    gap: 15px;
    flex-wrap: wrap;
    justify-content: center;
    align-items: center;
    max-width: 100%;
}

.button-container .myButton {
    height: 32px;
    padding: 0 20px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #fff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 13px;
    font-weight: bold;
    box-shadow: 0 2px 4px rgba(59, 130, 246, 0.2);
    transition: all 0.2s;
    white-space: nowrap;
}

.button-container .myButton:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%);
    transform: translateY(-1px);
    box-shadow: 0 4px 6px rgba(59, 130, 246, 0.3);
}
</style>

<script type="text/javascript">
$(document).ready(function() {
	getChequePrintConfig();
	$('#btnpaymentauthform').hide();
	checkConfig();
});

function checkConfig(){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            if(parseInt(items) == 1){
                $('#btnpaymentauthform').show();
            }
        }
    }
    x.open("GET", "<%=contextPath%>/com/finance/transactions/bankpayment/checkConfig.jsp", true);
    x.send();
}

function printHeaderVoucher() {
    var url = document.URL;
    var reurl = url.split("saveBankPayment");
    
    /* Document IDs work perfectly here because JQX setContent injects this into the main DOM */
    $("#docno").prop("disabled", false);
    var win = window.open(reurl[0] + "printBankPayment?docno=" + document.getElementById("docno").value + "&branch=" + document.getElementById("brchName").value + "&header=1", "_blank", "top=150,left=250,width=1020,height=500,location=no,scrollbars=no,toolbar=yes");
    win.focus();
}
	
function printCheque(){
    var url = document.URL;
    var reurl = url.split("com");
    
    $("#docno").prop("disabled", false);  
    var win = window.open(reurl[0] + "printBankPaymentCheque?docno=" + document.getElementById("docno").value + "&branch=" + document.getElementById("brchName").value, "_blank", "top=150,left=250,width=1020,height=500,location=no,scrollbars=no,toolbar=yes");
    win.focus();
}
	
function printWithOutHeader(){
    var url = document.URL;
    var reurl = url.split("saveBankPayment");
    
    $("#docno").prop("disabled", false); 
    var win = window.open(reurl[0] + "printBankPayment?docno=" + document.getElementById("docno").value + "&branch=" + document.getElementById("brchName").value + "&header=0", "_blank", "top=150,left=250,width=1020,height=500,location=no,scrollbars=no,toolbar=yes");
    win.focus();
}

function printPaymentauthform(){
    var url = document.URL;
    var reurl = url.split("saveBankPayment");
    
    $("#docno").prop("disabled", false);
    var win = window.open(reurl[0] + "paymentauthform?docno=" + document.getElementById("docno").value + "&branch=" + document.getElementById("brchName").value + "&header=1", "_blank", "top=150,left=250,width=1020,height=500,location=no,scrollbars=no,toolbar=yes");
    win.focus();
}

function getChequePrintConfig(){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            if(parseInt(items) > 0){
                $("#btncheque").hide();
            } else {
                $("#btncheque").show();
            }
        }
    }
    x.open("GET", "<%=contextPath%>/com/finance/getChequePrintConfig.jsp", true);  
    x.send();
}
</script>
</head>

<body onload="checkConfig();">
    <div class="print-modal-body">
        <div class="button-container">
            <input type="button" name="btnvoucherhead" id="btnvoucherhead" class="myButton" value="Voucher (Header)" onclick="printHeaderVoucher();">
            <input type="button" name="btncheque" id="btncheque" class="myButton" value="Cheque" onclick="printCheque();" style="display:none;">
            <input type="button" name="btnvoucherwithouthead" id="btnvoucherwithouthead" class="myButton" value="Voucher (No Header)" onclick="printWithOutHeader();">
            <input type="button" name="btnpaymentauthform" id="btnpaymentauthform" class="myButton" value="Payment Auth Form" onclick="printPaymentauthform();" style="display:none;">
        </div>
    </div>
</body>
</html>