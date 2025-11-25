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
	 $("#roledate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {

 		var rolename=document.getElementById("txtuserrolename").value;
 		var docNo=document.getElementById("txtdocno").value;
 		var date=document.getElementById("roledate").value;
	
		getdata(rolename,docNo,date);
	}
	function getdata(rolename,docNo,date){
		 $("#refreshdiv").load('rleMainSearchGrid.jsp?rolename='+encodeURIComponent(rolename)+'&docNo='+docNo+'&date='+date);
		}

	</script>
<body>
<body>
<style>
    /* --- Premium Blue UI --- */

    #search {
        background: #ffffff;
        padding: 18px 20px;
        border-radius: 14px;
        box-shadow: 0 4px 20px rgba(30, 136, 229, 0.18);
        width: 95%;
        margin: auto;
        font-family: "Poppins", "Segoe UI", sans-serif;
    }

    #search table td {
        padding: 8px 6px;
        font-size: 14px;
        color: #1f2d50;
        font-weight: 500;
    }

    /* Inputs */
    input[type="text"] {
        width: 95%;
        height: 32px;
        padding: 6px 10px;
        border: 1px solid #c7d4eb;
        border-radius: 6px;
        background: white;
        font-size: 14px;
        transition: 0.2s;
    }
    input[type="text"]:hover,
    input[type="text"]:focus {
        border-color: #1E88E5;
        box-shadow: 0 0 6px rgba(30,136,229,0.30);
        outline: none;
    }

    /* Search Button */
    .myButton {
        background: linear-gradient(90deg, #1E88E5, #1565C0);
        padding: 8px 22px;
        border-radius: 8px;
        border: none;
        color: white;
        font-weight: 600;
        font-size: 14px;
        cursor: pointer;
        box-shadow: 0 3px 8px rgba(30,136,229,0.25);
        transition: 0.25s ease-in-out;
    }
    .myButton:hover {
        background: linear-gradient(90deg, #42A5F5, #1E88E5);
        transform: translateY(-2px);
    }
    .myButton:active {
        transform: scale(0.97);
    }

    /* Search Grid Container */
    #refreshdiv {
        background: #ffffff;
        border: 1px solid #d9e5f7;
        border-radius: 12px;
        padding: 10px;
        margin-top: 12px;
        box-shadow: 0 2px 10px rgba(30,136,229,0.10);
    }
</style>

<div id="search">
<table width="100%">
  <tr>
    <td width="6%" align="right">Date</td>
    <td width="14%">
        <div id="roledate" name="roledate" value='<s:property value="roledate"/>'></div>
        <input type="hidden" name="hidroledate" id="hidroledate" value='<s:property value="hidroledate"/>'>
    </td>

    <td width="21%" align="right">Doc No</td>
    <td width="32%">
        <input type="text" name="txtdocno" id="txtdocno" value='<s:property value="txtdocno"/>'>
    </td>

    <td width="27%" align="center">
        <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch();">
    </td>
  </tr>

  <tr>
    <td align="right">Name</td>
    <td colspan="4">
        <input type="text" name="txtuserrolename" id="txtuserrolename" style="width:100%" value='<s:property value="txtuserrolename"/>'>
    </td>
  </tr>

  <tr>
    <td colspan="5">
        <div id="refreshdiv"><jsp:include page="rleMainSearchGrid.jsp"></jsp:include></div>
    </td>
  </tr>
</table>
</div>
</body>

</body>
</html>