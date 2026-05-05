
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
	
	   $('#clientwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#clientwindow').jqxWindow('close');
	   $('#fleetwindow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Fleet Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#fleetwindow').jqxWindow('close');
	   $('#salesmanwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Salesman Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#salesmanwindow').jqxWindow('close');
	   $('#lpowindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'MRA NO Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#lpowindow').jqxWindow('close');
	   
	   
	   $('#catwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: ' Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#catwindow').jqxWindow('close');
	   
	   
	  
	   $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	   
	
	   
	   $('#clientname').dblclick(function(){
	  	    $('#clientwindow').jqxWindow('open');
	   
	       clientSearchContent('clientsearch.jsp?', $('#clientwindow')); 
      });
	   
	   
	   $('#catname').dblclick(function(){
	  	    $('#catwindow').jqxWindow('open');
	   
	       catnameSearchContent('categorysearch.jsp?', $('#catwindow'));  
     });
	    
	   
	   
	   
	    $('#fleet').dblclick(function(){
	  	    $('#fleetwindow').jqxWindow('open');
	   
	       fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow')); 
       });
	    $('#salesman').dblclick(function(){
	  	    $('#salesmanwindow').jqxWindow('open');
	   
	       salesmanSearchContent('salesmansearch.jsp?', $('#salesmanwindow')); 
       });
	   /*  $('#lpo').dblclick(function(){
	  	    $('#lpowindow').jqxWindow('open');
	   
	  	  lpoSearchContent('lposearch.jsp?', $('#lpowindow')); 
       }); */
	    
	   
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
});
function funExportBtn(){
	   //$("#detailsgrid").jqxGrid('exportdata', 'xls', 'Rental List');
	   
	   
		 JSONToCSVCon(dataildata, 'Lease PO Number', true);
	 }
	 
 
function getclcat(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#catwindow').jqxWindow('open');
	  catnameSearchContent('categorysearch.jsp?', $('#catwindow'));    }
	 else{
		 }
	 } 
	 
	 
function catnameSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#catwindow').jqxWindow('open');
		$('#catwindow').jqxWindow('setContent', data);

	}); 
	}  
function getsalesman(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#salesmanwindow').jqxWindow('open');


	salesmanSearchContent('salesmansearch.jsp?', $('#salesmanwindow'));    }
	 else{
		 }
	 } 
function salesmanSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#salesmanwindow').jqxWindow('open');
		$('#salesmanwindow').jqxWindow('setContent', data);

	}); 
	} 
/* function getlpo(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#lpowindow').jqxWindow('open');


	  lpoSearchContent('lposearch.jsp?', $('#lpowindow'));    }
	 else{
		 }
	 } 
function lpoSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#lpowindow').jqxWindow('open');
		$('#lpowindow').jqxWindow('setContent', data);

	}); 
	}  */
function getfleet(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#fleetwindow').jqxWindow('open');


	 fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow'));    }
	 else{
		 }
	 } 
function fleetSearchContent(url) {
	 //alert(url);
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
 	 //alert(url);
 		 $.get(url).done(function (data) {
 			 
 			 $('#clientwindow').jqxWindow('open');
 		$('#clientwindow').jqxWindow('setContent', data);
 
 	}); 
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
	 var barchval = document.getElementById("cmbbranch").value;
     var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val(); 
	   $("#overlay, #PleaseWait").show();
	   
	  $("#detlist").load("detailedGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&cldocno="+document.getElementById("cldocno").value+"&salesmandoc="+document.getElementById("salesmandoc").value+"&fleet="+document.getElementById("fleet").value+"&status="+document.getElementById("status").value+"&type="+$("#rentaltype").val()+'&outchk='+$("#outchks").val()+'&inchk='+$("#inchks").val()+'&catid='+$("#catid").val());
	
		   }
	}
function getrentaltype() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			var rentaltype  = items.split(",");
			var optionsrental = '<option value="" selected>-- Select -- </option>';
			for (var i = 0; i < rentaltype.length; i++) {
				optionsrental += '<option value="' + rentaltype[i].trim() + '">'
						+ rentaltype[i] + '</option>';
			}
			$("select#rentaltype").html(optionsrental);
			
		} else {
			//alert("Error");
		}
	}
	x.open("GET","getrentaltypes.jsp", true);
	x.send();
}




