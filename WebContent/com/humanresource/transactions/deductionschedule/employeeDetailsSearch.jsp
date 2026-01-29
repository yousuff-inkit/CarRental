 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
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
/* ================================
   SEARCH POPUP – REFINED LAYOUT
   ================================ */

.search-popup {
    padding: 14px;
}

/* Search form table */
.search-form {
    width: 100%;
    border-spacing: 18px 12px;
}

/* Labels */
.search-form .label {
    font-family: Tahoma, Geneva, sans-serif;
    font-size: 14px;
    font-weight: 700;
    color: #222;
    white-space: nowrap;
    text-align: right;
}

/* Input cells */
.search-form .field {
    width: 28%;
}

/* Action cell */
.search-form .action {
    text-align: center;
    width: 12%;
}

/* Grid wrapper */
.search-grid {
    margin-top: 14px;
    border: 1px solid #dcdcdc;
    border-radius: 4px;
    background: #ffffff;
    padding: 6px;
}
.myButtons {
    font-family: Tahoma, Geneva, sans-serif;
    font-size: 14px;
    font-weight: 700;
    background-color: #007bff;   /* BLUE */
    color: #ffffff;
    padding: 8px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    box-shadow: 0 2px 4px rgba(0,0,0,0.15);
}

/* Keep same blue on hover */
.myButtons:hover {
    background-color: #007bff;
}
</style>
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
<body>
<div id="search">
<table width="100%">

  <!-- ROW 1 -->
  <tr>
    <td class="label">Name</td>
    <td class="field-wide" colspan="3">
        <input type="text"
               name="txtempname"
               id="txtempname"
               value='<s:property value="txtempname"/>'>
    </td>

    <td class="label">Mob</td>
    <td class="field-wide">
        <input type="text"
               name="txtmobile"
               id="txtmobile"
               value='<s:property value="txtmobile"/>'>
    </td>

    <td class="action" rowspan="2">
        <input type="button"
               name="btnsearch"
               id="btnsearch"
               class="myButton"
               value="Search"
               onclick="loadSearch();">
    </td>
  </tr>

  <!-- ROW 2 -->
  <tr>
    <td class="label">Designation</td>
    <td class="field">
        <select id="employeedesignation"
                name="employeedesignation">
            <option value="">--Select--</option>
        </select>
    </td>

    <td class="label">Department</td>
    <td class="field">
        <select id="employeedepartment"
                name="employeedepartment">
            <option value="">--Select--</option>
        </select>
    </td>

    <td class="label">Emp #</td>
    <td class="field">
        <input type="text"
               name="txtempid"
               id="txtempid"
               value='<s:property value="txtempid"/>'>
    </td>

    <td class="label">DOB</td>
    <td class="field">
        <div id="txtdob"></div>
    </td>
  </tr>

  <!-- GRID -->
  <tr>
    <td colspan="8">
        <div id="refreshhdiv">
            <jsp:include page="employeeDetailsSearchGrid.jsp"></jsp:include>
        </div>
    </td>
  </tr>

</table>
</div>
</body>
</html>