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
	$(document).ready(function () {
	
	}); 

 	function mainloadSearch() {
 		
 		var sclname=document.getElementById("SCl_name").value;
 		var smob=document.getElementById("Sl_mob").value;
 		var rno=document.getElementById("rno").value;
 		var flno=document.getElementById("flno").value;
 		var sregno=document.getElementById("sregno").value;
 		
 	 
 		  var branchval = document.getElementById("cmbbranch").value; 
	
		getdata(sclname,smob,rno,flno,sregno,branchval);

	}
	 function getdata(sclname,smob,rno,flno,sregno,branchval){
		 $("#srefreshdiv").load('agreementDetailsSearchGrid.jsp?sclname='+sclname+'&smob='+smob+'&rno='+rno+'&flno='+flno+'&sregno='+sregno+'&branchval='+branchval);
		}
 
	</script>
<body bgcolor="#E0ECF8">
<div id="search">
<table width="100%">

  <!-- ROW 1 -->
  <tr>
    <td class="label">Name</td>
    <td class="field-wide">
        <input type="text"
               name="SCl_name"
               id="SCl_name"
               value='<s:property value="SCl_name"/>'>
    </td>

    <td class="label">Mob</td>
    <td class="field-wide">
        <input type="text"
               name="Sl_mob"
               id="Sl_mob"
               value='<s:property value="Sl_mob"/>'>
    </td>

    <td class="label">Reg No</td>
    <td class="field">
        <input type="text"
               name="sregno"
               id="sregno"
               value='<s:property value="sregno"/>'>
    </td>
  </tr>

  <!-- ROW 2 -->
  <tr>
    <td class="label">Doc No</td>
    <td class="field">
        <input type="text"
               name="rno"
               id="rno"
               value='<s:property value="rno"/>'>
    </td>

    <td class="label">Fleet No</td>
    <td class="field">
        <input type="text"
               name="flno"
               id="flno"
               value='<s:property value="flno"/>'>
    </td>

    <td class="action" colspan="2">
        <input type="button"
               name="mbtnrasearch"
               id="mbtnrasearch"
               class="myButton"
               value="Search"
               onclick="mainloadSearch();">
    </td>
  </tr>

  <!-- GRID -->
  <tr>
    <td colspan="6">
        <div id="srefreshdiv">
            <jsp:include page="agreementDetailsSearchGrid.jsp"></jsp:include>
        </div>
    </td>
  </tr>

</table>
</div>
</body>
</html>