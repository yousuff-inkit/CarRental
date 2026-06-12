<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<script type="text/javascript" src="<%=contextPath%>/js/jquery-1.11.1.min.js"></script>

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
.section-title {
    background-color: var(--border-color);
    color: #fff;
    padding: 6px 12px;
    font-weight: bold;
    font-size: 13px;
    text-transform: uppercase;
    margin-top: 25px;
    margin-bottom: 10px;
    -webkit-print-color-adjust: exact;
    print-color-adjust: exact;
}
.info-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 15px 30px;
    margin-bottom: 20px;
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
    width: 120px;
    flex-shrink: 0;
    color: #444;
}
.grid-value {
    flex-grow: 1;
    color: #000;
}
.split-wrapper {
    display: flex;
    gap: 20px;
    margin-top: 10px;
    margin-bottom: 20px;
}
.split-box {
    flex: 1;
    border: 1px solid var(--border-color);
    padding: 15px;
    border-radius: 4px;
}
.split-box-title {
    font-weight: bold;
    background: var(--bg-header);
    padding: 6px 12px;
    margin: -15px -15px 15px -15px;
    border-bottom: 1px solid var(--border-color);
    text-transform: uppercase;
    font-size: 11px;
    color: var(--border-color);
    -webkit-print-color-adjust: exact;
    print-color-adjust: exact;
}
.vehicle-image-box {
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    border: 1px solid var(--border-color);
    padding: 10px;
    border-radius: 4px;
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
	var d = new Date,
    dformat = [''+' on '+d.getDate(),
               d.getMonth()+1,
               d.getFullYear()].join('-')+' at '+
              [d.getHours(),
               d.getMinutes(),
               d.getSeconds()].join(':');
	 document.getElementById("lblfooter").innerText=""+dformat;
}); 
</script>
</head>
<body>
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmprintrep" action="printrep" method="post" autocomplete="off" target="_blank">

