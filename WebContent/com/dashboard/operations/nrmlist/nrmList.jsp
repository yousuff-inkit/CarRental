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

<style type="text/css">
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
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    background-color: #f4f7f9;
}

/* Sidebar dynamically fills the left TD */
.sidebar-filters {
    width: 100%;
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

/* Flex 1 allows this middle section to scroll while keeping top fixed */
.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 20px 15px; 
}

.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 12px;
    margin-bottom: 12px;
}

.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.label-cell {
    text-align: right;
    padding-right: 12px;
    font-size: 12px; 
    font-weight: 600;
    color: #4e5e71;
    width: 90px;
}

/* ===== UNIFORM 24px TEXT INPUTS ===== */
input[type="text"], select {
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
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

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

input[readonly], input:disabled, select:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    cursor: not-allowed;
}

/* ===== BUTTONS ===== */
.button-group {
    display: flex;
    gap: 10px;
    justify-content: center;
}

.btn-submit {
    flex: 1;
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
    margin-top: 8px;
    transition: all 0.2s ease;
}

.btn-submit:hover {
    background: #1d4ed8 !important;
}

/* Layout Utilities */
.main-content-wrapper {
    flex: 1;
    width: 100%;
    display: flex;
    flex-direction: column;
    padding: 15px 20px;
    background: #fff;
    height: 100vh;
    box-sizing: border-box;
}

.scrollable-grid-area {
    flex: 1;
    width: 100%;
    overflow: auto;
}
</style>

