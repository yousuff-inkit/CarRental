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
/* Master UI Styles */
#search {
  background-color: #ffffff;
  padding: 5px;
}

#search table {
  border-collapse: separate;
  border-spacing: 12px 15px;  
  background-color: #ffffff;
}

#search td[align="right"], #search td[align="left"] {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 400; /* Regular weight */
  font-size: 14px;
  color: #222;
  white-space: nowrap;
}

input[type="text"] {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 400; /* Regular weight */
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
  border-color: #2563eb;
  outline: none;
}

#search tr {
  line-height: 1.6;
}

/* Updated Gradient Button UI */
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

#findiv {
    margin-top: 10px;
}
</style>

<body bgcolor="#ffffff">
<div id="search">
<table width="100%" border="0">
  <tr>
    <td width="10%" align="right">Account No</td>
    <td width="15%">
        <input type="text" name="txtaccountsno1" id="txtaccountsno1" value='<s:property value="txtaccountsno1"/>'>
    </td>
    <td width="10%" align="right">Account Name</td>
    <td width="50%">
        <input type="text" name="txtaccountsname1" id="txtaccountsname1" style="width: 98%;" value='<s:property value="txtaccountsname1"/>'>
    </td>
    <td width="15%" align="center">
        <input type="button" name="btnAccountSearch1" id="btnAccountSearch1" class="myButton" value="Search" onclick="loadAccountSearch();">
    </td>
  </tr>
  <tr>
    <td colspan="5">
        <div id="findiv">
            <jsp:include page="finaccsubsearch.jsp" />
        </div>
    </td>
  </tr>
</table>
</div>
</body></html>