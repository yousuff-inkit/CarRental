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
		 $("#searchdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function mainloadSearch() {
 		
 		var sclnames=document.getElementById("searchclient").value;
 		var reftype=document.getElementById("cmbsearchrtype").value;
 		var searchdate=$('#searchdate').jqxDateTimeInput('val');
 		var agmtno=document.getElementById("searchagmtno").value;
 		var fleetno=document.getElementById("searchfleetno").value;
 		var docno=document.getElementById("searchdocno").value;
	
 		var client = sclnames.replace(/ /g, "%20");
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
font: 14px Tahoma;
  font-weight: 700;
  color: #222;
}


input[type="text"], select {
  font-weight: 600;
  font-size: 14px;
  padding: 8px 12px;
  width: 95%; 
  max-width: 100%;
  box-sizing: border-box; 
}


#searchdate {
  font-weight: 600;
  font-size: 14px;
}

/* Bold button text and visual styling */
.myButton {
  font-weight: 700;
  font-size: 14px;
  background-color: #077bff;
  color: white;
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  box-shadow: 0 2px 5px rgba(0,0,0,0.2);
  transition: background-color 0.3s;
}

.myButton:hover {
  background-color: #45a049;
}

/* Additional spacing for rows */
tr {
  line-height: 1.8;
}

/* Original file's specific style */
.hidden-scrollbar {
    overflow: auto;
    height: 600px;
}

</style>

<body bgcolor="#E0ECF8">
<div id="search">
  <table width="100%">
    <tr>
      <td align="right" width="10%">Name</td>
      <td align="left" width="30%">
        <input type="text" name="searchclient" id="searchclient" style="width:96.5%;" value='<s:property value="searchclient"/>'>
      </td>
      <td align="right" width="10%">Type</td>
      <td align="left" width="20%">
        <select name="cmbsearchrtype" id="cmbsearchrtype">
          <option value="">--Select--</option>
          <option value="RAG">Rental</option>
          <option value="LAG">Lease</option>
        </select>
      </td>
      <td align="right" width="10%">Date</td>
      <td align="left" width="20%">
        <div id="searchdate" name="searchdate" value='<s:property value="searchdate"/>'></div>
      </td>
    </tr>

    <tr>
      <td align="left" style="font-weight: 700; font-size: 14px; color: #222;">Agmt NO</td>
      <td align="left">
        <input type="text" name="searchagmtno" id="searchagmtno" value='<s:property value="searchagmtno"/>'>
      </td>
      <td align="right">Fleet NO</td>
      <td align="left">
        <input type="text" name="searchfleetno" id="searchfleetno" style="width:96.5%;" value='<s:property value="searchfleetno"/>'>
      </td>
      <td align="right">Doc No</td>
      <td align="left">
        <input type="text" id="searchdocno" name="searchdocno" value='<s:property value="searchdocno"/>'>
      </td>
      <td align="center">
        <input type="button" name="mbtnrasearch" id="mbtnrasearch" class="myButton" value="Search" onclick="mainloadSearch();">
      </td>
    </tr>

    <tr>
      <td colspan="7">
        <div id="srefreshdiv">
          <jsp:include page="subMainSearch.jsp" />
        </div>
      </td>
    </tr>
  </table>
</div>
</body>
</html>