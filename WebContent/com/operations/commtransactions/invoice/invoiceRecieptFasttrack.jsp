<%@page import="javax.servlet.http.HttpSession.*"%>
<%@page import="javax.servlet.http.HttpServletRequest.*"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<% String contextPath=request.getContextPath();%>
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
    align-items: center;
    padding-bottom: 10px;
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
    margin-bottom: 15px;
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
    padding: 6px 8px;
    border: 1px solid #d1d5db;
    text-align: left;
    font-size: 10px;
}

.cr-table th {
    background-color: var(--bg-header);
    font-weight: bold;
    color: var(--border-color);
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
    margin-top: 20px;
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
    margin-top: 30px;
    font-size: 10px;
    color: #888;
    text-align: center;
}

@media print {
    body { padding: 0; }
    .document-container { max-width: 100%; }
    @page { margin: 15mm; size: A4; }
    .page-break { page-break-after: always; }
}
</style> 
<script type="text/javascript">
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
<s:set name="counter" value="0"></s:set>
<input type="hidden" name="jvsize" id="jvsize" value='<s:property value="jvsize"/>'/>
<s:set name="jvcounter" value="jvsize"></s:set>
<s:iterator value='#request.TRIAL' var="#aa" status="arr">

<div class="document-container">
    
    <div style="display: flex; justify-content: space-between; align-items: center; padding-bottom: 10px; border-bottom: 2px solid var(--border-color); margin-bottom: 20px;">
        <jsp:include page="../../../common/printHeader.jsp"></jsp:include>
    </div>

    <div class="info-grid">
        <div class="grid-row" style="grid-column: 1 / -1;">
            <span class="grid-value" style="font-weight: bold; font-size: 14px;">
                <label name="lblclientcode" id="lblclientcode"></label>&nbsp;&nbsp;&nbsp;&nbsp;
                <label name="lblclientname" id="lblclientname"></label>
            </span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Doc No:</span>
            <span class="grid-value"><label name="lbldocno" id="lbldocno"><s:property value="lbldocno"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Date:</span>
            <span class="grid-value"><label name="lbldate" id="lbldate"><s:property value="lbldate"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Type:</span>
            <span class="grid-value"><label name="lbltype" id="lbltype"><s:property value="lbltype"/></label></span>
        </div>
        <div class="grid-row" style="grid-column: 1 / -1; border-bottom: none;">
            <span class="grid-label">Description:</span>
            <span class="grid-value"><label name="lbldesc" id="lbldesc"><s:property value="lbldesc"/></label></span>
        </div>
    </div>

    <div class="section-title">Invoice Items</div>
    <table class="cr-table">
        <thead>
            <tr>
                <th width="5%">SI No</th>
                <th width="10%">Asset ID</th>
                <th width="20%">Asset Name</th>
                <th width="10%">Dep Posted</th>
                <th class="text-right" width="11%">Pur Value</th>
                <th class="text-right" width="11%">Acc Dep</th>
                <th class="text-right" width="11%">Cur Dep</th>
                <th class="text-right" width="11%">Net Book</th>
                <th class="text-right" width="11%">Net P/(L)</th>
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

    <input type="hidden" name="lblsalikcount" id="lblsalikcount" value='<s:property value="lblsalikcount"/>'/>
    <input type="hidden" name="lblsalikauhcount" id="lblsalikauhcount" value='<s:property value="lblsalikauhcount"/>'/>
    <input type="hidden" name="lblsalikdxbcount" id="lblsalikdxbcount" value='<s:property value="lblsalikdxbcount"/>'/>
    <input type="hidden" name="lbltrafficcount" id="lbltrafficcount" value='<s:property value="lbltrafficcountdubai"/>'/>
    <input type="hidden" name="lbltrafficcountelse" id="lbltrafficcountelse" value='<s:property value="lbltrafficcountelse"/>'/>
    <input type="hidden" name="lblfleetcount" id="lblfleetcount" value='<s:property value="lblfleetcount"/>'/>
    <input type="hidden" name="lbldamagecount" id="lbldamagecount" value='<s:property value="lbldamagecount"/>'/>
    <input type="hidden" name="lblshowfees" id="lblshowfees" value='<s:property value="lblshowfees"/>'/>
    <input type="hidden" name="lblextrasrvcstatus" id="lblextrasrvcstatus" value='<s:property value="lblextrasrvcstatus"/>'/>
    
    <s:set name="saliktemp" value="lblsalikcount" />
    <s:set name="salikauhcount" value="lblsalikauhcount" />
    <s:set name="salikdxbcount" value="lblsalikdxbcount" />
    <s:set name="trafficdubai" value="lbltrafficcountdubai" />
    <s:set name="trafficelse" value="lbltrafficcountelse" />
    <s:set name="fleetcount" value="lblfleetcount" />
    <s:set name="damagecount" value="lbldamagecount" />
    <s:set name="showfees" value="lblshowfees" />
    <s:set name="remarks" value="lblextrasrvcstatus" />

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
                    <th width="15%">Location</th>
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
            <div style="font-weight: bold; margin-bottom: 15px;">**Govt. Knowledge Fees for Dubai Traffic fine AED 20/-</div>
        </s:if>
    </s:if>

    <s:if test="#damagecount > 0">
        <div class="section-title">Damage Details</div>
        <div style="margin-bottom: 10px; font-weight: bold;">
            Inspection Doc No: <label name="lblinspno" id="lblinspno"><s:property value="lblinspno"/></label> | 
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

    <s:if test="#remarks > 0">
        <div class="section-title">Extra Services</div>
        <table class="cr-table">
            <thead>
                <tr>
                    <th width="10%">Sr No</th>
                    <th width="30%">Description</th>
                    <th width="40%">Remarks</th>
                    <th width="20%">Amount</th>
                </tr>
            </thead>
            <tbody>
                <s:iterator var="remarkgrid" status="arr" value='#request.REMARKS'>
                    <s:if test="#arr.index==#counter">
                        <s:iterator status="arr" value="#remarkgrid" var="remarkgrid2"> 
                            <tr>
                                <s:iterator status="arr" value="#remarkgrid2.split('::')" var="grid"> 
                                    <td><s:property value="#grid"/></td>
                                </s:iterator>
                            </tr>	
                        </s:iterator>
                    </s:if>
                </s:iterator>
            </tbody>
        </table>
    </s:if> 

    <div style="display: flex; justify-content: flex-end; margin-top: 20px;">
        <div style="width: 50%;">
            <table class="cr-table" style="margin-bottom: 0;">
                <tbody>
                    <tr style="background-color: var(--bg-header); font-weight: bold;">
                        <td>TOTAL:</td>
                        <td class="text-right"><label id="lbltotal" name="lbltotal"><s:property value="lbltotal"/></label></td>
                    </tr>
                </tbody>
            </table>
            <div style="text-align: right; font-weight: bold; margin-top: 5px;">
                Amount In Words: <label id="lblamountwords" name="lblamountwords"><s:property value="lblamountwords"/></label>
            </div>
        </div>
    </div>

    <div class="section-title">Bank Details</div>
    <div class="info-grid" style="grid-template-columns: 1fr;">
        <div class="grid-row"><span class="grid-label">Bank Name:</span> <span class="grid-value"><label id="lblbankdetails" name="lblbankdetails"><s:property value="lblbankdetails"/></label></span></div>
        <div class="grid-row"><span class="grid-label">Bank Address:</span> <span class="grid-value"><label id="lblcompbranchaddress" name="lblcompbranchaddress"><s:property value="lblcompbranchaddress"/></label></span></div>
        <div class="grid-row"><span class="grid-label">Account Name:</span> <span class="grid-value"><label id="lblbankbeneficiary1" name="lblbankbeneficiary1"><s:property value="lblbankbeneficiary1"/></label></span></div>
        <div class="grid-row"><span class="grid-label">Account Number:</span> <span class="grid-value"><label id="lblbankaccountno" name="lblbankaccountno"><s:property value="lblbankaccountno"/></label></span></div>
        <div class="grid-row"><span class="grid-label">IBAN:</span> <span class="grid-value"><label id="lblbankibanno1" name="lblbankibanno1"><s:property value="lblbankibanno1"/></label></span></div>
        <div class="grid-row" style="border-bottom: none;"><span class="grid-label">Swift Code:</span> <span class="grid-value"><label id="lblbeneficiarybank" name="lblbeneficiarybank"><s:property value="lblbeneficiarybank"/></label></span></div>
    </div>

    <s:if test="#fleetcount > 0">
        <div class="section-title">Other Fleets</div>
        <ul style="margin-top: 0; padding-left: 20px;">
            <s:iterator var="stat2" status="arr" value='#request.FLEETPRINT'>
                <s:if test="#arr.index==#counter">
                    <s:iterator status="arr" value="#stat2" var="des2"> 
                        <li><s:property value="#des2"/></li>
                    </s:iterator>
                </s:if>
            </s:iterator>
        </ul>
    </s:if>

    <div class="signature-wrapper">
        <div class="sig-block">
            <div style="font-weight: bold; margin-bottom: 5px; border-bottom: 1px solid #ccc; padding-bottom: 5px;">Checked By</div>
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
        <jsp:include page="../../../common/printFooterGlobal.jsp"></jsp:include>
    </div>

    <s:if test="#salikdxbcount > 0">
        <div class="page-break"></div>
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <img alt="Dubai Gov Logo" src="<%=contextPath%>/icons/dubaigovlogo.jpg" style="height: 50px;"/>
            <img alt="RTA Logo" src="<%=contextPath%>/icons/rtalogo.jpg" style="height: 50px;"/>
        </div>
        
        <div class="section-title">Salik Details (Dubai)</div>
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
                    <th width="10%">Amount</th>
                </tr>
            </thead>
            <tbody>
                <s:iterator var="statsalik" status="arr" value='#request.SALIKDXBPRINT'>
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
            <jsp:include page="../../../common/printFooterGlobal.jsp"></jsp:include>
        </div>
    </s:if>

    <s:if test="#salikauhcount > 0">
        <div class="page-break"></div>
        <div style="margin-bottom: 20px; text-align: left;">
            <img alt="Abu Dhabi Logo" src="<%=contextPath%>/icons/auhsalik.jpeg" style="height: 60px;">
        </div>
        
        <div class="section-title">Salik Details (Abu Dhabi)</div>
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
                    <th width="10%">Amount</th>
                </tr>
            </thead>
            <tbody>
                <s:iterator var="statsalik" status="arr" value='#request.SALIKAUHPRINT'>
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
            <jsp:include page="../../../common/printFooterGlobal.jsp"></jsp:include>
        </div>
    </s:if>

    <s:if test="#trafficdubai > 0"> 
        <div class="page-break"></div>
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <img alt="Dubai Gov Logo" src="<%=contextPath%>/icons/dubaigovlogo.jpg" style="height: 50px;"/>
            <img alt="RTA Logo" src="<%=contextPath%>/icons/rtalogo.jpg" style="height: 50px;"/>
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
            </tbody>
        </table>
        <div class="footer-section">
            <jsp:include page="../../../common/printFooterGlobal.jsp"></jsp:include>
        </div>
    </s:if>

    <s:if test="#trafficelse > 0"> 
        <div class="page-break"></div>
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
                    <th width="10%">Amount</th>
                    <th width="15%">Location</th>
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
            <jsp:include page="../../../common/printFooterGlobal.jsp"></jsp:include>
        </div>
    </s:if>

    <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
    <input type="hidden" name="lblhidheader" id="lblhidheader" value='<s:property value="lblhidheader"/>'/>

</div>

<s:if test="#arr.index!=#request.TRIAL.size-1">
    <div class="page-break"></div>
</s:if>

<s:set name="counter" value="%{#counter+1}" />
</s:iterator>

</form>
</div>
</body>
</html>