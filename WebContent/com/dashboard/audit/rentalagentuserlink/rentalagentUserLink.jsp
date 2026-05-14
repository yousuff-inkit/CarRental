<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
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
    width: 60px;
}

/* ===== UNIFORM 24px TEXT INPUTS & SELECTS ===== */
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

textarea {
    width: 100%;
    height: 90px !important;
    padding: 8px !important;
    border: 1px solid #ccd6e0 !important;
    border-radius: 4px !important;
    font-size: 12px !important;
    background-color: #f3f6f9 !important;
    color: #333;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    resize: none;
    box-sizing: border-box;
    outline: none;
}

input[readonly], input:disabled, select:disabled, textarea[readonly] {
    background-color: #f3f6f9 !important;
    color: #555;
    cursor: pointer;
}

/* Radio Button Layout Customization */
.radio-group {
    display: flex;
    gap: 15px;
    align-items: center;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    padding: 5px 0;
}

.radio-group input[type="radio"] {
    margin: 0 4px 0 0;
    vertical-align: middle;
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

.btn-submit:hover:not([disabled]) { 
    background: #1d4ed8 !important; 
}

.btn-submit:disabled {
    background: #cbd5e1 !important;
    cursor: not-allowed;
    color: #64748b !important;
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
</style>

<script type="text/javascript">
$(document).ready(function () {
    $('#userDetailsWindow').jqxWindow({width: '51%', height: '58%', maxHeight: '70%' ,maxWidth: '51%' , title: 'Users Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#userDetailsWindow').jqxWindow('close');
    
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    
    $('#txtusername').dblclick(function(){
        userDetailsSearchContent('userDetailsSearch.jsp');
    });
    
    document.getElementById("rdlinking").checked = true;
    $('#btnlinking').attr("disabled", true);
    $('#btnremovelinking').attr("disabled", true);
});

function userDetailsSearchContent(url) {
    $('#userDetailsWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#userDetailsWindow').jqxWindow('setContent', data);
        $('#userDetailsWindow').jqxWindow('bringToFront');
    }); 
}

function getUserDetails(event){
    var x = event.keyCode;
    if(x == 114){
        userDetailsSearchContent('userDetailsSearch.jsp');
    }
}

function funreload(event){
    $('#txtsalesmanid').val('');
    $('#txtsalesmaninfo').val(' ');     
    $('#btnlinking').attr("disabled", true);
    $('#btnremovelinking').attr("disabled", true);
    $("#overlay, #PleaseWait").show();
    
    if(document.getElementById("rdlinking").checked == true){
        $("#rentalUserLinkDiv").load("rentalUserLinkGrid.jsp?rpttype=1&check=1", function() {
            $("#overlay, #PleaseWait").hide();
        });
    } else if(document.getElementById("rddelete").checked == true){
        $("#rentalUserLinkDiv").load("rentalUserLinkGrid.jsp?rpttype=2&check=1", function() {
            $("#overlay, #PleaseWait").hide();
        });
    }
}

function funLinking(event){
    var userdocno = $('#txtuserdocno').val();
    var salesmanid = $('#txtsalesmanid').val();
    var rpttype = "0";
    if(document.getElementById("rdlinking").checked == true){
        rpttype = "1";
    }
    
    if(userdocno == ''){
        $.messager.alert('Message','Choose a User.','warning');
        return 0;
    }
        
    $.messager.confirm('Message', 'Do you want to link Salesman with User?', function(r){
        if(r == false) {
            return false; 
        } else {
            saveGridData(salesmanid, userdocno, rpttype);  
        }
    });
}

function funRemoveLinking(event){
    var userdocno = $('#txtuserdocno').val();
    var salesmanid = $('#txtsalesmanid').val();
    var rpttype = "0";
    if(document.getElementById("rddelete").checked == true){
        rpttype = "2";
    }
        
    $.messager.confirm('Message', 'Do you want to remove link ?', function(r){
        if(r == false) {
            return false; 
        } else {
            removeGridData(salesmanid, userdocno, rpttype);  
        }
    });
}

function saveGridData(salesmanid, userdocno, rpttype) {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function(){
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            $.messager.alert('Message', ' Record Successfully Linked ', function(r){});
            funClearInfo();
            funreload(event); 
        }
    }
    x.open("GET","saveData.jsp?salesmanid="+salesmanid+"&userdocno="+userdocno+"&rpttype="+rpttype,true);
    x.send();
}

