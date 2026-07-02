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
    width: 60px;
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
    font-family: inherit;
}

textarea#txtsalesmaninfo {
    width: 100%;
    height: 90px !important;
    padding: 8px !important;
    border: 1px solid #ccd6e0 !important;
    border-radius: 4px !important;
    font-size: 12px !important;
    background-color: #f3f6f9 !important;
    color: #333;
    font-family: inherit;
    resize: none;
    box-sizing: border-box;
    outline: none;
    margin-top: 5px;
}

/* Readonly / disabled look */
input[readonly], input:disabled, select:disabled, 
.filter-table input[readonly], .filter-table input:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed;
    cursor: not-allowed;
}

/* Radio Button Layout */
.radio-group {
    display: flex;
    justify-content: center;
    gap: 15px;
    align-items: center;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    padding-bottom: 15px;
    border-bottom: 1px solid #e1e8ed;
    margin-bottom: 15px;
}

.radio-group input[type="radio"] {
    margin: 0 6px 0 0;
    vertical-align: middle;
}

.radio-group label {
    cursor: pointer;
    display: flex;
    align-items: center;
}

/* ===== BUTTONS ===== */
.action-buttons {
    display: flex;
    flex-direction: column;
    gap: 8px;
    margin-top: 15px;
}

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
}

.btn-submit:hover:not(:disabled) { background: #1d4ed8; }
.btn-submit:disabled {
    background: #cbd5e1 !important;
    cursor: not-allowed;
    color: #64748b !important;
}

.btn-submit.btn-danger { background: #dc2626; }
.btn-submit.btn-danger:hover:not(:disabled) { background: #b91c1c; }

.btn-submit.btn-secondary { background: #64748b; }
.btn-submit.btn-secondary:hover:not(:disabled) { background: #475569; }

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
    // Note: jqxWindow requires TWO nested divs to function correctly
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
<body>

<div id="mainBG" class="homeContent" data-type="background">

    <div class="master-container">

        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">
                
                <div class="filter-card">
                    
                    <div class="radio-group">
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

                    <div class="action-buttons">
                        <button type="button" class="btn-submit" id="btnlinking" onclick="funLinking(event);">
                            Linking
                        </button>
                        <button type="button" class="btn-submit btn-danger" id="btnremovelinking" onclick="funRemoveLinking(event);">
                            Remove Linking
                        </button>
                        <button type="button" class="btn-submit btn-secondary" onclick="funClearInfo();">
                            Clear
                        </button>
                    </div>

                    <div style="display:none;">
                        <input type="hidden" id="txtsalesmanid" name="txtsalesmanid" value='<s:property value="txtsalesmanid"/>'>
                    </div>

                </div>

            </div>
        </div>

        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="rentalUserLinkDiv">
                    <jsp:include page="rentalUserLinkGrid.jsp"></jsp:include>
                </div>
            </div>

        </div>

    </div>

    <div id="userDetailsWindow">
        <div></div><div></div>
    </div>

</div>

</body>
</html>