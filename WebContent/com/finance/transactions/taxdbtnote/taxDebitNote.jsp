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
/* ----------- Scrollbar ------------ */
.hidden-scrollbar {
  overflow-y: auto;
  height: 530px;
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

/* ----------- Page Background ------------ */
body {
  background: linear-gradient(135deg, #e8f1ff 0%, #d1e4ff 100%);
  font-family: "Poppins", "Segoe UI", sans-serif;
  color: #1f2f46;
  margin: 0;
  padding: 40px 0;
  min-height: 100vh;
  animation: fadeIn 0.6s ease-in-out;
}

/* ----------- Main Container ------------ */
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

/* ----------- Section Container ------------ */
.receipt-header {
  background: #edf4ff;
  border: 1px solid #c9dafc;
  border-radius: 14px;
  padding: 20px;
  margin-bottom: 26px;
  box-shadow: 0 2px 10px rgba(132, 168, 255, 0.2);
}

/* ----------- Labels ------------ */
label {
  font-weight: 600;
  font-size: 15px;
  color: #1a2d4d;
  margin-bottom: 6px !important;
}

/* ----------- Unified Input Styling ------------ */
input[type="text"],
select,
.clean-input {
  width: 100%;
  height: 38px !important;
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

/* ----------- Dropdown ------------ */
select {
  appearance: none;
  background: #ffffff url("data:image/svg+xml;utf8,<svg fill='%233b82f6' height='20' width='20' viewBox='0 0 20 20'><polygon points='5,7 15,7 10,12' /></svg>") no-repeat right 10px center;
  background-size: 14px;
}
select option {
  font-size: 15px;
}

/* ----------- Disabled Inputs ------------ */
input[readonly],
select:disabled {
  background-color: #eef3ff !important;
  color: #6a7ba1 !important;
}

/* ----------- JQX Date Input ------------ */
#jqxDebitNoteDate {
  width: 100% !important;
  height: 38px !important;
}
#jqxDebitNoteDate input {
  height: 36px !important;
  padding-left: 10px !important;
  border-radius: 8px !important;
  background-color: #ffffff !important;
  box-shadow: none !important;
}

/* ----------- Autofill Pink FIX ------------ */
input:-webkit-autofill,
input:-webkit-autofill:hover,
input:-webkit-autofill:focus,
select:-webkit-autofill {
  -webkit-box-shadow: 0 0 0px 1000px #ffffff inset !important;
  background-color: #ffffff !important;
  color: #1f2f46 !important;
}
input::selection,
#jqxDebitNoteDate input::selection {
  background: #cfe2ff !important;
  color: #000 !important;
}

/* ----------- Grid Form Layout ------------ */
.clean-grid-form {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 22px 32px;
  width: 100%;
  box-sizing: border-box;
}
.clean-grid-item {
  display: flex;
  flex-direction: column;
}
.clean-grid-item.full {
  grid-column: span 3;
}

/* ----------- Table Styling ------------ */
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

/* ----------- Buttons ------------ */
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

/* ----------- Error Text ------------ */
#validrate,
#errormsg {
  color: #d62828;
  font-weight: 600;
  font-size: 0.9rem;
}

/* Fade Animation */
@keyframes fadeIn {
  from { opacity: 0; transform: translateY(-5px); }
  to { opacity: 1; transform: translateY(0); }
}

/* Mobile */
@media (max-width: 900px) {
  .clean-grid-form {
    grid-template-columns: repeat(1, 1fr);
  }
  .clean-grid-item.full {
    grid-column: span 1;
  }
}
/* Outer wrapper */
#jqxDebitNote {
    border: 1px solid #9db4d9 !important;   /* DARKER border */
    border-radius: 12px !important;
    overflow: hidden !important;
}

/* HEADER STYLING */
.jqx-grid-column-header,
.jqx-widget-header {
    background: #d5e4ff !important;
    color: #0f2a4d !important;             /* DARKER header text */
    font-weight: 700 !important;           /* BOLDER */
    font-size: 14.5px !important;
    border-bottom: 1px solid #9db4d9 !important; /* darker header line */

    height: 38px !important;
    min-height: 38px !important;
    line-height: 38px !important;
    padding: 0 !important;
}

/* Remove inner alignment issues */
.jqx-grid-column-header div,
.jqx-widget-header div {
    padding: 0 10px !important;
    margin: 0 !important;
    line-height: 38px !important;
}

/* ROW STYLING */
.jqx-grid-cell {
    background-color: #ffffff !important;
    border-color: #d3def5 !important;       /* darker row borders */
    font-size: 14px !important;
    color: #1c2f4a !important;
    
    height: 38px !important;
    min-height: 38px !important;
    padding: 0 10px !important;

    display: flex !important;
    align-items: center !important;         /* vertical centering */
}

/* Alternate rows */
.jqx-grid-cell-alt {
    background-color: #f4f7ff !important;
}

