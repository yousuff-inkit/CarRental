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

<style>
    
    body {
        background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
        color: #222;
        margin: 0;
        padding: 32px 0;
        min-height: 100vh;
        box-sizing: border-box;
    }

    #mainBG {
        background: #fff;
        border-radius: 16px;
        padding: 20px;
        max-width: 100%;
        margin: auto;
        box-shadow: 0 4px 24px rgba(0,0,0,0.06);
        text-align: left !important; 
    }

    
    center {
        text-align: left !important;
        display: block;
        width: 100%;
        margin-left: 0;
    }
    
    #formdet {
        font-size: 24px !important;
        font-weight: 700 !important;
        color: #2c3e50;
        margin-bottom: 15px;
        display: block;
        text-align: left !important;
        font-family: 'Segoe UI', sans-serif;
    }


    .receipt-header {
        display: grid;
        grid-template-columns: 100px 120px auto 150px auto 150px;
        gap: 15px;
        align-items: center;
        margin-bottom: 20px;
        margin-top: 20px;
        padding: 0 0 0 5px; 
    }

    .form-group {
        display: grid;
        grid-template-columns: 120px 1fr;
        align-items: center;
        gap: 12px;
        margin-bottom: 12px;
    }

    .form-group.dual-input {
        grid-template-columns: 120px 1fr 120px 1fr;
    }

    .form-group.single-label-dual-input {
        grid-template-columns: 120px 1fr 1fr;
    }
    
    .form-group.triple-input {
        grid-template-columns: 80px 1fr 80px 1fr 80px 1fr;
    }

    .section-row {
        display: flex;
        gap: 26px;
        margin-bottom: 30px;
    }

    .section-block {
        flex: 1;
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
        color: #333;
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
    
    input[readonly] {
        background-color: #f3f4f6;
        color: #6b7280;
    }

    label {
        font-weight: 600;
        color: #253858;
        white-space: nowrap;
        text-align: right;
        padding-right: 10px;
        font-size: 14px;
    }

 
    .table-section { margin: 20px 0; }
    .table-section h3 {
        color: #253858; font-size: 1.05rem; font-weight: 600; margin-bottom: 12px;
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
    

    .doc-group { display: flex; gap: 5px; }
    .hidden-scrollbar { overflow: auto; height: 100vh; }
    .hidden-scrollbar::-webkit-scrollbar { width: 0px; }
    #validrate { color: red; font-size: 12px; }
</style>

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
			  
			  function setValues(){
				  $('#jqxCreditNoteDate').jqxDateTimeInput({disabled: false});
				  var date = $('#jqxCreditNoteDate').val();
				  getCurrencyId(date);
				  $('#jqxCreditNoteDate').jqxDateTimeInput({disabled: true});
				  
				  document.getElementById("cmbtype").value=document.getElementById("hidcmbtype").value;
				  document.getElementById("cmbcurrency").value=document.getElementById("hidcmbcurrency").value;
				  
				  if($('#hidjqxCreditNoteDate').val()){
						 $("#jqxCreditNoteDate").jqxDateTimeInput('val', $('#hidjqxCreditNoteDate').val());
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
			             $("#jqxCreditNoteGrid").load("creditNoteGrid.jsp?txtcreditnotedocno2="+indexVal+"&check="+check);
				         var indexVal2 = document.getElementById("txttrno").value;
				         var indexVal3=document.getElementById("txtdocno").value;
				         $("#jqxApplyInvoicing1").load("applyCreditNoteInvoicingGrid.jsp?txttoaccid1="+indexVal3+"&txttotrno1="+indexVal2+"&check="+check); 
				         

					 }
					 getBankReconciled($("#docno").val(), "CNO");
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

			    	    if ($("#mode").val() !== "view" || $("#docno").val() === "") {
			    	        $.messager.alert('Message','Select a Document....!','warning');
			    	        return;
			    	    }

			    	    var baseUrl = document.URL.split("saveCreditNote")[0];

			    	    $.messager.confirm('Confirm', 'Do you want to have header?', function (r) {

			    	        var printUrl =
			    	            baseUrl +
			    	            "printCreditNote" +
			    	            "?docno=" + $("#docno").val() +
			    	            "&branch=" + $("#brchName").val() +
			    	            "&header=" + (r ? 1 : 0);

			    	        openAndPrint(printUrl);
			    	    });
			    	}

			       function openAndPrint(url) {
			    	    var win = window.open(
			    	        url,
			    	        "_blank",
			    	        "top=150,left=250,width=1020,height=600,scrollbars=yes"
			    	    );

			    	    if (win) {
			    	        setTimeout(function () {
			    	            win.focus();
			    	            win.print();
			    	            win.onafterprint = function () {
			    	                win.close();
			    	            };
			    	        }, 700);
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

</head>
<body onload="setValues();">
<div id="mainBG" class="hidden-scrollbar homeContent" data-type="background" >
<form id="frmCreditNote" action="saveCreditNote" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

    <div class='receipt-header'>
        <label>Date</label>
        <div>
            <div id="jqxCreditNoteDate" name="jqxCreditNoteDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxCreditNoteDate"/>'></div>
            <input type="hidden" id="hidjqxCreditNoteDate" name="hidjqxCreditNoteDate" value='<s:property value="hidjqxCreditNoteDate"/>'/>
        </div>

        <label>Ref. No.</label>
        <input type="text" id="txtrefno" name="txtrefno" value='<s:property value="txtrefno"/>'/>

        <label>Doc No.</label>
        <div class="doc-group">
            <input type="text" id="docno" name="txtcreditnotedocno" value='<s:property value="txtcreditnotedocno"/>' tabindex="-1"/>
            <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button>
        </div>
    </div>


    <div class="section-row">
        <div class="section-block">
            <h2>Account Details</h2>
            <div class="form-group">
                <label for="cmbtype">Type</label>
                <select id="cmbtype" name="cmbtype" onchange="clearClientInfo();" value='<s:property value="cmbtype"/>'>
                    <option value="AP">AP</option><option value="AR">AR</option>
                </select>
                <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/>
            </div>

            <div class="form-group single-label-dual-input">
                <label for="txtaccid">Account</label>
                <input type="text" id="txtaccid" name="txtaccid" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>' onkeydown="getAccType(event);"/>
                <input type="text" id="txtaccname" name="txtaccname" value='<s:property value="txtaccname"/>' tabindex="-1"/>
                <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
                <input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
            </div>
        </div>

        <div class="section-block">
            <h2>Transaction Details</h2>
            <div class="form-group dual-input">
                <label for="cmbcurrency">Currency</label>
                <select id="cmbcurrency" name="cmbcurrency" value='<s:property value="cmbcurrency"/>' onload="getRatevalue(this.value,$('#jqxCreditNoteDate').val());" onchange="getRatevalue(this.value,$('#jqxCreditNoteDate').val());">
                    <option></option>
                </select>
                <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency" value='<s:property value="hidcmbcurrency"/>'/>
                <input type="hidden" id="hidcurrencytype" name="hidcurrencytype" value='<s:property value="hidcurrencytype"/>'/>

                <label for="txtrate">Rate</label>
                <input type="text" id="txtrate" name="txtrate" onchange="funvalid()" value='<s:property value="txtrate"/>' onblur="funRoundRate(this.value,this.id);getBaseAmountFrom();getCrTotal();" tabindex="-1" />
                <span id="validrate"></span>
            </div>

            <div class="form-group dual-input">
                <label for="txtamount">Amount</label>
                <input type="text" id="txtamount" name="txtamount" value='<s:property value="txtamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getCrTotal();setApplyAmount();" />
                
                <label for="txtbaseamount">Base Amount</label>
                <input type="text" id="txtbaseamount" name="txtbaseamount" value='<s:property value="txtbaseamount"/>' tabindex="-1"/>
            </div>

            <div class="form-group">
                <label for="txtdescription">Description</label>
                <input type="text" id="txtdescription" name="txtdescription" value='<s:property value="txtdescription"/>'/>
            </div>
        </div>
    </div>

    <div class="table-section">
        <div id="jqxCreditNoteGrid"><jsp:include page="creditNoteGrid.jsp"></jsp:include></div><br/>
        
        <div class="form-group dual-input">
            <label>Dr. Total</label>
            <input type="text" id="txtdrtotal" name="txtdrtotal" value='<s:property value="txtdrtotal"/>' tabindex="-1"/>
            
            <label>Cr. Total</label>
            <input type="text" id="txtcrtotal" name="txtcrtotal" value='<s:property value="txtcrtotal"/>' tabindex="-1"/>
        </div>
    </div>

    <div class="table-section">
        <h3>Apply Invoices</h3>
        <div id="jqxApplyInvoicing1"><center><jsp:include page="applyCreditNoteInvoicingGrid.jsp"></jsp:include></center></div> 
        
        <div class="form-group triple-input" style="margin-top: 10px;">
            <label>Amount</label>
            <input type="text" id="txtapplyinvoiceamt" name="txtapplyinvoiceamt" value='<s:property value="txtapplyinvoiceamt"/>'/>
            <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
            
            <label>Applied</label>
            <input type="text" id="txtapplyinvoiceapply" name="txtapplyinvoiceapply" value='<s:property value="txtapplyinvoiceapply"/>' tabindex="-1"/>
            
            <label>Balance</label>
            <input type="text" id="txtapplyinvoicebalance" name="txtapplyinvoicebalance" value='<s:property value="txtapplyinvoicebalance"/>' tabindex="-1"/>
        </div>
    </div>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" name="txtforsearch" id="txtforsearch" value='<s:property value="txtforsearch"/>'/>
<div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
<input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
<input type="hidden" id="txtvalidation" name="txtvalidation"  value='<s:property value="txtvalidation"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
<input type="hidden" id="applylength" name="applylength"/>
<input type="hidden" id="applylengthupdate" name="applylengthupdate"/>
<input type="hidden" id="cnoapplyconfig" name="cnoapplyconfig"/>
<input type="hidden" id="cnrdocno" name="cnrdocno"  value='<s:property value="cnrdocno"/>'/>

</form>
</div>

<div id="creditNoteGridWindow">
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

</body>
</html>