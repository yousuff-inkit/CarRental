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

<style>
/* make left-side texts like 'Account No', 'Currency', etc. bold */
#search table td[align="right"] {
    font-weight: 800;
    font-family: 'Segoe UI','Roboto','Arial',sans-serif;
    font-size: 12px;
    color: #333;
}
</style>


<script type="text/javascript">
	$(document).ready(function () {
		$("#txtaccperiod").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		document.getElementById("txtatypes").value=document.getElementById("cmbacctype").value;
		
		 var year = window.parent.txtaccountperiodfrom.value;
		// alert(year);
		 var newDate = year.split('-');
		 year = newDate[1] + "-" + newDate[0] + "-" + newDate[2];
		 $('#txtaccperiod ').jqxDateTimeInput('setDate', new Date(year));
	}); 

	function loadClientAccountSearch() {
			var clientaccountno=document.getElementById("accountsno").value;
			var clientaccountname=document.getElementById("accountsname").value;
			var clientmobile=document.getElementById("clientmobileno").value;
			var curr=document.getElementById("txtcurrencies").value;
			var accounttype=document.getElementById("txtatypes").value;
			var date = document.getElementById("txtaccperiod").value;
			var checked = 1;
	
			getClientAccountDetails(clientaccountno,clientaccountname,clientmobile,curr,accounttype,date,checked);
	}
		
	function getClientAccountDetails(clientaccountno,clientaccountname,clientmobile,curr,accounttype,date,checked){
		 $("#refreshClientAccountDiv").load("clientAccountDetailsSearchGrid.jsp?accountno="+clientaccountno+'&accountname='+clientaccountname.replace(/ /g, "%20")+'&mobile='+clientmobile+'&currency='+curr+'&atype='+accounttype+'&date='+date+'&check='+checked);
	}

</script>
<style type="text/css">
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
  font-weight: 700;
  font-size: 14px;
  color: #222;
  font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

input[type="text"] {
  font-weight: 600;
  font-size: 14px;
  padding: 8px 12px;
  width: 95%;                
  max-width: 100%;
  box-sizing: border-box;   
  border: 1px solid #ccc;
}

#search tr {
  line-height: 1.6;
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
    <td width="15%" align="right">Account No</td>
    <td width="25%">
        <input type="text" name="accountsno" id="accountsno" value='<s:property value="accountsno"/>'>
    </td>
    <td width="15%" align="right">Currency</td>
    <td width="25%">
        <input type="text" name="txtcurrencies" id="txtcurrencies" value='<s:property value="txtcurrencies"/>'>
        <input type="hidden" name="txtatypes" id="txtatypes" value='<s:property value="txtatypes"/>'>
        <div hidden="true" id="txtaccperiod" name="txtaccperiod" value='<s:property value="txtaccperiod"/>'></div>
    </td>
    <td width="20%" rowspan="2" align="center">
        <input type="button" name="btnClientAccountSearch" id="btnClientAccountSearch" class="myButton" value="Search" onclick="loadClientAccountSearch();">
    </td>
  </tr>
  <tr>
    <td align="right">Account Name</td>
    <td>
        <input type="text" name="accountsname" id="accountsname" value='<s:property value="accountsname"/>'>
    </td>
    <td align="right">Mobile</td>
    <td>
        <input type="text" name="clientmobileno" id="clientmobileno" value='<s:property value="clientmobileno"/>'>
    </td>
  </tr>
  <tr>
    <td colspan="5">
        <div id="refreshClientAccountDiv">
            <jsp:include page="clientAccountDetailsSearchGrid.jsp"></jsp:include>
        </div>
    </td>
  </tr>
</table>
</div>
</body>
</html>