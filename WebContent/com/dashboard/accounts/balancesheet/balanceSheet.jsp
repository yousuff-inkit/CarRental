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
    
	var selectedBox = null;
	
	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
		 var year = window.parent.txtaccountperiodfrom.value;
		 var newDate = year.split('-');
		 year = newDate[1] + "-" + newDate[0] + "-" + newDate[2];
		 $('#fromdate ').jqxDateTimeInput('setDate', new Date(year));
	     
		 $("#branchlabel").attr('hidden',true);
		 $("#branchdiv").attr('hidden',true);
			
	     /* document.getElementById("hidchckgroup").value=1;
 		 document.getElementById("chckgroup").checked = true; */
 		 
 		 $(".chcklevels").click(function() {
 	        selectedBox = this.id;

 	        $(".chcklevels").each(function() {
 	            if ( this.id == selectedBox )
 	            {
 	                this.checked = true;
 	               if ( this.id != "chcklevel4" ){  
 	               	 $('#btnprint').attr("disabled",true);
 	               }else{
 	               	 $('#btnprint').attr("disabled",false);
 	               } 
 	            }
 	            else
 	            {
 	                this.checked = false;
 	            };        
 	        });
 	    });    
 		 
		 document.getElementById("hidchcklevel4").value=1;
 		 document.getElementById("chcklevel4").checked = true;
 		 $('#btnprint').attr("disabled",true);
 		 getBalanceSheetPrintConfig();
	});
	
	function getBalanceSheetPrintConfig(){
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
  		x.open("GET", "getBalanceSheetPrintConfig.jsp", true);
  		x.send();
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
	
	function analysischeck(){
		 if(document.getElementById("chckanalysis").checked){
			 document.getElementById("hidchckanalysis").value = 1;
			 $('#txtnoofdays').val("0");
 			 $('#txtfrequency').val("0");
		 }
		 else{
			 document.getElementById("hidchckanalysis").value = 0;
		 }
		 hidedata();
	 }
	
	function checklevel1(){
		if(document.getElementById("chcklevel1").checked){
			 document.getElementById("hidchcklevel1").value = 1;
			 document.getElementById("hidchcklevel2").value = 0;
			 document.getElementById("hidchcklevel3").value = 0;
			 document.getElementById("hidchcklevel4").value = 0;
		 }
		 else{
			 document.getElementById("hidchcklevel1").value = 0;
		 }
	 }
	
	function checklevel2(){
		 if(document.getElementById("chcklevel2").checked){
			 document.getElementById("hidchcklevel2").value = 1;
			 document.getElementById("hidchcklevel1").value = 0;
			 document.getElementById("hidchcklevel3").value = 0;
			 document.getElementById("hidchcklevel4").value = 0;
		 }
		 else{
			 document.getElementById("hidchcklevel2").value = 0;
		 }
	 }
	
	function checklevel3(){
		 if(document.getElementById("chcklevel3").checked){
			 document.getElementById("hidchcklevel3").value = 1;
			 document.getElementById("hidchcklevel1").value = 0;
			 document.getElementById("hidchcklevel2").value = 0;
			 document.getElementById("hidchcklevel4").value = 0;
		 }
		 else{
			 document.getElementById("hidchcklevel3").value = 0;
		 }
	 }
	
	function checklevel4(){
		 if(document.getElementById("chcklevel4").checked){
			 document.getElementById("hidchcklevel4").value = 1;
			 document.getElementById("hidchcklevel1").value = 0;
			 document.getElementById("hidchcklevel2").value = 0;
			 document.getElementById("hidchcklevel3").value = 0;
		 }
		 else{
			 document.getElementById("hidchcklevel4").value = 0;
		 }
	 }
	
	function hidedata(){
  		var analysis=$('#hidchckanalysis').val();
  		
  		if(parseInt(analysis)==1){
  			   $("#analysisDiv").prop("hidden", false);
  			   $("#viewDiv").attr("hidden", true);
  			}
  			else{
  				$("#analysisDiv").prop("hidden", true);
  				$("#viewDiv").attr("hidden", false);
  			}
  		}
	
	 function funreload(event){
		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var level1 = $('#hidchcklevel1').val();
		 var level2 = $('#hidchcklevel2').val();
		 var level3 = $('#hidchcklevel3').val();
		 var level4 = $('#hidchcklevel4').val();
		 var check=1;
		 
		 $("#overlay, #PleaseWait").show();
		 if(document.getElementById("chcklevel4").checked){
		   $('#btnprint').attr("disabled",true);
		 }
		 $("#balanceSheetDiv").load("balanceSheetGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&level1='+level1+'&level2='+level2+'&level3='+level3+'&level4='+level4+'&check='+check);
		}
		
		function funExportBtn(){
		  if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	JSONToCSVCon(dataExcelExport, 'BalanceSheet', true);
		  } else {
			 $("#balanceSheetGrid").jqxTreeGrid('exportData', 'xls');
		  }
	    }
		
		function funPrintTForm(){
		        var url=document.URL;
		        var reurl=url.split("balanceSheet.jsp");

		        var fromdate = $('#fromdate').jqxDateTimeInput('val');
		        var todate = $('#todate').jqxDateTimeInput('val');
		        
		        var win= window.open(reurl[0]+"printTForm?branch="+document.getElementById("cmbbranch").value+'&fromdate='+fromdate+'&todate='+todate,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
		        win.focus();
	    }
		
		function funPrint(){
		
		  if(document.getElementById("chcklevel4").checked){
			 
			 var branchval = document.getElementById("cmbbranch").value;
			 var fromdate = $('#fromdate').val();
			 var todate = $('#todate').val();
			 
			 var url=document.URL;
			 var reurl=url.split("com/");
			 var path= "com/dashboard/accounts/balancesheet/balancesheetlist2.action?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate;
			 var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");		
			 win.focus();		
			}
			else {
			
			 var branchval = document.getElementById("cmbbranch").value;
			 var fromdate = $('#fromdate').val();
			 var todate = $('#todate').val();
			 
			 var url=document.URL;
			 var reurl=url.split("com");
			 var path= "com/dashboard/accounts/balancesheet/balancesheetlist.action?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate;
			 var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");		
			 win.focus();
			
			
			}
				 
				
			}
	   
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar">

<table width="100%">
<tr>


<td width="20%" valign="top">

<fieldset class="filter-card">
<table width="100%" class="filter-table">

   
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

    <tr><td colspan="2">&nbsp;</td></tr>

    <tr>
        <td colspan="2">
            <fieldset>
                <legend><b><label class="branch">Levels</label></b></legend>

                <table width="100%">
                    <tr>
                        <td>
                            <input type="checkbox" id="chcklevel1" name="chcklevel1"
                                   class="chcklevels"
                                   onchange="checklevel1();"
                                   onclick="$(this).attr('value', this.checked ? 1 : 0)">
                            <label class="branch">Level 1</label>
                            <input type="hidden" id="hidchcklevel1" name="hidchcklevel1"
                                   value='<s:property value="hidchcklevel1"/>'>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <input type="checkbox" id="chcklevel2" name="chcklevel2"
                                   class="chcklevels"
                                   onchange="checklevel2();"
                                   onclick="$(this).attr('value', this.checked ? 1 : 0)">
                            <label class="branch">Level 2</label>
                            <input type="hidden" id="hidchcklevel2" name="hidchcklevel2"
                                   value='<s:property value="hidchcklevel2"/>'>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <input type="checkbox" id="chcklevel3" name="chcklevel3"
                                   class="chcklevels"
                                   onchange="checklevel3();"
                                   onclick="$(this).attr('value', this.checked ? 1 : 0)">
                            <label class="branch">Level 3</label>
                            <input type="hidden" id="hidchcklevel3" name="hidchcklevel3"
                                   value='<s:property value="hidchcklevel3"/>'>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <input type="checkbox" id="chcklevel4" name="chcklevel4"
                                   class="chcklevels"
                                   onchange="checklevel4();"
                                   onclick="$(this).attr('value', this.checked ? 1 : 0)">
                            <label class="branch">Level 4</label>
                            <input type="hidden" id="hidchcklevel4" name="hidchcklevel4"
                                   value='<s:property value="hidchcklevel4"/>'>
                        </td>
                    </tr>
                </table>
            </fieldset>
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
<td width="80%" valign="top">

<table width="100%">
<tr>
    <td>
        <div id="balanceSheetDiv">
            <jsp:include page="balanceSheetGrid.jsp"></jsp:include>
        </div>
    </td>
</tr>
</table>

</td>

</tr>
</table>

</div>
</div>
</body>

</html>