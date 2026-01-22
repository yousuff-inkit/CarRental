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
<style>
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

</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

	     var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	     $("#trialDiv").hide();
	     document.getElementById("hidchckincludingzero").value=0;
	     getTrialBalancePrintConfig();
	});
	
	function getTrialBalancePrintConfig(){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  			    
  			  	if(parseInt(items)==1){
  				 	 $("#btnprint").show();
	  			 } else {
	  				 $("#btnprint").hide();
  				 }
  		}
  		}
  		x.open("GET", "getTrialBalancePrintConfig.jsp", true);
  		x.send();
    }
	
	function funExportBtn(){
// JSONToCSVCon(data, 'TrialBalance', true);
$("#trialBalanceDiv").excelexportjs({
containerid: "trialBalanceDiv",
datatype: 'json',
dataset: null,
gridId: "trialBalance",
columns: getColumns("trialBalance") ,
worksheetName:"Trial Balance"
});

}
    
	function includingzerocheck(){
		 if(document.getElementById("chckincludingzero").checked){
			 document.getElementById("hidchckincludingzero").value = 1;
		 }
		 else{
			 document.getElementById("hidchckincludingzero").value = 0;
		 }
	 }
	
	function funreload(event){
		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var acctype = $('#cmbtype').val();
		 var includingzero = $('#hidchckincludingzero').val(); 
		 
		 $("#overlay, #PleaseWait").show();
		 
		 $("#trialBalanceDiv").load("trialBalanceGrid.jsp?barchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&acctype='+acctype+'&includingzero='+includingzero+'&check=1');
		}

	function funPrint(){
		var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var acctype = $('#cmbtype').val();
		 var includingzero = $('#hidchckincludingzero').val(); 
				var url=document.URL;
				var reurl=url.split("com/");
				/* var path= "com/dashboard/workshop/quotationapproval/printQuotationAproval.action?estDocno="+estdocno; */
				var path= "/com/dashboard/accounts/trialbalance/trialbalancelist.action?barchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&acctype='+acctype+'&includingzero='+includingzero+'&check=1';
				var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");		
				win.focus();		
			 
			
		}
	function disableprint() {
		$('#btnprint').attr("disabled",true);
	}
	
</script>
</head>
<body onload="getBranch();disableprint();">
<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ===== LEFT PANEL ===== -->
<td width="20%" valign="top">

<fieldset class="filter-card">
<table width="100%" class="filter-table">

    <!-- HEADING (DO NOT CHANGE) -->
    <jsp:include page="../../heading.jsp"></jsp:include>

    <tr>
        <td class="label-cell">Period</td>
        <td>
            <div id="fromdate" name="fromdate"
                 value='<s:property value="fromdate"/>'></div>
        </td>
    </tr>

    <tr>
        <td class="label-cell">To</td>
        <td>
            <div id="todate" name="todate"
                 value='<s:property value="todate"/>'></div>
        </td>
    </tr>

    <tr>
        <td colspan="2">
            <input type="checkbox"
                   id="chckincludingzero"
                   name="chckincludingzero"
                   onchange="includingzerocheck();"
                   onclick="$(this).attr('value', this.checked ? 1 : 0)">
            <label class="branch">Including Zero</label>

            <input type="hidden"
                   id="hidchckincludingzero"
                   name="hidchckincludingzero"
                   value='<s:property value="hidchckincludingzero"/>'>
        </td>
    </tr>

    <tr>
        <td class="label-cell">Type</td>
        <td>
            <select id="cmbtype"
                    name="cmbtype"
                    class="master-input"
                    value='<s:property value="cmbtype"/>'>
                <option value="">All</option>
                <option value="AP">AP</option>
                <option value="AR">AR</option>
                <option value="GL">GL</option>
                <option value="HR">HR</option>
            </select>
        </td>
    </tr>

    <tr><td colspan="2">&nbsp;</td></tr>

    <tr>
        <td colspan="2" align="center">
            <button type="button"
                    class="myButton"
                    id="btnprint"
                    onclick="funPrint();">
                Print
            </button>
        </td>
    </tr>

</table>
</fieldset>

</td>

<!-- ===== RIGHT PANEL ===== -->
<td width="80%" valign="top">

<table width="100%">
<tr>
    <td>
        <div id="trialBalanceDiv">
            <jsp:include page="trialBalanceGrid.jsp"></jsp:include>
        </div>
    </td>
</tr>
</table>

</td>

</tr>
</table>

<!-- ===== FOOT TOTAL ===== -->
<div id="trialDiv" hidden="true">
<table width="100%">
<tr>
    <td align="right">
        <input type="text"
               class="textbox"
               id="txtnetamount"
               name="txtnetamount"
               style="text-align:right;"
               value='<s:property value="txtnetamount"/>'>
    </td>
</tr>
</table>
</div>

</div>
</div>
</body>

</html>