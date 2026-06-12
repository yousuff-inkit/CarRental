<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
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
    font-size: 11px;
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
    font-size: 12px;
    text-transform: uppercase;
    margin-top: 20px;
    margin-bottom: 10px;
    -webkit-print-color-adjust: exact;
    print-color-adjust: exact;
}

.info-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 10px 20px;
    margin-bottom: 15px;
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
    width: 120px;
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
    padding: 6px 8px;
    border: 1px solid #d1d5db;
    text-align: left;
    font-size: 10px;
}

.cr-table th {
    background-color: var(--bg-header);
    font-weight: bold;
    color: var(--border-color);
    text-transform: uppercase;
    font-size: 10px;
    -webkit-print-color-adjust: exact;
    print-color-adjust: exact;
}

.cr-table .text-right { text-align: right; }
.cr-table .text-center { text-align: center; }

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

.sig-internal-grid {
    display: flex;
    justify-content: space-between;
    gap: 10px;
}

.sig-column {
    flex: 1;
    font-size: 11px;
    line-height: 1.6;
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
    display: flex;
    flex-direction: column;
    gap: 10px;
}

.footer-row {
    display: flex;
    justify-content: space-between;
}

@media print {
    body { padding: 0; }
    .document-container { max-width: 100%; }
    @page { margin: 15mm; size: A4; }
}
</style>
<script>
</script>
</head>

<body>
<div id="mainBG" class="homeContent" data-type="background">
<form id="fmnq" action="priInvoice" autocomplete="off" target="_blank">

