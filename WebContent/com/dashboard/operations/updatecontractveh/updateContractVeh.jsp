<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<style type="text/css">

/* ===== MASTER LAYOUT ===== */
.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', Tahoma, sans-serif;
    background-color: #f4f7f9;
}

/* Sidebar */
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

/* Cards */
.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

/* Tables */
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

/* Inputs */
input[type="text"], select {
    width: 100%;
    padding: 7px 10px;
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    font-size: 13px;
}

/* Buttons */
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

/* Page height fix */
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

$(document).ready(function () {
	  // setType(null);
	
	   $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");

	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	   var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
       var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
       $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
       $('#clientsearchwindow').jqxWindow({ width: '49%', height: '65%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#clientsearchwindow').jqxWindow('close');
	   $('#agmtnowindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Agreement Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#agmtnowindow').jqxWindow('close');
	   $('#client').dblclick(function(){
			 $('#clientsearchwindow').jqxWindow('open');
				$('#clientsearchwindow').jqxWindow('focus');
				 clientSearchContent('clientINgridsearch.jsp', $('#clientsearchwindow'));
			});
		 $('#hidagmtno').dblclick(function(){
			 if(document.getElementById("agmttype").value==""){
				 $.messager.alert('warning','Please Select Agreement Type');
				 return false;
			 }
			 $('#agmtnowindow').jqxWindow('open');
				$('#agmtnowindow').jqxWindow('focus');
				 agmtSearchContent('agmtSearch.jsp?agmttype='+document.getElementById("agmttype").value+'&branch='+document.getElementById("cmbbranch").value, $('#agmtnowindow'));
			});
		 
		 
		 
});


function getClient(event){
	var x= event.keyCode;
	if(x==114){
		 $('#clientsearchwindow').jqxWindow('open');
			$('#clientsearchwindow').jqxWindow('focus');
			 clientSearchContent('clientINgridsearch.jsp', $('#clientsearchwindow'));	
	}
 	 

}
function getAgmtno(event){
	var x= event.keyCode;
	if(x==114){
		 if(document.getElementById("agmttype").value==""){
			 $.messager.alert('warning','Please Select Agreement Type');
			 return false;
		 }
		 $('#agmtnowindow').jqxWindow('open');
			$('#agmtnowindow').jqxWindow('focus');
			 agmtSearchContent('agmtSearch.jsp?agmttype='+document.getElementById("agmttype").value+'&branch='+document.getElementById("cmbbranch").value, $('#agmtnowindow'));
			 
	}
 	 

}
function clientSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#clientsearchwindow').jqxWindow('setContent', data);

}); 
}
function agmtSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#agmtnowindow').jqxWindow('setContent', data);

}); 
}

function funreload(event)
{
	if(document.getElementById("cmbbranch").value==""){
		$.messager.alert('Warning','Please Select Branch');
		return false;
	}
	var dateval=funDateInPeriod($('#todate').jqxDateTimeInput('getDate'));
	//alert(dateval);
	if(dateval==1){

     var branch=document.getElementById("cmbbranch").value;
     var fromdate=$('#fromdate').jqxDateTimeInput('val');
     var todate=$('#todate').jqxDateTimeInput('val');
  	var agmttype=document.getElementById("agmttype").value;
  	var agmtno=document.getElementById("agmtno").value;
  	var cldocno=document.getElementById("hidclient").value;
    
    	 $("#overlay, #PleaseWait").show();
    		 $("#contractdiv").load("UpdateContractGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&agmttype="+agmttype+"&agmtno="+agmtno+"&cldocno="+cldocno+"&id=1");	 
    	 
    	  
     

	}
	}
