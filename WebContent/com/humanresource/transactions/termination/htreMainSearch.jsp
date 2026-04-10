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
SCOPED UI: Compact Search Modal Layout
========================================================= */
body {
    margin: 0;
    background-color: #fff;
    font-family: Arial, sans-serif;
}

.modern-ui {
    font-size: 12px;
    color: #333;
    padding: 10px;
    box-sizing: border-box;
    width: 100%;
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui select {
    height: 24px !important;
    border: 1px solid #b8c6d8;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 12px;
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
    background-color: #f4f7fb;
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    padding: 15px;
    margin-bottom: 10px;
}

.modern-ui table {
    border-collapse: collapse;
    width: 100%;
}

.modern-ui td {
    padding: 4px 5px;
    vertical-align: middle;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Modern Search Button */
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
    box-shadow: 0 1px 2px rgba(59, 130, 246, 0.3);
    transition: all 0.2s;
    text-transform: uppercase;
}

.modern-ui .myButton:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%);
    transform: translateY(-1px);
}

/* Data Grid Container */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}
</style>

<script type="text/javascript">
	$(document).ready(function () {
        /* Force width to 100% so it perfectly fits the table cell */
		$("#terminatedDate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy", value:null});
		
		/* Force internal alignment AFTER render */
        setTimeout(function () {
            $(".jqx-datetimeinput").find("input").css({
                "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
                "font-family": "Arial, sans-serif", "padding": "0 6px", "box-sizing":"border-box"
            });
            $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
        }, 0);
	}); 

	function loadSearch() {
		var empname = document.getElementById("txtempname").value || "";
		var docNo = document.getElementById("txtdocno").value || "";
		var date = $('#terminatedDate').jqxDateTimeInput('val') || "";
		var amount = document.getElementById("txtamount").value || "";
		
		getdata(empname, docNo, date, amount);
	}
	
	function getdata(empname, docNo, date, amount){
        /* Used encodeURIComponent to safely handle spaces and special characters in the employee name */
		$("#refreshdiv").load('htreMainSearchGrid.jsp?empname=' + encodeURIComponent(empname) + 
                              '&docNo=' + docNo + 
                              '&date=' + date + 
                              '&amount=' + amount);
	}
</script>

</head>
<body style="background-color: #fff; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
            <tr>
                <td class="lbl-right" width="10%">Date</td>
                <td width="30%">
                    <div id="terminatedDate" name="terminatedDate"></div>
                </td>

                <td class="lbl-right" width="10%">Doc No</td>
                <td width="30%">
                    <input type="text" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'>
                </td>

                <td width="20%" rowspan="2" align="center" valign="middle">
                    <input type="button" id="btnsearch" class="myButton" value="Search" onclick="loadSearch(); return false;">
                </td>
            </tr>

            <tr>
                <td class="lbl-right" style="padding-top: 10px;">Name</td>
                <td style="padding-top: 10px;">
                    <input type="text" id="txtempname" name="txtempname" value='<s:property value="txtempname"/>'>
                </td>

                <td class="lbl-right" style="padding-top: 10px;">Amount</td>
                <td style="padding-top: 10px;">
                    <input type="text" id="txtamount" name="txtamount" value='<s:property value="txtamount"/>'>
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="refreshdiv">
            <jsp:include page="htreMainSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>