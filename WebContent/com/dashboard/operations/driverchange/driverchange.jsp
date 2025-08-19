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
height:190px;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
	$(".ptypehide").hide();
	$("#drvuptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	   $('#dridwindow').jqxWindow({ width: '40%', height: '40%',  maxHeight: '50%' ,maxWidth: '40%' , title: 'Driver Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#dridwindow').jqxWindow('close');
	   $('#deldridwindow').jqxWindow({ width: '40%', height: '40%',  maxHeight: '50%' ,maxWidth: '40%' , title: 'Driver Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#deldridwindow').jqxWindow('close');
	   $('#agmtnowindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Agreement Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#agmtnowindow').jqxWindow('close');

	   $('#drnames').dblclick(function(){
			
			 $('#dridwindow').jqxWindow('open');
				$('#dridwindow').jqxWindow('focus');
				 drSearchContent('getdriverDetails.jsp');
			}); 
	   
	   $('#dlvdrvs').dblclick(function(){
			
			 $('#deldridwindow').jqxWindow('open');
				$('#deldridwindow').jqxWindow('focus');
				 deldrSearchContent('getdeldriverDetails.jsp');
			}); 
	   
	   $('#docnoos').dblclick(function(){
			 if(document.getElementById("agmttype").value==""){
				 $.messager.alert('warning','Please Select Agreement Type');
					document.getElementById("agmttype").focus();
				 return false;
			 }
			
			 $('#agmtnowindow').jqxWindow('open');
				$('#agmtnowindow').jqxWindow('focus');
				 agmtSearchContent('agmtSearch.jsp?agmttype='+document.getElementById("agmttype").value, $('#agmtnowindow'));
			}); 
	   $("#type").change(function() {
		 if($("#type").val()==4 || $("#type").val()==3){
			 $(".ptypehide").show();
		 } else {
		 	$("#processtype").val("");
			$(".ptypehide").hide();
		 }
	   });
	     
	
   });
function funreload(event)
{
	 var barchval = document.getElementById("cmbbranch").value;
	 var type=$("#type").val();
	 var uptodate=$("#drvuptodate").val();
	 $("#overlay, #PleaseWait").show();
	  $("#drvupdiv").load("driverupdateGrid.jsp?barchval="+barchval+"&type="+type+"&uptodate="+uptodate); 
	
	
	}
	

function funExportBtn(){
	var type=$("#type").val();
	
	
		$("#drvupdiv").excelexportjs({
			containerid: "drvupdiv", 
			datatype: 'json', 
			dataset: null, 
			gridId: "drvupdategrid", 
			columns: getColumns("drvupdategrid") ,   
			worksheetName:"Driver Change - "+type
			});
		
	}
	
	
function funupdate()
{
	
	var rows=$("#drvupdategrid").jqxGrid('selectedrowindexes');
	rows = rows.sort(function(a,b){return a - b});
 //alert(rows)
	if(rows.length==0){
	$("#overlay, #PleaseWait").hide();
	$.messager.alert('Warning','Select documents.');
	return false;
	}  
	var brch=document.getElementById("hidbrhid").value;	
	var doc_no=document.getElementById("doc_no").value;	
	var voc_no=document.getElementById("voc_no").value;
	var fleet_no=document.getElementById("fleet_no").value;
	var cldocno=document.getElementById("cldocno").value;
	var hidtype=document.getElementById("hidtype").value;
	var drid=document.getElementById("drid").value;
	var type=document.getElementById("type").value;
	var drvid=document.getElementById("drvid").value;
	var agmtno=document.getElementById("agmtno").value;
	if(drvid==''){
		$.messager.confirm('Message', 'Please Select a Driver !');
		return 0;
	}
	 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
   	  
	       
     	if(r==false)
     	  {
     		return false; 
     	  }
     	else{
     		savedata(doc_no,voc_no,fleet_no,cldocno,hidtype,drid,type,drvid,agmtno,brch);
     	}
	     });
	
}
function savedata(doc_no,voc_no,fleet_no,cldocno,hidtype,drid,type,drvid,agmtno,brch)
{
	let processtype=$("#processtype").val();
var x=new XMLHttpRequest();
x.onreadystatechange=function(){
if (x.readyState==4 && x.status==200)
	{

	 	var items= x.responseText;
	
		document.getElementById("doc_no").value="";
		document.getElementById("hidbrhid").value="";
	    document.getElementById("fleet_no").value="";
		document.getElementById("voc_no").value="";
		document.getElementById("hidtype").value="";
		document.getElementById("cldocno").value="";
		document.getElementById("drid").value="";
		document.getElementById("drvid").value="";
		document.getElementById("drids").value="";
		document.getElementById("drnames").value="";
		document.getElementById("drnames").placeholder = "Press F3 to Search";
		document.getElementById("agmtno").value="";
		
	 	funreload(event);
	 	$.messager.alert('Message', '  Record Successfully Updated ', function(r){
			     
		     });
}
}
 x.open("GET","saveData.jsp?processtype="+processtype+"&doc_no="+doc_no+"&voc_no="+voc_no+"&hidtype="+hidtype+"&fleet_no="+fleet_no+"&cldocno="+cldocno+"&drid="+drid+"&type="+type+"&drvid="+drvid+"&agmtno="+agmtno+"&brch="+brch,true);
x.send();

}



