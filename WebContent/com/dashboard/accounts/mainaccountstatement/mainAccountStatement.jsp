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
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

	     var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	     $('#txtaccid').dblclick(function(){
	    	 if($('#cmbtype').val()==''){
   			     $.messager.alert('Message','Please Choose Account Type.','warning');
   			     return 0;
   		     }
	    	 accountsSearchContent('accountsDetailsSearch.jsp');
		 });
	     
	     $("#trialDiv").hide();
	     document.getElementById("hidchckincludingzero").value=0;
	     $('#btnPrintAccount').attr('disabled', true);
	     
	});
	
	function accountsSearchContent(url) {
	    $('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getAccTypeFrom(event){
        var x= event.keyCode;
        if(x==114){
        	 if($('#cmbtype').val()==''){
   			     $.messager.alert('Message','Please Choose Account Type.','warning');
   			     return 0;
   		     }
      	     accountsSearchContent('accountsDetailsSearch.jsp');
        }
        else{
         }
        }
	
	function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	JSONToCSVCon(data, 'MainAccountStatement', true);
		 } else {
			 $("#mainAccountStatementGridID").jqxGrid('exportdata', 'xls', 'MainAccountStatement');
		 }
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
		 var accdocno = $('#txtdocno').val();
		 var includingzero = $('#hidchckincludingzero').val(); 
		 
		 if(acctype==''){
			 $.messager.alert('Message','Please Choose Account Type.','warning');
			 return 0;
		 }
		 
		 $("#overlay, #PleaseWait").show();
		 $("#mainAccountStatementDiv").load("mainAccountStatementGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&acctype='+acctype+'&accdocno='+accdocno+'&includingzero='+includingzero+'&check=1');
		}
	
	function funClearInfo(){

  	     $('#cmbbranch').val('a');
  	     $('#fromdate').val(new Date());
  	     var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		 $('#todate').val(new Date());
		 
		 document.getElementById("hidchckincludingzero").value = 0;
		 if(document.getElementById("hidchckincludingzero").value==0){
			 document.getElementById("chckincludingzero").checked = false;
		 }
		 
		 $('#btnPrintAccount').attr('disabled', true);
         document.getElementById("cmbtype").value="";document.getElementById("txtaccid").value="";
         document.getElementById("txtaccname").value="";document.getElementById("txtdocno").value="";
         funRoundAmt(0,"txtnetamount");
       
		 $("#mainAccountStatementGridID").jqxGrid('clear');$("#mainAccountStatementGridID").jqxGrid('addrow', null, {});
		
		 if (document.getElementById("txtaccid").value == "") {
		        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
		  }
		}
	
	function funPrintMainAccountStatement(){
    	if ($("#cmbtype").val()!="") {
	        var url=document.URL;
	        var reurl=url.split("mainAccountStatement.jsp");
	        $("#txtdocno").prop("disabled", false);
	        var win= window.open(reurl[0]+"printMainAccountStatement?type="+document.getElementById("cmbtype").value+'&acno='+document.getElementById("txtdocno").value+'&branch='+document.getElementById("cmbbranch").value+'&fromDate='+document.getElementById("fromdate").value+'&toDate='+$('#todate').val()+'&includingzero='+$('#hidchckincludingzero').val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        win.focus();
	     }
	    else {
			$.messager.alert('Message','Account Type is Mandatory.','warning');
			return;
		}
    }

</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ===== LEFT PANEL ===== -->
<td width="20%" valign="top">

<fieldset class="filter-card">
<table width="100%" class="filter-table">

    <!-- HEADING (UNCHANGED) -->
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
                <option value="">--Select--</option>
                <option value="AP">AP</option>
                <option value="AR">AR</option>
                <option value="GL">GL</option>
                <option value="HR">HR</option>
            </select>
        </td>
    </tr>

    <tr>
        <td class="label-cell">Account</td>
        <td>
            <input type="text"
                   id="txtaccid"
                   name="txtaccid"
                   class="master-input"
                   readonly
                   placeholder="Press F3 to Search"
                   value='<s:property value="txtaccid"/>'
                   onkeydown="getAccTypeFrom(event);">
        </td>
    </tr>

    <tr>
        <td></td>
        <td>
            <input type="text"
                   id="txtaccname"
                   name="txtaccname"
                   class="master-input"
                   readonly
                   value='<s:property value="txtaccname"/>'
                   tabindex="-1">

            <input type="hidden"
                   id="txtdocno"
                   name="txtdocno"
                   value='<s:property value="txtdocno"/>'>
        </td>
    </tr>

    <tr><td colspan="2">&nbsp;</td></tr>

    <!-- ✅ FIXED BUTTONS -->
    <tr>
        <td colspan="2" align="center">

            <button type="button"
                    class="myButton"
                    id="clear"
                    onclick="funClearInfo();">
                Clear
            </button>

            <button type="button"
                    class="myButton"
                    id="btnPrintAccount"
                    onclick="funPrintMainAccountStatement(event);">
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
        <div id="mainAccountStatementDiv">
            <jsp:include page="mainAccountStatementGrid.jsp"></jsp:include>
        </div>
    </td>
</tr>
</table>

</td>

</tr>
</table>

<!-- HIDDEN TOTAL -->
<div id="trialDiv" hidden="true">
<table width="100%">
<tr>
    <td align="right">
        <input type="hidden"
               id="txtnetamount"
               name="txtnetamount"
               value='<s:property value="txtnetamount"/>'>
    </td>
</tr>
</table>
</div>

</div>

<div id="accountDetailsWindow">
    <div></div>
</div>

</div>
</body>

</html>