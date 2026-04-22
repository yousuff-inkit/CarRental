<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

<style>
/* =========================================================
   SCOPED UI: Segoe UI Font & Clean White Search Panel
========================================================= */
body {
    margin: 0;
    background-color: #fff; /* Main background white */
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif; 
}

.modern-ui {
    font-size: 12px;
    color: #333;
    padding: 10px;
    box-sizing: border-box;
    width: 100%;
}

/* Master Input Styles */
.modern-ui input[type="text"],
.modern-ui select {
    height: 24px !important;
    border: 1px solid #BDBDBD;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 12px; 
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    box-sizing: border-box;
    background-color: #fff;
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus {
    border-color: #007bff;
    outline: none;
    background-color: #FFD6FF; /* Client master focus color */
}

/* Panel Styling - Clean White Panel */
.modern-ui .search-panel {
    background-color: #fff !important; 
    border: 1px solid #BDBDBD;
    border-radius: 4px;
    padding: 12px;
    margin-bottom: 10px;
}

/* Table Alignment */
.modern-ui table {
    border-collapse: separate;
    border-spacing: 5px 8px; 
    width: 100%;
}

.modern-ui td {
    vertical-align: middle;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #222;
    font-size: 12px; 
    font-weight: 600;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Search Button - Modern Blue matched to Client Master */
.modern-ui .myButton {
    height: 26px;
    padding: 0 20px;
    background-color: #0056b3;
    color: #ffffff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 12px;
    font-weight: bold;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

.modern-ui .myButton:hover {
    background-color: #004494;
}

/* Grid Container */
.modern-ui .grid-container {
    border: 1px solid #BDBDBD;
    background: #fff;
}
</style>

<script type="text/javascript">
    $(document).ready(function () {
        /* Date left untouched at 15px height to match reference logic */
        $("#txtdoj").jqxDateTimeInput({ width: '110px', height: '15px', formatString:"dd.MM.yyyy", value:null});
        
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
                    optionsdesignation += '<option value="' + designationIdItems[i] + '">'
                            + designationItems[i] + '</option>';
                }
                $("select#employeedesignation").html(optionsdesignation);
            }
        }
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
                    optionsdepartment += '<option value="' + departmentIdItems[i] + '">'
                            + departmentItems[i] + '</option>';
                }
                $("select#employeedepartment").html(optionsdepartment);
            }
        }
        x.open("GET", "getDepartment.jsp", true);
        x.send();
    }
  
    function loadSearch() {
        var empname = document.getElementById("txtempname").value || "";
        var mob = document.getElementById("txtmobile").value || "";
        var employeedesignation = document.getElementById("employeedesignation").value || "";
        var employeedepartment = document.getElementById("employeedepartment").value || "";
        var empid = document.getElementById("txtempid").value || "";
        var doj = $('#txtdoj').jqxDateTimeInput('val') || "";
        var check = 1;
        
        getdata(empname, mob, employeedesignation, employeedepartment, empid, doj, check);
    }
    
    function getdata(empname, mob, employeedesignation, employeedepartment, empid, doj, check){
         $("#refreshdiv").load('employeeDetailsSearchGrid.jsp?empname=' + encodeURIComponent(empname) + 
                               '&mob=' + encodeURIComponent(mob) + 
                               '&employeedesignation=' + encodeURIComponent(employeedesignation) + 
                               '&employeedepartment=' + encodeURIComponent(employeedepartment) + 
                               '&empid=' + encodeURIComponent(empid) + 
                               '&doj=' + doj + 
                               '&check=' + check);
    }
</script>
</head>

<body style="background-color: #fff; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="lbl-right" width="10%">Name</td>
                <td colspan="3" width="45%">
                    <input type="text" name="txtempname" id="txtempname" value='<s:property value="txtempname"/>'>
                </td>
                
                <td class="lbl-right" width="10%">Mob</td>
                <td width="20%">
                    <input type="text" name="txtmobile" id="txtmobile" value='<s:property value="txtmobile"/>'>
                </td>
                
                <td width="15%" align="center" rowspan="2">
                    <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch(); return false;">
                </td>
            </tr>
            <tr>
                <td class="lbl-right">Designation</td>
                <td width="15%">
                    <select id="employeedesignation" name="employeedesignation">
                        <option value="">--Select--</option>
                    </select>
                </td>
                
                <td class="lbl-right" width="10%">Department</td>
                <td width="20%">
                    <select id="employeedepartment" name="employeedepartment">
                        <option value="">--Select--</option>
                    </select>
                </td>
                
                <td class="lbl-right">Emp#</td>
                <td>
                    <input type="text" name="txtempid" id="txtempid" value='<s:property value="txtempid"/>'>
                </td>
                
                </tr>
            <tr>
                <td class="lbl-right">Date of Join</td>
                <td>
                    <div id="txtdoj" name="txtdoj"></div>
                </td>
                <td colspan="5"></td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="refreshdiv">
            <jsp:include page="employeeDetailsSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>