<%@ taglib prefix="s" uri="/struts-tags"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>
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
   DEBIT NOTE - SEGOE UI / CLEAN WHITE STYLING
========================================================= */
body, .homeContent {
    background-color: #fff !important; /* No Blue Background */
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
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
    font-size: 11px;
}

#validrate {
    color:red;
    font-size: 11px;
    font-weight: bold;
}

/* EXACT Input Styles from Client Master */
input[type="text"], input[type="email"], select {
    height: 24px !important; 
    border: 1px solid #ccc !important;
    border-radius: 3px !important;
    padding: 2px 6px !important;
    font-size: 12px !important; /* Updated for Segoe UI */
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    box-sizing: border-box;
    background-color: #fff !important;
    color: #333 !important;
    width: 100%;
}

input[type="text"]:focus, input[type="email"]:focus, select:focus {
    border-color: #007bff !important;
    background-color: #FFD6FF !important; /* Client Master Focus Color */
    outline: none !important;
}

input[readonly], input:disabled, select:disabled {
    background-color: #f4f5f7 !important;
    color: #5e6c84 !important;
    border-color: #e1e4e8 !important;
}

/* Fieldset and Legend styling */
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
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    color: #222 !important;
    font-weight: 600 !important; /* Slightly bolder for Segoe UI */
    vertical-align: middle;
}

