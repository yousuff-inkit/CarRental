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
/* ===== AGGRESSIVE OVERRIDES TO DESTROY BLUE BACKGROUNDS & HOVERS ===== */
html, body, #mainBG, .homeContent, .hidden-scrollbar {
    height: 100%;
    margin: 0 !important;
    padding: 0 !important;
    overflow: hidden !important;
    background-color: #ffffff !important;
    background: #ffffff !important;
    background-image: none !important;
}

/* Force layout tables to white */
.master-layout-table, 
.master-layout-table > tbody > tr, 
.master-layout-table > tbody > tr > td {
    background-color: #ffffff !important;
    background: #ffffff !important;
}

/* Forcefully kill all hover states on tables applied by external CSS */
table tr:hover, 
table td:hover, 
table th:hover, 
tbody tr:hover {
    background-color: transparent !important;
    background: transparent !important;
}

/* ===== MASTER LAYOUT ===== */
.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    background-color: #ffffff !important; 
    margin: 0 !important;
    padding: 0 !important;
}

/* Sidebar */
.sidebar-filters {
    width: 330px;
    flex: 0 0 330px;
    background: #ffffff !important;
    display: flex;
    flex-direction: column;
    height: 100vh;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
}

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 20px; 
}

/* Cards */
.filter-card {
    background: #f8fafc !important;
    border: 1px solid #e3e8ee;
    border-radius: 8px;
    padding: 15px; 
    margin-bottom: 12px;
}

/* Tables within the card */
.filter-table {
    width: 100%;
    border-spacing: 0 10px; 
    background: transparent !important;
}

.filter-table tr, .filter-table td {
    background: transparent !important;
    border: none !important;
}

.filter-table .label-cell {
    text-align: right;
    padding-right: 12px;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    width: 90px;
    white-space: nowrap; 
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
    background-color: #ffffff !important;
    box-sizing: border-box;
    color: #333;
    outline: none;
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
.btn-submit {
    flex: 1;
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
    text-align: center;
    transition: background 0.2s;
    width: 100%;
}

.btn-submit:hover {
    background: #1d4ed8 !important;
}

.filter-actions {
    display: flex;
    gap: 10px;
    justify-content: center;
    margin-top: 15px; 
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

// Targeted function to populate the native dropdown inside heading.jsp
function getBrch() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim().split('####');
            if (items.length > 1) {
                var brchIdItems = items[0].split(",");
                var brchItems = items[1].split(",");
                var optionsbrch = '<option value="">--Select--</option>';
                for (var i = 0; i < brchItems.length; i++) {
                    optionsbrch += '<option value="' + brchIdItems[i] + '">' + brchItems[i] + '</option>';
                }
                $("select#cmbbranch").html(optionsbrch);
            }
        }
    }
    x.open("GET", "getBranch.jsp", true);
    x.send();
}

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
    getBrch(); // Trigger branch populator on load
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

<table class="master-layout-table" width="100%" height="100%" cellpadding="0" cellspacing="0" border="0" style="background-color: #ffffff !important;">
<tr>

<td width="330px" valign="top" style="vertical-align: top; padding: 0 !important; margin: 0 !important; background: #ffffff !important; border-right: 1px solid #e1e8ed;">
    <div class="master-container">
        <div class="sidebar-filters">
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
                    
                    <div class="filter-actions">
                        <button type="button" class="btn-submit" onclick="funClearData();">Clear</button>
                    </div>
                </div>

            </div>
        </div>
    </div>
</td>

<td class="right-panel" valign="top" style="padding: 15px; background: #ffffff !important;">
    
    <div style="width: 100%; margin-bottom: 10px;">
        <jsp:include page="../../heading.jsp"></jsp:include>
    </div>

    <table width="100%" cellpadding="0" cellspacing="0" border="0" style="background: transparent !important;">
        <tr>
             <td valign="top" style="background: transparent !important;">
                 <div id="nrmdiv">
                     <jsp:include page="nrmListGrid.jsp"></jsp:include>
                 </div>
             </td>
        </tr>
    </table>
    
    <div style="display:none;">
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
    </div>

</td>

</tr>
</table>

</div>
</div>

<div id="fleetwindow"><div></div></div>
<div id="employeewindow"><div></div></div>
<div id="garagewindow"><div></div></div>

</form>
</body>
</html>