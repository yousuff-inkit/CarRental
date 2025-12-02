<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
.hidden-scrollbar {
  overflow-y: auto;
  height: 530px;
  scrollbar-width: thin;
  scrollbar-color: #4da3ff #eaf3ff;
}
.hidden-scrollbar::-webkit-scrollbar { width: 7px; }
.hidden-scrollbar::-webkit-scrollbar-thumb {
  background-color: #4da3ff;
  border-radius: 8px;
}
.hidden-scrollbar::-webkit-scrollbar-thumb:hover {
  background-color: #1a73e8;
}

body {
  background: linear-gradient(135deg, #e8f1ff 0%, #d1e4ff 100%);
  font-family: "Poppins", "Segoe UI", Arial, sans-serif;
  color: #1f2f46;
  margin: 0;
  padding: 40px 0;
  min-height: 100vh;
  box-sizing: border-box;
}

#mainBG {
  background: #f4f8ff;
  border-radius: 16px;
  box-shadow: 0 4px 25px rgba(50,110,255,0.15);
  padding: 25px 30px;
  max-width: 1250px;
  margin: 0 auto;
  transition: 0.3s ease;
}
#mainBG:hover {
  box-shadow: 0 8px 35px rgba(30,100,255,0.25);
}

.receipt-header {
  background: #edf4ff;
  border: 1px solid #c9dafc;
  border-radius: 14px;
  padding: 20px;
  margin-bottom: 26px;
  box-shadow: 0 2px 10px rgba(132,168,255,0.2);
  font-size: 14px;
}

.receipt-header label {
  font-weight: 600;
  color: #1a2d4d;
  margin-right: 8px;
}

.status {
  color: #d62828;
  font-weight: 600;
  font-size: 0.9rem;
}

#lblclientstatus {
  -moz-animation-duration: 1s;
  -moz-animation-name: blink;
  -moz-animation-iteration-count: infinite;
  -moz-animation-direction: alternate;
  -webkit-animation-duration: 1s;
  -webkit-animation-name: blink;
  -webkit-animation-iteration-count: infinite;
  -webkit-animation-direction: alternate;
  animation-duration: 1s;
  animation-name: blink;
  animation-iteration-count: infinite;
  animation-direction: alternate;
}
@-moz-keyframes blink { from { opacity: 1; } to { opacity: 0; } }
@-webkit-keyframes blink { from { opacity: 1; } to { opacity: 0; } }
@keyframes blink { from { opacity: 1; } to { opacity: 0; } }

.section-row {
  display: flex;
  gap: 22px;
  margin-bottom: 24px;
  flex-wrap: wrap;
}

.section-block {
  flex: 1;
  min-width: 320px;
  background: #f4f8ff;
  border-radius: 12px;
  padding: 20px 18px;
  box-shadow: 0 1px 8px rgba(132,168,255,0.18);
  border: 1px solid #c9dafc;
}

.section-block h2 {
  font-size: 1rem;
  font-weight: 600;
  margin: 0 0 14px 0;
  color: #1b3f73;
}

.section-block .form-group {
  display: flex;
  align-items: center;
  gap: 14px;
  margin-bottom: 12px;
  flex-wrap: wrap;
}

.section-block label {
  min-width: 110px;
  text-align: right;
  font-weight: 600;
  color: #1a2d4d;
  font-size: 14px;
}

.textbox, .section-block input[type="text"],
.section-block select,
.receipt-header input[type="text"],
.receipt-header select {
  border: 1px solid #b9ccf2;
  border-radius: 8px;
  padding: 10px 12px;
  font-size: 1rem;
  background: #ffffff;
  color: #1f2f46;
  transition: 0.25s ease;
  box-sizing: border-box;
}

.section-block input[type="text"]:focus,
.section-block select:focus,
.receipt-header input[type="text"]:focus,
.receipt-header select:focus {
  border-color: #4da3ff;
  outline: none;
  box-shadow: 0 0 6px rgba(77,163,255,0.55);
}

