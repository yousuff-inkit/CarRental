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


</style>

	<script type="text/javascript">
	$(document).ready(function () {
		$("#empdate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
		$("#led").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
		
		document.getElementById("txttype").value=document.getElementById("emptype").value;
	}); 

 	function mainloadSearch() {
 		
 		var salesman=document.getElementById("txtsalname").value;
 		var smob=document.getElementById("txtmob").value;
 		var salescode=document.getElementById("txtcode").value;
 		var docno=document.getElementById("txtdocno").value;
 		var date=document.getElementById("empdate").value;
 		var led=document.getElementById("led").value;
	    var type=document.getElementById("txttype").value;
	    
		getdata(salesman,smob,salescode,docno,date,led,type);

	}
	 function getdata(salesman,smob,salescode,docno,date,led,type){
		 $("#refreshdiv").load('employeeDetailsSearchGrid.jsp?salesman='+salesman+'&smob='+smob+'&salescode='+salescode+'&docno='+docno+'&date='+date+'&led='+led+'&type='+type);
		}
 
	</script>
<body bgcolor="#E0ECF8">
<div id="search">
<table width="100%">

  <!-- ROW 1 -->
  <tr>
    <td class="label">Name</td>
    <td class="field">
        <input type="text"
               name="txtsalname"
               id="txtsalname"
               value='<s:property value="txtsalname"/>'>

        <input type="hidden"
               name="txttype"
               id="txttype"
               value='<s:property value="txttype"/>'>
    </td>

    <td class="label">Code</td>
    <td class="field">
        <input type="text"
               name="txtcode"
               id="txtcode"
               value='<s:property value="txtcode"/>'>
    </td>

    <td class="label">Mob</td>
    <td class="field">
        <input type="text"
               name="txtmob"
               id="txtmob"
               value='<s:property value="txtmob"/>'>
    </td>
  </tr>

  <!-- ROW 2 -->
  <tr>
    <td class="label">Doc No</td>
    <td class="field">
        <input type="text"
               name="txtdocno"
               id="txtdocno"
               value='<s:property value="txtdocno"/>'>
    </td>

    <td class="label">Date</td>
    <td class="field">
        <div id="empdate" name="empdate"
             value='<s:property value="empdate"/>'></div>

        <input type="hidden"
               name="hidempdate"
               id="hidempdate"
               value='<s:property value="hidempdate"/>'>
    </td>

    <td class="label">L/C Exp.</td>
    <td class="field">
        <div id="led" name="led"
             value='<s:property value="led"/>'></div>

        <input type="hidden"
               name="hidled"
               id="hidled"
               value='<s:property value="hidled"/>'>
    </td>

    <td class="action">
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
    <td colspan="7">
        <div id="refreshdiv">
            <jsp:include page="employeeDetailsSearchGrid.jsp"></jsp:include>
        </div>
    </td>
  </tr>

</table>
</div>
</body>

</html>