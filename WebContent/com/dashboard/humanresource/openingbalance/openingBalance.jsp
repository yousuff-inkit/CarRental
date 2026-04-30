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
    cursor: pointer;
    font-size: 13px;
    font-weight: 600;
    padding: 10px 15px;
    width: 100%;
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
		
		 /* Searching Window */
     	 $('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
  		 $('#employeeDetailsWindow').jqxWindow('close');
  		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
		 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
	     $('#txtemployeeid').dblclick(function(){
	  		employeeSearchContent("employeeDetailsSearch.jsp");
		 });
	     
	});
	
	function employeeSearchContent(url) {
	 	$('#employeeDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#employeeDetailsWindow').jqxWindow('setContent', data);
		$('#employeeDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getPayrollCategory() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var payrollcategoryItems = items[0].split(",");
				var payrollcategoryIdItems = items[1].split(",");
				var optionspayrollcategory = '<option value="">--Select--</option>';
				for (var i = 0; i < payrollcategoryItems.length; i++) {
					optionspayrollcategory += '<option value="' + payrollcategoryIdItems[i] + '">'
							+ payrollcategoryItems[i] + '</option>';
				}
				$("select#cmbempcategory").html(optionspayrollcategory);
				
			} else {
			}
		}
		x.open("GET", "getPayrollCategory.jsp", true);
		x.send();
	}
	
	function getDepartment() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var departmentItems = items[0].split(",");
				var departmentIdItems = items[1].split(",");
				var optionsdepartments = '<option value="">--Select--</option>';
				for (var i = 0; i < departmentItems.length; i++) {
					optionsdepartments += '<option value="' + departmentIdItems[i] + '">'
							+ departmentItems[i] + '</option>';
				}
				$("select#cmbdepartment").html(optionsdepartments);
				
			} else {
			}
		}
		x.open("GET", "getDepartment.jsp", true);
		x.send();
	}
	
	function getEmployeeId(event){
        var x= event.keyCode;
        if(x==114){
        	employeeSearchContent("employeeDetailsSearch.jsp");
        }
        else{}
        }

	function  funClearInfo(){
		$('#cmbbranch').val('a');$('#txtemployeeid').val('');$('#txtemployeename').val('');$('#txtemployeedocno').val('');
		$('#txtemployeeids').val('');$('#cmbempcategory').val('');$('#cmbdepartment').val('');
		$('#msg').val('');$('#mode').val('');$('#gridlength').val('');
		$("#openingDetailsGridID").jqxGrid('clear');$("#openingDetailsGridID").jqxGrid('addrow', null, {});
		
		if (document.getElementById("txtemployeeid").value == "") {
	        $('#txtemployeeid').attr('placeholder', 'Press F3 to Search'); 
	        $('#txtemployeename').attr('placeholder', 'Employee Name');
	    }
		
	 }
	
	function funreload(event){
		 var branchval = document.getElementById("cmbbranch").value;
		 var category = $('#cmbempcategory').val();
		 var department = $('#cmbdepartment').val();
		 var employee = $('#txtemployeedocno').val();
		 $('#txtemployeeids').val('');$('#msg').val('');$('#mode').val('');$('#gridlength').val('');
		 var employeebranchchk=window.parent.employeebranchchk.value; 
	 	 var branch=document.getElementById("cmbbranch").value;
		 $("#overlay, #PleaseWait").show();
		 var check=1;
		 $("#openingBalanceDetailsDiv").load("openingBalanceGrid.jsp?category="+category+'&check='+check+'&department='+department+'&employee='+employee+'&branch='+branch+'&employeebranchchk='+employeebranchchk);
	} 
	
	function funNotify(){	
    	
		  var employeeids = $('#txtemployeeids').val();
		  if(employeeids.trim()==''){
			 $.messager.alert('Message','Change Opening For Some Employee(s) Before Saving.','warning');
			 return;
		  }
 		  
		   $.messager.confirm('Confirm', 'Do you want to save changes?', function(r){
	 		if (r){
	 				
	 			/* Opening Balance Grid  Saving*/
  			 	var rows = $("#openingDetailsGridID").jqxGrid('getrows');
  			 	var length=0;
  					 for(var i=0 ; i < rows.length ; i++){
  						var chk=rows[i].tobesaved;
  						if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
  							newTextBox = $(document.createElement("input"))
  						    .attr("type", "dil")
  						    .attr("id", "test"+length)
  						    .attr("name", "test"+length)
  							.attr("hidden", "true");
  							length=length+1;
  								
  				    newTextBox.val(rows[i].empdocno+"::"+rows[i].empacno+":: "+rows[i].terminationbenefits+":: "+rows[i].leavesalary+":: "+rows[i].travels);
  				    newTextBox.appendTo('form');
  				 }
  				}
  	 		 	$('#gridlength').val(length);
  			 	/* Opening Balance Grid  Saving Ends*/
	 		
			 document.getElementById("mode").value='A';
			 $("#overlay, #PleaseWait").show();
			 document.getElementById("frmDashboardOpening").submit();
			 
	 		 }
	 		});
		 
  		return 1;
	}
	
	function setValues(){
		  if($('#msg').val()!=""){
			 $.messager.alert('Message',$('#msg').val());
			 funreload(event);
		 }
	}
	
	function funExportBtn(){
		$("#openingBalanceDetailsDiv").excelexportjs({
			containerid: "openingBalanceDetailsDiv", 
			datatype: 'json', 
			dataset: null, 
			gridId: "openingDetailsGridID", 
			columns: getColumns("openingDetailsGridID") , 
			worksheetName:"OpeningBalance" 
			});
	} 
	
