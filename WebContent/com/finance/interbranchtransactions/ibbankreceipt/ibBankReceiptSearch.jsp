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
<% String atype = request.getParameter("atype")==null?"0":request.getParameter("atype"); %>

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
    background-color: #FFD6FF; /* Client master focus color */
}

/* Panel Styling - Clean White Panel */
.modern-ui .search-panel {
    background-color: #fff !important; 
    border: 1px solid #BDBDBD;
    border-radius: 4px;
    padding: 12px;
    margin-bottom: 10px;
    width: 100%;
    box-sizing: border-box;
}

/* Table Alignment - Strict Grid Mapping */
.modern-ui table {
    border-collapse: separate;
    border-spacing: 5px 8px; 
    width: 100%;
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
        var atype='<%=atype%>';
        if(document.getElementById("txttypes")) {
            document.getElementById("txttypes").value=atype;
        }
        if($('#maindate').length) {
            document.getElementById("txtnewmaindate").value=$('#maindate').val();
        }
    }); 
    
    function loadAccountSearchGrid() {
        var accountsno = document.getElementById("txtacctno").value || "";
        var accountsname = document.getElementById("txtacctname").value || "";
        var currs = document.getElementById("txtacctcurrency").value || "";
        var type = document.getElementById("txttypes").value || "";
        var date = document.getElementById("txtnewmaindate").value || "";
        var check = 1;
    
        getAccountDetails(accountsno, accountsname, currs, type, date, check);
    }
        
    function getAccountDetails(accountsno, accountsname, currs, type, date, check){
        /* Safely encoding URI components to prevent breakages on special characters */
        $("#refreshAccountSearchDetailsDiv").load("ibBankReceiptSearchGrid.jsp?accountno=" + encodeURIComponent(accountsno) + 
                                                  "&accountname=" + encodeURIComponent(accountsname) + 
                                                  "&currency=" + encodeURIComponent(currs) + 
                                                  "&atype=" + encodeURIComponent(type) + 
                                                  "&date=" + encodeURIComponent(date) + 
                                                  "&check=" + check);
    }
</script>

</head>
<body style="background-color: #fff; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="lbl-right" width="10%">Account No</td>
                <td width="25%">
                    <input type="text" name="txtacctno" id="txtacctno" autocomplete="off" value='<s:property value="txtacctno"/>'>
                </td>
                
                <td class="lbl-right" width="10%">Currency</td>
                <td width="20%">
                    <input type="text" name="txtacctcurrency" id="txtacctcurrency" autocomplete="off" value='<s:property value="txtacctcurrency"/>'>
                    <input type="hidden" name="txttypes" id="txttypes" value='<s:property value="txttypes"/>'>
                    <input type="hidden" name="txtnewmaindate" id="txtnewmaindate" value='<s:property value="txtnewmaindate"/>'>
                </td>
                
                <td width="35%" rowspan="2" align="center" valign="middle">
                    <input type="button" name="btnAccountSearch" id="btnAccountSearch" class="myButton" value="Search" onclick="loadAccountSearchGrid();">
                </td>
            </tr>
            <tr>
                <td class="lbl-right">Account Name</td>
                <td colspan="3">
                    <input type="text" name="txtacctname" id="txtacctname" autocomplete="off" value='<s:property value="txtacctname"/>'>
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="refreshAccountSearchDetailsDiv">
            <jsp:include page="ibBankReceiptSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>