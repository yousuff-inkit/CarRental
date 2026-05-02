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
    
    $("#btnExcel").click(function() {
        $("#inspListGrid").jqxGrid('exportdata', 'xls', 'sold Vehicles List');
    });
    
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
    
    $('#docwindow').jqxWindow({ width: '70%', height: '60%',  maxHeight: '70%' ,maxWidth: '60%' , title: 'Document Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#docwindow').jqxWindow('close');
    
    $('#clientwindow').jqxWindow({ width: '70%', height: '60%',  maxHeight: '70%' ,maxWidth: '60%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#clientwindow').jqxWindow('close');
     
    // Standardized height to 24px and width to 100%
    $("#fromdate, #todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    
    var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
    
    $('#refvocno').dblclick(function(){
        var reftype=document.getElementById("cmbreftype").value;
        if(document.getElementById("cmbreftype").value==''){
             $.messager.alert('warning','Ref Doc Type is Mandatory');
             return false;
         }
        if(document.getElementById("cmbreftype").value=="RAG" || document.getElementById("cmbreftype").value=="LAG"){
            if(document.getElementById("cmbagmtbranch").value==""){
                $.messager.alert('warning','Agreement Branch is Mandatory');
                return false;
            }
        }
        $('#docwindow').jqxWindow('open');
        docSearchContent('detailDocSearch.jsp?reftype='+reftype+'&branch='+$('#cmbagmtbranch').val(), $('#docwindow'));
    });

    $('#client').dblclick(function(){
        $('#clientwindow').jqxWindow('open');
        clientSearchContent('clientMasterSearch.jsp');
    });

    getAgmtBranch();
});

function docSearchContent(url) {
    $.get(url).done(function (data) {
        $('#docwindow').jqxWindow('setContent', data);
    }); 
}

function clientSearchContent(url) {
    $.get(url).done(function (data) {
        $('#clientwindow').jqxWindow('setContent', data);
    }); 
}

function funreload(event)
{
    var branch=document.getElementById("cmbbranch").value;
    var client=document.getElementById("hidclient").value;
    var fromdate=$('#fromdate').jqxDateTimeInput('val');
    var reftype=$('#cmbreftype').val();
    var agmtbranch=$('#cmbagmtbranch').val();
    var refdocno=$('#refdocno').val();
    var type=$('#cmbtype').val();
    var invoicetype=$('#cmbinvtype').val();
    var todate=$('#todate').jqxDateTimeInput('val');
    
    $("#overlay, #PleaseWait").show();
    $("#inspdiv").load("inspListGrid.jsp?branch="+branch+"&client="+client+"&fromdate="+fromdate+"&todate="+todate+"&reftype="+reftype+"&agmtbranch="+agmtbranch+"&refdocno="+refdocno+"&type="+type+"&invoicetype="+invoicetype+"&id=1");
}
    
function getAgmtBranch(){
   var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('***');
            var locItems = items[0].split(",");
            var locIdItems = items[1].split(",");
            var optionsloc = '<option value="">--Select--</option>';
            for (var i = 0; i < locItems.length; i++) {
                optionsloc += '<option value="' + locIdItems[i] + '">' + locItems[i] + '</option>';
            }
            $("select#cmbagmtbranch").html(optionsloc);
            
        }
    }
    x.open("GET", "getBranch.jsp", true);
    x.send();
}

function setValues(){
     if($('#msg').val()!=""){
       $.messager.alert('Message',$('#msg').val());
      }
}

function funExportBtn(){
     if(parseInt(window.parent.chkexportdata.value)=="1") {
         JSONToCSVCon(insplistdata, 'Inspection List', true);
       }
}
    
function funClearData(){
    $('input[type=text],[type=hidden]').val('');
    $('#fromdate').jqxDateTimeInput('setDate',new Date());
    $('#todate').jqxDateTimeInput('setDate',new Date());
    
    var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
}

function getDoc(event){
    var reftype=document.getElementById("cmbreftype").value;
    if(document.getElementById("cmbreftype").value==''){
         $.messager.alert('warning','Ref Doc Type is Mandatory');
         return false;
     }
    if(document.getElementById("cmbreftype").value=="RAG" || document.getElementById("cmbreftype").value=="LAG"){
        if(document.getElementById("cmbagmtbranch").value==""){
            $.messager.alert('warning','Agreement Branch is Mandatory');
            return false;
        }
    }
    var x= event.keyCode;
    if(x==114){
        $('#docwindow').jqxWindow('open');
        docSearchContent('detailDocSearch.jsp?reftype='+reftype+'&branch='+$('#cmbagmtbranch').val(), $('#docwindow'));
    }
}
</script>
</head>

<body onload="setValues();getBranch();">

<form id="frmSoldList" method="post">

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
                        <td class="label-cell">Ref Type</td>
                        <td>
                            <select id="cmbreftype" name="cmbreftype">
                                <option value="">--Select--</option>
                                <option value="RAG">Rental</option>
                                <option value="LAG">Lease</option>
                                <option value="RPL">Replacement</option>
                                <option value="NRM">Non Revenue Movement</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Agmt Branch</td>
                        <td>
                            <select id="cmbagmtbranch" name="cmbagmtbranch">
                                <option value="">--Select--</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Ref Doc</td>
                        <td>
                            <input type="text" id="refvocno" name="refvocno" 
                                   readonly placeholder="Press F3 to Search" 
                                   onkeydown="getDoc(event);">
                            <input type="hidden" id="refdocno" name="refdocno">
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Client</td>
                        <td>
                            <input type="text" id="client" name="client" 
                                   readonly placeholder="Press F3 to Search">
                            <input type="hidden" id="hidclient" name="hidclient">
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Type</td>
                        <td>
                            <select id="cmbtype" name="cmbtype">
                                <option value="">--Select--</option>
                                <option value="DMG">Damage</option>
                                <option value="ACC">Accident</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Invoice Type</td>
                        <td>
                            <select id="cmbinvtype" name="cmbinvtype">
                                <option value="">--Select--</option>
                                <option value="1">Invoiced</option>
                                <option value="0">Not Invoiced</option>
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
            
            <div id="inspdiv">
                <jsp:include page="inspListGrid.jsp"></jsp:include>
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
<div id="clientwindow"><div></div></div>
<div id="docwindow"><div></div></div>

</div>

</form>
</body>
</html>