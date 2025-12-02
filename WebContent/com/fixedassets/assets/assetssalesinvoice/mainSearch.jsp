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

/* -------------------- PAGE -------------------- */
body {
    background: #f3f7ff;
    margin: 0;
    font-family: "Segoe UI", Arial, sans-serif;
}

/* -------------------- MAIN SEARCH BOX -------------------- */
#search {
    background: #ffffff;
    width: 98%;
    margin: 10px auto;
    padding: 15px;
    border-radius: 10px;
    box-shadow: 0 4px 15px rgba(0, 0, 255, 0.08);
    border: 1px solid #e4ebff;
}

/* -------------------- TABLE ALIGNMENT -------------------- */
#search table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 10px 12px;
}

#search td {
    font-size: 12px;
    color: #333;
    font-weight: 600;
}

/* -------------------- INPUT FIELDS -------------------- */
#search input[type="text"],
#search select {
    width: 100%;
    height: 26px;
    padding-left: 8px;
    border: 1px solid #cdd9f5;
    border-radius: 6px;
    background: #f9fbff;
    font-size: 11px;
    transition: 0.2s ease;
}

#search select {
    height: 28px;
}

#search input[type="text"]:focus,
#search select:focus {
    border-color: #4a8dff;
    box-shadow: 0 0 6px rgba(74, 141, 255, 0.35);
    outline: none;
}

/* -------------------- SEARCH BUTTON -------------------- */
.myButton {
    background: linear-gradient(180deg, #4a90ff, #2a6dff);
    padding: 12px 30px;
    border-radius: 8px;
    border: none;
    font-size: 14px;
    font-weight: bold;
    color: white;
    cursor: pointer;
    box-shadow: 0 3px 8px rgba(0, 0, 255, 0.2);
    transition: all 0.25s ease;
}

/* Hover effect */
.myButton:hover {
    background: linear-gradient(180deg, #2a6dff, #1a54e8);
    transform: translateY(-2px);
    box-shadow: 0 6px 15px rgba(0, 0, 255, 0.25);
}

/* Press click effect */
.myButton:active {
    transform: scale(0.96);
}

/* -------------------- RESULT BOX -------------------- */
#srefreshdiv {
    background: #ffffff;
    margin-top: 12px;
    padding: 12px;
    border-radius: 10px;
    border: 1px solid #e4ebff;
    box-shadow: inset 0 0 10px rgba(0, 0, 255, 0.05);
    animation: fadeIn 0.25s ease-in-out;
}

/* Fade effect */
@keyframes fadeIn {
    from { opacity: 0; transform: translateY(3px); }
    to { opacity: 1; transform: translateY(0); }
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
		
		
		 $("#srefreshdiv").load('assetSalesSearch.jsp?docno='+docno+'&date='+date+'&client='+client+'&type='+type+'&acno='+acno+'&mobile='+mobile+'&branch='+branch+'&id=1');
		 

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
    <td colspan="7" align="right"><div id="srefreshdiv"><jsp:include page="assetSalesSearch.jsp"></jsp:include></div></td>
    </tr>

</table>



  </div>
</body>
</html>