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
		<style type="text/css">
#search {
    width: 100%;
    max-width: 900px;
    margin: 0 auto;
    background: #ffffff;
    border: 1px solid #ccc;
    font-family: Tahoma, Geneva, sans-serif;
    box-sizing: border-box;
    padding: 10px;
    border-radius: 4px;
}

#search table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 10px 8px; 
    table-layout: fixed;
}

td.label {
    font-size: 13px;
    font-weight: 700;
    color: #333;
    white-space: nowrap;
    text-align: right;
}

input[type="text"], select {
    font-family: Tahoma, Geneva, sans-serif;
    font-weight: 600;
    font-size: 13px;
    padding: 6px 10px;
    width: 100%;
    box-sizing: border-box;
    border: 1px solid #d1d5db;
    border-radius: 4px;
    height: 30px;
}

.myButton {
    font-family: Tahoma, Geneva, sans-serif;
    font-weight: 700;
    font-size: 13px;
    width: 100%;
    max-width: 140px;
    height: 38px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 2px 4px rgba(59, 130, 246, 0.2);
    text-transform: uppercase;
    letter-spacing: 0.5px;
    text-align: center;
}

.myButton:hover {
    background: linear-gradient(135deg, #2563eb 0%, #0b45a2 100%);
    box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
    transform: translateY(-1px);
}

#refreshdiv {
    margin-top: 10px;
    border-top: 1px solid #e0e4ee;
    width: 100%;
}
</style>

<body bgcolor="#E0ECF8">
<div id="search">
    <table border="0">
        <colgroup>
            <col width="12%"> <col width="30%"> <col width="12%"> <col width="26%"> <col width="20%"> </colgroup>
        
        <tr>
            <td class="label">Date</td>
            <td class="field">
                <div id="dscdate"></div>
            </td>

            <td class="label">Doc No</td>
            <td class="field">
                <input type="text" name="txtdocno" id="txtdocno" value="<s:property value='txtdocno'/>">
            </td>

            <td class="action" rowspan="2" align="center" valign="middle">
                <input type="button" class="myButton" value="Search" onclick="loadSearch();">
            </td>
        </tr>

        <tr>
            <td class="label">Name</td>
            <td class="field">
                <input type="text" name="txtempname" id="txtempname" value="<s:property value='txtempname'/>">
            </td>

            <td class="label">Amount</td>
            <td class="field">
                <input type="text" name="txtamount1" id="txtamount1" value="<s:property value='txtamount'/>">
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