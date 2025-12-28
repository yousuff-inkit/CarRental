<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>

<script>
$(document).ready(function(e) {
    $("#detaildate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy",value:null});
});

function funSearchDetail(){
	<%
	String reftype=request.getParameter("reftype")==null?"":request.getParameter("reftype").toString();
	String branch=request.getParameter("branch")==null?"":request.getParameter("branch").toString();
	String type=request.getParameter("type")==null?"":request.getParameter("type").toString();

	%>
		var type='<%=type%>';

	var reftype='<%=reftype%>';
	var branch='<%=branch%>';
	var docno=document.getElementById("detaildocno").value;
	var fleetno=document.getElementById("detailfleetno").value;
	var regno=document.getElementById("detailregno").value;
	var date=$('#detaildate').jqxDateTimeInput('val');
		$('#docdiv').load('docSearch.jsp?reftype='+reftype+'&branch='+branch+'&docno='+docno+'&fleetno='+fleetno+'&regno='+regno+'&date='+date+'&type='+type+'&mode=1');

}
</script>
</head>

<style type="text/css">
/* Master UI Styles */
body {
  font-family: Tahoma, Geneva, sans-serif;
  font-size: 14px;
  color: #222;
  background-color: #FFFFFF; /* Updated to White */
  overflow: hidden;
}

/* Table spacing and layout */
table {
  border-collapse: separate;
  border-spacing: 12px 15px; /* Standardized master gap */
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
#detaildate {
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
</style>

<body bgcolor="#FFFFFF">
<div id="search">
  <table width="100%" style="background-color:#FFFFFF;">
    <tr>
      <td width="3%" align="right">Date</td>
      <td width="16%" align="left"><div id="detaildate"></div></td>
      
      <td width="12%" align="right">Ref Doc No</td>
      <td width="15%" align="left"><input type="text" name="detaildocno" id="detaildocno"></td>
      <td width="9%" align="right">Fleet No</td>
      <td width="12%" align="left"><input type="text" name="detailfleetno" id="detailfleetno"></td>
      <td width="6%" align="right">Reg No</td>
      <td width="11%" align="left"><input type="text" name="detailregno" id="detailregno"></td>
      <td width="16%" align="center">
        <button type="button" id="btndetail" onClick="funSearchDetail();" class="myButton">Search</button>
      </td>
    </tr>
    <tr>
      <td colspan="9">
        <div id="docdiv">
          <jsp:include page="docSearch.jsp" />
        </div>
      </td>
    </tr>
  </table>
</div>
</body>