```html
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
<style>
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

.page-break {
    page-break-after: always;
}

.border {
  border: 1px solid #ccc;
  padding: 20px;
  margin-top: 20px;
}

p {
	font-size: 11px;
	font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
	text-align: justify;
    line-height: 1.4;
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
.sig-line {
    border-top: 1px dashed var(--border-color);
    margin-top: 40px;
    padding-top: 5px;
    text-align: center;
    font-weight: bold;
    font-size: 11px;
}

@media print {
    body { padding: 0; }
    .document-container { max-width: 100%; }
    @page { margin: 15mm; size: A4; }
    .border { border: none; padding: 0; margin: 0;}
}
</style> 
<script>
function gridload(){
	var indexvals = document.getElementById("docnoval").value;
    $("#calcdiv").load("calculationGrid.jsp?rentaldoc="+indexvals);
}  
</script>
</head>
<body onload="gridload();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmInvoicePrint" action="printrental" autocomplete="off" target="_blank">

<div class="document-container">
    <div>
        <div style="display: flex; justify-content: space-between; align-items: center; padding-bottom: 10px; border-bottom: 2px solid var(--border-color); margin-bottom: 20px;">
            <div style="flex: 0 0 120px;">
                <img src="<%=contextPath%>/icons/epic.jpg" width="150" height="60" alt=""/>
            </div>
            <div style="flex: 1; text-align: center;">
                <div style="font-size: 20px; font-weight: bold; text-transform: uppercase;">Rental Agreement</div>
                <div style="font-size: 14px; margin-top: 5px;">
                    <b>RANO:</b> <label id="rentaldoc" name="rentaldoc"><s:property value="rentaldoc"/></label> &nbsp; | &nbsp;
                    <b>MRA NO:</b> <label id="mrano" name="mrano"><s:property value="mrano"/></label> &nbsp; | &nbsp;
                    <b>RA:</b> <label id="rastatus" name="rastatus"><s:property value="rastatus"/></label>
                </div>
            </div>
            <div style="flex: 0 0 250px; text-align: right; font-size: 11px; line-height: 1.5;">
                <div style="font-weight: bold; margin-bottom: 2px;"><label id="companyname" name="companyname"><s:property value="companyname"/></label></div>
                <div style="margin-bottom: 2px;"><label id="address" name="address"><s:property value="address"/></label></div>
                <div><b>Tel:</b> <label id="mobileno" name="mobileno"><s:property value="mobileno"/></label></div>
                <div><b>Fax:</b> <label id="fax" name="fax"><s:property value="fax"/></label></div>
                <div><b>Branch:</b> <label id="barnchval" name="barnchval"><s:property value="barnchval"/></label></div>
                <div><b>Location:</b> <label id="location" name="location"><s:property value="location"/></label></div>
            </div>
        </div>

        <div style="display: flex; gap: 20px;">
            <div style="flex: 1;">
                <div class="section-title">Customer Details</div>
                <div class="info-grid" style="grid-template-columns: 1fr;">
                    <div class="grid-row" style="grid-column: 1 / -1;">
                        <span class="grid-label">Name:</span>
                        <span class="grid-value"><label id="clname" name="clname"><s:property value="clname"/></label></span>
                    </div>
                    <div class="grid-row" style="grid-column: 1 / -1;">
                        <span class="grid-label">Address:</span>
                        <span class="grid-value"><label id="claddress" name="claddress"><s:property value="claddress"/></label></span>
                    </div>
                    <div class="grid-row">
                        <span class="grid-label">MOB:</span>
                        <span class="grid-value"><label id="clmobno" name="clmobno"><s:property value="clmobno"/></label></span>
                    </div>
                    <div class="grid-row">
                        <span class="grid-label">Email:</span>
                        <span class="grid-value"><label id="clemail" name="clemail"><s:property value="clemail"/></label></span>
                    </div>
                </div>

                <div class="section-title">Driver Details</div>
                <div class="info-grid" style="grid-template-columns: 1fr;">
                    <div class="grid-row" style="grid-column: 1 / -1;">
                        <span class="grid-label">Name:</span>
                        <span class="grid-value"><label id="radrname" name="radrname"><s:property value="radrname"/></label></span>
                    </div>
                    <div class="grid-row">
                        <span class="grid-label">D\L NO:</span>
                        <span class="grid-value"><label id="radlno" name="radlno"><s:property value="radlno"/></label></span>
                    </div>
                    <div class="grid-row">
                        <span class="grid-label">Exp Date:</span>
                        <span class="grid-value"><label id="lblaccount" name="licexpdate"><s:property value="licexpdate"/></label></span>
                    </div>
                    <div class="grid-row" style="grid-column: 1 / -1;">
                        <span class="grid-label">Passport NO:</span>
                        <span class="grid-value"><label name="passno" id="passno"><s:property value="passno"/></label></span>
                    </div>
                    <div class="grid-row" style="display: flex; justify-content: space-between;">
                        <div style="display: flex; flex: 1;">
                            <span class="grid-label" style="width: auto; margin-right: 10px;">Exp Date:</span>
                            <span class="grid-value"><label name="passexpdate" id="passexpdate"><s:property value="passexpdate"/></label></span>
                        </div>
                        <div style="display: flex; flex: 1; justify-content: flex-end;">
                            <span class="grid-label" style="width: auto; margin-right: 10px;">DOB:</span>
                            <span class="grid-value"><label name="dobdate" id="dobdate"><s:property value="dobdate"/></label></span>
                        </div>
                    </div>
                </div>

                <div class="section-title">Additional Driver Details</div>
                <table class="cr-table">
                    <thead>
                        <tr>
                            <th width="20%">Details</th>
                            <th width="40%">Driver One</th>
                            <th width="40%">Driver Two</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><b>Name</b></td>
                            <td><label id="adddrname1" name="adddrname1"><s:property value="adddrname1"/></label></td>
                            <td><label id="adddrname2" name="adddrname2"><s:property value="adddrname2"/></label></td>
                        </tr>
                        <tr>
                            <td><b>D\L NO</b></td>
                            <td><label id="addlicno1" name="addlicno1"><s:property value="addlicno1"/></label></td>
                            <td><label id="addlicno2" name="addlicno2"><s:property value="addlicno2"/></label></td>
                        </tr>
                        <tr>
                            <td><b>Exp Date</b></td>
                            <td><label id="expdate1" name="expdate1"><s:property value="expdate1"/></label></td>
                            <td><label id="expdate2" name="expdate2"><s:property value="expdate2"/></label></td>
                        </tr>
                        <tr>
                            <td><b>DOB</b></td>
                            <td><label id="adddob1" name="adddob1"><s:property value="adddob1"/></label></td>
                            <td><label id="adddob2" name="adddob2"><s:property value="adddob2"/></label></td>
                        </tr>
                    </tbody>
                </table>
                
                <div style="border: 1px solid var(--border-color); padding: 10px; border-radius: 4px; margin-bottom: 15px;">
                    <div class="section-title" style="margin-top: 0;">Accidents</div>
                    <p style="margin-bottom: 5px;">By initialing, I understand that in case of accident, even though availed CDW, must be accompanied by a valid police report. If without CDW, I will be liable to pay excess deductible amount of AED <label id="excessinsu" name="excessinsu" style="font-weight: bold;"><s:property value="excessinsu"/></label>.</p>
                    <div style="border-top: 1px dashed #ccc; padding-top: 5px; text-align: right; width: 50%; float: right;">Initial</div>
                    <div style="clear: both;"></div>
                </div>

                <div style="border: 1px solid var(--border-color); padding: 10px; border-radius: 4px; margin-bottom: 15px;">
                    <div class="section-title" style="margin-top: 0;">Traffic/Parking Fines/Salik (Toll) / Tax</div>
                    <p style="margin-bottom: 5px;">By initialing, I agree to pay all traffic/parking/other fines/tax plus AED <label id="trafficcharge" style="font-weight: bold;"><s:property value="trafficcharge"/></label>/- per fine and plus AED <label id="salikcharge" style="font-weight: bold;"><s:property value="salikcharge"/></label>/- per Salik crossing as surcharge, occurring during the agreement period.</p>
                    <div style="border-top: 1px dashed #ccc; padding-top: 5px; text-align: right; width: 50%; float: right;">Initial</div>
                    <div style="clear: both;"></div>
                </div>
            </div>

            <div style="flex: 1;">
                <div class="section-title">Vehicle Details</div>
                <div class="info-grid" style="grid-template-columns: 1fr;">
                    <div class="grid-row">
                        <span class="grid-label">Vehicle:</span>
                        <span class="grid-value"><label id="ravehname" name="ravehname"><s:property value="ravehname"/></label></span>
                    </div>
                    <div class="grid-row" style="display: flex; justify-content: space-between;">
                        <div style="display: flex; flex: 1;">
                            <span class="grid-label" style="width: auto; margin-right: 10px;">YOM:</span>
                            <span class="grid-value"><label id="rayom" name="rayom"><s:property value="rayom"/></label></span>
                        </div>
                        <div style="display: flex; flex: 1;">
                            <span class="grid-label" style="width: auto; margin-right: 10px;">Color:</span>
                            <span class="grid-value"><label id="racolor" name="racolor"><s:property value="racolor"/></label></span>
                        </div>
                    </div>
                    <div class="grid-row" style="display: flex; justify-content: space-between;">
                        <div style="display: flex; flex: 1;">
                            <span class="grid-label" style="width: auto; margin-right: 10px;">Reg NO:</span>
                            <span class="grid-value"><label id="ravehregno" name="ravehregno"><s:property value="ravehregno"/></label></span>
                        </div>
                        <div style="display: flex; flex: 1;">
                            <span class="grid-label" style="width: auto; margin-right: 10px;">Group:</span>
                            <span class="grid-value"><label id="ravehgroup" name="ravehgroup"><s:property value="ravehgroup"/></label></span>
                        </div>
                    </div>
                </div>

                <div class="section-title">Out Details</div>
                <table class="cr-table">
                    <thead>
                        <tr>
                            <th>Status</th>
                            <th>Date</th>
                            <th>Time</th>
                            <th>Km</th>
                            <th>Fuel</th>
                            <th>Signature</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><b><label id="outdetails" name="outdetails"><s:property value="outdetails"/></label></b></td>
                            <td><label id="radateout" name="radateout"><s:property value="radateout"/></label></td>
                            <td><label id="ratimeout" name="ratimeout"><s:property value="ratimeout"/></label></td>
                            <td><label id="raklmout" name="raklmout"><s:property value="raklmout"/></label></td>
                            <td><label id="rafuelout" name="rafuelout"><s:property value="rafuelout"/></label></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td><b><label id="deldetailss" name="deldetailss"><s:property value="deldetailss"/></label></b></td>
                            <td><label id="deldates" name="deldates"><s:property value="deldates"/></label></td>
                            <td><label id="deltimes" name="deltimes"><s:property value="deltimes"/></label></td>
                            <td><label id="delkmins" name="delkmins"><s:property value="delkmins"/></label></td>
                            <td><label id="delfuels" name="delfuels"><s:property value="delfuels"/></label></td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>

                <div class="section-title">Rental Rates</div>
                <table class="cr-table" style="width: 100%;">
                    <tbody>
                        <tr>
                            <td width="35%"><b><label id="rarenttypes" name="rarenttypes"><s:property value="rarenttypes"/></label> Tariff</b></td>
                            <td width="15%" class="text-right"><label id="tariff" name="tariff"><s:property value="tariff"/></label></td>
                            <td width="35%"><b>CDW</b></td>
                            <td width="15%" class="text-right"><label id="racdwscdw" name="racdwscdw"><s:property value="racdwscdw"/></label></td>
                        </tr>
                        <tr>
                            <td><b>Accessories</b></td>
                            <td class="text-right"><label id="raaccessory" name="raaccessory"><s:property value="raaccessory"/></label></td>
                            <td><b>Add Driver Charges</b></td>
                            <td class="text-right"><label id="raadditionalcge" name="raadditionalcge"><s:property value="raadditionalcge"/></label></td>
                        </tr>
                        <tr>
                            <td><b>Extra KM</b></td>
                            <td class="text-right"><label id="raextrakm" name="raextrakm"><s:property value="raextrakm"/></label></td>
                            <td><b>Extra KM Charge</b></td>
                            <td class="text-right"><label id="raexxtakmchg" name="raexxtakmchg"><s:property value="raexxtakmchg"/></label></td>
                        </tr>
                    </tbody>
                </table>

                <div class="section-title">In Details</div>
                <table class="cr-table">
                    <thead>
                        <tr>
                            <th>Status</th>
                            <th>Date</th>
                            <th>Time</th>
                            <th>Km</th>
                            <th>Fuel</th>
                            <th>Signature</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><b><label id="indetails" name="indetails"><s:property value="indetails"/></label></b></td>
                            <td><label id="indate" name="indate"><s:property value="indate"/></label></td>
                            <td><label id="intime" name="intime"><s:property value="intime"/></label></td>
                            <td><label id="inkm" name="inkm"><s:property value="inkm"/></label></td>
                            <td><label id="infuel" name="infuel"><s:property value="infuel"/></label></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td><b><label id="coldetails" name="coldetails"><s:property value="coldetails"/></label></b></td>
                            <td><label id="coldates" name="coldates"><s:property value="coldates"/></label></td>
                            <td><label id="coltimes" name="coltimes"><s:property value="coltimes"/></label></td>
                            <td><label id="colkmins" name="colkmins"><s:property value="colkmins"/></label></td>
                            <td><label id="colfuels" name="colfuels"><s:property value="colfuels"/></label></td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div style="text-align: center; font-weight: bold; margin-bottom: 20px; padding: 10px; background-color: #f0f0f0; border: 1px solid #ccc;">
            VEHICLE INSURED FOR UAE TERRITORY ONLY
        </div>

        <div id="calcdiv">
            <jsp:include page="calculationGrid.jsp"></jsp:include>
        </div>

        <div class="section-title">Closing Balance Amount</div>
        <table class="cr-table" style="width: 50%;">
            <tbody>
                <tr>
                    <td width="50%"><b>Total Receipt</b></td>
                    <td width="50%" class="text-right"><label id="totalpaids" name="totalpaids"><s:property value="totalpaids"/></label></td>
                </tr>
                <tr>
                    <td><b>Invoice Amount</b></td>
                    <td class="text-right"><label id="invamount" name="invamount"><s:property value="invamount"/></label></td>
                </tr>
                <tr style="background-color: #f0f0f0;">
                    <td><b>Balance</b></td>
                    <td class="text-right" style="font-weight: bold;"><label id="balance" name="balance"><s:property value="balance"/></label></td>
                </tr>
            </tbody>
        </table>

        <div style="margin-top: 20px; font-size: 11px; line-height: 1.4; text-align: justify; border-top: 1px solid #ccc; padding-top: 10px;">
            I have read and understood the terms & conditions above and overleaf and agree with my signature to the same and acknowledge that a) Disclaimer b) Credit Card Authorization c) Vehicle Checklist (for original and replacement vehicles) are part of this agreement.
        </div>

        <div class="signature-wrapper" style="margin-top: 30px;">
            <div class="sig-block">
                <div style="font-weight: bold; margin-bottom: 10px; border-bottom: 1px solid #ccc; padding-bottom: 5px;">Customer Signature</div>
                <div style="height: 40px;"></div>
                <div class="sig-line">Date</div>
            </div>
            <div class="sig-block">
                <div style="font-weight: bold; margin-bottom: 10px; border-bottom: 1px solid #ccc; padding-bottom: 5px;">Rental Agent</div>
                <div style="height: 40px;"></div>
                <div class="sig-line">Date</div>
            </div>
        </div>
    </div>

    <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
    <input type="hidden" name="docnoval" id="docnoval" value='<s:property value="docnoval"/>' />
    
</div>
</form>
</div>
</div>
</body>
</html>

```