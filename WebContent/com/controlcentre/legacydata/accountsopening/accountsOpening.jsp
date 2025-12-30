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
		 
		$('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#accountDetailsWindow').jqxWindow('close');
		
		 $('#openingBalanceGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#openingBalanceGridWindow').jqxWindow('close');
		 
		 $('#txtaccid').dblclick(function(){
			  accountSearchContent("clientAccountDetailsSearch.jsp?atype="+$('#cmbacctype').val());
	     });
	});
	
	function accountSearchContent(url) {
	 	$('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function OpeningSearchContent(url) {
		$('#openingBalanceGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#openingBalanceGridWindow').jqxWindow('setContent', data);
		$('#openingBalanceGridWindow').jqxWindow('bringToFront');
	}); 
	} 

	function getAcc(event){
	    var x= event.keyCode;
	    if(x==114){
	    	accountSearchContent("clientAccountDetailsSearch.jsp?atype="+$('#cmbacctype').val());
	       }
	    }
	
	function funExcelBtn() {
		  if ($("#mode").val() == "view") {
		  	 if(parseInt(window.parent.chkexportdata.value)=="1") {
			  	JSONToCSVCon(data1, 'AccountsOpening', true);
			 } else {
				 $("#jqxAppliedAccounts").jqxGrid('exportdata', 'xls', 'AccountsOpening');
			 }
		  }
	  }
	  
	function funReadOnly(){
		$('#frmAccountsOpening input').attr('readonly', true );
		$('#frmAccountsOpening select').attr('disabled', true);
		//$('#jqxAccountOpeningDate').jqxDateTimeInput({disabled: true});
	 	$("#jqxAppliedAccounts").jqxGrid({ disabled: true});
	}

	function funRemoveReadOnly(){
	    $('#frmAccountsOpening input').attr('readonly', false );
		$('#frmAccountsOpening select').attr('disabled', false);
		//$('#jqxAccountOpeningDate').jqxDateTimeInput({disabled: false});
		$('#txtaccountcurrency').attr('readonly', true );
		$('#txtaccid').attr('readonly', true );
		$('#txtaccname').attr('readonly', true );
	    $('#txtdebittotal').attr('readonly', true );
	    $('#txtcredittotal').attr('readonly', true );
	    $('#txtnettotal').attr('readonly', true );
		$("#jqxAppliedAccounts").jqxGrid({ disabled: false});
		
		 if ($("#mode").val() == "A") {
			 $("#jqxAppliedAccounts").jqxGrid('clear');
			 $("#jqxAppliedAccounts").jqxGrid('addrow', null, {});
		}  
		
	}

	function funSearchLoad(){
	 	 changeContent('opnMainSearch.jsp', $('#window'));  
	}

	function funChkButton(){
		/* funReset(); */
	}

	function funFocus(){
		//$('#jqxAccountOpeningDate').jqxDateTimeInput('focus'); 
		document.getElementById("cmbacctype").focus();
	}

	function funNotify(){	
	  
	   /* Validation */
		 valid=document.getElementById("txtvalidation").value;
		 if(valid==1){
			 document.getElementById("errormsg").innerText="Invalid Transaction !!!";
			 return 0;
		 } 
		document.getElementById("errormsg").innerText="";
	  /* Validation Ends*/
			
	/* Accounts Invoice Grid Saving */
   	 var rows = $("#jqxAppliedAccounts").jqxGrid('getrows');
   	 var length=0;
		 for(var i=0 ; i < rows.length ; i++){
			var chk=rows[i].doc_no;
			var chks=rows[i].baseamount;
		//	alert(chk+"===="+chks);
			if(typeof(chk) == "undefined" && (typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != "")){
				document.getElementById("errormsg").innerText="Doc No is Mandatory.";
				return 0;
			}
			document.getElementById("errormsg").innerText="";
			// alert(typeof(chk));
			if(typeof(chk) == "number" || chk!=""){
				length=length+1;
				newTextBox = $(document.createElement("input"))
			    .attr("type", "dil")
			    .attr("id", "test"+i)
			    .attr("name", "test"+i)
				.attr("hidden", "true");
				
			var amount=0,baseamount=0,id;
			if((rows[i].credit!=null) && (rows[i].credit!='undefined') &&  (rows[i].credit!='NaN') && (rows[i].credit!="") && (rows[i].credit!=0)){
				 amount=rows[i].credit*-1;
				 baseamount=rows[i].baseamount*-1;
				 id=-1;
				
			}
			if((rows[i].debit!=null) && (rows[i].debit!='undefined') && (rows[i].debit!='NaN') && (rows[i].debit!="") && (rows[i].debit!=0)){
				 amount=rows[i].debit;
				 baseamount=rows[i].baseamount;
				 id=1;
			}
			
			newTextBox.val(rows[i].doc_no+"::"+rows[i].date+":: "+rows[i].description+":: "+amount+":: "+baseamount+":: "+id+":: "+rows[i].tr_no);
			newTextBox.appendTo('form');
			}
		 }
		 $('#gridlength').val(length);
		/* Accounts Invoice Grid Saving Ends */
			 
			return 1;
	} 


	function setValues(){
	  
	  document.getElementById("cmbacctype").value=document.getElementById("hidcmbacctype").value;
	  
	  if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
	  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	  funSetlabel(); 
		
	  var indexVal = document.getElementById("txttrno").value;
	  if(indexVal>0){
      $("#jqxAppliedAccountsGrid").load("accountsInvoiceGrid.jsp?txttrno2="+indexVal); 
		 }
	}
	
	function clearAccountInfo(){
		$('#txtdocno').val('');$('#txtaccid').val('');$('#txtaccname').val('');$('#txtaccountcurrency').val('');$('#txtaccountcurrencyid').val('');$('#txtrate').val('');
		$('#hidcurrencytype').val('');$('#txtdebittotal').val('');$('#txtcredittotal').val('');$('#txtnettotal').val('');$('#txtbaseamount').val('');$('#txtvalidation').val('');
		$("#jqxAppliedAccounts").jqxGrid('clear'); 
		$("#jqxAppliedAccounts").jqxGrid('addrow', null, {});
	} 

