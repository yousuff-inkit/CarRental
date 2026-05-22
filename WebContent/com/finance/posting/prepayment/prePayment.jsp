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

<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

<style>
/* =========================================================
   MODERN ERP UI - STRICT TABLE LAYOUT (NO CLIPPING)
========================================================= */
body {
    background: #f4f6f9;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #333;
    font-size: 12px;
    margin: 0;
    padding: 15px;
    box-sizing: border-box;
}

#mainBG {
    background: #fff;
    border-radius: 4px;
    padding: 15px;
    max-width: 100%;
    margin: auto;
    box-shadow: 0 2px 6px rgba(0,0,0,0.08);
    box-sizing: border-box;
    /* Completely removed height and overflow restrictions to allow natural scrolling */
}

/* Master Inputs */
input[type="text"], select {
    height: 24px !important;
    border: 1px solid #c5d3e0;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 12px;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    box-sizing: border-box;
    width: 100%;
    background-color: #fff;
    color: #333;
}

input[type="text"]:focus, select:focus {
    border-color: #007bff;
    outline: none;
}

input[readonly], input[disabled], select[disabled] {
    background-color: #f0f3f5;
    color: #666;
}

/* Table Settings */
table {
    border-collapse: separate;
    border-spacing: 5px 6px; 
    width: 100%;
    table-layout: fixed;
}

td {
    vertical-align: middle;
    padding: 0;
}

.lbl-right {
    text-align: right;
    font-weight: 600;
    color: #222;
    padding-right: 5px;
    white-space: nowrap;
    font-size: 12px;
}

/* Panel Containers */
.search-panel {
    background-color: #fff;
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    padding: 8px;
    margin-bottom: 10px;
}

fieldset {
    border: 1px solid #c5d3e0;
    background-color: #fff;
    margin-bottom: 10px;
    padding: 10px;
    border-radius: 4px;
}

legend {
    font-size: 13px;
    font-weight: bold;
    color: #0056b3;
    padding: 0 8px;
}

/* Buttons - Removed width: 100% to allow natural sizing and adjacent placement */
.myButton {
    height: 26px;
    padding: 0 18px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #fff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 12px;
    font-weight: bold;
    box-shadow: 0 1px 2px rgba(59, 130, 246, 0.3);
    transition: all 0.2s;
    white-space: nowrap;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

.myButton:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%);
}

.icon-btn {
    background: none;
    border: none;
    cursor: pointer;
    padding: 0;
    display: inline-flex;
    align-items: center;
    justify-content: center;
}

.icon-btn img {
    height: 26px;
}

/* Utility layout for buttons sitting side-by-side inside a TD */
.btn-group-right {
    display: flex;
    justify-content: flex-end;
    gap: 8px;
    align-items: center;
}
</style>

