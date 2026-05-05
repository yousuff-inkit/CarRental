
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
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
	
	 $("#jqxDeliveryOut").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	 $("#jqxDelTimeOut").jqxDateTimeInput({  width: '20%', height: '17px', formatString: 'HH:mm', showCalendarButton: false ,value: new Date()});
	 $("#jqxDateOut").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#jqxTimeOut").jqxDateTimeInput({  width: '20%', height: '17px', formatString: 'HH:mm', showCalendarButton: false });
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     $('#chauffeurinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Driver Search' ,position: { x: 200, y: 70 }, keyboardCloseKey: 27});
	     $('#chauffeurinfowindow').jqxWindow('close');

	 $('#jqxDeliveryOut').on('change', function (event) {
		
		if( $('#fleetno').val()!="")
			{
		 
		   var indate1=new Date($('#jqxDateOut').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var agmtdate1=new Date($('#jqxDeliveryOut').jqxDateTimeInput('getDate')); //del date
			  indate1.setHours(0,0,0,0);
			  agmtdate1.setHours(0,0,0,0); 
		   if(indate1>agmtdate1){
			   $.messager.alert('Message',' Delivery Date Cannot Be Less Than Out Date','warning');   
			 
		   return false;
		   
		   
		   }
		   
		  }   
		
	
	        
		  
	
	       });
	 
	
	  $('#jqxDelTimeOut').on('change', function (event) {
		   
		  if( $('#fleetno').val()!="")
			{
		   var indate1=new Date($('#jqxDateOut').jqxDateTimeInput('getDate'));     // out date
		  var agmtdate1=new Date($('#jqxDeliveryOut').jqxDateTimeInput('getDate')); //del date
		 
		  var intime1=new Date($('#jqxTimeOut').jqxDateTimeInput('getDate'));  //out time
		  var agmttime1=new Date($('#jqxDelTimeOut').jqxDateTimeInput('getDate')); // del time  

		  indate1.setHours(0,0,0,0);
		  agmtdate1.setHours(0,0,0,0); 
		   if(indate1>agmtdate1){
			   $.messager.alert('Message',' Delivery Date Cannot Be Less Than Out Date','warning');   	   
			 
		//  alert("Delivery Date Cannot be Less than Out Date");
		   return false;
		  }   
		
		   if(indate1.valueOf()==agmtdate1.valueOf()){
		 
		  var out=intime1.getHours();
		  var del=agmttime1.getHours();
		
		  if(out > del){
			  $.messager.alert('Message',' Delivery Time Cannot Be Less Than Out Time','warning');   
			   
			  
		  // alert("Delivery Time Cannot be Less than Out Time");
		    return false;
		   }
		   if(out==del){
		    if(intime1.getMinutes()>agmttime1.getMinutes()){
		    	  $.messager.alert('Message',' Delivery Time Cannot Be Less Than Out Time','warning');   
		    	
		     return false;
		    }
		   }
		  }
		  
			}
		  
		  
	
	       });
	  
 $('#del_Driver').dblclick(function(){
    	  
    	  if($("#chktype").val()=="VCU")
    		  {
	  	    $('#chauffeurinfowindow').jqxWindow('open');
  
  chauffeurSearchContent('SearchDriver.jsp?', $('#chauffeurinfowindow')); 
    		  }
	 });
      
});


function getchauffeur(event){
	  if($("#chktype").val()=="VCU")
	  {
  	 var x= event.keyCode;
  	 if(x==114){
  	  $('#chauffeurinfowindow').jqxWindow('open');
  
     
   chauffeurSearchContent('SearchDriver.jsp?', $('#chauffeurinfowindow'));  	 }
  	 else{
  		 }
	  }
  	 }

function chauffeurSearchContent(url) {
   
$.get(url).done(function (data) {
	
 $('#chauffeurinfowindow').jqxWindow('setContent', data);

	   }); 
}


function funExportBtn(){
	 //  $("#delupdategrid").jqxGrid('exportdata', 'xls', 'LAG-Delivery Update');
	   
	   
	   
		
		 if(parseInt(window.parent.chkexportdata.value)=="1")
		 {
		 JSONToCSVCon(datass, 'LAG-Delivery Update', true);
		 }
	 else
		 {
		   $("#delupdategrid").jqxGrid('exportdata', 'xls', 'LAG-Delivery Update');
		 }
		
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	 }

