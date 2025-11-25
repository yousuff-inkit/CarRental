<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>PDC Posting - Payments (FRO)</title>  
<jsp:include page="../../../../includes.jsp"></jsp:include>

<script type="text/javascript">
	$(document).ready(function() {      

		 // Match Receipts sizing & look
		 $("#jqxDate").jqxDateTimeInput({ width: '125px', height: 36, formatString:"dd.MM.yyyy", value: null });
		 $("#jqxFromDate").jqxDateTimeInput({ width: '125px', height: 36, formatString:"dd.MM.yyyy"});
		 $("#jqxToDate").jqxDateTimeInput({ width: '125px', height: 36, formatString:"dd.MM.yyyy"});
		 $("#chequedate").jqxDateTimeInput({ width: '125px', height: 36, formatString:"dd.MM.yyyy"});
		 $("#checkchequedate").jqxDateTimeInput({ width: '125px', height: 36, formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsWindow').jqxWindow({
			 width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%',
			 title: 'Accounts Search', position: { x: 300, y: 87 },
			 theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27
		 });
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
	
	 function getAcc(event){
         var x= event.keyCode;
         if(x==114){
        	 accountSearchContent('clientAccountDetailsSearch.jsp?atype='+$('#cmbacctype').val());
            }
         }
	 
	 function funReadOnly(){
			$('#frmPDCPostingPayment input').attr('readonly', true );
			$('#frmPDCPostingPayment select').attr('disabled', true);
			$('#jqxFromDate').jqxDateTimeInput({disabled: true});
			$('#jqxToDate').jqxDateTimeInput({disabled: true});
			$('#jqxDate').jqxDateTimeInput({disabled: true});
			$('#chequedate').jqxDateTimeInput({disabled: true});
			$("#jqxJournalVoucher").jqxGrid({ disabled: true});
			$("#jqxJournalVoucherApplying").jqxGrid({ disabled: true});
			$("#btnview").hide();
	 }
	 
	 function funRemoveReadOnly(){
		    $('#frmPDCPostingPayment input').attr('readonly', false );
			$('#frmPDCPostingPayment select').attr('disabled', false);
			$('#jqxFromDate').jqxDateTimeInput({disabled: false});
			$('#jqxToDate').jqxDateTimeInput({disabled: false});
			$('#jqxDate').jqxDateTimeInput({disabled: false});
			$('#chequedate').jqxDateTimeInput({disabled: true});
			$('#txtaccid').attr('readonly', true );
			$('#txtaccname').attr('readonly', true );
			$('#txtbankaccid').attr('readonly', true );
			$('#txtbankaccname').attr('readonly', true );     
			$('#txtchequeno').attr('readonly', true );
			$("#jqxJournalVoucher").jqxGrid({ disabled: true});
			$("#jqxJournalVoucherApplying").jqxGrid({ disabled: true});
			$("#btnview").show();
			
			if ($("#mode").val() == "A") {
			     getPDCAccounts();
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
				 $("#jqxJournalVoucher").jqxGrid('clear'); 
				 $("#jqxJournalVoucher").jqxGrid('addrow', null, {}); 
			     $("#jqxJournalVoucherApplying").jqxGrid('clear');
				 $("#jqxJournalVoucherApplying").jqxGrid('addrow', null, {}); 
			} 
			
	 }
	 
	 function funSearchLoad(){}
		
	 function funChkButton(){}
	 
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
			
	     document.getElementById("errormsg").innerText="";
		 /* Validation Ends*/
			
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
			
			if($('#txtdtype').val()=='IBP'){
				newTextBox.val(rows[i].doc_no+":: "+rows[i].description+":: "+rows[i].currencyid+":: "+rows[i].rate+":: "+amount+":: "+baseamount+":: "+id+":: 0:: 0:: "+rows[i].sr_no);
			} else if(($('#txtdtype').val()=='COT' && $('#txtibbranch').val()=='1')){
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
	  
	  
	  function setValues(){
		  
		  document.getElementById("cmbcriteria").value=document.getElementById("hidcmbcriteria").value;
		  document.getElementById("cmbacctype").value=document.getElementById("hidcmbacctype").value;
		  
		  if($('#hidjqxFromDate').val()){
				 $("#jqxFromDate").jqxDateTimeInput('val', $('#hidjqxFromDate').val());
			  }
		  
		  if($('#hidjqxToDate').val()){
				 $("#jqxToDate").jqxDateTimeInput('val', $('#hidjqxToDate').val());
			  }
		  
		  if($('#hidjqxDate').val()){
				 $("#jqxDate").jqxDateTimeInput('val', $('#hidjqxDate').val());
			  }
			  
		  if($('#hidchequedate').val()){
				 $("#chequedate").jqxDateTimeInput('val', $('#hidchequedate').val());
			  }
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
		  
		  $('#cmbcriteria').attr('disabled', false);$('#cmbacctype').attr('disabled', false);
		  
		  
		  if($('#mode').val()=="view"){
			    $("#jqxJournalVoucher").jqxGrid({ disabled: true});
			  	$("#jqxJournalVoucherApplying").jqxGrid({ disabled: true});
			  	$("#jqxJournalVoucherApplying").jqxGrid('clear');
			  	$("#jqxJournalVoucherApplying").jqxGrid('addrow', null, {});
			  }
		  $('#cmbcriteria').attr('disabled', true);$('#cmbacctype').attr('disabled', true);
		  
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
		  
		  $("#jqxJournalVoucherGrid").load('journalVoucherGrid.jsp?txtcriteria='+criteria+'&accId='+accId+'&accType='+accType+'&fromDate='+fromDate+'&toDate='+toDate+'&check='+check);
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
		  
		  $("#jqxJournalVoucher").jqxGrid({ disabled: false});
		  $("#jqxJournalVoucherApplying").jqxGrid('clear');
		  $("#jqxJournalVoucherApplying").jqxGrid('addrow', null, {});
		  
		  getPDCAccounts();
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
		  if (document.getElementById("txtaccid").value == "") {
		        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
		  }
		  $("#jqxJournalVoucher").jqxGrid({ disabled: true});
		  $("#jqxJournalVoucherApplying").jqxGrid({ disabled: true});
		  $("#jqxJournalVoucherApplying").jqxGrid('clear');
		  $("#jqxJournalVoucherApplying").jqxGrid('addrow', null, {});
		  $("#jqxJournalVoucher").jqxGrid('clear');
		  $("#jqxJournalVoucher").jqxGrid('addrow', null, {});
	  }
	  
	   function datechange(){
		    var date = $('#jqxDate').jqxDateTimeInput('getDate');
			var validdate=funDateInPeriod(date);
			if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
			}
			
		   $("#jqxJournalVoucherApplying").jqxGrid({ disabled: true});
		   $("#jqxJournalVoucherApplying").jqxGrid('clear');
		   $("#jqxJournalVoucherApplying").jqxGrid('addrow', null, {});
		   $("#jqxJournalVoucher").jqxGrid({ disabled: true});
		   $("#jqxJournalVoucher").jqxGrid('clear');
		   $("#jqxJournalVoucher").jqxGrid('addrow', null, {});
	  }
	  
</script>

<style>
/* ----------------------------
   PDC Receipts theme (copied/applied to Payments)
   ---------------------------- */

/* Scrollbar for page / grids */
.hidden-scrollbar {
  overflow-y: auto;
  height: 530px;
  scrollbar-width: thin;
  scrollbar-color: #4da3ff #eaf3ff;
}
.hidden-scrollbar::-webkit-scrollbar {
  width: 8px;
}
.hidden-scrollbar::-webkit-scrollbar-thumb {
  background-color: #8aa8d6;
  border-radius: 6px;
}
.hidden-scrollbar::-webkit-scrollbar-thumb:hover {
  background-color: #6f8ec4;
}

/* Page background */
body {
  background: linear-gradient(135deg, #e8f1ff 0%, #d1e4ff 100%);
  font-family: "Poppins", "Segoe UI", sans-serif;
  color: #1f2f46;
  margin: 0;
  padding: 40px 0;
  min-height: 100vh;
  -webkit-font-smoothing:antialiased;
}

/* Main container */
#mainBG {
  background: #f4f8ff;
  border-radius: 16px;
  box-shadow: 0 4px 25px rgba(50, 110, 255, 0.12);
  padding: 22px 26px;
  max-width: 1250px;
  margin: 0 auto;
}

/* Receipt header block (same as Receipts) */
.receipt-header {
  background: #edf4ff;
  border: 1px solid #c9dafc;
  border-radius: 12px;
  padding: 14px 18px;
  margin-bottom: 18px;
  box-shadow: 0 2px 12px rgba(132, 168, 255, 0.08);
  display: block;
}
.receipt-header .cr-row { display:flex; gap:12px; align-items:center; flex-wrap:wrap; }
.receipt-header label { font-weight:600; color:#274b8f; margin-right:6px; }
.receipt-header select, .receipt-header input[type="text"] {
  height:36px;
  padding:6px 10px;
  border-radius:8px;
  border:1px solid #d7e6ff;
  background:#fff;
  font-size:0.95rem;
}
.receipt-header .btn-primary {
  background: linear-gradient(90deg, #6fb1fc, #1a73e8);
  color:#fff;
  padding:8px 18px;
  border-radius:10px;
  border:none;
  cursor:pointer;
  box-shadow: 0 3px 10px rgba(26,115,232,0.18);
}

/* Table / grids */
.cr-table {
  width:100%;
  border-collapse:collapse;
  background:#fff;
  border-radius:10px;
  overflow:hidden;
  box-shadow: 0 0 0 1px #eef4ff;
}
.cr-table th,
.cr-table td {
  padding:10px 12px;
  border-bottom:1px solid #e6eefc;
  font-size:0.95rem;
  color:#2b3b5a;
}
.cr-table th {
  background: #f1f6ff;
  font-weight:700;
  color:#16325a;
}
.cr-table tr:hover td {
  background:#f7fbff;
}

/* Date inputs and dropdowns sizing + pink autofill removal */
#jqxFromDate, #jqxToDate, #jqxDate, #chequedate, #checkchequedate {
    height: 38px !important;
    display: flex !important;
    align-items: center !important;
}
#jqxFromDate input, #jqxToDate input, #jqxDate input, #chequedate input, #checkchequedate input {
    height: 36px !important;
    padding-left: 10px !important;
    border-radius: 8px !important;
    box-sizing: border-box !important;
}

/* Standardize Criteria + Account dropdowns (fix font-size and remove tint) */
#cmbcriteria, #cmbacctype {
    height: 38px !important;
    font-size: 15px !important;
    padding: 6px 12px !important;
    border-radius: 8px !important;
    background-color: #ffffff !important;
    border: 1px solid #d1d5db !important;
    color: #1f2f46 !important;
    box-sizing: border-box !important;
}

/* Bigger option text */
#cmbcriteria option, #cmbacctype option {
    font-size: 15px !important;
    color: #222 !important;
}

