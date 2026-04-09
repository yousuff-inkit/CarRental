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
/* =========================================================
   PETTY CASH - EXACT TEXT & UI MATCH TO CLIENT MASTER
========================================================= */
body, .homeContent {
    background: #f4f6f9 !important;
    font-family: Arial, sans-serif !important;
    color: #333 !important;
    font-size: 12px !important;
    margin: 0;
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

/* FIX: Responsive scroll area so the bottom is never cut off */
.hidden-scrollbar {
    overflow-y: auto;
    overflow-x: hidden;
    height: calc(100vh - 140px);
    padding-bottom: 60px;
    box-sizing: border-box;
}

form label.error {
    color: red;
    font-weight: bold;
}

#validrate {
    color: red;
}

/* EXACT Input Styles from Client Master */
/* FIX: No width: 100% to keep your exact layout widths intact */
input[type="text"], input[type="email"], select {
    height: 24px !important; 
    border: 1px solid #ccc !important;
    border-radius: 3px !important;
    padding: 2px 6px !important;
    font-size: 12px !important;
    box-sizing: border-box;
    background-color: #fff !important;
    color: #333 !important;
}

input[type="text"]:focus, input[type="email"]:focus, select:focus {
    border-color: #007bff !important;
    outline: none !important;
}

input[readonly], input:disabled, select:disabled {
    background-color: #f4f5f7 !important;
    color: #5e6c84 !important;
    border-color: #e1e4e8 !important;
}

/* Fieldset and Legend styling matching Client Master */
fieldset {
    border: 1px solid #e1e4e8 !important;
    background-color: #fff !important;
    margin-bottom: 10px !important;
    padding: 12px 10px 10px 10px !important;
    border-radius: 4px !important;
}

legend {
    font-size: 13px !important;
    font-weight: bold !important;
    color: #0056b3 !important;
    padding: 0 0 0 6px !important;
    border-left: 3px solid #0056b3 !important;
    margin-bottom: 5px !important;
    background: #fff;
}

/* Table adjustments for compact text */
table td {
    padding: 4px 6px !important;
    font-size: 12px !important;
    color: #444 !important;
    font-weight: bold !important;
    vertical-align: middle;
}

/* Modern Buttons matched to Client Master */
.myButton {
    background-color: #0056b3 !important;
    color: #ffffff !important;
    border: none !important;
    border-radius: 3px !important;
    padding: 4px 15px !important;
    font-weight: bold !important;
    font-size: 12px !important;
    cursor: pointer !important;
    height: 24px !important;
}

.myButton:hover {
    background-color: #004494 !important;
}
</style>