function  funcleardata()
{
	
	document.getElementById("catid").value="";
	document.getElementById("cldocno").value="";
	document.getElementById("salesmandoc").value="";
	
	

	
	
	document.getElementById("salesman").value="";
	document.getElementById("salesmandoc").value="";
	document.getElementById("fleet").value="";
	document.getElementById("clientname").value="";
	document.getElementById("rentaltype").value="";
	document.getElementById("status").value="";
	document.getElementById("catname").value="";
	//document.getElementById("salesman_txt").value="";
	document.getElementById("ra_no").value="";
	
	
	
	 if (document.getElementById("clientname").value == "") {
			
		 
	        $('#clientname').attr('placeholder', 'Press F3 TO Search'); 
	    }
	/* if (document.getElementById("salesman_txt").value == "") {
			
		 
	        $('#get_docno').attr('placeholder', ''); 
	    }
	    
	     if (document.getElementById("salesmann").value == "") {
			
		 
	        $('#salesmann').attr('placeholder', 'Press F3 TO Search'); 
	    }*/
	 if (document.getElementById("ra_no").value == "") {
			
		 
	        $('#ra_no').attr('placeholder', ''); 
	    }
	 if (document.getElementById("salesman").value == "") {
			
		 
	        $('#salesman').attr('placeholder', 'Press F3 TO Search'); 
	    }
	
	 if (document.getElementById("fleet").value == "") {
			
		 
	        $('#fleet').attr('placeholder', 'Press F3 TO Search'); 
	    }
	 if (document.getElementById("catname").value == "") {
			
		 
	        $('#catname').attr('placeholder', 'Press F3 TO Search'); 
	    }
		$("#detailedGrid").jqxGrid('clear');
	}


</script>
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
    cursor: pointer;
    font-size: 13px;
    font-weight: 600;
    padding: 10px 15px;
    width: 100%;
}

.myButtons:hover, .myButton:hover {
    background-color: #1d4ed8 !important;
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

/* 🔹 Button row (side-by-side) */
.button-row {
    display: flex;
    gap: 6px;
}

/* 🔹 Override full width */
.button-row .myButton {
    width: 50% !important;
    margin: 0 !important;
}
/* 🔹 Inputs smaller width */
.input-cell input {
    width: 160px;   /* adjust: 140px / 160px / 180px */
    height: 24px;
    padding: 0 8px;
    border: 1px solid #ccd6e0;
    border-radius: 4px;
    font-size: 13px;
    box-sizing: border-box;
}

.input-cell select {
    width: 160px;   /* same as your input fields */
    height: 24px;
    padding: 0 6px;
    border: 1px solid #ccd6e0;
    border-radius: 4px;
    font-size: 13px;
    box-sizing: border-box;
}

/* 🔹 inline card (does NOT break layout) */
.inline-card {
    display: inline-block;
    width: 250px; /* 🔥 increased card width */
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 10px;
    padding: 12px 15px;
    margin: 10px 0;
}

/* 🔹 table spacing */
.form-table {
    border-spacing: 0 8px;
}

/* 🔹 labels */
.form-table td:first-child {
    text-align: right;
    padding-right: 10px;
    font-size: 13px;
    font-weight: 600;
    color: #4e5e71;
    width: 90px; /* 🔥 slightly increased for better spacing */
}

/* 🔹 inputs */
.form-table input,
.form-table select {
    width: 100px; /* 🔥 increased field width */
    height: 24px;
    padding: 0 6px;
    border: 1px solid #ccd6e0;
    border-radius: 4px;
    font-size: 13px;
}

/* 🔹 radio row layout */
.radio-row {
    text-align: center;
    padding-top: 6px;
}

/* 🔹 spacing between options */
.radio-row label {
    margin: 0 12px;
    font-size: 13px;
    color: #4e5e71;
    cursor: pointer;
}

/* 🔹 align radio + text nicely */
.radio-row input[type="radio"] {
    margin-right: 4px;
    vertical-align: middle;
}
/* 🔹 label */
.label-cell {
    text-align: right;
    padding-right: 12px;
    font-size: 13px;
    font-weight: 600;
    color: #4e5e71;
    width: 90px;
    vertical-align: middle;
}

/* 🔹 input cell */
.input-cell {
    text-align: left;
}

/* 🔹 fields */
.input-cell input,
.input-cell select {
    width: 180px;
    height: 24px;
    padding: 0 6px;
    border: 1px solid #ccd6e0;
    border-radius: 4px;
    font-size: 13px;
    box-sizing: border-box;
}

/* 🔹 main button style */
.myButtons {
    background-color: #2563eb !important;  /* blue */
    color: #ffffff !important;
    border: none !important;
    border-radius: 4px;
    height: 24px;
    padding: 0 12px;
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
}

/* 🔹 hover */
.myButtons:hover {
    background-color: #1d4ed8 !important;
}/* 🔹 force button style */
input.myButtons {
    background-color: #2563eb !important;
    color: #ffffff !important;
    border: none !important;
    border-radius: 4px !important;
    height: 24px !important;
    padding: 0 12px !important;
    font-size: 13px !important;
    font-weight: 600 !important;
    cursor: pointer !important;
    appearance: none;           /* 🔥 removes browser default grey */
    -webkit-appearance: none;
}

/* 🔹 hover */
input.myButtons:hover {
    background-color: #1d4ed8 !important;
}

/* 🔥 strongest override */
input[type="button"].myButtons,
#clear.myButtons {
    background: #2563eb !important;
    color: #fff !important;
    border: none !important;
    border-radius: 4px !important;
    height: 24px !important;
    padding: 0 12px !important;
    font-size: 13px !important;
    font-weight: 600 !important;
    cursor: pointer !important;
}

