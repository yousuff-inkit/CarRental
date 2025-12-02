 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%> 
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
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
    #msearchdiv {
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
        width: 100%;
    }

    tr {
        height: 40px;
    }
</style>

	<script type="text/javascript">
		$(document).ready(function () {
			$("#msearchdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
		});
	
 		function mainloadSearch() {
 		
 			var date=$('#msearchdate').jqxDateTimeInput('val');
 			var fleetno=document.getElementById("msearchfleetno").value;
 			var docno=document.getElementById("msearchdocno").value;
			var flname=document.getElementById("msearchflname").value;
 			var brhid=document.getElementById("brchName").value;
			$('#msearchdiv').load('masterSearchGrid.jsp?date='+date+'&fleetno='+fleetno+'&docno='+docno+'&flname='+flname+'&id=1&brhid='+brhid);
		}

	</script>
	<body bgcolor="#E0ECF8">
		<div id=search>
  			<table width="100%" border="0">
    			<tr>
    				<td width="12%" align="right">Doc No</td>
    				<td width="14%" align="left"><input type="text" name="msearchdocno" id="msearchdocno"></td>
    				<td width="7%" align="right">Date</td>
    				<td width="13%" align="left"><div id="msearchdate" name="msearchdate"></div></td>
    				<td width="13%" align="right">Fleet No</td>
    				<td width="15%" align="left"><input type="text" name="msearchfleetno" id="msearchfleetno"></td></tr>
				<tr>
    				<td align="right">Fleet Name</td>
    				<td align="left" colspan="4"><input type="text" name="msearchflname" id="msearchflname" style="width:98%;" ></td>
    				<td align="center"><input type="button" name="btnmastersearch" id="btnmastersearch" class="myButton" value="Search" onClick="mainloadSearch();"></td>
				</tr>
  				<tr>
  					<td colspan="6">
   						<div id="msearchdiv"><jsp:include  page="masterSearchGrid.jsp"></jsp:include></div>
   					</td>
  				</tr>
	 		</table>
		</div>
	</body>
</html>