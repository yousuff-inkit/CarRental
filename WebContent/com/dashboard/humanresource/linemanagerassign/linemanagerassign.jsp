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
		 
		 $('#userDetailsWindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '50%' ,maxWidth: '20%' , title: 'Employee Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
				 $('#userDetailsWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
	     $('#txtusername').dblclick(function(){
			  userDetailsSearchContent('userDetailsSearchGrid.jsp');
		 });
		    	     
	});

	function userDetailsSearchContent(url) {
	    $('#userDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#userDetailsWindow').jqxWindow('setContent', data);
		$('#userDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getUserDetails(event){
        var x= event.keyCode;
        if(x==114){
        	userDetailsSearchContent('userDetailsSearchGrid.jsp');
        }
        else{}
        }
	
	function funreload(event){
		 $("#overlay, #PleaseWait").show();
		 
		 	$("#empUserLinkDiv").load("linemanagerassignGrid.jsp?check=1");
	}
	
	
	function funUpdate()
	{
		

		 $('#empUserLinkGridID').jqxGrid('clearfilters');
		 var selectedrows = $("#empUserLinkGridID").jqxGrid('selectedrowindexes');
		 selectedrows = selectedrows.sort(function(a,b){return a - b});

		 if(selectedrows.length==0){
			 $.messager.alert('Warning','Please select a document!');    
			return false;
		}
		 var salid=$("#salesman_txt").val();
		 if(salid==0){
			 $.messager.alert('Warning','Please select Salesman!');    
				return false;

		 }
			
		 var i=0,j=0;
		 var temptrno="";
		 for (i = 0; i < selectedrows.length; i++) {
			 if(i==0){  
				 var srvdetmtrno= $('#empUserLinkGridID').jqxGrid('getcellvalue', selectedrows[i], "docno");
				 temptrno=srvdetmtrno;   
			 }  
				else{  
					var srvdetmtrno = $('#empUserLinkGridID').jqxGrid('getcellvalue', selectedrows[i], "docno");
					temptrno=temptrno+","+srvdetmtrno;     
				}
				j++; 
		 }
				
		
		 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		     	  
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		 savegriddata(temptrno,salid);	
		     	}
			     });
		
		
		
	}
	function savegriddata(temptrno,salid)
	{
		//alert(ra_no);
		
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;
				 
				 document.getElementById("ra_no").value="";
				 document.getElementById("txtusername").value="";
				 document.getElementById("salesman_txt").value="";
				 funreload(event); 
				 $("#empUserLinkGridID").jqxGrid('clear');
				 $('#txtusername').attr('placeholder', 'Press F3 TO Search'); 
				 if(items>0){ 
				      $.messager.alert('Message','Record Successfully Updated','success');
				}else{
					  $.messager.alert('Message','Not Updated','warning');             
				}    
				}
		}
			
	x.open("GET","saveData.jsp?ra_no="+encodeURIComponent(temptrno)+"&salesman_txt="+salid);
	x.send(); 
	}

	function funExportBtn() {
		
		$("#empUserLinkDiv").excelexportjs({
					containerid: "empUserLinkDiv", 
					datatype: 'json', 
					dataset: null, 
					gridId: "empUserLinkGridID", 
					columns: getColumns("empUserLinkGridID") ,   
					worksheetName:"Line Manager Assign"
					});
		}
	
	function  funClearInfo() {
		    $('#txtempid').val('');
			$('#txtuserdocno').val('');
			$('#txtusername').val(''); 
			$('#txtempinfo').val(' ');
			$('#ra_no').val(' ');
			$("#empUserLinkGridID").jqxGrid('clear');
			
			if (document.getElementById("txtusername").value == "") {
		        $('#txtusername').attr('placeholder', 'Press F3 to Search'); 
		    }
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
		
	<tr><td colspan="2">&nbsp;</td></tr>
	    <tr><td align="right"><label class="branch">Line Manager</label></td>
	<td align="left"><input type="text" id="txtusername" name="txtusername" style="width:100%;height:20px;" placeholder="Press F3 to Search" readonly="readonly" onkeydown="getUserDetails(event);" value='<s:property value="txtusername"/>'/>
    <input type="hidden" id="txtuserdocno" name="txtuserdocno" value='<s:property value="txtuserdocno"/>'/></td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();"></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><input type="button" class="myButton" name="update" id="update"  value="Update" onclick="funUpdate();"></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
  	<tr><td colspan="2">&nbsp;</td></tr>
  	<tr><td colspan="2">&nbsp;</td></tr>
  	<tr><td colspan="2">&nbsp;</td></tr>
  
    <tr><td colspan="2"><input type="hidden" name="txtempid" id="txtempid" style="height:20px;width:70%;" value='<s:property value="txtempid"/>'></td></tr> 
	<tr><td><input type="hidden" name="ra_no" id="ra_no"  style="height:20px;width:50%;" value='<s:property value="ra_no"/>'></td></tr> 
    <tr><td><input type="hidden" name="salesman_txt" id="salesman_txt"  style="height:20px;width:50%;" value='<s:property value="salesman_txt"/>'></td></tr> 
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="empUserLinkDiv"><jsp:include page="linemanagerassignGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>

<div id="userDetailsWindow">
<div></div>
</div>
</div> 
</body>
</html>