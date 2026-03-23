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

 		var employeeName=document.getElementById("txtpartyname").value;
 		var empId=document.getElementById("txtpartyid").value;
 		var contactNo=document.getElementById("txtcontactno").value;
 		var designation=document.getElementById("cmbempdesignation").value;
 		var department=document.getElementById("cmbempdepartment").value;
 		var category=document.getElementById("cmbpayrollcategory").value;
 		var employeebranchchk=window.parent.employeebranchchk.value; 
 		var branch=document.getElementById("brchName").value;
		getdata(employeeName,empId,contactNo,designation,department,category, employeebranchchk, branch);
	}
	function getdata(employeeName,empId,contactNo,designation,department,category, employeebranchchk, branch){
		 $("#refreshdiv").load('employeeDetailsSearchGrid.jsp?employeename='+employeeName.replace(/ /g, "%20")+'&empid='+empId+'&designation='+designation+'&department='+department+'&category='+category+'&contactno='+contactNo+'&branchid='+branch+'&employeebranchchk='+employeebranchchk);
		}

	</script>
	<style type="text/css">
/* Master UI Fix: Explicit White Background */
#search {
  background-color: #ffffff; /* This removes the blue-grey background */
  padding: 10px;
  border-radius: 4px;
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

.myButton {
    font-weight: 700;
    font-size: 13px;
    width: 130px;
    height: 38px;
    padding: 8px 12px;
    /* Explicit Gradient from Master UI */
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%) !important;
    color: #ffffff !important;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 2px 4px rgba(59, 130, 246, 0.2);
    text-transform: uppercase;
    text-align: center;
}

.myButton:hover {
  background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%) !important;
}
</style>

<body bgcolor="#ffffff"> <div id="search">
<table width="100%" border="0">
  <tr>
    <td width="10%" align="right">Name</td>
    <td width="40%">
        <input type="text" name="txtpartyname" id="txtpartyname" value='<s:property value="txtpartyname"/>'>
    </td>
    <td width="10%" align="right">ID#</td>
    <td width="40%">
        <input type="text" name="txtpartyid" id="txtpartyid" value='<s:property value="txtpartyid"/>'>
    </td>
  </tr>
  <tr>
    <td align="right">Contact No.</td>
    <td>
        <input type="text" name="txtcontactno" id="txtcontactno" value='<s:property value="txtcontactno"/>'>
    </td>
    <td colspan="2" style="padding-left: 15px;">
        <input type="button" name="btnsearch" id="btnsearch" class="myButton" 
               value="Search" onclick="loadSearch(); return false;">
    </td>
  </tr>
  <tr>
    <td colspan="4">
        <div id="refreshdiv">
            <jsp:include page="employeeDetailsSearchGrid.jsp"></jsp:include>
        </div>
    </td>
  </tr>
</table>
</div>
</body>
</html>