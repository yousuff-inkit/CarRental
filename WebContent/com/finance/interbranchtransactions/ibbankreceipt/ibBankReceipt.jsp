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
   SCOPED UI: Segoe UI Font & Clean White Master Layout
========================================================= */
body, .homeContent {
    background-color: #fff !important; /* Pure White Background */
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    color: #333 !important;
    font-size: 12px !important;
    margin: 0;
    padding: 15px; 
    box-sizing: border-box;
}

#mainBG {
    background: #fff;
    border-radius: 8px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    border: 1px solid #e5e7eb; 
}

.modern-ui {
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif; 
    color: #333;
    font-size: 12px; 
    padding-top: 10px;
    box-sizing: border-box;
}

/* Master Input Heights - Set to 24px */
.modern-ui input[type="text"],
.modern-ui select,
.modern-ui textarea { 
    height: 24px !important; 
    border: 1px solid #BDBDBD !important; 
    border-radius: 3px !important; 
    padding: 2px 6px !important;
    font-size: 12px !important;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    box-sizing: border-box; 
    background-color: #fff !important; 
    color: #333 !important;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus { 
    border-color: #007bff !important; 
    background-color: #FFD6FF !important; /* Client Master Focus Color */
    outline: none !important;
}

.modern-ui input[readonly],
.modern-ui input:disabled,
.modern-ui select:disabled { 
    background-color: #f4f5f7 !important; 
    color: #5e6c84 !important;
    border-color: #e1e4e8 !important;
}

/* ROW LAYOUT */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    margin-bottom: 12px; 
    flex-wrap: nowrap;
}

.modern-ui .input-group {
    display: flex;
    align-items: center;
    margin-right: 25px; 
}

/* Labels */
.modern-ui .lbl-right { 
    text-align: right; 
    color: #222 !important;
    font-size: 12px !important; 
    font-weight: 600 !important;
    white-space: nowrap; 
    width: 80px; 
    padding-right: 8px;
    flex-shrink: 0;
}

/* Exact Panel Styling - CLEAN WHITE */
.modern-ui .bordered-panel { 
    border: 1px solid #BDBDBD !important; 
    padding: 10px; 
    background: #fff !important; /* NO BLUE BACKGROUND */
    border-radius: 4px; 
    margin-bottom: 10px;
}

/* Fieldset and Legend styling */
fieldset {
    border: 1px solid #BDBDBD !important;
    background-color: #fff !important; 
    margin-bottom: 15px !important;
    padding: 10px !important;
    border-radius: 4px !important;
}

legend {
    font-size: 13px !important;
    font-weight: bold !important;
    color: #0056b3 !important;
    padding: 0 5px !important;
    border-left: 3px solid #0056b3 !important;
    background: #fff;
}

/* Data Grid Container */
.modern-ui .grid-container {
    border: 1px solid #BDBDBD;
    border-radius: 4px;
    overflow: hidden;
    background: #fff;
    margin-bottom: 10px;
}

