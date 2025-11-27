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
<link href="<%=contextPath%>/css/search-globalcss.css" rel="stylesheet" />

<style>
/* Increase size only for THIS popup's date control */
#debitdate {
    width: 100% !important;
    height: 48px !important;             /* match other input height */
    border-radius: 12px !important;
    border: 1px solid #c8d9ff !important;
    background: #ffffff !important;
    box-shadow: 0px 3px 6px rgba(180,200,255,0.35) !important;
}

/* Inner text inside THIS popup's date box */
#debitdate .jqx-input-content {
    height: 48px !important;
    line-height: 48px !important;
    font-size: 1.05rem !important;
    padding-left: 14px !important;
    color: #052a6b !important;
}

/* Calendar icon ONLY inside this date box */
#debitdate .jqx-DateTimeInput-button {
    height: 48px !important;
    width: 44px !important;
    border-radius: 0 12px 12px 0 !important;
    background: #ffffff !important;
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
