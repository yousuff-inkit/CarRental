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



<style>

/* -------------- PREMIUM BLUE UI (Universal Theme) ---------------- */

/* GLOBAL FONT */
* {
	font-family: 'Poppins', sans-serif !important;
}

/* FIX: HIDE HIDDEN FIELDS SO THEY DON'T DISPLAY AS INPUTS */
input[type="hidden"] {
    display: none !important;
    height: 0 !important;
    padding: 0 !important;
    border: none !important;
    box-shadow: none !important;
}

/* WINDOW BOX / POPUP */
.jqx-window,
.jqx-window-content,
.jqx-popup,
.jqx-window-modal {
    border-radius: 18px !important;
    border: 1px solid #dce6ff !important;
    background: #ffffff !important;
    box-shadow: 0px 10px 35px rgba(93,125,255,0.20) !important;
    overflow: hidden !important;
}

/* HEADER BAR */
.jqx-window-header,
.jqx-window-caption {
    background: linear-gradient(90deg, #478dff, #67a8ff) !important;
    color: #ffffff !important;
    font-size: 1.05rem !important;
    font-weight: 600 !important;
    padding: 12px 18px !important;
    border: none !important;
}

/* CLOSE BUTTON */
.jqx-window-close-button {
    background: transparent !important;
    filter: brightness(0) invert(1) !important;
    border: none !important;
}

/* SEARCH WINDOW TOP BAR */
.search-header {
    background: linear-gradient(90deg, #478dff, #67a8ff) !important;
    padding: 14px 20px !important;
    color: white !important;
    font-size: 1.1rem !important;
    font-weight: 600 !important;
    display: flex !important;
    justify-content: space-between !important;
    border-radius: 14px 14px 0 0 !important;
}

/* POPUP BODY */
.search-body {
    padding: 18px 22px 10px !important;
    background: #fbfcff !important;
}

/* INPUT FIELDS (excluding JQX generated shadow fields) */
.jqx-input,
input[type="text"]:not(.jqx-input-content),
.jqx-widget-content input:not(.jqx-input-content) {
    height: 34px !important;
    border-radius: 10px !important;
    background: #ffffff !important;
    border: 1px solid #c4d3ff !important;
    padding: 5px 10px !important;
    font-size: 0.88rem !important;
    box-shadow: 0 2px 6px rgba(150,175,255,0.20) !important;
    transition: 0.2s ease !important;
}

/* FOCUS HIGHLIGHT */
input:focus,
.jqx-input:focus {
    border-color: #6a96ff !important;
    box-shadow: 0 0 0 2px rgba(70,120,255,0.15) !important;
    outline: none !important;
}

/* LABEL TEXT */
.jqx-window-content label {
    font-size: 0.82rem !important;
    font-weight: 600 !important;
    color: #263b75 !important;
    margin-bottom: 4px !important;
}

/* BUTTONS */
button,
input[type="button"],
.myButton {
    background: linear-gradient(90deg,#6fb1fc,#1a73e8) !important;
    height: 34px !important;
    color: white !important;
    border: none !important;
    padding: 0px 26px !important;
    border-radius: 10px !important;
    font-size: 0.9rem !important;
    font-weight: 600 !important;
    cursor: pointer !important;
    box-shadow: 0 4px 12px rgba(26,115,232,0.30) !important;
    transition: 0.2s !important;
    margin: 4px !important;
    white-space: nowrap !important;
    min-width: 120px !important;
}

/* BUTTON HOVER */
button:hover,
.myButton:hover {
    transform: translateY(-2px) scale(1.01) !important;
}

/* DATE INPUT HEIGHT FIX */
.jqx-datetimeinput,
#postingDate,
#jqxUnclearedChequeProcessingDate,
#jqxUnclearedChequeProcessFromDate,
#jqxUnclearedChequeProcessToDate {
    height: 30px !important;
    min-height: 30px !important;
    line-height: 30px !important;
    border-radius: 10px !important;
    padding: 0px 8px !important;
    box-sizing: border-box !important;
}

/* DATE ICON FIX */
.jqx-datetimeinput .jqx-input-content,
.jqx-datetimeinput .jqx-icon-calendar {
    margin-top: 2px !important;
}

/* GRID HEADER */
.jqx-grid-column-header,
.jqx-widget-header {
    background: linear-gradient(90deg,#eff4ff,#dfe9ff) !important;
    color: #2a3f85 !important;
    font-weight: 600 !important;
    border-color: #dce6ff !important;
    font-size: 0.85rem !important;
}

/* GRID CELLS */
.jqx-grid-cell {
    font-size: 0.85rem !important;
    padding: 6px !important;
    border-color: #eef3ff !important;
    color: #1f1f33 !important;
}

/* GRID HOVER */
.jqx-grid-cell-hover {
    background: rgba(70,120,255,0.08) !important;
}

/* SELECTED ROW */
.jqx-grid-cell-selected {
    background: #6e96ff !important;
    color: white !important;
}

/* PINNED COLUMN */
.jqx-grid-cell-pinned {
    background-color: #e5e5e5 !important;
}

</style>
<script type="text/javascript">
	$(document).ready(function() {
		 $("#btnUnclearedChequeSearch").hide();

	     $("#jqxUnclearedChequeProcessingDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#jqxUnclearedChequeProcessFromDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#jqxUnclearedChequeProcessToDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#postingDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy", value: null });
		 
		 var curfromdate= $('#jqxUnclearedChequeProcessFromDate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#jqxUnclearedChequeProcessFromDate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		 $('#jqxUnclearedChequeProcessFromDate').on('change', function (event) {
				var paydate = $('#jqxUnclearedChequeProcessFromDate').jqxDateTimeInput('getDate');
				var validdate=funDateInPeriod(paydate);
				 if(parseInt(validdate)==0){
					document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
					return 0;	
				 }
			 });
		 
		$('#btnsavemaster').click(function(){
			var selectedrows=$('#jqxUnclearedChequePayment').jqxGrid('getselectedrowindexes');
			if(selectedrows.length==0){
				$.messager.alert('Warning','Please select any valid documents');
				return false;
			}
			
			var paydate = $('#jqxUnclearedChequeProcessingDate').jqxDateTimeInput('getDate');
		    var validdate=funDateInPeriod(paydate);
			if(parseInt(validdate)==0){
				$.messager.alert("Warning","Transaction prior or after Account Period is not valid.","Warning");
				return 0;	
			}
	    	
			var postdate = $('#postingDate').jqxDateTimeInput('getDate');
			var postvaliddate=funDateInPeriod(postdate);
			if(parseInt(postvaliddate)==0){
				$.messager.alert("Warning","Transaction prior or after Account Period is not valid.","Warning");
				return 0;	
			}
			
			var postingdate = $('#postingDate').jqxDateTimeInput('getDate');
			var chequedate=$('#txtchqdt').val();
			if(postingdate<chequedate){
				$.messager.alert("Warning","Posting Date cannot be less than Cheque Date.","Warning");
				return 0;
			}
			

			for(var i=0;i<selectedrows.length;i++){
				var bpvno=$('#jqxUnclearedChequePayment').jqxGrid('getcellvalue', selectedrows[i], "bpvno");
				if(bpvno!=null && bpvno!="" && bpvno!="undefined" && typeof(bpvno)!="undefined" && bpvno!="0"){
					$.messager.alert('Warning','Already Posted Documents Present','warning');
					return false;
				}
			}
			$.messager.confirm('Confirm', 'Do you want to save changes?', function(r){
	    		if (r){
	    			$('#overlay,#PleaseWait').show();
	    			document.getElementById("errormsg").innerText="Processing data,Please wait";
	    			saveSimplifiedEMIV2(selectedrows);	    			
	    		}
			});
			
		 });
	});
	
	async function saveSimplifiedEMIV2(selectedrows){
		var gridlength=selectedrows.length;
		$("#jqxBankPayment").jqxGrid({ disabled: false});
		for(var i=0;i<selectedrows.length;i++){
			var rowindex1=selectedrows[i];
			var indexVal =  $('#jqxUnclearedChequePayment').jqxGrid('getcellvalue', rowindex1, "doc_no");
            var dtype =  $('#jqxUnclearedChequePayment').jqxGrid('getcellvalue', rowindex1, "dtype");
            var dealnodesc="";
            if(dtype=='UCP'){
            	toform='Bank Payment';
            	fromform='Uncleared Cheque Payment';
            	dealnodesc=$('#jqxUnclearedChequePayment').jqxGrid('getcellvalue', rowindex1, "dealno");
            }else if(dtype=='UCR'){
            	toform='Bank Receipt';
            	fromform='Uncleared Cheque Receipt';
            }
			document.getElementById("txtchqno").value= $('#jqxUnclearedChequePayment').jqxGrid('getcellvalue', rowindex1, "chqno");
 			document.getElementById("txtchqdt").value= $('#jqxUnclearedChequePayment').jqxGrid('getcelltext', rowindex1, "chqdt");
 			document.getElementById("txtchqname").value= $('#jqxUnclearedChequePayment').jqxGrid('getcellvalue', rowindex1, "chqname");
 			document.getElementById("chckpdc").value= $('#jqxUnclearedChequePayment').jqxGrid('getcellvalue', rowindex1, "pdc");
 			document.getElementById("txtfromrate").value= $('#jqxUnclearedChequePayment').jqxGrid('getcellvalue', rowindex1, "rate");
 			document.getElementById("txtgriddtype").value= $('#jqxUnclearedChequePayment').jqxGrid('getcellvalue', rowindex1, "dtype");
            document.getElementById("txtdocno").value= indexVal;
            var postingDate = document.getElementById("postingDate").value;
            var url='saveData.jsp?brhid='+$("#brchName").val()+'&docno='+indexVal+'&dtype='+dtype+'&chequeno='+$("#txtchqno").val()+'&chequedate='+$("#txtchqdt").val()+'&chequename='+$("#txtchqname").val()+'&pdc='+$("#chckpdc").val()+'&rate='+$("#txtfromrate").val()+'&griddtype='+$("#txtgriddtype").val()+'&postingdate='+postingDate+'&dealnodesc='+dealnodesc;
            const response = await fetch(url);
            const data = await response.json();
			if(data.errorstatus=="1"){
				$('#overlay,#PleaseWait').hide();
        		$.messager.alert('Warning','Not Saved','Warning');
        		return false;
			}
			else{
				$('#jqxUnclearedChequePayment').jqxGrid('setcellvalue',rowindex1,'bpvno',data.transno);
        		$('#jqxUnclearedChequePayment').jqxGrid('refresh');
			}
			if(i==(selectedrows.length-1) && data.errorstatus=="0"){
				$('#overlay,#PleaseWait').hide();
				document.getElementById("errormsg").innerText="";
				$.messager.alert('Success','Successfully Saved','message');
			}
		}
	}
	function saveSimplifiedEMI(selectedrows){
		var gridlength=selectedrows.length;
		$("#jqxBankPayment").jqxGrid({ disabled: false});
		for(var i=0;i<selectedrows.length;i++){
			var currentindex=selectedrows[i];
			(function(curr){
				
				var rowindex1=curr;
				var indexVal =  $('#jqxUnclearedChequePayment').jqxGrid('getcellvalue', rowindex1, "doc_no");
	            var dtype =  $('#jqxUnclearedChequePayment').jqxGrid('getcellvalue', rowindex1, "dtype");
	            var dealnodesc="";
	            if(dtype=='UCP'){
	            	toform='Bank Payment';
	            	fromform='Uncleared Cheque Payment';
	            	dealnodesc=$('#jqxUnclearedChequePayment').jqxGrid('getcellvalue', rowindex1, "dealno");
	            }else if(dtype=='UCR'){
	            	toform='Bank Receipt';
	            	fromform='Uncleared Cheque Receipt';
	            }
				document.getElementById("txtchqno").value= $('#jqxUnclearedChequePayment').jqxGrid('getcellvalue', rowindex1, "chqno");
	 			document.getElementById("txtchqdt").value= $('#jqxUnclearedChequePayment').jqxGrid('getcelltext', rowindex1, "chqdt");
	 			document.getElementById("txtchqname").value= $('#jqxUnclearedChequePayment').jqxGrid('getcellvalue', rowindex1, "chqname");
	 			document.getElementById("chckpdc").value= $('#jqxUnclearedChequePayment').jqxGrid('getcellvalue', rowindex1, "pdc");
	 			document.getElementById("txtfromrate").value= $('#jqxUnclearedChequePayment').jqxGrid('getcellvalue', rowindex1, "rate");
	 			document.getElementById("txtgriddtype").value= $('#jqxUnclearedChequePayment').jqxGrid('getcellvalue', rowindex1, "dtype");
	            document.getElementById("txtdocno").value= indexVal;
	            var postingDate = document.getElementById("postingDate").value;
	            $.ajax({
	                type: "POST",
	                url: "saveData.jsp",
	                async:false,
	                data: {
	                	'brhid':$("#brchName").val(),
	                	'docno':indexVal,
	                	'dtype':dtype,
	                	'chequeno':$("#txtchqno").val(),
	                	'chequedate':$("#txtchqdt").val(),
	                	'chequename':$("#txtchqname").val(),
	                	'pdc':$("#chckpdc").val(),
	                	'rate':$("#txtfromrate").val(),
	                	'griddtype':$("#txtgriddtype").val(),
	                	'postingdate':postingDate,
	                	'index':i,
	                	'gridindex':selectedrows.length,
	                	'dealnodesc':dealnodesc
	                },
	                success: function (data) {
	                	data=JSON.parse(data);
	                	if(data.errorstatus=="1"){
	                		$('#overlay,#PleaseWait').hide();
	                		$.messager.alert('Warning','Not Saved','Warning');
	                		errorstatus=1;
	                		return false;
	                	}
	                	else{
	                		$('#jqxUnclearedChequePayment').jqxGrid('setcellvalue',rowindex1,'bpvno',data.transno);
	                		$('#jqxUnclearedChequePayment').jqxGrid('refresh');
	                		gridlength--;
	                	}
	                	if(gridlength==0){
	                		$('#overlay,#PleaseWait').hide();
	                		if(data.errorstatus!="1"){
	                			$.messager.alert('Success','Successfully Saved','message');	
	                			document.getElementById("errormsg").innerText="";
	                		}
	                	}
	                },
	                error:function(data){
	                	$('#overlay,#PleaseWait').hide();
	            		$.messager.alert('Warning','Not Saved','Warning');
	                }
	            });
			})(currentindex);
		}
	}
	function funCheckPaymentRows(){
		var rows = $("#jqxBankPayment").jqxGrid('getrows');
		return rows.length;
	}
	 function funReadOnly(){
			/*$('#frmUnclearedChequeProcessing input').attr('readonly', true );
			$('#frmUnclearedChequeProcessing select').attr('disabled', true);
			$('#jqxUnclearedChequeProcessingDate').jqxDateTimeInput({disabled: true});
			$('#jqxUnclearedChequeProcessFromDate').jqxDateTimeInput({disabled: true});
			$('#jqxUnclearedChequeProcessToDate').jqxDateTimeInput({disabled: true});
			$('#postingDate').jqxDateTimeInput({disabled: true});*/
			$("#jqxUnclearedChequePayment").jqxGrid({ disabled: true});
			$("#jqxBankPayment").jqxGrid({ disabled: true});
			$("#btnUnclearedChequeSearch").show();
	 }
	 function funRemoveReadOnly(){
			$('#frmUnclearedChequeProcessing input').attr('readonly', false );
			$('#frmUnclearedChequeProcessing select').attr('disabled', false);
			$('#jqxUnclearedChequeProcessingDate').jqxDateTimeInput({disabled: false});
			$('#jqxUnclearedChequeProcessFromDate').jqxDateTimeInput({disabled: false});
			$('#jqxUnclearedChequeProcessToDate').jqxDateTimeInput({disabled: false});
			$('#postingDate').jqxDateTimeInput({disabled: false});
			$("#jqxUnclearedChequePayment").jqxGrid({ disabled: true});
			$("#jqxBankPayment").jqxGrid({ disabled: true});
			
			$('#docno').attr('readonly', true);
			$("#btnUnclearedChequeSearch").show();
			
			if ($("#mode").val() == "A") {
				
				 $('#jqxUnclearedChequeProcessingDate').val(new Date());
				 $('#jqxUnclearedChequeProcessFromDate').val(new Date());
				 var curfromdate= $('#jqxUnclearedChequeProcessFromDate').jqxDateTimeInput('getDate');
			     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
			     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
			     $('#jqxUnclearedChequeProcessFromDate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
			     $('#jqxUnclearedChequeProcessToDate').val(new Date());
			     $('#postingDate').val(null);
				 
				$("#jqxUnclearedChequePayment").jqxGrid('clear'); 
				$("#jqxUnclearedChequePayment").jqxGrid('addrow', null, {});
				$("#jqxBankPayment").jqxGrid('clear');
				$("#jqxBankPayment").jqxGrid('addrow', null, {}); 
			}
			
	 }
	 
	 function funSearchLoad(){
		/* changeContent('cpvMainSearch.jsp'); */ 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#jqxUnclearedChequeProcessFromDate').jqxDateTimeInput('focus'); 	    		
	    }
	   
	  function funNotify(){	
		  
		  /* Validation */
		    var paydate = $('#jqxUnclearedChequeProcessingDate').jqxDateTimeInput('getDate');
		    var validdate=funDateInPeriod(paydate);
			 if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
			 }
	    	
			var postdate = $('#postingDate').jqxDateTimeInput('getDate');
			var postvaliddate=funDateInPeriod(postdate);
			if(parseInt(postvaliddate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
			}
			
			var postingdate = $('#postingDate').jqxDateTimeInput('getDate');
			var chequedate=$('#txtchqdt').val();
			if(postingdate<chequedate){
				document.getElementById("errormsg").innerText="Posting Date cannot be less than Cheque Date.";
				return 0;
			}
			document.getElementById("errormsg").innerText="";
			
			
	    /* Validation Ends*/
	    		
			 /* Bank Payment Grid  Saving*/
	  		  var rows = $("#jqxBankPayment").jqxGrid('getrows');
	  		  var length=0;
			  for(var i=0 ; i < rows.length ; i++){
				    var chk=rows[i].docno;
				    if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
	  					newTextBox = $(document.createElement("input"))
	  				    .attr("type", "dil")
	  				    .attr("id", "test"+length)
	  				    .attr("name", "test"+length)
	  				    .attr("hidden", "true");
	  					length=length+1;
	  					
	  					var amount,baseamount;
	  					if(rows[i].dr==true){
							 amount=rows[i].amount1;
							 baseamount=rows[i].baseamount1;
						}
						else if(rows[i].dr==false){
							 amount=rows[i].amount1*-1;
							 baseamount=rows[i].baseamount1*-1;
						}
	  					
	  				newTextBox.val(rows[i].docno+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+rows[i].dr+"::"+amount+"::"+rows[i].description+"::"+baseamount+"::0:: "+rows[i].costtype+":: "+rows[i].costcode+":: "+rows[i].pdc+":: "+rows[i].sr_no);
	  				newTextBox.appendTo('form');
	  				}
			      }
			      $('#gridlength').val(length);
	  	 		/* Bank Payment Grid  Saving Ends*/	 	 
				 
	 		   $('#jqxUnclearedChequeProcessingDate').jqxDateTimeInput({disabled: false});
			   $('#jqxUnclearedChequeProcessFromDate').jqxDateTimeInput({disabled: false});
			   $('#jqxUnclearedChequeProcessToDate').jqxDateTimeInput({disabled: false});
			   $('#postingDate').jqxDateTimeInput({disabled: false});
	    		return 1;
		} 
	  
	  
	  function setValues(){
		  
		  document.getElementById("cmbtype").value=document.getElementById("hidcmbtype").value;
		  
		  if($('#hidjqxUnclearedChequeProcessingDate').val()){
				 $("#jqxUnclearedChequeProcessingDate").jqxDateTimeInput('val', $('#hidjqxUnclearedChequeProcessingDate').val());
			  }
		  
		  if($('#hidjqxUnclearedChequeProcessFromDate').val()){
				 $("#jqxUnclearedChequeProcessFromDate").jqxDateTimeInput('val', $('#hidjqxUnclearedChequeProcessFromDate').val());
			  }
		  
		  if($('#hidjqxUnclearedChequeProcessToDate').val()){
				 $("#jqxUnclearedChequeProcessToDate").jqxDateTimeInput('val', $('#hidjqxUnclearedChequeProcessToDate').val());
			  }
			  
		  if($('#hidpostingDate').val()){
				 $("#postingDate").jqxDateTimeInput('val', $('#hidpostingDate').val());
			  }
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
		  
		  
		  var tranno=document.getElementById("txttrno").value;
		  if(tranno>0){
			  var fromDate = document.getElementById("jqxUnclearedChequeProcessFromDate").value;
			  var toDate = document.getElementById("jqxUnclearedChequeProcessToDate").value;
			  var check =1;
			  var disable=0;
			  $("#unclearedChequeProcessingDiv").load('unclearedChequeProcessingGrid.jsp?fromDate='+fromDate+'&toDate='+toDate+'&check='+check+'&disable='+disable);
		  }
	  }
	  
	  function gridloading(){
		  var fromDate = document.getElementById("jqxUnclearedChequeProcessFromDate").value;
		  var toDate = document.getElementById("jqxUnclearedChequeProcessToDate").value;
		  var type = document.getElementById("cmbtype").value;
		  var check =1;
		  
		  $("#overlay, #PleaseWait").show();
		  
		  $("#unclearedChequeProcessingDiv").load('unclearedChequeProcessingGrid.jsp?fromDate='+fromDate+'&toDate='+toDate+'&type='+type+'&check='+check);
	  }
	  
	  function funloadgrid(){
		    var paydate = $('#jqxUnclearedChequeProcessingDate').jqxDateTimeInput('getDate');
			var validdate=funDateInPeriod(paydate);
			 if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
			 }
			
			if($('#cmbtype').val()==""){
				document.getElementById("errormsg").innerText="Type is Mandatory.";
				return 0;
			}
			
			//alert("cmbtype=="+$('#cmbtype').val()+"===");
			
			
			
			
			if(document.getElementById("postingDate").value=="" || document.getElementById("postingDate").value==null){
				   document.getElementById("errormsg").innerText="Posting Date is Mandatory.";
				   $("#jqxUnclearedChequePayment").jqxGrid({ disabled: true});
				   $("#jqxUnclearedChequePayment").jqxGrid('clear');
				   $("#jqxUnclearedChequePayment").jqxGrid('addrow', null, {});
				   $("#jqxUnclearedChequePayment").jqxGrid({ disabled: true});
				   $("#jqxUnclearedChequePayment").jqxGrid('clear');
				   $("#jqxUnclearedChequePayment").jqxGrid('addrow', null, {});
				  return 0;
			}
			
			document.getElementById("errormsg").innerText="";
			
		  $("#jqxUnclearedChequePayment").jqxGrid({ disabled: false});
		  //$("#jqxBankPayment").jqxGrid('clear');
		  //$("#jqxBankPayment").jqxGrid('addrow', null, {});
		  
		  
		  /* if($('#cmbtype').val().trim()=="UCR"){
				
				
				alert("11111");
			$('#jqxUnclearedChequePayment').jqxGrid('hidecolumn', 'dealno');
			
			}
		  alert("33333333"); */
		  gridloading();
		  }
	  
	  function headerbtndisable(){
		  $('#btnCreate,#btnPrint').attr('disabled',true);
		  $('#btnEdit').attr('disabled', true);
		  $('#btnDelete').attr('disabled', true);
		  $('#btnSearch').attr('disabled', true);
	  }
	  
	   function datechange(){
		    var date = $('#postingDate').jqxDateTimeInput('getDate');
			var validdate=funDateInPeriod(date);
			if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
			 }
			
		   $("#jqxUnclearedChequePayment").jqxGrid({ disabled: true});
		   $("#jqxUnclearedChequePayment").jqxGrid('clear');
		   $("#jqxUnclearedChequePayment").jqxGrid('addrow', null, {});
		   $("#jqxUnclearedChequePayment").jqxGrid({ disabled: true});
		   $("#jqxUnclearedChequePayment").jqxGrid('clear');
		   $("#jqxUnclearedChequePayment").jqxGrid('addrow', null, {});
	  }
