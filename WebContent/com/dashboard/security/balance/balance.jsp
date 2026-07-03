<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

<style type="text/css">
/* ===== MASTER LAYOUT (Modern Flexbox) ===== */
html, body, #mainBG {
    height: 100%;
    margin: 0;
    overflow: hidden;
    background-color: #f4f7f9;
}

.master-container {
    display: flex;
    width: 100%;
    height: 100vh;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

/* ===== LEFT SIDEBAR ===== */
.sidebar-filters {
    width: 280px; 
    flex: 0 0 280px; 
    background: #fff;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100%;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
    z-index: 10;
}

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 15px 25px; 
}

/* Cards */
.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 15px;
}

.card-title {
    font-size: 13px;
    font-weight: 700;
    color: #2563eb;
    margin-bottom: 12px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    border-bottom: 1px solid #e1e8ed;
    padding-bottom: 6px;
}

/* Tables */
.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.filter-table .label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    width: 80px;
}

/* ===== UNIFORM 24px INPUTS & SELECTS ===== */
input[type="text"], select,
.filter-table input[type="text"],
.filter-table select {
    width: 100%;
    height: 24px;              
    padding: 2px 8px;          
    border: 1px solid #ccd6e0;
    border-radius: 4px;        
    font-size: 12px;          
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
    outline: none;
    font-family: inherit;
}

/* Readonly / disabled look */
input[readonly], input:disabled, select:disabled,
.filter-table input[readonly], .filter-table input:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed;
    cursor: not-allowed;
}

/* jqx date/time containers */
div[id^="uptodate"] {
    width: 100%;
}

/* Radio Button Layout */
.radio-group {
    display: flex;
    justify-content: center;
    gap: 20px;
    align-items: center;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    margin-top: 5px;
}

.radio-group label {
    display: flex;
    align-items: center;
    cursor: pointer;
}

.radio-group input[type="radio"] {
    margin: 0 6px 0 0;
    vertical-align: middle;
}

/* ===== BUTTONS ===== */
.btn-submit {
    width: 100%;
    height: 30px;            
    padding: 0 12px;         
    background: #2563eb;
    color: #fff;
    border: none;
    border-radius: 4px;      
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
    line-height: 30px;       
    text-align: center;
    transition: background 0.2s;
    margin-top: 10px;
}

