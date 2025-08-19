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
	 $('#clientDetailsWindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	 $('#clientDetailsWindow').jqxWindow('close');
	 $('#driverDetailsWindow').jqxWindow({width: '55%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Driver Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#driverDetailsWindow').jqxWindow('close');
	
	 $('#agreementDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Agreement Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#agreementDetailsWindow').jqxWindow('close');
	 document.getElementById("rdra").checked=true;
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));

	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	 $('#todate').on('change', function (event) {
			
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }   
	 });
	 $('#btnstatus').attr('disabled', true);

	  $('#txtclientname').dblclick(function(){
		  clientSearchContent('clientDetailsSearchGrid.jsp');
		});
	  
	  $('#vocnos').dblclick(function(){
		  var branchval = document.getElementById("cmbbranch").value; 
			 if(document.getElementById("rdra").checked==true)
				{
				    agreementSearchContent('agreementDetailsSearch.jsp?branchval='+branchval+'&rad=1');
				 }
			 else if(document.getElementById("rdla").checked==true)

				 {
				    agreementSearchContent('agreementDetailsSearch.jsp?branchval='+branchval+'&rad=0');
				 }
	 

	  
	  
	  
	  });
});

	function clientSearchContent(url) {
	    $('#clientDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientDetailsWindow').jqxWindow('setContent', data);
		$('#clientDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function agreementSearchContent(url) {
	 	$('#agreementDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#agreementDetailsWindow').jqxWindow('setContent', data);
		$('#agreementDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getClient(event){
	    var x= event.keyCode;
	    if(x==114){
	    	 if(document.getElementById("rdra").checked==true)
				{
	    	clientSearchContent('clientDetailsSearchGrid.jsp?rad=1');
				}
	    	 else if(document.getElementById("rdla").checked==true)

			 {
	 	    	clientSearchContent('clientDetailsSearchGrid.jsp?rad=0');

			 }
	    }
	    else{}
	    }
	
	function getAgreement(event){
	    var x= event.keyCode;
	    if(x==114){
	    	var branchval = document.getElementById("cmbbranch").value;
	    	var rad=null;
	    	 if(document.getElementById("rdra").checked==true)
				{
				    agreementSearchContent('agreementDetailsSearch.jsp?branchval='+branchval+'&rad=1');
				 }
			 else if(document.getElementById("rdla").checked==true)

				 {
				    agreementSearchContent('agreementDetailsSearch.jsp?branchval='+branchval+'&rad=0');
				 }
	 	
	    
	    
	    }
	    else{}
	    }
	
/* 	function funSearchdblclick(){
		
	}
	 */
	  function funExportBtn(){
		 var client=document.getElementById("hidclient").value;
		 if(document.getElementById("rdra").checked==true)
			 {
			 $("#masterDiv").excelexportjs({
					containerid: "masterDiv",   
					datatype: 'json',
					dataset: null,
					gridId: "detailsgrid",
					columns: getColumns("detailsgrid") ,   
					worksheetName:"RA Driver Update "  
				});
			 
			 $("#DriverDiv").excelexportjs({
					containerid: "DriverDiv",   
					datatype: 'json',
					dataset: null,
					gridId: "jqxDriver",
					columns: getColumns("jqxDriver") ,   
					worksheetName:client 
				});
			 
			 }
		 else  if(document.getElementById("rdla").checked==true)

			 {
			 $("#masterDiv").excelexportjs({
					containerid: "masterDiv",   
					datatype: 'json',
					dataset: null,
					gridId: "detailsgrid",
					columns: getColumns("detailsgrid") ,   
					worksheetName:"LA Driver Update "  
				});
			 
			 $("#DriverDiv").excelexportjs({
					containerid: "DriverDiv",   
					datatype: 'json',
					dataset: null,
					gridId: "jqxDriver",
					columns: getColumns("jqxDriver") ,   
					worksheetName:client  
				});	 
			 }	 
	 } 

	function  funClearData(){
		 $('#txtclientname').val('');
		 $('#txtcldocno').val('');
		 $('#rentaltype').val('');
		 $('#txtagreementno').val('');
		 $('#vocnos').val('');
		 $('#todate').val(new Date());
		 $('#clstatuss').val('');
         $("#jqxDriver").jqxGrid('clear');


	//$('input[type=radio]').prop("checked", false);

		 var onemounth=new Date(new Date((new Date())).setMonth(new Date().getMonth()-1)); 
		
		 $('#fromdate').val(onemounth);
           $('#todate').val(new Date());
	     
		 if (document.getElementById("txtclientname").value == "") {
		        $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
		    }
		 if (document.getElementById("vocnos").value == "") {
		        $('#vocnos').attr('placeholder', 'Press F3 to Search'); 
		    }
	 }
	
	function funreload(event){
		

		  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  } 
		   else
			   {
				 
				
		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var cldocno = $('#txtcldocno').val();
	 
		 var agmtno = $('#txtagreementno').val();
		 
		   $("#overlay, #PleaseWait").show();
		   if(document.getElementById("rdra").checked==true)
			 {
		 $("#masterDiv").load("detailsGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&cldocno='+cldocno+'&agmtno='+agmtno+'&rad=1');
			 }
		   else  if(document.getElementById("rdla").checked==true)

			 {
				 $("#masterDiv").load("detailsGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&cldocno='+cldocno+'&agmtno='+agmtno+'&rad=0');

			   }
			   }
	}
	function chktype()
	{
		
		
	/* 	 if($('#rentaltype').val()=="")
		  {
			  $.messager.alert('Message','Select Type  ','warning');   
				 document.getElementById("rentaltype").focus(); 
			   return false;
	
		  } */
		
		
	}
	
	
	
	function changeStatus()
	{
		var drid = $('#hiddrid').val();
		var status = $('#hidstatus').val();
		var type = $('#hidtype').val();
        var rdocno=$('#hidrdoc').val();
        var cldocno=$('#hidcldocno').val();
		if(drid==""){
			 document.getElementById("errormsg").innerText="Choose a Driver.";
			 return 0;
		 }
		
		
		$.messager.confirm('Message', 'Do you want to save changes?', function(r){
			 if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
					updateStatus(drid,status,type,rdocno,cldocno);
		     	}
		  });
		
			
	}
	function updateStatus(drid,status,type,rdocno,cldocno)
	{

		var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
					var items=x.responseText;
					  if(items>0)
						  {
						  $.messager.alert('Message', '   Successfully Updated ', function(r){
						  });

						  }
					  else
						  {
						  $.messager.alert('Message', '   Not Updated ', function(r){
						  });
						  }
         			  	$('#DriverDiv').load('driver.jsp?cldocno='+cldocno+'&docno='+rdocno+'&type='+type);	

						 $('#btnstatus').attr('disabled', true);
						 $('#hidtype').val('');
						 $('#hidrdoc').val('');
						 $('#hidstatus').val('');
						 $('#hiddrid').val('');

				 }
			}
																	
		x.open("GET","updateData.jsp?drid="+drid+"&status="+status+"&type="+type+"&rdocno="+rdocno,true);
		x.send();
		}
	
	
	 function funAdditionalDriverSearch(){
		  var indexVal1 = document.getElementById("hidcldocno").value;
		  var indexVal2 = document.getElementById("type").value;
		  var indexVal3 = document.getElementById("hiddoc").value;
			 
		   
			 
			 if(indexVal3==''){
				 $.messager.alert('Message','Agreement No. is Mandatory.','warning');
				 return 0;
			 }
			 
		  
			   if(indexVal1>0 && indexVal3!=""){
				   driverSearchContent("driverDetailMultiSearch.jsp?clientId="+indexVal1+"&raType="+indexVal2+"&raNo="+indexVal3);
			   
		   }  
	  }
	  
	  function funAdditionalDriverAdd(){
		 
		var cldocno=document.getElementById("hidcldocno").value;
		var brhid=document.getElementById("hidbrhid").value;
		var type=document.getElementById("type").value;
		var rdocno=document.getElementById("hiddoc").value;
//alert(type);
			var array=new Array();		 
		  
		  var rows = $("#jqxDriver").jqxGrid('getrows');
		  
		  if(rows.length==0){
			  document.getElementById("errormsg").innerText="Add atleast one Driver.";
			  return 0;
		  }
		  for(var i=0 ; i < rows.length ; i++){
				
			   array.push(rows[i].dr_id+" :: "+rows[i].srno);
			//	  alert(rows[i].dr_id+" :: "+rows[i].srno);

		 }
		  $.messager.confirm('Message', 'Do you want to save changes?', function(r){
				 if(r==false)
			     	  {
			     		return false; 
			     	  }
				
				 else
					 {
				ajaxcall(array,cldocno,brhid,type,rdocno);
				 
					 }
					 });
	  }
	  
	  
	  function 	ajaxcall(array,cldocno,brhid,type,rdocno)
		{

			var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
					{
						var items=x.responseText;
						  if(items>0)
							  {
							  $.messager.alert('Message', '   Successfully Updated ', function(r){
							  });

							  }
           			  	$('#DriverDiv').load('driver.jsp?cldocno='+cldocno+'&docno='+rdocno+'&type='+type);	

							 $('#btnstatus').attr('disabled', true);
							// $('#hidcldocno').val('');
							 $('#hidbrhid').val('');
							 $('#type').val('');
							 $('#hiddoc').val('');

					 }
				}
																		
		  x.open("GET","savedata.jsp?array="+array+"&cldocno="+cldocno+"&brhid="+brhid+"&type="+type+"&rdocno="+rdocno,true); 
			x.send();
			}
		
	  
	 
	 
	  function driverSearchContent(url) {
		 	$('#driverDetailsWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#driverDetailsWindow').jqxWindow('setContent', data);
			$('#driverDetailsWindow').jqxWindow('bringToFront');
		}); 
		}
	  
	function clearagno()
	{
		$('#txtagreementno').val('');
		$('#vocnos').val('');
		
	}
	
	
	


	
		  
		  
		 
	
	
	
	

