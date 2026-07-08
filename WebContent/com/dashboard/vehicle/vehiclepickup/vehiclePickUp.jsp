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
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<style type="text/css">
  
/* ===== MASTER LAYOUT ===== */
html, body, #mainBG, .hidden-scrollbar {
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

/* Cards Layout Rules */
.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

/* Internal Presentation Tables */
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
    width: 80px;
}

/* Fieldset Section Header Look */
legend {
    font-size: 11px;
    font-weight: bold;
    color: #2563eb;
    text-transform: uppercase;
    margin-bottom: 5px;
}

fieldset {
    border: 1px solid #e3e8ee;
    border-radius: 8px;
    padding: 10px;
    margin: 0;
}

/* ===== UNIFORM 24px INPUTS, SELECTS, & TEXTAREAS ===== */
input[type="text"], select, textarea,
.filter-table input[type="text"],
.filter-table select,
.filter-table textarea {
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
    font-family: inherit;
}

/* Textarea specific overrides */
textarea {
    height: 50px !important;
    resize: none;
}

#agmtdetails {
    height: 80px !important;
}

/* Select specific styling */
select {
    padding: 2px 24px 2px 8px !important; 
    cursor: pointer;
    appearance: none;
    -webkit-appearance: none;
    background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%234e5e71' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
    background-repeat: no-repeat;
    background-position: right 6px center;
    background-size: 12px;
}

/* Readonly fields override */
input[readonly],
input:disabled,
select:disabled,
textarea[readonly] {
    background-color: #f3f6f9 !important;
    color: #7e8c9a;
    cursor: not-allowed;
}

/* jqx Date Container Mapping Rules */
.filter-table div[id^="periodupto"],
.filter-table div[id^="indate"],
.filter-table div[id^="intime"] {
    width: 100%;
}

/* ===== MASTER 30px BUTTON SYSTEM ===== */
.btn-submit {
    width: 100%;
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
    white-space: nowrap;
    text-align: center;
    transition: all 0.2s ease;
    box-shadow: none !important;
    display: inline-block;
    box-sizing: border-box;
}

.btn-submit:hover {
    background: #1d4ed8 !important;
}

.btn-danger {
    background: #dc2626 !important;
}

.btn-danger:hover {
    background: #b91c1c !important;
}

.button-group {
    display: flex;
    gap: 8px;
    margin-top: 5px;
}

.button-group .btn-submit {
    flex: 1;
}

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

.scrollable-grid-area {
    flex: 1;
    width: 100%;
    padding: 15px 20px;
    overflow: auto; 
    box-sizing: border-box;
}
</style>
<script type="text/javascript">

