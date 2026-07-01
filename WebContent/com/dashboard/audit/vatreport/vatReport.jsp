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
}

/* Readonly / disabled look */
input[readonly],
input:disabled,
.filter-table input[readonly],
.filter-table input:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed;
}

/* jqx date/time containers */
div[id^="fromdate"], div[id^="todate"] {
    width: 100%;
}

/* ===== BUTTONS ===== */
.btn-submit {
    width: 100%;
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
    transition: background 0.2s;
}

.btn-submit:hover {
    background: #1d4ed8;
}

.btn-submit:disabled {
    background: #9ca3af;
    cursor: not-allowed;
}

.action-buttons {
    display: flex;
    flex-direction: column;
    gap: 10px;
    margin-top: 15px;
}

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
    display: flex;
    flex-direction: column;
    gap: 15px;
}

/* Custom styles for this page */
fieldset {
    border: 1px solid #e1e8ed;
    border-radius: 8px;
    padding: 15px;
    margin: 0;
    background-color: #fcfcfd;
}

legend {
    font-size: 13px;
    font-weight: bold;
    color: #2563eb;
    padding: 0 8px;
}

.totals-bar {
    margin-top: auto; /* Pushes totals to the bottom of the container */
    background: #f8fafc;
    border: 1px solid #e1e8ed;
    border-radius: 8px;
    padding: 15px;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
    
    // Updated jqx inputs to 100% width & 24px height
    $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    $("#todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    
    var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
    $('#nettotal,#totalinput,#totaloutput').val("0");
    
});

function funreload(event)
{
    var fromdate=$('#fromdate').jqxDateTimeInput('val');
    var todate=$('#todate').jqxDateTimeInput('val');
    var brch=document.getElementById("cmbbranch").value;
    $("#overlay, #PleaseWait").show();
    $('#nettotal,#totalinput,#totaloutput').val("0");
    var nettotal=parseFloat($('#nettotal').val());
    funRoundAmt(nettotal,"nettotal");
    $("#vatoutputdiv").load("vatOutputGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&branch="+brch+"&id=1");
    $("#vatinputdiv").load("vatInputGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&branch="+brch+"&id=1");
}

function setValues(){
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
}
    
function funExportBtn(){
    $("#vatInputGrid").excelexportjs({
                containerid: "vatInputGrid",   
                datatype: 'json',
                dataset: null,
                gridId: "vatInputGrid",
                columns: getColumns("vatInputGrid") ,   
                worksheetName:"VAT Input"  
            }); 
    $("#vatOutputGrid").excelexportjs({
                containerid: "vatOutputGrid",   
                datatype: 'json',
                dataset: null,
                gridId: "vatOutputGrid",
                columns: getColumns("vatOutputGrid") ,   
                worksheetName:"VAT Output"  
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
    $('#nettotal,#totalinput,#totaloutput').val("0");
}
    
</script>
</head>
<body onload="setValues();getBranch();">
<form id="frmReplaceList" method="post">
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
                    </table>
                </div>

                <div class="action-buttons">
                    <input type="button" name="btnclear" id="btnclear" value="Clear" class="btn-submit" onclick="funClearData();">
                    <input type="button" name="btnrepprint" id="btnrepprint" value="Print" class="btn-submit" onclick="funPrintData();">
                </div>
            </div>
        </div>

        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <fieldset>
                    <legend>Output Tax</legend>
                    <div id="vatoutputdiv">
                        <jsp:include page="vatOutputGrid.jsp"></jsp:include>
                    </div>
                </fieldset>

                <fieldset>
                    <legend>Input Tax</legend>
                    <div id="vatinputdiv">
                        <jsp:include page="vatInputGrid.jsp"></jsp:include>
                    </div>
                </fieldset>

                <input type="hidden" name="totalinput" id="totalinput" value='<s:property value="totalinput"/>'>
                <input type="hidden" name="totaloutput" id="totaloutput" value='<s:property value="totaloutput"/>'>
                <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                <input type="hidden" name="printdocno" id="printdocno" value='<s:property value="printdocno"/>'>

                <div class="totals-bar">
                    <table width="100%">
                        <tr>
                            <td align="right" style="font-size: 13px; font-weight: bold; color: black;">Net Total :&nbsp;</td>
                            <td width="180px">
                                <input type="text" name="nettotal" id="nettotal" readonly 
                                       style="text-align: right; font-weight: bold; color: black; font-size: 14px;" 
                                       value='<s:property value="nettotal"/>' 
                                       onKeyPress="javascript:return isNumber (event,id)" 
                                       onBlur="funRoundAmt(value,id);">
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

        </div>

    </div>

    <div id="clientsearchwindow">
        <div></div>
    </div>
    <div id="agmtnowindow">
        <div></div>
    </div>

</div>
</form>
</body>
</html>