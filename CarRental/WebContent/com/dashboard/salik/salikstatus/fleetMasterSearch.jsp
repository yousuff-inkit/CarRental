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
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<style>
.textdetail {
	color: black;
	background-color: #E0ECF8;
	width: 100%;
	font-family: Tahoma;
	font-size: 10px;
}
</style>

	<script type="text/javascript">

 	function funFleetSearch() {
 		
 		var flname=document.getElementById("sflname").value;
 		var fleetno=document.getElementById("sfleetno").value;
 		var regno=document.getElementById("sregno").value;
 		$('#fleetsearchdiv').load('fleetSearchGrid.jsp?flname='+flname+'&fleetno='+fleetno+'&regno='+regno+'&id=1');

	}
 	
 
	</script>
	<body bgcolor="#E0ECF8">
		<div id=search>
			<table width="100%" >
	  			<tr>
	   				<td align="left" width="6.5%"><label class="textdetail">Fleet Name</label></td>
	    			<td align="left" width="54%"><input type="text" name="sflname" id="sflname"  style="width:96.5%;height:20px;" value='<s:property value="sflname"/>'></td>
	    			<td align="right"><label class="textdetail">Fleet No</label></td>
	    			<td align="left"><input type="text" name="sfleetno" id="sfleetno" style="height:20px;" value='<s:property value="sfleetno"/>'></td>
	      			<td align="right" width="10%"><label class="textdetail">Reg No</label></td>
	    			<td align="left"><input type="text" id="sregno" name="sregno" style="height:20px;" value='<s:property value="sregno"/>'></td>
	    			<td align="center"><input type="button" name="btnfleetsearch" id="btnfleetsearch" value="Search" onclick="funFleetSearch();" class="myButton"></td>
	    		<tr>
	  			<tr><td colspan="7"><div id="fleetsearchdiv"><jsp:include  page="fleetSearchGrid.jsp"></jsp:include></div></td></tr>
			</table>
	  	</div>
	</body>
</html>