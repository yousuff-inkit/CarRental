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
        max-width: 1450px;
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
        grid-template-columns: auto 1fr auto 1fr;
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
    
    /* Special row for Paid To (Label | Select | Input | Input) */
    .form-group.quad-input {
        grid-template-columns: 120px 80px 140px 1fr;
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
    .hidden-scrollbar { overflow: auto; height: 530px; }
    .hidden-scrollbar::-webkit-scrollbar { width: 0px; } 
    
    #validrate, #validrate1 { color: red; font-size: 12px; }
    
    /* Checkbox Alignment Helper */
    .checkbox-label {
        display: flex;
        align-items: center;
        justify-content: flex-end; 
        font-weight: 600;
        color: #253858;
        font-size: 14px;
        padding-right: 10px;
    }
    
    .checkbox-container {
        display: flex;
        align-items: center;
    }
</style>

<script type="text/javascript">
	$(document).ready(function() {
		 $("#jqxSecurityChequeDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#jqxChequeDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#jqxValidUpTo").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsToWindow').jqxWindow('close');  
		 
		 $('#accountDetailsFromWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsFromWindow').jqxWindow('close');
		 
		 $('#printWindow').jqxWindow({width: '51%', height: '31%',  maxHeight: '50%' ,maxWidth: '51%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#printWindow').jqxWindow('close');
		 
		 $('#txtfromaccid').dblclick(function(){
			  var date = $('#jqxSecurityChequeDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountFromSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
			  });
		 
		  $('#txttoaccid').dblclick(function(){
			  var date = $('#jqxSecurityChequeDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountToSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtotype').val()+"&date="+date);
			  });  
	});
	
	function accountFromSearchContent(url) {
	    $('#accountDetailsFromWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsFromWindow').jqxWindow('setContent', data);
		$('#accountDetailsFromWindow').jqxWindow('bringToFront');
	}); 
	}

	function accountToSearchContent(url) {
		 	$('#accountDetailsToWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#accountDetailsToWindow').jqxWindow('setContent', data);
			$('#accountDetailsToWindow').jqxWindow('bringToFront');
		}); 
	}
	
	function SecurityChequePrintContent(url) {
		$('#printWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#printWindow').jqxWindow('setContent', data);
		$('#printWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	 function funReadOnly(){
			$('#frmSecurityCheque input').attr('readonly', true );
			$('#frmSecurityCheque select').attr('disabled', true);
			$('#chckchqdate').attr('disabled', true);
			$('#chckamount').attr('disabled', true);
			$('#jqxSecurityChequeDate').jqxDateTimeInput({disabled: true});
			$('#jqxChequeDate').jqxDateTimeInput({disabled: true});
			$('#jqxValidUpTo').jqxDateTimeInput({disabled: true});
	 }
	 
	 function funRemoveReadOnly(){
			$('#frmSecurityCheque input').attr('readonly', false );
			$('#frmSecurityCheque select').attr('disabled', false);
			$('#chckchqdate').attr('disabled', false);
			$('#chckamount').attr('disabled', false);
			$('#jqxSecurityChequeDate').jqxDateTimeInput({disabled: false});
			$('#jqxChequeDate').jqxDateTimeInput({disabled: true});
			$('#jqxValidUpTo').jqxDateTimeInput({disabled: false});
			$('#txtfromaccid').attr('readonly', true );
			$('#txtfromaccname').attr('readonly', true );
			$('#txttoaccid').attr('readonly', true );
			$('#txttoaccname').attr('readonly', true );
			$('#txtamount').attr('readonly', true );
			$('#docno').attr('readonly', true);
			
			if ($("#mode").val() == "A") {
				$('#jqxSecurityChequeDate').val(new Date());
			}		
	 }
	 
	 function funSearchLoad(){
		 changeContent('secMainSearch.jsp');  
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
		  $('#jqxSecurityChequeDate').jqxDateTimeInput('focus'); 
	    }
	 
	   $(function(){
	        $('#frmSecurityCheque').validate({
	                rules: {
	                txtfromaccid:"required",
	                chckamount:"required",
					txtremarks:{maxlength:500}
	                 },
	                 messages: {
	                 txtfromaccid:" *",
	                 chckamount:{required:" *",number:"Invalid"},
					 txtremarks: {maxlength:"    Max 500 chars"}
	                 }
	        });});
	   
	  function funNotify(){	
		 		$('#jqxSecurityChequeDate').jqxDateTimeInput({disabled: false});
		 		$('#jqxChequeDate').jqxDateTimeInput({disabled: false});
		 		$('#jqxValidUpTo').jqxDateTimeInput({disabled: false});
			    $('#frmSecurityCheque select').attr('disabled', false); 
		 		
				var date = $('#jqxSecurityChequeDate').jqxDateTimeInput('getDate');
				var validdate=funDateInPeriod(date);
				if(parseInt(validdate)==0){
					document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
					return 0;	
				}
				
	  paidto=document.getElementById("cmbtotype").value;
		 if(paidto==""){
			 document.getElementById("errormsg").innerText="Enter Paid To";
			 return 0;
		 }
		 acc=document.getElementById("txttoaccname").value;
		 if(acc==""){
			 document.getElementById("errormsg").innerText="Enter Account Details";
			 return 0;
		 }
		 bank=document.getElementById("txtfromaccid").value;
		 if(bank==""){
			 document.getElementById("errormsg").innerText="Enter Bank";
			 return 0;
		 }
		 document.getElementById("errormsg").innerText="";
 		
			return 1;
	} 
	  function setValues(){
		  
		  document.getElementById("cmbtotype").value=document.getElementById("hidcmbtotype").value;
		  
		  if($('#hidjqxSecurityChequeDate').val()){
				 $("#jqxSecurityChequeDate").jqxDateTimeInput('val', $('#hidjqxSecurityChequeDate').val());
			  }
		  
		  if($('#hidmaindate').val()){
				 $("#maindate").jqxDateTimeInput('val', $('#hidmaindate').val());
			  }
		  
		  if($('#hidjqxChequeDate').val()){
				 $("#jqxChequeDate").jqxDateTimeInput('val', $('#hidjqxChequeDate').val());
			  }
		  
		  if($('#hidjqxValidUpTo').val()){
				 $("#jqxValidUpTo").jqxDateTimeInput('val', $('#hidjqxValidUpTo').val());
			  }
		  
		  if(document.getElementById("hidchckchqdate").value==1){
	 			 document.getElementById("chckchqdate").checked = true;
	 		 }
	 		 else if(document.getElementById("hidchckchqdate").value==0){
	 			document.getElementById("chckchqdate").checked = false;
	 		 }
		  
		  if(document.getElementById("hidchckamount").value==1){
	 			 document.getElementById("chckamount").checked = true;
	 		 }
	 		 else if(document.getElementById("hidchckamount").value==0){
	 			document.getElementById("chckamount").checked = false;
	 		 }
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
		  funRoundAmt($('#txtamount').val(),"txtamount");
	        
			
		}
	  
	  function funPrintBtn() {
			
		if (($("#mode").val() == "view") && $("#docno").val()!="") {
			SecurityChequePrintContent('printVoucherWindow.jsp');
		  }
		else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	  }
	  
	  function getAcc(event){
          var x= event.keyCode;
          if(x==114){
        	  var date = $('#jqxSecurityChequeDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
        	  accountFromSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
          }
          else{
           }
          }
	  
	  function getAccType(event){
          var x= event.keyCode;
          if(x==114){
        	  var date = $('#jqxSecurityChequeDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountToSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtotype').val()+"&date="+date);
          }
          else{
           }
          }
	  
	  function funchequedate(){
	      var chequedate = $('#jqxSecurityChequeDate').jqxDateTimeInput('getDate');
		  var chequeDates =new Date(chequedate).setDate(chequedate.getDate()+1); 
		  $('#jqxChequeDate').jqxDateTimeInput('setDate', new Date(chequeDates));
		  
		  var validupto = $('#jqxSecurityChequeDate').jqxDateTimeInput('getDate');
		  var validuptos =new Date(validupto).setDate(chequedate.getDate()+1); 
		  $('#jqxValidUpTo').jqxDateTimeInput('setDate', new Date(validuptos));
      }
	  	  
	  function clearClientInfo(){
		  $("#txttodocno").val('');$("#txttoaccid").val('');$("#txttoaccname").val('');
	  }
	  
	  function checkChequeDate(){
	 		 if(document.getElementById("chckchqdate").checked){
	 			 document.getElementById("hidchckchqdate").value = 1;
	 			 $('#jqxChequeDate').jqxDateTimeInput({disabled: false});
	 		 }
	 		 else{
	 			 document.getElementById("hidchckchqdate").value = 0;
	 			 $('#jqxChequeDate').jqxDateTimeInput({disabled: true});
	 		 }
	 	 }
	  
	  function checkAmount(){
		  if(document.getElementById("chckamount").checked){
	 			 document.getElementById("hidchckamount").value = 1;
	 			 $('#txtamount').attr('readonly', false );
	 		 }
	 		 else{
	 			 document.getElementById("hidchckamount").value = 0;
	 			 $('#txtamount').attr('readonly', true );
	 		 }
	  }
	  
	  function datechange(){
		  var date = $('#jqxSecurityChequeDate').jqxDateTimeInput('getDate');
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
<div id="mainBG" class="hidden-scrollbar homeContent" data-type="background" >
<form id="frmSecurityCheque" action="saveSecurityCheque" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

    <div class='receipt-header'>
        <label>Date</label>
        <div>
            <div id="jqxSecurityChequeDate" name="jqxSecurityChequeDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxSecurityChequeDate"/>'></div>
            <input type="hidden" id="hidjqxSecurityChequeDate" name="hidjqxSecurityChequeDate" value='<s:property value="hidjqxSecurityChequeDate"/>'/>
        </div>

        <label style="margin-left:auto;">Doc No.</label>
        <input type="text" id="docno" name="txtsecuritychequedocno" value='<s:property value="txtsecuritychequedocno"/>' tabindex="-1"/>
    </div>


    <div class="section-row">
        <div class="section-block">
            <h2>Cheque Details</h2>
            
            <div class="form-group single-label-dual-input">
                <label>Bank</label>
                <input type="text" id="txtfromaccid" name="txtfromaccid" placeholder="Press F3 to Search" value='<s:property value="txtfromaccid"/>' onkeydown="getAcc(event);"/>
                <input type="text" id="txtfromaccname" name="txtfromaccname" value='<s:property value="txtfromaccname"/>' tabindex="-1"/>
                <input type="hidden" id="txtfromdocno" name="txtfromdocno" value='<s:property value="txtfromdocno"/>'/>
            </div>

            <div class="form-group">
                <label>Cheque Name</label>
                <input type="text" id="txtchequename" name="txtchequename" value='<s:property value="txtchequename"/>'/>
            </div>

            <div class="form-group dual-input">
                <label>Cheque No</label>
                <input type="text" id="txtchequeno" name="txtchequeno" onchange="funchequedate();" value='<s:property value="txtchequeno"/>' />
                
                <label>Valid Up To</label>
                <div>
                    <div id="jqxValidUpTo" name="jqxValidUpTo" value='<s:property value="jqxValidUpTo"/>'></div>
                    <input type="hidden" id="hidjqxValidUpTo" name="hidjqxValidUpTo" value='<s:property value="hidjqxValidUpTo"/>'/>
                </div>
            </div>
            
            <div class="form-group">
                <div class="checkbox-label" style="min-width: 120px;">
                    <input type="checkbox" id="chckchqdate" name="chckchqdate" value="" onchange="checkChequeDate();">
                    Cheque Date
                </div>
                <div style="flex-grow: 1;">
                    <div id="jqxChequeDate" name="jqxChequeDate" value='<s:property value="jqxChequeDate"/>'></div>
                    <input type="hidden" id="hidjqxChequeDate" name="hidjqxChequeDate" value='<s:property value="hidjqxChequeDate"/>'/>
                    <input type="hidden" id="hidchckchqdate" name="hidchckchqdate" value='<s:property value="hidchckchqdate"/>'/>
                </div>
            </div>
        </div>

        <div class="section-block">
            <h2>Payment Details</h2>
            
            <div class="form-group quad-input">
                <label>Paid To</label>
                <select id="cmbtotype" name="cmbtotype" onchange="clearClientInfo();" value='<s:property value="cmbtotype"/>'>
                    <option value="AP">AP</option><option value="AR">AR</option><option value="GL">GL</option>
                </select>
                <input type="hidden" id="hidcmbtotype" name="hidcmbtotype" value='<s:property value="hidcmbtotype"/>'/>      
                
                <input type="text" id="txttoaccid" name="txttoaccid" placeholder="Press F3 to Search" value='<s:property value="txttoaccid"/>'  onkeydown="getAccType(event);"/>
                <input type="text" id="txttoaccname" name="txttoaccname" value='<s:property value="txttoaccname"/>' tabindex="-1"/>
                <input type="hidden" id="txttodocno" name="txttodocno" value='<s:property value="txttodocno"/>'/>
            </div>

            <div class="form-group">
                <div class="checkbox-label" style="min-width: 120px;">
                    <input type="checkbox" id="chckamount" name="chckamount" value="" onchange="checkAmount();">
                    Amount
                </div>
                <input type="text" id="txtamount" name="txtamount" style="width:100%;text-align: right;" value='<s:property value="txtamount"/>' onblur="funRoundAmt(this.value,this.id);" />
                <input type="hidden" id="hidchckamount" name="hidchckamount" value='<s:property value="hidchckamount"/>'/>
            </div>

            <div class="form-group">
                <label>Remarks</label>
                <input type="text" id="txtremarks" name="txtremarks" value='<s:property value="txtremarks"/>' />
            </div>
        </div>
    </div>


<input type="hidden" id="cmbfromcurrency" name="cmbfromcurrency" value='<s:property value="cmbfromcurrency"/>'/>
<input type="hidden" id="hidfromcurrencytype" name="hidfromcurrencytype" value='<s:property value="hidfromcurrencytype"/>'/>
<input type="hidden" id="txtfromrate" name="txtfromrate" value='<s:property value="txtfromrate"/>'/>

<input type="hidden" id="cmbtocurrency" name="cmbtocurrency" value='<s:property value="cmbtocurrency"/>'/>
<input type="hidden" id="hidtocurrencytype" name="hidtocurrencytype" value='<s:property value="hidtocurrencytype"/>'/>
<input type="hidden" id="txttorate" name="txttorate" value='<s:property value="txttorate"/>'/>
      
<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
<input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
<input type="hidden" name="txtforsearch" id="txtforsearch" value="0"/>
</div>
</form>  
				
<div id="accountDetailsFromWindow">
	<div></div><div></div>
</div>  
	 
 <div id="accountDetailsToWindow">
	<div></div><div></div>
</div> 
	
<div id="printWindow">
	<div></div><div></div>
</div>

</div>
</body>
</html>