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
	 $("#dr_DOB").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {
 		
 		var clientnamess=document.getElementById("Cl_name").value;
 		var mob=document.getElementById("Cl_mob").value;
 		var lcno=document.getElementById("dr_Licence").value;
 		var passno=document.getElementById("dr_Passport").value;
 		var nation=document.getElementById("dr_Nation").value;
 		var dob=document.getElementById("dr_DOB").value;
	
		
 		var clname = clientnamess.replace(/ /g, "%20");
		getdata(clname,mob,lcno,passno,nation,dob);
 

	}
	function getdata(clname,mob,lcno,passno,nation,dob){
		
		 $("#refreshdiv").load('clientinfo.jsp?clname='+clname+'&mob='+mob+'&lcno='+lcno+'&passno='+passno+'&nation='+nation+'&dob='+dob+'&id=1');
	
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
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 400; /* Regular weight */
  font-size: 14px;
  color: #222;
  white-space: nowrap;
}

input[type="text"] {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 400; /* Regular weight */
  font-size: 14px;
  padding: 8px 12px;
  width: 95%;                
  max-width: 100%;
  box-sizing: border-box;   
  border: 1px solid #bdc3c7;
  border-radius: 4px;
  background-color: #ffffff;
}

input[type="text"]:focus {
  border-color: #2563eb;
  outline: none;
}

#search tr {
  line-height: 1.6;
}

/* Master UI Gradient Button */
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

#refreshdiv {
    margin-top: 10px;
}
</style>

<body bgcolor="#ffffff">
<div id="search">
<table width="100%" border="0">
  <tr>
    <td width="10%" align="right">Name</td>
    <td width="30%">
        <input type="text" name="Cl_name" id="Cl_name" value='<s:property value="Cl_name"/>'>
    </td>
    <td width="10%" align="right">MOB</td>
    <td width="25%">
        <input type="text" name="Cl_mob" id="Cl_mob" value='<s:property value="Cl_mob"/>'>
    </td>
    <td width="25%" rowspan="3" align="center">
        <input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search" onclick="loadSearch();">
    </td>
  </tr>
  <tr>
    <td align="right">Licence#</td>
    <td>
        <input type="text" name="dr_Licence" id="dr_Licence" value='<s:property value="dr_Licence"/>'>
    </td>
    <td align="right">Passport#</td>
    <td>
        <input type="text" name="dr_Passport" id="dr_Passport" value='<s:property value="dr_Passport"/>'>
    </td>
  </tr>
  <tr>
    <td align="right">Nationality</td>
    <td>
        <input type="text" id="dr_Nation" name="dr_Nation" value='<s:property value="dr_Nation"/>'>
    </td>
    <td align="right">DOB</td>
    <td>
        <div id="dr_DOB" name="dr_DOB" value='<s:property value="dr_DOB"/>'></div>
        <input type="hidden" name="hiddr_DOB" id="hiddr_DOB" value='<s:property value="hiddr_DOB"/>'>
    </td>
  </tr>
  <tr>
    <td colspan="5">
        <div id="refreshdiv">
            <jsp:include page="clientinfo.jsp"></jsp:include> 
        </div>
    </td>
  </tr>
</table>
</div>
</body>
</html>