
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
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 


<style type="text/css">
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

/* 🔹 Inputs + Dropdowns */
input[type="text"],
select {
    width: 100%;
    height: 24px !important;
    padding: 0 8px !important;
    border: 1px solid #ccd6e0;
    border-radius: 4px;
    font-size: 13px;
    box-sizing: border-box;
    line-height: 24px;
}

/* 🔹 Dropdown text */
select {
    font-size: 13px !important;
}

/* 🔹 Buttons */
.btn-submit,
.myButtons,
.myButton,
input[type="button"],
button {
    width: 100%;
    height: 24px !important;
    padding: 0 10px !important;
    border-radius: 4px;
    font-size: 13px;
    font-weight: 600;
    box-sizing: border-box;
    line-height: 24px;
}

/* 🔹 Fix for any library overriding (like jqx / external CSS) */
.jqx-widget input,
.jqx-widget select {
    height: 24px !important;
    line-height: 24px !important;
}
</style>









<script type="text/javascript">

$(document).ready(function () {
	

	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");


		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '60%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
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
	 
	 
     $('#acno').dblclick(function(){
 	 
  		  
		  $('#accountDetailsWindow').jqxWindow('open');
		 commenSearchContent('accountsDetailsSearch.jsp?');
 		    
 		   
	  }); 
	  
});
function  getacc(event){
	 var x= event.keyCode;
	 if(x==114){
	
	  $('#accountDetailsWindow').jqxWindow('open');
	
	 commenSearchContent('accountsDetailsSearch.jsp?');
	 }
	 }   
function commenSearchContent(url) {
	 
		 $.get(url).done(function (data) {
			 
			 $('#accountDetailsWindow').jqxWindow('open');
		$('#accountDetailsWindow').jqxWindow('setContent', data);

	}); 
	} 	



function funExportBtn(){
	  /*  $("#orderlist").jqxGrid('exportdata', 'xls', 'NI Puchase Reports'); */
	JSONToCSVCon(nipurchaseExcelExport, 'NI Purchase Report', true); 
	 }


function funreload(event)
{

	  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
	  // out date
	 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	 	 
	   if(fromdates>todates){
		   
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		 
	   return false;
	  } 
	   else
		   {
		   
		   var fromdocno=$("#fromdocno").val();
		   var todocno=$("#todocno").val();   
		   var fromamount=$("#fromamount").val();  
		   var toamount=$("#toamount").val(); 
		   
		   if(fromdocno!="")
			   {
			   if(todocno=="")
				   {
				   
				   $.messager.alert('Message','Enter To Doc No ','warning');   
					 
				   return false;
				   
				   }
			   else if(parseInt(todocno)<parseInt(fromdocno))
				   {
				   
				   $.messager.alert('Message','To Doc No Less Than From Doc No','warning');   
					 
				   return false;
				   
				   }
			   
			   
			   
			   }
		   
		   if(fromamount!="")
		   {
		   if(toamount=="")
			   {
			   
			   $.messager.alert('Message','Enter To Amount ','warning');   
				 
			   return false;
			   
			   }
		   
		   else if(parseFloat(toamount)<parseFloat(fromamount))
		   {
		   
		   $.messager.alert('Message','To Amount Less Than From Amount  ','warning');   
			 
		   return false;
		   
		   }
		   
		   }
	   
		   

		   
		   
		   
	 var barchval = document.getElementById("cmbbranch").value;
     var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val();
	 

	 
 
	 var accdocno=$("#accdocno").val(); 
	   $("#overlay, #PleaseWait").show();
	  $("#listdiv").load("puchasereportGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&fromdocno="
			  +fromdocno+"&todocno="+todocno+"&fromamount="+fromamount+"&toamount="+toamount+"&accdocno="+accdocno);
	
		   }
	}
	
	
	
