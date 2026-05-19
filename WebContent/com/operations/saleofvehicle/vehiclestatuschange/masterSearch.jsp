 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%> 
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

	<script type="text/javascript">
		$(document).ready(function () {
			$("#msearchdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
		});
	
 		function mainloadSearch() {
 		
 			var date=$('#msearchdate').jqxDateTimeInput('val');
 			var fleetno=document.getElementById("msearchfleetno").value;
 			var docno=document.getElementById("msearchdocno").value;
			var flname=document.getElementById("msearchflname").value;
 			var brhid=document.getElementById("brchName").value;
			$('#msearchdiv').load('masterSearchGrid.jsp?date='+date+'&fleetno='+fleetno+'&docno='+docno+'&flname='+flname+'&id=1&brhid='+brhid);
		}

	</script>
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

/* Panel Styling */
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

/* Labels */
.modern-ui .lbl-right {
    text-align: right;
    color: #222;
    font-size: 12px;
    font-weight: 600;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    white-space: nowrap;
    padding-right: 5px;
}

/* Search Button */
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

<body style="background-color: #fff; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">

        <table width="100%" border="0" cellspacing="0" cellpadding="0">

            <tr>

                <td class="lbl-right" width="10%">
                    Doc No
                </td>

                <td width="16%">
                    <input type="text"
                           name="msearchdocno"
                           id="msearchdocno">
                </td>

                <td class="lbl-right" width="7%">
                    Date
                </td>

                <td width="15%">
                    <div id="msearchdate"
                         name="msearchdate"></div>
                </td>

                <td class="lbl-right" width="10%">
                    Fleet No
                </td>

                <td width="16%">
                    <input type="text"
                           name="msearchfleetno"
                           id="msearchfleetno">
                </td>

                <td width="16%" align="center" rowspan="2" style="vertical-align: middle;">
                    <input type="button"
                           name="btnmastersearch"
                           id="btnmastersearch"
                           class="myButton"
                           value="Search"
                           onClick="mainloadSearch();">
                </td>

            </tr>

            <tr>

                <td class="lbl-right">
                    Fleet Name
                </td>

                <td colspan="5">
                    <input type="text"
                           name="msearchflname"
                           id="msearchflname"
                           style="width:98%;">
                </td>

            </tr>

        </table>

    </div>

    <div class="grid-container">

        <div id="msearchdiv">
            <jsp:include page="masterSearchGrid.jsp"></jsp:include>
        </div>

    </div>

</div>

</body>
</html>