<div class="document-container">

    <jsp:include page="../../../common/printHeader.jsp"></jsp:include>

    <div class="section-title">Order Details</div>
    <div class="info-grid">
        <div class="grid-row" style="grid-column: 1 / -1;">
            <span class="grid-label">Vendor:</span>
            <span class="grid-value"><label id="lblacno" name="lblacno"><s:property value="lblacno"/></label>&nbsp;&nbsp;&nbsp;&nbsp;<label id="lblacnoname" name="lblacnoname"><s:property value="lblacnoname"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Doc No:</span>
            <span class="grid-value"><label name="docvals" id="docvals"><s:property value="docvals"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">TRN Number:</span>
            <span class="grid-value"><label name="lblclienttrn" id="lblclienttrn"><s:property value="lblclienttrn"/></label></span>
        </div>
        <div class="grid-row" style="grid-column: 1 / -1;">
            <span class="grid-label">Address:</span>
            <span class="grid-value"><label name="venaddress" id="venaddress"><s:property value="venaddress"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Contact Person:</span>
            <span class="grid-value"><label name="contactperson" id="contactperson"><s:property value="contactperson"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Date:</span>
            <span class="grid-value"><label id="lbldate" name="lbldate"><s:property value="lbldate"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Del Date:</span>
            <span class="grid-value"><label id="lbldeldate" name="lbldeldate"><s:property value="lbldeldate"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Del Terms:</span>
            <span class="grid-value"><label name="lbldddtm" id="lbldddtm"><s:property value="lbldddtm"/></label></span>
        </div>
        <div class="grid-row" style="grid-column: 1 / -1;">
            <span class="grid-label">Pay Terms:</span>
            <span class="grid-value"><label id="lblpatms" name="lblpatms"><s:property value="lblpatms"/></label></span>
        </div>
        <div class="grid-row" style="grid-column: 1 / -1;">
            <span class="grid-label">Description:</span>
            <span class="grid-value"><label id="lbldsc" name="lbldsc"><s:property value="lbldsc"/></label></span>
        </div>
    </div>

    <div class="section-title">Line Items</div>
    <table class="cr-table">
        <thead>
            <tr>
                <th class="text-center" width="5%">Sl No</th>
                <th width="35%">Description</th>
                <th class="text-center" width="10%">Qty</th>
                <th class="text-right" width="10%">Unit Price</th>
                <th class="text-right" width="10%">Total</th>
                <th class="text-right" width="10%">Discount</th>
                <th class="text-right" width="5%">Tax %</th>
                <th class="text-right" width="10%">Tax Amount</th>
                <th class="text-right" width="15%">Net Total</th>
            </tr>
        </thead>
        <tbody>
            <s:iterator var="stat" value='#request.details'>
            <tr>   
            <%int i=0; %>
                <s:iterator status="arr" value="#stat.split('::')" var="des">   
                <% if((i>2)) {%>
                <td class="text-right"><s:property value="#des"/></td>
                <%} else if (i==0 || i==2){ %>
                <td class="text-center"><s:property value="#des"/></td>
                <%} else { %>
                <td><s:property value="#des"/></td> 
                <% } i++;  %>
                </s:iterator>
            </tr>
            </s:iterator>
        </tbody>
        <tfoot>
            <tr>
                <td colspan="7" class="text-right"><b>Total:</b></td>
                <td colspan="2" class="text-right"><label id="lbltotal" name="lbltotal"><s:property value="lbltotal"/></label></td>
            </tr>
            <tr>
                <td colspan="7" class="text-right"><b>Discount:</b></td>
                <td colspan="2" class="text-right"><label id="lbldiscount" name="lbldiscount"><s:property value="lbldiscount"/></label></td>
            </tr>
            <tr>
                <td colspan="7" class="text-right"><b>Tax Amount:</b></td>
                <td colspan="2" class="text-right"><label id="lbltaxtot" name="lbltaxtot"><s:property value="lbltaxtot"/></label></td>
            </tr>
            <tr style="background-color: var(--bg-header);">
                <td colspan="6" class="text-right" style="font-weight: normal; font-size: 10px;">
                    <label id="lbltotinword" name="lbltotinword"><s:property value="lbltotinword"/></label>
                </td>
                <td class="text-right" style="font-weight: bold; font-size: 12px;">NET TOTAL:</td>
                <td colspan="2" class="text-right" style="font-weight: bold; font-size: 12px;"><label id="lblnettotal" name="lblnettotal"><s:property value="lblnettotal"/></label></td>
            </tr>
        </tfoot>
    </table>

    <div class="signature-wrapper">
        <div class="sig-block" style="flex: 1.5;">
            <div style="font-weight: bold; margin-bottom: 15px; border-bottom: 1px solid #ccc; padding-bottom: 5px;">Internal Processing</div>
            <div class="sig-internal-grid">
                <div class="sig-column">
                    <div style="font-weight: bold; margin-bottom: 5px;">Prepared</div>
                    <div><b>by</b> <label id="uname" name="uname"><s:property value="uname"/></label></div>
                    <div><b>on</b> <label id="udate" name="udate"><s:property value="udate"/></label></div>
                    <div><b>at</b> <label id="utime" name="utime"><s:property value="utime"/></label></div>
                </div>
                <div class="sig-column">
                    <div style="font-weight: bold; margin-bottom: 5px;">Verified</div>
                    <div><b>by</b> &nbsp;</div>
                    <div><b>on</b> &nbsp;</div>
                    <div><b>at</b> &nbsp;</div>
                </div>
                <div class="sig-column">
                    <div style="font-weight: bold; margin-bottom: 5px;">Approved</div>
                    <div><b>by</b> &nbsp;</div>
                    <div><b>on</b> &nbsp;</div>
                    <div><b>at</b> &nbsp;</div>
                </div>
            </div>
        </div>

        <div class="sig-block" style="flex: 1;">
            <div style="font-weight: bold; margin-bottom: 10px; border-bottom: 1px solid #ccc; padding-bottom: 5px;">Received By</div>
            <div style="height: 40px;"></div>
            <div class="sig-line">Name, Signature & Stamp</div>
            <div style="display: flex; justify-content: space-between; margin-top: 10px; font-size: 11px;">
                <span>Date: ____/____/______</span>
                <span>Time: ____:____</span>
            </div>
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