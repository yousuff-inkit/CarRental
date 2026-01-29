
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
</style>
 
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
	   //$("#detailsgrid").jqxGrid('exportdata', 'xls', 'Rental List');
	   
	   $("#detlist").excelexportjs({  
       		containerid: "detlist", 
       		datatype: 'json', 
       		dataset: null, 
       		gridId: "detailsgrid", 
       		columns: getColumns("detailsgrid") , 
       		worksheetName:"Rental List"
       		}); 
		// JSONToCSVCon(dataildata, 'Rental List', true);
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
	   $("#overlay, #PleaseWait").show();
	   var salesman=$('#hidsalesman').val();
	  $("#detlist").load("detailsGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&cldocno="+document.getElementById("cldocno").value+"&group="+document.getElementById("groupdoc").value+"&model="+document.getElementById("modelid").value+"&brand="+document.getElementById("brandid").value+"&fleet="+document.getElementById("fleet").value+"&status="+document.getElementById("status").value+"&type="+$("#rentaltype").val()+'&outchk='+$("#outchks").val()+'&inchk='+$("#inchks").val()+'&catid='+$("#catid").val()+'&salesman='+salesman);
	
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
	}


</script>

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
</head>
<body onload="getBranch();getrentaltype();">

<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ================= LEFT PANEL (20%) ================= -->
<td width="20%">

<div class="master-container">
<div class="sidebar-filters">

    <!-- ===== FIXED HEADING ===== -->
    <div class="sidebar-fixed-top">
        <div class="filter-card">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>
    </div>

    <!-- ===== SCROLLABLE FILTER CONTENT ===== -->
    <div class="sidebar-scroll-content">
        <div class="filter-card">

            <table class="filter-table">

                <tr>
                    <td colspan="2">
                        <input type="radio" name="chk" id="outchk" value="out"
                               checked="checked" onchange="funchkval()">
                        <label>Out Date</label>
                        &nbsp;&nbsp;
                        <input type="radio" name="chk" id="inchk" value="in"
                               onchange="funchkval()">
                        <label>In Date</label>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">From</td>
                    <td><div id="fromdate" name="fromdate"
                             value='<s:property value="fromdate"/>'></div></td>
                </tr>

                <tr>
                    <td class="label-cell">To</td>
                    <td><div id="todate" name="todate"
                             value='<s:property value="todate"/>'></div></td>
                </tr>

                <tr>
                    <td class="label-cell">Status</td>
                    <td>
                        <select id="status" name="status">
                            <option value="" selected>All</option>
                            <option value="0">Open</option>
                            <option value="1">Close</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Client</td>
                    <td>
                        <input type="text" id="clientname" name="clientname"
                               placeholder="Press F3 To Search"
                               readonly
                               onkeydown="getclinfo(event);"
                               value='<s:property value="clientname"/>'>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Category</td>
                    <td>
                        <input type="text" id="catname" name="catname"
                               placeholder="Press F3 To Search"
                               readonly
                               onkeydown="getclcat(event);"
                               value='<s:property value="catname"/>'>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Fleet</td>
                    <td>
                        <input type="text" id="fleet" name="fleet"
                               placeholder="Press F3 To Search"
                               readonly
                               onkeydown="getfleet(event)"
                               value='<s:property value="fleet"/>'>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Group</td>
                    <td>
                        <input type="text" id="group" name="group"
                               placeholder="Press F3 To Search"
                               readonly
                               onkeydown="getgroup(event)"
                               value='<s:property value="group"/>'>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Brand</td>
                    <td>
                        <input type="text" id="brand" name="brand"
                               placeholder="Press F3 To Search"
                               readonly
                               onkeydown="getbrand(event)"
                               value='<s:property value="brand"/>'>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Model</td>
                    <td>
                        <input type="text" id="model" name="model"
                               placeholder="Press F3 To Search"
                               readonly
                               onkeydown="getmodel(event)"
                               value='<s:property value="model"/>'>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Type</td>
                    <td>
                        <select id="rentaltype" name="rentaltype"></select>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Salesman</td>
                    <td>
                        <input type="text" id="salesman" name="salesman"
                               placeholder="Press F3 To Search"
                               readonly
                               onkeydown="getSalesman(event)"
                               value='<s:property value="salesman"/>'>
                    </td>
                </tr>

            </table>
        </div>

        <!-- ===== ACTION BUTTON ===== -->
        <button class="btn-submit" type="button" onclick="funcleardata();">
            Clear
        </button>

        <div id="paychaaaaa" style="height:50px;"></div>

    </div>
</div>
</div>

<!-- ===== HIDDEN FIELDS (UNCHANGED) ===== -->
<input type="hidden" id="outchks" name="outchks" value='<s:property value="outchks"/>'>
<input type="hidden" id="inchks" name="inchks" value='<s:property value="inchks"/>'>
<input type="hidden" id="cldocno" name="cldocno" value='<s:property value="cldocno"/>'>
<input type="hidden" id="groupdoc" name="groupdoc" value='<s:property value="groupdoc"/>'>
<input type="hidden" id="brandid" name="brandid" value='<s:property value="brandid"/>'>
<input type="hidden" id="modelid" name="modelid" value='<s:property value="modelid"/>'>
<input type="hidden" id="catid" name="catid" value='<s:property value="catid"/>'>
<input type="hidden" id="hidsalesman" name="hidsalesman" value='<s:property value="hidsalesman"/>'>

</td>

<!-- ================= RIGHT PANEL (80%) ================= -->
<td width="80%">
    <table width="100%">
        <tr>
            <td>
                <div id="detlist">
                    <jsp:include page="detailsGrid.jsp"></jsp:include>
                </div>
            </td>
        </tr>
    </table>
</td>

</tr>
</table>

</div>

<!-- ===== POPUP WINDOWS (UNCHANGED) ===== -->
<div id="catwindow"><div></div></div>
<div id="clientwindow"><div></div></div>
<div id="fleetwindow"><div></div></div>
<div id="groupwindow"><div></div></div>
<div id="brandwindow"><div></div></div>
<div id="modelwindow"><div></div></div>
<div id="salesmanwindow"><div></div></div>

</div>
</body>

</html>
	 