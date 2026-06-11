<%@page import="javax.servlet.http.HttpSession.*"%>
<%@page import="javax.servlet.http.HttpServletRequest.*"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link rel="stylesheet" type="text/css" href="../../../../css/body.css">
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

.text-right { text-align: right; }

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

#pageFooter {
    display: table-footer-group;
}

#pageFooter:after {
    counter-increment: page;
    counter-reset: pages 1;
    content: "Page " counter(page) " / " counter(pages);
}

@media print {
    body { padding: 0; }
    .document-container { max-width: 100%; }
    @page { margin: 15mm; size: landscape; }
}
</style> 

<script>
$(document).ready(function () {
});
function getPrint(){
	document.getElementById("mode").value="print";
	document.getElementById("frmSaleInvoicePrint").submit(); 
}
</script>
</head>
<body>
<div id="mainBG" class="homeContent" data-type="background">

<form id="frmSaleInvoicePrint" action="printSaleInvoice" autocomplete="off" target="_blank">

<div class="document-container">

    <jsp:include page="../../../common/printHeader.jsp"></jsp:include> 
    <s:set name="counter" value="0"></s:set>
    <input type="hidden" name="jvsize" id="jvsize" value='<s:property value="jvsize"/>'/>
    <s:set name="jvcounter" value="jvsize"></s:set>

    <div class="section-title">Invoice Information</div>
    <div class="info-grid" style="grid-template-columns: 1fr 1fr 1fr;">
        <div class="grid-row" style="grid-column: span 2;">
            <span class="grid-value">
                <label name="lblclientcode" id="lblclientcode"></label>&nbsp;&nbsp;&nbsp;&nbsp;
                <label name="lblclientname" id="lblclientname"></label>
            </span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Doc No:</span>
            <span class="grid-value"><label name="lbldocno" id="lbldocno"><s:property value="lbldocno"/></label></span>
        </div>
        
        <div class="grid-row">
            <span class="grid-label">Type:</span>
            <span class="grid-value"><label name="lbltype" id="lbltype"><s:property value="lbltype"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Date:</span>
            <span class="grid-value"><label name="lbldate" id="lbldate"><s:property value="lbldate"/></label></span>
        </div>
        <div></div>

        <div class="grid-row" style="grid-column: span 3; border-bottom: none;">
            <span class="grid-label">Description:</span>
            <span class="grid-value"><label name="lbldesc" id="lbldesc"><s:property value="lbldesc"/></label></span>
        </div>
    </div>

    <div class="section-title">Asset Details</div>
    <table class="cr-table">
        <thead>
            <tr>
                <th width="5%">SI No</th>
                <th width="10%">Asset ID</th>
                <th width="25%">Asset Name</th>
                <th width="10%">Dep Posted</th>
                <th class="text-right" width="10%">Pur Value</th>
                <th class="text-right" width="10%">Acc Dep</th>
                <th class="text-right" width="10%">Cur Dep</th>
                <th class="text-right" width="10%">Net Book</th>
                <th class="text-right" width="10%">Net P/(L)</th>
            </tr>
        </thead>
        <tbody>
            <s:iterator var="stat1" status="arr" value="%{#request.INVPRINT}">
                <s:iterator status="arr" value="#stat1" var="stat">
                    <tr>   
                        <s:iterator status="arr" value="#stat.split('::')" var="des">
                            <s:if test="#arr.index<=3">
                                <td><s:property value="#des"/></td>
                            </s:if>
                            <s:else>
                                <td class="text-right"><s:property value="#des"/></td>
                            </s:else>
                        </s:iterator>
                    </tr>
                </s:iterator>
            </s:iterator>
        </tbody>
    </table>

    <div class="signature-wrapper">
        <div class="sig-block">
            <div style="font-weight: bold; margin-bottom: 5px; border-bottom: 1px solid #ccc; padding-bottom: 5px;">Processed By</div>
            <div style="margin-top: 10px;"><label id="lblcheckedby" name="lblcheckedby"><s:property value="lblcheckedby"/></label></div>
        </div>
        <div class="sig-block">
            <div style="font-weight: bold; margin-bottom: 5px; border-bottom: 1px solid #ccc; padding-bottom: 5px;">Received By</div>
            <div style="margin-top: 10px;"><label id="lblrecievedby" name="lblrecievedby"><s:property value="lblrecievedby"/></label></div>
        </div>
        <div class="sig-block">
            <div style="font-weight: bold; margin-bottom: 5px; border-bottom: 1px solid #ccc; padding-bottom: 5px;">Date</div>
            <div style="margin-top: 10px;"><label id="lblfinaldate" name="lblfinaldate"><s:property value="lblfinaldate"/></label></div>
        </div>
    </div>

    <div class="footer-section">
        <div style="text-align: center; font-size: 11px; color: #aaa; margin-bottom: 5px; border-top: 1px solid #eee; padding-top: 10px;">
            System Generated Document Signature & Stamp Not Required.
        </div>
        <div class="footer-row">
            <span>Printed by <%=session.getAttribute("USERNAME")%> <label id="lblfooter"></label></span>
            <span style="font-weight: bold; color: #bbb;"></span>
        </div>
        <div id="content" style="display:none;"><div id="pageFooter"></div></div>
    </div>

</div>

</form>
</div>
</body>
</html>