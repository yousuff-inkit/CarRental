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
SCOPED UI: Bulletproof Table Layout (Does NOT affect header.jsp)
========================================================= */

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 10px 20px;
    box-sizing: border-box;
    width: 100%;
}

.modern-ui .erp-form-area {
    background-color: #f4f7fb;
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    padding: 15px 10px;
    margin-bottom: 10px;
    /* FIXED: Removed the 1050px min-width that was causing the overlap! */
    width: 100%;
    box-sizing: border-box;
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui select { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

.modern-ui table {
    border-collapse: collapse;
    width: 100%;
}

.modern-ui td {
    padding: 4px 5px;
    vertical-align: middle;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Split Section Styling */
.modern-ui .section-title {
    font-size: 13px;
    font-weight: bold;
    color: #0056b3;
    margin-bottom: 10px;
    border-bottom: 1px solid #c5d3e0;
    padding-bottom: 3px;
}

/* Custom UI Buttons matching 24px height */
.modern-ui .myButton {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 12px;
    font-family: Arial, sans-serif;
    font-size: 11px;
    font-weight: bold;
    border-radius: 3px;
    cursor: pointer;
    text-shadow: none;
    transition: all 0.2s;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    border: none;
    background-color: #e4685d;
    color: #ffffff;
    white-space: nowrap;
}
.modern-ui .myButton:hover { background-color: #eb675e; }

/* Data Grid Container */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    overflow: hidden;
    background: #fff;
    margin-bottom: 10px;
    margin-top: 5px;
}

.modern-ui label.error {
    color: red;
    font-weight: bold;
    font-size: 11px;
}

.modern-ui-scroll { 
    overflow-y: auto; 
    height: calc(100vh - 100px);
    padding-right: 5px;
}
.modern-ui-scroll::-webkit-scrollbar { width: 0px; }
</style>

<script type="text/javascript">
	$(document).ready(function() {
		 $("#btnvaluechange").hide();
		 
		 /* COMPACT DATE/TIME SIZING (120px) */
		 $("#jqxIBCashReceiptDate").jqxDateTimeInput({ width: '120px', height: '24px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '120px', height: '24px', formatString:"dd.MM.yyyy"});
		 
         /* Force internal alignment AFTER render */
         setTimeout(function () {
             $(".jqx-datetimeinput").find("input").css({
                 "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
                 "font-family": "Arial, sans-serif", "padding": "0 6px", "box-sizing":"border-box"
             });
             $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
         }, 0);
		 
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
				if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
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
	  
    /* SAFE READONLY FUNCTION */
	function funReadOnly(){
	    try {
			$('#frmIbCashReceipt input[type="text"]').attr('readonly', true );
			$('#frmIbCashReceipt select').attr('disabled', true);
			$('#jqxIBCashReceiptDate').jqxDateTimeInput({disabled: true});
			if($("#jqxApplyIbCashInvoicing").length) $("#jqxApplyIbCashInvoicing").jqxGrid({ disabled: true});
			if($("#jqxIbCashReceipt").length) $("#jqxIbCashReceipt").jqxGrid({ disabled: true});
			$("#btnvaluechange").hide();
	    } catch(e) { console.error(e); }
	}
	 
	/* SAFE REMOVE READONLY FUNCTION */
	function funRemoveReadOnly(){
	    try {
			getBranch();
			$('#frmIbCashReceipt input[type="text"]').attr('readonly', false );
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
			if($("#jqxApplyIbCashInvoicing").length) $("#jqxApplyIbCashInvoicing").jqxGrid({ disabled: false}); 
			if($("#jqxIbCashReceipt").length) $("#jqxIbCashReceipt").jqxGrid({ disabled: false});
			
			var date = $('#jqxIBCashReceiptDate').val();
		    getCurrencyId(date);
		    
			if ($("#mode").val() == "E") {
         	    $("#btnvaluechange").show();
         	    $('#frmIbCashReceipt input').attr('readonly', true );
   			    $('#frmIbCashReceipt select').attr('disabled', true);
   			    if($("#jqxApplyIbCashInvoicing").length) $("#jqxApplyIbCashInvoicing").jqxGrid({ disabled: true});
			    if($("#jqxIbCashReceipt").length) $("#jqxIbCashReceipt").jqxGrid({ disabled: true});
   			    $('#txtrefno').attr('readonly', false );
   			 	$('#txtdescription').attr('readonly', false );
   			 	
   			 	if($("#jqxIbCashReceipt").length) {
   			 	    $("#jqxIbCashReceipt").jqxGrid('addrow', null, {"docno": "","branch": "","brhid": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","costtype": "","costgroup": "","costcode": "","dr": true,"amount1": "","baseamount1": "","description": "","grtype": "","currencytype": "","sr_no":""});
   			 	}
			 }
			 else{
				$("#btnvaluechange").hide();
			} 
			
			if ($("#mode").val() == "A") {
				$('#jqxIBCashReceiptDate').val(new Date());
				if($("#jqxIbCashReceipt").length) {
    				$("#jqxIbCashReceipt").jqxGrid('clear'); 
    				$("#jqxIbCashReceipt").jqxGrid('addrow', null, {"docno": "","branch": "","brhid": "","type": "","accounts": "","accountname1": "","currency": "","currencyid": "","rate": "","costtype": "","costgroup": "","costcode": "","dr": true,"amount1": "","baseamount1": "","description": "","grtype": "","currencytype": "","sr_no":""});
				}
				if($("#jqxApplyIbCashInvoicing").length) {
    				$("#jqxApplyIbCashInvoicing").jqxGrid('clear');
    				$("#jqxApplyIbCashInvoicing").jqxGrid('addrow', null, {});
				}
			}
	    } catch(e) { console.error(e); }
	}
	 
	 function funSearchLoad(){
		changeContent('icrvMainSearch.jsp'); 
	 }
		
	 function funChkButton() { }
	 
	 function funFocus(){
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
		  if($("#jqxApplyIbCashInvoicing").length) {
    		  var rows = $("#jqxApplyIbCashInvoicing").jqxGrid('getrows');
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
		  if($("#jqxIbCashReceipt").length) {
    		  var rows = $('#jqxIbCashReceipt').jqxGrid('getrows');
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
	 		    var ibreceiptdate = $('#jqxIBCashReceiptDate').jqxDateTimeInput('getDate');
				var validdate=funDateInPeriod(ibreceiptdate);
				if(parseInt(validdate)==0){
					if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
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
		 		
		 		if(drtot=="" || crtot=="" || drtot=="NaN" || crtot=="NaN" || drtot==0 || crtot==0 ){
		 			 if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should not be Zero.";
		              return 0;
			 	}
		 		var balanceamt = $("#txtapplyinvoicebalance").val();  
		        if(parseInt(balanceamt)<0){
		        	 if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText= "Invalid applying amount!!!";
					 return 0;
		        }
		    	if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="";
		    		
		    	if($("#jqxIbCashReceipt").length) {
        			  var rows = $("#jqxIbCashReceipt").jqxGrid('getrows');
        			  var length=0,val2=0;
        			  for(var i=0 ; i < rows.length ; i++){
        				    var chk=rows[i].docno;
        				    var tramt=rows[i].tramt;
        				    var applying = $("#jqxApplyIbCashInvoicing").length ? $("#jqxApplyIbCashInvoicing").jqxGrid('getcelltext',i,'applying') : 0;
        				    
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
        	 				 if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText= "Invalid applying amount!!!";
        					 return 0; 
        	 		  }
        			  $('#gridlength').val(length);
		    	}
		 		
		 		if($("#jqxApplyIbCashInvoicing").length) {
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
    				 
    			 	 var rowsUpdate = $("#jqxApplyIbCashInvoicing").jqxGrid('getrows');
    			 	 var lengthupdate=0;
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
		 		
		    	return 1;
	 		}else{
	 			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Inter Brach is not created";
				return 0;
	 		}
		} 
	  
	  /* SAFE SET VALUES FUNCTION */
	  function setValues(){
	      try {
    		  getBranch();
    		  
    		  $('#jqxIBCashReceiptDate').jqxDateTimeInput({disabled: false});
    		  var date = $('#jqxIBCashReceiptDate').val();
    		  getCurrencyId(date);
    		  $('#jqxIBCashReceiptDate').jqxDateTimeInput({disabled: true});
    		  
    		  if(document.getElementById("cmbtotype") && document.getElementById("hidcmbtotype")) {
    		      document.getElementById("cmbtotype").value = document.getElementById("hidcmbtotype").value;
    		  }
    		  
    		  if($('#hidjqxIBCashReceiptDate').length && $('#hidjqxIBCashReceiptDate').val()){
    				 $("#jqxIBCashReceiptDate").jqxDateTimeInput('val', $('#hidjqxIBCashReceiptDate').val());
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
              
    		  if(typeof funSetlabel === "function") funSetlabel();
    			
    		  var indexVal = document.getElementById("docno") ? document.getElementById("docno").value : 0;
    		  if(indexVal>0 && $("#jqxIBCashReceiptGrid").length){
    			 var check = 1;
    	 		 $("#jqxIBCashReceiptGrid").load("ibCashReceiptGrid.jsp?txtcashreceiptdocno2="+indexVal+"&check="+check);
    		  }
    		  
    	      var indexVal1 = document.getElementById("txttodocno") ? document.getElementById("txttodocno").value : 0;
    	      var indexVal2 = document.getElementById("txttotrno") ? document.getElementById("txttotrno").value : 0;
    	      if(indexVal1>0 && $("#jqxIbCashApplyInvoicing1").length){
    	     	 var check = 1;
    	     	 $("#jqxIbCashApplyInvoicing1").load("applyIbCashReceiptInvoicingGrid.jsp?txttoaccid1="+indexVal1+"&txttotrno1="+indexVal2+"&check="+check); 
    	      }
    	      
    	      if(typeof funRoundRate === "function") {
                  funRoundRate($('#txtfromrate').val(),"txtfromrate");
        	      funRoundRate($('#txttorate').val(),"txttorate");
    	      }
    	      
    	      if(typeof funRoundAmt === "function") {
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
	      } catch(e) { console.error("Error in setValues:", e); }
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
                if(typeof funRoundAmt === "function") funRoundAmt(dr1,"txtdrtotal");
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
                    if(typeof funRoundAmt === "function") funRoundAmt(cr1,"txtcrtotal");
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
      }
	  
	  function getAccType(event){
          var x= event.keyCode;
          if(x==114){
        	  var date = $('#jqxIBCashReceiptDate').jqxDateTimeInput('getDate');
        	  $("#maindate").jqxDateTimeInput('val', date);
        	  accountToSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtotype').val()+"&date="+date);
          }
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
		  
		  if($("#jqxApplyIbCashInvoicing").length) {
    		  $("#jqxApplyIbCashInvoicing").jqxGrid('clear');
    		  $("#jqxApplyIbCashInvoicing").jqxGrid('addrow', null, {});
    		  var atype=$('#cmbtotype').val();
         	  if(atype != "AR"){
         		$("#jqxApplyIbCashInvoicing").jqxGrid({ disabled: true});
         	  }else if(atype == "AR"){
         		$("#jqxApplyIbCashInvoicing").jqxGrid({ disabled: false});
         	  }
		  }
		  
		  if (document.getElementById("txttoaccid") && document.getElementById("txttoaccid").value == "") {
		        $('#txttoaccid').attr('placeholder', 'Press F3 to Search'); 
		  }
	  }
	  
	  function datechange(){
		  var date = $('#jqxIBCashReceiptDate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(date);
		  if(parseInt(validdate)==0){
			if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
			return 0;	
		  }
		  $("#maindate").jqxDateTimeInput('val', date);
		  
		   if($('#cmbtobranch').val()!='' && $('#cmbtobranch').val()!=null){
			 	var validibdate=funIBDateInPeriod($('#jqxIBCashReceiptDate').val(),$('#cmbtobranch').val());
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
	  }
	  
</script>
</head>

<body onload="setValues();getBranch();">

<form id="frmIbCashReceipt" action="saveIbCashReceipt" method="post" autocomplete="off">
    <jsp:include page="../../../../header.jsp"></jsp:include>

    <div class="modern-ui modern-ui-scroll">
    
        <div class="erp-form-area">
            <table width="100%" border="0" cellspacing="0" cellpadding="2">
                <tr>
                    <td class="lbl-right" width="8%">Date</td>
                    <td width="15%">
                        <div id="jqxIBCashReceiptDate" name="jqxIBCashReceiptDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxIBCashReceiptDate"/>'></div>
                        <input type="hidden" id="hidjqxIBCashReceiptDate" name="hidjqxIBCashReceiptDate" value='<s:property value="hidjqxIBCashReceiptDate"/>'/>
                    </td>
                    <td class="lbl-right" width="10%">Ref. No.</td>
                    <td width="25%">
                        <input type="text" id="txtrefno" name="txtrefno" value='<s:property value="txtrefno"/>'/>
                    </td>
                    <td class="lbl-right" width="10%">Doc No.</td>
                    <td width="32%" style="display: flex; gap: 10px; align-items: center;">
                        <input type="text" id="docno" name="txtibcashreceiptdocno" style="width: 120px;" value='<s:property value="txtibcashreceiptdocno"/>' tabindex="-1"/>
                        <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button>
                    </td>
                </tr>
            </table>
        </div>

        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="50%" valign="top" style="padding-right: 10px;">
                    <div class="erp-form-area" style="height: 100%;">
                        <div class="section-title">Cash</div>
                        <table width="100%" border="0" cellspacing="0" cellpadding="2">
                            <tr>
                                <td class="lbl-right" width="15%">Cash</td>
                                <td width="35%">
                                    <input type="text" id="txtfromaccid" name="txtfromaccid" placeholder="Press F3 to Search" value='<s:property value="txtfromaccid"/>' onkeydown="getAcc(event);"/>
                                </td>
                                <td colspan="2">
                                    <input type="text" id="txtfromaccname" name="txtfromaccname" value='<s:property value="txtfromaccname"/>' tabindex="-1"/>
                                    <input type="hidden" id="txtfromdocno" name="txtfromdocno" value='<s:property value="txtfromdocno"/>'/>
                                </td>
                            </tr>
                            <tr>
                                <td class="lbl-right">Currency</td>
                                <td>
                                    <select id="cmbfromcurrency" name="cmbfromcurrency" value='<s:property value="cmbfromcurrency"/>' onchange="getRate(this.value,$('#jqxIBCashReceiptDate').val());"></select>
                                    <input type="hidden" id="hidcmbfromcurrency" name="hidcmbfromcurrency" value='<s:property value="hidcmbfromcurrency"/>'/>
                                    <input type="hidden" id="hidfromcurrencytype" name="hidfromcurrencytype" value='<s:property value="hidfromcurrencytype"/>'/>
                                </td>
                                <td class="lbl-right" width="15%">Rate</td>
                                <td width="35%">
                                    <input type="text" id="txtfromrate" name="txtfromrate" style="text-align: right;" value='<s:property value="txtfromrate"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getDrTotal();" tabindex="-1"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="lbl-right">Amount</td>
                                <td>
                                    <input type="text" id="txtfromamount" name="txtfromamount" style="text-align: right;" value='<s:property value="txtfromamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getDrTotal();" />
                                </td>
                                <td class="lbl-right">Base Amount</td>
                                <td>
                                    <input type="text" id="txtfrombaseamount" name="txtfrombaseamount" style="text-align: right;" value='<s:property value="txtfrombaseamount"/>' tabindex="-1"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="lbl-right" style="padding-top: 10px;">Description</td>
                                <td colspan="3" style="padding-top: 10px;">
                                    <input type="text" id="txtdescription" name="txtdescription" value='<s:property value="txtdescription"/>'/>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>

                <td width="50%" valign="top">
                    <div class="erp-form-area" style="height: 100%;">
                        <div class="section-title">Payment From</div>
                        <table width="100%" border="0" cellspacing="0" cellpadding="2">
                            <tr>
                                <td class="lbl-right" width="15%">Branch</td>
                                <td width="35%">
                                    <select id="cmbtobranch" name="cmbtobranch" onchange="funIBDateInPeriod($('#jqxIBCashReceiptDate').val(),this.value);" value='<s:property value="cmbtobranch"/>'></select>
                                    <input type="hidden" id="hidcmbtobranch" name="hidcmbtobranch" value='<s:property value="hidcmbtobranch"/>'/>
                                </td>
                                <td class="lbl-right" width="15%">Type</td>
                                <td width="35%">
                                    <select id="cmbtotype" name="cmbtotype" onchange="clearClientInfo();" value='<s:property value="cmbtotype"/>'>
                                        <option value="AR">AR</option>
                                        <option value="AP">AP</option>
                                    </select>
                                    <input type="hidden" id="hidcmbtotype" name="hidcmbtotype" value='<s:property value="hidcmbtotype"/>'/>
                                </td>
                            </tr>
                            <tr>
                                <td class="lbl-right">Account</td>
                                <td>
                                    <input type="text" id="txttoaccid" name="txttoaccid" value='<s:property value="txttoaccid"/>' placeholder="Press F3 to Search" onkeydown="getAccType(event);"/>
                                </td>
                                <td colspan="2">
                                    <input type="text" id="txttoaccname" name="txttoaccname" value='<s:property value="txttoaccname"/>' tabindex="-1"/>
                                    <input type="hidden" id="txttodocno" name="txttodocno" value='<s:property value="txttodocno"/>'/>
                                    <input type="hidden" id="txttotranid" name="txttotranid" value='<s:property value="txttotranid"/>'/>
                                    <input type="hidden" id="txttotrno" name="txttotrno" value='<s:property value="txttotrno"/>'/>
                                </td>
                            </tr>
                            <tr>
                                <td class="lbl-right">Currency</td>
                                <td>
                                    <select id="cmbtocurrency" name="cmbtocurrency" value='<s:property value="cmbtocurrency"/>' onchange="getRatevalue(this.value,$('#jqxIBCashReceiptDate').val());"></select>
                                    <input type="hidden" id="hidcmbtocurrency" name="hidcmbtocurrency" value='<s:property value="hidcmbtocurrency"/>'/>
                                    <input type="hidden" id="hidtocurrencytype" name="hidtocurrencytype" value='<s:property value="hidtocurrencytype"/>'/>
                                </td>
                                <td class="lbl-right">Rate</td>
                                <td>
                                    <input type="text" id="txttorate" name="txttorate" style="text-align: right;" value='<s:property value="txttorate"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountTo();getCrTotal();" tabindex="-1"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="lbl-right">Amount</td>
                                <td>
                                    <input type="text" id="txttoamount" name="txttoamount" style="text-align: right;" value='<s:property value="txttoamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountTo();getAmount();getCrTotal();" />
                                </td>
                                <td class="lbl-right">Base Amount</td>
                                <td>
                                    <input type="text" id="txttobaseamount" name="txttobaseamount" style="text-align: right;" value='<s:property value="txttobaseamount"/>' tabindex="-1"/>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>

        <div class="erp-form-area">
            <div class="section-title">Apply Invoices</div>
            <div class="grid-container" id="jqxIbCashApplyInvoicing1">
                <jsp:include page="applyIbCashReceiptInvoicingGrid.jsp"></jsp:include>
            </div>
            <table width="100%" border="0" cellspacing="0" cellpadding="2">
                <tr>
                    <td class="lbl-right" width="8%">Amount</td>
                    <td width="25%">
                        <input type="text" id="txtapplyinvoiceamt" name="txtapplyinvoiceamt" style="text-align: right;" value='<s:property value="txtapplyinvoiceamt"/>'/>
                        <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
                    </td>
                    <td class="lbl-right" width="8%">Applied</td>
                    <td width="25%">
                        <input type="text" id="txtapplyinvoiceapply" name="txtapplyinvoiceapply" style="text-align: right;" value='<s:property value="txtapplyinvoiceapply"/>' tabindex="-1"/>
                    </td>
                    <td class="lbl-right" width="8%">Balance</td>
                    <td width="26%">
                        <input type="text" id="txtapplyinvoicebalance" name="txtapplyinvoicebalance" style="text-align: right;" value='<s:property value="txtapplyinvoicebalance"/>' tabindex="-1"/>
                    </td>
                </tr>
            </table>
        </div>

        <div class="erp-form-area">
            <div class="grid-container" id="jqxIBCashReceiptGrid">
                <jsp:include page="ibCashReceiptGrid.jsp"></jsp:include>
            </div>
            <table width="100%" border="0" cellspacing="0" cellpadding="2">
                <tr>
                    <td width="50%"></td>
                    <td class="lbl-right" width="10%">Dr. Total</td>
                    <td width="15%">
                        <input type="text" id="txtdrtotal" name="txtdrtotal" style="text-align: right;" value='<s:property value="txtdrtotal"/>'/>
                    </td>
                    <td class="lbl-right" width="10%">Cr. Total</td>
                    <td width="15%">
                        <input type="text" id="txtcrtotal" name="txtcrtotal" style="text-align: right;" value='<s:property value="txtcrtotal"/>' tabindex="-1"/>
                    </td>
                </tr>
            </table>
        </div>

        <div style="display:none;">
            <input type="hidden" id="mode" name="mode"/>
            <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            <input type="hidden" name="txtforsearch" id="txtforsearch" value="0"/>
            <div id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
            <input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
            <input type="hidden" id="txtibvalidation" name="txtibvalidation" value='<s:property value="txtibvalidation"/>'/>
            <input type="hidden" id="gridlength" name="gridlength"/>
            <input type="hidden" id="applylength" name="applylength"/>
            <input type="hidden" id="applylengthupdate" name="applylengthupdate"/>
            
            <input type="hidden" id="formdetail" name="formdetail" value='<s:property value="formdetail"/>'/>
            <input type="hidden" id="formdetailcode" name="formdetailcode" value='<s:property value="formdetailcode"/>'/>
        </div>

    </div>
</form>
    
<div id="ibCashReceiptGridWindow"><div></div><div></div></div>  
<div id="accountDetailsFromWindow"><div></div><div></div></div>  
<div id="accountDetailsToWindow"><div></div><div></div></div>
<div id="branchSearchWindow"><div></div><div></div></div>
<div id="costTypeSearchGridWindow"><div></div><div></div></div> 
<div id="costCodeSearchWindow"><div></div><div></div></div> 

</body>
</html>