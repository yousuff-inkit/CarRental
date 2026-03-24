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
	  $("#bookdates").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
	}); 

 	function bookloadSearch() {
 		
 		var qutdocno1=document.getElementById("qutdocno").value;
 		 var clientnamess=document.getElementById("clientnames").value;
 		var clmob1=document.getElementById("clmob").value;
 		var qutdate1=document.getElementById("bookdates").value;
 		var quttype1=document.getElementById("quttype").value; 
 		
 	//	alert("clientname"+clientnames);
 	
 	var regno=document.getElementById("regno").value; 
 		
			var clientnames = clientnamess.replace(' ', '%20');
	
	getdata1(qutdocno1,clientnames,clmob1,qutdate1,quttype1,regno);
 

	}
	function getdata1(qutdocno1,clientnames,clmob1,qutdate1,quttype1,regno){
		

		
		 $("#qutrediv").load('bookingsubsearch.jsp?qutdocno='+qutdocno1+'&clientname='+clientnames+'&clmob='+clmob1+'&qutdate='+qutdate1+'&quttype='+quttype1+'&regno='+regno);
		
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
td[align="right"], td {
  font-family: Tahoma, Geneva, sans-serif;
  font-size: 14px;
  font-weight: 700;
  color: #222;
}

/* Bold text inside inputs and selects with Grey Borders */
input[type="text"], select {
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
input[type="text"]:focus, select:focus {
  border-color: #95a5a6;
  outline: none;
}

/* Date field styling for div */
#bookdates {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 600;
  font-size: 14px;
}

/* Master Button Appearance */
.myButton {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 700;
  font-size: 14px;
  background-color: #007bff; /* Master blue base */
  color: white;
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  box-shadow: 0 2px 5px rgba(0,0,0,0.2);
  transition: background-color 0.3s;
}

/* Updated Hover: Blue instead of Green */
.myButton:hover {
  background-color: #0056b3; 
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
<td>

<!-- ROW 1 -->
<table width="100%">
<tr>

<td align="right" width="8%">Doc No</td>
<td width="15%">
<input type="text" name="qutdocno" id="qutdocno"
style="width:95%;" value='<s:property value="qutdocno"/>'>
</td>

<td align="right" width="8%">Name</td>
<td width="40%">
<input type="text" name="clientnames" id="clientnames"
style="width:95%;" value='<s:property value="clientnames"/>'>
</td>

<td align="right" width="8%">Mob</td>
<td width="21%">
<input type="text" name="clmob" id="clmob"
style="width:95%;" value='<s:property value="clmob"/>'>
</td>

</tr>
</table>


<!-- ROW 2 -->
<table width="100%">
<tr>

<td align="right" width="8%">Date</td>
<td width="15%">
<div id="bookdates" name="bookdates"
value='<s:property value="bookdates"/>'></div>
</td>

<td align="right" width="8%">Ref Type</td>
<td width="15%">
<select name="quttype" id="quttype" style="width:95%;"
value='<s:property value="quttype"/>'>
<option value="">--Select--</option>
<option value="DIR">Direct</option>
<option value="QOT">Quotation</option>
<option value="ONL">Online</option>
</select>
</td>

<td align="right" width="8%">Reg No</td>
<td width="15%">
<input type="text" name="regno" id="regno"
style="width:95%;" value='<s:property value="regno"/>'>
</td>

<td width="31%" align="right">
<input type="button" name="qutbtnrasearch"
id="qutbtnrasearch"
class="myButton"
value="Search"
onclick="bookloadSearch()">
</td>

</tr>
</table>

</td>
</tr>


<tr>
<td colspan="8">

<div id="qutrediv">
<jsp:include page="bookingsubsearch.jsp"></jsp:include>
</div>

</td>
</tr>

</table>

</div>
</body>
</html>