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
		$("#fleetsearchdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy", value:null});
		
		getGroup();
		getColor();
        
        /* Force internal alignment AFTER render - Font Enforced */
        setTimeout(function () {
            $(".jqx-datetimeinput").find("input").css({
                "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
                "font-family": "'Segoe UI', 'Roboto', 'Arial', sans-serif", "padding": "0 6px", "box-sizing":"border-box"
            });
            $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
        }, 0);
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
                $("select#fleetsearchgroup").html(optionsgroup);
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
                $("select#fleetsearchcolor").html(optionscolor);
            }
        }
        x.open("GET", "../../../../com/controlcentre/masters/vehiclemaster/getColor.jsp", true);
        x.send();
    }

	function mainloadSearchfleet() {
		var searchdate = $('#fleetsearchdate').jqxDateTimeInput('val') || "";
		var fleetno = document.getElementById("fleetsearchfleetno").value || "";
		var docno = document.getElementById("fleetsearchdocno").value || "";
		var regno = document.getElementById("fleetsearchregno").value || "";
		var color = document.getElementById("fleetsearchcolor").value || "";
		var group = document.getElementById("fleetsearchgroup").value || "";
        
        /* Added safety check in case brchName doesn't exist on this popup */
        var branchElem = document.getElementById("brchName");
		var branch = branchElem ? branchElem.value : "";
        
		getdata(searchdate, fleetno, docno, regno, color, group, branch);
	}

    function getdata(searchdate, fleetno, docno, regno, color, group, branch){
        /* Used encodeURIComponent to safely handle spaces and special characters */
        $("#srefreshdiv").load('fleetSearch.jsp?searchdate=' + searchdate + 
                               '&fleetno=' + encodeURIComponent(fleetno) + 
                               '&docno=' + encodeURIComponent(docno) + 
                               '&regno=' + encodeURIComponent(regno) + 
                               '&color=' + encodeURIComponent(color) + 
                               '&group=' + encodeURIComponent(group) + 
                               '&branch=' + encodeURIComponent(branch));
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
                    <input type="text" name="fleetsearchdocno" id="fleetsearchdocno">
                </td>
                
                <td class="lbl-right" width="8%">Date</td>
                <td width="20%">
                    <div id="fleetsearchdate" name="fleetsearchdate"></div>
                </td>
                
                <td class="lbl-right" width="8%">Color</td>
                <td width="20%">
                    <select name="fleetsearchcolor" id="fleetsearchcolor">
                        <option value="">--Select--</option>
                    </select>
                </td>
                
                <td width="16%"></td> </tr>

            <tr>
                <td class="lbl-right" style="padding-top: 8px;">Fleet No</td>
                <td style="padding-top: 8px;">
                    <input type="text" name="fleetsearchfleetno" id="fleetsearchfleetno">
                </td>
                
                <td class="lbl-right" style="padding-top: 8px;">Reg No</td>
                <td style="padding-top: 8px;">
                    <input type="text" name="fleetsearchregno" id="fleetsearchregno">
                </td>
                
                <td class="lbl-right" style="padding-top: 8px;">Group</td>
                <td style="padding-top: 8px;">
                    <select name="fleetsearchgroup" id="fleetsearchgroup">
                        <option value="">--Select--</option>
                    </select>
                </td>
                
                <td align="right" valign="middle" style="padding-top: 8px;">
                    <input type="button" name="btnSearchExtfleet" id="btnSearchExtfleet" class="myButton" value="Search" onClick="mainloadSearchfleet(); return false;">
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="srefreshdiv">
            <jsp:include page="fleetSearch.jsp" /> 
        </div>
    </div>

</div>

</body>
</html>