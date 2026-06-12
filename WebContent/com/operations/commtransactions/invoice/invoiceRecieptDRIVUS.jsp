<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<script type="text/javascript" src="<%=contextPath%>/js/jquery-1.11.1.min.js"></script> 
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
    max-width: 950px;
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
}

.grid-label {
    font-weight: bold;
    width: 120px;
    flex-shrink: 0;
    color: #444;
}

.grid-value {
    flex-grow: 1;
    color: #000;
}

.grid-col-span-2 {
    grid-column: span 2;
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
    margin-top: 20px;
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

.commonfooter {
    position: fixed;
    bottom: 0;
    width: 100%;
}

@media print {
    body { padding: 0; }
    .document-container { max-width: 100%; }
    @page { margin: 15mm; size: A4; }
    .commonfooter { position: fixed; bottom: 0; }
}
</style> 

<script>
function getPrint(){
	document.getElementById("mode").value="print";
	document.getElementById("frmManualInvoicePrint").submit(); 
}

$(document).ready(function(){
	if(document.getElementById("lblhidheader").value=="1"){
		$(".invheader").hide();
		$(".commonheader").show();
		$(".commonfooter").show();
	}
	else{
		$(".invheader").show();
		$(".commonheader").hide();
		$(".commonfooter").hide();
	}
});
</script>
</head>
<body>
<div id="mainBG" class="homeContent" data-type="background">

<s:set name="counter" value="0"></s:set>
<s:set name="salik" value="#lblsalikcount"></s:set>

<s:iterator value='#request.TRIAL' var="#aa" status="arr">
<form id="frmManualInvoicePrint" action="printManualInvoice" autocomplete="off" target="_blank">

<div class="commonheader">
    <jsp:include page="../../../common/DrivusHeader.jsp"></jsp:include> <br/> 
</div>

<div class="document-container">
    
    <div class="invheader">
        <div style="text-align: center; font-size: 24px; font-weight: bold; margin-bottom: 20px; text-transform: uppercase;">
            <label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label>
        </div>
        <div style="display: flex; justify-content: space-between; margin-bottom: 20px; border-bottom: 2px solid var(--border-color); padding-bottom: 10px;">
            <div>
                <div><b>Location:</b> <label id="lbllocation" name="lbllocation"><s:property value="lbllocation"/></label></div>
                <div><b>Branch:</b> <label id="lblbranch" name="lblbranch"><s:property value="lblbranch"/></label></div>
            </div>
            <div class="text-right">
                <div><b>TRN:</b> <label name="lblcomptrn" id="lblcomptrn"><s:property value="lblcomptrn"/></label></div>
            </div>
        </div>
    </div>

    <div class="section-title">Invoice Details</div>
    <div class="info-grid">
        <div class="grid-row">
            <span class="grid-label">Customer:</span>
            <span class="grid-value"><label id="lblclient" name="lblclient"><s:property value="lblclient"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">INV No:</span>
            <span class="grid-value"><label name="lblinvno" id="lblinvno"><s:property value="lblinvno"/></label> (<label name="lblinvtype" id="lblinvtype"><s:property value="lblinvtype"/></label>)</span>
        </div>

        <div class="grid-row">
            <span class="grid-label">Code:</span>
            <span class="grid-value"><label id="lblaccount" name="lblaccount"><s:property value="lblaccount"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Date:</span>
            <span class="grid-value"><label name="lbldate" id="lbldate"><s:property value="lbldate"/></label></span>
        </div>

        <div class="grid-row grid-col-span-2">
            <span class="grid-label">Address:</span>
            <span class="grid-value"><label name="lbladdress1" id="lbladdress1"><s:property value="lbladdress1"/></label></span>
        </div>
        
        <div class="grid-row grid-col-span-2">
            <span class="grid-label">&nbsp;</span>
            <span class="grid-value"><label name="lbladdress2" id="lbladdress2"><s:property value="lbladdress2"/></label></span>
        </div>

        <div class="grid-row">
            <span class="grid-label">RA No:</span>
            <span class="grid-value"><label name="lblrano" id="lblrano"><s:property value="lblrano"/></label> (<label name="lblmrano" id="lblmrano"><s:property value="lblmrano"/></label>)</span>
        </div>
        <div class="grid-row">
            <span class="grid-label">LPO No:</span>
            <span class="grid-value"><label name="lbllpono" id="lbllpono"><s:property value="lbllpono"/></label></span>
        </div>

        <div class="grid-row">
            <span class="grid-label">TRN:</span>
            <span class="grid-value"><label name="lblclienttrn" id="lblclienttrn"><s:property value="lblclienttrn"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Branch:</span>
            <span class="grid-value"><label id="lblbranch" name="lblbranch"><s:property value="lblbranch"/></label></span>
        </div>

        <div class="grid-row">
            <span class="grid-label">Mobile:</span>
            <span class="grid-value"><label name="lblmobile" id="lblmobile"><s:property value="lblmobile"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Type:</span>
            <span class="grid-value"><label name="lblratype" id="lblratype"><s:property value="lblratype"/></label></span>
        </div>

        <div class="grid-row">
            <span class="grid-label">Phone:</span>
            <span class="grid-value"><label name="lbltelphone" id="lbltelphone"><s:property value="lbltelphone"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Contract Start:</span>
            <span class="grid-value"><label id="lblcontractstart" name="lblcontractstart"><s:property value="lblcontractstart"/></label></span>
        </div>

        <div class="grid-row grid-col-span-2" style="display: flex; justify-content: space-between;">
            <div style="display: flex; flex: 1;">
                <span class="grid-label">Driven:</span>
                <span class="grid-value"><label id="lbldriven" name="lbldriven"><s:property value="lbldriven"/></label></span>
            </div>
            <s:if test="lblinvtype!='INT' && lblinvtype!='INS'">
                <div style="display: flex; flex: 1; justify-content: flex-end;">
                    <span class="grid-label" style="width: auto; margin-right: 5px;">Inv From:</span>
                    <span class="grid-value" style="margin-right: 15px;"><label name="lblinvfrom" id="lblinvfrom"><s:property value="lblinvfrom"/></label></span>
                    <span class="grid-label" style="width: auto; margin-right: 5px;">To:</span>
                    <span class="grid-value"><label name="lblinvto" id="lblinvto"><s:property value="lblinvto"/></label></span>
                </div>
            </s:if>
        </div>

        <div class="grid-row">
            <span class="grid-label">Salesman:</span>
            <span class="grid-value"><label id="lblsalesman" name="lblsalesman"><s:property value="lblsalesman"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Currency:</span>
            <span class="grid-value"><label name="lblcurrencycode" id="lblcurrencycode"><s:property value="lblcurrencycode"/></label></span>
        </div>

        <div class="grid-row grid-col-span-2">
            <span class="grid-label">Contract Vehicle:</span>
            <span class="grid-value"><label name="lblcontractvehicle" id="lblcontractvehicle"><s:property value="lblcontractvehicle"/></label></span>
        </div>
        <div class="grid-row grid-col-span-2">
            <span class="grid-label">Current Vehicle:</span>
            <span class="grid-value"><label name="lblcurrentvehicle" id="lblcurrentvehicle"><s:property value="lblcurrentvehicle"/></label></span>
        </div>
    </div>

    <div class="section-title">Line Items</div>
    <table class="cr-table">
        <thead>
            <tr>
                <th width="5%">SI No</th>
                <th width="35%">Charge Description</th>
                <th class="text-right" width="10%">Units</th>
                <th class="text-right" width="10%">Rate</th>
                <th class="text-right" width="10%">Amount</th>
                <th class="text-right" width="10%">Tax Percent</th>
                <th class="text-right" width="10%">Tax Amount</th>
                <th class="text-right" width="10%">Total</th>
            </tr>
        </thead>
        <tbody>
        <s:iterator var="stat1" status="arr" value="%{#request.INVPRINT}">
            <s:if test="#arr.index==#counter">
                <s:iterator status="arr" value="#stat1" var="stat">    
                <tr>   
                    <%int i=0; %>
                    <s:iterator status="arr" value="#stat.split('::')" var="des">   
                        <% if(i>1){%>
                            <td class="text-right"><s:property value="#des"/></td>
                        <%} else{ %>
                            <td><s:property value="#des"/></td>
                        <% } i++;  %>
                    </s:iterator>
                </tr>
                </s:iterator>
            </s:if>
        </s:iterator>
        </tbody>
    </table>

    <div class="section-title">Tax Summary</div>
    <table class="cr-table" style="width: 60%; margin-left: auto;">
        <thead>
            <tr>
                <th>Tax Summary</th>
                <th class="text-right">Amount</th>
                <th class="text-right">Tax</th>
                <th class="text-right">Total</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>VAT 5%</td>
                <td class="text-right"><label name="lblwithtaxvalue" id="lblwithtaxvalue"><s:property value="lblwithtaxvalue"/></label></td>
                <td class="text-right"><label name="lblwithtaxamount" id="lblwithtaxamount"><s:property value="lblwithtaxamount"/></label></td>
                <td class="text-right"><label name="lblwithtaxtotal" id="lblwithtaxtotal"><s:property value="lblwithtaxtotal"/></label></td>
            </tr>
            <tr>
                <td>VAT 0%</td>
                <td class="text-right"><label name="lblwithouttaxtotal" id="lblwithouttaxtotal"><s:property value="lblwithouttaxtotal"/></label></td>
                <td class="text-right"><label name="lblwithouttaxamount" id="lblwithouttaxamount"><s:property value="lblwithouttaxamount"/></label></td>
                <td class="text-right"><label name="lblwithouttaxtotal" id="lblwithouttaxtotal"><s:property value="lblwithouttaxtotal"/></label></td>
            </tr>
            <tr>
                <td>VAT Group</td>
                <td class="text-right"><label name="lbltaxgrouptotal" id="lbltaxgrouptotal"><s:property value="lbltaxgrouptotal"/></label></td>
                <td class="text-right">0.00</td>
                <td class="text-right"><label name="lbltaxgrouptotal" id="lbltaxgrouptotal"><s:property value="lbltaxgrouptotal"/></label></td>
            </tr>
        </tbody>
        <tfoot>
            <tr style="background-color: var(--bg-header); font-weight: bold;">
                <td>TOTAL</td>
                <td class="text-right"><label name="lblnettaxvalue" id="lblnettaxvalue"><s:property value="lblnettaxvalue"/></label></td>
                <td class="text-right"><label name="lblnettaxamount" id="lblnettaxamount"><s:property value="lblnettaxamount"/></label></td>
                <td class="text-right"><label name="lblnettaxtotal" id="lblnettaxtotal"><s:property value="lblnettaxtotal"/></label></td>
            </tr>
        </tfoot>
    </table>

    <input type="hidden" name="lblsalikcount" id="lblsalikcount" value='<s:property value="lblsalikcount"/>'/>
    <input type="hidden" name="lbltrafficcount" id="lbltrafficcount" value='<s:property value="lbltrafficcountdubai"/>'/>
    <input type="hidden" name="lbltrafficcountelse" id="lbltrafficcountelse" value='<s:property value="lbltrafficcountelse"/>'/>
    <input type="hidden" name="lblfleetcount" id="lblfleetcount" value='<s:property value="lblfleetcount"/>'/>
    <input type="hidden" name="lbldamagecount" id="lbldamagecount" value='<s:property value="lbldamagecount"/>'/>
    <input type="hidden" name="lblshowfees" id="lblshowfees" value='<s:property value="lblshowfees"/>'/>
    <input type="hidden" name="lblmanual" id="lblmanual" value='<s:property value="lblmanual"/>'/>
    <s:set name="saliktemp" value="lblsalikcount" />
    <s:set name="trafficdubai" value="lbltrafficcountdubai" />
    <s:set name="trafficelse" value="lbltrafficcountelse" />
    <s:set name="fleetcount" value="lblfleetcount" />
    <s:set name="manual" value="lblmanual" />
    <s:set name="damagecount" value="lbldamagecount" />
    <s:set name="showfees" value="lblshowfees" />

    <s:if test="#trafficdubai > 0 || #trafficelse > 0"> 
        <div class="section-title">Traffic Fines</div>
        <table class="cr-table">
            <thead>
                <tr>
                    <th width="5%">Sr No</th>
                    <th width="10%">Reg No</th>
                    <th width="15%">Ticket No</th>
                    <th width="10%">Date</th>
                    <th width="10%">Time</th>
                    <th width="10%">Amount</th>
                    <th width="15%">Fine Source</th>
                    <th width="25%">Description</th>
                </tr>
            </thead>
            <tbody>
                <s:iterator var="stattraffic" status="arr" value='#request.TRAFFICPRINTDUBAI'>
                    <s:if test="#arr.index==#counter">
                        <s:iterator status="arr" value="#stattraffic" var="stattraffic2"> 
                            <tr>
                                <s:iterator status="arr" value="#stattraffic2.split('::')" var="destraffic"> 
                                    <td><s:property value="#destraffic"/></td>
                                </s:iterator>
                            </tr>	
                        </s:iterator>
                    </s:if>
                </s:iterator>
                
                <s:iterator var="stattraffic" status="arr" value='#request.TRAFFICPRINTELSE'>
                    <s:if test="#arr.index==#counter">
                        <s:iterator status="arr" value="#stattraffic" var="stattraffic2"> 
                            <tr>
                                <s:iterator status="arr" value="#stattraffic2.split('::')" var="destraffic"> 
                                    <td><s:property value="#destraffic"/></td>
                                </s:iterator>
                            </tr>	
                        </s:iterator>
                    </s:if>
                </s:iterator>
            </tbody>
        </table>
        <s:if test="#showfees > 0">
            <div style="font-weight: bold; margin-bottom: 20px;">**Govt. Knowledge Fees for Dubai Traffic fine AED 20/-</div>
        </s:if>
    </s:if>

    <s:if test="#damagecount > 0">
        <div class="section-title">Damage Details</div>
        <div style="margin-bottom: 10px; font-weight: bold;">
            Inspection Doc No: <label name="lblinspno" id="lblinspno"><s:property value="lblinspno"/></label> &nbsp;|&nbsp; 
            Vehicle Reg No: <label name="lblinspregno" id="lblinspregno"><s:property value="lblinspregno"/></label>
        </div>
        <table class="cr-table">
            <thead>
                <tr>
                    <th width="10%">Sr No</th>
                    <th width="10%">Code</th>
                    <th width="30%">Name</th>
                    <th width="10%">Type</th>
                    <th width="40%">Remarks</th>
                </tr>
            </thead>
            <tbody>
                <s:iterator var="statdamage" status="arr" value='#request.DAMAGEPRINT'>
                    <s:if test="#arr.index==#counter">
                        <s:iterator status="arr" value="#statdamage" var="statdamage2"> 
                            <tr>
                                <s:iterator status="arr" value="#statdamage2.split('::')" var="desdamage"> 
                                    <td><s:property value="#desdamage"/></td>
                                </s:iterator>
                            </tr>	
                        </s:iterator>
                    </s:if>
                </s:iterator>
            </tbody>
        </table>
    </s:if>

    <div style="display: flex; justify-content: flex-end; font-size: 14px; margin-top: 20px;">
        <div style="text-align: right; width: 60%;">
            <div style="margin-bottom: 5px;">
                <b>Total:</b> <label id="lbltotal" name="lbltotal"><s:property value="lbltotal"/></label>
            </div>
            <div>
                <b>Amount In Words:</b> <label id="lblamountwords" name="lblamountwords"><s:property value="lblamountwords"/></label>
            </div>
        </div>
    </div>

    <div class="section-title">Bank Details</div>
    <div class="info-grid" style="grid-template-columns: 1fr;">
        <div class="grid-row"><span class="grid-label" style="width: 150px;">Bank Name:</span> <span><label id="lblbankdetails" name="lblbankdetails"><s:property value="lblbankdetails"/></label></span></div>
        <div class="grid-row"><span class="grid-label" style="width: 150px;">Bank Address:</span> <span><label id="lblcompbranchaddress" name="lblcompbranchaddress"><s:property value="lblcompbranchaddress"/></label></span></div>
        <div class="grid-row"><span class="grid-label" style="width: 150px;">Account Name:</span> <span><label id="lblbankbeneficiary1" name="lblbankbeneficiary1"><s:property value="lblbankbeneficiary1"/></label></span></div>
        <div class="grid-row"><span class="grid-label" style="width: 150px;">Account Number:</span> <span><label id="lblbankaccountno" name="lblbankaccountno"><s:property value="lblbankaccountno"/></label></span></div>
        <div class="grid-row"><span class="grid-label" style="width: 150px;">IBAN:</span> <span><label id="lblbankibanno1" name="lblbankibanno1"><s:property value="lblbankibanno1"/></label></span></div>
        <div class="grid-row"><span class="grid-label" style="width: 150px;">Swift Code:</span> <span><label id="lblbeneficiarybank" name="lblbeneficiarybank"><s:property value="lblbeneficiarybank"/></label></span></div>
    </div>

    <s:if test="#fleetcount > 0">
        <div class="section-title">Other Fleets</div>
        <ul style="margin: 0 0 20px 20px; padding: 0;">
            <s:iterator var="stat2" status="arr" value='#request.FLEETPRINT'>
                <s:if test="#arr.index==#counter">
                    <s:iterator status="arr" value="#stat2" var="des2"> 
                        <li style="margin-bottom: 5px;"><s:property value="#des2"/></li>
                    </s:iterator>
                </s:if>
            </s:iterator>
        </ul>
    </s:if>

    <s:if test="#manual==1">
        <div style="margin-bottom: 20px;">
            <b>Remarks:</b> <label id="lblledgernote" name="lblledgernote"><s:property value="lblledgernote"/></label>
        </div>
    </s:if>

    <div class="signature-wrapper">
        <div class="sig-block">
            <div style="font-weight: bold; margin-bottom: 15px; border-bottom: 1px solid #ccc; padding-bottom: 5px;">Checked By</div>
            <div style="margin-top: 10px;"><label id="lblcheckedby" name="lblcheckedby"><s:property value="lblcheckedby"/></label></div>
        </div>
        <div class="sig-block">
            <div style="font-weight: bold; margin-bottom: 15px; border-bottom: 1px solid #ccc; padding-bottom: 5px;">Received By</div>
            <div style="margin-top: 10px;"><label id="lblrecievedby" name="lblrecievedby"><s:property value="lblrecievedby"/></label></div>
        </div>
        <div class="sig-block">
            <div style="font-weight: bold; margin-bottom: 15px; border-bottom: 1px solid #ccc; padding-bottom: 5px;">Date</div>
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

    <s:if test="#saliktemp > 0">
        <DIV style="page-break-after:always"></DIV>
        
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <div><img alt="Dubai Gov Logo" src="<%=contextPath%>/icons/dubaigovlogo.jpg" style="height: 50px;"/></div>
            <div><img alt="RTA Logo" src="<%=contextPath%>/icons/rtalogo.jpg" style="height: 50px;"/></div>
        </div>
        
        <div class="section-title">Salik Details</div>
        <table class="cr-table">
            <thead>
                <tr>
                    <th width="8%">Sr No</th>
                    <th width="12%">Transaction ID</th>
                    <th width="15%">Trip Date/Time</th>
                    <th width="15%">Post Date</th>
                    <th width="20%">Plate Info</th>
                    <th width="10%">Location</th>
                    <th width="10%">Direction</th>
                    <th width="10%" class="text-right">Amount (AED)</th>
                </tr>
            </thead>
            <tbody>
                <s:iterator var="statsalik" status="arr" value='#request.SALIKPRINT'>
                    <s:if test="#arr.index==#counter">
                        <s:iterator status="arr" value="#statsalik" var="statsalik2"> 
                            <tr>
                                <s:iterator status="arr" value="#statsalik2.split('::')" var="dessalik"> 
                                    <td><s:property value="#dessalik"/></td>
                                </s:iterator>
                            </tr>	
                        </s:iterator>
                    </s:if>
                </s:iterator>
            </tbody>
        </table>

        <div class="footer-section">
            <div style="text-align: center; font-size: 11px; color: #aaa; margin-bottom: 5px; border-top: 1px solid #eee; padding-top: 10px;">
                System Generated Document Signature & Stamp Not Required.
            </div>
            <div class="footer-row">
                <span>Printed by <%=session.getAttribute("USERNAME")%> <label id="lblfooter"></label></span>
                <span style="font-weight: bold; color: #bbb;"></span>
            </div>
        </div>
    </s:if>

    <s:if test="#trafficdubai > 0"> 
        <DIV style="page-break-after:always"></DIV>
        
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <div><img alt="Dubai Gov Logo" src="<%=contextPath%>/icons/dubaigovlogo.jpg" style="height: 50px;"/></div>
            <div><img alt="RTA Logo" src="<%=contextPath%>/icons/rtalogo.jpg" style="height: 50px;"/></div>
        </div>
        
        <div class="section-title">Traffic Details (Dubai)</div>
        <table class="cr-table">
            <thead>
                <tr>
                    <th width="5%">Sr No</th>
                    <th width="10%">Reg No</th>
                    <th width="15%">Ticket No</th>
                    <th width="10%">Date</th>
                    <th width="10%">Time</th>
                    <th width="10%" class="text-right">Amount</th>
                    <th width="15%">Fine Source</th>
                    <th width="25%">Description</th>
                </tr>
            </thead>
            <tbody>
                <s:iterator var="stattraffic" status="arr" value='#request.TRAFFICPRINTDUBAI'>
                    <s:if test="#arr.index==#counter">
                        <s:iterator status="arr" value="#stattraffic" var="stattraffic2"> 
                            <tr>
                                <s:iterator status="arr" value="#stattraffic2.split('::')" var="destraffic"> 
                                    <td><s:property value="#destraffic"/></td>
                                </s:iterator>
                            </tr>	
                        </s:iterator>
                    </s:if>
                </s:iterator>
            </tbody>
        </table>

        <div class="footer-section">
            <div style="text-align: center; font-size: 11px; color: #aaa; margin-bottom: 5px; border-top: 1px solid #eee; padding-top: 10px;">
                System Generated Document Signature & Stamp Not Required.
            </div>
            <div class="footer-row">
                <span>Printed by <%=session.getAttribute("USERNAME")%> <label id="lblfooter"></label></span>
                <span style="font-weight: bold; color: #bbb;"></span>
            </div>
        </div>
    </s:if>

    <s:if test="#trafficelse > 0"> 
        <DIV style="page-break-after:always"></DIV>
        
        <div style="margin-bottom: 20px; text-align: center;">
            <img alt="Traffic Logo" src="<%=contextPath%>/icons/traffic_banner.jpg" style="max-width: 100%; height: auto;" />
        </div>
        
        <div class="section-title">Traffic Details (Other)</div>
        <table class="cr-table">
            <thead>
                <tr>
                    <th width="5%">Sr No</th>
                    <th width="10%">Reg No</th>
                    <th width="15%">Ticket No</th>
                    <th width="10%">Date</th>
                    <th width="10%">Time</th>
                    <th width="10%" class="text-right">Amount</th>
                    <th width="15%">Fine Source</th>
                    <th width="25%">Description</th>
                </tr>
            </thead>
            <tbody>
                <s:iterator var="stattraffic" status="arr" value='#request.TRAFFICPRINTELSE'>
                    <s:if test="#arr.index==#counter">
                        <s:iterator status="arr" value="#stattraffic" var="stattraffic2"> 
                            <tr>
                                <s:iterator status="arr" value="#stattraffic2.split('::')" var="destraffic"> 
                                    <td><s:property value="#destraffic"/></td>
                                </s:iterator>
                            </tr>	
                        </s:iterator>
                    </s:if>
                </s:iterator>
            </tbody>
        </table>

        <div class="footer-section">
            <div style="text-align: center; font-size: 11px; color: #aaa; margin-bottom: 5px; border-top: 1px solid #eee; padding-top: 10px;">
                System Generated Document Signature & Stamp Not Required.
            </div>
            <div class="footer-row">
                <span>Printed by <%=session.getAttribute("USERNAME")%> <label id="lblfooter"></label></span>
                <span style="font-weight: bold; color: #bbb;"></span>
            </div>
        </div>
    </s:if>

    <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
    <input type="hidden" name="lblhidheader" id="lblhidheader" value='<s:property value="lblhidheader"/>'/>

</div>

<s:if test="#arr.index!=#request.TRIAL.size-1">
    <DIV style="page-break-after:always"></DIV>
</s:if>

<s:set name="counter" value="%{#counter+1}" />
</s:iterator>

</form>
</div>

<div class="commonfooter">
    <jsp:include page="../../../common/DrivusFooter.jsp" />
</div>

</body>
</html>