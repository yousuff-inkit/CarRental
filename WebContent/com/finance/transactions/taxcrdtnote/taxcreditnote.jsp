<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i) - Tax Credit Note</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<script type="text/javascript">
	$(document).ready(function() {
		/* JQX Date: make it full width and same height as inputs */
		$("#jqxCreditNoteDate").jqxDateTimeInput({
		    width: '100%',
		    height: 36,
		    formatString: "dd.MM.yyyy"
		});
		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $('#txtforsearch').val(2);
		
		 $('#accountDetailsToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsToWindow').jqxWindow('close');  
		 
		 $('#creditNoteGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#creditNoteGridWindow').jqxWindow('close'); 
		 
		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#costTypeSearchGridWindow').jqxWindow('close');
 		 
 		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
		 
		 $('#jqxCreditNoteDate').on('change', function (event) {
				var creditdate = $('#jqxCreditNoteDate').jqxDateTimeInput('getDate');
				var validdate=funDateInPeriod(creditdate);
				if(parseInt(validdate)==0){
					document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
					return 0;	
				} 
			 });
			 
		$('#txtaccid').dblclick(function(){
			  var date = $('#jqxCreditNoteDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtype').val()+"&date="+date);
			  $('#txtforsearch').val(2);
	    });  	 
		
	});
	
	function CreditSearchContent(url) {
		$('#creditNoteGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#creditNoteGridWindow').jqxWindow('setContent', data);
		$('#creditNoteGridWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function accountSearchContent(url) {
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
				 $('#txtaccid').attr('readonly', true);$('#txtaccname').attr('readonly', true);$('#txtamount').attr('readonly', false);$('#txtdescription').attr('readonly', false);
				 $('#txtrate').attr('readonly', false);$('#txtbaseamount').attr('readonly', true);$('#txtdrtotal').attr('readonly', true);$('#txtcrtotal').attr('readonly', true);
				 $('#frmTaxCreditNote select').attr('disabled', false);$("#jqxCreditNote").jqxGrid({ disabled: false});$('#frmTaxCreditNote select').attr('disabled', false);  
		         $('#cmbcurrency').attr('disabled',true);
					}
		   });
	  }
	  
	 function funReadOnly(){
			$('#frmTaxCreditNote input').attr('readonly', true );
			$('#frmTaxCreditNote select').attr('disabled', true);
			$('#jqxCreditNoteDate').jqxDateTimeInput({disabled: true});
			$("#jqxCreditNote").jqxGrid({ disabled: true});
			$("#btnvaluechange").hide();
	 }
	 function funRemoveReadOnly(){
		    $('#txtforsearch').val(2);
			$('#frmTaxCreditNote input').attr('readonly', false );
			$('#frmTaxCreditNote select').attr('disabled', false);
			$('#cmbcurrency').attr('disabled', true);
			
			$('#txtaccid').attr('readonly', true );
			$('#txtaccname').attr('readonly', true );
			$('#txtnettotal').attr('readonly', true );
		    $('#txtbaseamount').attr('readonly', true);
			$('#jqxCreditNoteDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$("#jqxCreditNote").jqxGrid({ disabled: false}); 
			
			var date = $('#jqxCreditNoteDate').val();
		    getCurrencyId(date);
		    
		   if ($("#mode").val() == "E") {
      	    $("#btnvaluechange").show();
      	    $('#frmTaxCreditNote input').attr('readonly', true );
			    $('#frmTaxCreditNote select').attr('disabled', true);
			    $("#jqxCreditNote").jqxGrid({ disabled: true});
			    $("#jqxCreditNote").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","dr": true,"amount1": "","description": ""});
			    $('#txtdescription').attr('readonly', false );
			    $('#txtrefno').attr('readonly', false );
			  }
			 else{
				$("#btnvaluechange").hide();
			} 
			
			if ($("#mode").val() == "A") {
				$('#jqxCreditNoteDate').val(new Date());
				$("#jqxCreditNote").jqxGrid('clear'); 
				$("#jqxCreditNote").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","dr": true,"amount1": "","description": ""});
			} 
	       }
	 
	function funSearchLoad(){
		changeContent('cnoMainSearch.jsp'); 
	 }
			
	function funChkButton(){
		/* funReset(); */
	}
			 
	function funFocus(){
	    $('#jqxCreditNoteDate').jqxDateTimeInput('focus'); 	    			
	}
			 
	$(function(){
	    $('#frmTaxCreditNote').validate({
	            rules: {
	            txtaccid:"required",
	            txtamount:{"required":true,number:true},
	            txtdescription:{maxlength:500}
	             },
	             messages: {
	             txtaccid:" *",
	             txtamount:{required:" *",number:"Invalid"},
	             txtdescription: {maxlength:"    Max 500 chars"}
	             }
	    });
	});
			   
	/* --- Validation + Save handling (keeps same logic as before) --- */
	function funNotify(){	
	    /* Validation */
	    var creditdate = $('#jqxCreditNoteDate').jqxDateTimeInput('getDate');
	    var taxacc=document.getElementById("taxaccount").value;
		var validdate=funDateInPeriod(creditdate);
		if(parseInt(validdate)==0){
			document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
			return 0;	
		} 
		
		acctype=document.getElementById("cmbtype").value;
		if(acctype==""){
			document.getElementById("errormsg").innerText="Account Type is Mandatory.";
			return 0;
		}
		 
		accid=document.getElementById("txtdocno").value;
		if(accid==""){
			document.getElementById("errormsg").innerText="Account is Mandatory.";
			return 0;
		}
		 
		currencyto=document.getElementById("cmbcurrency").value;
		currencyrate=document.getElementById("txtrate").value;
		if(currencyto=="" || currencyrate==""){
			document.getElementById("errormsg").innerText="Currency & Rate is Mandatory.";
			return 0;
		}
		 
	    var drtot = parseFloat(document.getElementById("txtdrtotal").value);
 		var crtot = parseFloat(document.getElementById("txtcrtotal").value);
 		
 		if(drtot>crtot || drtot<crtot){
 			document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should be Equal.";
          return 0;
 		}
 		
 		if(drtot=="" || crtot=="" ){
 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should be Equal.";
              return 0;
	 		}

 		if(isNaN(drtot) || isNaN(crtot)){
 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should be Equal.";
              return 0;
	 		}
 		
 		if(drtot==0 || crtot==0){
 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should not be Zero.";
              return 0;
	 		}
 		
 		if(drtot==0.0 || crtot==0.0){
 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should not be Zero.";
              return 0;
	 		}
 		
 		if(drtot==0.00 || crtot==0.00){
 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should not be Zero.";
              return 0;
	 		}
 		rate=document.getElementById("txtrate").value;
		 if(rate=="" || rate=="0" || rate=="0.00"){
			 document.getElementById("errormsg").innerText= "Rate is Mandatory.";
			 return 0;
		 }
	 	
 		document.getElementById("errormsg").innerText="";
	    		
	    /* Grid saving assembly */
		var rows = $("#jqxCreditNote").jqxGrid('getrows');
		var length=0,val=0;
		for(var i=0 ; i < rows.length ; i++){
			var chk=rows[i].docno;
			var rate=rows[i].rate;
			
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
				
				var amount,baseamount,nettotal,taxamnt;
				if(rows[i].dr==true){
					 amount=rows[i].amount1;
					 baseamount=rows[i].baseamount1;
					
					 taxamnt=rows[i].taxamount;
				}
				else if(rows[i].dr==false){
					 amount=rows[i].amount1*-1;
					 baseamount=rows[i].baseamount1*-1;
					
					 taxamnt=rows[i].taxamount*-1;
				}
				
				newTextBox.val(rows[i].docno+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+rows[i].dr+"::"+amount+"::"+rows[i].description+"::"+baseamount+":: "+rows[i].costtype+":: "+rows[i].costcode+":: "+rows[i].tax+":: "+taxamnt+":: "+rows[i].nettotal+":: "+taxacc+":: "+taxamnt);
				newTextBox.appendTo('form');
			}
		}
		if(val==1){
			 document.getElementById("errormsg").innerText= "Rate is Mandatory.";
			 return 0;
		 } 
		$('#gridlength').val(length);
		$('#cmbcurrency').attr('disabled',false); 
		return 1;
	}
			  
	function setValues(){
		$('#jqxCreditNoteDate').jqxDateTimeInput({disabled: false});
		var date = $('#jqxCreditNoteDate').val();
		getCurrencyId(date);
		$('#jqxCreditNoteDate').jqxDateTimeInput({disabled: true});
		
		document.getElementById("cmbtype").value=document.getElementById("hidcmbtype").value;
		document.getElementById("cmbcurrency").value=document.getElementById("hidcmbcurrency").value;
		
		if($('#hidjqxCreditNoteDate').val()){
			 $("#jqxCreditNoteDate").jqxDateTimeInput('val', $('#hidjqxCreditNoteDate').val());
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
			var check = 1;
            $("#jqxCreditNoteGrid").load("creditNoteGrid.jsp?txtcreditnotedocno2="+indexVal+"&check="+check);
		}
		funRoundRate($('#txtrate').val(),"txtrate");
		funRoundAmt($('#txtamount').val(),"txtamount");
		funRoundAmt($('#txtbaseamount').val(),"txtbaseamount");
		funRoundAmt($('#txtdrtotal').val(),"txtdrtotal");
		funRoundAmt($('#txtcrtotal').val(),"txtcrtotal");
	}
	
	function funvalid(){
		rate=document.getElementById("txtrate").value;
		if(rate=="" || rate=="0" || rate=="0.00"){
			document.getElementById("validrate").innerText= "Rate is Mandatory.";
			document.getElementById("txtrate").focus();
			return 0;
		}
		else{
			document.getElementById("validrate").innerText= "";
		}
	}
	
	function getCrTotal(){
	  var fromamount = $('#txtbaseamount').val();
	  var baseamount = 0;
	  if(!isNaN(fromamount)){
		    var dr=0.0,cr=0.0,cr1=0.0;
	        var rows = $('#jqxCreditNote').jqxGrid('getrows');
	        var rowlength= rows.length;
	 		for(var i=0;i<=rowlength-1;i++) {
	 		 var value = rows[i].dr;
             baseamount = rows[i].nettotal;
             if(typeof(baseamount) != "undefined" && typeof(baseamount) != "NaN" && baseamount != ""){
            	 if(value==true){
	              	if(!isNaN(baseamount)){
	                  	dr=dr+baseamount;
	              	}else{
	              		baseamount=0.00;
	              		dr=dr+baseamount;
	              	}
                 }
                 else{
	              	if(!isNaN(baseamount)){
	              		cr=cr+baseamount;
	              	}else{
	              		baseamount=0.00;
	              		cr=cr+baseamount;
	              	}
                 }
             }
	 		}
	 		if(!isNaN(fromamount)){
                cr1=parseFloat(cr) + parseFloat(fromamount);
                funRoundAmt(cr1,"txtcrtotal");
             }
	  }
	  else if(isNaN(fromamount)){
		  $('#txtamount').val(0.00);
		  $('#txtcrtotal').val(0.00);
		  $('#txtdrtotal').val(0.00);
	  }
	}
	
	function getAccType(event){
       var x= event.keyCode;
       if(x==114){
    	  var date = $('#jqxCreditNoteDate').jqxDateTimeInput('getDate');
		  $("#maindate").jqxDateTimeInput('val', date);
		  accountSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtype').val()+"&date="+date);
    	  $('#txtforsearch').val(2);
       }
       else{}
    }
	
	function funPrintBtn() {
		if (($("#mode").val() == "view") && $("#docno").val()!="") {
	        var url=document.URL;
	        var reurl=url.split("saveTaxCreditNote");
	        $("#docno").prop("disabled", false);  
	     
	        $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
				if (r){
					 var win= window.open(reurl[0]+"printTaxCreditNote?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
				     win.focus();
				 }
				else{
					var win= window.open(reurl[0]+"printTaxCreditNote?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
				    win.focus();
				}
			   });
	     }
	    else {
			$.messager.alert('Message','Select a Document....!','warning');
			return;
		}
    }
	
	function clearClientInfo(){
		$("#txtdocno").val('');$("#txtaccid").val('');$("#txtaccname").val('');
	}
	
	function datechange(){
		  var date = $('#jqxCreditNoteDate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(date);
		  if(parseInt(validdate)==0){
			document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
			return 0;	
		  } 
		  $("#maindate").jqxDateTimeInput('val', date);
	}
</script>

<style>
/* ----------- Scrollbar ------------ */
.hidden-scrollbar {
  overflow-y: auto;
  height: 530px;
  scrollbar-width: thin;
  scrollbar-color: #4da3ff #eaf3ff;
}
.hidden-scrollbar::-webkit-scrollbar {
  width: 7px;
}
.hidden-scrollbar::-webkit-scrollbar-thumb {
  background-color: #4da3ff;
  border-radius: 8px;
}
.hidden-scrollbar::-webkit-scrollbar-thumb:hover {
  background-color: #1a73e8;
}

/* ----------- Page Background ------------ */
body {
  background: linear-gradient(135deg, #e8f1ff 0%, #d1e4ff 100%);
  font-family: "Poppins", "Segoe UI", sans-serif;
  color: #1f2f46;
  margin: 0;
  padding: 40px 0;
  min-height: 100vh;
  animation: fadeIn 0.6s ease-in-out;
}

/* ----------- Main Container ------------ */
#mainBG {
  background: #f4f8ff;
  border-radius: 16px;
  box-shadow: 0 4px 25px rgba(50, 110, 255, 0.15);
  padding: 25px 30px;
  max-width: 1250px;
  margin: 0 auto;
  transition: 0.3s ease;
}
#mainBG:hover {
  box-shadow: 0 8px 35px rgba(30, 100, 255, 0.25);
}

