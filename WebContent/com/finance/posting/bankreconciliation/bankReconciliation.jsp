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
</style>
<style>
/* =========================================================
   MODERN ERP LAYOUT - EXACT ALIGNMENT & FULL WIDTH GRID 
   (Fuses tight horizontal alignment with modern clean UI)
========================================================= */
body {
    background: #f4f6f9;
    font-family: Arial, sans-serif;
    color: #333;
    font-size: 12px;
    margin: 0;
    padding: 10px;
    box-sizing: border-box;
}

#mainBG {
    background: #fff;
    border-radius: 4px;
    padding: 15px;
    max-width: 100%;
    margin: auto;
    box-shadow: 0 1px 4px rgba(0,0,0,0.1);
    box-sizing: border-box;
}

/* Master Input Heights - Set to 24px as requested */
input[type="text"], select {
    height: 24px !important;
    border: 1px solid #ccc;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box;
    width: 100%;
    background-color: #fff;
    color: #333;
}

input[type="text"]:focus, select:focus {
    border-color: #007bff;
    outline: none;
}

/* Clean Panels mapping to fieldsets */
fieldset {
    border: 1px solid #e1e4e8;
    background-color: #fff;
    margin-bottom: 10px;
    padding: 12px 10px 10px 10px;
    border-radius: 4px;
}

legend {
    font-size: 13px;
    font-weight: bold;
    color: #0056b3;
    padding: 0 0 0 6px;
    border-left: 3px solid #0056b3;
    margin-bottom: 5px;
}

/* Strict Full-Width CSS Grid for Top Section */
.top-grid {
    display: grid;
    /* 5 strict columns + inputs. Stretches perfectly across. */
    grid-template-columns: 80px minmax(100px, 1fr) 70px minmax(100px, 1fr) 50px minmax(150px, 2fr) 110px minmax(100px, 1fr) 90px minmax(100px, 1fr);
    column-gap: 8px;
    row-gap: 8px;
    align-items: center;
    width: 100%;
    margin-bottom: 15px;
}

.top-grid > label {
    text-align: right;
    color: #444;
    font-size: 12px;
    font-weight: bold;
    white-space: nowrap;
}

.flex-row {
    display: flex;
    align-items: center;
    gap: 5px;
    width: 100%;
}

.chk-container {
    display: flex;
    align-items: center;
    gap: 4px;
    cursor: pointer;
    color: #444;
    font-size: 12px;
    font-weight: bold;
    white-space: nowrap;
}

.chk-container input {
    margin: 0;
    padding: 0;
}

/* Middle Section Split */
.middle-section {
    display: flex;
    gap: 10px;
    margin-bottom: 10px;
}

.middle-panel {
    border: 1px solid #e1e4e8;
    padding: 15px 10px 10px 10px;
    background: #fff;
    position: relative;
    border-radius: 4px;
}

.middle-panel-title {
    position: absolute;
    top: -10px;
    left: 10px;
    background: #fff;
    padding: 0 5px 0 6px;
    color: #0056b3;
    font-weight: bold;
    font-size: 13px;
    border-left: 3px solid #0056b3;
}

/* Clean Tables mapping requested colors */
.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #fff;
    border: 1px solid #ddd;
}
.cr-table th, .cr-table td {
    padding: 4px 6px;
    border: 1px solid #ddd;
    font-size: 12px;
}
.cr-table th {
    background: #f0f3f5;
    font-weight: bold;
    color: #333;
    text-align: left;
}
.lbl-right {
    text-align: right;
    color: #444;
    font-weight: bold;
    font-size: 12px;
    padding-right: 5px;
}

/* Tabs Override */
#tabs { margin-top: 5px; margin-bottom: 0px; }
#content { padding-top: 10px; }

</style>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmBankReconciliation" action="saveBankReconciliation" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div  class='hidden-scrollbar'>
<table width="100%">
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
</table>
<fieldset><legend>Applying</legend>
<div id="jqxBankReconciliationGrid"><jsp:include page="bankReconciliationGrid.jsp"></jsp:include></div></fieldset><br/>
<table width="100%">
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