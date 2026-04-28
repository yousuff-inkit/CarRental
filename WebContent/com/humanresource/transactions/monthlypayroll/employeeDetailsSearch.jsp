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

.jqx-grid-header {
    background: linear-gradient(180deg, #e9ecef 0%, #dee2e6 100%) !important;
    border-color: #ced4da !important;
    color: #212529 !important;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

.jqx-grid-column-header {
    background: transparent !important;
    color: #212529 !important;
    font-weight: 700 !important;
    font-size: 11px !important;
    text-align: left !important;
    border-color: #ced4da !important;
}

.jqx-grid-column-header a:link,
.jqx-grid-column-header a:visited {
    color: #212529 !important;
    text-align: left !important;
}

.jqx-grid-column-header > div > div {
    text-align: left !important;
    padding-left: 6px !important;
}


.jqx-grid-cell {
    background: #ffffff;
    border-color: #dee2e6 !important; 
    border-width: 0px 0px 1px 0px !important;
    color: #1f2937;
    font-size: 11px !important;
    text-align: left !important;
}

.jqx-grid-cell-left-align {
    text-align: left !important;
    padding-left: 6px !important;
    margin-left: 0px !important;
}

.jqx-grid-cell-middle-align {
    text-align: left !important;
    padding-left: 6px !important;
}

.jqx-grid-cell-right-align {
    text-align: right !important;
    padding-right: 6px !important;
}


.jqx-grid-cell-alt {
    background: #f1f3f5 !important; 
}


.jqx-grid-cell-hover {
    background: #dee2e6 !important; 
    border-color: #ced4da !important;
    color: #000000 !important;
}

.jqx-grid-cell-selected {
    background: #adb5bd !important; 
    color: #ffffff !important;
    border-color: #868e96 !important;
}

.jqx-grid-table .jqx-grid-cell {
    border-width: 0px 0px 1px 0px !important;
    border-color: #dee2e6 !important;
}


.jqx-grid {
    border: 1px solid #adb5bd !important; 
    border-radius: 8px !important;
    overflow: hidden !important;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1) !important;
}


.jqx-grid-cell-sort {
    background-color: #e9ecef !important;
}
.jqx-grid-cell-sort-alt {
    background-color: #dee2e6 !important;
}

.jqx-grid-cell-filter,
.jqx-grid-cell-filter-alt {
    background-color: #f1f3f5 !important;
}

.jqx-grid-cell-pinned,
.jqx-grid-cell-pinned-alt {
    background-color: #e9ecef !important;
}


.jqx-grid-pager {
    background: #e9ecef !important; 
    border-top: 1px solid #ced4da !important;
    padding: 4px !important;
}

.jqx-grid-column-menubutton {
    opacity: 0.5;
    transition: opacity 0.2s;
}
.jqx-grid-column-menubutton:hover {
    opacity: 1;
}


.jqx-scrollbar-state-normal {
    background: #f1f3f5 !important;
}
.jqx-scrollbar-thumb-state-normal,
.jqx-scrollbar-thumb-state-normal-horizontal {
    background: #868e96 !important; 
    border-color: #868e96 !important;
    border-radius: 4px !important;
}
.jqx-scrollbar-thumb-state-hover,
.jqx-scrollbar-thumb-state-hover-horizontal {
    background: #495057 !important; 
    border-radius: 4px !important;
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