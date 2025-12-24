 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>
 
	<script type="text/javascript">
	$(document).ready(function () {
	 $("#txtdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {
 		var docNo=document.getElementById("txtdocno").value;
 		var dates=document.getElementById("txtdate").value;
 		var descriptions=document.getElementById("txtmaindescription").value;
 		var refNo=document.getElementById("txtreference").value;
 		var amounts=document.getElementById("txtamount").value;
 		var check = 1;
 		
		getdata(docNo,dates,descriptions,refNo,amounts,check);

	}
 	
	function getdata(docNo,dates,descriptions,refNo,amounts,check){
		 $("#refreshdiv").load('ijvMainSearchGrid.jsp?docNo='+docNo+'&dates='+dates+'&descriptions='+descriptions.replace(/ /g, "%20")+'&refNo='+refNo+'&amounts='+amounts+'&check='+check);
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
  width: 95%; /* Prevent overflow */
  max-width: 100%;
  box-sizing: border-box;
  /* Updated as per request: Grey border */
  border: 1px solid #bdc3c7; 
  border-radius: 4px;
  background-color: #ffffff;
}

/* Focus state for inputs */
input[type="text"]:focus {
  border-color: #95a5a6;
  outline: none;
}

/* Date field styling (div) */
#txtdate {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 600;
  font-size: 14px;
}

/* Master Button Appearance */
.myButton {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 700;
  font-size: 14px;
  background-color: #4CAF50; /* Master green */
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
</head>
<body bgcolor="#FFFFFF">
<div id="search">
<table width="100%">
  <tr>
    <td width="7%" align="right">Doc No</td>
    <td width="20%"><input type="text" name="txtdocno" id="txtdocno" autocomplete="off" value='<s:property value="txtdocno"/>'></td>
    <td width="11%" align="right">Ref. No.</td>
    <td width="23%"><input type="text" name="txtreference" id="txtreference" autocomplete="off" value='<s:property value="txtreference"/>'></td>
    <td width="21%" align="right">Date</td>
    <td width="18%">
      <div id="txtdate" name="txtdate" value='<s:property value="txtdate"/>'></div>
      <input type="hidden" name="hidtxtdate" id="hidtxtdate" value='<s:property value="hidtxtdate"/>'>
    </td>
  </tr>
  <tr>
    <td align="right">Amount</td>
    <td><input type="text" id="txtamount" name="txtamount" autocomplete="off" value='<s:property value="txtamount"/>'></td>
    <td align="right">Description</td>
    <td colspan="2"><input type="text" id="txtmaindescription" name="txtmaindescription" autocomplete="off" style="width:65%;" value='<s:property value="txtmaindescription"/>'></td>
    <td align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td colspan="6">
      <div id="refreshdiv">
        <jsp:include page="ijvMainSearchGrid.jsp" />
      </div>
    </td>
  </tr>
</table>
</div>
</body>
</html>