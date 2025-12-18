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
<style type="text/css">
/* Master UI Styles */
table {
  border-collapse: separate;
  border-spacing: 15px 18px; /* Standard master gap */
}

/* Bold labels - Overriding the previous 10px Tahoma style */
td[align="right"], td[align="left"] label, .textdetail {
  font-weight: 700 !important;
  font-size: 14px !important;
  color: #222 !important;
  font-family: Tahoma, Arial, sans-serif;
  background-color: transparent !important; /* Matches body bg */
}

/* Bold text inside inputs */
input[type="text"] {
  font-weight: 600;
  font-size: 14px;
  padding: 8px 12px;
  max-width: 100%;
  box-sizing: border-box; 
  font-family: Tahoma, Arial, sans-serif;
}

/* Master Button Styling */
.myButton {
  font-weight: 700;
  font-size: 14px;
  background-color: #4CAF50;
  color: white;
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  box-shadow: 0 2px 5px rgba(0,0,0,0.2);
  transition: background-color 0.3s;
  font-family: Tahoma, Arial, sans-serif;
}

.myButton:hover {
  background-color: #45a049;
}

/* Row spacing */
tr {
  line-height: 1.8;
}
</style>

	<script type="text/javascript">
	$(document).ready(function () {
	
	}); 

 	function mainloadSearch() {
 		
 		var sclname=document.getElementById("SCl_name").value;
 		var smob=document.getElementById("Sl_mob").value;
 		var rno=document.getElementById("rno").value;
 		var flno=document.getElementById("flno").value;
 		var sregno=document.getElementById("sregno").value;
 		var rentaltype=document.getElementById("cmbratype").value;
 		var clientId=document.getElementById("txtcldocno").value;

	
		getdata(sclname,smob,rno,flno,sregno,rentaltype,clientId);

	}
	 function getdata(sclname,smob,rno,flno,sregno,rentaltype,clientId){
		 $("#srefreshdiv").load('agreementDetailsSearchGrid.jsp?sclname='+sclname.replace(/ /g, "%20")+'&smob='+smob+'&rno='+rno+'&flno='+flno+'&sregno='+sregno+'&rentaltype='+rentaltype+'&clientId='+clientId);
		}
 
	</script>
<body bgcolor="#E0ECF8">
<div id="search">
<table width="100%">
  <tr>
    <td>
      <table width="100%">
        <tr>
          <td align="left" width="6.5%"><label class="textdetail">Name</label></td>
          <td align="left" width="54%">
            <input type="text" name="SCl_name" id="SCl_name" style="width:96.5%;" autocomplete="off" value='<s:property value="SCl_name"/>'>
          </td>
          <td align="right"><label class="textdetail">Mob</label></td>
          <td align="left">
            <input type="text" name="Sl_mob" id="Sl_mob" autocomplete="off" value='<s:property value="Sl_mob"/>'>
          </td>
          <td align="right" width="10%"><label class="textdetail">Reg No</label></td>
          <td align="left">
            <input type="text" id="sregno" name="sregno" autocomplete="off" value='<s:property value="sregno"/>'>
          </td>
        </tr>
      </table>
    </td>
  </tr>

  <tr>
    <td>
      <table width="100%">
        <tr>
          <td align="left" width="7%"><label class="textdetail">Doc No</label></td>
          <td align="left" width="54%">
            <input type="text" name="rno" id="rno" autocomplete="off" value='<s:property value="rno"/>'>
            &nbsp;&nbsp;<label class="textdetail">Fleet No</label>&nbsp;
            <input type="text" name="flno" id="flno" style="width:34%;" autocomplete="off" value='<s:property value="flno"/>'>
          </td>
          <td align="left">
            <input type="button" name="mbtnrasearch" id="mbtnrasearch" class="myButton" value="Search" onclick="mainloadSearch();">
          </td>
        </tr>
      </table>
    </td>
  </tr>

  <tr>
    <td colspan="8">
      <div id="srefreshdiv">
        <jsp:include page="agreementDetailsSearchGrid.jsp" />
      </div>
    </td>
  </tr>
</table>
</div>
</body>
</html>