<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/globalcss.css">

<style>
    /* --- GLOBAL LAYOUT --- */
    html, body {
        height: 100%;
        width: 100%;
        margin: 0;
        padding: 0;
        background-color: #f0f4f8;
        font-family: 'Segoe UI', 'Roboto', Helvetica, Arial, sans-serif;
        color: #334155;
        overflow: hidden; 
    }

    /* --- THIN BLUE SCROLLBAR (GLOBAL) --- */
    ::-webkit-scrollbar { width: 8px; height: 8px; }
    ::-webkit-scrollbar-track { background: #f1f1f1; }
    ::-webkit-scrollbar-thumb { background: #3b82f6; border-radius: 4px; border: 2px solid #f1f1f1; }
    ::-webkit-scrollbar-thumb:hover { background: #2563eb; }
    * { scrollbar-width: thin; scrollbar-color: #3b82f6 #f1f1f1; }

    /* --- MAIN LAYOUT (Vertical Stack) --- */
    #mainBG {
        display: flex;
        flex-direction: column; /* Nav on Top, Content Below */
        width: 100vw;           
        height: 100vh;          
        background-color: #f0f4f8;
        overflow: hidden;
    }

    /* --- TOP NAVIGATION BAR (Horizontal & Scrollable) --- */
    #nav {
        width: 100%;
        min-height: 50px;       
        background: linear-gradient(to right, #dbeafe, #eff6ff); 
        border-bottom: 1px solid #bfdbfe;
        padding: 8px 15px;
        display: flex;
        flex-direction: row;    /* Horizontal Alignment */
        align-items: center;    
        gap: 10px;              
        
        /* SCROLLBAR SETUP */
        overflow-x: auto;       /* Horizontal Scrollbar for buttons */
        overflow-y: hidden;     
        white-space: nowrap;    /* Prevents buttons from wrapping vertically */
        
        box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        z-index: 100;
        flex-shrink: 0;         
        box-sizing: border-box;
    }

    /* --- NAV HEADER TITLE --- */
    .nav-header {
        font-weight: 800;
        font-size: 1.2rem;
        color: #1e3a8a;
        margin-right: 20px;
        padding-right: 20px;
        border-right: 2px solid #bfdbfe;
        white-space: nowrap;
        position: sticky;       
        left: 0;
        background: inherit;    
    }

    /* --- HORIZONTAL BUTTON STYLING --- */
    .nav-btn {
        background-color: #ffffff;
        border: 1px solid #94a3b8;
        color: #1e3a8a;         
        font-size: 13px;
        font-weight: 600;
        padding: 6px 16px;      
        border-radius: 50px;    /* Pill Shape */
        cursor: pointer;
        transition: all 0.2s ease;
        outline: none;
        white-space: nowrap;    
        text-align: center;
        flex-shrink: 0;         /* Ensures buttons don't squish */
    }

    /* Button Hover - Blue */
    .nav-btn:hover {
        background-color: #3b82f6 !important; 
        border-color: #3b82f6 !important;
        color: white !important;
        transform: translateY(-1px);
        box-shadow: 0 3px 6px rgba(59, 130, 246, 0.3);
    }

    /* --- CONTENT AREA (Fills Full Width) --- */
    #comiframe {
        flex: 1;                /* Grow to fill remaining height */
        width: 100%;            /* Force Full Width */
        position: relative;
        background-color: #f0f4f8;
        padding: 0;             
        overflow: hidden;       /* Let inner iframe handle scrolling */
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
        $('#branchid').val(window.parent.branchid.value); 
    });
    
    function getConfig() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    items = x.responseText;
                    items = items.split('####');
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
<body onload="getConfig()">

<div id="mainBG">
    
    <div id="nav">
        <div class="nav-header">HR Setup</div>

        <input type="button" class="nav-btn" value="General" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/hrsetupgeneral/hrsetupgeneralmaster.jsp";'>
        <input type="button" class="nav-btn" value="Designation" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/designation.jsp";'>
        <input type="button" class="nav-btn" value="Department" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/department.jsp";'>
        <input type="button" class="nav-btn" value="Payroll Cat." onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/payrollcategory.jsp";'>
        <input type="button" class="nav-btn" value="Document" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/document.jsp";'>
        <input type="button" class="nav-btn" value="Leave" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/leave.jsp";'>
        <input type="button" class="nav-btn" value="Allowances" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/allowances.jsp";'>
        <input type="button" class="nav-btn" value="Statutory Ded." onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/statutorydeductions.jsp";'>
        <input type="button" class="nav-btn" value="Agent" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/agent.jsp";'>
        <input type="button" class="nav-btn" value="Leave Setup" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/leavesetup/leavesetupmaster.jsp";'>
        
        <input type="button" class="nav-btn" value="Co. Setup" id="btncompanysetup" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/companysetup/companysetup.jsp";'>
        <input type="button" class="nav-btn" value="Bank Details" id="btnbankdetails" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/bankdetails/bankdetails.jsp";'>
        <input type="button" class="nav-btn" value="Term. Setup" id="btnterminationsetup" onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/humanresource/setup/hrsetup/terminationsetup/terminationsetupmaster.jsp";'>
    </div>

    <div id="comiframe">
        <iframe id="iframe2" src="<%=contextPath%>/com/humanresource/setup/hrsetup/hrsetupgeneral/hrsetupgeneralmaster.jsp"></iframe>
    </div>

    <input type="hidden" id="formName" name="formName"  value='000'/>
    <input type="hidden" id="formCode" name="formCode"  value='HRM'/>
    <input type="hidden" id="branchid" name="branchid"  value=''/>
    <input type="hidden" id="mode" name="mode"   />

</div>

</body>
</html>