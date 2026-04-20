<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link rel="stylesheet" type="text/css" href="../../../../css/body.css">
<jsp:include page="../../../../includeso.jsp"></jsp:include>

<style>
/* =========================================================
SCOPED UI: Compact Input Sizing & Bulletproof Grids
* All rules are scoped inside .modern-ui to protect header.jsp *
========================================================= */

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding-top: 15px;
    box-sizing: border-box;
}

/* Master Input Heights - Set to 24px */
.modern-ui input[type="text"],
.modern-ui select,
.modern-ui textarea { 
    height: 24px !important; 
    border: 1px solid #ccc; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
    /* Safety constraint to prevent long text from breaking grid */
    min-width: 0; 
    text-overflow: ellipsis;
    white-space: nowrap;
    overflow: hidden;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus,
.modern-ui textarea:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui textarea[readonly],
.modern-ui select:disabled,
.modern-ui input:disabled { 
    background-color: #f3f4f6; 
    color: #6b7280;
}

/* Labels */
.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 2px;
}

/* Panels */
.modern-ui .modern-panel { 
    border: 1px solid #e1e4e8; 
    padding: 15px 10px 10px 10px; 
    background: #fff;
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
}

.modern-ui .modern-panel-title { 
    position: absolute;
    top: -10px; 
    left: 10px;
    background: #fff; 
    padding: 0 5px 0 6px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 13px;
    border-left: 3px solid #0056b3;
}

/* Specific Grid Alignments */
.modern-ui .top-details-grid {
    display: grid;
    grid-template-columns: max-content minmax(100px, 1.5fr) max-content minmax(100px, 2fr) max-content minmax(80px, 1fr);
    gap: 12px 10px;
    align-items: center;
}

.modern-ui .chk-container { 
    display: flex;
    align-items: center; 
    gap: 4px;
    cursor: pointer; 
}

.modern-ui .align-right-input { 
    text-align: right !important;
}

/* Updated Button Styles to match the Search Popup exactly */
.modern-ui .myButton {
    font-weight: bold;
    font-size: 12px;
    height: 24px !important;
    padding: 0px 16px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    box-shadow: 0 1px 2px rgba(59, 130, 246, 0.3);
    transition: all 0.2s ease;
}


.modern-ui .myButton:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%);
    transform: translateY(-1px);
}

.hidden-scrollbar { 
    overflow: auto; 
    height: 600px;
    box-sizing: border-box;
}
.hidden-scrollbar::-webkit-scrollbar { width: 0px; }

.jqx-menu-wrapper { border-radius: 3px; }


