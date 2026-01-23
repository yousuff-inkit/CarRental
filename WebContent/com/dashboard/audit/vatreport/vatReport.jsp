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
    /* Layout & Sidebar Structure */
    .master-container {
        display: flex;
        font-family: 'Segoe UI', Tahoma, sans-serif !important;
        background-color: #f4f7f9;
        width: 100%;
        height: 100vh !important;
        overflow: hidden !important;
        color: black !important; /* Force all font black */
    }

    .sidebar-filters {
        width: 330px; 
        flex: 0 0 330px;
        background-color: #ffffff;
        border-right: 1px solid #e1e8ed;
        display: flex;
        flex-direction: column;
        z-index: 10;
        box-shadow: 2px 0 8px rgba(0,0,0,0.05);
        height: 100vh !important;
    }

    .sidebar-fixed-top {
        padding: 20px 20px 15px 20px;
        background-color: #ffffff;
        border-bottom: 1px solid #f0f4f8;
        flex-shrink: 0;
    }

    .sidebar-scroll-content {
        flex: 1;
        overflow-y: auto;
        padding: 15px 20px 25px 20px;
    }

    /* Cleaned Cards - Stripping legacy backgrounds */
    .filter-card {
        background-color: #f8fafc !important;
        border: 1px solid #e3e8ee !important;
        border-radius: 12px !important;
        padding: 15px;
        margin-bottom: 10px;
    }

    /* HARD RESET: Force black fonts and remove unwanted green backgrounds */
    .filter-card *, 
    fieldset, 
    legend, 
    .branch, 
    td, 
    tr, 
    label, 
    span {
        background-color: transparent !important;
        background: none !important;
        color: black !important;
    }

    .filter-table { 
        width: 100%; 
        border-spacing: 0 10px; 
    }

    .label-cell {
        text-align: right;
        padding-right: 12px;
        font-size: 13px;
        font-weight: 600;
        width: 95px;
    }

    /* Input & Select Styling */
    input[type="text"], select {
        width: 100%;
        border: 1px solid #ccd6e0;
        border-radius: 6px;
        padding: 7px 10px;
        font-size: 13px;
        color: black !important;
        box-sizing: border-box;
        background-color: #ffffff !important;
    }

    /* RHS Visibility & Scrollbar Kill */
    .main-content-wrapper {
        flex: 1;
        display: flex;
        flex-direction: column;
        height: 100vh;
        width: 100%;
        max-width: calc(100vw - 330px);
        overflow: hidden !important; 
        position: relative;
        background-color: #ffffff;
    }

    .scrollable-grid-area {
        flex: 1;
        overflow-y: auto !important;
        overflow-x: hidden !important; 
        padding: 20px 20px 80px 20px;
    }

    /* Sticky Footer for Net Total */
    .totals-bar {
        background: #ffffff;
        border-top: 2px solid #2563eb;
        padding: 12px;
        position: absolute;
        bottom: 0;
        left: 0;
        right: 0;
        z-index: 20;
        box-shadow: 0 -2px 10px rgba(0,0,0,0.05);
    }

    /* Buttons Modernized */
    .myButtons {
        background-color: #6c7c7c;
        border: 1px solid transparent;
        border-radius: 4px;
        cursor: pointer;
        color: #ffffff !important; /* White for contrast */
        font-size: 13px;
        font-weight: 600;
        padding: 8px 15px;
        transition: background 0.2s;
        display: inline-block;
        text-align: center;
    }

    .myButtons:hover {
        background-color: #31b0d5;
    }

    .branch { font-size: 13px; font-weight: 600; }
    
    fieldset {
        border: 1px solid #ccd6e0 !important;
        margin-bottom: 20px !important;
        padding: 15px !important;
        border-radius: 8px !important;
    }
    
    legend {
        font-weight: bold;
        padding: 0 10px;
        font-size: 14px;
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