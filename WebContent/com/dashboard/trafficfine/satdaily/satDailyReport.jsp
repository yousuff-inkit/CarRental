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

/* ===== UNIFORM 24px TEXT INPUTS & SELECTS ===== */
input[type="text"], select, textarea {
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

textarea {
    height: auto !important;
    min-height: 45px;
    resize: vertical;
    line-height: 1.4;
}

select {
    padding: 2px 24px 2px 8px !important; 
    font-family: inherit;
    cursor: pointer;
    appearance: none;
    -webkit-appearance: none;
    background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%234e5e71' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
    background-repeat: no-repeat;
    background-position: right 6px center;
    background-size: 12px;
}

input[readonly], input:disabled, select:disabled, textarea[readonly] {
    background-color: #f3f6f9 !important;
    color: #555;
    cursor: pointer;
}

/* Inline Controls */
.inline-controls {
    display: flex;
    gap: 6px;
    align-items: center;
    width: 100%;
}

.btn-icon {
    background: #e1e8ed;
    border: 1px solid #ccd6e0;
    border-radius: 4px;
    cursor: pointer;
    padding: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    height: 24px;
    width: 28px;
    flex-shrink: 0;
    transition: background 0.2s;
    font-weight: bold;
    color: #4e5e71;
}

.btn-icon:hover { background: #cbd5e1; }

/* Radios */
input[type="radio"] {
    margin: 0;
    cursor: pointer;
    width: 14px;
    height: 14px;
    vertical-align: middle;
}

.radio-group {
    display: flex;
    justify-content: space-around;
    gap: 10px;
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
    padding: 5px 0;
}

.radio-group label {
    display: flex;
    align-items: center;
    cursor: pointer;
    gap: 5px;
}

.card-title {
    font-size: 13px;
    font-weight: bold;
    color: #2563eb;
    margin-bottom: 8px;
    padding-bottom: 4px;
    border-bottom: 1px solid #e3e8ee;
    text-transform: uppercase;
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
    // Standardize jqxDateTimeInputs
    $("#fromdate, #todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    
    $('#userwindow').jqxWindow({ width: '25%', height: '68%', maxHeight: '68%', maxWidth: '25%', title: 'Username Search', position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#userwindow').jqxWindow('close');
    
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    
    // Initialize Dates
    var curfromdate = $('#fromdate').jqxDateTimeInput('getDate');
    var oneyeardate = new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
    var oneyearbackdate = new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
    $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
    
    document.getElementById("rdticketdate").checked = true;
    document.getElementById("rdsalik").checked = true;
    fundisable();
    
    $('#username').dblclick(function(evt){
        var satcategory="";
        if (document.getElementById('rdsalik').checked==true) {
            satcategory="Salik";
        } else if (document.getElementById('rdtraffic').checked==true) {
            satcategory="Traffic";
        }
        var saliksource=$('#cmbsaliksource').val();
        $('#userwindow').jqxWindow('open');
        $('#userwindow').jqxWindow('focus');
        usernameSearchContent('usernameSearchGrid.jsp?satcategory='+satcategory+'&saliksource='+saliksource+'&id=1'); 
    });
});

function usernameSearchContent(url) {
    $.get(url).done(function (data) {
        $('#userwindow').jqxWindow('setContent', data);
    }); 
}

function getDailyCount(fromdate,todate,satcateg) {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function(){
        if (x.readyState == 4 && x.status == 200) {
            items = x.responseText;
            document.getElementById("searchdetails").value = items;
        }
    }
    x.open("GET",'getDailyCount.jsp?fromdate='+fromdate+'&todate='+todate+'&satcateg='+satcateg,true);
    x.send();
}

function funreload(event){
    var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));
    var todates = new Date($('#todate').jqxDateTimeInput('getDate')); 
    
    if(fromdates > todates){
        $.messager.alert('Message','To Date Less Than From Date ','warning');   
        return false;
    }
    
    if (!(document.getElementById('rdsalik').checked || document.getElementById('rdtraffic').checked)) {
        $.messager.alert('Message','Select Salik / Traffic','warning');
        return false;
    } else {
        var barchval = document.getElementById("cmbbranch").value;
        var fromdate = $("#fromdate").val();
        var todate = $("#todate").val();
        var check = 1;
        var satcateg = "";
        var datefilter = "";
        var saliksource = $('#cmbsaliksource').val();
        var username = $('#username').val();
        
        if (document.getElementById('rdticketdate').checked) {
            datefilter = "1";
        } else if (document.getElementById('rddownloaddate').checked) {
            datefilter = "2";
        }
        
        if (document.getElementById('rdsalik').checked) {
            satcateg = "salik";
            $("#overlay, #PleaseWait").show();
            $("#satSalikDiv").load("satSalikGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&satcateg=salik&datefilter="+datefilter+"&check="+check+"&saliksource="+saliksource+"&username="+username);
        } else if (document.getElementById('rdtraffic').checked) {
            satcateg = "traffic";
            $("#overlay, #PleaseWait").show();
            $("#satTrafficDiv").load("satTrafficGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&satcateg=traffic&datefilter="+datefilter+"&check="+check+"&username="+username);
        }
        
        $("#satCountDiv").load("satCountGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&satcateg="+satcateg+"&datefilter="+datefilter+"&check="+check+"&saliksource="+saliksource+"&userName="+username);
    }
}

function clearUserName(){
    $('#username').val('');
}
        
function funExportBtn(){
    if(parseInt(window.parent.chkexportdata.value)=="1") {
        if (document.getElementById('rdsalik').checked) {
            $("#satSalikDiv").excelexportjs({
                containerid: "satSalikDiv",
                datatype: 'json',
                dataset: null,
                gridId: "jqxloaddataGrid",
                columns: getColumns("jqxloaddataGrid"),
                worksheetName: "Salik Daily List"
            });
        } 
        if (document.getElementById('rdtraffic').checked) {
            $("#satTrafficDiv").excelexportjs({
                containerid: "satTrafficDiv",
                datatype: 'json',
                dataset: null,
                gridId: "jqxloadtrafficdataGrid",
                columns: getColumns("jqxloadtrafficdataGrid"),
                worksheetName: "Traffic Daily List"
            });
        }
    }
}
        
function fundisable(){
    if (document.getElementById('rdsalik').checked) {
        $('#satSalikDiv').show(); $('#satTrafficDiv').hide();
    } else if (document.getElementById('rdtraffic').checked) {
        $('#satSalikDiv').hide(); $('#satTrafficDiv').show();
    }
}

function funGetUsername(evt){
    if(evt.keyCode == 114){
        var satcategory = "";
        if (document.getElementById('rdsalik').checked) {
            satcategory = "Salik";
        } else if (document.getElementById('rdtraffic').checked) {
            satcategory = "Traffic";
        }
        var saliksource = $('#cmbsaliksource').val();
        $('#userwindow').jqxWindow('open');
        $('#userwindow').jqxWindow('focus');
        usernameSearchContent('usernameSearchGrid.jsp?satcategory='+satcategory+'&saliksource='+saliksource+'&id=1');
    }
}
</script>
</head>

<body onload="getBranch();">

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
                        <td class="label-cell">Salik Source</td>
                        <td>
                            <select id="cmbsaliksource" name="cmbsaliksource">
                                <option value="">All</option>
                                <option value="AUH">AUH</option>
                                <option value="DXB">DXB</option>
                            </select>
                        </td>
                    </tr>
                </table>
            </div>

            <!-- Report Type Settings -->
            <div class="filter-card">
                <div class="card-title">Report Type</div>
                
                <div class="radio-group" style="border-bottom: 1px dashed #ccd6e0; padding-bottom: 10px; margin-bottom: 5px;">
                    <label>
                        <input type="radio" id="rdticketdate" name="rddatefilter" value="rdticketdate">
                        Ticket Date
                    </label>
                    <label>
                        <input type="radio" id="rddownloaddate" name="rddatefilter" value="rddownloaddate">
                        Download Date
                    </label>
                </div>

                <div class="radio-group">
                    <label>
                        <input type="radio" id="rdsalik" name="rdcategory" value="rdsalik" onchange="fundisable();">
                        Salik
                    </label>
                    <label>
                        <input type="radio" id="rdtraffic" name="rdcategory" value="rdtraffic" onchange="fundisable();">
                        Traffic
                    </label>
                </div>
            </div>

            <!-- Search User -->
            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">User</td>
                        <td>
                            <div class="inline-controls">
                                <input type="text" id="username" name="username"
                                       placeholder="Press F3 to Search"
                                       onkeydown="funGetUsername(event);">
                                <button type="button" class="btn-icon" title="Clear" onclick="clearUserName()">X</button>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>

            <!-- Sub Grid Details Area -->
            <div style="margin-top: 15px;">
                <div id="satCountDiv">
                    <jsp:include page="satCountGrid.jsp"></jsp:include>
                </div>
            </div>

            <!-- Hidden Info Box -->
            <div style="display:none;">
                <textarea id="searchdetails" name="searchdetails" readonly></textarea>
            </div>

        </div>
    </div>
</td>

<!-- ================= RIGHT SIDE (GRIDS) ================= -->
<td valign="top">
    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            
            <div id="satSalikDiv">
                <jsp:include page="satSalikGrid.jsp"></jsp:include>
            </div>

            <div id="satTrafficDiv" style="display: none;">
                <jsp:include page="satTrafficGrid.jsp"></jsp:include>
            </div>

        </div>
    </div>
</td>

</tr>
</table>

</div>
</div>

<!-- POPUP -->
<div id="userwindow"><div></div></div>

</div>
</body>
</html>