$(document).ready(function () {
    
    document.getElementById("btnpickupsave").style.display="none";
    $("#overlay, #PleaseWait").hide();
    
    $('#agmtnowindow').jqxWindow({ width: '60%', height: '68%',  maxHeight: '68%' ,maxWidth: '60%' , title: 'Agreement Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#agmtnowindow').jqxWindow('close');
    
    $("#periodupto").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    $("#indate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    $("#intime").jqxDateTimeInput({ width: '100%', height: '24px', formatString: 'HH:mm', showCalendarButton: false ,value:null});
     
    funDisable();
     
    $('#agmtvocno').dblclick(function(){
         var agmttype=document.getElementById("cmbtype").value;
                if(document.getElementById("cmbbranch").value==""){
                    $.messager.alert('Message','Branch is Mandatory','warning');
                    return false;
                }
                if(document.getElementById("cmbtype").value==""){
                    $.messager.alert('Message','Agreement Type is Mandatory','warning');
                    return false;
                }
        $('#agmtnowindow').jqxWindow('open');
        $('#agmtnowindow').jqxWindow('focus');

        agmtnoSearchContent('agmtnoSearch.jsp?agmt='+agmttype);
    });
 
    funClearData();
});

function getAgmt(event){
     var agmttype=document.getElementById("cmbtype").value;
    if(document.getElementById("cmbbranch").value==""){
        $.messager.alert('Message','Branch is Mandatory','warning');
        return false;
    }
    if(document.getElementById("cmbtype").value==""){
        $.messager.alert('Message','Agreement Type is Mandatory','warning');
        return false;
    }
     var x= event.keyCode;
   if(x==114){
        $('#agmtnowindow').jqxWindow('open');
        $('#agmtnowindow').jqxWindow('focus');
         agmtnoSearchContent('agmtnoSearch.jsp?agmt='+agmttype);
   }
   else{
    }
    
}
function agmtnoSearchContent(url) {
      $.get(url).done(function (data) {
    $('#agmtnowindow').jqxWindow('setContent', data);

}); 
}
function funDisable(){
    $('#pickupfield').prop('disabled',true);
    $('#indate').jqxDateTimeInput('disabled',true);
}
function funpickupadd(){
    $('#pickupfield').prop('disabled',false);
    $('#indate').jqxDateTimeInput('disabled',false);
    document.getElementById("btnpickupadd").style.display="none";
    document.getElementById("btnpickupsave").style.display="block";
}
function funpickupsave(){
    if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=='a'){
        $.messager.alert('Message','Please Select a Branch','warning');
        return false;
    }
    if(document.getElementById("agmtvocno").value==""){
        $.messager.alert('Message','Agreement is Mandatory','warning');
        return false;
    }
    if($('#indate').jqxDateTimeInput('getDate')==null){
        $.messager.alert('Message','Pick Up Date is Mandatory','warning');
        return false;
    }
    if($('#intime').jqxDateTimeInput('getDate')==null){
        $.messager.alert('Message','Pick Up Time is Mandatory','warning');
        return false;
    }
    
    var startkm= document.getElementById("hidkm").value;
    var typekm=document.getElementById("inkm").value;
    if(parseInt(typekm)<parseInt(startkm)){
        $.messager.alert('Message','Pick Up KM is Less than Start Km','warning');
        return false;
    }
    
    document.getElementById("mode").value="A";
     $("#overlay, #PleaseWait").show();
    document.getElementById("frmVehiclePickup").submit();

}

function funreload(event){
      var branchval = document.getElementById("cmbbranch").value;
     
     $("#pickupdiv").load("pickupGrid.jsp?branchval="+branchval);
 
 }
 function setValues(){
    getBranch();
     if($('#msg').val()!=""){
           $.messager.alert('Message',$('#msg').val());
          }
    
 }
 function funPickupPrint(){
     if(document.getElementById("docno").value==""){
         $.messager.alert('Message','Please Select a Document','warning');
         return false;
     }
     else{
        
         var url=document.URL;
         if(document.getElementById("mode").value==""){
             var reurl=url.split("vehiclePickUp.jsp");   
             var win= window.open(reurl[0]+"vehiclePickUpPrint?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
                win.focus(); 
         }
         else {
             var reurl=url.split("saveVehiclePickup");
             var win= window.open(reurl[0]+"vehiclePickUpPrint?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
                win.focus(); 
         }
        
     }
 }
 
 function funPickupDelete(){
     if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=='a'){
            $.messager.alert('Message','Please Select a Branch','warning');
            return false;
        }
     if(document.getElementById("docno").value==""){
         $.messager.alert('Message','Please Select a Document','warning');
         return false;
     }
     else{
        document.getElementById("mode").value="D";
         $("#overlay, #PleaseWait").show();
        document.getElementById("frmVehiclePickup").submit();
     }
 }
 
 
 function funClearData(){
     $('#cmbagmttype').val('');
     $('#agmtvocno').val('');
     $('#agmtno').val('');
     $('#fleet_details').val('');
     $('#fleet_no').val('');
     $('#indate').jqxDateTimeInput('setDate',null);
     $('#intime').jqxDateTimeInput('setDate',null);
     $('#inkm').val('');
     $('#cmbinfuel').val('');
     $('#pickdesc').val('');
     $('#docno').val('');
 }
 
</script>
</head>
<body onload="setValues();">
<form id="frmVehiclePickup" action="saveVehiclePickup" method="post" autocomplete="off">

<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<div class="master-container">

    <!-- ================= LEFT PANEL (SIDEBAR) ================= -->
    <div class="sidebar-filters">
        <div class="sidebar-scroll-content">

            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Upto</td>
                        <td><div id="periodupto"></div></td>
                    </tr>
                </table>

                <button type="button" class="btn-submit" id="btnpickupadd" onclick="funpickupadd();" style="margin-top: 15px;">Add</button>
                <button type="button" class="btn-submit" id="btnpickupsave" onclick="funpickupsave();" style="margin-top: 15px;">Save</button>
            </div>

            <div class="filter-card">
                <fieldset id="pickupfield">
                    <legend>In Details</legend>

                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">Type</td>
                            <td>
                                <select name="cmbtype" id="cmbtype">
                                    <option value="">--Select--</option>
                                    <option value="RAG">Rental</option>
                                    <option value="LAG">Lease</option>
                                </select>
                            </td>
                        </tr>

                        <tr>
                            <td class="label-cell">Agmt</td>
                            <td>
                                <input type="text" name="agmtvocno" id="agmtvocno" readonly>
                                <input type="hidden" name="agmtno" id="agmtno">
                            </td>
                        </tr>

                        <tr>
                            <td class="label-cell">Fleet</td>
                            <td>
                                <input type="text" name="fleetdetails" id="fleetdetails" readonly>
                                <input type="hidden" name="fleet_no" id="fleet_no">
                            </td>
                        </tr>

                        <tr>
                            <td class="label-cell">Date</td>
                            <td><div id="indate"></div></td>
                        </tr>

                        <tr>
                            <td class="label-cell">Time</td>
                            <td><div id="intime"></div></td>
                        </tr>

                        <tr>
                            <td class="label-cell">Km</td>
                            <td><input type="text" name="inkm" id="inkm"></td>
                        </tr>

                        <tr>
                            <td class="label-cell">Fuel</td>
                            <td>
                                <select name="cmbinfuel" id="cmbinfuel">
                                    <option value="">--Select--</option>
                                    <option value="0.000">0/8</option>
                                    <option value="0.125">1/8</option>
                                    <option value="0.250">2/8</option>
                                    <option value="0.500">4/8</option>
                                    <option value="1.000">8/8</option>
                                </select>
                            </td>
                        </tr>

                        <tr>
                            <td class="label-cell">Details</td>
                            <td>
                                <textarea name="pickdesc" id="pickdesc"></textarea>
                            </td>
                        </tr>

                    </table>
                </fieldset>
            </div>
            
            <div class="filter-card">
                <div class="button-group">
                    <button type="button" class="btn-submit" id="btnpickupprint" onclick="funPickupPrint();">Print</button>
                    <button type="button" class="btn-submit btn-danger" id="btnpickypdelete" onclick="funPickupDelete();">Delete</button>
                </div>
            </div>

            <div class="filter-card">
                <textarea id="agmtdetails" name="agmtdetails" readonly></textarea>
            </div>

        </div>
    </div>

    <!-- ================= RIGHT PANEL (WORKSPACE GRIDS) ================= -->
    <div class="main-content-area">
        
        <!-- Horizontally Aligned Heading Toolbar -->
        <div class="top-toolbar-container">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>

        <div class="scrollable-grid-area">
            <div id="pickupdiv">
                <jsp:include page="pickupGrid.jsp"></jsp:include>
            </div>
        </div>

    </div>

</div>

<!-- Safely Restored Hidden Inputs and Modals -->
<div style="display:none;">
    <input type="hidden" name="gridlength" id="gridlength">
    <input type="hidden" name="invgridlength" id="invgridlength">
    <input type="hidden" name="mode" id="mode">
    <input type="hidden" name="msg" id="msg">
    <input type="hidden" name="cldocno" id="cldocno">
    <input type="hidden" name="docno" id="docno">
    <input type="hidden" name="hidkm" id="hidkm">
</div>

<div id="agmtnowindow">
   <div></div>
</div>

</div>
</div>
</form>
</body>
</html>