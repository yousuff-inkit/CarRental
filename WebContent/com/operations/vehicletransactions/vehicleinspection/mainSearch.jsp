<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>

<% String contextPath=request.getContextPath();%>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>GatewayERP(i)</title>

<script type="text/javascript">

$(document).ready(function () {

$("#searchdate").jqxDateTimeInput({
    width: '125px',
    height: '30px',
    formatString:"dd.MM.yyyy",
    value:null
});

}); 

function mainloadSearch() {

var fleetno=document.getElementById("searchfleet").value;
var cmbtype=document.getElementById("searchcmbtype").value;
var cmbreftype=document.getElementById("searchcmbreftype").value;
var refdocno=document.getElementById("searchrdocno").value;
var docno=document.getElementById("searchdocno").value;
var regno=document.getElementById("searchregno").value;
var searchdate=$('#searchdate').jqxDateTimeInput('val');
var branch=$('#brchName').val();

getdata(fleetno,cmbtype,cmbreftype,refdocno,docno,searchdate,branch,regno);

}

function getdata(fleetno,cmbtype,cmbreftype,refdocno,docno,searchdate,branch,regno){

$("#srefreshdiv").load(
'subMainSearch.jsp?fleetno='+fleetno+
'&cmbtype='+cmbtype+
'&cmbreftype='+cmbreftype+
'&refdocno='+refdocno+
'&docno='+docno+
'&searchdate='+searchdate+
'&branch='+branch+
'&regno='+regno
);

}

</script>


<style>

/* CASH RECEIPTS STYLE */

#search table{
border-collapse:separate;
border-spacing:15px 18px;
}

#search td[align="right"]{
font-family:'Segoe UI','Roboto','Arial',sans-serif;
font-weight:500;
font-size:14px;
color:#222;
}

#search input[type="text"],
#search select{
font-family:'Segoe UI','Roboto','Arial',sans-serif;
font-weight:500;
font-size:14px;
padding:6px 10px;
height:32px;
width:100%;
box-sizing:border-box;
}

#searchdate{
font-size:14px;
font-weight:500;
}



#search tr{
line-height:1.6;
}

</style>


</head>

<body bgcolor="#E0ECF8">

<div id="search">

<table width="100%">

<tr>

<td width="6%" align="right">Doc No</td>
<td width="11%">
<input type="text" name="searchdocno" id="searchdocno" value='<s:property value="searchdocno"/>'>
</td>

<td width="5%" align="right">Type</td>
<td width="15%">
<select name="searchcmbtype" id="searchcmbtype">
<option value="">--Select--</option>
<option value="IN">IN</option>
<option value="OUT">OUT</option>
</select>
</td>

<td width="15%" align="right">Ref Doc No</td>
<td width="15%">
<input type="text" name="searchrdocno" id="searchrdocno" value='<s:property value="searchrdocno"/>'>
</td>

<td width="9%" align="right">Reg No</td>
<td width="16%">
<input type="text" name="searchregno" id="searchregno">
</td>

</tr>


<tr>

<td align="right">Date</td>
<td>
<div id="searchdate" name="searchdate"></div>
</td>

<td align="right">Fleet</td>
<td>
<input type="text" name="searchfleet" id="searchfleet">
</td>

<td align="right">Ref Type</td>
<td>
<select name="searchcmbreftype" id="searchcmbreftype">
<option value="">--Select--</option>
<option value="RAG">Rental</option>
<option value="LAG">Lease</option>
<option value="NRM">Non Revenue Movement</option>
<option value="RPL">Replacement</option>
</select>
</td>

<td colspan="2" align="center">

<input type="button"
name="btninvsearch"
id="btninvsearch"
class="myButton"
value="Search"
onclick="mainloadSearch();">

</td>

</tr>


<tr>

<td colspan="8">

<div id="srefreshdiv">

<jsp:include page="subMainSearch.jsp" />

</div>

</td>

</tr>

</table>

</div>

</body>
</html>