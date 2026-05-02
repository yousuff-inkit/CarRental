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

 		var usersname=document.getElementById("txtusersname").value;
 		var usersrole=document.getElementById("txtusersrole").value;
 		var chk = 1;
 		
		getdata(usersname,usersrole,chk);
	}
 	
	function getdata(usersname,usersrole,chk){
		 $("#refreshdiv").load('userDetailsSearchGrid.jsp?usersname='+usersname.replace(/ /g, "%20")+'&usersrole='+usersrole.replace(/ /g, "%20")+'&chk='+chk);
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
    padding: 12px;
    margin-bottom: 12px;
}

/* GRID */
.modern-ui .grid-container {
    background: #fff;
    border: 1px solid #c5d3e0;
    border-radius: 8px;
    padding: 6px;
    min-height: 200px;
}

/* TABLE */
.modern-ui table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 6px 10px;
}

/* LABELS */
.modern-ui td[align="right"] {
    font-weight: 600;
    color: #444;
    white-space: nowrap;
}

/* INPUTS (STRICT 24px) */
.modern-ui input[type="text"] {
    height: 24px !important;
    line-height: 20px !important;
    padding: 2px 6px !important;
    border: 1px solid #b8c6d8;
    border-radius: 3px;
    box-sizing: border-box;
    width: 100%;
}

/* BUTTON */
.modern-ui .myButton {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 16px;
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
                <col width="8%">   <!-- User label -->
                <col width="32%">  <!-- User input -->

                <col width="8%">   <!-- Role label -->
                <col width="32%">  <!-- Role input -->

                <col width="20%">  <!-- Button -->
            </colgroup>

            <tr>
                <td align="right">User</td>
                <td>
                    <input type="text" name="txtusersname" id="txtusersname"
                        value='<s:property value="txtusersname"/>'>
                </td>

                <td align="right">Role</td>
                <td>
                    <input type="text" name="txtusersrole" id="txtusersrole"
                        value='<s:property value="txtusersrole"/>'>
                </td>

                <td align="left">
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
            <jsp:include page="userDetailsSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>