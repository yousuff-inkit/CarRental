<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath(); %>
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
    width: 80px;
}

/* ===== UNIFORM 24px TEXT INPUTS, SELECTS & TEXTAREA ===== */
input[type="text"], select, textarea {
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

textarea {
    height: auto !important;
    min-height: 45px;
    resize: vertical;
    line-height: 1.4;
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

input[readonly], input:disabled, select:disabled, textarea[readonly] {
    background-color: #f3f6f9 !important;
    color: #555;
    cursor: pointer;
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
    // Standardize jqxDateTimeInputs
    $("#fromdate, #todate, #date").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    
    $('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%', maxHeight: '70%', maxWidth: '51%', title: 'Employee Search', position: { x: 250, y: 120 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#employeeDetailsWindow').jqxWindow('close');
    
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    
    // Initialize Dates
    var curfromdate = $('#fromdate').jqxDateTimeInput('getDate');
    var oneyeardate = new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
    var oneyearbackdate = new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
    $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
    
    $('#txtempname').dblclick(function(){
        var branchval = document.getElementById("cmbbranch").value; 
        var emptype = $('#emptype').val();
        
        if(emptype == ''){
            $.messager.alert('Message','Choose an Employee Type.','warning');
            return 0;
        }
        
        employeeSearchContent('employeeDetailsSearch.jsp?branchval='+branchval+'&emptype='+emptype); 
    });
});

function funExportBtn(){
    if(parseInt(window.parent.chkexportdata.value)=="1") {
        JSONToCSVCon(data1, 'Staff-Allocated-Traffic', true);
    } else {
        $("#jqxstaffAllocatedTraffic").jqxGrid('exportdata', 'xls', 'Staff-Allocated-Traffic');
    }
}

function clientSearchContent(url) {
    $('#clientDetailsWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#clientDetailsWindow').jqxWindow('setContent', data);
        $('#clientDetailsWindow').jqxWindow('bringToFront');
    }); 
}

function employeeSearchContent(url) {
    $('#employeeDetailsWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#employeeDetailsWindow').jqxWindow('setContent', data);
        $('#employeeDetailsWindow').jqxWindow('bringToFront');
    }); 
}

function getEmployee(event){
    if(event.keyCode == 114){
        var emptype = $('#emptype').val();
        if(emptype == ''){
            $.messager.alert('Message','Choose an Employee Type.','warning');
            return 0;
        }
        var branchval = document.getElementById("cmbbranch").value; 
        employeeSearchContent('employeeDetailsSearch.jsp?branchval='+branchval+'&emptype='+emptype);
    }
}

function funClearData(){
    $('#emptype').val(''); $('#txtempname').val(''); $('#txtempid').val('');
    $('#fromdate').val(new Date()); $('#todate').val(new Date()); $('#date').val(new Date());
    
    $('#fromdate').val(new Date());
    var curfromdate = $('#fromdate').jqxDateTimeInput('getDate');
    var oneyeardate = new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
    var oneyearbackdate = new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
    $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
    
    if (document.getElementById("txtempname").value == "") {
        $('#txtempname').attr('placeholder', 'Press F3 to Search'); 
    }
}
    
function empchange(){
    $('#txtempid').val(''); $('#txtempname').val('');
    if (document.getElementById("txtempname").value == "") {
        $('#txtempname').attr('placeholder', 'Press F3 to Search'); 
    }
}

function datechange(){
    var date = $('#date').jqxDateTimeInput('getDate');
    var validdate = funDateInPeriod(date);
    if(validdate == 0){
        return 0;   
    }
}

function funreload(event){
    var branchval = document.getElementById("cmbbranch").value;
    var fromdate = $('#fromdate').val();
    var todate = $('#todate').val();
    var emptype = $('#emptype').val();
    var empname = $('#txtempid').val();
    
    if($('#cmbbranch').val() == "" || $('#cmbbranch').val() == "a"){
        $.messager.alert('warning','Please Select a Branch');
        return false;
    }
    $("#overlay, #PleaseWait").show();
    
    $("#staffAllocatedDiv").load("staffAllocatedTrafficGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&emptype='+emptype+'&empname='+empname);
}

function funUpdate(event){
    var trafficaccount = $('#txttrafficaccount').val();
    var expenseaccount = $('#txtexpenseaccount').val();
    var regno = $('#txtregno').val();
    var platecode = $('#txtplatecode').val();
    var tdate = $('#txttdate').val();
    var ttime = $('#txtttime').val();
    var rano = $('#txtrano').val();
    var fleetno = $('#txtfleetno').val();
    var amount = $('#txtamount').val();
    var mainbranch = $('#txtmainbranch').val();
    var docno = $('#txtdocno').val();
    var srno = $('#txtsrno').val();
    var amountcount = $('#txtamountcount').val();
    var empid = $('#txtemployeeid').val();
    var ticketno = $('#txtticketno').val();
    var postdate = $('#date').val();
    
    if(docno == ''){
        $.messager.alert('Message','Please Choose a Fleet.','warning');
        return 0;
    }
    
    var date = $('#date').jqxDateTimeInput('getDate');
    var validdate = funDateInPeriod(date);
    if(validdate == 0){
        return 0;   
    }
    
    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
        if(r == false) {
            return false; 
        } else {
            saveGridData(trafficaccount,expenseaccount,rano,fleetno,amount,mainbranch,docno,srno,amountcount,empid,ticketno,postdate,regno,platecode,tdate,ttime); 
        }
    });
}

