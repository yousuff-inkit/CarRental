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
<style>
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
}

.myButtons:hover, .myButton:hover {
    background-color: #1d4ed8 !important;
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
		 $("#branchlabel").hide();$("#branchdiv").hide();
		 
		 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 /* Searching Window */
     	 $('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
  		 $('#employeeDetailsWindow').jqxWindow('close');
  		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
	     $('#txtemployeeid').dblclick(function(){
		  	 employeeSearchContent("employeeDetailsSearch.jsp");
	     });
	     
	     document.getElementById("rdactive").checked=true;
	     
	});
	
	function employeeSearchContent(url) {
	 	$('#employeeDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#employeeDetailsWindow').jqxWindow('setContent', data);
		$('#employeeDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function funExportBtn(){
	    $("#severancePayDiv").excelexportjs({
			containerid: "severancePayDiv", 
			datatype: 'json', 
			dataset: null, 
			gridId: "severancePayGridID", 
			columns: getColumns("severancePayGridID") ,      
			worksheetName:"SeverancePay"
			});
	} 
	
	function getEmployeeId(event){
        var x= event.keyCode;
        if(x==114){
        	employeeSearchContent("employeeDetailsSearch.jsp");
        }
        else{}
	 }

	function funreload(event){
		 var branchval = document.getElementById("cmbbranch").value;
		 var uptodate = $('#uptodate').val();
		 var employeedocno = $('#txtemployeedocno').val();
		 var check=1;
		 
		 $("#overlay, #PleaseWait").show();
		 
		 if(document.getElementById("rdactive").checked==true){
			 $("#severancePayDiv").load("severancePayGrid.jsp?rpttype=1&branchval="+branchval+'&uptodate='+uptodate+'&employeedocno='+employeedocno+'&check='+check);
		 	
		 } else{
			 $("#severancePayDiv").load("severancePayGrid.jsp?rpttype=0&branchval="+branchval+'&uptodate='+uptodate+'&employeedocno='+employeedocno+'&check='+check);
		   }
		}
	
	function  funClearInfo(){
		
		$('#cmbbranch').val('a');$('#uptodate').val(new Date());
		$('#txtemployeeid').val('');$('#txtemployeename').val('');$('#txtemployeedocno').val('');
		
		document.getElementById("rdactive").checked=true;
		
		$("#severancePayGridID").jqxGrid('clear');$("#severancePayGridID").jqxGrid('addrow', null, {});
	    
	    if (document.getElementById("txtemployeeid").value == "") {
	        $('#txtemployeeid').attr('placeholder', 'Press F3 to Search'); 
	        $('#txtemployeename').attr('placeholder', 'Employee Name');
	    }
			
		}

</script>
</head>
<body onload="getBranch();">

<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar" style="height:100%;">

<table width="100%">
<tr>

<!-- ================= LEFT PANEL ================= -->
<td width="20%" valign="top">

<div class="master-container">
<div class="sidebar-filters">

    <!-- FIXED HEADER -->
    <div class="sidebar-fixed-top">
        <div class="filter-card">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>
    </div>

    <!-- SCROLLABLE CONTENT -->
    <div class="sidebar-scroll-content">

        <div class="filter-card">
        <table class="filter-table">

            <tr>
                <td class="label-cell">Up To</td>
                <td>
                    <div id="uptodate"
                         name="uptodate"
                         value='<s:property value="uptodate"/>'>
                    </div>
                </td>
            </tr>

            <tr>
                <td colspan="2">
                    <div style="font-weight:bold;margin:8px 0;">Report Type</div>
                    <div style="text-align:center;">
                        <input type="radio"
                               id="rdactive"
                               name="rdo"
                               value="rdactive">
                        <label for="rdactive" class="branch">Active</label>
                        &nbsp;&nbsp;
                        <input type="radio"
                               id="rdinactive"
                               name="rdo"
                               value="rdinactive">
                        <label for="rdinactive" class="branch">Inactive</label>
                    </div>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Employee</td>
                <td>
                    <input type="text"
                           id="txtemployeeid"
                           name="txtemployeeid"
                           readonly
                           placeholder="Press F3 to Search"
                           value='<s:property value="txtemployeeid"/>'
                           onkeydown="getEmployeeId(event);">
                    <input type="hidden"
                           id="txtemployeedocno"
                           name="txtemployeedocno"
                           value='<s:property value="txtemployeedocno"/>'>
                </td>
            </tr>

            <tr>
                <td colspan="2">
                    <input type="text"
                           id="txtemployeename"
                           name="txtemployeename"
                           readonly
                           placeholder="Employee Name"
                           tabindex="-1"
                           value='<s:property value="txtemployeename"/>'>
                </td>
            </tr>

        </table>
        </div>

        <!-- MASTER BLUE CLEAR BUTTON -->
        <div class="filter-card">
    <button type="button"
            class="myButtons"
            onclick="funClearInfo();">
        Clear
    </button>
</div>

    </div>
</div>
</div>

</td>

<!-- ================= RIGHT PANEL ================= -->
<td width="80%" valign="top">

<table width="100%">
<tr>
    <td>
        <div id="severancePayDiv">
            <jsp:include page="severancePayGrid.jsp"></jsp:include>
        </div>
    </td>
</tr>
</table>

</td>

</tr>
</table>

</div>

<div id="employeeDetailsWindow">
    <div></div>
</div>

</div>
</body>

</html>