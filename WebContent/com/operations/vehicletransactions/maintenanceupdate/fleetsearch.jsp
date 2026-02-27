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

 	function loadSearchs() {
 
 		var fleetno=document.getElementById("fleetno").value;
 		var regno=document.getElementById("regno").value;
 		var flnames=document.getElementById("flname").value;
 		var color=document.getElementById("color").value;
 		var group=document.getElementById("group").value;
 	
 		var flname = flnames.replace(/ /g, "%20");
		
	var aa="yes";
		getdata(fleetno,regno,flname,color,group,aa);
 

	}
	function getdata(fleetno,regno,flname,color,group,aa){
		
		 $("#refreshdivs").load('subvehinfo.jsp?fleetno='+fleetno+'&regno='+regno+'&flname='+flname+'&color='+color+'&group='+group+'&aa='+aa);

		}

	</script>
<style type="text/css">
#search table {
  border-collapse: separate;
  border-spacing: 15px 18px;  
}

td[align="right"] {
  font-weight: 600;
  font-size: 14px;
  color: #222;
}

input[type="text"] {
  font-weight: 600;
  font-size: 14px;
  padding: 8px 12px;
  width: 95%;                
  max-width: 100%;
  box-sizing: border-box;
}

tr {
  line-height: 1.6;
}


#btnsearch {
 font-weight: 700;
    font-size: 13px;
    width: 130px;
    height: 38px;
    padding: 8px 12px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
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

#btnsearch:hover {
  background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%);
  box-shadow: 0 4px 6px rgba(59, 130, 246, 0.3);
  transform: translateY(-1px);
</style>

<body>
<div id="search">
  <table width="100%">
    <tr>
      <td width="10%" align="right">Fleet</td>
      <td width="20%">
        <input type="text" name="fleetno" id="fleetno" value='<s:property value="fleetno"/>'>
      </td>
      <td width="10%" align="right">Reg No</td>
      <td width="20%">
        <input type="text" name="regno" id="regno" value='<s:property value="regno"/>'>
      </td>
      <td width="10%" align="right">Name</td>
      <td width="30%">
        <input type="text" name="flname" id="flname" value='<s:property value="flname"/>'>
      </td>
    </tr>
    <tr>
      <td align="right">Color</td>
      <td>
        <input type="text" name="color" id="color" value='<s:property value="color"/>'>
      </td>
      <td align="right">Group</td>
      <td>
        <input type="text" name="group" id="group" value='<s:property value="group"/>'>
      </td>
      <td>&nbsp;</td>
      <td align="left">
        <input type="button" name="btnsearch" id="btnsearch" value="Search" onclick="loadSearchs(); return false;">
      </td>
    </tr>
    <tr>
      <td colspan="6">
        <div id="refreshdivs">
          <jsp:include page="subvehinfo.jsp"></jsp:include> 
        </div>
      </td>
    </tr>
  </table>
</div>
</body>
</html>