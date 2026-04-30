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
.myButtons, .myButton {
    background-color: #2563eb !important;
    color: #ffffff !important;
    border: none !important;
    border-radius: 6px;
    padding: 10px 15px;
    width: 100%;
    font-weight: 600;
    cursor: pointer;
}

.myButtons:hover, .myButton:hover {
    background-color: #1d4ed8 !important;
}
.main-content-wrapper{
    flex:1;
    width:100%;
}

.scrollable-grid-area{
    width:100%;
}

#delupdiv{
    width:100%;
}

/* 🔹 Inputs + Dropdowns */
input[type="text"],
select {
    width: 100%;
    height: 24px !important;
    padding: 0 8px !important;
    border: 1px solid #ccd6e0;
    border-radius: 4px;
    font-size: 13px;
    box-sizing: border-box;
    line-height: 24px;
}

/* 🔹 Dropdown text */
select {
    font-size: 13px !important;
}

/* 🔹 Buttons */
.btn-submit,
.myButtons,
.myButton,
input[type="button"],
button {
    width: 100%;
    height: 24px !important;
    padding: 0 10px !important;
    border-radius: 4px;
    font-size: 13px;
    font-weight: 600;
    box-sizing: border-box;
    line-height: 24px;
}

/* 🔹 Fix for any library overriding (like jqx / external CSS) */
.jqx-widget input,
.jqx-widget select {
    height: 24px !important;
    line-height: 24px !important;
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
	     var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
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
	
	function getAccount(event){
        var x= event.keyCode;
        if(x==114){
      	  accountsSearchContent('accountsDetailsSearch.jsp');
        } else{}
        }
	
	function funExportBtn(){

		  $("#prepaidDiv").excelexportjs({  
		       		containerid: "prepaidDiv", 
		       		datatype: 'json', 
		       		dataset: null, 
		       		gridId: "prepaidGridID", 
		       		columns: getColumns("prepaidGridID") , 
		       		worksheetName:"Prepaid "
		       		}); 

		// JSONToCSVCon(dataExcelExport, 'Prepaid', true);
	}
	
	function funClearInfo(){

   	 	 $('#cmbbranch').val('a');$('#fromdate').val(new Date());$('#uptodate').val(new Date());$('#cmbreporttype').val('summary');
   	 	 $('#txtaccid').val('');$('#txtaccname').val('');$('#txtdocno').val('');$("#prepaidGridID").jqxGrid('clear');
   		 $("#prepaidGridID").jqxGrid("addrow", null, {});document.getElementById("chckfromdate").checked=false;fromdatecheck();
   	 
   		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		 if (document.getElementById("txtaccid").value == "") {
		        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
		  }
		
	}
	
	function fromdatecheck(){
		 if(document.getElementById("chckfromdate").checked){
			 document.getElementById("hidchckfromdate").value = 1;
			 $('#fromdate').jqxDateTimeInput({ disabled: false});
		 }
		 else{
			 document.getElementById("hidchckfromdate").value = 0;
			 $('#fromdate').jqxDateTimeInput({ disabled: true});
		 }
	 }
	    
	function funreload(event){
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var uptodate = $('#uptodate').val();
		 var chkfromdate = $('#hidchckfromdate').val();
		 var fromdate = $('#fromdate').val();
		 var reporttype = $('#cmbreporttype').val();
		 var accdocno = $('#txtdocno').val();

		 if(reporttype==''){
			 $.messager.alert('Message','Please Choose Report Type.','warning');
			 return 0;
		 }
		 
		 $("#overlay, #PleaseWait").show();
		 
		 $("#prepaidDiv").load("prepaidGrid.jsp?branchval="+branchval+'&uptodate='+uptodate+'&chkfromdate='+chkfromdate+'&fromdate='+fromdate+'&accdocno='+accdocno+'&reporttype='+reporttype+'&check=1');
		 
	}
	
</script>
</head>
<body onload="getBranch();fromdatecheck();">
<div id="mainBG" class="homeContent" data-type="background"> 
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
                        <td colspan="2" align="left">
                            <div style="display: flex; align-items: center; gap: 5px;">
                                <input type="checkbox" id="chckfromdate" name="chckfromdate" value="" onchange="fromdatecheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)" />
                                <label class="branch" style="font-size: 11px;">Enable From Date</label>
                            </div>
                            <input type="hidden" id="hidchckfromdate" name="hidchckfromdate" value='<s:property value="hidchckfromdate"/>'/>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">From</td>
                        <td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Up To</td>
                        <td><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td>
                    </tr>
                </table>
            </div>

            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Report</td>
                        <td>
                            <select id="cmbreporttype" name="cmbreporttype" value='<s:property value="cmbreporttype"/>'>
                                <option value="">--Select--</option>
                                <option value="summary" selected>Summary</option>
                                <option value="detail">Detail</option>
                            </select>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Account</td>
                        <td>
                            <input type="text" id="txtaccid" name="txtaccid" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>' onkeydown="getAccount(event);"/>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>
                            <input type="text" id="txtaccname" name="txtaccname" readonly="readonly" value='<s:property value="txtaccname"/>' />
                            <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
                        </td>
                    </tr>
                </table>
            </div>

            <div style="padding: 0 5px;">
                <input type="button" class="myButtons" name="clear" id="clear" value="Clear" onclick="funClearInfo();">
            </div>
        </div>
    </div>

    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="prepaidDiv">
                <jsp:include page="prepaidGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>
</div>

</div>

<div id="accountDetailsWindow">
	<div></div><div></div>
</div>
</div> 
</body>
</html>