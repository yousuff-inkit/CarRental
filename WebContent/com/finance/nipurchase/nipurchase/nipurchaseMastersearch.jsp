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
 		var desc=document.getElementById("description").value;
 		var description=desc.replace(/ /g, "%20");
 		var accnamess = accnamesss.replace(/ /g, "%20");

		
	var aa="yes";
		getdata(docnoss,accountss,accnamess,datess,reftypess,aa,description);
 

	}
	function getdata(docnoss,accountss,accnamess,datess,reftypess,aa,description){
		
		 $("#refreshdivs").load('submasterSearch.jsp?docnoss='+docnoss+'&accountss='+accountss+'&accnamess='+accnamess+'&datess='+datess+'&reftypess='+reftypess+'&aa='+aa+'&description='+description);

		}

	</script>
	<style type="text/css">
/* Master UI Styles */
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
  white-space: nowrap;
}

/* Bold text inside inputs and selects with Grey Borders */
input[type="text"], select {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 600;
  font-size: 14px;
  padding: 8px 10px;
  max-width: 100%;
  box-sizing: border-box;
  border: 1px solid #bdc3c7; /* Grey border */
  border-radius: 4px;
  background-color: #ffffff;
}

/* Focus state for inputs */
input[type="text"]:focus, select:focus {
  border-color: #007bff;
  outline: none;
}

/* Specifically adjust jqxDateTimeInput styling */
#datess {
  font-family: Tahoma, Geneva, sans-serif !important;
  font-weight: 600 !important;
  font-size: 14px !important;
}

/* Master Button Appearance */
.myButton {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 700;
  font-size: 14px;
  background-color: #007bff; /* Blue Button Color */
  color: white;
  padding: 8px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  transition: none;
}

/* No color change on hover as requested */
.myButton:hover {
  background-color: #007bff; 
  cursor: pointer;
}

/* Row spacing */
tr {
  line-height: 1.6;
}
</style>

<body bgcolor="#FFFFFF">
<div id="search">
<table width="100%">
  <tr>
    <td align="right" width="6%">Doc No</td>
    <td width="20%"><input type="text" name="docnoss" id="docnoss" style="width:100%;" value='<s:property value="docnoss"/>'></td>
    
    <td align="right" width="8%">Account</td>
    <td width="20%"><input type="text" name="accountss" id="accountss" style="width:100%;" value='<s:property value="accountss"/>'></td>
    
    <td align="right" width="10%">Account Name</td>
    <td width="30%"><input type="text" name="accnamess" id="accnamess" style="width:100%;" value='<s:property value="accnamess"/>'></td>
  </tr>

  <tr>
    <td align="right">Date</td>
    <td><div id="datess" name="datess" value='<s:property value="datess"/>'></div></td>
    
    <td align="right">Description</td>
    <td><input type="text" name="description" id="description" style="width:100%;" value='<s:property value="description"/>'></td>
    
    <td align="right">Type</td>
    <td>
      <table width="100%" cellpadding="0" cellspacing="0" border="0">
        <tr>
          <td width="60%">
            <select name="reftypess" id="reftypess" style="width:100%;" value='<s:property value="reftypess"/>'>
              <option value="">--select--</option>
              <option value="DIR">DIR</option>
              <option value="NPO">NPO</option>
            </select>
          </td>
          <td width="40%" align="right">
            <input type="button" name="searchs" id="searchs" class="myButton" value="Search" onclick="loadSearchs()">
          </td>
        </tr>
      </table>
    </td>
  </tr>

  <tr>
    <td colspan="6">
      <div id="refreshdivs">
        <jsp:include page="submasterSearch.jsp" />
      </div>
    </td>
  </tr>
</table>
</div>
</body>
</html>