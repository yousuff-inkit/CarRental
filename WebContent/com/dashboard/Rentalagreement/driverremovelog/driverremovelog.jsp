<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

<script type="text/javascript">

$(document).ready(function () {
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	 $('#clientDetailsWindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	 $('#clientDetailsWindow').jqxWindow('close');
	 
	 $('#agreementDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Agreement Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#agreementDetailsWindow').jqxWindow('close');
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
	  $('#txtclientname').dblclick(function(){
		  clientSearchContent('clientDetailsSearchGrid.jsp');
		});
	  
	  $('#vocnos').dblclick(function(){
		  var branchval = document.getElementById("cmbbranch").value; 
		  agreementSearchContent('agreementDetailsSearch.jsp?branchval='+branchval); 
		});
});

	function clientSearchContent(url) {
	    $('#clientDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientDetailsWindow').jqxWindow('setContent', data);
		$('#clientDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function agreementSearchContent(url) {
	 	$('#agreementDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#agreementDetailsWindow').jqxWindow('setContent', data);
		$('#agreementDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getClient(event){
	    var x= event.keyCode;
	    if(x==114){
	    	clientSearchContent('clientDetailsSearchGrid.jsp');
	    }
	    else{}
	    }
	
	function getAgreement(event){
	    var x= event.keyCode;
	    if(x==114){
	    	var branchval = document.getElementById("cmbbranch").value; 
  		    agreementSearchContent('agreementDetailsSearch.jsp?branchval='+branchval);
	    }
	    else{}
	    }
	
/* 	function funSearchdblclick(){
		
	}
	 */
	/*  function funExportBtn(){
		   $("#rentalInvoiceGrid").jqxGrid('exportdata', 'xls', 'Invoices List');
		 } */

	function  funClearData(){
		 $('#txtclientname').val('');$('#txtcldocno').val('');$('#rentaltype').val('');$('#txtagreementno').val('');$('#vocnos').val('');$('#todate').val(new Date());$('#clstatuss').val('');
		
		 var onemounth=new Date(new Date((new Date())).setMonth(new Date().getMonth()-1)); 
		
		 $('#fromdate').val(onemounth);
           $('#todate').val(new Date());
	     
		 if (document.getElementById("txtclientname").value == "") {
		        $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
		    }
		 if (document.getElementById("vocnos").value == "") {
		        $('#vocnos').attr('placeholder', 'Press F3 to Search'); 
		    }
	 }
	
	function funreload(event){
		

		  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  } 
		   else
			   {
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var cldocno = $('#txtcldocno').val();
	 
		 var agmtno = $('#txtagreementno').val();
		 
		   $("#overlay, #PleaseWait").show();
		 $("#masterDiv").load("detailsGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&cldocno='+cldocno+'&agmtno='+agmtno);
			   
			   }
			   }
	function chktype()
	{
		
		
	/* 	 if($('#rentaltype').val()=="")
		  {
			  $.messager.alert('Message','Select Type  ','warning');   
				 document.getElementById("rentaltype").focus(); 
			   return false;
	
		  } */
		
		
	}
	
	
	function clearagno()
	{
		$('#txtagreementno').val('');
		$('#vocnos').val('');
		
	}
	
	
	


	function funExportBtn(){
		      $("#detailsgrid").jqxGrid('exportdata', 'xls', 'Drivers Remove');
		     
 
		   }
		  
		  
		 
	
	
	
	

</script>
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
        width: 350px; 
        flex: 0 0 350px;
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
        margin-bottom: 12px;
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
        width: 90px;
    }

    /* Input & Select Styling */
    input[type="text"], select {
        width: 100%;
        border: 1px solid #ccd6e0;
        border-radius: 6px;
        padding: 7px 10px;
        font-size: 13px;
        color: black !important;
        box-sizing: border-box;
        background-color: #ffffff !important;
    }

    /* RHS Grid Area & Scroll Fix */
    .main-content-wrapper {
        flex: 1;
        display: flex;
        flex-direction: column;
        height: 100vh;
        width: 100%;
        max-width: calc(100vw - 350px);
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

    /* FINALIZED BUTTONS (#2563eb) */
    .myButtons {
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
        margin-top: 5px;
        transition: background 0.2s;
    }

    .myButtons:hover { 
        background-color: #1d4ed8 !important; 
    }

    .branch { font-size: 13px; font-weight: 600; }
</style>

</head>
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
                        <td class="label-cell">From</td>
                        <td align="left">
                            <div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">To</td>
                        <td align="left">
                            <div id="todate" name="todate" value='<s:property value="todate"/>'></div>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Client</td>
                        <td align="left">
                            <input type="text" id="txtclientname" name="txtclientname" readonly="readonly" placeholder="Press F3 to Search" onkeydown="getClient(event);" value='<s:property value="txtclientname"/>'/>
                            <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Agreement</td>
                        <td align="left">
                            <input type="text" id="vocnos" name="vocnos" readonly="readonly" onfocus="chktype()" placeholder="Press F3 to Search" ondblclick="funSearchdblclick();" onkeydown="getAgreement(event);" value='<s:property value="vocnos"/>'/>
                            <input type="hidden" id="txtagreementno" name="txtagreementno" value='<s:property value="txtagreementno"/>'/>
                        </td>
                    </tr>
                </table>
                
                <div style="margin-top: 15px;">
                    <input type="button" class="myButtons" name="clear" id="clear" value="Clear" onclick="funClearData();">
                </div>
            </div>
            
            <div style="height: 200px;"></div>
        </div>
    </div>

    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="masterDiv">
                <jsp:include page="detailsGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>
</div>
</div>

<div id="clientDetailsWindow">
	<div></div><div></div>
</div>
<div id="agreementDetailsWindow">
	<div></div><div></div>
</div>
</div> 
</body>
</html>