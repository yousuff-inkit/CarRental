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
<% String value=request.getParameter("value")==null?"0":request.getParameter("value"); %>
<script type="text/javascript">
function loadAccountSearch() {
	        var values='<%=value%>';
			var accountsno=document.getElementById("txtaccountsno").value;
			var accountsname=document.getElementById("txtaccountsname").value;
			var dates=$('#masterdate').val();
			var check = 1;
	
			getAccountDetails(accountsno,accountsname,dates,check,values);
	}
		
	function getAccountDetails(accountsno,accountsname,dates,check,values){
		 $("#ss").load("detailsSearchGrid.jsp?accountno="+accountsno+'&accountname='+accountsname.replace(/ /g, "%20")+'&dates='+dates+'&check='+check+'&values='+values);
	}

</script>
<style type="text/css">
/* Master UI Styles */

table {
  border-collapse: separate;
  border-spacing: 15px 18px; 
}


td[align="right"] {
  font-weight: 700;
  font-size: 14px; /* Default master font size */
  color: #222;
}

/* Overriding the default master label style for the specific 9px inline styles */
/* Note: The inline style font-size:9px; on the <td> will take precedence over the 14px master style */
td[align="right"][style*="font-size:9px"] {
  font-weight: 700; /* Keeping master bold */
  color: #222;
  /* font-size: 9px; is preserved by the inline style in the HTML */
}


input[type="text"] {
  font-weight: 600;
  font-size: 14px;
  padding: 8px 12px;
  /* Resetting width to use inline styles for width, but applying padding/font */
  max-width: 100%;
  box-sizing: border-box; /* Include padding in width */
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
</style>

<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="10%" align="right" style="font-size:9px;">Account No</td>
    <td width="51%"><input type="text" name="txtaccountsno" id="txtaccountsno" style="width:70%;" value='<s:property value="txtaccountsno"/>'></td>
    <td width="39%" align="center"><input type="button" name="btnAccountSearch" id="btnAccountSearch" class="myButton" value="Search"  onclick="loadAccountSearch();"></td>
  </tr>
  <tr>
    <td align="right" style="font-size:9px;">Account Name</td>
    <td colspan="2"><input type="text" name="txtaccountsname" id="txtaccountsname" style="width:70%;" value='<s:property value="txtaccountsname"/>'></td>
  </tr>
  <tr>
   <td colspan="3">
     <div id="ss">
       <jsp:include page="detailsSearchGrid.jsp" />
     </div>
   </td>
  </tr>
</table>
</div>
</body>
</html>