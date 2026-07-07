
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
html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
    background-color: #f4f7f9;
}

.master-container {
    display: flex;
    width: 100%;
    height: 100vh;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

/* ===== LEFT SIDEBAR ===== */
.sidebar-filters {
    width: 280px; 
    flex: 0 0 280px; 
    background: #fff;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100%;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
    z-index: 10;
}

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 15px 25px; 
}

/* Cards Layout Rules */
.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

/* Internal Presentation Tables */
.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.filter-table .label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    width: 80px;
}

/* ===== UNIFORM 24px INPUTS & SELECTS & TEXTAREA ===== */
input[type="text"], select, textarea,
.filter-table input[type="text"],
.filter-table select,
.filter-table textarea {
    width: 100%;
    height: 24px !important;             
    padding: 2px 8px !important;         
    border: 1px solid #ccd6e0 !important;
    border-radius: 4px !important;       
    font-size: 12px !important;          
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
    outline: none;
    font-family: inherit;
}

/* Textarea specific override for height */
textarea, .filter-table textarea {
    height: 180px !important;
    resize: none;
    padding: 8px !important;
}

/* Readonly fields override */
input[readonly],
textarea[readonly],
input:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed;
}

/* jqx Date Container Mapping Rules */
.filter-table div[id^="fromdate"],
.filter-table div[id^="todate"] {
    width: 100%;
}

/* ===== MASTER 30px BUTTON SYSTEM ===== */
.btn-submit {
    width: 100%;
    height: 30px !important;            
    padding: 0 12px !important;
    background: #2563eb !important;
    color: #fff !important;
    border: none !important;
    border-radius: 4px !important;
    font-size: 13px !important;
    font-weight: 600 !important;
    cursor: pointer;
    line-height: 30px !important;
    white-space: nowrap;
    text-align: center;
    transition: all 0.2s ease;
    box-shadow: none !important;
    display: inline-block;
    box-sizing: border-box;
}

.btn-submit:hover {
    background: #1d4ed8 !important;
}

.btn-submit:disabled {
    background: #9ca3af !important;
    color: #f3f4f6 !important;
    cursor: not-allowed;
}

/* ===== RIGHT CONTENT AREA (Dynamically fills screen) ===== */
.main-content-area {
    flex: 1; 
    display: flex;
    flex-direction: column;
    background: #ffffff;
    height: 100%;
    overflow: hidden;
}

.top-toolbar-container {
    width: 100%;
    padding: 10px 15px;
    background: #ffffff;
    border-bottom: 1px solid #e1e8ed;
    box-sizing: border-box;
}

.scrollable-grid-area {
    flex: 1;
    padding: 15px;
    overflow: auto; 
    box-sizing: border-box;
}
</style>
  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
	
	
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	 $('#driverwindow').jqxWindow({ width: '30%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Driver Search' , position: { x: 200, y: 60 }, keyboardCloseKey: 27});
	 $('#driverwindow').jqxWindow('close');
	     
	     
	     
	 $('#driver').dblclick(function(){
	  	    $('#driverwindow').jqxWindow('open');
	   
	       driverSearchContent('driverSearch.jsp?', $('#driverwindow')); 
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




function driverSearchContent(url) {
 	 //alert(url);
 		 $.get(url).done(function (data) {
 			 
 			 $('#driverwindow').jqxWindow('open');
 		$('#driverwindow').jqxWindow('setContent', data);
 
 	}); 
 	} 

function getDriverData(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#driverwindow').jqxWindow('open');


	  driverSearchContent('driverSearch.jsp?', $('#driverwindow'));     }
	 else{
		 }
	 }

function funreload(event)
{
	 var driver = document.getElementById("hiddriver").value;

	 if(driver=="")
		 {
		   $.messager.alert('Message','Search Driver  ','warning'); 
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
	  $("#drvdiv").load("driverMovementGrid.jsp?driver="+driver+"&fromdate="+fromdate+"&todate="+todate+"&ready=1");
	  $("#drvsummdiv").load("driverSummaryGrid.jsp?driver="+driver+"&fromdate="+fromdate+"&todate="+todate);
		   }
		 }
	
	}
function hiddenbrh(){
	
	$("#branchlabel").attr('hidden',true);
	$("#branchdiv").attr('hidden',true);
	
}

function funPrintMov(){
	var driver = document.getElementById("hiddriver").value;

	 if(driver=="")
		 {
		   $.messager.alert('Message','Search Driver  ','warning'); 
		   return false;
		 }
	 else
		 {
    var url=document.URL;
    var reurl=url.split("driverMovement.jsp");
  
    var win= window.open(reurl[0]+"printDriverMov?driver="+document.getElementById("hiddriver").value+'&fromdate='+$("#fromdate").val()+'&todate='+$("#todate").val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
    win.focus();
		 }
}

function funExportBtn(){
	var aa=$('#driver').val();
	JSONToCSVConvertor(exedata, 'Driver Movement \n\nDriver  :  '+aa, true);
	JSONToCSVConvertor(drvsummaryexcel, 'Driver Movement Summary :  '+aa, true);
	
}

function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
	
    var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
    
    var CSV = '';    
    
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

</script>
</head>
<body onload="hiddenbrh();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class="hidden-scrollbar">

<div class="master-container">

    <!-- ================= LEFT PANEL (SIDEBAR) ================= -->
    <div class="sidebar-filters">
        <div class="sidebar-scroll-content">

            <!-- Primary Filters Card -->
            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Driver</td>
                        <td>
                            <input type="text" id="driver" name="driver" placeholder="Press F3 To Search" readonly value='<s:property value="driver"/>' onkeydown="getDriverData(event);">
                            <input type="hidden" name="hiddriver" id="hiddriver" value='<s:property value="hiddriver"/>'>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">From</td>
                        <td>
                            <div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">To</td>
                        <td>
                            <div id="todate" name="todate" value='<s:property value="todate"/>'></div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <textarea id="drvinfo" name="drvinfo" readonly><s:property value="drvinfo"/></textarea>
                        </td>
                    </tr>
                </table>
            </div>

            <!-- Action Button Card -->
            <div class="filter-card">
                <button type="button" class="btn-submit" id="btnPrint" onclick="funPrintMov(event);">Print</button>
            </div>

            <!-- Chart Card -->
            <div class="filter-card">
                <div id="paychaaaaa" style="width:100%; height:125px;"></div>
            </div>

        </div>
    </div>

    <!-- ================= RIGHT PANEL (WORKSPACE) ================= -->
    <div class="main-content-area">
        
        <!-- Horizontally Aligned Toolbar -->
        <div class="top-toolbar-container">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>

        <!-- Scrollable Workspace Grids -->
        <div class="scrollable-grid-area">
            <div id="drvdiv">
                <jsp:include page="driverMovementGrid.jsp"></jsp:include>
            </div>
            
            <div id="drvsummdiv" style="margin-top: 20px;">
                <jsp:include page="driverSummaryGrid.jsp"></jsp:include>
            </div>
        </div>

    </div>

</div>

<!-- Popups / Modals -->
<div id="driverwindow"><div></div></div>

</div>
</div>
</body>

</html>