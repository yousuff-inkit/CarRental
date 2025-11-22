<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" rel="stylesheet" />

<title>GatewayERP(i) - Bank Reconciliation Search</title>

<style>

/* RESET energyblue and body.css interference */
.search-container * {
    box-sizing: border-box;
    font-family: 'Poppins', sans-serif !important;
}

/* OUTER CARD */
.search-container {
    background: #ffffff !important;
    border-radius: 18px !important;
    border: 1px solid #dce6ff !important;
    box-shadow: 0px 10px 35px rgba(93, 125, 255, 0.20) !important;
    overflow: hidden !important;
    padding: 0 !important;
}

/* HEADER BAR */
.search-header {
    background: linear-gradient(90deg, #478dff, #67a8ff) !important;
    padding: 14px 20px !important;
    color: white !important;
    font-size: 1.1rem !important;
    font-weight: 600 !important;
    letter-spacing: .3px !important;
    display: flex !important;
    align-items: center !important;
    justify-content: space-between !important;
}

.search-header small {
    font-size: 0.78rem !important;
    font-weight: 300 !important;
    opacity: 0.95 !important;
}

/* BODY */
.search-body {
    padding: 18px 22px 10px !important;
    background: #fbfcff !important;
}

/* GRID AREA */
.search-grid-area {
    padding: 15px 22px 20px !important;
    background: #f4f7ff !important;
    border-top: 1px solid #e3eaff !important;
}

/* LABELS */
.search-label {
    font-size: 0.82rem !important;
    font-weight: 600 !important;
    color: #263b75 !important;
    margin-bottom: 6px !important;
    display: block !important;
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

/* REMOVE PINK FOCUS */
.search-input:focus,
.search-input:-webkit-autofill {
    background-color: #ffffff !important;
    -webkit-box-shadow: 0 0 0 1000px white inset !important;
    box-shadow: 0 0 0 1000px white inset !important;
    border-color: #6a96ff !important;
}

/* JQX DATE INPUT FIX */
#reconciledate,
#creditdate {
    width: 100% !important;
    height: 34px !important;
    border-radius: 10px !important;
    border: 1px solid #c4d3ff !important;
}

#refreshdiv {
    width: 100%;
    height: 320px;           /* same as your jqxGrid height */
    overflow: visible !important;
}

.col-btn {
    display: flex !important;
    align-items: flex-end !important;
}


/* BUTTON */
.search-btn,
.search-container input.myButton {
    background: linear-gradient(90deg,#6fb1fc,#1a73e8) !important;
    height: 34px !important;
    color: white !important;
    border: none !important;
    padding: 0px 26px !important;
    border-radius: 10px !important;
    font-size: 0.9rem !important;
    font-weight: 600 !important;
    cursor: pointer !important;
    box-shadow: 0 4px 12px rgba(26,115,232,0.30) !important;
    transition: 0.2s !important;
}

.search-btn:hover,
.search-container input.myButton:hover {
    transform: translateY(-2px) !important;
}

/* FLEX */
.row, .search-row {
    display: flex !important;
    gap: 18px !important;
    margin-bottom: 14px !important;
}

.col, .search-col {
    flex: 1 !important;
}
/* Remove pink autofill inside jqx date input */
.jqx-input-content,
.jqx-fill-state-normal,
.jqx-fill-state-focus,
.jqx-fill-state-hover {
    background-color: #ffffff !important;
    box-shadow: none !important;
}

/* Remove inner input pink (Chrome autofill) */
input.jqx-input-content:-webkit-autofill {
    -webkit-box-shadow: 0 0 0 1000px #ffffff inset !important;
    box-shadow: 0 0 0 1000px #ffffff inset !important;
    background-color: #ffffff !important;
}

/* Increase input text size for cleaner modern look */
.search-input {
    font-size: 0.94rem !important;
}

/* Increase jqx date input text size */
.jqx-input-content {
    font-size: 0.94rem !important;
}

/* Increase text inside the outer jqx container */
#debitdate,
#creditdate {
    font-size: 0.94rem !important;
}
</style>


<script type="text/javascript">
$(document).ready(function () {
    $("#reconciledate").jqxDateTimeInput({
        width: "100%",
        height: "42px",
        formatString: "dd.MM.yyyy",
        value: null
    });
});

function loadSearch() {
    var account = document.getElementById("txtpartyname").value;
    var docNo = document.getElementById("txtdocumentno").value;
    var currency = document.getElementById("txtcurrency").value;
    var description = document.getElementById("txtdesc").value;
    var reconcileDt = document.getElementById("reconciledate").value;
    var check = 1;

    getdata(account, docNo, currency, description, reconcileDt, check);
}

function getdata(account, docNo, currency, description, reconcileDt, check) {
    $("#refreshdiv").load(
        "brcnMainSearchGrid.jsp?account=" + account +
        "&docNo=" + docNo +
        "&currency=" + currency +
        "&description=" + description.replace(/ /g, "%20") +
        "&reconcileDt=" + reconcileDt +
        "&check=" + check
    );
}
</script>

</head>
<body>

<div class="search-container">

    <div class="search-header">
        Document Search
        <small>Search by Account, Doc No, Currency, Description and Reconcile Date</small>
    </div>

    <div class="search-body">

        <!-- ROW 1: Account Name | Doc No | Search Button -->
        <div class="search-row">
            <div class="search-col">
                <label class="search-label">Account Name</label>
                <input type="text" id="txtpartyname" name="txtpartyname" class="search-input"
                       value='<s:property value="txtpartyname"/>' />
            </div>

            <div class="search-col">
                <label class="search-label">Doc No</label>
                <input type="text" id="txtdocumentno" name="txtdocumentno" class="search-input"
                       value='<s:property value="txtdocumentno"/>' />
            </div>

            <div class="search-col" style="display:flex; align-items:flex-end;">
                <input type="button" id="btnsearch" name="btnsearch" class="myButton"
                       value="Search" onclick="loadSearch();" />
            </div>
        </div>

        <!-- ROW 2: Currency | Description | Reconcile Date -->
        <div class="search-row">
            <div class="search-col">
                <label class="search-label">Currency</label>
                <input type="text" id="txtcurrency" name="txtcurrency" class="search-input"
                       value='<s:property value="txtcurrency"/>' />
            </div>

            <div class="search-col">
                <label class="search-label">Description</label>
                <input type="text" id="txtdesc" name="txtdesc" class="search-input"
                       value='<s:property value="txtdesc"/>' />
            </div>

            <div class="search-col">
                <label class="search-label">Reconcile Date</label>
                <div id="reconciledate"></div>
                <input type="hidden" id="hidreconciledate" name="hidreconciledate"
                       value='<s:property value="hidreconciledate"/>' />
            </div>
        </div>

    </div>

    <div class="search-grid-area">
        <div id="refreshdiv">
            <jsp:include page="brcnMainSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>
