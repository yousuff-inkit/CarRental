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
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

/* Checkboxes & Radios */
input[type="checkbox"], input[type="radio"] {
    margin: 0;
    cursor: pointer;
    width: 14px;
    height: 14px;
    vertical-align: middle;
}

.checkbox-wrap {
    display: flex;
    align-items: center;
    gap: 6px;
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
}

.radio-group {
    display: flex;
    justify-content: center;
    gap: 20px;
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
    padding: 10px 0;
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
    margin-bottom: 5px;
    padding-bottom: 5px;
    border-bottom: 1px solid #e3e8ee;
    text-transform: uppercase;
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
    font-size: 11px !important;
    font-weight: 600 !important;
    cursor: pointer;
    line-height: 30px !important;
    text-align: center;
    white-space: nowrap;
    transition: all 0.2s ease;
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
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
     
    // Standardize jqxDateTimeInputs
    $("#fromdate, #todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    
    document.getElementById("rdsalik").checked=true;
    funtypechange();
    
    var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));
    var onemounth = new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
    $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
    
    $('#todate').on('change', function (event) {
        var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));
        var todates = new Date($('#todate').jqxDateTimeInput('getDate')); 
        if(fromdates > todates){
            $.messager.alert('Message','To Date Less Than From Date ','warning');   
            return false;
        }   
    });
});

function funtypechange(){
    if (document.getElementById('rdsalik').checked) {
        $('#uasalikGridDiv').show(); $('#uatrafficGridDiv').hide();
    } else if (document.getElementById('rdtraffic').checked) {
        $('#uatrafficGridDiv').show(); $('#uasalikGridDiv').hide();
    }
}

function funreload(event){
    var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));
    var todates = new Date($('#todate').jqxDateTimeInput('getDate'));
    
    if(fromdates > todates){
        $.messager.alert('Message','To Date Less Than From Date ','warning');   
        return false;
    } 
    
    if (!(document.getElementById('rdsalik').checked || document.getElementById('rdtraffic').checked)) {
        $.messager.alert('Message','Select Traffic / Salik ','warning');
        return false;
    } else {
        var fromdate = $("#fromdate").val();
        var todate = $("#todate").val(); 
        var load = "yes";
        var chktype = "";
        var chkdatails = $("#chkdatails").val(); 
        
        if (document.getElementById('rdsalik').checked) {
            chktype = "salik";
            document.getElementById("chktypes").value = chktype;
            $('#uasalikGridDiv').show(); $('#uatrafficGridDiv').hide();
            $("#overlay, #PleaseWait").show();
            $("#uasalikGridDiv").load("salikGrid.jsp?load="+load+"&fromdate="+fromdate+"&todate="+todate+"&chkdatails="+chkdatails);
        } else if (document.getElementById('rdtraffic').checked) {
            chktype = "traffic";
            document.getElementById("chktypes").value = chktype;
            $('#uatrafficGridDiv').show(); $('#uasalikGridDiv').hide();
            $("#overlay, #PleaseWait").show();
            $("#uatrafficGridDiv").load("trafficGrid.jsp?load="+load+"&fromdate="+fromdate+"&todate="+todate+"&chkdatails="+chkdatails);
        }
    }
}

function funUnallocate() {
    var chkdatails = $("#chkdatails").val(); 
    if(chkdatails == 1){
        var selectedrows = $('#jqxsalikGrid').jqxGrid('getselectedrowindexes');
        if(selectedrows.length != 0){
            $.messager.alert('Warning','Already Allocated.');
            return false;
        }
    } 
        
    $.messager.confirm('Message', 'Do you want to Un Allocate?', function(r){
        if(r == false) { return false; } else {
            var chktypes = $('#chktypes').val();
            
            if(chktypes == "salik"){
                var selectedrows = $('#jqxsalikGrid').jqxGrid('getselectedrowindexes');
                if(selectedrows.length == 0){
                    $.messager.alert('Warning','Select documents.');
                    return false;
                }
                var dataarray = new Array();
                for(var i=0; i<selectedrows.length; i++){
                    var trans = $('#jqxsalikGrid').jqxGrid('getcelltext',selectedrows[i],'trans');
                    dataarray.push(trans);
                }
                ajaxcall(dataarray,chktypes); 
            } else if(chktypes == "traffic"){
                var selectedrows = $('#jqxtrafficGrid').jqxGrid('getselectedrowindexes');
                if(selectedrows.length == 0){
                    $.messager.alert('Warning','Select documents.');
                    return false;
                }
                var dataarray = new Array();
                for(var i=0; i<selectedrows.length; i++){
                    var trans = $('#jqxtrafficGrid').jqxGrid('getcelltext',selectedrows[i],'ticket_no');
                    dataarray.push(trans);
                }
                ajaxcall(dataarray,chktypes); 
            }
        }
    });
}

