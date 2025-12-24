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


#search table.cr-search-table td[align="right"] {
    font-weight: 800;
    color: #333;
    white-space: nowrap;
}

/* text inputs */
#search input[type="text"] {
    width: 100%;
    border: 1px solid #d1d5db;
    border-radius: 5px;
    padding: 4px 8px;
    height: 22px;
    line-height: 22px;
    font-size: 12px;
    box-sizing: border-box;
}

/* jqx date container should span cell width */
#roledate {
    width: 100%;
}

/* search button */
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

/* grid wrapper */
#refreshdiv {
    margin-top: 8px;
    background: #fff;
    border-radius: 6px;
    box-shadow: 0 0 0 1px #e0e4ee;
}
</style>

<script type="text/javascript">
$(document).ready(function () {
    $("#roledate").jqxDateTimeInput({
        width: '110px',
        height: '15px',
        formatString:"dd.MM.yyyy",
        value:null
    });
}); 

function loadSearch() {
    var rolename = document.getElementById("txtuserrolename").value;
    var docNo    = document.getElementById("txtdocno").value;
    var date     = document.getElementById("roledate").value;
    getdata(rolename, docNo, date);
}
function getdata(rolename, docNo, date){
    $("#refreshdiv").load(
        'rleMainSearchGrid.jsp?rolename=' + encodeURIComponent(rolename) +
        '&docNo=' + docNo +
        '&date=' + date
    );
}
</script>
</head>

<body>
<div id="search">
    <div id="search-body">
        <table class="cr-search-table">
            <tr>
                <td align="right" style="width:10%;">Date</td>
                <td style="width:20%;">
                    <div id="roledate" name="roledate"
                         value='<s:property value="roledate"/>'></div>
                    <input type="hidden" name="hidroledate" id="hidroledate"
                           value='<s:property value="hidroledate"/>'>
                </td>

                <td align="right" style="width:15%;">Doc No</td>
                <td style="width:30%;">
                    <input type="text" name="txtdocno" id="txtdocno"
                           value='<s:property value="txtdocno"/>'>
                </td>

                <td style="width:25%;" align="center">
                    <input type="button" name="btnsearch" id="btnsearch"
                           class="myButton" value="Search"
                           onclick="loadSearch();">
                </td>
            </tr>

            <tr>
                <td align="right">Name</td>
                <td colspan="4">
                    <input type="text" name="txtuserrolename" id="txtuserrolename"
                           style="width:100%;"
                           value='<s:property value="txtuserrolename"/>'>
                </td>
            </tr>

            <tr>
                <td colspan="5">
                    <div id="refreshdiv">
                        <jsp:include page="rleMainSearchGrid.jsp"></jsp:include>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</div>
</body>
</html>
