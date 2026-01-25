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
/* ================================
   SEARCH POPUP – COMMON MASTER CSS
   ================================ */

#search {
    background-color: #ffffff;
    padding: 8px;
}

/* Table layout */
#search table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 15px 12px;
}

/* Labels */
#search td[align="right"] {
    font-family: Tahoma, Geneva, sans-serif;
    font-size: 14px;
    font-weight: 700;
    color: #222;
    white-space: nowrap;
}

/* Text inputs */
#search input[type="text"] {
    font-family: Tahoma, Geneva, sans-serif;
    font-size: 14px;
    font-weight: 600;

    padding: 6px 10px;
    height: 34px;
    width: 100%;

    box-sizing: border-box;
    border: 1px solid #bdc3c7;
    border-radius: 4px;
    background-color: #ffffff;
}

/* Input focus */
#search input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
}

/* Button */
#search .myButton {
    font-family: Tahoma, Geneva, sans-serif;
    font-size: 14px;
    font-weight: 700;

    background-color: #007bff;
    color: #ffffff;

    padding: 8px 20px;
    border: none;
    border-radius: 4px;

    cursor: pointer;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

#search .myButton:hover {
    background-color: #007bff;
}

/* Result grid spacing */
#refreshdiv {
    margin-top: 10px;
}

</style>

	<script type="text/javascript">
	$(document).ready(function () {}); 

 	function loadSearch() {

 		var partyname=document.getElementById("txtpartyname").value;
 		var accNo=document.getElementById("txtaccountno").value;
 		var chk = 1;
 		
		getdata(partyname,accNo,chk);
	}
	function getdata(partyname,accNo,chk){
		 $("#refreshdiv").load('accountsDetailsGrid.jsp?partyname='+partyname.replace(/ /g, "%20")+'&accNo='+accNo+'&chk='+chk);
		}

	</script>
<body>
<div id="search">
<table width="100%">
  <tr>
    <td width="13%" align="right">Account</td>
    <td width="54%">
        <input type="text" name="txtaccountno" id="txtaccountno"
               style="width:70%;"
               value='<s:property value="txtaccountno"/>'>
    </td>
    <td width="33%" rowspan="2" align="center">
        <input type="button" name="btnsearch" id="btnsearch"
               class="myButton" value="Search"
               onclick="loadSearch();">
    </td>
  </tr>

  <tr>
    <td align="right">Name</td>
    <td>
        <input type="text" name="txtpartyname" id="txtpartyname"
               value='<s:property value="txtpartyname"/>'>
    </td>
  </tr>

  <tr>
    <td colspan="3">
        <div id="refreshdiv">
            <jsp:include page="accountsDetailsGrid.jsp"></jsp:include>
        </div>
    </td>
  </tr>
</table>
</div>
</body>

</html>