/* hover */
input[type="button"].myButtons:hover,
#clear.myButtons:hover {
    background: #1d4ed8 !important;
}

/* 🔹 center button cleanly */
.button-cell {
    text-align: center;
    padding-top: 8px;
}

/* 🔹 fix button width (not full width) */
.button-cell .myButtons {
    width: 120px !important;
    height: 24px !important;
    padding: 0 10px !important;
    background-color: #2563eb !important;
    color: #fff !important;
    border: none !important;
    border-radius: 4px;
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
}

/* 🔹 hover */
.button-cell .myButtons:hover {
    background-color: #1d4ed8 !important;
}

/* 🔹 reduce legend (title) font */
fieldset legend {
    font-size: 16px;   /* 🔻 reduced */
    font-weight: 600;
    color: #4e5e71;
}

/* 🔹 optional: reduce inside text slightly */
fieldset {
    font-size: 12px;
}
</style>
<script>

function funupdate()
{
	
//alert(ra_no);	
	 if(document.getElementById("ra_no").value=="")
	 {
		 $.messager.alert('Message',' select salesman ra_no ','warning');   
					 
		 return 0;
	 }
	 if(document.getElementById("lpo").value=="")
	 {
		 $.messager.alert('Message','select LPO NO ','warning');   
					 
		 return 0;
	 }
	
	
      
     var ra_no = document.getElementById("ra_no").value;
     var lpo = document.getElementById("lpo").value;
     var oldlpo = document.getElementById("oldlpo").value;

	    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
	     	  
		        
	     	if(r==false)
	     	  {
	     		return false; 
	     	  }
	     	else{
	     		 savegriddata(ra_no,lpo,oldlpo);	
	     	}
		     });
	
	
	
}
function savegriddata(ra_no,lpo,oldlpo)
{
	
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		
			var items=x.responseText;
			// alert(items);
			 document.getElementById("ra_no").value="";
			 document.getElementById("lpo").value="";
			 document.getElementById("oldlpo").value="";
			  
			  $.messager.alert('Message', '  Record Successfully Updated ', function(r){
		 		 
		 		 
			     
		     });
			 funreload(event); 
			 $("#detailedGrid").jqxGrid('clear');
			disitems();
			 
			
			}
	}
		
x.open("GET","lposavedata.jsp?ra_no="+ra_no+"&lpo="+encodeURIComponent(lpo)+"&oldlpo="+encodeURIComponent(oldlpo), true);       

x.send();
document.getElementById("lpo").value="";
if (document.getElementById("lpo").value == "") {
	$('#lpo').attr('placeholder', 'Enter LPO No'); 
}
document.getElementById("ra_no").value="";


}

</script>
</head>
<body onload="getBranch();getrentaltype();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #FFFFFF;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	
	  <tr>
    <td class="label-cell">From</td>
    <td class="input-cell">
        <div id="fromdate"></div>
    </td>
</tr>

<tr>
    <td class="label-cell">To</td>
    <td class="input-cell">
        <div id="todate"></div>
    </td>