.section-block input[type="text"],
.section-block select {
  flex: 1;
}

.section-block input[type="checkbox"] {
  transform: scale(1.05);
  accent-color: #3b82f6;
}

.table-section {
  margin-bottom: 18px;
}

.table-section h3 {
  color: #1b3f73;
  font-size: 1.04em;
  font-weight: 600;
  margin-bottom: 10px;
}

.cr-table {
  width: 100%;
  border-collapse: collapse;
  background: #ffffff;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 2px 12px rgba(100,140,255,0.15);
}

.cr-table th,
.cr-table td {
  padding: 14px 12px;
  border-bottom: 1px solid #d6e1ff;
  text-align: left;
  font-size: 0.95rem;
  color: #1f2f46;
}

.cr-table th {
  background-color: #dcebff;
  color: #1b3f73;
  font-weight: 600;
}

.cr-table tr:hover td {
  background-color: #eef5ff;
  transition: 0.25s;
}

button,
input[type="button"],
input[type="submit"],
.myButton {
  background: linear-gradient(90deg, #3b82f6, #1a73e8);
  color: #ffffff;
  border: none;
  border-radius: 8px;
  padding: 10px 20px;
  font-weight: 600;
  cursor: pointer;
  transition: 0.25s ease;
  box-shadow: 0 3px 10px rgba(30,100,255,0.25);
  font-size: 0.95rem;
}

button:hover,
input[type="button"]:hover,
input[type="submit"]:hover,
.myButton:hover {
  background: linear-gradient(90deg, #1a73e8, #155cc6);
  transform: translateY(-2px);
}

button:active,
input[type="button"]:active,
input[type="submit"]:active,
.myButton:active {
  transform: scale(0.96);
}

input[type="text"]::-moz-selection { background: #cfe2ff; color: #000000; }
input[type="text"]::selection { background: #cfe2ff; color: #000000; }

@media (max-width: 900px) {
  .section-row { flex-direction: column; }
  .section-block { width: 100%; }
}
</style>

<script type="text/javascript">
$(document).ready(function () { 
	$('#btnClose').attr('disabled', true );$('#btnCreate').attr('disabled', true );$('#btnEdit').attr('disabled', true );$('#btnExcel').attr('disabled', true );
	$('#btnDelete').attr('disabled', true );$('#btnSearch').attr('disabled', true );$('#btnAttach').attr('disabled', true );$('#btnPrint').attr('disabled', true );
	
	$("#jqxNonFinancialDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	$("#jqxClientReviewDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	
	$('#clientWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Clients Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true });
	$('#clientWindow').jqxWindow('close');
	
	$('#nonFinancialWindow').jqxWindow({width: '51%', height: '28%',  maxHeight: '30%' ,maxWidth: '51%' , title: 'Non-Financial Comments',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true });
	$('#nonFinancialWindow').jqxWindow('close');
	
	document.getElementById("hidchckdetailed").value = 0;
	getIDPDetails();
	
	$('#txtclientname').dblclick(function(){
		clientSearchContent('clientDetailsSearch.jsp');
	});
});

function clientSearchContent(url) {
    $('#clientWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#clientWindow').jqxWindow('setContent', data);
	$('#clientWindow').jqxWindow('bringToFront');
}); 
}

function nonFinancialCommentsContent(url) {
    $('#nonFinancialWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#nonFinancialWindow').jqxWindow('setContent', data);
	$('#nonFinancialWindow').jqxWindow('bringToFront');
}); 
}

function getIDPDetails(){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
		    $('#idpdetailsallowed').val(items);
		}
	}
	x.open("GET", "getIDPDetailsAllowed.jsp", true);
	x.send();
}

function getAccountBalance(a,b){
 	var x = new XMLHttpRequest();
 	x.onreadystatechange = function() {
 		if (x.readyState == 4 && x.status == 200) {
 			var items = x.responseText;
 			items = items.split('####');
 		    $('#txtbalance').val(items[0]);
 		    $('#lblclientstatus').html(items[1]);
 		}
 	}
 	x.open("GET", "getAccountBalance.jsp?accountno="+a+'&cldocno='+b, true);
 	x.send();
 }

