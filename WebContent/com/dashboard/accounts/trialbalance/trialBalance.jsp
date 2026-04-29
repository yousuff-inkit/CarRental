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
}

.btn-submit:hover, .myButton:hover {
    background: #1d4ed8 !important;
}

.btn-submit:disabled, .myButton:disabled {
    background: #9ca3af !important;
    cursor: not-allowed;
}

/* Layout Utilities */
.main-content-wrapper {
    flex: 1;
    width: 100%;
    display: flex;
    flex-direction: column;
    padding: 15px;
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

<script type="text/javascript">

    $(document).ready(function () {
         // STANDARD HEIGHT SET TO 24px AND WIDTH 100%
         $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
         $("#todate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
        
         $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
         $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

         var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
         var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
         var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
         $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
         
         $("#trialDiv").hide();
         document.getElementById("hidchckincludingzero").value=0;
         getTrialBalancePrintConfig();
    });
    
    function getTrialBalancePrintConfig(){
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                
                if(parseInt(items)==1){
                     $("#btnprint").show();
                 } else {
                     $("#btnprint").hide();
                 }
        }
        }
        x.open("GET", "getTrialBalancePrintConfig.jsp", true);
        x.send();
    }
    
    function funExportBtn(){
        $("#trialBalanceDiv").excelexportjs({
            containerid: "trialBalanceDiv",
            datatype: 'json',
            dataset: null,
            gridId: "trialBalance",
            columns: getColumns("trialBalance") ,
            worksheetName:"Trial Balance"
        });
    }
    
    function includingzerocheck(){
         if(document.getElementById("chckincludingzero").checked){
             document.getElementById("hidchckincludingzero").value = 1;
         }
         else{
             document.getElementById("hidchckincludingzero").value = 0;
         }
     }
    
    function funreload(event){
         var branchval = document.getElementById("cmbbranch").value;
         var fromdate = $('#fromdate').val();
         var todate = $('#todate').val();
         var acctype = $('#cmbtype').val();
         var includingzero = $('#hidchckincludingzero').val(); 
        
         $("#overlay, #PleaseWait").show();
        
         $("#trialBalanceDiv").load("trialBalanceGrid.jsp?barchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&acctype='+acctype+'&includingzero='+includingzero+'&check=1');
        }

    function funPrint(){
         var branchval = document.getElementById("cmbbranch").value;
         var fromdate = $('#fromdate').val();
         var todate = $('#todate').val();
         var acctype = $('#cmbtype').val();
         var includingzero = $('#hidchckincludingzero').val(); 
         var url=document.URL;
         var reurl=url.split("com/");
         var path= "/com/dashboard/accounts/trialbalance/trialbalancelist.action?barchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&acctype='+acctype+'&includingzero='+includingzero+'&check=1';
         var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");      
         win.focus();       
    }
    function disableprint() {
        $('#btnprint').attr("disabled",true);
    }
    
</script>
</head>
<body onload="getBranch();disableprint();">
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
                        <td colspan="2">
                            <div style="display: flex; align-items: center; gap: 5px;">
                                <input type="checkbox"
                                       id="chckincludingzero"
                                       name="chckincludingzero"
                                       onchange="includingzerocheck();"
                                       onclick="$(this).attr('value', this.checked ? 1 : 0)"
                                       style="margin:0;">
                                <label class="branch" style="margin:0;">Including Zero</label>
                            </div>

                            <input type="hidden"
                                   id="hidchckincludingzero"
                                   name="hidchckincludingzero"
                                   value='<s:property value="hidchckincludingzero"/>'>
                        </td>
                    </tr>

                    <tr>
                        <td class="label-cell">Type</td>
                        <td>
                            <select id="cmbtype"
                                    name="cmbtype"
                                    value='<s:property value="cmbtype"/>'>
                                <option value="">All</option>
                                <option value="AP">AP</option>
                                <option value="AR">AR</option>
                                <option value="GL">GL</option>
                                <option value="HR">HR</option>
                            </select>
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <div class="sidebar-fixed-bottom">
            <div class="button-group" style="margin: 0;">
                <button type="button"
                        class="myButton"
                        id="btnprint"
                        onclick="funPrint();"
                        style="margin-top:0;">
                    Print
                </button>
            </div>
        </div>

    </div>

    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="trialBalanceDiv">
                <jsp:include page="trialBalanceGrid.jsp"></jsp:include>
            </div>
            
            <div id="trialDiv" hidden="true" style="margin-top: 15px;">
                <table width="100%">
                <tr>
                    <td align="right">
                        <input type="text"
                               class="textbox"
                               id="txtnetamount"
                               name="txtnetamount"
                               style="text-align:right; width: 150px;"
                               value='<s:property value="txtnetamount"/>'>
                    </td>
                </tr>
                </table>
            </div>
            
        </div>
    </div>

</div>
</div>
</div>
</body>
</html>