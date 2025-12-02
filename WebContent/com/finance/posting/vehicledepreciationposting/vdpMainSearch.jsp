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
    /* Body styling */
    body {
        background-color: #E0ECF8;
        font-family: "Segoe UI", Roboto, sans-serif;
        margin: 0;
        padding: 0;
        color: #000000; /* Black text */
    }

    /* Outer Search Box */
    #search {
        width: 95%;
        margin: 15px auto;
        padding: 15px;
        background: #ffffff;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 92, 184, 0.18);
        border: 1px solid #c6ddf5;
    }

    /* Labels */
    td {
        font-size: 14px;
        color: #000000; /* Black text */
        padding: 4px 8px;
    }

    /* Input Fields */
    input[type="text"] {
        width: 95%;
        padding: 6px 8px;
        border: 1px solid #b7d1ee;
        border-radius: 6px;
        outline: none;
        transition: 0.3s;
        font-size: 13px;
        background: #ffffff;
        color: #000000;
    }

    input[type="text"]:focus {
        border-color: #0d6efd;
        box-shadow: 0 0 4px rgba(13, 110, 253, 0.4);
    }

    /* jqxDateTimeInput styling */
    .jqx-widget-content {
        font-size: 13px;
        color: #000000;
        border-radius: 6px;
        border: 1px solid #b7d1ee;
    }

    /* Search Button */
    .myButton {
        background: #0d6efd;
        color: white;
        padding: 8px 20px;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        font-size: 14px;
        font-weight: 600;
        transition: 0.3s;
        width: 120px;
    }

    .myButton:hover {
        background: #0b5ed7;
        box-shadow: 0 4px 10px rgba(13, 110, 253, 0.3);
        transform: translateY(-2px);
    }

    /* Grid / Refresh Div Styling */
    #refreshdiv {
        margin-top: 15px;
        padding: 10px;
        background: #ffffff;
        border: 1px solid #cfdaf0;
        border-radius: 10px;
        box-shadow: 0 3px 8px rgba(0, 92, 184, 0.12);
        color: #000000; /* Black text */
    }

    /* Table styling */
    table {
        border-collapse: collapse;
    }

    tr {
        height: 40px;
    }
</style>


	<script type="text/javascript">
	$(document).ready(function () {
	 	$("#vdpdate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {

 		var partyname=document.getElementById("txtpartyname").value;
 		var docNo=document.getElementById("txtdocno").value;
 		var date=document.getElementById("vdpdate").value;
 		var amount=document.getElementById("txtamount").value;
 		var branch=document.getElementById("brchName").value;
	
		getdata(partyname,docNo,date,amount,branch);
	}
	function getdata(partyname,docNo,date,amount,branch){
		 $("#refreshdiv").load('vdpMainSearchGrid.jsp?partyname='+partyname.replace(/ /g, "%20")+'&docNo='+docNo+'&date='+date+'&amount='+amount+'&branch='+branch);
		}

	</script>
<body>
<div id=search>
<table width="100%">
  <tr>
    <td width="6%" align="right">Date</td>
    <td width="14%"><div id="vdpdate" name="vdpdate"  value='<s:property value="vdpdate"/>'></div>
        <input type="hidden" name="hidvdpdate" id="hidvdpdate" value='<s:property value="hidvdpdate"/>'></td>
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
    <td colspan="5"><div id="refreshdiv"><jsp:include page="vdpMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
  </div>
</body>
</html>