.jqx-grid-header {
    /* Shifted from #f8f9fa to #e9ecef (subtly darker gradient) */
    background: linear-gradient(180deg, #e9ecef 0%, #dee2e6 100%) !important;
    border-color: #ced4da !important;
    color: #212529 !important;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

.jqx-grid-column-header {
    background: transparent !important;
    color: #212529 !important;
    font-weight: 700 !important;
    font-size: 11px !important;
    text-align: left !important;
    border-color: #ced4da !important;
}

.jqx-grid-column-header a:link,
.jqx-grid-column-header a:visited {
    color: #212529 !important;
    text-align: left !important;
}

.jqx-grid-column-header > div > div {
    text-align: left !important;
    padding-left: 6px !important;
}


.jqx-grid-cell {
    background: #ffffff;
    border-color: #dee2e6 !important; 
    color: #1f2937;
    font-size: 11px !important;
    text-align: left !important;
}

.jqx-grid-cell-left-align {
    text-align: left !important;
    padding-left: 6px !important;
    margin-left: 0px !important;
}

.jqx-grid-cell-middle-align {
    text-align: left !important;
    padding-left: 6px !important;
}

.jqx-grid-cell-right-align {
    text-align: right !important;
    padding-right: 6px !important;
}


.jqx-grid-cell-alt {
    background: #f1f3f5 !important; 
}


.jqx-grid-cell-hover {
    background: #dee2e6 !important; 
    border-color: #ced4da !important;
    color: #000000 !important;
}

.jqx-grid-cell-selected {
    background: #adb5bd !important; 
    color: #ffffff !important;
    border-color: #868e96 !important;
}

.jqx-grid-table .jqx-grid-cell {
    border-width: 0px 0px 1px 0px !important;
    border-color: #dee2e6 !important;
}


.jqx-grid {
    border: 1px solid #adb5bd !important; /* Darker outer border */
    border-radius: 8px !important;
    overflow: hidden !important;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1) !important;
}


.jqx-grid-cell-sort {
    background-color: #e9ecef !important;
}
.jqx-grid-cell-sort-alt {
    background-color: #dee2e6 !important;
}

.jqx-grid-cell-filter,
.jqx-grid-cell-filter-alt {
    background-color: #f1f3f5 !important;
}

.jqx-grid-cell-pinned,
.jqx-grid-cell-pinned-alt {
    background-color: #e9ecef !important;
}


.jqx-grid-pager {
    background: #e9ecef !important; /* Darker pager background */
    border-top: 1px solid #ced4da !important;
    padding: 4px !important;
}

.jqx-grid-column-menubutton {
    opacity: 0.5;
    transition: opacity 0.2s;
}
.jqx-grid-column-menubutton:hover {
    opacity: 1;
}


.jqx-scrollbar-state-normal {
    background: #f1f3f5 !important;
}
.jqx-scrollbar-thumb-state-normal,
.jqx-scrollbar-thumb-state-normal-horizontal {
    background: #868e96 !important; /* Steel grey thumb */
    border-color: #868e96 !important;
    border-radius: 4px !important;
}
.jqx-scrollbar-thumb-state-hover,
.jqx-scrollbar-thumb-state-hover-horizontal {
    background: #495057 !important; /* Deep grey on hover */
    border-radius: 4px !important;
}
</style>

<script type="text/javascript">
$(document).ready(function () {
	$('#btndownload').hide();
	document.getElementById("chkcollection").unchecked=true;
	document.getElementById("chauffer").disabled="true";
	// checkConvertion(); 
//	getConvertion();
	getBranch();
	getLeasePrior();
	getTestLocation();
	$('#brchName').change(function(){
  getAgmtLocation();
 });
	if(document.getElementById("hidchkcollection").value=="1"){
		document.getElementById("chkcollection").checked=true;
	}
	else{
		document.getElementById("chkcollection").checked=false;
	}

	//setCollection();
	//$("#tarifreferencegrid").jqxGrid({ disabled: true});
	$("#closeinvdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#closedate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#indate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	 $("#collectdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	 $("#datehidden").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#agmtdeliverydate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#closedatehidden").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	// $("#accidentdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	// $("#policecollecteddate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#intime").jqxDateTimeInput({ width: '80%', height: '17px', formatString: 'HH:mm', showCalendarButton: false ,value:null});
	 $("#collecttime").jqxDateTimeInput({ width: '80%', height: '17px', formatString: 'HH:mm', showCalendarButton: false,value:null});
	//Minimize Button
	 $("#jqxMenuMore").jqxMenu({ width: '40%', height: '26px', autoSizeMainItems: true});
     $("#jqxMenuMore").jqxMenu('minimize');            
     $("#jqxMenuMore").css('visibility', 'visible');
     //Common window for minimize button
     $('#window1').jqxWindow({autoOpen:false, width: '71%', height: '70%',  maxHeight: '70%' ,maxWidth: '80%' , title: 'Details',position: { x: 180, y: 60 } , theme: 'energyblue', showCloseButton: true,keyboardCloseKey: 27});
     $('#window1').jqxWindow('close');
	 //$("#accidenttime").jqxDateTimeInput({ width: '100%', height: '17px', formatString: 'HH:mm', showCalendarButton: false });
	  $('#agmtnowindow').jqxWindow({autoOpen:false, width: '60%', height: '68%',  maxHeight: '68%' ,maxWidth: '60%' , title: 'Agreement Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#agmtnowindow').jqxWindow('close');
	   $('#collectionWindow').jqxWindow({ autoOpen:false, width: '50%', height: '58%',  maxHeight: '58%' ,maxWidth: '50%' , title: 'Collection Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#collectionWindow').jqxWindow('close');
	   $('#checkinWindow').jqxWindow({ autoOpen:false, width: '50%', height: '58%',  maxHeight: '58%' ,maxWidth: '50%' , title: 'Check In Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#checkinWindow').jqxWindow('close');
	   $('#rentalAgentWindow').jqxWindow({autoOpen:false,  width: '50%', height: '58%',  maxHeight: '58%' ,maxWidth: '50%' , title: 'Rental Agent Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#rentalAgentWindow').jqxWindow('close');
	   
	   $('#indate').on('change', function (event) 
			   {  
		  if(document.getElementById("mode").value=="A"){
			document.getElementById("useddays").value="";
			document.getElementById("usedhours").value="";
			document.getElementById("totalkm").value="";
			document.getElementById("excesskm").value="";
			document.getElementById("lblinvoicedone").innerText="";
			 $('#totalgrid').jqxGrid('clear');
	    	 $("#totalgrid").jqxGrid("addrow", null, {});
	    	 $('#calculationgrid').jqxGrid('clear');
	    	 $("#calculationgrid").jqxGrid("addrow", null, {});
	    	 
	    	 if($('#intime').jqxDateTimeInput('getDate')!=null && $('#indate').jqxDateTimeInput('getDate')!=null){
				   var intime=new Date($('#intime').jqxDateTimeInput('getDate'));
				   var indate=new Date($('#indate').jqxDateTimeInput('getDate'));
				   var status=checkPriorTime(intime,indate);
				   if(status){
					   document.getElementById("errormsg").innerText="";
					   return true;
				   }
				   else{
					   $('#indate').jqxDateTimeInput('focus');
					   return false;
				   }
			   }
		  }
			   });
	   $('#intime').on('change', function (event) 
			   {  
		   if(document.getElementById("mode").value=="A"){
			document.getElementById("useddays").value="";
			document.getElementById("usedhours").value="";
			document.getElementById("totalkm").value="";
			document.getElementById("excesskm").value="";
			document.getElementById("lblinvoicedone").innerText="";
			 $('#totalgrid').jqxGrid('clear');
	    	 $("#totalgrid").jqxGrid("addrow", null, {});
	    	 $('#calculationgrid').jqxGrid('clear');
	    	 $("#calculationgrid").jqxGrid("addrow", null, {});
	    	 if($('#intime').jqxDateTimeInput('getDate')!=null){
				   var intime=new Date($('#intime').jqxDateTimeInput('getDate'));
				   var indate=new Date($('#indate').jqxDateTimeInput('getDate'));
				   var status=checkPriorTime(intime,indate);
				   if(status){
					   document.getElementById("errormsg").innerText="";
					   return true;
				   }
				   else{
					   $('#intime').jqxDateTimeInput('focus');
					   return false;
				   }
			   }
		   }
		   
		   
			   });
	   $( "#inkm" ).change(function() {
		   if(document.getElementById("mode").value=="A"){
			document.getElementById("useddays").value="";
			document.getElementById("usedhours").value="";
			document.getElementById("totalkm").value="";
			document.getElementById("excesskm").value="";
			document.getElementById("lblinvoicedone").innerText="";
			 $('#totalgrid').jqxGrid('clear');
	    	 $("#totalgrid").jqxGrid("addrow", null, {});
	    	 $('#calculationgrid').jqxGrid('clear');
	    	 $("#calculationgrid").jqxGrid("addrow", null, {});
		   }
		 });
	   $( "#cmbinfuel" ).change(function() {
		   if(document.getElementById("mode").value=="A"){
			document.getElementById("useddays").value="";
			document.getElementById("usedhours").value="";
			document.getElementById("totalkm").value="";
			document.getElementById("excesskm").value="";
			document.getElementById("lblinvoicedone").innerText="";
			 $('#totalgrid').jqxGrid('clear');
	    	 $("#totalgrid").jqxGrid("addrow", null, {});
	    	 $('#calculationgrid').jqxGrid('clear');
	    	 $("#calculationgrid").jqxGrid("addrow", null, {});
		   }
		 });
	   
	   

	   
	   
	   
	   $('#vocno').dblclick(function(){
		 if(document.getElementById("mode").value=="A"){
			 if(document.getElementById("cmbagmtbranch").value==""){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="Agreement Branch is Mandatory";
					return false;
				}
		    $('#agmtnowindow').jqxWindow('open');
		$('#agmtnowindow').jqxWindow('focus');
		 agmtnoSearchContent('agmtnoSearch.jsp?', $('#agmtnowindow'));
		 }
		});
	   $('#checkin').dblclick(function(){
			 if(document.getElementById("mode").value=="A"){

		    $('#checkinWindow').jqxWindow('open');
		$('#checkinWindow').jqxWindow('focus');
		 checkinSearchContent('checkinGrid.jsp?', $('#checkinWindow'));
			 }
			 });
	   $('#rentalagent').dblclick(function(){
			 if(document.getElementById("mode").value=="A"){

		    $('#rentalAgentWindow').jqxWindow('open');
		$('#rentalAgentWindow').jqxWindow('focus');
		 rentalSearchContent('rentalAgentGrid.jsp?', $('#rentalAgentWindow'));
			 }
			 });
	   $('#chauffer').dblclick(function(){
		    $('#collectionWindow').jqxWindow('open');
		$('#collectionWindow').jqxWindow('focus');
		 collectSearchContent('collectSearch.jsp', $('#collectionWindow'));
		});
	   //alert(document.getElementById("mode").value);
	   if(document.getElementById("mode").value=='view'){
		  $('#btnprocess').attr('disabled',true);
		  $('#btncalculate').attr('disabled',true);
	   }
 });
 
 function getLeasePrior(){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();
			items = items.split('***');
			document.getElementById("priormethod").value=items[0];
			document.getElementById("priorvalue").value=items[1];
			document.getElementById("defaultdate").value=items[2];
			document.getElementById("agmtsat").value=items[3];
			if(document.getElementById("defaultdate").value=="1" && document.getElementById("docno").value==""){
				$('#indate,#intime').jqxDateTimeInput('setDate',new Date());
			}
			if(document.getElementById("agmtsat").value=="1"  && document.getElementById("docno").value==""){
				$('#btndownload').show();
			}
			} else {
			}
		}
		x.open("GET", "../getLeasePriorClose.jsp", true);
		x.send();
 }
function checkPriorTime(intime,indate){
	 var currenttime=new Date();
	 var priormethod=document.getElementById("priormethod").value;
	 var priorvalue=document.getElementById("priorvalue").value;
	 var priorhours=priorvalue/60;
	 if(priormethod=="0"){
		 return true;
	 }
	 else if(parseInt(priormethod)>0){
		 var priordate=indate;
		 priordate.setHours(intime.getHours());
		 priordate.setMinutes(intime.getMinutes());
		 var difference=currenttime-priordate;
		 var minutediff=parseInt(difference/(1000*60));
		 if(minutediff>priorvalue){
			 document.getElementById("errormsg").innerText="";
			 document.getElementById("errormsg").innerText="Prior Close time is "+priorhours+" hours";
			 return false;
		 }
		 else{
			 return true;
		 }
	 }
}
 
function getBranch(){
	var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('***');
				var locItems = items[0].split(",");
				var locIdItems = items[1].split(",");
				var optionsloc = '<option value="">--Select--</option>';
				for (var i = 0; i < locItems.length; i++) {
					optionsloc += '<option value="' + locIdItems[i] + '">'
							+ locItems[i] + '</option>';
				}
				$("select#cmbagmtbranch").html(optionsloc);
				
				if ($('#hidcmbagmtbranch').val() != null) {
					$('#cmbagmtbranch').val($('#hidcmbagmtbranch').val());
				}
			} else {
			}
		}
		x.open("GET", "getBranch.jsp", true);
		x.send();
	}
	
	
	
//Minimize menu functions
function menuContent(url) {
    $.get(url).done(function (data) {
       $('#window1').jqxWindow('open');
   $('#window1').jqxWindow('setContent', data);
   $('#window1').jqxWindow('bringToFront');
   
      });
}
function replacement(){
//Function to show replaced vehicles
if (($("#mode").val() == "view") && $("#docno").val()!="") {
$('#window1').jqxWindow('open');
    menuContent('vehReplaceGrid.jsp?docnovals='+document.getElementById("agreementno").value, $('#window1')); 
}
else {
    $.messager.alert('Message','Select a Document....!','warning');
    return false;
   }
}

function fine(){
//Function to show Traffic Fines Charged	
if (($("#mode").val() == "view") && $("#docno").val()!="") {
 $('#window1').jqxWindow('open');
    menuContent('trafficFines.jsp?docnovals='+document.getElementById("agreementno").value, $('#window1'));         
}
else {
    $.messager.alert('Message','Select a Document....!','warning');
    return false;
   }
}

function account(){
//Function to show Account Statement 	
if (($("#mode").val() == "view") && $("#docno").val()!="") {
 $('#window1').jqxWindow('open');
    menuContent('accountsmainForm.jsp?docnovals='+document.getElementById("agreementno").value, $('#window1'));
}
else {
    $.messager.alert('Message','Select a Document....!','warning');
    return false;
   }
}

function closing(){
	 if (($("#mode").val() == "view") && $("#docno").val()!="") {
	      var url=document.URL;
	        var reurl=url.split("saveLeaseClose");
	        $("#docno").prop("disabled", false);                

	        var win= window.open(reurl[0]+"printLAGClosingSummary?docno="+document.getElementById("agreementno").value,"_blank","top=85,left=150,Width=1020,Height=600,location=no,scrollbars=no,toolbar=yes");
	      win.focus();
	     } 
	    
	     else {
	            $.messager.alert('Message','Select a Document....!','warning');
	            return false;
	           } 
	}
	
function funKmDetails(){
  	if (($("#mode").val() == "view") && $("#agreementno").val()!="") {
	 $('#window1').jqxWindow('open');
     menuContent('kmdetails.jsp?docno='+document.getElementById("agreementno").value+'&id=1', $('#window1')); 
  	}
  	 else {
	      $.messager.alert('Message','Select a Document....!','warning');
	      return false;
	     }
}
//Minimize menu functions ends here
function getAgmt(event){
	 if(document.getElementById("cmbagmtbranch").value==""){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Agreement Branch is Mandatory";
			return false;
		}
	 var x= event.keyCode;
     if(x==114){
 	    $('#agmtnowindow').jqxWindow('open');
		$('#agmtnowindow').jqxWindow('focus');
		 agmtnoSearchContent('agmtnoSearch.jsp?', $('#agmtnowindow'));
     }
     else{
      }
}
function getChauffer(event){
	 var x= event.keyCode;
     if(x==114){
    	   $('#collectionWindow').jqxWindow('open');
   		$('#collectionWindow').jqxWindow('focus');
   		 collectSearchContent('collectSearch.jsp', $('#collectionWindow'));
     }
     else{
      }
}
function getCheckin(event){
	 var x= event.keyCode;
    if(x==114){
    	 $('#checkinWindow').jqxWindow('open');
 		$('#checkinWindow').jqxWindow('focus');
 		 checkinSearchContent('checkinGrid.jsp?', $('#checkinWindow'));
    }
    else{
     }
}
function getRentalAgent(event){
	 var x= event.keyCode;
   if(x==114){
   	 $('#rentalAgentWindow').jqxWindow('open');
		$('#rentalAgentWindow').jqxWindow('focus');
		rentalSearchContent('rentalAgentGrid.jsp?', $('#rentalAgentWindow'));
   }
   else{
    }
}

 function agmtnoSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#agmtnowindow').jqxWindow('setContent', data);

}); 
}
 function checkinSearchContent(url) {
	    //alert(url);
	      $.get(url).done(function (data) {
	//alert(data);
	    $('#checkinWindow').jqxWindow('setContent', data);

	}); 
	}
 function rentalSearchContent(url) {
	    //alert(url);
	      $.get(url).done(function (data) {
	//alert(data);
	    $('#rentalAgentWindow').jqxWindow('setContent', data);

	}); 
	}
function collectSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#collectionWindow').jqxWindow('setContent', data);

}); 
}
function setCollection(){
	if(document.getElementById("chkcollection").checked==true){
		document.getElementById("chauffer").disabled=false;
		document.getElementById("collectchg").disabled=false;
		document.getElementById("collectkm").disabled=false;
		document.getElementById("cmbcollectfuel").disabled=false;
		$('#collectdate').jqxDateTimeInput({ disabled: false});
		$('#collecttime').jqxDateTimeInput({ disabled: false});
		document.getElementById("hidchkcollection").value=1;
	}
	else if(document.getElementById("chkcollection").checked==false){
		document.getElementById("chauffer").disabled=true;
		document.getElementById("collectchg").disabled=true;
		document.getElementById("collectkm").disabled=true;
		document.getElementById("cmbcollectfuel").disabled=true;
		$('#collectdate').jqxDateTimeInput({ disabled: true});
		$('#collecttime').jqxDateTimeInput({ disabled: true});
		document.getElementById("hidchkcollection").value=0;
	}
}

	function funReadOnly(){
		setCollection();
		$('#frmRentalClose input').attr('readonly',true);
		$('#frmRentalClose select').attr('disabled',true);
		 $('#closedate').jqxDateTimeInput({ disabled: true});
		 $('#indate').jqxDateTimeInput({ disabled: true});
		 $('#collectdate').jqxDateTimeInput({ disabled: true});
		 $('#intime').jqxDateTimeInput({ disabled: true});
		 $('#collecttime').jqxDateTimeInput({ disabled: true});
		 //$('#tarifreferencegrid').jqxGrid({ disabled: true});
		  $('#totalgrid').jqxGrid({ disabled: true});
		   $('#trafficGrid').jqxGrid({ disabled: true});
		   $('#tarifagmtgrid').jqxGrid({ disabled: true});
		    $('#calculationgrid').jqxGrid({ disabled: true});
/* 		getCheckin();
		getRentalAgent(); */
	}
	function funNotify(){
	
		if(document.getElementById("agreementno").value==""){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Please select an Agreement";
    		return false;
		}
		if(document.getElementById("cmbcloseloc").value==""){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Please select Close Location";
			document.getElementById("cmbcloseloc").focus();
    		return false;
		}
		var docdateval=funDateInPeriod($('#closedate').jqxDateTimeInput('getDate'));
		if(docdateval==0){
			$('#closedate').jqxDateTimeInput('focus');
			return false;
		}
		
		if($('#indate').jqxDateTimeInput('getDate')==null){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="In Date is Mandatory";
    		return false;
    	}
		var indateval=funDateInPeriod($('#indate').jqxDateTimeInput('getDate'));
		if(indateval==0){
			$('#indate').jqxDateTimeInput('focus');
			return false;
		}	
		if($('#intime').jqxDateTimeInput('getDate')==null){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="In Time is Mandatory";
    		return false;
    	}
		
		var intimeprior=new Date($('#intime').jqxDateTimeInput('getDate'));
		var indateprior=new Date($('#indate').jqxDateTimeInput('getDate'));
		var intimepriorstatus=checkPriorTime(intimeprior,indateprior);
		if(intimepriorstatus){
			document.getElementById("errormsg").innerText="";
		}
		else if(intimepriorstatus==false && document.getElementById("priormethod").value=="2"){
			$('#intime').jqxDateTimeInput('focus');
			return 0;
		}
		
		if($('#inkm').val()==''){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="In Km is Mandatory";
    		return false;
    	}
    	if(document.getElementById("chkcollection").checked==true){
    		if(document.getElementById("chauffer").value==""){
    			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="Driver is Mandatory";
    			return false;
    		}
    		if(document.getElementById("collectchg").value==""){
    			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="Collection Charge is Mandatory";
    			return false;
    		}
    		if($('#collectdate').jqxDateTimeInput('getDate')==null){
    			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="Collection Date cannot be Empty";
    			return false;
    		}
    		var collectdateval=funDateInPeriod($('#collectdate').jqxDateTimeInput('getDate'));
    		if(collectdateval==0){
    			$('#collectdate').jqxDateTimeInput('focus');
    			return false;
    		}
    		if($('#collecttime').jqxDateTimeInput('getDate')==null){
    			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="Collection Time is Mandatory";
        		return false;
        	}
    		if(document.getElementById("collectkm").value==""){
    			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="Collection Km is Mandatory";
        		return false;
    		}
    		var collectdate=$('#collectdate').jqxDateTimeInput('getDate');
    		var indate=$('#indate').jqxDateTimeInput('getDate');
    		var collecttime=$('#collecttime').jqxDateTimeInput('getDate');
    		var intime=$('#intime').jqxDateTimeInput('getDate');
    		collectdate.setHours(0,0,0,0);
    		indate.setHours(0,0,0,0);
    		var inkm=parseFloat(document.getElementById("inkm").value);
    		var collectkm=parseFloat(document.getElementById("collectkm").value);
    		if(indate<collectdate){
    			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="In Date cannot be less than Collection Date";
    			return false;
    		}
    		if(indate-collectdate==0){
    			if(intime.getHours()<collecttime.getHours()){
    				document.getElementById("errormsg").innerText="";
    				document.getElementById("errormsg").innerText="In Time cannot be less than Collection Time";
    				return false;
    			}
    			if(intime.getHours()==collecttime.getHours()){
    				if(intime.getMinutes()<collecttime.getMinutes()){
    					document.getElementById("errormsg").innerText="";
    					document.getElementById("errormsg").innerText="In Time cannot be less than Collection Time";
    					return false;
    				}
    				
    			}
    		}
    		if(inkm<collectkm){
    			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="In Km cannot be less than Collection Km";
    			return false;
    		}
    	}
		if(document.getElementById("cmbinfuel").value==""){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="In Fuel is Mandatory";
			return false;
		}
if(document.getElementById("rentalagent").value==""){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Rental Agent is Mandatory";
			return false;
		}
		if(document.getElementById("checkin").value==""){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Check In is Mandatory";
			return false;
		}
		
		
		/*if(typeof($("#totalgrid").jqxGrid("getcellvalue",0,"rate"))=="undefined" || $("#totalgrid").jqxGrid("getcellvalue",0,"rate")==""){
			
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Please Process";
			return 0;
		}
		if($('#calculationgrid').jqxGrid('getcellvalue',0,'description')=='' || typeof($('#calculationgrid').jqxGrid('getcellvalue',0,'description'))=='undefined'){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Please Calculate";
			return 0;
		}
		*/
		
		var rows = $("#totalgrid").jqxGrid('getrows');
			if(rows[0].rentaltype=="undefined" || rows[0].rentaltype==""){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Please Process";
				return 0;	
			}
		
		//alert(rows);
    	$('#gridlength').val(rows.length);
    		//alert($('#gridlength').val());
    		for(var i=0 ; i < rows.length ; i++){
			//	var myvar = rows[i].tarif; 
				newTextBox = $(document.createElement("input"))
			    .attr("type", "dil")
			    .attr("id", "test"+i)
			    .attr("name", "test"+i)
			    .attr("hidden", "true");
			
				newTextBox.val(rows[i].rentaltype+"::"+rows[i].rate+"::"+rows[i].cdw+"::"+rows[i].pai+"::"+rows[i].cdw1+"::"+rows[i].pai1+"::"+rows[i].gps+"::"+rows[i].babyseater+"::"+rows[i].cooler+"::"+rows[i].exhrchg+"::"+rows[i].exkmrte+"::"+rows[i].chaufchg);
			
			newTextBox.appendTo('form');
			
				//alert("ddddd"+$("#test"+i).val());
			}
    		var rowscalc = $("#calculationgrid").jqxGrid('getrows');
    		//alert(rows);
    		/*if(rowscalc[0].description=="undefined" || rowscalc[0].description==""){
    			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="Please Calculate";
    			return 0;
    			
    		}*/
    		document.getElementById("errormsg").innerText="";
        	$('#calcgridlength').val(rowscalc.length);
        		//alert($('#gridlength').val());
        		for(var i=0 ; i < rowscalc.length ; i++){
    			//	var myvar = rows[i].tarif; 
    				newTextBox = $(document.createElement("input"))
    			    .attr("type", "dil")
    			    .attr("id", "testcalc"+i)
    			    .attr("name", "testcalc"+i)
    			    .attr("hidden", "true");
    				  var summaryData= $("#calculationgrid").jqxGrid('getcolumnaggregateddata', 'creditnote', ['sum'],true);
                      document.getElementById("creditnotesum").value=summaryData.sum;
    				//newTextBox.val(rows[i].idno+"::"+rows[i].account+"::"+rows[i].description+"::"+rows[i].qty+"::"+rows[i].rate+"::"+rows[i].total);
    				newTextBox.val(rowscalc[i].idno+"::"+rowscalc[i].acno+"::"+rowscalc[i].description+"::"+rowscalc[i].qty+"::"+rowscalc[i].invoiced+"::"+rowscalc[i].invoice+"::"+rowscalc[i].creditnote+"::"+rowscalc[i].salamount+"::"+rowscalc[i].salikrate+"::"+rowscalc[i].saliksrvc+"::"+rowscalc[i].salikamt+"::"+rowscalc[i].trafficamt+"::"+rowscalc[i].trafficsrvc+"::"+rowscalc[i].salikauhamt+"::"+rowscalc[i].salikdxbamt+"::"+rowscalc[i].salikauhsrvc+"::"+rowscalc[i].salikdxbsrvc+"::"+rowscalc[i].salikauhcount+"::"+rowscalc[i].salikdxbcount+"::"+rowscalc[i].salikauhrate+"::"+rowscalc[i].salikdxbrate+"::"+rowscalc[i].salikauhsrvcrate+"::"+rowscalc[i].salikdxbsrvcrate+"::"+rowscalc[i].salikparkamt+"::"+rowscalc[i].salikparksrvc+"::"+rowscalc[i].salikparkcount+"::"+rowscalc[i].salikparkrate+"::"+rowscalc[i].salikparksrvcrate);
    			
    			newTextBox.appendTo('form');
    			
    				//alert("ddddd"+$("#testcalc"+i).val());
    			}
        		
		return 1;
	}
	
	function funRemoveReadOnly(){
		$('#frmRentalClose input').attr('readonly',false);
		$('#frmRentalClose select').attr('disabled',false);
		 $('#closedate').jqxDateTimeInput({ disabled: false});
		 $('#indate').jqxDateTimeInput({ disabled:false});
		 $('#intime').jqxDateTimeInput({ disabled: false});
		 $('#useddays').attr('readonly',true);
		 $('#usedhours').attr('readonly',true);
		 $('#totalkm').attr('readonly',true);
		 $('#excesskm').attr('readonly',true);
		 $('#agreementno').attr('readonly',true);
		 $('#vehicle').attr('readonly',true);
		 $('#clientid').attr('readonly',true);
		 $('#chauffer').attr('readonly',true);
		 $('#client').attr('readonly',true);
		 $('#docno').attr('readonly',true);
		 $('#checkin').attr('readonly',true);
		 $('#rentalagent').attr('readonly',true);
		// $('#tarifreferencegrid').jqxGrid({ disabled: false});
		  $('#totalgrid').jqxGrid({ disabled: false});
		   $('#trafficGrid').jqxGrid({ disabled:false});
		   $('#tarifagmtgrid').jqxGrid({ disabled: false});
		    $('#calculationgrid').jqxGrid({ disabled: false});
		    if(document.getElementById("mode").value=='A'){
		    	 $('#totalgrid').jqxGrid('clear');
		    	 $("#totalgrid").jqxGrid("addrow", null, {});
		    	 $('#trafficGrid').jqxGrid('clear');
		    	 $("#trafficGrid").jqxGrid("addrow", null, {});
		    	 $('#tarifagmtgrid').jqxGrid('clear');
		    	 $("#tarifagmtgrid").jqxGrid("addrow", null, {});
		    	 $('#calculationgrid').jqxGrid('clear');
		    	 $("#calculationgrid").jqxGrid("addrow", null, {});
		    	 $('#btnprocess').attr('disabled',false);
				  $('#btncalculate').attr('disabled',false);
		    
		    
			}
			if(document.getElementById("brchName").value!=""){
				getAgmtLocation();
			}
			if(document.getElementById("mode").value!="A"){
				document.getElementById("btnprocess").disabled=true;
				document.getElementById("btncalculate").disabled=true;
			}
		    setCollection();
			getLeasePrior();
	}
	function funChkButton(){
		
	}
	  function isNumber(evt,id) {
	//Function to restrict characters and enter number only
		  var iKeyCode = (evt.which) ? evt.which : evt.keyCode
	        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
	         {
	        	 $.messager.alert('Warning','Enter Numbers Only');
	           $("#"+id+"").focus();
	            return false;
	            
	         }
	        
	        return true;
	    }
	function funFocus(){
		document.getElementById("agreementno").focus();
	}

	function funChecking(){
	//Validation Before calling Ajax method for calculation	
		var docdateval=funDateInPeriod($('#closedate').jqxDateTimeInput('getDate'));
		if(docdateval==0){
			$('#closedate').jqxDateTimeInput('focus');
			return false;
		}
		if($('#indate').jqxDateTimeInput('getDate')==null){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="In Date is Mandatory";
    		return false;
    	}
		
		var indateval=funDateInPeriod($('#indate').jqxDateTimeInput('getDate'));
		if(indateval==0){
			$('#indate').jqxDateTimeInput('focus');
			return false;
		}
		if($('#intime').jqxDateTimeInput('getDate')==null){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="In Time is Mandatory";
    		return false;
    	}
    	if(document.getElementById("chkcollection").checked==true){
    		if(document.getElementById("chauffer").value==""){
    			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="Chauffer is Mandatory";
    			return false;
    		}
    		if(document.getElementById("collectchg").value==""){
    			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="Collection Charge is Mandatory";
    			return false;
    		}
    		if($('#collectdate').jqxDateTimeInput('getDate')==null){
    			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="Collection Date cannot be Empty";
    			return false;
    		}
    		var collectdateval=funDateInPeriod($('#collectdate').jqxDateTimeInput('getDate'));
    		if(collectdateval==0){
    			$('#collectdate').jqxDateTimeInput('focus');
    			return false;
    		}
    		if($('#collecttime').jqxDateTimeInput('getDate')==null){
    			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="Collection Time is Mandatory";
        		return false;
        	}
    		if(document.getElementById("collectkm").value==""){
    			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="Collection Km is Mandatory";
        		return false;
    		}
    		var collectdate=$('#collectdate').jqxDateTimeInput('getDate');
    		var indate=$('#indate').jqxDateTimeInput('getDate');
    		var collecttime=$('#collecttime').jqxDateTimeInput('getDate');
    		var intime=$('#intime').jqxDateTimeInput('getDate');
    		collectdate.setHours(0,0,0,0);
    		indate.setHours(0,0,0,0);
    		var inkm=parseFloat(document.getElementById("inkm").value);
    		var collectkm=parseFloat(document.getElementById("collectkm").value);
    		if(indate<collectdate){
    			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="In Date cannot be less than Collection Date";
    			return false;
    		}
    		if(indate-collectdate==0){
    			if(intime.getHours()<collecttime.getHours()){
    				document.getElementById("errormsg").innerText="";
    				document.getElementById("errormsg").innerText="In Time cannot be less than Collection Time";
    				return false;
    			}
    			if(intime.getHours()==collecttime.getHours()){
    				if(intime.getMinutes()<collecttime.getMinutes()){
    					document.getElementById("errormsg").innerText="";
    					document.getElementById("errormsg").innerText="In Time cannot be less than Collection Time";
    					return false;
    				}
    				
    			}
    		}
    		if(inkm<collectkm){
    			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="In Km cannot be less than Collection Km";
    			return false;
    		}
    	}
		if(document.getElementById("cmbinfuel").value==""){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="In Fuel is Mandatory";
			return false;
		}
if(document.getElementById("rentalagent").value==""){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Rental Agent is Mandatory";
			return false;
		}
		if(document.getElementById("checkin").value==""){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Check In is Mandatory";
			return false;
		}
		document.getElementById("errormsg").innerText="";
		checkAgmtDelivery();//Calling ajax method
		
	}
	
	function funProcess(){
	
		if(document.getElementById("errormsg").innerText!=""){
			return false;
		}
	
		var useddays=document.getElementById("useddays").value;
		var usedhours=document.getElementById("usedhours").value;
		var totalkm=document.getElementById("totalkm").value;
		var excesskm=document.getElementById("excesskm").value;
		var agmtno=document.getElementById("agreementno").value;
		//var rentaltype=$('#tarifagmtgrid').jqxGrid('getcellvalue', 0, "rentaltype");
		var agmtdate=$('#datehidden').jqxDateTimeInput('getText');
		var closedate=$('#closedatehidden').jqxDateTimeInput('getText');
		var closeinvdate=$('#closeinvdate').jqxDateTimeInput('val');
		$('#totaldiv').load("totalGrid.jsp?useddays="+useddays+"&usedhours="+usedhours+"&totalkm="+totalkm+"&excesskm="+excesskm+"&agmtno="+agmtno+"&agmtdate="+agmtdate+"&closedate="+closedate+"&temp=1&closeinvdate="+closeinvdate);
	}
	 function checkAgmtDelivery(){
		 //alert("Here in ajax");
		 var coldate=null;
		 var coltime="";
		 var colkm=0.0,colfuel=0.0;
		 document.getElementById("hidchkcollection").value="0";
		 if(document.getElementById("chkcollection").checked==true){
			 if($('#collectdate').jqxDateTimeInput('getDate')==null){
				 document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="Collection Date is Mandatory";
					return false;
			 }
			 document.getElementById("hidchkcollection").value="1";
			 colkm=document.getElementById("collectkm").value;
			 colfuel=document.getElementById("cmbcollectfuel").value;
			 coltime=$('#collecttime').jqxDateTimeInput('getText');
			 coldate=$('#collectdate').jqxDateTimeInput('getText');
		 }
		 var temprentaltype= $("#tarifagmtgrid").jqxGrid("getcellvalue",0,"rentaltype");
		 //alert("delstatus="+document.getElementById("delstatus").value+"&agmtno="+document.getElementById("agreementno").value+"&collectkm="+colkm+"&inkm="+document.getElementById("inkm").value+"&indate="+$('#indate').jqxDateTimeInput('getText')+"&infuel="+document.getElementById("cmbinfuel").value+"&collectfuel="+colfuel+"&intime="+$('#intime').jqxDateTimeInput('getText')+"&collecttime="+coltime+"&collectdate="+coldate);
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				//alert(x.responseText);
				
				items = items.split('***');
				document.getElementById("useddays").value="";
				document.getElementById("usedhours").value="";
				document.getElementById("totalkm").value="";
				document.getElementById("totalfuel").value="";
				document.getElementById("agmtkm").value="";
				
				 $('#totalgrid').jqxGrid('clear');
		    	 $("#totalgrid").jqxGrid("addrow", null, {});
		    	 $('#calculationgrid').jqxGrid('clear');
		    	 $("#calculationgrid").jqxGrid("addrow", null, {});
		    	 document.getElementById("excesskm").value="";
		    	 //alert($("#datehidden").jqxDateTimeInput('val'));
				//alert($("#datehidden").jqxDateTimeInput('val'));
				if(items[12].trim()=='1'){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="Agreement Not yet Started..Please check Out Date";
					return false;
				}
				if(items[13].trim()=='1'){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="Agreement Not yet Started..Please check Out Time";
					return false;
				}
				if(items[5].trim()=='1'){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="In KM cannot be less than Out KM";
					return false;
				}
				if(items[6].trim()=='1'){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="In Date cannot be less than Out Date";
					return false;
				}
				if(items[7].trim()=='1'){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="In Time cannot be less than Out Time";
					return false;
				}
				if(items[11].trim()=='1'){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="Collection KM cannot be less than In KM";
					return false;
				}
				if(items[14].trim()=='1'){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="Agreement Delivery is not Completed";
					return false;
				}
				if(items[9].trim()=='1'){
					 $.messager.alert('Warning','Invoice has been done till '+items[10].trim());
				}
				if(items[15].trim()=='1'){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="Invoice's are Pending";
					return false;
				}
				if(items[20].trim()=='1'){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="Vehicle In Date cannot be less than last out date";
					return false;
				}
				
				document.getElementById("errormsg").innerText="";
				//alert("finish");
				document.getElementById("fuel2").value=items[21].trim();
				document.getElementById("delcheckstatus").value=items[14].trim();
				document.getElementById("useddays").value=items[0];
				document.getElementById("usedhours").value=items[1];
				document.getElementById("totalkm").value=items[2];
				document.getElementById("totalfuel").value=items[3];
				document.getElementById("agmtkm").value=items[4];
				$("#datehidden").jqxDateTimeInput('val',items[8].trim());
				document.getElementById("closecalflag").value=items[17].trim();
				$("#closedatehidden").jqxDateTimeInput('val',items[16].trim());
				$("#closeinvdate").jqxDateTimeInput('val',items[18].trim());
				if(items[19].trim()!='1'){
					document.getElementById("lblinvoicedone").innerText="Invoice has been done till "+items[10].trim();	
				}
				
				funProcess();
			//alert(items[0]+"====="+items[1]+"====="+items[2]+"======"+items[3]);
			/* return "2"; */
			
		}
	}
		x.open("GET", "CheckDeliverykm.jsp?delstatus="+document.getElementById("delstatus").value+"&agmtno="+document.getElementById("agreementno").value+"&collectkm="+colkm+"&inkm="+document.getElementById("inkm").value+"&indate="+$('#indate').jqxDateTimeInput('getText')+"&infuel="+document.getElementById("cmbinfuel").value+"&collectfuel="+colfuel+"&intime="+$('#intime').jqxDateTimeInput('getText')+"&collecttime="+coltime+"&collectdate="+coldate+"&hidchkcollection="+document.getElementById("hidchkcollection").value+"&rentaltype="+temprentaltype, true);
		x.send();
	 }
	function funCalculate(){
		if(document.getElementById("agreementno").value==''){
			document.getElementById("errormsg").innerText="Please Enter Necessary Details";
			return false;
		}
		var temp=$('#totalgrid').jqxGrid('getcellvalue', 0, "rate");
		if((temp=='undefined')||(temp==null)){
			//alert(temp);
			document.getElementById("errormsg").innerText="Please Process Again";
			return false;
		}
		
		document.getElementById("errormsg").innerText="";
		var agmtno=document.getElementById("agreementno").value;
		var tarif=$('#totalgrid').jqxGrid('getcellvalue', 2, "rate");
		var cdwtotal=0;
		cdwtotal=$('#totalgrid').jqxGrid('getcellvalue', 2, "cdw");
		cdwtotal=cdwtotal+$('#totalgrid').jqxGrid('getcellvalue', 2, "pai");
		cdwtotal=cdwtotal+$('#totalgrid').jqxGrid('getcellvalue', 2, "cdw1");
		cdwtotal=cdwtotal+$('#totalgrid').jqxGrid('getcellvalue', 2, "pai1");
		var acc=0;
		acc=$('#totalgrid').jqxGrid('getcellvalue', 2, "gps");
		acc=acc+$('#totalgrid').jqxGrid('getcellvalue', 2, "babyseater");
		acc=acc+$('#totalgrid').jqxGrid('getcellvalue', 2, "cooler");
		var chauffer=0;
		chauffer=$('#totalgrid').jqxGrid('getcellvalue', 2, "chaufchg");
		var excesskmchg=0.0,excesshrchg=0.0;
		excesskmchg=$('#totalgrid').jqxGrid('getcellvalue', 2, "exkmrte");
		excesshrchg=$('#totalgrid').jqxGrid('getcellvalue', 2, "exhrchg");
		var clientid=document.getElementById("clientid").value;
		var fuel=document.getElementById("totalfuel").value;
		var termamt=document.getElementById("termamt").value;
		var agmtdate=$('#datehidden').jqxDateTimeInput('getText');
		var closedate=$('#indate').jqxDateTimeInput('getText');
		var closeinvdate=$('#closeinvdate').jqxDateTimeInput('val');
		var calctype=document.getElementById("calctype").value;
	$('#calcdiv').load("calculationGrid.jsp?agmtno="+agmtno+"&tarif="+tarif+"&cdwtotal="+cdwtotal+"&acctotal="+acc+"&chauffer="+chauffer+"&excesskmchg="+excesskmchg+"&excesshrchg="+excesshrchg+"&temp=1&usedhours="+document.getElementById("usedhours").value+"&clientid="+clientid+"&fuel="+fuel+"&deliverychg="+document.getElementById("deliverychg").value+"&collectchg="+document.getElementById("collectchg").value+"&termamt="+termamt+"&outdate="+agmtdate+"&indate="+closedate+"&cmbinfuel="+document.getElementById("fuel2").value+"&exkm="+document.getElementById("excesskm").value+"&termmonth="+document.getElementById("termmonth").value+"&closeinvdate="+closeinvdate+"&closecalflag="+$('#closecalflag').val()+"&calctype="+calctype);
	}
	function setValues(){
		if(document.getElementById("mode").value!="A"){
			document.getElementById("btnprocess").disabled=true;
			document.getElementById("btncalculate").disabled=true;
		}
		// document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		funSetlabel(); 
		if($('#msg').val()!=""){
  		   $.messager.alert('Message',$('#msg').val());
  		  }
		 if($('#hidcollecttime').val()){
				$("#collecttime").jqxDateTimeInput('val', $('#hidcollecttime').val());
			}
		 if($('#hidintime').val()){
				$("#intime").jqxDateTimeInput('val', $('#hidintime').val());
			}
			if ($('#hidcmbcollectfuel').val() != null) {
				$('#cmbcollectfuel').val($('#hidcmbcollectfuel').val());
			}
			if ($('#hidcmbinfuel').val() != null) {
				$('#cmbinfuel').val($('#hidcmbinfuel').val());
			}
		   if($('#hidclosedate').val()){
				$("#closedate").jqxDateTimeInput('val', $('#hidclosedate').val());
			}
		 if($('#hidcollectdate').val()){
				$("#collectdate").jqxDateTimeInput('val', $('#hidcollectdate').val());
			}
		 if($('#hidindate').val()){
				$("#indate").jqxDateTimeInput('val', $('#hidindate').val());
			}  
		//alert($('#hidclosedate').val());
		/* 	if ($('#hidcmbcheckin').val() != null) {
				$('#cmbcheckin').val($('#hidcmbcheckin').val());
			}
			if ($('#hidcmbrentalagent').val() != null) {
				$('#cmbrentalagent').val($('#hidcmbrentalagent').val());
			} */
			
		/* 	if(document.getElementById("agreementno").value==''){
				alert("Inside agreement blank");
				$('#calcdiv').load("calculationGrid.jsp");
				$('#totaldiv').load("totalGrid.jsp");
				$("#trafficdiv").load("trafficGrid.jsp");
				$("#agmttarifdiv").load("agreementTarifGrid.jsp");
			} */
			/* if(document.getElementById("docno").value!=''){
				//alert("docno not null");
				
				$("#agmttarifdiv").load("agreementTarifGrid.jsp?agmt="+document.getElementById("agreementno").value);
				$('#totaldiv').load("totalGrid.jsp?agmtno="+document.getElementById("agreementno").value+"&temp=2");
				$("#trafficdiv").load("trafficGrid.jsp?id="+document.getElementById("agreementno").value);
				$('#calcdiv').load("calculationGrid.jsp?agmtno="+document.getElementById("agreementno").value+"&temp=2");
				 
				 /*$("#agmttarifdiv").load("agreementTarifGrid.jsp?agmt="+document.getElementById("agreementno").value);
			} */
			
			if((document.getElementById("agreementno").value!='')&&(document.getElementById("docno").value!='')){

				$("#agmttarifdiv").load("agreementTarifGrid.jsp?agmt="+document.getElementById("agreementno").value);
				$('#totaldiv').load("totalGrid.jsp?agmtno="+document.getElementById("agreementno").value+"&temp=2");
				$("#trafficdiv").load("trafficGrid.jsp?id="+document.getElementById("agreementno").value);
				$('#calcdiv').load("calculationGrid.jsp?agmtno="+document.getElementById("agreementno").value+"&temp=2");
			//	$('#referencetarifdiv').load("referenceTarifGrid.jsp?id="+document.getElementById("agreementno").value);
			}
			
			if(document.getElementById("allbranch").value=="1"){
				$("#btnDelete").attr('disabled', true );
			}
}
	function funSearchLoad(){
		changeContent('masterSearch.jsp', $('#window'));
	}
	function funPrintBtn() {
    	if(document.getElementById("docno").value=='' || document.getElementById("docno").value=='0'){
    		 $.messager.alert('Warning','Select a Document');
    		 return false;
    	}
    	var url=document.URL;
    	  var reurl=url.split("saveLeaseClose");
    	    	var win= window.open(reurl[0]+"printLeaseClose?docno="+document.getElementById("agreementno").value+"&formdetailcode=LAC","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
    	win.focus();
    	 }
	
	
	function resetvalues(){
		$("#indate").jqxDateTimeInput('setDate', null);
		$("#intime").jqxDateTimeInput('setDate', null);		
		$("#collectdate").jqxDateTimeInput('setDate', null);
		$("#collecttime").jqxDateTimeInput('setDate', null);
		document.getElementById("chkcollection").checked=false;
		document.getElementById("agreementno").value="";
		document.getElementById("vehicle").value="";
		document.getElementById("client").value="";
		document.getElementById("clientid").value="";
		document.getElementById("description").value="";
		document.getElementById("chauffer").value="";
		document.getElementById("collectchg").value="";
		document.getElementById("collectkm").value="";
		$('#cmbcollectfuel').val('');
		document.getElementById("rentalagent").value="";
		document.getElementById("checkin").value="";
		document.getElementById("useddays").value="";
		document.getElementById("usedhours").value="";
		document.getElementById("totalkm").value="";
		document.getElementById("excesskm").value="";
		document.getElementById("inkm").value="";
		$('#cmbinfuel').val('');
    	 $('#totalgrid').jqxGrid('clear');
    	 $("#totalgrid").jqxGrid("addrow", null, {});
    	 $('#trafficGrid').jqxGrid('clear');
    	 $("#trafficGrid").jqxGrid("addrow", null, {});
    	 $('#tarifagmtgrid').jqxGrid('clear');
    	 $("#tarifagmtgrid").jqxGrid("addrow", null, {});
    	 $('#calculationgrid').jqxGrid('clear');
    	 $("#calculationgrid").jqxGrid("addrow", null, {});
    	 setCollection();
	}
			
			
			
	function getAgmtLocation(){
		var value=document.getElementById("brchName").value;
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('***');
				var locItems = items[0].split(",");
				var locIdItems = items[1].split(",");
				var optionsloc = '<option value="">--Select--</option>';
				for (var i = 0; i < locItems.length; i++) {
					optionsloc += '<option value="' + locIdItems[i] + '">'
							+ locItems[i] + '</option>';
				}
				$("select#cmbcloseloc").html(optionsloc);
				
				if ($('#hidcmbcloseloc').val() != null) {
					$('#cmbcloseloc').val($('#hidcmbcloseloc').val());
				}
			} else {
			}
		}
		x.open("GET", "../rentalclose/getLocation.jsp?branch="+value, true);
		x.send();			
	}
	
	
	function getTestLocation(){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('***');
				var locItems = items[0].split(",");
				var locIdItems = items[1].split(",");
				var optionsloc = '<option value="">--Select--</option>';
				for (var i = 0; i < locItems.length; i++) {
					optionsloc += '<option value="' + locIdItems[i] + '">'
							+ locItems[i] + '</option>';
				}
				$("select#cmbcloseloc").html(optionsloc);
				
				 if ($('#hidcmbcloseloc').val() != null) {
					$('#cmbcloseloc').val($('#hidcmbcloseloc').val());
				} 
			} else {
			}
		}
		x.open("GET", "../rentalclose/getTestLocation.jsp", true);
		x.send();
	}
	function funDownload(){
  		if($('#mode').val()=='A' || $('#mode').val()=='E'){
  			var agmtno=$('#agreementno').val();
      		var fleetno=document.getElementById("hidfleet").value;
     		var x = new XMLHttpRequest();
     		x.onreadystatechange = function() {
     			if (x.readyState == 4 && x.status == 200) {
     				var items = x.responseText.trim().split("::");
     				document.getElementById("errormsg").innerText="";
     				document.getElementById("errormsg").innerText=items[0]+" Saliks Downloaded";
     			}else {
     			}
     		}
     		x.open("GET", "downloadData.jsp?agmtno="+agmtno+"&fleetno="+fleetno, true);
     		x.send();	
  		}
  	}
