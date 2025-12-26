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
	 $("#txtdob").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {
 		
 		var clientid=document.getElementById("txtclientid").value;
 		var clname=document.getElementById("txtclientname").value;
 		var clientaccount=document.getElementById("txtclientsaccount").value;
 		var mob=document.getElementById("txtmobile").value;
 		var lcno=document.getElementById("txtlicence").value;
 		var driverid=document.getElementById("txtdriveridsearch").value;
 		var nation=document.getElementById("txtnation").value;
 		var dob=document.getElementById("txtdob").value;
		var check = 1;
		
 		getdata(clname,mob,lcno,clientid,driverid,nation,dob,clientaccount,check);
	}
 	
	function getdata(clname,mob,lcno,clientid,driverid,nation,dob,clientaccount,check){	
		 $("#refreshdiv").load('crmMainSearchGrid.jsp?clname='+clname.replace(/ /g, "%20")+'&mob='+mob+'&lcno='+lcno+'&clientid='+clientid+'&driverid='+driverid.replace(/ /g, "%20")+'&nation='+nation.replace(/ /g, "%20")+'&dob='+dob+'&clientaccount='+clientaccount+'&check='+check);
	}

	</script>
<style type="text/css">
/* Master UI Styles */
/* Table spacing and layout */
table {
  border-collapse: separate;
  border-spacing: 12px 15px; /* Standardized master gap */
}

/* Bold labels - Standardized to Master UI 14px Tahoma */
td[align="right"] {
  font-family: Tahoma, Geneva, sans-serif;
  font-size: 14px;
  font-weight: 700;
  color: #222;
}

/* Bold text inside inputs with Grey Borders */
input[type="text"] {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 600;
  font-size: 14px;
  padding: 8px 10px;
  max-width: 100%;
  box-sizing: border-box;
  /* Updated as per request: Grey border */
  border: 1px solid #bdc3c7; 
  border-radius: 4px;
  background-color: #ffffff;
}

/* Focus state for inputs */
input[type="text"]:focus {
  border-color: #95a5a6;
  outline: none;
}

/* Date field styling */
#txtdob {
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
  line-height: 1.6;
}
</style>

<body bgcolor="#FFFFFF">
<div id="search">
<table width="100%">
  <tr>
    <td width="6%" align="right">Client#</td>
    <td><input type="text" name="txtclientid" id="txtclientid" style="width:95%" value='<s:property value="txtclientid"/>'></td>
    <td width="4%" align="right">Name</td>
    <td colspan="3"><input type="text" name="txtclientname" id="txtclientname" style="width:100%" value='<s:property value="txtclientname"/>'></td>
    <td align="right">Account</td>
    <td><input type="text" name="txtclientsaccount" id="txtclientsaccount" style="width:99%" value='<s:property value="txtclientsaccount"/>'></td>
    <td colspan="2" align="center">
      <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch();">
    </td>
  </tr>
  <tr>
    <td align="right">Licence#</td>
    <td width="15%"><input type="text" name="txtlicence" id="txtlicence" style="width:95%" value='<s:property value="txtlicence"/>'></td>
    <td width="4%" align="right">Mob</td>
    <td width="17%"><input type="text" name="txtmobile" id="txtmobile" style="width:95%" value='<s:property value="txtmobile"/>'></td>
    <td width="5%" align="right">ID#</td>
    <td width="14%"><input type="text" name="txtdriveridsearch" id="txtdriveridsearch" style="width:95%" value='<s:property value="txtdriveridsearch"/>'></td>
    <td width="8%" align="right">Nationality</td>
    <td width="14%"><input type="text" id="txtnation" name="txtnation" style="width:100%" value='<s:property value="txtnation"/>'></td>
    <td width="6%" align="right">DOB</td>
    <td width="11%">
      <div id="txtdob" name="txtdob" value='<s:property value="txtdob"/>'></div>
      <input type="hidden" name="hidtxtdob" id="hidtxtdob" value='<s:property value="hidtxtdob"/>'>
    </td>
  </tr>
  <tr>
    <td colspan="10">
      <div id="refreshdiv">
        <jsp:include page="crmMainSearchGrid.jsp" />
      </div>
    </td>
  </tr>
</table>
</div>
</body>
</html>