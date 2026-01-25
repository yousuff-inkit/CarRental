
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

.inner-fieldset {
    border: none;
    padding: 6px 0;
}

</style>

<script type="text/javascript">
	$(document).ready(function () {
 		
		$("#cmbbranch").attr('hidden',true); 
	 	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	 	$("body").prepend('<div id="suboverlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     	$("body").prepend("<div id='subPleaseWait' style='display: none;position:absolute; z-index: 1;top:280px;left:100px;'><img src='../../../../icons/31load.gif'/></div>");
	
     	$('#fleetwindow').jqxWindow({ width: '60%', height: '60%',  maxHeight: '60%' ,maxWidth: '60%' , title: 'Fleet Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
   	 	$('#fleetwindow').jqxWindow('close');
	
	 	$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 	$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 	var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 	var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
     	$('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	 	
     	$('#todate').on('change', function (event) {
			var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			var todates=new Date($('#todate').jqxDateTimeInput('getDate'));
			if(fromdates>todates){
				$.messager.alert('Message','To Date Less Than From Date  ','warning');   
				return false;
			}   
		});
     	
     	$('#fleetno').dblclick(function(){
     		filterSearchContent('fleetMasterSearch.jsp','#fleetwindow');
     	});
	});

	function getFleet(event){
		var x= event.keyCode;
	    if(x==114){
	    	filterSearchContent('fleetMasterSearch.jsp','#fleetwindow');
	    }
	}
	
	function filterSearchContent(url,targetid) {
	    $(targetid).jqxWindow('open');
		$.get(url).done(function (data) {
			$(targetid).jqxWindow('setContent', data);
			$(targetid).jqxWindow('bringToFront');
		}); 
	}
	
	function funreload(event){
		var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		var todates=new Date($('#todate').jqxDateTimeInput('getDate'));
	 	if(fromdates>todates){
			$.messager.alert('Message','To Date Less Than From Date  ','warning');   
			return false;
	  	} 
	   	else{
			var fromdate= $("#fromdate").val();
 			var todate= $("#todate").val(); 
 			var chkincrecv= $("#hidchckincrecv").val(); 
	 		var test ="10"; 
	 		var fleetno=$('#fleetno').val();
     	 	$("#suboverlay, #subPleaseWait").show();
	  		$("#Readygrid").load("subgrid.jsp?test="+test+"&from="+fromdate+"&to="+todate+"&chkincrecv="+chkincrecv+"&id=1&fleetno="+fleetno);
			//  $("#detlist").load("detailsGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate);
	   	}
	}
	
	function hiddenbrh(){
		$("#branchlabel").attr('hidden',true);
		$("#branchdiv").attr('hidden',true);
		//$('#gridlength').val(""); 
	}

	
	function funExportBtn(){
		
		$("#jqxFleetGrid").excelexportjs({
			containerid: "jqxFleetGrid",
			datatype: 'json',
			dataset: null,
			gridId: "jqxFleetGrid",
			columns: getColumns("jqxFleetGrid") ,
			worksheetName:"Salik Status"
		});
	}	
 
	function increcvcheck(){
		if(document.getElementById("chckincrecv").checked){
			document.getElementById("hidchckincrecv").value = 1;
		}
	 	else{
			document.getElementById("hidchckincrecv").value = 0;
		}
	} 
	
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
	 
</script>
</head>
<body onload="getBranch();hiddenbrh();increcvcheck();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ===== LEFT SIDE ===== -->
<td width="20%" valign="top">

<fieldset class="filter-card">
<table width="100%" class="filter-table">

    <!-- HEADING (UNCHANGED – WILL APPEAR) -->
    <jsp:include page="../../heading.jsp"></jsp:include>

    <tr><td colspan="2">&nbsp;</td></tr>

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

    <tr><td colspan="2">&nbsp;</td></tr>

    <tr>
        <td class="label-cell">Fleet</td>
        <td>
            <input type="text"
                   name="fleetno"
                   id="fleetno"
                   class="master-input"
                   readonly
                   value='<s:property value="fleetno"/>'
                   onkeyup="getFleet(event);">
        </td>
    </tr>

    <tr>
        <td colspan="2" align="center">
            <input type="checkbox"
                   id="chckincrecv"
                   name="chckincrecv"
                   onchange="increcvcheck();"
                   onclick="$(this).attr('value', this.checked ? 1 : 0)">
            <input type="hidden"
                   id="hidchckincrecv"
                   name="hidchckincrecv"
                   value='<s:property value="hidchckincrecv"/>'>
            <label class="branch">Including Received</label>
        </td>
    </tr>

    <tr><td colspan="2">&nbsp;</td></tr>

    <tr>
        <td colspan="2">
            <div id="Readygrid">
                <jsp:include page="subgrid.jsp"></jsp:include>
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

<input type="hidden" id="chkdatails" name="chkdatails"
       value='<s:property value="chkdatails"/>'>
<input type="hidden" id="emptype"
       value='<s:property value="chkdatails"/>'>
<input type="hidden" id="empname"
       value='<s:property value="chkdatails"/>'>

<div id="fleetwindow">
    <div></div><div></div>
</div>

</div>
</div>
</body>



</html>