/* Hover */
.jqx-grid-cell-hover {
    background-color: #e4edff !important;
}

/* Selected cell */
.jqx-grid-cell-selected {
    background-color: #c3d6ff !important;
    border-color: #6a92d7 !important;
}

/* Checkbox alignment */
.jqx-grid-cell input[type="checkbox"] {
    transform: scale(1.2);
    margin-left: 6px !important;
}

/* Status bar (footer) */
.jqx-grid-statusbar {
    background: #e3ecff !important;
    border-top: 1px solid #9db4d9 !important;
    color: #0f2a4d !important;
    font-size: 14px !important;
    font-weight: 700 !important;

    height: 34px !important;
    padding: 6px 10px !important;
}

/* Scrollbars */
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
}
select:-webkit-autofill,
select:-webkit-autofill:hover,
select:-webkit-autofill:focus {
    -webkit-box-shadow: 0 0 0px 1000px #ffffff inset !important;
    background-color: #ffffff !important;
    color: #1f2f46 !important;
}
input[type="text"],
select,
.clean-input {
  font-size: 15px !important;   /* increased text size */
}
/* 1) native autofill fixes (Chrome / Blink) */
input:-webkit-autofill,
input:-webkit-autofill:hover,
input:-webkit-autofill:focus,
select:-webkit-autofill,
textarea:-webkit-autofill {
  -webkit-text-fill-color: #1f2f46 !important;
  -webkit-box-shadow: 0 0 0px 1000px #ffffff inset !important; /* paint white */
  box-shadow: 0 0 0px 1000px #ffffff inset !important;
  background-color: #ffffff !important;
}

/* 2) force select appearance / remove pink background on selects (Chrome) */
select,
select:focus,
select:hover {
  background-color: #ffffff !important;
  -webkit-appearance: none !important;
  appearance: none !important;
  -webkit-text-fill-color: #1f2f46 !important;
  color: #1f2f46 !important;
  background-image: url("data:image/svg+xml;utf8,<svg fill='%233b82f6' height='20' width='20' viewBox='0 0 20 20'><polygon points='5,7 15,7 10,12' /></svg>") !important;
  background-repeat: no-repeat !important;
  background-position: right 10px center !important;
  background-size: 14px !important;
}

/* 3) standardize select option font-size */
select, select option {
  font-size: 15px !important;
  line-height: 1.2 !important;
}

/* 4) JQX input / dropdown internals (covers most jqx styles) */
.jqx-input,
.jqx-input-content,
.jqx-dropdownlist,
.jqx-dropdownlist-content,
.jqx-dropdownlist-input,
.jqx-widget .jqx-input,
.jqx-widget .jqx-input-content,
.jqx-widget .jqx-dropdownlist {
  background-color: #ffffff !important;
  color: #1f2f46 !important;
  -webkit-box-shadow: 0 0 0px 1000px #ffffff inset !important;
  box-shadow: 0 0 0px 1000px #ffffff inset !important;
  border-color: #b9ccf2 !important;
}

/* 5) Remove any background-image set by JQX that could look pink */
.jqx-input .jqx-input-content,
.jqx-dropdownlist .jqx-input-content,
.jqx-dropdownlist-content {
  background-image: none !important;
}

/* 6) On focus ensure white background and visible text */
.jqx-input:focus,
.jqx-input-content:focus,
.jqx-dropdownlist:focus,
.jqx-dropdownlist-content:focus,
select:focus {
  background-color: #ffffff !important;
  color: #1f2f46 !important;
  -webkit-text-fill-color: #1f2f46 !important;
}

/* 7) Ensure date widget input (jqxDateTimeInput) text colour and background */
#jqxDebitNoteDate input,
#jqxBankReconciliationDate input,
.jqx-datetimeinput-input {
  background-color: #ffffff !important;
  color: #1f2f46 !important;
  -webkit-box-shadow: 0 0 0px 1000px #ffffff inset !important;
}

/* 8) Increase input/select font-size globally (only size change) */
input[type="text"],
input,
select,
.clean-input,
.jqx-input,
.jqx-dropdownlist {
  font-size: 16px !important; /* bump up a bit */
}

/* 9) last resort: override inline styles applied by scripts (very high specificity) */
body [style*="background"]:not(.keep-bg) {
  background-color: inherit !important;
}

