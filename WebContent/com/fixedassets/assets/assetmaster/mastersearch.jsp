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

	<script type="text/javascript">
	$(document).ready(function () {
	
	}); 

 	function mainloadSearch() {
 		
 		
 	
 		var sclnames=document.getElementById("assetnamess").value;
 		var gp=document.getElementById("assetgroupss").value;
 		
 		var sdocno=document.getElementById("sdocno").value;
 		var assetid=document.getElementById("assetidss").value;

 		

 		var assetgroup = gp.replace(/ /g, "%20");
 		var assetname = sclnames.replace(/ /g, "%20");
 		var chk="yes";
		getdata(assetname,assetid,sdocno,assetgroup,chk);
		
		

	}
	 function getdata(assetname,assetid,sdocno,assetgroup,chk){



		
		 $("#srefreshdiv").load('submasterSearch.jsp?assetname='+assetname+'&assetid='+assetid+'&sdocno='+sdocno+'&assetgroup='+assetgroup+'&chk='+chk);
		 

		  
/* x.open("GET", "dissearch.jsp?sclname="+sclname+"&smob="+smob+"&rno="+rno+"&flno="+flno+"&sregno="+sregno+"&smra="+smra, true);
		x.send(); */
		}
 
	</script> 
<style type="text/css">
/* Master UI Styles (with added button styling for visual consistency) */

table {
  border-collapse: separate;
  border-spacing: 15px 18px; 
}


td[align="right"] {
  font-weight: 700;
  font-size: 14px;
  color: #222;
}


input[type="text"] {
  font-weight: 600;
  font-size: 14px;
  padding: 8px 12px;
  max-width: 100%;
  box-sizing: border-box; /* Include padding in width */
}

/* Bold button text */
.myButton {
  font-weight: 700;
  font-size: 14px;
  /* Added Master Button Appearance: Using a common blue/grey theme for high visibility */
  background-color: #007bff; /* Green background */
  color: white; /* White text */
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  box-shadow: 0 2px 5px rgba(0,0,0,0.2);
  transition: background-color 0.3s;
}

/* Button Hover/Active Effects */
.myButton:hover {
  background-color: #45a049; /* Darker green on hover */
}

/* Additional spacing for rows */
tr {
  line-height: 1.8;
}
</style>

<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr >
    <td>
      <table width="100%" >
        <tr>
          <td align="left" width="8%" style="font-weight: 700; font-size: 14px; color: #222;">Doc NO</td>
          <td align="left" width="10%" width=><input type="text" name="sdocno" id="sdocno" value='<s:property value="sdocno"/>'>
          
          <td align="right" style="font-weight: 700; font-size: 14px; color: #222;">Asset Id</td>
          
          <td align="left" width="20%"><input type="text" name="assetidss" id="assetidss" style="width:96.5%;" value='<s:property value="assetidss"/>'></td>
          
          <td align="right" style="font-weight: 700; font-size: 14px; color: #222;">Asset Name</td>
          <td align="left" colspan="3"><input type="text" id="assetnamess" name="assetnamess" style="width:96.5%;"  value='<s:property value="assetnamess"/>'></td>
          
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td>
      <table width="100%">
        <tr>
          <td align="right"  width="8%" style="font-weight: 700; font-size: 14px; color: #222;">Asset Group</td>
          <td align="left" width="53%"><input type="text" name="assetgroupss" id="assetgroupss"  style="width:89.5%;" value='<s:property value="assetgroupss"/>'></td>
          
          <td colspan="2" align="center"><input type="button" name="mbtnrasearch" id="mbtnrasearch" class="myButton" value="Search"  onclick="mainloadSearch();"></td>
        <tr>
      </table>
      
    </td>
  </tr>
  <tr>
    <td colspan="8" align="right">
      <div id="srefreshdiv">
        <jsp:include page="submasterSearch.jsp" />
      </div>
    </td>
  </tr>
</table>
</div>
</body>
</html>