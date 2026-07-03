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
    width: 85px;
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
    background-color: #fff !important;
    color: #555;
    cursor: pointer; /* Pointer because they are search lookups */
}

/* Checkbox & Radio Alignment */
input[type="radio"], input[type="checkbox"] {
    margin: 0 4px 0 0;
    vertical-align: middle;
}

.radio-group {
    display: flex;
    justify-content: center;
    gap: 15px;
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
    padding: 5px 0 10px 0;
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

/* Summary Box */
.summary-fieldset {
    border: 1px solid #e3e8ee;
    border-radius: 8px;
    padding: 10px;
    background: #f8fafc;
    margin-top: 15px;
}
.summary-fieldset table td {
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
    background: transparent !important;
}
</style>

<script type="text/javascript">
$(document).ready(function () {
    
    // Standardize all Search Popups
    const windowSettings = { width: '20%', height: '60%', maxHeight: '62%' ,maxWidth: '60%', position: { x: 250, y: 120 }, keyboardCloseKey: 27};
    $('#clientwindow, #groupwindow, #brandwindow, #modelwindow, #catwindow').jqxWindow(windowSettings).jqxWindow('close');
    $('#fleetwindow').jqxWindow({ ...windowSettings, width: '30%' }).jqxWindow('close');

    // Loading Overlays
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    
    document.getElementById('inchks').value=""; 
    document.getElementById('outchks').value="OUT"; 

    // Date Inputs
    $("#fromdate, #todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));
    var onemounth = new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
    $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));

    $('#todate').on('change', function (event) {
        var fromd = new Date($('#fromdate').jqxDateTimeInput('getDate'));
        var tod = new Date($('#todate').jqxDateTimeInput('getDate')); 
        if(fromd > tod){
            $.messager.alert('Message','To Date Less Than From Date','warning');   
            return false;
        }   
    });

    // Double Click Handlers
    $('#clientname').dblclick(function(){ $('#clientwindow').jqxWindow('open'); clientSearchContent('clientsearch.jsp?'); });
    $('#catname').dblclick(function(){ $('#catwindow').jqxWindow('open'); catnameSearchContent('categorysearch.jsp?'); });
    $('#fleet').dblclick(function(){ $('#fleetwindow').jqxWindow('open'); fleetSearchContent('fleetsearch.jsp?'); });
    $('#group').dblclick(function(){ $('#groupwindow').jqxWindow('open'); groupSearchContent('groupsearch.jsp?'); });
    $('#brand').dblclick(function(){ $('#brandwindow').jqxWindow('open'); brandSearchContent('brandsearch.jsp?'); });
    $('#model').dblclick(function(){ $('#modelwindow').jqxWindow('open'); modelSearchContent('modelsearch.jsp?'); });
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

function funExportBtn(){
    $("#detlist").excelexportjs({
        containerid: "detlist",
        datatype: 'json', 
        dataset: null, 
        gridId: "detailsgrid", 
        columns: getColumns("detailsgrid") , 
        worksheetName:"Agreement List"
    }); 
}

// Search Window Content Loaders
function catnameSearchContent(url) { $.get(url).done(function(data) { $('#catwindow').jqxWindow('setContent', data); }); }
function modelSearchContent(url)   { $.get(url).done(function(data) { $('#modelwindow').jqxWindow('setContent', data); }); }
function brandSearchContent(url)   { $.get(url).done(function(data) { $('#brandwindow').jqxWindow('setContent', data); }); }
function groupSearchContent(url)   { $.get(url).done(function(data) { $('#groupwindow').jqxWindow('setContent', data); }); }
function fleetSearchContent(url)   { $.get(url).done(function(data) { $('#fleetwindow').jqxWindow('setContent', data); }); }
function clientSearchContent(url)  { $.get(url).done(function(data) { $('#clientwindow').jqxWindow('setContent', data); }); }

// F3 Keydown handlers
function getclcat(event) { if(event.keyCode==114){ $('#catwindow').jqxWindow('open'); catnameSearchContent('categorysearch.jsp?'); } } 
function getmodel(event) { if(event.keyCode==114){ $('#modelwindow').jqxWindow('open'); modelSearchContent('modelsearch.jsp?'); } }
function getbrand(event) { if(event.keyCode==114){ $('#brandwindow').jqxWindow('open'); brandSearchContent('brandsearch.jsp?'); } } 
function getgroup(event) { if(event.keyCode==114){ $('#groupwindow').jqxWindow('open'); groupSearchContent('groupsearch.jsp?'); } } 
function getfleet(event) { if(event.keyCode==114){ $('#fleetwindow').jqxWindow('open'); fleetSearchContent('fleetsearch.jsp?'); } } 
function getclinfo(event){ if(event.keyCode==114){ $('#clientwindow').jqxWindow('open'); clientSearchContent('clientsearch.jsp?'); } } 

function funreload(event) {
    var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
    var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
    if(fromdates > todates){
        $.messager.alert('Message','To Date Less Than From Date','warning');   
        return false;
    } else {
        var barchval = document.getElementById("cmbbranch").value;
        var fromdate= $("#fromdate").val();
        var todate= $("#todate").val(); 
        $("#overlay, #PleaseWait").show();
        $("#detlist").load("detailsGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&cldocno="+document.getElementById("cldocno").value+"&group="+document.getElementById("groupdoc").value+"&model="+document.getElementById("modelid").value+"&brand="+document.getElementById("brandid").value+"&fleet="+document.getElementById("fleet").value+"&status="+document.getElementById("status").value+"&type="+$("#rentaltype").val()+'&outchk='+$("#outchks").val()+'&inchk='+$("#inchks").val()+'&catid='+$("#catid").val());
    }
}

function getrentaltype() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            var rentaltype  = items.split(",");
            var optionsrental = '<option value="" selected>-- Select -- </option>';
            for (var i = 0; i < rentaltype.length; i++) {
                optionsrental += '<option value="' + rentaltype[i].trim() + '">' + rentaltype[i] + '</option>';
            }
            $("select#rentaltype").html(optionsrental);
        }
    }
    x.open("GET","getrentaltypes.jsp", true);
    x.send();
}

