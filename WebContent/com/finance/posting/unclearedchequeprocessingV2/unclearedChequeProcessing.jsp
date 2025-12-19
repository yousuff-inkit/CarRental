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
/* ------------------------------
   GLOBAL STYLES
------------------------------ */

body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 32px 0;
    min-height: 130vh;
    box-sizing: border-box;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 20px;
    max-width: 1450px;
    margin: auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

/* ------------------------------
   COMMON UI ELEMENTS
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
}

input[type="text"]:focus,
select:focus {
    border-color: #007bff;
    outline: none;
}

label {
    font-weight: 600;
    color: #253858;
    white-space: nowrap;
    font-size: 15px;
}

/* ------------------------------
   HEADER SECTION
------------------------------ */

.receipt-header {
    background: #f6f8fa;
    border-radius: 12px;
    padding: 24px;
    margin-bottom: 20px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.1);
}

/* ------------------------------
   UNCLEARED CHEQUE FORM ROWS
------------------------------ */

/* Date Range + Action Buttons Row - First Line */
.form-group.date-actions-row {
    display: flex;
    align-items: center;
    gap: 15px;
    padding: 10px 0;
    margin-bottom: 12px;
}

.form-group.date-actions-row label {
    font-weight: 600;
    color: #253858;
    white-space: nowrap;
    min-width: 140px;
    text-align: right;
}

.form-group.date-actions-row .date-wrapper {
    flex: 0 0 220px;
}

.form-group.date-actions-row .date-wrapper > div {
    width: 100%;
}

.form-group.date-actions-row .button-group {
    display: flex;
    gap: 80px;
    margin-left: auto;
     margin-right: auto;
}

/* Type + Posting Row - Second Line */
.form-group.type-posting-row {
    display: flex;
    align-items: center;
    gap: 15px;
    padding: 10px 0;
    margin-bottom: 12px;
}

.form-group.type-posting-row label {
    font-weight: 600;
    color: #253858;
    white-space: nowrap;
    min-width: 60px;
    text-align: right;
}

.form-group.type-posting-row select {
    width: 180px;
    padding: 6px 10px;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    font-size: 14px;
}

.form-group.type-posting-row .date-wrapper {
    flex: 0 0 220px;
}

.form-group.type-posting-row .date-wrapper > div {
    width: 100%;
}

/* ------------------------------
   TABLE SECTIONS
------------------------------ */

.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #fff;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 0 0 1px #e5e7eb;
}

.cr-table th,
.cr-table td {
    padding: 8px 12px;
    border-bottom: 1px solid #eef0f6;
    font-size: 14px;
}

.cr-table th {
    background: #eef0f6;
    font-weight: 600;
    color: #354B6A;
}

.cr-table tr:last-child td {
    border-bottom: none;
}

/* ------------------------------
   SCROLL AREAS
------------------------------ */

.hidden-scrollbar {
    overflow: auto;
}

.hidden-scrollbar::-webkit-scrollbar {
    width: 10px;
}

/* ------------------------------
   BUTTONS
------------------------------ */

button, .myButton {
    background: #007bff;
    border: none;
    padding: 8px 20px;
    color: #fff;
    border-radius: 6px;
    cursor: pointer;
    font-weight: 600;
    transition: background 0.2s;
    font-size: 14px;
    white-space: nowrap;
}

button:hover, .myButton:hover {
    background: #0056b3;
}

button:active, .myButton:active {
    transform: translateY(1px);
}

/* ------------------------------
   RESPONSIVE DESIGN
------------------------------ */

@media (max-width: 1200px) {
    .form-group.date-actions-row {
        flex-wrap: wrap;
    }
    
    .form-group.date-actions-row .button-group {
        margin-left: 0;
        width: 100%;
    }
}

@media (max-width: 768px) {
    .form-group.date-actions-row label,
    .form-group.type-posting-row label {
        min-width: auto;
    }
    
    .form-group.date-actions-row .date-wrapper,
    .form-group.type-posting-row .date-wrapper {
        flex: 1 1 auto;
        min-width: 150px;
    }
    
    .form-group.type-posting-row select {
        width: 100%;
        min-width: 120px;
    }
}
</style>

