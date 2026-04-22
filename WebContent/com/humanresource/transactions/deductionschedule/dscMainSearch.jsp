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
    /* height: 100vh; REMOVED to fix the extra scrollbar */
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

#refreshdiv {
    border: 1px solid #cbd5e1;
    border-radius: 6px;
    background: #fff;
    min-height: 300px;
    overflow: hidden;
}
</style>

<script type="text/javascript">
$(document).ready(function () {
    /* STRICT 24px JQX Calendar */
    $("#dscdate").jqxDateTimeInput({ 
        width: '120px', 
        height: '24px',
        formatString:"dd.MM.yyyy",
        value:null
    });

    /* Fix internal padding of jqx widget to match 24px height */
    setTimeout(function () {
        $(".jqx-datetimeinput").css({"border-color": "#cbd5e1", "border-radius": "3px", "margin": "0"});
        $(".jqx-datetimeinput").find("input").css({
            "font-size": "12px", 
            "line-height": "24px",
            "margin-top": "0px",
            "font-family": "'Segoe UI', 'Roboto', 'Arial', sans-serif", 
            "padding-left": "8px",
            "box-sizing": "border-box"
        });
        $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
    }, 100);
}); 

function loadSearch() {
    var empname = document.getElementById("txtempname").value || "";
    var docNo = document.getElementById("txtdocno").value || "";
    var date = $("#dscdate").jqxDateTimeInput('val') || "";
    var amount = document.getElementById("txtamount1").value || "";
    
    var employeebranchchk = (window.parent && window.parent.employeebranchchk) ? window.parent.employeebranchchk.value.trim() : "0"; 
    var branchElem = document.getElementById("brchName");
    var branch = branchElem ? branchElem.value : ""; 
    
    getdata(empname, docNo, date, amount, employeebranchchk, branch);
}

function getdata(empname, docNo, date, amount, employeebranchchk, branch){
    $("#refreshdiv").load(
        'dscMainSearchGrid.jsp?empname=' + encodeURIComponent(empname) +
        '&docNo=' + encodeURIComponent(docNo) +
        '&date=' + encodeURIComponent(date) +
        '&amount=' + encodeURIComponent(amount) +
        '&branch=' + encodeURIComponent(branch) +
        '&employeebranchchk=' + encodeURIComponent(employeebranchchk) +
        '&id=1'
    );
}
</script>
</head>

<body>
<div id="search-wrapper">

    <div class="search-filter-box">
        <table class="search-table" border="0">
            <tr>
                <td class="lbl">Date</td>
                <td>
                    <div id="dscdate"></div>
                </td>

                <td class="lbl">Doc No</td>
                <td>
                    <input type="text" name="txtdocno" id="txtdocno" value="<s:property value='txtdocno'/>">
                </td>
                
                <td></td>
            </tr>

            <tr>
                <td class="lbl">Name</td>
                <td>
                    <input type="text" name="txtempname" id="txtempname" value="<s:property value='txtempname'/>">
                </td>

                <td class="lbl">Amount</td>
                <td>
                    <div class="input-row">
                        <input type="text" name="txtamount1" id="txtamount1" value="<s:property value='txtamount'/>">
                        <button type="button" class="btn-search" onclick="loadSearch();">SEARCH</button>
                    </div>
                </td>
            </tr>
        </table>
    </div>

    <div id="refreshdiv">
        <jsp:include page="dscMainSearchGrid.jsp"></jsp:include>
    </div>

</div>
</body>
</html>