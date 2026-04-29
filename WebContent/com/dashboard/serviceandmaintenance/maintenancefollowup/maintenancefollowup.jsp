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
<style>
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

/* Flex 1 allows this middle section to scroll while keeping top and bottom fixed */
.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 20px 15px; 
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
    // UPDATED: Height to 24px and width to 100%
    $("#dateDue").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
});

function funExportBtn(){
    JSONToCSVCon(garagefolupexcel, 'Garage Followup Details', true);
}

function getinfo() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            
            var srno  = items[0].split(",");
            var process = items[1].split(",");
            var optionsbranch = '<option value="" selected>-- Select -- </option>';
            for (var i = 0; i < process.length; i++) {
                optionsbranch += '<option value="' + srno[i].trim() + '">'
                        + process[i] + '</option>';
            }
            $("select#cmbinfo").html(optionsbranch);
            
        }
    }
    x.open("GET","getinfo.jsp", true);
    x.send();
}

function funreload(event)
{
     var barchval = document.getElementById("cmbbranch").value;
     $("#duedatediv").load("mainGrid.jsp?barchval="+barchval);
     $("#duedetailsgrid").jqxGrid('clear');
}

function funchangeinfo()
{
  if($('#cmbinfo').val()==25 || $('#cmbinfo').val()==26)
  {
     $('#dateDue').jqxDateTimeInput({ disabled: false});
     $('#dateDue').jqxDateTimeInput('focus'); 
  }
}

function disitems()
{
     $('#dateDue').jqxDateTimeInput({ disabled: true});
     $('#cmbinfo').attr("disabled",true);
     $('#remarks').attr("readonly",true);
     $('#driverUpdate').attr("disabled",true);
}

function funupdate()
{
     if(document.getElementById("cmbinfo").value=="")
     {
         $.messager.alert('Message','Select Process ','warning');   
         return 0;
     }
    
     if($('#remarks').val()=="")
     {
         $.messager.alert('Message','Enter Remarks ','warning');   
         return 0;
     }
    
     var remarkss = document.getElementById("remarks").value;
     if(remarkss.length > 99)
     {
         $.messager.alert('Message',' Remarks cannot contain more than 100 characters ','warning');   
         return false; 
     } 
      
     var fleetno=document.getElementById("fleetno").value;
     var grgid=document.getElementById("grgid").value;
     var rentaldocno = document.getElementById("rentaldoc").value;
     var branchids = document.getElementById("branchids").value;
     var remarks = document.getElementById("remarks").value;
     var cmbinfo = document.getElementById("cmbinfo").value;
     var exdate =  $('#dateDue').val();
    
     $.messager.confirm('Message', 'Do you want to save changes?', function(r){
         if(r){
             savegriddata(rentaldocno,branchids,remarks,cmbinfo,exdate,fleetno,grgid);    
         }
     });
}

function savegriddata(rentaldocno,branchids,remarks,cmbinfo,exdate,fleetno,grgid)
{
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
    if (x.readyState==4 && x.status==200)
        {
             document.getElementById("fleetno").value="";
             document.getElementById("rentaldoc").value="";
             document.getElementById("branchids").value="";
             document.getElementById("remarks").value="";
             document.getElementById("cmbinfo").value="";
             document.getElementById("grgid").value="";
             $('#dateDue').val(new Date());
             
             $.messager.alert('Message', ' Record Successfully Updated ');
             funreload(event); 
             $("#duedetailsgrid").jqxGrid('clear');
             disitems();
        }
    }
    x.open("GET","savemaint.jsp?rentaldocno="+rentaldocno+"&branchids="+branchids+"&remarks="+remarks+"&cmbinfo="+cmbinfo+"&exdate="+exdate+"&fleetno="+fleetno+"&grgid="+grgid,true);
    x.send();
}
</script>
</head>
<body onload="getBranch();getinfo();disitems();">

<div id="mainBG" class="homeContent">
<div class="hidden-scrollbar">

<div class="master-container">

    <div class="sidebar-filters">

        <div class="sidebar-fixed-top">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>

        <div class="sidebar-scroll-content">
            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Fleet No</td>
                        <td>
                            <input type="text" id="fleetno" name="fleetno" readonly
                                   value='<s:property value="fleetno"/>'>
                        </td>
                    </tr>

                    <tr>
                        <td class="label-cell">Process</td>
                        <td>
                            <select id="cmbinfo" name="cmbinfo" onchange="funchangeinfo()">
                            </select>
                        </td>
                    </tr>

                    <tr>
                        <td class="label-cell">Date</td>
                        <td>
                            <div id="dateDue"></div>
                        </td>
                    </tr>

                    <tr>
                        <td class="label-cell">Remarks</td>
                        <td>
                            <input type="text" id="remarks" name="remarks"
                                   value='<s:property value="remarks"/>'>
                        </td>
                    </tr>
                </table>

                <div class="button-group" style="margin-top: 15px;">
                    <button type="button" class="btn-submit" onclick="funupdate();" style="margin-top:0;">
                        Update
                    </button>
                </div>
            </div>

            <input type="hidden" id="branchids" name="branchids" value='<s:property value="branchids"/>'>
            <input type="hidden" id="rentaldoc" name="rentaldoc" value='<s:property value="rentaldoc"/>'>
            <input type="hidden" id="grgid" name="grgid" value='<s:property value="grgid"/>'>
        </div>
    </div>

    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="duedatediv">
                <jsp:include page="mainGrid.jsp"></jsp:include>
            </div>

            <div id="detaildiv" style="margin-top: 20px;">
                <jsp:include page="detailgrid.jsp"></jsp:include>
            </div>
        </div>
    </div>

</div>

</div>
</div>
</body>
</html>