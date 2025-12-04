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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/globalcss.css">


<script type="text/javascript">
	$(document).ready(function() {
		 $("#btnvaluechange").hide();
		
		 $("#jqxBankPaymentDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#jqxChequeDate").jqxDateTimeInput({ width: '110px', height: '15px', formatString:"dd.MM.yyyy"});		 
		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsToWindow').jqxWindow('close');  
		 
		 $('#accountDetailsFromWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsFromWindow').jqxWindow('close');
		 
		 $('#bankPaymentGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#bankPaymentGridWindow').jqxWindow('close');
		 
		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#costTypeSearchGridWindow').jqxWindow('close');
 		 
 		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
		 
		 $('#printWindow').jqxWindow({width: '51%', height: '31%',  maxHeight: '50%' ,maxWidth: '51%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#printWindow').jqxWindow('close');
		 
		$('#jqxBankPaymentDate').on('change', function (event) {
				 var bankpaydate = $('#jqxBankPaymentDate').jqxDateTimeInput('getDate');
				 var validdate=funDateInPeriod(bankpaydate);
				 if(parseInt(validdate)==0){
					document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
					return 0;	
				 }
		});
		
		
		$('#txtfromaccid').dblclick(function(){
			  var date = $('#jqxBankPaymentDate').jqxDateTimeInput('getDate');
        	  $("#maindate").jqxDateTimeInput('val', date);
			  accountFromSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
		});
		 
		$('#txttoaccid').dblclick(function(){
			  var date = $('#jqxBankPaymentDate').jqxDateTimeInput('getDate');
        	  $("#maindate").jqxDateTimeInput('val', date);
			  accountToSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtotype').val()+"&date="+date);
		});  
		
	});
	
	function BankSearchContent(url) {
		$('#bankPaymentGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#bankPaymentGridWindow').jqxWindow('setContent', data);
		$('#bankPaymentGridWindow').jqxWindow('bringToFront');
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
	
	function BankPrintContent(url) {
		$('#printWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#printWindow').jqxWindow('setContent', data);
		$('#printWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function getChequeNoAlreadyExists(chequeno,bankacno,mode,docno){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText.trim();
				
  				if(parseInt(items)==1){
  					 document.getElementById("errormsg").innerText="Cheque No. Already Exists.";
  					 return 0;
  				 }
				 
				 pdcchequevalid=document.getElementById("txtpdcdatevalidation").value;
				 if(pdcchequevalid==1){
					document.getElementById("errormsg").innerText="Invalid Cheque Date !!!";
					return 0;
			    }
  				//document.getElementById("errormsg").innerText="";
  		}
	}
	x.open("GET", <%=contextPath+"/"%>+"com/finance/getChequeNoAlreadyExists.jsp?chequeno="+chequeno+'&bankacno='+bankacno+'&mode='+mode+'&docno='+docno, true);
	x.send();
    }
	
	function checkpdc(){
		 if(document.getElementById("hidchckpdc").value==1){
			 document.getElementById("chckpdc").checked = true;
		 }
		 else if(document.getElementById("hidchckpdc").value==0){
			document.getElementById("chckpdc").checked = false;
		  }
		 }
	
	 function funReadOnly(){
			$('#frmBankPayment input').attr('readonly', true );
			$('#frmBankPayment select').attr('disabled', true);
			$('#chckpdc').attr('disabled', true);
			$('#jqxBankPaymentDate').jqxDateTimeInput({disabled: true});
			$('#jqxChequeDate').jqxDateTimeInput({disabled: true});
			$("#jqxApplyBankInvoicing").jqxGrid({ disabled: true});
			$("#jqxBankPayment").jqxGrid({ disabled: true});
			$("#btnvaluechange").hide();
			
			 if(parseInt($("#pdcposttrno").val())!=0){
					 $("#btnEdit").attr('disabled', true);
					 $("#btnDelete").attr('disabled', true);
				 }
	 }
	 
	 function funRemoveReadOnly(){
		    checkpdc();
			$('#frmBankPayment input').attr('readonly', false );
			$('#frmBankPayment select').attr('disabled', false);
			$('#cmbfromcurrency').attr('disabled', true);
			$('#cmbtocurrency').attr('disabled', true);
			$('#txtfromaccid').attr('readonly', true );
			$('#txtfromaccname').attr('readonly', true );
			$('#txttoaccid').attr('readonly', true );
			$('#txttoaccname').attr('readonly', true );
			$('#txtapplyinvoiceamt').attr('readonly', true );
			$('#txtapplyinvoiceapply').attr('readonly', true );
			$('#txtapplyinvoicebalance').attr('readonly', true );
			$('#txtdrtotal').attr('readonly', true );
			$('#txtcrtotal').attr('readonly', true );
			$('#jqxBankPaymentDate').jqxDateTimeInput({disabled: false});
			$('#jqxChequeDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$("#jqxApplyBankInvoicing").jqxGrid({ disabled: false}); 
			$("#jqxBankPayment").jqxGrid({ disabled: false});
			
			var date = $('#jqxBankPaymentDate').val();
		    getCurrencyId(date);
		    
			if ($("#mode").val() == "E") {
         	    $("#btnvaluechange").show();
         	    $('#frmBankPayment input').attr('readonly', true );
   			    $('#frmBankPayment select').attr('disabled', true);
				$('#chckpdc').attr('disabled', true);
   			    $('#jqxChequeDate').jqxDateTimeInput({disabled: true});
   			    $("#jqxApplyBankInvoicing").jqxGrid({ disabled: true});
			    $("#jqxBankPayment").jqxGrid({ disabled: true});
   			    $('#txtrefno').attr('readonly', false );
   			    $('#txtdescription').attr('readonly', false );
   			    $("#jqxBankPayment").jqxGrid('addrow', null, {"docno": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","costtype": "","costgroup": "","costcode": "","dr": true,"amount1": "","baseamount1": "","description": "","grtype": "","currencytype": "","sr_no":""});
			  }
			 else{
				$("#btnvaluechange").hide();
			} 
			
			if ($("#mode").val() == "A") {
				$('#jqxBankPaymentDate').val(new Date());
				$('#jqxChequeDate').val(new Date());
				$('#chckpdc').attr('disabled', false);
				$("#jqxBankPayment").jqxGrid('clear'); 
				$("#jqxBankPayment").jqxGrid('addrow', null, {"docno": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","costtype": "","costgroup": "","costcode": "","dr": true,"amount1": "","baseamount1": "","description": "","grtype": "","currencytype": "","sr_no":""});
				$("#jqxApplyBankInvoicing").jqxGrid('clear');
				$("#jqxApplyBankInvoicing").jqxGrid('addrow', null, {});
			}
	 }
	 
	 function funSearchLoad(){
		changeContent('bpvMainSearch.jsp'); 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus()
	    {
	    	$('#jqxBankPaymentDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	  /* Validations */
	   $(function(){
	        $('#frmBankPayment').validate({
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
		  
		  var rows = $("#jqxApplyBankInvoicing").jqxGrid('getrows');
		  for(var i=0 ; i < rows.length ; i++){
		  //alert(rows[i].balance);
		  var balanceamt=rows[i].balance;
		  //alert(balanceamt);
		  if(balanceamt<0){
	        	//alert("BEFORE IF balanceamt==="+balanceamt)
	        	 document.getElementById("errormsg").innerText= "Invalid applying amount!!!";
				 return 0;
	        } 
		 	 				   }
		  
		    getChequeNoAlreadyExists($('#txtchequeno').val(),$('#txtfromdocno').val(),$("#mode").val(),$("#docno").val());
			
		    var bankpaydate = $('#jqxBankPaymentDate').jqxDateTimeInput('getDate');
			var validdate=funDateInPeriod(bankpaydate);
			if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
			}
			
			pdcchequevalid=document.getElementById("txtpdcdatevalidation").value;
			 if(pdcchequevalid==1){
				 document.getElementById("errormsg").innerText="Invalid Cheque Date !!!";
				 return 0;
			 }
			 
			 valid=document.getElementById("txtvalidation").value;
			 if(valid==1){
				 document.getElementById("errormsg").innerText="Invalid Transaction !!!";
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
	 		
	 		if(isNaN(crtot) || isNaN(drtot) || typeof(drtot)=="NaN" || typeof(crtot)=="NaN" || drtot=="" || crtot=="" || drtot=="NaN" || crtot=="NaN" || drtot=="0" || crtot=="0" || drtot=="0.0" || crtot=="0.0" || drtot=="0.00" || crtot=="0.00"){
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
	    	var balanceamt = $("#txtapplyinvoicebalance").val();  
	        if(parseInt(balanceamt)<0){
	        	 document.getElementById("errormsg").innerText= "Invalid applying amount!!!";
				 return 0;
	        }
	 		
	    		
	    /* Validation Ends*/
	    
	    	/* Bank Payment Grid  Saving*/
	  		  var rows = $("#jqxBankPayment").jqxGrid('getrows');
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
	  					if(rate=="" || rate=="0" || rate=="0.00" || isNaN(rate)){
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
							 baseamount=rows[i].baseamount1;
						}
						else if(rows[i].dr==false){
							 amount=rows[i].amount1*-1;
							 baseamount=rows[i].baseamount1*-1;
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
	  	 		   /* Bank Payment Grid  Saving Ends*/	 
	  	 		
	  	 		/* Applying Bank Invoice Grid Saving */
	  	         var rows = $("#jqxApplyBankInvoicing").jqxGrid('getrows');
		  	 	 var lengthapply=0,val2=0;
	  			 for(var i=0 ; i < rows.length ; i++){
	  					var applying = $("#jqxApplyBankInvoicing").jqxGrid('getcelltext',i,'applying');
		  				var tramt=rows[i].tramt;
		  				  
		  				if(typeof(applying) != "undefined" && typeof(applying) != "NaN" && applying != "" && applying != null){
	  					newTextBox = $(document.createElement("input"))
	  				    .attr("type", "dil")
	  				    .attr("id", "txtapply"+lengthapply)
	  				    .attr("name", "txtapply"+lengthapply)
	  				    .attr("hidden", "true");
	  					lengthapply=lengthapply+1;
	  					if((tramt-applying)<0){
		  					val2=1;
		  					break;
		  				}  
	  				 newTextBox.val(rows[i].applying+"::"+(parseFloat(rows[i].out_amount)+parseFloat(rows[i].applying))+"::"+rows[i].currency+"::"+rows[i].tranid+"::"+rows[i].acno); 
	  				newTextBox.appendTo('form');
	  				}
	  			  }
	  			 if(val2==1){   
	  				 document.getElementById("errormsg").innerText= "Invalid applying amount!!!";
					 return 0; 
	  			 } 
	  			 $('#applylength').val(lengthapply);
	  			 /* Applying Bank Invoice Grid Saving Ends*/
	  			 
	  			 /* Applying Bank Invoice Grid Updating */
	  		 		 var rows = $("#jqxApplyBankInvoicing").jqxGrid('getrows');
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
	  				 /* Applying Bank Invoice Grid Updating Ends*/
	  				 
	  				 $('#jqxBankPaymentDate').jqxDateTimeInput({disabled: false});
	  				 $('#jqxChequeDate').jqxDateTimeInput({disabled: false});
	  				
			         if ($("#mode").val() == "E") {
			        	 $('#frmBankPayment select').attr('disabled', false); 
			         }
			         $('#cmbfromcurrency').attr('disabled', false);
				     $('#cmbtocurrency').attr('disabled', false);
					 
				     document.getElementById("errormsg").innerText="";	 
	    		return 1;
		} 
	  
	  function setValues(){
		  checkpdc();
		  
		  $('#jqxBankPaymentDate').jqxDateTimeInput({disabled: false});
		  var date = $('#jqxBankPaymentDate').val();
		  getCurrencyId(date);
		  $('#jqxBankPaymentDate').jqxDateTimeInput({disabled: true});
		  
		  document.getElementById("cmbtotype").value=document.getElementById("hidcmbtotype").value;
		  
		  if($('#hidjqxBankPaymentDate').val()){
				 $("#jqxBankPaymentDate").jqxDateTimeInput('val', $('#hidjqxBankPaymentDate').val());
			  }
		  
		  if($('#hidjqxChequeDate').val()){
				 $("#jqxChequeDate").jqxDateTimeInput('val', $('#hidjqxChequeDate').val());
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
	         	 $("#jqxBankPaymentGrid").load("bankPaymentGrid.jsp?txtbankpaydocno2="+indexVal+"&check="+check);
			 }
	         
	         var indexVal1 = document.getElementById("txttodocno").value;
	         var indexVal2 = document.getElementById("txttotrno").value;
	         if(indexVal1>0){
	        	 var check = 1;
	         	 $("#bankApplyInvoicing1").load("applyBankInvoicingGrid.jsp?txttoaccid1="+indexVal1+"&txttotrno1="+indexVal2+"&check="+check); 
	         }
	         getBankReconciled($("#docno").val(), "BPV");    
	         
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
	
	  
	  function funwarningopen(){
		  $.messager.confirm('Confirm', 'Transaction will affect Links to the applied Bank Reconcilations & Prepayments.', function(r){
			    if (r){
			    	$("#mode").val("EDIT");
					 $('#txtfromaccid').attr('readonly', true);$('#txtfromaccname').attr('readonly', true);$('#txtfromamount').attr('readonly', false);$('#txtchequeno').attr('readonly', false);$('#chckpdc').attr('disabled', false);
					 $('#jqxChequeDate').jqxDateTimeInput({disabled: false});$('#txtdescription').attr('readonly', false);
					 $('#txttoaccid').attr('readonly', true);$('#txttoaccname').attr('readonly', true);$('#txttoamount').attr('readonly', false);$('#txtfromrate').attr('readonly', false);
				     $('#txtfrombaseamount').attr('readonly', true);$('#txttorate').attr('readonly', false);$('#txttobaseamount').attr('readonly', true);$('#txtapplyinvoiceamt').attr('readonly', true);
				     $('#txtapplyinvoiceapply').attr('readonly', true);$('#txtapplyinvoicebalance').attr('readonly', true);$('#txtdrtotal').attr('readonly', true);$('#txtcrtotal').attr('readonly', true);
				     $('#txtchequename').attr('readonly', false);$('#frmBankPayment select').attr('disabled', false);$("#jqxApplyBankInvoicing").jqxGrid({ disabled: false});$("#jqxBankPayment").jqxGrid({ disabled: false});  
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
	  
	  function getDrTotal(){
		  var toamount = $('#txttobaseamount').val();
		  
		  if(!isNaN(toamount)){
			  
		  var dr=0.0,cr=0.0,dr1=0.0;
  	      var rows = $('#jqxBankPayment').jqxGrid('getrows');
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
        	    var rows = $('#jqxBankPayment').jqxGrid('getrows');
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
		  	$('#txtfrombaseamount').val(0.00);
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
        	  var date = $('#jqxBankPaymentDate').jqxDateTimeInput('getDate');
        	  $("#maindate").jqxDateTimeInput('val', date);
        	  accountFromSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
          }
          else{}
          }
	  
	  function getAccType(event){
          var x= event.keyCode;
          if(x==114){
        	  var date = $('#jqxBankPaymentDate').jqxDateTimeInput('getDate');
        	  $("#maindate").jqxDateTimeInput('val', date);
        	  accountToSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtotype').val()+"&date="+date);
          }
          else{}
          }
	  
	  function funCheck(a){
		  if(document.getElementById("chckpdc").checked != false){
		 		 $('#hidchckpdc').val(1);getAccounts();
		  }
		  else{
			  $('#hidchckpdc').val(0);  
		  }
	  }
	  
	  function getAccounts(){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText;
	  			    $('#txtpdcacno').val(items);
	  		}
	  		}
	  		x.open("GET", "getAccounts.jsp", true);
	  		x.send();
	 }

 /* function funPrintBtn() {
			
		if (($("#mode").val() == "view") && $("#docno").val()!="") {
			BankPrintContent('printVoucherWindow.jsp');
		  }
		else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	      }	  */

	  function funPrintBtn() {
			
		if (($("#mode").val() == "view") && $("#docno").val()!="") {
			BankPrintContent('printVoucherWindow.jsp');
		  }
		else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	      }
	  
	  function clearClientInfo(){
		  $("#txttodocno").val('');$("#txttoaccid").val('');$("#txttoaccname").val('');$("#txtapplyinvoiceapply").val(0.00);
		  $("#jqxApplyBankInvoicing").jqxGrid('clear');
		  $("#jqxApplyBankInvoicing").jqxGrid('addrow', null, {});
		  var atype=$('#cmbtotype').val();
      	  if(atype != "AP"){
      		$("#jqxApplyBankInvoicing").jqxGrid({ disabled: true});
      	   }else if(atype == "AP"){
      		$("#jqxApplyBankInvoicing").jqxGrid({ disabled: false});
      	   }
	  }
	 
	  function datechange(){
		  var date = $('#jqxBankPaymentDate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(date);
		  if(parseInt(validdate)==0){
			document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
			return 0;	
		  }
		  $("#maindate").jqxDateTimeInput('val', date);
		  funPDCDate($('#hidchckpdc').val(),$('#jqxBankPaymentDate').jqxDateTimeInput('getDate'),$('#jqxChequeDate').jqxDateTimeInput('getDate'));
	  }
	  
	
</script>

<style>
.form-group {
    display: flex;
    align-items: center;
    gap: 20px;
    margin-bottom: 20px;
    width: 100%;
}

.form-group label {
    max-width: 120px;
    font-size: 15px;
    font-weight: 700;
    text-align: right;
    color: #1d2a4d;
}

/* INPUT / SELECT / TEXTBOX */
.form-group input[type="text"],
.form-group select {
    flex: 1;
    font-size: 18px;
    padding: 14px 20px;
    border-radius: 14px;
    border: 2px solid #b9c9e8;
    background: #ffffff;
    height: 40px;
    transition: 0.2s ease;
}

/* FOCUS + HOVER */
.form-group input[type="text"]:focus,
.form-group select:focus {
    border-color: #2f6dde !important;
    box-shadow: 0 0 10px rgba(47,109,222,0.4);
    outline: none;
}

fieldset {
    border-radius: 14px;
    border: 1px solid #c8d6ff;
    padding: 15px 18px;
    background: #ffffff;
    box-shadow: 0 6px 20px rgba(100,130,255,0.15);
    margin-bottom: 20px;
}
.payment-one-row {
    display: grid;
    grid-template-columns: 120px 150px 140px 1fr 1fr;
    gap: 20px;
    align-items: center;
    width: 100%;
}
/* =======================
   COMPACT FORM REFINEMENT
   ======================= */

/* Reduce overall height of form fields */
.section-block .form-group input[type="text"],
.section-block .form-group select,
.section-block .form-group textarea {
    font-size: 15px !important;
    padding: 8px 12px !important;
    height: 32px !important;
    border-radius: 10px !important;
}

/* Labels smaller & closer */
.section-block .form-group label {
    min-width: 100px !important;
    font-size: 15px !important;
    font-weight: 600 !important;
}

/* Dropdown text visible */
.section-block select {
    font-size: 15px !important;
    height: 42px !important;
    line-height: 2px !important;
}

/* Account ID and Cash row aligned */
.payment-one-row {
    display: grid;
    grid-template-columns: 100px 150px 120px 1fr 1fr;
    gap: 15px;
    align-items: center;
}

/* General layout narrower */
.section-block {
    padding: 8px !important;
}
/* Currency dropdown same size as in Cash section */
.compact-currency {
    width: 85% !important;
}
.compact-currency-payment{
width:83%;
}

.header-input {  
   height: 45px !important;
}




/* Amount box */
.compact-amount {
 width: 85% !important;}
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="hidden-scrollbar homeContent" data-type="background">

<form id="frmBankPayment" action="saveBankPayment" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<!-- ============================
     HEADER SECTION
=============================== -->
<div class="section-block" style="padding:20px;">
    <table width="100%">
        <tr class="form-group">
            <!-- DATE -->
            <td align="right"><label>Date</label></td>
            <td width="120px">
                <div id="jqxBankPaymentDate"
                     name="jqxBankPaymentDate"
                     onchange="datechange();"
                     onblur="datechange();"
                     value='<s:property value="jqxBankPaymentDate"/>'>
                </div>

                <input type="hidden" id="hidjqxBankPaymentDate"
                       name="hidjqxBankPaymentDate"
                       value='<s:property value="hidjqxBankPaymentDate"/>'/>
            </td>

            <td></td>

            <!-- REF NO -->
            <td align="right"><label>Ref. No.</label></td>
            <td>
                <input type="text" id="txtrefno" name="txtrefno"
                       style="width:60%;"
                       value='<s:property value="txtrefno"/>'/>
            </td>

            <!-- DOC NO -->
            <td align="right"><label>Doc No.</label></td>
            <td>
                <input type="text" id="docno" name="txtbankpaydocno"
                       style="width:60%;"
                       tabindex="-1"
                       value='<s:property value="txtbankpaydocno"/>'/>
            </td>

            <!-- BUTTON IN NEW COLUMN -->
            <td width="120px" align="left" >
                <button class="myButton header-input" type="button" onclick="funwarningopen();">
                    Value Change
                </button>
            </td>
        </tr>
    </table>
</div>



<!-- ============================
     BANK SECTION
=============================== -->
<div class="section-block">
    <h2>Bank</h2>

    <!-- BANK ID + NAME -->
    <div class="form-group">
        <label>Bank</label>
        <input type="text" id="txtfromaccid" name="txtfromaccid"
               placeholder="Press F3 to Search"
               value='<s:property value="txtfromaccid"/>' 
               onkeydown="getAcc(event);">

        <input type="text" id="txtfromaccname" name="txtfromaccname"
               value='<s:property value="txtfromaccname"/>' tabindex="-1">

        <input type="hidden" id="txtfromdocno" name="txtfromdocno"
               value='<s:property value="txtfromdocno"/>'>
    </div>

    <!-- CURRENCY + RATE -->
    <div class="form-group compact-currency">
        <label>Currency</label>
        <select id="cmbfromcurrency" name="cmbfromcurrency"
                onchange="getRate(this.value,$('#jqxBankReceiptDate').val());">
            <option></option>
        </select>

        <input type="hidden" id="hidcmbfromcurrency" name="hidcmbfromcurrency"
               value='<s:property value="hidcmbfromcurrency"/>'>
        <input type="hidden" id="hidfromcurrencytype" name="hidfromcurrencytype"
               value='<s:property value="hidfromcurrencytype"/>'>

        <label style="margin-left:20px;">Rate</label>
        <input type="text" id="txtfromrate" name="txtfromrate"
               value='<s:property value="txtfromrate"/>' tabindex="-1"
               onchange="funvalid()"
               onblur="funRoundRate(this.value,this.id);getBaseAmountFrom();getDrTotal();"
               style="max-width:140px;">
    </div>

    <!-- BANK NAME + PDC CHECKBOX -->
    <div class="form-group">
        <label>Bank Name</label>
        <input type="text" id="txtbankname" name="txtbankname"
               value='<s:property value="txtbankname"/>' style="max-width:40%;">

        <input type="checkbox" id="chckpdc" name="chckpdc"
               onclick="funCheck();funPDCDate($('#hidchckpdc').val(),
                       $('#jqxBankReceiptDate').jqxDateTimeInput('getDate'),
                       $('#jqxChequeDate').jqxDateTimeInput('getDate'));">

        <span>PDC</span>

        <input type="hidden" id="hidchckpdc" name="hidchckpdc"
               value='<s:property value="hidchckpdc"/>'>
        <input type="hidden" id="txtpdcacno" name="txtpdcacno"
               value='<s:property value="txtpdcacno"/>'>
    </div>

    <!-- CHEQUE NO + CHEQUE DATE -->
    <div class="form-group">
        <label>Cheque No.</label>
        <input type="text" id="txtchequeno" name="txtchequeno"
               value='<s:property value="txtchequeno"/>' style="max-width:40%;"
               onblur="getChequeNoAlreadyExists(this.value,$('#txtfromdocno').val(),$('#mode').val(),$('#docno').val());">

        <label style="margin-left:20px;">Cheque Date</label>
        <div id="jqxChequeDate" name="jqxChequeDate"
             onchange="funPDCDate($('#hidchckpdc').val(),
                       $('#jqxBankReceiptDate').jqxDateTimeInput('getDate'),
                       $('#jqxChequeDate').jqxDateTimeInput('getDate'));" 
             value='<s:property value="jqxChequeDate"/>'>
        </div>

        <input type="hidden" id="hidjqxChequeDate" name="hidjqxChequeDate"
               value='<s:property value="hidjqxChequeDate"/>'>
    </div>

    <!-- AMOUNT + BASE AMOUNT -->
    <div class="form-group compact-amount">
        <label>Amount</label>
        <input type="text" id="txtfromamount" name="txtfromamount"
               value='<s:property value="txtfromamount"/>' 
               onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getDrTotal();">

        <label>Base Amount</label>
        <input type="text" id="txtfrombaseamount" name="txtfrombaseamount"
               value='<s:property value="txtfrombaseamount"/>' tabindex="-1"
               style="max-width:150px;">
    </div>

    <!-- DESCRIPTION -->
    <div class="form-group">
        <label>Description</label>
        <input type="text" id="txtdescription" name="txtdescription"
               value='<s:property value="txtdescription"/>'>
    </div>

</div>



<!-- ============================
     PAYMENT FROM SECTION
=============================== -->
<div class="section-block">
    <h2>Payment From</h2>

    <div class="form-group payment-one-row">
        <label>Type</label>
        <select id="cmbtotype" name="cmbtotype" onchange="clearClientInfo();">
            <option value="AP" <s:if test="cmbtotype == 'AP'">selected</s:if>>AP</option>
            <option value="AR" <s:if test="cmbtotype == 'AR'">selected</s:if>>AR</option>
        </select>
        <input type="hidden" id="hidcmbtotype" name="hidcmbtotype"
               value='<s:property value="hidcmbtotype"/>'>

        <label>Account ID</label>
        <input type="text" id="txttoaccid" name="txttoaccid"
               placeholder="Press F3 to Search"
               value='<s:property value="txttoaccid"/>'
               onkeydown="getAccType(event);">

        <input type="text" id="txttoaccname" name="txttoaccname"
               value='<s:property value="txttoaccname"/>' tabindex="-1">

        <input type="hidden" id="txttodocno" name="txttodocno"
               value='<s:property value="txttodocno"/>'>
        <input type="hidden" id="txttotranid" name="txttotranid"
               value='<s:property value="txttotranid"/>'>
        <input type="hidden" id="txttotrno" name="txttotrno"
               value='<s:property value="txttotrno"/>'>
    </div>

    <div class="form-group compact-currency-payment">
        <label>Currency</label>
        <select id="cmbtocurrency" name="cmbtocurrency"
                onchange="getRatevalue(this.value,$('#jqxBankPaymentDate').val());">
            <option></option>
        </select>

        <input type="hidden" id="hidcmbtocurrency" name="hidcmbtocurrency"
               value='<s:property value="hidcmbtocurrency"/>'>
        <input type="hidden" id="hidtocurrencytype" name="hidtocurrencytype"
               value='<s:property value="hidtocurrencytype"/>'>

        <label>Rate</label>
        <input type="text" id="txttorate" name="txttorate"
               onchange="funvalid1()"
               onblur="funRoundRate(this.value,this.id);getBaseAmountTo();getDrTotal();"
               tabindex="-1"
               value='<s:property value="txttorate"/>' style="max-width:150px;">
    </div>

    <div class="form-group compact-amount">
        <label>Amount</label>
        <input type="text" id="txttoamount" name="txttoamount"
               value='<s:property value="txttoamount"/>'
               onblur="funRoundAmt(this.value,this.id);getBaseAmountTo();getDrTotal();getAmount();"
               onfocus="this.oldvalue=this.value;"
               onchange="funPaymentAmount(this);this.oldvalue=this.value;">

        <label>Base Amount</label>
        <input type="text" id="txttobaseamount" name="txttobaseamount"
               tabindex="-1"
               value='<s:property value="txttobaseamount"/>' style="max-width:150px;">
    </div>

</div>


<!-- ============================
     APPLY INVOICES
=============================== -->
<div class="section-block">
    <h3>Apply Invoices</h3>

    <div id="bankApplyInvoicing1">
        <center><jsp:include page="applyBankInvoicingGrid.jsp"></jsp:include></center>
    </div>

    <div class="form-group compact-amount">
        <label>Amount</label>
        <input type="text" id="txtapplyinvoiceamt" name="txtapplyinvoiceamt"
               value='<s:property value="txtapplyinvoiceamt"/>'
               style="width:25%;text-align:right;">
        <input type="hidden" id="txtvalidation" name="txtvalidation"
               value='<s:property value="txtvalidation"/>'>

        <label>Applied</label>
        <input type="text" id="txtapplyinvoiceapply" name="txtapplyinvoiceapply"
               value='<s:property value="txtapplyinvoiceapply"/>' tabindex="-1"
               style="width:25%;text-align:right;">

        <label>Balance</label>
        <input type="text" id="txtapplyinvoicebalance" name="txtapplyinvoicebalance"
               value='<s:property value="txtapplyinvoicebalance"/>' tabindex="-1"
               style="width:25%;text-align:right;">
    </div>
</div>


<!-- ============================
     MAIN GRID
=============================== -->
<div class="section-block">
    <div id="jqxBankPaymentGrid"><jsp:include page="bankPaymentGrid.jsp"></jsp:include></div>

    <div class="form-group compact-amount">
        <label>Dr. Total</label>
        <input type="text" id="txtdrtotal" name="txtdrtotal"
               value='<s:property value="txtdrtotal"/>' style="width:25%;text-align:right;">

        <label>Cr. Total</label>
        <input type="text" id="txtcrtotal" name="txtcrtotal"
               value='<s:property value="txtcrtotal"/>' tabindex="-1"
               style="width:25%;text-align:right;">
    </div>
</div>


<!-- ============================
     HIDDEN FIELDS
=============================== -->
<input type="hidden" id="mode" name="mode">
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'>
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
<input type="hidden" name="txtforsearch" id="txtforsearch" value="0">
<input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'>
<input type="hidden" id="txtpdcdatevalidation" name="txtpdcdatevalidation"
       value='<s:property value="txtpdcdatevalidation"/>'>
<input type="hidden" id="gridlength" name="gridlength">
<input type="hidden" id="applylength" name="applylength">
<input type="hidden" id="applylengthupdate" name="applylengthupdate">
<input type="hidden" id="pdcposttrno" name="pdcposttrno"
       value='<s:property value="pdcposttrno"/>'>

</form>


<!-- ============================
     POPUPS (UNCHANGED)
=============================== -->
<div id="bankPaymentGridWindow"><div></div><div></div></div>
<div id="accountDetailsFromWindow"><div></div><div></div></div>
<div id="accountDetailsToWindow"><div></div><div></div></div>
<div id="costTypeSearchGridWindow"><div></div><div></div></div>
<div id="costCodeSearchWindow"><div></div><div></div></div>
<div id="printWindow"><div></div><div></div></div>

</div>
</body>

</html>
