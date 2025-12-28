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

.fleet-status-wrapper {
    --shadow-light: #ffffff;
    --shadow-dark: #d0d0d0;
    --primary-color: #2c3e50;
    --secondary-color: #34495e;
    font-family: 'Poppins', sans-serif;
    background: #ffffff;
    height: 100vh;
    width: 100vw;
    padding: 12px;
    overflow: hidden;
    box-sizing: border-box;
}

/* Custom Scrollbar */
.fleet-status-wrapper::-webkit-scrollbar,
.fleet-status-wrapper *::-webkit-scrollbar {
    width: 6px;
    height: 6px;
}

.fleet-status-wrapper::-webkit-scrollbar-track,
.fleet-status-wrapper *::-webkit-scrollbar-track {
    background: #f1f1f1;
    border-radius: 10px;
}

.fleet-status-wrapper::-webkit-scrollbar-thumb,
.fleet-status-wrapper *::-webkit-scrollbar-thumb {
    background: #b0b0b0;
    border-radius: 10px;
}

.fleet-status-wrapper::-webkit-scrollbar-thumb:hover,
.fleet-status-wrapper *::-webkit-scrollbar-thumb:hover {
    background: #909090;
}


.fleet-status-wrapper .main-container {
    display: flex;
    flex-direction: row;
    gap: 12px;
    height: calc(100vh-16px);
    width: 100%;
    max-width: 100%;
    margin: 0;
    box-sizing: border-box;
    
}

/* Sidebar - Fixed Width - INCREASED MORE */
.fleet-status-wrapper .sidebar {
    flex: 0 0 400px;
    min-width: 450px;
    max-width: 450px;
    background: rgba(255, 255, 255, 0.9);
    border-radius: 12px;
    padding: 14px;
    box-shadow: -2px -2px 6px rgba(255, 255, 255, 0.8),
                2px 2px 6px rgba(0, 0, 0, 0.08);
    overflow-y: auto;
    overflow-x: hidden;
    min-height: calc(100vh - 120px);
    box-sizing: border-box;
}


.fleet-status-wrapper .main-content {
    flex: 1;
    min-width: 0;
    background: rgba(255, 255, 255, 0.95);
    border-radius: 12px;
    padding: 14px;
  	overflow-y: auto;
    overflow-x: visible;   
    min-height: calc(100vh - 40px);
    box-shadow: -2px -2px 8px rgba(255, 255, 255, 0.8),
                2px 2px 8px rgba(0, 0, 0, 0.08);
    box-sizing: border-box;
}


.fleet-status-wrapper fieldset {
    border: 1px solid #e0e0e0;
    border-radius: 10px;
    background: rgba(255, 255, 255, 0.9);
    padding: 12px;
    margin: 0;
}

.fleet-status-wrapper .checkbox-container {
    display: flex;
    align-items: center;
    gap: 8px;
    margin: 10px 0;
    padding: 8px 10px;
    background: rgba(255, 255, 255, 0.5);
    border-radius: 8px;
}

.fleet-status-wrapper input[type="checkbox"] {
    width: 16px;
    height: 16px;
    cursor: pointer;
}

.fleet-status-wrapper .branch {
    font-size: 13px;
    font-weight: 600;
    color: var(--primary-color);
    margin: 0;
}


.fleet-status-wrapper .grid-container {
    background: rgba(255, 255, 255, 0.9);
    border-radius: 10px;
    padding: 12px;
    margin: 6px 0;
    box-shadow: -2px -2px 6px rgba(255, 255, 255, 0.8),
                2px 2px 6px rgba(0, 0, 0, 0.08);
    max-width: 100%;
    overflow: visible;
}


.fleet-status-wrapper .sidebar .grid-container {
    padding: 12px;
    margin: 12px 0;
}

.fleet-status-wrapper .sidebar .grid-container table {
    width: 100%;
    max-width: 100%;
    table-layout: fixed;
    font-size: 11px;
    max-height:50px;
}

.fleet-status-wrapper .sidebar .grid-container table td {
    padding: 4px;
    word-wrap: break-word;
}


