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
    margin-bottom: 15px;
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
input[type="text"], select, textarea,
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
    font-family: inherit;
}

textarea#clientinfo {
    height: 80px !important;
    resize: none;
    margin-top: 5px;
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
input[readonly], input:disabled, select:disabled, textarea[readonly],
.filter-table input[readonly], .filter-table input:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed;
    cursor: not-allowed;
}

input[type="checkbox"] {
    margin: 0;
    cursor: pointer;
    width: 14px;
    height: 14px;
}

/* Inline Controls (Input + Button + Checkbox) */
.inline-controls {
    display: flex;
    gap: 6px;
    align-items: center;
    width: 100%;
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
}

.btn-icon:hover { background: #cbd5e1; }
.btn-icon:disabled { cursor: not-allowed; opacity: 0.6; }
.btn-icon img { height: 14px; width: 14px; }

/* jqx date/time containers */
div[id^="uptodate"], div[id^="date"], div[id^="chqdate"] {
    width: 100%;
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
    padding: 0 5px;         
    background: #2563eb;
    color: #fff;
    border: none;
    border-radius: 4px;      
    font-size: 12px;
    font-weight: 600;
    cursor: pointer;
    line-height: 30px;       
    text-align: center;
    transition: background 0.2s;
}

.btn-submit:hover:not(:disabled) { background: #1d4ed8; }
.btn-submit.btn-secondary { background: #64748b; }
.btn-submit.btn-secondary:hover:not(:disabled) { background: #475569; }
.btn-submit:disabled { background: #94a3b8 !important; cursor: not-allowed; }

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

/* Block layout required for JQX grids to calculate percentage height properly */
.grid-content-container {
    flex: 1;
    padding: 15px;
    overflow: auto; 
    box-sizing: border-box;
    display: block; 
}

.bottom-total-row {
    margin-top: 15px;
    display: flex;
    justify-content: flex-end;
    align-items: center;
    gap: 10px;
    font-size: 13px;
    font-weight: 600;
    color: #333;
}

/* Fix for jqx widget overrides */
.jqx-widget input, .jqx-widget select {
    height: 24px !important;
    line-height: 24px !important;
}
</style>

<script type="text/javascript">
$(document).ready(function () {
    // Standardized UI Controls
    $("#uptodate, #date, #chqdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    
    // Popup Windows Setup (Using exactly 2 nested divs)
    const winOpts = { height: '58%', theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27 };
    $('#accountDetailsWindow').jqxWindow({ ...winOpts, width: '51%', maxHeight: '70%', maxWidth: '51%', title: 'Search', position: { x: 300, y: 87 } }).jqxWindow('close');
    $('#branchSearchWindow').jqxWindow({ ...winOpts, width: '20%', maxHeight: '60%', maxWidth: '30%', title: 'Branch Search', position: { x: 250, y: 120 } }).jqxWindow('close');
    $('#cardDetailsWindow').jqxWindow({ ...winOpts, width: '30%', maxHeight: '70%', maxWidth: '30%', title: 'Card Search', position: { x: 300, y: 87 } }).jqxWindow('close');
    $('#agmtDetailsWindow').jqxWindow({ ...winOpts, width: '30%', maxHeight: '70%', maxWidth: '30%', title: 'Agreement Search', position: { x: 300, y: 87 } }).jqxWindow('close');
    
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    
    document.getElementById("hidchckibbranch").value=0;
     
    // Double Clicks
    $('#txtclientaccount').dblclick(function(){ accountsSearchContent('clientDetailsSearch.jsp'); });
    $('#txttypeaccid').dblclick(function(){ accountsSearchContent('accountsDetailsSearch.jsp'); });
    $('#txtibbranch').dblclick(function(){ branchSearchContent('branchSearchGrid.jsp?check=1'); });
      
    // Initial State Overrides
    $('#cmbtype').attr('disabled', true); $('#txttypeaccid').attr('readonly', true);
    $('#txtchequeno').attr('readonly', true); $('#txtremarks').attr('readonly', true); $('#txtibbranch').attr('disabled', true);
    $('#btnRefund').attr('disabled', true); $('#btnRelease').attr('disabled', true); 
    $('#date').jqxDateTimeInput({disabled: true}); $('#chqdate').jqxDateTimeInput({disabled: true});
    $('#cmbcardtype').attr('disabled', true); $('#btnCardSearch').attr('disabled', true);
});

// Loaders
function accountsSearchContent(url) { $('#accountDetailsWindow').jqxWindow('open'); $.get(url).done(function (data) { $('#accountDetailsWindow').jqxWindow('setContent', data).jqxWindow('bringToFront'); }); }
function branchSearchContent(url) { $('#branchSearchWindow').jqxWindow('open'); $.get(url).done(function (data) { $('#branchSearchWindow').jqxWindow('setContent', data).jqxWindow('bringToFront'); }); } 
function cardSearchContent(url) { $('#cardDetailsWindow').jqxWindow('open'); $.get(url).done(function (data) { $('#cardDetailsWindow').jqxWindow('setContent', data).jqxWindow('bringToFront'); }); }
function agmtSearchContent(url) { $('#agmtDetailsWindow').jqxWindow('open'); $.get(url).done(function (data) { $('#agmtDetailsWindow').jqxWindow('setContent', data).jqxWindow('bringToFront'); }); }

function funChangeAgreement(){
    var doc= $('#txtclientdocno').val();
    agmtSearchContent('agmtsearchGrid.jsp?cldoc='+doc);
}

function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
        $.messager.alert('Message',' Enter Numbers Only ','warning');   
        return false;
    }
    return true;
}

function getAccounts(a,b){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.split('####');
            $('#txttypedocno').val(items[0]);   
            $('#txttypeaccid').val(items[1]);
            $('#txttypeaccname').val(items[2]);
            $('#txttypeatype').val(items[3]);
            $('#txttypecurid').val(items[4]);
            $('#txttyperate').val(items[5]);
            $('#txttypetype').val(items[6]);
        }
    }
    x.open("GET", "getAccounts.jsp?paytype="+a+"&date="+b, true);
    x.send();
}

function getPayTypes() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.split('####');
            var cardIdItems  = items[0].split(",");
            var cardItems = items[1].split(",");
            var optionscard = '<option value="">--Select--</option>';
            for (var i = 0; i < cardItems.length; i++) {
                optionscard += '<option value="' + cardIdItems[i].trim() + '">' + cardItems[i] + '</option>';
            }
            $("select#cmbtype").html(optionscard);
            if ($('#hidcmbtype').val() != null) {
                $('#cmbtype').val($('#hidcmbtype').val());
            }
        }
    }
    x.open("GET", "getPayTypes.jsp", true);
    x.send();
}

