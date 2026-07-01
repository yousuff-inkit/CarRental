<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<style type="text/css">
/* ===== MASTER LAYOUT (Modern Flexbox) ===== */
html, body, #mainBG {
    height: 100%;
    margin: 0;
    overflow: hidden;
    background-color: #f4f7f9;
}

.master-container {
    display: flex;
    width: 100%;
    height: 100vh;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

/* ===== LEFT SIDEBAR ===== */
.sidebar-filters {
    width: 280px; 
    flex: 0 0 280px; 
    background: #fff;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100%;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
    z-index: 10;
}

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 15px 25px; 
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

.filter-table .label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    width: 80px;
}

/* ===== UNIFORM 24px INPUTS & SELECTS ===== */
input[type="text"], select,
.filter-table input[type="text"],
.filter-table select {
    width: 100%;
    height: 24px;              
    padding: 2px 8px;          
    border: 1px solid #ccd6e0;
    border-radius: 4px;        
    font-size: 12px;          
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
    outline: none;
}

select {
    padding-right: 24px; 
    cursor: pointer;
    appearance: none;
    -webkit-appearance: none;
    background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%234e5e71' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
    background-repeat: no-repeat;
    background-position: right 6px center;
    background-size: 12px;
}

/* Readonly / disabled look */
input[readonly], input:disabled, select:disabled,
.filter-table input[readonly], .filter-table input:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed;
    cursor: not-allowed;
}

/* jqx date/time containers */
div[id^="fromdate"], div[id^="todate"] {
    width: 100%;
}

/* Radio Button Layout */
.radio-group {
    display: flex;
    gap: 15px;
    align-items: center;
    justify-content: center;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 500;
    padding-bottom: 10px;
    border-bottom: 1px solid #e1e8ed;
    margin-bottom: 10px;
}

.radio-group input[type="radio"] {
    margin: 0 4px 0 0;
    vertical-align: middle;
}

/* ===== BUTTONS ===== */
.button-group {
    display: flex;
    gap: 8px;
    margin-top: 15px;
}

.btn-submit {
    flex: 1;
    height: 30px;            
    padding: 0 12px;         
    background: #2563eb;
    color: #fff;
    border: none;
    border-radius: 4px;      
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
    line-height: 30px;       
    text-align: center;
    transition: background 0.2s;
}

