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
 		var stag=document.getElementById("stag").value;
 		var pcode=document.getElementById("plcode").value;
 	
 		var flname = flnames.replace(/ /g, "%20");
		
	var aa="yes";
		getdata(fleetno,regno,flname,stag,pcode,aa);
 

	}
	function getdata(fleetno,regno,flname,stag,pcode,aa){
		
		 $("#refreshdivs").load('subperfleetSearch.jsp?fleetno='+fleetno+'&regno='+regno+'&flname='+flname+'&stag='+stag+'&pcode='+pcode+'&aa='+aa);

		}

	</script>
<style type="text/css">
/* Master UI Styles */

table {
  border-collapse: separate;
  border-spacing: 15px 18px; /* Consistent master gap */
}


td[align="right"] {
  font-weight: 700;
  font-size: 14px;
  color: #222;
  font-family: Tahoma, Arial, sans-serif;
}


input[type="text"] {
  font-weight: 600;
  font-size: 14px;
  padding: 8px 12px;
  width: 95%; 
  max-width: 100%;
  box-sizing: border-box; 
  font-family: Tahoma, Arial, sans-serif;
}

/* Master Button Appearance */
.myButton {
  font-weight: 700;
  font-size: 14px;
  background-color: #4CAF50; /* Master green */
  color: white;
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  box-shadow: 0 2px 5px rgba(0,0,0,0.2);
  transition: background-color 0.3s;
  font-family: Tahoma, Arial, sans-serif;
}

/* Button Hover Effects */
.myButton:hover {
  background-color: #45a049;
}

/* Additional spacing for rows */
tr {
  line-height: 1.8;
}
</style>

<body bgcolor="#E0ECF8">
<div id="search">
  <table width="100%">
    <tr>
      <td>
        <table width="100%">
          <tr>
            <td align="right" width="10%">Fleet</td> 
            <td align="left" width="23%">
              <input type="text" name="fleetno" id="fleetno" style="width:90%;" value='<s:property value="fleetno"/>'>
            </td>
            <td align="right" width="10%">Reg No</td>
            <td align="left" width="23%">
              <input type="text" name="regno" id="regno" value='<s:property value="regno"/>'>
            </td>
            <td align="right" width="10%">Name</td>
            <td align="left" width="24%">
              <input type="text" name="flname" style="width:90%;" id="flname" value='<s:property value="flname"/>'>
            </td>
          </tr>
        </table>
      </td>
    </tr>

    <tr>
      <td>
        <table width="100%">
          <tr>
            <td align="right" width="10%">SALIK TAG</td>
            <td align="left" width="23%">
              <input type="text" name="stag" style="width:90%;" id="stag" value='<s:property value="stag"/>'>
            </td>
            <td align="right" width="10%">PLATE CODE</td>
            <td align="left" width="23%">
              <input type="text" name="plcode" id="plcode" value='<s:property value="plcode"/>'>
            </td>
            <td align="right" width="10%">&nbsp;</td>
            <td align="left" width="24%">
              <input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search" onclick="loadSearchs();">
            </td>
          </tr>
        </table>
      </td>
    </tr>

    <tr>
      <td colspan="8">
        <div id="refreshdivs">
          <jsp:include page="subperfleetSearch.jsp" />
        </div>
      </td>
    </tr>
  </table>
</div>
</body>
</html>
