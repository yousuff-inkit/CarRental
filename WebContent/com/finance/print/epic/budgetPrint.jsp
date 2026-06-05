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
    --bg-income: #F6CECE;
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
    max-width: 1100px;
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
    width: 150px;
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
    padding: 6px 6px;
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
.cr-table .title-row td {
    background-color: var(--bg-income);
    font-size: 13px;
    font-weight: bold;
    text-transform: uppercase;
    -webkit-print-color-adjust: exact;
    print-color-adjust: exact;
}
.cr-table .text-right { text-align: right; }
.cr-table .text-center { text-align: center; }
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
    margin-top: 30px;
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
@media print {
    body { padding: 0; }
    .document-container { max-width: 100%; }
    @page { margin: 10mm; size: A4 landscape; }
}
</style>

<script type="text/javascript">

	function hidedata(){
		
		var first=document.getElementById("firstarray").value;
		var second=document.getElementById("secarray").value;
		var header=document.getElementById("txtheader").value;
	
		if(parseInt(header)==1){
			   $("#headerdiv").prop("hidden", false);
			   $("#withoutHeaderDiv").attr("hidden", true);
			}
			else{
				$("#headerdiv").prop("hidden", true);
				$("#withoutHeaderDiv").attr("hidden", false);
			}
		
		if(parseInt(first)==1){
			   $("#firstdiv").prop("hidden", false);
		}
		else{
			 $("#firstdiv").prop("hidden", true);
			}
		
		if(parseInt(second)==2){
			   $("#seconddiv").prop("hidden", false);
		}
		else{
			 $("#seconddiv").prop("hidden", true);
			}
		
		}

</script>



</head>
<body onload="hidedata()">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmbudgetPrint" action="budgetprintVoucher" method="post" autocomplete="off" target="_blank">

