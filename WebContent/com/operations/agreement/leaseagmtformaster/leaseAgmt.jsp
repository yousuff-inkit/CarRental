<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i) - Lease Agreement</title>

<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
   MODERN ERP LAYOUT - EXACT ALIGNMENT & FULL WIDTH GRID 
========================================================= */
body {
    background: #f4f6f9;
    font-family: Arial, sans-serif;
    color: #333;
    font-size: 12px;
    margin: 0;
    padding: 10px;
    box-sizing: border-box;
}

#mainBG {
    background: #fff;
    border-radius: 4px;
    padding: 15px;
    max-width: 100%;
    margin: auto;
    box-shadow: 0 1px 4px rgba(0,0,0,0.1);
    box-sizing: border-box;
}

/* Master Input Heights - Set to 24px */
input[type="text"], select {
    height: 24px !important;
    border: 1px solid #ccc;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box;
    width: 100%;
    background-color: #fff;
    color: #333;
}

input[type="text"]:focus, select:focus {
    border-color: #007bff;
    outline: none;
}

/* Clean Panels */
fieldset {
    border: 1px solid #e1e4e8;
    background-color: #fff;
    margin-bottom: 10px;
    padding: 12px 10px 10px 10px;
    border-radius: 4px;
}

legend {
    font-size: 13px;
    font-weight: bold;
    color: #0056b3;
    padding: 0 0 0 6px;
    border-left: 3px solid #0056b3;
    margin-bottom: 5px;
}

.icon {
	width: 2.5em;
	height: 2em;
	border: none;
	background-color: #E0ECF8;
    cursor: pointer;
}

/* Date/Time Overrides */
#date, #dateout, #deldateout { width: 120px !important; }
#timeout, #deltimeout { width: 90px !important; }

/* Hide Scrollbar Fix */
html, body {
    height: auto !important;
    min-height: 100%;
    overflow-y: auto !important;
    overflow-x: hidden;
}

.hidden-scrollbar {
    height: auto; 
    overflow: visible; 
    padding-bottom: 120px; 
}

/* Error Msg */
#errormsg {
    white-space: nowrap !important;
    display: inline-block !important;
    color: #e74c3c !important;
    font-weight: bold;
    font-size: 13px;
    padding: 6px 12px;
    margin-right: 30px !important;
    background-color: #fdf2f2;
    border: 1px solid #f5c6cb;
    border-radius: 4px;
    z-index: 50;
}

/* Accordion Styles */
.accordion-header {
    cursor: pointer;
    padding: 10px 12px;
    background: #f0f3f5;
    border-radius: 6px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 6px;
    margin-top: 10px;
}

.accordion-left {
    display: flex;
    align-items: center;
    gap: 10px;
}

.accordion-number {
    width: 22px;
    height: 22px;
    border-radius: 50%;
    background: #2f6db3;
    color: #fff;
    font-size: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
}

.accordion-title {
    font-weight: 600;
    color: #333;
}

.accordion-arrow {
    width: 0;
    height: 0;
    border-left: 5px solid transparent;
    border-right: 5px solid transparent;
    border-top: 6px solid #333;
    transition: transform 0.2s ease;
}

.accordion-header.active .accordion-arrow {
    transform: rotate(-180deg);
}

.jqx-safe-hide {
    height: 0px !important;
    overflow: hidden !important;
    padding-top: 0 !important;
    padding-bottom: 0 !important;
    margin-top: 0 !important;
    margin-bottom: 0 !important;
    border: none !important;
    display: block !important;
    opacity: 0;
}
</style>

