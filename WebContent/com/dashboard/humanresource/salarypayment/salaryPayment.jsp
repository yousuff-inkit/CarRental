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
<style>

.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', Tahoma, sans-serif;
    background-color: #f4f7f9;
}


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

.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

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

input[type="text"], select {
    width: 100%;
    padding: 7px 10px;
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    font-size: 13px;
}

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
.myButtons, .myButton {
    background-color: #2563eb !important;
    color: #ffffff !important;
    border: none !important;
    border-radius: 6px;
    padding: 10px 15px;
    width: 100%;
    font-weight: 600;
    cursor: pointer;
}

.myButtons:hover, .myButton:hover {
    background-color: #1d4ed8 !important;
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
		
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy", enableBrowserBoundsDetection: true});
		
		 /* Searching Window */
     	 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Account Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
  		 $('#accountDetailsWindow').jqxWindow('close');
  		 
  		 $('#establishedCodeDetailsWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '30%' , title: 'Establishment Code Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#establishedCodeDetailsWindow').jqxWindow('close');
  		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
		 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
	     $('#txtaccount').dblclick(function(){
	    	 accountSearchContent("accountDetailsSearch.jsp");
		 });
	     
	     $('#txtbankaccount').dblclick(function(){
	    	 accountSearchContent("bankAccountDetailsSearch.jsp");
		 });
	     
	     $('#txtestablishmentcode').dblclick(function(){
	    	 establishedCodeSearchContent("establishmentCodeDetailsSearch.jsp");
		 });
	     
	     $("#salaryPaymentDetailsGridID").jqxGrid({ height: 532 });
	     $('#salaryPaymentDetailsGridID').jqxGrid({ selectionmode: 'singlerow'});
	     $("#salaryPaymentDetailsGridID").jqxGrid({ disabled: true});
	     $('#btnSaveSalaryPayment').attr('disabled', true );
	     $('#btnSifSalaryPayment').attr('disabled', true );
	     $('#date').jqxDateTimeInput({disabled: true});
	});
	
	function accountSearchContent(url) {
	 	$('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function establishedCodeSearchContent(url) {
	 	$('#establishedCodeDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#establishedCodeDetailsWindow').jqxWindow('setContent', data);
		$('#establishedCodeDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	 function getYear() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					var yearItems = items[0].split(",");
					var yearIdItems = items[1].split(",");
					$('#excelconfig').val(items[2].split(","));
					var optionsyear = '<option value="">--Select--</option>';
					for (var i = 0; i < yearItems.length; i++) {
						optionsyear += '<option value="' + yearIdItems[i] + '">'
								+ yearItems[i] + '</option>';
					}
					$("select#cmbyear").html(optionsyear);
					if($('#hidcmbyear').val()){
						document.getElementById("cmbyear").value=document.getElementById("hidcmbyear").value;
						funreload(event);
					  }
				} else {
				}
			}
			x.open("GET", "getYear.jsp", true);
			x.send();
		}
	
	function getPayrollCategory() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var payrollcategoryItems = items[0].split(",");
				var payrollcategoryIdItems = items[1].split(",");
				var optionspayrollcategory = '<option value="">--Select--</option>';
				for (var i = 0; i < payrollcategoryItems.length; i++) {
					optionspayrollcategory += '<option value="' + payrollcategoryIdItems[i] + '">'
							+ payrollcategoryItems[i] + '</option>';
				}
				$("select#cmbempcategory").html(optionspayrollcategory);
				
			} else {
			}
		}
		x.open("GET", "getPayrollCategory.jsp", true);
		x.send();
	}
	
	function getSalesAgent() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var salesAgentItems = items[0].split(",");
				var salesAgentIdItems = items[1].split(",");
				var optionssalesagent = '<option value="">--Select--</option>';
				for (var i = 0; i < salesAgentItems.length; i++) {
					 optionssalesagent += '<option value="' + salesAgentIdItems[i] + '">'
							+ salesAgentItems[i] + '</option>';
				}
				$("select#cmbempagentid").html(optionssalesagent);
				
			} else {
			}
		}
		x.open("GET", "getSalesAgent.jsp", true);
		x.send();
	}
	
	function getAccount(event){
        var x= event.keyCode;
        if(x==114){
        	accountSearchContent("accountDetailsSearch.jsp");
        }
        else{}
        }
	
	function getBankAccount(event){
        var x= event.keyCode;
        if(x==114){
        	accountSearchContent("bankAccountDetailsSearch.jsp");
        }
        else{}
        }
	
	function getEstablishmentCode(event){
        var x= event.keyCode;
        if(x==114){
        	establishedCodeSearchContent("establishmentCodeDetailsSearch.jsp");
        }
        else{}
        }

	function  funClearInfo(){
		$('#cmbbranch').val('a');$('#cmbyear').val('');$('#cmbmonth').val('');$('#txtestablishmentcode').val('');
	    $('#txtaccount').val('');$('#txtaccountname').val('');$('#txtaccountdocno').val('');$('#date').val(new Date());$('#hiddate').val('');
	    $('#cmbempcategory').val('');$('#cmbempagentid').val('');
	    $('#txtbankaccount').val('');$('#txtbankaccountname').val('');$('#txtbankaccountdocno').val('');
	    $('#txtdrtotal').val('');$('#txtcrtotal').val('');$('#gridlength').val('');
	    $("#salaryPaymentDetailsGridID").jqxGrid('clearselection');$("#salaryPaymentDetailsGridID").jqxGrid('clear');$("#salaryPaymentDetailsGridID").jqxGrid('addrow', null, {});$("#salaryPaymentDetailsGridID").jqxGrid({ disabled: true});
	    $("#postedSalaryGridID").jqxGrid('clear');$("#salaryPaymentJVGridID").jqxGrid('clear');$("#salaryPaymentJVGridID").jqxGrid({ disabled: true});
	    $('#date').jqxDateTimeInput({disabled: true});$('#btnSaveSalaryPayment').attr('disabled', true );
	    
		if (document.getElementById("txtaccount").value == "") {
	        $('#txtaccount').attr('placeholder', 'Press F3 to Search'); 
	        $('#txtaccountname').attr('placeholder', 'Employee Name');
	    }
		
		if (document.getElementById("txtbankaccountdocno").value == "") {
	        $('#txtbankaccount').attr('placeholder', 'Press F3 to Search'); 
	        $('#txtbankaccountname').attr('placeholder', 'Bank Account');
	    }
		
		if (document.getElementById("txtestablishmentcode").value == "") {
	        $('#txtestablishmentcode').attr('placeholder', 'Press F3 to Search'); 
	    }
		
	 }
	
	function funreload(event){
		 var branchval = document.getElementById("cmbbranch").value;
		 var year = $('#cmbyear').val();
		 var month = $('#cmbmonth').val();
		 var category = $('#cmbempcategory').val();
		 var agent = $('#cmbempagentid').val();
		 var establishmentcode = $('#txtestablishmentcode').val();
		 var employeebranchchk=window.parent.employeebranchchk.value; 
		 
		 if($('#cmbyear').val()==''){
			 $.messager.alert('Message','Please Choose a Year.','warning');
			 return 0;
		 }
		
		if($('#cmbmonth').val()==''){
			 $.messager.alert('Message','Please Choose a Month.','warning');
			 return 0;
		 } 
		
		 $("#overlay, #PleaseWait").show();
		 
		 $('#btnSifSalaryPayment').attr('disabled', true );
		 $('#date').val(new Date());$('#date').jqxDateTimeInput({disabled: true});$('#btnSaveSalaryPayment').attr('disabled', true );
		 $("#salaryPaymentDetailsGridID").jqxGrid('clearselection');$("#salaryPaymentDetailsGridID").jqxGrid('clear');
		 $("#salaryPaymentDetailsGridID").jqxGrid('addrow', null, {});$("#salaryPaymentDetailsGridID").jqxGrid({ disabled: true});
		 $("#salaryPaymentJVGridID").jqxGrid('clear');$("#salaryPaymentJVGridID").jqxGrid({ disabled: true});$('#txtselectedemployees').val('');
		 $("#postedSalaryDiv").load("postedSalaryGrid.jsp?branchval="+branchval+'&year='+year+'&month='+month+'&category='+category+'&agent='+agent+'&establishmentCode='+establishmentcode.replace(/ /g, "%20")+'&check=1&employeebranchchk='+employeebranchchk);
	}
	
	function funCalculate(){
		
		/* if($('#cmbbranch').val()=='a'){
			 $.messager.alert('Message','Please Choose a Specific Main-Branch.','warning');
			 return 0;
		 }*/
		
		if($('#cmbyear').val()==''){
			 $.messager.alert('Message','Please Choose a Year.','warning');
			 return 0;
		 }
		
		if($('#cmbmonth').val()==''){
			 $.messager.alert('Message','Please Choose a Month.','warning');
			 return 0;
		 } 
		
		if($('#txtaccountdocno').val()==''){
			 $.messager.alert('Message','Please Choose a Payable Account & Then Calculate.','warning');
			 return 0;
		 } 
		
		var rows = $('#salaryPaymentJVGridID').jqxGrid('getrows');
    	var rowlength= rows.length;
		if(rowlength!=0){
			$.messager.alert('Message','Already calculated.Submit Again. ','warning');
			return 0;
		} else{
			$("#salaryPaymentJVGridID").jqxGrid('clear');
			$('#txtselectedemployees').val('');
		} 
		
		$("#overlay, #PleaseWait").show();
		
		$("#salaryPaymentJVGridID").jqxGrid({ disabled: false});
		
		var rows = $("#salaryPaymentDetailsGridID").jqxGrid('getrows');
		
		if(rows.length==1 && (rows[0].empdocno=="undefined" || rows[0].empdocno==null || rows[0].empdocno=="")){
			$("#overlay, #PleaseWait").hide();
			$.messager.alert('Warning','Select Items to be Calculated.');
			return false;
		}
		
		var selectedrows=$("#salaryPaymentDetailsGridID").jqxGrid('selectedrowindexes');
		selectedrows = selectedrows.sort(function(a,b){return a - b});
		
		if(selectedrows.length==0){
			$("#overlay, #PleaseWait").hide();
			$.messager.alert('Warning','Select Items to be Calculated.');
			return false;
		}
		
		var i=0;var tempemp="",tempemp1="";
        var j=0,k=0;
	    for (i = 0; i < rows.length; i++) {
				if(selectedrows[j]==i){
					
					if(i==0){
						tempemp=rows[i].empdocno;
						k=1;
					}
					else{
						if(k==0){
							tempemp=rows[i].empdocno;
							k=1;
						} else {
							tempemp=tempemp+","+rows[i].empdocno;
						}
					}
					tempemp1=tempemp;
					
				j++; 
			  }
            }
	     $('#txtselectedemployees').val(tempemp1);
		
	     var year = $('#cmbyear').val();
  		 var month = $('#cmbmonth').val();
  		 var bankaccount = $('#txtaccountdocno').val();
  		 var employees = $('#txtselectedemployees').val();
  		 var paymentPosting = $('#date').val();
  		 var employeebranchchk=window.parent.employeebranchchk.value; 
  		 var paymentPostingdate =$('#date').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(paymentPostingdate);
	//	  alert("paymentpostingdate="+paymentPostingdate+"validdate="+validdate);
		  if(parseInt(validdate)==0){
				return 0;	
			 }
  		 $("#overlay, #PleaseWait").show();
  		 $("#salaryPaymentJVGridID").jqxGrid('clear');$("#salaryPaymentJVGridID").jqxGrid({ disabled: false});
  		 $('#btnSaveSalaryPayment').attr('disabled', false );
  		
  		 $("#JVTDiv").load("salaryPaymentJVGrid.jsp?year="+year+'&month='+month+'&bankaccount='+bankaccount+'&employees='+employees+'&paymentPosting='+paymentPosting+'&check=1&employeebranchchk='+employeebranchchk);
	}
	
	function funNotify(){	
    	
		   var rows = $('#salaryPaymentJVGridID').jqxGrid('getrows');
	       var rowlength= rows.length;
		   if(rowlength==0){
				$.messager.alert('Message','Please Calculate & Save Again. ','warning');
				return 0;
		   } 
		   var paymentPostingdate =$('#date').jqxDateTimeInput('getDate');
			  var validdate=funDateInPeriod(paymentPostingdate);
		//	  alert("paymentpostingdate="+paymentPostingdate+"validdate="+validdate);
			  if(parseInt(validdate)==0){
					return 0;	
				 }
		   $.messager.confirm('Confirm', 'Do you want to save changes?', function(r){
	 		if (r){
	 				
	 			/* Salary Payment Grid  Saving*/
			 	var rows = $("#salaryPaymentJVGridID").jqxGrid('getrows');
			 	var length=0;
					 for(var i=0 ; i < rows.length ; i++){
						var chk=rows[i].docno;
						if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
							newTextBox = $(document.createElement("input"))
						    .attr("type", "dil")
						    .attr("id", "test"+length)
						    .attr("name", "test"+length)
							.attr("hidden", "true");
							length=length+1;
							
							var amount="0",baseamount="0",id="1";
							if((rows[i].credit!=null) && (rows[i].credit!='undefined') &&  (rows[i].credit!='NaN') && (rows[i].credit!="") && (rows[i].credit!=0)){
								 amount=rows[i].credit*-1;
								 baseamount=rows[i].baseamount*-1;
								 id=-1;
							}
							
							if((rows[i].debit!=null) && (rows[i].debit!='undefined') && (rows[i].debit!='NaN') && (rows[i].debit!="") && (rows[i].debit!=0)){
								 amount=rows[i].debit;
								 baseamount=rows[i].baseamount;
								 id=1;
							}
								
				    newTextBox.val(rows[i].docno+"::"+rows[i].description+":: "+rows[i].currencyid+":: "+rows[i].rate+":: "+baseamount+":: "+amount+":: 0::"+id+":: 0:: 0");
				    newTextBox.appendTo('form');
				 }
				}
	 		 	$('#gridlength').val(length);
			 	/* Salary Payment Grid  Saving Ends*/
	 		
			 document.getElementById("mode").value='A';
			 $("#overlay, #PleaseWait").show();
			 document.getElementById("frmDashboardSalaryPayment").submit();
			 
	 		 }
	 		});
		 
		return 1;
	}
	
	function setValues(){
		getYear();
		
		document.getElementById("cmbmonth").value=document.getElementById("hidcmbmonth").value;
	  
		  if($('#msg').val()!=""){
			 $.messager.alert('Message',$('#msg').val());
			 $('#txtdrtotal').val('');$('#txtcrtotal').val('');$('#gridlength').val('');
		 }
	}
	
	function funExportBtn(){
		var method=document.getElementById("excelconfig").value;
		
		if(method==1){
		JSONToCSVCon(dataexcel, 'SalaryPayment', true);
		}
		else{
		JSONToCSVCon(data1, 'SalaryPayment', true);
		}
	} 
	
	function funWPSFormat(){
		
		if($('#txtestablishmentcode').val()==''){
			$("#salaryPaymentDetailsGridID").jqxGrid('clearselection');$("#salaryPaymentDetailsGridID").jqxGrid('clear');$("#salaryPaymentDetailsGridID").jqxGrid('addrow', null, {});
			 $.messager.alert('Message','Establishment Code is Mandatory.','warning');
			 return 0;
		 }
		
		if($('#txtbankaccountdocno').val()==''){
			$("#salaryPaymentDetailsGridID").jqxGrid('clearselection');$("#salaryPaymentDetailsGridID").jqxGrid('clear');$("#salaryPaymentDetailsGridID").jqxGrid('addrow', null, {});
			 $.messager.alert('Message','Bank Account is Mandatory.','warning');
			 return 0;
		 }
		
		var rows = $("#salaryPaymentDetailsGridID").jqxGrid('getrows');
		if(rows.length==1 && (rows[0].empdocno=="undefined" || rows[0].empdocno==null || rows[0].empdocno=="")){
			$.messager.alert('Warning','Please Submit & Click again.');
			return false;
		}
		
		JSONToSIFCon(dataSIF, 'SalaryPayment', true);
	}
	
