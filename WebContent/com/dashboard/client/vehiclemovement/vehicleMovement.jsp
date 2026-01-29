
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
	
	
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	 $('#clientwindow').jqxWindow({ width: '30%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Client Search' , position: { x: 200, y: 60 }, keyboardCloseKey: 27});
	 $('#clientwindow').jqxWindow('close');
	     
	     
	     
	 $('#client').dblclick(function(){
	  	    $('#clientwindow').jqxWindow('open');
	   
	  	  clientSearchContent('clientSearch.jsp?', $('#clientwindow')); 
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




function clientSearchContent(url) {
 	 //alert(url);
 		 $.get(url).done(function (data) {
 			 
 			 $('#clientwindow').jqxWindow('open');
 		$('#clientwindow').jqxWindow('setContent', data);
 
 	}); 
 	} 

function getClientData(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#clientwindow').jqxWindow('open');


	  clientSearchContent('clientSearch.jsp?', $('#clientwindow'));     }
	 else{
		 }
	 }

function funreload(event)
{
	 var client = document.getElementById("hidclient").value;

	 if(client=="")
		 {
		   $.messager.alert('Message','Search Client  ','warning'); 
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
		 
     var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val();
	  $("#vehiclediv").load("vehicleMovementGrid.jsp?client="+client+"&fromdate="+fromdate+"&todate="+todate);
	  $("#vehiclesummdiv").load("vehicleSummaryGrid.jsp?client="+client+"&fromdate="+fromdate+"&todate="+todate+"&ready=1");
		   }
		 }
	
	}
function hiddenbrh(){
	
	$("#branchlabel").attr('hidden',true);
	$("#branchdiv").attr('hidden',true);
	
}

function funPrintMov(){
	var client = document.getElementById("hidclient").value;

	 if(client=="")
		 {
		   $.messager.alert('Message','Search Client  ','warning'); 
		   return false;
		 }
	 else
		 {
    var url=document.URL;
    var reurl=url.split("vehicleMovement.jsp");
  
    var win= window.open(reurl[0]+"printClientVehicleMov?client="+document.getElementById("hidclient").value+'&fromdate='+$("#fromdate").val()+'&todate='+$("#todate").val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
    win.focus();
		 }
}

</script>
</head>

<style type="text/css">
    /* Layout & Sidebar Structure */
    .master-container {
        display: flex;
        font-family: 'Segoe UI', Tahoma, sans-serif !important;
        background-color: #f4f7f9;
        width: 100%;
        height: 100vh !important;
        overflow: hidden !important;
        color: black !important;
    }

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

    /* Cleaned Cards */
    .filter-card {
        background-color: #f8fafc !important;
        border: 1px solid #e3e8ee !important;
        border-radius: 12px !important;
        padding: 15px;
        margin-bottom: 10px;
    }

    /* HARD RESET: Force black fonts and remove unwanted backgrounds */
    .filter-card *, fieldset, legend, .branch, td, tr, label, span, textarea {
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

    /* Input & Textarea Styling */
    input[type="text"], textarea {
        width: 100%;
        border: 1px solid #ccd6e0;
        border-radius: 6px;
        padding: 7px 10px;
        font-size: 13px;
        color: black !important;
        box-sizing: border-box;
        background-color: #ffffff !important;
    }

    /* RHS Visibility & Dual Grid Support */
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
        padding: 20px;
        display: flex;
        flex-direction: column;
        gap: 20px;
    }

    /* FINALIZED BUTTONS (#2563eb) */
    .myButton {
        background-color: #2563eb !important;
        color: #ffffff !important; 
        border: none !important;
        border-radius: 6px;
        cursor: pointer;
        font-size: 13px;
        font-weight: 600;
        padding: 10px 15px;
        text-align: center;
        display: block;
        width: 100%;
        margin-bottom: 8px;
        transition: background 0.2s;
    }

    .myButton:hover { background-color: #1d4ed8 !important; }

    .branch { font-size: 13px; font-weight: 600; }
</style>
<body onload="hiddenbrh();">
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
                        <td class="label-cell">Fleet</td>
                        <td>
                            <input type="text" id="client" name="client" placeholder="Press F3 To Search" readonly value='<s:property value="client"/>' onkeydown="getClientData(event);">
                            <input type="hidden" name="hidclient" id="hidclient" value='<s:property value="hidclient"/>'/>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">From</td>
                        <td><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">To</td>
                        <td><div id='todate' name='todate' value='<s:property value="todate"/>'></div></td>
                    </tr>
                </table>
            </div>

            <div class="filter-card">
                <textarea id="clientinfo" name="clientinfo" readonly="readonly" style="height:150px; font-size: 11px; resize:none;"><s:property value="clientinfo" ></s:property></textarea>
            </div>

            <div style="padding: 10px 5px;">
                <button class="myButton" type="button" id="btnPrint" name="btnPrint" onclick="funPrintMov(event);">Print</button>
            </div>

            <div id='paychaaaaa' style="width: 100%; height:125px; border: 1px solid #e1e8ed; border-radius: 8px; margin-top: 10px;"></div>
        </div>
    </div>

    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="vehiclediv">
                <jsp:include page="vehicleMovementGrid.jsp"></jsp:include>
            </div>
            
            <div id="vehiclesummdiv">
                <jsp:include page="vehicleSummaryGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>
</div>

</div>
<div id="clientwindow"><div></div>
</div>
</div>
</body>
</html>