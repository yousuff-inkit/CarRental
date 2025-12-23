<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="../../../../css/body.css"> 
<style>
    /* ------------------------------
       GLOBAL STYLES & LAYOUT (From Master)
    ------------------------------ */
    body {
        background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
        color: #222;
        margin: 0;
        padding: 32px 0;
        min-height: 100vh;
        box-sizing: border-box;
    }

    #mainBG {
        background: #fff;
        border-radius: 16px;
        padding: 20px;
        max-width: 100%;
        margin: auto;
        box-shadow: 0 4px 24px rgba(0,0,0,0.06);
        /* FORCE HEADER LEFT ALIGNMENT */
        text-align: left !important;
    }

    /* ------------------------------
       HEADER FIXES (Title & Buttons) (From Master)
    ------------------------------ */
    center {
        text-align: left !important;
        display: block;
        width: 100%;
        margin-left: 0;
    }

    #formdet {
        font-size: 24px !important;
        font-weight: 700 !important;
        color: #2c3e50;
        margin-bottom: 15px;
        display: block;
        text-align: left !important;
        font-family: 'Segoe UI', sans-serif;
    }

    /* ------------------------------
       GRID SYSTEM (FORM LAYOUT) (From Master)
    ------------------------------ */
    .receipt-header {
        display: grid;
        grid-template-columns: auto 1fr auto 1fr auto 1fr;
        gap: 15px;
        align-items: center;
        margin-bottom: 20px;
        padding: 0 0 0 5px;
    }

    .form-group {
        display: grid;
        grid-template-columns: 120px 1fr;
        align-items: center;
        gap: 12px;
        margin-bottom: 12px;
    }

    .form-group.dual-input {
        grid-template-columns: 120px 1fr 120px 1fr;
    }

    .form-group.triple-input {
        grid-template-columns: 120px 1fr 120px 1fr 120px 1fr;
    }

    .form-group.single-label-dual-input {
        grid-template-columns: 120px 1fr 1fr;
    }

    .section-row {
        display: flex;
        gap: 26px;
        margin-bottom: 30px;
        flex-wrap: wrap; /* Allows sections to wrap on smaller screens */
    }

    .section-block {
        flex: 1;
        background: #f6f8fa; /* Uniform background color */
        border-radius: 12px;
        padding: 20px;
        box-shadow: 0 1px 8px rgba(160,177,217,0.1);
        min-width: 45%; /* Ensures blocks have a minimum size before wrapping */
    }

    .full-width-block {
        flex: 1 1 100%; /* forces this block to take full width */
    }


    .section-block h2, .section-block legend {
        font-size: 1.1rem;

        margin: 0 0 20px;
        padding-left: 10px;
        border-left: 4px solid #007bff;
        color: #333;
        display: block;
    }

    .section-block legend {
        border: none;
        padding-left: 0;
        margin-bottom: 0;
    }

    /* ------------------------------
       INPUTS & CONTROLS (From Master)
    ------------------------------ */
    input[type="text"], select, textarea {
        height: 32px !important;
        border: 1px solid #d1d5db;
        border-radius: 6px;
        padding: 6px 10px;
        background: #fff;
        transition: border-color 0.2s;
        font-size: 14px;
        box-sizing: border-box;
        width: 100%;
    }

    input[type="text"]:focus, select:focus, textarea:focus {
        border-color: #007bff;
        outline: none;
    }

    input[readonly], textarea[readonly] {
        background-color: #f3f4f6;
        color: #6b7280;
    }

    label {
        font-weight: 600;
        color: #253858;
        white-space: nowrap;
        text-align: right;
        padding-right: 10px;
        font-size: 14px;
    }

    /* ------------------------------
       TABLES & UTILS (From Master)
    ------------------------------ */
    .myButton {
        background: #007bff; border: none; padding: 6px 16px; color: #fff;
        border-radius: 6px; cursor: pointer; font-weight: 600;
    }
    .myButton:hover { background: #0056b3; }

    /* SCROLLBAR FIX */
    .hidden-scrollbar { overflow: auto; height: 530px; }
    .hidden-scrollbar::-webkit-scrollbar { width: 0px; }

    /* CUSTOM STYLES FOR CUSTODY */
    /* Removed custom background colors */

    .inline-label-input {
        display: flex;
        align-items: center;
        gap: 10px;
    }
    .inline-label-input label {
        text-align: left;
        padding-right: 0;
        width: auto;
    }

    .two-col-group {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 12px;
        align-items: center;
    }

</style>
</head>
<script type="text/javascript">
$(document).ready(function () { 

//date definition 
$("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
$("#refdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
$("#dateout").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});

$("#hidevmovedate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
$("#hidevmovetime").jqxDateTimeInput({ width: '40%', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:null });
 

$("#colleteddate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null,enableBrowserBoundsDetection: true});
$("#indate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null,enableBrowserBoundsDetection: true});
$("#outdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null,enableBrowserBoundsDetection: true});
$("#deldate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null,enableBrowserBoundsDetection: true});
//time definition
 $("#timeout").jqxDateTimeInput({ width: '40%', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:null });

$("#deltime").jqxDateTimeInput({ width: '40%', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:null });
$("#collectedtime").jqxDateTimeInput({ width: '40%', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:null });
$("#intime").jqxDateTimeInput({ width: '40%', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:null });
$("#outtime").jqxDateTimeInput({ width: '40%', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:null });
 $('#collectionwindow').jqxWindow({ width: '60%', height: '54%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Driver Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
  $('#collectionwindow').jqxWindow('close');
  $('#agmtnowindow').jqxWindow({ width: '60%', height: '56%',  maxHeight: '75%' ,maxWidth: '80%' , title: 'Agreement Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#agmtnowindow').jqxWindow('close');
 
	$('#collectiondriver').dblclick(function(){
	    $('#collectionwindow').jqxWindow('open');
	$('#collectionwindow').jqxWindow('focus');
	 collectionSearchContent('driverSearchGrid.jsp?id=1', $('#collectionwindow'));
	});
	 	
	
 $('#deldriver').dblclick(function(){
   $('#collectionwindow').jqxWindow('open');
	$('#collectionwindow').jqxWindow('focus');
	collectionSearchContent('driverSearchGrid.jsp?id=2',  $('#collectionwindow'));
}); 
 
 
 $('#refno').dblclick(function(){
	 if(document.getElementById("mode").value=="view"){
		 return false;
	 }
	 
	 
	 if(document.getElementById("searchbranch").value==''){
		 document.getElementById("errormsg").innerText="Branch Is Mandatory";
		document.getElementById("searchbranch").focus();
		 return false;  
	 }
	 if(document.getElementById("cmbrentaltype").value==''){
		 document.getElementById("errormsg").innerText="Rental Type Is Mandatory";
		document.getElementById("cmbrentaltype").focus();
		 return false;  
	 }
	document.getElementById("errormsg").innerText="";
    $('#agmtnowindow').jqxWindow('open');
 agmtnoSearchContent('agmtnoSearch.jsp?rentalbranch='+document.getElementById("searchbranch").value, $('#agmtnowindow'));
});
 $('#date').on('change', function (event) {
	console.log(event);	  
     var maindate = $('#date').jqxDateTimeInput('getDate');
   	 if ($("#mode").val() == "A") {   
     funDateInPeriod(maindate);
   	 }
    });
 getTestLocation();

 
 $("#btnEdit").attr('disabled', true );
 //$("#btnDelete").attr('disabled', true );

 	$('#colleteddate,#indate,#outdate,#deldate').on('change', function (event) {
 		var maindate = event.args.date;
   		if ($("#mode").val() == "A") {   
     		funDateInPeriod(maindate);
   		}
	});
	
	$('#collectedtime,#intime,#outtime,#deltime').on('change', function (event) {
 		var maintime = event.args.date;
 		if ($("#mode").val() == "A") {
 			var maindate;
 			var targetid=$(event.currentTarget).attr('id');
 			if(targetid.includes('collectedtime')){
 				maindate=$('#colleteddate').jqxDateTimeInput('getDate');
 			}
 			else if(targetid.includes('intime')){
 				maindate=$('#indate').jqxDateTimeInput('getDate');
 			}
 			else if(targetid.includes('outtime')){
 				maindate=$('#outdate').jqxDateTimeInput('getDate');
 			}
 			else if(targetid.includes('deltime')){
 				maindate=$('#deldate').jqxDateTimeInput('getDate');
 			}
 			maindate.setHours(0,0,0,0);
 			maintime=new Date(maintime);
 			var curdate=new Date();
			curdate.setHours(0,0,0,0);
			if(maindate-curdate==0){
				funFutureTimeRestrict(maintime.getHours(),maintime.getMinutes(),event.currentTarget);	
			}
 			
   		}
	});
});

function funFutureTimeRestrict(hrs,mins,elm){
	var curtime=new Date();
	if(parseInt(hrs)>parseInt(curtime.getHours())){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Time cannot be greater than current time";
		$(elm).jqxDateTimeInput('focus');
		return false;
	}
	else if(parseInt(hrs)==parseInt(curtime.getHours())){
		if(parseInt(mins)>parseInt(curtime.getMinutes())){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Time cannot be greater than current time";
			$(elm).jqxDateTimeInput('focus');
			return false;	
		}
	}
	else{
		document.getElementById("errormsg").innerText="";
		return true;
	}
}
function getAgmtno(event){
	 if(document.getElementById("mode").value=="view"){
		 return false;
	 }
	 if(document.getElementById("searchbranch").value==''){
		 document.getElementById("errormsg").innerText="Branch Is Mandatory";
		document.getElementById("searchbranch").focus();
		 return false;  
	 }
	 
	 if(document.getElementById("cmbrentaltype").value==''){
		 document.getElementById("errormsg").innerText="Rental Type Is Mandatory";
		document.getElementById("cmbrentaltype").focus();
		 return false;  
	 }
	document.getElementById("errormsg").innerText="";
  
		 
	  var x= event.keyCode;
    if(x==114){
   	 $('#agmtnowindow').jqxWindow('open');
   	 agmtnoSearchContent('agmtnoSearch.jsp?rentalbranch='+document.getElementById("searchbranch").value, $('#agmtnowindow'));
    }
    else{
     }
}

function collectionSearchContent(url) {
    $.get(url).done(function (data) {
  $('#collectionwindow').jqxWindow('setContent', data);
}); 
}
function agmtnoSearchContent(url) {

	$.get(url).done(function (data) {
  $('#agmtnowindow').jqxWindow('setContent', data);
}); 
	
}



function getDriver(event,id){
	 var x= event.keyCode;
    if(x==114){
   	 $('#collectionwindow').jqxWindow('open');
   		$('#collectionwindow').jqxWindow('focus');
   		collectionSearchContent('driverSearchGrid.jsp?id='+id,  $('#collectionwindow'));
    }
    else{
     } 
}

function funReadOnly(){


	
	    $('#custody input').attr('readonly', true );
		$('#custody select').attr('disabled', true);
		$('#date').jqxDateTimeInput({ disabled: true});
		$('#refdate').jqxDateTimeInput({ disabled: true});
		$('#dateout').jqxDateTimeInput({ disabled: true});
		$('#timeout').jqxDateTimeInput({ disabled: true});
		
		
		$('#colleteddate').jqxDateTimeInput({ disabled: true});
		 $("#collection input").attr("disabled", true);
		 $("#collection select").attr("disabled", true);
		 
		 
			$('#deldate').jqxDateTimeInput({ disabled: true});
		 $("#delivery input").prop("disabled", true);
		 $("#delivery select").prop("disabled", true);
		 
			$('#colleteddate').jqxDateTimeInput({ disabled: true});
			$('#indate').jqxDateTimeInput({ disabled: true});
			$('#outdate').jqxDateTimeInput({ disabled: true});
			$('#deldate').jqxDateTimeInput({ disabled: true});
			
			$('#deltime').jqxDateTimeInput({ disabled: true});
			$('#collectedtime').jqxDateTimeInput({ disabled: true});
			$('#intime').jqxDateTimeInput({ disabled: true});
			$('#outtime').jqxDateTimeInput({ disabled: true});
		
			 
			$('#chkcollection').attr('disabled', true);
			
			
			 $("#branchout input").attr("readonly", true);
			 $("#branchout select").attr("disabled", true);
		
}

function funRemoveReadOnly(){
	
	
	 $("#branchout input").attr("disabled", true);
	 $("#branchout select").attr("disabled", true);
	 
	$('#chkcollection').attr('disabled', false);
	$('#chkdelivery').attr('disabled', true);

		$('#date').jqxDateTimeInput({ disabled: false});
		$('#refdate').jqxDateTimeInput({ disabled: true});
		$('#dateout').jqxDateTimeInput({ disabled: true});
		$('#timeout').jqxDateTimeInput({ disabled: true});
	
		
		        
		
	
		$('#indate').jqxDateTimeInput({ disabled: false});
		$('#intime').jqxDateTimeInput({ disabled: false});

		
		  $('#custody input').attr('readonly', false );
		$('#custody select').attr('disabled', false);
			
		$('#colleteddate').jqxDateTimeInput({ disabled: true});
		 $("#collection input").prop("disabled", true);
		 $("#collection select").prop("disabled", true);
		 
		 $('#deldate').jqxDateTimeInput({ disabled: true});
		 $("#delivery input").prop("disabled", true);
		 $("#delivery select").prop("disabled", true);
	
		if(document.getElementById("mode").value=="A"){
			
			$('#date').val(new Date());
				
		$('#docno').prop('readonly',true);
		$('#txtfleetno').prop('readonly',true);
		$('#txtfleetname').prop('readonly',true);
		$('#refname').prop('readonly',true);
		$('#refno').prop('readonly',true);
		$('#outkm').prop('readonly',true);
		$('#reason').prop('readonly',true);
	
 		$('#refdate').jqxDateTimeInput('setDate', null);
 		$('#dateout').jqxDateTimeInput('setDate', null);
 		$('#timeout').jqxDateTimeInput('setDate', null);
 	
 		
 		$('#colleteddate').jqxDateTimeInput('setDate', null);
 		$('#indate').jqxDateTimeInput('setDate', null);
 		$('#outdate').jqxDateTimeInput('setDate', null);
 		$('#deldate').jqxDateTimeInput('setDate', null);
 		
 		
 	
 		$('#collectedtime').jqxDateTimeInput('setDate', null);
 		$('#intime').jqxDateTimeInput('setDate', null);
 		$('#outtime').jqxDateTimeInput('setDate', null);
 		$('#deltime').jqxDateTimeInput('setDate', null);
 		 $("#branchout input").attr("disabled", true);
 		 $("#branchout select").attr("disabled", true);
		
 		$('#txtbranch').attr('readonly', true);
		$('#txtlocation').attr('readonly', true);
 		document.getElementById("reason").value="Custody";
	}
	
}

function getBranch() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items = items.split('***');
			var branchItems = items[0].split(",");
			var branchIdItems = items[1].split(",");
			var optionsbranch = '<option value="">--Select--</option>';
			for (var i = 0; i < branchItems.length; i++) {
				optionsbranch += '<option value="' + branchIdItems[i] + '">'
						+ branchItems[i] + '</option>';
			}
			$("select#inbranch").html(optionsbranch);
			
			if ($('#hidebranch').val() != null) {
				$('#inbranch').val($('#hidebranch').val());
			}
			
		
		} else {
		}
	}
	x.open("GET", "getBranch.jsp", true);
	x.send();
}


function getBranch1() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items = items.split('***');
			var branchItems = items[0].split(",");
			var branchIdItems = items[1].split(",");
			var optionsbranch = '<option value="">--Select--</option>';
			for (var i = 0; i < branchItems.length; i++) {
				optionsbranch += '<option value="' + branchIdItems[i] + '">'
						+ branchItems[i] + '</option>';
			}
			$("select#searchbranch").html(optionsbranch);
			
			if ($('#searchbranchval').val() != null) {
				$('#searchbranch').val($('#searchbranchval').val());
			}
			
		
		} else {
		}
	}
	x.open("GET", "getBranch.jsp", true);
	x.send();
}



function chkstatus() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			
			
			var items = x.responseText.trim();
			//alert(items);	
			if(items=="OUT")
				{
				$.messager.alert('Message','Fleet Is Not Available','warning');
				return 0;
				
				}
			else
				{
				
			items = items.split(',');
			var datein = items[0];
			var timein = items[1];
			var kmin = items[2];
			
		     $('#hidevmovedate').val(datein);
		     $('#hidevmovetime').val(timein);
		     $('#hidevmovekm').val(kmin);
			
			document.getElementById("outbranch").value="Update";
			$("#branchout input").prop("disabled", false);
			$("#branchout input").prop("readonly", false);
			 $("#branchout select").prop("disabled", false);
			 $('#outdate').jqxDateTimeInput({ disabled: false});
			  $('#outtime').jqxDateTimeInput({ disabled: false});
			  
			  return 0;
			
		
		} 
	}
	}
	x.open("GET", "validateDetails.jsp?fleetno="+document.getElementById("txtfleetno").value, true);
	x.send();
}











	function getLoc(value) {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items = items.split('***');
			var locationItems = items[0].split(",");
			var locationIdItems = items[1].split(",");
			var optionslocation = '<option value="">--Select--</option>';
			for (var i = 0; i < locationItems.length; i++) {
				optionslocation += '<option value="' + locationIdItems[i] + '">'
						+ locationItems[i] + '</option>';
			}
			$("select#inlocation").html(optionslocation);
			
			if ($('#hidelocation').val() != null) {
				$('#inlocation').val($('#hidelocation').val());
			}
			
		
		} else {
		}
	}
	x.open("GET", "getLoc.jsp?id="+value, true);
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
				
				$("select#inlocation").html(optionsloc);
		
				//alert("here");
				if ($('#hidelocation').val() != null) {
				$('#inlocation').val($('#hidelocation').val());
			}
				
			} else {
			}
		}
		x.open("GET", "getTestLocation.jsp", true);
		x.send();
  }  