function getAcc(event){
    var x= event.keyCode;
    if(x==114){
    	clientSearchContent('clientDetailsSearch.jsp');
    }
    else{}
    }

function funDetailed(){
	 if(document.getElementById("chckdetailed").checked){
		 $.messager.confirm('Confirm', 'Do you want to have detailed informations?', function(r){
				if (r){
					document.getElementById("hidchckdetailed").value = 1;
					var detailed=$('#hidchckdetailed').val();
					var cldocno=$('#txtcldocno').val();
					var accno=$('#txtaccno').val();
					if(cldocno != ""){
					    $("#operationDiv").load("operationGrid.jsp?cldocno="+cldocno+'&detailed='+detailed);
					    $("#driverDiv").load("driverDetailsGrid.jsp?cldocno="+cldocno);
					    $("#quotationDiv").load("quotationGrid.jsp?cldocno="+cldocno);
					    $("#accidentDamageDiv").load("accidentDamageHistoryGrid.jsp?cldocno="+cldocno);
					}
				    if(accno != ""){
					    $("#paymentFollowUpDiv").load("paymentFollowUpGrid.jsp?accountno="+accno+'&cldocno='+cldocno+'&detailed='+detailed);
				    }
				}
				else{
					document.getElementById("chckdetailed").checked = false;
					document.getElementById("hidchckdetailed").value = 0;
				}
		   });
	 } else{
		 document.getElementById("chckdetailed").checked = false;
		 document.getElementById("hidchckdetailed").value = 0;
		 var detailed=$('#hidchckdetailed').val();
		 var cldocno=$('#txtcldocno').val();
		 var accno=$('#txtaccno').val();
		 if(cldocno != ""){
		    $("#operationDiv").load("operationGrid.jsp?cldocno="+cldocno+'&detailed='+detailed);
		    $("#driverDiv").load("driverDetailsGrid.jsp?cldocno="+cldocno);
            $("#quotationDiv").load("quotationGrid.jsp?cldocno="+cldocno);
            $("#accidentDamageDiv").load("accidentDamageHistoryGrid.jsp?cldocno="+cldocno);
         }
         if(accno != ""){
		    $("#paymentFollowUpDiv").load("paymentFollowUpGrid.jsp?accountno="+accno+'&cldocno='+cldocno+'&detailed='+detailed);
         }
	 }
}

function funOutStandingStatement(){
	var accno = $('#txtaccno').val();
	
	if(accno==''){
		 $.messager.alert('Message','Please Choose a Client.','warning');
		 return 0;
	}
	
    if ($("#txtaccno").val()!="") {
        var url=document.URL;
        var reurl=url.split("clientReview.jsp");
        
        $("#txtaccno").prop("disabled", false);
        var win= window.open(reurl[0]+"clientReviewOutstandingsStatement?atype=AR&acno="+document.getElementById("txtaccno").value+'&level1from=0&level1to=30&level2from=31&level2to=60&level3from=61&level3to=90&level4from=91&level4to=120&level5from=121&branch='+document.getElementById("brchName").value+'&uptoDate='+$("#jqxClientReviewDate").val()+'&email=Nil&print=1','_blank','top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes');
        win.focus();
     }
    else {
		$.messager.alert('Message','Account is Mandatory.','warning');
		return;
	}
   }

function funSaveDetails(event){
	var mode = $("#mode").val("A");
	var cldocno = $('#txtcldocno').val();
	var description = $('#txtdescription').val();
	
	if(cldocno==''){
		 $.messager.alert('Message','Choose a Client.','warning');
		 return 0;
	}
		
	    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
	    	
	    	if(r==false)
	    	  {
	    			return false; 
	    	  }
	    	else{
	    		 saveGridData(description,cldocno,mode);	
	    	}
	 });
}

