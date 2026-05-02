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
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<style type="text/css">
   
.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', Tahoma, sans-serif;
    background-color: #f4f7f9;
}

.sidebar-filters {
    width: 330px;
    flex: 0 0 330px;
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

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 20px 25px;
}

.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 13px;
    font-weight: 600;
    color: #4e5e71;
    width: 90px;
}

input[type="text"], select {
    width: 100%;
    padding: 7px 10px;
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    font-size: 13px;
}

.btn-submit {
    width: 100%;
    padding: 11px;
    margin-top: 10px;
    background: #2563eb;
    color: #fff;
    border: none;
    border-radius: 6px;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
}

.btn-submit:hover {
    background: #1d4ed8;
}

html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
}

td[width="80%"] {
    height: 100vh;
    vertical-align: top;
    background: #fff;
}
.myButtons, .myButton {
    background-color: #2563eb !important;
    color: #ffffff !important;
    border: none !important;
    border-radius: 6px;
    padding: 10px 15px;
    font-weight: 600;
    cursor: pointer;
    width: 100%;
}

.myButtons:hover, .myButton:hover {
    background-color: #1d4ed8 !important;
}
.main-content-wrapper{
    flex:1;
    width:100%;
}

.scrollable-grid-area{
    width:100%;
}

#delupdiv{
    width:100%;
}
/* 🔹 Inputs + Dropdowns */
input[type="text"],
select {
    width: 100%;
    height: 24px !important;
    padding: 0 8px !important;
    border: 1px solid #ccd6e0;
    border-radius: 4px;
    font-size: 13px;
    box-sizing: border-box;
    line-height: 24px;
}

/* 🔹 Dropdown text */
select {
    font-size: 13px !important;
}

/* 🔹 Buttons */
.btn-submit,
.myButtons,
.myButton,
input[type="button"],
button {
    width: 100%;
    height: 24px !important;
    padding: 0 10px !important;
    border-radius: 4px;
    font-size: 13px;
    font-weight: 600;
    box-sizing: border-box;
    line-height: 24px;
}

/* 🔹 Fix for any library overriding (like jqx / external CSS) */
.jqx-widget input,
.jqx-widget select {
    height: 24px !important;
    line-height: 24px !important;
}
</style>
<script type="text/javascript">

$(document).ready(function () {
	/* document.getElementById("branchlabel").style.display="none";
	document.getElementById("branchdiv").style.display="none"; */
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
 	$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
 	$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
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
	// JSONToCSVCon(vatinputexceldata, 'VAT Input Report', true);
//	JSONToCSVCon(vatoutputexceldata, 'VAT Output Report', true);

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
<div class='hidden-scrollbar'>
<div class="master-container">
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
                </table>
            </div>

            <div style="height: 100px;"></div>

            <div style="padding: 10px 5px; text-align: center; display: flex; flex-direction: column; gap: 10px;">
                <input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();">
                <input type="button" name="btnrepprint" id="btnrepprint" value="Print" class="myButtons" onclick="funPrintData();">
            </div>
        </div>
    </div>

    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
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
        </div>

        <div class="totals-bar">
            <table width="100%">
                <tr>
                    <td align="right" style="font-size: 13px; font-weight: bold; color: black;">Net Total :&nbsp;</td>
                    <td width="180px">
                        <input type="text" name="nettotal" id="nettotal" readonly 
                               style="text-align: right; font-weight: bold; color: black; border: 1px solid #ccd6e0; border-radius: 4px; height: 30px;" 
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