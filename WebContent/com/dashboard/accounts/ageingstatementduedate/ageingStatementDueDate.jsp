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
        /* Removed fixed 100vh to allow parent table to control height */
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
        height: 650px; /* Set a fixed height for the sidebar to enable internal scrolling */
    }

    /* Fixed Top Section */
    .sidebar-fixed-top {
        padding: 20px 20px 15px 20px;
        background-color: #ffffff;
        border-bottom: 1px solid #f0f4f8;
        flex-shrink: 0;
    }

    .main-page-heading {
        font-size: 16px;
        font-weight: 700;
        color: #1a3a5f;
        margin-bottom: 10px;
        display: block;
        text-align: left;
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

    .level-row { display: flex; align-items: center; gap: 6px; }
    .level-input { width: 55px !important; text-align: center; }

    /* Buttons in #2563EB */
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
    
    /* 1. Reset root elements to fill the entire viewport height */
    html, body, #mainBG, .hidden-scrollbar {
        height: 100% !important;
        margin: 0 !important;
        padding: 0 !important;
        overflow: hidden !important;
    }

    /* 2. Force the main structural table to stretch to the bottom */
    table[width="100%"] {
        height: 100vh !important;
        border-collapse: collapse;
    }

    /* 3. Replace fixed 650px with 100vh so the sidebar stretches fully */
    .sidebar-filters {
        height: 100vh !important;
        flex: 0 0 330px;
        display: flex;
        flex-direction: column;
        background-color: #ffffff;
        border-right: 1px solid #e1e8ed;
    }

    /* 4. Ensure the master-container fills the height of its table cell */
    .master-container {
        height: 100% !important;
        display: flex;
    }

    /* 5. Ensure the scrollable form content area fills the remaining space */
    .sidebar-scroll-content {
        flex: 1;
        overflow-y: auto;
        padding: 15px 20px 25px 20px;
    }

    /* 6. Ensure the right-side grid area stretches to the bottom */
    td[width="80%"] {
        height: 100vh !important;
        background-color: #ffffff;
        vertical-align: top;
    }
    
