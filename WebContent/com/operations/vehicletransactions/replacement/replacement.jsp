<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="../../../../css/body.css"> 

<style>
/* =========================================================
SCOPED UI: Bulletproof Table Layout (Does NOT affect header.jsp)
========================================================= */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 5px 15px;
    box-sizing: border-box;
    width: 100%;
}

.modern-ui .erp-form-area {
    background-color: #f4f7fb;
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    padding: 15px 10px;
    margin-bottom: 10px;
    width: 100%;
    box-sizing: border-box;
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui select { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

.modern-ui table {
    border-collapse: collapse;
    width: 100%;
}

.modern-ui td {
    padding: 4px 5px;
    vertical-align: middle;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Split Section Styling */
.modern-ui .section-title {
    font-size: 13px;
    font-weight: bold;
    color: #0056b3;
    margin-bottom: 10px;
    border-bottom: 1px solid #c5d3e0;
    padding-bottom: 3px;
    display: flex;
    align-items: center;
    justify-content: space-between;
}

/* Custom UI Buttons matching 24px height */
.modern-ui .myButton {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 12px;
    font-family: Arial, sans-serif;
    font-size: 11px;
    font-weight: bold;
    border-radius: 3px;
    cursor: pointer;
    text-shadow: none;
    transition: all 0.2s;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    border: none;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    white-space: nowrap;
}
.modern-ui .myButton:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

.modern-ui label.error {
    color: red;
    font-weight: bold;
    font-size: 11px;
}

/* Search Icon Wrapper */
.modern-ui .input-search-container {
    position: relative;
    display: flex;
    width: 120px;
}
.modern-ui .input-search-container input {
    padding-right: 25px !important;
}
.modern-ui .magnifier-icon {
    position: absolute;
    right: 6px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
.modern-ui .magnifier-icon:hover { color: #2563eb; }

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 150px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }
</style> 

<script type="text/javascript">
      $(document).ready(function () { 
    	  $('#btnEdit').attr('disabled',true);

          /* COMPACT DATES (120px) AND TIMES (80px) FOR 24px HEIGHTS */
    	  $("#date").jqxDateTimeInput({ width: '120px', height: '24px',formatString:"dd.MM.yyyy"});
    	  $("#refdate").jqxDateTimeInput({ width: '120px', height: '24px',formatString:"dd.MM.yyyy",value:null});
    	  $("#dateout").jqxDateTimeInput({ width: '120px', height: '24px',formatString:"dd.MM.yyyy",value:null});
    	  $("#dateouthidden").jqxDateTimeInput({ width: '120px', height: '24px',formatString:"dd.MM.yyyy"});
    	  $("#oncollectdate").jqxDateTimeInput({ width: '120px', height: '24px',formatString:"dd.MM.yyyy",value:null});
    	  $("#incollectdate").jqxDateTimeInput({ width: '120px', height: '24px',formatString:"dd.MM.yyyy",value:null});
    	  $("#deliveryoutdate").jqxDateTimeInput({ width: '120px', height: '24px',formatString:"dd.MM.yyyy",value:null});
    	  $("#ondeliverydate").jqxDateTimeInput({ width: '120px', height: '24px',formatString:"dd.MM.yyyy",value:null});
          
          $("#timeout").jqxDateTimeInput({ width: '80px', height: '24px', formatString: 'HH:mm', showCalendarButton: false,value:null });
          $("#timeouthidden").jqxDateTimeInput({ width: '80px', height: '24px', formatString: 'HH:mm', showCalendarButton: false,value:new Date() });
          $("#oncollecttime").jqxDateTimeInput({ width: '80px', height: '24px', formatString: 'HH:mm', showCalendarButton: false,value:null });
          $("#incollecttime").jqxDateTimeInput({ width: '80px', height: '24px', formatString: 'HH:mm', showCalendarButton: false,value:null });
          $("#deliveryouttime").jqxDateTimeInput({ width: '80px', height: '24px', formatString: 'HH:mm', showCalendarButton: false,value:null });
          $("#ondeliverytime").jqxDateTimeInput({ width: '80px', height: '24px', formatString: 'HH:mm', showCalendarButton: false,value:null });
          
          /* Force internal alignment AFTER render */
          setTimeout(function () {
              $(".jqx-datetimeinput").find("input").css({
                  "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
                  "font-family": "Arial, sans-serif", "padding": "0 6px", "box-sizing":"border-box"
              });
              $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
          }, 0);

          $('#agmtnowindow').jqxWindow({ width: '60%', height: '54%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
   	      $('#agmtnowindow').jqxWindow('close');
   	      $('#collectionwindow').jqxWindow({ width: '60%', height: '54%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Driver Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
  	      $('#collectionwindow').jqxWindow('close');

		  if(document.getElementById("btnsave")) document.getElementById("btnsave").style.display="none";
		  $('#dateout').on('change', function (event) { checkfuturedate(); }); 
		  
          /* F3 KEY BINDS AND DOUBLE CLICKS */
   	      $('#refvocno').dblclick(function(){ openAgmtSearch(); });
   	      $('#txtoutfleetno').dblclick(function(){ openFleetSearch(); });
          
   	      $('#collectdriver').dblclick(function(){
		      $('#collectionwindow').jqxWindow('open');
		      $('#collectionwindow').jqxWindow('focus');
		      collectionSearchContent('driverSearchGrid.jsp?id=1', $('#collectionwindow'));
		  });
		
  	      $('#deliverydriver').dblclick(function(){
  	          $('#collectionwindow').jqxWindow('open');
		      $('#collectionwindow').jqxWindow('focus');
		      collectionSearchContent('driverSearchGrid.jsp?id=2',  $('#collectionwindow'));
	      });
	    
    	getReason();
    	check();
    	checkDelivery();
    	checkCollection();
    	getBranch();
    	getTestLocation();
    	
    	if(document.getElementById("docno") && document.getElementById("cmbreplacetype")) {
        	if((document.getElementById("docno").value=='')||(document.getElementById("cmbreplacetype").value=="atbranch")||(document.getElementById("cmbreplacetype").value=="0")){
        		if(document.getElementById("btnupdate")) document.getElementById("btnupdate").style.display="none";
        	} else {
        		if(!(document.getElementById("cmbreplacetype").value=="atbranch")){
        		    if(document.getElementById("btnupdate")) document.getElementById("btnupdate").style.display="block";
        		}
        	}
    	}
      });
      
      /* HELPER FUNCTIONS FOR SEARCH ICONS & F3 */
      function openAgmtSearch() {
          if(document.getElementById("mode").value=="view"){ return false; }
          if(document.getElementById("cmbrentaltype").value==''){
              if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Agreement Type is Mandatory";
              document.getElementById("cmbrentaltype").focus();
              return false;
          }
          if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="";
          $('#agmtnowindow').jqxWindow('open');
          $('#agmtnowindow').jqxWindow('focus');
          agmtnoSearchContent('agmtnoSearch.jsp?', $('#agmtnowindow'));
      }
      
      function openFleetSearch() {
          if(document.getElementById("mode").value=="view"){ return false; }
          $('#agmtnowindow').jqxWindow('open');
          $('#agmtnowindow').jqxWindow('focus');
          agmtnoSearchContent('masterFleetSearch.jsp?', $('#agmtnowindow'));
      }
      
      function getAgmtno(event) {
          if (event.keyCode == 114) { openAgmtSearch(); }
      }
      
      function getOutfleet(event) {
          if (event.keyCode == 114) { openFleetSearch(); }
      }
      
      /* OTHER FUNCTIONS */
      function checkfuturedate(){
   		var date1=new Date($('#dateout').jqxDateTimeInput('getDate'));
   		var time1=new Date($('#timeout').jqxDateTimeInput('getDate')); 
   		var futuredate=new Date();
   		var futuretime=new Date();
   		date1.setHours(0,0,0,0);
   		futuredate.setHours(0,0,0,0);

   		if(date1>futuredate){
   				   if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Future Date Cannot be applied";
   				   $('#dateout').jqxDateTimeInput('focus'); 
   				   return false;
   			   }
   		if(date1-futuredate==0){
   			if(time1.getHours()>futuretime.getHours()){
			   if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Future Time Cannot be applied";
			   $('#timeout').jqxDateTimeInput('focus'); 
			   return false;
   			}
   			if(time1.getHours()==futuretime.getHours()){
   				if(time1.getMinutes()>futuretime.getMinutes()){
   			       if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Future Time Cannot be applied";
   			       $('#timeout').jqxDateTimeInput('focus'); 
   			       return false;
   				}
    		}
		   }
   			   if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="";
   			   return true;
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
    				$("select#cmbinlocation").html(optionsloc);
    				if ($('#hidcmbinlocation').length && $('#hidcmbinlocation').val() != null) {
    					$('#cmbinlocation').val($('#hidcmbinlocation').val());
    				}
    			}
    		}
    		x.open("GET", "getTestLocation.jsp", true);
    		x.send();
      }
      
      function getDeliveryDriver(event){
    	  var x= event.keyCode;
          if(x==114){
        	  $('#collectionwindow').jqxWindow('open');
    		  $('#collectionwindow').jqxWindow('focus');
    		  collectionSearchContent('driverSearchGrid.jsp?id=2', $('#collectionwindow'));
          }
      }
      
      function getCollectDriver(event){
    	  var x= event.keyCode;
          if(x==114){
        	  $('#collectionwindow').jqxWindow('open');
   			  $('#collectionwindow').jqxWindow('focus');
   			  collectionSearchContent('driverSearchGrid.jsp?id=1', $('#collectionwindow'));
          }
      }
      
      function agmtnoSearchContent(url) {
	      $.get(url).done(function (data) {
	         $('#agmtnowindow').jqxWindow('setContent', data);
	      }); 
	  }
	  
      function collectionSearchContent(url) {
	      $.get(url).done(function (data) {
	         $('#collectionwindow').jqxWindow('setContent', data);
	      }); 
	  }
	  
      function funReset(){ }
        
    /* SAFE READONLY FUNCTION */
   	function funReadOnly(){
   	    try {
       		$('#frmReplacement input[type="text"]').attr('readonly', true );
       		$('#frmReplacement select').attr('disabled', true);
       		$('#date').jqxDateTimeInput({ disabled: true});
       		$('#refdate').jqxDateTimeInput({ disabled: true});
       		$('#dateout').jqxDateTimeInput({ disabled: true});
       		$('#timeout').jqxDateTimeInput({ disabled: true});
       		$('#incollectdate').jqxDateTimeInput({ disabled: true});
       		$('#incollecttime').jqxDateTimeInput({ disabled: true});
       		$('#oncollectdate').jqxDateTimeInput({ disabled: true});
       		$('#oncollecttime').jqxDateTimeInput({ disabled: true});
       		$('#deliveryoutdate').jqxDateTimeInput({ disabled: true});
       		$('#deliveryouttime').jqxDateTimeInput({ disabled: true});
       		$('#ondeliverydate').jqxDateTimeInput({ disabled: true});
       		$('#ondeliverytime').jqxDateTimeInput({ disabled: true});
   	    } catch(e) { console.error("Error in funReadOnly: ", e); }
   	}
   	
   	/* SAFE REMOVE READONLY FUNCTION */
   	function funRemoveReadOnly(){
   	    try {
       		$('#frmReplacement input[type="text"]').attr('readonly', false );
      		$('#frmReplacement select').attr('disabled', false);
      		$('#date').jqxDateTimeInput({ disabled: false});
      		$('#refdate').jqxDateTimeInput({ disabled: false});
      		$('#dateout').jqxDateTimeInput({ disabled:false});
      		$('#timeout').jqxDateTimeInput({ disabled: false});
      		$('#incollectdate').jqxDateTimeInput({ disabled:false});
      		$('#incollecttime').jqxDateTimeInput({ disabled: false});
      		$('#oncollectdate').jqxDateTimeInput({ disabled: false});
      		$('#oncollecttime').jqxDateTimeInput({ disabled: false});
      		$('#deliveryoutdate').jqxDateTimeInput({ disabled: false});
      		$('#deliveryouttime').jqxDateTimeInput({ disabled: false});
      		$('#ondeliverydate').jqxDateTimeInput({ disabled: false});
      		$('#ondeliverytime').jqxDateTimeInput({ disabled: false});
      		
   			$('#refno').prop('readonly', true);
   			$('#refname').prop('readonly', true);
   			$('#txtfleetno').prop('readonly', true);
   			$('#txtfleetname').prop('readonly', true);
   			$('#outkm').prop('readonly', true);
   			$('#txtbranch').prop('readonly', true);
   			$('#txtlocation').prop('readonly', true);
   			$('#user').prop('readonly', true);
   			$('#outbranch').prop('readonly', true);
   			$('#outlocation').prop('readonly', true);
   			$('#txtoutfleetno').prop('readonly', true);
   			$('#txtoutfleetname').prop('readonly', true);
   			$('#outuser').prop('readonly', true);
   			$('#dateout').val(new Date());
   			$('#collectdriver').prop('readonly',true);
   			$('#deliverydriver').prop('readonly',true);
   			
   			getReason(); check(); checkDelivery(); checkCollection(); getBranch();
   			
   			if(document.getElementById("mode").value=='A' && document.getElementById("chkstatus")!="1"){
   				$('input:checkbox').removeAttr('checked');
   				funResetValues();
   			}	
   	    } catch(e) { console.error("Error in funRemoveReadOnly: ", e); }
   	}
   	
   	function funResetValues(){
   		$('#refdate').jqxDateTimeInput('setDate', null);
  		$('#dateout').jqxDateTimeInput('setDate', null);
  		$('#timeout').jqxDateTimeInput('setDate', null);
  		$('#incollectdate').jqxDateTimeInput('setDate', null);
  		$('#incollecttime').jqxDateTimeInput('setDate', null);
  		$('#oncollectdate').jqxDateTimeInput('setDate', null);
  		$('#oncollecttime').jqxDateTimeInput('setDate', null);
  		$('#deliveryoutdate').jqxDateTimeInput('setDate', null);
  		$('#deliveryouttime').jqxDateTimeInput('setDate', null);
  		$('#ondeliverydate').jqxDateTimeInput('setDate', null);
  		$('#ondeliverytime').jqxDateTimeInput('setDate', null);
  		$('#refno').val('');
  		$('#referenceno').val('');
   		$('#refname').val('');
   		$('#txtfleetno').val('');
   		$('#txtfleetname').val('');
   		$('#outkm').val('');
   		$('#txtbranch').val('');
   		$('#txtlocation').val('');
   		$('#user').val('');
   		$('#outbranch').val('');
   		$('#outlocation').val('');
   		$('#txtoutfleetno').val('');
   		$('#txtoutfleetname').val('');
   		$('#outuser').val('');
   		$('#collectdriver').val('');
   		$('#deliverydriver').val('');
   		$('#incollectkm').val('');
   		$('#cmbincollectfuel').val('');
   		$('#cmbinbranch').val('');
   		$('#cmbinlocation').val('');
   		$('#ondeliverykm').val('');
   		$('#cmbondeliveryfuel').val('');
   	}
   	
   	function check(){
   		if(document.getElementById("hidchkdelivery") && document.getElementById("hidchkdelivery").value==1){
   			document.getElementById("chkdelivery").checked=true;
   			checkDelivery();
   		}
   		if(document.getElementById("hidchkdelivery") && document.getElementById("hidchkdelivery").value==0){
   			document.getElementById("chkdelivery").checked=false;
   			checkDelivery();
   		}
   		if(document.getElementById("hidchkcollection") && document.getElementById("hidchkcollection").value==1){
   			document.getElementById("chkcollection").checked=true;
   			checkCollection();
   		}
   		if(document.getElementById("hidchkcollection") && document.getElementById("hidchkcollection").value==0){
   			document.getElementById("chkcollection").checked=false;
   			checkCollection();
   		}	
   	}
   	
   	function funSearchLoad(){
  		 changeContent('mainSearch.jsp'); 
  	}
  	
   	function funNotify(){
   		var docdateval=funDateInPeriod($('#date').jqxDateTimeInput('getDate'));
			if(docdateval==0){
				$('#date').jqxDateTimeInput('focus');
				return false;
			}
			else{
				if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="";
			}
   		var reptype=document.getElementById("cmbreplacetype").value;
   		var outkm=parseFloat(document.getElementById("outkm").value);
   		var dateout1=new Date($('#dateout').jqxDateTimeInput('getDate'));
  	 	var timeout1=new Date($('#timeout').jqxDateTimeInput('getDate'));
  	 	dateout1.setHours(0,0,0,0);
  	 	var x=checkfuturedate();
  	 	if(x==false){ return 0; }
  	 	
  	 	if(document.getElementById("refno").value==''){
  	 	    if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Ref No Should Not be Empty";
			document.getElementById("refno").focus();
			return 0;
  	 	}
  	 	
   		if(reptype=='atbranch'){
   			if($('#incollectdate').jqxDateTimeInput('getDate')==null){
   				if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="In Date is Mandatory";
   				$('#incollectdate').jqxDateTimeInput('focus'); 
   				return 0;	
   			}
   			var atbranchindateval=funDateInPeriod($('#incollectdate').jqxDateTimeInput('getDate'));
 			if(atbranchindateval==0){
 				$('#incollectdate').jqxDateTimeInput('focus');
 				return 0;
 			}
   			if($('#incollecttime').jqxDateTimeInput('getDate')==null){
   				if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="In Time is Mandatory";
   				$('#incollecttime').jqxDateTimeInput('focus'); 
   				return 0;	
   			}
   			
   			var incollectdate1=new Date($('#incollectdate').jqxDateTimeInput('getDate'));
 	 	    incollectdate1.setHours(0,0,0,0);
   			var incollecttime1=new Date($('#incollecttime').jqxDateTimeInput('getDate'));
			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="";
			var ondeliverydate1=new Date($('#ondeliverydate').jqxDateTimeInput('getDate'));
			ondeliverydate1.setHours(0,0,0,0);
			var ondeliverytime1=new Date($('#ondeliverytime').jqxDateTimeInput('getDate'));
			
   			if(incollectdate1<dateout1){
   				if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="In Date Should Not be less than Fleet Date";
   				$('#incollectdate').jqxDateTimeInput('focus'); 
				return 0;
   			}
   			if(incollectdate1-dateout1==0){
    		 	if(incollecttime1.getHours()<timeout1.getHours()){
    				if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="In Time Should Not be less than Fleet Time";
    				$('#incollecttime').jqxDateTimeInput('focus'); 
    				return 0;
   				}
    		 	else if(incollecttime1.getHours()==timeout1.getHours()){
    		 		if(incollecttime1.getMinutes()<timeout1.getMinutes()){
    		 			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="In Time Should Not be less than Fleet Time";
    		 			$('#incollecttime').jqxDateTimeInput('focus'); 
        				return 0;	
    		 		}
    		 	}
   			}
   			if(document.getElementById("incollectkm").value=='' || parseFloat(document.getElementById("incollectkm").value)==0.0){
   				if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="In KM cannot be Empty";
   				document.getElementById("incollectkm").focus();
   				return 0;
   			}
   			if(parseFloat(document.getElementById("incollectkm").value)<outkm){
   				if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="In KM Should Not be less than Out Km";
   				document.getElementById("incollectkm").focus();
   				return 0;
   			}
   			if(document.getElementById("cmbincollectfuel").value==''){
   				if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Please select In Fuel";
   				document.getElementById("cmbincollectfuel").focus();
   				return 0;
   			}
   			if(document.getElementById("cmbinbranch").value==''){
   				if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="In Branch Cannot be Empty";
   				document.getElementById("cmbinbranch").focus();
   				return 0;
   			}
   			if(document.getElementById("cmbinlocation").value==''){
   				if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="In Location Cannot be Empty";
   				document.getElementById("cmbinlocation").focus();
   				return 0;
   			}
   			
 			if(ondeliverydate1<incollectdate1){
 				if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Out Date cannot be less than In Date";
 				$('#ondeliverydate').jqxDateTimeInput('focus'); 
     			return 0;
 			}
 			if(incollectdate1-ondeliverydate1==0){
 				if(ondeliverytime1.getHours()<incollecttime1.getHours()){
         			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Out Time cannot be less than In Time";
         			$('#ondeliverytime').jqxDateTimeInput('focus'); 
         			return 0;
 				}
 				if(ondeliverytime1.getHours()==incollecttime1.getHours()){
 					if(ondeliverytime1.getMinutes()<incollecttime1.getMinutes()){
         				if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Out Time cannot be less than Vehicle In Time";
         				$('#ondeliverytime').jqxDateTimeInput('focus'); 
         				return 0;
 					}
 				}
 			}
   		}
   		
   		if(document.getElementById("txtoutfleetno").value==''){
   			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Out Fleet Cannot be Empty";
   			document.getElementById("txtoutfleetno").focus();
   			return 0;
   		}
   		if($('#ondeliverydate').jqxDateTimeInput('getDate')==null){
   			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Out Date is Mandatory";
   			$('#ondeliverydate').jqxDateTimeInput('focus'); 
   			return 0;
   		}
   		var outdateval=funDateInPeriod($('#ondeliverydate').jqxDateTimeInput('getDate'));
		if(outdateval==0){
			$('#ondeliverydate').jqxDateTimeInput('focus');
			return 0;
		}
		
   		if($('#ondeliverytime').jqxDateTimeInput('getDate')==null){
   			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Out Time is Mandatory";
   			$('#ondeliverytime').jqxDateTimeInput('focus'); 
   			return 0;
   		}
   		
   		var ondeliverydate=new Date($('#ondeliverydate').jqxDateTimeInput('getDate'));
   		ondeliverydate.setHours(0,0,0,0);       		
   		var ondeliverytime=new Date($('#ondeliverytime').jqxDateTimeInput('getDate'));
   		if(ondeliverydate<dateout1){
   			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Out Date cannot be less than Agreement Date";
   			$('#ondeliverydate').jqxDateTimeInput('focus');
   			return 0;
   		}
   		if(ondeliverydate-dateout1==0){
   			if(ondeliverytime.getHours()<timeout1.getHours()){
       			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Out Time cannot be less than Agreement Time";
       			$('#ondeliverytime').jqxDateTimeInput('focus');
       			return 0;	
   			}
   			if(ondeliverytime.getHours()==timeout1.getHours()){
   				if(ondeliverytime.getMinutes()<timeout1.getMinutes()){
           			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Out Time cannot be less than Agreement Time";
           			$('#ondeliverytime').jqxDateTimeInput('focus');
           			return 0;	
   				}
   			}
   		}
   		
   		var outTimeStatus=funFutureTimeValidate(ondeliverydate,ondeliverytime);
		if(outTimeStatus==-1 || outTimeStatus==-2){
			if(outTimeStatus==-1){
				if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Future Date is not allowed";
	 			return false;
			}
			if(outTimeStatus==-2){
				if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Future Time is not allowed";
	 			return false;
			}
		}
		
   		if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="";
   		dateenable();
   		$('#frmReplacement input').attr('disabled',false);
   		$('#frmReplacement select').attr('disabled',false);
   		return 1;
   	} 

   	function funChkButton() { }

   	function funFocus(){
   	   	$('#date').jqxDateTimeInput('focus'); 	    		
   	}
   	
   	function chkCollection(){ }
   	
    function dateenable(){
    	$('#date').jqxDateTimeInput({ disabled: false});
    	$('#refdate').jqxDateTimeInput({ disabled: false});
    	$('#dateout').jqxDateTimeInput({ disabled:false});
    	$('#timeout').jqxDateTimeInput({ disabled: false});
    	$('#incollectdate').jqxDateTimeInput({ disabled:false});
    	$('#incollecttime').jqxDateTimeInput({ disabled: false});
    	$('#oncollectdate').jqxDateTimeInput({ disabled: false});
    	$('#oncollecttime').jqxDateTimeInput({ disabled: false});
    	$('#deliveryoutdate').jqxDateTimeInput({ disabled: false});
    	$('#deliveryouttime').jqxDateTimeInput({ disabled: false});
    	$('#ondeliverydate').jqxDateTimeInput({ disabled: false});
    	$('#ondeliverytime').jqxDateTimeInput({ disabled: false});
    }
    
   	function getReason() {
   		var x = new XMLHttpRequest();
   		x.onreadystatechange = function() {
   			if (x.readyState == 4 && x.status == 200) {
   				var items = x.responseText;
   				items = items.split('***');
   				var statusItems = items[0].split(",");
   				var statusIdItems = items[1].split(",");
   				var optionsstatus = '<option value="">--Select--</option>';
   				for (var i = 0; i < statusItems.length; i++) {
   					optionsstatus += '<option value="' + statusIdItems[i] + '">'
   							+ statusItems[i] + '</option>';
   				}
   				$("select#cmbtrreason").html(optionsstatus);
   				if ($('#hidcmbtrreason').length && $('#hidcmbtrreason').val() != null) {
   					$('#cmbtrreason').val($('#hidcmbtrreason').val());
   				}
   			}
   		}
   		x.open("GET", "getReason.jsp", true);
   		x.send();
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
   				$("select#cmbinbranch").html(optionsbranch);
   				$("select#cmbagmtbranch").html(optionsbranch);
   				
   				if ($('#hidcmbagmtbranch').length && $('#hidcmbagmtbranch').val() != null) {
   					$('#cmbagmtbranch').val($('#hidcmbagmtbranch').val());
   				}
   				if ($('#hidcmbinbranch').length && $('#hidcmbinbranch').val() != null) {
   					$('#cmbinbranch').val($('#hidcmbinbranch').val());
   				}
   			}
   		}
   		x.open("GET", "getBranch.jsp", true);
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
   				$("select#cmbinlocation").html(optionslocation);
   				if ($('#hidcmbinlocation').length && $('#hidcmbinlocation').val() != null) {
   					$('#cmbinlocation').val($('#hidcmbinlocation').val());
   				}
   			}
   		}
   		x.open("GET", "getLoc.jsp?id="+value, true);
   		x.send();
   	}
   	
   	function checkCollection(){
   		if(document.getElementById("chkcollection") && document.getElementById("chkcollection").checked==false){
   			document.getElementById("hidchkcollection").value="0";
   			$('#collectdriver').prop('disabled',true);
   			$('#oncollectdate').jqxDateTimeInput({ disabled: true});
   			$('#oncollecttime').jqxDateTimeInput({ disabled: true});
   			$('#oncollectkm').prop('disabled',true);
   			$('#cmboncollectfuel').prop('disabled',true);
   		}
   		if(document.getElementById("chkcollection") && document.getElementById("chkcollection").checked==true){
   			document.getElementById("hidchkcollection").value="1";
   			$('#collectdriver').prop('disabled',false);
   			$('#oncollectdate').jqxDateTimeInput({ disabled: false});
   			$('#oncollecttime').jqxDateTimeInput({ disabled: false});
   			$('#oncollectkm').prop('disabled',false);
   			$('#oncollectkm').prop('readonly',false);
   			$('#cmboncollectfuel').prop('disabled',false);
   		}
   	}
   	
   	function checkDelivery(){
   		if(document.getElementById("chkdelivery") && document.getElementById("chkdelivery").checked==false){
   			document.getElementById("hidchkdelivery").value="0";
   			$('#deliverydriver').prop('disabled',true);
   			$('#deliveryoutdate').jqxDateTimeInput({ disabled: true});
   			$('#deliveryouttime').jqxDateTimeInput({ disabled: true});
   			$('#deliveryto').prop('disabled',true);
   			$('#cmbdeliveryoutfuel').prop('disabled',true);
   			$('#deliveryoutkm').prop('disabled',false);
   		}
   		if(document.getElementById("chkdelivery") && document.getElementById("chkdelivery").checked==true){
   			document.getElementById("hidchkdelivery").value="1";
   			$('#deliverydriver').prop('disabled',false);
   			$('#deliveryoutdate').jqxDateTimeInput({ disabled: false});
   			$('#deliveryouttime').jqxDateTimeInput({ disabled: false});
   			$('#deliveryoutkm').prop('readonly',false);
   			$('#cmbdeliveryoutfuel').prop('disabled',false);
   			$('#ondeliverykm').prop('disabled',false);
   			$('#cmbondeliveryfuel').prop('disabled',false);
   			$('#deliveryto').prop('disabled',false);
   			$('#deliveryto').prop('readonly',false);
   		}
   	}
   	
    /* SAFE SET VALUES FUNCTION */
   	function setValues(){
   	    try {
           	if($('#hidoncollecttime').length && $('#hidoncollecttime').val()){
        		$("#oncollecttime").jqxDateTimeInput('val', $('#hidoncollecttime').val());
        	}
           	if($('#hiddeliveryouttime').length && $('#hiddeliveryouttime').val()){
        		$("#deliveryouttime").jqxDateTimeInput('val', $('#hiddeliveryouttime').val());
        	}
           	if($('#hidtimeout').length && $('#hidtimeout').val()){
        		$("#timeout").jqxDateTimeInput('val', $('#hidtimeout').val());
        	}
           	if($('#hidincollecttime').length && $('#hidincollecttime').val()){
        		$("#incollecttime").jqxDateTimeInput('val', $('#hidincollecttime').val());
        	}
           	if($('#hidondeliverytime').length && $('#hidondeliverytime').val()){
        		$("#ondeliverytime").jqxDateTimeInput('val', $('#hidondeliverytime').val());
        	}
        	
           	if ($('#hidcmbrentaltype').length && $('#hidcmbrentaltype').val() != null) {
    			$('#cmbrentaltype').val($('#hidcmbrentaltype').val());
    		}
           	if ($('#hidcmbtrreason').length && $('#hidcmbtrreason').val() != null) {
           		$('#cmbtrreason').val($('#hidcmbtrreason').val());
           	}
           	if ($('#hidcmbreplacetype').length && $('#hidcmbreplacetype').val() != null) {
           		$('#cmbreplacetype').val($('#hidcmbreplacetype').val());
           	}
           	if ($('#hidcmbfuel').length && $('#hidcmbfuel').val() != null) {
           		$('#cmbfuel').val($('#hidcmbfuel').val());
           	}
           	if ($('#hidcmboncollectfuel').length && $('#hidcmboncollectfuel').val() != null) {
           		$('#cmboncollectfuel').val($('#hidcmboncollectfuel').val());
           	}
           	if ($('#hidcmbincollectfuel').length && $('#hidcmbincollectfuel').val() != null) {
           		$('#cmbincollectfuel').val($('#hidcmbincollectfuel').val());
           	}
           	if ($('#hidcmbinbranch').length && $('#hidcmbinbranch').val() != null) {
           		$('#cmbinbranch').val($('#hidcmbinbranch').val());
           	}
           	if ($('#hidcmbinlocation').length && $('#hidcmbinlocation').val() != null) {
           		$('#cmbinlocation').val($('#hidcmbinlocation').val());
           	}
           	if ($('#hidcmbdeliveryoutfuel').length && $('#hidcmbdeliveryoutfuel').val() != null) {
           		$('#cmbdeliveryoutfuel').val($('#hidcmbdeliveryoutfuel').val());
           	}
           	if ($('#hidcmbondeliveryfuel').length && $('#hidcmbondeliveryfuel').val() != null) {
           		$('#cmbondeliveryfuel').val($('#hidcmbondeliveryfuel').val());
           	}
           	
           	if($('#msg').length && $('#msg').val()!=""){
           	    $.messager.alert('Message',$('#msg').val());
           	}
           	
            if (document.getElementById("formdet") && $('#formdetail').length && $('#formdetailcode').length) {
                 var detailVal = $('#formdetail').val() || "";
                 var codeVal = $('#formdetailcode').val() || "";
                 document.getElementById("formdet").innerText = detailVal + " (" + codeVal.trim() + ")";
            }
            
           	if(document.getElementById("cmbreplacetype") && document.getElementById("cmbreplacetype").value=="atbranch"){
           		if(document.getElementById("btnupdate")) document.getElementById("btnupdate").disabled=true;
           	} else if(document.getElementById("cmbreplacetype") && document.getElementById("cmbreplacetype").value=="collection"){
           		if(document.getElementById("btnupdate")) document.getElementById("btnupdate").disabled=false;
           	}
           	
           	if(document.getElementById("incollectkm") && document.getElementById("incollectkm").value!='' && parseFloat(document.getElementById("incollectkm").value)>0){
           		if(document.getElementById("btnupdate")) document.getElementById("btnupdate").disabled=true;
           	}
           	
           	if(document.getElementById("chkcollection")) document.getElementById("chkcollection").disabled=true;
           	if(document.getElementById("chkdelivery")) document.getElementById("chkdelivery").disabled=true;
    		
    		if(document.getElementById("docno") && document.getElementById("docno").value!=""){
    			getCancelStatus(document.getElementById("docno").value);
    		}
   	    } catch(e) { console.error("Error in setValues: ", e); }
   	}
		
	function getCancelStatus(value) {
    	var x = new XMLHttpRequest();
    	x.onreadystatechange = function() {
    		if (x.readyState == 4 && x.status == 200) {
    			var items = x.responseText.trim();
    			if(items=="1" && document.getElementById("lblcancelstatus")){
    				document.getElementById("lblcancelstatus").innerText="CANCELLED";
    			}
    			else if(document.getElementById("lblcancelstatus")){
    				document.getElementById("lblcancelstatus").innerText="";
    			}
    		}
    	}
    	x.open("GET", "getCancelStatus.jsp?id="+value, true);
    	x.send();
    }
		
  	function isNumber(evt,id) {
  	    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
  	    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
  	    	 $.messager.alert('Warning','Enter Numbers Only');
  	       $("#"+id+"").focus();
  	        return false;
  	    }
  	    return true;
  	}
  	
   	function checkReplace(){
   		var temp=document.getElementById("cmbreplacetype").value;
   		if(temp=='atbranch'){
   			document.getElementById("hidchkdelivery").value=0;
   			$('#deliverydriver').prop('disabled',true);
   			$('#deliveryoutdate').jqxDateTimeInput({ disabled: true});
   			$('#deliveryouttime').jqxDateTimeInput({ disabled: true});
   			$('#deliveryoutkm').prop('disabled',true);
   			$('#cmbdeliveryoutfuel').prop('disabled',true);
   			$('#deliveryto').prop('disabled',true);
   			document.getElementById("hidchkcollection").value=0;
   			$('#collectdriver').prop('disabled',true);
   			$('#oncollectdate').jqxDateTimeInput({ disabled: true});
   			$('#oncollecttime').jqxDateTimeInput({ disabled: true});
   			$('#oncollectkm').prop('disabled',true);
   			$('#cmboncollectfuel').prop('disabled',true);
   			if(document.getElementById("btnupdate")) document.getElementById("btnupdate").style.display="none";
   			$('#chkdelivery').prop('disabled',true);
   			$('#chkcollection').prop('disabled',true);
   			$('#incollectdate').jqxDateTimeInput({ disabled: false});
   			$('#incollecttime').jqxDateTimeInput({ disabled: false});
   			$('#incollectkm').prop('disabled',false);
   			$('#incollectkm').prop('readonly',false);
   			$('#cmbincollectfuel').prop('disabled',false);
   			$('#cmbinbranch').prop('disabled',false);
   			$('#cmbinlocation').prop('disabled',false);
   			$('#incollectdate').jqxDateTimeInput('focus');
   		}
   		if(temp=='collection'){
       	  if(document.getElementById("mode").value=='A'){
       		$('#oncollectdate').jqxDateTimeInput({ disabled: true});
  			$('#oncollecttime').jqxDateTimeInput({ disabled: true});
  			$('#oncollectkm').prop('disabled',true);
  			$('#oncollectkm').prop('readonly',true);
  			$('#cmboncollectfuel').prop('disabled',true);
       		$('#incollectdate').jqxDateTimeInput({ disabled: true});
  			$('#incollecttime').jqxDateTimeInput({ disabled: true});
  			$('#incollectkm').prop('disabled',true);
  			$('#incollectkm').prop('readonly',true);
  			$('#cmbincollectfuel').prop('disabled',true);
  			$('#cmbinbranch').prop('disabled',true);
  			$('#cmbinlocation').prop('disabled',true);
  			document.getElementById("txtoutfleetno").focus();
  			$('#chkdelivery').prop('disabled',true);
  			$('#chkcollection').prop('disabled',true);
  			checkDelivery();
  			checkCollection();
       	  }
   		  if(document.getElementById("docno").value>0 && document.getElementById("btnupdate")){
   			  document.getElementById("btnupdate").style.display="block";
   		  }
   		}
   	}
   	
   	function funupdate(){
   		document.getElementById("chkcollection").disabled=false;
		document.getElementById("chkdelivery").disabled=false;
   		$('#incollectdate').jqxDateTimeInput({ disabled: false});
		$('#incollecttime').jqxDateTimeInput({ disabled: false});
		$('#incollectkm').prop('disabled',false);
		$('#incollectkm').prop('readonly',false);
		$('#cmbincollectfuel').prop('disabled',false);
		$('#cmbinbranch').prop('disabled',false);
		$('#cmbinlocation').prop('disabled',false);
		$('#ondeliverydate').jqxDateTimeInput({ disabled: false});
		$('#ondeliverytime').jqxDateTimeInput({ disabled: false});
		$('#ondeliverykm').prop('disabled',false);
		$('#ondeliverykm').prop('readonly',false);
		$('#cmbondeliveryfuel').prop('disabled',false);
		
		if(document.getElementById("btnupdate")) document.getElementById("btnupdate").style.display="none";
		if(document.getElementById("btnsave")) document.getElementById("btnsave").style.display="block";
		
		$('#cmbtrreason').prop('disabled',false);
		$('#indesc').prop('readonly',false);
   	}
   	
   	function funsave(){
		$('#dateout').jqxDateTimeInput({ disabled: false});
		$('#timeout').jqxDateTimeInput({ disabled: false});
   		var oncollectdate1=new Date($('#oncollectdate').jqxDateTimeInput('getDate'));
   		oncollectdate1.setHours(0,0,0,0);
		var oncollecttime1=new Date($('#oncollecttime').jqxDateTimeInput('getDate'));
		var outkm=document.getElementById("outkm").value;
		var dateout1=new Date($('#dateout').jqxDateTimeInput('getDate'));
		dateout1.setHours(0,0,0,0);
		var timeout1=new Date($('#oncollecttime').jqxDateTimeInput('getDate'));
		var deliveryoutdate1=new Date($('#deliveryoutdate').jqxDateTimeInput('getDate'));
		var deliveryouttime1=new Date($('#deliveryouttime').jqxDateTimeInput('getDate'));
		var ondeliverydate1=new Date($('#ondeliverydate').jqxDateTimeInput('getDate'));
		ondeliverydate1.setHours(0,0,0,0);
		deliveryoutdate1.setHours(0,0,0,0);
		var ondeliverytime1=new Date($('#ondeliverytime').jqxDateTimeInput('getDate'));
		$('#dateout').jqxDateTimeInput({ disabled: true});
		$('#timeout').jqxDateTimeInput({ disabled: true});
		var incollectdate1=new Date($('#incollectdate').jqxDateTimeInput('getDate'));
		var incollecttime1=new Date($('#incollecttime').jqxDateTimeInput('getDate'));
		incollectdate1.setHours(0,0,0,0);
		
		if(document.getElementById("chkcollection").checked==false && document.getElementById("chkdelivery").checked==false){
   			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Collection/Delivery is Mandatory";
   			return false;
   		}
   		if(document.getElementById("chkcollection").checked==true){
   			var collectTimeStatus=funFutureTimeValidate(oncollectdate1,oncollecttime1);
   			if(collectTimeStatus==-1 || collectTimeStatus==-2){
   				if(collectTimeStatus==-1){
   					if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Future Date is not allowed";
   	 	 			return false;
   				}
   				if(collectTimeStatus==-2){
   					if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Future Time is not allowed";
   	 	 			return false;
   				}
   			}
   			if(document.getElementById("collectdriver").value==''){
   				if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Please Select Collection Driver";
   				document.getElementById("collectdriver").focus();
   				return false;
   			}
   			if($('#oncollectdate').jqxDateTimeInput('getDate')==null){
   	 			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Collection Date is Mandatory";
   	 			$('#oncollectdate').jqxDateTimeInput('focus'); 
   	 			return false;
   			}
   			
   			var collectdateval=funDateInPeriod($('#oncollectdate').jqxDateTimeInput('getDate'));
   			if(collectdateval==0){
   				$('#oncollectdate').jqxDateTimeInput('focus');
   				return false;
   			} else {
   				if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="";
   			}
   			if($('#oncollecttime').jqxDateTimeInput('getDate')==null){
   	 			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Collection Time is Mandatory";
   	 			$('#oncollecttime').jqxDateTimeInput('focus'); 
   	 			return false;
   			}
   			if($('#incollectdate').jqxDateTimeInput('getDate')==null){
   	 			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="In Date is Mandatory";
   	 			$('#incollectdate').jqxDateTimeInput('focus'); 
   	 			return false;
   			}
   			var colindateval=funDateInPeriod($('#incollectdate').jqxDateTimeInput('getDate'));
   			if(colindateval==0){
   				$('#incollectdate').jqxDateTimeInput('focus');
   				return false;
   			} else {
   				if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="";
   			}
   			if($('#incollecttime').jqxDateTimeInput('getDate')==null){
   	 			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="In Time is Mandatory";
   	 			$('#incollecttime').jqxDateTimeInput('focus'); 
   	 			return false;
   			}
   			
   			if(oncollectdate1<ondeliverydate1){
   				if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Collect Date cannot be less than Vehicle out Date";
   				$('#oncollectdate').jqxDateTimeInput('focus'); 
   	 			return false;
   			}
   			if(oncollectdate1-ondeliverydate1==0){
   				if(oncollecttime1.getHours()<ondeliverytime1.getHours()){
   	 			    if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Collection Time cannot be less than Vehicle out Time";
   	 			    $('#oncollecttime').jqxDateTimeInput('focus'); 
   	 			    return false;
   				}
   				if(oncollecttime1.getHours()==ondeliverytime1.getHours()){
   					if(oncollecttime1.getMinutes()<ondeliverytime1.getMinutes()){
   	 	 			    if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Collection Time cannot be less than Vehicle out Time";
   	 	 			    $('#oncollecttime').jqxDateTimeInput('focus'); 
   	 	 			    return false;
   					}
   				}
   			}
   			
   			if(incollectdate1<oncollectdate1){
   				if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="In Date Cannot be less than Collection Date";
   				$('#incollectdate').jqxDateTimeInput('focus');
   				return false;
   			}	
   			if(incollectdate1-oncollectdate1==0){
   				if(incollecttime1.getHours()<oncollecttime1.getHours()){
   	 			    if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Collection Time Cannot be less than In Time";
   	 			    $('#oncollecttime').jqxDateTimeInput('focus');
   	 			    return false;
   				}
   				if(incollecttime1.getHours()==oncollecttime1.getHours()){
   					if(incollecttime1.getMinutes()<oncollecttime1.getMinutes()){
   	 	 			    if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Collection Time Cannot be less than In Time";
   	 	 			    $('#incollecttime').jqxDateTimeInput('focus');
   	 	 			    return false;	
   					}
   				}
   			}
   			if(document.getElementById("oncollectkm").value==''){
   				if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Collection Km cannot be Empty";
   				document.getElementById("oncollectkm").focus();
   				return false;
   			}
   			if(parseFloat(document.getElementById("oncollectkm").value)==0.0){
   				if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Collection Km cannot be Empty";
   				document.getElementById("oncollectkm").focus();
   				return false;
   			}
   			if(parseFloat(document.getElementById("oncollectkm").value)<parseFloat(outkm)){
   				if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Collection Km cannot be less than Agreement Km";
   				document.getElementById("oncollectkm").focus();
   				return false;
   			}
   			if(document.getElementById("cmboncollectfuel").value==''){
   				if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Please select Collect fuel";
   				document.getElementById("cmboncollectfuel").focus();
   				return false;
   			}
   			
   			if(parseFloat(document.getElementById("incollectkm").value)<parseFloat(document.getElementById("oncollectkm").value)){
   				if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="In Km Cannot be less than Collection Km";
   				document.getElementById("incollectkm").focus();
   				return false;
   			}
   		}
   		
   		if(document.getElementById("incollectkm").value==''){
   			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="In Km cannot be Empty";
   			document.getElementById("incollectkm").focus();
   			return false;
   		}
   		if(parseFloat(document.getElementById("incollectkm").value)==0.0){
   			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="In Km cannot be Empty";
   			document.getElementById("incollectkm").focus();
   			return false;
   		}
   		if(parseFloat(document.getElementById("incollectkm").value)<parseFloat(outkm)){
   			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="In Km Cannot be less than Agreement Km";
   			document.getElementById("incollectkm").focus();
   			return false;
   		}
   		if(document.getElementById("cmbincollectfuel").value==''){
   			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="In Fuel cannot be Empty";
   			document.getElementById("cmbincollectfuel").focus();
   			return false;
   		}
   		if(document.getElementById("cmbinbranch").value==''){
   			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Select In Branch";
   			document.getElementById("cmbinbranch").focus();
   			return false;
   		}
   		if(document.getElementById("cmbinlocation").value==''){
   			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Select In Location";
   			document.getElementById("cmbinlocation").focus();
   			return false;
   		}
   			
		if(incollectdate1<ondeliverydate1){
			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="In Date cannot be less than Vehicle out Date";
			$('#incollectdate').jqxDateTimeInput('focus'); 
 			return false;
		}
		if(incollectdate1-ondeliverydate1==0){
			if(incollecttime1.getHours()<ondeliverytime1.getHours()){
	 			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="In Time cannot be less than Vehicle out Time";
	 			$('#incollecttime').jqxDateTimeInput('focus'); 
	 			return false;
			}
			if(incollecttime1.getHours()==ondeliverytime1.getHours()){
				if(incollecttime1.getMinutes()<ondeliverytime1.getMinutes()){
	 	 			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="In Time cannot be less than Vehicle out Time";
	 	 			$('#incollecttime').jqxDateTimeInput('focus'); 
	 	 			return false;
				}
			}
		}
			
   		if(document.getElementById("chkdelivery").checked==true){
   			var delTimeStatus=funFutureTimeValidate(deliveryoutdate1,deliveryouttime1);
   			if(delTimeStatus==-1 || delTimeStatus==-2){
   				if(delTimeStatus==-1){
   					if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Future Date is not allowed";
   	 	 			return false;
   				}
   				if(delTimeStatus==-2){
   					if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Future Time is not allowed";
   	 	 			return false;
   				}
   			}
   			
   			if(document.getElementById("deliverydriver").value==''){
   	 			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Please Select Driver";
   	 			document.getElementById("deliverydriver").focus();
   	 			return false;
   			}
   			if($('#deliveryoutdate').jqxDateTimeInput('getDate')==null){
   	 			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Delivery Date is Mandatory";
   	 			$('#deliveryoutdate').jqxDateTimeInput('focus'); 
   	 			return false;
   			}
   			
   			var deliverydateval=funDateInPeriod($('#deliveryoutdate').jqxDateTimeInput('getDate'));
   			if(deliverydateval==0){
   				$('#deliveryoutdate').jqxDateTimeInput('focus');
   				return false;
   			} else {
   				if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="";
   			}
   			if($('#deliveryouttime').jqxDateTimeInput('getDate')==null){
   	 			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Delivery Time is Mandatory";
   	 			$('#deliveryouttime').jqxDateTimeInput('focus'); 
   	 			return false;
   			}
    		if(deliveryoutdate1<ondeliverydate1){
    			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Delivery Date cannot be less than Out Date";
    			$('#deliveryoutdate').jqxDateTimeInput('focus'); 
    			return false;
    		}
    		if(deliveryoutdate1-ondeliverydate1==0){
    			if(deliveryouttime1.getHours()<ondeliverytime1.getHours()){
        			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Delivery Time cannot be less than Out Time";
        			$('#deliveryouttime').jqxDateTimeInput('focus'); 
        			return false;
    			}
    			if(deliveryouttime1.getHours()==ondeliverytime1.getHours()){
        			if(deliveryouttime1.getMinutes()<ondeliverytime1.getMinutes()){
            			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Delivery Time cannot be less than Out Time";
            			$('#deliveryouttime').jqxDateTimeInput('focus'); 
            			return false;
        			}
    			}
    		}
    		if(document.getElementById("chkcollection").checked==true){
    			if(deliveryoutdate1<oncollectdate1){
        			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Delivery Date cannot be less than Collection Date";
        			$('#deliveryouttime').jqxDateTimeInput('focus'); 
        			return false;
        		}
        		if(deliveryoutdate1-oncollectdate1==0){
        			if(deliveryouttime1.getHours()<oncollecttime1.getHours()){
            			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Delivery Time cannot be less than Collection Time";
            			$('#deliveryouttime').jqxDateTimeInput('focus'); 
            			return false;
        			}
        			if(deliveryouttime1.getHours()==oncollecttime1.getHours()){
        				if(deliveryouttime1.getMinutes()<=oncollecttime1.getMinutes()){
            				if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Delivery Time must be Greater than Collection Time";
            				$('#deliveryouttime').jqxDateTimeInput('focus'); 
            				return false;
        				}
        			}
        		}
    		}
    		
   			if(document.getElementById("deliveryoutkm").value==''){
    			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Delivery Km cannot be Empty";
    			document.getElementById("deliveryoutkm").focus();
    			return false;
   			}	
   			if(parseFloat(document.getElementById("deliveryoutkm").value)==0.0){
    			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Delivery Km cannot be Empty";
    			document.getElementById("deliveryoutkm").focus();
    			return false;
   			}
   			if(parseFloat(document.getElementById("deliveryoutkm").value)<parseFloat(document.getElementById("ondeliverykm").value)){
    			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Delivery Km Cannot be Less than Out Km";
    			document.getElementById("deliveryoutkm").focus();
    			return false;
   			}
   			if(document.getElementById("cmbdeliveryoutfuel").value==""){
    			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Please Select Delivery Fuel";
    			document.getElementById("cmbdeliveryoutfuel").focus();
    			return false;
   			}
   		}
   		
   		var inTimeStatus=funFutureTimeValidate(incollectdate1,incollecttime1);
		if(inTimeStatus==-1 || inTimeStatus==-2){
			if(inTimeStatus==-1){
				if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Future Date is not allowed";
	 			return false;
			}
			if(inTimeStatus==-2){
				if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Future Time is not allowed";
	 			return false;
			}
		}
		
   		if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="";
   		document.getElementById("mode").value="update";
   		dateenable();
   		$('#cmbondeliveryfuel').attr('disabled',false);
   		$('#cmbdeliveryoutfuel').attr('disabled',false);
   		
   		if(document.getElementById("btnSave")) document.getElementById("btnSave").mousedown();
   	}
   	
   	$(function(){
	    $('#frmReplacement').validate({
	        rules: {
                cmbtrreason:"required",
                cmbreplacetype:"required",
                refno:"required",
                txtoutfleetno:"required",
                cmbrentaltype:"required",
                description:{ maxlength:250 }
            },
            messages: {
           	    cmbtrreason:" *",
           	    cmbreplacetype:" *",
           	    refno:" *",
           	    txtoutfleetno:" *",
           	    cmbrentaltype:" *",
           	    description:{ maxlength:"max 250 chars" }
            }
	     });
    });
   	
   	/* FIXED: Bulletproof Print Function Routing */
   	function funPrintBtn(){
        var rfleetno=$('#txtfleetno').val();
        var ofleetno=$('#txtoutfleetno').val();
        var docno = document.getElementById("docno").value;

        if(!docno || docno === ""){
            $.messager.alert('Message', 'Select a Document....!', 'warning');
            return false;
        }

        var url = window.location.href;
        // Safely extract base path up to the last slash
        var baseUrl = url.substring(0, url.lastIndexOf('/') + 1);
        var printUrl = baseUrl + "printReplacementss?docno=" + docno + "&rfleetno=" + rfleetno + "&ofleetno=" + ofleetno;

        var win = window.open(printUrl, "_blank", "top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
        win.focus(); 
   	} 
   	
	function funFutureTimeValidate(paramdate,paramtime){
		var curdate=new Date();
		var curtime=new Date();
		paramdate=new Date(paramdate);
		paramdate.setHours(0,0,0,0);
		curdate.setHours(0,0,0,0);
		
		if(paramdate>curdate){
			return -1;
		}
		else if(paramdate-curdate==0){
			if(parseInt(paramtime.getHours())>curtime.getHours()){
				return -2;
			}
			else if(parseInt(paramtime.getHours())==curtime.getHours()){
				if(parseInt(paramtime.getMinutes())>curtime.getMinutes()){
					return -2;
				}
			}
		}
		else{
			return 0;
		}
	}
</script>
</head>

<body onload="setValues();">

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmReplacement" action="saveReplacement" autocomplete="off">
	<script>
			if(window.parent && window.parent.formName) window.parent.formName.value="Replacement";
			if(window.parent && window.parent.formCode) window.parent.formCode.value="RPL";
	</script>
	<jsp:include page="../../../../header.jsp" />
	
<div class="modern-ui hidden-scrollbar">

    <div class="erp-form-area">
        <div class="section-title">Vehicle Info As In Agreement</div>
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
            <tr>
                <td class="lbl-right" width="8%">Date</td>
                <td width="15%">
                    <div id="date" name="date" value='<s:property value="date"/>'></div>
                    <input type="hidden" id="hidddate" name="hidddate" value='<s:property value="hidddate"/>' />
                </td>
                
                <td class="lbl-right" width="10%">Rental Type</td>
                <td width="15%">
                    <select id="cmbrentaltype" name="cmbrentaltype" value='<s:property value="cmbrentaltype"/>'>
                        <option value="">--Select--</option>
                        <option value="RAG">Rental</option>
                        <option value="LAG">Lease</option>
                    </select>
                    <input type="hidden" id="hidcmbrentaltype" name="hidcmbrentaltype" value='<s:property value="hidcmbrentaltype"/>' />
                </td>
                
                <td class="lbl-right" width="8%">Branch</td>
                <td width="15%">
                    <select name="cmbagmtbranch" id="cmbagmtbranch" value='<s:property value="cmbagmtbranch"/>'>
                        <option value="">--Select--</option>
                    </select>
                    <input type="hidden" name="hidcmbagmtbranch" id="hidcmbagmtbranch" value='<s:property value="hidcmbagmtbranch"/>'>
                </td>
                
                <td class="lbl-right" width="8%">Doc No</td>
                <td width="21%">
                    <input type="text" id="docno" name="docno" style="width: 120px;" tabindex="-1" readonly value='<s:property value="docno"/>' />
                </td>
            </tr>
            
            <tr>
                <td class="lbl-right">Ref No</td>
                <td colspan="3">
                    <div style="display: flex; gap: 5px;">
                        <div class="input-search-container">
                            <input type="text" id="refvocno" name="refvocno" value='<s:property value="refvocno"/>' placeholder="Press F3" readonly onKeyDown="getAgmtno(event);" />
                            <svg class="magnifier-icon" onclick="openAgmtSearch();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                        </div>
                        <input type="text" id="refname" name="refname" style="flex-grow: 1;" value='<s:property value="refname"/>' readonly />
                    </div>
                </td>
                
                <td class="lbl-right">Ref Date</td>
                <td>
                    <div id='refdate' name='refdate' value='<s:property value="refdate"/>'></div>
                    <input type="hidden" id="hidrefdate" name="hidrefdate" value='<s:property value="hidrefdate"/>' />
                    <input type="hidden" id="hidreftime" name="hidreftime" value='<s:property value="hidreftime"/>' />
                </td>
                
                <td class="lbl-right">Ref. Extra</td>
                <td>
                    <input type="text" name="referenceno" id="referenceno" value='<s:property value="referenceno"/>' />
                </td>
            </tr>
            
            <tr>
                <td class="lbl-right">Fleet No</td>
                <td colspan="3">
                    <div style="display: flex; gap: 5px;">
                        <input type="text" id="txtfleetno" name="txtfleetno" style="width: 120px;" value='<s:property value="txtfleetno"/>' readonly />
                        <input type="text" id="txtfleetname" name="txtfleetname" style="flex-grow: 1;" value='<s:property value="txtfleetname"/>' readonly />
                    </div>
                </td>
                
                <td class="lbl-right">Date Out</td>
                <td>
                    <div id="dateout" name="dateout" value='<s:property value="dateout"/>'></div>
                    <input type="hidden" name="hiddateout" id="hiddateout" value='<s:property value="hiddateout"/>' />
                </td>
                
                <td class="lbl-right">Time Out</td>
                <td>
                    <div id="timeout" name="timeout" value='<s:property value="timeout"/>'></div>
                    <input type="hidden" id="hidtimeout" name="hidtimeout" value='<s:property value="hidtimeout"/>' />
                </td>
            </tr>
            
            <tr>
                <td class="lbl-right">Km Out</td>
                <td>
                    <input type="text" id="outkm" name="outkm" value='<s:property value="outkm"/>' readonly onkeypress="javascript:return isNumber (event,id)" />
                </td>
                
                <td class="lbl-right">Fuel Out</td>
                <td>
                    <select id="cmbfuel" name="cmbfuel" value='<s:property value="cmbfuel"/>'>
                        <option value="">--Select--</option>
                        <option value=0.000>Level 0/8</option><option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option>
                        <option value=0.500>Level 4/8</option><option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
                    </select>
                    <input type="hidden" id="hidcmbfuel" name="hidcmbfuel" value='<s:property value="hidcmbfuel"/>' />
                </td>
                
                <td class="lbl-right">Out Branch</td>
                <td>
                    <input type="text" name="txtbranch" id="txtbranch" readonly value='<s:property value="txtbranch"/>'/>
                    <input type="hidden" id="hidtxtbranch" name="hidtxtbranch" value='<s:property value="hidtxtbranch"/>'/>
                </td>
                
                <td class="lbl-right">Out Loc</td>
                <td>
                    <input type="text" name="txtlocation" id="txtlocation" readonly value='<s:property value="txtlocation"/>'/>
                    <input type="hidden" name="hidtxtlocation" id="hidtxtlocation" value='<s:property value="hidtxtlocation"/>'/>
                </td>
            </tr>

            <tr>
                <td class="lbl-right">Tr. Reason</td>
                <td colspan="3">
                    <select id="cmbtrreason" name="cmbtrreason" value='<s:property value="cmbtrreason"/>'>
                        <option value="">--Select--</option>
                    </select>
                    <input type="hidden" id="hidcmbtrreason" name="hidcmbtrreason" value='<s:property value="hidcmbtrreason"/>'/>
                </td>
                
                <td class="lbl-right">Replace Type</td>
                <td>
                    <select name="cmbreplacetype" id="cmbreplacetype" onchange="checkReplace();">
                        <option value="">--Select--</option>
                        <option value="atbranch">At Branch</option>
                        <option value="collection">Collection</option>
                    </select>
                    <input type="hidden" name="hidcmbreplacetype" id="hidcmbreplacetype" value='<s:property value="hidcmbreplacetype"/>' />
                </td>
                
                <td colspan="2" align="center">
                    <label id="lblcancelstatus" name="lblcancelstatus" style="font-size: 13px; font-weight: bold; color: #dc3545;"></label>
                </td>
            </tr>
            
            <tr>
                <td class="lbl-right" style="padding-top:10px;">Description</td>
                <td colspan="7" style="padding-top:10px;">
                    <input type="text" name="description" id="description" value='<s:property value="description"/>' />
                    <input type="hidden" name="hiduser" id="hiduser" value='<s:property value="hiduser"/>'/>
                </td>
            </tr>
        </table>
    </div>

    <div class="erp-form-area">
        <div class="section-title">
            <span>Vehicle In Info</span>
            <div style="display:flex; gap:10px;">
                <input type="button" name="btnupdate" id="btnupdate" class="myButton" value="Update" onclick="funupdate();">
                <input type="button" name="btnsave" id="btnsave" class="myButton" value="Save" onclick="funsave();">
            </div>
        </div>
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
            <tr>
                <td width="10%">
                    <div class="checkbox-group" style="justify-content: flex-end; background: transparent; border: none; margin-bottom: 0;">
                        <input type="checkbox" id="chkcollection" name="chkcollection" onchange="checkCollection();">
                        <label for="chkcollection">Collection</label>
                    </div>
                    <input type="hidden" name="hidchkcollection" id="hidchkcollection" value='<s:property value="hidchkcollection"/>'/>
                </td>
                <td width="20%">
                    <input type="text" name="collectdriver" id="collectdriver" placeholder="Press F3 to Search" value='<s:property value="collectdriver"/>' onkeydown="getCollectDriver(event);"/>
                    <input type="hidden" name="hidcollectdriver" id="hidcollectdriver" value='<s:property value="hidcollectdriver"/>'/>
                </td>
                <td class="lbl-right" width="8%">In User</td>
                <td width="15%">
                    <input type="text" id="outuser" name="outuser" value='<s:property value="outuser"/>'/>
                </td>
                <td colspan="4"></td>
            </tr>
            
            <tr>
                <td class="lbl-right">Col. Date</td>
                <td>
                    <div id="oncollectdate" name="oncollectdate" value='<s:property value="oncollectdate"/>'></div>
                    <input type="hidden" name="hidoncollectdate" id="hidoncollectdate" value='<s:property value="hidoncollectdate"/>'/>
                </td>
                <td class="lbl-right">Col. Time</td>
                <td>
                    <div id='oncollecttime' name='oncollecttime' value='<s:property value="oncollecttime"/>'></div>
                    <input type="hidden" id="hidoncollecttime" name="hidoncollecttime" value='<s:property value="hidoncollecttime"/>'/>
                </td>
                <td class="lbl-right" width="8%">Col. KM</td>
                <td width="15%">
                    <input type="text" id="oncollectkm" name="oncollectkm" value='<s:property value="oncollectkm"/>' onkeypress="javascript:return isNumber (event,id)"/>
                </td>
                <td class="lbl-right" width="8%">Col. Fuel</td>
                <td width="16%">
                    <select id="cmboncollectfuel" name="cmboncollectfuel" value='<s:property value="cmboncollectfuel"/>'>
                        <option value="">--Select--</option>
                        <option value=0.000>Level 0/8</option><option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option>
                        <option value=0.500>Level 4/8</option><option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
                    </select>
                    <input type="hidden" id="hidcmboncollectfuel" name="hidcmboncollectfuel" value='<s:property value="hidcmboncollectfuel"/>'/>
                </td>
            </tr>
            
            <tr>
                <td class="lbl-right">In Date</td>
                <td>
                    <div id="incollectdate" name="incollectdate" value='<s:property value="incollectdate"/>'></div>
                    <input type="hidden" name="hidincollectdate" id="hidincollectdate"  value='<s:property value="hidincollectdate"/>'>
                </td>
                <td class="lbl-right">In Time</td>
                <td>
                    <div id='incollecttime' name='incollecttime' value='<s:property value="incollecttime"/>'></div>
                    <input type="hidden" id="hidincollecttime" name="hidincollecttime" value='<s:property value="hidincollecttime"/>'/>
                </td>
                <td class="lbl-right">In KM</td>
                <td>
                    <input type="text" id="incollectkm" name="incollectkm" value='<s:property value="incollectkm"/>' onkeypress="javascript:return isNumber (event,id)"/>
                </td>
                <td class="lbl-right">In Fuel</td>
                <td>
                    <select id="cmbincollectfuel" name="cmbincollectfuel" value='<s:property value="cmbincollectfuel"/>'>
                        <option value="">--Select--</option>
                        <option value=0.000>Level 0/8</option><option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option>
                        <option value=0.500>Level 4/8</option><option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
                    </select>
                    <input type="hidden" id="hidcmbincollectfuel" name="hidcmbincollectfuel" value='<s:property value="hidcmbincollectfuel"/>'/>
                </td>
            </tr>
            
            <tr>
                <td class="lbl-right">In Branch</td>
                <td>
                    <select name="cmbinbranch" id="cmbinbranch" onchange="getLoc(this.value);"><option value="">--Select--</option></select>
                    <input type="hidden" id="hidcmbinbranch" name="hidcmbinbranch" value='<s:property value="hidcmbinbranch"/>'/>
                </td>
                <td class="lbl-right">In Location</td>
                <td>
                    <select name="cmbinlocation" id="cmbinlocation" ><option value="">--Select--</option></select>
                    <input type="hidden" id="hidcmbinlocation" name="hidcmbinlocation" value='<s:property value="hidcmbinlocation"/>'/>
                </td>
                <td colspan="4"></td>
            </tr>
            
            <tr>
                <td class="lbl-right" style="padding-top:10px;">Description</td>
                <td colspan="7" style="padding-top:10px;">
                    <input type="text" name="indesc" id="indesc" value='<s:property value="indesc"/>' />
                </td>
            </tr>
        </table>
    </div>

    <div class="erp-form-area">
        <div class="section-title">New Vehicle Out Info</div>
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
            <tr>
                <td class="lbl-right" width="8%">Fleet No</td>
                <td colspan="3" width="42%">
                    <div style="display: flex; gap: 5px;">
                        <div class="input-search-container" style="width: 120px;">
                            <input type="text" id="txtoutfleetno" name="txtoutfleetno" value='<s:property value="txtoutfleetno"/>' placeholder="Press F3" onKeyDown="getOutfleet(event);"/>
                            <svg class="magnifier-icon" onclick="openFleetSearch();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                        </div>
                        <input type="text" id="txtoutfleetname" name="txtoutfleetname" style="flex-grow: 1;" value='<s:property value="txtoutfleetname"/>'/>
                    </div>
                </td>
                <td class="lbl-right" width="10%">Branch</td>
                <td width="15%">
                    <input type="text" name="outbranch" id="outbranch" value='<s:property value="outbranch"/>'/>
                    <input type="hidden" name="hidoutbranch" id="hidoutbranch" value='<s:property value="hidoutbranch"/>'/>
                </td>
                <td class="lbl-right" width="10%">Location</td>
                <td width="15%">
                    <input type="text" name="outlocation" id="outlocation" value='<s:property value="outlocation"/>'/>
                    <input type="hidden" name="hidoutlocation" id="hidoutlocation" value='<s:property value="hidoutlocation"/>'/>
                </td>
            </tr>

            <tr>
                <td>
                    <div class="checkbox-group" style="justify-content: flex-end; background: transparent; border: none; margin-bottom: 0;">
                        <input type="checkbox" name="chkdelivery" id="chkdelivery" onchange="checkDelivery();">
                        <label for="chkdelivery">Delivery</label>
                    </div>
                    <input type="hidden" name="hidchkdelivery" id="hidchkdelivery" value='<s:property value="hidchkdelivery"/>'>
                </td>
                <td>
                    <input type="text" name="deliverydriver" id="deliverydriver" placeholder="Press F3 to Search" value='<s:property value="deliverydriver"/>' onkeydown="getDeliveryDriver(event)";/>
                    <input type="hidden" id="hiddeliverydriver" name="hiddeliverydriver" value='<s:property value="hiddeliverydriver"/>'/>
                </td>
                <td class="lbl-right">Del. Date</td>
                <td>
                    <div id="deliveryoutdate" name="deliveryoutdate"  value='<s:property value="deliveryoutdate"/>'></div>
                    <input type="hidden" id="hiddeliveryoutdate" name="hiddeliveryoutdate" value='<s:property value="hiddeliveryoutdate"/>'/>
                </td>
                <td class="lbl-right">Del. Time</td>
                <td>
                    <div id="deliveryouttime" name="deliveryouttime" value='<s:property value="deliveryouttime"/>'></div>
                    <input type="hidden" id="hiddeliveryouttime" name="hiddeliveryouttime" value='<s:property value="hiddeliveryouttime"/>'/>
                </td>
                <td class="lbl-right">Del. KM</td>
                <td>
                    <input type="text" id="deliveryoutkm" name="deliveryoutkm" value='<s:property value="deliveryoutkm"/>' onkeypress="javascript:return isNumber (event,id)"/>
                </td>
            </tr>
            
            <tr>
                <td class="lbl-right">Del. Fuel</td>
                <td>
                    <select id="cmbdeliveryoutfuel" name="cmbdeliveryoutfuel" value='<s:property value="cmbdeliveryoutfuel"/>'>
                        <option value="">--Select--</option>
                        <option value=0.000>Level 0/8</option><option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option>
                        <option value=0.500>Level 4/8</option><option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
                    </select>
                    <input type="hidden" id="hidcmbdeliveryoutfuel" name="hidcmbdeliveryoutfuel" value='<s:property value="hidcmbdeliveryoutfuel"/>'/>
                </td>
                <td class="lbl-right">Delivery To</td>
                <td colspan="5">
                    <input type="text" name="deliveryto" id="deliveryto" value='<s:property value="deliveryto"/>'/>
                </td>
            </tr>

            <tr>
                <td class="lbl-right" style="padding-top:10px;">Out User</td>
                <td style="padding-top:10px;">
                    <input type="text" id="user" name="user" value='<s:property value="user"/>' readonly/>
                    <input type="hidden" name="hidoutuser" id="hidoutuser" value='<s:property value="hidoutuser"/>'/>
                </td>
                <td class="lbl-right" style="padding-top:10px;">Out Date</td>
                <td style="padding-top:10px;">
                    <div id="ondeliverydate" name="ondeliverydate" value='<s:property value="ondeliverydate"/>'></div>
                    <input type="hidden" id="hidondeliverydate" name="hidondeliverydate" value='<s:property value="hidondeliverydate"/>'/>
                </td>
                <td class="lbl-right" style="padding-top:10px;">Out Time</td>
                <td style="padding-top:10px;">
                    <div id="ondeliverytime" name="ondeliverytime" value='<s:property value="ondeliverytime"/>'></div>
                    <input type="hidden" id="hidondeliverytime" name="hidondeliverytime" value='<s:property value="hidondeliverytime"/>'/>
                </td>
                <td class="lbl-right" style="padding-top:10px;">Out KM</td>
                <td style="padding-top:10px;">
                    <input type="text" id="ondeliverykm" name="ondeliverykm" value='<s:property value="ondeliverykm"/>' onkeypress="javascript:return isNumber (event,id)"/>
                </td>
            </tr>
            
            <tr>
                <td class="lbl-right">Out Fuel</td>
                <td>
                    <select id="cmbondeliveryfuel" name="cmbondeliveryfuel" value='<s:property value="cmbondeliveryfuel"/>'>
                        <option value="">--Select--</option>
                        <option value=0.000>Level 0/8</option><option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option><option value=0.375>Level 3/8</option>
                        <option value=0.500>Level 4/8</option><option value=0.625>Level 5/8</option><option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
                    </select>
                    <input type="hidden" id="hidcmbondeliveryfuel" name="hidcmbondeliveryfuel" value='<s:property value="hidcmbondeliveryfuel"/>'/>
                </td>
                <td colspan="6"></td>
            </tr>
        </table>
    </div>

    <div style="display:none;">
        <input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'  />
        <input type="hidden" name="dtype" id="dtype" value='<s:property value="dtype"/>'/>
        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
        <div id="dateouthidden" name="dateouthidden" hidden="true"></div>
        <div id="timeouthidden" name="timeouthidden" hidden="true"></div>
        <input type="hidden" id="infleettrancode" name="infleettrancode"  value='<s:property value="infleettrancode"/>'/>
        <input type="hidden" id="refno" name="refno" value='<s:property value="refno"/>' readonly />
        
        <input type="hidden" id="formdetail" name="formdetail" value='<s:property value="formdetail"/>'/>
        <input type="hidden" id="formdetailcode" name="formdetailcode" value='<s:property value="formdetailcode"/>'/>
    </div>

</div>
</form>

<div id="agmtnowindow"><div></div><div></div></div>
<div id="collectionwindow"><div></div><div></div></div>

</div>
</body>
</html>