.btn-submit:hover:not(:disabled) { background: #1d4ed8; }
.btn-submit.btn-secondary { background: #64748b; }
.btn-submit.btn-secondary:hover:not(:disabled) { background: #475569; }

/* ===== RIGHT CONTENT AREA ===== */
.main-content-area {
    flex: 1; 
    display: flex;
    flex-direction: column;
    background: #ffffff;
    height: 100%;
    overflow: hidden;
}

.top-toolbar-container {
    width: 100%;
    padding: 10px 15px;
    background: #ffffff;
    border-bottom: 1px solid #e1e8ed;
    box-sizing: border-box;
}

/* Block layout required for JQX grids to calculate percentage height properly */
.grid-content-container {
    flex: 1;
    padding: 15px;
    overflow: auto; 
    box-sizing: border-box;
    display: block; 
}

.bottom-total-row {
    margin-top: 15px;
    display: flex;
    justify-content: flex-end;
    align-items: center;
    gap: 10px;
    font-size: 13px;
    font-weight: 600;
    color: #333;
}

/* Fix for jqx widget overrides */
.jqx-widget input, .jqx-widget select {
    height: 24px !important;
    line-height: 24px !important;
}
</style>

<script type="text/javascript">
$(document).ready(function () {
    // Standardized height to 24px and width to 100%
    $("#uptodate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    
    // Note: jqxWindow requires TWO nested divs to function correctly
    $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%', maxHeight: '70%', maxWidth: '51%', title: 'Client Search', position: { x: 300, y: 87 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#accountDetailsWindow').jqxWindow('close');
    
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    
    $('#txtclientaccount').dblclick(function(){
        accountsSearchContent('accountsDetailsSearch.jsp');
    });
    
    document.getElementById("rdopen").checked = true;
});

function accountsSearchContent(url) {
    $('#accountDetailsWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#accountDetailsWindow').jqxWindow('setContent', data);
        $('#accountDetailsWindow').jqxWindow('bringToFront');
    }); 
}

function getClient(event){
    var x = event.keyCode;
    if(x == 114){
        accountsSearchContent('accountsDetailsSearch.jsp');
    }
}

function funreload(event){
    var branchval = document.getElementById("cmbbranch").value;
    var uptodate = $('#uptodate').val();
    var clientaccount = $('#txtclientaccount').val();
    var agreementtype = "OPEN";
    
    if(document.getElementById("rdopen").checked == true){
        agreementtype = "OPEN";
    } else if(document.getElementById("rdclose").checked == true){
        agreementtype = "CLOSE";
    }
    
    $("#overlay, #PleaseWait").show();
    $("#balanceDiv").load("balanceGrid.jsp?branchval="+branchval+'&uptodate='+uptodate+'&clientaccount='+clientaccount+'&agreementtype='+agreementtype);
}

function funClearInfo(){
    $('#uptodate').val(new Date());
    document.getElementById("txtclientaccount").value = "";
    document.getElementById("txtclientname").value = "";
    document.getElementById("txtcldocno").value = "";
    document.getElementById("rdopen").checked = true;
    $('#txtnetamount').val(0);
    
    $("#jqxBalance").jqxGrid('clear');
    $("#jqxBalance").jqxGrid('addrow', null, {});
    
    if (document.getElementById("txtclientaccount").value == "") {
        $('#txtclientaccount').attr('placeholder', 'Press F3 to Search'); 
    }
}
    
function funExportBtn(){
    if(parseInt(window.parent.chkexportdata.value) == "1") {
        JSONToCSVCon(data, 'SecurityBalance', true);
    } else {
        $("#jqxBalance").jqxGrid('exportdata', 'xls', 'SecurityBalance');
    }
}
</script>
</head>

<body onload="getBranch();">

<div id="mainBG" class="homeContent" data-type="background">

    <div class="master-container">

        <!-- ================= LEFT SIDEBAR ================= -->
        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">
                
                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">Up To</td>
                            <td>
                                <div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Client</td>
                            <td>
                                <input type="text" id="txtclientaccount" name="txtclientaccount" readonly
                                       placeholder="Press F3 to Search"
                                       value='<s:property value="txtclientaccount"/>'
                                       onkeydown="getClient(event);">
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <input type="text" id="txtclientname" name="txtclientname" readonly tabindex="-1"
                                       value='<s:property value="txtclientname"/>'>
                                <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'>
                            </td>
                        </tr>
                    </table>
                </div>

                <!-- AGREEMENT TYPE CARD -->
                <div class="filter-card">
                    <div class="card-title">Agreement Type</div>
                    <div class="radio-group">
                        <label>
                            <input type="radio" id="rdopen" name="rdo" value="rdopen">
                            Open
                        </label>
                        <label>
                            <input type="radio" id="rdclose" name="rdo" value="rdclose">
                            Close
                        </label>
                    </div>
                </div>

                <!-- BUTTONS -->
                <button type="button" class="btn-submit btn-secondary" id="clear" onclick="funClearInfo();">
                    Clear
                </button>

            </div>
        </div>

        <!-- ================= RIGHT CONTENT AREA ================= -->
        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                
                <div id="balanceDiv">
                    <jsp:include page="balanceGrid.jsp"></jsp:include>
                </div>
                
                <div class="bottom-total-row">
                    <label>Net Balance :</label>
                    <input type="text" id="txtnetamount" name="txtnetamount" readonly
                           style="width: 150px; text-align: right; font-weight: bold; background-color: #f3f6f9;"
                           value='<s:property value="txtnetamount"/>'>
                </div>

            </div>

        </div>

    </div>

    <!-- POPUPS -->
    <div id="accountDetailsWindow">
        <div></div><div></div>
    </div>

</div>

</body>
</html>