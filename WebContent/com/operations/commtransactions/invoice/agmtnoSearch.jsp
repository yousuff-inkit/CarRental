<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<link href="../../../../../css/body.css" rel="stylesheet" type="text/css"> 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
  <%-- <jsp:include page="../../../../../includes.jsp"></jsp:include> --%>  
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


input[type="text"] {
  font-weight: 600;
  font-size: 14px;
  padding: 8px 12px;
  width: 95%; 
  max-width: 100%;
  box-sizing: border-box; 
  font-family: Tahoma, Arial, sans-serif;
}


#agmtsearchdate {
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
	<script type="text/javascript">
	$(document).ready(function () {
	$("#agmtsearchdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	});

 	function loadagmtSearch() {
	
		
		
		var docnosearch1=document.getElementById("agmtdocnosearch").value;
		var fleetsearch=document.getElementById("agmtfleetsearch").value;
		var regnosearch=document.getElementById("agmtregnosearch").value;
		var clientsearch=document.getElementById("agmtclientsearch").value;
	 	var searchdate=$('#agmtsearchdate').jqxDateTimeInput('val');
	 	var agmttype=document.getElementById("cmbagmttype").value;
	 	var license=document.getElementById("agmtlicensesearch").value;
		var mobilesearch=document.getElementById("agmtmobilesearch").value;
		$('#brchName').prop('disabled',false);
		var branch=$('#brchName').val();
		$('#brchName').prop('disabled',true);
		getdata(docnosearch1,fleetsearch,regnosearch,clientsearch,searchdate,mobilesearch,agmttype,license,branch);
		
	}
	function getdata(docnosearch,fleetsearch,regnosearch,clientsearch,searchdate,mobilesearch,agmttype,license,branch){
				$("#agmtloadAgmtSearch").load("gridAgmtSearch.jsp?agmttype="+agmttype+"&docno="+docnosearch+"&fleet="+fleetsearch+"&regno="+regnosearch+"&client="+clientsearch+"&date="+searchdate+"&mobile="+mobilesearch+"&license="+license+'&branch='+branch);
				
	
		}

	</script>
<body>
<div id="search">
<table width="100%">
  <tr>
    <td align="right">Doc No</td>
    <td align="left"><input type="text" name="agmtdocnosearch" id="agmtdocnosearch" value='<s:property value="agmtdocnosearch"/>'></td>
    <td align="right">Fleet</td>
    <td align="left"><input type="text" name="agmtfleetsearch" id="agmtfleetsearch" value='<s:property value="agmtfleetsearch"/>'></td>
    <td align="right">Reg No</td>
    <td align="left"><input type="text" name="agmtregnosearch" id="agmtregnosearch" value='<s:property value="agmtregnosearch"/>'></td>
    <td align="right">License No</td>
    <td align="left"><input type="text" name="agmtlicensesearch" id="agmtlicensesearch" value='<s:property value="agmtlicensesearch"/>'></td>
  </tr>
  <tr>
    <td align="right">Client</td>
    <td align="left"><input type="text" name="agmtclientsearch" id="agmtclientsearch" value='<s:property value="agmtclientsearch"/>'></td>
    <td align="right">Date</td>
    <td align="left">
        <div id="agmtsearchdate" name="agmtsearchdate" value='<s:property value="agmtsearchdate"/>'></div>
    </td>
    <input type="hidden" name="hidagmtsearchdate" id="hidagmtsearchdate" value='<s:property value="hidagmtsearchdate"/>'>
    <td align="right">Mobile</td>
    <td align="left"><input type="text" name="agmtmobilesearch" id="agmtmobilesearch" value='<s:property value="agmtmobilesearch"/>'></td>
    <td colspan="2" align="center">
        <input type="button" name="btnagmtrasearch" id="btnagmtrasearch" class="myButton" value="Search" onclick="loadagmtSearch();">
    </td>
  </tr>
  <tr>
    <td colspan="8" align="right">
        <div id="agmtloadAgmtSearch">
            <jsp:include page="gridAgmtSearch.jsp" />
        </div>
    </td>
  </tr>
</table>
</div>
</body>
</html>