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
   UNCLEARED CHEQUE PAYMENT - EXACT TEXT & UI MATCH TO CLIENT MASTER
========================================================= */
body, .homeContent {
    background: #f4f6f9 !important;
    font-family: Arial, sans-serif !important;
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

/* FIX: Responsive scroll area so the bottom is never cut off */
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
}

#validrate, #validrate1 {
    color: red;
}

/* EXACT Input Styles from Client Master */
input[type="text"], input[type="email"], select {
    height: 24px !important; 
    border: 1px solid #ccc !important;
    border-radius: 3px !important;
    padding: 2px 6px !important;
    font-size: 12px !important;
    box-sizing: border-box;
    background-color: #fff !important;
    color: #333 !important;
    width: 100%;
}

input[type="text"]:focus, input[type="email"]:focus, select:focus {
    border-color: #007bff !important;
    outline: none !important;
}

input[readonly], input:disabled, select:disabled {
    background-color: #f4f5f7 !important;
    color: #5e6c84 !important;
    border-color: #e1e4e8 !important;
}

/* Fieldset and Legend styling matching Client Master */
fieldset {
    border: 1px solid #e1e4e8 !important;
    background-color: #fff !important;
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
    color: #444 !important;
    font-weight: bold !important;
    vertical-align: middle;
}

/* Modern Buttons matched to Client Master */
.myButton {
    background-color: #0056b3 !important;
    color: #ffffff !important;
    border: none !important;
    border-radius: 3px !important;
    padding: 4px 15px !important;
    font-weight: bold !important;
    font-size: 12px !important;
    cursor: pointer !important;
    height: 24px !important;
}

.myButton:hover {
    background-color: #004494 !important;
}
</style>