<script type="text/javascript">
	$(document).ready(function() {
		 $('#btnCalculate').attr('hidden', true );
		 fundecreaseamt();funinstallment();
		 $("#btnpost").hide();$("#btndist").hide();
			
         // Disable all standard header buttons except Create/Add/Save
         $('#btnEdit, #btnDelete, #btnSearch, #btnApprove, #btnApproval, #btnAttach, #btnAttachment, #btnPrint, #btnExcel').prop('disabled', true)
            .css({'pointer-events': 'none', 'opacity': '0.5'})
            .attr('tabindex', '-1');
		 
		 $("#jqxFromDate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
		 $("#jqxToDate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
		 $("#jqxStartDate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy", enableBrowserBoundsDetection: true });
		 $("#jqxEndDate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy", enableBrowserBoundsDetection: true });
		 $("#maindate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
         
         setTimeout(function () {
            $(".jqx-datetimeinput").css({"margin-top": "0px", "border-color": "#c5d3e0", "border-radius": "3px"});
            $(".jqx-datetimeinput").find("input").css({
                "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
                "font-family": "'Segoe UI', 'Roboto', 'Arial', sans-serif", "padding": "0 6px", "box-sizing":"border-box"
            });
            $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
        }, 100);
		 
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 $('#costTypeSearchGridWindow').jqxWindow({width: '35%', height: '58%',  maxHeight: '70%' ,maxWidth: '45%' , title: 'Cost Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#costTypeSearchGridWindow').jqxWindow('close');
 		 
 		 $('#txtdueafter').val(0);  $('#txtinstnos').val(1);
		 
		 var curfromdate= $('#jqxFromDate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#jqxFromDate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
		 
		 $('#jqxFromDate').on('change', function (event) {
				var fromdate = $('#jqxFromDate').jqxDateTimeInput('getDate');
			 });
		 
		 $('#jqxToDate').on('change', function (event) {
				var todate = $('#jqxToDate').jqxDateTimeInput('getDate');
			 });
			 
		$('#txtaccid').dblclick(function(){
			  var date = $('#maindate').jqxDateTimeInput('getDate');
			  accountSearchContent("accountsDetailsSearch.jsp?date="+date);
			  $('#txtforsearch').val(2);
			  });
		  
		  $('#txtdistributionaccid').dblclick(function(){
			  var date = $('#maindate').jqxDateTimeInput('getDate');
			  accountSearchContent("accountsDetailsSearch.jsp?date="+date);
			  $('#txtforsearch').val(1);
			  });
		  
		  $('#txtcostgroup').dblclick(function(){
			  costTypeSearchContent("costTypeSearchGrid.jsp");
			  });
		
		  $('#txtcostcode').dblclick(function(){
			  var costtype = $('#txtcosttype').val();
			  costTypeSearchContent("costCodeSearchGrid.jsp?costtype="+costtype);
			  });

		$('#btnSave').removeAttr('onclick');
		$('#btnSave').off('mousedown');
		$('#btnSave').on('click', function(e) {
			e.preventDefault();
			var validationResult = funNotify();
			if (validationResult === 1) {
				$.messager.confirm('Confirm', 'Do you want to save changes?', function(r){
					if (r){
						funSetlabel();
						$("#overlay, #PleaseWait").show();
						$('#brchName').attr('disabled', false);
						$('#currency').attr('disabled', false);
						$('#frmPrePayment').submit();
					}
				});
			}
		});
	});
	
	function accountSearchContent(url){
		   $('#accountDetailsWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#accountDetailsWindow').jqxWindow('setContent', data);
			$('#accountDetailsWindow').jqxWindow('bringToFront');
		}); 
	}
	
	function costTypeSearchContent(url) {
	    $('#costTypeSearchGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costTypeSearchGridWindow').jqxWindow('setContent', data);
		$('#costTypeSearchGridWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function cardCommission(tranid,trno,dtype,acno,i,length){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200){
				 items= x.responseText;
				 items=items.split(":");
				 var amount=items[0];
				 var commission=items[1];
				 var index=items[2];
				  $("#postingCardGrid").jqxGrid('setcellvalue', index, "commission", commission);
				  $("#postingCardGrid").jqxGrid('setcellvalue', index, "amountcomm", amount);
				}
		}
		x.open("GET","getCommissionAmount.jsp?cardtype="+cardtype+"&netamt="+netamt+"&paytype="+paytype+"&comm="+comm+"&index="+i,true);
		x.send();
	}
	
	function getInstallmentNumbers(frequency,startdate,enddate,inschk){
 		var x = new XMLHttpRequest();
 		x.onreadystatechange = function() {
 			if (x.readyState == 4 && x.status == 200) {
 				var items = x.responseText;
 			    $('#txtinstnos').val(items.trim());
 		}
 		}
 		x.open("GET", "getInstallmentNumber.jsp?frequency="+frequency+'&startdate='+startdate+'&enddate='+enddate+'&inschk='+inschk, true);
 		x.send();
    }
	
	function getInstallmentEndDate(frequency,installno,startdate,instalchk){
 		var x = new XMLHttpRequest();
 		x.onreadystatechange = function() {
 			if (x.readyState == 4 && x.status == 200) {
 				var items = x.responseText;
 				if(instalchk==1){
 			    $('#jqxEndDate').val(items);
 				}
 		}
 		}
 		x.open("GET", "getInstallmentEndDate.jsp?frequency="+frequency+'&installno='+installno+'&startdate='+startdate+'&instalchk='+instalchk, true);
 		x.send();
    }
	
    function funReadOnly(){
		$('#frmPrePayment input').attr('readonly', true );
		$('#frmPrePayment select').attr('disabled', true);
		$('#jqxFromDate').jqxDateTimeInput({disabled: true});
		$('#jqxToDate').jqxDateTimeInput({disabled: true});
		$('#jqxStartDate').jqxDateTimeInput({disabled: true});
		$('#jqxEndDate').jqxDateTimeInput({disabled: true});
	    $("#jqxPrePayment").jqxGrid({ disabled: true});
	    $("#jqxDistributionGrid").jqxGrid({ disabled: true});
	    $("#jqxJournalVoucherApplying").jqxGrid({ disabled: true});
	    $("#btnSubmit").hide();$("#btnDistributionSubmit").hide();$("#btnUpdate").hide();
	    $("#btnPrintSummary").hide();$("#btnpost").hide();$("#btndist").hide();
	}
	
    function funExportBtn(){
	    JSONToCSVCon(dataExcelExport, 'PrePayment', true);
	 }
    
	function funRemoveReadOnly(){
		funinstallment();
	    $('#frmPrePayment input').attr('readonly', false );
		$('#frmPrePayment select').attr('disabled', false);
		$('#jqxFromDate').jqxDateTimeInput({disabled: false});
		$('#jqxToDate').jqxDateTimeInput({disabled: false});
		$('#jqxStartDate').jqxDateTimeInput({disabled: false});
		$('#jqxEndDate').jqxDateTimeInput({disabled: false});
		$('#docno').attr('readonly', true );
		$('#txtaccid').attr('readonly', true );
	    $('#txtaccname').attr('readonly', true );
	    $('#txtdueafter').val(0);
	    $('#txtdistributionaccid').attr('readonly', true );
	    $('#txtdistributionaccname').attr('readonly', true );
	    $('#txtcostgroup').attr('readonly', true ); 
	    $('#txtcostcode').attr('readonly', true ); 
		$("#jqxPrePayment").jqxGrid({ disabled: true});
		$("#jqxDistributionGrid").jqxGrid({ disabled: true});
		$("#jqxJournalVoucherApplying").jqxGrid({ disabled: true});
		$("#btnSubmit").show();$("#btnPrintSummary").hide();
		$("#btnDistributionSubmit").hide();$("#btnUpdate").hide();
		$("#btnpost").hide();$("#btndist").hide();
		 
		 if ($("#mode").val() == "A") {
			 $('#jqxFromDate').val(new Date());
			 var curfromdate= $('#jqxFromDate').jqxDateTimeInput('getDate');
		     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
		     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
		     $('#jqxFromDate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
		     $('#jqxToDate').val(new Date());
		     $('#jqxStartDate').val(new Date());
		     $('#jqxEndDate').val(new Date());
			 
			 $("#jqxPrePayment").jqxGrid('clear');
			 $("#jqxPrePayment").jqxGrid('addrow', null, {});
			 $("#jqxDistributionGrid").jqxGrid('clear');
			 $("#jqxDistributionGrid").jqxGrid('addrow', null, {});
		}  
	}
	
	function funSearchLoad(){}
	function funChkButton(){}
	function funFocus(){ document.getElementById("txtaccid").focus(); }
	
	function funNotify(){
		 valid=document.getElementById("txtvalidation").value;
		 if(valid==1){
			 document.getElementById("errormsg").innerText="Invalid Transaction !!!";
			 return 0;
		 }
		 if(parseInt($('#cmbtype').val())==0){
			 document.getElementById("errormsg").innerText="Please Choose a Type.";
			 return 0;
		 }
		 if(parseInt($('#cmbtype').val())==1){
			 var rows = $("#jqxDistributionGrid").jqxGrid('getrows');
			 if(rows.length==0){
				 document.getElementById("errormsg").innerText="Please Distribute the Amount.";
				 return 0;
			 }
		 }
		 if(parseInt($('#cmbtype').val())==3){
			 var rows = $("#jqxJournalVoucherApplying").jqxGrid('getrows');
			 if(rows.length==0){
				 document.getElementById("errormsg").innerText="Invalid Posting !!!";
				 return 0;
			 }
		 }
		 var costgroup=document.getElementById("txtcostgroup").value;
		 var costype=document.getElementById("txtcosttype").value;
		 var costcode=document.getElementById("txtcostcode").value;
		 var description=document.getElementById("txtdescription").value;
		 var desaccid=document.getElementById("txtdistributionaccid").value; 
		 var desaccname=document.getElementById("txtdistributionaccname").value;
		 
		 var hidmodes=$("#hidmodes").val();
		 if(hidmodes!="DIS"){
			 if(parseInt($('#cmbtype').val())==1){
		 if(costgroup=="" || costype=="" || costcode=="" ||  desaccid=="" || desaccname==""){
			 document.getElementById("errormsg").innerText="Please Enter Distribution Details";
			 return 0;
		 }
		}
	 }
		 
 		 var amount = document.getElementById("txtamount").value;
         var total=$('#jqxDistributionGrid').jqxGrid('getcolumnaggregateddata', 'amount', ['sum'], true);
         total1=total.sum;
         document.getElementById("txtinstamttotal").value=total1;
         
   			if((parseFloat(total1)>parseFloat(amount)) || (parseFloat(total1)<parseFloat(amount))){ 
   				document.getElementById("errormsg").innerText="Invalid Transaction,Sum of Distribution is not Valid.";
   		        $('#txtvalidation').val(1);
   		         return 0;  
   			}
   			
		document.getElementById("errormsg").innerText="";
			
	  var rows = $("#jqxDistributionGrid").jqxGrid('getrows');
	  var length=0;
		 for(var i=0 ; i < rows.length ; i++){
			var chk=rows[i].amount;
			var chkdate=rows[i].date;
			if(typeof(chk) != "undefined" && typeof(chkdate) != "undefined" && chkdate!="" && chkdate!="null" && chkdate!=null){
				length=length+1;
					newTextBox = $(document.createElement("input"))
				    .attr("type", "dil")
				    .attr("id", "test"+i)
				    .attr("name", "test"+i)
					.attr("hidden", "true");
				
				newTextBox.val(rows[i].sr_no+":: "+rows[i].date+":: "+rows[i].amount+":: "+rows[i].posted+":: "+rows[i].rowno);
				newTextBox.appendTo('form');
				}
			}
	 		 $('#gridlength').val(length);
			
	 		 var rows = $("#jqxJournalVoucherApplying").jqxGrid('getrows');
	    	 var length=0;
			 for(var i=0 ; i < rows.length ; i++){
				var applychk=rows[i].doc_no;
					if(typeof(applychk) != "undefined" && 
						(((rows[i].credit!=null) && (rows[i].credit!='undefined') &&  (rows[i].credit!='NaN') && (rows[i].credit!="") && (rows[i].credit!=0)) || 
						 ((rows[i].debit!=null) && (rows[i].debit!='undefined') && (rows[i].debit!='NaN') && (rows[i].debit!="") && (rows[i].debit!=0)))){
					
					newTextBox = $(document.createElement("input"))
				    .attr("type", "dil")
				    .attr("id", "txtapply"+length)
				    .attr("name", "txtapply"+length)
					.attr("hidden", "txtapply")
					.attr("hidden", "true");
					
					length=length+1;
					
				var amount,baseamount,id;
				if((rows[i].credit!=null) && (rows[i].credit!='undefined') &&  (rows[i].credit!='NaN') && (rows[i].credit!="") && (rows[i].credit!=0)){
					 amount=rows[i].credit*-1;
					 baseamount=rows[i].rate*rows[i].credit*-1;
					 id=-1;
				}
				if((rows[i].debit!=null) && (rows[i].debit!='undefined') && (rows[i].debit!='NaN') && (rows[i].debit!="") && (rows[i].debit!=0)){
					 amount=rows[i].debit;
					 baseamount=rows[i].rate*rows[i].debit;
					 id=1;
				}
				else{}
				
				newTextBox.val(rows[i].doc_no+":: "+rows[i].description+":: "+rows[i].currencyid+":: "+rows[i].rate+":: "+amount+":: "+baseamount+":: "+rows[i].sr_no+":: "+id+":: "+rows[i].costtype+":: "+rows[i].costcode);
				newTextBox.appendTo('form');
				}
			 }
			 $('#applylength').val(length);
	 		 
	 		 $('#jqxFromDate').jqxDateTimeInput({disabled: false});
             $('#jqxToDate').jqxDateTimeInput({disabled: false});
             $('#jqxStartDate').jqxDateTimeInput({disabled: false});
             $('#txtinstnos').jqxDateTimeInput({disabled: false});
			 $('#jqxEndDate').jqxDateTimeInput({disabled: false});
			return 1;
	} 
	
	function setValues(){
		document.getElementById("cmbtype").value=document.getElementById("hidcmbtype").value;
		
		if($('#hidjqxFromDate').val()){ $("#jqxFromDate").jqxDateTimeInput('val', $('#hidjqxFromDate').val());  }
		if($('#hidjqxToDate').val()){ $("#jqxToDate").jqxDateTimeInput('val', $('#hidjqxToDate').val());  }
		if($('#hidjqxStartDate').val()){ $("#jqxStartDate").jqxDateTimeInput('val', $('#hidjqxStartDate').val());  }
		if($('#hidjqxEndDate').val()){ $("#jqxEndDate").jqxDateTimeInput('val', $('#hidjqxEndDate').val());  }
		if($('#hidmaindate').val()){ $("#maindate").jqxDateTimeInput('val', $('#hidmaindate').val());  }
	 
		 if($('#msg').val()!=""){
			 if($('#cmbtype').val()=='3'){
			     $.messager.alert('Message',$('#txtmsg').val());
			 } else {
				 $.messager.alert('Message',$('#msg').val()); 
			 }
	     }
		 
		 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		 funSetlabel();
		 
		 $('#cmbtype').attr('disabled', false );
	     var indexVal = document.getElementById("cmbtype").value;
		 if(indexVal>0){ gridloading(); }
		 if(indexVal==2){ distributiongridreloading(); }
		 $('#cmbtype').attr('disabled', true );
		 funRoundAmt($('#txtamount').val(),"txtamount");
	}
	
	 $(function(){
	        $('#frmPrePayment').validate({
	                rules: { cmbtype:"required", txtdescription:{maxlength:500} },
	                 messages: { cmbtype:" *", txtdescription: {maxlength:"    Max 500 chars"} }
	        });});
	
	function getAcc(event){
        var x= event.keyCode;
        if(x==114){
        	var date = $('#maindate').jqxDateTimeInput('getDate');
			accountSearchContent("accountsDetailsSearch.jsp?date="+date);
      		$('#txtforsearch').val(2);
        }
    }
	
	function getcostType(event){
        var x= event.keyCode;
        if(x==114){
			costTypeSearchContent("costTypeSearchGrid.jsp");
        }
    }
	
	function getcostNo(event){
        var x= event.keyCode;
        if(x==114){
        	var costtype = $('#txtcosttype').val();
			costTypeSearchContent("costCodeSearchGrid.jsp?costtype="+costtype);
        }
    }
	
	function getDistributionAcc(event){
        var x= event.keyCode;
        if(x==114){
        	var date = $('#maindate').jqxDateTimeInput('getDate');
			accountSearchContent("accountsDetailsSearch.jsp?date="+date);
        	$('#txtforsearch').val(1);
        }
    }
		
	function gridloading(){
		  var type = document.getElementById("cmbtype").value;
		  var accId = document.getElementById("txtdocno").value;
		  var fromDate = document.getElementById("jqxFromDate").value;
		  var toDate = document.getElementById("jqxToDate").value;
		  $('#txtdueafter').val(0);
		  if(type!=0){
			  var check = 1;
			  $("#overlay, #PleaseWait").show();
		  	  $("#jqxPrePaymentGrid").load('prePaymentGrid.jsp?txttype='+type+'&accId='+accId+'&fromDate='+fromDate+'&toDate='+toDate+'&check='+check);
		  }
	}
	
	function funloadgrid(){
		  $("#jqxPrePayment").jqxGrid('disabled', false);
		  var type = document.getElementById("cmbtype").value;
		 if(type==1){ $("#btnpost").hide(); }
		 if(type==2){ $("#btndist").hide(); }  
		  if(type!=2){
	      $("#btnUpdate").hide();
		  $("#btnPrintSummary").hide();
		  }
		  if(type==2){
			  $("#btnDistributionSubmit").hide();
			  } 
		  if(type==3){
			  var paymentPostingdate =$('#jqxToDate').jqxDateTimeInput('getDate');
			  var validdate=funDateInPeriod(paymentPostingdate);
					  if(parseInt(validdate)==0){ return 0;	}
		  }
		  $('#txtaccountdocno').val('');$('#txtdistributiondocno').val('');$('#txtdistributionaccid').val('');$('#txtdistributionaccname').val('');
		  $('#txttrno').val('');$('#txtdtype').val('');$('#txttranid').val('');$('#txtcostgroup').val('');$('#txtcosttype').val('');$('#txtcostno').val('');
		  $('#txtamount').val('');$('#hidcmbfrequency').val('');$('#txtdueafter').val('');$('#txtinstnos').val('');$('#txtinstamt').val('');
		  $('#txtdescription').val('');$('#txtdebittotal').val('');$('#txtrowno').val('');
		  
		  if (document.getElementById("txtdistributionaccid").value == "") {
		        $('#txtdistributionaccid').attr('placeholder', 'Press F3 to Search'); 
		    }
		  
		  var type = document.getElementById("cmbtype").value;
		  
		  if(type==2){ $('#btnSave').attr('disabled', true ); }
		  else{ $('#btnSave').attr('disabled', false ); }
		  
		  if(type!=2){
			  $('#jqxStartDate').jqxDateTimeInput({disabled: false});$('#cmbfrequency').attr('disabled', false );$('#txtdueafter').attr('readonly', false );
			  $('#txtinstnos').attr('readonly', false );$('#txtdescription').attr('readonly', false );
			  $("#jqxStartDate").jqxDateTimeInput('val', new Date());$("#jqxEndDate").jqxDateTimeInput('val', new Date());
		  }
		  if(type==3){
			  var account=document.getElementById("txtdocno").value;
				 if(account==''){
					 document.getElementById("errormsg").innerText="Account is Mandatory.";
					 $("#jqxPrePayment").jqxGrid('disabled', true);
					 $('#btnCalculate').attr('hidden', true );
					 return 0;
				 }
			  document.getElementById("errormsg").innerText="";
			  $('#btnCalculate').attr('hidden', false );
		  }
		  else{ $('#btnCalculate').attr('hidden', true ); }
		  
		  $("#jqxDistributionGrid").jqxGrid('clear');
		  $("#jqxDistributionGrid").jqxGrid('addrow', null, {});
		  $("#jqxJournalVoucherApplying").jqxGrid('clear');
		  
		  gridloading();
    }
	
	function distributiongridloading(){
		  var startdate = $('#jqxStartDate').jqxDateTimeInput('getText');
		  var enddate = $('#jqxEndDate').jqxDateTimeInput('getText');
		  var cmbfrequency = document.getElementById("cmbfrequency").value;
		  var amount = document.getElementById("txtamount").value;
		  var instno = document.getElementById("txtinstnos").value;
		  var instamt = document.getElementById("txtinstamt").value;
		  var dueafter = document.getElementById("txtdueafter").value;
		  
		  if(dueafter==''){
		  		document.getElementById("errormsg").innerText="Due After is Mandatory.";
		  		return 0;
		  }
				  
		  document.getElementById("errormsg").innerText=""; 
		  
		  var check = 1;
		  $("#jqxDistributionGrid1").load('distributionGrid.jsp?cmbfrequency='+cmbfrequency+'&startdate='+startdate+'&enddate='+enddate+'&amount='+amount+'&instno='+instno+'&instamt='+instamt+'&dueafter='+dueafter+'&check='+check);
	  }
	
	function funloaddistributiongrid(){
		var grtype=document.getElementById("hidgrtype").value;
    	 if((grtype==4) || (grtype==5)){
    		 document.getElementById("errormsg").innerText="";
    			if(($('#txtcostgroup').val()==null) || ($('#txtcostgroup').val()=='undefined') || ($('#txtcostgroup').val()=='NA') || ($('#txtcostgroup').val()=="") || ($('#txtcostgroup').val()==0)){
    			document.getElementById("errormsg").innerText="Cost Type is Mandatory for Income/Expence Accounts.";
    			return 0;
    		}
    	 }
		  $("#jqxDistributionGrid").jqxGrid({ disabled: false});
		  distributiongridloading();
	}
	
	function distributiongridreloading(){
		  var tranid = document.getElementById("txttranid").value;
		  var check = 1;
		  $("#jqxDistributionGrid1").load('distributionGrid.jsp?tranId='+tranid+'&check='+check);
	  }
	
	function funreloaddistributiongrid(){
		  $("#btnUpdate").show();$("#btnDistributionSubmit").hide();distributiongridreloading();
		  $('#txtamount').attr('readonly', true );$('#cmbfrequency').attr('disabled', true );
		  $('#txtdueafter').attr('readonly', true );$('#txtinstnos').attr('readonly', true );$('#txtdescription').attr('readonly', true );
	}

	 function funUpdate(){
      if(document.getElementById("btnUpdate").value=="Edit"){      	  
    	 $("#jqxDistributionGrid").jqxGrid({ disabled: false});
         document.getElementById("btnUpdate").value="Update";
         return 0;
       }
      else if(document.getElementById("btnUpdate").value=="Update"){
    	    $('#btnSave').mousedown();
           }
       }
	 
	 function funPrintSummary() {
			if (($("#mode").val() == "A") && $("#cmbtype").val()=="2") {
				 var url=document.URL;
			     var reurl=url.split("prePayment.jsp");
				 var win= window.open(reurl[0]+"printPrePayment?tranid="+document.getElementById("txttranid").value+"&branch="+document.getElementById("brchName").value,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
			     win.focus();
		     }
		    else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	    }
	 
	 function funPostingGrid(){
		 var posted=$('#cmbtype').val();
         if(posted==3){
        	 $("#jqxDistribution").prop("hidden", true); 
        	 $("#jqxJournalVoucherApplyingGrid").prop("hidden", false);
			 $('#btnCalculate').attr('hidden', false );
         }
         else{
        	 $("#jqxJournalVoucherApplyingGrid").prop("hidden", true);
        	 $("#jqxDistribution").prop("hidden", false);
			 $('#btnCalculate').attr('hidden', true );
         }
	 }
	 
	 function funInstAmount(){
		 var amount=$('#txtamount').val();
		 var instno=$('#txtinstnos').val();
		 $("#jqxDistributionGrid").jqxGrid({ disabled: true});
		 $("#jqxDistributionGrid").jqxGrid('clear');
		 $("#jqxDistributionGrid").jqxGrid('addrow', null, {});
		 
		 if(parseInt(instno)==0 || instno==""){
			 instno=1;
			 $('#txtinstnos').val(1);
		 } 
		 if(!isNaN(amount)){
		     var result = amount / instno;
			 $('#txtinstamt').val(result);
			 }
			 else if(isNaN(amount)){
			 	 $('#txtinstamt').val(0.0);
			 }
	 }
	 
	 function clearDistributionInfo(){
		  $('#jqxStartDate').val(new Date());
		  $("#jqxDistributionGrid").jqxGrid({ disabled: true});
		  $("#jqxDistributionGrid").jqxGrid('clear');
		  $("#jqxDistributionGrid").jqxGrid('addrow', null, {});
	  }
	 
	 function clearDistributionsInfo(){
		  $("#jqxDistributionGrid").jqxGrid({ disabled: true});
		  $("#jqxDistributionGrid").jqxGrid('clear');
		  $("#jqxDistributionGrid").jqxGrid('addrow', null, {});
	  }
	 
	 function funCalculate(){
		 	var rows=$("#jqxPrePayment").jqxGrid('getrows');
		 	var value = $('#cmbtype').val();
		 	var sdate=$('#jqxFromDate').val();
		 	var tdate=$('#jqxToDate').val();
		 	var startdate = $('#jqxStartDate').jqxDateTimeInput('getText');
			var enddate = $('#jqxEndDate').jqxDateTimeInput('getText');
			
			var selectedrows=$("#jqxPrePayment").jqxGrid('selectedrowindexes');
			selectedrows = selectedrows.sort(function(a,b){return a - b});
			
			if(selectedrows.length==0){
				$("#overlay, #PleaseWait").hide();
				$.messager.alert('Warning','Select Items to be Calculated.');
				return false;
			}
			
			if(selectedrows.length>0){
				$("#jqxJournalVoucherApplying").jqxGrid('clear');
				$("#jqxJournalVoucherApplying").jqxGrid({ disabled: false});
				
				for (var k = 0; k <= selectedrows.length; k++) {
					$("#jqxJournalVoucherApplying").jqxGrid('addrow', null, {});
				}
			}
			
			var temp="";
			var drtotal=0;
			var rowno="";
			var postacno="";
				
			var j=0;var k=0;
		    for (var i = 0; i < rows.length; i++) {
					if(selectedrows[j]==i){
						
						 document.getElementById("txttrno").value = $('#jqxPrePayment').jqxGrid('getcellvalue', i, "trno");
			           	 document.getElementById("txtdtype").value = $('#jqxPrePayment').jqxGrid('getcellvalue', i, "dtype");
			           	 document.getElementById("txttranid").value = $('#jqxPrePayment').jqxGrid('getcellvalue', i, "tranid");
			           	 document.getElementById("txtaccountdocno").value = $('#jqxPrePayment').jqxGrid('getcellvalue', i, "acno");
			           	 document.getElementById("txtcostgroup").value = $('#jqxPrePayment').jqxGrid('getcellvalue', i, "costgroup");
			           	 document.getElementById("txtcosttype").value = $('#jqxPrePayment').jqxGrid('getcellvalue', i, "costtype"); 
			           	 document.getElementById("txtcostno").value = $('#jqxPrePayment').jqxGrid('getcellvalue', i, "costcode");
			           	 
			           	 drtotal=drtotal+rows[i].dramount;
			           	
						 if(i==0){ temp=rows[i].trno; }
						 else{ temp=temp+","+rows[i].trno; }
						
						if(k==0){ rowno=rows[i].rowno;postacno=rows[i].postacno;k=1;} else{ rowno=rowno+","+rows[i].rowno;postacno=postacno+","+rows[i].postacno;}
						
						$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', j+1, "doc_no", $('#jqxPrePayment').jqxGrid('getcellvalue', i, "postacno"));
						$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', j+1, "atype", $('#jqxPrePayment').jqxGrid('getcellvalue', i, "atype"));
						$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', j+1, "account", $('#jqxPrePayment').jqxGrid('getcellvalue', i, "paccount"));
						$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', j+1, "accountname", $('#jqxPrePayment').jqxGrid('getcellvalue', i, "paccountname"));
						$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', j+1, "costtype", $('#jqxPrePayment').jqxGrid('getcellvalue', i, "costtype"));
						$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', j+1, "costgroup", $('#jqxPrePayment').jqxGrid('getcellvalue', i, "costgroup"));
						$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', j+1, "costcode", $('#jqxPrePayment').jqxGrid('getcellvalue', i, "costcode"));
						$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', j+1, "costcde", $('#jqxPrePayment').jqxGrid('getcellvalue', i, "costcode"));
						$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', j+1, "debit", $('#jqxPrePayment').jqxGrid('getcellvalue', i, "dramount"));
						$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', j+1, "credit", "");
						$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', j+1, "description", $('#jqxPrePayment').jqxGrid('getcellvalue', i, "desc1"));
						$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', j+1, "currencyid", $('#jqxPrePayment').jqxGrid('getcellvalue', i, "curid"));
						$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', j+1, "rate", $('#jqxPrePayment').jqxGrid('getcellvalue', i, "c_rate"));
						$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', j+1, "ref_row", $('#jqxPrePayment').jqxGrid('getcellvalue', i, "rowno"));
						$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', j+1, "sr_no", j+1);
						
					   j++; 
				     }
					
					$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "doc_no", document.getElementById("txtdocno").value);
					$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "atype", "GL");
					$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "account", document.getElementById("txtaccid").value);
					$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "accountname", document.getElementById("txtaccname").value);
					$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "costtype", "");
					$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "costgroup", "");
					$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "costcode", "0");
					$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "costcde", "0");
					$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "debit", "");
					$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "credit", drtotal);
					$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "description", ("PREPAYMENT FOR PERIOD "+$('#jqxFromDate').val()+" "+$('#jqxToDate').val()));
					$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "currencyid", $('#jqxPrePayment').jqxGrid('getcellvalue', i, "curid"));
					$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "rate", $('#jqxPrePayment').jqxGrid('getcellvalue', i, "c_rate"));
					$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "ref_row", "");
					$("#jqxJournalVoucherApplying").jqxGrid('setcellvalue', 0, "sr_no", 0);
					
					document.getElementById("txtrowno").value = rowno;
					document.getElementById("txtdistributiondocno").value = postacno;
	            }
		    document.getElementById("txtdebittotal").value =drtotal;
	 }
		
		function funInsEndDate(){
		  	   var inststartday= $('#jqxStartDate').jqxDateTimeInput('getDate');
		  	   if(inststartday==null){
				 	document.getElementById("errormsg").innerText="Start Date is Mandatory.";
				 	return 0;
			   }
		  	   if(inststartday>($('#jqxEndDate').jqxDateTimeInput('getDate'))){
				 	document.getElementById("errormsg").innerText="Start Date Should be less than End Date.";
				 	return 0;
			   }
		  	   document.getElementById("errormsg").innerText="";
			   var startdate = $('#jqxStartDate').jqxDateTimeInput('getText');
			   var installno = document.getElementById("txtinstnos").value;
			   var frequency = document.getElementById("cmbfrequency").value;
			   var instalchk = document.getElementById("hiins_chk").value;
			   getInstallmentEndDate(frequency,installno,startdate,instalchk);
	 }
	 
	 function funInsNoFromEndDate(){
			 var inststartday= $('#jqxStartDate').jqxDateTimeInput('getDate');
			 var instendday= $('#jqxEndDate').jqxDateTimeInput('getDate');

			 if(inststartday==null){
				 document.getElementById("errormsg").innerText="Start Date is Mandatory.";
				 return 0;
			 }
			 if(instendday==null){
				 document.getElementById("errormsg").innerText="End Date is Mandatory.";
				 return 0;
			 }
			 if(inststartday>instendday){
				 document.getElementById("errormsg").innerText="Start Date Should be less than End Date.";
				 return 0;
			 }
			 document.getElementById("errormsg").innerText="";
			 $('#cmbfrequency').attr('disabled', false);
			 var startdate = $('#jqxStartDate').jqxDateTimeInput('getText');
			 var enddate = $('#jqxEndDate').jqxDateTimeInput('getText');
			 var frequency = document.getElementById("cmbfrequency").value;
			var inschk=document.getElementById("hiins_chk").value;
			 if($('#cmbtype').val()=='2') { $('#cmbfrequency').attr('disabled', true); }
			 getInstallmentNumbers(frequency,startdate,enddate,inschk);
	 }
	 
	 function funinstallment(){
		 if(document.getElementById("ins_chk").checked){
			 document.getElementById("hiins_chk").value = 1; 
			 $('#txtdueafter').val(1);
			 $('#txtinstnos').val('');
			 $('#jqxEndDate').val(new Date());
	    }else{
		     document.getElementById("hiins_chk").value = 0; 
		     $('#txtdueafter').val(0);
		     $('#txtinstnos').val('');
		     $('#jqxEndDate').val(new Date());
		}
		 var inschk=document.getElementById("hiins_chk").value;
		 if(inschk==1){
			 $('#txtinstnos').attr('disabled',false);
			 $('#jqxEndDate').jqxDateTimeInput({disabled: true});
		 }else{
			 $('#txtinstnos').attr('disabled',true);
			 $('#jqxEndDate').jqxDateTimeInput({disabled: false});
		 }
	}
	
	function fundecreaseamt(){
		 if(document.getElementById("det_chk").checked){
			 document.getElementById("hidet_chk").value = 1; 
	    }else{
		     document.getElementById("hidet_chk").value = 0; 
		}
	    var chk=document.getElementById("hidet_chk").value;
	    var amount=parseFloat(document.getElementById("txtamount").value);
		var decamount=parseFloat(document.getElementById("txtdecamount").value);
		var hidamount=parseFloat(document.getElementById("hidtxtamount").value);
		if(isNaN(amount)){ amount=0; }
		if(isNaN(decamount)){ decamount=0; }
		
		if(chk==1){
			if(decamount>amount){
				 $.messager.alert('Message','Cannot be greater than Amount');
				}
			else{
			$('#txtdecamount').attr('disabled', false);
			 document.getElementById("txtamount").value =amount-decamount;
			}
		}else{
			$('#txtdecamount').attr('disabled', true);
			document.getElementById("txtamount").value =hidamount;
			document.getElementById("txtdecamount").value ="";
		}
	}

	function fundistribution(){
		  document.getElementById("hidmodes").value ="DIS";
		$.messager.confirm('Confirm', 'Transaction marked as Distributed will not come for posting , Do you want to save?', function(r){
			if (r){
				  var temp=funNotify();
				   if(temp>0){
					   funSetlabel();
					  $("#overlay, #PleaseWait").show();
					   $('#brchName').attr('disabled', false);$('#currency').attr('disabled', false);
					   $('#frmPrePayment').submit();
				   }
			}
	 		});
	}

