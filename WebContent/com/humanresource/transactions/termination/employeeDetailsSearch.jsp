<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
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
   SCOPED UI: Strict Pixel Grid Alignment & Modern Inputs
========================================================= */
body {
    margin: 0;
    background-color: #fff;
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
}

/* Panel Styling */
.modern-ui .search-panel {
    background-color: #fff !important; 
    border: 1px solid #BDBDBD;
    border-radius: 4px;
    padding: 12px 10px;
    margin-bottom: 10px;
    width: 100%;
    box-sizing: border-box;
}

/* Table Alignment - STRICT PERCENTAGE GRID */
.modern-ui table {
    border-collapse: separate;
    border-spacing: 5px 8px; 
    width: 100%;
    table-layout: fixed; /* Locks columns from squishing */
}

.modern-ui td {
    vertical-align: middle;
    padding: 0;
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

/* Search Button - Standard Blue */
.modern-ui .myButton {
    height: 26px;
    padding: 0 20px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #fff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 12px;
    font-weight: bold;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    transition: all 0.2s;
}

.modern-ui .myButton:hover {
    background-color: #004494;
}

/* Grid Container */
.modern-ui .grid-container {
    border: 1px solid #BDBDBD;
    background: #fff;
    overflow: hidden;
    width: 100%;
}
</style>

<script type="text/javascript">
    $(document).ready(function () {
        /* FIXED 120px WIDTH for safe calendar rendering */
        $("#txtdoj").jqxDateTimeInput({ width: '120px', height: '24px', formatString:"dd.MM.yyyy", value:null});
        
        getEmpDesignation();
        getEmpDepartment();

        /* Force internal alignment AFTER render */
        setTimeout(function () {
            $(".jqx-datetimeinput").css({"margin-top": "0px", "border-color": "#BDBDBD", "border-radius": "3px"});
            $(".jqx-datetimeinput").find("input").css({
                "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
                "font-family": "'Segoe UI', 'Roboto', 'Arial', sans-serif", "padding": "0 6px", "box-sizing":"border-box"
            });
            $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
        }, 100);
    }); 

    function getEmpDesignation() {
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
                var items = x.responseText;
                items = items.split('####');
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
        
        var employeebranchchk = "";
        if(window.parent && window.parent.employeebranchchk) {
            employeebranchchk = window.parent.employeebranchchk.value; 
        }
        var branch = "";
        if(document.getElementById("brchName")){
            branch = document.getElementById("brchName").value;
        }
        
        var check = 1;
        
        getdata(empname, mob, employeedesignation, employeedepartment, empid, doj, check, employeebranchchk, branch);
    }
    
    function getdata(empname, mob, employeedesignation, employeedepartment, empid, doj, check, employeebranchchk, branch){
        /* Used encodeURIComponent to safely handle spaces and special characters */
        $("#refreshdiv").load('employeeDetailsSearchGrid.jsp?empname=' + encodeURIComponent(empname) + 
                              '&mob=' + encodeURIComponent(mob) + 
                              '&employeedesignation=' + encodeURIComponent(employeedesignation) + 
                              '&employeedepartment=' + encodeURIComponent(employeedepartment) + 
                              '&empid=' + encodeURIComponent(empid) + 
                              '&doj=' + encodeURIComponent(doj) + 
                              '&check=' + check + 
                              '&branchid=' + encodeURIComponent(branch) + 
                              '&employeebranchchk=' + encodeURIComponent(employeebranchchk));
    }
</script>

</head>
<body style="background-color: #fff; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <colgroup>
                <col width="12%" /> <col width="25%" /> <col width="12%" /> <col width="25%" /> <col width="26%" /> </colgroup>
            
            <tr>
                <td class="lbl-right">Name</td>
                <td>
                    <input type="text" name="txtempname" id="txtempname" autocomplete="off" value='<s:property value="txtempname"/>'>
                </td>
                
                <td class="lbl-right">Mob</td>
                <td>
                    <input type="text" name="txtmobile" id="txtmobile" autocomplete="off" value='<s:property value="txtmobile"/>'>
                </td>
                
                <td align="center" rowspan="3" valign="middle">
                    <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch(); return false;">
                </td>
            </tr>

            <tr>
                <td class="lbl-right">Designation</td>
                <td>
                    <select id="employeedesignation" name="employeedesignation">
                        <option value="">--Select--</option>
                    </select>
                </td>

                <td class="lbl-right">Department</td>
                <td>
                    <select id="employeedepartment" name="employeedepartment">
                        <option value="">--Select--</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td class="lbl-right">Emp#</td>
                <td>
                    <input type="text" name="txtempid" id="txtempid" autocomplete="off" value='<s:property value="txtempid"/>'>
                </td>

                <td class="lbl-right">Date of Join</td>
                <td>
                    <div id="txtdoj" name="txtdoj"></div>
                </td>
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