<script type="text/javascript">
	$(document).ready(function() {
		 $("#btnvaluechange").hide();
		 
		 /* MODIFIED: Heights set to 24px to match text boxes */
		 $("#jqxUnclearedChequePaymentDate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
		 $("#jqxChequeDate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
		
		 $('#accountDetailsToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsToWindow').jqxWindow('close');  
		 
		 $('#accountDetailsFromWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsFromWindow').jqxWindow('close');
		 
		 $('#unclearedChequePaymentGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#unclearedChequePaymentGridWindow').jqxWindow('close');
		 
		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#costTypeSearchGridWindow').jqxWindow('close');
 		 
 		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
		 
		 $('#printWindow').jqxWindow({width: '51%', height: '31%',  maxHeight: '50%' ,maxWidth: '51%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#printWindow').jqxWindow('close');
		 
		 $('#jqxUnclearedChequePaymentDate').on('change', function (event) {
				 var bankpaydate = $('#jqxUnclearedChequePaymentDate').jqxDateTimeInput('getDate');
				 var validdate=funDateInPeriod(bankpaydate);
				 if(parseInt(validdate)==0){
					document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
					return 0;	
				 }
			 });
			 
		 $('#txtfromaccid').dblclick(function(){
			  var date = $('#jqxUnclearedChequePaymentDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountFromSearchContent("<%=contextPath%>/com/finance/accountsDetailsSearch.jsp?date="+date);
			  });
		 
		  $('#txttoaccid').dblclick(function(){
			  var date = $('#jqxUnclearedChequePaymentDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountToSearchContent("<%=contextPath%>/com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtotype').val()+"&date="+date);
			  });  	 
	});
	
	function unclearedChequeSearchContent(url) {
		$('#unclearedChequePaymentGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#unclearedChequePaymentGridWindow').jqxWindow('setContent', data);
		$('#unclearedChequePaymentGridWindow').jqxWindow('bringToFront');
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
	
	 function funReadOnly(){
			$('#frmUnclearedChequePayment input').attr('readonly', true );
			$('#frmUnclearedChequePayment select').attr('disabled', true);
			$('#jqxUnclearedChequePaymentDate').jqxDateTimeInput({disabled: true});
			$('#jqxChequeDate').jqxDateTimeInput({disabled: true});
			$("#jqxUnclearedChequePayment").jqxGrid({ disabled: true});
			$("#btnvaluechange").hide();
	 }
	 
	 function funRemoveReadOnly(){
			$('#frmUnclearedChequePayment input').attr('readonly', false );
			$('#frmUnclearedChequePayment select').attr('disabled', false);
			$('#cmbfromcurrency').attr('disabled', true);
			$('#cmbtocurrency').attr('disabled', true);
			$('#txtfromaccid').attr('readonly', true );
			$('#txtfromaccname').attr('readonly', true );
			$('#txttoaccid').attr('readonly', true );
			$('#txttoaccname').attr('readonly', true );
			$('#txtdrtotal').attr('readonly', true );
			$('#txtcrtotal').attr('readonly', true );
			$('#jqxUnclearedChequePaymentDate').jqxDateTimeInput({disabled: false});
			$('#jqxChequeDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$("#jqxUnclearedChequePayment").jqxGrid({ disabled: false});
			
			var date = $('#jqxUnclearedChequePaymentDate').val();
		    getCurrencyId(date);
			
			if ($("#mode").val() == "E") {
         	    $("#btnvaluechange").show();
         	    $('#frmUnclearedChequePayment input').attr('readonly', true );
   			    $('#frmUnclearedChequePayment select').attr('disabled', true);
   			    $('#jqxChequeDate').jqxDateTimeInput({disabled: true});
			    $("#jqxUnclearedChequePayment").jqxGrid({ disabled: true});
   			    $('#txtrefno').attr('readonly', false );
   			    $("#jqxUnclearedChequePayment").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","dr": true,"amount1": "","description": ""});
			  }
			 else{
				$("#btnvaluechange").hide();
			} 
			
			if ($("#mode").val() == "A") {
				$('#jqxUnclearedChequePaymentDate').val(new Date());
				$("#jqxUnclearedChequePayment").jqxGrid('clear'); 
				$("#jqxUnclearedChequePayment").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","dr": true,"amount1": "","description": ""});
			}
	 }
	 
	 function funSearchLoad(){
		changeContent('ucpMainSearch.jsp'); 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus()
	    {
	    	$('#jqxUnclearedChequePaymentDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	  /* Validations */
	   $(function(){
	        $('#frmUnclearedChequePayment').validate({
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
		    var bankpaydate = $('#jqxUnclearedChequePaymentDate').jqxDateTimeInput('getDate');
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
	 		
	 		if(drtot=="" || crtot=="" || drtot=="NaN" || crtot=="NaN" || drtot==0 || crtot==0 || drtot==0.0 || crtot==0.0 || drtot==0.00 || crtot==0.00){
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
	    
	    	/* Uncleared Cheque Payment Grid  Saving*/
	  		  var rows = $("#jqxUnclearedChequePayment").jqxGrid('getrows');
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
	  						 amount=rows[i].amount1;
	  						 baseamount=rows[i].rate*rows[i].amount1;
	  					}
	  					else if(rows[i].dr==false){
	  						 amount=rows[i].amount1*-1;
	  						 baseamount=rows[i].rate*rows[i].amount1*-1;
	  					}
	  					
	  				newTextBox.val(rows[i].docno+":: "+rows[i].currencyid+":: "+rows[i].rate+":: "+rows[i].dr+":: "+amount+":: "+rows[i].description+":: "+baseamount+":: "+rows[i].costtype+":: "+rows[i].costcode);
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
	  	 		   /* Uncleared Cheque Payment Grid  Saving Ends*/	 
	  				 
	  				 $('#jqxUnclearedChequePaymentDate').jqxDateTimeInput({disabled: false});
			         $('#jqxChequeDate').jqxDateTimeInput({disabled: false});
			         
			         if ($("#mode").val() == "E") {
			        	 $('#frmUnclearedChequePayment select').attr('disabled', false); 
			         }
			         $('#cmbfromcurrency').attr('disabled', false);
			  		  $('#cmbtocurrency').attr('disabled', false);
			  			
	  				 
	    		return 1;
		} 
	  
	  function setValues(){
		  
		  $('#jqxUnclearedChequePaymentDate').jqxDateTimeInput({disabled: false});
		  var date = $('#jqxUnclearedChequePaymentDate').val();
		  getCurrencyId(date);
		  $('#jqxUnclearedChequePaymentDate').jqxDateTimeInput({disabled: true});
		  
		  document.getElementById("cmbtotype").value=document.getElementById("hidcmbtotype").value;
		  
		  if($('#hidjqxUnclearedChequePaymentDate').val()){
				 $("#jqxUnclearedChequePaymentDate").jqxDateTimeInput('val', $('#hidjqxUnclearedChequePaymentDate').val());
			  }
		  
		  if($('#hidmaindate').val()){
				 $("#maindate").jqxDateTimeInput('val', $('#hidmaindate').val());
			  }
		  
		  if($('#hidjqxChequeDate').val()){
				 $("#jqxChequeDate").jqxDateTimeInput('val', $('#hidjqxChequeDate').val());
			  }
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
			 
			 var indexVal = document.getElementById("docno").value;
			 if(indexVal>0){
				 var check = 1;
	             $("#jqxUnclearedChequePaymentGrid").load("unclearedChequePaymentGrid.jsp?txtunclearedchequepaydocno2="+indexVal+'&check='+check);
			 }
			    funRoundRate($('#txtfromrate').val(),"txtfromrate");
			    funRoundRate($('#txttorate').val(),"txttorate");
		        funRoundAmt($('#txtfromamount').val(),"txtfromamount");
				funRoundAmt($('#txttoamount').val(),"txttoamount");
		        funRoundAmt($('#txtfrombaseamount').val(),"txtfrombaseamount");
		        funRoundAmt($('#txttobaseamount').val(),"txttobaseamount");
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
	
	  
	  function funwarningopen(){
		  $.messager.confirm('Confirm', 'Transaction will affect Links to the applied Bank Reconcilations & Prepayments.', function(r){
			    if (r){
			    	$("#mode").val("EDIT");
					 $('#txtfromaccid').attr('readonly', false);$('#txtfromaccname').attr('readonly', false);$('#txtfromamount').attr('readonly', false);$('#txtchequeno').attr('readonly', false);
					 $('#jqxChequeDate').jqxDateTimeInput({disabled: false});$('#txtdescription').attr('readonly', false);
					 $('#txttoaccid').attr('readonly', false);$('#txttoaccname').attr('readonly', false);$('#txttoamount').attr('readonly', false);$('#txtfromrate').attr('readonly', true);
				     $('#txtfrombaseamount').attr('readonly', true);$('#txttorate').attr('readonly', true);$('#txttobaseamount').attr('readonly', true);
				     $('#txtchequename').attr('readonly', false);$('#txtdrtotal').attr('readonly', true);$('#txtcrtotal').attr('readonly', true);
					 $('#frmUnclearedChequePayment select').attr('disabled', false);$("#jqxUnclearedChequePayment").jqxGrid({ disabled: false});  
					 $('#cmbfromcurrency').attr('disabled',true);
					 $('#cmbtocurrency').attr('disabled',true);
					  }
			   });
	  }
	  
	  function getDrTotal(){
		  var toamount = $('#txttobaseamount').val();
		  
		  if(!isNaN(toamount)){
			  
		  var dr=0.0,cr=0.0,dr1=0.0;
  	      var rows = $('#jqxUnclearedChequePayment').jqxGrid('getrows');
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
	  		
	  		if(!isNaN(toamount)){
               	dr1=parseFloat(dr) + parseFloat(toamount);
                funRoundAmt(dr1,"txtdrtotal");
           	 }
	      }
		  else if(isNaN(toamount)){
			$('#txtdrtotal').val(0.00);
			$('#txttoamount').val(0.00);
		}
	  } 
	  
	  function getCrTotal(){
		  var fromamount = $('#txtfrombaseamount').val();
		  if(!isNaN(fromamount)){
			  
			    var dr=0.0,cr=0.0,cr1=0.0;
        	    var rows = $('#jqxUnclearedChequePayment').jqxGrid('getrows');
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
                    cr1=parseFloat(cr) + parseFloat(fromamount);
                    funRoundAmt(cr1,"txtcrtotal");
                    }
		  }
		  else if(isNaN(fromamount)){
		  	$('#txtcrtotal').val(0.00);
		  	$('#txtfromamount').val(0.00);
		  }
	  } 
	  	  
	  function getAcc(event){
          var x= event.keyCode;
          if(x==114){
        	  var date = $('#jqxUnclearedChequePaymentDate').jqxDateTimeInput('getDate');
        	  $("#maindate").jqxDateTimeInput('val', date);
        	  accountFromSearchContent("<%=contextPath%>/com/finance/accountsDetailsSearch.jsp?date="+date);
          }
          else{}
          }
	  
	  function getAccType(event){
          var x= event.keyCode;
          if(x==114){
        	  var date = $('#jqxUnclearedChequePaymentDate').jqxDateTimeInput('getDate');
        	  $("#maindate").jqxDateTimeInput('val', date);
        	  accountToSearchContent("<%=contextPath%>/com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtotype').val()+"&date="+date);
          }
          else{}
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
		  $("#txttodocno").val('');$("#txttoaccid").val('');$("#txttoaccname").val('');
	  }
	  
	  function datechange(){
		  var date = $('#jqxUnclearedChequePaymentDate').jqxDateTimeInput('getDate');
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
<form id="frmUnclearedChequePayment" action="saveUnclearedChequePayment" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class='hidden-scrollbar'>

<table width="100%" cellpadding="3" cellspacing="0" style="margin-bottom: 10px;">
  <tr>
    <td width="10%" align="right">Date</td>
    <td width="20%">
        <div id="jqxUnclearedChequePaymentDate" name="jqxUnclearedChequePaymentDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxUnclearedChequePaymentDate"/>'></div>
        <input type="hidden" id="hidjqxUnclearedChequePaymentDate" name="hidjqxUnclearedChequePaymentDate" value='<s:property value="hidjqxUnclearedChequePaymentDate"/>'/>
    </td>
    <td width="10%" align="right">Ref. No.</td>
    <td width="30%" style="display: flex; gap: 5px; align-items: center;">
        <input type="text" id="txtrefno" name="txtrefno" style="width:150px;" value='<s:property value="txtrefno"/>'/>
        <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();" style="padding: 2px 8px !important;">Value Change</button>
    </td>
    <td width="10%" align="right">Doc No.</td>
    <td width="20%">
        <input type="text" id="docno" name="txtunclearedchequepaydocno" style="width:150px; background-color:#f4f5f7;" value='<s:property value="txtunclearedchequepaydocno"/>' tabindex="-1" readonly/>
    </td>
  </tr>
</table>
 
<table width="100%">
<tr>
<td width="50%" valign="top">
<fieldset>
<legend>Payment From</legend>
<table width="100%" cellpadding="3" cellspacing="0">
  <tr>
    <td width="15%" align="right">Bank</td>
    <td width="25%">
        <input type="text" id="txtfromaccid" name="txtfromaccid" placeholder="Press F3 to Search" value='<s:property value="txtfromaccid"/>' onkeydown="getAcc(event);"/>
    </td>
    <td colspan="2" style="display: flex; gap: 5px;">
        <input type="text" id="txtfromaccname" name="txtfromaccname" style="width:200px; background-color:#f4f5f7;" value='<s:property value="txtfromaccname"/>' tabindex="-1" readonly/>
        <input type="hidden" id="txtfromdocno" name="txtfromdocno" value='<s:property value="txtfromdocno"/>'/>
    </td>
  </tr>
  <tr>
    <td align="right">Currency</td>
    <td>
        <select id="cmbfromcurrency" name="cmbfromcurrency" value='<s:property value="cmbfromcurrency"/>' onchange="getRate(this.value,$('#jqxUnclearedChequePaymentDate').val());">
            <option></option>
        </select>
        <input type="hidden" id="hidcmbfromcurrency" name="hidcmbfromcurrency" value='<s:property value="hidcmbfromcurrency"/>'/>
        <input type="hidden" id="hidfromcurrencytype" name="hidfromcurrencytype" value='<s:property value="hidfromcurrencytype"/>'/>
    </td>
    <td width="15%" align="right">Rate</td>
    <td>
        <input type="text" id="txtfromrate" name="txtfromrate" onchange="funvalid()" style="text-align: right;" value='<s:property value="txtfromrate"/>' onblur="funRoundRate(this.value,this.id);getBaseAmountFrom();getCrTotal();" tabindex="-1"/>
        <span id="validrate"></span>
    </td>
  </tr>
  <tr>
    <td align="right">Cheque No.</td>
    <td>
        <input type="text" id="txtchequeno" name="txtchequeno" value='<s:property value="txtchequeno"/>' />
    </td>
    <td align="right">Cheque Date</td>
    <td>
        <div id="jqxChequeDate" name="jqxChequeDate" value='<s:property value="jqxChequeDate"/>'></div>
        <input type="hidden" id="hidjqxChequeDate" name="hidjqxChequeDate" value='<s:property value="hidjqxChequeDate"/>'/>
    </td>
  </tr>
  <tr>
    <td align="right">Cheque Name</td>
    <td colspan="3">
        <input type="text" id="txtchequename" name="txtchequename" value='<s:property value="txtchequename"/>' />
    </td>
  </tr>
  <tr>
    <td align="right">Amount</td>
    <td>
        <input type="text" id="txtfromamount" name="txtfromamount" style="text-align: right;" value='<s:property value="txtfromamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getCrTotal();" />
    </td>
    <td align="right">Base Amount</td>
    <td>
        <input type="text" id="txtfrombaseamount" name="txtfrombaseamount" style="text-align: right; background-color:#f4f5f7;" value='<s:property value="txtfrombaseamount"/>' tabindex="-1" readonly/>
    </td>
  </tr>
  <tr>
    <td align="right">Description</td>
    <td colspan="3">
        <input type="text" id="txtdescription" name="txtdescription" value='<s:property value="txtdescription"/>'/>
    </td>
  </tr>
</table>
</fieldset>
</td>

<td width="50%" valign="top">
<fieldset>
<legend>Payment To</legend>
<table width="100%" cellpadding="3" cellspacing="0">
  <tr>
    <td width="15%" align="right">Type</td>
    <td width="25%">
        <select id="cmbtotype" name="cmbtotype" onchange="clearClientInfo();" value='<s:property value="cmbtotype"/>'>
            <option value="AP">AP</option>
            <option value="AR">AR</option>
        </select>
        <input type="hidden" id="hidcmbtotype" name="hidcmbtotype" value='<s:property value="hidcmbtotype"/>'/>
    </td>
    <td colspan="2" style="display: flex; gap: 5px;">
        <input type="text" id="txttoaccid" name="txttoaccid" style="width:100px;" placeholder="Press F3 to Search" value='<s:property value="txttoaccid"/>' onkeydown="getAccType(event);"/>
        <input type="text" id="txttoaccname" name="txttoaccname" style="width:200px; background-color:#f4f5f7;" value='<s:property value="txttoaccname"/>' tabindex="-1" readonly/>
        <input type="hidden" id="txttodocno" name="txttodocno" value='<s:property value="txttodocno"/>'/>
    </td>
  </tr>
  <tr>
    <td align="right">Currency</td>
    <td>
        <select id="cmbtocurrency" name="cmbtocurrency" value='<s:property value="cmbtocurrency"/>' onchange="getRatevalue(this.value,$('#jqxUnclearedChequePaymentDate').val());">
            <option></option>
        </select>
        <input type="hidden" id="hidcmbtocurrency" name="hidcmbtocurrency" value='<s:property value="hidcmbtocurrency"/>'/>
        <input type="hidden" id="hidtocurrencytype" name="hidtocurrencytype" value='<s:property value="hidtocurrencytype"/>'/>
    </td>
    <td width="15%" align="right">Rate</td>
    <td>
        <input type="text" id="txttorate" name="txttorate" onchange="funvalid1()" style="text-align: right;" value='<s:property value="txttorate"/>' onblur="funRoundRate(this.value,this.id);getBaseAmountTo();getDrTotal();" tabindex="-1"/>
        <span id="validrate1"></span>
    </td>
  </tr>
  <tr>
    <td align="right">Amount</td>
    <td>
        <input type="text" id="txttoamount" name="txttoamount" style="text-align: right;" value='<s:property value="txttoamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountTo();getDrTotal();" />
    </td>
    <td align="right">Base Amount</td>
    <td>
        <input type="text" id="txttobaseamount" name="txttobaseamount" style="text-align: right; background-color:#f4f5f7;" value='<s:property value="txttobaseamount"/>' tabindex="-1" readonly/>
    </td>
  </tr>
</table>
</fieldset>
</td>
</tr></table>

<div id="jqxUnclearedChequePaymentGrid"><jsp:include page="unclearedChequePaymentGrid.jsp"></jsp:include></div><br/>

<table width="100%" cellpadding="3" cellspacing="0">
  <tr>
    <td width="10%" align="right"><b>Dr. Total</b></td>
    <td width="20%">
        <input type="text" id="txtdrtotal" name="txtdrtotal" style="text-align: right; background-color:#f4f5f7;" value='<s:property value="txtdrtotal"/>' tabindex="-1" readonly/>
    </td>
    <td width="40%"></td>
    <td width="10%" align="right"><b>Cr. Total</b></td>
    <td width="20%">
        <input type="text" id="txtcrtotal" name="txtcrtotal" style="text-align: right; background-color:#f4f5f7;" value='<s:property value="txtcrtotal"/>' tabindex="-1" readonly/>
    </td>
  </tr>
</table>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" name="txtforsearch" id="txtforsearch" value="0"/>
<div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
<input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
</div>
</form>
	
<div id="unclearedChequePaymentGridWindow">
	<div></div><div></div>
</div>  
				
<div id="accountDetailsFromWindow">
	<div></div><div></div>
</div>  
	 
<div id="accountDetailsToWindow">
    <div></div><div></div>
</div> 

<div id="costTypeSearchGridWindow">
	<div></div><div></div>
</div> 

<div id="costCodeSearchWindow">
	<div></div><div></div>
</div> 

<div id="printWindow">
	<div></div><div></div>
</div> 

</div>
</body>
</html>