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
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    font-size: 11px;
    color: var(--text-main);
    background-color: #fff;
    margin: 0;
    padding: 20px;
}
.document-container {
    max-width: 1000px;
    margin: 0 auto;
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
.cr-table .text-right { text-align: right; }
.cr-table .text-center { text-align: center; }
.cr-table tbody tr:hover {
    background-color: #F3F3F3;
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
.sig-internal-grid {
    display: flex;
    justify-content: space-between;
    gap: 10px;
}
.sig-column {
    flex: 1;
    font-size: 11px;
    line-height: 1.6;
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
@media print {
    body { padding: 0; }
    .document-container { max-width: 100%; }
    @page { margin: 15mm; size: A4 landscape; }
}
</style>

<script type="text/javascript">
	function hidedata(){
		var header=document.getElementById("txtheader").value;
		if(parseInt(header)==1){
			   $("#headerdiv").prop("hidden", false);
			   $("#withoutHeaderDiv").attr("hidden", true);
			}
			else{
				$("#headerdiv").prop("hidden", true);
				$("#withoutHeaderDiv").attr("hidden", false);
			}
		}
</script>
</head>
<body onload="hidedata();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmmonthlypayrollPrint" action="printMonthlyPayroll" method="post" autocomplete="off" target="_blank">

<div class="document-container">

    <div id="headerdiv" hidden="true">
        <jsp:include page="../../../common/printHeader.jsp"></jsp:include>
    </div>
    
    <div id="withoutHeaderDiv" hidden="true" style="text-align: center; padding: 20px 0; border-bottom: 2px solid #333; margin-bottom: 20px;">
        <h2 style="margin: 0; font-size: 24px; text-transform: uppercase;">
            <label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label>
        </h2>
    </div>

    <table class="cr-table">
        <thead>
            <tr>
                <th width="6%">ID.</th>
                <th width="13%">Name</th>
                <th class="text-center" width="3%">Days</th> 
                <th class="text-center" width="2%">Leaves</th>
                <th class="text-right" width="7%">Basic</th>
                <th class="text-right" width="5%">Alow.</th>
                <th class="text-center" width="3%">OT</th>  
                <th class="text-center" width="2%">HOT</th>
                <th class="text-right" width="8%">Over Time</th>
                <th class="text-right" width="6%">Gross Salary</th>
                <th class="text-right" width="5%">Add.</th>
                <th class="text-right" width="5%">Ded.</th>        
                <th class="text-right" width="5%">Loan</th>
                <th class="text-right" width="7%">Net Salary</th>
                <th width="14%">Remarks</th>
            </tr>
        </thead>
        <tbody> 
            <%int j=0,k=0; %>
            <s:iterator var="stat" value='#request.printpayroll'>
            <%k=k+1;j=0;%>
            <tr>   
                <s:iterator status="arr" value="#stat.split('::')" var="des">   
                <% if(j==0 || j==1 || j==14){%>
                    <td><s:property value="#des"/></td>
                <%} else if(j==5 || j==6 || j==4){%>
                    <td class="text-right"><s:property value="#des"/></td>
                <%} else if(j==2){%>
                    <td class="text-center"><s:property value="#des"/></td>
                <%} else if(j>7){%>
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
                <td class="text-right" colspan="9">TOTAL:</td>
                <td class="text-right"><label id="lblgrosstotal" name="lblgrosstotal"><s:property value="lblgrosstotal"/></label></td>
                <td class="text-right"><label id="lbladditiontotal" name="lbladditiontotal"><s:property value="lbladditiontotal"/></label></td>
                <td class="text-right"><label id="lbldeductiontotal" name="lbldeductiontotal"><s:property value="lbldeductiontotal"/></label></td>
                <td class="text-right"><label id="lblloantotal" name="lblloantotal"><s:property value="lblloantotal"/></label></td>
                <td class="text-right"><label id="lblnetsalarytotal" name="lblnetsalarytotal"><s:property value="lblnetsalarytotal"/></label></td>
                <td></td>
            </tr>
        </tfoot>
    </table>

    <div class="signature-wrapper">
        <div class="sig-block" style="flex: 1.5;">
            <div style="font-weight: bold; margin-bottom: 15px; border-bottom: 1px solid #ccc; padding-bottom: 5px;">Internal Processing</div>
            <div class="sig-internal-grid">
                <div class="sig-column">
                    <div style="font-weight: bold; margin-bottom: 5px;">Prepared</div>
                    <div><b>by</b> <label name="lblpreparedby" id="lblpreparedby"><s:property value="lblpreparedby"/></label></div>
                    <div><b>on</b> <label name="lblpreparedon" id="lblpreparedon"><s:property value="lblpreparedon"/></label></div>
                    <div><b>at</b> <label name="lblpreparedat" id="lblpreparedat"><s:property value="lblpreparedat"/></label></div>
                </div>
                <div class="sig-column">
                    <div style="font-weight: bold; margin-bottom: 5px;">Verified</div>
                    <div><b>by</b> &nbsp;</div>
                    <div><b>on</b> &nbsp;</div>
                    <div><b>at</b> &nbsp;</div>
                </div>
                <div class="sig-column">
                    <div style="font-weight: bold; margin-bottom: 5px;">Approved</div>
                    <div><b>by</b> &nbsp;</div>
                    <div><b>on</b> &nbsp;</div>
                    <div><b>at</b> &nbsp;</div>
                </div>
            </div>
        </div>

        <div class="sig-block" style="flex: 1;">
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
        <input type="hidden" id="txtheader" name="txtheader" value='<s:property value="txtheader"/>'>
    </div>

</div>

</form>
</div>
</body>
</html>