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
	 $("#terminatedDate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {

 		var empname=document.getElementById("txtempname").value;
 		var docNo=document.getElementById("txtdocno").value;
 		var date=document.getElementById("terminatedDate").value;
 		var amount=document.getElementById("txtamount").value;
	
		getdata(empname,docNo,date,amount);
	}
	function getdata(empname,docNo,date,amount){
		 $("#refreshdiv").load('htreMainSearchGrid.jsp?empname='+empname.replace(/ /g, "%20")+'&docNo='+docNo+'&date='+date+'&amount='+amount);
		}

	</script>
	
	
		<style>
#search-table {
    width: 100%;
    border-collapse: collapse;
}

.lbl {
    width: 10%;
    text-align: right;
    font-weight: 700;
    white-space: nowrap;
    padding-right: 8px;
}

.fld {
    width: 25%;
}

#search input[type="text"] {
    width: 95%;
    height: 28px;
    padding: 5px 8px;
    border: 1px solid #b8c6d8;
    border-radius: 5px;
    box-sizing: border-box;
    font-weight: 600;
}

#terminatedDate {
    width: 95% !important;
    padding: 0 !important;
}

.btn-cell {
    width: 15%;
    text-align: center;
}


</style>
	
<body>
<div id=search>
<table id="search-table" width="100%">
<tr>
    <td class="lbl">Date</td>
    <td class="fld">
        <div id="terminatedDate"></div>
    </td>

    <td class="lbl">Doc No</td>
    <td class="fld">
        <input type="text" id="txtdocno" name="txtdocno"
               value="<s:property value='txtdocno'/>">
    </td>

    <td class="btn-cell" rowspan="2">
        <button type="button" id="btnsearch" class="myButton" onclick="loadSearch();">
            Search
        </button>
    </td>
</tr>

<tr>
    <td class="lbl">Name</td>
    <td class="fld" colspan="1">
        <input type="text" id="txtempname" name="txtempname"
               value="<s:property value='txtempname'/>">
    </td>

    <td class="lbl">Amount</td>
    <td class="fld">
        <input type="text" id="txtamount" name="txtamount"
               value="<s:property value='txtamount'/>">
    </td>
</tr>

<tr>
    <td colspan="5">
        <div id="refreshdiv">
            <jsp:include page="htreMainSearchGrid.jsp"></jsp:include>
        </div>
    </td>
</tr>
</table>

  </div>
</body>
</html>