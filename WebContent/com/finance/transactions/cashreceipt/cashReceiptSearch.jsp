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

<style>
.l-btn {
    background-color: #007bff !important;
    border-color: #007bff !important;
}
.l-btn .l-btn-text {
    color: #ffffff !important;
    font-weight: 600;
}
.l-btn:hover {
    background-color: #0056b3 !important;
}

/* FINAL EASYUI OVERRIDE */
a.l-btn,
a.l-btn:hover,
a.l-btn:active {
    background-image: none !important;
    background-color: #0066ff !important;
    border: 1px solid #0066ff !important;
}

a.l-btn span.l-btn-text {
    color: #ffffff !important;
    font-weight: bold;
}
</style>



</head>

<body>

<div id="search">

<table width="100%" cellpadding="5">

<tr>
    <td width="10%" align="right">Account No</td>
    <td width="30%">
        <input type="text" id="txtacctno" style="width:85%;">
    </td>

    <td width="10%" align="right">Currency</td>
    <td width="27%">
        <input type="text" id="txtacctcurrency" style="width:50%;">
        <input type="hidden" id="txttypes">
        <input type="hidden" id="txtnewmaindate">
    </td>
    <td align="right">Account Name</td>
    <td >
        <input type="text" id="txtacctname" style="width:80%;">
    </td>

    <td width="23%"  align="center">
        <!-- EasyUI Button -->
        <a href="javascript:void(0)"
           class="easyui-linkbutton"
           onclick="loadAccountSearchGrid();">
            Search
        </a>
    </td>
</tr>



<tr>
    <td colspan="5">
        <div id="refreshAccountSearchDetailsDiv">
            <jsp:include page="cashReceiptSearchGrid.jsp"/>
        </div>
    </td>
</tr>

</table>

</div>

</body>
</html>
