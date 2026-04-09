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

#validrate { color: red; font-size: 11px; font-weight: bold; }

.hidden-scrollbar { 
    overflow: auto; 
    height: calc(100vh - 100px);
}
.hidden-scrollbar::-webkit-scrollbar { width: 0px; }
</style>

<script type="text/javascript">
	$(document).ready(function() {
		 /* FIXED DATE WIDTHS & HEIGHTS */ 
		 $("#jqxDebitNoteDate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
		 
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
				 $('#frmTaxCreditNote select').attr('disabled', false);
				 if($("#jqxDebitNote").length) $("#jqxDebitNote").jqxGrid({ disabled: false}); 
				 $('#frmTaxDebitNote select').attr('disabled', false);   
				 $('#cmbcurrency').attr('disabled',true);
		    }
		   });
	  }
	  
	/* SAFE READONLY FUNCTION */
	 function funReadOnly(){
	     try {
			$('#frmTaxDebitNote input').attr('readonly', true );
			$('#frmTaxDebitNote select').attr('disabled', true);
			$('#jqxDebitNoteDate').jqxDateTimeInput({disabled: true});
			if($("#jqxDebitNote").length) $("#jqxDebitNote").jqxGrid({ disabled: true});
			$("#btnvaluechange").hide();
	     } catch(e) { console.error("Error in funReadOnly: ", e); }
	 }

    /* SAFE REMOVE READONLY FUNCTION */
	 function funRemoveReadOnly(){
	     try {
		    $('#txtforsearch').val(2);
			$('#frmTaxDebitNote input').attr('readonly', false );
			$('#frmTaxDebitNote select').attr('disabled', false);
			$('#cmbcurrency').attr('disabled', true);
			
			$('#txtaccid').attr('readonly', true );
			$('#txtaccname').attr('readonly', true );
			if($('#txtnettotal').length) $('#txtnettotal').attr('readonly', true );
			$('#jqxDebitNoteDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			if($("#jqxDebitNote").length) $("#jqxDebitNote").jqxGrid({ disabled: false}); 
			
			var date = $('#jqxDebitNoteDate').val();
		    getCurrencyId(date);
		    
		   if ($("#mode").val() == "E") {
         	    $("#btnvaluechange").show();
         	    $('#frmTaxDebitNote input').attr('readonly', true );
			    $('#frmTaxDebitNote select').attr('disabled', true);   
			    if($("#jqxDebitNote").length) $("#jqxDebitNote").jqxGrid({ disabled: true});
			    $('#txtrefno').attr('readonly', false );
			    $('#txtdescription').attr('readonly', false );
			    if($("#jqxDebitNote").length) $("#jqxDebitNote").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","dr": true,"amount1": "","description": ""});
			  }
			 else{
				$("#btnvaluechange").hide();
			} 
			
			if ($("#mode").val() == "A") {
				$('#jqxDebitNoteDate').val(new Date());
				if($("#jqxDebitNote").length) {
				    $("#jqxDebitNote").jqxGrid('clear'); 
				    $("#jqxDebitNote").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","dr": true,"amount1": "","description": ""});
				}
			} 
	     } catch(e) { console.error("Error in funRemoveReadOnly: ", e); }
	   }
	
			function funSearchLoad(){
				changeContent('dnoMainSearch.jsp'); 
			 }
				
			 function funChkButton() { }
			 
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
					 
					accid=document.getElementById("docno").value;
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
			  
			/* SAFE SET VALUES FUNCTION */
			  function setValues(){
			      try {
    				  $('#jqxDebitNoteDate').jqxDateTimeInput({disabled: false});
    				  var date = $('#jqxDebitNoteDate').val();
    				  if(typeof getCurrencyId === 'function') getCurrencyId(date);
    				  $('#jqxDebitNoteDate').jqxDateTimeInput({disabled: true});
    				  
    				  if(document.getElementById("cmbtype") && document.getElementById("hidcmbtype")) {
    				      document.getElementById("cmbtype").value=document.getElementById("hidcmbtype").value;
    				  }
    				  if(document.getElementById("cmbcurrency") && document.getElementById("hidcmbcurrency")) {
    				      document.getElementById("cmbcurrency").value=document.getElementById("hidcmbcurrency").value;  
    				  }
    				  
    				  if($('#hidjqxDebitNoteDate').length && $('#hidjqxDebitNoteDate').val()){
    						 $("#jqxDebitNoteDate").jqxDateTimeInput('val', $('#hidjqxDebitNoteDate').val());
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
    				  if(indexVal>0 && $("#jqxDebitNoteGrid").length){
    						 var check = 1 ;
    			             $("#jqxDebitNoteGrid").load("debitNoteGrid.jsp?txtdebitnotedocno2="+indexVal+"&check="+check);
    				  }
    				  
    				  if(typeof funRoundRate === 'function') {
    					  funRoundRate($('#txtrate').val(),"txtrate");
    				  }
    				  if(typeof funRoundAmt === 'function') {
    				      funRoundAmt($('#txtamount').val(),"txtamount");
    				      funRoundAmt($('#txtbaseamount').val(),"txtbaseamount");
    					  funRoundAmt($('#txtdrtotal').val(),"txtdrtotal");
    					  funRoundAmt($('#txtcrtotal').val(),"txtcrtotal");
    				  }
			      } catch(e) { console.error("Error in setValues: ", e); }
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

			    	    if ($("#mode").val() !== "view" || $("#docno").val() === "") {
			    	        $.messager.alert('Message','Select a Document....!','warning');
			    	        return;
			    	    }

			    	    var baseUrl = document.URL.split("saveTaxDebitNote")[0];

			    	    $.messager.confirm('Confirm', 'Do you want to have header?', function (r) {

			    	        var printUrl =
			    	            baseUrl +
			    	            "printTaxDebitNote" +
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
			    	    } else {
			    	        $.messager.alert('Message','Popup blocked by browser','warning');
			    	    }
			    	}

	
			       function clearClientInfo(){
				 		  $("#docno").val('');$("#txtaccid").val('');$("#txtaccname").val('');
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
</head>

<body onload="setValues();">

<div id="mainBG" class="homeContent hidden-scrollbar" data-type="background" >
<form id="frmTaxDebitNote" action="saveTaxDebitNote" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class="modern-ui">

    <div class="erp-form-area">
        
        <table width="100%" border="0" cellspacing="0" cellpadding="2" style="margin-bottom: 8px;">
            <tr>
                <td class="lbl-right" width="8%">Date</td>
                <td width="15%">
                    <div id="jqxDebitNoteDate" name="jqxDebitNoteDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxDebitNoteDate"/>'></div>
                    <input type="hidden" id="hidjqxDebitNoteDate" name="hidjqxDebitNoteDate" value='<s:property value="hidjqxDebitNoteDate"/>'/>
                </td>
                <td class="lbl-right" width="8%">Ref. No.</td>
                <td width="15%">
                    <input type="text" id="txtrefno" name="txtrefno" value='<s:property value="txtrefno"/>'/>
                </td>
                <td class="lbl-right" width="8%">Doc No.</td>
                <td width="46%">
                    <div style="display: flex; gap: 8px; align-items: center;">
                        <input type="text" id="docno" name="txtdebitnotedocno" value='<s:property value="txtdebitnotedocno"/>' style="width: 150px;" tabindex="-1"/>
                        <button class="erp-btn-warning" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button>
                    </div>
                </td>
            </tr>

            <tr>
                <td class="lbl-right">Type</td>
                <td>
                    <select id="cmbtype" name="cmbtype" onchange="clearClientInfo();" value='<s:property value="cmbtype"/>'>
                        <option value="AR">AR</option>
                        <option value="GL">GL</option>
                        <option value="AP">AP</option>
                    </select>
                    <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/>
                </td>
                <td class="lbl-right">Account ID</td>
                <td>
                    <input type="text" id="txtaccid" name="txtaccid" placeholder="Press F3" value='<s:property value="txtaccid"/>' onkeydown="getAccType(event);" />
                </td>
                <td colspan="2">
                    <input type="text" id="txtaccname" name="txtaccname" value='<s:property value="txtaccname"/>' style="max-width: 400px;" tabindex="-1"/>
                    <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
                    <input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
                </td>
            </tr>

            <tr>
                <td class="lbl-right">Currency</td>
                <td>
                    <select id="cmbcurrency" name="cmbcurrency" value='<s:property value="cmbcurrency"/>' onchange="getRatevalue(this.value,$('#jqxDebitNoteDate').val());">
                        <option></option>
                    </select>
                    <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency" value='<s:property value="hidcmbcurrency"/>'/>
                    <input type="hidden" id="hidcurrencytype" name="hidcurrencytype" value='<s:property value="hidcurrencytype"/>'/>
                </td>
                <td class="lbl-right">Rate</td>
                <td colspan="3">
                    <input type="text" id="txtrate" name="txtrate" value='<s:property value="txtrate"/>' style="width: 100px;" onblur="funRoundRate(this.value,this.id); getBaseAmountFrom();getDrTotal();" tabindex="-1"/>
                    <span id="validrate"></span>
                </td>
            </tr>

            <tr>
                <td class="lbl-right">Amount</td>
                <td>
                    <input type="text" id="txtamount" name="txtamount" value='<s:property value="txtamount"/>' onblur="funRoundAmt(this.value,this.id); getBaseAmountFrom();getDrTotal();" />
                </td>
                <td class="lbl-right">Base Amount</td>
                <td colspan="3">
                    <input type="text" id="txtbaseamount" name="txtbaseamount" value='<s:property value="txtbaseamount"/>' style="width: 100px;" tabindex="-1"/>
                </td>
            </tr>

            <tr>
                <td class="lbl-right" style="padding-top: 10px;">Description</td>
                <td colspan="5" style="padding-top: 10px;">
                    <input type="text" id="txtdescription" name="txtdescription" value='<s:property value="txtdescription"/>' style="max-width: 800px;"/>
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="jqxDebitNoteGrid"><jsp:include page="debitNoteGrid.jsp"></jsp:include></div>
    </div>

    <div class="erp-form-area">
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
            <tr>
                <td class="lbl-right" width="10%">Dr. Total</td>
                <td width="15%">
                    <input type="text" id="txtdrtotal" name="txtdrtotal" style="text-align: right;" value='<s:property value="txtdrtotal"/>' tabindex="-1"/>
                </td>
                <td class="lbl-right" width="10%">Cr. Total</td>
                <td width="15%">
                    <input type="text" id="txtcrtotal" name="txtcrtotal" style="text-align: right;" value='<s:property value="txtcrtotal"/>' tabindex="-1"/>
                </td>
                <td width="50%" align="right">
                    <span id="formdet" style="font-size: 13px; font-weight: bold; color:#2c3e50;"></span>
                </td>
            </tr>
        </table>
    </div>

    <div style="display:none;">
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
        <div hidden="hidden" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
        <input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
        <input type="hidden" name="txtforsearch" id="txtforsearch" value='<s:property value="txtforsearch"/>'/>
        <input type="hidden" id="txtvalidation" name="txtvalidation"  value='<s:property value="txtvalidation"/>'/>
        <input type="hidden" id="taxaccount" name="taxaccount"  value='<s:property value="taxaccount"/>'/>
        <input type="hidden" id="gridlength" name="gridlength"/>
        
        <input type="hidden" id="formdetail" name="formdetail" value='<s:property value="formdetail"/>'/>
        <input type="hidden" id="formdetailcode" name="formdetailcode" value='<s:property value="formdetailcode"/>'/>
    </div>

</div>
</form>

<div id="debitNoteGridWindow"><div></div><div></div></div>  
<div id="accountDetailsToWindow"><div></div><div></div></div>
<div id="costTypeSearchGridWindow"><div></div><div></div></div> 
<div id="costCodeSearchWindow"><div></div><div></div></div> 
  
</div>
</body>
</html>