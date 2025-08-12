<%@ taglib prefix="s" uri="/struts-tags" %>
 <%
 String date = request.getParameter("date")==null?"0":request.getParameter("date");
 String date1 = request.getParameter("date1")==null?"0":request.getParameter("date1");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<style>
.dfont{
	font-size:12px;
	font-family: Tahoma;
}
</style>
<script>
/* $(document).ready(function() {
	$("#searchagmtdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
    $('#btnagmtsearch').click(function(e) {
    	var accountsno=document.getElementById("txtaccountsno").value;
		var accountsname=document.getElementById("txtaccountsname").value;
		var currs=document.getElementById("txtaccountcurrency").value;
		var dates=document.getElementById("fromdate").value;
		var check = 1;
	$('#refreshAccountDetailsDiv').load('accountDetailsSearchGrid.jsp?accountno='+accountsno+'&accountname='+accountsname.replace(/ /g, "%20")+'&currency='+currs+'&check='+check);

    });
}); */

$(document).ready(function () {
	
	$("#searchagmtdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
   
	 /* document.getElementById("txtsearchtype").value=document.getElementById("txtforsearch").value;
	 document.getElementById("txtnewdates").value=$('#maindate').val(); */ 
}); 

function loadAccountSearch() {
		var accountsno=document.getElementById("txtaccountsno").value;
		var accountsname=document.getElementById("txtaccountsname").value;
		var currs=document.getElementById("txtaccountcurrency").value;
	    var searchtype="";
		var date='<%=date%>';
		var date1='<%=date1%>';
	    var check = 1;
		var dtype="UCR";

		getAccountDetails(accountsno,accountsname,currs,dtype,searchtype,date,date1,check);
}

function getAccountDetails(accountsno,accountsname,currs,dtype,searchtype,date,date1,check){
 $("#refreshAccountDetailsDiv").load('accountDetailsSearchGrid.jsp?accountno='+accountsno+'&id=1&accountname='+accountsname.replace(/ /g, "%20")+'&currency='+currs+'&dtype='+dtype+'&searchtype='+searchtype+'&dates='+date+'&date1='+date1+'&id=1');
	 //
}
</script>
</head>
<body>
<table width="100%" border="0">
  <tr>
    <td width="13%" align="right"><span class="dfont">Account No</span></td>
    <td width="15%"><input type="text" name="txtaccountsno" id="txtaccountsno" style="height:18px;"></td>
    <td width="11%" align="right"><span class="dfont">Currency</span></td>
    <td colspan="4"><input type="text" name="txtaccountcurrency" id="txtaccountcurrency" style="height:18px;width:100%;">
    <input type="hidden" name="txtnewdates" id="txtnewdates" value='<s:property value="txtnewdates"/>'></td>
   </tr>
  <tr>
    <td align="right"><span class="dfont">Account Name</span></td>
    <td><input type="text" name="txtaccountsname" id="txtaccountsname" style="height:18px;"></td>
   <td width="12%" align="right"><span class="dfont">Date</span></td>
    <td width="22%"><div id="searchagmtdate"></div></td>
    	 <td width="11%" align="center"><button type="button" name="btnagmtsearch" id="btnagmtsearch" class="myButton" onclick="loadAccountSearch();">Search</button></td></tr>
	
  <tr>
     <td colspan="5"><div id="refreshAccountDetailsDiv"><jsp:include page="accountDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>

</body>
</html>