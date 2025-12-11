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
<style>
/* --- Master UI Styles (Revised Spacing) --- */
body {
    font-family: 'Segoe UI', Arial, sans-serif;
    font-size: 18px;
    background: #f7f9fc;
    color: #222;
    margin: 0;
    padding: 0;
}

#nav {
    /* Add padding below the navigation bar for separation */
    margin-bottom: 20px; 
}

#nav table {
    background: #fff;
    border-radius: 8px;
    /* Add slight margin/padding around the table */
    padding: 5px; 
}

#nav table td {
    /* Increase vertical padding to space out buttons rows */
    padding: 10px 12px; 
}

/* Applying the preferred myButton style to the new buttons */
input[type="button"].myButton {
    font-size: 1rem;
    padding: 10px 20px;
    border-radius: 8px;
    border: none;
    background: #4a90e2;
    color: #fff;
    font-weight: 500;
    box-shadow: 0 2px 8px rgba(0,0,0,0.08);
    /* Reduced margin-right to tighten up horizontal spacing */
    margin-right: 5px; 
    outline: none;
    transition: background 0.2s;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis; 
    /* Set a fixed width for visual consistency like the image */
    width: 150px; 
}


input[type="button"].myButton:hover {
    background: #357ab8;
}

input[type="text"], input[type="hidden"], select {
    background: #fff;
    font-size: 1.1rem;
    padding: 8px 12px;
    border: 1px solid #bcdffb;
    border-radius: 6px;
    margin-bottom: 8px;
    color: #222;
}

label {
    font-size: 1.1rem;
    font-weight: 500;
    color: #222;
    margin-bottom: 4px;
    display: block;
}
/* Remaining HR setup specific styles are implicitly removed/overwritten */

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
 
<body>
<div id="mainBG" class="homeContent" data-type="background">
<h3>HR Setup</h3> 


<div id="nav">
<table id="ss"> 
<tr>
<td><input type="button" class="myButton" value="GENERAL" style="outline:none;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/hrsetupgeneral/hrsetupgeneralmaster.jsp";'></td>
<td><input type="button" class="myButton" value="DESIGNATION" style="outline:none;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/designation.jsp";'></td>
<td><input type="button" class="myButton" value="DEPARTMENT" style="outline:none;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/department.jsp";'></td>
<td><input type="button" class="myButton" value="PAYROLL CATEGORY" style="outline:none;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/payrollcategory.jsp";'></td>
<td><input type="button" class="myButton" value="DOCUMENT" style="outline:none;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/document.jsp";'></td>
<td><input type="button" class="myButton" value="LEAVE" style="outline:none;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/leave.jsp";'></td>
</tr>
<tr>
<td><input type="button" class="myButton" value="ALLOWANCES" style="outline:none;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/allowances.jsp";'></td>
<td><input type="button" class="myButton" value="STATUTORY DEDUCTIONS" style="outline:none;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/statutorydeductions.jsp";'></td>
<td><input type="button" class="myButton" value="AGENT" style="outline:none;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/agent.jsp";'></td>
<td><input type="button" class="myButton" value="LEAVE SETUP" style="outline:none;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/leavesetup/leavesetupmaster.jsp";'></td>
<td><input type="button" class="myButton" value="COMPANY SETUP" id="btncompanysetup" name="btncompanysetup" style="outline:none;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/companysetup/companysetup.jsp";'></td>
<td><input type="button" class="myButton" value="BANK DETAILS" id="btnbankdetails" name="btnbankdetails" style="outline:none;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/bankdetails/bankdetails.jsp";'></td>
</tr>
<tr>
<td><input type="button" class="myButton" value="TERMINATION SETUP" id="btnterminationsetup" name="btnterminationsetup" style="outline:none;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/terminationsetup/terminationsetupmaster.jsp";'></td>
<td></td><td></td><td></td><td></td><td></td>
</tr>
</table>
</div>

<input type="hidden" id="formName" name="formName"  value='000'/>
<input type="hidden" id="formCode" name="formCode"  value='HRM'/>
<input type="hidden" id="branchid" name="branchid"  value=''/>
<input type="hidden" id="mode" name="mode"  />

<div id="comiframe">
	<iframe width="100%" height="100%" id="iframe2" align="right" frameborder="0" marginwidth="100%" scrolling="no" src="<%=contextPath%>/com/humanresource/setup/hrsetup/hrsetupgeneral/hrsetupgeneralmaster.jsp"></iframe>
</div>

</div>
</body>
</html>