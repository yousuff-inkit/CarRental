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
	<style type="text/css">


table {
  border-collapse: separate;
   border-spacing: 6px 8px;    
}


td[align="right"] {
  font-weight: 300;
  font-size: 14px;
  color: #222;
}


input[type="text"] {
  font-weight: 300;
  font-size: 14px;
  padding: 4px 6px;
  width: 95%;               /* Prevent overflow */
  max-width: 100%;
  box-sizing: border-box;   /* Include padding in width */
}


#bankdate, #chqdate {
  font-weight: 300;
  font-size: 14px;
}

/* Bold button text */
.myButton {
  font-weight: 700;
  font-size: 14px;
  /* Visual Button Appearance for consistency */
  background-color: #007bff; /* blue background */
  color: white; /* White text */
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  box-shadow: 0 2px 5px rgba(0,0,0,0.2);
  transition: background-color 0.3s;
}

/* Bold button text */
.myButton {
  font-weight: 300;
  font-size: 14px;
}

/* Additional spacing for rows */
tr {
  line-height: 1.2;
}

</style>
	<script type="text/javascript">

	$(document).ready(function () { 
	    
		   /* Date */ 	
	    $("#datess").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy",value:null}); 
		   
	});   
		   
 	function loadSearchs() {
 		
 		var docnoss=document.getElementById("docnoss").value;
 		var accountss=document.getElementById("accountss").value;
 		var accnamesss=document.getElementById("accnamess").value;
 		var datess=document.getElementById("datess").value;
;
 		
 		var accnamess = accnamesss.replace(' ', '%20');

		
	var aa="yes";
		getdata(docnoss,accountss,accnamess,datess,aa);
 

	}
	function getdata(docnoss,accountss,accnamess,datess,aa){
		
		 $("#refreshdivs").load('Subsearch.jsp?docnoss='+docnoss+'&accountss='+accountss+'&accnamess='+accnamess+'&datess='+datess+'&aa='+aa);

		}

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr >
   <td>
   <table width="100%" >
   <tr>
    <td align="right" width="6%">Doc No</td>
    <td align="left" width="20%"><input type="text" name="docnoss" id="docnoss"  style="width:90%;" value='<s:property value="docnoss"/>'></td>
    <td align="right" width="10%">Account</td>
    <td align="left"><input type="text" name="accountss" id="accountss" style="width:80%;"  value='<s:property value="accountss"/>'></td>
    
   <td align="right"  width="14%">Account Name</td>
    <td align="left"  width="30%"><input type="text" name="accnamess" style="width:90%;" id="accnamess" value='<s:property value="accnamess"/>'></td>
    
    <tr>
    </table>
    </td>
  </tr>
  <tr>
  <td>
  <table width="100%">
        <tr> 
        <td align="right" width="6%">Date </td>
    <td align="left" width="20%"><div id="datess" name="datess"  value='<s:property value="datess"/>'></div></td>
    <td align="right" width="10%">&nbsp;</td><td  width="20%"><input type="button" name="searchs" id="searchs" class="myButton" value="Search"  onclick="loadSearchs()">
</td>
   <td width="10%"></td>
   <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   </td>
    <tr>
    </table>
  </td>

  <tr>
    <td colspan="8" align="right">
    
    <div id="refreshdivs">
      
   <jsp:include  page="Subsearch.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>