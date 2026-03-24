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
  
    body {
        background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
        color: #222;
        margin: 0;
        padding: 32px 0 0 0;
        min-height: 100vh;
        box-sizing: border-box;
    }

    #mainBG {
        background: #fff;
        border-radius: 16px;
        padding: 20px;
        max-width: 100%;
        margin: auto;
        box-shadow: 0 4px 24px rgba(0,0,0,0.06);
        /* FORCE HEADER LEFT ALIGNMENT */
        text-align: left !important; 
    }

   
    
   
    center {
        text-align: left !important;
        display: block;
        width: 100%;
        margin-left: 0;
    }
    
    #formdet {
        font-size: 24px !important;
        font-weight: 700 !important;
        color: #2c3e50;
        margin-bottom: 15px;
        display: block;
        text-align: left !important;
        font-family: 'Segoe UI', sans-serif;
    }

   
    .receipt-header {
        display: grid;
        grid-template-columns: auto 1fr auto 1fr auto 1fr;
        gap: 15px;
        align-items: center;
        margin-bottom: 20px;
        padding: 0 0 0 5px; 
    }

    .form-group {
        display: grid;
        grid-template-columns: 120px 1fr;
        align-items: center;
        gap: 12px;
        margin-bottom: 12px;
    }

    .form-group.dual-input {
        grid-template-columns: 120px 1fr 120px 1fr;
    }

    .form-group.single-label-dual-input {
        grid-template-columns: 120px 1fr 1fr;
    }

    .section-row {
        display: flex;
        gap: 26px;
        margin-bottom: 30px;
    }

    .section-block {
        flex: 1;
        background: #f6f8fa;
        border-radius: 12px;
        padding: 20px;
        box-shadow: 0 1px 8px rgba(160,177,217,0.1);
    }

    .section-block h2 {
        font-size: 1.1rem;
        font-weight: 600;
        margin: 0 0 20px;
        padding-left: 10px;
        border-left: 4px solid #007bff;
        color: #333;
    }

    
    input[type="text"], select {
        height: 32px !important;
        border: 1px solid #d1d5db;
        border-radius: 6px;
        padding: 6px 10px;
        background: #fff;
        transition: border-color 0.2s;
        font-size: 14px;
        box-sizing: border-box;
        width: 100%;
    }

    input[type="text"]:focus, select:focus {
        border-color: #007bff;
        outline: none;
    }
    
    input[readonly] {
        background-color: #f3f4f6;
        color: #6b7280;
    }

    label {
        font-weight: 600;
        color: #253858;
        white-space: nowrap;
        text-align: right;
        padding-right: 10px;
        font-size: 14px;
    }

    
    .table-section { margin: 20px 0; }
    .table-section h3 {
        color: #253858; font-size: 1.05rem; font-weight: 600; margin-bottom: 12px;
    }
    
   

    .doc-group { display: flex; gap: 5px; }
    
   .hidden-scrollbar {
    overflow: auto;
    height: auto;
    max-height: calc(100vh - 100px); 
}

    body::-webkit-scrollbar {
    width: 0px;
}

.myButton {
 font-weight: 700;
    font-size: 13px;
    width: 130px;
    height: 38px;
    padding: 8px 12px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 2px 4px rgba(59, 130, 246, 0.2);
    text-transform: uppercase;
    letter-spacing: 0.3px;
    white-space: nowrap;
    text-align: center;
}

.myButton:hover {
  background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%);
  box-shadow: 0 4px 6px rgba(59, 130, 246, 0.3);
  transform: translateY(-1px);
    #validrate, #validrate1 { color: red; font-size: 12px; }
</style>

