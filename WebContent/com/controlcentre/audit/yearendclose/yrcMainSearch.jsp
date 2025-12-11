<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<style>
/* popup container */
#search {
    width: 900px;
    margin: 0 auto;
    background: #f6f8fa;
    border-radius: 10px;
    box-shadow: 0 8px 30px rgba(15,23,42,0.25);
    font-family: 'Segoe UI','Roboto','Arial',sans-serif;
    font-size: 13px;
    color: #222;
}

/* inner body */
#search-body {
    padding: 8px 14px 10px 14px;
}

/* filters table */
#search table.cr-search-table {
    width: 100%;
    border-collapse: collapse;
    background: #f9fafb;
    border-radius: 8px;
    box-shadow: 0 0 0 1px #e0e4ee;
}

#search table.cr-search-table td {
    padding: 4px 6px;
    vertical-align: middle;
    font-size: 12px;
}

/* bold labels like master UI */
#search table.cr-search-table td[align="right"] {
    font-weight: 800;
    color: #333;
    white-space: nowrap;
}

/* text inputs (if any) */
#search input[type="text"] {
    width: 100%;
    border: 1px solid #d1d5db;
    border-radius: 5px;
    padding: 2px 6px;
    height: 22px;
    line-height: 22px;
    font-family: 'Segoe UI','Roboto','Arial',sans-serif;
    font-size: 12px;
    box-sizing: border-box;
}

/* jqx date containers fill cell */
#search div[id^="yrc"] {
    width: 100%;
}

/* search button aligned with fields */
#search .myButton,
#btnsearch {
    background: #007bff;
    color: #fff;
    border: none;
    border-radius: 6px;
    height: 24px;
    line-height: 22px;
    padding: 0 16px;
    cursor: pointer;
    font-size: 12px;
    font-weight: 600;
}
#search .myButton:hover,
#btnsearch:hover {
    background: #0056b3;
}

/* grid area */
#refreshdiv {
    margin-top: 8px;
    background: #fff;
    border-radius: 6px;
    box-shadow: 0 0 0 1px #e0e4ee;
}
</style>

<script type="text/javascript">
$(document).ready(function () {
    $("#yrcdate").jqxDateTimeInput({ width: '110px', height: '15px', formatString:"dd.MM.yyyy", value:null});
    $("#yrcAccFrmDate").jqxDateTimeInput({ width: '110px', height: '15px', formatString:"dd.MM.yyyy", value:null});
    $("#yrcAccToDate").jqxDateTimeInput({ width: '110px', height: '15px', formatString:"dd.MM.yyyy", value:null});
}); 

function loadSearch() {
    var docNo        = document.getElementById("txtdocno").value;
    var date         = document.getElementById("yrcdate").value;
    var yrcAccFrmDate= document.getElementById("yrcAccFrmDate").value;
    var yrcAccToDate = document.getElementById("yrcAccToDate").value;
    getdata(docNo, date, yrcAccFrmDate, yrcAccToDate);
}

function getdata(docNo, date, yrcAccFrmDate, yrcAccToDate){
    $("#refreshdiv").load(
        'yrcMainSearchGrid.jsp?docNo=' + docNo +
        '&date=' + date +
        '&yrcAccFrmDate=' + yrcAccFrmDate +
        '&yrcAccToDate=' + yrcAccToDate
    );
}
</script>
</head>

<body>
<div id="search">
    <div id="search-body">
        <table class="cr-search-table">
            <tr>
                <td align="right" style="width:15%;">Date</td>
                <td style="width:22%;">
                    <div id="yrcdate" name="yrcdate"
                         value='<s:property value="yrcdate"/>'></div>
                    <input type="hidden" name="hidyrcdate" id="hidyrcdate"
                           value='<s:property value="hidyrcdate"/>'>
                </td>

                <td align="right" style="width:16%;">Doc No</td>
                <td style="width:28%;">
                    <input type="text" name="txtdocno" id="txtdocno"
                           value='<s:property value="txtdocno"/>'>
                </td>

                <td style="width:19%;" rowspan="2" align="center">
                    <input type="button" name="btnsearch" id="btnsearch"
                           class="myButton" value="Search"
                           onclick="loadSearch();">
                </td>
            </tr>

            <tr>
                <td align="right">Accounting Year From</td>
                <td>
                    <div id="yrcAccFrmDate" name="yrcAccFrmDate"
                         value='<s:property value="yrcAccFrmDate"/>'></div>
                    <input type="hidden" name="hidyrcAccFrmDate" id="hidyrcAccFrmDate"
                           value='<s:property value="hidyrcAccFrmDate"/>'>
                </td>

                <td align="right">Accounting Year To</td>
                <td>
                    <div id="yrcAccToDate" name="yrcAccToDate"
                         value='<s:property value="yrcAccToDate"/>'></div>
                    <input type="hidden" name="hidyrcAccToDate" id="hidyrcAccToDate"
                           value='<s:property value="hidyrcAccToDate"/>'>
                </td>
            </tr>

            <tr>
                <td colspan="5">
                    <div id="refreshdiv">
                        <jsp:include page="yrcMainSearchGrid.jsp"></jsp:include>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</div>
</body>
</html>
