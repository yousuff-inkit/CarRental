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
    --bg-highlight: #F6CECE;
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
.header-wrapper {
    margin-bottom: 20px;
}
.info-header {
    display: flex;
    justify-content: space-between;
    margin-bottom: 20px;
    border: 1px solid var(--border-color);
    border-radius: 4px;
    padding: 15px;
    background: #fafafa;
}
.info-left {
    width: 40%;
    border-right: 1px dashed #ccc;
    padding-right: 15px;
}
.info-right {
    width: 55%;
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 8px 15px;
}
.grid-row {
    display: flex;
    align-items: baseline;
    border-bottom: 1px dotted #ccc;
    padding-bottom: 4px;
}
.grid-label {
    font-weight: bold;
    width: 100px;
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
    padding: 10px 12px;
    border: 1px solid #d1d5db;
    text-align: left;
    vertical-align: top;
}
.cr-table th {
    background-color: var(--bg-highlight);
    font-weight: bold;
    color: var(--text-main);
    text-transform: uppercase;
    font-size: 11px;
    -webkit-print-color-adjust: exact;
    print-color-adjust: exact;
}
.cr-table tfoot td {
    background-color: var(--bg-header);
    -webkit-print-color-adjust: exact;
    print-color-adjust: exact;
}
.cr-table .text-right { text-align: right; }
.cr-table .text-center { text-align: center; }
.payment-details-grid {
    display: grid;
    grid-template-columns: auto 1fr auto 1fr;
    gap: 8px 15px;
    font-size: 11px;
    margin-top: 15px;
    background: #f9f9f9;
    padding: 10px;
    border-radius: 4px;
    border: 1px solid #eee;
}
.signature-wrapper {
    display: flex;
    justify-content: space-between;
    margin-top: 40px;
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
@media print {
    body { padding: 0; }
    .document-container { max-width: 100%; }
    @page { margin: 15mm; size: A4; }
}
</style>
</head>

<body>
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmRentalRefundVoucher" action="printRentalRefund" method="post" autocomplete="off" target="_blank">

<div class="document-container">

    <div class="header-wrapper">
        <jsp:include page="../../../common/printHeader.jsp"></jsp:include>
    </div>

    <div class="info-header">
        <div class="info-left">
            <div style="font-weight: bold; font-size: 12px; color: #666; text-transform: uppercase; margin-bottom: 5px;">Customer Name</div>
            <div style="font-size: 16px; font-weight: bold; color: var(--text-main);">
                <label id="receivedfrom" name="receivedfrom"><s:property value="receivedfrom"/></label>
            </div>
        </div>
        <div class="info-right">
            <div class="grid-row">
                <span class="grid-label">RA No:</span>
                <span class="grid-value"><label id="rentalno" name="rentalno"><s:property value="rentalno"/></label></span>
            </div>
            <div class="grid-row">
                <span class="grid-label">Receipt No:</span>
                <span class="grid-value"><label id="receiptno" name="receiptno"><s:property value="receiptno"/></label></span>
            </div>
            <div class="grid-row">
                <span class="grid-label">RA Type:</span>
                <span class="grid-value"><label id="rentaltype" name="rentaltype"><s:property value="rentaltype"/></label></span>
            </div>
            <div class="grid-row">
                <span class="grid-label">Receipt Date:</span>
                <span class="grid-value"><label id="receiptdate" name="receiptdate"><s:property value="receiptdate"/></label></span>
            </div>
            <div class="grid-row">
                <span class="grid-label">Ref. No:</span>
                <span class="grid-value"><label id="refno" name="refno"><s:property value="refno"/></label></span>
            </div>
            <div class="grid-row">
                <span class="grid-label">Contract Start:</span>
                <span class="grid-value"><label id="contractstart" name="contractstart"><s:property value="contractstart"/></label></span>
            </div>
        </div>
    </div>

    <table class="cr-table">
        <thead>
            <tr>
                <th>Description</th>
                <th class="text-center" width="20%">Payment Mode</th>
                <th class="text-right" width="20%">Amount</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>
                    <div style="margin-bottom: 8px; font-weight: bold; font-size: 13px;">
                        <label id="lbladvancesecurity" name="lbladvancesecurity"><s:property value="lbladvancesecurity"/></label>
                    </div>
                    <div>
                        <label id="lbldescription" name="lbldescription"><s:property value="lbldescription"/></label>
                    </div>
                    
                    <div class="payment-details-grid">
                        <span style="font-weight: bold;">Card No:</span>
                        <span><label id="cardno" name="cardno"><s:property value="cardno"/></label></span>
                        
                        <span style="font-weight: bold;">Card Exp:</span>
                        <span><label id="cardexp" name="cardexp"><s:property value="cardexp"/></label></span>
                        
                        <span style="font-weight: bold;">Cheque No:</span>
                        <span><label id="chqno" name="chqno"><s:property value="chqno"/></label></span>
                        
                        <span style="font-weight: bold;">Cheque Date:</span>
                        <span><label id="chqdate" name="chqdate"><s:property value="chqdate"/></label></span>
                    </div>
                </td>
                <td class="text-center" style="vertical-align: middle;">
                    <span style="background: #eef2f6; padding: 4px 10px; border-radius: 12px; font-weight: bold;">
                        <label id="paymode" name="paymode"><s:property value="paymode"/></label>
                    </span>
                </td>
                <td class="text-right" style="vertical-align: middle; font-weight: bold; font-size: 14px;">
                    <label id="amount" name="amount"><s:property value="amount"/></label>
                </td>
            </tr>
        </tbody>
        <tfoot>
            <tr>
                <td>
                    <b>Amount in Words:</b> <label id="amtinwords" name="amtinwords"><s:property value="amtinwords"/></label>
                </td>
                <td class="text-right" style="font-weight: bold; font-size: 13px;">TOTAL:</td>
                <td class="text-right" style="font-weight: bold; font-size: 15px;">
                    <label id="total" name="total"><s:property value="total"/></label>
                </td>
            </tr>
        </tfoot>
    </table>

    <div class="signature-wrapper">
        <div class="sig-block" style="flex: 0.6;">
            <div style="font-weight: bold; margin-bottom: 15px; border-bottom: 1px solid #ccc; padding-bottom: 5px;">Internal Processing</div>
            <div style="margin-bottom: 8px;">
                <b>Prepared by:</b> <label id="preparedby" name="preparedby"><s:property value="preparedby"/></label>
            </div>
        </div>

        <div class="sig-block" style="flex: 0.4;">
            <div style="font-weight: bold; margin-bottom: 10px; border-bottom: 1px solid #ccc; padding-bottom: 5px;">Received By</div>
            <div style="height: 40px;"></div>
            <div class="sig-line">Name, Signature & Stamp</div>
        </div>
    </div>

    <div style="margin-top: 40px;">
        <jsp:include page="../../../common/printFooter.jsp"></jsp:include>
    </div>

</div>
</form>
</div>
</body>
</html>