function funReset(){
	//	$('#frmQuote')[0].reset(); 
	}
	
function funNotify(){	
	

		
		
		var maindate = $('#date').jqxDateTimeInput('getDate');
		   var validdate=funDateInPeriod(maindate);
		   if(validdate==0){
			   $('#date').jqxDateTimeInput('focus');
		   return 0; 
		   }
	    
		   if(document.getElementById("chkcollection").checked==true)
			{
		    	      
			var maindate1 = $('#colleteddate').jqxDateTimeInput('getDate');
			   var validdate1=funDateInPeriod(maindate1);
			   if(validdate1==0){
				   
				   $('#colleteddate').jqxDateTimeInput('focus');
				   
			   return 0; 
			   }
		    maindate1.setHours(0,0,0,0);
 			var maintime1=new Date($('#collectedtime').jqxDateTimeInput('getDate'));
 			var curdate=new Date();
			curdate.setHours(0,0,0,0);
			if(maindate1-curdate==0){
				var curtime=new Date();
				if(parseInt(maintime1.getHours())>parseInt(curtime.getHours())){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="Time cannot be greater than current time";
					$('#collectedtime').jqxDateTimeInput('focus');
					return 0;
				}
				else if(parseInt(maintime1.getHours())==parseInt(curtime.getHours())){
					if(parseInt(maintime1.getMinutes())>parseInt(curtime.getMinutes())){
						document.getElementById("errormsg").innerText="";
						document.getElementById("errormsg").innerText="Time cannot be greater than current time";
						$('#collectedtime').jqxDateTimeInput('focus');
						return 0;	
					}
				}
				else{
					document.getElementById("errormsg").innerText="";
					
				}
			}	
			}  
				var maindate2 = $('#indate').jqxDateTimeInput('getDate');
				   var validdate2=funDateInPeriod(maindate2);
				   if(validdate2==0){
					   
					   $('#indate').jqxDateTimeInput('focus');
					   
				   return 0; 
				   }
				   
				   maindate2.setHours(0,0,0,0);
 			var maintime2=new Date($('#intime').jqxDateTimeInput('getDate'));
 			var curdate=new Date();
			curdate.setHours(0,0,0,0);
			if(maindate2-curdate==0){
				var curtime=new Date();
				if(parseInt(maintime2.getHours())>parseInt(curtime.getHours())){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="Time cannot be greater than current time";
					$('#intime').jqxDateTimeInput('focus');
					return 0;
				}
				else if(parseInt(maintime2.getHours())==parseInt(curtime.getHours())){
					if(parseInt(maintime2.getMinutes())>parseInt(curtime.getMinutes())){
						document.getElementById("errormsg").innerText="";
						document.getElementById("errormsg").innerText="Time cannot be greater than current time";
						$('#intime').jqxDateTimeInput('focus');
						return 0;	
					}
				}
				else{
					document.getElementById("errormsg").innerText="";
					
				}
			}	
			    
	 			
		   
	    if(document.getElementById("cmbrentaltype").value==""){
			 document.getElementById("errormsg").innerText="Select Rental Type";
			document.getElementById("cmbrentaltype").focus();
			 return 0;  
		 }
	    else
	    	{
	    	 document.getElementById("errormsg").innerText="";
	    	}
	    if(document.getElementById("refno").value==""){
			 document.getElementById("errormsg").innerText="Select Ref No";
			document.getElementById("refno").focus();
			 return 0;  
		 }
	    else
	    	{
	    	 document.getElementById("errormsg").innerText="";
	    	}
	    if(document.getElementById("chkcollection").checked==true)
		{
	    	
		
	    if(document.getElementById("collectiondriver").value==""){
			 document.getElementById("errormsg").innerText="Select Driver";
			document.getElementById("collectiondriver").focus();
			 return 0;  
		 }
	    else
	    	{
	    	 document.getElementById("errormsg").innerText="";
	    	}
	    
	     var colleteddate=$('#colleteddate').jqxDateTimeInput('getDate');
		 var collectedtime=$('#collectedtime').jqxDateTimeInput('getDate');
		 if(colleteddate==null){
			 document.getElementById("errormsg").innerText="";
			 document.getElementById("errormsg").innerText="Collection Date Is Mandatory";
			 $('#colleteddate').jqxDateTimeInput('focus');
			 return 0;
		 }
		 if(collectedtime==null){
			 document.getElementById("errormsg").innerText="";
			 document.getElementById("errormsg").innerText="Collection Time Is Mandatory";
			 $('#collectedtime').jqxDateTimeInput('focus');
			 return 0;
		 }
		    if(document.getElementById("colletedkm").value==""){
				 document.getElementById("errormsg").innerText="Enter Collection KM ";
				document.getElementById("colletedkm").focus();
				 return 0;  
			 }
		    else
		    	{
		    	 document.getElementById("errormsg").innerText="";
		    	}
		    if(document.getElementById("collectedfuel").value==""){
				 document.getElementById("errormsg").innerText="Select Collection Fuel";
				document.getElementById("collectedfuel").focus();
				 return 0;  
			 }
		    else
		    	{
		    	 document.getElementById("errormsg").innerText="";
		    	}
		}
	   // colleteddate,collectedtime,colletedkm,collectedfuel
	    
	    if(document.getElementById("inbranch").value==""){
			 document.getElementById("errormsg").innerText="Select Branch";
			document.getElementById("inbranch").focus();
			 return 0;  
		 }
	    else
	    	{
	    	 document.getElementById("errormsg").innerText="";
	    	}
	    if(document.getElementById("inlocation").value==""){
			 document.getElementById("errormsg").innerText="Select Location";
			document.getElementById("inlocation").focus();
			 return 0;  
		 }
	    else
	    	{
	    	 document.getElementById("errormsg").innerText="";
	    	}
	    var indate=$('#indate').jqxDateTimeInput('getDate');
		 var intime=$('#intime').jqxDateTimeInput('getDate');
		 if(indate==null){
			 document.getElementById("errormsg").innerText="";
			 document.getElementById("errormsg").innerText="In Date Is Mandatory";
			 $('#indate').jqxDateTimeInput('focus');
			 return 0;
		 }
		 if(intime==null){
			 document.getElementById("errormsg").innerText="";
			 document.getElementById("errormsg").innerText="In Time Is Mandatory";
			 $('#intime').jqxDateTimeInput('focus');
			 return 0;
		 }
		    if(document.getElementById("binkm").value==""){
				 document.getElementById("errormsg").innerText="Enter In KM ";
				document.getElementById("binkm").focus();
				 return 0;  
			 }
		    else
		    	{
		    	 document.getElementById("errormsg").innerText="";
		    	}
		    if(document.getElementById("binfuel").value==""){
				 document.getElementById("errormsg").innerText="Select In Fuel";
				document.getElementById("binfuel").focus();
				 return 0;  
			 }
		    else
		    	{
		    	 document.getElementById("errormsg").innerText="";
		    	}
		    if(document.getElementById("chkcollection").checked==true)
					{ 
		    /* 	dateout timeout-=colleteddate,collectedtime */ 
		    	
					
							  if ($("#mode").val() == "A") 
							     {  var dateout1=new Date($('#colleteddate').jqxDateTimeInput('getDate'));
							  	 	var timeout1=$('#collectedtime').jqxDateTimeInput('getDate');
							  		var dateouthidden1=new Date($('#dateout').jqxDateTimeInput('getDate'));
							  		var timeouthidden1=$('#timeout').jqxDateTimeInput('getDate');
							  		
							  	  		dateout1.setHours(0,0,0,0);
							  		dateouthidden1.setHours(0,0,0,0);
							  		
							  		
							  		if(dateout1<dateouthidden1){
							 
							  			document.getElementById("errormsg").innerText="";
							  			document.getElementById("errormsg").innerText="Collection Date Cannot be Less than Out Date";
							  			$('#colleteddate').jqxDateTimeInput('focus'); 
							  	  			return 0;	
							  			
							  		}
							  		if(dateout1-dateouthidden1==0){
											
								  			if(timeout1.getHours() < timeouthidden1.getHours()){
								  				document.getElementById("errormsg").innerText="";
								  				document.getElementById("errormsg").innerText="Collection Time Cannot be Less than Out Time";
								  				$('#collectedtime').jqxDateTimeInput('focus'); 
								  				return 0;
								  			}
								  			if(timeout1.getHours() == timeouthidden1.getHours()){
								  			if(timeout1.getMinutes() < timeouthidden1.getMinutes()){
								  				document.getElementById("errormsg").innerText="";
								  				document.getElementById("errormsg").innerText="Collection Time Cannot be Less than Out Time";
								  				$('#collectedtime').jqxDateTimeInput('focus');
								  				return 0;
								  			}
								  			}
								  			
								  			else{
								  				document.getElementById("errormsg").innerText="";
								  			}
								  		}
							  
							  		
							  		
							  		
								  	var outkm=document.getElementById("outkm").value;
					        	 	var colkm=document.getElementById("colletedkm").value;
					        	 	
					        	    if((parseFloat(colkm)<parseFloat(outkm)))
					        		   
					        	 	
					        	 	{
					        		  
					        		   document.getElementById("errormsg").innerText="Collection KM Less Than Out KM";  
					        		   document.getElementById("colletedkm").focus();
					        		   return 0;
					        	 	}		
							  	 
											   
					        }
					}
		 	   else
		    		{
		    	
							    	 if ($("#mode").val() == "A") 
								     {    
							    		 
							    		 
							    		 
							    		 
							    		 
							    		 var dateout1=new Date($('#indate').jqxDateTimeInput('getDate'));
									  	 	var timeout1=$('#intime').jqxDateTimeInput('getDate');
									  		var dateouthidden1=new Date($('#dateout').jqxDateTimeInput('getDate'));
									  		var timeouthidden1=$('#timeout').jqxDateTimeInput('getDate');
									  		
									  	  		dateout1.setHours(0,0,0,0);
									  		dateouthidden1.setHours(0,0,0,0);
									  		
									  		
									  		if(dateout1<dateouthidden1){
									 
									  			document.getElementById("errormsg").innerText="";
									  			document.getElementById("errormsg").innerText="In Date Cannot be Less than Out Date";
									  			$('#indate').jqxDateTimeInput('focus'); 
									  	  			return 0;	
									  			
									  		}
									  		if(dateout1-dateouthidden1==0){
													
										  			if(timeout1.getHours() < timeouthidden1.getHours()){
										  				document.getElementById("errormsg").innerText="";
										  				document.getElementById("errormsg").innerText="In Time Cannot be Less than Out Time";
										  				$('#intime').jqxDateTimeInput('focus'); 
										  				return 0;
										  			}
										  			if(timeout1.getHours() == timeouthidden1.getHours()){
										  			if(timeout1.getMinutes() < timeouthidden1.getMinutes()){
										  				document.getElementById("errormsg").innerText="";
										  				document.getElementById("errormsg").innerText="In Time Cannot be Less than Out Time";
										  				$('#intime').jqxDateTimeInput('focus');
										  				return 0;
										  			}
										  			}
										  			
										  			else{
										  				document.getElementById("errormsg").innerText="";
										  			}
							    		 
												
								  
					                           }
				    	
										  	var outkm=document.getElementById("outkm").value;
							        	 	var inkm=document.getElementById("binkm").value;
							        	 	
							        	    if((parseFloat(inkm)<parseFloat(outkm)))
							        		   
							        	 	
							        	 	{
							        		  
							        		   document.getElementById("errormsg").innerText="In KM Less Than Out KM";  
							        		   document.getElementById("binkm").focus();
							        		   return 0;
							        	 	}
		    	
								     }
							 }
		    
		    
		    
		    
		    if(document.getElementById("chkcollection").checked==true)
			{ 
    /* 	dateout timeout-=colleteddate,collectedtime */ 
    	
			
					  if ($("#mode").val() == "A") 
					     {      var dateout1=new Date($('#indate').jqxDateTimeInput('getDate'));
					  	 	    var timeout1=$('#intime').jqxDateTimeInput('getDate');
					  		    var dateouthidden1=new Date($('#colleteddate').jqxDateTimeInput('getDate'));
					  		   var timeouthidden1=$('#collectedtime').jqxDateTimeInput('getDate');
					  		
					  	  		dateout1.setHours(0,0,0,0);
					  		dateouthidden1.setHours(0,0,0,0);
					  		
					  		
					  		if(dateout1<dateouthidden1){
					 
					  			document.getElementById("errormsg").innerText="";
					  			document.getElementById("errormsg").innerText="In Date Cannot be Less than Collection Date";
					  			$('#indate').jqxDateTimeInput('focus'); 
					  	  			return 0;	
					  			
					  		}
					  		if(dateout1-dateouthidden1==0){
									
						  			if(timeout1.getHours() < timeouthidden1.getHours()){
						  				document.getElementById("errormsg").innerText="";
						  				document.getElementById("errormsg").innerText="In Time Cannot be Less than Collection Time";
						  				$('#intime').jqxDateTimeInput('focus'); 
						  				return 0;
						  			}
						  			if(timeout1.getHours() == timeouthidden1.getHours()){
						  			if(timeout1.getMinutes() < timeouthidden1.getMinutes()){
						  				document.getElementById("errormsg").innerText="";
						  				document.getElementById("errormsg").innerText="In Time Cannot be Less than Collection Time";
						  				$('#intime').jqxDateTimeInput('focus');
						  				return 0;
						  			}
						  			}
						  			
						  			else{
						  				document.getElementById("errormsg").innerText="";
						  			}
						  		}
					  		
					  		var colkm=document.getElementById("colletedkm").value;
			        	 	var inkm=document.getElementById("binkm").value;
			        	 	
			        	    if((parseFloat(inkm)<parseFloat(colkm)))
			        		   
			        	 	
			        	 	{
			        		  
			        		   document.getElementById("errormsg").innerText="In KM Less Than Collection KM";  
			        		   document.getElementById("binkm").focus();
			        		   return 0;
			        	 	}
									   
			     }
			}
		    
		    $('#date').jqxDateTimeInput({ disabled: false});
			$('#refdate').jqxDateTimeInput({ disabled: false});
			$('#dateout').jqxDateTimeInput({ disabled: false});
			$('#timeout').jqxDateTimeInput({ disabled: false});
		    $('#cmbfuel').prop('disabled',false);
	return 1;
	
}


