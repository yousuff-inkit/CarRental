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

    /* Outer search container */
    #search {
        width: 98%;
        margin: 20px auto;
        padding: 15px;
        background: #ffffff;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 92, 184, 0.18);
        border: 1px solid #c6ddf5;
        color: #000000;
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

    /* Refresh div (results grid container) */
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
 
 		var fleetno=document.getElementById("fleetno").value;
 		var regno=document.getElementById("regno").value;
 		var flnames=document.getElementById("flname").value;
 		var color=document.getElementById("color").value;
 		var group=document.getElementById("group").value;
 	
 		var flname = flnames.replace(/ /g, "%20");
		
	var aa="yes";
		getdata(fleetno,regno,flname,color,group,aa);
 

	}
	function getdata(fleetno,regno,flname,color,group,aa){
		
		 $("#refreshdivs").load('subvehinfo.jsp?fleetno='+fleetno+'&regno='+regno+'&flname='+flname+'&color='+color+'&group='+group+'&aa='+aa);

		}

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr >
   <td>
   <table >
   <tr>
    <td align="right" width="6%">Fleet</td> 
    <td align="left" ><input type="text" name="fleetno" id="fleetno"  style="width:90%;" value='<s:property value="fleetno"/>'></td>
    <td align="right" width="14%">Reg No</td>
    <td align="left"><input type="text" name="regno" id="regno" value='<s:property value="regno"/>'></td>
    
   <td align="right"  width="14%">Name</td>
    <td align="left"  width="30%"><input type="text" name="flname" style="width:90%;" id="flname" value='<s:property value="flname"/>'></td>
    
    <tr>
    </table>
    </td>
  </tr>
  <tr>
  <td>
  <table >
  <tr>
   <td align="right" width="6%">Color</td>
    <td align="left" ><input type="text" name="color"  style="width:90%;" id="color" value='<s:property value="color"/>'>
    <td align="right" width="14%">Group</td>
    <td align="left"><input type="text" name="group" id="group" value='<s:property value="group"/>'></td>
    <td align="right"  width="14%">&nbsp;</td>
    <td align="left"  width="30%"><input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search"  onclick="loadSearchs();"></td>
  </tr>
  </table>
  </td>

  <tr>
    <td colspan="8" align="right">
    
    <div id="refreshdivs">
      
   <jsp:include  page="subvehinfo.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>