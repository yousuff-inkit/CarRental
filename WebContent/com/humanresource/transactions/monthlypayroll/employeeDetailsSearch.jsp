<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath(); %>
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
.modern-ui input[type="text"] {
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

.modern-ui input[type="text"]:focus {
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
        document.getElementById("txtempprocessprint").value = document.getElementById("hidchckpayrollprocess").value;
    }); 

    function loadSearch() {
        var employeeName = document.getElementById("txtpartyname").value || "";
        var empId = document.getElementById("txtpartyid").value || "";
        var contactNo = document.getElementById("txtcontactno").value || "";
        var processPrint = document.getElementById("txtempprocessprint").value || "";
        
        var employeebranchchk = "";
        if(window.parent && window.parent.employeebranchchk) {
            employeebranchchk = window.parent.employeebranchchk.value; 
        }
        
        var branch = "";
        if(document.getElementById("brchName")){
            branch = document.getElementById("brchName").value;
        }
        
        getdata(employeeName, empId, contactNo, processPrint, employeebranchchk, branch);
    }
    
    function getdata(employeeName, empId, contactNo, processPrint, employeebranchchk, branch){
         $("#refreshdiv").load('employeeDetailsSearchGrid.jsp?employeename=' + encodeURIComponent(employeeName) + 
                               '&empid=' + encodeURIComponent(empId) + 
                               '&contactno=' + encodeURIComponent(contactNo) + 
                               '&processPrint=' + encodeURIComponent(processPrint) + 
                               '&branchid=' + encodeURIComponent(branch) + 
                               '&employeebranchchk=' + encodeURIComponent(employeebranchchk));
    }
</script>

</head>
<body style="background-color: #fff; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="lbl-right" width="10%">Name</td>
                <td width="30%">
                    <input type="text" name="txtpartyname" id="txtpartyname" value='<s:property value="txtpartyname"/>'>
                </td>
                
                <td width="10%"></td>
                <td width="30%"></td>
                
                <td width="20%" align="center" rowspan="2">
                    <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch();">
                </td>
            </tr>
            
            <tr>
                <td class="lbl-right">ID#</td>
                <td>
                    <input type="text" name="txtpartyid" id="txtpartyid" value='<s:property value="txtpartyid"/>'>
                </td>
                
                <td class="lbl-right">Contact No.</td>
                <td>
                    <input type="text" name="txtcontactno" id="txtcontactno" value='<s:property value="txtcontactno"/>'>
                    
                    <input type="hidden" name="txtatype" id="txtatype" value='<s:property value="txtatype"/>'>
                    <input type="hidden" name="txtempprocessprint" id="txtempprocessprint" value='<s:property value="txtempprocessprint"/>'>
                    <input type="hidden" id="hidchckpayrollprocess" value='<s:property value="hidchckpayrollprocess"/>'>
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