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
	 $("#bankdate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	 $("#chqdate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {

 		var partyname=document.getElementById("txtpartyname").value;
 		var docNo=document.getElementById("txtdocno").value;
 		var date=document.getElementById("bankdate").value;
 		var amount=document.getElementById("txtamount").value;
 		var chequeNo=document.getElementById("txtchqno").value;
 		var chequeDt=document.getElementById("chqdate").value;
	    var check = 1;
	    
		getdata(partyname,docNo,date,amount,chequeNo,chequeDt,check);
	}
	function getdata(partyname,docNo,date,amount,chequeNo,chequeDt,check){
		 $("#refreshdiv").load('ibpMainSearchGrid.jsp?partyname='+partyname.replace(/ /g, "%20")+'&docNo='+docNo+'&date='+date+'&amount='+amount+'&chequeNo='+chequeNo+'&chequeDt='+chequeDt+'&check='+check);
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
  width: 95%; /* Standardized width */
  max-width: 100%;
  box-sizing: border-box;
  /* Grey border as requested */
  border: 1px solid #bdc3c7; 
  border-radius: 4px;
  background-color: #ffffff;
}

/* Focus state for inputs */
input[type="text"]:focus {
  border-color: #95a5a6;
  outline: none;
}

/* Date field styling for div elements */
#bankdate, #chqdate {
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
    <td width="6%" align="right">Name</td>
    <td colspan="3">
      <input type="text" name="txtpartyname" id="txtpartyname" autocomplete="off" style="width:80%" value='<s:property value="txtpartyname"/>'>
    </td>
    <td width="11%" align="right">Doc No</td>
    <td colspan="2">
      <input type="text" name="txtdocno" id="txtdocno" autocomplete="off" value='<s:property value="txtdocno"/>'>
    </td>
    <td width="17%" align="center">
      <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch();">
    </td>
  </tr>
  <tr>
    <td align="right">Date</td>
    <td width="14%">
      <div id="bankdate" name="bankdate" value='<s:property value="bankdate"/>'></div>
      <input type="hidden" name="hidbankdate" id="hidbankdate" value='<s:property value="hidbankdate"/>'>
    </td>
    <td width="10%" align="right">Amount</td>
    <td width="14%">
      <input type="text" name="txtamount" id="txtamount" autocomplete="off" value='<s:property value="txtamount"/>'>
    </td>
    <td align="right">Cheque No</td>
    <td width="14%">
      <input type="text" id="txtchqno" name="txtchqno" autocomplete="off" value='<s:property value="txtchqno"/>'>
    </td>
    <td width="14%" align="right">Cheque Date</td>
    <td>
      <div id="chqdate" name="chqdate" value='<s:property value="chqdate"/>'></div>
      <input type="hidden" name="hidchqdate" id="hidchqdate" value='<s:property value="hidchqdate"/>'>
    </td>
  </tr>
  <tr>
    <td colspan="8">
      <div id="refreshdiv">
        <jsp:include page="ibpMainSearchGrid.jsp" />
      </div>
    </td>
  </tr>
</table>
</div>
</body>
</html>