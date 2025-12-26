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
<style>
.textdetail {
	color: black;
	background-color: #E0ECF8;
	width: 100%;
	font-family: Tahoma;
	font-size: 10px;
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
<style type="text/css">
/* Master UI Styles */
/* Table spacing and layout */
table {
  border-collapse: separate;
  border-spacing: 15px 12px;
}

/* Section Header with Blue Vertical Line */
.section-header {
  font-family: Tahoma, Geneva, sans-serif;
  font-size: 16px;
  font-weight: 700;
  color: #222;
  
  padding-left: 10px;
  margin: 10px 0 5px 10px;
}

/* Bold labels - Standardized to Master UI 14px Tahoma */
.textdetail, td[align="right"], td[align="left"] label {
  font-family: Tahoma, Geneva, sans-serif !important;
  font-size: 14px !important;
  font-weight: 700 !important;
  color: #222 !important;
  background-color: transparent !important;
}

/* Bold text inside inputs */
input[type="text"] {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 600;
  font-size: 14px;
  padding: 8px 12px;
  max-width: 100%;
  box-sizing: border-box;
  border: 1px solid #ccc;
  border-radius: 4px;
}

/* Master Button Appearance */
.myButton {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 700;
  font-size: 14px;
  background-color: #007bff; /* Master green */
  color: white;
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  box-shadow: 0 2px 5px rgba(0,0,0,0.2);
  transition: background-color 0.3s;
}

.myButton:hover {
  background-color: #45a049;
}

/* Row spacing */
tr {
  line-height: 1.6;
}
</style>

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
            <td align="right" width="5%"><label class="textdetail">Mob</label></td>
            <td align="left" width="15%">
              <input type="text" name="Sl_mob" id="Sl_mob" autocomplete="off" value='<s:property value="Sl_mob"/>'>
            </td>
            <td align="right" width="10%"><label class="textdetail">Reg No</label></td>
            <td align="left" width="15%">
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
              <input type="text" name="rno" id="rno" style="width:30%;" autocomplete="off" value='<s:property value="rno"/>'>
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