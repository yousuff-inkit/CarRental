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
/* ===== AGGRESSIVE OVERRIDES TO DESTROY BLUE BACKGROUNDS & HOVERS ===== */
html, body, #mainBG, .homeContent, .hidden-scrollbar {
    height: 100%;
    margin: 0 !important;
    padding: 0 !important;
    overflow: hidden !important;
    background-color: #ffffff !important;
    background: #ffffff !important;
    background-image: none !important;
    box-sizing: border-box;
}
/* Force layout tables to white */
.master-layout-table, .master-layout-table > tbody > tr, .master-layout-table > tbody > tr > td {
    background-color: #ffffff !important;
    background: #ffffff !important;
}
/* Forcefully kill all hover states on tables applied by external CSS */
table tr:hover, table td:hover, table th:hover, tbody tr:hover {
    background-color: transparent !important;
    background: transparent !important;
}

/* ===== MASTER LAYOUT ===== */
.sidebar-filters {
    width: 330px;
    background: #ffffff !important;
    height: 100%; 
    box-sizing: border-box;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
}

/* Inline Flow CSS - Buttons naturally follow the inputs */
.sidebar-scroll-content {
    height: 100%;
    overflow-y: auto;
    padding: 15px 20px !important;
    box-sizing: border-box;
}

.sidebar-fixed-bottom {
    margin-top: 15px;
    padding: 0;
    background: transparent;
}

/* Cards */
.filter-card {
    background: #f8fafc !important;
    border: 1px solid #e3e8ee;
    border-radius: 8px;
    padding: 15px; 
    margin-bottom: 12px;
}
/* Tables within the card */
.filter-table {
    width: 100%;
    border-spacing: 0 10px; 
    background: transparent !important;
}
.filter-table tr, .filter-table td {
    background: transparent !important;
    border: none !important;
}
.filter-table .label-cell {
    text-align: right;
    padding-right: 12px;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    width: 90px;
    white-space: nowrap; 
}
/* ===== UNIFORM 24px INPUTS & SELECTS ===== */
input[type="text"], select, .filter-table input[type="text"], .filter-table select {
    width: 100%;
    height: 24px !important;             
    padding: 2px 8px !important;         
    border: 1px solid #ccd6e0 !important;
    border-radius: 4px !important;       
    font-size: 12px !important;          
    background-color: #ffffff !important;
    box-sizing: border-box;
    color: #333;
    outline: none;
}
select {
    padding: 2px 24px 2px 8px !important; 
    font-family: inherit;
    cursor: pointer;
    appearance: none;
    -webkit-appearance: none;
    background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%234e5e71' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
    background-repeat: no-repeat;
    background-position: right 6px center;
    background-size: 12px;
}
input[readonly], input:disabled, select:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    cursor: pointer;
}
/* ===== BUTTONS ===== */
.button-group {
    display: flex;
    gap: 10px;
    justify-content: center;
}
.btn-submit, .myButton, .myButtons {
    flex: 1;
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
    text-align: center;
    transition: background 0.2s;
    width: 100%;
    margin-top: 0;
}
.btn-submit:hover, .myButton:hover, .myButtons:hover { background: #1d4ed8 !important; }
.btn-submit:disabled, .myButton:disabled, .myButtons:disabled { background: #9ca3af !important; cursor: not-allowed; }
</style>
<style type="text/css">

/* ===== Report Type ===== */

.section-title{
    text-align:center;
    font-size:12px;
    font-weight:600;
    color:#4e5e71;
    margin-bottom:10px;
}

.radio-table{
    width:100%;
    border-collapse:collapse;
}

.radio-table td{
    text-align:center;
    padding:5px 0;
    font-size:12px;
}

.radio-table input[type="radio"]{
    margin-right:5px;
}

.radio-table label{
    cursor:pointer;
    color:#333;
}

/* ===== Readonly Search Fields ===== */

#txtfleet,
#txtgroup,
#txtmodel{
    background:#f3f6f9 !important;
}

#txtfleet::placeholder,
#txtgroup::placeholder,
#txtmodel::placeholder{
    color:#7d8a99;
}

/* ===== Grid ===== */

#assetDiv{
    height:100%;
    background:#ffffff;
}