function getCardTypes() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.split('####');
            var cardIdItems  = items[0].split(",");
            var cardItems = items[1].split(",");
            var optionscard = '<option value="">--Select--</option>';
            for (var i = 0; i < cardItems.length; i++) {
                optionscard += '<option value="' + cardIdItems[i].trim() + '">' + cardItems[i] + '</option>';
            }
            $("select#cmbcardtype").html(optionscard);
            if ($('#hidcmbcardtype').val() != null) {
                $('#cmbcardtype').val($('#hidcmbcardtype').val());
            }
        }
    }
    x.open("GET", "getCardTypes.jsp", true);
    x.send();
}

// F3 Hotkeys
function getClient(event){ if(event.keyCode==114){ accountsSearchContent('clientDetailsSearch.jsp'); } }
function getAccType(event){ if(event.keyCode==114){ accountsSearchContent('accountsDetailsSearch.jsp'); } }
function getIbBranch(event){ if(event.keyCode==114){ branchSearchContent('branchSearchGrid.jsp?check=1'); } }

function funCardSearch(){ cardSearchContent('cardDetailsSearchGrid.jsp'); }

function ibbranchcheck(){
    if(document.getElementById("chckibbranch").checked){
        document.getElementById("hidchckibbranch").value = 1;
        $('#txtibbranch').attr('disabled', false );
    } else {
        document.getElementById("hidchckibbranch").value = 0;
        $('#txtibbranchid').val('0'); $('#txtibbranch').val('');
        $('#txtibbranch').attr('disabled', true );
        if (document.getElementById("txtibbranch").value == "") {
            $('#txtibbranch').attr('placeholder', 'Press F3 to Search'); 
        }
    }
}

