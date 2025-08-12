 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <%--  <jsp:include page="../../../../includes.jsp"></jsp:include> --%>    
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
</style>
	<script type="text/javascript">
	$(document).ready(function () {
	 $("#dr_DOB").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {
 		
 		var clientnamess=document.getElementById("Cl_name").value;
 		var mob=document.getElementById("Cl_mob").value;
 		var lcno=document.getElementById("dr_Licence").value;
 		var passno=document.getElementById("dr_Passport").value;
 		var nation=document.getElementById("dr_Nation").value;
 		var dob=document.getElementById("dr_DOB").value;
		var masterrefnocldocno=$('#masterrefnocldocno').val();
 		var clname = clientnamess.replace(/ /g, "%20");
	
		getdata(clname,mob,lcno,passno,nation,dob,masterrefnocldocno);
 

	}
	function getdata(clname,mob,lcno,passno,nation,dob,masterrefnocldocno){
		
		 $("#refreshdiv").load('clientinfo.jsp?clname='+clname+'&mob='+mob+'&lcno='+lcno+'&passno='+passno+'&nation='+nation+'&dob='+dob+'&masterrefnocldocno='+masterrefnocldocno+'&id='+1);
	
		}

	</script>
<body bgcolor="#E0ECF8">
<div id=search>
	<table style="width:100%;" border="0" >
  		<tr>
  			<td align="right">Name</td>
    		<td align="left" colspan="3"><input type="text" name="Cl_name" id="Cl_name"  style="width:99%;" value='<s:property value="Cl_name"/>'></td>
    		<td align="right">MOB</td>
    		<td align="left"><input type="text" name="Cl_mob" id="Cl_mob" value='<s:property value="Cl_mob"/>'></td>
   			<td align="center" colspan="2">
    			<input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search"  onclick="loadSearch();">
    		</td>
   		</tr>
		<tr>
			<td align="right">Licence#</td>
			<td align="left"><input type="text" name="dr_Licence" id="dr_Licence" value='<s:property value="dr_Licence"/>'>
			<td align="right">Passport#</td>
			<td align="left"><input type="text" name="dr_Passport" id="dr_Passport" value='<s:property value="dr_Passport"/>'></td>
			<td align="right">Nationality</td>
			<td align="left"><input type="text" id="dr_Nation" name="dr_Nation" value='<s:property value="dr_Nation"/>'></td>
			<td align="right">DOB</td>
			<td align="left">
				<div id="dr_DOB" name="dr_DOB"  value='<s:property value="dr_DOB"/>'></div>
				<input type="hidden" name="hiddr_DOB" id="hiddr_DOB" value='<s:property value="hiddr_DOB"/>'>
			</td>
    		
    	</tr>
    	<tr>
	    	<td align="right" colspan="9">
    			<div id="refreshdiv">
    				<jsp:include  page="clientinfo.jsp"></jsp:include> 
   				</div>
    		</td>
  		</tr>
	</table>
</div>
</body>
</html>