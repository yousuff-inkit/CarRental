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
   GLOBAL STYLES
------------------------------ */

body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 32px 0;
    min-height: 130vh;
    box-sizing: border-box;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 20px;
    max-width: 100%;
    margin: auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

/* ------------------------------
   COMMON UI ELEMENTS
------------------------------ */

input[type="text"], select {
    height: 32px !important;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    background: #fff;
    transition: border-color 0.2s;
    font-size: 14px;
    box-sizing: border-box;
}

input[type="text"]:focus,
select:focus {
    border-color: #007bff;
    outline: none;
}

label {
    font-weight: 600;
    color: #253858;
    white-space: nowrap;
}

/* ------------------------------
   HEADER SECTION
------------------------------ */

.receipt-header {
    background: #f6f8fa;
    border-radius: 12px;
    padding: 24px;
    margin-bottom: 20px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.1);
}

.section_row {
    display: flex;
    flex-direction: column;
    gap: 16px;
}

/* ------------------------------
   FORM ROWS LAYOUT
------------------------------ */

.form-group {
    display: grid;
    grid-template-columns: 120px 1fr;
    align-items: center;
    gap: 12px 16px;
    margin-bottom: 12px;
}

.form-group label {
    text-align: right;
    padding-right: 8px;
    font-size: 1rem;
}

.form-group input[type="text"],
.form-group select {
    width: 100%;
}

/* Dual input rows (Currency/Rate, Amount/Base Amount) */
.form-group.dual-input {
    grid-template-columns: 120px 1fr 120px 1fr;
}

.form-group.dual-input label:nth-of-type(2) {
    text-align: right;
    padding-right: 8px;
}

/* Date/Ref/Doc row - 3 pairs */
.form-group.date-ref-doc-row {
    grid-template-columns: 80px 200px 80px 1fr 80px 200px;
    align-items: center;
    gap: 12px;
}

.form-group.date-ref-doc-row label {
    text-align: right;
    padding-right: 8px;
}

.form-group.date-ref-doc-row .date-wrapper,
.form-group.date-ref-doc-row .ref-wrapper {
    display: flex;
    align-items: center;
    gap: 8px;
}

.form-group.date-ref-doc-row #jqxDebitNoteDate {
    flex: 1;
}

.form-group.date-ref-doc-row #txtrefno {
    flex: 1;
    min-width: 120px;
}

.form-group.date-ref-doc-row .myButton {
    white-space: nowrap;
    flex-shrink: 0;
}

/* Type/AccID/AccName row */
.form-group.type-acc-row {
    grid-template-columns: 120px 120px 120px 200px 1fr;
    align-items: center;
    gap: 12px;
}

.form-group.type-acc-row label {
    text-align: right;
    padding-right: 8px;
}

/* Full width description row */
.form-row.full-row {
    display: grid;
    grid-template-columns: 120px 1fr;
    align-items: center;
    gap: 12px;
    margin-bottom: 12px;
}

.form-row.full-row label {
    text-align: right;
    padding-right: 8px;
    font-weight: 600;
    color: #253858;
}

/* ------------------------------
   TABLE SECTIONS
------------------------------ */

.table-section {
    margin: 20px 0;
}

.table-section h3 {
    color: #253858;
    font-size: 1.05rem;
    font-weight: 600;
    margin-bottom: 12px;
}

.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #fff;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 0 0 1px #e5e7eb;
}

.cr-table th,
.cr-table td {
    padding: 8px 12px;
    border-bottom: 1px solid #eef0f6;
    font-size: 14px;
}

.cr-table th {
    background: #eef0f6;
    font-weight: 600;
    color: #354B6A;
}

.cr-table tr:last-child td {
    border-bottom: none;
}

/* ------------------------------
   SCROLL AREAS
------------------------------ */

.hidden-scrollbar {
    overflow: auto;
}

.hidden-scrollbar::-webkit-scrollbar {
    width: 10px;
}

/* ------------------------------
   BUTTONS
------------------------------ */

button, .myButton {
    background: #007bff;
    border: none;
    padding: 6px 16px;
    color: #fff;
    border-radius: 6px;
    cursor: pointer;
    font-weight: 600;
    transition: background 0.2s;
    font-size: 13px;
}

button:hover, .myButton:hover {
    background: #0056b3;
}

/* ------------------------------
   ERROR LABELS
------------------------------ */

#validrate,
#validrate1 {
    color: red;
    font-size: 12px;
    grid-column: 2 / -1;
}

