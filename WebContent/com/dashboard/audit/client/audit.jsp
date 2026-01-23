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
<style type="text/css">
    /* Layout & Sidebar Structure */
    .master-container {
        display: flex;
        font-family: 'Segoe UI', Tahoma, sans-serif !important;
        background-color: #f4f7f9;
        width: 100%;
        height: 100vh !important;
        overflow: hidden !important;
        color: black !important; /* Force all font black */
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

    /* Cleaned Cards - Stripping legacy green/shading backgrounds */
    .filter-card {
        background-color: #f8fafc !important;
        border: 1px solid #e3e8ee !important;
        border-radius: 12px !important;
        padding: 15px;
        margin-bottom: 10px;
    }

    /* HARD RESET: Force black fonts and remove unwanted backgrounds */
    .filter-card *, 
    fieldset, 
    legend, 
    .branch, 
    td, 
    tr, 
    label, 
    span {
        background-color: transparent !important;
        background: none !important;
        color: black !important;
    }

    .filter-table { 
        width: 100%; 
        border-spacing: 0 10px; 
    }

    .label-cell {
        text-align: right;
        padding-right: 12px;
        font-size: 13px;
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
        color: black !important;
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
        padding: 20px;
    }

    /* Buttons Modernized */
    .myButton {
        background-color: #2563eb !important;
        color: #ffffff !important; /* Button text white for contrast */
        border: none !important;
        padding: 10px !important;
        border-radius: 6px !important;
        cursor: pointer;
        font-size: 13px;
        font-weight: 600;
        width: 100%;
        margin-bottom: 8px;
        transition: background 0.2s;
        display: block;
        text-align: center;
    }

    .myButton:hover {
        background-color: #1d4ed8 !important;
    }

    /* Support for two buttons side-by-side in sidebar */
    .button-row {
        display: flex;
        gap: 10px;
        width: 100%;
    }
    .button-row .myButton {
        flex: 1;
    }

    .branch { font-size: 13px; font-weight: 600; }
</style>
</head>
<body onload="getBranch();">
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
                        <td class="label-cell">Client</td>
                        <td>
                            <input type="text" id="txtclientname" name="txtclientname" readonly="readonly" value='<s:property value="txtclientname"/>'/>
                            <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/>
                        </td>
                    </tr>
                </table>
            </div>

            <div style="padding: 10px 5px;">
                <button class="myButton" type="button" id="btnaudit" name="btnaudit" onclick="funAudit(event);">Audit</button>
                
                <div class="button-row">
                    <button class="myButton" type="button" id="btnclient" name="btnclient" onclick="getClientMaster(event);">Client</button>
                    <button class="myButton" type="button" id="btnattach" name="btnattach" onclick="funClientAttach(event);">Attach</button>
                </div>
            </div>
        </div>
    </div>

    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="auditDiv">
                <jsp:include page="auditGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>
</div></div>

<input type="hidden" name="txtbranchid" id="txtbranchid" style="height:20px;width:70%;" value='<s:property value="txtbranchid"/>'>

<div id="clientWindow">
<div></div>
</div>
</div> 
</body>
</html>