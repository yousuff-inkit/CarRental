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

<%
	String mod = request.getParameter("mod")==null?"":request.getParameter("mod").toString();   
	String acno = request.getParameter("acno")==null || request.getParameter("acno")==""?"0":request.getParameter("acno").toString();  
	String client = request.getParameter("client")==null?"":request.getParameter("client").toString();
	String cldocno = request.getParameter("cldocno")==null || request.getParameter("cldocno").equals("")?"0":request.getParameter("cldocno").toString();
	String account = request.getParameter("account")==null?"":request.getParameter("account").toString(); 
	String agmttype = request.getParameter("agmttype")==null?"":request.getParameter("agmttype").toString();  
	String agmtvocno = request.getParameter("agmtvocno")==null?"":request.getParameter("agmtvocno").toString();  
	String agmtdocno = request.getParameter("agmtdocno")==null?"":request.getParameter("agmtdocno").toString();     
	String amount = request.getParameter("amount")==null || request.getParameter("amount").equals("")?"0":request.getParameter("amount").toString();
	String remarks = request.getParameter("remarks")==null?"":request.getParameter("remarks").toString();
	String cnrdocno = request.getParameter("cnrdocno")==null || request.getParameter("cnrdocno").equals("")?"0":request.getParameter("cnrdocno").toString();