/* ------------------------------
   APPROVAL TABLE
------------------------------ */

#approval-table td {
    font-size: 14px;
    padding: 8px;
}

#approval-table tr:nth-child(even) {
    background: #f9fafb;
}
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="hidden-scrollbar homeContent" data-type="background" >
<form id="frmTaxDebitNote" action="saveTaxDebitNote" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div  class=' receipt-header'>
    <div class="section_row">

    <!-- Row 1: Date / Ref. No. / Doc No -->
    <div class="form-group date-ref-doc-row" style="margin-left:40px">
        <label for="jqxDebitNoteDate">Date</label>
        <div class="date-wrapper">
            <div id="jqxDebitNoteDate" name="jqxDebitNoteDate"
                 onchange="datechange();"
                 onblur="datechange();"
                 value='<s:property value="jqxDebitNoteDate"/>'></div>
            <input type="hidden" id="hidjqxDebitNoteDate" 
                   name="hidjqxDebitNoteDate"
                   value='<s:property value="hidjqxDebitNoteDate"/>'/>
        </div>

        <label for="txtrefno">Ref. No.</label>
        <div class="ref-wrapper">
            <input type="text" id="txtrefno" name="txtrefno"
                   value='<s:property value="txtrefno"/>'/>
            <button class="myButton" type="button" id="btnvaluechange"
                    name="btnvaluechange" onclick="funwarningopen();">
                Value Change
            </button>
        </div>

        <label for="docno">Doc No.</label>
        <input type="text" id="docno" name="txtdebitnotedocno"
               value='<s:property value="txtdebitnotedocno"/>' tabindex="-1"/>
    </div>

    <!-- Row 2: Type / Acc ID / Acc Name -->
    <div class="form-group type-acc-row">
        <label for="cmbtype">Type</label>
        <select id="cmbtype" name="cmbtype"
                onchange="clearClientInfo();"
                value='<s:property value="cmbtype"/>'>
            <option value="AR">AR</option>
            <option value="GL">GL</option>
            <option value="AP">AP</option>
        </select>
        <input type="hidden" id="hidcmbtype" name="hidcmbtype"
               value='<s:property value="hidcmbtype"/>'/>

        <label for="txtaccid">Account ID</label>
        <input type="text" id="txtaccid" name="txtaccid"
               placeholder="Press F3 to Search"
               value='<s:property value="txtaccid"/>'
               onkeydown="getAccType(event);" />

        <input type="text" id="txtaccname" name="txtaccname"
               value='<s:property value="txtaccname"/>' tabindex="-1"/>
        <input type="hidden" id="txtdocno" name="txtdocno"
               value='<s:property value="txtdocno"/>'/>
        <input type="hidden" id="txttrno" name="txttrno"
               value='<s:property value="txttrno"/>'/>
    </div>

    <!-- Row 3: Currency / Rate -->
    <div class="form-group dual-input">
        <label for="cmbcurrency">Currency</label>
        <select id="cmbcurrency" name="cmbcurrency"
                value='<s:property value="cmbcurrency"/>'
                onchange="getRatevalue(this.value,$('#jqxDebitNoteDate').val());">
            <option></option>
        </select>
        <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency"
               value='<s:property value="hidcmbcurrency"/>'/>
        <input type="hidden" id="hidcurrencytype" name="hidcurrencytype"
               value='<s:property value="hidcurrencytype"/>'/>

        <label for="txtrate">Rate</label>
        <input type="text" id="txtrate" name="txtrate"
               value='<s:property value="txtrate"/>'
               onblur="funRoundRate(this.value,this.id);
                       getBaseAmountFrom();getDrTotal();" tabindex="-1"/>
        <span id="validrate"></span>
    </div>

    <!-- Row 4: Amount / Base Amount -->
    <div class="form-group dual-input">
        <label for="txtamount">Amount</label>
        <input type="text" id="txtamount" name="txtamount"
               value='<s:property value="txtamount"/>'
               onblur="funRoundAmt(this.value,this.id);
                       getBaseAmountFrom();getDrTotal();" />

        <label for="txtbaseamount">Base Amount</label>
        <input type="text" id="txtbaseamount" name="txtbaseamount"
               value='<s:property value="txtbaseamount"/>' tabindex="-1"/>
    </div>

    <!-- Row 5: Description (full width) -->
    <div class="form-row full-row">
        <label for="txtdescription">Description</label>
        <input type="text" id="txtdescription" name="txtdescription"
               value='<s:property value="txtdescription"/>'/>
    </div>

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