 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <!--    <jsp:include page="../../../../includes.jsp"></jsp:include>   -->
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
</style>
<style>
/* Body background */
body {
    background-color: #E0ECF8;
    font-family: "Segoe UI", Roboto, sans-serif;
    margin: 0;
    padding: 0;
}

/* Search container */
#search {
    background-color: #ffffff;
    border: 1px solid #D8E6F7;
    border-radius: 8px;
    padding: 15px;
    margin: 20px auto;
    width: 95%;
    box-shadow: 0 2px 6px rgba(0, 80, 160, 0.1);
}

/* Table inputs */
#search input[type="text"] {
    padding: 6px 8px;
    border: 1px solid #C7DBF3;
    border-radius: 4px;
    width: 150px;
    font-size: 13px;
    color: #00315C;
}

/* Button style */
.myButton {
    background-color: #2F75C5;
    border: none;
    color: #ffffff;
    padding: 7px 16px;
    text-align: center;
    text-decoration: none;
    font-size: 13px;
    border-radius: 5px;
    cursor: pointer;
    font-weight: 600;
    transition: background-color 0.3s ease;
}

.myButton:hover {
    background-color: #1f4f8a;
}

/* Table labels */
#search td {
    font-weight: 600;
    color: #2F75C5;
    padding: 4px 6px;
    vertical-align: middle;
}

/* Refresh div (grid container) */
#refreshdivs {
    margin-top: 15px;
}
</style>
<style>
/* Container adjustments */
#search table {
    width: 100%;
    border-collapse: collapse;
}

/* Label alignment */
#search td[align="right"] {
    text-align: right;
    padding-right: 8px;
    vertical-align: middle;
    font-weight: 600;
    color: #2F75C5;
}

/* Input alignment */
#search td[align="left"] input[type="text"] {
    width: 90%;
    padding: 5px 8px;
    border: 1px solid #C7DBF3;
    border-radius: 4px;
    font-size: 13px;
    color: #00315C;
}

/* Button styling */
.myButton {
    background-color: #2F75C5;
    border: none;
    color: #ffffff;
    padding: 6px 16px;
    font-size: 14px;
    border-radius: 5px;
    cursor: pointer;
    font-weight: 600;
    transition: background-color 0.3s ease;
}

.myButton:hover {
    background-color: #1f4f8a;
}
</style>

	<script type="text/javascript">

 	function loadSearchs() {
 		var aa="yes";

 		var documentno=document.getElementById("documentno").value;
 		var regno=document.getElementById("regno").value;
 		var fleetno=document.getElementById("fleetno").value; 	
 		var name = document.getElementById("name").value;
 		name=name.replace(/ /g, "%20");
			 	 getdata(documentno,fleetno,regno,name,aa);
 	}
	function getdata(documentno,fleetno,regno,name,aa){
		 $("#refreshdivs").load('masterSearchGrid.jsp?fleetno='+fleetno+'&regno='+regno+'&name='+name+'&documentno='+documentno+'&aa='+aa);

		}

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr >
   <td>
   <table >
   <tr>
    <td align="right" width="14%">DOC NO</td> 
    <td align="left" ><input type="text" name="documentno" id="documentno"  style="" value='<s:property value="documentno"/>'></td>
    <td align="right" width="14%">FLEET NO</td>
    <td align="left"><input type="text" name="fleetno" id="fleetno" value='<s:property value="fleetno"/>'></td>
    <td align="right" width="14%">REG NO</td>
    <td align="left"><input type="text" name="regno" id="regno" value='<s:property value="regno"/>'></td>   
  
    <tr>
    </table>
    </td>
  </tr>
  <tr>
   <td>
  <table >
  <tr>
 <!--   <td align="right" width="6%">Test</td>
    <td align="left" ><input type="text" name="color"  style="width:90%;" id="color" value='<s:property value="color"/>'>
    <td align="right" width="14%">Group</td>
    <td align="left"><input type="text" name="group" id="group" value='<s:property value="group"/>'></td>
    <td align="right"  width="14%">&nbsp;</td> -->
     <td align="right"  width="22%">NAME</td>
    <td align="left"  width="0%"><input type="text" name="name" style="" id="name" value='<s:property value="name"/>'></td>
    
    <td align="left"  width="30%"><input type="button" style="margin-left:32px" name="btnrasearch" id="btnrasearch" class="myButton" value="Search"  onclick="loadSearchs();"></td>
  </tr>
  </table>
  </td>

  <tr>
    <td colspan="8" align="right">
    
    <div id="refreshdivs">
      
 <jsp:include  page="masterSearchGrid.jsp"></jsp:include>
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>