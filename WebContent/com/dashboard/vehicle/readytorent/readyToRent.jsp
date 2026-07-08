<%@page import="com.dashboard.vehicle.ClsvehicleDAO" %>
<% ClsvehicleDAO cvd=new ClsvehicleDAO();%>
<% String contextPath=request.getContextPath();%>
<jsp:include page="../../../../includeso.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700;800&display=swap" rel="stylesheet">
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>

<style>

/* ===== MASTER-UI MATCH: Fleet Status Dashboard ===== */

.fleet-status-wrapper {
    --primary-color: #2563eb;
    --secondary-color: #4e5e71;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    background: #f4f7f9 !important;
    height: 100vh;
    width: 100%;
    padding: 0 !important;
    overflow: hidden;
    box-sizing: border-box;
}

/* Custom Scrollbar (match master's light thin style) */
.fleet-status-wrapper::-webkit-scrollbar,
.fleet-status-wrapper *::-webkit-scrollbar {
    width: 8px;
    height: 8px;
}

.fleet-status-wrapper::-webkit-scrollbar-track,
.fleet-status-wrapper *::-webkit-scrollbar-track {
    background: #f4f7f9;
    border-radius: 4px;
}

.fleet-status-wrapper::-webkit-scrollbar-thumb,
.fleet-status-wrapper *::-webkit-scrollbar-thumb {
    background: #ccd6e0;
    border-radius: 4px;
}

.fleet-status-wrapper::-webkit-scrollbar-thumb:hover,
.fleet-status-wrapper *::-webkit-scrollbar-thumb:hover {
    background: #9fb0c3;
}

.fleet-status-wrapper .main-container {
    display: flex;
    flex-direction: row;
    gap: 0;
    height: 100vh;
    width: 100%;
    max-width: 100%;
    margin: 0;
    box-sizing: border-box;
}

/* ===== LEFT SIDEBAR (matches master exactly) ===== */
.fleet-status-wrapper .sidebar {
    flex: 0 0 280px;
    min-width: 280px;
    max-width: 280px;
    background: #ffffff;
    border-radius: 0;
    border-right: 1px solid #e1e8ed;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
    padding: 15px;
    overflow-y: auto;
    overflow-x: hidden;
    min-height: 100%;
    box-sizing: border-box;
}

.fleet-status-wrapper .main-content {
    flex: 1 1 auto;
    min-width: 0;
    background: #ffffff;
    border-radius: 0;
    padding: 15px;
    overflow-y: auto;
    overflow-x: visible;
    min-height: 100%;
    margin: 0;
    box-sizing: border-box;
}

/* ===== FILTER CARD (fieldset -> master's .filter-card look) ===== */
.fleet-status-wrapper fieldset {
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    background: #f8fafc;
    padding: 15px;
    margin: 0;
}

.fleet-status-wrapper .checkbox-container {
    display: flex;
    align-items: center;
    gap: 8px;
    margin: 10px 0;
    padding: 8px 10px;
    background: #ffffff;
    border: 1px solid #e3e8ee;
    border-radius: 4px;
}

.fleet-status-wrapper input[type="checkbox"] {
    width: 16px;
    height: 16px;
    cursor: pointer;
}

.fleet-status-wrapper .branch {
    font-size: 12px;
    font-weight: 500;
    color: #4e5e71;
    margin: 0;
}

/* ===== GRID CONTAINERS ===== */
.fleet-status-wrapper .grid-container {
    background: #ffffff;
    border: 1px solid #e3e8ee;
    border-radius: 8px;
    padding: 12px;
    margin: 6px 0;
    max-width: 100%;
    overflow: visible;
}

.fleet-status-wrapper .sidebar .grid-container {
    padding: 10px;
    margin: 12px auto;
    display: flex;
    justify-content: center;
    align-items: center;
    background: #f8fafc;
    border-radius: 8px;
    border: 1px solid #e3e8ee;
}

