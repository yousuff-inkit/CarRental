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

 		var partyname=document.getElementById("txtpartyname").value;
 		var accNo=document.getElementById("txtaccountno").value;
 		var check=1;
 		
		getdata(partyname,accNo,check);
	}
	function getdata(partyname,accNo,check){
		 $("#refreshdiv").load('accountsDetailsGrid.jsp?partyname='+partyname.replace(/ /g, "%20")+'&accNo='+accNo+'&check='+check);
		}

	</script>
<style type="text/css">

/* ================= MASTER UI (STRICT) ================= */

body {
    margin: 0;
    background-color: #f5f7fa;
}

/* GLOBAL FONT LOCK */
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
    padding: 5px;
    min-height: 200px;
}

/* TABLE */
.modern-ui table {
    border-collapse: separate;
    border-spacing: 6px 10px;
    width: 100%;
}

/* LABELS */
.modern-ui td[align="right"] {
    font-weight: 600 !important;
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
    box-sizing: border-box !important;
    background-color: #fff;
    width: 100%;
}

/* BUTTON (STRICT 24px) */
.modern-ui .myButton {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 16px !important;
    font-weight: 700 !important;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #fff;
    border: 1px solid #083a8a;
    border-radius: 3px;
    cursor: pointer;
    white-space: nowrap;
}

</style>
</head>

<body>

<div id="search" class="modern-ui">

    <!-- SEARCH PANEL -->
    <div class="search-panel">

        <table>
            <colgroup>
                <col width="8%">   <!-- Account label -->
                <col width="25%">  <!-- Account input -->

                <col width="8%">   <!-- Name label -->
                <col width="35%">  <!-- Name input -->

                <col width="10%">  <!-- Button -->
            </colgroup>

            <tr>
                <td align="right">Account</td>
                <td>
                    <input type="text" name="txtaccountno" id="txtaccountno"
                        value='<s:property value="txtaccountno"/>'>
                </td>

                <td align="right">Name</td>
                <td>
                    <input type="text" name="txtpartyname" id="txtpartyname"
                        value='<s:property value="txtpartyname"/>'>
                </td>

                <td align="left">
                    <input type="button" name="btnsearch" id="btnsearch"
                        class="myButton" value="Search"
                        onclick="loadSearch();">
                </td>
            </tr>

        </table>
    </div>

    <!-- GRID -->
    <div class="grid-container">
        <div id="refreshdiv">
            <jsp:include page="accountsDetailsGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>