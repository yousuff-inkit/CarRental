<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- <link href="../../../../css/main.css" rel="stylesheet" type="text/css" />
<link href="../../../../css/body.css" media="screen" rel="stylesheet" type="text/css" />
 -->
 <jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
/* ------------------------------
   GLOBAL STYLES
------------------------------ */

body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 32px 0;
    min-height: 130vh;
    box-sizing: border-box;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 20px;
    max-width: 1450px;
    margin: auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

/* ------------------------------
   COMMON UI ELEMENTS
------------------------------ */

input[type="text"], select {
    height: 32px !important;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    background: #fff;
    transition: border-color 0.2s;
    font-size: 14px;
    box-sizing: border-box;
}

input[type="text"]:focus,
select:focus {
    border-color: #007bff;
    outline: none;
}

label {
    font-weight: 600;
    color: #253858;
    white-space: nowrap;
}

/* ------------------------------
   HEADER SECTION
------------------------------ */

.receipt-header {
    display: flex;
    flex-direction: column;
    margin-bottom: 16px;
    padding: 0 10px 10px;
}

.receipt-header table {
    width: 100%;
}

.receipt-header td {
    padding: 6px 4px;
    vertical-align: middle;
}

#txtStatus {
    font-size: 14px;
    font-weight: 600;
    color: #e67e22;
}

/* ------------------------------
   FORM ROWS LAYOUT (FIXED)
------------------------------ */

.form-group {
    display: grid;
    grid-template-columns: 120px 1fr;
    align-items: center;
    gap: 12px 16px;
    margin-bottom: 12px;
}

.form-group label {
    text-align: right;
    padding-right: 8px;
    font-size:1rem;
}

.form-group input[type="text"],
.form-group select {
    width: 100%;
}

/* For rows with multiple input pairs (Currency/Rate, Amount/Base Amount) */
.form-group.dual-input {
    grid-template-columns: 120px 1fr 120px 1fr;
}

.form-group.dual-input label:nth-of-type(2) {
    text-align: right;
    padding-right: 8px;
}
.form-group.dual-input label:nth-of-type(2) {
    text-align: right;
    padding-right: 8px;
}

/* Special case: One label with two equal-width inputs */
.form-group.single-label-dual-input {
    grid-template-columns: 120px 1fr 1fr;
}

.form-group.single-label-dual-input input[type="text"]:first-of-type {
    width: 100%;
}

.form-group.single-label-dual-input input[type="text"]:nth-of-type(2) {
    width: 100%;
}

.section-row {
    display: flex;
    gap: 26px;
    margin-bottom: 30px;
}

.section-block {
    flex: 1;
    min-width: 0;
    background: #f6f8fa;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.1);
}

.section-block h2 {
    font-size: 1.1rem;
    font-weight: 600;
    margin: 0 0 20px;
    padding-left: 10px;
    border-left: 4px solid #007bff;
}

/* Special handling for the "to-account-row" - all items in one line */
.to-account-row {
    display: flex;
    align-items: center;
    flex-wrap: nowrap;       /* Prevent wrapping → keeps everything in one line */
    gap: 16px;               /* Space between elements */
    margin-left: -12px;
    margin-bottom: 12px;
    width: 100%;
}

.to-account-row label {
    white-space: nowrap;     /* Prevent label text from breaking */
    font-weight: 600;
    min-width: 120px;        /* You can adjust for label alignment */
}

.to-account-row input[type="text"],
.to-account-row select,
.to-account-row div[id$="Date"] {
    height: 32px;
    padding: 4px 8px;
    border-radius: 4px;
    border: 1px solid #d1d1d1;
}

.to-account-row select {
    width: 150px;            /* Adjust based on your design */
}

.to-account-row input[type="text"] {
    width: 180px;            /* Default width */
}

/* If you want some inputs wider */
#garagemaster { width: 320px !important; }


/* ------------------------------
   TABLE SECTIONS
------------------------------ */

.table-section {
    margin: 20px 0;
}

.table-section h3 {
    color: #253858;
    font-size: 1.05rem;
    font-weight: 600;
    margin-bottom: 12px;
}

.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #fff;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 0 0 1px #e5e7eb;
}

.cr-table th,
.cr-table td {
    padding: 8px 12px;
    border-bottom: 1px solid #eef0f6;
    font-size: 14px;
}