function funSearchLoad(){
	 changeContent('mainSearch.jsp'); 
}

	
function funFocus(){
	
	document.getElementById("searchbranch").focus();
	
   		
}
function setValues() {
	funSetlabel();
	document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	
	
	if($('#hidedate').val()){
		$("#date").jqxDateTimeInput('val', $('#hidedate').val());
	}
		if($('#hiderefdate').val()){
		$("#refdate").jqxDateTimeInput('val', $('#hiderefdate').val());
	}
		if($('#hideroutdate').val()){
		$("#dateout").jqxDateTimeInput('val', $('#hideroutdate').val());
	}
		
		if($('#hidertimeout').val()){
		$("#timeout").jqxDateTimeInput('val', $('#hidertimeout').val());
	}
		
	
		if ($('#renttypeval').val() != null) {
            $('#cmbrentaltype').val($('#renttypeval').val());
       }
		if ($('#rfuelval').val() != null) {
			$('#cmbfuel').val($('#rfuelval').val());
		}
		
		if($('#hidcollectedTime').val()){
			$("#collectedtime").jqxDateTimeInput('val', $('#hidcollectedTime').val());
		}
			
			if($('#hideIntime').val()){
			$("#intime").jqxDateTimeInput('val', $('#hideIntime').val());
		}
			
			
			if ($('#hidcollectedFuelval').val() != null) {
	            $('#collectedfuel').val($('#hidcollectedFuelval').val());
	       }
			if ($('#inFuelval').val() != null) {
				$('#binfuel').val($('#inFuelval').val());
			}	
			
			if($('#hidcollecteddate').val()){
				$("#colleteddate").jqxDateTimeInput('val', $('#hidcollecteddate').val());
			}
				
				if($('#hideIndate').val()){
				$("#indate").jqxDateTimeInput('val', $('#hideIndate').val());
			}
				
				if($('#hidouttime').val()){
					$("#outtime").jqxDateTimeInput('val', $('#hidouttime').val());
				}
					
					if($('#hidoutdate').val()){
					$("#outdate").jqxDateTimeInput('val', $('#hidoutdate').val());
				}
					if ($('#outfuelval').val() != null) {
						$('#boutfuel').val($('#outfuelval').val());
					}	
				   
			
					if($('#hiddeltime').val()){
						$("#deltime").jqxDateTimeInput('val', $('#hiddeltime').val());
					}
						
						if($('#hiddeldate').val()){
						$("#deldate").jqxDateTimeInput('val', $('#hiddeldate').val());
					}
						if ($('#hiddelfuelval').val() != null) {
							$('#delfuel').val($('#hiddelfuelval').val());
						}	
				
						if ($('#delyornval').val() != null) {
							$('#delyesorno').val($('#delyornval').val());
						}		
	
						
						
					   
					
					
		
	        if(parseInt(document.getElementById("collectintickval").value)>0)
	        	{
	        	
	        	document.getElementById("chkcollection").checked=true;
	    
	        	if(document.getElementById("mode").value=="A")
	        		
	        		{
	        		
	        		$("#collection input").prop("disabled", false);
	       		    $("#collection select").prop("disabled", false);
	       		   $('#colleteddate').jqxDateTimeInput({ disabled: false});
	       		   $('#collectedtime').jqxDateTimeInput({ disabled: false});
	       	
	        		
	        		}
	        	
	        	}
		
	        
        	
        	 if(document.getElementById("mode").value=="view")
        		
    		{
        		 if(parseInt(document.getElementById("delyornval").value)>0)
             	{
        				$('#chkdelivery').attr('disabled', false);	 
        	}
        		 else
        			 {
        				$('#chkdelivery').attr('disabled', true);
        			 }
        		 if(parseInt(document.getElementById("branchoutval").value)>0)
              	{
         				$('#outbranch').attr('disabled', true);	 
             	}
         		 else
         			 {
         				$('#outbranch').attr('disabled', false);
         			 }
         		  
        		 
        		 
        	}

	        if(parseInt(document.getElementById("delchkval").value)>0)
        	{
        	
        	document.getElementById("chkdelivery").checked=true;
        	if(document.getElementById("mode").value=="view")
        		
    		{
        	$('#chkdelivery').attr('disabled', true);
        	}
        	} 
		
		
		if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		
		
	if($('#extramsg').val()!=''){
		document.getElementById("errormsg").innerText=$('#extramsg').val();
	}
}

