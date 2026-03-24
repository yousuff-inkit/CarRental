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



	<script type="text/javascript">
	$(document).ready(function () {
	
	}); 

 	function mainloadSearch() {
 		
 		var sclnames=document.getElementById("SCl_name").value;
 		var smob=document.getElementById("Sl_mob").value;
 		var rno=document.getElementById("rno").value;
 		var flno=document.getElementById("flno").value;
 		var sregno=document.getElementById("sregno").value;
 		var smra=document.getElementById("smra").value;
 		var lponumber=document.getElementById("lponumber").value;
	
 		var sclname = sclnames.replace(/ /g, "%20");
 		
 		var branch_chk=document.getElementById("branch_chk").value;
 		
 		 $("#srefreshdiv").load('submainSearch.jsp?sclname='+sclname+'&smob='+smob+'&rno='+rno+'&flno='+flno+'&sregno='+sregno+'&smra='+smra+'&lponumber='+lponumber+'&branch_chk='+branch_chk);
 		

	}
	 
	</script>

<style type="text/css">
#search {
background-color: #ffffff;
padding: 2px;
}
#search table {
border-collapse: separate;
border-spacing: 8px 10px;

background-color: #ffffff;
}
#search td[align="right"] {
font-weight: 700;
font-size: 13px;
color: #222;
font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
white-space: nowrap;
}
input[type="text"] {
font-weight: 600;
font-size: 13px;
padding: 4px 8px;
width: 100%;

box-sizing: border-box;

border: 1px solid #ccc;
border-radius: 2px;
height: 28px;
}
#search tr {
line-height: 1;
}
.myButton {
font-weight: 700;
font-size: 13px;
width: 110px;
height: 32px;
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
.chk-label {
font-size: 12px;
font-weight: 700;
vertical-align: middle;
}
</style>

<body bgcolor="#ffffff">
<div id="search">
<table width="100%" border="0">
<tr>
<td width="8%" align="right">Name</td>
<td width="22%"><input type="text" name="SCl_name" id="SCl_name" value='<s:property value="SCl_name"/>'></td>
<td width="8%" align="right">MOB</td>
<td width="20%"><input type="text" name="Sl_mob" id="Sl_mob" value='<s:property value="Sl_mob"/>'></td>
<td width="8%" align="right">MRA</td>
<td width="18%"><input type="text" id="smra" name="smra" value='<s:property value="smra"/>'></td>
<td width="16%" rowspan="2" align="center">
<input type="button" name="mbtnrasearch" id="mbtnrasearch" class="myButton" value="Search" onclick="mainloadSearch();">
</td>
</tr>
<tr>
<td align="right">Doc NO</td>
<td><input type="text" name="rno" id="rno" value='<s:property value="rno"/>'></td>
<td align="right">Fleet NO</td>
<td><input type="text" name="flno" id="flno" value='<s:property value="flno"/>'></td>
<td align="right">Reg NO</td>
<td><input type="text" id="sregno" name="sregno" value='<s:property value="sregno"/>'></td>
</tr>
<tr>
<td align="right">LPO#</td>
<td><input type="text" name="lponumber" id="lponumber" value='<s:property value="lponumber"/>'></td>
<td align="right">Options</td>
<td colspan="4">
<input type="checkbox" id="branch_chk" name="branch_chk" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)">
<span class="chk-label">All Branch</span>
</td>
</tr>
<tr>
<td colspan="7">
<div id="srefreshdiv">
<jsp:include page="submainSearch.jsp"></jsp:include>
</div>
</td>
</tr>
</table>
</div>
</body>
</html>