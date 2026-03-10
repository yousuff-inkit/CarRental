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
.myButtons, .myButton {
    background-color: #2563eb !important;
    color: #ffffff !important;
    border: none !important;
    border-radius: 6px;
    padding: 10px 15px;
    width: 100%;
    font-weight: 600;
    cursor: pointer;
}

.myButtons:hover, .myButton:hover {
    background-color: #1d4ed8 !important;
}

</style>

<script type="text/javascript">

$(document).ready(function () {
	  // setType(null);
	   /*$("#btnExcel").click(function() {
				JSONToCSVCon(exceldata, 'Datalog Report', true);
				//$("#vehiclelist").jqxGrid('exportdata', 'xls', 'vehiclelist');
			});*/
	   $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	$('#vehdetaildiv').hide();
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $('#userwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'User Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	 $('#userwindow').jqxWindow('close');
	 $('#formwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Form Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	 $('#formwindow').jqxWindow('close');
	   var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
       var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
       $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
   
       $('#user').dblclick(function(){
 		  userSearchContent('userSearchGrid.jsp?check=1');
 		});
       $('#form').dblclick(function(){
    	   if (document.getElementById('formbtn').checked){
  		  formSearchContent('formSearchGrid.jsp?check=1');
    	   }
    	   else if  (document.getElementById('bibtn').checked){
    		   formSearchContent('formsearchgrid1.jsp?check=1');
    	   }
    	   });

});

function funExportBtn(){
	$("#logdiv").excelexportjs({
		containerid: "logdiv", 
		datatype: 'json', 
		dataset: null, 
		gridId: "datalogGrid", 
		columns: getColumns("datalogGrid") ,   
		worksheetName:"Datalog Report"
		});
	
}
function getUser(event){
    var x= event.keyCode;
    if(x==114){
    	userSearchContent('userSearchGrid.jsp?check=1');
    }
    else{}
    }
function getForm(event){
	if (document.getElementById('formbtn').checked){
    var x= event.keyCode;
    if(x==114){
    	formSearchContent('formSearchGrid.jsp?check=1');	
    }}
	else if (document.getElementById('bibtn').checked){
		 var x= event.keyCode;
		    if(x==114){
		    	formSearchContent('formsearchgrid1.jsp?check=1');	
		    }
	}
    else{}
    }
    
function userSearchContent(url) {
    $('#userwindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#userwindow').jqxWindow('setContent', data);
	$('#userwindow').jqxWindow('bringToFront');
}); 
}

function formSearchContent(url) {
    $('#formwindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#formwindow').jqxWindow('setContent', data);
	$('#formwindow').jqxWindow('bringToFront');
}); 
}

function funreload(event)
{
	if(document.getElementById("cmbbranch").value==""){
		$.messager.alert('Warning','Please Select Branch');
		return false;
	}
	var dateval=funDateInPeriod($('#todate').jqxDateTimeInput('getDate'));
	//alert(dateval);
	if(dateval==1){
		 var branch=document.getElementById("cmbbranch").value;
	     var fromdate=$('#fromdate').jqxDateTimeInput('val');
	     var todate=$('#todate').jqxDateTimeInput('val');
	  	 var hidform=document.getElementById("hidform").value;
	  	 var hiduser=document.getElementById("hiduser").value;
	  	
	    	 $("#overlay, #PleaseWait").show();
	    	 var test ="10";
	    	 if (document.getElementById('formbtn').checked){
	    		 
	    	 var formbtn=document.getElementById("formbtn").value;
	    	
	    	 $("#Readygrid").load("subgrid.jsp?branch="+branch+"&test="+test+"&from="+fromdate+"&to="+todate+"&id=1&hidform="+hidform+"&hiduser="+hiduser+"&value="+formbtn);
	    	 
	    	 $("#logdiv").load("datalogGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&id=1&hidform="+hidform+"&hiduser="+hiduser+"&value="+formbtn);   	 
	    	 }
	    	 else if (document.getElementById('bibtn').checked){
	    		 
		    	 var bibtn=document.getElementById("bibtn").value;
		    	 
		    	 $("#Readygrid").load("subgrid.jsp?branch="+branch+"&test="+test+"&from="+fromdate+"&to="+todate+"&id=1&hidform="+hidform+"&hiduser="+hiduser+"&value="+bibtn);
		    	 
		    	 $("#logdiv").load("datalogGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&id=1&hidform="+hidform+"&hiduser="+hiduser+"&value="+bibtn);   	 
		    	 }
	    	 }
	}
	

	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
		   $("#overlay, #PleaseWait").hide();
   		  }
		
		 
	}

	
	function funClearData(){
		$('input[type=text],[type=hidden]').val('');
		$('#fromdate').jqxDateTimeInput('setDate',new Date());
		$('#todate').jqxDateTimeInput('setDate',new Date());
		var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	       var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	       $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 	
	}


</script>
</head>
<body onload="getBranch();setValues();">

<form id="frmCostUpdate" method="post" action="saveCostUpdate">

<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<td width="20%" valign="top">

<div class="master-container">
<div class="sidebar-filters">

    <div class="sidebar-fixed-top">
        <div class="filter-card">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>
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

            <tr>
                <td colspan="2" align="center">
                    <input type="radio"
                           name="chk"
                           id="formbtn"
                           value="formbtn"
                           checked
                           onchange="funchkval();">
                    <label class="branch" for="formbtn">Form</label>
                    &nbsp;&nbsp;
                    <input type="radio"
                           name="chk"
                           id="bibtn"
                           value="bibtn"
                           onchange="funchkval();">
                    <label class="branch" for="bibtn">BI</label>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Form Name</td>
                <td>
                    <input type="text"
                           id="form"
                           name="form"
                           placeholder="Press F3 to Search"
                           readonly
                           onkeydown="getForm(event);">
                </td>
            </tr>

            <tr>
                <td class="label-cell">User</td>
                <td>
                    <input type="text"
                           id="user"
                           name="user"
                           placeholder="Press F3 to Search"
                           readonly
                           onkeydown="getUser(event);">
                </td>
            </tr>

        </table>
        </div>

      <div class="filter-card">
    <input type="button"
           id="btnclear"
           name="btnclear"
           value="Clear"
           class="myButtons"
           onclick="funClearData();">
</div>

        <div class="filter-card">
            <div id="Readygrid">
                <jsp:include page="subgrid.jsp"></jsp:include>
            </div>
        </div>

    </div>
</div>
</div>

</td>

<td width="80%" valign="top">

<table width="100%">
<tr>
    <td>
        <div id="logdiv">
            <jsp:include page="datalogGrid.jsp"></jsp:include>
        </div>

       
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
        <input type="hidden" id="hiduser" name="hiduser">
        <input type="hidden" id="hidform" name="hidform">
    </td>
</tr>
</table>

</td>

</tr>
</table>

</div>


<div id="userwindow">
    <div></div><div></div>
</div>

<div id="formwindow">
    <div></div><div></div>
</div>

</div>
</form>
</body>


</html>