<script type="text/javascript">
$(document).ready(function () {
    document.getElementById("branchlabel").style.display="none";
    document.getElementById("branchdiv").style.display="none";
    
    $("#btnExcel").click(function() {
        JSONToCSVCon(nrmexceldata, 'Movement List', true);
    });
    
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:210px;right:525px;'><img src='../../../../icons/31load.gif'/></div>");
    
    $('#fleetwindow').jqxWindow({ width: '50%', height: '60%', maxHeight: '80%' ,maxWidth: '50%' , title: 'Fleet Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#fleetwindow').jqxWindow('close');
    
    $('#employeewindow').jqxWindow({ width: '50%', height: '50%', maxHeight: '50%' ,maxWidth: '50%' , title: 'Employee Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#employeewindow').jqxWindow('close');
    
    $('#garagewindow').jqxWindow({ width: '50%', height: '50%', maxHeight: '50%' ,maxWidth: '50%' , title: 'Garage Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#garagewindow').jqxWindow('close');
    
    // Standardized height to 24px and width to 100%
    $("#fromdate, #todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    
    var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
    
    $('#fleet').dblclick(function(){
        $('#fleetwindow').jqxWindow('open');
        $('#fleetwindow').jqxWindow('focus');
        fleetSearchContent('masterFleetSearch.jsp');
    });
    
    $('#employee').dblclick(function(){
        if(document.getElementById("cmbemptype").value==""){
            $.messager.alert('Warning','Please Select Employee Type');
            return false;
        }
        $('#employeewindow').jqxWindow('open');
        $('#employeewindow').jqxWindow('focus');
        employeeSearchContent('employeeSearch.jsp?emptype='+document.getElementById("cmbemptype").value);
    });
    
    $('#garage').dblclick(function(){
        $('#garagewindow').jqxWindow('open');
        $('#garagewindow').jqxWindow('focus');
        garageSearchContent('garageSearch.jsp');
    });
});

function getFleet(event){
    var x= event.keyCode;
    if(x==114){
        $('#fleetwindow').jqxWindow('open');
        $('#fleetwindow').jqxWindow('focus');
        fleetSearchContent('masterFleetSearch.jsp');            
    }
}

function getEmployee(event){
    if(document.getElementById("cmbemptype").value==""){
        $.messager.alert('Warning','Please Select Employee Type');
        return false;
    }
    var x= event.keyCode;
    if(x==114){
        $('#employeewindow').jqxWindow('open');
        $('#employeewindow').jqxWindow('focus');
        employeeSearchContent('employeeSearch.jsp?emptype='+document.getElementById("cmbemptype").value);           
    }
}

function getGarage(event){
    var x= event.keyCode;
    if(x==114){
        $('#garagewindow').jqxWindow('open');
        $('#garagewindow').jqxWindow('focus');
        garageSearchContent('garageSearch.jsp');            
    }
}

function fleetSearchContent(url) {
    $.get(url).done(function (data) {
        $('#fleetwindow').jqxWindow('setContent', data);
    }); 
}
function employeeSearchContent(url) {
   $.get(url).done(function (data) {
        $('#employeewindow').jqxWindow('setContent', data);
    }); 
}
function garageSearchContent(url) {
    $.get(url).done(function (data) {
        $('#garagewindow').jqxWindow('setContent', data);
    }); 
}

function funreload(event)
{
    var fromdate=$('#fromdate').jqxDateTimeInput('val');
    var todate=$('#todate').jqxDateTimeInput('val');
    $("#overlay, #PleaseWait").show();
    var fleet=document.getElementById("fleet").value;
    var movtype=document.getElementById("cmbtype").value;
    var emptype=document.getElementById("cmbemptype").value;
    var employee=document.getElementById("hidemployee").value;
    var garage=document.getElementById("hidgarage").value;
    var status=document.getElementById("cmbstatus").value;
    
    $("#nrmdiv").load("nrmListGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&fleet="+fleet+"&movtype="+movtype+"&emptype="+emptype+"&employee="+employee+"&garage="+garage+"&status="+status+"&id=1");
}
    
function getCmbtype(){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            items = items.split('***');
            
            var typeIdItems  = items[1].split(",");
            var typeItems = items[0].split(",");
            var optionsbranch = '<option value="">--Select--</option>';
            for (var i = 0; i < typeItems.length;i++){
                optionsbranch += '<option value="' + typeIdItems[i]+ '">' + typeItems[i] + '</option>';
            }
            $("select#cmbtype").html(optionsbranch);
        }
    }
    x.open("GET","getCmbtype.jsp", true);
    x.send();
}

function setValues(){
     if($('#msg').val()!=""){
       $.messager.alert('Message',$('#msg').val());
      }
    getCmbtype();
}

function funExportBtn(){
    $("#nrmdiv").excelexportjs({
        containerid: "nrmdiv",
        datatype: 'json',
        dataset: null,
        gridId: "nrmListGrid",
        columns: getColumns("nrmListGrid"),
        worksheetName: "Movement List Data"
    });
}
    
function funClearData(){
    $('input[type=text],[type=hidden]').val('');
    $('select').find('option').prop("selected", false);
    $('#fromdate').jqxDateTimeInput('setDate',new Date());
    $('#todate').jqxDateTimeInput('setDate',new Date());
    var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
}
</script>
</head>

<body onload="setValues();">

<form id="frmNrmList" method="post">

<div id="mainBG" class="homeContent">
<div class="hidden-scrollbar">
<div class="master-container">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr>

<!-- ================= LEFT SIDEBAR ================= -->
<td width="330px" valign="top">
    <div class="sidebar-filters">
        <div class="sidebar-fixed-top">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>

        <div class="sidebar-scroll-content">
            
            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">From Date</td>
                        <td><div id="fromdate"></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">To Date</td>
                        <td><div id="todate"></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Fleet</td>
                        <td>
                            <input type="text" id="fleet" name="fleet" readonly placeholder="Press F3 to Search" onkeydown="getFleet(event);">
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Type</td>
                        <td>
                            <select id="cmbtype" name="cmbtype">
                                <option value="">--Select--</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Emp Type</td>
                        <td>
                            <select id="cmbemptype" name="cmbemptype">
                                <option value="">--Select--</option>
                                <option value="stf">Staff</option>
                                <option value="drv">Driver</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Employee</td>
                        <td>
                            <input type="text" id="employee" name="employee" readonly placeholder="Press F3 to Search" onkeydown="getEmployee(event);">
                            <input type="hidden" id="hidemployee" name="hidemployee">
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Garage</td>
                        <td>
                            <input type="text" id="garage" name="garage" readonly placeholder="Press F3 to Search" onkeydown="getGarage(event);">
                            <input type="hidden" id="hidgarage" name="hidgarage">
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Mov Status</td>
                        <td>
                            <select id="cmbstatus" name="cmbstatus">
                                <option value="">--Select--</option>
                                <option value="0">Open</option>
                                <option value="1">Closed</option>
                            </select>
                        </td>
                    </tr>
                </table>
            </div>

            <!-- BUTTONS -->
            <button type="button" class="btn-submit" onclick="funClearData();">Clear</button>

        </div>
    </div>
</td>

<!-- ================= RIGHT SIDE (GRIDS) ================= -->
<td valign="top">
    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="nrmdiv">
                <jsp:include page="nrmListGrid.jsp"></jsp:include>
            </div>
            
            <!-- Hidden Fields -->
            <div style="display:none;">
                <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'>
                <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
            </div>
        </div>
    </div>
</td>

</tr>
</table>

</div>
</div>

<!-- POPUPS -->
<div id="fleetwindow"><div></div></div>
<div id="employeewindow"><div></div></div>
<div id="garagewindow"><div></div></div>

</div>

</form>
</body>
</html>