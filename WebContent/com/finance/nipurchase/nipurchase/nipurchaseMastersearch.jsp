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
	    
		   /* Date */ 	
	    $("#datess").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy",value:null}); 
		   
	});   
		   
 	function loadSearchs() {
 		
 		var docnoss=document.getElementById("docnoss").value;
 		var accountss=document.getElementById("accountss").value;
 		var accnamesss=document.getElementById("accnamess").value;
 		var datess=document.getElementById("datess").value;
 		var reftypess=document.getElementById("reftypess").value;
 		var desc=document.getElementById("description").value;
 		var description=desc.replace(/ /g, "%20");
 		var accnamess = accnamesss.replace(/ /g, "%20");

		
	var aa="yes";
		getdata(docnoss,accountss,accnamess,datess,reftypess,aa,description);
 

	}
	function getdata(docnoss,accountss,accnamess,datess,reftypess,aa,description){
		
		 $("#refreshdivs").load('submasterSearch.jsp?docnoss='+docnoss+'&accountss='+accountss+'&accnamess='+accnamess+'&datess='+datess+'&reftypess='+reftypess+'&aa='+aa+'&description='+description);

		}

	</script>
		<style type="text/css">


.searchPop table {
  border-collapse: separate;
  border-spacing: 15px 18px;  
}


.searchPop td[align="right"] {
  font-weight: 300;
  font-size: 14px;
  color: #222;
}


.searchPop input[type="text"] {
  font-weight: 300;
  font-size: 13px;
  padding: 8px 12px;
  width: 95%;               /* Prevent overflow */
  max-width: 100%;
  box-sizing: border-box;   /* Include padding in width */
}


.searchPop #bankdate, #chqdate {
  font-weight: 300;
  font-size: 13px;
}

/* Bold button text */
.searchPop .myButton {
  font-weight: 300;
  font-size: 13px;
}

/* Additional spacing for rows */
.searchPop table {
  border-collapse: separate;
  /* Reduced vertical spacing (8px) while keeping horizontal gap (15px) */
  border-spacing: 15px 8px; 
}

/* Increased font size for labels */
.searchPop td[align="right"] {
  font-weight: 300;
  font-size: 13px; /* Larger font */
  color: #222;
  white-space: nowrap; /* Prevents labels from breaking into two lines */
}

/* Larger font and better padding for inputs */
.searchPop input[type="text"], select {
  font-weight: 300;
  font-size: 12px; /* Larger font */
  padding: 16px 10px; /* Comfortable padding without being too tall */
  box-sizing: border-box;
}

/* Specifically adjust the jqxDateTimeInput size to match */
.searchPop #datess {
  font-size: 16px !important;
}

/* Bold and large button */
.searchPop .myButton {
  font-weight: 300;
  font-size: 13px;
  padding: 5px 15px;
  cursor: pointer;
}

/* This removes the extra padding browsers sometimes add to table cells */
.searchPop td {
  padding: 2px 0px;
}

</style>
<body bgcolor="#E0ECF8">
<div id=search class="searchPop"> 
<table width="100%" >
  <tr >
   <td>
   <table width="100%"   >
   <tr>
   
    <td align="right" width="6%">Doc No</td>
    <td align="left" width="20%"><input type="text" name="docnoss" id="docnoss"  style="width:90%;" value='<s:property value="docnoss"/>'></td>
    <td align="right" width="8%">Account</td>
    <td align="left"><input type="text" name="accountss" id="accountss" style="width:100%;"  value='<s:property value="accountss"/>'></td>
    
   <td align="right"  width="10%">Account Name</td>
    <td align="left"  width="30%"><input type="text" name="accnamess" style="width:90%;" id="accnamess" value='<s:property value="accnamess"/>'></td>
    
    <tr>
    
    </td>
  </tr>
  <tr>
  <td>
  <!-- <table width="100%"> -->
        <tr> 
        <td align="right" width="6%">Date </td>
    <td align="left" width="20%"><div id="datess" name="datess"  value='<s:property value="datess"/>'></div></td>
   
    <td align="right" width="10%">Description</td><td  width="100%"><input type="text" name="description" style="width:100%;" id="description" value='<s:property value="description"/>'></td>
   
    <td align="right" width="8%">Type</td><td  width="10%"><select  name="reftypess" id="reftypess" style="width:100%;"  value='<s:property value="reftypess"/>' >
  <option value="">--select--</option>
  <option value="DIR" >DIR</option>
      <option value="NPO" >NPO</option>
   </select> &nbsp; <input type="button" name="searchs" id="searchs" class="myButton" value="Search"  onclick="loadSearchs()"> </td>
   
   </tr>
  
    </table>
  </td>



  <tr>
    <td colspan="8" align="right">
    
    <div id="refreshdivs">
      
   <jsp:include  page="submasterSearch.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>