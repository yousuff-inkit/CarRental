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


<script type="text/javascript">

$(document).ready(function () {
 
	
	
	// $('#vehiclewindow1').jqxWindow({ autoOpen: false,width: '80%', height: '80%',  maxHeight: '80%' ,maxWidth: '80%' , title: 'Vehicle Details' ,position: { x: 240, y: 15 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'});
	  $('#movementwindow').jqxWindow({ autoOpen: false,width: '77%', height: '74%',  maxHeight: '70%' ,maxWidth: '78%' , title: 'Movement Details' ,position: { x: 280, y: 15 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'}); 
$('#securitypasswindow').jqxWindow({ autoOpen: false,width: '60%', height: '60%',  maxHeight: '70%' ,maxWidth: '78%' , title: 'Security Pass Details' ,position: { x: 280, y: 15 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'});	  
$('#clientreview').click(function(){
	  	   var url=document.URL;
	  		var reurl=url.split("com");
	  		  window.parent.formName.value="Client Review";
	  		  window.parent.formCode.value="CRW";

	   top.addTab("Client Review",reurl[0]+"com/operations/clientrelations/clientreview/clientReview.jsp");

      }); 
	    $('#rabutton').click(function(){
	  	   var url=document.URL;
	  		var reurl=url.split("com");
	  		  window.parent.formName.value="Rental Agreement Create";
	  		  window.parent.formCode.value="RAG";

	   top.addTab("Rental Agreement",reurl[0]+"com/operations/agreement/rentalagreement/rentalAgreement.jsp");

	   });  
	   
	    $('#bookingbtn').click(function(){
		  	   var url=document.URL;
		  		var reurl=url.split("com");
		  		  window.parent.formName.value="Booking";
		  		  window.parent.formCode.value="VBR";

		   top.addTab("Booking",reurl[0]+"com/operations/marketing/booking/booking.jsp");

		   });  
		   
	  //rabutton bookingbtn
});
function securityPassSearchContent(url) {
	$('#securitypasswindow').jqxWindow('focus'); 
	$.get(url).done(function (data) {
		$('#securitypasswindow').jqxWindow('setContent', data);
	}); 
	 
 }
function funreload(event)  
{     
	document.getElementById("fleetno").value="";
	document.getElementById("brach").value="";
	document.getElementById("grp").value="";
	 disitems();
	 
	 
	 var barchval = document.getElementById("cmbbranch").value;
     
	 $("#fleetdiv").load("readyToRentGrid.jsp?brchval="+barchval);
	 
	 $("#maintariffGrid").jqxGrid('clear');
	 $("#jqxgridtarifrr").jqxGrid('clear');
	
	}
	
	
function funExportBtn()
{
	
//	$("#jqxFleetGrid").jqxGrid('exportdata', 'xls', 'ReadyToRent');
	
	
	
	 if(parseInt(window.parent.chkexportdata.value)=="1")
	 {
	 JSONToCSVCon(sssss, 'ReadyToRent', true);
	 }
 else
	 {
	   $("#jqxFleetGrid").jqxGrid('exportdata', 'xls', 'ReadyToRent');
	 }
	
	
	
	}
	
function disitems()
{
	 $('#btnvehicle').attr("disabled",true);
	 $('#btnmove').attr("disabled",true);
	 $('#btnclient').attr("disabled",true);
	 
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
 function openclientreview()
 {
	   var url=document.URL;
		var reurl=url.split("com");
		  window.parent.formName.value="Client Review";
		  window.parent.formCode.value="CRW";

 top.addTab("Client Review",reurl[0]+"com/operations/clientrelations/clientreview/clientReview.jsp");

 }
 /* function getRentalAgreement(){
	  var docno = $('#txtdocno').val();
	  
	  if(docno==''){
	    $.messager.alert('Message','Choose an Agreement.','warning');
	    return 0;
	   }
	  
	  var url=document.URL;
	  var reurl=url.split("com");
	  
	  window.parent.formName.value="Client Review";
	  window.parent.formCode.value="CRW";
	  
	  var detName= "Client Review";
	  var path= "com/operations/clientrelationsclientreviewDetails.action?mode=view&docno="+docno;
	  top.addTab( detName,reurl[0]+""+path);
	 }
  */
<%--  function getVehicle(){
	 $('#vehiclewindow1').jqxWindow('setContent', '');
	 $('#vehiclewindow1').jqxWindow('open'); 
	  vehicleSearchContent("<%=contextPath%>/com/controlcentre/masters/vehicle/saveVehicle1.action?mode=view&fleetno="+document.getElementById("fleetno").value);
	}
	function vehicleSearchContent(url) {
		 //$('#vehiclewindow').jqxWindow('open'); 
		 $('#vehiclewindow1').jqxWindow('focus'); 
		 $.get(url).done(function (data) {
		$('#vehiclewindow1').jqxWindow('setContent', data);
		}); 
		}
		  --%>
	

</script>
</head>
  
<body onload="getBranch();disitems();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ================= LEFT PANEL (20%) ================= -->
<td width="20%">
    <div class="master-container">
        <div class="sidebar-filters">

            <!-- Fixed Heading -->
            <div class="sidebar-fixed-top">
                <div class="filter-card">
                    <jsp:include page="../../heading.jsp"></jsp:include>
                </div>
            </div>

            <!-- Scrollable Content -->
            <div class="sidebar-scroll-content">

                <div class="filter-card">
                    <table class="filter-table">

                        <tr>
                            <td class="label-cell">Fleet</td>
                            <td>
                                <input type="text" name="fleetno" id="fleetno"
                                       readonly
                                       value='<s:property value="fleetno"/>'>
                            </td>
                        </tr>

                    </table>
                </div>

                <!-- ================= BLUE ACTION BUTTONS ================= -->
                <button type="button" class="btn-submit" onclick="funClientAttach();">
                    Attach
                </button>

                <button type="button" class="btn-submit" onclick="getVehicleMov();">
                    Movement
                </button>

                <!-- ================= ICON BUTTONS (UNCHANGED) ================= -->
                <div style="text-align:center; margin-top:12px;">
                    <button type="button" title="Rental Agreement" class="icons"
                            id="rabutton" value='<s:property value="rabutton"/>'>
                        <img alt="Rental Agreement"
                             src="<%=contextPath%>/icons/openra.png">
                    </button>

                    <button type="button" title="Booking" class="icons"
                            id="bookingbtn" value='<s:property value="bookingbtn"/>'>
                        <img alt="Booking"
                             src="<%=contextPath%>/icons/openbk.png">
                    </button>

                    <button type="button" title="Client Review" class="icons"
                            id="clientreview" value='<s:property value="clientreview"/>'>
                        <img alt="Client Review"
                             src="<%=contextPath%>/icons/openclientreview.png">
                    </button>
                </div>

                <!-- ================= MASTER TARIFF GRID ================= -->
                <div class="filter-card" style="margin-top:10px;">
                    <div id="mastertariff">
                        <jsp:include page="masterTariffgrid.jsp"></jsp:include>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <!-- Hidden fields (unchanged) -->
    <input type="hidden" name="brach" id="brach"
           value='<s:property value="brach"/>'>
    <input type="hidden" name="grp" id="grp"
           value='<s:property value="grp"/>'>
    <input type="hidden" name="docno" id="docno"
           value='<s:property value="docno"/>'>

</td>

<!-- ================= RIGHT CONTENT (80%) ================= -->
<td width="80%">
    <table width="100%">
        <tr>
            <td>
                <div id="fleetdiv">
                    <jsp:include page="readyToRentGrid.jsp"></jsp:include>
                </div>
            </td>
        </tr>

        <tr>
            <td>
                <div id="tariffdiv">
                    <jsp:include page="tariffShowgrid.jsp"></jsp:include>
                </div>
            </td>
        </tr>
    </table>
</td>

</tr>
</table>

</div>

<!-- ================= HIDDEN VALUES & POPUPS ================= -->
<label hidden="true" id="trncodeval"></label>
<label hidden="true" id="statusval"></label>

<div id="movementwindow"><div></div></div>
<div id="securitypasswindow"><div></div></div>

</div>
</body>

</html>