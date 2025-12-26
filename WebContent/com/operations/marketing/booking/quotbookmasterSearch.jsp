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
	  $("#qutdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
	}); 

 	function qutloadSearch() {
 	
 		var qutdocno=document.getElementById("qutdocno").value;
 		 var clientname=document.getElementById("clientname1").value;
 		var qutdate=document.getElementById("qutdate").value;
 		var clientname1 = clientname.replace(' ', '%20');
 		
		
	
	getdata1(qutdocno,clientname1,qutdate);
 

	}
	function getdata1(qutdocno,clientname1,qutdate){
		

		
		 $("#qutrediv").load('qutbooksubMastersearch.jsp?qutdocno='+qutdocno+'&clientname='+clientname1+'&qutdate='+qutdate);
		
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
#qutdate {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 600;
  font-size: 14px;
}

/* Master Button Appearance */
.myButton {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 700;
  font-size: 14px;
  background-color: #007bff; /* Updated Button Color */
  color: white;
  padding: 10px 25px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  transition: none; /* Removed transition as hover color won't change */
}

/* No color change on hover as requested */
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
<table width="100%">
  <tr>
    <td>                         
      <table width="100%">
        <tr>
          <td align="right" width="8%">Docno</td>
          <td align="left" width="15%">
            <input type="text" name="qutdocno" id="qutdocno" value='<s:property value="qutdocno"/>'>
          </td>
          <td align="right" width="8%">Name</td>
          <td align="left">
            <input type="text" name="clientname1" id="clientname1" style="width:96.5%;" value='<s:property value="clientname1"/>'>
          </td>
        </tr>
      </table>
      
      <table width="100%">
        <tr>
          <td align="right" width="8%">Date</td>
          <td align="left" width="15%">
            <div id="qutdate" name="qutdate" value='<s:property value="qutdate"/>'></div>
          </td>
          <td align="center"> 
            <input type="button" name="qutbtnrasearch" id="qutbtnrasearch" class="myButton" value="Search" onclick="qutloadSearch()">
          </td>
        </tr>
      </table>
    </td>
  </tr>

  <tr>
    <td colspan="8">
      <div id="qutrediv">
        <jsp:include page="qutbooksubMastersearch.jsp" /> 
      </div>
    </td>
  </tr>
</table>
</div>
</body>