</script>
</head>
<body onload="getBranch();setValues();getYear();getPayrollCategory();getSalesAgent();">

<form id="frmDashboardSalaryPayment"
      action="saveDashboardSalaryPayment"
      method="post">

<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar" style="height:100%;">

<table width="100%">
<tr>

<td width="20%" valign="top">

<div class="master-container">
<div class="sidebar-filters">

    <div class="sidebar-fixed-top">
        <div class="filter-card">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>
    </div>

   
    <div class="sidebar-scroll-content">

     
        <div class="filter-card">
        <table class="filter-table">

            <tr>
                <td class="label-cell">Year</td>
                <td>
                    <select id="cmbyear" name="cmbyear">
                        <option value="">--Select--</option>
                    </select>
                    <input type="hidden" id="hidcmbyear" name="hidcmbyear"
                           value='<s:property value="hidcmbyear"/>'>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Month</td>
                <td>
                    <select id="cmbmonth" name="cmbmonth">
                        <option value="">--Select--</option>
                        <option value="01">January</option>
                        <option value="02">February</option>
                        <option value="03">March</option>
                        <option value="04">April</option>
                        <option value="05">May</option>
                        <option value="06">June</option>
                        <option value="07">July</option>
                        <option value="08">August</option>
                        <option value="09">September</option>
                        <option value="10">October</option>
                        <option value="11">November</option>
                        <option value="12">December</option>
                    </select>
                    <input type="hidden" id="hidcmbmonth" name="hidcmbmonth"
                           value='<s:property value="hidcmbmonth"/>'>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Agent Id</td>
                <td>
                    <select id="cmbempagentid" name="cmbempagentid">
                        <option value="">--Select--</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Category</td>
                <td>
                    <select id="cmbempcategory" name="cmbempcategory">
                        <option value="">--Select--</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Est. Code</td>
                <td>
                    <input type="text"
                           id="txtestablishmentcode"
                           name="txtestablishmentcode"
                           readonly
                           placeholder="Press F3 to Search"
                           value='<s:property value="txtestablishmentcode"/>'
                           onkeydown="getEstablishmentCode(event);">
                </td>
            </tr>

            <tr>
                <td class="label-cell">Payable</td>
                <td>
                    <input type="text"
                           id="txtaccount"
                           name="txtaccount"
                           readonly
                           placeholder="Press F3 to Search"
                           value='<s:property value="txtaccount"/>'
                           onkeydown="getAccount(event);">
                    <input type="hidden"
                           id="txtaccountdocno"
                           name="txtaccountdocno"
                           value='<s:property value="txtaccountdocno"/>'>
                </td>
            </tr>

            <tr>
                <td colspan="2">
                    <input type="text"
                           id="txtaccountname"
                           name="txtaccountname"
                           readonly
                           placeholder="Payable Account"
                           value='<s:property value="txtaccountname"/>'
                           tabindex="-1">
                </td>
            </tr>

            <tr>
                <td class="label-cell">Payment</td>
                <td>
                    <div id="date"></div>
                    <input type="hidden"
                           id="hiddate"
                           name="hiddate"
                           value='<s:property value="hiddate"/>'>
                </td>
            </tr>

        </table>
        </div>

      
        <div class="filter-card">
            <div id="postedSalaryDiv">
                <jsp:include page="postedSalaryGrid.jsp"></jsp:include>
            </div>
        </div>

      
        <div class="filter-card">
        <table class="filter-table">

            <tr>
                <td class="label-cell">Bank</td>
                <td>
                    <input type="text"
                           id="txtbankaccount"
                           name="txtbankaccount"
                           readonly
                           placeholder="Press F3 to Search"
                           value='<s:property value="txtbankaccount"/>'
                           onkeydown="getBankAccount(event);">
                    <input type="hidden"
                           id="txtbankaccountdocno"
                           name="txtbankaccountdocno"
                           value='<s:property value="txtbankaccountdocno"/>'>
                </td>
            </tr>

            <tr>
                <td colspan="2">
                    <input type="text"
                           id="txtbankaccountname"
                           name="txtbankaccountname"
                           readonly
                           placeholder="Bank Account"
                           value='<s:property value="txtbankaccountname"/>'
                           tabindex="-1">
                </td>
            </tr>

        </table>
        </div>

   
        <div class="filter-card">
    <div style="display:flex; gap:8px;">

        <button type="button"
                class="myButtons"
                onclick="funClearInfo();"
                style="flex:1;">
            Clear
        </button>

        <button type="button"
                class="myButton"
                onclick="funWPSFormat();"
                style="flex:1;">
            WPS Format
        </button>

        <button type="button"
                class="myButton"
                onclick="funNotify();"
                style="flex:1;">
            Save
        </button>

    </div>