function checkCollection()
{
	if(document.getElementById("chkcollection").checked==true)
		{
		$('#collectiondriver').attr('readonly', true );
		$("#collection input").prop("disabled", false);
		 $("#collection select").prop("disabled", false);
		$('#colleteddate').jqxDateTimeInput({ disabled: false});
		  $('#collectedtime').jqxDateTimeInput({ disabled: false});
		document.getElementById("collectintickval").value=1;	
			
			
		}
	else
		{
		
		$("#collection input").prop("disabled", true);
		 $("#collection select").prop("disabled", true);
		 $('#colleteddate').jqxDateTimeInput({ disabled: true});
		  $('#collectedtime').jqxDateTimeInput({ disabled: true});
		 document.getElementById("collectintickval").value=0;	
		}
	
	}
	
function checkDelivery()
{
	if(document.getElementById("chkdelivery").checked==true)
		{
		
		$("#delivery input").prop("disabled", false);
		$("#delivery select").prop("disabled", false);
		$("#delivery input").prop("readonly", false);
		$("#deldriver").prop("readonly", true);
		
		$('#deldate').jqxDateTimeInput({ disabled: false});
		  $('#deltime').jqxDateTimeInput({ disabled: false});
		  
		  document.getElementById("delchkval").value=1;	  
		  document.getElementById("delupdate").value="Update";
		  
		}
	else
		{
		
		$("#delivery input").prop("disabled", true);
		$("#delivery select").prop("disabled", true);
		$('#deldate').jqxDateTimeInput({ disabled: true});
		  $('#deltime').jqxDateTimeInput({ disabled: true});
		  document.getElementById("delchkval").value=0;	 
		  document.getElementById("delupdate").value="Edit";
		}
	
	}
