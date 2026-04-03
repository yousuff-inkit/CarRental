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
SCOPED UI: Bulletproof Table Layout (Does NOT affect header.jsp)
========================================================= */

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 10px 20px;
    box-sizing: border-box;
}

.modern-ui .erp-form-area {
    background-color: #f4f7fb;
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    padding: 15px 10px;
    margin-bottom: 10px;
    min-width: 1050px; 
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
.modern-ui input:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

.modern-ui td {
    padding: 4px 5px;
    vertical-align: middle;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Action Buttons */
.modern-ui .erp-btn {
    height: 24px;
    padding: 0 15px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #fff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 11px;
    font-weight: bold;
    box-shadow: 0 1px 2px rgba(59, 130, 246, 0.3);
}

.modern-ui .erp-btn-warning {
    height: 24px;
    padding: 0 15px;
    background: linear-gradient(135deg, #d97706 0%, #f59e0b 100%);
    color: #fff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 11px;
    font-weight: bold;
    box-shadow: 0 1px 2px rgba(245, 158, 11, 0.3);
}

/* Data Grid Container */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    overflow: hidden;
    background: #fff;
    margin-bottom: 10px;
}

form label.error {
    color: red;
    font-weight: bold;
    font-size: 11px;
}

.hidden-scrollbar { 
    overflow: auto; 
    height: calc(100vh - 100px);
}
.hidden-scrollbar::-webkit-scrollbar { width: 0px; }
</style>

<script type="text/javascript">
	$(document).ready(function() {
		
        /* FIXED DATE WIDTHS & HEIGHTS */ 
		 $("#jqxDate").jqxDateTimeInput({ width: '120px', height: '24px', formatString:"dd.MM.yyyy", value: null });
		 $("#jqxFromDate").jqxDateTimeInput({ width: '120px', height: '24px', formatString:"dd.MM.yyyy"});
		 $("#jqxToDate").jqxDateTimeInput({ width: '120px', height: '24px', formatString:"dd.MM.yyyy"});
		 $("#chequedate").jqxDateTimeInput({ width: '120px', height: '24px', formatString:"dd.MM.yyyy"});
		 $("#checkchequedate").jqxDateTimeInput({ width: '120px', height: '24px', formatString:"dd.MM.yyyy"});
		 
		 /* Force internal alignment AFTER render */
         setTimeout(function () {
             $(".jqx-datetimeinput").find("input").css({
                 "margin-top": "0px", 
                 "line-height": "24px", 
                 "font-size": "12px", 
                 "font-family": "Arial, sans-serif",
                 "padding": "0 6px", 
                 "box-sizing":"border-box"
             });
             $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
         }, 0);
		 
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');  
		 
		 var curfromdate= $('#jqxFromDate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#jqxFromDate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
		
		 $('#txtaccid').dblclick(function(){
			  accountSearchContent('clientAccountDetailsSearch.jsp?atype='+$('#cmbacctype').val());
		 });
	});
	
	function accountSearchContent(url){
	    $('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getPDCAccounts(){
 		var x = new XMLHttpRequest();
 		x.onreadystatechange = function() {
 			if (x.readyState == 4 && x.status == 200) {
 				var items = x.responseText;
 				items = items.split('####');
 				var docNoItems = items[0];
 				var accountIdItems  = items[1];
 				var accountItems = items[2];
 				var accountTypeItems = items[3];
 				var accountCurIdItems  = items[4];
 				var accountRateItems = items[5];
 				var accCurrTypeItems = items[6];
 			
 			    $('#txtpdcdocno').val(docNoItems);	
 			    $('#txtpdcaccid').val(accountIdItems);
 			    $('#txtpdcaccname').val(accountItems);
 			 	$('#txtpdcatype').val(accountTypeItems);
			    $('#txtpdccurid').val(accountCurIdItems);
			    $('#txtpdcrate').val(accountRateItems);
			    $('#txtpdctype').val(accCurrTypeItems);
 		}
 		}
 		x.open("GET", "getPDCAccounts.jsp", true);
 		x.send();
    }
	
	function getPDCPostAccount(){
 		var x = new XMLHttpRequest();
 		x.onreadystatechange = function() {
 			if (x.readyState == 4 && x.status == 200) {
 				var items = x.responseText;
 				items = items.split('####');
 				var docNoItems = items[0];
 				var accountIdItems  = items[1];
 				var accountItems = items[2];
 				var accountTypeItems = items[3];
 				var accountCurIdItems  = items[4];
 				var accountRateItems = items[5];
 				var accCurrTypeItems = items[6];
 			
 			    $('#txtpdcpostdocno').val(docNoItems);	
 			    $('#txtpdcpostaccid').val(accountIdItems);
 			    $('#txtpdcpostaccname').val(accountItems);
 			 	$('#txtpdcpostatype').val(accountTypeItems);
			    $('#txtpdcpostcurid').val(accountCurIdItems);
			    $('#txtpdcpostrate').val(accountRateItems);
			    $('#txtpdcposttype').val(accCurrTypeItems);
 		}
 		}
 		x.open("GET", "getPDCPostAccount.jsp", true);
 		x.send();
   }
	
	 function getAcc(event){
         var x= event.keyCode;
         if(x==114){
        	 accountSearchContent('clientAccountDetailsSearch.jsp?atype='+$('#cmbacctype').val());
            }
         }
	 
    /* SAFE READONLY FUNCTION */
	 function funReadOnly(){
	     try {
			$('#frmPDCPostingReceipt input').attr('readonly', true );
			$('#frmPDCPostingReceipt select').attr('disabled', true);
			$('#jqxFromDate').jqxDateTimeInput({disabled: true});
			$('#jqxToDate').jqxDateTimeInput({disabled: true});
			$('#jqxDate').jqxDateTimeInput({disabled: true});
			$('#chequedate').jqxDateTimeInput({disabled: true});
			if($("#jqxJournalVoucher").length) $("#jqxJournalVoucher").jqxGrid({ disabled: true});
			if($("#jqxJournalVoucherApplying").length) $("#jqxJournalVoucherApplying").jqxGrid({ disabled: true});
			$("#btnview").hide();
	     } catch(e) { console.error("Error in funReadOnly: ", e); }
	 }
	 
    /* SAFE REMOVE READONLY FUNCTION */
	 function funRemoveReadOnly(){
	     try {
		    $('#frmPDCPostingReceipt input').attr('readonly', false );
			$('#frmPDCPostingReceipt select').attr('disabled', false);
			$('#jqxFromDate').jqxDateTimeInput({disabled: false});
			$('#jqxToDate').jqxDateTimeInput({disabled: false});
			$('#jqxDate').jqxDateTimeInput({disabled: false});
			$('#chequedate').jqxDateTimeInput({disabled: true});
			$('#txtaccid').attr('readonly', true );
			$('#txtaccname').attr('readonly', true );
			$('#txtbankaccid').attr('readonly', true );
			$('#txtbankaccname').attr('readonly', true );
			$('#txtchequeno').attr('readonly', true );
			if($("#jqxJournalVoucher").length) $("#jqxJournalVoucher").jqxGrid({ disabled: true});
			if($("#jqxJournalVoucherApplying").length) $("#jqxJournalVoucherApplying").jqxGrid({ disabled: true});
			$("#btnview").show();
			
			if ($("#mode").val() == "A") {
			     getPDCAccounts();getPDCPostAccount();
				 $('#jqxFromDate').val(new Date());
				 var curfromdate= $('#jqxFromDate').jqxDateTimeInput('getDate');
			     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
			     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
			     $('#jqxFromDate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
			     $('#jqxToDate').val(new Date());
				 $('#jqxDate').val(null);
			     $('#chequedate').val(new Date());
				 $('#checkchequedate').val(new Date());
			     $('#txtbankaccid').attr('readonly', true );
				 $('#txtbankaccname').attr('readonly', true );
				 $('#txtchequeno').attr('readonly', true );
				 if($("#jqxJournalVoucher").length) {
				     $("#jqxJournalVoucher").jqxGrid('clear'); 
				     $("#jqxJournalVoucher").jqxGrid('addrow', null, {}); 
				 }
			     if($("#jqxJournalVoucherApplying").length) {
			         $("#jqxJournalVoucherApplying").jqxGrid('clear');
				     $("#jqxJournalVoucherApplying").jqxGrid('addrow', null, {}); 
			     }
			} 
	     } catch(e) { console.error("Error in funRemoveReadOnly: ", e); }
	 }
	 
	 function funSearchLoad(){}
		
	 function funChkButton(){ }
	 
	 function funFocus(){
	    	document.getElementById("cmbcriteria").focus(); 	    		
	    }
	 
	 function funNotify(){	
		 
		 /* Validation */
		 
		    if(document.getElementById("cmbcriteria").value=="" || document.getElementById("cmbcriteria").value==null){
			  document.getElementById("errormsg").innerText="Criteria is Mandatory.";
			  return 0;
		    }
		  
		 	if(document.getElementById("jqxDate").value=="" || document.getElementById("jqxDate").value==null){
			  document.getElementById("errormsg").innerText="Posting Date is Mandatory.";
			  return 0;
		 	}
			
			var postdate = $('#jqxDate').jqxDateTimeInput('getDate');
			var postvaliddate=funDateInPeriod(postdate);
			if(parseInt(postvaliddate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
			}
			
			if($('#txtchequevalidation').val()==1){
				 document.getElementById("errormsg").innerText="Past/Current Cheque Date, Transaction Restricted.";
				 return 0;
			}
			
			if($('#cmbcriteria').val()!='4'){
				var applyrows=$("#jqxJournalVoucherApplying").jqxGrid('getrows');
				if(applyrows.length<=1){
					document.getElementById("errormsg").innerText="Invalid Transaction !!!";
					return 0;
			   }
			}else if($('#cmbcriteria').val()=='4'){
				if(document.getElementById("txtchequeno").value=="" || document.getElementById("txtchequeno").value==null){
					document.getElementById("errormsg").innerText="Invalid Transaction !!!";
					return 0;
				 }
			}

			
			if($('#cmbcriteria').val()=='1'){
				var rows1 = $("#jqxJournalVoucherApplying").jqxGrid('getrows');
				if(typeof(rows1[0].doc_no) == "undefined" || typeof(rows1[0].doc_no) == "NaN" || rows1[0].doc_no == ""){
					document.getElementById("errormsg").innerText="Select a Bank Account.";
					return 0;
				}
			}
			
		 /* Validation Ends*/
	    	
		 document.getElementById("errormsg").innerText="";
		 
		 /* Journal Voucher Applying Grid Saving */
    	 var rows = $("#jqxJournalVoucherApplying").jqxGrid('getrows');
    	 var length=0;
 		 for(var i=0 ; i < rows.length ; i++){
 			var chk=rows[i].doc_no;
			if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
				newTextBox = $(document.createElement("input"))
			    .attr("type", "dil")
			    .attr("id", "test"+i)
			    .attr("name", "test"+i)
			    .attr("hidden", "true");
				length=length+1;
				
			var amount,baseamount,id;
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
			
			if($('#txtdtype').val()=='IBR'){
				newTextBox.val(rows[i].doc_no+":: "+rows[i].description+":: "+rows[i].currencyid+":: "+rows[i].rate+":: "+amount+":: "+baseamount+":: "+id+":: 0:: 0:: "+rows[i].sr_no);
			} else{
				newTextBox.val(rows[i].doc_no+":: "+rows[i].description+":: "+rows[i].currencyid+":: "+rows[i].rate+":: "+amount+":: "+baseamount+":: "+rows[i].sr_no+":: "+id+":: 0:: 0");
			}
			newTextBox.appendTo('form');
			}
		   }
 		   $('#gridlength').val(length);
 		/* Journal Voucher Applying Grid Saving Ends */
 		
 		  $('#jqxFromDate').jqxDateTimeInput({disabled: false});
		  $('#jqxToDate').jqxDateTimeInput({disabled: false});
		  $('#jqxDate').jqxDateTimeInput({disabled: false});
		  $('#chequedate').jqxDateTimeInput({disabled: false});
		  $('#cmbcriteria').attr('disabled', false);
		  $('#cmbacctype').attr('disabled', false);
		  
		  return 1;
		} 
	  
	  /* SAFE SET VALUES FUNCTION */
	  function setValues(){
	      try {
    		  if(document.getElementById("cmbcriteria") && document.getElementById("hidcmbcriteria")){
    		      document.getElementById("cmbcriteria").value=document.getElementById("hidcmbcriteria").value;
    		  }
    		  if(document.getElementById("cmbacctype") && document.getElementById("hidcmbacctype")){
    		      document.getElementById("cmbacctype").value=document.getElementById("hidcmbacctype").value;
    		  }
    		  
    		  if($('#hidjqxFromDate').length && $('#hidjqxFromDate').val()){
    				 $("#jqxFromDate").jqxDateTimeInput('val', $('#hidjqxFromDate').val());
    			  }
    		  
    		  if($('#hidjqxToDate').length && $('#hidjqxToDate').val()){
    				 $("#jqxToDate").jqxDateTimeInput('val', $('#hidjqxToDate').val());
    			  }
    		  
    		   if($('#hidjqxDate').length && $('#hidjqxDate').val()){
    				 $("#jqxDate").jqxDateTimeInput('val', $('#hidjqxDate').val());
    			  }
    			  
    		  if($('#hidchequedate').length && $('#hidchequedate').val()){
    				 $("#chequedate").jqxDateTimeInput('val', $('#hidchequedate').val());
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
    		  
    		  if($('#mode').length && $('#mode').val()=="view"){
    			    if($("#jqxJournalVoucher").length) $("#jqxJournalVoucher").jqxGrid({ disabled: true});
    			  	if($("#jqxJournalVoucherApplying").length) {
    			  	    $("#jqxJournalVoucherApplying").jqxGrid({ disabled: true});
    			  	    $("#jqxJournalVoucherApplying").jqxGrid('clear');
    			  	    $("#jqxJournalVoucherApplying").jqxGrid('addrow', null, {});
    			  	}
    		  }
	      } catch(e) { console.error("Error in setValues: ", e); }
		}
	  
	  function checkChequeDate(){
		  var posted=$('#cmbcriteria').val();
	      if(posted==4){
    		  var newchequedate = $('#chequedate').jqxDateTimeInput('getDate');
    		  var oldchequedate = $('#checkchequedate').jqxDateTimeInput('getDate');
    		  if(newchequedate<oldchequedate){
    			  document.getElementById("errormsg").innerText="Past/Current Cheque Date, Transaction Restricted.";
    			  $('#txtchequevalidation').val(1);
    			  return 0;
    		  }
    		  document.getElementById("errormsg").innerText="";
    		  $('#txtchequevalidation').val(0);
    		  return 1;
	      }
	  }
	  
	  function gridloading(){
		  var criteria = document.getElementById("cmbcriteria").value;
		  var accId = document.getElementById("txtdocno").value;  
		  var accType = document.getElementById("cmbacctype").value;
		  var fromDate = document.getElementById("jqxFromDate").value;
		  var toDate = document.getElementById("jqxToDate").value;
		  var check = 1;
		  
		  $("#overlay, #PleaseWait").show();
		  
		  if($("#jqxJournalVoucherGrid").length) {
		      $("#jqxJournalVoucherGrid").load('journalVoucherGrid.jsp?txtcriteria='+criteria+'&accId='+accId+'&accType='+accType+'&fromDate='+fromDate+'&toDate='+toDate+'&check='+check);
		  }
	  }
	  
	  function funloadgrid(){
		  
		    if(document.getElementById("cmbcriteria").value=="" || document.getElementById("cmbcriteria").value==null){
			  document.getElementById("errormsg").innerText="Criteria is Mandatory.";
			  return 0;
		    }
		  
		    if(document.getElementById("jqxDate").value=="" || document.getElementById("jqxDate").value==null){
			  document.getElementById("errormsg").innerText="Posting Date is Mandatory.";
			  return 0;
		    }
			
		    var date = $('#jqxDate').jqxDateTimeInput('getDate');
			var validdate=funDateInPeriod(date);
			if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
			}
		  
		  document.getElementById("errormsg").innerText="";
		  
		  if($("#jqxJournalVoucher").length) $("#jqxJournalVoucher").jqxGrid({ disabled: false});
		  if($("#jqxJournalVoucherApplying").length) {
		      $("#jqxJournalVoucherApplying").jqxGrid('clear');
		      $("#jqxJournalVoucherApplying").jqxGrid('addrow', null, {});
		  }
		  
		  getPDCAccounts();
		  getPDCPostAccount();
		  gridloading();
		  }
	  
	  function dateDisable(){
			 var posted=$('#cmbcriteria').val();
	         if(posted==1){
	        	 $('#jqxFromDate').jqxDateTimeInput({disabled: true}); 
	        	 $("#pdcPostponedDiv").prop("hidden", true);
	        	 $("#jqxJournalVoucherApplyingGrid").prop("hidden", false);
	         }else if(posted==4){
	        	 $('#jqxFromDate').jqxDateTimeInput({disabled: true}); 
	        	 $("#pdcPostponedDiv").prop("hidden", false);
	        	 $("#jqxJournalVoucherApplyingGrid").prop("hidden", true);
	         }else{
	        	 $('#jqxFromDate').jqxDateTimeInput({disabled: false});
	        	 $("#pdcPostponedDiv").prop("hidden", true);
	        	 $("#jqxJournalVoucherApplyingGrid").prop("hidden", false);
	         }
	 }
	  
	  function headerbtndisable(){
		  $('#btnEdit').attr('disabled', true);
		  $('#btnDelete').attr('disabled', true);
		  $('#btnSearch').attr('disabled', true);
	  }
	  
	  function clearClientInfo(){
		  $("#txtdocno").val('');$("#txtaccid").val('');$("#txtaccname").val('');
		  if($("#jqxJournalVoucher").length) $("#jqxJournalVoucher").jqxGrid({ disabled: true});
		  if($("#jqxJournalVoucherApplying").length) {
		      $("#jqxJournalVoucherApplying").jqxGrid({ disabled: true});
		      $("#jqxJournalVoucherApplying").jqxGrid('clear');
		      $("#jqxJournalVoucherApplying").jqxGrid('addrow', null, {});
		  }
		  if($("#jqxJournalVoucher").length) {
		      $("#jqxJournalVoucher").jqxGrid('clear');
		      $("#jqxJournalVoucher").jqxGrid('addrow', null, {});
		  }
	  }
	 
	 function datechange(){
		    var date = $('#jqxDate').jqxDateTimeInput('getDate');
			var validdate=funDateInPeriod(date);
			if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
			}
			
		   if($("#jqxJournalVoucherApplying").length) {
		       $("#jqxJournalVoucherApplying").jqxGrid({ disabled: true});
		       $("#jqxJournalVoucherApplying").jqxGrid('clear');
		       $("#jqxJournalVoucherApplying").jqxGrid('addrow', null, {});
		   }
		   if($("#jqxJournalVoucher").length) {
		       $("#jqxJournalVoucher").jqxGrid({ disabled: true});
		       $("#jqxJournalVoucher").jqxGrid('clear');
		       $("#jqxJournalVoucher").jqxGrid('addrow', null, {});
		   }
	  }
	  
</script>
</head>

<body onload="setValues();headerbtndisable();">

<div id="mainBG" class="homeContent hidden-scrollbar" data-type="background" >
<form id="frmPDCPostingReceipt" action="savePDCPostingReceipt" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class="modern-ui">

    <div class="erp-form-area">
        
        <table width="100%" border="0" cellspacing="0" cellpadding="2" style="margin-bottom: 8px;">
            <tr>
                <td class="lbl-right" width="8%">Criteria</td>
                <td width="25%">
                    <select id="cmbcriteria" name="cmbcriteria" value='<s:property value="cmbcriteria"/>' onchange="dateDisable();getPDCAccounts();getPDCPostAccount();clearClientInfo();">
                        <option value="">--Select--</option>
                        <option value="1">PDC to be Posted</option>
                        <option value="2">PDC to be Returned</option>
                        <option value="3">Posted PDC to be Dishonoured</option>
                        <option value="4">PDC to be Postponed</option>
                        <option value="5">Retuned PDC to be Reversed</option>
                        <option value="6">Dishourned PDC to be Reversed</option>
                        <option value="7">CDC to be Dishourned</option>
                    </select>
                    <input type="hidden" id="hidcmbcriteria" name="hidcmbcriteria" value='<s:property value="hidcmbcriteria"/>'/>
                </td>
                <td class="lbl-right" width="8%">From</td>
                <td width="15%">
                    <div id="jqxFromDate" name="jqxFromDate" value='<s:property value="jqxFromDate"/>'></div>
                    <input type="hidden" id="hidjqxFromDate" name="hidjqxFromDate" value='<s:property value="hidjqxFromDate"/>'/>
                </td>
                <td class="lbl-right" width="8%">To</td>
                <td width="36%">
                    <div id="jqxToDate" name="jqxToDate" value='<s:property value="jqxToDate"/>'></div>
                    <input type="hidden" id="hidjqxToDate" name="hidjqxToDate" value='<s:property value="hidjqxToDate"/>'/>
                </td>
            </tr>
        </table>
        
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
            <tr>
                <td class="lbl-right" width="8%">Account</td>
                <td width="15%">
                    <select id="cmbacctype" name="cmbacctype" onchange="clearClientInfo();" value='<s:property value="cmbacctype"/>'>
                        <option value="0">--Select--</option>
                        <option value="BANK">Bank</option>
                        <option value="AP">AP</option>
                        <option value="AR">AR</option>
                    </select>
                    <input type="hidden" id="hidcmbacctype" name="hidcmbacctype" value='<s:property value="hidcmbacctype"/>'/>
                </td>
                <td width="10%">
                    <input type="text" id="txtaccid" name="txtaccid" placeholder="Press F3" value='<s:property value="txtaccid"/>' onkeydown="getAcc(event);"/>
                </td>
                <td width="30%">
                    <input type="text" id="txtaccname" name="txtaccname" value='<s:property value="txtaccname"/>' tabindex="-1"/>
                    <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
                </td>
                <td class="lbl-right" width="8%">Posting</td>
                <td width="15%">
                    <div id="jqxDate" name="jqxDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxDate"/>'></div>
                    <input type="hidden" id="hidjqxDate" name="hidjqxDate" value='<s:property value="hidjqxDate"/>'/>
                </td>
                <td width="14%" align="right">
                    <button class="erp-btn" type="button" id="btnview" name="btnview" onclick="funloadgrid();">View</button>
                </td>
            </tr>
        </table>

    </div>

    <div class="grid-container" id="jqxJournalVoucherGrid">
        <jsp:include page="journalVoucherGrid.jsp"></jsp:include>
    </div>
    
    <div class="grid-container" id="jqxJournalVoucherApplyingGrid">
        <jsp:include page="journalVoucherApplyingGrid.jsp"></jsp:include>
    </div>

    <div id="pdcPostponedDiv" hidden="true">
        <div class="erp-form-area" style="background-color: #ECF8E0; border-color: #c3e6cb;">
            <table width="100%" border="0" cellspacing="0" cellpadding="2">
                <tr>
                    <td class="lbl-right" width="8%">Bank</td>
                    <td width="20%">
                        <input type="text" id="txtbankaccid" name="txtbankaccid" value='<s:property value="txtbankaccid"/>'/>
                    </td>
                    <td colspan="2">
                        <input type="text" id="txtbankaccname" name="txtbankaccname" value='<s:property value="txtbankaccname"/>' style="max-width: 400px;"/>
                        <input type="hidden" id="txtbankdocno" name="txtbankdocno" value='<s:property value="txtbankdocno"/>'/>
                    </td>
                </tr>
                <tr>
                    <td class="lbl-right" style="padding-top: 8px;">Cheque No.</td>
                    <td style="padding-top: 8px;">
                        <input type="text" id="txtchequeno" name="txtchequeno" value='<s:property value="txtchequeno"/>'/>
                    </td>
                    <td class="lbl-right" width="10%" style="padding-top: 8px;">Cheque Date</td>
                    <td style="padding-top: 8px;">
                        <div id="chequedate" name="chequedate" onchange="checkChequeDate();" value='<s:property value="chequedate"/>'></div>
                        <input type="hidden" id="hidchequedate" name="hidchequedate" value='<s:property value="hidchequedate"/>'/>
                        <div hidden="true" id="checkchequedate" name="checkchequedate" value='<s:property value="checkchequedate"/>'></div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
 
    <div style="display:none;">
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
        <input type="hidden" id="txtpdcdocno" name="txtpdcdocno"  value='<s:property value="txtpdcdocno"/>'/>
        <input type="hidden" id="txtpdcaccid" name="txtpdcaccid"  value='<s:property value="txtpdcaccid"/>'/>
        <input type="hidden" id="txtpdcaccname" name="txtpdcaccname"  value='<s:property value="txtpdcaccname"/>'/>
        <input type="hidden" id="txtpdcatype" name="txtpdcatype"  value='<s:property value="txtpdcatype"/>'/>
        <input type="hidden" id="txtpdccurid" name="txtpdccurid"  value='<s:property value="txtpdccurid"/>'/>
        <input type="hidden" id="txtpdcrate" name="txtpdcrate"  value='<s:property value="txtpdcrate"/>'/>
        <input type="hidden" id="txtpdctype" name="txtpdctype"  value='<s:property value="txtpdctype"/>'/>
        <input type="hidden" id="txtpdcpostdocno" name="txtpdcpostdocno"  value='<s:property value="txtpdcpostdocno"/>'/>
        <input type="hidden" id="txtpdcpostaccid" name="txtpdcpostaccid"  value='<s:property value="txtpdcpostaccid"/>'/>
        <input type="hidden" id="txtpdcpostaccname" name="txtpdcpostaccname"  value='<s:property value="txtpdcpostaccname"/>'/>
        <input type="hidden" id="txtpdcpostatype" name="txtpdcpostatype"  value='<s:property value="txtpdcpostatype"/>'/>
        <input type="hidden" id="txtpdcpostcurid" name="txtpdcpostcurid"  value='<s:property value="txtpdcpostcurid"/>'/>
        <input type="hidden" id="txtpdcpostrate" name="txtpdcpostrate"  value='<s:property value="txtpdcpostrate"/>'/>
        <input type="hidden" id="txtpdcposttype" name="txtpdcposttype"  value='<s:property value="txtpdcposttype"/>'/>
        <input type="hidden" id="txtchqno" name="txtchqno" value='<s:property value="txtchqno"/>'/>
        <input type="hidden" id="txtgriddocno" name="txtgriddocno" value='<s:property value="txtgriddocno"/>'/>
        <input type="hidden" id="txtrowno" name="txtrowno" value='<s:property value="txtrowno"/>'/>
        <input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
        <input type="hidden" id="txtposttrno" name="txtposttrno"  value='<s:property value="txtposttrno"/>'/>
        <input type="hidden" id="txtdtype" name="txtdtype" value='<s:property value="txtdtype"/>'/>
        <input type="hidden" id="txtchequevalidation" name="txtchequevalidation"  value='<s:property value="txtchequevalidation"/>'/>
        <input type="hidden" id="gridlength" name="gridlength"/>
        
        <input type="hidden" id="formdetail" name="formdetail" value='<s:property value="formdetail"/>'/>
        <input type="hidden" id="formdetailcode" name="formdetailcode" value='<s:property value="formdetailcode"/>'/>
    </div>

</div>
</form>
            
<div id="accountDetailsWindow"><div></div><div></div></div>  
    
</div>
</body>
</html>