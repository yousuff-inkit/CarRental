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
<style type="text/css">

#search table {
  border-collapse: separate;
  border-spacing: 15px 18px;  
}


td[align="right"] {
  font-weight: 600;
  font-size: 14px;
  color: #222;
  font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
  
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

/* Bold button text */
.myButton {
  font-weight: 700;
  font-size: 14px;
}

/* Additional spacing for rows */
tr {
  line-height: 1.8;
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
</style>
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
		var check=1;
		
		getdata(partyname,docNo,date,amount,chequeNo,chequeDt,check);
	}
	function getdata(partyname,docNo,date,amount,chequeNo,chequeDt,check){
		 $("#refreshdiv").load('brvMainSearchGrid.jsp?partyname='+partyname.replace(/ /g, "%20")+'&docNo='+docNo+'&date='+date+'&amount='+amount+'&chequeNo='+chequeNo+'&chequeDt='+chequeDt+'&check='+check);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="6%" align="right">Name</td>
    <td colspan="1"><input type="text" name="txtpartyname" id="txtpartyname" style="width:80%" value='<s:property value="txtpartyname"/>'></td>
    <td width="11%" align="right">Doc No</td>
    <td colspan="1"><input type="text" name="txtdocno" id="txtdocno" value='<s:property value="txtdocno"/>'></td>
      <td align="right">Date</td>
    <td width="14%"><div id="bankdate" name="bankdate"  value='<s:property value="bankdate"/>'></div>
    <input type="hidden" name="hidbankdate" id="hidbankdate" value='<s:property value="hidbankdate"/>'></td>
    <td width="17%" align="center" rowspan="2"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
  	<td >Cheque No</td>
    <td width="14%"><input type="text" id="txtchqno" name="txtchqno" value='<s:property value="txtchqno"/>'></td>
        
    <td width="10%" align="right">Amount</td>
    <td width="14%"><input type="text" name="txtamount" id="txtamount" value='<s:property value="txtamount"/>'></td>
       <td width="14%" align="right">Cheque Date</td>
    <td><div id="chqdate" name="chqdate"  value='<s:property value="chqdate"/>'></div>
        <input type="hidden" name="hidchqdate" id="hidchqdate" value='<s:property value="hidchqdate"/>'></td>
  </tr>
  <tr>
    <td colspan="8"><div id="refreshdiv"><jsp:include  page="brvMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>