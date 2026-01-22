<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

<style type="text/css">
    /* Layout & Sidebar Structure */
    .master-container {
        display: flex;
        font-family: 'Segoe UI', Tahoma, sans-serif !important;
        background-color: #f4f7f9;
        width: 100%;
        height: 100vh !important;
        overflow: hidden !important;
    }

    .sidebar-filters {
        width: 330px; 
        flex: 0 0 330px;
        background-color: #ffffff;
        border-right: 1px solid #e1e8ed;
        display: flex;
        flex-direction: column;
        z-index: 10;
        box-shadow: 2px 0 8px rgba(0,0,0,0.05);
        height: 100vh !important;
    }

    .sidebar-fixed-top {
        padding: 20px 20px 15px 20px;
        background-color: #ffffff;
        border-bottom: 1px solid #f0f4f8;
        flex-shrink: 0;
    }

    .sidebar-scroll-content {
        flex: 1;
        overflow-y: auto;
        padding: 15px 20px 25px 20px;
    }

    /* Cleaned Cards - Background colors removed */
    .filter-card {
        background-color: #f8fafc !important;
        border: 1px solid #e3e8ee !important;
        border-radius: 12px !important;
        padding: 15px;
        margin-bottom: 10px;
    }

    .filter-table { 
        width: 100%; 
        border-spacing: 0 10px; 
    }

    /* Force remove unwanted green/yellow backgrounds */
    .filter-card, fieldset, legend, .branch, td, tr {
        background-color: transparent !important;
        background: none !important;
    }

    .label-cell {
        text-align: right;
        padding-right: 12px;
        font-size: 13px;
        color: #4e5e71;
        font-weight: 600;
        width: 95px;
    }

    /* Input & Select Styling */
    input[type="text"], select {
        width: 100%;
        border: 1px solid #ccd6e0;
        border-radius: 6px;
        padding: 7px 10px;
        font-size: 13px;
        color: #333;
        box-sizing: border-box;
        background-color: #ffffff !important;
    }

    /* RHS Visibility & Scrollbar Kill */
    .main-content-wrapper {
        flex: 1;
        display: flex;
        flex-direction: column;
        height: 100vh;
        width: 100%;
        max-width: calc(100vw - 330px);
        overflow: hidden !important; 
        position: relative;
        background-color: #ffffff;
    }

    .scrollable-grid-area {
        flex: 1;
        overflow-y: auto !important;
        overflow-x: hidden !important; 
        padding: 20px;
    }

    /* Button Styling */
    .myButtons {
        background: linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
        background-color: #768d87;
        border: 1px solid #566963;
        border-radius: 6px;
        cursor: pointer;
        color: #ffffff;
        font-size: 13px;
        font-weight: 600;
        padding: 10px;
        width: 100%;
        margin-bottom: 8px;
        text-shadow: 0px -1px 0px #2b665e;
    }

    .myButton {
        background-color: #2563eb !important;
        color: #ffffff !important;
        border: none !important;
        padding: 12px !important;
        border-radius: 6px !important;
        cursor: pointer;
        font-size: 14px;
        font-weight: 600;
        width: 100%;
        transition: background 0.2s;
    }

    .textbox {
        border: 1px solid #ccd6e0;
        height: 25px;
        border-radius: 5px;
        padding: 0 5px;
        outline: 0;
        background-color: #ffffff !important;
    }

    .branch { font-size: 13px; color: #4e5e71; font-weight: 600; }
</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy", enableBrowserBoundsDetection: true});
		 
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 $('#branchSearchWindow').jqxWindow({width: '20%', height: '58%',  maxHeight: '60%' ,maxWidth: '30%' , title: 'Branch Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#branchSearchWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		
	     var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		 $('#txtaccid').dblclick(function(){
			  accountsSearchContent('accountsDetailsSearch.jsp');
			  });
		  
		  $('#txtibbranch').dblclick(function(){
			  branchSearchContent('branchSearchGrid.jsp?check=1');
			  });
			  
	     document.getElementById("hidchckibbranch").value=0;
	     
	     $("#postingJV").jqxGrid({ disabled: true});$("#cardCommGrid").jqxGrid('clear');$("#cardCommGrid").jqxGrid({ disabled: true});
	});
	
	function isNumber(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
         {
          $.messager.alert('Message',' Enter Numbers Only ','warning');    
            return false;
         }
        return true;
    }
	
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
  			
  			    $('#txttypedocno').val(docNoItems);	
  			    $('#txttypeaccid').val(accountIdItems);
  			    $('#txttypeaccname').val(accountItems);
  			  	$('#txttypeatype').val(accountTypeItems);
			    $('#txttypecurid').val(accountCurIdItems);
			    $('#txttyperate').val(accountRateItems);
			    $('#txttypetype').val(accCurrTypeItems);
  		}
  		}
  		x.open("GET", "getAccounts.jsp?paytype="+a+"&date="+b, true);
  		x.send();
 }
	
	function getCommissionAccounts(a,b){
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
				var accCosttypeItems = items[7];
  				var accCostcodeItems = items[8];
  			
  			    $('#txtcommdocno').val(docNoItems);	
  			    $('#txtcommaccid').val(accountIdItems);
  			    $('#txtcommaccname').val(accountItems);
  			  	$('#txtcommatype').val(accountTypeItems);
			    $('#txtcommcurid').val(accountCurIdItems);
			    $('#txtcommrate').val(accountRateItems);
			    $('#txtcommtype').val(accCurrTypeItems);
				$('#txtcommcosttype').val(accCosttypeItems);
			    $('#txtcommcostcode').val(accCostcodeItems);
  		}
  		}
  		x.open("GET", "getCommissionAccounts.jsp?paytype="+a+"&date="+b, true);
  		x.send();
    }
	
	function getTaxAccounts(a,b){
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
				var accCosttypeItems = items[7];
  				var accCostcodeItems = items[8];
  				var taxPerItems = items[9];
  			
  			    $('#txttaxaccdocno').val(docNoItems);	
  			    $('#txttaxaccid').val(accountIdItems);
  			    $('#txttaxaccname').val(accountItems);
  			  	$('#txttaxaccatype').val(accountTypeItems);
			    $('#txttaxacccurid').val(accountCurIdItems);
			    $('#txttaxaccrate').val(accountRateItems);
			    $('#txttaxacccurtype').val(accCurrTypeItems);
				$('#txttaxacccosttype').val(accCosttypeItems);
			    $('#txttaxacccostcode').val(accCostcodeItems);
			    $('#txttaxpercentage').val(taxPerItems);
			    
  		}
  		}
  		x.open("GET", "getTaxAccounts.jsp?paytype="+a+"&date="+b, true);
  		x.send();
    }
	
	function getCardCommSeparate(){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  			    $('#txtbipostingcardcomm').val(items);
  		}
  		}
  		x.open("GET", "getCommSeparateAllowed.jsp", true);
  		x.send();
    }
	
	function getNonTaxableEntity(){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();
	  				$('#txtnontaxableentity').val(items);
	  				
	  				if(parseInt($('#txtnontaxableentity').val().trim())==1){
	  				 	getTaxAccounts($('#cmbtype').val(),$('#date').val());
	  				}
	  		}
	  		}
	  		x.open("GET", "getNonTaxableEntity.jsp", true);
	  		x.send();
	 }
	  
	function fromdatechange(){
	    var date = $('#fromdate').jqxDateTimeInput('getDate');
		var validdate=funDateInPeriod(date);
		if(parseInt(validdate)==0){
			$.messager.alert('Message','Transaction prior or after Account Period is not valid.','warning');
			return 0;	
		 }
    }
    
    function todatechange(){
	    var date = $('#todate').jqxDateTimeInput('getDate');
		var validdate=funDateInPeriod(date);
		if(parseInt(validdate)==0){
			$.messager.alert('Message','Transaction prior or after Account Period is not valid.','warning');
			return 0;	
		 }
    }
    
    function datechange(){
    	
    	if(parseInt($('#txtnontaxableentity').val().trim())==1){
    		getTaxAccounts($('#cmbtype').val(),$('#date').val());
    	}
    	
	    var date = $('#date').jqxDateTimeInput('getDate');
		var validdate=funDateInPeriod(date);
		 if(parseInt(validdate)==0){
			$.messager.alert('Message','Transaction prior or after Account Period is not valid.','warning');
			return 0;	
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
	
	function ibbranchcheck(){
		 if(document.getElementById("chckibbranch").checked){
			 document.getElementById("hidchckibbranch").value = 1;
			 $('#txtibbranch').attr('disabled', false );
		 }
		 else{
			 document.getElementById("hidchckibbranch").value = 0;
			 $('#txtibbranchid').val('');$('#txtibbranch').val('');
			 $('#txtibbranch').attr('disabled', true );
			 
			 if (document.getElementById("txtibbranch").value == "") {
			        $('#txtibbranch').attr('placeholder', 'Press F3 to Search'); 
			  }
		 }
	 }
	
	    
	function clearAccountInfo(){
		$('#txtdocno').val('');$('#txtaccid').val('');$('#txtaccname').val('');
		
		if (document.getElementById("txtaccid").value == "") {
	        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
	  }
	} 
	
	function funreload(event){
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var paytype = $('#cmbtype').val();
		 var check = 1;
		 
		 if($('#cmbbranch').val()=='a'){
			 $.messager.alert('Message','Please Choose a Specific Main-Branch.','warning');
			 return 0;
		 }
		 
		 if(paytype==''){
			 $.messager.alert('Message','Please Choose Type.','warning');
			 return 0;
		 }
		 
		 if(fromdate==''){
			 $.messager.alert('Message','Please Enter From Date.','warning');
			 return 0;
		 }
		 
		 if(todate==''){
			 $.messager.alert('Message','Please Enter To Date.','warning');
			 return 0;
		 }
		 
	    var date = $('#fromdate').jqxDateTimeInput('getDate');
		var validdate=funDateInPeriod(date);
		if(parseInt(validdate)==0){
			$.messager.alert('Message','Transaction prior or after Account Period is not valid.','warning');
			return 0;	
		 }
    
	    var date = $('#todate').jqxDateTimeInput('getDate');
		var validdate=funDateInPeriod(date);
		if(parseInt(validdate)==0){
			$.messager.alert('Message','Transaction prior or after Account Period is not valid.','warning');
			return 0;	
		 }
		 
		 $("#overlay, #PleaseWait").show();
		 
		 if(paytype==2){
	       	 $("#postingCardDiv").load("postingCardGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&paytype='+paytype+'&check='+check);
		 }else if(paytype==3){
			 $("#postingChequeDiv").load("postingChequeGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&paytype='+paytype+'&check='+check);
		 }else if(paytype==4){
			 $("#postingRefundDiv").load("postingRefundGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&paytype='+paytype+'&check='+check);
		 }else{
			 $("#postingCashDiv").load("postingCashGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&paytype='+paytype+'&check='+check);
		 }
		 
		 $("#postingJV").jqxGrid('clear');$("#postingJV").jqxGrid({ disabled: true});
		 $('#txtdrtotal').val('0.00');$('#txtcrtotal').val('0.00');
		 
		}
	
	function funCalculate(){
		
		if($('#cmbbranch').val()=='a'){
			 $.messager.alert('Message','Please Choose a Specific Main-Branch.','warning');
			 return 0;
		 }
		
		var date = $('#fromdate').jqxDateTimeInput('getDate');
		var validdate=funDateInPeriod(date);
		if(parseInt(validdate)==0){
			$.messager.alert('Message','Transaction prior or after Account Period is not valid.','warning');
			return 0;	
		 }
    
	    var date = $('#todate').jqxDateTimeInput('getDate');
		var validdate=funDateInPeriod(date);
		if(parseInt(validdate)==0){
			$.messager.alert('Message','Transaction prior or after Account Period is not valid.','warning');
			return 0;	
		 }
		
		ibvalid=document.getElementById("txtibvalidation").value;
		 if(ibvalid==1){
			 $.messager.alert('Message','Closing Done For Inter-Branch,Transaction Restricted.','warning');
			 return 0;
		 }
		 
		if($('#cmbtype').val()==''){
			 $.messager.alert('Message','Please Choose Type.','warning');
			 return 0;
		 }
		
		if($('#cmbtype').val()=='3'){
			var selectedrows=$("#postingChequeGrid").jqxGrid('selectedrowindexes');
			if(selectedrows.length>1){
				$.messager.alert('Message','Only One Cheque can be Posted at a Time.','warning');
				return 0;
		   }
		}
		
		if($('#txtdocno').val()==''){
			 $.messager.alert('Message','Please Choose Bank Account & Then Calculate.','warning');
			 return 0;
		 }
		
		var rows = $('#postingJV').jqxGrid('getrows');
    	var rowlength= rows.length;
		if(rowlength!=0){
			$.messager.alert('Message','Already calculated.Submit Again. ','warning');
			return 0;
		} else{
			$("#postingJV").jqxGrid('clear');
			$('#txtselecteddocs').val('');$('#txtselectedrno').val('');
		} 
		
		var temp1="",tempdocs1="",temprno1="";
		
		if($('#cmbtype').val()=='1'){
			
			$("#overlay, #PleaseWait").show();
			
			var rows = $('#postingJV').jqxGrid('getrows');
	    	var rowlength= rows.length;
			if(rowlength==0){
				$("#postingJV").jqxGrid('addrow', null, {});
	  	    	$("#postingJV").jqxGrid('addrow', null, {});
	    	}
			$("#postingJV").jqxGrid({ disabled: false});
				
			var rows = $("#postingCashGrid").jqxGrid('getrows');
			
			if(rows.length==1 && (rows[0].netamt=="undefined" || rows[0].netamt==null || rows[0].netamt=="")){
				return false;
			}
			
			var selectedrows=$("#postingCashGrid").jqxGrid('selectedrowindexes');
			selectedrows = selectedrows.sort(function(a,b){return a - b});
			
			if(selectedrows.length==0){
				$("#overlay, #PleaseWait").hide();
				$.messager.alert('Warning','Select Items to be Calculated.');
				return false;
			}
			
			var i=0;var temp="",tempdocs="",temprno="";
	        $('#gridlength').val(selectedrows.length);
	        var j=0;
		    for (i = 0; i < rows.length; i++) {
					if(selectedrows[j]==i){
						
						if(i==0){
							temp=rows[i].tr_no;
							tempdocs=rows[i].documentno;
							temprno=rows[i].srno;
						}
						else{
							temp=temp+"::"+rows[i].tr_no;
							tempdocs=tempdocs+","+rows[i].documentno;
							temprno=temprno+","+rows[i].srno;
						}
						temp1=temp+"::";
						tempdocs1=tempdocs+",";
						temprno1=temprno+",";
						
						$("#postingCashGrid").jqxGrid('setcellvalue', i, "totalamount", $('#postingCashGrid').jqxGrid('getcellvalue', i, "netamt"));
						
					j++; 
				  }
	            }
		    $('#txtselecteddocs').val(tempdocs1);
		    $('#txtselectedrno').val(temprno1);
		    $("#postingJV").jqxGrid('setcellvalue', 0, "description", "RRV["+$('#txtselectedrno').val()+"] ["+$('#txtselecteddocs').val()+"] CASH POSTING on "+$('#date').val()+"");
		    $("#postingJV").jqxGrid('setcellvalue', 1, "description", "RRV["+$('#txtselectedrno').val()+"] ["+$('#txtselecteddocs').val()+"] CASH POSTING on "+$('#date').val()+"");
		  }
		
		if($('#cmbtype').val()=='2'){
		getCardCommSeparate();
		
		$("#overlay, #PleaseWait").show();
		
		var rows = $('#postingJV').jqxGrid('getrows');
    	var rowlength= rows.length;
    	if(rowlength==0){
    		if($('#txtbipostingcardcomm').val().trim()=="0"){
				$("#postingJV").jqxGrid('addrow', null, {});
  	    		$("#postingJV").jqxGrid('addrow', null, {});
  	    		$("#postingJV").jqxGrid('addrow', null, {});
    		}else{
    			$("#postingJV").jqxGrid('addrow', null, {});
    			$("#postingJV").jqxGrid('addrow', null, {});
    		}
    	}
		$("#postingJV").jqxGrid({ disabled: false});
			
		var rows = $("#postingCardGrid").jqxGrid('getrows');
		var paytype = $('#cmbtype').val();
		
		if(rows.length==1 && (rows[0].netamt=="undefined" || rows[0].netamt==null || rows[0].netamt=="")){
			return false;
		}
		
		var selectedrows=$("#postingCardGrid").jqxGrid('selectedrowindexes');
		selectedrows = selectedrows.sort(function(a,b){return a - b});
		
		if(selectedrows.length==0){
			$("#overlay, #PleaseWait").hide();
			$.messager.alert('Warning','Select Cards to be Calculated.');
			return false;
		}
		
		var comm="",q=0;
		var cardtyperows = $("#cardCommGrid").jqxGrid('getrows');
		for (var c = 0; c < rows.length; c++) {
			if(selectedrows[q]==c){
				
			 for (var f = 0; f < cardtyperows.length; f++) {
				 if(rows[c].cardtype==cardtyperows[f].mode){
					comm= cardtyperows[f].commission;
					break;
				 }
			 }
			 
			 $("#postingCardGrid").jqxGrid('setcellvalue', c, "cardtypecomm", comm);
			 q++;
			}
		 }
		
		var i=0;var temp="",tempdocs="",temprno="";
        $('#gridlength').val(selectedrows.length);
        var j=0;
	    for (i = 0; i < rows.length; i++) {
				if(selectedrows[j]==i){
					cardCommission(rows[i].cardtype,rows[i].netamt,paytype,rows[i].cardtypecomm,i,selectedrows.length);
					if(i==0){
						temp=rows[i].tr_no;
						tempdocs=rows[i].documentno;
						temprno=rows[i].srno;
					}
					else{
						temp=temp+"::"+rows[i].tr_no;
						tempdocs=tempdocs+","+rows[i].documentno;
						temprno=temprno+","+rows[i].srno;
					}
					temp1=temp+"::";
					tempdocs1=tempdocs+",";
					temprno1=temprno+",";
				j++; 
			  }
            }
		  }
		
			if($('#cmbtype').val()=='3'){
			
			$("#overlay, #PleaseWait").show();
			
			var rows = $('#postingJV').jqxGrid('getrows');
	    	var rowlength= rows.length;
			if(rowlength==0){
				$("#postingJV").jqxGrid('addrow', null, {});
	  	    	$("#postingJV").jqxGrid('addrow', null, {});
	    	}
			$("#postingJV").jqxGrid({ disabled: false});
				
			var rows = $("#postingChequeGrid").jqxGrid('getrows');
			
			if(rows.length==1 && (rows[0].netamt=="undefined" || rows[0].netamt==null || rows[0].netamt=="")){
				return false;
			}
			
			var selectedrows=$("#postingChequeGrid").jqxGrid('selectedrowindexes');
			selectedrows = selectedrows.sort(function(a,b){return a - b});
			
			if(selectedrows.length==0){
				$("#overlay, #PleaseWait").hide();
				$.messager.alert('Warning','Select Items to be Calculated.');
				return false;
			}
			
			var i=0;var temp="",tempdocs="",temprno="";
	        $('#gridlength').val(selectedrows.length);
	        var j=0;
		    for (i = 0; i < rows.length; i++) {
					if(selectedrows[j]==i){
						
						if(i==0){
							temp=rows[i].tr_no;
							tempdocs=rows[i].documentno;
							temprno=rows[i].srno;
						}
						else{
							temp=temp+"::"+rows[i].tr_no;
							tempdocs=tempdocs+","+rows[i].documentno;
							temprno=temprno+","+rows[i].srno;
						}
						temp1=temp+"::";
						tempdocs1=tempdocs+",";
						temprno1=temprno+",";
						
						$("#postingChequeGrid").jqxGrid('setcellvalue', i, "totalamount", $('#postingChequeGrid').jqxGrid('getcellvalue', i, "netamt"));
						
					j++; 
				  }
	            }
		    $('#txtselecteddocs').val(tempdocs1);
		    $('#txtselectedrno').val(temprno1);
		    $("#postingJV").jqxGrid('setcellvalue', 0, "description", "RRV["+$('#txtselectedrno').val()+"] ["+$('#txtselecteddocs').val()+"] CHEQUE POSTING on "+$('#date').val()+"");
		    $("#postingJV").jqxGrid('setcellvalue', 1, "description", "RRV["+$('#txtselectedrno').val()+"] ["+$('#txtselecteddocs').val()+"] CHEQUE POSTING on "+$('#date').val()+"");
		  }
			
			 if($('#cmbtype').val()=='4'){
				getCardCommSeparate();
				 
				$("#overlay, #PleaseWait").show();
				
				var rows = $('#postingJV').jqxGrid('getrows');
		    	var rowlength= rows.length;
		    	if(rowlength==0){
		    		if($('#txtbipostingcardcomm').val().trim()=="0"){
						$("#postingJV").jqxGrid('addrow', null, {});
		  	    		$("#postingJV").jqxGrid('addrow', null, {});
		  	    		$("#postingJV").jqxGrid('addrow', null, {});
		    		}else{
		    			$("#postingJV").jqxGrid('addrow', null, {});
		    			$("#postingJV").jqxGrid('addrow', null, {});
		    		}
		    	}
				$("#postingJV").jqxGrid({ disabled: false});
					
				var rows = $("#postingRefundGrid").jqxGrid('getrows');
				var paytype = $('#cmbtype').val();
				
				if(rows.length==1 && (rows[0].netamt=="undefined" || rows[0].netamt==null || rows[0].netamt=="")){
					return false;
				}
				
				var selectedrows=$("#postingRefundGrid").jqxGrid('selectedrowindexes');
				selectedrows = selectedrows.sort(function(a,b){return a - b});
				
				if(selectedrows.length==0){
					$("#overlay, #PleaseWait").hide();
					$.messager.alert('Warning','Select Cards to be Calculated.');
					return false;
				}
				
				var comm="",q=0;
				var cardtyperows = $("#cardCommGrid").jqxGrid('getrows');
				for (var c = 0; c < rows.length; c++) {
					if(selectedrows[q]==c){
						
					 for (var f = 0; f < cardtyperows.length; f++) {
						 if(rows[c].cardtype==cardtyperows[f].mode){
							comm= cardtyperows[f].commission;
							break;
						 }
					 }
					 
					 $("#postingRefundGrid").jqxGrid('setcellvalue', c, "cardtypecomm", comm);
					 q++;
					}
				 }
				
				var i=0;var temp="",tempdocs="",temprno="";
		        $('#gridlength').val(selectedrows.length);
		        var j=0;
			    for (i = 0; i < rows.length; i++) {
						if(selectedrows[j]==i){
							cardCommission(rows[i].cardtype,rows[i].netamt,paytype,rows[i].cardtypecomm,i,selectedrows.length);
							if(i==0){
								temp=rows[i].tr_no;
								tempdocs=rows[i].documentno;
								temprno=rows[i].srno;
							}
							else{
								temp=temp+"::"+rows[i].tr_no;
								tempdocs=tempdocs+","+rows[i].documentno;
								temprno=temprno+","+rows[i].srno;
							}
							temp1=temp+"::";
							tempdocs1=tempdocs+",";
							temprno1=temprno+",";
						j++; 
					  }
		            }
				  }
		
	      $('#txttrno').val(temp1);
	      $('#txtselecteddocs').val(tempdocs1);
	      $('#txtselectedrno').val(temprno1);
	      $("#overlay, #PleaseWait").hide();
		  $('#postingCashGrid').jqxGrid({ sortable: true});
		  $('#postingCardGrid').jqxGrid({ sortable: true});
		  $('#postingChequeGrid').jqxGrid({ sortable: true});
		  $('#postingRefundGrid').jqxGrid({ sortable: true});
			
		}
	
		function cardCommission(cardtype,netamt,paytype,comm,i,length){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
					{
					 items= x.responseText;
					 items=items.split(":");
					 
					 var amount=items[0];
					 var commission=items[1];
					 var index=items[2];
					 var paytype=items[3];
					 
					 if(paytype==2){
					  		$("#postingCardGrid").jqxGrid('setcellvalue', index, "commission", commission);
					  		$("#postingCardGrid").jqxGrid('setcellvalue', index, "amountcomm", amount);
					 }else if(paytype==4){
						  	$("#postingRefundGrid").jqxGrid('setcellvalue', index, "commission", commission);
						  	$("#postingRefundGrid").jqxGrid('setcellvalue', index, "amountcomm", amount);
					}
					 
					}
				else
					{
					}
			}
			x.open("GET","getCommissionAmount.jsp?cardtype="+cardtype+"&netamt="+netamt+"&paytype="+paytype+"&comm="+comm+"&index="+i,true);
			x.send();
		}

	
      function funClearInfo(){

    	 $('#cmbbranch').val('a');
    	 $('#fromdate').val(new Date());
    	 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		 $('#todate').val(new Date());
		 $('#date').val(new Date());
		 
		 document.getElementById("hidchckibbranch").value = 0;
		 if(document.getElementById("hidchckibbranch").value==0){
			 document.getElementById("chckibbranch").checked = false;
		 }
		 $('#txtibbranchid').val('');$('#txtibbranch').val('');
		 $('#txtibbranch').attr('disabled', true );
		 
		document.getElementById("hidfromdate").value="";document.getElementById("hidtodate").value="";document.getElementById("cmbtype").value="";
		document.getElementById("hidcmbtype").value="";document.getElementById("txttypedocno").value="";document.getElementById("txttypeaccid").value="";
		document.getElementById("txttypeaccname").value="";document.getElementById("txttypeatype").value="";document.getElementById("txttypecurid").value="";
		document.getElementById("txttyperate").value="";document.getElementById("txttypetype").value="";document.getElementById("txtaccid").value="";
		document.getElementById("txtaccname").value="";document.getElementById("txtdocno").value="";document.getElementById("txtatype").value="";
		document.getElementById("txtcurid").value="";document.getElementById("txtrate").value="";document.getElementById("txtcurtype").value="";
		document.getElementById("txtcommaccid").value="";document.getElementById("txtcommaccname").value="";document.getElementById("txtcommdocno").value="";
		document.getElementById("txtcommatype").value="";document.getElementById("txtcommcurid").value="";document.getElementById("txtcommrate").value="";
		document.getElementById("txtcommtype").value="";document.getElementById("txtcommcosttype").value="";document.getElementById("txtcommcostcode").value="";
		document.getElementById("txtdrtotal").value="";document.getElementById("txtcrtotal").value="";
		document.getElementById("txttrno").value="";document.getElementById("gridlength").value="";document.getElementById("jvgridlength").value="";
		document.getElementById("jvgridlength").value="";document.getElementById("mode").value="";document.getElementById("msg").value="";
		
		$("#cardCommGrid").jqxGrid('clear');$("#cardCommGrid").jqxGrid({ disabled: true});
		$("#postingJV").jqxGrid('clear');$("#postingJV").jqxGrid({ disabled: true});
		$("#postingCashGrid").jqxGrid('clear');$("#postingCashGrid").jqxGrid('addrow', null, {});$("#postingCashGrid").jqxGrid('clearselection');
		$("#postingCardGrid").jqxGrid('clear');$("#postingCardGrid").jqxGrid('addrow', null, {});$("#postingCardGrid").jqxGrid('clearselection');
		$("#postingChequeGrid").jqxGrid('clear');$("#postingChequeGrid").jqxGrid('addrow', null, {});$("#postingChequeGrid").jqxGrid('clearselection');
		$("#postingRefundGrid").jqxGrid('clear');$("#postingRefundGrid").jqxGrid('addrow', null, {});$("#postingRefundGrid").jqxGrid('clearselection');
		
		 if (document.getElementById("txtaccid").value == "") {
		        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
		  }
		 
		 if (document.getElementById("txtibbranch").value == "") {
		        $('#txtibbranch').attr('placeholder', 'Press F3 to Search'); 
		  }
		
		 $('#txtdrtotal').val('0.00');$('#txtcrtotal').val('0.00');
		}
      
      function funGridType(){

     	 var paytype = $('#cmbtype').val();
     	// alert("paytype   "+paytype); 
     	$("#postingJV").jqxGrid('clear');$("#postingJV").jqxGrid({ disabled: true});
		
 		 if(paytype==2){
 		       	$("#postingCardDiv").prop("hidden", false);
 		        $("#postingCashDiv").prop("hidden", true);
 		        $("#postingChequeDiv").prop("hidden", true);
 		        $("#postingRefundDiv").prop("hidden", true);
				
				$("#cardCommGrid").jqxGrid({ disabled: false});
 			    $("#commissionDiv").load("cardCommDetailsGrid.jsp?paytype="+paytype+"&check=1");
				
 		 }else if(paytype==3){
 			    $("#postingChequeDiv").prop("hidden", false);
 		        $("#postingCashDiv").prop("hidden", true);
 		        $("#postingCardDiv").prop("hidden", true);
 		        $("#postingRefundDiv").prop("hidden", true);
				
				$("#cardCommGrid").jqxGrid('clear');
 		        $("#cardCommGrid").jqxGrid({ disabled: true});
				
 		 }else if(paytype==4){
 				$("#postingRefundDiv").prop("hidden", false);
 		        $("#postingCashDiv").prop("hidden", true);
 		        $("#postingCardDiv").prop("hidden", true);
 		        $("#postingChequeDiv").prop("hidden", true);
 		       
 		        $("#cardCommGrid").jqxGrid({ disabled: false});
			    $("#commissionDiv").load("cardCommDetailsGrid.jsp?paytype="+paytype+"&check=1");
 		       
 		 }else{
 			    $("#postingCashDiv").prop("hidden", false);
 			    $("#postingCardDiv").prop("hidden", true);
 			    $("#postingChequeDiv").prop("hidden", true);
 			    $("#postingRefundDiv").prop("hidden", true);
				
				$("#cardCommGrid").jqxGrid('clear');
 		        $("#cardCommGrid").jqxGrid({ disabled: true});
				
 		     }
 		
 		}
      
      function funNotify(){	
	    	
    	  var paytype = $('#cmbtype').val();
    	  // alert("in "+paytype);  
    	  if($('#cmbbranch').val()=='a'){
 			 $.messager.alert('Message','Please Choose a Specific Main-Branch.','warning');
 			 return 0;
 		 }
    	  
    	  var date = $('#fromdate').jqxDateTimeInput('getDate');
  		  var validdate=funDateInPeriod(date);
  		  if(parseInt(validdate)==0){
			$.messager.alert('Message','Transaction prior or after Account Period is not valid.','warning');
			return 0;	
		  }
      
  	      var date = $('#todate').jqxDateTimeInput('getDate');
  		  var validdate=funDateInPeriod(date);
  		  if(parseInt(validdate)==0){
			$.messager.alert('Message','Transaction prior or after Account Period is not valid.','warning');
			return 0;	
		  }
      
  	      var date = $('#date').jqxDateTimeInput('getDate');
  		  var validdate=funDateInPeriod(date);
  		  if(parseInt(validdate)==0){
			$.messager.alert('Message','Transaction prior or after Account Period is not valid.','warning');
			return 0;	
		  }
  		
    	  if(($('#hidchckibbranch').val()=='1') && ($('#txtibbranchid').val()=='')){
 			 $.messager.alert('Message','Please Choose Inter-Branch & Then Post.','warning');
 			 return 0;
 		  }
		  
		var drtot = document.getElementById("txtdrtotal").value;
	 	var crtot = document.getElementById("txtcrtotal").value;
	 	
		if(drtot>crtot || drtot<crtot){
	 		$.messager.alert('Message','Invalid Transaction !!! Credit and Debit should be Equal.','warning');
            return 0;
	 	}
	 		
	 	if(drtot=="" || crtot=="" || drtot=="NaN" || crtot=="NaN" || drtot==0 || crtot==0 || drtot==0.0 || crtot==0.0 || drtot==0.00 || crtot==0.00){
	 	    $.messager.alert('Message','Invalid Transaction !!! Credit and Debit should not be Zero.','warning');
	        return 0;
		}
      	  
    	  if(paytype==1){
	          
	      	   var selectedrows=$("#postingCashGrid").jqxGrid('selectedrowindexes');
	         
		  	   if(selectedrows.length==0){
		  			$.messager.alert('Warning','Select Items,Calculate & then Post.');
		  			return false;
		  	   }
   		   }
   		 
   		 if(paytype==2){
	    	
	      	   var selectedrows=$("#postingCardGrid").jqxGrid('selectedrowindexes');
	         
		  	   if(selectedrows.length==0){
		  			$.messager.alert('Warning','Select Cards,Calculate & then Post.');
		  			return false;
		  	   }
   		 
   		 }
   		 
   		 if(paytype==3){
	          
	      	   var selectedrows=$("#postingChequeGrid").jqxGrid('selectedrowindexes');
	         
		  	   if(selectedrows.length==0){
		  			$.messager.alert('Warning','Select Items,Calculate & then Post.');
		  			return false;
		  	   }
 		   }
   		 
		 if(paytype==4){
	          
	      	   var selectedrows=$("#postingRefundGrid").jqxGrid('selectedrowindexes');
	         
		  	   if(selectedrows.length==0){
		  			$.messager.alert('Warning','Select Cards,Calculate & then Post.');
		  			return false;
		  	   }
 		   }

	  	   var jvrows = $("#postingJV").jqxGrid('getrows');
	  	   if(jvrows.length>0 && (jvrows[0].baseamount=="undefined" || jvrows[0].baseamount==null || jvrows[0].baseamount=="")){
	  			$.messager.alert('Warning','Select Items,Calculate & then Post.');
	  			return false;
	  	   }
   		  
  		   $.messager.confirm('Confirm', 'Do you want to Post?', function(r){
  	 		if (r){
  	 				
	    	/* Journal Voucher Grid Saving */
	    	 var rows = $("#postingJV").jqxGrid('getrows');
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
					
				var amount="0",baseamount="0",id="1";
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
				
				var costtype="0";var costcode="0";
				if($('#cmbtype').val()=='2') {
					if($('#txtcommdocno').val()==rows[i].docno){
						costtype=$('#txtcommcosttype').val();costcode=$('#txtcommcostcode').val();
					}
				}
				
				if($('#hidchckibbranch').val()==0){
					newTextBox.val(rows[i].docno+"::"+rows[i].description+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+amount+"::"+baseamount+"::"+rows[i].sr_no+"::"+id+"::"+costtype+"::"+costcode+"");
				} else if($('#hidchckibbranch').val()==1){
					newTextBox.val(rows[i].docno+"::"+rows[i].description+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+amount+"::"+baseamount+"::"+id+"::"+costtype+"::"+costcode+"");
				}
				newTextBox.appendTo('form');
				}
			 }
			 $('#jvgridlength').val(length);
	 		/* Journal Voucher Grid Saving Ends */
	 		
			 document.getElementById("mode").value='A';
			 $("#overlay, #PleaseWait").show();
			 document.getElementById("frmDashboardPosting").submit();
			 
  	 		 }
  	 		});
  		 
    		return 1;
	} 
  
  
  function setValues(){
	 
	  document.getElementById("cmbtype").value=document.getElementById("hidcmbtype").value;
	  
	  if($('#hidfromdate').val()){
			 $("#fromdate").jqxDateTimeInput('val', $('#hidfromdate').val());
		  }

	  if($('#hidtodate').val()){
			 $("#todate").jqxDateTimeInput('val', $('#hidtodate').val());
		  }
	  
	  if($('#hiddate').val()){
			 $("#date").jqxDateTimeInput('val', $('#hiddate').val());
		  }
	  
	  if(document.getElementById("hidchckibbranch").value==1){
			 document.getElementById("chckibbranch").checked = true;
		 }
		 else if(document.getElementById("hidchckibbranch").value==0){
			 document.getElementById("chckibbranch").checked = false;
		 }
	  
	  if($('#msg').val()!=""){
		 $.messager.alert('Message',$('#msg').val());
		 getNonTaxableEntity();
		 funGridType();
		 funreload(event);
		 getAccounts($('#hidcmbtype').val(),$('#todate').val());
		 getCommissionAccounts($('#hidcmbtype').val(),$('#todate').val());
		 if(parseInt($('#txtnontaxableentity').val().trim())==1){
		 	getTaxAccounts($('#hidcmbtype').val(),$('#date').val());
		 }
		 
	 }
	  $('#txtdrtotal').val('0.00');$('#txtcrtotal').val('0.00');
	}
	
	function funExportBtn(){
		var type=$('#cmbtype').val();
		if(type=='1'){ 
			if(parseInt(window.parent.chkexportdata.value)=="1") {
				JSONToCSVCon(data, 'Posting', true);
			 } else {
				 $("#postingCashGrid").jqxGrid('exportdata', 'xls', 'Posting');
			 }
		}
		
		if(type=='2'){ 
			if(parseInt(window.parent.chkexportdata.value)=="1") {
				JSONToCSVCon(data, 'Posting', true);
			 } else {
				 $("#postingCardGrid").jqxGrid('exportdata', 'xls', 'Posting');
			 }
		}
		
		if(type=='3'){ 
			if(parseInt(window.parent.chkexportdata.value)=="1") {
				JSONToCSVCon(data, 'Posting', true);
			 } else {
				 $("#postingChequeGrid").jqxGrid('exportdata', 'xls', 'Posting');
			 }
		}
		
		if(type=='4'){ 
			if(parseInt(window.parent.chkexportdata.value)=="1") {
				JSONToCSVCon(data, 'Posting', true);
			 } else {
				 $("#postingRefundGrid").jqxGrid('exportdata', 'xls', 'Posting');
			 }
		}
	}

</script>
</head>
<body onload="getBranch();setValues();ibbranchcheck();getCardCommSeparate();getNonTaxableEntity();">
<form id="frmDashboardPosting" action="saveDashboardPosting" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<div class="master-container">
    <div class="sidebar-filters">
        <div class="sidebar-fixed-top">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>

        <div class="sidebar-scroll-content">
            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Period</td>
                        <td>
                            <div id="fromdate" name="fromdate" onchange="fromdatechange();" value='<s:property value="fromdate"/>'></div>
                            <input type="hidden" id="hidfromdate" name="hidfromdate" value='<s:property value="hidfromdate"/>'/>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">To</td>
                        <td>
                            <div id="todate" name="todate" onchange="todatechange();" value='<s:property value="todate"/>'></div>
                            <input type="hidden" id="hidtodate" name="hidtodate" value='<s:property value="hidtodate"/>'/>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Post Br.</td>
                        <td>
                            <input type="text" id="txtibbranch" name="txtibbranch" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtibbranch"/>' onkeydown="getIbBranch(event);"/>
                            <div style="margin-top: 5px; display: flex; align-items: center; gap: 5px;">
                                <input type="checkbox" id="chckibbranch" name="chckibbranch" value="" onchange="ibbranchcheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)" />
                                <label class="branch" style="font-size: 11px;">Active</label>
                            </div>
                            <input type="hidden" id="txtibbranchid" name="txtibbranchid" value='<s:property value="txtibbranchid"/>'/>
                            <input type="hidden" id="hidchckibbranch" name="hidchckibbranch" value='<s:property value="hidchckibbranch"/>'/>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Type</td>
                        <td>
                            <select id="cmbtype" name="cmbtype" onchange="funGridType();clearAccountInfo();getCommissionAccounts(this.value,$('#todate').val());getAccounts(this.value,$('#todate').val());getTaxAccounts(this.value,$('#date').val());" value='<s:property value="cmbtype"/>'>
                                <option value="">--Select--</option>
                                <option value="1">Cash</option>
                                <option value="2">Card</option>
                                <option value="3">Cheque/Online</option>
                                <option value="4">Paid to Card</option>
                            </select>
                            <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Account</td>
                        <td>
                            <input type="text" id="txttypeaccid" name="txttypeaccid" readonly="readonly" value='<s:property value="txttypeaccid"/>' tabindex="-1"/>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>
                            <input type="text" id="txttypeaccname" name="txttypeaccname" readonly="readonly" value='<s:property value="txttypeaccname"/>' tabindex="-1"/>
                            <input type="hidden" id="txttypedocno" name="txttypedocno" value='<s:property value="txttypedocno"/>'/>
                            <input type="hidden" id="txttypeatype" name="txttypeatype" value='<s:property value="txttypeatype"/>'/>
                            <input type="hidden" id="txttypecurid" name="txttypecurid" value='<s:property value="txttypecurid"/>'/>
                            <input type="hidden" id="txttyperate" name="txttyperate" value='<s:property value="txttyperate"/>'/>
                            <input type="hidden" id="txttypetype" name="txttypetype" value='<s:property value="txttypetype"/>'/>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="filter-card">
                <span class="branch" style="display:block; margin-bottom:8px; text-align:center;">Card Commission</span>
                <div id="commissionDiv"><jsp:include page="cardCommDetailsGrid.jsp"></jsp:include></div>
            </div>

            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Bank</td>
                        <td>
                            <input type="text" id="txtaccid" name="txtaccid" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>' onkeydown="getAccType(event);"/>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>
                            <input type="text" id="txtaccname" name="txtaccname" readonly="readonly" value='<s:property value="txtaccname"/>' tabindex="-1"/>
                            <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
                            <input type="hidden" id="txtatype" name="txtatype" value='<s:property value="txtatype"/>'/>
                            <input type="hidden" id="txtcurid" name="txtcurid" value='<s:property value="txtcurid"/>'/>
                            <input type="hidden" id="txtrate" name="txtrate" value='<s:property value="txtrate"/>'/>
                            <input type="hidden" id="txtcurtype" name="txtcurtype" value='<s:property value="txtcurtype"/>'/>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Posting</td>
                        <td>
                            <div id="date" name="date" onchange="datechange();" value='<s:property value="date"/>'></div>
                            <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'/>
                        </td>
                    </tr>
                </table>
            </div>

            <div style="padding: 0 5px;">
                <input type="button" class="myButtons" name="clear" id="clear" value="Clear" onclick="funClearInfo();">
                <button class="myButton" type="button" id="btnGenerate" name="btnGenerate" onclick="funNotify();">Post</button>
            </div>

            <input type="hidden" id="txtcommdocno" value='<s:property value="txtcommdocno"/>'/>
            <input type="hidden" id="txtcommaccid" value='<s:property value="txtcommaccid"/>'/>
            <input type="hidden" id="txtcommaccname" value='<s:property value="txtcommaccname"/>'/>
            <input type="hidden" id="txtcommatype" value='<s:property value="txtcommatype"/>'/>
            <input type="hidden" id="txtcommcurid" value='<s:property value="txtcommcurid"/>'/>
            <input type="hidden" id="txtcommrate" value='<s:property value="txtcommrate"/>'/>
            <input type="hidden" id="txtcommtype" value='<s:property value="txtcommtype"/>'/>
            <input type="hidden" id="txtcommcosttype" value='<s:property value="txtcommcosttype"/>'/>
            <input type="hidden" id="txtcommcostcode" value='<s:property value="txtcommcostcode"/>'/>
            <input type="hidden" id="txttaxaccdocno" value='<s:property value="txttaxaccdocno"/>'/>
            <input type="hidden" id="txttaxaccid" value='<s:property value="txttaxaccid"/>'/>
            <input type="hidden" id="txttaxaccname" value='<s:property value="txttaxaccname"/>'/>
            <input type="hidden" id="txttaxaccatype" value='<s:property value="txttaxaccatype"/>'/>
            <input type="hidden" id="txttaxacccurid" value='<s:property value="txttaxacccurid"/>'/>
            <input type="hidden" id="txttaxaccrate" value='<s:property value="txttaxaccrate"/>'/>
            <input type="hidden" id="txttaxacccurtype" value='<s:property value="txttaxacccurtype"/>'/>
            <input type="hidden" id="txttaxacccosttype" value='<s:property value="txttaxacccosttype"/>'/>
            <input type="hidden" id="txttaxacccostcode" value='<s:property value="txttaxacccostcode"/>'/>
            <input type="hidden" id="txttaxpercentage" value='<s:property value="txttaxpercentage"/>'/>
            <input type="hidden" id="txtchequedescription" value='<s:property value="txtchequedescription"/>'/>
            <input type="hidden" id="gridlength" name="gridlength"/>
            <input type="hidden" id="jvgridlength" name="jvgridlength"/>
            <input type="hidden" name="txttrno" id="txttrno" value='<s:property value="txttrno"/>'>
            <input type="hidden" name="txtselecteddocs" id="txtselecteddocs" value='<s:property value="txtselecteddocs"/>'>
            <input type="hidden" name="txtselectedrno" id="txtselectedrno" value='<s:property value="txtselectedrno"/>'>
            <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
            <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
            <input type="hidden" id="txtibvalidation" value='<s:property value="txtibvalidation"/>'/>
            <input type="hidden" name="txtbipostingcardcomm" id="txtbipostingcardcomm" value='<s:property value="txtbipostingcardcomm"/>'>
            <input type="hidden" name="txtnontaxableentity" id="txtnontaxableentity" value='<s:property value="txtnontaxableentity"/>'>
        </div>
    </div>

    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="postingCashDiv"><jsp:include page="postingCashGrid.jsp"></jsp:include></div>
            <div id="postingCardDiv" hidden="true"><jsp:include page="postingCardGrid.jsp"></jsp:include></div>
            <div id="postingChequeDiv" hidden="true"><jsp:include page="postingChequeGrid.jsp"></jsp:include></div>
            <div id="postingRefundDiv" hidden="true"><jsp:include page="postingRefundGrid.jsp"></jsp:include></div>
            
            <br/>
            <div id="JVTDiv"><jsp:include page="journalVoucherGrid.jsp"></jsp:include></div>
            
            <br/>
            <div class="filter-card">
                <table width="100%">
                    <tr>
                        <td width="15%" align="right" style="font-family: Myriad Pro; font-size: 12px; font-weight: bold;">Dr. Total :&nbsp;</td>
                        <td width="35%"><input type="text" id="txtdrtotal" name="txtdrtotal" class="textbox" style="width:100%; text-align: right;" readonly="readonly" value='<s:property value="txtdrtotal"/>'/></td>
                        <td width="15%" align="right" style="font-family: Myriad Pro; font-size: 12px; font-weight: bold;">Cr. Total :&nbsp;</td>
                        <td width="35%"><input type="text" id="txtcrtotal" name="txtcrtotal" class="textbox" style="width:100%; text-align: right;" readonly="readonly" value='<s:property value="txtcrtotal"/>' tabindex="-1"/></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>
</div>

<div id="accountDetailsWindow">
	<div></div><div></div>
</div>
<div id="branchSearchWindow">
	<div></div><div></div>
</div>
</div>
</form> 
</body>
</html>