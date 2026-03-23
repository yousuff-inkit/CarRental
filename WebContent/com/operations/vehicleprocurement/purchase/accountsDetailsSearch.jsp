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

</script>
<style type="text/css">
/* Master UI Styles */
#search {
  background-color: #ffffff;
  padding: 5px;
}

#search table {
  border-collapse: separate;
  border-spacing: 15px 18px;  
  background-color: #ffffff;
}

#search td[align="right"] {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 700;
  font-size: 14px;
  color: #222;
  white-space: nowrap;
}

input[type="text"] {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 600;
  font-size: 14px;
  padding: 8px 12px;
  width: 95%;                
  max-width: 100%;
  box-sizing: border-box;   
  border: 1px solid #bdc3c7;
  border-radius: 4px;
  background-color: #ffffff;
}

input[type="text"]:focus {
  border-color: #007bff;
  outline: none;
}

#search tr {
  line-height: 1.6;
}

.myButton {
    font-family: Tahoma, Geneva, sans-serif;
    font-weight: 700;
    font-size: 14px;
    width: 130px;
    height: 38px;
    padding: 8px 12px;
    background: #007bff !important;
    color: #ffffff !important;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    transition: none;
    text-align: center;
}

.myButton:hover {
    background-color: #007bff !important;
}

#refreshAccountDetailsDiv {
    margin-top: 10px;
}

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
    <td width="12%" align="right">Account No</td>
    <td width="28%">
        <input type="text" name="txtaccountsno" id="txtaccountsno" value='<s:property value="txtaccountsno"/>'>
    </td>
    <td width="10%" align="right">Currency</td>
    <td width="25%">
        <input type="text" name="txtaccountcurrency" id="txtaccountcurrency" style="width: 60%;" value='<s:property value="txtaccountcurrency"/>'>
        <input type="hidden" name="txtsearchtype" id="txtsearchtype" value='<s:property value="txtsearchtype"/>'>
    </td>
    <td width="25%" rowspan="2" align="center">
        <input type="button" name="btnAccountSearch" id="btnAccountSearch" class="myButton" value="Search" onclick="loadAccountSearch();">
    </td>
  </tr>
  <tr>
    <td align="right">Account Name</td>
    <td colspan="3">
        <input type="text" name="txtaccountsname" id="txtaccountsname" style="width: 98%;" value='<s:property value="txtaccountsname"/>'>
    </td>
  </tr>
  <tr>
    <td colspan="5">
        <div id="refreshAccountDetailsDiv">
            <jsp:include page="accountsDetailsFromGrid.jsp" />
        </div>
    </td>
  </tr>
</table>
</div>
</body></html>