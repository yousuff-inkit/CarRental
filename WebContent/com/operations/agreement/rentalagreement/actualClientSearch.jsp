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
	 $("#searchclientdob").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function funClientSearch() {
 		
 		var clientnamess=document.getElementById("searchclientname").value;
 		var mob=document.getElementById("searchclientmobile").value;
 		var lcno=document.getElementById("searchclientlicense").value;
 		var passno=document.getElementById("searchclientpassport").value;
 		var nation=document.getElementById("searchclientnation").value;
 		var dob=document.getElementById("searchclientdob").value;
		var catdocno=$('#catdocno').val();
		
 		var clname = clientnamess.replace(/ /g, "%20");
		getdata(clname,mob,lcno,passno,nation,dob,catdocno);
 

	}
	function getdata(clname,mob,lcno,passno,nation,dob,catdocno){
		
		 $("#clientsearchdiv").load('actualClientSearchGrid.jsp?clname='+clname+'&mob='+mob+'&lcno='+lcno+'&passno='+passno+'&nation='+nation+'&dob='+dob+'&id=1&catdocno='+catdocno);
	
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

#clientsearchdiv {
    margin-top: 10px;
}
</style>

<body bgcolor="#ffffff">
<div id="search">
<table width="100%" border="0">
  <tr>
    <td width="10%" align="right">Name</td>
    <td width="30%">
        <input type="text" name="searchclientname" id="searchclientname" value='<s:property value="searchclientname"/>'>
    </td>
    <td width="10%" align="right">MOB</td>
    <td width="25%">
        <input type="text" name="searchclientmobile" id="searchclientmobile" value='<s:property value="searchclientmobile"/>'>
    </td>
    <td width="25%" rowspan="3" align="center">
        <input type="button" name="btnclientsearch" id="btnclientsearch" class="myButton" value="Search" onclick="funClientSearch();">
    </td>
  </tr>
  <tr>
    <td align="right">Licence#</td>
    <td>
        <input type="text" name="searchclientlicense" id="searchclientlicense" value='<s:property value="searchclientlicense"/>'>
    </td>
    <td align="right">Passport#</td>
    <td>
        <input type="text" name="searchclientpassport" id="searchclientpassport" value='<s:property value="searchclientpassport"/>'>
    </td>
  </tr>
  <tr>
    <td align="right">Nationality</td>
    <td>
        <input type="text" id="searchclientnation" name="searchclientnation" value='<s:property value="searchclientnation"/>'>
    </td>
    <td align="right">DOB</td>
    <td>
        <div id="searchclientdob" name="searchclientdob" value='<s:property value="searchclientdob"/>'></div>
    </td>
  </tr>
  <tr>
    <td colspan="5">
        <div id="clientsearchdiv">
            <jsp:include page="actualClientSearchGrid.jsp"></jsp:include> 
        </div>
    </td>
  </tr>
</table>
</div>
</body></html>