<script type="text/javascript">
$(document).ready(function () {
	
	  /* create jqxMenu */
     $("#jqxMenuMore").jqxMenu({ width: '100%', height: '26px', autoSizeMainItems: true});
    $("#jqxMenuMore").jqxMenu('minimize');            
    $("#jqxMenuMore").css('visibility', 'visible');     
     
   /* Menu-minimized window  */
     $('#windows2').jqxWindow({width: '71%', height: '70%',  maxHeight: '70%' ,maxWidth: '80%' , title: 'Details',position: { x: 180, y: 60 } , theme: 'energyblue', showCloseButton: true,keyboardCloseKey: 27});
	$('#windows2').jqxWindow('close');   
	
	getLeasePrior();

$("#date").jqxDateTimeInput({ width: '120px', height: '15px',formatString:"dd.MM.yyyy"});
$("#dateout").jqxDateTimeInput({ width: '120px', height: '15px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection: true,value:null});
$("#deldateout").jqxDateTimeInput({ width: '120px', height: '15px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection: true,value:null});
$("#timeout").jqxDateTimeInput({ width: '90px', height: '17px', formatString: 'HH:mm', showCalendarButton: false ,value:null});
$("#deltimeout").jqxDateTimeInput({ width: '90px', height: '17px', formatString: 'HH:mm', showCalendarButton: false,value:null });

$('#clientinfowindow').jqxWindow({ width: '62%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Client Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#clientinfowindow').jqxWindow('close');
$('#driverinfowindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '62%' ,maxWidth: '50%' , title: 'Driver Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#driverinfowindow').jqxWindow('close');
$('#chauffeurinfowindow').jqxWindow({ width: '30%', height: '58%',  maxHeight: '62%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#chauffeurinfowindow').jqxWindow('close');
$('#vehinfowindow').jqxWindow({ width: '60%', height: '67%',  maxHeight: '70%' ,maxWidth: '70%' , title: ' Fleet Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#vehinfowindow').jqxWindow('close');
$('#deldrvwindow').jqxWindow({ width: '30%', height: '62%',  maxHeight: '54%' ,maxWidth: '50%' , title: 'Driver Search' ,position: { x: 650, y: 110 }, keyboardCloseKey: 27});
$('#deldrvwindow').jqxWindow('close');


$('#projectwindow').jqxWindow({ width: '30%', height: '62%',  maxHeight: '54%' ,maxWidth: '50%' , title: 'Project Search' ,position: { x: 800, y: 150 }, keyboardCloseKey: 27});
$('#projectwindow').jqxWindow('close');
$('#masterrefnowindow').jqxWindow({ width: '60%', height: '62%',  maxHeight: '54%' ,maxWidth: '60%' , title: 'Master Agreement Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#masterrefnowindow').jqxWindow('close');
$("#btnEdit").attr('disabled', true );

$('#clientid').dblclick(function(){
	    $('#clientinfowindow').jqxWindow('open');
      $('#clientinfowindow').jqxWindow('focus');
      clieninfoSearchContent('clientINgridsearch.jsp', $('#clientinfowindow'));
     });
     
$('#leaseproject').dblclick(function(){
    $('#projectwindow').jqxWindow('open');
  $('#projectwindow').jqxWindow('focus');
 projectinfoSearchContent('searchproject.jsp');
 });   
 $('#masterrefno').dblclick(function(){
	 var masterreftype=$('#cmbmasterreftype').val();
	 if(masterreftype=="MLA"){
		    $('#masterrefnowindow').jqxWindow('open');
		    $('#masterrefnowindow').jqxWindow('focus');
		   masterrefnoSearchContent('masterrefnoSearch.jsp');		 
	 }

 });  

     
$('#deldrvname').dblclick(function(){
    $('#deldrvwindow').jqxWindow('open');
  $('#deldrvwindow').jqxWindow('focus');
  drvdelSearchContent('Searchdeldriver.jsp?', $('#deldrvwindow'));  
 });  
     
$('#ladriverlist').dblclick(function(){
    $('#chauffeurinfowindow').jqxWindow('open');
  $('#chauffeurinfowindow').jqxWindow('focus');
  chauffeurSearchContent('SearchChauffeur.jsp', $('#chauffeurinfowindow'));
 });

$('#permanentfleet').dblclick(function(){
	   $('#vehinfowindow').jqxWindow('open');
  $('#vehinfowindow').jqxWindow('focus');
  vehinfoSearchContent('vehinfo.jsp', $('#vehinfowindow'));
 }); 

$('#tempfleet').dblclick(function(){
    $('#vehinfowindow').jqxWindow('open');
  $('#vehinfowindow').jqxWindow('focus');
  vehinfoSearchContent('vehinfotemp.jsp', $('#vehinfowindow'));
 }); 
     
$('#date').on('change', function (event) {
    var maindate = $('#date').jqxDateTimeInput('getDate');
  	 if ($("#mode").val() == "A") {   
    funDateInPeriod(maindate);
  	 }
   });
$('#dateout').on('change', function (event) {
    var dateout = $('#dateout').jqxDateTimeInput('getDate');
	 if ($("#mode").val() == "ADD") {  
    funDateInPeriod(dateout);
    if($('#timeout').jqxDateTimeInput('getDate')!=null){
		   var intime=new Date($('#timeout').jqxDateTimeInput('getDate'));
		   var indate=new Date($('#dateout').jqxDateTimeInput('getDate'));
		   var status=checkPriorTime(intime,indate);
		   if(status){
			   document.getElementById("errormsg").innerText="";
			   return true;
		   }
		   else{
			   $('#timeout').jqxDateTimeInput('focus');
			   return false;
		   }
	   }
	 }
   });
     
$('#deldateout').on('change', function (event) {
	 if ($("#mode").val() == "DLY") {  
	   var indate1=new Date($('#dateout').jqxDateTimeInput('getDate')); 
	  var agmtdate1=new Date($('#deldateout').jqxDateTimeInput('getDate'));
	  indate1.setHours(0,0,0,0);
	  agmtdate1.setHours(0,0,0,0);
	   if(indate1>agmtdate1){
	   document.getElementById("errormsg").innerText="Delivery Date Cannot be Less than Out Date";
	   return false;
	  } else{
	   document.getElementById("errormsg").innerText="";  
	   }
	 }
    });

$('#deltimeout').on('change', function (event) {
	 if ($("#mode").val() == "DLY") {  
		 $('#dateout').jqxDateTimeInput({ disabled: false}); 
		 $('#timeout').jqxDateTimeInput({ disabled: false}); 
		 
	  var indate1=new Date($('#dateout').jqxDateTimeInput('getDate'));     
	  var agmtdate1=new Date($('#deldateout').jqxDateTimeInput('getDate')); 
	  var intime1=new Date($('#timeout').jqxDateTimeInput('getDate'));  
	  var agmttime1=new Date($('#deltimeout').jqxDateTimeInput('getDate')); 
	 
	  indate1.setHours(0,0,0,0);
	  agmtdate1.setHours(0,0,0,0);
	  
	   if(indate1>agmtdate1){
	   document.getElementById("errormsg").innerText="Delivery Date Cannot be Less than Out Date";
		 $('#dateout').jqxDateTimeInput({ disabled: true}); 
		 $('#timeout').jqxDateTimeInput({ disabled: true}); 
	   return false;
	  }   
	
	   if(indate1.valueOf()==agmtdate1.valueOf()){
	  var out=intime1.getHours();
	  var del=agmttime1.getHours();
	  if(out > del){
	    document.getElementById("errormsg").innerText="Delivery Time Cannot be Less than Out Time";
		 $('#dateout').jqxDateTimeInput({ disabled: true}); 
		 $('#timeout').jqxDateTimeInput({ disabled: true}); 
	    return false;
	   }
	   if(out==del){
	    if(intime1.getMinutes()>agmttime1.getMinutes()){
	     document.getElementById("errormsg").innerText="Delivery Time Cannot be Less than Out Time";
		 $('#dateout').jqxDateTimeInput({ disabled: true}); 
		 $('#timeout').jqxDateTimeInput({ disabled: true}); 
	     return false;
	    }
	   }
	  }
		 $('#dateout').jqxDateTimeInput({ disabled: true}); 
		 $('#timeout').jqxDateTimeInput({ disabled: true}); 
	   document.getElementById("errormsg").innerText="";  
	 }
    });
  
  $('#timeout').on('change', function (event) {
	if($('#timeout').jqxDateTimeInput('getDate')!=null){
		   var intime=new Date($('#timeout').jqxDateTimeInput('getDate'));
		   var indate=new Date($('#dateout').jqxDateTimeInput('getDate'));
		   var status=checkPriorTime(intime,indate);
		   if(status){
			   document.getElementById("errormsg").innerText="";
			   return true;
		   }
		   else{
			   $('#timeout').jqxDateTimeInput('focus');
			   return false;
		   }
	   }
});
});

function getConfigs(){
	$.get('getConfigs.jsp',function(data){
		data=JSON.parse(data);
		var htmldata='';
		if(data.InvQuarterly=="1"){
			$('#invoice').append($('<option></option>').val("4").text("Quarterly"));
			$('#invoice').append($('<option></option>').val("5").text("Half Yearly"));
			$('#invoice').append($('<option></option>').val("6").text("Yearly"));
			if($('#hidinvoice').val()!="")
			{
				$('#invoice').val($('#hidinvoice').val());
			}
		}
		
		htmldata='<option value="">--Select--</option>';
		$.each(data.enqtypedata,function(index,value){
			htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
		});
 		$('#cmbenqtype').html($.parseHTML(htmldata));
 		if($('#hidcmbenqtype').val()!=''){
 			$('#cmbenqtype').val($('#hidcmbenqtype').val());
 		}
	});
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
			 document.getElementById("errormsg").innerText="Prior Opening time is "+priorhours+" hours";
			 return false;
		 }
		 else{
			 return true;
		 }
	 }
}

function getLeasePrior(){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();
			items = items.split('***');
			document.getElementById("priormethod").value=items[0];
			document.getElementById("priorvalue").value=items[1];
			} else {
			}
		}
		x.open("GET", "../getLeasePriorCreate.jsp", true);
		x.send();
 }
function  funReadOnly(){
	$("#jqxMenuMore").css('visibility', 'visible');  
	$('#docno').attr('disabled', true);
	$('#date').jqxDateTimeInput({ disabled: true});
	$('#dateout').jqxDateTimeInput({ disabled: true});
	$('#deldateout').jqxDateTimeInput({ disabled: true});
	$('#frmLeaseAgreementForMaster input').attr('disabled', true );
	$('#frmLeaseAgreementForMaster textarea').attr('disabled', true );
	$('#frmLeaseAgreementForMaster select').attr('disabled', true);
	$('#nwevehgrid').jqxGrid({ disabled: true}); 
	$('#rateGrid').jqxGrid({ disabled: true});
	$('#ladriverlist').attr('readonly', true);
	$('#adidrvcharges').attr('readonly', true);
	$('#btnupdate').attr('disabled', false);
	$('#leaseprintbtn').attr('disabled', false);
	
	if($('#delchkvalue').val()==1)
	  {
	$('#btndelupdate').attr('disabled', false);
	  }
	else
		{
		$('#btndelupdate').attr('disabled', true);
		}
	 $("#jqxgrid2").jqxGrid({ disabled: true});
	 $("#jqxgridpayment").jqxGrid({ disabled: true});
	 document.getElementById("btndelupdate").value="Edit";
	 document.getElementById("btnupdate").value="Edit";
	 $("#cleardata").hide();	
}

function btndisabled(){}

function change1(){ if(document.getElementById("m2").value!=""){ document.getElementById("m3").value=parseInt(document.getElementById("m2").value)+1; }else{ document.getElementById("m3").value=""; } }
function change2(){ if(document.getElementById("m4").value!=""){ document.getElementById("m5").value=parseInt(document.getElementById("m4").value)+1; }else{ document.getElementById("m5").value=""; } }
function change3(){ if(document.getElementById("m6").value!=""){ document.getElementById("m7").value=parseInt(document.getElementById("m6").value)+1; }else{ document.getElementById("m7").value=""; } }
function change4(){ if(document.getElementById("m8").value!=""){ document.getElementById("m9").value=parseInt(document.getElementById("m8").value)+1; }else{ document.getElementById("m9").value=""; } }

function getclientinfo(event){
    var x= event.keyCode;
    if(x==114){
     $('#clientinfowindow').jqxWindow('open');
     clieninfoSearchContent('clientINgridsearch.jsp');  	 
    }
}
function clieninfoSearchContent(url) { $.get(url).done(function (data) { $('#clientinfowindow').jqxWindow('setContent', data); }); }

function getproject(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#projectwindow').jqxWindow('open');
	  projectinfoSearchContent('searchproject.jsp'); 	 }
}
function projectinfoSearchContent(url) { $.get(url).done(function (data) { $('#projectwindow').jqxWindow('setContent', data); }); }

function getMasterRefno(event){
	 var x= event.keyCode;
	 if(x==114){
		 var masterreftype=$('#cmbmasterreftype').val();
		 if(masterreftype=="MLA"){
			    $('#masterrefnowindow').jqxWindow('open');
			    $('#masterrefnowindow').jqxWindow('focus');
			   masterrefnoSearchContent('masterrefnoSearch.jsp');		 
		 }
	  }
}	 
function masterrefnoSearchContent(url) { $.get(url).done(function (data) { $('#masterrefnowindow').jqxWindow('setContent', data); }); }

function funRemoveReadOnly(){
	 if ($("#mode").val() == "D") {
		 $('#docno').attr('disabled', false);
		 $('#clientid').attr('disabled', true);
		 $('#permanentfleet').attr('disabled', false);
		 $('#tempfleet').attr('disabled', false);
		var fleet_no=0;
		 var docnos=document.getElementById("masterdoc_no").value;
		 var clientid=document.getElementById("clientid").value;
				
			if($('#permanentfleet').val()==""){ fleet_no=document.getElementById("tempfleet").value; }
		else if($('#tempfleet').val()==""){ fleet_no=document.getElementById("permanentfleet").value; }
		 
				var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
					{
						var items=x.responseText;
				var chkfleet=items.trim();
						 if(parseInt(chkfleet)==1) {
							 $.messager.alert('Message',' Transaction Found Not Deleted ','warning'); 
							 $('#docno').attr('disabled', true);
							 $('#permanentfleet').attr('disabled', true);
							 $('#tempfleet').attr('disabled', true);
							 $("#mode").val("view");	
							  exit(); 
							  return 0;
						 } else {
							 $.messager.alert('Message','LA Is Successfully Deleted ','warning');  
							 $('#docno').attr('disabled', true);
							 $('#clientid').attr('disabled', true);
							 $('#permanentfleet').attr('disabled', true);
							 $('#tempfleet').attr('disabled', true);
							 $("#mode").val("D");	
							  exit(); 
							 return 0;	
						}
					}
				}
			x.open("GET","deletelease.jsp?valfleet="+fleet_no+"&docnos="+docnos+"&clientid="+clientid+"&branch="+$('#brchName').val(),true);
			x.send();
			exit(); 	
	}
	
	$('#frmLeaseAgreementForMaster input').attr('disabled', false );
	$('#frmLeaseAgreementForMaster textarea').attr('disabled', false );
	$('#frmLeaseAgreementForMaster select').attr('disabled', false);
	$('#date').jqxDateTimeInput({ disabled: false});
	$('#jqxgrid2').jqxGrid({ disabled: false});
	$('#jqxgridpayment').jqxGrid({ disabled: false});
	$('#rateGrid').jqxGrid({ disabled: false}); 
	$('#nwevehgrid').jqxGrid({ disabled: false}); 
	 
	$("#adidrvcharges").prop("disabled", true);
	$("#ladriverlist").prop("readonly", true);
    $("#ladriverlist").prop("disabled", true);
    $("#delkmout").attr("disabled", true);
    $('#adidrvcharges').attr('readonly', false);
    $("#cmbdelfuelout").attr("disabled", true);
    $('#deldateout').jqxDateTimeInput({ disabled: true});
    $('#deltimeout').jqxDateTimeInput({ disabled: true});
    $('#deltimeout').attr("disabled", true);
    $('#delkmout').attr("disabled", true);
    $('#cmbdelfuelout').attr("disabled", true);
    $('#vehdetailsupdate').attr('disabled', true);
    $('#delupdatefd').attr('disabled', true); 
	$('#btnupdate').attr('disabled', false);
	$('#btndelupdate').attr('disabled', false);
	$('#leaseprintbtn').attr('disabled', true);
	   
    $("#jqxgrid2").jqxGrid('clear');
    $("#jqxgrid2").jqxGrid('addrow', null, {});
    $("#jqxgrid2").jqxGrid('addrow', null, {});
	      
    $("#rateGrid").jqxGrid('clear');
    $("#rateGrid").jqxGrid('addrow', null, {});
		    
    $("#paymentdiv").load("paymentdetailsgrid.jsp?");
	      
    if($("#mode").val()=='A') {
	    $("#jqxMenuMore").css('visibility', 'hidden');   
	    $("#date").val(new Date);
	    $("#dateout").val("");
	    $("#timeout").val("");
	 	$("#deldateout").val(""); 
	 	$("#deltimeout").val("");
	 	$("#nwevehgrid").jqxGrid('clear');
	 	$("#nwevehgrid").jqxGrid('addrow', null, {});
        $("#nwevehgrid").jqxGrid('addrow', null, {});
        $("#nwevehgrid").jqxGrid('addrow', null, {});
        $("#nwevehgrid").jqxGrid('addrow', null, {});
        $("#nwevehgrid").jqxGrid('addrow', null, {});
	 	getDeliveryDriverConfig(); 
	}
	$("#cleardata").hide();	
}    

function menuContent(url) {
    $.get(url).done(function (data) {
        $('#windows2').jqxWindow('open');
        $('#windows2').jqxWindow('setContent', data);
        $('#windows2').jqxWindow('bringToFront');
    });
} 

function replacement(){
	if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
    $('#windows2').jqxWindow('open');
    menuContent('vehReplaceGrid.jsp?docnovals='+document.getElementById("masterdoc_no").value, $('#windows2')); 
	} else { $.messager.alert('Message','Select a Document....!','warning'); return false; } 
}

function fine(){
	if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	$('#windows2').jqxWindow('open');
    menuContent('trafficFines.jsp?docnovals='+document.getElementById("masterdoc_no").value, $('#windows2'));  
	} else { $.messager.alert('Message','Select a Document....!','warning'); return false; } 
}

function account(){ 
	if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	$('#windows2').jqxWindow('open');
    menuContent('accountsmainForm.jsp?docnovals='+document.getElementById("masterdoc_no").value, $('#windows2'));
	} else { $.messager.alert('Message','Select a Document....!','warning'); return false; } 
}

