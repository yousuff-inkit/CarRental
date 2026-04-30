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
    width: 90px;
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

/* ===== BUTTONS ===== */
.btn-submit {
    width: 100%;
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
    white-space: nowrap;
    text-align: center;
    margin-top: 8px;
    transition: all 0.2s ease;
}

.btn-submit:hover {
    background: #1d4ed8 !important;
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

/* Value block adjustments */
.value-block {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    margin-top: 15px;
    gap: 10px;
    font-family: 'Segoe UI', Tahoma, sans-serif;
    font-size: 13px;
    font-weight: 600;
    color: #4e5e71;
}
</style>

<script type="text/javascript">
$(document).ready(function () {
     // Standardized height to 24px and width to 100%
     $("#fromdate, #todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
     
     $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
     
     $('#clientwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#clientwindow').jqxWindow('close');
       
     var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
     $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
     
     $('#clientname').dblclick(function(){
        $('#clientwindow').jqxWindow('open');
        clientSearchContent('clientsearch.jsp', $('#clientwindow')); 
     });
});

function getclinfo(event){
     var x= event.keyCode;
    if(x==114){
        $('#clientwindow').jqxWindow('open');
        clientSearchContent('clientsearch.jsp', $('#clientwindow'));    
    }
} 

function clientSearchContent(url) {
    $.get(url).done(function (data) {
        $('#clientwindow').jqxWindow('open');
        $('#clientwindow').jqxWindow('setContent', data);
    }); 
}

function funExportBtn() {
    $("#collectionClosureDiv").excelexportjs({
        containerid: "collectionClosureDiv", 
        datatype: 'json', 
        dataset: null, 
        gridId: "collectionClosure", 
        columns: getColumns("collectionClosure") ,   
        worksheetName:"Collection Closure"
    });
}

function funreload(event){
     var branchval = document.getElementById("cmbbranch").value;
     var fromdate = $('#fromdate').val();
     var todate = $('#todate').val();
     var cldocno = $('#cldocno').val();
     var cmbpayedas = $('#cmbpayedas').val();
     var cmbstat = $('#cmbstat').val();
    
     $("#overlay, #PleaseWait").show();      
    
     $("#collectionClosureDiv").load("collectionClosureGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&cldocno='+cldocno+'&payas='+cmbpayedas+'&status='+cmbstat);
}

function funPrintCollectionClosure(){
    var url=document.URL;
    var reurl=url.split("collectionClosure.jsp");
    var win= window.open(reurl[0]+"printCollectionClosure?branch="+document.getElementById("cmbbranch").value+'&fromdate='+document.getElementById("fromdate").value+'&todate='+$("#todate").val()+'&netamount='+document.getElementById("txtnetamount").value,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
    win.focus();
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
                        <td class="label-cell">Period</td>
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
                        <td class="label-cell">Client</td>
                        <td>
                            <input type="text" id="clientname" name="clientname" 
                                   placeholder="Press F3 To Search" readonly="readonly" 
                                   onkeydown="getclinfo(event);" 
                                   value='<s:property value="clientname"/>'>
                            <input type="hidden" id="cldocno" name="cldocno" value='<s:property value="cldocno"/>'>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Paid As</td>
                        <td>
                            <select id="cmbpayedas" name="cmbpayedas">
                                <option value="">--Select--</option>
                                <option value="1">On Account</option>
                                <option value="2">Advance</option>
                                <option value="3">Security</option>
                            </select>
                            <input type="hidden" id="hidcmbpayedas" name="hidcmbpayedas" value='<s:property value="hidcmbpayedas"/>'>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Status</td>
                        <td>
                            <select id="cmbstat" name="cmbstat">
                                <option value="">--Select--</option>
                                <option value="1">Posted</option>
                                <option value="2">Not Posted</option>
                            </select>
                            <input type="hidden" id="hidcmbstat" name="hidcmbstat" value='<s:property value="hidcmbstat"/>'>
                        </td>
                    </tr>
                </table>
            </div>

            <button class="btn-submit" type="button" id="btnPrintCollectionClosure" onclick="funPrintCollectionClosure(event);">
                Print
            </button>
        </div>
    </div>
</td>

<!-- ================= RIGHT SIDE (GRIDS) ================= -->
<td valign="top">
    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            
            <div id="collectionClosureDiv">
                <jsp:include page="collectionClosureGrid.jsp"></jsp:include>
            </div>

            <div class="value-block">
                <label>Net Amount :</label>
                <input type="text" id="txtnetamount" name="txtnetamount" 
                       style="width:150px; text-align:right;" 
                       readonly
                       value='<s:property value="txtnetamount"/>'>
            </div>
            
        </div>
    </div>
</td>

</tr>
</table>

</div>
</div>

<!-- POPUPS -->
<div id="clientwindow"><div></div></div>

</div>
</body>
</html>