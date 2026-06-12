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
    grid-template-columns: repeat(2, 1fr);
    gap: 10px 20px;
    margin-bottom: 20px;
    border: 1px solid var(--border-color);
    padding: 15px;
    border-radius: 4px;
    background: #fafafa;
}

.info-grid.col-3 {
    grid-template-columns: repeat(3, 1fr);
}

.info-grid.col-4 {
    grid-template-columns: repeat(4, 1fr);
}

.grid-row {
    display: flex;
    align-items: baseline;
    border-bottom: 1px dotted #ccc;
    padding-bottom: 4px;
}

.grid-label {
    font-weight: bold;
    width: auto;
    margin-right: 10px;
    flex-shrink: 0;
    color: #444;
}

.grid-value {
    flex-grow: 1;
    color: #000;
}

.grid-col-span-2 { grid-column: span 2; }
.grid-col-span-3 { grid-column: span 3; }
.grid-col-span-4 { grid-column: span 4; }

.footer-section {
    margin-top: 40px;
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

@media print {
    body { padding: 0; }
    .document-container { max-width: 100%; }
    @page { margin: 15mm; size: A4; }
}
</style> 
<script type="text/javascript">
$(document).ready(function () {
    document.getElementById("collectionfield").style.display="none";
    document.getElementById("deliveryfield").style.display="none";
    if(document.getElementById("lblhiddelivery").innerText=="1"){
        document.getElementById("deliveryfield").style.display="block";	
    }
    if(document.getElementById("lblhidcollection").innerText=="1"){
        document.getElementById("collectionfield").style.display="block";	
    }
}); 

function getPrint(){
    document.getElementById("mode").value="print";
    document.getElementById("frmMovementPrint").submit(); 
}
</script>
</head>
<body>
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmMovementPrint" action="printMovement" autocomplete="off" target="_blank">

<div class="document-container">

    <jsp:include page="../../../common/printHeader.jsp"></jsp:include>

    <div class="section-title">Opening Details</div>
    
    <div class="info-grid col-3" style="margin-bottom: 0; border-bottom: none; border-bottom-left-radius: 0; border-bottom-right-radius: 0;">
        <div class="grid-row">
            <span class="grid-label">Branch:</span>
            <span class="grid-value"><label id="lblopenbranch" name="lblopenbranch"><s:property value="lblopenbranch"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Location:</span>
            <span class="grid-value"><label name="lblopenlocation" id="lblopenlocation"><s:property value="lblopenbranch"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Doc No:</span>
            <span class="grid-value"><label id="lbldocno" name="lbldocno"><s:property value="lbldocno"/></label></span>
        </div>

        <div class="grid-row">
            <span class="grid-label">Fleet NO:</span>
            <span class="grid-value"><label id="lblfleetno" name="lblfleetno"><s:property value="lblfleetno"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Date:</span>
            <span class="grid-value"><label id="lbldate" name="lbldate"><s:property value="lbldate"/></label></span>
        </div>
        <div></div>

        <div class="grid-row grid-col-span-2">
            <span class="grid-label">Fleet Details:</span>
            <span class="grid-value"><label name="lblfleetdetails" id="lblfleetdetails"><s:property value="lblfleetdetails"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Mov Type:</span>
            <span class="grid-value"><label id="lblmovtype" name="lblmovtype"><s:property value="lblmovtype"/></label></span>
        </div>
    </div>
    
    <div class="info-grid col-4" style="border-top-left-radius: 0; border-top-right-radius: 0; border-top: 1px dashed #ccc;">
        <div class="grid-row">
            <span class="grid-label">Date Out:</span>
            <span class="grid-value"><label id="lbldateout" name="lbldateout"><s:property value="lbldateout"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Time Out:</span>
            <span class="grid-value"><label id="lbltimeout" name="lbltimeout"><s:property value="lbltimeout"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">KM Out:</span>
            <span class="grid-value"><label id="lblkmout" name="lblkmout"><s:property value="lblkmout"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Fuel Out:</span>
            <span class="grid-value"><label id="lblfuelout" name="lblfuelout"><s:property value="lblfuelout"/></label></span>
        </div>

        <div class="grid-row">
            <span class="grid-label">Garage:</span>
            <span class="grid-value"><label id="lblgaragename" name="lblgaragename"><s:property value="lblgaragename"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Driver:</span>
            <span class="grid-value"><label name="lblopendriver" id="lblopendriver"><s:property value="lblopendriver"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Staff:</span>
            <span class="grid-value"><label name="lblopenstaff" id="lblopenstaff"><s:property value="lblopenstaff"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">User:</span>
            <span class="grid-value"><label id="lblopenuser" name="lblopenuser"><s:property value="lblopenuser"/></label></span>
        </div>

        <div class="grid-row grid-col-span-4">
            <span class="grid-label">Remarks:</span>
            <span class="grid-value"><label id="lblopenremarks" name="lblopenremarks"><s:property value="lblopenremarks"/></label></span>
        </div>
    </div>

    <div id="deliveryfield">
        <div class="section-title">Delivery Details</div>
        <div class="info-grid col-4">
            <div class="grid-row">
                <span class="grid-label">Date:</span>
                <span class="grid-value"><label id="lbldeldate" name="lbldeldate"><s:property value="lbldeldate"/></label></span>
            </div>
            <div class="grid-row">
                <span class="grid-label">Time:</span>
                <span class="grid-value"><label id="lbldeltime" name="lbldeltime"><s:property value="lbldeltime"/></label></span>
            </div>
            <div class="grid-row">
                <span class="grid-label">KM:</span>
                <span class="grid-value"><label id="lbldelkm" name="lbldelkm"><s:property value="lbldelkm"/></label></span>
            </div>
            <div class="grid-row">
                <span class="grid-label">Fuel:</span>
                <span class="grid-value"><label id="lbldelfuel" name="lbldelfuel"><s:property value="lbldelfuel"/></label></span>
            </div>
        </div>
    </div>

    <div id="driverdetailsfield">
        <div class="section-title">Driver Details</div>
        <div class="info-grid col-4">
            <div class="grid-row">
                <span class="grid-label">Driver Name:</span>
                <span class="grid-value"><label id="lbldrvdrivername" name="lbldrvdrivername"><s:property value="lbldrvdrivername"/></label></span>
            </div>
            <div class="grid-row">
                <span class="grid-label">License No:</span>
                <span class="grid-value"><label id="lbldrvlicenseno" name="lbldrvlicenseno"><s:property value="lbldrvlicenseno"/></label></span>
            </div>
            <div class="grid-row">
                <span class="grid-label">Expiry:</span>
                <span class="grid-value"><label id="lbldrvexpiry" name="lbldrvexpiry"><s:property value="lbldrvexpiry"/></label></span>
            </div>
            <div class="grid-row">
                <span class="grid-label">Issued from:</span>
                <span class="grid-value"><label id="lbldrvissuedfrom" name="lbldrvissuedfrom"><s:property value="lbldrvissuedfrom"/></label></span>
            </div>
        </div>
    </div>

    <div id="collectionfield">
        <div class="section-title">Collection Details</div>
        <div class="info-grid col-4">
            <div class="grid-row">
                <span class="grid-label">Date:</span>
                <span class="grid-value"><label id="lblcoldate" name="lblcoldate"><s:property value="lblcoldate"/></label></span>
            </div>
            <div class="grid-row">
                <span class="grid-label">Time:</span>
                <span class="grid-value"><label id="lblcoltime" name="lblcoltime"><s:property value="lblcoltime"/></label></span>
            </div>
            <div class="grid-row">
                <span class="grid-label">KM:</span>
                <span class="grid-value"><label id="lblcolkm" name="lblcolkm"><s:property value="lblcolkm"/></label></span>
            </div>
            <div class="grid-row">
                <span class="grid-label">Fuel:</span>
                <span class="grid-value"><label id="lblcolfuel" name="lblcolfuel"><s:property value="lblcolfuel"/></label></span>
            </div>
        </div>
    </div>

    <div class="section-title">Closing Details</div>
    
    <div class="info-grid col-2" style="margin-bottom: 0; border-bottom: none; border-bottom-left-radius: 0; border-bottom-right-radius: 0;">
        <div class="grid-row">
            <span class="grid-label">Branch:</span>
            <span class="grid-value"><label id="lblclosebranch" name="lblclosebranch"><s:property value="lblclosebranch"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Location:</span>
            <span class="grid-value"><label name="lblcloselocation" id="lblcloselocation"><s:property value="lblcloselocation"/></label></span>
        </div>
    </div>
    
    <div class="info-grid col-4" style="margin-bottom: 0; border-bottom: none; border-radius: 0; border-top: 1px dashed #ccc;">
        <div class="grid-row">
            <span class="grid-label">Date In:</span>
            <span class="grid-value"><label id="lblclosedate" name="lblclosedate"><s:property value="lblclosedate"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Time In:</span>
            <span class="grid-value"><label id="lblclosetime" name="lblclosetime"><s:property value="lblclosetime"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">KM:</span>
            <span class="grid-value"><label id="lblclosekm" name="lblclosekm"><s:property value="lblclosekm"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Fuel:</span>
            <span class="grid-value"><label id="lblclosefuel" name="lblclosefuel"><s:property value="lblclosefuel"/></label></span>
        </div>

        <div class="grid-row">
            <span class="grid-label">Garage:</span>
            <span class="grid-value"><label id="lblclosegarage" name="lblclosegarage"><s:property value="lblclosegarage"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Driver:</span>
            <span class="grid-value"><label id="lblclosedriver" name="lblclosedriver"><s:property value="lblclosedriver"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Staff:</span>
            <span class="grid-value"><label id="lblclosestaff" name="lblclosestaff"><s:property value="lblclosestaff"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">User:</span>
            <span class="grid-value"><label name="lblcloseuser" id="lblcloseuser"><s:property value="lblcloseuser"/></label></span>
        </div>
    </div>

    <div class="info-grid col-3" style="border-top-left-radius: 0; border-top-right-radius: 0; border-top: 1px dashed #ccc;">
        <div class="grid-row">
            <span class="grid-label">Accident Details:</span>
            <span class="grid-value"><label id="lblaccdetails" name="lblaccdetails"><s:property value="lblaccdetails"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Accident Fines:</span>
            <span class="grid-value"><label name="lblaccfines" id="lblaccfines"><s:property value="lblaccfines"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Total Km:</span>
            <span class="grid-value"><label name="lbltotalkm" id="lbltotalkm"><s:property value="lbltotalkm"/></label></span>
        </div>
        <div class="grid-row grid-col-span-3">
            <span class="grid-label">Remarks:</span>
            <span class="grid-value"><label id="lblcloseremarks" name="lblcloseremarks"><s:property value="lblcloseremarks"/></label></span>
        </div>
    </div>

    <div style="display: flex; gap: 20px; margin-bottom: 20px;">
        <div style="flex: 1;">
            <div class="section-title">Vehicle In Details</div>
            <div style="border: 1px solid var(--border-color); padding: 10px; border-radius: 4px; text-align: center;">
                <img src="<%=contextPath%>/icons/replacevehiclenew.jpg" style="max-width: 100%; height: auto;" />
            </div>
        </div>
        <div style="flex: 1;">
            <div class="section-title">Vehicle Out Details</div>
            <div style="border: 1px solid var(--border-color); padding: 10px; border-radius: 4px; text-align: center;">
                <img src="<%=contextPath%>/icons/replacevehiclenew.jpg" style="max-width: 100%; height: auto;" />
            </div>
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

    <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
    <label id="lblhiddelivery" name="lblhiddelivery" hidden="true"><s:property value="lblhiddelivery"/></label>
    <label id="lblhidcollection" name="lblhidcollection" hidden="true"><s:property value="lblhidcollection"/></label>

</div>

</form>
</div>
</body>
</html>