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
		 $('#btnExcel').attr('disabled', false );$('#btnDelete').attr('disabled', true );$('#btnAttach').attr('disabled', true );
		 
		 $("#jqxBankReconciliationDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $('#txtforsearch').val(2);
		 
		 $('#accountDetailsFromWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsFromWindow').jqxWindow('close');  
		 
		 $('#jqxBankReconciliationDate').on('change', function (event) {
				var reconciledate = $('#jqxBankReconciliationDate').jqxDateTimeInput('getDate');
				var validdate=funDateInPeriod(reconciledate);
				if(parseInt(validdate)==0){
					document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
					return 0;	
				}
			 });
			 
		$('#txtaccid').dblclick(function(){
			  var date = $('#jqxBankReconciliationDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
		   	  $('#txtforsearch').val(2);
		   	 $("#jqxBankReconciliation").jqxGrid('clear');
		});	 
		 
	});
	
	function accountSearchContent(url){
	  $('#accountDetailsFromWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsFromWindow').jqxWindow('setContent', data);
		$('#accountDetailsFromWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getBranch() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var branchIdItems  = items[0].split(",");
  				var branchItems = items[1].split(",");
  				var optionsbranch = '<option value="a">ALL</option>';
  				for (var i = 0; i < branchItems.length; i++) {
  					optionsbranch += '<option value="' + branchIdItems[i].trim() + '">'
  							+ branchItems[i] + '</option>';
  				}
  				$("select#cmbbranch").html(optionsbranch);
  				if ($('#hidcmbbranch').val() != null) {
  					$('#cmbbranch').val($('#hidcmbbranch').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", <%=contextPath+"/"%>+"com/finance/posting/getBranch.jsp", true);
  		x.send();
  	}
	
	function getLastReconcileDate(reconcileddate,account){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				 items = items.split('***');
  			     $('#txtchkgridload').val(items[2].trim());
  			     if(parseInt(items[2].trim())>=0){
  			    	  funloadappliedgrid();
  			     } else if(parseInt(items[2].trim())<0) {
					  $.messager.alert('Message','Bank Reconcilation done till '+items[1].trim()+'','warning');
					  $("#jqxBankReconciliation").jqxGrid('clear'); 
			          $("#jqxBankReconciliation").jqxGrid('addrow', null, {});
			          $("#jqxBankReconciliation").jqxGrid({ disabled: true});
					  return;
				 }
  			     
  			   
  		}
		}
		x.open("GET", "getLastReconciledDate.jsp?reconcileddate="+reconcileddate+'&account='+account, true);
		x.send();
	}
	
	function getAcc(event){
	   var x= event.keyCode;
	   if(x==114){
	  	 accountSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp");
   	     $('#txtforsearch').val(2);
   	     $("#jqxBankReconciliation").jqxGrid('clear');  
	      }
	   }
	   
	function funReadOnly(){
		$('#frmBankReconciliation input').attr('readonly', true );
		$('#frmBankReconciliation select').attr('disabled', true);
		$('#jqxBankReconciliationDate').jqxDateTimeInput({disabled: true});
	    $("#jqxBankReconciliation").jqxGrid({ disabled: true});
		$("#btnSubmit").hide();
	}
	
	function funRemoveReadOnly(){
		$('#txtforsearch').val(2);		
		getBranch();
	    $('#frmBankReconciliation input').attr('readonly', false );
		$('#frmBankReconciliation select').attr('disabled', false);
		$('#jqxBankReconciliationDate').jqxDateTimeInput({disabled: false});
		$('#docno').attr('readonly', true );
		$('#txtaccid').attr('readonly', true );
		$('#txtaccname').attr('readonly', true );
		$('#txtunclrreceipts').attr('readonly', true );
	    $('#txtunclrpayments').attr('readonly', true );
	    $('#txtbookbalance').attr('readonly', true );
	    $('#txtbankbalance').attr('readonly', true );
		$("#jqxBankReconciliation").jqxGrid({ disabled: true});
		$("#btnSubmit").show();
		
		var date = $('#jqxBankReconciliationDate').val();
	    getCurrencyId(date);
	    
		 if ($("#mode").val() == "A") {
			 $('#jqxBankReconciliationDate').val(new Date());
			 document.getElementById("lblformposted").innerText="";
			 $("#jqxBankReconciliation").jqxGrid('clear');
			 $("#jqxBankReconciliation").jqxGrid('addrow', null, {});
		}  
		 
		 if ($("#mode").val() == "E") {
			 $("#jqxBankReconciliation").jqxGrid({ disabled: false});
			  var check = 1;
			  var date=document.getElementById("jqxBankReconciliationDate").value;
			  var accId = document.getElementById("txtdocno").value;
			  var docno = document.getElementById("docno").value;
			  var mode = document.getElementById("mode").value;
			  $("#jqxBankReconciliationGrid").load('bankReconciliationGrid.jsp?accountno='+accId+'&date='+date+'&docno='+docno+'&mode='+mode+'&check='+check); 
		 }
		
	}
	
	function funSearchLoad(){
	    changeContent('brcnMainSearch.jsp'); 
	}
	
	function funChkButton(){
		/* funReset(); */
	}
	
	function funFocus(){
		$('#jqxBankReconciliationDate').jqxDateTimeInput('focus'); 	    		
	}
	
	function funNotify(){	
	 
	  /* Validation */
		var reconciledate = $('#jqxBankReconciliationDate').jqxDateTimeInput('getDate');
		var validdate=funDateInPeriod(reconciledate);
		if(parseInt(validdate)==0){
			document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
			return 0;	
		}
		
		document.getElementById("errormsg").innerText="";
		$('#jqxBankReconciliation').jqxGrid('clearfilters', true);  	
	/* Validation Ends*/
			
		 /*Bank Reconciliation Grid  Saving*/
		 var rows = $("#jqxBankReconciliation").jqxGrid('getrows');
	 		$('#gridlength').val(rows.length);
	 		for(var i=0 ; i < rows.length ; i++){
					newTextBox = $(document.createElement("input"))
				    .attr("type", "dil")
				    .attr("id", "test"+i)
				    .attr("name", "test"+i)
				    .attr("hidden", "true");
				
				var amount;
				if((rows[i].cr!=null) && (rows[i].cr!='undefined') &&  (rows[i].cr!='NaN') && (rows[i].cr!="") && (rows[i].cr!=0)){
					 amount=rows[i].cr;
				}
				if((rows[i].dr!=null) && (rows[i].dr!='undefined') && (rows[i].dr!='NaN') && (rows[i].dr!="") && (rows[i].dr!=0)){
					 amount=rows[i].dr;
				}
					
				newTextBox.val(rows[i].chk+":: "+rows[i].c_date+":: "+amount+":: "+rows[i].tranid+":: "+rows[i].date+":: "+rows[i].doc_no+":: "+rows[i].dtype+":: "+rows[i].chqno+":: "+rows[i].chqdt+":: "+rows[i].dr+":: "+rows[i].cr+":: "+rows[i].ref_detail+":: "+rows[i].description+":: "+rows[i].party);
				newTextBox.appendTo('form');
				
				} 
	 		   /*Bank Reconciliation Grid  Saving Ends*/	
	 		   
	 		   $('#jqxBankReconciliationDate').jqxDateTimeInput({disabled: false});
		   	   $('#cmbbranch').attr('disabled', false);
		  	   $('#cmbcurrency').attr('disabled', false);
	 		   
			return 1;
	} 
	
	
	function setValues(){
		var date = $('#jqxBankReconciliationDate').val();
	    getCurrencyId(date);getBranch();
		
		if($('#hidjqxBankReconciliationDate').val()){
			 $("#jqxBankReconciliationDate").jqxDateTimeInput('val', $('#hidjqxBankReconciliationDate').val());
		  }
	 
		if($('#hidmaindate').val()){
			 $("#maindate").jqxDateTimeInput('val', $('#hidmaindate').val());
		  }
		
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		 
		 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		 funSetlabel();
		 
		  if(document.getElementById("lblformposted").innerText.trim()!=""){
			    $('#btnEdit').attr('disabled', true );
		  } else {
			    $('#btnEdit').attr('disabled', false );
		  }
		 
		 var accId = document.getElementById("txtdocno").value;
		 if(accId>0){
			 funloadappliedgrid();
		 }
		 funRoundAmt($('#txtbookbalance').val(),"txtbookbalance");
         funRoundAmt($('#txtunclrpayments').val(),"txtunclrpayments");
	     funRoundAmt($('#txtunclrreceipts').val(),"txtunclrreceipts");
	     funRoundAmt($('#txtbankbalance').val(),"txtbankbalance"); 
	}
	
	function funloadappliedgrid(){

		$("#jqxBankReconciliation").jqxGrid({ disabled: false});
		  var date=document.getElementById("jqxBankReconciliationDate").value;
		  var accId = document.getElementById("txtdocno").value;
		  var docno = document.getElementById("docno").value;
		  var mode = document.getElementById("mode").value;
		  var brch = document.getElementById("cmbbranch").value;
		  var check = 1;
		  
		  $("#overlay, #PleaseWait").show();
		  
		  $("#jqxBankReconciliationGrid").load('bankReconciliationGrid.jsp?accountno='+accId+'&date='+date+'&docno='+docno+'&mode='+mode+'&check='+check+'&brch='+brch); 
	}
	
	function funExcelBtn(){
		 JSONToCSVCon(dataExcelExport, 'Bank Reconciliation', true);
	 }
	
	function funPrintBtn() {
		
		if (($("#mode").val() == "view") && $("#docno").val()!="") {
			
			 var url=document.URL;
		     var reurl=url.split("saveBankReconciliation");
		     $("#docno").prop("disabled", false);
			
				   $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
					if (r){
						 var win= window.open(reurl[0]+"printBankReconciliation?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					     win.focus();
					 }
					else{
						var win= window.open(reurl[0]+"printBankReconciliation?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					    win.focus();
					}
				   });
	     }
	    else {
			$.messager.alert('Message','Select a Document....!','warning');
			return;
		}
	  }
	
	function datechange(){
		  var date = $('#jqxBankReconciliationDate').jqxDateTimeInput('getDate');
		  $("#maindate").jqxDateTimeInput('val', date);
		  $("#jqxBankReconciliation").jqxGrid('clear'); 
          $("#jqxBankReconciliation").jqxGrid('addrow', null, {});
          $("#jqxBankReconciliation").jqxGrid({ disabled: true});
          $('#txtbookbalance').val('');$('#txtunclrpayments').val('');$('#txtunclrreceipts').val('');$('#txtbankbalance').val('');
		  
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
<div class="receipt-header">
    <div class="cr-row" style="flex-wrap:nowrap; align-items:center; gap:18px;">

        <!-- Account ID -->
        <label>Account</label>
        <input type="text"
               id="txtaccid"
               name="txtaccid"
               placeholder="Press F3 to Search"
               style="width:180px;"
               value='<s:property value="txtaccid"/>'
               onkeydown="getAcc(event);" />

        <!-- Account Name -->
        <input type="text"
               id="txtaccname"
               name="txtaccname"
               style="width:260px;"
               value='<s:property value="txtaccname"/>' />
        <input type="hidden" id="txtdocno" name="txtdocno"
               value='<s:property value="txtdocno"/>' />

        <!-- From -->
        <label for="jqxFromDate" style="margin-left:20px;">From</label>
        <div id="jqxFromDate" style="width:140px;"></div>
        <input type="hidden" id="hidjqxFromDate" name="hidjqxFromDate"
               value='<s:property value="hidjqxFromDate"/>' />

        <!-- To -->
        <label for="jqxToDate">To</label>
        <div id="jqxToDate" style="width:140px;"></div>
        <input type="hidden" id="hidjqxToDate" name="hidjqxToDate"
               value='<s:property value="hidjqxToDate"/>' />

        <!-- Type -->
        <label for="cmbtype" style="margin-left:20px;">Type</label>
        <select id="cmbtype"
                name="cmbtype"
                style="width:160px;"
                onchange="funPostingGrid();"
                value='<s:property value="cmbtype"/>'>
            <option value="0">--Select--</option>
            <option value="1">For Distribution</option>
            <option value="2">Summary</option>
            <option value="3">To be Posted</option>
        </select>
        <input type="hidden" id="hidcmbtype" name="hidcmbtype"
               value='<s:property value="hidcmbtype"/>' />

        <!-- Submit -->
        <button class="myButton"
                type="button"
                id="btnSubmit"
                name="btnSubmit"
                style="margin-left:20px;"
                onclick="funloadgrid();">
            Submit
        </button>

    </div>
</div>

</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmBankReconciliation" action="saveBankReconciliation" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div  class='hidden-scrollbar receipt-header'>
    <div class="table-section">
<table class="cr-table" width="100%">
  <tr>
    <td width="5%" align="right">Date</td>
    <td width="13%"><div id="jqxBankReconciliationDate" name="jqxBankReconciliationDate" onchange="datechange();" value='<s:property value="jqxBankReconciliationDate"/>'></div>
    <input type="hidden" id="hidjqxBankReconciliationDate" name="hidjqxBankReconciliationDate" value='<s:property value="hidjqxBankReconciliationDate"/>'/></td>
    <td width="10%" align="right">Branch</td>
    <td width="20%"><select id="cmbbranch" name="cmbbranch" style="width:50%;" value='<s:property value="cmbbranch"/>'>
    <option></option></select>
    <input type="hidden" id="hidcmbbranch" name="hidcmbbranch" value='<s:property value="hidcmbbranch"/>'/></td>
    <td width="12%" align="right">Currency</td>
    <td width="14%"><select id="cmbcurrency" name="cmbcurrency" style="width:50%;" value='<s:property value="cmbcurrency"/>' onload="getRatevalue(this.value);">
      <option></option></select>
      <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency" value='<s:property value="hidcmbcurrency"/>'/>
      <input type="hidden" id="hidcurrencytype" name="hidcurrencytype" value='<s:property value="hidcurrencytype"/>'/>
      <input type="hidden" id="txtrate" name="txtrate" value='<s:property value="txtrate"/>'/>
      <i><b><label id="lblformposted"  name="lblformposted"   style="font-size: 1px;font-family: Tahoma; color:#E0ECF8"><s:property value="lblformposted"/></label></b></i></td>
    <td width="14%" align="right">Doc No</td>
    <td width="12%"><input type="text" id="docno" name="txtbankreconciliationdocno" style="width:70%;" value='<s:property value="txtbankreconciliationdocno"/>' tabindex="-1"/></td>
  </tr>
  <tr>
    <td align="right">Account</td>
    <td><input type="text" id="txtaccid" name="txtaccid" style="width:80%;" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>' onkeydown="getAcc(event);"/></td>
    <td colspan="2"><input type="text" id="txtaccname" name="txtaccname" style="width:90%;" value='<s:property value="txtaccname"/>'/>
    <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/></td>
    <td align="right">Description</td>
    <td colspan="2"><input type="text" id="txtdescription" name="txtdescription" style="width:90%;" value='<s:property value="txtdescription"/>'/></td>
    <td align="center"><button class="myButton" type="button" id="btnSubmit" name="btnSubmit" onclick="getLastReconcileDate($('#jqxBankReconciliationDate').val(),$('#txtdocno').val());">Submit</button></td>
  </tr>
</table></div>

    <h3>Applying</h3>
    <div class="cr-table" id="jqxBankReconciliationGrid"><jsp:include page="bankReconciliationGrid.jsp"></jsp:include></div>


<div class="table-section">
<table class="cr-table" width="100%">
  <tr>
    <td align="right">Book Balance</td>
    <td><input type="text" id="txtbookbalance" name="txtbookbalance" style="text-align: right;" value='<s:property value="txtbookbalance"/>' tabindex="-1" onblur="funRoundAmt(this.value,this.id);" /></td>
    <td align="right">Uncleared Payments(+ve)</td>
    <td><input type="text" id="txtunclrpayments" name="txtunclrpayments" style="text-align: right;" value='<s:property value="txtunclrpayments"/>' tabindex="-1" onblur="funRoundAmt(this.value,this.id);"/></td>
    <td align="right">Uncleared Receipts(-ve)</td>
    <td><input type="text" id="txtunclrreceipts" name="txtunclrreceipts" style="text-align: right;" value='<s:property value="txtunclrreceipts"/>' tabindex="-1" onblur="funRoundAmt(this.value,this.id);"/></td>
    <td align="right">Bank St. Balance</td>
    <td><input type="text" id="txtbankbalance" name="txtbankbalance" style="text-align: right;" value='<s:property value="txtbankbalance"/>' tabindex="-1" onblur="funRoundAmt(this.value,this.id);"/></td>
  </tr>
</table>
</div>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="txttrno" name="txttrno"  value='<s:property value="txttrno"/>'/>
<input type="hidden" name="txtforsearch" id="txtforsearch" value='<s:property value="txtforsearch"/>'>
<div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
<input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
<input type="hidden" name="txtchkgridload" id="txtchkgridload" value='<s:property value="txtchkgridload"/>'>

</div>
</form>
	
<div id="accountDetailsFromWindow">
	<div></div><div></div>
</div>  

</div>
</body>
</html>