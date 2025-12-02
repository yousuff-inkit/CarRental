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
/* Scroll area */
.hidden-scrollbar {
    overflow: auto;
    height: 530px;
}

/* Page background */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    margin: 0;
    padding: 32px 0;
    min-height: 100vh;
    color: #222;
}

/* Main page area */
#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 10px;
    max-width: 1200px;
    margin: 0 auto;
}

/* ---------------------------------------
   TOP SECTION INPUTS / SELECTS / DATE
----------------------------------------*/

.top-section input[type="text"],
.top-section select,
.top-section .jqx-datetimeinput,
.top-section .jqx-datetimeinput input {
    height: 34px !important;
    line-height: 34px !important;
    padding: 0 10px !important;
    font-size: 14px;
    border-radius: 8px !important;
    border: 1px solid #d1d5db !important;
    background: #fff !important;
    box-sizing: border-box;
}

/* jqx date alignment */
.jqx-datetimeinput,
.jqx-datetimeinput input {
    height: 34px !important;
    padding-left: 10px !important;
    border-radius: 8px !important;
}

/* Calendar icon centering */
.jqx-icon-calendar {
    margin-top: 6px !important;
}

/* Remove Chrome pink autofill */
input:-webkit-autofill,
input:-webkit-autofill:hover,
input:-webkit-autofill:focus {
    -webkit-box-shadow: 0 0 0 1000px white inset !important;
    box-shadow: 0 0 0 1000px white inset !important;
    -webkit-text-fill-color: #000 !important;
}

/* ---------------------------------------
   FORM GRID LAYOUT
----------------------------------------*/

.form-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 22px;
    align-items: end !important; /* Align submit button with Description */
    margin-bottom: 14px;
}

/* Labels */
.form-item label {
    font-size: 14px;
    font-weight: 600;
    color: #1f2f46;
    margin-bottom: 4px;
}

/* Inputs inside grid */
.form-item input,
.form-item select,
.form-item div.jqx-widget {
    height: 34px !important;
    width: 100% !important;
    border: 1px solid #d1d5db !important;
    border-radius: 8px !important;
    padding: 6px 10px;
    background: #fff;
    font-size: 14px;
}

/* Submit button */
.myButton {
    height: 34px !important;
    width: 100%;
}

/* Row width adjustments */
.form-grid.first-row .form-item > * {
    width: 90% !important;
}
.form-grid.second-row .form-item > * {
    width: 95% !important;
}

/* ---------------------------------------
   DROPDOWN UPGRADED FONT SIZE
----------------------------------------*/

#cmbbranch,
#cmbcurrency {
    font-size: 18px !important;
    height: 34px !important;
    padding-left: 10px !important;
}

#cmbbranch option,
#cmbcurrency option {
    font-size: 18px !important;
}

/* ---------------------------------------
   BLUE BORDER ON FOCUS
----------------------------------------*/

input,
select,
.jqx-datetimeinput,
.jqx-datetimeinput input {
    border: 1px solid #d1d5db !important;
    border-radius: 8px !important;
    transition: border-color 0.2s, box-shadow 0.2s;
}

input:focus,
select:focus,
.jqx-datetimeinput:focus,
.jqx-datetimeinput input:focus {
    border-color: #3b82f6 !important;
    box-shadow: 0 0 0 2px rgba(59,130,246,0.25) !important;
    outline: none !important;
}

/* ---------------------------------------
   TABLE STYLE (Applying + Summary)
----------------------------------------*/

.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #f9fafb;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 0 0 1px #eef0f6;
}

.cr-table th,
.cr-table td {
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

/* Space below top bar */
.after-top-bar-gap {
    height: 22px;
}
/* Default input appearance */
input,
select,
.jqx-datetimeinput,
.jqx-datetimeinput input {
    border: 1px solid #d1d5db !important;   /* light grey */
    border-radius: 8px !important;
    outline: none !important;
    box-shadow: none !important;
    transition: border-color 0.2s, box-shadow 0.2s;
}

/* Blue border on focus */
input:focus,
select:focus,
.jqx-datetimeinput:focus,
.jqx-datetimeinput input:focus {
    border-color: #3b82f6 !important;   /* modern blue */
    box-shadow: 0 0 0 2px rgba(59,130,246,0.25) !important; /* soft blue glow */
    outline: none !important;
}
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmBankReconciliation" action="saveBankReconciliation" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div class="top-section">
<div class="top-form">

    <!-- FIRST ROW -->
    <div class="form-grid first-row">

        <div class="form-item">
            <label>Date</label>
            <div id="jqxBankReconciliationDate"></div>
        </div>

        <div class="form-item">
            <label>Branch</label>
            <select id="cmbbranch" name="cmbbranch"></select>
        </div>

        <div class="form-item">
            <label>Currency</label>
            <select id="cmbcurrency" name="cmbcurrency"></select>
        </div>

        <div class="form-item">
            <label>Doc No</label>
            <input type="text" id="docno">
        </div>

    </div>

    <!-- SECOND ROW -->
    <div class="form-grid second-row">

        <div class="form-item">
            <label>Account</label>
            <input type="text" id="txtaccid" placeholder="Press F3 to Search">
        </div>

        <div class="form-item">
            <label>Account Name</label>
            <input type="text" id="txtaccname">
        </div>

        <div class="form-item">
            <label>Description</label>
            <input type="text" id="txtdescription">
        </div>

        <div class="form-item">
            <label>&nbsp;</label>
            <button class="myButton" id="btnSubmit">Submit</button>
        </div>

    </div>

</div>

	<div class="after-top-bar-gap"></div>
	

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