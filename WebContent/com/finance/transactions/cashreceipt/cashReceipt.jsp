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
		 
		 $("#jqxCashReceiptDate").jqxDateTimeInput({ width: '164px', height: 34 , formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '164px', height: 34 , formatString:"dd.MM.yyyy"});
		// 🔥 REMOVE jqx inline margin (FINAL FIX)
		 $("#inputjqxCashReceiptDate").css("margin-top", "0px");
		 $("#inputmaindate").css("margin-top", "0px");
		 $("#jqxCashReceiptDate").jqxDateTimeInput({
			    width: '164px',
			    height: 34,
			    formatString: "dd.MM.yyyy",
			    theme: 'energyblue'
			});

			/* force internal alignment AFTER render */
			setTimeout(function () {
			    $("#jqxCashReceiptDate")
			        .find("input")
			        .css({
			            "margin-top": "0px",
			            "line-height": "34px"
			        });

			    $("#jqxCashReceiptDate")
			        .find(".jqx-action-button")
			        .css({
			            "top": "0px",
			            "height": "34px"
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
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus()
	    {
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
	        });});
	   
	  function funNotify(){	
		  
		  
		  /* Validation */
		  
		  var rows = $("#jqxApplyCashReceiptInvoicing").jqxGrid('getrows');
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
	  			 //alert("val2==="+val2);
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
        	  var date = $('#jqxCashReceiptDate').jqxDateTimeInput('getDate');
        	  $("#maindate").jqxDateTimeInput('val', date);
        	  accountFromSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
          }
          else{
           }
          }
	  
	  function getAccType(event){
          var x= event.keyCode;
          if(x==114){
        	  var date = $('#jqxCashReceiptDate').jqxDateTimeInput('getDate');
        	  $("#maindate").jqxDateTimeInput('val', date);
        	  accountToSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtotype').val()+"&date="+date);
          }
          else{
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
<style>


body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 32px 0;
    box-sizing: border-box;
    overflow-y: auto;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 20px;
    max-width: 100%;
    margin: auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
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
}

input[type="text"]:focus,
select:focus {
    border-color: #007bff;
    outline: none;
}

label {
    font-weight: 600;
    color: #253858;
    white-space: nowrap;
}


.receipt-header {
    display: flex;
    flex-direction: column;
    margin-bottom: 16px;
    padding: 0 10px 10px;
}

.receipt-header table {
    width: 100%;
}

.receipt-header td {
    padding: 6px 4px;
    vertical-align: middle;
}

#txtStatus {
    font-size: 14px;
    font-weight: 600;
    color: #e67e22;
}



.form-group {
    display: grid;
    grid-template-columns: 120px 1fr;
    align-items: center;
    gap: 12px 16px;
    margin-bottom: 12px;
}

.form-group label {
    text-align: right;
    padding-right: 8px;
    font-size:1rem;
}

.form-group input[type="text"],
.form-group select {
    width: 100%;
}

/* For rows with multiple input pairs (Currency/Rate, Amount/Base Amount) */
.form-group.dual-input {
    grid-template-columns: 120px 1fr 120px 1fr;
}

.form-group.dual-input label:nth-of-type(2) {
    text-align: right;
    padding-right: 8px;
}
.form-group.dual-input label:nth-of-type(2) {
    text-align: right;
    padding-right: 8px;
}

/* Special case: One label with two equal-width inputs */
.form-group.single-label-dual-input {
    grid-template-columns: 120px 1fr 1fr;
}

.form-group.single-label-dual-input input[type="text"]:first-of-type {
    width: 100%;
}

.form-group.single-label-dual-input input[type="text"]:nth-of-type(2) {
    width: 100%;
}

.section-row {
    display: flex;
    gap: 26px;
    margin-bottom: 30px;
}

.section-block {
    flex: 1;
    min-width: 0;
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
}

/* Special handling for the "to-account-row" - all items in one line */
.to-account-row {
    display: grid;
    grid-template-columns: 120px 110px 120px 140px 1fr;
    align-items: center;
    gap: 12px;
    margin-bottom: 12px;
}

.to-account-row label {
    text-align: right;
    padding-right: 8px;
}

.to-account-row #cmbtotype {
    width: 100%;
}

.to-account-row #txttoaccid {
    width: 100%;
}

.to-account-row #txttoaccname {
    width: 100%;
}



.table-section {
    margin: 20px 0;
}

.table-section h3 {
    color: #253858;
    font-size: 1.05rem;
    font-weight: 600;
    margin-bottom: 12px;
}

.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #fff;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 0 0 1px #e5e7eb;
}

