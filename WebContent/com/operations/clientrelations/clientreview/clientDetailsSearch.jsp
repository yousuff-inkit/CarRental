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
	
	function loadClientDetailsSearch() {
			var clientaccountno=document.getElementById("accountsno").value;
			var clientaccountname=document.getElementById("accountsname").value;
			var clientmobile=document.getElementById("clientmobileno").value;
			var curr=document.getElementById("txtcurrencies").value;
			var checked = 1;
	
			getClientDetails(clientaccountno,clientaccountname,clientmobile,curr,checked);
	}
		
	function getClientDetails(clientaccountno,clientaccountname,clientmobile,curr,checked){
		 $("#refreshClientSearchDiv").load("clientSearchDetailsGrid.jsp?accountno="+clientaccountno+'&accountname='+clientaccountname.replace(/ /g, "%20")+'&mobile='+clientmobile.replace(/ /g, "%20")+'&currency='+curr+'&check='+checked);
	}

</script>
<style type="text/css">
/* Strict Scope to protect background page fonts */
#search {
    background-color: #ffffff;
    padding: 2px;
    font-family: Tahoma, Geneva, sans-serif !important;
}

#search table {
    border-collapse: separate;
    border-spacing: 4px 6px; /* Ultra-tight compact spacing */
    background-color: #ffffff;
    width: 100%;
}

/* Master UI Labels: Tahoma, Regular (Non-Bold), 13px */
#search td {
    font-family: Tahoma, Geneva, sans-serif !important;
    font-weight: 400 !important; 
    font-size: 13px;
    color: #222;
    white-space: nowrap;
}

/* Master UI Inputs: White Background, Grey Border, No Bold */
#search input[type="text"] {
    font-family: Tahoma, Geneva, sans-serif !important;
    font-weight: 400 !important;
    font-size: 13px;
    padding: 3px 6px;
    width: 100%;                
    box-sizing: border-box;   
    border: 1px solid #bdc3c7;
    border-radius: 3px;
    height: 24px;
    background-color: #ffffff !important;
    outline: none;
}

#search input[type="text"]:focus {
    border-color: #2563eb;
}

/* EXACT Master UI Gradient Button - Fixed 90px Width */
#search .myButton {
    font-family: Tahoma, Geneva, sans-serif !important;
    font-weight: 700 !important;
    font-size: 11px;
    width: 90px !important;
    height: 26px;
    padding: 0;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%) !important;
    color: #ffffff !important;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: all 0.2s ease;
    box-shadow: 0 1px 3px rgba(59, 130, 246, 0.2);
    text-transform: uppercase;
    text-align: center;
}

#search .myButton:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%) !important;
    transform: translateY(-1px);
}

#refreshClientSearchDiv {
    margin-top: 5px;
    border-top: 1px solid #eee;
}

</style>

<body bgcolor="#ffffff">
<div id="search">
    <table border="0">
        <tr>
            <td width="10%" align="right">Account No</td>
            <td width="20%">
                <input type="text" name="accountsno" id="accountsno" value='<s:property value="accountsno"/>'>
            </td>
            <td width="8%" align="right">Currency</td>
            <td width="12%">
                <input type="text" name="txtcurrencies" id="txtcurrencies" value='<s:property value="txtcurrencies"/>'>
                <input type="hidden" name="txtatypes" id="txtatypes" value='<s:property value="txtatypes"/>'>
                <input type="hidden" name="txtdocumenttypes" id="txtdocumenttypes" value='<s:property value="txtdocumenttypes"/>'>
            </td>
            <td width="8%" align="right">Mobile</td>
            <td width="15%">
                <input type="text" name="clientmobileno" id="clientmobileno" value='<s:property value="clientmobileno"/>'>
                <input type="hidden" name="txtcreditdebit" id="txtcreditdebit" value='<s:property value="txtcreditdebit"/>'>
            </td>
            <td width="27%"></td> </tr>
        <tr>
            <td align="right">Client Name</td>
            <td colspan="5">
                <input type="text" name="accountsname" id="accountsname" value='<s:property value="accountsname"/>'>
            </td>
            <td align="left" style="padding-left: 10px;">
                <input type="button" name="btnClientAccountSearch" id="btnClientAccountSearch" class="myButton" value="Search" onclick="loadClientDetailsSearch();">
            </td>
        </tr>
        <tr>
            <td colspan="7">
                <div id="refreshClientSearchDiv">
                    <jsp:include page="clientSearchDetailsGrid.jsp"></jsp:include>
                </div>
            </td>
        </tr>
    </table>
</div>
</body>
</html>