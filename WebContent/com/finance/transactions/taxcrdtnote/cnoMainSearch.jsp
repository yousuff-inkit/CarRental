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
    font-family: Poppins, Arial, sans-serif !important;
}

/* OUTER CARD - MASTER UI */
.search-container {
    background: #ffffff !important;
    border-radius: 18px !important;
    border: 1px solid #dce6ff !important;
    box-shadow: 0px 10px 35px rgba(93,125,255,0.20) !important;
    overflow: hidden !important;
    padding: 0 !important;
}

/* HEADER - MASTER UI */
.search-header {
    background: linear-gradient(90deg, #478dff, #67a8ff) !important;
    padding: 16px 24px !important;
    color: #ffffff !important;
    font-size: 1.15rem !important;
    font-weight: 600 !important;
    display: flex !important;
    align-items: center !important;
    justify-content: space-between !important;
}
.search-header small {
    font-size: 0.80rem !important;
    opacity: 0.90 !important;
}

/* BODY */
.search-body {
    padding: 22px 26px 14px !important;
    background: #fbfcff !important;
}

/* GRID AREA */
.search-grid-area {
    padding: 20px 26px 24px !important;
    background: #f4f7ff !important;
    border-top: 1px solid #e3eaff !important;
}

/* LABEL (MASTER UI FONT + SPACING) */
.search-label {
    font-size: 0.90rem !important;
    font-weight: 600 !important;
    color: #263b75 !important;
    margin-bottom: 6px !important;
    display: block !important;
}

/* INPUT FIELD  EXACT MASTER UI STYLING */
.search-input {
    width: 100% !important;
    height: 44px !important;
    border-radius: 10px !important;
    border: 1px solid #c4d3ff !important;
    background: #ffffff !important;
    padding: 8px 14px !important;
    font-size: 1.05rem !important;
    color: #052a6b !important;
    box-shadow: 0px 3px 6px rgba(150,175,255,0.30) !important;
}

/* Remove pink autofill */
.search-input:-webkit-autofill {
    -webkit-box-shadow: 0 0 0 1000px #ffffff inset !important;
    box-shadow: 0 0 0 1000px #ffffff inset !important;
}

/* Input focus */
.search-input:focus {
    border-color: #6a96ff !important;
    outline: none !important;
}

/* SEARCH BUTTON  MASTER UI */
.search-btn {
    background: linear-gradient(90deg, #6fb1fc, #1a73e8) !important;
    height: 50px !important;
    color: #ffffff !important;
    border: none !important;
    padding: 0 42px !important;
    border-radius: 12px !important;
    font-size: 1.08rem !important;
    font-weight: 600 !important;
    cursor: pointer !important;
    box-shadow: 0px 6px 16px rgba(26,115,232,0.30) !important;
}
.search-btn:hover {
    transform: translateY(-2px) !important;
}

/* ROW / COLUMN  MASTER SPACING */
.row {
    display: flex !important;
    gap: 22px !important;
    margin-bottom: 18px !important;
}
.col {
    flex: 1 !important;
}
.btn-col {
    display: flex !important;
    align-items: flex-end !important;
}
/* ---- FIX JQX DATE INPUT SIZE FOR THIS PAGE (#creditdate) ---- */

/* Outer container */
#creditdate,
#creditdate .jqx-widget-content,
#creditdate .jqx-widget,
#creditdate .jqx-rc-all {
    width: 100% !important;
    height: 48px !important;                 /* Increase height */
    border-radius: 12px !important;
    border: 1px solid #c4d3ff !important;
    background: #ffffff !important;
    box-shadow: 0 3px 6px rgba(170,190,255,0.35) !important;
}

/* Input box inside jqx datetime */
#creditdate input.jqx-input-content {
    height: 48px !important;
    line-height: 48px !important;
    font-size: 1.15rem !important;
    font-weight: 500 !important;
    color: #052a6b !important;
    padding-left: 12px !important;
    background: #ffffff !important;
}

/* Remove pink autofill */
#creditdate input.jqx-input-content:-webkit-autofill {
    -webkit-box-shadow: 0 0 0 1000px #ffffff inset !important;
}

/* Calendar dropdown button */
#creditdate .jqx-input-button-content,
#creditdate .jqx-input-button {
    width: 42px !important;
    height: 48px !important;
    border-radius: 0 12px 12px 0 !important;
    background: #e7eeff !important;
}

/* Icon inside the calendar button */
#creditdate .jqx-icon-calendar,
#creditdate .jqx-icon-calendar-hover {
    margin-top: 6px !important;
    width: 24px !important;
    height: 24px !important;
}

</style>


<script type="text/javascript">

$(document).ready(function () {
     $("#creditdate").jqxDateTimeInput({
         width: "100%",
         height: 48,
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
