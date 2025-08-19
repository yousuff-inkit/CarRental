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
    <td width="25%"><font size="2"><label id="lblcompname" name="lblcompname" >Al Sayara Limousine Passengers Transport LLC</label></font></td>
  </tr>
  <tr>
<%--      <td align="left" width="25%"><font size="2"><b>PO Box :</b>&nbsp;<label id="lblcomppbno" name="lblcomppbno"><s:property value="lblcomppbno"/></label> </font></td> --%>
     <td align="left" width="25%"><font size="2"><b>PO Box :</b>&nbsp;<label id="lblcomppbno" name="lblcomppbno">3393</label> </font></td>
  </tr>
  <tr>
    <td rowspan="3" align="center"><font size="4"><label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label></font></td>
<%--       <td><label id="lblcompaddress" name="lblcompaddress"><s:property value="lblcompaddress"/></label></td> --%>
      <td><b>Address :</b>&nbsp<label id="lblcompaddress" name="lblcompaddress">Tower 400 and 6th Floor, Ibrahim Mohammed Al Madfaa Street (Al Mina Road), Al Soor, Sharjah, United Arab Emirates</label></td>
  </tr>
  <tr>
    <td align="left"><b>Tel :</b>&nbsp;<label id="lblcomptel" name="lblcomptel">600522200</label></td>
  </tr>
  <tr>
   <%--  <td align="left"><b>Email :</b>&nbsp;<label name="lblcompfax" id="lblcompfax" ><s:property value="lblcompfax"/></label></td> --%>
    <td align="left"><b>Email :</b>&nbsp;<label name="lblcompemail" id="lblcompemail" >info@sayararental.com</label></td>
  </tr>
  <tr>
    <td rowspan="2" align="center"><b><font size="2"><label id="lblprintname1" name="lblprintname1"><s:property value="lblprintname1"/></label></font></b></td>
    <td align="left"><b>Branch :</b>&nbsp;<label id="lblbranch" name="lblbranch" ><s:property value="lblbranch"/></label></td>
  </tr>
  <tr>
    <td align="left"><b>Location :</b>&nbsp;<label id="lbllocation" name="lbllocation" ><s:property value="lbllocation"/></label></td>
  </tr>
  <tr>
  	<td>&nbsp;</td>
  	<td>&nbsp;</td>
    <td align="left"><b>TRN :</b>&nbsp;<label id="lblcomptrn" name="lblcomptrn" ><s:property value="lblcomptrn"/></label></td>
  </tr>
  <tr>
    <td colspan="3"><hr noshade size=1 width="100%"></td>
  </tr>
   <tr>
    <td colspan="3"></td></tr></table></div>

</form>
</div>

</body>
</html>
