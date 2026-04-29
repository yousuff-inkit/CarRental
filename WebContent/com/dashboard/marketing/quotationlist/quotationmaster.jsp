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
     $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

     // Standardized height to 24px
     $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
     $("#todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
     
     var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
     var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
     
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
     
     $('#todate').on('change', function (event) {
           var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
           var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
           if(fromdates>todates){
               $.messager.alert('Message','To Date Less Than From Date','warning');   
               return false;
          }    
     });
});

function funExportBtn(){
       $("#qutlistgrid").jqxGrid('exportdata', 'xls', 'Quotation List');
}

function funreload(event)
{
    var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
    var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
    
    if(fromdates>todates){
        $.messager.alert('Message','To Date Less Than From Date','warning');   
        return false;
    } 
    else {
        var barchval = document.getElementById("cmbbranch").value;
        var fromdate= $("#fromdate").val();
        var todate= $("#todate").val();
        $("#overlay, #PleaseWait").show();
        $("#qutlistdiv").load("quotationlistGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate);
        $("#Readygrid").load("subgrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate);
    }
}
</script>
</head>

<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<div class="master-container">

    <div class="sidebar-filters">
        
        <div class="sidebar-fixed-top">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>

        <div class="sidebar-scroll-content">
            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">From Date</td>
                        <td><div id='fromdate'></div></td>
                    </tr> 
                    <tr>
                        <td class="label-cell">To Date</td>
                        <td><div id='todate'></div></td>
                    </tr>
                </table>
            </div>

            <div class="filter-card">
                <div id="Readygrid">
                    <jsp:include page="subgrid.jsp"></jsp:include>
                </div>
            </div>

            <div class="filter-card">
                <div id='paychaaaaa' style="width: 100%; height: 170px;"></div>
            </div>   
        </div>
    </div>

    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="qutlistdiv">
                <jsp:include page="quotationlistGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>

</div>
</div>
</div>
</body>
</html>