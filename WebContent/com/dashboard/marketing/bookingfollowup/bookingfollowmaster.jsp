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
    font-size: 12px; /* Uniform 12px label */
    font-weight: 600;
    color: #4e5e71;
    width: 90px;
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
}

/* ===== BUTTONS ===== */
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
    margin-top: 8px;
}

.btn-submit:hover {
    background: #1d4ed8 !important;
}

.btn-submit:disabled {
    background: #9ca3af !important;
    cursor: not-allowed;
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

/* Strips inherited green background */
.sidebar-filters label.branch, 
.sidebar-filters .filter-card label,
.sidebar-filters .branch {
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
    background: transparent !important;
}
</style>

<script type="text/javascript">

$(document).ready(function () {
     $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

     // Standardized height to 24px
     $("#fromdate, #todate, #date, #jqxDateOut").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
     $("#jqxTimeOut").jqxDateTimeInput({ width: '100%', height: '24px', formatString: 'HH:mm', showCalendarButton: false });
    
     $('#vehinfowindow').jqxWindow({ width: '30%', height: '55%', maxHeight: '85%' ,maxWidth: '80%' ,title: 'Fleet Search' , position: { x: 200, y: 120 }, keyboardCloseKey: 27});
     $('#vehinfowindow').jqxWindow('close');
     $('#Rentalagentinfowindow').jqxWindow({ width: '30%', height: '55%', maxHeight: '75%' ,maxWidth: '50%' , title: 'Rental Agent Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
     $('#Rentalagentinfowindow').jqxWindow('close');
     $('#Checkoutinfowindow').jqxWindow({ width: '30%', height: '55%', maxHeight: '75%' ,maxWidth: '50%' , title: 'Checkout Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
     $('#Checkoutinfowindow').jqxWindow('close');
     $('#chauffeurinfowindow').jqxWindow({ width: '30%', height: '55%', maxHeight: '75%' ,maxWidth: '50%' , title: 'Driver Search' ,position: { x: 200, y: 70 }, keyboardCloseKey: 27});
     $('#chauffeurinfowindow').jqxWindow('close');
     $('#driverinfowindow').jqxWindow({ width: '50%', height: '58%', maxHeight: '62%' ,maxWidth: '50%' , title: 'Driver Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
     $('#driverinfowindow').jqxWindow('close');          
    
     var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
     var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));

     $('#todate').on('change', function (event) {
           var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
           var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
           if(fromdates>todates){
               $.messager.alert('Message','To Date Less Than From Date','warning');   
               return false;
          }    
     });
    
     $('#ratariff_checkout').dblclick(function(){
            $('#Checkoutinfowindow').jqxWindow('open');
            checkoutSearchContent('searchCheckout.jsp?', $('#Checkoutinfowindow')); 
     });

     $('#rarenral_Agent').dblclick(function(){
            $('#Rentalagentinfowindow').jqxWindow('open');
            rentalagentSearchContent('SearchRentalAgent.jsp?', $('#Rentalagentinfowindow')); 
     });

     $('#txtfleetno').dblclick(function(){
            $('#vehinfowindow').jqxWindow('open');
            vehinfoSearchContent('vehinfo.jsp?groupid='+$('#grpid').val()+'&branchids='+$('#branchids').val()); 
     });

     $('#radriverlist').dblclick(function(){
            $('#chauffeurinfowindow').jqxWindow('open');
            chauffeurSearchContent('SearchChauffeur.jsp?', $('#chauffeurinfowindow')); 
     });
     
     $('#clientdrv').dblclick(function(){
            $('#driverinfowindow').jqxWindow('open');
            driverinfoSearchContent('clientDriverSearch.jsp?clientval='+$('#clientid').val()); 
     });
});

// Search Functions preserved
function getcldrv(event){
     var x= event.keyCode;
     if(x==114){
      $('#driverinfowindow').jqxWindow('open');
      driverinfoSearchContent('clientDriverSearch.jsp?clientval='+$('#clientid').val());  }
}
function driverinfoSearchContent(url) {
     $.get(url).done(function (data) {
         $('#driverinfowindow').jqxWindow('open');
        $('#driverinfowindow').jqxWindow('setContent', data);
    }); 
} 
function getcheckout(event){
     var x= event.keyCode;
     if(x==114){
      $('#Checkoutinfowindow').jqxWindow('open');
     checkoutSearchContent('searchCheckout.jsp?', $('#Checkoutinfowindow'));   }
}
function checkoutSearchContent(url) {
     $.get(url).done(function (data) {
           $('#Checkoutinfowindow').jqxWindow('setContent', data);
    }); 
}
function getrentalAgent(event){
     var x= event.keyCode;
     if(x==114){
      $('#Rentalagentinfowindow').jqxWindow('open');
    rentalagentSearchContent('SearchRentalAgent.jsp?', $('#Rentalagentinfowindow'));  }
}
function rentalagentSearchContent(url) {
       $.get(url).done(function (data) {
           $('#Rentalagentinfowindow').jqxWindow('setContent', data);
    }); 
}
function getvehinfo(event){
     var x= event.keyCode;
     if(x==114){
      $('#vehinfowindow').jqxWindow('open');
      vehinfoSearchContent('vehinfo.jsp?groupid='+$('#grpid').val()+'&branchids='+$('#branchids').val());   }
}
function vehinfoSearchContent(url) {
         $.get(url).done(function (data) {
        $('#vehinfowindow').jqxWindow('setContent', data);
    }); 
}
function getchauffeur(event){
     var x= event.keyCode;
     if(x==114){
      $('#chauffeurinfowindow').jqxWindow('open');
     chauffeurSearchContent('SearchChauffeur.jsp?', $('#chauffeurinfowindow'));   }
}
function chauffeurSearchContent(url) {
    $.get(url).done(function (data) {
     $('#chauffeurinfowindow').jqxWindow('setContent', data);
       }); 
}

function funreload(event) {
    var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
    var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
    if(fromdates>todates){
        $.messager.alert('Message','To Date Less Than From Date','warning');   
        return false;
    } 
    else {
        var barchval = document.getElementById("cmbbranch").value;
        var fromdate= $("#fromdate").val();
        var todate= $("#todate").val();
        $("#overlay, #PleaseWait").show();
        $("#duedetailsgrid").jqxGrid('clear');
        $("#bookfollowdiv").load("bookingfollowGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate);
    }
}

function getinfo() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.split('####');
            var srno = items[0].split(",");
            var process = items[1].split(",");
            var options = '<option value="" selected>-- Select -- </option>';
            for (var i = 0; i < process.length; i++) {
                options += '<option value="' + srno[i].trim() + '">' + process[i] + '</option>';
            }
            $("select#cmbinfo").html(options);
        }
    }
    x.open("GET","getinfo.jsp", true);
    x.send();
}

function disitems() {
    $('#date, #jqxDateOut, #jqxTimeOut').jqxDateTimeInput({ disabled: true});
    $("#delcharge, #cmbinfo, #driverUpdate, #txtfleetno, #delivery_chk, #radrivercheck, #radriverlist, #clientdrv, #rarenral_Agent, #ratariff_checkout, #rentalcreate").prop("disabled", true);
    $('#remarks').prop("readonly", true);
}

function funupdate() {
    if(document.getElementById("cmbinfo").value=="") {
        $.messager.alert('Message','Select Process ','warning');   
        return 0;
    }
    if($('#remarks').val()=="") {
        $.messager.alert('Message','Enter Remarks ','warning');   
        return 0;
    }
    var remarkss = document.getElementById("remarks").value;
    if(remarkss.length>99) {
         $.messager.alert('Message',' Remarks cannot contain more than 100 characters ','warning');   
         return false; 
    } 
      
    var rdocno = document.getElementById("rdocno").value;
    var branchids = document.getElementById("branchids").value;
    var remarks = document.getElementById("remarks").value;
    var cmbinfo = document.getElementById("cmbinfo").value;
    var clname=document.getElementById("clname").value;
    var reftype=document.getElementById("reftype").value;
    var folldate = $('#date').val();

    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
        if(r) savegriddata(rdocno,branchids,remarks,cmbinfo,folldate,clname,reftype); 
    });
}

function savegriddata(rdocno,branchids,remarks,cmbinfo,folldate,clname,reftype) {
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
             document.getElementById("rdocno").value="";
             document.getElementById("branchids").value="";
             document.getElementById("remarks").value="";
             document.getElementById("cmbinfo").value="";
             document.getElementById("clname").value="";
             document.getElementById("reftype").value=""; 
             $('#date').val(new Date());
             $.messager.alert('Message', ' Record Successfully Updated ');
             funreload(event); 
             $("#duedetailsgrid").jqxGrid('clear');
             disitems();
        }
    }
    x.open("GET","booksavedata.jsp?rdocno="+rdocno+"&branchids="+branchids+"&remarks="+remarks+"&cmbinfo="+cmbinfo+"&folldate="+folldate+"&clname="+clname+"&reftype="+reftype,true);
    x.send();
}

