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

<style>
#search {
    width: 100%;
    background-color: #E0ECF8;
    padding: 10px;
    border-radius: 5px;
    font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
    font-size: 13px;
}

#search input[type="text"], #search select {
    width: 95%;
    padding: 4px;
    border: 1px solid #c6ddf5;
    border-radius: 4px;
    font-size: 13px;
}

#search input.myButton {
    background-color: #0072C6; /* original blue button color */
    color: #fff;
    border: none;
    border-radius: 4px;
    padding: 5px 12px;
    cursor: pointer;
    font-size: 13px;
}

#search input.myButton:hover {
    background-color: #005a9e; /* hover darker blue */
}

#srefreshdiv {
    margin-top: 10px;
    background-color: #fff;
    border: 1px solid #c6ddf5;
    border-radius: 5px;
    padding: 5px;
}

table#search td {
    padding: 4px 6px;
}
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
		
		
		 $("#srefreshdiv").load('disposalSearch.jsp?docno='+docno+'&date='+date+'&client='+client+'&type='+type+'&acno='+acno+'&mobile='+mobile+'&branch='+branch+'&id=1');
		 

		}
 
	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%">
  <tr>
    <td width="9%" align="right">Doc No</td>
    <td width="15%" align="left"><input type="text" name="msearchdocno" id="msearchdocno" ></td>
    <td width="10%" align="right">Date</td>
    <td width="17%" align="left"><div id="msearchdate" ></div></td>
    <td width="10%" align="right">Type</td>
    <td width="29%" align="left"><select name="msearchcmbtype" id="msearchcmbtype">
      <option value="">--Select--</option>
      <option value="S">Sale</option>
      <option value="L">Total Loss</option>
    </select></td>
    <td width="10%" rowspan="2" align="center"><input type="button" name="searchbtn" id="searchbtn" class="myButton" value="Search"  onclick="mainSearch();"></td>
  </tr>
  <tr>
    <td align="right">Client</td>
    <td align="left"><input type="text" name="msearchclient" id="msearchclient"></td>
    <td align="right">A/c No</td>
    <td align="left"><input type="text" name="msearchacno" id="msearchacno"></td>
    <td align="right">Mobile</td>
    <td align="left"><input type="text" name="msearchmobile" id="msearchmobile"></td>
    </tr>
  <tr>
    <td colspan="7" align="right"><div id="srefreshdiv"><jsp:include page="disposalSearch.jsp"></jsp:include></div></td>
    </tr>

</table>



  </div>
</body>
</html>