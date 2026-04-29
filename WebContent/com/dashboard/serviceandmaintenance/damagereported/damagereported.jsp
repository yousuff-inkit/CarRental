<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<% String contextPath=request.getContextPath();%>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />
<style>
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
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif; /* UNIFORM FONT */
    background-color: #f4f7f9;
}

/* Sidebar */
.sidebar-filters {
    width: 330px;
    flex: 0 0 330px;
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

/* Flex 1 allows this middle section to scroll while keeping top and bottom fixed */
.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 20px 15px; 
}

/* New fixed bottom panel so buttons are always visible */
.sidebar-fixed-bottom {
    padding: 15px 20px;
    border-top: 1px solid #f0f4f8;
    background: #fff;
}

.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.label-cell {
    text-align: right;
    padding-right: 12px;
    font-size: 12px; /* Uniform 12px label */
    font-weight: 600;
    color: #4e5e71;
    width: 90px;
}

/* ===== UNIFORM 24px TEXT INPUTS ===== */
input[type="text"] {
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

/* ===== UNIFORM 24px SELECT DROPDOWNS (FIXED) ===== */
select {
    width: 100%;
    height: 24px !important;
    padding: 2px 24px 2px 8px !important; 
    border: 1px solid #ccd6e0 !important;
    border-radius: 4px !important;
    font-size: 12px !important;
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
    outline: none;
    font-family: inherit;
    cursor: pointer;
    
    appearance: none;
    -webkit-appearance: none;
    -moz-appearance: none;
    
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

/* ===== BUTTONS ===== */
.button-group {
    display: flex;
    gap: 10px;
    justify-content: center;
}

.btn-submit, .myButton {
    flex: 1;
    width: 100%;
    height: 30px !important;            /* Scaled button height */
    padding: 0 12px !important;
    background: #2563eb !important;
    color: #fff !important;
    border: none !important;
    border-radius: 4px !important;
    font-size: 13px !important;
    font-weight: 600 !important;
    cursor: pointer;
    line-height: 30px !important;
    white-space: nowrap;
    text-align: center;
    margin-top: 8px;
    transition: all 0.2s ease;
}

.btn-submit:hover, .myButton:hover {
    background: #1d4ed8 !important;
}

/* UPDATED DISABLED STATE: Faded blue, normal cursor, no red/grey */
.btn-submit:disabled, .myButton:disabled {
    background: #93c5fd !important; /* Lighter, faded blue */
    color: #ffffff !important;
    cursor: default !important; /* Standard arrow instead of banned cursor */
    opacity: 0.8;
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

/* =========================================================================
   GLOBAL OVERRIDE: Strips inherited green background from all external css 
========================================================================= */
.sidebar-filters label.branch, 
.sidebar-filters .filter-card label,
.sidebar-filters .branch {
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
    padding-left: 4px;
    background: transparent !important;
    background-color: transparent !important;
}
</style>
  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
    $('#attachmaintwindow').jqxWindow({ autoOpen: false,width: '55%', height: '50%',  maxHeight: '70%' ,maxWidth: '78%' , title: '' ,position: { x: 280, y: 120 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'});   
});

function funreload(event)
{
     var barchval = document.getElementById("cmbbranch").value;

      $("#damagediv").load("damagereportedgrid.jsp?barchval="+barchval);
      document.getElementById("fleetno").value="";
      document.getElementById("docno").value="";
      $('#attachbtn').attr("disabled",true); 
    
}
    
function funExportBtn(){
      // $("#damageGrid").jqxGrid('exportdata', 'xls', 'Damage Reported');
          $("#damagediv").excelexportjs({  
            containerid: "damagediv", 
            datatype: 'json', 
            dataset: null, 
            gridId: "damageGrid", 
            columns: getColumns("damageGrid") , 
            worksheetName:"Damage Reported"
            }); 
}
    
function funattachss(){
      var fleetno=document.getElementById("fleetno").value;
      var docno=document.getElementById("docno").value;
      $("#attachmaintwindow").jqxWindow('setTitle',"VIP - "+document.getElementById("docno").value);
      $('#attachmaintwindow').jqxWindow('setContent', '');
      $('#attachmaintwindow').jqxWindow('open');  
      inspSearchContent("newgrid.jsp?fleetno="+fleetno+"&docno="+docno);
}

function inspSearchContent(url) {
     //$('#vehiclewindow').jqxWindow('open'); 
     $('#attachmaintwindow').jqxWindow('focus'); 
     $.get(url).done(function (data) {
        $('#attachmaintwindow').jqxWindow('setContent', data);
    }); 
     
}

function findis()
{
    document.getElementById("fleetno").value="";
    document.getElementById("docno").value="";
    $('#attachbtn').attr("disabled",true); 
}

</script>
</head>
<body onload="getBranch();findis()">

<div id="mainBG" class="homeContent">
<div class="hidden-scrollbar">

<div class="master-container">

    <div class="sidebar-filters">

        <div class="sidebar-fixed-top">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>

        <div class="sidebar-scroll-content">
            <div class="filter-card">
                <div id="paychaaaaa"></div>
            </div>
            
            <div class="button-group" style="margin-top: 15px;">
                <button type="button"
                        id="attachbtn"
                        class="myButton"
                        onclick="funattachss();"
                        style="margin-top:0;">
                    Attach
                </button>
            </div>
            
        </div>
        
    </div>

    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="damagediv">
                <jsp:include page="damagereportedgrid.jsp"></jsp:include>
            </div>
        </div>
    </div>

</div>

<input type="hidden" id="fleetno" name="fleetno">
<input type="hidden" id="docno" name="docno">

<div id="attachmaintwindow">
    <div></div>
</div>

</div>
</div>
</body>
</html>