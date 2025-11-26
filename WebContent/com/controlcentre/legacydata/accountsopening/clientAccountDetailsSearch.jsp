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
	$(document).ready(function () {
		$("#txtaccperiod").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		document.getElementById("txtatypes").value=document.getElementById("cmbacctype").value;
		
		 var year = window.parent.txtaccountperiodfrom.value;
		// alert(year);
		 var newDate = year.split('-');
		 year = newDate[1] + "-" + newDate[0] + "-" + newDate[2];
		 $('#txtaccperiod ').jqxDateTimeInput('setDate', new Date(year));
	}); 

	function loadClientAccountSearch() {
			var clientaccountno=document.getElementById("accountsno").value;
			var clientaccountname=document.getElementById("accountsname").value;
			var clientmobile=document.getElementById("clientmobileno").value;
			var curr=document.getElementById("txtcurrencies").value;
			var accounttype=document.getElementById("txtatypes").value;
			var date = document.getElementById("txtaccperiod").value;
			var checked = 1;
	
			getClientAccountDetails(clientaccountno,clientaccountname,clientmobile,curr,accounttype,date,checked);
	}
		
	function getClientAccountDetails(clientaccountno,clientaccountname,clientmobile,curr,accounttype,date,checked){
		 $("#refreshClientAccountDiv").load("clientAccountDetailsSearchGrid.jsp?accountno="+clientaccountno+'&accountname='+clientaccountname.replace(/ /g, "%20")+'&mobile='+clientmobile+'&currency='+curr+'&atype='+accounttype+'&date='+date+'&check='+checked);
	}

</script>
<body>
<div id="search" style="padding: 18px; background: #fff; border-radius: 12px;
     box-shadow: 0 3px 12px rgba(0,0,0,0.08); font-family: 'Poppins', sans-serif;">

<table width="100%" style="border-collapse: separate; border-spacing: 0 10px;">

  <!-- 🔹 ROW 1 -->
  <tr>

    <td width="12%" align="right" style="font-weight:600; color:#1A3E7A;">Account No</td>
    <td width="33%">
      <input type="text" name="accountsno" id="accountsno"
             style="width:90%; padding:7px 10px; border:1px solid #cfe0ff;
             border-radius:6px; background:#f9fbff;">
    </td>

    <td width="10%" align="right" style="font-weight:600; color:#1A3E7A;">Currency</td>
    <td width="15%">
      <input type="text" name="txtcurrencies" id="txtcurrencies"
             style="width:85%; padding:7px 10px; border:1px solid #cfe0ff;
             border-radius:6px; background:#f9fbff;">
      <input type="hidden" name="txtatypes" id="txtatypes">
      <div hidden id="txtaccperiod"></div>
    </td>

    <td width="10%" align="right" style="font-weight:600; color:#1A3E7A;">Mobile</td>
    <td width="20%">
      <input type="text" name="clientmobileno" id="clientmobileno"
             style="width:90%; padding:7px 10px; border:1px solid #cfe0ff;
             border-radius:6px; background:#f9fbff;">
    </td>

  </tr>

  <!-- 🔹 ROW 2 -->
  <tr>
    <td align="right" style="font-weight:600; color:#1A3E7A;">Account Name</td>
    <td colspan="4">
      <input type="text" name="accountsname" id="accountsname"
             style="width:95%; padding:7px 10px; border:1px solid #cfe0ff;
             border-radius:6px; background:#f9fbff;">
    </td>

    <td align="center">
      <button id="btnClientAccountSearch" onclick="loadClientAccountSearch()"
              style="padding:8px 20px; background:linear-gradient(90deg,#1E88E5,#1565C0);
              border:none; border-radius:25px; color:white; font-weight:600;
              cursor:pointer; box-shadow:0 3px 8px rgba(21,101,192,0.25);
              transition:0.3s;">
        Search
      </button>
    </td>
  </tr>

  <!-- 🔹 GRID -->
  <tr>
    <td colspan="6" style="padding-top:12px;">
      <div id="refreshClientAccountDiv"
           style="background:#ffffff; border-radius:10px;
           padding:10px; box-shadow:0 2px 8px rgba(0,0,0,0.05);">
        <jsp:include page="clientAccountDetailsSearchGrid.jsp"></jsp:include>
      </div>
    </td>
  </tr>

</table>
</div>

</body>
</html>