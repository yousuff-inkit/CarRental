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
   SCOPED UI: Segoe UI Font & Clean White Search Panel
========================================================= */
body {
    margin: 0;
    background-color: #fff; 
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif; 
}

.modern-ui {
    font-size: 12px;
    color: #333;
    padding: 10px;
    box-sizing: border-box;
    width: 100%;
}

/* Master Input Styles - LOCKED TO 24px */
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

/* Search Button - LOCKED TO 24px to match inputs */
.modern-ui .myButton {
    height: 24px !important;
    line-height: 22px !important;
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
	    /* LOCKED TO 24px */
	    $("#txtdob").jqxDateTimeInput({ width: '120px', height: '24px', formatString:"dd.MM.yyyy", value:null, theme: 'energyblue'});
	    
        /* Force internal alignment AFTER render - LOCKED TO 24px */
        setTimeout(function () {
            $("#txtdob").find("input").css({
                "margin-top": "0px", 
                "line-height": "24px", 
                "font-size": "12px", 
                "font-family": "Arial, sans-serif",
                "padding": "0 6px", 
                "box-sizing":"border-box"
            });
            $("#txtdob").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
        }, 0);
	}); 

	function loadSearch() {
		var clientid = document.getElementById("txtclientid").value || "";
		var clname = document.getElementById("txtclientname").value || "";
		var clientaccount = document.getElementById("txtclientsaccount").value || "";
		var mob = document.getElementById("txtmobile").value || "";
		var lcno = document.getElementById("txtlicence").value || "";
		var driverid = document.getElementById("txtdriveridsearch").value || "";
		var nation = document.getElementById("txtnation").value || "";
		var dob = $('#txtdob').jqxDateTimeInput('val') || "";
		var check = 1;
		
		getdata(clname, mob, lcno, clientid, driverid, nation, dob, clientaccount, check);
	}
	
	function getdata(clname, mob, lcno, clientid, driverid, nation, dob, clientaccount, check){	
		 $("#refreshdiv").load('crmMainSearchGrid.jsp?clname=' + encodeURIComponent(clname) + 
                                                '&mob=' + encodeURIComponent(mob) + 
                                                '&lcno=' + encodeURIComponent(lcno) + 
                                                '&clientid=' + encodeURIComponent(clientid) + 
                                                '&driverid=' + encodeURIComponent(driverid) + 
                                                '&nation=' + encodeURIComponent(nation) + 
                                                '&dob=' + dob + 
                                                '&clientaccount=' + encodeURIComponent(clientaccount) + 
                                                '&check=' + check);
	}
</script>
</head>

<body style="background-color: #fff; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="lbl-right" width="8%">Client#</td>
                <td width="15%">
                    <input type="text" name="txtclientid" id="txtclientid" value='<s:property value="txtclientid"/>'>
                </td>
                
                <td class="lbl-right" width="8%">Name</td>
                <td width="25%">
                    <input type="text" name="txtclientname" id="txtclientname" value='<s:property value="txtclientname"/>'>
                </td>
                
                <td class="lbl-right" width="8%">Account</td>
                <td width="20%">
                    <input type="text" name="txtclientsaccount" id="txtclientsaccount" value='<s:property value="txtclientsaccount"/>'>
                </td>
                
                <td width="16%" align="center" rowspan="3" style="vertical-align: middle;">
                    <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch(); return false;">
                </td>
            </tr>
            
            <tr>
                <td class="lbl-right">Licence#</td>
                <td>
                    <input type="text" name="txtlicence" id="txtlicence" value='<s:property value="txtlicence"/>'>
                </td>
                
                <td class="lbl-right">Mob</td>
                <td>
                    <input type="text" name="txtmobile" id="txtmobile" value='<s:property value="txtmobile"/>'>
                </td>
                
                <td class="lbl-right">DOB</td>
                <td>
                    <div id="txtdob" name="txtdob" value='<s:property value="txtdob"/>'></div>
                    <input type="hidden" name="hidtxtdob" id="hidtxtdob" value='<s:property value="hidtxtdob"/>'>
                </td>
            </tr>
            
            <tr>
                <td class="lbl-right">ID#</td>
                <td>
                    <input type="text" name="txtdriveridsearch" id="txtdriveridsearch" value='<s:property value="txtdriveridsearch"/>'>
                </td>
                
                <td class="lbl-right">Nationality</td>
                <td>
                    <input type="text" id="txtnation" name="txtnation" value='<s:property value="txtnation"/>'>
                </td>
                
                <td colspan="2"></td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="refreshdiv">
            <jsp:include page="crmMainSearchGrid.jsp" />
        </div>
    </div>

</div>

</body>
</html>