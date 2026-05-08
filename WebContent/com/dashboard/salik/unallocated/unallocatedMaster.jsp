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
    cursor: pointer;
}

input[type="checkbox"] {
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

.card-title {
    font-size: 13px;
    font-weight: bold;
    color: #2563eb;
    margin-bottom: 10px;
    padding-bottom: 5px;
    border-bottom: 1px solid #e3e8ee;
    text-transform: uppercase;
}

/* Animations */
@keyframes blink {
    0% { opacity: 1; }
    50% { opacity: 0.4; }
    100% { opacity: 1; }
}

.blink-text {
    animation: blink 1s linear infinite;
    color: #d97706; /* Amber warning color */
    font-size: 12px;
    text-align: center;
    margin-bottom: 10px;
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
}

.btn-submit:hover { background: #1d4ed8 !important; }
.btn-submit:disabled { background: #94a3b8 !important; cursor: not-allowed; }

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
    // Standardize jqxDateTimeInputs
    $("#fromdate, #uptodate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    
    $("#cmbbranch").attr('hidden',true);
    funchange();
    
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    
    $("#hidediv").hide();
      
    // Initialize Popups
    const winSettings = { height: '65%', maxHeight: '85%', maxWidth: '80%', position: { x: 200, y: 60 }, keyboardCloseKey: 27 };
    $('#regwindow').jqxWindow({ ...winSettings, width: '30%', title: 'Reg No Search' }).jqxWindow('close');
    $('#tagwindow').jqxWindow({ ...winSettings, width: '30%', title: 'Tag No Search' }).jqxWindow('close');
    $('#fleetwindow').jqxWindow({ width: '30%', height: '60%', maxHeight: '62%', maxWidth: '60%', title: 'Fleet Search', position: { x: 250, y: 120 }, keyboardCloseKey: 27 }).jqxWindow('close');
    $('#commonwindow1').jqxWindow({ width: '71%', height: '70%', maxHeight: '70%', maxWidth: '80%', title: 'Details', position: { x: 180, y: 60 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27 }).jqxWindow('close');
    $('#commonwindow').jqxWindow({ width: '20%', height: '60%', maxHeight: '62%', maxWidth: '60%', title: 'Search', position: { x: 250, y: 120 }, keyboardCloseKey: 27 }).jqxWindow('close');
   
    $('#regno').dblclick(function(){ $('#regwindow').jqxWindow('open'); ragnoContent('regnosearch.jsp?', $('#regwindow')); });
    $('#tagno').dblclick(function(){ $('#tagwindow').jqxWindow('open'); tagnoContent('tagnosearch.jsp?', $('#tagwindow')); });
    $('#fleet_no').dblclick(function(){ $('#fleetwindow').jqxWindow('open'); fleetSearchContent('fleetsearch.jsp?id=1', $('#fleetwindow')); });
        
    $('#typesearch').dblclick(function(){
        if(document.getElementById("trftype").value=="RAG"){
            $('#commonwindow1').jqxWindow('open');
            raSearchContent('ramasterSearch.jsp'); 
        } else if(document.getElementById("trftype").value=="LAG"){
            $('#commonwindow1').jqxWindow('open');
            raSearchContent('lamasterSearch.jsp'); 
        } else if(document.getElementById("trftype").value=="DRV" || document.getElementById("trftype").value=="STF"){
            $('#commonwindow').jqxWindow('open');
            SearchContent('searchdrvandstaff.jsp?id=1&values='+document.getElementById("trftype").value); 
        }
    });
});

function SearchContent(url) { $.get(url).done(function (data) { $('#commonwindow').jqxWindow('open'); $('#commonwindow').jqxWindow('setContent', data); }); } 
function raSearchContent(url) { $.get(url).done(function (data) { $('#commonwindow1').jqxWindow('open'); $('#commonwindow1').jqxWindow('setContent', data); }); } 
function fleetSearchContent(url) { $.get(url).done(function (data) { $('#fleetwindow').jqxWindow('open'); $('#fleetwindow').jqxWindow('setContent', data); }); }
function ragnoContent(url) { $.get(url).done(function (data) { $('#regwindow').jqxWindow('open'); $('#regwindow').jqxWindow('setContent', data); }); } 
function tagnoContent(url) { $.get(url).done(function (data) { $('#tagwindow').jqxWindow('open'); $('#tagwindow').jqxWindow('setContent', data); }); } 

function getfleet(event){ if(event.keyCode==114){ $('#fleetwindow').jqxWindow('open'); fleetSearchContent('fleetsearch.jsp?id=1', $('#fleetwindow')); } } 
function getregno(event){ if(event.keyCode==114){ $('#regwindow').jqxWindow('open'); ragnoContent('regnosearch.jsp?', $('#regwindow')); } }
function gettagno(event){ if(event.keyCode==114){ $('#tagwindow').jqxWindow('open'); tagnoContent('tagnosearch.jsp?', $('#tagwindow')); } }

function funExportBtn(){ JSONToCSVCon(exceldatas, 'Salik Unallocated', true); }

function funreload(event) {     
    var val ="2";
    var uptodate=$("#uptodate").val();
    var fromdate=$("#fromdate").val();
    var hidchkdate=$("#hidchkdate").val();
    var regno=$("#regno").val();
    var tagno=$("#tagno").val();
    var saliktype=$('#cmbsaliktype').val();
    $("#overlay, #PleaseWait").show();
    $("#allodiv").load("allocatelistGrid.jsp?saliktype="+saliktype+"&chval="+val+"&uptodate="+uptodate+'&regno='+regno+'&tagno='+tagno+'&fromdate='+fromdate+'&hidchkdate='+hidchkdate);
}
    
function hiddenbrh(){
    $("#branchlabel").attr('hidden',true);
    $("#branchdiv").attr('hidden',true);
    $('#gridlength').val(""); 
}
    
function funallocate() {
    $.messager.confirm('Message', 'Do you want to Allocate?', function(r){
        if(r==false) { return false; } else {
            $("#hidediv").show();
            var saveval="10";
            var regno=document.getElementById('regno').value;
            var tagno=document.getElementById('tagno').value;
            ajaxcall(saveval,regno,tagno);
        }
    });
}
    
function ajaxcall(saveval,regno,tagno){
    var saliktype=$('#cmbsaliktype').val();
    $('.salikallocatecount').show();
    const interval = setInterval(function() {
        $.get('getAllocateCount.jsp',function(data){
            data=JSON.parse(data);
            $('.currentsalikallocated').text(data.currentcount);
        });             
    }, 5000);
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items= x.responseText;
            var itemval=items.trim();
            clearInterval(interval);
            $('.salikallocatecount').hide();
            if(parseInt(itemval)=="10") {
                $.messager.alert('Message', 'Allocation Not Processed');
                funreload(event);
                $("#hidediv").hide();
            } else if(parseInt(itemval)=="11") {
                $.messager.alert('Message', ' Record Successfully Allocated ');
                var val ="10";
                var uptodate=$("#uptodate").val();
                var regno=$("#regno").val();
                var tagno=$("#tagno").val();
                var fromdate=$("#fromdate").val();
                var hidchkdate=$("#hidchkdate").val();
                $("#allodiv").load("allocatelistGrid.jsp?chval="+val+"&uptodate="+uptodate+'&regno='+regno+'&tagno='+tagno+'&fromdate='+fromdate+'&hidchkdate='+hidchkdate);
                $("#hidediv").hide();
            } else {
                $.messager.alert('Message', ' Not Allocated ');
                funreload(event);
                $("#hidediv").hide();
            }
        }
    }
    x.open("GET","savedata.jsp?saliktype="+saliktype+"&saveval="+saveval+"&regno="+regno+"&tagno="+tagno+"&uptodate="+$('#uptodate').jqxDateTimeInput('val')+"&fromdate="+$('#fromdate').jqxDateTimeInput('val')+"&hidchkdate="+$("#hidchkdate").val());
    x.send();
}

function funcleardata() {
    document.getElementById("regno").value="";
    document.getElementById("tagno").value="";
    if (document.getElementById("regno").value == "") { $('#regno').attr('placeholder', 'Press F3 TO Search'); }
    if (document.getElementById("tagno").value == "") { $('#tagno').attr('placeholder', 'Press F3 TO Search'); }
}
        
function getAllocateBranch() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim().split('####');
            var optionsbranch = "" ;
            var branchid  = items[0].split(",");
            var branchname = items[1].split(",");
            for (var i = 0; i < branchname.length; i++) {
                optionsbranch += '<option value="' + branchid[i].trim() + '">' + branchname[i] + '</option>';
            }
            $("select#cmballocatebranch").html(optionsbranch);
        }
    }
    x.open("GET","<%=contextPath%>/com/dashboard/getBranch.jsp", true);
    x.send();
}
        
