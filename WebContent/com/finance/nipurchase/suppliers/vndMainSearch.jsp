<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" rel="stylesheet" />

<title>GatewayERP(i) - Vendor Search</title>

<style>

/* RESET inside popup */
.search-container * {
    box-sizing: border-box;
    font-family: Poppins, Arial, sans-serif;
}

/* OUTER CARD */
.search-container {
    background: #ffffff;
    border-radius: 18px;
    border: 1px solid #dce6ff;
    box-shadow: 0 10px 35px rgba(93,125,255,0.20);
    overflow: hidden;
    padding: 0;
    width: 100%;
}

/* HEADER */
.search-header {
    background: linear-gradient(90deg, #478dff, #67a8ff);
    padding: 20px 28px;
    color: #ffffff;
    font-size: 1.18rem;
    font-weight: 600;
    display: flex;
    justify-content: space-between;
    align-items: center;
}
.search-header small {
    font-size: 0.85rem;
    font-weight: 300;
    opacity: 0.95;
}

/* BODY */
.search-body {
    background: #fbfcff;
    padding: 22px 28px;
}

/* ROWS (3 equal columns per row) */
.search-row {
    display: flex;
    gap: 26px;
    margin-bottom: 24px;
    align-items: stretch;
}
.search-col {
    flex: 1;
    min-width: 0;
}
.search-col--btn {
    display: flex;
    align-items: flex-end;
    justify-content: flex-end;
}

/* LABELS */
.search-label {
    font-size: 0.90rem;
    font-weight: 600;
    color: #263b75;
    margin-bottom: 8px;
}

/* INPUTS */
.search-input {
    width: 100% !important;
    height: 34px !important;
    border-radius: 10px !important;
    border: 1px solid #c4d3ff !important;
    background: #ffffff !important;
    padding: 5px 10px !important;
    box-shadow: 0 2px 6px rgba(150,175,255,0.20) !important;
}

/* Search button (preserve class=myButton) */
.search-container input.myButton {
    background: linear-gradient(90deg,#6fb1fc,#1a73e8);
    color: #ffffff;
    border: none;
    height: 46px;
    padding: 0 38px;
    border-radius: 12px;
    font-size: 1rem;
    font-weight: 600;
    cursor: pointer;
    box-shadow: 0 6px 18px rgba(26,115,232,0.30);
}
.search-container input.myButton:hover {
    transform: translateY(-2px);
}

/* GRID AREA */
.search-grid-area {
    padding: 24px 28px 30px;
    background: #f4f7ff;
    border-top: 1px solid #e3eaff;
}

/* Fix: ensure refreshdiv visible and sized so jqxGrid can render */
#refreshdiv {
    width: 100%;
    display: block !important;
    overflow: visible !important;
}

/* mobile fallback */
@media (max-width: 900px) {
    .search-row {
        flex-direction: column;
        gap: 18px;
    }
    .search-col--btn {
        justify-content: stretch;
    }
    .search-container input.myButton {
        width: 100%;
    }
}

</style>

<script type="text/javascript">
$(document).ready(function () {
    /* nothing to init here by default */
});

function loadSearch() {
    var vndname   = document.getElementById("txtvendorsname").value;
    var vndaccno  = document.getElementById("txtaccountno").value;
    var vndmob    = document.getElementById("txtmobile").value;
    var vndtel    = document.getElementById("txttelephone").value;

    getdata(vndname, vndaccno, vndmob, vndtel);
}

function getdata(vndname, vndaccno, vndmob, vndtel){
    $("#refreshdiv").load(
        "vndMainSearchGrid.jsp?vndname=" + encodeURIComponent(vndname) +
        "&vndaccno=" + encodeURIComponent(vndaccno) +
        "&vndmob=" + encodeURIComponent(vndmob) +
        "&vndtel=" + encodeURIComponent(vndtel)
    );
}
</script>
</head>
<body>

<div class="search-container">

    <div class="search-header">
        Vendor Search
        <small>Search by Name, A/C No, Mobile & Telephone</small>
    </div>

    <div class="search-body">

        <!-- ROW 1: Name | A/C No | Search Button -->
        <div class="search-row">
            <div class="search-col">
                <label class="search-label">Name</label>
                <input type="text" name="txtvendorsname" id="txtvendorsname" class="search-input"
                       value='<s:property value="txtvendorsname"/>' />
            </div>

            <div class="search-col">
                <label class="search-label">A/C No.</label>
                <input type="text" name="txtaccountno" id="txtaccountno" class="search-input"
                       value='<s:property value="txtaccountno"/>' />
            </div>

            <div class="search-col search-col--btn">
                <input type="button" name="btnsearch" id="btnsearch" class="myButton"
                       value="Search" onclick="loadSearch();" />
            </div>
        </div>

        <!-- ROW 2: Mobile | Telephone | (empty to keep 3-col alignment) -->
        <div class="search-row">
            <div class="search-col">
                <label class="search-label">Mob No.</label>
                <input type="text" name="txtmobile" id="txtmobile" class="search-input"
                       value='<s:property value="txtmobile"/>' />
            </div>

            <div class="search-col">
                <label class="search-label">Tel No.</label>
                <input type="text" name="txttelephone" id="txttelephone" class="search-input"
                       value='<s:property value="txttelephone"/>' />
            </div>

            <div class="search-col">
                <!-- intentionally left blank to keep columns equal -->
            </div>
        </div>

    </div>

    <!-- GRID AREA -->
    <div class="search-grid-area">
        <div id="refreshdiv">
            <jsp:include page="vndMainSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>
