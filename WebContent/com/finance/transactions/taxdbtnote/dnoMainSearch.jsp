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

/* RESET */
.search-container * {
    box-sizing: border-box;
    font-family: Poppins, sans-serif !important;
}

/* OUTER CARD */
.search-container {
    background: #ffffff !important;
    border-radius: 18px !important;
    border: 1px solid #dce6ff !important;
    box-shadow: 0px 10px 35px rgba(93,125,255,0.20) !important;
    overflow: hidden !important;
    padding: 0 !important;
}

/* HEADER */
.search-header {
    background: linear-gradient(90deg,#478dff,#67a8ff) !important;
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

/* LABEL */
.search-label {
    font-size: 0.82rem !important;
    font-weight: 600 !important;
    color: #263b75 !important;
    margin-bottom: 6px !important;
    display: block !important;
}

/* INPUT */
.search-input {
    width: 100% !important;
    height: 34px !important;
    border-radius: 10px !important;
    border: 1px solid #c4d3ff !important;
    padding: 5px 10px !important;
    background: #ffffff !important;
    box-shadow: 0 2px 6px rgba(150,175,255,0.20) !important;
}

/* FOCUS FIX */
.search-input:focus,
.search-input:-webkit-autofill {
    background-color: #ffffff !important;
    border-color: #6a96ff !important;
    -webkit-box-shadow: 0 0 0 1000px white inset !important;
    box-shadow: 0 0 0 1000px white inset !important;
}

/* DATE INPUT HEIGHT FIX */
#debitdate {
    width: 100% !important;
    height: 34px !important;
    border-radius: 10px !important;
    border: 1px solid #c4d3ff !important;
}

/* BUTTON */
.search-btn {
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
.search-btn:hover {
    transform: translateY(-2px) !important;
}

/* FLEX */
.row {
    display: flex !important;
    gap: 18px !important;
    margin-bottom: 14px !important;
}
.col {
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

<script>
$(document).ready(function () {
    $("#debitdate").jqxDateTimeInput({
        width: "100%",
        height: "30px",
        formatString: "dd.MM.yyyy",
        value: null
    });
});

function loadSearch() {
    var docNo = document.getElementById("txtdocumentno").value;
    var date = document.getElementById("debitdate").value;
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
        <div class="row">

            <div class="col">
                <label class="search-label">Doc No</label>
                <input type="text" id="txtdocumentno" class="search-input"
                value='<s:property value="txtdocumentno"/>' />
            </div>

            <div class="col">
                <label class="search-label">Date</label>
                <div id="debitdate"></div>
                <input type="hidden" id="hiddebitdate" />
            </div>

            <div class="col">
                <label class="search-label">A/C No.</label>
                <input type="text" id="txtaccountid" class="search-input"
                value='<s:property value="txtaccountid"/>' />
            </div>

            <div class="col" style="display:flex; align-items:flex-end;">
                <button class="search-btn" onclick="loadSearch()">Search</button>
            </div>

        </div>

        <!-- ROW 2 -->
        <div class="row">

            <div class="col">
                <label class="search-label">A/C Name</label>
                <input type="text" id="txtaccountname" class="search-input"
                value='<s:property value="txtaccountname"/>' />
            </div>

            <div class="col">
                <label class="search-label">Amount</label>
                <input type="text" id="txtamounts" class="search-input"
                value='<s:property value="txtamounts"/>' />
            </div>

            <div class="col">
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