.fleet-status-wrapper .sidebar .grid-container table {
    width: 100%;
    max-width: 100%;
    table-layout: fixed;
    font-size: 11px;
    max-height: 50px;
    margin: 0 auto;
}

.fleet-status-wrapper .sidebar .grid-container table td {
    word-wrap: break-word;
    color: #333;
}

.fleet-status-wrapper .sidebar #Readygrid {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
}

.fleet-status-wrapper .sidebar #Readygrid > * {
    margin: 0 auto;
}

.fleet-status-wrapper .sidebar .jqx-grid {
    margin: 0 auto !important;
}

/* ===== BUTTONS (exact match to master's .btn-submit) ===== */
.fleet-status-wrapper .myButton {
    width: 100%;
    height: 30px;
    padding: 0 12px;
    border-radius: 4px;
    background: #2563eb;
    border: none;
    color: #ffffff;
    font-weight: 600;
    font-size: 13px;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 6px;
    cursor: pointer;
    line-height: 30px;
    transition: background 0.2s;
    box-shadow: none;
}

.fleet-status-wrapper .myButton:hover {
    background: #1d4ed8;
    transform: none;
    box-shadow: none;
}

.fleet-status-wrapper .submit-container {
    margin-top: 12px;
}

/* ===== CHARTS ===== */
.fleet-status-wrapper .chart-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 14px;
    margin: 12px 0;
}

.fleet-status-wrapper .chart-container {
    background: #ffffff;
    border: 1px solid #e3e8ee;
    border-radius: 8px;
    padding: 12px;
    box-shadow: none;
    height: 300px;
}

.fleet-status-wrapper .chart-container > div {
    height: 100% !important;
}

/* ===== SEARCH BAR (matches master's 24px input rhythm) ===== */
.fleet-status-wrapper .compact-search-bar {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 8px;
    margin-top: 0;
}

.fleet-status-wrapper .search-input-wrapper {
    flex: 1;
    position: relative;
    max-width: 220px;
}

.fleet-status-wrapper .search-icon-inline {
    position: absolute;
    left: 10px;
    top: 50%;
    transform: translateY(-50%);
    color: #94a3b8;
    pointer-events: none;
    width: 16px;
    height: 16px;
}

.fleet-status-wrapper .universal-search-input {
    width: 100%;
    height: 24px;
    padding: 2px 30px 2px 30px;
    border: 1px solid #ccd6e0;
    border-radius: 4px;
    font-size: 12px;
    font-weight: 400;
    color: #333;
    background: #ffffff;
    transition: border-color 0.2s;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    box-sizing: border-box;
}

.fleet-status-wrapper .universal-search-input:focus {
    outline: none;
    border-color: #2563eb;
    box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
}

.fleet-status-wrapper .clear-search-btn {
    position: absolute;
    right: 4px;
    top: 50%;
    transform: translateY(-50%);
    padding: 3px 6px;
    background: transparent;
    color: #94a3b8;
    border: none;
    border-radius: 4px;
    font-size: 12px;
    cursor: pointer;
    transition: all 0.2s ease;
    font-weight: 500;
    height: 20px;
    display: flex;
    align-items: center;
    justify-content: center;
}

.fleet-status-wrapper .clear-search-btn:hover {
    background: #fee2e2;
    color: #dc2626;
}

.fleet-status-wrapper .search-results-badge {
    padding: 4px 5px;
    background: #eef4ff;
    color: #2563eb;
    border-radius: 4px;
    font-size: 12px;
    font-weight: 500;
    white-space: nowrap;
    height: 24px;
    display: flex;
    align-items: center;
    box-sizing: border-box;
}

/* ===== MISC ===== */
.hidden-scrollbar {
    height: 100vh;
    width: 100%;
    overflow: hidden;
    box-sizing: border-box;
}

#fleetStatus1, #sec1, #thr1, #four1 {
    width: 100% !important;
    height: 100% !important;
}

