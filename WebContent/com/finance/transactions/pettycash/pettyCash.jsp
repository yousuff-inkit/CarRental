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
		 $("#btnvaluechange").hide();
		
		 $("#jqxPettyCashDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
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
			  accountSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
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
			  accountSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
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

/* var win= window.open(reurl[0]+"PettyCashPrint?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					     win.focus(); */
					 }
					else{
						var win= window.open(reurl[0]+"printPettyCashPayment?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					    win.focus();

/* var win= window.open(reurl[0]+"PettyCashPrint?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					     win.focus(); */
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

<style>
.form-group {
    display: flex;
    align-items: center;
    gap: 20px;
    margin-bottom: 20px;
    width: 100%;
}

.form-group label {
    max-width: 120px;
    font-size: 15px;
    font-weight: 700;
    text-align: right;
    color: #1d2a4d;
}

/* INPUT / SELECT / TEXTBOX */
.form-group input[type="text"],
.form-group select {
    flex: 1;
    font-size: 18px;
    padding: 14px 20px;
   
    border-radius: 14px;
    border: 2px solid #b9c9e8;
    background: #ffffff;
    height: 40px;
    transition: 0.2s ease;
}

/* FOCUS + HOVER */
.form-group input[type="text"]:focus,
.form-group select:focus {
    border-color: #2f6dde !important;
    box-shadow: 0 0 10px rgba(47,109,222,0.4);
    outline: none;
}

fieldset {
    border-radius: 14px;
    border: 1px solid #c8d6ff;
    padding: 15px 18px;
    background: #ffffff;
    box-shadow: 0 6px 20px rgba(100,130,255,0.15);
    margin-bottom: 20px;
}
.payment-one-row {
    display: grid;
    grid-template-columns: 120px 150px 140px 1fr 1fr;
    gap: 20px;
    align-items: center;
    width: 100%;
}
/* =======================
   COMPACT FORM REFINEMENT
   ======================= */

/* Reduce overall height of form fields */
.section-block .form-group input[type="text"],
.section-block .form-group select,
.section-block .form-group textarea {
    font-size: 15px !important;
    padding: 8px 12px !important;
    height: 32px !important;
    border-radius: 10px !important;
}

/* Labels smaller & closer */
.section-block .form-group label {
    min-width: 100px !important;
    font-size: 15px !important;
    font-weight: 600 !important;
}

/* Dropdown text visible */
.section-block select {
    font-size: 35px ;
    height: 42px;
    width:100%;
    line-height: 20px ;
}

/* Account ID and Cash row aligned */
.payment-one-row {
    display: grid;
    grid-template-columns: 100px 150px 120px 1fr 1fr;
    gap: 15px;
    align-items: center;
}

/* General layout narrower */
.section-block {
    padding: 8px !important;
}
/* Currency dropdown same size as in Cash section */
.compact-currency {
    width: 82% !important;
}
.compact-currency-payment{
width:83%;
}

.currency-row {
    display: grid;
    grid-template-columns: 140px 1fr 140px 1fr;
    gap: 25px;
    width: 100%;
    align-items: center;
}


/* Amount box */
.compact-amount {
 width: 85% !important;}
</style>

<body onload="setValues();">

<div id="mainBG" class="hidden-scrollbar homeContent" data-type="background">

<form id="frmPettyCash" action="savePettyCash" method="post" autocomplete="off">

<jsp:include page="../../../../header.jsp"></jsp:include>

<!-- ==========================================================
     HEADER BLOCK
========================================================== -->
<div class="section-block" style="padding:20px;">
    <table width="100%">
        <tr class="form-group">

            <!-- DATE -->
            <td align="right"><label>Date</label></td>
            <td width="120px">
                <div id="jqxPettyCashDate"
                     name="jqxPettyCashDate"
                     onchange="datechange();" onblur="datechange();"
                     value='<s:property value="jqxPettyCashDate"/>'>
                </div>

                <input type="hidden" id="hidjqxPettyCashDate"
                       name="hidjqxPettyCashDate"
                       value='<s:property value="hidjqxPettyCashDate"/>' />
            </td>

            <td></td>

            <!-- REF NO -->
            <td align="right"><label>Ref. No.</label></td>
            <td>
                <input type="text" id="txtrefno" name="txtrefno"
                       class="search-input"
                       value='<s:property value="txtrefno"/>' style="width:60%;">
            </td>

            <!-- DOC NO -->
            <td align="right"><label>Doc No.</label></td>
            <td>
                <input type="text" id="docno" name="txtpettycashdocno"
                       class="search-input" tabindex="-1"
                       value='<s:property value="txtpettycashdocno"/>' style="width:60%;">
            </td>
            <td> <button class="myButton" type="button"
                        onclick="funwarningopen();">Value Change</button></td>

        </tr>

        <tr>
            <td colspan="7">
                <span id="txtStatus"></span>
            </td>
        </tr>

    </table>
</div>


<!-- ==========================================================
     CASH SECTION
========================================================== -->
<div class="section-block">
<h2>Cash</h2>

<div class="form-group">
    <label>Cash</label>
    <input type="text" id="txtaccid" name="txtaccid"
           placeholder="Press F3 to Search"
           value='<s:property value="txtaccid"/>' onkeydown="getAcc(event);">

    <input type="text" id="txtaccname" name="txtaccname"
           value='<s:property value="txtaccname"/>' tabindex="-1">

    <input type="hidden" id="txtdocno" name="txtdocno"
           value='<s:property value="txtdocno"/>' />
</div>

 <div class="form-group currency-row">
        <label>Currency</label>
        <select id="cmbcurrency" name="cmbcurrency"
                onchange="getRatevalue(this.value,$('#jqxPettyCashDate').val());">
            <option></option>
        </select>

        <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency"
               value='<s:property value="hidcmbcurrency"/>'>

        <input type="hidden" id="hidcurrencytype" name="hidcurrencytype"
               value='<s:property value="hidcurrencytype"/>'>

        <label>Rate</label>
        <input type="text" id="txtrate" name="txtrate"
               value='<s:property value="txtrate"/>'
               onchange="funvalid()"
               onblur="funRoundRate(this.value,this.id);" tabindex="-1">
    </div>


    <!-- ============================
         AMOUNT ROW
    ============================ -->
    <div class="form-group currency-row">
        <label>Amount</label>
        <input type="text" id="txtamount" name="txtamount"
               value='<s:property value="txtamount"/>'
               onblur="funRoundAmt(this.value,this.id);" tabindex="-1"
               style="text-align:right;" readonly>

        <label>Base Amount</label>
        <input type="text" id="txtbaseamount" name="txtbaseamount"
               value='<s:property value="txtbaseamount"/>' tabindex="-1"
               style="text-align:right;" readonly>
    </div>


    <!-- ============================
         DESCRIPTION ROW (FULL WIDTH)
    ============================ -->
    <div class="form-group">
        <label>Description</label>
        <input type="text" id="txtdescription" name="txtdescription"
               style="flex:2;"
               value='<s:property value="txtdescription"/>'>
    </div>

</div> <!-- /Cash section -->


<!-- ==========================================================
     GRID SECTION
========================================================== -->
<div id="jqxPettyCashGrid">
    <jsp:include page="pettyCashGrid.jsp"></jsp:include>
</div>

<br>


<!-- ==========================================================
     HIDDEN FIELDS (UNCHANGED)
========================================================== -->
<input type="hidden" id="mode" name="mode" />
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>' />
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>' />
<input type="hidden" id="gridlength" name="gridlength" />
<input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>' />
<div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
<input type="hidden" id="txtforsearch" name="txtforsearch" value='<s:property value="txtforsearch"/>' />
<input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>' />
<input type="hidden" id="txttranid" name="txttranid" value='<s:property value="txttranid"/>' />
<input type="hidden" id="hidstatus" name="hidstatus" value='<s:property value="status"/>' />

</form>


<!-- ==========================================================
     POPUP WINDOWS
========================================================== -->
<div id="pettyCashGridWindow"><div></div><div></div></div>
<div id="accountDetailsFromWindow"><div></div><div></div></div>
<div id="costTypeSearchGridWindow"><div></div><div></div></div>
<div id="costCodeSearchWindow"><div></div><div></div></div>

</div>

</body>

</html>
