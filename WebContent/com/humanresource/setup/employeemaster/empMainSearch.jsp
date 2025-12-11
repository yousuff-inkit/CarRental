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
/* popup container */
#search {
    width: 900px;
    margin: 0 auto;
    background: #f6f8fa;
    border-radius: 10px;
    box-shadow: 0 8px 30px rgba(15,23,42,0.25);
    font-family: 'Segoe UI','Roboto','Arial',sans-serif;
    font-size: 13px;
    color: #222;
}

/* inner padding */
#search-body {
    padding: 8px 14px 10px 14px;
}

/* search table */
#search table.cr-search-table {
    width: 100%;
    border-collapse: collapse;
    background: #f9fafb;
    border-radius: 8px;
    box-shadow: 0 0 0 1px #e0e4ee;
}

#search table.cr-search-table td {
    padding: 4px 6px;
    vertical-align: middle;
    font-size: 12px;
}

/* bold right labels */
#search table.cr-search-table td[align="right"] {
    font-weight: 600;
    color: #333;
    white-space: nowrap;
}

/* inputs/selects */
#search input[type="text"],
#search select {
    width: 100%;
    border: 1px solid #d1d5db;
    border-radius: 5px;
    padding: 4px 8px;
    height: 22px;
    line-height: 22px;
    font-size: 12px;
    box-sizing: border-box;
}

/* date widget container spans cell */
#txtdob {
    width: 100%;
}

/* button */
#search .myButton,
#btnsearch {
    background: #007bff;
    color: #fff;
    border: none;
    border-radius: 6px;
    height: 24px;
    line-height: 22px;
    padding: 0 16px;
    cursor: pointer;
    font-size: 12px;
    font-weight: 600;
}
#search .myButton:hover,
#btnsearch:hover {
    background: #0056b3;
}

/* result area */
#refreshdiv {
    margin-top: 8px;
    background: #fff;
    border-radius: 6px;
    box-shadow: 0 0 0 1px #e0e4ee;
}
</style>

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

<body>
<div id="search">
    <div id="search-body">
        <table class="cr-search-table">
            <tr>
                <td align="right" style="width:12%;">Name</td>
                <td style="width:38%;">
                    <input type="text" name="txtempname" id="txtempname"
                           value='<s:property value="txtempname"/>'>
                </td>

                <td align="right" style="width:10%;">Mob</td>
                <td style="width:20%;">
                    <input type="text" name="txtmobile" id="txtmobile"
                           value='<s:property value="txtmobile"/>'>
                </td>

                <td style="width:20%;" align="center">
                    <input type="button" name="btnsearch" id="btnsearch"
                           class="myButton" value="Search"
                           onclick="loadSearch();">
                </td>
            </tr>

            <tr>
                <td align="right">Designation</td>
                <td>
                    <select id="employeedesignation" name="employeedesignation"
                            value='<s:property value="employeedesignation"/>'>
                        <option value="">--Select--</option>
                    </select>
                </td>

                <td align="right">Department</td>
                <td>
                    <select id="employeedepartment" name="employeedepartment"
                            value='<s:property value="employeedepartment"/>'>
                        <option value="">--Select--</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td align="right">Emp#</td>
                <td>
                    <input type="text" name="txtempid" id="txtempid"
                           value='<s:property value="txtempid"/>'>
                </td>

                <td align="right">DOB</td>
                <td>
                    <div id="txtdob" name="txtdob"
                         value='<s:property value="txtdob"/>'></div>
                </td>

                <td></td>
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
</div>
</body>
</html>
