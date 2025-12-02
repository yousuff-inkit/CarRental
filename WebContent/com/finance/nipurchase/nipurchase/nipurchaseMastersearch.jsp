<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<style>
/* ===== PREMIUM SEARCH UI ===== */

body {
    background: linear-gradient(135deg, #f0f4ff 0%, #d7e4ff 100%);
    font-family: "Segoe UI", Arial, sans-serif;
    margin: 0;
    padding: 25px;
}

/* MAIN CONTAINER */
.search-container {
    background: #ffffff;
    border-radius: 16px;
    border: 1px solid #dce6ff;
    box-shadow: 0px 8px 25px rgba(93,125,255,0.18);
    padding: 0;
    max-width: 900px;
    margin: 22px auto;
}

/* HEADER BAR */
.search-header {
    background: linear-gradient(90deg, #4c8fff, #6aa3ff);
    padding: 14px 20px;
    color: white;
    font-size: 1.05rem;
    font-weight: 600;
}

/* GRID LAYOUT */
.search-grid {
    display: grid;
    grid-template-columns: 160px auto 160px auto;
    gap: 16px 30px;
    padding: 28px 30px;
    background: #fbfcff;
}

.label {
    font-weight: 600;
    font-size: 14px;
    color: #1c3470;
}

.input-box {
    width: 100%;
    height: 34px;
    border: 1px solid #bcd0ff;
    border-radius: 8px;
    padding: 6px 10px;
    font-size: 14px;
    background: #ffffff;
    box-shadow: 0 1px 4px rgba(150,165,255,0.18);
    transition: 0.2s;
}

.input-box:focus {
    border-color: #6a9cff;
    box-shadow: 0 0 0 2px rgba(106,155,255,0.25);
    outline: none;
}

/* FULL ROW FOR SEARCH BUTTON */
.search-row-full {
    padding: 10px 30px 25px 30px;
    background: #fbfcff;
    display: flex;
    justify-content: flex-start;
}

.search-btn {
    background: linear-gradient(90deg,#6fb1fc,#1a73e8);
    color: #fff;
    border: none;
    padding: 10px 26px;
    border-radius: 10px;
    font-size: 15px;
    cursor: pointer;
    font-weight: 600;
    box-shadow: 0 3px 10px rgba(26,115,232,0.30);
    transition: 0.2s;
}

.search-btn:hover {
    transform: translateY(-2px);
}

/* RESULTS AREA */
.results-box {
    padding: 18px 25px;
    background: #f3f6ff;
    border-top: 1px solid #dce6ff;
    border-radius: 0 0 16px 16px;
}


/* Remove Chrome Autofill PINK Background */
input.input-box:-webkit-autofill,
input.input-box:-webkit-autofill:hover,
input.input-box:-webkit-autofill:focus,
textarea.input-box:-webkit-autofill,
select.input-box:-webkit-autofill {
    -webkit-box-shadow: 0 0 0 1000px #ffffff inset !important;
    box-shadow: 0 0 0 1000px #ffffff inset !important;
    -webkit-text-fill-color: #1c3470 !important;
    transition: background-color 9999s ease-in-out 0s;
}

input.input-box:-webkit-autofill {
    border: 1px solid #bcd0ff !important;
}

</style>

<script type="text/javascript">
$(document).ready(function () { 
    $("#datess").jqxDateTimeInput({
        width: '150px',
        height: '32px',
        formatString:"dd.MM.yyyy",
        value: null
    });
});

function loadSearchs() {

    var docnoss = document.getElementById("docnoss").value;
    var accountss = document.getElementById("accountss").value;
    var accnamess = document.getElementById("accnamess").value.replace(/ /g, "%20");
    var datess = document.getElementById("datess").value;
    var reftypess = document.getElementById("reftypess").value;
    var desc = document.getElementById("description").value.replace(/ /g, "%20");

    $("#refreshdivs").load(
        'submasterSearch.jsp?docnoss='+docnoss+
        '&accountss='+accountss+
        '&accnamess='+accnamess+
        '&datess='+datess+
        '&reftypess='+reftypess+
        '&aa=yes'+
        '&description='+desc
    );
}
</script>
</head>

<body>
<div class="search-container">

    <div class="search-header">Search Documents</div>

    <div class="search-grid">

        <div class="label">Doc No</div>
        <input type="text" id="docnoss" class="input-box" value='<s:property value="docnoss"/>'>

        <div class="label">Account</div>
        <input type="text" id="accountss" class="input-box" value='<s:property value="accountss"/>'>

        <div class="label">Account Name</div>
        <input type="text" id="accnamess" class="input-box" value='<s:property value="accnamess"/>'>

        <div class="label">Date</div>
        <div id="datess"></div>

        <div class="label">Description</div>
        <input type="text" id="description" class="input-box" value='<s:property value="description"/>'>

        <div class="label">Type</div>
        <select id="reftypess" class="input-box" style="width:150px;">
            <option value="">--select--</option>
            <option value="DIR">DIR</option>
            <option value="NPO">NPO</option>
        </select>

    </div>

    <!-- FULL WIDTH SEARCH BUTTON -->
    <div class="search-row-full">
        <button class="search-btn" onclick="loadSearchs()">Search</button>
    </div>

    <div class="results-box" id="refreshdivs">
        <jsp:include page="submasterSearch.jsp"></jsp:include>
    </div>

</div>
</body>
</html>