/* Remove pink autofill for inputs */
input:-webkit-autofill, input:-webkit-autofill:hover, input:-webkit-autofill:focus {
    -webkit-box-shadow: 0 0 0 1000px #ffffff inset !important;
    background-color: #ffffff !important;
    color: #1f2f46 !important;
    -webkit-text-fill-color: #1f2f46 !important;
}

/* jqxGrid modern styles (match Receipts) */
.jqx-grid {
    border: 1px solid #cddbf5 !important;
    border-radius: 10px !important;
    overflow: hidden !important;
}
.jqx-grid-cell {
    background: #ffffff !important;
    border-color: #dce6f9 !important;
    color: #2a2a2a !important;
    height: 40px !important;
    font-size: 14px !important;
}
.jqx-grid-column-header, .jqx-grid-header {
    background: #eaf2ff !important;
    border-bottom: 1px solid #c7d6f5 !important;
    color: #1e2d4a !important;
    font-weight: 600 !important;
    height: 42px !important;
    font-size: 14px !important;
}
.jqx-grid-cell-hover { background: #f5f9ff !important; }
.jqx-grid-cell-selected { background: #dceaff !important; }

.jqx-grid-cell input {
    background: #ffffff !important;
    border: 1px solid #c9d9f8 !important;
    height: 28px !important;
    font-size: 14px !important;
    border-radius: 6px !important;
    padding: 4px 8px !important;
}

/* small helpers */
#errormsg { color:#d62828; font-weight:700; margin-top:8px; display:block; }

/* responsive */
@media (max-width: 900px){
  #mainBG { padding:12px; }
  .receipt-header { padding:12px; }
  .receipt-header .cr-row { flex-direction:column; align-items:flex-start; }
}
/* FIX PINK AUTOFILL ON ALL jqxDateTimeInput FIELDS */
.jqx-datetimeinput input::-webkit-contacts-auto-fill-button,
.jqx-datetimeinput input:-webkit-autofill,
.jqx-datetimeinput input:-webkit-autofill:hover,
.jqx-datetimeinput input:-webkit-autofill:focus {
    -webkit-box-shadow: 0 0 0 1000px #ffffff inset !important;
    background-color: #ffffff !important;
    -webkit-text-fill-color: #1f2f46 !important;
    color: #1f2f46 !important;
    caret-color: #1f2f46 !important;
}

/* General input autofill override (backup) */
input:-webkit-autofill,
input:-webkit-autofill:hover,
input:-webkit-autofill:focus {
    -webkit-box-shadow: 0 0 0 1000px #ffffff inset !important;
    background-color: #ffffff !important;
    -webkit-text-fill-color: #1f2f46 !important;
}
/* FULL OVERRIDE TO REMOVE PINK FROM jqxDateTimeInput */

/* 1) jqx outer container */
.jqx-datetimeinput,
.jqx-datetimeinput .jqx-widget-content,
.jqx-datetimeinput .jqx-input,
.jqx-datetimeinput .jqx-fill-state-focus,
.jqx-datetimeinput .jqx-fill-state-normal,
.jqx-datetimeinput .jqx-fill-state-hover {
    background-color: #ffffff !important;
    border-color: #d1d5db !important;
}

/* 2) The REAL inner input field (jqx creates this) */
.jqx-datetimeinput-input {
    background: #ffffff !important;
    color: #1f2f46 !important;
    -webkit-text-fill-color: #1f2f46 !important;
    box-shadow: none !important;
}

/* 3) Chrome autofill fallback */
.jqx-datetimeinput input:-webkit-autofill,
.jqx-datetimeinput input:-webkit-autofill:hover,
.jqx-datetimeinput input:-webkit-autofill:focus {
    -webkit-box-shadow: 0 0 0 1000px #ffffff inset !important;
    background-color: #ffffff !important;
    -webkit-text-fill-color: #1f2f46 !important;
}

/* 4) Remove pink from jqx popup calendar */
.jqx-calendar,
.jqx-calendar-title-container,
.jqx-calendar-month-container,
.jqx-calendar-cell,
.jqx-calendar-row,
.jqx-popup {
    background: #ffffff !important;
    color: #1f2f46 !important;
}

/* 5) Remove pink from jqx dropdown icon area */
.jqx-datetimeinput-button,
.jqx-datetimeinput-button:hover,
.jqx-datetimeinput-button:focus {
    background: #ffffff !important;
    border-left: 1px solid #d1d5db !important;
}
</style>

</head>
<body onload="setValues();headerbtndisable();">
<div id="mainBG" class="homeContent hidden-scrollbar" data-type="background" >
<form id="frmPDCPostingPayment" action="savePDCPostingPayment" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<!-- ====== Top criteria (matched to Receipts) ====== -->
<div class="receipt-header">
  <div class="cr-row">

    <label for="cmbcriteria">Criteria</label>
    <select id="cmbcriteria" name="cmbcriteria" style="min-width:220px;" value='<s:property value="cmbcriteria"/>' onchange="dateDisable();getPDCAccounts();clearClientInfo();">
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

    <label for="jqxFromDate">From</label>
    <div id="jqxFromDate" style="width:125px;"></div>
    <input type="hidden" id="hidjqxFromDate" name="hidjqxFromDate" value='<s:property value="hidjqxFromDate"/>'/>

    <label for="jqxToDate">To</label>
    <div id="jqxToDate" style="width:125px;"></div>
    <input type="hidden" id="hidjqxToDate" name="hidjqxToDate" value='<s:property value="hidjqxToDate"/>'/>

    <label for="cmbacctype">Account</label>
    <select id="cmbacctype" name="cmbacctype" style="min-width:140px;" onchange="clearClientInfo();" value='<s:property value="cmbacctype"/>'>
      <option value="0">--Select--</option>
      <option value="BANK">Bank</option>
      <option value="AP">AP</option>
      <option value="AR">AR</option>
    </select>
    <input type="hidden" id="hidcmbacctype" name="hidcmbacctype" value='<s:property value="hidcmbacctype"/>'/>

    <input type="text" id="txtaccid" name="txtaccid" placeholder="Press F3 to Search" style="min-width:180px;" value='<s:property value="txtaccid"/>' onkeydown="getAcc(event);"/>

    <input type="text" id="txtaccname" name="txtaccname" style="min-width:320px;" value='<s:property value="txtaccname"/>'/>
    <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>

    <label for="jqxDate">Posting</label>
    <div id="jqxDate" style="width:125px;" onchange="datechange();" onblur="datechange();"></div>
    <input type="hidden" id="hidjqxDate" name="hidjqxDate" value='<s:property value="hidjqxDate"/>'/>

    <button type="button" id="btnview" class="btn-primary" onclick="funloadgrid();">View</button>

  </div>

  <span id="errormsg"></span>
</div>

<!-- ====== Journal Voucher Grid (loads via jsp include) ====== -->
<div class="cr-table hidden-scrollbar" id="jqxJournalVoucherGrid" style="margin-bottom:16px; padding:0;">
  <jsp:include page="journalVoucherGrid.jsp"></jsp:include>
</div>

<!-- ====== Journal Voucher Applying Grid (loads via jsp include) ====== -->
<div class="cr-table hidden-scrollbar" id="jqxJournalVoucherApplyingGrid" style="margin-bottom:16px; padding:0;">
  <jsp:include page="journalVoucherApplyingGrid.jsp"></jsp:include>
</div>

<!-- ====== Postponed PDC area (hidden toggled) ====== -->
<div id="pdcPostponedDiv" hidden="true" style="margin-top:12px;">
 <fieldset style="border-radius:8px; padding:12px; border:1px solid #e6f2d6; background:#f6fff0;">
 <table class="cr-table" width="100%">
  <tr>
    <td width="7%" align="right">Bank</td>
    <td width="14%"><input type="text" id="txtbankaccid" name="txtbankaccid" style="width:80%;" value='<s:property value="txtbankaccid"/>'/></td>
    <td colspan="2"><input type="text" id="txtbankaccname" name="txtbankaccname" style="width:40%;" value='<s:property value="txtbankaccname"/>'/>
    <input type="hidden" id="txtbankdocno" name="txtbankdocno" value='<s:property value="txtbankdocno"/>'/></td>
  </tr>
  <tr>
    <td align="right">Cheque No.</td>
    <td><input type="text" id="txtchequeno" name="txtchequeno" style="width:80%;" value='<s:property value="txtchequeno"/>'/></td>
    <td width="8%" align="right">Cheque Date</td>
    <td width="71%"><div id="chequedate" style="width:125px;"></div>
	<input type="hidden" id="hidchequedate" name="hidchequedate" value='<s:property value="hidchequedate"/>'/>
	<div hidden="true" id="checkchequedate" name="checkchequedate" value='<s:property value="checkchequedate"/>'></div></td>
  </tr>
</table>
</fieldset>
 </div>

<!-- hidden & meta -->
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
<input type="hidden" id="txtchqno" name="txtchqno" value='<s:property value="txtchqno"/>'/>
<input type="hidden" id="txtgriddocno" name="txtgriddocno" value='<s:property value="txtgriddocno"/>'/>
<input type="hidden" id="txtrowno" name="txtrowno" value='<s:property value="txtrowno"/>'/>
<input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
<input type="hidden" id="txtposttrno" name="txtposttrno"  value='<s:property value="txtposttrno"/>'/>
<input type="hidden" id="txtdtype" name="txtdtype" value='<s:property value="txtdtype"/>'/>
<input type="hidden" id="txtibbranch" name="txtibbranch" value='<s:property value="txtibbranch"/>'/>
<input type="hidden" id="typevalue" name="typevalue"  value='<s:property value="typevalue"/>'/>
<input type="hidden" id="txtchequevalidation" name="txtchequevalidation"  value='<s:property value="txtchequevalidation"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>

</form>

<!-- windows -->
<div id="accountDetailsWindow"><div></div><div></div></div>

</div> <!-- #mainBG -->
</body>
</html>
