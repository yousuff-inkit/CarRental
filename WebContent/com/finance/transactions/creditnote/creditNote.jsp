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

<%
	String mod = request.getParameter("mod")==null?"":request.getParameter("mod").toString();   
	String acno = request.getParameter("acno")==null || request.getParameter("acno")==""?"0":request.getParameter("acno").toString();  
	String client = request.getParameter("client")==null?"":request.getParameter("client").toString();
	String cldocno = request.getParameter("cldocno")==null || request.getParameter("cldocno").equals("")?"0":request.getParameter("cldocno").toString();
	String account = request.getParameter("account")==null?"":request.getParameter("account").toString(); 
	String atype = request.getParameter("atype")==null?"":request.getParameter("atype").toString();  
	String amount = request.getParameter("amount")==null || request.getParameter("amount").equals("")?"0":request.getParameter("amount").toString();  
	String remarks = request.getParameter("remarks")==null?"":request.getParameter("remarks").toString();  
	String cnrdocno = request.getParameter("cnrdocno")==null || request.getParameter("cnrdocno").equals("")?"0":request.getParameter("cnrdocno").toString();  
%>
<script type="text/javascript">
    var mod1 = '<%=mod%>';
	$(document).ready(function() {
		 $("#jqxCreditNoteDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $('#txtforsearch').val(2);
		 
		 $('#accountDetailsToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsToWindow').jqxWindow('close');  
		 
		 $('#creditNoteGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#creditNoteGridWindow').jqxWindow('close'); 
		 
		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#costTypeSearchGridWindow').jqxWindow('close');
 		 
 		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
		 
		 $('#jqxCreditNoteDate').on('change', function (event) {
				var creditdate = $('#jqxCreditNoteDate').jqxDateTimeInput('getDate');
				var validdate=funDateInPeriod(creditdate);
				if(parseInt(validdate)==0){
					document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
					return 0;	
				} 
			 });
			 
		$('#txtaccid').dblclick(function(){
			  var date = $('#jqxCreditNoteDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtype').val()+"&date="+date);
			  $('#txtforsearch').val(2);
	    });
		
		if ($('#formdetail').val() === "" || $('#formdetail').val() === "null") {
	        // Attempt to set the form name statically if the Struts tag failed
	        $('#formdetail').val("Credit Note");
	    }
	    if ($('#formdetailcode').val() === "" || $('#formdetailcode').val() === "null") {
	        // Attempt to set the form code statically if the Struts tag failed
	        $('#formdetailcode').val("CNO");
	    }
	    
		getConfigs();
	});
	
	function getConfigs(){
		$.get('getConfigs.jsp',function(data){
			data=JSON.parse(data);
			$('#cnoapplyconfig').val(data.CNOApply);
			if(data.CNOApply=="1"){
				$('#cnoapplyfield').show();
				$('#jqxCreditNote').jqxGrid({height:150});
			}
			else{
				$('#cnoapplyfield').hide();
				$('#jqxCreditNote').jqxGrid({height:300});
			}
		});
	}
	
	function CreditSearchContent(url) {
		$('#creditNoteGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#creditNoteGridWindow').jqxWindow('setContent', data);
		$('#creditNoteGridWindow').jqxWindow('bringToFront');
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
				 $('#frmCreditNote select').attr('disabled', false);$("#jqxCreditNote").jqxGrid({ disabled: false});  
				 $('#cmbcurrency').attr('disabled',true);
				 $("#jqxApplyCreditNoteInvoicing").jqxGrid({ disabled: false});
			}
		   });
	  }
	  
	 function funReadOnly(){
			$('#frmCreditNote input').attr('readonly', true );
			$('#frmCreditNote select').attr('disabled', true);
			$('#jqxCreditNoteDate').jqxDateTimeInput({disabled: true});
			$("#jqxCreditNote").jqxGrid({ disabled: true});
			$("#btnvaluechange").hide();
			
			if(mod1=="A") {
			    document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
				document.getElementById("formdetail").value=window.parent.formName.value;
				document.getElementById("formdetailcode").value=window.parent.formCode.value.trim(); 
				funCreateBtn();  
			}
	 }
	 function funRemoveReadOnly(){
		    $('#txtforsearch').val(2);
			$('#frmCreditNote input').attr('readonly', false );
			$('#frmCreditNote select').attr('disabled', false);
			$('#cmbcurrency').attr('disabled', true);
			$('#txtaccid').attr('readonly', true );
			$('#txtaccname').attr('readonly', true );
			$('#txtnettotal').attr('readonly', true );
		    $('#txtbaseamount').attr('readonly', true);
			$('#jqxCreditNoteDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$("#jqxCreditNote").jqxGrid({ disabled: false}); 
			
			var date = $('#jqxCreditNoteDate').val();
		    getCurrencyId(date);
		    
		   if ($("#mode").val() == "E") {
      	    $("#btnvaluechange").show();
      	    $('#frmCreditNote input').attr('readonly', true );
			    $('#frmCreditNote select').attr('disabled', true);
			    $("#jqxCreditNote").jqxGrid({ disabled: true});
			    $("#jqxCreditNote").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","dr": true,"amount1": "","description": ""});
			    $('#txtdescription').attr('readonly', false );
			    $('#txtrefno').attr('readonly', false );
			  }
			 else{
				$("#btnvaluechange").hide();
			} 
			
			if ($("#mode").val() == "A") {
				$('#jqxCreditNoteDate').val(new Date());
				$("#jqxCreditNote").jqxGrid('clear'); 
				$("#jqxCreditNote").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","dr": true,"amount1": "","description": ""});
			} 
			
			if (mod1 == "A") { 
				 document.getElementById("cnrdocno").value='<%=cnrdocno%>'; 
				 document.getElementById("txtaccid").value='<%=account%>';
				 document.getElementById("txtaccname").value='<%=client%>';  
			     document.getElementById("txtdocno").value='<%=acno%>';
		         document.getElementById("cmbtype").value='<%=atype%>';  
		         document.getElementById("hidcmbtype").value='<%=atype%>';  
		         document.getElementById("txtapplyinvoiceamt").value='<%=amount%>';  
		         document.getElementById("txtcrtotal").value='<%=amount%>';  
		         document.getElementById("txtamount").value='<%=amount%>';  
		         document.getElementById("txtbaseamount").value='<%=amount%>';  
		         document.getElementById("txtdescription").value='<%=remarks%>'; 
		         $("#txtaccid, #txtaccname,#txtdocno, #txtcrtotal,#txtamount").prop("readonly", true);

		     }
	      }
	 
			function funSearchLoad(){
				changeContent('cnoMainSearch.jsp'); 
			 }
				
			 function funChkButton(){
					/* funReset(); */
				}
			 
			 function funFocus(){
			    	$('#jqxCreditNoteDate').jqxDateTimeInput('focus'); 	    		
			    }
			 
			   $(function(){
			        $('#frmCreditNote').validate({
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
				    $('#jqxCreditNoteDate').jqxDateTimeInput({ disabled: false });
				    /* Validation */
				    var creditdate = $('#jqxCreditNoteDate').jqxDateTimeInput('getDate');
					var validdate=funDateInPeriod(creditdate);
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
			    		
			     /* Credit-Note Grid  Saving*/
				  var rows = $("#jqxCreditNote").jqxGrid('getrows');
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
							
							var amount,baseamount;
							if(rows[i].dr==true){
								 amount=rows[i].amount1;
								 baseamount=rows[i].baseamount1;
							}
							else if(rows[i].dr==false){
								 amount=rows[i].amount1*-1;
								 baseamount=rows[i].baseamount1*-1;
							}
							
						newTextBox.val(rows[i].docno+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+rows[i].dr+"::"+amount+"::"+rows[i].description+"::"+baseamount+":: "+rows[i].costtype+":: "+rows[i].costcode);
						newTextBox.appendTo('form');
						}
						}
					 if(val==1){
						 document.getElementById("errormsg").innerText= "Rate is Mandatory.";
						 return 0;
					 }
					 
					 /* Applying Invoice Grid Saving */
			  	 	rows = $("#jqxApplyCreditNoteInvoicing").jqxGrid('getrows');
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
			  				newTextBox.val(rows[i].applying+"::"+parseFloat((rows[i].out_amount+rows[i].applying)*-1)+"::"+rows[i].currency+"::"+rows[i].tranid+"::"+rows[i].acno);
			  				newTextBox.appendTo('form');
			  			}
			  		}
			  		$('#applylength').val(lengthapply);
					
			  		rows = $("#jqxApplyCreditNoteInvoicing").jqxGrid('getrows');
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
					 
					    $('#gridlength').val(length);
			 		   /* Credit-Note Grid  Saving Ends*/
			 		   
			 		   if ($("#mode").val() == "E") {
			             $('#frmCreditNote select').attr('disabled', false); 
			           }
			 		   $('#cmbcurrency').attr('disabled', false);
			 		  
				  return 1;
			  }
			  
			  $('#txtforsearch').val(2);
			    // ... (rest of the existing document.ready code) ...
			    
			    // -------------------------------------------------------------------
			    // START: HEADING FIX - Ensures hidden fields have form name/code on load
			    // -------------------------------------------------------------------
			    if ($('#formdetail').val() === "" || $('#formdetail').val() === "null") {
			        // Attempt to set the form name statically if the Struts tag failed
			        $('#formdetail').val("Credit Note");
			    }
			    if ($('#formdetailcode').val() === "" || $('#formdetailcode').val() === "null") {
			        // Attempt to set the form code statically if the Struts tag failed
			        $('#formdetailcode').val("CNO");
			    }
			    // -------------------------------------------------------------------
			    // END: HEADING FIX
			    // -------------------------------------------------------------------
			});

			function setValues(){
			    // ... (existing setValues function content) ...
			    
			    // The key line that uses the hidden fields (now guaranteed to have a value):
			    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
			    
			    // ... (rest of setValues function content) ...
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

			    function getCrTotal(){
			    	  var fromamount = $('#txtbaseamount').val();
			 		  if(!isNaN(fromamount)){
			 			  
			 			    var dr=0.0,cr=0.0,cr1=0.0;
			         	    var rows = $('#jqxCreditNote').jqxGrid('getrows');
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
			 			  $('#txtamount').val(0.00);
				 		  $('#txtcrtotal').val(0.00);
				 		  $('#txtdrtotal').val(0.00);
			 		  }
			 	  } 
			       
			       function getAccType(event){
			           var x= event.keyCode;
			           if(x==114){
			        	  var date = $('#jqxCreditNoteDate').jqxDateTimeInput('getDate');
			 			  $("#maindate").jqxDateTimeInput('val', date);
			 			  accountSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtype').val()+"&date="+date);
			         	  $('#txtforsearch').val(2);
			           }
			           else{
			            }
			           }
			       
			       function funPrintBtn() {
						
						if (($("#mode").val() == "view") && $("#docno").val()!="") {
					        var url=document.URL;
					        var reurl=url.split("saveCreditNote");
					        $("#docno").prop("disabled", false);  
					     
					        $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
								if (r){
									 var win= window.open(reurl[0]+"printCreditNote?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
								     win.focus();
								 }
								else{
									var win= window.open(reurl[0]+"printCreditNote?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
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
			 		  var date = $('#jqxCreditNoteDate').jqxDateTimeInput('getDate');
					  var validdate=funDateInPeriod(date);
					  if(parseInt(validdate)==0){
						document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
						return 0;	
					  } 
			 		  $("#maindate").jqxDateTimeInput('val', date);
			 	  }
	function setApplyAmount(){
		var amount = $('#txtamount').val();
		if(!isNaN(amount)){
			funRoundAmt(amount,"txtapplyinvoiceamt");
		}
		else if(isNaN(amount)){
			$('#txtapplyinvoiceamt').val(0.00);
			$('#txtamount').val(0.00);
		}
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

<form id="frmCreditNote" action="saveCreditNote" method="post" autocomplete="off">

    <jsp:include page="../../../../header.jsp"></jsp:include>

    <!-- ======================================================
         CREDIT NOTE — MAIN SECTION BLOCK
    ======================================================= -->
    <div class="section-block">

        <!-- ============================
             ROW 1 → Date | Ref No | Doc No
        ============================= -->
        <div class="form-group">
            <label>Date</label>
            <div style="flex:1;">
                <div id="jqxCreditNoteDate"
                     name="jqxCreditNoteDate"
                     onchange="datechange();" onblur="datechange();"
                     value='<s:property value="jqxCreditNoteDate"/>'>
                </div>

                <input type="hidden" id="hidjqxCreditNoteDate"
                       name="hidjqxCreditNoteDate"
                       value='<s:property value="hidjqxCreditNoteDate"/>' />
            </div>

            <label>Ref. No.</label>
            <input type="text" id="txtrefno" name="txtrefno"
                   value='<s:property value="txtrefno"/>' />

            <label>Doc No.</label>
            <input type="text" id="docno" name="txtcreditnotedocno"
                   tabindex="-1"
                   value='<s:property value="txtcreditnotedocno"/>' />
        </div>

        <!-- ============================
             ROW 2 → Type | Account ID | Account Name
        ============================= -->
        <div class="form-group">
            <label>Type</label>
            <select id="cmbtype" name="cmbtype"
                    onchange="clearClientInfo();">
                <option value="AP">AP</option>
                <option value="AR">AR</option>
            </select>
            <input type="hidden" id="hidcmbtype" name="hidcmbtype"
                   value='<s:property value="hidcmbtype"/>' />

            <label>Account ID</label>
            <input type="text" id="txtaccid" name="txtaccid"
            		style="margin-left:-15px;"
                   placeholder="Press F3 to Search"
                   value='<s:property value="txtaccid"/>'
                   onkeydown="getAccType(event);" />

            <label>Account Name</label>
            <input type="text" id="txtaccname" name="txtaccname"
            		style="margin-left:-10px;"
                   value='<s:property value="txtaccname"/>' tabindex="-1" />

            <input type="hidden" id="txtdocno" name="txtdocno"
                   value='<s:property value="txtdocno"/>' />
            <input type="hidden" id="txttrno" name="txttrno"
                   value='<s:property value="txttrno"/>' />
        </div>

        <!-- ============================
             ROW 3 → Currency | Rate | Amount
        ============================= -->
        <div class="form-group">
            <label>Currency</label>
            <select id="cmbcurrency" name="cmbcurrency"
                    onchange="getRatevalue(this.value,$('#jqxCreditNoteDate').val());">
                <option></option>
            </select>

            <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency"
                   value='<s:property value="hidcmbcurrency"/>' />
            <input type="hidden" id="hidcurrencytype" name="hidcurrencytype"
                   value='<s:property value="hidcurrencytype"/>' />

            <label>Rate</label>
            <input type="text" id="txtrate" name="txtrate"
            		style="margin-left:-19px;"
                   value='<s:property value="txtrate"/>'
                   onchange="funvalid();"
                   onblur="funRoundRate(this.value,this.id);getBaseAmountFrom();getCrTotal();" />

            <label>Amount</label>
            <input type="text" id="txtamount" name="txtamount"
                   value='<s:property value="txtamount"/>'
                   onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getCrTotal();setApplyAmount();" />
        </div>

        <!-- ============================
             ROW 4 → Base Amount | Description (spans 2 columns)
        ============================= -->
        <div class="form-group">
            <label>Base Amount</label>
            <input type="text" id="txtbaseamount" name="txtbaseamount"
                   value='<s:property value="txtbaseamount"/>' tabindex="-1" />

            <label>Description</label>
            <input type="text" id="txtdescription" name="txtdescription"
                   style="flex:2;"
                   value='<s:property value="txtdescription"/>' />
        </div>

    </div> <!-- /section-block -->


    <!-- ======================================================
         GRID + TOTALS SECTION
    ======================================================= -->
    <div class="section-block">

        <div id="jqxCreditNoteGrid">
            <jsp:include page="creditNoteGrid.jsp"></jsp:include>
        </div>

        <br>

        <div class="form-group">
            <label>Dr. Total</label>
            <input type="text" id="txtdrtotal" name="txtdrtotal"
                   value='<s:property value="txtdrtotal"/>' tabindex="-1">

            <label>Cr. Total</label>
            <input type="text" id="txtcrtotal" name="txtcrtotal"
                   value='<s:property value="txtcrtotal"/>' tabindex="-1">
        </div>

    </div>

    <!-- ======================================================
         APPLY INVOICES SECTION
    ======================================================= -->
    <div class="section-block">
        <h2>Apply Invoices</h2>

        <div id="jqxApplyInvoicing1">
            <center><jsp:include page="applyCreditNoteInvoicingGrid.jsp"></jsp:include></center>
        </div>

        <div class="form-group">
            <label>Amount</label>
            <input type="text" id="txtapplyinvoiceamt" name="txtapplyinvoiceamt"
                   value='<s:property value="txtapplyinvoiceamt"/>' />

            <label>Applied</label>
            <input type="text" id="txtapplyinvoiceapply" name="txtapplyinvoiceapply"
                   value='<s:property value="txtapplyinvoiceapply"/>' tabindex="-1" />

            <label>Balance</label>
            <input type="text" id="txtapplyinvoicebalance" name="txtapplyinvoicebalance"
                   value='<s:property value="txtapplyinvoicebalance"/>' tabindex="-1" />
        </div>
    </div>

    <!-- ======================================================
         HIDDEN FIELDS
    ======================================================= -->
    <input type="hidden" id="mode" name="mode">
    <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'>
    <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>

</form>
</div>

</body>


</html>