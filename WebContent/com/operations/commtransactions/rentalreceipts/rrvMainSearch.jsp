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

 		var accountName=document.getElementById("txtaccountname").value;
 		var mobno=document.getElementById("mobno").value;
 		var srNo=document.getElementById("txtdocumentsrno").value;
 		var date=document.getElementById("receiptdate").value;
 		var total=document.getElementById("txtamounttotal").value;
 		var refNo=document.getElementById("txtreferenceno").value;
	
		getdata(accountName,mobno,srNo,date,total,refNo);
	}
	function getdata(accountName,mobno,srNo,date,total,refNo){
		 $("#refreshdiv").load('rrvMainSearchGrid.jsp?accountName='+accountName.replace(/ /g, "%20")+'&mobile='+mobno+'&srNo='+srNo+'&date='+date+'&total='+total+'&refNo='+refNo);
		}

	</script>
<style type="text/css">
/* Master UI Styles */

table {
  border-collapse: separate;
  border-spacing: 15px 18px; 
}


td[align="right"], td[align="left"] {
  font-weight: 700;
  font-size: 14px;
  color: #222;
  font-family: Tahoma, Arial, sans-serif;
}


input[type="text"] {
  font-weight: 600;
  font-size: 14px;
  padding: 8px 12px;
  width: 95%; 
  max-width: 100%;
  box-sizing: border-box; 
  font-family: Tahoma, Arial, sans-serif;
}


#receiptdate {
  font-weight: 600;
  font-size: 14px;
  font-family: Tahoma, Arial, sans-serif;
}

/* Master Button Appearance */
.myButton {
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
  font-family: Tahoma, Arial, sans-serif;
}

/* Button Hover Effects */
.myButton:hover {
  background-color: #45a049;
}

/* Additional spacing for rows */
tr {
  line-height: 1.8;
}
#search td[align="right"]{
    font-weight:700;
    font-size:14px;
    color:#222;
}
</style>

<body>
<div id="search">

<table width="100%">

<tr>
    <td width="6%" align="right">Date</td>
    <td width="14%">
        <div id="receiptdate" name="receiptdate" value='<s:property value="receiptdate"/>'></div>
        <input type="hidden" name="hidreceiptdate" id="hidreceiptdate" value='<s:property value="hidreceiptdate"/>'>
    </td>

    <td width="21%" align="right">RR No</td>
    <td width="32%">
        <input type="text" name="txtdocumentsrno" id="txtdocumentsrno" autocomplete="off"
        value='<s:property value="txtdocumentsrno"/>'>
    </td>

    <td width="27%" align="center" rowspan="2">
        <input type="button" name="btnsearch" id="btnsearch" class="myButton"
        value="Search" onclick="loadSearch();">
    </td>
</tr>

<tr>
    <td align="right">A/C Name</td>
    <td>
        <input type="text" name="txtaccountname" id="txtaccountname" autocomplete="off"
        value='<s:property value="txtaccountname"/>'>
    </td>

    <td align="right">Total</td>
    <td>
        <input type="text" name="txtamounttotal" id="txtamounttotal" autocomplete="off"
        value='<s:property value="txtamounttotal"/>'>
    </td>
</tr>

<tr>
    <td align="right">Mobile</td>
    <td>
        <input type="text" name="mobno" id="mobno" autocomplete="off"
        value='<s:property value="mobno"/>'>
    </td>

    <td align="right">Ref No</td>
    <td>
        <input type="text" id="txtreferenceno" name="txtreferenceno" autocomplete="off"
        value='<s:property value="txtreferenceno"/>'>
    </td>

    <td colspan="2"></td>
</tr>

<tr>
<td colspan="5">
<div id="refreshdiv">
<jsp:include page="rrvMainSearchGrid.jsp" />
</div>
</td>
</tr>

</table>

</div>
</body>
</html>