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
<style>
/* -----------------------------
   Premium Blue Theme – FADP Search
-------------------------------- */

/* Page background */
body {
    font-family: "Segoe UI", Arial, sans-serif;
    background: #f4f9ff;
    margin: 0;
    padding: 10px;
}

/* Search container */
#search {
    background: #ffffff;
    border: 1px solid #d2e6ff;
    padding: 15px;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0, 95, 180, 0.18);
    animation: fadeIn 0.3s ease-in-out;
}

/* Table cells */
#search table td {
    padding: 6px 4px;
    font-size: 14px;
    color: #003d66;
}

/* Input fields */
#search input[type="text"] {
    width: 95%;
    padding: 6px 8px;
    border: 1px solid #a9c9f8;
    border-radius: 6px;
    font-size: 13px;
    outline: none;
    transition: all 0.2s ease;
}

#search input[type="text"]:focus {
    border-color: #0077e6;
    box-shadow: 0 0 5px rgba(0, 119, 230, 0.35);
}

/* Search button */
.myButton {
    padding: 7px 18px;
    font-size: 13px;
    font-weight: 600;
    background: linear-gradient(135deg, #0077e6, #005bb5);
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    box-shadow: 0 3px 10px rgba(0, 100, 200, 0.25);
    transition: all 0.25s ease;
}

.myButton:hover {
    background: linear-gradient(135deg, #005bb5, #004a99);
    transform: translateY(-2px);
    box-shadow: 0 5px 14px rgba(0, 90, 180, 0.35);
}

.myButton:active {
    transform: translateY(0px);
    box-shadow: 0 2px 6px rgba(0, 80, 160, 0.25);
}

/* jqx date time input fix */
#fadpdate {
    border: 1px solid #a9c9f8 !important;
    border-radius: 6px !important;
}

/* Refresh grid container */
#refreshdiv {
    margin-top: 10px;
    background: #ffffff;
    padding: 10px;
    border-radius: 10px;
    border: 1px solid #cfe2ff;
    box-shadow: 0 3px 10px rgba(0, 110, 200, 0.12);
}

/* Subtle fade animation */
@keyframes fadeIn {
    from { opacity: 0; transform: translateY(5px); }
    to { opacity: 1; transform: translateY(0); }
}
</style>
<style>
/* MEDIUM SIZE + PERFECT ALIGNMENT */
#search table td[align="right"] {
    font-size: 16px !important;
    font-weight: 600 !important;
    color: #2c3e50 !important;
    padding: 12px 8px !important;
    width: 80px !important;
    vertical-align: middle !important;
    text-align: right !important;
}

#search table td input[type="text"] {
    height: 42px !important;
    padding: 0 14px !important;
    border: 2px solid #e2e8f0 !important;
    border-radius: 8px !important;
    font-size: 15px !important;
    background: #ffffff !important;
    box-shadow: 0 2px 8px rgba(0,0,0,0.06) !important;
    transition: all 0.3s ease !important;
    font-weight: 500 !important;
    box-sizing: border-box !important;
    vertical-align: middle !important;
}

#search table td input[type="text"]:hover {
    border-color: #4a90e2 !important;
    box-shadow: 0 4px 12px rgba(74,144,226,0.2) !important;
    transform: translateY(-1px) !important;
}

#search table td input[type="text"]:focus {
    outline: none !important;
    border-color: #4a90e2 !important;
    box-shadow: 0 0 0 3px rgba(74,144,226,0.15) !important;
}

/* Name field wider */
#txtpartyname {
    width: 100% !important;
}
</style>

	<script type="text/javascript">
	$(document).ready(function () {
	 	$("#fadpdate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {

 		var partyname=document.getElementById("txtpartyname").value;
 		var docNo=document.getElementById("txtdocno").value;
 		var date=document.getElementById("fadpdate").value;
 		var amount=document.getElementById("txtamount").value;
 		var branch=document.getElementById("brchName").value;
	
		getdata(partyname,docNo,date,amount,branch);
	}
	function getdata(partyname,docNo,date,amount,branch){
		 $("#refreshdiv").load('fadpMainSearchGrid.jsp?partyname='+partyname.replace(/ /g, "%20")+'&docNo='+docNo+'&date='+date+'&amount='+amount+'&branch='+branch);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="6%" align="right">Date</td>
    <td width="14%"><div id="fadpdate" name="fadpdate"  value='<s:property value="fadpdate"/>'></div>
        <input type="hidden" name="hidfadpdate" id="hidfadpdate" value='<s:property value="hidfadpdate"/>'></td>
    <td width="21%" align="right">Doc No</td>
    <td width="32%"><input type="text" name="txtdocno" id="txtdocno" value='<s:property value="txtdocno"/>'></td>
    <td width="27%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td align="right">Name</td>
    <td colspan="2"><input type="text" name="txtpartyname" id="txtpartyname" style="width:100%" value='<s:property value="txtpartyname"/>'></td>
    <td align="right">Total</td>
    <td><input type="text" name="txtamount" id="txtamount" value='<s:property value="txtamount"/>'></td>
  </tr>
  <tr>
    <td colspan="5"><div id="refreshdiv"><jsp:include page="fadpMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>