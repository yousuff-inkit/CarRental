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
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

</style>

	<script type="text/javascript">
	$(document).ready(function () {
		$("#msearchdate").jqxDateTimeInput({
			width : '125px',
			height : '15px',
			formatString : "dd.MM.yyyy",value:null
		});
	}); 

 	function mainSearch() {
 		
 		var docno=document.getElementById("msearchdocno").value;
 		var date=$('#msearchdate').jqxDateTimeInput('val');
 		var client=document.getElementById("msearchclient").value;
 		var type=document.getElementById("msearchcmbtype").value;
 		var acno=document.getElementById("msearchacno").value;
 		var mobile=document.getElementById("msearchmobile").value;
		var branch=document.getElementById("brchName").value;
 		
 		getmaindata(docno,date,client,type,acno,mobile,branch);
 

	}
	 function getmaindata(docno,date,client,type,acno,mobile,branch){
		
		
		 $("#srefreshdiv").load('assetSalesSearch.jsp?docno='+docno+'&date='+date+'&client='+client+'&type='+type+'&acno='+acno+'&mobile='+mobile+'&branch='+branch+'&id=1');
		 

		}
 
	</script>
<style type="text/css">
/* Master UI Table Container */
#search table {
  border-collapse: separate;
  border-spacing: 15px 12px; /* Standardized master gap */
  width: 100%;
}

/* Label Styling */
td[align="right"] {
  font-family: Tahoma, Geneva, sans-serif;
  font-size: 14px;
  font-weight: 700;
  color: #222;
}

/* Input & Select Field Styling */
input[type="text"], select {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 600;
  font-size: 14px;
  padding: 8px 12px;
  width: 95%;
  max-width: 100%;
  box-sizing: border-box;
  border: 1px solid #ccc;
  border-radius: 4px;
}

/* Date Picker Container */
#msearchdate {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 600;
  font-size: 14px;
}

/* Master Button Appearance */
.myButton {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 700;
  font-size: 14px;
  background-color: #007bff; /* Master Blue */
  color: #ffffff;
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  box-shadow: 0 2px 5px rgba(0,0,0,0.2);
  transition: background-color 0.3s;
  min-width: 90px;
}

/* Master Green Hover Effect */
.myButton:hover {
  background-color: #45a049;
}

/* Row Spacing */
tr {
  line-height: 1.6;
}
</style>

<body bgcolor="#E0ECF8">
<div id="search">
  <table>
    <tr>
      <td width="9%" align="right">Doc No</td>
      <td width="15%" align="left">
        <input type="text" name="msearchdocno" id="msearchdocno">
      </td>
      <td width="10%" align="right">Date</td>
      <td width="17%" align="left">
        <div id="msearchdate"></div>
      </td>
      <td width="10%" align="right">Type</td>
      <td width="29%" align="left">
        <select name="msearchcmbtype" id="msearchcmbtype">
          <option value="">--Select--</option>
          <option value="S">Sale</option>
          <option value="L">Total Loss</option>
        </select>
      </td>
      <td width="10%" rowspan="2" align="center">
        <input type="button" name="searchbtn" id="searchbtn" class="myButton" value="Search" onclick="mainSearch();">
      </td>
    </tr>
    <tr>
      <td align="right">Client</td>
      <td align="left">
        <input type="text" name="msearchclient" id="msearchclient">
      </td>
      <td align="right">A/c No</td>
      <td align="left">
        <input type="text" name="msearchacno" id="msearchacno">
      </td>
      <td align="right">Mobile</td>
      <td align="left">
        <input type="text" name="msearchmobile" id="msearchmobile">
      </td>
    </tr>
    <tr>
      <td colspan="7">
        <div id="srefreshdiv">
          <jsp:include page="assetSalesSearch.jsp" />
        </div>
      </td>
    </tr>
  </table>
</div>
</body>
</html>