function funoutupdate()
     {
	if(document.getElementById("docno").value=="")
		
	{
	
	$.messager.alert('Message','Select a Document....!','warning');
	return 0;
	}
	
	
	
	if(document.getElementById("outbranch").value=="Update")
	{
		
		
		$('#colleteddate').jqxDateTimeInput({ disabled: false});
		 $("#collection input").prop("disabled", false);
		 $("#collection select").prop("disabled", false);
		 
		 outdate,outtime,boutkm,boutfuel,delyesorno
		  var outdate=$('#outdate').jqxDateTimeInput('getDate');
			 var outtime=$('#outtime').jqxDateTimeInput('getDate');
			 if(outdate==null){
				 document.getElementById("errormsg").innerText="";
				 document.getElementById("errormsg").innerText="Out Date Is Mandatory";
				 $('#outdate').jqxDateTimeInput('focus');
				 return 0;
			 }
			 if(outtime==null){
				 document.getElementById("errormsg").innerText="";
				 document.getElementById("errormsg").innerText="Out Time Is Mandatory";
				 $('#outtime').jqxDateTimeInput('focus');
				 return 0;
			 }
			 
			    
			 
			    	      
				var maindate1 = $('#outdate').jqxDateTimeInput('getDate');
				   var validdate1=funDateInPeriod(maindate1);
				   if(validdate1==0){
					   $('#outdate').jqxDateTimeInput('focus');
				   return 0; 
				   }
			    maindate1.setHours(0,0,0,0);
 				var maintime1=new Date($('#outtime').jqxDateTimeInput('getDate'));
 				var curdate=new Date();
				curdate.setHours(0,0,0,0);
				if(maindate1-curdate==0){
					var curtime=new Date();
					if(parseInt(maintime1.getHours())>parseInt(curtime.getHours())){
						document.getElementById("errormsg").innerText="";
						document.getElementById("errormsg").innerText="Time cannot be greater than current time";
						$('#outtime').jqxDateTimeInput('focus');
						return 0;
					}
					else if(parseInt(maintime1.getHours())==parseInt(curtime.getHours())){
						if(parseInt(maintime1.getMinutes())>parseInt(curtime.getMinutes())){
							document.getElementById("errormsg").innerText="";
							document.getElementById("errormsg").innerText="Time cannot be greater than current time";
							$('#outtime').jqxDateTimeInput('focus');
							return 0;
						}
					}
					else{
						document.getElementById("errormsg").innerText="";
					}
				}
				 
			    if(document.getElementById("boutkm").value==""){
					 document.getElementById("errormsg").innerText="Enter Out KM ";
					document.getElementById("boutkm").focus();
					 return 0;  
				 }
			    else
			    	{
			    	 document.getElementById("errormsg").innerText="";
			    	}
			    if(document.getElementById("boutfuel").value==""){
					 document.getElementById("errormsg").innerText="Select Out Fuel";
					document.getElementById("boutfuel").focus();
					 return 0;  
				 }
			    else
			    	{
			    	 document.getElementById("errormsg").innerText="";
			    	}
			    if(document.getElementById("delyesorno").value==""){
					 document.getElementById("errormsg").innerText="Choose One Option ";
					document.getElementById("delyesorno").focus();
					 return 0;  
				 }
			    else
			    	{
			    	 document.getElementById("errormsg").innerText="";
			    	}
			    
			    
			  //  hidevmovedate hidevmovetime hidevmovekm
			    //-----------------
			  ///  outdate  outtime
				      var dateout1=new Date($('#outdate').jqxDateTimeInput('getDate'));
				  	 	    var timeout1=$('#outtime').jqxDateTimeInput('getDate');
				  		    var dateouthidden1=new Date($('#hidevmovedate').jqxDateTimeInput('getDate'));
				  		   var timeouthidden1=$('#hidevmovetime').jqxDateTimeInput('getDate');
				  		
				  	  		dateout1.setHours(0,0,0,0);
				  		dateouthidden1.setHours(0,0,0,0);
				  		
				  		
				  		if(dateout1<dateouthidden1){
				 
				  			document.getElementById("errormsg").innerText="";
				  			document.getElementById("errormsg").innerText="Out Date Cannot be Less Than  In Date";
				  			$('#outdate').jqxDateTimeInput('focus'); 
				  	  			return 0;	
				  			
				  		}
				  		if(dateout1-dateouthidden1==0){
								
					  			if(timeout1.getHours() < timeouthidden1.getHours()){
					  				document.getElementById("errormsg").innerText="";
					  				document.getElementById("errormsg").innerText="Out Time Cannot be Less Than  In Time";
					  				$('#outtime').jqxDateTimeInput('focus'); 
					  				return 0;
					  			}
					  			if(timeout1.getHours() == timeouthidden1.getHours()){
					  			if(timeout1.getMinutes() < timeouthidden1.getMinutes()){
					  				document.getElementById("errormsg").innerText="";
					  				document.getElementById("errormsg").innerText="Out Time Cannot be Less Than  In Time";
					  				$('#outtime').jqxDateTimeInput('focus');
					  				return 0;
					  			}
					  			}
					  			
					  			else{
					  				document.getElementById("errormsg").innerText="";
					  			}
					  		}
				  		
				  		var colkm=document.getElementById("hidevmovekm").value;
		        	 	var inkm=document.getElementById("boutkm").value;
		        	 	
		        	    if((parseFloat(inkm)<parseFloat(colkm)))
		        		   
		        	 	
		        	 	{
		        		  
		        		   document.getElementById("errormsg").innerText="Out KM Less Than  In KM";  
		        		   document.getElementById("boutkm").focus();
		        		   return 0;
		        	 	}
								   
		        	    $('#searchbranch').attr('disabled',false);
		        	    $.messager.confirm('Confirm', 'Do you want to update changes?', function(r){
		        			if (r){

		        				  document.getElementById("mode").value="OUT";
		        				  document.getElementById("custody").submit();
		        			}
		        	 		});	        		
		
	}
	else
		{
		chkstatus();

	
		}
	}
	
	
	function funcleardatas()
	{
		
		
		document.getElementById("masterrefno").value="";
		document.getElementById("refno").value="";
		document.getElementById("txtfleetno").value="";
		document.getElementById("outkm").value="";
		document.getElementById("cmbfuel").value="";
		document.getElementById("txtbranch").value="";
		document.getElementById("txtlocation").value="";

		document.getElementById("refname").value="";
		document.getElementById("txtfleetname").value="";
		// txtfleetno  outkm cmbfuel txtbranch txtlocation    mainbranchid mainlocationid infleettrancode
		//refname txtfleetname
		
		
 		$('#refdate').jqxDateTimeInput('setDate', null);
 		$('#dateout').jqxDateTimeInput('setDate', null);
 		$('#timeout').jqxDateTimeInput('setDate', null);
		
	}
	
	
