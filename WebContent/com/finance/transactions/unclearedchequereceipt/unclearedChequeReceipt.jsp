<%@ taglib prefix="s" uri="/struts-tags"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>

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
}

.modern-ui .erp-form-area {
    background-color: #f4f7fb;
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    padding: 15px 10px;
    margin-bottom: 10px;
    min-width: 1050px; 
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

/* Action Buttons */
.modern-ui .erp-btn-warning {
    height: 24px;
    padding: 0 15px;
    background: linear-gradient(135deg, #d97706 0%, #f59e0b 100%);
    color: #fff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 11px;
    font-weight: bold;
    box-shadow: 0 1px 2px rgba(245, 158, 11, 0.3);
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

.modern-ui .split-container {
    display: flex;
    gap: 15px;
}

.modern-ui .split-panel {
    flex: 1;
    background: #fff;
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    padding: 10px;
}

/* Data Grid Container */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    overflow: hidden;
    background: #fff;
    margin-bottom: 10px;
}

form label.error {
    color: red;
    font-weight: bold;
    font-size: 11px;
}

#validrate, #validrate1 { color: red; font-size: 11px; font-weight: bold; }

.hidden-scrollbar { 
    overflow: auto; 
    height: calc(100vh - 100px);
}
.hidden-scrollbar::-webkit-scrollbar { width: 0px; }
</style>

<script type="text/javascript">
	$(document).ready(function() {
		 $("#btnvaluechange").hide();
		
         /* FIXED DATE WIDTHS & HEIGHTS */ 
		 $("#jqxUnclearedChequeReceiptDate").jqxDateTimeInput({ width: '120px', height: '24px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '120px', height: '24px', formatString:"dd.MM.yyyy"});
		 $("#jqxChequeDate").jqxDateTimeInput({ width: '120px', height: '24px', formatString:"dd.MM.yyyy"});        
         
         /* Force internal alignment AFTER render */
        setTimeout(function () {
            $(".jqx-datetimeinput").find("input").css({
                "margin-top": "0px", 
                "line-height": "24px", 
                "font-size": "12px", 
                "font-family": "Arial, sans-serif",
                "padding": "0 6px", 
                "box-sizing":"border-box"
            });
            $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
        }, 0);
		
		 $('#accountDetailsToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsToWindow').jqxWindow('close');  
		 
		 $('#accountDetailsFromWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsFromWindow').jqxWindow('close');
		 
		 $('#unclearedChequeReceiptGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#unclearedChequeReceiptGridWindow').jqxWindow('close');
		 
		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#costTypeSearchGridWindow').jqxWindow('close');
 		 
 		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
		 
		 $('#printWindow').jqxWindow({width: '51%', height: '31%',  maxHeight: '50%' ,maxWidth: '51%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#printWindow').jqxWindow('close');
		 
		 $('#jqxUnclearedChequeReceiptDate').on('change', function (event) {
				 var bankpaydate = $('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput('getDate');
				 var validdate=funDateInPeriod(bankpaydate);
				 if(parseInt(validdate)==0){
					document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
					return 0;	
				 }
			 });
		 
		 $('#txtfromaccid').dblclick(function(){
			  var date = $('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountFromSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
			  });
		 
		  $('#txttoaccid').dblclick(function(){
			  var date = $('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountToSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtotype').val()+"&date="+date);
			  });  
	});
	
	function unclearedChequeSearchContent(url) {
		$('#unclearedChequeReceiptGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#unclearedChequeReceiptGridWindow').jqxWindow('setContent', data);
		$('#unclearedChequeReceiptGridWindow').jqxWindow('bringToFront');
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
	
	/* SAFE READONLY FUNCTION */
	function funReadOnly(){
	    try {
			$('#frmUnclearedChequeReceipt input').attr('readonly', true );
			$('#frmUnclearedChequeReceipt select').attr('disabled', true);
			$('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput({disabled: true});
			$('#jqxChequeDate').jqxDateTimeInput({disabled: true});
			if($("#jqxUnclearedChequeReceipt").length) $("#jqxUnclearedChequeReceipt").jqxGrid({ disabled: true});
			$("#btnvaluechange").hide();
	    } catch(e) { console.error("Error in funReadOnly: ", e); }
	}
	 
	/* SAFE REMOVE READONLY FUNCTION */
	function funRemoveReadOnly(){
	    try {
			$('#frmUnclearedChequeReceipt input').attr('readonly', false );
			$('#frmUnclearedChequeReceipt select').attr('disabled', false);
			$('#cmbfromcurrency').attr('disabled', true);
			$('#cmbtocurrency').attr('disabled', true);
			
			$('#txtfromaccid').attr('readonly', true );
			$('#txtfromaccname').attr('readonly', true );
			$('#txttoaccid').attr('readonly', true );
			$('#txttoaccname').attr('readonly', true );
			$('#txtdrtotal').attr('readonly', true );
			$('#txtcrtotal').attr('readonly', true );
			$('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput({disabled: false});
			$('#jqxChequeDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			
			if($("#jqxUnclearedChequeReceipt").length) $("#jqxUnclearedChequeReceipt").jqxGrid({ disabled: false});
		
			var date = $('#jqxUnclearedChequeReceiptDate').val();
		    getCurrencyId(date);
			
			if ($("#mode").val() == "E") {
             $("#btnvaluechange").show();
             $('#frmUnclearedChequeReceipt input').attr('readonly', true );
   			 $('#frmUnclearedChequeReceipt select').attr('disabled', true);
   			 $('#jqxChequeDate').jqxDateTimeInput({disabled: true});
			 if($("#jqxUnclearedChequeReceipt").length) $("#jqxUnclearedChequeReceipt").jqxGrid({ disabled: true});
   			 $('#txtrefno').attr('readonly', false );
   			 if($("#jqxUnclearedChequeReceipt").length) $("#jqxUnclearedChequeReceipt").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","dr": true,"amount1": "","description": ""});
			} else{
				$("#btnvaluechange").hide();
			} 
			
			if ($("#mode").val() == "A") {
				$('#jqxUnclearedChequeReceiptDate').val(new Date());
				if($("#jqxUnclearedChequeReceipt").length) {
				    $("#jqxUnclearedChequeReceipt").jqxGrid('clear'); 
				    $("#jqxUnclearedChequeReceipt").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","dr": true,"amount1": "","description": ""});
				}
			}
	    } catch(e) { console.error("Error in funRemoveReadOnly: ", e); }
	}
	 
	 function funSearchLoad(){
		changeContent('ucrMainSearch.jsp'); 
	 }
		
	 function funChkButton() { }
	 
	 function funFocus() {
	    $('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput('focus'); 	    		
	 }
	 
	  /* Validations */
	   $(function(){
	        $('#frmUnclearedChequeReceipt').validate({
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
		    var bankpaydate = $('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput('getDate');
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
			 type=document.getElementById("cmbtotype").value;
			 if(type==""){
				 document.getElementById("errormsg").innerText="Enter Type";
				 return 0;
			 }
			 acc=document.getElementById("txttoaccid").value;
			 if(acc==""){
				 document.getElementById("errormsg").innerText="Enter Account";
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
	 		if(isNaN(crtot) ||  isNaN(drtot)  || typeof(drtot)=="NaN"|| crtot=="NaN" || typeof(crtot)=="NaN" || drtot=="" || crtot=="" || drtot=="NaN" || crtot=="NaN" || drtot=="0" || crtot=="0" || drtot=="0.0" || crtot=="0.0" || drtot=="0.00" || crtot=="0.00"){
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
	    
	    	/* Uncleared Cheque Receipt Grid  Saving*/
	 		  var rows = $("#jqxUnclearedChequeReceipt").jqxGrid('getrows');
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
	 						 baseamount=rows[i].rate*rows[i].amount1*-1;
	 					}
	 					else if(rows[i].dr==false){
	 						 amount=rows[i].amount1;
	 						 baseamount=rows[i].rate*rows[i].amount1;
	 					}
	 					
	 				newTextBox.val(rows[i].docno+":: "+rows[i].currencyid+":: "+rows[i].rate+":: "+rows[i].dr+":: "+rows[i].amount1+":: "+rows[i].description+":: "+baseamount+":: "+rows[i].costtype+":: "+rows[i].costcode);
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
	 	 		   /* Uncleared Cheque Receipt Grid  Saving Ends*/	
	 				
	 				 $('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput({disabled: false});
			         $('#jqxChequeDate').jqxDateTimeInput({disabled: false});
			         
			         if ($("#mode").val() == "E") {
			        	 $('#frmUnclearedChequeReceipt select').attr('disabled', false); 
			         }
			         $('#cmbfromcurrency').attr('disabled', false);
			 		  $('#cmbtocurrency').attr('disabled', false);
			 		
	    		return 1;
		} 
	  
	  /* SAFE SET VALUES FUNCTION */
	  function setValues(){
	      try {
    		  $('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput({disabled: false});
    		  var date = $('#jqxUnclearedChequeReceiptDate').val();
    		  
    		  if(typeof getCurrencyId === 'function') getCurrencyId(date);
    		  
    		  $('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput({disabled: true});
    		  
    		  if(document.getElementById("cmbtotype") && document.getElementById("hidcmbtotype")) {
    		      document.getElementById("cmbtotype").value=document.getElementById("hidcmbtotype").value;
    		  }
    		  
    		  if($('#hidjqxUnclearedChequeReceiptDate').length && $('#hidjqxUnclearedChequeReceiptDate').val()){
    				 $("#jqxUnclearedChequeReceiptDate").jqxDateTimeInput('val', $('#hidjqxUnclearedChequeReceiptDate').val());
    		  }
    		  if($('#hidmaindate').length && $('#hidmaindate').val()){
    				 $("#maindate").jqxDateTimeInput('val', $('#hidmaindate').val());
    		  }
    		  if($('#hidjqxChequeDate').length && $('#hidjqxChequeDate').val()){
    				 $("#jqxChequeDate").jqxDateTimeInput('val', $('#hidjqxChequeDate').val());
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
    		  if(indexVal>0 && $("#jqxUnclearedChequeReceiptGrid").length){
    			  $("#jqxUnclearedChequeReceiptGrid").load("unclearedChequeReceiptGrid.jsp?txtunclearedchequereceiptdocno2="+indexVal+"&check=1");
    		  }
    		  
    		  if(typeof funRoundRate === 'function') {
        		  funRoundRate($('#txtfromrate').val(),"txtfromrate");
        		  funRoundRate($('#txttorate').val(),"txttorate");
    		  }
    		  if(typeof funRoundAmt === 'function') {
        	      funRoundAmt($('#txtfromamount').val(),"txtfromamount");
        		  funRoundAmt($('#txttoamount').val(),"txttoamount");
        	      funRoundAmt($('#txtfrombaseamount').val(),"txtfrombaseamount");
        	      funRoundAmt($('#txttobaseamount').val(),"txttobaseamount");
        		  funRoundAmt($('#txtdrtotal').val(),"txtdrtotal");
        		  funRoundAmt($('#txtcrtotal').val(),"txtcrtotal");
    		  }
	      } catch(e) { console.error("Error in setValues: ", e); }
	  }
	  
	  function funvalid(){
		  var rate=document.getElementById("txtfromrate").value;
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
		  var rate1=document.getElementById("txttorate").value;
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
					 $('#frmUnclearedChequeReceipt select').attr('disabled', false);
					 if($("#jqxUnclearedChequeReceipt").length) $("#jqxUnclearedChequeReceipt").jqxGrid({ disabled: false});  
					 $('#cmbfromcurrency').attr('disabled',true);
					 $('#cmbtocurrency').attr('disabled',true);
				  }
			   });
	  }
	  
	  function getDrTotal(){
		  var fromamount = $('#txtfrombaseamount').val();
		  if(!isNaN(fromamount)){
			  
			    var dr=0.0,cr=0.0,dr1=0.0;
        	    var rows = $('#jqxUnclearedChequeReceipt').jqxGrid('getrows');
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
                    dr1=parseFloat(dr) + parseFloat(fromamount);
                    funRoundAmt(dr1,"txtdrtotal");
               	 }
		  }
		  else if(isNaN(fromamount)){
		  	$('#txtdrtotal').val(0.00);
		  	$('#txtfromamount').val(0.00);
		  }
	  }
	  
	  function getCrTotal(){
		  var toamount = $('#txttobaseamount').val();
		  
		  if(!isNaN(toamount)){
			  
		  var dr=0.0,cr=0.0,cr1=0.0;
  	      var rows = $('#jqxUnclearedChequeReceipt').jqxGrid('getrows');
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
	  	  
	  function getAcc(event){
          var x= event.keyCode;
          if(x==114){
        	  var date = $('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput('getDate');
        	  $("#maindate").jqxDateTimeInput('val', date);
        	  accountFromSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
          }
          else{}
          }
	  
	  function getAccType(event){
          var x= event.keyCode;
          if(x==114){
        	  var date = $('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput('getDate');
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
	  }
	  
	  function datechange(){
		  var date = $('#jqxUnclearedChequeReceiptDate').jqxDateTimeInput('getDate');
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

<div id="mainBG" class="homeContent hidden-scrollbar" data-type="background">
<form id="frmUnclearedChequeReceipt" action="saveUnclearedChequeReceipt" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class="modern-ui">

    <div class="erp-form-area">
        
        <table width="100%" border="0" cellspacing="0" cellpadding="2" style="margin-bottom: 8px;">
            <tr>
                <td class="lbl-right" width="6%">Date</td>
                <td width="12%">
                    <div id="jqxUnclearedChequeReceiptDate" name="jqxUnclearedChequeReceiptDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxUnclearedChequeReceiptDate"/>'></div>
                    <input type="hidden" id="hidjqxUnclearedChequeReceiptDate" name="hidjqxUnclearedChequeReceiptDate" value='<s:property value="hidjqxUnclearedChequeReceiptDate"/>'/>
                </td>
                <td class="lbl-right" width="8%">Ref. No.</td>
                <td width="15%">
                    <input type="text" id="txtrefno" name="txtrefno" value='<s:property value="txtrefno"/>'/>
                </td>
                <td class="lbl-right" width="8%">Doc No</td>
                <td width="15%">
                    <div style="display: flex; gap: 8px; align-items: center;">
                        <input type="text" id="docno" name="txtunclearedchequereceiptdocno" value='<s:property value="txtunclearedchequereceiptdocno"/>' tabindex="-1" readonly="readonly"/>
                        <button class="erp-btn-warning" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button>
                    </div>
                </td>
                <td align="right" width="36%"></td>
            </tr>
        </table>

        <div class="split-container">
            
            <div class="split-panel">
                <div class="section-title">Bank</div>
                <table width="100%" border="0" cellspacing="0" cellpadding="2">
                    <tr>
                        <td class="lbl-right" width="20%">Bank</td>
                        <td width="30%">
                            <input type="text" id="txtfromaccid" name="txtfromaccid" placeholder="Press F3" value='<s:property value="txtfromaccid"/>'  onkeydown="getAcc(event);"/>
                        </td>
                        <td width="50%" colspan="2">
                            <input type="text" id="txtfromaccname" name="txtfromaccname" value='<s:property value="txtfromaccname"/>' tabindex="-1"/>
                            <input type="hidden" id="txtfromdocno" name="txtfromdocno" value='<s:property value="txtfromdocno"/>'/>
                        </td>
                    </tr>
                    <tr>
                        <td class="lbl-right">Currency</td>
                        <td>
                            <select id="cmbfromcurrency" name="cmbfromcurrency" value='<s:property value="cmbfromcurrency"/>' onchange="getRate(this.value,$('#jqxUnclearedChequeReceiptDate').val());">
                                <option></option>
                            </select>
                            <input type="hidden" id="hidcmbfromcurrency" name="hidcmbfromcurrency" value='<s:property value="hidcmbfromcurrency"/>'/>
                            <input type="hidden" id="hidfromcurrencytype" name="hidfromcurrencytype" value='<s:property value="hidfromcurrencytype"/>'/>
                        </td>
                        <td class="lbl-right" width="15%">Rate</td>
                        <td width="35%">
                            <input type="text" id="txtfromrate" name="txtfromrate" onchange="funvalid()" value='<s:property value="txtfromrate"/>' onblur="funRoundRate(this.value,this.id);getBaseAmountFrom();getDrTotal();" tabindex="-1"/>
                            <div id="validrate"></div>
                        </td>
                    </tr>
                    <tr>
                        <td class="lbl-right">Cheque No</td>
                        <td>
                            <input type="text" id="txtchequeno" name="txtchequeno" value='<s:property value="txtchequeno"/>' />
                        </td>
                        <td class="lbl-right">Date</td>
                        <td>
                            <div id="jqxChequeDate" name="jqxChequeDate" value='<s:property value="jqxChequeDate"/>'></div>
                            <input type="hidden" id="hidjqxChequeDate" name="hidjqxChequeDate" value='<s:property value="hidjqxChequeDate"/>'/>
                        </td>
                    </tr>
                    <tr>
                        <td class="lbl-right">Cheque Name</td>
                        <td colspan="3">
                            <input type="text" id="txtchequename" name="txtchequename" value='<s:property value="txtchequename"/>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="lbl-right">Amount</td>
                        <td>
                            <input type="text" id="txtfromamount" name="txtfromamount" value='<s:property value="txtfromamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getDrTotal();" />
                        </td>
                        <td class="lbl-right">Base Amt</td>
                        <td>
                            <input type="text" id="txtfrombaseamount" name="txtfrombaseamount" value='<s:property value="txtfrombaseamount"/>' tabindex="-1" readonly="readonly"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="lbl-right">Description</td>
                        <td colspan="3">
                            <input type="text" id="txtdescription" name="txtdescription" value='<s:property value="txtdescription"/>'/>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="split-panel">
                <div class="section-title">Received From</div>
                <table width="100%" border="0" cellspacing="0" cellpadding="2">
                    <tr>
                        <td class="lbl-right" width="20%">Type</td>
                        <td width="80%" colspan="3">
                            <select id="cmbtotype" name="cmbtotype" onchange="clearClientInfo();" value='<s:property value="cmbtotype"/>' style="width: 100px;">
                                <option value="AP">AP</option><option value="AR">AR</option>
                            </select>
                            <input type="hidden" id="hidcmbtotype" name="hidcmbtotype" value='<s:property value="hidcmbtotype"/>'/>
                        </td>
                    </tr>
                    <tr>
                        <td class="lbl-right">Account</td>
                        <td width="30%">
                            <input type="text" id="txttoaccid" name="txttoaccid" placeholder="Press F3" value='<s:property value="txttoaccid"/>' onkeydown="getAccType(event);"/>
                        </td>
                        <td width="50%" colspan="2">
                            <input type="text" id="txttoaccname" name="txttoaccname" value='<s:property value="txttoaccname"/>' tabindex="-1"/>
                            <input type="hidden" id="txttodocno" name="txttodocno" value='<s:property value="txttodocno"/>'/>
                        </td>
                    </tr>
                    <tr>
                        <td class="lbl-right">Currency</td>
                        <td>
                            <select id="cmbtocurrency" name="cmbtocurrency" value='<s:property value="cmbtocurrency"/>' onchange="getRatevalue(this.value,$('#jqxUnclearedChequeReceiptDate').val());">
                                <option></option>
                            </select>
                            <input type="hidden" id="hidcmbtocurrency" name="hidcmbtocurrency" value='<s:property value="hidcmbtocurrency"/>'/>
                            <input type="hidden" id="hidtocurrencytype" name="hidtocurrencytype" value='<s:property value="hidtocurrencytype"/>'/>
                        </td>
                        <td class="lbl-right" width="15%">Rate</td>
                        <td width="35%">
                            <input type="text" id="txttorate" name="txttorate" onchange="funvalid1()" value='<s:property value="txttorate"/>' onblur="funRoundRate(this.value,this.id);getBaseAmountTo();getCrTotal();" tabindex="-1"/>
                            <div id="validrate1"></div>
                        </td>
                    </tr>
                    <tr>
                        <td class="lbl-right">Amount</td>
                        <td>
                            <input type="text" id="txttoamount" name="txttoamount" value='<s:property value="txttoamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountTo();getCrTotal();" />
                        </td>
                        <td class="lbl-right">Base Amt</td>
                        <td>
                            <input type="text" id="txttobaseamount" name="txttobaseamount" value='<s:property value="txttobaseamount"/>' tabindex="-1" readonly="readonly"/>
                        </td>
                    </tr>
                </table>
            </div>

        </div>
    </div>

    <div class="grid-container">
        <div id="jqxUnclearedChequeReceiptGrid"><jsp:include page="unclearedChequeReceiptGrid.jsp"></jsp:include></div>
    </div>

    <div class="erp-form-area">
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
            <tr>
                <td class="lbl-right" width="10%">Dr. Total</td>
                <td width="15%">
                    <input type="text" id="txtdrtotal" name="txtdrtotal" style="text-align: right;" value='<s:property value="txtdrtotal"/>' tabindex="-1" readonly="readonly"/>
                </td>
                <td class="lbl-right" width="10%">Cr. Total</td>
                <td width="15%">
                    <input type="text" id="txtcrtotal" name="txtcrtotal" style="text-align: right;" value='<s:property value="txtcrtotal"/>' tabindex="-1" readonly="readonly"/>
                </td>
                <td width="50%" align="right">
                    <i><b><label id="lblformposted" name="lblformposted" style="font-size: 13px; font-family: Tahoma; color:#6000FC;"></label></b></i>
                    <span id="formdet" style="display:none;"></span>
                </td>
            </tr>
        </table>
    </div>

    <div style="display:none;">
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
        <input type="hidden" name="txtforsearch" id="txtforsearch" value="0"/>
        <div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
        <input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
        <input type="hidden" id="gridlength" name="gridlength"/>
        
        <input type="hidden" id="formdetail" name="formdetail" value='<s:property value="formdetail"/>'/>
        <input type="hidden" id="formdetailcode" name="formdetailcode" value='<s:property value="formdetailcode"/>'/>
    </div>

</div>
</form>

<div id="unclearedChequeReceiptGridWindow"><div></div><div></div></div>  
<div id="accountDetailsFromWindow"><div></div><div></div></div>  
<div id="accountDetailsToWindow"><div></div><div></div></div> 
<div id="costTypeSearchGridWindow"><div></div><div></div></div> 
<div id="costCodeSearchWindow"><div></div><div></div></div> 
<div id="printWindow"><div></div><div></div></div> 

</div>
</body>
</html>