function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode;
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)){
        $.messager.alert('Message', 'Enter Numbers Only');
        return false;
    }
    return true;
}

function funchangeinfo() { $('#date').jqxDateTimeInput( 'focus'); }

function funExportBtn(){
    $("#bookfollowdiv").excelexportjs({
        containerid: "bookfollowdiv", datatype: 'json', dataset: null, gridId: "qutfollowgrid",
        columns: getColumns("qutfollowgrid") , worksheetName:"Booking Follow Up"
    });
}

function fundriverdisable(){
   if (document.getElementById('delivery_chk').checked) {
       document.getElementById("radriverlist").value="";
       $("#radriverlist").prop("disabled", false);
       document.getElementById("radrivercheck").checked = false;
       $("#radrivercheck").prop("disabled", true);
       document.getElementById("del_chaufferid").value="";
       document.getElementById("delivery").value=1; 
       $("#delcharge").prop("disabled", false);
   } else {   
       $("#radriverlist").prop("disabled", true);
       $("#delcharge").prop("disabled", true);
       $("#radrivercheck").prop("disabled", false);
       document.getElementById('radriverlist').value="";
       document.getElementById("del_chaufferid").value="";
       document.getElementById("delcharge").value="";
       document.getElementById("delivery").value=0;
   } 
}

