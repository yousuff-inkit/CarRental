<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />
<style>

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
</style>  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
/* 	 $("#jqxDateOut").jqxDateTimeInput({ width: '110px', height: '15px', formatString:"dd.MM.yyyy"});
	 $("#jqxDaterentalout").jqxDateTimeInput({ width: '110px', height: '15px', formatString:"dd.MM.yyyy"}); */
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
	
	   $('#clientwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#clientwindow').jqxWindow('close');
	   $('#agmtwindow').jqxWindow({ width: '60%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#agmtwindow').jqxWindow('close');
	   $('#fleetwindow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Fleet Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#fleetwindow').jqxWindow('close');
	   $('#clientcatwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Model Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#clientcatwindow').jqxWindow('close');
		$('#agmtno').dblclick(function(){
	  		$('#agmtwindow').jqxWindow('open');
	    	agmtSearchContent('agmtMasterSearch.jsp', $('#agmtwindow')); 
      	});
      	$('#clientcat').dblclick(function(){
	  		$('#clientcatwindow').jqxWindow('open');
	  		$("#overlay, #PleaseWait").show();
	    	clientCatSearchContent('clientCatSearchGrid.jsp?id=1', $('#clientcatwindow')); 
      	});
	   	$('#clientname').dblclick(function(){
	  		$('#clientwindow').jqxWindow('open');
	       	clientSearchContent('clientsearch.jsp?', $('#clientwindow')); 
      	});
	    $('#fleet').dblclick(function(){
	  	    $('#fleetwindow').jqxWindow('open');
		    fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow')); 
       	});
	 	$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 	$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 	var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 	var onemonth=new Date(new Date(fromdate).setMonth(fromdate.getMonth()-1)); 
     	$('#fromdate').jqxDateTimeInput('setDate', new Date(onemonth));
	 	$('#todate').on('change', function (event) {
			var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 	var todate=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		   	if(fromdates>todates){
				$.messager.alert('Message','To Date Less Than From Date  ','warning');   
			   	return false;
		  	}   
	 	});
}); 
function getAgmtno(event){
	var x= event.keyCode;
	if(x==114){
		$('#agmtwindow').jqxWindow('open');
	    agmtSearchContent('agmtMasterSearch.jsp', $('#agmtwindow'));
	}
	else{
	}
} 
function getClientCat(event){
	var x= event.keyCode;
	if(x==114){
		$('#clientcatwindow').jqxWindow('open');
		$("#overlay, #PleaseWait").show();
	    clientCatSearchContent('clientCatSearchGrid.jsp?id=1', $('#clientcatwindow')); 
	}
	else{
	}
}
function agmtSearchContent(url) {
	$.get(url).done(function (data) {
		$('#agmtwindow').jqxWindow('open');
		$('#agmtwindow').jqxWindow('setContent', data);
	}); 
} 
function clientCatSearchContent(url) {
	$.get(url).done(function (data) {
		$('#clientcatwindow').jqxWindow('open');
		$('#clientcatwindow').jqxWindow('setContent', data);
	}); 
}