.jqx-grid-content {
    overflow-x: auto !important;
    overflow-y: auto !important;
}

.jqx-grid {
    overflow: visible !important;
}

.fleet-status-wrapper #branchwisediv > div:not(.compact-search-bar) {
    max-height: calc(100vh - 300px);
    overflow-y: auto;
}

/* ===== RESPONSIVE (unchanged breakpoints, resized to master's 280px base) ===== */
@media (max-width: 1200px) {
    .fleet-status-wrapper .sidebar {
        flex: 0 0 260px;
        min-width: 260px;
        max-width: 260px;
    }
}

@media (max-width: 1024px) {
    .fleet-status-wrapper .sidebar {
        flex: 0 0 240px;
        min-width: 240px;
        max-width: 240px;
    }
}

@media (max-width: 768px) {
    .fleet-status-wrapper .main-container {
        flex-direction: column;
    }

    .fleet-status-wrapper .sidebar {
        flex: 0 0 auto;
        min-width: 100%;
        max-width: 100%;
        width: 100%;
        height: auto;
        max-height: 40vh;
        border-right: none;
        border-bottom: 1px solid #e1e8ed;
    }

    .fleet-status-wrapper .main-content {
        height: auto;
        flex: 1;
    }
}


.fleet-status-wrapper .main-container {
    align-items: stretch; 
}

.fleet-status-wrapper .main-content-wrapper {
    flex: 1 1 auto;
    min-width: 0;
    display: flex;
    flex-direction: column;
    height: 100%;
}

.fleet-status-wrapper .top-toolbar-container {
    width: 100%;
    padding: 5px 10px;
    background: #ffffff;
    border-bottom: 1px solid #e1e8ed;
    box-sizing: border-box;
    flex-shrink: 0;
}

.fleet-status-wrapper .main-content {
    flex: 1;
    overflow-y: auto;
    overflow-x: visible;
    padding: 5px;
    box-sizing: border-box;
}