function funClearInfo()
{
	 
	 
	 
	  $("#fromdocno").val('');
	  $("#todocno").val('');   
	 $("#fromamount").val('');  
	 $("#toamount").val(''); 
	  $("#accdocno").val(''); 
	  
	 $("#acno").val(''); 
	 $("#accname").val(''); 
	 
	 
	  $("#fromdocno").attr('placeholder', 'From');
	  $("#todocno").attr('placeholder', 'To');
	  $("#fromamount").attr('placeholder', 'From');
	  $("#toamount").attr('placeholder', 'To');
	  
	  
	/*   $(this).attr('placeholder', '');
	  $(this).attr('placeholder', '');
	  $(this).attr('placeholder', ''); */
	  
	 
	 
}
	   
	
	
function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
    	{
 	  // document.getElementById("errormsg").innerText=" Enter Numbers Only";  
 	   $.messager.alert('Message',' Enter Numbers Only  ','warning');   
        return false;
    	}
   // document.getElementById("errormsg").innerText="";  
    return true;
}	
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background">  
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ===== LEFT PANEL ===== -->
<td width="20%" valign="top">

<fieldset class="filter-card scrollable-left">
<table width="100%" class="filter-table">

    <!-- HEADING (UNCHANGED â WILL APPEAR) -->
    <jsp:include page="../../heading.jsp"></jsp:include>

    <tr>
        <td class="label-cell">From</td>
        <td>
            <div id="fromdate" name="fromdate"
                 value='<s:property value="fromdate"/>'></div>
        </td>
    </tr>

    <tr>
        <td class="label-cell">To</td>
        <td>
            <div id="todate" name="todate"
                 value='<s:property value="todate"/>'></div>
        </td>
    </tr>

    <tr>
        <td class="label-cell">Doc No</td>
        <td>
            <input type="text"
                   id="fromdocno"
                   name="fromdocno"
                   class="master-input half-input"
                   placeholder="From"
                   value='<s:property value="fromdocno"/>'
                   onkeypress="return isNumber(event);">
            <span style="padding:0 6px;">-</span>
            <input type="text"
                   id="todocno"
                   name="todocno"
                   class="master-input half-input"
                   placeholder="To"
                   value='<s:property value="todocno"/>'
                   onkeypress="return isNumber(event);">
        </td>
    </tr>

    <tr>
        <td class="label-cell">Amount</td>
        <td>
            <input type="text"
                   id="fromamount"
                   name="fromamount"
                   class="master-input half-input text-right"
                   placeholder="From"
                   value='<s:property value="fromamount"/>'
                   onblur="funRoundAmt(this.value,this.id);"
                   onkeypress="return isNumber(event);">
            <span style="padding:0 6px;">-</span>
            <input type="text"
                   id="toamount"
                   name="toamount"
                   class="master-input half-input text-right"
                   placeholder="To"
                   value='<s:property value="toamount"/>'
                   onblur="funRoundAmt(this.value,this.id);"
                   onkeypress="return isNumber(event);">
        </td>
    </tr>

    <tr>
        <td class="label-cell">Vendor</td>
        <td>
            <input type="text"
                   id="acno"
                   name="acno"
                   class="master-input"
                   readonly
                   placeholder="Press F3 To Search"
                   value='<s:property value="acno"/>'
                   tabindex="-1"
                   onkeydown="getacc(event);">
        </td>
    </tr>

    <tr>
        <td></td>
        <td>
            <input type="text"
                   id="accname"
                   name="accname"
                   class="master-input"
                   readonly
                   tabindex="-1"
                   value='<s:property value="accname"/>'>
        </td>
    </tr>

    <tr>
        <td colspan="2" align="center">
            <button type="button"
                    class="btn-submit"
                    onclick="funClearInfo();">Clear</button>
        </td>
    </tr>

    <tr>
        <td colspan="2">
            <div id="paychaaaaa" style="width:100%; height:100px;"></div>
        </td>
    </tr>

</table>
</fieldset>

<input type="hidden"
       id="accdocno"
       name="accdocno"
       value='<s:property value="accdocno"/>'>

</td>

<!-- ===== RIGHT GRID ===== -->
<td width="80%" valign="top">
<table width="100%">
<tr>
    <td>
        <div id="listdiv">
            <jsp:include page="puchasereportGrid.jsp"></jsp:include>
        </div>
    </td>
</tr>
</table>
</td>

</tr>
</table>

</div>

<div id="accountDetailsWindow">
    <div></div>
</div>

</div>
</body>

</html>