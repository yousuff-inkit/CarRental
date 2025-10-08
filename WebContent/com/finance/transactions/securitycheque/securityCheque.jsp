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

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}


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
    /*box-shadow: 0 4px 24px rgba(0,0,0,0.08);*/
    padding: 10px;
    max-width: 1200px;
    margin: 0 auto;
}

.receipt-header {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    margin-bottom: 16px;
    border-radius: 12px;
    padding: 0px 24px;
    font-size: 2vh;
}
.receipt-header label {
    font-weight: 500;
    color: #333;
    margin-right: 8px;
}
.receipt-header input[type="text"] {
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    font-size: 1rem;
    width: 120px;
    background: #fff;
    transition: border-color 0.2s;
}
.receipt-header input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
}
.receipt-header button {
    background: #007bff;
    color: #fff;
    border: none;
    border-radius: 6px;
    padding: 6px 16px;
    font-weight: 500;
    cursor: pointer;
    transition: background 0.2s;
}
.receipt-header button:hover {
    background: #0056b3;
}
#txtStatus {
    font-size: 1rem;
    font-weight: 600;
    color: #e67e22;
    margin-left: 12px;
}

.section-row {
    display: flex;
    gap: 26px;
    margin-bottom: 24px;
}
.section-block {
    flex: 1;
    background: #f6f8fa;
    border-radius: 10px;
    padding: 20px 18px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.05);
}

.section-block h2 {
    font-size: 1.09em;
    font-weight: 500;
    margin: 0 0 16px 0;
    color: #253858;
}

.section-block .form-group {
    display: flex;
    align-items: center;
    gap: 16px;
    margin-bottom: 12px;
}

.section-block label {
    min-width: 110px;
    text-align: right;
    font-weight: 500;
    color: #253858;
}

.section-block input[type="text"],
.section-block select {
    flex: 1;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    background: #fff;
    transition: border-color 0.2s;
}

.section-block input[type="text"]:focus,
.section-block select:focus {
    border-color: #007bff;
    outline: none;
}


.table-section {
    margin-bottom: 18px;
}
.table-section h3 {
    color: #253858;
    font-size: 1.04em;
    font-weight: 600;
}
.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #f9fafb;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 0 0 1px #eef0f6;
}
.cr-table th, .cr-table td {
    padding: 9px 10px;
    border-bottom: 1px solid #e4e7ec;
    text-align: left;
    font-size: 1em;
}
.cr-table th {
    background: #eef0f6;
    color: #354B6A;
    font-weight: 600;
}
.cr-table tr:last-child td {
    border-bottom: none;
}
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmSecurityCheque" action="saveSecurityCheque" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div  class='hidden-scrollbar receipt-header'>

    <div class="table-section">
<table class="cr-table" width="100%">
  <tr>
    <td width="6%" align="right">Date</td>
    <td colspan="2"><div id="jqxSecurityChequeDate" name="jqxSecurityChequeDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxSecurityChequeDate"/>'></div>
    <input type="hidden" id="hidjqxSecurityChequeDate" name="hidjqxSecurityChequeDate" value='<s:property value="hidjqxSecurityChequeDate"/>'/></td>
    <td width="47%" align="right">Doc No.</td>
    <td width="15%"><input type="text" id="docno" name="txtsecuritychequedocno" value='<s:property value="txtsecuritychequedocno"/>' tabindex="-1"/></td>
  </tr>
  <tr>
    <td align="right">Paid To</td>
    <td colspan="4"><select id="cmbtotype" name="cmbtotype" style="width:5%;" onchange="clearClientInfo();" value='<s:property value="cmbtotype"/>'>
      <option value="AP">AP</option><option value="AR">AR</option><option value="GL">GL</option></select>&nbsp;&nbsp;
      <input type="hidden" id="hidcmbtotype" name="hidcmbtotype" value='<s:property value="hidcmbtotype"/>'/>      
      <input type="text" id="txttoaccid" name="txttoaccid" style="width:15%;" placeholder="Press F3 to Search" value='<s:property value="txttoaccid"/>'  onkeydown="getAccType(event);"/>&nbsp;&nbsp;
      <input type="text" id="txttoaccname" name="txttoaccname" style="width:40%;" value='<s:property value="txttoaccname"/>' tabindex="-1"/>
      <input type="hidden" id="txttodocno" name="txttodocno" value='<s:property value="txttodocno"/>'/></td>
  </tr>
  <tr>
    <td align="right">Bank</td>
    <td colspan="4"><input type="text" id="txtfromaccid" name="txtfromaccid" style="width:15%;" placeholder="Press F3 to Search" value='<s:property value="txtfromaccid"/>' onkeydown="getAcc(event);"/>&nbsp;&nbsp;
      <input type="text" id="txtfromaccname" name="txtfromaccname" style="width:46%;" value='<s:property value="txtfromaccname"/>' tabindex="-1"/>
    <input type="hidden" id="txtfromdocno" name="txtfromdocno" value='<s:property value="txtfromdocno"/>'/></td>
  </tr>
   <tr>
    <td align="right">Cheque Name</td>
    <td colspan="4"><input type="text" id="txtchequename" name="txtchequename" style="width:62%;" value='<s:property value="txtchequename"/>'/></td>
  </tr>
  <tr>
    <td align="right">Cheque No.</td>
    <td width="18%"><input type="text" id="txtchequeno" name="txtchequeno" style="width:100%;" onchange="funchequedate();" value='<s:property value="txtchequeno"/>' /></td>
    <td width="14%" align="right">Valid Up To</td>
    <td colspan="2"><div id="jqxValidUpTo" name="jqxValidUpTo" value='<s:property value="jqxValidUpTo"/>'></div>
    <input type="hidden" id="hidjqxValidUpTo" name="hidjqxValidUpTo" value='<s:property value="hidjqxValidUpTo"/>'/></td>
  </tr>
  <tr>
    <td align="right"><input type="checkbox" id="chckchqdate" name="chckchqdate" value="" onchange="checkChequeDate();">Cheque Date
                                 <input type="hidden" id="hidchckchqdate" name="hidchckchqdate" value='<s:property value="hidchckchqdate"/>'/></td>
    <td><div id="jqxChequeDate" name="jqxChequeDate" value='<s:property value="jqxChequeDate"/>'></div>
    				<input type="hidden" id="hidjqxChequeDate" name="hidjqxChequeDate" value='<s:property value="hidjqxChequeDate"/>'/></td>
    <td align="right"><input type="checkbox" id="chckamount" name="chckamount" value="" onchange="checkAmount();">Amount
                                 <input type="hidden" id="hidchckamount" name="hidchckamount" value='<s:property value="hidchckamount"/>'/></td>
    <td colspan="2"><input type="text" id="txtamount" name="txtamount" style="width:15%;text-align: right;" value='<s:property value="txtamount"/>' onblur="funRoundAmt(this.value,this.id);" /></td>
  </tr>
  <tr>
    <td align="right">Remarks</td>
    <td colspan="4"><input type="text" id="txtremarks" name="txtremarks" style="width:62%;" value='<s:property value="txtremarks"/>' /></td>
  </tr>
</table></div>



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