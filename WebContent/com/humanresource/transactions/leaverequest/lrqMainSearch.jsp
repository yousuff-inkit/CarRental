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
        /* Date left untouched at 15px height, exactly matching the DNO reference */
        $("#txtdate").jqxDateTimeInput({ width: '110px', height: '15px', formatString:"dd.MM.yyyy", value:null});
    }); 

    function loadSearch() {
        var docNo = document.getElementById("txtdocno").value || "";
        var dates = $('#txtdate').jqxDateTimeInput('val') || "";
        var check = 1;
        var employeebranchchk = "";
        
        if(window.parent && window.parent.employeebranchchk) {
            employeebranchchk = window.parent.employeebranchchk.value; 
        }
        var branch = "";
        if(document.getElementById("brchName")){
            branch = document.getElementById("brchName").value;
        }
        getdata(docNo, dates, check, employeebranchchk, branch);
    }
    
    function getdata(docNo, dates, check, employeebranchchk, branch) { 
        $("#refreshdiv").load('lrqMainSearchGrid.jsp?docNo=' + encodeURIComponent(docNo) + 
                              '&dates=' + encodeURIComponent(dates) + 
                              '&check=' + check + 
                              '&branch=' + encodeURIComponent(branch) + 
                              '&employeebranchchk=' + encodeURIComponent(employeebranchchk));
    }
</script>

</head>
<body style="background-color: #fff; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="lbl-right" width="10%">Doc No</td>
                <td width="20%">
                    <input type="text" name="txtdocno" id="txtdocno" autocomplete="off" value='<s:property value="txtdocno"/>'>
                </td>
                
                <td class="lbl-right" width="10%">Date</td>
                <td width="15%">
                    <div id="txtdate" name="txtdate" value='<s:property value="txtdate"/>'></div>
                    <input type="hidden" name="hidtxtdate" id="hidtxtdate" value='<s:property value="hidtxtdate"/>'>
                </td>
                
                <td class="lbl-right" width="10%"></td>
                <td width="20%"></td>
                
                <td width="15%" align="center">
                    <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch(); return false;">
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="refreshdiv">
            <jsp:include page="lrqMainSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>