.cr-table th,
.cr-table td {
    padding: 8px 12px;
    border-bottom: 1px solid #eef0f6;
    font-size: 14px;
}

.cr-table th {
    background: #eef0f6;
    font-weight: 600;
    color: #354B6A;
}

.cr-table tr:last-child td {
    border-bottom: none;
}

/* ------------------------------
   SCROLL AREAS
------------------------------ */

.hidden-scrollbar {
    overflow: auto;
    height: 100vh;
}

.hidden-scrollbar::-webkit-scrollbar {
    width: 0px;
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



  
  
#validrate,
#validrate1 {
    color: red;
    font-size: 12px;
    grid-column: 2 / -1;
}



#approval-table td {
    font-size: 14px;
    padding: 8px;
}

#approval-table tr:nth-child(even) {
    background: #f9fafb;
}
input:-webkit-autofill,
input:-webkit-autofill:hover,
input:-webkit-autofill:focus,
select:-webkit-autofill {
    -webkit-box-shadow: 0 0 0px 1000px #ffffff inset !important;
    box-shadow: 0 0 0px 1000px #ffffff inset !important;
    -webkit-text-fill-color: #253858 !important;
    transition: background-color 5000s ease-in-out 0s;
}
/* Align jqxDateTimeInput with normal textboxes */
.jqx-datetimeinput,
.jqx-datetimeinput .jqx-input-content {
    height: 34px !important;
    line-height: 34px !important;
    box-sizing: border-box;
}


</style>


</head>
<body onload="setValues();">
<div id="mainBG" class="hidden-scrollbar homeContent" data-type="background">
<form id="frmCashReceipt" action="saveCashReceipt" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div  class='receipt-header'>
<table width="100%">
  <tr>
    <td width="3%" height="42" align="right">Date</td>
    <td width="11%"><div id="jqxCashReceiptDate" name="jqxCashReceiptDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxCashReceiptDate"/>'></div>
    <input type="hidden" id="hidjqxCashReceiptDate" name="hidjqxCashReceiptDate" value='<s:property value="hidjqxCashReceiptDate"/>'/></td>
    <td width="21%" align="left">&nbsp;</td>
    <td width="9%" align="right">Ref. No.</td>
    <td width="29%"><input type="text" id="txtrefno" name="txtrefno"  value='<s:property value="txtrefno"/>'/></td>
    <td width="6%" align="right">Doc No.</td>
    <td width="21%"><input type="text" id="docno" name="txtcashreceiptdocno"  value='<s:property value="txtcashreceiptdocno"/>' tabindex="-1"/>
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
            <div class="form-group single-label-dual-input" >
                <label for="txtfromaccid">Cash</label>
                <input type="text" id="txtfromaccid" name="txtfromaccid"  placeholder="Press F3 to Search" value='<s:property value="txtfromaccid"/>' onkeydown="getAcc(event);" />
                <input type="text" id="txtfromaccname" name="txtfromaccname"   value='<s:property value="txtfromaccname"/>' tabindex="-1" />
                <input type="hidden" id="txtfromdocno" name="txtfromdocno" value='<s:property value="txtfromdocno"/>' />
            </div>
            <div class="form-group dual-input" >
                <label for="cmbfromcurrency">Currency</label>
                <select id="cmbfromcurrency" name="cmbfromcurrency"  value='<s:property value="cmbfromcurrency"/>' onchange="getRate(this.value,$('#jqxCashReceiptDate').val());">
                    [...]
                </select>
                <input type="hidden" id="hidcmbfromcurrency" name="hidcmbfromcurrency" value='<s:property value="hidcmbfromcurrency"/>' />
                <input type="hidden" id="hidfromcurrencytype" name="hidfromcurrencytype" value='<s:property value="hidfromcurrencytype"/>' />
                <label for="txtfromrate" >Rate</label>
                <input type="text" id="txtfromrate" name="txtfromrate" onchange="funvalid()"  value='<s:property value="txtfromrate"/>' onblur="funRoundRate(this.value,this.id);getBaseAmountFrom();getDrTotal();" tabindex="-1" />
                <span id="validrate"></span>
            </div>
            <div class="form-group dual-input" >
                <label for="txtfromamount">Amount</label>
                <input type="text" id="txtfromamount" name="txtfromamount"  value='<s:property value="txtfromamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getDrTotal();" />
                <label for="txtfrombaseamount" >Base Amount</label>
                <input type="text" id="txtfrombaseamount" name="txtfrombaseamount"  value='<s:property value="txtfrombaseamount"/>' tabindex="-1" />
            </div>
            <div class="form-group">
                <label for="txtdescription">Description</label>
                <input type="text" id="txtdescription" name="txtdescription"  value='<s:property value="txtdescription"/>' />
            </div>
        </div>

        <!-- Payment From Section -->
        <div class="section-block">
            <h2>Payment From</h2>
            <div class="form-group to-account-row" >
                <label for="cmbtotype">Type</label>
                <select id="cmbtotype" name="cmbtotype" style="width:130%;" onchange="clearClientInfo();" value='<s:property value="cmbtotype"/>'>
                    <option value="AR">AR</option><option value="AP">AP</option>
                </select>
                <input type="hidden" id="hidcmbtotype" name="hidcmbtotype" value='<s:property value="hidcmbtotype"/>' />
                <label for="txttoaccid" >Account ID</label>
                <input type="text" id="txttoaccid" name="txttoaccid" placeholder="Press F3 to Search" value='<s:property value="txttoaccid"/>' onkeydown="getAccType(event);" />
                <input type="text" id="txttoaccname" name="txttoaccname" value='<s:property value="txttoaccname"/>' tabindex="-1" />
                <input type="hidden" id="txttodocno" name="txttodocno" value='<s:property value="txttodocno"/>' />
                <input type="hidden" id="txttotranid" name="txttotranid" value='<s:property value="txttotranid"/>' />
                <input type="hidden" id="txttotrno" name="txttotrno" value='<s:property value="txttotrno"/>' />
            </div>
            <div class="form-group dual-input" >
                <label for="cmbtocurrency">Currency</label>
                <select id="cmbtocurrency" name="cmbtocurrency" value='<s:property value="cmbtocurrency"/>' onchange="getRatevalue(this.value,$('#jqxCashReceiptDate').val());">
                    <option></option>
                </select>
                <input type="hidden" id="hidcmbtocurrency" name="hidcmbtocurrency" value='<s:property value="hidcmbtocurrency"/>' />
                <input type="hidden" id="hidtocurrencytype" name="hidtocurrencytype" value='<s:property value="hidtocurrencytype"/>' />
                <label for="txttorate" >Rate</label>
                <input type="text" id="txttorate" name="txttorate" onchange="funvalid1()" value='<s:property value="txttorate"/>' onblur="funRoundRate(this.value,this.id);getBaseAmountTo();getCrTotal();" tabindex="-1" />
                <span id="validrate1"></span>
            </div>
            <div class="form-group dual-input" >
                <label for="txttoamount" >Amount</label>
                <input type="text" id="txttoamount" name="txttoamount" value='<s:property value="txttoamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountTo();getCrTotal();getAmount();" onfocus="this.oldvalue = this.value;" onchange="funPaymentAmount(this);this.oldvalue = this.value;" />
                <label for="txttobaseamount" >Base Amount</label>
                <input type="text" id="txttobaseamount" name="txttobaseamount" value='<s:property value="txttobaseamount"/>' tabindex="-1" />
            </div>
        </div>
    </div>




