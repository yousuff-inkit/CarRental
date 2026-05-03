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

/* Inline Controls & Buttons */
.inline-controls {
    display: flex;
    gap: 8px;
    align-items: center;
    width: 100%;
}

input[type="checkbox"] {
    margin: 0;
    cursor: pointer;
    width: 14px;
    height: 14px;
    vertical-align: middle;
}

.btn-icon {
    background: #e1e8ed;
    border: 1px solid #ccd6e0;
    border-radius: 4px;
    cursor: pointer;
    padding: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    height: 24px;
    width: 28px;
    flex-shrink: 0;
    transition: background 0.2s;
    font-weight: bold;
    color: #4e5e71;
}

.btn-icon:hover { background: #cbd5e1; }

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

.bottom-total-row {
    display: flex;
    justify-content: flex-end;
    gap: 20px;
    margin-top: 15px;
    padding: 10px;
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 8px;
}
</style>

<script type="text/javascript">
$(document).ready(function () {
    // Standardize jqxDateTimeInputs
    $("#fromdate, #todate, #date").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    
    $('#accountDetailsWindow').jqxWindow({width: '51%', height: '60%', maxHeight: '70%', maxWidth: '51%', title: 'Accounts Search', position: { x: 300, y: 87 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#accountDetailsWindow').jqxWindow('close');
    
    $('#multiSearchWindow').jqxWindow({width: '50%', height: '55%', maxHeight: '55%', maxWidth: '50%', title: 'Ticket Search', position: { x: 300, y: 87 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#multiSearchWindow').jqxWindow('close');
    
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    
    var curfromdate = $('#fromdate').jqxDateTimeInput('getDate');
    var oneyeardate = new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
    var oneyearbackdate = new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
    $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
    
    $("#postingJV").jqxGrid({ disabled: true});
    
    $('#date').on('change', function (event) {
        var maindate = $('#date').jqxDateTimeInput('getDate');
        funDateInPeriod(maindate);
    });
     
    $('#txttypeaccid').dblclick(function(){
        if(document.getElementById("cmbtype").value!=""){
            $('#accountDetailsWindow').jqxWindow('open');
            commenSearchContent('accountsDetailsSearch.jsp?cmbtype='+document.getElementById("cmbtype").value);
        } else {
            $.messager.alert('Message','Select Type.','warning');
            return 0;
        }
    }); 
     
    $('#btnticketadd').click(function(){
        if(document.getElementById("chkticketno").checked==true){
            var branch = $('#cmbbranch').val();
            var fromdate = $('#fromdate').jqxDateTimeInput('val');
            var todate = $('#todate').jqxDateTimeInput('val');
            var type = $('#cmbtype').val();
            var acno = $('#txtaccid').val();
            $('#multiSearchWindow').jqxWindow('open');
            $('#multiSearchWindow').jqxWindow('focus');
            multiSearchContent('multiSearchMaster.jsp?branch='+branch+'&fromdate='+fromdate+'&todate='+todate+'&type='+type+'&acno='+acno);
        }
    });
});

function commenSearchContent(url) {
    $.get(url).done(function (data) {
        $('#accountDetailsWindow').jqxWindow('open');
        $('#accountDetailsWindow').jqxWindow('setContent', data);
    }); 
}   

function multiSearchContent(url) {
    $.get(url).done(function (data) {
        $('#multiSearchWindow').jqxWindow('setContent', data);
    }); 
}   

function funExportBtn(){
    if(parseInt(window.parent.chkexportdata.value)=="1") {
        JSONToCSVCon(data1, 'Traffic-Posting', true);
    } else {
        $("#jqxFleetGrid").jqxGrid('exportdata', 'xls', 'Traffic-Posting');
    }
}

function getacc(event){
    if(event.keyCode==114){
        if(document.getElementById("cmbtype").value!=""){
            $('#accountDetailsWindow').jqxWindow('open');
            commenSearchContent('accountsDetailsSearch.jsp?cmbtype='+document.getElementById("cmbtype").value);
        } else {
            $.messager.alert('Message','Select Type.','warning');
            return 0;
        }
    }
}   

function funreload(event){
    var branchval = document.getElementById("cmbbranch").value;
    if(branchval=="a") {
        $.messager.alert('Message','Choose A Specific Branch.','warning');
        return 0;
    }
    
    var fromdate = $('#fromdate').val();
    var todate = $('#todate').val();
    var paytype = $('#cmbtype').val();
    var txttypeaccid = $('#txttypeaccid').val();
    
    var maindate = $('#date').jqxDateTimeInput('getDate');
    var validdate = funDateInPeriod(maindate);
    if(validdate==0){ return 0; }
    
    if(paytype==''){ $.messager.alert('Message','Please Choose Type.','warning'); return 0; }
    if(fromdate==''){ $.messager.alert('Message','Please Enter From Date.','warning'); return 0; }
    if(todate==''){ $.messager.alert('Message','Please Enter To Date.','warning'); return 0; }
    if(txttypeaccid==''){ $.messager.alert('Message','Search Account.','warning'); return 0; }
    
    $("#postingJV").jqxGrid('clear');
    $("#overlay, #PleaseWait").show();
    
    var ticketno = $('#hidticketno').val();
    $("#postingCashDiv").load("postingTrafficgrid.jsp?fromdate="+fromdate+'&todate='+todate+'&chk='+"GO&ticketno="+ticketno);
}

function funCalculate(){
    var branchval = document.getElementById("cmbbranch").value;
    var txttypeaccid = document.getElementById("txttypeaccid").value;
    if(branchval=="a") {
        $.messager.alert('Message','Choose A Specific Branch.','warning');
        return 0;
    }
    var maindate = $('#date').jqxDateTimeInput('getDate');
    var validdate = funDateInPeriod(maindate);
    if(validdate==0){ return 0; }
    
    if($('#cmbtype').val()==''){ $.messager.alert('Message','Please Choose Type.','warning'); return 0; }
    if(txttypeaccid==''){ $.messager.alert('Message','Search Account.','warning'); return 0; }
    
    document.getElementById("calcu").value=1;
    var rows = $('#postingJV').jqxGrid('getrows');
    var rowlength = rows.length;
    
    if(rowlength!=0){
        $.messager.alert('Message','Already calculated.Submit Again. ','warning');
        return 0;
    } else {
        $("#postingJV").jqxGrid('clear');
    }
    
    var temp1="";
    $("#overlay, #PleaseWait").show();
    var selectedrows = $("#jqxFleetGrid").jqxGrid('selectedrowindexes');
    
    if(selectedrows.length==0){
        $("#overlay, #PleaseWait").hide();
        $.messager.alert('Warning','Select Items to be Calculated.');
        return false;
    }
    
    var rows = $('#postingJV').jqxGrid('getrows');
    var rowlength = rows.length;
    if(rowlength==0){
        $("#postingJV").jqxGrid('addrow', null, {});
        $("#postingJV").jqxGrid('addrow', null, {});
    }
    $("#postingJV").jqxGrid({ disabled: false});
        
    var rows = $("#jqxFleetGrid").jqxGrid('getrows');
    if(rows.length==1 && (rows[0].amount=="undefined" || rows[0].amount==null || rows[0].amount=="")){
        return false;
    }
    
    var selectedrows = $("#jqxFleetGrid").jqxGrid('selectedrowindexes');
    selectedrows = selectedrows.sort(function(a,b){return a - b});
    if(selectedrows.length==0){
        $("#overlay, #PleaseWait").hide();
        $.messager.alert('Warning','Select Items to be Calculated.');
        return false;
    }
    
    var i=0; var temp="";
    $('#gridlength').val(selectedrows.length);
    var j=0; var k=0;
    for (i = 0; i < rows.length; i++) {
        if(selectedrows[j]==i){
            $("#jqxFleetGrid").jqxGrid('setcellvalue', i, "totalamount", $('#jqxFleetGrid').jqxGrid('getcellvalue', i, "amount"));
            if(k==0){
                k=10;
                temp=rows[i].ticket_no;
            } else {
                temp=temp+"::"+rows[i].ticket_no;
            }
            temp1=temp;
            j++; 
        }
    }
    
    $('#txttrno').val(temp1);
    $("#overlay, #PleaseWait").hide();
}

function getAccounts(){
    document.getElementById("txttypeaccid").value="";
    document.getElementById("txttypeaccname").value="";
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            var docNoItems = items[0];
            var accountIdItems = items[1];
            var accountItems = items[2];
            var accountTypeItems = items[3];
            var accountCurIdItems = items[4];
            var accountRateItems = items[5];
            var accCurrTypeItems = items[6];
            $('#txtdocno').val(docNoItems); 
            $('#txtaccid').val(accountIdItems);
            $('#txtaccname').val(accountItems);
            $('#txtatype').val(accountTypeItems);
            $('#txtcurid').val(accountCurIdItems);
            $('#txtrate').val(accountRateItems);
            $('#txtcurtype').val(accCurrTypeItems);
        }
    }
    x.open("GET", "getAccounts.jsp?paytype="+$('#fromdate').val(), true);
    x.send();
}
      
function funNotify(){   
    var maindate = $('#todate').jqxDateTimeInput('getDate');
    var validdate = funDateInPeriod(maindate);
    if(validdate==0){ return 0; }
    
    if(document.getElementById("calcu").value==""){
        $.messager.alert('Warning','Calculate & then Generate.');
        return false;
    }
        
    var paytype = $('#cmbtype').val();
    if(paytype==""){
        var rows = $("#jqxFleetGrid").jqxGrid('getrows');                    
        if(rows.length>0 && (rows[0].netamt=="undefined" || rows[0].netamt==null || rows[0].netamt=="")){
            return false;
        }
        var branchval = document.getElementById("cmbbranch").value;
        var txttypeaccid = document.getElementById("txttypeaccid").value;
        if(branchval=="a"){ $.messager.alert('Message','Choose A Specific Branch.','warning'); return 0; }
        if(paytype==''){ $.messager.alert('Message','Please Choose Type.','warning'); return 0; }
        if(txttypeaccid==''){ $.messager.alert('Message','Search Account.','warning'); return 0; }
        
        var selectedrows = $("#jqxFleetGrid").jqxGrid('selectedrowindexes');
        if(selectedrows.length==0){
            $.messager.alert('Warning','Select Items,Calculate & then Generate.');
            return false;
        }
    }
        
    $.messager.confirm('Confirm', 'Do you want to Post?', function(r){
        if (r){
            /* Journal Voucher Grid Saving */
            var rows = $("#postingJV").jqxGrid('getrows');
            var length = 0;
            for(var i=0; i < rows.length; i++){
                var chk=rows[i].docno;
                if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
                    newTextBox = $(document.createElement("input"))
                    .attr("type", "dil")
                    .attr("id", "test"+length)
                    .attr("name", "test"+length)
                    .attr("hidden", "true");
                    length = length+1;
                    
                    var amount,baseamount,id;
                    if((rows[i].credit!=null) && (rows[i].credit!='undefined') &&  (rows[i].credit!='NaN') && (rows[i].credit!="") && (rows[i].credit!=0)){
                        amount=rows[i].credit*-1;
                        baseamount=rows[i].baseamount*-1;
                        id=-1;
                    }
                    if((rows[i].debit!=null) && (rows[i].debit!='undefined') && (rows[i].debit!='NaN') && (rows[i].debit!="") && (rows[i].debit!=0)){
                        amount=rows[i].debit;
                        baseamount=rows[i].baseamount;
                        id=1;
                    }
                    
                    newTextBox.val(rows[i].docno+"::"+rows[i].description+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+amount+"::"+baseamount+"::0::"+id+":: :: ");
                    newTextBox.appendTo('form');
                }
            }
            $('#jvgridlength').val(length);
            /* Journal Voucher Grid Saving Ends */
            
            document.getElementById("mode").value='A';
            $("#overlay, #PleaseWait").show();
            document.getElementById("frmDashboardPostings").submit();
        }
    });
    return 1;
} 
  
function funClearInfo() {
    document.getElementById("txttypeaccid").value="";
    document.getElementById("txttypedocno").value="";
    document.getElementById("txttypeatype").value="";
    document.getElementById("txttypecurid").value="";
    document.getElementById("txttyperate").value ="";
    document.getElementById("txttypetype").value=""; 
    document.getElementById("txttrno").value="";
    document.getElementById("txtaccid").value=""; 
    document.getElementById("txtaccname").value="";
    document.getElementById("txtdocno").value=""; 
    document.getElementById("txtatype").value="";
    document.getElementById("txtcurid").value=""; 
    document.getElementById("txtrate").value="";
    document.getElementById("txtcurtype").value="";
    document.getElementById("hidticketno").value="";
    document.getElementById("ticketdetails").value="";
}
      
function setValues(){
    document.getElementById("cmbtype").value="";
    
    if($('#hidfromdate').val()){ $("#fromdate").jqxDateTimeInput('val', $('#hidfromdate').val()); }
    if($('#hidtodate').val()){ $("#todate").jqxDateTimeInput('val', $('#hidtodate').val()); }
    if($('#hiddate').val()){ $("#date").jqxDateTimeInput('val', $('#hiddate').val()); }
    
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
        var fromdate = $('#fromdate').val();
        var todate = $('#todate').val();
        $("#postingCashDiv").load("postingTrafficgrid.jsp?fromdate="+fromdate+'&todate='+todate+'&chk='+"GO");
    }
    $('#txtdrtotal').val('0.00'); $('#txtcrtotal').val('0.00');
}
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmDashboardPostings" action="saveDbTrafficPosting" method="post">

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
                        <td class="label-cell">Period</td>
                        <td>
                            <div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div>
                            <input type="hidden" id="hidfromdate" name="hidfromdate" value='<s:property value="hidfromdate"/>'>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">To</td>
                        <td>
                            <div id="todate" name="todate" value='<s:property value="todate"/>'></div>
                            <input type="hidden" id="hidtodate" name="hidtodate" value='<s:property value="hidtodate"/>'>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Type</td>
                        <td>
                            <select id="cmbtype" name="cmbtype" onchange="getAccounts();" value='<s:property value="cmbtype"/>'>
                                <option value="">--Select--</option>
                                <option value="1">Cash</option>
                                <option value="2">Bank</option>
                                <option value="3">GL</option>
                            </select>
                            <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Account</td>
                        <td>
                            <input type="text" id="txttypeaccid" name="txttypeaccid" readonly
                                   placeholder="Press F3 To search" value='<s:property value="txttypeaccid"/>'
                                   onkeydown="getacc(event);">
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <input type="text" id="txttypeaccname" name="txttypeaccname" readonly
                                   value='<s:property value="txttypeaccname"/>'>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Tickets</td>
                        <td>
                            <div class="inline-controls">
                                <input type="checkbox" id="chkticketno" name="chkticketno">
                                <label for="chkticketno" style="font-size:12px;font-weight:600;color:#4e5e71;cursor:pointer;">Enable</label>
                                <button type="button" id="btnticketadd" class="btn-icon" title="Add" onclick="funTicketAdd();">+</button>
                                <button type="button" id="btnticketremove" class="btn-icon" title="Remove" onclick="funTicketRemove();">-</button>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <textarea id="ticketdetails" class="master-textarea" readonly></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Post Date</td>
                        <td>
                            <div id="date" name="date" value='<s:property value="date"/>'></div>
                            <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'>
                        </td>
                    </tr>
                </table>
                
                <div class="button-group">
                    <button type="button" class="btn-submit" id="clear" onclick="funClearInfo();" style="background:#64748b !important;">
                        Clear
                    </button>
                    <button type="button" class="btn-submit" id="btnGenerate" onclick="funNotify();">
                        Post
                    </button>
                </div>
            </div>

            <!-- HIDDEN FIELDS -->
            <div style="display:none;">
                <input type="hidden" id="gridlength" name="gridlength">
                <input type="hidden" id="jvgridlength" name="jvgridlength">
                <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'>
                <input type="hidden" id="calcu" name="calcu" value='<s:property value="calcu"/>'>
                <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
                <input type="hidden" id="txttypedocno" name="txttypedocno">
                <input type="hidden" id="txttypeatype" name="txttypeatype">
                <input type="hidden" id="txttypecurid" name="txttypecurid">
                <input type="hidden" id="txttyperate" name="txttyperate">
                <input type="hidden" id="txttypetype" name="txttypetype">
                <input type="hidden" id="txttrno" name="txttrno">
                <input type="hidden" id="txtaccid" name="txtaccid">
                <input type="hidden" id="txtaccname" name="txtaccname">
                <input type="hidden" id="txtdocno" name="txtdocno">
                <input type="hidden" id="txtatype" name="txtatype">
                <input type="hidden" id="txtcurid" name="txtcurid">
                <input type="hidden" id="txtrate" name="txtrate">
                <input type="hidden" id="txtcurtype" name="txtcurtype">
                <input type="hidden" id="hidticketno" name="hidticketno">
            </div>

        </div>
    </div>
</td>

<!-- ================= RIGHT SIDE (GRIDS) ================= -->
<td valign="top">
    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            
            <div id="postingCashDiv">
                <jsp:include page="postingTrafficgrid.jsp"></jsp:include>
            </div>

            <div id="JVTDiv" style="margin-top: 15px;">
                <jsp:include page="journalVoucherGrid.jsp"></jsp:include>
            </div>

            <!-- TOTALS ROW -->
            <div class="bottom-total-row">
                <div style="display:flex; align-items:center; gap:8px;">
                    <span style="font-weight:bold; font-size:13px; color:#333;">Dr. Total:</span>
                    <input type="text" id="txtdrtotal" readonly style="width:130px; text-align:right; font-weight:bold; background-color:#f8fafc !important;">
                </div>
                <div style="display:flex; align-items:center; gap:8px;">
                    <span style="font-weight:bold; font-size:13px; color:#333;">Cr. Total:</span>
                    <input type="text" id="txtcrtotal" readonly style="width:130px; text-align:right; font-weight:bold; background-color:#f8fafc !important;">
                </div>
            </div>

        </div>
    </div>
</td>

</tr>
</table>

</div>
</div>

<!-- POPUPS -->
<div id="accountDetailsWindow"><div></div><div></div></div>
<div id="multiSearchWindow"><div></div><div></div></div>

</div>
</form>
</body>
</html>