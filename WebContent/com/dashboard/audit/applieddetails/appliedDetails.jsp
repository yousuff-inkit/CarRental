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
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
			
// 		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
	     $('#txtaccid').dblclick(function(){
			  accountsSearchContent('accountsDetailsSearch.jsp');
		 });
	     
// 	     $('#date').jqxDateTimeInput({disabled: true});$('#txtreason').attr("readonly",true);$('#chckremoveall').attr("disabled",true);$('#btndelete').attr("disabled",true);
	    /*  $("#appliedDetailsGrid").jqxGrid({ disabled: true});  */
	     
	     var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
			  
		     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
		     $('#todate').on('change', function (event) {
					
				   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
				 lead
				  // out date
				 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
				 	 
				   if(fromdates>todates){
					   
					   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
					 
				   return false;
				  }})
				  
	     
	});
	
	function accountsSearchContent(url) {
	    $('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function isNumber(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
         {
          $.messager.alert('Message',' Enter Numbers Only ','warning');    
            return false;
         }
        return true;
    }
	
	function funreload(event){
	
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var branchval = document.getElementById("cmbbranch").value;
		 var atype = $('#cmbtype').val();
		 var accountno = $('#txtdocno').val();
		 
// 		 $('#date').val(new Date());
		 $('#txtreason').val('');$('#txttrno').val();
		 $('#txtoutamount').val('');$('#txtdtype').val('');$('#txtbranchid').val('');$('#applyinfo').val(' ');
  	    /*  $("#appliedDetailsGrid").jqxGrid({ disabled: true});$("#appliedDetailsGrid").jqxGrid('clear');  */
//   	     $('#date').jqxDateTimeInput({disabled: true});
  	     //$('#txtreason').attr("readonly",true);$('#btndelete').attr("disabled",true);$('#chckremoveall').attr("disabled",true);
  	    // document.getElementById("chckremoveall").checked=false;$('#hidchckremoveall').val('0');
		
  	     if(accountno==''){
			 $.messager.alert('Message','Account is Mandatory.','warning');
			 return 0;
		 }
  	   
		 $("#overlay, #PleaseWait").show();
		 
		 $("#appliedDiv").load("appliedGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&branchval="+branchval+'&atype='+atype+'&accountno='+accountno+'&check=1');
		}
	
	
	
	function clearAccountInfo(){
		$('#txtdocno').val('');$('#txtaccid').val('');$('#txtaccname').val('');
		$('#txttrno').val(' ');$('#txtoutamount').val(' ');$('#txtdtype').val(' ');
		$('#txtbranchid').val(' ');
// 		$('#date').val(new Date());
		$('#txtreason').val(' ');
		$('#applyinfo').val(' ');
		$("#appliedDetailsGrid").jqxGrid({ disabled: true});$("#appliedDetailsGrid").jqxGrid('clear'); 
		$("#appliedDelete").jqxGrid('clear');
// 		$('#date').jqxDateTimeInput({disabled: true});
  	   // $('#txtreason').attr("readonly",true);$('#btndelete').attr("disabled",true);$('#chckremoveall').attr("disabled",true);
  	   // document.getElementById("chckremoveall").checked=false;$('#hidchckremoveall').val('0');
  	  
  	  if (document.getElementById("txtaccid").value == "") {
	        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
	    }
	}
	
	function getAccTypeFrom(event){
        var x= event.keyCode;
        if(x==114){
      		accountsSearchContent('accountsDetailsSearch.jsp');
        }
       
      }
	
	/* function removeallcheck(){
		 if(document.getElementById("chckremoveall").checked){
			 document.getElementById("hidchckremoveall").value = 1;
		 }
		 else{
			 document.getElementById("hidchckremoveall").value = 0;
		 }
	 } */
	
	function funExportBtn(){
		/* $("#appliedDiv").excelexportjs({  
			containerid: "appliedDiv", 
			datatype: 'json', 
			dataset: null, 
			gridId: "appliedDelete", 
			columns: getColumns("appliedDelete") ,   
			worksheetName:"Applied Details"
			}); */
			JSONToCSVCon(data, 'Applied Details', true) 
	} 
	
	function funPrint(){
    	if ($("#txtaccid").val()!="") {
	        var url=document.URL;
	        var atype=$('#cmbtype').val();
	        var branch=document.getElementById("cmbbranch").value;
	        var reurl=url.split("appliedDetails.jsp");   
	        var win= window.open(reurl[0]+"../../../../com/dashboard/audit/applieddetails/printAppliedDetail?acno="+document.getElementById("txtaccid").value+'&accname='+$('#txtaccname').val()+'&atype='+atype+'&branch='+branch+'&fromDate='+document.getElementById("fromdate").value+'&toDate='+$('#todate').val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        win.focus();
	     }
	    else {
			$.messager.alert('Message','Account is Mandatory.','warning');
			return;
		}
    }
	
	
</script>
</head>
<body onload="getBranch();">

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmAppliedDetails" action="saveAppliedDetails" method="post" autocomplete="off">

<div class="hidden-scrollbar" style="height:100%;">

<table width="100%">
<tr>

<!-- ================= LEFT PANEL (MASTER STYLE) ================= -->
<td width="20%" valign="top">

<div class="master-container">
<div class="sidebar-filters">

    <!-- FIXED HEADER -->
    <div class="sidebar-fixed-top">
        <div class="filter-card">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>
    </div>

    <!-- SCROLLABLE CONTENT -->
    <div class="sidebar-scroll-content">

        <div class="filter-card">
        <table class="filter-table">

            <tr>
                <td class="label-cell">From</td>
                <td><div id="fromdate" name="fromdate"
                         value='<s:property value="fromdate"/>'></div></td>
            </tr>

            <tr>
                <td class="label-cell">To</td>
                <td><div id="todate" name="todate"
                         value='<s:property value="todate"/>'></div></td>
            </tr>

            <tr>
                <td class="label-cell">Type</td>
                <td>
                    <select id="cmbtype"
                            name="cmbtype"
                            onchange="clearAccountInfo();">
                        <option value="AR">AR</option>
                        <option value="AP">AP</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Account</td>
                <td>
                    <input type="text"
                           id="txtaccid"
                           name="txtaccid"
                           placeholder="Press F3 to Search"
                           readonly
                           onkeydown="getAccTypeFrom(event);"
                           value='<s:property value="txtaccid"/>'>
                </td>
            </tr>

            <tr>
                <td></td>
                <td>
                    <input type="text"
                           id="txtaccname"
                           name="txtaccname"
                           readonly
                           tabindex="-1"
                           value='<s:property value="txtaccname"/>'>

                    <input type="hidden"
                           id="txtdocno"
                           name="txtdocno"
                           value='<s:property value="txtdocno"/>'>
                </td>
            </tr>

        </table>
        </div>

        <div class="filter-card" style="text-align:center;">
            <textarea id="applyinfo"
                      name="applyinfo"
                      readonly
                      style="width:100%;height:90px;resize:none;font:10px Tahoma;">
<s:property value="applyinfo"/>
            </textarea>
        </div>

        <!-- HIDDEN FIELDS -->
        <input type="hidden" id="txttrno" name="txttrno"
               value='<s:property value="txttrno"/>'>
        <input type="hidden" id="txtoutamount" name="txtoutamount"
               value='<s:property value="txtoutamount"/>'>
        <input type="hidden" id="txtdtype" name="txtdtype"
               value='<s:property value="txtdtype"/>'>
        <input type="hidden" id="txttranid" name="txttranid"
               value='<s:property value="txttranid"/>'>
        <input type="hidden" id="txtbranchid" name="txtbranchid"
               value='<s:property value="txtbranchid"/>'>

    </div>
</div>
</div>

</td>

<!-- ================= RIGHT PANEL ================= -->
<td width="80%" valign="top">

<table width="100%">
<tr>
    <td>
        <div id="appliedDiv">
            <jsp:include page="appliedGrid.jsp"></jsp:include>
        </div>
    </td>
</tr>
</table>

</td>

</tr>
</table>

</div>
</form>

<div id="accountDetailsWindow">
    <div></div><div></div>
</div>

</div>
</body>

</html>