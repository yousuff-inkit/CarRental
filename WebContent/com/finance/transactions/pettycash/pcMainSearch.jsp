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
	 $("#paydate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {

 		var partyname=document.getElementById("txtpartyname").value;
 		var docNo=document.getElementById("txtpettydocno").value;
 		var date=document.getElementById("paydate").value;
 		var amount=document.getElementById("txtpettyamount").value;
	    var check = 1;
	    
		getdata(partyname,docNo,date,amount,check);
	}
	function getdata(partyname,docNo,date,amount,check){
		 $("#refreshdiv").load('pcMainSearchGrid.jsp?partyname='+partyname.replace(/ /g, "%20")+'&docNo='+docNo+'&date='+date+'&amount='+amount+'&check='+check);
		}

	</script>
	<style type="text/css">

table {
  border-collapse: separate;
  border-spacing: 15px 18px;  
}


td[align="right"] {
  font-weight: 700;
  font-size: 14px;
  color: #222;
}


input[type="text"] {
  font-weight: 600;
  font-size: 14px;
  padding: 8px 12px;
  width: 95%;               /* Prevent overflow */
  max-width: 100%;
  box-sizing: border-box;   /* Include padding in width */
}


#bankdate, #chqdate {
  font-weight: 600;
  font-size: 14px;
}

#btnsearch{
  background-color: #2f80ed;   /* clean blue */
  color: #ffffff;
  font-size: 14px;
  font-weight: 600;
  padding: 6px 18px;
  border: 1px solid #2f80ed;
  border-radius: 4px;
  cursor: pointer;
  min-width: 90px;
}
/* Additional spacing for rows */
tr {
  line-height: 1.8;
}
</style>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="6%" align="right">Date</td>
    <td width="14%"><div id="paydate" name="paydate"  value='<s:property value="paydate"/>'></div>
        <input type="hidden" name="hidpaydate" id="hidpaydate" value='<s:property value="hidpaydate"/>'></td>
    <td width="21%" align="right">Doc No</td>
    <td width="32%"><input type="text" name="txtpettydocno" id="txtpettydocno" value='<s:property value="txtpettydocno"/>'></td>
    <td width="27%" align="center" rowspan="2"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td align="right">Name</td>
    <td ><input type="text" name="txtpartyname" id="txtpartyname" style="width:100%" value='<s:property value="txtpartyname"/>'></td>
    <td align="right">Amount</td>
    <td><input type="text" name="txtpettyamount" id="txtpettyamount" value='<s:property value="txtpettyamount"/>'></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshdiv"><jsp:include page="pcMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>