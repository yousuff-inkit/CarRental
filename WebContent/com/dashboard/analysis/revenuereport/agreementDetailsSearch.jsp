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


	<script type="text/javascript">
	$(document).ready(function () {
	
	}); 

 	function mainloadSearch() {
 		
 		var sclname=document.getElementById("SCl_name").value;
 		var smob=document.getElementById("Sl_mob").value;
 		var rno=document.getElementById("rno").value;
 		var flno=document.getElementById("flno").value;
 		var sregno=document.getElementById("sregno").value;
 		
 		var rentaltype=document.getElementById("rentaltype").value;
 		
 		  var branchval = document.getElementById("cmbbranch").value; 
	
		getdata(sclname,smob,rno,flno,sregno,rentaltype,branchval);

	}
	 function getdata(sclname,smob,rno,flno,sregno,rentaltype,branchval){
		 $("#srefreshdiv").load('agreementDetailsSearchGrid.jsp?sclname='+sclname+'&smob='+smob+'&rno='+rno+'&flno='+flno+'&sregno='+sregno+'&rentaltype='+rentaltype+'&branchval='+branchval);
		}
 
	</script>
<style type="text/css">
/* Master UI Styles */
/* Table spacing and layout */
table {
  border-collapse: separate;
  border-spacing: 15px 12px; /* Standardized master gap */
}

/* Bold labels - Standardized to Master UI 14px Tahoma */
.textdetail, td[align="right"], td[align="left"] {
  font-family: Tahoma, Geneva, sans-serif;
  font-size: 14px;
  font-weight: 600; /* Requested font weight */
  color: #222;
  white-space: nowrap;
}

/* Bold text inside inputs with Grey Borders */
input[type="text"] {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 600; /* Requested font weight */
  font-size: 14px;
  padding: 8px 12px;
  max-width: 100%;
  box-sizing: border-box;
  /* Grey border */
  border: 1px solid #bdc3c7; 
  border-radius: 4px;
  background-color: #ffffff;
}

/* Focus state for inputs */
input[type="text"]:focus {
  border-color: #007bff;
  outline: none;
}

/* Master Button Appearance */
.myButton {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 700;
  font-size: 14px;
  background-color: #007bff; /* Standard Blue */
  color: white;
  padding: 8px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  transition: none; /* No hover transition */
}

/* No color change on hover */
.myButton:hover {
  background-color: #007bff; 
  cursor: pointer;
}

/* Row spacing */
tr {
  line-height: 1.6;
}

/* Container background override */
#search {
    background-color: #FFFFFF;
}
</style>

<body bgcolor="#FFFFFF">
<div id="search">
<table width="100%">
  <tr>
    <td>
      <table>
        <tr>
          <td align="left" width="6.5%"><label class="textdetail">Name</label></td>
          <td align="left" width="54%"><input type="text" name="SCl_name" id="SCl_name" style="width:96.5%;" value='<s:property value="SCl_name"/>'></td>
          <td align="right"><label class="textdetail">Mob</label></td>
          <td align="left"><input type="text" name="Sl_mob" id="Sl_mob" value='<s:property value="Sl_mob"/>'></td>
          <td align="right" width="10%"><label class="textdetail">Reg No</label></td>
          <td align="left"><input type="text" id="sregno" name="sregno" value='<s:property value="sregno"/>'></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td>
      <table>
        <tr>
          <td align="left" width="7%"><label class="textdetail">Doc No</label></td>
          <td align="left" width="54%">
            <input type="text" name="rno" id="rno" value='<s:property value="rno"/>'>
            &nbsp;<label class="textdetail">Fleet No</label>
            <input type="text" name="flno" id="flno" style="width:34%;" value='<s:property value="flno"/>'>
          </td>
          <td align="left">&nbsp;&nbsp;
            <input type="button" name="mbtnrasearch" id="mbtnrasearch" class="myButton" value="Search" onclick="mainloadSearch();">
          </td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td colspan="8">
      <div id="srefreshdiv">
        <jsp:include page="agreementDetailsSearchGrid.jsp"></jsp:include>
      </div>
    </td>
  </tr>
</table>
</div>
</body>
</html>