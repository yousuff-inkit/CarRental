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
<script type="text/javascript">

$(document).ready(function () {
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
	$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	document.getElementById("imgloading").style.display="none";
	var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	var onemonthbefore=new Date(new Date(fromdate).setMonth(fromdate.getMonth()-1)); 
    $('#fromdate').jqxDateTimeInput('setDate', new Date(onemonthbefore));
});

function funreload(event)
{
	var fromdate=$('#fromdate').jqxDateTimeInput('val');
	var todate=$('#todate').jqxDateTimeInput('val');
	$('#overlay,#PleaseWait').show();
	$('#summarydiv').load('summaryGrid.jsp?check=1&fromdate='+fromdate+'&todate='+todate);
}
function funCalculate(){

}
	

function funNotify(){
	
}
function setValues(){

}
function funExportBtn(){

	/* if(parseInt(window.parent.chkexportdata.value)=="1")
	{
		JSONToCSVCon(invoicedata, 'Rental Invoice', true);
	}
	else
	{
		$("#rentalInvoiceGrid").jqxGrid('exportdata', 'xls', 'Rental Invoice');
	} */

}
	
</script>
</head>
<style type="text/css">
    /* Layout & Sidebar Structure */
    .master-container {
        display: flex;
        font-family: 'Segoe UI', Tahoma, sans-serif !important;
        background-color: #f4f7f9;
        width: 100%;
        height: 100vh !important;
        overflow: hidden !important;
        color: black !important;
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

    /* Cleaned Card Styling */
    .filter-card {
        background-color: #f8fafc !important;
        border: 1px solid #e3e8ee !important;
        border-radius: 12px !important;
        padding: 15px;
        margin-bottom: 10px;
    }

    /* Reset legacy styles and force black text */
    .filter-card *, fieldset, legend, .branch, td, tr, label, span {
        background-color: transparent !important;
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
        width: 85px;
    }

    /* RHS Grid Area & Scroll Fix */
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
        padding: 20px;
    }

    /* Loading Overlay */
    #imgdiv {
        position: absolute;
        z-index: 100;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
    }

    .branch { font-size: 13px; font-weight: 600; }
</style>
<body onload="getBranch();setValues();">
	<form id="frmVehicleStatusSummary" action="saveVehicleStatusSummary" method="post">
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
            
            <div style="height: 300px;"></div>
        </div>
    </div>

    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="imgdiv">
                <img id="imgloading" alt="Loading..." src="../../../../icons/31load.gif"/>
            </div>

            <div id="summarydiv">
                <jsp:include page="summaryGrid.jsp"></jsp:include>
            </div>
            
            <div id="detailsdiv" style="margin-top:20px;">
                <jsp:include page="detailsGrid.jsp"></jsp:include>
            </div>
            
            <input type="hidden" name="gridlength" id="gridlength" >
            <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
            <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
        </div>
    </div>
</div>
			</div>
		</div>
	</form>
</body>
</html>