/* ----------- Section Container ------------ */
.receipt-header {
  background: #edf4ff;
  border: 1px solid #c9dafc;
  border-radius: 14px;
  padding: 20px;
  margin-bottom: 26px;
  box-shadow: 0 2px 10px rgba(132, 168, 255, 0.2);
}

/* ----------- Labels ------------ */
label {
  font-weight: 600;
  font-size: 15px;
  color: #1a2d4d;
  margin-bottom: 6px !important;
}

/* ----------- Unified Input Styling ------------ */
input[type="text"],
select,
.clean-input {
  width: 100%;
  height: 38px !important;
  padding: 6px 12px;
  border: 1px solid #b9ccf2;
  border-radius: 8px;
  background: #ffffff;
  font-size: 0.95rem;
  color: #1f2f46;
  box-sizing: border-box;
  transition: 0.25s ease;
}
input[type="text"]:focus,
select:focus {
  border-color: #4da3ff;
  box-shadow: 0 0 6px rgba(77, 163, 255, 0.55);
  outline: none;
}

/* ----------- Dropdown ------------ */
select {
  appearance: none;
  background: #ffffff url("data:image/svg+xml;utf8,<svg fill='%233b82f6' height='20' width='20' viewBox='0 0 20 20'><polygon points='5,7 15,7 10,12' /></svg>") no-repeat right 10px center;
  background-size: 14px;
}
select option {
  font-size: 15px;
}

