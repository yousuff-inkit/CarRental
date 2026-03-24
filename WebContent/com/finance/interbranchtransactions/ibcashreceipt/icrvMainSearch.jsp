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
	 $("#receiptdate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {

 		var partyname=document.getElementById("txtpartyname").value;
 		var docNo=document.getElementById("txtdocno").value;
 		var date=document.getElementById("receiptdate").value;
 		var amount=document.getElementById("txtamount").value;
	    var check = 1;
	    
		getdata(partyname,docNo,date,amount,check);
	}
	function getdata(partyname,docNo,date,amount,check){
		 $("#refreshdiv").load('icrvMainSearchGrid.jsp?partyname='+partyname.replace(/ /g, "%20")+'&docNo='+docNo+'&date='+date+'&amount='+amount+'&check='+check);
		}

	</script>
<style type="text/css">
/* Master UI Styles */
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
    <td width="15%" align="right">Date</td>
    <td width="20%">
        <div id="receiptdate" name="receiptdate" value='<s:property value="receiptdate"/>'></div>
        <input type="hidden" name="hidreceiptdate" id="hidreceiptdate" value='<s:property value="hidreceiptdate"/>'>
    </td>
    <td width="15%" align="right">Doc No</td>
    <td width="25%">
        <input type="text" name="txtdocno" id="txtdocno" autocomplete="off" value='<s:property value="txtdocno"/>'>
    </td>
    <td width="25%" rowspan="2" align="center">
        <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch();">
    </td>
  </tr>
  <tr>
    <td align="right">Name</td>
    <td>
        <input type="text" name="txtpartyname" id="txtpartyname" autocomplete="off" value='<s:property value="txtpartyname"/>'>
    </td>
    <td align="right">Amount</td>
    <td>
        <input type="text" name="txtamount" id="txtamount" autocomplete="off" value='<s:property value="txtamount"/>'>
    </td>
  </tr>
  <tr>
    <td colspan="5">
        <div id="refreshdiv">
            <jsp:include page="icrvMainSearchGrid.jsp"></jsp:include>
        </div>
    </td>
  </tr>
</table>
</div>
</body>
</html>