<div class="document-container">

    <div style="display: flex; justify-content: space-between; align-items: center; padding-bottom: 10px; border-bottom: 2px solid var(--border-color); margin-bottom: 20px;">
        <div style="flex: 0 0 120px;">
            <img src="<%=contextPath%>/icons/epic.jpg" width="100" height="91" alt=""/>
        </div>
        <div style="flex: 1; text-align: center;">
            <div style="font-size: 20px; font-weight: bold; text-transform: uppercase;">Vehicle Replacement</div>
        </div>
        <div style="flex: 0 0 250px; text-align: right; font-size: 12px; line-height: 1.5;">
            <div style="font-size: 14px; font-weight: bold; margin-bottom: 5px;"><label id="companyname" name="companyname"><s:property value="companyname"/></label></div>
            <div style="font-weight: bold; margin-bottom: 5px;"><label id="address" name="address"><s:property value="address"/></label></div>
            <div><b>Tel :</b> <label id="mobileno" name="mobileno"><s:property value="mobileno"/></label></div>
            <div><b>Fax :</b> <label id="fax" name="fax"><s:property value="fax"/></label></div>
            <div><b>Branch :</b> <label id="barnchval" name="barnchval"><s:property value="barnchval"/></label></div>
            <div><b>Location :</b> <label id="location" name="location"><s:property value="location"/></label></div>
        </div>
    </div>

    <div class="section-title">1. Agreement Opening Details</div>
    <div class="info-grid">
        <div class="grid-row">
            <span class="grid-label">Branch:</span>
            <span class="grid-value"><label id="brwithcompany" name="brwithcompany"><s:property value="brwithcompany"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Doc NO:</span>
            <span class="grid-value"><label id="pdocno" name="pdocno"><s:property value="pdocno"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Location:</span>
            <span class="grid-value"><label id="lblrlocation" name="lblrlocation"><s:property value="lblrlocation"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Date:</span>
            <span class="grid-value"><label id="pdate" name="pdate"><s:property value="pdate"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Agreement:</span>
            <span class="grid-value"><label id="agmt" name="agmt"><s:property value="agmt"/></label> &nbsp; - <s:property value="vrano"/></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Fleet:</span>
            <span class="grid-value"><label id="pfleetno" name="pfleetno"><s:property value="pfleetno"/></label> &nbsp; <label id="lblinfleetname" name="lblinfleetname"><s:property value="lblinfleetname"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">VRA Date:</span>
            <span class="grid-value"><label id="vradate" name="vradate"><s:property value="vradate"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Reg NO:</span>
            <span class="grid-value"><label id="pregno" name="pregno"><s:property value="pregno"/></label></span>
        </div>
        <div class="grid-row" style="grid-column: 1 / -1;">
            <span class="grid-label">Client:</span>
            <span class="grid-value"><label id="clientacno" name="clientacno"><s:property value="clientacno"/></label> &nbsp; <label id="pclient" name="pclient"><s:property value="pclient"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Opened:</span>
            <span class="grid-value"><label id="popened" name="popened"><s:property value="popened"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Date Out:</span>
            <span class="grid-value"><label id="poutdate" name="poutdate"><s:property value="poutdate"/></label> &nbsp; <s:property value="mtime"/></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Rep Type:</span>
            <span class="grid-value"><label id="reptype" name="reptype"><s:property value="reptype"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">KM Out:</span>
            <span class="grid-value"><label id="pkm" name="pkm"><s:property value="pkm"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Driven By:</span>
            <span class="grid-value"><label id="lbldrivenby" name="lbldrivenby"><s:property value="lbldrivenby"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Fuel Out:</span>
            <span class="grid-value"><label id="pfuel" name="pfuel"><s:property value="pfuel"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Replaced:</span>
            <span class="grid-value"><label id="replaced" name="replaced"><s:property value="replaced"/></label></span>
        </div>
        <div class="grid-row" style="grid-column: 1 / -1;">
            <span class="grid-label">Reason:</span>
            <span class="grid-value"><label id="invehreason" name="invehreason"><s:property value="invehreason"/></label></span>
        </div>
        <div class="grid-row" style="grid-column: 1 / -1;">
            <span class="grid-label">Description:</span>
            <span class="grid-value"><label id="lbldescription" name="lbldescription"><s:property value="lbldescription"/></label></span>
        </div>
    </div>

    <div class="section-title">2. Vehicle In Details</div>
    <div class="info-grid">
        <div class="grid-row">
            <span class="grid-label">Branch:</span>
            <span class="grid-value"><label id="inbrwithcompany" name="inbrwithcompany"><s:property value="inbrwithcompany"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Location:</span>
            <span class="grid-value"><label id="lblinlocation" name="lblinlocation"><s:property value="lblinlocation"/></label></span>
        </div>
        <div class="grid-row" style="grid-column: 1 / -1;">
            <span class="grid-label">Fleet No:</span>
            <span class="grid-value"><label id="colfleet" name="colfleet"><s:property value="colfleet"/></label> &nbsp; <label id="lblcolfleetname" name="lblcolfleetname"><s:property value="lblcolfleetname"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Reg No:</span>
            <span class="grid-value"><label id="colregno" name="colregno"><s:property value="colregno"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Driver:</span>
            <span class="grid-value"><label id="lblcoldriver" name="lblcoldriver"><s:property value="lblcoldriver"/></label></span>
        </div>
    </div>

    <div class="split-wrapper">
        <div class="split-box">
            <div class="split-box-title">Collected - Client</div>
            <div class="info-grid" style="grid-template-columns: 1fr; gap: 12px; margin-bottom: 0;">
                <div class="grid-row">
                    <span class="grid-label" style="width: 80px;">Date:</span>
                    <span class="grid-value"><label id="coldate" name="coldate"><s:property value="coldate"/></label></span>
                </div>
                <div class="grid-row">
                    <span class="grid-label" style="width: 80px;">Time:</span>
                    <span class="grid-value"><label id="coltime" name="coltime"><s:property value="coltime"/></label></span>
                </div>
                <div class="grid-row">
                    <span class="grid-label" style="width: 80px;">KM:</span>
                    <span class="grid-value"><label id="colkm" name="colkm"><s:property value="colkm"/></label></span>
                </div>
                <div class="grid-row">
                    <span class="grid-label" style="width: 80px;">Fuel:</span>
                    <span class="grid-value"><label id="colfuel" name="colfuel"><s:property value="colfuel"/></label></span>
                </div>
            </div>
        </div>

        <div class="split-box">
            <div class="split-box-title">Received - Branch</div>
            <div class="info-grid" style="grid-template-columns: 1fr; gap: 12px; margin-bottom: 0;">
                <div class="grid-row">
                    <span class="grid-label" style="width: 80px;">Date:</span>
                    <span class="grid-value"><label id="invehdate" name="invehdate"><s:property value="invehdate"/></label></span>
                </div>
                <div class="grid-row">
                    <span class="grid-label" style="width: 80px;">Time:</span>
                    <span class="grid-value"><label id="invehtime" name="invehtime"><s:property value="invehtime"/></label></span>
                </div>
                <div class="grid-row">
                    <span class="grid-label" style="width: 80px;">KM:</span>
                    <span class="grid-value"><label id="invehkm" name="invehkm"><s:property value="invehkm"/></label></span>
                </div>
                <div class="grid-row">
                    <span class="grid-label" style="width: 80px;">Fuel:</span>
                    <span class="grid-value"><label id="invehfuel" name="invehfuel"><s:property value="invehfuel"/></label></span>
                </div>
            </div>
        </div>

        <div class="vehicle-image-box">
            <img src="<%=contextPath%>/icons/replacevehicle.jpg" style="max-width: 100%; max-height: 150px;" alt=""/>
        </div>
    </div>

    <div class="section-title">3. Vehicle Out Details</div>
    <div class="info-grid">
        <div class="grid-row">
            <span class="grid-label">Branch:</span>
            <span class="grid-value"><label id="delbrwithcompany" name="delbrwithcompany"><s:property value="delbrwithcompany"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Location:</span>
            <span class="grid-value"><label id="lbloutlocation" name="lbloutlocation"><s:property value="lbloutlocation"/></label></span>
        </div>
        <div class="grid-row" style="grid-column: 1 / -1;">
            <span class="grid-label">Fleet No:</span>
            <span class="grid-value"><label id="delfleet" name="delfleet"><s:property value="delfleet"/></label> &nbsp; <label id="lbldelfleetname" name="lbldelfleetname"><s:property value="lbldelfleetname"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Reg No:</span>
            <span class="grid-value"><label id="delregno" name="delregno"><s:property value="delregno"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Driver:</span>
            <span class="grid-value"><label id="lbldeldriver" name="lbldeldriver"><s:property value="lbldeldriver"/></label></span>
        </div>
    </div>

    <div class="split-wrapper">
        <div class="split-box">
            <div class="split-box-title">Delivery - Branch</div>
            <div class="info-grid" style="grid-template-columns: 1fr; gap: 12px; margin-bottom: 0;">
                <div class="grid-row">
                    <span class="grid-label" style="width: 80px;">Date:</span>
                    <span class="grid-value"><label id="newvehoutdate" name="newvehoutdate"><s:property value="newvehoutdate"/></label></span>
                </div>
                <div class="grid-row">
                    <span class="grid-label" style="width: 80px;">Time:</span>
                    <span class="grid-value"><label id="newvehouttime" name="newvehouttime"><s:property value="newvehouttime"/></label></span>
                </div>
                <div class="grid-row">
                    <span class="grid-label" style="width: 80px;">KM:</span>
                    <span class="grid-value"><label id="newvehkm" name="newvehkm"><s:property value="newvehkm"/></label></span>
                </div>
                <div class="grid-row">
                    <span class="grid-label" style="width: 80px;">Fuel:</span>
                    <span class="grid-value"><label id="newvehfuel" name="newvehfuel"><s:property value="newvehfuel"/></label></span>
                </div>
            </div>
        </div>

        <div class="split-box">
            <div class="split-box-title">Delivered - Client</div>
            <div class="info-grid" style="grid-template-columns: 1fr; gap: 12px; margin-bottom: 0;">
                <div class="grid-row">
                    <span class="grid-label" style="width: 80px;">Date:</span>
                    <span class="grid-value"><label id="deldate" name="deldate"><s:property value="deldate"/></label></span>
                </div>
                <div class="grid-row">
                    <span class="grid-label" style="width: 80px;">Time:</span>
                    <span class="grid-value"><label id="deltime" name="deltime"><s:property value="deltime"/></label></span>
                </div>
                <div class="grid-row">
                    <span class="grid-label" style="width: 80px;">KM:</span>
                    <span class="grid-value"><label id="delkm" name="delkm"><s:property value="delkm"/></label></span>
                </div>
                <div class="grid-row">
                    <span class="grid-label" style="width: 80px;">Fuel:</span>
                    <span class="grid-value"><label id="delfuel" name="delfuel"><s:property value="delfuel"/></label></span>
                </div>
            </div>
        </div>

        <div class="vehicle-image-box">
            <img src="<%=contextPath%>/icons/replacevehicle.jpg" style="max-width: 100%; max-height: 150px;" alt=""/>
        </div>
    </div>

    <div class="signature-wrapper" style="margin-top: 20px;">
        <div class="sig-block">
            <div style="font-weight: bold; margin-bottom: 10px; border-bottom: 1px solid #ccc; padding-bottom: 5px;">Customer</div>
            <div style="height: 40px;"></div>
            <div class="sig-line">Name & Signature</div>
        </div>

        <div class="sig-block">
            <div style="font-weight: bold; margin-bottom: 10px; border-bottom: 1px solid #ccc; padding-bottom: 5px;">Checked By</div>
            <div style="height: 40px;"></div>
            <div class="sig-line">Name & Signature</div>
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

    <label id="lbldelivery" name="lbldelivery" hidden="true"><s:property value="lbldelivery"/></label>
    <label id="lblcollection" name="lblcollection" hidden="true"><s:property value="lblcollection"/></label>

</div>

</form>
</div>
</body>
</html>