<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<link href="../../../../css/body.css" rel="stylesheet" type="text/css">

<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%--  <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

<% String agmttype=request.getParameter("agmt")==null?"0":request.getParameter("agmt").toString();%>
	<script type="text/javascript">
	$(document).ready(function () {
	$("#searchdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	
	
	});

	

 	function loadSearch() {
 		var agmt='<%=agmttype%>';
		//document.getElementById("errormsg").innerText="";
		var docnosearch1=$('#docnosearch').val();
		var fleetsearch=$('#fleetsearch').val();
		var regnosearch=$('#regnosearch').val();
		var clientsearch=$('#clientsearch').val();
	 	var searchdate=$('#searchdate').val();
	 	var branch=$('#cmbbranch').val(); 
		var mobilesearch=$('#mobilesearch').val();
		$("#loadRaSearch").load('gridRaSearch.jsp?docnochk='+docnosearch1+'&fleetchk='+fleetsearch+'&regnochk='+regnosearch+'&clientchk='+clientsearch+'&datechk='+searchdate+'&mobilechk='+mobilesearch+'&branchchk='+branch+'&agmt='+agmt+'&chk=1');
		//getdata(docnosearch1,fleetsearch,regnosearch,clientsearch,searchdate,mobilesearch,branch,agmt);
	}
	function getdata(docnosearch1,fleetsearch,regnosearch,clientsearch,searchdate,mobilesearch,branch,agmt){
		//alert(docnosearch1+"=="+fleetsearch+"=="+regnosearch+"=="+clientsearch+"=="+searchdate+"=="+mobilesearch+"=="+branch+"=="+agmt);
		 
		 //alert(agmt);
				//$("#loadRaSearch").load('gridRaSearch.jsp?docnochk='+docnosearch1+'&fleetchk='+fleetsearch+'&regnochk='+regnosearch+'&clientchk='+clientsearch+'&datechk='+searchdate+'&mobilechk='+mobilesearch+'&branchchk='+branch+'&agmt='+agmt+'&chk=1');
		}

	</script>
	
<style type="text/css">
/* Master UI Styles */
/* Table spacing and layout */
table {
  border-collapse: separate;
  border-spacing: 15px 12px; /* Standardized master gap */
}

/* Bold labels - Standardized to Master UI 14px Tahoma */
.branch, td[align="right"] {
  font-family: Tahoma, Geneva, sans-serif;
  font-size: 14px;
  font-weight: 600; /* Font weight 600 as requested */
  color: #222;
  white-space: nowrap;
}

/* Bold text inside inputs with Grey Borders */
input[type="text"] {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 600; /* Font weight 600 as requested */
  font-size: 14px;
  padding: 8px 12px;
  max-width: 100%;
  box-sizing: border-box;
  /* Grey border */
  border: 1px solid #bdc3c7; 
  border-radius: 4px;
  background-color: #ffffff;
}

/* Focus state for inputs */
input[type="text"]:focus {
  border-color: #007bff;
  outline: none;
}

/* Specifically adjust jqxDateTimeInput styling for searchdate div */
#searchdate {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 600;
  font-size: 14px;
}

/* Master Button Appearance */
.myButton {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 700;
  font-size: 14px;
  background-color: #007bff; /* Standard Blue */
  color: white;
  padding: 8px 25px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  transition: none; /* No hover transition */
}

/* No color change on hover */
.myButton:hover {
  background-color: #007bff; 
  cursor: pointer;
}

/* Row spacing */
tr {
  line-height: 1.6;
}

/* Container background override */
#search {
    background-color: #FFFFFF;
}
</style>

<body bgcolor="#FFFFFF">
<div id="search">
<table width="100%">
  <tr>
    <td align="right"><label class="branch">Doc No</label></td>
    <td align="left"><input type="text" name="docnosearch" id="docnosearch" value='<s:property value="docnosearch"/>'></td>
    
    <td align="right"><label class="branch">Fleet</label></td>
    <td align="left"><input type="text" name="fleetsearch" id="fleetsearch" value='<s:property value="fleetsearch"/>'></td>
    
    <td align="right"><label class="branch">Reg No</label></td>
    <td align="left"><input type="text" name="regnosearch" id="regnosearch" value='<s:property value="regnosearch"/>'></td>
    
    <td align="right">&nbsp;</td>
    <td align="left">&nbsp;</td>
  </tr>
  <tr>
    <td align="right"><label class="branch">Client</label></td>
    <td align="left"><input type="text" name="clientsearch" id="clientsearch" value='<s:property value="clientsearch"/>'></td>
    
    <td align="right"><label class="branch">Date</label></td>
    <td align="left">
        <div id="searchdate" name="searchdate" value='<s:property value="searchdate"/>'></div>
        <input type="hidden" name="hidsearchdate" id="hidsearchdate" value='<s:property value="hidsearchdate"/>'>
    </td>
    
    <td align="right"><label class="branch">Mobile</label></td>
    <td align="left"><input type="text" name="mobilesearch" id="mobilesearch" value='<s:property value="mobilesearch"/>'></td>
    
    <td colspan="2" align="center">
        <input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search" onclick="loadSearch();">
    </td> 
  </tr>
  <tr>
    <td colspan="8">
        <div id="loadRaSearch">
            <jsp:include page="gridRaSearch.jsp"></jsp:include>
        </div>
    </td>
  </tr>
</table>
</div>
</body>
</html>