<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<style>

/* ==========================
      PREMIUM UI STYLING
=========================== */

/* RESET unwanted styles */
.search-container * {
    box-sizing: border-box;
    font-family: "Poppins", sans-serif !important;
}

/* OUTER CARD */
.search-container {
    background: #ffffff !important;
    border-radius: 18px !important;
    border: 1px solid #dce6ff !important;
    box-shadow: 0px 10px 35px rgba(93,125,255,0.20) !important;
    overflow: hidden;
}

/* HEADER BAR */
.search-header {
    background: linear-gradient(90deg, #478dff, #67a8ff);
    padding: 14px 20px;
    color: white;
    font-size: 1.12rem;
    font-weight: 600;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.search-header small {
    font-size: 0.78rem;
    font-weight: 300;
    opacity: 0.9;
}

/* BODY */
.search-body {
    padding: 20px 22px 10px;
    background: #fbfcff;
}

/* GRID SECTION */
.search-grid-area {
    padding: 15px 22px 20px;
    background: #f4f7ff;
    border-top: 1px solid #e3eaff;
}

/* LABEL */
.search-label {
    font-size: 0.82rem;
    font-weight: 600;
    color: #263b75;
    margin-bottom: 6px;
    display: block;
}

/* INPUT */
.search-input {
    width: 100%;
    height: 34px;
    border-radius: 10px;
    border: 1px solid #c4d3ff;
    background: #ffffff;
    padding: 5px 10px;
    box-shadow: 0 2px 6px rgba(150,175,255,0.20);
}

.search-input:focus {
    border-color: #6a96ff !important;
}

/* DATE FIELDS (jqx) */
.jqx-date {
    height: 34px !important;
    border-radius: 10px !important;
}

/* BUTTON */
.search-btn {
    background: linear-gradient(90deg,#6fb1fc,#1a73e8);
    height: 34px;
    border: none;
    color: #fff;
    padding: 0 26px;
    border-radius: 10px;
    font-size: 0.9rem;
    font-weight: 600;
    cursor: pointer;
    box-shadow: 0 4px 12px rgba(26,115,232,0.30);
    transition: 0.2s;
}

.search-btn:hover {
    transform: translateY(-2px);
}

/* FLEX ROWS */
.row {
    display: flex;
    gap: 18px;
    margin-bottom: 14px;
}

.col {
    flex: 1;
}

</style>


<script type="text/javascript">

$(document).ready(function () {
    $("#bankdate").jqxDateTimeInput({
        width: "100%",
        height: "30px",
        formatString:"dd.MM.yyyy",
        value: null
    });

    $("#chqdate").jqxDateTimeInput({
        width: "100%",
        height: "30px",
        formatString:"dd.MM.yyyy",
        value: null
    });
});


function loadSearch() {
    var partyname = document.getElementById("txtpartyname").value;
    var docNo = document.getElementById("txtdocno").value;
    var date = document.getElementById("bankdate").value;
    var amount = document.getElementById("txtamount").value;
    var chequeNo = document.getElementById("txtchqno").value;
    var chequeDt = document.getElementById("chqdate").value;
    var check = 1;

    $("#refreshdiv").load(
        "bpvMainSearchGrid.jsp?partyname=" + partyname.replace(/ /g, "%20")
        + "&docNo=" + docNo
        + "&date=" + date
        + "&amount=" + amount
        + "&chequeNo=" + chequeNo
        + "&chequeDt=" + chequeDt
        + "&check=" + check
    );
}

</script>

</head>

<body>

<div class="search-container">

    <!-- HEADER -->
    <div class="search-header">
        BPV Search
        <small>Search by Name, Doc No, Date, Amount, Cheque No & Cheque Date</small>
    </div>

    <!-- BODY -->
    <div class="search-body">

        <!-- ROW 1 -->
        <div class="row">
            <div class="col">
                <label class="search-label">Name</label>
                <input type="text" id="txtpartyname" class="search-input"
                value='<s:property value="txtpartyname"/>' >
            </div>

            <div class="col">
                <label class="search-label">Doc No</label>
                <input type="text" id="txtdocno" class="search-input"
                value='<s:property value="txtdocno"/>' >
            </div>

            <div class="col" style="display:flex; align-items:flex-end;">
                <button class="search-btn" onclick="loadSearch()">Search</button>
            </div>
        </div>

        <!-- ROW 2 -->
        <div class="row">
            <div class="col">
                <label class="search-label">Date</label>
                <div id="bankdate" class="jqx-date"></div>
            </div>

            <div class="col">
                <label class="search-label">Amount</label>
                <input type="text" id="txtamount" class="search-input"
                value='<s:property value="txtamount"/>' >
            </div>

            <div class="col">
                <label class="search-label">Cheque No</label>
                <input type="text" id="txtchqno" class="search-input"
                value='<s:property value="txtchqno"/>' >
            </div>

            <div class="col">
                <label class="search-label">Cheque Date</label>
                <div id="chqdate" class="jqx-date"></div>
            </div>
        </div>

    </div>

    <!-- GRID AREA -->
    <div class="search-grid-area">
        <div id="refreshdiv">
            <jsp:include page="bpvMainSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>