function closing(){
	if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	    var url=document.URL;
	    var reurl=url.split("saveLeaseAgreement");
	    $("#docno").prop("disabled", false);                
	    var win= window.open(reurl[0]+"printLAGClosingSummary?docno="+document.getElementById("masterdoc_no").value,"_blank","top=85,left=150,Width=1020,Height=600,location=no,scrollbars=no,toolbar=yes");
	    win.focus();
	} else { $.messager.alert('Message','Select a Document....!','warning'); return false; } 
}

function funKmDetails(){
  	if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	$('#windows2').jqxWindow('open');
    menuContent('kmdetails.jsp?docno='+document.getElementById("masterdoc_no").value+'&id=1', $('#windows2')); 
  	} else { $.messager.alert('Message','Select a Document....!','warning'); return false; }
}

function funFocus(){ document.getElementById("clientid").focus(); }

function driverinfoSearchContent(url) {
    $.get(url).done(function (data) {
        $('#driverinfowindow').jqxWindow('open');
        $('#driverinfowindow').jqxWindow('setContent', data);
    }); 
}
     	
function funaddidriverview(){
    if (document.getElementById('additional_driver').checked) {
        $("#adidrvcharges").prop("disabled", false);
        document.getElementById('adidrvcharges').value="";
        document.getElementById('add_drchk').value=1;
    } else {   
        $("#adidrvcharges").prop("disabled", true);
        document.getElementById('adidrvcharges').value="";
        document.getElementById('add_drchk').value=0;
    } 
}

function funShaffurdisable(){
    if (document.getElementById('ladrivercheck').checked) {
        $("#ladriverlist").prop("disabled", false);
        $("#jqxgrid2").jqxGrid('clear');
        $("#jqxgrid2").jqxGrid('addrow', null, {});
        $("#jqxgrid2").jqxGrid('addrow', null, {});
        $("#jqxgrid2").jqxGrid({ disabled: true});
        document.getElementById("errormsg").innerText="";	
   } else {
        $("#ladriverlist").prop("disabled", true);
        $("#jqxgrid2").jqxGrid({ disabled: false});
        document.getElementById('ladriverlist').value="";
        document.getElementById('del_chaufferid').value="";
   }
}

function getchauffeur(event){
    var x= event.keyCode;
    if(x==114){
        $('#chauffeurinfowindow').jqxWindow('open');
        chauffeurSearchContent('SearchChauffeur.jsp?', $('#chauffeurinfowindow'));  	 
    }
}
function chauffeurSearchContent(url) { $.get(url).done(function (data) { $('#chauffeurinfowindow').jqxWindow('setContent', data); }); }
    
function getdeldrv(event){
	 var x= event.keyCode;
	 if(x==114){
	    $('#deldrvwindow').jqxWindow('open');
        drvdelSearchContent('Searchdeldriver.jsp?', $('#deldrvwindow'));  	 
     }
}
function drvdelSearchContent(url) { $.get(url).done(function (data) { $('#deldrvwindow').jqxWindow('setContent', data); }); }

function getvehinfo(eventval){
    var x= event.keyCode;
    if(x==114){
        $('#vehinfowindow').jqxWindow('open');
        if(eventval==1) { vehinfoSearchContent('vehinfo.jsp?', $('#vehinfowindow')); }
        else { vehinfoSearchContent('vehinfotemp.jsp?', $('#vehinfowindow')); }
    }
}
function vehinfoSearchContent(url) { $.get(url).done(function (data) { $('#vehinfowindow').jqxWindow('setContent', data); }); }

function getDeliveryDriverConfig(){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim().split("::");
            $('#invruleoverride').val(items[1].trim());
        }
    }
    x.open("GET", "getDeliveryDriverConfig.jsp", true);
    x.send();
}

