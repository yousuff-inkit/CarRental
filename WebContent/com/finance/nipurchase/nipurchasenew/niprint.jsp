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
        font-size: 11px;
        color: var(--text-main);
        background-color: #fff;
        margin: 0;
        padding: 20px;
    }

    .document-container {
        max-width: 1000px;
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
        border: 1px solid var(--border-color);
        border-radius: 4px;
        padding: 15px;
        background: #fafafa;
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

    @media print {
        body { padding: 0; }
        .document-container { max-width: 100%; }
        @page { margin: 15mm; size: A4 landscape; }
    }
</style> 
</head>

<body>
<div id="mainBG" class="homeContent" data-type="background">
<form id="fmnq" action="priInvoice" autocomplete="off" target="_blank">

<div class="document-container">

    <jsp:include page="../../../common/printHeader.jsp"></jsp:include>

    <div class="section-title">Invoice Details</div>
    
    <div class="info-grid">
        <div class="grid-row">
            <span class="grid-label">Date:</span>
            <span class="grid-value"><label id="lbldate" name="lbldate"><s:property value="lbldate"/></label></span>
        </div>
        <div class="grid-row" style="display: flex; justify-content: space-between;">
            <div style="display: flex; flex: 1;">
                <span class="grid-label" style="width: auto; margin-right: 10px;">Type:</span>
                <span class="grid-value"><label name="lbltype" id="lbltype"><s:property value="lbltype"/></label></span>
            </div>
            <div style="display: flex; flex: 1; justify-content: flex-end;">
                <span class="grid-label" style="width: auto; margin-right: 10px;">Doc No:</span>
                <span class="grid-value"><label name="docvals" id="docvals"><s:property value="docvals"/></label></span>
            </div>
        </div>

        <div class="grid-row" style="grid-column: 1 / -1;">
            <span class="grid-label">Vendor:</span>
            <span class="grid-value"><label id="lblacno" name="lblacno"><s:property value="lblacno"/></label>&nbsp;&nbsp;&nbsp;&nbsp;<label id="lblacnoname" name="lblacnoname"><s:property value="lblacnoname"/></label></span>
        </div>
        
        <div class="grid-row">
            <span class="grid-label">TRN No:</span>
            <span class="grid-value"><label id="lbltrno" name="lbltrno"><s:property value="lbltrno"/></label></span>
        </div>
        <div class="grid-row"></div>

        <div class="grid-row">
            <span class="grid-label">Inv No:</span>
            <span class="grid-value"><label id="lblinvno" name="lblinvno"><s:property value="lblinvno"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Inv Date:</span>
            <span class="grid-value"><label id="lblinvdate" name="lblinvdate"><s:property value="lblinvdate"/></label></span>
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
                <th width="4%">Sl No</th>
                <th width="20%">Description</th>
                <th width="5%">Qty</th>
                <th class="text-right" width="8%">Unit Price</th>
                <th class="text-right" width="8%">Total</th>
                <th class="text-right" width="8%">Discount</th>
                <th class="text-right" width="5%">Tax %</th>
                <th class="text-right" width="8%">Tax Amount</th>
                <th class="text-right" width="8%">Net Total</th>
                <th class="text-center" width="5%">Type</th>
                <th width="7%">Account</th>
                <th width="9%">Account Name</th>
                <th width="5%">Reg No</th>
            </tr>
        </thead>
        <tbody>
            <s:iterator var="stat" value='#request.details'>
            <tr>   
            <%int i=0; %>
                <s:iterator status="arr" value="#stat.split('::')" var="des">   
                <% if((i==3)||(i==4)||(i==5)||(i==6)||(i==7)||(i==8)) {%>
                    <td class="text-right"><s:property value="#des"/></td>
                <%} else if(i==9) {%>
                    <td class="text-center"><s:property value="#des"/></td>
                <%} else{ %>
                    <td><s:property value="#des"/></td>
                <% } i++;  %>
                </s:iterator>
            </tr>
            </s:iterator>
        </tbody>
        <tfoot>
            <tr>
                <td colspan="11" class="text-right"><b>Total:</b></td>
                <td colspan="2" class="text-right"><label id="lbltotal" name="lbltotal"><s:property value="lbltotal"/></label></td>
            </tr>
            <tr>
                <td colspan="11" class="text-right"><b>Discount:</b></td>
                <td colspan="2" class="text-right"><label id="lbldiscount" name="lbldiscount"><s:property value="lbldiscount"/></label></td>
            </tr>
            <tr>
                <td colspan="11" class="text-right"><b>Tax Amount:</b></td>
                <td colspan="2" class="text-right"><label id="lbltaxtot" name="lbltaxtot"><s:property value="lbltaxtot"/></label></td>
            </tr>
            <tr style="background-color: var(--bg-header);">
                <td colspan="10" class="text-right" style="font-weight: normal; font-size: 10px;">
                    <label id="lbltotinword" name="lbltotinword"><s:property value="lbltotinword"/></label>
                </td>
                <td class="text-right" style="font-weight: bold; font-size: 12px;">NET TOTAL:</td>
                <td colspan="2" class="text-right" style="font-weight: bold; font-size: 12px;"><label id="lblnettotal" name="lblnettotal"><s:property value="lblnettotal"/></label></td>
            </tr>
        </tfoot>
    </table>

    <div style="margin-top: 40px;">
        <jsp:include page="../../../common/printFooter.jsp"></jsp:include>
    </div>

</div>

</form>
</div>
</body>
</html>