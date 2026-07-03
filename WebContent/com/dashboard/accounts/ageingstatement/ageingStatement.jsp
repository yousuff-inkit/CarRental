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
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>



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
		 _agData = null;
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
		

		/* ===================== AGEING DASHBOARD ===================== */
		var _agData = null;
		var _agCharts = {};
		var _AC = {T:'#1D9E75',B:'#185FA5',B2:'#378ADD',A:'#EF9F27',C:'#D85A30',R:'#E24B4A',G:'#888780',P:'#7F77DD'};
		var _PALETTE = [_AC.B,_AC.T,_AC.A,_AC.C,_AC.P,_AC.B2,_AC.R,_AC.G,'#9B59B6','#2ECC71','#F39C12','#1ABC9C','#E74C3C','#3498DB','#8E44AD'];

		function showAgView(v){
			if(v==='dash'){
				document.getElementById('agBtnGrid').classList.remove('active');
				document.getElementById('agBtnDash').classList.add('active');
				document.getElementById('ageingStatementGridWrap').style.display='none';
				document.getElementById('agDashboard').style.display='block';
				buildAgDashboard();
			} else {
				document.getElementById('agBtnDash').classList.remove('active');
				document.getElementById('agBtnGrid').classList.add('active');
				document.getElementById('agDashboard').style.display='none';
				document.getElementById('ageingStatementGridWrap').style.display='block';
			}
		}

		function switchAgTab(tab){
			document.querySelectorAll('.d-tab[id^="agt_"]').forEach(function(b){b.classList.remove('active');});
			document.querySelectorAll('.d-panel[id^="agp_"]').forEach(function(p){p.classList.remove('active');});
			document.getElementById('agt_'+tab).classList.add('active');
			document.getElementById('agp_'+tab).classList.add('active');
		}

		function _agDcDestroy(){
			Object.keys(_agCharts).forEach(function(k){try{_agCharts[k].destroy();}catch(e){}});
			_agCharts={};
		}

		function _agFmt(v){
			v=parseFloat(v)||0;
			if(Math.abs(v)>=1000000) return (v/1000000).toFixed(2)+'M';
			if(Math.abs(v)>=1000) return (v/1000).toFixed(1)+'K';
			return v.toFixed(2);
		}

		function _agPct(v,t){ return t>0?((v/t)*100).toFixed(1)+'%':'0%'; }

		function _agSetKpi(id,val,sub,color){
			var el=document.getElementById(id); if(!el) return;
			var c=color?'color:'+color+';':'';
			el.innerHTML='<div class="d-metric-val" style="'+c+'">'+val+'</div><div class="d-metric-sub">'+sub+'</div>';
		}

		function _agGrpBy(rows,field){
			var grp={};
			rows.forEach(function(r){
				var k=r[field]||'(None)';
				if(!grp[k]) grp[k]={balance:0,advance:0,unapplied:0,total:0,l1:0,l2:0,l3:0,l4:0,l5:0,count:0,creditlimit:0};
				grp[k].balance   +=parseFloat(r.balance)  ||0;
				grp[k].advance   +=parseFloat(r.advance)  ||0;
				grp[k].unapplied +=parseFloat(r.unapplied)||0;
				grp[k].total     +=parseFloat(r.total)    ||0;
				grp[k].l1        +=parseFloat(r.level_1)  ||0;
				grp[k].l2        +=parseFloat(r.level_2)  ||0;
				grp[k].l3        +=parseFloat(r.level_3)  ||0;
				grp[k].l4        +=parseFloat(r.level_4)  ||0;
				grp[k].l5        +=parseFloat(r.level_5)  ||0;
				grp[k].creditlimit+=parseFloat(r.creditlimit)||0;
				grp[k].count++;
			});
			return grp;
		}

		function _agLbls(){
			return [
				($('#txtlevel1from').val()||'0')+'-'+($('#txtlevel1to').val()||'30')+'d',
				($('#txtlevel2from').val()||'31')+'-'+($('#txtlevel2to').val()||'60')+'d',
				($('#txtlevel3from').val()||'61')+'-'+($('#txtlevel3to').val()||'90')+'d',
				($('#txtlevel4from').val()||'91')+'-'+($('#txtlevel4to').val()||'120')+'d',
				'>'+($('#txtlevel5from').val()||'121')+'d'
			];
		}

		function buildAgDashboard(){
			var rows=$('#ageingStatement').jqxGrid('getrows');
			var msg=document.getElementById('agDashMsg');
			var tabs=document.getElementById('agDashTabs');
			if(!rows||rows.length===0){
				msg.style.display='block'; tabs.style.display='none';
				msg.innerHTML='<div style="padding:60px;text-align:center;color:#aaa;">No data loaded. Load the grid first then switch to dashboard.</div>';
				return;
			}
			if(_agData){
				msg.style.display='none'; tabs.style.display='block'; return;
			}
			msg.style.display='block'; tabs.style.display='none';
			msg.innerHTML='<div style="padding:40px;text-align:center;color:#888;">Building analytics...</div>';
			_agDcDestroy();
			_agData=rows;
			setTimeout(function(){
				_agRenderOverview(rows);
				_agRenderByCategory(rows);
				_agRenderBySP(rows);
				_agRenderBuckets(rows);
				_agRenderCredit(rows);
				_agRenderTopDebtors(rows);
				msg.style.display='none'; tabs.style.display='block';
			},60);
		}

		function _agRenderOverview(rows){
			var totBal=0,totAdv=0,totUnap=0,totL1=0,totL2=0,totL3=0,totL4=0,totL5=0;
			rows.forEach(function(r){
				totBal  +=parseFloat(r.balance)  ||0;
				totAdv  +=parseFloat(r.advance)  ||0;
				totUnap +=parseFloat(r.unapplied)||0;
				totL1   +=parseFloat(r.level_1)  ||0;
				totL2   +=parseFloat(r.level_2)  ||0;
				totL3   +=parseFloat(r.level_3)  ||0;
				totL4   +=parseFloat(r.level_4)  ||0;
				totL5   +=parseFloat(r.level_5)  ||0;
			});
			var totOverdue=totL3+totL4+totL5;
			var netRec=totBal-totAdv;
			_agSetKpi('ag_ov_count',  rows.length,        'Total Accounts');
			_agSetKpi('ag_ov_balance',_agFmt(totBal),     'Total Balance',_AC.B);
			_agSetKpi('ag_ov_advance',_agFmt(totAdv),     'Total Advance',_AC.A);
			_agSetKpi('ag_ov_net',    _agFmt(netRec),     'Net Receivable',netRec>=0?_AC.T:_AC.R);
			_agSetKpi('ag_ov_overdue',_agFmt(totOverdue), 'Overdue >60 days',_AC.R);
			_agSetKpi('ag_ov_unap',   _agFmt(totUnap),    'Unapplied',_AC.C);

			var ctxD=document.getElementById('ag_ch_ov_donut').getContext('2d');
			_agCharts['ov_donut']=new Chart(ctxD,{type:'doughnut',data:{
				labels:['Balance','Advance','Unapplied','Overdue >60d'],
				datasets:[{data:[totBal,totAdv,totUnap,totOverdue],
					backgroundColor:[_AC.B,_AC.A,_AC.C,_AC.R],borderWidth:2}]
			},options:{responsive:true,plugins:{legend:{position:'bottom',labels:{font:{size:11}}}}}});

			var ll=_agLbls();
			var ctxB=document.getElementById('ag_ch_ov_bucket').getContext('2d');
			_agCharts['ov_bucket']=new Chart(ctxB,{type:'bar',data:{
				labels:ll,
				datasets:[{label:'Amount',data:[totL1,totL2,totL3,totL4,totL5],
					backgroundColor:[_AC.T,_AC.B2,_AC.A,_AC.C,_AC.R]}]
			},options:{responsive:true,plugins:{legend:{display:false}},
				scales:{y:{beginAtZero:true,ticks:{callback:function(v){return _agFmt(v);}}}}}});
		}

		function _agRenderByCategory(rows){
			var grp=_agGrpBy(rows,'catname');
			var keys=Object.keys(grp).sort(function(a,b){return grp[b].balance-grp[a].balance;});
			var topCat=keys[0]||'-';
			var mostOD=keys.slice().sort(function(a,b){return (grp[b].l3+grp[b].l4+grp[b].l5)-(grp[a].l3+grp[a].l4+grp[a].l5);})[0]||'-';
			var bestCat=keys.slice().sort(function(a,b){
				var pa=grp[a].balance>0?(grp[a].l3+grp[a].l4+grp[a].l5)/grp[a].balance:0;
				var pb=grp[b].balance>0?(grp[b].l3+grp[b].l4+grp[b].l5)/grp[b].balance:0;
				return pa-pb;
			})[0]||'-';
			_agSetKpi('ag_cat_count',keys.length,   'Categories');
			_agSetKpi('ag_cat_top',  topCat,        'Largest by Balance',_AC.B);
			_agSetKpi('ag_cat_od',   mostOD,        'Most Overdue >60d',_AC.R);
			_agSetKpi('ag_cat_best', bestCat,       'Lowest Overdue %',_AC.T);

			var ctxH=document.getElementById('ag_ch_cat_bar').getContext('2d');
			_agCharts['cat_bar']=new Chart(ctxH,{type:'bar',data:{
				labels:keys,
				datasets:[{label:'Balance',data:keys.map(function(k){return grp[k].balance;}),
					backgroundColor:keys.map(function(k,i){return _PALETTE[i%_PALETTE.length];})}]
			},options:{indexAxis:'y',responsive:true,plugins:{legend:{display:false}},
				scales:{x:{beginAtZero:true,ticks:{callback:function(v){return _agFmt(v);}}}}}});

			var ll=_agLbls();
			var ctxS=document.getElementById('ag_ch_cat_stacked').getContext('2d');
			_agCharts['cat_stacked']=new Chart(ctxS,{type:'bar',data:{labels:keys,datasets:[
				{label:ll[0],data:keys.map(function(k){return grp[k].l1;}),backgroundColor:_AC.T},
				{label:ll[1],data:keys.map(function(k){return grp[k].l2;}),backgroundColor:_AC.B2},
				{label:ll[2],data:keys.map(function(k){return grp[k].l3;}),backgroundColor:_AC.A},
				{label:ll[3],data:keys.map(function(k){return grp[k].l4;}),backgroundColor:_AC.C},
				{label:ll[4],data:keys.map(function(k){return grp[k].l5;}),backgroundColor:_AC.R}
			]},options:{responsive:true,plugins:{legend:{position:'bottom',labels:{font:{size:10}}}},
				scales:{x:{stacked:true},y:{stacked:true,beginAtZero:true,ticks:{callback:function(v){return _agFmt(v);}}}}}});
		}

		function _agRenderBySP(rows){
			var grp=_agGrpBy(rows,'sal_name');
			var keys=Object.keys(grp).filter(function(k){return k!='(None)';}).sort(function(a,b){return grp[b].balance-grp[a].balance;});
			if(grp['(None)']) keys.push('(None)');
			var topSP=keys[0]||'-';
			var mostOD=keys.slice().sort(function(a,b){return (grp[b].l3+grp[b].l4+grp[b].l5)-(grp[a].l3+grp[a].l4+grp[a].l5);})[0]||'-';
			var totBal=keys.reduce(function(s,k){return s+grp[k].balance;},0);
			var avgBal=keys.length>0?totBal/keys.length:0;
			_agSetKpi('ag_sp_count',keys.length,    'Sales Persons');
			_agSetKpi('ag_sp_top',  topSP,          'Largest Portfolio',_AC.B);
			_agSetKpi('ag_sp_od',   mostOD,         'Most Overdue >60d',_AC.R);
			_agSetKpi('ag_sp_avg',  _agFmt(avgBal), 'Avg Receivable / SP',_AC.A);

			var disp=keys.slice(0,12);
			var ctxH=document.getElementById('ag_ch_sp_bar').getContext('2d');
			_agCharts['sp_bar']=new Chart(ctxH,{type:'bar',data:{
				labels:disp,
				datasets:[{label:'Balance',data:disp.map(function(k){return grp[k].balance;}),
					backgroundColor:disp.map(function(k,i){return _PALETTE[i%_PALETTE.length];})}]
			},options:{indexAxis:'y',responsive:true,plugins:{legend:{display:false}},
				scales:{x:{beginAtZero:true,ticks:{callback:function(v){return _agFmt(v);}}}}}});

			var ll=_agLbls();
			var ctxS=document.getElementById('ag_ch_sp_stacked').getContext('2d');
			_agCharts['sp_stacked']=new Chart(ctxS,{type:'bar',data:{labels:disp,datasets:[
				{label:ll[0],data:disp.map(function(k){return grp[k].l1;}),backgroundColor:_AC.T},
				{label:ll[1],data:disp.map(function(k){return grp[k].l2;}),backgroundColor:_AC.B2},
				{label:ll[2],data:disp.map(function(k){return grp[k].l3;}),backgroundColor:_AC.A},
				{label:ll[3],data:disp.map(function(k){return grp[k].l4;}),backgroundColor:_AC.C},
				{label:ll[4],data:disp.map(function(k){return grp[k].l5;}),backgroundColor:_AC.R}
			]},options:{responsive:true,plugins:{legend:{position:'bottom',labels:{font:{size:10}}}},
				scales:{x:{stacked:true},y:{stacked:true,beginAtZero:true,ticks:{callback:function(v){return _agFmt(v);}}}}}});
		}

		function _agRenderBuckets(rows){
			var ll=_agLbls();
			var t1=0,t2=0,t3=0,t4=0,t5=0;
			rows.forEach(function(r){
				t1+=parseFloat(r.level_1)||0; t2+=parseFloat(r.level_2)||0;
				t3+=parseFloat(r.level_3)||0; t4+=parseFloat(r.level_4)||0; t5+=parseFloat(r.level_5)||0;
			});
			var grand=t1+t2+t3+t4+t5;
			_agSetKpi('ag_bk_l1',_agFmt(t1)+' ('+_agPct(t1,grand)+')',ll[0]+' (Current)',_AC.T);
			_agSetKpi('ag_bk_l2',_agFmt(t2)+' ('+_agPct(t2,grand)+')',ll[1],_AC.B2);
			_agSetKpi('ag_bk_l3',_agFmt(t3)+' ('+_agPct(t3,grand)+')',ll[2],_AC.A);
			_agSetKpi('ag_bk_l4',_agFmt(t4)+' ('+_agPct(t4,grand)+')',ll[3],_AC.C);
			_agSetKpi('ag_bk_l5',_agFmt(t5)+' ('+_agPct(t5,grand)+')',ll[4]+' (Oldest)',_AC.R);

			var ctxD=document.getElementById('ag_ch_bk_donut').getContext('2d');
			_agCharts['bk_donut']=new Chart(ctxD,{type:'doughnut',data:{labels:ll,datasets:[{
				data:[t1,t2,t3,t4,t5],backgroundColor:[_AC.T,_AC.B2,_AC.A,_AC.C,_AC.R],borderWidth:2}]
			},options:{responsive:true,plugins:{legend:{position:'bottom',labels:{font:{size:10}}}}}});

			var top10=rows.slice().sort(function(a,b){
				var oa=(parseFloat(a.level_3)||0)+(parseFloat(a.level_4)||0)+(parseFloat(a.level_5)||0);
				var ob=(parseFloat(b.level_3)||0)+(parseFloat(b.level_4)||0)+(parseFloat(b.level_5)||0);
				return ob-oa;
			}).slice(0,10);
			var ctxT=document.getElementById('ag_ch_bk_top').getContext('2d');
			_agCharts['bk_top']=new Chart(ctxT,{type:'bar',data:{
				labels:top10.map(function(r){return r.account_name||r.accno||'?';}),
				datasets:[
					{label:ll[2],data:top10.map(function(r){return parseFloat(r.level_3)||0;}),backgroundColor:_AC.A,stack:'s'},
					{label:ll[3],data:top10.map(function(r){return parseFloat(r.level_4)||0;}),backgroundColor:_AC.C,stack:'s'},
					{label:ll[4],data:top10.map(function(r){return parseFloat(r.level_5)||0;}),backgroundColor:_AC.R,stack:'s'}
				]
			},options:{indexAxis:'y',responsive:true,plugins:{legend:{position:'bottom',labels:{font:{size:10}}}},
				scales:{x:{stacked:true,beginAtZero:true,ticks:{callback:function(v){return _agFmt(v);}}},y:{stacked:true}}}});
		}

		function _agRenderCredit(rows){
			var withLim=rows.filter(function(r){return parseFloat(r.creditlimit)>0;});
			var overLim=0,nearLim=0,healthy=0,noLim=rows.length-withLim.length;
			var totCL=0,totBal=0;
			withLim.forEach(function(r){
				var bal=parseFloat(r.balance)||0,lim=parseFloat(r.creditlimit)||0;
				totCL+=lim; totBal+=bal;
				var u=lim>0?bal/lim:0;
				if(u>1) overLim++; else if(u>=0.8) nearLim++; else healthy++;
			});
			var avgUtil=totCL>0?(totBal/totCL*100).toFixed(1)+'%':'-';
			_agSetKpi('ag_cr_overlimit',overLim,          'Over Credit Limit',_AC.R);
			_agSetKpi('ag_cr_nearlimit',nearLim,          'Near Limit (>80%)',_AC.A);
			_agSetKpi('ag_cr_util',     avgUtil,          'Avg Utilisation',  _AC.B);
			_agSetKpi('ag_cr_total',    _agFmt(totCL),    'Total Credit Limit',_AC.T);

			var top15=withLim.slice().sort(function(a,b){return (parseFloat(b.balance)||0)-(parseFloat(a.balance)||0);}).slice(0,15);
			var ctxB=document.getElementById('ag_ch_cr_bar').getContext('2d');
			_agCharts['cr_bar']=new Chart(ctxB,{type:'bar',data:{
				labels:top15.map(function(r){return r.account_name||r.accno||'?';}),
				datasets:[
					{label:'Balance',     data:top15.map(function(r){return parseFloat(r.balance)||0;}),     backgroundColor:_AC.B},
					{label:'Credit Limit',data:top15.map(function(r){return parseFloat(r.creditlimit)||0;}), backgroundColor:_AC.G}
				]
			},options:{indexAxis:'y',responsive:true,plugins:{legend:{position:'bottom',labels:{font:{size:11}}}},
				scales:{x:{beginAtZero:true,ticks:{callback:function(v){return _agFmt(v);}}}}}});

			var ctxD=document.getElementById('ag_ch_cr_donut').getContext('2d');
			_agCharts['cr_donut']=new Chart(ctxD,{type:'doughnut',data:{
				labels:['Over Limit','Near Limit (>80%)','Healthy','No Limit Set'],
				datasets:[{data:[overLim,nearLim,healthy,noLim],
					backgroundColor:[_AC.R,_AC.A,_AC.T,_AC.G],borderWidth:2}]
			},options:{responsive:true,plugins:{legend:{position:'bottom',labels:{font:{size:10}}}}}});
		}

		function _agRenderTopDebtors(rows){
			var sorted=rows.slice().sort(function(a,b){return (parseFloat(b.total)||0)-(parseFloat(a.total)||0);});
			var totAll=rows.reduce(function(s,r){return s+(parseFloat(r.total)||0);},0);
			var top5Tot=sorted.slice(0,5).reduce(function(s,r){return s+(parseFloat(r.total)||0);},0);
			var zeroCount=rows.filter(function(r){return (parseFloat(r.total)||0)===0;}).length;
			var totUnap=rows.reduce(function(s,r){return s+(parseFloat(r.unapplied)||0);},0);
			_agSetKpi('ag_td_top',    sorted.length>0?(sorted[0].account_name||sorted[0].accno||'-'):'-','Largest Debtor',_AC.R);
			_agSetKpi('ag_td_top5pct',_agPct(top5Tot,totAll),'Top 5 Concentration',_AC.A);
			_agSetKpi('ag_td_zero',   zeroCount,             'Zero Balance Accounts',_AC.T);
			_agSetKpi('ag_td_unap',   _agFmt(totUnap),       'Total Unapplied',_AC.C);

			var top15=sorted.slice(0,15);
			var ctxB=document.getElementById('ag_ch_td_bar').getContext('2d');
			_agCharts['td_bar']=new Chart(ctxB,{type:'bar',data:{
				labels:top15.map(function(r){return r.account_name||r.accno||'?';}),
				datasets:[{label:'Total Balance',data:top15.map(function(r){return parseFloat(r.total)||0;}),
					backgroundColor:top15.map(function(r){
						var od=(parseFloat(r.level_3)||0)+(parseFloat(r.level_4)||0)+(parseFloat(r.level_5)||0);
						var tot=parseFloat(r.total)||0;
						if(tot>0&&od/tot>0.5) return _AC.R;
						if(tot>0&&od/tot>0.25) return _AC.A;
						return _AC.B;
					})
				}]
			},options:{indexAxis:'y',responsive:true,plugins:{legend:{display:false}},
				scales:{x:{beginAtZero:true,ticks:{callback:function(v){return _agFmt(v);}}}}}});

			var ll=_agLbls();
			var tbl='<table style="width:100%;font-size:11px;border-collapse:collapse;">';
			tbl+='<tr style="background:#f0f4f8;font-weight:700;"><td style="padding:6px 4px;">Account</td><td style="padding:6px 4px;">Category</td><td style="padding:6px 4px;text-align:right;">Balance</td><td style="padding:6px 4px;text-align:right;">Overdue</td></tr>';
			sorted.slice(0,12).forEach(function(r,i){
				var od=(parseFloat(r.level_3)||0)+(parseFloat(r.level_4)||0)+(parseFloat(r.level_5)||0);
				var tot=parseFloat(r.total)||0;
				var bg=i%2===0?'#fff':'#f8fafc';
				var oc=od>0?_AC.R:'#333';
				tbl+='<tr style="background:'+bg+';"><td style="padding:5px 4px;">'+(r.account_name||r.accno||'?')+'</td>';
				tbl+='<td style="padding:5px 4px;color:#888;">'+(r.catname||'-')+'</td>';
				tbl+='<td style="padding:5px 4px;text-align:right;font-weight:600;">'+_agFmt(tot)+'</td>';
				tbl+='<td style="padding:5px 4px;text-align:right;color:'+oc+';">'+_agFmt(od)+' ('+_agPct(od,tot)+')</td></tr>';
			});
			tbl+='</table>';
			document.getElementById('ag_td_table').innerHTML=tbl;
		}
		/* ===================== END DASHBOARD ===================== */

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

