<%@ taglib prefix="s" uri="/struts-tags" %>
 
<!DOCTYPE html>
<html>
<head>
<s:head/>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
 <jsp:include page="../../../../includes.jsp"></jsp:include>
<!-- <link rel="stylesheet" type="text/css" href="../css/body.css"> -->
<script type="text/javascript">
$(document).ready(function() {
	$("#fleetstatusdate").jqxDateTimeInput({
		width : '125px',
		height : '15px',
		formatString : "dd.MM.yyyy"
	});
	$("#hiddate").jqxDateTimeInput({
		width : '125px',
		height : '15px',
		formatString : "dd.MM.yyyy"
	});
	getStatus();
	$('#btnEdit').attr('disabled',true);
	 $('#fleetwindow').jqxWindow({ width: '60%', height: '58%',  maxHeight: '58%' ,maxWidth: '50%' , title: 'Fleet Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#fleetwindow').jqxWindow('close');
	$("#fleetstatustime").jqxDateTimeInput({ width: '50%', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:new Date() });
	$("#hidtime").jqxDateTimeInput({ width: '50%', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:new Date() });
	  $('#fleetno').dblclick(function(){
		  
		  if(document.getElementById("mode").value=="view"){
			  return false;
		  }
		  datereset();
		    $('#fleetwindow').jqxWindow('open');
		$('#fleetwindow').jqxWindow('focus');
		fleetnoSearchContent('masterFleetSearch.jsp?', $('#fleetwindow'));
		});
});
function fleetnoSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#fleetwindow').jqxWindow('setContent', data);

}); 
}
function getFleet(event){
	   	//alert("Here");
     var x= event.keyCode;
     if(x==114){
    	 if(document.getElementById("mode").value=="view"){
			  return false;
		  }
    	 datereset();
   	   $('#fleetwindow').jqxWindow('open');
  		$('#fleetwindow').jqxWindow('focus');
  		 fleetnoSearchContent('masterFleetSearch.jsp?', $('#fleetwindow'));
     }
     else{
      }
     }
function funReset(){
	//$('#frmFleetStatusChange')[0].reset(); 
}
function datereset(){
	$('#fleetstatusdate').jqxDateTimeInput('setDate', new Date());
	   $('#fleetstatustime').jqxDateTimeInput('setDate', new Date());
	   
}
function funFocus(){
	document.getElementById("fleetno").focus();
}
function funReadOnly(){
	if($('#docno').val()!='0'){
		$('#frmFleetStatusChange input').attr('readonly', true );
		 $('#fleetstatusdate').jqxDateTimeInput({ disabled: true}); 
		 $('#fleetstatustime').jqxDateTimeInput({ disabled: true}); 
		 $('#frmFleetStatusChange select').attr('disabled', true );
		 $('#frmFleetStatusChange textarea').attr('readonly', true );	
	}
	
}
function funRemoveReadOnly(){
	$('#frmFleetStatusChange input').attr('readonly', false );
	 $('#fleetstatusdate').jqxDateTimeInput({ disabled: false}); 
	 $('#fleetstatustime').jqxDateTimeInput({ disabled: false}); 
	 $('#frmFleetStatusChange select').attr('disabled', false );
	 $('#frmFleetStatusChange textarea').attr('readonly', false );
	$('#docno').attr('readonly', true);
	$('#fleetno').attr('readonly', true);
	$('#fleetname').attr('readonly', true);
	$('#currentstatus').attr('readonly', true);
	if(document.getElementById("mode").value=="A"){
		datereset();
	}

}
function getStatus() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items = items.split('***');
			//alert(items);
			var status = items[0].split(",");
			var statusid = items[1].split(",");
			var optionsstatus = '<option value="">--Select--</option>';
			for (var i = 0; i < status.length; i++) {
				optionsstatus += '<option value="' + statusid[i] + '">'
						+ status[i] + '</option>';
			}
			$("select#cmbchangestatus").html(optionsstatus);
			if ($('#hidcmbchangestatus').val() != null) {
				$('#cmbchangestatus').val($('#hidcmbchangestatus').val());
			}
		} else {
		}
	}
	x.open("GET", "getStatus.jsp", true);
	x.send();
}
function setValues()
{
	funSetlabel();

	if($('#hidfleetstatustime').val()){
		$("#fleetstatustime").jqxDateTimeInput('val', $('#hidfleetstatustime').val());
	}
	if($('#msg').val()!=""){
		$.messager.alert('Message',$('#msg').val());
		if($('#msg').val()!=$('#extramsg').val()){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText=$('#extramsg').val();
		}
		else{
			document.getElementById("errormsg").innerText="";
		}
	}
	 if ($('#hidcmbchangestatus').val() != null) {
			$('#cmbchangestatus').val($('#hidcmbchangestatus').val());
		}
	

	}
	function funNotify(){
		var temp=document.getElementById("cmbchangestatus").value;
		var statusdate= new Date($('#fleetstatusdate').jqxDateTimeInput('getDate'));
		var statustime= new Date($('#fleetstatustime').jqxDateTimeInput('getDate'));
		var hiddate=$('#hiddate').jqxDateTimeInput('getDate');
		var hidtime=$('#hidtime').jqxDateTimeInput('getDate');
		statusdate.setHours(0,0,0,0);
		hiddate.setHours(0,0,0,0);
		
		var validdate=funDateInPeriod(statusdate);
		if(validdate==0){
			return 0; 
		}
		
		var curdate=new Date();
		var curtime=new Date();
		curdate.setHours(0,0,0,0);
		
		
		if(statusdate-curdate==0){
			if(statustime.getHours()>curtime.getHours()){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Future Time Not Allowed";
				return 0;
			}
			else if(statustime.getHours()==curtime.getHours()){
				if(statustime.getMinutes()>curtime.getMinutes()){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="Future Time Not Allowed";
					return 0;
				}
			}
		}
		
		if(document.getElementById("cmbchangestatus").value==""){
			document.getElementById("errormsg").innerText="Select a Status";
			return 0;
		}
		if(document.getElementById("hidcurrentstatus").value==temp){
			document.getElementById("errormsg").innerText="Cannot Select Same Status";
			return 0;
		}
		//checking status change date with last in date
		if(statusdate<hiddate){
			 document.getElementById("errormsg").innerText="";
			 document.getElementById("errormsg").innerText="Change Date Cannot be less than Last In Date";
			 return 0;
		}
		if(statusdate-hiddate==0){
			if(statustime.getHours()<hidtime.getHours()){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Change Time Cannot be less than Last In Time";
				 return 0;	
			}
			if(statustime.getHours()==hidtime.getHours()){
				if(statustime.getMinutes()<hidtime.getMinutes()){
					document.getElementById("errormsg").innerText="";
					document.getElementById("errormsg").innerText="Change Time Cannot be less than Last In Time";
					 return 0;		
				}
			}
		}
		document.getElementById("errormsg").innerText="";
		return 1;
	}
	function funSearchLoad(){
		 changeContent('masterSearch.jsp', $('#window')); 
	}
