<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<% String contextPath=request.getContextPath();%>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

<style type="text/css">
.tabheight{
height:140px;
}
</style>

<script type="text/javascript">

$(document).ready(function () {

	 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#accountDetailsWindow').jqxWindow('close');
	
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	 
	 $('#txtaccid').dblclick(function(){
	      if($('#cmbtype').val()==''){
			 $.messager.alert('Message','Please Choose Account Type.','warning');
			 return 0;
		  }
		  accountsSearchContent('accountsDetailsSearch.jsp');
	 });
	}); 
	     
function getAccType(event){
    var x= event.keyCode;
    if(x==114){
	  if($('#cmbtype').val()==''){
		  $.messager.alert('Message','Please Choose Account Type.','warning');
		  return 0;
	  }
  	  accountsSearchContent('accountsDetailsSearch.jsp');
    }
    else{
     }
    }     
function accountsSearchContent(url) {
    $('#accountDetailsWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#accountDetailsWindow').jqxWindow('setContent', data);
	$('#accountDetailsWindow').jqxWindow('bringToFront');
}); 
}

function clearAccountInfo(){
	$('#txtdocno').val('');$('#txtaccid').val('');$('#txtaccname').val('');
	document.getElementById("txtaccid").placeholder = "Press F3 to Search";
	
	
} 
function funreload(event){
	
	 var branchval = document.getElementById("cmbbranch").value;
	 var atype = $('#cmbtype').val();
	 var acno = $('#txtaccid').val();
	 var check=1;
	 
	  if(atype==''){
		 $.messager.alert('Message','Please Choose Account Type.','warning');
		 return 0;
	 } 
	 
	 
	 $("#overlay, #PleaseWait").show();
	 
	 $("#apctdiv").load("applycorrectionGrid.jsp?branchval="+branchval+'&check='+check+'&atype='+atype+'&acno='+acno);
	 
	}
	
	
function funupdate()
{
	
	var rows=$("#jqxapctgrid").jqxGrid('selectedrowindexes');
	rows = rows.sort(function(a,b){return a - b});
 //alert(rows)
	if(rows.length==0){
	$("#overlay, #PleaseWait").hide();
	$.messager.alert('Warning','Select documents.');
	return false;
	}  
	
	var doc_no=document.getElementById("doc_no").value;	
	var atype=document.getElementById("cmbtype").value;
	
	
	 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
   	  
	       
     	if(r==false)
     	  {
     		return false; 
     	  }
     	else{
     		savedata(doc_no,atype);
     	}
	     });
	
}

function savedata(doc_no,atype)
{

var x=new XMLHttpRequest();
x.onreadystatechange=function(){
if (x.readyState==4 && x.status==200)
	{

	var items = x.responseText.trim();
	if(parseInt(items)>0){
		document.getElementById("doc_no").value="";
		
	    document.getElementById("atype").value="";
		document.getElementById("txtdocno").value="";
		document.getElementById("txtaccname").value="";
		document.getElementById("txtaccid").value="";
		document.getElementById("txtaccid").placeholder = "Press F3 to Search";
	
	 	funreload(event);
	 	$.messager.alert('Message', '  Record Successfully Updated ', function(r){
			     
		     });
}else{
	$.messager.alert('Message', '  Not Updated ');
	
  }
 }
}
 x.open("GET","saveData.jsp?doc_no="+doc_no+"&atype="+atype,true);
x.send();


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
	<table width="100%">
		<jsp:include page="../../heading.jsp"></jsp:include>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 
	 
					<tr>
									<td align="right"><label class="branch">Type</label></td>
									<td align="left"><select id="cmbtype" name="cmbtype"
										style="width: 40%;"
										onchange="clearAccountInfo()"
										value='<s:property value="cmbtype"/>'>
											<option value="" >--Select--</option>
											<option value="AR" selected>AR</option>
											<option value="AP">AP</option>
									</select></td>
								</tr>
								<tr>
									<td align="right"><label class="branch">Account</label></td>
									<td align="left"><input type="text" id="txtaccid"
										name="txtaccid" style="width: 60%; height: 20px;"
										readonly="readonly" placeholder="Press F3 to Search"
										value='<s:property value="txtaccid"/>'
										onkeydown="getAccType(event);" /></td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td><input type="text" id="txtaccname" name="txtaccname"
										style="width: 100%; height: 20px;" readonly="readonly"
										value='<s:property value="txtaccname"/>' tabindex="-1" /> <input
										type="hidden" id="txtdocno" name="txtdocno"
										value='<s:property value="txtdocno"/>' /></td>
								</tr>
								<tr> <td>
     <input type="hidden" name="doc_no" id="doc_no" value='<s:property value="doc_no"/>' >
     <input type="hidden" name="atype" id="atype"  value='<s:property value="atype"/>' >
     </td></tr>
								<tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
  
   <tr><td  align="center" colspan="2"><input type="Button" name="Update" id="Update" class="myButton" value="Update" onclick="funupdate()">
 
<tr class="tabheight"><td >&nbsp;</td></tr>

       
  </table>
  
   </fieldset>

</td>
<td width="80%">
	<table width="100%">
		<tr>
			  <td><div id="apctdiv"><jsp:include page="applycorrectionGrid.jsp"></jsp:include></div></td> 
			  </tr>
			 
	</table>
</tr>
</table>
</div>
</div>
<div id="accountDetailsWindow">
<div></div>
<div></div>
</div>
</body>
</html>
  