<style type="text/css">
/* ===== AGGRESSIVE OVERRIDES TO DESTROY BLUE BACKGROUNDS & HOVERS ===== */
html, body, #mainBG, .homeContent, .hidden-scrollbar {
    height: 100%;
    margin: 0 !important;
    padding: 0 !important;
    overflow: hidden !important;
    background-color: #ffffff !important;
    background: #ffffff !important;
    background-image: none !important;
}

/* Force layout tables to white */
.master-layout-table, 
.master-layout-table > tbody > tr, 
.master-layout-table > tbody > tr > td {
    background-color: #ffffff !important;
    background: #ffffff !important;
}

/* Forcefully kill all hover states on tables applied by external CSS */
table tr:hover, 
table td:hover, 
table th:hover, 
tbody tr:hover {
    background-color: transparent !important;
    background: transparent !important;
}

/* ===== MASTER LAYOUT ===== */
.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    background-color: #ffffff !important; 
    margin: 0 !important;
    padding: 0 !important;
}

/* Sidebar */
.sidebar-filters {
    width: 330px;
    flex: 0 0 330px;
    background: #ffffff !important;
    display: flex;
    flex-direction: column;
    height: 100vh;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
    border-right: 1px solid #e1e8ed;
}

/* Flex 1 allows this middle section to scroll while keeping bottom fixed */
.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 20px; 
}

