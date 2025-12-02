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
    /* Body styling */
    body {
        background-color: #E0ECF8;
        font-family: "Segoe UI", Roboto, sans-serif;
        margin: 0;
        padding: 0;
        color: #000000; /* Black text */
    }

    /* Outer search box */
    #search {
        width: 98%;
        margin: 20px auto;
        padding: 15px;
        background: #ffffff;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 92, 184, 0.18);
        border: 1px solid #c6ddf5;
        color: #000000; /* Ensure text inside search box is black */
    }

    /* Table styling */
    table {
        width: 100%;
        border-collapse: collapse;
    }

    td {
        font-size: 14px;
        color: #000000; /* Black labels */
        padding: 4px 8px;
        vertical-align: middle;
    }

    td[align="right"] {
        text-align: right;
        font-weight: 600;
    }

    td[align="left"] input[type="text"] {
        width: 90%;
        padding: 6px 8px;
        font-size: 13px;
        color: #000000; /* Black input text */
        border: 1px solid #b7d1ee;
        border-radius: 6px;
        outline: none;
        transition: 0.3s;
        background-color: #ffffff;
    }

    td[align="left"] input[type="text"]:focus {
        border-color: #0d6efd;
        box-shadow: 0 0 4px rgba(13, 110, 253, 0.4);
        color: #000000; /* Ensure focused text stays black */
    }

    /* Search button */
    .myButton {
        background: #0d6efd;
        color: #ffffff;
        padding: 8px 20px;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        font-size: 14px;
        font-weight: 600;
        transition: 0.3s;
    }

    .myButton:hover {
        background: #0b5ed7;
        box-shadow: 0 4px 10px rgba(13, 110, 253, 0.3);
        transform: translateY(-2px);
    }

    /* Refresh div styling */
    #refreshdivs {
        margin-top: 15px;
        padding: 10px;
        background: #ffffff;
        border: 1px solid #cfdaf0;
        border-radius: 10px;
        box-shadow: 0 3px 8px rgba(0, 92, 184, 0.12);
        color: #000000; /* Black text inside grid */
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