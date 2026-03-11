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

.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', Tahoma, sans-serif;
    background-color: #f4f7f9;
}

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

.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

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

</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '60%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 $('#multiSearchWindow').jqxWindow({width: '50%', height: '55%',  maxHeight: '55%' ,maxWidth: '50%' , title: 'Ticket  Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#multiSearchWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		
	     var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	     $("#postingJV").jqxGrid({ disabled: true});
	     
		  $('#date').on('change', function (event) {
			  
		        var maindate = $('#date').jqxDateTimeInput('getDate');
		      
		        funDateInPeriod(maindate);
		    
		       });
	     
	     
	     $('#txttypeaccid').dblclick(function(){
	 		 if(document.getElementById("cmbtype").value!=""){
	  		  
			  $('#accountDetailsWindow').jqxWindow('open');
			 commenSearchContent('accountsDetailsSearch.jsp?cmbtype='+document.getElementById("cmbtype").value);
	 		 }
	 		 
	 		 else
	 			 {
	 			 
	 			 $.messager.alert('Message','Select Type.','warning');
				 return 0;
	 			 }
				        
		  }); 
	     
	     
	/*      
	     $('#EnquiryDate').on('change', function (event) {
	         var maindate = $('#EnquiryDate').jqxDateTimeInput('getDate');
	   	 	 if ($("#mode").val() == "A" || $('#mode').val()=="E" ) {   
	      funDateInPeriod(maindate);
	     	 } 
			   */
	     
	     $('#btnticketadd').click(function(){
		 	if(document.getElementById("chkticketno").checked==true){
				var branch=$('#cmbbranch').val();
				var fromdate=$('#fromdate').jqxDateTimeInput('val');
				var todate=$('#todate').jqxDateTimeInput('val');
				var type=$('#cmbtype').val();
				var acno=$('#txtaccid').val();
				$('#multiSearchWindow').jqxWindow('open');
				$('#multiSearchWindow').jqxWindow('focus');
			 	multiSearchContent('multiSearchMaster.jsp?branch='+branch+'&fromdate='+fromdate+'&todate='+todate+'&type='+type+'&acno='+acno);
			}
		 });
	});
	
	
	

	function commenSearchContent(url) {
	 	 //alert(url);
	 		 $.get(url).done(function (data) {
	 			 
	 			 $('#accountDetailsWindow').jqxWindow('open');
	 		$('#accountDetailsWindow').jqxWindow('setContent', data);
	 
	 	}); 
	 	} 	
  function multiSearchContent(url) {
	 		 $.get(url).done(function (data) {
	 			$('#multiSearchWindow').jqxWindow('setContent', data);
	 
	 	}); 
	 	} 	
 
   function funExportBtn(){
		 
		 
		 if(parseInt(window.parent.chkexportdata.value)=="1")
		  {
		  	JSONToCSVCon(data1, 'Traffic-Posting', true);
		  }
		 else
		  {
		                 
			 $("#jqxFleetGrid").jqxGrid('exportdata', 'xls', 'Traffic-Posting');
		  }
		 
	}
	function  getacc(event){
	 	 var x= event.keyCode;
	 	 if(x==114){
	 		 
	 		 if(document.getElementById("cmbtype").value!=""){
	 			 
	 			 
	 		 
	 		
	 	  $('#accountDetailsWindow').jqxWindow('open');
	 	
	 	 commenSearchContent('accountsDetailsSearch.jsp?cmbtype='+document.getElementById("cmbtype").value);
	 	   }
	 		 else
	 			 {
	 			 $.messager.alert('Message','Select Type.','warning');
				 return 0;
	 			 
	 			 }
	 		 
		          }
	 		   
	 	 else{
	 		 }
	 	 }    

	/* function funSearchdblclick(){
		  $('#txtaccid').dblclick(function(){
			  accountsSearchContent('accountsDetailsSearch.jsp');
			  });
	}
	
	function getAccType(event){
        var x= event.keyCode;
        if(x==114){
      	  accountsSearchContent('accountsDetailsSearch.jsp');
        }
        else{
         }
        }
	 */
	    


	
	
	function funreload(event){
		
		 var branchval = document.getElementById("cmbbranch").value;
		 
		 if(branchval=="a")
			 {
			 $.messager.alert('Message','Choose A Specific Branch.','warning');
			 return 0;
			 }
		 
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var paytype = $('#cmbtype').val();
		 var txttypeaccid = $('#txttypeaccid').val();
		 
			var maindate = $('#date').jqxDateTimeInput('getDate');
			   var validdate=funDateInPeriod(maindate);
			   if(validdate==0){
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
		 
		 
		 if(txttypeaccid==''){
			 $.messager.alert('Message','Search Account.','warning');
			 return 0;
		 }
		  $("#postingJV").jqxGrid('clear');
		 $("#overlay, #PleaseWait").show();

		 
			var ticketno=$('#hidticketno').val();
	
			 $("#postingCashDiv").load("postingTrafficgrid.jsp?fromdate="+fromdate+'&todate='+todate+'&chk='+"GO&ticketno="+ticketno);
		
		 
		}
	
	function funCalculate(){
		
	
		 var branchval = document.getElementById("cmbbranch").value;
 		 var txttypeaccid = document.getElementById("txttypeaccid").value;
 		 
 		 if(branchval=="a")
 			 {
 			 $.messager.alert('Message','Choose A Specific Branch.','warning');
 			 return 0;
 			 }
 		var maindate = $('#date').jqxDateTimeInput('getDate');
		   var validdate=funDateInPeriod(maindate);
		   if(validdate==0){
		   return 0; 
		   }
 		if($('#cmbtype').val()==''){
			 $.messager.alert('Message','Please Choose Type.','warning');
			 return 0;
		 }
		
			 if(txttypeaccid==''){
				 $.messager.alert('Message','Search Account.','warning');
				 return 0;
			 }
			 
	  	  document.getElementById("calcu").value=1;
		
	/* 	if($('#txtdocno').val()==''){
			 $.messager.alert('Message','Please Choose Bank Account & Then Calculate.','warning');
			 return 0;
		 } */
	  	var rows = $('#postingJV').jqxGrid('getrows');
	     var rowlength= rows.length;
	  if(rowlength!=0){
	   $.messager.alert('Message','Already calculated.Submit Again. ','warning');
	   return 0;
	  } else{
	   $("#postingJV").jqxGrid('clear');
	  }
	/* 	$("#postingJV").jqxGrid('clear'); */
		
		var temp1="";
		


			
			$("#overlay, #PleaseWait").show();
			var selectedrows=$("#jqxFleetGrid").jqxGrid('selectedrowindexes');
			 
			if(selectedrows.length==0){
				$("#overlay, #PleaseWait").hide();
				$.messager.alert('Warning','Select Items to be Calculated.');
				return false;
			}
			
			
			var rows = $('#postingJV').jqxGrid('getrows');
	    	var rowlength= rows.length;
			if(rowlength==0){
				$("#postingJV").jqxGrid('addrow', null, {});
	  	    	$("#postingJV").jqxGrid('addrow', null, {});
	    	}
			$("#postingJV").jqxGrid({ disabled: false});
				
			var rows = $("#jqxFleetGrid").jqxGrid('getrows');
			
			if(rows.length==1 && (rows[0].amount=="undefined" || rows[0].amount==null || rows[0].amount=="")){
				return false;
			}
			
			var selectedrows=$("#jqxFleetGrid").jqxGrid('selectedrowindexes');
			selectedrows = selectedrows.sort(function(a,b){return a - b});
			if(selectedrows.length==0){
				$("#overlay, #PleaseWait").hide();
				$.messager.alert('Warning','Select Items to be Calculated.');
				return false;
			}
			
			var i=0;var temp="";
	        $('#gridlength').val(selectedrows.length);
	        var j=0;
	        var k=0;
		    for (i = 0; i < rows.length; i++) {
					if(selectedrows[j]==i){
						$("#jqxFleetGrid").jqxGrid('setcellvalue', i, "totalamount", $('#jqxFleetGrid').jqxGrid('getcellvalue', i, "amount"));
						if(k==0){
							k=10;
							temp=rows[i].ticket_no;
						}
						else{
							temp=temp+"::"+rows[i].ticket_no;
						}
						temp1=temp;
					j++; 
				  }
	            }
		  
		

		
	      $('#txttrno').val(temp1);
	      $("#overlay, #PleaseWait").hide();
		/*   $('#postingCardGrid').jqxGrid({ sortable: true}); */
			
		}
	
		/* function cardCommission(cardtype,netamt,paytype,i,length){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
					{
					 items= x.responseText;
					 items=items.split(":");
					 
					 var amount=items[0];
					 var commission=items[1];
					 var index=items[2];
					 
					  $("#postingCardGrid").jqxGrid('setcellvalue', index, "commission", commission);
					  $("#postingCardGrid").jqxGrid('setcellvalue', index, "amountcomm", amount);
					 
					}
				else
					{
					}
			}
			x.open("GET","getCommissionAmount.jsp?cardtype="+cardtype+"&netamt="+netamt+"&paytype="+paytype+"&index="+i,true);
			x.send();
		}
	 */
     
      
  /*     function funGridType(){

     	 var paytype = $('#cmbtype').val();
     	 
     	$("#postingJV").jqxGrid('clear');$("#postingJV").jqxGrid({ disabled: true});
		
 		 if(paytype==2){
 		       	$("#postingCardDiv").prop("hidden", false);
 		        $("#postingCashDiv").prop("hidden", true);
 		 }else{
 			    $("#postingCashDiv").prop("hidden", false);
 			    $("#postingCardDiv").prop("hidden", true);
 		 }
 		
 		} */
 		
 		
 		
 		
 		function getAccounts(){
 			//txttypeaccid txttypeaccname
 			document.getElementById("txttypeaccid").value="";
 			
 			document.getElementById("txttypeaccname").value="";
 			
 			
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
 	  				//txtaccid txtaccname txtdocno txtatype txtcurid txtrate txtcurtype
 	  			    $('#txtdocno').val(docNoItems);	
 	  			    $('#txtaccid').val(accountIdItems);
 	  			    $('#txtaccname').val(accountItems);
 	  			  	$('#txtatype').val(accountTypeItems);
 				    $('#txtcurid').val(accountCurIdItems);
 				    $('#txtrate').val(accountRateItems);
 				    $('#txtcurtype').val(accCurrTypeItems);
 	  		}
 	  		}
 	  		x.open("GET", "getAccounts.jsp?paytype="+$('#fromdate').val(), true);
 	  		x.send();
 	 }
 		
      
      function funNotify(){	
    		var maindate = $('#todate').jqxDateTimeInput('getDate');
			   var validdate=funDateInPeriod(maindate);
			   if(validdate==0){
		
			   return 0; 
			   }
 	 
		    	 if(document.getElementById("calcu").value=="")
		    		 
		    		 {
		    		 
		    		 $.messager.alert('Warning','Calculate & then Generate.');
			  			return false;
		    		 
		    		 }
		    	
		 
		    	 
		    	 
    	  var paytype = $('#cmbtype').val();
      	 
 		 if(paytype==""){
	    	  var rows = $("#jqxFleetGrid").jqxGrid('getrows');                    
	      	  if(rows.length>0 && (rows[0].netamt=="undefined" || rows[0].netamt==null || rows[0].netamt=="")){
	      		return false;
	      	  }
	      	  
	      	
	 		 var branchval = document.getElementById("cmbbranch").value;
	 		 var txttypeaccid = document.getElementById("txttypeaccid").value;
	 		 
	 		 if(branchval=="a")
	 			 {
	 			 $.messager.alert('Message','Choose A Specific Branch.','warning');
	 			 return 0;
	 			 }
	        	 if(paytype==''){
					 $.messager.alert('Message','Please Choose Type.','warning');
					 return 0;
				 }
				 if(txttypeaccid==''){
					 $.messager.alert('Message','Search Account.','warning');
					 return 0;
				 }
				 
	      	  
	      	   var selectedrows=$("#jqxFleetGrid").jqxGrid('selectedrowindexes');
	         
		  	   if(selectedrows.length==0){
		  			$.messager.alert('Warning','Select Items,Calculate & then Generate.');
		  			return false;
		  	   }
 		 }
   		
   		 
	  /* 	   var jvrows = $("#postingJV").jqxGrid('getrows');
	  	   if(jvrows.length>0 && (jvrows[0].baseamount=="undefined" || jvrows[0].baseamount==null || jvrows[0].baseamount=="")){
	  			$.messager.alert('Warning','Select Cards,Calculate & then Generate.');
	  			return false;
	  	   } */
   		  
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
					
				var amount,baseamount,id;
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
				
				newTextBox.val(rows[i].docno+"::"+rows[i].description+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+amount+"::"+baseamount+"::0::"+id+":: :: ");
				newTextBox.appendTo('form');
				}
			 }
			 $('#jvgridlength').val(length);
	 		/* Journal Voucher Grid Saving Ends */
	 		
			 document.getElementById("mode").value='A';
			 $("#overlay, #PleaseWait").show();
			 document.getElementById("frmDashboardPostings").submit();
			 
  	 		 }
  	 		});
    		return 1;
	} 
  
      
    function funClearInfo()
    {

    	 
  	  document.getElementById("txttypeaccid").value="";

	  document.getElementById("txttypedocno").value="";
	  
	  
	  
	  document.getElementById("txttypeatype").value="";
	  document.getElementById("txttypecurid").value="";
	  
	  
	  document.getElementById("txttyperate").value ="";
	  
	  document.getElementById("txttypetype").value=""; 
	  document.getElementById("txttrno").value="";
	  document.getElementById("txtaccid").value=""; 
	  document.getElementById("txtaccname").value="";
	  
	  document.getElementById("txtdocno").value=""; 
	  document.getElementById("txtatype").value="";
	  document.getElementById("txtcurid").value=""; 
	  document.getElementById("txtrate").value="";
	  
	  document.getElementById("txtrate").value="";
	  
	  document.getElementById("txtcurtype").value="";
	  
document.getElementById("hidticketno").value="";
		document.getElementById("ticketdetails").value="";
    	
    	
    }
      
  
  function setValues(){
	 
	document.getElementById("cmbtype").value="";
	  
	  if($('#hidfromdate').val()){
			 $("#fromdate").jqxDateTimeInput('val', $('#hidfromdate').val());
		  }

	  if($('#hidtodate').val()){
			 $("#todate").jqxDateTimeInput('val', $('#hidtodate').val());
		  }
	  
	  if($('#hiddate').val()){
			 $("#date").jqxDateTimeInput('val', $('#hiddate').val());
		  }
	  
	  
	  
	  
	  if($('#msg').val()!=""){
		 $.messager.alert('Message',$('#msg').val());
		 
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 
	
			 $("#postingCashDiv").load("postingTrafficgrid.jsp?fromdate="+fromdate+'&todate='+todate+'&chk='+"GO");
		// funGridType();
		// funreload(event);
		// getAccounts($('#hidcmbtype').val());
		// getCommissionAccounts($('#hidcmbtype').val());
	 }
	  $('#txtdrtotal').val('0.00');$('#txtcrtotal').val('0.00');
	}
	
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmDashboardPostings" action="saveDbTrafficPosting" method="post">