function funreload(event){
    var branchval = document.getElementById("cmbbranch").value;
    var uptodate = $('#uptodate').val();
    var agreementcloseddays = $('#txtagreementcloseddays').val();
    var clientAccount = $('#txtcldocno').val();
    
    $("#overlay, #PleaseWait").show();
    $("#refundableDiv").load("refundGrid.jsp?branchval="+branchval+'&uptodate='+uptodate+'&agreementcloseddays='+agreementcloseddays.replace(/ /g, "%20")+'&chk=1&clientAccount='+clientAccount);
}

function funClearInfo(){
    $('#cmbbranch').val('a');
    $('#uptodate').val(new Date()); $('#date').val(new Date()); $('#chqdate').val(new Date());
    $('#btnRefund,#btnRelease').attr('disabled',false);
    $('#txtagreementcloseddays').val(''); $('#txtclientaccount').val(''); $('#txtclientname').val(''); $('#txtcldocno').val(''); $('#clientinfo').val('');
    $('#txtnetamount').val('0.00');
    
    document.getElementById("hidchckibbranch").value = 0;
    if(document.getElementById("hidchckibbranch").value==0){
        document.getElementById("chckibbranch").checked = false;
    }
    
    $('#txtibbranchid').val('0'); $('#txtibbranch').val('');
    $('#cmbtype').val(''); $('#hidcmbtype').val(''); $('#txttypedocno').val(''); $('#txttypeaccid').val('');
    $('#txttypeaccname').val(''); $('#txttypeatype').val(''); $('#txttypecurid').val(''); $('#txttyperate').val('');
    $('#txttypetype').val(''); $('#txtchequeno').val(''); $('#txtremarks').val('');

    $('#cmbtype').attr('disabled', true); $('#txttypeaccid').attr('readonly', true);
    $('#cmbcardtype').val(''); $('#cmbcardtype').attr('disabled', true);
    $('#txtchequeno').attr('readonly', true); $('#txtremarks').attr('readonly', true); $('#txtibbranch').attr('disabled', true);
    $('#btnRefund').attr('disabled', true); $('#btnRelease').attr('disabled', true); $('#date').jqxDateTimeInput({disabled: true});
    $('#chqdate').jqxDateTimeInput({disabled: true}); $('#btnCardSearch').attr('disabled', true);
    
    $("#jqxRefund").jqxGrid('clear'); $("#jqxRefund").jqxGrid('addrow', null, {});
    
    if (document.getElementById("txtagreementcloseddays").value == "") { $('#txtagreementcloseddays').attr('placeholder', 'Agreement Closed Days'); }
    if (document.getElementById("txtclientaccount").value == "") { $('#txtclientaccount').attr('placeholder', 'Press F3 to Search'); }
    if (document.getElementById("txtibbranch").value == "") { $('#txtibbranch').attr('placeholder', 'Press F3 to Search'); }
}

function bankAccountSearch(){
    if(document.getElementById("cmbtype").value == 5){
        $('#txttypedocno').val(''); $('#txttypeaccid').val(''); $('#txttypeaccname').val('');
        $('#txttypeatype').val(''); $('#txttypecurid').val(''); $('#txttyperate').val('');
        $('#txttypetype').val(''); $('#txtchequeno').attr('readonly', false );
        $('#cmbcardtype').val(''); $('#cmbcardtype').attr('disabled', true );
        $('#btnCardSearch').attr('disabled', true);
        $('#chqdate').jqxDateTimeInput({disabled: false});
        if (document.getElementById("txttypeaccid").value == "") { $('#txttypeaccid').attr('placeholder', 'Press F3 to Search'); }
        $('#txttypeaccid').focus();
    } else if(document.getElementById("cmbtype").value == 6 || document.getElementById("cmbtype").value == 4){
        $('#txttypeaccid').attr('tabindex', '-1'); $('#txttypeaccname').attr('tabindex', '-1');
        $('#cmbcardtype').val(''); $('#cmbcardtype').attr('disabled', false );
        $('#txtchequeno').attr('readonly', false ); $('#btnCardSearch').attr('disabled', false);
        $('#chqdate').jqxDateTimeInput({disabled: false});
    } else {
        $('#txttypeaccid').attr('tabindex', '-1'); $('#txttypeaccname').attr('tabindex', '-1');
        $('#cmbcardtype').val(''); $('#cmbcardtype').attr('disabled', true );
        $('#txtchequeno').attr('readonly', true ); $('#btnCardSearch').attr('disabled', true);
        $('#chqdate').jqxDateTimeInput({disabled: true});
    }
}

