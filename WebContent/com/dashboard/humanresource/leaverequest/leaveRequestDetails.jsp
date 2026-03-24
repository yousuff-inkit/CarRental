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

</style>

<script type="text/javascript">

	$(document).ready(function () {
		
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 /* Searching Window */
     	 $('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
  		 $('#employeeDetailsWindow').jqxWindow('close');
  		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
		 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	     document.getElementById("rdall").checked=true;
	     
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
	
	function getDesignation() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var designationItems = items[0].split(",");
				var designationIdItems = items[1].split(",");
				var optionsdesignation = '<option value="">--Select--</option>';
				for (var i = 0; i < designationItems.length; i++) {
					optionsdesignation += '<option value="' + designationIdItems[i] + '">'
							+ designationItems[i] + '</option>';
				}
				$("select#cmbdesignation").html(optionsdesignation);
				
			} else {
			}
		}
		x.open("GET", "getDesignation.jsp", true);
		x.send();
	}
	
	function getCategory() {
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
  				$("select#cmbcategory").html(optionspayrollcategory);
  				
  			} else {
  			}
  		}
  		x.open("GET", "getCategory.jsp", true);
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
		$('#cmbbranch').val('a');$('#fromdate').val(new Date());$('#todate').val(new Date());
		var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	    var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	    var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	    $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	    $('#txtemployeeid').val('');$('#txtemployeename').val('');$('#txtemployeedocno').val('');
	    $('#cmbdepartment').val('');$('#cmbdesignation').val('');$('#cmbcategory').val('');
	    document.getElementById("rdall").checked=true;
		$("#leaveRequestDetailsGridID").jqxGrid('clear');$("#leaveRequestDetailsGridID").jqxGrid('addrow', null, {});
		
		if (document.getElementById("txtemployeeid").value == "") {
	        $('#txtemployeeid').attr('placeholder', 'Press F3 to Search'); 
	        $('#txtemployeename').attr('placeholder', 'Employee Name');
	    }
		
	 }
	
	function funreload(event){
		 var branchval = $('#cmbbranch').val(); 
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var department = $('#cmbdepartment').val();
		 var designation = $('#cmbdesignation').val();
		 var category = $('#cmbcategory').val();
		 var employee = $('#txtemployeedocno').val();
		 var employeebranchchk=window.parent.employeebranchchk.value;  
		 $("#overlay, #PleaseWait").show(); 
		 
		 if(document.getElementById("rdpending").checked==true){  
			 $("#leaveRequestDetailsDiv").load("leaveRequestDetailsGrid.jsp?rpttype=2&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&department='+department+'&designation='+designation+'&category='+category+'&employee='+employee+'&check=1'+'&employeebranchchk='+employeebranchchk);
		 	
		 } else if(document.getElementById("rdapproved").checked==true){
			 $("#leaveRequestDetailsDiv").load("leaveRequestDetailsGrid.jsp?rpttype=3&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&department='+department+'&designation='+designation+'&category='+category+'&employee='+employee+'&check=1'+'&employeebranchchk='+employeebranchchk);
			 
		 } else{
			 $("#leaveRequestDetailsDiv").load("leaveRequestDetailsGrid.jsp?rpttype=1&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&department='+department+'&designation='+designation+'&category='+category+'&employee='+employee+'&check=1'+'&employeebranchchk='+employeebranchchk);
		 }
	}
	
	function funExportBtn(){
		  $("#leaveRequestDetailsDiv").excelexportjs({
		  			containerid: "leaveRequestDetailsDiv",  
		  			datatype: 'json', 
		  			dataset: null, 
		  			gridId: "leaveRequestDetailsGridID", 
		  			columns: getColumns("leaveRequestDetailsGridID") ,   
		  			worksheetName:"LeaveRequestDetails"
		  			});
	}
	
	
</script>
</head>
<body onload="getBranch();getDepartment();getDesignation();getCategory();">

<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar" style="height:100%;">

<table width="100%">
<tr>
<td width="20%" valign="top">

<div class="master-container">
<div class="sidebar-filters">

    <div class="sidebar-fixed-top">
        <div class="filter-card">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>
    </div>

    <div class="sidebar-scroll-content">

        <div class="filter-card">
        <table class="filter-table">

            <tr>
                <td class="label-cell">From</td>
                <td><div id="fromdate"></div></td>
            </tr>

            <tr>
                <td class="label-cell">To</td>
                <td><div id="todate"></div></td>
            </tr>

            <tr>
                <td class="label-cell">Department</td>
                <td>
                    <select id="cmbdepartment" name="cmbdepartment">
                    </select>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Designation</td>
                <td>
                    <select id="cmbdesignation" name="cmbdesignation">
                    </select>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Category</td>
                <td>
                    <select id="cmbcategory" name="cmbcategory">
                    </select>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Employee</td>
                <td>
                    <input type="text"
                           id="txtemployeeid"
                           name="txtemployeeid"
                           placeholder="Press F3 to Search"
                           readonly
                           onkeydown="getEmployeeId(event);"
                           value='<s:property value="txtemployeeid"/>'>

                    <input type="hidden"
                           id="txtemployeedocno"
                           name="txtemployeedocno"
                           value='<s:property value="txtemployeedocno"/>'>
                </td>
            </tr>

            <tr>
                <td></td>
                <td>
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

        <div class="filter-card">
            <div style="font-weight:bold;margin-bottom:6px;">Report Type</div>

            <div style="display:flex;justify-content:space-around;">
                <label class="branch">
                    <input type="radio" id="rdall" name="rdo"> All
                </label>

                <label class="branch">
                    <input type="radio" id="rdpending" name="rdo"> Pending
                </label>
            </div>

            <div style="text-align:center;margin-top:6px;">
                <label class="branch">
                    <input type="radio" id="rdapproved" name="rdo"> Approved
                </label>
            </div>
        </div>

    
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

<td width="80%" valign="top">

<table width="100%">
<tr>
    <td>
        <div id="leaveRequestDetailsDiv">
            <jsp:include page="leaveRequestDetailsGrid.jsp"></jsp:include>
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

