<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>GatewayERP(i)</title>

<link href="<%=contextPath%>/css/body.css" rel="stylesheet" />

<style>

/* --- SEARCH BOX CARD --- */
#search {
    background: #ffffff;
    border: 1px solid #d7e3ff;
    border-radius: 14px;
    padding: 18px 22px;
    box-shadow: 0 6px 20px rgba(80,120,255,0.20);
    font-family: "Poppins", sans-serif;
    width: 100%;
}

/* Labels */
#search table td {
    font-size: 13px;
    font-weight: 600;
    color: #2f3f86;
}

/* Textboxes */
#search input[type="text"] {
    width: 95%;
    height: 34px;
    font-size: 13px;
    padding: 6px 10px;
    border: 1px solid #c4d3ff !important;
    border-radius: 10px !important;
    background: #ffffff !important;
    color: #001a4d !important;
    box-shadow: 0 2px 6px rgba(140,160,250,0.18);
}

/* Focus glow */
#search input:focus {
    outline: none;
    border-color: #5a8aff !important;
    box-shadow: 0 0 6px rgba(80,120,255,0.35);
}

/* Search Button */
.myButton {
    background: linear-gradient(90deg,#6fb1fc,#1a73e8);
    border: none;
    color: white;
    padding: 9px 22px;
    font-size: 14px;
    font-weight: 600;
    border-radius: 10px;
    cursor: pointer;
    box-shadow: 0 4px 12px rgba(26,115,232,0.35);
}
.myButton:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 18px rgba(26,115,232,0.45);
}

</style>

<script type="text/javascript">
$(document).ready(function () {
    var atype = '<%=atype%>';
    document.getElementById("txttypes").value = atype;
}); 

function loadAccountSearch() {
    var accountsno = document.getElementById("txtaccountsno").value;
    var accountsname = document.getElementById("txtaccountsname").value;
    var atype = document.getElementById("txttypes").value;
    var check = 1;

    getAccountDetails(accountsno, accountsname, atype, check);
}

function getAccountDetails(accountsno, accountsname, atype, check){
    $("#refreshAccountDetailsDiv").load(
        "accountDetailsSearchGrid.jsp?accountno=" + accountsno +
        "&accountname=" + accountsname.replace(/ /g, "%20") +
        "&atype=" + atype +
        "&check=" + check
    );
}
</script>

</head>

<body>

<div id="search">
<table width="100%" cellspacing="12">

<tr>
    <td width="15%" align="right">Account No.</td>
    <td width="60%">
        <input type="text" id="txtaccountsno" name="txtaccountsno"
               style="width:65%;" value='<s:property value="txtaccountsno"/>'>
        <input type="hidden" id="txttypes" name="txttypes"
               value='<s:property value="txttypes"/>'>
    </td>
    <td width="25%" align="center">
        <button class="myButton" onclick="loadAccountSearch()">Search</button>
    </td>
</tr>

<tr>
    <td align="right">Account Name</td>
    <td colspan="2">
        <input type="text" id="txtaccountsname" name="txtaccountsname"
               style="width:75%;" value='<s:property value="txtaccountsname"/>'>
    </td>
</tr>

<tr>
    <td colspan="3">
        <div id="refreshAccountDetailsDiv">
            <jsp:include page="accountDetailsSearchGrid.jsp"></jsp:include>
        </div>
    </td>
</tr>

</table>
</div>

</body>
</html>