</script>

<style>
/* =========================================================
   MODERN ERP LAYOUT - EXACT ALIGNMENT & FULL WIDTH GRID 
   (Fuses tight horizontal alignment with modern clean UI)
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

/* Master Input Heights - Set to 24px as requested */
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

/* Clean Panels mapping to fieldsets */
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

/* Strict Full-Width CSS Grid for Top Section */
.top-grid {
    display: grid;
    /* 5 strict columns + inputs. Stretches perfectly across. */
    grid-template-columns: 80px minmax(100px, 1fr) 70px minmax(100px, 1fr) 50px minmax(150px, 2fr) 110px minmax(100px, 1fr) 90px minmax(100px, 1fr);
    column-gap: 8px;
    row-gap: 8px;
    align-items: center;
    width: 100%;
    margin-bottom: 15px;
}

.top-grid > label {
    text-align: right;
    color: #444;
    font-size: 12px;
    font-weight: bold;
    white-space: nowrap;
}

.flex-row {
    display: flex;
    align-items: center;
    gap: 5px;
    width: 100%;
}

.chk-container {
    display: flex;
    align-items: center;
    gap: 4px;
    cursor: pointer;
    color: #444;
    font-size: 12px;
    font-weight: bold;
    white-space: nowrap;
}

.chk-container input {
    margin: 0;
    padding: 0;
}

/* Middle Section Split */
.middle-section {
    display: flex;
    gap: 10px;
    margin-bottom: 10px;
}

.middle-panel {
    border: 1px solid #e1e4e8;
    padding: 15px 10px 10px 10px;
    background: #fff;
    position: relative;
    border-radius: 4px;
}

.middle-panel-title {
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

/* Clean Tables mapping requested colors */
.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #fff;
    border: 1px solid #ddd;
}
.cr-table th, .cr-table td {
    padding: 4px 6px;
    border: 1px solid #ddd;
    font-size: 12px;
}
.cr-table th {
    background: #f0f3f5;
    font-weight: bold;
    color: #333;
    text-align: left;
}
.lbl-right {
    text-align: right;
    color: #444;
    font-weight: bold;
    font-size: 12px;
    padding-right: 5px;
}