/* Magnifier Icon Styling */
.input-search-container {
    position: relative;
    display: block;
    width: 100%;
}
.input-search-container input {
    padding-right: 25px !important;
}
.magnifier-icon {
    position: absolute;
    right: 4px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
.magnifier-icon:hover { color: #2563eb; }

/* Action Buttons */
.modern-ui .myButton {
    height: 24px !important;
    padding: 0 15px !important;
    background-color: #0056b3 !important;
    color: #ffffff !important;
    border: none !important;
    border-radius: 3px !important;
    cursor: pointer !important;
    font-size: 12px !important;
    font-weight: bold !important;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
}
.modern-ui .myButton:hover { background-color: #004494 !important; }

.modern-ui .btn-warning { background-color: #f39c12 !important; }
.modern-ui .btn-warning:hover { background-color: #e67e22 !important; }

/* Table adjustments for compact text */
table td {
    padding: 4px 6px !important;
    font-size: 12px !important;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    color: #222 !important;
    font-weight: 600 !important;
    vertical-align: middle;
}

/* Validation Error override */
.modern-ui #errormsg, #validrate, #validrate1 {
    color: red;
    font-weight: bold;
    font-size: 12px;
}

.hidden-scrollbar { 
    overflow: auto; 
    height: calc(100vh - 100px);
}
.hidden-scrollbar::-webkit-scrollbar { width: 0px; }
</style>

<script type="text/javascript">
	$(document).ready(function() {
		 $("#btnvaluechange").hide();
		 
         /* CLEAN JQX DATE SETUP (No CSS Hacks) */ 
		 $("#jqxIbBankReceiptDate").jqxDateTimeInput({ width: '130px', height: '24px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '130px', height: '24px', formatString:"dd.MM.yyyy"});
		 $("#jqxChequeDate").jqxDateTimeInput({ width: '130px', height: '24px', formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsToWindow').jqxWindow('close');  
		 
		 $('#accountDetailsFromWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsFromWindow').jqxWindow('close');
		 
		 $('#ibBankReceiptGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#ibBankReceiptGridWindow').jqxWindow('close');
		 
		 $('#branchSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Branch Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#branchSearchWindow').jqxWindow('close');
 		 
 		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costTypeSearchGridWindow').jqxWindow('close');
		 
		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
		 
		 $('#printWindow').jqxWindow({width: '51%', height: '31%',  maxHeight: '50%' ,maxWidth: '51%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#printWindow').jqxWindow('close');
 		 
		 $('#txtfromaccid').dblclick(function(){ openFromAccSearch(); });
		 $('#txttoaccid').dblclick(function(){ openToAccSearch(); });  
			  
 		 $('#jqxIbBankReceiptDate').on('change', function (event) {
			var ibbankreceiptdate = $('#jqxIbBankReceiptDate').jqxDateTimeInput('getDate');
			var validdate=funDateInPeriod(ibbankreceiptdate);
			if(parseInt(validdate)==0){
				if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
			}
		 });
	});

    /* Click Handlers for Magnifier Icons */
    function openFromAccSearch() {
        var date = $('#jqxIbBankReceiptDate').jqxDateTimeInput('getDate');
        $("#maindate").jqxDateTimeInput('val', date);
        accountFromSearchContent("<%=contextPath%>/com/finance/accountsDetailsSearch.jsp?date="+date);
    }

    function openToAccSearch() {
        var date = $('#jqxIbBankReceiptDate').jqxDateTimeInput('getDate');
        $("#maindate").jqxDateTimeInput('val', date);
        accountToSearchContent("<%=contextPath%>/com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtotype').val()+"&date="+date);
    }
	
	function BankSearchContent(url) {
		$('#ibBankReceiptGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#ibBankReceiptGridWindow').jqxWindow('setContent', data);
		$('#ibBankReceiptGridWindow').jqxWindow('bringToFront');
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
 					 if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Cheque No. Already Exists.";
 					 return 0;
 				 }
 				if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="";
 		}
	}
	x.open("GET", "<%=contextPath%>/com/finance/getChequeNoAlreadyExists.jsp?chequeno="+chequeno+'&bankacno='+bankacno+'&mode='+mode+'&docno='+docno, true);
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
	
	/* SAFE READONLY FUNCTION */
	 function funReadOnly(){
	     try {
			$('#frmIbBankReceipt input').attr('readonly', true );
			$('#frmIbBankReceipt select').attr('disabled', true);
			$('#chckpdc').attr('disabled', true);
			$('#jqxIbBankReceiptDate').jqxDateTimeInput({disabled: true});
			$('#jqxChequeDate').jqxDateTimeInput({disabled: true});
			if($("#jqxApplyIbBankInvoicing").length) $("#jqxApplyIbBankInvoicing").jqxGrid({ disabled: true});
			if($("#jqxIbBankReceipt").length) $("#jqxIbBankReceipt").jqxGrid({ disabled: true});
			$("#btnvaluechange").hide();
			if(parseInt($("#pdcposttrno").val())!=0){
				 $("#btnEdit").attr('disabled', true);
				 $("#btnDelete").attr('disabled', true);
			 }
	     } catch(e) { console.error("Error in funReadOnly: ", e); }
	 }

    /* SAFE REMOVE READONLY FUNCTION */
	 function funRemoveReadOnly(){
	     try {
		    getBranch();checkpdc();
			$('#frmIbBankReceipt input').attr('readonly', false );
			$('#frmIbBankReceipt select').attr('disabled', false);
			$('#txtfromaccid').attr('readonly', true );
			$('#txtfromaccname').attr('readonly', true );
			$('#txttoaccid').attr('readonly', true );
			$('#txttoaccname').attr('readonly', true );
			if($('#txtapplyinvoiceamt').length) $('#txtapplyinvoiceamt').attr('readonly', true );
			if($('#txtapplyinvoiceapply').length) $('#txtapplyinvoiceapply').attr('readonly', true );
			if($('#txtapplyinvoicebalance').length) $('#txtapplyinvoicebalance').attr('readonly', true );
			$('#txtdrtotal').attr('readonly', true );
			$('#txtcrtotal').attr('readonly', true );
			$('#jqxIbBankReceiptDate').jqxDateTimeInput({disabled: false});
			$('#jqxChequeDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			
			if($("#jqxApplyIbBankInvoicing").length) $("#jqxApplyIbBankInvoicing").jqxGrid({ disabled: false}); 
			if($("#jqxIbBankReceipt").length) $("#jqxIbBankReceipt").jqxGrid({ disabled: false});
			
			var date = $('#jqxIbBankReceiptDate').val();
		    if(typeof getCurrencyId === 'function') getCurrencyId(date);
			
			if ($("#mode").val() == "E") {
         	    $("#btnvaluechange").show();
         	    $('#frmIbBankReceipt input').attr('readonly', true );
   			    $('#frmIbBankReceipt select').attr('disabled', true);
				$('#chckpdc').attr('disabled', true);
   			    $('#jqxChequeDate').jqxDateTimeInput({disabled: true});
   			    if($("#jqxApplyIbBankInvoicing").length) $("#jqxApplyIbBankInvoicing").jqxGrid({ disabled: true});
			    if($("#jqxIbBankReceipt").length) {
			        $("#jqxIbBankReceipt").jqxGrid({ disabled: true});
			    }
   			    $('#txtrefno').attr('readonly', false );
   			 	$('#txtdescription').attr('readonly', false );
   			 	
   			 	if($("#jqxIbBankReceipt").length) {
   			 	    $("#jqxIbBankReceipt").jqxGrid('addrow', null, {"docno": "","branch": "","brhid": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","costtype": "","costgroup": "","costcode": "","dr": true,"amount1": "","baseamount1": "","description": "","grtype": "","currencytype": "","sr_no":""});
   			 	}
			  }
			 else{
				$("#btnvaluechange").hide();
			}
			
			if ($("#mode").val() == "A") {
				$('#jqxIbBankReceiptDate').val(new Date());
				$('#jqxChequeDate').val(new Date());
				$('#chckpdc').attr('disabled', false);
				if($("#jqxIbBankReceipt").length) {
    				$("#jqxIbBankReceipt").jqxGrid('clear'); 
    				$("#jqxIbBankReceipt").jqxGrid('addrow', null, {"docno": "","branch": "","brhid": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","costtype": "","costgroup": "","costcode": "","dr": true,"amount1": "","baseamount1": "","description": "","grtype": "","currencytype": "","sr_no":""});
				}
				if($("#jqxApplyIbBankInvoicing").length) {
    				$("#jqxApplyIbBankInvoicing").jqxGrid('clear');
    				$("#jqxApplyIbBankInvoicing").jqxGrid('addrow', null, {});
				}
			}
	     } catch(e) { console.error("Error in funRemoveReadOnly: ", e); }
	 }
	
	 function funSearchLoad(){ changeContent('ibrMainSearch.jsp'); }
		
	 function funChkButton() { }
	
	 function funFocus() { $('#jqxIbBankReceiptDate').jqxDateTimeInput('focus'); }
	
	  /* Validations */
	   $(function(){
	        $('#frmIbBankReceipt').validate({
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
		  
		  if($("#jqxApplyIbBankInvoicing").length) {
		      var rows = $("#jqxApplyIbBankInvoicing").jqxGrid('getrows');
    		  for(var i=0 ; i < rows.length ; i++){
        		  var balanceamt=rows[i].balance;
        		  if(balanceamt<0){
        	 	     if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText= "Invalid applying amount!!!";
        			 return 0;
        	      } 
    		  }
		  }
			
		  var brname=$('#brchName').val();
		  var cmbtobranch=$('#cmbtobranch').val();
		  var id=0;
		  var list1=new Array();
		  
		  if($("#jqxIbBankReceipt").length) {
		      var rows = $('#jqxIbBankReceipt').jqxGrid('getrows');
    		  for(var i=0 ; i < rows.length ; i++){
    			    var chk=rows[i].docno;
    			    if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
    			    	list1.push(rows[i].brhid);
    				}
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
	 			}
	 		}
	 		x.open("GET",<%=contextPath+"/"%>+"com/finance/interbranchtransactions/checkInterBranch.jsp?br1="+brname+'&br2='+cmbtobranch+'&list1='+encodeURIComponent(list1), false);
	 		x.send();
	 		
	 		if(id==1){
	 		    var ibbankreceiptdate = $('#jqxIbBankReceiptDate').jqxDateTimeInput('getDate');
	 			var validdate=funDateInPeriod(ibbankreceiptdate);
	 			if(parseInt(validdate)==0){
	 			  if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
	 			  return 0;	
	 			}
	 			
	 			var pdcchequevalid=document.getElementById("txtpdcdatevalidation") ? document.getElementById("txtpdcdatevalidation").value : 0;
	 			 if(pdcchequevalid==1){
	 				 if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Invalid Cheque Date !!!";
	 				 return 0;
	 			 }
	 			
	 			var ibvalid=document.getElementById("txtibvalidation") ? document.getElementById("txtibvalidation").value : 0;
	 			 if(ibvalid==1){
	 				 if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Closing Done For Inter-Branch,Transaction Restricted. ";
	 				 return 0;
	 			 }
	 			
	 			 var valid=document.getElementById("txtvalidation") ? document.getElementById("txtvalidation").value : 0;
	 			 if(valid==1){
	 				 if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Invalid Transaction !!!";
	 				 return 0;
	 			 }
	 			
	 			 var currency=document.getElementById("cmbfromcurrency") ? document.getElementById("cmbfromcurrency").value : "";
	 			 if(currency==""){
	 				 if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Currency & Rate is Mandatory.";
	 				 return 0;
	 			 }
	 			
	 			 var currencyto=document.getElementById("cmbtocurrency") ? document.getElementById("cmbtocurrency").value : "";
	 			 var acnoto=document.getElementById("txttoaccid") ? document.getElementById("txttoaccid").value : "";
	 			 if(currencyto=="" && acnoto!=""){
	 				 if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Currency & Rate is Mandatory.";
	 				 return 0;
	 			 }
	 		  
	 		    var drtot = parseFloat(document.getElementById("txtdrtotal").value || 0);
	 	 		var crtot = parseFloat(document.getElementById("txtcrtotal").value || 0);
	 	 		if(drtot>crtot || drtot<crtot){
	 	 			 if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should be Equal.";
	                 return 0;
	 	 		}
	 	 		
	 	 		if(drtot=="" || crtot=="" || drtot=="NaN" || crtot=="NaN" || drtot==0 || crtot==0 || drtot==0.0 || crtot==0.0 || drtot==0.00 || crtot==0.00){
	 	 			  if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should not be Zero.";
	 	              return 0;
	 		 	}
	 		 		
	 	 		var balanceamt = $("#txtapplyinvoicebalance").val();  
		        if(parseInt(balanceamt)<0){
		        	 if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText= "Invalid applying amount!!!";
					 return 0;
		        }
	 	 		
	 	        if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="";
	 	    /* Validation Ends*/
	 	    
	 	    	/* Bank Receipt Grid  Saving*/
	 	    	if($("#jqxIbBankReceipt").length) {
	 	 		  var rows = $("#jqxIbBankReceipt").jqxGrid('getrows');
	 	 		  var length=0,val2=0;
	 			  for(var i=0 ; i < rows.length ; i++){
	 				    var chk=rows[i].docno;
	 				    var tramt=rows[i].tramt;
					    var applying = $("#jqxApplyIbBankInvoicing").length ? $("#jqxApplyIbBankInvoicing").jqxGrid('getcelltext',i,'applying') : 0;
					    
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
	 							 baseamount=rows[i].baseamount1;
	 						}
	 						
	 					newTextBox.val(rows[i].docno+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+rows[i].dr+"::"+amount+"::"+rows[i].description+"::"+baseamount+"::0:: "+rows[i].costtype+":: "+rows[i].costcode+"::"+rows[i].brhid);
	 					newTextBox.appendTo('form');
	 					}
	 			  }
	 			  if(val2==1){   
	 				 if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText= "Invalid applying amount!!!";
					 return 0; 
	 			  } 
	 		      $('#gridlength').val(length);
	 	    	}
	 	 		   /* Bank Receipt Grid  Saving Ends*/	 
	 	 		
	 	 		/* Applying Bank Invoice Grid Saving */
	 	 		if($("#jqxApplyIbBankInvoicing").length) {
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
	 				  
	 				  var lengthupdate=0;
	 				  var rowsUpdate = $("#jqxApplyIbBankInvoicing").jqxGrid('getrows');
	 				  for(var i=0 ; i < rowsUpdate.length ; i++){
	 					 	var chkd=rowsUpdate[i].applying;
	 			 				if(typeof(chkd) != "undefined" && typeof(chkd) != "NaN" && chkd != ""){
	 							newTextBox = $(document.createElement("input"))
	 						    .attr("type", "dil")
	 						    .attr("id", "txtapplyupdate"+lengthupdate)
	 						    .attr("name", "txtapplyupdate"+lengthupdate)
	 						    .attr("hidden", "true");
	 							lengthupdate=lengthupdate+1;
	 							
	 						newTextBox.val(parseFloat(rowsUpdate[i].out_amount-rowsUpdate[i].applying)+"::"+rowsUpdate[i].tranid);
	 						newTextBox.appendTo('form');
	 						}
	 					}
	 					$('#applylengthupdate').val(lengthupdate);
	 	 		}
	 	 			 /* Applying Bank Invoice Grid Updating Ends*/
	 	 			
	 	 			 $('#jqxIbBankReceiptDate').jqxDateTimeInput({disabled: false});
	 			     $('#jqxChequeDate').jqxDateTimeInput({disabled: false});
	 			     
	 	    		return 1;
	 		}else{
	 			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Inter Brach is not created";
				return 0;
	 		}
		} 
	  
	  /* SAFE SET VALUES FUNCTION */
	  function setValues(){
	      try {
    		  if(typeof getBranch === 'function') getBranch();
    		  if(typeof checkpdc === 'function') checkpdc();
    		  
    		  $('#jqxIbBankReceiptDate').jqxDateTimeInput({disabled: false});
    		  var date = $('#jqxIbBankReceiptDate').val();
    		  if(typeof getCurrencyId === 'function') getCurrencyId(date);
    		  $('#jqxIbBankReceiptDate').jqxDateTimeInput({disabled: true});
    		  
    		  if(document.getElementById("cmbtotype") && document.getElementById("hidcmbtotype")) {
    		      document.getElementById("cmbtotype").value=document.getElementById("hidcmbtotype").value;
    		  }
    		  
    		  if($('#hidjqxIbBankReceiptDate').length && $('#hidjqxIbBankReceiptDate').val()){
    				 $("#jqxIbBankReceiptDate").jqxDateTimeInput('val', $('#hidjqxIbBankReceiptDate').val());
    			  }
    		  
    		  if($('#hidjqxChequeDate').length && $('#hidjqxChequeDate').val()){
    				 $("#jqxChequeDate").jqxDateTimeInput('val', $('#hidjqxChequeDate').val());
    			  }
    		  
    		  if($('#hidmaindate').length && $('#hidmaindate').val()){
    				 $("#maindate").jqxDateTimeInput('val', $('#hidmaindate').val());
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
    			  
    		     var indexVal = document.getElementById("docno") ? document.getElementById("docno").value : 0;
    			 if(indexVal>0 && $("#jqxIbBankReceiptGrid").length){
    				 var check = 1;
    	             $("#jqxIbBankReceiptGrid").load("ibBankReceiptGrid.jsp?txtibbankreceiptdocno2="+indexVal+"&check="+check);
    			 }
    	         
    	         var indexVal1 = document.getElementById("txttodocno") ? document.getElementById("txttodocno").value : 0;
    	         var indexVal2 = document.getElementById("txttotrno") ? document.getElementById("txttotrno").value : 0;
    	         if(indexVal1>0 && $("#bankApplyInvoicing1").length){
    	         	 var check = 1;
    	             $("#bankApplyInvoicing1").load("applyIbBankReceiptInvoicingGrid.jsp?txttoaccid1="+indexVal1+"&txttotrno1="+indexVal2+"&check="+check); 
    	         }
    	         
    	         if(typeof funRoundRate === "function"){
    	             funRoundRate($('#txtfromrate').val(),"txtfromrate");
    	             funRoundRate($('#txttorate').val(),"txttorate");
    	         }
    	         if(typeof funRoundAmt === "function"){
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
	      } catch(e) { console.error("Error in setValues: ", e); }
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
	  				if ($('#hidcmbtobranch').length && $('#hidcmbtobranch').val() != null) {
	  					$('#cmbtobranch').val($('#hidcmbtobranch').val());
	  				}
	  			}
	  		}
	  		x.open("GET", "<%=contextPath%>/com/finance/interbranchtransactions/getBranch.jsp", true);
	  		x.send();
	  	}
	  
	  function getDrTotal(){
		  var toamount = $('#txttobaseamount').val();
		  
		  if(!isNaN(toamount)){
			  
		  var dr=0.0,cr=0.0,dr1=0.0;
		  if($("#jqxIbBankReceipt").length) {
      	      var rows = $('#jqxIbBankReceipt').jqxGrid('getrows');
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
		  }
	 		
	 		if(!isNaN(toamount)){
                dr1=parseFloat(dr) + parseFloat(toamount);
                if(typeof funRoundAmt === "function") funRoundAmt(dr1,"txtdrtotal");
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
			    if($("#jqxIbBankReceipt").length) {
            	    var rows = $('#jqxIbBankReceipt').jqxGrid('getrows');
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
			    }
        		
        		if(!isNaN(fromamount)){
                    cr1=parseFloat(cr) + parseFloat(fromamount);
                    if(typeof funRoundAmt === "function") funRoundAmt(cr1,"txtcrtotal");
                }
		  }
		  else if(isNaN(fromamount)){
		  	$('#txtcrtotal').val(0.00);
		  	$('#txtfrombaseamount').val(0.00);
		  }
	  } 
	  
	  function getAmount(){
		  var toamount = $('#txttoamount').val();
		  if(!isNaN(toamount) && $('#txtapplyinvoiceamt').length){
		      $('#txtapplyinvoiceamt').val(toamount);
		  }
		  else if(isNaN(toamount)){
		      if($('#txtapplyinvoiceamt').length) $('#txtapplyinvoiceamt').val(0.00);
			  $('#txttoamount').val(0.00);
			}
	  }
	  
	  function getAcc(event){
        var x= event.keyCode;
        if(x==114){
          openFromAccSearch();
        }
      }
	  
	  function getAccType(event){
        var x= event.keyCode;
        if(x==114){
          openToAccSearch();
        }
      }
	  
	  function funCheck(a){
		  if(document.getElementById("chckpdc").checked != false){
		 		 $('#hidchckpdc').val(1);
		 		 if(typeof getAccounts === 'function') getAccounts();
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
		        var url=document.URL;
		        var reurl=url.split("saveIbBankReceipt");
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
		  $("#txttodocno").val('');$("#txttoaccid").val('');$("#txttoaccname").val('');
		  if($('#txtapplyinvoiceapply').length) $("#txtapplyinvoiceapply").val(0.00);
		  
		  if($("#jqxApplyIbBankInvoicing").length) {
    		  $("#jqxApplyIbBankInvoicing").jqxGrid('clear');
    		  $("#jqxApplyIbBankInvoicing").jqxGrid('addrow', null, {});
    		  var atype=$('#cmbtotype').val();
          	  if(atype != "AR"){
          		$("#jqxApplyIbBankInvoicing").jqxGrid({ disabled: true});
          	   }else if(atype == "AR"){
          		$("#jqxApplyIbBankInvoicing").jqxGrid({ disabled: false});
          	   }
		  }
		   if (document.getElementById("txttoaccid") && document.getElementById("txttoaccid").value == "") {
		        $('#txttoaccid').attr('placeholder', 'Press F3 to Search'); 
		   }
	  }
	  
	  function datechange(){
		  var date = $('#jqxIbBankReceiptDate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(date);
		  if(parseInt(validdate)==0){
			  if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
			  return 0;	
		  }
		  $("#maindate").jqxDateTimeInput('val', date);
		  
		  if($('#cmbtobranch').val()!='' && $('#cmbtobranch').val()!=null){
		  	var validibdate=funIBDateInPeriod($('#jqxIbBankReceiptDate').val(),$('#cmbtobranch').val());
			if(parseInt(validibdate)==0){
				if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Closing Done, Transaction Restricted.";
				return 0;	
		    }
			
			if(parseInt($('#brchName').val().trim())==parseInt($('#cmbtobranch').val().trim())){
			    if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Invalid Transaction !!! Main Branch and Inter-Branch should not be same.";
				return 0;
			}
			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="";
		  }
		  
		  if(typeof funPDCDate === 'function') {
		      funPDCDate($('#hidchckpdc').val(),$('#jqxIbBankReceiptDate').jqxDateTimeInput('getDate'),$('#jqxChequeDate').jqxDateTimeInput('getDate'));
		  }
	  }
	  
</script>
</head>

<body onload="setValues();getBranch();">

<div id="mainBG" class="homeContent hidden-scrollbar" data-type="background">
<form id="frmIbBankReceipt" action="saveIbBankReceipt" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class="modern-ui">

    <span id="errormsg" style="display:block; margin-bottom:10px;"></span>

    <div class="bordered-panel">
        <div class="field-row">
            <div class="input-group">
                <label class="lbl-right">Date</label>
                <div id="jqxIbBankReceiptDate" name="jqxIbBankReceiptDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxIbBankReceiptDate"/>'></div>
                <input type="hidden" id="hidjqxIbBankReceiptDate" name="hidjqxIbBankReceiptDate" value='<s:property value="hidjqxIbBankReceiptDate"/>'/>
            </div>

            <div class="input-group">
                <label class="lbl-right" style="width: 60px;">Ref. No.</label>
                <input type="text" id="txtrefno" name="txtrefno" style="width: 200px;" value='<s:property value="txtrefno"/>'/>
            </div>

            <div class="input-group">
                <label class="lbl-right" style="width: 60px;">Doc No.</label>
                <input type="text" id="docno" name="txtibbankreceiptdocno" style="width: 150px; background-color:#f4f5f7;" value='<s:property value="txtibbankreceiptdocno"/>' tabindex="-1" readonly="readonly"/>
                <button class="myButton btn-warning" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();" style="margin-left: 10px;">Value Change</button>
            </div>
        </div>
    </div>

    <table width="100%">
        <tr>
            <td width="50%" valign="top" style="padding-right: 10px;">
                <fieldset>
                    <legend>Bank Details (From)</legend>
                    <table width="100%" border="0" cellspacing="0" cellpadding="4">
                        <tr>
                            <td class="lbl-right" width="20%">Bank</td>
                            <td colspan="3">
                                <div style="display: flex; gap: 5px;">
                                    <div class="input-search-container" style="width: 110px; flex-shrink: 0;">
                                        <input type="text" id="txtfromaccid" name="txtfromaccid" placeholder="Press F3" value='<s:property value="txtfromaccid"/>' onkeydown="getAcc(event);" readonly/>
                                        <svg class="magnifier-icon" onclick="openFromAccSearch();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                                    </div>
                                    <input type="text" id="txtfromaccname" name="txtfromaccname" style="flex-grow: 1; background-color:#f4f5f7;" value='<s:property value="txtfromaccname"/>' tabindex="-1" readonly/>
                                    <input type="hidden" id="txtfromdocno" name="txtfromdocno" value='<s:property value="txtfromdocno"/>'/>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="lbl-right">Currency</td>
                            <td>
                                <select id="cmbfromcurrency" name="cmbfromcurrency" onchange="getRate(this.value,$('#jqxIbBankReceiptDate').val());" value='<s:property value="cmbfromcurrency"/>'>
                                    <option></option>
                                </select>
                                <input type="hidden" id="hidcmbfromcurrency" name="hidcmbfromcurrency" value='<s:property value="hidcmbfromcurrency"/>'/>
                                <input type="hidden" id="hidfromcurrencytype" name="hidfromcurrencytype" value='<s:property value="hidfromcurrencytype"/>'/>
                            </td>
                            <td class="lbl-right" width="15%">Rate</td>
                            <td>
                                <input type="text" id="txtfromrate" name="txtfromrate" style="text-align: right;" value='<s:property value="txtfromrate"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getCrTotal();" tabindex="-1"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="lbl-right">
                                <label style="cursor:pointer; display:flex; align-items:center; justify-content:flex-end; gap:4px; font-weight:bold; font-size:12px; color:#444;">
                                    <input type="checkbox" id="chckpdc" name="chckpdc" onclick="funCheck();funPDCDate($('#hidchckpdc').val(),$('#jqxIbBankReceiptDate').jqxDateTimeInput('getDate'),$('#jqxChequeDate').jqxDateTimeInput('getDate'));" style="margin:0;"> PDC
                                </label>
                            </td>
                            <td>
                                <input type="text" id="txtchequeno" name="txtchequeno" placeholder="Cheque No." onblur="getChequeNoAlreadyExists(this.value,$('#txtfromdocno').val(),$('#mode').val(),$('#docno').val());" value='<s:property value="txtchequeno"/>'/>
                            </td>
                            <td class="lbl-right">Cheque Dt.</td>
                            <td>
                                <div id="jqxChequeDate" name="jqxChequeDate" onchange="funPDCDate($('#hidchckpdc').val(),$('#jqxIbBankReceiptDate').jqxDateTimeInput('getDate'),$('#jqxChequeDate').jqxDateTimeInput('getDate'));" value='<s:property value="jqxChequeDate"/>'></div>
                                <input type="hidden" id="hidjqxChequeDate" name="hidjqxChequeDate" value='<s:property value="hidjqxChequeDate"/>'/>
                            </td>
                        </tr>
                        <tr>
                            <td class="lbl-right">Cheque Name</td>
                            <td colspan="3">
                                <input type="text" id="txtchequename" name="txtchequename" value='<s:property value="txtchequename"/>'/>
                            </td>
                        </tr>
                        <tr>
                            <td class="lbl-right">Amount</td>
                            <td>
                                <input type="text" id="txtfromamount" name="txtfromamount" style="text-align: right;" value='<s:property value="txtfromamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getCrTotal();"/>
                            </td>
                            <td class="lbl-right">Base Amt</td>
                            <td>
                                <input type="text" id="txtfrombaseamount" name="txtfrombaseamount" style="text-align: right; background-color:#f4f5f7;" value='<s:property value="txtfrombaseamount"/>' tabindex="-1" readonly="readonly"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="lbl-right">Description</td>
                            <td colspan="3">
                                <input type="text" id="txtdescription" name="txtdescription" value='<s:property value="txtdescription"/>'/>
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>

            <td width="50%" valign="top" style="padding-left: 10px;">
                <fieldset>
                    <legend>Received From</legend>
                    <table width="100%" border="0" cellspacing="0" cellpadding="4">
                        <tr>
                            <td class="lbl-right" width="20%">Branch</td>
                            <td width="40%">
                                <select id="cmbtobranch" name="cmbtobranch" onchange="funIBDateInPeriod($('#jqxIbBankReceiptDate').val(),this.value);" value='<s:property value="cmbtobranch"/>'>
                                    <option></option>
                                </select>
                                <input type="hidden" id="hidcmbtobranch" name="hidcmbtobranch" value='<s:property value="hidcmbtobranch"/>'/>
                            </td>
                            <td class="lbl-right" width="15%">Type</td>
                            <td width="25%">
                                <select id="cmbtotype" name="cmbtotype" onchange="clearClientInfo();" value='<s:property value="cmbtotype"/>'>
                                    <option value="AP">AP</option>
                                    <option value="AR">AR</option>
                                </select>
                                <input type="hidden" id="hidcmbtotype" name="hidcmbtotype" value='<s:property value="hidcmbtotype"/>'/>
                            </td>
                        </tr>
                        <tr>
                            <td class="lbl-right">Account</td>
                            <td colspan="3">
                                <div style="display: flex; gap: 5px;">
                                    <div class="input-search-container" style="width: 110px; flex-shrink: 0;">
                                        <input type="text" id="txttoaccid" name="txttoaccid" placeholder="Press F3" value='<s:property value="txttoaccid"/>' onkeydown="getAccType(event);" readonly/>
                                        <svg class="magnifier-icon" onclick="openToAccSearch();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                                    </div>
                                    <input type="text" id="txttoaccname" name="txttoaccname" style="flex-grow: 1; background-color:#f4f5f7;" value='<s:property value="txttoaccname"/>' tabindex="-1" readonly/>
                                    <input type="hidden" id="txttodocno" name="txttodocno" value='<s:property value="txttodocno"/>'/>
                                    <input type="hidden" id="txttotranid" name="txttotranid" value='<s:property value="txttotranid"/>'/>
                                    <input type="hidden" id="txttotrno" name="txttotrno" value='<s:property value="txttotrno"/>'/>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="lbl-right">Currency</td>
                            <td>
                                <select id="cmbtocurrency" name="cmbtocurrency" onchange="getRatevalue(this.value,$('#jqxIbBankReceiptDate').val());" value='<s:property value="cmbtocurrency"/>'>
                                    <option></option>
                                </select>
                                <input type="hidden" id="hidcmbtocurrency" name="hidcmbtocurrency" value='<s:property value="hidcmbtocurrency"/>'/>
                                <input type="hidden" id="hidtocurrencytype" name="hidtocurrencytype" value='<s:property value="hidtocurrencytype"/>'/>
                            </td>
                            <td class="lbl-right">Rate</td>
                            <td>
                                <input type="text" id="txttorate" name="txttorate" style="text-align: right;" value='<s:property value="txttorate"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountTo();getDrTotal();" tabindex="-1"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="lbl-right">Amount</td>
                            <td>
                                <input type="text" id="txttoamount" name="txttoamount" style="text-align: right;" value='<s:property value="txttoamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountTo();getAmount();getDrTotal();"/>
                            </td>
                            <td class="lbl-right">Base Amt</td>
                            <td>
                                <input type="text" id="txttobaseamount" name="txttobaseamount" style="text-align: right; background-color:#f4f5f7;" value='<s:property value="txttobaseamount"/>' tabindex="-1" readonly="readonly"/>
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>
    </table>

    <fieldset>
        <legend>Apply Invoices</legend>
        <div class="grid-container" id="bankApplyInvoicing1" style="margin-bottom: 10px;"><jsp:include page="applyIbBankReceiptInvoicingGrid.jsp"></jsp:include></div>
        
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
            <tr>
                <td class="lbl-right" width="10%">Amount</td>
                <td width="20%">
                    <input type="text" id="txtapplyinvoiceamt" name="txtapplyinvoiceamt" style="text-align: right; background-color:#f4f5f7;" value='<s:property value="txtapplyinvoiceamt"/>' readonly="readonly"/>
                    <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
                </td>
                <td class="lbl-right" width="10%">Applied</td>
                <td width="20%">
                    <input type="text" id="txtapplyinvoiceapply" name="txtapplyinvoiceapply" style="text-align: right; background-color:#f4f5f7;" value='<s:property value="txtapplyinvoiceapply"/>' tabindex="-1" readonly="readonly"/>
                </td>
                <td class="lbl-right" width="10%">Balance</td>
                <td width="30%">
                    <input type="text" id="txtapplyinvoicebalance" name="txtapplyinvoicebalance" style="text-align: right; background-color:#f4f5f7;" value='<s:property value="txtapplyinvoicebalance"/>' tabindex="-1" readonly="readonly"/>
                </td>
            </tr>
        </table>
    </fieldset>

    <div class="grid-container" id="jqxIbBankReceiptGrid"><jsp:include page="ibBankReceiptGrid.jsp"></jsp:include></div>

    <table width="100%" border="0" cellspacing="0" cellpadding="2" style="margin-top: 10px;">
        <tr>
            <td width="10%" class="lbl-right">Dr. Total</td>
            <td width="20%">
                <input type="text" id="txtdrtotal" name="txtdrtotal" style="text-align: right; background-color:#f4f5f7;" value='<s:property value="txtdrtotal"/>' tabindex="-1" readonly="readonly"/>
            </td>
            <td width="40%"></td>
            <td width="10%" class="lbl-right">Cr. Total</td>
            <td width="20%">
                <input type="text" id="txtcrtotal" name="txtcrtotal" style="text-align: right; background-color:#f4f5f7;" value='<s:property value="txtcrtotal"/>' tabindex="-1" readonly="readonly"/>
            </td>
        </tr>
    </table>

    <div style="display:none;">
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" name="txtforsearch" id="txtforsearch" value="0"/>
        
        <input type="hidden" id="txtfromdocno" name="txtfromdocno" value='<s:property value="txtfromdocno"/>'/>
        <input type="hidden" id="hidchckpdc" name="hidchckpdc" value='<s:property value="hidchckpdc"/>'/>
        <input type="hidden" id="txtpdcacno" name="txtpdcacno" value='<s:property value="txtpdcacno"/>'/>
        
        <div id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
        <input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
        <input type="hidden" id="txtibvalidation" name="txtibvalidation" value='<s:property value="txtibvalidation"/>'/>
        <input type="hidden" id="txtpdcdatevalidation" name="txtpdcdatevalidation" value='<s:property value="txtpdcdatevalidation"/>'/>
        <input type="hidden" id="gridlength" name="gridlength"/>
        <input type="hidden" id="applylength" name="applylength"/>
        <input type="hidden" id="applylengthupdate" name="applylengthupdate"/>
        <input type="hidden" id="pdcposttrno" name="pdcposttrno" value='<s:property value="pdcposttrno"/>'/>
        
        <input type="hidden" id="formdetail" name="formdetail" value='<s:property value="formdetail"/>'/>
        <input type="hidden" id="formdetailcode" name="formdetailcode" value='<s:property value="formdetailcode"/>'/>
        <span id="formdet"></span>
    </div>

</div>
</form>

<div id="ibBankReceiptGridWindow"><div></div><div></div></div>   
<div id="accountDetailsFromWindow"><div></div><div></div></div>   
<div id="accountDetailsToWindow"><div></div><div></div></div> 
<div id="branchSearchWindow"><div></div><div></div></div>
<div id="costTypeSearchGridWindow"><div></div><div></div></div> 
<div id="costCodeSearchWindow"><div></div><div></div></div> 
<div id="printWindow"><div></div><div></div></div> 

</div>
</body>
</html>