function gettypessearch(event){
    if(event.keyCode==114){
        if(document.getElementById("trftype").value=="RAG"){
            $('#commonwindow1').jqxWindow('open');
            raSearchContent('ramasterSearch.jsp'); 
        } else if(document.getElementById("trftype").value=="LAG"){
            $('#commonwindow1').jqxWindow('open');
            raSearchContent('lamasterSearch.jsp'); 
        } else if(document.getElementById("trftype").value=="DRV" || document.getElementById("trftype").value=="STF"){
            $('#commonwindow').jqxWindow('open');
            SearchContent('searchdrvandstaff.jsp?id=1&values='+document.getElementById("trftype").value); 
        }
    }
}
        
function cleardatas() {
    document.getElementById("typesearch").value="";
    document.getElementById("rentaldoc").value="";
    document.getElementById("leasedoc").value="";
    document.getElementById("drdoc").value="";
    document.getElementById("staffdoc").value="";
}
    
function funoneallocate(){
    if(document.getElementById("fleet_no").value==""){ $.messager.alert('Message',' Search Fleet ','warning'); return false; }
    if(document.getElementById("typesearch").value==""){ $.messager.alert('Message','Convict Search ','warning'); return false; }
    $.messager.confirm('Message', 'Do you want to Allocate?', function(r){
        if(r==false){ return false; } else { doprocess(); }
    });
}
        
