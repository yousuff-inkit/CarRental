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
		 
		 $("#jqxIbBankPaymentDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#jqxChequeDate").jqxDateTimeInput({ width: '110px', height: '15px', formatString:"dd.MM.yyyy"});
		
		 $('#accountDetailsToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsToWindow').jqxWindow('close');  
		 
		 $('#accountDetailsFromWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsFromWindow').jqxWindow('close');
		 
		 $('#ibBankPaymentGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#ibBankPaymentGridWindow').jqxWindow('close');
		 
		 $('#branchSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Branch Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#branchSearchWindow').jqxWindow('close');
 		 
 		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costTypeSearchGridWindow').jqxWindow('close');
		 
		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
		 
		 $('#printWindow').jqxWindow({width: '51%', height: '31%',  maxHeight: '50%' ,maxWidth: '51%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#printWindow').jqxWindow('close');
 		 
 		 $('#jqxIbBankPaymentDate').on('change', function (event) {
			var ibbankpaydate = $('#jqxIbBankPaymentDate').jqxDateTimeInput('getDate');
			var validdate=funDateInPeriod(ibbankpaydate);
			if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
			}
		 });
		 
		$('#txtfromaccid').dblclick(function(){
			  var date = $('#jqxIbBankPaymentDate').jqxDateTimeInput('getDate');
        	  $("#maindate").jqxDateTimeInput('val', date);
			  accountFromSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
		});
		 
		$('#txttoaccid').dblclick(function(){
			  var date = $('#jqxIbBankPaymentDate').jqxDateTimeInput('getDate');
        	  $("#maindate").jqxDateTimeInput('val', date);
			  accountToSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtotype').val()+"&date="+date);
		});  
	});
	
	function BankSearchContent(url) {
		$('#ibBankPaymentGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#ibBankPaymentGridWindow').jqxWindow('setContent', data);
		$('#ibBankPaymentGridWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function BranchSearchContent(url) {
		$('#branchSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#branchSearchWindow').jqxWindow('setContent', data);
		$('#branchSearchWindow').jqxWindow('bringToFront');
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
  				document.getElementById("errormsg").innerText="";
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
			$('#frmIbBankPayment input').attr('readonly', true );
			$('#frmIbBankPayment select').attr('disabled', true);
			$('#chckpdc').attr('disabled', true);
			$('#jqxIbBankPaymentDate').jqxDateTimeInput({disabled: true});
			$('#jqxChequeDate').jqxDateTimeInput({disabled: true});
			$("#jqxApplyIbBankInvoicing").jqxGrid({ disabled: true});
			$("#jqxIbBankPayment").jqxGrid({ disabled: true});
			$("#btnvaluechange").hide();
			if(parseInt($("#pdcposttrno").val())!=0){
				 $("#btnEdit").attr('disabled', true);
				 $("#btnDelete").attr('disabled', true);
			 }
			
	 }
	 function funRemoveReadOnly(){
		    getBranch();checkpdc();
			$('#frmIbBankPayment input').attr('readonly', false );
			$('#frmIbBankPayment select').attr('disabled', false);
			$('#txtfromaccid').attr('readonly', true );
			$('#txtfromaccname').attr('readonly', true );
			$('#txttoaccid').attr('readonly', true );
			$('#txttoaccname').attr('readonly', true );
			$('#txtapplyinvoiceamt').attr('readonly', true );
			$('#txtapplyinvoiceapply').attr('readonly', true );
			$('#txtapplyinvoicebalance').attr('readonly', true );
			$('#txtdrtotal').attr('readonly', true );
			$('#txtcrtotal').attr('readonly', true );
			$('#jqxIbBankPaymentDate').jqxDateTimeInput({disabled: false});
			$('#jqxChequeDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$("#jqxApplyIbBankInvoicing").jqxGrid({ disabled: false}); 
			$("#jqxIbBankPayment").jqxGrid({ disabled: false});
			
			var date = $('#jqxIbBankPaymentDate').val();
		    getCurrencyId(date);
			
			if ($("#mode").val() == "E") {
         	    $("#btnvaluechange").show();
         	    $('#frmIbBankPayment input').attr('readonly', true );
   			    $('#frmIbBankPayment select').attr('disabled', true);
				$('#chckpdc').attr('disabled', true);
   			    $('#jqxChequeDate').jqxDateTimeInput({disabled: true});
   			    $("#jqxApplyIbBankInvoicing").jqxGrid({ disabled: true});
			    $("#jqxIbBankPayment").jqxGrid({ disabled: true});
   			    $('#txtrefno').attr('readonly', false );
   			 	$('#txtdescription').attr('readonly', false );
   			    $("#jqxIbBankPayment").jqxGrid('addrow', null, {"docno": "","branch": "","brhid": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","costtype": "","costgroup": "","costcode": "","dr": true,"amount1": "","baseamount1": "","description": "","grtype": "","currencytype": "","sr_no":""});
			  }
			 else{
				$("#btnvaluechange").hide();
			}
			
			if ($("#mode").val() == "A") {
				$('#jqxIbBankPaymentDate').val(new Date());
				$('#jqxChequeDate').val(new Date());
				$('#chckpdc').attr('disabled', false);
				$("#jqxIbBankPayment").jqxGrid('clear'); 
				$("#jqxIbBankPayment").jqxGrid('addrow', null, {"docno": "","branch": "","brhid": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","costtype": "","costgroup": "","costcode": "","dr": true,"amount1": "","baseamount1": "","description": "","grtype": "","currencytype": "","sr_no":""});
				$("#jqxApplyIbBankInvoicing").jqxGrid('clear');
				$("#jqxApplyIbBankInvoicing").jqxGrid('addrow', null, {});
			}
	 }
	 
	 function funSearchLoad(){
		changeContent('ibpMainSearch.jsp'); 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus()
	    {
	    	$('#jqxIbBankPaymentDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	  /* Validations */
	   $(function(){
	        $('#frmIbBankPayment').validate({
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
		  /* Validation 
		    if(parseInt($('#brchName').val().trim())==parseInt($('#cmbtobranch').val().trim())){
			    document.getElementById("errormsg").innerText="Invalid Transaction !!! Main Branch and Inter-Branch should not be same.";
				return 0;
			}*/
			
		  var rows = $("#jqxApplyIbBankInvoicing").jqxGrid('getrows');
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
			
		  var brname=$('#brchName').val();
		  var cmbtobranch=$('#cmbtobranch').val();
		  var id=0;
		  var rows = $('#jqxIbBankPayment').jqxGrid('getrows');
		  var list1=new Array();
		  for(var i=0 ; i < rows.length ; i++){
			    var chk=rows[i].docno;
			    if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
			    	list1.push(rows[i].brhid);
				}
		  }
		  
		  
		  var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText;

					var itemval = items.trim();
					if(itemval>0){
		  				id=1;

					}
	  			} else {
	  			}
	  		}
	  		x.open("GET",<%=contextPath+"/"%>+"com/finance/interbranchtransactions/checkInterBranch.jsp?br1="+brname+'&br2='+cmbtobranch+'&list1='+encodeURIComponent(list1), false);
	  		x.send();
	  		if(id==1){
	  			 getChequeNoAlreadyExists($('#txtchequeno').val(),$('#txtfromdocno').val(),$("#mode").val(),$("#docno").val());
	 			
	 		    var ibbankpaydate = $('#jqxIbBankPaymentDate').jqxDateTimeInput('getDate');
	 			var validdate=funDateInPeriod(ibbankpaydate);
	 			if(parseInt(validdate)==0){
	 				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
	 				return 0;	
	 			}
	 			
	 			pdcchequevalid=document.getElementById("txtpdcdatevalidation").value;
	 			 if(pdcchequevalid==1){
	 				 document.getElementById("errormsg").innerText="Invalid Cheque Date !!!";
	 				 return 0;
	 			 }
	 			 
	 			ibvalid=document.getElementById("txtibvalidation").value;
	 			 if(ibvalid==1){
	 				 document.getElementById("errormsg").innerText="Closing Done For Inter-Branch,Transaction Restricted. ";
	 				 return 0;
	 			 }
	 			 
	 			 valid=document.getElementById("txtvalidation").value;
	 			 if(valid==1){
	 				 document.getElementById("errormsg").innerText="Invalid Transaction !!!";
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
	 		  
	 		    var drtot = document.getElementById("txtdrtotal").value;
	 	 		var crtot = document.getElementById("txtcrtotal").value;
	 	 		if(drtot>crtot || drtot<crtot){
	 	 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should be Equal.";
	            return 0;
	 	 		}
	 	 		
	 	 		if(drtot=="" || crtot=="" || drtot=="NaN" || crtot=="NaN" || drtot==0 || crtot==0 || drtot==0.0 || crtot==0.0 || drtot==0.00 || crtot==0.00){
	 	 			  document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should not be Zero.";
	 	              return 0;
	 		 		}
	 	 		var balanceamt = $("#txtapplyinvoicebalance").val();  
		        if(parseInt(balanceamt)<0){
		        	 document.getElementById("errormsg").innerText= "Invalid applying amount!!!";
					 return 0;
		        }
	 	 		
	 	    	//document.getElementById("errormsg").innerText="";
	 	    		
	 	    /* Validation Ends*/
	 	    
	 	    	/* Bank Payment Grid  Saving*/
	 	  		  var rows = $("#jqxIbBankPayment").jqxGrid('getrows');
	 	  		  var length=0,val2=0;
	 			  for(var i=0 ; i < rows.length ; i++){
	 				    var chk=rows[i].docno;
	 				   var tramt=rows[i].tramt;
					    var applying = $("#jqxApplyIbBankInvoicing").jqxGrid('getcelltext',i,'applying');
	 				    if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
	 	  					newTextBox = $(document.createElement("input"))
	 	  				    .attr("type", "dil")
	 	  				    .attr("id", "test"+length)
	 	  				    .attr("name", "test"+length)
	 	  				    .attr("hidden", "true");
	 	  					length=length+1;
	 	  					if((tramt-applying)<0){
			  					val2=1;
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
	 	  				newTextBox.val(rows[i].docno+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+rows[i].dr+"::"+amount+"::"+rows[i].description+"::"+baseamount+"::0:: "+rows[i].costtype+":: "+rows[i].costcode+"::"+rows[i].brhid);
	 	  				newTextBox.appendTo('form');
	 	  				}
	 			  }
	 			 if(val2==1){   
	  				 document.getElementById("errormsg").innerText= "Invalid applying amount!!!";
					 return 0; 
	  			 } 
	 		      $('#gridlength').val(length);
	 	  	 		   /* Bank Payment Grid  Saving Ends*/	 
	 	  	 		
	 	  	 		/* Applying Bank Invoice Grid Saving */
	 	  	 		var rows = $("#jqxApplyIbBankInvoicing").jqxGrid('getrows');
	 	  	 		var lengthapply=0;
	 	  			 for(var i=0 ; i < rows.length ; i++){
	 	  					var chks=rows[i].applying;
	 	  					if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != ""){
	 	  					newTextBox = $(document.createElement("input"))
	 	  				    .attr("type", "dil")
	 	  				    .attr("id", "txtapply"+lengthapply)
	 	  				    .attr("name", "txtapply"+lengthapply)
	 	  				    .attr("hidden", "true");
	 	  					lengthapply=lengthapply+1;
	 	  					
	 	  				newTextBox.val(rows[i].applying+"::"+parseFloat(rows[i].out_amount+rows[i].applying)+"::"+rows[i].currency+"::"+rows[i].tranid+"::"+rows[i].acno);
	 	  				newTextBox.appendTo('form');
	 	  				}
	 				  }
	 				  $('#applylength').val(lengthapply);
	 	  			 /* Applying Bank Invoice Grid Saving Ends*/
	 	  			 
	 	  			 /* Applying Bank Invoice Grid Updating */
	 	  		 		var rows = $("#jqxApplyIbBankInvoicing").jqxGrid('getrows');
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
	 	  						
	 	  					newTextBox.val(parseFloat(rows[i].out_amount-rows[i].applying)+"::"+rows[i].tranid);
	 	  					newTextBox.appendTo('form');
	 	  					}
	 	  				}
	 	  				$('#applylengthupdate').val(lengthupdate);
	 	  				 /* Applying Bank Invoice Grid Updating Ends*/
	 	  				 
	 	  				 $('#jqxIbBankPaymentDate').jqxDateTimeInput({disabled: false});
	 			         $('#jqxChequeDate').jqxDateTimeInput({disabled: false});
	 			         
	 	    		return 1;
	  		}else{
	  			document.getElementById("errormsg").innerText="Inter Brach is not created";
				 return 0;
	  		}
			
			
		   
		} 
	  
	  function setValues(){
		  getBranch();checkpdc();
		  
		  $('#jqxIbBankPaymentDate').jqxDateTimeInput({disabled: false});
		  var date = $('#jqxIbBankPaymentDate').val();
		  getCurrencyId(date);
		  $('#jqxIbBankPaymentDate').jqxDateTimeInput({disabled: true});
		  
		  document.getElementById("cmbtotype").value=document.getElementById("hidcmbtotype").value;
		  
		  if($('#hidjqxIbBankPaymentDate').val()){
				 $("#jqxIbBankPaymentDate").jqxDateTimeInput('val', $('#hidjqxIbBankPaymentDate').val());
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
	             $("#jqxIbBankPaymentGrid").load("ibBankPaymentGrid.jsp?txtibbankpaydocno2="+indexVal+"&check="+check);
			 }
	         
	         var indexVal1 = document.getElementById("txttodocno").value;
	         var indexVal2 = document.getElementById("txttotrno").value;
	         if(indexVal1>0){
	        	 var check = 1;
	             $("#bankApplyInvoicing1").load("applyIbBankInvoicingGrid.jsp?txttoaccid1="+indexVal1+"&txttotrno1="+indexVal2+"&check="+check); 
	         }
		}
	  
	  function funwarningopen(){
			$.messager.confirm('Confirm', 'Transaction will affect Links to the applied Bank Reconcilations & Prepayments.', function(r){
			    if (r){
			    	 $("#mode").val("EDIT");
					 $('#txtfromaccid').attr('readonly', true);$('#txtfromaccname').attr('readonly', true);$('#txtfromamount').attr('readonly', false);$('#txtdescription').attr('readonly', false);
					 $('#txttoaccid').attr('readonly', true);$('#txttoaccname').attr('readonly', true);$('#txttoamount').attr('readonly', false);$('#txtfromrate').attr('readonly', false);$('#chckpdc').attr('disabled', false);
					 $('#jqxChequeDate').jqxDateTimeInput({disabled: false});$('#txtfrombaseamount').attr('readonly', true);$('#txttorate').attr('readonly', false);$('#txttobaseamount').attr('readonly', true);
					 $('#txtapplyinvoiceamt').attr('readonly', true);$('#txtapplyinvoiceapply').attr('readonly', true);$('#txtapplyinvoicebalance').attr('readonly', true);$('#txtdrtotal').attr('readonly', true);
					 $('#txtcrtotal').attr('readonly', true);$('#frmIbBankPayment select').attr('disabled', false);$("#jqxApplyIbBankInvoicing").jqxGrid({ disabled: false});
					 $('#txtchequename').attr('readonly', false);$("#jqxIbBankPayment").jqxGrid({ disabled: false});$('#txtchequeno').attr('readonly', false);  
			    }
			   });
		}
	  
	  function getBranch() {
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText;
	  				items = items.split('####');
	  				var branchIdItems  = items[0].split(",");
	  				var branchItems = items[1].split(",");
	  				var optionsbranch = '<option value=""></option>';
	  				for (var i = 0; i < branchItems.length; i++) {
	  					optionsbranch += '<option value="' + branchIdItems[i] + '">'
	  							+ branchItems[i] + '</option>';
	  				}
	  				$("select#cmbtobranch").html(optionsbranch);
	  				if ($('#hidcmbtobranch').val() != null) {
	  					$('#cmbtobranch').val($('#hidcmbtobranch').val());
	  				}
	  			} else {
	  			}
	  		}
	  		x.open("GET", <%=contextPath+"/"%>+"com/finance/interbranchtransactions/getBranch.jsp", true);
	  		x.send();
	  	}
	  
	  function getDrTotal(){
		  var toamount = $('#txttobaseamount').val();
		  
		  if(!isNaN(toamount)){
			  
		  var dr=0.0,cr=0.0,dr1=0.0;
  	      var rows = $('#jqxIbBankPayment').jqxGrid('getrows');
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
        	    var rows = $('#jqxIbBankPayment').jqxGrid('getrows');
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
		  $('#txtapplyinvoiceamt').val(toamount);
		  }
		  else if(isNaN(toamount)){
			  $('#txtapplyinvoiceamt').val(0.00);
			  $('#txttoamount').val(0.00);
			}
	  }
	  
	  function getAcc(event){
        var x= event.keyCode;
        if(x==114){
          var date = $('#jqxIbBankPaymentDate').jqxDateTimeInput('getDate');
      	  $("#maindate").jqxDateTimeInput('val', date);
      	  accountFromSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
        }
        else{}
        }
	  
	  function getAccType(event){
        var x= event.keyCode;
        if(x==114){
          var date = $('#jqxIbBankPaymentDate').jqxDateTimeInput('getDate');
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
		  $("#jqxApplyIbBankInvoicing").jqxGrid('clear');
		  $("#jqxApplyIbBankInvoicing").jqxGrid('addrow', null, {});
		  var atype=$('#cmbtotype').val();
      	  if(atype != "AP"){
      		$("#jqxApplyIbBankInvoicing").jqxGrid({ disabled: true});
      	   }else if(atype == "AP"){
      		 $("#jqxApplyIbBankInvoicing").jqxGrid({ disabled: false});   
      	   }
		   if (document.getElementById("txttoaccid").value == "") {
		        $('#txttoaccid').attr('placeholder', 'Press F3 to Search'); 
		   }
	  }
	  
	  function datechange(){
		  var date = $('#jqxIbBankPaymentDate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(date);
		  if(parseInt(validdate)==0){
			  document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
			  return 0;	
		  }
		  $("#maindate").jqxDateTimeInput('val', date);
		  
		  if($('#cmbtobranch').val()!='' && $('#cmbtobranch').val()!=null){
		  	var validibdate=funIBDateInPeriod($('#jqxIbBankPaymentDate').val(),$('#cmbtobranch').val());
			if(parseInt(validibdate)==0){
				document.getElementById("errormsg").innerText="Closing Done, Transaction Restricted.";
				return 0;	
		    }
			
			if(parseInt($('#brchName').val().trim())==parseInt($('#cmbtobranch').val().trim())){
			    document.getElementById("errormsg").innerText="Invalid Transaction !!! Main Branch and Inter-Branch should not be same.";
				return 0;
			}
			document.getElementById("errormsg").innerText="";
		  }
		  
		  funPDCDate($('#hidchckpdc').val(),$('#jqxIbBankPaymentDate').jqxDateTimeInput('getDate'),$('#jqxChequeDate').jqxDateTimeInput('getDate'));
	  }
	  
</script>

<style>
/* ------------------------------
    GLOBAL STYLES (MASTER CRV UI)
------------------------------ */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 32px 0;
    box-sizing: border-box;
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
    width: 100%;
}

input[type="text"]:focus, select:focus {
    border-color: #007bff;
    outline: none;
}

label {
    font: 16px 'Segoe UI';
    font-weight: 500;
    color: #253858;
    white-space: nowrap;
    line-height: 32px;
}

.section-block {
    flex: 1;
    min-width: 0;
    background: #f6f8fa;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.1);
    margin-bottom: 20px;
}

.section-block h2 {
    font-size: 17.6px;
    font-weight: 600;
    margin: 0 0 20px;
    padding-left: 10px;
    border-left: 4px solid #007bff;
    display: flex;
    align-items: center;
    gap: 10px;
}

.section-row {
    display: flex;
    gap: 20px;
    margin-bottom: 20px;
}

.trans-info-grid {
    display: grid;
    grid-template-columns: auto 1fr auto 1fr auto 1fr;
    gap: 12px 15px;
    align-items: center;
}

.agmt-info-grid {
    display: grid;
    grid-template-columns: auto 1.5fr auto 1fr;
    gap: 12px 20px;
    align-items: center;
}

.hidden-scrollbar {
    overflow: auto;
    height: 530px;
}

.checkbox-group {
    display: flex;
    align-items: center;
    gap: 8px;
}

.jqx-datetimeinput, 
.jqx-datetimeinput input, {
    width: 130px !important;
}


#docno, 
.header-docno {
    width: 130px !important;
}

#refno {
    width: 130px !important;
}
</style>
</head>
<body onload="setValues();">

<div id="mainBG" class="homeContent" data-type="background">
    <jsp:include page="../../../../header.jsp"></jsp:include>
    <br>
                <div class="trans-info-grid">
                    <label>Date</label>
                    <div id="jqxIbBankPaymentDate" name="jqxIbBankPaymentDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxIbBankPaymentDate"/>'></div>
                    
                    <label>Ref. No.</label>
                    <input type="text" id="txtrefno" name="txtrefno" value='<s:property value="txtrefno"/>'/>

                    <label>Doc No.</label>
                    <div style="display: flex; gap: 8px;">
                        <input type="text" id="docno" name="txtibbankpaydocno" value='<s:property value="txtibbankpaydocno"/>' tabindex="-1"/>
                        <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();" style="white-space: nowrap;">Value Change</button>
                    </div>
                </div>

    <form id="frmIbBankPayment" action="saveIbBankPayment" method="post" autocomplete="off">
        <div class="hidden-scrollbar">
            
            

            <div class="section-row">
                <div class="section-block">
                    <h2>Bank Details (From)</h2>
                    <div class="agmt-info-grid">
                        <label>Bank</label>
                        <div style="display: flex; gap: 8px;">
                            <input type="text" id="txtfromaccid" name="txtfromaccid" placeholder="F3 to Search" value='<s:property value="txtfromaccid"/>' onkeydown="getAcc(event);" style="width: 40%;"/>
                            <input type="text" id="txtfromaccname" name="txtfromaccname" value='<s:property value="txtfromaccname"/>' tabindex="-1"/>
                        </div>

                        <label>Currency</label>
                        <div style="display: flex; gap: 8px; align-items: center;">
                            <select id="cmbfromcurrency" name="cmbfromcurrency" onchange="getRate(this.value,$('#jqxIbBankPaymentDate').val());" value='<s:property value="cmbfromcurrency"/>'>
                                <option></option>
                            </select>
                            <label>Rate</label>
                            <input type="text" id="txtfromrate" name="txtfromrate" style="text-align: right;" value='<s:property value="txtfromrate"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getCrTotal();" tabindex="-1"/>
                        </div>

                        <div class="checkbox-group">
                            <input type="checkbox" id="chckpdc" name="chckpdc" onclick="funCheck();funPDCDate($('#hidchckpdc').val(),$('#jqxIbBankPaymentDate').jqxDateTimeInput('getDate'),$('#jqxChequeDate').jqxDateTimeInput('getDate'));">
                            <label for="chckpdc">PDC</label>
                        </div>
                        <div style="display: flex; gap: 8px; align-items: center;">
                            <label>Cheque No.</label>
                            <input type="text" id="txtchequeno" name="txtchequeno" onblur="getChequeNoAlreadyExists(this.value,$('#txtfromdocno').val(),$('#mode').val(),$('#docno').val());" value='<s:property value="txtchequeno"/>'/>
                        </div>

                        <label>Cheque Date</label>
                        <div id="jqxChequeDate" name="jqxChequeDate" onchange="funPDCDate($('#hidchckpdc').val(),$('#jqxIbBankPaymentDate').jqxDateTimeInput('getDate'),$('#jqxChequeDate').jqxDateTimeInput('getDate'));" value='<s:property value="jqxChequeDate"/>'></div>

                        <label>Cheque Name</label>
                        <input type="text" id="txtchequename" name="txtchequename" value='<s:property value="txtchequename"/>'/>

                        <label>Amount</label>
                        <div style="display: flex; gap: 8px; align-items: center;">
                            <input type="text" id="txtfromamount" name="txtfromamount" style="text-align: right;" value='<s:property value="txtfromamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getCrTotal();"/>
                            <label>Base</label>
                            <input type="text" id="txtfrombaseamount" name="txtfrombaseamount" style="text-align: right;" value='<s:property value="txtfrombaseamount"/>' tabindex="-1"/>
                        </div>

                        <label>Description</label>
                        <input type="text" id="txtdescription" name="txtdescription" value='<s:property value="txtdescription"/>'/>
                    </div>
                </div>

                <div class="section-block">
                    <h2>Payment To</h2>
                    <div class="agmt-info-grid">
                        <label>Branch</label>
                        <div style="display: flex; gap: 8px; align-items: center;">
                            <select id="cmbtobranch" name="cmbtobranch" onchange="funIBDateInPeriod($('#jqxIbBankPaymentDate').val(),this.value);" value='<s:property value="cmbtobranch"/>'>
                                <option></option>
                            </select>
                            <label>Type</label>
                            <select id="cmbtotype" name="cmbtotype" style="width: 80px;" onchange="clearClientInfo();" value='<s:property value="cmbtotype"/>'>
                                <option value="AP">AP</option>
                                <option value="AR">AR</option>
                            </select>
                        </div>

                        <label>Account</label>
                        <div style="display: flex; gap: 8px;">
                            <input type="text" id="txttoaccid" name="txttoaccid" placeholder="F3 to Search" value='<s:property value="txttoaccid"/>' onkeydown="getAccType(event);" style="width: 40%;"/>
                            <input type="text" id="txttoaccname" name="txttoaccname" value='<s:property value="txttoaccname"/>' tabindex="-1"/>
                        </div>

                        <label>Currency</label>
                        <div style="display: flex; gap: 8px; align-items: center;">
                            <select id="cmbtocurrency" name="cmbtocurrency" onchange="getRatevalue(this.value,$('#jqxIbBankPaymentDate').val());" value='<s:property value="cmbtocurrency"/>'>
                                <option></option>
                            </select>
                            <label>Rate</label>
                            <input type="text" id="txttorate" name="txttorate" style="text-align: right;" value='<s:property value="txttorate"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountTo();getDrTotal();" tabindex="-1"/>
                        </div>

                        <label>Amount</label>
                        <div style="display: flex; gap: 8px; align-items: center;">
                            <input type="text" id="txttoamount" name="txttoamount" style="text-align: right;" value='<s:property value="txttoamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountTo();getAmount();getDrTotal();"/>
                            <label>Base</label>
                            <input type="text" id="txttobaseamount" name="txttobaseamount" style="text-align: right;" value='<s:property value="txttobaseamount"/>' tabindex="-1"/>
                        </div>
                    </div>
                </div>
            </div>

            <div class="section-block">
                <h2>Apply Invoices</h2>
                <div id="bankApplyInvoicing1" style="margin-bottom: 15px;">
                    <jsp:include page="applyIbBankInvoicingGrid.jsp"></jsp:include>
                </div>
                <div class="trans-info-grid">
                    <label>Amount</label>
                    <input type="text" id="txtapplyinvoiceamt" name="txtapplyinvoiceamt" style="text-align: right;" value='<s:property value="txtapplyinvoiceamt"/>'/>
                    
                    <label>Applied</label>
                    <input type="text" id="txtapplyinvoiceapply" name="txtapplyinvoiceapply" style="text-align: right;" value='<s:property value="txtapplyinvoiceapply"/>' tabindex="-1"/>
                    
                    <label>Balance</label>
                    <input type="text" id="txtapplyinvoicebalance" name="txtapplyinvoicebalance" style="text-align: right;" value='<s:property value="txtapplyinvoicebalance"/>' tabindex="-1"/>
                </div>
            </div>

            <div class="section-block">
                <h2>Transaction Details</h2>
                <div id="jqxIbBankPaymentGrid" style="width: 100%;">
                    <jsp:include page="ibBankPaymentGrid.jsp"></jsp:include>
                </div>
            </div>

            <div class="section-block">
                <div class="trans-info-grid">
                    <label>Dr. Total</label>
                    <input type="text" id="txtdrtotal" name="txtdrtotal" style="text-align: right; font-weight: bold;" value='<s:property value="txtdrtotal"/>'/>
                    
                    <span></span><span></span> <label>Cr. Total</label>
                    <input type="text" id="txtcrtotal" name="txtcrtotal" style="text-align: right; font-weight: bold;" value='<s:property value="txtcrtotal"/>' tabindex="-1"/>
                </div>
            </div>

            <input type="hidden" id="hidjqxIbBankPaymentDate" name="hidjqxIbBankPaymentDate" value='<s:property value="hidjqxIbBankPaymentDate"/>'/>
            <input type="hidden" id="txtfromdocno" name="txtfromdocno" value='<s:property value="txtfromdocno"/>'/>
            <input type="hidden" id="hidcmbfromcurrency" name="hidcmbfromcurrency" value='<s:property value="hidcmbfromcurrency"/>'/>
            <input type="hidden" id="hidfromcurrencytype" name="hidfromcurrencytype" value='<s:property value="hidfromcurrencytype"/>'/>
            <input type="hidden" id="hidchckpdc" name="hidchckpdc" value='<s:property value="hidchckpdc"/>'/>
            <input type="hidden" id="txtpdcacno" name="txtpdcacno" value='<s:property value="txtpdcacno"/>'/>
            <input type="hidden" id="hidjquChequeDate" name="hidjqxChequeDate" value='<s:property value="hidjqxChequeDate"/>'/>
            <input type="hidden" id="hidcmbtobranch" name="hidcmbtobranch" value='<s:property value="hidcmbtobranch"/>'/>
            <input type="hidden" id="hidcmbtotype" name="hidcmbtotype" value='<s:property value="hidcmbtotype"/>'/>
            <input type="hidden" id="txttodocno" name="txttodocno" value='<s:property value="txttodocno"/>'/>
            <input type="hidden" id="txttotranid" name="txttotranid" value='<s:property value="txttotranid"/>'/>
            <input type="hidden" id="txttotrno" name="txttotrno" value='<s:property value="txttotrno"/>'/>
            <input type="hidden" id="hidcmbtocurrency" name="hidcmbtocurrency" value='<s:property value="hidcmbtocurrency"/>'/>
            <input type="hidden" id="hidtocurrencytype" name="hidtocurrencytype" value='<s:property value="hidtocurrencytype"/>'/>
            <input type="hidden" id="mode" name="mode"/>
            <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            <input type="hidden" name="txtforsearch" id="txtforsearch" value="0"/>
            <div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
            <input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
            <input type="hidden" id="txtibvalidation" name="txtibvalidation" value='<s:property value="txtibvalidation"/>'/>
            <input type="hidden" id="txtpdcdatevalidation" name="txtpdcdatevalidation" value='<s:property value="txtpdcdatevalidation"/>'/>
            <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
            <input type="hidden" id="gridlength" name="gridlength"/>
            <input type="hidden" id="applylength" name="applylength"/>
            <input type="hidden" id="applylengthupdate" name="applylengthupdate"/>
            <input type="hidden" id="pdcposttrno" name="pdcposttrno" value='<s:property value="pdcposttrno"/>'/>
        </div>
    </form>
    
    <div id="ibBankPaymentGridWindow"><div></div><div></div></div>   
    <div id="accountDetailsFromWindow"><div></div><div></div></div>   
    <div id="accountDetailsToWindow"><div></div><div></div></div> 
    <div id="branchSearchWindow"><div></div><div></div></div>
    <div id="costTypeSearchGridWindow"><div></div><div></div></div> 
    <div id="costCodeSearchWindow"><div></div><div></div></div> 
    <div id="printWindow"><div></div><div></div></div> 
</div>

</body>
</html>