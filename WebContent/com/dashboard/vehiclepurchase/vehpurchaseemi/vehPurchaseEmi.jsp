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
.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
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
		<div class='hidden-scrollbar'>
			<table width="100%" >
				<tr>
					<td width="20%" >
    					<fieldset style="background: #ECF8E0;">
							<table width="100%"  >
								<jsp:include page="../../heading.jsp"></jsp:include>
								<tr><td colspan="2">&nbsp;</td></tr> 
	  							<tr>
	  								<td align="right"><label class="branch">Up To</label></td>
     								<td align="left"><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td>
     							</tr>
	 							<tr><td colspan="2">&nbsp;</td></tr>
 								<tr>
 									<td align="right"><label class="branch">Type</label></td>
 									<td>
 										<select id="type" onchange="changegrid()">
 											<option value="summary">Deal Wise Summary</option>
 											<option value="banksummary">Bank Wise Summary</option>
 											<option value="fleetwise">Fleet Wise Summary</option>
 											<option value="vehwise">Fleet Wise Details</option>
 											<option value="detail">Detail</option>
 										</select>
 									</td>
 								</tr>  
 								<tr id="fleetsearch">
									<td  align="right"><label class="branch">Fleet</label></td>	<td> <input type="text" id="fleetno" style="height:20px;width:61%;" name="fleetno" placeholder="Press F3 To Search" onfocus="this.placeholder = ''" readonly="readonly" value='<s:property value="fleetno"/>' onkeydown="getfleetdata(event);" > </td>
           						</tr> 
 								<tr>
 									<td align="right"><label class="branch">Account</label></td>  
 									<td align="left"><input type="text" id="txtaccid" name="txtaccid" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>'  onkeydown="getAccTypeFrom(event);"/></td>
 								</tr> 
 								<tr>
 									<td>&nbsp;</td>
 									<td>
 										<input type="text" id="txtaccname" name="txtaccname" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="txtaccname"/>' tabindex="-1"/>
    									<input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
    								</td>
    							</tr>
  								<tr>
									<td  align="right"><label class="branch">Deal No</label></td>	<td> <input type="text" id="dealno" readonly="readonly" style="height:20px;width:61%;" placeholder="Press F3 to Search" name="dealno" value='<s:property value="dealno"/>' onkeydown="getdealNo(event);" > </td>
    							</tr> 
								<tr><td colspan="2">&nbsp;</td></tr>
 								<tr><td colspan="2">&nbsp;</td></tr> 
 								<tr id="emptyrow"><td colspan="2">&nbsp;</td></tr>
 								<tr>
	 								<td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funcleardata()"></td>
	 							</tr>
								<tr>
									<td colspan="2"><div id='paychaaaaa' style="width: 100% ; align:right; height: 150px;"></div></td>
								</tr>	
							</table>
						</fieldset>
						<input type="hidden" id="cldocno" style="height:20px;width:70%;"  name="cldocno">
					</td>
					<td width="80%">
						<table width="100%">
							<tr>
			 					<td>
			 						<div id="enqlistdiv" ><jsp:include page="Gridfirst.jsp"></jsp:include></div>
			 						<div id="fleetdiv" hidden="true"><jsp:include page="fleetcalugrid.jsp"></jsp:include></div>
			  						<div id="detdivs" hidden="true"><jsp:include page="detailgrid.jsp"></jsp:include></div> 
			  					   <div id="fdiv" hidden="true"><jsp:include page="fleetgrid.jsp"></jsp:include></div>
			  						
			 					</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
		<div id="fleetwindow">
   			<div></div>
		</div> 
		<div id="accountSearchwindow">
   			<div ></div>
		</div>
		<div id="dealnowindow">
   			<div ></div>
		</div>
	</div>
</body>
</html>