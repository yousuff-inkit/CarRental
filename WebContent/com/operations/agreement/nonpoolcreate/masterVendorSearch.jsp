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
   SCOPED UI: Compact Search Modal Layout (Pure White & Segoe UI)
========================================================= */
body {
    margin: 0;
    background-color: #fff;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
}

.modern-ui {
    font-size: 12px;
    color: #333;
    padding: 10px;
    box-sizing: border-box;
    width: 100%;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
}

/* Master Input Heights - Forced to 24px and Font Enforced */
.modern-ui input[type="text"],
.modern-ui select {
    height: 24px !important;
    border: 1px solid #b8c6d8;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 12px;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
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

/* Panel Styling - Pure White */
.modern-ui .search-panel {
    background-color: #fff !important; 
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
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Modern Search Button - Font Enforced */
.modern-ui .myButton {
    height: 24px !important; 
    line-height: 22px !important;
    padding: 0 20px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #fff !important;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 12px;
    font-weight: bold;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
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
        /* COMPACT DATE/TIME SIZING */
		$("#vndsearchdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy", value:null});
		
        /* Force internal alignment AFTER render - Font Enforced */
        setTimeout(function () {
            $(".jqx-datetimeinput").find("input").css({
                "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
                "font-family": "'Segoe UI', 'Roboto', 'Arial', sans-serif", "padding": "0 6px", "box-sizing":"border-box"
            });
            $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
        }, 0);
	}); 

	function mainloadSearchvnd() {
		var searchdate = $('#vndsearchdate').jqxDateTimeInput('val') || "";
		var docno = document.getElementById("vndsearchdocno").value || "";
		var name = document.getElementById("vndsearchname").value || "";
		var acno = document.getElementById("vndsearchacno").value || "";
		var mobile = document.getElementById("vndsearchmobile").value || "";
		
		getdata(searchdate, docno, name, acno, mobile);
	}

	function getdata(searchdate, docno, name, acno, mobile){
        /* Used encodeURIComponent to safely handle spaces and special characters */
		$("#srefreshdivvendor").load('vendorSearch.jsp?searchdate=' + searchdate + 
                                     '&docno=' + encodeURIComponent(docno) + 
                                     '&name=' + encodeURIComponent(name) + 
                                     '&acno=' + encodeURIComponent(acno) + 
                                     '&mobile=' + encodeURIComponent(mobile) + 
                                     '&id=1');
	}
</script>

</head>
<body style="background-color: #fff; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
            <tr>
                <td class="lbl-right" width="8%">Doc No</td>
                <td width="20%">
                    <input type="text" name="vndsearchdocno" id="vndsearchdocno">
                </td>
                
                <td class="lbl-right" width="8%">Date</td>
                <td width="20%">
                    <div id="vndsearchdate" name="vndsearchdate"></div>
                </td>
                
                <td class="lbl-right" width="8%">Mobile</td>
                <td width="20%">
                    <input type="text" name="vndsearchmobile" id="vndsearchmobile">
                </td>
                
                <td width="16%"></td> </tr>

            <tr>
                <td class="lbl-right" style="padding-top: 8px;">Name</td>
                <td colspan="3" style="padding-top: 8px;">
                    <input type="text" name="vndsearchname" id="vndsearchname" style="width:100%;">
                </td>
                
                <td class="lbl-right" style="padding-top: 8px;">A/c No</td>
                <td style="padding-top: 8px;">
                    <input type="text" name="vndsearchacno" id="vndsearchacno">
                </td>
                
                <td align="right" valign="middle" style="padding-top: 8px;">
                    <input type="button" name="btnSearchvnd" id="btnSearchvnd" class="myButton" value="Search" onClick="mainloadSearchvnd(); return false;">
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="srefreshdivvendor">
            <jsp:include page="vendorSearch.jsp" /> 
        </div>
    </div>

</div>

</body>
</html>