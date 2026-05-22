
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
	   $('#groupwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Group Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#groupwindow').jqxWindow('close');
	   $('#brandwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Brand Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#brandwindow').jqxWindow('close');
	   $('#modelwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Model Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#modelwindow').jqxWindow('close');
	   $('#salesmanwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Salesman Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#salesmanwindow').jqxWindow('close');
	   $('#rentalagentWindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Salesman Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#rentalagentWindow').jqxWindow('close');
	   $('#catwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: ' Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#catwindow').jqxWindow('close');
	   
	   
	   
	   $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	   
		document.getElementById('inchks').value=""; 
		document.getElementById('outchks').value="OUT"; 
	   
		$('#salesman').dblclick(function(){
	  	    $('#salesmanwindow').jqxWindow('open');
	  	  salesmanSearchContent('salesmanSearch.jsp?', $('#salesmanwindow')); 
      });
		$('#rentalagent').dblclick(function(){
	  	    $('#rentalagentWindow').jqxWindow('open');
	  	  rentalagentSearchContent('rentalAgentSearch.jsp?', $('#rentalagentWindow')); 
      });
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
	    $('#group').dblclick(function(){
	  	    $('#groupwindow').jqxWindow('open');
	   
	       groupSearchContent('groupsearch.jsp?', $('#groupwindow')); 
       });
	    $('#brand').dblclick(function(){
	  	    $('#brandwindow').jqxWindow('open');
	   
	       brandSearchContent('brandsearch.jsp?', $('#brandwindow')); 
      });
	   $('#model').dblclick(function(){
	  	    $('#modelwindow').jqxWindow('open');
	   
	  	  modelSearchContent('modelsearch.jsp?', $('#modelwindow')); 
       }); 
	   
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
	//alert(exceldata);
	JSONToCSVCon(exceldata, 'RA Tariff List', true);
	 }
	 
function getRentalAgent(event){
	var x= event.keyCode;
	 if(x==114){
		 $('#rentalagentWindow').jqxWindow('open');
		 rentalagentSearchContent('rentalAgentSearch.jsp', $('#rentalagentWindow'));
	 }
	 else{
		 }
}
function rentalagentSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 $('#rentalagentWindow').jqxWindow('open');
		$('#rentalagentWindow').jqxWindow('setContent', data);

	}); 
	}
	
function getSalesman(event){
	 var x= event.keyCode;
	 if(x==114){
		 $('#salesmanwindow').jqxWindow('open');
		 salesmanSearchContent('salesmanSearch.jsp', $('#salesmanwindow'));
	 }
	 else{
		 }
	 } 

function getclcat(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#catwindow').jqxWindow('open');
	  catnameSearchContent('categorysearch.jsp?', $('#catwindow'));    }
	 else{
		 }
	 } 
	 
function getbrand(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#brandwindow').jqxWindow('open');
	brandSearchContent('brandsearch.jsp?', $('#brandwindow'));    }
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
function catnameSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#catwindow').jqxWindow('open');
		$('#catwindow').jqxWindow('setContent', data);

	}); 
	}  
	 
function modelSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#modelwindow').jqxWindow('open');
		$('#modelwindow').jqxWindow('setContent', data);

	}); 
	} 
function getbrand(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#brandwindow').jqxWindow('open');
	brandSearchContent('brandsearch.jsp?', $('#brandwindow'));    }
	 else{
		 }
	 } 
function brandSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#brandwindow').jqxWindow('open');
		$('#brandwindow').jqxWindow('setContent', data);

	}); 
	} 
function getgroup(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#groupwindow').jqxWindow('open');


	groupSearchContent('groupsearch.jsp?', $('#groupwindow'));    }
	 else{
		 }
	 } 
function groupSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#groupwindow').jqxWindow('open');
		$('#groupwindow').jqxWindow('setContent', data);

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
	 var ragent=$('#hidrentalagent').val();
	   $("#overlay, #PleaseWait").show();
	   var salesman=$('#hidsalesman').val();
	  $("#detlist").load("detailsGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&cldocno="+document.getElementById("cldocno").value+"&group="+document.getElementById("groupdoc").value+"&model="+document.getElementById("modelid").value+"&brand="+document.getElementById("brandid").value+"&fleet="+document.getElementById("fleet").value+"&status="+document.getElementById("status").value+"&type="+$("#rentaltype").val()+'&outchk='+$("#outchks").val()+'&inchk='+$("#inchks").val()+'&catid='+$("#catid").val()+'&salesman='+salesman+'&ragent='+ragent);
	  
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
	document.getElementById("groupdoc").value="";
	document.getElementById("groupdoc").value="";
	document.getElementById("brandid").value="";
	document.getElementById("modelid").value="";
	
	document.getElementById("model").value="";
	document.getElementById("brand").value="";
	
	document.getElementById("group").value="";
	document.getElementById("fleet").value="";
	document.getElementById("clientname").value="";
	document.getElementById("rentaltype").value="";
	document.getElementById("status").value="";
	document.getElementById("catname").value="";
	document.getElementById("salesman").value="";
	document.getElementById("hidsalesman").value="";
	document.getElementById("rentalagent").value="";
	document.getElementById("hidrentalagent").value="";
	
	
	 if (document.getElementById("clientname").value == "") {
			
		 
	        $('#clientname').attr('placeholder', 'Press F3 TO Search'); 
	    }
	 if (document.getElementById("model").value == "") {
			
		 
	        $('#model').attr('placeholder', 'Press F3 TO Search'); 
	    }
	 if (document.getElementById("brand").value == "") {
			
		 
	        $('#brand').attr('placeholder', 'Press F3 TO Search'); 
	    }
	 if (document.getElementById("group").value == "") {
			
		 
	        $('#group').attr('placeholder', 'Press F3 TO Search'); 
	    }
	 if (document.getElementById("fleet").value == "") {
			
		 
	        $('#fleet').attr('placeholder', 'Press F3 TO Search'); 
	    }
	 if (document.getElementById("catname").value == "") {
			
		 
	        $('#catname').attr('placeholder', 'Press F3 TO Search'); 
	    }
	 if (document.getElementById("salesman").value == "") {
			
		 
	        $('#salesman').attr('placeholder', 'Press F3 TO Search'); 
	    }
	 if (document.getElementById("rentalagent").value == "") {
			
	        $('#rentalagent').attr('placeholder', 'Press F3 TO Search'); 
	    }
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


	
      

</style>
<script>
function funchkval(){
if (document.getElementById('outchk').checked) {
	
	

	
	document.getElementById('inchks').value=""; 
	document.getElementById('outchks').value="OUT"; 
	
	
	
	}
else if (document.getElementById('inchk').checked) {

	document.getElementById('inchks').value="IN"; 
	document.getElementById('outchks').value=""; 
	
}
}
</script>
<style type="text/css">
/* ===== MASTER LAYOUT ===== */
html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
}

.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    background-color: #f4f7f9;
}

/* Sidebar dynamically fills the left TD */
.sidebar-filters {
    width: 100%;
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
    padding: 15px 20px 15px; 
}

.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 12px;
    margin-bottom: 12px;
}

.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.label-cell {
    text-align: right;
    padding-right: 12px;
    font-size: 12px; 
    font-weight: 600;
    color: #4e5e71;
    width: 90px;
}

/* ===== UNIFORM 24px TEXT INPUTS ===== */
input[type="text"], select {
    width: 100%;
    height: 24px !important;             
    padding: 2px 8px !important;         
    border: 1px solid #ccd6e0 !important;
    border-radius: 4px !important;       
    font-size: 12px !important;          
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
    outline: none;
}

select {
    padding: 2px 24px 2px 8px !important; 
    font-family: inherit;
    cursor: pointer;
    appearance: none;
    -webkit-appearance: none;
    background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%234e5e71' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
    background-repeat: no-repeat;
    background-position: right 6px center;
    background-size: 12px;
}

input[readonly],
input:disabled,
select:disabled {
    background-color: #ffffff !important;
    color: #555;
    cursor: text !important;
}

/* ===== BUTTONS ===== */
.button-group {
    display: flex;
    gap: 10px;
    justify-content: center;
}

.btn-submit {
    flex: 1;
    width: 100%;
    height: 30px !important;            
    padding: 0 12px !important;
    background: #2563eb !important;
    color: #fff !important;
    border: none !important;
    border-radius: 4px !important;
    font-size: 13px !important;
    font-weight: 600 !important;
    cursor: pointer;
    line-height: 30px !important;
    white-space: nowrap;
    text-align: center;
    margin-top: 8px;
    transition: all 0.2s ease;
}

.btn-submit:hover {
    background: #1d4ed8 !important;
}

