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

<script type="text/javascript">
	$(document).ready(function () {}); 
	
	function loadAccountSearch() {
			var accountsno=document.getElementById("txtcmaccountsno").value;
			var accountsname=document.getElementById("txtcmaccountsname").value;
			var cmatype=document.getElementById("cmatype").value;

			var dates=$('#todate').val();
			var check = 1;
	
			getAccountDetails(accountsno,accountsname,dates,check,cmatype);
	}
		
	function getAccountDetails(accountsno,accountsname,dates,check,cmatype){
		 $("#refreshcmAccountDetailsDiv").load("cmaccountDetailsSearchGrid.jsp?accountno="+accountsno+'&accountname='+accountsname.replace(/ /g, "%20")+'&dates='+dates+'&check='+check+'&cmatype='+cmatype);
	}

</script>
<body>
<div id=cmsearch>
<table width="100%">
  <tr>
    <td width="10%" align="right" style="font-size:9px;">Account Type</td>
    <td width="30%"><input type="text" name="cmatype" id="cmatype" style="width:70%;height:20px;" value='<s:property value="cmatype"/>'></td>
  
    <td width="10%" align="right" style="font-size:9px;">Account No</td>
    <td width="30%"><input type="text" name="txtcmaccountsno" id="txtcmaccountsno" style="width:70%;height:20px;" value='<s:property value="txtcmaccountsno"/>'></td>
   
    <td width="39%" align="center"><input type="button" name="btnAccountSearch" id="btnAccountSearch" class="myButton" value="Search"  onclick="loadAccountSearch();"></td>
  </tr>
  <tr>
    <td align="right" style="font-size:9px;">Account Name</td>
    <td colspan="2"><input type="text" name="txtcmaccountsname" id="txtcmaccountsname" style="width:70%;height:20px;" value='<s:property value="txtcmaccountsname"/>'></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshcmAccountDetailsDiv"><jsp:include page="cmaccountDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>