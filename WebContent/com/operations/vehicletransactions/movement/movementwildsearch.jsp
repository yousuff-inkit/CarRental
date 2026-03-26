<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<!-- <link rel="stylesheet" type="text/css" href="../../../../css/body.css"> --> 
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<style>
.hidden-scrollbar {
  overflow: auto;
  height: 545px;
}
</style>
<script>
function funWildSearch(){
	alert("Inside Search Button");
	var tempdoc=document.getElementById("searchdocno").value;
	var tempfleet=document.getElementById("searchfleet").value;
	var tempregno=document.getElementById("searchregno").value;
	var tempstatus=document.getElementById("searchstatus").value;
	
	getWildData(tempdoc,tempfleet,tempregno,tempstatus);
}
function getWildData(tempdoc,tempfleet,tempregno,tempstatus) {
	alert("Inside Ajax Function");
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			//alert(items);
			$("#wildgriddiv").load("wildsearchgrid.jsp?id="+items);
		} else {
		}
	}
	x.open("GET", "getWildData.jsp?doc="+tempdoc+"&fleet="+tempfleet+"&regno="+tempregno+"&status="+tempstatus+"", true);
	x.send();
}
</script>
</head>
<style type="text/css">
/* Strict Scope to protect background page fonts */
#search {
    background-color: #ffffff;
    padding: 2px;
    font-family: Tahoma, Geneva, sans-serif !important;
}

#search table {
    border-collapse: separate;
    border-spacing: 4px 2px; /* Minimal spacing */
    background-color: #ffffff;
    width: auto; /* Shrink table to fit content */
}

/* Master UI Labels: Tahoma, Regular, 13px */
#search td {
    font-family: Tahoma, Geneva, sans-serif !important;
    font-weight: 400 !important; 
    font-size: 13px;
    color: #222;
    padding: 0 4px;
    white-space: nowrap;
}

/* Master UI Inputs: White Background, Grey Border */
#search input[type="text"] {
    font-family: Tahoma, Geneva, sans-serif !important;
    font-weight: 400 !important;
    font-size: 13px;
    padding: 3px 6px;
    width: 120px; /* Uniform compact width */
    box-sizing: border-box;   
    border: 1px solid #bdc3c7;
    border-radius: 3px;
    height: 24px;
    background-color: #ffffff !important;
    outline: none;
}

#search input[type="text"]:focus {
    border-color: #2563eb;
}

/* EXACT Master UI Gradient Button - Fixed 90px Width */
#search .myButton {
    font-family: Tahoma, Geneva, sans-serif !important;
    font-weight: 700 !important;
    font-size: 11px;
    width: 90px !important;
    height: 26px;
    padding: 0;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%) !important;
    color: #ffffff !important;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: all 0.2s ease;
    box-shadow: 0 1px 3px rgba(59, 130, 246, 0.2);
    text-transform: uppercase;
    text-align: center;
}

#search .myButton:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%) !important;
    transform: translateY(-1px);
}

#wildgriddiv {
    margin-top: 5px;
    border-top: 1px solid #eee;
}
</style>

<body bgcolor="#ffffff">
<div id="search">
    <table border="0">
        <tr>
            <td align="right">Doc No</td>
            <td><input type="text" name="searchdocno" id="searchdocno" value='<s:property value="searchdocno"/>'/></td>
            
            <td align="right">Fleet</td>
            <td><input type="text" name="searchfleet" id="searchfleet" value='<s:property value="searchfleet"/>'/></td>
            
            <td align="right">Reg No</td>
            <td><input type="text" name="searchregno" id="searchregno" value='<s:property value="searchregno"/>'/></td>
            
            <td align="right">Status</td>
            <td><input type="text" name="searchstatus" id="searchstatus" value='<s:property value="searchstatus"/>'/></td>
            
            <td style="padding-left: 10px;">
                <input type="button" name="btndsearch" id="btndsearch" class="myButton" value="Search" onclick="funWildSearch();">
            </td>
        </tr>
    </table>
    
    <div id="wildgriddiv">
        <jsp:include page="wildsearchgrid.jsp"></jsp:include>
    </div>
</div>
</body>
</html>