/* ----------- Disabled Inputs ------------ */
input[readonly],
select:disabled {
  background-color: #eef3ff !important;
  color: #6a7ba1 !important;
}

/* ----------- JQX Date Input ------------ */
#jqxCreditNoteDate {
  width: 100% !important;
  height: 38px !important;
}
#jqxCreditNoteDate input {
  height: 36px !important;
  padding-left: 10px !important;
  border-radius: 8px !important;
  background-color: #ffffff !important;
  box-shadow: none !important;
}

/* ----------- Autofill Pink FIX ------------ */
input:-webkit-autofill,
input:-webkit-autofill:hover,
input:-webkit-autofill:focus,
select:-webkit-autofill {
  -webkit-box-shadow: 0 0 0px 1000px #ffffff inset !important;
  background-color: #ffffff !important;
  color: #1f2f46 !important;
}
input::selection,
#jqxCreditNoteDate input::selection {
  background: #cfe2ff !important;
  color: #000 !important;
}

/* ----------- Grid Form Layout (3-col) ------------ */
.clean-grid-form {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 22px 32px;
  width: 100%;
  box-sizing: border-box;
}
.clean-grid-item {
  display: flex;
  flex-direction: column;
}
.clean-grid-item.full {
  grid-column: span 3;
}

/* ----------- Table Styling ------------ */
.cr-table {
  width: 100%;
  border-collapse: collapse;
  background: #ffffff;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 2px 12px rgba(100, 140, 255, 0.15);
}
.cr-table th,
.cr-table td {
  padding: 10px 12px;
  border-bottom: 1px solid #d6e1ff;
  text-align: left;
  font-size: 0.95rem;
}
.cr-table th {
  background-color: #dcebff;
  color: #1b3f73;
  font-weight: 600;
}
.cr-table tr:hover td {
  background-color: #eef5ff;
  transition: 0.25s;
}

