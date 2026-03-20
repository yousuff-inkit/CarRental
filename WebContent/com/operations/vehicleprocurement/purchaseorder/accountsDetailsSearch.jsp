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
	
	
	function loadAccountSearch() {
		var masterdate=document.getElementById("vehpurorderDate").value;
		

			var accountsno=document.getElementById("txtaccountsno").value;
			var accountsname=document.getElementById("txtaccountsname").value;
			var currs=document.getElementById("txtaccountcurrency").value;
		
			var check = 1;
	
			getAccountDetails(accountsno,accountsname,currs,check,masterdate);
	}
		
	function getAccountDetails(accountsno,accountsname,currs,check,masterdate){

		 $("#refreshAccountDetailsDiv").load("accountsDetailsFromGrid.jsp?accountno="+accountsno+'&accountname='+accountsname.replace(/ /g, "%20")+'&currency='+currs+'&check='+check+'&masterdate='+masterdate);
	}
	$(document).ready(function () {
	    $(".popup-body").scrollTop(0);
	});
</script>
<style type="text/css">
/* Container */
#searchContainer {
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    font-family: Tahoma, Geneva, sans-serif;
}

/* Header (FIXED LIKE OTHER PAGE) */
.popup-header {
    background: #f1f1f1;
    padding: 10px 15px;
    font-size: 16px;
    font-weight: bold;
    border-bottom: 1px solid #ccc;
}

/* Body scroll */
.popup-body {
    padding: 10px;
    max-height: 500px;
    overflow-y: auto;
}

/* Table spacing (FIXED ISSUE) */
table {
    border-collapse: separate;
    border-spacing: 10px 10px;
}

/* Labels */
td[align="right"] {
    font-size: 14px;
    font-weight: bold;
    color: #222;
}

/* Inputs */
input[type="text"] {
    width: 100%;
    padding: 7px 10px;
    font-size: 14px;
    font-weight: 600;
    border: 1px solid #bdc3c7;
    border-radius: 4px;
}

/* Focus */
input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
}

/* Button */
.myButton {
    font-weight: bold;
    font-size: 14px;
    background-color: #007bff;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

/* Grid */
.grid-container {
    margin-top: 10px;
    border: 1px solid #ccc;
}
.popup-body {
    padding: 0px 15px 15px 15px;  /* remove top padding */
    margin-top: 0;
}
table {
    border-spacing: 10px 0px;  /* removes top white line completely */
}
table tr:first-child td {
    padding-top: 0;
}
.ui-dialog-content {
    padding-top: 0 !important;
}
#search td[align="right"]{
    font-weight:700;
    font-size:14px;
    color:#222;
}
td[align="right"] {
  font-family: Tahoma, Geneva, sans-serif;
  font-size: 14px;
  font-weight: 700;   /* stronger bold */
  color: #000;        /* darker */
}
</style>
<body bgcolor="#FFFFFF">

<div id="searchContainer">

    

    <!-- Content -->
    <div class="popup-body">

        <table width="100%">
            <tr>
                <td width="15%" align="right">Account No</td>
                <td width="35%">
                    <input type="text" name="txtaccountsno" id="txtaccountsno" value='<s:property value="txtaccountsno"/>'>
                </td>

                <td width="15%" align="right">Currency</td>
                <td width="20%">
                    <input type="text" name="txtaccountcurrency" id="txtaccountcurrency" value='<s:property value="txtaccountcurrency"/>'>
                    <input type="hidden" name="txtsearchtype" id="txtsearchtype" value='<s:property value="txtsearchtype"/>'>
                </td>

                <td width="15%" rowspan="2" align="center">
                    <input type="button" name="btnAccountSearch" id="btnAccountSearch"
                        class="myButton" value="Search" onclick="loadAccountSearch();">
                </td>
            </tr>

            <tr>
                <td align="right">Account Name</td>
                <td colspan="3">
                    <input type="text" name="txtaccountsname" id="txtaccountsname" style="width:95%;" value='<s:property value="txtaccountsname"/>'>
                </td>
            </tr>

            <tr>
                <td colspan="5">
                    <div id="refreshAccountDetailsDiv" class="grid-container">
                        <jsp:include page="accountsDetailsFromGrid.jsp" />
                    </div>
                </td>
            </tr>
        </table>

    </div>
</div>

</body>

</html>