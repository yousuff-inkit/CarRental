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


</style>

	<script type="text/javascript">
	$(document).ready(function () {}); 

 	 function loadSearch() {

 		var employeeName=document.getElementById("txtpartyname").value;
 		var empId=document.getElementById("txtpartyid").value;
 		var contactNo=document.getElementById("txtcontactno").value;
 		var employeebranchchk=window.parent.employeebranchchk.value; 
 		var branch=document.getElementById("cmbbranch").value; 
		getdata(employeeName,empId,contactNo, employeebranchchk, branch);
	}
	function getdata(employeeName,empId,contactNo, employeebranchchk, branch){
		 $("#refreshdiv").load('employeeDetailsSearchGrid.jsp?employeename='+employeeName.replace(/ /g, "%20")+'&empid='+empId+'&contactno='+contactNo+'&check=1'+'&branch='+branch+'&employeebranchchk='+employeebranchchk);
		}

	</script>
<style type="text/css">

/* ===== MASTER UI STRICT ===== */

body {
    margin: 0;
    background-color: #f5f7fa;
}

/* FONT LOCK */
#search.modern-ui,
#search.modern-ui * {
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    font-size: 12px !important;
}

/* PANEL */
.modern-ui .search-panel {
    background: #fff;
    border: 1px solid #c5d3e0;
    border-radius: 8px;
    padding: 10px;
    margin-bottom: 10px;
}

/* GRID */
.modern-ui .grid-container {
    background: #fff;
    border: 1px solid #c5d3e0;
    border-radius: 8px;
    padding: 5px;
}

/* TABLE */
.modern-ui table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 4px 8px;
}

/* LABELS */
.modern-ui td.label {
    font-weight: 600;
    color: #444;
    text-align: right;
    white-space: nowrap;
}

/* INPUTS */
.modern-ui input[type="text"] {
    height: 24px !important;
    padding: 2px 6px !important;
    border: 1px solid #b8c6d8;
    border-radius: 3px;
    box-sizing: border-box;
    width: 100%;
}

/* BUTTON */
.modern-ui .myButton {
    height: 24px !important;
    padding: 0 14px;
    font-weight: 700;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #fff;
    border: 1px solid #083a8a;
    border-radius: 3px;
    cursor: pointer;
    white-space: nowrap;
}

</style>

<body>

<div id="search" class="modern-ui">

    <!-- SEARCH PANEL -->
    <div class="search-panel">

        <table>
            <colgroup>
                <col width="8%">   <!-- Name -->
                <col width="30%">

                <col width="8%">   <!-- ID -->
                <col width="18%">

                <col width="10%">  <!-- Contact -->
                <col width="16%">

                <col width="10%">  <!-- Button -->
            </colgroup>

            <tr>
                <!-- Name -->
                <td class="label">Name</td>
                <td>
                    <input type="text"
                        name="txtpartyname"
                        id="txtpartyname"
                        value='<s:property value="txtpartyname"/>'>
                </td>

                <!-- ID -->
                <td class="label">ID#</td>
                <td>
                    <input type="text"
                        name="txtpartyid"
                        id="txtpartyid"
                        value='<s:property value="txtpartyid"/>'>
                </td>

                <!-- Contact -->
                <td class="label">Contact No.</td>
                <td>
                    <input type="text"
                        name="txtcontactno"
                        id="txtcontactno"
                        value='<s:property value="txtcontactno"/>'>

                    <input type="hidden"
                        name="txtatype"
                        id="txtatype"
                        value='<s:property value="txtatype"/>'>
                </td>

                <!-- Button -->
                <td>
                    <input type="button"
                        name="btnsearch"
                        id="btnsearch"
                        class="myButton"
                        value="Search"
                        onclick="loadSearch();">
                </td>
            </tr>

        </table>
    </div>

    <!-- GRID -->
    <div class="grid-container">
        <div id="refreshdiv">
            <jsp:include page="employeeDetailsSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>

</html>