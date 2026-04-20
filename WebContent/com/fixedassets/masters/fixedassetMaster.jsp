<% String contextPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<title>GatewayERP(i)</title>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="<%=contextPath%>/css/main.css" rel="stylesheet" />
<link href="<%=contextPath%>/css/body.css" rel="stylesheet" />
<link href="<%=contextPath%>/css/myButton.css" rel="stylesheet" />

<jsp:include page="../../../includes.jsp"></jsp:include>

<style>
/* ---------------- RESET ---------------- */
html, body {
    height: 100%;
    margin: 0;
}

/* ---------------- PAGE LAYOUT ---------------- */
#whole {
    display: flex;
    height: 100vh;
    width: 100%;
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
}

/* ---------------- LEFT NAV ---------------- */
#nav {
    width: 130px;
    background-color: #E0ECF8;
    padding: 8px 5px;
    box-sizing: border-box;
    border-right: 1px solid #c9d9ee;
}

#nav table {
    width: 100%;
}

/* -------- BLUE PREMIUM BUTTONS -------- */
#nav input[type="button"] {
    width: 100%;
    margin-bottom: 12px;
    padding: 10px 0;
    background: linear-gradient(135deg, #4FA8FF, #2F7FD4);
    color: #ffffff;
    border: none;
    border-radius: 8px;
    font-size: 12px;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.25s ease;
    box-shadow: 0 4px 10px rgba(79,168,255,0.35);
}

/* Hover */
#nav input[type="button"]:hover {
    background: linear-gradient(135deg, #2F7FD4, #1F63B8);
    transform: translateY(-2px);
    box-shadow: 0 6px 14px rgba(47,127,212,0.45);
}

/* Active click */
#nav input[type="button"]:active {
    transform: translateY(0);
    box-shadow: 0 3px 6px rgba(47,127,212,0.35);
}

/* Active menu */
#nav input[type="button"].active {
    background: linear-gradient(135deg, #1F63B8, #154A8A);
    box-shadow: inset 0 0 0 2px rgba(255,255,255,0.35);
}

/* ---------------- RIGHT CONTENT ---------------- */
#content {
    flex: 1;
    display: flex;
    flex-direction: column;
}

/* ---------------- HEADER ---------------- */
#content h3 {
    margin: 14px 18px;
    padding-left: 10px;
    border-left: 4px solid #007bff;
    font-size: 16px;
    font-weight: 600;
    color: #253858;
}

/* ---------------- IFRAME AREA ---------------- */
#iframeWrapper {
    flex: 1;
    padding: 12px 18px;
    box-sizing: border-box;
}

#iframe2 {
    width: 100%;
    height: 100%;
    border: none;
    background: #ffffff;
    border-radius: 12px;
}
</style>

<script>
$(document).ready(function () {
    if (window.parent && window.parent.branchid) {
        $('#branchid').val(window.parent.branchid.value);
    }
});

/* Active button highlight */
function setActive(btn, url) {
    document.querySelectorAll('#nav input[type="button"]').forEach(b => {
        b.classList.remove('active');
    });
    btn.classList.add('active');
    document.getElementById("iframe2").src = url;
}
</script>

</head>

<body>

<div id="whole">

    <!-- LEFT MENU -->
    <div id="nav">
        <table>
            <tr>
                <td>
                    <input type="button"
                           class="active"
                           value="Group Master"
                           onclick="setActive(this,'<%=contextPath%>/com/fixedassets/masters/groupMaster.jsp');">
                </td>
            </tr>
            <tr>
                <td>
                    <input type="button"
                           value="Location Master"
                           onclick="setActive(this,'<%=contextPath%>/com/fixedassets/masters/locationMaster.jsp');">
                </td>
            </tr>
        </table>
    </div>

    <!-- RIGHT CONTENT -->
    <div id="content">

        <h3>Fixed Asset Master</h3>

        <!-- hidden fields -->
        <input type="hidden" id="formName" name="formName" value="000"/>
        <input type="hidden" id="formCode" name="formCode" value="SAP"/>
        <input type="hidden" id="branchid" name="branchid" value=""/>
        <input type="hidden" id="mode" name="mode"/>

        <div id="iframeWrapper">
            <iframe id="iframe2"
                    src="<%=contextPath%>/com/fixedassets/masters/groupMaster.jsp">
            </iframe>
        </div>

    </div>

</div>

</body>
</html>
