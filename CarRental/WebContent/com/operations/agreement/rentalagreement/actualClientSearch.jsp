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
	 $("#searchclientdob").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function funClientSearch() {
 		
 		var clientnamess=document.getElementById("searchclientname").value;
 		var mob=document.getElementById("searchclientmobile").value;
 		var lcno=document.getElementById("searchclientlicense").value;
 		var passno=document.getElementById("searchclientpassport").value;
 		var nation=document.getElementById("searchclientnation").value;
 		var dob=document.getElementById("searchclientdob").value;
		var catdocno=$('#catdocno').val();
		
 		var clname = clientnamess.replace(/ /g, "%20");
		getdata(clname,mob,lcno,passno,nation,dob,catdocno);
 

	}
	function getdata(clname,mob,lcno,passno,nation,dob,catdocno){
		
		 $("#clientsearchdiv").load('actualClientSearchGrid.jsp?clname='+clname+'&mob='+mob+'&lcno='+lcno+'&passno='+passno+'&nation='+nation+'&dob='+dob+'&id=1&catdocno='+catdocno);
	
		}

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr >
   <td>
   <table>
   <tr>
    <td align="right">Name</td>
    <td align="left" width="73.7%"><input type="text" name="searchclientname" id="searchclientname"  style="width:99%;" value='<s:property value="searchclientname"/>'></td>
    <td align="left">MOB</td>
    <td align="left"><input type="text" name="searchclientmobile" id="searchclientmobile" value='<s:property value="searchclientmobile"/>'></td>
    <tr>
    </table>
    </td>
  </tr>
  
  <table>
  <tr>
   <td align="right">Licence#</td>
    <td align="left"><input type="text" name="searchclientlicense" id="searchclientlicense" value='<s:property value="searchclientlicense"/>'>
    <td align="right">Passport#</td>
    <td align="left"><input type="text" name="searchclientpassport" id="searchclientpassport" value='<s:property value="searchclientpassport"/>'></td>
    <td align="right">Nationality</td>
    <td align="left"><input type="text" id="searchclientnation" name="searchclientnation" value='<s:property value="searchclientnation"/>'></td>
    
    <td align="right">DOB</td>
    <td align="left"><div id="searchclientdob" name="searchclientdob"  value='<s:property value="searchclientdob"/>'></div>

    </td>
    <td colspan="2" align="center"><input type="button" name="btnclientsearch" id="btnclientsearch" class="myButton" value="Search"  onclick="funClientSearch();"></td>
  </tr>
  </table>
  </td>

  <tr>
    <td colspan="8" align="right">
    
    <div id="clientsearchdiv">
      
   <jsp:include  page="actualClientSearchGrid.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>