function funExportBtn(){
	//	 $("#updateContractGrid").jqxGrid('exportdata', 'xls', 'Permanent Vehicle Update');
/* if(parseInt(window.parent.chkexportdata.value.trim())=="1") {
			JSONToCSVCon(updatedata, 'Permanent_Vehicle_Update', true);
		}
		else{
		   // $("#jqxRefund").jqxGrid('exportdata', 'xls', 'Permanent Vehicle Update');
		}
		 */
		 
	if(parseInt(window.parent.chkexportdata.value.trim())=="1") {
		JSONToCSVCon(updatedata, 'Permanent_Vehicle_Update', true);
	}
	else{
	   // $("#jqxRefund").jqxGrid('exportdata', 'xls', 'Permanent Vehicle Update');
	}
	
		 
		 
	}

	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
	
	}

	
		
	
	function funClearData(){
		$('input[type=text],[type=hidden]').val('');
		$('#agmttype').val('');
		$('#agmtdetails').val('');
	}
	function funUpdateData(){
		
		if(document.getElementById("agmtdetails").value==""){
			$.messager.alert('Message','Please Select an Agreement');
		return false;
		}
	
		var reg=document.getElementById("hidfleetreg").value;
		var agmtno=document.getElementById("agmtno").value;
		var agmttype=document.getElementById("agmttype").value;
		var fleet=document.getElementById("hidofleet").value;
		 $.messager.confirm('Confirm', 'Do you want to update Vehicle No: '+fleet+' '+reg+' of Agmt No: '+agmttype+' '+agmtno+' as Permanent Vehicle', function(r){ 
		/* $.messager.confirm('Confirm', 'Do you want to update Vehicle No:'+reg+' as Permanent Vehicle', function(r){ */
			if (r){
				
				
				
				$("#overlay, #PleaseWait").show();
				var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
						var items = x.responseText;
						$("#overlay, #PleaseWait").hide();
						 $.messager.alert('Message',items); 
						 funClearData();
						 funreload(reg);
					} else {
					}
				}
				x.open("GET", "updateContract.jsp?agmtno="+agmtno+"&agmttype="+agmttype+"&fleet="+fleet, true);
				x.send();
			}
			});
		}

	</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmUpdateContract" method="post">

<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ================= LEFT PANEL ================= -->
<td width="23%" valign="top">

<div class="master-container">
<div class="sidebar-filters">

    <!-- FIXED HEADER -->
    <div class="sidebar-fixed-top">
        <div class="filter-card">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>
    </div>

    <!-- SCROLLABLE FILTER CONTENT -->
    <div class="sidebar-scroll-content">

        <div class="filter-card">
            <table class="filter-table">

                <tr>
                    <td class="label-cell">From Date</td>
                    <td>
                        <div id="fromdate"></div>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">To Date</td>
                    <td>
                        <div id="todate"></div>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Agreement Type</td>
                    <td>
                        <select name="agmttype" id="agmttype">
                            <option value="">--Select--</option>
                            <option value="RAG">Rental</option>
                            <option value="LAG">Lease</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Agreement No</td>
                    <td>
                        <input type="text"
                               name="hidagmtno"
                               id="hidagmtno"
                               placeholder="Press F3 to Search"
                               readonly
                               onkeydown="getAgmtno(event);">
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Client</td>
                    <td>
                        <input type="text"
                               name="client"
                               id="client"
                               placeholder="Press F3 to Search"
                               readonly
                               onkeydown="getClient(event);">
                    </td>
                </tr>

                <input type="hidden" name="hidclient" id="hidclient">

                <tr>
                    <td colspan="2">
                        <textarea id="agmtdetails"
                                  name="agmtdetails"
                                  rows="8"
                                  readonly></textarea>
                    </td>
                </tr>

            </table>
        </div>

        <!-- MASTER BUTTON ROW -->
        <div style="display:flex;gap:10px;justify-content:center;">
            <button type="button"
                    class="btn-submit"
                    id="btnclear"
                    onclick="funClearData();">
                Clear
            </button>

            <button type="button"
                    class="btn-submit"
                    id="btnupdate"
                    onclick="funUpdateData();">
                Update
            </button>
        </div>

    </div>

</div>
</div>

</td>

<!-- ================= RIGHT PANEL ================= -->
<td width="77%" valign="top">

<table width="100%">
<tr>
    <td>
        <div id="contractdiv">
            <jsp:include page="UpdateContractGrid.jsp"></jsp:include>
        </div>

        <%-- 
        <div id="distributiondiv" hidden="true">
            <jsp:include page="salesMonthwiseGrid.jsp"></jsp:include>
        </div> 
        --%>
    </td>

    <!-- HIDDEN FIELDS -->
    <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
    <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
    <input type="hidden" name="hidofleet" id="hidofleet">
    <input type="hidden" name="hidfleetreg" id="hidfleetreg">
    <input type="hidden" name="agmtno" id="agmtno">
</tr>
</table>

</td>

</tr>
</table>

</div>

<div id="clientsearchwindow">
    <div></div>
</div>

<div id="agmtnowindow">
    <div></div>
</div>

</div>
</form>
</body>

</html>