</div>

        <input type="hidden" id="txtselectedemployees" name="txtselectedemployees"
               value='<s:property value="txtselectedemployees"/>'>
        <input type="hidden" id="txtdrtotal" name="txtdrtotal"
               value='<s:property value="txtdrtotal"/>'>
        <input type="hidden" id="txtcrtotal" name="txtcrtotal"
               value='<s:property value="txtcrtotal"/>'>
        <input type="hidden" id="gridlength" name="gridlength"
               value='<s:property value="gridlength"/>'>
        <input type="hidden" id="mode" name="mode"
               value='<s:property value="mode"/>'>
        <input type="hidden" id="msg" name="msg"
               value='<s:property value="msg"/>'>
        <input type="hidden" id="excelconfig" name="excelconfig"
               value='<s:property value="excelconfig"/>'>

    </div>
</div>
</div>

</td>

<td width="80%" valign="top">

<table width="100%">
<tr>
    <td>
        <div id="salaryPaymentDetailsDiv">
            <jsp:include page="salaryPaymentGrid.jsp"></jsp:include>
        </div>
    </td>
</tr>

<tr>
    <td>
        <div id="JVTDiv" hidden="true">
            <jsp:include page="salaryPaymentJVGrid.jsp"></jsp:include>
        </div>
    </td>
</tr>
</table>

</td>

</tr>
</table>

</div>

<div id="accountDetailsWindow"><div></div></div>
<div id="establishedCodeDetailsWindow"><div></div></div>

</div>
</form>
</body>

