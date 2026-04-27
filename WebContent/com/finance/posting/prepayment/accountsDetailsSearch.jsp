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
   MODERN ERP UI - STRICT TABLE LAYOUT (NO CLIPPING)
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

/* Master Inputs */
.modern-ui input[type="text"] {
    height: 24px !important;
    border: 1px solid #c5d3e0;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 12px;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    box-sizing: border-box;
    width: 100%;
    background-color: #fff;
    color: #333;
}

.modern-ui input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
}

/* Table Settings */
.modern-ui table {
    border-collapse: separate;
    border-spacing: 5px 8px; 
    width: 100%;
    table-layout: fixed;
}

.modern-ui td {
    vertical-align: middle;
    padding: 0;
}

.modern-ui .lbl-right {
    text-align: right;
    font-weight: 600;
    color: #222;
    padding-right: 5px;
    white-space: nowrap;
    font-size: 12px;
}

/* Panel Containers */
.modern-ui .search-panel {
    background-color: #fff;
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    padding: 10px;
    margin-bottom: 10px;
}

/* Buttons */
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
    white-space: nowrap;
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
        /* Safely check for elements to prevent JS errors if they load slowly */
        if(document.getElementById("txtforsearch")) {
            document.getElementById("txtsearchtype").value = document.getElementById("txtforsearch").value;
        }
        if($('#maindate').length) {
            document.getElementById("txtnewdates").value = $('#maindate').val();
        }
    }); 
    
    function loadAccountSearch() {
        var accountsno = document.getElementById("txtaccountsno").value || "";
        var accountsname = document.getElementById("txtaccountsname").value || "";
        var currs = document.getElementById("txtaccountcurrency").value || "";
        var searchtype = document.getElementById("txtsearchtype").value || "";
        var dates = document.getElementById("txtnewdates").value || ""; 
        var check = 1;
    
        getAccountDetails(accountsno, accountsname, currs, searchtype, dates, check);
    }
        
    function getAccountDetails(accountsno, accountsname, currs, searchtype, dates, check){
        /* Safely encoding URI components to prevent backend breakages */
        $("#refreshAccountDetailsDiv").load("accountDetailsSearchGrid.jsp?accountno=" + encodeURIComponent(accountsno) + 
                                            "&accountname=" + encodeURIComponent(accountsname) + 
                                            "&currency=" + encodeURIComponent(currs) + 
                                            "&searchtype=" + encodeURIComponent(searchtype) + 
                                            "&dates=" + encodeURIComponent(dates) + 
                                            "&check=" + check);
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
                    <input type="text" name="txtaccountsno" id="txtaccountsno" autocomplete="off" value='<s:property value="txtaccountsno"/>'>
                </td>
                
                <td class="lbl-right">Currency</td>
                <td>
                    <input type="text" name="txtaccountcurrency" id="txtaccountcurrency" autocomplete="off" value='<s:property value="txtaccountcurrency"/>'>
                    <input type="hidden" name="txtsearchtype" id="txtsearchtype" value='<s:property value="txtsearchtype"/>'>
                    <input type="hidden" name="txtnewdates" id="txtnewdates" value='<s:property value="txtnewdates"/>'>
                </td>
                
                <td align="center" rowspan="2" valign="middle">
                    <input type="button" name="btnAccountSearch" id="btnAccountSearch" class="myButton" value="Search" onclick="loadAccountSearch();">
                </td>
            </tr>
            
            <tr>
                <td class="lbl-right">Account Name</td>
                <td colspan="3">
                    <input type="text" name="txtaccountsname" id="txtaccountsname" autocomplete="off" value='<s:property value="txtaccountsname"/>'>
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="refreshAccountDetailsDiv">
            <jsp:include page="accountDetailsSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>
</body>
