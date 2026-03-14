 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <%--   <jsp:include page="../../../../includes.jsp"></jsp:include>   --%>   
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
</style>

	<script type="text/javascript">
	$(document).ready(function () {
	  $("#searchdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
	}); 

 	function loadSearch1() {

 		var seardate=$("#searchdate").val();
 	  var seartype=document.getElementById("enqtype").value;
 		var seardoc=document.getElementById("msdocno").value; 

 	
	getdata1(seardate,seartype,seardoc);
 

	}
	function getdata1(seardate,seartype,seardoc){
		

		
		 $("#refreshdivmas").load('subMastersearch.jsp?seardate='+seardate+'&seartype='+seartype+'&seardoc='+seardoc);
		
		}

	</script>
<style type="text/css">
/* Master UI Styles */
/* Table spacing and layout */
table {
  border-collapse: separate;
  border-spacing: 15px 12px; /* Standardized master gap */
}

/* Bold labels - Standardized to Master UI 14px Tahoma */
td[align="right"] {
  font-family: Tahoma, Geneva, sans-serif;
  font-size: 14px;
  font-weight: 700;
  color: #222;
}

/* Bold text inside inputs and selects */
input[type="text"], select {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 600;
  font-size: 14px;
  padding: 8px 12px;
  width: 95%; /* Standardized width */
  max-width: 100%;
  box-sizing: border-box;
  border: 1px solid #ccc;
  border-radius: 4px;
}

/* Date field styling (applied to the div) */
#searchdate {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 600;
  font-size: 14px;
}

/* Master Button Appearance */
.myButton {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 700;
  font-size: 14px;
  background-color: #007bff; /* Master green */
  color: white;
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  box-shadow: 0 2px 5px rgba(0,0,0,0.2);
  transition: background-color 0.3s;
}

.myButton:hover {
  background-color: #45a049;
}

/* Row spacing */
tr {
  line-height: 1.8;
}
#search td[align="right"]{
    font-weight:700;
    font-size:14px;
    color:#222;
}
</style>

<body bgcolor="#E0ECF8">
<div id="search">

<table width="100%">

<tr>
    <td width="6%" align="right">Date</td>
    <td width="14%">
        <div id="searchdate" name="searchdate"
        value='<s:property value="searchdate"/>'></div>
    </td>

    <td width="21%" align="right">Doc No</td>
    <td width="32%">
        <input type="text" name="msdocno" id="msdocno"
        value='<s:property value="msdocno"/>'>
    </td>

    <td width="27%" align="center" rowspan="2">
        <input type="button" name="mainsearchbtn"
        id="mainsearchbtn" class="myButton"
        value="Search" onclick="loadSearch1()">
    </td>
</tr>

<tr>
    <td align="right">Type</td>
    <td>
        <select name="enqtype" id="enqtype" style="width:100%;">
            <option value="traffic">Traffic</option>
            <option value="salik">Salik</option>
        </select>
    </td>

    <td colspan="2"></td>
</tr>

<tr>
<td colspan="5">
<div id="refreshdivmas">
<jsp:include page="subMastersearch.jsp" />
</div>
</td>
</tr>

</table>

</div>
</body>
</html>