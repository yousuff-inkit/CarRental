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
    /* ------------------------------
       GLOBAL STYLES & LAYOUT
    ------------------------------ */
    body {
        background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
        color: #222;
        margin: 0;
        padding: 32px 0;
        min-height: 100vh;
        box-sizing: border-box;
    }

    #mainBG {
        background: #fff;
        border-radius: 16px;
        padding: 20px;
        max-width: 100%;
        margin: auto;
        box-shadow: 0 4px 24px rgba(0,0,0,0.06);
        /* FORCE HEADER LEFT ALIGNMENT */
        text-align: left !important; 
    }

    /* ------------------------------
       HEADER FIXES (Title & Buttons)
    ------------------------------ */
    
    /* This overrides any <center> tags coming from header.jsp */
    center {
        text-align: left !important;
        display: block;
        width: 100%;
        margin-left: 0;
    }
    
    /* Force the Title (#formdet) to be Left Aligned and Big */
    #formdet {
        font-size: 24px !important;
        font-weight: 700 !important;
        color: #2c3e50;
        margin-bottom: 15px;
        display: block;
        text-align: left !important;
        font-family: 'Segoe UI', sans-serif;
    }

    /* ------------------------------
       GRID SYSTEM (FORM LAYOUT)
    ------------------------------ */
    .receipt-header {
        display: grid;
        grid-template-columns: auto 1fr auto 1fr auto 1fr;
        gap: 15px;
        align-items: center;
        margin-bottom: 20px;
        padding: 0 0 0 5px; 
    }

    .form-group {
        display: grid;
        grid-template-columns: 120px 1fr;
        align-items: center;
        gap: 12px;
        margin-bottom: 12px;
    }

    .form-group.dual-input {
        grid-template-columns: 120px 1fr 120px 1fr;
    }

    .form-group.single-label-dual-input {
        grid-template-columns: 120px 1fr 1fr;
    }

    .section-row {
        display: flex;
        gap: 26px;
        margin-bottom: 30px;
    }

    .section-block {
        flex: 1;
        background: #f6f8fa;
        border-radius: 12px;
        padding: 20px;
        box-shadow: 0 1px 8px rgba(160,177,217,0.1);
    }

    .section-block h2 {
        font-size: 1.1rem;
        font-weight: 600;
        margin: 0 0 20px;
        padding-left: 10px;
        border-left: 4px solid #007bff;
        color: #333;
    }

    /* ------------------------------
       INPUTS & CONTROLS
    ------------------------------ */
    input[type="text"], select {
        height: 32px !important;
        border: 1px solid #d1d5db;
        border-radius: 6px;
        padding: 6px 10px;
        background: #fff;
        transition: border-color 0.2s;
        font-size: 14px;
        box-sizing: border-box;
        width: 100%;
    }

    input[type="text"]:focus, select:focus {
        border-color: #007bff;
        outline: none;
    }
    
    input[readonly] {
        background-color: #f3f4f6;
        color: #6b7280;
    }

    label {
        font-weight: 600;
        color: #253858;
        white-space: nowrap;
        text-align: right;
        padding-right: 10px;
        font-size: 14px;
    }

    /* ------------------------------
       TABLES & UTILS
    ------------------------------ */
    .table-section { margin: 20px 0; }
    .table-section h3 {
        color: #253858; font-size: 1.05rem; font-weight: 600; margin-bottom: 12px;
    }
    
    .myButton {
        background: #007bff; border: none; padding: 6px 16px; color: #fff;
        border-radius: 6px; cursor: pointer; font-weight: 600;
    }
    .myButton:hover { background: #0056b3; }

    .doc-group { display: flex; gap: 5px; }
    
    /* SCROLLBAR FIX */
    .hidden-scrollbar { overflow: auto; height: 100vh; }
    .hidden-scrollbar::-webkit-scrollbar { width: 0px; } /* Set to 8px if you want to see the bar */
    
    #validrate { color: red; font-size: 12px; }
    
    #txtStatus {
        font-size: 14px;
        font-weight: 600;
        color: #e67e22;
        margin-left: 12px;
    }
</style>

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

</head>
<body onload="setValues();">
<div id="mainBG" class="hidden-scrollbar homeContent" data-type="background" >
<form id="frmPettyCash" action="savePettyCash" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

    <div class='receipt-header'>
        <label>Date</label>
        <div>
            <div id="jqxPettyCashDate" name="jqxPettyCashDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxPettyCashDate"/>'></div>
            <input type="hidden" id="hidjqxPettyCashDate" name="hidjqxPettyCashDate" value='<s:property value="hidjqxPettyCashDate"/>'/>
        </div>

        <label>Ref. No.</label>
        <input type="text" id="txtrefno" name="txtrefno" value='<s:property value="txtrefno"/>'/>

        <label>Doc No.</label>
        <div class="doc-group">
            <input type="text" id="docno" name="txtpettycashdocno" value='<s:property value="txtpettycashdocno"/>' tabindex="-1"/>
            <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button>
        </div>
        
        <span id="txtStatus"></span>
    </div>

    <div class="section-row">
        <div class="section-block">
            <h2>Transaction Details</h2>
            
            <div class="form-group single-label-dual-input">
                <label>Cash</label>
                <input type="text" id="txtaccid" name="txtaccid" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>'  onkeydown="getAcc(event);"/>
                <input type="text" id="txtaccname" name="txtaccname" value='<s:property value="txtaccname"/>' tabindex="-1"/>
                <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
            </div>
            
            <div class="form-group dual-input">
                <label>Currency</label>
                <select id="cmbcurrency" name="cmbcurrency" value='<s:property value="cmbcurrency"/>' onload="getRatevalue(this.value,$('#jqxPettyCashDate').val());" onchange="getRatevalue(this.value,$('#jqxPettyCashDate').val());">
                  <option></option>
                </select>
                <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency" value='<s:property value="hidcmbcurrency"/>'/>
                <input type="hidden" id="hidcurrencytype" name="hidcurrencytype" value='<s:property value="hidcurrencytype"/>'/>

                <label>Rate</label>
                <input type="text" id="txtrate" name="txtrate" onchange="funvalid()" value='<s:property value="txtrate"/>' onblur="funRoundRate(this.value,this.id);" tabindex="-1"/>
                <span id="validrate"></span>
            </div>

            <div class="form-group dual-input">
                <label>Amount</label>
                <input type="text" id="txtamount" name="txtamount" value='<s:property value="txtamount"/>' readonly onblur="funRoundAmt(this.value,this.id);" tabindex="-1"/>
                
                <label>Base Amount</label>
                <input type="text" id="txtbaseamount" name="txtbaseamount" readonly value='<s:property value="txtbaseamount"/>' tabindex="-1" tabindex="-1"/>
            </div>

            <div class="form-group">
                <label>Description</label>
                <input type="text" id="txtdescription" name="txtdescription" value='<s:property value="txtdescription"/>'/>
            </div>
        </div>
    </div>


    <div class="table-section">
        <div id="jqxPettyCashGrid"><jsp:include page="pettyCashGrid.jsp"></jsp:include></div><br/>
    </div>

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