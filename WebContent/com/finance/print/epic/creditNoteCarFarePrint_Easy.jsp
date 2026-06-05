```html
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
#image {
    position: fixed;
    top: 30%;
    left: 20%;
    width: 60%;
    opacity: 0.15;
    z-index: -1;
    pointer-events: none;
    text-align: center;
}
#image img {
    width: 100%;
    max-width: 500px;
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
    width: 150px;
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

<script type="text/javascript">
function hidedata(){
	var first=document.getElementById("firstarray").value;
	var header=document.getElementById("txtheader").value;
	var watermark=document.getElementById("watermark").value;
	
	if(parseInt(watermark)==1){
		   $("#image").prop("hidden", false);
		}
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
<body onload="hidedata();">

<div id="image" hidden="true">
    <img src="<%=contextPath%>/icons/draft.png" />
</div>

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmCreditDebitVoucherPrint" action="creditDebitVoucherPrint" method="post" autocomplete="off" target="_blank">

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
        <div class="grid-row" style="grid-column: 1 / -1;">
            <span class="grid-label" style="width: auto; margin-right: 10px;">Your Account has been <label id="lblcreditordebit" name="lblcreditordebit"><s:property value="lblcreditordebit"/></label>:</span>
            <span class="grid-value"><label id="lblaccountname" name="lblaccountname"><s:property value="lblaccountname"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Voucher No:</span>
            <span class="grid-value"><label id="lbldocumentno" name="lbldocumentno"><s:property value="lbldocumentno"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Voucher Date:</span>
            <span class="grid-value"><label id="lbldate" name="lbldate"><s:property value="lbldate"/></label></span>
        </div>
        <div class="grid-row" style="grid-column: 1 / -1;">
            <span class="grid-label">Description:</span>
            <span class="grid-value"><label id="lbldescription" name="lbldescription"><s:property value="lbldescription"/></label></span>
        </div>
        <div class="grid-row" style="grid-column: 1 / -1;">
            <span class="grid-label">Amount in Words:</span>
            <span class="grid-value"><label id="lblnetamountwords" name="lblnetamountwords"><s:property value="lblnetamountwords"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Amount:</span>
            <span class="grid-value" style="font-weight: bold;"><label id="lblnetamount" name="lblnetamount"><s:property value="lblnetamount"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Invoice No:</span>
            <span class="grid-value"><label id="lblinvoiceno" name="lblinvoiceno"><s:property value="lblinvoiceno"/></label></span>
        </div>

        <s:set name="agreement" value="lblagreement" />
        <s:if test="#agreement == 0"> 
        </s:if> 
        <s:else>
            <div class="grid-row">
                <span class="grid-label">Agreement Vehicle:</span>
                <span class="grid-value"><label id="lblvehicleinfo" name="lblvehicleinfo"><s:property value="lblvehicleinfo"/></label></span>
            </div>
            <div class="grid-row">
                <span class="grid-label">Agreement:</span>
                <span class="grid-value"><label id="lblagreement" name="lblagreement"><s:property value="lblagreement"/></label></span>
            </div>
        </s:else>
    </div>

    <div id="firstdiv" hidden="true">
        <div class="section-title">2. Accounting</div>
        <table class="cr-table" id="accounting">
            <thead>
                <tr>
                    <th class="text-center" width="5%">Sl No</th>
                    <th class="text-center" width="8%">Acc. No</th>
                    <th width="28%">Acc. Head</th>
                    <th width="30%">Description</th>
                    <th class="text-center" width="7%">Currency</th> 
                    <th class="text-right" width="11%">Debit</th>
                    <th class="text-right" width="11%">Credit</th>
                </tr>
            </thead>
            <tbody>
                <%int i=0,l=0; %>
                <s:iterator var="stat" value='#request.printingarray' >
                <%l=l+1;i=0;%>
                <tr>   
                    <td class="text-center"><%=l%></td>
                    <s:iterator status="arr" value="#stat.split('::')" var="des">   
                        <% if(i==1 || i==2){%>
                            <td><s:property value="#des"/></td>
                        <%} else if(i>3){%>
                            <td class="text-right"><s:property value="#des"/></td>
                        <%} else{ %>
                            <td class="text-center"><s:property value="#des"/></td>
                        <% } i++;  %>
                    </s:iterator>
                </tr>
                </s:iterator> 
            </tbody>	
            <tfoot>
                <tr style="background-color: var(--bg-header); font-weight: bold;">
                    <td colspan="5" class="text-right">TOTAL:</td>
                    <td class="text-right"><label id="lbldebittotal" name="lbldebittotal"><s:property value="lbldebittotal"/></label></td>
                    <td class="text-right"><label id="lblcredittotal" name="lblcredittotal"><s:property value="lblcredittotal"/></label></td>
                </tr>
            </tfoot>
        </table>
    </div>

    <div class="signature-wrapper">
        <div class="sig-block">
            <div style="font-weight: bold; margin-bottom: 10px; border-bottom: 1px solid #ccc; padding-bottom: 5px;">Internal Processing</div>
            <div style="margin-bottom: 8px;"><b>Prepared by:</b> <label name="lblpreparedby" id="lblpreparedby"><s:property value="lblpreparedby"/></label></div>
            <div style="margin-bottom: 8px;"><b>Verified by:</b> &nbsp;</div>
            <div style="margin-bottom: 8px;"><b>Approved by:</b> &nbsp;</div>
            <div style="margin-bottom: 8px;"><b>Date:</b> <label name="lblpreparedon" id="lblpreparedon"><s:property value="lblpreparedon"/></label> at <label name="lblpreparedat" id="lblpreparedat"><s:property value="lblpreparedat"/></label></div>
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
        <div style="text-align: center; font-size: 11px; color: #aaa; margin-bottom: 5px; border-top: 1px solid #eee; padding-top: 10px;">
            System Generated Document Signature & Stamp Not Required.
        </div>
        <div class="footer-row">
            <span>Printed by <%=session.getAttribute("USERNAME")%> <label id="lblfooter"></label></span>
            <span style="font-weight: bold; color: #bbb;"></span>
        </div>
        <div id="content" style="display:none;"><div id="pageFooter"></div></div>
    </div>

    <div style="display:none;">
        <input type="hidden" id="firstarray" name="firstarray" value='<s:property value="firstarray"/>'>  
        <input type="hidden" id="txtheader" name="txtheader" value='<s:property value="txtheader"/>'>
        <input type="hidden" id="watermark" name="watermark" value='<s:property value="watermark"/>'>
    </div>

</div>

</form>
</div>
</body>
</html>

