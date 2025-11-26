 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>
<style>
/* Full white clean theme */
#jqxVehicleDepreciationMainSearch, #refreshdiv .jqx-grid {
    background-color: #ffffff !important; 
    border: 1px solid #D8E6F7 !important;
    border-radius: 8px !important;
    box-shadow: 0 2px 6px rgba(0, 80, 160, 0.10) !important;
    font-family: "Segoe UI", Roboto, sans-serif !important;
    font-size: 13px !important;
}

/* Header white with blue text */
#jqxVehicleDepreciationMainSearch .jqx-grid-column-header, 
#refreshdiv .jqx-grid .jqx-grid-column-header {
    background-color: #ffffff !important;
    color: #2F75C5 !important;
    font-weight: 600 !important;
    border-bottom: 2px solid #C7DBF3 !important;
    text-align: center !important;
}

/* Normal rows – pure white */
#jqxVehicleDepreciationMainSearch .jqx-grid-cell,
#refreshdiv .jqx-grid .jqx-grid-cell {
    background-color: #ffffff !important;
    border-color: #E6EEF9 !important;
    color: #00315C !important;
}

/* Alternate rows – very light blue tint */
#jqxVehicleDepreciationMainSearch .jqx-grid-cell-alt,
#refreshdiv .jqx-grid .jqx-grid-cell-alt {
    background-color: #F8FBFF !important; 
}

/* Row hover */
#jqxVehicleDepreciationMainSearch .jqx-grid-cell:hover,
#refreshdiv .jqx-grid .jqx-grid-cell:hover {
    background-color: #F0F6FF !important;
}

/* Selected row – subtle blue */
#jqxVehicleDepreciationMainSearch .jqx-grid-row-selected,
#refreshdiv .jqx-grid .jqx-grid-row-selected {
    background-color: #DDEAFF !important;
    color: #002B55 !important;
    font-weight: 600 !important;
}

/* Minimal scrollbar */
#jqxVehicleDepreciationMainSearch::-webkit-scrollbar,
#refreshdiv .jqx-grid::-webkit-scrollbar {
    width: 7px;
}
#jqxVehicleDepreciationMainSearch::-webkit-scrollbar-thumb,
#refreshdiv .jqx-grid::-webkit-scrollbar-thumb {
    background: #C7DBF3;
    border-radius: 10px;
}
#jqxVehicleDepreciationMainSearch::-webkit-scrollbar-track,
#refreshdiv .jqx-grid::-webkit-scrollbar-track {
    background: #F3F8FF;
}
</style>
<style>
/* Container spacing */
#search table {
    width: 100%;
    border-collapse: collapse;
}

/* Labels */
#search td[align="right"] {
    text-align: right;
    padding-right: 5px;
    vertical-align: middle;
    font-weight: 600;
    font-size: 13px;
}

/* Inputs */
#search input[type="text"], 
#search input[type="button"], 
#search div[id^="vdpdate"] {
    height: 28px;
    padding: 4px 6px;
    font-size: 13px;
    border: 1px solid #C7DBF3;
    border-radius: 4px;
    box-sizing: border-box;
}

/* Date picker div styling */
#search div[id^="vdpdate"] {
    width: 110px;
}

/* Button styling */
#search input.myButton {
    background-color: #2F75C5;
    color: white;
    border: none;
    cursor: pointer;
    border-radius: 4px;
    height: 32px;
    padding: 0 12px;
    font-size: 13px;
}
#search input.myButton:hover {
    background-color: #1E5CB8;
}

/* Adjust spacing between label-input pairs */
#search td {
    padding: 4px 6px;
}

/* Full-width input for name field */
#txtpartyname {
    width: 100%;
}
</style>

	<script type="text/javascript">
	$(document).ready(function () {
	 	$("#vdpdate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {

 		var partyname=document.getElementById("txtpartyname").value;
 		var docNo=document.getElementById("txtdocno").value;
 		var date=document.getElementById("vdpdate").value;
 		var amount=document.getElementById("txtamount").value;
 		var branch=document.getElementById("brchName").value;
	
		getdata(partyname,docNo,date,amount,branch);
	}
	function getdata(partyname,docNo,date,amount,branch){
		 $("#refreshdiv").load('vdpMainSearchGrid.jsp?partyname='+partyname.replace(/ /g, "%20")+'&docNo='+docNo+'&date='+date+'&amount='+amount+'&branch='+branch);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="6%" align="right">Date</td>
    <td width="14%"><div id="vdpdate" name="vdpdate"  value='<s:property value="vdpdate"/>'></div>
        <input type="hidden" name="hidvdpdate" id="hidvdpdate" value='<s:property value="hidvdpdate"/>'></td>
    <td width="21%" align="right">Doc No</td>
    <td width="32%"><input type="text" name="txtdocno" id="txtdocno" value='<s:property value="txtdocno"/>'></td>
    <td width="27%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td align="right">Name</td>
    <td colspan="2"><input type="text" name="txtpartyname" id="txtpartyname" style="width:100%" value='<s:property value="txtpartyname"/>'></td>
    <td align="right">Total</td>
    <td><input type="text" name="txtamount" id="txtamount" value='<s:property value="txtamount"/>'></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshdiv"><jsp:include page="vdpMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>