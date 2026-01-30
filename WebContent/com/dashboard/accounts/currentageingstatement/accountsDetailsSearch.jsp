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

</style>

	<script type="text/javascript">
	$(document).ready(function () {
 		document.getElementById("txtatype").value=$('#cmbtype').val();
	}); 

 	function loadSearch() {

 		var partyname=document.getElementById("txtpartyname").value;
 		var accNo=document.getElementById("txtaccountno").value;
 		var contactNo=document.getElementById("txtcontactno").value;
 		var atype=document.getElementById("txtatype").value;
 		var check=1;
		getdata(atype,partyname,accNo,contactNo,check);
	}
	function getdata(atype,partyname,accNo,contactNo,check){
		 $("#refreshdiv").load('accountsDetailsGrid.jsp?atype='+atype+'&partyname='+partyname.replace(/ /g, "%20")+'&accNo='+accNo+'&contactNo='+contactNo+"&check="+check);
		}

	</script>
<body>
<div id="search">
<table width="100%">

  <!-- Row 1 -->
  <tr>
    <td class="label">Name</td>
    <td class="field" colspan="2">
        <input type="text"
               name="txtpartyname"
               id="txtpartyname"
               value='<s:property value="txtpartyname"/>'>
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

  <!-- Row 2 -->
  <tr>
    <td class="label">Account</td>
    <td class="field">
        <input type="text"
               name="txtaccountno"
               id="txtaccountno"
               value='<s:property value="txtaccountno"/>'>
    </td>

    <td class="label">Contact No.</td>
    <td class="field">
        <input type="text"
               name="txtcontactno"
               id="txtcontactno"
               style="width:50%;"
               value='<s:property value="txtcontactno"/>'>

        <input type="hidden"
               name="txtatype"
               id="txtatype"
               value='<s:property value="txtatype"/>'>
    </td>
  </tr>

  <!-- Grid -->
  <tr>
    <td colspan="4">
        <div id="refreshdiv">
            <jsp:include page="accountsDetailsGrid.jsp"></jsp:include>
        </div>
    </td>
  </tr>

</table>
</div>
</body>

</html>