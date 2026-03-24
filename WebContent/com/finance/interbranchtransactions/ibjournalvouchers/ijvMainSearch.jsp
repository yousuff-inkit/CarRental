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
    <td width="10%" align="right">Doc No</td>
    <td width="20%">
        <input type="text" name="txtdocno" id="txtdocno" autocomplete="off" value='<s:property value="txtdocno"/>'>
    </td>
    <td width="10%" align="right">Ref. No.</td>
    <td width="20%">
        <input type="text" name="txtreference" id="txtreference" autocomplete="off" value='<s:property value="txtreference"/>'>
    </td>
    <td width="10%" align="right">Date</td>
    <td width="20%">
        <div id="txtdate" name="txtdate" value='<s:property value="txtdate"/>'></div>
        <input type="hidden" name="hidtxtdate" id="hidtxtdate" value='<s:property value="hidtxtdate"/>'>
    </td>
  </tr>
  <tr>
    <td align="right">Amount</td>
    <td>
        <input type="text" id="txtamount" name="txtamount" autocomplete="off" value='<s:property value="txtamount"/>'>
    </td>
    <td align="right">Description</td>
    <td colspan="2">
        <input type="text" id="txtmaindescription" name="txtmaindescription" autocomplete="off" style="width: 98%;" value='<s:property value="txtmaindescription"/>'>
    </td>
    <td align="center">
        <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch();">
    </td>
  </tr>
  <tr>
    <td colspan="6">
        <div id="refreshdiv">
            <jsp:include page="ijvMainSearchGrid.jsp"></jsp:include>
        </div>
    </td>
  </tr>
</table>
</div>
</body>
</html>