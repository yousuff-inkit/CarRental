<jsp:include page="../../../../includes.jsp"></jsp:include>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<%
	String contextPath = request.getContextPath();
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/resample.js"></script>

<style type="text/css">
    /* Layout & Sidebar Structure */
    .master-container {
        display: flex;
        font-family: 'Segoe UI', Tahoma, sans-serif !important;
        background-color: #f4f7f9;
        width: 100%;
        height: 100% !important;
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

    /* Filter Cards */
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
        background-color: #ffffff;
    }

    .level-row { display: flex; align-items: center; gap: 6px; }
    .level-input { width: 55px !important; text-align: center; }

    /* Action Buttons (myButton style updated for Sidebar) */
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
        margin-top: 10px;
        transition: background 0.2s;
        display: block;
    }

    .myButton:hover { background-color: #1d4ed8 !important; }

    /* RHS Visibility Fix */
    .main-content-wrapper {
        flex: 1;
        display: flex;
        flex-direction: column;
        height: 100vh;
        overflow: hidden;
        position: relative;
        background-color: #ffffff;
    }

    .scrollable-grid-area {
        flex: 1;
        overflow-y: auto;
        padding: 20px 20px 100px 20px; /* Space to clear the totals bar */
    }

    .totals-bar {
        background: #ffffff;
        border-top: 1px solid #e1e8ed;
        padding: 12px;
        position: absolute;
        bottom: 0;
        left: 0;
        right: 0;
        z-index: 20;
        box-shadow: 0 -2px 10px rgba(0,0,0,0.05);
    }

    .textbox {
        border: 1px solid #ccd6e0;
        height: 25px;
        border-radius: 5px;
        padding: 0 5px;
        outline: 0;
        background-color: #ffffff;
    }

    /* Global Resets */
    html, body, #mainBG, .hidden-scrollbar {
        height: 100% !important;
        margin: 0 !important;
        padding: 0 !important;
        overflow: hidden !important;
    }

    #tabledata { display: none; }
    .branch { font-size: 13px; color: #4e5e71; font-weight: 600; }
    
    /* 1. Prevent horizontal overflow on the root and main containers */
    html, body, .master-container, .main-content-wrapper {
        overflow-x: hidden !important;
        width: 100%;
    }

    /* 2. Force the grid area to handle only vertical scrolling */
    .scrollable-grid-area {
        flex: 1;
        overflow-y: auto;
        overflow-x: hidden; /* This kills the horizontal scrollbar */
        padding: 20px 20px 140px 20px;
    }

    /* 3. Force tables to stay within their parent's width */
    .scrollable-grid-area table, 
    .totals-bar table {
        table-layout: fixed; /* This prevents columns from pushing the width out */
        width: 100% !important;
        word-wrap: break-word;
    }

    /* 4. Ensure the totals bar doesn't cause an overflow */
    .totals-bar {
        width: 100%;
        box-sizing: border-box; /* Includes padding in the width calculation */
        overflow: hidden;
    }

    /* 5. Handle long text in cells so they don't force width expansion */
    .scrollable-grid-area td, 
    .totals-bar td {
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
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
		      if($('#cmbtype').val()==''){
    			 $.messager.alert('Message','Please Choose Account Type.','warning');
    			 return 0;
    		  }
			  accountsSearchContent('accountsDetailsSearch.jsp');
		 });
		$('#aedLabel').hide();
	  	$('#aedbalance').hide();
	  	$('#cadlabel').hide();
	  	$('#cadbalance').hide();
	  	 $('#chflabel').hide();
	  				    $('#chfbalance').hide();
	  				     $('#eurlabel').hide();
	  				    $('#eurbalance').hide();
	  				     $('#usdlabel').hide();
	  				    $('#usdbalance').hide();
	  	getconfig();
	});
	
	function funExportBtn(){
	    //JSONToCSVConvertor(data, 'AgeingStatement', true);
		$("#ageingStatementDiv").excelexportjs({
			containerid: "ageingStatementDiv",
			datatype: 'json', 
			dataset: null, 
			gridId: "ageingStatement", 
			columns: getColumns("ageingStatement") , 
			worksheetName: "Ageing Statement"
		});

	}

	
	function accountsSearchContent(url) {
	    $('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getSalesPerson() {
		// alert(document.getElementById("lbldetailname").innerText);
		 if(document.getElementById("lbldetailname").innerText=="Current Ageing"){
			$('#uptodate').jqxDateTimeInput({disabled: true});
		 }
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
		  if($('#cmbtype').val()==''){
    		  $.messager.alert('Message','Please Choose Account Type.','warning');
    		  return 0;
    	  }
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
			 $.messager.alert('Message','Please Choose a Client/Supplier.','warning');
			 return 0;
		 }
		
  	if ($("#txtacountno").val()!="") {
	        var url=document.URL;
	        var reurl=url.split("ageingStatement.jsp");
	        console.log("ac print");   
	        $("#txtacountno").prop("disabled", false);
	        var win= window.open(reurl[0]+"printAgeingOutstandingsStatement?&acno="+document.getElementById("txtacountno").value+'&atype='+document.getElementById("cmbtype").value+'&level1from='+level1from+'&level1to='+level1to+'&level2from='+level2from+'&level2to='+level2to+'&level3from='+level3from+'&level3to='+level3to+'&level4from='+level4from+'&level4to='+level4to+'&level5from='+level5from+'&branch='+document.getElementById("cmbbranch").value+'&uptoDate='+$("#uptodate").val()+'&email=Nil&print=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        win.focus();
			funGetOutstandingTable();  
	     }
	    else {
	    	$.messager.alert('Message','Please Choose a Client/Supplier.','warning');
			return;
		}
	   }
	
	function funauditletterprint(){
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
			 $.messager.alert('Message','Please Choose a Client/Supplier.','warning');
			 return 0;
		 }
		
 	if ($("#txtacountno").val()!="") {
	        var url=document.URL;
	        var reurl=url.split("ageingStatement.jsp");
	        
	        $("#txtacountno").prop("disabled", false);
	        var win= window.open(reurl[0]+"printAuditconfirmationletter?balance="+document.getElementById("txtbalance").value.replace(',','')+"&acno="+document.getElementById("txtacountno").value+'&atype='+document.getElementById("cmbtype").value+'&level1from='+level1from+'&level1to='+level1to+'&level2from='+level2from+'&level2to='+level2to+'&level3from='+level3from+'&level3to='+level3to+'&level4from='+level4from+'&level4to='+level4to+'&level5from='+level5from+'&branch='+document.getElementById("cmbbranch").value+'&uptoDate='+$("#uptodate").val(),+'&email=Nil&print=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        win.focus();
			//funGetOutstandingTable();  
	     }
	    else {
	    	$.messager.alert('Message','Please Choose a Client/Supplier.','warning');
			return;
		}
	   }
	
	
	function funSendingEmail() {  
		
	    var email = document.getElementById("txtaccemail").value;
	    var level1from = $('#txtlevel1from').val();
		var level1to = $('#txtlevel1to').val();
		var level2from = $('#txtlevel2from').val();
		var level2to = $('#txtlevel2to').val();
		var level3from = $('#txtlevel3from').val();
		var level3to = $('#txtlevel3to').val();
		var level4from = $('#txtlevel4from').val();
		var level4to = $('#txtlevel4to').val();
		var level5from = $('#txtlevel5from').val();
	    var res;var part1;var part2;var dotsplt;
	    if(email.indexOf("@")>=0) {
		    res = email.split('@');
		    part1=res[0];
		    part2=res[1];
		    dotsplt=part2.split('.');
	    }
	    
	   if ($("#txtacountno").val().trim()=="" || typeof($("#txtacountno").val().trim())=="undefined" || typeof($("#txtacountno").val().trim())=="NaN") {
		    $('#txtacountno').val('');
		    $.messager.alert('Message','Please Choose a Client/Supplier.','warning');
			return;
	  } else  if(email.trim()=="" || typeof(email.trim())=="undefined" || typeof(email.trim())=="NaN") {
		    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
	  } else if(email.indexOf("@")<0) {
		    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
	  } else if(email.split('@').length!=2) {
		    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
	  } else if(part1.length==0) {
		    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
	  } else if(part1.split(" ").length>2) {
		    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
      } else if(part2.split(".").length<2) {
    	    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
      } else if(dotsplt[0].length==0 ) {
    	    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
      } else if(dotsplt[1].length<2 ||dotsplt[1].length>4) {
    	    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return;
      } else {
 		
		    $("#overlay, #PleaseWait").show();
		   
	 		$.ajaxFileUpload ({  
	    	    	
	    	    	  url: 'printAgeingOutstandingsStatement.action?acno='+document.getElementById("txtacountno").value+'&atype='+document.getElementById("cmbtype").value+'&level1from='+level1from+'&level1to='+level1to+'&level2from='+level2from+'&level2to='+level2to+'&level3from='+level3from+'&level3to='+level3to+'&level4from='+level4from+'&level4to='+level4to+'&level5from='+level5from+'&branch='+document.getElementById("cmbbranch").value+'&uptoDate='+$("#uptodate").val()+'&email='+$('#txtaccemail').val()+'&print=0',  
	    	          secureuri:false,//false  
	    	          fileElementId:'file', //id  <input type="file" id="file" name="file" />  
	    	          dataType: 'string',// json  
	    	          success: function (data, status) {  
	
	    	             if(status=='success'){
							$("#overlay, #PleaseWait").hide();
							$.messager.alert('Message','E-Mail Send Successfully');
	    	              }
	    	             if(status=='error'){
	    	            	 $("#overlay, #PleaseWait").hide();
	    	            	 $.messager.alert('Message','E-Mail Sending failed');
	    	             }
	    	             
	    	              $("#testImg").attr("src",data.message);
	    	              if(typeof(data.error) != 'undefined')  
	    	              {  
	    	                  if(data.error != '')  
	    	                  {  
	    	                      alert(data.error);  
	    	                  }else  
	    	                  {  
	    	                      alert(data.message);  
	    	                  }  
	    	              }  
	    	          },  
	    	           error: function (data, status, e)
	    	          {  
	    	              alert(e);  
	    	          }  
	    	      }) 
	    	     return false;
 		
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
		 var clientstatus = $('#cmbclientstatus').val();
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
		 
		 $("#ageingStatementDiv").load("ageingStatementGrid.jsp?branchval="+branchval+'&uptodate='+uptodate+'&atype='+atype+'&accdocno='+accdocno+'&salesperson='+salesperson+'&category='+category+'&level1from='+level1from+'&level1to='+level1to+'&level2from='+level2from+'&level2to='+level2to
				 +'&level3from='+level3from+'&level3to='+level3to+'&level4from='+level4from+'&level4to='+level4to+'&level5from='+level5from+'&clientstatus='+clientstatus+'&check='+check);
		 
		}
	
	
		function funGetOutstandingTable() {
		$("#overlay, #PleaseWait").show();
		var acno=document.getElementById("txtacountno").value;
		var atype=document.getElementById("cmbtype").value;
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
		var branch=document.getElementById("cmbbranch").value;
		var uptoDate=$("#uptodate").jqxDateTimeInput('val');
		
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				$("#overlay, #PleaseWait").hide();
				$('#ageingStatementDiv').append($.parseHTML(items.split("::")[0]));
				$("#ageingStatementDiv").excelexportjs({
					containerid: "tabledata",
					datatype: 'table', 
					dataset: $.parseHTML(items.split("::")[0]),
					worksheetName: items.split("::")[1]
				});
				
			} else {
			}
		}
		x.open("GET", "getOutstandingTable.jsp?acno="+acno+"&atype="+atype+"&level1from="+level1from+"&level1to="+level1to+"&level2from="+level2from+"&level2to="+level2to+"&level3from="+level3from+"&level3to="+level3to+"&level4from="+level4from+"&level4to="+level4to+"&level5from="+level5from+"&branch="+branch+"&uptoDate="+uptoDate+"&email=Nil&print=1", true);
		x.send();
	}
		
		function funApplyingCrrct(){
			var acno=document.getElementById("txtacountno").value;
			if(acno=="" || acno==null){
					$.messager.alert('Message','Please Select the Account','warning');
					return 0;

			}
			 $.messager.confirm('Message', 'Do you want to Apply Correction on account number : '+acno, function(r){
			        
			     	if(r==false)
			     	  {
			     		return false; 
			     	  }
			     	else{
			     		 $("#overlay, #PleaseWait").show();
			 			
			 			var x = new XMLHttpRequest();
			 			x.onreadystatechange = function() {
			 				if (x.readyState == 4 && x.status == 200) {
			 					var items = x.responseText.trim();
			 					$("#overlay, #PleaseWait").hide();
			 					$.messager.alert('Message','Applying Data corrected','warning');
			 					 
			 					
			 				} else {
			 				}
			 			}
			 			x.open("GET","ApplyingCorrection.jsp?accountno="+acno, true);
			 			x.send();	
			     	}
			 });
			
			
		}
	
	function funGetCurrDetails() {
	var rows = $('#ageingStatement').jqxGrid('getrows');
	if(rows.length>0){
		var acno=document.getElementById("txtacountno").value;
		var atype=document.getElementById("cmbtype").value;
		 var accdocno = $('#txtdocno').val();
		var branch=document.getElementById("cmbbranch").value;
		var uptoDate=$("#uptodate").jqxDateTimeInput('val');
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.split("####");
				if(parseInt(items[5])){
				if(parseInt(items[0] == 0)){  
	  				    $('#aedLabel').hide();
	  				    $('#aedbalance').hide();
	  				} else {
	  					$('#aedLabel').show();
	  				    $('#aedbalance').show();
	  				   document.getElementById('aedbalance').innerHTML =parseFloat(items[0]);
	  				}
				if(parseInt(items[1]) == 0){    
	  				    $('#cadlabel').hide();
	  				    $('#cadbalance').hide();
	  				} else {
	  					$('#cadlabel').show();
	  				    $('#cadbalance').show();
	  				    document.getElementById('cadbalance').innerHTML =items[1];
	  				}
				if(items[2] == ''){  
	  				    $('#chflabel').hide();
	  				    $('#chfbalance').hide();
	  				} else {
	  					$('#chflabel').show();
	  				    $('#chfbalance').show();
	  				    document.getElementById('chfbalance').innerHTML =items[2];
	  				}
				if(items[3] == ''){  
	  				    $('#eurlabel').hide();
	  				    $('#eurbalance').hide();
	  				} else {
	  					$('#eurlabel').show();
	  				    $('#eurbalance').show();
	  				    document.getElementById('eurbalance').innerHTML =items[3];
	  				}
				if(items[4] == ''){  
	  				    $('#usdlabel').hide();
	  				    $('#usdbalance').hide();
	  				} else {
	  					$('#usdlabel').show();
	  				    $('#usdbalance').show();
	  				    document.getElementById('usdbalance').innerHTML =items[4];
	  				}
	  				}
				
			} else {
			}
		}
		
		x.open("GET", "getCurrncyDetails.jsp?acno="+accdocno+"&atype="+atype+"&branch="+branch+"&uptoDate="+uptoDate+"", true);
		x.send();
		}
	}
		
		function funAutoApply(){
			var accno = $('#txtacountno').val();
			var atype=document.getElementById("cmbtype").value;
			if(accno==''){
				 $.messager.alert('Message','Please Choose a Client/Supplier.','warning');
				 return 0;
			 }
			/* if(atype!='AR'){
				 $.messager.alert('Message','Option for Client only','warning');
				 return 0;
			 } */
			$("#overlay, #PleaseWait").show();
			
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText.trim();
					$("#overlay, #PleaseWait").hide();
					if(items=="S"){
						$.messager.alert('Message','Succesfully Applied','warning');
					
					} else {
						// $.messager.alert('Message','Not Applied','warning');
					}
					}
			}
			x.open("GET", "applydelete.jsp?acno="+accno+"&uptodate="+$("#uptodate").val()+"&atype="+document.getElementById("cmbtype").value, true );
			x.send();
		
		}
		

		  function getconfig() {
					var x = new XMLHttpRequest();
					x.onreadystatechange = function() {
						if (x.readyState == 4 && x.status == 200) {
							items = x.responseText;
							items = items.split('####');
							//alert(items[0])
							if (items[0]==1) 
							{
								$('#btnApply').hide();
					       }
						} 
						else {
							$('#btnApply').show();
						}
					}
					x.open("GET", "getconfig.jsp", true);
					x.send();
				}	
		
		
	
		
		