</tr>
     
	
	 <tr>
    <td class="label-cell">Status</td>
    <td class="input-cell">
        <select id="status" name="status">
            <option value="">All</option>  
            <option value="0">Open</option>
            <option value="1">Close</option>  
        </select>
    </td>
</tr>
 <tr>
    <td class="label-cell">Client</td>
    <td class="input-cell">
        <input type="text" name="clientname" id="clientname"
               placeholder="Press F3 TO Search"
               readonly
               onkeydown="getclinfo(event);"
               onclick="this.placeholder=''"
               value='<s:property value="clientname"/>'>
    </td>
</tr>

<tr>
    <td class="label-cell">Category</td>
    <td class="input-cell">
        <input type="text" name="catname" id="catname"
               placeholder="Press F3 TO Search"
               readonly
               onkeydown="getclcat(event);"
               onclick="this.placeholder=''"
               value='<s:property value="catname"/>'>
    </td>
</tr>

<tr>
    <td class="label-cell">Fleet</td>
    <td class="input-cell">
        <input type="text" name="fleet" id="fleet"
               placeholder="Press F3 TO Search"
               readonly
               onkeydown="getfleet(event)"
               onclick="this.placeholder=''"
               value='<s:property value="fleet"/>'>
    </td>
</tr>

<tr>
    <td class="label-cell">Salesman</td>
    <td class="input-cell">
        <input type="text" name="salesman" id="salesman"
               placeholder="Press F3 TO Search"
               readonly
               onkeydown="getsalesman(event)"
               onclick="this.placeholder=''"
               value='<s:property value="salesman"/>'>
    </td>
</tr>
      
      <tr><td align="right"><label class="branch">&nbsp;</label></td><td align="left">
       <select id="rentaltype" name="rentaltype" style="height:20px;width:70%;" value='<s:property value="rentaltype"/>' hidden="true">
      </select> </td></tr> 
	 <tr><td colspan="2"></td></tr>
	 <tr>
	 <tr>
    <td colspan="2" class="button-cell">
        <input type="button"
               class="myButtons"
               name="clear"
               id="clear"
               value="Clear"
               onclick="funcleardata()">
    </td>
</tr>
<tr><td colspan="2">
	  <tr>
<td colspan="2" align="center">
    <div class="lpo-card">
        <fieldset>
            <legend>LPO NO change</legend>

            <table width="100%" id="lpochange">
<tr>
    <td class="label-cell">LPO NO</td>
    <td class="input-cell">
        <input type="text"
               name="lpo"
               id="lpo"
               placeholder="Enter LPO No"
               value='<s:property value="lpo"/>'>
    </td>
</tr>

<!-- 🔹 hidden fields (FIXED STRUCTURE, NO CHANGE IN FUNCTIONALITY) -->
<input type="hidden" name="ra_no" id="ra_no"
       value='<s:property value="ra_no"/>'>

<input type="hidden" name="oldlpo" id="oldlpo"
       value='<s:property value="oldlpo"/>'>
      
      <tr>
	<tr>
    <td colspan="2" class="button-cell">
        <input type="button"
               class="myButtons"
               name="update"
               id="update"
               value="Update"
               onclick="funupdate()">
    </td>
</tr><tr><td colspan="2"></td></tr>                 
    </table>               
      </fieldset> 
	<tr>
	<td colspan="2">&nbsp;</div></td> 
	</tr>
	<!-- <tr>
	<td colspan="2"><div id='paychaaaaa' style="width: 100% ; align:right; height: 100px;"></div></td> 
	</tr> -->	
	</table>
	</fieldset>
		<input type="hidden" name="cldocno" id="cldocno"  style="height:20px;width:70%;" value='<s:property value="cldocno"/>'>
	        <input type="hidden" name="salesmandoc" id="salesmandoc"  style="height:20px;width:70%;" value='<s:property value="salesmandoc"/>'>
	         <input type="hidden" name="catid" id="catid"  style="height:20px;width:70%;" value='<s:property value="catid"/>'>	
</td>
<td width="80%">
	<table width="100%">
		<tr>
		   <td><div id="detlist"><jsp:include page="detailedGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>

</div>

<div id="catwindow">
   <div ></div>
</div>

<div id="clientwindow">
   <div ></div>
</div>
<div id="fleetwindow">
   <div ></div>
</div>
<div id="salesmanwindow">
   <div ></div>
</div>
<div id="lpowindow">
   <div ></div>
</div>

</div>
</body>
</html>
	 