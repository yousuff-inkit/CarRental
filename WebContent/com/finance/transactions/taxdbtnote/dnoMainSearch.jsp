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
    font-family: Poppins, Arial, sans-serif !important;
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

/* FLEX ROW */
.search-row {
    display: flex;
    gap: 26px;
    margin-bottom: 24px;
}

/* FLEX COLUMN */
.search-col {
    flex: 1;
}
.search-col-btn {
    display: flex;
    align-items: flex-end;
}

/* LABELS */
.search-label {
    font-size: 0.95rem;
    font-weight: 600;
    color: #263b75;
    margin-bottom: 8px;
}

/* INPUTS  larger, cleaner, modern */
.search-input {
    width: 100%;
    height: 48px;                       /* bigger */
    border-radius: 12px;
    border: 1px solid #c8d9ff;
    background: #ffffff !important;
    padding: 0px 16px;
    font-size: 1.18rem !important;      /* bigger text */
    font-weight: 500;
    color: #052a6b !important;
    box-shadow: 0px 3px 7px rgba(180,200,255,0.35);
}

/* Bigger placeholder text */
.search-input::placeholder {
    font-size: 1.18rem !important;
    opacity: 0.65;
}

/* REMOVE PINK AUTOFILL */
.search-input:-webkit-autofill {
    box-shadow: 0 0 0 1000px #ffffff inset !important;
    -webkit-box-shadow: 0 0 0 1000px #ffffff inset !important;
}

/* DATE BOX outer container */
#debitdate {
    width: 100% !important;
    height: 48px !important;           /* match textbox */
    border-radius: 12px !important;
    border: 1px solid #c8d9ff !important;
    background: #ffffff !important;
    box-shadow: 0px 3px 7px rgba(180,200,255,0.35) !important;
    display: flex;
    align-items: center;
}

/* JQX INPUT TEXT */
.jqx-input-content {
    height: 48px !important;
    line-height: 48px !important;
    font-size: 1.18rem !important;     /* bigger */
    font-weight: 500 !important;
    color: #052a6b !important;
    background: #ffffff !important;
}

/* Remove pink autofill in jqx date input */
.jqx-input-content:-webkit-autofill {
    -webkit-box-shadow: 0 0 0 1000px #ffffff inset !important;
}

/* SEARCH BUTTON  bigger, bold */
.search-container input.myButton {
    background: linear-gradient(90deg, #6fb1fc, #1a73e8);
    color: #ffffff;
    border: none;
    height: 52px !important;           /* bigger */
    padding: 0px 48px !important;       /* bigger */
    border-radius: 12px;
    font-size: 1.15rem !important;     /* bigger text */
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

/* Mobile */
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