function funNotify(){	
    var maindate = $('#date').jqxDateTimeInput('getDate');
    var validdate=funDateInPeriod(maindate);
    if(validdate==0){ return 0; }
				   
    if($('#totalmasterqty').val()==$('#totalagmtqty').val() && $('#cmbmasterreftype').val()!="DIR"){
        document.getElementById("errormsg").innerText="Agreement Limit for Master Lease "+$('#masterrefno').val()+" Exceeded";
        return 0;
    }
    var valid2=document.getElementById("clientid").value;
    if(valid2=="") {
        document.getElementById("errormsg").innerText=" Select Client";
        document.getElementById("clientid").focus();  
        return 0;
    }

    if($("#invruleoverride").val()!="1"){
        var checkinvoice ="Monthly";
        var invoicevalue=document.getElementById("invoice").value;
        if(document.getElementById("configmethod").value>0) {
            if(checkinvoice=="Monthly") { 
                if(document.getElementById("advchkval").value!=document.getElementById("advance_chk").value) {
                    document.getElementById("errormsg").innerText="Please check the client invoice rule";
                    return 0;
                }
                if(document.getElementById("invval").value!=document.getElementById("invoice").value) {
                    document.getElementById("errormsg").innerText="Please check the client invoice rule";
                    return 0;
                }
            }
        }
        var invoice=$('#invoice').val();
        if(invoice=="5" || invoice=="6"){
            if(document.getElementById("advance_chk").checked==false){
                document.getElementById("errormsg").innerText="Please check the advance";
                return 0;
            }
        }
        if(checkinvoice!="Monthly") {
            if(invoicevalue=="1") {
                if(document.getElementById("configmethod").value>0) {	
                    $('#advance_chk').attr('disabled', false);
                    $('#invoice').attr('disabled', false);
                }
            } else { document.getElementById("errormsg").innerText=""; }
        }
    }

    var validdesc=document.getElementById("description").value;
    if(validdesc!="") {
        var nmaxs = validdesc.length;
        if(nmaxs>99) {
            document.getElementById("errormsg").innerText="Description Cannot Contain More Than 100 Characters";
            document.getElementById("description").focus(); 
            return 0;
        } else { document.getElementById("errormsg").innerText=""; }
    }
		
    if (document.getElementById('additional_driver').checked) {
        var addcharge=document.getElementById("adidrvcharges").value;
        if( addcharge=="") {
            document.getElementById("errormsg").innerText=" Enter Additional Driver Charge";
            document.getElementById("adidrvcharges").focus();  
            return 0;
        } else { document.getElementById("errormsg").innerText=""; }
    }
		
    if(document.getElementById('ladrivercheck').checked==false) {
        var rows = $("#jqxgrid2").jqxGrid('getrows');
        var aa=0;
        for(var i=0;i<rows.length;i++){
            if(parseInt(rows[i].dr_id1)>0) { aa=1; break; }
            else{ aa=0; } 
        }
        if(parseInt(aa)==0) {
            document.getElementById("errormsg").innerText=" Select Driver";
            return 0;
        } else { document.getElementById("errormsg").innerText=""; }
    }
    
    if ((document.getElementById('ladrivercheck').checked)) {
        var drvname=document.getElementById("ladriverlist").value;
        if(drvname=="") {
            document.getElementById("errormsg").innerText=" Select Driver";
            document.getElementById("ladriverlist").focus();  
            return 0;
        } else { document.getElementById("errormsg").innerText=""; }
    }
		
    var excessinsur=document.getElementById("excessinsur").value;
    if(excessinsur=="") { document.getElementById("excessinsur").value=0; }
	
	// driver grid
	var rows = $("#jqxgrid2").jqxGrid('getrows');
    $('#drivergridlength').val(rows.length);
    for(var i=0;i<rows.length;i++){
        newTextBox = $(document.createElement("input"))
            .attr("type", "dil")
            .attr("id", "drvtest"+i)
            .attr("name", "drvtest"+i)
            .attr("hidden", "true");
        newTextBox.val(rows[i].dr_id1+" :: ");
        newTextBox.appendTo('form');
    }

	// tariff grid
    var rows = $("#rateGrid").jqxGrid('getrows');
    $('#tariffgridlength').val(rows.length);
    for(var i=0;i<rows.length;i++){
        var rowlgt= rows.length-1; 
        if(i==rowlgt) {
            var rateval=rows[i].rate;
            if(rateval==""||typeof(rateval)=="undefined"||typeof(rateval)=="NaN") {
                document.getElementById("errormsg").innerText="Tariff Is Not Entered";  
                return 0;
            }
        }
    }
    for(var i=0;i<rows.length;i++){
        newTextBox = $(document.createElement("input"))
            .attr("type", "dil")
            .attr("id", "test"+i)
            .attr("name", "test"+i)
            .attr("hidden", "true");
        newTextBox.val(rows[i].rate+" :: "+rows[i].cdw+" :: "+rows[i].pai+" :: "+rows[i].cdw1+" :: "+rows[i].pai1+" :: "+rows[i].gps+" :: "+rows[i].babyseater+" :: "+rows[i].cooler+" :: "+rows[i].kmrest+" :: "+rows[i].exkmrte+" :: "+rows[i].chaufchg+" :: "+rows[i].chaufexchg+" :: "+rows[i].status+" :: ");
        newTextBox.appendTo('form'); 
    }				
         
	var rows = $("#jqxgridpayment").jqxGrid('getrows');
    var cardnum="";
    var cardtype="";
    for(var i=0 ; i < rows.length ; i++){
        if(rows[i].mode=="CARD"||rows[i].mode=="CASH") {
            if(rows[i].amount==""||rows[i].amount=="0.00"||typeof(rows[i].amount)=="undefined"||typeof(rows[i].amount)=="NaN") {
                document.getElementById("errormsg").innerText="Enter Amount In   "+rows[i].payment;  
                return 0;
            }
        } 
        if(rows[i].mode=="CARD") {
            cardtype=rows[i].card;
            cardnum=rows[i].cardno;
            if(!(cardtype=="MASTER"||cardtype=="VISA")) {
                document.getElementById("errormsg").innerText="Select Card Type In "+rows[i].payment;  
                return 0;
            } 
            if(cardnum==""||typeof(cardnum)=="undefined"||typeof(cardnum)=="NaN") {
                document.getElementById("errormsg").innerText="Enter Card NO In  "+rows[i].payment;  
                return 0;
            }
            var str = ""+cardnum;
            var n = str.length;
            if(n!=16) {
                document.getElementById("errormsg").innerText="Invalid Card Number In  "+rows[i].payment;  
                return 0;
            }
        }
    }
			   
    var rows = $("#jqxgridpayment").jqxGrid('getrows');
    $('#paymentgridlength').val(rows.length);
    for(var i=0 ; i < rows.length ; i++){
        newTextBox = $(document.createElement("input"))
            .attr("type", "dil")
            .attr("id", "paytest"+i)
            .attr("name", "paytest"+i)
            .attr("hidden", "true");
        newTextBox.val(rows[i].payment+"::"+rows[i].mode+" :: "+rows[i].amount+" :: "+rows[i].acode+" :: "+rows[i].cardno+" :: "+rows[i].hidexpdate+" :: "+rows[i].card+" :: "+rows[i].cardtype+" :: "+rows[i].paytype+" :: "+rows[i].invno+" :: "+rows[i].status+" :: ");
        newTextBox.appendTo('form');
    }   
			   
    var rows = $("#nwevehgrid").jqxGrid('getrows');
    $('#newvehdetalslenght').val(rows.length);
    for(var i=0;i<rows.length;i++){
        newTextBox = $(document.createElement("input"))
            .attr("type", "dil")
            .attr("id", "vehtest"+i)
            .attr("name", "vehtest"+i)
            .attr("hidden", "true");
        newTextBox.val(rows[i].name+" :: "+rows[i].price+" :: ");
        newTextBox.appendTo('form');
    }  
    return 1;
}

function getAgmtDates(doctemp) {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            var showdate = items.split("::")[0];
            var showtime = items.split("::")[1];
            var showagmtdate = items.split("::")[2];
            if (showagmtdate == "1") {
                if (showdate != "null") { document.getElementById("errormsg").innerText = "Closed On " + showdate + "  " + showtime; }
            }
        }
    }
    x.open("GET", "getAgmtDates.jsp?docno=" + doctemp, true);
    x.send();
}

function setValues() {
    var maindoc=document.getElementById("masterdoc_no").value;
    if(maindoc>0) {
        var indexVal1 = document.getElementById("masterdoc_no").value;
        $("#ratediv").load('rateGrid.jsp?rateGriddocno='+indexVal1);
        $("#divDrivGrid").load("driverGrid.jsp?driverGriddocno="+indexVal1);
        $("#paymentdiv").load("paymentdetailsgrid.jsp?paymentGriddocno="+indexVal1);
        $("#newvehdiv").load("newvehdetails.jsp?vehdivdoc="+indexVal1);
        getAgmtDates(indexVal1);
    }
  		
    if($('#hiddate').val()){ $("#date").jqxDateTimeInput('val', $('#hiddate').val()); }
    if($('#hidoutdate').val()){ $("#dateout").jqxDateTimeInput('val', $('#hidoutdate').val()); }
    getConfigs();
    if($('#hidouttime').val()){ $("#timeout").jqxDateTimeInput('val', $('#hidouttime').val()); }
    if($('#hiddeloutdate').val()){ $("#deldateout").jqxDateTimeInput('val', $('#hiddeloutdate').val()); }
    if($('#hiddelouttime').val()){ $("#deltimeout").jqxDateTimeInput('val', $('#hiddelouttime').val()); } 
      	
    if($('#msg').val()!=""){ $.messager.alert('Message',$('#msg').val()); }
  	   
    delvalueChange();
  	
    if(document.getElementById("checkbranch").value=="WOB") {
        $("#btnDelete").attr('disabled', true );
        $("#btndelupdate").attr('disabled', true );
        $("#btnupdate").attr('disabled', true );
    }

    if($('#hidcmbmasterreftype').val()!=''){
        $('#cmbmasterreftype').val($('#hidcmbmasterreftype').val());
    }
}

function fundescvalidate() {
    var validdesc=document.getElementById("description").value;
    if(validdesc!="") {
        var nmaxs = validdesc.length;
        if(nmaxs>99) {
            document.getElementById("errormsg").innerText="Description Cannot Contain More Than 100 Characters";
            document.getElementById("description").focus(); 
            return 0;
        } else{ document.getElementById("errormsg").innerText=""; }
    }
}

function delvalueChange() {
    if(document.getElementById("delchkvalue").value==1) {
        document.getElementById("chkdelivery").checked = true;
        document.getElementById("chkdelivery").value = 1;
        document.getElementById("del_chaufferid").value = "";
        document.getElementById("ladriverlist").value = "";
    }
    if(document.getElementById("add_drchk").value==1) {
        document.getElementById("additional_driver").checked = true;
        document.getElementById("additional_driver").value = 1;
        if ($("#mode").val() == "A") { $('#adidrvcharges').attr('disabled', false); }
    }
    if(document.getElementById("chaffchkvalue").value==1) {
        document.getElementById("ladrivercheck").checked = true;
        document.getElementById("ladrivercheck").value = 1;
        document.getElementById('deldrvname').value="";
        document.getElementById('deldrvid').value="";
        if ($("#mode").val() == "A") { $('#ladriverlist').attr('disabled', false); }
    }
    if(document.getElementById("hidadvance_chk").value==1) {
        document.getElementById("advance_chk").checked = true;
        document.getElementById("advance_chk").value = 1;
    }

    if($('#hidcmbtype').val()!="") { $('#cmbfuelout').val($('#hidcmbtype').val()); }
    if($('#hiddelcmbtype').val()!="") { $('#cmbdelfuelout').val($('#hiddelcmbtype').val()); }
    if($('#hidper_value').val()!="") { $('#per_value').val($('#hidper_value').val()); }
    if($('#hidper_name').val()!="") { $('#per_name').val($('#hidper_name').val()); }
    if($('#hidinvoice').val()!="") { $('#invoice').val($('#hidinvoice').val()); }
}

function funSearchLoad(){ changeContent('masterSearch.jsp', $('#window')); }

function funchkvehStatus() {
    var masterdoc=document.getElementById("masterdoc_no").value;
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items= x.responseText;
            if(items>0) {
                $.messager.alert('Message',' Already Edited ','warning');   
                return  0;
            } else {
                $("#cleardata").show();	
                $('#dateout').jqxDateTimeInput({ disabled: false});
                $("#vehdetailsupdate input").prop("disabled", false);
                $("#vehdetailsupdate select").prop("disabled", true);
                $("#kmout").attr("readonly",true); 
                $('#dateout').jqxDateTimeInput({ disabled: false});
                $("#dateout").val(new Date);
                $("#timeout").val(new Date);
                if($('#chaffchkvalue').val()=="1") { $("#chkdelivery").attr("disabled", true); }
                if (document.getElementById('chkdelivery').checked) {
                    $("#delcharges").prop("disabled", false);
                    $("#deldrvname").prop("disabled", false);
                } else {
                    $("#delcharges").prop("disabled", true);
                    $("#deldrvname").prop("disabled", true);
                    document.getElementById('delcharges').value="";
                    document.getElementById('deldrvname').value="";
                    document.getElementById('deldrvid').value="";
                }
                document.getElementById("btnupdate").value="Update";
                document.getElementById("mode").value='ADD';
                return 0;
            }
        }
    }
    x.open("GET", 'checkvehUpdate.jsp?masterdocno='+masterdoc, true);
    x.send();
}  

