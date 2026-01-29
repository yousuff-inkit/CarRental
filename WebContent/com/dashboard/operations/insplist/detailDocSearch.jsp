<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<style>
/* ================================
   SEARCH POPUP – COMMON MASTER CSS
   ================================ */

#search {
    background-color: #ffffff;
    padding: 8px;
}

/* Table layout */
#search table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 15px 12px;
}

/* Labels */
#search td[align="right"] {
    font-family: Tahoma, Geneva, sans-serif;
    font-size: 14px;
    font-weight: 700;
    color: #222;
    white-space: nowrap;
}

/* Text inputs */
#search input[type="text"] {
    font-family: Tahoma, Geneva, sans-serif;
    font-size: 14px;
    font-weight: 600;

    padding: 6px 10px;
    height: 34px;
    width: 100%;

    box-sizing: border-box;
    border: 1px solid #bdc3c7;
    border-radius: 4px;
    background-color: #ffffff;
}

/* Input focus */
#search input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
}

/* Button */
#search .myButton {
    font-family: Tahoma, Geneva, sans-serif;
    font-size: 14px;
    font-weight: 700;

    background-color: #007bff;
    color: #ffffff;

    padding: 8px 20px;
    border: none;
    border-radius: 4px;

    cursor: pointer;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

#search .myButton:hover {
    background-color: #007bff;
}

/* Result grid spacing */
#refreshdiv {
    margin-top: 10px;
}
/* ================================
   SEARCH POPUP – REFINED LAYOUT
   ================================ */

.search-popup {
    padding: 14px;
}

/* Search form table */
.search-form {
    width: 100%;
    border-spacing: 18px 12px;
}

/* Labels */
.search-form .label {
    font-family: Tahoma, Geneva, sans-serif;
    font-size: 14px;
    font-weight: 700;
    color: #222;
    white-space: nowrap;
    text-align: right;
}

/* Input cells */
.search-form .field {
    width: 28%;
}

/* Action cell */
.search-form .action {
    text-align: center;
    width: 12%;
}

/* Grid wrapper */
.search-grid {
    margin-top: 14px;
    border: 1px solid #dcdcdc;
    border-radius: 4px;
    background: #ffffff;
    padding: 6px;
}

</style>
<script>
$(document).ready(function(e) {
    $("#detaildate").jqxDateTimeInput({ width: '100px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	

});

function funSearchDetail(){
	<%
	String reftype=request.getParameter("reftype")==null?"":request.getParameter("reftype").toString();
	String branch=request.getParameter("branch")==null?"":request.getParameter("branch").toString();
	%>
	var reftype='<%=reftype%>';
	var branch='<%=branch%>';
	var docno=document.getElementById("detaildocno").value;
	var fleetno=document.getElementById("detailfleetno").value;
	var regno=document.getElementById("detailregno").value;
	var date=$('#detaildate').jqxDateTimeInput('val');
	$('#docdiv').load('docSearch.jsp?reftype='+reftype+'&branch='+branch+'&docno='+docno+'&fleetno='+fleetno+'&regno='+regno+'&date='+date+'&mode=1');
}
</script>
</head>

<body>
<div id="search" style="background-color:#FFFFFF;">
<table width="100%">

  <!-- SEARCH ROW -->
  <tr>
    <td class="label">Date</td>
    <td class="field">
        <div id="detaildate"></div>
    </td>

    <td class="label">Ref Doc No</td>
    <td class="field">
        <input type="text"
               name="detaildocno"
               id="detaildocno">
    </td>

    <td class="label">Fleet No</td>
    <td class="field">
        <input type="text"
               name="detailfleetno"
               id="detailfleetno">
    </td>

    <td class="label">Reg No</td>
    <td class="field">
        <input type="text"
               name="detailregno"
               id="detailregno">
    </td>

    <td class="action">
        <button type="button"
                id="btndetail"
                class="myButton"
                onclick="funSearchDetail();">
            Search
        </button>
    </td>
  </tr>

  <!-- GRID -->
  <tr>
    <td colspan="9">
        <div id="docdiv">
            <jsp:include page="docSearch.jsp"></jsp:include>
        </div>
    </td>
  </tr>

</table>
</div>
</body>

</html>