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
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr >
   <td>
<%--    <table  width="100%"  border="1">
   <tr>
    <td align="right" width="8%">Name</td>
    <td align="left" width="60%" colspan="4"><input type="text" name="SCl_name" id="SCl_name"  style="width:96.5%;" value='<s:property value="SCl_name"/>'></td>
    <td align="right">MOB</td>
    <td align="left"><input type="text" name="Sl_mob" id="Sl_mob" value='<s:property value="Sl_mob"/>'></td>
      <td align="right">MRA</td>
    <td align="left"><input type="text" id="smra" name="smra" value='<s:property value="smra"/>'> </td>
    <tr>
     
  <tr>
 
     <td align="left" width="8">Doc NO</td>
    <td align="left" width="20%"><input type="text" name="rno" id="rno" value='<s:property value="rno"/>'>

    <td align="right" width="20%">Fleet NO</td>
    
    <td align="left" width="20%"><input type="text" name="flno" id="flno" style="width:96.5%;" value='<s:property value="flno"/>'></td>
    <td align="right" width="20%">Reg NO</td>
    <td align="left" width="20%"><input type="text" id="sregno" name="sregno" value='<s:property value="sregno"/>'></td>
    
    <td  align="center" width="20%" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="mbtnrasearch" id="mbtnrasearch" class="myButton" value="Search"  onclick="mainloadSearch();"></td>
  </tr>
  </table> --%>
     <table  width="100%">
   <tr>
    <td align="right" width="7px">Name</td>
    <td align="left" width="25px"><input type="text" name="SCl_name" id="SCl_name"  style="width:99%;" value='<s:property value="SCl_name"/>'></td>
    <td align="right" width="7px">MOB</td>
    <td align="left" width="7px"><input type="text" name="Sl_mob" id="Sl_mob" value='<s:property value="Sl_mob"/>'></td>
      <td width="7px" align="right">MRA</td>
    <td width="10px" align="left"><input type="text" id="smra" name="smra" value='<s:property value="smra"/>'> </td>
          <td width="5px" align="right"><input type="checkbox" id="branch_chk"  name="branch_chk" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" ></td>
    <td width="5px" align="left">All Branch </td>
    <td align="left" width="5px"> <input type="button" name="mbtnrasearch" id="mbtnrasearch" class="myButton" value="Search"  onclick="mainloadSearch();"></td>
    <tr>
     
  <tr>
 
     <td  align="right" width="7px">Doc NO</td>
    <td align="left" width="25px"><input type="text" name="rno" id="rno" value='<s:property value="rno"/>'>
    <td align="right" width="7px">Fleet NO</td>
    <td align="left" width="10px"><input type="text" name="flno" id="flno" style="width:96.5%;" value='<s:property value="flno"/>'></td>
    <td align="right" width="7px">Reg NO</td>
    <td align="left" width="10px"><input type="text" id="sregno" name="sregno" value='<s:property value="sregno"/>'></td>
    <td align="right" width="7px">LPO#</td>
    <td align="left" width="10px" colspan="2"><input type="text" name="lponumber" id="lponumber" style="width:96.5%;" value='<s:property value="lponumber"/>'></td>
       </tr>
  </table>
  </td>

  <tr>
    <td colspan="8" align="right">
    
    <div id="srefreshdiv">
      
   <jsp:include  page="submainSearch.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>