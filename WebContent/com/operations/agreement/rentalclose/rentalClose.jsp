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
   MASTER UI (SCOPED) — RENTAL CLOSE CONVERSION
========================================================= */

.modern-ui {
    font-family: Arial, sans-serif;
    color: #333;
    font-size: 12px;
    padding-top: 15px;
    box-sizing: border-box;
}

/* INPUTS */
.modern-ui input[type="text"],
.modern-ui select {
    height: 24px !important;
    border: 1px solid #ccc;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box;
    width: 100%;
    min-width: 0;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.modern-ui input:focus,
.modern-ui select:focus {
    border-color: #007bff;
    outline: none;
}

.modern-ui input[readonly] {
    background-color: #f3f4f6;
    color: #6b7280;
}

/* LABELS */
.modern-ui .lbl-right {
    text-align: right;
    font-weight: bold;
    white-space: nowrap;
}

/* PANEL */
.modern-ui .modern-panel {
    border: 1px solid #e1e4e8;
    padding: 15px 10px 10px;
    background: #fff;
    border-radius: 4px;
    margin-bottom: 15px;
    position: relative;
}

.modern-ui .modern-panel-title {
    position: absolute;
    top: -10px;
    left: 10px;
    background: #fff;
    padding: 0 6px;
    color: #0056b3;
    font-weight: bold;
    font-size: 13px;
    border-left: 3px solid #0056b3;
}

/* GRID */
.modern-ui .top-details-grid {
    display: grid;
    grid-template-columns: max-content 1fr max-content 1fr max-content 1fr max-content 1fr;
    gap: 10px;
    align-items: center;
}

/* BUTTON */
.modern-ui .myButton {
    font-weight: bold;
    font-size: 12px;
    height: 24px;
    padding: 0 14px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #fff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
}

.modern-ui .myButton:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%);
}

/* CHECK */
.modern-ui .chk-container {
    display: flex;
    align-items: center;
    gap: 6px;
}

/* SCROLL */
.hidden-scrollbar {
    overflow: auto;
    height: calc(100vh - 140px);
}