</script>
<style>
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
    <tr>
	 <td align="right"><label class="branch">From</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>
	<tr>
	<td></td>
	<td width="right" ><input type="radio" id="rdra" name="rdo"  value="rdra" ><label for="rdra" class="branch">RA</label>
    <input type="radio" id="rdla" name="rdo"  value="rdla" ><label for="rdla" class="branch">LA</label></td>
	
	</tr>
	<tr><td align="right"><label class="branch">Client</label></td>
	<td align="left"><input type="text" id="txtclientname" name="txtclientname" style="width:100%;height:20px;" readonly="readonly" placeholder="Press F3 to Search"  onkeydown="getClient(event);" value='<s:property value="txtclientname"/>'/>
    <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/></td></tr>
 
	 
	<tr><td align="right"><label class="branch">Agreement</label></td>
	<td align="left"><input type="text" id="vocnos" name="vocnos" style="width:100%;height:20px;" readonly="readonly" onfocus="chktype()" placeholder="Press F3 to Search"  onkeydown="getAgreement(event);" value='<s:property value="vocnos"/>'/>
	</td></tr>
	
	<tr><td colspan="2"><input type="hidden" id="txtagreementno" name="txtagreementno" style="width:100%;height:20px;"  value='<s:property value="txtagreementno"/>'/></td></tr>

