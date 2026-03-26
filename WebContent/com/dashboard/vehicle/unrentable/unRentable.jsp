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
html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
}

.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
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
    height: calc(100vh - 50px); 
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
}

.sidebar-fixed-top {
    padding: 10px 15px;
    border-bottom: 1px solid #f0f4f8;
}

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 10px 15px 20px;
}

/* Cards */
.filter-card {
    background: #fff;
    border: 1px solid #e3e8ee;
    border-radius: 8px;
    padding: 12px;
    margin-bottom: 10px;
}

/* Form Alignment Fix: Bringing labels closer to inputs */
.filter-table {
    width: 100%;
    border-collapse: collapse;
}

.filter-table td {
    padding: 5px 0;
}

.label-cell {
    text-align: left;
    vertical-align: middle; 
    font-size: 13px; /* Same as Branch label */
    font-weight: 500;
    color: #4e5e71;
    width: 65px; /* Fixed width to pull inputs closer */
    white-space: nowrap;
}

/* Input Consistency */
input[type="text"], 
select, 
.jqx-datetimeinput {
    width: 100% !important;
    height: 32px !important; /* Matches Branch dropdown height */
    padding: 4px 8px;
    border: 1px solid #ccd6e0;
    border-radius: 4px;
    font-size: 13px !important; /* Matches Branch font size */
    box-sizing: border-box;
    outline: none;
    font-family: inherit;
    background-color: #fff;
}

/* Button Styling: Perfectly matching the "Submit" button */
.button-container {
    display: flex;
    flex-direction: column;
    gap: 8px;
    margin-top: 5px;
}

.btn-submit {
    width: 100%;
    height: 38px; /* Matches standard submit button height */
    background: #2563eb; /* Primary Blue */
    color: #fff;
    border: none;
    border-radius: 6px;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.2s ease;
}

.btn-submit:hover {
    background: #1d4ed8;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.btn-submit:disabled {
    background: #cbd5e1;
    cursor: not-allowed;
    opacity: 0.8;
}

/* Grid Area */
td[width="80%"] {
    height: 100vh;
    vertical-align: top;
    background: #fff;
}
</style>
  
<script type="text/javascript">
$(document).ready(function () {
    // Standardize jQWidgets
    $("#fleetdate").jqxDateTimeInput({ width: '100%', height: '32px', formatString:"dd.MM.yyyy"});
    $("#fleettime").jqxDateTimeInput({ width: '100%', height: '32px', formatString: 'HH:mm', showCalendarButton: false , value: new Date()});
    
    // Hidden Trackers
    $("#curdate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy", value: new Date()});
    $("#hiddate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy", value: new Date()});
    $("#hidtime").jqxDateTimeInput({ width: '20%', height: '17px', formatString: 'HH:mm', showCalendarButton: false , value: new Date()});
    
    // Windows
    $('#movementwindow').jqxWindow({ autoOpen: false,width: '80%', height: '75%', title: 'Movement Details' ,position: { x:250, y: 60 }, keyboardCloseKey: 27, showCloseButton: true, closeButtonAction:'hide'});
    $('#clientAttachWindow').jqxWindow({autoOpen: false,width: '70%', height: '58%', title: 'Attach', position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});

    // Initial Button State
    $(".action-btn").prop("disabled", true); 
});

function getStatus() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.split('***');
			var status = items[0].split(",");
			var statusid = items[1].split(",");
			var optionsstatus = '<option value="">--Select--</option>';
			for (var i = 0; i < status.length; i++) {
				optionsstatus += '<option value="' + statusid[i] + '">' + status[i] + '</option>';
			}
			$("#cmbstatus").html(optionsstatus);
		}
	}
	x.open("GET", "../../../operations/saleofvehicle/vehiclestatuschange/getStatus.jsp", true);
	x.send();
}

function updateStatus(){
	var testdate= $('#fleetdate').jqxDateTimeInput('val');
	var testtime2=$('#fleettime').jqxDateTimeInput('val');
	if($("#fleetno").val()==""){
		 $.messager.alert('Message',"Please Select Fleet");
		 return false;
	}
	// ... rest of validation logic ...
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			if(x.responseText.trim()=="1"){
				$.messager.alert('Message',"Successfully Saved");
				funreload();
			}
		}
	}
	x.open("GET", "updateStatus.jsp?fleetdate="+testdate+"&fleettime="+testtime2+"&fleetno="+$("#fleetno").val()+"&status="+$("#cmbstatus").val()+"&branch="+$("#hidbranch").val(), true);
	x.send();
}

function funreload() {
    $(".action-btn").prop("disabled", true);
    $('input[type=text]').val('');
    $('#fleetdate, #fleettime').jqxDateTimeInput('setDate', new Date());
    $("#fleetdiv").load("unRentableGrid.jsp?branchval=" + $("#cmbbranch").val());
}

function getVehicleMov(){
	 $('#movementwindow').jqxWindow('open');	 
     $.get("<%=contextPath%>/com/dashboard/vehicle/vehiclemovement/vehiclemovementGrid.jsp?fleetno="+$("#fleetno").val()).done(function (data) {
        $('#movementwindow').jqxWindow('setContent', data);
    }); 
}

function getAttach(){
	$.get("<%=contextPath%>/com/common/attachGrid.jsp?formCode=VEH&docno="+$("#docno").val()).done(function (data) {
        $('#clientAttachWindow').jqxWindow('open').jqxWindow('setContent',data);
    }); 
}
</script>
</head>

<body onload="getBranch(); getStatus();">
<form autocomplete="off">
<div id="mainBG" class="homeContent"> 
<div class="hidden-scrollbar">

<table width="100%" cellpadding="0" cellspacing="0">
<tr>
<td width="20%" style="vertical-align: top;">
    <div class="master-container">
        <div class="sidebar-filters">

            <div class="sidebar-fixed-top">
                <div class="filter-card" style="border:none; padding:0;">
                    <jsp:include page="../../heading.jsp"></jsp:include>
                </div>
            </div>

            <div class="sidebar-scroll-content">
                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">Fleet</td>
                            <td><input type="text" name="fleetno" id="fleetno" readonly></td>
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
                            <td><div id="fleetdate"></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Time</td>
                            <td><div id="fleettime"></div></td>
                        </tr>
                    </table>
                </div>

                <div class="button-container">
                    <button type="button" class="btn-submit action-btn" id="btnUpdate" onclick="updateStatus();">Update Status</button>
                    <button type="button" class="btn-submit action-btn" id="btnattach" onclick="getAttach();">Attach</button>
                    <button type="button" class="btn-submit action-btn" id="btnmove" onclick="getVehicleMov();">Movement</button>
                </div>
            </div>
        </div>
    </div>
</td>

<td width="80%" style="vertical-align: top;">
    <div id="fleetdiv" style="padding: 10px;">
        <jsp:include page="unRentableGrid.jsp"></jsp:include>
    </div>
</td>
</tr>
</table>

<div id="hiddate" style="display:none;"></div>
<div id="hidtime" style="display:none;"></div>
<div id="curdate" style="display:none;"></div>
<input type="hidden" name="docno" id="docno">
<div id="movementwindow"><div></div></div>
<div id="clientAttachWindow"><div></div></div>

</div>
</div>
</form>
</body>
</html>