<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
    /* --- GLOBAL LAYOUT --- */
    html, body {
        height: 100%;
        margin: 0;
        padding: 0;
        background-color: #f0f4f8; /* Matches your other forms */
        font-family: 'Segoe UI', 'Roboto', Helvetica, Arial, sans-serif;
        color: #334155;
        overflow: hidden; /* Prevents double scrollbars */
    }

    /* Main Container using Flexbox for vertical stacking */
    #mainBG {
        display: flex;
        flex-direction: column;
        height: 100vh;
        width: 100%;
    }

    /* --- HEADER SECTION --- */
    #header {
        padding: 15px 20px 5px 20px;
        text-align: center; /* Centered title looks better for a menu */
    }

    #header h3 {
        color: #1e3a8a; /* Navy Blue */
        font-weight: 700;
        font-size: 1.8rem;
        margin: 0;
        letter-spacing: 0.5px;
    }

    /* --- NAVIGATION BAR --- */
    #nav {
        display: flex;
        justify-content: center; /* Centers buttons horizontally */
        align-items: center;
        padding: 15px 0;
        gap: 15px; /* Space between buttons */
        background: transparent;
    }

    /* --- PILL BUTTON STYLING --- */
    .nav-btn {
        background-color: #ffffff;
        border: 2px solid #94a3b8; /* Soft Blue-Grey Border */
        color: #1e3a8a; /* Navy Text */
        font-size: 15px; /* Matches your form labels */
        font-weight: 600;
        padding: 10px 30px;
        border-radius: 50px; /* Pill Shape */
        cursor: pointer;
        transition: all 0.3s ease;
        outline: none;
        box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        min-width: 120px; /* Ensures buttons are uniform width */
    }

    /* Hover Effect */
    .nav-btn:hover {
        background-color: #3b82f6; /* Bright Blue */
        border-color: #3b82f6;
        color: white;
        box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
        transform: translateY(-2px); /* Slight lift */
    }

    /* Active/Focus Effect */
    .nav-btn:active, .nav-btn:focus {
        background-color: #1e3a8a; /* Darker Blue on click */
        border-color: #1e3a8a;
        color: white;
    }

    /* --- IFRAME CONTAINER --- */
    #comiframe {
        flex-grow: 1; /* Takes up all remaining height */
        width: 100%;
        position: relative;
        background-color: #f0f4f8; 
    }

    iframe {
        width: 100%;
        height: 100%;
        border: none;
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
    
    <div id="header">
        <h3>Maintenance Master</h3>
    </div>

    <div id="nav">
        <input type="button" name="btngarage" class="nav-btn" value="Garage" 
               onclick='document.getElementById("iframe3").src="<%=contextPath%>/com/controlcentre/masters/maintenancemaster/garage.jsp";'>
        
        <input type="button" name="btndamage" class="nav-btn" value="Damage" 
               onclick='document.getElementById("iframe3").src="<%=contextPath%>/com/controlcentre/masters/maintenancemaster/damage.jsp";'>
        
        <input type="button" name="btnmain" class="nav-btn" value="Maintenance" 
               onclick='document.getElementById("iframe3").src="<%=contextPath%>/com/controlcentre/masters/maintenancemaster/maintenance.jsp";'>
        
        <input type="button" name="btncomplaint" class="nav-btn" value="Complaint" 
               onclick='document.getElementById("iframe3").src="<%=contextPath%>/com/controlcentre/masters/maintenancemaster/complaintmaster.jsp";'>
    </div>

    <input type="hidden" id="formName" name="formName"  value='000'/>
    <input type="hidden" id="formCode" name="formCode"  value='MNT'/>
    <input type="hidden" id="branchid" name="branchid"  value=''/>
    <input type="hidden" id="mode" name="mode"  />

    <div id="comiframe">
        <iframe id="iframe3" src="<%=contextPath%>/com/controlcentre/masters/maintenancemaster/maintenance.jsp"></iframe>
    </div>

</div>

</body>
</html>