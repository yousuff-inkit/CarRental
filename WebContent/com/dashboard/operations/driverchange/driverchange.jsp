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
    width: 90px;
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
    cursor: pointer; /* Pointer because they are search lookups */
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

.filter-actions {
    display: flex;
    gap: 10px;
    justify-content: center;
    margin-top: 15px; 
}

/* Custom Utilities for this page */
.card-title {
    font-size: 13px;
    font-weight: bold;
    color: #2563eb;
    margin-bottom: 10px;
    padding-bottom: 5px;
    border-bottom: 1px solid #e3e8ee;
    text-transform: uppercase;
}
</style>

<script type="text/javascript">
$(document).ready(function () {
    $(".ptypehide").hide();
    
    // Standardized height to 24px and width to 100%
    $("#drvuptodate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    
    // Loading Overlays
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

    // Standardize Popups
    const drvWindowSettings = { width: '40%', height: '40%', maxHeight: '50%' ,maxWidth: '40%' , position: { x: 250, y: 60 }, keyboardCloseKey: 27};
    $('#dridwindow').jqxWindow({ ...drvWindowSettings, title: 'Driver Search' }).jqxWindow('close');
    $('#deldridwindow').jqxWindow({ ...drvWindowSettings, title: 'Driver Search' }).jqxWindow('close');
    $('#agmtnowindow').jqxWindow({ width: '50%', height: '60%', maxHeight: '80%' ,maxWidth: '50%' , title: 'Agreement Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27}).jqxWindow('close');

    $('#drnames').dblclick(function(){
        $('#dridwindow').jqxWindow('open');
        $('#dridwindow').jqxWindow('focus');
        drSearchContent('getdriverDetails.jsp');
    }); 
    
    $('#dlvdrvs').dblclick(function(){
        $('#deldridwindow').jqxWindow('open');
        $('#deldridwindow').jqxWindow('focus');
        deldrSearchContent('getdeldriverDetails.jsp');
    }); 
    
    $('#docnoos').dblclick(function(){
        if(document.getElementById("agmttype").value==""){
            $.messager.alert('warning','Please Select Agreement Type');
            document.getElementById("agmttype").focus();
            return false;
        }
        $('#agmtnowindow').jqxWindow('open');
        $('#agmtnowindow').jqxWindow('focus');
        agmtSearchContent('agmtSearch.jsp?agmttype='+document.getElementById("agmttype").value, $('#agmtnowindow'));
    }); 
    
    $("#type").change(function() {
        if($("#type").val()==4 || $("#type").val()==3){
            $(".ptypehide").show();
        } else {
            $("#processtype").val("");
            $(".ptypehide").hide();
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
    var barchval = document.getElementById("cmbbranch").value;
    var type=$("#type").val();
    var uptodate=$("#drvuptodate").val();
    $("#overlay, #PleaseWait").show();
    $("#drvupdiv").load("driverupdateGrid.jsp?barchval="+barchval+"&type="+type+"&uptodate="+uptodate); 
}

function funExportBtn(){
    var type=$("#type").val();
    $("#drvupdiv").excelexportjs({
        containerid: "drvupdiv", 
        datatype: 'json', 
        dataset: null, 
        gridId: "drvupdategrid", 
        columns: getColumns("drvupdategrid"),   
        worksheetName: "Driver Change - "+type
    });
}
    
function funupdate() {
    var rows=$("#drvupdategrid").jqxGrid('selectedrowindexes');
    rows = rows.sort(function(a,b){return a - b});
    
    if(rows.length==0){
        $("#overlay, #PleaseWait").hide();
        $.messager.alert('Warning','Select documents.');
        return false;
    }  
    
    var brch=document.getElementById("hidbrhid").value; 
    var doc_no=document.getElementById("doc_no").value; 
    var voc_no=document.getElementById("voc_no").value;
    var fleet_no=document.getElementById("fleet_no").value;
    var cldocno=document.getElementById("cldocno").value;
    var hidtype=document.getElementById("hidtype").value;
    var drid=document.getElementById("drid").value;
    var type=document.getElementById("type").value;
    var drvid=document.getElementById("drvid").value;
    var agmtno=document.getElementById("agmtno").value;
    
    if(drvid==''){
        $.messager.confirm('Message', 'Please Select a Driver !');
        return 0;
    }
    
    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
        if(r==false) {
            return false; 
        } else {
            savedata(doc_no,voc_no,fleet_no,cldocno,hidtype,drid,type,drvid,agmtno,brch);
        }
    });
}

function savedata(doc_no,voc_no,fleet_no,cldocno,hidtype,drid,type,drvid,agmtno,brch) {
    let processtype=$("#processtype").val();
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items= x.responseText;
            document.getElementById("doc_no").value="";
            document.getElementById("hidbrhid").value="";
            document.getElementById("fleet_no").value="";
            document.getElementById("voc_no").value="";
            document.getElementById("hidtype").value="";
            document.getElementById("cldocno").value="";
            document.getElementById("drid").value="";
            document.getElementById("drvid").value="";
            document.getElementById("drids").value="";
            document.getElementById("drnames").value="";
            document.getElementById("drnames").placeholder = "Press F3 to Search";
            document.getElementById("agmtno").value="";
            
            funreload(event);
            $.messager.alert('Message', ' Record Successfully Updated ');
        }
    }
    x.open("GET","saveData.jsp?processtype="+processtype+"&doc_no="+doc_no+"&voc_no="+voc_no+"&hidtype="+hidtype+"&fleet_no="+fleet_no+"&cldocno="+cldocno+"&drid="+drid+"&type="+type+"&drvid="+drvid+"&agmtno="+agmtno+"&brch="+brch,true);
    x.send();
}

function fundelupdate() {
    var agmtype=document.getElementById("agmttype").value;  
    var drvid=document.getElementById("dlvdrv").value;  
    var agmdocno=document.getElementById("docnos").value;   
    var orgdrvid=document.getElementById("dlvdrvs").value;  
    var orgagmdocno=document.getElementById("docnoos").value;   
    
    if(orgagmdocno==''){
        $.messager.confirm('Message', 'Please Select a Docno !');
        return 0;
    }
    if(orgdrvid==''){
        $.messager.confirm('Message', 'Please Select a Driver !');
        return 0;
    }
    
    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
        if(r==false) {
            return false; 
        } else {
            delchkdata(agmtype,drvid,agmdocno);
        }
    });
}

function delchkdata(agmtype, drvid, agmdocno) {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function () {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.split("####");
            let messages = [];
            if (parseInt(items[0]) === 1) messages.push("Already Invoiced.");
            if (parseInt(items[1]) === 1) messages.push("Replacement Already Done.");
            if (parseInt(items[2]) === 1) messages.push("Custody Already Done.");

            if (messages.length > 0) {
                $.messager.alert('Message', messages.join('<br>'));
            } else {
                delsavedata(agmtype, drvid, agmdocno);
            }
        }
    };
    x.open("GET", "delcheckData.jsp?agmtype=" + agmtype + "&drvid=" + drvid + "&agmdocno=" + agmdocno, true);
    x.send();
}

