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
    $(document).ready(function () {
        /* Safety checks to ensure fields exist before pulling their values */
        if(document.getElementById("formdetailcode")) {
            document.getElementById("txtdoctypes").value = document.getElementById("formdetailcode").value;
        }
        if(document.getElementById("txtforsearch")) {
            document.getElementById("txtsearchtype").value = document.getElementById("txtforsearch").value;
        }
        if($('#maindate').length) {
            document.getElementById("txtnewdates").value = $('#maindate').val();
        }
    }); 
    
    function loadAccountSearch() {
        var accountsno = document.getElementById("txtaccountsno").value;
        var accountsname = document.getElementById("txtaccountsname").value;
        var currs = document.getElementById("txtaccountcurrency").value;
        var formcode = document.getElementById("txtdoctypes").value;
        var searchtype = document.getElementById("txtsearchtype").value;
        var dates = document.getElementById("txtnewdates").value;
        var check = 1;

        getAccountDetails(accountsno, accountsname, currs, formcode, searchtype, dates, check);
    }
        
    function getAccountDetails(accountsno, accountsname, currs, formcode, searchtype, dates, check){
        console.log("../../accountDetailsSearchGrid.jsp?accountno="+accountsno+'&accountname='+accountsname.replace(/ /g, "%20")+'&currency='+currs+'&dtype='+formcode+'&searchtype='+searchtype+'&dates='+dates+'&check='+check);
        
        $("#refreshAccountDetailsDiv").load(
            "../../accountDetailsSearchGrid.jsp?accountno=" + accountsno + 
            '&accountname=' + encodeURIComponent(accountsname.replace(/ /g, "%20")) + 
            '&currency=' + currs + 
            '&dtype=' + encodeURIComponent(formcode.trim()) + 
            '&searchtype=' + searchtype + 
            '&dates=' + dates + 
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
                <label class="fixed-lbl">Account No</label>
                <input type="text" name="txtaccountsno" id="txtaccountsno" style="width: 140px;" value='<s:property value="txtaccountsno"/>'>
            </div>
            
            <div class="field-group">
                <label class="fixed-lbl" style="width: 60px;">Currency</label>
                <input type="text" name="txtaccountcurrency" id="txtaccountcurrency" style="width: 80px;" value='<s:property value="txtaccountcurrency"/>'>
                
                <input type="hidden" name="txtdoctypes" id="txtdoctypes" value='<s:property value="txtdoctypes"/>'>
                <input type="hidden" name="txtsearchtype" id="txtsearchtype" value='<s:property value="txtsearchtype"/>'>
                <input type="hidden" name="txtnewdates" id="txtnewdates" value='<s:property value="txtnewdates"/>'>
            </div>
            
            <div style="margin-left: auto;">
                <input type="button" name="btnAccountSearch" id="btnAccountSearch" class="myButton" value="Search" onclick="loadAccountSearch();">
            </div>
        </div>
        
        <div class="form-row" style="margin-bottom: 0;">
            <div class="field-group" style="width: 100%; max-width: 500px;">
                <label class="fixed-lbl">Account Name</label>
                <input type="text" name="txtaccountsname" id="txtaccountsname" style="flex: 1;" value='<s:property value="txtaccountsname"/>'>
            </div>
        </div>
        
    </div>

    <div class="grid-container">
        <div id="refreshAccountDetailsDiv">
            <jsp:include page="accountDetailsSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>