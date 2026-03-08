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

<script type="text/javascript">
	$(document).ready(function () {}); 

 	function mainloadSearch() {
 		
 		var empnames=document.getElementById("empnames").value;
 		var empids=document.getElementById("empids").value;
 		var docnoss=document.getElementById("docnoss").value;
 		var mobnos=document.getElementById("mobnos").value;	
 		var empns = empnames.replace(/ /g, "%20");
 		var employeebranchchk=window.parent.employeebranchchk.value; 
 		var branch=document.getElementById("brchName").value;  
 		getdata(empns,empids,docnoss,mobnos, employeebranchchk, branch);
	}
 	
	function getdata(empns,empids,docnoss,mobnos, employeebranchchk, branch){
		 $("#srefreshdiv").load('submainSearch.jsp?empns='+empns+'&empids='+empids+'&docnoss='+docnoss+'&mobnos='+mobnos+'&branch='+branch+'&employeebranchchk='+employeebranchchk);
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
    table-layout: fixed; /* Ensures all columns respect the defined width exactly */
}

td[align="right"] {
    font-size: 13px;
    font-weight: 700;
    color: #333;
    white-space: nowrap;
}

/* Equalizing input heights and proportions */
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
    transition: border-color 0.2s;
}

input[type="text"]:focus {
    border-color: #2563eb;
    outline: none;
}

.myButton {
    font-family: Tahoma, Geneva, sans-serif;
    font-weight: 700;
    font-size: 13px;
    width: 100%; /* Button fills its container cell */
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

#srefreshdiv {
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
            <td align="right">Name</td>
            <td colspan="3">
                <input type="text" name="empnames" id="empnames" value='<s:property value="empnames"/>'>
            </td>
            <td rowspan="2" align="center" valign="middle">
                <input type="button" name="mbtnrasearch" id="mbtnrasearch" class="myButton" value="SEARCH" onclick="mainloadSearch();">
            </td>
        </tr>

        <tr>
            <td align="right">Emp ID</td>
            <td>
                <input type="text" name="empids" id="empids" value='<s:property value="empids"/>'>
            </td>
            <td align="right">Doc No</td>
            <td>
                <input type="text" name="docnoss" id="docnoss" value='<s:property value="docnoss"/>'>
            </td>
        </tr>

        <tr>
            <td align="right">Mobile</td>
            <td>
                <input type="text" name="mobnos" id="mobnos" value='<s:property value="mobnos"/>'>
            </td>
            <td colspan="3">&nbsp;</td> </tr>

        <tr>
            <td colspan="5">
                <div id="srefreshdiv">
                    <jsp:include page="submainSearch.jsp"></jsp:include>
                </div>
            </td>
        </tr>
    </table>
</div>
</body>
</html>