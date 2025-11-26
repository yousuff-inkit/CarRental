<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

<!-- ============================================= -->
<!--           PREMIUM RICH UI STYLING             -->
<!-- ============================================= -->
<style>

.search-container {
    background: #ffffff;
    border-radius: 18px;
    border: 1px solid #dce6ff;
    box-shadow: 0px 10px 35px rgba(93, 125, 255, 0.20);
    overflow: hidden;
    padding: 0;
}

/* HEADER */
.search-header {
    background: linear-gradient(90deg, #478dff, #67a8ff);
    padding: 14px 22px;
    color: white;
    font-size: 1.1rem;
    font-weight: 600;
    letter-spacing: .3px;
}

.search-header small {
    font-size: 0.78rem;
    font-weight: 300;
    opacity: 0.95;
}

/* BODY */
.search-body {
    padding: 20px 24px 10px;
    background: #fbfcff;
}

/* GRID AREA */
.search-grid-area {
    padding: 18px 22px;
    background: #f4f7ff;
    border-top: 1px solid #e3eaff;
}

/* LABELS */
.search-label {
    font-size: 0.85rem;
    font-weight: 600;
    color: #22386c;
    margin-bottom: 6px;
    display: block;
}

/* INPUTS */
.search-input {
    width: 90%;
    height: 34px;
    border-radius: 10px;
    border: 1px solid #c4d3ff;
    padding: 6px 10px;
    background: #ffffff;
    font-size: 0.95rem;
    color: black;
}

/* JQX DATE FIX */
#receiptdate {
    width: 100% !important;
    height: 34px !important;
    border-radius: 10px !important;
}

/* BUTTON */
.search-btn {
    background: linear-gradient(90deg,#6fb1fc,#1a73e8);
    height: 34px;
    color: white;
    border: none;
    padding: 0 25px;
    border-radius: 10px;
    font-size: .9rem;
    font-weight: 600;
    cursor: pointer;
    box-shadow: 0 4px 12px rgba(26,115,232,.30);
}
.search-btn:hover { transform: translateY(-2px); }

/* FLEX LAYOUT */
.row {
    display: flex;
    gap: 18px;
    margin-bottom: 18px;
}
.col { flex: 1; }

</style>

<!-- ============================================= -->
<!--                JAVASCRIPT LOGIC               -->
<!-- ============================================= -->

<script type="text/javascript">

$(document).ready(function () {
    $("#receiptdate").jqxDateTimeInput({
        width: '100%',
        height: '30px',
        formatString:"dd.MM.yyyy",
        value:null
    });
});

function loadSearch() {
    var partyname = document.getElementById("txtpartyname").value;
    var docNo     = document.getElementById("txtdocno").value;
    var date      = document.getElementById("receiptdate").value;
    var amount    = document.getElementById("txtamount").value;
    var check = 1;

    $("#refreshdiv").load(
        'crvMainSearchGrid.jsp?partyname=' + partyname.replace(/ /g,"%20")
        + '&docNo=' + docNo
        + '&date=' + date
        + '&amount=' + amount
        + '&check=' + check
    );
}

</script>

</head>

<body>

<div class="search-container">

    <!-- HEADER BAR -->
    <div class="search-header">
        Cash Receipt Voucher Search
        <small>Search by Date, Doc No, Name & Amount</small>
    </div>

    <!-- BODY -->
    <div class="search-body">

        <!-- Row 1 -->
        <div class="row">
            <div class="col">
                <label class="search-label">Date</label>
                <div id="receiptdate"></div>
                <input type="hidden" id="hidreceiptdate">
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

        <!-- Row 2 -->
        <div class="row">
            <div class="col">
                <label class="search-label">Name</label>
                <input type="text" id="txtpartyname" class="search-input"
                       value='<s:property value="txtpartyname"/>' >
            </div>

            <div class="col">
                <label class="search-label">Amount</label>
                <input type="text" id="txtamount" class="search-input"
                       value='<s:property value="txtamount"/>' >
            </div>
        </div>

    </div>

    <!-- GRID AREA -->
    <div class="search-grid-area">
        <div id="refreshdiv">
            <jsp:include page="crvMainSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>