</script>
</head>
<body onload="getBranch();setValues();getPayrollCategory();getDepartment();">

<form id="frmDashboardOpening" action="saveDashboardOpening" method="post">

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

    <!-- SCROLLABLE FILTER CONTENT -->
    <div class="sidebar-scroll-content">

        <div class="filter-card">
        <table class="filter-table">

            <tr>
                <td class="label-cell">Category</td>
                <td>
                    <select id="cmbempcategory"
                            name="cmbempcategory">
                    </select>
                    <input type="hidden"
                           id="hidcmbempcategory"
                           name="hidcmbempcategory"
                           value='<s:property value="hidcmbempcategory"/>'>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Department</td>
                <td>
                    <select id="cmbdepartment"
                            name="cmbdepartment">
                    </select>
                    <input type="hidden"
                           id="hidcmbdepartment"
                           name="hidcmbdepartment"
                           value='<s:property value="hidcmbdepartment"/>'>
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

        <!-- MASTER BLUE BUTTONS -->
        <div class="filter-card">
    <div style="display:flex; gap:10px;">

        <button type="button"
                class="myButtons"
                onclick="funClearInfo();"
                style="flex:1;">
            Clear
        </button>

        <button type="button"
                class="myButton"
                onclick="funNotify();"
                style="flex:1;">
            Save
        </button>

    </div>
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
        <div id="openingBalanceDetailsDiv">
            <jsp:include page="openingBalanceGrid.jsp"></jsp:include>
        </div>
    </td>
</tr>
</table>

</td>

</tr>
</table>

<!-- HIDDEN FIELDS -->
<input type="hidden" id="txtemployeeids" name="txtemployeeids"
       value='<s:property value="txtemployeeids"/>'>

<input type="hidden" id="gridlength" name="gridlength"
       value='<s:property value="gridlength"/>'>

<input type="hidden" id="mode" name="mode"
       value='<s:property value="mode"/>'>

<input type="hidden" id="msg" name="msg"
       value='<s:property value="msg"/>'>

</div>

<div id="employeeDetailsWindow">
    <div></div>
</div>

</div>
</form>
</body>
