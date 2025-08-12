 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <!--    <jsp:include page="../../../../includes.jsp"></jsp:include>   -->
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
</style>
	<script type="text/javascript">

 	function loadSearchs() {
 		var aa="yes";

 		var documentno=document.getElementById("documentno").value;
 		var regno=document.getElementById("regno").value;
 		var fleetno=document.getElementById("fleetno").value; 	
 		var name = document.getElementById("name").value;
 		name=name.replace(/ /g, "%20");
			 	 getdata(documentno,fleetno,regno,name,aa);
 	}
	function getdata(documentno,fleetno,regno,name,aa){
		 $("#refreshdivs").load('masterSearchGrid.jsp?fleetno='+fleetno+'&regno='+regno+'&name='+name+'&documentno='+documentno+'&aa='+aa);

		}

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr >
   <td>
   <table >
   <tr>
    <td align="right" width="14%">DOC NO</td> 
    <td align="left" ><input type="text" name="documentno" id="documentno"  style="" value='<s:property value="documentno"/>'></td>
    <td align="right" width="14%">FLEET NO</td>
    <td align="left"><input type="text" name="fleetno" id="fleetno" value='<s:property value="fleetno"/>'></td>
    <td align="right" width="14%">REG NO</td>
    <td align="left"><input type="text" name="regno" id="regno" value='<s:property value="regno"/>'></td>   
  
    <tr>
    </table>
    </td>
  </tr>
  <tr>
   <td>
  <table >
  <tr>
 <!--   <td align="right" width="6%">Test</td>
    <td align="left" ><input type="text" name="color"  style="width:90%;" id="color" value='<s:property value="color"/>'>
    <td align="right" width="14%">Group</td>
    <td align="left"><input type="text" name="group" id="group" value='<s:property value="group"/>'></td>
    <td align="right"  width="14%">&nbsp;</td> -->
     <td align="right"  width="22%">NAME</td>
    <td align="left"  width="0%"><input type="text" name="name" style="" id="name" value='<s:property value="name"/>'></td>
    
    <td align="left"  width="30%"><input type="button" style="margin-left:32px" name="btnrasearch" id="btnrasearch" class="myButton" value="Search"  onclick="loadSearchs();"></td>
  </tr>
  </table>
  </td>

  <tr>
    <td colspan="8" align="right">
    
    <div id="refreshdivs">
      
 <jsp:include  page="masterSearchGrid.jsp"></jsp:include>
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>