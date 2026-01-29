
  <jsp:include page="../../../../includes.jsp"></jsp:include>  
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />
  <style>
/* ===== MASTER LAYOUT ===== */
.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', Tahoma, sans-serif;
    background-color: #f4f7f9;
}

/* Sidebar */
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

/* Cards */
.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

/* Tables */
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

/* Inputs */
input[type="text"], select {
    width: 100%;
    padding: 7px 10px;
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    font-size: 13px;
}

/* Buttons */
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

/* Page height fix */
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
</style>
  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 

<script type="text/javascript">

$(document).ready(function () {
	 $("#fleetdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#curdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value: new Date()});
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value: new Date()});
	 $("#fleettime").jqxDateTimeInput({ width: '25%', height: '17px', formatString: 'HH:mm', showCalendarButton: false ,value: new Date()});
	 $("#hiddate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value: new Date()});
	 $("#hidtime").jqxDateTimeInput({ width: '20%', height: '17px', formatString: 'HH:mm', showCalendarButton: false ,value: new Date()});
	 /*  $('#vehiclewindow').jqxWindow({ autoOpen: false,width: '80%', height: '70%',  maxHeight: '70%' ,maxWidth: '80%' , title: 'Vehicle Details' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'}); */
	 $('#movementwindow').jqxWindow({ autoOpen: false,width: '80%', height: '75%',  maxHeight: '75%' ,maxWidth: '80%' , title: 'Movement Details' ,position: { x:250, y: 60 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'});
	 document.getElementById("btnUpdate").disabled=true;
	document.getElementById("btnattach").disabled=true;
	document.getElementById("btnmove").disabled=true;
	 $('#clientAttachWindow').jqxWindow({autoOpen: false,width: '70%', height: '58%',  maxHeight: '70%' ,maxWidth: '70%' , title: 'Attach',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
	   $('#clientAttachWindow').jqxWindow('close');
	 
});

function getStatus() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items = items.split('***');
			var status = items[0].split(",");
			var statusid = items[1].split(",");
			var optionsstatus = '<option value="">--Select--</option>';
			for (var i = 0; i < status.length; i++) {
				optionsstatus += '<option value="' + statusid[i] + '">'
						+ status[i] + '</option>';
			}
			$("select#cmbstatus").html(optionsstatus);
			if ($('#hidcmbstatus').val() != null) {
				$('#cmbstatus').val($('#hidcmbstatus').val());
			}
		} else {
		}
	}
	x.open("GET", "../../../operations/saleofvehicle/vehiclestatuschange/getStatus.jsp", true);
	x.send();
}
function updateStatus(){
	var testdate= $('#fleetdate').jqxDateTimeInput('getDate');
	var testtime= $('#fleettime').jqxDateTimeInput('getDate');
	var testtime2=$('#fleettime').jqxDateTimeInput('val');
	if(document.getElementById("fleetno").value==""){
		 $.messager.alert('Message',"Please Select Fleet");
		 return false;
	}
	if(document.getElementById("cmbstatus").value==""){
		 $.messager.alert('Message',"Please Select Status");
		 return false;
	}
	var hiddate=$('#hiddate').jqxDateTimeInput('getDate');
	var hidtime=$('#hidtime').jqxDateTimeInput('getDate');
	//alert(testtime.getHours());
	hiddate.setHours(0,0,0,0);
	testdate.setHours(0,0,0,0);
	
	var validdate=funDateInPeriod(testdate);
	if(validdate==0){
		return 0; 
	}
	
	var curdate=new Date();
	var curtime=new Date();
	curdate.setHours(0,0,0,0);
	
	if(testdate-curdate==0){
		if(testtime.getHours()>curtime.getHours()){
			$.messager.alert('Message',"Future Time Not Allowed");
			return false;
		}
		else if(testtime.getHours()==curtime.getHours()){
			if(testtime.getMinutes()>curtime.getMinutes()){
				$.messager.alert('Message',"Future Time Not Allowed");
				return false;
			}
		}
	}
	
	if(testdate<hiddate){
		 $.messager.alert('Message',"Change Date Cannot be less than Last In Date");
		 return false;
	}
	if(testdate-hiddate==0){
		if(testtime.getHours()<hidtime.getHours()){
			$.messager.alert('Message',"Change Time Cannot be less than Last In Time");
			 return false;	
		}
		if(testtime.getHours()==hidtime.getHours()){
			if(testtime.getMinutes()<hidtime.getMinutes()){
				$.messager.alert('Message',"Change Time Cannot be less than Last In Time");
				 return false;		
			}
		}
	}
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			if(items.trim()=="1"){
					   $.messager.alert('Message',"Successfully Saved");
						
					   funreload(this);
					  
			}
				else{
					$.messager.alert('Message',"Not Saved");
					funreload(this);
						
				}

		} else {
		}
	}
	x.open("GET", "updateStatus.jsp?fleetdate="+testdate+"&fleettime="+testtime2+"&fleetno="+document.getElementById("fleetno").value+"&status="+document.getElementById("cmbstatus").value+"&branch="+document.getElementById("hidbranch").value, true);
	x.send();
}
function funreload(event)
{
	 document.getElementById("btnUpdate").disabled=true;
		document.getElementById("btnattach").disabled=true;
		document.getElementById("btnmove").disabled=true;
 	$('input[type=text],[type=hidden]').val('');
	 //  $('select').find('option').prop("selected", false);
	   $('#fleetdate').jqxDateTimeInput('setDate', new Date());
	   $('#fleettime').jqxDateTimeInput('setDate', new Date());
  	var barchval = document.getElementById("cmbbranch").value;
     
	  $("#fleetdiv").load("unRentableGrid.jsp?branchval="+barchval);
	
	}
	
	