function funExcelBtn(){
	 $("#unclearedChequeProcessingDiv").excelexportjs({  
       		containerid: "unclearedChequeProcessingDiv", 
       		datatype: 'json', 
       		dataset: null, 
       		gridId: "jqxUnclearedChequePayment", 
       		columns: getColumns("jqxUnclearedChequePayment") , 
       		worksheetName:"Uncleared Cheque Processing"
       		}); 

}
	  
</script>

<style>
/* ---------------------------------------------------
   GLOBAL BACKGROUND & CONTAINER
--------------------------------------------------- */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    margin: 0;
    padding: 32px 0;
}

#mainBG {
    background: #ffffff;
    border-radius: 16px;
    padding: 20px;
    max-width: 1250px;
    margin: 0 auto;
}

/* ---------------------------------------------------
   TOP FILTER CARD
--------------------------------------------------- */
.top-filter-card {
    background: #f7f9ff;
    border-radius: 12px;
    padding: 22px 28px;
    margin-bottom: 20px;
    box-shadow: 0 2px 8px rgba(44, 95, 255, 0.08);
}

.filter-grid {
    display: grid;
    grid-template-columns: 180px 180px 180px 180px auto auto;
    column-gap: 32px;
    align-items: end;
}

.filter-item {
    display: flex;
    flex-direction: column;
}

