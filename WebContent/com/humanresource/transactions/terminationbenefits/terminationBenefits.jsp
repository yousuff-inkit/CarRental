<%@ page contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="ISO-8859-1">
<title>GatewayERP(i) - Terminal Benefits</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<link rel="stylesheet" href="<%=contextPath%>/css/global.css" type="text/css">

<script type="text/javascript">
	$(document).ready(function() {
		 $('#btnEdit').attr('disabled', true );$('#btnDelete').attr('disabled', true );$('#btnAttach').attr('disabled', true );
		 $("#terminationBenefitsPostingDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	     var curfromdate= $('#terminationBenefitsPostingDate').jqxDateTimeInput('getDate');
		 var lastdaydate = new Date(curfromdate.getFullYear(), curfromdate.getMonth() + 1, 0);
	     var lastdaymonthdate=new Date(new Date(lastdaydate).setDate(lastdaydate.getDate()));
	     $('#terminationBenefitsPostingDate ').jqxDateTimeInput('setDate', new Date(lastdaymonthdate));
	});
	
	function getLeaveDaysConfig(){
		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText.trim();
  				document.getElementById("chkleavedayconfig").value=items;
  			} else {
  				}
  			}
  		x.open("GET", "leavedaysconfig.jsp", true);
  		x.send();
	}
	
	function getLastMonthDepreciation(date){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText;
	  				 items = items.split('***');
	  			     $('#txtchkgridload').val(items[0]);
	  			     $('#txtchkdate').val(items[1]);
	  			     $('#txtchksalarypaid').val(items[3]);
	  			     document.getElementById("errormsg").innerText="Terminal Benefits done till "+items[2]+".";
	  			   if(parseInt($('#txtchkdate').val())==0){
	  				  if(parseInt($('#txtchkgridload').val())==1){
	  					if(parseInt($('#txtchksalarypaid').val())==0){
	  					    $("#overlay, #PleaseWait").show();
	  					    var employeebranchchk=window.parent.employeebranchchk.value;   
	  					    $("#terminationBenefitsDetailsDiv").load("terminationBenefitsGrid.jsp?check=1&deprdate="+date+"&branch="+document.getElementById("brchName").value+'&employeebranchchk='+employeebranchchk);
	  					    $('#txtchkgridload').val('');
	  					    $('#txtgridload').val(1);
	  					    $('#btnExcelExporter').show();
	  					} else {
	  						$.messager.alert('Message','Payroll Processing Pending.','warning');
							$("#terminationBenefitsDetails").jqxGrid('clear'); 
				            $("#terminationBenefitsDetails").jqxGrid('addrow', null, {});
				            $("#terminationBenefitsAccounts").jqxGrid('clear');
				            $("#terminationBenefitsAccounts").jqxGrid('addrow', null, {});
							$('#txtterminalbenefitstotal').val('');
							$('#txtleavesalarytotal').val('');
							$('#txttravelstotal').val('');
							$('#txtdrtotal').val('');
							$('#txtcrtotal').val('');
	  						return;
	  					}
	  				  }else if(parseInt($('#txtchkgridload').val())==0) {
	  						$.messager.alert('Message','Terminal Benefits Pending for Last-Month.','warning');
							$("#terminationBenefitsDetails").jqxGrid('clear'); 
				            $("#terminationBenefitsDetails").jqxGrid('addrow', null, {});
				            $("#terminationBenefitsAccounts").jqxGrid('clear');
				            $("#terminationBenefitsAccounts").jqxGrid('addrow', null, {});
							$('#txtterminalbenefitstotal').val('');
							$('#txtleavesalarytotal').val('');
							$('#txttravelstotal').val('');
							$('#txtdrtotal').val('');
							$('#txtcrtotal').val('');
	  						return;
	  					}else if(parseInt($('#txtchkgridload').val())==2) {
  							$.messager.alert('Message','Terminal Benefits Already Done.','warning');
							$("#terminationBenefitsDetails").jqxGrid('clear'); 
				            $("#terminationBenefitsDetails").jqxGrid('addrow', null, {});
				            $("#terminationBenefitsAccounts").jqxGrid('clear');
				            $("#terminationBenefitsAccounts").jqxGrid('addrow', null, {});
							$('#txtterminalbenefitstotal').val('');
							$('#txtleavesalarytotal').val('');
							$('#txttravelstotal').val('');
							$('#txtdrtotal').val('');
							$('#txtcrtotal').val('');
  							return;
  					}
	  			  }else {
	  						$.messager.alert('Message','Terminal Benefits date should be Month-End.','warning');
							$("#terminationBenefitsDetails").jqxGrid('clear'); 
				            $("#terminationBenefitsDetails").jqxGrid('addrow', null, {});
				            $("#terminationBenefitsAccounts").jqxGrid('clear');
				            $("#terminationBenefitsAccounts").jqxGrid('addrow', null, {});
							$('#txtterminalbenefitstotal').val('');
							$('#txtleavesalarytotal').val('');
							$('#txttravelstotal').val('');
							$('#txtdrtotal').val('');
							$('#txtcrtotal').val('');
	  						return;
	  					}
	  		}
  		}
  		x.open("GET", "getLastMonthDepreciation.jsp?date="+date+"&branch="+document.getElementById("brchName").value, true);
  		x.send();
    }
	
	 function funReadOnly(){
			$('#frmTerminalBenefitsPosting input').attr('readonly', true );
			$("#terminationBenefitsDetails").jqxGrid({ disabled: true});
			$("#terminationBenefitsAccounts").jqxGrid({ disabled: true});
			$('#terminationBenefitsPostingDate').jqxDateTimeInput({disabled: true});
			$('#btnProcessing').hide();$('#btnCalculate').hide();$('#btnExcelExporter').hide();
	 }
	 function funRemoveReadOnly(){
		 	$('#btnProcessing').show();$('#btnCalculate').show();
		 	$('#frmTerminalBenefitsPosting input').attr('readonly', true );
			$("#terminationBenefitsDetails").jqxGrid({ disabled: false});
			$("#terminationBenefitsAccounts").jqxGrid({ disabled: false});
			$('#terminationBenefitsPostingDate').jqxDateTimeInput({disabled: false});
			getLeaveDaysConfig();
			if ($("#mode").val() == "A") {
				$('#terminationBenefitsPostingDate').val(new Date());
				var curfromdate= $('#terminationBenefitsPostingDate').jqxDateTimeInput('getDate');
				var lastdaydate = new Date(curfromdate.getFullYear(), curfromdate.getMonth() + 1, 0);
			    var lastdaymonthdate=new Date(new Date(lastdaydate).setDate(lastdaydate.getDate()));
			    $('#terminationBenefitsPostingDate ').jqxDateTimeInput('setDate', new Date(lastdaymonthdate));
				$("#terminationBenefitsDetails").jqxGrid('clear'); 
				$("#terminationBenefitsDetails").jqxGrid('addrow', null, {});
				$("#terminationBenefitsAccounts").jqxGrid('clear');
				$("#terminationBenefitsAccounts").jqxGrid('addrow', null, {});
			}
	 }
	 
	 function funSearchLoad(){
		 changeContent('tebMainSearch.jsp'); 
	 }
		
	 function funChkButton() {
		}
	 
	 function funFocus(){
	    	$('#terminationBenefitsPostingDate').jqxDateTimeInput('focus'); 	    		
	    }
	   
	  function funNotify(){	
	        	var rows = $("#terminationBenefitsAccounts").jqxGrid('getrows');
	        	if(parseInt(rows[0].acno)>0){
	        		document.getElementById("errormsg").innerText="";
	        	}else {
	        		document.getElementById("errormsg").innerText="Process,Calculate & Save.";
	        	    return 0;	
	        	}
				var paydate = $('#terminationBenefitsPostingDate').jqxDateTimeInput('getDate');
		        var validdate=funDateInPeriod(paydate);
		         if(validdate==0){
			        return 0;	
		         }
				 var rows = $("#terminationBenefitsDetails").jqxGrid('getrows');
				 var length=0;
					 for(var i=0 ; i < rows.length ; i++){
						var chk=rows[i].employeedocno;
						if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
							newTextBox = $(document.createElement("input"))
						    .attr("type", "dil")
						    .attr("id", "test"+length)
						    .attr("name", "test"+length)
							.attr("hidden", "true");
							length=length+1;
				    newTextBox.val(rows[i].employeedocno+"::"+rows[i].salary+"::"+rows[i].terminalbenefitsyears+"::"+rows[i].terminalbenefitsdaystobeposted+"::"+rows[i].terminalbenefitscurrentprovision+"::"+rows[i].terminalbenefitsalreadyposted+"::"+rows[i].terminalbenefitstobeposted+"::"+rows[i].leavesalary+"::"+rows[i].leavesalarydaystobeposted+"::"+rows[i].leavesalarytotaldaysposted+"::"+rows[i].leavesalarycurrentprovision+"::"+rows[i].leavesalaryalreadyposted+"::"+rows[i].leavesalarytobeposted+"::"+rows[i].travelstotalperyear+"::"+rows[i].travelsdaystobeposted+"::"+rows[i].travelstotaldaysposted+"::"+rows[i].travelstotal+"::"+rows[i].travelsalreadyposted+"::"+rows[i].travelstobeposted);
					newTextBox.appendTo('form');
					 }
					}
		 		 $('#gridlength').val(length);
		    	 var accountrows = $("#terminationBenefitsAccounts").jqxGrid('getrows');
		    	 var journallength=0;
				 for(var j=0 ; j < accountrows.length ; j++){
					var chks=accountrows[j].acno;
					if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != ""){
						newTextBox = $(document.createElement("input"))
					    .attr("type", "dil")
					    .attr("id", "journal"+journallength)
					    .attr("name", "journal"+journallength)
					    .attr("hidden", "true");
						journallength=journallength+1;
					var amount=0,id=1;
					if((accountrows[j].credit!=null) && (accountrows[j].credit!='undefined') &&  (accountrows[j].credit!='NaN') && (accountrows[j].credit!="") && (accountrows[j].credit!=0)){
						 amount=accountrows[j].credit*-1;
						 id=-1;
					}
					if((accountrows[j].debit!=null) && (accountrows[j].debit!='undefined') && (accountrows[j].debit!='NaN') && (accountrows[j].debit!="") && (accountrows[j].debit!=0)){
						 amount=accountrows[j].debit;
						 id=1;
					}
					newTextBox.val(accountrows[j].acno+"::"+amount+"::"+id);
					newTextBox.appendTo('form');
					}
				 }
				 $('#journalgridlength').val(journallength);
	    		return 1;
		} 
	  
	  function setValues(){
		  if($('#hidterminationBenefitsPostingDate').val()){
				 $("#terminationBenefitsPostingDate").jqxDateTimeInput('val', $('#hidterminationBenefitsPostingDate').val());
			  }
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
		     var indexVal = document.getElementById("txttrno").value;
			 if(indexVal>0){
	         $("#accountsDetailsDiv").load("accountsDetailsGrid.jsp?trno="+indexVal);
			 }
			 var indexVal1 = document.getElementById("docno").value;
	         var indexVal2 = document.getElementById("txttrno").value;
	         if(indexVal1>0){
	        	 var employeebranchchk=window.parent.employeebranchchk.value; 
	      		 var branch=document.getElementById("brchName").value;  
	         	$("#terminationBenefitsDetailsDiv").load("terminationBenefitsGrid.jsp?docno="+indexVal1+"&trno="+indexVal2+'&branch='+branch+'&employeebranchchk='+employeebranchchk);
	         } 
		}	
		
	  function funProcessBtn(){
	      var paydate = $('#terminationBenefitsPostingDate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(paydate);
		  if(validdate==0){
			return 0;	
		  }
		  var date = $('#terminationBenefitsPostingDate').val();
		  getLastMonthDepreciation(date);
	  }
	  
	  function funCalculateBtn(){
		  $('#btnExcelExporter').show();
		  if($('#txtgridload').val()=='1'){
			  var length = 0;
			  var date=$('#terminationBenefitsPostingDate').val();
			  var curfromdate= $('#terminationBenefitsPostingDate').jqxDateTimeInput('getDate');
			  var lastday = new Date(curfromdate.getFullYear(), curfromdate.getMonth() + 1, 0);
			  var lastdaydate = lastday.getDate();
			  $("#overlay, #PleaseWait").show();
			  var employeebranchchk=window.parent.employeebranchchk.value; 
			  $("#terminationBenefitsDetailsDiv").load("terminationBenefitsGrid.jsp?check=2&day="+lastdaydate+"&deprdate="+date+"&branch="+document.getElementById("brchName").value+'&employeebranchchk='+employeebranchchk);
			  var rows = $("#terminationBenefitsDetails").jqxGrid('getrows');
			  length = rows.length;
			  if(!(length=='0')){
			     $("#accountsDetailsDiv").load("accountsDetailsGrid.jsp?check=2");
			  }
		  }else {
				$.messager.alert('Message','Process & Then Calculate.','warning');
				return;
			}
	  }
	  
	  function funExcelExporter(){
			 if(parseInt(window.parent.chkexportdata.value)=="1") {
			  	JSONToCSVCon(data, 'TerminalBenefits', true);
			 } else {
				 $("#terminationBenefitsDetails").jqxGrid('exportdata', 'xls', 'TerminalBenefits');
			 }
		 }
	  
	  function funExcelBtn() {
		  JSONToCSVCon(dataExcelExport, 'TerminalBenefits', true);
	  }
		
		function funPrintBtn() {
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
				 var url=document.URL;
				 reurl=url.split("transactions");
			     $("#docno").prop("disabled", false);
					   $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
						if (r){
							 var win= window.open(reurl[0]+"transactions/terminationbenefits/printTerminalBenefitsPosting?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
						     win.focus();
						 }
						else{
							var win= window.open(reurl[0]+"transactions/terminationbenefits/printTerminalBenefitsPosting?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
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
		    var date = $('#terminationBenefitsPostingDate').jqxDateTimeInput('getDate');
			var lastdaydate = new Date(date.getFullYear(), date.getMonth() + 1, 0);
		    var lastdaymonthdate=new Date(new Date(lastdaydate).setDate(lastdaydate.getDate()));
		    $('#terminationBenefitsPostingDate ').jqxDateTimeInput('setDate', new Date(lastdaymonthdate));
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

<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmTerminalBenefitsPosting" action="terminalbenefitsposting" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div class="hidden-scrollbar receipt-header">
<div class="table-section" style="width: 100%;">
<table class="cr-table" width="100%">
  <tr>
    <td width="3%" align="right">Date</td>
    <td width="24%"><div id="terminationBenefitsPostingDate" name="terminationBenefitsPostingDate" onchange="datechange();" value='<s:property value="terminationBenefitsPostingDate"/>'></div>
    <input type="hidden" id="hidterminationBenefitsPostingDate" name="hidterminationBenefitsPostingDate" value='<s:property value="hidterminationBenefitsPostingDate"/>'/></td>
    <td width="8%" align="right"><button type="button" class="icon" id="btnExcelExporter" title="Export current Document to Excel" onclick="funExcelExporter();">
      						 <img alt="Export current Document to Excel" src="<%=contextPath%>/icons/excel_new.png">
      					</button></td>
    <td width="13%" align="right"><button type="button" id="btnProcessing" title="Process" style="border:none;background:none;" onclick="funProcessBtn();">
      						 <img alt="Process" src="<%=contextPath%>/icons/process2.png" width="16" height="16">
      					</button></td>
    <td width="10%" align="center"><button type="button" class="icon" id="btnCalculate" title="Calculate" onclick="funCalculateBtn();">
							<img alt="Calculate" src="<%=contextPath%>/icons/calculate_new.png">
						</button></td>
    <td width="18%" align="right">Doc No.</td>
    <td width="24%"><input type="text" id="docno" name="txtjvno" value='<s:property value="txtjvno"/>' tabindex="-1"/></td>
  </tr>
</table>
</div>
<div class="table-section" style="width: 100%;"><h3>Details</h3>
<div class="cr-table" id="terminationBenefitsDetailsDiv"><jsp:include page="terminationBenefitsGrid.jsp"></jsp:include></div>
</div>

<table class="cr-table" width="100%">
  <tr>
    <td width="8%" align="right">Terminal Benefits</td>
    <td width="24%"><input type="text" id="txtterminalbenefitstotal" name="txtterminalbenefitstotal" style="width:50%;text-align: right;" value='<s:property value="txtterminalbenefitstotal"/>' tabindex="-1"/></td>
    <td width="5%" align="right">Leave Salary</td>
    <td width="26%"><input type="text" id="txtleavesalarytotal" name="txtleavesalarytotal" style="width:50%;text-align: right;" value='<s:property value="txtleavesalarytotal"/>' tabindex="-1"/></td>
    <td width="10%" align="right">Travels</td>
    <td width="27%"><input type="text" id="txttravelstotal" name="txttravelstotal" style="width:50%;text-align: right;" value='<s:property value="txttravelstotal"/>' tabindex="-1"/></td>
  </tr>
</table>

<div class="table-section" style="width: 100%;"><h3>Accounts</h3>
<div class="cr-table" id="accountsDetailsDiv"><jsp:include page="accountsDetailsGrid.jsp"></jsp:include></div>
</div>
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
<input type="hidden" id="gridlength" name="gridlength"/>
<input type="hidden" id="journalgridlength" name="journalgridlength"/>
<input type="hidden" id="txttrno" name="txttrno"  value='<s:property value="txttrno"/>'/>
<input type="hidden" id="txtgridload" name="txtgridload"  value='<s:property value="txtgridload"/>'/>
<input type="hidden" id="txtchkgridload" name="txtchkgridload"  value='<s:property value="txtchkgridload"/>'/>
<input type="hidden" id="txtchksalarypaid" name="txtchksalarypaid"  value='<s:property value="txtchksalarypaid"/>'/>
<input type="hidden" id="txtchkdate" name="txtchkdate"  value='<s:property value="txtchkdate"/>'/>
<input type="hidden" id="chkleavedayconfig" name="chkleavedayconfig"/>
</div>
</form>
</div>
</body>
</html>
