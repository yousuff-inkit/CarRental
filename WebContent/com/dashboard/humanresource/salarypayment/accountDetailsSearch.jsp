 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>



<script type="text/javascript">
	$(document).ready(function () {}); 

 	function loadSearch() {

 		var account=document.getElementById("txtaccountsno").value;
 		var accountname=document.getElementById("txtaccountsname").value;
 		
		getdata(account,accountname);
	}
	function getdata(account,accountname){
		 $("#refreshdiv").load('accountDetailsSearchGrid.jsp?accountname='+accountname.replace(/ /g, "%20")+'&account='+account+'&check=1');
		}

	</script>
<style type="text/css">

/* ===== MASTER UI STRICT ===== */

body {
    margin: 0;
    background-color: #f5f7fa;
}

/* FONT LOCK */
#search.modern-ui,
#search.modern-ui * {
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    font-size: 12px !important;
}

/* PANEL */
.modern-ui .search-panel {
    background: #fff;
    border: 1px solid #c5d3e0;
    border-radius: 8px;
    padding: 10px;
    margin-bottom: 10px;
}

/* GRID */
.modern-ui .grid-container {
    background: #fff;
    border: 1px solid #c5d3e0;
    border-radius: 8px;
    padding: 5px;
}

/* TABLE */
.modern-ui table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 4px 8px;
}

/* LABELS */
.modern-ui td.label {
    font-weight: 600;
    color: #444;
    text-align: right;
    white-space: nowrap;
}

/* INPUTS (STRICT 24px) */
.modern-ui input[type="text"] {
    height: 24px !important;
    padding: 2px 6px !important;
    border: 1px solid #b8c6d8;
    border-radius: 3px;
    box-sizing: border-box;
    width: 100%;
}

/* BUTTON */
.modern-ui .myButton {
    height: 24px !important;
    padding: 0 14px;
    font-weight: 700;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #fff;
    border: 1px solid #083a8a;
    border-radius: 3px;
    cursor: pointer;
    white-space: nowrap;
}

</style>

<body>

<div id="search" class="modern-ui">

    <!-- SEARCH PANEL -->
    <div class="search-panel">

        <table>
            <colgroup>
                <col width="10%">  <!-- Account -->
                <col width="35%">

                <col width="10%">  <!-- Name -->
                <col width="35%">

                <col width="10%">  <!-- Button -->
            </colgroup>

            <tr>
                <!-- Account -->
                <td class="label">Account</td>
                <td>
                    <input type="text" name="txtaccountsno" id="txtaccountsno"
                        value='<s:property value="txtaccountsno"/>'>
                </td>

                <!-- Name -->
                <td class="label">Name</td>
                <td>
                    <input type="text" name="txtaccountsname" id="txtaccountsname"
                        value='<s:property value="txtaccountsname"/>'>
                </td>

                <!-- Button -->
                <td>
                    <input type="button" name="btnsearch" id="btnsearch"
                        class="myButton"
                        value="Search"
                        onclick="loadSearch();">
                </td>
            </tr>

        </table>
    </div>

    <!-- GRID -->
    <div class="grid-container">
        <div id="refreshdiv">
            <jsp:include page="accountDetailsSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>