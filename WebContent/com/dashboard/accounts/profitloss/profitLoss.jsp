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

    /* Fixed Top Section */
    .sidebar-fixed-top {
        padding: 20px 20px 15px 20px;
        background-color: #ffffff;
        border-bottom: 1px solid #f0f4f8;
        flex-shrink: 0;
    }

    /* Light Grey Card Backgrounds */
    .filter-card {
        background-color: #f8fafc !important;
        border: 1px solid #e3e8ee !important;
        border-radius: 12px !important;
        padding: 15px;
        margin-bottom: 10px;
    }

    /* Scrollable Form Area */
    .sidebar-scroll-content {
        flex: 1;
        overflow-y: auto;
        padding: 15px 20px 25px 20px;
    }

    .filter-table { 
        width: 100%; 
        border-spacing: 0 10px; 
    }

    .label-cell {
        text-align: right;
        padding-right: 12px;
        font-size: 13px;
        color: #4e5e71;
        font-weight: 600;
        width: 85px;
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
        background-color: #ffffff;
    }

    /* Buttons */
    .btn-submit {
        background-color: #2563eb !important;
        color: #ffffff !important;
        border: none !important;
        padding: 12px !important;
        border-radius: 6px !important;
        cursor: pointer;
        font-size: 14px;
        font-weight: 600;
        width: 100%;
        margin-top: 10px;
        transition: background 0.2s;
    }

    .btn-submit:hover { background-color: #1d4ed8 !important; }

    /* Root Fixes */
    html, body, #mainBG, .hidden-scrollbar {
        height: 100% !important;
        margin: 0 !important;
        padding: 0 !important;
        overflow: hidden !important;
    }

    table[width="100%"] {
        height: 100vh !important;
        border-collapse: collapse;
    }

    /* Right side Grid area */
    td[width="80%"] {
        height: 100vh !important;
        background-color: #ffffff;
        vertical-align: top;
    }

    /* Preservation of original styles for account labels */
    .account { color: black; background-color: #E0ECF8; width: 100%; height: 28px; font-family: Myriad Pro; font-weight: bold; }
    .accname { color: black; background-color: #E0ECF8; width: 100%; font-family: comic sans ms; }
    .branch { font-size: 13px; color: #4e5e71; font-weight: 600; }
    
    /* Specific fix to remove the light green backgrounds */
    #viewDiv .filter-card, 
    #viewDiv fieldset, 
    #viewDiv .filter-table tr, 
    #viewDiv .filter-table td {
        background-color: transparent !important;
        background: none !important;
        border: none !important;
    }

    /* Reset the label color to match the rest of the sidebar */
    .branch { 
        font-size: 13px; 
        color: #4e5e71; 
        font-weight: 600; 
        background: none !important;
    }
    
    /* Ensure the legend doesn't have a background */
    #viewDiv legend {
        background: none !important;
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
  		getProfitAndLossPrintConfig()
 	});
 	
	function getProfitAndLossPrintConfig(){
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
  		x.open("GET", "getProfitAndLossPrintConfig.jsp", true);
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
		 $('#btnprint').attr("disabled",true);
		 $("#profitLossDiv").load("profitLossGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&level1='+level1+'&level2='+level2+'&level3='+level3+'&level4='+level4+'&check='+check);
		}
		
		function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	JSONToCSVCon(dataExcelExport, 'ProfitAndLoss', true);
		 } else {
			 $("#profitLossGrid").jqxTreeGrid('exportData', 'xls');
		 }
	 }
		
	function funPrint(){
		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 
		 var url=document.URL;
		 var reurl=url.split("com/");
		 var path= "com/dashboard/accounts/profitloss/profitlosslist.action?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate;
		 var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");		
		 win.focus();		
			 
			
		}
	
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
  <tr>
    <td width="20%" >
    <div class="master-container">
    <div class="sidebar-filters">
        <div class="sidebar-fixed-top">
            <div class="filter-card">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>
        </div>

        <div class="sidebar-scroll-content">
            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Period</td>
                        <td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">To</td>
                        <td><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
                    </tr>
                </table>
            </div>

            <div id="viewDiv">
                <div class="filter-card">
                    <span class="branch" style="display:block; margin-bottom:8px;">Levels</span>
                    <table class="filter-table">
                        <tr>
                            <td width="10%"><input type="checkbox" id="chcklevel1" name="chcklevel1" class="chcklevels" value="" onchange="checklevel1();" onclick="$(this).attr('value', this.checked ? 1 : 0)"></td>
                            <td><label class="branch">Level 1</label>
                                <input type="hidden" id="hidchcklevel1" name="hidchcklevel1" value='<s:property value="hidchcklevel1"/>'/>
                            </td>
                        </tr>
                        <tr>
                            <td><input type="checkbox" id="chcklevel2" name="chcklevel2" class="chcklevels" value="" onchange="checklevel2();" onclick="$(this).attr('value', this.checked ? 1 : 0)"></td>
                            <td><label class="branch">Level 2</label>
                                <input type="hidden" id="hidchcklevel2" name="hidchcklevel2" value='<s:property value="hidchcklevel2"/>'/>
                            </td>
                        </tr>
                        <tr>
                            <td><input type="checkbox" id="chcklevel3" name="chcklevel3" class="chcklevels" value="" onchange="checklevel3();" onclick="$(this).attr('value', this.checked ? 1 : 0)"></td>
                            <td><label class="branch">Level 3</label>
                                <input type="hidden" id="hidchcklevel3" name="hidchcklevel3" value='<s:property value="hidchcklevel3"/>'/>
                            </td>
                        </tr>
                        <tr>
                            <td><input type="checkbox" id="chcklevel4" name="chcklevel4" class="chcklevels" value="" onchange="checklevel4();" onclick="$(this).attr('value', this.checked ? 1 : 0)"></td>
                            <td><label class="branch">Level 4</label>
                                <input type="hidden" id="hidchcklevel4" name="hidchcklevel4" value='<s:property value="hidchcklevel4"/>'/>
                            </td>
                        </tr>
                    </table>
                </div>
                
                <button type="button" class="btn-submit" id="btnprint" onclick="funPrint();">Print</button>
            </div>

            <div id="analysisDiv" hidden="true">
                <div class="filter-card">
                    <select id="cmbchoose" name="cmbchoose" value='<s:property value="cmbchoose"/>'>
                        <option value="1">Days</option>
                        <option value="2">Monthly</option>
                        <option value="3">Quarterly</option>
                        <option value="4">Yearly</option>
                    </select>
                    <input type="text" id="txtnoofdays" name="txtnoofdays" style="margin-top:10px;" placeholder="No. of Days" value='<s:property value="txtnoofdays"/>'/>
                    <div style="margin-top:10px;">
                        <label class="branch">Frequency</label>
                        <input type="text" id="txtfrequency" name="txtfrequency" value='<s:property value="txtfrequency"/>'/>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div style="flex: 1; height: 100vh; overflow-y: auto; background-color: #fff;">
        <table width="100%">
            <tr>
                <td style="padding: 20px;">
                    <div id="dynamicGridContainer"></div> 
                </td>
            </tr>
        </table>
    </div>
</div>
</td>
<td width="80%">
	<table width="100%">
		 <tr>
		    <td><div id="profitLossDiv"><jsp:include page="profitLossGrid.jsp"></jsp:include></div></td>
		 </tr> 
	</table>
</td></tr>
</table>
</div>

</div> 
</body>
</html>