</script>
</head>
<body onload="getBranch();getSalesPerson();getCategory();">
	<div id="mainBG" class="homeContent" data-type="background">
		<div class='hidden-scrollbar'>
		<div class="master-container">
    <div class="sidebar-filters">
        <div class="sidebar-fixed-top">
            <div class="filter-card" style="background: none !important; border: none !important;">
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
                            <select id="cmbtype" name="cmbtype" onchange="clearAccountInfo();getCategory();" value='<s:property value="cmbtype"/>'>
                                <option value="">--Select--</option>
                                <option value="AR" selected>AR</option>
                                <option value="AP">AP</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Account</td>
                        <td>
                            <input type="text" id="txtaccid" name="txtaccid" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>' onkeydown="getAccType(event);" />
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <input type="text" id="txtaccname" name="txtaccname" readonly="readonly" value='<s:property value="txtaccname"/>' tabindex="-1" style="margin-top:-5px;"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Sales Person</td>
                        <td>
                            <select id="cmbsalesperson" name="cmbsalesperson" value='<s:property value="cmbsalesperson"/>'>
                                <option value="">--Select--</option>
                            </select>
                            <input type="hidden" id="hidcmbsalesperson" name="hidcmbsalesperson" value='<s:property value="hidcmbsalesperson"/>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Category</td>
                        <td>
                            <select id="cmbcategory" name="cmbcategory" value='<s:property value="cmbcategory"/>'>
                                <option value="">--Select--</option>
                            </select>
                            <input type="hidden" id="hidcmbcategory" name="hidcmbcategory" value='<s:property value="hidcmbcategory"/>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Status</td>
                        <td>
                            <select id="cmbclientstatus" name="cmbclientstatus" value='<s:property value="cmbclientstatus"/>'>
                                <option value=''>-- Select --</option>
                                <option value='0'>Active</option>
                                <option value='1'>Litigation</option>
                                <option value='2'>Dispute</option>
                                <option value='3'>Over Due</option>
                            </select>
                            <input type="hidden" id="hidcmbclientstatus" name="hidcmbclientstatus" value='<s:property value="hidcmbclientstatus"/>' />
                        </td>
                    </tr>
                </table>
            </div>

            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Level 1</td>
                        <td class="level-row">
                            <input type="text" id="txtlevel1from" name="txtlevel1from" class="level-input" readonly value='0' />
                            <span>-</span>
                            <input type="text" id="txtlevel1to" name="txtlevel1to" class="level-input" onblur="changelevel1();" value='30' />
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Level 2</td>
                        <td class="level-row">
                            <input type="text" id="txtlevel2from" name="txtlevel2from" class="level-input" readonly value='31' />
                            <span>-</span>
                            <input type="text" id="txtlevel2to" name="txtlevel2to" class="level-input" onblur="changelevel2();" value='60' />
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Level 3</td>
                        <td class="level-row">
                            <input type="text" id="txtlevel3from" name="txtlevel3from" class="level-input" readonly value='61' />
                            <span>-</span>
                            <input type="text" id="txtlevel3to" name="txtlevel3to" class="level-input" onblur="changelevel3();" value='90' />
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Level 4</td>
                        <td class="level-row">
                            <input type="text" id="txtlevel4from" name="txtlevel4from" class="level-input" readonly value='91' />
                            <span>-</span>
                            <input type="text" id="txtlevel4to" name="txtlevel4to" class="level-input" onblur="changelevel4();" value='120' />
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Level 5</td>
                        <td class="level-row">
                            <input type="text" id="txtlevel5from" name="txtlevel5from" class="level-input" value='121' />
                            <span style="font-weight: bold;">&ge;</span>
                        </td>
                    </tr>
                </table>
            </div>

            <button class="myButton" type="button" onclick="funOutStandingStatement();">Outstanding Statement</button>
            <button class="myButton" type="button" onclick="funApplyingCrrct();">Applying Correct</button>
            <button class="myButton" type="button" onclick="funAutoApply();">Auto Apply</button>

            <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>' />
            <input type="hidden" id="txtacountno" name="txtacountno" value='<s:property value="txtacountno"/>' />
            <input type="hidden" id="txtaccemail" name="txtaccemail" value='<s:property value="txtaccemail"/>' />
            <input type="hidden" id="txtbalance" name="txtbalance" value='<s:property value="txtbalance"/>' />
            <input type="hidden" id="txtbranch" name="txtbranch" value='<s:property value="txtbranch"/>' />
            <div hidden="true"><button type="button" onclick="funauditletterprint();">Audit Balance Letter</button></div>
        </div>
    </div>

    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <table width="100%">
                <tr>
                    <td>
                        <div id="ageingStatementDiv">
                            <jsp:include page="ageingStatementGrid.jsp"></jsp:include>
                        </div>
                    </td>
                </tr>
            </table>
        </div>

        <div class="totals-bar">
            <table width="100%">
                <tr>
                    <td width="10%" align="right" style="font-family: Myriad Pro; font-size: 12px; font-weight: bold;">Net Total:</td>
                    <td width="10%"><input type="text" class="textbox" id="txtnetbalance" name="txtnetbalance" readonly value='<s:property value="txtnetbalance"/>' /></td>

                    <td width="8%" align="right" style="font-family: Myriad Pro; font-size: 11px; font-weight: bold;">AED:</td>
                    <td width="8%"><label class="textbox" id="aedbalance" style="display:block; line-height:25px;"></label></td>

                    <td width="8%" align="right" style="font-family: Myriad Pro; font-size: 11px; font-weight: bold;">CAD:</td>
                    <td width="8%"><label class="textbox" id="cadbalance" style="display:block; line-height:25px;"></label></td>

                    <td width="8%" align="right" style="font-family: Myriad Pro; font-size: 11px; font-weight: bold;">CHF:</td>
                    <td width="8%"><label class="textbox" id="chfbalance" style="display:block; line-height:25px;"></label></td>

                    <td width="8%" align="right" style="font-family: Myriad Pro; font-size: 11px; font-weight: bold;">EUR:</td>
                    <td width="8%"><label class="textbox" id="eurbalance" style="display:block; line-height:25px;"></label></td>

                    <td width="8%" align="right" style="font-family: Myriad Pro; font-size: 11px; font-weight: bold;">USD:</td>
                    <td width="8%"><label class="textbox" id="usdbalance" style="display:block; line-height:25px;"></label></td>
                </tr>
            </table>
        </div>
    </div>
</div>
		</div>

		<div id="accountDetailsWindow">
			<div></div>
			<div></div>
		</div>
	</div>
</body>
</html>