.hidden-scrollbar::-webkit-scrollbar {
    width: 0px;
}

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
	$('#lblchkorgregcard').hide();
	$('#chkorgregcardcollect').hide();
	$('#description').css('width','99%');
	if($('#hidchkorgregcard').val()=='1'){
		$('#description').css('width','70%');
		$('#lblchkorgregcard').show();
		$('#chkorgregcardcollect').show();
	}
	document.getElementById("chkcollection").unchecked=true;
	document.getElementById("chauffer").disabled="true";
	checkConvertion(); 
	getConvertion();
	getBranch();
	getTestLocation();
	getPriorClose();
	$('#brchName').change(function(){
  	getAgmtLocation();
 });
	if(document.getElementById("hidchkcollection").value=="1"){
		document.getElementById("chkcollection").checked=true;
	}
	else{
		document.getElementById("chkcollection").checked=false;
	}
	// setCollection();
	//$("#tarifreferencegrid").jqxGrid({ disabled: true});
    
    /* MODIFIED: Heights changed to 24px to match inputs */
	 $("#closedate").jqxDateTimeInput({ width: '125px', height: '24px',formatString:"dd.MM.yyyy"});
	 $("#indate").jqxDateTimeInput({ width: '125px', height: '24px',formatString:"dd.MM.yyyy",value:null});
	 $("#collectdate").jqxDateTimeInput({ width: '125px', height: '24px',formatString:"dd.MM.yyyy",value:null});
	 $("#datehidden").jqxDateTimeInput({ width: '125px', height: '24px',formatString:"dd.MM.yyyy"});
	 $("#agmtdeliverydate").jqxDateTimeInput({ width: '125px', height: '24px',formatString:"dd.MM.yyyy"});
	 $("#closedatehidden").jqxDateTimeInput({ width: '125px', height: '24px',formatString:"dd.MM.yyyy"});
	 $("#closeinvdate").jqxDateTimeInput({ width: '125px', height: '24px',formatString:"dd.MM.yyyy"});
	// $("#accidentdate").jqxDateTimeInput({ width: '125px', height: '24px',formatString:"dd.MM.yyyy"});
	// $("#policecollecteddate").jqxDateTimeInput({ width: '125px', height: '24px',formatString:"dd.MM.yyyy"});
	 $("#intime").jqxDateTimeInput({ width: '80%', height: '24px', formatString: 'HH:mm', showCalendarButton: false ,value:null});
	 $("#collecttime").jqxDateTimeInput({ width: '80%', height: '24px', formatString: 'HH:mm', showCalendarButton: false,value:null});
	
    //Minimize Button
	 $("#jqxMenuMore").jqxMenu({ width: '40%', height: '26px', autoSizeMainItems: true});
     $("#jqxMenuMore").jqxMenu('minimize');            
     $("#jqxMenuMore").css('visibility', 'visible');
     //Common window for minimize button
     $('#window1').jqxWindow({width: '71%', height: '70%',  maxHeight: '70%' ,maxWidth: '80%' , title: 'Details',position: { x: 180, y: 60 } , theme: 'energyblue', showCloseButton: true,keyboardCloseKey: 27});
     $('#window1').jqxWindow('close');
	 //$("#accidenttime").jqxDateTimeInput({ width: '100%', height: '24px', formatString: 'HH:mm', showCalendarButton: false });
	  $('#agmtnowindow').jqxWindow({ width: '60%', height: '68%',  maxHeight: '68%' ,maxWidth: '60%' , title: 'Agreement Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#agmtnowindow').jqxWindow('close');
	   $('#collectionWindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '58%' ,maxWidth: '50%' , title: 'Collection Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#collectionWindow').jqxWindow('close');
	   $('#checkinWindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '58%' ,maxWidth: '50%' , title: 'Check In Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#checkinWindow').jqxWindow('close');
	   $('#rentalAgentWindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '58%' ,maxWidth: '50%' , title: 'Rental Agent Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
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
		   }
		   
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
 function getPriorClose(){
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
		x.open("GET", "../getPriorClose.jsp", true);
		x.send();
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
	
	
function menuContent(url) {
    $.get(url).done(function (data) {
       $('#window1').jqxWindow('open');
   $('#window1').jqxWindow('setContent', data);
   $('#window1').jqxWindow('bringToFront');
   
      });
}
function replacement(){
	if (($("#mode").val() == "view") && $("#agreementno").val()!="") {
    $('#window1').jqxWindow('open');
    menuContent('vehReplaceGrid.jsp?docnovals='+document.getElementById("agreementno").value, $('#window1'));
	}

	   else {
	    	      $.messager.alert('Message','Select a Document....!','warning');
	    	      return false;
	    	     } 
}

function fine(){
	if (($("#mode").val() == "view") && $("#agreementno").val()!="") {
 $('#window1').jqxWindow('open');
    menuContent('trafficFines.jsp?docnovals='+document.getElementById("agreementno").value, $('#window1'));         
	}

	   else {
	    	      $.messager.alert('Message','Select a Document....!','warning');
	    	      return false;
	    	     } 
	}

function account(){
	if (($("#mode").val() == "view") && $("#agreementno").val()!="") {
 $('#window1').jqxWindow('open');
    menuContent('accountsmainForm.jsp?docnovals='+document.getElementById("agreementno").value, $('#window1')); 
	}

	   else {
	    	      $.messager.alert('Message','Select a Document....!','warning');
	    	      return false;
	    	     } 
}

function closing(){
	//alert($("#mode").val());
	if (($("#mode").val() == "view") && $("#agreementno").val()!="") {
 	   var url=document.URL;
        var reurl=url.split("saveRentalClose");
        //$("#docno").prop("disabled", false);                

        var win= window.open(reurl[0]+"printRAClosingSummaryNormal?docno="+document.getElementById("agreementno").value,"_blank","top=85,left=150,Width=1020,Height=600,location=no,scrollbars=no,toolbar=yes");
 	   win.focus();
 	   } 
 	  
 	   else {
	    	      $.messager.alert('Message','Select a Document....!','warning');
	    	      return false;
	    	     } 
}

function getAgmt(event){
	
	  /* $('#gridRaSearch').jqxGrid('clear');
  	 $("#gridRaSearch").jqxGrid("addrow", null, {}); */
	if(document.getElementById("mode").value=='A'){
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
 function checkConvertion(){
		
		$("#tarifreferencegrid").jqxGrid({ disabled: true});
	
	
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

	function getConvertion(){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				 var items=x.responseText.trim();
				//alert("Response items"+items);
					if(items=='noconvert'){
		
						document.getElementById("referencefield").style.display="none";
		
					}
			else {
				
			}
			}
		}
		x.open("GET", "getConvertion.jsp", true);
		x.send();
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
		 $('#tarifreferencegrid').jqxGrid({ disabled: true});
		  $('#totalgrid').jqxGrid({ disabled: true});
		   $('#trafficGrid').jqxGrid({ disabled: true});
		   $('#tarifagmtgrid').jqxGrid({ disabled: true});
		    $('#calculationgrid').jqxGrid({ disabled: true});
		   
/* getCheckin();
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
		
		var intimestatus=checkfuturetime($('#indate').jqxDateTimeInput('getDate'),$('#intime').jqxDateTimeInput('getDate'));
    	if(intimestatus){
    		document.getElementById("errormsg").innerText="";
    			
    	}
    	else{
    		$('#intime').jqxDateTimeInput('focus');
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
    		var collectdate=$('#collectdate').jqxDateTimeInput('getDate');
    		var indate=$('#indate').jqxDateTimeInput('getDate');
    		var collecttime=$('#collecttime').jqxDateTimeInput('getDate');
    		var intime=$('#intime').jqxDateTimeInput('getDate');
			
			var collecttimestatus=checkfuturetime(collectdate,collecttime);
	    	if(collecttimestatus){
	    		document.getElementById("errormsg").innerText="";
	    			
	    	}
	    	else{
	    		$('#collecttime').jqxDateTimeInput('focus');
	    		return false;
	    	}
			
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
		
		
	/* var validrate=$("#totalgrid").jqxGrid("getcellvalue",0,"rate");
		if(validrate==="" || validrate===null || validrate==="undefined" || typeof(validrate)==="undefined"){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Please Process";
			return 0;
		}
		var validdesc=$('#calculationgrid').jqxGrid('getcellvalue',0,'description');
		if(validdesc==="" || validdesc===null || validdesc==="undefined" || typeof(validdesc)==="undefined"){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Please Calculate";
			return 0;
		} 
 */
 		var invtype=$('#invtype').val();
 		if(invtype!="3"){
 			var validrate=$("#totalgrid").jqxGrid("getcellvalue",0,"rate");
 			if(validrate==="" || validrate===null || validrate==="undefined" || typeof(validrate)==="undefined"){
 				document.getElementById("errormsg").innerText="";
 				document.getElementById("errormsg").innerText="Please Process";
 				return 0;
 			}	
 		}
		
		var rows = $("#totalgrid").jqxGrid('getrows');
		//alert(rows);
		if(rows[0].rentaltype=="undefined" || rows[0].rentaltype==""){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Please Process";
			return 0;	
		}
    	$('#gridlength').val(rows.length);
    		//alert($('#gridlength').val());
    		for(var i=0 ; i < rows.length ; i++){
			//	var myvar = rows[i].tarif; 
				newTextBox = $(document.createElement("input"))
			    .attr("type", "dil")
			    .attr("id", "test"+i)
			    .attr("name", "test"+i)
			    .attr("hidden", "true");
			
				newTextBox.val(rows[i].rentaltype+"::"+rows[i].rate+"::"+rows[i].cdw+"::"+rows[i].pai+"::"+rows[i].cdw1+"::"+rows[i].pai1+"::"+rows[i].gps+"::"+rows[i].babyseater+"::"+rows[i].cooler+"::"+rows[i].exkmrte+"::"+rows[i].exhrchg+"::"+rows[i].chaufchg);
			
			newTextBox.appendTo('form');
			
				//alert("ddddd"+$("#test"+i).val());
			}
    		var rowscalc = $("#calculationgrid").jqxGrid('getrows');
    		//alert(rows);
    		if(rowscalc.length>0){
			if(rowscalc[0].description=="undefined" || rowscalc[0].description==""){
    			document.getElementById("errormsg").innerText="";
    			document.getElementById("errormsg").innerText="Please Calculate";
    			return 0;
    			
    		}
			}
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
        	
        	document.getElementById("errormsg").innerText="";
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
		 $('#tarifreferencegrid').jqxGrid({ disabled: false});
		  $('#totalgrid').jqxGrid({ disabled: false});
		   $('#trafficGrid').jqxGrid({ disabled:false});
		   $('#tarifagmtgrid').jqxGrid({ disabled: false});
		    $('#calculationgrid').jqxGrid({ disabled: false});
		    if(document.getElementById("mode").value=='A'){
		    	 $('#tarifreferencegrid').jqxGrid('clear');
		    	 $("#tarifreferencegrid").jqxGrid("addrow", null, {});
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
				  resetvalues();
				  $('#closedate').jqxDateTimeInput('setDate',new Date());
				  $('#lblchkorgregcard').hide();
					$('#chkorgregcardcollect').hide();
					$('#description').css('width','99%');
					if($('#hidchkorgregcard').val()=='1'){
						$('#description').css('width','70%');
						$('#lblchkorgregcard').show();
						$('#chkorgregcardcollect').show();
					}
					
					getDeliveryDriverConfig();
		    }
			if(document.getElementById("brchName").value!=""){
				getAgmtLocation();
			}
			if(document.getElementById("mode").value!="A"){
				document.getElementById("btnprocess").disabled=true;
				document.getElementById("btncalculate").disabled=true;
			}
		    setCollection();
		     getPriorClose();
	}
	function funChkButton(){
		
	}
	  function isNumber(evt,id) {
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
	//Mandatory Validation for calculation starts here
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
		
		var intimestatus=checkfuturetime($('#indate').jqxDateTimeInput('getDate'),$('#intime').jqxDateTimeInput('getDate'));
    	if(intimestatus){
    		document.getElementById("errormsg").innerText="";
    			
    	}
    	else{
    		$('#intime').jqxDateTimeInput('focus');
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
			
			var collecttimestatus=checkfuturetime($('#collectdate').jqxDateTimeInput('getDate'),$('#collecttime').jqxDateTimeInput('getDate'));
	    	if(collecttimestatus){
	    		document.getElementById("errormsg").innerText="";
	    			
	    	}
	    	else{
	    		$('#collecttime').jqxDateTimeInput('focus');
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
		
		
		//Mandatory validations ends here.
		document.getElementById("errormsg").innerText="";
		checkFuel();
		
		 
		
	}
	
	function checkFuel(){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				
				if(parseInt(items)==1){
					
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="Please Configure Valid Fuel Rate";
					
					
					return false;
				}
				else{
					
					checkAgmtDelivery();//Calling Ajax Method for calculation	
				}
				
		}
	}
		x.open("GET", "checkFuel.jsp?indate="+$('#indate').jqxDateTimeInput('val'), true);
		x.send();
	}
	function funProcess(){
		//Method for calculation and displaying the data in the Total grid// 
		if(document.getElementById("errormsg").innerText!=""){
			return false;
		}
		var useddays=document.getElementById("useddays").value;
		var usedhours=document.getElementById("usedhours").value;
		var totalkm=document.getElementById("totalkm").value;
		var excesskm=document.getElementById("excesskm").value;
		var agmtno=document.getElementById("agreementno").value;
		var rentaltype=$('#tarifagmtgrid').jqxGrid('getcellvalue', 0, "rentaltype");
		var agmtdate=$('#datehidden').jqxDateTimeInput('getText');
		var closedate=$('#closedatehidden').jqxDateTimeInput('getText');
		var closeinvdate=$('#closeinvdate').jqxDateTimeInput('val');
		$('#totaldiv').load("totalGrid.jsp?useddays="+useddays+"&usedhours="+usedhours+"&totalkm="+totalkm+"&excesskm="+excesskm+"&agmtno="+agmtno+"&rentaltype="+rentaltype+"&agmtdate="+agmtdate+"&closedate="+closedate+"&temp=1&closecalflag="+$('#closecalflag').val()+"&closeinvdate="+closeinvdate);
	/* } */
	}
	
	 function checkAgmtDelivery(){
		 //Ajax Method for date,time,km,fuel Calculation 
		
		 var coldate=null;
		 var coltime="";
		 var colkm=0.0,colfuel=0.0;
		 document.getElementById("hidchkcollection").value="0";
		 if(document.getElementById("chkcollection").checked==true){
			 document.getElementById("hidchkcollection").value="1";
			 colkm=document.getElementById("collectkm").value;
			 colfuel=document.getElementById("cmbcollectfuel").value;
			 coltime=$('#collecttime').jqxDateTimeInput('getText');
			 coldate=$('#collectdate').jqxDateTimeInput('getText');
		 }
		 var temprentaltype= $("#tarifagmtgrid").jqxGrid("getcellvalue",0,"rentaltype");
		 //alert("Inside checkAgmtDelivery");
		 var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
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
					document.getElementById("errormsg").innerText="In Km cannot be less than Collection Km";
					return false;
				}
				if(items[12].trim()=='1'){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="Agreement Delivery is not Completed";
					return false;
				}
				if(items[9].trim()=='1'){
					
					 $.messager.alert('Warning','Invoice has been done till '+items[10].trim());
					
				}
				if(items[13].trim()=='1'){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="Invoice's are Pending";
					return false;
				}
				if(items[17].trim()!='1'){
					document.getElementById("lblinvoicedone").innerText="Invoice has been done till "+items[10].trim();	
				}
				if(items[18].trim()=='1'){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="Vehicle In Date cannot be less than last out date";
					return false;
				}
				
				
				document.getElementById("errormsg").innerText="";
				//alert("finish");
				document.getElementById("fuel2").value=items[19].trim();
				document.getElementById("delcheckstatus").value=items[12].trim();
				document.getElementById("useddays").value=items[0];
				document.getElementById("usedhours").value=items[1];
				document.getElementById("totalkm").value=items[2];
				document.getElementById("totalfuel").value=items[3];
				document.getElementById("agmtkm").value=items[4];
				$("#datehidden").jqxDateTimeInput('val',items[8].trim());
				$("#closedatehidden").jqxDateTimeInput('val',items[14].trim());
				document.getElementById("closecalflag").value=items[15].trim();
				$("#closeinvdate").jqxDateTimeInput('val',items[16].trim());
				/* if(document.getElementById("delcheckstatus").value=="1"){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="Agreement Delivery is not Completed";
					return false;
				} */
				funProcess();
			//alert(items[0]+"====="+items[1]+"====="+items[2]+"======"+items[3]);
			/* return "2"; */
		}
	}
		x.open("GET", "checkDeliverykm.jsp?delstatus="+document.getElementById("delstatus").value+"&agmtno="+document.getElementById("agreementno").value+"&collectkm="+colkm+"&inkm="+document.getElementById("inkm").value+"&indate="+$('#indate').jqxDateTimeInput('getText')+"&infuel="+document.getElementById("cmbinfuel").value+"&collectfuel="+colfuel+"&intime="+$('#intime').jqxDateTimeInput('getText')+"&collecttime="+coltime+"&collectdate="+coldate+"&hidchkcollection="+document.getElementById("hidchkcollection").value+"&rentaltype="+temprentaltype, true);
		x.send();
	 }
	function funCalculate(){
		//Method for calculating and displaying final amount and data in the Calculation grid
		if(document.getElementById("agreementno").value==''){
			document.getElementById("errormsg").innerText="Please Enter Necessary Details";
			return false;
		}
		var temp=$('#totalgrid').jqxGrid('getcellvalue', 0, "rate");
		//alert(temp);
		 if((temp=='undefined')||(temp==null)){
			//alert(temp);
			document.getElementById("errormsg").innerText="Please process again, total is not calculated";
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
		var agmtdate=$('#datehidden').jqxDateTimeInput('getText');
		var closedate=$('#closedatehidden').jqxDateTimeInput('getText');
		var closeinvdate=$('#closeinvdate').jqxDateTimeInput('val');
		var calctype=document.getElementById("calctype").value;
		var useddays=document.getElementById("useddays").value;
		//alert("===="+agmtno+":"+tarif+":"+cdwtotal+":"+":"+acc+":"+chauffer+":"+excesskmchg+":"+excesshrchg+"===");
	$('#calcdiv').load("calculationGrid.jsp?agmtno="+agmtno+"&tarif="+tarif+"&cdwtotal="+cdwtotal+"&acctotal="+acc+"&chauffer="+chauffer+"&excesskmchg="+excesskmchg+"&excesshrchg="+excesshrchg+"&temp=1&usedhours="+document.getElementById("usedhours").value+"&clientid="+clientid+"&fuel="+fuel+"&deliverychg="+document.getElementById("deliverychg").value+"&collectchg="+document.getElementById("collectchg").value+"&outdate="+agmtdate+"&indate="+closedate+"&cmbinfuel="+document.getElementById("fuel2").value+"&exkm="+document.getElementById("excesskm").value+"&closeinvdate="+closeinvdate+"&closecalflag="+$('#closecalflag').val()+"&calctype="+calctype+"&useddays="+useddays);
	}
	
	function checkCollection(){
		if(document.getElementById("hidchkcollection").value=="1"){
			document.getElementById("chkcollection").checked=true;
			document.getElementById("chauffer").disabled=false;
			document.getElementById("collectchg").disabled=false;
			document.getElementById("collectkm").disabled=false;
			document.getElementById("cmbcollectfuel").disabled=false;
			$('#collectdate').jqxDateTimeInput({ disabled: false});
			$('#collecttime').jqxDateTimeInput({ disabled: false});
		}
		else{
			document.getElementById("chkcollection").checked=false;
			document.getElementById("chauffer").disabled=true;
			document.getElementById("collectchg").disabled=true;
			document.getElementById("collectkm").disabled=true;
			document.getElementById("cmbcollectfuel").disabled=true;
			$('#collectdate').jqxDateTimeInput({ disabled: true});
			$('#collecttime').jqxDateTimeInput({ disabled: true});
		}
	}
	function setValues(){
		 //document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		// checkCollection();
		if(document.getElementById("mode").value!="A"){
			document.getElementById("btnprocess").disabled=true;
			document.getElementById("btncalculate").disabled=true;
		}
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
			
		
			if((document.getElementById("agreementno").value!='')&&(document.getElementById("docno").value!='')){

				$("#agmttarifdiv").load("agreementTarifGrid.jsp?agmt="+document.getElementById("agreementno").value);
				$('#totaldiv').load("totalGrid.jsp?agmtno="+document.getElementById("agreementno").value+"&temp=2");
				$("#trafficdiv").load("trafficGrid.jsp?id="+document.getElementById("agreementno").value);
				$('#calcdiv').load("calculationGrid.jsp?agmtno="+document.getElementById("agreementno").value+"&temp=2");
				$('#referencetarifdiv').load("referenceTarifGrid.jsp?id="+document.getElementById("agreementno").value);
			}
			
			if(document.getElementById("allbranch").value=="1"){
				$("#btnDelete").attr('disabled', true );
			}
		if($('#hidchkorgregcardcollect').val()=='1'){
			document.getElementById("chkorgregcardcollect").checked=true;
		}
		else{
			document.getElementById("chkorgregcardcollect").checked=false;
		}
}
	//Master Document Search
	function funSearchLoad(){
		changeContent('masterSearch.jsp', $('#window'));
	}
	
			function getReplace(){
				//Function for Displaying Replaced Vehicle in the Agreement
				 $('#agmtnowindow').jqxWindow('open');
					$('#agmtnowindow').jqxWindow('focus');
					 agmtnoSearchContent('vehReplaceGrid.jsp?docno='+document.getElementById("agreementno").value, $('#agmtnowindow'));
			}
			function funPrintBtn() {
				//Function for Print the Agreement
		    	if(document.getElementById("docno").value=='' || document.getElementById("docno").value=='0'){
		    		 $.messager.alert('Warning','Select a Document');
		    		 return false;
		    	}
		    	var url=document.URL;
		    	  var reurl=url.split("saveRentalClose");
		    	    	var win= window.open(reurl[0]+"printRentalClose?docno="+document.getElementById("agreementno").value+"&formdetailcode=RAC","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
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
				document.getElementById("lblinvoicedone").innerText="";
				$('#cmbinfuel').val('');
				$('#tarifreferencegrid').jqxGrid('clear');
		    	 $("#tarifreferencegrid").jqxGrid("addrow", null, {});
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
				x.open("GET", "getLocation.jsp?branch="+value, true);
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
				x.open("GET", "getTestLocation.jsp", true);
				x.send();
			}
			
			
			
			
			function checkfuturetime(date,time){
		 		var date1=new Date(date);
		 		var time1=new Date(time);
		 		var currentdate = new Date(); 
		 		var currenthours=currentdate.getHours();
		 		var currentminutes=currentdate.getMinutes();
		 		var time1hours=time1.getHours();
		 		var time1minutes=time1.getMinutes();
		 		date1.setHours(0,0,0,0);
		 		currentdate.setHours(0,0,0,0);
		 		if(date1-currentdate==0){
		 			if(time1hours>currenthours){
		 				document.getElementById("errormsg").innerText="";
		 				document.getElementById("errormsg").innerText="Future Time Not Allowed";
		 				return false;
		 			}
		 			else if(time1hours==currenthours){
		 				if(time1minutes>currentminutes){
		 					document.getElementById("errormsg").innerText="";
		 					document.getElementById("errormsg").innerText="Future Time Not Allowed";
		 					return false;
		 				}
		 			}
		 		}
		 		return true;
		 	}
			
			
			function setOrgRegCollect(){
				if($('#mode').val()=='A'){
					if(document.getElementById("chkorgregcardcollect").checked==true){
						document.getElementById("hidchkorgregcardcollect").value="1";
					}
					else{
						document.getElementById("hidchkorgregcardcollect").value="0";
					}
				}
			}
			
			function getDeliveryDriverConfig(){
	         	var x = new XMLHttpRequest();
	         	x.onreadystatechange = function() {
	         		if (x.readyState == 4 && x.status == 200) {
	         			var items = x.responseText.trim().split("::");
	         			/* $('#deliverydriverconfig').val(items[0].trim());
	         			$('#invruleoverride').val(items[1].trim()); */
	         			//if($('#deliverydriverconfig').val()=="0"){
	         				$('#rentalagent').val(items[3].trim());
	             			$('#hidrentalagent').val(items[2].trim());
	         			//}
	         			
	         		} else {
	         			}
	         		}
	         		x.open("GET", "<%=contextPath%>/com/operations/agreement/rentalagreement/getDeliveryDriverConfig.jsp", true);
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
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmRentalClose" action="saveRentalClose" autocomplete="off">
	<%-- <script>
			window.parent.formName.value="Rental Agreement Close";
			window.parent.formCode.value="RAC";
	</script> --%>
	<jsp:include page="../../../../header.jsp" />
	<br/> 
<div class="modern-ui hidden-scrollbar">

<!-- ================= AGREEMENT ================= -->
<div class="modern-panel">
<span class="modern-panel-title">Agreement</span>

<div style="position:absolute; top:-12px; right:15px;">
<div id='jqxMenuMore' style='visibility:hidden;'>
<ul>
<li><a href="#trafficFines" onclick="fine();">Traffic Fines</a></li>
<li><a href="#documents" onclick="replacement();">Replacement</a></li>
<li><a href="#history" onclick="account();">Account Statement</a></li>
<li><a href="#close" onclick="closing();">Closing Summary</a></li>
</ul>
</div>
</div>

<div class="top-details-grid">

<label class="lbl-right">Branch</label>
<select name="cmbagmtbranch" id="cmbagmtbranch">
<option value="">--Select--</option>
</select>

<label class="lbl-right">Agmt No</label>
<input type="text" name="vocno" id="vocno" value='<s:property value="vocno"/>' onkeydown="getAgmt(event);" placeholder="Press F3 to Search">

<label class="lbl-right">Vehicle</label>
<input type="text" name="vehicle" id="vehicle" value='<s:property value="vehicle"/>'>

<label class="lbl-right">Doc No</label>
<input type="text" name="voucherno" id="voucherno" value='<s:property value="voucherno"/>' readonly>

<label class="lbl-right">Client</label>
<input type="text" name="clientid" id="clientid" value='<s:property value="clientid"/>'>

<label class="lbl-right">Client Name</label>
<input type="text" name="client" id="client" value='<s:property value="client"/>'>

<label class="lbl-right">Date</label>
<div id="closedate"></div>

<label class="lbl-right">Description</label>
<input type="text" name="description" id="description" value='<s:property value="description"/>'>

<label class="lbl-right">Location</label>
<select name="cmbcloseloc" id="cmbcloseloc">
<option value="">--Select--</option>
</select>

</div>

<input type="hidden" name="txtaccno" id="txtaccno">
<input type="hidden" name="hidclosedate" id="hidclosedate">
<input type="hidden" name="hidcmbagmtbranch" id="hidcmbagmtbranch">
<input type="hidden" name="hidcmbcloseloc" id="hidcmbcloseloc">

</div>


<!-- ================= VEHICLE INFO ================= -->
<div class="modern-panel">
<span class="modern-panel-title">Vehicle and Collection Info</span>

<div style="display:flex; gap:20px;">

<!-- LEFT -->
<div style="width:20%; display:flex; flex-direction:column; gap:10px;">
<div class="chk-container">
<label>Collection</label>
<input type="checkbox" name="chkcollection" id="chkcollection" onchange="setCollection();">
</div>

<input type="text" name="chauffer" id="chauffer" value='<s:property value="chauffer"/>' readonly onkeydown="getChauffer(event);" placeholder="Press F3 to Search">

<input type="text" name="collectchg" id="collectchg" value='<s:property value="collectchg"/>' placeholder="Collection Charge">

<input type="hidden" name="hidchkcollection" id="hidchkcollection">
</div>

<!-- RIGHT -->
<div style="flex:1; display:flex; flex-direction:column; gap:10px;">

<div style="display:grid; grid-template-columns:120px 1fr 120px 1fr 120px 1fr 120px 1fr; gap:10px;">
<label class="lbl-right">Collection KM</label>
<input type="text" name="collectkm" id="collectkm" value='<s:property value="collectkm"/>'>

<label class="lbl-right">Fuel</label>
<select name="cmbcollectfuel" id="cmbcollectfuel"></select>

<label class="lbl-right">Date</label>
<div id="collectdate"></div>

<label class="lbl-right">Time</label>
<div id="collecttime"></div>
</div>

<div style="display:grid; grid-template-columns:120px 1fr 120px 1fr 120px 1fr 120px 1fr; gap:10px;">
<label class="lbl-right">In KM</label>
<input type="text" name="inkm" id="inkm" value='<s:property value="inkm"/>'>

<label class="lbl-right">Fuel</label>
<select name="cmbinfuel" id="cmbinfuel"></select>

<label class="lbl-right">Date</label>
<div id="indate"></div>

<label class="lbl-right">Time</label>
<div id="intime"></div>
</div>

<div style="display:grid; grid-template-columns:120px 1fr 120px 1fr 120px 1fr auto; gap:10px;">
<label class="lbl-right">Rental Agent</label>
<input type="text" name="rentalagent" id="rentalagent" value='<s:property value="rentalagent"/>' readonly onkeydown="getRentalAgent(event);">

<label class="lbl-right">Check In</label>
<input type="text" name="checkin" id="checkin" value='<s:property value="checkin"/>' readonly onkeydown="getCheckin(event);">

<label class="lbl-right">Total KM</label>
<input type="text" name="totalkm" id="totalkm" value='<s:property value="totalkm"/>' readonly>

<input type="button" class="myButton" value="Process" onclick="funChecking();">
</div>

</div>
</div>

<input type="hidden" name="hidrentalagent" id="hidrentalagent">
<input type="hidden" name="hidcheckin" id="hidcheckin">
<input type="hidden" name="hidcmbrentalagent" id="hidcmbrentalagent">

</div>


<!-- ================= LOWER ================= -->
<div style="display:flex; gap:15px;">

<div style="flex:2; display:flex; flex-direction:column; gap:15px;">
<div class="modern-panel"><div id="agmttarifdiv"><jsp:include page="agreementTarifGrid.jsp"></jsp:include></div></div>
<div class="modern-panel"><div id="referencetarifdiv"><jsp:include page="referenceTarifGrid.jsp"></jsp:include></div></div>
<div class="modern-panel"><div id="totaldiv"><jsp:include page="totalGrid.jsp"></jsp:include></div></div>
<div class="modern-panel"><div id="trafficdiv"><jsp:include page="trafficGrid.jsp"></jsp:include></div></div>
</div>

<div style="flex:1.1; display:flex; flex-direction:column;">
<div style="display:flex; justify-content:center; gap:10px; margin-bottom:10px;">
<label id="lblinvoicedone" style="color:red; font-weight:bold;"></label>
<input type="button" class="myButton" value="Calculate" onclick="funCalculate();">
<input type="button" class="myButton" value="Download" onclick="funDownload();">
</div>

<div class="modern-panel" style="flex:1;">
<span class="modern-panel-title">Calculation Info</span>
<div id="calcdiv"><jsp:include page="calculationGrid.jsp"></jsp:include></div>
<input type="hidden" name="hidchkconvert" id="hidchkconvert">
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
<div id="closedatehidden" name="closedatehidden" hidden="true"></div>
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
<input type="hidden" name="tempuseddays" id="tempuseddays" value='<s:property value="tempuseddays"/>' >
<input type="hidden" name="delcheckstatus" id="delcheckstatus" value='<s:property value="delcheckstatus"/>' >
<input type="hidden" name="fuelstatus" id="fuelstatus" value='<s:property value="fuelstatus"/>' >
<input type="hidden" name="closecalflag" id="closecalflag" value='<s:property value="closecalflag"/>' >
<input type="hidden" name="calctype" id="calctype" value='<s:property value="calctype"/>' >
<div name="closeinvdate" id="closeinvdate" value='<s:property value="closeinvdate"/>' hidden="true"></div>
<input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>' readonly>
<input type="hidden" name="fuel2" id="fuel2" value='<s:property value="fuel2"/>' >
<input type="hidden" name="agreementno" id="agreementno" value='<s:property value="agreementno"/>' onkeydown="getAgmt(event);" placeholder="Press F3 to Search"  >
<input type="hidden" name="allbranch" id="allbranch" value='<s:property value="allbranch"/>' >
<input type="hidden" name="priormethod" id="priormethod">
<input type="hidden" name="priorvalue" id="priorvalue">
<input type="hidden" name="defaultdate" id="defaultdate">
<input type="hidden" name="invtype" id="invtype">
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
</div>
</body>
</html>