.cr-table th {
    background: #eef0f6;
    font-weight: 600;
    color: #354B6A;
}

.cr-table tr:last-child td {
    border-bottom: none;
}

/* ------------------------------
   SCROLL AREAS
------------------------------ */

.hidden-scrollbar {
    overflow: auto;
    height: 530px;
}

/* Hide scrollbars (but allow scrolling) */
.hidden-scrollbar::-webkit-scrollbar {
    width: 0px;
}

/* ------------------------------
   BUTTONS
------------------------------ */

button, .myButton {
    background: #007bff;
    border: none;
    padding: 6px 16px;
    color: #fff;
    border-radius: 6px;
    cursor: pointer;
    font-weight: 600;
    transition: background 0.2s;
}

button:hover, .myButton:hover {
    background: #0056b3;
}

/* ------------------------------
   ERROR LABELS
------------------------------ */

#validrate,
#validrate1 {
    color: red;
    font-size: 12px;
    grid-column: 2 / -1;
}

/* ------------------------------
   APPROVAL TABLE
------------------------------ */

#approval-table td {
    font-size: 14px;
    padding: 8px;
}

#approval-table tr:nth-child(even) {
    background: #f9fafb;
}
</style>
<script type="text/javascript">

$(document).ready(function () {     
	 $("#maintainceDate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	$('#fleetsearchwindow').jqxWindow({  width: '62%', height: '67%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Fleet Search' , position: { x: 400, y: 60 }, keyboardCloseKey: 27});
	$('#fleetsearchwindow').jqxWindow('close');
	 $("#invDate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	$('#garragesearchwindow').jqxWindow({ width: '30%', height: '63%',  maxHeight: '70%' ,maxWidth: '50%' ,title: 'Garrage Search' , position: { x: 700, y: 60 }, keyboardCloseKey: 27});
	$('#garragesearchwindow').jqxWindow('close');
    $('#typeservsearchwndow').jqxWindow({ width: '30%', height: '59%',  maxHeight: '65%' ,maxWidth: '65%' , title: 'Type Search' ,position: { x: 200, y:100 }, keyboardCloseKey: 27});
    $('#typeservsearchwndow').jqxWindow('close');
     $('#serdescsearchwndow').jqxWindow({ width: '25%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Description Search' ,position: { x: 200, y:100 }, keyboardCloseKey: 27});
    $('#serdescsearchwndow').jqxWindow('close'); 
    
    $('#maintainceDate').on('change', function (event) {
        var receiptdate = $('#maintainceDate').jqxDateTimeInput('getDate');
        funDateInPeriod(receiptdate);
       });
	$('#garagemaster').dblclick(function(){
		   $('#garragesearchwindow').jqxWindow('open');
		  	  
		  	  garragechangeContent('garragesearch.jsp?', $('#garragesearchwindow'));
				 });
	
	$('#mtfleetno').dblclick(function(){
	   $('#fleetsearchwindow').jqxWindow('open');
	  	  
	  	  fleetchangeContent('fleetsearch.jsp?', $('#fleetsearchwindow'));
			 });
	
      		 }); 
function descservSearchContent(url) {
 	 //alert(url);
 		 $.get(url).done(function (data) {
          
 			 $('#serdescsearchwndow').jqxWindow('open');
 		$('#serdescsearchwndow').jqxWindow('setContent', data);
 
 	}); 
 	}  
function TypeservSearchContent(url) {
  	 //alert(url);
  		 $.get(url).done(function (data) {
           
  			 $('#typeservsearchwndow').jqxWindow('open');
  		$('#typeservsearchwndow').jqxWindow('setContent', data);
  
  	}); 
  	} 
function getgarrage(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#garragesearchwindow').jqxWindow('open');

	  garragechangeContent('garragesearch.jsp?', $('#garragesearchwindow'));   }
	 else{
		 }
	 }  
	  function garragechangeContent(url) {
      //alert(url);
         $.get(url).done(function (data) {
//alert(data);
       $('#garragesearchwindow').jqxWindow('setContent', data);

	           }); 
   	}

function getfleet(event){
 	 var x= event.keyCode;
 	 if(x==114){
 	  $('#fleetsearchwindow').jqxWindow('open');
 
 	 fleetchangeContent('fleetsearch.jsp?', $('#fleetsearchwindow'));   }
 	 else{
 		 }
 	 }  
	  function fleetchangeContent(url) {
       //alert(url);
          $.get(url).done(function (data) {
//alert(data);
        $('#fleetsearchwindow').jqxWindow('setContent', data);

	           }); 
    	}

function funFocus(){
	
	$('#maintainceDate').jqxDateTimeInput('focus'); 	    		
}
function funReset() {
	
}
function funReadOnly() {
	$('#frmmaint input').attr('readonly', true);
	$('#frmmaint select').attr('disabled', true);
	
	$('#mtfleetno').attr('disabled', true);
	$('#garagemaster').attr('disabled', true);
	
	   $("#maindowngrid").jqxGrid({ disabled: true});
	   $("#mainuppergrid").jqxGrid({ disabled: true}); 
		$('#invDate').jqxDateTimeInput({ disabled: true}); 
		$('#maintainceDate').jqxDateTimeInput({ disabled: true}); 
}
function funRemoveReadOnly() {
	
	$('#frmmaint input').attr('readonly', false);
	$('#frmmaint select').attr('disabled', false);
	$('#mtfleetno').attr('disabled', false);
	$('#garagemaster').attr('disabled', false);
	 $('#nextserdue').attr('disabled', false);
	$('#maintainceDate').jqxDateTimeInput({ disabled: false}); 
	$('#invDate').jqxDateTimeInput({ disabled: false}); 
	$('#mtfleetno').attr('readonly', true);
	$('#mtflname').attr('readonly', true);
	$('#garagemaster').attr('readonly', true);
	$('#docno').attr('readonly', true);
	$("#maindowngrid").jqxGrid({ disabled: false});
	$("#mainuppergrid").jqxGrid({ disabled: false}); 
	if($('#mode').val()=='A')
		{
		 $('#nextserdue').attr('disabled', false);
		$('#maintainceDate').val(new Date());
		$('#invDate').val(new Date());
		$("#maindowngrid").jqxGrid('clear');
		$("#maindowngrid").jqxGrid('addrow', null, {});
		$("#mainuppergrid").jqxGrid('clear');
		$("#mainuppergrid").jqxGrid('addrow', null, {});
		
		} 
	if($('#mode').val()=='E')
	{
		if($('#maintype').val()=="repair")
		 {
		 
			  $('#nextserdue').attr('disabled', true);
		
		 }	
		else
			{
			 $('#nextserdue').attr('disabled', false);
			}
	} 
	
	
	
}
function valchange()
{
if($('#maintypeval').val()!="")
 {
	
 
 $('#maintype').val($('#maintypeval').val());
 }
if($('#maintypeval').val()=="repair")
{

	  $('#nextserdue').attr('disabled', true);

}	
else
	{
	 $('#nextserdue').attr('disabled', false);
	}
}

function changetype()
{
	if($('#maintype').val()=="repair")
	 {
	 
		  $('#nextserdue').attr('disabled', true);
	
	 }	
	else
		{
		 $('#nextserdue').attr('disabled', false);
		}
	
}

function setValues() {
	 if($('#hidmaintainceDate').val()){
	   $("#maintainceDate").jqxDateTimeInput('val', $('#hidmaintainceDate').val());
	  }
	 if($('#hidinvDate').val()){
		   $("#invDate").jqxDateTimeInput('val', $('#hidinvDate').val());
		  }
	 
	  if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
	  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	  valchange();
	  var docval=document.getElementById("masterdoc_no").value;
	  if(docval>0)
		  {
		  
			 var indexVal2 = document.getElementById("masterdoc_no").value;
	     	
	         $("#maingrid").load("maintGrid.jsp?maindoc="+indexVal2);
	         $("#servgrid").load("servicemaingrid.jsp?maindoc1="+indexVal2);
		  
		  }
	  
}


function funNotify(){
	
	var receiptdate = $('#maintainceDate').jqxDateTimeInput('getDate');
	   var validdate=funDateInPeriod(receiptdate);
	   if(validdate==0){
	   return 0; 
	   }
	 var fleetval=document.getElementById("mtfleetno").value;
	   
	   if(fleetval=="")
	   {
		   document.getElementById("errormsg").innerText="Select Fleet No";  
		   document.getElementById("mtfleetno").focus();
		   return 0;
	   }
	   if($('#maintype').val()=="service")
		 {
	   	var cuurkmval=document.getElementById("currkm").value;
	 	var nextserkmval=document.getElementById("nextserdue").value;
	   if((parseFloat(nextserkmval)<parseFloat(cuurkmval)))
		   
	 	
	 	{
		  
		   document.getElementById("errormsg").innerText="Service Due KM Less Than Current KM";  
		   document.getElementById("nextserdue").focus();
		   return 0;
	 	}
	   else
		   {
		   document.getElementById("errormsg").innerText="";  
		   }
		
		 }
	   var garrage=document.getElementById("garrageid").value;
	   if(garrage=="")
	   {
		   document.getElementById("errormsg").innerText="Select Garrage";  
		   document.getElementById("garagemaster").focus();
		   return 0;
	   }
	   
		
             var invno= document.getElementById("invno").value;
			
			if(invno=="")
				{
				 document.getElementById("errormsg").innerText=" Enter Inv NO";
				 document.getElementById("invno").focus();
				 
				 return 0;
				   }
			else
				   {
				   document.getElementById("errormsg").innerText="";
				   } 
				
	   
	   
	 /* 
	 
	 
	 
		var aa="";
		//var dateval="";
			
		
	  
	   
	    for(var i=0;i<rows.length;i++){
	    	// dateval=2;
	    	 //alert("date"+rows[i].hidcldate);
	    	if(rows[i].clear==true){
	    		aa=1;
	    		
	    		break;
	    		
	    	}
	    	else{
	    		aa=0;
	    	}
	    	
	    } */

	   /*  if(aa==0){
	    	
	    	 document.getElementById("errormsg").innerText="At least One Cleared";  
			 
	    	return 0;
	    } */
	   /*  if(dateval==1)
		{
		document.getElementById("errormsg").innerText="Enter Cleard Item Date";  
		 
		return 0;
		} */
	   //alert($('#gridlength').val());
		var rows = $("#mainuppergrid").jqxGrid('getrows');
		  $('#maingridlength').val(rows.length);
	    for(var i=0;i<rows.length;i++){
	 	   // var myvar = rows[i].tarif; 
	 	    newTextBox = $(document.createElement("input"))
	 	       .attr("type", "dil")
	 	       .attr("id", "main"+i)                  
	 	       .attr("name", "main"+i)
	 	         .attr("hidden", "true");
	 	   newTextBox.val(rows[i].hidcldate+"::"+rows[i].clear+" :: "+rows[i].clremarks+" :: "+rows[i].srno+" :: "+rows[i].hidcltime+" :: ");
	 		
	 	   newTextBox.appendTo('form'); 
	 		
	 	   }
	 	    
	   
	  var rows = $("#maindowngrid").jqxGrid('getrows');
	    $('#servicegridlenght').val(rows.length);
	    
	 
	   //alert($('#gridlength').val());
	   for(var i=0 ; i < rows.length ; i++){
		   
		   
		   if(rows[i].description==''){
			   
			   $.messager.alert('Message','Select Description....!','warning');
	    	      return false;
			   
		   }
		   
	   // var myvar = rows[i].tarif; 
	    newTextBox = $(document.createElement("input"))
	       .attr("type", "dil")
	       .attr("id", "service"+i)
	       .attr("name", "service"+i)
	    .attr("hidden", "true");
	   newTextBox.val(rows[i].type+"::"+rows[i].description+" :: "+rows[i].remarks+" :: "
			   +rows[i].lbrcost+" :: "+rows[i].partscost+" :: "+rows[i].total+" :: ");
		                                                                            

	   newTextBox.appendTo('form');

	    
	   } 
	   


	   var lbrcost=document.getElementById("lbrtotalcost").value;

	
	   if(lbrcost==""||typeof(lbrcost)=="undefined"||typeof(lbrcost)=="NaN")
		   {
		
		   document.getElementById("lbrtotalcost").value=0.00;
		  /*  document.getElementById("errormsg").innerText=" Labor Cost Is Empty";  
		   return 0; */
		   }
	   
	   
	   var partscost=document.getElementById("partstotalcost").value;
	
	   if(partscost==""||typeof(partscost)=="undefined"||typeof(partscost)=="NaN")
	   {
		   document.getElementById("partstotalcost").value=0.00;
		   /* document.getElementById("errormsg").innerText=" Parts Cost Is Empty";  
		   return 0; */
	   }
	   var totalcost=document.getElementById("totalcost").value;
	
	   if(totalcost==""||typeof(totalcost)=="undefined"||typeof(totalcost)=="NaN")
	   {
		   
		   document.getElementById("totalcost").value=0.00;
		 /*   document.getElementById("errormsg").innerText="Total Is Empty";  
		 
		   return 0; */
	   }
	   
	   
	   
/* 
	   if(parseFloat(lbrcost)>0)
	   {
	 
	   document.getElementById("lbrtotalcost").value=partscost.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
	
	   }

	   if(parseFloat(partscost)>0)
	   {
		  
		   document.getElementById("partstotalcost").value=partscost.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
		  
	   }
	   
	   if(parseFloat(totalcost)>0)
	   {
		  
		   document.getElementById("lbrtotalcost").value=totalcost.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
		  
	   }
	   */
	   var x =new XMLHttpRequest();
		
		x.onreadystatechange=function()
		{
		if(x.readyState==4 && x.status==200)	
		
		{
			var items=x.responseText;
			
			
			
			var chk=items.trim();
			
			
			 
			
		if(parseInt(chk)==1)
			{
			
			document.getElementById("errormsg").innerText="Inv No "+document.getElementById("invno").value+" Already Exists ";  
			document.getElementById("invno").focus();
			
			return 0;
			
			}
		else
			{
			 document.getElementById("errormsg").innerText="";
			 
			 
			 
			 document.getElementById("frmmaint").submit();
			}
			
			
		
		}
		}
		
		x.open("GET","checkinvno.jsp?invno="+document.getElementById("invno").value+'&masterdocno='+document.getElementById("masterdoc_no").value+'&garrageid='+document.getElementById("garrageid").value);

		x.send();	
	   
 
}





function funchkinv()
{
var x =new XMLHttpRequest();

x.onreadystatechange=function()
{
if(x.readyState==4 && x.status==200)	

{
	var items=x.responseText;
	
	
	
	var chk=items.trim();
	
	
 
	
if(parseInt(chk)==1)
	{
	
	document.getElementById("errormsg").innerText="Inv No "+document.getElementById("invno").value+" Already Exists ";  
	document.getElementById("invno").focus();
	
	return 0;
	
	}
else
	{
	 document.getElementById("errormsg").innerText="";
	 
	 
	 
	 return 1;
	}
	
	

}
}

x.open("GET","checkinvno.jsp?invno="+document.getElementById("invno").value+'&masterdocno='+document.getElementById("masterdoc_no").value+'&garrageid='+document.getElementById("garrageid").value);

x.send();

}






function funChkButton() {
	   /* funReset(); */
	  }
	  
function funSearchLoad(){

	changeContent('masterSearch.jsp?', $('#updatesearchwindow'));
 }
 
$(function(){
    $('#frmmaint').validate({
            rules: {
            	
            	 currkm:{"required":true,number:true},
       
            	 nextserdue:{"required":true,number:true},
       
             },
             messages: {
            
            	 currkm:{required:" *required",number:" inValid"},
          
            	 nextserdue:{required:" *required",number:" inValid"}
           
             }
    });});

function funPrintBtn(){
	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	  
	   var url=document.URL;

    var reurl=url.split("saveMaint");
    
    $("#docno").prop("disabled", false);                
    

var win= window.open(reurl[0]+"printMintupdate?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
 
win.focus();
	   } 
	  
	   else {
    	      $.messager.alert('Message','Select a Document....!','warning');
    	      return false;
    	     }
    	
	}
                              
/* function currkmValidate()
{
        var x = document.maintUpdate.currkm.value;
        if(isNaN(x)|| x.indexOf(" ")!=-1){
            //  alert("Enter numeric value");
              document.getElementById("errormsg").innerText="Enter numeric value";   
              
              return false;
              }
        else
        	{
        	 document.getElementById("errormsg").innerText="";
        	}
       
           
}
function nextserdueValidate()
{
        var x = document.maintUpdate.nextserdue.value;
        if(isNaN(x)|| x.indexOf(" ")!=-1){
            //  alert("Enter numeric value");
              document.getElementById("errormsg").innerText="Enter numeric value";   
              
              return false;
              }
        else
        	{
        	 document.getElementById("errormsg").innerText="";
        	}
       
           
} */
</script>

 
</head>
<body onload="setValues();">
<div id="mainBG" class="hidden-scrolbar homeContent" data-type="background">
<form id="frmmaint" action="saveMaint" name="maintUpdate" method="post" autocomplete="OFF">
<!-- <div class='hidden-scrollbar'>   -->
<jsp:include page="../../../../header.jsp" /><br/>



<fieldset>
<legend>Maintenance Update</legend> 
<div class=section-block">
<div class="form-group dual-input">
<label>Date</label>
<div id="maintainceDate" name="maintainceDate"  value='<s:property value="date_accountmaster"/>'></div><input type="hidden" id="hidmaintainceDate" name="hidmaintainceDate" value='<s:property value="hidmaintainceDate"/>'>

<label>Fleet No</label>
<input type="text" id="mtfleetno" name="mtfleetno" style="width:85%;" placeholder="Press F3 To Search"    value='<s:property value="mtfleetno"/>' onkeydown="getfleet(event)">
</div>

<div class="form-group dual-input">
<label>Name</label>
<input type="text" id="mtflname" style="width:90%;" tabindex="-1" name="mtflname" value='<s:property value="mtflname"/>'>

<label>Doc No</label>
<input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>'>

</div>

<div class="form-group ">
<label>Remarks</label>
<input type="text" id="mtremark" name="mtremark" style="width:73.4%;"   value='<s:property value="mtremark"/>'>

</div>



<div class="form-group to-account-row">
<label>Type</label>
<select id="maintype" name="maintype" onchange="changetype()" value='<s:property value="maintype"/>'>
<option value="service">Service</option>
<option value="repair">Repair</option>   
</select>

<label>Curr.KM</label>
<input type="text" id="currkm" name="currkm" style="width:50%;"  value='<s:property value="currkm"/>'> 
<label>Next Ser.Due KM</label>
<input type="text" id="nextserdue" name="nextserdue" style="width:50%;" value='<s:property value="nextserdue"/>' > 
</div>

<div class="form-group to-account-row">
<label>Garage</label>
<input type="text" id="garagemaster"  name="garagemaster" placeholder="Press F3 To Search" style="width:83.3%;"  value='<s:property value="garagemaster"/>' onkeydown="getgarrage(event)">
<label>Inv NO</label>
<input type="text" id="invno" name="invno" value='<s:property value="invno"/>' onblur="funchkinv();">
<label>Inv Date</label>
<div id="invDate" name="invDate"  value='<s:property value="invDate"/>'></div><input type="hidden" id="hidinvDate" name="hidinvDate" value='<s:property value="hidinvDate"/>'>


                                
</div>
                       
</div>
</fieldset>

<fieldset>
<div id="maingrid">
<jsp:include page="maintGrid.jsp"></jsp:include></div>
</fieldset>
<fieldset>
<div id="servgrid">
<jsp:include page="servicemaingrid.jsp"></jsp:include></div>
</fieldset>
<input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'>
<input type="hidden" id="garrageid" name="garrageid" value='<s:property value="garrageid"/>'>
<input type="hidden" id="mtypename" name="mtypename" value='<s:property value="mtypename"/>'> <!--  mtypesearch from serviece grid -->

<input type="hidden" id="lbrtotalcost" name="lbrtotalcost" value='<s:property value="lbrtotalcost"/>'>  
<input type="hidden" id="partstotalcost" name="partstotalcost" value='<s:property value="partstotalcost"/>'> 	
<input type="hidden" id="totalcost" name="totalcost" value='<s:property value="totalcost"/>'>    


<input type="hidden" id="maintypeval" name="maintypeval" value='<s:property value="maintypeval"/>'>    


<input type="hidden" id="maintTrno" name="maintTrno" value='<s:property value="maintTrno"/>'>    

<input type="hidden" id="jvmDovno" name="jvmDovno" value='<s:property value="jvmDovno"/>'>    <!-- for docno jvm table  -->

<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'>
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'>
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>

<input type="hidden" id="maingridlength" name="maingridlength" value='<s:property value="maingridlength"/>'>

<input type="hidden" id="servicegridlenght" name="servicegridlenght" value='<s:property value="servicegridlenght"/>'>
 <!--  </div>   -->


</form>
<div id="fleetsearchwindow">
   <div ></div>
</div>
<div id="typeservsearchwndow">
   <div ></div>
</div>
 <div id="serdescsearchwndow">
   <div ></div>
</div> 
 <div id="garragesearchwindow">
   <div ></div>
</div>
 <div id="updatesearchwindow">
   <div ></div>
</div>

 
	
</body>
</html>