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
   SCOPED UI: Strict Pixel Grid Alignment
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
.modern-ui input[type="text"] {
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
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #fff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 12px;
    font-weight: bold;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    transition: all 0.2s;
    /* width: 100% removed to ensure natural compact size */
}

.modern-ui .myButton:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%);
}

/* Grid Container */
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
        var clientaccountno = document.getElementById("accountsno").value || "";
        var clientaccountname = document.getElementById("accountsname").value || "";
        var clientmobile = document.getElementById("clientmobileno").value || "";
        var curr = document.getElementById("txtcurrencies").value || "";
        var accounttype = document.getElementById("txtatypes").value || "";
        var code = document.getElementById("txtdocumenttypes").value || "";
        var debitcredit = document.getElementById("txtcreditdebit").value || "";
        var date = document.getElementById("txtnewdate").value || "";
        var checked = 1;
        
        if(typeof checkapprvl === 'function') {
            checkapprvl(code);
        }
        
        getClientAccountDetails(clientaccountno, clientaccountname, clientmobile, curr, accounttype, code, debitcredit, date, checked);
    }
        
    function getClientAccountDetails(clientaccountno, clientaccountname, clientmobile, curr, accounttype, code, debitcredit, date, checked){
        /* Safely encoding all URI components to prevent breakages */
        $("#refreshClientAccountDiv").load(
            "../../clientAccountDetailsSearchGrid.jsp?accountno=" + encodeURIComponent(clientaccountno) + 
            '&accountname=' + encodeURIComponent(clientaccountname) + 
            '&mobile=' + encodeURIComponent(clientmobile) + 
            '&currency=' + encodeURIComponent(curr) + 
            '&atype=' + encodeURIComponent(accounttype) + 
            '&dtype=' + encodeURIComponent(code) + 
            '&debitcredit=' + encodeURIComponent(debitcredit) + 
            '&date=' + encodeURIComponent(date) + 
            '&check=' + checked
        );
    }
</script>
</head>

<body style="background-color: #fff; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <colgroup>
                <col width="12%" /> <col width="28%" /> <col width="10%" /> <col width="25%" /> <col width="25%" /> </colgroup>
            
            <tr>
                <td class="lbl-right">Account No</td>
                <td>
                    <input type="text" name="accountsno" id="accountsno" value='<s:property value="accountsno"/>'>
                </td>
                
                <td class="lbl-right">Currency</td>
                <td>
                    <input type="text" name="txtcurrencies" id="txtcurrencies" value='<s:property value="txtcurrencies"/>'>
                    
                    <input type="hidden" name="txtatypes" id="txtatypes" value='<s:property value="txtatypes"/>'>
                    <input type="hidden" name="txtdocumenttypes" id="txtdocumenttypes" value='<s:property value="txtdocumenttypes"/>'>
                </td>
                
                <td align="center" rowspan="2" valign="middle">
                    <input type="button" name="btnClientAccountSearch" id="btnClientAccountSearch" class="myButton" value="Search" onclick="loadClientAccountSearch();">
                </td>
            </tr>
            
            <tr>
                <td class="lbl-right">Account Name</td>
                <td>
                    <input type="text" name="accountsname" id="accountsname" value='<s:property value="accountsname"/>'>
                </td>
                
                <td class="lbl-right">Mobile</td>
                <td>
                    <input type="text" name="clientmobileno" id="clientmobileno" value='<s:property value="clientmobileno"/>'>
                    
                    <input type="hidden" name="txtcreditdebit" id="txtcreditdebit" value='<s:property value="txtcreditdebit"/>'>
                    <input type="hidden" name="txtnewdate" id="txtnewdate" value='<s:property value="txtnewdate"/>'>
                    <input type="hidden" id="hidapprvlcheck"/>
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="refreshClientAccountDiv">
            <jsp:include page="clientAccountDetailsSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>