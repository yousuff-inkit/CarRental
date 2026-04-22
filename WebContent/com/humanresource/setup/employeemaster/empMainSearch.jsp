<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<style>
/* =========================================================
   SCOPED UI: Compact Search Modal Layout (Pure White & Segoe UI)
========================================================= */
body {
    margin: 0;
    background-color: #fff;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
}

.modern-ui {
    font-size: 12px;
    color: #333;
    padding: 10px;
    box-sizing: border-box;
    width: 100%;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
}

/* Master Input Heights - Forced to 24px and Font Enforced */
.modern-ui input[type="text"],
.modern-ui select {
    height: 24px !important;
    border: 1px solid #b8c6d8;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 12px;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    box-sizing: border-box;
    background-color: #fff;
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus {
    border-color: #007bff;
    outline: none;
}

/* Panel Styling - Pure White */
.modern-ui .search-panel {
    background-color: #fff !important; 
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    padding: 15px;
    margin-bottom: 10px;
}

.modern-ui table {
    border-collapse: collapse;
    width: 100%;
}

.modern-ui td {
    padding: 4px 5px;
    vertical-align: middle;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Modern Search Button - Font Enforced */
.modern-ui .myButton {
    height: 24px !important; 
    line-height: 22px !important;
    padding: 0 20px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #fff !important;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 12px;
    font-weight: bold;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    box-shadow: 0 1px 2px rgba(59, 130, 246, 0.3);
    transition: all 0.2s;
    text-transform: uppercase;
}

.modern-ui .myButton:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%);
    transform: translateY(-1px);
}

/* Data Grid Container */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}
</style>

<script type="text/javascript">
$(document).ready(function () {
    /* COMPACT DATE/TIME SIZING - FIXED WIDTH TO PREVENT SQUISHING */
    $("#txtdob").jqxDateTimeInput({
        width: '110px', /* CHANGED from 100% to 110px */
        height: '24px',
        formatString:"dd.MM.yyyy",
        value:null
    });
    
    /* Force internal alignment AFTER render - Font Enforced */
    setTimeout(function () {
        $(".jqx-datetimeinput").find("input").css({
            "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
            "font-family": "'Segoe UI', 'Roboto', 'Arial', sans-serif", "padding": "0 6px", "box-sizing":"border-box"
        });
        $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
    }, 0);

    getEmpDesignation();
    getEmpDepartment();
}); 

function getEmpDesignation() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.split('####');
            var designationItems = items[0].split(",");
            var designationIdItems = items[1].split(",");
            var optionsdesignation = '<option value="">--Select--</option>';
            for (var i = 0; i < designationItems.length; i++) {
                optionsdesignation += '<option value="' + designationIdItems[i] + '">' +
                                      designationItems[i] + '</option>';
            }
            $("select#employeedesignation").html(optionsdesignation);
        }
    };
    x.open("GET", "getDesignation.jsp", true);
    x.send();
}

function getEmpDepartment() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.split('####');
            var departmentItems = items[0].split(",");
            var departmentIdItems = items[1].split(",");
            var optionsdepartment = '<option value="">--Select--</option>';
            for (var i = 0; i < departmentItems.length; i++) {
                optionsdepartment += '<option value="' + departmentIdItems[i] + '">' +
                                     departmentItems[i] + '</option>';
            }
            $("select#employeedepartment").html(optionsdepartment);
        }
    };
    x.open("GET", "getDepartment.jsp", true);
    x.send();
}

function loadSearch() {
    var empname            = document.getElementById("txtempname").value || "";
    var mob                = document.getElementById("txtmobile").value || "";
    var employeedesignation= document.getElementById("employeedesignation").value || "";
    var employeedepartment = document.getElementById("employeedepartment").value || "";
    var empid              = document.getElementById("txtempid").value || "";
    var dob                = $('#txtdob').jqxDateTimeInput('val') || "";
    
    /* Safety check for parent window elements */
    var employeebranchchk  = (window.parent && window.parent.employeebranchchk) ? window.parent.employeebranchchk.value : "0";
    var branchElem         = document.getElementById("brchName");
    var branch             = branchElem ? branchElem.value : "";
    
    getdata(empname, mob, employeedesignation, employeedepartment, empid, dob, employeebranchchk, branch);
}

function getdata(empname, mob, employeedesignation, employeedepartment, empid, dob, employeebranchchk, branch){
    /* Used encodeURIComponent to safely handle spaces and special characters */
    $("#refreshdiv").load(
        'empMainSearchGrid.jsp?empname=' + encodeURIComponent(empname) +
        '&mob=' + encodeURIComponent(mob) +
        '&employeedesignation=' + encodeURIComponent(employeedesignation) +
        '&employeedepartment=' + encodeURIComponent(employeedepartment) +
        '&empid=' + encodeURIComponent(empid) +
        '&dob=' + dob +
        '&branch=' + encodeURIComponent(branch) +
        '&employeebranchchk=' + encodeURIComponent(employeebranchchk)
    );
}
</script>
</head>

<body style="background-color: #fff; margin: 0;">
<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
            <tr>
                <td class="lbl-right" width="8%">Name</td>
                <td width="20%">
                    <input type="text" name="txtempname" id="txtempname" value='<s:property value="txtempname"/>'>
                </td>
                
                <td class="lbl-right" width="8%">Mob</td>
                <td width="20%">
                    <input type="text" name="txtmobile" id="txtmobile" value='<s:property value="txtmobile"/>'>
                </td>
                
                <td class="lbl-right" width="10%">Designation</td>
                <td width="20%">
                    <select id="employeedesignation" name="employeedesignation">
                        <option value="">--Select--</option>
                    </select>
                </td>
            </tr>
            
            <tr>
                <td class="lbl-right" style="padding-top: 8px;">Department</td>
                <td style="padding-top: 8px;">
                    <select id="employeedepartment" name="employeedepartment">
                        <option value="">--Select--</option>
                    </select>
                </td>
                
                <td class="lbl-right" style="padding-top: 8px;">Emp#</td>
                <td style="padding-top: 8px;">
                    <input type="text" name="txtempid" id="txtempid" value='<s:property value="txtempid"/>'>
                </td>
                
                <td class="lbl-right" style="padding-top: 8px;">DOB</td>
                <td style="padding-top: 8px; display: flex; gap: 10px; align-items: center; border: none;">
                    <div id="txtdob" name="txtdob"></div>
                    <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch(); return false;">
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="refreshdiv">
            <jsp:include page="empMainSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>
</body>
</html>