function funRefund(event){
    var refunddate = $('#date').val();
    var ibbranch = $('#txtibbranchid').val();
    var chckibbranch = $('#hidchckibbranch').val();
    var type = $('#cmbtype').val();
    var typeaccount = $('#txttypedocno').val();
    var chequeno = $('#txtchequeno').val();
    var remarks = $('#txtremarks').val();
    var clientaccount = $('#txtclaccount').val();
    var clientdocno = $('#txtclientdocno').val();
    var clientname = $('#txtclname').val();
    var rano = $('#txtrano').val();
    var rtype = $('#txtrtype').val();
    var mainbrhid = $('#txtmainbrhid').val();
    var securityamount = $('#txtsecurityamount').val();
    var balanceamount = $('#txtbalanceamount').val();
    var cardtype = $('#cmbcardtype').val();
    var process="REFUNDED";
    
    if(type==''){ $.messager.alert('Message','Please Choose a Type.','warning'); return 0; }
    if(typeaccount==''){ $.messager.alert('Message','Please Choose an Account.','warning'); return 0; }
    if(securityamount.trim()==''){ $.messager.alert('Message','Security Amount Unavailable, Transaction Restricted.','warning'); return 0; }
    if($('#cmbbranch').val()=='a'){ $.messager.alert('Message','Please Select a Branch.','warning'); return 0; }
    if(($('#hidchckibbranch').val()=='1') && ($('#txtibbranchid').val()=='0')){ $.messager.alert('Message','Please Choose Inter-Branch.','warning'); return 0; }
    
    var ibvalid=document.getElementById("txtibvalidation").value;
    if(ibvalid==1){ $.messager.alert('Message','Closing Done For Inter-Branch,Transaction Restricted.','warning'); return 0; }
    
    var date = $('#date').jqxDateTimeInput('getDate');
    var validdate=funDateInPeriod(date);
    if(validdate==0){ return 0; }
    
    $.messager.confirm('Message', 'Do you want to Refund Security?', function(r){
        if(r==false) { return false; } else {
            $('#chqdate').jqxDateTimeInput({disabled: false});
            var chequedate = $('#chqdate').val();
            $("#overlay, #PleaseWait").show();
            saveGridData(refunddate,ibbranch,chckibbranch,type,typeaccount,chequeno,chequedate,remarks,clientaccount,clientdocno,clientname,rano,rtype,mainbrhid,securityamount,balanceamount,cardtype,process); 
        }
    });
}

function funRelease(event){
    var refunddate = $('#date').val();
    var ibbranch = $('#txtibbranchid').val();
    var chckibbranch = $('#hidchckibbranch').val();
    var type = $('#cmbtype').val();
    var typeaccount = $('#txttypedocno').val();
    var chequeno = $('#txtchequeno').val();
    var remarks = $('#txtremarks').val();
    var clientaccount = $('#txtclaccount').val();
    var clientdocno = $('#txtclientdocno').val();
    var clientname = $('#txtclname').val();
    var rano = $('#txtrano').val();
    var rtype = $('#txtrtype').val();
    var mainbrhid = $('#txtmainbrhid').val();
    var securityamount = $('#txtsecurityamount').val();
    var balanceamount = $('#txtbalanceamount').val();
    var cardtype = $('#cmbcardtype').val();
    var process="RELEASED";
    
    if(securityamount.trim()==''){ $.messager.alert('Message','Security Amount Unavailable, Transaction Restricted.','warning'); return 0; }
    if($('#cmbbranch').val()=='a'){ $.messager.alert('Message','Please Select a Branch.','warning'); return 0; }
    
    var date = $('#date').jqxDateTimeInput('getDate');
    var validdate=funDateInPeriod(date);
    if(validdate==0){ return 0; }
    
    $.messager.confirm('Message', 'Do you want to Release Security?', function(r){
        if(r==false) { return false; } else {
            $('#chqdate').jqxDateTimeInput({disabled: false});
            var chequedate = $('#chqdate').val();
            $("#overlay, #PleaseWait").show();
            saveGridData(refunddate,ibbranch,chckibbranch,type,typeaccount,chequeno,chequedate,remarks,clientaccount,clientdocno,clientname,rano,rtype,mainbrhid,securityamount,balanceamount,cardtype,process); 
        }
    });
}