<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<td width="20%" valign="top">

<fieldset class="filter-card scrollable-left">
<table width="100%" class="filter-table">

    <jsp:include page="../../heading.jsp"></jsp:include>

    <tr>
        <td class="label-cell">Period</td>
        <td>
            <div id="fromdate" name="fromdate"
                 value='<s:property value="fromdate"/>'></div>
            <input type="hidden" id="hidfromdate" name="hidfromdate"
                   value='<s:property value="hidfromdate"/>'>
        </td>
    </tr>

    <tr>
        <td class="label-cell">To</td>
        <td>
            <div id="todate" name="todate"
                 value='<s:property value="todate"/>'></div>
            <input type="hidden" id="hidtodate" name="hidtodate"
                   value='<s:property value="hidtodate"/>'>
        </td>
    </tr>

    <tr>
        <td class="label-cell">Type</td>
        <td>
            <select id="cmbtype"
                    name="cmbtype"
                    class="master-input"
                    onchange="getAccounts();"
                    value='<s:property value="cmbtype"/>'>
                <option value="">--Select--</option>
                <option value="1">Cash</option>
                <option value="2">Bank</option>
                <option value="3">GL</option>
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
                   placeholder="Press F3 To search"
                   value='<s:property value="txttypeaccid"/>'
                   onkeydown="getacc(event);">
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
        <td></td>
        <td>
            <input type="checkbox" id="chkticketno" name="chkticketno">
            <label for="chkticketno" class="branch">Ticket No</label>

            <button type="button"
                    id="btnticketadd"
                    class="btn-icon"
                    onclick="funTicketAdd();">+</button>

            <button type="button"
                    id="btnticketremove"
                    class="btn-icon"
                    onclick="funTicketRemove();">-</button>
        </td>
    </tr>

    <tr>
        <td colspan="2">
            <textarea id="ticketdetails"
                      class="master-textarea"
                      readonly></textarea>
        </td>
    </tr>

    <tr>
        <td class="label-cell">Post Date</td>
        <td>
            <div id="date" name="date"
                 value='<s:property value="date"/>'></div>
            <input type="hidden" id="hiddate" name="hiddate"
                   value='<s:property value="hiddate"/>'>
        </td>
    </tr>

    <tr>
        <td colspan="2" align="center">
            <button type="button"
                    class="btn-submit"
                    id="clear"
                    onclick="funClearInfo();">
                Clear
            </button>

            <button type="button"
                    class="btn-submit"
                    id="btnGenerate"
                    onclick="funNotify();">
                Post
            </button>
        </td>
    </tr>

    <tr>
        <td colspan="2">
            <input type="hidden" id="gridlength" name="gridlength">
            <input type="hidden" id="jvgridlength" name="jvgridlength">
            <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'>
            <input type="hidden" id="calcu" name="calcu" value='<s:property value="calcu"/>'>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
        </td>
    </tr>

</table>
</fieldset>

</td>

<td width="80%" valign="top">

<table width="100%">
<tr>
    <td>
        <div id="postingCashDiv">
            <jsp:include page="postingTrafficgrid.jsp"></jsp:include>
        </div>
    </td>
</tr>

<tr>
    <td>
        <div id="JVTDiv">
            <jsp:include page="journalVoucherGrid.jsp"></jsp:include>
        </div>
    </td>
</tr>

<tr>
<td>
<table width="100%">
<tr>
    <td align="right" style="font-weight:bold;">Dr. Total :</td>
    <td><input type="text" id="txtdrtotal" readonly class="textbox"></td>
    <td align="right" style="font-weight:bold;">Cr. Total :</td>
    <td><input type="text" id="txtcrtotal" readonly class="textbox"></td>
</tr>
</table>
</td>
</tr>
</table>

</td>
</tr>
</table>

<input type="hidden" id="hidticketno" name="hidticketno">

</div>

<div id="accountDetailsWindow"><div></div><div></div></div>
<div id="multiSearchWindow"><div></div><div></div></div>

</div>
</form>
</body>

</html>