function funExportBtn()
{
	
	 


  if(parseInt(window.parent.chkexportdata.value)=="1")
	    {
	    JSONToCSVCon(ssss, 'Unrentable', true);
	    }
	   else
	    {
		   $("#unRentableGrid").jqxGrid('exportdata', 'xls', 'Unrentable');
	    }
	   
	   


	
	}
function getVehicleMov(){
	if(document.getElementById("fleetno").value==""){
		 $.messager.alert('Message',"Please Select Fleet");
		 return false;
	}
	 var fleetno=document.getElementById("fleetno").value;
	 var vals=0;
	 var ready="ready";
	 $('#movementwindow').jqxWindow('setContent', '');
		$('#movementwindow').jqxWindow('open');	 
		movementSearchContent("<%=contextPath%>/com/dashboard/vehicle/vehiclemovement/vehiclemovementGrid.jsp?fleetno="+fleetno+"&fromdate="+vals+"&todate="+vals+"&ready="+ready);
	}
<%-- function getVehicle(){
	if(document.getElementById("fleetno").value==""){
		 $.messager.alert('Message',"Please Select Fleet");
		 return false;
	}
	$('#vehiclewindow').jqxWindow('setContent', '');
	$('#vehiclewindow').jqxWindow('open');	
	 vehicleSearchContent("<%=contextPath%>/com/controlcentre/masters/vehicle/saveVehicle1.action?mode=view&fleetno="+document.getElementById("fleetno").value);
}
function vehicleSearchContent(url) {
	//$('#vehiclewindow').jqxWindow('open');	
	$('#vehiclewindow').jqxWindow('focus');	
	$.get(url).done(function (data) {
$('#vehiclewindow').jqxWindow('setContent', data);
}); 
} --%>
function movementSearchContent(url) {
	$('#movementwindow').jqxWindow('focus');	
	$.get(url).done(function (data) {
$('#movementwindow').jqxWindow('setContent', data);
}); 
}
function getAttach(){
	if(document.getElementById("fleetno").value==""){
		 $.messager.alert('Message',"Please Select Fleet");
		 return false;
	}
	changeClientAttachContent("<%=contextPath%>/com/common/attachGrid.jsp?formCode=VEH&docno="+document.getElementById("docno").value);  

}
function changeClientAttachContent(url) {
	   $.get(url).done(function (data) {
	        $('#clientAttachWindow').jqxWindow('open');
	     $('#clientAttachWindow').jqxWindow('setContent',data);
	     $('#clientAttachWindow').jqxWindow('bringToFront');
	  }); 
	  }
</script>
</head>
<body onload="getBranch();getStatus();">
<form autocomplete="off">

<div id="mainBG" class="homeContent" data-type="background"> 
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ================= LEFT SIDEBAR (20%) ================= -->
<td width="20%">
    <div class="master-container">
        <div class="sidebar-filters">

            <!-- Fixed Heading -->
            <div class="sidebar-fixed-top">
                <div class="filter-card">
                    <jsp:include page="../../heading.jsp"></jsp:include>
                </div>
            </div>

            <!-- Scrollable Content -->
            <div class="sidebar-scroll-content">

                <!-- Filters -->
                <div class="filter-card">
                    <table class="filter-table">

                        <tr>
                            <td class="label-cell">Fleet</td>
                            <td>
                                <input type="text" name="fleetno" id="fleetno" readonly>
                            </td>
                        </tr>

                        <tr>
                            <td class="label-cell">Status</td>
                            <td>
                                <select name="cmbstatus" id="cmbstatus">
                                    <option value="">--Select--</option>
                                </select>
                            </td>
                        </tr>

                        <tr>
                            <td class="label-cell">Date</td>
                            <td>
                                <div id="fleetdate" name="fleetdate"></div>
                            </td>
                        </tr>

                        <tr>
                            <td class="label-cell">Time</td>
                            <td>
                                <div id="fleettime" name="fleettime"></div>
                            </td>
                        </tr>

                        <tr>
                            <td colspan="2" style="text-align:center;">
                                <div id="hiddate" name="hiddate" hidden="true"></div>
                                <div id="hidtime" name="hidtime" hidden="true"></div>
                            </td>
                        </tr>

                    </table>
                </div>

                <!-- Action Buttons -->
                <button type="button"
                        class="btn-submit"
                        id="btnUpdate"
                        onclick="updateStatus();">
                    Update
                </button>

                <button type="button"
                        class="btn-submit"
                        id="btnattach"
                        onclick="getAttach();">
                    Attach
                </button>

                <button type="button"
                        class="btn-submit"
                        id="btnmove"
                        onclick="getVehicleMov();">
                    Movement
                </button>

            </div>
        </div>
    </div>
</td>

<!-- ================= RIGHT CONTENT (80%) ================= -->
<td width="80%">
    <table width="100%">
        <tr>
            <td>
                <div id="fleetdiv">
                    <jsp:include page="unRentableGrid.jsp"></jsp:include>
                </div>
            </td>
        </tr>
    </table>
</td>

</tr>
</table>

<!-- Hidden Fields & Popups -->
<div id="curdate" name="curdate" hidden="true"></div>
<div id="fromdate" name="fromdate" hidden="true"></div>

<input type="hidden" name="docno" id="docno">
<input type="hidden" name="hidcmbstatus" id="hidcmbstatus">

<label id="trncodeval" hidden="true"></label>
<label id="statusval" hidden="true"></label>

<div id="movementwindow"><div></div></div>
<div id="clientAttachWindow"><div></div></div>

</div>
</div>
</form>
</body>
</html>