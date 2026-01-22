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


</style>

<script type="text/javascript">

	$(document).ready(function () {
		
		 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"MM.yyyy"});
		 $("#postingDate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
		 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 $('#uptodate').focusout(function(){
			 getLastPayrollPostedDate();
		 });
		 
		 getLastPayrollPostedDate();
	});
	
	function getLastPayrollPostedDate(){
		var employeebranchchk=window.parent.employeebranchchk.value; 
 		var branch=document.getElementById("cmbbranch").value;  
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				 items = items.split('***');
  				 
  			     $('#uptodate').val(items[0]);
  			     document.getElementById("lbllastposted").innerText=items[1].trim();
  			}
		}
		x.open("GET", 'getLastPayrollPostedDate.jsp?branch='+branch+'&employeebranchchk='+employeebranchchk, true); 
		x.send();
	}
	
	function  funClearData(){
		$('#cmbbranch').val('a');$('#uptodate').val(new Date());$('#postingDate').val(new Date());$('#txtremarks').val('');$('#txtremarks').attr('placeholder', 'Remarks');
		$('#txtselectedemployees').val('');disable();$('#txtdrtotal').val('');$('#txtcrtotal').val('');
		$("#monthlyPayrollPostingGridID").jqxGrid('clearselection');$("#monthlyPayrollTotalGridID").jqxGrid('clear');
		$("#monthlyPayrollPostingGridID").jqxGrid('clear');$("#monthlyPayrollPostingGridID").jqxGrid('addrow', null, {});$("#monthlyPayrollPostingGridID").jqxGrid({ disabled: true});
		$("#payrollPostingJVGridID").jqxGrid('clear');$("#payrollPostingJVGridID").jqxGrid({ disabled: true});getLastPayrollPostedDate();
		document.getElementById("gridlength").value="";document.getElementById("mode").value="";document.getElementById("msg").value="";
	 }
	
	function funreload(event){
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var uptodate = $('#uptodate').val();
		 
		 if(uptodate==''){
			 $.messager.alert('Message','Save Payroll and Post.','warning');
			 return;
		 }
		 
		 var check = 1;
		 $("#monthlyPayrollPostingGridID").jqxGrid('clearselection');$("#monthlyPayrollPostingGridID").jqxGrid('clear');$("#monthlyPayrollPostingGridID").jqxGrid('addrow', null, {});$("#monthlyPayrollPostingGridID").jqxGrid({ disabled: true});
		 $("#payrollPostingJVGridID").jqxGrid('clear');$("#payrollPostingJVGridID").jqxGrid({ disabled: true});$('#txtdrtotal').val('');$('#txtcrtotal').val('');
		 $('#postingDate').val(new Date());$('#txtremarks').val('');$('#txtremarks').attr('placeholder', 'Remarks');document.getElementById("gridlength").value="";
		 document.getElementById("mode").value="";document.getElementById("msg").value="";$('#txtselectedemployees').val('');$('#btnpost').attr("disabled",true);$('#postingDate').jqxDateTimeInput({ disabled: true});
		 
		 $("#overlay, #PleaseWait").show();
		 
		 $("#monthlypayrollTotalDiv").load("monthlyPayrollTotalGrid.jsp?branchval="+branchval+'&uptodate=01.'+uptodate+'&check='+check);
		 
	}

	function disable(){
		 $('#postingDate').jqxDateTimeInput({ disabled: true});
		 $('#txtremarks').attr("readonly",true);
		 $('#btnpost').attr("disabled",true);
		 $("#monthlyPayrollPostingGridID").jqxGrid({ disabled: true});
		 $("#payrollPostingJVGridID").jqxGrid({ disabled: true});
	}
	
	function funCalculate(){
		
		var rows = $('#monthlyPayrollPostingGridID').jqxGrid('getrows');
    	if(rows.length==1 && (rows[0].netsalary=="undefined" || rows[0].netsalary==null || rows[0].netsalary=="")){
			$.messager.alert('Message','Select Payroll to be Posted & Calculate.','warning');
			return 0;
		} 
    	 var paymentPostingdate =$('#postingDate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(paymentPostingdate);
	//	  alert("paymentpostingdate="+paymentPostingdate+"validdate="+validdate);
		  if(parseInt(validdate)==0){
				return 0;	
			 }
		var rows = $('#payrollPostingJVGridID').jqxGrid('getrows');
    	var rowlength= rows.length;
		if(rowlength!=0){
			$.messager.alert('Message','Already calculated.Submit Again. ','warning');
			return 0;
		} else{
			$("#payrollPostingJVGridID").jqxGrid('clear');
			$('#txtselectedemployees').val('');
		} 
		
		$("#overlay, #PleaseWait").show();
		
		var rows = $("#monthlyPayrollPostingGridID").jqxGrid('getrows');
		
		if(rows.length==1 && (rows[0].netsalary=="undefined" || rows[0].netsalary==null || rows[0].netsalary=="")){
			return false;
		}
		
		var selectedrows=$("#monthlyPayrollPostingGridID").jqxGrid('selectedrowindexes');
		selectedrows = selectedrows.sort(function(a,b){return a - b});
		
		if(selectedrows.length==0){
			$("#overlay, #PleaseWait").hide();
			$.messager.alert('Warning','Select Items to be Calculated.');
			return false;
		}
		
		var i=0;var tempempdocnos="",tempempcatids="";
        $('#gridlength').val(selectedrows.length);
        var j=0; var k=0;
	    for (i = 0; i < rows.length; i++) {
				if(selectedrows[j]==i){
					
					if(k==1){
						tempempdocnos=tempempdocnos+","+rows[i].employeedocno;
						tempempcatids=tempempcatids+","+rows[i].empcatid;
					} else {
						tempempdocnos=rows[i].employeedocno;
						tempempcatids=rows[i].empcatid;
						k=1;
					}
				j++; 
			  }
            }
	    
	    $('#txtselectedemployees').val(tempempdocnos);
	    $('#txtcategoryids').val(tempempcatids);
	    var checked = 1;
	    
	    $("#payrollPostingJVGridID").jqxGrid('clear');$("#payrollPostingJVGridID").jqxGrid({ disabled: false});
	    $('#postingDate').jqxDateTimeInput({ disabled: false});$('#txtremarks').attr("readonly",false);$('#btnpost').attr("disabled",false);
	    $("#JVTDiv").load("monthlyJVGrid.jsp?branchval="+$('#cmbbranch').val()+'&uptodate=01.'+$('#uptodate').val()+'&category='+$('#txtcategoryids').val()+'&employees='+$('#txtselectedemployees').val()+'&postdate='+$('#postingDate').val()+'&checked='+checked);
		
	}
	
	function funPost(event){
		funNotify();
	}
	
	function funNotify() {	
    	
  	     /* if($('#cmbbranch').val()=='a'){
			 $.messager.alert('Message','Please Choose a Specific Main-Branch.','warning');
			 return 0;
		 } */
 		  
		   $.messager.confirm('Confirm', 'Do you want to Post?', function(r){
	 		if (r){
	 				
	    	/* Journal Voucher Grid Saving */
	    	 var rows = $("#payrollPostingJVGridID").jqxGrid('getrows');
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
				
				newTextBox.val(rows[i].docno+"::"+rows[i].description+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+baseamount+"::"+amount+":: 0::"+id+":: "+rows[i].costtype+":: "+rows[i].costcode);
				
				newTextBox.appendTo('form');
				}
			 }
			 $('#gridlength').val(length);
	 		/* Journal Voucher Grid Saving Ends */
	 		
			 document.getElementById("mode").value='A';
			 $("#overlay, #PleaseWait").show();
			 document.getElementById("frmDashboardMonthlyPayrollPosting").submit();
			 
	 		 }
	 		});
		 
  		return 1;
	} 
	
	function setValues(){
		
		  if($('#hiduptodate').val()){
			 $("#uptodate").jqxDateTimeInput('val', $('#hiduptodate').val());
		  }

	      if($('#hidpostingDate').val()){
			 $("#postingDate").jqxDateTimeInput('val', $('#hidpostingDate').val());
		  }
	  
		  if($('#msg').val()!=""){
			 $.messager.alert('Message',$('#msg').val());
			 getLastPayrollPostedDate();funreload(event);disable(); 
		 }
	}
	
