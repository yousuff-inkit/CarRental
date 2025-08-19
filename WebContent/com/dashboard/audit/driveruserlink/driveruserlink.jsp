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
.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}
</style>
<script type="text/javascript">

	$(document).ready(function () {
		 $("#branchlabel").hide();
		 $("#branchdiv").hide();
		 $('#driverDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Driver Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#driverDetailsWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
	     $('#txtdriver').dblclick(function(){
	    	 driverDetailsSearchContent('driverDetailsSearch.jsp?chk=1');
		 });
	     $('#btnlinking').attr("disabled",true);  
	});

	function driverDetailsSearchContent(url) {
	    $('#driverDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#driverDetailsWindow').jqxWindow('setContent', data);
		$('#driverDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getDriver(event){
        var x= event.keyCode;
        if(x==114){
        	driverDetailsSearchContent('driverDetailsSearch.jsp?chk=1');
        }
        else{}
        }
	
	function funreload(event){  
		 $('#btnlinking').attr("disabled",true);
		 $("#overlay, #PleaseWait").show();
		 $("#userLinkDiv").load("driveruserlinkGrid.jsp?check=1");    
	}  
	
	function funLinking(event){
		var userdocno = $('#hiddocno').val();
		var driverid = $('#txtdrid').val();  
		if(userdocno==''){
			 $.messager.alert('Message','Please select a document.','warning');
			 return 0;
		 }
		
		if(driverid==''){
			 $.messager.alert('Message','Choose a driver.','warning');
			 return 0;
		 }
			
		    $.messager.confirm('Message', 'Do you want to link Driver with User?', function(r){  
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		 saveGridData(driverid,userdocno);	
		     	}
		 });
	}
	function saveGridData(driverid,userdocno) {  
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;
				
				$.messager.alert('Message', '  Record Successfully Linked ', function(r){
			  });
			  funClearInfo();
		      funreload(event); 
		  }
		}
			
	x.open("GET","saveData.jsp?driverid="+driverid+"&userdocno="+userdocno,true);
	x.send();
	}
	
	function funExportBtn(){
		 $("#userLinkDiv").excelexportjs({
			 containerid: "userLinkDiv", 
			 datatype: 'json', 
			 dataset: null, 
			 gridId: "driverlinkingGrid", 
			 columns: getColumns("driverlinkingGrid") ,   
			 worksheetName:"DriverLinking"
			 });
	 }
	
	function  funClearInfo() {
		    $('#txtdrid').val('');
			$('#txtdriver').val('');
			$('#hiddocno').val(''); 
			$('#btnlinking').attr("disabled",true);
			$("#driverlinkingGrid").jqxGrid('clear');
			
			if (document.getElementById("txtdriver").value == "") {
		        $('#txtdriver').attr('placeholder', 'Press F3 to Search');   
		    }
	}
	
</script>

</head>
<body >
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
    <tr><td align="right"><label class="branch">Driver</label></td>
	<td align="left"><input type="text" id="txtdriver" name="txtdriver" style="width:100%;height:20px;" placeholder="Press F3 to Search" readonly="readonly" onkeydown="getDriver(event);" value='<s:property value="txtdriver"/>'/>
    <input type="hidden" id="txtdrid" name="txtdrid" value='<s:property value="txtdrid"/>'/></td></tr>     
	<tr><td colspan="2" align="center"><button class="myButton" type="button" id="btnlinking" name="btnlinking" onclick="funLinking(event);">Linking</button></td></tr>
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();"></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>   
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2"><input type="hidden" name="hiddocno" id="hiddocno" style="height:20px;width:70%;" value='<s:property value="hiddocno"/>'></td></tr>   
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="userLinkDiv"><jsp:include page="driveruserlinkGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>

<div id="driverDetailsWindow">
<div></div>
</div>
</div> 
</body>
</html>