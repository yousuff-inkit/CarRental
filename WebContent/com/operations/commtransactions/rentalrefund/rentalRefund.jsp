<%@ page contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="ISO-8859-1">
<title>GatewayERP(i) - Rental Refund</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<link rel="stylesheet" href="<%=contextPath%>/css/global.css" type="text/css">
<%
	String mod = request.getParameter("mod")==null?"":request.getParameter("mod").toString();
	String acno = request.getParameter("acno")==null || request.getParameter("acno")==""?"0":request.getParameter("acno").toString();
	String client = request.getParameter("client")==null?"":request.getParameter("client").toString();
	String cldocno = request.getParameter("cldocno")==null || request.getParameter("cldocno").equals("")?"0":request.getParameter("cldocno").toString();
	String account = request.getParameter("account")==null?"":request.getParameter("account").toString();
	String agmttype = request.getParameter("agmttype")==null?"":request.getParameter("agmttype").toString();
	String agmtvocno = request.getParameter("agmtvocno")==null?"":request.getParameter("agmtvocno").toString();
	String agmtdocno = request.getParameter("agmtdocno")==null?"":request.getParameter("agmtdocno").toString();
	String amount = request.getParameter("amount")==null || request.getParameter("amount").equals("")?"0":request.getParameter("amount").toString();
	String remarks = request.getParameter("remarks")==null?"":request.getParameter("remarks").toString();
	String cnrdocno = request.getParameter("cnrdocno")==null || request.getParameter("cnrdocno").equals("")?"0":request.getParameter("cnrdocno").toString();
