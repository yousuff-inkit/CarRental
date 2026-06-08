<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<%@ page pageEncoding="utf-8" %>
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
    font-size: 12px;
    color: var(--text-main);
    background-color: #fff;
    margin: 0;
    padding: 20px;
}
.document-container {
    max-width: 900px;
    margin: 0 auto;
}
.info-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 15px 30px;
    margin-bottom: 20px;
    padding: 0 5px;
    border: 1px solid var(--border-color);
    border-radius: 4px;
    padding: 15px;
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
    width: 120px;
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
    background-color: #ffebcd;
    font-weight: bold;
    color: var(--border-color);
    font-size: 11px;
    -webkit-print-color-adjust: exact;
    print-color-adjust: exact;
}
.section-title {
    font-weight: bold;
    text-decoration: underline;
    margin-bottom: 5px;
    font-size: 12px;
}
.content-text {
    font-size: 11px;
    line-height: 1.5;
    margin-bottom: 15px;
    text-align: justify;
}
.list-table {
    width: 100%;
    font-size: 11px;
    line-height: 1.5;
    margin-bottom: 15px;
}
.list-table td {
    padding: 2px 5px;
    vertical-align: top;
}
.contact-table {
    width: 100%;
    font-size: 11px;
    margin-top: 15px;
}
.contact-table td {
    padding: 2px 5px;
}
.page-break {
    page-break-before: always;
}
@media print {
    body { padding: 0; }
    .document-container { max-width: 100%; }
    @page { margin: 15mm; size: A4; }
}
</style>

<script type="text/javascript">
function hidedata() {
	var first=document.getElementById("firstarray").value;
	var sec=document.getElementById("secarray").value;

	if(parseInt(first)==1) {
	   $("#firstdiv").prop("hidden", false);
	} else {
	   $("#firstdiv").prop("hidden", true);
	}
}
</script>
</head>
<body onload="hidedata();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmqotPrint" action="prqotInvoice" autocomplete="off" target="_blank">

