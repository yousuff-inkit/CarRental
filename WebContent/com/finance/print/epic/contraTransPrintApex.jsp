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
.split-wrapper {
    display: flex;
    gap: 20px;
    margin-top: 20px;
    margin-bottom: 20px;
}
.split-box {
    flex: 1;
    border: 1px solid var(--border-color);
    padding: 15px;
    border-radius: 4px;
}
.split-box-title {
    font-weight: bold;
    background: var(--bg-header);
    padding: 6px 12px;
    margin: -15px -15px 15px -15px;
    border-bottom: 1px solid var(--border-color);
    text-transform: uppercase;
    font-size: 11px;
    color: var(--border-color);
    -webkit-print-color-adjust: exact;
    print-color-adjust: exact;
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
		
		var header=document.getElementById("txtheader").value;
		var first=document.getElementById("firstarray").value;
		var second=document.getElementById("secondarray").value;
		var third=document.getElementById("thirdarray").value;
		
		if(parseInt(header)==1){
		   $("#headerdiv").prop("hidden", false);
		   $("#withoutHeaderDiv").attr("hidden", true);
		}
		else{
			$("#headerdiv").prop("hidden", true);
			$("#withoutHeaderDiv").attr("hidden", false);
		}
		
		if(parseInt(first)==1){
			   $("#firstdiv").prop("hidden", true);
			}
		else{
			$("#firstdiv").prop("hidden", false);
			}
		
		if(parseInt(second)=="1"){
			   $("#vehiclediv").prop("hidden", false);
			}
		else{
			$("#vehiclediv").prop("hidden", true);
			}
		
		if(parseInt(third)=="1"){
			   $("#detaildiv").prop("hidden", false);
			}
		else{
			$("#detaildiv").prop("hidden", true);
			}
		
		}

</script>
</head>
<body onload="hidedata();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmContraTransVoucherPrint" action="contraTransVoucherPrint" method="post" autocomplete="off" target="_blank">

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
            <span class="grid-label">Voucher Date:</span>
            <span class="grid-value"><label id="lbldate" name="lbldate"><s:property value="lbldate"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Voucher No:</span>
            <span class="grid-value"><label name="lblvoucherno" id="lblvoucherno"><s:property value="lblvoucherno"/></label></span>
        </div>
        <div class="grid-row" style="grid-column: 1 / -1;">
            <span class="grid-label">Amount in Words:</span>
            <span class="grid-value"><label id="lblnetamountwords" name="lblnetamountwords"><s:property value="lblnetamountwords"/></label></span>
        </div>
        <div class="grid-row" style="grid-column: 1 / -1;">
            <span class="grid-label">Total Amount:</span>
            <span class="grid-value" style="font-weight: bold;"><label id="lblnetamount" name="lblnetamount"><s:property value="lblnetamount"/></label></span>
        </div>
    </div>

    <div class="split-wrapper">
        <div class="split-box">
            <div class="split-box-title">Payment Details</div>
            <div class="info-grid" style="grid-template-columns: 1fr; gap: 12px; margin-bottom: 0;">
                <div class="grid-row">
                    <span class="grid-label" style="width: 100px;">Paid To:</span>
                    <span class="grid-value"><label id="lblpaidtoname" name="lblpaidtoname"><s:property value="lblpaidtoname"/></label></span>
                </div>
                <div class="grid-row">
                    <span class="grid-label" style="width: 100px;">Cheque No:</span>
                    <span class="grid-value"><label id="lblchqno" name="lblchqno"><s:property value="lblchqno"/></label></span>
                </div>
                <div class="grid-row">
                    <span class="grid-label" style="width: 100px;">Cheque Date:</span>
                    <span class="grid-value"><label id="lblchqdate" name="lblchqdate"><s:property value="lblchqdate"/></label></span>
                </div>
                <div id="firstdiv" hidden="true">
                    <div class="grid-row">
                        <span class="grid-label" style="width: 100px;">Branch:</span>
                        <span class="grid-value"><label id="lblinterbranch" name="lblinterbranch"><s:property value="lblinterbranch"/></label></span>
                    </div>
                </div>
            </div>
        </div>

        <div class="split-box">
            <div class="split-box-title">Receipt Details</div>
            <div class="info-grid" style="grid-template-columns: 1fr; gap: 12px; margin-bottom: 0;">
                <div class="grid-row">
                    <span class="grid-label" style="width: 120px;">Received From:</span>
                    <span class="grid-value"><label id="lblreceivedname" name="lblreceivedname"><s:property value="lblreceivedname"/></label></span>
                </div>
                <div class="grid-row">
                    <span class="grid-label" style="width: 120px;">Description:</span>
                    <span class="grid-value"><label id="lbldescription" name="lbldescription"><s:property value="lbldescription"/></label></span>
                </div>
            </div>
        </div>
    </div>

    <div id="vehiclediv">
        <div class="section-title">2. Vehicle Details</div>
        <div class="info-grid">
            <div class="grid-row">
                <span class="grid-label">Vehicle Make:</span>
                <span class="grid-value"><label id="lblbrandname" name="lblbrandname"><s:property value="lblbrandname"/></label></span>
            </div>
            <div class="grid-row">
                <span class="grid-label">Model/year:</span>
                <span class="grid-value"><label id="lblmodelyear" name="lblmodelyear"><s:property value="lblmodelyear"/></label></span>
            </div>
            <div class="grid-row">
                <span class="grid-label">Chassis No:</span>
                <span class="grid-value"><label id="lblchasisno" name="lblchasisno"><s:property value="lblchasisno"/></label></span>
            </div>
            <div class="grid-row">
                <span class="grid-label">Color:</span>
                <span class="grid-value"><label id="lblcolor" name="lblcolor"><s:property value="lblcolor"/></label></span>
            </div>
        </div>
    </div>

    <div id="detaildiv">
        <div class="section-title">3. Item Details</div>
        <table class="cr-table">
            <thead>
                <tr>
                    <th width="5%">Sl No</th>
                    <th>Description</th>
                    <th width="5%">Qty</th>
                    <th class="text-right" width="7%">Amount</th>
                </tr>
            </thead>
            <tbody>
                <s:iterator var="stat" value='#request.details'>
                <tr>   
                    <%int i=0; %>
                    <s:iterator status="arr" value="#stat.split('::')" var="des">   
                        <%if(i==3){%>
                            <td class="text-right"><s:property value="#des"/></td>
                        <%} else{ %>
                            <td><s:property value="#des"/></td>
                        <% } i++;  %>
                    </s:iterator>
                </tr>
                </s:iterator>
            </tbody>
        </table>
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
        <input type="hidden" name="secondarray" id="secondarray" value='<s:property value="secondarray"/>'>
        <input type="hidden" name="thirdarray" id="thirdarray" value='<s:property value="thirdarray"/>'>
        <input type="hidden" id="txtheader" name="txtheader" value='<s:property value="txtheader"/>'>
    </div>

</div>

</form>
</div>
</body>
</html>
