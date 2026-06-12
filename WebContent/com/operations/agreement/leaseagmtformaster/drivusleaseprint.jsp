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

.warning-box {
    border: 1px solid var(--border-color);
    padding: 10px;
    border-radius: 4px;
    margin-bottom: 15px;
}

@media print {
    body { padding: 0; }
    .document-container { max-width: 100%; }
    @page { margin: 15mm; size: A4; }
}
</style> 
<script type="text/javascript">
function gridload(){
    var indexvals = document.getElementById("docnoval").value;
    $("#calcdiv").load("calculationGrid.jsp?rentaldoc="+indexvals);
}  
</script>
</head>
<body onload="gridload();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmPrintlease" action="printleaseone" autocomplete="off" target="_blank">

<div class="document-container">
    
    <div style="display: flex; justify-content: space-between; align-items: center; padding-bottom: 10px; border-bottom: 2px solid var(--border-color); margin-bottom: 20px;">
        <div style="flex: 0 0 120px;">
            <img src="<%=contextPath%>/icons/epic.jpg" style="width:100%; height:auto;" alt=""/>
        </div>
        <div style="flex: 1; text-align: center;">
            <div style="font-size: 20px; font-weight: bold; text-transform: uppercase;">Lease Agreement</div>
            <div style="font-size: 14px; margin-top: 5px;">
                <b>LANO:</b> <label id="rentaldoc" name="rentaldoc"><s:property value="rentaldoc"/></label> &nbsp; | &nbsp;
                <b>LA:</b> <label id="rastatus" name="rastatus"><s:property value="rastatus"/></label>
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
                <div class="grid-row"><span class="grid-label">Passport NO:</span> <span class="grid-value"><label name="passno" id="passno"><s:property value="passno"/></label></span></div>
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
            
            <div class="warning-box">
                <div class="section-title" style="margin-top: 0;">Accidents</div>
                <p style="margin-bottom: 5px; font-size: 11px; line-height: 1.4; text-align: justify;">By Initialing, you understand any accident, even if you have availed CDW, must be accompanied by a valid police report. Failure to provide one will result in additional charges. Customer who opt out of CDW will be liable to pay the excess deductible.</p>
                <div style="border-top: 1px dashed #ccc; padding-top: 5px; text-align: right; width: 50%; float: right;">Initial</div>
                <div style="clear: both;"></div>
            </div>

            <div class="warning-box">
                <div class="section-title" style="margin-top: 0;">Traffic Fines</div>
                <p style="margin-bottom: 5px; font-size: 11px; line-height: 1.4; text-align: justify;">By putting your initial in box provided, You agree to pay all traffic and parking fines issued to you whilst the vehicle is rented in your name, you also agree to pay a 10% admin charge in addition to the fine.</p>
                <div style="border-top: 1px dashed #ccc; padding-top: 5px; text-align: right; width: 50%; float: right;">Initial</div>
                <div style="clear: both;"></div>
            </div>

            <div class="warning-box">
                <div class="section-title" style="margin-top: 0;">Salik (Road tolls)</div>
                <p style="margin-bottom: 5px; font-size: 11px; line-height: 1.4; text-align: justify;">By putting your initial in the box provided below you agree to pay salik charges of 4 Dhs for each crossing and 1 Dhs admin fee. Total 5 Dhs per crossing.These charges will be added to the end of the rental, or as and when we are notified by the RTA.</p>
                <div style="border-top: 1px dashed #ccc; padding-top: 5px; text-align: right; width: 50%; float: right;">Initial</div>
                <div style="clear: both;"></div>
            </div>

            <div style="text-align: center; font-weight: bold; margin: 20px 0; padding: 10px; background-color: #f0f0f0; border: 1px solid #ccc;">
                VEHICLE INSURED FOR UAE TERRITORY ONLY
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
            <div class="info-grid" style="grid-template-columns: 1fr;">
                <div class="grid-row" style="display: flex; justify-content: space-between;">
                    <div style="display: flex; flex: 1;">
                        <span class="grid-label" style="width: auto; margin-right: 10px;">Date:</span>
                        <span class="grid-value"><label id="radateout" name="radateout"><s:property value="radateout"/></label></span>
                    </div>
                    <div style="display: flex; flex: 1; justify-content: flex-end;">
                        <span class="grid-label" style="width: auto; margin-right: 10px;">Time:</span>
                        <span class="grid-value"><label id="ratimeout" name="ratimeout"><s:property value="ratimeout"/></label></span>
                    </div>
                </div>
                <div class="grid-row" style="display: flex; justify-content: space-between;">
                    <div style="display: flex; flex: 1;">
                        <span class="grid-label" style="width: auto; margin-right: 10px;">KM:</span>
                        <span class="grid-value"><label id="raklmout" name="raklmout"><s:property value="raklmout"/></label></span>
                    </div>
                    <div style="display: flex; flex: 1; justify-content: flex-end;">
                        <span class="grid-label" style="width: auto; margin-right: 10px;">Fuel:</span>
                        <span class="grid-value"><label id="rafuelout" name="rafuelout"><s:property value="rafuelout"/></label></span>
                    </div>
                </div>
            </div>

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

            <div class="section-title">Closing Details</div>
            <div class="info-grid" style="grid-template-columns: 1fr;">
                <div class="grid-row" style="display: flex; justify-content: space-between;">
                    <div style="display: flex; flex: 1;">
                        <span class="grid-label" style="width: auto; margin-right: 10px;">In KM:</span>
                        <span class="grid-value"><label id="inkm" name="inkm"><s:property value="inkm"/></label></span>
                    </div>
                    <div style="display: flex; flex: 1; justify-content: flex-end;">
                        <span class="grid-label" style="width: auto; margin-right: 10px;">In Fuel:</span>
                        <span class="grid-value"><label id="infuel" name="infuel"><s:property value="infuel"/></label></span>
                    </div>
                </div>
                <div class="grid-row" style="display: flex; justify-content: space-between;">
                    <div style="display: flex; flex: 1;">
                        <span class="grid-label" style="width: auto; margin-right: 10px;">In Date:</span>
                        <span class="grid-value"><label id="indate" name="indate"><s:property value="indate"/></label></span>
                    </div>
                    <div style="display: flex; flex: 1; justify-content: flex-end;">
                        <span class="grid-label" style="width: auto; margin-right: 10px;">In Time:</span>
                        <span class="grid-value"><label id="intime" name="intime"><s:property value="intime"/></label></span>
                    </div>
                </div>
            </div>
            
            <div id="calcdiv">
                <jsp:include page="calculationGrid.jsp"></jsp:include>
            </div>

            <div class="section-title">Closing Balance Amount</div>
            <table class="cr-table" style="width: 100%;">
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
                It is important that you have read and understood the terms and conditions that will apply to this contract before singing. Only sign this agreement if you wish to be bound by the terms and conditions over the page. (Arabic translation overleaf is available on the rental wallet) and if you are paying by Credit card, your signature is authorization for Automatic billing. Your signature also allows us to deduct any additional charges pertaining to this contract after the rental agreement has been closed.
            </div>

            <div class="signature-wrapper">
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
            
            <div style="margin-top: 15px; padding: 10px; border: 1px solid #ccc; border-radius: 4px; font-weight: bold; background-color: #f9f9f9; text-align: center;">
                You are responsible for any damage to the vehicle by striking overhanging objects.
            </div>
            
        </div>
    </div>

    <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
    <input type="hidden" name="docnoval" id="docnoval" value='<s:property value="docnoval"/>' />
    
</div>

</form>
</div>
</body>
</html>