</script>

<style>


.hidden-scrollbar {
    overflow: auto;
    height: 530px;
}


body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 32px 0;
    min-height: 100vh;
    box-sizing: border-box; [web:29]
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 20px;
    max-width: 100%;
    margin: auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
    text-align: left !important;
}

/* Header include alignment */
.receipt-header {
    display: block;
    padding: 0 0 0 5px;
}


.section-block {
    background: #f6f8fa;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.1);
    margin-bottom: 18px;
}

.section-title {
    font-size: 1.1rem;
    font-weight: 600;
    margin: 0 0 16px;
    padding-left: 10px;
    border-left: 4px solid #007bff;
    color: #333;
}

.section-row {
    display: flex;
    flex-wrap: wrap;
    gap: 18px 26px;
}

/* Each label + control block */
.form-group {
    display: grid;
    grid-template-columns: 120px 260px; /* 120 label + fixed 260 input */
    align-items: center;
    gap: 10px;
    margin-bottom: 6px;
    min-width: 320px;
}


.form-group label {
    font-family: Tahoma, 'Segoe UI', sans-serif;
    font-weight: 600;
    color: #253858;
    white-space: nowrap;
    text-align: right;
    padding-right: 10px;
    font-size: 16px;
}


.form-group input[type="text"],
.form-group select {
    height: 32px !important;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    background: #fff;
    transition: border-color 0.2s;
    font-size: 14px;
    box-sizing: border-box;
    width: 260px; /* consistent width for all inputs */
}


input[type="text"],
select {
    height: 32px !important;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    background: #fff;
    font-size: 14px;
    box-sizing: border-box;
}

input[type="text"]:focus,
select:focus {
    border-color: #007bff;
    outline: none;
}


input[readonly],
input[tabindex="-1"] {
    background-color: #f3f4f6;
    color: #6b7280;
}


.section-block.totals-block .form-group input[type="text"] {
    height: 32px !important;
    font-size: 14px;
    font-weight: 600;
    text-align: right;
}


#jqxAppliedAccountsGrid {
    border: 1px solid #e4e7ec;
    border-radius: 10px;
    overflow: hidden;
    background: #fff;
}

#jqxAppliedAccountsGrid .jqx-grid-header {
    background: #f1f4f9;
    border-bottom: 1px solid #dbe1ea;
}

#jqxAppliedAccountsGrid .jqx-grid-column-header {
    font-size: 14px;
    font-weight: 600;
    color: #354B6A;
    padding: 8px 6px;
}

#jqxAppliedAccountsGrid .jqx-grid-cell {
    font-size: 14px;
    padding: 7px 6px;
    border-bottom: 1px solid #e4e7ec;
}

#jqxAppliedAccountsGrid .jqx-grid-cell-selected {
    background-color: #e8f0ff !important;
}


.hidden-scrollbar { 
    overflow: auto; 
    height: 530px; 
    padding: 0;
}
.hidden-scrollbar::-webkit-scrollbar { width: 0px; }


