
   
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
<% String fleetno=request.getParameter("fleetno");
String cldocno=request.getParameter("cldocno");
String odate=request.getParameter("odate");
%>

	<script type="text/javascript">
	$(document).ready(function () {


	}); 

	function  funuserupdates()
	
	{
	
		
		
		var fleetno='<%=fleetno%>';
		var cldocno='<%=cldocno%>';
		var odate='<%=odate%>';
		var userids=document.getElementById("userdoc").value;
		var userdesc=document.getElementById("userdesc").value;
		
		if(userids=="")
		{
			document.getElementById("errormsg").innerText="Select User Name";
			return 0;
		}
	else{
		 document.getElementById("errormsg").innerText="";
	   }
	
		if(userdesc=="")
		{
		   	document.getElementById("errormsg").innerText="Enter Description";
			document.getElementById("userdesc").focus(); 
			return 0;
		}
	else{
			 document.getElementById("errormsg").innerText="";
	   }
	 var nmaxs = userdesc.length;
    		
    		
          if(nmaxs>74)
       	   {
		       	document.getElementById("errormsg").innerText="Description Cannot Contain More Than 75 Characters";
				document.getElementById("userdesc").focus(); 
		       	   
				return 0;
			}
		else{
			 	document.getElementById("errormsg").innerText="";
		   }
		

		funsavedatas(userids,userdesc,fleetno,cldocno,odate);
		
	}

	function funsavedatas(userids,userdesc,fleetno,cldocno,odate)
	{
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	var items= x.responseText.trim();
			 	document.getElementById("specialdiscountuser").value=items;
			 	
	 			$.messager.alert('Message', 'Permitted By Special Approval');
	 			$('#usersearchwindow').jqxWindow('close');
		}
		}
	     x.open("GET","saveuserdata.jsp?userids="+userids+"&userdesc="+userdesc+"&fleetno="+fleetno+"&cldocno="+cldocno+"&odate="+odate,true);
	    x.send();
	   
		
	}
	
	
	</script>
<style type="text/css">
/* Master UI Styles */
/* Table spacing and layout */
table {
  border-collapse: separate;
  border-spacing: 15px 12px; /* Standardized master gap */
}

/* Bold labels - Standardized to Master UI 14px Tahoma */
td[align="right"] {
  font-family: Tahoma, Geneva, sans-serif;
  font-size: 14px;
  font-weight: 700;
  color: #222;
  white-space: nowrap;
}

/* Bold text inside inputs with Grey Borders */
input[type="text"] {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 600; /* Font weight 600 as requested */
  font-size: 14px;
  padding: 8px 12px;
  max-width: 100%;
  box-sizing: border-box;
  /* Grey border */
  border: 1px solid #bdc3c7; 
  border-radius: 4px;
  background-color: #ffffff;
}

/* Focus state for inputs */
input[type="text"]:focus {
  border-color: #007bff;
  outline: none;
}

/* Master Button Appearance */
.myButton {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 700;
  font-size: 14px;
  background-color: #007bff; /* Blue Button Color */
  color: white;
  padding: 8px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  transition: none; /* No hover transition */
}

/* No color change on hover */
.myButton:hover {
  background-color: #007bff; 
  cursor: pointer;
}

/* Row spacing */
tr {
  line-height: 1.6;
}
</style>

<body bgcolor="#FFFFFF">
<div id="search">
<table width="100%">
  <tr>
    <td colspan="8" align="right">
      <div>
        <jsp:include page="userinfos.jsp"></jsp:include> 
      </div>
    </td>
  </tr>
  <tr>
    <td>
      <table width="100%">
        <tr>
          <td width="6%" align="right">Name</td>
          <td width="20%" align="left">
            <input type="text" style="width:99%;" name="usernames" id="usernames" readonly="readonly">
          </td>
          <td width="7%" align="right">Description</td>
          <td width="60%" align="left">
            <input type="text" style="width:99%;" name="userdesc" id="userdesc">
          </td>
          <td width="7%">
            <input type="button" name="updateuser" id="updateuser" class="myButton" value="Submit" onclick="funuserupdates()">
          </td>
        </tr>
      </table> 
    </td>
  </tr>
</table>

<input type="hidden" name="userdoc" id="userdoc" value='<s:property value="userdoc"/>'>
</div>
</body>
</html>