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
	<style>
	/* 700 weight + no wrap */
#search td,
#search label {
    font-weight: 700 !important;
    white-space: nowrap !important;
    font-family: 'Segoe UI', Arial, sans-serif;
    color: #1A2734;
}

/* Input Fields UI */
#search input[type="text"] {
    padding: 6px 8px;
    height: 28px;
    border: 1px solid #b8c6d8;
    border-radius: 5px;
    font-weight: 600;
    background: #fff;
    box-sizing: border-box;
    width: 100%;
}

/* Table cell spacing */
#search td {
    padding: 6px 8px;
    vertical-align: middle;
}

/* Premium Small Button */
.myButton {
    background:#4FA8FF;       /* premium sky blue */
    color:#fff;
    border:none;
    padding:4px 12px;
    border-radius:6px;
    font-weight:700;
    font-size:13px;
    cursor:pointer;
    transition:0.2s ease-in-out;
}

.myButton:hover {
    background:#2F7FD4;
}

/* Make table stable */
#search table {
    width:100%;
    table-layout: fixed;
}
	
	</style>
	
	
<body>
<div id=search>
<table width="100%">
  <tr>
    <td align="right">Name</td>
    <td colspan="2"><input type="text" name="txtpartyname" id="txtpartyname" style="width:100%;" value='<s:property value="txtpartyname"/>'></td>
    <td width="49%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
  <td width="7%" align="right">ID#</td>
    <td width="26%"><input type="text" name="txtpartyid" id="txtpartyid" style="width:70%;" value='<s:property value="txtpartyid"/>'></td>
    <td width="18%" align="right">Contact No.</td>
    <td width="49%"><input type="text" name="txtcontactno" id="txtcontactno" style="width:50%;" value='<s:property value="txtcontactno"/>'>
    <input type="hidden" name="txtatype" id="txtatype" value='<s:property value="txtatype"/>'></td>   
  </tr>
  <tr>
    <td colspan="5"><div id="refreshdiv"><jsp:include page="employeeDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>