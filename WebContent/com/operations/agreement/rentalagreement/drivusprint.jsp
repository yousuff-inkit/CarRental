```html
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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

.signature-wrapper {
    display: flex;
    justify-content: space-between;
    margin-top: 30px;
    gap: 40px;
}

.sig-block {
    flex: 1;
    border: 1px solid var(--border-color);
    padding: 15px;
    border-radius: 4px;
    position: relative;
}

.sig-line {
    border-top: 1px dashed var(--border-color);
    margin-top: 40px;
    padding-top: 5px;
    text-align: left;
    font-weight: bold;
    font-size: 11px;
}

@media print {
    body { padding: 0; }
    .document-container { max-width: 100%; }
    @page { size: A4; margin: 15mm; }
    .page-break { page-break-after: always; }
}
</style> 

<script type="text/javascript">
function gridload(){
    var indexvals = document.getElementById("docnoval").value;
    $("#calcdiv").load("calculationGrid.jsp?rentaldoc="+indexvals);
}

window.onload = function() {
    gridload();
    if(document.getElementById('actualcldocno').value != 0){ 
        document.getElementById('noninvyogo').style.display = 'none';
    }else {
        document.getElementById('invyogo').style.display = 'none';
    }
}
</script>
</head>

<body>
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmInvoicePrint" action="printrental" autocomplete="off" target="_blank">

<div class="document-container">

    <div class="header-section">
        <div style="flex: 0 0 150px;">
            <img src="../../../../icons/epic.jpg" style="width:100%; height:auto;" alt="Logo" />
        </div>
        <div style="flex: 1; text-align: center;">
            <div style="font-size: 18px; font-weight: bold; text-transform: uppercase;">Rental Agreement</div>
            <div style="font-size: 12px; margin-top: 5px;">
                <b>RANO:</b> <label id="rentaldoc" name="rentaldoc"><s:property value="barnchval"/> - <s:property value="rentaldoc"/></label> &nbsp; | &nbsp;
                <b>RA:</b> <label id="rastatus" name="rastatus"><s:property value="rastatus"/></label>
            </div>
        </div>
        <div style="flex: 0 0 250px; text-align: right; font-size: 11px; line-height: 1.5;">
            <div style="font-weight: bold; font-size: 12px;"><label id="companyname" name="companyname"><s:property value="companyname"/></label></div>
            <div><label id="address" name="address"><s:property value="address"/></label></div>
            <div><b>Tel:</b> <label id="mobileno" name="mobileno"><s:property value="mobileno"/></label></div>
            <div><b>Email:</b> <label id="lblindigoemail" name="lblindigoemail"><s:property value="lblindigoemail"/></label></div>
            <div><b>Website:</b> <label id="lblcompwebsite" name="lblcompwebsite"><s:property value="lblcompwebsite"/></label></div>
            <div><b>Branch:</b> <label id="barnchval" name="barnchval"><s:property value="barnchval"/></label></div>
        </div>
    </div>

    <div style="display: flex; gap: 20px;">
        <div style="flex: 1;">
            <div class="section-title">Customer Details</div>
            <div class="info-grid" style="grid-template-columns: 1fr;">
                <div class="grid-row"><span class="grid-label">Name:</span> <span class="grid-value"><label id="clname" name="clname"><s:property value="clname"/></label></span></div>
                <div class="grid-row"><span class="grid-label">Address:</span> <span class="grid-value"><label id="claddress" name="claddress"><s:property value="claddress"/></label></span></div>
                <div class="grid-row"><span class="grid-label">MOB:</span> <span class="grid-value"><label id="clmobno" name="clmobno"><s:property value="clmobno"/></label></span></div>
                <div class="grid-row"><span class="grid-label">Email:</span> <span class="grid-value"><label id="clemail" name="clemail"><s:property value="clemail"/></label></span></div>
            </div>

            <div class="section-title">Driver Details</div>
            <div class="info-grid" style="grid-template-columns: 1fr;">
                <div class="grid-row"><span class="grid-label">Name:</span> <span class="grid-value"><label id="radrname" name="radrname"><s:property value="radrname"/></label></span></div>
                <div class="grid-row"><span class="grid-label">D\L NO:</span> <span class="grid-value"><label id="radlno" name="radlno"><s:property value="radlno"/></label></span></div>
                <div class="grid-row"><span class="grid-label">Exp Date:</span> <span class="grid-value"><label id="lblaccount" name="licexpdate"><s:property value="licexpdate"/></label></span></div>
                <div class="grid-row"><span class="grid-label">EID NO:</span> <span class="grid-value"><label name="lblidno" id="lblidno"><s:property value="lblidno"/></label></span></div>
                <div class="grid-row"><span class="grid-label">Passport NO:</span> <span class="grid-value"><label name="passno" id="passno"><s:property value="passno"/></label></span></div>
                <div class="grid-row" style="display: flex; justify-content: space-between;">
                    <div style="display: flex; flex: 1;">
                        <span class="grid-label" style="width: auto; margin-right: 10px;">Exp Date:</span>
                        <span class="grid-value"><label name="passexpdate" id="passexpdate"><s:property value="passexpdate"/></label></span>
                    </div>
                    <div style="display: flex; flex: 1;">
                        <span class="grid-label" style="width: auto; margin-right: 10px; margin-left: 10px;">DOB:</span>
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
                        <td><b>EID NO</b></td>
                        <td><label id="lbladdid1" name="lbladdid1"><s:property value="lbladdid1"/></label></td>
                        <td><label id="addlicno2" name="addlicno2"><s:property value="addlicno2"/></label></td>
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
                <div style="font-weight: bold; margin-bottom: 5px;">Remarks</div>
                <div><label id="cldesc" name="cldesc"><s:property value="cldesc"/></label></div>
            </div>
        </div>

        <div style="flex: 1;">
            <div class="section-title">Vehicle</div>
            <div class="info-grid" style="grid-template-columns: 1fr;">
                <div class="grid-row"><span class="grid-label">Vehicle:</span> <span class="grid-value"><label id="ravehname" name="ravehname"><s:property value="ravehname"/></label></span></div>
                <div class="grid-row" style="display: flex; justify-content: space-between;">
                    <div style="display: flex; flex: 1;">
                        <span class="grid-label" style="width: auto; margin-right: 10px;">YOM:</span>
                        <span class="grid-value"><label id="rayom" name="rayom"><s:property value="rayom"/></label></span>
                    </div>
                    <div style="display: flex; flex: 1;">
                        <span class="grid-label" style="width: auto; margin-right: 10px; margin-left: 10px;">Color:</span>
                        <span class="grid-value"><label id="racolor" name="racolor"><s:property value="racolor"/></label></span>
                    </div>
                </div>
                <div class="grid-row" style="display: flex; justify-content: space-between;">
                    <div style="display: flex; flex: 1;">
                        <span class="grid-label" style="width: auto; margin-right: 10px;">Reg NO:</span>
                        <span class="grid-value"><label id="ravehregno" name="ravehregno"><s:property value="ravehregno"/></label></span>
                    </div>
                    <div style="display: flex; flex: 1;">
                        <span class="grid-label" style="width: auto; margin-right: 10px; margin-left: 10px;">Group:</span>
                        <span class="grid-value"><label id="ravehgroup" name="ravehgroup"><s:property value="ravehgroup"/></label></span>
                    </div>
                </div>
            </div>

            <div class="section-title">Out Details</div>
            <table class="cr-table">
                <thead>
                    <tr>
                        <th width="20%">Status</th>
                        <th width="20%">Date</th>
                        <th width="15%">Time</th>
                        <th width="15%">Km</th>
                        <th width="15%">Fuel</th>
                        <th width="15%" class="text-center">Signature</th>
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

            <div id="noninvyogo">
                <div class="section-title">Rental Rates</div>
                <table class="cr-table" style="width: 100%;">
                    <tbody>
                        <tr>
                            <td width="50%">Rent Type</td>
                            <td width="50%" class="text-right"><label id="rarenttypes" name="rarenttypes"><s:property value="rarenttypes"/></label></td>
                        </tr>
                        <tr>
                            <td>Tariff</td>
                            <td class="text-right"><label id="tariff" name="tariff"><s:property value="tariff"/></label></td>
                        </tr>
                        <tr>
                            <td>CDW</td>
                            <td class="text-right"><label id="Selcarcdw" name="Selcarcdw"><s:property value="Selcarcdw"/></label></td>
                        </tr>
                        <tr>
                            <td>PAI</td>
                            <td class="text-right"><label id="lblpai" name="lblpai"><s:property value="lblpai"/></label></td>
                        </tr>
                        <tr>
                            <td>Cardoo</td>
                            <td class="text-right"><label id="racardoo" name="racardoo"><s:property value="racardoo"/></label></td>
                        </tr>
                        <tr>
                            <td>Accessories</td>
                            <td class="text-right"><label id="raaccessorysum" name="raaccessorysum"><s:property value="raaccessorysum"/></label></td>
                        </tr>
                        <tr>
                            <td>Delivery Chrges</td>
                            <td class="text-right"><label id="laldelcharge" name="laldelcharge"><s:property value="laldelcharge"/></label></td>
                        </tr>
                        <tr>
                            <td>Add Driver Charge</td>
                            <td class="text-right"><label id="raadditionalcge" name="raadditionalcge"><s:property value="raadditionalcge"/></label></td>
                        </tr>
                        <tr>
                            <td>Chaufer Charge</td>
                            <td class="text-right"><label id="lblchafcharge" name="lblchafcharge"><s:property value="lblchafcharge"/></label></td>
                        </tr>
                        <tr>
                            <td>Restrict KMS</td>
                            <td class="text-right"><label id="raextrakm" name="raextrakm"><s:property value="raextrakm"/></label></td>
                        </tr>
                        <tr>
                            <td>Excess KM Rate</td>
                            <td class="text-right"><label id="raexxtakmchg" name="raexxtakmchg"><s:property value="raexxtakmchg"/></label></td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div id="invyogo">
                <div class="section-title">Rental Rates</div>
                <table class="cr-table" style="width: 100%;">
                    <tbody>
                        <tr>
                            <td width="50%">Rent Type</td>
                            <td width="50%" class="text-center"><label id="rarenttypes" name="rarenttypes"><s:property value="rarenttypes"/></label></td>
                        </tr>
                        <tr>
                            <td>Tariff</td>
                            <td class="text-center">Rates as per your agreement with <s:property value="actualcategory"/></td>
                        </tr>
                        <tr><td>CDW</td><td></td></tr>
                        <tr><td>PAI</td><td></td></tr>
                        <tr><td>Cardoo</td><td></td></tr>
                        <tr><td>Accessories</td><td></td></tr>
                        <tr><td>Delivery Chrges</td><td></td></tr>
                        <tr><td>Add Driver Charge</td><td></td></tr>
                        <tr><td>Chaufer Charge</td><td></td></tr>
                        <tr><td>Restrict KMS</td><td></td></tr>
                        <tr><td>Excess KM Rate</td><td></td></tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div style="background-color: #f9f9f9; border: 1px solid #ddd; padding: 15px; border-radius: 4px; margin-bottom: 20px;">
        <div style="font-weight: bold; margin-bottom: 10px;">Note: Value Added Tax (VAT) will be applicable extra for the rental and other services</div>
        <div class="section-title" style="margin-top: 0;">Terms & Conditions</div>
        <p style="font-size: 11px; line-height: 1.5; text-align: justify; margin-bottom: 20px;">
            I acknowledge in the event of any accident, I will obtain a valid POLICE REPORT. 
            Failure to do so could result in legal action, and further void all insurances, 
            rendering me liable for all cost incurred by the Lessor. This vehicle cannot be taken outside the
            OMAN without the permission of Owner. By this signature, I/ we hereby agree to the Terms & Conditions 
            mentioned on both sides of this agreement.
        </p>

        <div style="display: flex; justify-content: space-between; margin-bottom: 20px; font-weight: bold;">
            <div>Sales Person: <label id="salname" name="salname"><s:property value="salname"/></label></div>
            <div>Rental Agent: <label id="raagent" name="raagent"><s:property value="raagent"/></label></div>
            <div>Customer: <label id="clname" name="clname"><s:property value="clname"/></label></div>
        </div>

        <div class="signature-wrapper">
            <div class="sig-block">
                <div class="sig-line">Rental Agent Signature</div>
                <div style="margin-top: 10px;">Date: <label id="lblcurrentdate" name="lblcurrentdate"><s:property value="lblcurrentdate"/></label></div>
            </div>
            <div class="sig-block">
                <img src='<s:property value="signpath"/>' style="width:100px; height:auto; position:absolute; top: -30px; left: 15px;" />
                <div class="sig-line">Customer Signature</div>
                <div style="margin-top: 10px;">Date: </div>
            </div>
        </div>
    </div>

    <div class="page-break"></div>
    <div style="text-align: center; margin-top: 20px;">
        <img src="drivusterms.jpg" style="max-width: 100%; height: auto;" alt="Terms and Conditions" />
    </div>

    <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
    <input type="hidden" name="docnoval" id="docnoval" value='<s:property value="docnoval"/>' />
    <input type="hidden" name="actualcldocno" id="actualcldocno" value='<s:property value="actualcldocno"/>' />
    
</div>
</form>
</div>
</body>
</html>

```