/* Tabs Override */
#tabs { margin-top: 5px; margin-bottom: 0px; }
#content { padding-top: 10px; }

.fleet-row {
    grid-template-columns: 70px 120px 200px 120px 150px 140px;
}

/* Make fleet name stretch properly */
.fleet-row .wide {
    width: 100%;
}

/* Prevent wrapping */
.fleet-row {
    align-items: center;
}

/* Optional safety */
select {
    width: 100%;
}

.fleet-row {
    grid-template-columns: auto auto auto auto auto auto;
    grid-auto-flow: column;
}
#fleetstatustime {
    width: 160px;   /* increase as needed */
}

.fleet-input {
    display: flex;
    align-items: center;
    border: 1px solid #ccc;
    border-radius: 3px;
    padding: 0 5px;
    height: 24px;
    background: #fff;
}

.fleet-input input {
    border: none;
    outline: none;
    flex: 1;
    font-size: 12px;
    padding-left: 4px;
}

.search-icon {
    cursor: pointer;
    display: flex;
    align-items: center;
}

.search-icon:hover svg {
    stroke: #007bff;
}

select {
    height: 24px !important;
    line-height: 22px;
    padding: 2px 6px;
    color: #333 !important;
    background-color: #fff !important;
    appearance: auto;           /* restore default dropdown */
    -webkit-appearance: menulist;
    -moz-appearance: menulist;
}
.top-grid select {
    overflow: visible;
    white-space: nowrap;
}
</style>
</head>

<body onload="funReadOnly();setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmFleetStatusChange" action="saveActionFleetStatusChange" autocomplete="off">
<%-- <script>
			window.parent.formName.value="Vehicle Status Change";
			window.parent.formCode.value="VSC";
	</script> --%>
	<jsp:include page="../../../../header.jsp" />
	<br/> 
<fieldset>
<legend>Fleet Status Change Info</legend>

<!-- ROW 1 -->
<div class="top-grid" style="grid-template-columns: 70px 120px 70px 150px 80px 140px;">

    <label>Date</label>
    <div id="fleetstatusdate"
         value='<s:property value="fleetstatusdate"/>'></div>

    <label>Time</label>
    <div id="fleetstatustime"
         value='<s:property value="fleetstatustime"/>'></div>

    <label>Doc No</label>
    <input type="text" name="docno" id="docno"
           value='<s:property value="docno"/>' readonly>

</div>

<!-- ROW 2 -->
<div class="top-grid fleet-row">

  <label>Fleet</label>

<div class="fleet-input">
    <span class="search-icon" onclick="getFleet(event)">
        <!-- SVG Icon -->
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none">
            <circle cx="11" cy="11" r="7" stroke="#666" stroke-width="2"/>
            <line x1="16.5" y1="16.5" x2="21" y2="21" stroke="#666" stroke-width="2"/>
        </svg>
    </span>

    <input type="text" id="fleetno"
           placeholder="Double click to search"
           ondblclick="getFleet(event)">
</div>

    <input type="text" id="fleetname" class="wide">

    <label>Current Status</label>
    <input type="text" id="currentstatus">

    <label>Change to Status</label>
    <select id="cmbchangestatus">
        <option value="">--Select--</option>
    </select>

</div>
<!-- ROW 3 -->
<div class="top-grid" style="grid-template-columns: 70px 1fr;">

    <label>Reason</label>
    <textarea id="reason" name="reason"
              style="resize:none;height:50px;width:100%;">
<s:property value="reason"/>
    </textarea>

</div>

<!-- HIDDEN FIELDS -->
<input type="hidden" name="hidcmbsalesman" id="hidcmbsalesman" value='<s:property value="hidcmbsalesman"/>'>
<input type="hidden" name="hidfleetstatusdate" id="hidfleetstatusdate" value='<s:property value="hidfleetstatusdate"/>'>
<input type="hidden" name="hidfleetstatustime" id="hidfleetstatustime" value='<s:property value="hidfleetstatustime"/>'>
<input type="hidden" name="hidcmbchangestatus" id="hidcmbchangestatus" value='<s:property value="hidcmbchangestatus"/>'>
<input type="hidden" name="hidcurrentstatus" id="hidcurrentstatus" value='<s:property value="hidcurrentstatus"/>'>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
<input type="hidden" name="extramsg" id="extramsg" value='<s:property value="extramsg"/>'>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>

<div id="hiddate" hidden></div>
<div id="hidtime" hidden></div>

</fieldset>
</form>
<div id="fleetwindow">
   <div ></div>
</div>
</div>
</body>
</html>