.dashboard-header-wrapper .header-container {
    padding: 0;
    background: transparent; 
    border: none;
    box-shadow: none;
    margin-bottom: 0; 
    text-align: left;
    font-size: 14px !important;
    font-weight: 500 !important;
    color: var(--text-main);
    white-space: nowrap;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
  $("#chart").show();
  $("#branchwisediv").hide();
  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
  $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	
	  
	  $("#grid1").hide();
	
	  $("#grid2").hide();
	 var data  =<%=cvd.firstchart()%>;
     
     var dataStatCounter = data;
 
     var charts = [
         { title: '', label: 'Stat', dataSource: dataStatCounter }
     ];
     for (var i = 0; i < charts.length; i++) {
         var chartSettings = {
             source: charts[i].dataSource,
             title: 'On Hire',
             description: charts[i].title,
             enableAnimations: false,
             showLegend: true,
             showBorderLine: true,
             padding: { left: 5, top: 30, right: 5, bottom: 5 },
             titlePadding: { left: 0, top: 0, right: 0, bottom: 20 },
             colorScheme: 'scheme07',
             seriesGroups: [
                 {
                     type: 'pie',
                     showLegend: true,
                     enableSeriesToggle: true,
                     series:
                         [
                             {
                                 dataField: 'per',
                                 displayText: 'tran_code',
                                 showLabels: true,
                                 labelRadius: 200,
                                 labelLinesEnabled: true,
                                 labelLinesAngles: true,
                                 labelsAutoRotate: false,
                                 initialAngle: 0,
                                 radius: 180,
                                 minAngle: 0,
                                 maxAngle: 180,
                                 centerOffset: 0,
                                 offsetY: 180,
                                 formatFunction: function (value, itemIdx, serieIndex, groupIndex) {
                                     if (isNaN(value))
                                         return value;
                                     return value + '%';
                                 }
                             }
                         ]
                 }
             ]
         };
         var selector = '#fleetStatus' + (i + 1);
         $(selector).jqxChart(chartSettings); 
     }
 var data1  =<%=cvd.Secondchart()%>;
     
     var dataStatCounter1 = data1;
 
     var charts = [
         { title: '', label: 'Stat', dataSource: dataStatCounter1 }
     ];
     for (var i = 0; i < charts.length; i++) {
    	 var chartSettings = {
                 source: charts[i].dataSource,
                 title: 'Available',
                 description: charts[i].title,
                 enableAnimations: false,
                 showLegend: true,
                 showBorderLine: true,
                 padding: { left: 5, top: 30, right: 5, bottom: 5 },
                 titlePadding: { left: 0, top: 0, right: 0, bottom: 20 },
                 colorScheme: 'scheme05',
                 seriesGroups: [
                     {
                         type: 'pie',
                         showLegend: true,
                         enableSeriesToggle: true,
                         series:
                             [
                                 {
                                     dataField: 'per',
                                     displayText: 'tran_code',
                                     showLabels: true,
                                     labelRadius: 200,
                                     labelLinesEnabled: true,
                                     labelLinesAngles: true,
                                     labelsAutoRotate: false,
                                     initialAngle: 0,
                                     radius: 180,
                                     minAngle: 0,
                                     maxAngle: 180,
                                     centerOffset: 0,
                                     offsetY: 180,
                                  formatFunction: function (value, itemIdx, serieIndex, groupIndex) {
                                     if (isNaN(value))
                                         return value;
                                     return value + '%';
                                 }
                             }
                         ]
                 }
             ]
         };
         var selector = '#sec' + (i + 1);
         $(selector).jqxChart(chartSettings); 
     }
 var data2  =<%=cvd.Thirdchart()%>;
     
     var dataStatCounter2 = data2;
 
     var charts = [
         { title: '', label: 'Stat', dataSource: dataStatCounter2 }
     ];
     for (var i = 0; i < charts.length; i++) {
         var chartSettings = {
             source: charts[i].dataSource,
             title: 'Garage',
             description: charts[i].title,
             enableAnimations: false,
             showLegend: true,
             showBorderLine: true,
             padding: { left: 5, top: 30, right: 5, bottom: 5 },
             titlePadding: { left: 0, top: 0, right: 0, bottom: 20 },
             colorScheme: 'scheme02',
             seriesGroups: [
                 {
                     type: 'pie',
                     showLegend: true,
                     enableSeriesToggle: true,
                     series:
                         [
                             {
                                 dataField: 'per',
                                 displayText: 'tran_code',
                                 showLabels: true,
                                 labelRadius: 200,
                                 labelLinesEnabled: true,
                                 labelLinesAngles: true,
                                 labelsAutoRotate: false,
                                 initialAngle: 0,
                                 radius: 180,
                                 minAngle: 0,
                                 maxAngle: 180,
                                 centerOffset: 0,
                                 offsetY: 180,
                                 formatFunction: function (value, itemIdx, serieIndex, groupIndex) {
                                     if (isNaN(value))
                                         return value;
                                     return value + '%';
                                 }
                             }
                         ]
                 }
             ]
         };
         var selector = '#thr' + (i + 1);
         $(selector).jqxChart(chartSettings); 
     }
     var data4=<%=cvd.Fourthchart()%>;
     
     var dataStatCounter4 = data4;
 
     var charts = [
         { title: '', label: 'Stat', dataSource: dataStatCounter4 }
     ];
     for (var i = 0; i < charts.length; i++) {
         var chartSettings = {
             source: charts[i].dataSource,
             title: 'All',
             description: charts[i].title,
             enableAnimations: false,
             showLegend: true,
             showBorderLine: true,
             padding: { left: 5, top: 30, right: 5, bottom: 5 },
             titlePadding: { left: 0, top: 0, right: 0, bottom: 20 },
             colorScheme: 'scheme01',
             seriesGroups: [
                 {
                     type: 'pie',
                     showLegend: true,
                     enableSeriesToggle: true,
                     series:
                         [
                             {
                                 dataField: 'per',
                                 displayText: 'tran_code',
                                 showLabels: true,
                                 labelRadius: 200,
                                 labelLinesEnabled: true,
                                 labelLinesAngles: true,
                                 labelsAutoRotate: false,
                                 initialAngle: 0,
                                 radius: 180,
                                 minAngle: 0,
                                 maxAngle: 180,
                                 centerOffset: 0,
                                 offsetY: 180,
                                 formatFunction: function (value, itemIdx, serieIndex, groupIndex) {
                                     if (isNaN(value))
                                         return value;
                                     return value + '%';
                                 }
                             }
                         ]
                 }
             ]
         };
         var selector = '#four' + (i + 1);
         $(selector).jqxChart(chartSettings); 
     }
     getConfigs();
     setTimeout(initializeSearchBars, 500);
});

