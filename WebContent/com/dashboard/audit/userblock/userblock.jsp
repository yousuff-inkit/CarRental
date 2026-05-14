<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
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

/* ===== UNIFORM TEXT INPUTS & SELECTS ===== */
input[type="text"], select, textarea {
    width: 100%;
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

input[type="text"], select {
    height: 24px !important;             
}

textarea {
    resize: none;
    padding: 6px 8px !important;
    line-height: 1.4;
}

input[readonly], textarea[readonly], input:disabled, select:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    cursor: default;
}

input[readonly]:not(:disabled) {
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

.btn-submit:hover:not(:disabled) { 
    background: #1d4ed8 !important; 
}

.btn-submit:disabled {
    background: #94a3b8 !important;
    cursor: not-allowed;
    opacity: 0.7;
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
     $('#userwindow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'User Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
     $('#userwindow').jqxWindow('close');
    
     $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:200px;right:600px;'><img src='../../../../icons/31load.gif'/></div>");    
    
     $('#btnblock').attr("disabled",true);
     
     $('#user').dblclick(function(){
          $('#userwindow').jqxWindow('open');
          userSearchContent('usersearch.jsp?', $('#userwindow')); 
    });
});

function getuser(event){
     var x = event.keyCode;
     if(x == 114){
      $('#userwindow').jqxWindow('open');
      userSearchContent('usersearch.jsp?', $('#userwindow'));    
     }
} 

function userSearchContent(url) {
     $.get(url).done(function (data) {
         $('#userwindow').jqxWindow('open');
         $('#userwindow').jqxWindow('setContent', data);
     }); 
} 

function funreload(event) {
    var branch=$('#cmbbranch').val();
    var doc_no=$('#docno').val();
    
    $('#overlay,#PleaseWait').show();
    $("#userblockdiv").load("userblockGrid.jsp?doc_no="+doc_no+"&branch="+branch+"&check=1");
}

function funExportBtn() {
    // Intentionally left blank from original code
}

function funBlock() {
    if(document.getElementById("bdocno").value==""){
         $.messager.alert('Message',"Please Select user");
         return false;
    }
    var doc_no = document.getElementById("bdocno").value;
    
    $.messager.confirm('Message', 'Do you want to Block?', function(r){
        if(r==false) {
            return false; 
        } else {
            savegriddata(doc_no);
        }
    });
}

function savegriddata(doc_no) {
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items=x.responseText;
            if(items==1) {
                document.getElementById("bdocno").value="";
                $.messager.alert('Message', '  Blocked Successfully ');
                funreload(event);
            } else {
                $.messager.alert('Message', 'Not Updated ');
                $("#fleetdetailsgrid").jqxGrid('clear');
            }       
        }
    }
    x.open("GET","userblockdata.jsp?doc_no="+doc_no,true);
    x.send();
}
</script>
</head>

<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
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
                        <td class="label-cell">User</td>
                        <td>
                            <input type="text" name="user" id="user" placeholder="Press F3 To Search" readonly="readonly" onkeydown="getuser(event)" onclick="this.placeholder=''" value='<s:property value="user"/>'>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <textarea id="txtclientname" name="txtclientname" readonly="readonly" style="height:60px;"><s:property value="txtclientname" /></textarea>
                        </td>
                    </tr>
                </table>

                <div class="button-group" style="margin-top: 15px;">
                    <button type="button" name="btnblock" id="btnblock" class="btn-submit" onclick="funBlock();">
                        Block
                    </button>
                </div>
            </div>
            
            <!-- Hidden Fields -->
            <div style="display:none;">
                <input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'>
                <input type="hidden" name="bdocno" id="bdocno" value='<s:property value="bdocno"/>'>
            </div>
            
        </div>
    </div>
</td>

<!-- ================= RIGHT SIDE (GRID) ================= -->
<td valign="top">
    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="userblockdiv">
                <jsp:include page="userblockGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>
</td>

</tr>
</table>

</div>

<!-- POPUPS -->
<div id="userwindow"><div></div></div>

</div>
</div>

</body>
</html>