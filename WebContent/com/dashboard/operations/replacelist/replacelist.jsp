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

table, tr, td, th, tbody {
    background-color: #ffffff !important;
    background: #ffffff !important;
}

/* Forcefully kill all hover states on tables applied by external CSS */
table tr:hover, 
table td:hover, 
table th:hover, 
tbody tr:hover, 
.master-layout-table tr:hover, 
.master-layout-table td:hover {
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
    border-right: 1px solid #e1e8ed;
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
}

.filter-table .label-cell {
    text-align: right;
    padding-right: 12px;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    width: 100px;
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

/* Readonly / disabled look */
input[readonly],
input:disabled,
.filter-table input[readonly],
.filter-table input:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    cursor: not-allowed;
}

/* jqx date/time containers */
.filter-table div[id^="fromdate"],
.filter-table div[id^="todate"] {
    width: 100%;
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
}

.btn-submit:hover {
    background: #1d4ed8 !important;
}

.btn-submit:disabled {
    background: #9ca3af !important;
    cursor: not-allowed;
}

/* Action buttons layout */
.filter-actions {
    display: flex;
    gap: 10px;
    justify-content: center;
    margin-top: 15px; 
}
</style>

<script type="text/javascript">
$(document).ready(function () {
    // Populate the heading.jsp branch dropdown on load
    getBrch();

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
                // Target the specific ID present inside heading.jsp
                $("select#cmbbranch").html(optionsbrch);
            }
        }
    }
    x.open("GET", "getBranch.jsp", true);
    x.send();
}

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

            <div class="filter-actions">
                <button type="button" class="btn-submit" onclick="funClearData();">Clear</button>
                <button type="button" class="btn-submit" onclick="funPrintData();">Print</button>
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
                 <div id="replacediv">
                     <jsp:include page="replaceGrid.jsp"></jsp:include>
                 </div>
             </td>
             <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
             <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
             <input type="hidden" name="printdocno" id="printdocno" value='<s:property value="printdocno"/>'>
        </tr>
    </table>

</td>

</tr>
</table>

</div>

<div id="clientsearchwindow"><div></div></div>
<div id="agmtnowindow"><div></div></div>

</form>
</body>
</html>