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
		 $('#btnExcel').attr('disabled', false );$('#btnDelete').attr('disabled', true );$('#btnAttach').attr('disabled', true );
		 
		 $("#jqxBankReconciliationDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $('#txtforsearch').val(2);
		 
		 $('#accountDetailsFromWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsFromWindow').jqxWindow('close');  
		 
		 $('#jqxBankReconciliationDate').on('change', function (event) {
				var reconciledate = $('#jqxBankReconciliationDate').jqxDateTimeInput('getDate');
				var validdate=funDateInPeriod(reconciledate);
				if(parseInt(validdate)==0){
					document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
					return 0;	
				}
			 });
			 
		$('#txtaccid').dblclick(function(){
			  var date = $('#jqxBankReconciliationDate').jqxDateTimeInput('getDate');
			  $("#maindate").jqxDateTimeInput('val', date);
			  accountSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp?date="+date);
		   	  $('#txtforsearch').val(2);
		   	 $("#jqxBankReconciliation").jqxGrid('clear');
		});	 
		 
	});
	
	function accountSearchContent(url){
	  $('#accountDetailsFromWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsFromWindow').jqxWindow('setContent', data);
		$('#accountDetailsFromWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getBranch() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var branchIdItems  = items[0].split(",");
  				var branchItems = items[1].split(",");
  				var optionsbranch = '<option value="a">ALL</option>';
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
  		x.open("GET", <%=contextPath+"/"%>+"com/finance/posting/getBranch.jsp", true);
  		x.send();
  	}
	
	function getLastReconcileDate(reconcileddate,account){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				 items = items.split('***');
  			     $('#txtchkgridload').val(items[2].trim());
  			     if(parseInt(items[2].trim())>=0){
  			    	  funloadappliedgrid();
  			     } else if(parseInt(items[2].trim())<0) {
					  $.messager.alert('Message','Bank Reconcilation done till '+items[1].trim()+'','warning');
					  $("#jqxBankReconciliation").jqxGrid('clear'); 
			          $("#jqxBankReconciliation").jqxGrid('addrow', null, {});
			          $("#jqxBankReconciliation").jqxGrid({ disabled: true});
					  return;
				 }
  			     
  			   
  		}
		}
		x.open("GET", "getLastReconciledDate.jsp?reconcileddate="+reconcileddate+'&account='+account, true);
		x.send();
	}
	
	function getAcc(event){
	   var x= event.keyCode;
	   if(x==114){
	  	 accountSearchContent(<%=contextPath+"/"%>+"com/finance/accountsDetailsSearch.jsp");
   	     $('#txtforsearch').val(2);
   	     $("#jqxBankReconciliation").jqxGrid('clear');  
	      }
	   }
	   
	function funReadOnly(){
		$('#frmBankReconciliation input').attr('readonly', true );
		$('#frmBankReconciliation select').attr('disabled', true);
		$('#jqxBankReconciliationDate').jqxDateTimeInput({disabled: true});
	    $("#jqxBankReconciliation").jqxGrid({ disabled: true});
		$("#btnSubmit").hide();
	}
	
	function funRemoveReadOnly(){
		$('#txtforsearch').val(2);		
		getBranch();
	    $('#frmBankReconciliation input').attr('readonly', false );
		$('#frmBankReconciliation select').attr('disabled', false);
		$('#jqxBankReconciliationDate').jqxDateTimeInput({disabled: false});
		$('#docno').attr('readonly', true );
		$('#txtaccid').attr('readonly', true );
		$('#txtaccname').attr('readonly', true );
		$('#txtunclrreceipts').attr('readonly', true );
	    $('#txtunclrpayments').attr('readonly', true );
	    $('#txtbookbalance').attr('readonly', true );
	    $('#txtbankbalance').attr('readonly', true );
		$("#jqxBankReconciliation").jqxGrid({ disabled: true});
		$("#btnSubmit").show();
		
		var date = $('#jqxBankReconciliationDate').val();
	    getCurrencyId(date);
	    
		 if ($("#mode").val() == "A") {
			 $('#jqxBankReconciliationDate').val(new Date());
			 document.getElementById("lblformposted").innerText="";
			 $("#jqxBankReconciliation").jqxGrid('clear');
			 $("#jqxBankReconciliation").jqxGrid('addrow', null, {});
		}  
		 
		 if ($("#mode").val() == "E") {
			 $("#jqxBankReconciliation").jqxGrid({ disabled: false});
			  var check = 1;
			  var date=document.getElementById("jqxBankReconciliationDate").value;
			  var accId = document.getElementById("txtdocno").value;
			  var docno = document.getElementById("docno").value;
			  var mode = document.getElementById("mode").value;
			  $("#jqxBankReconciliationGrid").load('bankReconciliationGrid.jsp?accountno='+accId+'&date='+date+'&docno='+docno+'&mode='+mode+'&check='+check); 
		 }
		
	}
	
	function funSearchLoad(){
	    changeContent('brcnMainSearch.jsp'); 
	}
	
	function funChkButton(){
		/* funReset(); */
	}
	
	function funFocus(){
		$('#jqxBankReconciliationDate').jqxDateTimeInput('focus'); 	    		
	}
	
	function funNotify(){	
	 
	  /* Validation */
		var reconciledate = $('#jqxBankReconciliationDate').jqxDateTimeInput('getDate');
		var validdate=funDateInPeriod(reconciledate);
		if(parseInt(validdate)==0){
			document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
			return 0;	
		}
		
		document.getElementById("errormsg").innerText="";
		$('#jqxBankReconciliation').jqxGrid('clearfilters', true);  	
	/* Validation Ends*/
			
		 /*Bank Reconciliation Grid  Saving*/
		 var rows = $("#jqxBankReconciliation").jqxGrid('getrows');
	 		$('#gridlength').val(rows.length);
	 		for(var i=0 ; i < rows.length ; i++){
					newTextBox = $(document.createElement("input"))
				    .attr("type", "dil")
				    .attr("id", "test"+i)
				    .attr("name", "test"+i)
				    .attr("hidden", "true");
				
				var amount;
				if((rows[i].cr!=null) && (rows[i].cr!='undefined') &&  (rows[i].cr!='NaN') && (rows[i].cr!="") && (rows[i].cr!=0)){
					 amount=rows[i].cr;
				}
				if((rows[i].dr!=null) && (rows[i].dr!='undefined') && (rows[i].dr!='NaN') && (rows[i].dr!="") && (rows[i].dr!=0)){
					 amount=rows[i].dr;
				}
					
				newTextBox.val(rows[i].chk+":: "+rows[i].c_date+":: "+amount+":: "+rows[i].tranid+":: "+rows[i].date+":: "+rows[i].doc_no+":: "+rows[i].dtype+":: "+rows[i].chqno+":: "+rows[i].chqdt+":: "+rows[i].dr+":: "+rows[i].cr+":: "+rows[i].ref_detail+":: "+rows[i].description+":: "+rows[i].party);
				newTextBox.appendTo('form');
				
				} 
	 		   /*Bank Reconciliation Grid  Saving Ends*/	
	 		   
	 		   $('#jqxBankReconciliationDate').jqxDateTimeInput({disabled: false});
		   	   $('#cmbbranch').attr('disabled', false);
		  	   $('#cmbcurrency').attr('disabled', false);
	 		   
			return 1;
	} 
	
	
	function setValues(){
		var date = $('#jqxBankReconciliationDate').val();
	    getCurrencyId(date);getBranch();
		
		if($('#hidjqxBankReconciliationDate').val()){
			 $("#jqxBankReconciliationDate").jqxDateTimeInput('val', $('#hidjqxBankReconciliationDate').val());
		  }
	 
		if($('#hidmaindate').val()){
			 $("#maindate").jqxDateTimeInput('val', $('#hidmaindate').val());
		  }
		
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		 
		 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		 funSetlabel();
		 
		  if(document.getElementById("lblformposted").innerText.trim()!=""){
			    $('#btnEdit').attr('disabled', true );
		  } else {
			    $('#btnEdit').attr('disabled', false );
		  }
		 
		 var accId = document.getElementById("txtdocno").value;
		 if(accId>0){
			 funloadappliedgrid();
		 }
		 funRoundAmt($('#txtbookbalance').val(),"txtbookbalance");
         funRoundAmt($('#txtunclrpayments').val(),"txtunclrpayments");
	     funRoundAmt($('#txtunclrreceipts').val(),"txtunclrreceipts");
	     funRoundAmt($('#txtbankbalance').val(),"txtbankbalance"); 
	}
	
	function funloadappliedgrid(){

		$("#jqxBankReconciliation").jqxGrid({ disabled: false});
		  var date=document.getElementById("jqxBankReconciliationDate").value;
		  var accId = document.getElementById("txtdocno").value;
		  var docno = document.getElementById("docno").value;
		  var mode = document.getElementById("mode").value;
		  var brch = document.getElementById("cmbbranch").value;
		  var check = 1;
		  
		  $("#overlay, #PleaseWait").show();
		  
		  $("#jqxBankReconciliationGrid").load('bankReconciliationGrid.jsp?accountno='+accId+'&date='+date+'&docno='+docno+'&mode='+mode+'&check='+check+'&brch='+brch); 
	}
	
	function funExcelBtn(){
		 JSONToCSVCon(dataExcelExport, 'Bank Reconciliation', true);
	 }
	function funPrintBtn() {

	    if ($("#mode").val() !== "view" || $("#docno").val() === "") {
	        $.messager.alert('Message','Select a Document....!','warning');
	        return;
	    }

	    var baseUrl = document.URL.split("saveBankReconciliation")[0];

	    $.messager.confirm('Confirm', 'Do you want to have header?', function (r) {

	        var printUrl =
	            baseUrl +
	            "printBankReconciliation" +
	            "?docno=" + $("#docno").val() +
	            "&branch=" + $("#brchName").val() +
	            "&header=" + (r ? 1 : 0);

	        openAndPrint(printUrl);
	    });
	}
	
	 function openAndPrint(url) {

 	    var win = window.open(
 	        url,
 	        "_blank",
 	        "top=150,left=250,width=1020,height=600,scrollbars=yes"
 	    );

 	    if (win) {
 	        setTimeout(function () {
 	            win.focus();
 	            win.print();
 	            win.onafterprint = function () {
 	                win.close();
 	            };
 	        }, 700);
 	    } else {
 	        $.messager.alert('Message','Popup blocked by browser','warning');
 	    }
 	}

	
	function datechange(){
		  var date = $('#jqxBankReconciliationDate').jqxDateTimeInput('getDate');
		  $("#maindate").jqxDateTimeInput('val', date);
		  $("#jqxBankReconciliation").jqxGrid('clear'); 
          $("#jqxBankReconciliation").jqxGrid('addrow', null, {});
          $("#jqxBankReconciliation").jqxGrid({ disabled: true});
          $('#txtbookbalance').val('');$('#txtunclrpayments').val('');$('#txtunclrreceipts').val('');$('#txtbankbalance').val('');
		  
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
    min-height: 100vh;
    box-sizing: border-box;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 20px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

.section-block {
    background: #f6f8fa;
    border-radius: 10px;
    padding: 20px 18px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.05);
    margin-bottom: 24px;
}