function funreload(event)
{
	
	  $("#chart").show();
	  $("#grid1").hide();
	  $("#grid2").hide();

	 var barchval = document.getElementById("cmbbranch").value;
	$('#chart').hide();
	$('#branchwisediv').show();
	  $("#Readygrid").load("vehDetailsgrid.jsp?barchval="+barchval);
	  $("#branchwisediv").load("branchwiseGrid.jsp?check=1");
	}
	

	
function funExportBtn()
{
	
	
  	if(document.getElementById("chkgrid").value=="chkgrids")
	
	
		{
		 JSONToCSVConvertor(vehicleexceldata, 'Availability', true);
		}
	else
		{  
	 	 
		
	 	JSONToCSVConvertor(exceldata, 'Availability', true);
		
		  }
	  
	
	 
	
	
	
	
	}
	
	function funsetaval()
	{
		  if (document.getElementById('det_chk').checked) {
		
		document.getElementById("chkdatails").value="search";
		   $('#jqxFleetGrid').jqxGrid('showcolumn', 'empid');
		   $('#jqxFleetGrid').jqxGrid('showcolumn', 'empname');
		   

		   $('#vehiclelist').jqxGrid('showcolumn', 'rdocno');
		   $('#vehiclelist').jqxGrid('showcolumn', 'empname');
		  }
		  else
			  {
			  document.getElementById("chkdatails").value="";
			   $('#jqxFleetGrid').jqxGrid('hidecolumn', 'empid');
			   $('#jqxFleetGrid').jqxGrid('hidecolumn', 'empname');
			   
			   $('#vehiclelist').jqxGrid('hidecolumn', 'rdocno');
			   $('#vehiclelist').jqxGrid('hidecolumn', 'empname');
			  }
		  
		  
		 /*    if(document.getElementById("chkdatails").value=="search")
			{
			   $('#vehdetails').jqxGrid('showcolumn', 'rdocno');
			   $('#vehdetails').jqxGrid('showcolumn', 'empname');
			}
		else
			{
		   $('#vehdetails').jqxGrid('hidecolumn', 'rdocno');
		   $('#vehdetails').jqxGrid('hidecolumn', 'empname');

			} */
	}
	
	function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
		
	    var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
	    
	   // alert("arrData");
	    var CSV = '';    
	    //Set Report title in first row or line
	    
	    CSV += ReportTitle + '\r\n\n';

	    //This condition will generate the Label/Header
	    if (ShowLabel) {
	        var row = "";
	        
	        //This loop will extract the label from 1st index of on array
	        for (var index in arrData[0]) {
	            
	            //Now convert each value to string and comma-seprated
	            row += index + ',';
	        }

	        row = row.slice(0, -1);
	        
	        //append Label row with line break
	        CSV += row + '\r\n';
	    }
	    
	    //1st loop is to extract each row
	    for (var i = 0; i < arrData.length; i++) {
	        var row = "";
	        
	        //2nd loop will extract each column and convert it in string comma-seprated
	        for (var index in arrData[i]) {
	            row += '"' + arrData[i][index] + '",';
	        }

	        row.slice(0, row.length - 1);
	        
	        //add a line break after each row
	        CSV += row + '\r\n';
	    }

	    if (CSV == '') {        
	        alert("Invalid data");
	        return;
	    }   
	    
	    //Generate a file name
	    var fileName = "";
	    //this will remove the blank-spaces from the title and replace it with an underscore
	    fileName += ReportTitle.replace(/ /g,"_");   
	    
	    //Initialize file format you want csv or xls
	    var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
	    
	    // Now the little tricky part.
	    // you can use either>> window.open(uri);
	    // but this will not work in some browsers
	    // or you will not get the correct file extension    
	    
	    //this trick will generate a temp <a /> tag
	    var link = document.createElement("a");    
	    link.href = uri;
	    
	    //set the visibility hidden so it will not effect on your web-layout
	    link.style = "visibility:hidden";
	    link.download = fileName + ".csv";
	    
	    //this part will append the anchor tag and remove it after automatic click
	    document.body.appendChild(link);
	    link.click();
	    document.body.removeChild(link);
	}
 
	 function funPrintBtn(){
			   var url=document.URL;
	    	   var reurl=url.split("readyToRent.jsp");
	    	   var companyname='<%=session.getAttribute("COMPANYNAME").toString()%>';
			   var win= window.open(reurl[0]+"printReadyToRentJrxml?brhid="+document.getElementById("cmbbranch").value+"&company="+companyname+"&print=1","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");    
		       win.focus(); 
		}
	 function funSendingEmail() {  
		 var companyname='<%=session.getAttribute("COMPANYNAME").toString()%>';	
		    
	 		alert("inside mail");
			    $("#overlay, #PleaseWait").show();
			   
		 		$.ajaxFileUpload ({  
		    	    	
		    	    	  url:"printReadyToRentJrxml?brhid="+document.getElementById("cmbbranch").value+"&company="+companyname+"&print=0",  
		    	          secureuri:false,//false  
		    	          fileElementId:'file', //id  <input type="file" id="file" name="file" />  
		    	          dataType: 'string',// json  
		    	          success: function (data, status) {  
		
		    	             if(status=='success'){
								$("#overlay, #PleaseWait").hide();
								$.messager.alert('Message','E-Mail Send Successfully');
		    	              }
		    	             if(status=='error'){
		    	            	 $("#overlay, #PleaseWait").hide();
		    	            	 $.messager.alert('Message','E-Mail Sending failed');
		    	             }
		    	             
		    	              $("#testImg").attr("src",data.message);
		    	              if(typeof(data.error) != 'undefined')  
		    	              {  
		    	                  if(data.error != '')  
		    	                  {  
		    	                      alert(data.error);  
		    	                  }else  
		    	                  {  
		    	                      alert(data.message);  
		    	                  }  
		    	              }  
		    	          },  
		    	           error: function (data, status, e)
		    	          {  
		    	              alert(e);  
		    	          }  
		    	      }) 
		    	     return false;
	      }
	 
	 function getConfigs(){
		    //var dname=document.getElementById("lbldetailname").innerText;
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.split("####");
	  				if(parseInt(items[0]) == 1){  
	  				    $('#btnprint').show();
	  				} else {
	  					$('#btnprint').hide();
	  				}
	  			
	  		}
	  		}
	  		x.open("GET", "getConfig.jsp", true);  
	  		x.send();
	 	}
	 var universalSearchTimer;

	 function universalSearch(inputElement) {
	     var searchText = inputElement.value;
	     
	     // Clear any existing timer
	     clearTimeout(universalSearchTimer);
	     
	     // Show/hide clear button
	     var clearBtn = inputElement.parentElement.querySelector('.clear-search-btn');
	     if (clearBtn) {
	         clearBtn.style.display = searchText ? 'block' : 'none';
	     }
	     
	     // Debounce the search
	     universalSearchTimer = setTimeout(function() {
	         var searchLower = searchText.toLowerCase().trim();
	         
	         // Check which grid is currently visible and apply search
	         if ($('#grid1').is(':visible')) {
	             searchInGrid('jqxFleetGrid', searchLower, inputElement);
	         } else if ($('#grid2').is(':visible')) {
	             searchInGrid('vehiclelist', searchLower, inputElement);
	         } else if ($('#branchwisediv').is(':visible')) {
	             searchInBranchGrid(searchLower, inputElement);
	         }
	     }, 300);
	 }

	 function searchInGrid(gridId, searchText, inputElement) {
		    var grid = $('#' + gridId);
		    if (!grid.length) return;

		    searchText = searchText.toLowerCase().trim();

		    if (!searchText) {
		        // Restore original data
		        grid.jqxGrid('clear');
		        grid.jqxGrid({ source: new $.jqx.dataAdapter({ localdata: originalFleetData }) });
		        updateResultsBadge(inputElement, originalFleetData.length, true);
		        return;
		    }

		    // Filter rows manually
		    var filteredData = originalFleetData.filter(function (row) {
		        for (var key in row) {
		            if (row[key] != null &&
		                row[key].toString().toLowerCase().includes(searchText)) {
		                return true;
		            }
		        }
		        return false;
		    });

		    // Reload grid with filtered data
		    var source = {
		        datatype: "json",
		        localdata: filteredData
		    };

		    grid.jqxGrid('clear');
		    grid.jqxGrid({ source: new $.jqx.dataAdapter(source) });

		    updateResultsBadge(inputElement, filteredData.length, false);
		}


	 function searchInBranchGrid(searchText, inputElement) {
	     // Find the grid in branch-wise div
	     var branchGrid = $('#branchwisediv').find('[id*="Grid"]');
	     if (branchGrid.length > 0) {
	         var gridId = branchGrid.attr('id');
	         if (gridId) {
	             searchInGrid(gridId, searchText, inputElement);
	         }
	     }
	 }

	 function clearUniversalSearch(inputElement) {
	     inputElement.value = '';
	     universalSearch(inputElement);
	     inputElement.focus();
	 }

	 function updateResultsBadge(inputElement, count, isCleared) {
	     var container = inputElement.closest('.grid-container');
	     if (!container) return;
	     
	     var badgeId = 'resultsBadge_' + container.id;
	     var badge = document.getElementById(badgeId);
	     
	     if (!badge) return;
	     
	     if (isCleared || inputElement.value.trim() === '') {
	         badge.style.display = 'none';
	     } else {
	         badge.style.display = 'block';
	         badge.textContent = count + ' result' + (count !== 1 ? 's' : '');
	     }
	 }

	 // Initialize search bars when grids load
	 function initializeSearchBars() {
	     // Make sure clear buttons are hidden initially
	     document.querySelectorAll('.clear-search-btn').forEach(function(btn) {
	         btn.style.display = 'none';
	     });
	 }
	
