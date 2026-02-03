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
	   $('#salesmanwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Salesman Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#salesmanwindow').jqxWindow('close');
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
	         $("#detlist").excelexportjs({
				containerid: "detlist", 
				datatype: 'json', 
				dataset: null, 
				gridId: "detailedGrid", 
				columns: getColumns("detailedGrid") , 
				worksheetName:"MRA Number"
				});
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
	document.getElementById("clientname").value="";
	document.getElementById("catid").value="";
	document.getElementById("cldocno").value="";
	document.getElementById("salesmandoc").value="";
	document.getElementById("salesman").value="";
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
	 if (document.getElementById("ra_no").value == "") {
			
		 
	        $('#ra_no').attr('placeholder', ' '); 
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
<script>

function funupdate()
{
	
//alert(ra_no);	
	 if(document.getElementById("ra_no").value=="")
	 {
		 $.messager.alert('Message',' select salesman ra_no ','warning');   
					 
		 return 0;
	 }
	 if(document.getElementById("mrano").value=="")
	 {
		 $.messager.alert('Message','select MRA NO ','warning');   
					 
		 return 0;
	 }
	
	
      
     var ra_no = document.getElementById("ra_no").value;
     var mrano = document.getElementById("mrano").value;
     var oldmrano = document.getElementById("oldmrano").value;
     var reftypes = document.getElementById("reftypes").value;

	    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
	     	  
		        
	     	if(r==false)
	     	  {
	     		return false; 
	     	  }
	     	else{
	     		 savegriddata(ra_no,mrano,oldmrano,reftypes);	
	     	}
		     });
	
	
	
}
function savegriddata(ra_no,mrano,oldmrano,reftypes)
{
	
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		
			var items=x.responseText;
			// alert(items);
			 document.getElementById("ra_no").value="";
			 document.getElementById("mrano").value="";
			 document.getElementById("oldmrano").value="";
			 document.getElementById("reftypes").value="";
			  
			  $.messager.alert('Message', '  Record Successfully Updated ', function(r){
		 		 
		 		 
			     
		     });
			 funreload(event); 
			 $("#detailedGrid").jqxGrid('clear');
			disitems();
			 
			
			}
	}
		
x.open("GET","mranosavedata.jsp?ra_no="+ra_no+"&mrano="+mrano+"&oldmrano="+oldmrano+"&reftypes="+reftypes);

x.send();
document.getElementById("mrano").value="";
if (document.getElementById("mrano").value == "") {
	
	 
    $('#mrano').attr('placeholder', 'Enter MRA No'); 
}
document.getElementById("ra_no").value="0";


}

</script>
</head>
<body onload="getBranch();getrentaltype();">

<div id="mainBG" class="homeContent">
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ================= LEFT SIDEBAR ================= -->
<td width="20%">
<div class="master-container">
<div class="sidebar-filters">

    <!-- Fixed Heading -->
    <div class="sidebar-fixed-top">
        <div class="filter-card">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>
    </div>

    <!-- Scrollable Filters -->
    <div class="sidebar-scroll-content">

        <!-- Date Filters -->
        <div class="filter-card">
            <table class="mra-filter-table">
                <tr>
                    <td class="label-cell">From</td>
                    <td><div id="fromdate"></div></td>
                </tr>
                <tr>
                    <td class="label-cell">To</td>
                    <td><div id="todate"></div></td>
                </tr>
            </table>
        </div>

        <!-- Main Filters -->
        <div class="filter-card">
            <table class="mra-filter-table">

                <tr>
                    <td class="label-cell">Status</td>
                    <td>
                        <select id="status" name="status">
                            <option value="">All</option>
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
                               readonly onkeydown="getclinfo(event);">
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Category</td>
                    <td>
                        <input type="text" id="catname" name="catname"
                               placeholder="Press F3 To Search"
                               readonly onkeydown="getclcat(event);">
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Fleet</td>
                    <td>
                        <input type="text" id="fleet" name="fleet"
                               placeholder="Press F3 To Search"
                               readonly onkeydown="getfleet(event);">
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Salesman</td>
                    <td>
                        <input type="text" id="salesman" name="salesman"
                               placeholder="Press F3 To Search"
                               readonly onkeydown="getsalesman(event);">
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Type</td>
                    <td>
                        <select id="rentaltype" name="rentaltype"></select>
                    </td>
                </tr>

            </table>

            <div class="mra-actions">
                <button type="button"
                        class="btn-submit"
                        onclick="funcleardata();">
                    Clear
                </button>
            </div>
        </div>

        <!-- MRA No Change -->
        <div class="filter-card mra-change-card">
            <div class="mra-change-title">MRA No Change</div>

            <table class="mra-filter-table">
                <tr>
                    <td class="label-cell">MRA No</td>
                    <td>
                        <input type="text" id="mrano" name="mrano"
                               placeholder="Enter MRA No">
                    </td>
                </tr>
            </table>

            <div class="mra-actions">
                <button type="button"
                        class="btn-submit"
                        onclick="funupdate();">
                    Update
                </button>
            </div>
        </div>

        <!-- Placeholder -->
        <div class="filter-card">
            <div id="paychaaaaa"></div>
        </div>

        <!-- Hidden Fields -->
        <input type="hidden" id="ra_no" name="ra_no">
        <input type="hidden" id="oldmrano" name="oldmrano">
        <input type="hidden" id="cldocno" name="cldocno">
        <input type="hidden" id="salesmandoc" name="salesmandoc">
        <input type="hidden" id="catid" name="catid">
        <input type="hidden" id="reftypes" name="reftypes">

    </div>
</div>
</div>
</td>

<!-- ================= RIGHT GRID ================= -->
<td width="80%">
    <div id="detlist">
        <jsp:include page="detailedGrid.jsp"></jsp:include>
    </div>
</td>

</tr>
</table>

</div>

<!-- POPUP WINDOWS -->
<div id="catwindow"><div></div></div>
<div id="clientwindow"><div></div></div>
<div id="fleetwindow"><div></div></div>
<div id="salesmanwindow"><div></div></div>

</div>
</body>
</html>
	 