
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
    /* Force high-visibility and reset legacy backgrounds */
    html, body {
        height: 100% !important;
        margin: 0 !important;
        padding: 0 !important;
        overflow: hidden !important;
        background-color: #f4f7f9;
    }

    .master-container {
        display: flex;
        font-family: 'Segoe UI', Tahoma, sans-serif !important;
        width: 100%;
        height: 100vh !important;
        color: black !important;
    }

    /* Sidebar Structure */
    .sidebar-filters {
        width: 330px; 
        flex: 0 0 330px;
        background-color: #ffffff;
        border-right: 1px solid #e1e8ed;
        display: flex;
        flex-direction: column;
        z-index: 10;
        box-shadow: 2px 0 8px rgba(0,0,0,0.05);
        height: 100vh !important;
    }

    .sidebar-fixed-top {
        padding: 20px 20px 15px 20px;
        background-color: #ffffff;
        border-bottom: 1px solid #f0f4f8;
        flex-shrink: 0;
    }

    .sidebar-scroll-content {
        flex: 1;
        overflow-y: auto;
        padding: 15px 20px 25px 20px;
    }

    /* Cleaned Card Styling */
    .filter-card {
        background-color: #f8fafc !important;
        border: 1px solid #e3e8ee !important;
        border-radius: 12px !important;
        padding: 15px;
        margin-bottom: 10px;
    }

    /* Reset legacy styles and force black text */
    .filter-card *, fieldset, legend, .branch, td, tr, label, span {
        background-color: transparent !important;
        background: none !important;
        color: black !important;
    }

    .filter-table { 
        width: 100%; 
        border-spacing: 0 10px; 
    }

    .label-cell {
        text-align: right;
        padding-right: 12px;
        font-size: 13px;
        font-weight: 600;
        width: 85px;
    }

    /* RHS Grid Area & Scroll Fix */
    .main-content-wrapper {
        flex: 1;
        display: flex;
        flex-direction: column;
        height: 100vh;
        width: 100%;
        max-width: calc(100vw - 330px);
        overflow: hidden !important; 
        position: relative;
        background-color: #ffffff;
    }

    .scrollable-grid-area {
        flex: 1;
        overflow-y: auto !important;
        overflow-x: hidden !important; 
        padding: 20px;
    }

    /* Chart and Subgrid Container Styling */
    #paychaaaaa, #Readygrid {
        background-color: #ffffff !important;
        border: 1px solid #e3e8ee;
        border-radius: 8px;
        margin-top: 15px;
        overflow: hidden;
    }

    .branch { font-size: 13px; font-weight: 600; }
</style>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<div class="master-container">
    <div class="sidebar-filters">
        <div class="sidebar-fixed-top">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>

        <div class="sidebar-scroll-content">
            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">From Date</td>
                        <td>
                            <div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">To Date</td>
                        <td>
                            <div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                        </td>
                    </tr>
                </table>
            </div>

            <div id="Readygrid">
                <jsp:include page="subgrid.jsp"></jsp:include>
            </div>

            <div id='paychaaaaa' style="width: 100%; height: 170px;"></div>
        </div>
    </div>

    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="booklistdiv">
                <jsp:include page="bookinglistGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>
</div>
</div>
</div>
</body>
</html>