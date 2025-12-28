 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

	<script type="text/javascript">
	$(document).ready(function () {
	 $("#refunddate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {

 		var accountName=document.getElementById("txtaccountname").value;
 		var srNo=document.getElementById("txtdocumentsrno").value;
 		var date=document.getElementById("refunddate").value;
 		var total=document.getElementById("txtamounttotal").value;
 		var refNo=document.getElementById("txtreferenceno").value;
	
		getdata(accountName,srNo,date,total,refNo);
	}
	function getdata(accountName,srNo,date,total,refNo){
		 $("#refreshdiv").load('rrpMainSearchGrid.jsp?accountName='+accountName.replace(/ /g, "%20")+'&srNo='+srNo+'&date='+date+'&total='+total+'&refNo='+refNo);
		}

	</script>
<style type="text/css">
/* Master UI Styles */
/* Table spacing and layout */
table {
  border-collapse: separate;
  border-spacing: 15px 18px; /* Standardized master gap */
}

/* Bold labels - Standardized to Master UI 14px Tahoma */
td[align="right"] {
  font-family: Tahoma, Geneva, sans-serif;
  font-size: 14px;
  font-weight: 700;
  color: #222;
}

/* Bold text inside inputs */
input[type="text"] {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 600;
  font-size: 14px;
  padding: 8px 12px;
  width: 95%;
  max-width: 100%;
  box-sizing: border-box;
  border: 1px solid #ccc;
  border-radius: 4px;
}

/* Date field styling */
#refunddate {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 600;
  font-size: 14px;
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
  line-height: 1.8;
}
</style>

<body bgcolor="#E0ECF8">
<div id="search">
<table width="100%">
  <tr>
    <td width="7%" align="right">RR No</td>
    <td width="19%">
      <input type="text" name="txtdocumentsrno" id="txtdocumentsrno" autocomplete="off" value='<s:property value="txtdocumentsrno"/>'>
    </td>
    <td width="10%" align="right">A/C Name</td>
    <td colspan="3">
      <input type="text" name="txtaccountname" id="txtaccountname" autocomplete="off" style="width:80%" value='<s:property value="txtaccountname"/>'>
    </td>
    <td width="13%" align="center">
      <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch();">
    </td>
  </tr>
  <tr>
    <td align="right">Date</td>
    <td>
      <div id="refunddate" name="refunddate" value='<s:property value="refunddate"/>'></div>
      <input type="hidden" name="hidrefunddate" id="hidrefunddate" value='<s:property value="hidrefunddate"/>'>
    </td>
    <td align="right">Total</td>
    <td width="23%">
      <input type="text" name="txtamounttotal" id="txtamounttotal" autocomplete="off" value='<s:property value="txtamounttotal"/>'>
    </td>
    <td width="6%" align="right">Ref. No</td>
    <td colspan="2">
      <input type="text" id="txtreferenceno" name="txtreferenceno" autocomplete="off" value='<s:property value="txtreferenceno"/>'>
    </td>
  </tr>
  <tr>
    <td colspan="7">
      <div id="refreshdiv">
        <jsp:include page="rrpMainSearchGrid.jsp" />
      </div>
    </td>
  </tr>
</table>
</div>
</body>
</html>