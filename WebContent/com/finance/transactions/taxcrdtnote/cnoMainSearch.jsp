<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

<style>
/* =========================================================
   SCOPED UI: Bulletproof Search Modal Table Layout
========================================================= */
body {
    margin: 0;
    background-color: #fff;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

.modern-ui {
    font-size: 12px;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #333;
    padding: 10px;
    box-sizing: border-box;
    width: 100%;
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"] {
    height: 24px !important;
    border: 1px solid #b8c6d8;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 12px;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    box-sizing: border-box;
    background-color: #fff;
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
    background-color: #FFD6FF; /* Client master focus color */
}

/* Panel Styling */
.modern-ui .search-panel {
    background-color: #fff;
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    padding: 12px 10px;
    margin-bottom: 10px;
    width: 100%;
    box-sizing: border-box;
}

/* Table alignment - STRICT GRID */
.modern-ui table {
    border-collapse: separate;
    border-spacing: 5px 8px; 
    width: 100%;
    table-layout: fixed; /* Locks columns from squishing */
}

.modern-ui td {
    padding: 0px 5px;
    vertical-align: middle;
}

.modern-ui .lbl-right {
    text-align: right;
    font-weight: 600;
    color: #222;
    white-space: nowrap;
    font-size: 12px;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

/* Modern Search Button - natural compact sizing */
.modern-ui .myButton {
    height: 26px;
    padding: 0 20px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #fff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 12px;
    font-weight: bold;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    box-shadow: 0 1px 2px rgba(59, 130, 246, 0.3);
    transition: all 0.2s;
}

.modern-ui .myButton:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%);
}

/* Data Grid Container */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
    width: 100%;
}
</style>

<script type="text/javascript">
    $(document).ready(function () {
        /* FIXED WIDTH: 100% fits the colgroup width safely without squishing the calendar */
        $("#creditdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy", value:null});
        
        /* Force internal alignment AFTER render */
        setTimeout(function () {
            $(".jqx-datetimeinput").css({"margin-top": "0px", "border-color": "#b8c6d8", "border-radius": "3px"});
            $(".jqx-datetimeinput").find("input").css({
                "margin-top": "0px", 
                "line-height": "24px", 
                "font-size": "12px", 
                "font-family": "'Segoe UI', 'Roboto', 'Arial', sans-serif",
                "padding": "0 6px", 
                "box-sizing":"border-box"
            });
            $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
        }, 100);
    }); 

    function loadSearch() {
        var docNo = document.getElementById("txtdocumentno").value || "";
        var date = $('#creditdate').jqxDateTimeInput('val') || "";
        var accId = document.getElementById("txtaccountid").value || "";
        var accName = document.getElementById("txtaccountname").value || "";
        var amount = document.getElementById("txtamounts").value || "";
        var description = document.getElementById("txtdescriptions").value || "";
        var check = 1;
        
        getdata(docNo, date, accId, accName, amount, description, check);
    }
    
    function getdata(docNo, date, accId, accName, amount, description, check){
        /* Safely encoding URI components */
        $("#refreshdiv").load('cnoMainSearchGrid.jsp?docNo=' + encodeURIComponent(docNo) + 
                              '&date=' + date + 
                              '&accId=' + encodeURIComponent(accId) + 
                              '&accName=' + encodeURIComponent(accName) + 
                              '&amount=' + encodeURIComponent(amount) + 
                              '&description=' + encodeURIComponent(description) + 
                              '&check=' + check);
    }
</script>
</head>

<body style="background-color: #fff; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <colgroup>
                <col width="8%" />  <col width="17%" /> <col width="6%" />  <col width="13%" /> <col width="8%" />  <col width="28%" /> <col width="20%" /> </colgroup>
            
            <tr>
                <td class="lbl-right">Doc No</td>
                <td>
                    <input type="text" name="txtdocumentno" id="txtdocumentno" autocomplete="off" value='<s:property value="txtdocumentno"/>'>
                </td>
                
                <td class="lbl-right">Date</td>
                <td>
                    <div id="creditdate" name="creditdate" value='<s:property value="creditdate"/>'></div>
                    <input type="hidden" name="hidcreditdate" id="hidcreditdate" value='<s:property value="hidcreditdate"/>'>
                </td>
                
                <td class="lbl-right">A/C No.</td>
                <td>
                    <input type="text" name="txtaccountid" id="txtaccountid" autocomplete="off" value='<s:property value="txtaccountid"/>'>
                </td>
                
                <td align="center" rowspan="2" valign="middle" style="padding-left: 10px;">
                    <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch();">
                </td>
            </tr>
            
            <tr>
                <td class="lbl-right">A/C Name</td>
                <td>
                    <input type="text" name="txtaccountname" id="txtaccountname" autocomplete="off" value='<s:property value="txtaccountname"/>'>
                </td>
                
                <td class="lbl-right">Amount</td>
                <td>
                    <input type="text" name="txtamounts" id="txtamounts" autocomplete="off" value='<s:property value="txtamounts"/>'>
                </td>
                
                <td class="lbl-right">Desc</td>
                <td>
                    <input type="text" name="txtdescriptions" id="txtdescriptions" autocomplete="off" value='<s:property value="txtdescriptions"/>'>
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="refreshdiv">
            <jsp:include page="cnoMainSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>
</body>
</html>