<div class="document-container">

    <div>
        <jsp:include page="../../../common/printHeader.jsp"></jsp:include>
        
        <div class="info-grid" style="margin-top: 20px;">
            <div class="grid-row">
                <span class="grid-label">Customer Name:</span>
                <span class="grid-value"><label id="lblclient" name="lblclient"><s:property value="lblclient"/></label></span>
            </div>
            <div class="grid-row">
                <span class="grid-label">Doc No:</span>
                <span class="grid-value"><label id="docvals" name="docvals"><s:property value="docvals"/></label></span>
            </div>
            <div class="grid-row" style="grid-column: 1;">
                <span class="grid-label">Address:</span>
                <span class="grid-value"><label name="lblclientaddress" id="lblclientaddress"><s:property value="lblclientaddress"/></label></span>
            </div>
            <div class="grid-row">
                <span class="grid-label">Date:</span>
                <span class="grid-value"><label name="lbldate" id="lbldate"><s:property value="lbldate"/></label></span>
            </div>
            <div class="grid-row" style="grid-column: 1;">
                <span class="grid-label">MOB:</span>
                <span class="grid-value"><label name="lblmob" id="lblmob"><s:property value="lblmob"/></label></span>
            </div>
            <div class="grid-row" style="grid-column: 1;">
                <span class="grid-label">Email:</span>
                <span class="grid-value"><label name="lblemail" id="lblemail"><s:property value="lblemail"/></label></span>
            </div>
        </div>

        <div id="firstdiv" hidden="true">
            <table class="cr-table">
                <thead>
                    <tr>
                        <th width="5%">Sl No</th>
                        <th>Lease From</th>
                        <th>Brand</th>
                        <th>Model</th>
                        <th>Specification</th>
                        <th>Color</th>
                        <th>Lease in Months</th>
                        <th>KM use per month</th>
                        <th>Group</th>
                        <th>Total</th>
                    </tr>
                </thead>
                <tbody>
                    <s:iterator var="stat" value='#request.details'>
                    <tr>   
                        <%int i=0; %>
                        <s:iterator status="arr" value="#stat.split('::')" var="des">   
                            <td><s:property value="#des"/></td>
                        </s:iterator>
                    </tr>
                    </s:iterator>
                    <% for(int i=0;i<3;i++) { %>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <%} %>
                </tbody>
            </table>

            <div style="margin-top: 15px;">
                <div class="section-title"><label name="terms1" id="terms1"><s:property value="terms1"/></label></div>
                <div class="content-text"><label name="generalterms" id="generalterms"><s:property value="generalterms"/></label></div>
            </div>

            <div style="margin-top: 15px;">
                <div class="section-title"><label name="terms2" id="terms2"><s:property value="terms2"/></label></div>
                <table class="list-table">
                    <s:iterator var="stat" value='#request.desc'>
                    <tr>   
                        <%int j=0; %>
                        <s:iterator status="arr" value="#stat.split('::')" var="des">   
                            <% if(j==0){%>
                                <td width="3%"><s:property value="#des"/></td>
                            <%} else{ %>
                                <td><s:property value="#des"/></td>
                            <% } j++;  %>
                        </s:iterator>
                    </tr>
                    </s:iterator>
                </table>
            </div>
        </div>

        <div class="content-text" style="margin-top: 20px;">
            <b>Note:</b>
            <div style="margin-left: 15px; margin-top: 5px;">- Quotation is valid for 10 days from the date of quotation.</div>
            <div style="margin-left: 15px; margin-top: 2px;">- The delivery is subject to the availability with the dealers. (Temporary replacement ex-fleet can be arranged immediately, subject to availability)</div>
        </div>

        <div class="content-text">
            <b>Quoted Rate Includes:</b>
            <table class="list-table" style="margin-top: 5px; margin-left: 10px;">
                <tr><td width="3%">1.</td><td>Routine Service & Maintenance</td></tr>
                <tr><td>2.</td><td>Replacement Vehicle</td></tr>
                <tr><td>3.</td><td>Registration & Renewal</td></tr>
                <tr><td>4.</td><td>Full Comprehensive Insurance*</td></tr>
                <tr><td>5.</td><td>Free Delivery & collection in City Limits between 08:00 to 19:00 on working days.</td></tr>
                <tr><td>6.</td><td>24 Hours Breakdown Service.</td></tr>
            </table>
        </div>

        <div class="content-text">
            We trust the above offer is to your satisfaction and we are looking forward to receiving your order confirmation. Should you require any further clarifications, please do not hesitate to contact me at any time.
        </div>

        <div class="content-text" style="margin-top: 15px; font-weight: bold;">
            The <span style="color: #6495ed;">P</span><span style="color: red;">RAC</span> Team is looking forward to be at your service ...<span style="font-style: italic; color: #6495ed;">with a difference!</span>
        </div>

        <hr style="border-top: 1px solid #ccc; margin: 20px 0;">

        <table class="contact-table">
            <tr>
                <td width="50%"><b>Name</b></td>
                <td width="50%">T: +971 55 100 31....</td>
            </tr>
            <tr>
                <td><b>Sales Executive</b></td>
                <td><u style="color: blue;">sales@progresscars.com</u></td>
            </tr>
            <tr><td colspan="2">&nbsp;</td></tr>
            <tr>
                <td colspan="2" style="font-style: italic; color: #555;">* Subject to Police report/Payment of Insurance excess or CDW</td>
            </tr>
        </table>

        <div style="margin-top: 30px;">
            <jsp:include page="../../../common/printFooter.jsp"></jsp:include>
        </div>
    </div>

    <div class="page-break"></div>

    <div>
        <div style="text-align: center; margin-bottom: 20px;">
            <img src="<%=contextPath%>/icons/epic.jpg" style="max-width: 400px; height: auto;" alt=""/>
        </div>
        
        <div style="font-weight: bold; font-size: 14px; text-decoration: underline; margin-bottom: 15px; margin-left: 15px;">Terms & Conditions</div>
        
        <div class="content-text" style="margin-left: 15px;">
            <table class="list-table">
                <tr>
                    <td width="3%"><b>1.</b></td>
                    <td><b>Documentation:</b> RentalContract, LPO, copies of Trade License,Chamber of Commerce, Power of Attorney, Passport of the signatory. All the documents to be signed by the authorized signatory.</td>
                </tr>
                <tr>
                    <td><b>2.</b></td>
                    <td><b>Insurance:</b> All our vehicles are comprehensively insured and your liability will be limited to AED 1000/- in case of faulty accidents and hit and run cases/natural calamities, based on timely submission of police report. Optional CDW and PAI available on request.</td>
                </tr>
                <tr>
                    <td><b>3.</b></td>
                    <td><b>Mileage:</b> Limited 60,000 km P/mnt/weekly/daily, extra mileage 25 Fils/Km</td>
                </tr>
                <tr>
                    <td><b>4.</b></td>
                    <td><b>Geographical Boundaries:</b> The lessee is allowed to drive the vehicle within UAE geographical boundaries only. Oman travel, NOC and insurance obtainable at additional cost subject to Management approval.</td>
                </tr>
                <tr>
                    <td><b>5.</b></td>
                    <td><b>Lessee responsibility:</b> The lessee should ensure that the fluid levels are correctly maintained and the tyres are properly inflated at all times. Vehicle is to be driven in proper roads only and not to be driven in flood/saline water/off road. Any damage due to negligence or misuse will be duly charged to the lessee.</td>
                </tr>
                <tr>
                    <td><b>6.</b></td>
                    <td><b>Payment terms:</b> PRAC follows an advance invoicing policy and your credit terms are 30 days from invoice generation. Any additional charges to be paid immediately upon invoice receipt.</td>
                </tr>
                <tr>
                    <td><b>7.</b></td>
                    <td><b>Traffic Fines & Salik:</b> Traffic fines /penalties & Salik during the contract period to be cleared immediately. Traffic fine @ Actual+AED 25/fine and Salik @ Actual+ AED1/crossing.</td>
                </tr>
                <tr>
                    <td><b>8.</b></td>
                    <td>
                        <b>General Policies:</b>
                        <div style="margin-left: 10px; margin-top: 5px;">
                            - Fuel will be at customer’s expense (including bringing for replacement/maintenance).<br/>
                            - NOC for MAWAQIF parking permit will be provided based on request.<br/>
                            - Smoking is not allowed in our cars. AED 250/- will be charged in case of smoke smell.<br/>
                            - Tinting of vehicle window is not allowed as per UAE laws.<br/>
                            - Use of mobiles are banned while driving as per UAE laws.
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <div style="display:none;">
        <input type="hidden" id="firstarray" name="firstarray" value='<s:property value="firstarray"/>'>  
        <input type="hidden" id="secarray" name="secarray" value='<s:property value="secarray"/>'>
    </div>

</div>
</form>
</div>
</body>
</html>