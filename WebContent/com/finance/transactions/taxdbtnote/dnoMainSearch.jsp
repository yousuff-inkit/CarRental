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
SCOPED UI: Compact Search Modal Layout
========================================================= */
.modern-ui {
    font-family: Arial, sans-serif;
    font-size: 12px;
    color: #333;
    padding: 10px;
    box-sizing: border-box;
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
    padding: 15px;
    margin-bottom: 10px;
}

/* Unbreakable Row Layouts */
.modern-ui .form-row {
    display: flex;
    align-items: center;
    margin-bottom: 10px;
    gap: 20px;
    flex-wrap: nowrap;
}

.modern-ui .field-group {
    display: flex;
    align-items: center;
    gap: 8px;
}

/* Fixed Label Alignments */
.modern-ui .fixed-lbl {
    width: 75px;
    text-align: right;
    font-weight: bold;
    color: #444;
    white-space: nowrap;
    flex-shrink: 0;
}

/* Modern Search Button */
.modern-ui .myButton {
    height: 26px;
    padding: 0 16px;
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
}
</style>

<script type="text/javascript">
    $(document).ready(function () {
        /* Upgraded JQX Dates to match 24px inputs */
        $("#debitdate").jqxDateTimeInput({ width: '120px', height: '24px', formatString:"dd.MM.yyyy", value:null});
        
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
        var docNo = document.getElementById("txtdocumentno").value;
        var date = document.getElementById("debitdate").value;
        var accId = document.getElementById("txtaccountid").value;
        var accName = document.getElementById("txtaccountname").value;
        var amounts = document.getElementById("txtamounts").value;
        var amount = (amounts * -1);
        var description = document.getElementById("txtdescriptions").value;
        var check = 1;
        
        getdata(docNo, date, accId, accName, amount, description, check);
    }
    
    function getdata(docNo, date, accId, accName, amount, description, check){
         $("#refreshdiv").load(
             'dnoMainSearchGrid.jsp?docNo=' + docNo + 
             '&date=' + date + 
             '&accId=' + accId + 
             '&accName=' + encodeURIComponent(accName.replace(/ /g, "%20")) + 
             '&amount=' + amount + 
             '&description=' + encodeURIComponent(description.replace(/ /g, "%20")) + 
             '&check=' + check
         );
    }
</script>
</head>

<body style="background-color: #fff; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">
        
        <div class="form-row">
            <div class="field-group">
                <label class="fixed-lbl">Doc No</label>
                <input type="text" name="txtdocumentno" id="txtdocumentno" style="width: 140px;" value='<s:property value="txtdocumentno"/>'>
            </div>
            
            <div class="field-group">
                <label class="fixed-lbl" style="width: 50px;">Date</label>
                <div id="debitdate" name="debitdate" value='<s:property value="debitdate"/>'></div>
                <input type="hidden" name="hiddebitdate" id="hiddebitdate" value='<s:property value="hiddebitdate"/>'>
            </div>

            <div class="field-group">
                <label class="fixed-lbl" style="width: 60px;">A/C No.</label>
                <input type="text" name="txtaccountid" id="txtaccountid" style="width: 120px;" value='<s:property value="txtaccountid"/>'>
            </div>
            
            <div style="margin-left: auto;">
                <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch();">
            </div>
        </div>
        
        <div class="form-row" style="margin-bottom: 0;">
            <div class="field-group">
                <label class="fixed-lbl">A/C Name</label>
                <input type="text" name="txtaccountname" id="txtaccountname" style="width: 140px;" value='<s:property value="txtaccountname"/>'>
            </div>

            <div class="field-group">
                <label class="fixed-lbl" style="width: 50px;">Amount</label>
                <input type="text" name="txtamounts" id="txtamounts" style="width: 120px;" value='<s:property value="txtamounts"/>'>
            </div>

            <div class="field-group" style="flex: 1; max-width: 400px;">
                <label class="fixed-lbl" style="width: 60px;">Desc</label>
                <input type="text" name="txtdescriptions" id="txtdescriptions" style="flex: 1;" value='<s:property value="txtdescriptions"/>'>
            </div>
        </div>
        
    </div>

    <div class="grid-container">
        <div id="refreshdiv">
            <jsp:include page="dnoMainSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>