function getfleet(event){
	var x= event.keyCode;
	if(x==114){
		$('#fleetwindow').jqxWindow('open');
	 	fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow'));    }
	else{
	}
} 
function fleetSearchContent(url) {
	$.get(url).done(function (data) {
		$('#fleetwindow').jqxWindow('open');
		$('#fleetwindow').jqxWindow('setContent', data);
	}); 
} 
function getclinfo(event){
	var x= event.keyCode;
	if(x==114){
		$('#clientwindow').jqxWindow('open');
		clientSearchContent('clientsearch.jsp?', $('#clientwindow'));    }
	else{
	}
} 
function clientSearchContent(url) {
	$.get(url).done(function (data) {
 		$('#clientwindow').jqxWindow('open');
 		$('#clientwindow').jqxWindow('setContent', data);
 	}); 
} 
function funreload(event){
	var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	var todate=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	var agmtno=$('#hidagmtno').val();
	var clientcat=$('#hidclientcat').val();
	var cldocno=$('#cldocno').val();
/*	if(agmtno=="" || clientcat=="" || cldocno==""){
		$.messager.alert('Warning','Please select a filter');
		return false;
 	}  */
	if(fromdate>todate){
		$.messager.alert('Message','To Date Less Than From Date  ','warning');   
	   	return false;
	} 
	else{
		var branch = document.getElementById("cmbbranch").value;
     	var fromdate= $("#fromdate").val();
	 	var todate= $("#todate").val(); 
	 	
	  	$("#detlist").load("detailsGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&cldocno="+document.getElementById("cldocno").value+"&fleet="+document.getElementById("fleet").value+"&status="+document.getElementById("status").value+"&type="+$("#rentaltype").val()+"&clientcat="+clientcat+"&agmtno="+agmtno+"&id=1");
	}
	disiem(); 
}
function  funcleardata()
{
	document.getElementById("cldocno").value="";
	document.getElementById("fleet").value="";
	document.getElementById("clientname").value="";
	//document.getElementById("rentaltype").value="Daily";
	document.getElementById("status").value="0";
	/* 
	$('#jqxDateOut').val(new Date());
	$('#jqxDaterentalout').val(new Date()); */
	$('#agmtno,#hidagmtno,#clientcat,#hidclientcat').val('');
	document.getElementById("docnos").value="";
 	document.getElementById("excessinsur").value="";
	document.getElementById("normalinsu").value="";
	document.getElementById("cdwinsu").value="";
	document.getElementById("supercdwinsu").value=""; 
	
	document.getElementById("gridlength").value="";
	document.getElementById("branchid").value="";
	
	if (document.getElementById("clientname").value == "") {
		$('#clientname').attr('placeholder', 'Press F3 TO Search'); 
	}
	if (document.getElementById("fleet").value == "") {
		$('#fleet').attr('placeholder', 'Press F3 TO Search'); 
	}
}
	
function funExportBtn(){
	if(parseInt(window.parent.chkexportdata.value)=="1"){
		JSONToCSVCon(shotterm, 'RAG-Payment', true);
	}
	else{
	    $("#detailsgrid").jqxGrid('exportdata', 'xls', 'RAG-Payment');
	}
}
	
function disiem()
{
	// $("#jqxgridpayment").jqxGrid({ disabled: true});

	$('#jqxgridpayment').jqxGrid('setcellvalue',0, "mode","");
	$('#jqxgridpayment').jqxGrid('setcellvalue',0, "amount","");
	$('#jqxgridpayment').jqxGrid('setcellvalue', 0, "acode","");
	$('#jqxgridpayment').jqxGrid('setcellvalue', 0, "cardno","");
	$('#jqxgridpayment').jqxGrid('setcellvalue', 0, "expdate","");
	$('#jqxgridpayment').jqxGrid('setcellvalue', 0, "hidexpdate","");
	$('#jqxgridpayment').jqxGrid('setcellvalue',0, "card","");
	$('#jqxgridpayment').jqxGrid('setcellvalue',0, "cardtype","");
	$('#jqxgridpayment').jqxGrid('setcellvalue',0, "paytype","");
	$('#jqxgridpayment').jqxGrid('setcellvalue',0, "rano","");
	$('#jqxgridpayment').jqxGrid('setcellvalue',0, "odate","");
	$('#jqxgridpayment').jqxGrid('setcellvalue',0, "brhid","");
	$('#jqxgridpayment').jqxGrid('setcellvalue',0, "vocno","");
	
}
</script>
</head>
<body onload="getBranch();disiem()">

<div id="mainBG" class="homeContent">
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<td width="20%">
<div class="master-container">
<div class="sidebar-filters">

    <div class="sidebar-fixed-top">
        <div class="filter-card">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>
    </div>

    <div class="sidebar-scroll-content">

        <div class="filter-card">
            <table class="insurance-filter-table">
                <tr>
                    <td class="label-cell">From</td>
                    <td><div id="fromdate"></div></td>
                </tr>

                <tr>
                    <td class="label-cell">To</td>
                    <td><div id="todate"></div></td>
                </tr>

                <tr>
                    <td class="label-cell">Status</td>
                    <td>
                        <select id="status" name="status">
                            <option value="0">Open</option>
                            <option value="1">Close</option>
                            <option value="">All</option>
                        </select>
                    </td>
                </tr>
            </table>
        </div>

        <div class="filter-card">
            <table class="insurance-filter-table">

                <tr>
                    <td class="label-cell">Client</td>
                    <td>
                        <input type="text" id="clientname" name="clientname"
                               placeholder="Press F3 To Search"
                               readonly onkeydown="getclinfo(event);">
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Fleet</td>
                    <td>
                        <input type="text" id="fleet" name="fleet"
                               placeholder="Press F3 To Search"
                               readonly onkeydown="getfleet(event);">
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Agreement</td>
                    <td>
                        <input type="text" id="agmtno" name="agmtno"
                               placeholder="Press F3 To Search"
                               readonly onkeydown="getAgmtno(event);">
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Client Category</td>
                    <td>
                        <input type="text" id="clientcat" name="clientcat"
                               placeholder="Press F3 To Search"
                               readonly onkeydown="getClientCat(event);">
                    </td>
                </tr>

            </table>

            <div class="insurance-actions">
                <button type="button"
                        class="btn-submit"
                        onclick="funcleardata();">
                    Clear
                </button>
            </div>
        </div>

     
        <div class="filter-card">
            <div id="paychaaaaa"></div>
        </div>

        <input type="hidden" id="hidagmtno" name="hidagmtno">
        <input type="hidden" id="hidclientcat" name="hidclientcat">
        <input type="hidden" id="cldocno" name="cldocno">
        <input type="hidden" id="groupdoc" name="groupdoc">
        <input type="hidden" id="brandid" name="brandid">
        <input type="hidden" id="modelid" name="modelid">
        <input type="hidden" id="docnos" name="docnos">
        <input type="hidden" id="excessinsur" name="excessinsur">
        <input type="hidden" id="normalinsu" name="normalinsu">
        <input type="hidden" id="cdwinsu" name="cdwinsu">
        <input type="hidden" id="supercdwinsu" name="supercdwinsu">
        <input type="hidden" id="gridlength" name="gridlength">
        <input type="hidden" id="branchid" name="branchid">

    </div>
</div>

<td width="80%">
    <div id="detlist">
        <jsp:include page="detailsGrid.jsp"></jsp:include>
    </div>

    <div style="height:10px;"></div>

    <div id="rtariff">
        <jsp:include page="paymentgrid.jsp"></jsp:include>
    </div>
</td>

</tr>
</table>

</div>

<div id="clientwindow"><div></div></div>
<div id="fleetwindow"><div></div></div>
<div id="agmtwindow"><div></div></div>
<div id="clientcatwindow"><div></div></div>
<div id="usersearchwindow"><div></div></div>

</div>
</body>
</html>
	 