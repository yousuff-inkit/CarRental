<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<link href="<%=contextPath%>/css/body.css" rel="stylesheet" type="text/css" />

<!-- 🔥 PREMIUM BLUE MINIMAL UI -->
<style>

/* OUTER CARD */
.search-container {
    background: #ffffff;
    border-radius: 16px;
    border: 1px solid #dce6ff;
    box-shadow: 0px 8px 25px rgba(93, 125, 255, 0.18);
    padding: 0;
    max-width: 900px;
    margin: 22px auto;
}

/* HEADER */
.search-header {
    background: linear-gradient(90deg, #4c8fff, #6aa3ff);
    padding: 14px 20px;
    color: white;
    font-size: 1.05rem;
    font-weight: 600;
}

/* BODY */
.search-body {
    padding: 28px 30px !important;
    background: #fbfcff;
}

/* ROWS */
.row {
    display: flex;
    gap: 32px !important;
    margin-bottom: 22px !important;
}

/* COLUMN */
.col {
    width: 220px !important;
    flex: 1;
}

/* LABEL */
.search-label {
    font-size: 0.78rem;
    font-weight: 600;
    color: #1f3365;
    margin-bottom: 8px !important;
}

/* INPUT BOX */
.search-input {
    width: 100%;
    height: 32px;
    border-radius: 8px;
    border: 1px solid #c4d3ff;
    padding: 5px 8px;
    background: #ffffff;
    font-size: 0.8rem;
    box-shadow: 0 2px 5px rgba(150,175,255,0.15);
}

.search-input:focus {
    border-color: #6a96ff;
    box-shadow: 0 0 0 2px rgba(105,150,255,0.30);
    outline: none;
}

/* DATE BOX */
#datess {
    width: 100% !important;
    height: 32px !important;
    border-radius: 8px !important;
    border: 1px solid #c4d3ff !important;
    background: #ffffff !important;
}

/* SEARCH BUTTON */
.search-btn {
    background: linear-gradient(90deg,#6fb1fc,#1a73e8);
    height: 32px;
    color: white;
    border: none;
    padding: 0px 24px;
    border-radius: 8px;
    font-size: 0.82rem;
    font-weight: 600;
    cursor: pointer;
    box-shadow: 0 3px 10px rgba(26,115,232,0.30);
    transition: .2s;
}

.search-btn:hover {
    transform: translateY(-2px);
}

/* GRID AREA */
.search-grid-area {
    background: #f4f7ff;
    padding: 12px 20px;
    border-top: 1px solid #e3eaff;
}

/* Remove Chrome Autofill Ugly Pink */
input.search-input:-webkit-autofill,
input.search-input:-webkit-autofill:focus {
    -webkit-box-shadow: 0 0 0 1000px #ffffff inset !important;
    box-shadow: 0 0 0 1000px #ffffff inset !important;
    -webkit-text-fill-color: #1f3365 !important;
}

</style>

<script type="text/javascript">

$(document).ready(function () {
    $("#datess").jqxDateTimeInput({
        width: '180px',
        height: '30px',
        formatString: "dd.MM.yyyy",
        value: null
    });
});

function loadSearchs() {

    var docnoss = document.getElementById("docnoss").value;
    var accountss = document.getElementById("accountss").value;
    var accnamesss = document.getElementById("accnamess").value;
    var datess = document.getElementById("datess").value;

    var accnamess = accnamesss.replace(/ /g,"%20");

    $("#refreshdivs").load(
        "Subsearch.jsp?docnoss=" + docnoss +
        "&accountss=" + accountss +
        "&accnamess=" + accnamess +
        "&datess=" + datess +
        "&aa=yes"
    );
}

</script>
</head>

<body>

<div class="search-container">

    <div class="search-header">Document Search</div>

    <div class="search-body">

        <!-- 🌟 ROW 1: Doc No + Account -->
        <div class="row">
            <div class="col">
                <label class="search-label">Doc No</label>
                <input type="text" id="docnoss" class="search-input"
                value='<s:property value="docnoss"/>' >
            </div>

            <div class="col">
                <label class="search-label">Account</label>
                <input type="text" id="accountss" class="search-input"
                value='<s:property value="accountss"/>' >
            </div>
        </div>

        <!-- 🌟 ROW 2: Account Name + Date + Search -->
        <div class="row">

            <div class="col">
                <label class="search-label">Account Name</label>
                <input type="text" id="accnamess" class="search-input"
                value='<s:property value="accnamess"/>' >
            </div>

            <div class="col">
                <label class="search-label">Date</label>
                <div id="datess"></div>
            </div>

            <div class="col" style="flex:0.5; display:flex; align-items:flex-end;">
                <button class="search-btn" onclick="loadSearchs()">Search</button>
            </div>

        </div>

    </div>

    <div class="search-grid-area">
        <div id="refreshdivs">
            <jsp:include page="Subsearch.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>