</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $('#fleetDetailsWindow').jqxWindow({width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Fleet Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#fleetDetailsWindow').jqxWindow('close');
	     
		 $('#groupDetailsWindow').jqxWindow({width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Group Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	     $('#groupDetailsWindow').jqxWindow('close');
	     
	     $('#modelDetailsWindow').jqxWindow({width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Model Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	     $('#modelDetailsWindow').jqxWindow('close');
		   
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	     document.getElementById("rdall").checked=true;
	     
	});
	
	function funExportBtn(){
	   // JSONToCSVConvertor(dataExcelExport, 'VehicleAssetRegister', true);

        $("#assetDiv").excelexportjs({
				containerid: "assetDiv",   
				datatype: 'json',
				dataset: null,
				gridId: "vehicleAssetGrid",
				columns: getColumns("vehicleAssetGrid") ,   
				worksheetName:"Vehicle Asset Register"  
			});   
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

	
	function fleetSearchContent(url) {
	    $('#fleetDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#fleetDetailsWindow').jqxWindow('setContent', data);
		$('#fleetDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function groupSearchContent(url) {
	    $('#groupDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#groupDetailsWindow').jqxWindow('setContent', data);
		$('#groupDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function modelSearchContent(url) {
	    $('#modelDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#modelDetailsWindow').jqxWindow('setContent', data);
		$('#modelDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getFleet(event){
        var x= event.keyCode;
        if(x==114){
        	fleetSearchContent('fleetSearchGrid.jsp');
        }
        else{}
        }
	
	function getGroup(event){
        var x= event.keyCode;
        if(x==114){
        	groupSearchContent('groupSearchGrid.jsp');
        }
        else{}
        }
	
	function getModel(event){
        var x= event.keyCode;
        if(x==114){
        	modelSearchContent('modelSearchGrid.jsp');
        }
        else{}
        }
	
	function funSearchdblclick(){
		  $('#txtfleet').dblclick(function(){
			  fleetSearchContent('fleetSearchGrid.jsp');
			});
		  
		  $('#txtgroup').dblclick(function(){
			  groupSearchContent('groupSearchGrid.jsp');
			});
		  
		  $('#txtmodel').dblclick(function(){
			  modelSearchContent('modelSearchGrid.jsp');
			});
	}

	function funreload(event){
		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var fleetno = $('#txtfleet').val();
		 var group = $('#txtgroupno').val();
		 var model = $('#txtmodelid').val();
		 var check=1;
		 
		 $("#overlay, #PleaseWait").show();
		 
		 if(document.getElementById("rdall").checked==true){
			 $("#assetDiv").load("vehicleAssetRegisterGrid.jsp?rpttype=1&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&fleetno='+fleetno+'&group='+group+'&model='+model+'&check='+check);
		 	
		 }else if(document.getElementById("rdsold").checked==true){
			 $("#assetDiv").load("vehicleAssetRegisterGrid.jsp?rpttype=2&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&fleetno='+fleetno+'&group='+group+'&model='+model+'&check='+check);
			 
		 }else{
			 $("#assetDiv").load("vehicleAssetRegisterGrid.jsp?rpttype=3&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&fleetno='+fleetno+'&group='+group+'&model='+model+'&check='+check);
		   }
		}
	
	function  funClearInfo(){
		
		$('#fromdate').val(new Date());
		var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');;
	    var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	    var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	    $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	    $('#todate').val(new Date());
	    
		document.getElementById("txtfleet").value="";
		document.getElementById("txtmodel").value="";
		document.getElementById("txtmodelid").value="";
		document.getElementById("txtgroup").value="";
		document.getElementById("txtgroupno").value="";
		
		document.getElementById("rdall").checked=true;
		
		 if (document.getElementById("txtmodel").value == "") {
		        $('#txtmodel').attr('placeholder', 'Press F3 to Search'); 
		    }
		
		 if (document.getElementById("txtgroup").value == "") {
		        $('#txtgroup').attr('placeholder', 'Press F3 to Search'); 
		    }
		 
		 if (document.getElementById("txtfleet").value == "") {
		        $('#txtfleet').attr('placeholder', 'Press F3 to Search'); 
		    }
			
		}

</script>
</head>
<body onload="getBranch();">

<div id="mainBG" class="homeContent" data-type="background" style="height:100%;overflow:hidden;box-sizing:border-box;">

<div class="hidden-scrollbar" style="height:100%;box-sizing:border-box;">

<table class="master-layout-table"
       width="100%"
       height="100%"
       cellpadding="0"
       cellspacing="0"
       border="0"
       style="table-layout:fixed;background:#fff;height:100%;">

<tr>

<!-- ================= LEFT PANEL ================= -->

<td width="330"
    valign="top"
    style="padding:0;background:#fff;border-right:1px solid #e1e8ed;">

<div class="sidebar-filters">

<div class="sidebar-scroll-content">

<div class="filter-card">

<table class="filter-table">

<tr>
<td class="label-cell">From</td>
<td>
<div id="fromdate"
name="fromdate"
value='<s:property value="fromdate"/>'></div>
</td>
</tr>

<tr>
<td class="label-cell">To</td>
<td>
<div id="todate"
name="todate"
value='<s:property value="todate"/>'></div>
</td>
</tr>

</table>

</div>

<div class="filter-card">

<table class="filter-table">

<tr>

<td class="label-cell">
Fleet
</td>

<td>

<input type="text"
id="txtfleet"
name="txtfleet"
readonly="readonly"
placeholder="Press F3 to Search"
value='<s:property value="txtfleet"/>'
ondblclick="funSearchdblclick();"
onkeydown="getFleet(event);" />

</td>

</tr>

<tr>

<td class="label-cell">
Group
</td>

<td>

<input type="text"
id="txtgroup"
name="txtgroup"
readonly="readonly"
placeholder="Press F3 to Search"
value='<s:property value="txtgroup"/>'
ondblclick="funSearchdblclick();"
onkeydown="getGroup(event);" />

<input type="hidden"
id="txtgroupno"
name="txtgroupno"
value='<s:property value="txtgroupno"/>'/>

</td>

</tr>

<tr>

<td class="label-cell">
Model
</td>

<td>

<input type="text"
id="txtmodel"
name="txtmodel"
readonly="readonly"
placeholder="Press F3 to Search"
value='<s:property value="txtmodel"/>'
ondblclick="funSearchdblclick();"
onkeydown="getModel(event);" />

<input type="hidden"
id="txtmodelid"
name="txtmodelid"
value='<s:property value="txtmodelid"/>'/>

</td>

</tr>

</table>

</div>

<div class="filter-card">

<div class="section-title">
Report Type
</div>

<table class="radio-table">

<tr>

<td>

<input type="radio"
id="rdall"
name="rdo"
value="rdall">

<label for="rdall">All</label>

</td>

<td>

<input type="radio"
id="rdsold"
name="rdo"
value="rdsold">

<label for="rdsold">Sold</label>

</td>

</tr>

<tr>

<td colspan="2">

<input type="radio"
id="rdadditions"
name="rdo"
value="rdadditions">

<label for="rdadditions">
Additions
</label>

</td>

</tr>

</table>

</div>

<div class="sidebar-fixed-bottom">

<div class="button-group">

<input type="button"
class="myButtons"
name="clear"
id="clear"
value="Clear"
onclick="funClearInfo();">

</div>

</div>

</div>

</div>

</td>

<!-- ================= RIGHT PANEL ================= -->

<td valign="top"
    style="padding:15px;background:#ffffff;height:100%;">

<div style="display:flex;flex-direction:column;height:100%;box-sizing:border-box;">

<div style="width:100%;margin-bottom:10px;flex-shrink:0;">

<jsp:include page="../../heading.jsp"></jsp:include>

</div>

<div id="assetDiv"
     style="flex:1;overflow:auto;min-height:0;">

<jsp:include page="vehicleAssetRegisterGrid.jsp"></jsp:include>

</div>

</div>

</td>

</tr>

</table>

</div>

</div>

<div id="fleetDetailsWindow">
    <div></div>
    <div></div>
</div>

<div id="groupDetailsWindow">
    <div></div>
    <div></div>
</div>

<div id="modelDetailsWindow">
    <div></div>
    <div></div>
</div>

</body>
</html>