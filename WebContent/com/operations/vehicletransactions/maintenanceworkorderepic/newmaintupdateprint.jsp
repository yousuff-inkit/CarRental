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
}

.grid-row {
    display: flex;
    align-items: baseline;
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

.vehicle-image-container {
    text-align: center;
    margin: 40px 0;
    padding: 20px;
    border: 1px dashed #ccc;
    border-radius: 8px;
}

.vehicle-image-container img {
    max-width: 50%;
    height: auto;
}

@media print {
    body { padding: 0; }
    .document-container { max-width: 100%; }
    @page { size: A4; margin: 15mm; }
    .vehicle-image-container { border: none; }
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
<form id="fmnq" action="priInvoice" autocomplete="off" target="_blank">

<div class="document-container">

    <jsp:include page="../../../common/printHeader.jsp"></jsp:include>

    <div class="section-title">General Information</div>
    <div class="info-grid">
        <div class="grid-row"><span class="grid-label">Garage Name:</span> <span><label name="lblgarage" id="lblgarage"><s:property value="lblgarage"/></label></span></div>
        <div class="grid-row"><span class="grid-label">Doc No:</span> <span><label id="docvals" name="docvals"><s:property value="docvals"/></label> - <label id="lblbranch" name="lblbranch"><s:property value="lblbranch"/></label></span></div>
        <div class="grid-row"><span class="grid-label">TRN NO:</span> <span><label name="lbltrnno" id="lbltrnno"><s:property value="lbltrnno"/></label></span></div>
        <div class="grid-row" style="display: flex; justify-content: space-between;">
            <div style="display: flex; flex: 1;">
                <span class="grid-label" style="width: auto; margin-right: 10px;">Date:</span>
                <span><label name="lbldate" id="lbldate"><s:property value="lbldate"/></label></span>
            </div>
            <div style="display: flex; flex: 1;">
                <span class="grid-label" style="width: auto; margin-right: 10px; margin-left: 20px;">Time:</span>
                <span><label name="lblmainttime" id="lblmainttime"><s:property value="lblmainttime"/></label></span>
            </div>
        </div>
        <div class="grid-row"><span class="grid-label">INV NO:</span> <span><label name="lblinvo" id="lblinvo"><s:property value="lblinvo"/></label></span></div>
        <div class="grid-row"><span class="grid-label">INV Date:</span> <span><label name="lblinvdate" id="lblinvdate"><s:property value="lblinvdate"/></label></span></div>
    </div>

    <div class="section-title">Vehicle Details</div>
    <div class="info-grid">
        <div class="grid-row"><span class="grid-label">Fleet:</span> <span><label id="lblfleetno" name="lblfleetno"><s:property value="lblfleetno"/></label>&nbsp;&nbsp;<label id="lblfleetname" name="lblfleetname"><s:property value="lblfleetname"/></label></span></div>
        <div class="grid-row"><span class="grid-label">Reg No:</span> <span><label id="lblreg_no" name="lblreg_no"><s:property value="lblreg_no"/></label> - <label id="lblpltid" name="lblpltid"><s:property value="lblpltid"/></label></span></div>
        <div class="grid-row"><span class="grid-label">Type:</span> <span><label name="lblservtype" id="lblservtype"><s:property value="lblservtype"/></label></span></div>
        <div class="grid-row"><span class="grid-label">Engine No:</span> <span><label id="lblengno" name="lblengno"><s:property value="lblengno"/></label></span></div>
        <div class="grid-row"><span class="grid-label">Current KM:</span> <span><label name="lblcurrkm" id="lblcurrkm"><s:property value="lblcurrkm"/></label></span></div>
        <div class="grid-row"><span class="grid-label">Chasis No:</span> <span><label name="lblchasno" id="lblchasno"><s:property value="lblchasno"/></label></span></div>
        <div class="grid-row"><span class="grid-label">Next Ser. Due KM:</span> <span><label name="lblnextserkm" id="lblnextserkm"><s:property value="lblnextserkm"/></label></span></div>
    </div>

    <div id="firstdiv" hidden="true">
        <div class="section-title">Service Details</div>
        <table class="cr-table">
            <thead>
                <tr>
                    <th width="5%" class="text-center">Sl No</th>
                    <th width="15%">Type</th>
                    <th width="35%">Description</th>
                    <th width="15%">Remarks</th>
                    <th width="10%" class="text-right">Labor Cost</th>
                    <th width="10%" class="text-right">Parts Cost</th>
                    <th width="10%" class="text-right">Total</th>
                </tr>
            </thead>
            <tbody>
                <s:iterator var="stat" value='#request.details'>
                <tr>   
                    <%int i=0; %>
                    <s:iterator status="arr" value="#stat.split('::')" var="des">   
                        <% if(i>3){%>
                            <td class="text-right"><s:property value="#des"/></td>
                        <%} else if(i==0){ %>
                            <td class="text-center"><s:property value="#des"/></td>
                        <%} else { %>
                            <td><s:property value="#des"/></td>
                        <% } i++;  %>
                    </s:iterator>
                </tr>
                </s:iterator>
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="4" class="text-right"><b>Total:</b></td> 
                    <td class="text-right"><label id="lblnettotallabour" name="lblnettotallabour"><s:property value="lblnettotallabour"/></label></td>
                    <td class="text-right"><label id="lblnettotalparts" name="lblnettotalparts"><s:property value="lblnettotalparts"/></label></td>
                    <td class="text-right"><b><label id="lblnettotalamount" name="lblnettotalamount"><s:property value="lblnettotalamount"/></label></b></td>
                </tr>
                <tr style="background-color: var(--bg-header);">
                    <td colspan="4" class="text-right"><b>Tax:</b></td> 
                    <td class="text-right"><label id="lbltaxamount" name="lbltaxamount"><s:property value="lbltaxamount"/></label></td>
                    <td class="text-right"><b>NET TOTAL:</b></td>
                    <td class="text-right" style="font-weight: bold; font-size: 12px;"><label id="lblnettaxamount" name="lblnettaxamount"><s:property value="lblnettaxamount"/></label></td>
                </tr>
            </tfoot>
        </table>

        <div class="vehicle-image-container">
            <img src="<%=contextPath%>/icons/replacevehicle.jpg" alt="Vehicle Damage Reference"/>
        </div>
    </div> 

    <div style="margin-top: 30px;">
        <jsp:include page="../../../common/printFooter.jsp"></jsp:include>
    </div>

    <input type="hidden" id="firstarray" name="firstarray" value='<s:property value="firstarray"/>'>  
</div>
</form>
</div>
</body>
</html>

```