/* Layout Utilities */
.main-content-wrapper {
    flex: 1;
    width: 100%;
    display: flex;
    flex-direction: column;
    padding: 15px 20px;
    background: #fff;
    height: 100vh;
    box-sizing: border-box;
}

.scrollable-grid-area {
    flex: 1;
    width: 100%;
    overflow: auto;
}

input[type="radio"], input[type="checkbox"] {
    margin: 0 4px 0 0;
    vertical-align: middle;
}

.radio-group {
    display: flex;
    justify-content: center;
    gap: 15px;
    margin-bottom: 12px;
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
}

.radio-group label {
    display: flex;
    align-items: center;
    cursor: pointer;
}

.sidebar-filters label.branch {
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
    background: transparent !important;
}
</style>

</head>
<body onload="getBranch();getrentaltype();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<div class="master-container">

    <!-- LEFT SIDE -->
    <div class="sidebar-filters" style="width:20%; min-width:300px;">

        <div class="sidebar-fixed-top">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>

        <div class="sidebar-scroll-content">

            <div class="filter-card">

                <table class="filter-table">

                    <!-- DATE TYPE -->
                    <tr>
                        <td colspan="2">

                            <div class="radio-group">

                                <label class="branch" style="display:flex; align-items:center; gap:6px;">

                                    <input type="radio"
                                           name="chk"
                                           checked="checked"
                                           id="outchk"
                                           value="out"
                                           onchange="funchkval()">

                                    Out Date

                                </label>


                                <label class="branch" style="display:flex; align-items:center; gap:6px;">

                                    <input type="radio"
                                           name="chk"
                                           id="inchk"
                                           value="in"
                                           onchange="funchkval()">

                                    In Date

                                </label>

                            </div>

                        </td>
                    </tr>


                    <!-- FROM -->
                    <tr>

                        <td class="label-cell">
                            <label class="branch">From</label>
                        </td>

                        <td>
                            <div id="fromdate"
                                 name="fromdate"
                                 value='<s:property value="fromdate"/>'>
                            </div>
                        </td>

                    </tr>


                    <!-- TO -->
                    <tr>

                        <td class="label-cell">
                            <label class="branch">To</label>
                        </td>

                        <td>
                            <div id="todate"
                                 name="todate"
                                 value='<s:property value="todate"/>'>
                            </div>
                        </td>

                    </tr>


                    <!-- STATUS -->
                    <tr>

                        <td class="label-cell">
                            <label class="branch">Status</label>
                        </td>

                        <td>

                            <select id="status"
                                    name="status"
                                    value='<s:property value="status"/>'>

                                <option value="" selected>All</option>
                                <option value="0">Open</option>
                                <option value="1">Close</option>

                            </select>

                        </td>

                    </tr>


                    <!-- CLIENT -->
                    <tr>

                        <td class="label-cell">
                            <label class="branch">Client</label>
                        </td>

                        <td>

                            <input type="text"
                                   name="clientname"
                                   id="clientname"
                                   readonly="readonly"
                                   placeholder="Press F3 TO Search"
                                   onkeydown="getclinfo(event);"
                                   onclick="this.placeholder=''"
                                   value='<s:property value="clientname"/>'>

                        </td>

                    </tr>


                    <!-- CATEGORY -->
                    <tr>

                        <td class="label-cell">
                            <label class="branch">Category</label>
                        </td>

                        <td>

                            <input type="text"
                                   name="catname"
                                   id="catname"
                                   readonly="readonly"
                                   placeholder="Press F3 TO Search"
                                   onkeydown="getclcat(event);"
                                   onclick="this.placeholder=''"
                                   value='<s:property value="catname"/>'>

                        </td>

                    </tr>


                    <!-- FLEET -->
                    <tr>

                        <td class="label-cell">
                            <label class="branch">Fleet</label>
                        </td>

                        <td>

                            <input type="text"
                                   name="fleet"
                                   id="fleet"
                                   readonly="readonly"
                                   placeholder="Press F3 TO Search"
                                   onkeydown="getfleet(event)"
                                   onclick="this.placeholder=''"
                                   value='<s:property value="fleet"/>'>

                        </td>

                    </tr>


                    <!-- GROUP -->
                    <tr>

                        <td class="label-cell">
                            <label class="branch">Group</label>
                        </td>

                        <td>

                            <input type="text"
                                   name="group"
                                   id="group"
                                   readonly="readonly"
                                   placeholder="Press F3 TO Search"
                                   onkeydown="getgroup(event)"
                                   onclick="this.placeholder=''"
                                   value='<s:property value="group"/>'>

                        </td>

                    </tr>


                    <!-- BRAND -->
                    <tr>

                        <td class="label-cell">
                            <label class="branch">Brand</label>
                        </td>

                        <td>

                            <input type="text"
                                   name="brand"
                                   id="brand"
                                   readonly="readonly"
                                   placeholder="Press F3 TO Search"
                                   onkeydown="getbrand(event)"
                                   onclick="this.placeholder=''"
                                   value='<s:property value="brand"/>'>

                        </td>

                    </tr>


                    <!-- MODEL -->
                    <tr>

                        <td class="label-cell">
                            <label class="branch">Model</label>
                        </td>

                        <td>

                            <input type="text"
                                   name="model"
                                   id="model"
                                   readonly="readonly"
                                   placeholder="Press F3 TO Search"
                                   onkeydown="getmodel(event)"
                                   onclick="this.placeholder=''"
                                   value='<s:property value="model"/>'>

                        </td>

                    </tr>


                    <!-- TYPE -->
                    <tr>

                        <td class="label-cell">
                            <label class="branch">Type</label>
                        </td>

                        <td>

                            <select id="rentaltype"
                                    name="rentaltype"
                                    value='<s:property value="rentaltype"/>'>
                            </select>

                        </td>

                    </tr>


                    <!-- SALESMAN -->
                    <tr>

                        <td class="label-cell">
                            <label class="branch">Salesman</label>
                        </td>

                        <td>

                            <input type="text"
                                   name="salesman"
                                   id="salesman"
                                   readonly="readonly"
                                   placeholder="Press F3 To Search"
                                   onkeydown="getSalesman(event)"
                                   onclick="this.placeholder=''"
                                   value='<s:property value="salesman"/>'>

                        </td>

                    </tr>


                    <!-- RENTAL AGENT -->
                    <tr>

                        <td class="label-cell">
                            <label class="branch">Rental Agent</label>
                        </td>

                        <td>

                            <input type="text"
                                   name="rentalagent"
                                   id="rentalagent"
                                   readonly="readonly"
                                   placeholder="Press F3 To Search"
                                   onkeydown="getRentalAgent(event)"
                                   onclick="this.placeholder=''"
                                   value='<s:property value="rentalagent"/>'>

                        </td>

                    </tr>

                </table>


                <!-- BUTTON -->
                <div style="margin-top:18px;">

                    <input type="button"
                           class="btn-submit"
                           name="clear"
                           id="clear"
                           value="Clear"
                           onclick="funcleardata()"
                           style="background:#64748b !important;">

                </div>


                <!-- SPACER -->
                <div id="paychaaaaa" style="
                    width:100%;
                    height:10px;
                "></div>

            </div>

        </div>

    </div>



    <!-- RIGHT SIDE -->
    <div class="main-content-wrapper">

        <div class="scrollable-grid-area">

            <div id="detlist">

                <jsp:include page="detailsGrid.jsp"></jsp:include>

            </div>

        </div>

    </div>

</div>



<!-- HIDDEN FIELDS -->
<input type="hidden" name="hidsalesman" id="hidsalesman" value='<s:property value="hidsalesman"/>'>

<input type="hidden" name="hidrentalagent" id="hidrentalagent" value='<s:property value="hidrentalagent"/>'>

<input type="hidden" name="outchks" id="outchks" value='<s:property value="outchks"/>'>

<input type="hidden" name="inchks" id="inchks" value='<s:property value="inchks"/>'>

<input type="hidden" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>'>

<input type="hidden" name="groupdoc" id="groupdoc" value='<s:property value="groupdoc"/>'>

<input type="hidden" name="brandid" id="brandid" value='<s:property value="brandid"/>'>

<input type="hidden" name="modelid" id="modelid" value='<s:property value="modelid"/>'>

<input type="hidden" name="catid" id="catid" value='<s:property value="catid"/>'>

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
<div id="groupwindow">
   <div ></div>
</div>
<div id="brandwindow">
   <div ></div>
</div>
<div id="modelwindow">
   <div ></div>
</div>
<div id="salesmanwindow">
   <div ></div>
</div>
<div id="rentalagentWindow">
   <div ></div>
</div>
</div>
</body>
</html>
	 