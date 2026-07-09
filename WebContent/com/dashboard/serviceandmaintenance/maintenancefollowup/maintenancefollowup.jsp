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
<style>
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
    width: 280px; /* Uniform width */
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
    padding: 15px 15px 25px; /* Uniform tighter padding */
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
.release-filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.release-filter-table .label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    width: 80px; /* Standardized label column width */
}

/* ===== UNIFORM 24px INPUTS & SELECTS ===== */
input[type="text"], select,
.release-filter-table input[type="text"],
.release-filter-table select {
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
}

/* Custom dropdown arrow for native selects */
select {
    padding: 2px 24px 2px 8px;
    appearance: none;
    -webkit-appearance: none;
    -moz-appearance: none;
    background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%234e5e71' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
    background-repeat: no-repeat;
    background-position: right 6px center;
    background-size: 12px;
}

/* Readonly / disabled look */
input[readonly],
input:disabled,
select:disabled,
.release-filter-table input[readonly],
.release-filter-table input:disabled,
.release-filter-table select:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed;
    cursor: not-allowed;
}

/* jqx date container */
.release-filter-table div[id^="date"] {
    width: 100%;
}

/* ===== BUTTONS ===== */
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
    transition: background 0.2s;
    white-space: nowrap;
    text-align: center;
}

.btn-submit:hover {
    background: #1d4ed8;
}

/* Action layout modifications */
.release-actions {
    display: flex;
    gap: 10px;
    justify-content: center;
    margin-top: 15px;
}

/* ===== RIGHT CONTENT AREA (Dynamically fills screen) ===== */
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

/* Override strip background styles */
.sidebar-filters label.branch, 
.sidebar-filters .filter-card label,
.sidebar-filters .branch {
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
    padding-left: 4px;
    background: transparent !important;
}
</style>
 
<script type="text/javascript">
$(document).ready(function () {
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
    <div class="master-container">

        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">
                <div class="filter-card">
                    <table class="release-filter-table">
                        <tr>
                            <td class="label-cell">Fleet No</td>
                            <td>
                                <input type="text" id="fleetno" name="fleetno" readonly value='<s:property value="fleetno"/>'>
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
                                <input type="text" id="remarks" name="remarks" value='<s:property value="remarks"/>'>
                            </td>
                        </tr>
                    </table>

                    <div class="release-actions">
                        <button type="button" class="btn-submit" onclick="funupdate();">Update</button>
                    </div>
                </div>

                <input type="hidden" id="branchids" name="branchids" value='<s:property value="branchids"/>'>
                <input type="hidden" id="rentaldoc" name="rentaldoc" value='<s:property value="rentaldoc"/>'>
                <input type="hidden" id="grgid" name="grgid" value='<s:property value="grgid"/>'>
            </div>
        </div>

        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
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

</body>
</html>