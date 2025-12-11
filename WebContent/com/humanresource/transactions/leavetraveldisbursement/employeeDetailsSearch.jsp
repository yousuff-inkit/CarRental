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
	<style>
	
	/* Bold labels + No wrap */
#search td,
#search label {
    font-weight: 700 !important;
    white-space: nowrap !important;
    font-family: 'Segoe UI', Arial, sans-serif;
    color: #1A2734;
}

/* Input & Select UI */
#search input[type="text"],
#search select {
    width: 100%;
    padding: 6px 8px;
    height: 28px;
    border: 1px solid #b8c6d8;
    border-radius: 5px;
    background: #fff;
    font-weight: 600;
    box-sizing: border-box;
}

/* Date div UI */
#txtdoj {
    border: 1px solid #b8c6d8 !important;
    background: #fff !important;
    border-radius: 5px;
    padding: 4px 6px;
}

/* Cell spacing */
#search td {
    padding: 6px 8px;
    vertical-align: middle;
}

/* Premium Sky-Blue Button */
.myButton {
    background:#4FA8FF;         /* premium sky-blue */
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
    background:#2F7FD4;         /* darker premium blue */
}
	
	
	/* --- STYLING ALL DROPDOWNS (SELECT BOXES) --- */
select {
    width: 100% !important;          /* make it fill the cell neatly */
    padding: 4px 10px;               /* make dropdown taller */
    height: 28px !important;         /* uniform height */
    border: 1px solid #b8c6d8;       /* clean border */
    border-radius: 6px;              /* modern rounded look */
    background-color: #fff;          /* remove any pink */
    font-weight: 600;                /* bold text */
    color: #222;                     /* clean dark text */
    box-sizing: border-box;
}

/* Dropdown on focus (blue border) */
select:focus {
    border-color: #007bff !important;
    outline: none;
}

/* Improve dropdown option spacing */
select option {
    padding: 8px 12px !important;     /* Top/Bottom 8px, Left/Right 12px */
    font-size: 14px;                  /* Clean readable size */
    line-height: 1.6;                 /* Extra breathing room */
}
	</style>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="7%" align="right">Name</td>
    <td colspan="3"><input type="text" name="txtempname" id="txtempname" style="width:96%" value='<s:property value="txtempname"/>'></td>
    <td width="8%" align="right">Mob</td>
    <td colspan="2"><input type="text" name="txtmobile" id="txtmobile" value='<s:property value="txtmobile"/>'></td>
    <td width="15%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td align="right">Designation</td>
    <td width="15%"><select id="employeedesignation" name="employeedesignation" style="width:96%;" value='<s:property value="employeedesignation"/>'>
      <option value="">--Select--</option></select></td>
    <td width="10%" align="right">Department</td>
    <td width="19%"><select id="employeedepartment" name="employeedepartment" style="width:96%;" value='<s:property value="employeedepartment"/>'>
      <option value="">--Select--</option></select></td>
    <td width="8%" align="right">Emp#</td>
    <td width="14%"><input type="text" name="txtempid" id="txtempid" value='<s:property value="txtempid"/>'></td>
    <td width="12%" align="right">Date of Join</td>
    <td><div id="txtdoj" name="txtdoj"  value='<s:property value="txtdoj"/>'></div></td>
  </tr>
  <tr>
    <td colspan="8"><div id="refreshdiv"><jsp:include  page="employeeDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>