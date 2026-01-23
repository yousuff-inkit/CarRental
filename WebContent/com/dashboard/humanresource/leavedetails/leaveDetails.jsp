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
		
		 $('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
  		 $('#employeeDetailsWindow').jqxWindow('close');
		 
  		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
		 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 $('#txtemployeeid').attr('readonly', true);
		 $('#txtemployeename').attr('readonly', true);
		 document.getElementById("rdsummary").checked=true;
		 $("#leaveDetailsDetailedDiv").prop("hidden", true); 
		 $('#cmbleavetype').attr('disabled', true );
			
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
				var optionsdepartment = '<option value="">--Select--</option>';
				for (var i = 0; i < departmentItems.length; i++) {
					optionsdepartment += '<option value="' + departmentIdItems[i] + '">'
							+ departmentItems[i] + '</option>';
				}
				$("select#cmbempdepartment").html(optionsdepartment);
			} else {
			}
		}
		x.open("GET", "getDepartment.jsp", true);
		x.send();
	}
    function getYear() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var yearItems = items[0].split(",");
				var yearIdItems = items[1].split(",");
				var optionsyear = '<option value="">--Select--</option>';
				for (var i = 0; i < yearItems.length; i++) {
					optionsyear += '<option value="' + yearIdItems[i] + '">'
							+ yearItems[i] + '</option>';
				}
				$("select#cmbyear").html(optionsyear);
			} else {
			}
		}
		x.open("GET", "getYear.jsp", true);
		x.send();
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
    
    function getLeaveType() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var leavetypeItems = items[0].split(",");
				var leavetypeIdItems = items[1].split(",");
				var optionsleavetype = '<option value="">--Select--</option>';
				for (var i = 0; i < leavetypeItems.length; i++) {
					optionsleavetype += '<option value="' + leavetypeIdItems[i] + '">'
							+ leavetypeItems[i] + '</option>';
				}
				$("select#cmbleavetype").html(optionsleavetype);
				
			} else {
			}
		}
		x.open("GET", "getLeaveType.jsp", true);
		x.send();
	}
    
    function getEmployeeId(event){
        var x= event.keyCode;
        if(x==114){
        	employeeSearchContent("employeeDetailsSearch.jsp");
        }
        else{}
        }
    
    function funleavestype() {
    	 var leavetype=$('#cmbleavetype').children("option").length;
		 for(var k=1 ; k <= leavetype ; k++){
			 $('#txtleavename'+k).val($('#cmbleavetype option').eq(k).text().trim());
		 } 
    }
    
    function funGridHide(){
		if(document.getElementById("rdsummary").checked==true){
       	 	$("#leaveDetailsDetailedDiv").prop("hidden", true); 
       	 	$("#leaveDetailsDiv").prop("hidden", false);
			$('#cmbleavetype').attr('disabled', true );
			$("#leaveDetailsGridID").jqxGrid('clear');$("#leaveDetailsGridID").jqxGrid('addrow', null, {});
			$("#leaveDetailsDetailedGridID").jqxGrid('clear');$("#leaveDetailsDetailedGridID").jqxGrid('addrow', null, {});
        
	    } else if(document.getElementById("rddetailed").checked==true){
       	    $("#leaveDetailsDiv").prop("hidden", true);
       	    $("#leaveDetailsDetailedDiv").prop("hidden", false);
			$('#cmbleavetype').attr('disabled', false );
			$("#leaveDetailsGridID").jqxGrid('clear');$("#leaveDetailsGridID").jqxGrid('addrow', null, {});
			$("#leaveDetailsDetailedGridID").jqxGrid('clear');$("#leaveDetailsDetailedGridID").jqxGrid('addrow', null, {});
        }
	 }
    
    function funClearInfo(){
		$('#cmbbranch').val('a');$('#cmbyear').val('');$('#cmbmonth').val('');$('#cmbempdepartment').val('');$('#cmbempcategory').val('');
		$('#txtemployeeid').val('');$('#txtemployeedocno').val('');$('#txtemployeename').val('');
		$("#leaveDetailsGridID").jqxGrid('clear');$("#leaveDetailsGridID").jqxGrid('addrow', null, {});
		
		document.getElementById("rdsummary").checked=true;
		funGridHide();
	}
    
    function funClearYearInfo(){
		$('#cmbmonth').val('');$('#cmbempdepartment').val('');$('#cmbempcategory').val('');
		$('#txtemployeeid').val('');$('#txtemployeedocno').val('');$('#txtemployeename').val('');
		$("#leaveDetailsGridID").jqxGrid('clear');$("#leaveDetailsGridID").jqxGrid('addrow', null, {});
		
		document.getElementById("rdsummary").checked=true;
		funGridHide();
	}
	
	function funExportBtn(){
		if(document.getElementById("rdsummary").checked==true){
			$("#leaveDetailsDiv").excelexportjs({
				containerid: "leaveDetailsDiv", 
				datatype: 'json', 
				dataset: null, 
				gridId: "leaveDetailsGridID", 
				columns: getColumns("leaveDetailsGridID") ,   
				worksheetName:"LeaveDetails"
				});
		} else if(document.getElementById("rddetailed").checked==true){
			$("#leaveDetailsDetailedDiv").excelexportjs({
				containerid: "leaveDetailsDetailedDiv", 
				datatype: 'json', 
				dataset: null, 
				gridId: "leaveDetailsDetailedGridID", 
				columns: getColumns("leaveDetailsDetailedGridID") ,    
				worksheetName:"LeaveDetails"
				});
		}
	} 
	
	function funreload(event){
		 var year=$('#cmbyear').val();
		 var month=$('#cmbmonth').val();
		 var department=$('#cmbempdepartment').val();
		 var category=$('#cmbempcategory').val();
		 var empId=$('#txtemployeedocno').val();
		 var employeebranchchk=window.parent.employeebranchchk.value; 
	 	 var branch=document.getElementById("cmbbranch").value; 
		 funleavestype();
		 
		 $("#overlay, #PleaseWait").show();
		 
		 if(document.getElementById("rdsummary").checked==true){ 
		 	$("#leaveDetailsDiv").load("leaveDetailsGrid.jsp?year="+year+"&month="+month+"&department="+department+"&category="+category+"&empId="+empId+"&check=1"+'&branch='+branch+'&employeebranchchk='+employeebranchchk);
		 } else if(document.getElementById("rddetailed").checked==true){
			 var leavetype=$('#cmbleavetype').val();
			 $("#leaveDetailsDetailedDiv").load("leaveDetailsDetailedGrid.jsp?year="+year+"&month="+month+"&department="+department+"&category="+category+"&leaveType="+leavetype+"&empId="+empId+"&check=1"+'&branch='+branch+'&employeebranchchk='+employeebranchchk); 
		 }
	}
	
