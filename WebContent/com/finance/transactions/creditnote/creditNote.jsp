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
/* =========================================================
SCOPED UI: Modern Layout (Matches Client Master)
========================================================= */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 5px 15px;
    box-sizing: border-box;
    width: 100%;
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
.modern-ui input:disabled,
.modern-ui select:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

/* Layout Utilities */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Middle Section Panels - No Clipped Headings */
.modern-ui .middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 20px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
    margin-top: 12px; 
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -12px; 
    left: 10px; 
    background: #ffffff; 
    padding: 0 8px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 14px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
}

/* Custom UI Buttons matching 24px height */
.modern-ui .myButton {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 16px;
    font-family: Arial, sans-serif;
    font-size: 11px;
    font-weight: bold;
    border-radius: 3px;
    cursor: pointer;
    text-shadow: none;
    transition: all 0.2s;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    border: none;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    white-space: nowrap;
}
.modern-ui .myButton:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

/* Search Icon Wrapper */
.modern-ui .input-search-container {
    position: relative;
    display: flex;
}
.modern-ui .input-search-container input {
    padding-right: 25px !important;
}
.modern-ui .magnifier-icon {
    position: absolute;
    right: 6px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
.modern-ui .magnifier-icon:hover { color: #2563eb; }

/* Grid Wrapper */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

/* Validation Label */
.modern-ui .val-error { color: red; font-size: 11px; font-weight:bold; }

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 150px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }
</style>

<script type="text/javascript">
    var mod1 = '<%=mod%>';
	$(document).ready(function() {
		
         /* COMPACT DATE SIZING */
		 $("#jqxCreditNoteDate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
		 $("#maindate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
		
         /* Force internal alignment AFTER render */
         setTimeout(function () {
             $(".jqx-datetimeinput").find("input").css({
                 "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
                 "font-family": "Arial, sans-serif", "padding": "0 6px", "box-sizing":"border-box"
             });
             $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
         }, 0);

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

<div id="mainBG" class="homeContent hidden-scrollbar" data-type="background">

<form id="frmCreditNote" action="saveCreditNote" method="post" autocomplete="off">
    <jsp:include page="../../../../header.jsp"></jsp:include>

    <div class="modern-ui">

        <div class="middle-panel">
            <span class="middle-panel-title">General Info</span>
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px;">Date</label>
                <div style="width: 125px;">
                    <div id="jqxCreditNoteDate" name="jqxCreditNoteDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxCreditNoteDate"/>'></div>
                    <input type="hidden" id="hidjqxCreditNoteDate" name="hidjqxCreditNoteDate" value='<s:property value="hidjqxCreditNoteDate"/>'/>
                </div>
                
                <label class="lbl-right" style="width:80px;">Ref. No.</label>
                <input type="text" id="txtrefno" name="txtrefno" value='<s:property value="txtrefno"/>' style="width:120px;" />
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No.</label>
                <div style="display:flex; gap:10px;">
                    <input type="text" id="docno" name="txtcreditnotedocno" value='<s:property value="txtcreditnotedocno"/>' tabindex="-1" style="width:120px;" readonly />
                    <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button>
                </div>
            </div>
        </div>

        <div style="display: flex; gap: 15px; margin-bottom: 15px;">
            <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
                <span class="middle-panel-title">Account Details</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Type</label>
                    <select id="cmbtype" name="cmbtype" onchange="clearClientInfo();" value='<s:property value="cmbtype"/>' style="width:80px;">
                        <option value="AP">AP</option>
                        <option value="AR">AR</option>
                    </select>
                    <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/>
                </div>
                
                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:80px;">Account</label>
                    <div class="input-search-container" style="width: 120px;">
                        <input type="text" id="txtaccid" name="txtaccid" placeholder="Press F3" value='<s:property value="txtaccid"/>' onkeydown="getAccType(event);"/>
                        <svg class="magnifier-icon" onclick="var d=$('#jqxCreditNoteDate').jqxDateTimeInput('getDate'); $('#maindate').jqxDateTimeInput('val', d); accountSearchContent('<%=contextPath%>/com/finance/clientAccountDetailsSearch.jsp?atype='+$('#cmbtype').val()+'&date='+d); $('#txtforsearch').val(2);" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <input type="text" id="txtaccname" name="txtaccname" value='<s:property value="txtaccname"/>' style="flex:1;" tabindex="-1" readonly/>
                    <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
                    <input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
                </div>
            </div>

            <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
                <span class="middle-panel-title">Transaction Details</span>
                
                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Currency</label>
                    <select id="cmbcurrency" name="cmbcurrency" style="width:120px;" value='<s:property value="cmbcurrency"/>' onload="getRatevalue(this.value,$('#jqxCreditNoteDate').val());" onchange="getRatevalue(this.value,$('#jqxCreditNoteDate').val());">
                        <option></option>
                    </select>
                    <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency" value='<s:property value="hidcmbcurrency"/>'/>
                    <input type="hidden" id="hidcurrencytype" name="hidcurrencytype" value='<s:property value="hidcurrencytype"/>'/>

                    <label class="lbl-right" style="width:80px; margin-left:auto;">Rate</label>
                    <input type="text" id="txtrate" name="txtrate" onchange="funvalid()" style="width:120px; text-align:right;" value='<s:property value="txtrate"/>' onblur="funRoundRate(this.value,this.id);getBaseAmountFrom();getCrTotal();" tabindex="-1" />
                    <span id="validrate" class="val-error" style="width:100%; text-align:right;"></span>
                </div>

                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Amount</label>
                    <input type="text" id="txtamount" name="txtamount" style="width:120px; text-align:right;" value='<s:property value="txtamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getCrTotal();setApplyAmount();" />
                    
                    <label class="lbl-right" style="width:80px; margin-left:auto;">Base Amount</label>
                    <input type="text" id="txtbaseamount" name="txtbaseamount" style="width:120px; text-align:right;" value='<s:property value="txtbaseamount"/>' tabindex="-1" readonly/>
                </div>

                <div class="field-row" style="margin-bottom:0;">
                    <label class="lbl-right" style="width:80px;">Description</label>
                    <input type="text" id="txtdescription" name="txtdescription" value='<s:property value="txtdescription"/>' style="flex:1;" />
                </div>
            </div>
        </div>

        <div class="middle-panel">
            <span class="middle-panel-title">Credit Note Details</span>
            <div class="grid-container" id="jqxCreditNoteGrid">
                <jsp:include page="creditNoteGrid.jsp"></jsp:include>
            </div>
            
            <div class="field-row" style="margin-top: 15px; justify-content: flex-end; margin-bottom: 0;">
                <label class="lbl-right">Dr. Total</label>
                <input type="text" id="txtdrtotal" name="txtdrtotal" style="width:100px; text-align:right;" value='<s:property value="txtdrtotal"/>' tabindex="-1" readonly/>
                
                <label class="lbl-right" style="margin-left:15px;">Cr. Total</label>
                <input type="text" id="txtcrtotal" name="txtcrtotal" style="width:100px; text-align:right;" value='<s:property value="txtcrtotal"/>' tabindex="-1" readonly/>
            </div>
        </div>

        <div class="middle-panel">
            <span class="middle-panel-title">Apply Invoices</span>
            <div class="grid-container" id="jqxApplyInvoicing1">
                <jsp:include page="applyCreditNoteInvoicingGrid.jsp"></jsp:include>
            </div> 
            
            <div class="field-row" style="margin-top: 15px; justify-content: flex-end; margin-bottom: 0;">
                <label class="lbl-right" style="width:60px;">Amount</label>
                <input type="text" id="txtapplyinvoiceamt" name="txtapplyinvoiceamt" style="width:100px; text-align:right;" value='<s:property value="txtapplyinvoiceamt"/>' readonly/>
                <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
                
                <label class="lbl-right" style="width:60px; margin-left:15px;">Applied</label>
                <input type="text" id="txtapplyinvoiceapply" name="txtapplyinvoiceapply" style="width:100px; text-align:right;" value='<s:property value="txtapplyinvoiceapply"/>' tabindex="-1" readonly/>
                
                <label class="lbl-right" style="width:60px; margin-left:15px;">Balance</label>
                <input type="text" id="txtapplyinvoicebalance" name="txtapplyinvoicebalance" style="width:100px; text-align:right;" value='<s:property value="txtapplyinvoicebalance"/>' tabindex="-1" readonly/>
            </div>
        </div>

        <div style="display:none;">
            <input type="hidden" id="mode" name="mode"/>
            <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            <input type="hidden" name="txtforsearch" id="txtforsearch" value='<s:property value="txtforsearch"/>'/>
            <div id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
            <input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
            <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
            <input type="hidden" id="gridlength" name="gridlength"/>
            <input type="hidden" id="applylength" name="applylength"/>
            <input type="hidden" id="applylengthupdate" name="applylengthupdate"/>
            <input type="hidden" id="cnoapplyconfig" name="cnoapplyconfig"/>
            <input type="hidden" id="cnrdocno" name="cnrdocno" value='<s:property value="cnrdocno"/>'/>
        </div>

    </div>
</form>

<div id="creditNoteGridWindow"><div></div><div></div></div>  
<div id="accountDetailsToWindow"><div></div><div></div></div>  
<div id="costTypeSearchGridWindow"><div></div><div></div></div> 
<div id="costCodeSearchWindow"><div></div><div></div></div> 

</div>
</body>
</html>