function funDeleteDocu(event){
	var mode = $("#mode").val("D");
	var cldocno = $('#txtcldocno').val();
	
	if(cldocno==''){
		 $.messager.alert('Message','Choose a Client.','warning');
		 return 0;
	}
		
	    $.messager.confirm('Message', 'Do you want to delete?', function(r){
	    	
	    	if(r==false)
	    	  {
	    			return false; 
	    	  }
	    	else{
	    			$('#txtdescription').val('');
	    		$('#txtdescriptions').val('');
	    		var description = 0;
	    		 saveGridData(description,cldocno,mode);	
	    	}
	 });
}

function saveGridData(description,cldocno,mode){
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;
				$.messager.alert('Message', 'Successfully Completed. ', function(r){
				  });
	          funreload(event); 
			}
	}
		
	x.open("GET","saveData.jsp?description="+description+"&cldocno="+cldocno+"&mode="+mode,true);
	x.send();
}

function funAttachButton(){
	if (($("#mode").val() == "view") && $("#txtcldocno").val()!="") {
		$("#windowattach").jqxWindow('setTitle',"CRM - "+document.getElementById("txtcldocno").value);
		
		changeAttachContent("<%=contextPath%>/com/common/attachGrid.jsp?formCode=CRM&docno="+document.getElementById("txtcldocno").value);		
	} else {
		$.messager.alert('Message','Select a Document....!','warning');
		return;
	}
}

function funReadOnly(){
	$('#frmClientReview input').attr('readonly', true );
	$("#financialCommentsGridID").jqxGrid({ disabled: true});
	$("#operationGridID").jqxGrid({ disabled: true});
	$("#quotationGridID").jqxGrid({ disabled: true});
	$("#accidentDamageGridID").jqxGrid({ disabled: true});
	$("#driverGridID").jqxGrid({ disabled: true});
	$("#btnbalance").hide();
}

function funRemoveReadOnly(){}

function funSearchLoad(){
}

function funChkButton() {
}

function funFocus(){
   	document.getElementById("txtclientname").focus();	    	
}

function funNotify(){
		return 1;
} 

function setValues(){
  $("#btnbalance").show();
  
  if(document.getElementById("hidchckdetailed").value==1){
	  document.getElementById("chckdetailed").checked = true;
  } else if(document.getElementById("hidchckdetailed").value==0){
	  document.getElementById("chckdetailed").checked = false;
  }
  
  if($('#msg').val()!=""){
	  $.messager.alert('Message',$('#msg').val());
  }
  
  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
  funSetlabel();
  
  var detailed=$('#hidchckdetailed').val();
  var accno=$('#txtaccno').val();
   if(accno != ""){
       var indexVal = document.getElementById("txtcldocno").value;
       $("#paymentFollowUpDiv").load("paymentFollowUpGrid.jsp?accountno="+accno+'&cldocno='+indexVal+'&detailed='+detailed);
   }
  
   var cldocno=$('#txtcldocno').val();
   if(cldocno != ""){
      $("#operationDiv").load("operationGrid.jsp?cldocno="+cldocno+'&detailed='+detailed);
      $("#driverDiv").load("driverDetailsGrid.jsp?cldocno="+cldocno);
      $("#accidentDamageDiv").load("accidentDamageHistoryGrid.jsp?cldocno="+cldocno);
      $("#quotationDiv").load("quotationGrid.jsp?cldocno="+cldocno);
   }
  
  $('#txtdescription').attr('readonly', false);
	
}
</script>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmClientReview" action="saveClientReview" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div class="hidden-scrollbar receipt-header">
    <div style="width: 100%;" class="table-section">
