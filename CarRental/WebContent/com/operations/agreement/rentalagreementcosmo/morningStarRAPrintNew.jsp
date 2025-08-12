<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();
String outdate=request.getParameter("printdate");
String outtime=request.getParameter("printtime");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style type="text/css">
 body,label {
    font-size: 0.88em;
} 
.header{
	width:100%;
	height:100px;
	display:block;
}
table tr td,table{
	border-collapse:collapse;
	cell-spacing:0;
	cell-padding:0;
	/* border:1px solid #000; */
}

</style>
</head>
<body>
<form id="frmInvoicePrint" action="printrental" autocomplete="off" target="_blank">
<div class="header"></div>
<table width="100%" border="0">
  <tr>
    <td width="23%" height="25" align="center" style="font-size:10px;"><b><label><s:property value="barnchval"/></label></b></td>
    <td width="58%" align="center">&nbsp;</td>
    <td width="19%" align="center" style="font-size:10px;"><b><label><s:property value="rentaldoc"/></label></b></td>
  </tr>
</table>
<table width="100%" border="0">
  <tr>
    <td width="67%"><table width="100%" border="0">
      <tr>
        <td width="22%" height="50">&nbsp;</td>
        <td colspan="3"><b><label style="position:absolute;padding-top:5px;font-size:10px;"><s:property value="clname"/></label></b></td>
        <td width="21%">&nbsp;</td>
      </tr>
      <tr>
        <td  width="22%" height="50">&nbsp;</td>
        <td colspan="3"><b><label style="position:absolute;padding-top:5px;font-size:10px;"><s:property value="radrname"/></label></b></td>
        <td width="21%">&nbsp;</td>
      </tr>
      <tr>
        <td colspan="2">&nbsp;</td>
        <td colspan="2"><b><label style="font-size:10px;"><s:property value="claddress"/></label></b></td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td colspan="2"><b><label style="font-size:10px;"><s:property value="clmobno"/></label></b></td>
        <td width="21%">&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td colspan="2">&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td height="30"  colspan="2"><b><label style="position:absolute;padding-top:5px;font-size:10px;padding-left:12px;"><s:property value="radlno"/></label></b></td>
        <td width="17%" ><b><label style="position:absolute;padding-top:5px;font-size:10px;"><s:property value="lblissby"/></label></b></td>
        <td width="21%" ><b><label style="position:absolute;padding-top:5px;font-size:10px;"><s:property value="lblissfromdate"/></label></b></td>
        <td ><b><label style="position:absolute;padding-top:5px;font-size:10px;"><s:property value="licexpdate"/></label></b></td>
      </tr>
      <tr>
        <td height="30" colspan="2" ><b><label style="position:absolute;padding-top:5px;font-size:10px;padding-left:12px;" ><s:property value="passno"/></label></b></td>
        <td>&nbsp;</td>
        <td ><b><label style="position:absolute;padding-top:5px;font-size:10px;"><s:property value="passexpdate"/></label></b></td>
        <td ><b><label style="position:absolute;padding-top:5px;font-size:10px;"><s:property value="dobdate"/></label></b></td>
      </tr>
      <tr>
        <td height="30" colspan="3" ><b><label style="position:absolute;padding-top:5px; padding-left:10px; margin-top:-2px;font-size:12px;padding-left:12px;" ><s:property value="lblnation"/></label></b></td>
        <td colspan="2">&nbsp;</td>
        </tr>
      <tr>
        <td height="30">&nbsp;</td>
        <td colspan="3"><b><label style="font-size:10px;"><s:property value="adddrname1"/></label></b></td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td height="30" colspan="2"><b><label style="font-size:10px;"><s:property value="addlicno1"/></label></b></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td><b><label style="font-size:10px;"><s:property value="expdate1"/></label></b></td>
      </tr>
    </table>
      <table width="100%" border="0">
        <tr>
          <td height="656">&nbsp;</td>
        </tr>
    </table></td>
    <td width="33%"><table width="100%" border="0">
      <tr>
        <td width="50%" height="50" valign="bottom"><b><label  style="padding-top:25px;margin-left:-30px;font-size:10px;padding-left:12px;"><s:property value="ravehname"/></label></b></td>
        <td width="50%" valign="bottom"><b><label style="font-size:10px;"><s:property value="ravehregno"/></label></b></td>
      </tr>
      <tr>
        <td height="30"><b><label style="font-size:10px;"><s:property value="racolor"/></label></b></td>
        <td style="padding-left:20px;font-size:10px;"><b><label><s:property value="rayom"/></label></b></td>
      </tr>
      <tr>
        <td height="30" style="padding-left:10px;font-size:10px;" ><b><label><s:property value="raklmout"/></label></b></td>
        <td style="padding-top:25px;font-size:10px;"><b><label><%=outdate%>&nbsp;<%=outtime%></label></b></td>
      </tr>
      <tr>
        <td height="30">&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td height="30">&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table>
      <table width="100%" border="0">
        <tr>
          <td width="70%" height="25">&nbsp;</td>
          <td width="30%" style="padding-top:10px;padding-left:5px;">
		  	<% if(request.getAttribute("rarenttypes").toString().equalsIgnoreCase("daily")){ %>
				<b><label style="font-size:10px;"><s:property value="tariff"/></label></b>
				
 			<%} %>
 			
 		</td>
        </tr>
        <tr>
          <td height="25">&nbsp;</td>
          <td style="padding-bottom:20px;font-size:10px;"><% if(request.getAttribute("rarenttypes").toString().equalsIgnoreCase("weekly")){ %>
				<b><label><s:property value="tariff"/></label></b>
 			<%} %>
 			
          </td>
        </tr>
        <tr>
          <td height="25">&nbsp;</td>
          <td>
          <% if(request.getAttribute("rarenttypes").toString().equalsIgnoreCase("monthly")){ %>
				<b><label style="font-size:10px;"><s:property value="tariff"/></label></b>
 			<%} %>
 			
          </td>
        </tr>
        <tr>
          <td height="20">&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="20">&nbsp;</td>
          <td><b><label style="font-size:10px;"><s:property value="laldelcharge"/></label></b></td>
        </tr>
        <tr>
          <td height="20">&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="20">&nbsp;</td>
          <td><b><label style="font-size:10px;"><s:property value="racdwscdw"/></label></b></td>
        </tr>
        <tr>
          <td height="20">&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="25">&nbsp;</td>
          <td><b><label style="position:absolute;padding-top:10px;font-size:10px;"><s:property value="raexxtakmchg"/></label></b></td>
        </tr>
        <tr>
          <td height="20">&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="20">&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="20">&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="20">&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="20">&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="20">&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="20">&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="199">&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td height="59">&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
    </table></td>
  </tr>
</table>
</form>
</body>
</html>