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


<script type="text/javascript">
	$(document).ready(function() {
		 $("#jqxDebitNoteDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
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
		 if ($('#formdetail').val() === "" || $('#formdetail').val() === "null") {
				    $('#formdetail').val("Debit Note"); // Sets the visible form name
				}
				if ($('#formdetailcode').val() === "" || $('#formdetailcode').val() === "null") {
				    $('#formdetailcode').val("DNO"); // Sets the form code (used for title and functions)
				}
			 
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
				 $('#frmDebitNote select').attr('disabled', false);$("#jqxDebitNote").jqxGrid({ disabled: false});  
				 $('#cmbcurrency').attr('disabled',true);
				   }
		   });
	  }
	  
	 function funReadOnly(){
			$('#frmDebitNote input').attr('readonly', true );
			$('#frmDebitNote select').attr('disabled', true);
			$('#jqxDebitNoteDate').jqxDateTimeInput({disabled: true});
			$("#jqxDebitNote").jqxGrid({ disabled: true});
			$("#btnvaluechange").hide();
	 }
	 function funRemoveReadOnly(){
		    $('#txtforsearch').val(2);
			$('#frmDebitNote input').attr('readonly', false );
			$('#frmDebitNote select').attr('disabled', false);
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
      	        $('#frmDebitNote input').attr('readonly', true );
			    $('#frmDebitNote select').attr('disabled', true);
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
			        $('#frmDebitNote').validate({
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
						var chk=rows[i].rate;
						
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
								 amount=rows[i].amount1*-1;
								 baseamount=rows[i].baseamount1*-1;
							}
							else if(rows[i].dr==false){
								 amount=rows[i].amount1;
								 baseamount=rows[i].baseamount1;
							}
							
						newTextBox.val(rows[i].docno+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+rows[i].dr+"::"+amount+"::"+rows[i].description+"::"+baseamount+":: "+rows[i].costtype+":: "+rows[i].costcode);
						newTextBox.appendTo('form');
						}
						}
					 if(val==1){
						 document.getElementById("errormsg").innerText= "Rate is Mandatory.";
						 return 0;
					 } 
					    $('#gridlength').val(length);
			 		   /* Debit-Note Grid  Saving Ends*/	
			 		   
			 		   if ($("#mode").val() == "E") {
			             $('#frmDebitNote select').attr('disabled', false); 
			           }
			 		  $('#cmbcurrency').attr('disabled', false);
					 
				  return 1;
			  }
			  
			  function setValues(){
				  $('#jqxDebitNoteDate').jqxDateTimeInput({disabled: false});
				  var date = $('#jqxDebitNoteDate').val();
				  getCurrencyId(date);
				  $('#jqxDebitNoteDate').jqxDateTimeInput({disabled: true});
				  
				  document.getElementById("cmbtype").value=document.getElementById("hidcmbtype").value;
				  document.getElementById("cmbcurrency").value=document.getElementById("hidcmbcurrency").value;
				  if ($('#formdetail').val() === "" || $('#formdetail').val() === "null") {
				        $('#formdetail').val("Debit Note");
				    }
				    if ($('#formdetailcode').val() === "" || $('#formdetailcode').val() === "null") {
				        $('#formdetailcode').val("DNO");
				    }
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
					 getBankReconciled($("#docno").val(), "DNO");
					 
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
					        var reurl=url.split("saveDebitNote");
					        $("#docno").prop("disabled", false);  
					     
					        $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
								if (r){
									 var win= window.open(reurl[0]+"printDebitNote?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
								     win.focus();
								 }
								else{
									var win= window.open(reurl[0]+"printDebitNote?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
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

<form id="frmDebitNote" action="saveDebitNote" method="post" autocomplete="off">

<input type="hidden" id="formdetail" name="formdetail"
       value='<s:property value="formdetail"/>' />

<input type="hidden" id="formdetailcode" name="formdetailcode"
       value='<s:property value="formdetailcode"/>' />

<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
<input type="hidden" id="hidstatus" name="hidstatus" value='<s:property value="status"/>'/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>

<jsp:include page="../../../../header.jsp"></jsp:include>


<!-- ============================== MAIN SECTION ============================== -->
<div class="section-block">

    <!-- ====================== ROW 1: Date | Ref No | Doc No ====================== -->
    <div class="form-group">

        <label>Date</label>
        <div style="flex:1;">
            <div id="jqxDebitNoteDate"
                 name="jqxDebitNoteDate"
                 onchange="datechange();" onblur="datechange();"
                 value='<s:property value="jqxDebitNoteDate"/>'>
            </div>

            <input type="hidden" id="hidjqxDebitNoteDate"
                   name="hidjqxDebitNoteDate"
                   value='<s:property value="hidjqxDebitNoteDate"/>' />
        </div>

        <label>Ref. No.</label>
        <input type="text" id="txtrefno" name="txtrefno"
               value='<s:property value="txtrefno"/>' />

        <label>Doc No.</label>
        <input type="text" id="docno" name="txtdebitnotedocno"
               value='<s:property value="txtdebitnotedocno"/>' tabindex="-1" />
    </div>


    <!-- ================== ROW 2: Type | Account ID | Account Name ================== -->
    <div class="form-group">

        <label>Type</label>
        <select id="cmbtype" name="cmbtype"
                onchange="clearClientInfo();">
            <option value="AP">AP</option>
            <option value="AR">AR</option>
            <option value="HR">HR</option>
        </select>
        <input type="hidden" id="hidcmbtype" name="hidcmbtype"
               value='<s:property value="hidcmbtype"/>' />

        <label>Account ID</label>
        <input type="text" id="txtaccid" name="txtaccid"
               placeholder="Press F3 to Search"
               value='<s:property value="txtaccid"/>'
               onkeydown="getAccType(event);" />

        <label>Account Name</label>
        <input type="text" id="txtaccname" name="txtaccname"
               value='<s:property value="txtaccname"/>' tabindex="-1" />

        <input type="hidden" id="txtdocno" name="txtdocno"
               value='<s:property value="txtdocno"/>' />
        <input type="hidden" id="txttrno" name="txttrno"
               value='<s:property value="txttrno"/>' />
    </div>


    <!-- ================= ROW 3: Currency | Rate | Amount ================= -->
    <div class="form-group">

        <label>Currency</label>
        <select id="cmbcurrency" name="cmbcurrency"
                onchange="getRatevalue(this.value,$('#jqxDebitNoteDate').val());">
            <option></option>
        </select>

        <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency"
               value='<s:property value="hidcmbcurrency"/>' />
        <input type="hidden" id="hidcurrencytype" name="hidcurrencytype"
               value='<s:property value="hidcurrencytype"/>' />

        <label>Rate</label>
        <input type="text" id="txtrate" name="txtrate"
               value='<s:property value="txtrate"/>'
               onchange="funvalid();"
               onblur="funRoundRate(this.value,this.id);getBaseAmountFrom();getDrTotal();" />

        <label>Amount</label>
        <input type="text" id="txtamount" name="txtamount"
               value='<s:property value="txtamount"/>'
               onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getDrTotal();" />
    </div>


    <!-- ================= ROW 4: Base Amount | Description ================= -->
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

			<!-- GRID + TOTALS remain unchanged -->
			<div id="jqxDebitNoteGrid">
				<jsp:include page="debitNoteGrid.jsp"></jsp:include>
			</div>
			<br />

			<!-- ============================== GRID SECTION ============================== -->
<div class="section-block">

    <div id="jqxDebitNoteGrid">
        <jsp:include page="debitNoteGrid.jsp"></jsp:include>
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

</form>
</div>

</body>

</html>