function updateinvoice(){
		var tranid=$('#txttranid').val();
		if(tranid=='' ){
			 $.messager.confirm('Warning', 'Please select a Document!');
				      return false;
			 }
			var rows = $("#jqxDistributionGrid").jqxGrid('selectedrowindexes');
		 if(rows.length==0 || rows.length==''){
			 $.messager.confirm('Warning', 'Please select atleast 1 Row');
			return false;
		}
		  $.messager.confirm('Confirm', 'Do you want to Mark as Invoiced?', function(r){
				if (r){
					updateinv();	
				}
			});
}

function updateinv(){
	var rows = $("#jqxDistributionGrid").jqxGrid('selectedrowindexes');
	var upinvarray=new Array();
	var tranid=$('#txttranid').val();
	
	 for(var i=0;i<rows.length;i++){
		 upinvarray.push($('#jqxDistributionGrid').jqxGrid('getcellvalue',rows[i],'rowno'));
	}
	 var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200){
				var items=x.responseText.trim();
				$('.load-wrapp').hide();
				if(parseInt(items)=="0")  
				{	
					$.messager.alert('Message', ' Successfully Updated ');
					funloadgrid();
				}
				else
				{
					$.messager.alert('Message', ' Not Updated  ');
				}
			}
		}
		x.open("POST","markPosted.jsp?tranid="+tranid+"&upinvarray="+upinvarray+"&upinvlength="+rows.length,true);	 		
		x.send();	
 }
