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
<style>
<style>
/* ===== MASTER LAYOUT ===== */
.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', Tahoma, sans-serif;
    background-color: #f4f7f9;
}

/* Sidebar */
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

.label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 13px;
    font-weight: 600;
    color: #4e5e71;
    width: 90px;
}

/* Inputs */
input[type="text"], select {
    width: 100%;
    padding: 7px 10px;
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    font-size: 13px;
}

/* Buttons */
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

/* Page height fix */
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
	changegrid();
	$("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});

	$('#fleetwindow').jqxWindow({ width: '30%', height: '65%', maxHeight: '85%' ,maxWidth: '80%' ,title: 'Fleet Search' , position: { x: 200, y: 60 }, keyboardCloseKey: 27});
	$('#fleetwindow').jqxWindow('close');
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif' /></div>");

	$('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%', maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
	$('#accountSearchwindow').jqxWindow('close');


	$('#dealnowindow').jqxWindow({ width: '30%', height: '65%', maxHeight: '85%' ,maxWidth: '80%' ,title: 'Deal No Search' , position: { x: 200, y: 60 }, keyboardCloseKey: 27});
	$('#dealnowindow').jqxWindow('close');


	$('#fleetno').dblclick(function(){
	$('#fleetwindow').jqxWindow('open');

	fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow'));
	});


	$('#dealno').dblclick(function(){
	$('#dealnowindow').jqxWindow('open');

	dealnoSearchContent('dealnoseach.jsp?', $('#dealnowindow'));
	});



	$('#txtaccid').dblclick(function(){


	$('#accountSearchwindow').jqxWindow('open');
	commenSearchContent('finaccountSearch.jsp?');

	});



	/* $("#fleetdiv").hide();
	$("#enqlistdiv").show(); */
	});




	function getdealNo(event){
	var x= event.keyCode;
	if(x==114){

	$('#dealnowindow').jqxWindow('open');

	dealnoSearchContent('dealnoseach.jsp?');
	}

	else{
	}


	}



	function dealnoSearchContent(url) {
	//alert(url);
	$.get(url).done(function (data) {

	$('#dealnowindow').jqxWindow('open');
	$('#dealnowindow').jqxWindow('setContent', data);

	});
	}


	function getAccTypeFrom(event){
	var x= event.keyCode;
	if(x==114){

	$('#accountSearchwindow').jqxWindow('open');

	commenSearchContent('finaccountSearch.jsp?');
	}

	else{
	}
	}



	function commenSearchContent(url) {
	//alert(url);
	$.get(url).done(function (data) {

	$('#accountSearchwindow').jqxWindow('open');
	$('#accountSearchwindow').jqxWindow('setContent', data);

	});
	}

	function funExportBtn(){

	var fleetno = document.getElementById("fleetno").value;
	var type = document.getElementById("type").value;



	if(type=="summary" || type=="banksummary")
	{
	$("#enqlistdiv").excelexportjs({
	containerid: "enqlistdiv",
	datatype: 'json',
	dataset: null,
	gridId: "vehicleAssetGrid",
	columns: getColumns("vehicleAssetGrid") ,
	worksheetName:"Purchase Reports Summary"
	});
	// JSONToCSVConvertor(summdata, 'Purchase Reports', true);

	}


	if(type=="fleetwise")
	{

	$("#fleetdiv").excelexportjs({
	containerid: "fleetdiv",
	datatype: 'json',
	dataset: null,
	gridId: "fleeetgrid",
	columns: getColumns("fleeetgrid") ,
	worksheetName:"Purchase Reports Summary -Fleetwise"
	});
	// JSONToCSVConvertor(fleetexceldata, 'Purchase Reports', true);

	}
	if(type=="vehwise")
	{

	$("#fdiv").excelexportjs({
	containerid: "fdiv",
	datatype: 'json',
	dataset: null,
	gridId: "vehicleFleetGrid",
	columns: getColumns("vehicleFleetGrid") ,
	worksheetName:"Purchase Reports Summary -Vehiclewise"
	});
	// JSONToCSVConvertor(fleetexceldata, 'Purchase Reports', true);

	}

	if(type=="detail" && fleetno=="")
	{
	$("#detdivs").excelexportjs({
	containerid: "detdivs",
	datatype: 'json',
	dataset: null,
	gridId: "detailgeids",
	columns: getColumns("detailgeids") ,
	worksheetName:"Purchase Reports Detail"
	});


	// JSONToCSVConvertor(detaildata, 'Purchase Reports', true);

	}
	}
	function fleetSearchContent(url) {
	//alert(url);
	$.get(url).done(function (data) {

	$('#fleetwindow').jqxWindow('open');
	$('#fleetwindow').jqxWindow('setContent', data);

	});
	}

	function getfleetdata(event){
	var x= event.keyCode;
	if(x==114){
	$('#fleetwindow').jqxWindow('open');


	fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow')); }
	else{
	}
	}


	function funreload(event){

	var uptodate = $('#uptodate').val();
	var barchval = document.getElementById("cmbbranch").value;
	var fleetno = document.getElementById("fleetno").value;
	var type = document.getElementById("type").value;
	var findoc = document.getElementById("txtdocno").value;
	var dealnos = document.getElementById("dealno").value;
	var dealno = dealnos.replace(/ /g, "%20");
	/*
	if(type=="fleetwise" && dealnos==""){
	$.messager.alert('Warning','Please select Deal No');
	return false;
	} */
	if((type=="summary" || type=="banksummary") && fleetno=="") {
	var aa="chk";
	$("#overlay, #PleaseWait").show();
	$("#enqlistdiv").load("Gridfirst.jsp?barchval="+barchval+"&type="+type+"&val="+aa+"&findoc="+findoc+"&dealno="+dealno+'&uptodate='+uptodate+"&fleetno="+fleetno);
	}


	if(type=="fleetwise")
	{

	$("#overlay, #PleaseWait").show();
	var aa="fleet";
	$("#fleetdiv").load("fleetcalugrid.jsp?barchvals="+barchval+"&vals="+aa+"&fleetno="+fleetno+"&type="+type+"&findoc="+findoc+"&dealno="+dealno+'&uptodate='+uptodate+'&id=1');



	}

	if(type=="vehwise")
	{

	$("#overlay, #PleaseWait").show();
	var aa="veh";
	$("#fdiv").load("fleetgrid.jsp?barchval="+barchval+"&type="+type+"&val="+aa+"&findoc="+findoc+"&dealno="+dealno+'&uptodate='+uptodate+"&fleetno="+fleetno);



	}
	if(type=="detail" && fleetno=="")
	{

	$("#overlay, #PleaseWait").show();
	var aa="fleets";
	$("#detdivs").load("detailgrid.jsp?barchval="+barchval+"&type="+type+"&val="+aa+"&findoc="+findoc+"&dealno="+dealno+'&uptodate='+uptodate+"&fleetno="+fleetno);




	}



	}



	function changegrid()
	{
	var type = document.getElementById("type").value;
	if(type=="summary" || type=="banksummary")
	{
		$("#fleetdiv").hide();
		$("#fleetsearch").hide();  
		$("#emptyrow").show();  
		$("#enqlistdiv").show();
		$("#detdivs").hide();
		$("#fdiv").hide();
	
		$("#detailgeids").jqxGrid('clear');
		$("#detailgeids").jqxGrid('addrow', null, {});
	
	
		$("#fleeetgrid").jqxGrid('clear');
		$("#fleeetgrid").jqxGrid('addrow', null, {});
		$("#vehicleFleetGrid").jqxGrid('clear');
	
		$("#vehicleFleetGrid").jqxGrid('addrow', null, {});
	
		$("#vehicleAssetGrid").jqxGrid('clear');
	
		$("#vehicleAssetGrid").jqxGrid('addrow', null, {});
		document.getElementById("fleetno").value="";
		$('#fleetno').attr('placeholder', 'Press F3 TO Search');

	}
	else if(type=="fleetwise"){
		$("#detailgeids").jqxGrid('clear');
		$("#detailgeids").jqxGrid('addrow', null, {});
	
		$("#fleeetgrid").jqxGrid('clear');
		$("#fleeetgrid").jqxGrid('addrow', null, {});
	
		$("#vehicleAssetGrid").jqxGrid('clear');
		$("#vehicleAssetGrid").jqxGrid('addrow', null, {});
	
		$("#vehicleFleetGrid").jqxGrid('clear');
	
		$("#vehicleFleetGrid").jqxGrid('addrow', null, {});
	
		$("#fleetsearch").show();  
		$("#emptyrow").hide(); 
		$("#fleetdiv").show();
		$("#enqlistdiv").hide();
		$("#detdivs").hide();
		$("#fdiv").hide();
	}
	else if(type=="detail")
	{
		$("#fleetsearch").hide(); 
		$("#emptyrow").show(); 
		$("#fleetdiv").hide();
		$("#enqlistdiv").hide();
		$("#detdivs").show();
		$("#fdiv").hide();
	
		$("#detailgeids").jqxGrid('clear');
		$("#detailgeids").jqxGrid('addrow', null, {});
	
	
		$("#fleeetgrid").jqxGrid('clear');
		$("#fleeetgrid").jqxGrid('addrow', null, {});
	
		$("#vehicleAssetGrid").jqxGrid('clear');
		$("#vehicleAssetGrid").jqxGrid('addrow', null, {});
		$("#vehicleFleetGrid").jqxGrid('clear');
	
		$("#vehicleFleetGrid").jqxGrid('addrow', null, {});
	
		document.getElementById("fleetno").value="";
		$('#fleetno').attr('placeholder', 'Press F3 TO Search');
	}
	else if(type=="vehwise"){
		$("#detailgeids").jqxGrid('clear');
		$("#detailgeids").jqxGrid('addrow', null, {});
	
		$("#fleeetgrid").jqxGrid('clear');
		$("#fleeetgrid").jqxGrid('addrow', null, {});
	
		$("#vehicleAssetGrid").jqxGrid('clear');
		$("#vehicleAssetGrid").jqxGrid('addrow', null, {});
	
		$("#vehicleFleetGrid").jqxGrid('clear');
		$("#vehicleFleetGrid").jqxGrid('addrow', null, {});
	
		$("#fleetsearch").show();  
		$("#emptyrow").hide(); 
		$("#fleetdiv").hide();
		$("#enqlistdiv").hide();
		$("#detdivs").hide();
		$("#fdiv").show();
	}
	}


	function funcleardata()
	{
	$("#fleetdiv").hide();
	$("#enqlistdiv").show();
	$("#detdivs").hide();
	$("#fdiv").hide();

	$('#uptodate').val(new Date());

	$("#detailgeids").jqxGrid('clear');
	$("#detailgeids").jqxGrid('addrow', null, {});

	$("#fleeetgrid").jqxGrid('clear');
	$("#fleeetgrid").jqxGrid('addrow', null, {});
	$("#vehicleFleetGrid").jqxGrid('clear');

	$("#vehicleFleetGrid").jqxGrid('addrow', null, {});

	$("#vehicleAssetGrid").jqxGrid('clear');
	$("#vehicleAssetGrid").jqxGrid('addrow', null, {});
	document.getElementById("fleetno").value="";

	document.getElementById("type").value="summary";

	document.getElementById("dealno").value="";
	document.getElementById("txtaccid").value="";
	document.getElementById("txtaccname").value="";
	document.getElementById("txtdocno").value="";
	// txtaccname txtdocno

	$('#fleetno').attr('placeholder', 'Press F3 TO Search');
	$('#txtaccid').attr('placeholder', 'Press F3 TO Search');
	$('#dealno').attr('placeholder', 'Press F3 TO Search');

	}

</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ===== LEFT PANEL ===== -->
<td width="20%" valign="top">

<fieldset class="filter-card scrollable-left">
<table width="100%" class="filter-table">

    <!-- HEADING (UNCHANGED â WILL APPEAR) -->
    <jsp:include page="../../heading.jsp"></jsp:include>

    <tr>
        <td class="label-cell">Up To</td>
        <td>
            <div id="uptodate" name="uptodate"
                 value='<s:property value="uptodate"/>'></div>
        </td>
    </tr>

    <tr>
        <td class="label-cell">Type</td>
        <td>
            <select id="type" class="master-input" onchange="changegrid()">
                <option value="summary">Deal Wise Summary</option>
                <option value="banksummary">Bank Wise Summary</option>
                <option value="fleetwise">Fleet Wise Summary</option>
                <option value="vehwise">Fleet Wise Details</option>
                <option value="detail">Detail</option>
            </select>
        </td>
    </tr>

    <tr id="fleetsearch">
        <td class="label-cell">Fleet</td>
        <td>
            <input type="text"
                   id="fleetno"
                   name="fleetno"
                   class="master-input"
                   readonly
                   placeholder="Press F3 To Search"
                   value='<s:property value="fleetno"/>'
                   onkeydown="getfleetdata(event);">
        </td>
    </tr>

    <tr>
        <td class="label-cell">Account</td>
        <td>
            <input type="text"
                   id="txtaccid"
                   name="txtaccid"
                   class="master-input"
                   readonly
                   placeholder="Press F3 to Search"
                   value='<s:property value="txtaccid"/>'
                   onkeydown="getAccTypeFrom(event);">
        </td>
    </tr>

    <tr>
        <td></td>
        <td>
            <input type="text"
                   id="txtaccname"
                   name="txtaccname"
                   class="master-input"
                   readonly
                   tabindex="-1"
                   value='<s:property value="txtaccname"/>'>
            <input type="hidden"
                   id="txtdocno"
                   name="txtdocno"
                   value='<s:property value="txtdocno"/>'>
        </td>
    </tr>

    <tr>
        <td class="label-cell">Deal No</td>
        <td>
            <input type="text"
                   id="dealno"
                   name="dealno"
                   class="master-input"
                   readonly
                   placeholder="Press F3 to Search"
                   value='<s:property value="dealno"/>'
                   onkeydown="getdealNo(event);">
        </td>
    </tr>

    <tr>
        <td colspan="2" align="center">
            <button type="button"
                    class="btn-submit"
                    onclick="funcleardata()">Clear</button>
        </td>
    </tr>

    <tr>
        <td colspan="2">
            <div id="paychaaaaa" style="width:100%; height:150px;"></div>
        </td>
    </tr>

</table>
</fieldset>

<input type="hidden" id="cldocno" name="cldocno">

</td>

<!-- ===== RIGHT GRID ===== -->
<td width="80%" valign="top">
<table width="100%">
<tr>
    <td>
        <div id="enqlistdiv">
            <jsp:include page="Gridfirst.jsp"></jsp:include>
        </div>

        <div id="fleetdiv" hidden="true">
            <jsp:include page="fleetcalugrid.jsp"></jsp:include>
        </div>

        <div id="detdivs" hidden="true">
            <jsp:include page="detailgrid.jsp"></jsp:include>
        </div>

        <div id="fdiv" hidden="true">
            <jsp:include page="fleetgrid.jsp"></jsp:include>
        </div>
    </td>
</tr>
</table>
</td>

</tr>
</table>

</div>

<div id="fleetwindow"><div></div></div>
<div id="accountSearchwindow"><div></div></div>
<div id="dealnowindow"><div></div></div>

</div>
</body>

</html>