function funcleardata() {
    document.getElementById("catid").value="";
    document.getElementById("cldocno").value="";
    document.getElementById("groupdoc").value="";
    document.getElementById("brandid").value="";
    document.getElementById("modelid").value="";
    document.getElementById("model").value="";
    document.getElementById("brand").value="";
    document.getElementById("group").value="";
    document.getElementById("fleet").value="";
    document.getElementById("clientname").value="";
    document.getElementById("rentaltype").value="";
    document.getElementById("status").value="";
    document.getElementById("catname").value="";
    
    if (document.getElementById("clientname").value == "") { $('#clientname').attr('placeholder', 'Press F3 TO Search'); }
    if (document.getElementById("model").value == "") { $('#model').attr('placeholder', 'Press F3 TO Search'); }
    if (document.getElementById("brand").value == "") { $('#brand').attr('placeholder', 'Press F3 TO Search'); }
    if (document.getElementById("group").value == "") { $('#group').attr('placeholder', 'Press F3 TO Search'); }
    if (document.getElementById("fleet").value == "") { $('#fleet').attr('placeholder', 'Press F3 TO Search'); }
    if (document.getElementById("catname").value == "") { $('#catname').attr('placeholder', 'Press F3 TO Search'); }
}

function funchkval(){
    if (document.getElementById('outchk').checked) {
        document.getElementById('inchks').value=""; 
        document.getElementById('outchks').value="OUT"; 
    } else if (document.getElementById('inchk').checked) {
        document.getElementById('inchks').value="IN"; 
        document.getElementById('outchks').value=""; 
    }
}
</script>

</head>
<body onload="getBranch();getrentaltype();">

<div id="mainBG" class="homeContent">
<div class="hidden-scrollbar">

<table class="master-layout-table" width="100%" height="100%" cellpadding="0" cellspacing="0" border="0" style="background-color: #ffffff !important;">
<tr>