function funreload(event)
{
	disitems();
	 var barchval = document.getElementById("cmbbranch").value;
	
	   $("#overlay, #PleaseWait").show();
	  $("#delupdiv").load("delupdateGrid.jsp?barchval="+barchval);
	
	
	}
	
function funAttachBtn(){
	if ($("#rentaldoc").val()!="" && $("#chktype").val()=="LAG") {
		  $("#windowattach").jqxWindow('setTitle',"LAG - "+document.getElementById("rentaldoc").value);
		changeAttachContent("<%=contextPath%>/com/dashboard/Attach.jsp?formCode=LAG&docno="+document.getElementById("rentaldoc").value+"&barchvals="+document.getElementById("branchids").value);		
	} else {
		$.messager.alert('Message','Select a Document....!','warning');
		return;
	}
}
function changeAttachContent(url) {
	$.get(url).done(function (data) {
		    $('#windowattach').jqxWindow('open');
			$('#windowattach').jqxWindow('setContent',data);
			 $('#windowattach').jqxWindow('bringToFront');
}); 
}	

	

function funupdate()
{
	
	
	 if(document.getElementById("del_Driver").value=="")
	 {
 
				 
		  $.messager.alert('Message',' Search Driver','warning'); 
		 return 0;
	 }
	
	 if(document.getElementById("del_KM").value=="")
	 {
		  $.messager.alert('Message','Enter KM','warning');   	 
		 
		 return 0;
	 }
	
	 if($('#del_Fuel').val()=="")
	 {
		  $.messager.alert('Message',' Select Fuel ','warning');  
		
		
		 return 0;
	 }
	 
	
	 var outkm=document.getElementById("out_km").value;
		//alert("out"+outkm);
	 	var delkm=document.getElementById("del_KM").value;
	   if((parseFloat(delkm)<parseFloat(outkm)))
		   
	 	
	 	{
		   $.messager.alert('Message','Delivery KM Less Than Out KM ','warning');  
		  
		   return 0;
	 	}
	  var indate1=new Date($('#jqxDateOut').jqxDateTimeInput('getDate'));     // out date
	  var agmtdate1=new Date($('#jqxDeliveryOut').jqxDateTimeInput('getDate')); //del date
	 
	  var intime1=new Date($('#jqxTimeOut').jqxDateTimeInput('getDate'));  //out time
	  var agmttime1=new Date($('#jqxDelTimeOut').jqxDateTimeInput('getDate')); // del time  

	  indate1.setHours(0,0,0,0);
	  agmtdate1.setHours(0,0,0,0); 
	   if(indate1>agmtdate1){
		   $.messager.alert('Message',' Delivery Date Cannot Be Less Than Out Date ','warning');  
		  
	   return 0;
	  }   
	
	   if(indate1.valueOf()==agmtdate1.valueOf()){
	 
	  var out=intime1.getHours();
	  var del=agmttime1.getHours();
	
	  if(out > del){
		  $.messager.alert('Message',' Delivery Time Cannot Be Less Than Out Time ','warning');   
		 
	    return 0;
	   }
	   if(out==del){
	    if(intime1.getMinutes()>agmttime1.getMinutes()){
	    	 $.messager.alert('Message',' Delivery Time Cannot Be Less Than Out Time ','warning');   
	    	 
	     return 0;
	    }
	   }
	  }
		
		
	var drid=document.getElementById("del_Driverid").value;	
	var rentaldoc=document.getElementById("rentaldoc").value;
	var rentaldate=document.getElementById("rentaldate").value;
	var fleetno=document.getElementById("fleetno").value;

	var del_KM=document.getElementById("del_KM").value;
	var del_Fuel=document.getElementById("del_Fuel").value;
	var jqxDeliveryOut= $('#jqxDeliveryOut').val();
	var jqxDelTimeOut= $('#jqxDelTimeOut').val();
	 var group=document.getElementById("group").value;
	var vlocation=document.getElementById("vehloca").value;
	
	var branchval=document.getElementById("branchids").value;
	var cldocno=document.getElementById("cldocno").value;
    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
   	  
	       
     	if(r==false)
     	  {
     		return false; 
     	  }
     	else{
     		delsave(rentaldoc,rentaldate,fleetno,del_KM,del_Fuel,jqxDeliveryOut,jqxDelTimeOut,group,vlocation,branchval,cldocno,drid);
     	}
	     });
	
	
}
	function delsave(rentaldoc,rentaldate,fleetno,del_KM,del_Fuel,jqxDeliveryOut,jqxDelTimeOut,group,vlocation,branchval,cldocno,drid)
         {
		
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
		
			 	var items= x.responseText;
			
				document.getElementById("rentaldoc").value="";
				
			    document.getElementById("fleetno").value="";
				document.getElementById("del_Driverid").value="";
				document.getElementById("del_Driver").value="";
				document.getElementById("chktype").value="";
				 $('#del_Driver').attr('placeholder', ''); 
				document.getElementById("del_KM").value="";
				document.getElementById("del_Fuel").value="";
				$('#jqxDeliveryOut').val(new Date());
				$('#jqxDelTimeOut').val(new Date());
				document.getElementById("group").value="";
				document.getElementById("vehloca").value="";
				document.getElementById("out_km").value="";
				document.getElementById("out_fuel").value="";
				document.getElementById("branchids").value="";
				document.getElementById("cldocno").value="";
				$('#jqxDateOut').val("");
				$('#jqxTimeOut').val("");
				disitems();
			 	funreload(event);
			 	$.messager.alert('Message', '  Record Successfully Updated ', function(r){
					     
				     });
	    }
		}
		  x.open("GET","savedeldate.jsp?rentaldoc="+rentaldoc+"&rentaldate="+rentaldate+"&fleetno="+fleetno+"&del_KM="+del_KM+"&del_Fuel="+del_Fuel+"&jqxDeliveryOut="+jqxDeliveryOut+"&jqxDelTimeOut="+jqxDelTimeOut+"&group="+group+"&vlocation="+vlocation+"&branchval="+branchval+"&cldocno="+cldocno+"&chktype="+document.getElementById("chktype").value+"&drid="+drid,true);
	     x.send();
		
		}
	
	function disitems()
	{
		document.getElementById("del_Driverid").value="";
		document.getElementById("del_Driver").value="";
	    document.getElementById("rentaldoc").value="";
	    document.getElementById("rentaldate").value="";
	    document.getElementById("fleetno").value="";
		document.getElementById("chktype").value="";
		 $('#del_Driver').attr('placeholder', ''); 
		document.getElementById("del_KM").value="";
		document.getElementById("del_Fuel").value="";
		$('#jqxDeliveryOut').val(new Date());
		$('#jqxDelTimeOut').val(new Date());
		document.getElementById("group").value="";
		document.getElementById("vehloca").value="";
		document.getElementById("out_km").value="";
		document.getElementById("out_fuel").value="";
		document.getElementById("branchids").value="";
		document.getElementById("cldocno").value="";
		$('#jqxDateOut').val(new Date());
		$('#jqxTimeOut').val(new Date());
		
		 $('#jqxDeliveryOut').jqxDateTimeInput({ disabled: true});
		 $('#jqxDelTimeOut').jqxDateTimeInput({ disabled: true});
		 
		 
		 $('#del_KM').attr("readonly",true);
		 $('#del_Fuel').attr("disabled",true);
		 $('#driverUpdate').attr("disabled",true);
		 $('#attachbtns').attr("disabled",true);
	
		
	}
    function isNumber(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
        	{
        	 $.messager.alert('Message','Enter Numbers Only ','warning');
        	
            return false;
        	}
        
        return true;
    }	
	function funchkkm()
	{
		
		 var outkm=document.getElementById("out_km").value;
			//alert("out"+outkm);
		 	var delkm=document.getElementById("del_KM").value;
		   if((parseFloat(delkm)<parseFloat(outkm)))
			   
		 	
		 	{
			   $.messager.alert('Message','Delivery KM Less Than Out KM ','warning');
			 
			  
		 	}
		
	}	