</style>


</head>
<body onload="setValues();">

<div id="mainBG" class="homeContent">

<form id="frmAccountsOpening" action="saveAccountsOpening" method="post" autocomplete="off">

    <jsp:include page="../../../../header.jsp"></jsp:include>

    <!-- ================= ACCOUNT DETAILS ================= -->
    <div class="section-block">

        <div class="section-title">Account Details</div>

        <div class="section-row">

            <div class="form-group">
                <label>Account</label>
                <select id="cmbacctype" name="cmbacctype" onchange="clearAccountInfo();">
                    <option value="BANK">Bank</option>
                    <option value="GL">GL</option>
                    <option value="AR">AR</option>
                    <option value="AP">AP</option>
                    <option value="HR">HR</option>
                </select>
                <input type="hidden" id="hidcmbacctype" name="hidcmbacctype"
                       value='<s:property value="hidcmbacctype"/>'/>
            </div>

            <div class="form-group">
                <label>Account ID</label>
                <input type="text" id="txtaccid" name="txtaccid"
                       placeholder="Press F3 to Search"
                       value='<s:property value="txtaccid"/>' 
                       onkeydown="getAcc(event);"/>
            </div>

            <div class="form-group">
                <label>Account Name</label>
                <input type="text" id="txtaccname" name="txtaccname"
                       tabindex="-1"
                       value='<s:property value="txtaccname"/>'/>
                <input type="hidden" id="txtdocno" name="txtdocno"
                       value='<s:property value="txtdocno"/>'/>
            </div>

            <div class="form-group">
                <label>Currency</label>
                <input type="text" id="txtaccountcurrency" name="txtaccountcurrency"
                       readonly
                       value='<s:property value="txtaccountcurrency"/>'/>
                <input type="hidden" id="txtaccountcurrencyid" name="txtaccountcurrencyid"
                       value='<s:property value="txtaccountcurrencyid"/>'/>
                <input type="hidden" id="hidcurrencytype" name="hidcurrencytype"
                       value='<s:property value="hidcurrencytype"/>'/>
            </div>

            <div class="form-group">
                <label>Rate</label>
                <input type="text" id="txtrate" name="txtrate"
                       style="text-align:right;"
                       value='<s:property value="txtrate"/>'/>
            </div>

        </div>
    </div>

    <!-- ================= OPENING DETAILS GRID ================= -->
    <div class="section-block">

        <div class="section-title">Opening Invoice / Cheque / Other Details</div>

        <div id="jqxAppliedAccountsGrid">
            <jsp:include page="accountsInvoiceGrid.jsp"></jsp:include>
        </div>

    </div>

    <!-- ================= TOTALS ================= -->
    <div class="section-block totals-block">

        <div class="section-title">Totals</div>

        <div class="section-row">

            <div class="form-group">
                <label>Debit Total</label>
                <input type="text" id="txtdebittotal" name="txtdebittotal"
                       tabindex="-1"
                       style="text-align:right;"
                       value='<s:property value="txtdebittotal"/>'/>
                <input type="hidden" id="txtvalidation" name="txtvalidation"
                       value='<s:property value="txtvalidation"/>'/>
            </div>

            <div class="form-group">
                <label>Credit Total</label>
                <input type="text" id="txtcredittotal" name="txtcredittotal"
                       tabindex="-1"
                       style="text-align:right;"
                       value='<s:property value="txtcredittotal"/>'/>
            </div>

            <div class="form-group">
                <label>Net Total</label>
                <input type="text" id="txtnettotal" name="txtnettotal"
                       tabindex="-1"
                       style="text-align:right;"
                       value='<s:property value="txtnettotal"/>'/>
            </div>

            <div class="form-group">
                <label>Base Amount</label>
                <input type="text" id="txtbaseamount" name="txtbaseamount"
                       tabindex="-1"
                       style="text-align:right;"
                       value='<s:property value="txtbaseamount"/>'/>
            </div>

        </div>
    </div>

    <!-- ================= HIDDEN FIELDS ================= -->
    <input type="hidden" id="mode" name="mode"/>
    <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
    <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
    <input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
    <input type="hidden" id="gridlength" name="gridlength"/>
    <input type="hidden" id="applylength" name="applylength"/>
    <input type="hidden" id="applylengthupdate" name="applylengthupdate"/>

</form>

<!-- ================= POPUP WINDOWS ================= -->
<div id="accountDetailsWindow"><div></div><div></div></div>
<div id="openingBalanceGridWindow"><div></div><div></div></div>

</div>

</body>

</html>