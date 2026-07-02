<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
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
    margin-bottom: 12px;
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
    width: 90px;
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
}

select {
    padding-right: 24px; 
    cursor: pointer;
    appearance: none;
    -webkit-appearance: none;
    background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%234e5e71' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
    background-repeat: no-repeat;
    background-position: right 6px center;
    background-size: 12px;
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

.btn-submit:hover { background: #1d4ed8; }

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
}

/* Fix for jqx widget overrides */
.jqx-widget input, .jqx-widget select {
    height: 24px !important;
    line-height: 24px !important;
}
</style>

<script type="text/javascript">
$(document).ready(function () {
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    
    // Standardized height to 24px and width to 100%
    $("#uptodate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    
    // Note: jqxWindow requires two nested divs to function correctly
    $('#clientcatwindow').jqxWindow({ width: '25%', height: '55%', maxHeight: '85%' ,maxWidth: '40%' , title: 'Client Category Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#clientcatwindow').jqxWindow('close');   
    
    $('#clientcat').dblclick(function(){
        $('#clientcatwindow').jqxWindow('open');
        $('#clientcatwindow').jqxWindow('focus');
        clientCatSearchContent('clientCatSearchGrid.jsp?id=1', $('#clientcatwindow'));
    });
    
    $('#btnclear').click(function(){
        $('#uptodate').jqxDateTimeInput('setDate',new Date());
        $('#clientcat,#hidclientcat,#rentalstatus').val('');
        $('#rentaltype').val('RAG');
        $('#followup').jqxGrid('clear');
    }); 
});

function getClientCat(event){
    var x = event.keyCode;
    if(x == 114){
        $('#clientcatwindow').jqxWindow('open');
        $('#clientcatwindow').jqxWindow('focus');
        clientCatSearchContent('clientCatSearchGrid.jsp?id=1', $('#clientcatwindow'));
    }
}

function clientCatSearchContent(url) {
    $.get(url).done(function (data) {
        $('#clientcatwindow').jqxWindow('setContent', data);
    }); 
}

function funreload(event) {
     var barchval = document.getElementById("cmbbranch").value;
     var rentaltype = document.getElementById("rentaltype").value;
     var rentalstatus = document.getElementById("rentalstatus").value;
     var uptodate = $('#uptodate').jqxDateTimeInput('val');
     var clientcat = $('#hidclientcat').val();
     
     $("#overlay, #PleaseWait").show();
     $("#cradfwdiv").load("cardfollowupGrid.jsp?barchval="+barchval+'&uptodate='+uptodate+'&type='+rentaltype+'&check=1&rentalstatus='+rentalstatus+'&clientcat='+clientcat);
}

function funExportBtn(){
     if(parseInt(window.parent.chkexportdata.value) == "1") {
        JSONToCSVCon(exceldata, 'Card Block Followup', true);
     } else {
         $("#followup").jqxGrid('exportdata', 'xls', 'Card Block Followup');
     }
}
</script>
</head>

<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
    
    <div class="master-container">

        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">
                
                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">Upto Date</td>
                            <td><div id="uptodate" name="uptodate"></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Client Category</td>
                            <td>
                                <input type="text" readonly id="clientcat" name="clientcat" 
                                       value='<s:property value="clientcat"/>' 
                                       onkeydown="getClientCat(event);" 
                                       placeholder="Press F3 to Search">
                                <input type="hidden" readonly id="hidclientcat" name="hidclientcat" value='<s:property value="hidclientcat"/>' >
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Rental Type</td>
                            <td>
                                <select id="rentaltype" name="rentaltype" value='<s:property value="rentaltype"/>'>
                                    <option value="RAG">Rental</option>
                                    <option value="LAG">Lease</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Rental Status</td>
                            <td>
                                <select id="rentalstatus" name="rentalstatus" value='<s:property value="rentalstatus"/>'>
                                    <option value="">All</option>
                                    <option value="0">Opened</option>
                                    <option value="1">Closed</option>
                                </select>
                            </td>
                        </tr>
                    </table>
                    
                    <button type="button" id="btnclear" name="btnclear" class="btn-submit">Clear</button>
                </div>

                <div id='pieChart1' style="width: 100%; height: 170px; margin-top: 10px;"></div>

            </div>
        </div>

        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="cradfwdiv">
                    <jsp:include page="cardfollowupGrid.jsp"></jsp:include>
                </div>
            </div>

        </div>

    </div>

    <div id="clientcatwindow">
        <div></div><div></div>
    </div>

</div>
</body>
</html>