</script>

<style type="text/css">
.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', Tahoma, sans-serif;
    background-color: #f4f7f9;
}

.sidebar-filters {
    width: 330px;
    flex: 0 0 330px;
    background: #fff;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100vh;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
}

.sidebar-fixed-top {
    padding: 15px 20px;
    border-bottom: 1px solid #f0f4f8;
}

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 20px 25px;
}

.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 13px;
    font-weight: 600;
    color: #4e5e71;
    width: 90px;
}

input[type="text"], select {
    width: 100%;
    padding: 7px 10px;
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    font-size: 13px;
}

.btn-submit {
    width: 100%;
    padding: 11px;
    margin-top: 10px;
    background: #2563eb;
    color: #fff;
    border: none;
    border-radius: 6px;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
}

.btn-submit:hover {
    background: #1d4ed8;
}

html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
}

td[width="80%"] {
    height: 100vh;
    vertical-align: top;
    background: #fff;
}
.myButtons, .myButton {
    background-color: #2563eb !important;
    color: #ffffff !important;
    border: none !important;
    border-radius: 6px;
    cursor: pointer;
    font-size: 13px;
    font-weight: 600;
    padding: 10px 15px;
    width: 100%;
}

.myButtons:hover, .myButton:hover {
    background-color: #1d4ed8 !important;
}
/* 🔹 Inputs + Dropdowns */
input[type="text"],
select {
    width: 100%;
    height: 24px !important;
    padding: 0 8px !important;
    border: 1px solid #ccd6e0;
    border-radius: 4px;
    font-size: 13px;
    box-sizing: border-box;
    line-height: 24px;
}

