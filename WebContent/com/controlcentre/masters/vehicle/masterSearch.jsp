 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <%--  <jsp:include page="../../../../includes.jsp"></jsp:include>   --%>
<style>
<%-- <link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
 --%>
</style>

	<script type="text/javascript">
	$(document).ready(function () {
		$("#searchdate").jqxDateTimeInput({ width: '100%', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function mainloadSearch() {
 		
 		var fleetno=document.getElementById("searchfleet").value;
 		var docno=document.getElementById("searchdocno").value;
 		var regno=document.getElementById("searchregno").value;
 		var fleetname=document.getElementById("searchfleetname").value;
 		var searchdate=$('#searchdate').jqxDateTimeInput('val');
 		var engine=document.getElementById("searchengine").value;
		var chassis=document.getElementById("searchchassis").value;
		getdata(fleetno,docno,regno,fleetname,searchdate,engine,chassis);
 
 

	}
	 function getdata(fleetno,docno,regno,fleetname,searchdate,engine,chassis){
		
		 $("#srefreshdiv").load('subMainSearch.jsp?fleetno='+fleetno+'&docno='+docno+'&regno='+regno+'&fleetname='+fleetname+'&searchdate='+searchdate+'&id=1&engine='+engine+'&chassis='+chassis);
		 

		}
 
	</script>
<style type="text/css">
/* Master UI Styles */
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
#searchdate {
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
  <table width="100%" >
    <tr>
      <td width="6%" align="right">Fleet No</td>
      <td width="19%" align="left"><input type="text" name="searchfleet" id="searchfleet" value='<s:property value="searchfleet"/>'></td>
      <td width="9%" align="right">Fleet Name</td>
      <td align="left"><input type="text" name="searchfleetname" id="searchfleetname" value='<s:property value="searchfleetname"/>' style="width:99%;"></td>
      <td align="right">Engine No</td>
      <td align="left"><input type="text" name="searchengine" id="searchengine" value='<s:property value="searchengine"/>'></td>
      <td align="right">Chassis No</td>
      <td align="left"><input type="text" name="searchchassis" id="searchchassis" value='<s:property value="searchchassis"/>'></td>
    </tr>
    <tr>
      <td align="right">Doc No</td>
      <td align="left"><input type="text" name="searchdocno" id="searchdocno" value='<s:property value="searchdocno"/>'></td>
      <td align="right">Date</td>
      <td width="19%" align="left"><div id="searchdate" name="searchdate"></div></td>
      <td width="12%" align="right">Reg No</td>
      <td width="11%" align="left"><input type="text" name="searchregno" id="searchregno"></td>
      <td width="24%" colspan="2" align="center">
        <input type="button" name="btninvsearch" id="btninvsearch" class="myButton" value="Search" onClick="mainloadSearch();">
      </td>
    </tr>
    <tr>
      <td colspan="8"> 
        <div id="srefreshdiv">
          <jsp:include page="subMainSearch.jsp" /> 
        </div>
      </td>
    </tr>
  </table>
</div>
</body>