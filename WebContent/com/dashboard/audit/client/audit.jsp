<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

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
    box-sizing: border-box;
}
/* Force layout tables to white */
.master-layout-table, .master-layout-table > tbody > tr, .master-layout-table > tbody > tr > td {
    background-color: #ffffff !important;
    background: #ffffff !important;
}
/* Forcefully kill all hover states on tables applied by external CSS */
table tr:hover, table td:hover, table th:hover, tbody tr:hover {
    background-color: transparent !important;
    background: transparent !important;
}

/* ===== MASTER LAYOUT ===== */
.sidebar-filters {
    width: 330px;
    background: #ffffff !important;
    height: 100%; 
    box-sizing: border-box;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
}

/* Inline Flow CSS - Buttons naturally follow the inputs */
.sidebar-scroll-content {
    height: 100%;
    overflow-y: auto;
    padding: 15px 20px !important;
    box-sizing: border-box;
}

.sidebar-fixed-bottom {
    margin-top: 15px;
    padding: 0;
    background: transparent;
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
input[type="text"], select, .filter-table input[type="text"], .filter-table select {
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
    cursor: pointer;
}
/* ===== BUTTONS ===== */
/* ===== Action Buttons ===== */

.button-group{
    display:flex;
    gap:8px;
}

.button-group .myButton{
    flex:1;
    height:30px !important;
    margin:0 !important;
    width:auto !important;
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
.btn-submit:hover, .myButton:hover, .myButtons:hover { background: #1d4ed8 !important; }
.btn-submit:disabled, .myButton:disabled, .myButtons:disabled { background: #9ca3af !important; cursor: not-allowed; }
</style>
<style type="text/css">

/* ===== Readonly Client Field ===== */

#txtclientname{
    background:#f3f6f9 !important;
}

/* ===== Vertical Buttons ===== */

.action-buttons{
    display:flex;
    flex-direction:column;
    gap:8px;
}

.action-buttons .myButton{
    width:100%;
}

/* ===== Grid ===== */

#auditDiv{
    height:100%;
    background:#ffffff;
}

</style>
<script type="text/javascript">

$(document).ready(function () {
	 $('#clientWindow').jqxWindow({ autoOpen: false,width: '78%', height: '85%',  maxHeight: '85%' ,maxWidth: '78%' , title: 'Client Details' , theme: 'energyblue', position: { x: 280, y: 10 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'});
	 
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	 
});

	function getClientMaster(){
		var client = $('#txtcldocno').val();
		
		if(client==''){
			 $.messager.alert('Message','Choose an Client.','warning');
			 return 0;
		 }
		
		var url=document.URL;
		var reurl=url.split("com/");
		
		window.parent.formName.value="Client";
		window.parent.formCode.value="CRM";
		
		var detName= "Client";
		var path= "com/operations/clientrelations/client/clientAudit.action?mode=view&txtclientdocno="+client;
		top.addTab( detName,reurl[0]+""+path);
	}	
	
	function clientSearchContent(url) {
		 $('#clientWindow').jqxWindow('focus'); 
		 $.get(url).done(function (data) {
		 $('#clientWindow').jqxWindow('setContent', data);
		}); 
		}
	
	function funreload(event){
		     $('#txtclientname').val('');$('#txtcldocno').val('');
			 var branchval = document.getElementById("cmbbranch").value;
			 $("#overlay, #PleaseWait").show();
			 
			 $("#auditDiv").load("auditGrid.jsp?branchval="+branchval+'&check=1');
	}
	
	function funAudit(event){
		var cldocno = $('#txtcldocno').val();
		var branchid = $('#txtbranchid').val();
		
		if(cldocno==''){
			 $.messager.alert('Message','Choose a Client.','warning');
			 return 0;
		 }
			
		    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		 saveGridData(branchid,cldocno);	
		     	}
		 });
	}
	
	function saveGridData(branchid,cldocno){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;

				var branchid = $('#txtbrhid').val('');
				var cldocno = $('#txtcldocno').val('');
				var clientname = $('#txtclientname').val(''); 
				
				$.messager.alert('Message', '  Record Successfully Updated ', function(r){
			  });
		      funreload(event); 
		  }
		}
			
	x.open("GET","saveData.jsp?branchid="+branchid+"&cldocno="+cldocno,true);
	x.send();
	}
	
	function funClientAttach(){
		if ($("#txtcldocno").val()!="") {
			$("#windowattach").jqxWindow('setTitle',"CRM - "+document.getElementById("txtcldocno").value);
			changeDashBoardAttachContent("<%=contextPath%>/com/common/attachGrid.jsp?formCode=CRM&docno="+document.getElementById("txtcldocno").value);		
		} else {
			$.messager.alert('Message','Select a Document....!','warning');
			return;
		}
	}
	
	function funExportBtn(){
		 JSONToCSVCon(data1, 'Client Audit List', true);
	 }

	
</script>

</head>
<body onload="getBranch();">

<div id="mainBG" class="homeContent" data-type="background" style="height:100%;overflow:hidden;box-sizing:border-box;">

<div class="hidden-scrollbar" style="height:100%;box-sizing:border-box;">

<table class="master-layout-table"
       width="100%"
       height="100%"
       cellpadding="0"
       cellspacing="0"
       border="0"
       style="table-layout:fixed;background:#fff;height:100%;">

<tr>

<!-- ================= LEFT PANEL ================= -->

<td width="330"
    valign="top"
    style="padding:0;background:#fff;border-right:1px solid #e1e8ed;">

<div class="sidebar-filters">

<div class="sidebar-scroll-content">

<div class="filter-card">

<table class="filter-table">

<tr>

<td class="label-cell">
Client
</td>

<td>

<input type="text"
       id="txtclientname"
       name="txtclientname"
       readonly="readonly"
       value='<s:property value="txtclientname"/>'/>

<input type="hidden"
       id="txtcldocno"
       name="txtcldocno"
       value='<s:property value="txtcldocno"/>'/>

</td>

</tr>

</table>

</div>

<div class="filter-card">

<div class="filter-card">

    <div class="button-group">

        <input type="button"
               class="myButton"
               id="btnaudit"
               name="btnaudit"
               value="Audit"
               onclick="funAudit(event);"/>

        <input type="button"
               class="myButton"
               id="btnclient"
               name="btnclient"
               value="Client"
               onclick="getClientMaster(event);"/>

        <input type="button"
               class="myButton"
               id="btnattach"
               name="btnattach"
               value="Attach"
               onclick="funClientAttach(event);"/>

    </div>

</div>

</div>

</div>

</div>

</td>

<!-- ================= RIGHT PANEL ================= -->

<td valign="top"
    style="padding:15px;background:#ffffff;height:100%;">

<div style="display:flex;flex-direction:column;height:100%;box-sizing:border-box;">

<div style="width:100%;margin-bottom:10px;flex-shrink:0;">

<jsp:include page="../../heading.jsp"></jsp:include>

</div>

<div id="auditDiv"
     style="flex:1;overflow:auto;min-height:0;">

<jsp:include page="auditGrid.jsp"></jsp:include>

</div>

</div>

</td>

</tr>

</table>

</div>

</div>

<input type="hidden"
       name="txtbranchid"
       id="txtbranchid"
       value='<s:property value="txtbranchid"/>'>

<div id="clientWindow">
    <div></div>
</div>

</body>
</html>