<%--        <table width="100%">--%>
<%--<tr>--%>
<%--<td width="50%">--%>
<%--<fieldset>--%>
<%--<table width="100%">--%>
<%--  <tr>--%>
<%--    <td width="6%" align="right">Cash</td>--%>
<%--    <td><input type="text" id="txtfromaccid" name="txtfromaccid" 70%;" placeholder="Press F3 to Search" value='<s:property value="txtfromaccid"/>' onkeydown="getAcc(event);"/></td>--%>
<%--    <td colspan="2"><input type="text" id="txtfromaccname" name="txtfromaccname" 54%;" value='<s:property value="txtfromaccname"/>' tabindex="-1"/>--%>
<%--    <input type="hidden" id="txtfromdocno" name="txtfromdocno" value='<s:property value="txtfromdocno"/>'/></td>--%>
<%--  </tr>--%>
<%--  <tr>--%>
<%--    <td align="right">Currency</td>--%>
<%--    <td width="22%"><select id="cmbfromcurrency" name="cmbfromcurrency" 71%;" value='<s:property value="cmbfromcurrency"/>' onchange="getRate(this.value,$('#jqxCashReceiptDate').val());">--%>
<%--      <option></option></select>--%>
<%--      <input type="hidden" id="hidcmbfromcurrency" name="hidcmbfromcurrency" value='<s:property value="hidcmbfromcurrency"/>'/>--%>
<%--      <input type="hidden" id="hidfromcurrencytype" name="hidfromcurrencytype" value='<s:property value="hidfromcurrencytype"/>'/></td>--%>
<%--    <td width="23%" align="right">Rate</td>--%>
<%--    <td width="60%"><input type="text" id="txtfromrate" name="txtfromrate" onchange="funvalid()"  32%;text-align: right;" value='<s:property value="txtfromrate"/>' onblur="funRoundRate(this.value,this.id);getBaseAmountFrom();getDrTotal();" tabindex="-1"/>--%>
<%--    <span id="validrate"></span>--%>
<%--    </td>--%>
<%--  </tr>--%>
<%--  <tr>--%>
<%--    <td align="right">Amount</td>--%>
<%--    <td><input type="text" id="txtfromamount" name="txtfromamount" 70%;text-align: right;" value='<s:property value="txtfromamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getDrTotal();" /></td>--%>
<%--    <td align="right">Base Amount</td>--%>
<%--    <td><input type="text" id="txtfrombaseamount" name="txtfrombaseamount" 32%;text-align: right;" value='<s:property value="txtfrombaseamount"/>' tabindex="-1"/></td>--%>
<%--  </tr>--%>
<%--   <tr>--%>
<%--    <td align="right">Description</td>--%>
<%--    <td colspan="3"><input type="text" id="txtdescription" name="txtdescription" 65%;" value='<s:property value="txtdescription"/>'/></td>--%>
<%--  </tr>--%>
<%--</table>--%>
<%--</fieldset>--%>
<%--</td>--%>

