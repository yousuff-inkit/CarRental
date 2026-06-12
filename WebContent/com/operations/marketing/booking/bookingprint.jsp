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

@media print {
    body { padding: 0; }
    .document-container { max-width: 100%; }
    @page { size: A4; margin: 15mm; }
}
</style> 

<script type="text/javascript">
function hidedata() {
	var first = document.getElementById("firstarray").value;
	var sec = document.getElementById("secarray").value;

	if (parseInt(first) == 1) {
		$("#firstdiv").prop("hidden", false);
	} else {
		$("#firstdiv").prop("hidden", true);
	}
	
	if (parseInt(sec) == 2) {
		$("#secdiv").prop("hidden", false);
	} else {
		$("#secdiv").prop("hidden", true);
	}
}
</script>
</head>

<body onload="hidedata();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmqotPrint" action="prqotInvoice" autocomplete="off" target="_blank">

<div class="document-container">

    <jsp:include page="../../../common/printHeader.jsp"></jsp:include>

    <div class="section-title">Customer Information</div>
    <div class="info-grid">
        <div class="grid-row">
            <span class="grid-label">Customer Name:</span>
            <span class="grid-value"><label id="lblclient" name="lblclient"><s:property value="lblclient"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Doc No:</span>
            <span class="grid-value"><label id="docvals" name="docvals"><s:property value="docvals"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Address:</span>
            <span class="grid-value"><label name="lblclientaddress" id="lblclientaddress"><s:property value="lblclientaddress"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Date:</span>
            <span class="grid-value"><label name="lbldate" id="lbldate"><s:property value="lbldate"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">MOB:</span>
            <span class="grid-value"><label name="lblmob" id="lblmob"><s:property value="lblmob"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Fleet:</span>
            <span class="grid-value"><label name="lblfleet" id="lblfleet"><s:property value="lblfleet"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Email:</span>
            <span class="grid-value"><label name="lblemail" id="lblemail"><s:property value="lblemail"/></label></span>
        </div>
        <div class="grid-row" style="border-bottom: none;"></div>
    </div>

    <div class="section-title">Vehicle & Booking Details</div>
    <div class="info-grid">
        <div class="grid-row">
            <span class="grid-label">Brand:</span>
            <span class="grid-value"><label id="lblbrand" name="lblbrand"><s:property value="lblbrand"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">From Date:</span>
            <span class="grid-value"><label id="lblfromdate" name="lblfromdate"><s:property value="lblfromdate"/></label> &nbsp; Time: <label id="lblfromtim" name="lblfromtim"><s:property value="lblfromtim"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Model:</span>
            <span class="grid-value"><label name="lblmodel" id="lblmodel"><s:property value="lblmodel"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">To Date:</span>
            <span class="grid-value"><label id="lbltodate" name="lbltodate"><s:property value="lbltodate"/></label> &nbsp; Time: <label id="lbltotim" name="lbltotim"><s:property value="lbltotim"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Color:</span>
            <span class="grid-value"><label name="lblcolor" id="lblcolor"><s:property value="lblcolor"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Delivery:</span>
            <span class="grid-value"><label name="lbldelivery" id="lbldelivery"><s:property value="lbldelivery"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Group:</span>
            <span class="grid-value"><label name="lblgroup" id="lblgroup"><s:property value="lblgroup"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Chauffeur:</span>
            <span class="grid-value"><label name="lblchauffeur" id="lblchauffeur"><s:property value="lblchauffeur"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Del.Location:</span>
            <span class="grid-value"><label name="lbldellocation" id="lbldellocation"><s:property value="lbldellocation"/></label></span>
        </div>
        <div class="grid-row" style="border-bottom: none;">
             <label hidden="true" name="lblrenttype" id="lblrenttype"><s:property value="lblrenttype"/></label>
        </div>
    </div>

    <div id="firstdiv" hidden="true">
        <div class="section-title">Tariff Details</div>
        <table class="cr-table">
            <thead>
                <tr>
                    <th>Rental Type</th>
                    <th class="text-right">Tariff</th>
                    <th class="text-right">CDW</th>
                    <th class="text-right">SCDW</th>
                    <th class="text-right">GPS</th>
                    <th class="text-right">Child Seat</th>
                    <th class="text-right">Booster</th>
                    <th class="text-right">KM Rest</th>
                    <th class="text-right">Exc KM Rate</th>
                    <th class="text-right">Ins Charge</th>
                    <th class="text-right">Ex. Hr Charge</th>
                </tr>
            </thead>
            <tbody>
                <s:iterator var="stat" value='#request.tariffdetails'>
                <tr>   
                    <%int j=0; %>
                    <s:iterator status="arr" value="#stat.split('::')" var="des">   
                        <% if(j>1){%>
                            <td class="text-right"><s:property value="#des"/></td>
                        <%} else{ %>
                            <td><s:property value="#des"/></td>
                        <% } j++;  %>
                    </s:iterator>
                </tr>
                </s:iterator>
            </tbody>
        </table>
    </div>

    <div id="secdiv" hidden="true"> 
        <div class="section-title">Payment Details</div>
        <table class="cr-table">
            <thead>
                <tr>
                    <th>Payment</th>
                    <th>Mode</th>
                    <th class="text-right">Amount</th>
                    <th>Auth No</th>
                    <th>Card Type</th>
                    <th>Card NO</th>
                    <th>Exp:Date</th>
                    <th>Receipt NO</th>
                </tr>
            </thead>
            <tbody>
                <s:iterator var="stat" value='#request.details'>
                <tr>   
                    <%int i=0; %>
                    <s:iterator status="arr" value="#stat.split('::')" var="des">   
                        <% if(i==2){%>
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

    <div style="margin-top: 30px;">
        <jsp:include page="../../../common/printFooter.jsp"></jsp:include>
    </div>

    <input type="hidden" id="firstarray" name="firstarray" value='<s:property value="firstarray"/>'>  
    <input type="hidden" id="secarray" name="secarray" value='<s:property value="secarray"/>'>
    
</div>

</form>
</div>
</body>
</html>