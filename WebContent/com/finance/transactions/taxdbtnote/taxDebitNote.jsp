<%@page import="com.controlcentre.masters.tarifmgmt.ClsTarifAction"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link rel="stylesheet" type="text/css" href="../../../../css/body.css">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
.hidden-scrollbar {
  overflow-y: auto;
  height: 600px;
  scrollbar-width: thin;
  scrollbar-color: #4da3ff #eaf3ff;
}
.hidden-scrollbar::-webkit-scrollbar {
  width: 7px;
}
.hidden-scrollbar::-webkit-scrollbar-thumb {
  background-color: #4da3ff;
  border-radius: 8px;
}
.hidden-scrollbar::-webkit-scrollbar-thumb:hover {
  background-color: #1a73e8;
}
body {
  background: linear-gradient(135deg, #e8f1ff 0%, #d1e4ff 100%);
  font-family: "Poppins", "Segoe UI", sans-serif;
  color: #1f2f46;
  margin: 0;
  padding: 40px 0;
  min-height: 100vh;
  animation: fadeIn 0.6s ease-in-out;
}
#mainBG {
  background: #f4f8ff;
  border-radius: 16px;
  box-shadow: 0 4px 25px rgba(50, 110, 255, 0.15);
  padding: 25px 30px;
  max-width: 1250px;
  margin: 0 auto;
  transition: 0.3s ease;
}
#mainBG:hover {
  box-shadow: 0 8px 35px rgba(30, 100, 255, 0.25);
}
.receipt-header {
  background: #edf4ff;
  border: 1px solid #c9dafc;
  border-radius: 14px;
  padding: 20px;
  margin-bottom: 26px;
  box-shadow: 0 2px 10px rgba(132, 168, 255, 0.2);
}
label {
  font-weight: 600;
  font-size: 15px;
  color: #1a2d4d;
  margin-bottom: 6px;
}
input[type="text"],
select,
.clean-input {
  width: 100%;
  height: 38px;
  padding: 6px 12px;
  border: 1px solid #b9ccf2;
  border-radius: 8px;
  background: #ffffff;
  font-size: 0.95rem;
  color: #1f2f46;
  box-sizing: border-box;
  transition: 0.25s ease;
}
input[type="text"]:focus,
select:focus {
  border-color: #4da3ff;
  box-shadow: 0 0 6px rgba(77, 163, 255, 0.55);
  outline: none;
}
select {
  appearance: none;
  background: #ffffff url("data:image/svg+xml;utf8,<svg fill='%233b82f6' height='20' width='20' viewBox='0 0 20 20'><polygon points='5,7 15,7 10,12' /></svg>") no-repeat right 10px center;
  background-size: 14px;
}
input[readonly],
select:disabled {
  background-color: #eef3ff;
  color: #6a7ba1;
}
#jqxTariffDate,
#jqxTariffFromDate,
#jqxTariffToDate {
  width: 100%;
  height: 38px;
}
#jqxTariffDate input,
#jqxTariffFromDate input,
#jqxTariffToDate input {
  height: 36px;
  padding-left: 10px;
  border-radius: 8px;
  background-color: #ffffff;
  box-shadow: none;
}
input:-webkit-autofill,
input:-webkit-autofill:hover,
input:-webkit-autofill:focus,
select:-webkit-autofill {
  -webkit-box-shadow: 0 0 0px 1000px #ffffff inset;
  background-color: #ffffff;
  color: #1f2f46;
}
input::selection,
#jqxTariffDate input::selection,
#jqxTariffFromDate input::selection,
#jqxTariffToDate input::selection {
  background: #cfe2ff;
  color: #000;
}
.cr-table {
  width: 100%;
  border-collapse: collapse;
  background: #ffffff;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 2px 12px rgba(100, 140, 255, 0.15);
}
.cr-table th,
.cr-table td {
  padding: 10px 12px;
  border-bottom: 1px solid #d6e1ff;
  text-align: left;
  font-size: 0.95rem;
}
.cr-table th {
  background-color: #dcebff;
  color: #1b3f73;
  font-weight: 600;
}
.cr-table tr:hover td {
  background-color: #eef5ff;
  transition: 0.25s;
}
button,
.myButton {
  background: linear-gradient(90deg, #3b82f6, #1a73e8);
  color: #fff;
  border: none;
  border-radius: 8px;
  padding: 9px 22px;
  font-weight: 600;
  cursor: pointer;
  transition: 0.25s ease;
  box-shadow: 0 3px 10px rgba(30, 100, 255, 0.25);
}
button:hover,
.myButton:hover {
  background: linear-gradient(90deg, #1a73e8, #155cc6);
  transform: translateY(-2px);
}
button:active {
  transform: scale(0.96);
}
#validrate,
#validrate1,
#errormsg {
  color: #d62828;
  font-weight: 600;
  font-size: 0.9rem;
}
@keyframes fadeIn {
  from { opacity: 0; transform: translateY(-5px); }
  to { opacity: 1; transform: translateY(0); }
}
#jqxDebitNote {
    border: 1px solid #9db4d9;
    border-radius: 12px;
    overflow: hidden;
}
.jqx-grid-column-header,
.jqx-widget-header {
    background: #d5e4ff;
    color: #0f2a4d;
    font-weight: 700;
    font-size: 14.5px;
    border-bottom: 1px solid #9db4d9;
    height: 38px;
    min-height: 38px;
    line-height: 38px;
    padding: 0;
}
.jqx-grid-column-header div,
.jqx-widget-header div {
    padding: 0 10px;
    margin: 0;
    line-height: 38px;
}
.jqx-grid-cell {
    background-color: #ffffff;
    border-color: #d3def5;
    font-size: 14px;
    color: #1c2f4a;
    height: 38px;
    min-height: 38px;
    padding: 0 10px;
    display: flex;
    align-items: center;
}
.jqx-grid-cell-alt {
    background-color: #f4f7ff;
}
.jqx-grid-cell-hover {
    background-color: #e4edff;
}
.jqx-grid-cell-selected {
    background-color: #c3d6ff;
    border-color: #6a92d7;
}
.jqx-grid-cell input[type="checkbox"] {
    transform: scale(1.2);
    margin-left: 6px;
}
.jqx-grid-statusbar {
    background: #e3ecff;
    border-top: 1px solid #9db4d9;
    color: #0f2a4d;
    font-size: 14px;
    font-weight: 700;
    height: 34px;
    padding: 6px 10px;
}
#jqxDebitNote::-webkit-scrollbar {
    width: 8px;
    height: 8px;
}
#jqxDebitNote::-webkit-scrollbar-thumb {
    background: #8aa8d6;
    border-radius: 6px;
}
#jqxDebitNote::-webkit-scrollbar-thumb:hover {
    background: #6f8ec4;
}
textarea {
  width: 100%;
  height: 80px;
  padding: 8px 12px;
  border: 1px solid #b9ccf2;
  border-radius: 8px;
  background: #ffffff;
  font-size: 0.95rem;
  color: #1f2f46;
  box-sizing: border-box;
  resize: vertical;
}
fieldset {
  border: 1px solid #c9dafc;
  border-radius: 8px;
  background: #f8fbff;
}
legend {
  color: #1a2d4d;
  font-weight: 600;
  padding: 0 8px;
}
</style>
<script type="text/javascript">
      $(document).ready(function () { 
    	  getTariftype();
    	 
    	  
    	  getcheckbox();
     setCheck();
    	  document.getElementById("grouplabel").style.display="none";
document.getElementById("txtclient").disabled="true";
    	  $("#jqxTariffDate").jqxDateTimeInput({ width: '100%', height: '38px',formatString:"dd.MM.yyyy"});
    	  $("#jqxTariffFromDate").jqxDateTimeInput({ width: '100%', height: '38px',formatString:"dd.MM.yyyy"});
    	  $("#jqxTariffToDate").jqxDateTimeInput({ width: '100%', height: '38px',formatString:"dd.MM.yyyy"});
    	  document.getElementById("btnTarifEdit").style.display="none";

$('#clienttarifwindow').jqxWindow({autoOpen:false, width: '50%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#clienttarifwindow').jqxWindow('close');
	selectTarif();
	$('#txtclient').dblclick(function(){
		    $('#clienttarifwindow').jqxWindow('open');
		$('#clienttarifwindow').jqxWindow('focus');
		 clientSearchContent('clientSearch.jsp?tariftype='+document.getElementById("cmbtariftype").value, $('#clienttarifwindow'));
		});
	     
      });
    
      function clientSearchContent(url) {
  	    $.get(url).done(function (data) {
  	    $('#clienttarifwindow').jqxWindow('setContent', data);

  	}); 
  	}
      function getClient(event){
          var x= event.keyCode;
          if(x==114){
        	   $('#clienttarifwindow').jqxWindow('open');
       		$('#clienttarifwindow').jqxWindow('focus');
       		 clientSearchContent('clientSearch.jsp?tariftype='+document.getElementById("cmbtariftype").value, $('#clienttarifwindow'));
          }
          else{
           }
          }
      function selectTarif(){
    	  $('#frmTariffManagement select').attr('disabled',false );
  		var temp=document.getElementById("cmbtariftype").value;
  		 if(document.getElementById("mode").value=='A'){
  			 
  		 }
  		else if(temp=="Client"){
  			$('#txtclient').attr('disabled', false );
  			$("#jqxgridtarif").jqxGrid({ disabled: false});
  			$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
  			$("#jqxgridtariffoc").jqxGrid({ disabled: true});
  			$("#jqxgridtariffuel").jqxGrid({ disabled: false});
  			if(document.getElementById("mode").value=='A'){
  	  			$("#jqxgridtarif").jqxGrid({ disabled: true});

  			}
  		}
  		else if(temp=="Corporate"){
  			$('#txtclient').attr('disabled', false );
  			$("#jqxgridtarif").jqxGrid({ disabled: false});
  			$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
  			$("#jqxgridtariffoc").jqxGrid({ disabled: true});
  			$("#jqxgridtariffuel").jqxGrid({ disabled: false});
  			if(document.getElementById("mode").value=='A'){
  	  			$("#jqxgridtarif").jqxGrid({ disabled: true});

  			} 			
  		}
  		else if(temp=="Weekend"){
  			document.getElementById("fieldweekday").style.display="block";
  			document.getElementById("fieldfoc").style.display="none";
  			$("#jqxgridtarifweekday").jqxGrid({ disabled: false});
  			$("#jqxgridtarif").jqxGrid({ disabled: true});
  			if(document.getElementById("mode").value=='A'){
  				$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
  	  			$("#jqxgridtariffoc").jqxGrid({ disabled: true});
  			}
  		}
  		else if(temp=="FOC"){
  			document.getElementById("fieldweekday").style.display="none";
  			document.getElementById("fieldfoc").style.display="block";
  			$("#jqxgridtarifweekday").jqxGrid({ disabled: false});
  			$("#jqxgridtarif").jqxGrid({ disabled: true});
  			if(document.getElementById("mode").value=='A'){
  				$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
  	  			$("#jqxgridtariffoc").jqxGrid({ disabled: true});
  			}
  		}
  		else{
  			$('#txtclient').attr('disabled', true );
  			$("#jqxgridtarif").jqxGrid({disabled: false});
  			$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
  			$("#jqxgridtariffoc").jqxGrid({ disabled: true});
  			$("#jqxgridtariffuel").jqxGrid({ disabled: false});
  			if(document.getElementById("mode").value=='A'){
  	  			$("#jqxgridtarif").jqxGrid({ disabled: true});

  			}
  		}
  	} 
	function funReset(){
    		
    	}
		
    	function funReadOnly(){
			$('#frmTariffManagement input').attr('readonly', true );
			$('#frmTariffManagement select').attr('disabled', true );
			$('#frmTariffManagement textarea').attr('readonly', true );
    		$('#jqxTariffFromDate').jqxDateTimeInput({ disabled: true});
    		$('#jqxTariffToDate').jqxDateTimeInput({ disabled: true});
    		$('#jqxTariffDate').jqxDateTimeInput({ disabled: true});
    		$("#jqxgridtarif").jqxGrid({ disabled: true});
    		$("#jqxgridtariffuel").jqxGrid({ disabled: true});
    		$("#jqxgridtariffoc").jqxGrid({ disabled: true});
    		$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
    		$("#jqxgridtarifgrpfinish").jqxGrid({ disabled: true});
    	} 
    	function funRemoveReadOnly(){
    		$('#frmTariffManagement input').attr('readonly', false );
			$('#frmTariffManagement select').attr('disabled', false );
			$('#frmTariffManagement textarea').attr('readonly', false );
    		$('#jqxTariffFromDate').jqxDateTimeInput({ disabled: false});
    		$('#jqxTariffToDate').jqxDateTimeInput({ disabled: false});
    		$('#jqxTariffDate').jqxDateTimeInput({ disabled: false});
    		$("#jqxgridtarif").jqxGrid({ disabled: false});
    		$("#jqxgridtariffuel").jqxGrid({ disabled: false});
    		$("#jqxgridtariffoc").jqxGrid({ disabled: false});
    		$("#jqxgridtarifweekday").jqxGrid({ disabled: false});
    		$("#jqxgridtarifgrpfinish").jqxGrid({ disabled: false});
    		if(document.getElementById("mode").value=='A'){
    			$("#divRegularTarif").load("gridRegularTarif.jsp");
    			 $("#divfoc").load("gridFoc.jsp");
          		 $("#divweekday").load("gridWeekday.jsp");
          		 $("#divgroup1").load("gridgroup1.jsp");
          		 $("#divgroup2").load("gridgroup2.jsp");
          		 document.getElementById("grouplabel").style.display="none";
          		 document.getElementById("btnTarifEdit").style.display="none";
          		document.getElementById("btnTarifSave").style.display="none";
          		 $("#jqxTariffFromDate").jqxDateTimeInput('setDate', new Date());
          		$("#jqxTariffToDate").jqxDateTimeInput('setDate', new Date());
          		$("#jqxTariffDate").jqxDateTimeInput('setDate', new Date());

    		}
    	}
    	function funNotify(){	
    	 	if(document.getElementById("docno").value!=''){	
    	var rows = $("#jqxgridtarif").jqxGrid('getrows');
    		$('#gridlength').val(rows.length);
    		for(var i=0 ; i < rows.length ; i++){
				newTextBox = $(document.createElement("input"))
			    .attr("type", "dil")
			    .attr("id", "test"+i)
			    .attr("name", "test"+i);
				
			newTextBox.val(rows[i].rentaltype+"::"+rows[i].rate+"::"+rows[i].cdw+"::"+rows[i].pai+"::"+rows[i].cdw1+"::"+rows[i].pai1+"::"+rows[i].gps+"::"+rows[i].babyseater+"::"+rows[i].cooler+"::"+rows[i].exhrchg+"::"+rows[i].chaufchg+"::"+rows[i].chaufexchg+"::"+rows[i].disclevel1+"::"+rows[i].disclevel2+"::"+rows[i].disclevel3+"::"+rows[i].kmrest+"::"+rows[i].exkmrte+"::"+rows[i].oinschg);
			
			newTextBox.appendTo('form');
			}
    	if(document.getElementById("cmbtariftype").value=='Weekend'){
    		var rowsweekday=$("#jqxgridtarifweekday").jqxGrid('getrows');
    		var j=0;
    		for(var i=0 ; i < rowsweekday.length ; i++){

    				newTextBoxweekday = $(document.createElement("input"))
    			    .attr("type", "dil")
    			    .attr("id", "txtweekday"+i)
    			    .attr("name", "txtweekday"+i);
    				var d=new Date(rowsweekday[i].cstime);
    				var tempstarttime=d.getHours()+":"+(d.getMinutes()<10?'0':'') + d.getMinutes();
    				var d1=new Date(rowsweekday[i].cetime);
    				var tempendtime=d1.getHours()+":"+(d1.getMinutes()<10?'0':'') + d1.getMinutes();
    				if(typeof(rowsweekday[i].cswkday)!="undefined" && rowsweekday[i].cswkday!="" && typeof(rowsweekday[i].cstime)!="undefined" && typeof(rowsweekday[i].cstime)!="" && 
    						typeof(rowsweekday[i].cewkday)!="undefined" && typeof(rowsweekday[i].cewkday)!="" && typeof(rowsweekday[i].cetime)!="undefined" && typeof(rowsweekday[i].cetime)!=""){
    					newTextBoxweekday.val(rowsweekday[i].cswkday+"::"+tempstarttime+"::"+rowsweekday[i].cewkday+"::"+tempendtime+"::"+rowsweekday[i].rate+"::"+rowsweekday[i].cdw+"::"+rowsweekday[i].gps+"::"+rowsweekday[i].babyseater+"::"+rowsweekday[i].cooler+"::"+rowsweekday[i].kmrest+"::"+rowsweekday[i].exkmrte+"::"+rowsweekday[i].oinschg+"::"+rowsweekday[i].ulevel1+"::"+rowsweekday[i].ulevel2+"::"+rowsweekday[i].ulevel3+"::"+rowsweekday[i].exdaychg);
    				j++;
    				newTextBoxweekday.appendTo('form');
    				}
    			}
    		$('#weekdaylength').val(j);
    	}
    	if(document.getElementById("cmbtariftype").value=='FOC'){
    		var rowsfoc=$("#jqxgridtariffoc").jqxGrid('getrows');
    		$('#foclength').val(rowsfoc.length);
    		for(var i=0 ; i < rowsfoc.length ; i++){
    				newTextBoxfoc = $(document.createElement("input"))
    			    .attr("type", "dil")
    			    .attr("id", "txtfoc"+i)
    			    .attr("name", "txtfoc"+i);
    				newTextBoxfoc.val(rowsfoc[i].minday+"::"+rowsfoc[i].foc+"::"+rowsfoc[i].rate+"::"+rowsfoc[i].cdw+"::"+rowsfoc[i].gps+"::"+rowsfoc[i].babyseater+"::"+rowsfoc[i].cooler+"::"+rowsfoc[i].kmrest+"::"+rowsfoc[i].exkmrte+"::"+rowsfoc[i].oinschg);
    				newTextBoxfoc.appendTo('form');
    			}
    	}
    		var a=document.getElementById("gridlength").value;
			var b=document.getElementById("weekdaylength").value;
			var c=document.getElementById("foclength").value;
			var d=document.getElementById("fuellength").value;
    			}
    			$('#frmTariffManagement select').attr('disabled',false);
    			$('#txtclient').attr('disabled',false);
			return 1;
			$('#frmTariffManagement select').attr('disabled',true);
    	} 

     	function funChkButton() {
    		/* funReset(); */
    	}

    	function funSearchLoad(){
    		changeContent('tarifSearch.jsp', $('#window')); 
    	}
    		
     	function funFocus(){
    	   	$('#jqxTariffDate').jqxDateTimeInput('focus'); 	    	
     	}
		function setCheck(){
			if(document.getElementById("chckdeliverychg").checked==true){
				document.getElementById("hidcheck").value=1;
			}
			else
				document.getElementById("hidcheck").value=0;
		}
		function getcheckbox(){
			if(document.getElementById("hidcheck").value==1){
				document.getElementById("chckdeliverychg").checked=true;
			}
			else{
				document.getElementById("chckdeliverychg").unchecked=true;
			}
		}
		function setValues(){
			document.getElementById("cmbtariftype").disabled=false;
			if(document.getElementById("cmbtariftype").value=="Weekend"){
				document.getElementById("fieldweekday").style.display="block";
	  			document.getElementById("fieldfoc").style.display="none";
			}
			if(document.getElementById("cmbtariftype").value=="FOC"){
				document.getElementById("fieldweekday").style.display="none";
	  			document.getElementById("fieldfoc").style.display="block";
			}
			if(document.getElementById("docno")!=''){
				var temp=document.getElementById("docno").value;
				$("#divgroup2").load("gridgroup2.jsp?id="+temp);
				$("#divgroup1").load("gridgroup1.jsp?id="+temp);
			}
			if ($('#hidcmbtariftype').val() != null) {
				$('#cmbtariftype').val($('#hidcmbtariftype').val());
			}
			if ($('#hidcmbtariffor').val() != null) {
				$('#cmbtariffor').val($('#hidcmbtariffor').val());
			}
			if($('#hidjqxTariffDate').val()){
				$("#jqxTariffDate").jqxDateTimeInput('val', $('#hidjqxTariffDate').val());
			}
			if($('#hidjqxTariffFromDate').val()){
				$("#jqxTariffFromDate").jqxDateTimeInput('val', $('#hidjqxTariffFromDate').val());
			}
			if($('#hidjqxTariffToDate').val()){
				$("#jqxTariffToDate").jqxDateTimeInput('val', $('#hidjqxTariffToDate').val());
			}
			if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
if(document.getElementById("docno").value==''){
	document.getElementById("btnTarifEdit").style.display="none";
}

document.getElementById("cmbtariftype").disabled=true;
		}
		 function funTarifEdit(){
		 	 document.getElementById("cmbtariftype").disabled=false;
		 	$("#jqxgridtarifgrp").jqxGrid({ disabled:false});
		 	document.getElementById("insurexcess").readOnly=false;
		 	document.getElementById("cdwexcess").readOnly=false;
		 	document.getElementById("scdwexcess").readOnly=false;
		 	document.getElementById("securityamt").readOnly=false;
	    		if(document.getElementById("cmbtariftype").value=="Weekend"){
	    			$("#jqxgridtarifweekday").jqxGrid({ disabled: false});
	    			$("#jqxgridtariffoc").jqxGrid({ disabled:true});
	    			$("#jqxgridtarif").jqxGrid({ disabled: true});
	    			 document.getElementById("btnTarifEdit").style.display="none";
		     			document.getElementById("btnTarifSave").style.display="block";
	    		}
	    		else if(document.getElementById("cmbtariftype").value=="FOC"){
	    			$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
	    			$("#jqxgridtariffoc").jqxGrid({ disabled:false});
	    			$("#jqxgridtarif").jqxGrid({ disabled: true});
	    			 document.getElementById("btnTarifEdit").style.display="none";
		     			document.getElementById("btnTarifSave").style.display="block";
	    		}
	    		else{
	    			$("#jqxgridtariffoc").jqxGrid({ disabled: true});
	        		$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
	        		$("#jqxgridtariffuel").jqxGrid({ disabled: false});
	        		 document.getElementById("btnTarifEdit").style.display="none";
	     			document.getElementById("btnTarifSave").style.display="block";
	    			$("#jqxgridtarif").jqxGrid({ disabled: false});
	    		}
		 	document.getElementById("cmbtariftype").disabled=true;
		}  
		 function funTarifSave(){
			 document.getElementById("cmbtariftype").disabled=false;
			 if(document.getElementById("cmbtariftype").value=="Weekend"){
	
				 var rowsweekday=$('#jqxgridtarifweekday').jqxGrid('getrows');
	
				 if(typeof(rowsweekday[0].cswkday)=="undefined" || rowsweekday[0].cswkday==""){
			
					 document.getElementById("errormsg").innerText="";
		    			document.getElementById("errormsg").innerText="Start day is Mandatory";
		    			return false;
		    		}
		    		if(typeof(rowsweekday[0].cstime)=="undefined" || rowsweekday[0].cstime==""){
		    			document.getElementById("errormsg").innerText="";
		    			document.getElementById("errormsg").innerText="Start time is Mandatory";
		    			return false;
		    		}
		    		if(typeof(rowsweekday[0].cewkday)=="undefined" || rowsweekday[0].cewkday==""){
		    			document.getElementById("errormsg").innerText="";
		    			document.getElementById("errormsg").innerText="End day is Mandatory";
		    			return false;
		    		}
		    		if(typeof(rowsweekday[0].cetime)=="undefined" || rowsweekday[0].cetime==""){
		    			document.getElementById("errormsg").innerText="";
		    			document.getElementById("errormsg").innerText="End time is Mandatory";
		    			return false;
		    		}
		    		if(typeof(rowsweekday[0].rate)=="undefined" || rowsweekday[0].rate==""){
		    			document.getElementById("errormsg").innerText="";
		    			document.getElementById("errormsg").innerText="Tariff is Mandatory";
		    			return false;
		    		}
			 }
			if(document.getElementById("docno").value!=""){
				 document.getElementById("mode").value="A";
				 $('#btnSave').mousedown();	 
			 }
			 else{
				 $.messager.alert('Warning','Please Select a Valid Document');
				 return false;
			 }
			 document.getElementById("cmbtariftype").disabled=true;
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
		function funPrintBtn() {
	   		if(document.getElementById("docno").value=='' || document.getElementById("docno").value=='0'){
	   		 $.messager.alert('Warning','Select a Document');
	   		 return false;
		   		}
	   		var url=document.URL;
	   	 var reurl=url.split("com/");
	   	  	var win= window.open(reurl[0]+"com/controlcentre/masters/tarifmgmt/tarifPrint.action?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	   		win.focus();  
		}
		function getTariftype(){
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items=items.split("***");
					var tarifitems = items[0].split(",");
					var status=items[1];				
					var optionstarif = '<option value="">--Select--</option>';
					for (var i = 0; i < tarifitems.length; i++) {
						optionstarif += '<option value="' + tarifitems[i] + '">'
								+ tarifitems[i] + '</option>';
					}
					$("select#cmbtariftype").html(optionstarif);
				 	 if ($('#hidcmbtariftype').val() != null) {
						$('#cmbtariftype').val($('#hidcmbtariftype').val());
					}
				 	  document.getElementById("fieldfoc").style.display="none";
		        	  document.getElementById("fieldweekday").style.display="none";	
				}
			}
			x.open("GET", "getTariftype.jsp", true);
			x.send();
		}
</script>

</head>
<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmTariffManagement" action="saveTariffManagement" autocomplete="off">
	<script>
		window.parent.formName.value="Tariff Management";
		window.parent.formCode.value="TFM";
	</script>
	<jsp:include page="../../../../header.jsp" />
	<br/>

<div class='hidden-scrollbar receipt-header'>
<table class="cr-table" width="100%" >
  <tr>
    <td width="3%" align="right">Date</td>
    <td width="8%" align="left"><input type="hidden" id="hidjqxTariffDate" name="hidjqxTariffDate" value='<s:property value="hidjqxTariffDate"/>'/>
      <div id='jqxTariffDate' name='jqxTariffDate' value='<s:property value="jqxTariffDate"/>'></div></td>
    <td width="5%" align="right">Tariff Type</td>
    <td width="18%" align="left"><select id="cmbtariftype" name="cmbtariftype" value='<s:property value="cmbtariftype"/>' onchange="selectTarif();" >
      <option value="">--Select--</option></select>
      <input type="text" name="txtclient" id="txtclient" value='<s:property value="txtclient"/>' onkeydown="getClient(event);">
      <input type="hidden" id="hidcmbtariftype" name="hidcmbtariftype" value='<s:property value="hidcmbtariftype"/>'/></td>
    <input type="hidden" name="hidtxtclient" id="hidtxtclient" value='<s:property value="hidtxtclient"/>'/>
    <td width="4%" align="right">Tariff For</td>
    <td width="9%" align="left"><select id="cmbtariffor" name="cmbtariffor" value='<s:property value="cmbtariffor"/>' >
      <option value="">--Select--</option><option value="Vehicle">Vehicle</option>
    </select>
      <input type="hidden" id="hidcmbtariffor" name="hidcmbtariffor" value='<s:property value="hidcmbtariffor"/>'/></td>
    <td width="6%" align="right">Validity From</td>
    <td width="9%" align="left"><input type="hidden" id="hidjqxTariffFromDate" name="hidjqxTariffFromDate" value='<s:property value="hidjqxTariffFromDate"/>'/>
      <div id='jqxTariffFromDate' name='jqxTariffFromDate' value='<s:property value="jqxTariffFromDate"/>'></div></td>
    <td width="5%" align="right">Validity To</td>
    <td width="9%" align="left"><input type="hidden" id="hidjqxTariffToDate" name="hidjqxTariffToDate" value='<s:property value="hidjqxTariffToDate"/>'/>
      <div id='jqxTariffToDate' name='jqxTariffToDate' value='<s:property value="jqxTariffToDate"/>'></div></td>
    <td width="9%" align="left"><input type="checkbox" id="chckdeliverychg" name="chckdeliverychg"  onchange="setCheck();">
      &nbsp;&nbsp;Delivery Charge</td><input type="hidden" name="hidcheck" id="hidcheck" value='<s:property value="hidcheck"/>'/>
    <td width="4%" align="right">Doc No</td>
    <td width="11%" align="left"><input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>'/></td>
  </tr>
  <tr>
    <td height="41" align="right">Notes</td>
    <td align="left" colspan="10"><textarea id="notes" name="notes" style="width:100%;resize:vertical;"><s:property value="notes"/></textarea></td>
    <td align="center">
    <button type="button"  id="btnTarifEdit" title="Tarif Edit" style="border:none;background:none;" onclick="funTarifEdit();">
							<img alt="Tarif Edit" src="<%=contextPath%>/icons/tarifedit.png" width="30" height="30">
		  </button>
    <button type="button" id="btnTarifSave" title="Tarif Save" hidden="true" style="border:none;background:none;" onclick="funTarifSave();">
							<img alt="Tarif Save" src="<%=contextPath%>/icons/tarifsave.png" width="30" height="30">
		  </button>
    </td>
  </tr>
</table>
<center><label id="grouplabel" style="color:red;font-weight:bold;"></label></center>

<table width="100%">
  <tr>
    <td width="6%" rowspan="11" ><div id="divgroup1" ><jsp:include page="gridgroup1.jsp"></jsp:include></div></td>
    <td colspan="2" align="center"><fieldset><div id="divRegularTarif"><jsp:include page="gridRegularTarif.jsp"></jsp:include></div></fieldset></td>
    <td width="6%" rowspan="11"><div id="divgroup2"><jsp:include page="gridgroup2.jsp"></jsp:include></div></td></tr>
  <tr>
    <td colspan="2"  align="center"><fieldset id="fieldextrainsur" align="left">
      <table width="100%">
        <tr>
          <td align="right">Security Amount</td><td align="left"><input type="text" name="securityamt" id="securityamt" value='<s:property value="securityamt"/>' onkeypress="javascript:return isNumber (event,this.id)"></td>
          <td align="right">Insurance Excess</td><td align="left"><input type="text" name="insurexcess" id="insurexcess" value='<s:property value="insurexcess"/>' onkeypress="javascript:return isNumber (event,this.id)"></td>
          <td align="right">CDW Excess</td><td align="left"><input type="text" name="cdwexcess" id="cdwexcess" value='<s:property value="cdwexcess"/>' onkeypress="javascript:return isNumber (event,this.id)"></td>
          <td align="right">Super CDW Excess</td><td align="left"><input type="text" name="scdwexcess" id="scdwexcess" value='<s:property value="scdwexcess"/>' onkeypress="javascript:return isNumber (event,this.id)"></td>
        </tr>
      </table>
    </fieldset></td>
  </tr>
  <tr>
    <td colspan="2"  align="center"><fieldset id="fieldfoc" align="left" style="display:none;">
      <legend>FOC Tariff</legend>
      <table width="100%">
        <tr>
          <td><div id="divfoc">
            <jsp:include page="gridFoc.jsp"></jsp:include>
          </div></td>
        </tr>
      </table>
    </fieldset></td>
  </tr>
  <tr>
    <td colspan="2"  align="center"><fieldset id="fieldweekday" align="left" style="display:none;">
      <legend>Week Day Tariff</legend>
      <table width="100%">
        <tr>
          <td><div id="divweekday">
            <jsp:include page="gridWeekday.jsp"></jsp:include>
          </div></td>
        </tr>
      </table>
    </fieldset></td>
  </tr>
  <tr>
    <td colspan="2"  align="center">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2"  align="center">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2" >&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2" >&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2" >&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2" >&nbsp;</td>
  </tr>
<input type="hidden" id="mode" name="mode"/>
<input type="hidden" name="delete" id="delete" value='<s:property value="delete"/>'/>
<input type="hidden" name="tempgroup" id="tempgroup" value='<s:property value="tempgroup"/>'>
<input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
<input type="hidden" name="weekdaylength" id="weekdaylength" value='<s:property value="weekdaylength"/>'>
<input type="hidden" name="foclength" id="foclength" value='<s:property value="foclength"/>'>
<input type="hidden" name="fuellength" id="fuellength" value='<s:property value="fuellength"/>'>
<input type="hidden" name="tarifmode" id="tarifmode" value='<s:property value="tarifmode"/>'>
<input type="hidden" name="temprowindex" id="temprowindex" value='<s:property value="temprowindex"/>'> 
<input type="hidden" name="deliverylength" id="deliverylength" value='<s:property value="deliverylength"/>'>
<input type="hidden" name="tempdocno" id="tempdocno" value='<s:property value="tempdocno"/>'>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
<input type="hidden" name="tempstatus" id="tempstatus" value='<s:property value="tempstatus"/>'>
<input type="hidden" name="formdetail" id="formdetail" value='<s:property value="formdetail"/>'>
<input type="hidden" name="formdetailcode" id="formdetailcode" value='<s:property value="formdetailcode"/>'>
<input type="hidden" name="conditionstatus" id="conditionstatus" value='<s:property value="conditionstatus"/>'/>
<input type="hidden" name="hidgroupdoc" id="hidgroupdoc" value='<s:property value="hidgroupdoc"/>'/>
</table>
</form>
</div>
<div id="clienttarifwindow">
   <div ></div>
</div>
<div hidden="true">
<fieldset>
  <legend>Fuel Info</legend>
  <table width="100%">
    <tr>
      <td><div id="divfuel">
        <jsp:include page="gridfuel.jsp"></jsp:include>
      </div></td>
    </tr>
  </table>
</fieldset>
</div>
<p>&nbsp;</p>
</body>
</html>