function funupdate() {
    if(document.getElementById("btnupdate").value=="Edit") {
        $('#docno').attr('disabled',false);
        if(($('#masterdoc_no').val()=="0") || ($('#masterdoc_no').val()=="")) {
            $.messager.alert('Message',' Search Details ','warning');   
            $('#docno').attr('disabled',true);
            return 0;
        }
        funchkvehStatus();
        return 0;
    } else {
        var fleet_no=0;
        var intimeprior=new Date($('#timeout').jqxDateTimeInput('getDate'));
        var indateprior=new Date($('#dateout').jqxDateTimeInput('getDate'));
        var intimepriorstatus=checkPriorTime(intimeprior,indateprior);
        if(intimepriorstatus){ document.getElementById("errormsg").innerText=""; }
        else if(intimepriorstatus==false && document.getElementById("priormethod").value=="2"){
            $('#intime').jqxDateTimeInput('focus');
            return 0;
        }
        $.messager.confirm('Confirm', 'Do you want to save changes?', function(r){
            if (r==false){ return 0; }
            else {
                if($('#tempfleet').val()=="" && $('#permanentfleet').val()=="") {
                    document.getElementById("errormsg").innerText=" Search Fleet";	 
                    return false;	
                } else { document.getElementById("errormsg").innerText=""; }

                if($('#permanentfleet').val()=="") { fleet_no=document.getElementById("tempfleet").value; }
                else if($('#tempfleet').val()=="") { fleet_no=document.getElementById("permanentfleet").value; }
					
                if ((document.getElementById('chkdelivery').checked)) {
                    var deldrvname=document.getElementById("deldrvname").value;
                    if(deldrvname=="") {
                        document.getElementById("errormsg").innerText=" Select Driver";
                        document.getElementById("deldrvname").focus();  
                        return 0;
                    } else{ document.getElementById("errormsg").innerText=""; }
							
                    var delcharge=document.getElementById("delcharges").value;
                    if(delcharge=="") {
                        document.getElementById("errormsg").innerText="Enter Delivery Charges ";
                        document.getElementById("delcharges").focus();  
                        return 0;
                    } else{ document.getElementById("errormsg").innerText=""; }
                }
					
                var dateout = $('#dateout').jqxDateTimeInput('getDate');
                var validdate=funDateInPeriod(dateout);
                if(validdate==0){ return 0; }
				
                var dateout=$('#dateout').val();
                var timeout=$('#timeout').val();
                chkavailable(fleet_no,dateout,timeout);
            }
        });
    }
}
  
function chkavailable(valfleet,dateout,timeout) {
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items=x.responseText;
            var chkfleet=items.trim();
            if(chkfleet==1) {
                $.messager.alert('Message','Fleet Is Not Available ','warning');   
                return 0;
            } else {
                funSetlabel();
                $('#frmLeaseAgreementForMaster input').attr('disabled', false );
                $('#frmLeaseAgreementForMaster textarea').attr('disabled', false );
                $('#frmLeaseAgreementForMaster select').attr('disabled', false);
                $('#date').jqxDateTimeInput({ disabled: false});
                $('#jqxgrid2').jqxGrid({ disabled: false});
                $('#jqxgridpayment').jqxGrid({ disabled: false});
                $('#rateGrid').jqxGrid({ disabled: false}); 
                $('#dateout').jqxDateTimeInput({ disabled: false});
					   
                var rows = $("#jqxgridpayment").jqxGrid('getrows');
                $('#paymentgridlength').val(rows.length);
                for(var i=0 ; i < rows.length ; i++){
                    newTextBox = $(document.createElement("input"))
                        .attr("type", "dil")
                        .attr("id", "paytest"+i)
                        .attr("name", "paytest"+i)
                        .attr("hidden", "true");
                    newTextBox.val(rows[i].payment+"::"+rows[i].mode+" :: "+rows[i].amount+" :: "+rows[i].acode+" :: "+rows[i].cardno+" :: "+rows[i].hidexpdate+" :: "+rows[i].card+" :: "+rows[i].cardtype+" :: "+rows[i].paytype+" :: "+rows[i].invno+" :: "+rows[i].status+" :: ");
                    newTextBox.appendTo('form');
                }   
                $('#frmLeaseAgreementForMaster').submit();
            }
        }
    }
    x.open("GET","chkavailablefleet.jsp?valfleet="+valfleet+"&dateout="+dateout+"&timeout="+timeout,true);
    x.send();
}
 
function funchkDelStatus() {
    var masterdoc=document.getElementById("masterdoc_no").value;
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items= x.responseText;
            if(items>0) {
                $.messager.alert('Message',' Already Edited ','warning');   
                return  0;
            } else {
                $("#delupdatefd input").prop("disabled", false);
                $("#delupdatefd select").prop("disabled", false);
                $('#deldateout').jqxDateTimeInput({ disabled: false});
                $("#deldateout").val(new Date);
                $("#deltimeout").val(new Date);
                document.getElementById("btndelupdate").value="Update";
                document.getElementById("mode").value='DLY';
                return 0;
            }
        }
    }
    x.open("GET", 'checkdelUpdate.jsp?masterdocno='+masterdoc, true);
    x.send();
}  

function fundelupdate() {
    if(document.getElementById("btndelupdate").value=="Edit") {
        $('#delchkvalue').attr('disabled',false);
        if(($('#delchkvalue').val()==1)) { funchkDelStatus(); }
        else {
            $.messager.alert('Message','Delivery Update Need Not Be Entered ','warning');   
            return 0;
        }
        return 0;
    } else {
        $.messager.confirm('Confirm', 'Do you want to save changes?', function(r){
            if (r==false){ return 0; }
            else {
                var indate1=new Date($('#dateout').jqxDateTimeInput('getDate'));     
                var agmtdate1=new Date($('#deldateout').jqxDateTimeInput('getDate')); 
                var intime1=new Date($('#timeout').jqxDateTimeInput('getDate'));  
                var agmttime1=new Date($('#deltimeout').jqxDateTimeInput('getDate')); 

                indate1.setHours(0,0,0,0);
                agmtdate1.setHours(0,0,0,0);
						  
                if(indate1>agmtdate1){
                    document.getElementById("errormsg").innerText="Delivery Date Cannot be Less than Out Date";
                    return false;
                }   
						
                if(indate1.valueOf()==agmtdate1.valueOf()){
                    var out=intime1.getHours();
                    var del=agmttime1.getHours();
                    if(out > del){
                        document.getElementById("errormsg").innerText="Delivery Time Cannot be Less than Out Time";
                        return false;
                    }
                    if(out==del){
                        if(intime1.getMinutes()>agmttime1.getMinutes()){
                            document.getElementById("errormsg").innerText="Delivery Time Cannot be Less than Out Time";
                            return false;
                        }
                    }
                }
                document.getElementById("errormsg").innerText="";  
					
                if(document.getElementById("delkmout").value=="") {
                    document.getElementById("errormsg").innerText=" Enter Delivery KM";
                    document.getElementById("delkmout").focus();
                    return false;
                } else { document.getElementById("errormsg").innerText=""; }
                
                if($('#cmbdelfuelout').val()=="") {
                    document.getElementById("errormsg").innerText=" Select Delivery Fuel";	 
                    document.getElementById("cmbdelfuelout").focus();
                    return false;
                } else { document.getElementById("errormsg").innerText=""; }
       
                $("#kmout").prop("disabled", false);
                var outkm=document.getElementById("kmout").value;
                var delkm=document.getElementById("delkmout").value;
                if((parseFloat(delkm)<parseFloat(outkm))) {
                    document.getElementById("errormsg").innerText="Delivery KM Less Than Out KM";  
                    $("#kmout").prop("disabled", true);
                    return 0;
                } else {
                    document.getElementById("errormsg").innerText="";  
                    $("#kmout").prop("disabled", true);
                }
					
                funSetlabel();
                $('#frmLeaseAgreementForMaster input').attr('disabled', false );
                $('#frmLeaseAgreementForMaster textarea').attr('disabled', false );
                $('#frmLeaseAgreementForMaster select').attr('disabled', false);
                $('#date').jqxDateTimeInput({ disabled: false});
                $('#jqxgrid2').jqxGrid({ disabled: false});
                $('#jqxgridpayment').jqxGrid({ disabled: false});
                $('#rateGrid').jqxGrid({ disabled: false}); 
                $('#dateout').jqxDateTimeInput({ disabled: false});
                $('#deldateout').jqxDateTimeInput({ disabled: false}); 
                $('#frmLeaseAgreementForMaster').submit();
            }
        });
    }
}

function funchkKm() {
    $("#kmout").prop("disabled", false);
    var outkm=document.getElementById("kmout").value;
    var delkm=document.getElementById("delkmout").value;
    if((parseFloat(delkm)<parseFloat(outkm))) {
        document.getElementById("errormsg").innerText="Delivery KM Less Than Out KM";  
        document.getElementById("delkmout").focus();
        $("#kmout").prop("disabled", true);
        return 0;
    } else {
        document.getElementById("errormsg").innerText="";  
        $("#kmout").prop("disabled", true);
    }
}
  
function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
    	document.getElementById("errormsg").innerText="Enter Numbers Only";  
        return false;
    }
    document.getElementById("errormsg").innerText="";  
    return true;
}

