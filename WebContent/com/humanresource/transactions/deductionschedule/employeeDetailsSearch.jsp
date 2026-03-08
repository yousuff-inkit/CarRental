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
	 $("#txtdob").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	 
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
 		var dob=document.getElementById("txtdob").value;
 		var employeebranchchk=window.parent.employeebranchchk.value; 
 		var branch=document.getElementById("brchName").value; 
 		getdata(empname,mob,employeedesignation,employeedepartment,empid,dob, employeebranchchk, branch);
	}
 	
	function getdata(empname,mob,employeedesignation,employeedepartment,empid,dob, employeebranchchk, branch){
		
		 $("#refreshhdiv").load('employeeDetailsSearchGrid.jsp?empname='+empname.replace(/ /g, "%20")+'&mob='+mob+'&employeedesignation='+employeedesignation+'&employeedepartment='+employeedepartment+'&empid='+empid+'&dob='+dob+'&branchid='+branch+'&employeebranchchk='+employeebranchchk);
		}

	</script>
<style type="text/css">
#search {
    width: 100%;
    max-width: 600px; /* Narrower width to make fields smaller */
    margin: 0 auto;
    background: #ffffff;
    border: 1px solid #ccc;
    font-family: Tahoma, Geneva, sans-serif;
    box-sizing: border-box;
    padding: 10px;
    border-radius: 4px;
}

#search table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 5px 8px;
    table-layout: fixed;
}

td.label {
    font-size: 12px;
    font-weight: 700;
    color: #333;
    white-space: nowrap;
    text-align: right;
    padding-right: 8px;
}

input[type="text"], select {
    font-family: Tahoma, Geneva, sans-serif;
    font-weight: 600;
    font-size: 12px;
    padding: 3px 6px;
    width: 100%;
    box-sizing: border-box;
    border: 1px solid #d1d5db;
    border-radius: 3px;
    height: 24px;
}

.myButton {
    font-family: Tahoma, Geneva, sans-serif;
    font-weight: 700;
    font-size: 12px;
    width: 110px;
    height: 32px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 2px 4px rgba(59, 130, 246, 0.2);
    text-transform: uppercase;
    text-align: center;
}

.myButton:hover {
    background: linear-gradient(135deg, #2563eb 0%, #0b45a2 100%);
    transform: translateY(-1px);
}

#refreshhdiv {
    margin-top: 8px;
    border-top: 1px solid #e0e4ee;
    width: 100%;
}
</style>

<body bgcolor="#E0ECF8">
<div id="search">
    <table border="0">
        <colgroup>
            <col width="18%"> <col width="32%"> <col width="18%"> <col width="32%"> </colgroup>
        
        <tr>
            <td class="label">Name</td>
            <td>
                <input type="text" name="txtempname" id="txtempname" value='<s:property value="txtempname"/>'>
            </td>
            <td class="label">Mob</td>
            <td>
                <input type="text" name="txtmobile" id="txtmobile" value='<s:property value="txtmobile"/>'>
            </td>
        </tr>

        <tr>
            <td class="label">Designation</td>
            <td>
                <select id="employeedesignation" name="employeedesignation">
                    <option value="">--Select--</option>
                </select>
            </td>
            <td class="label">Department</td>
            <td>
                <select id="employeedepartment" name="employeedepartment">
                    <option value="">--Select--</option>
                </select>
            </td>
        </tr>

        <tr>
            <td class="label">Emp #</td>
            <td>
                <input type="text" name="txtempid" id="txtempid" value='<s:property value="txtempid"/>'>
            </td>
            <td class="label">DOB</td>
            <td>
                <div id="txtdob"></div>
            </td>
        </tr>

        <tr>
            <td colspan="4" align="center" style="padding-top: 10px;">
                <input type="button" class="myButton" value="Search" onclick="loadSearch();">
            </td>
        </tr>

        <tr>
            <td colspan="4">
                <div id="refreshhdiv">
                    <jsp:include page="employeeDetailsSearchGrid.jsp"></jsp:include>
                </div>
            </td>
        </tr>
    </table>
</div>
</body>
</html>