.lbl-right { 
    text-align: right; 
    color: #222 !important;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Modern Buttons matched to Client Master */
.myButton {
    background-color: #0056b3 !important;
    color: #ffffff !important;
    border: none !important;
    border-radius: 3px !important;
    padding: 0 15px !important;
    font-weight: bold !important;
    font-size: 12px !important;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    cursor: pointer !important;
    height: 24px !important;
}

.myButton:hover {
    background-color: #004494 !important;
}

/* Magnifier Icon Styling */
.input-search-container {
    position: relative;
    display: inline-block;
    width: 65%; /* Replaces the inline style on txtaccid */
}
.input-search-container input {
    padding-right: 25px !important;
}
.magnifier-icon {
    position: absolute;
    right: 4px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
.magnifier-icon:hover { color: #2563eb; }

</style>

<script type="text/javascript">
	$(document).ready(function() {
         /* MODIFIED: Heights set to 24px to match text boxes */
		 $("#jqxDebitNoteDate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
		 $('#txtforsearch').val(2);
		
		 $('#accountDetailsToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsToWindow').jqxWindow('close');  
		 
		 $('#debitNoteGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#debitNoteGridWindow').jqxWindow('close'); 
		 
		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#costTypeSearchGridWindow').jqxWindow('close');
 		 
 		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
		 
		 $('#jqxDebitNoteDate').on('change', function (event) {
				 var debitdate = $('#jqxDebitNoteDate').jqxDateTimeInput('getDate');
				 var validdate=funDateInPeriod(debitdate);
				 if(parseInt(validdate)==0){
					document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
					return 0;	
				 }
		});
			 
		$('#txtaccid').dblclick(function(){ openToAcc(); }); 	 
	});

    /* ADDED CLICK HANDLER FOR MAGNIFIER ICON */
    function openToAcc() {
        var date = $('#jqxDebitNoteDate').jqxDateTimeInput('getDate');
        $("#maindate").jqxDateTimeInput('val', date);
        accountSearchContent("<%=contextPath%>/com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbtype').val()+"&date="+date);
        $('#txtforsearch').val(2);
    }
	
	function DebitSearchContent(url) {
		$('#debitNoteGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#debitNoteGridWindow').jqxWindow('setContent', data);
		$('#debitNoteGridWindow').jqxWindow('bringToFront');
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
				 $('#frmDebitNote select').attr('disabled', false);$("#jqxDebitNote").jqxGrid({ disabled: false});  
				 $('#cmbcurrency').attr('disabled',true);
				   }
		   });
	  }
	  
	 function funReadOnly(){
			$('#frmDebitNote input').attr('readonly', true );
			$('#frmDebitNote select').attr('disabled', true);
			$('#jqxDebitNoteDate').jqxDateTimeInput({disabled: true});
			$("#jqxDebitNote").jqxGrid({ disabled: true});
			$("#btnvaluechange").hide();
	 }
	 function funRemoveReadOnly(){
		    $('#txtforsearch').val(2);
			$('#frmDebitNote input').attr('readonly', false );
			$('#frmDebitNote select').attr('disabled', false);
			$('#cmbcurrency').attr('disabled', true);
			$('#txtaccid').attr('readonly', true );
			$('#txtaccname').attr('readonly', true );
			$('#txtnettotal').attr('readonly', true );
			$('#jqxDebitNoteDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$("#jqxDebitNote").jqxGrid({ disabled: false}); 
			
			var date = $('#jqxDebitNoteDate').val();
		    getCurrencyId(date);
		    
		   if ($("#mode").val() == "E") {
                $("#btnvaluechange").show();
                $('#frmDebitNote input').attr('readonly', true );
			    $('#frmDebitNote select').attr('disabled', true);
			    $("#jqxDebitNote").jqxGrid({ disabled: true});
			    $('#txtrefno').attr('readonly', false );
			    $('#txtdescription').attr('readonly', false );
			    $("#jqxDebitNote").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","dr": true,"amount1": "","description": ""});
			  }
			 else{
				$("#btnvaluechange").hide();
			} 
			
			if ($("#mode").val() == "A") {
				$('#jqxDebitNote').val(new Date());
				$("#jqxDebitNote").jqxGrid('clear'); 
				$("#jqxDebitNote").jqxGrid('addrow', null, {"type": "","accounts": "","accountname1": "","currency": "","rate": "","dr": true,"amount1": "","description": ""});
			} 
	       }
	
			function funSearchLoad(){
				changeContent('dnoMainSearch.jsp'); 
			 }
				
			 function funChkButton() {
					/* funReset(); */
				}
			 
			 function funFocus(){
			    	$('#jqxDebitNoteDate').jqxDateTimeInput('focus'); 	    		
			    }
			 
			   $(function(){
			        $('#frmDebitNote').validate({
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
				  /* Validation */
				    var debitdate = $('#jqxDebitNoteDate').jqxDateTimeInput('getDate');
					var validdate=funDateInPeriod(debitdate);
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
			    		
			    /* Validation Ends*/
			    		
			     /* Debit-Note Grid  Saving*/
				  var rows = $("#jqxDebitNote").jqxGrid('getrows');
				  var length=0,val=0;
					 for(var i=0 ; i < rows.length ; i++){
						var chk=rows[i].docno;
						var chk=rows[i].rate;
						
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
				    
							var amount,baseamount;
							if(rows[i].dr==true){
								 amount=rows[i].amount1*-1;
								 baseamount=rows[i].baseamount1*-1;
							}
							else if(rows[i].dr==false){
								 amount=rows[i].amount1;
								 baseamount=rows[i].baseamount1;
							}
							
						newTextBox.val(rows[i].docno+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+rows[i].dr+"::"+amount+"::"+rows[i].description+"::"+baseamount+":: "+rows[i].costtype+":: "+rows[i].costcode);
						newTextBox.appendTo('form');
						}
						}
					 if(val==1){
						 document.getElementById("errormsg").innerText= "Rate is Mandatory.";
						 return 0;
					 } 
					    $('#gridlength').val(length);
			 		   /* Debit-Note Grid  Saving Ends*/	
			 		   
			 		   if ($("#mode").val() == "E") {
			             $('#frmDebitNote select').attr('disabled', false); 
			           }
			 		  $('#cmbcurrency').attr('disabled', false);
					
				  return 1;
			  }
			  
			  function setValues(){
				  $('#jqxDebitNoteDate').jqxDateTimeInput({disabled: false});
				  var date = $('#jqxDebitNoteDate').val();
				  getCurrencyId(date);
				  $('#jqxDebitNoteDate').jqxDateTimeInput({disabled: true});
				  
				  document.getElementById("cmbtype").value=document.getElementById("hidcmbtype").value;
				  document.getElementById("cmbcurrency").value=document.getElementById("hidcmbcurrency").value;
				  
				  if($('#hidjqxDebitNoteDate').val()){
						 $("#jqxDebitNoteDate").jqxDateTimeInput('val', $('#hidjqxDebitNoteDate').val());
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
						 var check = 1 ;
			             $("#jqxDebitNoteGrid").load("debitNoteGrid.jsp?txtdebitnotedocno2="+indexVal+"&check="+check);
					 }
					 getBankReconciled($("#docno").val(), "DNO");
					 
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
			
			       
			       function getDrTotal(){
			 		  var fromamount = $('#txtbaseamount').val();
			 		  
			 		  if(!isNaN(fromamount)){
			 			  
			 		  var dr=0.0,cr=0.0,dr1=0.0;
			   	      var rows = $('#jqxDebitNote').jqxGrid('getrows');
			 	      var rowlength= rows.length;
			 	 		for(var i=0;i<=rowlength-1;i++) {
			 	 		
			 	 		  var value = rows[i].dr;
			 	          var baseamount = rows[i].baseamount1;
			 	          
			 	          if(typeof(baseamount) != "undefined" && typeof(baseamount) != "NaN" && baseamount != ""){
			 	        	  if(value==true){
			                	   if(!isNaN(baseamount)){
			                	      cr=cr+baseamount;
			                	   }else if(isNaN(baseamount)){
			                  		 baseamount=0.00;
			                  		 cr=cr+baseamount;
			                  	   }
			                   }
			                   else{
			                	   if(!isNaN(baseamount)){
			                    	 	dr=dr+baseamount;
			                   	   }else if(isNaN(baseamount)){
			                   		    baseamount=0.00;
			                   		 	dr=dr+baseamount;
			                   	   }
			                   }
			 	 	       }
			 	 		}
			 	 		
			 	 		if(!isNaN(fromamount)){
			                	dr1=parseFloat(dr) + parseFloat(fromamount);
			                   funRoundAmt(dr1,"txtdrtotal");
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
			         	   openToAcc();
			           }
			           else{}
			       }
			       
			       function funPrintBtn() {
			    	    if (($("#mode").val() == "view") && $("#docno").val() != "") {
			    	        var url = document.URL;
			    	        var reurl = url.split("saveDebitNote");
			    	        $("#docno").prop("disabled", false);

			    	        // Helper function to handle the new window and auto-trigger print
			    	        var openAndAutoPrint = function(printUrl) {
			    	            var win = window.open(printUrl, "_blank", "top=150,left=250,Width=1020,Height=800,location=no,scrollbars=yes,toolbar=yes");
			    	            if (win) {
			    	                var checkReady = setInterval(function() {
			    	                    if (win.document.readyState === 'complete') {
			    	                        clearInterval(checkReady);
			    	                        // Delay to ensure server-side Jasper/Crystal reports render components
			    	                        setTimeout(function() {
			    	                            win.focus();
			    	                            win.print();
			    	                        }, 1000);
			    	                    }
			    	                }, 500);
			    	            }
			    	        };

			    	        $.messager.confirm('Confirm', 'Do you want to have header?', function(r) {
			    	            var baseUrl = reurl[0] + "printDebitNote?docno=" + document.getElementById("docno").value + 
			    	                          "&branch=" + document.getElementById("brchName").value;
			    	            
			    	            if (r) {
			    	                // With Header
			    	                openAndAutoPrint(baseUrl + "&header=1");
			    	            } else {
			    	                // Without Header
			    	                openAndAutoPrint(baseUrl + "&header=0");
			    	            }
			    	        });
			    	    } else {
			    	        $.messager.alert('Message', 'Select a Document....!', 'warning');
			    	        return;
			    	    }
			    	}
	
			       function clearClientInfo(){
				 		  $("#txtdocno").val('');$("#txtaccid").val('');$("#txtaccname").val('');
				 	  }
			       
			       function datechange(){
				 		  var date = $('#jqxDebitNoteDate').jqxDateTimeInput('getDate');
						  var validdate=funDateInPeriod(date);
						  if(parseInt(validdate)==0){
							document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
							return 0;	
						  }
				 		  $("#maindate").jqxDateTimeInput('val', date);
				 	  }

</script>
</head>

<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmDebitNote" action="saveDebitNote" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class='hidden-scrollbar'>
<span id="errormsg" style="color:red; font-weight:bold;"></span>
<fieldset style="border:none !important; padding: 0 !important; background: transparent !important; margin-bottom: 5px !important;">

<table width="100%" cellpadding="3" cellspacing="0">
  <tr>
    <td width="10%" class="lbl-right">Date</td>
    <td width="23%">
        <div id="jqxDebitNoteDate" name="jqxDebitNoteDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxDebitNoteDate"/>'></div>
        <input type="hidden" id="hidjqxDebitNoteDate" name="hidjqxDebitNoteDate" value='<s:property value="hidjqxDebitNoteDate"/>'/>
    </td>
    <td width="10%" class="lbl-right">Ref. No.</td>
    <td width="23%" style="display: flex; gap: 5px;">
        <input type="text" id="txtrefno" name="txtrefno" value='<s:property value="txtrefno"/>' style="flex:1;"/>
        <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();" style="padding: 2px 8px !important; background-color: #f39c12 !important;">Value Change</button>
    </td>
    <td width="10%" class="lbl-right">Doc No.</td>
    <td width="24%">
        <input type="text" id="docno" name="txtdebitnotedocno" value='<s:property value="txtdebitnotedocno"/>' tabindex="-1" readonly style="background-color: #f4f5f7;"/>
    </td>
  </tr>
  
  <tr>
    <td class="lbl-right">Type</td>
    <td>
        <select id="cmbtype" name="cmbtype" onchange="clearClientInfo();" value='<s:property value="cmbtype"/>' style="width: 30%; display: inline-block;">
            <option value="AP">AP</option>
            <option value="AR">AR</option>
            <option value="HR">HR</option>
        </select>
        <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/>
        
        <div class="input-search-container">
            <input type="text" id="txtaccid" name="txtaccid" placeholder="Press F3" value='<s:property value="txtaccid"/>' onkeydown="getAccType(event);" readonly/>
            <svg class="magnifier-icon" onclick="openToAcc();" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
        </div>
    </td>
    <td colspan="4" style="padding-left: 10px;">
        <input type="text" id="txtaccname" name="txtaccname" value='<s:property value="txtaccname"/>' tabindex="-1" readonly/>
        <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
        <input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
    </td>
  </tr>
  
  <tr>
    <td class="lbl-right">Currency</td>
    <td>
        <select id="cmbcurrency" name="cmbcurrency" value='<s:property value="cmbcurrency"/>' onload="getRatevalue(this.value,$('#jqxDebitNoteDate').val());" onchange="getRatevalue(this.value,$('#jqxDebitNoteDate').val());">
            <option></option>
        </select>
        <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency" value='<s:property value="hidcmbcurrency"/>'/>
        <input type="hidden" id="hidcurrencytype" name="hidcurrencytype" value='<s:property value="hidcurrencytype"/>'/>
    </td>
    <td class="lbl-right">Rate</td>
    <td>
        <input type="text" id="txtrate" name="txtrate" onchange="funvalid()" value='<s:property value="txtrate"/>' onblur="funRoundRate(this.value,this.id);getBaseAmountFrom();getDrTotal();" tabindex="-1" style="text-align: right;"/>
        <span id="validrate"></span>
    </td>
    <td colspan="2"></td>
  </tr>
  
  <tr>
    <td class="lbl-right">Amount</td>
    <td>
        <input type="text" id="txtamount" name="txtamount" value='<s:property value="txtamount"/>' onblur="funRoundAmt(this.value,this.id);getBaseAmountFrom();getDrTotal();" style="text-align: right;"/>
    </td>
    <td class="lbl-right">Base Amount</td>
    <td>
        <input type="text" id="txtbaseamount" name="txtbaseamount" value='<s:property value="txtbaseamount"/>' tabindex="-1" readonly style="text-align: right; background-color: #f4f5f7;"/>
    </td>
    <td colspan="2"></td>
  </tr>
  
  <tr>
    <td class="lbl-right">Description</td>
    <td colspan="5">
        <input type="text" id="txtdescription" name="txtdescription" value='<s:property value="txtdescription"/>'/>
    </td>
  </tr>
</table>
</fieldset><br/>

<div id="jqxDebitNoteGrid"><jsp:include page="debitNoteGrid.jsp"></jsp:include></div><br/>

<table width="100%" cellpadding="3" cellspacing="0">
  <tr>
    <td width="10%" class="lbl-right">Dr. Total</td>
    <td width="20%">
        <input type="text" id="txtdrtotal" name="txtdrtotal" value='<s:property value="txtdrtotal"/>' tabindex="-1" readonly style="text-align: right; background-color: #f4f5f7;"/>
    </td>
    <td width="50%"></td>
    <td width="10%" class="lbl-right">Cr. Total</td>
    <td width="20%">
        <input type="text" id="txtcrtotal" name="txtcrtotal" value='<s:property value="txtcrtotal"/>' tabindex="-1" readonly style="text-align: right; background-color: #f4f5f7;"/>
    </td>
  </tr>
</table>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
<input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
<input type="hidden" name="txtforsearch" id="txtforsearch" value='<s:property value="txtforsearch"/>'/>
<input type="hidden" id="txtvalidation" name="txtvalidation"  value='<s:property value="txtvalidation"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
</div>
</form>
<div id="debitNoteGridWindow">
	<div></div><div></div>
</div>  
				
<div id="accountDetailsToWindow">
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