<script type="text/javascript">
	$(document).ready(function() {
		 $("#btnvaluechange").hide();
		
         /* MODIFIED: Heights set to 24px */
		 $("#jqxPettyCashDate").jqxDateTimeInput({ width: '125px', height: '24px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '24px', formatString:"dd.MM.yyyy"});
		 $('#txtforsearch').val(2);
		 
		 $('#accountDetailsFromWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsFromWindow').jqxWindow('close');  
		 
		 $('#pettyCashGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#pettyCashGridWindow').jqxWindow('close');
		 
		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#costTypeSearchGridWindow').jqxWindow('close');
 		 
 		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
		 
		 $('#jqxPettyCashDate').on('change', function (event) {
				var paydate = $('#jqxPettyCashDate').jqxDateTimeInput('getDate');
			    var validdate=funDateInPeriod(paydate);
				if(parseInt(validdate)==0){
					document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
					return 0;	
				}
	     });
		 
		 $('#txtaccid').dblclick(function(){
			  var date = $('#jqxPettyCashDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountSearchContent("<%=contextPath%>/com/finance/accountsDetailsSearch.jsp?date="+date);
        	  $('#txtforsearch').val(2);
		});
		 
	});
	
	function PettyCashSearchContent(url) {
		$('#pettyCashGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#pettyCashGridWindow').jqxWindow('setContent', data);
		$('#pettyCashGridWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function accountSearchContent(url) {
		    $('#accountDetailsFromWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#accountDetailsFromWindow').jqxWindow('setContent', data);
			$('#accountDetailsFromWindow').jqxWindow('bringToFront');
		}); 
		}
	
	function costTypeSearchContent(url) {
	    $('#costTypeSearchGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costTypeSearchGridWindow').jqxWindow('setContent', data);
		$('#costTypeSearchGridWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function costCodeSearchContent(url) {
	    $('#costCodeSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costCodeSearchWindow').jqxWindow('setContent', data);
		$('#costCodeSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	

	
	 function funReadOnly(){
			$('#frmPettyCash input').attr('readonly', true );
			$('#frmPettyCash select').attr('disabled', true);
			$('#jqxPettyCashDate').jqxDateTimeInput({disabled: true});
			$("#jqxPettyCash").jqxGrid({ disabled: true});
			$("#btnvaluechange").hide();
	 }
	 
	 function funRemoveReadOnly(){
		    $('#txtforsearch').val(2);
			$('#frmPettyCash input').attr('readonly', false );
			$('#frmPettyCash select').attr('disabled', false);
			$('#cmbcurrency').attr('disabled', true);
			$('#txtaccid').attr('readonly', true );
			$('#txtaccname').attr('readonly', true );
			$('#txtamount').attr('readonly', true );
			$('#txtbaseamount').attr('readonly', true );
			$('#jqxPettyCashDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$("#jqxPettyCash").jqxGrid({ disabled: false});
			
			var date = $('#jqxPettyCashDate').val();
		    getCurrencyId(date);
		    
			if ($("#mode").val() == "E") {
         	    $("#btnvaluechange").show();
         	    $('#frmPettyCash input').attr('readonly', true );
   			    $('#frmPettyCash select').attr('disabled', true);
			    $("#jqxPettyCash").jqxGrid({ disabled: true});
   			    $('#txtrefno').attr('readonly', false );
   			 	$('#txtdescription').attr('readonly', false);
   			    $("#jqxPettyCash").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","amount1": "","description": ""});
			  }
			 else{
				$("#btnvaluechange").hide();
			} 
			
			if ($("#mode").val() == "A") {
				$('#jqxPettyCashDate').val(new Date());
				$("#jqxPettyCash").jqxGrid('clear'); 
				$("#jqxPettyCash").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","amount1": "","description": ""});
			}
			
	 }
	 
	 function funSearchLoad(){
		 changeContent('pcMainSearch.jsp');  
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#jqxPettyCashDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	   $(function(){
	        $('#frmPettyCash').validate({
	                rules: {
	                txtaccid:"required",
	                txtamount:{"required":true,number:true},
	                txtdescription:{maxlength:500}
	                 },
	                 messages: {
	                 txtaccid:" *",
	                 txtamount:{required:" *",number:"Invalid"},
	                 txtdescription: {maxlength:"    Max 500 chars"}
	                 }
	        });});
	   
	  function funNotify(){
		 
			docno=document.getElementById("txtdocno").value;
		  if(docno==""){
				document.getElementById("errormsg").innerText="Select cash account.";
				return 0;	
			}
		  var summ= $("#jqxPettyCash").jqxGrid('getcolumnaggregateddata', 'amount1', ['sum'],true);
	   		 var sum1=summ.sum.replace(/,/g,'');
		  if(sum1==0){
			   document.getElementById("errormsg").innerText="Enter amount value.";
				return 0;
		  }
		  /* Validation */
		    var paydate = $('#jqxPettyCashDate').jqxDateTimeInput('getDate');
			var validdate=funDateInPeriod(paydate);
			if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
			}
			
			currency=document.getElementById("cmbcurrency").value;
			 if(currency==""){
				 document.getElementById("errormsg").innerText="Currency & Rate is Mandatory.";
				 return 0;
			 }
			 

				rate=document.getElementById("txtrate").value;
				 if(rate=="" || rate=="0" || rate=="0.00"){
					 document.getElementById("errormsg").innerText= "Rate is Mandatory.";
					 return 0;
				 }
			  
		  
		   	document.getElementById("errormsg").innerText=""; 
	    		
	    /* Validation Ends*/
	    		
	     /* Petty Cash Grid  Saving*/
			 var rows = $("#jqxPettyCash").jqxGrid('getrows');
			 var length=0,val=0;
				 for(var i=0 ; i < rows.length ; i++){
					var chk=rows[i].docno;
					var rate=rows[i].rate;
					if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
						newTextBox = $(document.createElement("input"))
					    .attr("type", "dil")
					    .attr("id", "test"+length)
					    .attr("name", "test"+length)
						.attr("hidden", "true");
						length=length+1;
						if(rate=="" || rate=="0" || rate=="0.00"){
							  val=1;
							  break;
						 }	
			    newTextBox.val(rows[i].docno+"::"+rows[i].currencyid+"::"+rows[i].rate+"::true::"+rows[i].amount1+"::"+rows[i].description+"::"+rows[i].baseamount1+"::0:: "+rows[i].costtype+":: "+rows[i].costcode);
				newTextBox.appendTo('form');
				 }
				}
				 if(val==1){
					 document.getElementById("errormsg").innerText= "Rate is Mandatory.";
					 return 0;
				 }  
				$('#gridlength').val(length);
	 		   /* Petty Cash Grid  Saving Ends*/	
	 		   $('#cmbcurrency').attr('disabled', false);
	  
	    		return 1;
		} 
	  
	  
	  function setValues(){
		  $('#jqxPettyCashDate').jqxDateTimeInput({disabled: false});
		  var date = $('#jqxPettyCashDate').val();
		  getCurrencyId(date);
		  $('#jqxPettyCashDate').jqxDateTimeInput({disabled: true});
		  
		  if($('#hidjqxPettyCashDate').val()){
				 $("#jqxPettyCashDate").jqxDateTimeInput('val', $('#hidjqxPettyCashDate').val());
			  }
		  
		  if($('#hidmaindate').val()){
				 $("#maindate").jqxDateTimeInput('val', $('#hidmaindate').val());
			  }
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
			
			 var indexVal = document.getElementById("docno").value;
			 if(indexVal>0){
				 var check = 1;
	             $("#jqxPettyCashGrid").load("pettyCashGrid.jsp?txtpettycashdocno2="+indexVal+"&check="+check);
			 }
			
			if(parseFloat($("#hidstatus").val())<3){
					$("#txtStatus").html("DRAFT");
			}else if(parseFloat($("#hidstatus").val())==4){
					$("#txtStatus").html("REJECTED");
			}else{
					$("#txtStatus").html("");
			}
			funRoundRate($('#txtrate').val(),"txtrate");
			funRoundAmt($('#txtamount').val(),"txtamount");
			funRoundAmt($('#txtbaseamount').val(),"txtbaseamount");
		}
	  
	  function funvalid(){
		  rate=document.getElementById("txtrate").value;
			 if(rate=="" || rate=="0" || rate=="0.00"){
				 document.getElementById("validrate").innerText= "Rate is Mandatory.";
				 document.getElementById("txtrate").focus();
				 return 0;
			 }
			 else{
				 document.getElementById("validrate").innerText= "";
				 
			 }
	  }
	
	  
	  function getDrTotal(){
		  var amount = $('#txtbaseamount').val();
		  if(!isNaN(amount)){
			  $('#txtdrtotal').val(amount);
		  }
		  else if(isNaN(amount)){
		  	$('#txtdrtotal').val(0.00);
		  	$('#txtamount').val(0.00);
		  }
	  }
	  
	  function getAcc(event){
          var x= event.keyCode;
          if(x==114){
        	  var date = $('#jqxPettyCashDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountSearchContent("<%=contextPath%>/com/finance/accountsDetailsSearch.jsp?date="+date);
        	  $('#txtforsearch').val(2);
          }
          else{}
          }
	  
	  function funPrintBtn() {
			
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
		        var url=document.URL;
		        var reurl=url.split("savePettyCash");
		        $("#docno").prop("disabled", false); 
		       
		        $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
					if (r){
						 var win= window.open(reurl[0]+"printPettyCashPayment?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					     win.focus();

					 }
					else{
						var win= window.open(reurl[0]+"printPettyCashPayment?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
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
		  var date = $('#jqxPettyCashDate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(date);
		  if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
		  }
		  $("#maindate").jqxDateTimeInput('val', date);
	  }
	
	  function funwarningopen(){
			 $.messager.confirm('Confirm', 'Transaction will affect Links to the applied Bank Reconcilations & Prepayments.', function(r){
				    if (r){
				    	$("#mode").val("EDIT");
						 $('#txtaccid').attr('readonly', true);$('#txtaccname').attr('readonly', true);$('#txtamount').attr('readonly', false);
						 $('#txtdescription').attr('readonly', false);$('#txtrate').attr('readonly', false);$('#txtbaseamount').attr('readonly', true);
						 $('#frmPettyCash select').attr('disabled', false);$("#jqxPettyCash").jqxGrid({ disabled: false});  
				         $('#cmbcurrency').attr('disabled',true);
				    }
				   });
		  }
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmPettyCash" action="savePettyCash" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br>

<div  class='hidden-scrollbar'>

<table width="100%" cellpadding="3" cellspacing="0" style="margin-bottom: 5px;">
  <tr>
    <td width="10%" align="right">Date</td>
    <td width="20%">
        <div id="jqxPettyCashDate" name="jqxPettyCashDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxPettyCashDate"/>'></div>
        <input type="hidden" id="hidjqxPettyCashDate" name="hidjqxPettyCashDate" value='<s:property value="hidjqxPettyCashDate"/>'/>
    </td>
    <td width="10%" align="right">Ref. No.</td>
    <td width="30%" style="display: flex; gap: 5px; align-items: center;">
        <input type="text" id="txtrefno" name="txtrefno" style="width:50%;" value='<s:property value="txtrefno"/>'/>
        <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();" style="padding: 2px 8px !important;">Value Change</button>
    </td>
    <td width="10%" align="right">Doc No.</td>
    <td width="20%">
        <input type="text" id="docno" name="txtpettycashdocno" style="width:100%; background-color:#f4f5f7;" value='<s:property value="txtpettycashdocno"/>' tabindex="-1" readonly/>
    </td>
  </tr>
  <tr>
    <td colspan="5"></td>
    <td align="center"><span id="txtStatus" style="font-weight:bold; color:#cc0000;"></span></td>
  </tr>
</table>

<fieldset>
<legend>Petty Cash Details</legend>
<table width="100%" cellpadding="3" cellspacing="0">
  <tr>
    <td width="10%" align="right">Cash</td>
    <td width="40%" style="display: flex; gap: 5px;">
        <input type="text" id="txtaccid" name="txtaccid" style="width:30%;" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>'  onkeydown="getAcc(event);"/>
        <input type="text" id="txtaccname" name="txtaccname" style="width:70%; background-color:#f4f5f7;" value='<s:property value="txtaccname"/>' tabindex="-1" readonly/>
        <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
    </td>
    <td width="10%" align="right">Currency</td>
    <td width="20%">
        <select id="cmbcurrency" name="cmbcurrency" style="width:100%;" value='<s:property value="cmbcurrency"/>' onload="getRatevalue(this.value,$('#jqxPettyCashDate').val());" onchange="getRatevalue(this.value,$('#jqxPettyCashDate').val());">
            <option></option>
        </select>
        <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency" value='<s:property value="hidcmbcurrency"/>'/>
        <input type="hidden" id="hidcurrencytype" name="hidcurrencytype" value='<s:property value="hidcurrencytype"/>'/>
    </td>
    <td width="5%" align="right">Rate</td>
    <td width="15%">
        <input type="text" id="txtrate" name="txtrate" onchange="funvalid()" style="width:100%; text-align: right;" value='<s:property value="txtrate"/>' onblur="funRoundRate(this.value,this.id);" tabindex="-1"/>
        <span id="validrate"></span>
    </td>
  </tr>
  <tr>
    <td align="right">Amount</td>
    <td style="display: flex; gap: 5px; align-items: center;">
        <input type="text" id="txtamount" name="txtamount" style="width:40%; text-align: right; background-color:#f4f5f7;" value='<s:property value="txtamount"/>' readonly onblur="funRoundAmt(this.value,this.id);" tabindex="-1"/>
        <span style="font-weight:bold; color:#444; width:30%; text-align:right;">Base Amount</span>
        <input type="text" id="txtbaseamount" name="txtbaseamount" style="width:30%; text-align: right; background-color:#f4f5f7;" readonly value='<s:property value="txtbaseamount"/>' tabindex="-1"/>
    </td>
    <td align="right">Description</td>
    <td colspan="3">
        <input type="text" id="txtdescription" name="txtdescription" style="width:100%;" value='<s:property value="txtdescription"/>'/>
    </td>
  </tr>
</table>
</fieldset>

<br/>
<div id="jqxPettyCashGrid"><jsp:include page="pettyCashGrid.jsp"></jsp:include></div>
<br/>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
<div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
<input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
<input type="hidden" name="txtforsearch" id="txtforsearch" value='<s:property value="txtforsearch"/>'>
<input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
<input type="hidden" id="txttranid" name="txttranid" value='<s:property value="txttranid"/>'/>
<input type="hidden" id="hidstatus" name="hidstatus" value='<s:property value="status"/>'/>
</div>
</form>
	
<div id="pettyCashGridWindow">
	<div></div><div></div>
</div>  
				
<div id="accountDetailsFromWindow">
	<div></div><div></div>
</div>  
	 
<div id="costTypeSearchGridWindow">
	<div></div><div></div>
</div> 

<div id="costCodeSearchWindow">
	<div></div><div></div>
</div> 
	
</div>
</body>
</html>