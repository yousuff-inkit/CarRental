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
    font-family: 'Segoe UI', Tahoma, sans-serif;
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
    margin-bottom: 20px;
    border: 1px solid #ccc;
    padding: 15px;
    border-radius: 8px;
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
    padding: 8px;
    border: 1px solid #d1d5db;
    text-align: left;
}

.cr-table th {
    background-color: var(--bg-header);
    font-weight: bold;
    text-transform: uppercase;
    font-size: 10px;
    -webkit-print-color-adjust: exact;
    print-color-adjust: exact;
}

@media print {
    body { padding: 0; }
    .document-container { max-width: 100%; }
    @page { size: A4; margin: 15mm; }
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

    <div class="section-title">Customer Information</div>
    <div class="info-grid">
        <div class="grid-row">
            <span class="grid-label">Customer Name:</span>
            <span class="grid-value"><label id="lblclient" name="lblclient"><s:property value="lblclient"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Doc No:</span>
            <span class="grid-value"><label id="docvals" name="docvals"><s:property value="docvals"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Address:</span>
            <span class="grid-value"><label name="lblclientaddress" id="lblclientaddress"><s:property value="lblclientaddress"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Date:</span>
            <span class="grid-value"><label name="lbldate" id="lbldate"><s:property value="lbldate"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">MOB:</span>
            <span class="grid-value"><label name="lblmob" id="lblmob"><s:property value="lblmob"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Type:</span>
            <span class="grid-value"><label name="lbltypep" id="lbltypep"><s:property value="lbltypep"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Email:</span>
            <span class="grid-value"><label name="lblemail" id="lblemail"><s:property value="lblemail"/></label></span>
        </div>
        <div class="grid-row" style="border-bottom: none;"></div>
    </div>

    <div class="section-title">Vehicle Details</div>
    <table class="cr-table">
        <thead>
            <tr>
                <th width="5%">Sl No</th>
                <th>Brand</th>
                <th>Model</th>
                <th>Specification</th>
                <th>Color</th>
                <th>Rent Type</th>
                <th>From Date</th>
                <th>To Date</th>
                <th>Unit</th>
            </tr>
        </thead>
        <tbody>
            <s:iterator var="stat" value='#request.details'>
            <tr>   
                <%int i=0; %>
                <s:iterator status="arr" value="#stat.split('::')" var="des">   
                    <% if(i>1){%>
                        <td align="left"><s:property value="#des"/></td>
                    <%} else{ %>
                        <td align="left"><s:property value="#des"/></td>
                    <% } i++;  %>
                </s:iterator>
            </tr>
            </s:iterator>
        </tbody>
    </table>

    <div style="margin-top: 30px;">
        <jsp:include page="../../../common/printFooter.jsp"></jsp:include>
    </div>

</div>

</form>
</div>
</body>
</html>