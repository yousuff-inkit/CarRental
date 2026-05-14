<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

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
    width: 80px;
}

/* ===== UNIFORM 24px TEXT INPUTS & SELECTS ===== */
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
    cursor: pointer;
}

/* Radio Button Layout Customization */
.radio-group {
    display: flex;
    gap: 15px;
    align-items: center;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 500;
    padding: 5px 0;
}

.radio-group input[type="radio"] {
    margin: 0 4px 0 0;
    vertical-align: middle;
}

/* ===== BUTTONS ===== */
.button-group {
    display: flex;
    gap: 8px;
    margin-top: 5px;
}

.btn-submit {
    flex: 1;
    height: 30px !important;            
    padding: 0 5px !important;
    background: #2563eb !important;
    color: #fff !important;
    border: none !important;
    border-radius: 4px !important;
    font-size: 12px !important;
    font-weight: 600 !important;
    cursor: pointer;
    line-height: 30px !important;
    text-align: center;
    transition: all 0.2s ease;
    width: 100%;
}

.btn-submit:hover { background: #1d4ed8 !important; }

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
                <div class="radio-group" style="padding-bottom: 10px; border-bottom: 1px solid #e1e8ed; margin-bottom: 10px; justify-content: center;">
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
                
                <div class="button-group" style="margin-top: 15px;">
                    <button type="button" class="btn-submit" id="btncostupdate" onclick="funMissingUpdate();" style="background:#f59e0b !important;">
                        Update
                    </button>
                </div>
            </div>

            <div class="filter-card">
                <div class="button-group">
                    <button type="button" class="btn-submit" id="btnclear" onclick="funClearData();" style="background:#64748b !important;">
                        Clear
                    </button>
                    <button type="button" class="btn-submit" id="btnpost" onclick="funPost();">
                        Post
                    </button>
                </div>
            </div>

            <!-- Hidden Fields -->
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
</td>

<!-- ================= RIGHT SIDE (GRID) ================= -->
<td valign="top">
    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="costupdatediv">
                <jsp:include page="costupdateGrid.jsp"></jsp:include>
            </div>
            <div id="costmissingdiv">
                <jsp:include page="costMissingGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>
</td>

</tr>
</table>

<!-- POPUPS -->
<div id="costCodeDetailsWindow">
    <div></div>
</div>

</div>
</div>
</div>
</form>

</body>
</html>