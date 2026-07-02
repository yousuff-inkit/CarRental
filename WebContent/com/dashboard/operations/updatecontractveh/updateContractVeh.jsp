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
    font-weight: 600;
    color: #4e5e71;
    width: 110px; /* Slightly wider for "Agreement Type" */
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

textarea#agmtdetails {
    height: 120px !important;
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

/* jqx date/time containers */
div[id^="fromdate"], div[id^="todate"] {
    width: 100%;
}

/* ===== BUTTONS ===== */
.button-group {
    display: flex;
    gap: 10px;
    justify-content: center;
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
     // Standardized height to 24px and width to 100%
     $("#fromdate, #todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    
     $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");

     var curfromdate = $('#fromdate').jqxDateTimeInput('getDate');
     var onemonthbackdate = new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
     $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
     
     // Note: jqxWindow requires two nested divs
     $('#clientsearchwindow').jqxWindow({ width: '49%', height: '65%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
     $('#clientsearchwindow').jqxWindow('close');
     
     $('#agmtnowindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Agreement Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
     $('#agmtnowindow').jqxWindow('close');
     
     $('#client').dblclick(function(){
         $('#clientsearchwindow').jqxWindow('open');
         $('#clientsearchwindow').jqxWindow('focus');
         clientSearchContent('clientINgridsearch.jsp', $('#clientsearchwindow'));
     });
     
     $('#hidagmtno').dblclick(function(){
         if(document.getElementById("agmttype").value == ""){
             $.messager.alert('warning','Please Select Agreement Type');
             return false;
         }
         $('#agmtnowindow').jqxWindow('open');
         $('#agmtnowindow').jqxWindow('focus');
         agmtSearchContent('agmtSearch.jsp?agmttype='+document.getElementById("agmttype").value+'&branch='+document.getElementById("cmbbranch").value, $('#agmtnowindow'));
     });
});


function getClient(event){
    var x = event.keyCode;
    if(x == 114){
         $('#clientsearchwindow').jqxWindow('open');
         $('#clientsearchwindow').jqxWindow('focus');
         clientSearchContent('clientINgridsearch.jsp', $('#clientsearchwindow'));    
    }
}

function getAgmtno(event){
    var x = event.keyCode;
    if(x == 114){
         if(document.getElementById("agmttype").value == ""){
             $.messager.alert('warning','Please Select Agreement Type');
             return false;
         }
         $('#agmtnowindow').jqxWindow('open');
         $('#agmtnowindow').jqxWindow('focus');
         agmtSearchContent('agmtSearch.jsp?agmttype='+document.getElementById("agmttype").value+'&branch='+document.getElementById("cmbbranch").value, $('#agmtnowindow'));
    }
}

function clientSearchContent(url) {
    $.get(url).done(function (data) {
        $('#clientsearchwindow').jqxWindow('setContent', data);
    }); 
}

function agmtSearchContent(url) {
    $.get(url).done(function (data) {
        $('#agmtnowindow').jqxWindow('setContent', data);
    }); 
}

function funreload(event)
{
    if(document.getElementById("cmbbranch").value == ""){
        $.messager.alert('Warning','Please Select Branch');
        return false;
    }
    var dateval = funDateInPeriod($('#todate').jqxDateTimeInput('getDate'));
    if(dateval == 1){
        var branch = document.getElementById("cmbbranch").value;
        var fromdate = $('#fromdate').jqxDateTimeInput('val');
        var todate = $('#todate').jqxDateTimeInput('val');
        var agmttype = document.getElementById("agmttype").value;
        var agmtno = document.getElementById("agmtno").value;
        var cldocno = document.getElementById("hidclient").value;
        
        $("#overlay, #PleaseWait").show();
        $("#contractdiv").load("UpdateContractGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&agmttype="+agmttype+"&agmtno="+agmtno+"&cldocno="+cldocno+"&id=1"); 
    }
}

function funExportBtn(){
    if(parseInt(window.parent.chkexportdata.value.trim()) == "1") {
        JSONToCSVCon(updatedata, 'Permanent_Vehicle_Update', true);
    }
}

function setValues(){
     if($('#msg').val() != ""){
       $.messager.alert('Message',$('#msg').val());
      }
}

function funClearData(){
    $('input[type=text],[type=hidden]').val('');
    $('#agmttype').val('');
    $('#agmtdetails').val('');
}

function funUpdateData(){
    if(document.getElementById("agmtdetails").value == ""){
        $.messager.alert('Message','Please Select an Agreement');
        return false;
    }

    var reg = document.getElementById("hidfleetreg").value;
    var agmtno = document.getElementById("agmtno").value;
    var agmttype = document.getElementById("agmttype").value;
    var fleet = document.getElementById("hidofleet").value;
    
    $.messager.confirm('Confirm', 'Do you want to update Vehicle No: '+fleet+' '+reg+' of Agmt No: '+agmttype+' '+agmtno+' as Permanent Vehicle', function(r){ 
        if (r){
            $("#overlay, #PleaseWait").show();
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    $("#overlay, #PleaseWait").hide();
                    $.messager.alert('Message',items); 
                    funClearData();
                    funreload(reg);
                }
            }
            x.open("GET", "updateContract.jsp?agmtno="+agmtno+"&agmttype="+agmttype+"&fleet="+fleet, true);
            x.send();
        }
    });
}
</script>
</head>

<body onload="getBranch();setValues();">
<form id="frmUpdateContract" method="post">

<div id="mainBG" class="homeContent" data-type="background">

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
                            <td class="label-cell">Agreement Type</td>
                            <td>
                                <select name="agmttype" id="agmttype">
                                    <option value="">--Select--</option>
                                    <option value="RAG">Rental</option>
                                    <option value="LAG">Lease</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Agreement No</td>
                            <td>
                                <input type="text" name="hidagmtno" id="hidagmtno" 
                                       placeholder="Press F3 to Search" readonly="readonly" 
                                       onkeydown="getAgmtno(event);">
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Client</td>
                            <td>
                                <input type="text" name="client" id="client" 
                                       placeholder="Press F3 to Search" readonly="readonly" 
                                       onkeydown="getClient(event);">
                                <input type="hidden" name="hidclient" id="hidclient">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <textarea id="agmtdetails" name="agmtdetails" readonly="readonly" placeholder="Agreement Details..."></textarea>
                            </td>
                        </tr>
                    </table>
                </div>

                <div class="button-group">
                    <button class="btn-submit btn-secondary" type="button" id="btnclear" onclick="funClearData();">Clear</button>
                    <button class="btn-submit" type="button" id="btnupdate" onclick="funUpdateData();">Update</button>
                </div>

            </div>
        </div>

        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="contractdiv">
                    <jsp:include page="UpdateContractGrid.jsp"></jsp:include>
                </div>
                
                <div style="display:none;">
                    <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                    <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                    <input type="hidden" name="hidofleet" id="hidofleet">
                    <input type="hidden" name="hidfleetreg" id="hidfleetreg">
                    <input type="hidden" name="agmtno" id="agmtno">
                </div>
            </div>

        </div>

    </div>

    <div id="clientsearchwindow"><div></div><div></div></div>
    <div id="agmtnowindow"><div></div><div></div></div>

</div>
</form>
</body>
</html>