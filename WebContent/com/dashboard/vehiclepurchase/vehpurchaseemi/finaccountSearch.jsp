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

<script type="text/javascript">
	$(document).ready(function () {
		 //document.getElementById("txtdoctypes").value=document.getElementById("formdetailcode").value;
		// document.getElementById("txtsearchtype").value=document.getElementById("txtforsearch").value;
	}); 
	
	function loadAccountSearch() {
			var accountsno=document.getElementById("txtaccountsno1").value;
			var accountsname=document.getElementById("txtaccountsname1").value;
			//var currs=document.getElementById("txtaccountcurrency1").value;
		//	var formcode=document.getElementById("txtdoctypes").value;
		//	var searchtype=document.getElementById("txtsearchtype").value;
			var check = 1;
	
			getAccountDetails(accountsno,accountsname,check);
	}
		
	function getAccountDetails(accountsno,accountsname,check){
		 $("#findiv").load("finaccsubsearch.jsp?accountno="+accountsno+'&accountname='+accountsname+'&check='+check);
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
.modern-ui td.label {
    font-weight: 600;
    color: #444;
    text-align: right;
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
                <col width="12%">   <!-- Account No -->
                <col width="28%">

                <col width="12%">   <!-- Account Name -->
                <col width="28%">

                <col width="20%">   <!-- Button -->
            </colgroup>

            <tr>
                <td class="label">Account No</td>
                <td>
                    <input type="text" name="txtaccountsno1" id="txtaccountsno1"
                        value='<s:property value="txtaccountsno1"/>'>
                </td>

                <td class="label">Account Name</td>
                <td>
                    <input type="text" name="txtaccountsname1" id="txtaccountsname1"
                        value='<s:property value="txtaccountsname1"/>'>
                </td>

                <td>
                    <input type="button" name="btnAccountSearch1" id="btnAccountSearch1"
                        class="myButton"
                        value="Search"
                        onclick="loadAccountSearch();">
                </td>
            </tr>

        </table>
    </div>

    <!-- GRID -->
    <div class="grid-container">
        <jsp:include page="finaccsubsearch.jsp"></jsp:include>
    </div>

</div>

</body>
</html>