/* 🔹 Dropdown text */
select {
    font-size: 13px !important;
}

/* 🔹 Buttons */
.btn-submit,
.myButtons,
.myButton,
input[type="button"],
button {
    width: 100%;
    height: 24px !important;
    padding: 0 10px !important;
    border-radius: 4px;
    font-size: 13px;
    font-weight: 600;
    box-sizing: border-box;
    line-height: 24px;
}

/* 🔹 Fix for any library overriding (like jqx / external CSS) */
.jqx-widget input,
.jqx-widget select {
    height: 24px !important;
    line-height: 24px !important;
}

/* 🔹 Button row (side-by-side) */
.button-row {
    display: flex;
    gap: 6px;
}

/* 🔹 Override full width */
.button-row .myButton {
    width: 50% !important;
    margin: 0 !important;
}
/* 🔹 Inputs smaller width */
.input-cell input {
    width: 160px;   /* adjust: 140px / 160px / 180px */
    height: 24px;
    padding: 0 8px;
    border: 1px solid #ccd6e0;
    border-radius: 4px;
    font-size: 13px;
    box-sizing: border-box;
}

.input-cell select {
    width: 160px;   /* same as your input fields */
    height: 24px;
    padding: 0 6px;
    border: 1px solid #ccd6e0;
    border-radius: 4px;
    font-size: 13px;
    box-sizing: border-box;
}

/* 🔹 inline card (does NOT break layout) */
.inline-card {
    display: inline-block;
    width: 300px; /* 🔥 increased card width */
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 10px;
    padding: 12px 15px;
    margin: 10px 0;
}

/* 🔹 table spacing */
.form-table {
    border-spacing: 0 8px;
}

/* 🔹 labels */
.form-table td:first-child {
    text-align: right;
    padding-right: 10px;
    font-size: 13px;
    font-weight: 600;
    color: #4e5e71;
    width: 90px; /* 🔥 slightly increased for better spacing */
}

/* 🔹 inputs */
.form-table input,
.form-table select {
    width: 130px; /* 🔥 increased field width */
    height: 24px;
    padding: 0 6px;
    border: 1px solid #ccd6e0;
    border-radius: 4px;
    font-size: 13px;
}
</style>


</head>
<body onload="getBranch();disitems();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #FFFFFF;">
	<table width="100%">
		<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
<tr>
<td colspan="2">

<div class="inline-card">

<table class="form-table">
<tr>
    <td class="label-cell">Fleet</td>
    <td class="input-cell">
        <input type="text" name="fleetno" id="fleetno"
               value='<s:property value="fleetno"/>'
               readonly="readonly">
    </td>
</tr>

<tr>
    <td class="label-cell">Driver</td>
    <td class="input-cell">
        <input type="text" name="del_Driver" id="del_Driver"
               value='<s:property value="del_Driver"/>'
               readonly="readonly"
               onkeydown="getchauffeur(event);">
    </td>
</tr>

<tr>
    <td class="label-cell">KM</td>
    <td class="input-cell">
        <input type="text" name="del_KM" id="del_KM"
               value='<s:property value="del_KM"/>'
               onkeypress="return isNumber(event);"
               onblur="funchkkm();">
    </td>
