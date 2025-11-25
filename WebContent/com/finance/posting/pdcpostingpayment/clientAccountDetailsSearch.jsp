<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<link href="<%=contextPath%>/css/body.css" rel="stylesheet" type="text/css" />

<style>

/* RESET */
.search-container * {
    box-sizing: border-box;
    font-family: Poppins, Arial, sans-serif !important;
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
    display: flex !important;
    align-items: center !important;
    justify-content: space-between !important;
}
.search-header small {
    font-size: 0.78rem !important;
    opacity: 0.95 !important;
}

/* BODY */
.search-body {
    padding: 18px 22px 12px !important;
    background: #fbfcff !important;
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
    background: white !important;
    box-shadow: 0 2px 6px rgba(150,175,255,0.20) !important;
    font-size: 0.94rem !important;
}

/* REMOVE PINK AUTOFILL */
.search-input:-webkit-autofill {
    -webkit-box-shadow: 0 0 0 1000px white inset !important;
}

/* BUTTON */
.search-btn {
    background: linear-gradient(90deg,#6fb1fc,#1a73e8) !important;
    height: 34px !important;
    color: white !important;
    border: none !important;
    padding: 0 26px !important;
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
.btn-col {
    display: flex !important;
    align-items: flex-end !important;
}

/* GRID AREA */
.search-grid-area {
    padding: 15px 22px 20px !important;
    background: #f4f7ff !important;
    border-top: 1px solid #e3eaff !important;
}

</style>

<script type="text/javascript">

$(document).ready(function () {
    document.getElementById("txtatypes").value = document.getElementById("cmbacctype").value;
});

function loadClientAccountSearch() {
    var clientaccountno = document.getElementById("accountsno").value;
    var clientaccountname = document.getElementById("accountsname").value;
    var clientmobile = document.getElementById("clientmobileno").value;
    var curr = document.getElementById("txtcurrencies").value;
    var accounttype = document.getElementById("txtatypes").value;
    var checked = 1;

    getClientAccountDetails(clientaccountno,clientaccountname,clientmobile,curr,accounttype,checked);
}

function getClientAccountDetails(clientaccountno,clientaccountname,clientmobile,curr,accounttype,checked){
    $("#refreshClientAccountDiv").load(
        "clientAccountDetailsSearchGrid.jsp?accountno="+clientaccountno+
        "&accountname="+clientaccountname.replace(/ /g,"%20")+
        "&mobile="+clientmobile+
        "&currency="+curr+
        "&atype="+accounttype+
        "&check="+checked
    );
}

</script>

<body>

<div class="search-container">

    <div class="search-header">
        Client Account Search
        <small>Search by Account Name, Number, Currency and Mobile</small>
    </div>

    <div class="search-body">

        <!-- ROW 1: Account Name + Account No -->
        <div class="row">
            <div class="col">
                <label class="search-label">Account Name</label>
                <input type="text" id="accountsname" name="accountsname"
                class="search-input"
                value='<s:property value="accountsname"/>' />
            </div>
            <div class="col">
                <label class="search-label">Account No</label>
                <input type="text" id="accountsno" name="accountsno"
                class="search-input"
                value='<s:property value="accountsno"/>' />
            </div>
        </div>

        <!-- ROW 2: Currency + Mobile + Search -->
        <div class="row">
            <div class="col">
                <label class="search-label">Currency</label>
                <input type="text" id="txtcurrencies" name="txtcurrencies"
                class="search-input"
                value='<s:property value="txtcurrencies"/>' />
            </div>

            <div class="col">
                <label class="search-label">Mobile</label>
                <input type="text" id="clientmobileno" name="clientmobileno"
                class="search-input"
                value='<s:property value="clientmobileno"/>' />
            </div>

            <div class="col btn-col">
                <button class="search-btn" onclick="loadClientAccountSearch()">Search</button>
            </div>
        </div>

        <!-- Hidden Fields -->
        <input type="hidden" id="txtatypes" name="txtatypes" value='<s:property value="txtatypes"/>' />
        <input type="hidden" id="txtdocumenttypes" name="txtdocumenttypes" value='<s:property value="txtdocumenttypes"/>' />
        <input type="hidden" id="txtcreditdebit" name="txtcreditdebit" value='<s:property value="txtcreditdebit"/>' />

    </div>

    <div class="search-grid-area">
        <div id="refreshClientAccountDiv">
            <jsp:include page="clientAccountDetailsSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>