<%--<td width="50%">--%>
<%--<fieldset>--%>
<%--<legend>Payment From</legend>--%>
<%--<table width="100%">--%>
<%--  <tr>--%>
<%--    <td width="6%" align="right">Type</td>--%>
<%--    <td width="10%"><select id="cmbtotype" name="cmbtotype" 90%;" onchange="clearClientInfo();" value='<s:property value="cmbtotype"/>'>--%>
<%--    <option value="AR">AR</option><option value="AP">AP</option></select>--%>
<%--    <input type="hidden" id="hidcmbtotype" name="hidcmbtotype" value='<s:property value="hidcmbtotype"/>'/></td>--%>
<%--    <td width="20%"><input type="text" id="txttoaccid" name="txttoaccid" 80%;" placeholder="Press F3 to Search" value='<s:property value="txttoaccid"/>' onkeydown="getAccType(event);"/></td>--%>
<%--    <td colspan="2"><input type="text" id="txttoaccname" name="txttoaccname" 53%;" value='<s:property value="txttoaccname"/>' tabindex="-1"/>--%>
<%--    <input type="hidden" id="txttodocno" name="txttodocno" value='<s:property value="txttodocno"/>'/>--%>
<%--    <input type="hidden" id="txttotranid" name="txttotranid" value='<s:property value="txttotranid"/>'/>--%>
<%--    <input type="hidden" id="txttotrno" name="txttotrno" value='<s:property value="txttotrno"/>'/></td>--%>
<%--  </tr>--%>
<%--  <tr>--%>
<%--    <td align="right">Currency</td>--%>
<%--    <td colspan="2"><select id="cmbtocurrency" name="cmbtocurrency" 50%;" value='<s:property value="cmbtocurrency"/>' onchange="getRatevalue(this.value,$('#jqxCashReceiptDate').val());">--%>
<%--      <option></option></select>--%>
<%--      <input type="hidden" id="hidcmbtocurrency" name="hidcmbtocurrency" value='<s:property value="hidcmbtocurrency"/>'/>--%>
<%--      <input type="hidden" id="hidtocurrencytype" name="hidtocurrencytype" value='<s:property value="hidtocurrencytype"/>'/></td>--%>
<%--    <td width="20%" align="right">Rate</td>--%>
<%--    <td width="57%"><input type="text" id="txttorate" name="txttorate" onchange="funvalid1()" 30%;text-align: right;" value='<s:property value="txttorate"/>' onblur="funRoundRate(this.value,this.id);getBaseAmountTo();getCrTotal();" tabindex="-1"/>--%>
<%--    <span id="validrate1"></span></td>--%>
<%--  </tr>--%>
<%--  <tr>--%>
<%--    <td align="right">Amount</td>--%>
<%--    <td colspan="2"><input type="text" id="txttoamount" name="txttoamount" 50%;text-align: right;" value='<s:property value="txttoamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountTo();getCrTotal();getAmount();" onfocus="this.oldvalue = this.value;" onchange="funPaymentAmount(this);this.oldvalue = this.value;" /></td>--%>
<%--    <td align="right">Base Amount</td>--%>
<%--    <td><input type="text" id="txttobaseamount" name="txttobaseamount" 30%;text-align: right;" value='<s:property value="txttobaseamount"/>' tabindex="-1"/></td>--%>
<%--  </tr>--%>
<%--</table>--%>
<%--</fieldset>--%>
<%--</td>--%>
<%--</tr></table>--%>

