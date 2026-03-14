 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <%--  <jsp:include page="../../../../includes.jsp"></jsp:include>   --%>
<style>
<%-- <link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
 --%>
</style>

	<script type="text/javascript">
	$(document).ready(function () {
		$("#searchdate").jqxDateTimeInput({ width: '100%', height: '15px',formatString:"dd.MM.yyyy",value:null});
		/* document.body.scroll = "no";
		document.body.style.overflow = 'hidden';
		//document.height = window.innerHeight; */
		funChangeDeletedInv();
	}); 
	function funChangeDeletedInv(){
		if(document.getElementById("chkdeletedinv").checked==true){
			document.getElementById("hidchkdeletedinv").value="1";
		}
		else{
			document.getElementById("hidchkdeletedinv").value="0";
		}
	}
 	function mainloadSearch() {
 		
 		if(document.getElementById("searchagmtno").value!=""){
 			if(document.getElementById("searchcmbagmttype").value==""){
 				document.getElementById("errormsg").innerText="";
 				document.getElementById("errormsg").innerText="Agreement Type is Mandatory";
 				return false;
 			}
 		}
 		document.getElementById("errormsg").innerText="";
 		var client=document.getElementById("searchclient").value;
 		var cmbagmttype=document.getElementById("searchcmbagmttype").value;
 		var agmtno=document.getElementById("searchagmtno").value;
 		var docno=document.getElementById("searchdocno").value;
 		var searchdate=$('#searchdate').jqxDateTimeInput('val');
 		document.getElementById("brchName").disabled=false;
 		var searchbranch=$('#brchName').val();
 		var chkdeletedinv=$('#hidchkdeletedinv').val();
		getdata(client,cmbagmttype,agmtno,docno,searchdate,searchbranch,chkdeletedinv);
 

	}
	function getdata(client,cmbagmttype,agmtno,docno,searchdate,searchbranch,chkdeletedinv){
		$("#srefreshdiv").load('subMainSearch.jsp?client='+client+'&cmbagmttype='+cmbagmttype+'&agmtno='+agmtno+'&docno='+docno+'&searchdate='+searchdate+'&branch='+searchbranch+'&chkdeletedinv='+chkdeletedinv+'&id=1');
	}
 
	</script>
<style type="text/css">
/* Master UI Styles */

table {
  border-collapse: separate;
  border-spacing: 15px 18px; /* Standard master gap */
}


td[align="right"] {
  font-weight: 700;
  font-size: 14px;
  color: #222;
  font-family: Tahoma, Arial, sans-serif;
}


input[type="text"], select {
  font-weight: 600;
  font-size: 14px;
  padding: 8px 12px;
  width: 95%; 
  max-width: 100%;
  box-sizing: border-box; 
  font-family: Tahoma, Arial, sans-serif;
}


#searchdate {
  font-weight: 600;
  font-size: 14px;
  font-family: Tahoma, Arial, sans-serif;
}

/* Master Button Appearance */
.myButton {
  font-weight: 700;
  font-size: 14px;
  background-color: #007bff; /* Master green */
  color: white;
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  box-shadow: 0 2px 5px rgba(0,0,0,0.2);
  transition: background-color 0.3s;
  font-family: Tahoma, Arial, sans-serif;
}

/* Button Hover Effects */
.myButton:hover {
  background-color: #45a049;
}

/* Checkbox Label Styling */
td[align="center"] {
  font-weight: 600;
  font-size: 14px;
  color: #222;
  font-family: Tahoma, Arial, sans-serif;
}

/* Additional spacing for rows */
tr {
  line-height: 1.8;
}
#search td[align="right"]{
    font-weight:700;
    font-size:14px;
    color:#222;
}
</style>

<body bgcolor="#E0ECF8">
<div id="search">

<table width="100%">

<tr>
    <td width="6%" align="right">Date</td>
    <td width="14%">
        <div id="searchdate" name="searchdate"></div>
    </td>

    <td width="21%" align="right">Doc No</td>
    <td width="32%">
        <input type="text" name="searchdocno" id="searchdocno"
        value='<s:property value="searchdocno"/>'>
    </td>

    <td width="27%" align="center" rowspan="2">
        <input type="button" name="btninvsearch" id="btninvsearch"
        class="myButton" value="Search" onClick="mainloadSearch();">
    </td>
</tr>

<tr>
    <td align="right">Client</td>
    <td>
        <input type="text" name="searchclient" id="searchclient"
        value='<s:property value="searchclient"/>'>
    </td>

    <td align="right">Ref Type</td>
    <td>
        <select name="searchcmbagmttype" id="searchcmbagmttype">
            <option value="">--Select--</option>
            <option value="RAG">Rental</option>
            <option value="LAG">Lease</option>
        </select>
    </td>
</tr>

<tr>
    <td align="right">Agmt No</td>
    <td>
        <input type="text" name="searchagmtno" id="searchagmtno"
        value='<s:property value="searchagmtno"/>'>
    </td>

    <td colspan="2">
        <input type="checkbox" name="chkdeletedinv" id="chkdeletedinv"
        onchange="funChangeDeletedInv();">
        Deleted Invoices
    </td>

    <td></td>
</tr>

<tr>
<td colspan="5">
<div id="srefreshdiv">
<jsp:include page="subMainSearch.jsp" />
</div>
</td>
</tr>

</table>

</div>
</body>