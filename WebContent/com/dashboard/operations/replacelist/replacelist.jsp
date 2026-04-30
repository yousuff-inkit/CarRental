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
    width: 100px;
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

    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
    
    $('#agmtnowindow').jqxWindow({ width: '50%', height: '60%', maxHeight: '80%' ,maxWidth: '50%' , title: 'Agreement Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#agmtnowindow').jqxWindow('close');
    
    $('#clientsearchwindow').jqxWindow({ width: '49%', height: '65%', maxHeight: '75%' ,maxWidth: '50%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#clientsearchwindow').jqxWindow('close');

    // Standardized height to 24px and width to 100%
    $("#fromdate, #todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    
    var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
    
    funGetAgmtBranch();
    funGetReplaceReason();
    
    $('#agmtno').dblclick(function(){
         if(document.getElementById("cmbagmttype").value==""){
             $.messager.alert('warning','Please Select Agreement Type');
             document.getElementById("cmbagmttype").focus();
             return false;
         }
         if(document.getElementById("cmbagmtbranch").value==""){
             $.messager.alert('warning','Please Select Agreement Branch');
             document.getElementById("cmbagmtbranch").focus();
             return false;
         }
         $('#agmtnowindow').jqxWindow('open');
         $('#agmtnowindow').jqxWindow('focus');
         agmtSearchContent('agmtSearch.jsp?agmttype='+document.getElementById("cmbagmttype").value+'&branch='+document.getElementById("cmbagmtbranch").value, $('#agmtnowindow'));
    }); 
});

function getAgmtno(event){
    var x= event.keyCode;
    if(x==114){
        if(document.getElementById("cmbagmttype").value==""){
             $.messager.alert('warning','Please Select Agreement Type');
             document.getElementById("cmbagmttype").focus();
             return false;
         }
         if(document.getElementById("cmbagmtbranch").value==""){
             $.messager.alert('warning','Please Select Agreement Branch');
             document.getElementById("cmbagmtbranch").focus();
             return false;
         }
         $('#agmtnowindow').jqxWindow('open');
         $('#agmtnowindow').jqxWindow('focus');
         agmtSearchContent('agmtSearch.jsp?agmttype='+document.getElementById("cmbagmttype").value+'&branch='+document.getElementById("cmbagmtbranch").value, $('#agmtnowindow'));
    }
}

function agmtSearchContent(url) {
    $.get(url).done(function (data) {
        $('#agmtnowindow').jqxWindow('setContent', data);
    }); 
}

function funGetAgmtBranch(){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            items = items.split('###');
            var branchIdItems  = items[0].split(",");
            var branchItems = items[1].split(",");
            var optionsbranch = '<option value="">--Select--</option>';
            for (var i = 0; i < branchItems.length; i++) {
                optionsbranch += '<option value="' + branchIdItems[i].trim() + '">' + branchItems[i] + '</option>';
            }
            $("select#cmbagmtbranch").html(optionsbranch);
        }
    }
    x.open("GET","getAgmtBranch.jsp", true);
    x.send();
}

function funGetReplaceReason(){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            items = items.split('###');
            var replaceIdItems  = items[0].split(",");
            var replaceItems = items[1].split(",");
            var optionsbranch = '<option value="">--Select--</option>';
            for (var i = 0; i < replaceItems.length;i++){
                optionsbranch += '<option value="' + replaceIdItems[i].trim() + '">' + replaceItems[i] + '</option>';
            }
            $("select#cmbreplacereason").html(optionsbranch);
        }
    }
    x.open("GET","getReplaceReason.jsp", true);
    x.send();
}

function funreload(event)
{
     if(document.getElementById("cmbrentaltype").value!=""){
        if(document.getElementById("cmbagmttype").value==""){
            $.messager.alert('warning','Please Select Agreement Type');
            return false;
        }
    } 
     if(document.getElementById("cmbagmtstatus").value!=""){
         if(document.getElementById("cmbagmttype").value==""){
             $.messager.alert('warning','Please Select Agreement Type');
             return false;
         }
     }
    
     var fromdate=$('#fromdate').jqxDateTimeInput('val');
     var todate=$('#todate').jqxDateTimeInput('val');
     var repstatus=document.getElementById("cmbreplacestatus").value;
     var repreason=document.getElementById("cmbreplacereason").value;
     var reptype=document.getElementById("cmbreplacetype").value;
     var agmttype=document.getElementById("cmbagmttype").value;
     var agmtbranch=document.getElementById("cmbagmtbranch").value;
     var agmtno=document.getElementById("agmtno").value;
     var rentaltype=document.getElementById("cmbrentaltype").value;
     var agmtstatus=document.getElementById("cmbagmtstatus").value;
     
    $("#overlay, #PleaseWait").show();
    $("#replacediv").load("replaceGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&repstatus="+repstatus+"&repreason="+repreason+"&reptype="+reptype+"&agmttype="+agmttype+"&agmtbranch="+agmtbranch+"&agmtno="+agmtno+"&rentaltype="+rentaltype+"&agmtstatus="+agmtstatus+"&id=1");
}

