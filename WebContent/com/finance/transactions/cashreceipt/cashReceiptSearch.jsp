<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<%
    String contextPath = request.getContextPath();
    String atype = request.getParameter("atype");
    if (atype == null) {
        atype = "0";
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>GatewayERP(i)</title>

<!-- Base CSS -->
<link rel="stylesheet" type="text/css"
      href="<%=contextPath%>/css/body.css">

<!-- EasyUI CSS (already in your project) -->
<link rel="stylesheet" type="text/css"
      href="<%=contextPath%>/css/easyui.css">

<!-- jQuery -->
<script src="<%=contextPath%>/js/jquery.min.js"></script>

<!-- EasyUI JS -->
<script src="<%=contextPath%>/js/jquery.easyui.min.js"></script>

<script type="text/javascript">
$(function () {

    // set hidden values safely
    if ($("#txttypes").length) {
        $("#txttypes").val("<%=atype%>");
    }

    if ($("#maindate").length && $("#txtnewmaindate").length) {
        $("#txtnewmaindate").val($("#maindate").val());
    }

});

// search button action
function loadAccountSearchGrid() {
    $("#refreshAccountSearchDetailsDiv").load(
        "cashReceiptSearchGrid.jsp",
        {
            accountno  : $("#txtacctno").val(),
            accountname: $("#txtacctname").val(),
            currency   : $("#txtacctcurrency").val(),
            atype      : $("#txttypes").val(),
            date       : $("#txtnewmaindate").val(),
            check      : 1
        }
    );
}
</script>

<!-- ✅ FORCE BLUE EASYUI BUTTON -->
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Modernized Search</title>
<style>
    /* 1. Global & Container Styles */
    body {
        font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
        background-color: #f4f7fa;
        display: flex;
        justify-content: center;
        padding-top: 40px;
        margin: 0;
    }

    #search-card {
        background: #ffffff;
        width: 90%;
        max-width: 900px;
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
        border: 1px solid #e1e8f0;
    }

    /* 2. Grid Layout Logic */
    .search-form-grid {
        display: grid;
        grid-template-columns: 1fr 1fr 150px; /* Three columns: 2 inputs + 1 button */
        gap: 20px;
        align-items: end;
    }

    .form-group {
        display: flex;
        flex-direction: column;
        gap: 8px;
    }

    .form-group.full-width {
        grid-column: span 2; /* Account Name spans 2 columns */
    }

    /* 3. Typography & Input Styling */
    label {
        font-size: 13px;
        font-weight: 600;
        color: #64748b;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    input[type="text"] {
        height: 40px;
        padding: 0 12px;
        border: 1px solid #cbd5e1;
        border-radius: 6px;
        font-size: 14px;
        color: #1e293b;
        transition: all 0.2s ease;
        background-color: #fcfcfc;
    }

    input[type="text"]:focus {
        outline: none;
        border-color: #2563eb;
        background-color: #ffffff;
        box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
    }

    /* 4. Your Specific Button Request */
    .btn-search {
        font-weight: 700;
        font-size: 13px;
        width: 130px;
        height: 42px; /* Matched to input height */
        padding: 8px 12px;
        background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
        color: #ffffff !important;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        transition: all 0.3s ease;
        box-shadow: 0 2px 4px rgba(59, 130, 246, 0.2);
        text-transform: uppercase;
        letter-spacing: 0.3px;
        white-space: nowrap;
        text-align: center;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        justify-content: center;
    }

    .btn-search:hover {
        transform: translateY(-1px);
        box-shadow: 0 4px 12px rgba(37, 99, 235, 0.4);
        filter: brightness(1.1);
    }

    .btn-search:active {
        transform: translateY(0);
    }

    /* 5. Results Section */
    .results-container {
        margin-top: 30px;
        border-top: 2px solid #f1f5f9;
        padding-top: 20px;
    }

    /* Utility for hidden fields */
    .hidden { display: none; }
</style>
</head>

<body>

<div id="search-card">
    <div class="search-form-grid">
        
        <div class="form-group">
            <label for="txtacctno">Account No</label>
            <input type="text" id="txtacctno" placeholder="e.g. 10002345">
        </div>

        <div class="form-group">
            <label for="txtacctcurrency">Currency</label>
            <input type="text" id="txtacctcurrency" placeholder="USD">
            
            <input type="hidden" id="txttypes">
            <input type="hidden" id="txtnewmaindate">
        </div>

        <div class="form-group" style="align-items: center;">
            <a href="javascript:void(0)" 
               class="btn-search" 
               onclick="loadAccountSearchGrid();">
                Search
            </a>
        </div>

        <div class="form-group full-width">
            <label for="txtacctname">Account Name</label>
            <input type="text" id="txtacctname" placeholder="Search by customer or business name...">
        </div>

    </div>

    <div class="results-container">
        <div id="refreshAccountSearchDetailsDiv">
            <jsp:include page="cashReceiptSearchGrid.jsp"/>
        </div>
    </div>
</div>

</body>
</html>
