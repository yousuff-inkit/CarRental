 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%> 
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

	<script type="text/javascript">
		$(document).ready(function () {
			$("#msearchdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
		});
	
 		function mainloadSearch() {
 		
 			var date=$('#msearchdate').jqxDateTimeInput('val');
 			var fleetno=document.getElementById("msearchfleetno").value;
 			var docno=document.getElementById("msearchdocno").value;
			var flname=document.getElementById("msearchflname").value;
 			var brhid=document.getElementById("brchName").value;
			$('#msearchdiv').load('masterSearchGrid.jsp?date='+date+'&fleetno='+fleetno+'&docno='+docno+'&flname='+flname+'&id=1&brhid='+brhid);
		}

	</script>
	<style type="text/css">
/* Master UI Table Container */
#search table {
  border-collapse: separate;
  border-spacing: 15px 18px; /* Standard master gap */
  width: 100%;
}

/* Label Styling */
td[align="right"] {
  font-family: Tahoma, Arial, sans-serif;
  font-size: 14px;
  font-weight: 700;
  color: #222;
}

/* Input & Select Field Styling */
input[type="text"], select {
  font-family: Tahoma, Arial, sans-serif;
  font-weight: 600;
  font-size: 14px;
  padding: 8px 12px;
  width: 95%;
  max-width: 100%;
  box-sizing: border-box; /* Include padding in width */
}

/* Specific styling for Fleet Name to ensure 98% width */
#msearchflname {
  width: 98% !important;
}

/* Date Picker Container */
#msearchdate {
  font-family: Tahoma, Arial, sans-serif;
  font-weight: 600;
  font-size: 14px;
}

/* Master Button Appearance */
.myButton {
  font-family: Tahoma, Arial, sans-serif;
  font-weight: 700;
  font-size: 14px;
  background-color: #007bff; /* Master Blue */
  color: #ffffff;
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  box-shadow: 0 2px 5px rgba(0,0,0,0.2);
  transition: background-color 0.3s;
  min-width: 90px;
}

/* Master Green Hover Effect */
.myButton:hover {
  background-color: #45a049;
}

/* Row Spacing */
tr {
  line-height: 1.8;
}
</style>

<body bgcolor="#E0ECF8">
    <div id="search">
        <table border="0">
            <tr>
                <td width="12%" align="right">Doc No</td>
                <td width="14%" align="left">
                    <input type="text" name="msearchdocno" id="msearchdocno">
                </td>
                <td width="7%" align="right">Date</td>
                <td width="13%" align="left">
                    <div id="msearchdate" name="msearchdate"></div>
                </td>
                <td width="13%" align="right">Fleet No</td>
                <td width="15%" align="left">
                    <input type="text" name="msearchfleetno" id="msearchfleetno">
                </td>
            </tr>
            <tr>
                <td align="right">Fleet Name</td>
                <td align="left" colspan="4">
                    <input type="text" name="msearchflname" id="msearchflname">
                </td>
                <td align="center">
                    <input type="button" name="btnmastersearch" id="btnmastersearch" class="myButton" value="Search" onClick="mainloadSearch();">
                </td>
            </tr>
            <tr>
                <td colspan="6">
                    <div id="msearchdiv">
                        <jsp:include page="masterSearchGrid.jsp" />
                    </div>
                </td>
            </tr>
        </table>
    </div>
</body>
</html>