<% String contextPath=request.getContextPath();%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%--  <jsp:include page="../../../../../includes.jsp"></jsp:include> --%>  
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


input[type="text"] {
  font-weight: 600;
  font-size: 14px;
  padding: 8px 12px;
  width: 95%; /* Prevent overflow */
  max-width: 100%;
  box-sizing: border-box; /* Include padding in width */
}


#searchdate {
  font-weight: 600;
  font-size: 14px;
}

/* Bold button text */
.myButton {
  font-weight: 700;
  font-size: 14px;
  /* Visual Button Appearance for consistency */
  background-color: #007bff; /* Green background */
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
  background-color: #45a049; /* Darker green on hover */
}

/* Additional spacing for rows */
tr {
  line-height: 1.8;
}

/* Original file's hidden scrollbar style */
.hidden-scrollbar {
    overflow: auto;
    height: 600px;
}
</style>
	<script type="text/javascript">
	$(document).ready(function () {
	$("#searchdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	});

 	function loadSearch() {
	
 		
		var docnosearch1=document.getElementById("docnosearch").value;
	
		var fleetsearch=document.getElementById("fleetsearch").value;
		var regnosearch=document.getElementById("regnosearch").value;
		var clientsearch=document.getElementById("clientsearch").value;
	 	var searchdate=$('#searchdate').jqxDateTimeInput('val');
	 	//alert("===="+searchdate);
	 	var agmttype=document.getElementById("cmbrentaltype").value;
		var mobilesearch=document.getElementById("mobilesearch").value;
 		var agmtbranch1=document.getElementById("cmbagmtbranch").value.trim();
 		
		getdata(docnosearch1,fleetsearch,regnosearch,clientsearch,searchdate,mobilesearch,agmttype,agmtbranch1);
 
	}
 	
	function getdata(docnosearch,fleetsearch,regnosearch,clientsearch,searchdate,mobilesearch,agmttype,agmtbranch1){
		
			
				$("#loadAgmtSearch").load("gridAgmtSearch.jsp?agmttype="+agmttype+"&docno="+docnosearch+"&fleet="+fleetsearch+"&regno="+regnosearch+"&client="+clientsearch+"&date="+searchdate+"&mobile="+mobilesearch+"&date="+searchdate+"&agmtbranch1="+agmtbranch1);
				
		}

	</script>
	<div id="search">
<body>
<div id=search>
<table width="100%" >
  <tr>
    <td align="right">Doc No</td>
    <td align="left"><input type="text" name="docnosearch" id="docnosearch" value='<s:property value="docnosearch"/>'></td>
    <td align="right">Fleet</td>
    <td align="left"><input type="text" name="fleetsearch" id="fleetsearch" value='<s:property value="fleetsearch"/>'></td>
    <td align="right">Reg No</td>
    <td align="left"><input type="text" name="regnosearch" id="regnosearch" value='<s:property value="regnosearch"/>'></td>
    <td align="right">License No</td>
    <td align="left"><input type="text" name="licensesearch" id="licensesearch" value='<s:property value="licensesearch"/>'></td>
  </tr>
  <tr>
    <td align="right">Client</td>
    <td align="left"><input type="text" name="clientsearch" id="clientsearch" value='<s:property value="clientsearch"/>'></td>
    <td align="right">Date</td>
    <td align="left">
        <div id="searchdate" name="searchdate" value='<s:property value="searchdate"/>'></div>
    </td>
    <input type="hidden" name="hidsearchdate" id="hidsearchdate" value='<s:property value="hidsearchdate"/>'>
    <td align="right">Mobile</td>
    <td align="left"><input type="text" name="mobilesearch" id="mobilesearch" value='<s:property value="mobilesearch"/>'></td>
    <td colspan="2" align="center"><input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td colspan="8" align="right">
        <div id="loadAgmtSearch">
            <jsp:include page="gridAgmtSearch.jsp" />
        </div>
    </td>
  </tr>
</table>
</div>
</body>
</html>