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
		 $('#btnClose').attr('disabled', true );$('#btnCreate').attr('disabled', true );$('#btnEdit').attr('disabled', true );$('#btnPrint').attr('disabled', true );
		 $('#btnExcel').attr('disabled', true );$('#btnDelete').attr('disabled', true );$('#btnSearch').attr('disabled', true );$('#btnAttach').attr('disabled', true );

		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
		 $("#jqxApplyInvoicing").jqxGrid({ disabled: true});
		 $("#jqxAppliedInvoicing").jqxGrid({ disabled: true});
		 
		 $('#accountDetailsToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsToWindow').jqxWindow('close');  
		 
		 $('#cashPaymentGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#cashPaymentGridWindow').jqxWindow('close');
		 
		 $('#txtaccid').dblclick(function(){
			  var date = $('#maindate').jqxDateTimeInput('getDate');
			  accountSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbacctype').val()+"&date="+date);
			  $('#txtforsearch').val(3); 
		     });
		 
	});
	
	function accountSearchContent(url){
	   $('#accountDetailsToWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsToWindow').jqxWindow('setContent', data);
		$('#accountDetailsToWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getAcc(event){
	    var x= event.keyCode;
	    if(x==114){
	    	  var date = $('#maindate').jqxDateTimeInput('getDate');
	    	  accountSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbacctype').val()+"&date="+date);
			  $('#txtforsearch').val(3);
	       }
	    }
	    
	function funReadOnly(){} 
	
	function funRemoveReadOnly(){}
	
	function funSearchLoad(){}
	
	function funChkButton(){
		/* funReset(); */
	}
	
	function funFocus(){
		document.getElementById("cmbacctype").focus(); 	    		
	}
	
	function funNotify(){	
		$("#jqxApplyInvoicing").jqxGrid('clearfilters');
	  /* Validation */
		 valid=document.getElementById("txtvalidation").value;
		 if(valid==1){
			 document.getElementById("errormsg").innerText="Invalid Outstanding Amount !!!";
			 return 0;
		 }
		 
		    var rows1 = $("#jqxApplyInvoicing").jqxGrid('getrows');
		    var appliedamount=0.00;
		    var applyinvoiceamt=0.00;
		    for(var i=0 ; i < rows1.length ; i++){
				if(rows1[0].balance<0){
					document.getElementById("errormsg").innerText="Invalid Outstanding Amount !!!";
					return 0;
				}
				
                                   if(typeof(rows1[i].applying) != "undefined" && typeof(rows1[i].applying) != "NaN" && rows1[i].applying != ""){
				appliedamount=parseFloat(appliedamount)+parseFloat(rows1[i].applying);
}
		    } 
		    applyinvoiceamt=document.getElementById("txtapplyinvoiceamt").value;
		   // alert(applyinvoiceamt+"=="+appliedamount)
		// if(parseFloat(appliedamount).toFixed(2)<parseFloat(applyinvoiceamt).toFixed(2)){
			if(parseFloat(document.getElementById("txtapplyinvoiceamt").value)<parseFloat(appliedamount).toFixed(window.parent.document.getElementById("amtdec").value)){
		    	document.getElementById("errormsg").innerText="Limit Already Reached,Invalid Outstanding Amount !!!";
				return 0;
		    }
		    
		    if(parseFloat(document.getElementById("txtapplyinvoicebalance").value)<0){
		    	document.getElementById("errormsg").innerText="Limit Already Reached,Invalid Outstanding Amount !!!";
				return 0;
		    }
		    
		    document.getElementById("errormsg").innerText="";
			
	   /* Validation Ends*/
			
		 /* Applying Invoice Grid Saving */
			var rows = $("#jqxApplyInvoicing").jqxGrid('getrows');
			var lengthapply=0;
			for(var i=0 ; i < rows.length ; i++){
				    var chks=rows[i].applying;
	  				if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != ""){
				 	newTextBox = $(document.createElement("input"))
				    .attr("type", "dil")
				    .attr("id", "test"+lengthapply)
				    .attr("name", "test"+lengthapply)
				    .attr("hidden", "true");
				 	lengthapply=lengthapply+1;
				 	
				newTextBox.val(rows[i].applying+"::"+parseFloat(rows[i].out_amount+rows[i].applying)+"::"+rows[i].currency+"::"+rows[i].tranid+"::"+rows[i].acno);
				newTextBox.appendTo('form');
				}
			}
			$('#gridlength').val(lengthapply);
			 /* Applying Invoice Grid Saving Ends*/
			 
			return 1;
	} 
	
	
	function setValues(){
	  
	  document.getElementById("cmbacctype").value=document.getElementById("hidcmbacctype").value;
	  
	  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	  funSetlabel();
	  
	  if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
      
      var accId = document.getElementById("txtdocno").value;
      if(accId!=0){
    	  funloadappliedgrid();
      }
      
      funRoundAmt($('#txtapplyinvoiceamt').val(),"txtapplyinvoiceamt");
	  funRoundAmt($('#txtapplyinvoiceapply').val(),"txtapplyinvoiceapply");
	  funRoundAmt($('#txtapplyinvoicebalance').val(),"txtapplyinvoicebalance");  
	}
	
	function funloadappliedgrid(){
		  $('#mode').val("A");
		  $('#txtgriddocno').val('');$('#txtdoctype').val('');$('#txtapplyinvoiceamt').val('');$('#txtapplyinvoiceapply').val('');$('#txtapplyinvoicebalance').val('');
		  
		  $("#jqxApplyInvoicing").jqxGrid('clear');
		  $("#jqxApplyInvoicing").jqxGrid('addrow', null, {});
		  
		  $("#jqxApplyInvoicing").jqxGrid({ disabled: true});
	      $("#jqxAppliedInvoicing").jqxGrid({ disabled: false});
			 
		  $("#jqxAppliedInvoicing").jqxGrid({ disabled: false});
		  var accId = document.getElementById("txtdocno").value;
		  var accType = document.getElementById("cmbacctype").value;
		  var check = 1;
		  
		  $("#overlay, #PleaseWait").show();
		  
	      $("#jqxManualAppliedGrid").load('appliedInvoicingGrid.jsp?accountno='+accId+'&accType='+accType+'&check='+check);
	}
	
	function funUpdateChanges(){
		$('#btnSave').mousedown();
	}
	
	function clearAccountInfo(){
		$('#txtdocno').val('');$('#txtaccid').val('');$('#txtaccname').val('');	
		if (document.getElementById("txtaccid").value == "") {
	        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
	    }
	}

</script>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmManualApplying" action="saveManualApplying" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div  class='hidden-scrollbar'>


<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" name="txtforsearch" id="txtforsearch" value='<s:property value="txtforsearch"/>'>
<input type="hidden" id="txttranid" name="txttranid" value='<s:property value="txttranid"/>'/>
<input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
<input type="hidden" id="txtoutamount" name="txtoutamount" value='<s:property value="txtoutamount"/>'/>
<input type="hidden" id="txtacno" name="txtacno" value='<s:property value="txtacno"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
<div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
</div>
</form>
	
<div id="cashPaymentGridWindow">
	<div></div><div></div>
</div>  
				
<div id="accountDetailsToWindow">
	<div></div><div></div>
</div>  
	
</div>
</body>
</html>