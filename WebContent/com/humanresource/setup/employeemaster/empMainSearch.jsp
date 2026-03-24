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



<script type="text/javascript">
$(document).ready(function () {
    $("#txtdob").jqxDateTimeInput({
        width: '110px',
        height: '15px',
        formatString:"dd.MM.yyyy",
        value:null
    });
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
    var empname            = document.getElementById("txtempname").value;
    var mob                = document.getElementById("txtmobile").value;
    var employeedesignation= document.getElementById("employeedesignation").value;
    var employeedepartment = document.getElementById("employeedepartment").value;
    var empid              = document.getElementById("txtempid").value;
    var dob                = document.getElementById("txtdob").value;
    var employeebranchchk  = window.parent.employeebranchchk.value;
    var branch             = document.getElementById("brchName").value;
    getdata(empname, mob, employeedesignation, employeedepartment, empid, dob,
            employeebranchchk, branch);
}

function getdata(empname, mob, employeedesignation, employeedepartment,
                 empid, dob, employeebranchchk, branch){
    $("#refreshdiv").load(
        'empMainSearchGrid.jsp?empname=' + empname.replace(/ /g, "%20") +
        '&mob=' + mob +
        '&employeedesignation=' + employeedesignation +
        '&employeedepartment=' + employeedepartment +
        '&empid=' + empid +
        '&dob=' + dob +
        '&branch=' + branch +
        '&employeebranchchk=' + employeebranchchk
    );
}
</script>
</head>

<style type="text/css">
#search {
    width: 900px;
    margin: 0 auto;
    background: #ffffff;
    border: 1px solid #ccc;
    font-family: Tahoma, Geneva, sans-serif;
}

#search table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 12px 10px; 
}

td[align="right"] {
    font-size: 13px;
    font-weight: 700;
    color: #333;
    white-space: nowrap;
}

input[type="text"], select {
    font-family: Tahoma, Geneva, sans-serif;
    font-weight: 600;
    font-size: 12px;
    padding: 4px 8px;
    width: 100%;
    box-sizing: border-box;
    border: 1px solid #d1d5db;
    border-radius: 4px;
    height: 28px;
}

.myButton {
    font-family: Tahoma, Geneva, sans-serif;
    font-weight: 700;
    font-size: 13px;
    width: 130px;
    height: 38px;
    padding: 8px 12px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 2px 4px rgba(59, 130, 246, 0.2);
    text-transform: uppercase;
    letter-spacing: 0.3px;
    white-space: nowrap;
    text-align: center;
}

.myButton:hover {
    background: linear-gradient(135deg, #2563eb 0%, #0b45a2 100%);
    box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
    transform: translateY(-1px);
}

#refreshdiv {
    margin-top: 10px;
    border-top: 1px solid #e0e4ee;
}
</style>

<body bgcolor="#E0ECF8">
<div id="search">
    <table border="0">
        <tr>
            <td width="10%" align="right">Name</td>
            <td width="30%">
                <input type="text" name="txtempname" id="txtempname" value='<s:property value="txtempname"/>'>
            </td>
            <td width="10%" align="right">Mob</td>
            <td width="20%">
                <input type="text" name="txtmobile" id="txtmobile" value='<s:property value="txtmobile"/>'>
            </td>
            <td width="30%" rowspan="2" align="center" valign="middle">
                <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch();">
            </td>
        </tr>
        <tr>
            <td align="right">Designation</td>
            <td>
                <select id="employeedesignation" name="employeedesignation">
                    <option value="">--Select--</option>
                </select>
            </td>
            <td align="right">Department</td>
            <td>
                <select id="employeedepartment" name="employeedepartment">
                    <option value="">--Select--</option>
                </select>
            </td>
        </tr>
        <tr>
            <td align="right">Emp#</td>
            <td>
                <input type="text" name="txtempid" id="txtempid" value='<s:property value="txtempid"/>'>
            </td>
            <td align="right">DOB</td>
            <td>
                <div id="txtdob" name="txtdob"></div>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td colspan="5">
                <div id="refreshdiv">
                    <jsp:include page="empMainSearchGrid.jsp"></jsp:include>
                </div>
            </td>
        </tr>
    </table>
</div>
</body>
</html>
