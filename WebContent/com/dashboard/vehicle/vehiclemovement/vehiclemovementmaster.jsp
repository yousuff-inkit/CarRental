
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
</style> 
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
	
	
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	 $('#fleetwindow').jqxWindow({ width: '30%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Fleet Search' , position: { x: 200, y: 60 }, keyboardCloseKey: 27});
	 $('#fleetwindow').jqxWindow('close');
	     
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
     
	     
	 $('#fleetno').dblclick(function(){
	  	    $('#fleetwindow').jqxWindow('open');
	   
	       fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow')); 
    });
	 
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
    
});




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


	  fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow'));     }
	 else{
		 }
	 }

function funreload(event)
{
	 var fleetno = document.getElementById("fleetno").value;

	 if(fleetno=="")
		 {
		   $.messager.alert('Message','Search Fleet  ','warning'); 
		   return 0;
		 }
	 else
		 {
		 
		  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  } 
		   else{
			   document.getElementById("trncodeval").innerText="";
			   document.getElementById("statusval").innerText="";
			   
     var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val();
	 $("#overlay, #PleaseWait").show();
	  $("#vehdiv").load("vehiclemovementGrid.jsp?fleetno="+fleetno+"&fromdate="+fromdate+"&todate="+todate);
		   }
		 }
	
	}
function hiddenbrh(){
	
	$("#branchlabel").attr('hidden',true);
	$("#branchdiv").attr('hidden',true);
	
}
function funExportBtn(){
	   
	   
	   
	   if(parseInt(window.parent.chkexportdata.value)=="1")
	    {
	    JSONToCSVCon(datamov, 'Vehicle Movement', true);
	    }
	   else
	    {
		   $("#vehmovement").jqxGrid('exportdata', 'xls', 'Vehicle Movement');
	    }
	   
	   
	   
	   
	   
	 }


</script>
</head>
<body onload="hiddenbrh();">

<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<table width="100%">
<tr>

<!-- ================= LEFT PANEL (20%) ================= -->
<td width="20%" valign="top">

    <div class="master-container">
        <div class="sidebar-filters">

            <!-- Heading -->
            <div class="sidebar-fixed-top">
                <div class="filter-card">
                    <jsp:include page="../../heading.jsp"></jsp:include>
                </div>
            </div>

            <!-- Scrollable Content -->
            <div class="sidebar-scroll-content">

                <!-- Fleet & Date Filter -->
                <div class="filter-card">
                    <table class="filter-table">

                        <tr>
                            <td class="label-cell">Fleet</td>
                            <td>
                                <input type="text"
                                       id="fleetno"
                                       name="fleetno"
                                       placeholder="Press F3 To Search"
                                       readonly
                                       value='<s:property value="fleetno"/>'
                                       onkeydown="getfleetdata(event);">
                            </td>
                        </tr>

                        <tr>
                            <td class="label-cell">From</td>
                            <td><div id='fromdate'></div></td>
                        </tr>

                        <tr>
                            <td class="label-cell">To</td>
                            <td><div id='todate'></div></td>
                        </tr>

                    </table>
                </div>

                <!-- Vehicle Info Box -->
                <div class="filter-card">
                    <p id="vehinfo"
                       style="background:#fff; height:180px; font:10px Tahoma; overflow:auto; padding:5px;">
                        <s:property value="vehinfo"></s:property>
                    </p>
                </div>

                <!-- Status Labels -->
                <div class="filter-card" style="text-align:center;">
                    <font size="3" color="Blue">
                        <b><label id="trncodeval"></label></b>
                    </font>
                    <br><br>
                    <font size="3" color="Blue">
                        <b><label id="statusval"></label></b>
                    </font>
                </div>

                <!-- Payment Area -->
                <div class="filter-card">
                    <div id='paychaaaaa' style="width:100%; height:60px;"></div>
                </div>

            </div>
        </div>
    </div>

</td>

<!-- ================= RIGHT PANEL (80%) ================= -->
<td width="80%" valign="top">
    <table width="100%">
        <tr>
            <td>
                <div id="vehdiv">
                    <jsp:include page="vehiclemovementGrid.jsp"></jsp:include>
                </div>
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

</div>
</body>
</html>