function removeGridData(salesmanid, userdocno, rpttype) {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function(){
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            $.messager.alert('Message', ' Record Successfully Removed ', function(r){});
            funClearInfo();
            funreload(event); 
        }
    }
    x.open("GET","saveData.jsp?salesmanid="+salesmanid+"&userdocno="+userdocno+"&rpttype="+rpttype,true);
    x.send();
}

function funExportBtn(){
    JSONToCSVCon(data, 'SalesUserLink', true);
}

function funClearInfo() {
    $('#txtsalesmanid').val('');
    $('#txtuserdocno').val('');
    $('#txtusername').val(''); 
    $('#txtsalesmaninfo').val(' ');
    $('#btnlinking').attr("disabled", true);
    $('#btnremovelinking').attr("disabled", true);
    document.getElementById("rdlinking").checked = true;
    document.getElementById("rddelete").checked = false;
    $("#rentalUserLinkGridID").jqxGrid('clear');
    
    if (document.getElementById("txtusername").value == "") {
        $('#txtusername').attr('placeholder', 'Press F3 to Search'); 
    }
}

function funClearRadioInfo() {
    if(document.getElementById("rdlinking").checked == true){
        $('#txtsalesmanid').val('');
        $('#txtuserdocno').val('');
        $('#txtusername').val(''); 
        $('#txtsalesmaninfo').val(' ');
        $('#btnlinking').attr("disabled", true);
        $('#btnremovelinking').attr("disabled", true);
        document.getElementById("rdlinking").checked = true;
        document.getElementById("rddelete").checked = false;
        $("#rentalUserLinkGridID").jqxGrid('clear');
        
        if (document.getElementById("txtusername").value == "") {
            $('#txtusername').attr('placeholder', 'Press F3 to Search'); 
        }
    } else if(document.getElementById("rddelete").checked == true){
        $('#txtsalesmanid').val('');
        $('#txtuserdocno').val('');
        $('#txtusername').val(''); 
        $('#txtsalesmaninfo').val(' ');
        $('#btnlinking').attr("disabled", true);
        $('#btnremovelinking').attr("disabled", true);
        document.getElementById("rdlinking").checked = false;
        document.getElementById("rddelete").checked = true;
        $("#rentalUserLinkGridID").jqxGrid('clear');
        
        if (document.getElementById("txtusername").value == "") {
            $('#txtusername').attr('placeholder', 'Press F3 to Search'); 
        }
    }
}
</script>

</head>
<body onload="getBranch();">

<div id="mainBG" class="homeContent" data-type="background">
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
                
                <div class="radio-group" style="padding-bottom: 10px; border-bottom: 1px solid #e1e8ed; margin-bottom: 10px; justify-content: center;">
                    <label>
                        <input type="radio" id="rdlinking" name="rdo" onchange="funClearRadioInfo();">
                        Linking
                    </label>
                    <label>
                        <input type="radio" id="rddelete" name="rdo" onchange="funClearRadioInfo();">
                        Remove Linking
                    </label>
                </div>

                <table class="filter-table">
                    <tr>
                        <td class="label-cell">User</td>
                        <td>
                            <input type="text" id="txtusername" name="txtusername" placeholder="Press F3 to Search" readonly onkeydown="getUserDetails(event);" value='<s:property value="txtusername"/>'>
                            <input type="hidden" id="txtuserdocno" name="txtuserdocno" value='<s:property value="txtuserdocno"/>'>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <textarea id="txtsalesmaninfo" readonly><s:property value="txtsalesmaninfo"/></textarea>
                        </td>
                    </tr>
                </table>

                <div class="button-group" style="margin-top: 15px;">
                    <button type="button" class="btn-submit" id="btnlinking" onclick="funLinking(event);">
                        Linking
                    </button>
                    <button type="button" class="btn-submit" id="btnremovelinking" onclick="funRemoveLinking(event);" style="background:#d9344a !important;">
                        Remove Linking
                    </button>
                </div>
                
                <div class="button-group" style="margin-top: 5px;">
                    <button type="button" class="btn-submit" onclick="funClearInfo();" style="background:#64748b !important;">
                        Clear
                    </button>
                </div>

            </div>

            <!-- Hidden Fields -->
            <div style="display:none;">
                <input type="hidden" id="txtsalesmanid" name="txtsalesmanid" value='<s:property value="txtsalesmanid"/>'>
            </div>
            
        </div>
    </div>
</td>

<!-- ================= RIGHT SIDE (GRID) ================= -->
<td valign="top">
    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="rentalUserLinkDiv">
                <jsp:include page="rentalUserLinkGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>
</td>

</tr>
</table>

<!-- POPUP -->
<div id="userDetailsWindow">
    <div></div>
</div>

</div>
</div>
</div>

</body>
</html>