function funShaffurdisable(){
    if (document.getElementById('radrivercheck').checked) {
        document.getElementById("radriverlist").value="";
       $("#radriverlist").prop("disabled", false);
       document.getElementById("delivery_chk").checked = false;
       $("#delivery_chk").prop("disabled", true);
       document.getElementById("clientdrvid").value="";
       document.getElementById("clientdrv").value="";
       document.getElementById("del_chaufferid").value="";
      $("#clientdrv").prop("disabled", true);
      $("#delcharge").prop("disabled", true);
         document.getElementById("chuef").value=1;
         document.getElementById("delcharge").value="";
   } else {
       $("#radriverlist").prop("disabled", true);
        $("#delivery_chk").prop("disabled", false);
       document.getElementById('radriverlist').value="";
       document.getElementById('delcharge').value="";
       $("#delcharge").prop("disabled", true);
       document.getElementById("del_chaufferid").value="";
       $("#delivery_chk").prop("clientdrv", false);
         document.getElementById("clientdrvid").value="";
         document.getElementById("clientdrv").value="";
         document.getElementById("del_chaufferid").value="";
        $("#clientdrv").prop("disabled", false);
         document.getElementById("chuef").value=0; 
   }
}

function chkavailable(valfleet,dateout,timeout) {
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
    if (x.readyState==4 && x.status==200) {
            var items=x.responseText;
    var chkfleet=items.trim();
         if(chkfleet==1) {
                 $.messager.alert('Message','Fleet Is Not Available ','warning');   
                 return 0;
         } else {
            var fleetnos = document.getElementById("txtfleetno").value;
            var rdocno = document.getElementById("rdocno").value;
             var deldrvss = document.getElementById("del_chaufferid").value;
             var clientdrs = document.getElementById("clientdrvid").value;
             var rantalagt = document.getElementById("tariffrenral_Agentid").value;
             var chkout = document.getElementById("ratariff_checkoutid").value;
             var delivery = document.getElementById("delivery").value;
             var chuef = document.getElementById("chuef").value;
             var delcharge = document.getElementById("delcharge").value;
             var mrano=document.getElementById("mrano").value;
             var branchids = document.getElementById("branchids").value;
             if(delcharge==""|| typeof(delcharge)=="undefined" ||typeof(delcharge)=="NaN") { delcharge=0;  }
            $.messager.confirm('Message', 'Do you want to Create A Rental Agreement?', function(r){
                if(r) creategriddata(rdocno,deldrvss,clientdrs,rantalagt,chkout,delivery,chuef,fleetnos,branchids,dateout,timeout,delcharge,mrano);  
             });
         }
        }
    }
