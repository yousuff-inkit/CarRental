<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<style>
/* =========================================================
SCOPED UI: Clean UI Panel Design for Search Modal
* All rules are prefixed with .modern-ui to prevent bleeding! *
========================================================= */

.modern-ui {
    font-family: Arial, sans-serif;
    color: #333;
    font-size: 12px;
    padding: 10px;
    background-color: #f4f6f9;
    height: 100%;
    box-sizing: border-box;
}

/* Master Input Heights - Set to 24px */
.modern-ui input[type="text"], 
.modern-ui select {
    height: 24px !important;
    border: 1px solid #ccc;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box;
    background-color: #fff;
    color: #333;
}

/* Compact Width Classes */
.modern-ui .input-xs { width: 60px !important; }
.modern-ui .input-sm { width: 100px !important; }
.modern-ui .input-md { width: 140px !important; }
.modern-ui .input-lg { width: 200px !important; }
.modern-ui .input-xl { width: 300px !important; }
.modern-ui .input-full { width: 100% !important; flex: 1; }

.modern-ui input[type="text"]:focus, 
.modern-ui select:focus {
    border-color: #007bff;
    outline: none;
}

/* Layout Utilities */
.modern-ui .field-row {
    display: flex;
    align-items: center;
    gap: 8px;
    margin-bottom: 12px;
    flex-wrap: wrap;
}

.modern-ui .lbl-right {
    text-align: right;
    color: #444;
    font-size: 12px;
    font-weight: bold;
    white-space: nowrap;
    padding-right: 5px;
}

/* Panel Styling */
.modern-ui .modern-panel {
    border: 1px solid #e1e4e8;
    padding: 15px;
    background: #fff;
    border-radius: 4px;
    margin-bottom: 15px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.05);
}

/* Search Button */
.modern-ui .myButton {
    font-weight: bold;
    font-size: 12px;
    height: 24px !important;
    padding: 0px 16px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    box-shadow: 0 1px 2px rgba(59, 130, 246, 0.3);
    transition: all 0.2s ease;
}

.modern-ui .myButton:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%);
    transform: translateY(-1px);
}

/* Grid Container */
.modern-ui .grid-container {
    background: #fff;
    border: 1px solid #e1e4e8;
    padding: 2px;
    min-height: 200px;
}
</style>

<script type="text/javascript">
$(document).ready(function () {}); 

function loadSearch() {
    var vndname=document.getElementById("txtvendorsname").value;
    var vndaccno=document.getElementById("txtaccountno").value;
    var vndmob=document.getElementById("txtmobile").value;
    var vndtel=document.getElementById("txttelephone").value;

    getdata(vndname,vndaccno,vndmob,vndtel);
}

function getdata(vndname,vndaccno,vndmob,vndtel){
    $("#refreshdiv").load('vndMainSearchGrid.jsp?vndname='+vndname.replace(/ /g, "%20")+'&vndaccno='+vndaccno+'&vndmob='+vndmob+'&vndtel='+vndtel);
}
</script>

</head>
<body>

<div id="search" class="modern-ui">

    <div class="modern-panel">
        
        <div class="field-row">
            <label class="lbl-right" style="width: 50px;">Name</label>
            <input type="text" name="txtvendorsname" id="txtvendorsname" class="input-lg" style="flex: 1; max-width: 350px;" value='<s:property value="txtvendorsname"/>'>

            <label class="lbl-right" style="width: 60px; margin-left: 10px;">A/C No.</label>
            <input type="text" name="txtaccountno" id="txtaccountno" class="input-md" value='<s:property value="txtaccountno"/>'>

            <div style="margin-left: auto;">
                <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch();">
            </div>
        </div>

        <div class="field-row" style="margin-bottom: 0;">
            <label class="lbl-right" style="width: 50px;">Mob No.</label>
            <input type="text" name="txtmobile" id="txtmobile" class="input-lg" style="flex: 1; max-width: 350px;" value='<s:property value="txtmobile"/>'>

            <label class="lbl-right" style="width: 60px; margin-left: 10px;">Tel No.</label>
            <input type="text" name="txttelephone" id="txttelephone" class="input-md" value='<s:property value="txttelephone"/>'>
        </div>

    </div>

    <div class="grid-container">
        <div id="refreshdiv">
            <jsp:include page="vndMainSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>