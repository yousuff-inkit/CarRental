<%@ page contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@page import="java.util.*" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="com.operations.vehicleprocurement.vehiclepurchasedirect.ClspurchaseDirectDAO" %>
<%
String contextPath=request.getContextPath();
ClspurchaseDirectDAO pdao=new ClspurchaseDirectDAO();
int method=pdao.getTaxMethod();
%>

<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="ISO-8859-1">
<title>GatewayERP(i) - Veh. Purchase Direct (VPD)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<link rel="stylesheet" href="<%=contextPath%>/css/global.css" type="text/css">

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
label { font-weight: 600; font-size: 14px; color: #1a2d4d; margin-bottom: 8px; display:block; }
.cr-table { width: 100%; border-collapse: collapse; background: #ffffff; border-radius: 12px; overflow: hidden; box-shadow: 0 2px 12px rgba(100, 140, 255, 0.15); }
.cr-table th, .cr-table td { padding: 10px 12px; border-bottom: 1px solid #d6e1ff; text-align: left; font-size: 0.95rem; color: #1f2f46; vertical-align: middle; }
.cr-table th { background-color: #dcebff; color: #1b3f73; font-weight: 600; }
button, .myButton { background: linear-gradient(90deg, #3b82f6, #1a73e8); color: #fff; border: none; border-radius: 8px; padding: 9px 22px; font-weight: 600; cursor: pointer; transition: 0.25s ease; box-shadow: 0 3px 10px rgba(30, 100, 255, 0.25); }
.section-row { display: flex; flex-direction: column; gap: 26px; width: 100%; }
.section-block { width: 100%; background: #f0f4ff; border-radius: 12px; padding: 20px 18px; box-shadow: 0 4px 12px rgba(30, 64, 175, 0.08); border: none; }
.section-block h2 { font-size: 1.09em; font-weight: 600; margin-bottom: 16px; color: #1e2a44; }
.section-block .form-group { display: flex; align-items: center; gap: 16px; margin-bottom: 12px; }
.section-block label { min-width: 110px; text-align: right; font-weight: 500; color: #1e2a44; }
.section-block input[type="text"], .section-block select { flex: 1; border: 1px solid #b4c6ff; border-radius: 6px; padding: 6px 10px; background: #fff; font-size: 0.96rem; transition: border-color 0.2s ease; }
.section-block input[type="text"]:focus, .section-block select:focus { border-color: #376bff; outline: none; }
@keyframes fadeIn { from { opacity: 0; transform: translateY(-5px); } to { opacity: 1; transform: translateY(0); } }
@media (max-width: 900px) { .clean-grid-form { grid-template-columns: repeat(1, 1fr); } .clean-grid-item.full { grid-column: span 1; } }
/* ensure table inputs match the header input (docno) */
.cr-table input.clean-input,
.cr-table input[type="text"] {
  height: 44px;
  padding: 8px 12px;
  border-radius: 8px;
  border: 1px solid #b9ccf2;
  background: #ffffff;
  box-sizing: border-box;
  font-size: 0.95rem;
  transition: 0.18s ease;
}
.cr-table input.clean-input:focus,
.cr-table input[type="text"]:focus {
  border-color: #4da3ff;
  box-shadow: 0 0 6px rgba(77,163,255,0.35);
  outline: none;
}

</style>

<script type="text/javascript">
	$(document).ready(function() {
		 var meth='<%=method%>'
		 if(meth==0){
			 document.getElementById("txttaxamount").style.display="none";
			 document.getElementById("lbltax").style.display="none";
		 }
		 $("#vehpurorderDate").jqxDateTimeInput({ width: '120px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#vehpurinvDate").jqxDateTimeInput({ width: '120px', height: '15px', formatString:"dd.MM.yyyy"});
	     $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
		 $('#accountSearchwindow').jqxWindow('close');
	     $('#fleetwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' ,title: 'Fleet Search' , position: { x: 150, y: 60 }, keyboardCloseKey: 27});
		 $('#fleetwindow').jqxWindow('close');
		 $('#accid').dblclick(function(){
			   if($('#mode').val()!="view") {
				   $('#accountSearchwindow').jqxWindow('open');
				   accountSearchContent('accountsDetailsSearch.jsp?');
			   }
		  });
		  $("#btnEdit").attr('disabled', true );
	    $('#vehpurorderDate').on('change', function (event) {
	        var maindate = $('#vehpurorderDate').jqxDateTimeInput('getDate');
	  	 	if ($("#mode").val() != "view"  ) {
	    		funDateInPeriod(maindate);
	    	}
	    });
	});
	function commenSearchContent(url) {
		 $.get(url).done(function (data) {
			 $('#accountSearchwindow').jqxWindow('open');
			 $('#accountSearchwindow').jqxWindow('setContent', data);
		 });
	}
	function  getfinacc(event){
	 	var x= event.keyCode;
	 	if(x==114){
	 	  $('#accountSearchwindow').jqxWindow('open');
	 	  commenSearchContent('finaccountSearch.jsp?');
	 	}
	}
	function fleetSearchContent(url) {
		 $.get(url).done(function (data) {
			 $('#fleetwindow').jqxWindow('open');
			 $('#fleetwindow').jqxWindow('setContent', data);
		 });
	}
	function getaccountdetails(event){
	 	var x= event.keyCode;
	 	if(x==114){
	 	   if($('#mode').val()!="view") {
	 		  $('#accountSearchwindow').jqxWindow('open');
	 		  accountSearchContent('accountsDetailsSearch.jsp?');
	 	   }
	 	}
	}
	function accountSearchContent(url) {
	    $.get(url).done(function (data) {
	        $('#accountSearchwindow').jqxWindow('setContent', data);
		});
	}
	function funReadOnly(){
		$('#frmpurchasedir input').attr('readonly', true );
		$('#frmpurchasedir select').attr('disabled', true);
		$('#vehpurorderDate').jqxDateTimeInput({disabled: true});
		$('#vehpurinvDate').jqxDateTimeInput({disabled: true});
	}
	function funRemoveReadOnly(){
		$('#frmpurchasedir input').attr('readonly', false );
		$('#frmpurchasedir select').attr('disabled', false);
		$('#vehpurorderDate').jqxDateTimeInput({disabled: false});
		$('#vehpurinvDate').jqxDateTimeInput({disabled: false});
		$('#docno').attr('readonly', true);
		$('#accid').attr('readonly', true);
		if ($("#mode").val() == "A") {
			tax();
			$('#vehpurorderDate').val(new Date());
			$('#vehpurinvDate').val(new Date());
		    $("#vehpurchasedirgrid").jqxGrid('clear');
		    $("#vehpurchasedirgrid").jqxGrid('addrow', null, {});
		}
		if($('#mode').val()=='D') {
			$('#frmpurchasedir input').attr('readonly',false);
			$('#frmpurchasedir select').attr('disabled',false);
			$('#vehpurorderDate').jqxDateTimeInput({disabled: false});
			$('#vehpurinvDate').jqxDateTimeInput({disabled: false});
			funchkfordel(document.getElementById("masterdoc_no").value);
			funReadOnly();
			exit();
	    }
	}
	function funchkfordel(masterdoc_no)
	{
	 	var x = new XMLHttpRequest();
	 	x.onreadystatechange = function() {
	 		if (x.readyState == 4 && x.status == 200) {
	 			var items = x.responseText.trim();
	 			if(parseInt(items)>0) {
	 				$.messager.alert('Message',' Transaction Already Exists','warning');
	            	return 0;
	 			} else {
	 				$('#frmpurchasedir input').attr('readonly',false);
	 				$('#frmpurchasedir select').attr('disabled',false);
	 				$('#vehpurorderDate').jqxDateTimeInput({disabled: false});
	 				$('#vehpurinvDate').jqxDateTimeInput({disabled: false});
	 				$('#frmpurchasedir').submit();
	 			}
	 		}
	 	}
	 	x.open("GET", "deletechk.jsp?srno="+document.getElementById("masterdoc_no").value, true);
	 	x.send();
	}
	function funSearchLoad(){
		changeContent('mastersearch.jsp');
	}
	function funChkButton() {
	}
	function funFocus() {
		$('#vehpurorderDate').jqxDateTimeInput('focus');
	}
	function getTaxPer(date){
	     var x = new XMLHttpRequest();
	     x.onreadystatechange = function() {
	       if (x.readyState == 4 && x.status == 200) {
	        var items = x.responseText.trim();
	       	$('#txttaxpercentage').val(items);
	       }
   		 }
	      x.open("GET", "getTaxper.jsp?date="+date, true);
	      x.send();
	}
	function tax(){
		var date=$('#vehpurorderDate').val();
		getTaxPer(date);
	}
	function funNotify(){
		  var maindate = $('#vehpurorderDate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(maindate);
		  if(validdate==0){ return 0; }
		var purid= document.getElementById("accid").value;
		if(purid=="") {
			 document.getElementById("errormsg").innerText=" Select An Account";
			 document.getElementById("accid").focus();
			 return 0;
		} else { document.getElementById("errormsg").innerText=""; }
		var invno= document.getElementById("invno").value;
		if(invno=="") {
			 document.getElementById("errormsg").innerText=" Enter Invoice No";
			 document.getElementById("invno").focus();
			 return 0;
		} else { document.getElementById("errormsg").innerText=""; }
		  var rows = $("#vehpurchasedirgrid").jqxGrid('getrows');
		    $('#vehpurchasegridlenght').val(rows.length);
		   for(var i=0 ; i < rows.length ; i++){
		       newTextBox = $(document.createElement("input"))
		           .attr("type", "dil")
		           .attr("id", "vehpurchasetest"+i)
		           .attr("name", "vehpurchasetest"+i)
		           .attr("hidden", "true");
		       newTextBox.val(rows[i].fleet_no+"::"+rows[i].brdid+" :: "+rows[i].modid+" :: "
					   +rows[i].clrid+" :: "+rows[i].chaseno+" :: "+rows[i].enginno+" :: "+rows[i].prch_cost+" :: "+rows[i].addicost+" :: "
					   +rows[i].price+" :: ");
		       newTextBox.appendTo('form');
		   }
	    return 1;
	}
	$(function(){
        $('#frmpurchasedir').validate({
        	 rules: { vehdesc:{maxlength:200} },
                messages: { vehdesc: {maxlength:"  Max 250 chars"} }
        });
	});
	function isNumber(evt) {
	    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
	    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
	 	   document.getElementById("errormsg").innerText=" Enter Numbers Only";
	        return false;
	    }
	    document.getElementById("errormsg").innerText="";
	    return true;
	}
  function setValues()
  {
	   if($('#hidvehpurorderDate').val()){
			 $("#vehpurorderDate").jqxDateTimeInput('val', $('#hidvehpurorderDate').val());
		  }
	  if($('#hidvehpurinvDate').val()){
			 $("#vehpurinvDate").jqxDateTimeInput('val', $('#hidvehpurinvDate').val());
		  }
		var indexVa5 = document.getElementById("masterdoc_no").value;
        if(parseInt(indexVa5)>0){
         $("#vehpuchase").load("vehpurchaseDetails.jsp?masterdoc="+indexVa5);
        }
        if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
		}
      	funSetlabel();
  }
	 function funPrintBtn(){
	  	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	  	     var url=document.URL;
	         var reurl=url.split("savePurchase");
	         $("#docno").prop("disabled", false);
	         var win= window.open(reurl[0]+"printPurchaseDir?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	    	 win.focus();
	  	   } else {
	 	     $.messager.alert('Message','Select a Document....!','warning');
	 	     return false;
	  	   }
	}
</script>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmpurchasedir" action="savePurchaseDir" method="post" autocomplete="off">
    <jsp:include page="../../../../header.jsp"></jsp:include>
    <br><br>
    <div class="hidden-scrollbar receipt-header" style="padding:20px;">
      <div class="clean-grid-form" style="grid-template-columns: 1fr;">
        <div class="clean-grid-item" style="display:block; width:100%;">
          <table class="cr-table" width="100%" style="background:#fff; box-shadow:none;">
            <tr>
              <td>
                <table width="100%" style="border-collapse:separate; border-spacing:8px 6px;">
                  <tr>
                    <td style="width:12%; text-align:right; font-weight:600; color:#1b3f73;">Date</td>
                    <td style="width:15%;">
                      <div id="vehpurorderDate" name="vehpurorderDate" value='<s:property value="vehpurorderDate"/>' onblur="tax()" onchange="tax()"></div>
                      <input type="hidden" id="hidvehpurorderDate" name="hidvehpurorderDate" value='<s:property value="hidvehpurorderDate"/>'/>
                    </td>
                    <td style="text-align:right; font-weight:600; color:#1b3f73;">Doc No</td>
                    <td style="width:20%;"><input type="text" id="docno" name="docno" class="clean-input" readonly="readonly" value='<s:property value="docno"/>' tabindex="-1"/></td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td>
                <table width="100%" style="border-collapse:separate; border-spacing:8px 6px;">
                  <tr>
                    <td style="width:12%; text-align:right; font-weight:600; color:#1b3f73;">Vendor</td>
                    <td style="width:38%;">
                      <input type="text" id="accid" name="accid" class="clean-input" style="width:25%; display:inline-block;" placeholder="Press F3 to Search" value='<s:property value="accid"/>'  onkeydown="getaccountdetails(event)"/>
                      <input type="text" id="vehpuraccname" name="vehpuraccname" class="clean-input" style="width:70%; display:inline-block; margin-left:8px;" value='<s:property value="vehpuraccname"/>'/>
                    </td>
                    <td style="width:8%; text-align:right; font-weight:600; color:#1b3f73;">Inv No</td>
                    <td style="width:12%;"><input type="text" id="invno" name="invno" class="clean-input" style="width:55%;" value='<s:property value="invno"/>'/></td>
                    <td style="width:12%; text-align:right; font-weight:600; color:#1b3f73;">Purchase Date</td>
                    <td style="width:10%;"><div id="vehpurinvDate" name="vehpurinvDate" value='<s:property value="vehpurinvDate"/>'></div>
                      <input type="hidden" id="hidvehpurinvDate" name="hidvehpurinvDate" value='<s:property value="hidvehpurinvDate"/>'/>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td>
                <table width="100%" style="border-collapse:separate; border-spacing:8px 6px;">
                  <tr>
                    <td style="font-weight:600; color:#1b3f73;">Description</td>
                    <td><input type="text" id="vehdesc" name="vehdesc" class="clean-input" style="width:100%;" value='<s:property value="vehdesc"/>'/></td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </div>
      </div>
    </div>

```
<br>
<div class="table-section" style="width:100%;">
  <div class="cr-table" id="vehpuchase">
    <jsp:include page="vehpurchaseDetails.jsp"></jsp:include>
  </div>
</div>

<br><br>
<input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/>
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="headacccode" name="headacccode"  value='<s:property value="headacccode"/>'/>
<input type="hidden" id="txttaxpercentage" name="txttaxpercentage"  value='<s:property value="txttaxpercentage"/>'/>
<input type="hidden" id="vehpurchasegridlenght" name="vehpurchasegridlenght"  value='<s:property value="vehpurchasegridlenght"/>'/>

<div>
  <table class="cr-table" width="100%" border="0" style="margin-top:12px;">
   <tr>
  <td style="width:34%;">&nbsp;</td>

  <td style="width:15%; text-align:right; font-weight:600; color:#1b3f73;">
    <label id="lbltax" style="margin:0; display:block;">Tax Amount</label>
  </td>

  <td style="width:17%;">
    <input type="text" name="txttaxamount" id="txttaxamount" class="clean-input" value='<s:property value="txttaxamount"/>' />
  </td>

  <td style="width:12%; text-align:right; font-weight:600; color:#1b3f73;">Net Total</td>

  <td style="width:22%;">
    <input type="text" name="txtnetotal" id="txtnetotal" class="clean-input" value='<s:property value="txtnetotal"/>' />
  </td>
</tr>

  </table>
</div>


</form>

<div id="accountSearchwindow"><div></div></div>
<div id="fleetwindow"><div></div></div>

</div>
</body>
</html>
