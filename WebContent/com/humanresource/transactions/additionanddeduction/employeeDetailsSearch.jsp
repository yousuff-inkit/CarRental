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
/* Search Section Box */
#search {
    background-color: #E0ECF8;
    padding: 15px;
    border-radius: 8px;
    margin: 10px;
    box-shadow: 0 0 6px rgba(0,0,0,0.1);
}

/* Labels */
#search td {
    padding: 6px 4px;
    font-size: 13px;
}

/* Inputs */
#search input[type="text"] {
    padding: 6px;
    border: 1px solid #AFC7D9;
    border-radius: 5px;
    font-size: 13px;
    outline: none;
}

#search input[type="text"]:focus {
    border-color: #66A3D2;
    box-shadow: 0 0 4px rgba(102,163,210,0.5);
}

/* Search Button */
.myButton {
    background-color: #4A90E2;
    color: #fff;
    padding: 7px 18px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 13px;
    font-weight: bold;
}

.myButton:hover {
    background-color: #2171C7;
}

/* Refresh Div */
#refreshdiv {
    margin-top: 10px;
}
</style>


	<script type="text/javascript">
	$(document).ready(function () {}); 

 	function loadSearch() {

 		var employeeName=document.getElementById("txtpartyname").value;
 		var empId=document.getElementById("txtpartyid").value;
 		var contactNo=document.getElementById("txtcontactno").value;
 		var employeebranchchk=window.parent.employeebranchchk.value; 
 		var branch=document.getElementById("brchName").value;
		getdata(employeeName,empId,contactNo, employeebranchchk, branch);
	}
	function getdata(employeeName,empId,contactNo, employeebranchchk, branch){  
		 $("#refreshdiv").load('employeeDetailsSearchGrid.jsp?employeename='+employeeName.replace(/ /g, "%20")+'&empid='+empId+'&contactno='+contactNo+'&branchid='+branch+'&employeebranchchk='+employeebranchchk);
		}

	</script>
<body>
<div id="search">
  <table width="100%">
  
    <tr>
      <td align="right">Name</td>
      <td colspan="3">
        <input type="text" name="txtpartyname" id="txtpartyname" style="width:95%;" 
        value='<s:property value="txtpartyname"/>'>
      </td>
      <td width="20%"></td>
    </tr>

    <tr>
      <td align="right">ID#</td>
      <td>
        <input type="text" name="txtpartyid" id="txtpartyid" style="width:80%;" 
        value='<s:property value="txtpartyid"/>'>
      </td>

      <td align="right">Contact No.</td>
      <td>
        <input type="text" name="txtcontactno" id="txtcontactno" style="width:85%;" 
        value='<s:property value="txtcontactno"/>'>
      </td>

      <td align="left">
        <input type="button" name="btnsearch" id="btnsearch" class="myButton" 
        value="Search" onclick="loadSearch();">
      </td>
    </tr>

    <tr>
      <td colspan="5">
        <div id="refreshdiv">
          <jsp:include page="employeeDetailsSearchGrid.jsp"></jsp:include>
        </div>
      </td>
    </tr>

  </table>
</div>
</body>

</html>