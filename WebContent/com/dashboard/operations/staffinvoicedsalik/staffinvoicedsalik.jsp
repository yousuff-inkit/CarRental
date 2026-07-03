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
/* ===== AGGRESSIVE OVERRIDES TO DESTROY BLUE BACKGROUNDS & HOVERS ===== */
html, body, #mainBG, .homeContent, .hidden-scrollbar {
    height: 100%;
    margin: 0 !important;
    padding: 0 !important;
    overflow: hidden !important;
    background-color: #ffffff !important;
    background: #ffffff !important;
    background-image: none !important;
}

/* Force layout tables to white */
.master-layout-table, 
.master-layout-table > tbody > tr, 
.master-layout-table > tbody > tr > td {
    background-color: #ffffff !important;
    background: #ffffff !important;
}

/* Forcefully kill all hover states on tables applied by external CSS */
table tr:hover, 
table td:hover, 
table th:hover, 
tbody tr:hover {
    background-color: transparent !important;
    background: transparent !important;
}

/* ===== MASTER LAYOUT ===== */
.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    background-color: #ffffff !important; 
    margin: 0 !important;
    padding: 0 !important;
}

/* Sidebar */
.sidebar-filters {
    width: 330px;
    flex: 0 0 330px;
    background: #ffffff !important;
    display: flex;
    flex-direction: column;
    height: 100vh;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
}

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 20px; 
}

/* Cards */
.filter-card {
    background: #f8fafc !important;
    border: 1px solid #e3e8ee;
    border-radius: 8px;
    padding: 15px; 
    margin-bottom: 12px;
}

/* Tables within the card */
.filter-table {
    width: 100%;
    border-spacing: 0 10px; 
    background: transparent !important;
}

.filter-table tr, .filter-table td {
    background: transparent !important;
    border: none !important;
}

.filter-table .label-cell {
    text-align: right;
    padding-right: 12px;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    width: 80px;
    white-space: nowrap; 
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
    background-color: #ffffff !important;
    box-sizing: border-box;
    color: #333;
    outline: none;
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

input[readonly], input:disabled, select:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    cursor: not-allowed;
}

/* Checkbox & Radio Alignment */
input[type="radio"], input[type="checkbox"] {
    margin: 0 4px 0 0;
    vertical-align: middle;
}

.radio-group {
    display: flex;
    justify-content: flex-start;
    gap: 15px;
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
}

.radio-group label {
    display: flex;
    align-items: center;
    cursor: pointer;
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
    font-size: 13px !important;
    font-weight: 600 !important;
    cursor: pointer;
    line-height: 30px !important;       
    text-align: center;
    transition: background 0.2s;
    width: 100%;
}

.btn-submit:hover {
    background: #1d4ed8 !important;
}
</style>

<script type="text/javascript">
$(document).ready(function () {
    $('#loadsalikdata').hide();
    $('#loadtrafficdata').hide();
    
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

    $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%', maxHeight: '75%', maxWidth: '50%', title: 'Account Search', position: { x: 150, y: 60 }, keyboardCloseKey: 27});
    $('#accountSearchwindow').jqxWindow('close');
    
    // Standardized height to 24px and width to 100%
    $("#fromdate, #todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    
    var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));
    var onemounth = new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
    $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
    
    $('#todate').on('change', function (event) {
        var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));
        var todates = new Date($('#todate').jqxDateTimeInput('getDate')); 
        if(fromdates > todates){
            $.messager.alert('Message','To Date Less Than From Date','warning');   
            return false;
        }   
    });
});

// Targeted function to populate the native dropdown inside heading.jsp
function getBranch() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim().split('####');
            if (items.length > 1) {
                var brchIdItems = items[0].split(",");
                var brchItems = items[1].split(",");
                var optionsbrch = '<option value="">--Select--</option>';
                for (var i = 0; i < brchItems.length; i++) {
                    optionsbrch += '<option value="' + brchIdItems[i] + '">' + brchItems[i] + '</option>';
                }
                $("select#cmbbranch").html(optionsbrch);
            }
        }
    }
    x.open("GET", "getBranch.jsp", true);
    x.send();
}

