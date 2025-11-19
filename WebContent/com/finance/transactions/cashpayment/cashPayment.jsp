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

<script type="text/javascript">
	$(document).ready(function() {
		 $("#btnvaluechange").hide();
		
		 $("#jqxCashPaymentDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsToWindow').jqxWindow('close');  
		 
		 $('#accountDetailsFromWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsFromWindow').jqxWindow('close');
		 
		 $('#cashPaymentGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#cashPaymentGridWindow').jqxWindow('close');
		 
		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#costTypeSearchGridWindow').jqxWindow('close');
 		 
 		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
		 
		 $('#jqxCashPaymentDate').on('change', function (event) {
				var paydate = $('#jqxCashPaymentDate').jqxDateTimeInput('getDate');
				var validdate=funDateInPeriod(paydate);
				if(parseInt(validdate)==0){
					document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
					return 0;	
				}
			 });
		 
		 $('#txttoamount').keydown(function (evt) {
			  if (evt.keyCode==9) {
			          event.preventDefault();
			          $('#jqxApplyInvoicing').jqxGrid('selectcell',0, 'applying');
			          $('#jqxApplyInvoicing').jqxGrid('focus',0, 'applying');
			  }
		 });
		 
		 $('#txtfromaccid').dblclick(function(){
			  var date = $('#jqxCashPaymentDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
        	  accountFromSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
			  });
		 
		  $('#txttoaccid').dblclick(function(){
			  var date = $('#jqxCashPaymentDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
        	  accountToSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtotype').val()+"&date="+date);
			  }); 
	});
	
	function CashSearchContent(url) {
		$('#cashPaymentGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#cashPaymentGridWindow').jqxWindow('setContent', data);
		$('#cashPaymentGridWindow').jqxWindow('bringToFront');
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
					 $('#frmCashPayment select').attr('disabled', false);$("#jqxApplyInvoicing").jqxGrid({ disabled: false});$("#jqxCashPayment").jqxGrid({ disabled: false});  
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
			$('#frmCashPayment input').attr('readonly', true );
			$('#frmCashPayment select').attr('disabled', true);
			$('#jqxCashPaymentDate').jqxDateTimeInput({disabled: true});
			$("#jqxApplyInvoicing").jqxGrid({ disabled: true});
			$("#jqxCashPayment").jqxGrid({ disabled: true});
			$("#btnvaluechange").hide();
	 }
	 function funRemoveReadOnly(){
			$('#frmCashPayment input').attr('readonly', false );
			$('#frmCashPayment select').attr('disabled', false);
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
			$('#jqxCashPaymentDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$("#jqxApplyInvoicing").jqxGrid({ disabled: false}); 
			$("#jqxCashPayment").jqxGrid({ disabled: false});
			
			var date = $('#jqxCashPaymentDate').val();
		    getCurrencyId(date);
		    
			if ($("#mode").val() == "E") {
         	    $("#btnvaluechange").show();
         	    $('#frmCashPayment input').attr('readonly', true );
   			    $('#frmCashPayment select').attr('disabled', true);
   			    $("#jqxApplyInvoicing").jqxGrid({ disabled: true});
			    $("#jqxCashPayment").jqxGrid({ disabled: true});
   			    $('#txtrefno').attr('readonly', false );
   			    $('#txtdescription').attr('readonly', false );
   			    $("#jqxCashPayment").jqxGrid('addrow', null, {"docno": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","costtype": "","costgroup": "","costcode": "","dr": true,"amount1": "","baseamount1": "","description": "","grtype": "","currencytype": "","sr_no":""});
			  }
			 else{
				$("#btnvaluechange").hide();
			} 
			
			if ($("#mode").val() == "A") {
				$('#jqxCashPaymentDate').val(new Date());
				$("#jqxCashPayment").jqxGrid('clear'); 
				$("#jqxCashPayment").jqxGrid('addrow', null, {"docno": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","costtype": "","costgroup": "","costcode": "","dr": true,"amount1": "","baseamount1": "","description": "","grtype": "","currencytype": "","sr_no":""});
				$("#jqxApplyInvoicing").jqxGrid('clear');
				$("#jqxApplyInvoicing").jqxGrid('addrow', null, {});
			}
			
	 }
	 
	 function funSearchLoad(){
		changeContent('cpvMainSearch.jsp'); 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#jqxCashPaymentDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	   $(function(){
	        $('#frmCashPayment').validate({
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
		  var rows = $("#jqxApplyInvoicing").jqxGrid('getrows');
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
		    var paydate = $('#jqxCashPaymentDate').jqxDateTimeInput('getDate');
			var validdate=funDateInPeriod(paydate);
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
				 document.getElementById("errormsg").innerText="Enter Cash.";
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
			 var balanceamt = $("#txtapplyinvoicebalance").val();  
		        if(parseInt(balanceamt)<0){
		        	 document.getElementById("errormsg").innerText= "Invalid applying amount!!!";
					 return 0;
		        }
		 		
	    /* Validation Ends*/
	    		
	     /* Cash Payment Grid  Saving*/
				 var rows = $("#jqxCashPayment").jqxGrid('getrows');
				 var length=0,val=0,valid=0;
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
	 		   /* Cash Payment Grid  Saving Ends*/	 
	 		
	 		/* Applying Invoice Grid Saving */
	 		 var rows = $("#jqxApplyInvoicing").jqxGrid('getrows');
	 		var lengthapply=0,val2=0; 
			 for(var i=0 ; i < rows.length ; i++){
				    var chks= $("#jqxApplyInvoicing").jqxGrid('getcelltext',i,'applying');
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
				newTextBox.val(rows[i].applying+"::"+(parseFloat(rows[i].out_amount)+parseFloat(rows[i].applying))+"::"+rows[i].currency+"::"+rows[i].tranid+"::"+rows[i].acno);
				newTextBox.appendTo('form');
				}
			 }
			 if(val2==1){   
  				 document.getElementById("errormsg").innerText= "Invalid applying amount!!!";
				 return 0; 
  			 } 
			 //alert("val2==="+val2);
			 $('#applylength').val(lengthapply);
			 /* Applying Invoice Grid Saving Ends*/
			 
			 /* Applying Invoice Grid Updating */
		 		 var rows = $("#jqxApplyInvoicing").jqxGrid('getrows');
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
			        	 $('#frmCashPayment select').attr('disabled', false); 
			      }
				 $('#cmbfromcurrency').attr('disabled', false);
				  $('#cmbtocurrency').attr('disabled', false);
				  document.getElementById("errormsg").innerText="";
	    		return 1;
		} 
	  
	  
	  function setValues(){
		  $('#jqxCashPaymentDate').jqxDateTimeInput({disabled: false});
		  var date = $('#jqxCashPaymentDate').val();
		  getCurrencyId(date);
		  $('#jqxCashPaymentDate').jqxDateTimeInput({disabled: true});
		  
		  document.getElementById("cmbtotype").value=document.getElementById("hidcmbtotype").value;
		  
		  if($('#hidjqxCashPaymentDate').val()){
				 $("#jqxCashPaymentDate").jqxDateTimeInput('val', $('#hidjqxCashPaymentDate').val());
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
	         	 $("#jqxCashPaymentGrid").load("cashPaymentGrid.jsp?txtcashpaydocno2="+indexVal+"&check="+check);
			 }
	         
			 var indexVal1 = document.getElementById("txttodocno").value;
	         var indexVal2 = document.getElementById("txttotrno").value;
	         if(indexVal1>0){
	        	var check=1;
	         	$("#jqxApplyInvoicing1").load("applyInvoicingGrid.jsp?txttoaccid1="+indexVal1+"&txttotrno1="+indexVal2+"&check="+check); 
	         } 
	         
	        if(parseFloat($("#hidstatus").val())<3){
					$("#txtStatus").html("DRAFT");
			}else if(parseFloat($("#hidstatus").val())==4){
					$("#txtStatus").html("REJECTED");
			}else{
					$("#txtStatus").html("");
			}
	        getBankReconciled($("#docno").val(), "CPV");  
	        
	        funRoundRate($('#txtfromrate').val(),"txtfromrate");
	        funRoundRate($('#txttorate').val(),"txttorate");
			funRoundAmt($('#txtfromamount').val(),"txtfromamount");
			funRoundAmt($('#txttoamount').val(),"txttoamount");
	        funRoundAmt($('#txtfrombaseamount').val(),"txtfrombaseamount");
			funRoundAmt($('#txttobaseamount').val(),"txttobaseamount");
	        funRoundAmt($('#txtapplyinvoiceapply').val(),"txtapplyinvoiceapply");
			funRoundAmt($('#txtapplyinvoicebalance').val(),"txtapplyinvoicebalance");
	        funRoundAmt($('#txtapplyinvoiceamt').val(),"txtapplyinvoiceamt");
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
		  var toamount = $('#txttobaseamount').val();
		  
		  if(!isNaN(toamount)){
			  
		  var dr=0.0,cr=0.0,dr1=0.0;
  	      var rows = $('#jqxCashPayment').jqxGrid('getrows');
	      var rowlength= rows.length;
	  		for(var i=0;i<=rowlength-1;i++) {
	  			
	  		  var value = rows[i].dr;
	          var baseamount = rows[i].baseamount1;
	          
	          //alert(baseamount+"===="+value);
	  		  
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
        	    var rows = $('#jqxCashPayment').jqxGrid('getrows');
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
        	  var date = $('#jqxCashPaymentDate').jqxDateTimeInput('getDate');
        	  $("#maindate").jqxDateTimeInput('val', date);
        	  accountFromSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
          }
          else{
           }
          }
	  
	  function getAccType(event){
          var x= event.keyCode;
          if(x==114){
        	  var date = $('#jqxCashPaymentDate').jqxDateTimeInput('getDate');
        	  $("#maindate").jqxDateTimeInput('val', date);
        	  accountToSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtotype').val()+"&date="+date);
          }
          else{
           }
          }
	  
	  function funPrintBtn() {
				
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
				
				 var url=document.URL;
			     var reurl=url.split("saveCashPayment");
			     $("#docno").prop("disabled", false);
				
					   $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
						if (r){
							 var win= window.open(reurl[0]+"printCashPayment?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
						     win.focus();
						 }
						else{
							var win= window.open(reurl[0]+"printCashPayment?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
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
		  $("#txttodocno").val('');$("#txttoaccid").val('');$("#txttoaccname").val('');$("#txtapplyinvoiceapply").val(0.00);
		  $("#jqxApplyInvoicing").jqxGrid('clear');
		  $("#jqxApplyInvoicing").jqxGrid('addrow', null, {});
		  var atype=$('#cmbtotype').val();
      	  if(atype != "AP"){
      		$("#jqxApplyInvoicing").jqxGrid({ disabled: true});
      	   }else if(atype == "AP"){
      		$("#jqxApplyInvoicing").jqxGrid({ disabled: false});
      	   }
	  }
	  
	  function datechange(){
		  var date = $('#jqxCashPaymentDate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(date);
		  if(parseInt(validdate)==0){
			document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
			return 0;	
		  }
		  $("#maindate").jqxDateTimeInput('val', date);
	  }
	  
</script>

<style>
/* =========================================
   Professional Blue UI Theme (Enlarged Fields with Blue Box-Shadows)
   ========================================= */

/* Scrollable container */
.hidden-scrollbar {
    overflow: auto;
    height: 530px;
}

/* Validation messages */
#validrate,
#validrate1 {
    color: #e74c3c; /* Professional red for error visibility */
    font-size: 1em; /* Slightly larger text */
    margin-left: 5px;
    font-weight: 600;
}

/* ===== Global Page Styling ===== */
body {
    /* Subtle blue gradient background */
    background: linear-gradient(135deg, #e0f7fa 0%, #b3e5fc 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #2c3e50;
    margin: 0;
    padding: 32px 0;
    min-height: 100vh;
    box-sizing: border-box;
}

/* ===== Main Container (mainBG) ===== */
#mainBG {
    background: #ffffff;
    border-radius: 12px;
    /* Added blue box-shadow */
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15), 0 0 0 3px rgba(52, 152, 219, 0.2); /* Stronger overall shadow with blue tint */
    padding: 24px;
    max-width: 1250px;
    margin: 0 auto;
}

/* ===== Header Section (Date, Doc No) ===== */
.receipt-header {
    display: block;
    margin-bottom: 24px;
    padding: 10px 0;
    border-bottom: 2px solid #3498db;
}

.receipt-header table {
    width: 100%;
    border-collapse: collapse;
}
.receipt-header td {
    padding: 8px 0;
    font-size: 1em;
    color: #2c3e50;
    font-weight: 500;
}
/* Ensure jqxDateTimeInput integrates visually */
.receipt-header div.jqx-datetimeinput {
    border: 1px solid #bdc3c7 !important;
    border-radius: 6px !important;
    background: #fdfdfd !important;
    height: 28px !important;
    box-shadow: 0 1px 3px rgba(52, 152, 219, 0.1); /* Subtle blue shadow */
}

/* Header Inputs */
.receipt-header input[type="text"] {
    border: 1px solid #bdc3c7;
    border-radius: 6px;
    padding: 8px 12px;
    background: #fdfdfd;
    transition: border-color 0.2s, box-shadow 0.2s; /* Added box-shadow to transition */
    font-size: 1em;
    box-shadow: 0 1px 3px rgba(52, 152, 219, 0.1); /* Subtle blue shadow */
}
.receipt-header input[type="text"]:focus {
    border-color: #3498db;
    box-shadow: 0 0 8px rgba(52, 152, 219, 0.6); /* More prominent blue shadow on focus */
    outline: none;
}

/* Header Button (Value Change) */
.myButton {
    background: #3498db;
    color: #fff;
    border: none;
    border-radius: 6px;
    padding: 8px 18px;
    font-weight: 600;
    cursor: pointer;
    transition: background 0.3s ease, transform 0.1s, box-shadow 0.2s; /* Added box-shadow to transition */
    box-shadow: 0 3px 8px rgba(52, 152, 219, 0.25); /* Blue shadow for button */
}
.myButton:hover {
    background: #2980b9;
    transform: translateY(-1px);
    box-shadow: 0 5px 12px rgba(52, 152, 219, 0.4); /* More prominent blue shadow on hover */
}
.myButton:active {
    transform: translateY(0);
}

/* Status Tag */
#txtStatus {
    font-size: 1.1rem;
    font-weight: 700;
    color: #e67e22;
    background: #fef9e7;
    padding: 6px 12px;
    border-radius: 6px;
    display: inline-block;
    box-shadow: 0 1px 4px rgba(52, 152, 219, 0.15); /* Subtle blue shadow for status tag */
}

/* ===== Main Form Section Layouts (Cash and Payment From) ===== */
.section-row {
    display: flex;
    gap: 24px;
    margin-bottom: 24px;
    flex-wrap: wrap;
}
.section-block {
    flex: 1;
    background: #f8faff;
    border-radius: 10px;
    padding: 25px 28px;
    /* Added blue box-shadow */
    box-shadow: 0 1px 8px rgba(52, 152, 219, 0.1), 0 0 0 1px rgba(52, 152, 219, 0.08); /* Subtle blue border-like shadow */
    border: 1px solid #d1d5db; /* Keep the subtle border */
    transition: box-shadow 0.3s ease;
}
.section-block:hover {
    box-shadow: 0 2px 10px rgba(52, 152, 219, 0.2), 0 0 0 2px rgba(52, 152, 219, 0.15); /* More prominent blue shadow on hover */
}

/* Section Headings */
.section-block h2 {
    font-size: 1.2em;
    font-weight: 600;
    margin: 0 0 20px 0;
    color: #3498db;
    border-bottom: 1px solid #d1d5db;
    padding-bottom: 8px;
}

/* Form Groups (input rows) */
.form-group {
    display: flex;
    align-items: center;
    gap: 15px;
    margin-bottom: 12px;
}

/* Labels */
.section-block label {
    font-weight: 500;
    color: #2c3e50;
    white-space: nowrap;
}

/* Inputs & Selects within sections */
.section-block input[type="text"],
.section-block select {
    flex: 1;
    border: 1px solid #bdc3c7;
    border-radius: 6px;
    padding: 10px 14px;
    background: #fff;
    color: #333;
    transition: border-color 0.25s ease, box-shadow 0.25s ease; /* Added box-shadow to transition */
    font-size: 1em;
    box-sizing: border-box;
    width: auto !important;
    box-shadow: 0 1px 3px rgba(52, 152, 219, 0.1); /* Subtle blue shadow */
}

.section-block input[type="text"]:focus,
.section-block select:focus {
    border-color: #3498db;
    box-shadow: 0 0 8px rgba(52, 152, 219, 0.6); /* More prominent blue shadow on focus */
    outline: none;
}

/* Readonly & Disabled */
input[readonly],
select:disabled {
    background-color: #ecf0f1 !important;
    color: #777;
    cursor: not-allowed;
    box-shadow: none !important; /* Remove shadow for disabled elements */
}

/* ===== Apply Invoices / Footer ===== */
fieldset {
    border: 1px solid #d1d5db;
    border-radius: 10px;
    padding: 20px;
    margin-bottom: 24px;
    background: #ffffff;
    box-shadow: 0 1px 8px rgba(52, 152, 219, 0.1); /* Subtle blue shadow for fieldset */
    transition: box-shadow 0.3s ease;
}
fieldset:hover {
    box-shadow: 0 2px 10px rgba(52, 152, 219, 0.2); /* More prominent blue shadow on hover */
}

legend {
    font-size: 1.1em;
    font-weight: 600;
    color: #3498db;
    padding: 0 10px;
}
.table-section h3 {
    color: #3498db;
    font-size: 1.1em;
    font-weight: 600;
    border-bottom: 1px dashed #d1d5db;
    padding-bottom: 5px;
    margin-bottom: 15px;
}

/* Invoices Table Cells/Rows - Applying the same visual standard */
.cr-table th, .cr-table td {
    padding: 12px 14px;
    font-size: 0.95em;
    border-bottom: 1px solid #e0e6ec; /* Lighter border for table rows */
}
.cr-table th {
    background: #eaf3f8; /* Light blue background for table headers */
    color: #2c3e50;
    box-shadow: 0 1px 3px rgba(52, 152, 219, 0.08); /* Subtle blue shadow for table header */
}
.cr-table td input[type="text"] {
    box-shadow: none; /* Remove individual shadow from inputs within table for cleaner look */
}


/* Totals Row */
#txtdrtotal, #txtcrtotal {
    font-weight: 700;
    background-color: #eaf3f8;
    border: 1px solid #3498db;
    color: #2c3e50;
    padding: 10px 14px;
    font-size: 1.05em;
    width: 20% !important;
    box-shadow: 0 2px 5px rgba(52, 152, 219, 0.2); /* Stronger blue shadow for totals */
}
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmCashPayment" action="saveCashPayment" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div  class='hidden-scrollbar receipt-header'>
<table width="100%">
  <tr>
    <td width="3%" height="42" align="right">Date</td>
    <td width="11%"><div id="jqxCashPaymentDate" name="jqxCashPaymentDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxCashPaymentDate"/>'></div>
    <input type="hidden" id="hidjqxCashPaymentDate" name="hidjqxCashPaymentDate" value='<s:property value="hidjqxCashPaymentDate"/>'/></td>
    <td width="21%" align="left">&nbsp;</td>
    <td width="9%" align="right">Ref. No.</td>
    <td width="29%"><input type="text" id="txtrefno" name="txtrefno" style="width:40%;" value='<s:property value="txtrefno"/>'/></td>
    <td width="6%" align="right">Doc No.</td>
    <td width="21%"><input type="text" id="docno" name="txtcashpaydocno" style="width:50%;" value='<s:property value="txtcashpaydocno"/>' tabindex="-1"/>
    <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button></td>
  </tr>
  <tr>
    <td colspan="6"></td>
    <td><span id="txtStatus"></span></td>
  </tr>
</table>

    <div class="section-row">
        <!-- Cash Section -->
        <div class="section-block">
            <h2>Cash</h2>
            <div class="form-group" style="margin-bottom: 10px;">
                <label for="txtfromaccid">Cash</label>
                <input type="text" id="txtfromaccid" name="txtfromaccid" style="width:70%;" placeholder="Press F3 to Search" value='<s:property value="txtfromaccid"/>'  onkeydown="getAcc(event);"/>
                <input type="text" id="txtfromaccname" name="txtfromaccname" style="width:54%;" value='<s:property value="txtfromaccname"/>' tabindex="-1" />
                <input type="hidden" id="txtfromdocno" name="txtfromdocno" value='<s:property value="txtfromdocno"/>' />
            </div>
            <div class="form-group" style="margin-bottom: 10px;">
                <label for="cmbfromcurrency">Currency</label>
                <select id="cmbfromcurrency" name="cmbfromcurrency" style="width:71%;" value='<s:property value="cmbfromcurrency"/>' onload="getRate(this.value,$('#jqxCashPaymentDate').val());" onchange="getRate(this.value,$('#jqxCashPaymentDate').val());">
                    <option></option></select>
                <input type="hidden" id="hidcmbfromcurrency" name="hidcmbfromcurrency" value='<s:property value="hidcmbfromcurrency"/>' />
                <input type="hidden" id="hidfromcurrencytype" name="hidfromcurrencytype" value='<s:property value="hidfromcurrencytype"/>' />
                <label for="txtfromrate" style="margin-left: 18px;">Rate</label>
                <input type="text" id="txtfromrate" name="txtfromrate" onchange="funvalid()" style="width:32%;text-align: right;" value='<s:property value="txtfromrate"/>' onblur="funRoundRate(this.value,this.id);getBaseAmountFrom();getDrTotal();" tabindex="-1" />
                <span id="validrate"></span>
            </div>
            <div class="form-group" style="margin-bottom: 10px;">
                <label for="txtfromamount">Amount</label>
                <input type="text" id="txtfromamount" name="txtfromamount" style="width:70%;text-align: right;" value='<s:property value="txtfromamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getCrTotal();" />
                <label for="txtfrombaseamount" style="margin-left: 18px;">Base Amount</label>
                <input type="text" id="txtfrombaseamount" name="txtfrombaseamount" style="width:32%;text-align: right;" value='<s:property value="txtfrombaseamount"/>' tabindex="-1"/>
            </div>
            <div class="form-group">
                <label for="txtdescription">Description</label>
                <input type="text" id="txtdescription" name="txtdescription" style="width:65%;" value='<s:property value="txtdescription"/>'/>
            </div>
        </div>

        <!-- Payment From Section -->
        <div class="section-block">
            <h2>Payment From</h2>
            <div class="form-group" style="margin-bottom: 10px;">
                <label for="cmbtotype">Type</label>
                <select id="cmbtotype" name="cmbtotype" style="width:90%;" onchange="clearClientInfo();" value='<s:property value="cmbtotype"/>'>
                    <option value="AP">AP</option><option value="AR">AR</option></select>
                <input type="hidden" id="hidcmbtotype" name="hidcmbtotype" value='<s:property value="hidcmbtotype"/>'/>
                <label for="txttoaccid" style="margin-left: 18px;">Account ID</label>
                <input type="text" id="txttoaccid" name="txttoaccid" style="width:80%;" placeholder="Press F3 to Search" value='<s:property value="txttoaccid"/>' onkeydown="getAccType(event);"/>
                <input type="text" id="txttoaccname" name="txttoaccname" style="width:53%;" value='<s:property value="txttoaccname"/>' tabindex="-1"/>
                <input type="hidden" id="txttodocno" name="txttodocno" value='<s:property value="txttodocno"/>'/>
                <input type="hidden" id="txttotranid" name="txttotranid" value='<s:property value="txttotranid"/>'/>
                <input type="hidden" id="txttotrno" name="txttotrno" value='<s:property value="txttotrno"/>'/>
            </div>
            <div class="form-group" style="margin-bottom: 10px;">
                <label for="cmbtocurrency">Currency</label>
                <select id="cmbtocurrency" name="cmbtocurrency" style="width:50%;" value='<s:property value="cmbtocurrency"/>' onload="getRatevalue(this.value,$('#jqxCashPaymentDate').val());" onchange="getRatevalue(this.value,$('#jqxCashPaymentDate').val());">
                    <option></option></select>
                <input type="hidden" id="hidcmbtocurrency" name="hidcmbtocurrency" value='<s:property value="hidcmbtocurrency"/>'/>
                <input type="hidden" id="hidtocurrencytype" name="hidtocurrencytype" value='<s:property value="hidtocurrencytype"/>'/>
                <label for="txttorate" style="margin-left: 18px;">Rate</label>
                <input type="text" id="txttorate" name="txttorate" onchange="funvalid1()" style="width:30%;text-align: right;" value='<s:property value="txttorate"/>' onblur="funRoundRate(this.value,this.id);getBaseAmountTo();getDrTotal();" tabindex="-1"/>
                <span id="validrate1"></span>
            </div>
            <div class="form-group" style="margin-bottom: 10px;">
                <label for="txttoamount">Amount</label>
                <input type="text" id="txttoamount" name="txttoamount" style="width:50%;text-align: right;" value='<s:property value="txttoamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountTo();getDrTotal();getAmount();" onfocus="this.oldvalue = this.value;" onchange="funPaymentAmount(this);this.oldvalue = this.value;" />
                <label for="txttobaseamount" style="margin-left: 18px;">Base Amount</label>
                <input type="text" id="txttobaseamount" name="txttobaseamount" style="width:30%;text-align: right;" value='<s:property value="txttobaseamount"/>' tabindex="-1"/>
            </div>
        </div>
    </div>


<%--<table width="100%">--%>
<%--<tr>--%>
<%--<td width="50%">--%>
<%--<fieldset>--%>
<%--<table width="100%">--%>
<%--  <tr>--%>
<%--    <td width="6%" align="right">Cash</td>--%>
<%--    <td><input type="text" id="txtfromaccid" name="txtfromaccid" style="width:70%;" placeholder="Press F3 to Search" value='<s:property value="txtfromaccid"/>'  onkeydown="getAcc(event);"/></td>--%>
<%--    <td colspan="2"><input type="text" id="txtfromaccname" name="txtfromaccname" style="width:54%;" value='<s:property value="txtfromaccname"/>' tabindex="-1"/>--%>
<%--    <input type="hidden" id="txtfromdocno" name="txtfromdocno" value='<s:property value="txtfromdocno"/>'/></td>--%>
<%--  </tr>--%>
<%--  <tr>--%>
<%--    <td align="right">Currency</td>--%>
<%--    <td width="22%"><select id="cmbfromcurrency" name="cmbfromcurrency" style="width:71%;" value='<s:property value="cmbfromcurrency"/>' onload="getRate(this.value,$('#jqxCashPaymentDate').val());" onchange="getRate(this.value,$('#jqxCashPaymentDate').val());">--%>
<%--      <option></option></select>--%>
<%--      <input type="hidden" id="hidcmbfromcurrency" name="hidcmbfromcurrency" value='<s:property value="hidcmbfromcurrency"/>'/>--%>
<%--      <input type="hidden" id="hidfromcurrencytype" name="hidfromcurrencytype" value='<s:property value="hidfromcurrencytype"/>'/></td>--%>
<%--    <td width="23%" align="right">Rate</td>--%>
<%--    <td width="60%"><input type="text" id="txtfromrate" name="txtfromrate" style="width:32%;text-align: right;" value='<s:property value="txtfromrate"/>' onchange="funvalid()" onblur="funRoundRate(this.value,this.id);getBaseAmountFrom();getCrTotal();" tabindex="-1"/>--%>
<%--    <span id="validrate"></span>--%>
<%--    </td>--%>
<%--  </tr>--%>
<%--  <tr>--%>
<%--    <td align="right">Amount</td>--%>
<%--    <td><input type="text" id="txtfromamount" name="txtfromamount" style="width:70%;text-align: right;" value='<s:property value="txtfromamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getCrTotal();" /></td>--%>
<%--    <td align="right">Base Amount</td>--%>
<%--    <td><input type="text" id="txtfrombaseamount" name="txtfrombaseamount" style="width:32%;text-align: right;" value='<s:property value="txtfrombaseamount"/>' tabindex="-1"/></td>--%>
<%--  </tr>--%>
<%--   <tr>--%>
<%--    <td align="right">Description</td>--%>
<%--    <td colspan="3"><input type="text" id="txtdescription" name="txtdescription" style="width:65%;" value='<s:property value="txtdescription"/>'/></td>--%>
<%--  </tr>--%>
<%--</table>--%>
<%--</fieldset>--%>
<%--</td>--%>

<%--<td width="50%">--%>
<%--<fieldset>--%>
<%--<legend>Payment To</legend>--%>
<%--<table width="100%">--%>
<%--  <tr>--%>
<%--    <td width="6%" align="right">Type</td>--%>
<%--    <td width="10%"><select id="cmbtotype" name="cmbtotype" style="width:90%;" onchange="clearClientInfo();" value='<s:property value="cmbtotype"/>'>--%>
<%--    <option value="AP">AP</option><option value="AR">AR</option></select>--%>
<%--    <input type="hidden" id="hidcmbtotype" name="hidcmbtotype" value='<s:property value="hidcmbtotype"/>'/></td>--%>
<%--    <td width="20%"><input type="text" id="txttoaccid" name="txttoaccid" style="width:80%;" placeholder="Press F3 to Search" value='<s:property value="txttoaccid"/>' onkeydown="getAccType(event);"/></td>--%>
<%--    <td colspan="2"><input type="text" id="txttoaccname" name="txttoaccname" style="width:53%;" value='<s:property value="txttoaccname"/>' tabindex="-1"/>--%>
<%--    <input type="hidden" id="txttodocno" name="txttodocno" value='<s:property value="txttodocno"/>'/>--%>
<%--    <input type="hidden" id="txttotranid" name="txttotranid" value='<s:property value="txttotranid"/>'/>--%>
<%--    <input type="hidden" id="txttotrno" name="txttotrno" value='<s:property value="txttotrno"/>'/></td>--%>
<%--  </tr>--%>
<%--  <tr>--%>
<%--    <td align="right">Currency</td>--%>
<%--    <td colspan="2"><select id="cmbtocurrency" name="cmbtocurrency" style="width:50%;" value='<s:property value="cmbtocurrency"/>' onload="getRatevalue(this.value,$('#jqxCashPaymentDate').val());" onchange="getRatevalue(this.value,$('#jqxCashPaymentDate').val());">--%>
<%--      <option></option></select>--%>
<%--      <input type="hidden" id="hidcmbtocurrency" name="hidcmbtocurrency" value='<s:property value="hidcmbtocurrency"/>'/>--%>
<%--      <input type="hidden" id="hidtocurrencytype" name="hidtocurrencytype" value='<s:property value="hidtocurrencytype"/>'/></td>--%>
<%--    <td width="20%" align="right">Rate</td>--%>
<%--    <td width="57%"><input type="text" id="txttorate" name="txttorate" onchange="funvalid1()" style="width:30%;text-align: right;" value='<s:property value="txttorate"/>' onblur="funRoundRate(this.value,this.id);getBaseAmountTo();getDrTotal();" tabindex="-1"/>--%>
<%--    <span id="validrate1"></span>--%>
<%--    </td>--%>
<%--  </tr>--%>
<%--  <tr>--%>
<%--    <td align="right">Amount</td>--%>
<%--    <td colspan="2"><input type="text" id="txttoamount" name="txttoamount" style="width:50%;text-align: right;" value='<s:property value="txttoamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountTo();getDrTotal();getAmount();" onfocus="this.oldvalue = this.value;" onchange="funPaymentAmount(this);this.oldvalue = this.value;" /></td>--%>
<%--    <td align="right">Base Amount</td>--%>
<%--    <td><input type="text" id="txttobaseamount" name="txttobaseamount" style="width:30%;text-align: right;" value='<s:property value="txttobaseamount"/>' tabindex="-1"/></td>--%>
<%--  </tr>--%>
<%--</table>--%>
<%--</fieldset>--%>
<%--</td>--%>
<%--</tr></table>--%>


<fieldset>
    <div class="table-section">

        <h3>Apply Invoices</h3>
        <div id="jqxApplyInvoicing1"><center><jsp:include page="applyInvoicingGrid.jsp"></jsp:include></center></div>
        <table width="100%">
            <tr>
                <td width="8%" align="right">Amount</td>
                <td width="24%"><input type="text" id="txtapplyinvoiceamt" name="txtapplyinvoiceamt" style="width:50%;text-align: right;" value='<s:property value="txtapplyinvoiceamt"/>'/>
                    <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/></td>
                <td width="5%" align="right">Applied</td>
                <td width="26%"><input type="text" id="txtapplyinvoiceapply" name="txtapplyinvoiceapply" style="width:50%;text-align: right;" value='<s:property value="txtapplyinvoiceapply"/>' tabindex="-1"/></td>
                <td width="10%" align="right">Balance</td>
                <td width="27%"><input type="text" id="txtapplyinvoicebalance" name="txtapplyinvoicebalance" style="width:50%;text-align: right;" value='<s:property value="txtapplyinvoicebalance"/>' tabindex="-1"/></td>
            </tr>
        </table>

    </div>

</fieldset><br/>
<div id="jqxCashPaymentGrid"><jsp:include page="cashPaymentGrid.jsp"></jsp:include></div><br/>
<table width="100%">
  <tr>
    <td width="7%" align="right">Dr. Total</td>
    <td width="68%"><input type="text" id="txtdrtotal" name="txtdrtotal" style="width:15%;text-align: right;" value='<s:property value="txtdrtotal"/>'/></td>
    <td width="6%" align="right">Cr. Total</td>
    <td width="19%"><input type="text" id="txtcrtotal" name="txtcrtotal" style="width:50%;text-align: right;" value='<s:property value="txtcrtotal"/>' tabindex="-1"/></td>
  </tr>
</table>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" name="txtforsearch" id="txtforsearch" value="0"/>
<div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
<input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
<input type="hidden" id="applylength" name="applylength"/>
<input type="hidden" id="applylengthupdate" name="applylengthupdate"/>
<input type="hidden" id="hidstatus" name="hidstatus" value='<s:property value="status"/>'/>
</div>
</form>
	
<div id="cashPaymentGridWindow">
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
	
</div>
</body>
</html>
