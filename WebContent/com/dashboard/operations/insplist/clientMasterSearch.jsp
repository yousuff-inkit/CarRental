<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head> 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
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
	
	$("#clientdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	//$('body').css('background-color','#E0ECF8');
});

function loadClients(){
	var name=document.getElementById("clients").value;
	var cldocno=document.getElementById("cldocno").value;
	var telephone=document.getElementById("telephone").value;
	var clientdate=$('#clientdate').jqxDateTimeInput('val');
	var mobile=document.getElementById("mobile").value;
	$("#overlay, #PleaseWait").show();
	$('#clientdiv').load('clientSearch.jsp?name='+name+'&cldocno='+cldocno+'&telephone='+telephone+'&clientdate='+clientdate+'&mobile='+mobile+'&id=1');
}


</script>
</head>
<body>
<div id="search" style="background-color:#FFFFFF;">
<table width="100%">

  <!-- ROW 1 -->
  <tr>
    <td class="label">Name</td>
    <td class="field" colspan="3">
        <input type="text"
               name="clients"
               id="clients">
    </td>

    <td class="label">Telephone</td>
    <td class="field">
        <input type="text"
               name="telephone"
               id="telephone">
    </td>
  </tr>

  <!-- ROW 2 -->
  <tr>
    <td class="label">Doc No</td>
    <td class="field">
        <input type="text"
               name="cldocno"
               id="cldocno">
    </td>

    <td class="label">Date</td>
    <td class="field">
        <div id="clientdate"></div>
    </td>

    <td class="label">Mobile</td>
    <td class="field">
        <input type="text"
               name="mobile"
               id="mobile">
    </td>

    <td class="action">
        <button type="button"
                name="btnclientsearch"
                id="btnclientsearch"
                class="myButtons"
                onclick="loadClients();">
            Search
        </button>
    </td>
  </tr>

  <!-- GRID -->
  <tr>
    <td colspan="7">
        <div id="clientdiv">
            <jsp:include page="clientSearch.jsp"></jsp:include>
        </div>
    </td>
  </tr>

</table>
</div>
</body>

</html>