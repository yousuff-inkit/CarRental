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

	<script type="text/javascript">
	$(document).ready(function () {
	 $("#leaveTravelDisbursementsDate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {

 		var empname=document.getElementById("txtempname").value;
 		var docNo=document.getElementById("txtdocno").value;
 		var date=document.getElementById("leaveTravelDisbursementsDate").value;
 		var amount=document.getElementById("txtamount").value;
	
		getdata(empname,docNo,date,amount);
	}
	function getdata(empname,docNo,date,amount){
		 $("#refreshdiv").load('ltdMainSearchGrid.jsp?empname='+empname.replace(/ /g, "%20")+'&docNo='+docNo+'&date='+date+'&amount='+amount);
		}

	</script>
	<style>
	/* Bold Labels + No Wrap */
#search td,
#search label {
    font-weight: 700 !important;
    white-space: nowrap !important;
    font-family: 'Segoe UI', Arial, sans-serif;
    color: #1A2734;
}

/* Input boxes */
#search input[type="text"] {
    width: 100%;
    padding: 6px 8px;
    height: 26px;
    border: 1px solid #b8c6d8;
    border-radius: 5px;
    font-weight: 600;
    background: #fff;
    box-sizing: border-box;
}

/* Calendar / Date Div */
#leaveTravelDisbursementsDate {
    border: 1px solid #b8c6d8 !important;
    background: #fff !important;
    border-radius: 5px;
    padding: 4px 6px;
}

/* Table Cell UI */
#search td {
    padding: 5px 6px;
    vertical-align: middle;
}

/* Premium Sky-Blue Small Button */
.myButton {
    background:#4FA8FF;
    color:#fff;
    border:none;
    padding:4px 12px;
    border-radius:6px;
    font-weight:700;
    font-size:13px;
    cursor:pointer;
    transition:0.2s ease-in-out;
}

.myButton:hover {
    background:#2F7FD4;
}

/* Fix layout */
#search table {
    width:100%;
    table-layout: fixed;
}
	
	</style>
<body>
<div id=search>
<table width="100%">

<tr>
    <td width="6%" align="right">Date</td>
    <td width="14%">
        <div id="leaveTravelDisbursementsDate"></div>
    </td>

    <td width="21%" align="right">Doc No</td>
    <td width="32%">
        <input type="text" name="txtdocno" id="txtdocno"
               value="<s:property value='txtdocno'/>" style="width:100%">
    </td>

    <td width="27%" rowspan="2" align="center">
        <input type="button" class="myButton" id="btnsearch"
               value="Search" onclick="loadSearch();">
    </td>
</tr>

<tr>
    <td align="right">Name</td>

    <!-- Name FULL WIDTH (same as before) -->
    <td width="14%">
        <input type="text" name="txtempname" id="txtempname"
               value="<s:property value='txtempname'/>" style="width:100%">
    </td>

    <td align="right">Amount</td>

    <!-- Amount sits UNDER Doc No with same width -->
    <td width="32%">
        <input type="text" name="txtamount" id="txtamount"
               value="<s:property value='txtamount'/>" style="width:100%">
    </td>
</tr>

<tr>
    <td colspan="5">
        <div id="refreshdiv">
            <jsp:include page="ltdMainSearchGrid.jsp"></jsp:include>
        </div>
    </td>
</tr>

</table>

  </div>
</body>
</html>