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
    /* ------------------------------
       GLOBAL STYLES & LAYOUT
    ------------------------------ */
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
        /* FORCE HEADER LEFT ALIGNMENT */
        text-align: left !important; 
    }

    /* ------------------------------
       HEADER FIXES (Title & Buttons)
    ------------------------------ */
    
    /* This overrides any <center> tags coming from header.jsp */
    center {
        text-align: left !important;
        display: block;
        width: 100%;
        margin-left: 0;
    }
    
    /* Force the Title (#formdet) to be Left Aligned and Big */
    #formdet {
        font-size: 24px !important;
        font-weight: 700 !important;
        color: #2c3e50;
        margin-bottom: 15px;
        display: block;
        text-align: left !important;
        font-family: 'Segoe UI', sans-serif;
    }

    /* ------------------------------
       GRID SYSTEM (FORM LAYOUT)
    ------------------------------ */
    .receipt-header {
        display: grid;
        grid-template-columns: auto 1fr auto 1fr auto 1fr;
        gap: 15px;
        align-items: center;
        margin-bottom: 20px;
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

    /* ------------------------------
       INPUTS & CONTROLS
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
    
    input[type="checkbox"] {
        width: auto !important;
        height: auto !important;
        margin-right: 5px;
    }

    label {
        font-weight: 600;
        color: #253858;
        white-space: nowrap;
        text-align: right;
        padding-right: 10px;
        font-size: 14px;
    }

    /* ------------------------------
       TABLES & UTILS
    ------------------------------ */
    .table-section { margin: 20px 0; }
    .table-section h3 {
        color: #253858; font-size: 1.05rem; font-weight: 600; margin-bottom: 12px;
    }
    
    .myButton {
        background: #007bff; border: none; padding: 6px 16px; color: #fff;
        border-radius: 6px; cursor: pointer; font-weight: 600;
    }
    .myButton:hover { background: #0056b3; }

    .doc-group { display: flex; gap: 5px; }
    
    /* SCROLLBAR FIX */
    .hidden-scrollbar { overflow: auto; height: 100vh; }
    .hidden-scrollbar::-webkit-scrollbar { width: 0px; } 
    
    #validrate, #validrate1 { color: red; font-size: 12px; }
    
    /* Checkbox Alignment Helper */
    .checkbox-container {
        display: flex;
        align-items: center;
        justify-content: flex-end; /* Aligns content to the right */
        width: 100%;
    }
    .checkbox-container span {
        font-weight: 600;
        color: #253858;
        font-size: 14px;
    }
</style>

<script type="text/javascript">
	$(document).ready(function() {
		 $("#btnvaluechange").hide();
		 
		 $("#jqxContraTransDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#jqxChequeDate").jqxDateTimeInput({ width: '110px', height: '15px', formatString:"dd.MM.yyyy"});
		
			
		 $('#accountDetailWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Account Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailWindow').jqxWindow('close');
		 $('#jqxContraTransDate').on('change', function (event) {
			 var contradate = $('#jqxContraTransDate').jqxDateTimeInput('getDate');
			 var validdate=funDateInPeriod(contradate);
			 if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
			    return 0;	
		     }
		 });
		 
		 $('#txtfromaccid').dblclick(function(){
			  var date = $('#jqxContraTransDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  AccountSearchContent('accountsDetailsSearch.jsp?type1='+$('#cmbtype').val()+"&date="+date);
			  $('#txtfromorto').val(2);
			  });
		 
		  $('#txttoaccid').dblclick(function(){
			  var date = $('#jqxContraTransDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  AccountSearchContent('accountsDetailsSearch.jsp?type1='+$('#cmbtotype').val()+"&date="+date);
			  $('#txtfromorto').val(3);
			  });  
		 
	});
	
	function AccountSearchContent(url) {
		$('#accountDetailWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailWindow').jqxWindow('setContent', data);
		$('#accountDetailWindow').jqxWindow('bringToFront');
	}); 
	} 
  
	  function getBranch() {
		  var branch=$('#brchName').val();
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					var branchIdItems  = items[0].split(",");
					var branchItems = items[1].split(",");
					var optionsbranch = '<option value="">--Select--</option>';
					for (var i = 0; i < branchItems.length; i++) {
						if(parseInt(branch)!=parseInt(branchIdItems[i].trim())){
							optionsbranch += '<option value="' + branchIdItems[i].trim() + '">'
							+ branchItems[i] + '</option>';
						}
					}
					$("select#cmbbranch").html(optionsbranch);    
					if ($('#hidcmbbranch').val() != null) {
						$('#cmbbranch').val($('#hidcmbbranch').val());
					}
				} else {
				}
			}
			x.open("GET", <%=contextPath+"/"%>+"com/operations/commtransactions/getBranch.jsp", true);
			x.send();
		}
	  
		  function getAccounts(){
		 		var x = new XMLHttpRequest();
		 		x.onreadystatechange = function() {
		 			if (x.readyState == 4 && x.status == 200) {
		 				var items = x.responseText;
		 			    $('#txtpdcacno').val(items);
		 		}
		 		}
		 		x.open("GET", "getAccounts.jsp", true);
		 		x.send();
		 }
	
	 function funwarningopen(){
		 $.messager.confirm('Confirm', 'Transaction will affect Links to the applied Bank Reconcilations & Prepayments.', function(r){
			    if (r){
			    	$("#mode").val("EDIT");
			    	 $('#frmContraTrans input').attr('readonly', false );$('#frmContraTrans select').attr('disabled', false);$('#jqxChequeDate').jqxDateTimeInput({disabled: false});
					 $('#txtrefno').attr('readonly', false );$('#txtdescription').attr('readonly', false );$('#txtfromaccid').attr('readonly', true );
					 $('#txtfromaccname').attr('readonly', true );$('#txttoaccid').attr('readonly', true );$('#txttoaccname').attr('readonly', true );
					 $('#docno').attr('readonly', true);$('#chckpdc').attr('disabled', false);$('#chckib').attr('disabled', false);  
					 $('#cmbfromcurrency').attr('disabled',true);
					 $('#cmbtocurrency').attr('disabled',true);
				 }
			   });
	  }
	
	 function funReadOnly(){
		    $("#btnvaluechange").hide();
			$('#frmContraTrans input').attr('readonly', true );
			$('#frmContraTrans select').attr('disabled', true);
			$('#chckpdc').attr('disabled', true);
			$('#jqxContraTransDate').jqxDateTimeInput({disabled: true});
			$('#jqxChequeDate').jqxDateTimeInput({disabled: true});
	 }
	 
	 function funRemoveReadOnly(){
		    getBranch();checkIb();checkpdc();
		    
			$('#frmContraTrans input').attr('readonly', false );
			$('#frmContraTrans select').attr('disabled', false);
			$('#cmbfromcurrency').attr('disabled', true);
			$('#cmbtocurrency').attr('disabled', true);
			$('#txtfromaccid').attr('readonly', true );
			$('#txtfromaccname').attr('readonly', true );
			$('#txttoaccid').attr('readonly', true );
			$('#txttoaccname').attr('readonly', true );
			$('#jqxContraTransDate').jqxDateTimeInput({disabled: false});
			$('#jqxChequeDate').jqxDateTimeInput({disabled: false});
			$('#cmbbranch').attr('disabled', true);
			$('#docno').attr('readonly', true);
			
			var date = $('#jqxContraTransDate').val();
		    getCurrencyId(date);
			
			if($('#cmbtype').val()=="CASH"){
	    		  $('#txtchequeno').attr('readonly', true);
	    		  $('#chckpdc').attr('disabled', true);
	    	  }
			
			if ($("#mode").val() == "E") {
             $("#btnvaluechange").show();
             $('#frmContraTrans input').attr('readonly', true );
             $('#frmContraTrans select').attr('disabled', true);
             $('#jqxChequeDate').jqxDateTimeInput({disabled: true});
   			 $('#txtrefno').attr('readonly', false );
   			 $('#txtdescription').attr('readonly', false );
   			 $('#chckpdc').attr('disabled', true);
   			 $('#chckib').attr('disabled', true);
			  }
			 else{
				$("#btnvaluechange").hide();
				$('#chckpdc').attr('disabled', false);
			}
			
	 }
	 
	 function funSearchLoad(){
		    changeContent('cotMainSearch.jsp');    
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#jqxContraTransDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	 
	   $(function(){
	        $('#frmContraTrans').validate({
	                rules: {
	                	txtfromaccid:"required",
		                txtfromamount:{number:true},
		                txttoamount:{number:true},
		                txttoaccid:"required",
	                    txtdescription:{maxlength:500}
	                 },
	                 messages: {
	                 	 txtfromaccid:" *",
		                 txtfromamount:{number:"Invalid"},
		                 txttoamount:{number:"Invalid"},
		                 txttoaccid:" *",
	                     txtdescription: {maxlength:"    Max 500 chars"}
	                 }
	        });}); 
	   
	  
	   
	   function getConfig() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				//alert(items)   
				if(parseInt(items)>0){ 
					       $('#btnEdit').attr('disabled', true);
                           $('#btnDelete').attr('disabled', true);
					}else{
						
					}
			}
		}		
			x.open("GET", "getConfig.jsp?txttotrno="+document.getElementById("txttotrno").value,true);
			x.send();
	  }	
	   
	  function funNotify(){	
		  
		 	/* Validation */
		    var contradate = $('#jqxContraTransDate').jqxDateTimeInput('getDate');
			var validdate=funDateInPeriod(contradate);
			if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
			    return 0;	
		    }
			
			ibvalid=document.getElementById("txtibvalidation").value;
			 if(ibvalid==1){
				 document.getElementById("errormsg").innerText="Closing Done For Inter-Branch,Transaction Restricted. ";
				 return 0;
			 }
			 
			pdcchequevalid=document.getElementById("txtpdcdatevalidation").value;
			 if(pdcchequevalid==1){
				 document.getElementById("errormsg").innerText="Invalid Cheque Date !!!";
				 return 0;
			 }
			 
		    var drtot = parseFloat(document.getElementById("txtfrombaseamount").value);
	 		var crtot = parseFloat(document.getElementById("txttobaseamount").value);
	 		
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
		  $('#jqxChequeDate').jqxDateTimeInput({disabled: false});
		  $('#frmContraTrans select').attr('disabled', false);
		  $('#cmbfromcurrency').attr('disabled', false);
 		  $('#cmbtocurrency').attr('disabled', false);
 			 	
	    	return 1;
		} 
	  
	  
	  function setValues(){
		  getBranch();checkIb();checkpdc();
		  
		  $('#jqxContraTransDate').jqxDateTimeInput({disabled: false});
		  var date = $('#jqxContraTransDate').val();
		  getCurrencyId(date);
		  $('#jqxContraTransDate').jqxDateTimeInput({disabled: true});
		  
		  document.getElementById("cmbtype").value=document.getElementById("hidcmbtype").value;
		  document.getElementById("cmbtotype").value=document.getElementById("hidcmbtotype").value;
		  
		  if($('#hidjqxContraTransDate').val()){
			 $("#jqxContraTransDate").jqxDateTimeInput('val', $('#hidjqxContraTransDate').val());
		  }
		  
		  if($('#hidmaindate').val()){
				 $("#maindate").jqxDateTimeInput('val', $('#hidmaindate').val());
			  }
		  
		  if($('#hidjqxChequeDate').val()){
				 $("#jqxChequeDate").jqxDateTimeInput('val', $('#hidjqxChequeDate').val());
			  }
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
		  getBankReconciled($("#docno").val(), "COT"); 
		  funRoundRate($('#txtfromrate').val(),"txtfromrate");
		  funRoundRate($('#txttorate').val(),"txttorate");
		  funRoundAmt($('#txtfromamount').val(),"txtfromamount");
		  funRoundAmt($('#txttoamount').val(),"txttoamount");
		  funRoundAmt($('#txtfrombaseamount').val(),"txtfrombaseamount");
		  funRoundAmt($('#txttobaseamount').val(),"txttobaseamount");
		 
	        
			
		}
	  function funvalid(){
		  rate=document.getElementById("txtfromrate").value;
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
		  rate1=document.getElementById("txttorate").value;
			 if(rate1=="" || rate1=="0" || rate1=="0.00"){
				 document.getElementById("validrate1").innerText= "Rate is Mandatory.";
				 document.getElementById("txttorate").focus();
				 return 0;
			 }
			 else{
				 document.getElementById("validrate1").innerText= "";
				 
			 }
	  }
	  
	
	  
	  function funchequedate(){
		  if($('#cmbtype').val()=="BANK"){
			  $('#txtchequeno').attr('readonly', false);
			  $('#chckpdc').attr('disabled', false);
		  }
		  else if($('#cmbtype').val()=="CASH"){
    		  $('#txtchequeno').attr('readonly', true);
    		  $('#chckpdc').attr('disabled', true);
    		  $('#txtchequeno').val('');
    	  }
      }
	  
	  function funCheckIb(a){
		  if(document.getElementById("chckib").checked != false){
		 		 $('#hidchckib').val(1);
		 		 $('#cmbbranch').attr('disabled', false );
		  }
		  else{
			  $('#hidchckib').val(0); 
			  $('#cmbbranch').attr('disabled', true );
		  }
	  }
	  
	  function funCheck(a){
		  if(document.getElementById("chckpdc").checked != false){
		 		 $('#hidchckpdc').val(1);getAccounts();
		  }
		  else{
			  $('#hidchckpdc').val(0);  
		  }
	  }
	  
	  function checkIb(){
			 if(document.getElementById("hidchckib").value==1){
				 document.getElementById("chckib").checked = true;
			 }
			 else if(document.getElementById("hidchckib").value==0){
				document.getElementById("chckib").checked = false;
			  }
			 }
	  
	  function checkpdc(){
			 if(document.getElementById("hidchckpdc").value==1){
				 document.getElementById("chckpdc").checked = true;
			 }
			 else if(document.getElementById("hidchckpdc").value==0){
				document.getElementById("chckpdc").checked = false;
			  }
			 }
	  
	  function getAcc(event){
          var x= event.keyCode;
          if(x==114){
        	  var date = $('#jqxContraTransDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
        	  AccountSearchContent('accountsDetailsSearch.jsp?type1='+$('#cmbtype').val()+"&date="+date);
        	  $('#txtfromorto').val(2);  
          }
          else{
           }
          }
	  
	  function getAccType(event){
          var x= event.keyCode;
          if(x==114){
        	  var date = $('#jqxContraTransDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
        	  AccountSearchContent('accountsDetailsSearch.jsp?type1='+$('#cmbtotype').val()+"&date="+date);
        	  $('#txtfromorto').val(3);
          }
          else{
           }
          }
	  
	  function funPrintBtn() {
			
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
		        var url=document.URL;
		        var reurl=url.split("saveContraTrans");
		        $("#docno").prop("disabled", false);  
		     
		        $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
					if (r){
						 var win= window.open(reurl[0]+"printContraTrans?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					     win.focus();
					 }
					else{
						var win= window.open(reurl[0]+"printContraTrans?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					    win.focus();
					}
				   });
		     }
		    else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	    }
	  
	  function clearClientInfoFrom(){
		  $("#txtfromdocno").val('');$("#txtfromaccid").val('');$("#txtfromaccname").val('');
	  }
	  
	  function clearClientInfoTo(){
		  $("#txttodocno").val('');$("#txttoaccid").val('');$("#txttoaccname").val('');
	  }
	  
	  function datechange(){
		  var date = $('#jqxContraTransDate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(date);
		  if(parseInt(validdate)==0){
			document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
			return 0;	
		  }
			
			if($('#cmbbranch').val()!='' && $('#cmbbranch').val()!=null){
		 	   var validibdate=funIBDateInPeriod($('#jqxContraTransDate').val(),$('#cmbbranch').val());
			   if(parseInt(validibdate)==0){
					document.getElementById("errormsg").innerText="Closing Done, Transaction Restricted.";
					return 0;	
		       }
		    }
		  
		  $("#maindate").jqxDateTimeInput('val', date);
		  funPDCDate($('#hidchckpdc').val(),$('#jqxContraTransDate').jqxDateTimeInput('getDate'),$('#jqxChequeDate').jqxDateTimeInput('getDate'));
	  }
	  
	  
	  
</script>

</head>
<body onload="setValues();getBranch();" onmouseover="getConfig();">
<div id="mainBG" class="hidden-scrollbar homeContent" data-type="background">
<form id="frmContraTrans" action="saveContraTrans" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

    <div class='receipt-header'>
        <label>Date</label>
        <div>
            <div id="jqxContraTransDate" name="jqxContraTransDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxContraTransDate"/>'></div>
            <input type="hidden" id="hidjqxContraTransDate" name="hidjqxContraTransDate" value='<s:property value="hidjqxContraTransDate"/>'/>
        </div>

        <label>Ref. No.</label>
        <input type="text" id="txtrefno" name="txtrefno" value='<s:property value="txtrefno"/>'/>

        <label>Doc No.</label>
        <div class="doc-group">
            <input type="text" id="docno" name="txtcontratransdocno" value='<s:property value="txtcontratransdocno"/>' tabindex="-1"/>
            <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button>
        </div>
    </div>


    <div class="section-row">
        <div class="section-block">
            <h2>Bank</h2>
            
            <div class="form-group">
                <label>Type</label>
                <select id="cmbtype" name="cmbtype" onchange="clearClientInfoFrom();funchequedate();" value='<s:property value="cmbtype"/>'>
                    <option value="CASH">Cash</option><option value="BANK">Bank</option>
                </select>
                <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/>
            </div>

            <div class="form-group single-label-dual-input">
                <label>Account</label>
                <input type="text" id="txtfromaccid" name="txtfromaccid" readonly placeholder="Press F3 to Search" value='<s:property value="txtfromaccid"/>'  onkeydown="getAcc(event);"/>
                <input type="text" id="txtfromaccname" name="txtfromaccname" readonly value='<s:property value="txtfromaccname"/>' tabindex="-1"/>
                <input type="hidden" id="txtfromdocno" name="txtfromdocno" value='<s:property value="txtfromdocno"/>'/>
            </div>

            <div class="form-group dual-input">
                <label>Currency</label>
                <select id="cmbfromcurrency" name="cmbfromcurrency" value='<s:property value="cmbfromcurrency"/>' onchange="getRate(this.value,$('#jqxContraTransDate').val());">
                    <option></option>
                </select>
                <input type="hidden" id="hidcmbfromcurrency" name="hidcmbfromcurrency" value='<s:property value="hidcmbfromcurrency"/>'/>
                <input type="hidden" id="hidfromcurrencytype" name="hidfromcurrencytype" value='<s:property value="hidfromcurrencytype"/>'/>

                <label>Rate</label>
                <input type="text" id="txtfromrate" name="txtfromrate" onchange="funvalid()" value='<s:property value="txtfromrate"/>' onblur="funRoundRate(this.value,this.id);getBaseAmountFrom();" tabindex="-1"/>
                <span id="validrate"></span>
            </div>

            <div class="form-group">
                <div class="checkbox-container">
                    <input type="checkbox" id="chckpdc" name="chckpdc" onclick="funCheck();funPDCDate($('#hidchckpdc').val(),$('#jqxContraTransDate').jqxDateTimeInput('getDate'),$('#jqxChequeDate').jqxDateTimeInput('getDate'));">
                    <span>PDC</span>
                </div>
                <input type="hidden" id="hidchckpdc" name="hidchckpdc" value='<s:property value="hidchckpdc"/>'/>
                <input type="hidden" id="txtpdcacno" name="txtpdcacno" value='<s:property value="txtpdcacno"/>'/>
            </div>
            
            <div class="form-group dual-input">
                 <label>Cheque No</label>
                 <input type="text" id="txtchequeno" name="txtchequeno" value='<s:property value="txtchequeno"/>' />
                 
                 <label>Cheque Date</label>
                 <div>
                    <div id="jqxChequeDate" name="jqxChequeDate" onchange="funPDCDate($('#hidchckpdc').val(),$('#jqxContraTransDate').jqxDateTimeInput('getDate'),$('#jqxChequeDate').jqxDateTimeInput('getDate'));" value='<s:property value="jqxChequeDate"/>'></div>
                    <input type="hidden" id="hidjqxChequeDate" name="hidjqxChequeDate" value='<s:property value="hidjqxChequeDate"/>'/>
                 </div>
            </div>

            <div class="form-group dual-input">
                <label>Amount</label>
                <input type="text" id="txtfromamount" name="txtfromamount" value='<s:property value="txtfromamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();" />
                
                <label>Base Amount</label>
                <input type="text" id="txtfrombaseamount" name="txtfrombaseamount" value='<s:property value="txtfrombaseamount"/>' tabindex="-1"/>
            </div>

            <div class="form-group">
                <label>Description</label>
                <input type="text" id="txtdescription" name="txtdescription" value='<s:property value="txtdescription"/>'/>
            </div>
        </div>

        <div class="section-block">
            <h2>Payment To</h2>
            
            <div class="form-group">
                 <div class="checkbox-container" style="justify-content: flex-end; padding-right: 10px;">
                    <input type="checkbox" id="chckib" name="chckib" onclick="funCheckIb();">
                    <span>Inter-Branch</span>
                 </div>
                 <input type="hidden" id="hidchckib" name="hidchckib" value='<s:property value="hidchckib"/>'/>
            </div>
            
            <div class="form-group">
                <label>Branch</label>
                <select id="cmbbranch" name="cmbbranch" value='<s:property value="cmbbranch"/>'>
                    <option value=""></option>
                </select>
                <input type="hidden" id="hidcmbbranch" name="hidcmbbranch" value='<s:property value="hidcmbbranch"/>'/>
            </div>

            <div class="form-group">
                <label>Type</label>
                <select id="cmbtotype" name="cmbtotype" onchange="clearClientInfoTo();" value='<s:property value="cmbtotype"/>'>
                    <option value="CASH">Cash</option><option value="BANK">Bank</option>
                </select>
                <input type="hidden" id="hidcmbtotype" name="hidcmbtotype" value='<s:property value="hidcmbtotype"/>'/>
            </div>

            <div class="form-group single-label-dual-input">
                 <label>Account</label>
                 <input type="text" id="txttoaccid" name="txttoaccid" readonly placeholder="Press F3 to Search" value='<s:property value="txttoaccid"/>' onkeydown="getAccType(event);"/>
                 <input type="text" id="txttoaccname" name="txttoaccname" readonly value='<s:property value="txttoaccname"/>' tabindex="-1"/>
                 <input type="hidden" id="txttodocno" name="txttodocno" value='<s:property value="txttodocno"/>'/>
                 <input type="hidden" id="txttotranid" name="txttotranid" value='<s:property value="txttotranid"/>'/>
                 <input type="hidden" id="txttotrno" name="txttotrno" value='<s:property value="txttotrno"/>'/>
            </div>

            <div class="form-group dual-input">
                <label>Currency</label>
                <select id="cmbtocurrency" name="cmbtocurrency" value='<s:property value="cmbtocurrency"/>' onchange="getRatevalue(this.value,$('#jqxContraTransDate').val());">
                    <option></option>
                </select>
                <input type="hidden" id="hidcmbtocurrency" name="hidcmbtocurrency" value='<s:property value="hidcmbtocurrency"/>'/>
                <input type="hidden" id="hidtocurrencytype" name="hidtocurrencytype" value='<s:property value="hidtocurrencytype"/>'/>

                <label>Rate</label>
                <input type="text" id="txttorate" name="txttorate" onchange="funvalid1()" value='<s:property value="txttorate"/>' onblur="funRoundRate(this.value,this.id);getBaseAmountTo();getCrTotal();" tabindex="-1"/>
                <span id="validrate1"></span>
            </div>

            <div class="form-group dual-input">
                <label>Amount</label>
                <input type="text" id="txttoamount" name="txttoamount" value='<s:property value="txttoamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountTo();getCrTotal();" />
                
                <label>Base Amount</label>
                <input type="text" id="txttobaseamount" name="txttobaseamount" value='<s:property value="txttobaseamount"/>' tabindex="-1"/>
            </div>
        </div>
    </div>


<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
<div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
<input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
<input type="hidden" name="txtfromorto" id="txtfromorto" value='<s:property value="txtfromorto"/>'>
<input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
<input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
<input type="hidden" id="txtibvalidation" name="txtibvalidation" value='<s:property value="txtibvalidation"/>'/>
<input type="hidden" id="txtpdcdatevalidation" name="txtpdcdatevalidation" value='<s:property value="txtpdcdatevalidation"/>'/>

</form>

<div id="accountDetailWindow">
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