function delsavedata(agmtype,drvid,agmdocno) {
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items= x.responseText;
            document.getElementById("dlvdrv").value="";
            document.getElementById("docnos").value="";
            document.getElementById("dlvdrvs").value="";
            document.getElementById("docnoos").value="";
            $('#dlvdrvs').attr('placeholder','Press F3 to Search'); 
            $('#docnoos').attr('placeholder','Press F3 to Search'); 
            
            funreload(event);
            $.messager.alert('Message', ' Record Successfully Updated ');
        }
    }
    x.open("GET","delsaveData.jsp?agmtype="+agmtype+"&drvid="+drvid+"&agmdocno="+agmdocno,true);
    x.send();
}

function getDrid(event){
    if(event.keyCode==114){
        $('#dridwindow').jqxWindow('open');
        $('#dridwindow').jqxWindow('focus');
        drSearchContent('getdriverDetails.jsp');
    }
}

function getdelDrid(event){
    if(event.keyCode==114){
        $('#deldridwindow').jqxWindow('open');
        $('#deldridwindow').jqxWindow('focus');
        deldrSearchContent('getdeldriverDetails.jsp');
    }
}

function drSearchContent(url) {
    $.get(url).done(function (data) {
        $('#dridwindow').jqxWindow('setContent', data);
    }); 
}

function deldrSearchContent(url) {
    $.get(url).done(function (data) {
        $('#deldridwindow').jqxWindow('setContent', data);
    }); 
}