%>    
<script type="text/javascript">
var mod1 = '<%=mod%>';
$(document).ready(function() {
	
	 $("#jqxRentalRefundDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	 $("#jqxReferenceDate").jqxDateTimeInput({ width: '110px', height: '15px', formatString:"dd.MM.yyyy"});		 

	 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#accountDetailsWindow').jqxWindow('close'); 
	 
	 $('#agreementDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Agreement Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#agreementDetailsWindow').jqxWindow('close');
	 
	 $('#clientDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#clientDetailsWindow').jqxWindow('close'); 
	 
	 $('#cardDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Card Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#cardDetailsWindow').jqxWindow('close');
	 
	 $('#printWindow').jqxWindow({width: '31%', height: '28%',  maxHeight: '70%' ,maxWidth: '31%' , title: 'Print',position: { x: 400, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#printWindow').jqxWindow('close');
	 
	 $('#txtaccid').dblclick(function(){
		  var date = $('#jqxRentalRefundDate').jqxDateTimeInput('getDate');
 	  	  $("#maindate").jqxDateTimeInput('val', date);
 	  	  accountSearchContent(<%=contextPath+"/"%>+"com/operations/accountsDetailsSearch.jsp?date="+date);
		  });
	 
	  $('#txtagreementvocher').dblclick(function(){
		  agreementSearchContent('agreementSearch.jsp?clientId='+$('#txtcldocno').val());
		  });
	 
	  $('#txtclientid').dblclick(function(){
		  var date = $('#jqxRentalRefundDate').jqxDateTimeInput('getDate');
		  $("#maindate").jqxDateTimeInput('val', date);
		  clientSearchContent(<%=contextPath+"/"%>+"com/operations/clientAccountDetailsSearch.jsp?atype=AR"+"&date="+date);
          $('#txtforsearch').val(1);
	 });
});

function getBranch() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var branchIdItems  = items[0].split(",");
				var branchItems = items[1].split(",");
				var optionsbranch = '<option value="">--Select--</option>';
				for (var i = 0; i < branchItems.length; i++) {
					optionsbranch += '<option value="' + branchIdItems[i].trim() + '">'
							+ branchItems[i] + '</option>';
				}
				$("select#cmbbranch").html(optionsbranch);
				if ($('#hidcmbbranch').val() != null) {
					$('#cmbbranch').val($('#hidcmbbranch').val());
				}
			} else {
			}
		}
		x.open("GET", <%=contextPath+"/"%>+"com/operations/commtransactions/getBranch.jsp", true);
		x.send();
	}
	
	function accountSearchContent(url) {
	 	$('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function agreementSearchContent(url) {
	 	$('#agreementDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#agreementDetailsWindow').jqxWindow('setContent', data);
		$('#agreementDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function clientSearchContent(url) {
	 	$('#clientDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientDetailsWindow').jqxWindow('setContent', data);
		$('#clientDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function cardSearchContent(url) {
	 	$('#cardDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#cardDetailsWindow').jqxWindow('setContent', data);
		$('#cardDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function RefundPrintContent(url) {
		$('#printWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#printWindow').jqxWindow('setContent', data);
		$('#printWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function checkIb(){
		 if(document.getElementById("hidchckib").value==1){
			 document.getElementById("chckib").checked = true;
		 }
		 else if(document.getElementById("hidchckib").value==0){
			document.getElementById("chckib").checked = false;
		  }
		 }
	
	 function funReadOnly(){
			$('#frmRentalRefund input').attr('readonly', true );
			$('#frmRentalRefund select').attr('disabled', true);
			$('#chckib').attr('disabled', true);
			$('#jqxRentalRefundDate').jqxDateTimeInput({disabled: true});
			$('#jqxReferenceDate').jqxDateTimeInput({disabled: true});
			$('#btnCardSearch').attr('disabled', true);
			$("#jqxSecurity").jqxGrid({ disabled: true});
			
			if(mod1=="A") {
			    document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
				document.getElementById("formdetail").value=window.parent.formName.value;
				document.getElementById("formdetailcode").value=window.parent.formCode.value.trim(); 
				funCreateBtn();  
			}
	 }
	 function funRemoveReadOnly(){
		    getBranch();getCardTypes();checkIb();
			$('#frmRentalRefund input').attr('readonly', false );
			$('#frmRentalRefund select').attr('disabled', false);
			$('#chckib').attr('disabled', false);
			$('#jqxRentalRefundDate').jqxDateTimeInput({disabled: false});
			$('#jqxReferenceDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$('#txtdoctype').attr('readonly', true);
			$('#txtsrno').attr('readonly', true);
			$('#txtaccid').attr('readonly', true);
			$('#txtaccname').attr('readonly', true);
			$('#txtclientid').attr('readonly', true);
			$('#txtclientname').attr('readonly', true);
			$('#txtagreementvocher').attr('readonly', true);
			$('#txtnetamount').attr('readonly', true ); 
			$('#txtchequeno').attr('readonly', true);
			$('#cmbbranch').attr('disabled', true);
			$('#txtamount').attr('readonly', true);
			$("#jqxSecurity").jqxGrid({ disabled: false});
			
		    if ($("#mode").val() == "E") {
			    $('#cmbpaytype').attr('disabled', true);
				$('#chckib').attr('disabled', true);
				$('#cmbbranch').attr('disabled', true);
				$('#txtaccid').attr('readonly', true);
				$('#txtaccname').attr('readonly', true);
				$('#cmbcardtype').attr('disabled', true);
			} 
			
			if ($("#mode").val() == "A") {
				$('#jqxRentalRefundDate').val(new Date());
				$('#jqxReferenceDate').val(new Date());
				$("#jqxSecurity").jqxGrid('clear');
				$("#jqxSecurity").jqxGrid('addrow', null, {});
				$('#cmbpaytype').val('');$('#cmbcardtype').val('');$('#cmbratype').val('');$('#cmbpayedas').val('');
				$('#txtaccid').attr('placeholder','');
			}
			
			if (mod1 == "A") { 
				 document.getElementById("cnrdocno").value='<%=cnrdocno%>'; 
				 document.getElementById("txtclientid").value='<%=account%>';
				 document.getElementById("txtclientname").value='<%=client%>';  
			     document.getElementById("txtacno").value='<%=acno%>';
		         document.getElementById("txtcldocno").value='<%=cldocno%>';  
		         document.getElementById("cmbratype").value='<%=agmttype%>';  
		         document.getElementById("hidcmbratype").value='<%=agmttype%>';  
		         document.getElementById("txtagreementvocher").value='<%=agmtvocno%>';  
		         document.getElementById("txtagreement").value='<%=agmtdocno%>';  
		         document.getElementById("txtamount").value='<%=amount%>';
		         document.getElementById("txtdescriptions").value='<%=remarks%>';  
		         document.getElementById("txtonaccountamount").value='<%=amount%>';
		         
		         $("#txtclientid, #txtclientname,#txtacno, #cmbratype,#txtagreementvocher, #txtamount, #txtonaccountamount").prop("readonly", true);
		     }
	 }
	
	function funSearchLoad(){
	      changeContent('rrpMainSearch.jsp');  
	}
		
	 function funChkButton() {
			/* funReset(); */
	}
	 
	function funFocus(){
	    	$('#jqxRentalRefundDate').jqxDateTimeInput('focus'); 	    		
	}
	
	 /* Validations */
	 $(function(){
	    $('#frmRentalRefund').validate({
	    	    rules: {
	            txtamount:{number:true},
	            txtdeduction:{number:true},
				txtaddamount:{number:true},
	            txtnetamount:{number:true},
	            txtonaccountamount:{number:true},
	            txtdescription:{maxlength:500},
	            txtdescriptions:{maxlength:500},
	            cmbpayedas:"required"
	             },
	             messages: {
	             txtamount:{number:"Invalid"},
	             txtdeduction:{number:"Invalid"},
				 txtaddamount:{number:"Invalid"},
	             txtnetamount:{number:"Invalid"},
	             txtonaccountamount:{number:"Invalid"},
	             txtdescription: {maxlength:"    Max 500 chars"},
	             txtdescriptions: {maxlength:"    Max 500 chars"},
	             cmbpayedas:"*"
	             }
	 });}); 
	
    function funNotify(){	
    	/* Validation */
		
		var paydate = $('#jqxRentalRefundDate').jqxDateTimeInput('getDate');
		var validdate=funDateInPeriod(paydate);
		 if(parseInt(validdate)==0){
			document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
			return 0;	
		 }
		
		ibvalid=document.getElementById("txtibvalidation").value;
		 if(ibvalid==1){
			 document.getElementById("errormsg").innerText="Closing Done For Inter-Branch,Transaction Restricted. ";
			 return 0;
		 }
		 
    	valid=document.getElementById("txtvalidation").value;
		if(valid==1){
			 document.getElementById("errormsg").innerText="Invalid Transaction !!!";
			 return 0;
		}
		 
		if($('#hidchckib').val()==1){
			 mainbranch=document.getElementById("brchName").value;
			 ibbranch=document.getElementById("cmbbranch").value;
			 if(mainbranch==ibbranch){
				 document.getElementById("errormsg").innerText="Main branch & Inter-Branch need to be Different,Transaction Restricted.";
				 return 0;
			 }
		}
		
		 var netvalue = document.getElementById("txtnetamount").value;
		 var onaccountvalue = document.getElementById("txtonaccountamount").value;
		 if((netvalue=="" || netvalue=="NaN" || netvalue==0 || netvalue==0.0 || netvalue==0.00) && (onaccountvalue=="" || onaccountvalue=="NaN" || onaccountvalue==0 || onaccountvalue==0.0 || onaccountvalue==0.00)){
			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Amount should not be Zero.";
             return 0;
	 	 }
		 
		 document.getElementById("errormsg").innerText="";
		 /* Validation Ends*/
    	 
    	/* Security Grid Saving */
 		var rows = $("#jqxSecurity").jqxGrid('getrows');
		var length=0;
		 for(var i=0 ; i < rows.length ; i++){
			var chk=rows[i].tobepaid;
			if(typeof(chk) != "undefined"){
				length=length+1;
				newTextBox = $(document.createElement("input"))
			    .attr("type", "dil")
			    .attr("id", "txtapply"+i)
			    .attr("name", "txtapply"+i)
			    .attr("hidden", "true");
				
			newTextBox.val(rows[i].tobepaid+"::"+(parseInt(rows[i].out_amount)+parseInt(rows[i].tobepaid))+"::"+rows[i].currency+"::"+rows[i].tranid+"::"+rows[i].securityacno);
			newTextBox.appendTo('form');
			}
		 }
		 $('#applylength').val(length);
		 /* Security Grid Saving Ends*/
		 
		 /* Security Grid Updating */
	 		var rows = $("#jqxSecurity").jqxGrid('getrows');
			var length=0;
			 for(var i=0 ; i < rows.length ; i++){
				var chk=rows[i].tobepaid;
				if(typeof(chk) != "undefined"){
					length=length+1;
					newTextBox = $(document.createElement("input"))
				    .attr("type", "dil")
				    .attr("id", "txtapplyupdate"+i)
				    .attr("name", "txtapplyupdate"+i)
				    .attr("hidden", "true");
					
				newTextBox.val(parseInt(rows[i].out_amount)-parseInt(rows[i].tobepaid)+"::"+rows[i].tranid);
				newTextBox.appendTo('form');
				}
			 }
			 $('#applylengthupdate').val(length);
			 /* Security Grid Updating Ends*/
			 
		 $('#jqxRentalRefundDate').jqxDateTimeInput({disabled: false});
         $('#jqxReferenceDate').jqxDateTimeInput({disabled: false});
         $('#cmbpaytype').attr('disabled', false);
		 $('#cmbcardtype').attr('disabled', false);
  		 $('#chckib').attr('disabled', false);
  		 $('#cmbbranch').attr('disabled', false);
	   			 
  		return 1;
	} 
	
   function setValues(){
	  getBranch();getCardTypes();checkIb();
	  
	  document.getElementById("cmbpaytype").value=document.getElementById("hidcmbpaytype").value;
	  document.getElementById("cmbratype").value=document.getElementById("hidcmbratype").value;
	  document.getElementById("cmbpayedas").value=document.getElementById("hidcmbpayedas").value;
	  document.getElementById("cmbcardtype").value=document.getElementById("hidcmbcardtype").value;
	   
	  if($('#hidjqxRentalRefundDate').val()){
			 $("#jqxRentalRefundDate").jqxDateTimeInput('val', $('#hidjqxRentalRefundDate').val());
		  }
	  
	  if($('#hidjqxReferenceDate').val()){
			 $("#jqxReferenceDate").jqxDateTimeInput('val', $('#hidjqxReferenceDate').val());
		  }
	  
	   if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
	   
	   var paid = document.getElementById("cmbpayedas").value;
	   if(paid==1){
	    var indexVal = document.getElementById("txttranno").value;
	    var indexVal1 = document.getElementById("txtsecurityacno").value;
		if(indexVal>0){
	         $("#jqxSecurityGrid").load("securityGrid.jsp?txttranno2="+indexVal+"&txtsecurityacno2="+indexVal1); 
	         } 
	      }
       } 
	
	function getAccounts(a){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var accountIdItems  = items[0];
  				var accountItems = items[1];
  				var docNoItems = items[2];
				var payTypeItems = items[3];
  				
  				if(parseInt(payTypeItems)==1 || parseInt(payTypeItems)==3){
					$('#txtaccid').val(accountIdItems) ;
					$('#txtaccname').val(accountItems) ;
					$('#txtdocno').val(docNoItems) ;
				}
  		}
  		}
  		x.open("GET", "getAccounts.jsp?paytype="+a, true);
  		x.send();
    }
	
	function getCardTypes() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var cardIdItems  = items[0].split(",");
  				var cardItems = items[1].split(",");
  				var optionscard = '<option value="">--Select--</option>';
  				for (var i = 0; i < cardItems.length; i++) {
  					optionscard += '<option value="' + cardIdItems[i].trim() + '">'
  							+ cardItems[i] + '</option>';
  				}
  				$("select#cmbcardtype").html(optionscard);
  				if ($('#hidcmbcardtype').val() != null) {
  					$('#cmbcardtype').val($('#hidcmbcardtype').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getCardTypes.jsp", true);
  		x.send();
  	}
	
	function getAgreement(event){
	  var x= event.keyCode;
	  if(x==114){
	  	agreementSearchContent('agreementSearch.jsp');
	  }
	 }
	 
	function getClient(event){
	  var x= event.keyCode;
	  if(x==114){
		  var date = $('#jqxRentalRefundDate').jqxDateTimeInput('getDate');
		  $("#maindate").jqxDateTimeInput('val', date);
		  clientSearchContent(<%=contextPath+"/"%>+"com/operations/clientAccountDetailsSearch.jsp?atype=AR"+"&date="+date);
          $('#txtforsearch').val(1);
	  }
	 }
	 
	 function funCardSearch(){
		cardSearchContent('cardDetailsSearchGrid.jsp?clientId='+$('#txtcldocno').val());
	}
	 
	 function getAcc(event){
        var x= event.keyCode;
        if(x==114){
      	  var date = $('#jqxRentalRefundDate').jqxDateTimeInput('getDate');
      	  $("#maindate").jqxDateTimeInput('val', date);
      	  accountSearchContent(<%=contextPath+"/"%>+"com/operations/accountsDetailsSearch.jsp?date="+date);
        }
        else{}
        }
	
	function funCheck(a){
		  if(document.getElementById("chckib").checked != false){
		 		 $('#hidchckib').val(1);
		 		 $('#cmbbranch').attr('disabled', false );
		  }
		  else{
			  $('#hidchckib').val(0); 
			  $('#cmbbranch').attr('disabled', true );
		  }
	  }
		
	function funchequedate(){
		  paytype=document.getElementById("cmbpaytype").value;
		  if(paytype==1){
			  $('#cmbcardtype').attr('disabled', true);
			  $('#txtchequeno').attr('readonly', true);  
			  $('#btnCardSearch').attr('disabled', true);
			  $('#cmbcardtype').val('');
			  $('#txtchequeno').val('');$('#jqxReferenceDate').val(new Date());
		  }else if(paytype==2){
			  $('#cmbcardtype').attr('disabled', true);
			  $('#txtchequeno').attr('readonly', false);
			  $('#btnCardSearch').attr('disabled', true);
			  $('#cmbcardtype').val('');
			  $('#txtchequeno').val('');$('#jqxReferenceDate').val(new Date());
	      } else if(paytype==3){
    		  $('#cmbcardtype').attr('disabled', false); 
    		  $('#txtchequeno').attr('readonly', false);
    		  $('#btnCardSearch').attr('disabled', false);
    		  $('#cmbcardtype').val('');
    		  $('#txtchequeno').val('');$('#jqxReferenceDate').val(new Date());
    	  }
    }
	
	function funclearchequecardno(){
    	$('#txtchequeno').val('');$('#jqxReferenceDate').val(new Date());
    }
	
	function bankAccountSearch(){
		 if(document.getElementById("cmbpaytype").value == 2){
			 $('#txtaccid').val('');$('#txtaccname').val('');$('#txtdocno').val('');
			 if (document.getElementById("txtaccid").value == "") {
			        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
			    }
			 $('#txtaccid').focus();
			 
		 }else{
			 $('#txtaccid').val('');$('#txtaccid').attr('placeholder', '');
			 $('#txtaccid').attr('tabindex', '-1');
			 $('#txtaccname').attr('tabindex', '-1');
		 }
	}
	 
	function applyDisable(){
    	paid=document.getElementById("cmbpayedas").value;
    	deduction=document.getElementById("txtdeduction").value;
    	if(deduction==null || deduction=="" || typeof(deduction)=="undefined" || typeof(deduction)=="NaN"){
    		$('#txtdeduction').val(0.00);
    	}
        if(paid==1){
    		var indexVal = document.getElementById("txtagreement").value;
    		var rtype = document.getElementById("cmbratype").value;
    		if(indexVal>0){
   	         $("#jqxSecurityGrid").load("securityGrid.jsp?txtagreement2="+indexVal+"&cmbratype2="+rtype); 
   	         } 
    		$("#jqxSecurity").jqxGrid({ disabled: false});
    		$('#txtdeduction').attr('readonly', false);
			$('#txtaddamount').attr('readonly', false);
    		$('#txtnetamount').attr('readonly', false);
    		$('#txtonaccountamount').attr('readonly', true);
    		$('#txtonaccountamount').val('');
    		
    	}
        else if(paid==2){
    		$("#jqxSecurity").jqxGrid('clear');
			$("#jqxSecurity").jqxGrid('addrow', null, {});
    	    $("#jqxSecurity").jqxGrid({ disabled: true});
    		$('#txtdeduction').attr('readonly', true);
			$('#txtaddamount').attr('readonly', true);
    		$('#txtnetamount').attr('readonly', true);
    		$('#txtonaccountamount').attr('readonly', false);
    		$('#txtamount').val('');$('#txtdeduction').val('');
    		$('#txtaddamount').val('');$('#txtnetamount').val('');
    	}
    } 
	
	function getNetTotal(){
        var amount = $('#txtamount').val();
        var discount = $('#txtdeduction').val();
        var additionalamt = $('#txtaddamount').val();
        var netamount=$('#txtnetamount').val();
        
        if(amount!=''){
        	netamount=(parseFloat(amount));
      	}
        
        if(discount!=''){
      		netamount=((parseFloat(amount)-parseFloat(discount)));
      	}
     
        if(additionalamt!=''){
     		netamount=((parseFloat(amount)-parseFloat(discount))+parseFloat(additionalamt));
     	}
        
     	funRoundAmt(Math.round(netamount),"txtnetamount");
    }
	
	function funPrintBtn(){
    	if (($("#mode").val() == "view") && $("#txtsrno").val()!="") {
	        RefundPrintContent('printVoucherWindow.jsp');
	     }
	    else {
			$.messager.alert('Message','Select a Document....!','warning');
			return;
		}
    }
	
	function datechange(){
		  var date = $('#jqxRentalRefundDate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(date);
			 if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
			 }
		  $("#maindate").jqxDateTimeInput('val', date);
		  
		  if($('#hidchckib').val()==1){
			  if($('#cmbbranch').val()!='' && $('#cmbbranch').val()!=null){
				funIBDateInPeriod($('#jqxRentalRefundDate').val(),$('#cmbbranch').val());
			  }
			}
	  }
	function clearfields(){
		  $("#jqxSecurity").jqxGrid('clear');
		  $("#cmbratype").val('');
		  $("#txtagreementvocher").val('');
		
	}
	function getPayTypes() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var cardIdItems  = items[0].split(",");
  				var cardItems = items[1].split(",");
  				var optionscard = '<option value="">--Select--</option>';
  				for (var i = 0; i < cardItems.length; i++) {
  					optionscard += '<option value="' + cardIdItems[i].trim() + '">'
  							+ cardItems[i] + '</option>';
  				}
  				$("select#cmbpaytype").html(optionscard);
  				if ($('#hidcmbpaytype').val() != null) {
  					$('#cmbpaytype').val($('#hidcmbpaytype').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getPayTypes.jsp", true);
  		x.send();
  }
</script>
<style>
/* ------------------------------
    GLOBAL STYLES (MASTER CRV UI)
------------------------------ */

body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 32px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 20px;
    max-width: 100%;
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
    width: 100%;
}

input[type="text"]:focus,
select:focus {
    border-color: #007bff;
    outline: none;
}

label {
    font: 14px Tahoma;
    color: #253858;
    white-space: nowrap;
    line-height: 32px;
    padding: 0px 8px 0px 0px; 
    text-align: right; 
}

/* ------------------------------
    CARD ROWS LAYOUT (MASTER UI)
------------------------------ */

.section-block {
    flex: 1;
    min-width: 0;
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
    border-left: 4px solid #007bff; /* Blue line accent */
}

.section-row {
    display: flex;
    gap: 26px;
    margin-bottom: 20px;
}

.agmt-info-grid {
    display: grid;
    grid-template-columns: auto 1fr auto 1fr auto 1fr; 
    gap: 15px 25px;
    align-items: center;
}

.in-out-info-grid {
    display: grid;
    grid-template-columns: auto 1fr auto 1fr; 
    gap: 12px 16px;
    align-items: center;
}

.input-group {
    display: flex;
    gap: 5px;
    width: 100%;
}

/* SCROLLING FIX */
.hidden-scrollbar {
    overflow-y: visible !important; 
    max-height: none !important; 
    min-height: 1px; 
    padding-right: 5px; 
}

.icon {
    width: 32px;
    height: 32px;
    border: 1px solid #d1d5db;
    background: #fff;
    border-radius: 4px;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
}


</style>
</head>
<style>
/* ------------------------------
    GLOBAL STYLES (MASTER CRV UI)
------------------------------ */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 32px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 20px;
    max-width: 100%;
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
    width: 100%;
}

input[type="text"]:focus, select:focus {
    border-color: #007bff;
    outline: none;
}

label {
    font: 16px Segoe UI;
    font-weight: 500;
    color: #253858;
    white-space: nowrap;
    line-height: 32px;
    padding: 0px 8px 0px 0px; 
}

/* ------------------------------
    CARD ROWS LAYOUT
------------------------------ */
.section-block {
    flex: 1;
    min-width: 0;
    background: #f6f8fa;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.1);
    margin-bottom: 20px;
}

.section-block h2 {
    font-size: 17.6px;
    font-weight: 600;
    margin: 0 0 20px;
    padding-left: 10px;
    border-left: 4px solid #007bff;
    display: flex;
    align-items: center;
    gap: 10px;
}

.section-row {
    display: flex;
    gap: 26px;
    margin-bottom: 20px;
}

.agmt-info-grid {
    display: grid;
    grid-template-columns: auto 1fr auto 1fr; 
    gap: 12px 25px;
    align-items: center;
}

.trans-info-grid {
    display: grid;
    grid-template-columns: auto 1fr auto 1fr auto 1fr;
    gap: 12px 15px;
    align-items: center;
}

.hidden-scrollbar {
    overflow-y: visible !important; 
    max-height: none !important; 
    min-height: 1px; 
    padding: 10px; 
}

.checkbox-group {
    display: flex;
    align-items: center;
    gap: 8px;
}

.icon {
    background: none;
    border: none;
    cursor: pointer;
    padding: 0;
}
/* ===== COMMON PAGE HEADER ALIGNMENT FIX ===== */
#HeadIcons {
    display: flex;
    align-items: center;   /* vertical alignment */
    height: auto;
}

#HeadIcons > label {
    text-align: left;      /* override global label */
    line-height: normal;
    margin: 0;
    padding: 0 8px;
    width: auto;
}
/* ===== FIX HEADER INSIDE TABS ===== */
.tabs {
    height: auto !important;
}

.tabs-header,
.tabs-wrap,
.tabs-panels {
    height: auto !important;
}

.HeadIcons {
    display: flex !important;
    align-items: center !important;
    min-height: 36px;   /* important */
}

.HeadIcons label {
    line-height: normal !important;
    text-align: left !important;
}
body::-webkit-scrollbar {
	width: 0px;
}
.myButton {
 font-weight: 700;
    font-size: 13px;
    width: 130px;
    height: 38px;
    padding: 8px 12px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 2px 4px rgba(59, 130, 246, 0.2);
    text-transform: uppercase;
    letter-spacing: 0.3px;
    white-space: nowrap;
    text-align: center;
}

.myButton:hover {
  background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%);
  box-shadow: 0 4px 6px rgba(59, 130, 246, 0.3);
  transform: translateY(-1px);

</style>

<body onload="setValues();getBranch();getCardTypes();getPayTypes();">

<div id="mainBG" class="homeContent" data-type="background">
    <jsp:include page="../../../../header.jsp"></jsp:include>
    <div style="display:flex; align-items:center; justify-content:space-between; margin-bottom:10px;">

    <div style="display:flex; align-items:center; gap:8px;">
        <label>Date</label>
        <div id="jqxRentalRefundDate" name="jqxRentalRefundDate"
             onchange="datechange();" onblur="datechange();"
             value='<s:property value="jqxRentalRefundDate"/>'
             style="width:120px;"></div>
    </div>

    <div style="display:flex; align-items:center; gap:8px;">
        <label>Doc No.</label>
        <input type="text" id="docno" name="txtrentalrefunddocno"
               value='<s:property value="txtrentalrefunddocno"/>'
               tabindex="-1" style="width:120px;">
    </div>

</div>      
    <br>

    <form id="frmRentalRefund" action="saveRentalRefund" method="post" autocomplete="off">
        <div class="hidden-scrollbar">
            
            <div class="section-block">
                <h2>General Information</h2>
                <div class="trans-info-grid">
                   
                    <label>Doc Type</label>
                    <input type="text" id="txtdoctype" name="txtdoctype" value='<s:property value="txtdoctype"/>' tabindex="-1"/>


                    <label>Receipt No.</label>
                    <input type="text" id="txtsrno" name="txtsrno" value='<s:property value="txtsrno"/>' tabindex="-1"/>
                </div>
            </div>

            <div class="section-row">
                <div class="section-block">
                    <h2>Agreement Details</h2>
                    <div class="agmt-info-grid">
                        <div class="checkbox-group" style="grid-column: span 2;">
                            <input type="checkbox" id="chckib" name="chckib" onclick="funCheck();">
                            <label for="chckib">Inter-Branch</label>
                        </div>

                        <label>Branch</label>
                        <select id="cmbbranch" name="cmbbranch" onchange="funIBDateInPeriod($('#jqxRentalRefundDate').val(),this.value);" value='<s:property value="cmbbranch"/>'>
                            <option value=""></option>
                        </select>

                        <label>Client</label>
                        <div style="display: flex; gap: 8px;">
                            <input type="text" id="txtclientid" name="txtclientid" style="width: 40% !important;" placeholder="F3" value='<s:property value="txtclientid"/>' onkeydown="getClient(event);"/>
                            <input type="text" id="txtclientname" name="txtclientname" value='<s:property value="txtclientname"/>'/>
                        </div>

                        <label>Agreement</label>
                        <div style="display: flex; gap: 8px;">
                            <select id="cmbratype" name="cmbratype" style="width: 40% !important;" value='<s:property value="cmbratype"/>'>
                                <option value="RAG">Rental</option>
                                <option value="LAG">Lease</option>
                            </select>
                            <input type="text" id="txtagreementvocher" name="txtagreementvocher" placeholder="F3" value='<s:property value="txtagreementvocher"/>' onkeydown="getAgreement(event);"/>
                        </div>

                        <label>Paid As</label>
                        <select id="cmbpayedas" name="cmbpayedas" value='<s:property value="cmbpayedas"/>' onchange="applyDisable();">
                            <option value="1">Security</option>
                            <option value="2">On Account</option>
                        </select>
                    </div>
                </div>

                <div class="section-block">
                    <h2>Payment Details</h2>
                    <div class="agmt-info-grid">
                        <label>Pay Type</label>
                        <select id="cmbpaytype" name="cmbpaytype" value='<s:property value="cmbpaytype"/>' onchange="bankAccountSearch();funchequedate();getAccounts(this.value);"></select>

                        <label>Account</label>
                        <div style="display: flex; gap: 8px;">
                            <input type="text" id="txtaccid" name="txtaccid" style="width: 40% !important;" value='<s:property value="txtaccid"/>' onkeydown="getAcc(event);" />
                            <input type="text" id="txtaccname" name="txtaccname" value='<s:property value="txtaccname"/>'/>
                        </div>

                        <label>Card Type</label>
                        <div style="display: flex; gap: 8px; align-items: center;">
                            <button type="button" class="icon" id="btnCardSearch" title="Search Card" onclick="funCardSearch();">
                                <img alt="Search Card" src="<%=contextPath%>/icons/cardsearch.png" height="20">
                            </button>
                            <select id="cmbcardtype" name="cmbcardtype" onchange="funclearchequecardno();" value='<s:property value="cmbcardtype"/>'>
                                <option value="">--Select--</option>
                            </select>
                        </div>

                        <label>Chq/Card/Online No</label>
                        <input type="text" id="txtchequeno" name="txtchequeno" value='<s:property value="txtchequeno"/>'/>

                        <label>Ref. Date</label>
                        <div id="jqxReferenceDate" name="jqxReferenceDate" value='<s:property value="jqxReferenceDate"/>'></div>

                        <label>Description</label>
                        <input type="text" id="txtdescription" name="txtdescription" value='<s:property value="txtdescription"/>'/>
                    </div>
                </div>
            </div>

            <div class="section-block">
                <h2>Security Details</h2>
                <div id="jqxSecurityGrid" style="width: 100%;">
                    <jsp:include page="securityGrid.jsp"></jsp:include>
                </div>
            </div>

            <div class="section-block">
                <h2>Refund Summary</h2>
                <div class="trans-info-grid">
                    <label>Amount</label>
                    <input type="text" id="txtamount" name="txtamount" style="text-align: right;" value='<s:property value="txtamount"/>' onblur="funRoundAmt(this.value,this.id);getNetTotal();"/>
                    
                    <label>Deduction</label>
                    <input type="text" id="txtdeduction" name="txtdeduction" style="text-align: right;" onblur="funRoundAmt(this.value,this.id);getNetTotal();" value='<s:property value="txtdeduction"/>'/>
                    
                    <label>Add. Amount</label>
                    <input type="text" id="txtaddamount" name="txtaddamount" style="text-align: right;" value='<s:property value="txtaddamount"/>' onblur="funRoundAmt(this.value,this.id);getNetTotal();"/>

                    <label>Net Amount</label>
                    <input type="text" id="txtnetamount" name="txtnetamount" style="text-align: right;" value='<s:property value="txtnetamount"/>' tabindex="-1"/>
                    
                    <label>On Acc. Amt</label>
                    <input type="text" id="txtonaccountamount" name="txtonaccountamount" style="text-align: right;" onblur="funRoundAmt(this.value,this.id);" value='<s:property value="txtonaccountamount"/>'/>
                </div>

                <div class="agmt-info-grid" style="margin-top: 15px;">
                    <label>Description</label>
                    <input type="text" id="txtdescriptions" name="txtdescriptions" value='<s:property value="txtdescriptions"/>'/>
                    
                    <label>Paid To</label>
                    <input type="text" id="txtpaidto" name="txtpaidto" value='<s:property value="txtpaidto"/>'/>
                </div>
            </div>

            <input type="hidden" id="hidjqxRentalRefundDate" name="hidjqxRentalRefundDate" value='<s:property value="hidjqxRentalRefundDate"/>'/>
            <input type="hidden" id="hidchckib" name="hidchckib" value='<s:property value="hidchckib"/>'/>
            <input type="hidden" id="hidcmbbranch" name="hidcmbbranch" value='<s:property value="hidcmbbranch"/>'/>
            <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/>
            <input type="hidden" id="txtacno" name="txtacno" value='<s:property value="txtacno"/>'/>
            <input type="hidden" id="hidcmbratype" name="hidcmbratype" value='<s:property value="hidcmbratype"/>'/>
            <input type="hidden" id="txtagreement" name="txtagreement" value='<s:property value="txtagreement"/>'/>
            <input type="hidden" id="hidcmbpayedas" name="hidcmbpayedas" value='<s:property value="hidcmbpayedas"/>'/>
            <input type="hidden" id="txtsecurityacno" name="txtsecurityacno" value='<s:property value="txtsecurityacno"/>'/>
            <input type="hidden" id="hidcmbpaytype" name="hidcmbpaytype" value='<s:property value="hidcmbpaytype"/>'/>
            <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
            <input type="hidden" id="txttranno" name="txttranno" value='<s:property value="txttranno"/>'/>
            <input type="hidden" id="hidcmbcardtype" name="hidcmbcardtype" value='<s:property value="hidcmbcardtype"/>'/>
            <input type="hidden" id="hidjqxReferenceDate" name="hidjqxReferenceDate" value='<s:property value="hidjqxReferenceDate"/>'/>
            <input type="hidden" id="mode" name="mode"/>
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            <input type="hidden" name="txtforsearch" id="txtforsearch" value='<s:property value="txtforsearch"/>'/>
            <div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
            <input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
            <input type="hidden" name="txtvalidation" id="txtvalidation" value='<s:property value="txtvalidation"/>'/>
            <input type="hidden" id="txtibvalidation" name="txtibvalidation" value='<s:property value="txtibvalidation"/>'/>
            <input type="hidden" id="applylength" name="applylength"/>
            <input type="hidden" id="applylengthupdate" name="applylengthupdate"/>
            <input type="hidden" id="cnrdocno" name="cnrdocno" value='<s:property value="cnrdocno"/>'/>
        </div>
    </form>

    <div id="agreementDetailsWindow"><div></div><div></div></div>  
    <div id="clientDetailsWindow"><div></div><div></div></div> 
    <div id="accountDetailsWindow"><div></div><div></div></div>
    <div id="cardDetailsWindow"><div></div><div></div></div> 
    <div id="printWindow"><div></div><div></div></div> 
</div>

</body>
</html>
