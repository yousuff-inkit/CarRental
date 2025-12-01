<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i) - Tax Credit Note</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/globalcss.css">

<script type="text/javascript">
	$(document).ready(function() {
		/* JQX Date: make it full width and same height as inputs */
		$("#jqxCreditNoteDate").jqxDateTimeInput({
		    width: '100%',
		    height: 36,
		    formatString: "dd.MM.yyyy"
		});
		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $('#txtforsearch').val(2);

		 /* windows used for search dialogs */
		 $('#accountDetailsToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsToWindow').jqxWindow('close');
		 $('#creditNoteGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#creditNoteGridWindow').jqxWindow('close');
		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#costTypeSearchGridWindow').jqxWindow('close');
 		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');

		 $('#jqxCreditNoteDate').on('change', function (event) {
				var creditdate = $('#jqxCreditNoteDate').jqxDateTimeInput('getDate');
				var validdate=funDateInPeriod(creditdate);
				if(parseInt(validdate)==0){
					document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
					return 0;
				}
			 });

		$('#txtaccid').dblclick(function(){
			  var date = $('#jqxCreditNoteDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtype').val()+"&date="+date);
			  $('#txtforsearch').val(2);
	    });

	});
	/* --- remaining functions kept as-is --- */

	function CreditSearchContent(url) {
		$('#creditNoteGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
			$('#creditNoteGridWindow').jqxWindow('setContent', data);
			$('#creditNoteGridWindow').jqxWindow('bringToFront');
		});
	}

	function accountSearchContent(url) {
		$('#accountDetailsToWindow').jqxWindow('open');
		$.get(url).done(function (data) {
			$('#accountDetailsToWindow').jqxWindow('setContent', data);
			$('#accountDetailsToWindow').jqxWindow('bringToFront');
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

	function funwarningopen(){
		$.messager.confirm('Confirm', 'Transaction will affect Links to the applied Bank Reconcilations & Prepayments.', function(r){
		    if (r){
		    	 $("#mode").val("EDIT");
				 $('#txtaccid').attr('readonly', true);$('#txtaccname').attr('readonly', true);$('#txtamount').attr('readonly', false);$('#txtdescription').attr('readonly', false);
				 $('#txtrate').attr('readonly', false);$('#txtbaseamount').attr('readonly', true);$('#txtdrtotal').attr('readonly', true);$('#txtcrtotal').attr('readonly', true);
				 $('#frmTaxCreditNote select').attr('disabled', false);$("#jqxCreditNote").jqxGrid({ disabled: false});$('#frmTaxCreditNote select').attr('disabled', false);
		         $('#cmbcurrency').attr('disabled',true);
			}
		});
	}

	function funReadOnly(){
		$('#frmTaxCreditNote input').attr('readonly', true );
		$('#frmTaxCreditNote select').attr('disabled', true);
		$('#jqxCreditNoteDate').jqxDateTimeInput({disabled: true});
		$("#jqxCreditNote").jqxGrid({ disabled: true});
		$("#btnvaluechange").hide();
	}
	function funRemoveReadOnly(){
			$('#txtforsearch').val(2);
			$('#frmTaxCreditNote input').attr('readonly', false );
			$('#frmTaxCreditNote select').attr('disabled', false);
			$('#cmbcurrency').attr('disabled', true);

			$('#txtaccid').attr('readonly', true );
			$('#txtaccname').attr('readonly', true );
			$('#txtnettotal').attr('readonly', true );
		    $('#txtbaseamount').attr('readonly', true);
			$('#jqxCreditNoteDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$("#jqxCreditNote").jqxGrid({ disabled: false});

			var date = $('#jqxCreditNoteDate').val();
		    getCurrencyId(date);

		   if ($("#mode").val() == "E") {
				$("#btnvaluechange").show();
      	        $('#frmTaxCreditNote input').attr('readonly', true );
			    $('#frmTaxCreditNote select').attr('disabled', true);
			    $("#jqxCreditNote").jqxGrid({ disabled: true});
			    $("#jqxCreditNote").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","dr": true,"amount1": "","description": ""});
			    $('#txtdescription').attr('readonly', false );
			    $('#txtrefno').attr('readonly', false );
			  }
			 else{
				$("#btnvaluechange").hide();
			}

			if ($("#mode").val() == "A") {
				$('#jqxCreditNoteDate').val(new Date());
				$("#jqxCreditNote").jqxGrid('clear');
				$("#jqxCreditNote").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","dr": true,"amount1": "","description": ""});
			}
	}

	function funSearchLoad(){ changeContent('cnoMainSearch.jsp'); }
	function funChkButton(){ /* funReset(); */ }
	function funFocus(){ $('#jqxCreditNoteDate').jqxDateTimeInput('focus'); }

	$(function(){
	    $('#frmTaxCreditNote').validate({
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
	    });
	});

	/* Validation + Save handling kept exactly (unchanged business logic) */
	function funNotify(){
	    var creditdate = $('#jqxCreditNoteDate').jqxDateTimeInput('getDate');
	    var taxacc=document.getElementById("taxaccount").value;
		var validdate=funDateInPeriod(creditdate);
		if(parseInt(validdate)==0){
			document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
			return 0;
		}

		acctype=document.getElementById("cmbtype").value;
		if(acctype==""){
			document.getElementById("errormsg").innerText="Account Type is Mandatory.";
			return 0;
		}
		accid=document.getElementById("txtdocno").value;
		if(accid==""){
			document.getElementById("errormsg").innerText="Account is Mandatory.";
			return 0;
		}
		currencyto=document.getElementById("cmbcurrency").value;
		currencyrate=document.getElementById("txtrate").value;
		if(currencyto=="" || currencyrate==""){
			document.getElementById("errormsg").innerText="Currency & Rate is Mandatory.";
			return 0;
		}

	    var drtot = parseFloat(document.getElementById("txtdrtotal").value);
 		var crtot = parseFloat(document.getElementById("txtcrtotal").value);

 		if(drtot>crtot || drtot<crtot){
 			document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should be Equal.";
          return 0;
 		}
 		if(drtot=="" || crtot=="" ){
 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should be Equal.";
              return 0;
	 		}
 		if(isNaN(drtot) || isNaN(crtot)){
 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should be Equal.";
              return 0;
	 		}
 		if(drtot==0 || crtot==0){
 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should not be Zero.";
              return 0;
	 		}
 		if(drtot==0.0 || crtot==0.0){
 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should not be Zero.";
              return 0;
	 		}
 		if(drtot==0.00 || crtot==0.00){
 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should not be Zero.";
              return 0;
	 		}
 		rate=document.getElementById("txtrate").value;
		 if(rate=="" || rate=="0" || rate=="0.00"){
			 document.getElementById("errormsg").innerText= "Rate is Mandatory.";
			 return 0;
		 }

 		document.getElementById("errormsg").innerText="";

	    /* Grid saving assembly */
		var rows = $("#jqxCreditNote").jqxGrid('getrows');
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
				var amount,baseamount,nettotal,taxamnt;
				if(rows[i].dr==true){
					 amount=rows[i].amount1;
					 baseamount=rows[i].baseamount1;
					 taxamnt=rows[i].taxamount;
				}
				else if(rows[i].dr==false){
					 amount=rows[i].amount1*-1;
					 baseamount=rows[i].baseamount1*-1;
					 taxamnt=rows[i].taxamount*-1;
				}
				newTextBox.val(rows[i].docno+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+rows[i].dr+"::"+amount+"::"+rows[i].description+"::"+baseamount+":: "+rows[i].costtype+":: "+rows[i].costcode+":: "+rows[i].tax+":: "+taxamnt+":: "+rows[i].nettotal+":: "+taxacc+":: "+taxamnt);
				newTextBox.appendTo('form');
			}
		}
		if(val==1){
			 document.getElementById("errormsg").innerText= "Rate is Mandatory.";
			 return 0;
		 }
		$('#gridlength').val(length);
		$('#cmbcurrency').attr('disabled',false);
		return 1;
	}

	function setValues(){
		$('#jqxCreditNoteDate').jqxDateTimeInput({disabled: false});
		var date = $('#jqxCreditNoteDate').val();
		getCurrencyId(date);
		$('#jqxCreditNoteDate').jqxDateTimeInput({disabled: true});

		document.getElementById("cmbtype").value=document.getElementById("hidcmbtype").value;
		document.getElementById("cmbcurrency").value=document.getElementById("hidcmbcurrency").value;

		if($('#hidjqxCreditNoteDate').val()){
			 $("#jqxCreditNoteDate").jqxDateTimeInput('val', $('#hidjqxCreditNoteDate').val());
		  }

		if($('#hidmaindate').val()){
			 $("#maindate").jqxDateTimeInput('val', $('#hidmaindate').val());
		  }

		if($('#msg').val()!=""){ $.messager.alert('Message',$('#msg').val()); }

		document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		funSetlabel();

		var indexVal = document.getElementById("docno").value;
		if(indexVal>0){
			var check = 1;
            $("#jqxCreditNoteGrid").load("creditNoteGrid.jsp?txtcreditnotedocno2="+indexVal+"&check="+check);
		}
		funRoundRate($('#txtrate').val(),"txtrate");
		funRoundAmt($('#txtamount').val(),"txtamount");
		funRoundAmt($('#txtbaseamount').val(),"txtbaseamount");
		funRoundAmt($('#txtdrtotal').val(),"txtdrtotal");
		funRoundAmt($('#txtcrtotal').val(),"txtcrtotal");
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

	function getCrTotal(){
	  var fromamount = $('#txtbaseamount').val();
	  var baseamount = 0;
	  if(!isNaN(fromamount)){
		    var dr=0.0,cr=0.0,cr1=0.0;
	        var rows = $('#jqxCreditNote').jqxGrid('getrows');
	        var rowlength= rows.length;
	 		for(var i=0;i<=rowlength-1;i++) {
	 		 var value = rows[i].dr;
             baseamount = rows[i].nettotal;
             if(typeof(baseamount) != "undefined" && typeof(baseamount) != "NaN" && baseamount != ""){
            	 if(value==true){
	              	if(!isNaN(baseamount)){
	                  	dr=dr+baseamount;
	              	}else{
	              		baseamount=0.00;
	              		dr=dr+baseamount;
	              	}
                 }
                 else{
	              	if(!isNaN(baseamount)){
	              		cr=cr+baseamount;
	              	}else{
	              		baseamount=0.00;
	              		cr=cr+baseamount;
	              	}
                 }
             }
	 		}
	 		if(!isNaN(fromamount)){
                cr1=parseFloat(cr) + parseFloat(fromamount);
                funRoundAmt(cr1,"txtcrtotal");
             }
	  }
	  else if(isNaN(fromamount)){
		  $('#txtamount').val(0.00);
		  $('#txtcrtotal').val(0.00);
		  $('#txtdrtotal').val(0.00);
	  }
	}

	function getAccType(event){
       var x= event.keyCode;
       if(x==114){
    	  var date = $('#jqxCreditNoteDate').jqxDateTimeInput('getDate');
		  $("#maindate").jqxDateTimeInput('val', date);
		  accountSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtype').val()+"&date="+date);
    	  $('#txtforsearch').val(2);
       }
    }

	function funPrintBtn() {
		if (($("#mode").val() == "view") && $("#docno").val()!="") {
	        var url=document.URL;
	        var reurl=url.split("saveTaxCreditNote");
	        $("#docno").prop("disabled", false);

	        $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
				if (r){
					 var win= window.open(reurl[0]+"printTaxCreditNote?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
				     win.focus();
				 }
				else{
					var win= window.open(reurl[0]+"printTaxCreditNote?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
				    win.focus();
				}
			   });
	     }
	    else {
			$.messager.alert('Message','Select a Document....!','warning');
			return;
		}
    }

	function clearClientInfo(){
		$("#txtdocno").val('');$("#txtaccid").val('');$("#txtaccname").val('');
	}

	function datechange(){
		  var date = $('#jqxCreditNoteDate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(date);
		  if(parseInt(validdate)==0){
			document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
			return 0;
		  }
		  $("#maindate").jqxDateTimeInput('val', date);
	}
</script>

<style>
.inp {
    width: 100%;
    height: 32px !important;
    padding: 4px 8px !important;
    font-size: 15px !important;
    border-radius: 10px !important;
    border: 1px solid #b9c9e8 !important;
    background: #fff !important;
    transition: 0.25s;
}

.inp:hover,
.inp:focus {
    border-color: #2f6dde !important;
    box-shadow: 0 0 8px rgba(47,109,222,0.4) !important;
    outline: none !important;
}

/* ------------------------------
   Labels
------------------------------ */
.lbl {
    min-width: 110px;
    font-size: 18px;
    font-weight: 600;
    color: #1d2a4d;
}

/* Smaller labels for Totals */
.lbl.small {
    font-size: 16px;
    min-width: 90px;
}

/* ------------------------------
   Layout Rows
------------------------------ */
.row-flex {
    display: flex;
    align-items: center;
    gap: 10px;
    flex: 1;
    min-width: 260px;
}

.row3 {
    display: flex;
    gap: 25px;
    flex-wrap: wrap;
    margin-bottom: 18px;
}

/* ------------------------------
   Dropdown text increase
------------------------------ */
select.inp,
select.inp option {
    font-size: 18px !important;
}

/* ------------------------------
   Remove Pink Autofill
------------------------------ */
input:-webkit-autofill {
    -webkit-box-shadow: 0 0 0 1000px white inset !important;
    -webkit-text-fill-color: black !important;
}

/* ------------------------------
   JQX Date Input – Keep White
------------------------------ */
#jqxCreditNoteDate * {
    background: #ffffff !important;
    -webkit-box-shadow: none !important;
    box-shadow: none !important;
    -webkit-text-fill-color: #000 !important;
}

/* ------------------------------
   Dr/Cr Totals Modern Container
------------------------------ */
.totals-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 18px;
    padding: 18px;
    background: #f6f8ff;
    border-radius: 14px;
    border: 1px solid #d8e3ff;
}

/* Each total block */
.total-box {
    display: flex;
    align-items: center;
    gap: 12px;
}

/* Total input fields */
.total-inp {
    width: 120px !important;
    height: 32px !important;
    padding: 4px 8px !important;
    text-align: right !important;
    font-size: 15px !important;
    border-radius: 10px !important;
    border: 1px solid #b9c9e8 !important;
}
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">

<form id="frmTaxCreditNote" action="saveTaxCreditNote" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<!-- EXACT SAME WRAPPER AS MASTER -->
<div class="hidden-scrollbar receipt-header">

    <!-- EXACT SAME SECTION-BLOCK WRAPPING -->
    <div class="section-block">
        <h2>Credit Note Details</h2>

        <!-- ROW 1 -->
        <div class="row3">

            <div class="row-flex">
                <label class="lbl">Date</label>
                <div id="jqxCreditNoteDate" class="inp"></div>
                <input type="hidden" id="hidjqxCreditNoteDate"
                       name="hidjqxCreditNoteDate"
                       value='<s:property value="hidjqxCreditNoteDate"/>'>
            </div>

            <div class="row-flex">
                <label class="lbl">Ref. No.</label>
                <input type="text" class="inp"
                    id="txtrefno" name="txtrefno"
                    value='<s:property value="txtrefno"/>'>
            </div>

            <div class="row-flex">
                <label class="lbl">Doc No.</label>
                <input type="text" class="inp"
                    id="docno" name="txtcreditnotedocno"
                    value='<s:property value="txtcreditnotedocno"/>'>
            </div>

        </div>

        <!-- ROW 2 -->
        <div class="row3">

            <div class="row-flex">
                <label class="lbl">Type</label>
                <select class="inp" id="cmbtype" name="cmbtype"
                        onchange="clearClientInfo();">
                    <option value="AR">AR</option>
                    <option value="AP">AP</option>
                    <option value="GL">GL</option>
                </select>
                <input type="hidden" id="hidcmbtype"
                       name="hidcmbtype"
                       value='<s:property value="hidcmbtype"/>'/>
            </div>

            <div class="row-flex">
                <label class="lbl">Account</label>
                <input type="text" class="inp"
                       id="txtaccid" name="txtaccid"
                       placeholder="Press F3 to Search"
                       value='<s:property value="txtaccid"/>'
                       onkeydown="getAccType(event);">
            </div>

            <div class="row-flex">
                <label class="lbl">Account Name</label>
                <input type="text" class="inp"
                       id="txtaccname" name="txtaccname"
                       value='<s:property value="txtaccname"/>'>
                <input type="hidden" id="txtdocno" name="txtdocno"
                       value='<s:property value="txtdocno"/>'>
                <input type="hidden" id="txttrno" name="txttrno"
                       value='<s:property value="txttrno"/>'>
            </div>

        </div>

        <!-- ROW 3 -->
        <div class="row3">

            <div class="row-flex">
                <label class="lbl">Currency</label>
                <select class="inp" id="cmbcurrency" name="cmbcurrency"
                        onchange="getRatevalue(this.value,$('#jqxCreditNoteDate').val());">
                </select>
                <input type="hidden" id="hidcmbcurrency"
                       name="hidcmbcurrency"
                       value='<s:property value="hidcmbcurrency"/>'>
            </div>

            <div class="row-flex">
                <label class="lbl">Rate</label>
                <input type="text" class="inp"
                       id="txtrate" name="txtrate"
                       style="text-align:right;"
                       value='<s:property value="txtrate"/>'
                       onblur="funRoundRate(this.value,this.id);getBaseAmountFrom();getCrTotal();">
            </div>

            <div class="row-flex">
                <label class="lbl">Amount</label>
                <input type="text" class="inp"
                       id="txtamount" name="txtamount"
                       style="text-align:right;"
                       value='<s:property value="txtamount"/>'
                       onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getCrTotal();">
            </div>

        </div>

        <!-- ROW 4 -->
        <div class="row3">

            <div class="row-flex">
                <label class="lbl">Base Amount</label>
                <input type="text" class="inp"
                       id="txtbaseamount" name="txtbaseamount"
                       style="text-align:right;"
                       value='<s:property value="txtbaseamount"/>'>
            </div>

            <div class="row-flex">
                <label class="lbl">Description</label>
                <input type="text" class="inp"
                       id="txtdescription" name="txtdescription"
                       value='<s:property value="txtdescription"/>'>
            </div>

        </div>

    </div> <!-- END section-block -->

    <!-- ========== GRID SECTION ========== -->
    <div class="cr-table" id="jqxCreditNoteGrid" style="margin-top:18px;">
        <jsp:include page="creditNoteGrid.jsp"></jsp:include>
    </div>
    <br/>

    <!-- ========== TOTALS ========== -->
    <div class="totals-row">

    <div class="total-box">
        <label class="lbl small">Dr. Total</label>
        <input type="text" id="txtdrtotal" name="txtdrtotal"
               class="inp total-inp"
               value='<s:property value="txtdrtotal"/>'
               tabindex="-1" />
    </div>

    <div class="total-box">
        <label class="lbl small">Cr. Total</label>
        <input type="text" id="txtcrtotal" name="txtcrtotal"
               class="inp total-inp"
               value='<s:property value="txtcrtotal"/>'
               tabindex="-1" />
    </div>

</div>
    

</div> <!-- END hidden-scrollbar receipt-header -->

<!-- hidden fields (unchanged) -->
<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<div hidden id="maindate"></div>
<input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
<input type="hidden" name="txtforsearch" id="txtforsearch" value='<s:property value="txtforsearch"/>'/>
<input type="hidden" id="txtvalidation" name="txtvalidation"  value='<s:property value="txtvalidation"/>'/>
<input type="hidden" id="taxaccount" name="taxaccount"  value='<s:property value="taxaccount"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>

</form>

<!-- windows -->
<div id="creditNoteGridWindow"><div></div><div></div></div>
<div id="accountDetailsToWindow"><div></div><div></div></div>
<div id="costTypeSearchGridWindow"><div></div><div></div></div>
<div id="costCodeSearchWindow"><div></div><div></div></div>

</div>
</body>

</html>
