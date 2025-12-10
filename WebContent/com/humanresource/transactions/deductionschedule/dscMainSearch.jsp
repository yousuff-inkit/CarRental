 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

	<script type="text/javascript">
	$(document).ready(function () {
	 $("#dscdate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {

 		var empname=document.getElementById("txtempname").value;
 		var docNo=document.getElementById("txtdocno").value;
 		var date=$("#dscdate").jqxDateTimeInput('val');
 		//alert($("#dscdate").jqxDateTimeInput('val')+"=datevales==="+date)
 		var amount=document.getElementById("txtamount1").value;
 		var employeebranchchk=window.parent.employeebranchchk.value.trim(); 
 		var branch=document.getElementById("brchName").value; 
		getdata(empname,docNo,date,amount, employeebranchchk, branch);
	}
	function getdata(empname,docNo,date,amount, employeebranchchk, branch){
		//console.log(empname+"="+docNo+"="+date+"="+amount+"="+employeebranchchk.trim()+"="+branch+"=");
		 $("#refreshdiv").load('dscMainSearchGrid.jsp?empname='+encodeURIComponent(empname)+'&docNo='+docNo+'&date='+date+'&amount='+amount+'&branch='+branch+'&employeebranchchk='+employeebranchchk+'&id='+1);
		}

	</script>
		<style>
#search td,
#search label {
    font-weight: 700 !important;
    white-space: nowrap !important;
}

#search input[type="text"] {
    padding: 5px 8px;
    height: 26px;
    border: 1px solid #b8c6d8;
    border-radius: 5px;
    font-weight: 600;
    width: 100%;
    box-sizing: border-box;
}

#search td {
    padding: 4px 6px;
    vertical-align: middle;
}

.myButton {
    padding: 6px 18px;
    font-weight: 700;
}

#dscdate {
    border: 1px solid #b8c6d8 !important;
    border-radius: 5px;
    padding: 2px;
    background: white !important;
}

#search-table {
    width: 100%;
    table-layout: auto;      /* natural spacing */
}

</style>
<body>
<div id="search">

<table id="search-table">

<tr>
    <td>Date</td>
    <td>
        <div class="row-flex">
            <div class="col">
                <div id="dscdate"></div>
            </div>
        </div>
    </td>

    <td>Doc No</td>
    <td>
        <input type="text" id="txtdocno" name="txtdocno" class="input-box"
               value="<s:property value='txtdocno'/>">
    </td>

    <td rowspan="2" align="center">
        <button type="button" class="search-btn myButton" onclick="loadSearch();">
            Search
        </button>
    </td>
</tr>

<tr>
    <td>Name</td>
    <td>
        <input type="text" id="txtempname" name="txtempname" 
               class="input-box" value="<s:property value='txtempname'/>">
    </td>

    <td>Amount</td>
    <td>
        <input type="text" id="txtamount1" name="txtamount1" 
               class="input-box" value="<s:property value='txtamount'/>">
    </td>
</tr>

<tr>
    <td colspan="5">
        <div id="refreshdiv">
            <jsp:include page="dscMainSearchGrid.jsp"></jsp:include>
        </div>
    </td>
</tr>

</table>

</div>

</body>

</html>