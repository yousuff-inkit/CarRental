```html
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
 <%@ page pageEncoding="utf-8" %>
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
                <div style="font-size: 20px; font-weight: bold; text-transform: uppercase;">Lease Agreement</div>
                <div style="font-size: 14px; margin-top: 5px;">
                    <b>RANO:</b> <label id="rentaldoc" name="rentaldoc"><s:property value="rentaldoc"/></label> &nbsp; | &nbsp;
                    <b>MRA NO:</b> <label id="mrano" name="mrano"><s:property value="mrano"/></label> &nbsp; | &nbsp;
                    <b>RA Status:</b> <label id="rastatus" name="rastatus"><s:property value="rastatus"/></label>
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

        <div class="section-title">Customer Details</div>
        <div class="info-grid">
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
        <div class="info-grid">
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
            <div class="grid-row">
                <span class="grid-label">Exp Date:</span>
                <span class="grid-value"><label name="passexpdate" id="passexpdate"><s:property value="passexpdate"/></label></span>
            </div>
            <div class="grid-row">
                <span class="grid-label">DOB:</span>
                <span class="grid-value"><label name="dobdate" id="dobdate"><s:property value="dobdate"/></label></span>
            </div>
        </div>

        <div class="section-title">Additional Driver Details</div>
        <table class="cr-table" style="margin-bottom: 20px;">
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

        <div style="display: flex; gap: 20px; margin-bottom: 20px;">
            <div style="flex: 1; border: 1px solid var(--border-color); padding: 10px; border-radius: 4px;">
                <div class="section-title" style="margin-top: 0;">Accidents</div>
                <p>By initialing, I understand that in case of accident, even though availed CDW, must be accompanied by a valid police report. If without CDW, I will be liable to pay excess deductible amount of AED <label id="excessinsu" name="excessinsu" style="font-weight: bold;"><s:property value="excessinsu"/></label>.</p>
                <div style="border-top: 1px dashed #ccc; margin-top: 20px; padding-top: 5px; text-align: right;">Initial</div>
            </div>
            <div style="flex: 1; border: 1px solid var(--border-color); padding: 10px; border-radius: 4px;">
                <div class="section-title" style="margin-top: 0;">Traffic/Parking Fines/Salik (Toll)/Tax</div>
                <p>By initialing, I agree to pay all traffic/parking/other fines/Tax plus AED <label id="trafficcharge" style="font-weight: bold;"><s:property value="trafficcharge"/></label>/- per fine and plus AED <label id="salikcharge" style="font-weight: bold;"><s:property value="salikcharge"/></label>/- per Salik crossing as surcharge, occurring during the agreement period.</p>
                <div style="border-top: 1px dashed #ccc; margin-top: 20px; padding-top: 5px; text-align: right;">Initial</div>
            </div>
        </div>
        
        <div style="text-align: center; font-weight: bold; margin-bottom: 20px; padding: 10px; background-color: #f0f0f0; border: 1px solid #ccc;">
            VEHICLE INSURED FOR UAE TERRITORY ONLY
        </div>

        <div style="display: flex; gap: 20px;">
            <div style="flex: 1;">
                <div class="section-title">Vehicle Details</div>
                <div class="info-grid" style="grid-template-columns: 1fr;">
                    <div class="grid-row">
                        <span class="grid-label">Vehicle:</span>
                        <span class="grid-value"><label id="ravehname" name="ravehname"><s:property value="ravehname"/></label></span>
                    </div>
                    <div class="grid-row">
                        <span class="grid-label">YOM:</span>
                        <span class="grid-value"><label id="rayom" name="rayom"><s:property value="rayom"/></label></span>
                    </div>
                    <div class="grid-row">
                        <span class="grid-label">Color:</span>
                        <span class="grid-value"><label id="racolor" name="racolor"><s:property value="racolor"/></label></span>
                    </div>
                    <div class="grid-row">
                        <span class="grid-label">Reg NO:</span>
                        <span class="grid-value"><label id="ravehregno" name="ravehregno"><s:property value="ravehregno"/></label></span>
                    </div>
                    <div class="grid-row">
                        <span class="grid-label">Group:</span>
                        <span class="grid-value"><label id="ravehgroup" name="ravehgroup"><s:property value="ravehgroup"/></label></span>
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
            </div>

            <div style="flex: 1;">
                <div class="section-title">Rental Rates</div>
                <table class="cr-table" style="width: 100%;">
                    <tbody>
                        <tr>
                            <td width="50%"><b>Rent Type</b></td>
                            <td width="50%" class="text-right"><label id="rarenttypes" name="rarenttypes"><s:property value="rarenttypes"/></label></td>
                        </tr>
                        <tr>
                            <td><b>Tariff</b></td>
                            <td class="text-right"><label id="tariff" name="tariff"><s:property value="tariff"/></label></td>
                        </tr>
                        <tr>
                            <td><b>CDW</b></td>
                            <td class="text-right"><label id="racdwscdw" name="racdwscdw"><s:property value="racdwscdw"/></label></td>
                        </tr>
                        <tr>
                            <td><b>PAI</b></td>
                            <td class="text-right"><label id="lblpai" name="lblpai"><s:property value="lblpai"/></label></td>
                        </tr>
                        <tr>
                            <td><b>Accessories</b></td>
                            <td class="text-right"><label id="raaccessory" name="raaccessory"><s:property value="raaccessory"/></label></td>
                        </tr>
                        <tr>
                            <td><b>Delivery Charges</b></td>
                            <td class="text-right"><label id="laldelcharge" name="laldelcharge"><s:property value="laldelcharge"/></label></td>
                        </tr>
                        <tr>
                            <td><b>Add Driver Charge</b></td>
                            <td class="text-right"><label id="raadditionalcge" name="raadditionalcge"><s:property value="raadditionalcge"/></label></td>
                        </tr>
                        <tr>
                            <td><b>Chaufer Charge</b></td>
                            <td class="text-right"><label id="lblchafcharge" name="lblchafcharge"><s:property value="lblchafcharge"/></label></td>
                        </tr>
                        <tr>
                            <td><b>Restrict KMS</b></td>
                            <td class="text-right"><label id="raextrakm" name="raextrakm"><s:property value="raextrakm"/></label></td>
                        </tr>
                        <tr>
                            <td><b>Excess KM Rate</b></td>
                            <td class="text-right"><label id="raexxtakmchg" name="raexxtakmchg"><s:property value="raexxtakmchg"/></label></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div style="width: 50%; margin-left: auto;">
            <div class="section-title">Closing Balance Amount</div>
            <table class="cr-table">
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
        </div>

        <div style="margin-top: 20px; font-size: 10px; line-height: 1.4;">
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

    <div class="page-break"></div>

    <div class="border">
        <div style="text-align: center; margin-bottom: 20px;">
            <img src="<%=contextPath%>/icons/epic.jpg" width="300" alt=""/>
            <h3 style="text-decoration: underline; margin-top: 10px;">STANDARD TERMS AND CONDITIONS OF RENTAL / LEASE</h3>
        </div>

        <p>The Lessor mentioned overleaf, in the following called PROGRESS rent a car (PRAC), hereby rents/leases the vehicle indentified overleaf to Renter/Lessee subject to all Terms and Conditions on the front page and this page and Renter/Lessee on consideration thereof agrees to them as the essence of the Agreement.</p>

        <p><b>1. <u>Delivery and Return:</u></b> The vehicle is delivered to the Client/Driver in good overall condition and without apparent defects and complaints as to its condition must be made known to the Lessor immediately on delivery. The Client/Driver agrees to return it with all documents and accessories and in the same condition to the Lessor at the location and on the date designated in this Agreement. The Lessor reserves the right to repossess the vehicle at any time without demand at Renter's expense if vehicle is used in violation of this Agreement.</p>

        <p><b>2. <u>Age and Driving License:</u></b> Minimum age of Driver to be 25 years. Driving license to be one year old. UAE residents can drive with UAE driving license only. Visit/tourist visa holders can drive with International License that are valid in UAE, if their home country license is more than one year old.</p>

        <p><b>3. <u>Damage, Accident, Loss, Theft, etc.:</u></b> In the event of damage to or loss or theft of the vehicle or parts of it, including fire and breakage of glass, the Renter/Lessee shall, irrespective of his/her or the driver's fault, pay to the Lessor the amount of all resulting loss and expenses of the Lessor (including but not limited to replacement or recovery costs, repair costs, compensation for decline in value and loss of the rental/lease fee) if the Renter/Lessee or the driver violated these Standard Terms and Conditions of Rental/Lease Agreement, any legal provisions (also customs regulations) or insurance regulations. As loss of revenue, the Lessor may charge a compensation corresponding to the rental/lease charge, until the day the vehicle or a replacement vehicle will again be available to the Lessor. This liability of the Renter/Lessee may be limited, if Renter/Lessee accepts Collision Damage Waiver according to Clause 8 by placing his/her initials in the space "Accept" on the front page, provided that the Renter/Lessee complies in all other respects with the Terms and Conditions of this Rental/Lease Agreement. In case of an accident (with or without damage to the vehicle) and in case of any personal injuries, the police must be called to the scene of the event and Renter/Lessee must insist on obtaining a Police Report. In case of theft of the vehicle or Parts of it, Renter/Lessee must report this to the police and obtain a Police Report and forward the said Police Report to the Lessor. Any accident or damage or loss or theft of the vehicle must be reported to the Lessor immediately. Upon request of the Lessor, an accident report must be completed. Renter/Lessee must secure all data of all other parties as well as of any witnesses in order to complete said accident report. Under no circumstances, claims by third parties must be accepted by the Renter/Lessee. The Renter/Lessee is obliged to assist the Lessor and/or its insurance companies in all claims or legal affairs in connection with an accident or any damage. These responsibilities of the Renter/Lessee shall apply accordingly in case of theft. No repairs are to be carried out on the vehicle without the prior approval of the Lessor. If the Renter/Lessee violates any of these regulations, especially if no Police Report can be presented to the Lessor within 24 hours, even an accepted and paid CDW may not release Renter/Lessee from indemnities.</p>

        <p><b>4. <u>Replacement vehicle:</u></b> Lessor will provide a suitable replacement vehicle for the duration of maintenance, servicing and damage repairs of the original vehicle. The type of vehicle will be the closest available group from the daily rental fleet. A replacement vehicle for any damaged vehicle will only be supplied, following the submission of a Police Report. Replacement vehicle may not be available if the rental/lease vehicle is returned to the Lessor for normal general service just before public holidays or weekends. Renter/Lessee undertakes to monitor and bring the vehicle for periodic maintenance/repairs and registration with prior appointment. Renter/Lessee is responsible for collecting the vehicle within a maximum of 24 hours after being informed of the completion of repairs, failing which Lessee is liable to pay daily tariff rental rate, as additional charge for delaying the return of replacement vehicle, until such time the replacement vehicle has been returned to the Lessor. In the event of the leased vehicle being rendered totally unfit for use, Lessor shall at its own discretion either provide the Renter/Lessee with a replacement vehicle or issue a credit note if applicable or otherwise release the Renter/Lessee from its payment obligations under this Agreement. Fuel used for rental/lease replacement/original vehicle/s + fuel used for original/replacement vehicle/s transfer to and from garage for service/maintenance/repair, will be paid by the Renter / Lessee. For frequent accidents, the number of total replacement days per annum is limited to 14-21 days.</p>

        <p><b>5. <u>Charges:</u></b> Client/Driver shall pay any charges shown on the front page or mentioned in the current tariffs including Rental, VAT, other taxes, cost of fuel, Mawaqif, Salik (AED 5 p/crossing. Subject to change if Salik charge increased by local authorities), RTA, Traffic Fines, SAAED, Municipality and respective service charge fees (AED 25 p/fine). If required by the Lessor, Client/Driver undertakes to clear black points/fines directly with the authority immediately, without any delay and inform Lessor accordingly. Cleaning charges from AED 50-500 is applicable in case the vehicle is returned stained/ dirty.</p>

        <p><b>6. <u>Payment Terms:</u></b> Lease advance - monthly. Monthly mini lease: monthly advance+ pre-authorization for the following month. Daily/weekly rental: advance for entire rental duration. All the above categories will also require a pre-authorization/cash deposit of a minimum of AED 1,000 to cover Salik, RTA, Mawaqif, Traffic fines, SAAED, etc. Lessor has the right to terminate the contract and take possession of the vehicle at the expense of the Renter/Lessee in case charges (rental, fines, Salik) are not cleared within 7 (seven) days of due date. For delayed payment: Late payment fee will be charged at 1.5% per month of total outstanding.</p>

        <p><b>7. <u>Invoice Submission:</u></b> Invoice will be submitted to the Client / client by beginning of every month as per the agreed invoice rules.</p>

        <p><b>8. <u>Indemnity:</u></b> The Lessor is only responsible for loss or damage suffered by Renter/Lessee or Third Parties - limited to PRAC Insurance Policy -, in connection with the renting /leasing or the rented /leased vehicle, where such loss or damage was caused intentionally or through gross negligence on its part. In all cases, the Lessor cannot accept any such liability and Renter/Lessee shall hold the Lessor harmless against such claims. The Renter/Lessee shall indemnify and hold harmless the Lessor, its employees and agents from and against any loss, liability and expense arising directly in or directly from: a) any breach of terms of this Agreement by Renter/Lessee; b) loss of or damage to the vehicle (save as provided in clause 2.); c) death or injury to any person arising out of the operation or usage of the vehicle; d) loss of or damage to any property suffered by Renter/Lessee or by third parties arising out of the operation or usage of the vehicle or for loss of or damage to Renters/Lessees property left in the vehicle or for loss or inconvenience resulting from delivery delays, breakdown or any cause beyond Lessor's control.</p>

        <p><b>9. <u>Conditions of use:</u></b> The Renter/Lessee is expected to look after the vehicle carefully and in particular not allow it to be used: a) to carry persons or property for hire, except in the case of trucks and vans; b) to propel or tow any vehicle, trailer or other object; c) in any race, test or contest, or off-road/through water driving; d) while Renter/ Lessee or any other driver of vehicle is under the influence of alcohol, hallucinatory drugs, narcotics, barbiturates or any other substance impairing his/her consciousness or ability to react; e) in contravention of any customs, traffic, insurance policy or other regulations; f) by any person other than Renter/Lessee unless such person has been previously designated by the Lessor in the space provided on the front page of this Agreement; g) outside the country of rental unless otherwise pre-authorized by written permission of the Lessor, h) in geographical areas which have been defined by the Lessor as restricted ones, i) the Renter/Lessee undertakes to make sure of the car condition by periodically checking of the oil, water, tire pressure and inform the Lessor of any mechanical, electrical or tire problem. The Renter/Lessee needs to report to the Lessor any signal that appears on the car screen for warning of any type of maintenance. The Renter/Lessee shall bear any damages as a result of driver misuse, including an administration fee (min. AED 25 up to 10% of the total repair cost) from not reporting this fault and continuing to drive the vehicle. Tire replacement due to Renter's/Lessee's negligence and punctures will be at the Renter's/Lessee's and expense in this case' replacement vehicle shall not be provided. J) Renter/Lessee is aware of the obligation to follow Road Traffic Rules, m case of any traffic offence occurs, Renter/Lessee agrees to pay the company the compensation amount for vehicle if impounded by the police + the respective fines and black points for each such occurrence during the time of rental period + agrees to accept any transferrable fines/black points. Agrees to if necessary and without delay, to visit the respective traffic department to clear any fines/black points. Tinting of rented/leased vehicle is strictly prohibited by UAE authorities. Fines are responsibility of Renter/Lessee.</p>

        <p><b>10. <u>Insurance:</u></b> The Lessor provides insurance coverage for the authorized persons using the vehicle with its permission (and not otherwise) in accordance with an automobile liability insurance policy, which is available for inspection upon written request, and this will form part of this Agreement. Collision Damage Waiver (CDW): By placing his/her initials in the space "Accept" on the front page, the Renter/Lessee assumes the obligation to payment of a supplementary fee in accordance with valid price list. Otherwise in case of damages to or loss or theft of the vehicle or parts of it, Renter/Lessee shall be liable to pay an insurance excess as per valid price list, unless otherwise specified, in accordance with Clause 2 of these Standard Terms and Conditions of Rental/Lease Agreement. The Collision Damage Waiver does not exempt from liability in case of negligence or contravention of the rental/lease conditions, legal regulations or insurance conditions. Personal Accident Insurance (PAI): By placing his/her initials in the space Accept on the front page, the Renter/Lessee agrees to pay an additional fee as per valid price list. Driver's age 23-25 years or driving license less than one year damage at fault or without 3rd party 10% of total repair cost with a minimum of AED 1,000 is the Renter's /Lessee's responsibility.</p>

        <p><b>11. <u>Identification marks:</u></b> The Renter/Lessee is authorized to place any identification marks it deems necessary or desirable on the leased vehicle and such marks should be added in such a way that they can be easily removed without effecting the vehicle's ex-or interior condition or causing any damage. Renter/Lessee is responsible to inform the Lessor in writing prior to obtaining the necessary permit/s from the authorities concerned and pay any fees or charges related to obtaining such permit/s. Placement and removal of such marks shall be at the Renter/Lessee's expense.</p>

        <p><b>12. <u>Mileage:</u></b> Unless otherwise specified, the following applies, the mileage is agreed to be unlimited up to a maximum of: a) 40,000 km per annum (yearly lease), b) 4,000 km per month (mini lease), c) 1,000 km per week (weekly rental), d) 200 km per day (daily rental). Any mileage that is more than 10% in excess of the maximum cap will be subject to an excess mileage charge at a rate of 0.25 AED per kilometer, this charge will be applied periodically as per the contract duration where relevant.</p>

        <p><b>13. <u>Documents:</u></b> Credit card authorization letter, Disclaimer form and Vehicle check in/out forms and any other documents issued will form integral part of this rental agreement.</p>

        <p><b>14. <u>Personal Data:</u></b> The Renter/Lessee acknowledges that the personal data on the Rental/Lease Agreement will be kept as part of the Lessor's database. The Renter/Lessee agrees expressly that the data can be communicated to third parties, especially for credit protection purposes. The Renter/Lessee commits to immediately inform the Lessor of any change to contact/personal data details.</p>

        <p><b>15. <u>Governing Law & Jurisdiction:</u></b> This agreement in all respects be governed by and be construed and interpreted and take effect in accordance with the law of the United Arab Emirates, applicable to the Emirate of Abu Dhabi and the parties hereto irrevocably submit to the non exclusive jurisdiction of the courts of such Emirate.</p>

        <p><b>16. <u>Language:</u></b> The language acceptable for this contract is English only unless the court of law demands legal Arabic translation.</p>

        <div style="text-align: center; color: #a52a2a; font-weight: bold; margin-top: 20px; font-size: 14px;">
            SAFETY FIRST! SAFETY FIRST! SAFETY FIRST! SAFETY FIRST! SAFETY FIRST!
        </div>

        <div style="display: flex; justify-content: space-between; margin-top: 20px; background-color: #f9f9f9; padding: 15px; border-radius: 5px;">
            <ul style="list-style-type: square; margin: 0; padding-left: 20px; font-size: 11px; line-height: 1.6; flex: 1;">
                <li>Always fasten your seat belt.</li>
                <li>Drive with stipulated speed limits.</li>
                <li>Cross traffic junction only when green.</li>
                <li>Do not seat young children in the front.</li>
                <li>Do not enter the left yellow line (hard shoulder).</li>
                <li>Overtake only from left and always use indicator.</li>
            </ul>
            <ul style="list-style-type: square; margin: 0; padding-left: 20px; font-size: 11px; line-height: 1.6; flex: 1;">
                <li>Obey traffic instructions & be watchful of road signs.</li>
                <li>Never drive after consuming any narcotic substances.</li>
                <li>Do not carry inflammable, hazardous materials in your vehicle.</li>
                <li>Avoid using mobile phone while driving. If you must, always use hands-free.</li>
                <li>Ensure tires, brakes, head & brake lights + side indicators are in good working condition.</li>
                <li>Think ahead and do not make impulsive deviations. Change lanes only after indicating your move.</li>
            </ul>
        </div>
        <div style="text-align: center; color: #191970; font-weight: bold; margin-top: 15px;">
            The PRAC Team wishes you safe driving!
        </div>
    </div>

    <div class="page-break"></div>

    <div class="border">
        <div style="text-align: center; margin-bottom: 30px;">
            <img src="<%=contextPath%>/icons/epic.jpg" width="300" alt=""/>
        </div>

        <div style="font-size: 13px; line-height: 2;">
            <b>From:</b> <u style="font-weight: bold;"><label id="clname" name="clname"><s:property value="clname"/></label></u><br><br>
            <b>To:</b> PROGRESS rent a car
        </div>

        <div style="text-align: center; font-size: 18px; font-weight: bold; text-decoration: underline; margin: 30px 0;">
            Authorization Letter
        </div>

        <div style="font-size: 12px; line-height: 1.8;">
            I hereby authorize PROGRESS rent a car to charge my credit card no: <b><label id="lbcardno" name="lbcardno"><s:property value="lbcardno"/></label></b>
            <br>
            Expiry Date: <b><label id="lbexpcarddate" name="lbexpcarddate"><s:property value="lbexpcarddate"/></label></b> (Visa, Master, American Express)
            <br><br>
            Being rental, Traffic Fine, Salik, Damage, Insurance Excess, Fuel, Government Tax, other charges against vehicle hired by me or replacements provided with Rental Agreement no:
            <br><br>
            _________________________________________________________________________________________________
        </div>

        <table style="width: 100%; margin-top: 50px; font-size: 12px; line-height: 2.5;">
            <tr>
                <td width="15%"><b>Name:</b></td>
                <td><u><label id="clname" name="clname"><s:property value="clname"/></label></u></td>
            </tr>
            <tr>
                <td><b>Id:</b></td>
                <td>________________________________________________________</td>
            </tr>
            <tr>
                <td><b>Signature:</b></td>
                <td>________________________________________________________</td>
            </tr>
            <tr>
                <td><b>Date:</b></td>
                <td>________________________________________________________</td>
            </tr>
        </table>
        
        <hr style="margin: 40px 0; border: 1px dashed #ccc;">

        <div style="font-size: 12px;">
            <b>DISCLAIMER for RA#:</b> <u><label id="rentaldoc" name="rentaldoc"><s:property value="rentaldoc"/></label></u> &nbsp;&nbsp;&nbsp;&nbsp;
            <b>Customer Name:</b> <u><label id="clname" name="clname"><s:property value="clname"/></label></u>
            <br><br>
            <b>Mobile no:</b> <u><label id="clmobno" name="clmobno"><s:property value="clmobno"/></label></u> &nbsp;&nbsp;
            <b>Landline no:</b> <u><label id="ldllandno"><s:property value="ldllandno"/></label></u> &nbsp;&nbsp;
            <b>Email:</b> <u><label id="clemail" name="clemail"><s:property value="clemail"/></label></u>
        </div>

        <div style="margin-top: 20px; font-weight: bold; text-align: justify; font-size: 11px;">
            Traffic fines, Black Points and impounding charges to be cleared with the respective authority by the renter/lessee within two working days from the date of intimation.
        </div>

        <div style="margin-top: 15px; font-size: 11px; line-height: 1.6; text-align: justify;">
            <b>1. <u>Use of mobile phones</u>:</b> Usage of mobile phones without a hands free is against the law.<br>
            <b>2. <u>Red Light Jumping/black point fines</u>:</b> Red light jumping/black point fines to be cleared by the Customer immediately on advice and pay the impounding charges, if applicable.<br>
            <b>3. <u>Tinting of windows</u>:</b> Not permitted for rental cars as per UAE law. Fines up to AED 10,000/black points/vehicle impounding charges will be the renter's responsibility. Insurance will not be applicable if vehicle is tinted.<br>
            <b>4. <u>Off-road driving is not allowed.</u></b><br>
            <b>5. <u>Periodic maintenance service</u>:</b> It is the responsibility of the Customer to bring the vehicle for service as per the mileage mentioned in the Sticker in the wind screen/mentioned in the Checkout report. Amount charged will be depending on the extra KM driven. If any damage happens to the vehicle due to this it will be charged extra.<br>
            <b>6. <u>Insurance</u>:</b> Accident/insurance claim to be supported by Police Report. Replacement vehicle will be provided only after getting Police Report and excess payment as per Rental Agreement.<br>
            <b>7. <u>Oman Insurance:</u></b> NOC to be obtained min. 2 working days prior to travel from PRAC, approval at Management discretion. The charges depend upon the period of travel. It is also the full responsibility of the Renter/Lessee to obtain the Orange Card (third party insurance) at the border, paying the authorities directly and presenting the NOC provided by PRAC. The Renter/Lessee is responsible to transport the vehicle to the UAE boarder in case of breakdown/accident.<br>
            <b>8. <u>Vehicles to be parked in proper authorized parking with valid parking document.</u></b><br>
            <b>9. <u>Vehicle Cleanliness</u>:</b> Use proper fuel, to regularly check the oil and water levels, tire pressure and keep the vehicle clean (in- and exterior). Renter/Lessee will be charged for the maintenance and allied costs.<br>
            <b>10. <u>All our vehicles are smoke free.</u>:</b> Charges apply for cleaning and maintenance.<br>
            <b>11. <u>Fuel cost</u>:</b> Fuel consumed during service/maintenance/repair is at Renter/Lessees’ cost. Vehicle original/replacement, to be returned with same fuel as given, fuel charges will apply for lesser level.<br>
            <b>12. <u>Mileage limits</u>:</b> 5,000km, Weekly 1500km, daily 250km. Extra KM will be charged as per tariff rate.<br>
            <b>13. <u>Payments</u>:</b> Rental amounts and Tax to be paid in advance and other payments on presentation of Invoice.<br>
            <b>14. <u>Credit Card Payment and Pre-authorization:</u></b> PROGRESS rent a car has the right to charge the Credit Card for the rental, Salik, Traffic Fine, Mawaqif and any other charges for the original/replacement vehicles. Renter/Lessee agrees to keep a valid pre-authorization of AED 1,000/- from the date of opening of Rental Agreement and until 21 days from date of closure of the Rental Agreement. Pre-authorization renewal during rental duration every 21 days automatically.<br>
            <b>15. <u>Driver</u>:</b> Only as authorized as per the Rental Agreement. For unauthorized drivers insurance does not apply.<br>
            <b>16. <u>Driver age</u>:</b> Minimum 25 years with minimum 1 year old driving license. Drivers 23-25 years with prior approval at PRAC Management discretion: Excess AED 2,000 + 25% of total repair cost.<br>
            <b>17. <u>Driving License</u>:</b> If vehicle was rented whilst on visit visa, and visa status has been changed to residence, the Renter/Lessee is not permitted to drive the vehicle until UAE d/l is obtained and visa, d/l and Emirates ID copies are submitted to PRAC.<br>
            <b>18. <u>Return of Vehicle</u>:</b> is responsible to return/extend the vehicle rental as per the agreement due date.<br>
            <b>19.</b> FURTHER AND DETAILED TERMS & CONDITIONS AS PER RENTAL AGREEMENT/LEASE FRAME CONTRACT.
        </div>

        <div style="margin-top: 30px; font-size: 12px;">
            <b>Above accepted:</b> ________________________________________________________ &nbsp;&nbsp; <b>Date:</b> _____________________<br><br>
            <b>Customer Name & address:</b> __________________________________________________________________________
        </div>
    </div>

    <div class="page-break"></div>
    
    <div style="text-align: center; margin-bottom: 20px;">
        <img src="<%=contextPath%>/icons/epic.jpg" style="max-width: 400px; height: auto;" alt=""/>
    </div>
    
    <div style="display: flex; flex-direction: column; align-items: center; gap: 40px; margin-top: 50px;">
        <img src="<%=contextPath%>/icons/replacevehicle.jpg" style="max-width: 80%; border: 1px solid #ccc; padding: 10px;" alt="Vehicle Condition Diagram 1"/>
        <img src="<%=contextPath%>/icons/replacevehicle.jpg" style="max-width: 80%; border: 1px solid #ccc; padding: 10px;" alt="Vehicle Condition Diagram 2"/>
    </div>

    <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
    <input type="hidden" name="docnoval" id="docnoval" value='<s:property value="docnoval"/>'/>
    <input type="hidden" id="firstarray" name="firstarray" value='<s:property value="firstarray"/>'>  
    <input type="hidden" id="secarray" name="secarray" value='<s:property value="secarray"/>'>

</div>
</form>
</div>
</body>
</html>

```