/* Fixed bottom panel so buttons are always visible */
.sidebar-fixed-bottom {
    padding: 15px 20px;
    border-top: 1px solid #e1e8ed;
    background: #ffffff !important;
}

/* Cards */
.filter-card {
    background: #f8fafc !important;
    border: 1px solid #e3e8ee;
    border-radius: 8px;
    padding: 15px; 
    margin-bottom: 12px;
}

/* Tables within the card */
.filter-table {
    width: 100%;
    border-spacing: 0 10px; 
    background: transparent !important;
}

.filter-table tr, .filter-table td {
    background: transparent !important;
    border: none !important;
}

.filter-table .label-cell {
    text-align: right;
    padding-right: 12px;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    width: 90px;
    white-space: nowrap; 
}

/* ===== UNIFORM 24px INPUTS & SELECTS ===== */
input[type="text"], select,
.filter-table input[type="text"],
.filter-table select {
    width: 100%;
    height: 24px !important;             
    padding: 2px 8px !important;         
    border: 1px solid #ccd6e0 !important;
    border-radius: 4px !important;       
    font-size: 12px !important;          
    background-color: #ffffff !important;
    box-sizing: border-box;
    color: #333;
    outline: none;
}

select {
    padding: 2px 24px 2px 8px !important; 
    font-family: inherit;
    cursor: pointer;
    appearance: none;
    -webkit-appearance: none;
    background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%234e5e71' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
    background-repeat: no-repeat;
    background-position: right 6px center;
    background-size: 12px;
}

