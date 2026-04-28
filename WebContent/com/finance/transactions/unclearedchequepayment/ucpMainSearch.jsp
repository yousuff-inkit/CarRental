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
   SCOPED UI: Segoe UI Font & Clean White Search Panel
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

/* Master Input Styles */
.modern-ui input[type="text"],
.modern-ui select {
    height: 24px !important;
    border: 1px solid #BDBDBD;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 12px; 
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    box-sizing: border-box;
    background-color: #fff;
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus {
    border-color: #007bff;
    outline: none;
}

/* Panel Styling - Clean White Panel */
.modern-ui .search-panel {
    background-color: #fff !important; 
    border: 1px solid #BDBDBD;
    border-radius: 4px;
    padding: 12px 10px;
    margin-bottom: 10px;
    width: 100%;
    box-sizing: border-box;
}

/* Table Alignment - STRICT PERCENTAGE GRID */
.modern-ui table {
    border-collapse: separate;
    border-spacing: 5px 8px; 
    width: 100%;
    table-layout: fixed; /* Locks columns from squishing */
}

.modern-ui td {
    vertical-align: middle;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #222;
    font-size: 12px; 
    font-weight: 600;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Search Button - Standard Blue */
.modern-ui .myButton {
    height: 26px;
    padding: 0 20px;
    background-color: #0056b3;
    color: #ffffff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 12px;
    font-weight: bold;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    transition: all 0.2s;
    /* REMOVED width: 100% so button stays naturally compact */
}

.modern-ui .myButton:hover {
    background-color: #004494;
}

/* Grid Container */
.modern-ui .grid-container {
    border: 1px solid #BDBDBD;
    background: #fff;
    overflow: hidden;
    width: 100%;
}
</style>

<script type="text/javascript">
    $(document).ready(function () {
        /* FIXED 120px WIDTH: Kept wide enough so calendar icons don't crush text */
        $("#unclearchequedate").jqxDateTimeInput({ width: '120px', height: '24px', formatString:"dd.MM.yyyy", value:null});
        $("#chqdate").jqxDateTimeInput({ width: '120px', height: '24px', formatString:"dd.MM.yyyy", value:null});
        
        /* Force internal alignment AFTER render */
        setTimeout(function () {
            $(".jqx-datetimeinput").css({"margin-top": "0px", "border-color": "#BDBDBD", "border-radius": "3px"});
            $(".jqx-datetimeinput").find("input").css({
                "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
                "font-family": "'Segoe UI', 'Roboto', 'Arial', sans-serif", "padding": "0 6px", "box-sizing":"border-box"
            });
            $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
        }, 100);
    }); 

    function loadSearch() {
        var partyname = document.getElementById("txtpartyname").value || "";
        var docNo = document.getElementById("txtdocno").value || "";
        var date = $('#unclearchequedate').jqxDateTimeInput('val') || "";
        var amount = document.getElementById("txtamount").value || "";
        var chequeNo = document.getElementById("txtchqno").value || "";
        var chequeDt = $('#chqdate').jqxDateTimeInput('val') || "";
        var check = 1;
        
        getdata(partyname, docNo, date, amount, chequeNo, chequeDt, check);
    }
    
    function getdata(partyname, docNo, date, amount, chequeNo, chequeDt, check){
        /* Safely encoding URI components */
        $("#refreshdiv").load('ucpMainSearchGrid.jsp?partyname=' + encodeURIComponent(partyname) + 
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
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <colgroup>
                <col width="6%" />  <col width="18%" /> <col width="8%" />  <col width="17%" /> <col width="9%" />  <col width="18%" /> <col width="24%" /> 
            </colgroup>
            
            <tr>
                <td class="lbl-right">Name</td>
                <td>
                    <input type="text" name="txtpartyname" id="txtpartyname" autocomplete="off" value='<s:property value="txtpartyname"/>'>
                </td>
                
                <td class="lbl-right">Doc No</td>
                <td>
                    <input type="text" name="txtdocno" id="txtdocno" autocomplete="off" value='<s:property value="txtdocno"/>'>
                </td>
                
                <td class="lbl-right">Amount</td>
                <td>
                    <input type="text" name="txtamount" id="txtamount" autocomplete="off" value='<s:property value="txtamount"/>'>
                </td>
                
                <td align="center" rowspan="2" valign="middle">
                    <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch(); return false;">
                </td>
            </tr>
            
            <tr>
                <td class="lbl-right">Date</td>
                <td>
                    <div id="unclearchequedate" name="unclearchequedate" value='<s:property value="unclearchequedate"/>'></div>
                    <input type="hidden" name="hidunclearchequedate" id="hidunclearchequedate" value='<s:property value="hidunclearchequedate"/>'>
                </td>
                
                <td class="lbl-right">Chq No</td>
                <td>
                    <input type="text" id="txtchqno" name="txtchqno" autocomplete="off" value='<s:property value="txtchqno"/>'>
                </td>
                
                <td class="lbl-right">Chq Date</td>
                <td>
                    <div id="chqdate" name="chqdate" value='<s:property value="chqdate"/>'></div>
                    <input type="hidden" name="hidchqdate" id="hidchqdate" value='<s:property value="hidchqdate"/>'>
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="refreshdiv">
            <jsp:include page="ucpMainSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>