</script>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmPrePayment" action="savePrePayment" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div class='hidden-scrollbar'>

<div class="search-panel">
    <table width="100%" border="0" cellspacing="5" cellpadding="0">
        <colgroup>
            <col width="6%" />
            <col width="12%" />
            <col width="18%" />
            <col width="4%" />
            <col width="12%" />
            <col width="3%" />
            <col width="12%" />
            <col width="4%" />
            <col width="14%" />
            <col width="10%" />
        </colgroup>
        <tr>
            <td class="lbl-right">Account</td>
            <td>
                <input type="text" id="txtaccid" name="txtaccid" placeholder="Press F3" value='<s:property value="txtaccid"/>' onkeydown="getAcc(event);"/>
            </td>
            <td>
                <input type="text" id="txtaccname" name="txtaccname" value='<s:property value="txtaccname"/>'/> 
                <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
            </td>
            <td class="lbl-right">From</td>
            <td>
                <div id="jqxFromDate" name="jqxFromDate" value='<s:property value="jqxFromDate"/>'></div>
                <input type="hidden" id="hidjqxFromDate" name="hidjqxFromDate" value='<s:property value="hidjqxFromDate"/>'/>
            </td>
            <td class="lbl-right">To</td>
            <td>
                <div id="jqxToDate" name="jqxToDate" value='<s:property value="jqxToDate"/>'></div>
                <input type="hidden" id="hidjqxToDate" name="hidjqxToDate" value='<s:property value="hidjqxToDate"/>'/>
            </td>
            <td class="lbl-right">Type</td>
            <td>
                <select id="cmbtype" name="cmbtype" onchange="funPostingGrid();" value='<s:property value="cmbtype"/>'>
                    <option value="0">--Select--</option>
                    <option value="1">For Distribution</option>
                    <option value="2">Summary</option>
                    <option value="3">To be Posted</option>
                </select>
                <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/>
            </td>
            <td align="right">
                <button class="myButton" type="button" id="btnSubmit" name="btnSubmit" onclick="funloadgrid();">Submit</button>
            </td>
        </tr>
    </table>
