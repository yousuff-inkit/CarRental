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
 <style>
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
	$("#branchlabel").css("opacity","0");$("#branchdiv").css("opacity","0");
	
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
     
   
    $('#userRoleDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'User-Role Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#userRoleDetailsWindow').jqxWindow('close');
	 
	 document.getElementById("rduserrole").checked=true;
	 $('#userlistgrid').hide();
	 
});

function getRole(event){
	document.getElementById("txtusername").value="";
	 if (document.getElementById("txtusername").value == "") {
			
		 
	        $('#txtusername').attr('placeholder', 'Press F3 to Search'); 
	    }
    var x= event.keyCode;
    if(x==114){
  	  userRoleSearchContent('userRoleSearchGrid.jsp');
    }
    else{}
    }
function funSearchdblclick(){
	document.getElementById("txtusername").value="";
	 if (document.getElementById("txtusername").value == "") {
			
		 
	        $('#txtusername').attr('placeholder', 'Press F3 to Search'); 
	    }
	  $('#txtrolename').dblclick(function(){
		  userRoleSearchContent('userRoleSearchGrid.jsp');
	  });
}

function userRoleSearchContent(url) {
	    $('#userRoleDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#userRoleDetailsWindow').jqxWindow('setContent', data);
		$('#userRoleDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
function getName(event){
    var x= event.keyCode;
    if(x==114){
  	  userNameSearchContent('userNameSearchGrid.jsp');
    }
    else{}
    }
    
function funExportBtn(){

	 if(document.getElementById("rduserrole").checked==true){
		 $("#userrolGriddiv").excelexportjs({
			 containerid: "userrolGriddiv",
			 datatype:'json',
			 datasset: null,
			 gridId: "jqxUserRole",
			 columns: getColumns("jqxUserRole"),
			 worksheetName:"Menu Role"
		 });
		 $("#userroldetailsGriddiv").excelexportjs({
			 containerid: "userroldetailsGriddiv",
			 datatype:'json',
			 datasset: null,
			 gridId: "jqxUserRoledetails",
			 columns: getColumns("jqxUserRoledetails"),
			 worksheetName:"BI Role"
		 });
				 
	 } else if(document.getElementById("rduserlist").checked==true){
		 $("#userlistgrid").excelexportjs({
			 containerid: "userlistgrid",
			 datatype:'json',
			 datasset: null,
			 gridId: "jqxUserList",
			 columns: getColumns("jqxUserList"),
			 worksheetName:"User List"
		 });
		 
	 }
}


function funNamedblclick(){
	  $('#txtusername').dblclick(function(){
		  userNameSearchContent('userNameSearchGrid.jsp');
	  });
}

function userNameSearchContent(url) {
	    $('#userRoleDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#userRoleDetailsWindow').jqxWindow('setContent', data);
		$('#userRoleDetailsWindow').jqxWindow('bringToFront');
	}); 
	}

function funreload(event){
	 $("#overlay, #PleaseWait").show();
	 if(document.getElementById("rduserrole").checked==true){
		 var roleid= $('#txtroleid').val();
		 var rolleid= $('#txtrolleid').val();
		$('#userrolGriddiv').load('userRoleGrid.jsp?roleid='+roleid+'&rolleid='+rolleid+'&id=1');
		$('#userroldetailsGriddiv').load('userRoledetailsGrid.jsp?roleid='+roleid+'&rolleid='+rolleid+'&id=1');
		$('#userlistgrid').hide();
		$('#userrolGriddiv').show();
	 	$('#userroldetailsGriddiv').show();

	 } else if(document.getElementById("rduserlist").checked==true){
		$("#userlistgrid").load("userlistgrid.jsp");
		$('#userrolGriddiv').hide();
	 	$('#userroldetailsGriddiv').hide();
		$('#userlistgrid').show();
	 }
}


function funReadOnly(){
	$('#frmUserRoleMaster input').attr('readonly', true );
	// $("#jqxUserRole").jqxGrid({ disabled: true});
	//	$("#jqxUserRoledetails").jqxGrid({ disabled: true});
	/* $("#fromdate").jqxDateTimeInput({ disabled: true}); */
	/* $("#todate").jqxDateTimeInput({ disabled: true}); */
}

function funClearRadioInfo() {
	
	if(document.getElementById("rduserrole").checked==true){
		document.getElementById("rduserrole").checked=true;
		document.getElementById("rduserlist").checked=false;
		$('#txtrolleid').val("");
		$('#txtusername').val("");
		$('#txtrolename').val("");
		$('#txtroleid').val("");
	} else if (document.getElementById("rduserlist").checked==true){
		document.getElementById("rduserrole").checked=false;
		document.getElementById("rduserlist").checked=true;
		$('#txtrolleid').val("");
		$('#txtusername').val("");
		$('#txtrolename').val("");
		$('#txtroleid').val("");
	}
	
	if ($('#txtusername').val()=="" || $('#txtrolename').val()=="") {
        $('#txtusername').attr('placeholder', 'Press F3 to Search'); 
        $('#txtrolename').attr('placeholder', 'Press F3 to Search'); 
    }
}



	
</script>

</head>
<body onload="funReadOnly();">

<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar">

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

    <!-- SCROLLABLE FILTER CONTENT -->
    <div class="sidebar-scroll-content">

        <div class="filter-card">
        <table class="filter-table">

            <tr>
                <td colspan="2" align="center">
                    <input type="radio"
                           id="rduserrole"
                           name="rdo"
                           value="rduserrole"
                           onchange="funClearRadioInfo();">
                    <label for="rduserrole" class="branch">
                        User Role Detail
                    </label>

                    &nbsp;&nbsp;&nbsp;

                    <input type="radio"
                           id="rduserlist"
                           name="rdo"
                           value="rduserlist"
                           onchange="funClearRadioInfo();">
                    <label for="rduserlist" class="branch">
                        View User List
                    </label>
                </td>
            </tr>

            <tr>
                <td class="label-cell">User Role</td>
                <td>
                    <input type="text"
                           id="txtrolename"
                           name="txtrolename"
                           placeholder="Press F3 to Search"
                           value='<s:property value="txtrolename"/>'
                           ondblclick="funSearchdblclick();"
                           onkeydown="getRole(event);">

                    <input type="hidden"
                           id="txtroleid"
                           name="txtroleid"
                           value='<s:property value="txtroleid"/>'>
                </td>
            </tr>

            <tr>
                <td class="label-cell">User Name</td>
                <td>
                    <input type="text"
                           id="txtusername"
                           name="txtusername"
                           placeholder="Press F3 to Search"
                           value='<s:property value="txtusername"/>'
                           ondblclick="funNamedblclick();"
                           onkeydown="getName(event);">

                    <input type="hidden"
                           id="txtrolleid"
                           name="txtrolleid"
                           value='<s:property value="txtrolleid"/>'>
                </td>
            </tr>

        </table>
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
        <div id="userrolGriddiv">
            <jsp:include page="userRoleGrid.jsp"></jsp:include>
        </div>
    </td>
</tr>

<tr>
    <td>
        <div id="userroldetailsGriddiv">
            <jsp:include page="userRoledetailsGrid.jsp"></jsp:include>
        </div>
    </td>
</tr>
</table>

<div id="userlistgrid">
    <jsp:include page="userlistgrid.jsp"></jsp:include>
</div>

</td>

</tr>
</table>

</div>

<!-- POPUP -->
<div id="userRoleDetailsWindow">
    <div></div>
</div>

</div>
</body>

</html>