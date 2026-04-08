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
        /* COMPACT DATE/TIME SIZING */
		$("#msearchdate").jqxDateTimeInput({ width: '120px', height: '24px', formatString:"dd.MM.yyyy", value:null});
		
        var initDate = $('#msearchdate').attr('value');
        if(initDate && initDate !== "") {
            $("#msearchdate").jqxDateTimeInput('val', initDate);
        }

        /* Force internal alignment AFTER render */
        setTimeout(function () {
            $(".jqx-datetimeinput").find("input").css({
                "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
                "font-family": "Arial, sans-serif", "padding": "0 6px", "box-sizing":"border-box"
            });
            $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
        }, 0);
	}); 

	function mainloadSearch() {
		if(document.getElementById("searchagmtno").value != ""){
			if(document.getElementById("cmbsearchrtype").value == ""){
			    if(document.getElementById("errormsg")) document.getElementById("errormsg").innerText="Agmt Type is Mandatory";
				return false;
			}
		}
		
		var client = document.getElementById("searchclient").value || "";
		var reftype = document.getElementById("cmbsearchrtype").value || "";
		var searchdate = $('#msearchdate').jqxDateTimeInput('val') || "";
		var agmtno = document.getElementById("searchagmtno").value || "";
		var fleetno = document.getElementById("searchfleetno").value || "";
		var docno = document.getElementById("searchdocno").value || "";
	
		getdata(client, reftype, searchdate, agmtno, fleetno, docno);
	}
	
    function getdata(client, reftype, searchdate, agmtno, fleetno, docno) {
         /* FIXED: Standard string concatenation. Encoded URIs can break older Struts mappings. */
		 $("#srefreshdiv").load('subMainSearch.jsp?client=' + client + 
                                '&reftype=' + reftype + 
                                '&searchdate=' + searchdate + 
                                '&agmtno=' + agmtno + 
                                '&fleetno=' + fleetno + 
                                '&docno=' + docno);
    }
</script>

</head>
<body style="background-color: #fff; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
            <tr>
                <td class="lbl-right" width="8%">Name</td>
                <td width="20%">
                    <input type="text" name="searchclient" id="searchclient" value='<s:property value="searchclient"/>'>
                </td>
                
                <td class="lbl-right" width="8%">Type</td>
                <td width="15%">
                    <select name="cmbsearchrtype" id="cmbsearchrtype">
                        <option value="">--Select--</option>
                        <option value="RAG">Rental</option>
                        <option value="LAG">Lease</option>
                    </select>
                </td>
                
                <td class="lbl-right" width="8%">Date</td>
                <td width="20%">
                    <div id="msearchdate" name="msearchdate" value='<s:property value="msearchdate"/>'></div>
                </td>
                
                <td width="21%" rowspan="2" align="center" valign="middle">
                    <input type="button" name="mbtnrasearch" id="mbtnrasearch" class="myButton" value="Search" onclick="mainloadSearch();">
                </td>
            </tr>

            <tr>
                <td class="lbl-right" style="padding-top: 10px;">Agmt No</td>
                <td style="padding-top: 10px;">
                    <input type="text" name="searchagmtno" id="searchagmtno" value='<s:property value="searchagmtno"/>'>
                </td>
                
                <td class="lbl-right" style="padding-top: 10px;">Fleet No</td>
                <td style="padding-top: 10px;">
                    <input type="text" name="searchfleetno" id="searchfleetno" value='<s:property value="searchfleetno"/>'>
                </td>
                
                <td class="lbl-right" style="padding-top: 10px;">Doc No</td>
                <td style="padding-top: 10px;">
                    <input type="text" id="searchdocno" name="searchdocno" value='<s:property value="searchdocno"/>'>
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="srefreshdiv">
            <jsp:include page="subMainSearch.jsp"/>
        </div>
    </div>

</div>

</body>
</html>