<!-- 	<button class="myButton" type="button" id="btnSalikInvoicePrint" name="btnSalikInvoicePrint" onclick="funSalikInvoicePrint();">Print</button> --></td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
		<tr><td colspan="2">&nbsp;</td></tr>
		
			<tr>
			<td><input type="button" class="myButton" name="btnstatus" id="btnstatus"  value="Activate" onclick="changeStatus();"></td>
			<td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearData();">
			</td>
			<td>
			<input type="hidden" id="hiddrid" name="hiddrid"   value='<s:property value="hiddrid"/>'/>
			<input type="hidden" id="hidstatus" name="hidstatus"   value='<s:property value="hidstatus"/>'/>
			<input type="hidden" id="hidtype" name="hidtype"   value='<s:property value="hidtype"/>'/>
			<input type="hidden" id="hidrdoc" name="hidrdoc"   value='<s:property value="hidrdoc"/>'/>
			<input type="hidden" id="hidcldocno" name="hidcldocno"   value='<s:property value="hidcldocno"/>'/>
			<input type="hidden" id="type" name="type"   value='<s:property value="type"/>'/>
			<input type="hidden" id="hiddoc" name="hiddoc"   value='<s:property value="hiddoc"/>'/>
			<input type="hidden" id="drivergridlength" name="drivergridlength"/>
			<input type="hidden" id="hidbrhid" name="hidbrhid"   value='<s:property value="hidbrhid"/>'/>
		 <input type="hidden" id="hidclient" name="hidclient"   value='<s:property value="hidclient"/>'/>
			
			</td>
					
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
	<tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2">&nbsp;</td></tr> 
	
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="masterDiv"><jsp:include page="detailsGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
	
	<fieldset style="background-color:#ECF8E0;"><legend><b> Driver</b></legend>
<input type="hidden" id="adddriverintickval" name="adddriverintickval" value='<s:property value="adddriverintickval"/>'>
<table width="100%">
  <tr>
    <td width="7%" align="center"><button type="button" class="icon1" id="btnAdditionalDriverSearch" title="Search Additional Driver" onclick="funAdditionalDriverSearch();">
							<img alt="Search Additional Driver" src="<%=contextPath%>/icons/driverSearch.png">
						</button></td>
    <td width="7%" align="left"><button type="button" class="icon1" id="btnAdditionalDriverAdd" title="Add Additional Driver" onclick="funAdditionalDriverAdd();">
							<img alt="Add Additional Driver" src="<%=contextPath%>/icons/driverAdd.png">
						</button></td>
    <td width="6%" align="right"></td>
    <td width="19%" hidden="true"><input type="text" id="txtamount" name="txtamount" style="width:70%;text-align: right;" value='<s:property value="txtamount"/>' onblur="funRoundAmt(this.value,this.id);" /></td>
    <td width="8%" align="right"></td>
    <td width="53%" hidden="true"><input type="text" id="txtdescription" name="txtdescription" style="width:65%;" value='<s:property value="txtdescription"/>'/></td>
  </tr>
</table>
<div id="DriverDiv"><jsp:include page="driver.jsp"></jsp:include></div><br/>

</fieldset>
	
</tr>
</table>
</div>

<div id="clientDetailsWindow">
	<div></div><div></div>
</div>
<div id="agreementDetailsWindow">
	<div></div><div></div>
</div>
<div id="driverDetailsWindow">
	<div></div><div></div>
</div>
</div> 
</body>
</html>