function setValues(){
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
}
    
function funExportBtn(){
    $("#replaceGrid").excelexportjs({
        containerid: "replaceGrid",
        datatype: 'json',
        dataset: null,
        gridId: "replaceGrid",
        columns: getColumns("replaceGrid"),
        worksheetName: "Replacement List"
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

function funPrintData(){
    var rows=$('#replaceGrid').jqxGrid('getrows');
    if(rows.length==0){
        $.messager.alert('warning','Please Select any valid documents');
        return false;
    }
    else{
        var fromdate=$('#fromdate').jqxDateTimeInput('val');
        var todate=$('#todate').jqxDateTimeInput('val');
        var repstatus=document.getElementById("cmbreplacestatus").value;
        var repreason=document.getElementById("cmbreplacereason").value;
        var reptype=document.getElementById("cmbreplacetype").value;
        var agmttype=document.getElementById("cmbagmttype").value;
        var agmtbranch=document.getElementById("cmbagmtbranch").value;
        var agmtno=document.getElementById("agmtno").value;
        var rentaltype=document.getElementById("cmbrentaltype").value;
        var agmtstatus=document.getElementById("cmbagmtstatus").value;
        
        var url=document.URL;
        var reurl=url.split("replacelist.jsp");
        var win= window.open(reurl[0]+"repListPrintAction?fromdate="+fromdate+"&todate="+todate+"&repstatus="+repstatus+"&repreason="+repreason+"&reptype="+reptype+"&agmttype="+agmttype+"&agmtbranch="+agmtbranch+"&agmtno="+agmtno+"&rentaltype="+rentaltype+"&agmtstatus="+agmtstatus,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
        win.focus();
    }
}
</script>
    
</head>
<body onload="setValues();">

<form id="frmReplaceList" method="post">

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
                        <td class="label-cell">Replace Status</td>
                        <td>
                            <select id="cmbreplacestatus" name="cmbreplacestatus">
                                <option value="">--Select--</option>
                                <option value="0">Open</option>
                                <option value="1">Closed</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Replace Reason</td>
                        <td>
                            <select id="cmbreplacereason" name="cmbreplacereason">
                                <option value="">--Select--</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Replace Type</td>
                        <td>
                            <select id="cmbreplacetype" name="cmbreplacetype">
                                <option value="">--Select--</option>
                                <option value="atbranch">At Branch</option>
                                <option value="collection">Collection</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Agmt Type</td>
                        <td>
                            <select name="cmbagmttype" id="cmbagmttype">
                                <option value="">--Select--</option>
                                <option value="RAG">Rental</option>
                                <option value="LAG">Lease</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Agmt Branch</td>
                        <td>
                            <select name="cmbagmtbranch" id="cmbagmtbranch">
                                <option value="">--Select--</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Agmt No</td>
                        <td>
                            <input type="text" name="agmtno" id="agmtno" 
                                   placeholder="Press F3 to Search" readonly 
                                   onkeydown="getAgmtno(event);">
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Rental Type</td>
                        <td>
                            <select name="cmbrentaltype" id="cmbrentaltype">
                                <option value="">--Select--</option>
                                <option value="daily">Daily</option>
                                <option value="weekly">Weekly</option>
                                <option value="monthly">Monthly</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Agmt Status</td>
                        <td>
                            <select name="cmbagmtstatus" id="cmbagmtstatus">
                                <option value="">--Select--</option>
                                <option value="0">Open</option>
                                <option value="1">Close</option>
                            </select>
                        </td>
                    </tr>
                </table>
            </div>

            <!-- BUTTONS -->
            <div class="button-group">
                <button type="button" class="btn-submit" onclick="funClearData();">Clear</button>
                <button type="button" class="btn-submit" onclick="funPrintData();">Print</button>
            </div>

        </div>
    </div>
</td>

<!-- ================= RIGHT SIDE (GRIDS) ================= -->
<td valign="top">
    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            
            <div id="replacediv">
                <jsp:include page="replaceGrid.jsp"></jsp:include>
            </div>
            
            <!-- Hidden Fields -->
            <div style="display:none;">
                <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                <input type="hidden" name="printdocno" id="printdocno" value='<s:property value="printdocno"/>'>
            </div>
            
        </div>
    </div>
</td>

</tr>
</table>

</div>
</div>

<!-- POPUPS -->
<div id="clientsearchwindow"><div></div></div>
<div id="agmtnowindow"><div></div></div>

</form>
</body>
</html>