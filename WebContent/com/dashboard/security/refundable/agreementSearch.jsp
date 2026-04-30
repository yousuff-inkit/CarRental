<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<style type="text/css">
/* =========================================================
   SCOPED UI: Modern Search Popup Style
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

/* Table layout */
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

/* Buttons */
.modern-ui .myButton {
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    font-weight: 700 !important;
    font-size: 12px !important;
    height: 24px !important; 
    line-height: 22px !important;
    padding: 0 15px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%) !important;
    color: #ffffff !important;
    border: 1px solid #083a8a; 
    border-radius: 3px;
    cursor: pointer;
    box-shadow: 0 1px 2px rgba(59, 130, 246, 0.3);
    text-align: center;
}

.modern-ui .myButton:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%) !important;
}
</style>

<script type="text/javascript">
$(document).ready(function () {}); 

function loadSearch() {
    var cldocno = document.getElementById("txtclientdocno").value;
    getdata(cldocno);
}

function funupdate() {
    var rtype = document.getElementById("txthidtype").value; 
    var docno = document.getElementById("hiddocno").value;
    
    $.messager.confirm('Message', 'Do you want to change Agreement?', function(r) {
        if(r == false) {
            return false; 
        } else {
            saveGridData(rtype, docno); 
        }
    });
}

function saveGridData(rtype, docno) {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            $("#overlay, #PleaseWait").hide();
            $.messager.alert('Message', items); 
        }
    };
    x.open("GET", "updateData.jsp?rtype=" + rtype + "&rdocno=" + docno, true);
    x.send();
}

function getdata(cldocno) {
    $("#refreshdiv").load('agmtsearchGrid.jsp?cldoc=' + cldocno);
}
</script>
</head>

<body bgcolor="#f5f7fa">
<div id="search" class="modern-ui">

    <!-- ACTION PANEL -->
    <div class="search-panel">
        <table width="100%">
            <!-- Legacy search inputs remain commented as in the original code -->
            <tr>
                <td align="right">
                    <button type="button" id="btnupdate" name="btnupdate" class="myButton" onclick="funupdate();" style="width: 120px;">
                        Update
                    </button>
                </td>
            </tr>
        </table>
    </div>

    <!-- GRID -->
    <div class="grid-container">
        <div id="refreshdiv">
            <jsp:include page="agmtsearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>
</body>
</html>