<%--    <div class="table-section">--%>
<%--        <h3>Apply invoices</h3>--%>
<%--        <table class="cr-table">--%>
<%--            <tr>--%>
<%--                <th>Date</th>--%>
<%--                <th>Dec Type</th>--%>
<%--                <th>Date</th>--%>
<%--                <th>Remarks</th>--%>
<%--                <th>Amount</th>--%>
<%--                <th>Applying</th>--%>
<%--                <th>Balance</th>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <td>...</td>--%>
<%--                <td>...</td>--%>
<%--                <td>...</td>--%>
<%--                <td>...</td>--%>
<%--                <td>...</td>--%>
<%--                <td>...</td>--%>
<%--                <td>...</td>--%>
<%--            </tr>--%>
<%--        </table>--%>
<%--    </div>--%>
    <!-- Modern Apply Invoices Section -->
    <div class="table-section">
        <h3>Apply Invoices</h3>
        <div id="jqxApplyInvoicing1">
            <jsp:include page="applyCashReceiptInvoicingGrid.jsp"></jsp:include>
        </div>
        <table class="cr-table">
            <tr>
                <td align="right">Amount</td>
                <td>
                    <input type="text" id="txtapplyinvoiceamt" name="txtapplyinvoiceamt" value='<s:property value="txtapplyinvoiceamt"/>' />
                    <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>' />
                </td>
                <td align="right">Applied</td>
                <td>
                    <input type="text" id="txtapplyinvoiceapply" name="txtapplyinvoiceapply"value='<s:property value="txtapplyinvoiceapply"/>' tabindex="-1" />
                </td>
                <td align="right">Balance</td>
                <td>
                    <input type="text" id="txtapplyinvoicebalance" name="txtapplyinvoicebalance"  value='<s:property value="txtapplyinvoicebalance"/>' tabindex="-1" />
                </td>
            </tr>
        </table>
    </div>

<%--<fieldset>--%>
<%--<legend>Apply Invoices</legend>--%>
<%--<div id="jqxApplyInvoicing1"><center><jsp:include page="applyCashReceiptInvoicingGrid.jsp"></jsp:include></center></div> --%>
<%--<table width="100%">--%>
<%--  <tr>--%>
<%--    <td width="8%" align="right">Amount</td>--%>
<%--    <td width="24%"><input type="text" id="txtapplyinvoiceamt" name="txtapplyinvoiceamt" 50%;text-align: right;" value='<s:property value="txtapplyinvoiceamt"/>'/>--%>
<%--    <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/></td>--%>
<%--    <td width="5%" align="right">Applied</td>--%>
<%--    <td width="26%"><input type="text" id="txtapplyinvoiceapply" name="txtapplyinvoiceapply" 50%;text-align: right;" value='<s:property value="txtapplyinvoiceapply"/>' tabindex="-1"/></td>--%>
<%--    <td width="10%" align="right">Balance</td>--%>
<%--    <td width="27%"><input type="text" id="txtapplyinvoicebalance" name="txtapplyinvoicebalance" 50%;text-align: right;" value='<s:property value="txtapplyinvoicebalance"/>' tabindex="-1"/></td>--%>
<%--  </tr>--%>
<%--</table>--%>
<%--</fieldset>--%>
    <br/>
<div id="jqxCashReceiptGrid"><jsp:include page="cashReceiptGrid.jsp"></jsp:include></div><br/>
<table width="100%">
  <tr>
    <td width="7%" align="right">Dr. Total</td>
    <td width="68%"><input type="text" id="txtdrtotal" name="txtdrtotal" value='<s:property value="txtdrtotal"/>'/></td>
    <td width="6%" align="right">Cr. Total</td>
    <td width="19%"><input type="text" id="txtcrtotal" name="txtcrtotal" value='<s:property value="txtcrtotal"/>' tabindex="-1"/></td>
  </tr>
</table>
    <div class="table-section" id="approval-section">
        <h3>Approvals</h3>
        <table class="cr-table" id="approval-table">
            <thead>
                <tr>
                    <th>Approved By</th>
                    <th>Date</th>
                    <th>Remarks</th>
                </tr>
            </thead>
            <tbody>
                <!-- Approval rows will be populated here -->
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
                // Expecting items as CSV: approvedBy,date,remarks\n...
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
	
<div id="cashReceiptGridWindow">
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