<td width="330px" valign="top" style="vertical-align: top; padding: 0 !important; margin: 0 !important; background: #ffffff !important; border-right: 1px solid #e1e8ed;">
    <div class="master-container">
        <div class="sidebar-filters">
            
            <div class="sidebar-scroll-content">
                
                <div class="radio-group">
                    <label><input type="radio" name="chk" id="outchk" value="out" checked onchange="funchkval()"> Out Date</label>
                    <label><input type="radio" name="chk" id="inchk" value="in" onchange="funchkval()"> In Date</label>
                </div>

                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">From</td>
                            <td><div id="fromdate" name="fromdate"></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">To</td>
                            <td><div id="todate" name="todate"></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Status</td>
                            <td>
                                <select id="status" name="status">
                                    <option value="" selected>All</option>  
                                    <option value="0">Open</option>
                                    <option value="1">Close</option>  
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Client</td>
                            <td>
                                <input type="text" name="clientname" id="clientname" 
                                       placeholder="Press F3 TO Search" readonly 
                                       onKeyDown="getclinfo(event);" onclick="this.placeholder=''">
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Category</td>
                            <td>
                                <input type="text" name="catname" id="catname" 
                                       placeholder="Press F3 TO Search" readonly 
                                       onKeyDown="getclcat(event);" onclick="this.placeholder=''">
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Fleet</td>
                            <td>
                                <input type="text" name="fleet" id="fleet" 
                                       placeholder="Press F3 TO Search" readonly 
                                       onkeydown="getfleet(event)" onclick="this.placeholder=''">
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Group</td>
                            <td>
                                <input type="text" name="group" id="group" 
                                       placeholder="Press F3 TO Search" readonly 
                                       onkeydown="getgroup(event)" onclick="this.placeholder=''">
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Brand</td>
                            <td>
                                <input type="text" name="brand" id="brand" 
                                       placeholder="Press F3 TO Search" readonly 
                                       onkeydown="getbrand(event)" onclick="this.placeholder=''">
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Model</td>
                            <td>
                                <input type="text" name="model" id="model" 
                                       placeholder="Press F3 TO Search" readonly 
                                       onkeydown="getmodel(event)" onclick="this.placeholder=''">
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Type</td>
                            <td>
                                <select id="rentaltype" name="rentaltype"></select>
                            </td>
                        </tr>
                    </table>
                </div>

                <button type="button" class="btn-submit" name="clear" id="clear" onclick="funcleardata()">Clear Filters</button>

                <div class="summary-fieldset">
                    <table width="100%" style="background: transparent !important;">
                        <tr>
                            <td align="right" width="40%" style="padding-right:10px;">Rental</td>
                            <td><input type="text" name="rt" id="rt" readonly style="background-color: #FFEBEB !important; border: 1px solid #e3e8ee !important;"></td>
                        </tr>
                        <tr>
                            <td align="right" width="40%" style="padding-right:10px; padding-top:8px;">Lease</td>
                            <td style="padding-top:8px;"><input type="text" name="lt" id="lt" readonly style="background-color: #ffffff !important; border: 1px solid #e3e8ee !important;"></td>
                        </tr>
                    </table>
                </div>

                <div style="display:none;">
                    <input type="hidden" name="outchks" id="outchks">
                    <input type="hidden" name="inchks" id="inchks">
                    <input type="hidden" name="cldocno" id="cldocno">
                    <input type="hidden" name="groupdoc" id="groupdoc">
                    <input type="hidden" name="brandid" id="brandid">
                    <input type="hidden" name="modelid" id="modelid">
                    <input type="hidden" name="catid" id="catid">
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
                 <div id="detlist">
                     <jsp:include page="detailsGrid.jsp"></jsp:include>
                 </div>
             </td>
        </tr>
    </table>

</td>

</tr>
</table>

</div>
</div>

<div id="catwindow"><div></div></div>
<div id="clientwindow"><div></div></div>
<div id="fleetwindow"><div></div></div>
<div id="groupwindow"><div></div></div>
<div id="brandwindow"><div></div></div>
<div id="modelwindow"><div></div></div>

</body>
</html>