input[readonly], input:disabled, select:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    cursor: not-allowed;
}

/* ===== BUTTONS ===== */
.button-group {
    display: flex;
    gap: 10px;
    justify-content: center;
}

.btn-submit, .myButton, .myButtons {
    flex: 1;
    height: 30px !important;            
    padding: 0 12px !important;         
    background: #2563eb !important;
    color: #fff !important;
    border: none !important;
    border-radius: 4px !important;      
    font-size: 13px !important;
    font-weight: 600 !important;
    cursor: pointer;
    line-height: 30px !important;       
    text-align: center;
    transition: background 0.2s;
    width: 100%;
    margin-top: 0;
}

.btn-submit:hover, .myButton:hover, .myButtons:hover {
    background: #1d4ed8 !important;
}

/* Layout Utilities */
.main-content-wrapper {
    flex: 1;
    width: 100%;
    display: flex;
    flex-direction: column;
    padding: 15px;
    background: #fff !important;
    height: 100vh;
    box-sizing: border-box;
}

.scrollable-grid-area {
    flex: 1;
    width: 100%;
    overflow: auto;
}

/* Global Overrides for Labels */
.sidebar-filters label.branch, 
.sidebar-filters .filter-card label,
.sidebar-filters .branch {
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
    padding-left: 4px;
    background: transparent !important;
    background-color: transparent !important;
}

