<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style type="text/css">
:root {
    --border-color: #333;
    --bg-header: #f4f7fb;
    --text-main: #222;
}
body {
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    font-size: 12px;
    color: var(--text-main);
    background-color: #fff;
    margin: 0;
    padding: 20px;
}
.document-container {
    max-width: 900px;
    margin: 0 auto;
}
.section-title {
    background-color: var(--border-color);
    color: #fff;
    padding: 6px 12px;
    font-weight: bold;
    font-size: 13px;
    text-transform: uppercase;
    margin-top: 25px;
    margin-bottom: 10px;
    -webkit-print-color-adjust: exact;
    print-color-adjust: exact;
}
.info-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 15px 30px;
    margin-bottom: 20px;
    padding: 0 5px;
}
.grid-row {
    display: flex;
    align-items: baseline;
    border-bottom: 1px dotted #ccc;
    padding-bottom: 4px;
}
.grid-label {
    font-weight: bold;
    width: 130px;
    flex-shrink: 0;
    color: #444;
}
.grid-value {
    flex-grow: 1;
    color: #000;
}
.cr-table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
    border: 1px solid var(--border-color);
}
.cr-table th, .cr-table td {
    padding: 8px 10px;
    border: 1px solid #d1d5db;
    text-align: left;
}
.cr-table th {
    background-color: var(--bg-header);
    font-weight: bold;
    color: var(--border-color);
    text-transform: uppercase;
    font-size: 11px;
    -webkit-print-color-adjust: exact;
    print-color-adjust: exact;
}
.cr-table .text-right { text-align: right; }
.cr-table .text-center { text-align: center; }
.summary-block {
    width: 100%;
    max-width: 450px;
    margin-left: auto;
    margin-top: 20px;
    border: 1px solid var(--border-color);
    border-radius: 4px;
    padding: 15px;
    background-color: #fafafa;
    -webkit-print-color-adjust: exact;
    print-color-adjust: exact;
}
.summary-row {
    display: flex;
    justify-content: space-between;
    margin-bottom: 10px;
    font-size: 12px;
}
.summary-row.total-row {
    border-top: 1px solid #ccc;
    padding-top: 10px;
    font-weight: bold;
    font-size: 13px;
}
.signature-wrapper {
    display: flex;
    justify-content: space-between;
    margin-top: 50px;
    gap: 40px;
}
.sig-block {
    flex: 1;
    border: 1px solid var(--border-color);
    padding: 15px;
    border-radius: 4px;
}
.sig-line {
    border-top: 1px dashed var(--border-color);
    margin-top: 40px;
    padding-top: 5px;
    text-align: center;
    font-weight: bold;
    font-size: 11px;
}
.footer-section {
    margin-top: 40px;
    font-size: 10px;
    color: #888;
    border-top: 1px solid #eee;
    padding-top: 10px;
    display: flex;
    justify-content: space-between;
}
@media print {
    body { padding: 0; }
    .document-container { max-width: 100%; }
    @page { margin: 15mm; size: A4; }
}
</style>

<script type="text/javascript">

	function hidedata(){
		
		var first=document.getElementById("firstarray").value;
		var header=document.getElementById("txtheader").value;
	
		if(parseInt(header)==1){
			   $("#headerdiv").prop("hidden", false);
			   $("#withoutHeaderDiv").attr("hidden", true);
			}
			else{
				$("#headerdiv").prop("hidden", true);
				$("#withoutHeaderDiv").attr("hidden", false);
			}
		
		if(parseInt(first)==1){
			   $("#firstdiv").prop("hidden", false);
		}
		else{
			 $("#firstdiv").prop("hidden", true);
			}
		
		}

</script>



</head>
<body onload="hidedata()">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmbankReconcilePrint" action="reconcileprintVoucher" method="post" autocomplete="off" target="_blank">

