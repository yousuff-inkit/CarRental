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
        /* COMPACT DATE/TIME SIZING (120px width, 24px height) */
		$("#searchdate").jqxDateTimeInput({ width: '120px', height: '24px', formatString:"dd.MM.yyyy", value:null});
		
        /* Force internal alignment AFTER render */
        setTimeout(function () {
            $(".jqx-datetimeinput").find("input").css({
                "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
                "font-family": "Arial, sans-serif", "padding": "0 6px", "box-sizing":"border-box"
            });
            $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
        }, 0);
        
		getGroup();
		getColor();
	}); 

	function getGroup() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var groupItems = items[0].split(",");
				var groupIdItems = items[1].split(",");
			
				var optionsgroup = '<option value="">--Select--</option>';
				for (var i = 0; i < groupItems.length; i++) {
					optionsgroup += '<option value="' + groupIdItems[i] + '">' + groupItems[i] + '</option>';
				}
				$("select#searchgroup").html(optionsgroup);
			}
		}
		x.open("GET", "../../../../com/controlcentre/masters/vehiclemaster/getGroup.jsp", true);
		x.send();
	}
	
	function getColor() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var colorItems = items[0].split(",");
				var colorIdItems = items[1].split(",");
				
				var optionscolor = '<option value="">--Select--</option>';
				for (var i = 0; i < colorItems.length; i++) {
					optionscolor += '<option value="' + colorIdItems[i] + '">' + colorItems[i] + '</option>';
				}
				$("select#searchcolor").html(optionscolor);
			}
		}
		x.open("GET", "../../../../com/controlcentre/masters/vehiclemaster/getColor.jsp", true);
		x.send();
	}

	function mainloadSearch() {
		var searchdate = $('#searchdate').jqxDateTimeInput('val') || "";
		var fleetno = document.getElementById("searchfleetno").value || "";
		var docno = document.getElementById("searchdocno").value || "";
		var regno = document.getElementById("searchregno").value || "";
		var color = document.getElementById("searchcolor").value || "";
		var group = document.getElementById("searchgroup").value || "";
        
        // Safely pull from parent document elements if they exist
		var branchid = document.getElementById("brchName") ? document.getElementById("brchName").value : "";
		var agmttype = document.getElementById('cmbrentaltype') ? document.getElementById('cmbrentaltype').value : "";
   		var agmtno = document.getElementById('refno') ? document.getElementById('refno').value : "";

		getdata(searchdate, fleetno, docno, regno, color, group, branchid, agmttype, agmtno);
	}

	function getdata(searchdate, fleetno, docno, regno, color, group, branchid, agmttype, agmtno) {
        /* Safely encode URI components to prevent special character crashes */
        var targetUrl = 'outFleetSearch.jsp?agmttype=' + encodeURIComponent(agmttype) + 
                        '&agmtno=' + encodeURIComponent(agmtno) + 
                        '&searchdate=' + encodeURIComponent(searchdate) + 
                        '&fleetno=' + encodeURIComponent(fleetno) + 
                        '&docno=' + encodeURIComponent(docno) + 
                        '&regno=' + encodeURIComponent(regno) + 
                        '&color=' + encodeURIComponent(color) + 
                        '&group=' + encodeURIComponent(group) + 
                        '&branch=' + encodeURIComponent(branchid);
                        
		$("#srefreshdiv").load(targetUrl);
	}
</script>

</head>
<body style="background-color: #fff; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
            <tr>
                <td class="lbl-right" width="10%">Doc No</td>
                <td width="20%">
                    <input type="text" name="searchdocno" id="searchdocno">
                </td>
                
                <td class="lbl-right" width="10%">Date</td>
                <td width="20%">
                    <div id="searchdate" name="searchdate"></div>
                </td>
                
                <td class="lbl-right" width="10%">Color</td>
                <td width="20%">
                    <select name="searchcolor" id="searchcolor">
                        <option value="">--Select--</option>
                    </select>
                </td>
                
                <td width="10%"></td>
            </tr>

            <tr>
                <td class="lbl-right" style="padding-top: 10px;">Fleet No</td>
                <td style="padding-top: 10px;">
                    <input type="text" name="searchfleetno" id="searchfleetno">
                </td>
                
                <td class="lbl-right" style="padding-top: 10px;">Reg No</td>
                <td style="padding-top: 10px;">
                    <input type="text" name="searchregno" id="searchregno">
                </td>
                
                <td class="lbl-right" style="padding-top: 10px;">Group</td>
                <td style="padding-top: 10px;">
                    <select name="searchgroup" id="searchgroup">
                        <option value="">--Select--</option>
                    </select>
                </td>
                
                <td align="right" style="padding-top: 10px;">
                    <input type="button" name="btnSearchExt" id="btnSearchExt" class="myButton" value="Search" onClick="mainloadSearch();">
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="srefreshdiv">
            <jsp:include page="outFleetSearch.jsp" /> 
        </div>
    </div>

</div>

</body>
</html>