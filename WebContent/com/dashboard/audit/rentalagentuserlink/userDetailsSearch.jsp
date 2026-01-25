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

 		var usersname=document.getElementById("txtusersname").value;
 		var usersrole=document.getElementById("txtusersrole").value;
 		var chk = 1;
 		
		getdata(usersname,usersrole,chk);
	}
 	
	function getdata(usersname,usersrole,chk){
		 $("#refreshdiv").load('userDetailsSearchGrid.jsp?usersname='+usersname.replace(/ /g, "%20")+'&usersrole='+usersrole.replace(/ /g, "%20")+'&chk='+chk);
	}

</script>
<body>
<div id="search">
<table width="100%">
  <tr>
    <td width="5%" align="right">User</td>
    <td width="37%">
        <input type="text" name="txtusersname" id="txtusersname"
               value='<s:property value="txtusersname"/>'>
    </td>

    <td width="9%" align="right">Role</td>
    <td width="33%">
        <input type="text" name="txtusersrole" id="txtusersrole"
               value='<s:property value="txtusersrole"/>'>
    </td>

    <td width="16%" align="center">
        <input type="button" name="btnsearch" id="btnsearch"
               class="myButton" value="Search"
               onclick="loadSearch();">
    </td>
  </tr>

  <tr>
    <td colspan="5">
        <div id="refreshdiv">
            <jsp:include page="userDetailsSearchGrid.jsp"></jsp:include>
        </div>
    </td>
  </tr>
</table>
</div>
</body>

</html>