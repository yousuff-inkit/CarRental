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
	  $("#enqdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null}); 
	}); 

 	function enqloadSearch1() {
 		
 		var enqdate=document.getElementById("enqdate").value;
 		// var type=document.getElementById("type").value;
//  		var Cl_mobno=document.getElementById("question").value;
//  		var enqtype=document.getElementById("enqtype").value;
 		var msdocno=document.getElementById("msdocno").value; 
 		//var types = type.replace(' ', '%20');
 		var aa="yes";
	//getdata1(types,msdocno,enqdate);
	
 		getdata1(msdocno,enqdate,aa);
 

	}
	//function getdata1(types,msdocno,enqdate){
		
function getdata1(msdocno,enqdate,aa){
		
		// $("#refreshdivmas").load('subMastersearch.jsp?type='+types+'&msdocno='+msdocno+'&enqdate='+enqdate);
		
		$("#refreshdivmas").load('subMastersearch.jsp?msdocno='+msdocno+'&enqdate='+enqdate+'&aa='+aa);
		
		}

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
<table width="100%" >
  <tr>
   <td>                         
   <table>
   <tr>
   <td align="right">Docno</td>
    <td align="left" width="2%"><input type="text" name="msdocno" id="msdocno"  value='<s:property value="msdocno"/>'></td>
<td align="right" >Date</td>
<td align="left" ><div id="enqdate" name="enqdate"  value='<s:property value="enqdate"/>'></div></td>
<%-- <td align="right" >Type</td>
    <td align="left" width="70%" ><input type="text" name="type" id="type"  style="width:96.5%;" value='<s:property value="type"/>'></td>
 --%>
<td><input type="button" name="quebtnsearch" id="quebtnsearch" class="myButton" value="Search"  onclick="enqloadSearch1()"></td>
      </tr>
    </table>
    </td>
</tr>

  <tr>
    <td colspan="8" align="right">
    
    <div id="refreshdivmas">
      
   <jsp:include  page="subMastersearch.jsp"></jsp:include> 
   
   </div>
    </td>
  </tr>
</table>
  </div>
</body>
</html>