/* View Toggle Bar specific styles */
.view-btn {
    padding: 6px 12px;
    border: 1px solid #ccd6e0;
    border-radius: 4px;
    background: #fff;
    color: #4e5e71;
    font-size: 12px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.2s;
}
.view-btn:hover { background: #f3f6f9; }
.view-btn.active { background: #e0f2fe; color: #1d4ed8; border-color: #93c5fd; }

/* Dashboard Styles (placeholder for the layout you provided) */
.d-tabs { display:flex; gap:10px; margin-bottom:15px; border-bottom:1px solid #e1e8ed; padding-bottom:10px; }
.d-tab { padding:6px 12px; border:none; background:none; cursor:pointer; font-size:13px; font-weight:600; color:#4e5e71; border-radius:4px; }
.d-tab.active { background:#e0f2fe; color:#1d4ed8; }
.d-panel { display:none; }
.d-panel.active { display:block; }
.d-metric-grid { display:grid; grid-template-columns:repeat(auto-fit, minmax(150px, 1fr)); gap:15px; margin-bottom:20px; }
.d-metric { background:#f8fafc; border:1px solid #e3e8ee; padding:15px; border-radius:8px; text-align:center; }
.d-chart-row { display:flex; gap:15px; margin-bottom:20px; flex-wrap:wrap; }
.d-chart-box { background:#fff; border:1px solid #e3e8ee; border-radius:8px; padding:15px; }
.d-chart-title { font-size:13px; font-weight:bold; color:#4e5e71; margin-bottom:10px; text-align:center; }
.totals-bar { background:#f8fafc; border-top:1px solid #e1e8ed; padding:10px 15px; margin-top:auto; }

	
</style>
</head>
<body onload="getBranch();getSalesPerson();getCategory();">

<div id="mainBG" class="homeContent" data-type="background">
<div class='hidden-scrollbar'>

<table class="master-layout-table" width="100%" height="100%" cellpadding="0" cellspacing="0" border="0" style="background-color: #ffffff !important;">
<tr>

<td width="330px" valign="top" style="vertical-align: top; padding: 0 !important; margin: 0 !important; background: #ffffff !important; border-right: 1px solid #e1e8ed;">
    <div class="master-container">
        <div class="sidebar-filters">
            
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
                                <input type="text" id="txtaccname" name="txtaccname" readonly="readonly" value='<s:property value="txtaccname"/>' tabindex="-1" style="background-color: #f3f6f9 !important; border: 1px solid #e3e8ee !important;" />
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
                            <td style="display:flex; gap:6px; align-items:center;">
                                <input type="text" id="txtlevel1from" name="txtlevel1from" readonly value='0' style="flex:1; text-align:center; background-color: #f3f6f9 !important;" />
                                <span style="font-weight:bold; color:#4e5e71;">-</span>
                                <input type="text" id="txtlevel1to" name="txtlevel1to" onblur="changelevel1();" value='30' style="flex:1; text-align:center;" />
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Level 2</td>
                            <td style="display:flex; gap:6px; align-items:center;">
                                <input type="text" id="txtlevel2from" name="txtlevel2from" readonly value='31' style="flex:1; text-align:center; background-color: #f3f6f9 !important;" />
                                <span style="font-weight:bold; color:#4e5e71;">-</span>
                                <input type="text" id="txtlevel2to" name="txtlevel2to" onblur="changelevel2();" value='60' style="flex:1; text-align:center;" />
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Level 3</td>
                            <td style="display:flex; gap:6px; align-items:center;">
                                <input type="text" id="txtlevel3from" name="txtlevel3from" readonly value='61' style="flex:1; text-align:center; background-color: #f3f6f9 !important;" />
                                <span style="font-weight:bold; color:#4e5e71;">-</span>
                                <input type="text" id="txtlevel3to" name="txtlevel3to" onblur="changelevel3();" value='90' style="flex:1; text-align:center;" />
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Level 4</td>
                            <td style="display:flex; gap:6px; align-items:center;">
                                <input type="text" id="txtlevel4from" name="txtlevel4from" readonly value='91' style="flex:1; text-align:center; background-color: #f3f6f9 !important;" />
                                <span style="font-weight:bold; color:#4e5e71;">-</span>
                                <input type="text" id="txtlevel4to" name="txtlevel4to" onblur="changelevel4();" value='120' style="flex:1; text-align:center;" />
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Level 5</td>
                            <td style="display:flex; gap:6px; align-items:center;">
                                <input type="text" id="txtlevel5from" name="txtlevel5from" value='121' style="flex:1; text-align:center;" />
                                <span style="font-weight:bold; color:#4e5e71; font-size:14px; width:100%; text-align:center;">&ge;</span>
                            </td>
                        </tr>
                    </table>
                </div>

                <div style="display:none;">
                    <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>' />
                    <input type="hidden" id="txtacountno" name="txtacountno" value='<s:property value="txtacountno"/>' />
                    <input type="hidden" id="txtaccemail" name="txtaccemail" value='<s:property value="txtaccemail"/>' />
                    <input type="hidden" id="txtbalance" name="txtbalance" value='<s:property value="txtbalance"/>' />
                    <input type="hidden" id="txtbranch" name="txtbranch" value='<s:property value="txtbranch"/>' />
                    <button type="button" onclick="funauditletterprint();">Audit Balance Letter</button>
                </div>

            </div>

            <div class="sidebar-fixed-bottom" style="display:flex; flex-direction:column; gap:5px;">
                <button class="myButton" type="button" onclick="funOutStandingStatement();">Outstanding Statement</button>
                <button class="myButton" type="button" onclick="funApplyingCrrct();" style="background:#059669 !important;">Applying Correct</button>
                <button class="myButton" type="button" onclick="funAutoApply();" style="background:#4e5e71 !important;">Auto Apply</button>
            </div>

        </div>
    </div>
</td>

<td class="right-panel" valign="top" style="padding: 0; background: #ffffff !important; display:flex; flex-direction:column; height:100vh;">

    <div style="padding: 15px 20px 0 20px; background: #ffffff !important;">
        <jsp:include page="../../heading.jsp"></jsp:include>
    </div>

    <div class="main-content-wrapper" style="padding: 0; flex:1;">
        
        <div style="display:flex;align-items:center;gap:8px;padding:9px 20px;background:#fff;border-bottom:1px solid #e1e8ed;flex-wrap:wrap;">
            <button type="button" id="agBtnGrid" onclick="showAgView('grid')" class="view-btn active">Grid View</button>
            <button type="button" id="agBtnDash" onclick="showAgView('dash')" class="view-btn">Analytics Dashboard</button>
            <div style="margin-left:auto;display:flex;gap:8px;">
                <button type="button" onclick="funExportBtn()" class="view-btn" style="background:#059669;color:#fff;">Export Excel</button>
                <button type="button" onclick="funreload('')" class="view-btn" style="background:#2563eb;color:#fff;border:none;">Load / Refresh</button>
            </div>
        </div>

        <div class="scrollable-grid-area" style="padding: 15px 20px;">
            <div id="ageingStatementGridWrap">
                <table width="100%" cellpadding="0" cellspacing="0" border="0" style="background: transparent !important;">
                    <tr>
                         <td valign="top" style="background: transparent !important;">
                             <div id="ageingStatementDiv">
                                 <jsp:include page="ageingStatementGrid.jsp"></jsp:include>
                             </div>
                         </td>
                    </tr>
                </table>
            </div>

            <div id="agDashboard" style="display:none;">
                <div id="agDashMsg"></div>
                <div id="agDashTabs" style="display:none;">
                    <div class="d-tabs">
                        <button type="button" class="d-tab active" id="agt_ov"  onclick="switchAgTab('ov')">Overview</button>
                        <button type="button" class="d-tab"        id="agt_cat" onclick="switchAgTab('cat')">By Category</button>
                        <button type="button" class="d-tab"        id="agt_sp"  onclick="switchAgTab('sp')">By Sales Person</button>
                        <button type="button" class="d-tab"        id="agt_bk"  onclick="switchAgTab('bk')">Ageing Buckets</button>
                        <button type="button" class="d-tab"        id="agt_cr"  onclick="switchAgTab('cr')">Credit Analysis</button>
                        <button type="button" class="d-tab"        id="agt_td"  onclick="switchAgTab('td')">Top Debtors</button>
                    </div>

                    <div class="d-panel active" id="agp_ov">
                        <div class="d-metric-grid">
                            <div class="d-metric" id="ag_ov_count"></div>
                            <div class="d-metric" id="ag_ov_balance"></div>
                            <div class="d-metric" id="ag_ov_advance"></div>
                            <div class="d-metric" id="ag_ov_net"></div>
                            <div class="d-metric" id="ag_ov_overdue"></div>
                            <div class="d-metric" id="ag_ov_unap"></div>
                        </div>
                        <div class="d-chart-row">
                            <div class="d-chart-box" style="flex:1;min-width:260px;max-width:340px;">
                                <div class="d-chart-title">Receivables Breakdown</div>
                                <canvas id="ag_ch_ov_donut" height="220"></canvas>
                            </div>
                            <div class="d-chart-box" style="flex:2;min-width:340px;">
                                <div class="d-chart-title">Ageing Bucket Totals</div>
                                <canvas id="ag_ch_ov_bucket" height="200"></canvas>
                            </div>
                        </div>
                    </div>

                    <div class="d-panel" id="agp_cat">
                        <div class="d-metric-grid">
                            <div class="d-metric" id="ag_cat_count"></div>
                            <div class="d-metric" id="ag_cat_top"></div>
                            <div class="d-metric" id="ag_cat_od"></div>
                            <div class="d-metric" id="ag_cat_best"></div>
                        </div>
                        <div class="d-chart-row">
                            <div class="d-chart-box" style="flex:1;min-width:300px;">
                                <div class="d-chart-title">Balance by Category</div>
                                <canvas id="ag_ch_cat_bar" height="230"></canvas>
                            </div>
                            <div class="d-chart-box" style="flex:1;min-width:300px;">
                                <div class="d-chart-title">Ageing Buckets by Category</div>
                                <canvas id="ag_ch_cat_stacked" height="230"></canvas>
                            </div>
                        </div>
                    </div>

                    <div class="d-panel" id="agp_sp">
                        <div class="d-metric-grid">
                            <div class="d-metric" id="ag_sp_count"></div>
                            <div class="d-metric" id="ag_sp_top"></div>
                            <div class="d-metric" id="ag_sp_od"></div>
                            <div class="d-metric" id="ag_sp_avg"></div>
                        </div>
                        <div class="d-chart-row">
                            <div class="d-chart-box" style="flex:1;min-width:300px;">
                                <div class="d-chart-title">Balance by Sales Person (Top 12)</div>
                                <canvas id="ag_ch_sp_bar" height="270"></canvas>
                            </div>
                            <div class="d-chart-box" style="flex:1;min-width:300px;">
                                <div class="d-chart-title">Ageing Buckets by Sales Person</div>
                                <canvas id="ag_ch_sp_stacked" height="270"></canvas>
                            </div>
                        </div>
                    </div>

                    <div class="d-panel" id="agp_bk">
                        <div class="d-metric-grid">
                            <div class="d-metric" id="ag_bk_l1"></div>
                            <div class="d-metric" id="ag_bk_l2"></div>
                            <div class="d-metric" id="ag_bk_l3"></div>
                            <div class="d-metric" id="ag_bk_l4"></div>
                            <div class="d-metric" id="ag_bk_l5"></div>
                        </div>
                        <div class="d-chart-row">
                            <div class="d-chart-box" style="flex:1;min-width:260px;max-width:340px;">
                                <div class="d-chart-title">Bucket Distribution</div>
                                <canvas id="ag_ch_bk_donut" height="230"></canvas>
                            </div>
                            <div class="d-chart-box" style="flex:2;min-width:340px;">
                                <div class="d-chart-title">Top 10 Most Overdue Accounts (&gt;60 days)</div>
                                <canvas id="ag_ch_bk_top" height="230"></canvas>
                            </div>
                        </div>
                    </div>

                    <div class="d-panel" id="agp_cr">
                        <div class="d-metric-grid">
                            <div class="d-metric" id="ag_cr_overlimit"></div>
                            <div class="d-metric" id="ag_cr_nearlimit"></div>
                            <div class="d-metric" id="ag_cr_util"></div>
                            <div class="d-metric" id="ag_cr_total"></div>
                        </div>
                        <div class="d-chart-row">
                            <div class="d-chart-box" style="flex:2;min-width:340px;">
                                <div class="d-chart-title">Credit Limit vs Balance (Top 15)</div>
                                <canvas id="ag_ch_cr_bar" height="250"></canvas>
                            </div>
                            <div class="d-chart-box" style="flex:1;min-width:260px;max-width:340px;">
                                <div class="d-chart-title">Credit Utilisation Status</div>
                                <canvas id="ag_ch_cr_donut" height="230"></canvas>
                            </div>
                        </div>
                    </div>

                    <div class="d-panel" id="agp_td">
                        <div class="d-metric-grid">
                            <div class="d-metric" id="ag_td_top"></div>
                            <div class="d-metric" id="ag_td_top5pct"></div>
                            <div class="d-metric" id="ag_td_zero"></div>
                            <div class="d-metric" id="ag_td_unap"></div>
                        </div>
                        <div class="d-chart-row">
                            <div class="d-chart-box" style="flex:2;min-width:360px;">
                                <div class="d-chart-title">Top 15 Debtors by Balance <span style="font-weight:400;font-size:11px;color:#888;">(red = >50% overdue, amber = >25%)</span></div>
                                <canvas id="ag_ch_td_bar" height="290"></canvas>
                            </div>
                            <div class="d-table-box" style="flex:1;min-width:280px;background:#fff;border:1px solid #e3e8ee;border-radius:8px;padding:15px;">
                                <div class="d-chart-title">Top Debtors Summary</div>
                                <div id="ag_td_table"></div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <div class="totals-bar">
            <table width="100%" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="10%" align="right" style="font-size: 13px; font-weight: bold; color: #4e5e71; padding-right:10px;">Net Total:</td>
                    <td width="10%">
                        <input type="text" id="txtnetbalance" name="txtnetbalance" readonly value='<s:property value="txtnetbalance"/>' style="background-color: #f3f6f9 !important;" />
                    </td>

                    <td width="8%" align="right" style="font-size: 12px; font-weight: bold; color: #4e5e71; padding-right:6px;">AED:</td>
                    <td width="8%"><label id="aedbalance" style="font-size: 12px; color: #333; font-weight:600; display:block; padding: 2px 8px; border: 1px solid #ccd6e0; border-radius: 4px; background:#fff; height:24px; box-sizing:border-box;"></label></td>

                    <td width="8%" align="right" style="font-size: 12px; font-weight: bold; color: #4e5e71; padding-right:6px;">CAD:</td>
                    <td width="8%"><label id="cadbalance" style="font-size: 12px; color: #333; font-weight:600; display:block; padding: 2px 8px; border: 1px solid #ccd6e0; border-radius: 4px; background:#fff; height:24px; box-sizing:border-box;"></label></td>

                    <td width="8%" align="right" style="font-size: 12px; font-weight: bold; color: #4e5e71; padding-right:6px;">CHF:</td>
                    <td width="8%"><label id="chfbalance" style="font-size: 12px; color: #333; font-weight:600; display:block; padding: 2px 8px; border: 1px solid #ccd6e0; border-radius: 4px; background:#fff; height:24px; box-sizing:border-box;"></label></td>

                    <td width="8%" align="right" style="font-size: 12px; font-weight: bold; color: #4e5e71; padding-right:6px;">EUR:</td>
                    <td width="8%"><label id="eurbalance" style="font-size: 12px; color: #333; font-weight:600; display:block; padding: 2px 8px; border: 1px solid #ccd6e0; border-radius: 4px; background:#fff; height:24px; box-sizing:border-box;"></label></td>

                    <td width="8%" align="right" style="font-size: 12px; font-weight: bold; color: #4e5e71; padding-right:6px;">USD:</td>
                    <td width="8%"><label id="usdbalance" style="font-size: 12px; color: #333; font-weight:600; display:block; padding: 2px 8px; border: 1px solid #ccd6e0; border-radius: 4px; background:#fff; height:24px; box-sizing:border-box;"></label></td>
                </tr>
            </table>
        </div>

    </div>

</td>

</tr>
</table>

</div>
</div>

<div id="accountDetailsWindow">
    <div></div>
    <div></div>
</div>

</body>
</html>
</html>