/* ----------- Buttons ------------ */
button,
.myButton {
  background: linear-gradient(90deg, #3b82f6, #1a73e8);
  color: #fff;
  border: none;
  border-radius: 8px;
  padding: 9px 22px;
  font-weight: 600;
  cursor: pointer;
  transition: 0.25s ease;
  box-shadow: 0 3px 10px rgba(30, 100, 255, 0.25);
}
button:hover,
.myButton:hover {
  background: linear-gradient(90deg, #1a73e8, #155cc6);
  transform: translateY(-2px);
}
button:active {
  transform: scale(0.96);
}

/* ----------- Error Text ------------ */
#validrate,
#errormsg {
  color: #d62828;
  font-weight: 600;
  font-size: 0.9rem;
}

/* Fade Animation */
@keyframes fadeIn {
  from { opacity: 0; transform: translateY(-5px); }
  to { opacity: 1; transform: translateY(0); }
}

/* Mobile */
@media (max-width: 900px) {
  .clean-grid-form {
    grid-template-columns: repeat(1, 1fr);
  }
  .clean-grid-item.full {
    grid-column: span 1;
  }
}

/* jqxGrid visual adjustments (darker borders, stronger header) */
/* These selectors are safe to keep as-is for the credit grid too */
#jqxCreditNote {
    border: 1px solid #9db4d9 !important;
    border-radius: 12px !important;
    overflow: hidden !important;
}
.jqx-grid-column-header, .jqx-widget-header {
    background: #d5e4ff !important; color: #0f2a4d !important; font-weight: 700 !important;
    font-size: 14.5px !important; border-bottom: 1px solid #9db4d9 !important;
    height: 38px !important; min-height: 38px !important; line-height: 38px !important; padding: 0 !important;
}
.jqx-grid-column-header div, .jqx-widget-header div { padding: 0 10px !important; margin: 0 !important; line-height: 38px !important; }
.jqx-grid-cell { background-color: #ffffff !important; border-color: #d3def5 !important; font-size: 14px !important; color: #1c2f4a !important; height: 38px !important; min-height: 38px !important; padding: 0 10px !important; display:flex !important; align-items:center !important; }
.jqx-grid-cell-alt { background-color: #f4f7ff !important; }
.jqx-grid-cell-hover { background-color: #e4edff !important; }
.jqx-grid-cell-selected { background-color: #c3d6ff !important; border-color: #6a92d7 !important; }
.jqx-grid-statusbar { background: #e3ecff !important; border-top: 1px solid #9db4d9 !important; color: #0f2a4d !important; font-size: 14px !important; font-weight: 700 !important; height: 34px !important; padding: 6px 10px !important; }
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">

<form id="frmTaxCreditNote" action="saveTaxCreditNote" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<!-- ================= SCROLLABLE CONTENT WRAPPER (FIXED) ================ -->
<div class="hidden-scrollbar">

    <!-- ================= TOP FORM SECTION ================= -->
    <div class="receipt-header">
      <div class="table-section">

        <!-- ====== CLEAN GRID FORM (TOP SECTION) for Credit Note ====== -->
        <div class="clean-grid-form">

            <!-- ROW 1 -->
            <div class="clean-grid-item">
                <label>Date</label>
                <div id="jqxCreditNoteDate" onchange="datechange();" onblur="datechange();"></div>
                <input type="hidden" id="hidjqxCreditNoteDate" name="hidjqxCreditNoteDate"
                       value='<s:property value="hidjqxCreditNoteDate"/>'/>
            </div>

            <div class="clean-grid-item">
                <label>Ref. No.</label>
                <input type="text" id="txtrefno" name="txtrefno"
                       class="clean-input"
                       value='<s:property value="txtrefno"/>'/>
            </div>

            <div class="clean-grid-item">
                <label>Doc No.</label>
                <input type="text" id="docno" name="txtcreditnotedocno"
                       class="clean-input"
                       value='<s:property value="txtcreditnotedocno"/>' tabindex="-1"/>
            </div>

            <!-- ROW 2 -->
            <div class="clean-grid-item">
                <label>Type</label>
                <select id="cmbtype" name="cmbtype" class="clean-input"
                        onchange="clearClientInfo();">
                    <option value="AR">AR</option>
                    <option value="AP">AP</option>
                    <option value="GL">GL</option>
                </select>
                <input type="hidden" id="hidcmbtype" name="hidcmbtype"
                       value='<s:property value="hidcmbtype"/>'/>
            </div>

            <div class="clean-grid-item">
                <label>Account</label>
                <input type="text" id="txtaccid" name="txtaccid"
                       class="clean-input"
                       placeholder="Press F3 to Search"
                       value='<s:property value="txtaccid"/>'
                       onkeydown="getAccType(event);" />
            </div>

            <div class="clean-grid-item">
                <label>Account Name</label>
                <input type="text" id="txtaccname" name="txtaccname"
                       class="clean-input"
                       value='<s:property value="txtaccname"/>' tabindex="-1"/>
                <input type="hidden" id="txtdocno" name="txtdocno"
                       value='<s:property value="txtdocno"/>'/>
                <input type="hidden" id="txttrno" name="txttrno"
                       value='<s:property value="txttrno"/>'/>
            </div>

            <!-- ROW 3 -->
            <div class="clean-grid-item">
                <label>Currency</label>
                <select id="cmbcurrency" name="cmbcurrency"
                        class="clean-input"
                        onchange="getRatevalue(this.value,$('#jqxCreditNoteDate').val());">
                </select>
                <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency"
                       value='<s:property value="hidcmbcurrency"/>'/>
            </div>

            <div class="clean-grid-item">
                <label>Rate</label>
                <input type="text" id="txtrate" name="txtrate"
                       class="clean-input"
                       style="text-align:right;"
                       value='<s:property value="txtrate"/>'
                       onblur="funRoundRate(this.value,this.id);getBaseAmountFrom();getCrTotal();" />
                <span id="validrate"></span>
            </div>

            <div></div>

            <!-- ROW 4 -->
            <div class="clean-grid-item">
                <label>Amount</label>
                <input type="text" id="txtamount" name="txtamount"
                       class="clean-input"
                       style="text-align:right;"
                       value='<s:property value="txtamount"/>'
                       onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getCrTotal();" />
            </div>

            <div class="clean-grid-item">
                <label>Base Amount</label>
                <input type="text" id="txtbaseamount" name="txtbaseamount"
                       class="clean-input"
                       style="text-align:right;"
                       value='<s:property value="txtbaseamount"/>' tabindex="-1"/>
            </div>

            <div></div>

            <!-- ROW 5 -->
            <div class="clean-grid-item full">
                <label>Description</label>
                <input type="text" id="txtdescription" name="txtdescription"
                       class="clean-input"
                       value='<s:property value="txtdescription"/>'/>
            </div>

        </div>
        <!-- ====== END CLEAN GRID FORM ====== -->

      </div>
    </div>

    <!-- ================= GRID SECTION ================= -->
    <div class="cr-table" id="jqxCreditNoteGrid" style="margin-top:18px;">
        <jsp:include page="creditNoteGrid.jsp"></jsp:include>
    </div>

    <br/>

    <!-- ================= TOTALS SECTION ================= -->
    <table class="cr-table" width="100%">
        <tr>
            <td style="width:10%; text-align:right;">Dr. Total</td>
            <td style="width:55%;">
                <input type="text" id="txtdrtotal" name="txtdrtotal"
                       style="width:20%; text-align:right;"
                       value='<s:property value="txtdrtotal"/>' tabindex="-1"/>
            </td>
            <td style="width:10%; text-align:right;">Cr. Total</td>
            <td style="width:25%;">
                <input type="text" id="txtcrtotal" name="txtcrtotal"
                       style="width:50%; text-align:right;"
                       value='<s:property value="txtcrtotal"/>' tabindex="-1"/>
            </td>
        </tr>
    </table>

</div>
<!-- ================= END SCROLLABLE WRAPPER ================= -->

<!-- Hidden fields -->
<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<div hidden="hidden" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
<input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
<input type="hidden" name="txtforsearch" id="txtforsearch" value='<s:property value="txtforsearch"/>'/>
<input type="hidden" id="txtvalidation" name="txtvalidation"  value='<s:property value="txtvalidation"/>'/>
<input type="hidden" id="taxaccount" name="taxaccount"  value='<s:property value="taxaccount"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>

</form>

<!-- windows -->
<div id="creditNoteGridWindow"><div></div><div></div></div>
<div id="accountDetailsToWindow"><div></div><div></div></div>
<div id="costTypeSearchGridWindow"><div></div><div></div></div>
<div id="costCodeSearchWindow"><div></div><div></div></div>

</div>
</body>

</html>
