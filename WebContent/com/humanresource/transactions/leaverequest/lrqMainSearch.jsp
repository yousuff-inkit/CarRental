 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>
 
	<script type="text/javascript">
	$(document).ready(function () {
	 $("#txtdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

	
 	function loadSearch() {
 		var docNo=document.getElementById("txtdocno").value;
 		var dates=document.getElementById("txtdate").value;
 		var check = 1;
 		var employeebranchchk=window.parent.employeebranchchk.value; 
 		var branch=document.getElementById("brchName").value;
		getdata(docNo,dates,check, employeebranchchk, branch);

	}
 	
	function getdata(docNo,dates,check, employeebranchchk, branch){ 
		 $("#refreshdiv").load('lrqMainSearchGrid.jsp?docNo='+docNo+'&dates='+dates+'&check='+check+'&branch='+branch+'&employeebranchchk='+employeebranchchk);
		}

	</script>
	<style>
	/* Make all labels & table text bold */
#search td,
#search label {
    font-weight: 700 !important;
    white-space: nowrap !important;
    font-family: 'Segoe UI', Arial, sans-serif;
    color: #1A2734;
}

/* Input boxes UI */
#search input[type="text"] {
    width: 100%;
    padding: 6px 8px;
    height: 26px;
    border: 1px solid #b8c6d8;
    border-radius: 5px;
    font-weight: 600;
    background: #fff;
    box-sizing: border-box;
}

/* Date div box look */
#txtdate {
    border: 1px solid #b8c6d8 !important;
    background: #fff !important;
    border-radius: 5px;
    padding: 4px 6px;
}

/* Table spacing */
#search td {
    padding: 4px 6px;
    vertical-align: middle;
}

/* Premium Sky Blue small search button */
.myButton {
    background: #4FA8FF;          /* premium sky blue */
    color: #fff;
    border: none;
    padding: 4px 14px;            /* clean small size */
    border-radius: 6px;
    font-weight: 700;
    font-size: 13px;
    cursor: pointer;
    transition: 0.2s ease-in-out;
}

.myButton:hover {
    background: #2F7FD4;          /* darker sky blue */
}

/* Full width fix so layout stays neat */
#search table {
    width: 100%;
    table-layout: fixed;
}
	
	</style>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="7%" align="right">Doc No</td>
    <td width="33%"><input type="text" name="txtdocno" id="txtdocno" autocomplete="off" value='<s:property value="txtdocno"/>'></td>
    <td width="12%" align="right">Date</td>
    <td width="23%"><div id="txtdate" name="txtdate"  value='<s:property value="txtdate"/>'></div>
    <input type="hidden" name="hidtxtdate" id="hidtxtdate" value='<s:property value="hidtxtdate"/>'></td>
<td width="25%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshdiv"><jsp:include page="lrqMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>