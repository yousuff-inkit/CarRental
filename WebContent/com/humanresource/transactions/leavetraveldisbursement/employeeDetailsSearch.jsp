 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

	<script type="text/javascript">
	$(document).ready(function () {
	 $("#txtdoj").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	 
	 getEmpDesignation();getEmpDepartment();
	}); 

	function getEmpDesignation() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var designationItems = items[0].split(",");
				var designationIdItems = items[1].split(",");
				var optionsdesignation = '<option value="">--Select--</option>';
				for (var i = 0; i < designationItems.length; i++) {
					optionsdesignation += '<option value="' + designationIdItems[i] + '">'
							+ designationItems[i] + '</option>';
				}
				$("select#employeedesignation").html(optionsdesignation);
			} else {}
		}
		x.open("GET", "getDesignation.jsp", true);
		x.send();
	}
  
  	function getEmpDepartment() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var departmentItems = items[0].split(",");
				var departmentIdItems = items[1].split(",");
				var optionsdepartment = '<option value="">--Select--</option>';
				for (var i = 0; i < departmentItems.length; i++) {
					optionsdepartment += '<option value="' + departmentIdItems[i] + '">'
							+ departmentItems[i] + '</option>';
				}
				$("select#employeedepartment").html(optionsdepartment);
			} else {}
		}
		x.open("GET", "getDepartment.jsp", true);
		x.send();
	}
  
 	function loadSearch() {
 		
 		var empname=document.getElementById("txtempname").value;
 		var mob=document.getElementById("txtmobile").value;
 		var employeedesignation=document.getElementById("employeedesignation").value;
 		var employeedepartment=document.getElementById("employeedepartment").value;
 		var empid=document.getElementById("txtempid").value;
 		var doj=document.getElementById("txtdoj").value;
        var check = 1;
        
 		getdata(empname,mob,employeedesignation,employeedepartment,empid,doj,check);
	}
 	
	function getdata(empname,mob,employeedesignation,employeedepartment,empid,doj,check){
		
		 $("#refreshdiv").load('employeeDetailsSearchGrid.jsp?empname='+empname.replace(/ /g, "%20")+'&mob='+mob+'&employeedesignation='+employeedesignation+'&employeedepartment='+employeedepartment+'&empid='+empid+'&doj='+doj+'&check='+check);
		}

	</script>
<style type="text/css">
/* Master UI Styles Applied */
#search {
  background-color: #ffffff;
  padding: 5px;
}

#search table {
  border-collapse: separate;
  border-spacing: 15px 18px;  /* Master UI Spacing */
  background-color: #ffffff;
}

#search td[align="right"] {
  font-weight: 700;
  font-size: 14px;
  color: #222;
  font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

input[type="text"], 
select {
  font-weight: 600;
  font-size: 14px;
  padding: 8px 12px;
  width: 95%;                
  max-width: 100%;
  box-sizing: border-box;   
  border: 1px solid #ccc;
  height: 38px; /* Uniform height for Master UI inputs */
}

#search tr {
  line-height: 1.6;
}

/* Master UI Button - Dark Blue Gradient */
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
    <td width="10%" align="right">Name</td>
    <td colspan="3">
        <input type="text" name="txtempname" id="txtempname" style="width:98%" value='<s:property value="txtempname"/>'>
    </td>
    <td width="10%" align="right">Mob</td>
    <td colspan="2">
        <input type="text" name="txtmobile" id="txtmobile" value='<s:property value="txtmobile"/>'>
    </td>
    <td width="15%" align="center">
        <input type="button" name="btnsearch" id="btnsearch" class="myButton" 
               value="Search" onclick="loadSearch(); return false;">
    </td>
  </tr>
  <tr>
    <td align="right">Designation</td>
    <td width="15%">
        <select id="employeedesignation" name="employeedesignation" value='<s:property value="employeedesignation"/>'>
          <option value="">--Select--</option>
        </select>
    </td>
    <td width="10%" align="right">Department</td>
    <td width="15%">
        <select id="employeedepartment" name="employeedepartment" value='<s:property value="employeedepartment"/>'>
          <option value="">--Select--</option>
        </select>
    </td>
    <td width="8%" align="right">Emp#</td>
    <td width="12%">
        <input type="text" name="txtempid" id="txtempid" value='<s:property value="txtempid"/>'>
    </td>
    <td width="10%" align="right">Date of Join</td>
    <td width="15%">
        <div id="txtdoj" name="txtdoj" value='<s:property value="txtdoj"/>'></div>
    </td>
  </tr>
  <tr>
    <td colspan="8">
        <div id="refreshdiv">
            <jsp:include page="employeeDetailsSearchGrid.jsp"></jsp:include>
        </div>
    </td>
  </tr>
</table>
</div>
</body></html>