.btn-submit:hover { background: #1d4ed8; }
.btn-submit.btn-warning { background: #f59e0b; }
.btn-submit.btn-warning:hover { background: #d97706; }
.btn-submit.btn-secondary { background: #64748b; }
.btn-submit.btn-secondary:hover { background: #475569; }

/* ===== RIGHT CONTENT AREA ===== */
.main-content-area {
    flex: 1; 
    display: flex;
    flex-direction: column;
    background: #ffffff;
    height: 100%;
    overflow: hidden;
}

.top-toolbar-container {
    width: 100%;
    padding: 10px 15px;
    background: #ffffff;
    border-bottom: 1px solid #e1e8ed;
    box-sizing: border-box;
}

.grid-content-container {
    flex: 1;
    padding: 15px;
    overflow: auto; 
    box-sizing: border-box;
}
</style>

<script type="text/javascript">
$(document).ready(function () {
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
    $('#vehdetaildiv').hide();
    
    $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    $("#todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    
    $('#costCodeDetailsWindow').jqxWindow({ width: '60%', height: '68%', maxHeight: '68%' ,maxWidth: '60%' , title: 'Cost Detail Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
    $('#costCodeDetailsWindow').jqxWindow('close');
    
    var curfromdate = $('#fromdate').jqxDateTimeInput('getDate');
    var onemonthbackdate = new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
        
    $('#costmissingdiv').hide();
    document.getElementById("rdodifference").checked = true;
    setCosttype();
    getCostType();
        
    $('#costcode').dblclick(function(){
        if(document.getElementById("cmbcosttype").value == ""){
            $.messager.alert('warning','Cost Type is Mandatory');
            return false;
        }
        $('#costCodeDetailsWindow').jqxWindow('open');
        $('#costCodeDetailsWindow').jqxWindow('focus');
        costCodeDetailsContent('costCodeDetailsSearch.jsp?', $('#costCodeDetailsWindow'));
    });
});

function getCostCodeKey(event){
    if(document.getElementById("cmbcosttype").value == ""){
        $.messager.alert('warning','Cost Type is Mandatory');
        return false;
    }
    var x = event.keyCode;
    if(x == 114){
        $('#costCodeDetailsWindow').jqxWindow('open');
        $('#costCodeDetailsWindow').jqxWindow('focus');
        costCodeDetailsContent('costCodeDetailsSearch.jsp?', $('#costCodeDetailsWindow'));
    }
}

function costCodeDetailsContent(url) {
    $.get(url).done(function (data) {
        $('#costCodeDetailsWindow').jqxWindow('setContent', data);
    }); 
}

function funreload(event) {
    if(document.getElementById("cmbbranch").value == ""){
        $.messager.alert('Warning','Please Select Branch');
        return false;
    }
    var dateval = funDateInPeriod($('#todate').jqxDateTimeInput('getDate'));
    if(dateval == 1){
        var branch = document.getElementById("cmbbranch").value;
        var fromdate = $('#fromdate').jqxDateTimeInput('val');
        var todate = $('#todate').jqxDateTimeInput('val');
  
        $("#overlay, #PleaseWait").show();
        if(document.getElementById("rdomissing").checked == true){
            $("#costmissingdiv").load("costMissingGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&id=1", function() {
                $("#overlay, #PleaseWait").hide();
            });
        } else if(document.getElementById("rdodifference").checked == true){
            $("#costupdatediv").load("costupdateGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&id=1", function() {
                $("#overlay, #PleaseWait").hide();
            });     
        }
    }
}
    
function setValues(){
    if($('#msg').val() != ""){
        $.messager.alert('Message',$('#msg').val());
        $("#overlay, #PleaseWait").hide();
    }
}

function funExportBtn(){
    $("#vehUtilizeGrid").jqxGrid('exportdata', 'xls', 'Vehicle Utilization');
}

function funClearData(){
    $('input[type=text],[type=hidden]').val('');
}

function funPost(){
    var rows = $("#costupdateGrid").jqxGrid('selectedrowindexes');
    document.getElementById("hidtrno").value = "";
    document.getElementById("hidgridacno").value = "";
    
    for(var i=0; i<rows.length; i++){
        var trno = $('#costupdateGrid').jqxGrid('getcellvalue',rows[i],'tr_no');
        var acno = $('#costupdateGrid').jqxGrid('getcellvalue',rows[i],'acno');
        if(i == 0){
            document.getElementById("hidgridacno").value = acno+"::"+trno;
        } else{
            document.getElementById("hidgridacno").value += ","+acno+"::"+trno;
        }
    }
    if(document.getElementById("rdodifference").checked == true){
        document.getElementById("mode").value = "A";
        $("#overlay, #PleaseWait").show();
        document.getElementById("frmCostUpdate").submit();          
    }
}
    
function setCosttype(){
    if(document.getElementById("rdomissing").checked == true){
        $('#costupdatediv').hide();
        $('#costmissingdiv').show();
        $('#btncostupdate').show();
    } else if(document.getElementById("rdodifference").checked == true){
        $('#costmissingdiv').hide();
        $('#costupdatediv').show();
        $('#btncostupdate').hide();
    }
}
    
function getCostType() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            var srno  = items[0].split(",");
            var process = items[1].split(",");
            var optionsbranch = '<option value="" selected>-- Select -- </option>';
            for (var i = 0; i < process.length; i++) {
                if (srno[i].trim() !== "") {
                    optionsbranch += '<option value="' + srno[i].trim() + '">' + process[i] + '</option>';
                }
            }
            $("select#cmbcosttype").html(optionsbranch);
        }
    }
    x.open("GET","getCostType.jsp", true);
    x.send();
}
    
function funClearCosts(){
    $('#costcode,#costcodename,#hidcostcode').val('');
    $('#costcode').attr('placeholder','Press F3 to Search');
}
    
function funMissingUpdate(){
    if(document.getElementById("rdomissing").checked == false){
        $.messager.alert('warning','Please Enable the missing option');
        return false;
    }
    if(document.getElementById("cmbcosttype").value == ""){
        $.messager.alert('warning','Please choose cost type');
        return false;
    }
    if(document.getElementById("costcode").value == ""){
        $.messager.alert('warning','Please choose cost code');
        return false;
    }
    var selectedrows = $('#costMissingGrid').jqxGrid('selectedrowindexes');
    var trno = "";
    for( var i=0; i<selectedrows.length; i++){
        if(i == 0){
            document.getElementById("missingtrno").value += $('#costMissingGrid').jqxGrid('getcellvalue',selectedrows[i],'tr_no')+"::"+$('#costMissingGrid').jqxGrid('getcellvalue',selectedrows[i],'acno');
        } else {
            document.getElementById("missingtrno").value += ","+$('#costMissingGrid').jqxGrid('getcellvalue',selectedrows[i],'tr_no')+"::"+$('#costMissingGrid').jqxGrid('getcellvalue',selectedrows[i],'acno');
        }
    }
    document.getElementById("mode").value = "MU";
    $("#overlay, #PleaseWait").show();
    document.getElementById("frmCostUpdate").submit();      
}

function funUpdateMissing(trno,costtype,costcode){
    // Implementation intentionally commented out in original file
}
</script>
</head>

<body onload="getBranch();setValues();">
<form id="frmCostUpdate" method="post" action="saveCostUpdate">

<div id="mainBG" class="homeContent" data-type="background">

    <div class="master-container">

        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">
                
                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">From</td>
                            <td><div id="fromdate"></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">To</td>
                            <td><div id="todate"></div></td>
                        </tr>
                    </table>
                </div>

                <div class="filter-card">
                    <div class="radio-group">
                        <label>
                            <input type="radio" name="rdocosttype" id="rdomissing" onchange="setCosttype();">
                            Manual
                        </label>
                        <label>
                            <input type="radio" name="rdocosttype" id="rdodifference" onchange="setCosttype();">
                            Automatic
                        </label>
                    </div>
                    
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">Cost Type</td>
                            <td>
                                <select id="cmbcosttype" name="cmbcosttype" onchange="funClearCosts();">
                                    <option value="">--Select--</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Cost Code</td>
                            <td>
                                <input type="text" id="costcode" name="costcode" placeholder="Press F3 to Search" readonly onkeydown="getCostCodeKey(event);">
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell"></td>
                            <td>
                                <input type="text" id="costcodename" name="costcodename" readonly>
                            </td>
                        </tr>
                    </table>
                    
                    <div class="button-group">
                        <button type="button" class="btn-submit btn-warning" id="btncostupdate" onclick="funMissingUpdate();">
                            Update
                        </button>
                    </div>
                </div>

                <div class="filter-card">
                    <div class="button-group">
                        <button type="button" class="btn-submit btn-secondary" id="btnclear" onclick="funClearData();">
                            Clear
                        </button>
                        <button type="button" class="btn-submit" id="btnpost" onclick="funPost();">
                            Post
                        </button>
                    </div>
                </div>

                <div style="display:none;">
                    <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'>
                    <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
                    <input type="hidden" id="hidtrno" name="hidtrno">
                    <input type="hidden" id="hidgridacno" name="hidgridacno">
                    <input type="hidden" id="hidcostcode" name="hidcostcode">
                    <input type="hidden" id="missingtrno" name="missingtrno" value='<s:property value="missingtrno"/>'>
                </div>
                
            </div>
        </div>

        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="costupdatediv">
                    <jsp:include page="costupdateGrid.jsp"></jsp:include>
                </div>
                <div id="costmissingdiv">
                    <jsp:include page="costMissingGrid.jsp"></jsp:include>
                </div>
            </div>

        </div>

    </div>

    <div id="costCodeDetailsWindow">
        <div></div>
    </div>

</div>
</form>
</body>
</html>