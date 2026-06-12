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
    @page { size: A4; margin: 15mm; }
}
</style>

<script type="text/javascript">
	function hidedata(){
		var first = document.getElementById("firstarray").value;
		var header = document.getElementById("txtheader").value;
	
		if(parseInt(header) == 1){
		   $("#headerdiv").prop("hidden", false);
		   $("#withoutHeaderDiv").attr("hidden", true);
		} else {
			$("#headerdiv").prop("hidden", true);
			$("#withoutHeaderDiv").attr("hidden", false);
		}
		
		if(parseInt(first) == 1){
		   $("#firstdiv").prop("hidden", false);
		} else {
			$("#firstdiv").prop("hidden", true);
		}
	}
</script>

</head>
<body onload="hidedata()">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmSecurityChequeVoucherPrint" action="securityChequeVoucherPrint" method="post" autocomplete="off" target="_blank">

<div class="document-container">

    <div id="headerdiv" hidden="true">
        <jsp:include page="../../../common/printHeader.jsp"></jsp:include>
    </div>
    
    <div id="withoutHeaderDiv" hidden="true" style="text-align: center; padding: 20px 0; border-bottom: 2px solid #333; margin-bottom: 20px;">
        <h2 style="margin: 0; font-size: 24px; text-transform: uppercase;">
            <label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label>
        </h2>
    </div>

    <div class="section-title">Voucher Details</div>
    <div class="info-grid">
        <div class="grid-row">
            <span class="grid-label">Voucher Date:</span>
            <span class="grid-value"><label id="lbldate" name="lbldate"><s:property value="lbldate"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Voucher No:</span>
            <span class="grid-value"><label name="lblvoucherno" id="lblvoucherno"><s:property value="lblvoucherno"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Amount:</span>
            <span class="grid-value"><label id="lblnetamount" name="lblnetamount"><s:property value="lblnetamount"/></label></span>
        </div>
        <div class="grid-row" style="grid-column: 1 / -1;">
            <span class="grid-label">Amount in Words:</span>
            <span class="grid-value"><label id="lblnetamountwords" name="lblnetamountwords"><s:property value="lblnetamountwords"/></label></span>
        </div>
    </div>

    <div style="display: flex; gap: 20px; margin-bottom: 20px;">
        <div style="flex: 1;">
            <div class="section-title">Cheque Information</div>
            <div class="info-grid" style="grid-template-columns: 1fr; margin-bottom: 0;">
                <div class="grid-row">
                    <span class="grid-label">Paid To:</span>
                    <span class="grid-value"><label id="lblpaidtoname" name="lblpaidtoname"><s:property value="lblpaidtoname"/></label></span>
                </div>
                <div class="grid-row">
                    <span class="grid-label">Cheque No:</span>
                    <span class="grid-value"><label id="lblchqno" name="lblchqno"><s:property value="lblchqno"/></label></span>
                </div>
                <div class="grid-row">
                    <span class="grid-label">Cheque Date:</span>
                    <span class="grid-value"><label id="lblchqdate" name="lblchqdate"><s:property value="lblchqdate"/></label></span>
                </div>
                <div class="grid-row" style="border-bottom: none;">
                    <span class="grid-label">Valid Up To:</span>
                    <span class="grid-value"><label id="lblvalidupto" name="lblvalidupto"><s:property value="lblvalidupto"/></label></span>
                </div>
            </div>
        </div>

        <div style="flex: 1;">
            <div class="section-title">Receipt Information</div>
            <div class="info-grid" style="grid-template-columns: 1fr; margin-bottom: 0; height: calc(100% - 65px);">
                <div class="grid-row">
                    <span class="grid-label">Received From:</span>
                    <span class="grid-value"><label id="lblreceivedname" name="lblreceivedname"><s:property value="lblreceivedname"/></label></span>
                </div>
                <div class="grid-row" style="border-bottom: none;">
                    <span class="grid-label">Description:</span>
                    <span class="grid-value"><label id="lbldescription" name="lbldescription"><s:property value="lbldescription"/></label></span>
                </div>
            </div>
        </div>
    </div>

    <div class="signature-wrapper">
        <div class="sig-block" style="flex: 1.5;">
            <div style="font-weight: bold; margin-bottom: 15px; border-bottom: 1px solid #ccc; padding-bottom: 5px;">Internal Processing</div>
            <div class="sig-internal-grid">
                <div class="sig-column">
                    <div style="font-weight: bold; margin-bottom: 5px;">Prepared</div>
                    <div><b>by</b> <label name="lblpreparedby" id="lblpreparedby"><s:property value="lblpreparedby"/></label></div>
                    <div><b>on</b> <label name="lblpreparedon" id="lblpreparedon"><s:property value="lblpreparedon"/></label></div>
                    <div><b>at</b> <label name="lblpreparedat" id="lblpreparedat"><s:property value="lblpreparedat"/></label></div>
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
    </div>

</div>

</form>
</div>
</body>
</html>