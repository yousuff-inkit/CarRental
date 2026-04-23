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
   EXACT MATCH FOR SCREENSHOT (STRICT 24PX HEIGHT)
========================================================= */

body {
    background-color: #f8fafc; 
    margin: 0;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

#search-wrapper {
    background: #ffffff;
    padding: 15px;
    box-sizing: border-box;
}

/* The bordered box surrounding the search inputs */
.search-filter-box {
    border: 1px solid #cbd5e1;
    border-radius: 6px;
    padding: 15px 20px;
    background-color: #ffffff;
    margin-bottom: 15px;
}

.search-table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 15px 12px; 
}

.search-table td.lbl {
    font-size: 12px;
    font-weight: 700;
    color: #334155;
    text-align: right;
    white-space: nowrap;
    width: 1%; 
}

/* STRICT 24px Input styling */
.search-table input[type="text"] {
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    font-weight: 500;
    font-size: 12px;
    padding: 2px 8px;
    width: 100%;
    min-width: 140px;
    height: 24px !important;
    box-sizing: border-box;
    border: 1px solid #cbd5e1;
    border-radius: 3px;
    color: #333;
}

.search-table input[type="text"]:focus {
    border-color: #2563eb;
    outline: none;
}

/* STRICT 24px SEARCH button */
.btn-search {
    background-color: #1d4ed8; 
    color: #ffffff !important;
    border: none;
    border-radius: 3px;
    height: 24px !important;
    line-height: 22px;
    padding: 0 16px;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    font-weight: 700;
    font-size: 11px;
    cursor: pointer;
    margin-left: 10px;
    text-transform: uppercase;
}

.btn-search:hover {
    background-color: #1e40af;
}

.input-row {
    display: flex;
    align-items: center;
}

#srefreshdiv {
    border: 1px solid #cbd5e1;
    border-radius: 6px;
    background: #fff;
    min-height: 300px;
    overflow: hidden;
}
</style>

<script type="text/javascript">
    $(document).ready(function () {}); 

    function mainloadSearch() {
        var empnames = document.getElementById("empnames").value || "";
        var empids = document.getElementById("empids").value || "";
        var docnoss = document.getElementById("docnoss").value || "";
        var mobnos = document.getElementById("mobnos").value || "";    
        
        var employeebranchchk = (window.parent && window.parent.employeebranchchk) ? window.parent.employeebranchchk.value : "0"; 
        var branchElem = document.getElementById("brchName");
        var branch = branchElem ? branchElem.value : "";  
        
        getdata(empnames, empids, docnoss, mobnos, employeebranchchk, branch);
    }
    
    function getdata(empnames, empids, docnoss, mobnos, employeebranchchk, branch){
        $("#srefreshdiv").load(
            'submainSearch.jsp?empns=' + encodeURIComponent(empnames) +
            '&empids=' + encodeURIComponent(empids) +
            '&docnoss=' + encodeURIComponent(docnoss) +
            '&mobnos=' + encodeURIComponent(mobnos) +
            '&branch=' + encodeURIComponent(branch) +
            '&employeebranchchk=' + encodeURIComponent(employeebranchchk)
        );
    }
</script>
</head>

<body>
<div id="search-wrapper">

    <div class="search-filter-box">
        <table class="search-table" border="0">
            <tr>
                <td class="lbl">Name</td>
                <td colspan="3">
                    <input type="text" name="empnames" id="empnames" value='<s:property value="empnames"/>'>
                </td>
                <td></td>
            </tr>

            <tr>
                <td class="lbl">Emp ID</td>
                <td>
                    <input type="text" name="empids" id="empids" value='<s:property value="empids"/>'>
                </td>
                
                <td class="lbl">Doc No</td>
                <td>
                    <input type="text" name="docnoss" id="docnoss" value='<s:property value="docnoss"/>'>
                </td>
            </tr>

            <tr>
                <td class="lbl">Mobile</td>
                <td>
                    <input type="text" name="mobnos" id="mobnos" value='<s:property value="mobnos"/>'>
                </td>
                
                <td colspan="2" style="text-align: right;">
                    <button type="button" name="mbtnrasearch" id="mbtnrasearch" class="btn-search" onclick="mainloadSearch();">SEARCH</button>
                </td>
            </tr>
        </table>
    </div>

    <div id="srefreshdiv">
        <jsp:include page="submainSearch.jsp"></jsp:include>
    </div>

</div>
</body>
</html>