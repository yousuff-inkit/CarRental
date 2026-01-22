<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

<style type="text/css">

/* ===== MASTER LAYOUT ===== */
.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', Tahoma, sans-serif;
    background-color: #f4f7f9;
}

/* Sidebar */
.sidebar-filters {
    width: 330px;
    flex: 0 0 330px;
    background: #fff;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100vh;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
}

.sidebar-fixed-top {
    padding: 15px 20px;
    border-bottom: 1px solid #f0f4f8;
}

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 20px 25px;
}

/* Cards */
.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

/* Tables */
.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 13px;
    font-weight: 600;
    color: #4e5e71;
    width: 90px;
}

/* Inputs */
input[type="text"], select {
    width: 100%;
    padding: 7px 10px;
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    font-size: 13px;
}

/* Buttons */
.btn-submit {
    width: 100%;
    padding: 11px;
    margin-top: 10px;
    background: #2563eb;
    color: #fff;
    border: none;
    border-radius: 6px;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
}

.btn-submit:hover {
    background: #1d4ed8;
}

/* Page height fix */
html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
}

td[width="80%"] {
    height: 100vh;
    vertical-align: top;
    background: #fff;
}
/* ===== FIX LEFT PANEL SCROLL ISSUE ===== */

/* Allow page to calculate height correctly */
html, body {
    height: 100%;
}

/* Main container must not block scrolling */
#mainBG {
    height: 100%;
}

/* Left sidebar container */
.scrollable-left {
    max-height: calc(100vh - 90px); /* adjust if header height differs */
    overflow-y: auto;
    overflow-x: hidden;
    padding-right: 6px; /* avoids scrollbar overlap */
}

/* Smooth scrollbar (optional but nice) */
.scrollable-left::-webkit-scrollbar {
    width: 6px;
}

.scrollable-left::-webkit-scrollbar-thumb {
    background-color: #cbd5e1;
    border-radius: 4px;
}

.scrollable-left::-webkit-scrollbar-track {
    background: transparent;
}

