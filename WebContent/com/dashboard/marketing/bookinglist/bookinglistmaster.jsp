
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
	
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");


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



/* function funExportBtn(){
	   $("#booklistgrid").jqxGrid('exportdata', 'xls', 'Booking List');
	 } */
	 
	 function funExportBtn(){
			$("#booklistdiv").excelexportjs({
				containerid: "booklistdiv", 
				datatype: 'json', 
				dataset: null, 
				gridId: "booklistgrid", 
				columns: getColumns("booklistgrid") ,   
				worksheetName:"Booking List"
				});
			
		}
function funreload(event)
{
	var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));


//out date
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
	 // $("#overlay, #PleaseWait").show();
 
	 // $("#booklistdiv").load("bookinglistGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate);
	 $("#Readygrid").load("subgrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate);
	
	   }
	}

</script>
</head>
<style type="text/css">
 
.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
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
<body onload="getBranch();">

<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

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
                            <td>
                                <div id='fromdate'></div>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">To Date</td>
                            <td>
                                <div id='todate'></div>
                            </td>
                        </tr>
                    </table>
                </div>

                <div class="filter-card">
                    <div id="Readygrid">
                        <jsp:include page="subgrid.jsp"></jsp:include>
                    </div>
                </div>

                <div class="filter-card">
                    <div id='paychaaaaa' style="width:100%; height:170px;"></div>
                </div>

            </div>
        </div>
    </div>

</td>

<td width="80%" valign="top">

    <table width="100%">
        <tr>
            <td>
                <div id="booklistdiv">
                    <jsp:include page="bookinglistGrid.jsp"></jsp:include>
                </div>
            </td>
        </tr>
    </table>

</td>

</tr>
</table>

</div>
</div>

</body>
</html>