.filter-item label {
    font-size: 14px;
    font-weight: 600;
    color: #2f3b52;
    margin-bottom: 6px;
}

/* all input/select/jqx elements same size */
.filter-item select,
.filter-item input,
.filter-item div.jqx-datetimeinput,
.filter-item div {
    height: 36px !important;
    width: 100% !important;
    border-radius: 8px !important;
}

/* ---------------------------------------------------
   BUTTONS
--------------------------------------------------- */
.primary-btn {
    background: linear-gradient(45deg, #1a73e8, #4ea1ff);
    color: white;
    padding: 10px 24px;
    border-radius: 10px;
    border: none;
    cursor: pointer;
    font-size: 14.5px;
    font-weight: 600;
    min-width: 110px;
}
.primary-btn:hover {
    background: linear-gradient(45deg, #0c5fcc, #3a8ded);
}

/* ---------------------------------------------------
   TYPE DROPDOWN TEXT SIZE
--------------------------------------------------- */
#cmbtype {
    font-size: 16px !important;
    font-weight: 500;
    height: 38px !important;
    padding: 6px 10px !important;
}

#cmbtype option {
    font-size: 16px !important;
}

/* ---------------------------------------------------
   AUTOFILL FIX FOR ALL INPUTS & SELECTS
--------------------------------------------------- */
input:-webkit-autofill,
select:-webkit-autofill {
    -webkit-box-shadow: 0 0 0px 1000px white inset !important;
    box-shadow: 0 0 0px 1000px white inset !important;
    -webkit-text-fill-color: #000 !important;
    color: #000 !important;
}

