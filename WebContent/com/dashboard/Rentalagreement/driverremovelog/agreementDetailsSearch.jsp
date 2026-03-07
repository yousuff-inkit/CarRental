 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%--   <jsp:include page="../../../../includes.jsp"></jsp:include>   --%> 
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />


	<script type="text/javascript">
	$(document).ready(function () {
	
	}); 

 	function mainloadSearch() {
 		
 		var sclname=document.getElementById("SCl_name").value;
 		var smob=document.getElementById("Sl_mob").value;
 		var rno=document.getElementById("rno").value;
 		var flno=document.getElementById("flno").value;
 		var sregno=document.getElementById("sregno").value;
 		
 	 
 		  var branchval = document.getElementById("cmbbranch").value; 
	
		getdata(sclname,smob,rno,flno,sregno,branchval);

	}
	 function getdata(sclname,smob,rno,flno,sregno,branchval){
		 $("#srefreshdiv").load('agreementDetailsSearchGrid.jsp?sclname='+sclname+'&smob='+smob+'&rno='+rno+'&flno='+flno+'&sregno='+sregno+'&branchval='+branchval);
		}
 
	</script>
<style type="text/css">
/* ------------------------------
    MASTER UI CSS STANDARDS
------------------------------ */
body {
    background-color: #FFFFFF !important;
    font-family: Tahoma, Geneva, sans-serif;
    margin: 0;
    padding: 0;
}

#search {
    background-color: #FFFFFF !important;
    padding: 15px;
}

/* Table Layout: Standard Master UI Gaps */
table {
    border-collapse: separate;
    border-spacing: 12px 8px;
}

/* Labels: Tahoma 14px, Weight 600 */
.textdetail, td[align="right"], td[align="left"] label {
    font-family: Tahoma, Geneva, sans-serif;
    font-size: 14px;
    font-weight: 600;
    color: #222;
    white-space: nowrap;
}

/* Master Inputs: Grey Border #bdc3c7, Weight 600 */
input[type="text"] {
    font-family: Tahoma, Geneva, sans-serif;
    font-weight: 600;
    font-size: 14px;
    padding: 6px 10px;
    border: 1px solid #bdc3c7; 
    border-radius: 4px;
    background-color: #ffffff;
    box-sizing: border-box; /* Ensures width: % works with padding */
}

input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
}

/* Master Blue Button: #007bff, No Hover Color Change */
.myButton {
    font-family: Tahoma, Geneva, sans-serif;
    font-weight: 700;
    font-size: 14px;
    background-color: #007bff;
    color: white;
    padding: 8px 25px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.myButton:hover {
    background-color: #007bff; /* Stays blue per instructions */
    cursor: pointer;
}
</style>

<body bgcolor="#FFFFFF">
<div id="search">

<table width="100%" cellspacing="4" cellpadding="2">

<tr>

<td width="8%">
<label class="textdetail">Name</label>
</td>

<td width="32%">
<input type="text" name="SCl_name" id="SCl_name" style="width:95%;" value='<s:property value="SCl_name"/>'>
</td>

<td width="6%" align="right">
<label class="textdetail">Mob</label>
</td>

<td width="16%">
<input type="text" name="Sl_mob" id="Sl_mob" style="width:95%;" value='<s:property value="Sl_mob"/>'>
</td>

<td width="8%" align="right">
<label class="textdetail">Reg No</label>
</td>

<td width="16%">
<input type="text" id="sregno" name="sregno" style="width:95%;" value='<s:property value="sregno"/>'>
</td>

<td width="14%"></td>

</tr>


<tr>

<td>
<label class="textdetail">Doc No</label>
</td>

<td>
<input type="text" name="rno" id="rno" style="width:95%;" value='<s:property value="rno"/>'>
</td>

<td align="right">
<label class="textdetail">Fleet No</label>
</td>

<td>
<input type="text" name="flno" id="flno" style="width:95%;" value='<s:property value="flno"/>'>
</td>

<td colspan="3">
<input type="button" name="mbtnrasearch" id="mbtnrasearch"
class="myButton" value="Search" onclick="mainloadSearch();">
</td>

</tr>


<tr>
<td colspan="7">

<div id="srefreshdiv">
<jsp:include page="agreementDetailsSearchGrid.jsp"></jsp:include>
</div>

</td>
</tr>

</table>

</div>
</body>
</html>