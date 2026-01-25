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
		/* document.getElementById("branchlabel").style.display="none";
		document.getElementById("branchdiv").style.display="none"; */
   	$("#btnExcel").click(function() {
		/* JSONToCSVCon(repexceldata, 'Replacement List', true); */
		$("#inspListGrid").jqxGrid('exportdata', 'xls', 'sold Vehicles List');
	});
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	 $('#docwindow').jqxWindow({ width: '70%', height: '60%',  maxHeight: '70%' ,maxWidth: '60%' , title: 'Document Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
 	 $('#docwindow').jqxWindow('close');
 	$('#clientwindow').jqxWindow({ width: '70%', height: '60%',  maxHeight: '70%' ,maxWidth: '60%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	 $('#clientwindow').jqxWindow('close');
	$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	$('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate);
	
	
	$('#refvocno').dblclick(function(){
  	  	var reftype=document.getElementById("cmbreftype").value;
 		if(document.getElementById("cmbreftype").value==''){
			 $.messager.alert('warning','Ref Doc Type is Mandatory');
			 return false;
		 }
 		if(document.getElementById("cmbreftype").value=="RAG" || document.getElementById("cmbreftype").value=="LAG"){
 			if(document.getElementById("cmbagmtbranch").value==""){
 				$.messager.alert('warning','Agreement Branch is Mandatory');
 				return false;
 			}
 		}
		    $('#docwindow').jqxWindow('open');
			 docSearchContent('detailDocSearch.jsp?reftype='+reftype+'&branch='+$('#cmbagmtbranch').val(), $('#docwindow'));
		});

	$('#client').dblclick(function(){
  	  	
		$('#clientwindow').jqxWindow('open');
		clientSearchContent('clientMasterSearch.jsp');
		});

	
	getAgmtBranch();
});

function docSearchContent(url) {
	$.get(url).done(function (data) {
  $('#docwindow').jqxWindow('setContent', data);
}); 
}
function clientSearchContent(url) {
	$.get(url).done(function (data) {
  $('#clientwindow').jqxWindow('setContent', data);
}); 
}
function funreload(event)
{
	var branch=document.getElementById("cmbbranch").value;
	//var fleet=document.getElementById("fleetno").value;
	var client=document.getElementById("hidclient").value;
	var fromdate=$('#fromdate').jqxDateTimeInput('val');
	var reftype=$('#cmbreftype').val();
	var agmtbranch=$('#cmbagmtbranch').val();
	var refdocno=$('#refdocno').val();
	var type=$('#cmbtype').val();
	var invoicetype=$('#cmbinvtype').val();
	var todate=$('#todate').jqxDateTimeInput('val');
    $("#overlay, #PleaseWait").show();
   	$("#inspdiv").load("inspListGrid.jsp?branch="+branch+"&client="+client+"&fromdate="+fromdate+"&todate="+todate+"&reftype="+reftype+"&agmtbranch="+agmtbranch+"&refdocno="+refdocno+"&type="+type+"&invoicetype="+invoicetype+"&id=1");
   	
}
	
function getAgmtBranch(){
	   var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('***');
				var locItems = items[0].split(",");
				var locIdItems = items[1].split(",");
				var optionsloc = '<option value="">--Select--</option>';
				for (var i = 0; i < locItems.length; i++) {
					optionsloc += '<option value="' + locIdItems[i] + '">'
							+ locItems[i] + '</option>';
				}
				$("select#cmbagmtbranch").html(optionsloc);
				
			} else {
			}
		}
		x.open("GET", "getBranch.jsp", true);
		x.send();
}

	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
   		  }
	
	}
	function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		     JSONToCSVCon(insplistdata, 'Inspection List', true);
		   } else {
		    //$("#jqxRefund").jqxGrid('exportdata', 'xls', 'SecurityRefund');
		   }
	}
	
		
	
	function funClearData(){
		$('input[type=text],[type=hidden]').val('');
		$('#fromdate').jqxDateTimeInput('setDate',new Date());
		$('#todate').jqxDateTimeInput('setDate',new Date());
		var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	    var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	    $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
	
	}
	function getDoc(event){
   		var reftype=document.getElementById("cmbreftype").value;
 		if(document.getElementById("cmbreftype").value==''){
			 $.messager.alert('warning','Ref Doc Type is Mandatory');
			 return false;
		 }
		if(document.getElementById("cmbreftype").value=="RAG" || document.getElementById("cmbreftype").value=="LAG"){
			if(document.getElementById("cmbagmtbranch").value==""){
				$.messager.alert('warning','Agreement Branch is Mandatory');
				return false;
			}
		}
    	var x= event.keyCode;
          if(x==114){
       	  		$('#docwindow').jqxWindow('open');
       	   		docSearchContent('detailDocSearch.jsp?reftype='+reftype+'&branch='+$('#cmbagmtbranch').val(), $('#docwindow'));
          }
          else{
           
          }
     }
	function getDoc(event){
    	var x= event.keyCode;
          if(x==114){
       	  		$('#clientwindow').jqxWindow('open');
       	   		clientSearchContent('clientMasterSearch.jsp');
          }
          else{
           
          }
     }
	</script>
	
