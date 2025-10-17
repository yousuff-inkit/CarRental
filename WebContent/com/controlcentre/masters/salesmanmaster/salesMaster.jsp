<% String contextPath=request.getContextPath();%>
<!DOCTYPE>
<html>
<head>

<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="../../../../css/main.css" rel="stylesheet" type="text/css" />
<link href="../../../../css/body.css" media="screen" rel="stylesheet" type="text/css" />
<link href="../../../../css/myButton.css" rel="stylesheet" type="text/css"/>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            font-size: 18px;
            background: #f7f9fc;
            color: #222;
            margin: 0;
            padding: 0;
        }

        #nav table {
            background: #fff;
            border-radius: 8px;
        }

        #nav table td {
            padding: 0 12px;
        }

        input[type="button"].myButton {
            font-size: 1rem; /* Reduced from 1.2rem */
            padding: 10px 20px; /* Adjusted padding */
            border-radius: 8px;
            border: none;
            background: #4a90e2;
            color: #fff;
            font-weight: 500;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            margin-right: 10px;
            outline: none;
            transition: background 0.2s;
            white-space: nowrap; /* 👈 Prevents text from breaking */
            overflow: hidden; /* 👈 Avoids overflow */
            text-overflow: ellipsis; /* 👈 Optional: adds "..." if still too long */
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
    </style>


    <script type="text/javascript">
	
	$(document).ready(function() {
		//document.getElementById("btnproject").disabled="true";
		$('#branchid').val(window.parent.branchid.value); 
	});
	</script>
</head>
<body>
<div id="mainBG" class="homeContent" data-type="background">
<h3>Salesman Master</h3>


<div id="nav">
<table >
<tr><td><input type="button" name="btnsalesman" class="myButton" value="Salesman" style="width:120px;outline:none;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/salesmanmaster/salesManMaster.jsp";'></td>
    <td><input type="button" name="btnsalesagent" class="myButton" value="Sales Agent" style="width:120px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/salesmanmaster/salesAgent.jsp";'></td>
    <td><input type="button" name="btnrentalagent" class="myButton" value="Rental Agent" style="width:120px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/salesmanmaster/rentalAgent.jsp";'></td>
    <td><input type="button" name="btndriver" class="myButton" value="Driver" style="width:120px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/salesmanmaster/driver.jsp";'></td>
    <td><input type="button" name="btncheckin" class="myButton" value="Check In" style="width:120px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/salesmanmaster/checkin.jsp";'></td>
    <td><input type="button" name="btnstaff" class="myButton" value="Staff" style="width:120px;" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/salesmanmaster/staff.jsp";'></td>
</tr>

</table>
</div>
<input type="hidden" id="formName" name="formName"  value='000'/>
<input type="hidden" id="formCode" name="formCode"  value='SAP'/> 
<input type="hidden" id="branchid" name="branchid"  value=''/>
<input type="hidden" id="mode" name="mode"  />
<div id="comiframe">
	<iframe width="100%" height="100%" id="iframe2" align="right" frameborder="0" marginwidth="100%" scrolling="no" src="<%=contextPath%>/com/controlcentre/masters/salesmanmaster/salesManMaster.jsp"></iframe>
</div>
<!-- <script>
function resizeIframeToFitContent(iframe) {
    // This function resizes an IFrame object
    // to fit its content.
    // The IFrame tag must have a unique ID attribute.
    iframe.height = document.frames[iframe.iframe2]
                    .document.body.scrollHeight;
}
</script> -->

</div>
</body>
</html>