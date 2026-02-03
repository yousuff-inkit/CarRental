<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<style type="text/css">
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
.myButtons {
    font-family: Tahoma, Geneva, sans-serif;
    font-size: 14px;
    font-weight: 700;
    background-color: #007bff;   /* BLUE */
    color: #ffffff;
    padding: 8px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    box-shadow: 0 2px 4px rgba(0,0,0,0.15);
}

/* Keep same blue on hover */
.myButtons:hover {
    background-color: #007bff;
}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$("#agmtsearchdate").jqxDateTimeInput({ width: '110px', height: '15px', formatString:"dd.MM.yyyy",value:null});
		$('#agmtsearchbtn').click(function(){
			var docno=$('#agmtsearchdocno').val();
			var date=$('#agmtsearchdate').jqxDateTimeInput('val');
			var fleetno=$('#agmtsearchfleetno').val();
			var regno=$('#agmtsearchregno').val();
			var clientname=$('#agmtsearchclientname').val();
			var mobile=$('#agmtsearchmobile').val();
			$("#overlay, #PleaseWait").show(); 
			$('#agmtsearchdiv').load('agmtSearchGrid.jsp?docno='+docno+'&date='+date+'&fleetno='+fleetno+'&regno='+regno+'&clientname='+clientname+'&clientmobile='+mobile+'&id=1');
		});
	});
	
</script>
</head>
<body>
<div id="search">
<table width="100%">

  <!-- ROW 1 -->
  <tr>
    <td class="label">Doc No</td>
    <td class="field">
        <input type="text"
               name="agmtsearchdocno"
               id="agmtsearchdocno"
               value='<s:property value="agmtsearchdocno"/>'>
    </td>

    <td class="label">Date</td>
    <td class="field">
        <div id="agmtsearchdate" name="agmtsearchdate"></div>
    </td>

    <td class="label">Fleet No</td>
    <td class="field">
        <input type="text"
               name="agmtsearchfleetno"
               id="agmtsearchfleetno"
               value='<s:property value="agmtsearchfleetno"/>'>
    </td>

    <td class="label">Reg No</td>
    <td class="field">
        <input type="text"
               name="agmtsearchregno"
               id="agmtsearchregno"
               value='<s:property value="agmtsearchregno"/>'>
    </td>
  </tr>

  <!-- ROW 2 -->
  <tr>
    <td class="label">Client Name</td>
    <td class="field-wide" colspan="3">
        <input type="text"
               name="agmtsearchclientname"
               id="agmtsearchclientname"
               value='<s:property value="agmtsearchclientname"/>'>
    </td>

    <td class="label">Mobile</td>
    <td class="field-wide">
        <input type="text"
               name="agmtsearchmobile"
               id="agmtsearchmobile"
               value='<s:property value="agmtsearchmobile"/>'>
    </td>

    <td class="action" colspan="2">
        <input type="button"
               name="agmtsearchbtn"
               id="agmtsearchbtn"
               class="myButton"
               value="Search">
    </td>
  </tr>

  <!-- GRID -->
  <tr>
    <td colspan="8">
        <div id="agmtsearchdiv">
            <jsp:include page="agmtSearchGrid.jsp"></jsp:include>
        </div>
    </td>
  </tr>

</table>
</div>
</body>

</html>