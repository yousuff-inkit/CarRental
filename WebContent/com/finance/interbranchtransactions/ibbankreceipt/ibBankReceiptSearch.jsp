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
		 $("#refreshAccountSearchDetailsDiv").load("ibBankReceiptSearchGrid.jsp?accountno="+accountsno+'&accountname='+accountsname.replace(/ /g, "%20")+'&currency='+currs+'&atype='+type+'&date='+date+'&check='+check);
	}

</script>
<style type="text/css">
#search {
  background-color: #ffffff;
  padding: 5px;
}

#search table {
  border-collapse: separate;
  border-spacing: 15px 18px;  
  background-color: #ffffff;
}

#search td[align="right"] {
  font-weight: 700;
  font-size: 14px;
  color: #222;
  font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

input[type="text"] {
  font-weight: 600;
  font-size: 14px;
  padding: 8px 12px;
  width: 95%;                
  max-width: 100%;
  box-sizing: border-box;   
  border: 1px solid #ccc;
}

#search tr {
  line-height: 1.6;
}

.myButton {
    font-weight: 700;
    font-size: 13px;
    width: 130px;
    height: 38px;
    padding: 8px 12px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%) !important;
    color: #ffffff !important;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 2px 4px rgba(59, 130, 246, 0.2);
    text-transform: uppercase;
    letter-spacing: 0.3px;
    white-space: nowrap;
    text-align: center;
}

.myButton:hover {
  background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%) !important;
  box-shadow: 0 4px 6px rgba(59, 130, 246, 0.3);
  transform: translateY(-1px);
}
</style>

<body bgcolor="#ffffff">
<div id="search">
<table width="100%" border="0">
  <tr>
    <td width="15%" align="right">Account No</td>
    <td width="25%">
        <input type="text" name="txtacctno" id="txtacctno" value='<s:property value="txtacctno"/>'>
    </td>
    <td width="15%" align="right">Currency</td>
    <td width="20%">
        <input type="text" name="txtacctcurrency" id="txtacctcurrency" value='<s:property value="txtacctcurrency"/>'>
        <input type="hidden" name="txttypes" id="txttypes" value='<s:property value="txttypes"/>'>
        <input type="hidden" name="txtnewmaindate" id="txtnewmaindate" value='<s:property value="txtnewmaindate"/>'>
    </td>
    <td width="25%" rowspan="2" align="center">
        <input type="button" name="btnAccountSearch" id="btnAccountSearch" class="myButton" value="Search" onclick="loadAccountSearchGrid();">
    </td>
  </tr>
  <tr>
    <td align="right">Account Name</td>
    <td colspan="3">
        <input type="text" name="txtacctname" id="txtacctname" style="width: 98%;" value='<s:property value="txtacctname"/>'>
    </td>
  </tr>
  <tr>
    <td colspan="5">
        <div id="refreshAccountSearchDetailsDiv">
            <jsp:include page="ibBankReceiptSearchGrid.jsp"></jsp:include>
        </div>
    </td>
  </tr>
</table>
</div>
</body>
</html>