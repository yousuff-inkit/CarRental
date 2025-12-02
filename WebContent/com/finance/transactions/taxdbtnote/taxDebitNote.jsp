<%@page import="com.controlcentre.masters.tarifmgmt.ClsTarifAction"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link rel="stylesheet" type="text/css" href="../../../../css/body.css">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<<<<<<< HEAD
<style>
.hidden-scrollbar {
  overflow-y: auto;
  height: 600px;
  scrollbar-width: thin;
  scrollbar-color: #4da3ff #eaf3ff;
}
.hidden-scrollbar::-webkit-scrollbar {
  width: 7px;
}
.hidden-scrollbar::-webkit-scrollbar-thumb {
  background-color: #4da3ff;
  border-radius: 8px;
}
.hidden-scrollbar::-webkit-scrollbar-thumb:hover {
  background-color: #1a73e8;
}
body {
  background: linear-gradient(135deg, #e8f1ff 0%, #d1e4ff 100%);
  font-family: "Poppins", "Segoe UI", sans-serif;
  color: #1f2f46;
  margin: 0;
  padding: 40px 0;
  min-height: 100vh;
  animation: fadeIn 0.6s ease-in-out;
}
#mainBG {
  background: #f4f8ff;
  border-radius: 16px;
  box-shadow: 0 4px 25px rgba(50, 110, 255, 0.15);
  padding: 25px 30px;
  max-width: 1250px;
  margin: 0 auto;
  transition: 0.3s ease;
}
#mainBG:hover {
  box-shadow: 0 8px 35px rgba(30, 100, 255, 0.25);
}
.receipt-header {
  background: #edf4ff;
  border: 1px solid #c9dafc;
  border-radius: 14px;
  padding: 20px;
  margin-bottom: 26px;
  box-shadow: 0 2px 10px rgba(132, 168, 255, 0.2);
}
label {
  font-weight: 600;
  font-size: 15px;
  color: #1a2d4d;
  margin-bottom: 6px;
}
input[type="text"],
select,
.clean-input {
  width: 100%;
  height: 38px;
  padding: 6px 12px;
  border: 1px solid #b9ccf2;
  border-radius: 8px;
  background: #ffffff;
  font-size: 0.95rem;
  color: #1f2f46;
  box-sizing: border-box;
  transition: 0.25s ease;
}
input[type="text"]:focus,
select:focus {
  border-color: #4da3ff;
  box-shadow: 0 0 6px rgba(77, 163, 255, 0.55);
  outline: none;
}
select {
  appearance: none;
  background: #ffffff url("data:image/svg+xml;utf8,<svg fill='%233b82f6' height='20' width='20' viewBox='0 0 20 20'><polygon points='5,7 15,7 10,12' /></svg>") no-repeat right 10px center;
  background-size: 14px;
}
input[readonly],
select:disabled {
  background-color: #eef3ff;
  color: #6a7ba1;
}
#jqxTariffDate,
#jqxTariffFromDate,
#jqxTariffToDate {
  width: 100%;
  height: 38px;
}
#jqxTariffDate input,
#jqxTariffFromDate input,
#jqxTariffToDate input {
  height: 36px;
  padding-left: 10px;
  border-radius: 8px;
  background-color: #ffffff;
  box-shadow: none;
}
input:-webkit-autofill,
input:-webkit-autofill:hover,
input:-webkit-autofill:focus,
select:-webkit-autofill {
  -webkit-box-shadow: 0 0 0px 1000px #ffffff inset;
  background-color: #ffffff;
  color: #1f2f46;
}
input::selection,
#jqxTariffDate input::selection,
#jqxTariffFromDate input::selection,
#jqxTariffToDate input::selection {
  background: #cfe2ff;
  color: #000;
}
.cr-table {
  width: 100%;
  border-collapse: collapse;
  background: #ffffff;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 2px 12px rgba(100, 140, 255, 0.15);
}
.cr-table th,
.cr-table td {
  padding: 10px 12px;
  border-bottom: 1px solid #d6e1ff;
  text-align: left;
  font-size: 0.95rem;
}
.cr-table th {
  background-color: #dcebff;
  color: #1b3f73;
  font-weight: 600;
}
.cr-table tr:hover td {
  background-color: #eef5ff;
  transition: 0.25s;
}
button,
.myButton {
  background: linear-gradient(90deg, #3b82f6, #1a73e8);
  color: #fff;
  border: none;
  border-radius: 8px;
  padding: 9px 22px;
  font-weight: 600;
  cursor: pointer;
  transition: 0.25s ease;
  box-shadow: 0 3px 10px rgba(30, 100, 255, 0.25);
}
button:hover,
.myButton:hover {
  background: linear-gradient(90deg, #1a73e8, #155cc6);
  transform: translateY(-2px);
}
button:active {
  transform: scale(0.96);
}
#validrate,
#validrate1,
#errormsg {
  color: #d62828;
  font-weight: 600;
  font-size: 0.9rem;
}
@keyframes fadeIn {
  from { opacity: 0; transform: translateY(-5px); }
  to { opacity: 1; transform: translateY(0); }
}
#jqxDebitNote {
    border: 1px solid #9db4d9;
    border-radius: 12px;
    overflow: hidden;
}
.jqx-grid-column-header,
.jqx-widget-header {
    background: #d5e4ff;
    color: #0f2a4d;
    font-weight: 700;
    font-size: 14.5px;
    border-bottom: 1px solid #9db4d9;
    height: 38px;
    min-height: 38px;
    line-height: 38px;
    padding: 0;
}
.jqx-grid-column-header div,
.jqx-widget-header div {
    padding: 0 10px;
    margin: 0;
    line-height: 38px;
}
.jqx-grid-cell {
    background-color: #ffffff;
    border-color: #d3def5;
    font-size: 14px;
    color: #1c2f4a;
    height: 38px;
    min-height: 38px;
    padding: 0 10px;
    display: flex;
    align-items: center;
}
.jqx-grid-cell-alt {
    background-color: #f4f7ff;
}
.jqx-grid-cell-hover {
    background-color: #e4edff;
}
.jqx-grid-cell-selected {
    background-color: #c3d6ff;
    border-color: #6a92d7;
}
.jqx-grid-cell input[type="checkbox"] {
    transform: scale(1.2);
    margin-left: 6px;
}
.jqx-grid-statusbar {
    background: #e3ecff;
    border-top: 1px solid #9db4d9;
    color: #0f2a4d;
    font-size: 14px;
    font-weight: 700;
    height: 34px;
    padding: 6px 10px;
}
#jqxDebitNote::-webkit-scrollbar {
    width: 8px;
    height: 8px;
}
#jqxDebitNote::-webkit-scrollbar-thumb {
    background: #8aa8d6;
    border-radius: 6px;
}
#jqxDebitNote::-webkit-scrollbar-thumb:hover {
    background: #6f8ec4;