</tr>
 
<tr>
    <td class="label-cell">Fuel</td>
    <td class="input-cell">
        <select name="del_Fuel" id="del_Fuel">
            <option value="">-Select-</option>  
            <option value="0.000">Level 0/8</option>
            <option value="0.125">Level 1/8</option>
            <option value="0.250">Level 2/8</option>
            <option value="0.375">Level 3/8</option>
            <option value="0.500">Level 4/8</option>
            <option value="0.625">Level 5/8</option>
            <option value="0.750">Level 6/8</option>
            <option value="0.875">Level 7/8</option>
            <option value="1.000">Level 8/8</option>
        </select>
    </td>
</tr>

 <tr>
    <td class="label-cell">Date</td>
    <td class="input-cell">
        <div id="jqxDeliveryOut"></div>
        <input type="hidden" id="hidjqxDeliveryOut" name="hidjqxDeliveryOut"
               value='<s:property value="hidjqxDeliveryOut"/>'>
    </td>
</tr>

<tr>
    <td class="label-cell">Time</td>
    <td class="input-cell">
        <div id="jqxDelTimeOut"></div>
        <input type="hidden" id="hidjqxDelTimeOut" name="hidjqxDelTimeOut"
               value='<s:property value="hidjqxDelTimeOut"/>'>
    </td>
</tr>
</table>

</div>

</td>
</tr>
 <tr><td colspan="2" style="padding-top:10px;">
    <div class="button-row">
        <input type="button" name="driverUpdate" id="driverUpdate"
               class="myButton" value="Update" onclick="funupdate()">

        <input type="button" name="attachbtns" id="attachbtns"
               class="myButton" value="Attach" onclick="funAttachBtn()">
    </div>
</td> </tr>
  
    
 	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>	
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>	

       
  </table>
  
     <input type="hidden" name="chktype" id="chktype" style="height:20px;width:70%;" value='<s:property value="chktype"/>' >
     <input type="hidden" name="del_Driverid" id="del_Driverid" style="height:20px;width:70%;" value='<s:property value="del_Driverid"/>' >
  <input type="hidden" name="rentaldate" id="rentaldate" style="height:20px;width:70%;" value='<s:property value="rentaldate"/>' >
  <input type="hidden" name="rentaldoc" id="rentaldoc" style="height:20px;width:70%;" value='<s:property value="rentaldoc"/>' >
<%-- <input type="text" name="fleetno" id="fleetno" style="height:20px;width:70%;" value='<s:property value="fleetno"/>' > --%>
<%-- <input type="hidden" name="del_Driverid" id="del_Driverid" style="height:20px;width:70%;" value='<s:property value="del_Driverid"/>' > --%>
<input type="hidden" name="out_km" id="out_km" style="height:20px;width:70%;" value='<s:property value="out_km"/>' >
<input type="hidden" name="out_fuel" id="out_fuel" style="height:20px;width:70%;" value='<s:property value="out_fuel"/>' >

<div hidden="true" id='jqxDateOut' name='jqxDateOut' value='<s:property value="jqxDateOut"/>'></div>
<div hidden="true" id='jqxTimeOut' name='jqxTimeOut' value='<s:property value="jqxTimeOut"/>'></div>


<input type="hidden" name="branchids" id="branchids" style="height:20px;width:70%;" value='<s:property value="branchids"/>' >
<input type="hidden" name="group" id="group" style="height:20px;width:70%;" value='<s:property value="group"/>' >
<input type="hidden" name="vehloca" id="vehloca" style="height:20px;width:70%;" value='<s:property value="vehloca"/>' >
		<input type="hidden" name="cldocno" id="cldocno" style="height:20px;width:70%;" value='<s:property value="cldocno"/>' >  
	 
   </fieldset>

</td>
<td width="80%">
	<table width="100%">
		<tr>
			  <td><div id="delupdiv"><jsp:include page="delupdateGrid.jsp"></jsp:include></div></td> 
			  </tr>
			  <%-- <tr>
			  <td><div hidden="true">	<jsp:include page="../../../../header.jsp"></jsp:include></div></td>
			  
		</tr> --%>
	</table>
</tr>
</table>
</div>
<div id="chauffeurinfowindow">
   <div ></div>
</div>
</div>
</body>