</script>


</head>
<body onload="setValues();">
<div class="homeContent" data-type="background" >
<form id="frmLeaseClose" action="saveLeaseClose" autocomplete="off">

<jsp:include page="../../../../header.jsp" />

<div class="modern-ui hidden-scrollbar">

    <div class="modern-panel" style="padding-top: 15px;">
        <span class="modern-panel-title">Close Details</span>
        
        <div style="position: absolute; top: -12px; right: 15px;">
            <div id='jqxMenuMore' title="More" align="center" style='visibility: hidden;'>
                <ul>
                    <li><a href="#trafficFines" onclick="fine();">Traffic Fines</a></li>
                    <li><a href="#documents" onclick="replacement();">Replacement</a></li>
                    <li><a href="#history" onclick="account();">Account Statement</a></li>
                    <li><a href="#close" onclick="closing();">Closing Summary</a></li>
                    <li><a href="#kmdetails" onclick="funKmDetails();">KM Details</a></li>
                </ul>
            </div>
        </div>

        <div class="erp-panel-grid" style="display: grid; gap: 10px 15px; grid-template-columns: repeat(3, minmax(0, 1fr)); width: 100%;">
            
            <div style="display: flex; align-items: center; gap: 8px; width: 100%;">
                <label class="lbl-right" style="width:70px">Branch</label>
                <select name="cmbagmtbranch" id="cmbagmtbranch" style="width: 100%;" value='<s:property value="cmbagmtbranch"/>'>
                    <option value="">--Select--</option>
                </select>
                <input type="hidden" name="hidcmbagmtbranch" id="hidcmbagmtbranch" value='<s:property value="hidcmbagmtbranch"/>'>
            </div>

            <div style="display: flex; align-items: center; gap: 8px; width: 100%;">
                <label class="lbl-right" style="width:100px">Agreement No</label>
                <input type="text" name="vocno" id="vocno" style="width: 100%;" value='<s:property value="vocno"/>' onKeyDown="getAgmt(event);" placeholder="Press F3 to Search">
            </div>

            <div style="display: flex; align-items: center; gap: 8px; width: 100%;">
                <label class="lbl-right" style="width:70px">Vehicle</label>
                <input type="text" name="vehicle" id="vehicle" style="width: 100%;" value='<s:property value="vehicle"/>'>
                
                <label class="lbl-right" style="width:50px; margin-left:10px;">Doc No</label>
                <input type="text" name="voucherno" id="voucherno" style="width: 100%;" value='<s:property value="voucherno"/>' readonly>
            </div>

            <div style="display: flex; align-items: center; gap: 8px; width: 100%;">
                <label class="lbl-right" style="width:70px">Client</label>
                <input type="text" name="clientid" id="clientid" style="width: 100%;" value='<s:property value="clientid"/>' >
                <input type="hidden" name="txtaccno" id="txtaccno" value='<s:property value="txtaccno"/>'>
            </div>

            <div style="display: flex; align-items: center; gap: 8px; width: 100%; grid-column: span 2;">
                <input type="text" name="client" id="client" style="width: 100%;" value='<s:property value="client"/>' >
                
                <label class="lbl-right" style="width:40px; margin-left:10px;">Date</label>
                <div style="width:125px;">
                    <div id="closedate" name="closedate" value='<s:property value="closedate"/>'></div>
                </div>
                <input type="hidden" name="hidclosedate" id="hidclosedate" value='<s:property value="hidclosedate"/>'>
            </div>

            <div style="display: flex; align-items: center; gap: 8px; width: 100%; grid-column: span 2;">
                <label class="lbl-right" style="width:70px">Description</label>
                <input type="text" name="description" id="description" style="width: 100%;" value='<s:property value="description"/>'>
            </div>

            <div style="display: flex; align-items: center; gap: 8px; width: 100%;">
                <label class="lbl-right" style="width:70px">Location</label>
                <select name="cmbcloseloc" id="cmbcloseloc" style="width: 100%;" value='<s:property value="description" />'>
                    <option value="">--Select--</option>
                </select>
                <input type="hidden" name="hidcmbcloseloc" id="hidcmbcloseloc" value='<s:property value="hidcmbcloseloc" />' />
            </div>

        </div>
    </div>

    <div class="modern-panel">
        <span class="modern-panel-title">In Info</span>
        
        <div style="display: flex; gap: 20px; padding-top: 10px; align-items: flex-start; width: 100%;">

            <div style="width: 18%; display: flex; flex-direction: column; gap: 12px; flex-shrink: 0; min-width: 0;">
                <div class="chk-container">
                    <label class="lbl-right" style="width:70px; text-align:left;">Collection</label>
                    <input type="checkbox" name="chkcollection" id="chkcollection" onchange="setCollection();">
                </div>
                <input type="text" name="chauffer" id="chauffer" value='<s:property value="chauffer"/>' onkeydown="getChauffer(event);" readonly placeholder="Press F3 to Search">
                <input type="text" name="collectchg" id="collectchg" class="align-right-input" value='<s:property value="collectchg"/>' placeholder="Collection Charge">
                <input type="hidden" name="hidchkcollection" id="hidchkcollection" value='<s:property value="hidchkcollection"/>'>
            </div>

            <div style="width:100%; display:flex; flex-direction:column; gap:10px;">

    <!-- COMMON GRID (8 columns = 4 pairs) -->

    <!-- ROW 1 -->
    <div style="display:grid;
                grid-template-columns:120px 1fr 120px 1fr 120px 1fr 120px 1fr;
                gap:10px; align-items:center;">

        <label class="lbl-right">Collection Details KM</label>
        <input type="text" name="collectkm" id="collectkm" class="align-right-input" value='<s:property value="collectkm"/>'>

        <label class="lbl-right">Fuel</label>
        <select name="cmbcollectfuel" id="cmbcollectfuel">
            <option value="">-Select-</option>
            <option value=0.000>Level 0/8</option><option value=0.125>Level 1/8</option>
            <option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option>
            <option value=0.500>Level 4/8</option><option value=0.625>Level 5/8</option>
            <option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option>
            <option value=1.000>Level 8/8</option>
        </select>
        <input type="hidden" name="hidcmbcollectfuel" id="hidcmbcollectfuel" value='<s:property value="hidcmbcollectfuel"/>'>

        <label class="lbl-right">Date</label>
        <div>
            <div id="collectdate" name="collectdate" value='<s:property value="collectdate"/>'></div>
            <input type="hidden" name="hidcollectdate" id="hidcollectdate" value='<s:property value="hidcollectdate"/>'>
        </div>

        <label class="lbl-right">Time</label>
        <div>
            <div id="collecttime" name="collecttime" value='<s:property value="collecttime"/>'></div>
            <input type="hidden" id="hidcollecttime" name="hidcollecttime" value='<s:property value="hidcollecttime"/>'>
        </div>
    </div>

    <!-- ROW 2 -->
    <div style="display:grid;
                grid-template-columns:120px 1fr 120px 1fr 120px 1fr 120px 1fr;
                gap:10px; align-items:center;">

        <label class="lbl-right">In Details KM</label>
        <input type="text" name="inkm" id="inkm" class="align-right-input"
               value='<s:property value="inkm"/>'
               onkeypress="javascript:return isNumber(event,id)">

        <label class="lbl-right">Fuel</label>
        <select name="cmbinfuel" id="cmbinfuel">
            <option value="">-Select-</option>
            <option value=0.000>Level 0/8</option><option value=0.125>Level 1/8</option>
            <option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option>
            <option value=0.500>Level 4/8</option><option value=0.625>Level 5/8</option>
            <option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option>
            <option value=1.000>Level 8/8</option>
        </select>

        <label class="lbl-right">Date</label>
        <div>
            <div id="indate" name="indate" value='<s:property value="indate"/>'></div>
            <input type="hidden" name="hidindate" id="hidindate" value='<s:property value="hidindate"/>'>
        </div>

        <label class="lbl-right">Time</label>
        <div>
            <div id="intime" name="intime" value='<s:property value="intime"/>'></div>
            <input type="hidden" name="hidintime" id="hidintime" value='<s:property value="hidintime"/>'>
        </div>
    </div>

    <!-- ROW 3 -->
    <div style="display:grid;
                grid-template-columns:110px 1fr 110px 1fr 110px 1fr auto;
                gap:10px; align-items:center;">

        <label class="lbl-right">Rental Agent</label>
        <input type="text" name="rentalagent" id="rentalagent"
               value='<s:property value="rentalagent"/>'
               readonly placeholder="Press F3 to search"
               onkeydown="getRentalAgent(event);">

        <input type="hidden" name="hidrentalagent" id="hidrentalagent"
               value='<s:property value="hidrentalagent"/>'>
        <input type="hidden" name="hidcmbcheckin" id="hidcmbcheckin"
               value='<s:property value="hidcmbcheckin"/>'>

        <label class="lbl-right">Check In</label>
        <input type="text" name="checkin" id="checkin"
               value='<s:property value="checkin"/>'
               readonly placeholder="Press F3 to search"
               onkeydown="getCheckin(event);">

        <input type="hidden" name="hidcheckin" id="hidcheckin"
               value='<s:property value="hidcheckin"/>'>
        <input type="hidden" name="hidcmbrentalagent" id="hidcmbrentalagent"
               value='<s:property value="hidcmbrentalagent"/>'>

        <label class="lbl-right">Total KM</label>
        <input type="text" name="totalkm" id="totalkm"
               class="align-right-input"
               value='<s:property value="totalkm"/>' readonly>

        <!-- PROCESS BUTTON -->
        <input type="button" name="btnprocess" id="btnprocess"
               class="myButton"
               value="Process"
               onclick="checkAgmtDelivery();">
    </div>

