<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

<style type="text/css">
/* =========================================================
   SCOPED UI: Modern Search Popup Style
========================================================= */
body {
    margin: 0;
    background-color: #f5f7fa; 
}

#search.modern-ui {
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    font-size: 12px !important;
    color: #333;
    padding: 10px;
    background-color: #f5f7fa;
}

.modern-ui .search-panel {
    background: #fff;
    border: 1px solid #c5d3e0;
    border-radius: 8px;
    padding: 12px 10px;
    margin-bottom: 12px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.04);
}

.modern-ui .grid-container {
    background: #fff;
    border: 1px solid #c5d3e0;
    border-radius: 8px;
    padding: 5px;
    min-height: 50px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.04);
}

/* Table layout */
.modern-ui table {
    border-collapse: separate;
    border-spacing: 4px 8px; 
    width: 100%;
}

.modern-ui td {
    font-size: 12px !important;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    vertical-align: middle;
}

.modern-ui td[align="right"] {
    color: #444 !important;
    font-weight: 600 !important;
    padding-right: 8px;
    white-space: nowrap;
}

.modern-ui .formfont {
    font-size: 12px;
    font-weight: 600;
    cursor: default;
    color: #444;
}

/* Master Input Heights */
.modern-ui input[type="text"] {
    height: 24px !important;
    font-size: 12px !important;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    font-weight: normal !important;
    border: 1px solid #b8c6d8;
    border-radius: 3px;
    padding: 2px 6px;
    box-sizing: border-box;
    width: 100%;
    transition: border-color 0.2s;
    background-color: #ffffff;
}

.modern-ui input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
    box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.1);
}

/* Buttons */
.modern-ui .myButton {
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    font-weight: 700 !important;
    font-size: 12px !important;
    height: 24px !important; /* Matched to input height */
    line-height: 22px !important;
    padding: 0 15px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%) !important;
    color: #ffffff !important;
    border: 1px solid #083a8a; 
    border-radius: 3px;
    cursor: pointer;
    box-shadow: 0 1px 2px rgba(59, 130, 246, 0.3);
    text-align: center;
    width: 100%;
}

.modern-ui .myButton:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%) !important;
}
</style>

<script type="text/javascript">
    $(document).ready(function () {}); 

    function loadSearch() {
        var clientsname = document.getElementById("txtclientsname").value;
        var contactNo = document.getElementById("txtcontactno").value;
        
        getdata(clientsname, contactNo);
    }
    
    function getdata(clientsname, contactNo){
        $("#refreshdiv").load('clientDetailsSearchGrid.jsp?clientname='+clientsname.replace(/ /g, "%20")+'&contactNo='+contactNo+'&check=1');
    }
</script>
</head>

<body bgcolor="#f5f7fa">
<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%">
            <colgroup>
                <col width="10%"> <col width="35%">
                <col width="15%"> <col width="25%">
                <col width="15%">
            </colgroup>

            <tr>
                <td align="right">
                    <label class="formfont">Name</label>
                </td>
                <td align="left">
                    <input type="text" name="txtclientsname" id="txtclientsname" value='<s:property value="txtclientsname"/>'>
                </td>

                <td align="right">
                    <label class="formfont">Contact No.</label>
                </td>
                <td align="left">
                    <input type="text" name="txtcontactno" id="txtcontactno" value='<s:property value="txtcontactno"/>'>
                </td>

                <td align="right">
                    <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch();">
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="refreshdiv">
            <jsp:include page="clientDetailsSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>
</body>
</html>