/* 10) small visual guard for disabled fields (keeps them readable) */
input[readonly],
select:disabled {
  background-color: #f4f7ff !important;
  color: #6a7ba1 !important;
}
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmTaxDebitNote" action="saveTaxDebitNote" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div  class='hidden-scrollbar receipt-header'>
    <div class="table-section">

        <!-- ====== CLEAN GRID FORM (REPLACED TOP SECTION) ====== -->
        <div class="clean-grid-form">

            <!-- ROW 1 -->
            <div class="clean-grid-item">
                <label>Date</label>
                <div id="jqxDebitNoteDate"
                     onchange="datechange();"
                     onblur="datechange();"></div>
                <input type="hidden" id="hidjqxDebitNoteDate" name="hidjqxDebitNoteDate"
                       value='<s:property value="hidjqxDebitNoteDate"/>'/>
            </div>

            <div class="clean-grid-item">
                <label>Ref. No.</label>
                <input type="text" id="txtrefno" name="txtrefno"
                       class="clean-input"
                       value='<s:property value="txtrefno"/>'/>
            </div>

            <div class="clean-grid-item">
                <label>Doc No.</label>
                <input type="text" id="docno" name="txtdebitnotedocno"
                       class="clean-input"
                       value='<s:property value="txtdebitnotedocno"/>' tabindex="-1"/>
            </div>

            <!-- ROW 2 -->
            <div class="clean-grid-item">
                <label>Type</label>
                <select id="cmbtype" name="cmbtype" class="clean-input"
                        onchange="clearClientInfo();">
                    <option value="AR">AR</option>
                    <option value="AP">AP</option>
                    <option value="GL">GL</option>
                </select>
                <input type="hidden" id="hidcmbtype" name="hidcmbtype"
                       value='<s:property value="hidcmbtype"/>'/>
            </div>

            <div class="clean-grid-item">
                <label>Account</label>
                <input type="text" id="txtaccid" name="txtaccid"
                       class="clean-input"
                       placeholder="Press F3 to Search"
                       value='<s:property value="txtaccid"/>'
                       onkeydown="getAccType(event);" />
            </div>

            <div class="clean-grid-item">
                <label>Account Name</label>
                <input type="text" id="txtaccname" name="txtaccname"
                       class="clean-input"
                       value='<s:property value="txtaccname"/>' tabindex="-1"/>
                <input type="hidden" id="txtdocno" name="txtdocno"
                       value='<s:property value="txtdocno"/>'/>
                <input type="hidden" id="txttrno" name="txttrno"
                       value='<s:property value="txttrno"/>'/>
            </div>

            <!-- ROW 3 -->
            <div class="clean-grid-item">
                <label>Currency</label>
                <select id="cmbcurrency" name="cmbcurrency"
                        class="clean-input"
                        onchange="getRatevalue(this.value,$('#jqxDebitNoteDate').val());">
                </select>
                <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency"
                       value='<s:property value="hidcmbcurrency"/>'/>
            </div>

            <div class="clean-grid-item">
                <label>Rate</label>
                <input type="text" id="txtrate" name="txtrate"
                       class="clean-input"
                       style="text-align:right;"
                       value='<s:property value="txtrate"/>'
                       onblur="funRoundRate(this.value,this.id);getBaseAmountFrom();getDrTotal();" />
                <span id="validrate"></span>
            </div>

            <div></div>

            <!-- ROW 4 -->
            <div class="clean-grid-item">
                <label>Amount</label>
                <input type="text" id="txtamount" name="txtamount"
                       class="clean-input"
                       style="text-align:right;"
                       value='<s:property value="txtamount"/>'
                       onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getDrTotal();" />
            </div>

            <div class="clean-grid-item">
                <label>Base Amount</label>
                <input type="text" id="txtbaseamount" name="txtbaseamount"
                       class="clean-input"
                       style="text-align:right;"
                       value='<s:property value="txtbaseamount"/>' tabindex="-1"/>
            </div>

            <div></div>

            <!-- ROW 5 -->
            <div class="clean-grid-item full">
                <label>Description</label>
                <input type="text" id="txtdescription" name="txtdescription"
                       class="clean-input"
                       value='<s:property value="txtdescription"/>'/>
            </div>

        </div>
        <!-- ====== END CLEAN GRID FORM ====== -->

    </div>

<div class="cr-table" id="jqxDebitNoteGrid"><jsp:include page="debitNoteGrid.jsp"></jsp:include></div><br/>
<table class="cr-table" width="100%">
  <tr>
    <td width="7%" align="right">Dr. Total</td>
    <td width="68%"><input type="text" id="txtdrtotal" name="txtdrtotal" style="width:15%;text-align: right;" value='<s:property value="txtdrtotal"/>' tabindex="-1"/></td>
    <td width="6%" align="right">Cr. Total</td>
    <td width="19%"><input type="text" id="txtcrtotal" name="txtcrtotal" style="width:50%;text-align: right;" value='<s:property value="txtcrtotal"/>' tabindex="-1"/></td>
  </tr>
</table>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<div hidden="hidden" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
<input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
<input type="hidden" name="txtforsearch" id="txtforsearch" value='<s:property value="txtforsearch"/>'/>
<input type="hidden" id="txtvalidation" name="txtvalidation"  value='<s:property value="txtvalidation"/>'/>
<input type="hidden" id="taxaccount" name="taxaccount"  value='<s:property value="taxaccount"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
</div>
</form>
<div id="debitNoteGridWindow">
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