function saveGridData(refunddate,ibbranch,chckibbranch,type,typeaccount,chequeno,chequedate,remarks,clientaccount,clientdocno,clientname,rano,rtype,mainbrhid,securityamount,balanceamount,cardtype,process){
    $('#btnRefund,#btnRelease').attr('disabled',true);
    $("#jqxRefund").jqxGrid({disabled:true});
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items=x.responseText.split('***');
            var val = items[0];
            var rrpno = items[1];
            var result = items[2].toLowerCase().replace(/\b[a-z]/g, function(letter) {
                return letter.toUpperCase();
            });
            $.messager.alert('Message', ''+result+' Successfully, Doc No. '+rrpno+'');
            funClearInfo();
            funreload(event); 
        }
    }
    x.open("GET","saveData.jsp?refunddate="+refunddate+"&ibbranch="+ibbranch+"&chckibbranch="+chckibbranch+"&type="+type+"&typeaccount="+typeaccount+"&chequeno="+chequeno+"&chequedate="+chequedate+"&remarks="+remarks+"&clientaccount="+clientaccount+"&clientdocno="+clientdocno+"&clientname="+clientname+"&rano="+rano+"&rtype="+rtype+"&mainbranch="+mainbrhid+"&securityamount="+securityamount+"&balanceamount="+balanceamount+"&cardtype="+cardtype+"&process="+process,true);
    x.send();
}

function funExportBtn(){
    if(parseInt(window.parent.chkexportdata.value)=="1") {
        JSONToCSVCon(data, 'SecurityRefund', true);
    } else {
        $("#jqxRefund").jqxGrid('exportdata', 'xls', 'SecurityRefund');
    }
}
</script>
</head>

<body onload="getBranch();getCardTypes();getPayTypes();">

