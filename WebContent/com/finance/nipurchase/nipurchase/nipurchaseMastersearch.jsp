<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

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
    font-weight: 300 !important;
    opacity: 0.95 !important;
}

/* BODY */
.search-body {
    padding: 18px 22px 10px !important;
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
    background: #ffffff !important;
    box-shadow: 0 2px 6px rgba(150,175,255,0.20) !important;
    font-size: 0.94rem !important;
}

/* REMOVE PINK AUTOFILL */
.search-input:-webkit-autofill {
    -webkit-box-shadow: 0 0 0 1000px #ffffff inset !important;
    box-shadow: 0 0 0 1000px #ffffff inset !important;
}

/* JQX DATE BOX */
#datess {
    width: 100% !important;
    height: 34px !important;
    border-radius: 10px !important;
    border: 1px solid #c4d3ff !important;
    font-size: 0.94rem !important;
}
.jqx-input-content {
    font-size: 0.94rem !important;
    background-color: #ffffff !important;
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
/* Improve dropdown (Type) text size and alignment */
.search-select {
    width: 100% !important;
    height: 34px !important;
    border-radius: 10px !important;
    border: 1px solid #c4d3ff !important;
    background: #ffffff !important;
    font-size: 0.94rem !important;     /* same as inputs */
    padding-left: 10px !important;
    box-shadow: 0 2px 6px rgba(150,175,255,0.20) !important;
    color: #263b75 !important;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
    $("#datess").jqxDateTimeInput({
        width: "100%",
        height: "30px",
        formatString: "dd.MM.yyyy",
        value: null
    });
});

function loadSearchs() {

    var docnoss = document.getElementById("docnoss").value;
    var accountss = document.getElementById("accountss").value;
    var accnamesss = document.getElementById("accnamess").value;
    var datess = document.getElementById("datess").value;
    var reftypess = document.getElementById("reftypess").value;
    var desc = document.getElementById("description").value;

    var description = desc.replace(/ /g,"%20");
    var accnamess = accnamesss.replace(/ /g,"%20");
    var aa = "yes";

    getdata(docnoss,accountss,accnamess,datess,reftypess,aa,description);
}

function getdata(docnoss,accountss,accnamess,datess,reftypess,aa,description){
    $("#refreshdivs").load(
        "submasterSearch.jsp?docnoss="+docnoss+
        "&accountss="+accountss+
        "&accnamess="+accnamess+
        "&datess="+datess+
        "&reftypess="+reftypess+
        "&aa="+aa+
        "&description="+description
    );
}

</script>

<body>

<div class="search-container">

    <div class="search-header">
        Document Search
        <small>Search by Doc No, Account, Account Name, Date and Type</small>
    </div>

    <div class="search-body">

        <!-- ROW 1: Doc No | Account | Account Name -->
        <div class="row">

            <div class="col">
                <label class="search-label">Doc No</label>
                <input type="text" id="docnoss" name="docnoss"
                class="search-input"
                value='<s:property value="docnoss"/>' />
            </div>

            <div class="col">
                <label class="search-label">Account</label>
                <input type="text" id="accountss" name="accountss"
                class="search-input"
                value='<s:property value="accountss"/>' />
            </div>

            <div class="col">
                <label class="search-label">Account Name</label>
                <input type="text" id="accnamess" name="accnamess"
                class="search-input"
                value='<s:property value="accnamess"/>' />
            </div>

        </div>

        <!-- ROW 2: Date | Description | Type + Search -->
        <div class="row">

            <div class="col">
                <label class="search-label">Date</label>
                <div id="datess"></div>
            </div>

            <div class="col">
                <label class="search-label">Description</label>
                <input type="text" id="description" name="description"
                class="search-input"
                value='<s:property value="description"/>' />
            </div>

            <div class="col">
                <label class="search-label">Type</label>
                <select name="reftypess" id="reftypess" class="search-input"
                style="height:34px; padding-left:10px;">
                    <option value="">--select--</option>
                    <option value="DIR">DIR</option>
                    <option value="NPO">NPO</option>
                </select>
            </div>

            <div class="col btn-col">
                <button class="search-btn" onclick="loadSearchs()">Search</button>
            </div>

        </div>

    </div>

    <div class="search-grid-area">
        <div id="refreshdivs">
            <jsp:include page="submasterSearch.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>
