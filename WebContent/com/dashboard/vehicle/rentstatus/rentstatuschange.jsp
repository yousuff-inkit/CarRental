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
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
 
	
	
	// $('#vehiclewindow1').jqxWindow({ autoOpen: false,width: '80%', height: '80%',  maxHeight: '80%' ,maxWidth: '80%' , title: 'Vehicle Details' ,position: { x: 240, y: 15 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'});
	  $('#movementwindow').jqxWindow({ autoOpen: false,width: '77%', height: '74%',  maxHeight: '70%' ,maxWidth: '78%' , title: 'Movement Details' ,position: { x: 280, y: 15 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'}); 
 
});

function funreload(event)  
{     
	document.getElementById("fleetno").value="";
	document.getElementById("brach").value="";
	document.getElementById("grp").value="";
	 document.getElementById("docno").value="";
	 document.getElementById("rentaltype").value="";
	 document.getElementById("typeingrid").value="";
	
	 disitems();
		 var barchval = document.getElementById("cmbbranch").value;
     
	 $("#fleetdiv").load("vehlistshowgrid.jsp?brchval="+barchval);
	 
	
	}
	
 	
function disitems()
{
	 $('#btnvehicle').attr("disabled",true);
	 $('#btnmove').attr("disabled",true);
	 $('#btnupdate').attr("disabled",true);
	 $('#rentaltype').attr("disabled",true);
	 $('#fleetno').attr("disabled",true);
	 
	  
}
	
 function getVehicleMov(){
	  var fleetno=document.getElementById("fleetno").value;
	  var vals=0;
	  var ready="ready";
	  $('#movementwindow').jqxWindow('setContent', '');
	  $('#movementwindow').jqxWindow('open');  
	  movementSearchContent("<%=contextPath%>/com/dashboard/vehicle/vehiclemovement/vehiclemovementGrid.jsp?fleetno="+fleetno+"&fromdate="+vals+"&todate="+vals+"&ready="+ready);
	 }
 
 function movementSearchContent(url) {
	 //$('#vehiclewindow').jqxWindow('open'); 
	 $('#movementwindow').jqxWindow('focus'); 
	 $.get(url).done(function (data) {
	$('#movementwindow').jqxWindow('setContent', data);
	}); 
	 
 }
 function changeClientAttachContent(url) {
		$.get(url).done(function (data) {
			    $('#windowattach').jqxWindow('open');
				$('#windowattach').jqxWindow('setContent',data);
				$('#windowattach').jqxWindow('bringToFront');
	}); 
	}
 function funClientAttach(){
	
	 
		if ($("#docno").val()!="") {
			  $("#windowattach").jqxWindow('setTitle',"VEH - "+document.getElementById("docno").value);
			changeClientAttachContent("<%=contextPath%>/com/common/attachGrid.jsp?formCode=VEH&docno="+document.getElementById("docno").value);		
		} else {
			$.messager.alert('Message','Select Fleet....!','warning');
			return;
		}
	}

	
 function funsamechk()
 {
	 
	 if(document.getElementById("rentaltype").value==document.getElementById("typeingrid").value)
	 {
		 $.messager.alert('Message','Rent Type Is Same','warning');   
		 document.getElementById("rentaltype").focus();
					 
		 return 0;
	 }
	 
 }
 
 
 
		  function funupdate()
		  
			{

			  
			  if(document.getElementById("rentaltype").value=="")
				 {
					 $.messager.alert('Message','Select Rent Type ','warning');   
								 
					 return 0;
				 }
				
			  if(document.getElementById("rentaltype").value==document.getElementById("typeingrid").value)
				 {
					 $.messager.alert('Message','Rent Type Is Same','warning');   
					 document.getElementById("rentaltype").focus();
								 
					 return 0;
				 }
			  var fleetno=document.getElementById("fleetno").value;
			  
			  var renttype=document.getElementById("rentaltype").value;
			  
			  savegriddata(fleetno,renttype);
			 
			}	
				
	
		
			function savegriddata(fleetno,renttype)
			{
				
				var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
					{
					
						var items=x.responseText;
						 document.getElementById("rentaltype").value="";
						 document.getElementById("fleetno").value="";
						 document.getElementById("brach").value="";
						 document.getElementById("grp").value="";
						 document.getElementById("docno").value="";
						 document.getElementById("typeingrid").value="";
						  
			              $.messager.alert('Message', '  Record Successfully Updated ', function(r){
					 		   
					     });
						 funreload(event); 
						 
						 disitems();
						 
						
						}
					
				}
					
			x.open("GET","saverenttype.jsp?fleet="+fleetno+"&renttype="+renttype,true);

			x.send();
					
			}
			
			
			function funExportBtn(){
				
				   
				   
				   
				   
				   
					 if(parseInt(window.parent.chkexportdata.value)=="1")
					 {
					 JSONToCSVCon(sssss, 'Rent Status', true);
					 }
				 else
					 {
					   $("#jqxFleetGrid").jqxGrid('exportdata', 'xls', 'Rent Status');
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
        color: black !important; /* Force all font black */
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

    /* Cleaned Cards - Stripping legacy backgrounds */
    .filter-card {
        background-color: #f8fafc !important;
        border: 1px solid #e3e8ee !important;
        border-radius: 12px !important;
        padding: 15px;
        margin-bottom: 10px;
    }

    /* HARD RESET: Force black fonts and remove unwanted backgrounds */
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

    /* RHS Visibility & Scrollbar Kill */
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

    /* Chart Container Styling */
    #pieChart1 {
        background-color: #ffffff !important;
        border-radius: 8px;
        border: 1px solid #e3e8ee;
        margin-top: 20px;
    }
</style>
<body onload="getBranch();disitems();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
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
                            <input type="text" name="fleetno" id="fleetno" readonly="readonly" value='<s:property value="fleetno"/>'>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">RentType</td>
                        <td>
                            <select name="rentaltype" id="rentaltype" onchange="funsamechk()">
                                <option value="">--Select--</option>
                                <option value="R" selected>Rental</option>
                                <option value="L">Lease</option>
                                <option value="LM">Limousine</option>
                                <option value="A">All</option>
                            </select>
                        </td>
                    </tr>
                </table>
            </div>

            <div style="padding: 10px 5px;">
                <input type="button" name="btnupdate" id="btnupdate" value="Update" class="myButton" onclick="funupdate();">
                
                <div style="display: flex; gap: 8px; margin-top: 10px;">
                    <input type="button" name="btnvehicle" id="btnvehicle" value="Attach" class="myButton" onclick="funClientAttach();" style="flex: 1;">
                    <input type="button" name="btnmove" id="btnmove" value="Movement" class="myButton" onClick="getVehicleMov();" style="flex: 1;">
                </div>
            </div>

            <div id='pieChart1' style="width: 100%; height: 170px;"></div>
        </div>
    </div>

    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="mainGridDiv">
                </div>
        </div>
    </div>
</div>
	</fieldset>
	
<input type="hidden" name="brach" id="brach" style="height:20px;width:60%;" readonly="readonly" value='<s:property value="brach"/>' >
<input type="hidden" name="grp" id="grp" style="height:20px;width:60%;" readonly="readonly" value='<s:property value="grp"/>' >

<input type="hidden" name="docno" id="docno" style="height:20px;width:60%;" readonly="readonly" value='<s:property value="docno"/>' >
<input type="hidden" name="typeingrid" id="typeingrid" style="height:20px;width:60%;" readonly="readonly" value='<s:property value="typeingrid"/>' >
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="fleetdiv"><jsp:include page="vehlistshowgrid.jsp"></jsp:include></div></td>
			 
			 </tr>
		
	</table>
</tr>
</table>
</div>
<label hidden="true" id="trncodeval"></label>
 <label  hidden="true" id="statusval"></label>

<div id="movementwindow">
<div></div>
</div> 

</div>


</body>
</html>