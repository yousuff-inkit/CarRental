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

.header-section {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    padding-bottom: 15px;
    border-bottom: 2px solid var(--border-color);
    margin-bottom: 20px;
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

.text-right { text-align: right; }
.text-center { text-align: center; }

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
    @page { size: A4; margin: 15mm; }
}
</style> 

<script>
$(document).ready(function () {
});
function getPrint(){
	document.getElementById("mode").value="print";
	document.getElementById("frmManualInvoicePrint").submit(); 
}
</script>
</head>
<body>
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmManualInvoicePrint" action="printSaleInvoice" autocomplete="off" target="_blank" >

<div class="document-container">

    <div class="header-section">
        <div style="flex: 0 0 150px;">
            <img src="<%=contextPath%>/icons/epic.jpg" style="width:100px; height:auto;" alt=""/>
        </div>
        <div style="flex: 1; text-align: center;">
            <div style="font-size: 20px; font-weight: bold; text-transform: uppercase;">
                <label id="lblprintname" name="lblprintname">Vehicle Sales Tax Invoice</label>
            </div>
            <div style="font-size: 14px; margin-top: 5px;">
                <b><label id="lblprintname1" name="lblprintname1"><s:property value="lblprintname1"/></label></b>
            </div>
        </div>
        <div style="flex: 0 0 250px; text-align: right; font-size: 11px; line-height: 1.5;">
            <div style="font-weight: bold; font-size: 14px;"><label id="lblcompname" name="lblcompname"><s:property value="lblcompname"/></label></div>
            <div><b><label id="lblcompaddress" name="lblcompaddress"><s:property value="lblcompaddress"/></label></b></div>
            <div><b>Tel:</b> <label id="lblcomptel" name="lblcomptel"><s:property value="lblcomptel"/></label></div>
            <div><b>Fax:</b> <label name="lblcompfax" id="lblcompfax"><s:property value="lblcompfax"/></label></div>
            <div><b>Branch:</b> <label id="lblbranch" name="lblbranch"><s:property value="lblbranch"/></label></div>
            <div><b>Location:</b> <label id="lbllocation" name="lbllocation"><s:property value="lbllocation"/></label></div>
            <div><b>TRN:</b> <label id="lblcomptrn" name="lblcomptrn"><s:property value="lblcomptrn"/></label></div>
        </div>
    </div>

    <div class="section-title">Client Details</div>
    <div class="info-grid">
        <div class="grid-row">
            <span class="grid-label">Client Name:</span>
            <span class="grid-value"><label name="lblclientname" id="lblclientname"><s:property value="lblclientname"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Doc No:</span>
            <span class="grid-value"><label name="lbldocno" id="lbldocno"><s:property value="lbldocno"/></label></span>
        </div>

        <div class="grid-row">
            <span class="grid-label">Client TRN:</span>
            <span class="grid-value"><label name="lblclienttrn" id="lblclienttrn"><s:property value="lblclienttrn"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Date:</span>
            <span class="grid-value"><label name="lbldate" id="lbldate"><s:property value="lbldate"/></label></span>
        </div>

        <div class="grid-row">
            <span class="grid-label">Client Code:</span>
            <span class="grid-value"><label name="lblclientcode" id="lblclientcode"><s:property value="lblclientcode"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Mobile:</span>
            <span class="grid-value"><label name="lblphone" id="lblphone"><s:property value="lblphone"/></label></span>
        </div>

        <div class="grid-row" style="grid-column: 1 / -1;">
            <span class="grid-label">Address:</span>
            <span class="grid-value">
                <label name="lbladdress1" id="lbladdress1"><s:property value="lbladdress1"/></label>
                <label name="lbladdress2" id="lbladdress2"><s:property value="lbladdress2"/></label>
            </span>
        </div>

        <div class="grid-row">
            <span class="grid-label">Phone:</span>
            <span class="grid-value"><label name="lblmobile" id="lblmobile"><s:property value="lblmobile"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Type:</span>
            <span class="grid-value"><label name="lbltype" id="lbltype"><s:property value="lbltype"/></label></span>
        </div>

        <div class="grid-row" style="grid-column: 1 / -1;">
            <span class="grid-label">Description:</span>
            <span class="grid-value"><label name="lbldesc" id="lbldesc"><s:property value="lbldesc"/></label></span>
        </div>
    </div>

    <div class="section-title">Invoice Items</div>
    <table class="cr-table">
        <thead>
            <tr>
                <th width="10%">SI No</th>
                <th width="20%">Fleet</th>
                <th width="30%">Fleet Name</th>
                <th width="25%">Chassis No</th>
                <th width="15%" class="text-right">Gross</th>
            </tr>
        </thead>
        <tbody>
            <s:iterator var="stat1" status="arr" value="%{#request.INVPRINT}">
                <s:iterator status="arr" value="#stat1" var="stat">
                    <tr>   
                        <s:iterator status="arr" value="#stat.split('::')" var="des" begin="0" end="5">
                            <s:if test="#arr.index!=3">
                                <s:if test="#arr.index<=4">  
                                    <td><s:property value="#des"/></td>
                                </s:if>
                                <s:else>
                                    <td class="text-right"><s:property value="#des"/></td>
                                </s:else>
                            </s:if>
                        </s:iterator>
                    </tr>
                </s:iterator>
            </s:iterator>
        </tbody>
        <tfoot>
            <tr>
                <td colspan="4" class="text-right"><b>Total:</b></td>
                <td class="text-right"><b><label id="lbltotal" name="lbltotal"><s:property value="lbltotal"/></label></b></td>
            </tr>
            <tr>
                <td colspan="4" class="text-right"><b>VAT (5%):</b></td>
                <td class="text-right"><b><label id="lbltaxtotal" name="lbltaxtotal"><s:property value="lbltaxtotal"/></label></b></td>
            </tr>
            <tr style="background-color: var(--bg-header);">
                <td colspan="4" class="text-right"><b>NET TOTAL:</b></td>
                <td class="text-right"><b><label id="lblnettaxtotal" name="lblnettaxtotal"><s:property value="lblnettaxtotal"/></label></b></td>
            </tr>
            <tr>
                <td colspan="5" class="text-right" style="padding-top: 15px;">
                    <b>Amount In Words:</b> <b><label id="lblamountwords" name="lblamountwords"><s:property value="lblamountwords"/></label></b>
                </td>
            </tr>
        </tfoot>
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

    <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
</div>
</form>
</div>
</body>
</html>