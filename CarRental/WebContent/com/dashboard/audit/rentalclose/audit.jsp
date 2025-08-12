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
<style type="text/css">
	#rowheight{
	   height : 210px;
	}
</style>
<script type="text/javascript">

$(document).ready(function () {
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
     $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
 	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
 	 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
});

	function funreload(event){
		 $('#txtbranchid').val('');
		 $('#txtdocno').val('');
		 $('#txtdocnoss').val('');
		 var fromdate=$('#fromdate').jqxDateTimeInput('val');
		 var todate=$('#todate').jqxDateTimeInput('val');
		 var branchval = document.getElementById("cmbbranch").value;
		 var type = $("#cmbtype").val()
		 $("#overlay, #PleaseWait").show();
		 $("#auditDiv").load('auditGrid.jsp?fromdate='+fromdate+'&todate='+todate+'&branchval='+branchval+'&type='+type+'&check=1');    
	 }
	
	function funAudit(event){
		var docno = $('#txtdocno').val();
		var branchid = $('#txtbranchid').val();
		
		if(docno==''){
			 $.messager.alert('Message','Choose an Agreement.','warning');
			 return 0;
		 }
			
		    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		 saveGridData(branchid,docno);	
		     	}
		 });
	}
	
	function saveGridData(branchid,docno,srno){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;

				$('#txtbranchid').val('');
				$('#txtdocno').val('');
				 $('#txtdocnoss').val('');
				
				$.messager.alert('Message', '  Record Successfully Updated ', function(r){
			  });
		      funreload(event); 
		  }
		}
			
	x.open("GET","saveData.jsp?branchid="+branchid+"&docno="+docno,true);
	x.send();
	}
	
	function funExportBtn(){
		 $("#auditDiv").excelexportjs({
			 containerid: "auditDiv", 
			 datatype: 'json', 
			 dataset: null, 
			 gridId: "racloseaudit", 
			 columns: getColumns("racloseaudit") , 
			 worksheetName:"Rental Close Discount List"
			 });
	 }
	
</script>

</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td width="35%" align="right"><label class="branch">From Date</label></td>
	<td width="65%" align="left"><div id="fromdate" name="fromdate"></div></td></tr> 
	<tr>
	  <td align="right"><label class="branch">To Date</label></td>
	  <td><div id="todate" name="todate"></div></td>
	</tr>
	<tr><td align="right"><label class="branch">Type</label></td>
	<td align="left"> <select id="cmbtype" name="cmbtype">
		<option value="">All</option>
		<option value="0">Not Audited</option>
		<option value="1">Audited</option>  
	</select></td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
    <tr><td align="right"><label class="branch">Agreement</label></td>
	<td align="left"><input type="hidden" id="txtdocno" name="txtdocno" style="width:75%;height:20px;" readonly="readonly" value='<s:property value="txtdocno"/>'/>
	
	<input type="text" id="txtdocnoss" name="txtdocnoss" style="width:75%;height:20px;" readonly="readonly" value='<s:property value="txtdocnoss"/>'/>
	</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><button class="myButton" type="button" id="btnaudit" name="btnaudit" onclick="funAudit(event);">Audit</button></td></tr>
	<tr id="rowheight"><td colspan="2">&nbsp;</td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="auditDiv"><jsp:include page="auditGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>

<input type="hidden" name="txtbranchid" id="txtbranchid" style="height:20px;width:70%;" value='<s:property value="txtbranchid"/>'>

</div> 
</body>
</html>