.section-block h2 {
    font-size: 17.6px;
    font-weight: 600;
    margin: 0 0 16px 0;
    padding-left: 10px;
    border-left: 4px solid #007bff;
    color: #253858;
    display: flex;
    align-items: center;
}

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

.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #fff;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 0 0 1px #eef0f6;
}

.cr-table td {
    padding: 10px;
    border-bottom: 1px solid #e4e7ec;
    font-size: 16px;
    color: #333;
}

.cr-table td[align="right"] {
    font-weight: 600;
    color: #253858;
    white-space: nowrap;
}

.hidden-scrollbar {
    overflow: auto;
    height: 530px;
}

/* Custom button alignment */
.btn-container {
    display: flex;
    justify-content: flex-end;
    margin-top: 10px;
}
</style>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmBankReconciliation" action="saveBankReconciliation" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div class='hidden-scrollbar'>
    
    <div class="section-block">
        <h2>Reconciliation Header</h2>
        <table class="cr-table">
          <tr>
            <td width="8%" align="right">Date</td>
            <td width="15%">
                <div id="jqxBankReconciliationDate" name="jqxBankReconciliationDate" onchange="datechange();" value='<s:property value="jqxBankReconciliationDate"/>'></div>
            </td>
            <td width="8%" align="right">Branch</td>
            <td width="18%">
                <select id="cmbbranch" name="cmbbranch" value='<s:property value="cmbbranch"/>'>
                    <option></option>
                </select>
            </td>
            <td width="8%" align="right">Currency</td>
            <td width="18%">
                <select id="cmbcurrency" name="cmbcurrency" value='<s:property value="cmbcurrency"/>' onload="getRatevalue(this.value);">
                    <option></option>
                </select>
            </td>
            <td width="8%" align="right">Doc No</td>
            <td width="17%">
                <input type="text" id="docno" name="txtbankreconciliationdocno" value='<s:property value="txtbankreconciliationdocno"/>' tabindex="-1"/>
            </td>
          </tr>
          <tr>
            <td align="right">Account</td>
            <td>
                <input type="text" id="txtaccid" name="txtaccid" placeholder="F3 for Search" value='<s:property value="txtaccid"/>' onkeydown="getAcc(event);"/>
            </td>
            <td colspan="2">
                <input type="text" id="txtaccname" name="txtaccname" value='<s:property value="txtaccname"/>'/>
            </td>
            <td align="right">Description</td>
            <td colspan="2">
                <input type="text" id="txtdescription" name="txtdescription" value='<s:property value="txtdescription"/>'/>
            </td>
            <td align="center">
                <button class="myButton" type="button" id="btnSubmit" name="btnSubmit" onclick="getLastReconcileDate($('#jqxBankReconciliationDate').val(),$('#txtdocno').val());">Submit</button>
            </td>
          </tr>
        </table>
    </div>

    <div class="section-block">
        <h2>Applying Invoices</h2>
        <div id="jqxBankReconciliationGrid">
            <jsp:include page="bankReconciliationGrid.jsp"></jsp:include>
        </div>
    </div>

    <div class="section-block">
        <h2>Balance Summary</h2>
        <table class="cr-table">
          <tr>
            <td width="12%" align="right">Book Balance</td>
            <td><input type="text" id="txtbookbalance" name="txtbookbalance" style="text-align: right;" value='<s:property value="txtbookbalance"/>' tabindex="-1" onblur="funRoundAmt(this.value,this.id);" /></td>
            
            <td width="15%" align="right">Uncleared Payments</td>
            <td><input type="text" id="txtunclrpayments" name="txtunclrpayments" style="text-align: right;" value='<s:property value="txtunclrpayments"/>' tabindex="-1" onblur="funRoundAmt(this.value,this.id);"/></td>
            
            <td width="15%" align="right">Uncleared Receipts</td>
            <td><input type="text" id="txtunclrreceipts" name="txtunclrreceipts" style="text-align: right;" value='<s:property value="txtunclrreceipts"/>' tabindex="-1" onblur="funRoundAmt(this.value,this.id);"/></td>
            
            <td width="12%" align="right">Bank St. Balance</td>
            <td><input type="text" id="txtbankbalance" name="txtbankbalance" style="text-align: right;" value='<s:property value="txtbankbalance"/>' tabindex="-1" onblur="funRoundAmt(this.value,this.id);"/></td>
          </tr>
        </table>
    </div>

    <input type="hidden" id="hidjqxBankReconciliationDate" name="hidjqxBankReconciliationDate" value='<s:property value="hidjqxBankReconciliationDate"/>'/>
    <input type="hidden" id="hidcmbbranch" name="hidcmbbranch" value='<s:property value="hidcmbbranch"/>'/>
    <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency" value='<s:property value="hidcmbcurrency"/>'/>
    <input type="hidden" id="hidcurrencytype" name="hidcurrencytype" value='<s:property value="hidcurrencytype"/>'/>
    <input type="hidden" id="txtrate" name="txtrate" value='<s:property value="txtrate"/>'/>
    <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
    <input type="hidden" id="mode" name="mode"/>
    <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
    <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
    <input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
    <input type="hidden" name="txtforsearch" id="txtforsearch" value='<s:property value="txtforsearch"/>'>
    <input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
    <input type="hidden" id="gridlength" name="gridlength"/>
    <input type="hidden" name="txtchkgridload" id="txtchkgridload" value='<s:property value="txtchkgridload"/>'>
    <div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
    <div style="display:none">
        <label id="lblformposted" name="lblformposted"><s:property value="lblformposted"/></label>
    </div>

</div>
</form>
    
<div id="accountDetailsFromWindow">
    <div></div><div></div>
</div>  

</div>
</body>
</html>