</script>
</head>
<body onload="getBranch();">
<div class="fleet-status-wrapper">
<div class='hidden-scrollbar'>
<div class="main-container">

<!-- SIDEBAR -->
<div class="sidebar">
    <fieldset>
        <!-- Include heading -->
        
        
        <!-- Detail Checkbox -->
        <div class="checkbox-container">
            <label class="branch">Detail</label>
            <input type="checkbox" id="det_chk" name="det_chk" value="0" onclick="funsetaval()">
        </div>
        
        <!-- Vehicle Details Grid -->
        <div class="grid-container">
            <div id="Readygrid">
                <jsp:include page="vehDetailsgrid.jsp"></jsp:include>
            </div>
        </div>
        
        <!-- Overall Status Button -->
        <div class="submit-container">
            <button type="button" class="myButton" id="btnprint" name="btnprint" onclick="funPrintBtn();">
                Overall Status
            </button>
        </div>
    </fieldset>
</div>

<!-- MAIN CONTENT -->
<div class="main-content">

    <div class="top-toolbar-container">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>
  <div class="grid-container" id="grid1" style="display: none;">
    <div class="compact-search-bar">
        <div class="search-input-wrapper">
            <svg class="search-icon-inline" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <circle cx="11" cy="11" r="8"></circle>
                <path d="m21 21-4.35-4.35"></path>
            </svg>
            <input 
                type="text" 
                class="universal-search-input" 
                placeholder="Search..." 
                onkeyup="universalSearch(this)"
                autocomplete="off"
            />
            <button type="button" class="clear-search-btn" onclick="clearUniversalSearch(this.parentElement.querySelector('input'))">
                X
            </button>
        </div>
        <div id="resultsBadge_grid1" class="search-results-badge" style="display: none;">0 results</div>
    </div>
    <div id="fleetdiv">
        <jsp:include page="readyToRentGrid.jsp"></jsp:include>
    </div>
