 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<% String atype = request.getParameter("atype")==null?"0":request.getParameter("atype"); %>

<script type="text/javascript">
	$(document).ready(function () {
		var atype='<%=atype%>';
		document.getElementById("txttypes").value=atype;
		document.getElementById("txtnewmaindate").value=$('#maindate').val();
	}); 
	
	function loadAccountSearchGrid() {
			var accountsno=document.getElementById("txtacctno").value;
			var accountsname=document.getElementById("txtacctname").value;
			var currs=document.getElementById("txtacctcurrency").value;
			var type=document.getElementById("txttypes").value;
			var date=document.getElementById("txtnewmaindate").value;
			var check = 1;
	
			getAccountDetails(accountsno,accountsname,currs,type,date,check);
	}
		
	function getAccountDetails(accountsno,accountsname,currs,type,date,check){
		 $("#refreshAccountSearchDetailsDiv").load("ibJournalVoucherSearchGrid.jsp?accountno="+accountsno+'&accountname='+accountsname.replace(/ /g, "%20")+'&currency='+currs+'&atype='+type+'&date='+date+'&check='+check);
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
    <td width="10%" align="right">Account No</td>
    <td width="30%">
      <input type="text" name="txtacctno" id="txtacctno" style="width:85%;" value='<s:property value="txtacctno"/>'>
    </td>
    <td width="10%" align="right">Currency</td>
    <td width="27%">
      <input type="text" name="txtacctcurrency" id="txtacctcurrency" style="width:50%;" value='<s:property value="txtacctcurrency"/>'>
      <input type="hidden" name="txttypes" id="txttypes" value='<s:property value="txttypes"/>'>
      <input type="hidden" name="txtnewmaindate" id="txtnewmaindate" value='<s:property value="txtnewmaindate"/>'>
    </td>
    <td width="23%" rowspan="2" align="center">
      <input type="button" name="btnAccountSearch" id="btnAccountSearch" class="myButton" value="Search" onclick="loadAccountSearchGrid();">
    </td>
  </tr>
  <tr>
    <td align="right">Account Name</td>
    <td colspan="3">
      <input type="text" name="txtacctname" id="txtacctname" style="width:80%;" value='<s:property value="txtacctname"/>'>
    </td>
  </tr>
  <tr>
    <td colspan="5">
      <div id="refreshAccountSearchDetailsDiv">
        <jsp:include page="ibJournalVoucherSearchGrid.jsp" />
      </div>
    </td>
  </tr>
</table>
</div>
</body>
</html>