x.open("GET","chkavailablefleet.jsp?valfleet="+valfleet+"&dateout="+dateout+"&timeout="+timeout,true);
x.send();
}

function funrentalcreate() {
    var fleetnos = document.getElementById("txtfleetno").value;
    var rdocno = document.getElementById("rdocno").value;
     var deldrvss = document.getElementById("del_chaufferid").value;
     var clientdrs = document.getElementById("clientdrvid").value;
     var rantalagt = document.getElementById("tariffrenral_Agentid").value;
     var chkout = document.getElementById("ratariff_checkoutid").value;
     var delivery = document.getElementById("delivery").value;
     var chuef = document.getElementById("chuef").value;
     var mrano=document.getElementById("mrano").value;
     var branchids=document.getElementById("branchids").value;
    
     if($('#txtfleetno').val()=="") {
         $.messager.alert('Message','Select Fleet','warning');   
         return 0;
     }
    
      if ((document.getElementById('delivery_chk').checked)) {
           var delchrg=document.getElementById("delcharge").value;
                if(delchrg=="") {
                     $.messager.alert('Message','Enter Delivery Charge ','warning');   
                    return 0;
                }
       }
     if ((document.getElementById('delivery_chk').checked)||(document.getElementById('radrivercheck').checked)) {
       var drvname=document.getElementById("radriverlist").value;
            if(drvname=="") {
                 $.messager.alert('Message','Select Driver ','warning');   
                return 0;
            }
   }
    
    if(rantalagt=="") {
         $.messager.alert('Message','Select Rental Agent ','warning');   
         return 0;
     }
    
     if(chkout=="") {
         $.messager.alert('Message','Select Checkout','warning');   
         return 0;
     }
    
      var valfleetno=document.getElementById("txtfleetno").value;
        var dateout=$('#jqxDateOut').val();
        var timeout=$('#jqxTimeOut').val();
        
        var maindate = $('#jqxDateOut').jqxDateTimeInput('getDate');
        var currentDate = new Date(new Date());
     
        if(maindate>currentDate){
             $.messager.alert('Message','Future Date, Transaction Restricted.','warning');   
        return 0;
       } 
        
        chkavailable(valfleetno,dateout,timeout);
}

function creategriddata(rdocno,deldrvss,clientdrs,rantalagt,chkout,delivery,chuef,fleetnos,branchids,dateout,timeout,delcharge,mrano) {
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
    if (x.readyState==4 && x.status==200) {
            var items=x.responseText.trim();
            if(items=='NO') {
                $.messager.alert('Message', 'Not Create ');
            } else {
                 document.getElementById("rdocno").value="";
                     document.getElementById("txtfleetno").value="";
                     document.getElementById("rdocno").value="";
                      document.getElementById("del_chaufferid").value="";
                      document.getElementById("clientdrvid").value="";
                      document.getElementById("tariffrenral_Agentid").value="";
                      document.getElementById("ratariff_checkoutid").value="";
                      document.getElementById("delivery").value="";
                      document.getElementById("chuef").value="";
                     document.getElementById("radriverlist").value="";
                     document.getElementById("delcharge").value="";
                    document.getElementById("mrano").value="";
                     
                         document.getElementById("clientdrv").value="";
                          document.getElementById("rarenral_Agent").value="";
                          document.getElementById("ratariff_checkout").value="";
                         document.getElementById("delivery_chk").checked=false; 
                    
                         document.getElementById("radrivercheck").checked=false; 
                          $('#jqxDateOut').val(new Date());
                          $('#jqxTimeOut').val(new Date());
            
                $.messager.alert('Message', ' Successfully Created '+'RA NO Is '+items);
                 funreload(event); 
        
                disitems();
            }
        }
    }
x.open("GET","rentalagmtsavedata.jsp?docno="+rdocno+"&deldrvss="+deldrvss+"&clientdrs="+clientdrs+"&rantalagt="+rantalagt+"&chkout="+chkout+"&delivery="+delivery+"&chuef="+chuef+'&fleetnos='+fleetnos+'&branchids='+branchids+'&dateout='+dateout+'&timeout='+timeout+'&delcharge='+delcharge+"&mrano="+mrano,true);
x.send();
}
</script>
</head>

<body onload="getBranch();getinfo();disitems();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr>

