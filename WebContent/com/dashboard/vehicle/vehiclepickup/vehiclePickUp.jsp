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
.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif; /* UNIFORM FONT */
    background-color: #f4f7f9;
}

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

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 20px 25px;
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

/* ===== UNIFORM 24px SELECT DROPDOWNS (FIXED) ===== */
select {
    width: 100%;
    height: 24px;
    padding: 2px 24px 2px 8px; /* Extra right padding so text doesn't hit the arrow */
    border: 1px solid #ccd6e0;
    border-radius: 4px;
    font-size: 12px;
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
    outline: none;
    font-family: inherit;
    cursor: pointer;
    
    /* Strip default OS styling */
    appearance: none;
    -webkit-appearance: none;
    -moz-appearance: none;
    
    /* Custom clean arrow */
    background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%234e5e71' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
    background-repeat: no-repeat;
    background-position: right 6px center;
    background-size: 12px;
}

/* Textarea styling matching inputs but without fixed height */
textarea {
    width: 100%;
    padding: 4px 8px;
    border: 1px solid #ccd6e0;
    border-radius: 4px;
    font-size: 12px;
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
    font-family: inherit;
    resize: vertical;
    outline: none;
}

input[readonly], input:disabled, select:disabled, textarea[readonly], textarea:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    cursor: not-allowed;
}

/* ===== FIELDSET STYLING ===== */
fieldset {
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    padding: 10px;
    margin: 0;
    background: #fff;
}

legend {
    font-size: 12px;
    font-weight: 600;
    color: #2563eb;
    padding: 0 5px;
    width: auto;
    border: none;
    margin-bottom: 0;
}

/* ===== BUTTONS ===== */
.button-group {
    display: flex;
    gap: 10px;
    justify-content: center;
    margin-top: 10px;
}

.btn-submit {
    flex: 1;
    width: 100%;
    height: 30px;            /* Scaled button height */
    padding: 0 12px;
    background: #2563eb;
    color: #fff;
    border: none;
    border-radius: 4px;
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
    line-height: 30px;
    white-space: nowrap;
}

.btn-submit:hover {
    background: #1d4ed8;
}

.btn-danger {
    background: #dc2626;
}

.btn-danger:hover {
    background: #b91c1c;
}

html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
}

td[width="80%"] {
    height: 100vh;
    vertical-align: top;
    background: #fff;
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

<table width="100%">
<tr>

<td width="20%" valign="top">
    <div class="master-container">
        <div class="sidebar-filters">

            <div class="sidebar-fixed-top">
                <div class="filter-card">
                    <jsp:include page="../../heading.jsp"></jsp:include>
                </div>
            </div>

            <div class="sidebar-scroll-content">

                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">Upto</td>
                            <td><div id="periodupto"></div></td>
                        </tr>
                    </table>

                    <button type="button"
                            class="btn-submit"
                            id="btnpickupadd"
                            onclick="funpickupadd();"
                            style="margin-top: 15px;">
                        Add
                    </button>

                    <button type="button"
                            class="btn-submit"
                            id="btnpickupsave"
                            onclick="funpickupsave();"
                            style="margin-top: 15px;">
                        Save
                    </button>
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
                                    <textarea name="pickdesc" id="pickdesc" style="height:50px;"></textarea>
                                </td>
                            </tr>

                        </table>
                    </fieldset>
                </div>
                
                <div class="button-group">
                    <button type="button"
                            class="btn-submit"
                            id="btnpickupprint"
                            onclick="funPickupPrint();">
                        Print
                    </button>

                    <button type="button"
                            class="btn-submit btn-danger"
                            id="btnpickypdelete"
                            onclick="funPickupDelete();">
                        Delete
                    </button>
                </div>

                <div class="filter-card" style="margin-top: 15px;">
                    <textarea id="agmtdetails" name="agmtdetails" style="height:80px;" readonly></textarea>
                </div>

            </div>
        </div>
    </div>
</td>

<td width="80%" valign="top">
    <table width="100%">
        <tr>
            <td>
                <div id="pickupdiv">
                    <jsp:include page="pickupGrid.jsp"></jsp:include>
                </div>

                <input type="hidden" name="gridlength" id="gridlength">
                <input type="hidden" name="invgridlength" id="invgridlength">
                <input type="hidden" name="mode" id="mode">
                <input type="hidden" name="msg" id="msg">
                <input type="hidden" name="cldocno" id="cldocno">
                <input type="hidden" name="docno" id="docno">
                <input type="hidden" name="hidkm" id="hidkm">
            </td>
        </tr>
    </table>
</td>

</tr>
</table>

</div>

<div id="agmtnowindow">
   <div></div>
</div>

</div>
</form>
</body>
</html>