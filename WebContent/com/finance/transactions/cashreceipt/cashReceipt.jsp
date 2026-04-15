<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
SCOPED UI: Modern Layout (Matches Client Master)
========================================================= */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 5px 15px;
    box-sizing: border-box;
    width: 100%;
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui select { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled,
.modern-ui select:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

/* Layout Utilities */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* FIXED: Middle Section Panels */
.modern-ui .middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 20px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
    margin-top: 12px;
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -12px;
    left: 10px; 
    background: #ffffff; 
    padding: 0 8px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 14px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
}

/* Custom UI Buttons matching 24px height */
.modern-ui .myButton {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 12px;
    font-family: Arial, sans-serif;
    font-size: 11px;
    font-weight: bold;
    border-radius: 3px;
    cursor: pointer;
    text-shadow: none;
    transition: all 0.2s;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    border: none;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    white-space: nowrap;
}
.modern-ui .myButton:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

/* Search Icon Wrapper */
.modern-ui .input-search-container {
    position: relative;
    display: flex;
}
.modern-ui .input-search-container input {
    padding-right: 25px !important;
}
.modern-ui .magnifier-icon {
    position: absolute;
    right: 6px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
.modern-ui .magnifier-icon:hover { color: #2563eb; }

/* Clean Tables for Approvals */
.modern-ui .cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #fff;
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    overflow: hidden;
}
.modern-ui .cr-table th, .modern-ui .cr-table td {
    padding: 6px 10px;
    border-bottom: 1px solid #eef0f6;
    font-size: 12px;
    text-align: left;
}
.modern-ui .cr-table th { background: #f4f7fb; font-weight: bold; color: #0056b3; }

/* Grid Wrappers */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

/* Validation Label */
.modern-ui .val-error { color: red; font-size: 11px; font-weight:bold; }

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 150px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }
</style>

<script type="text/javascript">
	$(document).ready(function() {
		 $("#btnvaluechange").hide();
		 
		 /* Formatted jqxDateTimeInput heights to match modern UI 24px */
		 $("#jqxCashReceiptDate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
		 $("#maindate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy"});
		 
		 $("#inputjqxCashReceiptDate").css("margin-top", "0px");
		 $("#inputmaindate").css("margin-top", "0px");

		 /* force internal alignment AFTER render */
		 setTimeout(function () {
		     $("#jqxCashReceiptDate, #maindate").find("input").css({
		         "margin-top": "0px",
		         "line-height": "24px",
                 "font-size": "12px", 
                 "font-family": "Arial, sans-serif", 
                 "padding": "0 6px", 
                 "box-sizing":"border-box"
		     });
		     $("#jqxCashReceiptDate, #maindate").find(".jqx-action-button").css({
		         "top": "0px",
		         "height": "24px"
		     });
		 }, 0);

		 $('#accountDetailsToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } ,  showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsToWindow').jqxWindow('close');  
		 
		 $('#accountDetailsFromWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsFromWindow').jqxWindow('close');
		 
		 $('#cashReceiptGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , showCloseButton: true, keyboardCloseKey: 27});
		 $('#cashReceiptGridWindow').jqxWindow('close');
		 
		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , showCloseButton: true, keyboardCloseKey: 27});
 		 $('#costTypeSearchGridWindow').jqxWindow('close');
 		 
 		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 }  , showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
		 
		 $('#jqxCashReceiptDate').on('change', function (event) {
			 var receiptdate = $('#jqxCashReceiptDate').jqxDateTimeInput('getDate');
			 var validdate=funDateInPeriod(receiptdate);
			 if(parseInt(validdate)==0){
				 document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				 return 0;	
		     }
		 });
			 
		 $('#txtfromaccid').dblclick(function(){
			 var date = $('#jqxCashReceiptDate').jqxDateTimeInput('getDate');
			 $("#maindate").jqxDateTimeInput('val', date);
			 accountFromSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
		 });
		 
		 $('#txttoaccid').dblclick(function(){
			 var date = $('#jqxCashReceiptDate').jqxDateTimeInput('getDate');
			 $("#maindate").jqxDateTimeInput('val', date);
			 accountToSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtotype').val()+"&date="+date);
		 });  
	});
	
	function CashSearchContent(url) {
		$('#cashReceiptGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#cashReceiptGridWindow').jqxWindow('setContent', data);
		$('#cashReceiptGridWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function accountFromSearchContent(url) {
		 $('#accountDetailsFromWindow').jqxWindow('open');
		 $.get(url).done(function (data) {
			$('#accountDetailsFromWindow').jqxWindow('setContent', data);
			$('#accountDetailsFromWindow').jqxWindow('bringToFront');
		}); 
	}
	
	function accountToSearchContent(url) {
		 $('#accountDetailsToWindow').jqxWindow('open');
		 $.get(url).done(function (data) {
			$('#accountDetailsToWindow').jqxWindow('setContent', data);
			$('#accountDetailsToWindow').jqxWindow('bringToFront');
		}); 
	}
	
	function costTypeSearchContent(url) {
	    $('#costTypeSearchGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costTypeSearchGridWindow').jqxWindow('setContent', data);
		$('#costTypeSearchGridWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function costCodeSearchContent(url) {
	    $('#costCodeSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costCodeSearchWindow').jqxWindow('setContent', data);
		$('#costCodeSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function funwarningopen(){
		 $.messager.confirm('Confirm', 'Transaction will affect Links to the applied Bank Reconcilations & Prepayments.', function(r){
			    if (r){
			    	$("#mode").val("EDIT");
					 $('#txtfromaccid').attr('readonly', true);$('#txtfromaccname').attr('readonly', true);$('#txtfromamount').attr('readonly', false);$('#txtdescription').attr('readonly', false);
					 $('#txttoaccid').attr('readonly', true);$('#txttoaccname').attr('readonly', true);$('#txttoamount').attr('readonly', false);$('#txtfromrate').attr('readonly', false);
				     $('#txtfrombaseamount').attr('readonly', true);$('#txttorate').attr('readonly', false);$('#txttobaseamount').attr('readonly', true);$('#txtapplyinvoiceamt').attr('readonly', true);
				     $('#txtapplyinvoiceapply').attr('readonly', true);$('#txtapplyinvoicebalance').attr('readonly', true);$('#txtdrtotal').attr('readonly', true);$('#txtcrtotal').attr('readonly', true);
					 $('#frmCashReceipt select').attr('disabled', false);$("#jqxApplyCashReceiptInvoicing").jqxGrid({ disabled: false});$("#jqxCashReceipt").jqxGrid({ disabled: false});  
					 $('#cmbfromcurrency').attr('disabled',true);
					 $('#cmbtocurrency').attr('disabled',true);
			    }
			   });
	 }
	  
	 function funPaymentAmount(txttoamount) {
	    if (parseFloat($("#txtapplyinvoiceapply").val())>0 && $("#mode").val()=="EDIT") {
	        if(parseFloat(txttoamount.value)<parseFloat(txttoamount.oldvalue)){
	        	$("#txttoamount").val(txttoamount.oldvalue);
	    		$.messager.alert('Message','Applied for '+txttoamount.oldvalue+'/-, Remove applied & then change the Payment Amount.','warning');
		    	return;
	        }
	    }
	    var appliedamt = $("#txtapplyinvoiceapply").val();
    	var balance = 0.0;
    	var nettotal = $("#txttoamount").val();  
    	if(appliedamt!="" && appliedamt!=null){
    		balance = parseFloat(nettotal) - parseFloat(appliedamt);   
    		$("#txtapplyinvoicebalance").val(balance);
    	}else{
    		$("#txtapplyinvoicebalance").val(nettotal);       
    	}
	 }
	  
	 function funReadOnly(){
			$('#frmCashReceipt input').attr('readonly', true );
			$('#frmCashReceipt select').attr('disabled', true);
			$('#jqxCashReceiptDate').jqxDateTimeInput({disabled: true});
			$("#jqxApplyCashReceiptInvoicing").jqxGrid({ disabled: true});
			$("#jqxCashReceipt").jqxGrid({ disabled: true});
			$("#btnvaluechange").hide();
	 }
	 function funRemoveReadOnly(){
			$('#frmCashReceipt input').attr('readonly', false );
			$('#frmCashReceipt select').attr('disabled', false);
			$('#cmbfromcurrency').attr('disabled', true);
			$('#cmbtocurrency').attr('disabled', true);
			$('#jqxCashReceiptDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$('#txtfromaccid').attr('readonly', true );
			$('#txtfromaccname').attr('readonly', true );
			$('#txttoaccid').attr('readonly', true );
			$('#txttoaccname').attr('readonly', true );
			$('#txtapplyinvoiceamt').attr('readonly', true );
			$('#txtapplyinvoiceapply').attr('readonly', true );
			$('#txtapplyinvoicebalance').attr('readonly', true );
			$('#txtdrtotal').attr('readonly', true );
			$('#txtcrtotal').attr('readonly', true );
			$("#jqxApplyCashReceiptInvoicing").jqxGrid({ disabled: false}); 
			$("#jqxCashReceipt").jqxGrid({ disabled: false});

			var date = $('#jqxCashReceiptDate').val();
		    getCurrencyId(date);
		    
			if ($("#mode").val() == "E") {
         	    $("#btnvaluechange").show();
         	    $('#frmCashReceipt input').attr('readonly', true );
   			    $('#frmCashReceipt select').attr('disabled', true);
   			    $("#jqxApplyCashReceiptInvoicing").jqxGrid({ disabled: true});
			    $("#jqxCashReceipt").jqxGrid({ disabled: true});
   			    $('#txtrefno').attr('readonly', false );
   			    $("#cmbtotype").attr('disabled',false);
   			    $('#txtdescription').attr('readonly', false );
   			    $("#jqxCashReceipt").jqxGrid('addrow', null, {"docno": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","costtype": "","costgroup": "","costcode": "","dr": true,"amount1": "","baseamount1": "","description": "","grtype": "","currencytype": "","sr_no":""});
			 }
			 else{
				$("#btnvaluechange").hide();
			} 
			
			if ($("#mode").val() == "A") {
				$('#jqxCashReceiptDate').val(new Date());
				$("#jqxCashReceipt").jqxGrid('clear'); 
				$("#jqxCashReceipt").jqxGrid('addrow', null, {"docno": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","costtype": "","costgroup": "","costcode": "","dr": true,"amount1": "","baseamount1": "","description": "","grtype": "","currencytype": "","sr_no":""});
				$("#jqxApplyCashReceiptInvoicing").jqxGrid('clear');
				$("#jqxApplyCashReceiptInvoicing").jqxGrid('addrow', null, {});
			}
	 }
	 
	 function funSearchLoad(){
		changeContent('crvMainSearch.jsp'); 
	 }
		
	 function funChkButton() { }
	 
	 function funFocus() {
	    $('#jqxCashReceiptDate').jqxDateTimeInput('focus'); 	    		
	 }
	 
	 $(function(){
	     $('#frmCashReceipt').validate({
	        rules: {
		        txtfromaccid:"required",
		        txtfromamount:{"required":true,number:true},
		        txttoamount:{number:true},
		        txtdescription:{maxlength:500}
		    },
		    messages: {
		        txtfromaccid:" *",
		        txtfromamount:{required:" *",number:"Invalid"},
		        txttoamount:{number:"Invalid"},
		        txtdescription: {maxlength:"    Max 500 chars"}
		    }
	     });
	 });
	   
	 function funNotify(){	
		  
		 /* Validation */
		 var rows = $("#jqxApplyCashReceiptInvoicing").jqxGrid('getrows');
		 for(var i=0 ; i < rows.length ; i++){
		     var balanceamt=rows[i].balance;
		     if(balanceamt<0){
	        	 document.getElementById("errormsg").innerText= "Invalid applying amount!!!";
				 return 0;
	         } 
		 }
		  
		 var receiptdate = $('#jqxCashReceiptDate').jqxDateTimeInput('getDate');
	     var validdate=funDateInPeriod(receiptdate);
		 if(parseInt(validdate)==0){
			document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
			return 0;	
		 }
			
		 valid=document.getElementById("txtvalidation").value;
		 if(valid==1){
			 document.getElementById("errormsg").innerText="Invalid Transaction !!!";
			 return 0;
		 }

		 cash=document.getElementById("txtfromaccid").value;
		 if(cash==""){
			 document.getElementById("errormsg").innerText="Enter Cash";
			 return 0;
		 }
			 
		 currency=document.getElementById("cmbfromcurrency").value;
		 if(currency==""){
			 document.getElementById("errormsg").innerText="Currency & Rate is Mandatory.";
			 return 0;
		 }
			 
		 var drtot = parseFloat(document.getElementById("txtdrtotal").value);
		 var crtot = parseFloat(document.getElementById("txtcrtotal").value);
		 if(drtot>crtot || drtot<crtot){
		 	document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should be Equal.";
	        return 0;
		 }
		 var amountto=$("#txttoamount").val();
		 if(amountto==""){
		 	amountto="0";
		 }
		 if(parseFloat(amountto)!=0){   	
			 type=document.getElementById("cmbtotype").value;
			 if(type==""){
				 document.getElementById("errormsg").innerText="Enter Type";
				 return 0;
			 }
				 
			 accid=document.getElementById("txttoaccid").value;
			 if(accid==""){
				 document.getElementById("errormsg").innerText="Enter Account";
				 return 0;
			 }
				 
			 currencyto=document.getElementById("cmbtocurrency").value;
			 acnoto=document.getElementById("txttoaccid").value;
			 if(currencyto=="" && acnoto!=""){
				 document.getElementById("errormsg").innerText="Currency & Rate is Mandatory.";
				 return 0;
			 }
				 
			 rate1=document.getElementById("txttorate").value;
			 if(rate1=="" || rate1=="0" || rate1=="0.00"){
				 document.getElementById("errormsg").innerText= "Rate is Mandatory.";
				 return 0;
			 }
		 }   
		  
		 if(isNaN(crtot) ||  isNaN(drtot)  || typeof(drtot)=="NaN"|| crtot=="NaN" || typeof(crtot)=="NaN" || drtot=="" || crtot=="" || drtot=="NaN" || crtot=="NaN" || drtot=="0" || crtot=="0" || drtot=="0.0" || crtot=="0.0" || drtot=="0.00" || crtot=="0.00"){
		     document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should not be Zero.";
		     return 0;
		 }
		 rate=document.getElementById("txtfromrate").value;
		 if(rate=="" || rate=="0" || rate=="0.00"){
			 document.getElementById("errormsg").innerText= "Rate is Mandatory.";
			 return 0;
		 }
		 var balanceamt = $("#txtapplyinvoicebalance").val();   
		 if(parseInt(balanceamt)<0){
		     document.getElementById("errormsg").innerText= "Invalid applying amount!!!";
			 return 0;
		 }
		 		
	    	
	     /* Validation Ends*/
	    	  
	     /* Cash Receipt Grid  Saving*/
	 	 var rows = $("#jqxCashReceipt").jqxGrid('getrows');
	 	 var length=0,val=0,valid=0;
		 for(var i=0 ; i < rows.length ; i++){
			var chk=rows[i].docno;
			var rate=rows[i].rate;
			var amount=rows[i].amount1;
				 
			if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
	 			newTextBox = $(document.createElement("input"))
	 			    .attr("type", "dil")
	 			    .attr("id", "test"+length)
	 			    .attr("name", "test"+length)
	 			    .attr("hidden", "true");
	 			length=length+1;
	 			if(rate=="" || rate=="0" || rate=="0.00"){
					val=1;
					break;
				}
	 			if(amount=="" || amount=="0" || amount=="0.00"){
					valid=1;
					break;
				}
	 					
	 			var amount,baseamount;
	 			if(rows[i].dr==true){
					amount=rows[i].amount1*-1;
					baseamount=rows[i].baseamount1*-1;
				}
				else if(rows[i].dr==false){
					amount=rows[i].amount1;
					baseamount=rows[i].baseamount1;
				}
	 					
	 			newTextBox.val(rows[i].docno+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+rows[i].dr+"::"+amount+"::"+rows[i].description+"::"+baseamount+"::0:: "+rows[i].costtype+":: "+rows[i].costcode);
	 			newTextBox.appendTo('form');
		     }
	 	}
		if(val==1){
			document.getElementById("errormsg").innerText= "Rate is Mandatory.";
			return 0;
		} 
		if(valid==1){
			document.getElementById("errormsg").innerText= "Amount is Mandatory.";
			return 0;
		}
		$('#gridlength').val(length);
	 	/* Cash Receipt Grid  Saving Ends*/	 
	 	 		
	 	/* Applying Invoice Grid Saving */
	 	var rows = $("#jqxApplyCashReceiptInvoicing").jqxGrid('getrows');
	 	var lengthapply=0,val2=0;
	 	for(var i=0 ; i < rows.length ; i++){
	 		var chks= $("#jqxApplyCashReceiptInvoicing").jqxGrid('getcelltext',i,'applying');
	 		var balance=rows[i].balance;
			if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != ""){
	 			newTextBox = $(document.createElement("input"))
	 				.attr("type", "dil")
	 				.attr("id", "txtapply"+lengthapply)
	 				.attr("name", "txtapply"+lengthapply)
	 				.attr("hidden", "true");
	 			lengthapply=lengthapply+1;
	 			if(balance<0){
		 			val2=1;
		 			break;
		 		}
	 			newTextBox.val(rows[i].applying+"::"+(parseFloat(rows[i].out_amount)+parseFloat(rows[i].applying))*-1+"::"+rows[i].currency+"::"+rows[i].tranid+"::"+rows[i].acno);
	 			newTextBox.appendTo('form');  
	 		}
	 	}
	 	if(val2==1){   
	 		document.getElementById("errormsg").innerText= "Invalid applying amount!!!";
			return 0; 
	 	} 
	 	$('#applylength').val(lengthapply);
	 	/* Applying Invoice Grid Saving Ends*/
	 			 
	 	/* Applying Invoice Grid Updating */
	 	var rows = $("#jqxApplyCashReceiptInvoicing").jqxGrid('getrows');
	 	var lengthupdate=0;
	 	for(var i=0 ; i < rows.length ; i++){
	 	    var chkd=rows[i].applying;
		 	if(typeof(chkd) != "undefined" && typeof(chkd) != "NaN" && chkd != ""){
	 			newTextBox = $(document.createElement("input"))
	 				.attr("type", "dil")
	 				.attr("id", "txtapplyupdate"+lengthupdate)
	 				.attr("name", "txtapplyupdate"+lengthupdate)
	 				.attr("hidden", "true");
	 			lengthupdate=lengthupdate+1;
	 						
	 			newTextBox.val(parseFloat(rows[i].out_amount)-parseFloat(rows[i].applying)+"::"+rows[i].tranid);
	 			newTextBox.appendTo('form');
	 		}
		}
		$('#applylengthupdate').val(lengthupdate);
	 	/* Applying Invoice Grid Updating Ends*/
	 				 
	 	if ($("#mode").val() == "E") {
			$('#frmCashReceipt select').attr('disabled', false); 
		}
	 	$('#cmbfromcurrency').attr('disabled', false);
	 	$('#cmbtocurrency').attr('disabled', false);
	 	document.getElementById("errormsg").innerText="";
	    return 1;
	} 
	  
	function setValues(){
        $('#jqxCashReceiptDate').jqxDateTimeInput({disabled: false});
        var date = $('#jqxCashReceiptDate').val();
        getCurrencyId(date);
        $('#jqxCashReceiptDate').jqxDateTimeInput({disabled: true});

        document.getElementById("cmbtotype").value=document.getElementById("hidcmbtotype").value;

        if($('#hidjqxCashReceiptDate').val()){
            $("#jqxCashReceiptDate").jqxDateTimeInput('val', $('#hidjqxCashReceiptDate').val());
        }

        if($('#hidmaindate').val()){
            $("#maindate").jqxDateTimeInput('val', $('#hidmaindate').val());
        }

        if($('#msg').val()!=""){
            $.messager.alert('Message',$('#msg').val());
        }

        document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
        funSetlabel();

        var indexVal = document.getElementById("docno").value;
        if(indexVal>0){
            var check=1;
            // Load cash receipt grid and handle completion
            $("#jqxCashReceiptGrid").load("cashReceiptGrid.jsp?txtcashpaydocno2="+indexVal+"&check="+check, function() {
                // Grid loading complete, now load apply invoicing grid if needed
                var indexVal1 = document.getElementById("txttodocno").value;
                var indexVal2 = document.getElementById("txttotrno").value;
                if(indexVal1>0){
                    var check=1;
                    $("#jqxApplyInvoicing1").load("applyCashReceiptInvoicingGrid.jsp?txttoaccid1="+indexVal1+"&txttotrno1="+indexVal2+"&check="+check, function() {
                        // After all grids are loaded, load approvals
                        loadApprovals();
                    });
                } else {
                    // If no apply invoicing grid, still load approvals
                    loadApprovals();
                }
            });
        }

        if(parseFloat($("#hidstatus").val())<3){
            $("#txtStatus").html("DRAFT");
        }else if(parseFloat($("#hidstatus").val())==4){
            $("#txtStatus").html("REJECTED");
        }else{
            $("#txtStatus").html("");
        }

        getBankReconciled($("#docno").val(), "CRV");

        // Round all amounts
        funRoundRate($('#txtfromrate').val(),"txtfromrate");
        funRoundRate($('#txttorate').val(),"txttorate");
        funRoundAmt($('#txtfromamount').val(),"txtfromamount");
        funRoundAmt($('#txttoamount').val(),"txttoamount");
        funRoundAmt($('#txtfrombaseamount').val(),"txtfrombaseamount");
        funRoundAmt($('#txttobaseamount').val(),"txttobaseamount");
        funRoundAmt($('#txtapplyinvoiceamt').val(),"txtapplyinvoiceamt");
        funRoundAmt($('#txtapplyinvoiceapply').val(),"txtapplyinvoiceapply");
        funRoundAmt($('#txtapplyinvoicebalance').val(),"txtapplyinvoicebalance");
        funRoundAmt($('#txtdrtotal').val(),"txtdrtotal");
        funRoundAmt($('#txtcrtotal').val(),"txtcrtotal");
    }

	function funvalid(){
		 rate=document.getElementById("txtfromrate").value;
		 if(rate=="" || rate=="0" || rate=="0.00"){
			 document.getElementById("validrate").innerText= "Rate is Mandatory.";
			 document.getElementById("txtfromrate").focus();
			 return 0;
		 }
		 else{
			 document.getElementById("validrate").innerText= "";
			 
		 }
	}
	
	function funvalid1(){
		 rate1=document.getElementById("txttorate").value;
		 if(rate1=="" || rate1=="0" || rate1=="0.00"){
			 document.getElementById("validrate1").innerText= "Rate is Mandatory.";
			 document.getElementById("txttorate").focus();
			 return 0;
		 }
		 else{
			 document.getElementById("validrate1").innerText= "";
			 
		 }
	}
	  
	function getDrTotal(){
		var fromamount = $('#txtfrombaseamount').val();
		  
		if(!isNaN(fromamount)){
			  
		    var dr=0.0,cr=0.0,dr1=0.0;
  	        var rows = $('#jqxCashReceipt').jqxGrid('getrows');
	        var rowlength= rows.length;
	 		for(var i=0;i<=rowlength-1;i++) {
	 		
	 		  var value = rows[i].dr;
	          var baseamount = rows[i].baseamount1;
	          
	          if(typeof(baseamount) != "undefined" && typeof(baseamount) != "NaN" && baseamount != ""){
	        	  if(value==true){
               	   if(!isNaN(baseamount)){
               	      cr=cr+baseamount;
               	   }else if(isNaN(baseamount)){
                 		 baseamount=0.00;
                 		 cr=cr+baseamount;
                 	   }
                  }
                  else{
               	   if(!isNaN(baseamount)){
                    	 	dr=dr+baseamount;
                  	   }else if(isNaN(baseamount)){
                  		    baseamount=0.00;
                  		 	dr=dr+baseamount;
                  	   }
                    }
	 	       }
	 		}
	 		
	 		if(!isNaN(fromamount)){
                dr1=parseFloat(dr) + parseFloat(fromamount);
                funRoundAmt(dr1,"txtdrtotal");
            }
	    }
		else if(isNaN(fromamount)){
			$('#txtdrtotal').val(0.00);
			$('#txtfrombaseamount').val(0.00);			
		}
	} 
	  
	function getCrTotal(){
		var toamount = $('#txttobaseamount').val();
		if(!isNaN(toamount)){
			  
			var dr=0.0,cr=0.0,cr1=0.0;
        	var rows = $('#jqxCashReceipt').jqxGrid('getrows');
    	    var rowlength= rows.length;
        	for(var i=0;i<=rowlength-1;i++) {
        		
        		var value = rows[i].dr;
                var baseamount = rows[i].baseamount1;
                
                if(typeof(baseamount) != "undefined" && typeof(baseamount) != "NaN" && baseamount != ""){
                	 if(value==true){
                  	   if(!isNaN(baseamount)){
                  	      cr=cr+baseamount;
                  	   }else if(isNaN(baseamount)){
                    		 baseamount=0.00;
                    		 cr=cr+baseamount;
                    	   }
                     }
                     else{
                  	   if(!isNaN(baseamount)){
                       	 	dr=dr+baseamount;
                      	   }else if(isNaN(baseamount)){
                      		    baseamount=0.00;
                      		 	dr=dr+baseamount;
                      	   }
                       }
        	       }
        		}
        		
        		if(!isNaN(toamount)){
                    cr1=parseFloat(cr) + parseFloat(toamount);
                    funRoundAmt(cr1,"txtcrtotal");
                }
		}
		else if(isNaN(toamount)){
			$('#txtcrtotal').val(0.00);
			$('#txttoamount').val(0.00);
		}
	} 
	  
	function getAmount(){
		var toamount = $('#txttoamount').val();
		if(!isNaN(toamount)){
		    funRoundAmt(toamount,"txtapplyinvoiceamt");
		}
		else if(isNaN(toamount)){
			$('#txtapplyinvoiceamt').val(0.00);
			$('#txttoamount').val(0.00);
		}
	}
	  
	function getAcc(event){
        var x= event.keyCode;
        if(x==114){
            /* Use SVG search icon internally now instead of forcing F3 */
        	var date = $('#jqxCashReceiptDate').jqxDateTimeInput('getDate');
        	$("#maindate").jqxDateTimeInput('val', date);
        	accountFromSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
        }
    }
	  
	function getAccType(event){
        var x= event.keyCode;
        if(x==114){
            /* Use SVG search icon internally now instead of forcing F3 */
        	var date = $('#jqxCashReceiptDate').jqxDateTimeInput('getDate');
        	$("#maindate").jqxDateTimeInput('val', date);
        	accountToSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtotype').val()+"&date="+date);
        }
    }
	  
	function funPrintBtn() {
		if (($("#mode").val() == "view") && $("#docno").val()!="") {
		    var url=document.URL;
		    var reurl=url.split("saveCashReceipt");
		    $("#docno").prop("disabled", false);  
		 
		    $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
                let win;
				if (r){
					win= window.open(reurl[0]+"printCashReceipt?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
				}
				else{
                    win= window.open(reurl[0]+"printCashReceipt?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
				}
                if (win) {
                    setTimeout(function() {
                        win.focus();
                        win.print();
                    });
                }else {
                    console.error("Win object not loaded");
                }
		    });
		}
		else {
			$.messager.alert('Message','Select a Document....!','warning');
			return;
		}
    }
	  
	function clearClientInfo(){
		$("#txttodocno").val('');$("#txttoaccid").val('');$("#txttoaccname").val('');$("#txtapplyinvoiceapply").val(0.00);
		$("#jqxApplyCashReceiptInvoicing").jqxGrid('clear');
		$("#jqxApplyCashReceiptInvoicing").jqxGrid('addrow', null, {});
		var atype=$('#cmbtotype').val();
      	if(atype != "AR"){
      		$("#jqxApplyCashReceiptInvoicing").jqxGrid({ disabled: true});
      	}else if(atype == "AR"){
      		$("#jqxApplyCashReceiptInvoicing").jqxGrid({ disabled: false});
      	}
	}
	  
	function datechange(){
		var date = $('#jqxCashReceiptDate').jqxDateTimeInput('getDate');
		var validdate=funDateInPeriod(date);
		if(parseInt(validdate)==0){
			document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
			return 0;	
		}
		$("#maindate").jqxDateTimeInput('val', date);
	}
</script>

</head>
<body onload="setValues();">

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmCashReceipt" action="saveCashReceipt" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>

    <div class="middle-panel">
        <span class="middle-panel-title">General Info</span>
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:80px;">Date</label>
            <div style="width: 125px;">
                <div id="jqxCashReceiptDate" name="jqxCashReceiptDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxCashReceiptDate"/>'></div>
                <input type="hidden" id="hidjqxCashReceiptDate" name="hidjqxCashReceiptDate" value='<s:property value="hidjqxCashReceiptDate"/>'/>
            </div>
            
            <label class="lbl-right" style="width:80px;">Ref. No.</label>
            <input type="text" id="txtrefno" name="txtrefno" value='<s:property value="txtrefno"/>' style="width:120px;" />
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No.</label>
            <input type="text" id="docno" name="txtcashreceiptdocno" value='<s:property value="txtcashreceiptdocno"/>' tabindex="-1" style="width:120px;" readonly />
            
            <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button>
            <span id="txtStatus" style="font-weight:bold; color:#e67e22; margin-left:10px;"></span>
        </div>
    </div>

    <div style="display: flex; gap: 15px; margin-bottom: 15px;">
        
        <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
            <span class="middle-panel-title">Cash</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Cash Account</label>
                <div class="input-search-container" style="width: 120px;">
                    <input type="text" id="txtfromaccid" name="txtfromaccid" placeholder="Press F3" value='<s:property value="txtfromaccid"/>' onkeydown="getAcc(event);" />
                    <svg class="magnifier-icon" onclick="var d=$('#jqxCashReceiptDate').jqxDateTimeInput('getDate'); $('#maindate').jqxDateTimeInput('val', d); accountFromSearchContent('<%=contextPath%>/com/finance/accountsDetailsSearch.jsp?date='+d);" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                <input type="text" id="txtfromaccname" name="txtfromaccname" value='<s:property value="txtfromaccname"/>' style="flex:1;" tabindex="-1" readonly />
                <input type="hidden" id="txtfromdocno" name="txtfromdocno" value='<s:property value="txtfromdocno"/>' />
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Currency</label>
                <select id="cmbfromcurrency" name="cmbfromcurrency" style="width:120px;" value='<s:property value="cmbfromcurrency"/>' onchange="getRate(this.value,$('#jqxCashReceiptDate').val());">
                    </select>
                <input type="hidden" id="hidcmbfromcurrency" name="hidcmbfromcurrency" value='<s:property value="hidcmbfromcurrency"/>' />
                <input type="hidden" id="hidfromcurrencytype" name="hidfromcurrencytype" value='<s:property value="hidfromcurrencytype"/>' />
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Rate</label>
                <input type="text" id="txtfromrate" name="txtfromrate" onchange="funvalid()" style="width:120px; text-align:right;" value='<s:property value="txtfromrate"/>' onblur="funRoundRate(this.value,this.id);getBaseAmountFrom();getDrTotal();" tabindex="-1" />
                <span id="validrate" class="val-error" style="width:100%; text-align:right;"></span>
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Amount</label>
                <input type="text" id="txtfromamount" name="txtfromamount" style="width:120px; text-align:right;" value='<s:property value="txtfromamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getDrTotal();" />
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Base Amount</label>
                <input type="text" id="txtfrombaseamount" name="txtfrombaseamount" style="width:120px; text-align:right;" value='<s:property value="txtfrombaseamount"/>' tabindex="-1" readonly />
            </div>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:100px;">Description</label>
                <input type="text" id="txtdescription" name="txtdescription" value='<s:property value="txtdescription"/>' style="flex:1;" />
            </div>
        </div>

        <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
            <span class="middle-panel-title">Payment From</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Type</label>
                <select id="cmbtotype" name="cmbtotype" style="width:80px;" onchange="clearClientInfo();" value='<s:property value="cmbtotype"/>'>
                    <option value="AR">AR</option>
                    <option value="AP">AP</option>
                </select>
                <input type="hidden" id="hidcmbtotype" name="hidcmbtotype" value='<s:property value="hidcmbtotype"/>' />
                
                <div class="input-search-container" style="width: 120px; margin-left: 10px;">
                    <input type="text" id="txttoaccid" name="txttoaccid" placeholder="Press F3" value='<s:property value="txttoaccid"/>' onkeydown="getAccType(event);" />
                    <svg class="magnifier-icon" onclick="var d=$('#jqxCashReceiptDate').jqxDateTimeInput('getDate'); $('#maindate').jqxDateTimeInput('val', d); accountToSearchContent('<%=contextPath%>/com/finance/clientAccountDetailsSearch.jsp?atype='+$('#cmbtotype').val()+'&date='+d);" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                <input type="text" id="txttoaccname" name="txttoaccname" value='<s:property value="txttoaccname"/>' style="flex:1;" tabindex="-1" readonly />
                <input type="hidden" id="txttodocno" name="txttodocno" value='<s:property value="txttodocno"/>' />
                <input type="hidden" id="txttotranid" name="txttotranid" value='<s:property value="txttotranid"/>' />
                <input type="hidden" id="txttotrno" name="txttotrno" value='<s:property value="txttotrno"/>' />
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Currency</label>
                <select id="cmbtocurrency" name="cmbtocurrency" style="width:120px;" value='<s:property value="cmbtocurrency"/>' onchange="getRatevalue(this.value,$('#jqxCashReceiptDate').val());">
                    <option></option>
                </select>
                <input type="hidden" id="hidcmbtocurrency" name="hidcmbtocurrency" value='<s:property value="hidcmbtocurrency"/>' />
                <input type="hidden" id="hidtocurrencytype" name="hidtocurrencytype" value='<s:property value="hidtocurrencytype"/>' />
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Rate</label>
                <input type="text" id="txttorate" name="txttorate" onchange="funvalid1()" style="width:120px; text-align:right;" value='<s:property value="txttorate"/>' onblur="funRoundRate(this.value,this.id);getBaseAmountTo();getCrTotal();" tabindex="-1" />
                <span id="validrate1" class="val-error" style="width:100%; text-align:right;"></span>
            </div>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px;">Amount</label>
                <input type="text" id="txttoamount" name="txttoamount" style="width:120px; text-align:right;" value='<s:property value="txttoamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountTo();getCrTotal();getAmount();" onfocus="this.oldvalue = this.value;" onchange="funPaymentAmount(this);this.oldvalue = this.value;" />
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Base Amount</label>
                <input type="text" id="txttobaseamount" name="txttobaseamount" style="width:120px; text-align:right;" value='<s:property value="txttobaseamount"/>' tabindex="-1" readonly />
            </div>
        </div>
        
    </div>

    <div class="middle-panel">
        <span class="middle-panel-title">Apply Invoices</span>
        <div id="jqxApplyInvoicing1" class="grid-container">
            <jsp:include page="applyCashReceiptInvoicingGrid.jsp"></jsp:include>
        </div>
        
        <div class="field-row" style="margin-top: 15px; justify-content: flex-end; margin-bottom:0;">
            <label class="lbl-right" style="width:60px;">Amount</label>
            <input type="text" id="txtapplyinvoiceamt" name="txtapplyinvoiceamt" style="width:100px; text-align:right;" value='<s:property value="txtapplyinvoiceamt"/>' readonly />
            <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>' />
            
            <label class="lbl-right" style="width:60px; margin-left:15px;">Applied</label>
            <input type="text" id="txtapplyinvoiceapply" name="txtapplyinvoiceapply" style="width:100px; text-align:right;" value='<s:property value="txtapplyinvoiceapply"/>' tabindex="-1" readonly />
            
            <label class="lbl-right" style="width:60px; margin-left:15px;">Balance</label>
            <input type="text" id="txtapplyinvoicebalance" name="txtapplyinvoicebalance" style="width:100px; text-align:right;" value='<s:property value="txtapplyinvoicebalance"/>' tabindex="-1" readonly />
        </div>
    </div>

    <div class="middle-panel">
        <span class="middle-panel-title">Receipt Allocation</span>
        <div id="jqxCashReceiptGrid" class="grid-container">
            <jsp:include page="cashReceiptGrid.jsp"></jsp:include>
        </div>
        
        <div class="field-row" style="margin-top: 15px; justify-content: flex-end; margin-bottom:0;">
            <label class="lbl-right" style="width:60px;">Dr. Total</label>
            <input type="text" id="txtdrtotal" name="txtdrtotal" style="width:100px; text-align:right;" value='<s:property value="txtdrtotal"/>' readonly />
            
            <label class="lbl-right" style="width:60px; margin-left:15px;">Cr. Total</label>
            <input type="text" id="txtcrtotal" name="txtcrtotal" style="width:100px; text-align:right;" value='<s:property value="txtcrtotal"/>' tabindex="-1" readonly />
        </div>
    </div>

    <div class="middle-panel">
        <span class="middle-panel-title">Approvals</span>
        <table class="cr-table" id="approval-table">
            <thead>
                <tr>
                    <th>Approved By</th>
                    <th>Date</th>
                    <th>Remarks</th>
                </tr>
            </thead>
            <tbody>
                </tbody>
        </table>
    </div>

    <script type="text/javascript">
    function loadApprovals() {
        var docno = document.getElementById('docno').value;
        var dtype = document.getElementById('formdetailcode').value;
        var brch = document.getElementById('brchName').value;
        var usrid = '';
        if (window.parent && window.parent.document.getElementById('formdetailcode')) {
            usrid = window.parent.document.getElementById('formdetailcode').value;
        }
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText.trim();
                var rows = items.split('\n');
                var tbody = document.querySelector('#approval-table tbody');
                tbody.innerHTML = '';
                if (rows.length > 0 && rows[0] !== '') {
                    rows.forEach(function(row) {
                        var cols = row.split(',');
                        var tr = document.createElement('tr');
                        for (var i = 0; i < 3; i++) {
                            var td = document.createElement('td');
                            td.textContent = cols[i] ? cols[i] : '';
                            tr.appendChild(td);
                        }
                        tbody.appendChild(tr);
                    });
                } else {
                    var tr = document.createElement('tr');
                    tr.innerHTML = '<td colspan="3" style="text-align:center;color:#888;">No approvals found</td>';
                    tbody.appendChild(tr);
                }
            }
        };
        x.open("GET", '<%=contextPath%>/com/finance/transactions/cashreceipt/getApprovals.jsp?docno=' + docno + '&dtype=' + dtype + '&brch=' + brch, true);
        x.send();
    }
    document.addEventListener('DOMContentLoaded', function() {
        loadApprovals();
    });
    </script>

    <div style="display:none;">
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
        <input type="hidden" name="txtforsearch" id="txtforsearch" value="0"/>
        <div id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
        <input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
        <input type="hidden" id="gridlength" name="gridlength"/>
        <input type="hidden" id="applylength" name="applylength"/>
        <input type="hidden" id="applylengthupdate" name="applylengthupdate"/>
        <input type="hidden" id="hidstatus" name="hidstatus" value='<s:property value="status"/>'/>
    </div>

</div>
</form>
	
<div id="cashReceiptGridWindow"><div></div><div></div></div>  
<div id="accountDetailsFromWindow"><div></div><div></div></div>  
<div id="accountDetailsToWindow"><div></div><div></div></div> 
<div id="costTypeSearchGridWindow"><div></div><div></div></div> 
<div id="costCodeSearchWindow"><div></div><div></div></div> 
	
</div>
</body>
</html>