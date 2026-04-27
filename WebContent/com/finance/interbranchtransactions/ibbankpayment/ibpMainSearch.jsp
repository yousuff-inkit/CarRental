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

/* Table alignment */
.modern-ui table {
    border-collapse: separate;
    border-spacing: 5px 8px; 
    width: 100%;
}

.modern-ui td {
    padding: 4px 5px;
    vertical-align: middle;
}

.modern-ui .lbl-right {
    text-align: right;
    font-weight: 600;
    color: #222;
    white-space: nowrap;
    font-size: 12px;
}

/* Modern Search Button */
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
    box-shadow: 0 1px 2px rgba(59, 130, 246, 0.3);
    transition: all 0.2s;
    width: 100%;
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
        /* FIXED 120px WIDTH: Prevents the calendar icon from overlapping text */
        $("#bankdate").jqxDateTimeInput({ width: '120px', height: '24px', formatString:"dd.MM.yyyy", value:null});
        $("#chqdate").jqxDateTimeInput({ width: '120px', height: '24px', formatString:"dd.MM.yyyy", value:null});
        
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
        var partyname = document.getElementById("txtpartyname").value || "";
        var docNo = document.getElementById("txtdocno").value || "";
        var date = $('#bankdate').jqxDateTimeInput('val') || "";
        var amount = document.getElementById("txtamount").value || "";
        var chequeNo = document.getElementById("txtchqno").value || "";
        var chequeDt = $('#chqdate').jqxDateTimeInput('val') || "";
        var check = 1;
        
        getdata(partyname, docNo, date, amount, chequeNo, chequeDt, check);
    }
    
    function getdata(partyname, docNo, date, amount, chequeNo, chequeDt, check){
        /* Safely encoding URI components */
        $("#refreshdiv").load('ibpMainSearchGrid.jsp?partyname=' + encodeURIComponent(partyname) + 
                              '&docNo=' + encodeURIComponent(docNo) + 
                              '&date=' + date + 
                              '&amount=' + encodeURIComponent(amount) + 
                              '&chequeNo=' + encodeURIComponent(chequeNo) + 
                              '&chequeDt=' + chequeDt + 
                              '&check=' + check);
    }
</script>
</head>

<body style="background-color: #fff; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">
        
        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-bottom: 5px;">
            <tr>
                <td class="lbl-right" style="width: 50px;">Name</td>
                <td style="width: 45%;">
                    <input type="text" name="txtpartyname" id="txtpartyname" autocomplete="off" value='<s:property value="txtpartyname"/>'>
                </td>
                
                <td class="lbl-right" style="width: 60px;">Doc No</td>
                <td style="width: 30%;">
                    <input type="text" name="txtdocno" id="txtdocno" autocomplete="off" value='<s:property value="txtdocno"/>'>
                </td>
                
                <td align="center" style="width: 100px; padding-left: 10px;">
                    <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch();">
                </td>
            </tr>
        </table>

        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="lbl-right" style="width: 50px;">Date</td>
                <td style="width: 125px;">
                    <div id="bankdate" name="bankdate" value='<s:property value="bankdate"/>'></div>
                    <input type="hidden" name="hidbankdate" id="hidbankdate" value='<s:property value="hidbankdate"/>'>
                </td>
                
                <td class="lbl-right" style="width: 60px;">Amount</td>
                <td>
                    <input type="text" name="txtamount" id="txtamount" autocomplete="off" value='<s:property value="txtamount"/>'>
                </td>
                
                <td class="lbl-right" style="width: 80px;">Cheque No</td>
                <td>
                    <input type="text" id="txtchqno" name="txtchqno" autocomplete="off" value='<s:property value="txtchqno"/>'>
                </td>
                
                <td class="lbl-right" style="width: 85px;">Cheque Date</td>
                <td style="width: 125px;">
                    <div id="chqdate" name="chqdate" value='<s:property value="chqdate"/>'></div>
                    <input type="hidden" name="hidchqdate" id="hidchqdate" value='<s:property value="hidchqdate"/>'>
                </td>
            </tr>
        </table>

    </div>

    <div class="grid-container">
        <div id="refreshdiv">
            <jsp:include page="ibpMainSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>
</body>
</html>