</div>

<fieldset>
    <legend>Details</legend>
    <div id="jqxPrePaymentGrid"><jsp:include page="prePaymentGrid.jsp"></jsp:include></div>
</fieldset>

<div id="jqxDistribution"><br/>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <colgroup>
            <col width="65%" />
            <col width="2%" />
            <col width="33%" />
        </colgroup>
        <tr>
            <td valign="top">
                <fieldset>
                    <legend>Distribution</legend>
                    <table width="100%" border="0" cellspacing="5" cellpadding="0">
                        <colgroup>
                            <col width="18%" />
                            <col width="16%" />
                            <col width="5%" />
                            <col width="38%" />
                            <col width="23%" />
                        </colgroup>
                        <tr>
                            <td class="lbl-right">Account (To be Posted)</td>
                            <td>
                                <input type="text" id="txtdistributionaccid" name="txtdistributionaccid" placeholder="Press F3" value='<s:property value="txtdistributionaccid"/>' onkeydown="getDistributionAcc(event);"/>
                            </td>
                            <td></td>
                            <td>
                                <input type="text" id="txtdistributionaccname" name="txtdistributionaccname" tabindex="-1" value='<s:property value="txtdistributionaccname"/>'/>
                                <input type="hidden" id="txtdistributiondocno" name="txtdistributiondocno" value='<s:property value="txtdistributiondocno"/>'/>
                                <input type="hidden" id="txtaccountdocno" name="txtaccountdocno" value='<s:property value="txtaccountdocno"/>'/>
                                <input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
                                <input type="hidden" id="txtdtype" name="txtdtype" value='<s:property value="txtdtype"/>'/>
                                <input type="hidden" id="txttranid" name="txttranid" value='<s:property value="txttranid"/>'/>
                            </td>
                            <td></td>
                        </tr>
                        
                        <tr>
                            <td class="lbl-right">Cost Type</td>
                            <td>
                                <input type="text" id="txtcostgroup" readonly name="txtcostgroup" placeholder="Press F3" tabindex="2" onkeydown="getcostType(event);" value='<s:property value="txtcostgroup"/>'/>
                                <input type="hidden" id="txtcosttype" name="txtcosttype" value='<s:property value="txtcosttype"/>'/>
                            </td>
                            <td class="lbl-right">Cost No</td>
                            <td>
                                <input type="text" id="txtcostcode" readonly name="txtcostcode" tabindex="4" onkeydown="getcostNo(event);" placeholder="Press F3" value='<s:property value="txtcostcode"/>'/>
                                <input type="hidden" id="txtcostno" name="txtcostno" value='<s:property value="txtcostno"/>'/>
                            </td>
                            <td align="right">
                                <div class="btn-group-right">
                                    <input type="button" name="btnPrintSummary" id="btnPrintSummary" class="myButton" value="Print" onclick="funPrintSummary();">
                                    <button class="myButton" type="button" id="btndist" name="btndist">Mark Dist.</button>
                                </div>
                            </td>
                        </tr>
                    </table>
                    
                    <hr style="border: 0; border-top: 1px solid #c5d3e0; margin: 8px 0;">
                    
                    <table width="100%" border="0" cellspacing="5" cellpadding="0">
                        <colgroup>
                            <col width="18%" />
                            <col width="16%" />
                            <col width="8%" />
                            <col width="8%" />
                            <col width="14%" />
                            <col width="10%" />
                            <col width="16%" />
                            <col width="10%" />
                        </colgroup>
                        <tr>
                            <td class="lbl-right">Amount</td>
                            <td>
                                <input type="text" id="txtamount" name="txtamount" onchange="fundecreaseamt();" value='<s:property value="txtamount"/>' onblur="funRoundAmt(this.value,this.id);"/>
                            </td>
                            <td align="center">
                                <input type="checkbox" id="det_chk" name="det_chk" value="" onchange="fundecreaseamt();" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                                <input type="hidden" id="hidet_chk" name="hidet_chk">
                            </td>
                            <td class="lbl-right">Settle Amt</td>
                            <td>
                                <input type="text" id="txtdecamount" name="txtdecamount" onchange="fundecreaseamt();" value='<s:property value="txtdecamount"/>'/>
                            </td>
                            <td class="lbl-right">Frequency</td>
                            <td>
                                <select id="cmbfrequency" name="cmbfrequency" onchange="clearDistributionInfo();" value='<s:property value="cmbfrequency"/>'>
                                    <option value="2">Month</option>
                                </select>
                                <input type="hidden" id="hidcmbfrequency" name="hidcmbfrequency" value='<s:property value="hidcmbfrequency"/>'/>
                            </td>
                            <td></td>
                        </tr>
                        
                        <tr>
                            <td class="lbl-right">Due After</td>
                            <td>
                                <input type="text" id="txtdueafter" name="txtdueafter" onblur="clearDistributionsInfo();" value='<s:property value="txtdueafter"/>'/>
                            </td>
                            <td align="center">
                                <input type="checkbox" id="ins_chk" name="ins_chk" value="" onchange="funinstallment();" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                                <input type="hidden" id="hiins_chk" name="hiins_chk"> 
                            </td>
                            <td colspan="2" style="font-size: 12px; font-weight: bold; color: #444;">Equal Installment</td>
                            <td class="lbl-right">Inst. Nos</td>
                            <td>
                                <input type="text" id="txtinstnos" name="txtinstnos" onblur="funInstAmount();funInsEndDate();" value='<s:property value="txtinstnos"/>'/>
                                <input type="hidden" id="hitxtinstnos" name="hitxtinstnos" value='<s:property value="hitxtinstnos"/>'/> 
                                <input type="hidden" id="txtinstamt" name="txtinstamt" value='<s:property value="txtinstamt"/>'/>
                            </td>
                            <td></td>
                        </tr>
                    </table>
                    
                    <hr style="border: 0; border-top: 1px solid #c5d3e0; margin: 8px 0;">
                    
                    <table width="100%" border="0" cellspacing="5" cellpadding="0">
                        <colgroup>
                            <col width="18%" />
                            <col width="16%" />
                            <col width="8%" />
                            <col width="16%" />
                            <col width="42%" />
                        </colgroup>
                        <tr>
                            <td class="lbl-right">For Period From</td>
                            <td>
                                <div id="jqxStartDate" name="jqxStartDate" tabindex="8" onchange="funInsEndDate();funInsNoFromEndDate();" value='<s:property value="jqxStartDate"/>'></div>
                                <input type="hidden" id="hidjqxStartDate" name="hidjqxStartDate" value='<s:property value="hidjqxStartDate"/>'/>
                            </td>
                            <td class="lbl-right">To date</td>
                            <td>
                                <div id="jqxEndDate" name="jqxEndDate" tabindex="9" onchange="funInsNoFromEndDate();" value='<s:property value="jqxEndDate"/>'></div>
                                <input type="hidden" id="hidjqxEndDate" name="hidjqxEndDate" value='<s:property value="hidjqxEndDate"/>'/>
                            </td>
                            <td align="right">
                                <div class="btn-group-right">
                                    <button class="myButton" type="button" id="btnDistributionSubmit" name="btnDistributionSubmit" tabindex="11" onclick="funloaddistributiongrid();">Submit</button>
                                    <input type="button" name="btnUpdate" id="btnUpdate" class="myButton" value="Edit" tabindex="12" onclick="funUpdate();">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="lbl-right">Description</td>
                            <td colspan="4">
                                <input type="text" id="txtdescription" name="txtdescription" value='<s:property value="txtdescription"/>'/>
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
            
            <td></td> <td valign="top">
                <div style="border: 1px solid #c5d3e0; border-radius: 4px; background: #fff; height: 100%;">
                    <div id="jqxDistributionGrid1">
                        <jsp:include page="distributionGrid.jsp"></jsp:include>
                    </div>
                </div>
            </td>
        </tr>
    </table>
