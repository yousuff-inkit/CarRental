<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
   SCOPED UI: Master Layout for Sidebar & Iframe
========================================================= */
html, body {
    margin: 0;
    padding: 0;
    height: 100%;
    overflow: hidden; /* Prevents double scrollbars */
    background-color: #f4f6f9;
    font-family: Arial, sans-serif;
}

.modern-layout {
    display: flex;
    flex-direction: column;
    height: 100%;
    width: 100%;
}

/* Top Header Bar */
.layout-header {
    padding: 12px 20px;
    background-color: #ffffff;
    border-bottom: 1px solid #e1e4e8;
    box-shadow: 0 1px 3px rgba(0,0,0,0.05);
    z-index: 10;
}

.layout-header h3 {
    margin: 0;
    font-size: 16px;
    color: #0056b3;
    font-weight: bold;
}

/* Main Body Split */
.layout-body {
    display: flex;
    flex: 1;
    overflow: hidden;
}

/* Left Sidebar Navigation */
.layout-sidebar {
    width: 140px;
    background-color: #ffffff;
    border-right: 1px solid #e1e4e8;
    padding: 20px 15px;
    display: flex;
    flex-direction: column;
    gap: 12px; /* Perfect spacing between buttons */
    box-shadow: 1px 0 3px rgba(0,0,0,0.02);
    z-index: 5;
}

/* Modern Sidebar Buttons */
.sidebar-btn {
    font-weight: bold;
    font-size: 12px;
    height: 32px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    width: 100%;
    text-align: center;
    box-shadow: 0 1px 2px rgba(59, 130, 246, 0.3);
    transition: all 0.2s ease;
}

.sidebar-btn:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%);
    transform: translateY(-1px);
    box-shadow: 0 2px 4px rgba(59, 130, 246, 0.4);
}

.sidebar-btn:active {
    transform: translateY(0);
}

/* Iframe Container */
.layout-content {
    flex: 1;
    background-color: #f4f6f9;
    position: relative;
}

.layout-content iframe {
    width: 100%;
    height: 100%;
    border: none;
    display: block;
}
</style>

<script type="text/javascript">
    $(document).ready(function() {
        if(window.parent && window.parent.branchid) {
            $('#branchid').val(window.parent.branchid.value); 
        }
    });

    // Helper function to handle button clicks and iframe loading
    function loadModule(moduleUrl) {
        document.getElementById("iframe3").src = moduleUrl;
    }
</script>

</head>
<body>

<div class="modern-layout">
    
    <div class="layout-header">
        <h3>Maintenance Master</h3>
    </div>

    <div class="layout-body">
        
        <div class="layout-sidebar">
            <button class="sidebar-btn" onclick="loadModule('<%=contextPath%>/com/controlcentre/masters/maintenancemaster/garage.jsp')">Garage</button>
            <button class="sidebar-btn" onclick="loadModule('<%=contextPath%>/com/controlcentre/masters/maintenancemaster/damage.jsp')">Damage</button>
            <button class="sidebar-btn" onclick="loadModule('<%=contextPath%>/com/controlcentre/masters/maintenancemaster/maintenance.jsp')">Maintenance</button>
            <button class="sidebar-btn" onclick="loadModule('<%=contextPath%>/com/controlcentre/masters/maintenancemaster/complaintmaster.jsp')">Complaint</button>
            
            <input type="hidden" id="formName" name="formName" value='000'/>
            <input type="hidden" id="formCode" name="formCode" value='MNT'/>
            <input type="hidden" id="branchid" name="branchid" value=''/>
            <input type="hidden" id="mode" name="mode" />
        </div>

        <div class="layout-content">
            <iframe id="iframe3" src="<%=contextPath%>/com/controlcentre/masters/maintenancemaster/maintenance.jsp"></iframe>
        </div>

    </div>

</div>

</body>
</html>