<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Employee Inactive</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" /> 



<script type="text/javascript">

$(document).ready(function () {
	
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		
});
function funreload(event){
	
	 $("#overlay, #PleaseWait").show();
	 var date=$('#date').jqxDateTimeInput('val');
		
	 $("#empinactivegridDiv").load("employeeinactiveGrid.jsp?check=1");
}
function funExportBtn() {
	 $("#empinactivegridDiv").excelexportjs({  
		 containerid: "empinactivegridDiv", 
		 datatype: 'json', 
		 dataset: null, 
		 gridId: "employeeinactiveGridId", 
		 columns: getColumns("employeeinactiveGridId") ,   
		 worksheetName:"Employee Termination"
		 });
}


function funTerminate(event){
	var date =  $('#date').val();
	var hiddocno=$('#hiddocno').val();
	
	 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
	        
	     	if(r==false)
	     	  {
	     		return false; 
	     	  }
	     	else{
	     		saveData(date,hiddocno);	
	     	}
	});
}

function saveData(date,hiddocno){
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200){
     			
			var items=x.responseText;
			
			$('#date').val(new Date());
			var hiddocno = $('#hiddocno').val('');
			
			if(parseInt(items)>0){
				$.messager.alert('Message', ' Record Successfully Updated ', function(r){
			    });
				}else{
					$.messager.alert('Message', ' Not Updated ', function(r){
				    });
						
				}
			funreload(event); 
			
			}
	}
		
x.open("GET","savedata.jsp?date="+date+"&hiddocno="+hiddocno,true);
x.send();
		
}



	
</script>
<style type="text/css">
.tabheight{
height:250px;
}
</style>

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
	<tr ><td >&nbsp;</td></tr>
	<tr ><td >&nbsp;</td></tr>
	
	<tr>
		<td align="left" colspan="2">
		<table>
		 <tr><td align="right"><label class="branch">Termination Date</label></td><td><div id="date" name="date"></div></td></tr>
	 <tr ><td >&nbsp;</td></tr>
	<tr><td><input type="hidden" name="hiddocno" id="hiddocno" value='<s:property value="hiddocno"/>'></td></tr>
			  		
	<tr><td colspan="2" align="center">&nbsp;<button class="myButton" type="button" id="btnterm" name="btnterm" onclick="funTerminate(event);">Terminate</button></td></tr>
	
	
	<tr class="tabheight"><td >&nbsp;</td></tr>
	</table>
	</td>
	</tr>
  </table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="empinactivegridDiv"><jsp:include page="employeeinactiveGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>

</div>

</body>
</html>
	