</script>
</head>
<body onload="getBranch();disable();setValues();">

<form id="frmDashboardMonthlyPayrollPosting"
      action="saveDashboardMonthlyPayrollPosting"
      method="post">

<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar" style="height:100%;">

<table width="100%">
<tr>

<!-- ================= LEFT PANEL ================= -->
<td width="20%" valign="top">

<div class="master-container">
<div class="sidebar-filters">

    <!-- FIXED HEADER -->
    <div class="sidebar-fixed-top">
        <div class="filter-card">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>
    </div>

    <!-- SCROLLABLE CONTENT -->
    <div class="sidebar-scroll-content">

        <!-- FILTER CARD -->
        <div class="filter-card">
        <table class="filter-table">

            <tr>
                <td class="label-cell">Up To</td>
                <td>
                    <div id="uptodate"></div>
                    <input type="hidden"
                           id="hiduptodate"
                           name="hiduptodate"
                           value='<s:property value="hiduptodate"/>'>
                </td>
            </tr>

            <tr>
                <td colspan="2" style="text-align:center;">
                    <p class="bounce" style="margin:6px 0;">
                        <b>
                            <label id="lbllastposted" name="lbllastposted">
                                <s:property value="lbllastposted"/>
                            </label>
                        </b>
                    </p>
                </td>
            </tr>

        </table>
        </div>

        <!-- TOTAL GRID -->
        <div class="filter-card">
            <div id="monthlypayrollTotalDiv">
                <jsp:include page="monthlyPayrollTotalGrid.jsp"></jsp:include>
            </div>
        </div>

        <!-- POSTING DETAILS -->
        <div class="filter-card">
        <table class="filter-table">

            <tr>
                <td class="label-cell">Posting</td>
                <td>
                    <div id="postingDate"></div>
                    <input type="hidden"
                           id="hidpostingDate"
                           name="hidpostingDate"
                           value='<s:property value="hidpostingDate"/>'>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Remarks</td>
                <td>
                    <input type="text"
                           id="txtremarks"
                           name="txtremarks"
                           placeholder="Remarks"
                           value='<s:property value="txtremarks"/>'>
                </td>
            </tr>

        </table>
        </div>

        <!-- ACTION BUTTONS -->
        <div class="filter-card" style="text-align:center;">

            <button type="button"
                    onclick="funClearData();"
                    style="
                        background: linear-gradient(#2196f3, #1e88e5);
                        border: 1px solid #1565c0;
                        color: #fff;
                        padding: 6px 20px;
                        border-radius: 4px;
                        font-weight: bold;
                        cursor: pointer;
                        margin-right:6px;
                    ">
                Clear
            </button>

            <button type="button"
                    onclick="funPost(event);"
                    style="
                        background: linear-gradient(#2196f3, #1e88e5);
                        border: 1px solid #1565c0;
                        color: #fff;
                        padding: 6px 22px;
                        border-radius: 4px;
                        font-weight: bold;
                        cursor: pointer;
                    ">
                Post
            </button>

        </div>

        <!-- HIDDEN FIELDS -->
        <input type="hidden" id="txtselectedemployees" name="txtselectedemployees"
               value='<s:property value="txtselectedemployees"/>'>

        <input type="hidden" id="txtcategoryids" name="txtcategoryids"
               value='<s:property value="txtcategoryids"/>'>

        <input type="hidden" id="txtdrtotal" name="txtdrtotal"
               value='<s:property value="txtdrtotal"/>'>

        <input type="hidden" id="txtcrtotal" name="txtcrtotal"
               value='<s:property value="txtcrtotal"/>'>

        <input type="hidden" id="gridlength" name="gridlength">
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>

    </div>
</div>
</div>

</td>

<!-- ================= RIGHT PANEL ================= -->
<td width="80%" valign="top">

<table width="100%">
<tr>
    <td>
        <div id="monthlyPayrollPostingDiv">
            <jsp:include page="monthlyPayrollPostingGrid.jsp"></jsp:include>
        </div>
    </td>
</tr>

<tr>
    <td>
        <div id="JVTDiv">
            <jsp:include page="monthlyJVGrid.jsp"></jsp:include>
        </div>
    </td>
</tr>
</table>

</td>

</tr>
</table>

</div>
</div>

</form>
</body>

