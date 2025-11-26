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
<link href="<%=contextPath%>/css/css_global.css" rel="stylesheet" type="text/css" />



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

<style type="text/css">
/* =========================================================
   YOUR ORIGINAL GRID (KEPT EXACTLY AS IS)
   ========================================================= */

.form-grid {
    display: grid;
    grid-template-columns: repeat(6, 1fr); /* 6 equal columns */
    grid-column-gap: 20px;
    grid-row-gap: 14px;
    align-items: center;
}

.form-grid label {
    font-weight: 600;
}

/* Ensure inputs don't shrink weirdly */
.form-grid input,
.form-grid select,
.form-grid div {
    width: 100%;
    box-sizing: border-box;
}

/* Increase overall font size */
.form-grid,
.form-grid input,
.form-grid select,
.form-grid label {
    font-size: 15px;
}

/* =========================================================
   OUTER LIGHT BLUE BACKGROUND WRAPPER
   ========================================================= */

.form-section-bg {
    background: #eaf3ff; /* Light sky-blue */
    padding: 30px;
    border-radius: 18px;
    margin-bottom: 25px;
    box-shadow: 0 4px 25px rgba(100, 150, 255, 0.18);
    border: 1px solid #cddfff;
}

/* =========================================================
   INNER WHITE CARD (THE ONE FROM YOUR SCREENSHOT)
   ========================================================= */

.form-inner-card {
    background: #ffffff;
    padding: 30px;
    border-radius: 16px;
    box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
    margin-bottom: 10px;
}

/* =========================================================
   OPTIONAL — MATCH EXACT INPUT STYLE FROM THE SCREENSHOT
   ========================================================= */

.form-grid input,
.form-grid select {
    height: 38px;
    padding: 8px 12px;
    border-radius: 8px;
    border: 1px solid #bcd0f5;
    background: #fff;
    box-shadow: 0 2px 8px rgba(180, 190, 255, 0.20);
    font-size: 14px;
}

.form-grid input:focus,
.form-grid select:focus {
    border-color: #4a97ff;
    box-shadow: 0 0 6px rgba(77, 163, 255, 0.55);
    outline: none;
}

/* DESCRIPTION should stretch wide */
.form-grid .full-span {
    grid-column: span 5;
}

/* =========================================================
   BUTTON (matches screenshot)
   ========================================================= */
.myButton, button {
    background: linear-gradient(90deg, #3b82f6, #1a73e8);
    border: none;
    border-radius: 8px;
    padding: 8px 24px;
    color: #fff;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
    box-shadow: 0 4px 12px rgba(30, 100, 255, 0.35);
    transition: .2s ease;
}

.myButton:hover,
button:hover {
    transform: translateY(-2px);
    background: linear-gradient(90deg, #1a73e8, #155cc6);
}

</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="hidden-scrollbar homeContent" data-type="background" >
<form id="frmDebitNote" action="saveDebitNote" method="post" autocomplete="off">
<input type="hidden" id="formdetail" name="formdetail"
       value='<s:property value="formdetail"/>' />

<input type="hidden" id="formdetailcode" name="formdetailcode"
       value='<s:property value="formdetailcode"/>' />

<jsp:include page="../../../../header.jsp"></jsp:include>

<div class='receipt-header'>
<div class="form-section-bg">
    <div class="form-inner-card">

    <div class="form-grid">

        <!-- ROW 1 -->
        <label>Date</label>
        <div>
            <div id="jqxDebitNoteDate" name="jqxDebitNoteDate"
                 onchange="datechange();" onblur="datechange();"
                 value='<s:property value="jqxDebitNoteDate"/>'></div>
            <input type="hidden" id="hidjqxDebitNoteDate"
                   name="hidjqxDebitNoteDate"
                   value='<s:property value="hidjqxDebitNoteDate"/>' />
        </div>

        <label>Ref. No.</label>
        <div>
            <input type="text" id="txtrefno" name="txtrefno"
                   value='<s:property value="txtrefno"/>' />
        </div>

        <label>Doc No.</label>
        <div>
            <input type="text" id="docno" name="txtdebitnotedocno"
                   value='<s:property value="txtdebitnotedocno"/>' tabindex="-1" />
        </div>

        <!-- ROW 2 -->
        <label>Type</label>
        <div>
            <select id="cmbtype" name="cmbtype"
                    onchange="clearClientInfo();"
                    value='<s:property value="cmbtype"/>'>
                <option value="AP">AP</option>
                <option value="AR">AR</option>
                <option value="HR">HR</option>
            </select>
            <input type="hidden" id="hidcmbtype" name="hidcmbtype"
                   value='<s:property value="hidcmbtype"/>' />
        </div>

        <label>Account ID</label>
        <div>
            <input type="text" id="txtaccid" name="txtaccid"
                   placeholder="Press F3 to Search"
                   value='<s:property value="txtaccid"/>'
                   onkeydown="getAccType(event);" />
        </div>

        <label>Account Name</label>
        <div>
            <input type="text" id="txtaccname" name="txtaccname"
                   value='<s:property value="txtaccname"/>' tabindex="-1" />
            <input type="hidden" id="txtdocno" name="txtdocno"
                   value='<s:property value="txtdocno"/>' />
            <input type="hidden" id="txttrno" name="txttrno"
                   value='<s:property value="txttrno"/>' />
        </div>

        <!-- ROW 3 -->
        <label>Currency</label>
        <div>
            <select id="cmbcurrency" name="cmbcurrency"
                    value='<s:property value="cmbcurrency"/>'
                    onchange="getRatevalue(this.value,$('#jqxDebitNoteDate').val());">
                <option></option>
            </select>
            <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency"
                   value='<s:property value="hidcmbcurrency"/>' />
            <input type="hidden" id="hidcurrencytype" name="hidcurrencytype"
                   value='<s:property value="hidcurrencytype"/>' />
        </div>

        <label>Rate</label>
        <div>
            <input type="text" id="txtrate" name="txtrate"
                   value='<s:property value="txtrate"/>'
                   onchange="funvalid()"
                   onblur="funRoundRate(this.value,this.id);getBaseAmountFrom();getDrTotal();" />
            <span id="validrate"></span>
        </div>

        <label>Amount</label>
        <div>
            <input type="text" id="txtamount" name="txtamount"
                   value='<s:property value="txtamount"/>'
                   onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getDrTotal();" />
        </div>

        <label>Base Amount</label>
        <div>
            <input type="text" id="txtbaseamount" name="txtbaseamount"
                   value='<s:property value="txtbaseamount"/>' tabindex="-1" />
        </div>

        <label>Description</label>
        <div >
    <input type="text" id="txtdescription" name="txtdescription"
           value='<s:property value="txtdescription"/>' />
</div>

    </div>

    <!-- GRID + TOTALS remain unchanged -->
    <div id="jqxDebitNoteGrid">
        <jsp:include page="debitNoteGrid.jsp"></jsp:include>
    </div>

    <br/>

    <table class="cr-table" width="100%">
        <tr>
            <td width="7%" align="right">Dr. Total</td>
            <td width="68%">
                <input type="text" id="txtdrtotal" name="txtdrtotal"
                       style="width:15%;text-align: right;"
                       value='<s:property value="txtdrtotal"/>' tabindex="-1"/>
            </td>
            <td width="6%" align="right">Cr. Total</td>
            <td width="19%">
                <input type="text" id="txtcrtotal" name="txtcrtotal"
                       style="width:50%;text-align: right;"
                       value='<s:property value="txtcrtotal"/>' tabindex="-1"/>
            </td>
        </tr>
    </table>

</div>
</div>
</div>
</form>
</div>
</body>
</html>