<div id="mainBG" class="homeContent" data-type="background">

    <div class="master-container">

        <!-- ================= LEFT SIDEBAR ================= -->
        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">
                
                <!-- Filter Group 1 -->
                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">Up To</td>
                            <td><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Closed Before</td>
                            <td>
                                <input type="text" id="txtagreementcloseddays" name="txtagreementcloseddays"
                                       placeholder="Agreement Closed Days" onkeypress="javascript:return isNumber(event)"
                                       value='<s:property value="txtagreementcloseddays"/>'>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Client</td>
                            <td>
                                <div class="inline-controls">
                                    <input type="text" id="txtclientaccount" name="txtclientaccount" readonly
                                           placeholder="Press F3 to Search" value='<s:property value="txtclientaccount"/>'
                                           onkeydown="getClient(event);">
                                    <button type="button" class="btn-icon" title="Change Agreement" onclick="funChangeAgreement();">
                                        <img src="<%=contextPath%>/icons/add_new.png" alt="">
                                    </button>
                                </div>
                                <input type="hidden" id="hiddocno" name="hiddocno" value='<s:property value="hiddocno"/>'>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <input type="text" id="txtclientname" name="txtclientname" readonly tabindex="-1" value='<s:property value="txtclientname"/>'>
                                <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <textarea id="clientinfo" readonly><s:property value="clientinfo"/></textarea>
                            </td>
                        </tr>
                    </table>
                </div>

                <!-- Filter Group 2 -->
                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">Date</td>
                            <td>
                                <div id="date" name="date" value='<s:property value="date"/>'></div>
                                <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Branch</td>
                            <td>
                                <div class="inline-controls">
                                    <input type="text" id="txtibbranch" name="txtibbranch" readonly
                                           placeholder="Press F3 to Search" value='<s:property value="txtibbranch"/>'
                                           onkeydown="getIbBranch(event);">
                                    <input type="checkbox" id="chckibbranch" name="chckibbranch" onchange="ibbranchcheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                                </div>
                                <input type="hidden" id="txtibbranchid" name="txtibbranchid" value='<s:property value="txtibbranchid"/>'>
                                <input type="hidden" id="hidchckibbranch" name="hidchckibbranch" value='<s:property value="hidchckibbranch"/>'>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Type</td>
                            <td>
                                <select id="cmbtype" name="cmbtype" onchange="bankAccountSearch();getAccounts(this.value,$('#date').val());" value='<s:property value="cmbtype"/>'></select>
                                <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Account</td>
                            <td>
                                <input type="text" id="txttypeaccid" name="txttypeaccid" readonly value='<s:property value="txttypeaccid"/>' onkeydown="getAccType(event);">
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td><input type="text" id="txttypeaccname" name="txttypeaccname" readonly value='<s:property value="txttypeaccname"/>'></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Card Type</td>
                            <td>
                                <div class="inline-controls">
                                    <select id="cmbcardtype" name="cmbcardtype" value='<s:property value="cmbcardtype"/>'>
                                        <option value="">--Select--</option>
                                    </select>
                                    <button type="button" id="btnCardSearch" class="btn-icon" onclick="funCardSearch();">
                                        <img src="<%=contextPath%>/icons/cardsearch.png" alt="">
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Chq/Card No.</td>
                            <td><input type="text" id="txtchequeno" name="txtchequeno" value='<s:property value="txtchequeno"/>'></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Chq/Card Dt</td>
                            <td><div id="chqdate" name="chqdate" value='<s:property value="chqdate"/>'></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Remarks</td>
                            <td><input type="text" id="txtremarks" name="txtremarks" value='<s:property value="txtremarks"/>'></td>
                        </tr>
                    </table>

                    <!-- Action Buttons -->
                    <div class="button-group">
                        <button class="btn-submit" type="button" id="btnRefund" onclick="funRefund(event);">Refund</button>
                        <button class="btn-submit btn-secondary" type="button" id="clear" onclick="funClearInfo();">Clear</button>
                        <button class="btn-submit" type="button" id="btnRelease" onclick="funRelease(event);">Release</button>
                    </div>

                </div>

                <!-- Global Hidden Data -->
                <div style="display:none;">
                    <input type="hidden" id="txtclientdocno" name="txtclientdocno">
                    <input type="hidden" id="txtclaccount" name="txtclaccount">
                    <input type="hidden" id="txtclname" name="txtclname">
                    <input type="hidden" id="txtrano" name="txtrano">
                    <input type="hidden" id="txtrtype" name="txtrtype">
                    <input type="hidden" id="txtmainbrhid" name="txtmainbrhid">
                    <input type="hidden" id="txtsecurityamount" name="txtsecurityamount">
                    <input type="hidden" id="txtbalanceamount" name="txtbalanceamount">
                    <input type="hidden" id="txtibvalidation" name="txtibvalidation">
                    <input type="hidden" id="txthidtype" name="txthidtype">
                    <input type="hidden" id="txthidtrno" name="txthidtrno">
                    <input type="hidden" id="txthidvoc" name="txthidvoc">
                    <div id="paychaaaaa"></div>
                </div>

            </div>
        </div>

        <!-- ================= RIGHT CONTENT AREA ================= -->
        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="refundableDiv">
                    <jsp:include page="refundGrid.jsp"></jsp:include>
                </div>
                
                <div class="bottom-total-row">
                    <label style="font-size: 13px; font-weight: bold; color: #333;">Net Balance :</label>
                    <input type="text" id="txtnetamount" class="textbox" readonly
                           style="width: 150px; text-align: right; background-color: #f8fafc;"
                           value='<s:property value="txtnetamount"/>'>
                </div>
            </div>

        </div>

    </div>

    <!-- POPUPS -->
    <div id="accountDetailsWindow"><div></div><div></div></div>
    <div id="branchSearchWindow"><div></div><div></div></div>
    <div id="cardDetailsWindow"><div></div><div></div></div>
    <div id="agmtDetailsWindow"><div></div><div></div></div>

</div>
</body>
</html>