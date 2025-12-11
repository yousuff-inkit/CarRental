<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<style>
/* popup container */
#search {
    width: 900px;
    margin: 0 auto;
    background: #f6f8fa;
    border-radius: 10px;
    box-shadow: 0 8px 30px rgba(15,23,42,0.25);
    font-family: 'Segoe UI','Roboto','Arial',sans-serif;
    font-size: 13px;
    color: #222;
}

/* inner body only – no extra header strip */
#search-body {
    padding: 8px 14px 10px 14px;
}

/* filters table */
#search table.cr-search-table {
    width: 100%;
    border-collapse: collapse;
    background: #f9fafb;
    border-radius: 8px;
    box-shadow: 0 0 0 1px #e0e4ee;
}

#search table.cr-search-table td {
    padding: 4px 6px;
    vertical-align: middle;
    font-size: 12px;
}

#search table.cr-search-table td[align="right"] {
    font-weight: 800;
    color: #333;
    white-space: nowrap;
}

/* inputs – same look/height as master UI */
#search input[type="text"] {
    width: 100%;
    border: 1px solid #d1d5db;
    border-radius: 5px;
    padding: 2px 6px;
    height: 22px;
    line-height: 22px;
    font-family: 'Segoe UI','Roboto','Arial',sans-serif;
    font-size: 12px;
    box-sizing: border-box;
}

/* search button aligned with inputs */
#search .myButton {
    background: #007bff;
    color: #fff;
    border: none;
    border-radius: 6px;
    height: 24px;
    line-height: 22px;
    padding: 0 16px;
    cursor: pointer;
    font-size: 12px;
    font-weight: 600;
}
#search .myButton:hover {
    background: #0056b3;
}

/* grid wrapper under filters */
#refreshdiv {
    margin-top: 8px;
    background: #fff;
    border-radius: 6px;
    box-shadow: 0 0 0 1px #e0e4ee;
}
</style>

<script type="text/javascript">
function loadSearch() {
    var accountNo   = document.getElementById("txtaccountno").value;
    var accountName = document.getElementById("txtaccountname").value;
    var total       = document.getElementById("txttotal").value;
    getdata(accountNo, accountName, total);
}

function getdata(accountNo, accountName, total){
    $("#refreshdiv").load(
        'opnMainSearchGrid.jsp?accountNo=' + accountNo +
        '&accountName=' + accountName.replace(/ /g, "%20") +
        '&total=' + total
    );
}
</script>
</head>

<body>
<div id="search">
    <div id="search-body">
        <table class="cr-search-table">
            <tr>
                <td align="right" style="width:12%;">A/c No</td>
                <td style="width:31%;">
                    <input type="text" name="txtaccountno" id="txtaccountno"
                           autocomplete="off"
                           value='<s:property value="txtaccountno"/>'>
                </td>

                <td align="right" style="width:15%;">Balance</td>
                <td style="width:22%;">
                    <input type="text" name="txttotal" id="txttotal"
                           value='<s:property value="txttotal"/>'>
                </td>
            </tr>

            <tr>
                <td align="right">A/c Name</td>
                <td colspan="2">
                    <input type="text" name="txtaccountname" id="txtaccountname"
                           autocomplete="off"
                           value='<s:property value="txtaccountname"/>'>
                </td>
                <td align="center">
                    <input type="button" name="btnsearch" id="btnsearch"
                           class="myButton" value="Search"
                           onclick="loadSearch();">
                </td>
            </tr>

            <tr>
                <td colspan="4">
                    <div id="refreshdiv">
                        <jsp:include page="opnMainSearchGrid.jsp"></jsp:include>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</div>
</body>
</html>