</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#chqdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 $('#branchSearchWindow').jqxWindow({width: '20%', height: '58%',  maxHeight: '60%' ,maxWidth: '30%' , title: 'Branch Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#branchSearchWindow').jqxWindow('close');
		 
		 $('#cardDetailsWindow').jqxWindow({width: '30%', height: '58%',  maxHeight: '70%' ,maxWidth: '30%' , title: 'Card Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#cardDetailsWindow').jqxWindow('close');
		 
		  $('#agmtDetailsWindow').jqxWindow({width: '30%', height: '58%',  maxHeight: '70%' ,maxWidth: '30%' , title: 'Agreement Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#agmtDetailsWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
	     document.getElementById("hidchckibbranch").value=0;
	     
	     $('#txtclientaccount').dblclick(function(){
			  accountsSearchContent('clientDetailsSearch.jsp');
			  });
		  
		  $('#txttypeaccid').dblclick(function(){
			  accountsSearchContent('accountsDetailsSearch.jsp');
			  });
		  
		  $('#txtibbranch').dblclick(function(){
			  branchSearchContent('branchSearchGrid.jsp?check=1');
			  });
		  
	     $('#cmbtype').attr('disabled', true );$('#txttypeaccid').attr('readonly', true );$('#txttypeaccid').attr('readonly', true );
	     $('#txtchequeno').attr('readonly', true );$('#txtremarks').attr('readonly', true );$('#txtibbranch').attr('disabled', true );
	     $('#btnRefund').attr('disabled', true );$('#btnRelease').attr('disabled', true );$('#date').jqxDateTimeInput({disabled: true});
	     $('#chqdate').jqxDateTimeInput({disabled: true});$('#cmbcardtype').attr('disabled', true );$('#btnCardSearch').attr('disabled', true);
	     
	});
	
	function accountsSearchContent(url) {
	    $('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function branchSearchContent(url) {
		$('#branchSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#branchSearchWindow').jqxWindow('setContent', data);
		$('#branchSearchWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function cardSearchContent(url) {
	 	$('#cardDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#cardDetailsWindow').jqxWindow('setContent', data);
		$('#cardDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	function agmtSearchContent(url) {
	 	$('#agmtDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#agmtDetailsWindow').jqxWindow('setContent', data);
		$('#agmtDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	function funChangeAgreement(){
     var doc= $('#txtclientdocno').val();
		agmtSearchContent('agmtsearchGrid.jsp?cldoc='+doc);
	}
	
	
	function isNumber(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
         {
          $.messager.alert('Message',' Enter Numbers Only ','warning');    
            return false;
         }
        return true;
    }
	
	function getAccounts(a,b){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var docNoItems = items[0];
  				var accountIdItems  = items[1];
  				var accountItems = items[2];
  				var accountTypeItems = items[3];
  				var accountCurIdItems  = items[4];
  				var accountRateItems = items[5];
  				var accCurrTypeItems = items[6];
  				var payTypeItems = items[7];
  				
  			/*  if(parseInt(payTypeItems)==1 || parseInt(payTypeItems)==3){ */  // commented
  			    $('#txttypedocno').val(docNoItems);	
  			    $('#txttypeaccid').val(accountIdItems);
  			    $('#txttypeaccname').val(accountItems);
  			  	$('#txttypeatype').val(accountTypeItems);
			    $('#txttypecurid').val(accountCurIdItems);
			    $('#txttyperate').val(accountRateItems);
			    $('#txttypetype').val(accCurrTypeItems);
  			 /* } */
  		}
  		}
  		x.open("GET", "getAccounts.jsp?paytype="+a+"&date="+b, true);
  		x.send();
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
  				$("select#cmbtype").html(optionscard);
  				if ($('#hidcmbtype').val() != null) {
  					$('#cmbtype').val($('#hidcmbtype').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getPayTypes.jsp", true);
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
	
	function getClient(event){
      var x= event.keyCode;
      if(x==114){
    	  accountsSearchContent('clientDetailsSearch.jsp');
      }
      else{
       }
      }
	
	function getAccType(event){
        var x= event.keyCode;
        if(x==114){
      	  accountsSearchContent('accountsDetailsSearch.jsp');
        }
        else{
         }
        }
	
	function getIbBranch(event){
        var x= event.keyCode;
        if(x==114){
        	branchSearchContent('branchSearchGrid.jsp?check=1');
        }
        else{
         }
        }
	
	function funCardSearch(){
	
		cardSearchContent('cardDetailsSearchGrid.jsp');
	}
	
	
	
	function ibbranchcheck(){
		 if(document.getElementById("chckibbranch").checked){
			 document.getElementById("hidchckibbranch").value = 1;
			 $('#txtibbranch').attr('disabled', false );
		 }
		 else{
			 document.getElementById("hidchckibbranch").value = 0;
			 $('#txtibbranchid').val('0');$('#txtibbranch').val('');
			 $('#txtibbranch').attr('disabled', true );
			 
			 if (document.getElementById("txtibbranch").value == "") {
			        $('#txtibbranch').attr('placeholder', 'Press F3 to Search'); 
			  }
		 }
	 }
	
	function funreload(event){
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var uptodate = $('#uptodate').val();
		 var agreementcloseddays = $('#txtagreementcloseddays').val();
		 var clientAccount = $('#txtcldocno').val();
		 
		 $("#overlay, #PleaseWait").show();
		 
		 $("#refundableDiv").load("refundGrid.jsp?branchval="+branchval+'&uptodate='+uptodate+'&agreementcloseddays='+agreementcloseddays.replace(/ /g, "%20")+'&chk=1&clientAccount='+clientAccount);
		}
	
	function  funClearInfo(){
		
		$('#cmbbranch').val('a');
		$('#uptodate').val(new Date());$('#date').val(new Date());$('#chqdate').val(new Date());
		$('#btnRefund,#btnRelease').attr('disabled',false);
		$('#txtagreementcloseddays').val('');$('#txtclientaccount').val('');$('#txtclientname').val('');$('#txtcldocno').val('');$('#clientinfo').val('');
		$('#txtnetamount').val('0.00');
		
		document.getElementById("hidchckibbranch").value = 0;
		 if(document.getElementById("hidchckibbranch").value==0){
			 document.getElementById("chckibbranch").checked = false;
		 }
		 $('#txtibbranchid').val('0');$('#txtibbranch').val('');
		 $('#cmbtype').val('');$('#hidcmbtype').val('');$('#txttypedocno').val('');$('#txttypeaccid').val('');
		 $('#txttypeaccname').val('');$('#txttypeatype').val('');$('#txttypecurid').val('');$('#txttyperate').val('');
		 $('#txttypetype').val('');$('#txtchequeno').val('');$('#txtremarks').val('');

		 $('#cmbtype').attr('disabled', true );$('#txttypeaccid').attr('readonly', true );$('#txttypeaccid').attr('readonly', true );
		 $('#cmbcardtype').val('');$('#cmbcardtype').attr('disabled', true );
	     $('#txtchequeno').attr('readonly', true );$('#txtremarks').attr('readonly', true );$('#txtibbranch').attr('disabled', true );
	     $('#btnRefund').attr('disabled', true );$('#btnRelease').attr('disabled', true );$('#date').jqxDateTimeInput({disabled: true});
	     $('#chqdate').jqxDateTimeInput({disabled: true});$('#btnCardSearch').attr('disabled', true);
		 $("#jqxRefund").jqxGrid('clear');$("#jqxRefund").jqxGrid('addrow', null, {});
		
		if (document.getElementById("txtagreementcloseddays").value == "") {
		        $('#txtagreementcloseddays').attr('placeholder', 'Agreement Closed Days'); 
		}
		  
		 if (document.getElementById("txtclientaccount").value == "") {
		        $('#txtclientaccount').attr('placeholder', 'Press F3 to Search'); 
		 }
		 
		 if (document.getElementById("txtibbranch").value == "") {
		        $('#txtibbranch').attr('placeholder', 'Press F3 to Search'); 
		  }
		
		}
	
	function bankAccountSearch(){
		 if(document.getElementById("cmbtype").value == 5){
			 $('#txttypedocno').val('');$('#txttypeaccid').val('');$('#txttypeaccname').val('');
			 $('#txttypeatype').val('');$('#txttypecurid').val('');$('#txttyperate').val('');
			 $('#txttypetype').val('');$('#txtchequeno').attr('readonly', false );
			 $('#cmbcardtype').val('');$('#cmbcardtype').attr('disabled', true );
			 $('#btnCardSearch').attr('disabled', true);
			 $('#chqdate').jqxDateTimeInput({disabled: false});
			 
			 if (document.getElementById("txttypeaccid").value == "") {
			        $('#txttypeaccid').attr('placeholder', 'Press F3 to Search'); 
			    }
			 $('#txttypeaccid').focus();
			 
		 }else if(document.getElementById("cmbtype").value == 6 || document.getElementById("cmbtype").value == 4){
			 $('#txttypeaccid').attr('tabindex', '-1');
			 $('#txttypeaccname').attr('tabindex', '-1');
			 $('#cmbcardtype').val('');$('#cmbcardtype').attr('disabled', false );
			 $('#txtchequeno').attr('readonly', false );
			 $('#btnCardSearch').attr('disabled', false);
			 $('#chqdate').jqxDateTimeInput({disabled: false});
			 
		 }else{
			 $('#txttypeaccid').attr('tabindex', '-1');
			 $('#txttypeaccname').attr('tabindex', '-1');
			 $('#cmbcardtype').val('');$('#cmbcardtype').attr('disabled', true );
			 $('#txtchequeno').attr('readonly', true );
			 $('#btnCardSearch').attr('disabled', true);
			 $('#chqdate').jqxDateTimeInput({disabled: true});
		 }
	 }
	
	function funRefund(event){
		
		var refunddate = $('#date').val();
		var ibbranch = $('#txtibbranchid').val();
		var chckibbranch = $('#hidchckibbranch').val();
		var type = $('#cmbtype').val();
		var typeaccount = $('#txttypedocno').val();
		var chequeno = $('#txtchequeno').val();
		var remarks = $('#txtremarks').val();
		var clientaccount = $('#txtclaccount').val();
		var clientdocno = $('#txtclientdocno').val();
		var clientname = $('#txtclname').val();
		var rano = $('#txtrano').val();
		var rtype = $('#txtrtype').val();
		var mainbrhid = $('#txtmainbrhid').val();
		var securityamount = $('#txtsecurityamount').val();
		var balanceamount = $('#txtbalanceamount').val();
		var cardtype = $('#cmbcardtype').val();
		var process="REFUNDED";
		
		if(type==''){
			 $.messager.alert('Message','Please Choose a Type.','warning');
			 return 0;
		 }
		
		if(typeaccount==''){
			 $.messager.alert('Message','Please Choose an Account.','warning');
			 return 0;
		 }
		
		if(securityamount.trim()==''){
			 $.messager.alert('Message','Security Amount Unavailable, Transaction Restricted.','warning');
			 return 0;
		 }
		
		/*if(balanceamount<0){
			 $.messager.alert('Message','Net Amount is Negative, Transaction Restricted.','warning');
			 return 0;
		 }*/
		 
		if($('#cmbbranch').val()=='a'){
			  $.messager.alert('Message','Please Select a Branch.','warning');
				return 0;
		}
		
		if(($('#hidchckibbranch').val()=='1') && ($('#txtibbranchid').val()=='0')){
			 $.messager.alert('Message','Please Choose Inter-Branch.','warning');
			 return 0;
		}
		
		ibvalid=document.getElementById("txtibvalidation").value;
		  if(ibvalid==1){
			 $.messager.alert('Message','Closing Done For Inter-Branch,Transaction Restricted.','warning');
			 return 0;
		  }
		  
		/* if(remarks==''){
		    $.messager.alert('Message','Please Enter Remarks.','warning');
			return 0;
		} */
		
		var date = $('#date').jqxDateTimeInput('getDate');
		var validdate=funDateInPeriod(date);
		if(validdate==0){
			return 0;	
		}
		
		    $.messager.confirm('Message', 'Do you want to Refund Security?', function(r){
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		 $('#chqdate').jqxDateTimeInput({disabled: false});
		     		 var chequedate = $('#chqdate').val();
		     		$("#overlay, #PleaseWait").show();
		     		 saveGridData(refunddate,ibbranch,chckibbranch,type,typeaccount,chequeno,chequedate,remarks,clientaccount,clientdocno,clientname,rano,rtype,mainbrhid,securityamount,balanceamount,cardtype,process);	
		     	}
		 });
	}
	
	function funRelease(event){
		
		var refunddate = $('#date').val();
		var ibbranch = $('#txtibbranchid').val();
		var chckibbranch = $('#hidchckibbranch').val();
		var type = $('#cmbtype').val();
		var typeaccount = $('#txttypedocno').val();
		var chequeno = $('#txtchequeno').val();
		var remarks = $('#txtremarks').val();
		var clientaccount = $('#txtclaccount').val();
		var clientdocno = $('#txtclientdocno').val();
		var clientname = $('#txtclname').val();
		var rano = $('#txtrano').val();
		var rtype = $('#txtrtype').val();
		var mainbrhid = $('#txtmainbrhid').val();
		var securityamount = $('#txtsecurityamount').val();
		var balanceamount = $('#txtbalanceamount').val();
		var cardtype = $('#cmbcardtype').val();
		var process="RELEASED";
		
		if(securityamount.trim()==''){
			 $.messager.alert('Message','Security Amount Unavailable, Transaction Restricted.','warning');
			 return 0;
		 }
		
		if($('#cmbbranch').val()=='a'){
			  $.messager.alert('Message','Please Select a Branch.','warning');
				return 0;
		}
		  
		/* if(remarks==''){
		    $.messager.alert('Message','Please Enter Remarks.','warning');
			return 0;
		} */
		
		var date = $('#date').jqxDateTimeInput('getDate');
		var validdate=funDateInPeriod(date);
		if(validdate==0){
			return 0;	
		}
		
		    $.messager.confirm('Message', 'Do you want to Release Security?', function(r){
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		 $('#chqdate').jqxDateTimeInput({disabled: false});
		     		 var chequedate = $('#chqdate').val();
		     		$("#overlay, #PleaseWait").show();
		     		saveGridData(refunddate,ibbranch,chckibbranch,type,typeaccount,chequeno,chequedate,remarks,clientaccount,clientdocno,clientname,rano,rtype,mainbrhid,securityamount,balanceamount,cardtype,process);	
		     	}
		 });
	}
	
	function saveGridData(refunddate,ibbranch,chckibbranch,type,typeaccount,chequeno,chequedate,remarks,clientaccount,clientdocno,clientname,rano,rtype,mainbrhid,securityamount,balanceamount,cardtype,process){
		$('#btnRefund,#btnRelease').attr('disabled',true);
		$("#jqxRefund").jqxGrid({disabled:true});
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;
				items = items.split('***');
				var val = items[0];
				var rrpno = items[1];
				var result = items[2];
				
				result = result.toLowerCase().replace(/\b[a-z]/g, function(letter) {
				    return letter.toUpperCase();
				});
				
				$.messager.alert('Message', ''+result+' Successfully, Doc No. '+rrpno+'', function(r){
				});
				
			  funClearInfo();
		      funreload(event); 
		  }
		}
			
	x.open("GET","saveData.jsp?refunddate="+refunddate+"&ibbranch="+ibbranch+"&chckibbranch="+chckibbranch+"&type="+type+"&typeaccount="+typeaccount+"&chequeno="+chequeno+"&chequedate="+chequedate+"&remarks="+remarks+"&clientaccount="+clientaccount+"&clientdocno="+clientdocno+"&clientname="+clientname+"&rano="+rano+"&rtype="+rtype+"&mainbranch="+mainbrhid+"&securityamount="+securityamount+"&balanceamount="+balanceamount+"&cardtype="+cardtype+"&process="+process,true);
	x.send();
	}
	
	function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	JSONToCSVCon(data, 'SecurityRefund', true);
		 } else {
			 $("#jqxRefund").jqxGrid('exportdata', 'xls', 'SecurityRefund');
		 }
	 }
	
