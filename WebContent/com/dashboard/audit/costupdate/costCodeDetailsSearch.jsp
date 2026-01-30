 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
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
	$(document).ready(function () {
 		/* document.getElementById("txtcosttype").value=$('#cmbcosttype').val(); */
 		if(($("#cmbcosttype option:selected").text().trim()=='Fleet')){
 			$('#txtregno').attr('readonly', false );
 		} else {
 			$('#txtregno').attr('readonly', true );
 		}
	}); 

 	function loadSearch() {

 		var costCode=document.getElementById("txtcostcodes").value;
 		var RegNo=document.getElementById("txtregno").value;
 		var type=$('#cmbcosttype').val();
 		var costCodeName=document.getElementById("txtcostcodesname").value;
 		var check = 1;
 		
		getdata(type,costCode,costCodeName,RegNo,check);
	}
 	
	function getdata(type,costCode,costCodeName,RegNo,check){
		 $("#refreshdiv").load('costCodeDetailsSearchGrid.jsp?type='+type+'&costCode='+costCode+'&costCodeName='+costCodeName.replace(/ /g, "%20")+'&RegNo='+RegNo+'&check='+check);
		}

	</script>
<body>
<div id="search">
<table width="100%">

  <!-- ROW 1 -->
  <tr>
    <td class="label">Cost Code</td>
    <td class="field">
        <input type="text"
               name="txtcostcodes"
               id="txtcostcodes"
               value='<s:property value="txtcostcodes"/>'>

        <input type="hidden"
               name="txtcosttype"
               id="txtcosttype"
               value='<s:property value="txtcosttype"/>'>
    </td>

    <td class="label">Reg No</td>
    <td class="field">
        <input type="text"
               name="txtregno"
               id="txtregno"
               value='<s:property value="txtregno"/>'>
    </td>

    <td class="action">
        <input type="button"
               name="btnsearch"
               id="btnsearch"
               class="myButton"
               value="Search"
               onclick="loadSearch();">
    </td>
  </tr>

  <!-- ROW 2 -->
  <tr>
    <td class="label">Name</td>
    <td class="field" colspan="3">
        <input type="text"
               name="txtcostcodesname"
               id="txtcostcodesname"
               value='<s:property value="txtcostcodesname"/>'>
    </td>
  </tr>

  <!-- GRID -->
  <tr>
    <td colspan="5">
        <div id="refreshdiv">
            <jsp:include page="costCodeDetailsSearchGrid.jsp"></jsp:include>
        </div>
    </td>
  </tr>

</table>
</div>
</body>

</html>