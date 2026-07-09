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

/* ===== Checkbox Section ===== */

.checkbox-row{
    display:flex;
    align-items:center;
    gap:6px;
}

.checkbox-row input[type="checkbox"]{
    margin:0;
    cursor:pointer;
}

.checkbox-row label{
    font-size:12px;
    color:#333;
    cursor:pointer;
    font-weight:600;
}

/* ===== Readonly Fields ===== */

#txtaccid,
#txtaccname{
    background:#f3f6f9 !important;
}

/* ===== Placeholder ===== */

#txtaccid::placeholder{
    color:#7d8a99;
    font-size:12px;
}

/* ===== Grid ===== */

#prepaidDiv{
    height:100%;
    background:#ffffff;
}

</style>
<script type="text/javascript">

	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
	     var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		  $('#txtaccid').dblclick(function(){
			  accountsSearchContent('accountsDetailsSearch.jsp');
		  });
		 
	});
	
	function accountsSearchContent(url) {
	    $('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getAccount(event){
        var x= event.keyCode;
        if(x==114){
      	  accountsSearchContent('accountsDetailsSearch.jsp');
        } else{}
        }
	
	function funExportBtn(){

		  $("#prepaidDiv").excelexportjs({  
		       		containerid: "prepaidDiv", 
		       		datatype: 'json', 
		       		dataset: null, 
		       		gridId: "prepaidGridID", 
		       		columns: getColumns("prepaidGridID") , 
		       		worksheetName:"Prepaid "
		       		}); 

		// JSONToCSVCon(dataExcelExport, 'Prepaid', true);
	}
	
	function funClearInfo(){

   	 	 $('#cmbbranch').val('a');$('#fromdate').val(new Date());$('#uptodate').val(new Date());$('#cmbreporttype').val('summary');
   	 	 $('#txtaccid').val('');$('#txtaccname').val('');$('#txtdocno').val('');$("#prepaidGridID").jqxGrid('clear');
   		 $("#prepaidGridID").jqxGrid("addrow", null, {});document.getElementById("chckfromdate").checked=false;fromdatecheck();
   	 
   		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		 if (document.getElementById("txtaccid").value == "") {
		        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
		  }
		
	}
	
	function fromdatecheck(){
		 if(document.getElementById("chckfromdate").checked){
			 document.getElementById("hidchckfromdate").value = 1;
			 $('#fromdate').jqxDateTimeInput({ disabled: false});
		 }
		 else{
			 document.getElementById("hidchckfromdate").value = 0;
			 $('#fromdate').jqxDateTimeInput({ disabled: true});
		 }
	 }
	    
	function funreload(event){
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var uptodate = $('#uptodate').val();
		 var chkfromdate = $('#hidchckfromdate').val();
		 var fromdate = $('#fromdate').val();
		 var reporttype = $('#cmbreporttype').val();
		 var accdocno = $('#txtdocno').val();

		 if(reporttype==''){
			 $.messager.alert('Message','Please Choose Report Type.','warning');
			 return 0;
		 }
		 
		 $("#overlay, #PleaseWait").show();
		 
		 $("#prepaidDiv").load("prepaidGrid.jsp?branchval="+branchval+'&uptodate='+uptodate+'&chkfromdate='+chkfromdate+'&fromdate='+fromdate+'&accdocno='+accdocno+'&reporttype='+reporttype+'&check=1');
		 
	}
	
</script>
</head>
<body onload="getBranch();fromdatecheck();">

<div id="mainBG" class="homeContent" data-type="background" style="height:100%;overflow:hidden;box-sizing:border-box;">

<div class="hidden-scrollbar" style="height:100%;box-sizing:border-box;">

<table class="master-layout-table" width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr>

<!-- ================= LEFT PANEL ================= -->

<td width="330" valign="top" style="padding:0;background:#fff;border-right:1px solid #e1e8ed;">

<div class="sidebar-filters">

<div class="sidebar-scroll-content">

<div class="filter-card">

<table class="filter-table">

<tr>

<td colspan="2">

<div class="checkbox-row">

<input type="checkbox"
id="chckfromdate"
name="chckfromdate"
value=""
onchange="fromdatecheck();"
onclick="$(this).attr('value', this.checked ? 1 : 0)" />

<label for="chckfromdate">
Enable From Date
</label>

</div>

<input type="hidden"
id="hidchckfromdate"
name="hidchckfromdate"
value='<s:property value="hidchckfromdate"/>'/>

</td>

</tr>

<tr>

<td class="label-cell">From</td>

<td>

<div id="fromdate"
name="fromdate"
value='<s:property value="fromdate"/>'></div>

</td>

</tr>

<tr>

<td class="label-cell">Up To</td>

<td>

<div id="uptodate"
name="uptodate"
value='<s:property value="uptodate"/>'></div>

</td>

</tr>

</table>

</div>

<div class="filter-card">

<table class="filter-table">

<tr>

<td class="label-cell">Report</td>

<td>

<select id="cmbreporttype"
name="cmbreporttype"
value='<s:property value="cmbreporttype"/>'>

<option value="">--Select--</option>
<option value="summary" selected>Summary</option>
<option value="detail">Detail</option>

</select>

</td>

</tr>

</table>

</div>

<div class="filter-card">

<table class="filter-table">

<tr>

<td class="label-cell">Account</td>

<td>

<input type="text"
id="txtaccid"
name="txtaccid"
readonly="readonly"
placeholder="Press F3 to Search"
value='<s:property value="txtaccid"/>'
onkeydown="getAccount(event);" />

</td>

</tr>

<tr>

<td></td>

<td>

<input type="text"
id="txtaccname"
name="txtaccname"
readonly="readonly"
value='<s:property value="txtaccname"/>' />

<input type="hidden"
id="txtdocno"
name="txtdocno"
value='<s:property value="txtdocno"/>'/>

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

<td valign="top" style="padding:15px;background:#fff;">

<div style="display:flex;flex-direction:column;height:100%;">

<div style="margin-bottom:10px;">

<jsp:include page="../../heading.jsp"></jsp:include>

</div>

<div id="prepaidDiv" style="flex:1;overflow:auto;">

<jsp:include page="prepaidGrid.jsp"></jsp:include>

</div>

</div>

</td>

</tr>

</table>

</div>

</div>

<div id="accountDetailsWindow">
    <div></div>
    <div></div>
</div>

</body>
</html>