function fundelivarytick(){
    if (document.getElementById('chkdelivery').checked) {
        $("#delcharges").prop("disabled", false);
        $("#deldrvname").prop("disabled", false);
    } else {
        $("#delcharges").prop("disabled", true);
        $("#deldrvname").prop("disabled", true);
        document.getElementById('delcharges').value="";
        document.getElementById('deldrvname').value=""; 
        document.getElementById('deldrvid').value="";
    }
} 

function funPrintBtn(){
    if (($("#mode").val() != "A") && $("#masterdoc_no").val()!="") {
        var url=document.URL;
        var reurl=url.split("saveLeaseAgreementForMaster");
        $("#docno").prop("disabled", false);                
        var win= window.open(reurl[0]+"Leasemainprint?docno="+document.getElementById("masterdoc_no").value+"&formdetailcode=LAG","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
        win.focus(); 
    } else {
        $.messager.alert('Message','Select a Document....!','warning');
        return false;
    }
}  

function funPrintdown(){ 
    if (($("#mode").val() != "A") && $("#masterdoc_no").val()!="") {
        var url=document.URL;
        var reurl=url.split("saveLeaseAgreement");
        $("#docno").prop("disabled", false);                
        var win= window.open(reurl[0]+"LeasemasterPrint?docno="+document.getElementById("masterdoc_no").value+"&formdetailcode=LAG","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
        win.focus(); 
    } else {
        $.messager.alert('Message','Select a Document....!','warning');
        return false;
    }
} 

function clearvehdata() {
    if(document.getElementById("mode").value="ADD") {
        document.getElementById("mode").value="view";
        document.getElementById("tempfleet").value="";
        document.getElementById("permanentfleet").value="";
        document.getElementById("delcharges").value="";
        document.getElementById("fleetname").value="";
        document.getElementById("kmout").value="";
        document.getElementById("cmbfuelout").value="";
        document.getElementById('deldrvname').value=""; 
        document.getElementById('deldrvid').value="";
	  
        $('#dateout').jqxDateTimeInput({ disabled: true});
        $("#vehdetailsupdate input").prop("disabled", true);
        $("#vehdetailsupdate select").prop("disabled", true);
        $("#kmout").attr("readonly",true); 
        $("#dateout").val('');
        $("#timeout").val('');
        document.getElementById('chkdelivery').checked=false;
        $("#btnupdate").prop("disabled", false);
        $("#leaseprintbtn").prop("disabled", false);
        document.getElementById("btnupdate").value="Edit";
        $("#cleardata").hide();	
        return 0;
    }
}

function checkBrandQty(fleetno,masterrefno){
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items=x.responseText.trim().split("::");
            var brand=items[0];
            var model=items[1];
            var mastervehqty=items[2];
            var agmtvehqty=items[3];
            if(parseInt(mastervehqty)==parseInt(agmtvehqty) && $('#cmbmasterreftype').val()!="DIR"){
                document.getElementById("errormsg").innerText="Vehicle Limit for Master Lease "+$('#masterrefno').val()+" with brand "+brand+" and model "+model+" Exceeded";
                return false;
            }
        }
    }
    x.open("GET","checkBrandQty.jsp?fleetno="+fleetno+"&masterrefno="+masterrefno,true);
    x.send();	
}

</script>

</head>
<body onload="setValues();">
    <div id="mainBG" class="homeContent" data-type="background">
        <form id="frmLeaseAgreementForMaster" action="saveLeaseAgreementForMaster" method="post" autocomplete="off">
            <input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
            <jsp:include page="../../../../header.jsp" /><br/>
            
            <div class='hidden-scrollbar'>

<div class="accordion-header" onclick="toggleAccordion(this)">
    <div class="accordion-left">
        <div class="accordion-number">1</div>
        <div class="accordion-title">Lease Info</div>
    </div>
    <div class="accordion-arrow"></div>
</div>

<div class="accordion-content">
<div style="width:100%; display:flex; gap:20px; align-items:flex-start;">

    <div style="flex:1; background:#f7f9fc; padding:12px; border-radius:8px;">
        <div style="border-left:3px solid #1a4fa3; padding-left:8px; font-weight:600; margin-bottom:10px;">
            Client Info
        </div>

        <div style="display:flex; gap:10px; margin-bottom:10px; align-items:center;">
            <label style="width:90px;">Client</label>
            <input type="text" id="clientid" name="clientid" style="width:140px;" readonly placeholder="Press F3 To Search" value='<s:property value="clientid"/>' onKeyDown="getclientinfo(event);" ondoubleclick="getclientinfo(event);"/>
            <input type="text" id="clientname" readonly name="clientname" style="flex:1;" tabindex="-1" value='<s:property value="clientname"/>'/>
        </div>

        <div style="display:flex; gap:10px; margin-bottom:10px; align-items:center;">
            <label style="width:90px;">Salesman</label>
            <input type="text" id="salesman" name="salesman" style="flex:1;" readonly placeholder="Salesman Name" value='<s:property value="salesman"/>'/>
            
            <input type="hidden" id="le_salmanid" name="le_salmanid" value='<s:property value="le_salmanid"/>'/>
            <input type="hidden" id="le_clcodeno" name="le_clcodeno" value='<s:property value="le_clcodeno"/>'/>
            <input type="hidden" id="le_clacno" name="le_clacno" value='<s:property value="le_clacno"/>'/>
        </div>

        <div style="display:flex; gap:10px; margin-bottom:10px; align-items:center;">
            <label style="width:90px;">Address</label>
            <input type="text" id="cusaddress" placeholder="Mobil NO-Address" readonly name="cusaddress" style="flex:1;" value='<s:property value="cusaddress"/>'>
        </div>

        <div style="display:flex; gap:10px; align-items:center;">
            <label style="width:90px;">Description</label>
            <input type="text" name="description" id="description" placeholder="Description" value='<s:property value="description"/>' style="flex:1;" onblur="fundescvalidate()">
        </div>
    </div>

    <div style="width:340px;">
        <div style="display:flex; flex-direction:column; gap:10px;">
            
            <div style="display:flex; align-items:center; gap:10px;">
                <label style="width:100px;">Date</label>
                <div id='date' name='date' style="flex:1;" value='<s:property value="date"/>'></div>
                <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'/>
            </div>

            <div style="display:flex; align-items:center; gap:10px;">
                <label style="width:100px;">Doc No</label>
                <input type="text" id="docno" name="docno" style="flex:1;" readonly tabindex="-1" value='<s:property value="docno"/>'/>
            </div>

            <div style="display:flex; align-items:center; gap:10px;">
                <label style="width:100px;">Enq.Type</label>
                <select name="cmbenqtype" id="cmbenqtype" style="flex:1;"><option value="">--Select--</option></select>
                <input type="hidden" name="hidcmbenqtype" id="hidcmbenqtype" value='<s:property value="hidcmbenqtype"/>'>
            </div>

            <div style="display:flex; align-items:center; gap:10px;">
                <label style="width:100px;">Master Ref Type</label>
                <select name="cmbmasterreftype" id="cmbmasterreftype" style="flex:1;"><option value="DIR">DIR</option><option value="MLA">MLA</option></select>
                <input type="hidden" name="hidcmbmasterreftype" id="hidcmbmasterreftype" value='<s:property value="hidcmbmasterreftype"/>'>
            </div>

            <div style="display:flex; align-items:center; gap:10px;">
                <label style="width:100px;">Master Ref No</label>
                <input type="text" name="masterrefno" id="masterrefno" style="flex:1;" value='<s:property value="masterrefno"/>' readonly placeholder="Press F3 to Search" onkeydown="getMasterRefno(event);">
                <input type="hidden" name="hidmasterrefno" id="hidmasterrefno" value='<s:property value="hidmasterrefno"/>'>
                <input type="hidden" name="masterrefnocldocno" id="masterrefnocldocno" value='<s:property value="masterrefnocldocno"/>'>
            </div>
            
            <div style="display:flex; align-items:center; gap:10px;">
                <label style="width:100px;">Status</label>
                <label id="leasestatus" name="leasestatus" style="color:#6000FC; font-weight:bold;"><s:property value="leasestatus"/></label>
            </div>
            
            <div style="text-align:right;">
                <div id='jqxMenuMore'>
                    <ul>
                        <li><a href="#trafficFines" onclick="fine();">Traffic Fines</a></li>
                        <li><a href="#documents" onclick="replacement();">Replacement</a></li>
                        <li><a href="#history" onclick="account();">Account Statement</a></li>   
                        <li><a href="#close" onclick="closing();">Closing Summary</a></li>
                        <li><a href="#kmdetails" onclick="funKmDetails();">KM Details</a></li>               
                    </ul>
                </div>
            </div>

        </div>
    </div>

</div>
</div>

<div class="accordion-header" onclick="toggleAccordion(this)">
    <div class="accordion-left">
        <div class="accordion-number">2</div>
        <div class="accordion-title">Driver Details</div>
    </div>
    <div class="accordion-arrow"></div>
</div>

<div class="accordion-content">
    <div style="display:flex; align-items:center; gap:20px; flex-wrap:wrap; margin-bottom:10px;">

        <div style="display:flex; align-items:center; gap:6px;">
            <label>Additional Driver</label>
            <input type="checkbox" id="additional_driver" name="additional_driver" value="0" onchange="funaddidriverview()" onclick="$(this).attr('value', this.checked ? 1 : 0)">
        </div>

        <div style="display:flex; align-items:center; gap:6px;">
            <label>Charge</label>
            <input type="text" id="adidrvcharges" name="adidrvcharges" style="width:80px; text-align:right;" value='<s:property value="adidrvcharges"/>' onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event)">
        </div>

        <div style="display:flex; align-items:center; gap:6px;">
            <label>Chauffeur</label>
            <input type="checkbox" id="ladrivercheck" name="ladrivercheck" value="0" onchange="funShaffurdisable()" onclick="$(this).attr('value', this.checked ? 1 : 0)">
        </div>

        <div style="display:flex; align-items:center; gap:6px;">
            <input type="text" id="ladriverlist" name="ladriverlist" placeholder="Press F3 To Search" style="width:180px;" value='<s:property value="ladriverlist"/>' onKeyDown="getchauffeur(event);"/>
            
            <input type="hidden" id="del_chaufferid" name="del_chaufferid" value='<s:property value="del_chaufferid"/>'/>
            <input type="hidden" id="client_driverid" name="client_driverid" value='<s:property value="client_driverid"/>'/>
            <input type="hidden" id="client_driverdoc" name="client_driverdoc" value='<s:property value="client_driverdoc"/>'/>
        </div>

    </div>

    <div style="width:100%;">
        <div id="divDrivGrid">
            <jsp:include page="driverGrid.jsp"></jsp:include>
        </div>
    </div>