</script>
</head>
<body onload="getBranch();getYear();getDepartment();getPayrollCategory();getLeaveType();">

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
                <td class="label-cell">Year</td>
                <td>
                    <select id="cmbyear" name="cmbyear"
                            onchange="funClearYearInfo();">
                    </select>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Month</td>
                <td>
                    <select id="cmbmonth" name="cmbmonth">
                        <option value="">--Select--</option>
                        <option value="01">January</option>
                        <option value="02">February</option>
                        <option value="03">March</option>
                        <option value="04">April</option>
                        <option value="05">May</option>
                        <option value="06">June</option>
                        <option value="07">July</option>
                        <option value="08">August</option>
                        <option value="09">September</option>
                        <option value="10">October</option>
                        <option value="11">November</option>
                        <option value="12">December</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Department</td>
                <td>
                    <select id="cmbempdepartment"
                            name="cmbempdepartment">
                        <option value="">--Select--</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Category</td>
                <td>
                    <select id="cmbempcategory"
                            name="cmbempcategory">
                        <option value="">--Select--</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Leaves</td>
                <td>
                    <select id="cmbleavetype"
                            name="cmbleavetype">
                        <option value="">--Select--</option>
                    </select>
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

            <tr>
                <td colspan="2">
                    <div class="filter-subbox">
                        <div class="subbox-title">Report Type</div>
                        <div style="display:flex;justify-content:space-around;">
                            <label>
                                <input type="radio"
                                       id="rdsummary"
                                       name="rdo"
                                       value="rdsummary"
                                       onchange="funGridHide();">
                                Summary
                            </label>
                            <label>
                                <input type="radio"
                                       id="rddetailed"
                                       name="rdo"
                                       value="rddetailed"
                                       onchange="funGridHide();">
                                Detailed
                            </label>
                        </div>
                    </div>
                </td>
            </tr>

        </table>
        </div>

        <!-- MASTER BLUE BUTTON -->
        <div class="filter-card" style="text-align:center;">
            <button type="button"
                    onclick="funClearInfo();"
                    style="
                        background:linear-gradient(#2196f3,#1e88e5);
                        border:1px solid #1565c0;
                        color:#fff;
                        padding:6px 22px;
                        border-radius:4px;
                        font-weight:bold;
                        cursor:pointer;">
                Clear
            </button>
        </div>

        <!-- HIDDEN FIELDS -->
        <input type="hidden" id="txtleavename1" name="txtleavename1" value='<s:property value="txtleavename1"/>'>
        <input type="hidden" id="txtleavename2" name="txtleavename2" value='<s:property value="txtleavename2"/>'>
        <input type="hidden" id="txtleavename3" name="txtleavename3" value='<s:property value="txtleavename3"/>'>
        <input type="hidden" id="txtleavename4" name="txtleavename4" value='<s:property value="txtleavename4"/>'>
        <input type="hidden" id="txtleavename5" name="txtleavename5" value='<s:property value="txtleavename5"/>'>
        <input type="hidden" id="txtleavename6" name="txtleavename6" value='<s:property value="txtleavename6"/>'>
        <input type="hidden" id="txtleavename7" name="txtleavename7" value='<s:property value="txtleavename7"/>'>
        <input type="hidden" id="txtleavename8" name="txtleavename8" value='<s:property value="txtleavename8"/>'>
        <input type="hidden" id="txtleavename9" name="txtleavename9" value='<s:property value="txtleavename9"/>'>
        <input type="hidden" id="txtleavename10" name="txtleavename10" value='<s:property value="txtleavename10"/>'>

    </div>
</div>
</div>

</td>

<!-- ================= RIGHT PANEL ================= -->
<td width="80%" valign="top">

<table width="100%">
<tr>
    <td>
        <div id="leaveDetailsDiv">
            <jsp:include page="leaveDetailsGrid.jsp"></jsp:include>
        </div>

        <div id="leaveDetailsDetailedDiv">
            <jsp:include page="leaveDetailsDetailedGrid.jsp"></jsp:include>
        </div>
    </td>
</tr>
</table>

</td>

</tr>
</table>

</div>

<div id="employeeDetailsWindow"><div></div></div>

</div>
</body>