function fundelUpdate()
{

	 if(document.getElementById("deldriver").value==""){
		 document.getElementById("errormsg").innerText="Select Driver ";
		document.getElementById("deldriver").focus();
		 return 0;  
	 }
    else
    	{
    	 document.getElementById("errormsg").innerText="";
    	}
	
	 if(document.getElementById("deliveryto").value==""){
		 document.getElementById("errormsg").innerText="Enter Deliver To ";
		document.getElementById("deliveryto").focus();
		 return 0;  
	 }
    else
    	{
    	 document.getElementById("errormsg").innerText="";
    	}
	
		
	 var deldate=$('#deldate').jqxDateTimeInput('getDate');
	 var deltime=$('#deltime').jqxDateTimeInput('getDate');
	 if(deldate==null){
		 document.getElementById("errormsg").innerText="";
		 document.getElementById("errormsg").innerText="Delivery Date Is Mandatory";
		 $('#deldate').jqxDateTimeInput('focus');
		 return 0;
	 }
	 if(deltime==null){
		 document.getElementById("errormsg").innerText="";
		 document.getElementById("errormsg").innerText="Delivery Time Is Mandatory";
		 $('#deltime').jqxDateTimeInput('focus');
		 return 0;
	 }
	    if(document.getElementById("delkm").value==""){
			 document.getElementById("errormsg").innerText="Enter Delivery KM ";
			document.getElementById("delkm").focus();
			 return 0;  
		 }
	    else
	    	{
	    	 document.getElementById("errormsg").innerText="";
	    	}
	    if(document.getElementById("delfuel").value==""){
			 document.getElementById("errormsg").innerText="Select Delivery Fuel";
			document.getElementById("delfuel").focus();
			 return 0;  
		 }
	    else
	    	{
	    	 document.getElementById("errormsg").innerText="";
	    	}
	
		var maindate1 = $('#deldate').jqxDateTimeInput('getDate');
		   var validdate1=funDateInPeriod(maindate1);
		   if(validdate1==0){
			   $('#deldate').jqxDateTimeInput('focus');
			   
		   return 0; 
		   }
	    
		 
	    
	    //-------------------------
	  //  deldate,deltime,delkm
	      var dateout1=new Date($('#deldate').jqxDateTimeInput('getDate'));
	 	    var timeout1=$('#deltime').jqxDateTimeInput('getDate');
		    var dateouthidden1=new Date($('#outdate').jqxDateTimeInput('getDate'));
		   var timeouthidden1=$('#outtime').jqxDateTimeInput('getDate');
		
	  		dateout1.setHours(0,0,0,0);
		dateouthidden1.setHours(0,0,0,0);
		
		
		if(dateout1<dateouthidden1){

			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Delivery Date Cannot be Less than Out Date";
			$('#deldate').jqxDateTimeInput('focus'); 
	  			return 0;	
			
		}
		if(dateout1-dateouthidden1==0){
				
	  			if(timeout1.getHours() < timeouthidden1.getHours()){
	  				document.getElementById("errormsg").innerText="";
	  				document.getElementById("errormsg").innerText="Delivery Time Cannot be Less than Out Time";
	  				$('#deltime').jqxDateTimeInput('focus'); 
	  				return 0;
	  			}
	  			if(timeout1.getHours() == timeouthidden1.getHours()){
	  			if(timeout1.getMinutes() < timeouthidden1.getMinutes()){
	  				document.getElementById("errormsg").innerText="";
	  				document.getElementById("errormsg").innerText="Delivery Time Cannot be Less than Out Time";
	  				$('#deltime').jqxDateTimeInput('focus');
	  				return 0;
	  			}
	  			}
	  			
	  			else{
	  				document.getElementById("errormsg").innerText="";
	  			}
	  		}
		
		var outkm=document.getElementById("boutkm").value;
	 	var delkm=document.getElementById("delkm").value;
	 	
	    if((parseFloat(delkm)<parseFloat(outkm)))
		   
	 	
	 	{
		  
		   document.getElementById("errormsg").innerText="Delivery KM Less Than Out KM";  
		   document.getElementById("delkm").focus();
		   return 0;
	 	}
	    
	    
	    
	    $.messager.confirm('Confirm', 'Do you want to update changes?', function(r){
			if (r){
				$('#overlay,#PleaseWait').show();
				$('#colleteddate').jqxDateTimeInput({ disabled: false});
				$("#collection input").prop("disabled", false);
				$("#collection select").prop("disabled", false);
				$('#searchbranch').attr('disabled',false);
				document.getElementById("mode").value="DLY";
				document.getElementById("custody").submit();
					
			}
	 	});
	    
	    
	    


	}
