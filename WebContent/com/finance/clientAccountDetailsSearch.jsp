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
        if(document.getElementById("txtforsearch")) {
            if(document.getElementById("txtforsearch").value == "2" && document.getElementById("cmbtype")){
                document.getElementById("txtatypes").value = document.getElementById("cmbtype").value;
            }
            else if(document.getElementById("txtforsearch").value == "3" && document.getElementById("cmbacctype")){
                document.getElementById("txtatypes").value = document.getElementById("cmbacctype").value;
            } else if (document.getElementById("cmbtotype")) {
                document.getElementById("txtatypes").value = document.getElementById("cmbtotype").value;
            }
            document.getElementById("txtcreditdebit").value = document.getElementById("txtforsearch").value;
        }
        
        if(document.getElementById("formdetailcode")) {
            document.getElementById("txtdocumenttypes").value = document.getElementById("formdetailcode").value;
        }
        
        if($('#maindate').length) {
            document.getElementById("txtnewdate").value = $('#maindate').val();
        }
    }); 
    
    function loadClientAccountSearch() {
        var clientaccountno = document.getElementById("accountsno").value;
        var clientaccountname = document.getElementById("accountsname").value;
        var clientmobile = document.getElementById("clientmobileno").value;
        var curr = document.getElementById("txtcurrencies").value;
        var accounttype = document.getElementById("txtatypes").value;
        var code = document.getElementById("txtdocumenttypes").value;
        var debitcredit = document.getElementById("txtcreditdebit").value;
        var date = document.getElementById("txtnewdate").value;
        var checked = 1;
        
        if(typeof checkapprvl === 'function') {
            checkapprvl(code);
        }
        
        getClientAccountDetails(clientaccountno, clientaccountname, clientmobile, curr, accounttype, code, debitcredit, date, checked);
    }
        
    function getClientAccountDetails(clientaccountno, clientaccountname, clientmobile, curr, accounttype, code, debitcredit, date, checked){
        $("#refreshClientAccountDiv").load(
            "../../clientAccountDetailsSearchGrid.jsp?accountno=" + clientaccountno + 
            '&accountname=' + encodeURIComponent(clientaccountname.replace(/ /g, "%20")) + 
            '&mobile=' + clientmobile + 
            '&currency=' + curr + 
            '&atype=' + accounttype + 
            '&dtype=' + code + 
            '&debitcredit=' + debitcredit + 
            '&date=' + date + 
            '&check=' + checked
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
                <input type="text" name="accountsno" id="accountsno" style="width: 140px;" value='<s:property value="accountsno"/>'>
            </div>
            
            <div class="field-group">
                <label class="fixed-lbl" style="width: 60px;">Currency</label>
                <input type="text" name="txtcurrencies" id="txtcurrencies" style="width: 80px;" value='<s:property value="txtcurrencies"/>'>
                
                <input type="hidden" name="txtatypes" id="txtatypes" value='<s:property value="txtatypes"/>'>
                <input type="hidden" name="txtdocumenttypes" id="txtdocumenttypes" value='<s:property value="txtdocumenttypes"/>'>
            </div>
            
            <div style="margin-left: auto;">
                <input type="button" name="btnClientAccountSearch" id="btnClientAccountSearch" class="myButton" value="Search" onclick="loadClientAccountSearch();">
            </div>
        </div>
        
        <div class="form-row" style="margin-bottom: 0;">
            <div class="field-group">
                <label class="fixed-lbl">Account Name</label>
                <input type="text" name="accountsname" id="accountsname" style="width: 200px;" value='<s:property value="accountsname"/>'>
            </div>
            
            <div class="field-group">
                <label class="fixed-lbl" style="width: 50px;">Mobile</label>
                <input type="text" name="clientmobileno" id="clientmobileno" style="width: 120px;" value='<s:property value="clientmobileno"/>'>
                
                <input type="hidden" name="txtcreditdebit" id="txtcreditdebit" value='<s:property value="txtcreditdebit"/>'>
                <input type="hidden" name="txtnewdate" id="txtnewdate" value='<s:property value="txtnewdate"/>'>
                <input type="hidden" id="hidapprvlcheck"/>
            </div>
        </div>
        
    </div>

    <div class="grid-container">
        <div id="refreshClientAccountDiv">
            <jsp:include page="clientAccountDetailsSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>