function doprocess() {
    var salikarray=new Array();
    var selectedrows=$('#salikgrid').jqxGrid('selectedrowindexes');
    for(var i=0;i<selectedrows.length;i++){
        salikarray.push($('#salikgrid').jqxGrid('getcellvalue',selectedrows[i],'trans'));
    }
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items= x.responseText;
            var itemval=items.trim();
            if(parseInt(itemval)=="10") {
                $.messager.alert('Message', ' Record Successfully Allocated ');
                var val="2";
                var uptodate=$("#uptodate").val();
                $("#allodiv").load("allocatelistGrid.jsp?chval="+val+"&uptodate="+uptodate);
                $("#hidediv").hide();
                dis();
                funreload(event);
            } else {
                $.messager.alert('Message', ' Not Allocated ');
                $("#hidediv").hide();
            }
        }
    }
    x.open("GET","saveonedata.jsp?salikarray="+salikarray+"&trftype="+document.getElementById("trftype").value
            +"&cmballocatebranch="+document.getElementById("cmballocatebranch").value+"&rentaldoc="+document.getElementById("rentaldoc").value
            +"&leasedoc="+document.getElementById("leasedoc").value+"&drdoc="+document.getElementById("drdoc").value
            +"&staffdoc="+document.getElementById("staffdoc").value+"&fleet_no="+document.getElementById("fleet_no").value);
    x.send();   
}
    
function dis() {
    document.getElementById("saliktag").value="";
    document.getElementById("fleet_no").value="";
    document.getElementById("typesearch").value="";
    document.getElementById("rentaldoc").value="";
    document.getElementById("leasedoc").value="";
    document.getElementById("drdoc").value="";
    document.getElementById("staffdoc").value="";
    
    $('#ticketno').attr("disabled",true);
    $('#fleet_no').attr("disabled",true);
    $('#trftype').attr("disabled",true);
    $('#cmballocatebranch').attr("disabled",true);
    $('#allocates').attr("disabled",true);
    $('#typesearch').attr("disabled",true);
}

function funchange(){
    if(document.getElementById('Chkfromdate').checked){
        $("#fromdate").jqxDateTimeInput({disabled: false}); 
        document.getElementById("hidchkdate").value="1";
    }else{
        $("#fromdate").jqxDateTimeInput({disabled: true}); 
        document.getElementById("hidchkdate").value="0";
    }
}
</script>
</head>