.fleet-status-wrapper .myButton {
    width: 100%;
    padding: 8px 12px;
    border-radius: 10px;
    background: linear-gradient(145deg, #ffffff, #f5f5f5);
    border: 1px solid #e0e0e0;
    color: var(--primary-color);
    font-weight: 600;
    font-size: 12px;
    font-family: "Poppins", sans-serif;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 6px;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: -2px -2px 6px rgba(255, 255, 255, 0.9),
                2px 2px 6px rgba(0, 0, 0, 0.1);
}

.fleet-status-wrapper .myButton:hover {
    transform: translateY(-1px);
    background: linear-gradient(145deg, #ffffff, #eeeeee);
    box-shadow: -3px -3px 8px rgba(255, 255, 255, 1),
                3px 3px 8px rgba(0, 0, 0, 0.12);
}

.fleet-status-wrapper .submit-container {
    margin-top: 10px;
}


.fleet-status-wrapper .chart-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 14px;
    margin: 12px 0;
}

.fleet-status-wrapper .chart-container {
    background: rgba(255, 255, 255, 0.95);
    border-radius: 10px;
    padding: 12px;
    box-shadow: -2px -2px 6px rgba(255, 255, 255, 0.8),
                2px 2px 6px rgba(0, 0, 0, 0.08);
    height: 200px;
}

.fleet-status-wrapper .chart-container > div {
    height: 100% !important;
}

.fleet-status-wrapper .compact-search-bar {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 12px;
}

.fleet-status-wrapper .search-input-wrapper {
    flex: 1;
    position: relative;
    max-width: 350px;
}

.fleet-status-wrapper .search-icon-inline {
    position: absolute;
    left: 10px;
    top: 50%;
    transform: translateY(-50%);
    color: #94a3b8;
    pointer-events: none;
}

.fleet-status-wrapper .universal-search-input {
    width: 100%;
    padding: 8px 35px 8px 35px;
    border: 2px solid #e2e8f0;
    border-radius: 8px;
    font-size: 13px;
    font-weight: 500;
    color: var(--primary-color);
    background: white;
    transition: all 0.3s ease;
    font-family: 'Poppins', sans-serif;
}

.fleet-status-wrapper .universal-search-input:focus {
    outline: none;
    border-color: #3498db;
    box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
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
    font-weight: 600;
}

.fleet-status-wrapper .clear-search-btn:hover {
    background: #fee;
    color: #e74c3c;
}

.fleet-status-wrapper .search-results-badge {
    padding: 5px 10px;
    background: linear-gradient(135deg, #e8f4fd, #d4e9f7);
    color: #3498db;
    border-radius: 6px;
    font-size: 12px;
    font-weight: 600;
    white-space: nowrap;
}


.hidden-scrollbar {
    height: 100vh;
    width: 100vw;
    overflow: hidden;
    box-sizing: border-box;
}

/* Make sure charts fit properly */
#fleetStatus1, #sec1, #thr1, #four1 {
    width: 100% !important;
    height: 100% !important;
}


.jqx-grid-content {
    overflow-x: scroll !important;
    overflow-y: auto !important;
}

/* Branch-wise div */
.fleet-status-wrapper #branchwisediv > div:not(.compact-search-bar) {
    max-height: calc(100vh - 300px);
    overflow-y: auto;
}

/* Responsive adjustments */
@media (max-width: 1400px) {
    .fleet-status-wrapper .sidebar {
        flex: 0 0 400px;
        min-width: 400px;
        max-width: 400px;
    }
}

@media (max-width: 1200px) {
    .fleet-status-wrapper .sidebar {
        flex: 0 0 400px;
        min-width: 400px;
        max-width: 400px;
    }
}

@media (max-width: 1024px) {
    .fleet-status-wrapper .sidebar {
        flex: 0 0 400px;
        min-width: 300px;
        max-width: 400px;
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
    }
    
    .fleet-status-wrapper .main-content {
        height: auto;
        flex: 1;
    }
}
.jqx-grid {
    overflow: visible !important;
}

.jqx-grid-content {
    overflow-x: auto !important;
    overflow-y: auto !important;
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
        <jsp:include page="../../heading.jsp"></jsp:include>
        
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
  <div class="grid-container" id="grid1" style="display: none;">
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
                <div id='fleetStatus1' style="width: 100%; height: 250px;"></div>
            </div>
            <div class="chart-container">
                <div id='thr1' style="width: 100%; height: 250px;"></div>
            </div>
            <div class="chart-container">
                <div id='sec1' style="width: 100%; height: 250px;"></div>
            </div>
            <div class="chart-container">
                <div id='four1' style="width: 100%; height: 250px;"></div>
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