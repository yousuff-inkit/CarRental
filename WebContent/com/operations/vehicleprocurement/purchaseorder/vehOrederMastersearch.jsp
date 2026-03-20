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
	    
		   /* Date */ 	
	    $("#datess").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy",value:null}); 
		   
	});   
		   
 	function loadSearchs() {
 		
 		var docnoss=document.getElementById("docnoss").value;
 		var accountss=document.getElementById("accountss").value;
 		var accnamesss=document.getElementById("accnamess").value;
 		var datess=document.getElementById("datess").value;
 		var reftypess=document.getElementById("reftypess").value;
 		/* var brchName=document.getElementById("brchName").value;
 */ 		
 		var accnamess = accnamesss.replace(' ', '%20');

		
	var aa="yes";
		getdata(docnoss,accountss,accnamess,datess,reftypess,aa);
 

	}
	function getdata(docnoss,accountss,accnamess,datess,reftypess,aa){
		
	
		
		 $("#refreshdivs").load('submasterSearch.jsp?docnoss='+docnoss+'&accountss='+accountss+'&accnamess='+accnamess+'&datess='+datess+'&reftypess='+reftypess+'&aa='+aa);

		}

	</script>
<style type="text/css">
/* Master UI Styles */
/* Table spacing and layout */
table {
  border-collapse: separate;
  border-spacing: 15px 15px; /* Standardized master gap */
}

/* Bold labels - Standardized to Master UI 14px Tahoma */
td[align="right"] {
  font-family: Tahoma, Geneva, sans-serif;
  font-size: 14px;
  font-weight: 700;
  color: #222;
}

/* Bold text inside inputs and selects with Grey Borders */
input[type="text"], select {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 600;
  font-size: 14px;
  padding: 8px 12px;
  max-width: 100%;
  box-sizing: border-box;
  /* Grey border as requested */
  border: 1px solid #bdc3c7; 
  border-radius: 4px;
  background-color: #ffffff;
}

/* Focus state for inputs */
input[type="text"]:focus, select:focus {
  border-color: #007bff;
  outline: none;
}

/* Date field styling for div */
#datess {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 600;
  font-size: 14px;
}

/* Master Button Appearance */
.myButton {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 700;
  font-size: 14px;
  background-color: #007bff; /* Blue Button Color */
  color: white;
  padding: 10px 25px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  transition: none; /* No hover transition */
}

/* No color change on hover */
.myButton:hover {
  background-color: #007bff; 
  cursor: pointer;
}

/* Row spacing */
tr {
  line-height: 1.6;
}
#search td[align="right"]{
    font-weight:700;
    font-size:14px;
    color:#222;
}
</style>

<body bgcolor="#FFFFFF">
<div id="search">

<table width="100%">

<tr>
    <td width="6%" align="right">Date</td>
    <td width="14%">
        <div id="datess" name="datess" value='<s:property value="datess"/>'></div>
    </td>

    <td width="21%" align="right">Doc No</td>
    <td width="32%">
        <input type="text" name="docnoss" id="docnoss"
        value='<s:property value="docnoss"/>'>
    </td>

    <td width="27%" align="center" rowspan="2">
        <input type="button" name="searchs" id="searchs"
        class="myButton" value="Search" onclick="loadSearchs()">
    </td>
</tr>

<tr>
    <td align="right">Account</td>
    <td>
        <input type="text" name="accountss" id="accountss"
        value='<s:property value="accountss"/>'>
    </td>

    <td align="right">Account Name</td>
    <td>
        <input type="text" name="accnamess" id="accnamess"
        value='<s:property value="accnamess"/>'>
    </td>
</tr>

<tr>
    <td align="right">Type</td>
    <td>
        <select name="reftypess" id="reftypess">
            <option value="">--select--</option>
            <option value="DIR">DIR</option>
            <option value="VPR">VPR</option>
        </select>
    </td>

    <td colspan="3"></td>
</tr>

<tr>
<td colspan="5">
<div id="refreshdivs">
<jsp:include page="submasterSearch.jsp" />
</div>
</td>
</tr>

</table>

</div>
</body>
</html>