</script>
</head>
<body onload="getBranch();getCardTypes();getPayTypes();">
<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ===== LEFT PANEL ===== -->
<td width="20%" valign="top">

<fieldset class="filter-card scrollable-left">
<table width="100%" class="filter-table">

    <!-- HEADING (UNCHANGED) -->
    <jsp:include page="../../heading.jsp"></jsp:include>

    <tr>
        <td class="label-cell">Up To</td>
        <td><div id="uptodate" name="uptodate"
             value='<s:property value="uptodate"/>'></div></td>
    </tr>

    <tr>
        <td class="label-cell">Closed Before</td>
        <td>
            <input type="text"
                   id="txtagreementcloseddays"
                   name="txtagreementcloseddays"
                   class="master-input"
                   placeholder="Agreement Closed Days"
                   onkeypress="javascript:return isNumber(event)"
                   value='<s:property value="txtagreementcloseddays"/>'>
        </td>
    </tr>

    <tr>
        <td class="label-cell">Client</td>
        <td>
            <div style="display:flex;gap:6px;align-items:center;">
                <input type="text"
                       id="txtclientaccount"
                       name="txtclientaccount"
                       class="master-input"
                       readonly
                       placeholder="Press F3 to Search"
                       value='<s:property value="txtclientaccount"/>'
                       onkeydown="getClient(event);">

                <button type="button"
                        class="btn-icon"
                        title="Change Agreement"
                        onclick="funChangeAgreement();">
                    <img src="<%=contextPath%>/icons/add_new.png" alt="">
                </button>
            </div>

            <input type="hidden" id="hiddocno" name="hiddocno"
                   value='<s:property value="hiddocno"/>'>
        </td>
    </tr>

    <tr>
        <td></td>
        <td>
            <input type="text"
                   id="txtclientname"
                   name="txtclientname"
                   class="master-input"
                   readonly
                   value='<s:property value="txtclientname"/>'
                   tabindex="-1">

            <input type="hidden" id="txtcldocno" name="txtcldocno"
                   value='<s:property value="txtcldocno"/>'>
        </td>
    </tr>

    <tr>
        <td colspan="2" align="center">
            <textarea id="clientinfo"
                      class="master-textarea"
                      readonly><s:property value="clientinfo"/></textarea>
        </td>
    </tr>

    <tr>
        <td class="label-cell">Date</td>
        <td>
            <div id="date" name="date"
                 value='<s:property value="date"/>'></div>
            <input type="hidden" id="hiddate" name="hiddate"
                   value='<s:property value="hiddate"/>'>
        </td>
    </tr>

    <tr>
        <td class="label-cell">Branch</td>
        <td>
            <div style="display:flex;gap:6px;align-items:center;">
                <input type="text"
                       id="txtibbranch"
                       name="txtibbranch"
                       class="master-input"
                       readonly
                       placeholder="Press F3 to Search"
                       value='<s:property value="txtibbranch"/>'
                       onkeydown="getIbBranch(event);">

                <input type="checkbox"
                       id="chckibbranch"
                       name="chckibbranch"
                       onchange="ibbranchcheck();"
                       onclick="$(this).attr('value', this.checked ? 1 : 0)">
            </div>

            <input type="hidden" id="txtibbranchid" name="txtibbranchid"
                   value='<s:property value="txtibbranchid"/>'>
            <input type="hidden" id="hidchckibbranch" name="hidchckibbranch"
                   value='<s:property value="hidchckibbranch"/>'>
        </td>
    </tr>

    <tr>
        <td class="label-cell">Type</td>
        <td>
            <select id="cmbtype"
                    name="cmbtype"
                    class="master-input"
                    onchange="bankAccountSearch();getAccounts(this.value,$('#date').val());"
                    value='<s:property value="cmbtype"/>'>
            </select>

            <input type="hidden" id="hidcmbtype" name="hidcmbtype"
                   value='<s:property value="hidcmbtype"/>'>
        </td>
    </tr>

    <tr>
        <td class="label-cell">Account</td>
        <td>
            <input type="text"
                   id="txttypeaccid"
                   name="txttypeaccid"
                   class="master-input"
                   readonly
                   value='<s:property value="txttypeaccid"/>'
                   onkeydown="getAccType(event);">
        </td>
    </tr>

    <tr>
        <td></td>
        <td>
            <input type="text"
                   id="txttypeaccname"
                   name="txttypeaccname"
                   class="master-input"
                   readonly
                   value='<s:property value="txttypeaccname"/>'>
        </td>
    </tr>

    <tr>
        <td class="label-cell">Card Type</td>
        <td>
            <div style="display:flex;gap:6px;align-items:center;">
                <select id="cmbcardtype"
                        name="cmbcardtype"
                        class="master-input"
                        value='<s:property value="cmbcardtype"/>'>
                    <option value="">--Select--</option>
                </select>

                <button type="button"
                        class="btn-icon"
                        onclick="funCardSearch();">
                    <img src="<%=contextPath%>/icons/cardsearch.png" alt="">
                </button>
            </div>
        </td>
    </tr>

    <tr>
        <td class="label-cell">Cheque/Card No.</td>
        <td><input type="text"
                   id="txtchequeno"
                   name="txtchequeno"
                   class="master-input"
                   value='<s:property value="txtchequeno"/>'></td>
    </tr>

    <tr>
        <td class="label-cell">Cheque/Card Date</td>
        <td>
            <div id="chqdate" name="chqdate"
                 value='<s:property value="chqdate"/>'></div>
        </td>
    </tr>

    <tr>
        <td class="label-cell">Remarks</td>
        <td><input type="text"
                   id="txtremarks"
                   name="txtremarks"
                   class="master-input"
                   value='<s:property value="txtremarks"/>'></td>
    </tr>

    <tr>
        <td colspan="2" align="center">
            <button class="btn-submit"
                    type="button"
                    id="btnRefund"
                    onclick="funRefund(event);">Refund</button>

            <button class="btn-submit"
                    type="button"
                    id="clear"
                    onclick="funClearInfo();">Clear</button>

            <button class="btn-submit"
                    type="button"
                    id="btnRelease"
                    onclick="funRelease(event);">Release</button>
        </td>
    </tr>

    <!-- HIDDEN FIELDS (UNCHANGED) -->
    <tr><td colspan="2">
        <input type="hidden" id="txtclientdocno" name="txtclientdocno">
        <input type="hidden" id="txtclaccount" name="txtclaccount">
        <input type="hidden" id="txtclname" name="txtclname">
        <input type="hidden" id="txtrano" name="txtrano">
        <input type="hidden" id="txtrtype" name="txtrtype">
        <input type="hidden" id="txtmainbrhid" name="txtmainbrhid">
        <input type="hidden" id="txtsecurityamount" name="txtsecurityamount">
        <input type="hidden" id="txtbalanceamount" name="txtbalanceamount">
        <input type="hidden" id="txtibvalidation" name="txtibvalidation">
        <input type="hidden" id="txthidtype" name="txthidtype">
        <input type="hidden" id="txthidtrno" name="txthidtrno">
        <input type="hidden" id="txthidvoc" name="txthidvoc">
    </td></tr>

</table>
</fieldset>

</td>

<!-- ===== RIGHT PANEL ===== -->
<td width="80%" valign="top">

<table width="100%">
<tr>
    <td>
        <div id="refundableDiv">
            <jsp:include page="refundGrid.jsp"></jsp:include>
        </div>
    </td>
</tr>
</table>

<table width="100%">
<tr>
    <td align="right" style="font-weight:bold;">Net Balance :</td>
    <td><input type="text"
               id="txtnetamount"
               class="textbox"
               style="text-align:right;"
               value='<s:property value="txtnetamount"/>'></td>
</tr>
</table>

</td>
</tr>
</table>

</div>

<div id="accountDetailsWindow"><div></div><div></div></div>
<div id="branchSearchWindow"><div></div><div></div></div>
<div id="cardDetailsWindow"><div></div><div></div></div>
<div id="agmtDetailsWindow"><div></div><div></div></div>

</div>
</body>

</html>