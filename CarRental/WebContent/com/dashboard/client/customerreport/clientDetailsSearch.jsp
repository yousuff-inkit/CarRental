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
	
	
	function loadAccountSearch() {
	 
		

			 
			var accountsname=document.getElementById("txtaccountsname").value;
			var accountno=document.getElementById("txtaccountsno").value;
			var mob=document.getElementById("txtaccountsmob").value;
			var check = 1;
	
			getAccountDetails(accountsname,check,accountno,mob);
	}
		
	function getAccountDetails(accountsname,check,accountno,mob){

		 $("#refreshAccountDetailsDiv").load("accountsDetailsFromGrid.jsp?accountname="+accountsname.replace(/ /g, "%20")+'&check='+check+'&account='+accountno+'&mob='+mob);
	}

</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="10%" align="right"><label style="font-size:9px;">Client Name</label></td>
    <td width="30%"><input type="text" name="txtaccountsname" id="txtaccountsname" style="height:20px;"value='<s:property value="txtaccountsname"/>'></td>
    <td width="10%" align="right"><label style="font-size:9px;">Account</label></td>
    <td width="30%"><input type="text" name="txtaccountsno" id="txtaccountsno" style="height:20px;"value='<s:property value="txtaccountsno"/>'></td>
    
  </tr>
  <tr>
   <td width="10%" align="right"><label style="font-size:9px;">Mob</label></td>
    <td width="30%"><input type="text" name="txtaccountsmob" id="txtaccountsmob" style="height:20px;"value='<s:property value="txtaccountsmob"/>'></td>
          <td><input type="hidden" name="txtsearchtype" id="txtsearchtype" value='<s:property value="txtsearchtype"/>'></td>
     
      <td width="23%"align="center"><input type="button" name="btnAccountSearch" id="btnAccountSearch" class="myButton" value="Search"  onclick="loadAccountSearch();"></td>
  
  </tr>
  <tr>
    <td colspan="5"><div id="refreshAccountDetailsDiv"><jsp:include page="accountsDetailsFromGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>