</div>

<div class="accordion-header" onclick="toggleAccordion(this)">
    <div class="accordion-left">
        <div class="accordion-number">3</div>
        <div class="accordion-title">Rate Info</div>
    </div>
    <div class="accordion-arrow"></div>
</div>

<div class="accordion-content">
    <div style="display:flex; align-items:center; gap:20px; flex-wrap:wrap; margin-bottom:10px;">
        
        <div style="display:flex; align-items:center; gap:6px;">
            <label>Period</label>
            <select name="per_value" id="per_value" style="width:70px;" value='<s:property value="per_value"/>'>
                <option value=1>1</option><option value=2>2</option><option value=3>3</option><option value=4>4</option><option value=5>5</option>
                <option value=6>6</option><option value=7>7</option><option value=8>8</option><option value=9>9</option><option value=10>10</option>
                <option value=11>11</option><option value=12>12</option><option value=13>13</option><option value=14>14</option><option value=15>15</option>
                <option value=16>16</option><option value=17>17</option><option value=18>18</option><option value=19>19</option><option value=20>20</option>
                <option value=21>21</option><option value=22>22</option><option value=23>23</option><option value=24>24</option><option value=25>25</option>
                <option value=26>26</option><option value=27>27</option><option value=28>28</option><option value=29>29</option><option value=30>30</option>
                <option value=31>31</option><option value=32>32</option><option value=33>33</option><option value=34>34</option><option value=35>35</option>
                <option value=36>36</option><option value=37>38</option><option value=38>38</option><option value=39>39</option><option value=40>40</option>
                <option value="" selected>-Select-</option>      
            </select>
            <select name="per_name" id="per_name" style="width:100px;" value='<s:property value="per_name"/>'>
                <option value=1>Years</option>
                <option value=2>Months</option>
                <option value="" selected>-Select-</option>      
            </select>
        </div>

        <div style="display:flex; align-items:center; gap:6px;">
            <input type="checkbox" id="advance_chk" name="advance_chk" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)">
            <label>Advance</label>
        </div>

        <div style="display:flex; align-items:center; gap:6px;">
            <label>Ins.Excess</label>
            <input type="text" id="excessinsur" name="excessinsur" style="width:100px; text-align:right;" value='<s:property value="excessinsur"/>' onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event);">
        </div>

        <div style="display:flex; align-items:center; gap:6px;">
            <label>Invoice</label>
            <select name="invoice" id="invoice" style="width:140px;" value='<s:property value="invoice"/>'>
                <option value="1">Month End</option>
                <option value="2">Period</option>
            </select>
        </div>

    </div>

    <div style="width:100%;">
        <div id="ratediv">
            <jsp:include page="rateGrid.jsp"></jsp:include>
        </div>
    </div>
</div>

<div class="accordion-header" onclick="toggleAccordion(this)">
    <div class="accordion-left">
        <div class="accordion-number">4</div>
        <div class="accordion-title">Payment Info</div>
    </div>
    <div class="accordion-arrow"></div>
</div>

<div class="accordion-content">
    <div style="width:100%;">
        <div id="paymentdiv">
            <jsp:include page="paymentdetailsgrid.jsp"></jsp:include>
        </div>
    </div>

    <div style="display:flex; gap:20px; flex-wrap:wrap; margin-top:10px;">
        <div style="display:flex; align-items:center; gap:8px;">
            <label style="width:60px;">PO</label>
            <input type="text" id="leasePo" name="leasePo" style="width:140px;" value='<s:property value="leasePo"/>'>
        </div>

        <div style="display:flex; align-items:center; gap:8px;">
            <label style="width:60px;">Project</label>
            <input type="text" id="leaseproject" name="leaseproject" style="width:180px;" readonly="readonly" onkeydown="getproject(event);" placeholder="Press F3 To Search" value='<s:property value="leaseproject"/>'>
            <input type="hidden" id="leaseprojectDoc" name="leaseprojectDoc" value='<s:property value="leaseprojectDoc"/>'>
        </div>
    </div>
</div>

<div class="accordion-header" onclick="toggleAccordion(this)">
    <div class="accordion-left">
        <div class="accordion-number">5</div>
        <div class="accordion-title">Termination Clauses & Other Income</div>
    </div>
    <div class="accordion-arrow"></div>
</div>

<div class="accordion-content">
    <div style="display:flex; gap:20px;">
        
        <div style="flex:1;">
            <fieldset style="margin-bottom:0;">
            <legend>Termination Clauses</legend>
            <table width="100%" cellpadding="3">
                <tr>
                    <td align="right" width="60%">
                        <input type="text" name="m1" id="m1" value='<s:property value="m1"/>' onkeypress="javascript:return isNumber (event)" style="width:50px; text-align:center;"> to 
                        <input type="text" name="m2" id="m2" value='<s:property value="m2"/>' onkeypress="javascript:return isNumber (event)" onblur="change1();" style="width:50px; text-align:center;">
                    </td>
                    <td align="left"><input type="text" id="amt1" name="amt1" style="width:100px;" value='<s:property value="amt1"/>' onkeypress="javascript:return isNumber (event)"/></td>
                </tr>
                <tr>
                    <td align="right">
                        <input type="text" name="m3" id="m3" value='<s:property value="m3"/>' onkeypress="javascript:return isNumber (event)" readonly style="width:50px; text-align:center;"> to 
                        <input type="text" name="m4" id="m4" value='<s:property value="m4"/>' onkeypress="javascript:return isNumber (event)" onblur="change2();" style="width:50px; text-align:center;">
                    </td>
                    <td align="left"><input type="text" id="amt2" name="amt2" style="width:100px;" value='<s:property value="amt2"/>' onkeypress="javascript:return isNumber (event)" /></td>
                </tr>
                <tr>
                    <td align="right">
                        <input type="text" name="m5" id="m5" value='<s:property value="m5"/>' onkeypress="javascript:return isNumber (event)" readonly="true" style="width:50px; text-align:center;"> to 
                        <input type="text" name="m6" id="m6" value='<s:property value="m6"/>' onkeypress="javascript:return isNumber (event)" onblur="change3();" style="width:50px; text-align:center;">
                    </td>
                    <td align="left"><input type="text" id="amt3" name="amt3" style="width:100px;" value='<s:property value="amt3"/>' onkeypress="javascript:return isNumber (event)" /></td>
                </tr>
                <tr>
                    <td align="right">
                        <input type="text" name="m7" id="m7" value='<s:property value="m7"/>' onkeypress="javascript:return isNumber (event)" readonly="true" style="width:50px; text-align:center;"> to 
                        <input type="text" name="m8" id="m8" value='<s:property value="m8"/>' onkeypress="javascript:return isNumber (event)" onblur="change4();" style="width:50px; text-align:center;">
                    </td>
                    <td align="left"><input type="text" id="amt4" name="amt4" style="width:100px;" value='<s:property value="amt4"/>' onkeypress="javascript:return isNumber (event)" /></td>
                </tr>
                <tr>
                    <td align="right">
                        <input type="text" name="m9" id="m9" value='<s:property value="m9"/>' onkeypress="javascript:return isNumber (event)" readonly style="width:50px; text-align:center;"> to 
                        <input type="text" name="m10" id="m10" value='<s:property value="m10"/>' onkeypress="javascript:return isNumber (event)" style="width:50px; text-align:center;">
                    </td>
                    <td align="left"><input type="text" id="amt5" name="amt5" style="width:100px;" value='<s:property value="amt5"/>' onkeypress="javascript:return isNumber (event)" /></td>
                </tr>
            </table>
            </fieldset>
        </div>

        <div style="flex:1;">
            <fieldset style="margin-bottom:0;">
            <legend>Other Income</legend>
            <div id="newvehdiv" style="width:100%;">
                <jsp:include page="newvehdetails.jsp"></jsp:include>
            </div>
            </fieldset>
        </div>

    </div>
</div>

<div class="accordion-header" onclick="toggleAccordion(this)">
    <div class="accordion-left">
        <div class="accordion-number">6</div>
        <div class="accordion-title">Vehicle & Delivery Info</div>
    </div>
    <div class="accordion-arrow"></div>
</div>

