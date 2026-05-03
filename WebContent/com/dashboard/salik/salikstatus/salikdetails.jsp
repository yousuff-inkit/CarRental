<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

<style type="text/css">
/* ===== MASTER LAYOUT ===== */
html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
}

.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    background-color: #f4f7f9;
}

/* Sidebar dynamically fills the left TD */
.sidebar-filters {
    width: 100%;
    background: #fff;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100vh;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
}

.sidebar-fixed-top {
    padding: 15px 20px;
    border-bottom: 1px solid #f0f4f8;
}

/* Flex 1 allows this middle section to scroll while keeping top fixed */
.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 20px 15px; 
}

.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 12px;
    margin-bottom: 12px;
}

.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.label-cell {
    text-align: right;
    padding-right: 12px;
    font-size: 12px; 
    font-weight: 600;
    color: #4e5e71;
    width: 80px;
}

/* ===== UNIFORM 24px TEXT INPUTS ===== */
input[type="text"], select {
    width: 100%;
    height: 24px !important;             
    padding: 2px 8px !important;         
    border: 1px solid #ccd6e0 !important;
    border-radius: 4px !important;       
    font-size: 12px !important;          
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
    outline: none;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

input[readonly], input:disabled, select:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    cursor: pointer;
}

/* Checkbox Alignment */
input[type="checkbox"] {
    margin: 0;
    cursor: pointer;
    width: 14px;
    height: 14px;
    vertical-align: middle;
}

.checkbox-wrap {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 6px;
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
    margin-top: 10px;
    margin-bottom: 5px;
}

/* Layout Utilities */
.main-content-wrapper {
    flex: 1;
    width: 100%;
    display: flex;
    flex-direction: column;
    padding: 15px 20px;
    background: #fff;
    height: 100vh;
    box-sizing: border-box;
}

.scrollable-grid-area {
    flex: 1;
    width: 100%;
    overflow: auto;
}
</style>

<script type="text/javascript">
$(document).ready(function () {
    $("#cmbbranch").attr('hidden',true); 
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    $("body").prepend('<div id="suboverlay" class="ui-widget-overlay" style="z-index: 1003; display: none;"></div>');
    $("body").prepend("<div id='subPleaseWait' style='display: none;position:absolute; z-index: 1004;top:280px;left:100px;'><img src='../../../../icons/31load.gif'/></div>");
    
    $('#fleetwindow').jqxWindow({ width: '60%', height: '60%', maxHeight: '60%', maxWidth: '60%', title: 'Fleet Search', theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
    $('#fleetwindow').jqxWindow('close');
    
    // Standardized UI Controls
    $("#fromdate, #todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    
    var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));
    var onemounth = new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
    $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
        
    $('#todate').on('change', function (event) {
        var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));
        var todates = new Date($('#todate').jqxDateTimeInput('getDate'));
        if(fromdates > todates){
            $.messager.alert('Message','To Date Less Than From Date ','warning');   
            return false;
        }   
    });
        
    $('#fleetno').dblclick(function(){
        filterSearchContent('fleetMasterSearch.jsp','#fleetwindow');
    });
});

function getFleet(event){
    var x = event.keyCode;
    if(x == 114){
        filterSearchContent('fleetMasterSearch.jsp','#fleetwindow');
    }
}
    
function filterSearchContent(url,targetid) {
    $(targetid).jqxWindow('open');
    $.get(url).done(function (data) {
        $(targetid).jqxWindow('setContent', data);
        $(targetid).jqxWindow('bringToFront');
    }); 
}
    
function funreload(event){
    var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));
    var todates = new Date($('#todate').jqxDateTimeInput('getDate'));
    
    if(fromdates > todates){
        $.messager.alert('Message','To Date Less Than From Date ','warning');   
        return false;
    } else {
        var fromdate = $("#fromdate").val();
        var todate = $("#todate").val(); 
        var chkincrecv = $("#hidchckincrecv").val(); 
        var test = "10"; 
        var fleetno = $('#fleetno').val();
        
        $("#suboverlay, #subPleaseWait").show();
        $("#Readygrid").load("subgrid.jsp?test="+test+"&from="+fromdate+"&to="+todate+"&chkincrecv="+chkincrecv+"&id=1&fleetno="+fleetno);
    }
}
    
function hiddenbrh(){
    $("#branchlabel").attr('hidden',true);
    $("#branchdiv").attr('hidden',true);
}

function funExportBtn(){
    $("#jqxFleetGrid").excelexportjs({
        containerid: "jqxFleetGrid",
        datatype: 'json',
        dataset: null,
        gridId: "jqxFleetGrid",
        columns: getColumns("jqxFleetGrid"),
        worksheetName: "Salik Status"
    });
}   

function increcvcheck(){
    if(document.getElementById("chckincrecv").checked){
        document.getElementById("hidchckincrecv").value = 1;
    } else {
        document.getElementById("hidchckincrecv").value = 0;
    }
} 
</script>
</head>
<body onload="getBranch();hiddenbrh();increcvcheck();">

<div id="mainBG" class="homeContent">
<div class="hidden-scrollbar">
<div class="master-container">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr>

<!-- ================= LEFT SIDEBAR ================= -->
<td width="330px" valign="top">
    <div class="sidebar-filters">
        <div class="sidebar-fixed-top">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>

        <div class="sidebar-scroll-content">
            
            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">From</td>
                        <td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">To</td>
                        <td><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
                    </tr>
                    <tr>
                        <td colspan="2" style="height: 10px;"></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Fleet</td>
                        <td>
                            <input type="text" name="fleetno" id="fleetno" readonly
                                   placeholder="Press F3 to Search"
                                   value='<s:property value="fleetno"/>'
                                   onkeyup="getFleet(event);">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <div class="checkbox-wrap">
                                <input type="checkbox" id="chckincrecv" name="chckincrecv" 
                                       onchange="increcvcheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                                <label for="chckincrecv">Including Received</label>
                            </div>
                            <input type="hidden" id="hidchckincrecv" name="hidchckincrecv" value='<s:property value="hidchckincrecv"/>'>
                        </td>
                    </tr>
                </table>
            </div>

            <!-- Sub Grid Details Area -->
            <div style="margin-top: 15px;">
                <div id="Readygrid">
                    <jsp:include page="subgrid.jsp"></jsp:include>
                </div>
            </div>

        </div>
    </div>
</td>

<!-- ================= RIGHT SIDE (GRID) ================= -->
<td valign="top">
    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            
            <table width="100%" id="grid1">
            <tr>
                <td>
                    <div id="fleetdiv">
                        <jsp:include page="detailsgrid.jsp"></jsp:include>
                    </div>
                </td>
            </tr>
            </table>

        </div>
    </div>
</td>

</tr>
</table>

</div>
</div>

<!-- HIDDEN FIELDS -->
<div style="display:none;">
    <input type="hidden" id="chkdatails" name="chkdatails" value='<s:property value="chkdatails"/>'>
    <input type="hidden" id="emptype" value='<s:property value="chkdatails"/>'>
    <input type="hidden" id="empname" value='<s:property value="chkdatails"/>'>
</div>

<!-- POPUPS -->
<div id="fleetwindow">
    <div></div><div></div>
</div>

</div>
</body>
</html>