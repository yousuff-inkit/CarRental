<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

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
    height: 24px !important; 
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
$(document).ready(function () {
    $("#empdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy", value: null});
    $("#led").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy", value: null});
    
    // Safety check in case 'emptype' is coming from the parent window
    if(document.getElementById("emptype")) {
        document.getElementById("txttype").value = document.getElementById("emptype").value;
    }
}); 

function mainloadSearch() {
    var salesman = document.getElementById("txtsalname").value;
    var smob = document.getElementById("txtmob").value;
    var salescode = document.getElementById("txtcode").value;
    var docno = document.getElementById("txtempdocno").value;
    var date = document.getElementById("empdate").value;
    var led = document.getElementById("led").value;
    var type = document.getElementById("txttype").value;
    
    getdata(salesman, smob, salescode, docno, date, led, type);
}

function getdata(salesman, smob, salescode, docno, date, led, type){
    $("#refreshdiv").load('employeeDetailsSearchGrid.jsp?salesman='+encodeURIComponent(salesman)+'&smob='+encodeURIComponent(smob)+'&salescode='+encodeURIComponent(salescode)+'&docno='+encodeURIComponent(docno)+'&date='+encodeURIComponent(date)+'&led='+encodeURIComponent(led)+'&type='+encodeURIComponent(type));
}
</script>
</head>

<body bgcolor="#f5f7fa">
<div id="search" class="modern-ui">

    <!-- SEARCH FORM -->
    <div class="search-panel">
        <table width="100%">
            <colgroup>
                <col width="8%">  <col width="22%">
                <col width="8%">  <col width="22%">
                <col width="8%">  <col width="20%">
                <col width="12%">
            </colgroup>

            <!-- Row 1 -->
            <tr>
                <td align="right"><label class="formfont">Name</label></td>
                <td align="left">
                    <input type="text" name="txtsalname" id="txtsalname" value='<s:property value="txtsalname"/>'>
                    <input type="hidden" name="txttype" id="txttype" value='<s:property value="txttype"/>'>
                </td>

                <td align="right"><label class="formfont">Code</label></td>
                <td align="left">
                    <input type="text" name="txtcode" id="txtcode" value='<s:property value="txtcode"/>'>
                </td>

                <td align="right"><label class="formfont">Mob</label></td>
                <td align="left" colspan="2">
                    <input type="text" name="txtmob" id="txtmob" value='<s:property value="txtmob"/>'>
                </td>
            </tr>

            <!-- Row 2 -->
            <tr>
                <td align="right"><label class="formfont">Doc No</label></td>
                <td align="left">
                    <input type="text" name="txtempdocno" id="txtempdocno" value='<s:property value="txtempdocno"/>'>
                </td>

                <td align="right"><label class="formfont">Date</label></td>
                <td align="left">
                    <div id="empdate" name="empdate" value='<s:property value="empdate"/>'></div>
                    <input type="hidden" name="hidempdate" id="hidempdate" value='<s:property value="hidempdate"/>'>
                </td>

                <td align="right"><label class="formfont">L/C Exp.</label></td>
                <td align="left">
                    <div id="led" name="led" value='<s:property value="led"/>'></div>
                    <input type="hidden" name="hidled" id="hidled" value='<s:property value="hidled"/>'>
                </td>

                <td align="right">
                    <button type="button" name="mbtnrasearch" id="mbtnrasearch" class="myButton" onclick="mainloadSearch();">
                        Search
                    </button>
                </td>
            </tr>
        </table>
    </div>

    <!-- GRID -->
    <div class="grid-container">
        <div id="refreshdiv">
            <jsp:include page="employeeDetailsSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>
</body>
</html>