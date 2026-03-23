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


<script type="text/javascript">

	$(document).ready(function () {
		 
		 $('#clientDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#clientDetailsWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		
	     $('#txtclientname').dblclick(function(){
			  clientSearchContent('clientDetailsSearch.jsp');
		 });
	     
	});
	
	function clientSearchContent(url) {
	    $('#clientDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientDetailsWindow').jqxWindow('setContent', data);
		$('#clientDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getClient(event){
	      var x= event.keyCode;
	      if(x==114){
	    	  clientSearchContent('clientDetailsSearch.jsp');
	      } else{}
	}
	
	function funreload(event){
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var cldocno = $('#txtcldocno').val();
		 var check="1";
		 
		 $("#overlay, #PleaseWait").show();
		
	     $("#clientApprovalDiv").load("clientApprovalGrid.jsp?branchval="+branchval+'&cldocno='+cldocno+'&check='+check);
		 
		 
		}
	
      function funClearInfo(){

    	 $('#cmbbranch').val('a');
    	 $('#txtcldocno').val('');$('#txtclientname').val('');$('#txtselectedclients').val('');
    	 
		 $("#clientApprovalGridID").jqxGrid('clear');$("#clientApprovalGridID").jqxGrid('clearselection');
		
		 if (document.getElementById("txtclientname").value == "") {
		        $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
		 }
		 
		}
      
	function funExportBtn(){ 
		if(parseInt(window.parent.chkexportdata.value)=="1") {
			JSONToCSVCon(dataExcelExport, 'ClientApproval', true);
		 } else {
			 $("#clientApprovalGridID").jqxGrid('exportdata', 'xls', 'ClientApproval');
		 }
	}
	
	function funClientApproval(){
		
		var rows = $("#clientApprovalGridID").jqxGrid('getrows');
		var selectedrows=$("#clientApprovalGridID").jqxGrid('selectedrowindexes');
		selectedrows = selectedrows.sort(function(a,b){return a - b});
		
		if(selectedrows.length==0){
			$("#overlay, #PleaseWait").hide();
			$.messager.alert('Warning','Select Clients to be Approved.');
			return false;
		}
		
		var i=0;var tempcldocno="",tempcldocno1="";
        var j=0,k=0;
	    for (i = 0; i < rows.length; i++) {
				if(selectedrows[j]==i){
					
					if(i==0){
						tempcldocno=rows[i].cldocno;
						k=1;
					}
					else{
						if(k==0){
							tempcldocno=rows[i].cldocno;
							k=1;
						} else {
							tempcldocno=tempcldocno+","+rows[i].cldocno;
						}
					}
					tempcldocno1=tempcldocno;
					
				j++; 
			  }
            }
	     $('#txtselectedclients').val(tempcldocno1);
		
	     $.messager.confirm('Confirm', 'Do you want to Approve ?', function(r){
	  	 		if (r){
	  	 			  var selectedclients = $('#txtselectedclients').val();
	  	 			  
	  	 			  $("#overlay, #PleaseWait").show();
	  	 			 
	  	 			  saveGridData(selectedclients);
	  	 	  }
	  	  });  
	}
	
	function saveGridData(selectedclients) {
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;
				items = items.split('***');
				var val = items[0];
				
				if(val>0) {
					$.messager.alert('Message', ' Successfully Approved', function(r){
					});
					
					$('#txtcldocno').val('');$('#txtclientname').val('');$('#txtselectedclients').val('');
			    	 
					if (document.getElementById("txtclientname").value == "") {
					        $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
					}
				} else {
					$.messager.alert('Message', ' Failed', function(r){
					});
				}
				funreload(event);
		  }
		}
			
		
	x.open("GET","saveData.jsp?selectedclients="+selectedclients,true);
	x.send();
	}

</script>
</head>
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
</style>
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
                        <td align="left">
                            <input type="text" id="txtclientname" name="txtclientname" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtclientname"/>' onkeydown="getClient(event);"/>
                            <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/>
                        </td>
                    </tr>
                </table>
                
                <div style="margin-top: 15px; display: flex; flex-direction: column; gap: 8px;">
                    <input type="button" class="myButtons" name="clear" id="clear" value="Clear" onclick="funClearInfo();">
                    <button class="myButton" type="button" id="btnApproved" name="btnApproved" onclick="funClientApproval();">Approval</button>
                </div>
            </div>
            
            <input type="hidden" id="txtselectedclients" name="txtselectedclients" value='<s:property value="txtselectedclients"/>'/>
            
            <div style="height: 300px;"></div>
        </div>
    </div>

    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="clientApprovalDiv">
                <jsp:include page="clientApprovalGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>
</div>
</div>
<div id="clientDetailsWindow">
	<div></div>
</div>

</div>
</body>
</html>