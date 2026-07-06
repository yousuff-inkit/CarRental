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
    height: 100vh;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    background-color: #f4f7f9;
}

/* Sidebar Component */
.sidebar-filters {
    width: 330px;
    flex: 0 0 330px;
    background: #fff;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100%;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
    z-index: 2;
}

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 20px 25px;
}

/* Cards Layout Rules */
.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 12px;
    margin-bottom: 12px;
}

/* Internal Presentation Tables */
.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.filter-table .label-cell {
    text-align: right;
    padding-right: 12px;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    width: 90px;
}

/* ===== UNIFORM 24px INPUTS & SELECTS ===== */
input[type="text"], select,
.filter-table input[type="text"],
.filter-table select {
    width: 100%;
    height: 24px !important;             
    padding: 2px 8px !important;         
    border: 1px solid #ccd6e0 !important;
    border-radius: 4px !important;       
    font-size: 12px !important;          
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
    outline: none;
}

/* Select specific styling */
select {
    padding: 2px 24px 2px 8px !important; 
    font-family: inherit;
    cursor: pointer;
    appearance: none;
    -webkit-appearance: none;
    background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%234e5e71' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
    background-repeat: no-repeat;
    background-position: right 6px center;
    background-size: 12px;
}

/* Readonly fields override */
input[readonly],
input:disabled {
    background-color: #f3f6f9 !important;
    color: #7e8c9a;
    cursor: not-allowed;
}

/* jqx Date Container Mapping Rules */
.filter-table div[id^="fleetdate"],
.filter-table div[id^="fleettime"] {
    width: 100%;
}

/* ===== MASTER 30px BUTTON SYSTEM OVERRIDES ===== */
.btn-submit {
    width: 100%;
    height: 30px !important;            
    padding: 0 12px !important;
    background: #2563eb !important;
    color: #fff !important;
    border: none !important;
    border-radius: 4px !important;
    font-size: 13px !important;
    font-weight: 600 !important;
    cursor: pointer;
    line-height: 30px !important;
    white-space: nowrap;
    text-align: center;
    transition: all 0.2s ease;
    box-shadow: none !important;
    text-shadow: none !important;
    display: block;
    box-sizing: border-box;
}

.btn-submit:hover {
    background: #1d4ed8 !important;
}



/* Button Group Alignment */
.button-container {
    display: flex;
    flex-direction: column;
    gap: 10px;
    margin-top: 5px;
}

.button-group {
    display: flex;
    gap: 8px;
}

.button-group .btn-submit {
    flex: 1;
}

/* ===== RIGHT CONTENT AREA ===== */
.main-content-wrapper {
    flex: 1;
    width: 100%;
    display: flex;
    flex-direction: column;
    background: #fff;
    height: 100vh;
    box-sizing: border-box;
}

.top-toolbar-container {
    width: 100%;
    padding: 10px 15px;
    background: #ffffff;
    border-bottom: 1px solid #e1e8ed;
    box-sizing: border-box;
}

.scrollable-grid-area {
    flex: 1;
    width: 100%;
    padding: 15px 20px;
    overflow: auto;
    box-sizing: border-box;
}
</style>
  
<script type="text/javascript">
$(document).ready(function () {
    // Standardize jQWidgets (Updated to 24px)
    $("#fleetdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    $("#fleettime").jqxDateTimeInput({ width: '100%', height: '24px', formatString: 'HH:mm', showCalendarButton: false , value: new Date()});
    
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

<div class="master-container">

    <!-- ================= LEFT PANEL (SIDEBAR) ================= -->
    <div class="sidebar-filters">
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

            <!-- Action Buttons Card -->
            <div class="filter-card">
                <div class="button-container">
                    <button type="button" class="btn-submit action-btn" id="btnUpdate" onclick="updateStatus();">Update Status</button>
                    
                    <div class="button-group">
                        <button type="button" class="btn-submit action-btn" id="btnattach" onclick="getAttach();">Attach</button>
                        <button type="button" class="btn-submit action-btn" id="btnmove" onclick="getVehicleMov();">Movement</button>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <!-- ================= RIGHT PANEL (WORKSPACE GRIDS) ================= -->
    <div class="main-content-wrapper">
        
        <!-- Horizontally Aligned Heading -->
        <div class="top-toolbar-container">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>

        <div class="scrollable-grid-area">
            <div id="fleetdiv">
                <jsp:include page="unRentableGrid.jsp"></jsp:include>
            </div>
        </div>

    </div>

</div>

<!-- Labels and Modals restored exactly to their original position at the bottom -->
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