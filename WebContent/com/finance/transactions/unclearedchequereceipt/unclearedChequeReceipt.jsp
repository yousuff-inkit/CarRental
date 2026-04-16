<%@ taglib prefix="s" uri="/struts-tags"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>
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
   UNCLEARED CHEQUE RECEIPT - SEGOE UI / CLEAN WHITE UI
========================================================= */
body, .homeContent {
    background-color: #fff !important; /* Pure White Background */
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    color: #333 !important;
    font-size: 12px !important;
    margin: 0;
    box-sizing: border-box;
}

#mainBG {
    background: #fff;
    border-radius: 4px;
    padding: 15px;
    max-width: 100%;
    margin: auto;
    box-shadow: 0 1px 4px rgba(0,0,0,0.1);
    box-sizing: border-box;
}

/* Responsive scroll area so the bottom is never cut off */
.hidden-scrollbar {
    overflow-y: auto;
    overflow-x: hidden;
    height: calc(100vh - 140px);
    padding-bottom: 60px;
    box-sizing: border-box;
}

form label.error {
    color: red;
    font-weight: bold;
    font-size: 11px;
}

#validrate, #validrate1 {
    color: red;
    font-size: 11px;
    font-weight: bold;
}

/* EXACT Input Styles from Client Master */
input[type="text"], input[type="email"], select {
    height: 24px !important; 
    border: 1px solid #ccc !important;
    border-radius: 3px !important;
    padding: 2px 6px !important;
    font-size: 12px !important; /* Updated for Segoe UI */
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    box-sizing: border-box;
    background-color: #fff !important;
    color: #333 !important;
    width: 100%;
}

input[type="text"]:focus, input[type="email"]:focus, select:focus {
    border-color: #007bff !important;
    background-color: #FFD6FF !important; /* Client Master Focus Color */
    outline: none !important;
}

input[readonly], input:disabled, select:disabled {
    background-color: #f4f5f7 !important;
    color: #5e6c84 !important;
    border-color: #e1e4e8 !important;
}

/* Fieldset and Legend styling */
fieldset {
    border: 1px solid #e1e4e8 !important;
    background-color: #fff !important; /* No Blue Background */
    margin-bottom: 10px !important;
    padding: 12px 10px 10px 10px !important;
    border-radius: 4px !important;
}

legend {
    font-size: 13px !important;
    font-weight: bold !important;
    color: #0056b3 !important;
    padding: 0 0 0 6px !important;
    border-left: 3px solid #0056b3 !important;
    margin-bottom: 5px !important;
    background: #fff;
}

/* Table adjustments for compact text */
table td {
    padding: 4px 6px !important;
    font-size: 12px !important;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    color: #222 !important;
    font-weight: 600 !important; /* Match Segoe UI bold look */
    vertical-align: middle;
}