</style>
<script type="text/javascript">

	$(document).ready(function () {
		 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
	     $('#txtaccid').dblclick(function(){
			  accountsSearchContent('accountsDetailsSearch.jsp');
		 });
	});
	
	function accountsSearchContent(url) {
	    $('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getSalesPerson() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var salesagentItems = items[0].split(",");
				var salesagentIdItems = items[1].split(",");
				var optionssalesagent = '<option value="">--Select--</option>';
				for (var i = 0; i < salesagentItems.length; i++) {
					optionssalesagent += '<option value="' + salesagentIdItems[i] + '">'
							+ salesagentItems[i] + '</option>';
				}
				$("select#cmbsalesperson").html(optionssalesagent);
				if ($('#hidcmbsalesperson').val() != null) {
					$('#cmbsalesperson').val($('#hidcmbsalesperson').val());
				}
			} else {
			}
		}
		x.open("GET", "getSalesPerson.jsp", true);
		x.send();
	}
  
   function getCategory() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var categoryItems = items[0].split(",");
				var categoryIdItems = items[1].split(",");
				var optionscategory = '<option value="">--Select--</option>';
				for (var i = 0; i < categoryItems.length; i++) {
					optionscategory += '<option value="' + categoryIdItems[i] + '">'
							+ categoryItems[i] + '</option>';
				}
				$("select#cmbcategory").html(optionscategory);
				if ($('#hidcmbcategory').val() != null) {
					$('#cmbcategory').val($('#hidcmbcategory').val());
				}
			} else {
			}
		}
		x.open("GET", "getCategory.jsp?type="+$('#cmbtype').val(), true);
		x.send();
	}
	
	function changelevel1(){ 
	   var level1to=$('#txtlevel1to').val();
	   var level2to=$('#txtlevel2to').val();
	   var level1from=$('#txtlevel1from').val();
	   if(level2to!=""){
	   if(parseInt(level1to)>parseInt(level2to) || parseInt(level1to)<parseInt(level1from)){
			 $.messager.alert('Message','Not a Valid Range.','warning');
			 $('#txtlevel1to').val('');
			 return 0;
		 }
	   }
	   
	   if(level1to!=""){
		   $('#txtlevel2from').val(parseInt(level1to)+1);
		   }
	    else{
		   $('#txtlevel2from').val('');
		   }
	}
	
	function changelevel2(){
		 var level2to=$('#txtlevel2to').val();
		 var level3to=$('#txtlevel3to').val();
		 var level2from=$('#txtlevel2from').val();
		 if(level3to!=""){
		 if(parseInt(level2to)>parseInt(level3to) || parseInt(level2to)<parseInt(level2from)){
				$.messager.alert('Message','Not a Valid Range.','warning');
				$('#txtlevel2to').val('');
				return 0;
			 }
		 }
		 
		if(level2to!=""){
			   $('#txtlevel3from').val(parseInt(level2to)+1);
			   }
		   else{
			   $('#txtlevel3from').val('');
			   } 
		
	}
	
	function changelevel3(){
		var level3to=$('#txtlevel3to').val();
		var level4to=$('#txtlevel4to').val();
		var level3from=$('#txtlevel3from').val();
		if(level4to!=""){
		 if(parseInt(level3to)>parseInt(level4to) || parseInt(level3to)<parseInt(level3from)){
				$.messager.alert('Message','Not a Valid Range.','warning');
				$('#txtlevel3to').val('');
				return 0;
			 }
		}
		 
		if(level3to!=""){
			   $('#txtlevel4from').val(parseInt(level3to)+1);
			   }
		     else{
			   $('#txtlevel4from').val('');
			   } 
	}
	
	function changelevel4(){
		var level4to=$('#txtlevel4to').val();
		var level4from=$('#txtlevel4from').val();
		if(level4to!=""){
		 if(parseInt(level4to)<parseInt(level4from)){
				$.messager.alert('Message','Not a Valid Range.','warning');
				$('#txtlevel4to').val('');
				return 0;
			 }
		}
		
		if(level4to!=""){
			   $('#txtlevel5from').val(parseInt(level4to)+1);
			   }
		    else{
			   $('#txtlevel5from').val('');
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
	
	function funOutStandingStatement(){
		 var accno = $('#txtacountno').val();
		 var level1from = $('#txtlevel1from').val();
		 var level1to = $('#txtlevel1to').val();
		 var level2from = $('#txtlevel2from').val();
		 var level2to = $('#txtlevel2to').val();
		 var level3from = $('#txtlevel3from').val();
		 var level3to = $('#txtlevel3to').val();
		 var level4from = $('#txtlevel4from').val();
		 var level4to = $('#txtlevel4to').val();
		 var level5from = $('#txtlevel5from').val();
		 
		if(accno==''){
			 $.messager.alert('Message','Please Choose a Client.','warning');
			 return 0;
		 }
		
  	if ($("#txtacountno").val()!="") {
	        var url=document.URL;
	        var reurl=url.split("ageingStatementDueDate.jsp");

	        $("#txtacountno").prop("disabled", false);
	        var win= window.open(reurl[0]+"printAgeingOutstandingStatementDueDate?atype="+document.getElementById("cmbtype").value+'&acno='+document.getElementById("txtacountno").value+'&level1from='+level1from+'&level1to='+level1to+'&level2from='+level2from+'&level2to='+level2to+'&level3from='+level3from+'&level3to='+level3to+'&level4from='+level4from+'&level4to='+level4to+'&level5from='+level5from+'&branch='+document.getElementById("txtbranch").value+'&uptoDate='+$("#uptodate").val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        win.focus();
	     }
	    else {
			$.messager.alert('Message','Account is Mandatory.','warning');
			return;
		}
	   }
	    
	function clearAccountInfo(){
		$('#txtdocno').val('');$('#txtaccid').val('');$('#txtaccname').val('');
	} 
	
	function funreload(event){
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var uptodate = $('#uptodate').val();
		 var atype = $('#cmbtype').val();
		 var accdocno = $('#txtdocno').val();
		 var salesperson = $('#cmbsalesperson').val();
		 var category = $('#cmbcategory').val();
		 var level1from = $('#txtlevel1from').val();
		 var level1to = $('#txtlevel1to').val();
		 var level2from = $('#txtlevel2from').val();
		 var level2to = $('#txtlevel2to').val();
		 var level3from = $('#txtlevel3from').val();
		 var level3to = $('#txtlevel3to').val();
		 var level4from = $('#txtlevel4from').val();
		 var level4to = $('#txtlevel4to').val();
		 var level5from = $('#txtlevel5from').val();
		 var check=1;
		 
		 if(atype==''){
			 $.messager.alert('Message','Please Choose Account Type.','warning');
			 return 0;
		 }
		 
		 if(level1from==''){$.messager.alert('Message','Level 1 is Mandatory.','warning');return 0;}
		 if(level1to==''){$.messager.alert('Message','Level 1 is Mandatory.','warning');return 0;}
		 if(level2from==''){$.messager.alert('Message','Level 2 is Mandatory.','warning');return 0;}
		 if(level2to==''){$.messager.alert('Message','Level 2 is Mandatory.','warning');return 0;}
		 if(level3from==''){$.messager.alert('Message','Level 3 is Mandatory.','warning');return 0;}
		 if(level3to==''){$.messager.alert('Message','Level 3 is Mandatory.','warning');return 0;}
		 if(level4from==''){$.messager.alert('Message','Level 4 is Mandatory.','warning');return 0;}
		 if(level4to==''){$.messager.alert('Message','Level 4 is Mandatory.','warning');return 0;}
		 if(level5from==''){$.messager.alert('Message','Level 5 is Mandatory.','warning');return 0;}
		 
		 $("#overlay, #PleaseWait").show();
		 
		 $("#ageingStatementDueDateDiv").load("ageingStatementDueDateGrid.jsp?branchval="+branchval+'&uptodate='+uptodate+'&atype='+atype+'&accdocno='+accdocno+'&salesperson='+salesperson+'&category='+category+'&level1from='+level1from+'&level1to='+level1to+'&level2from='+level2from+'&level2to='+level2to
				 +'&level3from='+level3from+'&level3to='+level3to+'&level4from='+level4from+'&level4to='+level4to+'&level5from='+level5from+'&check='+check);
		}
	
	    function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	JSONToCSVCon(data, 'AgeingStatement(DueDate)', true);
		 } else {
			 $("#ageingStatementDueDate").jqxGrid('exportdata', 'xls', 'AgeingStatement(DueDate)');
		 }
	 }
	    function funRefreshDuedate(){
	    	$("#overlay, #PleaseWait").show();
	    	$.post('refreshDueDate.jsp',function(data,status){
	    		data=JSON.parse(data);
	    		if(data.errorstatus=="0"){
	    			$.messager.alert('Message','Successfully Refreshed');
	    		}
	    		else if(data.errorstatus=="1"){
	    			$.messager.alert('Warning','Not Refreshed');
	    		}
	    	});
	    }
</script>
</head>
<body onload="getBranch();getSalesPerson();getCategory();">
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
                        <td class="label-cell">Up To</td>
                        <td><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Type</td>
                        <td>
                            <select id="cmbtype" name="cmbtype" onchange="clearAccountInfo();getCategory();">
                                <option value="AR" selected>AR</option>
                                <option value="AP">AP</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Account</td>
                        <td>
                            <input type="text" id="txtaccid" name="txtaccid" placeholder="F3 to Search" 
                                   value='<s:property value="txtaccid"/>' 
                                   readonly="readonly"
                                   ondblclick="funSearchdblclick();" 
                                   onkeydown="getAccType(event);"/>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <input type="text" id="txtaccname" name="txtaccname" readonly="readonly" 
                                   value='<s:property value="txtaccname"/>' 
                                   tabindex="-1" style="margin-top:-5px;"/>
                            <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
                            <input type="hidden" id="txtacountno" name="txtacountno" value='<s:property value="txtacountno"/>'/>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Sales Person</td>
                        <td><select id="cmbsalesperson" name="cmbsalesperson"><option value="">--Select--</option></select></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Category</td>
                        <td><select id="cmbcategory" name="cmbcategory"><option value="">--Select--</option></select></td>
                    </tr>

                    <tr>
                        <td class="label-cell">Level 1</td>
                        <td class="level-row">
                            <input type="text" id="txtlevel1from" class="level-input" readonly value='0'/>
                            <span>-</span>
                            <input type="text" id="txtlevel1to" class="level-input" onblur="changelevel1();" value='30'/>
                        </td>
                    </tr>
                    <tr><td class="label-cell">Level 2</td><td class="level-row"><input type="text" id="txtlevel2from" class="level-input" readonly value='31'/><span>-</span><input type="text" id="txtlevel2to" class="level-input" onblur="changelevel2();" value='60'/></td></tr>
                    <tr><td class="label-cell">Level 3</td><td class="level-row"><input type="text" id="txtlevel3from" class="level-input" readonly value='61'/><span>-</span><input type="text" id="txtlevel3to" class="level-input" onblur="changelevel3();" value='90'/></td></tr>
                    <tr><td class="label-cell">Level 4</td><td class="level-row"><input type="text" id="txtlevel4from" class="level-input" readonly value='91'/><span>-</span><input type="text" id="txtlevel4to" class="level-input" onblur="changelevel4();" value='120'/></td></tr>
                    <tr><td class="label-cell">Level 5</td><td class="level-row"><input type="text" id="txtlevel5from" class="level-input" value='121'/><span style="font-weight: bold;">&ge;</span></td></tr>
                </table>
            </div>

            <button class="btn-submit" type="button" onclick="funOutStandingStatement();">Outstanding Statement</button>
            <button class="btn-submit" type="button" onclick="funRefreshDuedate();">Refresh Due Date</button>
        </div>
    </div>
</div></td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="ageingStatementDueDateDiv"><jsp:include page="ageingStatementDueDateGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>

</div>

<div id="accountDetailsWindow">
	<div></div><div></div>
</div>
</div> 
</body>
</html>