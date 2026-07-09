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


/* ===== Radio Button Cards ===== */

.radio-table{
    width:100%;
    border-collapse:collapse;
}

.radio-table td{
    text-align:center;
    padding:5px 0;
    font-size:12px;
    color:#333;
}

.radio-table input[type="radio"]{
    margin-right:5px;
    vertical-align:middle;
}

.radio-table label{
    cursor:pointer;
}

/* ===== Readonly Account Fields ===== */

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

#pdcOutStandingDiv{
    height:100%;
    background:#fff;
}

</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	  
	     document.getElementById("rdpayment").checked=true;
	     document.getElementById("rdall").checked=true;
	     
		 $('#txtaccid').dblclick(function(){
			 if($('#cmbtype').val()==''){
    			 $.messager.alert('Message','Please Choose Account Type.','warning');
    			 return 0;
    		 }
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
	
	function getAccTypeFrom(event){
        var x= event.keyCode;
        if(x==114){
    		if($('#cmbtype').val()==''){
    			 $.messager.alert('Message','Please Choose Account Type.','warning');
    			 return 0;
    		 }
      		accountsSearchContent('accountsDetailsSearch.jsp');
        }
        else{}
        }
	
	function clearAccountInfo(){
		$('#txtdocno').val('');$('#txtaccid').val('');$('#txtaccname').val('');
		
		if (document.getElementById("txtaccid").value == "") {
	        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
	    }

	}
	
	function  funClearInfo(){
		
	    $('#uptodate').val(new Date());
	    
		document.getElementById("rdpayment").checked=true;
		document.getElementById("rdall").checked=true;
		
		$('#cmbbranch').val('a');
	    $('#cmbtype').val('0');
		$('#txtdocno').val('');$('#txtaccid').val('');$('#txtaccname').val('');
		
		$("#pdcOutStandingGridID").jqxGrid('clear');
		$("#pdcOutStandingGridID").jqxGrid('addrow', null, {});
		
		if (document.getElementById("txtaccid").value == "") {
	        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
	    }
		
	}

	function funreload(event){
			 var branchval = document.getElementById("cmbbranch").value;
			 var uptodate = $('#uptodate').val();
			 var acctype = $('#cmbtype').val();
			 var accno = $('#txtdocno').val();
			 var reporttype = "";
			 
			 if(document.getElementById("rdall").checked==true){
				 reporttype = $('#rdall').val();
			 }else if(document.getElementById("rdpdc").checked==true){
				 reporttype = $('#rdpdc').val();
			 }else if(document.getElementById("rduncleared").checked==true){
				 reporttype = $('#rduncleared').val();
			 }
			 
			   $("#overlay, #PleaseWait").show();
			 
			   if(document.getElementById("rdreceipt").checked==true){
					  $("#pdcOutStandingDiv").load("pdcOutStandingGrid.jsp?code=FRO&reporttype="+reporttype+'&branchval='+branchval+'&uptodate='+uptodate+'&acctype='+acctype+'&accno='+accno+'&check=1');								 
			   } else {
					  $("#pdcOutStandingDiv").load("pdcOutStandingGrid.jsp?code=FPP&reporttype="+reporttype+'&branchval='+branchval+'&uptodate='+uptodate+'&acctype='+acctype+'&accno='+accno+'&check=1');								 
			   }
			}
	
	function funExportBtn(){
   		if(parseInt(window.parent.chkexportdata.value)=="1") {
   		  	JSONToCSVCon(data, 'PdcOutStanding', true);
   		 } else {
   			 $("#pdcOutStandingGridID").jqxGrid('exportdata', 'xls', 'PdcOutStanding');
   		 }
	}
		
</script>

</head>
<body onload="getBranch();">

<div id="mainBG" class="homeContent" data-type="background" style="height:100%;overflow:hidden;">

<div class="hidden-scrollbar" style="height:100%;">

<table class="master-layout-table" width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr>

<td width="330px" valign="top" style="border-right:1px solid #e1e8ed;">

<div class="sidebar-filters">

<div class="sidebar-scroll-content">

<div class="filter-card">

<table class="filter-table">

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

<div class="section-title">Type</div>

<table class="radio-table">

<tr>

<td>

<input type="radio" id="rdall" name="rdos" value="rdall">

<label for="rdall">All</label>

</td>

<td>

<input type="radio" id="rdpdc" name="rdos" value="rdpdc">

<label for="rdpdc">PDC</label>

</td>

</tr>

<tr>

<td colspan="2">

<input type="radio" id="rduncleared" name="rdos" value="rduncleared">

<label for="rduncleared">Uncleared</label>

</td>

</tr>

</table>

</div>

<div class="filter-card">

<div class="section-title">Report Type</div>

<table class="radio-table">

<tr>

<td>

<input type="radio" id="rdpayment" name="rdo" value="FPP">

<label for="rdpayment">Payment</label>

</td>

<td>

<input type="radio" id="rdreceipt" name="rdo" value="FRO">

<label for="rdreceipt">Receipt</label>

</td>

</tr>

</table>

</div>

<div class="filter-card">

<table class="filter-table">

<tr>

<td class="label-cell">Type</td>

<td>

<select id="cmbtype"
name="cmbtype"
onchange="clearAccountInfo();"
value='<s:property value="cmbtype"/>'>

<option value="0">--Select--</option>
<option value="BANK">Bank</option>
<option value="AP">AP</option>
<option value="AR">AR</option>

</select>

</td>

</tr>

<tr>

<td class="label-cell">Account</td>

<td>

<input type="text"
id="txtaccid"
name="txtaccid"
readonly="readonly"
placeholder="Press F3 to Search"
value='<s:property value="txtaccid"/>'
onkeydown="getAccTypeFrom(event);" />

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

<td valign="top" style="padding:15px;background:#fff;">

<div style="display:flex;flex-direction:column;height:100%;">

<div style="margin-bottom:10px;">

<jsp:include page="../../heading.jsp"></jsp:include>

</div>

<div id="pdcOutStandingDiv" style="flex:1;overflow:auto;">

<jsp:include page="pdcOutStandingGrid.jsp"></jsp:include>

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