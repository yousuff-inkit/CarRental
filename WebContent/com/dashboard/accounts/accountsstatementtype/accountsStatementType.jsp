<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/resample.js"></script>
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

    /* Cleaned Cards */
    .filter-card {
        background-color: #f8fafc !important;
        border: 1px solid #e3e8ee !important;
        border-radius: 12px !important;
        padding: 15px;
        margin-bottom: 10px;
    }

    /* HARD RESET: Removing all light-green/legacy backgrounds from every element */
    .filter-card *, 
    fieldset, 
    legend, 
    .branch, 
    td, 
    tr, 
    span, 
    label, 
    div[name="fromdate"], 
    div[name="todate"],
    #lblwithoutxl,
    #lblwithxl {
        background-color: transparent !important;
        background: none !important;
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
        padding: 20px 20px 80px 20px;
    }

    .totals-bar {
        background: #ffffff;
        border-top: 2px solid #2563eb;
        padding: 12px;
        position: absolute;
        bottom: 0;
        left: 0;
        right: 0;
        z-index: 20;
    }

    /* Animation & Status */
    .status { color: #FD8725; font-size: 20px; font-weight: bold; }
    #lblclientstatus { animation: blink 1s infinite alternate; }
    @keyframes blink { from { opacity: 1; } to { opacity: 0; } }

    /* Buttons */
    .myButton {
        background-color: #2563eb !important;
        color: #ffffff !important;
        border: none !important;
        padding: 10px !important;
        border-radius: 6px !important;
        cursor: pointer;
        font-size: 13px;
        font-weight: 600;
        width: 100%;
        margin-top: 5px;
    }
</style>
	<%
	String mod = request.getParameter("mod")==null?"":request.getParameter("mod").toString();   
	String acno = request.getParameter("acno")==null?"":request.getParameter("acno").toString();   
	String account = request.getParameter("account")==null?"":request.getParameter("account").toString();   
	String acname = request.getParameter("acname")==null?"":request.getParameter("acname").toString();
	%>
<script type="text/javascript">
    var modd1 = '<%=mod%>';
	$(document).ready(function () {
		 var name='<%=request.getParameter("name")==null?"":request.getParameter("name")%>';
		
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 var year = window.parent.txtaccountperiodfrom.value;
		 var newDate = year.split('-');
		 year = newDate[1] + "-" + newDate[0] + "-" + newDate[2];
		 $('#fromdate ').jqxDateTimeInput('setDate', new Date(year));
		 
		 $('#txtaccid').dblclick(function(){
			  accountsSearchContent('accountsDetailsSearch.jsp');
	     });
		 document.getElementById("chckopnprint").checked=true;$('#hidchckopnprint').val(1);opnprintcheck();
		// alert($("#lbldetailname").val()+" ---  "+$("#detailname").val()+" ---- "+$("#detail").val());
	     getConfigs();
	     setlink();
	});
	
	function accountsSearchContent(url) {
	    $('#accountDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsWindow').jqxWindow('setContent', data);
		$('#accountDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function funExportBtn(){ 
		var accname=$('#txtaccid').val()+" - "+$('#txtaccname').val(); 
		/*if(($('#lbldetailname').text()=='Accounts Statement AP')){  
			JSONToCSVCon(dataExcelExport,'AccountsStatementAP              '+' '+accname, true);    
        }else if(($('#lbldetailname').text()=='Accounts Statement AR')){
			JSONToCSVCon(dataExcelExport,'AccountsStatementAR              '+' '+accname, true);
        }else if(($('#lbldetailname').text()=='Accounts Statement GL')){             
			JSONToCSVCon(dataExcelExport,'AccountsStatementGL              '+' '+accname, true);
        }else if(($('#lbldetailname').text()=='Accounts Statement HR')){
			JSONToCSVCon(dataExcelExport,'AccountsStatementHR              '+' '+accname, true);
        }*/
        accname = $('#lbldetailname').text() + "    "+accname;
		$("#accountsStatementDiv").excelexportjs({
			containerid: "accountsStatementDiv", 
			datatype: 'json', 
			dataset: null, 
			gridId: "accountsStatement", 
			columns: getColumns("accountsStatement") ,     
			worksheetName:accname,
			enableColumnGroups:false
			}); 
	} 
	
	function getAccTypeFrom(event){
        var x= event.keyCode;
        if(x==114){
      		accountsSearchContent('accountsDetailsSearch.jsp');
        }
        else{}
        }
	
	function getAccountingPeriod(date){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  			    $('#txtaccountperiodfrom').val(items);
  		}
  		}
  		x.open("GET", "getAccountingPeriod.jsp?fromDate="+date, true);
  		x.send();
 }
	
	function getAccountFromPeriod(){
		
		 var date = $('#fromdate').val();
		 getAccountingPeriod(date);
			  
	 		if($('#txtaccountperiodfrom').val()<0){
			  $.messager.alert('Message','Not in Account-Period.','warning');
			  return;
		   }
		
	}
	
	function setlink(){
		if(modd1=='A'){
			//alert("Entered");
	    	 $('#txtaccname').val('<%=acname%>');
	    	 $('#txtaccid').val('<%=account%>');
	    	 $('#txtdocno').val('<%=acno%>');
	    	 document.getElementById("lbldetailname").innerText="Accounts Statement HR";
			 document.getElementById("lbldetail").innerText="Accounts";
	    	 $('#detail').val("Accounts");
			 $('#detailname').val("Accounts Statement HR");
	    	// funreload();
	    	let checkInterval = setInterval(function () {
        		let value = $("#cmbbranch").val(); // Get input value
        			if (value) { // Check if value is set
            			clearInterval(checkInterval); // Stop checking
	    				$('#btnSubmit').trigger("click");
        			}
    		}, 100); // Check every 500ms
		}
	}
	
	function funreload(event){
		
		if($('#txtaccountperiodfrom').val()<0){
			  $.messager.alert('Message','Not in Account-Period.','warning');
			  return;
		   }
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var accdocno = $('#txtdocno').val();
		 var atype = $('#txtatype').val();
		 if(accdocno==''){
			 $.messager.alert('Message','Account is Mandatory.','warning');
			 return 0;
		 }
		var formname=$('#lbldetailname').text();
		 $("#overlay, #PleaseWait").show();
		 
		 document.getElementById("lblaccountname").innerText=$('#txtaccname').val(); 
		 $("#accountsStatementDiv").load("accountsStatementTypeGrid.jsp?formname="+encodeURIComponent(formname)+"&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accdocno='+accdocno+'&atype='+atype+'&check=1');
		}
	function funxlshowcheck(){
 		if(document.getElementById("rdbnxlshow").checked){
 				$('#xlstat').val("0");
 			}
 			if(document.getElementById("rdbnxlhide").checked){
 				$('#xlstat').val("1");
 			}
 	}
 	function funtotshowcheck(){
 		if(document.getElementById("rdbntotalshow").checked){
 				$('#totalstat').val("1");
 			}
 			if(document.getElementById("rdbntotalhide").checked){
 				$('#totalstat').val("0");
 			}
 	}
	
	function funPrintAccountStatement(){
    	if ($("#txtdocno").val()!="") {
	        var url=document.URL;
	        var xlstat=$('#xlstat').val();
	        var reurl=url.split("accountsStatementType.jsp");
	        $("#txtdocno").prop("disabled", false);
	        if(xlstat==""){
	  			$.messager.alert('Message','Select a Brand option...','warning');
	  		}
	        var win= window.open(reurl[0]+"../../../../com/dashboard/accounts/accountsstatement/printAccountsStatement?acno="+document.getElementById("txtdocno").value+'&netamount='+document.getElementById("txtnetamount").value+'&branch='+document.getElementById("cmbbranch").value+'&fromDate='+document.getElementById("fromdate").value+'&allcase=0'+'&toDate='+$('#todate').val()+'&xlstat='+xlstat+'&chckopn='+$('#hidchckopnprint').val()+'&email=Nil&print=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");	        win.focus();
	     }
	    else {
			$.messager.alert('Message','Account is Mandatory.','warning');
			return;
		}
    }
	function funPrintAccountStatementAll(){
		//const arr=["11369","11366","11357","11343","11331","11329","11326"];
		//for (var i=0;i<7;i++)
			{
			//alert("array=="+arr[i]);
    	if ($("#txtdocno").val()!="") {
	        var url=document.URL;
	       // var Allstat=$("#Allstat").val();
	        //var type='ALL';
	        var xlstat=$("#xlstat").val();
	        var reurl=url.split("accountsStatementType.jsp");
	        $("#txtdocno").prop("disabled", false);
	        if(xlstat==""){
	  			$.messager.alert('Message','Select a Brand option...','warning');
	  		}
	        var win= window.open(reurl[0]+"../../../../com/dashboard/accounts/accountsstatement/printAccountsStatement?acno="+document.getElementById("txtdocno").value+'&netamount='+document.getElementById("txtnetamount").value+'&branch='+document.getElementById("cmbbranch").value+'&xlstat='+xlstat+'&fromDate='+document.getElementById("fromdate").value+'&allcase=1'+'&toDate='+$('#todate').val()+'&chckopn='+$('#hidchckopnprint').val()+'&email=Nil&print=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        win.focus();
    	}
    	
	    else {
			$.messager.alert('Message','Account is Mandatory.','warning');
			return;
		}
			}
    }
	function funPrintRAwise(){
    	if ($("#txtdocno").val()!="") {
	        var url=document.URL;
	        var reurl=url.split("accountsStatementType.jsp");
	        $("#txtdocno").prop("disabled", false);
	        var win= window.open(reurl[0]+"../../../../com/dashboard/accounts/accountsstatement/printRAWise?acno="+document.getElementById("txtdocno").value+'&netamount='+document.getElementById("txtnetamount").value+'&branch='+document.getElementById("cmbbranch").value+'&fromDate='+document.getElementById("fromdate").value+'&toDate='+$('#todate').val()+'&chckopn='+$('#hidchckopnprint').val()+'&email=Nil&print=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        win.focus();
	     }
	    else {
			$.messager.alert('Message','Account is Mandatory.','warning');
			return;
		}
    }
	function funSendingEmail() {  
		
	    var email = document.getElementById("txtaccemail").value;
	    var res;var part1;var part2;var dotsplt;
	    if(email.indexOf("@")>=0) {
		    res = email.split('@');
		    part1=res[0];
		    part2=res[1];
		    dotsplt=part2.split('.');
	    }
	    
	   if ($("#txtdocno").val().trim()=="" || typeof($("#txtdocno").val().trim())=="undefined" || typeof($("#txtdocno").val().trim())=="NaN") {
		    $('#txtaccid').val('');$('#txtaccname').val('');$('#txtdocno').val('');$('#txtaccemail').val('');
			
			if (document.getElementById("txtaccid").value == "") {
		        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
		    }
			$.messager.alert('Message','Account is Mandatory.','warning');
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
	    	    	
	    	    	  url: 'printAccountsStatement.action?acno='+document.getElementById("txtdocno").value+'&netamount='+document.getElementById("txtnetamount").value+'&branch='+document.getElementById("cmbbranch").value+'&fromDate='+document.getElementById("fromdate").value+'&toDate='+$('#todate').val()+'&email='+$('#txtaccemail').val()+'&print=0chckopn&chckopn=1',  
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
	  
	  function getClientStatus(){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  			    $('#lblclientstatus').html(items[0]);
  		}
  		}
  		x.open("GET", "getClientStatus.jsp?accountno="+$("#txtdocno").val().trim(), true);
  		x.send();
 	}
	
	  function opnprintcheck(){
			 if(document.getElementById("chckopnprint").checked){
				 document.getElementById("hidchckopnprint").value = 1;
			 }
			 else{
				 document.getElementById("hidchckopnprint").value = 0;
			 }
		 }
	  
	  function funPrintARProjectWise(){
	    	if ($("#txtdocno").val()!="") {
		        var url=document.URL;
		        var reurl=url.split("accountsStatementType.jsp");
		        $("#txtdocno").prop("disabled", false);
		        var win= window.open(reurl[0]+"../../../../com/dashboard/accounts/accountsstatement/printARProjectWise?acno="+document.getElementById("txtdocno").value+'&netamount='+document.getElementById("txtnetamount").value+'&branch='+document.getElementById("cmbbranch").value+'&fromDate='+document.getElementById("fromdate").value+'&toDate='+$('#todate').val()+'&chckopn='+$('#hidchckopnprint').val()+'&email=Nil&print=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
		        win.focus();
		     }
		    else {
				$.messager.alert('Message','Account is Mandatory.','warning');
				return;
			}
	    }
	  function getConfigs(){
		    var dname=document.getElementById("lbldetailname").innerText;
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  			
	  				var items = x.responseText.split("####");
	  				//alert(parseInt(items[4]));
	  				if(parseInt(items[0]) == 1){  
	  				    $('#btnPrintAccountStmt').show();
	  				} else {
	  					$('#btnPrintAccountStmt').hide();
	  				}
	  				
	  				if(parseInt(items[1]) == 1 && dname=="Accounts Statement AR"){
						  $('#btnRAPrintAccount').show();
					}else{
						  $('#btnRAPrintAccount').hide();  
					}
	  				if(parseInt(items[2]) == 1){  
	  				    $('#hidbalanceinconfig').val(1);
	  				} else {
	  					$('#hidbalanceinconfig').val(0);      
	  				}
	  				if(parseInt(items[3])>0){  
	  				    $('#hidacStmtgmtDetailsConfig').val(parseInt(items[3]));   
	  				} else {
	  					$('#hidacStmtgmtDetailsConfig').val(0);      
	  				}
	  				if(parseInt(items[4]) == 1){  
	  				    $('#btnPrintAccountAll').show();
	  				} else {
	  					$('#btnPrintAccountAll').hide();
	  				}
	  				if(parseInt(items[5]) == 1){ 
		  			    $('#rdbnxlshow').show();
		  			  $('#lblwithoutxl').show();
		  			  $('#lblwithxl').show();
	  				} else {
	  					$('#rdbnxlshow').hide();
	  					$('#lblwithoutxl').hide();
	  					$('#lblwithxl').hide();
	  				}
		  				if(parseInt(items[5]) == 1){ 
			  			    $('#rdbnxlhide').show();
		  				} else {
		  					$('#rdbnxlhide').hide();
		  				}
	  				
	  				
	  		}
	  		}
	  		x.open("GET", "getConfigs.jsp", true);  
	  		x.send();
	 	}
</script>
</head>
<body onload="getBranch();">      
<div id="mainBG" class="homeContent" data-type="background"> 
<form id="frmAccountStatementType" action="saveAccountStatementType" method="post" autocomplete="off">
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
                        <td><div id="fromdate" name="fromdate" onchange="getAccountFromPeriod();" value='<s:property value="fromdate"/>'></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">To</td>
                        <td><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
                    </tr>
                </table>
            </div>

            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Account</td>
                        <td><input type="text" id="txtaccid" name="txtaccid" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>' onkeydown="getAccTypeFrom(event);"/></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <input type="text" id="txtaccname" name="txtaccname" readonly="readonly" value='<s:property value="txtaccname"/>' tabindex="-1" style="margin-top:-5px;"/>
                            <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
                            <input type="hidden" id="txtaccemail" name="txtaccemail" value='<s:property value="txtaccemail"/>'/>
                        </td>
                    </tr>
                </table>
                <div align="center" style="margin-top:10px;">
                    <label class="status" id="lblclientstatus"><s:property value="lblclientstatus"/></label>
                </div>
            </div>

            <div class="filter-card">
                <table width="100%">
                    <tr>
                        <td align="center">
                            <input type="radio" id="rdbnxlshow" name="rdbnxl" onchange="funxlshowcheck();" value="Show xl" checked="checked">
                            <label class="branch" for="rdbnxlshow" id="lblwithoutxl">Print</label>
                        </td>
                        <td align="center">
                            <input type="radio" id="rdbnxlhide" name="rdbnxl" onchange="funxlshowcheck();" value="Hide xl">
                            <label class="branch" for="rdbnxlhide" id="lblwithxl">With Excel</label>
                            <input type="hidden" id="xlstat" name="xlstat" value="0" />
                        </td>
                    </tr>
                </table>
                <div align="center" style="margin-top:15px; border-top: 1px solid #eee; padding-top: 10px;">
                    <input type="checkbox" id="chckopnprint" name="chckopnprint" onchange="opnprintcheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)" />
                    <label class="branch" id="lblopn">OPN</label>
                    <input type="hidden" id="hidchckopnprint" name="hidchckopnprint" value='<s:property value="hidchckopnprint"/>'/>
                </div>
            </div>

            <button class="myButton" type="button" id="btnPrintAccount" onclick="funPrintAccountStatement(event);">Account Statement</button>
            <button class="myButton" type="button" id="btnPrintAccountAll" onclick="funPrintAccountStatementAll(event);">Account Statement All</button>
            <button class="myButton" type="button" id="btnRAPrintAccount" onclick="funPrintRAwise(event);">RA wise Print</button>
            <button class="myButton" type="button" id="btnPrintAccountStmt" onclick="funPrintARProjectWise(event);">Project Wise Print</button>

            <input type="hidden" id="hidbalanceinconfig" name="hidbalanceinconfig" value='<s:property value="hidbalanceinconfig"/>'/>
            <input type="hidden" id="hidacStmtgmtDetailsConfig" name="hidacStmtgmtDetailsConfig" value='<s:property value="hidacStmtgmtDetailsConfig"/>'/>
        </div>
    </div>

    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div style="margin-bottom:15px; border-bottom: 1px solid #e1e8ed; padding-bottom: 10px;">
                <label style="color:#1a3a5f; font-weight:bold; font-size:14px;">Account :</label>
                <label style="color:#2563eb; font-weight:bold;" name="lblaccountname" id="lblaccountname"></label>
            </div>
            <div id="accountsStatementDiv">
                <jsp:include page="accountsStatementTypeGrid.jsp"></jsp:include>
            </div>
        </div>

        <div class="totals-bar">
            <table width="100%">
                <tr>
                    <td align="right" style="font-size:13px; font-weight:bold; color:#1a3a5f;">Net Amount :&nbsp;</td>
                    <td width="150px">
                        <input type="text" id="txtnetamount" name="txtnetamount" readonly 
                               style="text-align: right; font-weight: bold; color: #2563eb; background: #f8fafc !important; border: 1px solid #ccd6e0; border-radius: 4px; height: 30px;" 
                               value='<s:property value="txtnetamount"/>'/>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>

<input type="hidden" id="txtaccountperiodfrom" name="txtaccountperiodfrom" value='<s:property value="txtaccountperiodfrom"/>'/>
</div>
</form>
<div id="accountDetailsWindow">
	<div></div><div></div>
</div>
</div> 
</body>
</html>