</div>

<!-- Grid 2 with Search -->
<div class="grid-container" id="grid2" style="display: none;">
    <div class="compact-search-bar">
        <div class="search-input-wrapper">
            <svg class="search-icon-inline" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <circle cx="11" cy="11" r="8"></circle>
                <path d="m21 21-4.35-4.35"></path>
            </svg>
            <input 
                type="text" 
                class="universal-search-input" 
                placeholder="Search all columns..." 
                onkeyup="universalSearch(this)"
                autocomplete="off"
            />
            <button type="button" class="clear-search-btn" onclick="clearUniversalSearch(this.parentElement.querySelector('input'))">
                ✕
            </button>
        </div>
        <div id="resultsBadge_grid2" class="search-results-badge" style="display: none;">0 results</div>
    </div>
    <div id="fleetdiv1">
        <jsp:include page="vehiclelistgrid.jsp"></jsp:include>
    </div>
</div>
    
    <!-- Charts Section -->
    <div id="chart">
        <div class="chart-grid">
            <div class="chart-container">
                <div id='fleetStatus1' style="width: 100%; height: 350px;"></div>
            </div>
            <div class="chart-container">
                <div id='thr1' style="width: 100%; height: 350px;"></div>
            </div>
            <div class="chart-container">
                <div id='sec1' style="width: 100%; height: 350px;"></div>
            </div>
            <div class="chart-container">
                <div id='four1' style="width: 100%; height: 350px;"></div>
            </div>
        </div>
    </div>
    
    <!-- Branch-wise Grid -->
    <div id="branchwisediv" class="grid-container" style="display: none;">
    <div class="compact-search-bar">
        <div class="search-input-wrapper">
            <svg class="search-icon-inline" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <circle cx="11" cy="11" r="8"></circle>
                <path d="m21 21-4.35-4.35"></path>
            </svg>
            <input 
                type="text" 
                class="universal-search-input" 
                placeholder="Search all columns..." 
                onkeyup="universalSearch(this)"
                autocomplete="off"
            />
            <button type="button" class="clear-search-btn" onclick="clearUniversalSearch(this.parentElement.querySelector('input'))">
                ✕
            </button>
        </div>
        <div id="resultsBadge_branchwisediv" class="search-results-badge" style="display: none;">0 results</div>
    </div>
    <jsp:include page="branchwiseGrid.jsp"></jsp:include>
</div>
</div>

</div>

<!-- Hidden Fields -->
<input type="hidden" id="chkgrid" name="chkgrid" value='<s:property value="chkgrid"/>'>
<input type="hidden" id="chkdatails" name="chkdatails" value='<s:property value="chkdatails"/>'>
<input type="hidden" id="emptype" value='<s:property value="chkdatails"/>'>
<input type="hidden" id="empname" value='<s:property value="chkdatails"/>'>

</div>
</div>

</body>
</html>