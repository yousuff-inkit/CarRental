<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/main.css" rel="stylesheet" type="text/css" />
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<link href="<%=contextPath%>/css/myButton.css" rel="stylesheet" type="text/css"/>
<jsp:include page="../../../includes.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/globalcss.css">

<style>
/* ========================================
     FIXED ASSET MASTER - PERFECT SPACING 
   ======================================== */

/* Perfect body background */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    margin: 0;
    padding: 25px;
    min-height: 100vh;
}

/* Main container - perfect centered box */
#mainBG {
    background: #ffffff;
    border-radius: 24px;
    box-shadow: 0 20px 60px rgba(74,144,226,0.2);
    padding: 35px;
    max-width: 1400px;
    margin: 0 auto;
}

/* BIG PREMIUM TITLE */
#mainBG h3 {
    font-size: 36px !important;
    font-weight: 800 !important;
    color: #2c3e50;
    margin: 0 0 35px 0;
    text-align: center;
    background: linear-gradient(135deg, #4a90e2, #357abd);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    letter-spacing: 1px;
}

/* PERFECT HORIZONTAL BUTTON LAYOUT - 40px SPACING */
#nav {
    background: rgba(255,255,255,0.95);
    backdrop-filter: blur(20px);
    border-radius: 20px;
    padding: 40px;
    box-shadow: 0 15px 50px rgba(74,144,226,0.25);
    margin: 0 auto 40px;
    display: flex !important;
    justify-content: center !important;
    align-items: center !important;
    gap: 40px !important;  /* INCREASED TO 40px spacing */
    flex-wrap: wrap;
    max-width: 550px;  /* Slightly wider for more space */
}

/* DESTROY TABLE LAYOUT - PURE FLEX */
#nav table, #nav tr, #nav td {
    display: contents !important;
    width: auto !important;
    padding: 0 !important;
    margin: 0 !important;
    border: none !important;
}

/* PREMIUM BLUE BUTTONS - 170x60px */
#nav input.myButton {
    width: 170px !important;
    height: 60px !important;
    border: none !important;
    border-radius: 16px !important;
    background: linear-gradient(145deg, #4a90e2 0%, #357abd 50%, #2c6395 100%) !important;
    color: white !important;
    font-size: 16px !important;
    font-weight: 700 !important;
    text-transform: uppercase !important;
    letter-spacing: 1px !important;
    cursor: pointer !important;
    transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94) !important;
    box-shadow: 
        0 12px 35px rgba(74,144,226,0.4),
        0 6px 18px rgba(0,0,0,0.15),
        inset 0 1px 0 rgba(255,255,255,0.3) !important;
    position: relative !important;
    overflow: hidden !important;
}

#nav input.myButton:hover {
    transform: translateY(-6px) scale(1.05) !important;
    box-shadow: 
        0 25px 50px rgba(74,144,226,0.5),
        0 12px 30px rgba(0,0,0,0.2),
        inset 0 1px 0 rgba(255,255,255,0.4) !important;
    background: linear-gradient(145deg, #357abd 0%, #2c6395 50%, #1f4a70 100%) !important;
}

#nav input.myButton:active {
    transform: translateY(-3px) scale(1.02) !important;
}

/* IFRAME CONTAINER - Perfect frame */
#comiframe {
    background: rgba(255,255,255,0.95);
    border-radius: 24px;
    box-shadow: 0 20px 70px rgba(0,0,0,0.2);
    overflow: hidden;
    height: 75vh;
    border: 1px solid rgba(255,255,255,0.3);
    margin-top: 25px;
}

#iframe2 {
    border-radius: 20px;
    box-shadow: inset 0 4px 20px rgba(0,0,0,0.1);
    width: 100% !important;
    height: 100% !important;
}

/* Hidden inputs clean */
input[type="hidden"] {
    display: none !important;
}

/* Responsive perfection */
@media (max-width: 768px) {
    #nav { 
        gap: 25px !important;  /* Reduced spacing on mobile */
        padding: 30px !important; 
        flex-direction: column !important;
    }
    #nav input.myButton { 
        width: 150px !important; 
        height: 55px !important; 
    }
    #mainBG h3 { font-size: 28px !important; }
    #comiframe { height: 65vh; }
}

@media (max-width: 480px) {
    body { padding: 15px; }
    #mainBG { padding: 25px; }
    #nav { gap: 20px !important; }
}
</style>

<script type="text/javascript">
$(document).ready(function() {
    $('#branchid').val(window.parent.branchid.value); 
});
</script>
</head>
<body>
<div id="mainBG" class="homeContent" data-type="background">
    <h3>Fixed Asset Master</h3>

    <!-- PERFECT HORIZONTAL BUTTONS WITH 40px SPACING -->
    <div id="nav">
        <input type="button" name="btnfgm" class="myButton" value="Group Master" 
               onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/fixedassets/masters/groupMaster.jsp";'>
        <input type="button" name="btnflm" class="myButton" value="Loc. Master" 
               onclick='document.getElementById("iframe2").src="<%=contextPath%>/com/fixedassets/masters/locationMaster.jsp";'>
    </div>

    <input type="hidden" id="formName" name="formName" value='000'/>
    <input type="hidden" id="formCode" name="formCode" value='SAP'/> 
    <input type="hidden" id="branchid" name="branchid" value=''/>
    <input type="hidden" id="mode" name="mode" />

    <!-- PERFECT IFRAME CONTAINER -->
    <div id="comiframe">
        <iframe width="100%" height="100%" id="iframe2" align="right" frameborder="0" 
                marginwidth="100%" scrolling="no" 
                src="<%=contextPath%>/com/fixedassets/masters/groupMaster.jsp"></iframe>
    </div>
</div>
</body>
</html>