<div class="document-container">

    <div id="headerdiv" hidden="true">
        <jsp:include page="../../../common/printHeader.jsp"></jsp:include>
    </div>
    
    <div id="withoutHeaderDiv" hidden="true" style="text-align: center; padding: 20px 0; border-bottom: 2px solid #333; margin-bottom: 20px;">
        <h2 style="margin: 0; font-size: 24px; text-transform: uppercase;">
            <label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label>
        </h2>
    </div>

    <div class="section-title">1. Voucher Details</div>
    <div class="info-grid">
        <div class="grid-row">
            <span class="grid-label">Account:</span>
            <span class="grid-value"><label id="lblaccountname" name="lblaccountname"><s:property value="lblaccountname"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Voucher No:</span>
            <span class="grid-value"><label name="lblvoucherno" id="lblvoucherno"><s:property value="lblvoucherno"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Currency:</span>
            <span class="grid-value"><label id="lblcurrency" name="lblcurrency"><s:property value="lblcurrency"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Date Upto:</span>
            <span class="grid-value"><label name="lbldate" id="lbldate"><s:property value="lbldate"/></label></span>
        </div>
    </div>

    <div id="firstdiv" hidden="true">
        <div class="section-title">2. Reconciliation Details</div>
        <table class="cr-table" id="reconcile">
            <thead>
                <tr>
                    <th class="text-center" width="5%">Sl No</th>
                    <th class="text-center" width="14%">Date</th> 
                    <th class="text-center" width="11%">Doc Type</th>
                    <th class="text-center" width="13%">Doc No</th>
                    <th class="text-center" width="27%">Cheque No.</th> 
                    <th class="text-right" width="15%">Receipts</th>
                    <th class="text-right" width="15%">Payments</th>
                </tr>
            </thead>
            <tbody>
                <%int j=0,k=0; %>
                <s:iterator var="stat" value='#request.printreconcilations'>
                <%k=k+1;j=0;%>
                <tr>   
                    <td class="text-center"><%=k%></td>
                    <s:iterator status="arr" value="#stat.split('::')" var="des">   
                        <% if(j>3){%>
                            <td class="text-right"><s:property value="#des"/></td>
                        <%} else{ %>
                            <td class="text-center"><s:property value="#des"/></td>
                        <% } j++;  %>
                    </s:iterator>
                </tr>
                </s:iterator> 
            </tbody>
            <tfoot>
                <tr style="background-color: var(--bg-header); font-weight: bold;">
                    <td colspan="5" class="text-right">TOTAL:</td>
                    <td class="text-right"><label id="lblunclearedreceipttotal" name="lblunclearedreceipttotal"><s:property value="lblunclearedreceipttotal"/></label></td>
                    <td class="text-right"><label id="lblunclearedpaymenttotal" name="lblunclearedpaymenttotal"><s:property value="lblunclearedpaymenttotal"/></label></td>
                </tr>
            </tfoot>
        </table>
    </div>

    <div class="summary-block">
        <div class="summary-row">
            <span><b>Balance As Per Book:</b></span>
            <span><label id="lblbookbalance" name="lblbookbalance"><s:property value="lblbookbalance"/></label></span>
        </div>
        <div class="summary-row">
            <span><b>ADD: Uncleared Payments:</b></span>
            <span><label id="lblunclearedpayments" name="lblunclearedpayments"><s:property value="lblunclearedpayments"/></label></span>
        </div>
        <div class="summary-row">
            <span><b>LESS: Uncleared Receipts:</b></span>
            <span><label id="lblunclearedreceipts" name="lblunclearedreceipts"><s:property value="lblunclearedreceipts"/></label></span>
        </div>
        <div class="summary-row total-row">
            <span><b>Balance As Per Bank Statement:</b></span>
            <span><label id="lblbankstatements" name="lblbankstatements"><s:property value="lblbankstatements"/></label></span>
        </div>
    </div>

    <div class="signature-wrapper">
        <div class="sig-block">
            <div style="font-weight: bold; margin-bottom: 10px; border-bottom: 1px solid #ccc; padding-bottom: 5px;">Internal Processing</div>
            <div style="margin-bottom: 8px;"><b>Prepared by:</b> <label name="lblpreparedby" id="lblpreparedby"><s:property value="lblpreparedby"/></label></div>
            <div style="margin-bottom: 8px;"><b>Date:</b> <label name="lblpreparedon" id="lblpreparedon"><s:property value="lblpreparedon"/></label></div>
            <div style="margin-bottom: 8px;"><b>Time:</b> <label name="lblpreparedat" id="lblpreparedat"><s:property value="lblpreparedat"/></label></div>
        </div>

        <div class="sig-block">
            <div style="font-weight: bold; margin-bottom: 10px; border-bottom: 1px solid #ccc; padding-bottom: 5px;">Received By</div>
            <div style="height: 40px;"></div>
            <div class="sig-line">Name, Signature & Stamp</div>
            <div style="display: flex; justify-content: space-between; margin-top: 10px; font-size: 11px;">
                <span>Date: ____/____/______</span>
                <span>Time: ____:____</span>
            </div>
        </div>
    </div>

    <div class="footer-section">
        <span>Printed by <%=session.getAttribute("USERNAME")%> <label id="lblfooter"></label></span>
        <span style="font-weight: bold; color: #bbb;">System Generated Document Signature & Stamp Not Required - </span>
        <div id="content" style="display:none;"><div id="pageFooter"></div></div>
    </div>

    <div style="display:none;">
        <input type="hidden" id="firstarray" name="firstarray" value='<s:property value="firstarray"/>'>  
        <input type="hidden" id="txtheader" name="txtheader" value='<s:property value="txtheader"/>'>
    </div>

</div>

</form>
</div>
</body>
</html>
