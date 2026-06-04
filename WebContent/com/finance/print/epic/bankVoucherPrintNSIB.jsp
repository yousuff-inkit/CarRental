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
.sig-stamp {
    flex: 0 0 80px;
    display: flex;
    align-items: center;
    justify-content: center;
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
    margin-top: 30px;
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
		var sec=document.getElementById("secarray").value;
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
		
		if(parseInt(sec)==2){
			  $("#secdiv").prop("hidden", false);
		}
		else{
			 $("#secdiv").prop("hidden", true);
			}
		}

</script>



</head>
<body onload="hidedata()">

<div id="image" hidden="true">
    <s:if test="%{status == 4}">
        <img src="<%=contextPath%>/icons/rejected_2.png" />
    </s:if>
    <s:else>
        <img src="<%=contextPath%>/icons/draft_2.png" />
    </s:else>
</div>

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmbankVoucherPrint" action="bankprintVoucher" method="post" autocomplete="off" target="_blank">

<div class="document-container">

    <div id="headerdiv" hidden="true">
        <div style="display: flex; justify-content: space-between; align-items: center; padding-bottom: 10px; border-bottom: 2px solid var(--border-color); margin-bottom: 20px;">
            <div style="flex: 0 0 120px;">
                <img src="<%=contextPath%>/icons/epic.jpg" width="110" height="100" alt=""/>
            </div>
            <div style="flex: 1; text-align: center;">
                <div style="font-size: 20px; font-weight: bold; text-transform: uppercase;"><label id="lblprintnamensib" name="lblprintnamensib"><s:property value="lblprintnamensib"/></label></div>
                <div style="font-size: 14px; font-weight: bold; margin-top: 5px;"><label id="lblprintname1" name="lblprintname1"><s:property value="lblprintname1"/></label></div>
            </div>
            <div style="flex: 0 0 250px; text-align: right; font-size: 12px; line-height: 1.5;">
                <div style="font-size: 14px; font-weight: bold; margin-bottom: 5px;"><label id="lblcompname" name="lblcompname"><s:property value="lblcompname"/></label></div>
                <div style="font-weight: bold; margin-bottom: 5px;"><label id="lblcompaddress" name="lblcompaddress"><s:property value="lblcompaddress"/></label></div>
                <div><b>Tel :</b> <label id="lblcomptel" name="lblcomptel"><s:property value="lblcomptel"/></label></div>
                <div><b>Fax :</b> <label name="lblcompfax" id="lblcompfax"><s:property value="lblcompfax"/></label></div>
                <div><b>Branch :</b> <label id="lblbranch" name="lblbranch"><s:property value="lblbranch"/></label></div>
                <div><b>Location :</b> <label id="lbllocation" name="lbllocation"><s:property value="lbllocation"/></label></div>
            </div>
        </div>
    </div>
    
    <div id="withoutHeaderDiv" hidden="true" style="text-align: center; padding: 20px 0; border-bottom: 2px solid #333; margin-bottom: 20px;">
        <h2 style="margin: 0; font-size: 24px; text-transform: uppercase;">
            <label id="lblprintnamensib" name="lblprintnamensib"><s:property value="lblprintnamensib"/></label>
        </h2>
    </div>

    <div class="section-title">1. Voucher Details</div>
    <div class="info-grid">
        <div class="grid-row">
            <span class="grid-label"><label id="lblmainname" name="lblmainname"><s:property value="lblmainname"/></label>:</span>
            <span class="grid-value"><label id="lblname" name="lblname"><s:property value="lblname"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Voucher No:</span>
            <span class="grid-value"><label name="lblvoucherno" id="lblvoucherno"><s:property value="lblvoucherno"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Description:</span>
            <span class="grid-value"><label id="lbldescription" name="lbldescription"><s:property value="lbldescription"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Voucher Date:</span>
            <span class="grid-value"><label name="lbldate" id="lbldate"><s:property value="lbldate"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Cheque No:</span>
            <span class="grid-value"><label id="lblchqno" name="lblchqno"><s:property value="lblchqno"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Cheque Date:</span>
            <span class="grid-value"><label id="lblchqdate" name="lblchqdate"><s:property value="lblchqdate"/></label></span>
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

    <div id="firstdiv" hidden="true">
        <div class="section-title">2. Applying</div>
        <table class="cr-table" id="applying">
            <thead>
                <tr>
                    <th class="text-center" width="5%">Sl No</th>
                    <th class="text-center" width="11%">Doc No</th>
                    <th class="text-center" width="9%">Doc Type</th>
                    <th class="text-center" width="11%">Date</th> 
                    <th width="25%">Remarks</th> 
                    <th class="text-right" width="13%">Amount</th>
                    <th class="text-right" width="13%">Applying</th>
                    <th class="text-right" width="13%">Balance</th>
                </tr>
            </thead>
            <tbody>
                <%int j=0,k=0; %>
                <s:iterator var="stat" value='#request.printapplying'>
                <%k=k+1;j=0;%>
                <tr>   
                    <td class="text-center"><%=k%></td>
                    <s:iterator status="arr" value="#stat.split('::')" var="des">   
                        <% if(j==3){%>
                            <td><s:property value="#des"/></td>
                        <%} else if(j>3){%>
                            <td class="text-right"><s:property value="#des"/></td>
                        <%} else{ %>
                            <td class="text-center"><s:property value="#des"/></td>
                        <% } j++;  %>
                    </s:iterator>
                </tr>
                </s:iterator> 
            </tbody>
        </table>
    </div>

    <div id="secdiv" hidden="true"> 
        <div class="section-title">3. Accounting</div>
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

    <div style="margin-top: 15px; font-weight: bold; font-size: 13px; text-align: right; color: var(--text-main);">
        * Cheque Receipt is subject to realisation.
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
                    <div><b>by</b> <label name="verifiedappr" id="verifiedappr"><s:property value="verifiedappr"/></label></div>
                    <div><b>on</b> <label name="verifybydt" id="verifybydt"><s:property value="verifybydt"/></label></div>
                    <div><b>at</b> <label name="verifybyat" id="verifybyat"><s:property value="verifybyat"/></label></div>
                </div>
                <div class="sig-column">
                    <div style="font-weight: bold; margin-bottom: 5px;">Approved</div>
                    <div><b>by</b> <label name="approved" id="approved"><s:property value="approved"/></label></div>
                    <div><b>on</b> <label name="approvedt" id="approvedt"><s:property value="approvedt"/></label></div>
                    <div><b>at</b> <label name="approveat" id="approveat"><s:property value="approveat"/></label></div>
                </div>
                <div class="sig-stamp">
                    <img src="<%=contextPath%>/icons/nsib_stamp.png" style="max-width: 100%; max-height: 70px;" alt=""/>
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
        <input type="hidden" id="secarray" name="secarray" value='<s:property value="secarray"/>'>
        <input type="hidden" id="txtheader" name="txtheader" value='<s:property value="txtheader"/>'>
        <input type="hidden" id="watermark" name="watermark" value='<s:property value="watermark"/>'>
    </div>

</div>

</form>
</div>
</body>
</html>
