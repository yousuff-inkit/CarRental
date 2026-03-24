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
#search {
  background-color: #ffffff;
  padding: 5px;
}

#search table {
  border-collapse: separate;
  border-spacing: 12px 15px;  
  background-color: #ffffff;
}

#search td[align="right"] {
  font-weight: 700;
  font-size: 13px;
  color: #222;
  font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
  white-space: nowrap;
}

input[type="text"], select {
  font-weight: 600;
  font-size: 13px;
  padding: 4px 8px;
  width: 100%;                
  box-sizing: border-box;   
  border: 1px solid #ccc;
  border-radius: 3px;
  height: 28px;
}

#search tr {
  line-height: 1.2;
}

.myButton {
    font-weight: 700;
    font-size: 13px;
    width: 110px;
    height: 35px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%) !important;
    color: #ffffff !important;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    text-transform: uppercase;
    text-align: center;
}

.myButton:hover {
  background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%) !important;
}

#refreshdivs {
    margin-top: 10px;
    border-top: 1px solid #eee;
}
</style>

<body bgcolor="#ffffff">
<div id="search">
<table width="100%" border="0">
  <tr>
    <td width="10%" align="right">Date</td>
    <td width="20%">
        <div id="datess" name="datess" value='<s:property value="datess"/>'></div>
    </td>
    <td width="12%" align="right">Doc No</td>
    <td width="25%">
        <input type="text" name="docnoss" id="docnoss" value='<s:property value="docnoss"/>'>
    </td>
    <td width="20%" rowspan="2" align="center">
        <input type="button" name="searchs" id="searchs" class="myButton" value="Search" onclick="loadSearchs()">
    </td>
  </tr>
  <tr>
    <td align="right">Account</td>
    <td>
        <input type="text" name="accountss" id="accountss" value='<s:property value="accountss"/>'>
    </td>
    <td align="right">Account Name</td>
    <td>
        <input type="text" name="accnamess" id="accnamess" value='<s:property value="accnamess"/>'>
    </td>
  </tr>
  <tr>
    <td align="right">Type</td>
    <td>
        <select name="reftypess" id="reftypess">
            <option value="">--select--</option>
            <option value="DIR">DIR</option>
            <option value="VPO">VPO</option>
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