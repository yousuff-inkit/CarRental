 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>	 
	<% String contextPath=request.getContextPath();%>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>GatewayERP(i)</title>
	<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
	<style type="text/css">
		#search table tr td{
			font-size:10px;
		}
		#search table tr td input{
			height:18px;
		}
	</style>
	<script type="text/javascript">
		function mainloadSearch() {
 			var sclname=document.getElementById("SCl_name").value;
	 		var smob=document.getElementById("Sl_mob").value;
	 		var rno=document.getElementById("rno").value;
	 		var flno=document.getElementById("flno").value;
	 		var sregno=document.getElementById("sregno").value;
	 		var smra=document.getElementById("smra").value;
			var branch=document.getElementById("cmbbranch").value;
	 		
			getdata(sclname,smob,rno,flno,sregno,smra,branch);
		}
	 	
		function getdata(sclname,smob,rno,flno,sregno,smra,branch){
			var agmttype=$('#cmbagmttype').val();
			$("#overlay, #PleaseWait").show();
			$("#srefreshdiv").load('agmtSearchGrid.jsp?sclname='+sclname+'&smob='+smob+'&rno='+rno+'&flno='+flno+'&sregno='+sregno+'&smra='+smra+'&branch='+branch+'&id=1&agmttype='+agmttype);
		}
 
	</script>
</head>
<body bgcolor="#E0ECF8">
	<div id=search>
		<table  width="100%" border="0" >
	   		<tr>
	    		<td align="right">Name</td>
	    		<td align="left" colspan="3"><input type="text" name="SCl_name" id="SCl_name"  style="width:99%;" value='<s:property value="SCl_name"/>'></td>
	    		<td align="right">MOB</td>
	    		<td align="left"><input type="text" name="Sl_mob" id="Sl_mob" value='<s:property value="Sl_mob"/>'></td>
	      		<td align="right">MRA</td>
	    		<td align="left"><input type="text" id="smra" name="smra" value='<s:property value="smra"/>'> </td>
	    	</tr>
	  		<tr>
	 			<td  align="right" >Doc NO</td>
			    <td align="left" ><input type="text" name="rno" id="rno" value='<s:property value="rno"/>'>
			    <td align="right">Fleet NO</td>
			    <td align="left" ><input type="text" name="flno" id="flno" style="width:96.5%;" value='<s:property value="flno"/>'></td>
			    <td align="right">Reg NO</td>
			    <td align="left" ><input type="text" id="sregno" name="sregno" value='<s:property value="sregno"/>'></td>
			    <td colspan="2" align="center"><input type="button" name="mbtnrasearch" id="mbtnrasearch" class="myButton" value="Search"  onclick="mainloadSearch();"></td>
	  		</tr>
	  		<tr>
	  			<td colspan="8">
	  				<div id="srefreshdiv">
	  					<jsp:include  page="agmtSearchGrid.jsp"></jsp:include> 
	   				</div>			
	  			</td>
	  		</tr>
	  	</table>
	</div>
</body>
</html>