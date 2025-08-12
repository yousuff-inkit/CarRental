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

</script>
</head>
<body onload="" bgcolor="white">
<div id="mainBG" class="homeContent" data-type="background">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 
<form>
 <div style="background-color:white;">
<table width="100%" class="normaltable" border="0">
  <tr>
    <td width="30%" rowspan="7"><img src="<%=contextPath%>/icons/epic.jpg" width="200" height="78"  alt=""/></td>
    <td width="45%" rowspan="2">&nbsp;</td>
     </tr>
  
 
  <tr>
    <td rowspan="1"  align="center"><b><font size="3"><label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label></font></b></td>
    
    </tr>
  <tr>
  <td colspan="1" align="right"> </td>
   <td colspan="2" align="center"><b>TRN : </b> <label id="lblcomptrn" name="lblcomptrn" ><s:property value="lblcomptrn"/></label></b></td>
  </tr>
  
   <tr>
    <td colspan="3"></td></tr></table></div>

</form>
</div>

</body>
</html>
