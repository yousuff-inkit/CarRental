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
    /* Global Font Enforced */
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
		$("#bookdates").jqxDateTimeInput({ width: '120px', height: '24px', formatString:"dd.MM.yyyy", value:null});
		
        var initDate = $('#bookdates').attr('value');
        if(initDate && initDate !== "") {
            $("#bookdates").jqxDateTimeInput('val', initDate);
        }

        /* Force internal alignment AFTER render - Font Enforced */
        setTimeout(function () {
            $(".jqx-datetimeinput").find("input").css({
                "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
                "font-family": "'Segoe UI', 'Roboto', 'Arial', sans-serif", "padding": "0 6px", "box-sizing":"border-box"
            });
            $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
        }, 0);
	}); 

	function bookloadSearch() {
		var qutdocno1 = document.getElementById("qutdocno").value || "";
		var clientnamess = document.getElementById("clientnames").value || "";
		var clmob1 = document.getElementById("clmob").value || "";
		var qutdate1 = $('#bookdates').jqxDateTimeInput('val') || "";
		var quttype1 = document.getElementById("quttype").value || ""; 
		var regno = document.getElementById("regno").value || ""; 
		
		getdata1(qutdocno1, clientnamess, clmob1, qutdate1, quttype1, regno);
	}
	
	function getdata1(qutdocno1, clientnames, clmob1, qutdate1, quttype1, regno){
        /* Used encodeURIComponent to safely handle spaces and special characters */
		$("#qutrediv").load('bookingsubsearch.jsp?qutdocno=' + encodeURIComponent(qutdocno1) + 
                            '&clientname=' + encodeURIComponent(clientnames) + 
                            '&clmob=' + encodeURIComponent(clmob1) + 
                            '&qutdate=' + qutdate1 + 
                            '&quttype=' + encodeURIComponent(quttype1) + 
                            '&regno=' + encodeURIComponent(regno));
	}
</script>

</head>
<body style="background-color: #fff; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
            <tr>
                <td class="lbl-right" width="8%">Doc No</td>
                <td width="15%">
                    <input type="text" name="qutdocno" id="qutdocno" value='<s:property value="qutdocno"/>'>
                </td>
                
                <td class="lbl-right" width="8%">Name</td>
                <td width="30%">
                    <input type="text" name="clientnames" id="clientnames" value='<s:property value="clientnames"/>'>
                </td>
                
                <td class="lbl-right" width="8%">MOB</td>
                <td width="20%">
                    <input type="text" name="clmob" id="clmob" value='<s:property value="clmob"/>'>
                </td>
            </tr>

            <tr>
                <td class="lbl-right" style="padding-top: 8px;">Date</td>
                <td style="padding-top: 8px;">
                    <div id="bookdates" name="bookdates" value='<s:property value="bookdates"/>'></div>
                </td>
                
                <td class="lbl-right" style="padding-top: 8px;">Ref Type</td>
                <td style="padding-top: 8px; display: flex; gap: 10px; align-items: center; border: none;">
                    <select name="quttype" id="quttype" value='<s:property value="quttype"/>' style="width: 120px;">
                        <option value="">--Select--</option>
                        <option value="DIR">Direct</option>
                        <option value="QOT">Quotation</option>
                        <option value="ONL">Online</option>
                    </select>
                    <span class="lbl-right" style="padding-right: 0; min-width: 50px;">Reg No</span>
                    <input type="text" name="regno" id="regno" value='<s:property value="regno"/>' style="width: 120px;">
                </td>
                
                <td align="right" valign="middle" style="padding-top: 8px;" colspan="2">
                    <input type="button" name="qutbtnrasearch" id="qutbtnrasearch" class="myButton" value="Search" onclick="bookloadSearch(); return false;">
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="qutrediv">
            <jsp:include page="bookingsubsearch.jsp"></jsp:include> 
        </div>
    </div>

</div>

</body>
</html>