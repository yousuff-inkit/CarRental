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

<style type="text/css">
#search {
    background-color: #E0ECF8;
}
</style>

	<script type="text/javascript">
	$(document).ready(function () {}); 

 	function loadSearch() {

 		var partyname=document.getElementById("txtpartyname").value;
 		var accNo=document.getElementById("txtaccountno").value;
 		var contactNo=document.getElementById("txtcontactno").value;
 		
		getdata(partyname,accNo,contactNo);
	}
	function getdata(partyname,accNo,contactNo){
		 $("#refreshdiv").load('clientAccountDetailsSearchGrid.jsp?atype=AR&partyname='+partyname.replace(/ /g, "%20")+'&accNo='+accNo+'&contactNo='+contactNo+'&check=1');
		}

	</script>
<style type="text/css">
/* ------------------------------
    MASTER UI CSS STANDARDS
------------------------------ */
body {
    background-color: #FFFFFF !important;
    font-family: Tahoma, Geneva, sans-serif;
    margin: 0;
    padding: 0;
}

#search {
    background-color: #FFFFFF !important;
    padding: 15px;
}

/* Table Layout: Standard Master UI Gaps */
table {
    border-collapse: separate;
    border-spacing: 12px 8px;
}

/* Labels: Tahoma 14px, Weight 600 */
td[align="right"] {
    font-family: Tahoma, Geneva, sans-serif;
    font-size: 14px;
    font-weight: 600;
    color: #222;
    white-space: nowrap;
}

/* Master Inputs: Grey Border #bdc3c7, Weight 600 */
input[type="text"] {
    font-family: Tahoma, Geneva, sans-serif;
    font-weight: 600;
    font-size: 14px;
    padding: 6px 10px;
    border: 1px solid #bdc3c7; 
    border-radius: 4px;
    background-color: #ffffff;
    box-sizing: border-box; /* Ensures width: % works with padding */
}

input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
}

/* Master Blue Button: #007bff, No Hover Color Change */
.myButton {
    font-family: Tahoma, Geneva, sans-serif;
    font-weight: 700;
    font-size: 14px;
    background-color: #007bff;
    color: white;
    padding: 8px 25px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.myButton:hover {
    background-color: #007bff; /* Stays blue per instructions */
    cursor: pointer;
}
</style>

<body bgcolor="#FFFFFF">
<div id="search">
<table width="100%">
  <tr>
    <td width="7%" align="right">Name</td>
    <td colspan="2">
        <input type="text" name="txtpartyname" id="txtpartyname" style="width:100%;" value='<s:property value="txtpartyname"/>'>
    </td>
    <td width="49%" align="center">
        <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch();">
    </td>
  </tr>
  <tr>
    <td width="7%" align="right">Account</td>
    <td width="26%">
        <input type="text" name="txtaccountno" id="txtaccountno" style="width:70%;" value='<s:property value="txtaccountno"/>'>
    </td>
    <td width="18%" align="right">Contact No.</td>
    <td width="49%">
        <input type="text" name="txtcontactno" id="txtcontactno" style="width:50%;" value='<s:property value="txtcontactno"/>'>
    </td>    
  </tr>
  <tr>
    <td colspan="5">
        <div id="refreshdiv">
            <jsp:include page="clientAccountDetailsSearchGrid.jsp"></jsp:include>
        </div>
    </td>
  </tr>
</table>
</div>
</body>
</html>