</div>

        </div>
    </div>

    <div style="display:flex; gap:15px;">
        <div style="flex: 2; display:flex; flex-direction:column; gap:15px;">
            <div class="modern-panel" style="margin-bottom:0; padding: 10px;">
                <div id="agmttarifdiv"><jsp:include page="agreementTarifGrid.jsp"></jsp:include></div>
            </div>
            <div class="modern-panel" style="margin-bottom:0; padding: 10px;">
                <div id="totaldiv"><jsp:include page="totalGrid.jsp"></jsp:include></div>
            </div>
            <div class="modern-panel" style="margin-bottom:0; padding: 10px;">
                <div id="trafficdiv"><jsp:include page="trafficGrid.jsp"></jsp:include></div>
            </div>
        </div>

        <div style="flex: 1.1; display:flex; flex-direction:column;">
            <div style="display:flex; align-items:center; justify-content:center; gap:15px; margin-bottom: 10px;">
                <label name="lblinvoicedone" id="lblinvoicedone" style="color:red; font-weight:bold; font-size:14px; margin:0;"></label>
                <input type="button" name="btncalculate" id="btncalculate" class="myButton" value="Calculate" onclick="funCalculate();">
                <input type="button" name="btndownload" id="btndownload" class="myButton" value="Download" onclick="funDownload();">
            </div>

            <div class="modern-panel" style="margin-bottom:0; flex:1;">
                <span class="modern-panel-title">Calculation Info</span>
                <div style="padding-top: 5px; height: 100%;">
                    <div id="calcdiv"><jsp:include page="calculationGrid.jsp"></jsp:include></div>
                    <input type="hidden" name="hidchkconvert" id="hidchkconvert" value='<s:property value="hidchkconvert"/>'>
                </div>
            </div>
        </div>
    </div>