<div class="document-container">

    <div id="headerdiv" hidden="true">
        <jsp:include page="../../../common/printHeader.jsp"></jsp:include>
    </div>
    
    <div id="withoutHeaderDiv" hidden="true" style="text-align: center; padding: 20px 0; border-bottom: 2px solid #333; margin-bottom: 20px;">
        <h2 style="margin: 0; font-size: 24px; text-transform: uppercase;">
            <label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label>
        </h2>
    </div>

    <div class="section-title">1. Voucher Details</div>
    <div class="info-grid">
        <div class="grid-row">
            <span class="grid-label">Assessment Year:</span>
            <span class="grid-value"><label id="lblassessmentyear" name="lblassessmentyear"><s:property value="lblassessmentyear"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Voucher No:</span>
            <span class="grid-value"><label name="lblvoucherno" id="lblvoucherno"><s:property value="lblvoucherno"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Description:</span>
            <span class="grid-value"><label id="lbldescription" name="lbldescription"><s:property value="lbldescription"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Date:</span>
            <span class="grid-value"><label name="lbldate" id="lbldate"><s:property value="lbldate"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Total Income:</span>
            <span class="grid-value" style="font-weight: bold;"><label id="lbltotincome" name="lbltotincome"><s:property value="lbltotincome"/></label></span>
        </div>
        <div class="grid-row">
            <span class="grid-label">Total Expenditure:</span>
            <span class="grid-value" style="font-weight: bold;"><label name="lbltotexpenditure" id="lbltotexpenditure"><s:property value="lbltotexpenditure"/></label></span>
        </div>
    </div>

    <div id="firstdiv" hidden="true">
        <table class="cr-table">
            <thead>
                <tr class="title-row">
                    <td colspan="14">Income</td>
                </tr>
                <tr>
                    <th class="text-center" width="5%">Account</th> 
                    <th width="23%">Account Name</th>
                    <th class="text-center" width="6%"><label name="lblincomemonth1" id="lblincomemonth1"><s:property value="lblincomemonth1"/></label></th>
                    <th class="text-center" width="6%"><label name="lblincomemonth2" id="lblincomemonth2"><s:property value="lblincomemonth2"/></label></th> 
                    <th class="text-right" width="6%"><label name="lblincomemonth3" id="lblincomemonth3"><s:property value="lblincomemonth3"/></label></th>
                    <th class="text-right" width="6%"><label name="lblincomemonth4" id="lblincomemonth4"><s:property value="lblincomemonth4"/></label></th>
                    <th class="text-right" width="6%"><label name="lblincomemonth5" id="lblincomemonth5"><s:property value="lblincomemonth5"/></label></th>
                    <th class="text-right" width="6%"><label name="lblincomemonth6" id="lblincomemonth6"><s:property value="lblincomemonth6"/></label></th>
                    <th class="text-right" width="6%"><label name="lblincomemonth7" id="lblincomemonth7"><s:property value="lblincomemonth7"/></label></th>
                    <th class="text-right" width="6%"><label name="lblincomemonth8" id="lblincomemonth8"><s:property value="lblincomemonth8"/></label></th>
                    <th class="text-right" width="6%"><label name="lblincomemonth9" id="lblincomemonth9"><s:property value="lblincomemonth9"/></label></th>
                    <th class="text-right" width="6%"><label name="lblincomemonth10" id="lblincomemonth10"><s:property value="lblincomemonth10"/></label></th>
                    <th class="text-right" width="6%"><label name="lblincomemonth11" id="lblincomemonth11"><s:property value="lblincomemonth11"/></label></th>
                    <th class="text-right" width="6%"><label name="lblincomemonth12" id="lblincomemonth12"><s:property value="lblincomemonth12"/></label></th>
                </tr>
            </thead>
            <tbody>
                <%int j=0,k=0; %>
                <s:iterator var="stat" value='#request.printincomes'>
                <%k=k+1;j=0;%>
                <tr>   
                    <s:iterator status="arr" value="#stat.split('::')" var="des">   
                        <% if(j==1){%>
                            <td><s:property value="#des"/></td>
                        <%} else if(j>1){%>
                            <td class="text-right"><s:property value="#des"/></td>
                        <%} else{ %>
                            <td class="text-center"><s:property value="#des"/></td>
                        <% } j++;  %>
                    </s:iterator>
                </tr>
                </s:iterator> 
            </tbody>
            <tfoot>
                <tr style="background-color: var(--bg-header); font-weight: bold;">
                    <td colspan="12" class="text-right">TOTAL:</td>
                    <td colspan="2" class="text-right"><label id="lblincometotal" name="lblincometotal"><s:property value="lblincometotal"/></label></td>
                </tr>
            </tfoot>
        </table>
    </div>

    <div id="seconddiv" hidden="true">
        <table class="cr-table">
            <thead>
                <tr class="title-row">
                    <td colspan="14">Expenditure</td>
                </tr>
                <tr>
                    <th class="text-center" width="5%">Account</th> 
                    <th width="23%">Account Name</th>
                    <th class="text-center" width="6%"><label name="lblexpendituremonth1" id="lblexpendituremonth1"><s:property value="lblexpendituremonth1"/></label></th>
                    <th class="text-center" width="6%"><label name="lblexpendituremonth2" id="lblexpendituremonth2"><s:property value="lblexpendituremonth2"/></label></th> 
                    <th class="text-right" width="6%"><label name="lblexpendituremonth3" id="lblexpendituremonth3"><s:property value="lblexpendituremonth3"/></label></th>
                    <th class="text-right" width="6%"><label name="lblexpendituremonth4" id="lblexpendituremonth4"><s:property value="lblexpendituremonth4"/></label></th>
                    <th class="text-right" width="6%"><label name="lblexpendituremonth5" id="lblexpendituremonth5"><s:property value="lblexpendituremonth5"/></label></th>
                    <th class="text-right" width="6%"><label name="lblexpendituremonth6" id="lblexpendituremonth6"><s:property value="lblexpendituremonth6"/></label></th>
                    <th class="text-right" width="6%"><label name="lblexpendituremonth7" id="lblexpendituremonth7"><s:property value="lblexpendituremonth7"/></label></th>
                    <th class="text-right" width="6%"><label name="lblexpendituremonth8" id="lblexpendituremonth8"><s:property value="lblexpendituremonth8"/></label></th>
                    <th class="text-right" width="6%"><label name="lblexpendituremonth9" id="lblexpendituremonth9"><s:property value="lblexpendituremonth9"/></label></th>
                    <th class="text-right" width="6%"><label name="lblexpendituremonth10" id="lblexpendituremonth10"><s:property value="lblexpendituremonth10"/></label></th>
                    <th class="text-right" width="6%"><label name="lblexpendituremonth11" id="lblexpendituremonth11"><s:property value="lblexpendituremonth11"/></label></th>
                    <th class="text-right" width="6%"><label name="lblexpendituremonth12" id="lblexpendituremonth12"><s:property value="lblexpendituremonth12"/></label></th>
                </tr>
            </thead>
            <tbody>
                <%int l=0,m=0; %>
                <s:iterator var="stat" value='#request.printexpenditures'>
                <%m=m+1;l=0;%>
                <tr>   
                    <s:iterator status="arr" value="#stat.split('::')" var="des">   
                        <% if(l==1){%>
                            <td><s:property value="#des"/></td>
                        <%} else if(l>1){%>
                            <td class="text-right"><s:property value="#des"/></td>
                        <%} else{ %>
                            <td class="text-center"><s:property value="#des"/></td>
                        <% } l++;  %>
                    </s:iterator>
                </tr>
                </s:iterator> 
            </tbody>
            <tfoot>
                <tr style="background-color: var(--bg-header); font-weight: bold;">
                    <td colspan="12" class="text-right">TOTAL:</td>
                    <td colspan="2" class="text-right"><label id="lblexpendituretotal" name="lblexpendituretotal"><s:property value="lblexpendituretotal"/></label></td>
                </tr>
            </tfoot>
        </table>
    </div>

    <div class="signature-wrapper">
        <div class="sig-block">
            <div style="font-weight: bold; margin-bottom: 10px; border-bottom: 1px solid #ccc; padding-bottom: 5px;">Internal Processing</div>
            <div style="margin-bottom: 8px;"><b>Prepared by:</b> <label name="lblpreparedby" id="lblpreparedby"><s:property value="lblpreparedby"/></label></div>
            <div style="margin-bottom: 8px;"><b>Date:</b> <label name="lblpreparedon" id="lblpreparedon"><s:property value="lblpreparedon"/></label></div>
            <div style="margin-bottom: 8px;"><b>Time:</b> <label name="lblpreparedat" id="lblpreparedat"><s:property value="lblpreparedat"/></label></div>
        </div>

        <div class="sig-block">
            <div style="font-weight: bold; margin-bottom: 10px; border-bottom: 1px solid #ccc; padding-bottom: 5px;">Received By</div>
            <div style="height: 40px;"></div>
            <div class="sig-line">Name, Signature & Stamp</div>
            <div style="display: flex; justify-content: space-between; margin-top: 10px; font-size: 11px;">
                <span>Date: ____/____/______</span>
                <span>Time: ____:____</span>
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

    <div style="display:none;">
        <input type="hidden" id="firstarray" name="firstarray" value='<s:property value="firstarray"/>'>  
        <input type="hidden" id="secarray" name="secarray" value='<s:property value="secarray"/>'>
        <input type="hidden" id="txtheader" name="txtheader" value='<s:property value="txtheader"/>'>
    </div>

</div>

</form>
</div>
</body>
</html>
