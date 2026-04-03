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
}

.modern-ui {
    font-family: Arial, sans-serif;
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
    box-sizing: border-box;
    background-color: #fff;
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
}

/* Panel Styling */
.modern-ui .search-panel {
    background-color: #f4f7fb;
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    padding: 12px 10px;
    margin-bottom: 10px;
    width: 100%;
    box-sizing: border-box;
}

/* Table alignment */
.modern-ui td {
    padding: 4px 5px;
    vertical-align: middle;
}

.modern-ui .lbl-right {
    text-align: right;
    font-weight: bold;
    color: #444;
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
        /* 100% width allows JQX to perfectly fill the decoupled table cells */
        $("#bankdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy", value:null});
        $("#chqdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy", value:null});
        
        /* Force internal alignment AFTER render */
        setTimeout(function () {
            $(".jqx-datetimeinput").find("input").css({
                "margin-top": "0px", 
                "line-height": "24px", 
                "font-size": "12px", 
                "font-family": "Arial, sans-serif",
                "padding": "0 6px", 
                "box-sizing":"border-box"
            });
            $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
        }, 0);
    }); 

    function loadSearch() {
        var partyname = document.getElementById("txtpartyname").value;
        var docNo = document.getElementById("txtdocno").value;
        var date = document.getElementById("bankdate").value;
        var amount = document.getElementById("txtamount").value;
        var chequeNo = document.getElementById("txtchqno").value;
        var chequeDt = document.getElementById("chqdate").value;
        var check = 1;
        
        getdata(partyname, docNo, date, amount, chequeNo, chequeDt, check);
    }
    
    function getdata(partyname, docNo, date, amount, chequeNo, chequeDt, check){
         $("#refreshdiv").load(
             'ibpMainSearchGrid.jsp?partyname=' + encodeURIComponent(partyname.replace(/ /g, "%20")) + 
             '&docNo=' + docNo + 
             '&date=' + date + 
             '&amount=' + amount + 
             '&chequeNo=' + chequeNo + 
             '&chequeDt=' + chequeDt + 
             '&check=' + check
         );
    }
</script>
</head>

<body style="background-color: #fff; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">
        
        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-bottom: 8px;">
            <tr>
                <td class="lbl-right" width="6%">Name</td>
                <td width="46%">
                    <input type="text" name="txtpartyname" id="txtpartyname" autocomplete="off" value='<s:property value="txtpartyname"/>'>
                </td>
                <td class="lbl-right" width="10%">Doc No</td>
                <td width="20%">
                    <input type="text" name="txtdocno" id="txtdocno" autocomplete="off" value='<s:property value="txtdocno"/>'>
                </td>
                <td width="18%" align="right" style="padding-right: 5px;">
                    <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch();">
                </td>
            </tr>
        </table>

        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="lbl-right" width="6%">Date</td>
                <td width="17%">
                    <div id="bankdate" name="bankdate" value='<s:property value="bankdate"/>'></div>
                    <input type="hidden" name="hidbankdate" id="hidbankdate" value='<s:property value="hidbankdate"/>'>
                </td>
                <td class="lbl-right" width="8%">Amount</td>
                <td width="15%">
                    <input type="text" name="txtamount" id="txtamount" autocomplete="off" value='<s:property value="txtamount"/>'>
                </td>
                <td class="lbl-right" width="10%">Cheque No</td>
                <td width="15%">
                    <input type="text" id="txtchqno" name="txtchqno" autocomplete="off" value='<s:property value="txtchqno"/>'>
                </td>
                <td class="lbl-right" width="12%">Cheque Date</td>
                <td width="17%">
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