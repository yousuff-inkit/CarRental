<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath(); %>
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
    background-color: #0056b3;
    color: #ffffff;
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
    $(document).ready(function () {}); 

    function loadSearch() {
        var employeeName = document.getElementById("txtpartyname").value || "";
        var empId = document.getElementById("txtpartyid").value || "";
        var contactNo = document.getElementById("txtcontactno").value || "";
        
        // Safely check for elements that might not be on this specific modal version
        var designation = document.getElementById("cmbempdesignation") ? document.getElementById("cmbempdesignation").value : "";
        var department = document.getElementById("cmbempdepartment") ? document.getElementById("cmbempdepartment").value : "";
        var category = document.getElementById("cmbpayrollcategory") ? document.getElementById("cmbpayrollcategory").value : "";
        
        var employeebranchchk = "";
        if (window.parent && window.parent.employeebranchchk) {
            employeebranchchk = window.parent.employeebranchchk.value;
        }
        
        var branch = document.getElementById("brchName") ? document.getElementById("brchName").value : "";
        
        getdata(employeeName, empId, contactNo, designation, department, category, employeebranchchk, branch);
    }
    
    function getdata(employeeName, empId, contactNo, designation, department, category, employeebranchchk, branch){
        /* Safely encoding URI components to prevent breakages on special characters */
        $("#refreshdiv").load('employeeDetailsSearchGrid.jsp?employeename=' + encodeURIComponent(employeeName) + 
                              '&empid=' + encodeURIComponent(empId) + 
                              '&designation=' + encodeURIComponent(designation) + 
                              '&department=' + encodeURIComponent(department) + 
                              '&category=' + encodeURIComponent(category) + 
                              '&contactno=' + encodeURIComponent(contactNo) + 
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
                <col width="10%" /> <col width="25%" /> <col width="10%" /> <col width="25%" /> <col width="30%" /> </colgroup>
            
            <tr>
                <td class="lbl-right">Name</td>
                <td>
                    <input type="text" name="txtpartyname" id="txtpartyname" autocomplete="off" value='<s:property value="txtpartyname"/>'>
                </td>
                
                <td class="lbl-right">ID#</td>
                <td>
                    <input type="text" name="txtpartyid" id="txtpartyid" autocomplete="off" value='<s:property value="txtpartyid"/>'>
                </td>
                
                <td align="center" rowspan="2" valign="middle">
                    <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch(); return false;">
                </td>
            </tr>
            
            <tr>
                <td class="lbl-right">Contact No.</td>
                <td>
                    <input type="text" name="txtcontactno" id="txtcontactno" autocomplete="off" value='<s:property value="txtcontactno"/>'>
                </td>
                <td colspan="2"></td> </tr>
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