<input type="hidden" name="agmttime" id="agmttime" value='<s:property value="agmttime"/>'>
<input type="hidden" name="agmtdeliverytime" id="agmtdeliverytime" value='<s:property value="agmtdeliverytime"/>'>
<input type="hidden" name="agmtdate" id="agmtdate" value='<s:property value="agmtdate"/>'>
<input type="hidden" name="agmtkm" id="agmtkm" value='<s:property value="agmtkm"/>'>
<input type="hidden" name="agmtfuel" id="agmtfuel" value='<s:property value="agmtfuel"/>'>
<input type="hidden" name="agmtdeliveryfuel" id="agmtdeliveryfuel" value='<s:property value="agmtdeliveryfuel"/>'>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
<div id="datehidden" name="datehidden" hidden="true"></div>
<div id="agmtdeliverydate" name="agmtdeliverydate" hidden="true"></div>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="chaufferid" id="chaufferid" value='<s:property value="chaufferid"/>'>
<input type="hidden" name="agmtdeliverykm" id="agmtdeliverykm" value='<s:property value="agmtdeliverykm"/>'>
<input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
<input type="hidden" name="hidcmbinfuel" id="hidcmbinfuel" value='<s:property value="hidcmbinfuel"/>' >
<input type="hidden" name="totkm" id="totkm" value='<s:property value="totkm"/>' >
<input type="hidden" name="totfuel" id="totfuel" value='<s:property value="totfuel"/>' >
<input type="hidden" name="totalfuel" id="totalfuel" value='<s:property value="totalfuel"/>' >
<input type="hidden" name="calcgridlength" id="calcgridlength" value='<s:property value="calcgridlength"/>' >
<input type="hidden" name="clientacno" id="clientacno" value='<s:property value="clientacno"/>' >
<input type="hidden" name="hidfleet" id="hidfleet" value='<s:property value="hidfleet"/>' >
<input type="hidden" name="creditnotesum" id="creditnotesum" value='<s:property value="creditnotesum"/>' >
<input type="hidden" name="delstatus" id="delstatus" value='<s:property value="delstatus"/>' >
<input type="hidden" name="deliverychg" id="deliverychg" value='<s:property value="deliverychg"/>' >
<input type="hidden" name="termamt" id="termamt" value='<s:property value="termamt"/>' >
<input type="hidden" name="delcheckstatus" id="delcheckstatus" value='<s:property value="delcheckstatus"/>' >
<input type="hidden" name="termmonth" id="termmonth" value='<s:property value="termmonth"/>' >
<input type="hidden" name="closecalflag" id="closecalflag" value='<s:property value="closecalflag"/>' >
<div name="closeinvdate" id="closeinvdate" value='<s:property value="closeinvdate"/>' ></div>
<div name="closedatehidden" id="closedatehidden" value='<s:property value="closedatehidden"/>' hidden="true"></div>
<input type="hidden" name="agreementno" id="agreementno" value='<s:property value="agreementno"/>' onkeydown="getAgmt(event);" placeholder="Press F3 to Search">
<input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>' readonly>
<input type="hidden" name="fuel2" id="fuel2" value='<s:property value="fuel2"/>'>
<input type="hidden" name="calctype" id="calctype" value='<s:property value="calctype"/>'>
<input type="hidden" name="allbranch" id="allbranch" value='<s:property value="allbranch"/>' >
<input type="hidden" name="priormethod" id="priormethod">
<input type="hidden" name="priorvalue" id="priorvalue">
<input type="hidden" name="defaultdate" id="defaultdate">
<input type="hidden" name="agmtsat" id="agmtsat">
</div>
</form>
<div id="agmtnowindow">
   <div ></div>
</div>
<div id="collectionWindow">
   <div ></div>
</div>
<div id="checkinWindow">
   <div ></div>
</div>
<div id="rentalAgentWindow">
   <div ></div>
</div>
<div id="window1">
   <div ></div>

</div>
</body>
</html>