</div>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
    <tr>
        <td width="70%">
            <button type="button" class="icon-btn" id="btnExcel" title="Export current Document to Excel" onclick="funExportBtn();">
                <img alt="excelDocument" src="<%=contextPath%>/icons/excel_new.png">
            </button> 
        </td>
        <td width="30%" align="right">
            <button class="myButton" type="button" id="btnpost" name="btnpost" onclick="updateinvoice();" tabindex="11" style="padding: 0 30px;">Mark as Invoiced</button>
        </td>
    </tr> 
</table>

<button type="button" class="icon-btn" id="btnCalculate" title="Calculate" onclick="funCalculate();" style="margin-top: 5px;">
    <img alt="Calculate" src="<%=contextPath%>/icons/calculate_new.png">
</button>
                      
<div id="jqxJournalVoucherApplyingGrid" hidden="true"><br/><jsp:include page="journalVoucherApplyingGrid.jsp"></jsp:include></div>
</div>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
<input type="hidden" id="txtmsg" name="txtmsg" value='<s:property value="txtmsg"/>'/>
<div hidden="hidden" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
<input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
<input type="hidden" id="txttranno" name="txttranno" value='<s:property value="txttranno"/>'/>
<input type="hidden" id="txtdebittotal" name="txtdebittotal" value='<s:property value="txtdebittotal"/>'/>
<input type="hidden" id="txtrowno" name="txtrowno" value='<s:property value="txtrowno"/>'/>
<input type="hidden" name="txtforsearch" id="txtforsearch" value='<s:property value="txtforsearch"/>'>
<input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
<input type="hidden" id="applylength" name="applylength"/>
<input type="hidden" id="hidgrtype" name="hidgrtype"/>
<input type="hidden" id="hidtxtamount" name="hidtxtamount"/>
<input type="hidden" id="txtinstamttotal" name="txtinstamttotal" value='<s:property value="txtinstamttotal"/>'/>
<input type="hidden" id="hidmodes" name="hidmodes"/>

</form> 

<div id="accountDetailsWindow"><div></div><div></div></div>
<div id="costTypeSearchGridWindow"><div></div><div></div></div> 
 
</div>
</body>
</html>