=======
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/globalcss.css">

<script type="text/javascript">
	$(document).ready(function() {
		/* JQX Date: make it full width and same height as inputs */
		$("#jqxDebitNoteDate").jqxDateTimeInput({
		    width: '100%',
		    height: 36,
		    formatString: "dd.MM.yyyy"
		});
		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $('#txtforsearch').val(2);
		
		 $('#accountDetailsToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsToWindow').jqxWindow('close');  
		 
		 $('#debitNoteGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#debitNoteGridWindow').jqxWindow('close'); 
		 
		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#costTypeSearchGridWindow').jqxWindow('close');
 		 
 		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
		 
		 $('#jqxDebitNoteDate').on('change', function (event) {
				 var debitdate = $('#jqxDebitNoteDate').jqxDateTimeInput('getDate');
				 var validdate=funDateInPeriod(debitdate);
				 if(parseInt(validdate)==0){
					document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
					return 0;	
				 }
		});
			 
		$('#txtaccid').dblclick(function(){
			  var date = $('#jqxDebitNoteDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtype').val()+"&date="+date);
         	  $('#txtforsearch').val(2);
		}); 	 
	});
	
	function DebitSearchContent(url) {
		$('#debitNoteGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#debitNoteGridWindow').jqxWindow('setContent', data);
		$('#debitNoteGridWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function accountSearchContent(url) {
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
				 $('#txtaccid').attr('readonly', true);$('#txtaccname').attr('readonly', true);$('#txtamount').attr('readonly', false);$('#txtdescription').attr('readonly', false);
				 $('#txtrate').attr('readonly', false);$('#txtbaseamount').attr('readonly', true);$('#txtdrtotal').attr('readonly', true);$('#txtcrtotal').attr('readonly', true);
				 $('#frmTaxCreditNote select').attr('disabled', false);$("#jqxDebitNote").jqxGrid({ disabled: false}); $('#frmTaxDebitNote select').attr('disabled', false);    
				 $('#cmbcurrency').attr('disabled',true);
				    }
		   });
	  }
	  
	 function funReadOnly(){
			$('#frmTaxDebitNote input').attr('readonly', true );
			$('#frmTaxDebitNote select').attr('disabled', true);
			$('#jqxDebitNoteDate').jqxDateTimeInput({disabled: true});
			$("#jqxDebitNote").jqxGrid({ disabled: true});
			$("#btnvaluechange").hide();
	 }
	 function funRemoveReadOnly(){
		    $('#txtforsearch').val(2);
			$('#frmTaxDebitNote input').attr('readonly', false );
			$('#frmTaxDebitNote select').attr('disabled', false);
			$('#cmbcurrency').attr('disabled', true);
			
			$('#txtaccid').attr('readonly', true );
			$('#txtaccname').attr('readonly', true );
			$('#txtnettotal').attr('readonly', true );
			$('#jqxDebitNoteDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$("#jqxDebitNote").jqxGrid({ disabled: false}); 
			
			var date = $('#jqxDebitNoteDate').val();
		    getCurrencyId(date);
		    
		   if ($("#mode").val() == "E") {
      	        $("#btnvaluechange").show();
      	        $('#frmTaxDebitNote input').attr('readonly', true );
			    $('#frmTaxDebitNote select').attr('disabled', true);    
			    $("#jqxDebitNote").jqxGrid({ disabled: true});
			    $('#txtrefno').attr('readonly', false );
			    $('#txtdescription').attr('readonly', false );
			    $("#jqxDebitNote").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","dr": true,"amount1": "","description": ""});
			  }
			 else{
				$("#btnvaluechange").hide();
			} 
			
			if ($("#mode").val() == "A") {
				$('#jqxDebitNote').val(new Date());
				$("#jqxDebitNote").jqxGrid('clear'); 
				$("#jqxDebitNote").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","dr": true,"amount1": "","description": ""});
			} 
	       }
	 
			function funSearchLoad(){
				changeContent('dnoMainSearch.jsp'); 
			 }
				
			 function funChkButton() {
					/* funReset(); */
				}
			 
			 function funFocus(){
			    	$('#jqxDebitNoteDate').jqxDateTimeInput('focus'); 	    		
			    }
			 
			   $(function(){
			        $('#frmTaxDebitNote').validate({
			                rules: {
			                txtaccid:"required",
			                txtamount:{"required":true,number:true},
			                txtdescription:{maxlength:500}
			                 },
			                 messages: {
			                 txtaccid:" *",
			                 txtamount:{required:" *",number:"Invalid"},
			                 txtdescription: {maxlength:"    Max 500 chars"}
			                 }
			        });});
			   
			  function funNotify(){	
				  /* Validation */
				    var debitdate = $('#jqxDebitNoteDate').jqxDateTimeInput('getDate');
				    var taxacc=document.getElementById("taxaccount").value;
					var validdate=funDateInPeriod(debitdate);
					if(parseInt(validdate)==0){
						document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
						return 0;	
					}
					
					acctype=document.getElementById("cmbtype").value;
					if(acctype==""){
						document.getElementById("errormsg").innerText="Account Type is Mandatory.";
						return 0;
					}
					 
					accid=document.getElementById("txtdocno").value;
					if(accid==""){
						document.getElementById("errormsg").innerText="Account is Mandatory.";
						return 0;
					}
					 
					currencyto=document.getElementById("cmbcurrency").value;
					currencyrate=document.getElementById("txtrate").value;
					if(currencyto=="" || currencyrate==""){
						document.getElementById("errormsg").innerText="Currency & Rate is Mandatory.";
						return 0;
					}
					 
					var drtot = parseFloat(document.getElementById("txtdrtotal").value);
			 		var crtot = parseFloat(document.getElementById("txtcrtotal").value);
			 		
			 		if(drtot>crtot || drtot<crtot){
			 			document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should be Equal.";
		              return 0;
			 		}
			 		
			 		if(drtot=="" || crtot=="" ){
			 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should be Equal.";
			              return 0;
				 		}

			 		if(isNaN(drtot) || isNaN(crtot)){
			 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should be Equal.";
			              return 0;
				 		}
			 		
			 		if(drtot==0 || crtot==0){
			 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should not be Zero.";
			              return 0;
				 		}
			 		
			 		if(drtot==0.0 || crtot==0.0){
			 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should not be Zero.";
			              return 0;
				 		}
			 		
			 		if(drtot==0.00 || crtot==0.00){
			 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should not be Zero.";
			              return 0;
				 		}
			 		rate=document.getElementById("txtrate").value;
					 if(rate=="" || rate=="0" || rate=="0.00"){
						 document.getElementById("errormsg").innerText= "Rate is Mandatory.";
						 return 0;
					 }
				  
			 		
			 		document.getElementById("errormsg").innerText="";
			    		
			    /* Validation Ends*/
			    		
			     /* Debit-Note Grid  Saving*/
				  var rows = $("#jqxDebitNote").jqxGrid('getrows');
				  var length=0,val=0;
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
							
							var amount,baseamount,nettotal,taxamnt;
							if(rows[i].dr==true){
								 amount=rows[i].amount1*-1;
								 baseamount=rows[i].baseamount1*-1;  
								
								 taxamnt=rows[i].taxamount*-1;
							}
							else if(rows[i].dr==false){
								 amount=rows[i].amount1;
								 baseamount=rows[i].baseamount1;
								
								 taxamnt=rows[i].taxamount;
							}
							
						newTextBox.val(rows[i].docno+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+rows[i].dr+"::"+amount+"::"+rows[i].description+"::"+baseamount+":: "+rows[i].costtype+":: "+rows[i].costcode+":: "+rows[i].tax+":: "+taxamnt+":: "+rows[i].nettotal+":: "+taxacc+":: "+taxamnt);
						newTextBox.appendTo('form');
						}
						}
					 if(val==1){
						 document.getElementById("errormsg").innerText= "Rate is Mandatory.";
						 return 0;
					 }  
					    $('#gridlength').val(length);
			 		   /* Debit-Note Grid  Saving Ends*/	
			 		   	
			 		$('#cmbcurrency').attr('disabled',false); 
				  return 1;
			  }
			  
			  function setValues(){
				  $('#jqxDebitNoteDate').jqxDateTimeInput({disabled: false});
				  var date = $('#jqxDebitNoteDate').val();
				  getCurrencyId(date);
				  $('#jqxDebitNoteDate').jqxDateTimeInput({disabled: true});
				  
				  document.getElementById("cmbtype").value=document.getElementById("hidcmbtype").value;
				  document.getElementById("cmbcurrency").value=document.getElementById("hidcmbcurrency").value;  
				  
				  if($('#hidjqxDebitNoteDate').val()){
						 $("#jqxDebitNoteDate").jqxDateTimeInput('val', $('#hidjqxDebitNoteDate').val());
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
						 var check = 1 ;
			             $("#jqxDebitNoteGrid").load("debitNoteGrid.jsp?txtdebitnotedocno2="+indexVal+"&check="+check);
					 }
					    funRoundRate($('#txtrate').val(),"txtrate");
				        funRoundAmt($('#txtamount').val(),"txtamount");
				        funRoundAmt($('#txtbaseamount').val(),"txtbaseamount");
						funRoundAmt($('#txtdrtotal').val(),"txtdrtotal");
						funRoundAmt($('#txtcrtotal').val(),"txtcrtotal");
				        		
				}
			  function funvalid(){
				  rate=document.getElementById("txtrate").value;
					 if(rate=="" || rate=="0" || rate=="0.00"){
						 document.getElementById("validrate").innerText= "Rate is Mandatory.";
						 document.getElementById("txtrate").focus();
						 return 0;
					 }
					 else{
						 document.getElementById("validrate").innerText= "";
						 
					 }
			  }
			       	   
			       function getDrTotal(){
			 		  var fromamount = $('#txtbaseamount').val();
			 		  
			 		  if(!isNaN(fromamount)){
			 			  
			 		  var dr=0.0,cr=0.0,dr1=0.0;
			   	      var rows = $('#jqxDebitNote').jqxGrid('getrows');
			 	      var rowlength= rows.length;
			 	  		for(var i=0;i<=rowlength-1;i++) {
			 	  		
			 	  		  var value = rows[i].dr;
			 	          var baseamount = rows[i].nettotal;
			 	          
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
			 			  $('#txtamount').val(0.00);
				 		  $('#txtcrtotal').val(0.00);
				 		  $('#txtdrtotal').val(0.00);			
			 		}
			 	  } 
			       	
			       function getAccType(event){
			           var x= event.keyCode;
			           if(x==114){
			        	   var date = $('#jqxDebitNoteDate').jqxDateTimeInput('getDate');
				 		   $("#maindate").jqxDateTimeInput('val', date);
			        	   accountSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtype').val()+"&date="+date);
				           $('#txtforsearch').val(2);
			           }
			           else{}
			           }
			       	
			       function funPrintBtn() {
						
						if (($("#mode").val() == "view") && $("#docno").val()!="") {
					        var url=document.URL;
					        var reurl=url.split("saveTaxDebitNote");
					        $("#docno").prop("disabled", false);  
					     
					        $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
								if (r){
									 var win= window.open(reurl[0]+"printTaxDebitNote?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
								     win.focus();
								 }
								else{
									var win= window.open(reurl[0]+"printTaxDebitNote?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
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
				 		  $("#txtdocno").val('');$("#txtaccid").val('');$("#txtaccname").val('');
				 	  }
			       
			       function datechange(){
				 		  var date = $('#jqxDebitNoteDate').jqxDateTimeInput('getDate');
						  var validdate=funDateInPeriod(date);
						  if(parseInt(validdate)==0){
							document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
							return 0;	
						  }
				 		  $("#maindate").jqxDateTimeInput('val', date);
				 	  }

</script>

<style>
/* ------------------------------
   INPUT FIELD BASE STYLE
------------------------------ */
.inp {
    width: 100%;
    height: 32px !important;
    padding: 4px 8px !important;
    font-size: 15px !important;
    border-radius: 10px !important;
    border: 1px solid #b9c9e8 !important;
    background: #fff !important;
    transition: 0.25s;
}

.inp:hover,
.inp:focus {
    border-color: #2f6dde !important;
    box-shadow: 0 0 8px rgba(47,109,222,0.4) !important;
    outline: none !important;
}

/* Labels */
.lbl {
    min-width: 110px;
    font-size: 18px;
    font-weight: 600;
    color: #1d2a4d;
}

/* Layout spacing */
.row-flex {
    display: flex;
    align-items: center;
    gap: 10px;
    flex: 1;
    min-width: 260px;
}
.row3 {
    display: flex;
    gap: 25px;
    flex-wrap: wrap;
    margin-bottom: 18px;
}

/* ------------------------------
   FIX: Chrome Autofill (remove pink)
------------------------------ */
input:-webkit-autofill,
input:-webkit-autofill:hover,
input:-webkit-autofill:focus {
    -webkit-box-shadow: 0 0 0 1000px #ffffff inset !important;
    -webkit-text-fill-color: #000 !important;
}

/* ------------------------------
   FIX: Dropdown font size
------------------------------ */
select.inp,
select.inp option {
    font-size: 18px !important;
    height: 32px !important;
    line-height: 32px !important;
}

select.inp {
    padding-right: 35px !important;
}

/* ------------------------------
   JQX DATE INPUT — FINAL PINK FIX
------------------------------ */

/* Force every JQX layer to stay white */
#jqxDebitNoteDate *,
.jqx-datetimeinput *,
.jqx-datetimeinput-input,
.jqx-datetimeinput-content input {
    background-color: #ffffff !important;
    box-shadow: none !important;
    -webkit-box-shadow: 0 0 0 1000px #ffffff inset !important;
    -webkit-text-fill-color: #000 !important;
}

/* Override inline background that JQX injects */
#jqxDebitNoteDate div[style*="background"],
.jqx-datetimeinput div[style*="background"] {
    background: #ffffff !important;
}

/* Match height of JQX container + internal input */
.jqx-datetimeinput,
.jqx-datetimeinput-input,
.jqx-datetimeinput-content input {
    height: 32px !important;
    min-height: 32px !important;
    line-height: 32px !important;
    font-size: 15px !important;
    padding-left: 8px !important;
}

/* Calendar button */
.jqx-datetimeinput-button {
    width: 32px !important;
    height: 32px !important;
    border-radius: 10px !important;
    background: transparent !important;
    display: flex !important;
    align-items: center !important;
    justify-content: center !important;
    border: none !important;
}

.jqx-datetimeinput-button img {
    width: 18px !important;
    height: 18px !important;
    display: block !important;
    object-fit: contain !important;
}

/* ------------------------------
   Dr / Cr total input tweak
------------------------------ */
#txtdrtotal,
#txtcrtotal {
    height: 30px !important;
    width: 110px !important;
    padding: 4px 8px !important;
    font-size: 14px !important;
    border-radius: 8px !important;
    border: 1px solid #c7d6ee !important;
>>>>>>> 24a78c3ad9450ab2511f66258f5ced924366d5d4
}
textarea {
  width: 100%;
  height: 80px;
  padding: 8px 12px;
  border: 1px solid #b9ccf2;
  border-radius: 8px;
  background: #ffffff;
  font-size: 0.95rem;
  color: #1f2f46;
  box-sizing: border-box;
  resize: vertical;
}
fieldset {
  border: 1px solid #c9dafc;
  border-radius: 8px;
  background: #f8fbff;
}
legend {
  color: #1a2d4d;
  font-weight: 600;
  padding: 0 8px;
}
</style>
<script type="text/javascript">
      $(document).ready(function () { 
    	  getTariftype();
    	 
    	  
    	  getcheckbox();
     setCheck();
    	  document.getElementById("grouplabel").style.display="none";
document.getElementById("txtclient").disabled="true";
    	  $("#jqxTariffDate").jqxDateTimeInput({ width: '100%', height: '38px',formatString:"dd.MM.yyyy"});
    	  $("#jqxTariffFromDate").jqxDateTimeInput({ width: '100%', height: '38px',formatString:"dd.MM.yyyy"});
    	  $("#jqxTariffToDate").jqxDateTimeInput({ width: '100%', height: '38px',formatString:"dd.MM.yyyy"});
    	  document.getElementById("btnTarifEdit").style.display="none";

$('#clienttarifwindow').jqxWindow({autoOpen:false, width: '50%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
$('#clienttarifwindow').jqxWindow('close');
	selectTarif();
	$('#txtclient').dblclick(function(){
		    $('#clienttarifwindow').jqxWindow('open');
		$('#clienttarifwindow').jqxWindow('focus');
		 clientSearchContent('clientSearch.jsp?tariftype='+document.getElementById("cmbtariftype").value, $('#clienttarifwindow'));
		});
	     
      });
    
      function clientSearchContent(url) {
  	    $.get(url).done(function (data) {
  	    $('#clienttarifwindow').jqxWindow('setContent', data);

  	}); 
  	}
      function getClient(event){
          var x= event.keyCode;
          if(x==114){
        	   $('#clienttarifwindow').jqxWindow('open');
       		$('#clienttarifwindow').jqxWindow('focus');
       		 clientSearchContent('clientSearch.jsp?tariftype='+document.getElementById("cmbtariftype").value, $('#clienttarifwindow'));
          }
          else{
           }
          }
      function selectTarif(){
    	  $('#frmTariffManagement select').attr('disabled',false );
  		var temp=document.getElementById("cmbtariftype").value;
  		 if(document.getElementById("mode").value=='A'){
  			 
  		 }
  		else if(temp=="Client"){
  			$('#txtclient').attr('disabled', false );
  			$("#jqxgridtarif").jqxGrid({ disabled: false});
  			$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
  			$("#jqxgridtariffoc").jqxGrid({ disabled: true});
  			$("#jqxgridtariffuel").jqxGrid({ disabled: false});
  			if(document.getElementById("mode").value=='A'){
  	  			$("#jqxgridtarif").jqxGrid({ disabled: true});

  			}
  		}
  		else if(temp=="Corporate"){
  			$('#txtclient').attr('disabled', false );
  			$("#jqxgridtarif").jqxGrid({ disabled: false});
  			$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
  			$("#jqxgridtariffoc").jqxGrid({ disabled: true});
  			$("#jqxgridtariffuel").jqxGrid({ disabled: false});
  			if(document.getElementById("mode").value=='A'){
  	  			$("#jqxgridtarif").jqxGrid({ disabled: true});

  			} 			
  		}
  		else if(temp=="Weekend"){
  			document.getElementById("fieldweekday").style.display="block";
  			document.getElementById("fieldfoc").style.display="none";
  			$("#jqxgridtarifweekday").jqxGrid({ disabled: false});
  			$("#jqxgridtarif").jqxGrid({ disabled: true});
  			if(document.getElementById("mode").value=='A'){
  				$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
  	  			$("#jqxgridtariffoc").jqxGrid({ disabled: true});
  			}
  		}
  		else if(temp=="FOC"){
  			document.getElementById("fieldweekday").style.display="none";
  			document.getElementById("fieldfoc").style.display="block";
  			$("#jqxgridtarifweekday").jqxGrid({ disabled: false});
  			$("#jqxgridtarif").jqxGrid({ disabled: true});
  			if(document.getElementById("mode").value=='A'){
  				$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
  	  			$("#jqxgridtariffoc").jqxGrid({ disabled: true});
  			}
  		}
  		else{
  			$('#txtclient').attr('disabled', true );
  			$("#jqxgridtarif").jqxGrid({disabled: false});
  			$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
  			$("#jqxgridtariffoc").jqxGrid({ disabled: true});
  			$("#jqxgridtariffuel").jqxGrid({ disabled: false});
  			if(document.getElementById("mode").value=='A'){
  	  			$("#jqxgridtarif").jqxGrid({ disabled: true});

  			}
  		}
  	} 
	function funReset(){
    		
    	}
		
    	function funReadOnly(){
			$('#frmTariffManagement input').attr('readonly', true );
			$('#frmTariffManagement select').attr('disabled', true );
			$('#frmTariffManagement textarea').attr('readonly', true );
    		$('#jqxTariffFromDate').jqxDateTimeInput({ disabled: true});
    		$('#jqxTariffToDate').jqxDateTimeInput({ disabled: true});
    		$('#jqxTariffDate').jqxDateTimeInput({ disabled: true});
    		$("#jqxgridtarif").jqxGrid({ disabled: true});
    		$("#jqxgridtariffuel").jqxGrid({ disabled: true});
    		$("#jqxgridtariffoc").jqxGrid({ disabled: true});
    		$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
    		$("#jqxgridtarifgrpfinish").jqxGrid({ disabled: true});
    	} 
    	function funRemoveReadOnly(){
    		$('#frmTariffManagement input').attr('readonly', false );
			$('#frmTariffManagement select').attr('disabled', false );
			$('#frmTariffManagement textarea').attr('readonly', false );
    		$('#jqxTariffFromDate').jqxDateTimeInput({ disabled: false});
    		$('#jqxTariffToDate').jqxDateTimeInput({ disabled: false});
    		$('#jqxTariffDate').jqxDateTimeInput({ disabled: false});
    		$("#jqxgridtarif").jqxGrid({ disabled: false});
    		$("#jqxgridtariffuel").jqxGrid({ disabled: false});
    		$("#jqxgridtariffoc").jqxGrid({ disabled: false});
    		$("#jqxgridtarifweekday").jqxGrid({ disabled: false});
    		$("#jqxgridtarifgrpfinish").jqxGrid({ disabled: false});
    		if(document.getElementById("mode").value=='A'){
    			$("#divRegularTarif").load("gridRegularTarif.jsp");
    			 $("#divfoc").load("gridFoc.jsp");
          		 $("#divweekday").load("gridWeekday.jsp");
          		 $("#divgroup1").load("gridgroup1.jsp");
          		 $("#divgroup2").load("gridgroup2.jsp");
          		 document.getElementById("grouplabel").style.display="none";
          		 document.getElementById("btnTarifEdit").style.display="none";
          		document.getElementById("btnTarifSave").style.display="none";
          		 $("#jqxTariffFromDate").jqxDateTimeInput('setDate', new Date());
          		$("#jqxTariffToDate").jqxDateTimeInput('setDate', new Date());
          		$("#jqxTariffDate").jqxDateTimeInput('setDate', new Date());

    		}
    	}
    	function funNotify(){	
    	 	if(document.getElementById("docno").value!=''){	
    	var rows = $("#jqxgridtarif").jqxGrid('getrows');
    		$('#gridlength').val(rows.length);
    		for(var i=0 ; i < rows.length ; i++){
				newTextBox = $(document.createElement("input"))
			    .attr("type", "dil")
			    .attr("id", "test"+i)
			    .attr("name", "test"+i);
				
			newTextBox.val(rows[i].rentaltype+"::"+rows[i].rate+"::"+rows[i].cdw+"::"+rows[i].pai+"::"+rows[i].cdw1+"::"+rows[i].pai1+"::"+rows[i].gps+"::"+rows[i].babyseater+"::"+rows[i].cooler+"::"+rows[i].exhrchg+"::"+rows[i].chaufchg+"::"+rows[i].chaufexchg+"::"+rows[i].disclevel1+"::"+rows[i].disclevel2+"::"+rows[i].disclevel3+"::"+rows[i].kmrest+"::"+rows[i].exkmrte+"::"+rows[i].oinschg);
			
			newTextBox.appendTo('form');
			}
    	if(document.getElementById("cmbtariftype").value=='Weekend'){
    		var rowsweekday=$("#jqxgridtarifweekday").jqxGrid('getrows');
    		var j=0;
    		for(var i=0 ; i < rowsweekday.length ; i++){

    				newTextBoxweekday = $(document.createElement("input"))
    			    .attr("type", "dil")
    			    .attr("id", "txtweekday"+i)
    			    .attr("name", "txtweekday"+i);
    				var d=new Date(rowsweekday[i].cstime);
    				var tempstarttime=d.getHours()+":"+(d.getMinutes()<10?'0':'') + d.getMinutes();
    				var d1=new Date(rowsweekday[i].cetime);
    				var tempendtime=d1.getHours()+":"+(d1.getMinutes()<10?'0':'') + d1.getMinutes();
    				if(typeof(rowsweekday[i].cswkday)!="undefined" && rowsweekday[i].cswkday!="" && typeof(rowsweekday[i].cstime)!="undefined" && typeof(rowsweekday[i].cstime)!="" && 
    						typeof(rowsweekday[i].cewkday)!="undefined" && typeof(rowsweekday[i].cewkday)!="" && typeof(rowsweekday[i].cetime)!="undefined" && typeof(rowsweekday[i].cetime)!=""){
    					newTextBoxweekday.val(rowsweekday[i].cswkday+"::"+tempstarttime+"::"+rowsweekday[i].cewkday+"::"+tempendtime+"::"+rowsweekday[i].rate+"::"+rowsweekday[i].cdw+"::"+rowsweekday[i].gps+"::"+rowsweekday[i].babyseater+"::"+rowsweekday[i].cooler+"::"+rowsweekday[i].kmrest+"::"+rowsweekday[i].exkmrte+"::"+rowsweekday[i].oinschg+"::"+rowsweekday[i].ulevel1+"::"+rowsweekday[i].ulevel2+"::"+rowsweekday[i].ulevel3+"::"+rowsweekday[i].exdaychg);
    				j++;
    				newTextBoxweekday.appendTo('form');
    				}
    			}
    		$('#weekdaylength').val(j);
    	}
    	if(document.getElementById("cmbtariftype").value=='FOC'){
    		var rowsfoc=$("#jqxgridtariffoc").jqxGrid('getrows');
    		$('#foclength').val(rowsfoc.length);
    		for(var i=0 ; i < rowsfoc.length ; i++){
    				newTextBoxfoc = $(document.createElement("input"))
    			    .attr("type", "dil")
    			    .attr("id", "txtfoc"+i)
    			    .attr("name", "txtfoc"+i);
    				newTextBoxfoc.val(rowsfoc[i].minday+"::"+rowsfoc[i].foc+"::"+rowsfoc[i].rate+"::"+rowsfoc[i].cdw+"::"+rowsfoc[i].gps+"::"+rowsfoc[i].babyseater+"::"+rowsfoc[i].cooler+"::"+rowsfoc[i].kmrest+"::"+rowsfoc[i].exkmrte+"::"+rowsfoc[i].oinschg);
    				newTextBoxfoc.appendTo('form');
    			}
    	}
    		var a=document.getElementById("gridlength").value;
			var b=document.getElementById("weekdaylength").value;
			var c=document.getElementById("foclength").value;
			var d=document.getElementById("fuellength").value;
    			}
    			$('#frmTariffManagement select').attr('disabled',false);
    			$('#txtclient').attr('disabled',false);
			return 1;
			$('#frmTariffManagement select').attr('disabled',true);
    	} 

     	function funChkButton() {
    		/* funReset(); */
    	}

    	function funSearchLoad(){
    		changeContent('tarifSearch.jsp', $('#window')); 
    	}
    		
     	function funFocus(){
    	   	$('#jqxTariffDate').jqxDateTimeInput('focus'); 	    	
     	}
		function setCheck(){
			if(document.getElementById("chckdeliverychg").checked==true){
				document.getElementById("hidcheck").value=1;
			}
			else
				document.getElementById("hidcheck").value=0;
		}
		function getcheckbox(){
			if(document.getElementById("hidcheck").value==1){
				document.getElementById("chckdeliverychg").checked=true;
			}
			else{
				document.getElementById("chckdeliverychg").unchecked=true;
			}
		}
		function setValues(){
			document.getElementById("cmbtariftype").disabled=false;
			if(document.getElementById("cmbtariftype").value=="Weekend"){
				document.getElementById("fieldweekday").style.display="block";
	  			document.getElementById("fieldfoc").style.display="none";
			}
			if(document.getElementById("cmbtariftype").value=="FOC"){
				document.getElementById("fieldweekday").style.display="none";
	  			document.getElementById("fieldfoc").style.display="block";
			}
			if(document.getElementById("docno")!=''){
				var temp=document.getElementById("docno").value;
				$("#divgroup2").load("gridgroup2.jsp?id="+temp);
				$("#divgroup1").load("gridgroup1.jsp?id="+temp);
			}
			if ($('#hidcmbtariftype').val() != null) {
				$('#cmbtariftype').val($('#hidcmbtariftype').val());
			}
			if ($('#hidcmbtariffor').val() != null) {
				$('#cmbtariffor').val($('#hidcmbtariffor').val());
			}
			if($('#hidjqxTariffDate').val()){
				$("#jqxTariffDate").jqxDateTimeInput('val', $('#hidjqxTariffDate').val());
			}
			if($('#hidjqxTariffFromDate').val()){
				$("#jqxTariffFromDate").jqxDateTimeInput('val', $('#hidjqxTariffFromDate').val());
			}
			if($('#hidjqxTariffToDate').val()){
				$("#jqxTariffToDate").jqxDateTimeInput('val', $('#hidjqxTariffToDate').val());
			}
			if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
if(document.getElementById("docno").value==''){
	document.getElementById("btnTarifEdit").style.display="none";
}

document.getElementById("cmbtariftype").disabled=true;
		}
		 function funTarifEdit(){
		 	 document.getElementById("cmbtariftype").disabled=false;
		 	$("#jqxgridtarifgrp").jqxGrid({ disabled:false});
		 	document.getElementById("insurexcess").readOnly=false;
		 	document.getElementById("cdwexcess").readOnly=false;
		 	document.getElementById("scdwexcess").readOnly=false;
		 	document.getElementById("securityamt").readOnly=false;
	    		if(document.getElementById("cmbtariftype").value=="Weekend"){
	    			$("#jqxgridtarifweekday").jqxGrid({ disabled: false});
	    			$("#jqxgridtariffoc").jqxGrid({ disabled:true});
	    			$("#jqxgridtarif").jqxGrid({ disabled: true});
	    			 document.getElementById("btnTarifEdit").style.display="none";
		     			document.getElementById("btnTarifSave").style.display="block";
	    		}
	    		else if(document.getElementById("cmbtariftype").value=="FOC"){
	    			$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
	    			$("#jqxgridtariffoc").jqxGrid({ disabled:false});
	    			$("#jqxgridtarif").jqxGrid({ disabled: true});
	    			 document.getElementById("btnTarifEdit").style.display="none";
		     			document.getElementById("btnTarifSave").style.display="block";
	    		}
	    		else{
	    			$("#jqxgridtariffoc").jqxGrid({ disabled: true});
	        		$("#jqxgridtarifweekday").jqxGrid({ disabled: true});
	        		$("#jqxgridtariffuel").jqxGrid({ disabled: false});
	        		 document.getElementById("btnTarifEdit").style.display="none";
	     			document.getElementById("btnTarifSave").style.display="block";
	    			$("#jqxgridtarif").jqxGrid({ disabled: false});
	    		}
		 	document.getElementById("cmbtariftype").disabled=true;
		}  
		 function funTarifSave(){
			 document.getElementById("cmbtariftype").disabled=false;
			 if(document.getElementById("cmbtariftype").value=="Weekend"){
	
				 var rowsweekday=$('#jqxgridtarifweekday').jqxGrid('getrows');
	
				 if(typeof(rowsweekday[0].cswkday)=="undefined" || rowsweekday[0].cswkday==""){
			
					 document.getElementById("errormsg").innerText="";
		    			document.getElementById("errormsg").innerText="Start day is Mandatory";
		    			return false;
		    		}
		    		if(typeof(rowsweekday[0].cstime)=="undefined" || rowsweekday[0].cstime==""){
		    			document.getElementById("errormsg").innerText="";
		    			document.getElementById("errormsg").innerText="Start time is Mandatory";
		    			return false;
		    		}
		    		if(typeof(rowsweekday[0].cewkday)=="undefined" || rowsweekday[0].cewkday==""){
		    			document.getElementById("errormsg").innerText="";
		    			document.getElementById("errormsg").innerText="End day is Mandatory";
		    			return false;
		    		}
		    		if(typeof(rowsweekday[0].cetime)=="undefined" || rowsweekday[0].cetime==""){
		    			document.getElementById("errormsg").innerText="";
		    			document.getElementById("errormsg").innerText="End time is Mandatory";
		    			return false;
		    		}
		    		if(typeof(rowsweekday[0].rate)=="undefined" || rowsweekday[0].rate==""){
		    			document.getElementById("errormsg").innerText="";
		    			document.getElementById("errormsg").innerText="Tariff is Mandatory";
		    			return false;
		    		}
			 }
			if(document.getElementById("docno").value!=""){
				 document.getElementById("mode").value="A";
				 $('#btnSave').mousedown();	 
			 }
			 else{
				 $.messager.alert('Warning','Please Select a Valid Document');
				 return false;
			 }
			 document.getElementById("cmbtariftype").disabled=true;
		 }
		  function isNumber(evt,id) {
		        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
		        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
		         {
		        	 $.messager.alert('Warning','Enter Numbers Only');
		           $("#"+id+"").focus();
		            return false;
		            
		         }
		        
		        return true;
		    }
		function funPrintBtn() {
	   		if(document.getElementById("docno").value=='' || document.getElementById("docno").value=='0'){
	   		 $.messager.alert('Warning','Select a Document');
	   		 return false;
		   		}
	   		var url=document.URL;
	   	 var reurl=url.split("com/");
	   	  	var win= window.open(reurl[0]+"com/controlcentre/masters/tarifmgmt/tarifPrint.action?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	   		win.focus();  
		}
		function getTariftype(){
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items=items.split("***");
					var tarifitems = items[0].split(",");
					var status=items[1];				
					var optionstarif = '<option value="">--Select--</option>';
					for (var i = 0; i < tarifitems.length; i++) {
						optionstarif += '<option value="' + tarifitems[i] + '">'
								+ tarifitems[i] + '</option>';
					}
					$("select#cmbtariftype").html(optionstarif);
				 	 if ($('#hidcmbtariftype').val() != null) {
						$('#cmbtariftype').val($('#hidcmbtariftype').val());
					}
				 	  document.getElementById("fieldfoc").style.display="none";
		        	  document.getElementById("fieldweekday").style.display="none";	
				}
			}
			x.open("GET", "getTariftype.jsp", true);
			x.send();
		}
</script>

</head>
<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmTariffManagement" action="saveTariffManagement" autocomplete="off">
	<script>
		window.parent.formName.value="Tariff Management";
		window.parent.formCode.value="TFM";
	</script>
	<jsp:include page="../../../../header.jsp" />
	<br/>

<<<<<<< HEAD
<div class='hidden-scrollbar receipt-header'>
<table class="cr-table" width="100%" >
=======
<div  class='hidden-scrollbar receipt-header'>
    <div class="section-block">
    <h2>Debit Note Details</h2>

    <!-- ROW 1 -->
    <div class="row3">

        <div class="row-flex">
            <label class="lbl">Date</label>
            <div id="jqxDebitNoteDate" class="inp"></div>
        </div>

        <div class="row-flex">
            <label class="lbl">Ref. No.</label>
            <input type="text" class="inp"
                   id="txtrefno" name="txtrefno"
                   value='<s:property value="txtrefno"/>'>
        </div>

        <div class="row-flex">
            <label class="lbl">Doc No.</label>
            <input type="text" class="inp"
                   id="docno" name="txtdebitnotedocno"
                   value='<s:property value="txtdebitnotedocno"/>'>
        </div>

    </div>

    <!-- ROW 2 -->
    <div class="row3">

        <div class="row-flex">
            <label class="lbl">Type</label>
            <select class="inp" id="cmbtype" name="cmbtype"
                    onchange="clearClientInfo();">
                <option value="AR">AR</option>
                <option value="AP">AP</option>
                <option value="GL">GL</option>
            </select>
        </div>

        <div class="row-flex">
            <label class="lbl">Account</label>
            <input type="text" class="inp"
                   id="txtaccid" name="txtaccid"
                   placeholder="Press F3 to Search"
                   value='<s:property value="txtaccid"/>'
                   onkeydown="getAccType(event);">
        </div>

        <div class="row-flex">
            <label class="lbl">Account Name</label>
            <input type="text" class="inp"
                   id="txtaccname" name="txtaccname"
                   value='<s:property value="txtaccname"/>'>
        </div>

    </div>

    <!-- ROW 3 -->
    <div class="row3">

        <div class="row-flex">
            <label class="lbl">Currency</label>
            <select class="inp" id="cmbcurrency" name="cmbcurrency"
                    onchange="getRatevalue(this.value,$('#jqxDebitNoteDate').val());">
            </select>
        </div>

        <div class="row-flex">
            <label class="lbl">Rate</label>
            <input type="text" class="inp"
                   id="txtrate" name="txtrate"
                   style="text-align:right;"
                   value='<s:property value="txtrate"/>'
                   onblur="funRoundRate(this.value,this.id);getBaseAmountFrom();getDrTotal();">
        </div>

        <div class="row-flex">
            <label class="lbl">Amount</label>
            <input type="text" class="inp"
                   id="txtamount" name="txtamount"
                   style="text-align:right;"
                   value='<s:property value="txtamount"/>'
                   onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getDrTotal();">
        </div>

    </div>

    <!-- ROW 4 -->
    <div class="row3">

        <div class="row-flex">
            <label class="lbl">Base Amount</label>
            <input type="text" class="inp"
                   id="txtbaseamount" name="txtbaseamount"
                   style="text-align:right;"
                   value='<s:property value="txtbaseamount"/>'>
        </div>

        <div class="row-flex">
            <label class="lbl">Description</label>
            <input type="text" class="inp"
                   id="txtdescription" name="txtdescription"
                   value='<s:property value="txtdescription"/>'>
        </div>

    </div>

</div>
    

<div class="cr-table" id="jqxDebitNoteGrid"><jsp:include page="debitNoteGrid.jsp"></jsp:include></div><br/>
<table class="cr-table" width="100%">
>>>>>>> 24a78c3ad9450ab2511f66258f5ced924366d5d4
  <tr>
    <td width="3%" align="right">Date</td>
    <td width="8%" align="left"><input type="hidden" id="hidjqxTariffDate" name="hidjqxTariffDate" value='<s:property value="hidjqxTariffDate"/>'/>
      <div id='jqxTariffDate' name='jqxTariffDate' value='<s:property value="jqxTariffDate"/>'></div></td>
    <td width="5%" align="right">Tariff Type</td>
    <td width="18%" align="left"><select id="cmbtariftype" name="cmbtariftype" value='<s:property value="cmbtariftype"/>' onchange="selectTarif();" >
      <option value="">--Select--</option></select>
      <input type="text" name="txtclient" id="txtclient" value='<s:property value="txtclient"/>' onkeydown="getClient(event);">
      <input type="hidden" id="hidcmbtariftype" name="hidcmbtariftype" value='<s:property value="hidcmbtariftype"/>'/></td>
    <input type="hidden" name="hidtxtclient" id="hidtxtclient" value='<s:property value="hidtxtclient"/>'/>
    <td width="4%" align="right">Tariff For</td>
    <td width="9%" align="left"><select id="cmbtariffor" name="cmbtariffor" value='<s:property value="cmbtariffor"/>' >
      <option value="">--Select--</option><option value="Vehicle">Vehicle</option>
    </select>
      <input type="hidden" id="hidcmbtariffor" name="hidcmbtariffor" value='<s:property value="hidcmbtariffor"/>'/></td>
    <td width="6%" align="right">Validity From</td>
    <td width="9%" align="left"><input type="hidden" id="hidjqxTariffFromDate" name="hidjqxTariffFromDate" value='<s:property value="hidjqxTariffFromDate"/>'/>
      <div id='jqxTariffFromDate' name='jqxTariffFromDate' value='<s:property value="jqxTariffFromDate"/>'></div></td>
    <td width="5%" align="right">Validity To</td>
    <td width="9%" align="left"><input type="hidden" id="hidjqxTariffToDate" name="hidjqxTariffToDate" value='<s:property value="hidjqxTariffToDate"/>'/>
      <div id='jqxTariffToDate' name='jqxTariffToDate' value='<s:property value="jqxTariffToDate"/>'></div></td>
    <td width="9%" align="left"><input type="checkbox" id="chckdeliverychg" name="chckdeliverychg"  onchange="setCheck();">
      &nbsp;&nbsp;Delivery Charge</td><input type="hidden" name="hidcheck" id="hidcheck" value='<s:property value="hidcheck"/>'/>
    <td width="4%" align="right">Doc No</td>
    <td width="11%" align="left"><input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>'/></td>
  </tr>
  <tr>
    <td height="41" align="right">Notes</td>
    <td align="left" colspan="10"><textarea id="notes" name="notes" style="width:100%;resize:vertical;"><s:property value="notes"/></textarea></td>
    <td align="center">
    <button type="button"  id="btnTarifEdit" title="Tarif Edit" style="border:none;background:none;" onclick="funTarifEdit();">
							<img alt="Tarif Edit" src="<%=contextPath%>/icons/tarifedit.png" width="30" height="30">
		  </button>
    <button type="button" id="btnTarifSave" title="Tarif Save" hidden="true" style="border:none;background:none;" onclick="funTarifSave();">
							<img alt="Tarif Save" src="<%=contextPath%>/icons/tarifsave.png" width="30" height="30">
		  </button>
    </td>
  </tr>
</table>
<center><label id="grouplabel" style="color:red;font-weight:bold;"></label></center>

<table width="100%">
  <tr>
    <td width="6%" rowspan="11" ><div id="divgroup1" ><jsp:include page="gridgroup1.jsp"></jsp:include></div></td>
    <td colspan="2" align="center"><fieldset><div id="divRegularTarif"><jsp:include page="gridRegularTarif.jsp"></jsp:include></div></fieldset></td>
    <td width="6%" rowspan="11"><div id="divgroup2"><jsp:include page="gridgroup2.jsp"></jsp:include></div></td></tr>
  <tr>
    <td colspan="2"  align="center"><fieldset id="fieldextrainsur" align="left">
      <table width="100%">
        <tr>
          <td align="right">Security Amount</td><td align="left"><input type="text" name="securityamt" id="securityamt" value='<s:property value="securityamt"/>' onkeypress="javascript:return isNumber (event,this.id)"></td>
          <td align="right">Insurance Excess</td><td align="left"><input type="text" name="insurexcess" id="insurexcess" value='<s:property value="insurexcess"/>' onkeypress="javascript:return isNumber (event,this.id)"></td>
          <td align="right">CDW Excess</td><td align="left"><input type="text" name="cdwexcess" id="cdwexcess" value='<s:property value="cdwexcess"/>' onkeypress="javascript:return isNumber (event,this.id)"></td>
          <td align="right">Super CDW Excess</td><td align="left"><input type="text" name="scdwexcess" id="scdwexcess" value='<s:property value="scdwexcess"/>' onkeypress="javascript:return isNumber (event,this.id)"></td>
        </tr>
      </table>
    </fieldset></td>
  </tr>
  <tr>
    <td colspan="2"  align="center"><fieldset id="fieldfoc" align="left" style="display:none;">
      <legend>FOC Tariff</legend>
      <table width="100%">
        <tr>
          <td><div id="divfoc">
            <jsp:include page="gridFoc.jsp"></jsp:include>
          </div></td>
        </tr>
      </table>
    </fieldset></td>
  </tr>
  <tr>
    <td colspan="2"  align="center"><fieldset id="fieldweekday" align="left" style="display:none;">
      <legend>Week Day Tariff</legend>
      <table width="100%">
        <tr>
          <td><div id="divweekday">
            <jsp:include page="gridWeekday.jsp"></jsp:include>
          </div></td>
        </tr>
      </table>
    </fieldset></td>
  </tr>
  <tr>
    <td colspan="2"  align="center">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2"  align="center">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2" >&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2" >&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2" >&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2" >&nbsp;</td>
  </tr>
<input type="hidden" id="mode" name="mode"/>
<input type="hidden" name="delete" id="delete" value='<s:property value="delete"/>'/>
<input type="hidden" name="tempgroup" id="tempgroup" value='<s:property value="tempgroup"/>'>
<input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
<input type="hidden" name="weekdaylength" id="weekdaylength" value='<s:property value="weekdaylength"/>'>
<input type="hidden" name="foclength" id="foclength" value='<s:property value="foclength"/>'>
<input type="hidden" name="fuellength" id="fuellength" value='<s:property value="fuellength"/>'>
<input type="hidden" name="tarifmode" id="tarifmode" value='<s:property value="tarifmode"/>'>
<input type="hidden" name="temprowindex" id="temprowindex" value='<s:property value="temprowindex"/>'> 
<input type="hidden" name="deliverylength" id="deliverylength" value='<s:property value="deliverylength"/>'>
<input type="hidden" name="tempdocno" id="tempdocno" value='<s:property value="tempdocno"/>'>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
<input type="hidden" name="tempstatus" id="tempstatus" value='<s:property value="tempstatus"/>'>
<input type="hidden" name="formdetail" id="formdetail" value='<s:property value="formdetail"/>'>
<input type="hidden" name="formdetailcode" id="formdetailcode" value='<s:property value="formdetailcode"/>'>
<input type="hidden" name="conditionstatus" id="conditionstatus" value='<s:property value="conditionstatus"/>'/>
<input type="hidden" name="hidgroupdoc" id="hidgroupdoc" value='<s:property value="hidgroupdoc"/>'/>
</table>
</form>
</div>
<div id="clienttarifwindow">
   <div ></div>
</div>
<div hidden="true">
<fieldset>
  <legend>Fuel Info</legend>
  <table width="100%">
    <tr>
      <td><div id="divfuel">
        <jsp:include page="gridfuel.jsp"></jsp:include>
      </div></td>
    </tr>
  </table>
</fieldset>
</div>
<p>&nbsp;</p>
</body>
</html>

