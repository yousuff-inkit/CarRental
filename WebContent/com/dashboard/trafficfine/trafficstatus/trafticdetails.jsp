
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
.scrollable-left {
    max-height: calc(100vh - 120px);
    overflow-y: auto;
    overflow-x: hidden;
}

.input-with-icon {
    display: flex;
    align-items: center;
    gap: 6px;
}

.icon-btn {
    border: none;
    background: transparent;
    cursor: pointer;
    padding: 0;
}

</style>
 
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		
     $('#ticketnowindow').jqxWindow({ width: '38%', height: '48%',  maxHeight: '48%' ,maxWidth: '38%' , title: 'Ticket Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	 $('#ticketnowindow').jqxWindow('close');  
	 $('#regnowindow').jqxWindow({ width: '60%', height: '56%',  maxHeight: '56%' ,maxWidth: '60%' , title: 'Reg No. Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	 $('#regnowindow').jqxWindow('close');
	 $("#cmbbranch").attr('hidden',true); 
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	 $('#todate').on('change', function (event) {
			
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }   
	 });
	 
	 $('#ticketno').dblclick(function(){
		 ticketSearchContent('ticketSearchGrid.jsp?id=1&fromdate='+$('#fromdate').jqxDateTimeInput('val')+'&todate='+$('#todate').jqxDateTimeInput('val')); 
	});
	 $('#regno').dblclick(function(){
		 regnoSearchContent('regnoSearchGrid.jsp?id=1&fromdate='+$('#fromdate').jqxDateTimeInput('val')+'&todate='+$('#todate').jqxDateTimeInput('val')); 
	});
	 
});

function ticketSearchContent(url) {
	$('#ticketnowindow').jqxWindow('open');
	$.get(url).done(function (data) {
		$('#ticketnowindow').jqxWindow('setContent', data);
		$('#ticketnowindow').jqxWindow('bringToFront');
	});
}
function getTicket(event){
    var x= event.keyCode;
    if(x==114){
    	ticketSearchContent('ticketSearchGrid.jsp?id=1&fromdate='+$('#fromdate').jqxDateTimeInput('val')+'&todate='+$('#todate').jqxDateTimeInput('val'));
    }
    else{}
}
function regnoSearchContent(url) {
	$('#regnowindow').jqxWindow('open');
	$.get(url).done(function (data) {
		$('#regnowindow').jqxWindow('setContent', data);
		$('#regnowindow').jqxWindow('bringToFront');
	});
}
function getRegno(event){
    var x= event.keyCode;
    if(x==114){
    	regnoSearchContent('regnoSearchGrid.jsp?id=1&fromdate='+$('#fromdate').jqxDateTimeInput('val')+'&todate='+$('#todate').jqxDateTimeInput('val'));
    }
    else{}
}
function funreload(event)
{

	var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 
	  // out date
	 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	 	 
	   if(fromdates>todates){
		   
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		 
	   return false;
	  } 
	   else
	   {
	
		   $("#overlay, #PleaseWait").show();
var fromdate= $("#fromdate").val();
var todate= $("#todate").val(); 
var regno= $("#regno").val();
var test ="10"; 

$("#Readygrid").load("subgrid.jsp?test="+test+"&from="+encodeURIComponent(fromdate)+"&regno="+encodeURIComponent(regno)+"&to="+encodeURIComponent(todate)+"&ticketno="+$('#ticketno').val());


$("#posgrid").load("subposting.jsp?test="+test+"&from="+encodeURIComponent(fromdate)+"&regno="+encodeURIComponent(regno)+"&to="+encodeURIComponent(todate)+"&ticketno="+$('#ticketno').val());


//  $("#detlist").load("detailsGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate);  
 }

	
	}
	
function hiddenbrh(){
	
	$("#branchlabel").attr('hidden',true);
	$("#branchdiv").attr('hidden',true);
	//$('#gridlength').val(""); 
}

	
function funExportBtn()
{
	
	 $("#fleetdiv").excelexportjs({  
    		containerid: "fleetdiv", 
    		datatype: 'json', 
    		dataset: null, 
    		gridId: "jqxFleetGrid", 
    		columns: getColumns("jqxFleetGrid") , 
    		worksheetName:"Traffic Status"
    		}); 

	
/* 	 if(parseInt(window.parent.chkexportdata.value)=="1")
	  {
	  	JSONToCSVCon(dataexcel, 'Trafficstatus', true);
	  }
	 else
	  {
	                 
		 $("#jqxFleetGrid").jqxGrid('exportdata', 'xls', 'Trafficstatus');
	  }
	 
	
 */	}
	
	/* function funsetaval()
	{
		  if (document.getElementById('det_chk').checked) {
		
		document.getElementById("chkdatails").value="search";
		   $('#jqxFleetGrid').jqxGrid('showcolumn', 'empid');
		   $('#jqxFleetGrid').jqxGrid('showcolumn', 'empname');
		  }
		  else
			  {
			  document.getElementById("chkdatails").value="";
			   $('#jqxFleetGrid').jqxGrid('hidecolumn', 'empid');
			   $('#jqxFleetGrid').jqxGrid('hidecolumn', 'empname');
			  }
	}
	 */
	 function clearTicket(){
		 $('#ticketno').val('');
		 $('#ticketno').attr('placeholder','Press F3 to Search');
		 $('#ticketno').attr('readonly',true);
		 return false;
	 }
	 function clearRegno(){
		 $('#regno').val('');
		 $('#regno').attr('placeholder','Press F3 to Search');
		 $('#regno').attr('readonly',true);
		 return false;
	 }
</script>
</head>
<body onload="getBranch();hiddenbrh()">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ===== LEFT PANEL ===== -->
<td width="20%" valign="top">

<fieldset class="filter-card scrollable-left">
<table width="100%" class="filter-table">

    <!-- HEADING (UNCHANGED) -->
    <jsp:include page="../../heading.jsp"></jsp:include>

    <tr>
        <td class="label-cell">From</td>
        <td>
            <div id="fromdate" name="fromdate"
                 value='<s:property value="fromdate"/>'></div>
        </td>
    </tr>

    <tr>
        <td class="label-cell">To</td>
        <td>
            <div id="todate" name="todate"
                 value='<s:property value="todate"/>'></div>
        </td>
    </tr>

    <tr>
        <td class="label-cell">Ticket No</td>
        <td class="input-with-icon">
            <input type="text"
                   id="ticketno"
                   name="ticketno"
                   class="master-input"
                   readonly
                   placeholder="Press F3 to Search"
                   onclick="getTicket(event)">
            <button type="button"
                    class="icon-btn"
                    onclick="clearTicket();">
                <img src="../../../../icons/cancel_new.png" alt="">
            </button>
        </td>
    </tr>

    <tr>
        <td class="label-cell">Reg No</td>
        <td class="input-with-icon">
            <input type="text"
                   id="regno"
                   name="regno"
                   class="master-input"
                   readonly
                   placeholder="Press F3 to Search"
                   onclick="getRegno(event)">
            <button type="button"
                    class="icon-btn"
                    onclick="clearRegno();">
                <img src="../../../../icons/cancel_new.png" alt="">
            </button>
        </td>
    </tr>

    <tr>
        <td colspan="2">
            <div id="Readygrid">
                <jsp:include page="subgrid.jsp"></jsp:include>
            </div>
        </td>
    </tr>

    <tr>
        <td colspan="2">
            <div id="posgrid">
                <jsp:include page="subposting.jsp"></jsp:include>
            </div>
        </td>
    </tr>

</table>
</fieldset>

</td>

<!-- ===== RIGHT GRID ===== -->
<td width="80%" valign="top">

<table width="100%" id="grid1">
<tr>
    <td>
        <div id="fleetdiv">
            <jsp:include page="detailsgrid.jsp"></jsp:include>
        </div>
    </td>
</tr>
</table>

</td>

</tr>
</table>

<!-- HIDDEN FIELDS (UNCHANGED) -->
<input type="hidden" id="chkdatails" name="chkdatails" value='<s:property value="chkdatails"/>'>
<input type="hidden" id="emptype" value='<s:property value="chkdatails"/>'>
<input type="hidden" id="empname" value='<s:property value="chkdatails"/>'>

<div id="ticketnowindow"><div></div><div></div></div>
<div id="regnowindow"><div></div><div></div></div>

</div>
</div>
</body>

</html>
