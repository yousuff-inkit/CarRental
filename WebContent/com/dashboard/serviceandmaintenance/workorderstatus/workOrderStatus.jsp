
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<script type="text/javascript">

$(document).ready(function () {
	$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

});

   function funreload(event) {
	
	 var branchval = document.getElementById("cmbbranch").value;
	 var fromdate = $('#fromdate').val();
	 var todate = $('#todate').val();
     
	  $("#overlay, #PleaseWait").show();
	  $("#jqxWorkOrderStatusGrid").jqxGrid('clear');
	  
	  $("#maintenanceDiv").load("maintenanceDetailsGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate);
	
	}

	
	function funExportBtn() {
		$("#jqxWorkOrderStatusGrid").excelexportjs({
			containerid: "jqxWorkOrderStatusGrid",
			datatype: 'json',
			dataset: null,
			gridId: "jqxWorkOrderStatusGrid",
			columns: getColumns("jqxWorkOrderStatusGrid") ,
			worksheetName:"Work Order Status"
		});
	}
	
 
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
	
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td align="right"><label class="branch">From</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr><td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2"><div id="maintenanceDiv"><jsp:include page="maintenanceDetailsGrid.jsp"></jsp:include></div></td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		 <tr>
		    <td><div id="workOrderStatusDiv"><jsp:include page="workOrderStatusGrid.jsp"></jsp:include></div></td>
		 </tr> 
	</table>
</td>
</tr>
</table>

<input type="hidden" id="chkgrid" name="chkgrid" value='<s:property value="chkgrid"/>'>
 <input type="hidden" id="chkdatails" name="chkdatails" value='<s:property value="chkdatails"/>'>
  <input type ="hidden" id="emptype" value='<s:property value="chkdatails"/>'>
   <input type ="hidden" id="empname"  value='<s:property value="chkdatails"/>'>
</div>
</div>

</body>
</html>