function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
    	{
 	   document.getElementById("errormsg").innerText=" Enter Numbers Only";  
       
        return false;
    	}
    document.getElementById("errormsg").innerText="";  
    return true;
}


function funPrintBtn(){
	   if (($("#mode").val() == "view") && $("#docno").val()!="") { 
	  
	      
	   var url=document.URL;
  var reurl=url.split("saveCustody");
 var win= window.open(reurl[0]+"printCustody?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
win.focus(); 
	    } 
	  
	   else {
 	      $.messager.alert('Message','Select a Document....!','warning');
 	      return false;
 	     } 
 	
	} 

</script>

<body onload="setValues();getBranch();getBranch1();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="custody" action="saveCustody" autocomplete="off">
	<%-- <script>
			window.parent.formName.value="Replacement";
			window.parent.formCode.value="RPL";
	</script> --%>
	<jsp:include page="../../../../header.jsp" />

<div class='hidden-scrollbar'>

    <div class="section-block full-width-block">
        <h2>Vehicle Custody</h2>

        <div class="form-group dual-input" style="grid-template-columns: 120px 1fr 120px 1fr 120px 1fr;">
            <label>Date</label>
            <div>
                <div id="date" name="date" value='<s:property value="date"/>'></div>
            </div>

            <label>Branch</label>
            <select name="searchbranch" id="searchbranch" value='<s:property value="searchbranch"/>'><option value="">--Select--</option></select>

            <label>Doc No</label>
            <input type="text" id="docno" name="docno" tabindex="-1" readonly value='<s:property value="docno"/>'/>
        </div>

        <div class="form-group dual-input">
            <label>Rental Type</label>
            <select id="cmbrentaltype" name="cmbrentaltype" onchange="funcleardatas()" value='<s:property value="cmbrentaltype"/>'>
                <option value="">--Select--</option><option value="RAG">Rental</option><option value="LAG">Lease</option>
            </select>

            <label>Ref No</label>
            <div class="two-col-group">
                <input type="text" id="refno" name="refno" value='<s:property value="refno"/>' placeholder="Press F3 to Search" readonly onkeydown="getAgmtno(event);"/>
                <input type="text" id="refname" name="refname" value='<s:property value="refname"/>' readonly/>
            </div>
        </div>

        <div class="form-group dual-input">
            <label>Ref Date</label>
            <div>
                <div id='refdate' name='refdate' value='<s:property value="refdate"/>'></div>
            </div>

            <label>Fleet No</label>
            <div class="two-col-group">
                <input type="text" id="txtfleetno" name="txtfleetno" value='<s:property value="txtfleetno"/>' readonly />
                <input type="text" id="txtfleetname" name="txtfleetname" value='<s:property value="txtfleetname"/>' readonly/>
            </div>
        </div>

        <div class="form-group dual-input">
            <label>Date Out</label>
            <div>
                <div id="dateout" name="dateout" value='<s:property value="dateout"/>'></div>
            </div>

            <label>Time Out</label>
            <div>
                <div id="timeout" name="timeout" value='<s:property value="timeout"/>'></div>
            </div>
        </div>

        <div class="form-group dual-input">
            <label>Km Out</label>
            <input type="text" id="outkm" name="outkm" value='<s:property value="outkm"/>' readonly onkeypress="javascript:return isNumber (event)"/>

            <label>Fuel</label>
            <select id="cmbfuel" name="cmbfuel" value='<s:property value="cmbfuel"/>'>
                <option value="">--Select--</option><option value=0.000>Level 0/8</option><option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option>
                <option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
            </select>
        </div>

        <div class="form-group dual-input">
            <label>Branch</label>
            <input type="text" name="txtbranch" id="txtbranch" readonly value='<s:property value="txtbranch"/>'/>

            <label>Location</label>
            <input type="text" name="txtlocation" id="txtlocation" readonly value='<s:property value="txtlocation"/>'/>
        </div>

        <div class="form-group">
            <label>Tr. Reason</label>
            <input type="text" id="reason" name="reason" readonly value='<s:property value="reason"/>'>
        </div>

        <div class="form-group">
            <label>Description</label>
            <input type="text" name="descnew" id="descnew" value='<s:property value="descnew"/>'>
        </div>
    </div>


    <div class="section-row">
        <div class="section-block" id="collection">
            <h2>
                <input type="checkbox" name="chkcollection" id="chkcollection" onchange="checkCollection();">
                <b>Collection Details</b>
            </h2>

            <div class="form-group">
                <label>Driver</label>
                <input type="text" name="collectiondriver" id="collectiondriver" value='<s:property value="collectiondriver"/>' placeholder="Press F3 to Search" readonly onkeydown="getDriver(event,1);">
            </div>

            <div class="form-group dual-input">
                <label>Date</label>
                <div><div id="colleteddate" name="colleteddate" value='<s:property value="colleteddate"/>'></div></div>

                <label>Time</label>
                <div><div id="collectedtime" name="collectedtime" value='<s:property value="collectedtime"/>'></div></div>
            </div>

            <div class="form-group dual-input">
                <label>KM</label>
                <input type="text" name="colletedkm" id="colletedkm" value='<s:property value="colletedkm"/>' onkeypress="javascript:return isNumber (event)">

                <label>Fuel</label>
                <select name="collectedfuel" id="collectedfuel" value='<s:property value="collectedfuel"/>'>
                    <option value="">--Select--</option>
                    <option value=0.000>Level 0/8</option><option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option>
                    <option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
                </select>
            </div>

        </div>

        <div class="section-block" id="collectfield">
            <h2><b>Branch In</b></h2>

            <div class="form-group dual-input">
                <label>Branch</label>
                <select name="inbranch" id="inbranch" value='<s:property value="inbranch"/>' onchange="getLoc(this.value);"><option value="">--Select--</option></select>

                <label>Location</label>
                <select name="inlocation" id="inlocation" value='<s:property value="inlocation"/>'><option value="">--Select--</option></select>
            </div>

            <div class="form-group dual-input">
                <label>Date</label>
                <div><div id="indate" name="indate" value='<s:property value="indate"/>'></div></div>

                <label>Time</label>
                <div><div id="intime" name="intime" value='<s:property value="intime"/>' ></div></div>
            </div>

            <div class="form-group dual-input">
                <label>KM</label>
                <input type="text" name="binkm" id="binkm" value='<s:property value="binkm"/>' onkeypress="javascript:return isNumber (event)">

                <label>Fuel</label>
                <select name="binfuel" id="binfuel" value='<s:property value="binfuel"/>'>
                    <option value="">--Select--</option>
                    <option value=0.000>Level 0/8</option><option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option>
                    <option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
                </select>
            </div>
        </div>
    </div>


    <div class="section-row">
        <div class="section-block" id="branchout">
            <h2><b>Branch Out</b></h2>

            <div class="form-group dual-input">
                <label>Date</label>
                <div><div id="outdate" name="outdate" value='<s:property value="outdate"/>'></div></div>

                <label>Time</label>
                <div><div id="outtime" name="outtime" value='<s:property value="outtime"/>'></div></div>
            </div>

            <div class="form-group dual-input">
                <label>KM</label>
                <input type="text" name="boutkm" id="boutkm" value='<s:property value="boutkm"/>' onkeypress="javascript:return isNumber (event)">

                <label>Fuel</label>
                <select name="boutfuel" id="boutfuel" value='<s:property value="boutfuel"/>'>
                    <option value="">--Select--</option>
                    <option value=0.000>Level 0/8</option><option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option>
                    <option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
                </select>
            </div>

            <div class="form-group">
                <label>Delivery</label>
                <div class="inline-label-input" style="justify-content: space-between;">
                    <select name="delyesorno" id="delyesorno" value='<s:property value="delyesorno"/>' style="width: 50%;">
                        <option value="">--Select--</option>
                        <option value=1>YES</option>
                        <option value=0>NO</option>
                    </select>
                    <input type="button" id="outbranch" class="myButton" name="outbranch" value="Edit" onclick="funoutupdate()">
                </div>
            </div>

            <div class="form-group">
                <label>Description</label>
                <input type="text" name="outdesc" id="outdesc" value='<s:property value="outdesc"/>'>
            </div>
        </div>


        <div class="section-block" id="deliveryfield">
            <h2>
                <input type="checkbox" name="chkdelivery" id="chkdelivery" onchange="checkDelivery();">
                <label for="chkdelivery"><b>Delivery</b></label>
            </h2>

            <div class="form-group">
                <label>Driver</label>
                <input type="text" name="deldriver" id="deldriver" readonly value='<s:property value="deldriver"/>' placeholder="Press F3 to Search" onkeydown="getDriver(event,2);">
            </div>

            <div class="form-group">
                <label>Deliver To</label>
                <input type="text" name="deliveryto" id="deliveryto" value='<s:property value="deliveryto"/>'>
            </div>

            <div class="form-group dual-input">
                <label>Date</label>
                <div><div id="deldate" name="deldate" value='<s:property value="deldate"/>'></div></div>

                <label>Time</label>
                <div><div id="deltime" name="deltime" value='<s:property value="deltime"/>'></div></div>
            </div>

            <div class="form-group dual-input">
                <label>KM</label>
                <input type="text" name="delkm" id="delkm" value='<s:property value="delkm"/>' onkeypress="javascript:return isNumber (event)">

                <label>Fuel</label>
                <select name="delfuel" id="delfuel" value='<s:property value="delfuel"/>'>
                    <option value="">--Select--</option>
                    <option value=0.000>Level 0/8</option><option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option>
                    <option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
                </select>
            </div>

            <div class="form-group">
                <label></label>
                <input type="button" id="delupdate" class="myButton" name="delupdate" value="Edit" onclick="fundelUpdate()" style="width: auto;">
            </div>
        </div>
    </div>

<input type="hidden" name="masterrefno" id="masterrefno" value='<s:property value="masterrefno"/>'>
<input type="hidden" name="searchbranchval" id="searchbranchval" value='<s:property value="searchbranchval"/>'>
<input type="hidden" name="branchoutval" id="branchoutval" value='<s:property value="branchoutval"/>'>
<input type="hidden" name="delyornval" id="delyornval" value='<s:property value="delyornval"/>'>
<input type="hidden" name="clientnumbers" id="clientnumbers" value='<s:property value="clientnumbers"/>'>
<input type="hidden" name="hidedate" id="hidedate" value='<s:property value="hidedate"/>'>
<input type="hidden" name="hiderefdate" id="hiderefdate" value='<s:property value="hiderefdate"/>'>
<input type="hidden" name="hideroutdate" id="hideroutdate" value='<s:property value="hideroutdate"/>'>
<input type="hidden" name="hidertimeout" id="hidertimeout" value='<s:property value="hidertimeout"/>'>
<input type="hidden" name="rfuelval" id="rfuelval" value='<s:property value="rfuelval"/>'>
<input type="hidden" name="renttypeval" id="renttypeval" value='<s:property value="renttypeval"/>'>
<input type="hidden" name="hidcollecteddate" id="hidcollecteddate" value='<s:property value="hidcollecteddate"/>'>
<input type="hidden" name="hidcollectedTime" id="hidcollectedTime" value='<s:property value="hidcollectedTime"/>'>
<input type="hidden" name="hidcollectedFuelval" id="hidcollectedFuelval" value='<s:property value="hidcollectedFuelval"/>'>
<input type="hidden" name="hideIndate" id="hideIndate" value='<s:property value="hideIndate"/>'>
<input type="hidden" name="hideIntime" id="hideIntime" value='<s:property value="hideIntime"/>'>
<input type="hidden" name="inFuelval" id="inFuelval" value='<s:property value="inFuelval"/>'>
<input type="hidden" name="mainbranchid" id="mainbranchid" value='<s:property value="mainbranchid"/>'>
<input type="hidden" name="mainlocationid" id="mainlocationid" value='<s:property value="mainlocationid"/>'>
<input type="hidden" name="infleettrancode" id="infleettrancode" value='<s:property value="infleettrancode"/>'>
<input type="hidden" name="hidebranch" id="hidebranch" value='<s:property value="hidebranch"/>'>
<input type="hidden" name="hidelocation" id="hidelocation" value='<s:property value="hidelocation"/>'>
<input type="hidden" name="hidoutdate" id="hidoutdate" value='<s:property value="hidoutdate"/>'>
<input type="hidden" name="hidouttime" id="hidouttime" value='<s:property value="hidouttime"/>'>
<input type="hidden" name="outfuelval" id="outfuelval" value='<s:property value="outfuelval"/>'>
<input type="hidden" name="hiddeldate" id="hiddeldate" value='<s:property value="hiddeldate"/>'>
<input type="hidden" name="hiddeltime" id="hiddeltime" value='<s:property value="hiddeltime"/>'>
<input type="hidden" name="hiddelfuelval" id="hiddelfuelval" value='<s:property value="hiddelfuelval"/>'>
<input type="hidden" name="colldriverid" id="colldriverid" value='<s:property value="colldriverid"/>'>
<input type="hidden" name="deldriverid" id="deldriverid" value='<s:property value="deldriverid"/>'>
<input type="hidden" name="collectintickval" id="collectintickval" value='<s:property value="collectintickval"/>'>
<input type="hidden" name="delchkval" id="delchkval" value='<s:property value="delchkval"/>'>
<div hidden="true" id="hidevmovedate" name="hidevmovedate" value='<s:property value="hidevmovedate"/>'></div>
<div hidden="true" id="hidevmovetime" name="hidevmovetime" value='<s:property value="hidevmovetime"/>'></div>
<input type="hidden" name="hidevmovekm" id="hidevmovekm" value='<s:property value="hidevmovekm"/>'>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
<input type="hidden" name="extramsg" id="extramsg" value='<s:property value="extramsg"/>'>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>

</div>
</form>
<div id="collectionwindow">

 <div ></div>
</div>
.<div id="agmtnowindow">
<div ></div>
</div>
</div>

</body>
</html>