<td width="330px" valign="top">
<div class="master-container">
<div class="sidebar-filters">

    <div class="sidebar-fixed-top">
        <jsp:include page="../../heading.jsp"></jsp:include>
    </div>

    <div class="sidebar-scroll-content">

        <div class="filter-card">
            <table class="filter-table">
                <tr>
                    <td class="label-cell">From</td>
                    <td><div id='fromdate'></div></td>
                </tr>
                <tr>
                    <td class="label-cell">To</td>
                    <td><div id='todate'></div></td>
                </tr>
            </table>
        </div>

        <div class="filter-card">
            <table class="filter-table">
                <tr>
                    <td class="label-cell">Process</td>
                    <td><select id="cmbinfo" name="cmbinfo" onchange="funchangeinfo()"></select></td>
                </tr>
                <tr>
                    <td class="label-cell">Date</td>
                    <td><div id='date'></div></td>
                </tr>
                <tr>
                    <td class="label-cell">Remarks</td>
                    <td><input type="text" id="remarks" name="remarks"></td>
                </tr>
            </table>

            <button type="button" class="btn-submit" id="driverUpdate" onclick="funupdate();">
                Update
            </button>
        </div>

        <div class="filter-card">
            <fieldset>
                <legend>Rental Agreement Create</legend>
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Fleet</td>
                        <td><input type="text" id="txtfleetno" name="txtfleetno" readonly placeholder="Press F3" onkeydown="getvehinfo(event);" /></td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center" style="padding:5px 0;">
                            <label class="branch">Del</label> <input type="checkbox" id="delivery_chk" onchange="fundriverdisable()">
                            <label class="branch">Chau</label> <input type="checkbox" id="radrivercheck" onchange="funShaffurdisable()">
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Del Chg</td>
                        <td><input type="text" id="delcharge" name="delcharge" style="text-align:right;" onblur="funRoundAmt(this.value,this.id);" onkeypress="return isNumber(event);"/></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Driver</td>
                        <td><input type="text" readonly id="radriverlist" name="radriverlist" placeholder="Press F3" onkeydown="getchauffeur(event);" /></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Client Drv</td>
                        <td><input type="text" id="clientdrv" readonly name="clientdrv" placeholder="Press F3" onkeydown="getcldrv(event);" /></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Agent</td>
                        <td><input type="text" id="rarenral_Agent" readonly placeholder="Press F3" onkeydown="getrentalAgent(event);" /></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Checkout</td>
                        <td><input type="text" id="ratariff_checkout" readonly placeholder="Press F3" onkeydown="getcheckout(event);" /></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Out Date</td>
                        <td><div id='jqxDateOut'></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Out Time</td>
                        <td><div id='jqxTimeOut'></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">MRA No</td>
                        <td><input type="text" id="mrano" name="mrano"/></td>
                    </tr>
                </table>

                <button type="button" class="btn-submit" id="rentalcreate" onclick="funrentalcreate();">
                    Create
                </button>
            </fieldset>
        </div>
        
    </div>
</div>
</div>
</td>

<td valign="top">
    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="bookfollowdiv">
                <jsp:include page="bookingfollowGrid.jsp"></jsp:include>
            </div>

            <div id="detaildiv" style="margin-top:15px;">
                <jsp:include page="detailgrid.jsp"></jsp:include>
            </div>
        </div>
    </div>
</td>

</tr>
</table>

<input type="hidden" name="branchids" id="branchids" value='<s:property value="branchids"/>' >
<input type="hidden" name="rdocno" id="rdocno" value='<s:property value="rdocno"/>' >
<input type="hidden" name="clname" id="clname" value='<s:property value="clname"/>' >
<input type="hidden" name="reftype" id="reftype" value='<s:property value="reftype"/>' >
<input type="hidden" id="delivery" name="delivery" value="0">
<input type="hidden" id="chuef" name="chuef" value="0">
<input type="hidden" id="del_chaufferid">
<input type="hidden" id="clientdrvid">
<input type="hidden" id="tariffrenral_Agentid">
<input type="hidden" id="ratariff_checkoutid">

<div id="vehinfowindow"><div></div></div>
<div id="Rentalagentinfowindow"><div></div></div>
<div id="Checkoutinfowindow"><div></div></div>
<div id="chauffeurinfowindow"><div></div></div>
<div id="driverinfowindow"><div></div></div>

</div>
</div>
</body>
</html>