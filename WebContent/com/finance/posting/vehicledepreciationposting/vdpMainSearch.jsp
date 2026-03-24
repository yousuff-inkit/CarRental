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
	 	$("#vdpdate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {

 		var partyname=document.getElementById("txtpartyname").value;
 		var docNo=document.getElementById("txtdocno").value;
 		var date=document.getElementById("vdpdate").value;
 		var amount=document.getElementById("txtamount").value;
 		var branch=document.getElementById("brchName").value;
	
		getdata(partyname,docNo,date,amount,branch);
	}
	function getdata(partyname,docNo,date,amount,branch){
		 $("#refreshdiv").load('vdpMainSearchGrid.jsp?partyname='+partyname.replace(/ /g, "%20")+'&docNo='+docNo+'&date='+date+'&amount='+amount+'&branch='+branch);
		}

	</script>
<style type="text/css">
/* Master UI Table Container */
#search table {
  border-collapse: separate;
  border-spacing: 15px 18px; /* Standard master gap */
  width: 100%;
}

/* Label Styling */
td[align="right"] {
  font-family: Tahoma, Arial, sans-serif;
  font-size: 14px;
  font-weight: 700;
  color: #222;
}

/* Input Field Styling */
input[type="text"] {
  font-family: Tahoma, Arial, sans-serif;
  font-weight: 600;
  font-size: 14px;
  padding: 8px 12px;
  width: 95%;
  max-width: 100%;
  box-sizing: border-box; /* Include padding in width */
}

/* Date Picker Container */
#vdpdate {
  font-family: Tahoma, Arial, sans-serif;
  font-weight: 600;
  font-size: 14px;
}

/* Master Button Appearance */
.myButton {
  font-family: Tahoma, Arial, sans-serif;
  font-weight: 700;
  font-size: 14px;
  background-color: #007bff; /* Master Blue */
  color: #ffffff;
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  box-shadow: 0 2px 5px rgba(0,0,0,0.2);
  transition: background-color 0.3s;
  min-width: 90px;
}

/* Master Green Hover Effect */
.myButton:hover {
  background-color: #45a049;
}

/* Row Spacing */
tr {
  line-height: 1.8;
}
</style>
</head>
<body bgcolor="#E0ECF8">
<div id="search">
  <table>
    <tr>
      <td width="6%" align="right">Date</td>
      <td width="14%">
        <div id="vdpdate" name="vdpdate" value='<s:property value="vdpdate"/>'></div>
        <input type="hidden" name="hidvdpdate" id="hidvdpdate" value='<s:property value="hidvdpdate"/>'>
      </td>
      <td width="21%" align="right">Doc No</td>
      <td width="32%">
        <input type="text" name="txtdocno" id="txtdocno" value='<s:property value="txtdocno"/>'>
      </td>
      <td width="27%" align="center">
        <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch();">
      </td>
    </tr>
    <tr>
      <td align="right">Name</td>
      <td colspan="2">
        <input type="text" name="txtpartyname" id="txtpartyname" style="width:100%" value='<s:property value="txtpartyname"/>'>
      </td>
      <td align="right">Total</td>
      <td>
        <input type="text" name="txtamount" id="txtamount" value='<s:property value="txtamount"/>'>
      </td>
    </tr>
    <tr>
      <td colspan="5">
        <div id="refreshdiv">
          <jsp:include page="vdpMainSearchGrid.jsp" />
        </div>
      </td>
    </tr>
  </table>
</div>
</body></html>