function getAgmtno(event){
    if(event.keyCode==114){
        if(document.getElementById("agmttype").value==""){
             $.messager.alert('warning','Please Select Agreement Type');
             document.getElementById("agmttype").focus();
             return false;
         }
        $('#agmtnowindow').jqxWindow('open');
        $('#agmtnowindow').jqxWindow('focus');
        agmtSearchContent('agmtSearch.jsp?agmttype='+document.getElementById("agmttype").value, $('#agmtnowindow'));
    }
}

function agmtSearchContent(url) {
    $.get(url).done(function (data) {
        $('#agmtnowindow').jqxWindow('setContent', data);
    }); 
}
</script>
</head>
<body onload="getBranch();">

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
                            <td class="label-cell">Upto Date</td>
                            <td>
                                <div id="drvuptodate" name="drvuptodate" value='<s:property value="drvuptodate"/>'></div>
                                <input type="hidden" id="hiddrvuptodate" name="hiddrvuptodate" value='<s:property value="hiddrvuptodate"/>'/>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Type</td>
                            <td>
                                <select id="type" name="type" value='<s:property value="type"/>'>
                                    <option value="1">Delivery</option>
                                    <option value="2">Collection</option>
                                    <option value="3">Replacement</option>
                                    <option value="4">Movement</option>
                                </select>
                            </td>
                        </tr>
                        
                        <tr class="ptypehide">
                            <td class="label-cell">Process Type</td>
                            <td>
                                <select id="processtype" name="processtype" value='<s:property value="processtype"/>'>
                                    <option value="1">Delivery</option>
                                    <option value="2">Collection</option>
                                </select>
                            </td>
                        </tr>

                        <tr>
                            <td class="label-cell">Driver</td>
                            <td>
                                <input type="hidden" id="drids" name="drids">
                                <input type="text" id="drnames" name="drnames" readonly
                                       placeholder="Press F3 to Search"
                                       onkeydown="getDrid(event);">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <button type="button" id="driverUpdate" class="btn-submit" onclick="funupdate();">
                                    Update
                                </button>
                            </td>
                        </tr>
                    </table>
                </div>

                <div class="filter-card">
                    <div class="card-title">Delivery Details</div>
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">Type</td>
                            <td>
                                <select id="agmttype" name="agmttype" value='<s:property value="agmttype"/>'>
                                    <option value="RAG">Rental</option>
                                    <option value="LAG">Lease</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Doc No</td>
                            <td>
                                <input type="hidden" id="docnos" name="docnos">
                                <input type="text" id="docnoos" name="docnoos" readonly
                                       placeholder="Press F3 to Search"
                                       onkeydown="getAgmtno(event);">
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Driver</td>
                            <td>
                                <input type="hidden" id="dlvdrv" name="dlvdrv">
                                <input type="text" id="dlvdrvs" name="dlvdrvs" readonly
                                       placeholder="Press F3 to Search"
                                       onkeydown="getdelDrid(event);">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <button type="button" id="deldriverUpdate" class="btn-submit" onclick="fundelupdate();">
                                    Update
                                </button>
                            </td>
                        </tr>
                    </table>
                </div>

                <div style="display:none;">
                    <input type="hidden" id="doc_no" name="doc_no" value='<s:property value="doc_no"/>'>
                    <input type="hidden" id="voc_no" name="voc_no" value='<s:property value="voc_no"/>'>
                    <input type="hidden" id="hidtype" name="hidtype" value='<s:property value="hidtype"/>'>
                    <input type="hidden" id="fleet_no" name="fleet_no" value='<s:property value="fleet_no"/>'>
                    <input type="hidden" id="cldocno" name="cldocno" value='<s:property value="cldocno"/>'>
                    <input type="hidden" id="drid" name="drid" value='<s:property value="drid"/>'>
                    <input type="hidden" id="drvid" name="drvid" value='<s:property value="drvid"/>'>
                    <input type="hidden" id="deldrvid" name="deldrvid" value='<s:property value="deldrvid"/>'>
                    <input type="hidden" id="agmtno" name="agmtno" value='<s:property value="agmtno"/>'>
                    <input type="hidden" id="hidbrhid" name="hidbrhid" value='<s:property value="hidbrhid"/>'>
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
                 <div id="drvupdiv">
                     <jsp:include page="driverupdateGrid.jsp"></jsp:include>
                 </div>
             </td>
        </tr>
    </table>

</td>

</tr>
</table>

</div>
</div>

<div id="dridwindow"><div></div></div>
<div id="deldridwindow"><div></div></div>
<div id="agmtnowindow"><div></div></div>

</body>
</html>