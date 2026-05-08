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

<script type="text/javascript">
    $(document).ready(function() {
        getChequePrintConfig();
    });

    // Centralized auto-print handler
    function openAndPrint(url) {
        var win = window.open(url, "_blank", "top=150,left=250,Width=1020,Height=800,location=no,scrollbars=yes,toolbar=yes");
        if (win) {
            var checkReady = setInterval(function() {
                if (win.document.readyState === 'complete') {
                    clearInterval(checkReady);
                    // 1-second timeout allows JSP/Struts elements to render correctly
                    setTimeout(function() {
                        win.focus();
                        win.print();
                    }, 1000);
                }
            }, 500);
        }
    }
    
    function printHeaderVoucher() {
        var url = document.URL;
        var reurl = url.split("saveIbBankPayment");
        $("#docno").prop("disabled", false);  
        
        var finalUrl = reurl[0] + "printIBBankPayment?docno=" + document.getElementById("docno").value + 
                       "&branch=" + document.getElementById("brchName").value + "&header=1";
        
        openAndPrint(finalUrl);
    }
    
    function printCheque(){
        var url = document.URL;
        var reurl = url.split("com");
        $("#docno").prop("disabled", false);  
        
        var finalUrl = reurl[0] + "printIBBankPaymentCheque?docno=" + document.getElementById("docno").value + 
                       "&branch=" + document.getElementById("brchName").value;
        
        openAndPrint(finalUrl);
    }
    
    function printWithOutHeader(){
        var url = document.URL;
        var reurl = url.split("saveIbBankPayment");
        $("#docno").prop("disabled", false); 
        
        var finalUrl = reurl[0] + "printIBBankPayment?docno=" + document.getElementById("docno").value + 
                       "&branch=" + document.getElementById("brchName").value + "&header=0";
        
        openAndPrint(finalUrl);
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
        x.open("GET", "<%=contextPath%>" + "/com/finance/getChequePrintConfig.jsp", true);  
        x.send();
    }
</script>
<body>
<div id=search>
<br/><br/><br/><br/><br/><br/>
<table width="100%">
  <tr>
    <td align="center"><input type="button" name="btnvoucherhead" id="btnvoucherhead" class="myButton" value="Voucher(Header)"  onclick="printHeaderVoucher();"></td>
    <td align="center"><input type="button" name="btncheque" id="btncheque" class="myButton" value="Cheque"  onclick="printCheque();"></td>
    <td align="center"><input type="button" name="btnvoucherwithouthead" id="btnvoucherwithouthead" class="myButton" value="Voucher(Without Header)"  onclick="printWithOutHeader();"></td>
  </tr>
</table>
<br/><br/><br/><br/><br/><br/>
  </div>
</body>
</html>