/* jqx inputs autofill fix */
.jqx-input,
.jqx-input-content,
.jqx-widget-content,
.jqx-datetimeinput-input {
    background-color: #ffffff !important;
    color: #000 !important;
}

/* jqx filter row input fix */
.jqx-grid-cell input,
.jqx-grid-column-filter input {
    background-color: #ffffff !important;
}

/* ---------------------------------------------------
   TOTALS FOOTER
--------------------------------------------------- */
.totals-wrapper {
    max-width: 1200px;
    margin: 0 auto;
}

.totals-row-fixed {
    width: 100%;
    display: flex;
    justify-content: space-between;
    padding: 16px 24px;
    margin-top: 18px;
    background: #ffffff;
    border-radius: 10px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.08);
}

.total-box label {
    font-size: 15px;
    font-weight: 600;
    color: #003c8f;
}

.total-box input {
    width: 180px;
    height: 38px;
    border-radius: 8px;
    border: 1px solid #ccd4e0;
    padding: 6px 12px;
    font-size: 15px;
    text-align: right;
    background: white !important;
    box-sizing: border-box;
}
/* Remove autofill pink for SELECT */
#cmbtype:-webkit-autofill,
#cmbtype:-webkit-autofill:hover,
#cmbtype:-webkit-autofill:focus {
    -webkit-box-shadow: 0 0 0px 1000px white inset !important;
    box-shadow: 0 0 0px 1000px white inset !important;
    background-color: #ffffff !important;
    -webkit-text-fill-color: #000 !important;
}