.lbl-right { 
    text-align: right; 
    color: #222 !important;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Value Change Button */
.erp-btn-warning {
    height: 24px !important;
    padding: 0 10px !important;
    background-color: #f39c12 !important;
    color: #fff !important;
    border: none !important;
    border-radius: 3px !important;
    font-size: 12px !important;
    font-weight: bold !important;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    cursor: pointer !important;
}

/* Search Icon Wrapper */
.input-search-container {
    position: relative;
    display: block;
    width: 100%;
}
.input-search-container input {
    padding-right: 25px !important;
}
.magnifier-icon {
    position: absolute;
    right: 4px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
.magnifier-icon:hover { color: #2563eb; }

</style>

<script type="text/javascript">
	$(document).ready(function() {
		 $("#btnvaluechange").hide();
		
		 $("#jqxUnclearedChequeReceiptDate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
		 $("#jqxChequeDate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
		
		 $('#accountDetailsToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsToWindow').jqxWindow('close');  
		 
		 $('#accountDetailsFromWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsFromWindow').jqxWindow('close');
		 
		 $('#unclearedChequeReceiptGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#unclearedChequeReceiptGridWindow').jqxWindow('close');
		 
		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#costTypeSearchGridWindow').jqxWindow('close');
 		 
 		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
		 
		 $('#printWindow').jqxWindow({width: '51%', height: '31%',  maxHeight: '50%' ,maxWidth: '51%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#printWindow').jqxWindow('close');
		 
		 $('#jqxUnclearedChequeReceiptDate').on('change', function (event) {
				 var bankpaydate = $('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput('getDate');
				 var validdate=funDateInPeriod(bankpaydate);
				 if(parseInt(validdate)==0){
					document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
					return 0;	
				 }
			 });
		 
		 $('#txtfromaccid').dblclick(function(){ openFromAcc(); });
		 $('#txttoaccid').dblclick(function(){ openToAcc(); });  
	});
	
	function openFromAcc() {
        var date = $('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput('getDate');
        $("#maindate").jqxDateTimeInput('val', date);
        accountFromSearchContent("<%=contextPath%>/com/finance/accountsDetailsSearch.jsp?date="+date);
    }

    function openToAcc() {
        var date = $('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput('getDate');
        $("#maindate").jqxDateTimeInput('val', date);
        accountToSearchContent("<%=contextPath%>/com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtotype').val()+"&date="+date);
    }
	
	function unclearedChequeSearchContent(url) {
		$('#unclearedChequeReceiptGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#unclearedChequeReceiptGridWindow').jqxWindow('setContent', data);
		$('#unclearedChequeReceiptGridWindow').jqxWindow('bringToFront');
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
	
	function unclearedChequePrintContent(url) {
		$('#printWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#printWindow').jqxWindow('setContent', data);
		$('#printWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	/* SAFE READONLY FUNCTION */
	function funReadOnly(){
	    try {
			$('#frmUnclearedChequeReceipt input').attr('readonly', true );
			$('#frmUnclearedChequeReceipt select').attr('disabled', true);
			$('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput({disabled: true});
			$('#jqxChequeDate').jqxDateTimeInput({disabled: true});
			if($("#jqxUnclearedChequeReceipt").length) $("#jqxUnclearedChequeReceipt").jqxGrid({ disabled: true});
			$("#btnvaluechange").hide();
	    } catch(e) { console.error("Error in funReadOnly: ", e); }
	}
	 
	/* SAFE REMOVE READONLY FUNCTION */
	function funRemoveReadOnly(){
	    try {
			$('#frmUnclearedChequeReceipt input').attr('readonly', false );
			$('#frmUnclearedChequeReceipt select').attr('disabled', false);
			$('#cmbfromcurrency').attr('disabled', true);
			$('#cmbtocurrency').attr('disabled', true);
			
			$('#txtfromaccid').attr('readonly', true );
			$('#txtfromaccname').attr('readonly', true );
			$('#txttoaccid').attr('readonly', true );
			$('#txttoaccname').attr('readonly', true );
			$('#txtdrtotal').attr('readonly', true );
			$('#txtcrtotal').attr('readonly', true );
			$('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput({disabled: false});
			$('#jqxChequeDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			
			if($("#jqxUnclearedChequeReceipt").length) $("#jqxUnclearedChequeReceipt").jqxGrid({ disabled: false});
		
			var date = $('#jqxUnclearedChequeReceiptDate').val();
		    getCurrencyId(date);
			
			if ($("#mode").val() == "E") {
             $("#btnvaluechange").show();
             $('#frmUnclearedChequeReceipt input').attr('readonly', true );
   			 $('#frmUnclearedChequeReceipt select').attr('disabled', true);
   			 $('#jqxChequeDate').jqxDateTimeInput({disabled: true});
			 if($("#jqxUnclearedChequeReceipt").length) $("#jqxUnclearedChequeReceipt").jqxGrid({ disabled: true});
   			 $('#txtrefno').attr('readonly', false );
   			 if($("#jqxUnclearedChequeReceipt").length) $("#jqxUnclearedChequeReceipt").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","dr": true,"amount1": "","description": ""});
			} else{
				$("#btnvaluechange").hide();
			} 
			
			if ($("#mode").val() == "A") {
				$('#jqxUnclearedChequeReceiptDate').val(new Date());
				if($("#jqxUnclearedChequeReceipt").length) {
				    $("#jqxUnclearedChequeReceipt").jqxGrid('clear'); 
				    $("#jqxUnclearedChequeReceipt").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","dr": true,"amount1": "","description": ""});
				}
			}
	    } catch(e) { console.error("Error in funRemoveReadOnly: ", e); }
	}
	 
	 function funSearchLoad(){ changeContent('ucrMainSearch.jsp'); }
		
	 function funChkButton() { }
	 
	 function funFocus() { $('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput('focus'); }
	 
	  /* Validations */
	   $(function(){
	        $('#frmUnclearedChequeReceipt').validate({
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
	        });});
	   
	  function funNotify(){	
		  /* Validation */
		    var bankpaydate = $('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput('getDate');
			var validdate=funDateInPeriod(bankpaydate);
			if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
			}
			bank=document.getElementById("txtfromaccid").value;
			 if(bank==""){
				 document.getElementById("errormsg").innerText="Enter Bank";
				 return 0;
			 }
			 type=document.getElementById("cmbtotype").value;
			 if(type==""){
				 document.getElementById("errormsg").innerText="Enter Type";
				 return 0;
			 }
			 acc=document.getElementById("txttoaccid").value;
			 if(acc==""){
				 document.getElementById("errormsg").innerText="Enter Account";
				 return 0;
			 }
			
			currency=document.getElementById("cmbfromcurrency").value;
			 if(currency==""){
				 document.getElementById("errormsg").innerText="Currency & Rate is Mandatory.";
				 return 0;
			 }
			 
			 currencyto=document.getElementById("cmbtocurrency").value;
			 acnoto=document.getElementById("txttoaccid").value;
			 if(currencyto=="" && acnoto!=""){
				 document.getElementById("errormsg").innerText="Currency & Rate is Mandatory.";
				 return 0;
			 }
		  
		    var drtot = parseFloat(document.getElementById("txtdrtotal").value);
	 		var crtot = parseFloat(document.getElementById("txtcrtotal").value);
	 		if(drtot>crtot || drtot<crtot){
	 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should be Equal.";
              return 0;
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
			 rate1=document.getElementById("txttorate").value;
			 if(rate1=="" || rate1=="0" || rate1=="0.00"){
				 document.getElementById("errormsg").innerText= "Rate is Mandatory.";
				 return 0;
			 }
	 	    
	 		
	 		document.getElementById("errormsg").innerText="";
	 		
	    /* Validation Ends*/
	    
	    	/* Uncleared Cheque Receipt Grid  Saving*/
	 		  var rows = $("#jqxUnclearedChequeReceipt").jqxGrid('getrows');
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
	 						 baseamount=rows[i].rate*rows[i].amount1*-1;
	 					}
	 					else if(rows[i].dr==false){
	 						 amount=rows[i].amount1;
	 						 baseamount=rows[i].rate*rows[i].amount1;
	 					}
	 					
	 				newTextBox.val(rows[i].docno+":: "+rows[i].currencyid+":: "+rows[i].rate+":: "+rows[i].dr+":: "+rows[i].amount1+":: "+rows[i].description+":: "+baseamount+":: "+rows[i].costtype+":: "+rows[i].costcode);
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
	 	 		   /* Uncleared Cheque Receipt Grid  Saving Ends*/	
	 				
	 				 $('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput({disabled: false});
			         $('#jqxChequeDate').jqxDateTimeInput({disabled: false});
			         
			         if ($("#mode").val() == "E") {
			        	 $('#frmUnclearedChequeReceipt select').attr('disabled', false); 
			         }
			         $('#cmbfromcurrency').attr('disabled', false);
			 		  $('#cmbtocurrency').attr('disabled', false);
			 		
	    		return 1;
		} 
	  
	  /* SAFE SET VALUES FUNCTION */
	  function setValues(){
	      try {
    		  $('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput({disabled: false});
    		  var date = $('#jqxUnclearedChequeReceiptDate').val();
    		  
    		  if(typeof getCurrencyId === 'function') getCurrencyId(date);
    		  
    		  $('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput({disabled: true});
    		  
    		  if(document.getElementById("cmbtotype") && document.getElementById("hidcmbtotype")) {
    		      document.getElementById("cmbtotype").value=document.getElementById("hidcmbtotype").value;
    		  }
    		  
    		  if($('#hidjqxUnclearedChequeReceiptDate').length && $('#hidjqxUnclearedChequeReceiptDate').val()){
    				 $("#jqxUnclearedChequeReceiptDate").jqxDateTimeInput('val', $('#hidjqxUnclearedChequeReceiptDate').val());
    		  }
    		  if($('#hidmaindate').length && $('#hidmaindate').val()){
    				 $("#maindate").jqxDateTimeInput('val', $('#hidmaindate').val());
    		  }
    		  if($('#hidjqxChequeDate').length && $('#hidjqxChequeDate').val()){
    				 $("#jqxChequeDate").jqxDateTimeInput('val', $('#hidjqxChequeDate').val());
    		  }
    		  
    		  if($('#msg').length && $('#msg').val()!=""){
    			   $.messager.alert('Message',$('#msg').val());
    		  }
    		  
    		  if (document.getElementById("formdet") && $('#formdetail').length && $('#formdetailcode').length) {
                  var detailVal = $('#formdetail').val() || "";
                  var codeVal = $('#formdetailcode').val() || "";
                  document.getElementById("formdet").innerText = detailVal + " (" + codeVal.trim() + ")";
              }
              
    		  if(typeof funSetlabel === 'function') funSetlabel();
    			
    		  var indexVal = document.getElementById("docno") ? document.getElementById("docno").value : 0;
    		  if(indexVal>0 && $("#jqxUnclearedChequeReceiptGrid").length){
    			  $("#jqxUnclearedChequeReceiptGrid").load("unclearedChequeReceiptGrid.jsp?txtunclearedchequereceiptdocno2="+indexVal+"&check=1");
    		  }
    		  
    		  if(typeof funRoundRate === 'function') {
        		  funRoundRate($('#txtfromrate').val(),"txtfromrate");
        		  funRoundRate($('#txttorate').val(),"txttorate");
    		  }
    		  if(typeof funRoundAmt === 'function') {
        	      funRoundAmt($('#txtfromamount').val(),"txtfromamount");
        		  funRoundAmt($('#txttoamount').val(),"txttoamount");
        	      funRoundAmt($('#txtfrombaseamount').val(),"txtfrombaseamount");
        	      funRoundAmt($('#txttobaseamount').val(),"txttobaseamount");
        		  funRoundAmt($('#txtdrtotal').val(),"txtdrtotal");
        		  funRoundAmt($('#txtcrtotal').val(),"txtcrtotal");
    		  }
	      } catch(e) { console.error("Error in setValues: ", e); }
	  }
	  
	  function funvalid(){
		  var rate=document.getElementById("txtfromrate").value;
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
		  var rate1=document.getElementById("txttorate").value;
			 if(rate1=="" || rate1=="0" || rate1=="0.00"){
				 document.getElementById("validrate1").innerText= "Rate is Mandatory.";
				 document.getElementById("txttorate").focus();
				 return 0;
			 }
			 else{
				 document.getElementById("validrate1").innerText= "";
				 
			 }
	  }
	
	  
	  function funwarningopen(){
		  $.messager.confirm('Confirm', 'Transaction will affect Links to the applied Bank Reconcilations & Prepayments.', function(r){
			    if (r){
			    	$("#mode").val("EDIT");
					 $('#txtfromaccid').attr('readonly', false);$('#txtfromaccname').attr('readonly', false);$('#txtfromamount').attr('readonly', false);$('#txtchequeno').attr('readonly', false);
					 $('#jqxChequeDate').jqxDateTimeInput({disabled: false});$('#txtdescription').attr('readonly', false);
					 $('#txttoaccid').attr('readonly', false);$('#txttoaccname').attr('readonly', false);$('#txttoamount').attr('readonly', false);$('#txtfromrate').attr('readonly', true);
				     $('#txtfrombaseamount').attr('readonly', true);$('#txttorate').attr('readonly', true);$('#txttobaseamount').attr('readonly', true);
				     $('#txtchequename').attr('readonly', false);$('#txtdrtotal').attr('readonly', true);$('#txtcrtotal').attr('readonly', true);
					 $('#frmUnclearedChequeReceipt select').attr('disabled', false);
					 if($("#jqxUnclearedChequeReceipt").length) $("#jqxUnclearedChequeReceipt").jqxGrid({ disabled: false});  
					 $('#cmbfromcurrency').attr('disabled',true);
					 $('#cmbtocurrency').attr('disabled',true);
				  }
			   });
	  }
	  
	  function getDrTotal(){
		  var fromamount = $('#txtfrombaseamount').val();
		  if(!isNaN(fromamount)){
			  
			    var dr=0.0,cr=0.0,dr1=0.0;
        	    var rows = $('#jqxUnclearedChequeReceipt').jqxGrid('getrows');
    	        var rowlength= rows.length;
        		for(var i=0;i<=rowlength-1;i++) {
        		
        		var value = rows[i].dr;
                var baseamount = rows[i].baseamount1;
                
                if(typeof(baseamount) != "undefined" && typeof(baseamount) != "NaN" && baseamount != ""){
                	  
                	if(value==true){
                  	   if(!isNaN(baseamount)){
                  	      dr=dr+baseamount;
                  	   }else if(isNaN(baseamount)){
                    		    baseamount=0.00;
                    		    dr=dr+baseamount;
                    	   }
                  }
                  else{
                  	   if(!isNaN(baseamount)){
                       	 	cr=cr+baseamount;
                      	   }else if(isNaN(baseamount)){
                      		 baseamount=0.00;
                      		 cr=cr+baseamount;
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
		  	$('#txtfromamount').val(0.00);
		  }
	  }
	  
	  function getCrTotal(){
		  var toamount = $('#txttobaseamount').val();
		  
		  if(!isNaN(toamount)){
			  
		  var dr=0.0,cr=0.0,cr1=0.0;
  	      var rows = $('#jqxUnclearedChequeReceipt').jqxGrid('getrows');
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
	  	  
	  function getAcc(event){
          var x= event.keyCode;
          if(x==114){
        	  openFromAcc();
          }
       }
	  
	  function getAccType(event){
          var x= event.keyCode;
          if(x==114){
        	  openToAcc();
          }
       }
	  
	  
	  function funPrintBtn() {
			
		if (($("#mode").val() == "view") && $("#docno").val()!="") {
			unclearedChequePrintContent('printVoucherWindow.jsp');
		  }
		else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	      }
	  
	  function clearClientInfo(){
	  }
	  
	  function datechange(){
		  var date = $('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput('getDate');
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

<div id="mainBG" class="homeContent hidden-scrollbar" data-type="background">
<form id="frmUnclearedChequeReceipt" action="saveUnclearedChequeReceipt" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<span id="errormsg" style="color:red; font-weight:bold; margin-left: 15px; font-size: 11px; display:block;"></span>

<table width="100%" cellpadding="3" cellspacing="0" style="margin-bottom: 10px;">
  <tr>
    <td width="10%" class="lbl-right">Date</td>
    <td width="20%">
        <div id="jqxUnclearedChequeReceiptDate" name="jqxUnclearedChequeReceiptDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxUnclearedChequeReceiptDate"/>'></div>
        <input type="hidden" id="hidjqxUnclearedChequeReceiptDate" name="hidjqxUnclearedChequeReceiptDate" value='<s:property value="hidjqxUnclearedChequeReceiptDate"/>'/>
    </td>
    <td width="10%" class="lbl-right">Ref. No.</td>
    <td width="30%" style="display: flex; gap: 5px; align-items: center;">
        <input type="text" id="txtrefno" name="txtrefno" style="width:150px;" value='<s:property value="txtrefno"/>'/>
        <button class="erp-btn-warning" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button>
    </td>
    <td width="10%" class="lbl-right">Doc No.</td>
    <td width="20%">
        <input type="text" id="docno" name="txtunclearedchequereceiptdocno" style="width:150px; background-color:#f4f5f7;" value='<s:property value="txtunclearedchequereceiptdocno"/>' tabindex="-1" readonly="readonly"/>
    </td>
  </tr>
</table>

<table width="100%">
<tr>
<td width="50%" valign="top">
<fieldset>
<legend>Bank</legend>
<table width="100%" cellpadding="3" cellspacing="0">
  <tr>
    <td width="15%" class="lbl-right">Bank</td>
    <td width="25%">
        <div class="input-search-container">
            <input type="text" id="txtfromaccid" name="txtfromaccid" placeholder="Press F3" value='<s:property value="txtfromaccid"/>' onkeydown="getAcc(event);"/>
            <svg class="magnifier-icon" onclick="openFromAcc();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
        </div>
    </td>
    <td colspan="2">
        <input type="text" id="txtfromaccname" name="txtfromaccname" value='<s:property value="txtfromaccname"/>' style="background-color:#f4f5f7;" tabindex="-1" readonly/>
        <input type="hidden" id="txtfromdocno" name="txtfromdocno" value='<s:property value="txtfromdocno"/>'/>
    </td>
  </tr>
  <tr>
    <td class="lbl-right">Currency</td>
    <td>
        <select id="cmbfromcurrency" name="cmbfromcurrency" value='<s:property value="cmbfromcurrency"/>' onchange="getRate(this.value,$('#jqxUnclearedChequeReceiptDate').val());">
            <option></option>
        </select>
        <input type="hidden" id="hidcmbfromcurrency" name="hidcmbfromcurrency" value='<s:property value="hidcmbfromcurrency"/>'/>
        <input type="hidden" id="hidfromcurrencytype" name="hidfromcurrencytype" value='<s:property value="hidfromcurrencytype"/>'/>
    </td>
    <td width="15%" class="lbl-right">Rate</td>
    <td width="35%">
        <input type="text" id="txtfromrate" name="txtfromrate" onchange="funvalid()" value='<s:property value="txtfromrate"/>' style="text-align: right;" onblur="funRoundRate(this.value,this.id);getBaseAmountFrom();getDrTotal();" tabindex="-1"/>
        <div id="validrate"></div>
    </td>
  </tr>
  <tr>
    <td class="lbl-right">Cheque No</td>
    <td>
        <input type="text" id="txtchequeno" name="txtchequeno" value='<s:property value="txtchequeno"/>' />
    </td>
    <td class="lbl-right">Date</td>
    <td>
        <div id="jqxChequeDate" name="jqxChequeDate" value='<s:property value="jqxChequeDate"/>'></div>
        <input type="hidden" id="hidjqxChequeDate" name="hidjqxChequeDate" value='<s:property value="hidjqxChequeDate"/>'/>
    </td>
  </tr>
  <tr>
    <td class="lbl-right">Cheque Name</td>
    <td colspan="3">
        <input type="text" id="txtchequename" name="txtchequename" value='<s:property value="txtchequename"/>' />
    </td>
  </tr>
  <tr>
    <td class="lbl-right">Amount</td>
    <td>
        <input type="text" id="txtfromamount" name="txtfromamount" value='<s:property value="txtfromamount"/>' style="text-align: right;" onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getDrTotal();" />
    </td>
    <td class="lbl-right">Base Amt</td>
    <td>
        <input type="text" id="txtfrombaseamount" name="txtfrombaseamount" value='<s:property value="txtfrombaseamount"/>' style="text-align: right; background-color:#f4f5f7;" tabindex="-1" readonly="readonly"/>
    </td>
  </tr>
  <tr>
    <td class="lbl-right">Description</td>
    <td colspan="3">
        <input type="text" id="txtdescription" name="txtdescription" value='<s:property value="txtdescription"/>'/>
    </td>
  </tr>
</table>
</fieldset>
</td>

<td width="50%" valign="top">
<fieldset>
<legend>Received From</legend>
<table width="100%" cellpadding="3" cellspacing="0">
  <tr>
    <td width="15%" class="lbl-right">Type</td>
    <td width="25%">
        <select id="cmbtotype" name="cmbtotype" onchange="clearClientInfo();" value='<s:property value="cmbtotype"/>'>
            <option value="AP">AP</option><option value="AR">AR</option>
        </select>
        <input type="hidden" id="hidcmbtotype" name="hidcmbtotype" value='<s:property value="hidcmbtotype"/>'/>
    </td>
    <td colspan="2"></td>
  </tr>
  <tr>
    <td class="lbl-right">Account</td>
    <td>
        <div class="input-search-container">
            <input type="text" id="txttoaccid" name="txttoaccid" placeholder="Press F3" value='<s:property value="txttoaccid"/>' onkeydown="getAccType(event);"/>
            <svg class="magnifier-icon" onclick="openToAcc();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
        </div>
    </td>
    <td colspan="2">
        <input type="text" id="txttoaccname" name="txttoaccname" value='<s:property value="txttoaccname"/>' style="background-color:#f4f5f7;" tabindex="-1" readonly/>
        <input type="hidden" id="txttodocno" name="txttodocno" value='<s:property value="txttodocno"/>'/>
    </td>
  </tr>
  <tr>
    <td class="lbl-right">Currency</td>
    <td>
        <select id="cmbtocurrency" name="cmbtocurrency" value='<s:property value="cmbtocurrency"/>' onchange="getRatevalue(this.value,$('#jqxUnclearedChequeReceiptDate').val());">
            <option></option>
        </select>
        <input type="hidden" id="hidcmbtocurrency" name="hidcmbtocurrency" value='<s:property value="hidcmbtocurrency"/>'/>
        <input type="hidden" id="hidtocurrencytype" name="hidtocurrencytype" value='<s:property value="hidtocurrencytype"/>'/>
    </td>
    <td class="lbl-right" width="15%">Rate</td>
    <td width="35%">
        <input type="text" id="txttorate" name="txttorate" onchange="funvalid1()" value='<s:property value="txttorate"/>' style="text-align: right;" onblur="funRoundRate(this.value,this.id);getBaseAmountTo();getCrTotal();" tabindex="-1"/>
        <div id="validrate1"></div>
    </td>
  </tr>
  <tr>
    <td class="lbl-right">Amount</td>
    <td>
        <input type="text" id="txttoamount" name="txttoamount" value='<s:property value="txttoamount"/>' style="text-align: right;" onblur="funRoundAmt(this.value,this.id);getBaseAmountTo();getCrTotal();" />
    </td>
    <td class="lbl-right">Base Amt</td>
    <td>
        <input type="text" id="txttobaseamount" name="txttobaseamount" value='<s:property value="txttobaseamount"/>' style="text-align: right; background-color:#f4f5f7;" tabindex="-1" readonly="readonly"/>
    </td>
  </tr>
</table>
</fieldset>
</td>
</tr></table>

<div id="jqxUnclearedChequeReceiptGrid"><jsp:include page="unclearedChequeReceiptGrid.jsp"></jsp:include></div>

<table width="100%" cellpadding="3" cellspacing="0" style="margin-top: 10px;">
  <tr>
    <td width="10%" class="lbl-right">Dr. Total</td>
    <td width="20%">
        <input type="text" id="txtdrtotal" name="txtdrtotal" style="text-align: right; background-color:#f4f5f7;" value='<s:property value="txtdrtotal"/>' tabindex="-1" readonly="readonly"/>
    </td>
    <td width="40%"></td>
    <td width="10%" class="lbl-right">Cr. Total</td>
    <td width="20%">
        <input type="text" id="txtcrtotal" name="txtcrtotal" style="text-align: right; background-color:#f4f5f7;" value='<s:property value="txtcrtotal"/>' tabindex="-1" readonly="readonly"/>
    </td>
  </tr>
</table>

<div style="display:none;">
    <input type="hidden" id="mode" name="mode"/>
    <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
    <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
    <input type="hidden" name="txtforsearch" id="txtforsearch" value="0"/>
    <div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
    <input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
    <input type="hidden" id="gridlength" name="gridlength"/>
    <input type="hidden" id="formdetail" name="formdetail" value='<s:property value="formdetail"/>'/>
    <input type="hidden" id="formdetailcode" name="formdetailcode" value='<s:property value="formdetailcode"/>'/>
    <span id="formdet" style="display:none;"></span>
    <i><b><label id="lblformposted" name="lblformposted"></label></b></i>
</div>

</form>

<div id="unclearedChequeReceiptGridWindow"><div></div><div></div></div>  
<div id="accountDetailsFromWindow"><div></div><div></div></div>  
<div id="accountDetailsToWindow"><div></div><div></div></div> 
<div id="costTypeSearchGridWindow"><div></div><div></div></div> 
<div id="costCodeSearchWindow"><div></div><div></div></div> 
<div id="printWindow"><div></div><div></div></div> 

</div>
</body>
</html>