%>
<script type="text/javascript">
var mod1 = '<%=mod%>';
$(document).ready(function() {
	$("#jqxRentalRefundDate").jqxDateTimeInput({ width: '100%', height: 44, formatString:"dd.MM.yyyy"});
	$("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	$("#jqxReferenceDate").jqxDateTimeInput({ width: '100%', height: 44, formatString:"dd.MM.yyyy"});
	$('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%', maxHeight: '70%', maxWidth: '51%', title: 'Accounts Search', position: { x: 300, y: 87 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	$('#accountDetailsWindow').jqxWindow('close');
	$('#agreementDetailsWindow').jqxWindow({width: '51%', height: '58%', maxHeight: '70%', maxWidth: '51%', title: 'Agreement Search', position: { x: 300, y: 87 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	$('#agreementDetailsWindow').jqxWindow('close');
	$('#clientDetailsWindow').jqxWindow({width: '51%', height: '58%', maxHeight: '70%', maxWidth: '51%', title: 'Client Search', position: { x: 300, y: 87 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	$('#clientDetailsWindow').jqxWindow('close');
	$('#cardDetailsWindow').jqxWindow({width: '51%', height: '58%', maxHeight: '70%', maxWidth: '51%', title: 'Card Search', position: { x: 300, y: 87 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	$('#cardDetailsWindow').jqxWindow('close');
	$('#printWindow').jqxWindow({width: '31%', height: '28%', maxHeight: '70%', maxWidth: '31%', title: 'Print', position: { x: 400, y: 87 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	$('#printWindow').jqxWindow('close');
	$('#txtaccid').dblclick(function(){
		var date = $('#jqxRentalRefundDate').jqxDateTimeInput('getDate');
		$("#maindate").jqxDateTimeInput('val', date);
		accountSearchContent(<%=contextPath+"/"%>+"com/operations/accountsDetailsSearch.jsp?date="+date);
	});
	$('#txtagreementvocher').dblclick(function(){
		agreementSearchContent('agreementSearch.jsp?clientId='+$('#txtcldocno').val());
	});
	$('#txtclientid').dblclick(function(){
		var date = $('#jqxRentalRefundDate').jqxDateTimeInput('getDate');
		$("#maindate").jqxDateTimeInput('val', date);
		clientSearchContent(<%=contextPath+"/"%>+"com/operations/clientAccountDetailsSearch.jsp?atype=AR"+"\&date="+date);
		$('#txtforsearch').val(1);
	});
});
function accountSearchContent(url) {
	$('#accountDetailsWindow').jqxWindow('open');
	$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	});
}
function agreementSearchContent(url) {
	$('#agreementDetailsWindow').jqxWindow('open');
	$.get(url).done(function (data) {
		$('#agreementDetailsWindow').jqxWindow('setContent', data);
		$('#agreementDetailsWindow').jqxWindow('bringToFront');
	});
}
function clientSearchContent(url) {
	$('#clientDetailsWindow').jqxWindow('open');
	$.get(url).done(function (data) {
		$('#clientDetailsWindow').jqxWindow('setContent', data);
		$('#clientDetailsWindow').jqxWindow('bringToFront');
	});
}
function cardSearchContent(url) {
	$('#cardDetailsWindow').jqxWindow('open');
	$.get(url).done(function (data) {
		$('#cardDetailsWindow').jqxWindow('setContent', data);
		$('#cardDetailsWindow').jqxWindow('bringToFront');
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
			var optionsbranch = '<option value="">--Select--</option>';
			for (var i = 0; i < branchItems.length; i++) {
				optionsbranch += '<option value="' + branchIdItems[i].trim() + '">' + branchItems[i] + '</option>';
			}
			$("select#cmbbranch").html(optionsbranch);
			if ($('#hidcmbbranch').val() != null) {
				$('#cmbbranch').val($('#hidcmbbranch').val());
			}
		}
	}
	x.open("GET", <%=contextPath+"/"%>+"com/operations/commtransactions/getBranch.jsp", true);
	x.send();
}
function getCardTypes() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items = items.split('####');
			var cardIdItems  = items[0].split(",");
			var cardItems = items[1].split(",");
			var optionscard = '<option value="">--Select--</option>';
			for (var i = 0; i < cardItems.length; i++) {
				optionscard += '<option value="' + cardIdItems[i].trim() + '">' + cardItems[i] + '</option>';
			}
			$("select#cmbcardtype").html(optionscard);
			if ($('#hidcmbcardtype').val() != null) {
				$('#cmbcardtype').val($('#hidcmbcardtype').val());
			}
		}
	}
	x.open("GET", "getCardTypes.jsp", true);
	x.send();
}
function getPayTypes() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items = items.split('####');
			var idItems  = items[0].split(",");
			var nameItems = items[1].split(",");
			var options = '<option value="">--Select--</option>';
			for (var i = 0; i < nameItems.length; i++) {
				options += '<option value="' + idItems[i].trim() + '">' + nameItems[i] + '</option>';
			}
			$("select#cmbpaytype").html(options);
			if ($('#hidcmbpaytype').val() != null) {
				$('#cmbpaytype').val($('#hidcmbpaytype').val());
			}
		}
	}
	x.open("GET", "getPayTypes.jsp", true);
	x.send();
}
</script>

<style>
html, body { height: 100%; overflow-y: auto; }
body::-webkit-scrollbar { width: 10px; }
body::-webkit-scrollbar-track { background: #eaf3ff; border-radius: 8px; }
body::-webkit-scrollbar-thumb { background: #4da3ff; border-radius: 8px; border: 2px solid #eaf3ff; }
body::-webkit-scrollbar-thumb:hover { background: #1a73e8; }
.hidden-scrollbar { max-height: 80vh; overflow-y: auto; padding-right: 10px; scrollbar-width: thin; scrollbar-color: #4da3ff #eaf3ff; }
.hidden-scrollbar::-webkit-scrollbar { width: 8px; }
.hidden-scrollbar::-webkit-scrollbar-track { background: #eaf3ff; border-radius: 4px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background-color: #4da3ff; border-radius: 4px; border: 2px solid #eaf3ff; }
.hidden-scrollbar::-webkit-scrollbar-thumb:hover { background-color: #1a73e8; }
body { background: linear-gradient(135deg, #e8f1ff 0%, #d1e4ff 100%); font-family: "Poppins", "Segoe UI", sans-serif; color: #1f2f46; margin: 0; padding: 40px 0; min-height: 100vh; animation: fadeIn 0.6s ease-in-out; box-sizing: border-box; }
#mainBG { background: #f4f8ff; border-radius: 16px; box-shadow: 0 4px 25px rgba(50, 110, 255, 0.15); padding: 25px 30px; max-width: 1250px; margin: 0 auto; transition: 0.3s ease; }
.receipt-header { background: #edf4ff; border: 1px solid #c9dafc; border-radius: 14px; padding: 20px; margin-bottom: 26px; box-shadow: 0 2px 10px rgba(132, 168, 255, 0.2); }
.clean-grid-form { display: grid; grid-template-columns: repeat(3, 1fr); gap: 22px 32px; width: 100%; box-sizing: border-box; align-items: start; }
.clean-grid-item { display: flex; flex-direction: column; }
.clean-grid-item.full { grid-column: span 3; }
.clean-input, .clean-grid-item input[type="text"], .clean-grid-item select, .receipt-header input[type="text"], .receipt-header select { width: 100%; height: 44px; padding: 8px 12px; border: 1px solid #b9ccf2; border-radius: 8px; background: #ffffff; font-size: 0.95rem; color:#1f2f46; box-sizing: border-box; transition: 0.18s ease; }
.clean-input:focus, .receipt-header input[type="text"]:focus, .receipt-header select:focus { border-color: #4da3ff; box-shadow: 0 0 6px rgba(77,163,255,0.35); outline: none; }
#jqxRentalRefundDate, #jqxReferenceDate { width: 100% !important; height: 44px !important; }
#jqxRentalRefundDate input, #jqxReferenceDate input { height: 42px !important; padding-left: 10px !important; border-radius: 8px !important; background-color: #ffffff !important; box-shadow: none !important; }
.cr-table input[type="text"], .cr-table select { width: 100%; height: 40px; padding: 6px 10px; box-sizing: border-box; border-radius: 8px; border: 1px solid #d6e1ff; background: #fff; }
label { font-weight: 600; font-size: 14px; color: #1a2d4d; margin-bottom: 8px; display:block; }
.cr-table { width: 100%; border-collapse: collapse; background: #ffffff; border-radius: 12px; overflow: hidden; box-shadow: 0 2px 12px rgba(100, 140, 255, 0.15); }
.cr-table th, .cr-table td { padding: 10px 12px; border-bottom: 1px solid #d6e1ff; text-align: left; font-size: 0.95rem; color: #1f2f46; vertical-align: middle; }
.cr-table th { background-color: #dcebff; color: #1b3f73; font-weight: 600; }
button, .myButton { background: linear-gradient(90deg, #3b82f6, #1a73e8); color: #fff; border: none; border-radius: 8px; padding: 9px 22px; font-weight: 600; cursor: pointer; transition: 0.25s ease; box-shadow: 0 3px 10px rgba(30, 100, 255, 0.25); }
@keyframes fadeIn { from { opacity: 0; transform: translateY(-5px); } to { opacity: 1; transform: translateY(0); } }
@media (max-width: 900px) { .clean-grid-form { grid-template-columns: repeat(1, 1fr); } .clean-grid-item.full { grid-column: span 1; } }
</style>
</head>

<body onload="setValues();getBranch();getCardTypes();getPayTypes();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmRentalRefund" action="saveRentalRefund" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class="hidden-scrollbar">
  <div class="receipt-header">
    <div class="clean-grid-form">

      <div class="clean-grid-item">
        <label>Date</label>
        <div id="jqxRentalRefundDate" onchange="datechange();" onblur="datechange();"></div>
        <input type="hidden" id="hidjqxRentalRefundDate" name="hidjqxRentalRefundDate" value='<s:property value="hidjqxRentalRefundDate"/>'/>
      </div>

      <div class="clean-grid-item">
        <label>Ref. No.</label>
        <input type="text" id="txtrefno" name="txtrefno" class="clean-input" value='<s:property value="txtrefno"/>'/>
      </div>

      <div class="clean-grid-item">
        <label>Doc No.</label>
        <input type="text" id="docno" name="txtrentalrefunddocno" class="clean-input" value='<s:property value="txtrentalrefunddocno"/>' tabindex="-1"/>
      </div>

      <div class="clean-grid-item">
        <label>Type</label>
        <select id="cmbratype" name="cmbratype" class="clean-input">
          <option value="RAG">Rental</option>
          <option value="LAG">Lease</option>
        </select>
        <input type="hidden" id="hidcmbratype" name="hidcmbratype" value='<s:property value="hidcmbratype"/>'/>
      </div>

      <div class="clean-grid-item">
        <label>Account</label>
        <input type="text" id="txtaccid" name="txtaccid" class="clean-input" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>' onkeydown="getAcc(event);" />
      </div>

      <div class="clean-grid-item">
        <label>Account Name</label>
        <input type="text" id="txtaccname" name="txtaccname" class="clean-input" value='<s:property value="txtaccname"/>' tabindex="-1"/>
      </div>

      <div class="clean-grid-item">
        <label>Branch</label>
        <select id="cmbbranch" name="cmbbranch" class="clean-input" value='<s:property value="cmbbranch"/>' onchange="funIBDateInPeriod($('#jqxRentalRefundDate').val(),this.value);">
          <option value=""></option>
        </select>
        <input type="hidden" id="hidcmbbranch" name="hidcmbbranch" value='<s:property value="hidcmbbranch"/>'/>
      </div>

      <div class="clean-grid-item">
        <label>Pay Type</label>
        <select id="cmbpaytype" name="cmbpaytype" class="clean-input" onchange="bankAccountSearch();funchequedate();getAccounts(this.value);"></select>
        <input type="hidden" id="hidcmbpaytype" name="hidcmbpaytype" value='<s:property value="hidcmbpaytype"/>'/>
      </div>

      <div class="clean-grid-item">
        <label>Card Type</label>
        <select id="cmbcardtype" name="cmbcardtype" class="clean-input" onchange="funclearchequecardno();">
          <option value="">--Select--</option>
        </select>
        <input type="hidden" id="hidcmbcardtype" name="hidcmbcardtype" value='<s:property value="hidcmbcardtype"/>'/>
      </div>

      <div class="clean-grid-item">
        <label>Chq/Card No/Online</label>
        <input type="text" id="txtchequeno" name="txtchequeno" class="clean-input" value='<s:property value="txtchequeno"/>'/>
      </div>

      <div class="clean-grid-item">
        <label>Date</label>
        <div id="jqxReferenceDate" name="jqxReferenceDate"></div>
        <input type="hidden" id="hidjqxReferenceDate" name="hidjqxReferenceDate" value='<s:property value="hidjqxReferenceDate"/>'/>
      </div>

      <div class="clean-grid-item">
        <label>Description</label>
        <input type="text" id="txtdescription" name="txtdescription" class="clean-input" value='<s:property value="txtdescription"/>'/>
      </div>

      <div class="clean-grid-item full">
        <h3 style="margin:0 0 12px 0; color:#1b3f73; font-size:1.02rem; font-weight:600;">Security Details</h3>
        <div class="cr-table" id="jqxSecurityGrid">
          <center><jsp:include page="securityGrid.jsp"></jsp:include></center>
        </div>
      </div>

      <div class="clean-grid-item full">
        <table class="cr-table" width="100%">
          <tr>
            <td style="width:12%; text-align:right;">Amount</td>
            <td style="width:18%;"><input type="text" id="txtamount" name="txtamount" class="clean-input" value='<s:property value="txtamount"/>' onblur="funRoundAmt(this.value,this.id);getNetTotal();"/></td>
            <td style="width:12%; text-align:right;">Deduction</td>
            <td style="width:18%;"><input type="text" id="txtdeduction" name="txtdeduction" class="clean-input" onblur="funRoundAmt(this.value,this.id);getNetTotal();" value='<s:property value="txtdeduction"/>'/></td>
            <td style="width:12%; text-align:right;">Add. Amount</td>
            <td style="width:18%;"><input type="text" id="txtaddamount" name="txtaddamount" class="clean-input" value='<s:property value="txtaddamount"/>' onblur="funRoundAmt(this.value,this.id);getNetTotal();"/></td>
          </tr>
          <tr>
            <td style="width:12%; text-align:right;">Net Amount</td>
            <td style="width:18%;"><input type="text" id="txtnetamount" name="txtnetamount" class="clean-input" value='<s:property value="txtnetamount"/>' tabindex="-1"/></td>
            <td style="width:12%; text-align:right;">On Account Amount</td>
            <td style="width:18%;"><input type="text" id="txtonaccountamount" name="txtonaccountamount" class="clean-input" onblur="funRoundAmt(this.value,this.id);" value='<s:property value="txtonaccountamount"/>'/></td>
            <td style="width:12%; text-align:right;">Paid To</td>
            <td style="width:18%;"><input type="text" id="txtpaidto" name="txtpaidto" class="clean-input" value='<s:property value="txtpaidto"/>'/></td>
          </tr>
          <tr>
            <td style="width:12%; text-align:right;">Description</td>
            <td colspan="5"><input type="text" id="txtdescriptions" name="txtdescriptions" class="clean-input" value='<s:property value="txtdescriptions"/>'/></td>
          </tr>
        </table>
      </div>

    </div>
  </div>
</div>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
<input type="hidden" name="txtforsearch" id="txtforsearch" value='<s:property value="txtforsearch"/>'/>
<div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
<input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
<input type="hidden" name="txtvalidation" id="txtvalidation" value='<s:property value="txtvalidation"/>'/>
<input type="hidden" id="txtibvalidation" name="txtibvalidation" value='<s:property value="txtibvalidation"/>'/>
<input type="hidden" id="applylength" name="applylength"/>
<input type="hidden" id="applylengthupdate" name="applylengthupdate"/>
<input type="hidden" id="cnrdocno" name="cnrdocno" value='<s:property value="cnrdocno"/>'/>
</form>

<div id="agreementDetailsWindow"><div></div><div></div></div>
<div id="clientDetailsWindow"><div></div><div></div></div>
<div id="accountDetailsWindow"><div></div><div></div></div>
<div id="cardDetailsWindow"><div></div><div></div></div>
<div id="printWindow"><div></div><div></div></div>

</div>
</body>
</html>
