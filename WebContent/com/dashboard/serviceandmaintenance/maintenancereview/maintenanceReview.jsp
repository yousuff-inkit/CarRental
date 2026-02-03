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
<style type="text/css">

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
		 
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $('#vehicleDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Vehicle Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#vehicleDetailsWindow').jqxWindow('close');
		 
		 $('#inspectionWindow').jqxWindow({ autoOpen: false,width: '78%', height: '85%',  maxHeight: '85%' ,maxWidth: '78%' , title: 'Inspection Details' , theme: 'energyblue', position: { x: 280, y: 10 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		
	     var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	     $('#txtvehicle').dblclick(function(){
			  vehicleSearchContent('vehicleDetailsGrid.jsp');
			});
	});
	
	function vehicleSearchContent(url) {
	    $('#vehicleDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#vehicleDetailsWindow').jqxWindow('setContent', data);
		$('#vehicleDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function inspectionSearchContent(url) {
		 $('#inspectionWindow').jqxWindow('focus'); 
		 $.get(url).done(function (data) {
		 $('#inspectionWindow').jqxWindow('setContent', data);
		}); 
		}
	
	function getVehicle(event){
        var x= event.keyCode;
        if(x==114){
        	vehicleSearchContent('vehicleDetailsGrid.jsp');
        }
        else{
         }
        }
	
	function funreload(event){
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var type = $('#cmbtype').val();
		 var fleetno = $('#txtfleetno').val();
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 
		 if(type==''){
			 $.messager.alert('Message','Please Choose a Review Type.','warning');
			 return 0;
		 }

		 $("#overlay, #PleaseWait").show();
		 
		 if(type==1){
			 $("#serviceHistoryDiv").prop("hidden", true);
	       	 $("#accidentHistoryDiv").prop("hidden", false);
		     $("#accidentHistoryDiv").load("accidentHistoryGrid.jsp?branchval="+branchval+'&type='+type+'&fromdate='+fromdate+'&todate='+todate+'&fleetno='+fleetno+'&id=1');
		 }
		 else{  
			 $("#accidentHistoryDiv").prop("hidden", true); 
	       	 $("#serviceHistoryDiv").prop("hidden", false);
		     $("#serviceHistoryDiv").load("serviceHistoryGrid.jsp?branchval="+branchval+'&type='+type+'&fromdate='+fromdate+'&todate='+todate+'&fleetno='+fleetno+'&id=1');
		 }
		}
	
	function funClearInfo(){

  	     $('#cmbbranch').val('a');
  	     $('#fromdate').val(new Date());
  	 	 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		 $('#todate').val(new Date());
		 $("#cmbtype").val('');$("#txtvehicle").val('');$("#txtfleetno").val('');$("#txtvehdocno").val('');
		 
		 $("#accidentHistory").jqxGrid('clear');$("#serviceHistory").jqxGrid('clear');		
		 
		 if (document.getElementById("txtvehicle").value == "") {
		        $('#txtvehicle').attr('placeholder', 'Press F3 to Search'); 
		  }
		 document.getElementById("vehinfo").value="";     
		}
	
	function funMaintenancePrint(){
		var fleetno = $('#txtfleetno').val();
		 
		if(fleetno==''){
			 $.messager.alert('Message','Please Choose a Fleet.','warning');
			 return 0;
		 }
		
 	    if ($("#txtfleetno").val()!="") {
	        var url=document.URL;
	        var reurl=url.split("maintenanceReview.jsp");
	        
	        $("#txtfleetno").prop("disabled", false);
	        var win= window.open(reurl[0]+"printMaintenanceReview?&fleetno="+document.getElementById("txtfleetno").value+'&branch='+document.getElementById("cmbbranch").value+'&fromdate='+$("#fromdate").val()+'&todate='+$("#todate").val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        win.focus();
	     }
	    else {
			$.messager.alert('Message','Fleet is Mandatory.','warning');
			return;
		}
	   }
	   
	   function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		 if(temp1=='1'){
		  	JSONToCSVCon(data2, 'AccidentHistory', true);
		 }
		 
		 if(temp1=='2'){
		    JSONToCSVCon(data1, 'ServiceHistory', true);
		 }
			
		 } else {
			 if(temp1=='1'){
	    			$("#accidentHistory").jqxGrid('exportdata', 'xls', 'AccidentHistory');
        	}
			if(temp1=='2'){
	    			$("#serviceHistory").jqxGrid('exportdata', 'xls', 'ServiceHistory');
        	}
		 }
	 }
	function funSearchdblclick(){   
		
	}
</script>
</head>
<body onload="getBranch();">

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

        <!-- Filters -->
        <div class="filter-card">
            <table class="review-filter-table">

                <tr>
                    <td class="label-cell">Period</td>
                    <td><div id="fromdate"></div></td>
                </tr>

                <tr>
                    <td class="label-cell">To</td>
                    <td><div id="todate"></div></td>
                </tr>

                <tr>
                    <td class="label-cell">Review</td>
                    <td>
                        <select id="cmbtype" name="cmbtype">
                            <option value="">--Select--</option>
                            <option value="1">Accident History</option>
                            <option value="2">Service History</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Vehicle</td>
                    <td>
                        <input type="text"
                               id="txtvehicle"
                               name="txtvehicle"
                               placeholder="Press F3 to Search"
                               readonly
                               ondblclick="funSearchdblclick();"
                               onkeydown="getVehicle(event);">
                        <input type="hidden" id="txtfleetno" name="txtfleetno">
                    </td>
                </tr>

            </table>
        </div>

        <!-- Vehicle Info -->
        <div class="filter-card">
            <textarea id="vehinfo" name="vehinfo" readonly>
<s:property value="vehinfo"></s:property>
            </textarea>

            <input type="hidden" id="txtvehdocno" name="txtvehdocno">

            <div class="review-actions">
                <button type="button"
                        class="btn-submit"
                        onclick="funClearInfo();">
                    Clear
                </button>

                <button type="button"
                        class="btn-submit"
                        onclick="funMaintenancePrint();">
                    Print
                </button>
            </div>
        </div>

    </div>
</div>
</div>
</td>

<!-- ================= RIGHT CONTENT ================= -->
<td width="80%">
    <div id="accidentHistoryDiv">
        <jsp:include page="accidentHistoryGrid.jsp"></jsp:include>
    </div>

    <div id="serviceHistoryDiv" hidden>
        <jsp:include page="serviceHistoryGrid.jsp"></jsp:include>
    </div>
</td>

</tr>
</table>

</div>

<!-- POPUP WINDOWS -->
<div id="vehicleDetailsWindow"><div></div><div></div></div>
<div id="inspectionWindow"><div></div></div>

</div>
</body>
</html>