<script type="text/javascript">
	$(document).ready(function() {
		 $("#btnvaluechange").hide();
		
		 $("#jqxUnclearedChequePaymentDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#jqxChequeDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});		 
		
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
			  accountFromSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
			  });
		 
		  $('#txttoaccid').dblclick(function(){
			  var date = $('#jqxUnclearedChequePaymentDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountToSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtotype').val()+"&date="+date);
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
        	  accountFromSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
          }
          else{}
          }
	  
	  function getAccType(event){
          var x= event.keyCode;
          if(x==114){
        	  var date = $('#jqxUnclearedChequePaymentDate').jqxDateTimeInput('getDate');
        	  $("#maindate").jqxDateTimeInput('val', date);
        	  accountToSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtotype').val()+"&date="+date);
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
<div id="mainBG" class="hidden-scrollbar homeContent" data-type="background">
<form id="frmUnclearedChequePayment" action="saveUnclearedChequePayment" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

    <div class='receipt-header'>
        <label>Date</label>
        <div>
            <div id="jqxUnclearedChequePaymentDate" name="jqxUnclearedChequePaymentDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxUnclearedChequePaymentDate"/>'></div>
            <input type="hidden" id="hidjqxUnclearedChequePaymentDate" name="hidjqxUnclearedChequePaymentDate" value='<s:property value="hidjqxUnclearedChequePaymentDate"/>'/>
        </div>

        <label>Ref. No.</label>
        <input type="text" id="txtrefno" name="txtrefno" value='<s:property value="txtrefno"/>'/>

        <label>Doc No.</label>
        <div class="doc-group">
            <input type="text" id="docno" name="txtunclearedchequepaydocno" value='<s:property value="txtunclearedchequepaydocno"/>' tabindex="-1"/>
            <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button>
        </div>
    </div>


    <div class="section-row">
        <div class="section-block">
            <h2>Bank</h2>
            
            <div class="form-group single-label-dual-input">
                <label>Bank</label>
                <input type="text" id="txtfromaccid" name="txtfromaccid" placeholder="Press F3 to Search" value='<s:property value="txtfromaccid"/>'  onkeydown="getAcc(event);"/>
                <input type="text" id="txtfromaccname" name="txtfromaccname" value='<s:property value="txtfromaccname"/>' tabindex="-1"/>
                <input type="hidden" id="txtfromdocno" name="txtfromdocno" value='<s:property value="txtfromdocno"/>'/>
            </div>

            <div class="form-group dual-input">
                <label>Currency</label>
                <select id="cmbfromcurrency" name="cmbfromcurrency" value='<s:property value="cmbfromcurrency"/>' onchange="getRate(this.value,$('#jqxUnclearedChequePaymentDate').val());">
                    <option></option>
                </select>
                <input type="hidden" id="hidcmbfromcurrency" name="hidcmbfromcurrency" value='<s:property value="hidcmbfromcurrency"/>'/>
                <input type="hidden" id="hidfromcurrencytype" name="hidfromcurrencytype" value='<s:property value="hidfromcurrencytype"/>'/>

                <label>Rate</label>
                <input type="text" id="txtfromrate" name="txtfromrate" onchange="funvalid()" value='<s:property value="txtfromrate"/>' onblur="funRoundRate(this.value,this.id);getBaseAmountFrom();getCrTotal();" tabindex="-1"/>
                <span id="validrate"></span>
            </div>

            <div class="form-group dual-input">
                 <label>Cheque No</label>
                 <input type="text" id="txtchequeno" name="txtchequeno" value='<s:property value="txtchequeno"/>' />
                 
                 <label>Cheque Date</label>
                 <div>
                    <div id="jqxChequeDate" name="jqxChequeDate" value='<s:property value="jqxChequeDate"/>'></div>
                    <input type="hidden" id="hidjqxChequeDate"  name="hidjqxChequeDate" value='<s:property value="hidjqxChequeDate"/>'/>
                 </div>
            </div>
            
            <div class="form-group">
                <label>Cheque Name</label>
                <input type="text" id="txtchequename" name="txtchequename" value='<s:property value="txtchequename"/>' />
            </div>

            <div class="form-group dual-input">
                <label>Amount</label>
                <input type="text" id="txtfromamount" name="txtfromamount" value='<s:property value="txtfromamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getCrTotal();" />
                
                <label>Base Amount</label>
                <input type="text" id="txtfrombaseamount" name="txtfrombaseamount" value='<s:property value="txtfrombaseamount"/>' tabindex="-1"/>
            </div>

            <div class="form-group">
                <label>Description</label>
                <input type="text" id="txtdescription" name="txtdescription" value='<s:property value="txtdescription"/>'/>
            </div>
        </div>

        <div class="section-block">
            <h2>Payment To</h2>
            
            <div class="form-group">
                <label>Type</label>
                <select id="cmbtotype" name="cmbtotype" onchange="clearClientInfo();" value='<s:property value="cmbtotype"/>'>
                    <option value="AP">AP</option><option value="AR">AR</option>
                </select>
                <input type="hidden" id="hidcmbtotype" name="hidcmbtotype" value='<s:property value="hidcmbtotype"/>'/>
            </div>

            <div class="form-group single-label-dual-input">
                 <label>Account</label>
                 <input type="text" id="txttoaccid" name="txttoaccid" placeholder="Press F3 to Search" value='<s:property value="txttoaccid"/>' onkeydown="getAccType(event);"/>
                 <input type="text" id="txttoaccname" name="txttoaccname" value='<s:property value="txttoaccname"/>' tabindex="-1"/>
                 <input type="hidden" id="txttodocno" name="txttodocno" value='<s:property value="txttodocno"/>'/>
            </div>

            <div class="form-group dual-input">
                <label>Currency</label>
                <select id="cmbtocurrency" name="cmbtocurrency" value='<s:property value="cmbtocurrency"/>' onchange="getRatevalue(this.value,$('#jqxUnclearedChequePaymentDate').val());">
                    <option></option>
                </select>
                <input type="hidden" id="hidcmbtocurrency" name="hidcmbtocurrency" value='<s:property value="hidcmbtocurrency"/>'/>
                <input type="hidden" id="hidtocurrencytype" name="hidtocurrencytype" value='<s:property value="hidtocurrencytype"/>'/>

                <label>Rate</label>
                <input type="text" id="txttorate" name="txttorate" onchange="funvalid1()" value='<s:property value="txttorate"/>' onblur="funRoundRate(this.value,this.id);getBaseAmountTo();getDrTotal();" tabindex="-1"/>
                <span id="validrate1"></span>
            </div>

            <div class="form-group dual-input">
                <label>Amount</label>
                <input type="text" id="txttoamount" name="txttoamount" value='<s:property value="txttoamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountTo();getDrTotal();" />
                
                <label>Base Amount</label>
                <input type="text" id="txttobaseamount" name="txttobaseamount" value='<s:property value="txttobaseamount"/>' tabindex="-1"/>
            </div>
        </div>
    </div>

    <div class="table-section">
        <div id="jqxUnclearedChequePaymentGrid"><jsp:include page="unclearedChequePaymentGrid.jsp"></jsp:include></div><br/>
        
        <div class="form-group dual-input">
            <label>Dr. Total</label>
            <input type="text" id="txtdrtotal" name="txtdrtotal" value='<s:property value="txtdrtotal"/>'/>
            
            <label>Cr. Total</label>
            <input type="text" id="txtcrtotal" name="txtcrtotal" value='<s:property value="txtcrtotal"/>' tabindex="-1"/>
        </div>
    </div>

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