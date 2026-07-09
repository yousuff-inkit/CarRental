<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

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
    margin-bottom: 12px;
}

/* Tables inside Cards */
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
    height: 24px !important;              
    padding: 2px 8px !important;          
    border: 1px solid #ccd6e0 !important;
    border-radius: 4px !important;        
    font-size: 12px !important;          
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
    outline: none;
}

/* Readonly / disabled look */
input[readonly], input:disabled, 
.filter-table input[readonly], 
.filter-table input:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed !important;
    cursor: default;
}

/* Checkbox & Input with Icon */
input[type="checkbox"] { margin: 0; cursor: pointer; width: 14px; height: 14px; vertical-align: middle; }
.input-with-icon { display: flex; align-items: center; gap: 4px; }
.btn-icon { background: #e1e8ed; border: 1px solid #ccd6e0; border-radius: 4px; cursor: pointer; padding: 0; height: 24px; width: 24px; display: flex; align-items: center; justify-content: center; }

/* jqx date/time containers */
#fromdate, #todate {
    width: 100%;
}

/* ===== BUTTONS ===== */
.btn-submit {
    flex: 1;
    height: 30px !important;            
    padding: 0 12px !important;          
    background: #2563eb !important;
    color: #fff !important;
    border: none !important;
    border-radius: 4px !important;      
    font-size: 12px !important;
    font-weight: 600 !important;
    cursor: pointer;
    line-height: 30px !important;        
    transition: background 0.2s;
    text-align: center;
    width: 100%;
}

.btn-submit:hover { background: #1d4ed8 !important; }

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

.grid-content-container {
    flex: 1;
    padding: 15px;
    overflow: auto;
    box-sizing: border-box;
    position: relative;
}

#PleaseWait {
    position: absolute !important;
    z-index: 1002;
    top: 50% !important;
    left: 50% !important;
    transform: translate(-50%, -50%);
}
</style>

<script type="text/javascript">
$(document).ready(function () {
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;'><img src='../../../../icons/31load.gif'/></div>");
    
    // Standardize inputs
    $("#fromdate, #todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});

    $('#clientwindow').jqxWindow({ width: '62%', height: '65%', maxHeight: '85%' ,maxWidth: '80%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27, theme: 'energyblue'});
    $('#clientwindow').jqxWindow('close');

    $('#projectwindow').jqxWindow({ width: '50%', height: '65%', maxHeight: '65%' ,maxWidth: '65%' , title: 'Project Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27, theme: 'energyblue'});
    $('#projectwindow').jqxWindow('close');

    $('#client').dblclick(function(){
        $('#clientwindow').jqxWindow('open');
        clientSearchContent('clientINgridsearch.jsp', $('#clientwindow'));
    });

    $('#project').dblclick(function(){
        $('#projectwindow').jqxWindow('open');
        projectSearchContent('projectSearchGrid.jsp?id=1');
    });
    
    var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));
    var onemounth = new Date(new Date(fromdates).setMonth(fromdates.getMonth() - 1));
    $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));

    $('#todate').on('change', function (event) {
        var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));
        var todates = new Date($('#todate').jqxDateTimeInput('getDate'));
        if (fromdates > todates) {
            $.messager.alert('Message','To Date Less Than From Date','warning');
            return false;
        }   
    });
});

function clientSearchContent(url) {
    $.get(url).done(function (data) {
        $('#clientwindow').jqxWindow('setContent', data);
    }); 
}

function projectSearchContent(url) {
    $.get(url).done(function (data) {
        $('#projectwindow').jqxWindow('setContent', data);
    }); 
}

function funreload(event) {
    var branchval = document.getElementById("cmbbranch").value;
    if(branchval.trim() == 'a'){
        $.messager.alert('Warning','Branch is Mandatory');
        return false;
    }
    
    var fromdate = $("#fromdate").val();
    var todate = $("#todate").val();
    
    $("#overlay, #PleaseWait").show();
    $("#Readygrid").load("subgrid.jsp?from="+encodeURIComponent(fromdate)+"&to="+encodeURIComponent(todate));
    $("#posgrid").load("subposting.jsp?from="+encodeURIComponent(fromdate)+"&to="+encodeURIComponent(todate));
    $("#fleetdiv").load("detailsgrid.jsp?branch="+branchval+"&from="+encodeURIComponent(fromdate)+"&to="+encodeURIComponent(todate));
}

function funExportBtn(){
    $("#fleetdiv").excelexportjs({
        containerid: "fleetdiv", 
        datatype: 'json', 
        dataset: null, 
        gridId: "jqxFleetGrid", 
        columns: getColumns("jqxFleetGrid"), 
        worksheetName: "Traffic Status"
    });
}
</script>
</head>

<body onload="getBranch();">
    <div id="mainBG" class="homeContent">
        <div class="master-container">

            <!-- ================= LEFT SIDEBAR ================= -->
            <div class="sidebar-filters">
                <div class="sidebar-scroll-content">
                    <div class="filter-card">
                        <table class="filter-table">
                            <tr>
                                <td class="label-cell">From</td>
                                <td><div id="fromdate"></div></td>
                            </tr>
                            <tr>
                                <td class="label-cell">To</td>
                                <td><div id="todate"></div></td>
                            </tr>
                            <tr>
                                <td class="label-cell">Ticket No</td>
                                <td><input type="text" id="ticketno" name="ticketno" placeholder="Press F3 to Search" readonly></td>
                            </tr>
                            <tr>
                                <td class="label-cell">Reg No</td>
                                <td><input type="text" id="regno" name="regno" placeholder="Press F3 to Search" readonly></td>
                            </tr>
                        </table>

                        <div class="action-buttons">
                            <button type="button" class="btn-submit" onclick="funreload()">Load</button>
                        </div>
                    </div>
                    
                    <!-- Nested Grids Area -->
                    <div id="Readygrid"></div>
                    <div id="posgrid" style="margin-top:10px;"></div>
                </div>
            </div>

            <!-- ================= RIGHT SIDE (MAIN CONTENT) ================= -->
            <div class="main-content-area">
                <div class="top-toolbar-container">
                    <jsp:include page="../../heading.jsp"></jsp:include>
                </div>
                
                <div class="grid-content-container">
                    <div id="fleetdiv">
                        <jsp:include page="detailsgrid.jsp"></jsp:include>
                    </div>
                </div>
            </div>
        </div>

        <!-- Hidden Fields & Popups -->
        <div style="display:none;">
            <input type="hidden" id="chkdatails" name="chkdatails">
        </div>
        <div id="clientwindow"><div></div></div>
        <div id="projectwindow"><div></div></div>
    </body>
</html>