<table class="cr-table" width="100%">
  <tr>
    <td width="4%" align="right">Client</td>
    <td width="22%"><input type="text" id="txtclientname" name="txtclientname" style="width:100%;" placeholder="Press F3 to Search" onkeydown="getAcc(event);" value='<s:property value="txtclientname"/>'/>
    <input type="hidden" id="txtcldocno" name="txtcldocno" style="width:10%" value='<s:property value="txtcldocno"/>'/>
    <input type="hidden" id="txtaccno" name="txtaccno" style="width:10%" value='<s:property value="txtaccno"/>'/></td>
    <td width="12%" align="right" style="font-family: Myriad Pro;font-size: 12px;font-weight: bold;">Account Balance :</td>
    <td width="18%" align="left"><input type="text" class="textbox" id="txtbalance" name="txtbalance" style="width:40%;text-align: right;" value='<s:property value="txtbalance"/>'/></td>
    <td width="10%"><label class="status" id="lblclientstatus" name="lblclientstatus"><s:property value="lblclientstatus"/></label></td>
    <td width="11%"><input type="checkbox" id="chckdetailed" name="chckdetailed" value="" onchange="funDetailed();" onclick="$(this).attr('value', this.checked ? 1 : 0)">Detailed
                             <input type="hidden" id="hidchckdetailed" name="hidchckdetailed" value='<s:property value="hidchckdetailed"/>'/></td>
    <td width="13%" align="left"><button class="myButton" type="button" id="btnbalance" name="btnbalance" onclick="funOutStandingStatement();">Outstanding Statement</button></td>
    <td width="9%" align="center"><button class="myButton" type="button" id="btnAttach" name="btnAttach" onclick="funAttachButton();">Attach</button></td>
  </tr>
</table>
    </div>

    <div class="table-section" style="background: #ECF8E0; width: 100%;"><h3 style="font-family: comic sans ms;font-weight: bold;">Operations</h3>
        <div class="cr-table" id="operationDiv"><jsp:include page="operationGrid.jsp"></jsp:include></div>
    </div>

    <div class="table-section" style="width: 100%; background: #E0ECF8;"><h3 style="font-family: comic sans ms;font-weight: bold;">Payment Follow-Up</h3>
        <div class="cr-table" id="paymentFollowUpDiv"><jsp:include page="paymentFollowUpGrid.jsp"></jsp:include></div>
       <div class="cr-table"> <jsp:include page="description.jsp"></jsp:include></div>
    </div>
    <div class="table-section" style="width: 100%; background: #FFFFF0;"><h3 style="font-family: comic sans ms;font-weight: bold;">Driver Details</h3>
        <div class="cr-table" id="driverDiv"><jsp:include page="driverDetailsGrid.jsp"></jsp:include></div>
    </div>
    <div class="table-section" style="width:100%;background: #FFEBEB;"><h3 style="font-family: comic sans ms;font-weight: bold;">Accident/Damage History</h3>
        <div class="cr-table" id="accidentDamageDiv"><jsp:include page="accidentDamageHistoryGrid.jsp"></jsp:include></div>
    </div>
    <div class="table-section" style="width: 100%; background: #FFFAFA;"><h3 style="font-family: comic sans ms;font-weight: bold;">Quotation Details</h3>
        <div class="cr-table" id="quotationDiv"><jsp:include page="quotationGrid.jsp"></jsp:include></div>
    </div>
<div hidden="true" id="jqxClientReviewDate" name="jqxClientReviewDate" value='<s:property value="jqxClientReviewDate"/>'></div>
<div hidden="true" id="jqxNonFinancialDate" name="jqxNonFinancialDate" value='<s:property value="jqxNonFinancialDate"/>'></div>
<input type="hidden" id="hidjqxNonFinancialDate" name="hidjqxNonFinancialDate" value='<s:property value="hidjqxNonFinancialDate"/>'/>
<input type="hidden" id="txtnonfinancialcomment" name="txtnonfinancialcomment" style="width:80%;" value='<s:property value="txtnonfinancialcomment"/>'/>
<input type="hidden" id="docno" name="txtnonfinancialdocno" value='<s:property value="txtnonfinancialdocno"/>'/>
<input type="hidden" id="idpdetailsallowed" name="idpdetailsallowed"  value='<s:property value="idpdetailsallowed"/>'/>

<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
</div>
</form>
<div id="clientWindow">
	<div></div><div></div>
</div>
<div id="nonFinancialWindow">
	<div></div><div></div>
</div>  
</div>
</body>
</html>
