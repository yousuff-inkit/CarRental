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
		$("#msearchdate").jqxDateTimeInput({
			width : '125px',
			height : '15px',
			formatString : "dd.MM.yyyy",value:null
		});
	}); 

 	function mainDocSearch() {
 		
 		var docno=document.getElementById("msearchdocno").value;
 		var date=$('#msearchdate').jqxDateTimeInput('val');
 		var vendor=document.getElementById("msearchvendor").value;
 		var fleetno=document.getElementById("msearchfleetno").value;
 		var regno=document.getElementById("msearchregno").value;
 		var mobile=document.getElementById("msearchmobile").value;
		var branch=document.getElementById("brchName").value;
 		
 		getmaindata(docno,date,vendor,fleetno,regno,mobile,branch);
 

	}
	 function getmaindata(docno,date,vendor,fleetno,regno,mobile,branch){
		
		
		 $("#srefreshdivmain").load('subMainSearch.jsp?docno='+docno+'&date='+date+'&vendor='+vendor+'&fleetno='+fleetno+'&regno='+regno+'&mobile='+mobile+'&branch='+branch+'&id=1');
		 

		}
 
	</script>
<style type="text/css">
/* Master UI Styles */
/* Table spacing and layout */
table {
  border-collapse: separate;
  border-spacing: 15px 15px; /* Standardized master gap */
}

/* Bold labels - Standardized to Master UI 14px Tahoma */
td[align="right"] {
  font-family: Tahoma, Geneva, sans-serif;
  font-size: 14px;
  font-weight: 700;
  color: #222;
}

/* Bold text inside inputs with Grey Borders */
input[type="text"] {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 600;
  font-size: 14px;
  padding: 8px 12px;
  width: 95%; 
  max-width: 100%;
  box-sizing: border-box;
  /* Grey border as requested */
  border: 1px solid #bdc3c7; 
  border-radius: 4px;
  background-color: #ffffff;
}

/* Focus state for inputs */
input[type="text"]:focus {
  border-color: #007bff;
  outline: none;
}

/* Date field styling for div */
#msearchdate {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 600;
  font-size: 14px;
}

/* Master Button Appearance */
.myButton {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 700;
  font-size: 14px;
  background-color: #007bff; /* Blue Button Color */
  color: white;
  padding: 10px 25px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  transition: none; /* Removed hover transition */
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
#search td[align="right"]{
    font-weight:700;
    font-size:14px;
    color:#222;
}
</style>

<body bgcolor="#FFFFFF">
<div id="search">
  <table width="100%">
    <tr>
      <td width="9%" align="right">Doc No</td>
      <td width="15%" align="left"><input type="text" name="msearchdocno" id="msearchdocno"></td>
      <td width="10%" align="right">Date</td>
      <td width="17%" align="left"><div id="msearchdate"></div></td>
      <td width="10%" align="right">Vendor</td>
      <td width="29%" align="left"><input type="text" name="msearchvendor" id="msearchvendor"></td>
      <td width="10%" rowspan="2" align="center">
        <input type="button" name="searchbtn" id="searchbtn" class="myButton" value="Search" onclick="mainDocSearch();">
      </td>
    </tr>
    <tr>
      <td align="right">Fleet</td>
      <td align="left"><input type="text" name="msearchfleetno" id="msearchfleetno"></td>
      <td align="right">Reg No</td>
      <td align="left"><input type="text" name="msearchregno" id="msearchregno"></td>
      <td align="right">Mobile</td>
      <td align="left"><input type="text" name="msearchmobile" id="msearchmobile"></td>
    </tr>
    <tr>
      <td colspan="7" align="right">
        <div id="srefreshdivmain">
          <jsp:include page="subMainSearch.jsp" />
        </div>
      </td>
    </tr>
  </table>
</div>
</body>
</html>