<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" /> 

<style type="text/css">
.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}

.mySaveButton {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #77d42a), color-stop(1, #5cb811));
	background:-moz-linear-gradient(top, #77d42a 5%, #5cb811 100%);
	background:-webkit-linear-gradient(top, #77d42a 5%, #5cb811 100%);
	background:-o-linear-gradient(top, #77d42a 5%, #5cb811 100%);
	background:-ms-linear-gradient(top, #77d42a 5%, #5cb811 100%);
	background:linear-gradient(to bottom, #77d42a 5%, #5cb811 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#77d42a', endColorstr='#5cb811',GradientType=0);
	background-color:#77d42a;
	-moz-border-radius:6px;
	-webkit-border-radius:6px;
	border-radius:6px;
	border:1px solid #268a16;
	display:inline-block;
	cursor:pointer;
	font-family:Verdana;
	font-size:10px;
	font-weight:bold;
	padding:4px 8px;
	text-decoration:none;
	text-shadow:0px -1px 0px #aade7c;
}
.mySaveButton:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #5cb811), color-stop(1, #77d42a));
	background:-moz-linear-gradient(top, #5cb811 5%, #77d42a 100%);
	background:-webkit-linear-gradient(top, #5cb811 5%, #77d42a 100%);
	background:-o-linear-gradient(top, #5cb811 5%, #77d42a 100%);
	background:-ms-linear-gradient(top, #5cb811 5%, #77d42a 100%);
	background:linear-gradient(to bottom, #5cb811 5%, #77d42a 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#5cb811', endColorstr='#77d42a',GradientType=0);
	background-color:#5cb811;
}
.mySaveButton:active {
	position:relative;
	top:1px;
}
.tdheight{
height:137px;
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
		
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy", enableBrowserBoundsDetection: true});
		 /* Searching Window */
     	 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Account Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
  		 $('#accountDetailsWindow').jqxWindow('close');
  		 
  		 $('#establishedCodeDetailsWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '30%' , title: 'Establishment Code Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#establishedCodeDetailsWindow').jqxWindow('close');
  		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
		 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
	     $('#txtbankaccount').dblclick(function(){
	    	 accountSearchContent("bankAccountDetailsSearch.jsp");
		 });
	     
	     $('#txtestablishmentcode').dblclick(function(){
	    	 establishedCodeSearchContent("establishmentCodeDetailsSearch.jsp");
		 });
	     
	     $("#salaryPaymentDetailsGridID").jqxGrid({ height: 532 });
	     $('#salaryPaymentDetailsGridID').jqxGrid({ selectionmode: 'singlerow'});
	     $("#salaryPaymentDetailsGridID").jqxGrid({ disabled: true});
	     $('#btnSaveSalaryPayment').attr('disabled', true );
	     //$('#btnSifSalaryPayment').attr('disabled', true );
	     $('#date').jqxDateTimeInput({disabled: true});
	});
	
	function accountSearchContent(url) {
	 	$('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function establishedCodeSearchContent(url) {
	 	$('#establishedCodeDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#establishedCodeDetailsWindow').jqxWindow('setContent', data);
		$('#establishedCodeDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	 function getYear() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					var yearItems = items[0].split(",");
					var yearIdItems = items[1].split(",");
					$('#excelconfig').val(items[2].split(","));
					var optionsyear = '<option value="">--Select--</option>';
					for (var i = 0; i < yearItems.length; i++) {
						optionsyear += '<option value="' + yearIdItems[i] + '">'
								+ yearItems[i] + '</option>';
					}
					$("select#cmbyear").html(optionsyear);
					if($('#hidcmbyear').val()){
						document.getElementById("cmbyear").value=document.getElementById("hidcmbyear").value;
						funreload(event);
					  }
				} else {
				}
			}
			x.open("GET", "getYear.jsp", true);
			x.send();
		}
	
	function getPayrollCategory() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var payrollcategoryItems = items[0].split(",");
				var payrollcategoryIdItems = items[1].split(",");
				var optionspayrollcategory = '<option value="">--Select--</option>';
				for (var i = 0; i < payrollcategoryItems.length; i++) {
					optionspayrollcategory += '<option value="' + payrollcategoryIdItems[i] + '">'
							+ payrollcategoryItems[i] + '</option>';
				}
				$("select#cmbempcategory").html(optionspayrollcategory);
				
			} else {
			}
		}
		x.open("GET", "getPayrollCategory.jsp", true);
		x.send();
	}
	
	function getSalesAgent() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var salesAgentItems = items[0].split(",");
				var salesAgentIdItems = items[1].split(",");
				var optionssalesagent = '<option value="">--Select--</option>';
				for (var i = 0; i < salesAgentItems.length; i++) {
					 optionssalesagent += '<option value="' + salesAgentIdItems[i] + '">'
							+ salesAgentItems[i] + '</option>';
				}
				$("select#cmbempagentid").html(optionssalesagent);
				
			} else {
			}
		}
		x.open("GET", "getSalesAgent.jsp", true);
		x.send();
	}
	
	function getAccount(event){
        var x= event.keyCode;
        if(x==114){
        	accountSearchContent("accountDetailsSearch.jsp");
        }
        else{}
        }
	
	function getBankAccount(event){
        var x= event.keyCode;
        if(x==114){
        	accountSearchContent("bankAccountDetailsSearch.jsp");
        }
        else{}
        }
	
	function getEstablishmentCode(event){
        var x= event.keyCode;
        if(x==114){
        	establishedCodeSearchContent("establishmentCodeDetailsSearch.jsp");
        }
        else{}
        }

	function  funClearInfo(){
		$('#cmbbranch').val('a');$('#cmbyear').val('');$('#cmbmonth').val('');$('#txtestablishmentcode').val('');
	    $('#cmbempcategory').val('');$('#cmbempagentid').val('');$('#date').val(new Date());$('#hiddate').val('');
	    $('#txtbankaccount').val('');$('#txtbankaccountname').val('');$('#txtbankaccountdocno').val('');
	    $('#txtdrtotal').val('');$('#txtcrtotal').val('');$('#gridlength').val('');
	    $("#salaryPaymentDetailsGridID").jqxGrid('clearselection');$("#salaryPaymentDetailsGridID").jqxGrid('clear');$("#salaryPaymentDetailsGridID").jqxGrid('addrow', null, {});$("#salaryPaymentDetailsGridID").jqxGrid({ disabled: true});
	    $("#postedSalaryGridID").jqxGrid('clear');
	    $('#date').jqxDateTimeInput({disabled: true});$('#btnSaveSalaryPayment').attr('disabled', true );
	    
		/* if (document.getElementById("txtaccount").value == "") {
	        $('#txtaccount').attr('placeholder', 'Press F3 to Search'); 
	        $('#txtaccountname').attr('placeholder', 'Employee Name');
	    } */
		
		if (document.getElementById("txtbankaccountdocno").value == "") {
	        $('#txtbankaccount').attr('placeholder', 'Press F3 to Search'); 
	        $('#txtbankaccountname').attr('placeholder', 'Bank Account');
	    }
		
		if (document.getElementById("txtestablishmentcode").value == "") {
	        $('#txtestablishmentcode').attr('placeholder', 'Press F3 to Search'); 
	    }
		
	 }
	
	function funreload(event){
		 var branchval = document.getElementById("cmbbranch").value;
		 var year = $('#cmbyear').val();
		 var month = $('#cmbmonth').val();
		 var category = $('#cmbempcategory').val();
		 var agent = $('#cmbempagentid').val();
		 var establishmentcode = $('#txtestablishmentcode').val();
		 var employeebranchchk=window.parent.employeebranchchk.value; 
		 
		 var bankAccount = $('#txtbankaccountdocno').val();
		 var bankName = $('#txtbankaccountname').val();
		 if($('#cmbyear').val()==''){
			 $.messager.alert('Message','Please Choose a Year.','warning');
			 return 0;
		 }
		
		if($('#cmbmonth').val()==''){
			 $.messager.alert('Message','Please Choose a Month.','warning');
			 return 0;
		 } 
		
		  $("#overlay, #PleaseWait").show();
		  $('#date').jqxDateTimeInput({disabled: false});
		  $('#date').val(new Date()); 
		  var paymentdate=$('#date').val(); 
		  $("#salaryPaymentDetailsGridID").jqxGrid('clearselection');$("#salaryPaymentDetailsGridID").jqxGrid('clear');
		  $("#salaryPaymentDetailsGridID").jqxGrid('addrow', null, {});$("#salaryPaymentDetailsGridID").jqxGrid({ disabled: true});
		  $('#txtselectedemployees').val('');  
		  $("#salaryPaymentDetailsDiv").load("salaryPaymentGrid.jsp?branchval="+branchval+'&paymentdate='+paymentdate+'&bankAccount='+bankAccount+'&bankName='+encodeURIComponent(bankName)+'&year='+year+'&month='+month+'&category='+category+'&agent='+agent+'&establishmentCode='+establishmentcode.replace(/ /g, "%20")+'&check=1&employeebranchchk='+employeebranchchk); 
		  $('#date').jqxDateTimeInput({disabled: true});
	}
	 
	function funExportBtn(){
		var method=document.getElementById("excelconfig").value;
		
		$("#salaryPaymentDetailsDiv").excelexportjs({
			containerid: "salaryPaymentDetailsDiv", 
			datatype: 'json', 
			dataset: null, 
			gridId: "salaryPaymentDetailsGridID", 
			columns: getColumns("salaryPaymentDetailsGridID") ,   
			worksheetName:"WPS Listing"
			});
	}  
	
	function funWPSFormat(){
		
		if($('#txtestablishmentcode').val()==''){
			$("#salaryPaymentDetailsGridID").jqxGrid('clearselection');$("#salaryPaymentDetailsGridID").jqxGrid('clear');$("#salaryPaymentDetailsGridID").jqxGrid('addrow', null, {});
			 $.messager.alert('Message','Establishment Code is Mandatory.','warning');
			 return 0;
		 }
		
		if($('#txtbankaccountdocno').val()==''){
			$("#salaryPaymentDetailsGridID").jqxGrid('clearselection');$("#salaryPaymentDetailsGridID").jqxGrid('clear');$("#salaryPaymentDetailsGridID").jqxGrid('addrow', null, {});
			 $.messager.alert('Message','Bank Account is Mandatory.','warning');
			 return 0;
		 }
		
		var rows = $("#salaryPaymentDetailsGridID").jqxGrid('getrows');
		if(rows.length==1 && (rows[0].empdocno=="undefined" || rows[0].empdocno==null || rows[0].empdocno=="")){
			$.messager.alert('Warning','Please Submit & Click again.');
			return false;
		}
		var estcode = $("#txtestablishmentcode").val();
		var currentdate = new Date();   
		var year =new Date(currentdate.getFullYear(), ("0" + (currentdate.getMonth() + 1)).slice(-2), currentdate.getDate()).toLocaleDateString('en', {year: '2-digit'}); 
		var datetime = year+""+("0" + (currentdate.getMonth() + 1)).slice(-2)+""+currentdate.getDate()+""+currentdate.getHours()+""+currentdate.getMinutes()+""+("0"+currentdate.getSeconds()).slice(-2);                  
		console.log(datetime);
			  JSONToCSVConNew(dataSIF, estcode+""+datetime, true);  
		 
		    
	}
	function JSONToCSVConNew(JSONData, ReportTitle, ShowLabel) {
		 console.log(JSONData)
	    var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
	    
	   
	    var CSV = '';    
	    //Set Report title in first row or line
	    
	    //CSV += ReportTitle + '\r\n\n';

	    //This condition will generate the Label/Header
/* 	    if (ShowLabel) {     
	        var row = "";
	        
	        //This loop will extract the label from 1st index of on array
	        for (var index in arrData[0]) {
	            console.log(index)
	            //Now convert each value to string and comma-seprated
	            row += index + ',';
	        }

	        row = row.slice(0, -1);
	        
	        //append Label row with line break
	        CSV += row + '\r\n';
	    } */
	    
	    //1st loop is to extract each row
	    var strquote = "'";
	    
	    for (var i = 0; i < arrData.length; i++) {
	        var row = "";
	        
	        //2nd loop will extract each column and convert it in string comma-seprated
	        for (var index in arrData[i]) {
	        	console.log(index);
	            //row += strquote+'"' + arrData[i][index] + '",';
	            if(index=="ibanno" ||  index=="ifsccode" || index=="empid" || index=="fromdate" || index=="todate"){   
	            	if(isNaN(arrData[i][index])){
		            	row += arrData[i][index]+',';   
		            }else{
		            	console.log('='+arrData[i][index]);  
		            	if((arrData[i][index])!='' && (arrData[i][index])!=null){
		            		 row += strquote+arrData[i][index]+',';  
		            	}else{
		            		  row += arrData[i][index]+','; 
		            	}
		            }
	            }else{
	            	row += arrData[i][index]+','; 
	            }
	            
	        }

	        row.slice(0, row.length - 1);
	        
	        //add a line break after each row
	        CSV += row + '\r\n';
	    }

	    if (CSV == '') {        
	        //alert("Invalid data");
	        return;
	    }   
	    
	    //Generate a file name
	    var fileName = "";
	    //this will remove the blank-spaces from the title and replace it with an underscore
	    fileName += ReportTitle.replace(/ /g,"_");   
	    
		 // newly added 
	    var temp = CSV;
	    blob = new Blob([temp],{type: 'text/csv'});
	    var bigcsv= window.webkitURL.createObjectURL(blob);
	   
		
	    //Initialize file format you want csv or xls
	  //  var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
	    
	    // Now the little tricky part.
	    // you can use either>> window.open(uri);
	    // but this will not work in some browsers
	    // or you will not get the correct file extension    
	    
	    //this trick will generate a temp <a /> tag
	    var link = document.createElement("a");    
	     //  link.href = uri;
	      link.href = bigcsv;
	    
	    //set the visibility hidden so it will not effect on your web-layout
	    link.style = "visibility:hidden";
	    link.download = fileName + ".csv";
	    
	    //this part will append the anchor tag and remove it after automatic click
	    document.body.appendChild(link);
	    link.click();
	    document.body.removeChild(link);
	}
</script>
</head>
<body onload="getBranch();getYear();getPayrollCategory();getSalesAgent();">
<form id="frmDashboardSalaryPayment" action="saveDashboardSalaryPayment" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr >
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%">
	<jsp:include page="../../heading.jsp"></jsp:include>

	 <tr><td align="right"><label class="branch">Year</label></td>
     <td align="left"><select id="cmbyear" name="cmbyear" style="width:80%;" value='<s:property value="cmbyear"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbyear" name="hidcmbyear" value='<s:property value="hidcmbyear"/>'/></td></tr>
	 <tr><td align="right"><label class="branch">Month</label></td>
     <td align="left"><select id="cmbmonth" name="cmbmonth" style="width:80%;" value='<s:property value="cmbmonth"/>'>
      <option value="">--Select--</option><option value="01">January</option><option value="02">February</option><option value="03">March</option>
      <option value="04">April</option><option value="05">May</option><option value="06">June</option><option value="07">July</option>
      <option value="08">August</option><option value="09">September</option><option value="10">October</option><option value="11">November</option>
      <option value="12">December</option></select>
      <input type="hidden" id="hidcmbmonth" name="hidcmbmonth" value='<s:property value="hidcmbmonth"/>'/></td></tr>
     <tr><td align="right"><label class="branch">Agent Id</label></td>
	 <td align="left"><select id="cmbempagentid" style="width:80%;" name="cmbempagentid"  value='<s:property value="cmbempagentid"/>'></select></td></tr>
	 <tr><td align="right"><label class="branch">Category</label></td>
	 <td align="left"><select id="cmbempcategory" style="width:80%;" name="cmbempcategory"  value='<s:property value="cmbempcategory"/>'></select></td></tr>
	 <tr><td align="right"><label class="branch">Est.Code</label></td>
     <td align="left"><input type="text" id="txtestablishmentcode" name="txtestablishmentcode" style="width:80%;height:20;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtestablishmentcode"/>'  onkeydown="getEstablishmentCode(event);"/></td></tr>
     <tr><td align="right"><label class="branch">Payment</label></td>
     <td align="left"><div id="date" name="date" value='<s:property value="date"/>'></div>
     <input type="hidden" id="hiddate" name="hiddate" style="width:60%;height:20px;" readonly="readonly" value='<s:property value="hiddate"/>'/></td></tr>
     <tr><td align="right"><label class="branch">Bank</label></td>
     <td align="left"><input type="text" id="txtbankaccount" name="txtbankaccount" style="width:80%;height:20;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtbankaccount"/>'  onkeydown="getBankAccount(event);"/>
     <input type="hidden" id="txtbankaccountdocno" name="txtbankaccountdocno" value='<s:property value="txtbankaccountdocno"/>'/></td></tr>
     <tr><td colspan="2"><input type="text" id="txtbankaccountname" name="txtbankaccountname" readonly="readonly" placeholder="Bank Account" style="width:95%;height:20;" tabindex="-1" value='<s:property value="txtbankaccountname"/>'/></td></tr>
	 <tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();">
	 <input type="button" class="myButton" id="btnSifSalaryPayment" name="btnSifSalaryPayment" value="WPS Format" onclick="funWPSFormat();">
	 <!-- <input type="button" class="mySaveButton" id="btnSaveSalaryPayment" name="btnSaveSalaryPayment" value="Save" onclick="funNotify();"> --></td></tr>
     <tr><td colspan="2">&nbsp;<input type="hidden" id="txtselectedemployees" name="txtselectedemployees" value='<s:property value="txtselectedemployees"/>'/>
     <input type="hidden" name="txtdrtotal" id="txtdrtotal" style="width:100%;height:20px;" value='<s:property value="txtdrtotal"/>'>
     <input type="hidden" name="txtcrtotal" id="txtcrtotal" style="width:100%;height:20px;" value='<s:property value="txtcrtotal"/>'>
     <input type="hidden" id="gridlength" name="gridlength" style="width:100%;height:20px;" value='<s:property value="gridlength"/>'/>
     <input type="hidden" name="mode" id="mode" style="width:100%;height:20px;" value='<s:property value="mode"/>'>
     <input type="hidden" name="msg" id="msg" style="width:100%;height:20px;" value='<s:property value="msg"/>'> 
     <input type="hidden" name="excelconfig" id="excelconfig" style="width:100%;height:20px;" value='<s:property value="excelconfig"/>'></td></tr>
     <tr><td class="tdheight">&nbsp;</td></tr>   
	 </table>
	 </fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr><td><div id="salaryPaymentDetailsDiv"><jsp:include page="salaryPaymentGrid.jsp"></jsp:include></div></td></tr>
	</table>
</td></tr></table>

</div>
<div id="accountDetailsWindow">
   <div></div>
</div>
<div id="establishedCodeDetailsWindow">
   <div></div>
</div>
</div> 
</form>
</body>
