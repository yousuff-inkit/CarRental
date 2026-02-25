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
</head>
<style>
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 32px 0;
    box-sizing: border-box;
    /* Changed from min-height: 100vh to fit content and remove excess bottom space */
    min-height: auto; 
    overflow-y: auto;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 20px;
    max-width: 100%;
    margin: auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
    /* Prevents container from stretching vertically unnecessarily */
    display: inline-block;
    width: 100%;
}

.receipt-header {
    display: block;
    margin-bottom: 16px;
    padding: 0 10px;
}

.receipt-header table {
    width: 100%;
}

.receipt-header td {
    padding: 6px 4px;
    vertical-align: middle;
}

.section-block {
    background: #f6f8fa;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.1);
    /* Reduced bottom margin to pull content together */
    margin-bottom: 15px; 
}

.section-block h2 {
    font-size: 1.1rem;
    font-weight: 600;
    margin: 0 0 20px;
    padding-left: 10px;
    border-left: 4px solid #007bff;
    color: #333;
}

.form-group {
    display: grid;
    grid-template-columns: 120px 1fr;
    align-items: center;
    gap: 12px 16px;
    margin-bottom: 12px;
}

.form-group.dual-input {
    grid-template-columns: 120px 1fr 120px 1fr;
}

.form-group.single-label-dual-input {
    grid-template-columns: 120px 1fr 1fr;
}

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

textarea {
    height: 80px !important;
    padding: 10px;
    resize: none; /* Prevents user from creating extra space by dragging */
}

input[type="text"]:focus, select:focus, textarea:focus {
    border-color: #007bff;
    outline: none;
}

label {
    font-weight: 600;
    color: #253858;
    white-space: nowrap;
    text-align: right;
    padding-right: 8px;
}

.jqx-datetimeinput {
    height: 34px !important;
    box-sizing: border-box;
}

/* Ensures no extra padding at the bottom of the last element */
.section-block:last-child {
    margin-bottom: 0;
}
</style>

<body onload="funReadOnly();setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmFleetStatusChange" action="saveActionFleetStatusChange" autocomplete="off">
<%-- <script>
			window.parent.formName.value="Vehicle Status Change";
			window.parent.formCode.value="VSC";
	</script> --%>
	<jsp:include page="../../../../header.jsp" />
	<br/> 

  <div id="mainBG">
    <div class="receipt-header">
        <table width="100%">
            <tr>
                <td width="5%" align="right"><label>Date</label></td>
                <td width="180px">
                    <div id="fleetstatusdate" name="fleetstatusdate" value='<s:property value="fleetstatusdate"/>'></div>
                    <input type="hidden" name="hidfleetstatusdate" id="hidfleetstatusdate" value='<s:property value="hidfleetstatusdate"/>'>
                </td>
                <td width="5%" align="right"><label>Time</label></td>
                <td width="150px">
                    <div id="fleetstatustime" name="fleetstatustime" value='<s:property value="fleetstatustime"/>'></div>
                    <input type="hidden" name="hidfleetstatustime" id="hidfleetstatustime" value='<s:property value="hidfleetstatustime"/>'>
                </td>
                <td></td>
                <td width="10%" align=><label>Doc No</label></td>
                <td width="180px">
                    <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly tabindex="-1">
                </td>
            </tr>
        </table>
    </div>

    <div class="section-block">
        <h2>Fleet Status Change Info</h2>

        <div class="form-group single-label-dual-input">
            <label>Fleet</label>
            <input type="text" name="fleetno" id="fleetno" value='<s:property value="fleetno"/>' readonly onkeydown="getFleet(event);" placeholder="Press F3 to Search">
            <input type="text" name="fleetname" id="fleetname" value='<s:property value="fleetname"/>' readonly tabindex="-1">
        </div>

        <div class="form-group dual-input">
            <label>Current Status</label>
            <input type="text" name="currentstatus" id="currentstatus" value='<s:property value="currentstatus"/>' readonly tabindex="-1">
            <input type="hidden" name="hidcurrentstatus" id="hidcurrentstatus" value='<s:property value="hidcurrentstatus"/>'>

            <label>Change to Status</label>
            <select name="cmbchangestatus" id="cmbchangestatus">
                <option value="">--Select--</option>
            </select>
            <input type="hidden" name="hidcmbchangestatus" id="hidcmbchangestatus" value='<s:property value="hidcmbchangestatus"/>'>
        </div>

        <div class="form-group">
            <label style="align-self: flex-start; padding-top: 8px;">Reason</label>
            <textarea id="reason" name="reason"><s:property value="reason"/></textarea>
        </div>
    </div>
</div>

    <input type="hidden" name="hidcmbsalesman" id="hidcmbsalesman" value='<s:property value="hidcmbsalesman"/>'>
    <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
    <input type="hidden" name="extramsg" id="extramsg" value='<s:property value="extramsg"/>'>
    <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
    <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
    <div id="hiddate" name="hiddate" hidden="true"></div>
    <div id="hidtime" name="hidtime" hidden="true"></div>
    
</form>
<div id="fleetwindow">
   <div ></div>
</div>
</div>
</body>
</html>