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
	<style type="text/css">


/* ===== Scoped styles ONLY for this search page ===== */
#search table {
    border-collapse: separate;
    border-spacing: 8px 8px;
    width: 100%;
}

/* Labels */
#search td[align="right"] {
    font-weight: 550;
    font-size: 15px;
    color: #1f2937;
    white-space: nowrap;
}

/* Text Inputs */
#search input[type="text"] {
    font-size: 15px;
    font-weight: 500;
    padding: 6px 10px;
    height: 32px;
    width: 100%;
    border: 1px solid #cbd5e1;
    border-radius: 6px;
    box-sizing: border-box;
}

/* Date picker container */
#search #datess {
    height: 36px;
}

/* jqx Date Input text */
#search #datess input {
    font-size: 15px;
    height: 34px;
}

/* Button */
#search .myButton {
    font-size: 15px;
    font-weight: 500;
    padding: 8px 18px;
    height: 38px;
    border-radius: 6px;
    border: 1px solid #2563eb;
    background-color: #2563eb;
    color: #ffffff;
    cursor: pointer;
}

#search .myButton:hover {
    background-color: #1d4ed8;
}

/* Row spacing */
#search tr {
    line-height: 1.2;
}

/* Result container spacing */
#search #refreshdivs {
    margin-top: 14px;
}

#search td[align="right"]{
    font-weight:700;
    font-size:14px;
    color:#222;
}
</style>
	<script type="text/javascript">

	$(document).ready(function () { 
	    
		   /* Date */ 	
	    $("#datess").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy",value:null}); 
		   
	});   
		   
 	function loadSearchs() {
 		
 		var docnoss=document.getElementById("docnoss").value;
 		var accountss=document.getElementById("accountss").value;
 		var accnamesss=document.getElementById("accnamess").value;
 		var datess=document.getElementById("datess").value;
;
 		
 		var accnamess = accnamesss.replace(' ', '%20');

		
	var aa="yes";
		getdata(docnoss,accountss,accnamess,datess,aa);
 

	}
	function getdata(docnoss,accountss,accnamess,datess,aa){
		
		 $("#refreshdivs").load('Subsearch.jsp?docnoss='+docnoss+'&accountss='+accountss+'&accnamess='+accnamess+'&datess='+datess+'&aa='+aa);

		}

	</script>
<body bgcolor="#E0ECF8">
<div id="search">

<table width="100%">

<tr>
<td>

<table width="100%">

<tr>

<td align="right" width="6%">Doc No</td>
<td width="20%">
<input type="text"
       name="docnoss"
       id="docnoss"
       style="width:90%;"
       value='<s:property value="docnoss"/>'>
</td>

<td align="right" width="10%">Account</td>
<td width="20%">
<input type="text"
       name="accountss"
       id="accountss"
       style="width:80%;"
       value='<s:property value="accountss"/>'>
</td>

<td align="right" width="14%">Account Name</td>
<td width="30%">
<input type="text"
       name="accnamess"
       id="accnamess"
       style="width:90%;"
       value='<s:property value="accnamess"/>'>
</td>

</tr>

</table>

</td>
</tr>


<tr>
<td>

<table width="100%">

<tr>

<td align="right" width="6%">Date</td>
<td width="20%">
<div id="datess" name="datess"
     value='<s:property value="datess"/>'></div>
</td>

<td width="54%"></td>

<td width="20%" align="center">
<input type="button"
       name="searchs"
       id="searchs"
       class="myButton"
       value="Search"
       onclick="loadSearchs()">
</td>

</tr>

</table>

</td>
</tr>


<tr>
<td>

<div id="refreshdivs">
<jsp:include page="Subsearch.jsp"></jsp:include>
</div>

</td>
</tr>

</table>

</div>
</body>
</html>