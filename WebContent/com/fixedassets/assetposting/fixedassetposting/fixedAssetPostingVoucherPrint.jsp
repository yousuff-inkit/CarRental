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
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmfixedAssetVoucherPrint" action="printFixedAssetPosting" method="post" autocomplete="off" target="_blank">

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
            <span class="grid-label">Voucher No:</span>
            <span class="grid-value"><label name="lblvoucherno" id="lblvoucherno"><s:property value="lblvoucherno"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Voucher Date:</span>
            <span class="grid-value"><label name="lbldate" id="lbldate"><s:property value="lbldate"/></label></span>
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

    <div id="firstdiv" hidden="true">
        <div class="section-title">Accounts</div>
        <table class="cr-table" id="applying">
            <thead>
                <tr>
                    <th class="text-center" width="12%">Account No</th>
                    <th width="38%">Account Head</th>
                    <th class="text-right" width="20%">Debit</th>
                    <th class="text-right" width="20%">Credit</th> 
                </tr>
            </thead>
            <tbody>
                <%int j=0; %>
                <s:iterator var="stat" value='#request.printaccounting'>
                <%j=0;%>
                <tr>   
                    <s:iterator status="arr" value="#stat.split('::')" var="des">   
                    <% if(j==1){%>
                        <td><s:property value="#des"/></td>
                    <%} else if(j>1){%>
                        <td class="text-right"><s:property value="#des"/></td>
                    <%} else{ %>
                        <td class="text-center"><s:property value="#des"/></td>
                    <% } j++;  %>
                    </s:iterator>
                </tr>
                </s:iterator>
            </tbody> 
            <tfoot>
                <tr style="background-color: var(--bg-header); font-weight: bold;">
                    <td colspan="2" class="text-right">TOTAL:</td>
                    <td class="text-right"><label id="lbldebittotal" name="lbldebittotal"><s:property value="lbldebittotal"/></label></td>
                    <td class="text-right"><label id="lblcredittotal" name="lblcredittotal"><s:property value="lblcredittotal"/></label></td>
                </tr>
            </tfoot>
        </table>
    </div>
 
    <div id="secdiv" hidden="true"> 
        <div class="section-title">Asset Details</div>
        <table class="cr-table" id="accounting">
            <thead>
                <tr>
                    <th class="text-center" width="5%">Sl No</th>
                    <th width="8%">Asset ID</th>
                    <th width="18%">Asset Name</th>
                    <th width="8%">Group</th>
                    <th class="text-center" width="9%">Purch Date</th>
                    <th class="text-right" width="12%">Purch Price</th> 
                    <th class="text-right" width="11%">Book Value</th>
                    <th class="text-right" width="7%">Depr %</th>
                    <th class="text-right" width="12%">Depreciation</th>
                </tr>
            </thead>
            <tbody>
                <%int i=0,l=0; %>
                <s:iterator var="stat" value='#request.printingarray'>
                <%l=l+1;i=0;%>
                <tr>   
                    <td class="text-center"><%=l%></td>
                    <s:iterator status="arr" value="#stat.split('::')" var="des">   
                    <% if(i==0 || i==2){%>
                        <td><s:property value="#des"/></td>
                    <%} else if(i==1){%>
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
                    <td colspan="8" class="text-right">TOTAL:</td>
                    <td class="text-right"><label id="lbldepreciationtotal" name="lbldepreciationtotal"><s:property value="lbldepreciationtotal"/></label></td>
                </tr>
            </tfoot>
        </table>
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
        <input type="hidden" id="secarray" name="secarray" value='<s:property value="secarray"/>'>
        <input type="hidden" id="txtheader" name="txtheader" value='<s:property value="txtheader"/>'>
    </div>

</div>

</form>
</div>
</body>
</html>