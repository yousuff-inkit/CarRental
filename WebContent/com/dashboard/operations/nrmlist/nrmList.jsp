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


</style>

<script type="text/javascript">

$(document).ready(function () {
		document.getElementById("branchlabel").style.display="none";
		document.getElementById("branchdiv").style.display="none";
		   $("#btnExcel").click(function() {
				JSONToCSVCon(nrmexceldata, 'Movement List', true);
				//$("#vehiclelist").jqxGrid('exportdata', 'xls', 'vehiclelist');
			});
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:210px;right:525px;'><img src='../../../../icons/31load.gif'/></div>");
	    $('#fleetwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Fleet Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#fleetwindow').jqxWindow('close');
		$('#employeewindow').jqxWindow({ width: '50%', height: '50%',  maxHeight: '50%' ,maxWidth: '50%' , title: 'Employee Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#employeewindow').jqxWindow('close');
		$('#garagewindow').jqxWindow({ width: '50%', height: '50%',  maxHeight: '50%' ,maxWidth: '50%' , title: 'Garage Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#garagewindow').jqxWindow('close');
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	
	    
	    $('#fleet').dblclick(function(){
		
			 $('#fleetwindow').jqxWindow('open');
				$('#fleetwindow').jqxWindow('focus');
				 fleetSearchContent('masterFleetSearch.jsp');
			});
	    $('#employee').dblclick(function(){
			if(document.getElementById("cmbemptype").value==""){
				$.messager.alert('Warning','Please Select Employee Type');
				return false;
			}
			 $('#employeewindow').jqxWindow('open');
				$('#employeewindow').jqxWindow('focus');
				 employeeSearchContent('employeeSearch.jsp?emptype='+document.getElementById("cmbemptype").value);
			});
	    $('#garage').dblclick(function(){
			
			 $('#garagewindow').jqxWindow('open');
				$('#garagewindow').jqxWindow('focus');
				 garageSearchContent('garageSearch.jsp');
			});
	    
	    
	    
});


function getFleet(event){
	var x= event.keyCode;
	if(x==114){
		
		 $('#fleetwindow').jqxWindow('open');
			$('#fleetwindow').jqxWindow('focus');
			 fleetSearchContent('masterFleetSearch.jsp');			 
	}
}
function getEmployee(event){
	if(document.getElementById("cmbemptype").value==""){
		$.messager.alert('Warning','Please Select Employee Type');
		return false;
	}
	var x= event.keyCode;
	if(x==114){
		
		 $('#employeewindow').jqxWindow('open');
			$('#employeewindow').jqxWindow('focus');
			employeeSearchContent('employeeSearch.jsp?emptype='+document.getElementById("cmbemptype").value);			 
	}
}

function getGarage(event){
	var x= event.keyCode;
	if(x==114){
		
		 $('#garagewindow').jqxWindow('open');
			$('#garagewindow').jqxWindow('focus');
			 garageSearchContent('garageSearch.jsp');			 
	}
}


function fleetSearchContent(url) {
    $.get(url).done(function (data) {
    	$('#fleetwindow').jqxWindow('setContent', data);
	}); 
}
function employeeSearchContent(url) {
   $.get(url).done(function (data) {
   		$('#employeewindow').jqxWindow('setContent', data);
	}); 
}
function garageSearchContent(url) {
    $.get(url).done(function (data) {
    	$('#garagewindow').jqxWindow('setContent', data);
	}); 
}
function funreload(event)
{
    var fromdate=$('#fromdate').jqxDateTimeInput('val');
    var todate=$('#todate').jqxDateTimeInput('val');
    $("#overlay, #PleaseWait").show();
    var fleet=document.getElementById("fleet").value;
    var movtype=document.getElementById("cmbtype").value;
    var emptype=document.getElementById("cmbemptype").value;
    var employee=document.getElementById("hidemployee").value;
    var garage=document.getElementById("hidgarage").value;
    var status=document.getElementById("cmbstatus").value;
   	$("#nrmdiv").load("nrmListGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&fleet="+fleet+"&movtype="+movtype+"&emptype="+emptype+"&employee="+employee+"&garage="+garage+"&status="+status+"&id=1");
   	
}
	
	function getCmbtype(){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				items = items.split('***');
				
				var typeIdItems  = items[1].split(",");
				var typeItems = items[0].split(",");
				var optionsbranch = '<option value="">--Select--</option>';
				for (var i = 0; i < typeItems.length;i++){
					optionsbranch += '<option value="' + typeIdItems[i]+ '">'
							+ typeItems[i] + '</option>';
				}
				$("select#cmbtype").html(optionsbranch);

			} else {

			}
		}
		x.open("GET","getCmbtype.jsp", true);
		x.send();
	}

	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
		getCmbtype();
	}
	function funExportBtn(){
		$("#nrmdiv").excelexportjs({
			containerid: "nrmdiv",
			datatype: 'json',
			dataset: null,
			gridId: "nrmListGrid",
			columns: getColumns("nrmListGrid"),
			worksheetName: "Movement List Data"
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
	</script>
	
</head>
<body onload="setValues();">

<form id="frmNrmList" method="post">

<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ================= LEFT PANEL ================= -->
<td width="20%" valign="top">

<div class="master-container">
<div class="sidebar-filters">

    <!-- FIXED HEADING -->
    <div class="sidebar-fixed-top">
        <div class="filter-card">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>
    </div>

    <!-- SCROLLABLE FILTER AREA -->
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
                <td class="label-cell">Fleet</td>
                <td>
                    <input type="text"
                           id="fleet"
                           name="fleet"
                           readonly
                           placeholder="Press F3 to Search">
                </td>
            </tr>

            <tr>
                <td class="label-cell">Type</td>
                <td>
                    <select id="cmbtype" name="cmbtype">
                        <option value="">--Select--</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Emp Type</td>
                <td>
                    <select id="cmbemptype" name="cmbemptype">
                        <option value="">--Select--</option>
                        <option value="stf">Staff</option>
                        <option value="drv">Driver</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Employee</td>
                <td>
                    <input type="text"
                           id="employee"
                           name="employee"
                           readonly
                           placeholder="Press F3 to Search">
                    <input type="hidden" id="hidemployee" name="hidemployee">
                </td>
            </tr>

            <tr>
                <td class="label-cell">Garage</td>
                <td>
                    <input type="text"
                           id="garage"
                           name="garage"
                           readonly
                           placeholder="Press F3 to Search">
                    <input type="hidden" id="hidgarage" name="hidgarage">
                </td>
            </tr>

            <tr>
                <td class="label-cell">Mov Status</td>
                <td>
                    <select id="cmbstatus" name="cmbstatus">
                        <option value="">--Select--</option>
                        <option value="0">Open</option>
                        <option value="1">Closed</option>
                    </select>
                </td>
            </tr>

        </table>
        </div>

        <!-- ACTION BUTTON -->
        <button type="button"
                class="btn-submit"
                onclick="funClearData();">
            Clear
        </button>

    </div>
</div>
</div>

</td>

<!-- ================= RIGHT PANEL ================= -->
<td width="80%" valign="top">

<table width="100%">
<tr>
    <td>
        <div id="nrmdiv">
            <jsp:include page="nrmListGrid.jsp"></jsp:include>
        </div>

        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
    </td>
</tr>
</table>

</td>

</tr>
</table>

</div>

<!-- POPUP WINDOWS -->
<div id="fleetwindow"><div></div></div>
<div id="employeewindow"><div></div></div>
<div id="garagewindow"><div></div></div>

</div>

</form>
</body>

</html>