function ajaxcall(dataarray,chktypes){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function(){
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            var itemval = items.trim();
            if(parseInt(itemval) > 0) {
                $.messager.alert('Message', ' Record Successfully Un Allocated ');
                funreload(event);
            } else {
                $.messager.alert('Message', ' Not Un Allocated ');
            }
        }
    }
    x.open("GET","savedata.jsp?dataarray="+dataarray+'&chktypes='+chktypes,true);
    x.send();
}

function funInvoice() {
    $.messager.confirm('Message', 'Do you want to Mark as Invoiced?', function(r){
        if(r == false) { return false; } else {
            var chktypes = $('#chktypes').val();
            
            if(chktypes == "salik"){
                var selectedrows = $('#jqxsalikGrid').jqxGrid('getselectedrowindexes');
                if(selectedrows.length == 0){
                    $.messager.alert('Warning','Select documents.');
                    return false;
                }
                var dataarray = new Array();
                for(var i=0; i<selectedrows.length; i++){
                    var trans = $('#jqxsalikGrid').jqxGrid('getcelltext',selectedrows[i],'trans');
                    dataarray.push(trans);
                }
                ajaxcallinv(dataarray,chktypes); 
            } else if(chktypes == "traffic"){
                var selectedrows = $('#jqxtrafficGrid').jqxGrid('getselectedrowindexes');
                if(selectedrows.length == 0){
                    $.messager.alert('Warning','Select documents.');
                    return false;
                }
                var dataarray = new Array();
                for(var i=0; i<selectedrows.length; i++){
                    var trans = $('#jqxtrafficGrid').jqxGrid('getcelltext',selectedrows[i],'ticket_no');
                    dataarray.push(trans);
                }
                ajaxcallinv(dataarray,chktypes); 
            }
        }
    });
}

function ajaxcallinv(dataarray,chktypes){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function(){
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            var itemval = items.trim();
            if(parseInt(itemval) > 0) {
                $.messager.alert('Message', ' Record Successfully Marked as Invoice ');
                funreload(event);
            } else {
                $.messager.alert('Message', ' Not Updated ');
            }
        }
    }
    x.open("GET","savedatainv.jsp?dataarray="+dataarray+'&chktypes='+chktypes,true);
    x.send();
}

function funExportBtn(){
    if(document.getElementById('rdsalik').checked){
        $("#jqxsalikGrid").excelexportjs({
            containerid: "jqxsalikGrid",
            datatype: 'json',
            dataset: null,
            gridId: "jqxsalikGrid",
            columns: getColumns("jqxsalikGrid") ,
            worksheetName:"Salik Allocation List"
        }); 
    } else if(document.getElementById('rdtraffic').checked){
        $("#jqxtrafficGrid").excelexportjs({
            containerid: "jqxtrafficGrid",
            datatype: 'json',
            dataset: null,
            gridId: "jqxtrafficGrid",
            columns: getColumns("jqxtrafficGrid") ,
            worksheetName:"Traffic Allocation List"
        }); 
    }
}
 
function funsetaval() {
    if (document.getElementById('Unallocated').checked) {
        document.getElementById("chkdatails").value="1";
    } else {
        document.getElementById("chkdatails").value="0";
    }
}
</script>
</head>

<body onload="getBranch()">
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
                        <td colspan="2" align="center" style="padding-top: 10px;">
                            <div class="checkbox-wrap" style="justify-content: center;">
                                <input type="checkbox" id="Unallocated" name="Unallocated" onchange="funsetaval();">
                                <label for="Unallocated">Unallocated</label>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="filter-card">
                <div class="card-title">Type</div>
                <div class="radio-group">
                    <label>
                        <input type="radio" id="rdtraffic" name="rdcategory" value="rdtraffic" onchange="funtypechange();">
                        Traffic
                    </label>
                    <label>
                        <input type="radio" id="rdsalik" name="rdcategory" value="rdsalik" onchange="funtypechange();">
                        Salik
                    </label>
                </div>

                <div class="button-group" style="margin-top: 15px;">
                    <button class="btn-submit" type="button" id="btnunallocate" onclick="funUnallocate(event);">
                        Unallocate
                    </button>
                    <button class="btn-submit" type="button" id="btninvoiced" onclick="funInvoice(event);">
                        Mark as Invoiced
                    </button>
                </div>

                <!-- HIDDEN FIELDS -->
                <div style="display:none;">
                    <input type="hidden" id="chktypes" name="chktypes">
                    <input type="hidden" id="chkdatails" name="chkdatails" value='<s:property value="chkdatails"/>'>
                </div>
            </div>

        </div>
    </div>
</td>

<!-- ================= RIGHT SIDE (GRIDS) ================= -->
<td valign="top">
    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            
            <div id="uasalikGridDiv">
                <jsp:include page="salikGrid.jsp"></jsp:include>
            </div>

            <div id="uatrafficGridDiv" style="display:none;">
                <jsp:include page="trafficGrid.jsp"></jsp:include>
            </div>

        </div>
    </div>
</td>

</tr>
</table>

</div>
</div>
</body>
</html>