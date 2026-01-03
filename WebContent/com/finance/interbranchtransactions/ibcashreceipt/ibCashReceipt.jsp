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
		 
		 $("#jqxIBCashReceiptDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsToWindow').jqxWindow('close');  
		 
		 $('#accountDetailsFromWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsFromWindow').jqxWindow('close');
		 
		 $('#ibCashReceiptGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#ibCashReceiptGridWindow').jqxWindow('close');
		 
		 $('#branchSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Branch Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#branchSearchWindow').jqxWindow('close');
 		 
 		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costTypeSearchGridWindow').jqxWindow('close');
		 
		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
 		 
		 $('#txtfromaccid').dblclick(function(){
			  var date = $('#jqxIBCashReceiptDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountFromSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
			  });
		 
		  $('#txttoaccid').dblclick(function(){
			  var date = $('#jqxIBCashReceiptDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountToSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtotype').val()+"&date="+date);
			  });  
			  
 		$('#jqxIBCashReceiptDate').on('change', function (event) {
			 var ibreceiptdate = $('#jqxIBCashReceiptDate').jqxDateTimeInput('getDate');
			 var validdate=funDateInPeriod(ibreceiptdate);
			 if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
			 }
		 });
	});
	
	function CashSearchContent(url) {
		$('#ibCashReceiptGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#ibCashReceiptGridWindow').jqxWindow('setContent', data);
		$('#ibCashReceiptGridWindow').jqxWindow('bringToFront');
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
	
	function funwarningopen(){
		$.messager.confirm('Confirm', 'Transaction will affect Links to the applied Bank Reconcilations & Prepayments.', function(r){
		    if (r){
		    	 $("#mode").val("EDIT");
				 $('#txtfromaccid').attr('readonly', true);$('#txtfromaccname').attr('readonly', true);$('#txtfromamount').attr('readonly', false);$('#txtdescription').attr('readonly', false);
				 $('#txttoaccid').attr('readonly', true);$('#txttoaccname').attr('readonly', true);$('#txttoamount').attr('readonly', false);$('#txtfromrate').attr('readonly', false);
			     $('#txtfrombaseamount').attr('readonly', true);$('#txttorate').attr('readonly', false);$('#txttobaseamount').attr('readonly', true);$('#txtapplyinvoiceamt').attr('readonly', true);
			     $('#txtapplyinvoiceapply').attr('readonly', true);$('#txtapplyinvoicebalance').attr('readonly', true);$('#txtdrtotal').attr('readonly', true);$('#txtcrtotal').attr('readonly', true);
				 $('#frmIbCashReceipt select').attr('disabled', false);$("#jqxApplyIbCashInvoicing").jqxGrid({ disabled: false});$("#jqxIbCashReceipt").jqxGrid({ disabled: false});     
		    }
		   });
	}
	  
	 function funReadOnly(){
			$('#frmIbCashReceipt input').attr('readonly', true );
			$('#frmIbCashReceipt select').attr('disabled', true);
			$('#jqxIBCashReceiptDate').jqxDateTimeInput({disabled: true});
			$("#jqxApplyIbCashInvoicing").jqxGrid({ disabled: true});
			$("#jqxIbCashReceipt").jqxGrid({ disabled: true});
			$("#btnvaluechange").hide();
	 }
	 
	 function funRemoveReadOnly(){
			getBranch();
			$('#frmIbCashReceipt input').attr('readonly', false );
			$('#frmIbCashReceipt select').attr('disabled', false);
			
			$('#txtfromaccid').attr('readonly', true );
			$('#txtfromaccname').attr('readonly', true );
			$('#txttoaccid').attr('readonly', true );
			$('#txttoaccname').attr('readonly', true );
			$('#txtapplyinvoiceamt').attr('readonly', true );
			$('#txtapplyinvoiceapply').attr('readonly', true );
			$('#txtapplyinvoicebalance').attr('readonly', true );
			$('#txtdrtotal').attr('readonly', true );
			$('#txtcrtotal').attr('readonly', true );
			$('#jqxIBCashReceiptDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$("#jqxApplyIbCashInvoicing").jqxGrid({ disabled: false}); 
			$("#jqxIbCashReceipt").jqxGrid({ disabled: false});
			
			var date = $('#jqxIBCashReceiptDate').val();
		    getCurrencyId(date);
		    
			if ($("#mode").val() == "E") {
         	    $("#btnvaluechange").show();
         	    $('#frmIbCashReceipt input').attr('readonly', true );
   			    $('#frmIbCashReceipt select').attr('disabled', true);
   			    $("#jqxApplyIbCashInvoicing").jqxGrid({ disabled: true});
			    $("#jqxIbCashReceipt").jqxGrid({ disabled: true});
   			    $('#txtrefno').attr('readonly', false );
   			 	$('#txtdescription').attr('readonly', false );
   			 	$("#jqxIbCashReceipt").jqxGrid('addrow', null, {"docno": "","branch": "","brhid": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","costtype": "","costgroup": "","costcode": "","dr": true,"amount1": "","baseamount1": "","description": "","grtype": "","currencytype": "","sr_no":""});
			  }
			 else{
				$("#btnvaluechange").hide();
			} 
			
			if ($("#mode").val() == "A") {
				$('#jqxIBCashReceiptDate').val(new Date());
				$("#jqxIbCashReceipt").jqxGrid('clear'); 
				$("#jqxIbCashReceipt").jqxGrid('addrow', null, {"docno": "","branch": "","brhid": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","costtype": "","costgroup": "","costcode": "","dr": true,"amount1": "","baseamount1": "","description": "","grtype": "","currencytype": "","sr_no":""});
				$("#jqxApplyIbCashInvoicing").jqxGrid('clear');
				$("#jqxApplyIbCashInvoicing").jqxGrid('addrow', null, {});
			}
	 }
	 
	 function funSearchLoad(){
		changeContent('icrvMainSearch.jsp'); 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus()
	    {
	    	$('#jqxIBCashReceiptDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	   $(function(){
	        $('#frmIbCashReceipt').validate({
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
			}
			*/
		  var rows = $("#jqxApplyIbCashInvoicing").jqxGrid('getrows');
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
		  var rows = $('#jqxIbCashReceipt').jqxGrid('getrows');
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
	  		    var ibreceiptdate = $('#jqxIBCashReceiptDate').jqxDateTimeInput('getDate');
				var validdate=funDateInPeriod(ibreceiptdate);
				if(parseInt(validdate)==0){
					document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
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
		 		var balanceamt = $("#txtapplyinvoicebalance").val();  
		        if(parseInt(balanceamt)<0){
		        	 document.getElementById("errormsg").innerText= "Invalid applying amount!!!";
					 return 0;
		        }
		    	document.getElementById("errormsg").innerText="";
		    		
		    /* Validation Ends*/
		    		
		     /* Cash Receipt Grid  Saving*/
			  var rows = $("#jqxIbCashReceipt").jqxGrid('getrows');
			  var length=0,val2=0;
			  for(var i=0 ; i < rows.length ; i++){
				    var chk=rows[i].docno;
				    var tramt=rows[i].tramt;
				    var applying = $("#jqxApplyIbCashInvoicing").jqxGrid('getcelltext',i,'applying');
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
							 amount=rows[i].amount1*-1;
							 baseamount=rows[i].baseamount1*-1;
						}
						else if(rows[i].dr==false){
							 amount=rows[i].amount1;
							 baseamount=rows[i].rate*rows[i].amount1;
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
		 		   /* Cash Receipt Grid  Saving Ends*/	 
		 		
		 		/* Applying Invoice Grid Saving */
		 		 var rows = $("#jqxApplyIbCashInvoicing").jqxGrid('getrows');
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
				 /* Applying Invoice Grid Saving Ends*/
				 
				 /* Applying Invoice Grid Updating */
			 		var rows = $("#jqxApplyIbCashInvoicing").jqxGrid('getrows');
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
					 /* Applying Invoice Grid Updating Ends*/
					 
		    		return 1;
	  		}else{
	  			document.getElementById("errormsg").innerText="Inter Brach is not created";
				 return 0;
	  		}
			
			
		} 
	  
	  function setValues(){
		  getBranch();
		  
		  $('#jqxIBCashReceiptDate').jqxDateTimeInput({disabled: false});
		  var date = $('#jqxIBCashReceiptDate').val();
		  getCurrencyId(date);
		  $('#jqxIBCashReceiptDate').jqxDateTimeInput({disabled: true});
		  
		  document.getElementById("cmbtotype").value=document.getElementById("hidcmbtotype").value;
		  
		  if($('#hidjqxIBCashReceiptDate').val()){
				 $("#jqxIBCashReceiptDate").jqxDateTimeInput('val', $('#hidjqxIBCashReceiptDate').val());
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
	         	 $("#jqxIBCashReceiptGrid").load("ibCashReceiptGrid.jsp?txtcashreceiptdocno2="+indexVal+"&check="+check);
			 }
	         var indexVal1 = document.getElementById("txttodocno").value;
	         var indexVal2 = document.getElementById("txttotrno").value;
	         if(indexVal1>0){
	        	 var check = 1;
	         	 $("#jqxIbCashApplyInvoicing1").load("applyIbCashReceiptInvoicingGrid.jsp?txttoaccid1="+indexVal1+"&txttotrno1="+indexVal2+"&check="+check); 
	         }
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
		  var fromamount = $('#txtfrombaseamount').val();
		  
		  if(!isNaN(fromamount)){
			  
		  var dr=0.0,cr=0.0,dr1=0.0;
  	      var rows = $('#jqxIbCashReceipt').jqxGrid('getrows');
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
        	    var rows = $('#jqxIbCashReceipt').jqxGrid('getrows');
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
        	  var date = $('#jqxIBCashReceiptDate').jqxDateTimeInput('getDate');
        	  $("#maindate").jqxDateTimeInput('val', date);
        	  accountFromSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
          }
          else{}
          }
	  
	  function getAccType(event){
          var x= event.keyCode;
          if(x==114){
        	  var date = $('#jqxIBCashReceiptDate').jqxDateTimeInput('getDate');
        	  $("#maindate").jqxDateTimeInput('val', date);
        	  accountToSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtotype').val()+"&date="+date);
          }
          else{}
          }
	  
	  function funPrintBtn() {
			
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
		        var url=document.URL;
		        var reurl=url.split("saveIbCashReceipt");
		        $("#docno").prop("disabled", false);  
		     
		        $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
					if (r){
						 var win= window.open(reurl[0]+"printIBCashReceipt?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					     win.focus();
					 }
					else{
						var win= window.open(reurl[0]+"printIBCashReceipt?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
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
		  $("#jqxApplyIbCashInvoicing").jqxGrid('clear');
		  $("#jqxApplyIbCashInvoicing").jqxGrid('addrow', null, {});
		  var atype=$('#cmbtotype').val();
      	  if(atype != "AR"){
      		$("#jqxApplyIbCashInvoicing").jqxGrid({ disabled: true});
      	  }else if(atype == "AR"){
      		$("#jqxApplyIbCashInvoicing").jqxGrid({ disabled: false});
      	  }
		  if (document.getElementById("txttoaccid").value == "") {
		        $('#txttoaccid').attr('placeholder', 'Press F3 to Search'); 
		  }
	  }
	  
	  function datechange(){
		  var date = $('#jqxIBCashReceiptDate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(date);
		  if(parseInt(validdate)==0){
			document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
			return 0;	
		  }
		  $("#maindate").jqxDateTimeInput('val', date);
		  
		   if($('#cmbtobranch').val()!='' && $('#cmbtobranch').val()!=null){
			  	var validibdate=funIBDateInPeriod($('#jqxIBCashReceiptDate').val(),$('#cmbtobranch').val());
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
	  }
	  
</script>

<style>
/* =========================
   GLOBAL PAGE BASE
========================= */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    max-height: calc(100vh - 140px);
    box-sizing: border-box;
}

/* =========================
   MAIN WHITE CARD
========================= */
#mainBG {
    background: #ffffff;
    border-radius: 16px;
    padding: 12px;
    max-width: 100%;
    margin: 0 auto;
    box-sizing: border-box;
}

/* =========================
   SCROLL CONTAINER (IMPORTANT)
========================= */
.hidden-scrollbar {
    overflow-y: auto;
    overflow-x: hidden;
    max-height: calc(100vh - 140px); /* header + padding safe */
    padding-right: 8px;
    box-sizing: border-box;
}

/* Smooth scroll */
.hidden-scrollbar {
    scroll-behavior: smooth;
}

/* Optional: clean scrollbar */
.hidden-scrollbar::-webkit-scrollbar {
    width: 8px;
}
.hidden-scrollbar::-webkit-scrollbar-thumb {
    background: #c7d7f9;
    border-radius: 6px;
}
.hidden-scrollbar::-webkit-scrollbar-track {
    background: transparent;
}

/* =========================
   TABLE + FIELDSET CLEANUP
========================= */
table {
    border-collapse: collapse;
}

fieldset {
    border: 1px solid #dbe2ef;
    border-radius: 10px;
    padding: 12px 14px;
    margin-bottom: 16px;
    background: #f9fafb;
}

legend {
    padding: 0 10px;
    font-weight: 700;
    color: #253858;
}

/* =========================
   INPUTS / SELECTS
========================= */
input[type="text"],
select {
    height: 28px;
    padding: 4px 8px;
    border: 1px solid #cbd5e1;
    border-radius: 6px;
    font-weight: 600;
    background: #ffffff;
    box-sizing: border-box;
}

input[type="text"]:focus,
select:focus {
    border-color: #007bff;
    outline: none;
}

/* Numbers aligned right */
input[style*="text-align: right"] {
    text-align: right;
}

/* =========================
   BUTTONS
========================= */
.myButton {
    background: #4FA8FF;
    color: #fff;
    border: none;
    border-radius: 6px;
    padding: 4px 12px;
    font-size: 13px;
    font-weight: 700;
    cursor: pointer;
    transition: 0.2s ease-in-out;
}

.myButton:hover {
    background: #2F7FD4;
}

/* Icon buttons */
.icon {
    width: 34px;
    height: 30px;
    border: none;
    border-radius: 6px;
    background: #E0ECF8;
    cursor: pointer;
}

.icon:hover {
    background: #c7d7f9;
}

/* =========================
   GRID CONTAINERS
========================= */
#jqxIBCashReceiptGrid,
#jqxIbCashApplyInvoicing1 {
    margin-top: 12px;
}

/* =========================
   LABELS / TABLE TEXT
========================= */
td,
th,
label {
    font-weight: 700;
    white-space: nowrap;
}


</style>

</head>
<body onload="setValues();getBranch();">

<div id="mainBG" class="homeContent" data-type="background">

<form id="frmIbCashReceipt" action="saveIbCashReceipt" method="post" autocomplete="off">

    <jsp:include page="../../../../header.jsp"></jsp:include>

    <!-- ================= MAIN SCROLL AREA ================= -->
    <div class="hidden-scrollbar">

        <!-- ================= HEADER ROW ================= -->
        <table width="100%">
            <tr>
                <td width="5%" align="right">Date</td>
                <td width="15%">
                    <div id="jqxIBCashReceiptDate"
                         name="jqxIBCashReceiptDate"
                         onchange="datechange();"
                         onblur="datechange();"
                         value='<s:property value="jqxIBCashReceiptDate"/>'></div>
                    <input type="hidden" id="hidjqxIBCashReceiptDate" name="hidjqxIBCashReceiptDate"
                           value='<s:property value="hidjqxIBCashReceiptDate"/>'/>
                </td>

                <td width="10%" align="right">Ref. No.</td>
                <td width="20%">
                    <input type="text" id="txtrefno" name="txtrefno" style="width:60%;"
                           value='<s:property value="txtrefno"/>'/>
                </td>

                <td width="10%" align="right">Doc No.</td>
                <td width="20%">
                    <input type="text" id="docno" name="txtibcashreceiptdocno"
                           style="width:60%;"
                           value='<s:property value="txtibcashreceiptdocno"/>' tabindex="-1"/>
                    <button class="myButton" type="button" id="btnvaluechange"
                            onclick="funwarningopen();">Value Change</button>
                </td>
            </tr>
        </table>

        <!-- ================= CASH / PAYMENT SECTION ================= -->
        <table width="100%">
            <tr>

                <!-- -------- LEFT : CASH -------- -->
                <td width="50%" valign="top">
                    <fieldset>
                        <legend>Cash</legend>

                        <table width="100%">
                            <tr>
                                <td align="right">Cash</td>
                                <td>
                                    <input type="text" id="txtfromaccid" name="txtfromaccid"
                                           placeholder="Press F3 to Search"
                                           value='<s:property value="txtfromaccid"/>'
                                           onkeydown="getAcc(event);"/>
                                </td>
                                <td colspan="2">
                                    <input type="text" id="txtfromaccname" name="txtfromaccname"
                                           value='<s:property value="txtfromaccname"/>' tabindex="-1"/>
                                    <input type="hidden" id="txtfromdocno" name="txtfromdocno"
                                           value='<s:property value="txtfromdocno"/>'/>
                                </td>
                            </tr>

                            <tr>
                                <td align="right">Currency</td>
                                <td>
                                    <select id="cmbfromcurrency" name="cmbfromcurrency"
                                            onchange="getRate(this.value,$('#jqxIBCashReceiptDate').val());">
                                        <option></option>
                                    </select>
                                </td>

                                <td align="right">Rate</td>
                                <td>
                                    <input type="text" id="txtfromrate" name="txtfromrate"
                                           value='<s:property value="txtfromrate"/>'
                                           tabindex="-1"/>
                                </td>
                            </tr>

                            <tr>
                                <td align="right">Amount</td>
                                <td>
                                    <input type="text" id="txtfromamount" name="txtfromamount"
                                           value='<s:property value="txtfromamount"/>'
                                           onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getDrTotal();"/>
                                </td>

                                <td align="right">Base Amount</td>
                                <td>
                                    <input type="text" id="txtfrombaseamount" name="txtfrombaseamount"
                                           value='<s:property value="txtfrombaseamount"/>'
                                           tabindex="-1"/>
                                </td>
                            </tr>

                            <tr>
                                <td align="right">Description</td>
                                <td colspan="3">
                                    <input type="text" id="txtdescription" name="txtdescription"
                                           style="width:90%;"
                                           value='<s:property value="txtdescription"/>'/>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </td>

                <!-- -------- RIGHT : PAYMENT FROM -------- -->
                <td width="50%" valign="top">
                    <fieldset>
                        <legend>Payment From</legend>

                        <table width="100%">
                            <tr>
                                <td align="right">Branch</td>
                                <td colspan="2">
                                    <select id="cmbtobranch" name="cmbtobranch"
                                            onchange="funIBDateInPeriod($('#jqxIBCashReceiptDate').val(),this.value);">
                                        <option></option>
                                    </select>
                                </td>

                                <td align="right">Type</td>
                                <td>
                                    <select id="cmbtotype" name="cmbtotype" onchange="clearClientInfo();">
                                        <option value="AR">AR</option>
                                        <option value="AP">AP</option>
                                    </select>
                                </td>
                            </tr>

                            <tr>
                                <td align="right">Account</td>
                                <td>
                                    <input type="text" id="txttoaccid" name="txttoaccid"
                                           placeholder="Press F3 to Search"
                                           onkeydown="getAccType(event);"/>
                                </td>
                                <td colspan="3">
                                    <input type="text" id="txttoaccname" name="txttoaccname"
                                           value='<s:property value="txttoaccname"/>' tabindex="-1"/>
                                </td>
                            </tr>

                            <tr>
                                <td align="right">Amount</td>
                                <td colspan="2">
                                    <input type="text" id="txttoamount" name="txttoamount"
                                           value='<s:property value="txttoamount"/>'
                                           onblur="funRoundAmt(this.value,this.id);getBaseAmountTo();getCrTotal();"/>
                                </td>

                                <td align="right">Base Amount</td>
                                <td>
                                    <input type="text" id="txttobaseamount" name="txttobaseamount"
                                           value='<s:property value="txttobaseamount"/>' tabindex="-1"/>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </td>

            </tr>
        </table>

        <!-- ================= APPLY INVOICES ================= -->
        <fieldset>
            <legend>Apply Invoices</legend>

            <div id="jqxIbCashApplyInvoicing1">
                <jsp:include page="applyIbCashReceiptInvoicingGrid.jsp"></jsp:include>
            </div>
        </fieldset>

        <!-- ================= MAIN GRID ================= -->
        <div id="jqxIBCashReceiptGrid">
            <jsp:include page="ibCashReceiptGrid.jsp"></jsp:include>
        </div>

        <!-- ================= TOTALS ================= -->
        <table width="100%">
            <tr>
                <td align="right">Dr. Total</td>
                <td><input type="text" id="txtdrtotal" name="txtdrtotal"/></td>

                <td align="right">Cr. Total</td>
                <td><input type="text" id="txtcrtotal" name="txtcrtotal" tabindex="-1"/></td>
            </tr>
        </table>

    </div> <!-- END SCROLL -->

</form>
</div>

</body>

</html>
