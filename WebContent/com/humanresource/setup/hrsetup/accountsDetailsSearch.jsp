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

/* Fixed Label Alignments for perfect vertical stacking */
.modern-ui .fixed-lbl {
    width: 85px;
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
    $(document).ready(function () {}); 
    
    function loadAccountSearch() {
        var accountsno = document.getElementById("txtaccountsno").value;
        var accountsname = document.getElementById("txtaccountsname").value;
        
        /* Safety check for formdetailcode (usually inherited from parent) */
        var formcode = "";
        if(document.getElementById("formdetailcode")) {
            formcode = document.getElementById("formdetailcode").value;
        }
        var check = 1;

        getAccountDetails(accountsno, accountsname, check, formcode);
    }
        
    function getAccountDetails(accountsno, accountsname, check, formcode){
         $("#refreshAccountDetailsDiv").load(
             "accountsDetailsFromGrid.jsp?accountno=" + accountsno + 
             '&accountname=' + encodeURIComponent(accountsname.replace(/ /g, "%20")) + 
             '&check=' + check + 
             '&formcode=' + formcode
         );
    }
</script>
</head>

<body style="background-color: #fff; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">
        
        <div class="form-row" style="margin-bottom: 0;">
            <div class="field-group">
                <label class="fixed-lbl">Account No</label>
                <input type="text" name="txtaccountsno" id="txtaccountsno" style="width: 140px;" value='<s:property value="txtaccountsno"/>'>
            </div>
            
            <div class="field-group" style="flex: 1; max-width: 500px;">
                <label class="fixed-lbl" style="width: 90px;">Account Name</label>
                <input type="text" name="txtaccountsname" id="txtaccountsname" style="flex: 1;" value='<s:property value="txtaccountsname"/>'>
            </div>
            
            <div style="margin-left: auto;">
                <input type="button" name="btnAccountSearch" id="btnAccountSearch" class="myButton" value="Search" onclick="loadAccountSearch();">
            </div>
        </div>
        
    </div>

    <div class="grid-container">
        <div id="refreshAccountDetailsDiv">
            <jsp:include page="accountsDetailsFromGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>