</head>
<body onload="setValues();getBranch();">

<form id="frmSoldList" method="post">

<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ================= LEFT PANEL ================= -->
<td width="23%" valign="top">

<div class="master-container">
<div class="sidebar-filters">

    <!-- FIXED HEADING -->
    <div class="sidebar-fixed-top">
        <div class="filter-card">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>
    </div>

    <!-- SCROLLABLE FILTERS -->
    <div class="sidebar-scroll-content">

        <div class="filter-card">
        <table class="filter-table">

            <tr>
                <td class="label-cell">From Date</td>
                <td><div id="fromdate"></div></td>
            </tr>

            <tr>
                <td class="label-cell">To Date</td>
                <td><div id="todate"></div></td>
            </tr>

            <tr>
                <td class="label-cell">Ref Type</td>
                <td>
                    <select id="cmbreftype" name="cmbreftype">
                        <option value="">--Select--</option>
                        <option value="RAG">Rental</option>
                        <option value="LAG">Lease</option>
                        <option value="RPL">Replacement</option>
                        <option value="NRM">Non Revenue Movement</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Agmt Branch</td>
                <td>
                    <select id="cmbagmtbranch" name="cmbagmtbranch">
                        <option value="">--Select--</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Ref Doc</td>
                <td>
                    <input type="text"
                           id="refvocno"
                           name="refvocno"
                           readonly
                           placeholder="Press F3 to Search"
                           onkeydown="getDoc(event);">
                    <input type="hidden" id="refdocno" name="refdocno">
                </td>
            </tr>

            <tr>
                <td class="label-cell">Client</td>
                <td>
                    <input type="text"
                           id="client"
                           name="client"
                           readonly
                           placeholder="Press F3 to Search">
                    <input type="hidden" id="hidclient" name="hidclient">
                </td>
            </tr>

            <tr>
                <td class="label-cell">Type</td>
                <td>
                    <select id="cmbtype" name="cmbtype">
                        <option value="">--Select--</option>
                        <option value="DMG">Damage</option>
                        <option value="ACC">Accident</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Invoice Type</td>
                <td>
                    <select id="cmbinvtype" name="cmbinvtype">
                        <option value="">--Select--</option>
                        <option value="1">Invoiced</option>
                        <option value="0">Not Invoiced</option>
                    </select>
                </td>
            </tr>

        </table>
        </div>

        <!-- ACTION BUTTON -->
        <button type="button"
                class="btn-submit"
                onclick="funClearData();">
            Clear
        </button>

    </div>
</div>
</div>

</td>

<!-- ================= RIGHT PANEL ================= -->
<td width="77%" valign="top">

<table width="100%">
<tr>
    <td>
        <div id="inspdiv">
            <jsp:include page="inspListGrid.jsp"></jsp:include>
        </div>

        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
    </td>
</tr>
</table>

</td>

</tr>
</table>

</div>

<!-- POPUPS -->
<div id="clientwindow"><div></div></div>
<div id="docwindow"><div></div></div>

</div>

</form>
</body>

</html>