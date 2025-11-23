<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" rel="stylesheet" />

<title>GatewayERP(i)</title>

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
    box-shadow: 0px 10px 35px rgba(93,125,255,0.20);
    overflow: hidden;
    padding: 0;
    width: 100%;
}

/* HEADER */
.search-header {
    background: linear-gradient(90deg, #478dff, #67a8ff);
    padding: 20px 28px;
    color: #ffffff;
    font-size: 1.2rem;
    font-weight: 600;
    display: flex;
    justify-content: space-between;
    align-items: center;
}
.search-header small {
    font-size: 0.85rem;
    opacity: 0.95;
}

/* BODY */
.search-body {
    background: #fbfcff;
    padding: 24px 28px;
}

/* FLEX ROW (master UI spacing) */
.search-row {
    display: flex;
    gap: 26px;
    margin-bottom: 24px;
}

/* FLEX COLUMN */
.search-col {
    flex: 1;
    min-width: 0;
}
.search-col-btn {
    display: flex;
    align-items: flex-end;
}

/* LABELS */
.search-label {
    font-size: 0.90rem;
    font-weight: 600;
    color: #263b75;
    margin-bottom: 8px;
}

/* MASTER UI INPUTS */
.search-input {
    width: 100%;
    height: 42px;
    border-radius: 12px;
    border: 1px solid #c8d9ff;
    background: #ffffff;
    padding: 0px 14px;
    font-size: 1rem;
    color: #052a6b;
    box-shadow: 0px 3px 6px rgba(180,200,255,0.35);
}

/* DATE BOX */
#debitdate {
    width: 100%;
    height: 42px;
    border-radius: 12px;
    border: 1px solid #c8d9ff;
    box-shadow: 0px 3px 6px rgba(180,200,255,0.35);
}

/* SEARCH BUTTON (keep your myButton class as-is) */
.search-container input.myButton {
    background: linear-gradient(90deg, #6fb1fc, #1a73e8);
    color: #ffffff;
    border: none;
    height: 46px;
    padding: 0px 38px;
    border-radius: 12px;
    font-size: 1rem;
    font-weight: 600;
    cursor: pointer;
    box-shadow: 0px 6px 18px rgba(26,115,232,0.30);
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

/* Mobile fallback */
@media (max-width: 900px) {
    .search-row {
        flex-direction: column;
        gap: 18px;
    }
    .search-col-btn input {
        width: 100%;
    }
}
</style>

<script>
$(document).ready(function () {
    $("#debitdate").jqxDateTimeInput({
        width: "100%",
        height: "42px",
        formatString: "dd.MM.yyyy",
        value: null
    });
});

function loadSearch() {
    var docNo = document.getElementById("txtdocumentno").value;
    var date  = document.getElementById("debitdate").value;
    var accId = document.getElementById("txtaccountid").value;
    var accName = document.getElementById("txtaccountname").value;
    var amounts = document.getElementById("txtamounts").value;
    var amount = (amounts * -1);
    var description = document.getElementById("txtdescriptions").value;
    var check = 1;

    $("#refreshdiv").load(
        "dnoMainSearchGrid.jsp?docNo=" + docNo +
        "&date=" + date +
        "&accId=" + accId +
        "&accName=" + accName.replace(/ /g,"%20") +
        "&amount=" + amount +
        "&description=" + description.replace(/ /g,"%20") +
        "&check=" + check
    );
}
</script>

</head>

<body>

<div class="search-container">

    <!-- HEADER -->
    <div class="search-header">
        Document Search
        <small>Search by Date, Doc No, A/C No, Name and Amount</small>
    </div>

    <!-- BODY -->
    <div class="search-body">

        <!-- ROW 1 -->
        <div class="search-row">

            <div class="search-col">
                <label class="search-label">Doc No</label>
                <input type="text" id="txtdocumentno" class="search-input"
                       value='<s:property value="txtdocumentno"/>' />
            </div>

            <div class="search-col">
                <label class="search-label">Date</label>
                <div id="debitdate"></div>
                <input type="hidden" id="hiddebitdate" />
            </div>

            <div class="search-col">
                <label class="search-label">A/C No.</label>
                <input type="text" id="txtaccountid" class="search-input"
                       value='<s:property value="txtaccountid"/>' />
            </div>

            <div class="search-col search-col-btn">
                <input type="button" id="btnsearch" class="myButton"
                       value="Search" onclick="loadSearch();">
            </div>

        </div>

        <!-- ROW 2 -->
        <div class="search-row">

            <div class="search-col">
                <label class="search-label">A/C Name</label>
                <input type="text" id="txtaccountname" class="search-input"
                       value='<s:property value="txtaccountname"/>' />
            </div>

            <div class="search-col">
                <label class="search-label">Amount</label>
                <input type="text" id="txtamounts" class="search-input"
                       value='<s:property value="txtamounts"/>' />
            </div>

            <div class="search-col">
                <label class="search-label">Description</label>
                <input type="text" id="txtdescriptions" class="search-input"
                       value='<s:property value="txtdescriptions"/>' />
            </div>

        </div>

    </div>

    <!-- GRID AREA -->
    <div class="search-grid-area">
        <div id="refreshdiv">
            <jsp:include page="dnoMainSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>
