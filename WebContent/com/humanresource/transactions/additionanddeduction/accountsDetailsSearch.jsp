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
	}); 
	
	function loadAccountSearch() {
			var accountsno=document.getElementById("txtaccountsno").value;
			var accountsname=document.getElementById("txtaccountsname").value;
			var atype=document.getElementById("txttypes").value;
			var check = 1;
			
			getAccountDetails(accountsno,accountsname,atype,check);
	}
		
	function getAccountDetails(accountsno,accountsname,atype,check){
		 $("#refreshAccountDetailsDiv").load("accountDetailsSearchGrid.jsp?accountno="+accountsno+'&accountname='+accountsname.replace(/ /g, "%20")+'&atype='+atype+'&check='+check);
	}

</script>
<style type="text/css">
#search {
    width: 850px;
    margin: 0 auto;
    background: #ffffff;
    border: 1px solid #ccc;
    font-family: Tahoma, Geneva, sans-serif;
}

#search table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 12px 10px; 
}

td[align="right"] {
    font-size: 13px;
    font-weight: 700;
    color: #333;
    white-space: nowrap;
}

input[type="text"] {
    font-family: Tahoma, Geneva, sans-serif;
    font-weight: 600;
    font-size: 12px;
    padding: 4px 8px;
    width: 100%;
    box-sizing: border-box;
    border: 1px solid #d1d5db;
    border-radius: 4px;
    height: 28px;
}

.myButton {
    font-family: Tahoma, Geneva, sans-serif;
    font-weight: 700;
    font-size: 13px;
    width: 130px;
    height: 38px;
    padding: 8px 12px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
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
    background: linear-gradient(135deg, #2563eb 0%, #0b45a2 100%);
    box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
    transform: translateY(-1px);
}

#refreshAccountDetailsDiv {
    margin-top: 10px;
    border-top: 1px solid #e0e4ee;
}
</style>

<body bgcolor="#E0ECF8">
<div id="search">
    <table border="0">
        <tr>
            <td width="15%" align="right">Account No.</td>
            <td width="55%">
                <input type="text" name="txtaccountsno" id="txtaccountsno" value='<s:property value="txtaccountsno"/>'>
                <input type="hidden" name="txttypes" id="txttypes" value='<s:property value="txttypes"/>'>
            </td>
            <td width="30%" rowspan="2" align="center" valign="middle">
                <input type="button" name="btnAccountSearch" id="btnAccountSearch" class="myButton" value="Search" onclick="loadAccountSearch();">
            </td>
        </tr>
        <tr>
            <td align="right">Account Name</td>
            <td>
                <input type="text" name="txtaccountsname" id="txtaccountsname" value='<s:property value="txtaccountsname"/>'>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <div id="refreshAccountDetailsDiv">
                    <jsp:include page="accountDetailsSearchGrid.jsp"></jsp:include>
                </div>
            </td>
        </tr>
    </table>
</div>
</body>
</html>