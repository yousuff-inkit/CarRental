<!DOCTYPE>
<html>
<head>
<% String contextPath=request.getContextPath();%>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="../../../../css/main.css" rel="stylesheet" type="text/css" />
<link href="../../../../css/body.css" media="screen" rel="stylesheet" type="text/css" />
<link href="../../../../css/myButton.css" rel="stylesheet" type="text/css"/>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/globalcss.css">
<style>

/* =======================
   GLOBAL WRAPPER
======================= */
#whole {
    width: 100%;
    background: #f3f7ff;
    font-family: "Segoe UI", Roboto, Arial, sans-serif;
}

/* =======================
   HEADER
======================= */
#header {
    background: linear-gradient(135deg, #cce4ff, #a9ccf7);
    color: #003366;
    text-align: left;
    height: 7%;
    width: 100%;
    padding: 8px 12px;
    border-bottom: 2px solid #8bb8f0;
    box-shadow: 0 2px 6px rgba(0, 60, 150, 0.15);
    font-weight: 600;
}

/* =======================
   HORIZONTAL NAVIGATION
======================= */


/* NAV LINKS */
#nav a {
    color: #003f7f;
    text-decoration: none;
    font-size: 13px;
    font-weight: 600;
    padding: 8px 14px;
    border-radius: 6px;
    transition: all 0.25s ease;
}

/* HOVER EFFECT */
#nav a:hover {
    background: linear-gradient(135deg, #8cc6ff, #5aa4f5);
    color: #ffffff;
    box-shadow: 0 4px 12px rgba(0, 80, 160, 0.3);
    transform: translateY(-2px);
}
#nav {
    display: flex !important;
    flex-direction: row !important;
    gap: 10px;
    align-items: center;
    flex-wrap: wrap; /* optional if too many buttons */
}

#nav a, 
#nav button, 
#nav .myButtons {
    display: inline-block !important;
}

/* =======================
   IFRAME CONTENT SECTION
======================= */
#comiframe {
    width: 100%;
    height: 95%;
    background: #ffffff;
    color: #003366;
    border: 1px solid #d0e3ff;
    border-radius: 6px;
    box-shadow: 0 4px 10px rgba(0, 70, 160, 0.15);
}

/* =======================
   BUTTONS - PREMIUM BLUE
======================= */
.myButtons {
    background: linear-gradient(to bottom, #5daeff 5%, #3e8be0 100%);
    border-radius: 4px;
    cursor: pointer;
    color: #ffffff;
    font-size: 11px;
    padding: 5px 12px;
    border: 1px solid #2c6bb3;
    text-decoration: none;
    box-shadow: 0 3px 6px rgba(0, 60, 150, 0.2);
    transition: all 0.2s ease;
}

.myButtons:hover {
    background: linear-gradient(to bottom, #3e8be0 5%, #5daeff 100%);
    box-shadow: 0 4px 10px rgba(0, 60, 150, 0.3);
    transform: translateY(-1px);
}

.myButtons:active {
    position: relative;
    top: 1px;
}


</style>
<script type="text/javascript">
	
	$(document).ready(function() {
		//document.getElementById("btnproject").disabled="true";
		$('#branchid').val(window.parent.branchid.value); 
	});
	
	
	  function getConfig() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					items = x.responseText;
					items = items.split('####');
					//alert(items[0])
					if (items[0]==1) 
					{
						$('#btncompanysetup').show();
						$('#btnbankdetails').show();
			       }
				} 
				else {
					$('#btncompanysetup').hide();
					$('#btnbankdetails').hide();
				}
				
				if(items[1]==0){
					$('#btnterminationsetup').hide();
				}
			}
			x.open("GET", "getConfig.jsp", true);
			x.send();
		}	



	</script> 
</head>
<body onload="getConfig()";>
<div id="mainBG" class="homeContent" data-type="background">
 


<div id="nav"> 
<br>
 
<table width="60%" id="ss">  
<tr><td align="center"><input type="button"   class="myButtons" value="GENERAL" style="width:180px;outline:none;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/hrsetupgeneral/hrsetupgeneralmaster.jsp";'></td></tr>

<tr><td align="center"><input type="button"   class="myButtons" value="DESIGNATION" style="width:180px;outline:none;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/designation.jsp";'></td></tr>
<tr><td align="center"><input type="button"   class="myButtons" value="DEPARTMENT" style="width:180px;outline:none;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/department.jsp";'></td></tr>
<tr><td align="center"><input type="button"   class="myButtons" value="PAYROLL CATEGORY" style="width:180px;outline:none;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/payrollcategory.jsp";'></td></tr>
<tr><td align="center"><input type="button"   class="myButtons" value="DOCUMENT" style="width:180px;outline:none;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/document.jsp";'></td></tr>
<tr><td align="center"><input type="button"  class="myButtons" value="LEAVE" style="width:180px;outline:none;"  onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/leave.jsp";'></td></tr>

<tr><td align="center"><input type="button"   class="myButtons" value="ALLOWANCES" style="width:180px;outline:none;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/allowances.jsp";'></td></tr>
<tr><td align="center"><input type="button"   class="myButtons" value="STATUTORY DEDUCTIONS" style="width:180px;outline:none;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/statutorydeductions.jsp";'></td></tr>
 <tr><td align="center"><input type="button"   class="myButtons" value="AGENT" style="width:180px;outline:none;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/agent.jsp";'></td></tr>
 <tr><td align="center"><input type="button"   class="myButtons" value="LEAVE SETUP" style="width:180px;outline:none;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/leavesetup/leavesetupmaster.jsp";'></td></tr>
<tr><td align="center"><input type="button"   class="myButtons" value="COMPANY SETUP" id="btncompanysetup" name="btncompanysetup" style="width:180px;outline:none;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/companysetup/companysetup.jsp";'></td></tr>
<tr><td align="center"><input type="button"   class="myButtons" value="BANK DETAILS" id="btnbankdetails" name="btnbankdetails" style="width:180px;outline:none;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/bankdetails/bankdetails.jsp";'></td></tr>
<tr><td align="center"><input type="button"   class="myButtons" value="TERMINATION SETUP" id="btnterminationsetup" name="btnterminationsetup" style="width:180px;outline:none;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/terminationsetup/terminationsetupmaster.jsp";'></td></tr>

</table>
</div>
<div id="comiframe">
	<iframe width="97%" height="100%" id="iframe2" align="right" frameborder="0" marginwidth="97%" scrolling="no" src="<%=contextPath%>/com/humanresource/setup/hrsetup/hrsetupgeneral/hrsetupgeneralmaster.jsp";></iframe>
</div>
<input type="hidden" id="formName" name="formName"  value='000'/>
<input type="hidden" id="formCode" name="formCode"  value='HRM'/>
<input type="hidden" id="branchid" name="branchid"  value=''/>


<input type="hidden" id="mode" name="mode"   />



</div>
</body>
</html>