function funreload(event) {
    var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));
    var todates = new Date($('#todate').jqxDateTimeInput('getDate')); 
    
    if(fromdates > todates){
        $.messager.alert('Message','To Date Less Than From Date','warning');   
        return false;
    }
    
    if (!(document.getElementById('radio_salik').checked || document.getElementById('radio_traffic').checked)) {
        $.messager.alert('Message','Select Salik / Traffic','warning');
        return false;
    } else {
        var barchval = document.getElementById("cmbbranch").value;
        var fromdate = $("#fromdate").val();
        var todate = $("#todate").val();
        var satcateg;
        
        if (document.getElementById('radio_salik').checked) {
            satcateg = $("#radio_salik").val();
            $("#overlay, #PleaseWait").show();
            $("#loadsalikdata").load("invoicesalicGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&satcateg="+satcateg);
        } else if (document.getElementById('radio_traffic').checked) {
            satcateg = $("#radio_traffic").val();
            $("#overlay, #PleaseWait").show();
            $("#loadtrafficdata").load("invoicetrafficGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&satcateg="+satcateg);
        }
    }
}

function load(){
    $('#loadsalikdata').show();
}

function fundisable(){
    if (document.getElementById('radio_salik').checked) {
        $('#loadsalikdata').show();
        $('#loadtrafficdata').hide();
        $('#loadinvoicesalicgrid').hide();
    } else if (document.getElementById('radio_traffic').checked) {
        $('#loadsalikdata').hide();
        $('#loadtrafficdata').show();
        $('#loadinvoicesalicgrid').hide();
    }
}

function funExportBtn(){
    if(document.getElementById("radio_salik").checked == true){
        JSONToCSVCon(salicexcel, 'Staff Salik', true);
    } else if(document.getElementById("radio_traffic").checked == true){
        JSONToCSVCon(trafficexcel, 'Staff Traffic', true);
    }
} 
</script>
</head>
<body onload="getBranch();load();">

<form id="frmStaffSalikList" method="post">

<div id="mainBG" class="homeContent">
<div class="hidden-scrollbar">

<table class="master-layout-table" width="100%" height="100%" cellpadding="0" cellspacing="0" border="0" style="background-color: #ffffff !important;">
<tr>

<td width="330px" valign="top" style="vertical-align: top; padding: 0 !important; margin: 0 !important; background: #ffffff !important; border-right: 1px solid #e1e8ed;">
    <div class="master-container">
        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">
                
                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">From</td>
                            <td>
                                <div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">To</td>
                            <td>
                                <div id="todate" name="todate" value='<s:property value="todate"/>'></div>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell" style="vertical-align: middle;">Category</td>
                            <td>
                                <div class="radio-group">
                                    <label>
                                        <input type="radio" checked="checked" id="radio_salik" name="category" value="salik" onchange="fundisable();">
                                        Salik
                                    </label>
                                    <label>
                                        <input type="radio" id="radio_traffic" name="category" value="radio_traffic" onchange="fundisable();">
                                        Traffic
                                    </label>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>

                <div style="display:none;">
                    <input type="hidden" id="acno" name="acno" value='<s:property value="acno"/>'>
                </div>

            </div>
        </div>
    </div>
</td>

<td class="right-panel" valign="top" style="padding: 15px; background: #ffffff !important;">
    
    <div style="width: 100%; margin-bottom: 10px;">
        <jsp:include page="../../heading.jsp"></jsp:include>
    </div>

    <table width="100%" cellpadding="0" cellspacing="0" border="0" style="background: transparent !important;">
        <tr>
             <td valign="top" style="background: transparent !important;">
                 <div id="loadsalikdata">
                     <jsp:include page="invoicesalicGrid.jsp"></jsp:include>
                 </div>

                 <div id="loadtrafficdata">
                     <jsp:include page="invoicetrafficGrid.jsp"></jsp:include>
                 </div>
             </td>
        </tr>
    </table>

</td>

</tr>
</table>

</div>
</div>

<div id="accountSearchwindow">
    <div></div>
</div>

</form>
</body>
</html>