/* Ensure dropdown is always white */
#cmbtype {
    background-color: #ffffff !important;
    color: #000 !important;
}

</style>


</head>
<body onload="setValues();headerbtndisable();">

<div id="mainBG" class="homeContent">

<form id="frmUnclearedChequeProcessing" 
      action="saveUnclearedChequeProcessing" 
      method="post" autocomplete="off">

    <!-- HEADER -->
    <jsp:include page="../../../../header.jsp"></jsp:include>
    <br/>

<div class="top-filter-card">
    <div class="filter-grid">

        <!-- Hidden original processing date -->
        <div hidden>
            <div id="jqxUnclearedChequeProcessingDate"></div>
        </div>

        <!-- PDC From -->
        <div class="filter-item">
            <label>Uncleared P.D.C From</label>
            <div id="jqxUnclearedChequeProcessFromDate"></div>
        </div>

        <!-- PDC Upto -->
        <div class="filter-item">
            <label>P.D.C Upto</label>
            <div id="jqxUnclearedChequeProcessToDate"></div>
        </div>

        <!-- Type -->
        <div class="filter-item">
            <label>Type</label>
            <select id="cmbtype" name="cmbtype">
                <option value="">--Select--</option>
                <option value="UCP">Payment</option>
                <option value="UCR">Receipt</option>
            </select>
        </div>

        <!-- Posting -->
        <div class="filter-item">
            <label>Posting</label>
            <div id="postingDate" onchange="datechange();" onblur="datechange();"></div>
        </div>

        <!-- VIEW -->
        <div class="filter-item">
            <label>&nbsp;</label>
            <button type="button" id="btnUnclearedChequeSearch" class="primary-btn">View</button>
        </div>

        <!-- SAVE CHANGES -->
        <div class="filter-item">
            <label>&nbsp;</label>
            <button type="button" id="btnsavemaster" class="primary-btn">Save Changes</button>
        </div>

    </div>
