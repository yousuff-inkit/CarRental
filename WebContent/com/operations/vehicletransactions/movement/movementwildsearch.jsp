<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<!-- <link rel="stylesheet" type="text/css" href="../../../../css/body.css"> --> 
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<style>
.hidden-scrollbar {
  overflow: auto;
  height: 545px;
}
</style>
<script>
function funWildSearch(){
	alert("Inside Search Button");
	var tempdoc=document.getElementById("searchdocno").value;
	var tempfleet=document.getElementById("searchfleet").value;
	var tempregno=document.getElementById("searchregno").value;
	var tempstatus=document.getElementById("searchstatus").value;
	
	getWildData(tempdoc,tempfleet,tempregno,tempstatus);
}
function getWildData(tempdoc,tempfleet,tempregno,tempstatus) {
	alert("Inside Ajax Function");
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			//alert(items);
			$("#wildgriddiv").load("wildsearchgrid.jsp?id="+items);
		} else {
		}
	}
	x.open("GET", "getWildData.jsp?doc="+tempdoc+"&fleet="+tempfleet+"&regno="+tempregno+"&status="+tempstatus+"", true);
	x.send();
}
</script>
</head>
<style type="text/css">
/* Master UI Styles */
/* Table spacing and layout */
table {
  border-collapse: separate;
  border-spacing: 15px 12px; /* Standardized master gap */
}

/* Bold labels - Standardized to Master UI 14px Tahoma */
td[align="right"], td {
  font-family: Tahoma, Geneva, sans-serif;
  font-size: 14px;
  font-weight: 700;
  color: #222;
  white-space: nowrap;
}

/* Bold text inside inputs with Grey Borders */
input[type="text"] {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 600; /* Font weight 600 as requested */
  font-size: 14px;
  padding: 8px 12px;
  width: 95%;
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
<table width="100%">
  <tr>
    <td align="right">Doc No</td>
    <td><input type="text" name="searchdocno" id="searchdocno" value='<s:property value="searchdocno"/>'/></td>
    
    <td align="right">Fleet</td>
    <td><input type="text" name="searchfleet" id="searchfleet" value='<s:property value="searchfleet"/>'/></td>
    
    <td align="right">Reg No</td>
    <td><input type="text" name="searchregno" id="searchregno" value='<s:property value="searchregno"/>'/></td>
    
    <td>Status</td>
    <td><input type="text" name="searchstatus" id="searchstatus" value='<s:property value="searchstatus"/>'/></td>
  </tr>
  <tr>
    <td colspan="8" align="center">
      <input type="button" name="btndsearch" id="btndsearch" class="myButton" value="Search" onclick="funWildSearch();">
    </td>
  </tr>
  <tr>
    <td colspan="8">
      <div id="wildgriddiv">
        <jsp:include page="wildsearchgrid.jsp"></jsp:include>
      </div>
    </td>
  </tr>
</table>
</div>
</body>
</html>