</head>
<body onload="setValues();headerbtndisable();">
<div id="mainBG" class="homeContent hidden-scrollbar" data-type="background" >
<form id="frmUnclearedChequeProcessing" action="saveUnclearedChequeProcessing" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div  class=' receipt-header'>

 <div class="form-group date-actions-row">
        <label for="jqxUnclearedChequeProcessFromDate">Uncleared P.D.C From</label>
        <div class="date-wrapper">
            <div id="jqxUnclearedChequeProcessFromDate" 
                 name="jqxUnclearedChequeProcessFromDate" 
                 value='<s:property value="jqxUnclearedChequeProcessFromDate"/>'></div>
            <input type="hidden" 
                   id="hidjqxUnclearedChequeProcessFromDate" 
                   name="hidjqxUnclearedChequeProcessFromDate" 
                   value='<s:property value="hidjqxUnclearedChequeProcessFromDate"/>'/>
        </div>

        <label for="jqxUnclearedChequeProcessToDate">P.D.C. Upto</label>
        <div class="date-wrapper">
            <div id="jqxUnclearedChequeProcessToDate" 
                 name="jqxUnclearedChequeProcessToDate" 
                 value='<s:property value="jqxUnclearedChequeProcessToDate"/>'></div>
            <input type="hidden" 
                   id="hidjqxUnclearedChequeProcessToDate" 
                   name="hidjqxUnclearedChequeProcessToDate" 
                   value='<s:property value="hidjqxUnclearedChequeProcessToDate"/>'/>
        </div>

        <div class="button-group">
            <button class="myButton" type="button" 
                    id="btnUnclearedChequeSearch" 
                    name="btnUnclearedChequeSearch" 
                    onclick="funloadgrid();">
                View
            </button>
            <button class="myButton" type="button" 
                    id="btnsavemaster" 
                    name="btnsavemaster">
                Save Changes
            </button>
        </div>

        <!-- Hidden Date (not displayed) -->
        <div class="date-wrapper" style="display:none;">
            <div id="jqxUnclearedChequeProcessingDate" 
                 name="jqxUnclearedChequeProcessingDate" 
                 value='<s:property value="jqxUnclearedChequeProcessingDate"/>'></div>
            <input type="hidden" 
                   id="hidjqxUnclearedChequeProcessingDate" 
                   name="hidjqxUnclearedChequeProcessingDate" 
                   value='<s:property value="hidjqxUnclearedChequeProcessingDate"/>'/>
        </div>
    </div>

    <!-- Row 2: Type + Posting Date -->
    <div class="form-group type-posting-row">
        <label for="cmbtype">Type</label>
        <select id="cmbtype" name="cmbtype" value='<s:property value="cmbtype"/>'>
            <option value="">--Select--</option>
            <option value="UCP">Payment</option>
            <option value="UCR">Receipt</option>
        </select>
        <input type="hidden" id="hidcmbtype" name="hidcmbtype" 
               value='<s:property value="hidcmbtype"/>'/>

        <label for="postingDate" style="margin-left:190px;">Posting</label>
        <div class="date-wrapper">
            <div id="postingDate" name="postingDate" 
                 onchange="datechange();" 
                 onblur="datechange();" 
                 value='<s:property value="postingDate"/>'></div>
            <input type="hidden" id="hidpostingDate" name="hidpostingDate" 
                   value='<s:property value="hidpostingDate"/>'/>
        </div>
    </div>

</div>

<div class="cr-table" id="unclearedChequeProcessingDiv"><center><jsp:include page="unclearedChequeProcessingGrid.jsp"></jsp:include></center></div><br/>

<div id="bankPaymentDiv" style="visibility:hidden;"><center><jsp:include page="bankPaymentGrid.jsp"></jsp:include></center></div><br/>

<table width="100%">
  <tr>
    <td width="7%" align="right">Dr. Total</td>
    <td width="68%"><input type="text" id="txtdrtotal" name="txtdrtotal" style="width:15%;text-align: right;" value='<s:property value="txtdrtotal"/>'/></td>
    <td width="6%" align="right">Cr. Total</td>
    <td width="19%"><input type="text" id="txtcrtotal" name="txtcrtotal" style="width:50%;text-align: right;" value='<s:property value="txtcrtotal"/>' tabindex="-1"/></td>
  </tr>
</table>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="txtchqno" name="txtchqno" value='<s:property value="txtchqno"/>'/>
<input type="hidden" id="txtchqdt" name="txtchqdt" value='<s:property value="txtchqdt"/>'/>
<input type="hidden" id="txtchqname" name="txtchqname" value='<s:property value="txtchqname"/>'/>
<input type="hidden" id="chckpdc" name="chckpdc" value='<s:property value="chckpdc"/>'/>
<input type="hidden" id="txtfromrate" name="txtfromrate" value='<s:property value="txtfromrate"/>'/>
<input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
<input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
<input type="hidden" id="txtgriddtype" name="txtgriddtype" value='<s:property value="txtgriddtype"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
</div>
</form>
	
</div>
</body>
</html>
