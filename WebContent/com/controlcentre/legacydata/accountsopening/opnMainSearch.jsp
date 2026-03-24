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

<style type="text/css">
/* Wrapper container with white background */
#search {
  background-color: #ffffff;
  padding: 5px;
}

/* Standardized table spacing for Master UI */
#search table {
  border-collapse: separate;
  border-spacing: 15px 18px;  
  background-color: #ffffff;
}

/* Label styling: bold, dark grey, Segoe UI font */
#search td[align="right"] {
  font-weight: 700;
  font-size: 14px;
  color: #222;
  font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

/* Input field styling: 95% width, standard padding and borders */
input[type="text"] {
  font-weight: 600;
  font-size: 14px;
  padding: 8px 12px;
  width: 95%;                
  max-width: 100%;
  box-sizing: border-box;   
  border: 1px solid #ccc;
}

/* Row height spacing */
#search tr {
  line-height: 1.6;
}

/* Master UI Primary Action Button - Dark Blue Gradient */
.myButton {
    font-weight: 700;
    font-size: 13px;
    width: 130px;
    height: 38px;
    padding: 8px 12px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%) !important;
    color: #ffffff !important;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 2px 4px rgba(59, 130, 246, 0.2);
    text-transform: uppercase;
    letter-spacing: 0.3px;
    white-space: nowrap;
    text-align: center;
}

/* Hover effect for the primary button */
.myButton:hover {
  background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%) !important;
  box-shadow: 0 4px 6px rgba(59, 130, 246, 0.3);
  transform: translateY(-1px);
}
</style>

<body bgcolor="#ffffff">
<div id="search">
<table width="100%" border="0">
  
  <tr>
    <td width="12%" align="right">A/c No</td>
    <td width="35%">
        <input type="text" name="txtaccountno" id="txtaccountno"
               autocomplete="off"
               value='<s:property value="txtaccountno"/>'>
    </td>
    <td width="15%" align="right">Balance</td>
    <td width="38%">
        <input type="text" name="txttotal" id="txttotal"
               value='<s:property value="txttotal"/>'>
    </td>
  </tr>

  <tr>
    <td align="right">A/c Name</td>
    <td colspan="2">
        <input type="text" name="txtaccountname" id="txtaccountname"
               autocomplete="off" style="width: 98%;"
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
</body>
</html>
