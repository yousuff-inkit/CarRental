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
    font-size: 12px; /* Uniform 12px label */
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

/* Strips inherited green background */
.sidebar-filters label.branch, 
.sidebar-filters .filter-card label,
.sidebar-filters .branch {
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
    background: transparent !important;
}
</style>

<script type="text/javascript">
$(document).ready(function () {
     // UPDATED: Standardized height to 24px and width to 100%
     $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
     $("#todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
     
     $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
     
     $('#clientDetailsWindow').jqxWindow({ width: '20%', height: '60%', maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#clientDetailsWindow').jqxWindow('close');
    
     $('#agreementDetailsWindow').jqxWindow({width: '51%', height: '58%', maxHeight: '70%' ,maxWidth: '51%' , title: 'Agreement Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
     $('#agreementDetailsWindow').jqxWindow('close');
     
     var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
     var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
    
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
     
     $('#todate').on('change', function (event) {
           var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
           var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
           if(fromdates>todates){
               $.messager.alert('Message','To Date Less Than From Date ','warning');   
               return false;
          }    
     });
    
     $('#txtclientname').dblclick(function(){
          clientSearchContent('clientDetailsSearchGrid.jsp');
     });
      
     $('#vocnos').dblclick(function(){
          var branchval = document.getElementById("cmbbranch").value; 
          agreementSearchContent('agreementDetailsSearch.jsp?branchval='+branchval); 
     });
});

function clientSearchContent(url) {
    $('#clientDetailsWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#clientDetailsWindow').jqxWindow('setContent', data);
        $('#clientDetailsWindow').jqxWindow('bringToFront');
    }); 
}

function agreementSearchContent(url) {
    $('#agreementDetailsWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#agreementDetailsWindow').jqxWindow('setContent', data);
        $('#agreementDetailsWindow').jqxWindow('bringToFront');
    }); 
}

function getClient(event){
    var x= event.keyCode;
    if(x==114){
        clientSearchContent('clientDetailsSearchGrid.jsp');
    }
}

function getAgreement(event){
    var x= event.keyCode;
    if(x==114){
        var branchval = document.getElementById("cmbbranch").value; 
        agreementSearchContent('agreementDetailsSearch.jsp?branchval='+branchval);
    }
}

function funClearData(){
     $('#txtclientname').val('');$('#txtcldocno').val('');$('#rentaltype').val('');$('#txtagreementno').val('');$('#vocnos').val('');$('#todate').val(new Date());$('#clstatuss').val('');
     var onemounth=new Date(new Date((new Date())).setMonth(new Date().getMonth()-1)); 
     $('#fromdate').val(onemounth);
     $('#todate').val(new Date());
     
     if (document.getElementById("txtclientname").value == "") {
         $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
     }
     if (document.getElementById("vocnos").value == "") {
         $('#vocnos').attr('placeholder', 'Press F3 to Search'); 
     }
}

function funreload(event){
     var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
     var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
     
     if(fromdates>todates){
         $.messager.alert('Message','To Date Less Than From Date ','warning');   
         return false;
     } else {
         var branchval = document.getElementById("cmbbranch").value;
         var fromdate = $('#fromdate').val();
         var todate = $('#todate').val();
         var cldocno = $('#txtcldocno').val();
         var agmtno = $('#txtagreementno').val();
         
         $("#overlay, #PleaseWait").show();
         $("#masterDiv").load("detailsGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&cldocno='+cldocno+'&agmtno='+agmtno);
     }
}

function chktype() { }

function clearagno(){
    $('#txtagreementno').val('');
    $('#vocnos').val('');
}

function funExportBtn(){
      $("#detailsgrid").jqxGrid('exportdata', 'xls', 'Drivers Remove');
}
</script>
</head>
<body onload="getBranch();">

<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar">
<div class="master-container">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr>

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
                        <td>
                            <div id="fromdate" value='<s:property value="fromdate"/>'></div>
                        </td>
                    </tr>

                    <tr>
                        <td class="label-cell">To</td>
                        <td>
                            <div id="todate" value='<s:property value="todate"/>'></div>
                        </td>
                    </tr>

                    <tr>
                        <td class="label-cell">Client</td>
                        <td>
                            <input type="text"
                                   id="txtclientname"
                                   readonly
                                   placeholder="Press F3 to Search"
                                   onkeydown="getClient(event);"
                                   value='<s:property value="txtclientname"/>'>

                            <input type="hidden"
                                   id="txtcldocno"
                                   value='<s:property value="txtcldocno"/>'>
                        </td>
                    </tr>

                    <tr>
                        <td class="label-cell">Agreement</td>
                        <td>
                            <input type="text"
                                   id="vocnos"
                                   readonly
                                   placeholder="Press F3 to Search"
                                   onfocus="chktype();"
                                   ondblclick="funSearchdblclick();"
                                   onkeydown="getAgreement(event);"
                                   value='<s:property value="vocnos"/>'>

                            <input type="hidden"
                                   id="txtagreementno"
                                   value='<s:property value="txtagreementno"/>'>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="button-group">
                <button type="button"
                        class="btn-submit"
                        onclick="funClearData();">
                    Clear
                </button>
            </div>
        </div>
    </div>
</td>

<td valign="top">
    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="masterDiv">
                <jsp:include page="detailsGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>
</td>

</tr>
</table>

</div>
</div>

<div id="clientDetailsWindow"><div></div><div></div></div>
<div id="agreementDetailsWindow"><div></div><div></div></div>

</div>
</body>
</html>