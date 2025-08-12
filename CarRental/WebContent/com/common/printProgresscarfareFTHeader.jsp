<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<!--<link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/body.css">-->
<script>
$(document).ready(function(){
if(document.getElementById("lblcomplogo").value!=""){
	  var cpath = '<%=contextPath%>';
	  document.getElementById('lblcomplogos').src =cpath+"/"+document.getElementById("lblcomplogo").value;
}
});
</script>
</head>
<body onload="" bgcolor="white">
<div id="mainBG" class="homeContent" data-type="background">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 
<form>
 <div style="background-color:white;">
 
 <table width="100%" class="normaltable" border="0">
 
  <tr>
 <td width="30%" rowspan="7">
	 <img id="lblcomplogos" src="<%=contextPath%>/icons/epic.jpg" width="100%"  alt=""/><input type="hidden" id="lblcomplogo" name="lblcomplogo"  value='<s:property value="lblcomplogo"/>'></td>
	
 
  <td rowspan="7" align="center">
  <table width="100%"><tr><td align="center"><font size="4"><label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label></font></td></tr>
  <tr> <td rowspan="2" align="center"><b><font size="2"><label id="lblprintname1" name="lblprintname1"><s:property value="lblprintname1"/></label></font></b></td></tr>
    </table></td>
 
  <td width="28%" >
  <table width="100%" border="0">
  <tr><td><font size="2"><label id="lblcompname" name="lblcompname" ><s:property value="lblcompname"/></label></font></td></tr>
  <tr><td><b><label id="lblcompaddress" name="lblcompaddress"><s:property value="lblcompaddress"/></label></b></td></tr>
  <tr><td align="left"><b>Tel :</b>&nbsp;<label id="lblcomptel" name="lblcomptel"><s:property value="lblcomptel"/></label></td></tr>
  <tr><td align="left"><b>Fax :</b>&nbsp;<label name="lblcompfax" id="lblcompfax" ><s:property value="lblcompfax"/></label></td></tr>
  <tr><td align="left"><b>Branch :</b>&nbsp;<label id="lblbranch" name="lblbranch" ><s:property value="lblbranch"/></label></td></tr>
  <tr><td align="left"><b>Location :</b>&nbsp;<label id="lbllocation" name="lbllocation" ><s:property value="lbllocation"/></label></td></tr>
  <tr><td align="left"><b>TRN :</b>&nbsp;<label id="lblcomptrn" name="lblcomptrn" ><s:property value="lblcomptrn"/></label></td></tr>
  </table ></td></tr>
  </table>
<tr><td colspan="3"><hr noshade size=1 width="100%"></td>
    <td colspan="3"></td></tr>
 



</div>

</form>
</div>

</body>
</html>