function fundelupdate()
{
	
	var agmtype=document.getElementById("agmttype").value;	
	var drvid=document.getElementById("dlvdrv").value;	
	var agmdocno=document.getElementById("docnos").value;	
	var orgdrvid=document.getElementById("dlvdrvs").value;	
	var orgagmdocno=document.getElementById("docnoos").value;	
	
	if(orgagmdocno==''){
		$.messager.confirm('Message', 'Please Select a Docno !');
		return 0;
	}
	if(orgdrvid==''){
		$.messager.confirm('Message', 'Please Select a Driver !');
		return 0;
	}
	
	 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
   	  
	       
     	if(r==false)
     	  {
     		return false; 
     	  }
     	else{
     		delchkdata(agmtype,drvid,agmdocno);
     	}
	     });
	
}

 
 function delchkdata(agmtype, drvid, agmdocno) {
	    var x = new XMLHttpRequest();
	    x.onreadystatechange = function () {
	        if (x.readyState == 4 && x.status == 200) {
	            var items = x.responseText.split("####");
	            let messages = [];
	            if (parseInt(items[0]) === 1) {
	                messages.push("Already Invoiced.");
	            }
	            if (parseInt(items[1]) === 1) {
	                messages.push("Replacement Already Done.");
	            }
	            if (parseInt(items[2]) === 1) {
	                messages.push("Custody Already Done.");
	            }

	            if (messages.length > 0) {
	                $.messager.alert('Message', messages.join('<br>'));
	            }  else {
	                delsavedata(agmtype, drvid, agmdocno);
	            }
	        }
	    };
	    x.open("GET", "delcheckData.jsp?agmtype=" + agmtype + "&drvid=" + drvid + "&agmdocno=" + agmdocno, true);
	    x.send();
	}

function delsavedata(agmtype,drvid,agmdocno)
{
var x=new XMLHttpRequest();
x.onreadystatechange=function(){
if (x.readyState==4 && x.status==200)
	{

	 	var items= x.responseText;
	 	document.getElementById("dlvdrv").value="";
		document.getElementById("docnos").value="";
	    document.getElementById("dlvdrvs").value="";
		document.getElementById("docnoos").value="";
		$('#dlvdrvs').attr('placeholder','Press F3 to Search');	
		$('#docnoos').attr('placeholder','Press F3 to Search');	
		
		
			
	 	funreload(event);
	 	$.messager.alert('Message', '  Record Successfully Updated ', function(r){
			     
		     });
}
}
 x.open("GET","delsaveData.jsp?agmtype="+agmtype+"&drvid="+drvid+"&agmdocno="+agmdocno,true);
x.send();

}


function getDrid(event){
	var x= event.keyCode;
	if(x==114){
		
		  $('#dridwindow').jqxWindow('open');
			$('#dridwindow').jqxWindow('focus');
			 drSearchContent('getdriverDetails.jsp');
			 
	}
 	 

}

function getdelDrid(event){
	var x= event.keyCode;
	if(x==114){
		
		  $('#deldridwindow').jqxWindow('open');
			$('#deldridwindow').jqxWindow('focus');
			 deldrSearchContent('getdeldriverDetails.jsp');
			 
	}
 	 

}

function drSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#dridwindow').jqxWindow('setContent', data);

}); 
}

function deldrSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#deldridwindow').jqxWindow('setContent', data);

}); 
}


function getAgmtno(event){
	var x= event.keyCode;
	if(x==114){
		if(document.getElementById("agmttype").value==""){
			 $.messager.alert('warning','Please Select Agreement Type');
				document.getElementById("agmttype").focus();
			 return false;
		 }
		
		 $('#agmtnowindow').jqxWindow('open');
			$('#agmtnowindow').jqxWindow('focus');
			 agmtSearchContent('agmtSearch.jsp?agmttype='+document.getElementById("agmttype").value, $('#agmtnowindow'));
			 
	}
 	 

}

function agmtSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#agmtnowindow').jqxWindow('setContent', data);

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
	<table width="100%">
		<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	 
	 <tr><td  align="right" ><label class="branch">Upto Date</label></td><td align="left"><div id='drvuptodate' name='drvuptodate' value='<s:property value="drvuptodate"/>'></div>
                    <input type="hidden" id="hiddrvuptodate" name="hiddrvuptodate" value='<s:property value="hiddrvuptodate"/>'/></td></tr>
  
  
  
  <tr> <td  align="right"><label class="branch">Type</label></td><td align="left">
 <select name="type" id="type" style="width:80%;" name="type"  value='<s:property value="type"/>'>
     <option value="1" >Delivery</option>
     <option value="2">Collection</option>
     <option value="3">Replacement</option>
     <option value="4">Movement</option>
  </select></td></tr>
  
  
  
  <tr> <td>
     <input type="hidden" name="doc_no" id="doc_no" value='<s:property value="doc_no"/>' >
     <input type="hidden" name="voc_no" id="voc_no"  value='<s:property value="voc_no"/>' >
     <input type="hidden" name="hidtype" id="hidtype" value='<s:property value="hidtype"/>' >
     <input type="hidden" name="fleet_no" id="fleet_no" value='<s:property value="fleet_no"/>' >
     <input type="hidden" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>' >
     <input type="hidden" name="drid" id="drid" value='<s:property value="drid"/>' >
     <input type="hidden" name="drvid" id="drvid" value='<s:property value="drvid"/>' >
      <input type="hidden" name="deldrvid" id="deldrvid" value='<s:property value="deldrvid"/>' >
      <input type="hidden" name="agmtno" id="agmtno" value='<s:property value="agmtno"/>' >
        <input type="hidden" name="hidbrhid" id="hidbrhid" value='<s:property value="hidbrhid"/>' >
    
      </td> </tr>
 	
	<tr> <td  align="right" class="ptypehide"><label class="branch">Process type</label></td><td align="left" class="ptypehide">
 <select name="type" id="processtype" style="width:80%;" name="type"  value='<s:property value="processtype"/>'>
     <option value="1" >Delivery</option>
     <option value="2">Collection</option>
  </select></td></tr>
	<tr>
   <td align="right"><label class="branch">Driver</label></td>
   <td><input type="hidden" name="drids" id="drids" >
 <input type="text" name="drnames" id="drnames"  placeholder="Press F3 to Search"  style="width:80%;height:30%" onkeydown="getDrid(event);" ></td>
 </tr>
  <tr><td colspan="2">&nbsp;</td></tr>
	
	
   <tr><td  align="center" colspan="2"><input type="Button" name="driverUpdate" id="driverUpdate" class="myButton" value="Update" onclick="funupdate()">
 </td></tr>
 	<tr><td colspan="2">&nbsp;</td></tr>
 	
  
  <tr>
  <td colspan="2" >
<fieldset><legend>Delivery Details</legend>
  <table width="100%">
 
   <tr> <td  align="right"><label class="branch">Type</label></td><td align="left">
 <select name="type" id="agmttype" style="width:80%;" name="agmttype"  value='<s:property value="agmttype"/>'>
     <option value="RAG" >Rental</option>
     <option value="LAG">Lease</option>
  </select></td></tr>
 	<tr>
   <td align="right"><label class="branch">Doc No</label></td>
   <td><input type="hidden" name="docnos" id="docnos" >
 <input type="text" name="docnoos" id="docnoos"  placeholder="Press F3 to Search"  style="width:80%;height:30%" onkeydown="getAgmtno(event);" ></td>
 </tr>
 <tr>
   <td align="right"><label class="branch">Driver</label></td>
   <td><input type="hidden" name="dlvdrv" id="dlvdrv" >
 <input type="text" name="dlvdrvs" id="dlvdrvs"  placeholder="Press F3 to Search"  style="width:80%;height:30%" onkeydown="getdelDrid(event);" ></td>
 </tr>
	<tr><td colspan="2">&nbsp;</td></tr>
  <tr><td  align="center" colspan="2"><input type="Button" name="deldriverUpdate" id="deldriverUpdate" class="myButton" value="Update" onclick="fundelupdate()">
 </td></tr>
 	<tr><td colspan="2">&nbsp;</td></tr>
 	</table>
</fieldset>
</td></tr>

<tr class="tabheight"><td >&nbsp;</td></tr>     

       
  </table>
  
   </fieldset>

</td>
<td width="80%">
	<table width="100%">
		<tr>
			  <td><div id="drvupdiv"><jsp:include page="driverupdateGrid.jsp"></jsp:include></div></td> 
			  </tr>
			 
	</table>
</tr>
</table>
</div>
</div>
<div id="dridwindow">
<div></div>
</div>
<div id="deldridwindow">
<div></div>
</div>
<div id="agmtnowindow">
<div></div>
</div>
</body>
  
  