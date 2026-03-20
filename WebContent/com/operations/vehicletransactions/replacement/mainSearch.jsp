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
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

</style>

	<script type="text/javascript">
	$(document).ready(function () {
		 $("#msearchdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function mainloadSearch() {
 	
 		
 		if(document.getElementById("searchagmtno").value!=""){
 			if(document.getElementById("cmbsearchrtype").value==""){
 				document.getElementById("errormsg").innerText="";
 				document.getElementById("errormsg").innerText="Agmt Type is Mandatory";
 				return false;
 			}
 		}
 		
 		var client=document.getElementById("searchclient").value;
 		var reftype=document.getElementById("cmbsearchrtype").value;
 		var searchdate=$('#msearchdate').jqxDateTimeInput('val');
 		var agmtno=document.getElementById("searchagmtno").value;
 		var fleetno=document.getElementById("searchfleetno").value;
 		var docno=document.getElementById("searchdocno").value;
	
		getdata(client,reftype,searchdate,agmtno,fleetno,docno);
 

	}
	 function getdata(client,reftype,searchdate,agmtno,fleetno,docno){
		
		// $("#tariffDivId").load('rateDescription.jsp?txtrentaldocno='+indexVal1+'&revehGroup='+revehGroup);
		
		 $("#srefreshdiv").load('subMainSearch.jsp?client='+client+'&reftype='+reftype+'&searchdate='+searchdate+'&agmtno='+agmtno+'&fleetno='+fleetno+'&docno='+docno);
		 

		  
/* x.open("GET", "dissearch.jsp?sclname="+sclname+"&smob="+smob+"&rno="+rno+"&flno="+flno+"&sregno="+sregno+"&smra="+smra, true);
		x.send(); */
		}
 
	</script>
<style type="text/css">
/* Master UI Styles */

table {
  border-collapse: separate;
  border-spacing: 15px 18px; 
}


td[align="right"] {
  font-weight: 700;
  font-size: 14px;
  color: #222;
}


input[type="text"], select {
  font-weight: 600;
  font-size: 14px;
  padding: 8px 12px;
  width: 95%; /* Prevent overflow */
  max-width: 100%;
  box-sizing: border-box; /* Include padding in width */
}


#msearchdate {
  font-weight: 600;
  font-size: 14px;
}

/* Bold button text */
.myButton {
  font-weight: 700;
  font-size: 14px;
  /* Visual Button Appearance for consistency */
  background-color: #007BFF; /* Green background */
  color: white; /* White text */
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  box-shadow: 0 2px 5px rgba(0,0,0,0.2);
  transition: background-color 0.3s;
}

/* Button Hover/Active Effects */
.myButton:hover {
  background-color: #007BFF; /* Darker green on hover */
}

/* Additional spacing for rows */
tr {
  line-height: 1.8;
}
</style>

<body bgcolor="#FFFFFF">

<div id="search">

<table width="100%" style="table-layout:fixed;border-collapse:separate;border-spacing:15px 18px;font-family:'Segoe UI','Roboto','Arial',sans-serif;">

<tr>

<td align="right" width="10%" style="font-weight:700;font-size:14px;color:#222;">Name</td>

<td width="25%">
<input type="text"
name="searchclient"
id="searchclient"
style="width:95%;font-size:14px;font-weight:600;padding:8px 12px;box-sizing:border-box;"
value='<s:property value="searchclient"/>'>
</td>


<td align="right" width="10%" style="font-weight:700;font-size:14px;color:#222;">Type</td>

<td width="20%">
<select name="cmbsearchrtype"
id="cmbsearchrtype"
style="width:95%;font-size:14px;font-weight:600;padding:8px 10px;box-sizing:border-box;">
<option value="">--Select--</option>
<option value="RAG">Rental</option>
<option value="LAG">Lease</option>
</select>
</td>


<td align="right" width="10%" style="font-weight:700;font-size:14px;color:#222;">Date</td>

<td width="25%">
<div id="msearchdate"
name="msearchdate"
value='<s:property value="msearchdate"/>'></div>
</td>


<td rowspan="2" align="center">

<input type="button"
name="mbtnrasearch"
id="mbtnrasearch"
class="myButton"
value="Search"
onclick="mainloadSearch();">

</td>

</tr>



<tr>

<td align="right" width="10%" style="font-weight:700;font-size:14px;color:#222;">Agmt NO</td>

<td width="25%">
<input type="text"
name="searchagmtno"
id="searchagmtno"
style="width:95%;font-size:14px;font-weight:600;padding:8px 12px;box-sizing:border-box;"
value='<s:property value="searchagmtno"/>'>
</td>


<td align="right" width="10%" style="font-weight:700;font-size:14px;color:#222;">Fleet NO</td>

<td width="20%">
<input type="text"
name="searchfleetno"
id="searchfleetno"
style="width:95%;font-size:14px;font-weight:600;padding:8px 12px;box-sizing:border-box;"
value='<s:property value="searchfleetno"/>'>
</td>


<td align="right" width="10%" style="font-weight:700;font-size:14px;color:#222;">Doc No</td>

<td width="15%">
<input type="text"
id="searchdocno"
name="searchdocno"
style="width:95%;font-size:14px;font-weight:600;padding:8px 12px;box-sizing:border-box;"
value='<s:property value="searchdocno"/>'>
</td>

</tr>



<tr>

<td colspan="8">

<div id="srefreshdiv">
<jsp:include page="subMainSearch.jsp"/>
</div>

</td>

</tr>

</table>

</div>

</body>
</html>