function saveGridData(trafficaccount,expenseaccount,rano,fleetno,amount,mainbranch,docno,srno,amountcount,empid,ticketno,postdate,regno,platecode,tdate,ttime){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function(){
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            items = items.split('***');
            var val = items[0];
            var jvno = items[1];
            
            $.messager.alert('Message', ' Ticket No: '+$('#txtticketno').val()+' of Fleet No: '+$('#txtfleetno').val()+' is Passed as Journal Voucher No.: '+items[1]+'', function(r){});
            
            $('#txttrafficaccount').val(' '); $('#txtexpenseaccount').val(' '); $('#txtrano').val(' ');
            $('#txttdate').val(' '); $('#txtttime').val(' '); $('#txtregno').val(' ');
            $('#txtplatecode').val(' '); $('#txtfleetno').val(' '); $('#txtamount').val(' ');
            $('#txtmainbranch').val(' '); $('#txtdocno').val(' '); $('#txtsrno').val(' ');
            $('#txtamountcount').val(' '); $('#txtemployeeid').val(' '); $('#vehinfo').val(' ');
            $('#txtticketno').val(' '); $('#date').val(new Date());
            
            funreload(event); 
        }
    }
    x.open("GET","saveData.jsp?trafficaccount="+trafficaccount+"&expenseaccount="+expenseaccount+"&rano="+rano+"&fleetno="+fleetno+"&amount="+amount+"&mainbranch="+mainbranch+"&docno="+docno+"&srno="+srno+"&amountcount="+amountcount+"&empid="+empid+"&ticketno="+ticketno+"&postdate="+postdate+"&regno="+regno+"&platecode="+platecode+"&tdate="+tdate+"&ttime="+ttime,true);
    x.send();
}
</script>
</head>

<body onload="getBranch();">
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
                        <td class="label-cell">From</td>
                        <td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">To</td>
                        <td><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Type</td>
                        <td>
                            <select id="emptype" name="emptype" onchange="empchange();" value='<s:property value="emptype"/>'>
                                <option value="">--Select--</option>
                                <option value="STF">Staff</option>
                                <option value="DRV">Driver</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Employee</td>
                        <td>
                            <input type="text" id="txtempname" name="txtempname" readonly
                                   placeholder="Press F3 to Search" value='<s:property value="txtempname"/>'
                                   onkeydown="getEmployee(event);">
                            <input type="hidden" id="txtempid" name="txtempid" value='<s:property value="txtempid"/>'>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <textarea id="vehinfo" name="vehinfo" readonly><s:property value="vehinfo"/></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Posting</td>
                        <td><div id="date" name="date" onchange="datechange();" value='<s:property value="date"/>'></div></td>
                    </tr>
                </table>

                <div class="button-group">
                    <button type="button" id="clear" class="btn-submit" onclick="funClearData();" style="background:#64748b !important;">
                        Clear
                    </button>
                    <button type="button" id="btnupdate" class="btn-submit" onclick="funUpdate(event);">
                        Update
                    </button>
                </div>
            </div>

            <!-- HIDDEN FIELDS -->
            <div style="display:none;">
                <input type="hidden" id="txttrafficaccount" name="txttrafficaccount" value='<s:property value="txttrafficaccount"/>'>
                <input type="hidden" id="txtexpenseaccount" name="txtexpenseaccount" value='<s:property value="txtexpenseaccount"/>'>
                <input type="hidden" id="txtrano" name="txtrano" value='<s:property value="txtrano"/>'>
                <input type="hidden" id="txtfleetno" name="txtfleetno" value='<s:property value="txtfleetno"/>'>
                <input type="hidden" id="txtticketno" name="txtticketno" value='<s:property value="txtticketno"/>'>
                <input type="hidden" id="txtamount" name="txtamount" value='<s:property value="txtamount"/>'>
                <input type="hidden" id="txtamountcount" name="txtamountcount" value='<s:property value="txtamountcount"/>'>
                <input type="hidden" id="txtmainbranch" name="txtmainbranch" value='<s:property value="txtmainbranch"/>'>
                <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'>
                <input type="hidden" id="txtsrno" name="txtsrno" value='<s:property value="txtsrno"/>'>
                <input type="hidden" id="txtemployeeid" name="txtemployeeid" value='<s:property value="txtemployeeid"/>'>
                <input type="hidden" id="txtplatecode" name="txtplatecode" value='<s:property value="txtplatecode"/>'>
                <input type="hidden" id="txtregno" name="txtregno" value='<s:property value="txtregno"/>'>
                <input type="hidden" id="txttdate" name="txttdate" value='<s:property value="txttdate"/>'>
                <input type="hidden" id="txtttime" name="txtttime" value='<s:property value="txtttime"/>'>
            </div>

        </div>
    </div>
</td>

<!-- ================= RIGHT SIDE (GRID) ================= -->
<td valign="top">
    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            
            <div id="staffAllocatedDiv">
                <jsp:include page="staffAllocatedTrafficGrid.jsp"></jsp:include>
            </div>

        </div>
    </div>
</td>

</tr>
</table>

</div>
</div>

<!-- POPUPS -->
<div id="employeeDetailsWindow">
    <div></div><div></div>
</div>

</div> 
</body>
</html>