<div class="accordion-content">
    <div style="display:flex; gap:20px;">
        
        <div style="flex:1;">
            <fieldset id="vehdetailsupdate" style="margin-bottom:0;">
                <legend>Vehicle Info</legend>
                
                <div style="display:flex; align-items:center; gap:10px; margin-bottom:10px; flex-wrap:wrap;">
                    <label>Temp Fleet</label>
                    <input type="text" readonly id="tempfleet" style="width:120px;" name="tempfleet" placeholder="Press F3 To Search" value='<s:property value="tempfleet"/>' onKeyDown="getvehinfo(2);">
                    
                    <label>Perm Fleet</label>
                    <input type="text" readonly id="permanentfleet" style="width:120px;" placeholder="Press F3 To Search" name="permanentfleet" value='<s:property value="permanentfleet"/>' onKeyDown="getvehinfo(1);">
                    
                    <input type="button" name="btnupdate" id="btnupdate" class="myButton" value="Edit" onclick="funupdate()">
                    <input type="button" name="leaseprintbtn" id="leaseprintbtn" class="myButton" value="Print" onclick="funPrintdown()">
                </div>
                
                <div style="display:flex; align-items:center; gap:10px; margin-bottom:10px;">
                    <label style="width:80px;">Fleet Details</label>
                    <input type="text" readonly name="fleetname" id="fleetname" value='<s:property value="fleetname"/>' style="flex:1;">
                </div>
                
                <div style="display:flex; align-items:center; gap:10px; flex-wrap:wrap;">
                    <label>OUT Date</label>
                    <div id="dateout" name="dateout"></div>
                    <input type="hidden" name="hiddateout" id="hiddateout" value='<s:property value="hiddateout"/>'>
                    
                    <label>Time</label>
                    <div id="timeout" name="timeout"></div>
                    <input type="hidden" name="hidtimeout" id="hidtimeout" value='<s:property value="hidtimeout"/>'>
                    
                    <label>KM</label>
                    <input type="text" name="kmout" id="kmout" style="width:80px;" value='<s:property value="kmout"/>' onkeypress="javascript:return isNumber (event)">
                    
                    <label>Fuel</label>
                    <select name="cmbfuelout" id="cmbfuelout" style="width:100px;">  
                        <option value="" selected>-Select-</option>
                        <option value=0.000 >Level 0/8</option>
                        <option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option>
                        <option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
                    </select>
                    <input type="hidden" name="hidcmbfuelout" id="hidcmbfuelout" value='<s:property value="hidcmbfuelout"/>'>
                    
                    <button type="button" title="Reset" class="icon" id="cleardata" onclick="clearvehdata()" value='<s:property value="cleardata"/>'>
                        <img alt="Reset" src="<%=contextPath%>/icons/cancel_new.png" style="width:16px; height:16px;"> 
                    </button>
                </div>
            </fieldset>
        </div>

        <div style="flex:1;">
            <fieldset id="delupdatefd" style="margin-bottom:0;">
                <legend>Delivery Details</legend>
                
                <div style="display:flex; align-items:center; gap:10px; margin-bottom:10px; flex-wrap:wrap;">
                    <input type="checkbox" id="chkdelivery" name="chkdelivery" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" onchange="fundelivarytick();">
                    <label>Delivery</label>
                    
                    <input type="text" readonly id="deldrvname" placeholder="Press F3 To Search" style="width:120px;" name="deldrvname" value='<s:property value="deldrvname"/>' onKeyDown="getdeldrv(event);">
                    
                    <label>Del.Charges</label>
                    <input type="text" id="delcharges" name="delcharges" style="width:100px; text-align:right;" value='<s:property value="delcharges" />' onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber (event)">
                </div>
                
                <div style="display:flex; align-items:center; gap:10px; flex-wrap:wrap;">
                    <label>Del Date</label>
                    <div id="deldateout" name="deldateout"></div>
                    <input type="hidden" name="hiddeldateout" id="hiddeldateout" value='<s:property value="hiddeldateout"/>'>
                    
                    <label>Del Time</label>
                    <div id="deltimeout" name="deltimeout"></div>
                    <input type="hidden" name="hiddeltimeout" id="hiddeltimeout" value='<s:property value="hiddeltimeout"/>'>
                    
                    <label>Del Km</label>
                    <input type="text" name="delkmout" id="delkmout" style="width:80px;" value='<s:property value="delkmout"/>' onblur="funchkKm();" onkeypress="javascript:return isNumber (event);">
                    
                    <label>Del Fuel</label>
                    <select name="cmbdelfuelout" id="cmbdelfuelout" style="width:100px;">
                        <option value="" selected>-Select-</option>
                        <option value=0.000 >Level 0/8</option>
                        <option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option>
                        <option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
                    </select>
                    
                    <input type="button" name="btndelupdate" id="btndelupdate" class="myButton" value="Edit" onclick="fundelupdate()">
                </div>
            </fieldset>
        </div>

    </div>
</div>

            </div> <input type="hidden" name="checkbranch" id="checkbranch" value='<s:property value="checkbranch"/>'>
            <input type="hidden" name="masterdoc_no" id="masterdoc_no" value='<s:property value="masterdoc_no"/>'>
            <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
            <input type="hidden" id="tariffgridlength" name="tariffgridlength"/>
            <input type="hidden" id="paymentgridlength" name="paymentgridlength"/> 
            <input type="hidden" id="drivergridlength" name="drivergridlength"/> 
            <input type="hidden" id="newvehdetalslenght" name="newvehdetalslenght"/>
            <input type="hidden" name="deldrvid" id="deldrvid" value='<s:property value="deldrvid"/>'  />
            <input type="hidden" name="delchkvalue" id="delchkvalue" value='<s:property value="delchkvalue"/>'  />
            <input type="hidden" name="chaffchkvalue" id="chaffchkvalue" value='<s:property value="chaffchkvalue"/>'  />
            <input type="hidden" name="add_drchk" id="add_drchk" value='<s:property value="add_drchk"/>'  />
            <input type="hidden" name="hidper_value" id="hidper_value" value='<s:property value="hidper_value"/>'  />
            <input type="hidden" name="hidper_name" id="hidper_name" value='<s:property value="hidper_name"/>'  />
            <input type="hidden" name="hidadvance_chk" id="hidadvance_chk" value='<s:property value="hidadvance_chk"/>'  />
            <input type="hidden" name="hidinvoice" id="hidinvoice" value='<s:property value="hidinvoice"/>'  />
            <input type="hidden" name="hidoutdate" id="hidoutdate" value='<s:property value="hidoutdate"/>'  />
            <input type="hidden" name="hidouttime" id="hidouttime" value='<s:property value="hidouttime"/>'  />
            <input type="hidden" name="hidcmbtype" id="hidcmbtype" value='<s:property value="hidcmbtype"/>'  />
            <input type="hidden" name="hiddeloutdate" id="hiddeloutdate" value='<s:property value="hiddeloutdate"/>'  />
            <input type="hidden" name="hiddelouttime" id="hiddelouttime" value='<s:property value="hiddelouttime"/>'  />
            <input type="hidden" name="hiddelcmbtype" id="hiddelcmbtype" value='<s:property value="hiddelcmbtype"/>'  />
            <input type="hidden" id="vehlocation" name="vehlocation" value='<s:property value="vehlocation"/>' />
            <input type="hidden" name="priormethod" id="priormethod">
            <input type="hidden" name="totalmasterqty" id="totalmasterqty">
            <input type="hidden" name="totalagmtqty" id="totalagmtqty">
            <input type="hidden" name="priorvalue" id="priorvalue">
            <input type="hidden" name="invruleoverride" id="invruleoverride">
            <input type="hidden" name="advchkval" id="advchkval" value='<s:property value="advchkval"/>'  /> 
            <input type="hidden" name="invval" id="invval" value='<s:property value="invval"/>' />
            <input type="hidden" id="configmethod" name="configmethod" value='<s:property value="configmethod"/>' />

        </form>

        <div id="windows2"><div style="background-color: #E0ECF8;"></div></div>  
        <div id="clientinfowindow"><div></div></div>
        <div id="driverinfowindow"><div></div></div>
        <div id="vehinfowindow"><div></div></div>
        <div id="chauffeurinfowindow"><div></div></div>
        <div id="deldrvwindow"><div></div></div>
        <div id="projectwindow"><div></div></div>
        <div id="masterrefnowindow"><div></div></div>

    </div>

<script>
document.addEventListener("DOMContentLoaded", function () {
    var masterDoc = document.getElementById("masterdoc_no");
    var isLoaded = (masterDoc && masterDoc.value && masterDoc.value > 0);

    const sections = document.querySelectorAll('.accordion-content');
    const headers = document.querySelectorAll('.accordion-header');

    sections.forEach((el, index) => {
        if (isLoaded) {
            el.style.display = 'block';
            if(headers[index]) headers[index].classList.add('active');
        } else {
            if (index === 0) {
                el.style.display = 'block';
                if(headers[index]) headers[index].classList.add('active');
            } else {
                el.classList.add('jqx-safe-hide');
                el.style.display = ''; 
                if(headers[index]) headers[index].classList.remove('active');
            }
        }
    });
});

function toggleAccordion(el) {
    const content = el.nextElementSibling;
    
    if (content.classList.contains('jqx-safe-hide')) {
        content.classList.remove('jqx-safe-hide');
        content.style.display = "block";
        el.classList.add("active");
        
        setTimeout(function() {
            $(window).trigger('resize');
            if (typeof $.fn.jqxGrid === 'function') {
                if ($("#jqxgrid2").length > 0) $("#jqxgrid2").jqxGrid('render');
                if ($("#rateGrid").length > 0) $("#rateGrid").jqxGrid('render');
                if ($("#jqxgridpayment").length > 0) $("#jqxgridpayment").jqxGrid('render');
                if ($("#nwevehgrid").length > 0) $("#nwevehgrid").jqxGrid('render');
            }
        }, 100);
        return;
    }

    const isOpen = content.style.display === "block";
    content.style.display = isOpen ? "none" : "block";
    el.classList.toggle("active", !isOpen);

    if (!isOpen) {
        setTimeout(function() {
            $(window).trigger('resize');
            if (typeof $.fn.jqxGrid === 'function') {
                if ($("#jqxgrid2").length > 0) $("#jqxgrid2").jqxGrid('render');
                if ($("#rateGrid").length > 0) $("#rateGrid").jqxGrid('render');
                if ($("#jqxgridpayment").length > 0) $("#jqxgridpayment").jqxGrid('render');
                if ($("#nwevehgrid").length > 0) $("#nwevehgrid").jqxGrid('render');
            }
        }, 100);
    }
}
</script>
</body>
</html>