<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="<%=contextPath%>/css/body.css" rel="stylesheet" />

<style>

/* RESET */
.search-container * {
    box-sizing: border-box;
    font-family: Poppins, Arial, sans-serif;
}

/* OUTER CARD */
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
    padding: 16px 22px;
    color: #ffffff;
    font-size: 1.2rem;
    font-weight: 600;
    display: flex;
    align-items: center;
    justify-content: space-between;
}
.search-header small {
    font-size: 0.80rem;
    font-weight: 300;
    opacity: 0.95;
}

/* BODY */
.search-body {
    padding: 20px 24px 12px;
    background: #fbfcff;
}

/* GRID AREA */
.search-grid-area {
    padding: 18px 24px 22px;
    background: #f4f7ff;
    border-top: 1px solid #e3eaff;
}

/* LABEL */
.search-label {
    font-size: 0.85rem;
    font-weight: 600;
    color: #263b75;
    margin-bottom: 6px;
    display: block;
}

/* INPUTS */
.search-input {
    width: 100%;
    height: 38px;
    border-radius: 10px;
    border: 1px solid #c4d3ff;
    background: #ffffff;
    padding: 6px 12px;
    box-shadow: 0 2px 6px rgba(150,175,255,0.20);
}
.search-input:focus {
    border-color: #6a96ff;
}

.search-btn {
    background: linear-gradient(90deg, #6fb1fc, #1a73e8) !important;
    height: 50px !important;
    color: #ffffff !important;
    border: none !important;
    padding: 0 42px !important;
    border-radius: 14px !important;
    font-size: 1.05rem !important;
    font-weight: 600 !important;
    cursor: pointer !important;
    box-shadow: 0 6px 18px rgba(26,115,232,0.32) !important;
}

.search-btn:hover {
    transform: translateY(-2px);
}

/* ROW COL */
.row {
    display: flex;
    gap: 20px;
    margin-bottom: 16px;
}
.col {
    flex: 1;
}
.btn-col {
    display: flex;
    align-items: flex-end;
}

</style>

<script type="text/javascript">

$(document).ready(function () {
     $("#creditdate").jqxDateTimeInput({
         width: "100%",
         height: "38px",
         formatString: "dd.MM.yyyy",
         value: null
     });
});

function loadSearch() {
    var docNo = document.getElementById("txtdocumentno").value;
    var date = document.getElementById("creditdate").value;
    var accId = document.getElementById("txtaccountid").value;
    var accName = document.getElementById("txtaccountname").value;
    var amount = document.getElementById("txtamounts").value;
    var description = document.getElementById("txtdescriptions").value;
    var check = 1;

    getdata(docNo, date, accId, accName, amount, description, check);
}

function getdata(docNo, date, accId, accName, amount, description, check) {
    $("#refreshdiv").load(
        "cnoMainSearchGrid.jsp?docNo=" + docNo +
        "&date=" + date +
        "&accId=" + accId +
        "&accName=" + accName.replace(/ /g, "%20") +
        "&amount=" + amount +
        "&description=" + description.replace(/ /g, "%20") +
        "&check=" + check
    );
}

</script>

</head>

<body>

<div class="search-container">

    <div class="search-header">
        Document Search
        <small>Search by Date, Doc No, A/C No, Name and Amount</small>
    </div>

    <div class="search-body">

        <div class="row">
            <div class="col">
                <label class="search-label">Doc No</label>
                <input type="text" id="txtdocumentno" class="search-input"
                value='<s:property value="txtdocumentno"/>'>
            </div>

            <div class="col">
                <label class="search-label">Date</label>
                <div id="creditdate"></div>
                <input type="hidden" id="hidcreditdate"
                value='<s:property value="hidcreditdate"/>'>
            </div>

            <div class="col">
                <label class="search-label">A/C No.</label>
                <input type="text" id="txtaccountid" class="search-input"
                value='<s:property value="txtaccountid"/>'>
            </div>

            <div class="col btn-col">
                <button class="search-btn" onclick="loadSearch()">Search</button>
            </div>
        </div>

        <div class="row">
            <div class="col">
                <label class="search-label">A/C Name</label>
                <input type="text" id="txtaccountname" class="search-input"
                value='<s:property value="txtaccountname"/>'>
            </div>

            <div class="col">
                <label class="search-label">Amount</label>
                <input type="text" id="txtamounts" class="search-input"
                value='<s:property value="txtamounts"/>'>
            </div>

            <div class="col">
                <label class="search-label">Description</label>
                <input type="text" id="txtdescriptions" class="search-input"
                value='<s:property value="txtdescriptions"/>'>
            </div>
        </div>

    </div>

    <div class="search-grid-area">
        <div id="refreshdiv">
            <jsp:include page="cnoMainSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>
