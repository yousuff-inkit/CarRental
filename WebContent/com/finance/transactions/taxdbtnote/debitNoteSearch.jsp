<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath(); %>
<% String atype = request.getParameter("atype")==null?"0":request.getParameter("atype"); %>
<% String cmbtype = request.getParameter("cmbtype")==null?"0":request.getParameter("cmbtype"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Accounts Search</title>

<style>

/* ------------------------------
   GENERAL RESET + FONT
--------------------------------*/
* {
    box-sizing: border-box;
    font-family: 'Segoe UI', Roboto, Arial, sans-serif;
}

body {
    margin: 0;
    padding: 0;
    background: transparent;
}

/* ------------------------------
   MAIN CARD CONTAINER
--------------------------------*/
.search-card {
    background: #ffffff;
    border-radius: 18px;
    border: 1px solid #d0dcff;
    box-shadow: 0px 10px 30px rgba(120, 150, 255, 0.25);
    padding: 22px 26px;
}

/* ------------------------------
   SECTION ROWS
--------------------------------*/
.search-row {
    display: flex;
    align-items: center;
    gap: 26px;
    margin-bottom: 22px;
}

/* ------------------------------
   LABELS
--------------------------------*/
.search-label {
    font-size: 0.95rem;
    font-weight: 600;
    color: #2b3d69;
    margin-bottom: 6px;
    display: block;
}

/* ------------------------------
   INPUT FIELDS
--------------------------------*/
.search-input {
    width: 100%;
    height: 44px;
    border-radius: 12px;
    border: 1px solid #c7d4ff;
    background: #ffffff;
    padding: 0px 14px;
    font-size: 1rem;
    color: #0c1f47;
    box-shadow: 0px 3px 8px rgba(180,200,255,0.35);
}

/* Remove Autofill PINK */
.search-input:-webkit-autofill,
.search-input:-webkit-autofill:hover,
.search-input:-webkit-autofill:focus {
    transition: background-color 9999s ease-in-out 0s;
}

/* ------------------------------
   SEARCH BUTTON
--------------------------------*/
.myButton {
    background: linear-gradient(90deg, #4ea1ff, #1a73e8);
    color: white !important;
    border: none;
    border-radius: 10px;
    padding: 11px 30px;
    font-weight: 600;
    font-size: 1rem;
    cursor: pointer;
    box-shadow: 0px 6px 18px rgba(26,115,232,0.30);
}
.myButton:hover {
    transform: translateY(-2px);
}

/* ------------------------------
   GRID CONTAINER
--------------------------------*/
.grid-section {
    margin-top: 10px;
    background: #f5f7ff;
    padding: 18px;
    border-radius: 14px;
    border: 1px solid #d8e2ff;
    box-shadow: inset 0 0 8px rgba(180,195,255,0.25);
    min-height: 350px;
}

@media (max-width: 900px) {
    .search-row {
        flex-direction: column;
    }
}
</style>

<script type="text/javascript">
$(document).ready(function () {

    var atype = '<%=atype%>';
    var cmbtype = '<%=cmbtype%>';

    $("#txttypes").val(atype);
    $("#txtcmtype").val(cmbtype);
    $("#txtnewmaindate").val($("#maindate").val());
});

function loadAccountSearchGrid() {

    var accountsno   = $("#txtacctno").val();
    var accountsname = $("#txtacctname").val();
    var currs        = $("#txtacctcurrency").val();
    var type         = $("#txttypes").val();
    var txtcmtype    = $("#txtcmtype").val();
    var date         = $("#txtnewmaindate").val();
    var creditdate   = $("#jqxDebitNoteDate").val();
    var check        = 1;

    $("#refreshAccountSearchDetailsDiv").load(
        "debitNoteSearchGrid.jsp?accountno=" + accountsno +
        "&accountname=" + accountsname.replace(/ /g, "%20") +
        "&currency=" + currs +
        "&atype=" + type +
        "&date=" + date +
        "&creditdate=" + creditdate +
        "&check=" + check +
        "&txtcmtype=" + txtcmtype
    );
}
</script>

</head>

<body>

<div class="search-card">

    <!-- ---------------- ROW 1 ---------------- -->
    <div class="search-row">

        <div style="flex:1">
            <label class="search-label">Account No</label>
            <input type="text" id="txtacctno" class="search-input" 
                   value='<s:property value="txtacctno"/>' />
        </div>

        <div style="flex:1">
            <label class="search-label">Currency</label>
            <input type="text" id="txtacctcurrency" class="search-input" 
                   value='<s:property value="txtacctcurrency"/>' />
        </div>

        <div style="flex:1">
            <label class="search-label">Mobile</label>
            <input type="text" id="txtacctmobile" class="search-input" />
        </div>

    </div>

    <!-- ---------------- ROW 2 ---------------- -->
    <div class="search-row">

        <div style="flex:2">
            <label class="search-label">Account Name</label>
            <input type="text" id="txtacctname" class="search-input" 
                   value='<s:property value="txtacctname"/>' />
        </div>

        <div style="flex:1; display:flex; align-items:flex-end;">
            <input type="button" class="myButton" value="Search" onclick="loadAccountSearchGrid();">
        </div>

    </div>

    <!-- Hidden Fields -->
    <input type="hidden" id="txttypes" value='<s:property value="txttypes"/>'>
    <input type="hidden" id="txtcmtype" value='<s:property value="txtcmtype"/>'>
    <input type="hidden" id="txtnewmaindate" value='<s:property value="txtnewmaindate"/>'>

    <!-- ---------------- GRID SECTION ---------------- -->
    <div class="grid-section">
        <div id="refreshAccountSearchDetailsDiv">
            <jsp:include page="debitNoteSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>