</div>

    <div class="cr-table" id="unclearedChequeProcessingDiv">
    <center><jsp:include page="unclearedChequeProcessingGrid.jsp"></jsp:include></center>
</div>
<br/>

<!-- FIXED TOTALS SECTION (Aligned with page container) -->
<div class="totals-wrapper">
    <div class="totals-row-fixed">
        
        <div class="total-box">
            <label>Dr. Total</label><br>
            <input type="text" id="txtdrtotal" name="txtdrtotal"
                   value='<s:property value="txtdrtotal"/>' />
        </div>

        <div class="total-box">
            <label>Cr. Total</label><br>
            <input type="text" id="txtcrtotal" name="txtcrtotal"
                   value='<s:property value="txtcrtotal"/>' readonly />
        </div>

    </div>
</div>

    <!-- BANK PAYMENT GRID (hidden until needed) -->
    <div id="bankPaymentDiv" style="visibility:hidden;">
        <center>
            <jsp:include page="bankPaymentGrid.jsp"></jsp:include>
        </center>
    </div>

    <br/>


    <!-- ================= HIDDEN FIELDS (DO NOT TOUCH) ================= -->
    <input type="hidden" id="mode" name="mode"/>
    <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
    <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
    <input type="hidden" id="txtchqno" name="txtchqno" value='<s:property value="txtchqno"/>'/>
    <input type="hidden" id="txtchqdt" name="txtchqdt" value='<s:property value="txtchqdt"/>'/>
    <input type="hidden" id="txtchqname" name="txtchqname" value='<s:property value="txtchqname"/>'/>
    <input type="hidden" id="chckpdc" name="chckpdc" value='<s:property value="chckpdc"/>'/>
    <input type="hidden" id="txtfromrate" name="txtfromrate" value='<s:property value="txtfromrate"/>'/>
    <input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
    <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
    <input type="hidden" id="txtgriddtype" name="txtgriddtype" value='<s:property value="txtgriddtype"/>'/>
    <input type="hidden" id="gridlength" name="gridlength"/>

</form>
</div>

</body>

</html>
