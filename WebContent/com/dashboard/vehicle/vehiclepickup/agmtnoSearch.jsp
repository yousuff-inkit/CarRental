<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

<% String agmttype=request.getParameter("agmt")==null?"0":request.getParameter("agmt").toString();%>

<script type="text/javascript">
$(document).ready(function () {
    /* Initialize JQX to match 24px input height */
    $("#searchdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy", value:null});
    
    /* Sync JQX internal styling */
    setTimeout(function () {
        $(".jqx-datetimeinput").css({"border-color": "#b8c6d8", "border-radius": "3px"});
        $(".jqx-datetimeinput input").css({"line-height": "24px", "font-size": "12px", "font-family": "'Segoe UI', 'Roboto', 'Arial', sans-serif"});
        $(".jqx-datetimeinput .jqx-action-button").css({"height": "24px"});
    }, 100);
});

function loadSearch() {
    var agmt = '<%=agmttype%>';
    var docnosearch1 = $('#docnosearch').val() || "";
    var fleetsearch = $('#fleetsearch').val() || "";
    var regnosearch = $('#regnosearch').val() || "";
    var clientsearch = $('#clientsearch').val() || "";
    
    /* Safely get date from JQX or fallback to standard input */
    var searchdate = $('#searchdate').val();
    if(!searchdate && $('#searchdate').jqxDateTimeInput) {
        searchdate = $('#searchdate').jqxDateTimeInput('val');
    }
    searchdate = searchdate || "";
    
    var mobilesearch = $('#mobilesearch').val() || "";

    /* Safe check in case cmbbranch is in a parent frame or hidden */
    var branchElem = document.getElementById("cmbbranch");
    var branch = branchElem ? branchElem.value : "";
    if (!branch && $('#cmbbranch').length) branch = $('#cmbbranch').val() || "";

    /* Safely encode URI components instead of basic string replace */
    $("#loadRaSearch").load('gridRaSearch.jsp?docnochk=' + encodeURIComponent(docnosearch1) +
                            '&fleetchk=' + encodeURIComponent(fleetsearch) +
                            '&regnochk=' + encodeURIComponent(regnosearch) +
                            '&clientchk=' + encodeURIComponent(clientsearch) +
                            '&datechk=' + encodeURIComponent(searchdate) +
                            '&mobilechk=' + encodeURIComponent(mobilesearch) +
                            '&branchchk=' + encodeURIComponent(branch) +
                            '&agmt=' + encodeURIComponent(agmt) +
                            '&chk=1');
}
</script>

<style type="text/css">
/* =========================================================
   SCOPED UI: Cash Receipts Style (Matching the Picture)
========================================================= */
body {
    margin: 0;
    background-color: #f5f7fa; 
}

#search.modern-ui {
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    font-size: 12px !important;
    color: #333;
    padding: 10px;
    background-color: #f5f7fa;
}

.modern-ui .search-panel {
    background: #fff;
    border: 1px solid #c5d3e0;
    border-radius: 8px;
    padding: 12px 10px;
    margin-bottom: 12px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.04);
}

.modern-ui .grid-container {
    background: #fff;
    border: 1px solid #c5d3e0;
    border-radius: 8px;
    padding: 5px;
    min-height: 50px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.04);
}

/* Table rules strictly matching the 3-column + button layout from the image */
.modern-ui table {
    border-collapse: separate;
    border-spacing: 4px 8px; 
    width: 100%;
}

.modern-ui td {
    font-size: 12px !important;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    vertical-align: middle;
}

/* KILLS THE GREEN COLOR FROM BODY.CSS */
#search.modern-ui td[align="right"],
#search.modern-ui .branch {
    color: #000000 !important; 
    font-weight: normal !important;
    background-color: transparent !important; /* <--- THIS KILLS THE GREEN HIGHLIGHT */
    background: none !important;
    padding-right: 5px;
    white-space: nowrap;
    cursor: default;
}

/* Master Input Heights */
.modern-ui input[type="text"] {
    height: 24px !important;
    font-size: 12px !important;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    font-weight: normal !important;
    border: 1px solid #b8c6d8;
    border-radius: 3px;
    padding: 2px 6px;
    box-sizing: border-box;
    width: 100%;
    transition: border-color 0.2s;
    background-color: #ffffff !important; /* Forces white to kill any autofill green */
}

.modern-ui input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
    box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.1);
}

/* Button positioned exactly like the image */
.modern-ui .myButton {
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    font-weight: 700 !important;
    font-size: 12px !important;
    height: 24px !important; /* Matched to input height */
    line-height: 22px !important;
    padding: 0 15px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%) !important;
    color: #ffffff !important;
    border: 1px solid #083a8a;
    border-radius: 3px;
    cursor: pointer;
    box-shadow: 0 1px 2px rgba(59, 130, 246, 0.3);
    text-align: center;
    width: 100%; 
}

.modern-ui .myButton:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%) !important;
}
</style>
</head>

<body bgcolor="#f5f7fa">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%">
            <colgroup>
                <col width="8%">  <col width="22%"> <col width="8%">  <col width="22%"> <col width="8%">  <col width="22%"> <col width="2%">  <col width="8%">  </colgroup>

            <tr>
                <td align="right"><label class="branch">Doc No</label></td>
                <td align="left"><input type="text" name="docnosearch" id="docnosearch" value='<s:property value="docnosearch"/>'></td>
                
                <td align="right"><label class="branch">Fleet</label></td>
                <td align="left"><input type="text" name="fleetsearch" id="fleetsearch" value='<s:property value="fleetsearch"/>'></td>
                
                <td align="right"><label class="branch">Reg No</label></td>
                <td align="left"><input type="text" name="regnosearch" id="regnosearch" value='<s:property value="regnosearch"/>'></td>
                
                <td align="right">&nbsp;</td>
                <td align="left">&nbsp;</td>
            </tr>
            <tr>
                <td align="right"><label class="branch">Client</label></td>
                <td align="left"><input type="text" name="clientsearch" id="clientsearch" value='<s:property value="clientsearch"/>'></td>
                
                <td align="right"><label class="branch">Date</label></td>
                <td align="left">
                    <div id="searchdate" name="searchdate" value='<s:property value="searchdate"/>'></div>
                    <input type="hidden" name="hidsearchdate" id="hidsearchdate" value='<s:property value="hidsearchdate"/>'>
                </td>
                
                <td align="right"><label class="branch">Mobile</label></td>
                <td align="left"><input type="text" name="mobilesearch" id="mobilesearch" value='<s:property value="mobilesearch"/>'></td>
                
                <td colspan="2" align="center">
                    <input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search" onclick="loadSearch();">
                </td> 
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="loadRaSearch">
            <jsp:include page="gridRaSearch.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>