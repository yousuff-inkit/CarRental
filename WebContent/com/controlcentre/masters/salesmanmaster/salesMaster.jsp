<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="../../../../css/main.css" rel="stylesheet" type="text/css" />
<link href="../../../../css/body.css" media="screen" rel="stylesheet" type="text/css" />

<style>
/* =========================================================
   SCOPED UI: Vertical Sidebar Layout (Matches HR Setup Image)
========================================================= */
body {
    font-family: 'Segoe UI', Arial, sans-serif;
    font-size: 14px;
    background: #f7f9fc;
    color: #222;
    margin: 0;
    padding: 0;
    height: 100vh;
    display: flex;
    flex-direction: column;
}

#mainBG {
    background: #fff;
    border-radius: 8px;
    padding: 20px;
    margin: 15px;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
    display: flex;
    flex-direction: row; /* Aligns Sidebar and Iframe side-by-side */
    gap: 25px;
    flex: 1;
}

/* Sidebar Navigation Styling */
#nav-sidebar {
    width: 220px;
    display: flex;
    flex-direction: column;
    gap: 10px;
    flex-shrink: 0;
}

#nav-sidebar h3 {
    margin-top: 0;
    margin-bottom: 20px;
    color: #1a2b3c;
    font-size: 18px;
    border-bottom: 2px solid #0056b3;
    padding-bottom: 8px;
}

/* Button Styling matching the image */
input[type="button"].myButton {
    width: 100%;
    font-size: 13px;
    font-weight: 700;
    padding: 12px 15px;
    border-radius: 4px;
    border: none;
    background: #1d4ed8; /* Solid flat blue matching the image */
    color: #fff;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    outline: none;
    cursor: pointer;
    transition: background 0.2s, transform 0.1s;
    text-transform: uppercase;
    text-align: center;
    white-space: normal;
    word-wrap: break-word;
}

input[type="button"].myButton:hover {
    background: #1e3a8a; /* Darker blue on hover */
    transform: translateY(-1px);
}

/* Active/Focused state to mimic selection */
input[type="button"].myButton:focus {
    background: #1e3a8a;
    box-shadow: inset 0 3px 5px rgba(0,0,0,0.2);
}

/* Content Area Styling */
#comiframe {
    flex: 1; /* Takes up all remaining width */
    border-left: 1px solid #e2e8f0;
    padding-left: 20px;
    display: flex;
    flex-direction: column;
    min-height: 600px;
}

iframe {
    width: 100%;
    height: 100%;
    border: none;
    flex: 1;
}

/* Hidden inputs logic */
.hidden-data {
    display: none;
}
</style>

<script type="text/javascript" src="../../../../js/jquery-1.11.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    if (window.parent && window.parent.branchid) {
        $('#branchid').val(window.parent.branchid.value); 
    }
});
</script>
</head>

<body>

<div id="mainBG" class="homeContent">
    
    <div id="nav-sidebar">
        <h3>Salesman Master</h3>
        <input type="button" name="btnsalesman" class="myButton" value="SALESMAN" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/salesmanmaster/salesManMaster.jsp";'>
        <input type="button" name="btnsalesagent" class="myButton" value="SALES AGENT" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/salesmanmaster/salesAgent.jsp";'>
        <input type="button" name="btnrentalagent" class="myButton" value="RENTAL AGENT" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/salesmanmaster/rentalAgent.jsp";'>
        <input type="button" name="btndriver" class="myButton" value="DRIVER" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/salesmanmaster/driver.jsp";'>
        <input type="button" name="btncheckin" class="myButton" value="CHECK IN" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/salesmanmaster/checkin.jsp";'>
        <input type="button" name="btnstaff" class="myButton" value="STAFF" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/controlcentre/masters/salesmanmaster/staff.jsp";'>
    </div>

    <div id="comiframe">
        <iframe id="iframe2" scrolling="auto" src="<%=contextPath%>/com/controlcentre/masters/salesmanmaster/salesManMaster.jsp"></iframe>
    </div>

    <div class="hidden-data">
        <input type="hidden" id="formName" name="formName" value='000'/>
        <input type="hidden" id="formCode" name="formCode" value='SAP'/> 
        <input type="hidden" id="branchid" name="branchid" value=''/>
        <input type="hidden" id="mode" name="mode" />
    </div>

</div>

</body>
</html>