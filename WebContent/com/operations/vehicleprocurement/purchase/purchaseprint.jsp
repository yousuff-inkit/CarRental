<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<script type="text/javascript" src="<%=contextPath%>/js/jquery-1.11.1.min.js"></script>

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
    max-width: 1000px;
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

.page-break {
    page-break-before: always;
}

@media print {
    body { padding: 0; }
    .document-container { max-width: 100%; }
    @page { margin: 15mm; size: A4 landscape; }
}
</style>

<script type="text/javascript">
function hidedata() {
	var first = document.getElementById("firstarray").value;
	if (parseInt(first) == 1) {
		$("#firstdiv").prop("hidden", false);
	} else {
		$("#firstdiv").prop("hidden", true);
	}
}
</script>

</head>
<body onload="hidedata();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="fmnq" action="priInvoices" autocomplete="off" target="_blank">

<div class="document-container">

    <div>
        <jsp:include page="../../../common/printHeader.jsp"></jsp:include>
        
        <div class="section-title">Purchase Details</div>
        <div class="info-grid">
            <div class="grid-row">
                <span class="grid-label">Date:</span>
                <span class="grid-value"><label id="lbldate" name="lbldate"><s:property value="lbldate"/></label></span>
            </div>
            <div class="grid-row">
                <span class="grid-label">Doc No:</span>
                <span class="grid-value"><label id="lbldoc" name="lbldoc"><s:property value="lbldoc"/></label></span>
            </div>
            <div class="grid-row" style="grid-column: 1 / -1;">
                <span class="grid-label">Vendor:</span>
                <span class="grid-value"><label id="lblvendoeacc" name="lblvendoeacc"><s:property value="lblvendoeacc"/></label> &nbsp; <label id="lblvendoeaccName" name="lblvendoeaccName"><s:property value="lblvendoeaccName"/></label></span>
            </div>
            <div class="grid-row">
                <span class="grid-label">Vendor TRN:</span>
                <span class="grid-value"><label name="lblclienttrn" id="lblclienttrn"><s:property value="lblclienttrn"/></label></span>
            </div>
            <div class="grid-row">
                <span class="grid-label">Type:</span>
                <span class="grid-value"><label id="lbltype" name="lbltype"><s:property value="lbltype"/></label></span>
            </div>
            <div class="grid-row">
                <span class="grid-label">Purchase Date:</span>
                <span class="grid-value"><label id="lblpurchaseDate" name="lblpurchaseDate"><s:property value="lblpurchaseDate"/></label></span>
            </div>
            <div class="grid-row">
                <span class="grid-label">Inv No:</span>
                <span class="grid-value"><label id="lblinvno" name="lblinvno"><s:property value="lblinvno"/></label></span>
            </div>
            <div class="grid-row">
                <span class="grid-label">Exp. Delivery:</span>
                <span class="grid-value"><label name="expdeldate" id="expdeldate"><s:property value="expdeldate"/></label></span>
            </div>
            <div class="grid-row" style="grid-column: 1 / -1;">
                <span class="grid-label">Description:</span>
                <span class="grid-value"><label name="lbldesc1" id="lbldesc1"><s:property value="lbldesc1"/></label></span>
            </div>
        </div>

        <div class="section-title">Item Details</div>
        <table class="cr-table">
            <thead>
                <tr>
                    <th class="text-center" width="5%">Sl No</th>
                    <th width="8%">Brand</th>
                    <th width="9%">Model</th>
                    <th width="16%">Specification</th>
                    <th width="7%">Color</th>
                    <th width="16%">Chassis No</th>
                    <th width="14%">Engine No</th>
                    <th class="text-right" width="6%">Price</th>
                    <th width="7%">Fleet</th>
                    <th width="8%">Reg No</th>
                </tr>
            </thead>
            <tbody>
                <s:iterator var="stat" value='#request.details'>
                <tr>   
                    <%int i=0; %>
                    <s:iterator status="arr" value="#stat.split('::')" var="des">   
                        <% if(i==0){%>
                            <td class="text-center"><s:property value="#des"/></td>
                        <%} else if(i==7){%>
                            <td class="text-right"><s:property value="#des"/></td>
                        <%} else{ %>
                            <td><s:property value="#des"/></td>
                        <% } i++;  %>
                    </s:iterator>
                </tr>
                </s:iterator>
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="7" class="text-right" style="font-weight: bold;">TOTAL:</td>
                    <td class="text-right" style="font-weight: bold;"><label id="lbltotal"><s:property value="lbltotal"/></label></td>
                    <td colspan="2"></td>
                </tr>
                <tr>
                    <td colspan="7" class="text-right" style="font-weight: bold;">Tax 5%:</td>
                    <td class="text-right" style="font-weight: bold;"><label id="lbltax"><s:property value="lbltax"/></label></td>
                    <td colspan="2"></td>
                </tr>
                <tr style="background-color: var(--bg-header);">
                    <td colspan="7" class="text-right" style="font-weight: bold; font-size: 13px;">NET TOTAL:</td>
                    <td class="text-right" style="font-weight: bold; font-size: 13px;"><label id="lblnettotal"><s:property value="lblnettotal"/></label></td>
                    <td colspan="2"></td>
                </tr>
            </tfoot>
        </table>
        
        <div style="font-weight: bold; font-size: 13px; margin-top: 10px; margin-bottom: 30px;">
            Amount in words: <label id="amountinwords" style="font-weight: normal;"><s:property value="amountinwords"/></label>
        </div>

        <div id="firstdiv" hidden="true">
            <div class="section-title">Finance Details</div>
            <div class="info-grid">
                <div class="grid-row">
                    <span class="grid-label">Tax Amount:</span>
                    <span class="grid-value"><label id="lbltax" name="lbltax"><s:property value="lbltax"/></label></span>
                </div>
                <div class="grid-row">
                    <span class="grid-label">Total Amount:</span>
                    <span class="grid-value"><label id="lblnettotal" name="lblnettotal"><s:property value="lblnettotal"/></label></span>
                </div>
                <div class="grid-row">
                    <span class="grid-label">Down Payment:</span>
                    <span class="grid-value"><label id="lbldownpayment" name="lbldownpayment"><s:property value="lbldownpayment"/></label></span>
                </div>
                <div class="grid-row">
                    <span class="grid-label">Loan Amount:</span>
                    <span class="grid-value"><label id="lblloanamt" name="lblloanamt"><s:property value="lblloanamt"/></label></span>
                </div>
                <div class="grid-row">
                    <span class="grid-label">Start Date:</span>
                    <span class="grid-value"><label id="lblstartdate" name="lblstartdate"><s:property value="lblstartdate"/></label></span>
                </div>
                <div class="grid-row">
                    <span class="grid-label">% Of Interest:</span>
                    <span class="grid-value"><label id="lblperinterst" name="lblperinterst"><s:property value="lblperinterst"/></label></span>
                </div>
                <div class="grid-row">
                    <span class="grid-label">Number Of Inst:</span>
                    <span class="grid-value"><label id="lblnoofinst" name="lblnoofinst"><s:property value="lblnoofinst"/></label></span>
                </div>
                <div class="grid-row">
                    <span class="grid-label">Total Interest:</span>
                    <span class="grid-value"><label id="lbltotalint" name="lbltotalint"><s:property value="lbltotalint"/></label></span>
                </div>
                <div class="grid-row">
                    <span class="grid-label">Calculation Method:</span>
                    <span class="grid-value"><label id="lblcalcumethod" name="lblcalcumethod"><s:property value="lblcalcumethod"/></label></span>
                </div>
                <div class="grid-row">
                    <span class="grid-label">Payment Method:</span>
                    <span class="grid-value"><label id="lblpayval" name="lblpayval"><s:property value="lblpayval"/></label></span>
                </div>
                
                <div class="grid-row" style="grid-column: 1 / -1; margin-top: 10px; border-top: 1px solid #eee; padding-top: 10px;"></div>
                
                <div class="grid-row">
                    <span class="grid-label">Acc (Financier):</span>
                    <span class="grid-value"><label id="lblfinacc" name="lblfinacc"><s:property value="lblfinacc"/></label> &nbsp; <label id="lblfinaccName" name="lblfinaccName"><s:property value="lblfinaccName"/></label></span>
                </div>
                <div class="grid-row">
                    <span class="grid-label">Bank A/C:</span>
                    <span class="grid-value"><label id="lblbankacc" name="lblbankacc"><s:property value="lblbankacc"/></label> &nbsp; <label id="lblbankaccName" name="lblbankaccName"><s:property value="lblbankaccName"/></label></span>
                </div>
                <div class="grid-row">
                    <span class="grid-label">Interest A/C:</span>
                    <span class="grid-value"><label id="lblintacc" name="lblintacc"><s:property value="lblintacc"/></label> &nbsp; <label id="lblintaccName" name="lblintaccName"><s:property value="lblintaccName"/></label></span>
                </div>
                <div class="grid-row">
                    <span class="grid-label">Loan A/C:</span>
                    <span class="grid-value"><label id="lblloanacc" name="lblloanacc"><s:property value="lblloanacc"/></label> &nbsp; <label id="lblloanaccName" name="lblloanaccName"><s:property value="lblloanaccName"/></label></span>
                </div>

                <div class="grid-row" style="grid-column: 1 / -1; margin-top: 10px; border-top: 1px solid #eee; padding-top: 10px;"></div>

                <div class="grid-row">
                    <span class="grid-label">Security Chq NO:</span>
                    <span class="grid-value"><label id="lblsecucqNo" name="lblsecucqNo"><s:property value="lblsecucqNo"/></label></span>
                </div>
                <div class="grid-row">
                    <span class="grid-label">Amount:</span>
                    <span class="grid-value"><label id="lblanamt" name="lblanamt"><s:property value="lblanamt"/></label></span>
                </div>
                <div class="grid-row">
                    <span class="grid-label">Upto Date:</span>
                    <span class="grid-value"><label id="lbluptodate" name="lbluptodate"><s:property value="lbluptodate"/></label></span>
                </div>
                <div class="grid-row" style="grid-column: 1 / -1;">
                    <span class="grid-label">Name In Cheque:</span>
                    <span class="grid-value"><label id="lblnameinchq" name="lblnameinchq"><s:property value="lblnameinchq"/></label></span>
                </div>
                <div class="grid-row" style="grid-column: 1 / -1;">
                    <span class="grid-label">Description:</span>
                    <span class="grid-value"><label id="lblDesc" name="lblDesc"><s:property value="lblDesc"/></label></span>
                </div>
            </div>
        </div>
    </div>

    <div class="page-break"></div>

    <div>
        <jsp:include page="../../../common/printHeader.jsp"></jsp:include>
        
        <div class="section-title">Purchase Details</div>
        <div class="info-grid">
            <div class="grid-row">
                <span class="grid-label">Date:</span>
                <span class="grid-value"><label id="lbldate" name="lbldate"><s:property value="lbldate"/></label></span>
            </div>
            <div class="grid-row">
                <span class="grid-label">Doc No:</span>
                <span class="grid-value"><label id="lbldoc" name="lbldoc"><s:property value="lbldoc"/></label></span>
            </div>
            <div class="grid-row" style="grid-column: 1 / -1;">
                <span class="grid-label">Vendor:</span>
                <span class="grid-value"><label id="lblvendoeacc" name="lblvendoeacc"><s:property value="lblvendoeacc"/></label> &nbsp; <label id="lblvendoeaccName" name="lblvendoeaccName"><s:property value="lblvendoeaccName"/></label></span>
            </div>
            <div class="grid-row">
                <span class="grid-label">Vendor TRN:</span>
                <span class="grid-value"><label name="lblclienttrn" id="lblclienttrn"><s:property value="lblclienttrn"/></label></span>
            </div>
            <div class="grid-row">
                <span class="grid-label">Type:</span>
                <span class="grid-value"><label id="lbltype" name="lbltype"><s:property value="lbltype"/></label></span>
            </div>
            <div class="grid-row">
                <span class="grid-label">Purchase Date:</span>
                <span class="grid-value"><label id="lblpurchaseDate" name="lblpurchaseDate"><s:property value="lblpurchaseDate"/></label></span>
            </div>
            <div class="grid-row">
                <span class="grid-label">Inv No:</span>
                <span class="grid-value"><label id="lblinvno" name="lblinvno"><s:property value="lblinvno"/></label></span>
            </div>
            <div class="grid-row">
                <span class="grid-label">Exp. Delivery:</span>
                <span class="grid-value"><label name="expdeldate" id="expdeldate"><s:property value="expdeldate"/></label></span>
            </div>
            <div class="grid-row" style="grid-column: 1 / -1;">
                <span class="grid-label">Description:</span>
                <span class="grid-value"><label name="lbldesc1" id="lbldesc1"><s:property value="lbldesc1"/></label></span>
            </div>
        </div>

        <div class="section-title">Schedule Details</div>
        <table class="cr-table">
            <thead>
                <tr>
                    <th class="text-center">Sr No</th>
                    <th>Date</th>
                    <th>Cheque No</th>
                    <th class="text-right">Principal Amount</th>
                    <th class="text-right">Interest</th>
                    <th class="text-right">Amount</th>
                    <th class="text-center">Bpv No</th>
                </tr>
            </thead>
            <tbody>
                <s:iterator var="stat" value='#request.detailsarr'>
                <tr>   
                    <%int i=0; %>
                    <s:iterator status="arrdet" value="#stat.split('::')" var="des">   
                        <% if(i==0){%>
                            <td class="text-center"><s:property value="#des"/></td>
                        <%} else if(i==6){%>
                            <td class="text-center"><s:property value="#des"/></td>
                        <%} else if(i>2){%>
                            <td class="text-right"><s:property value="#des"/></td>
                        <%} else{ %>
                            <td><s:property value="#des"/></td>
                        <% } i++;  %>
                    </s:iterator>
                </tr>
                </s:iterator>
            </tbody>
            <tfoot>
                <tr style="background-color: var(--bg-header); font-weight: bold;">
                    <td colspan="3" class="text-right">TOTAL:</td>
                    <td class="text-right"><label id="lblpricitotalamount" name="lblpricitotalamount"><s:property value="lblpricitotalamount"/></label></td>
                    <td class="text-right"><label id="lblinttotalamount" name="lblinttotalamount"><s:property value="lblinttotalamount"/></label></td>
                    <td class="text-right"><label id="lbltotalgridamount" name="lbltotalgridamount"><s:property value="lbltotalgridamount"/></label></td>
                    <td></td>
                </tr>
            </tfoot>
        </table>
        
        <div style="margin-top: 50px;">
            <jsp:include page="../../../common/printFooter.jsp"></jsp:include>
        </div>
    </div>

    <input type="hidden" id="firstarray" name="firstarray" value='<s:property value="firstarray"/>'>  

</div>
</form>
</div>
</body>
</html>