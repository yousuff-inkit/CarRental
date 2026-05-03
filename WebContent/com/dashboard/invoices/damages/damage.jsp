<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
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

input[readonly], input:disabled, select:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    cursor: pointer;
}

/* ===== BUTTONS ===== */
.button-group {
    display: flex;
    gap: 8px;
    margin-top: 5px;
}

.btn-submit {
    flex: 1;
    height: 30px !important;            
    padding: 0 5px !important;
    background: #2563eb !important;
    color: #fff !important;
    border: none !important;
    border-radius: 4px !important;
    font-size: 12px !important;
    font-weight: 600 !important;
    cursor: pointer;
    line-height: 30px !important;
    text-align: center;
    transition: all 0.2s ease;
    width: 100%;
}

.btn-submit:hover { background: #1d4ed8 !important; }

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
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:200px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    $("#overlay, #PleaseWait").hide();
    
    // Standardize jqxDateTimeInput
    $("#periodupto").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    
    $('#periodupto').on('change', function (event) {  
        var docdateval = funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
        if(docdateval == 0){
            $('#periodupto').jqxDateTimeInput('focus');
            return false;
        }
    });
});

function funreload(event) {
    if(document.getElementById("cmbbranch").value == "" || document.getElementById("cmbbranch").value == 'a'){
        $.messager.alert('Warning','Select a single Branch');
        return false;
    } 
    var branchval = document.getElementById("cmbbranch").value;
    var docdateval = funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
    if(docdateval == 0){
        $('#periodupto').jqxDateTimeInput('focus');
        return false;
    }
    $("#damageinvoicediv").load("damageInvGrid.jsp?branchval=" + branchval);
}

function funNotify(){
    var docdateval = funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
    if(docdateval == 0){
        $('#periodupto').jqxDateTimeInput('focus');
        return false;
    }
    var z = 0;
    var rows = $("#damageInvGrid").jqxGrid('getrows');                    
    
    if(rows.length > 0 && (rows[0].refdocno == "undefined" || rows[0].refdocno == null || rows[0].refdocno == "")){
        return 0;
    }
    
    var selectedrows = $("#damageInvGrid").jqxGrid('selectedrowindexes');
    if(selectedrows.length == 0){
        $.messager.alert('Warning','Select an Invoice');
        return 0;
    }
        
    $('#invgridlength').val(selectedrows.length);
    for (var i = 0; i < rows.length; i++) {
        for(var j = 0; j < selectedrows.length; j++){
            if(selectedrows[j] == i){
                newTextBox = $(document.createElement("input"))
                    .attr("type", "dil")
                    .attr("id", "testinvoice"+z)
                    .attr("name", "testinvoice"+z)
                    .attr("hidden","true");
                    
                newTextBox.val(rows[i].refdocno+"::"+rows[i].reftype+"::"+rows[i].date+"::"+rows[i].date+"::"+rows[i].amount+"::"+rows[i].cldocno+"::"+rows[i].brhid+"::"+rows[i].curid+"::"+rows[i].doc_no+"::"+rows[i].acno+"::"+rows[i].accfines);
                
                newTextBox.appendTo('form');
                z++;
            }
        }
    }
    document.getElementById("mode").value = 'A';
    document.getElementById("frmDashboardDamageInvoice").submit();
}

function setValues(){
    if($('#msg').val() != ""){
        $.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
    }
}

function funExportBtn(){
    if(parseInt(window.parent.chkexportdata.value) == "1") {
        JSONToCSVCon(damagedata, 'Damages', true);
    } else {
        $("#damageInvGrid").jqxGrid('exportdata', 'xls', 'Damages');
    }
}
</script>
</head>

<body onload="getBranch();setValues();">
<form id="frmDashboardDamageInvoice" action="saveDashboardDamageInvoice">

<div id="mainBG" class="homeContent">
<div class='hidden-scrollbar'>
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
                        <td class="label-cell">Period Upto</td>
                        <td><div id="periodupto"></div></td>
                    </tr>
                </table>

                <div class="button-group" style="margin-top: 15px;">
                    <button type="button" id="btninvoicesave" class="btn-submit" onclick="funNotify();">
                        Generate
                    </button>
                </div>
            </div>

            <!-- Hidden fields -->
            <div style="display:none;">
                <input type="hidden" id="invgridlength" name="invgridlength" value='<s:property value="invgridlength"/>'>
                <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'>
                <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
            </div>

        </div>
    </div>
</td>

<!-- ================= RIGHT SIDE (GRID) ================= -->
<td valign="top">
    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="damageinvoicediv">
                <jsp:include page="damageInvGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>
</td>

</tr>
</table>

</div>
</div>
</div>
</form>
</body>
</html>