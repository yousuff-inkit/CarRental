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
		document.getElementById("txtnewmaindate").value=$('#maindate').val();
	}); 
	
	function loadAccountSearchGrid() {
			var accountsno=document.getElementById("txtacctno").value;
			var accountsname=document.getElementById("txtacctname").value;
			var currs=document.getElementById("txtacctcurrency").value;
			var type=document.getElementById("txttypes").value;
			var date=document.getElementById("txtnewmaindate").value;
			var check = 1;
	
			getAccountDetails(accountsno,accountsname,currs,type,date,check);
	}
		
	function getAccountDetails(accountsno,accountsname,currs,type,date,check){
		 $("#refreshAccountSearchDetailsDiv").load("bankReceiptSearchGrid.jsp?accountno="+accountsno+'&accountname='+accountsname.replace(/ /g, "%20")+'&currency='+currs+'&atype='+type+'&date='+date+'&check='+check);
	}

</script>
<style type="text/css">
/* ============================================================
   ACCOUNT SEARCH SECTION (Matches Professional Blue Theme)
   ============================================================ */

/* Wrapper Box */
#search {
    background: #f0f6ff; /* Light blue background */
    padding: 16px 20px;
    border-radius: 10px;
    box-shadow: 0 3px 12px rgba(30, 64, 175, 0.15);
    max-width: 100%;
    margin-bottom: 22px;
    border: 1px solid #c7d2fe;
}

/* Search Table */
#search table {
    width: 100%;
    border-collapse: collapse;
}

#search td {
    padding: 6px 10px;
    font-size: 0.95rem;
    color: #1e293b;
    font-weight: 500;
}

/* Labels in the search box */
#search td[align="right"] {
    color: #1e3a8a;
    font-weight: 600;
    padding-right: 8px;
}

/* Textboxes */
#search input[type="text"] {
    border: 1px solid #b0c4ff;
    background: #ffffff;
    border-radius: 6px;
    padding: 8px 12px;
    font-size: 0.95rem;
    width: 100%;
    box-sizing: border-box;
    transition: 0.25s;
}

#search input[type="text"]:focus {
    border-color: #3b82f6;
    box-shadow: 0 0 6px rgba(59, 130, 246, 0.45);
    outline: none;
}

/* Hidden fields styling */
#search input[type="hidden"] {
    display: none;
}

/* Search Button */
#btnAccountSearch {
    background: linear-gradient(90deg, #3b82f6, #1e3a8a);
    color: #ffffff;
    border: none;
    border-radius: 8px;
    padding: 10px 22px;
    font-size: 1rem;
    font-weight: 600;
    cursor: pointer;
    box-shadow: 0 4px 12px rgba(30, 58, 138, 0.3);
    transition: all 0.25s ease;
    width: 80%;
}

#btnAccountSearch:hover {
    background: linear-gradient(90deg, #1d4ed8, #1e3a8a);
    transform: translateY(-2px);
    box-shadow: 0 6px 16px rgba(30, 58, 138, 0.45);
}

#btnAccountSearch:active {
    transform: scale(0.97);
}

/* Search Result Grid Wrapper */
#refreshAccountSearchDetailsDiv {
    margin-top: 12px;
    background: #ffffff;
    border-radius: 10px;
    padding: 12px;
    box-shadow: 0 2px 10px rgba(30, 64, 175, 0.18);
    border: 1px solid #d0d7ff;
}
</style>
</head>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="10%" align="right">Account No</td>
    <td width="30%"><input type="text" name="txtacctno" id="txtacctno" style="width:85%;" value='<s:property value="txtacctno"/>'></td>
    <td width="10%" align="right">Currency</td>
    <td width="27%"><input type="text" name="txtacctcurrency" id="txtacctcurrency" style="width:50%;" value='<s:property value="txtacctcurrency"/>'>
    <input type="hidden" name="txttypes" id="txttypes" value='<s:property value="txttypes"/>'>
    <input type="hidden" name="txtnewmaindate" id="txtnewmaindate" value='<s:property value="txtnewmaindate"/>'></td>
    <td width="23%" rowspan="2" align="center"><input type="button" name="btnAccountSearch" id="btnAccountSearch" class="myButton" value="Search"  onclick="loadAccountSearchGrid();"></td>
  </tr>
  <tr>
    <td align="right">Account Name</td>
    <td colspan="3"><input type="text" name="txtacctname" id="txtacctname" style="width:80%;" value='<s:property value="txtacctname"/>'></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshAccountSearchDetailsDiv"><jsp:include page="bankReceiptSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>