<body onload="hiddenbrh();getAllocateBranch();dis();">
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
            
            <div class="salikallocatecount blink-text" hidden>
                <b>Total Saliks Allocated:</b> <span class="currentsalikallocated"></span>
            </div>

            <!-- Main Filter Card -->
            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">From Date</td>
                        <td>
                            <div class="checkbox-wrap">
                                <input type="checkbox" id="Chkfromdate" name="Chkfromdate" onchange="funchange()">
                                <label for="Chkfromdate">Enable</label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell"></td>
                        <td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Up To</td>
                        <td><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Reg No</td>
                        <td>
                            <input type="text" id="regno" name="regno" readonly
                                   placeholder="Press F3 To Search" value='<s:property value="regno"/>'
                                   onkeydown="getregno(event);">
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Tag No</td>
                        <td>
                            <input type="text" id="tagno" name="tagno" readonly
                                   placeholder="Press F3 To Search" value='<s:property value="tagno"/>'
                                   onkeydown="gettagno(event);">
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Type</td>
                        <td>
                            <select id="cmbsaliktype" name="cmbsaliktype">
                                <option value="">--Select--</option>
                                <option value="SAL">Salik</option>
                                <option value="PAR">Parking</option>
                            </select>
                        </td>
                    </tr>
                </table>
                <div class="button-group">
                    <button type="button" id="driverUpdate" class="btn-submit" onclick="funallocate()">Allocate</button>
                    <button type="button" id="clear" class="btn-submit" onclick="funcleardata()" style="background:#64748b !important;">Clear</button>
                </div>
            </div>

            <!-- Manual Allocate Card -->
            <div class="filter-card">
                <div class="card-title">Manual Allocate</div>
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Salik Tag</td>
                        <td><input type="text" id="saliktag" name="saliktag" readonly value='<s:property value="saliktag"/>'></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Fleet No</td>
                        <td>
                            <input type="text" id="fleet_no" name="fleet_no" readonly
                                   placeholder="Press F3 To Search" value='<s:property value="fleet_no"/>'
                                   onkeydown="getfleet(event);">
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Type</td>
                        <td>
                            <select id="trftype" onchange="cleardatas()">
                                <option value="RAG">Rental</option>
                                <option value="LAG">Lease</option>
                                <option value="STF">Staff</option>
                                <option value="DRV">Driver</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Branch</td>
                        <td>
                            <select id="cmballocatebranch" name="cmballocatebranch" value='<s:property value="cmballocatebranch"/>'>
                                <option value="">--Select--</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Convict</td>
                        <td>
                            <input type="text" id="typesearch" name="typesearch" readonly
                                   placeholder="Press F3 To Search" value='<s:property value="typesearch"/>'
                                   onkeydown="gettypessearch(event)">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <button type="button" id="allocates" class="btn-submit" onclick="funoneallocate()" style="margin-top: 5px;">
                                Manual
                            </button>
                        </td>
                    </tr>
                </table>
            </div>

            <!-- Hidden Fields -->
            <div style="display:none;">
                <input type="hidden" id="gridlength" name="gridlength">
                <input type="hidden" id="rentaldoc" name="rentaldoc">
                <input type="hidden" id="leasedoc" name="leasedoc">
                <input type="hidden" id="drdoc" name="drdoc">
                <input type="hidden" id="staffdoc" name="staffdoc">
                <input type="hidden" id="hidchkdate" name="hidchkdate">
            </div>

        </div>
    </div>
</td>

<!-- ================= RIGHT SIDE (GRID) ================= -->
<td valign="top">
    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <form action="">
                <div id="allodiv">
                    <jsp:include page="allocatelistGrid.jsp"></jsp:include>
                </div>
            </form>
        </div>
    </div>
</td>

</tr>
</table>

</div>
</div>

<!-- POPUPS -->
<div id="regwindow"><div></div></div>
<div id="tagwindow"><div></div></div>
<div id="fleetwindow"><div></div></div>
<div id="commonwindow"><div></div></div>
<div id="commonwindow1"><div></div></div>

</div>
</body>
</html>