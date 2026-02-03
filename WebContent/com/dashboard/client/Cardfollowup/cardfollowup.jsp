
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
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	$("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$('#clientcatwindow').jqxWindow({ width: '25%', height: '55%',  maxHeight: '85%' ,maxWidth: '40%' , title: 'Client Category Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#clientcatwindow').jqxWindow('close');	
    $('#clientcat').dblclick(function(){
		$('#clientcatwindow').jqxWindow('open');
		$('#clientcatwindow').jqxWindow('focus');
		clientCatSearchContent('clientCatSearchGrid.jsp?id=1', $('#clientcatwindow'));
	});
    $('#btnclear').click(function(){
    	$('#uptodate').jqxDateTimeInput('setDate',new Date());
    	$('#clientcat,#hidclientcat,#rentalstatus').val('');
    	$('#rentaltype').val('RAG');
    	$('#followup').jqxGrid('clear');
    }); 
   
});
function getClientCat(event){
	 var x= event.keyCode;
    if(x==114){
    	$('#clientcatwindow').jqxWindow('open');
		$('#clientcatwindow').jqxWindow('focus');
		clientCatSearchContent('clientCatSearchGrid.jsp?id=1', $('#clientcatwindow'));
    }
    else{
     }
}
function clientCatSearchContent(url) {
	$.get(url).done(function (data) {
	    $('#clientcatwindow').jqxWindow('setContent', data);
	}); 
}
function funreload(event)
{
	 var barchval = document.getElementById("cmbbranch").value;
	 var rentaltype=document.getElementById("rentaltype").value;
	 var rentalstatus=document.getElementById("rentalstatus").value;
	 var uptodate=$('#uptodate').jqxDateTimeInput('val');
	 var clientcat=$('#hidclientcat').val();
	   $("#overlay, #PleaseWait").show();
	  $("#cradfwdiv").load("cardfollowupGrid.jsp?barchval="+barchval+'&uptodate='+uptodate+'&type='+rentaltype+'&check=1&rentalstatus='+rentalstatus+'&clientcat='+clientcat);
	
	
	}

	function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	JSONToCSVCon(exceldata, 'Card Block Followup', true);
		 } else {
			 $("#followup").jqxGrid('exportdata', 'xls', 'Card Block Followup');
		 }
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
        width: 350px; 
        flex: 0 0 350px;
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
        margin-bottom: 12px;
    }

    /* Reset legacy styles and force black text */
    .filter-card *, fieldset, legend, .branch, td, tr, label, span {
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
        width: 100px;
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

    /* RHS Grid Area & Scroll Fix */
    .main-content-wrapper {
        flex: 1;
        display: flex;
        flex-direction: column;
        height: 100vh;
        width: 100%;
        max-width: calc(100vw - 350px);
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

    /* FINALIZED BUTTONS (#2563eb) */
    .myButton {
        background-color: #2563eb !important;
        color: #ffffff !important; 
        border: none !important;
        border-radius: 6px;
        cursor: pointer;
        font-size: 13px;
        font-weight: 600;
        padding: 10px 15px;
        text-align: center;
        display: block;
        width: 100%;
        margin-top: 5px;
        transition: background 0.2s;
    }

    .myButton:hover { 
        background-color: #1d4ed8 !important; 
    }

    .branch { font-size: 13px; font-weight: 600; }
</style>
<body onload="getBranch();">
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
                        <td class="label-cell">Upto Date</td>
                        <td><div id="uptodate" name="uptodate"></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Client Category</td>
                        <td>
                            <input type="text" readonly id="clientcat" name="clientcat" value='<s:property value="clientcat"/>' onkeydown="getClientCat(event);" placeholder="Press F3 to Search">
                            <input type="hidden" readonly id="hidclientcat" name="hidclientcat" value='<s:property value="hidclientcat"/>' >
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Rental Type</td>
                        <td>
                            <select id="rentaltype" name="rentaltype" value='<s:property value="rentaltype"/>'>
                                <option value="RAG">Rental</option>
                                <option value="LAG">Lease</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Rental Status</td>
                        <td>
                            <select id="rentalstatus" name="rentalstatus" value='<s:property value="rentalstatus"/>'>
                                <option value="">All</option>
                                <option value="0">Opened</option>
                                <option value="1">Closed</option>
                            </select>
                        </td>
                    </tr>
                </table>
                
                <hr style="border: 0; border-top: 1px solid #e1e8ed; margin: 15px 0;">
                
                <div style="text-align: center;">
                    <button type="button" id="btnclear" name="btnclear" class="myButton">Clear</button>
                </div>
            </div>

            <div id='pieChart1' style="width: 100%; height: 170px; margin-top: 10px;"></div>
        </div>
    </div>

    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="cradfwdiv">
                <jsp:include page="cardfollowupGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>
</div>
</div>
<div id="clientcatwindow">
<div></div>
</div>
</div>
</body>
</html>