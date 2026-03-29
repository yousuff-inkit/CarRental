<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<jsp:include page="../../../../includes.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="../../../../css/body.css"> 

<style>
/* =========================================================
   SCOPED UI: Perfectly Aligned Grid Layout
   * Protected: CSS will ONLY apply inside .modern-ui *
========================================================= */

.modern-ui {
    font-family: Arial, sans-serif;
    color: #333;
    font-size: 12px;
    box-sizing: border-box;
    padding-top: 15px;
}

/* Master Input Heights - Set to 24px */
.modern-ui input[type="text"], 
.modern-ui select, 
.modern-ui textarea {
    height: 24px !important;
    border: 1px solid #ccc;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box;
    background-color: #fff;
    color: #333;
    width: 100%;
}

/* Compact Width Overrides */
.modern-ui .input-xs { width: 60px !important; flex: none !important; }
.modern-ui .input-sm { width: 100px !important; flex: none !important; }
.modern-ui .input-md { width: 140px !important; flex: none !important; }
.modern-ui .input-full { flex: 1; }

.modern-ui input[type="text"]:focus, 
.modern-ui select:focus {
    border-color: #007bff;
    outline: none;
}

.modern-ui input[readonly], 
.modern-ui select:disabled, 
.modern-ui input:disabled {
    background-color: #f3f4f6;
    color: #6b7280;
}

/* Strict Column Alignment */
.modern-ui .field-row {
    display: flex;
    align-items: center;
    gap: 8px;
    margin-bottom: 10px;
}

.modern-ui .lbl-right {
    text-align: right;
    color: #444;
    font-size: 12px;
    font-weight: bold;
    white-space: nowrap;
    display: inline-block;
}

/* Panels */
.modern-ui .modern-panel {
    border: 1px solid #e1e4e8;
    padding: 20px 15px 10px 15px;
    background: #fff;
    position: relative;
    border-radius: 4px;
    margin-bottom: 20px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.05);
}

.modern-ui .modern-panel-title {
    position: absolute;
    top: -10px;
    left: 10px;
    background: #fff;
    padding: 0 5px 0 6px;
    color: #0056b3;
    font-weight: bold;
    font-size: 13px;
    border-left: 3px solid #0056b3;
}

.modern-ui .chk-container {
    display: flex;
    align-items: center;
    gap: 4px;
    cursor: pointer;
    color: #0056b3;
    font-size: 13px;
    font-weight: bold;
    margin: 0;
}

.modern-ui .chk-container input {
    margin: 0;
    padding: 0;
}

.modern-ui .myButton {
    font-weight: 700;
    font-size: 11px;
    height: 24px !important;
    padding: 0px 16px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    white-space: nowrap;
}

.modern-ui .myButton:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%);
}

.modern-ui .split-section {
    display: flex;
    gap: 20px;
}

.modern-ui .split-col {
    flex: 1;
    display: flex;
    flex-direction: column;
}

.hidden-scrollbar {
    overflow: auto;
    height: 550px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 0px; }
</style>

<script type="text/javascript">
$(document).ready(function () { 

    // Date definition (Fixed compact widths)
    $("#date").jqxDateTimeInput({ width: '120px', height: '24px',formatString:"dd.MM.yyyy"});
    $("#refdate").jqxDateTimeInput({ width: '120px', height: '24px',formatString:"dd.MM.yyyy",value:null}); 
    $("#dateout").jqxDateTimeInput({ width: '120px', height: '24px',formatString:"dd.MM.yyyy",value:null});
    $("#hidevmovedate").jqxDateTimeInput({ width: '120px', height: '24px',formatString:"dd.MM.yyyy",value:null}); 
    
    $("#colleteddate").jqxDateTimeInput({ width: '120px', height: '24px',formatString:"dd.MM.yyyy",value:null,enableBrowserBoundsDetection: true});
    $("#indate").jqxDateTimeInput({ width: '120px', height: '24px',formatString:"dd.MM.yyyy",value:null,enableBrowserBoundsDetection: true});
    $("#outdate").jqxDateTimeInput({ width: '120px', height: '24px',formatString:"dd.MM.yyyy",value:null,enableBrowserBoundsDetection: true});
    $("#deldate").jqxDateTimeInput({ width: '120px', height: '24px',formatString:"dd.MM.yyyy",value:null,enableBrowserBoundsDetection: true});
    
    // Time definition (Fixed compact widths)
    $("#timeout").jqxDateTimeInput({ width: '80px', height: '24px', formatString: 'HH:mm', showCalendarButton: false,value:null });
    $("#hidevmovetime").jqxDateTimeInput({ width: '80px', height: '24px', formatString: 'HH:mm', showCalendarButton: false,value:null });
    $("#deltime").jqxDateTimeInput({ width: '80px', height: '24px', formatString: 'HH:mm', showCalendarButton: false,value:null });
    $("#collectedtime").jqxDateTimeInput({ width: '80px', height: '24px', formatString: 'HH:mm', showCalendarButton: false,value:null });
    $("#intime").jqxDateTimeInput({ width: '80px', height: '24px', formatString: 'HH:mm', showCalendarButton: false,value:null });
    $("#outtime").jqxDateTimeInput({ width: '80px', height: '24px', formatString: 'HH:mm', showCalendarButton: false,value:null });

    /* Force internal alignment AFTER render */
    setTimeout(function () {
        $(".jqx-datetimeinput").find("input").css({
            "margin-top": "0px", 
            "line-height": "24px", 
            "font-size": "12px", 
            "font-family": "Arial, sans-serif",
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
    }, 0);

    $('#collectionwindow').jqxWindow({ width: '60%', height: '54%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Driver Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#collectionwindow').jqxWindow('close');
    $('#agmtnowindow').jqxWindow({ width: '60%', height: '56%',  maxHeight: '75%' ,maxWidth: '80%' , title: 'Agreement Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#agmtnowindow').jqxWindow('close');
 
    $('#collectiondriver').dblclick(function(){
        $('#collectionwindow').jqxWindow('open');
        $('#collectionwindow').jqxWindow('focus');
        collectionSearchContent('driverSearchGrid.jsp?id=1', $('#collectionwindow'));
    });
        
    $('#deldriver').dblclick(function(){
        $('#collectionwindow').jqxWindow('open');
        $('#collectionwindow').jqxWindow('focus');
        collectionSearchContent('driverSearchGrid.jsp?id=2',  $('#collectionwindow'));
    }); 
 
    $('#refno').dblclick(function(){
         if(document.getElementById("mode").value=="view"){
             return false;
         }
         if(document.getElementById("searchbranch").value==''){
             document.getElementById("errormsg").innerText="Branch Is Mandatory";
             document.getElementById("searchbranch").focus();
             return false;  
         }
         if(document.getElementById("cmbrentaltype").value==''){
             document.getElementById("errormsg").innerText="Rental Type Is Mandatory";
             document.getElementById("cmbrentaltype").focus();
             return false;  
         }
        document.getElementById("errormsg").innerText="";
        $('#agmtnowindow').jqxWindow('open');
        agmtnoSearchContent('agmtnoSearch.jsp?rentalbranch='+document.getElementById("searchbranch").value, $('#agmtnowindow'));
    });

    $('#date').on('change', function (event) {
        var maindate = $('#date').jqxDateTimeInput('getDate');
        if ($("#mode").val() == "A") {   
            funDateInPeriod(maindate);
        }
    });

    getTestLocation();

    $("#btnEdit").attr('disabled', true );

    $('#colleteddate,#indate,#outdate,#deldate').on('change', function (event) {
        var maindate = event.args.date;
        if ($("#mode").val() == "A") {   
            funDateInPeriod(maindate);
        }
    });
    
    $('#collectedtime,#intime,#outtime,#deltime').on('change', function (event) {
        var maintime = event.args.date;
        if ($("#mode").val() == "A") {
            var maindate;
            var targetid=$(event.currentTarget).attr('id');
            if(targetid.includes('collectedtime')){
                maindate=$('#colleteddate').jqxDateTimeInput('getDate');
            }
            else if(targetid.includes('intime')){
                maindate=$('#indate').jqxDateTimeInput('getDate');
            }
            else if(targetid.includes('outtime')){
                maindate=$('#outdate').jqxDateTimeInput('getDate');
            }
            else if(targetid.includes('deltime')){
                maindate=$('#deldate').jqxDateTimeInput('getDate');
            }
            maindate.setHours(0,0,0,0);
            maintime=new Date(maintime);
            var curdate=new Date();
            curdate.setHours(0,0,0,0);
            if(maindate-curdate==0){
                funFutureTimeRestrict(maintime.getHours(),maintime.getMinutes(),event.currentTarget);  
            }
        }
    });
});

function funFutureTimeRestrict(hrs,mins,elm){
    var curtime=new Date();
    if(parseInt(hrs)>parseInt(curtime.getHours())){
        document.getElementById("errormsg").innerText="Time cannot be greater than current time";
        $(elm).jqxDateTimeInput('focus');
        return false;
    }
    else if(parseInt(hrs)==parseInt(curtime.getHours())){
        if(parseInt(mins)>parseInt(curtime.getMinutes())){
            document.getElementById("errormsg").innerText="Time cannot be greater than current time";
            $(elm).jqxDateTimeInput('focus');
            return false;   
        }
    }
    else{
        document.getElementById("errormsg").innerText="";
        return true;
    }
}
function getAgmtno(event){
     if(document.getElementById("mode").value=="view"){ return false; }
     if(document.getElementById("searchbranch").value==''){
         document.getElementById("errormsg").innerText="Branch Is Mandatory";
        document.getElementById("searchbranch").focus();
         return false;  
     }
     if(document.getElementById("cmbrentaltype").value==''){
         document.getElementById("errormsg").innerText="Rental Type Is Mandatory";
        document.getElementById("cmbrentaltype").focus();
         return false;  
     }
    document.getElementById("errormsg").innerText="";
    var x= event.keyCode;
    if(x==114){
     $('#agmtnowindow').jqxWindow('open');
     agmtnoSearchContent('agmtnoSearch.jsp?rentalbranch='+document.getElementById("searchbranch").value, $('#agmtnowindow'));
    }
}

function collectionSearchContent(url) {
    $.get(url).done(function (data) { $('#collectionwindow').jqxWindow('setContent', data); }); 
}
function agmtnoSearchContent(url) {
    $.get(url).done(function (data) { $('#agmtnowindow').jqxWindow('setContent', data); }); 
}

function getDriver(event,id){
     var x= event.keyCode;
    if(x==114){
     $('#collectionwindow').jqxWindow('open');
        $('#collectionwindow').jqxWindow('focus');
        collectionSearchContent('driverSearchGrid.jsp?id='+id,  $('#collectionwindow'));
    }
}

function funReadOnly(){
        $('#custody input').attr('readonly', true );
        $('#custody select').attr('disabled', true);
        $('#date').jqxDateTimeInput({ disabled: true});
        $('#refdate').jqxDateTimeInput({ disabled: true});
        $('#dateout').jqxDateTimeInput({ disabled: true});
        $('#timeout').jqxDateTimeInput({ disabled: true});
        
        $('#colleteddate').jqxDateTimeInput({ disabled: true});
         $("#collection input").attr("disabled", true);
         $("#collection select").attr("disabled", true);
        
        $('#deldate').jqxDateTimeInput({ disabled: true});
         $("#delivery input").prop("disabled", true);
         $("#delivery select").prop("disabled", true);
        
        $('#indate').jqxDateTimeInput({ disabled: true});
        $('#outdate').jqxDateTimeInput({ disabled: true});
        $('#deltime').jqxDateTimeInput({ disabled: true});
        $('#collectedtime').jqxDateTimeInput({ disabled: true});
        $('#intime').jqxDateTimeInput({ disabled: true});
        $('#outtime').jqxDateTimeInput({ disabled: true});
        
        $('#chkcollection').attr('disabled', true);
        $('#chkdelivery').attr('disabled', true);
        
        $("#branchout input").attr("readonly", true);
        $("#branchout select").attr("disabled", true);
}

function funRemoveReadOnly(){
     $("#branchout input").attr("disabled", true);
     $("#branchout select").attr("disabled", true);
    
    $('#chkcollection').attr('disabled', false);
    $('#chkdelivery').attr('disabled', true);

        $('#date').jqxDateTimeInput({ disabled: false});
        $('#refdate').jqxDateTimeInput({ disabled: true});
        $('#dateout').jqxDateTimeInput({ disabled: true});
        $('#timeout').jqxDateTimeInput({ disabled: true});
        $('#indate').jqxDateTimeInput({ disabled: false});
        $('#intime').jqxDateTimeInput({ disabled: false});

        $('#custody input').attr('readonly', false );
        $('#custody select').attr('disabled', false);
            
        $('#colleteddate').jqxDateTimeInput({ disabled: true});
         $("#collection input").prop("disabled", true);
         $("#collection select").prop("disabled", true);
        
         $('#deldate').jqxDateTimeInput({ disabled: true});
         $("#delivery input").prop("disabled", true);
         $("#delivery select").prop("disabled", true);
    
        if(document.getElementById("mode").value=="A"){
            $('#date').val(new Date());
                
        $('#docno').prop('readonly',true);
        $('#txtfleetno').prop('readonly',true);
        $('#txtfleetname').prop('readonly',true);
        $('#refname').prop('readonly',true);
        $('#refno').prop('readonly',true);
        $('#outkm').prop('readonly',true);
        $('#reason').prop('readonly',true);
    
        $('#refdate').jqxDateTimeInput('setDate', null);
        $('#dateout').jqxDateTimeInput('setDate', null);
        $('#timeout').jqxDateTimeInput('setDate', null);
        $('#colleteddate').jqxDateTimeInput('setDate', null);
        $('#indate').jqxDateTimeInput('setDate', null);
        $('#outdate').jqxDateTimeInput('setDate', null);
        $('#deldate').jqxDateTimeInput('setDate', null);
        $('#collectedtime').jqxDateTimeInput('setDate', null);
        $('#intime').jqxDateTimeInput('setDate', null);
        $('#outtime').jqxDateTimeInput('setDate', null);
        $('#deltime').jqxDateTimeInput('setDate', null);
         $("#branchout input").attr("disabled", true);
         $("#branchout select").attr("disabled", true);
        
        $('#txtbranch').attr('readonly', true);
        $('#txtlocation').attr('readonly', true);
        document.getElementById("reason").value="Custody";
    }
}

function getBranch() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.split('***');
            var branchItems = items[0].split(",");
            var branchIdItems = items[1].split(",");
            var optionsbranch = '<option value="">--Select--</option>';
            for (var i = 0; i < branchItems.length; i++) {
                optionsbranch += '<option value="' + branchIdItems[i] + '">' + branchItems[i] + '</option>';
            }
            $("select#inbranch").html(optionsbranch);
            if ($('#hidebranch').val() != null) {
                $('#inbranch').val($('#hidebranch').val());
            }
        }
    }
    x.open("GET", "getBranch.jsp", true);
    x.send();
}


function getBranch1() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.split('***');
            var branchItems = items[0].split(",");
            var branchIdItems = items[1].split(",");
            var optionsbranch = '<option value="">--Select--</option>';
            for (var i = 0; i < branchItems.length; i++) {
                optionsbranch += '<option value="' + branchIdItems[i] + '">' + branchItems[i] + '</option>';
            }
            $("select#searchbranch").html(optionsbranch);
            if ($('#searchbranchval').val() != null) {
                $('#searchbranch').val($('#searchbranchval').val());
            }
        }
    }
    x.open("GET", "getBranch.jsp", true);
    x.send();
}

function chkstatus() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            if(items=="OUT") {
                $.messager.alert('Message','Fleet Is Not Available','warning');
                return 0;
            } else {
                items = items.split(',');
                var datein = items[0];
                var timein = items[1];
                var kmin = items[2];
                
                 $('#hidevmovedate').val(datein);
                 $('#hidevmovetime').val(timein);
                 $('#hidevmovekm').val(kmin);
                
                document.getElementById("outbranch").value="Update";
                $("#branchout input").prop("disabled", false);
                $("#branchout input").prop("readonly", false);
                 $("#branchout select").prop("disabled", false);
                 $('#outdate').jqxDateTimeInput({ disabled: false});
                  $('#outtime').jqxDateTimeInput({ disabled: false});
                  return 0;
            } 
        }
    }
    x.open("GET", "validateDetails.jsp?fleetno="+document.getElementById("txtfleetno").value, true);
    x.send();
}

function getLoc(value) {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.split('***');
            var locationItems = items[0].split(",");
            var locationIdItems = items[1].split(",");
            var optionslocation = '<option value="">--Select--</option>';
            for (var i = 0; i < locationItems.length; i++) {
                optionslocation += '<option value="' + locationIdItems[i] + '">' + locationItems[i] + '</option>';
            }
            $("select#inlocation").html(optionslocation);
            if ($('#hidelocation').val() != null) {
                $('#inlocation').val($('#hidelocation').val());
            }
        }
    }
    x.open("GET", "getLoc.jsp?id="+value, true);
    x.send();
}
    
function getTestLocation(){
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText.split('***');
                var locItems = items[0].split(",");
                var locIdItems = items[1].split(",");
                var optionsloc = '<option value="">--Select--</option>';
                for (var i = 0; i < locItems.length; i++) {
                    optionsloc += '<option value="' + locIdItems[i] + '">' + locItems[i] + '</option>';
                }
                $("select#inlocation").html(optionsloc);
                if ($('#hidelocation').val() != null) {
                $('#inlocation').val($('#hidelocation').val());
            }
            }
        }
        x.open("GET", "getTestLocation.jsp", true);
        x.send();
  }  

function funNotify(){   
        var maindate = $('#date').jqxDateTimeInput('getDate');
           var validdate=funDateInPeriod(maindate);
           if(validdate==0){
               $('#date').jqxDateTimeInput('focus');
           return 0; 
           }
        
           if(document.getElementById("chkcollection").checked==true) {
            var maindate1 = $('#colleteddate').jqxDateTimeInput('getDate');
               var validdate1=funDateInPeriod(maindate1);
               if(validdate1==0){
                   $('#colleteddate').jqxDateTimeInput('focus');
               return 0; 
               }
             maindate1.setHours(0,0,0,0);
            var maintime1=new Date($('#collectedtime').jqxDateTimeInput('getDate'));
            var curdate=new Date();
            curdate.setHours(0,0,0,0);
            if(maindate1-curdate==0){
                var curtime=new Date();
                if(parseInt(maintime1.getHours())>parseInt(curtime.getHours())){
                    document.getElementById("errormsg").innerText="Time cannot be greater than current time";
                    $('#collectedtime').jqxDateTimeInput('focus');
                    return 0;
                }
                else if(parseInt(maintime1.getHours())==parseInt(curtime.getHours())){
                    if(parseInt(maintime1.getMinutes())>parseInt(curtime.getMinutes())){
                        document.getElementById("errormsg").innerText="Time cannot be greater than current time";
                        $('#collectedtime').jqxDateTimeInput('focus');
                        return 0;   
                    }
                }
                else{
                    document.getElementById("errormsg").innerText="";
                }
            }   
            }  
                var maindate2 = $('#indate').jqxDateTimeInput('getDate');
                   var validdate2=funDateInPeriod(maindate2);
                   if(validdate2==0){
                       $('#indate').jqxDateTimeInput('focus');
                   return 0; 
                   }
                   
                   maindate2.setHours(0,0,0,0);
            var maintime2=new Date($('#intime').jqxDateTimeInput('getDate'));
            var curdate=new Date();
            curdate.setHours(0,0,0,0);
            if(maindate2-curdate==0){
                var curtime=new Date();
                if(parseInt(maintime2.getHours())>parseInt(curtime.getHours())){
                    document.getElementById("errormsg").innerText="Time cannot be greater than current time";
                    $('#intime').jqxDateTimeInput('focus');
                    return 0;
                }
                else if(parseInt(maintime2.getHours())==parseInt(curtime.getHours())){
                    if(parseInt(maintime2.getMinutes())>parseInt(curtime.getMinutes())){
                        document.getElementById("errormsg").innerText="Time cannot be greater than current time";
                        $('#intime').jqxDateTimeInput('focus');
                        return 0;   
                    }
                }
                else{
                    document.getElementById("errormsg").innerText="";
                }
            }   
                
        if(document.getElementById("cmbrentaltype").value==""){
             document.getElementById("errormsg").innerText="Select Rental Type";
            document.getElementById("cmbrentaltype").focus();
             return 0;  
         }
        if(document.getElementById("refno").value==""){
             document.getElementById("errormsg").innerText="Select Ref No";
            document.getElementById("refno").focus();
             return 0;  
         }
        if(document.getElementById("chkcollection").checked==true) {
        
        if(document.getElementById("collectiondriver").value==""){
             document.getElementById("errormsg").innerText="Select Driver";
            document.getElementById("collectiondriver").focus();
             return 0;  
         }
         var colleteddate=$('#colleteddate').jqxDateTimeInput('getDate');
         var collectedtime=$('#collectedtime').jqxDateTimeInput('getDate');
         if(colleteddate==null){
             document.getElementById("errormsg").innerText="Collection Date Is Mandatory";
             $('#colleteddate').jqxDateTimeInput('focus');
             return 0;
         }
         if(collectedtime==null){
             document.getElementById("errormsg").innerText="Collection Time Is Mandatory";
             $('#collectedtime').jqxDateTimeInput('focus');
             return 0;
         }
            if(document.getElementById("colletedkm").value==""){
                 document.getElementById("errormsg").innerText="Enter Collection KM ";
                document.getElementById("colletedkm").focus();
                 return 0;  
             }
            if(document.getElementById("collectedfuel").value==""){
                 document.getElementById("errormsg").innerText="Select Collection Fuel";
                document.getElementById("collectedfuel").focus();
                 return 0;  
             }
        }
        
        if(document.getElementById("inbranch").value==""){
             document.getElementById("errormsg").innerText="Select Branch";
            document.getElementById("inbranch").focus();
             return 0;  
         }
        if(document.getElementById("inlocation").value==""){
             document.getElementById("errormsg").innerText="Select Location";
            document.getElementById("inlocation").focus();
             return 0;  
         }
        var indate=$('#indate').jqxDateTimeInput('getDate');
         var intime=$('#intime').jqxDateTimeInput('getDate');
         if(indate==null){
             document.getElementById("errormsg").innerText="In Date Is Mandatory";
             $('#indate').jqxDateTimeInput('focus');
             return 0;
         }
         if(intime==null){
             document.getElementById("errormsg").innerText="In Time Is Mandatory";
             $('#intime').jqxDateTimeInput('focus');
             return 0;
         }
            if(document.getElementById("binkm").value==""){
                 document.getElementById("errormsg").innerText="Enter In KM ";
                document.getElementById("binkm").focus();
                 return 0;  
             }
            if(document.getElementById("binfuel").value==""){
                 document.getElementById("errormsg").innerText="Select In Fuel";
                document.getElementById("binfuel").focus();
                 return 0;  
             }
             
            if(document.getElementById("chkcollection").checked==true) { 
                              if ($("#mode").val() == "A") {  
                                    var dateout1=new Date($('#colleteddate').jqxDateTimeInput('getDate'));
                                    var timeout1=$('#collectedtime').jqxDateTimeInput('getDate');
                                    var dateouthidden1=new Date($('#dateout').jqxDateTimeInput('getDate'));
                                    var timeouthidden1=$('#timeout').jqxDateTimeInput('getDate');
                                    
                                    dateout1.setHours(0,0,0,0);
                                    dateouthidden1.setHours(0,0,0,0);
                                    
                                    if(dateout1<dateouthidden1){
                                        document.getElementById("errormsg").innerText="Collection Date Cannot be Less than Out Date";
                                        $('#colleteddate').jqxDateTimeInput('focus'); 
                                        return 0;   
                                    }
                                    if(dateout1-dateouthidden1==0){
                                            if(timeout1.getHours() < timeouthidden1.getHours()){
                                                document.getElementById("errormsg").innerText="Collection Time Cannot be Less than Out Time";
                                                $('#collectedtime').jqxDateTimeInput('focus'); 
                                                return 0;
                                            }
                                            if(timeout1.getHours() == timeouthidden1.getHours()){
                                            if(timeout1.getMinutes() < timeouthidden1.getMinutes()){
                                                document.getElementById("errormsg").innerText="Collection Time Cannot be Less than Out Time";
                                                $('#collectedtime').jqxDateTimeInput('focus');
                                                return 0;
                                            }
                                            }
                                        }
                                    var outkm=document.getElementById("outkm").value;
                                    var colkm=document.getElementById("colletedkm").value;
                                    if((parseFloat(colkm)<parseFloat(outkm))) {
                                       document.getElementById("errormsg").innerText="Collection KM Less Than Out KM";  
                                       document.getElementById("colletedkm").focus();
                                       return 0;
                                    }       
                        }
                    }
            else {
                     if ($("#mode").val() == "A") {   
                         var dateout1=new Date($('#indate').jqxDateTimeInput('getDate'));
                            var timeout1=$('#intime').jqxDateTimeInput('getDate');
                            var dateouthidden1=new Date($('#dateout').jqxDateTimeInput('getDate'));
                            var timeouthidden1=$('#timeout').jqxDateTimeInput('getDate');
                            
                                dateout1.setHours(0,0,0,0);
                            dateouthidden1.setHours(0,0,0,0);
                            
                            if(dateout1<dateouthidden1){
                                document.getElementById("errormsg").innerText="In Date Cannot be Less than Out Date";
                                $('#indate').jqxDateTimeInput('focus'); 
                                    return 0;   
                            }
                            if(dateout1-dateouthidden1==0){
                                    if(timeout1.getHours() < timeouthidden1.getHours()){
                                        document.getElementById("errormsg").innerText="In Time Cannot be Less than Out Time";
                                        $('#intime').jqxDateTimeInput('focus'); 
                                        return 0;
                                    }
                                    if(timeout1.getHours() == timeouthidden1.getHours()){
                                    if(timeout1.getMinutes() < timeouthidden1.getMinutes()){
                                        document.getElementById("errormsg").innerText="In Time Cannot be Less than Out Time";
                                        $('#intime').jqxDateTimeInput('focus');
                                        return 0;
                                    }
                                    }
                                           }
                            var outkm=document.getElementById("outkm").value;
                            var inkm=document.getElementById("binkm").value;
                            if((parseFloat(inkm)<parseFloat(outkm))) {
                               document.getElementById("errormsg").innerText="In KM Less Than Out KM";  
                               document.getElementById("binkm").focus();
                               return 0;
                            }
                     }
             }
        
        if(document.getElementById("chkcollection").checked==true) { 
                      if ($("#mode").val() == "A") {       
                                var dateout1=new Date($('#indate').jqxDateTimeInput('getDate'));
                                var timeout1=$('#intime').jqxDateTimeInput('getDate');
                                var dateouthidden1=new Date($('#colleteddate').jqxDateTimeInput('getDate'));
                               var timeouthidden1=$('#collectedtime').jqxDateTimeInput('getDate');
                            
                                dateout1.setHours(0,0,0,0);
                            dateouthidden1.setHours(0,0,0,0);
                            
                            if(dateout1<dateouthidden1){
                                document.getElementById("errormsg").innerText="In Date Cannot be Less than Collection Date";
                                $('#indate').jqxDateTimeInput('focus'); 
                                    return 0;   
                            }
                            if(dateout1-dateouthidden1==0){
                                    if(timeout1.getHours() < timeouthidden1.getHours()){
                                        document.getElementById("errormsg").innerText="In Time Cannot be Less than Collection Time";
                                        $('#intime').jqxDateTimeInput('focus'); 
                                        return 0;
                                    }
                                    if(timeout1.getHours() == timeouthidden1.getHours()){
                                    if(timeout1.getMinutes() < timeouthidden1.getMinutes()){
                                        document.getElementById("errormsg").innerText="In Time Cannot be Less than Collection Time";
                                        $('#intime').jqxDateTimeInput('focus');
                                        return 0;
                                    }
                                    }
                                }
                            
                            var colkm=document.getElementById("colletedkm").value;
                            var inkm=document.getElementById("binkm").value;
                            if((parseFloat(inkm)<parseFloat(colkm))) {
                               document.getElementById("errormsg").innerText="In KM Less Than Collection KM";  
                               document.getElementById("binkm").focus();
                               return 0;
                            }
                     }
            }
        
        $('#date').jqxDateTimeInput({ disabled: false});
            $('#refdate').jqxDateTimeInput({ disabled: false});
            $('#dateout').jqxDateTimeInput({ disabled: false});
            $('#timeout').jqxDateTimeInput({ disabled: false});
            $('#cmbfuel').prop('disabled',false);
    return 1;
}

function funSearchLoad(){
     changeContent('mainSearch.jsp'); 
}

function funFocus(){
    document.getElementById("searchbranch").focus();
}

function setValues() {
    funSetlabel();
    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
    
    if($('#hidedate').val()){ $("#date").jqxDateTimeInput('val', $('#hidedate').val()); }
    if($('#hiderefdate').val()){ $("#refdate").jqxDateTimeInput('val', $('#hiderefdate').val()); }
    if($('#hideroutdate').val()){ $("#dateout").jqxDateTimeInput('val', $('#hideroutdate').val()); }
    if($('#hidertimeout').val()){ $("#timeout").jqxDateTimeInput('val', $('#hidertimeout').val()); }
    
    if ($('#renttypeval').val() != null) { $('#cmbrentaltype').val($('#renttypeval').val()); }
    if ($('#rfuelval').val() != null) { $('#cmbfuel').val($('#rfuelval').val()); }
    if($('#hidcollectedTime').val()){ $("#collectedtime").jqxDateTimeInput('val', $('#hidcollectedTime').val()); }
    if($('#hideIntime').val()){ $("#intime").jqxDateTimeInput('val', $('#hideIntime').val()); }
    if ($('#hidcollectedFuelval').val() != null) { $('#collectedfuel').val($('#hidcollectedFuelval').val()); }
    if ($('#inFuelval').val() != null) { $('#binfuel').val($('#inFuelval').val()); }   
    if($('#hidcollecteddate').val()){ $("#colleteddate").jqxDateTimeInput('val', $('#hidcollecteddate').val()); }
    if($('#hideIndate').val()){ $("#indate").jqxDateTimeInput('val', $('#hideIndate').val()); }
    if($('#hidouttime').val()){ $("#outtime").jqxDateTimeInput('val', $('#hidouttime').val()); }
    if($('#hidoutdate').val()){ $("#outdate").jqxDateTimeInput('val', $('#hidoutdate').val()); }
    if ($('#outfuelval').val() != null) { $('#boutfuel').val($('#outfuelval').val()); }   
    if($('#hiddeltime').val()){ $("#deltime").jqxDateTimeInput('val', $('#hiddeltime').val()); }
    if($('#hiddeldate').val()){ $("#deldate").jqxDateTimeInput('val', $('#hiddeldate').val()); }
    if ($('#hiddelfuelval').val() != null) { $('#delfuel').val($('#hiddelfuelval').val()); }   
    if ($('#delyornval').val() != null) { $('#delyesorno').val($('#delyornval').val()); }       
        
    if(parseInt(document.getElementById("collectintickval").value)>0) {
        document.getElementById("chkcollection").checked=true;
        if(document.getElementById("mode").value=="A") {
            $("#collection input").prop("disabled", false);
            $("#collection select").prop("disabled", false);
            $('#colleteddate').jqxDateTimeInput({ disabled: false});
            $('#collectedtime').jqxDateTimeInput({ disabled: false});
        }
    }
            
    if(document.getElementById("mode").value=="view") {
         if(parseInt(document.getElementById("delyornval").value)>0) {
                $('#chkdelivery').attr('disabled', false);  
         } else {
                $('#chkdelivery').attr('disabled', true);
         }
         if(parseInt(document.getElementById("branchoutval").value)>0) {
                $('#outbranch').attr('disabled', true); 
         } else {
                $('#outbranch').attr('disabled', false);
         }
    }

    if(parseInt(document.getElementById("delchkval").value)>0) {
        document.getElementById("chkdelivery").checked=true;
        if(document.getElementById("mode").value=="view") {
            $('#chkdelivery').attr('disabled', true);
        }
    } 
        
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
    if($('#extramsg').val()!=''){
        document.getElementById("errormsg").innerText=$('#extramsg').val();
    }
}

function checkCollection() {
    if(document.getElementById("chkcollection").checked==true) {
        $('#collectiondriver').attr('readonly', true );
        $("#collection input").prop("disabled", false);
         $("#collection select").prop("disabled", false);
        $('#colleteddate').jqxDateTimeInput({ disabled: false});
          $('#collectedtime').jqxDateTimeInput({ disabled: false});
        document.getElementById("collectintickval").value=1;    
    }
    else {
        $("#collection input").prop("disabled", true);
         $("#collection select").prop("disabled", true);
         $('#colleteddate').jqxDateTimeInput({ disabled: true});
          $('#collectedtime').jqxDateTimeInput({ disabled: true});
         document.getElementById("collectintickval").value=0;   
    }
}
    
function checkDelivery() {
    if(document.getElementById("chkdelivery").checked==true) {
        $("#delivery input").prop("disabled", false);
        $("#delivery select").prop("disabled", false);
        $("#delivery input").prop("readonly", false);
        $("#deldriver").prop("readonly", true);
        $('#deldate').jqxDateTimeInput({ disabled: false});
          $('#deltime').jqxDateTimeInput({ disabled: false});
          document.getElementById("delchkval").value=1;   
          document.getElementById("delupdate").value="Update";
    }
    else {
        $("#delivery input").prop("disabled", true);
        $("#delivery select").prop("disabled", true);
        $('#deldate').jqxDateTimeInput({ disabled: true});
          $('#deltime').jqxDateTimeInput({ disabled: true});
          document.getElementById("delchkval").value=0;  
          document.getElementById("delupdate").value="Edit";
    }
}

function funoutupdate() {
    if(document.getElementById("docno").value=="") {
        $.messager.alert('Message','Select a Document....!','warning');
        return 0;
    }
    
    if(document.getElementById("outbranch").value=="Update") {
        $('#colleteddate').jqxDateTimeInput({ disabled: false});
         $("#collection input").prop("disabled", false);
         $("#collection select").prop("disabled", false);
        
         var outdate=$('#outdate').jqxDateTimeInput('getDate');
             var outtime=$('#outtime').jqxDateTimeInput('getDate');
             if(outdate==null){
                 document.getElementById("errormsg").innerText="Out Date Is Mandatory";
                 $('#outdate').jqxDateTimeInput('focus');
                 return 0;
             }
             if(outtime==null){
                 document.getElementById("errormsg").innerText="Out Time Is Mandatory";
                 $('#outtime').jqxDateTimeInput('focus');
                 return 0;
             }
            
                var maindate1 = $('#outdate').jqxDateTimeInput('getDate');
                   var validdate1=funDateInPeriod(maindate1);
                   if(validdate1==0){
                       $('#outdate').jqxDateTimeInput('focus');
                   return 0; 
                   }
                 maindate1.setHours(0,0,0,0);
                var maintime1=new Date($('#outtime').jqxDateTimeInput('getDate'));
                var curdate=new Date();
                curdate.setHours(0,0,0,0);
                if(maindate1-curdate==0){
                    var curtime=new Date();
                    if(parseInt(maintime1.getHours())>parseInt(curtime.getHours())){
                        document.getElementById("errormsg").innerText="Time cannot be greater than current time";
                        $('#outtime').jqxDateTimeInput('focus');
                        return 0;
                    }
                    else if(parseInt(maintime1.getHours())==parseInt(curtime.getHours())){
                        if(parseInt(maintime1.getMinutes())>parseInt(curtime.getMinutes())){
                            document.getElementById("errormsg").innerText="Time cannot be greater than current time";
                            $('#outtime').jqxDateTimeInput('focus');
                            return 0;
                        }
                    }
                }
                
                if(document.getElementById("boutkm").value==""){
                     document.getElementById("errormsg").innerText="Enter Out KM ";
                    document.getElementById("boutkm").focus();
                     return 0;  
                 }
                if(document.getElementById("boutfuel").value==""){
                     document.getElementById("errormsg").innerText="Select Out Fuel";
                    document.getElementById("boutfuel").focus();
                     return 0;  
                 }
                if(document.getElementById("delyesorno").value==""){
                     document.getElementById("errormsg").innerText="Choose One Option ";
                    document.getElementById("delyesorno").focus();
                     return 0;  
                 }
                
                      var dateout1=new Date($('#outdate').jqxDateTimeInput('getDate'));
                        var timeout1=$('#outtime').jqxDateTimeInput('getDate');
                        var dateouthidden1=new Date($('#hidevmovedate').jqxDateTimeInput('getDate'));
                       var timeouthidden1=$('#hidevmovetime').jqxDateTimeInput('getDate');
                        
                            dateout1.setHours(0,0,0,0);
                        dateouthidden1.setHours(0,0,0,0);
                        
                        if(dateout1<dateouthidden1){
                            document.getElementById("errormsg").innerText="Out Date Cannot be Less Than  In Date";
                            $('#outdate').jqxDateTimeInput('focus'); 
                                return 0;   
                        }
                        if(dateout1-dateouthidden1==0){
                                if(timeout1.getHours() < timeouthidden1.getHours()){
                                    document.getElementById("errormsg").innerText="Out Time Cannot be Less Than  In Time";
                                    $('#outtime').jqxDateTimeInput('focus'); 
                                    return 0;
                                }
                                if(timeout1.getHours() == timeouthidden1.getHours()){
                                if(timeout1.getMinutes() < timeouthidden1.getMinutes()){
                                    document.getElementById("errormsg").innerText="Out Time Cannot be Less Than  In Time";
                                    $('#outtime').jqxDateTimeInput('focus');
                                    return 0;
                                }
                                }
                            }
                        
                        var colkm=document.getElementById("hidevmovekm").value;
                var inkm=document.getElementById("boutkm").value;
                
                if((parseFloat(inkm)<parseFloat(colkm))) {
                   document.getElementById("errormsg").innerText="Out KM Less Than  In KM";  
                   document.getElementById("boutkm").focus();
                   return 0;
                }
                                   
                    $('#searchbranch').attr('disabled',false);
                    $.messager.confirm('Confirm', 'Do you want to update changes?', function(r){
                    if (r){
                          document.getElementById("mode").value="OUT";
                          document.getElementById("custody").submit();
                    }
                    });             
    }
    else {
        chkstatus();
    }
}
    
function fundelUpdate() {

     if(document.getElementById("deldriver").value==""){
         document.getElementById("errormsg").innerText="Select Driver ";
        document.getElementById("deldriver").focus();
         return 0;  
     }
     if(document.getElementById("deliveryto").value==""){
         document.getElementById("errormsg").innerText="Enter Deliver To ";
        document.getElementById("deliveryto").focus();
         return 0;  
     }
        
     var deldate=$('#deldate').jqxDateTimeInput('getDate');
     var deltime=$('#deltime').jqxDateTimeInput('getDate');
     if(deldate==null){
         document.getElementById("errormsg").innerText="Delivery Date Is Mandatory";
         $('#deldate').jqxDateTimeInput('focus');
         return 0;
     }
     if(deltime==null){
         document.getElementById("errormsg").innerText="Delivery Time Is Mandatory";
         $('#deltime').jqxDateTimeInput('focus');
         return 0;
     }
        if(document.getElementById("delkm").value==""){
             document.getElementById("errormsg").innerText="Enter Delivery KM ";
            document.getElementById("delkm").focus();
             return 0;  
         }
        if(document.getElementById("delfuel").value==""){
             document.getElementById("errormsg").innerText="Select Delivery Fuel";
            document.getElementById("delfuel").focus();
             return 0;  
         }
    
        var maindate1 = $('#deldate').jqxDateTimeInput('getDate');
           var validdate1=funDateInPeriod(maindate1);
           if(validdate1==0){
               $('#deldate').jqxDateTimeInput('focus');
           return 0; 
           }
        
          var dateout1=new Date($('#deldate').jqxDateTimeInput('getDate'));
            var timeout1=$('#deltime').jqxDateTimeInput('getDate');
            var dateouthidden1=new Date($('#outdate').jqxDateTimeInput('getDate'));
           var timeouthidden1=$('#outtime').jqxDateTimeInput('getDate');
        
            dateout1.setHours(0,0,0,0);
        dateouthidden1.setHours(0,0,0,0);
        
        if(dateout1<dateouthidden1){
            document.getElementById("errormsg").innerText="Delivery Date Cannot be Less than Out Date";
            $('#deldate').jqxDateTimeInput('focus'); 
                return 0;   
        }
        if(dateout1-dateouthidden1==0){
                if(timeout1.getHours() < timeouthidden1.getHours()){
                    document.getElementById("errormsg").innerText="Delivery Time Cannot be Less than Out Time";
                    $('#deltime').jqxDateTimeInput('focus'); 
                    return 0;
                }
                if(timeout1.getHours() == timeouthidden1.getHours()){
                if(timeout1.getMinutes() < timeouthidden1.getMinutes()){
                    document.getElementById("errormsg").innerText="Delivery Time Cannot be Less than Out Time";
                    $('#deltime').jqxDateTimeInput('focus');
                    return 0;
                }
                }
            }
        
        var outkm=document.getElementById("boutkm").value;
        var delkm=document.getElementById("delkm").value;
        
        if((parseFloat(delkm)<parseFloat(outkm))) {
           document.getElementById("errormsg").innerText="Delivery KM Less Than Out KM";  
           document.getElementById("delkm").focus();
           return 0;
        }
        
        $.messager.confirm('Confirm', 'Do you want to update changes?', function(r){
            if (r){
                $('#overlay,#PleaseWait').show();
                $('#colleteddate').jqxDateTimeInput({ disabled: false});
                $("#collection input").prop("disabled", false);
                $("#collection select").prop("disabled", false);
                $('#searchbranch').attr('disabled',false);
                document.getElementById("mode").value="DLY";
                document.getElementById("custody").submit();
                    
            }
        });
    }

function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
           document.getElementById("errormsg").innerText=" Enter Numbers Only";  
        return false;
        }
    document.getElementById("errormsg").innerText="";  
    return true;
}

function funPrintBtn(){
       if (($("#mode").val() == "view") && $("#docno").val()!="") { 
       var url=document.URL;
  var reurl=url.split("saveCustody");
 var win= window.open(reurl[0]+"printCustody?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
win.focus(); 
        } else {
          $.messager.alert('Message','Select a Document....!','warning');
          return false;
         } 
    } 
</script>
</head>

<body onload="setValues();getBranch();getBranch1();">
<form id="custody" action="saveCustody" autocomplete="off">

    <jsp:include page="../../../../header.jsp" />

    <div class="modern-ui hidden-scrollbar">
        
        <div style="border: 1px solid transparent; padding: 5px 0;">
            <div class="field-row" style="margin-bottom: 15px;">
                <label class="lbl-right" style="width: 50px;">Date</label>
                <div style="width: 120px;">
                    <div id="date" name="date" value='<s:property value="date"/>'></div>
                </div>

                <div style="margin-left: auto; display: flex; align-items: center; gap: 8px; padding-right: 10px;">
                    <label class="lbl-right">Doc No</label>
                    <input type="text" id="docno" name="docno" class="input-sm" tabindex="-1" readonly value='<s:property value="docno"/>'/>
                </div>
            </div>
        </div>

        <div class="modern-panel" id="custody_panel">
            <span class="modern-panel-title">Vehicle Custody</span>
            <div style="padding-top: 5px; display: flex; gap: 20px;">
                
                <div style="flex: 1; display: flex; flex-direction: column;">
                    <div class="field-row">
                        <label class="lbl-right" style="width: 80px;">Branch</label>
                        <select name="searchbranch" id="searchbranch" class="input-full" value='<s:property value="searchbranch"/>'>
                            <option value="">--Select--</option>
                        </select>
                    </div>
                    <div class="field-row">
                        <label class="lbl-right" style="width: 80px;">Ref Date</label>
                        <div style="width: 120px;">
                            <div id='refdate' name='refdate' value='<s:property value="refdate"/>'></div>
                        </div>
                    </div>
                    <div class="field-row">
                        <label class="lbl-right" style="width: 80px;">Date Out</label>
                        <div style="width: 120px;">
                            <div id="dateout" name="dateout" value='<s:property value="dateout"/>'></div>
                        </div>
                    </div>
                    <div class="field-row">
                        <label class="lbl-right" style="width: 80px;">Branch</label>
                        <input type="text" name="txtbranch" id="txtbranch" class="input-full" readonly value='<s:property value="txtbranch"/>'/>
                    </div>
                </div>

                <div style="flex: 1; display: flex; flex-direction: column;">
                    <div class="field-row">
                        <label class="lbl-right" style="width: 80px;">Rental Type</label>
                        <select id="cmbrentaltype" name="cmbrentaltype" class="input-full" onchange="funcleardatas()" value='<s:property value="cmbrentaltype"/>'>
                            <option value="">--Select--</option><option value="RAG">Rental</option><option value="LAG">Lease</option>
                        </select>
                    </div>
                    <div class="field-row">
                        <label class="lbl-right" style="width: 80px;">Fleet No</label>
                        <div style="display: flex; flex: 1; gap: 5px;">
                            <input type="text" id="txtfleetno" name="txtfleetno" class="input-sm" value='<s:property value="txtfleetno"/>' readonly />
                            <input type="text" id="txtfleetname" name="txtfleetname" class="input-full" value='<s:property value="txtfleetname"/>' readonly/>
                        </div>
                    </div>
                    <div class="field-row">
                        <label class="lbl-right" style="width: 80px;">Time Out</label>
                        <div style="width: 80px;">
                            <div id="timeout" name="timeout" value='<s:property value="timeout"/>'></div>
                        </div>
                    </div>
                    <div class="field-row">
                        <label class="lbl-right" style="width: 80px;">Location</label>
                        <input type="text" name="txtlocation" id="txtlocation" class="input-full" readonly value='<s:property value="txtlocation"/>'/>
                    </div>
                </div>

                <div style="flex: 1.2; display: flex; flex-direction: column;">
                    <div class="field-row">
                        <label class="lbl-right" style="width: 70px;">Ref No</label>
                        <div style="display: flex; flex: 1; gap: 5px;">
                            <input type="text" id="refno" name="refno" class="input-sm" value='<s:property value="refno"/>' placeholder="Press F3" readonly onkeydown="getAgmtno(event);"/>
                            <input type="text" id="refname" name="refname" class="input-full" value='<s:property value="refname"/>' readonly/>
                        </div>
                    </div>
                    <div class="field-row">
                        <div style="height: 24px;"></div>
                    </div>
                    <div class="field-row">
                        <label class="lbl-right" style="width: 70px;">Km Out</label>
                        <input type="text" id="outkm" name="outkm" class="input-sm" style="width: 70px !important;" value='<s:property value="outkm"/>' readonly onkeypress="javascript:return isNumber (event)"/>
                        
                        <label class="lbl-right" style="width: 40px; margin-left:auto;">Fuel</label>
                        <select id="cmbfuel" name="cmbfuel" class="input-full" style="max-width: 120px;" value='<s:property value="cmbfuel"/>'>
                            <option value="">--Select--</option>
                            <option value=0.000>Level 0/8</option><option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option>
                            <option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option><option value=0.625>Level 5/8</option>
                            <option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
                        </select>
                    </div>
                    <div class="field-row">
                        <label class="lbl-right" style="width: 70px;">Tr. Reason</label>
                        <input type="text" id="reason" name="reason" class="input-full" readonly value='<s:property value="reason"/>'>
                    </div>
                </div>

            </div>

            <div class="field-row" style="margin-top: 10px;">
                <label class="lbl-right" style="width: 80px;">Description</label>
                <input type="text" name="descnew" id="descnew" class="input-full" value='<s:property value="descnew"/>'>
            </div>
        </div>

        <div class="split-section">
            <div class="split-col">
                <div class="modern-panel" id="collection" style="flex: 1;">
                    <span class="modern-panel-title">
                        <label class="chk-container">
                            <input type="checkbox" name="chkcollection" id="chkcollection" onchange="checkCollection();">
                            Collection Details
                        </label>
                    </span>
                    <div style="padding-top: 5px;">
                        <div class="field-row">
                            <label class="lbl-right" style="width: 60px;">Driver</label>
                            <input type="text" name="collectiondriver" id="collectiondriver" class="input-full" value='<s:property value="collectiondriver"/>' placeholder="Press F3 to Search" readonly onkeydown="getDriver(event,1);">
                        </div>
                        <div class="field-row">
                            <label class="lbl-right" style="width: 60px;">Date</label>
                            <div style="width: 120px;">
                                <div id="colleteddate" name="colleteddate" value='<s:property value="colleteddate"/>'></div>
                            </div>
                            <label class="lbl-right" style="width: 40px;">Time</label>
                            <div style="width: 80px;">
                                <div id="collectedtime" name="collectedtime" value='<s:property value="collectedtime"/>'></div>
                            </div>
                        </div>
                        <div class="field-row">
                            <label class="lbl-right" style="width: 60px;">KM</label>
                            <input type="text" name="colletedkm" id="colletedkm" class="input-sm" style="flex: 1;" value='<s:property value="colletedkm"/>' onkeypress="javascript:return isNumber (event)">
                            <label class="lbl-right" style="width: 40px;">Fuel</label>
                            <select name="collectedfuel" id="collectedfuel" class="input-full" style="max-width: 120px;" value='<s:property value="collectedfuel"/>'>
                                <option value="">-Select-</option>
                                <option value=0.000>Level 0/8</option><option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option>
                                <option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option><option value=0.625>Level 5/8</option>
                                <option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>

            <div class="split-col">
                <div class="modern-panel" id="collectfield" style="flex: 1;">
                    <span class="modern-panel-title">Branch In</span>
                    <div style="padding-top: 5px;">
                        <div class="field-row">
                            <label class="lbl-right" style="width: 60px;">Branch</label>
                            <select name="inbranch" id="inbranch" class="input-full" value='<s:property value="inbranch"/>' onchange="getLoc(this.value);">
                                <option value="">--Select--</option>
                            </select>
                            <label class="lbl-right" style="width: 60px;">Location</label>
                            <select name="inlocation" id="inlocation" class="input-full" value='<s:property value="inlocation"/>'>
                                <option value="">--Select--</option>
                            </select>
                        </div>
                        <div class="field-row">
                            <label class="lbl-right" style="width: 60px;">Date</label>
                            <div style="width: 120px;">
                                <div id="indate" name="indate" value='<s:property value="indate"/>'></div>
                            </div>
                            <label class="lbl-right" style="width: 40px;">Time</label>
                            <div style="width: 80px;">
                                <div id="intime" name="intime" value='<s:property value="intime"/>' ></div>
                            </div>
                        </div>
                        <div class="field-row">
                            <label class="lbl-right" style="width: 60px;">KM</label>
                            <input type="text" name="binkm" id="binkm" class="input-sm" style="flex: 1;" value='<s:property value="binkm"/>' onkeypress="javascript:return isNumber (event)">
                            <label class="lbl-right" style="width: 40px;">Fuel</label>
                            <select name="binfuel" id="binfuel" class="input-full" style="max-width: 120px;" value='<s:property value="binfuel"/>'>
                                <option value="">-Select-</option>
                                <option value=0.000>Level 0/8</option><option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option>
                                <option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option><option value=0.625>Level 5/8</option>
                                <option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="split-section">
            <div class="split-col">
                <div class="modern-panel" id="branchout" style="flex: 1;">
                    <span class="modern-panel-title">Branch Out</span>
                    <div style="padding-top: 5px;">
                        <div class="field-row">
                            <label class="lbl-right" style="width: 60px;">Date</label>
                            <div style="width: 120px;">
                                <div id="outdate" name="outdate" value='<s:property value="outdate"/>'></div>
                            </div>
                            <label class="lbl-right" style="width: 40px;">Time</label>
                            <div style="width: 80px;">
                                <div id="outtime" name="outtime" value='<s:property value="outtime"/>'></div>
                            </div>
                        </div>
                        <div class="field-row">
                            <label class="lbl-right" style="width: 60px;">KM</label>
                            <input type="text" name="boutkm" id="boutkm" class="input-sm" style="flex: 1;" value='<s:property value="boutkm"/>' onkeypress="javascript:return isNumber (event)">
                            <label class="lbl-right" style="width: 40px;">Fuel</label>
                            <select name="boutfuel" id="boutfuel" class="input-full" style="max-width: 120px;" value='<s:property value="boutfuel"/>'>
                                <option value="">-Select-</option>
                                <option value=0.000>Level 0/8</option><option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option>
                                <option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option><option value=0.625>Level 5/8</option>
                                <option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
                            </select>
                        </div>
                        <div class="field-row">
                            <label class="lbl-right" style="width: 60px;">Delivery</label>
                            <select name="delyesorno" id="delyesorno" class="input-xs" value='<s:property value="delyesorno"/>'>
                                <option value="">--</option><option value=1>YES</option><option value=0>NO</option>
                            </select>
                            <input type="button" id="outbranch" class="myButton" name="outbranch" value="Edit" onclick="funoutupdate()" style="margin-left: auto;">
                        </div>
                        <div class="field-row">
                            <label class="lbl-right" style="width: 60px;">Description</label>
                            <input type="text" name="outdesc" id="outdesc" class="input-full" value='<s:property value="outdesc"/>'>
                        </div>
                    </div>
                </div>
            </div>

            <div class="split-col">
                <div class="modern-panel" id="deliveryfield" style="flex: 1;">
                    <span class="modern-panel-title">
                        <label class="chk-container">
                            <input type="checkbox" name="chkdelivery" id="chkdelivery" onchange="checkDelivery();">
                            Delivery
                        </label>
                    </span>
                    <div style="padding-top: 5px;">
                        <div class="field-row">
                            <label class="lbl-right" style="width: 60px;">Driver</label>
                            <input type="text" name="deldriver" id="deldriver" class="input-full" readonly value='<s:property value="deldriver"/>' placeholder="Press F3" onkeydown="getDriver(event,2);">
                        </div>
                        <div class="field-row">
                            <label class="lbl-right" style="width: 60px;">Deliver To</label>
                            <input type="text" name="deliveryto" id="deliveryto" class="input-full" value='<s:property value="deliveryto"/>'>
                        </div>
                        <div class="field-row">
                            <label class="lbl-right" style="width: 60px;">Date</label>
                            <div style="width: 120px;">
                                <div id="deldate" name="deldate" value='<s:property value="deldate"/>'></div>
                            </div>
                            <label class="lbl-right" style="width: 40px;">Time</label>
                            <div style="width: 80px;">
                                <div id="deltime" name="deltime" value='<s:property value="deltime"/>'></div>
                            </div>
                        </div>
                        <div class="field-row">
                            <label class="lbl-right" style="width: 60px;">KM</label>
                            <input type="text" name="delkm" id="delkm" class="input-sm" style="flex: 1;" value='<s:property value="delkm"/>' onkeypress="javascript:return isNumber (event)">
                            <label class="lbl-right" style="width: 40px;">Fuel</label>
                            <select name="delfuel" id="delfuel" class="input-full" style="max-width: 120px;" value='<s:property value="delfuel"/>'>
                                <option value="">-Select-</option>
                                <option value=0.000>Level 0/8</option><option value=0.125>Level 1/8</option><option value=0.250>Level 2/8</option>
                                <option value=0.375>Level 3/8</option><option value=0.500>Level 4/8</option><option value=0.625>Level 5/8</option>
                                <option value=0.750>Level 6/8</option><option value=0.875>Level 7/8</option><option value=1.000>Level 8/8</option>
                            </select>
                            <input type="button" id="delupdate" class="myButton" name="delupdate" value="Edit" onclick="fundelUpdate()" style="margin-left: 10px;">
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <input type="hidden" name="masterrefno" id="masterrefno" value='<s:property value="masterrefno"/>'>
        <input type="hidden" name="searchbranchval" id="searchbranchval" value='<s:property value="searchbranchval"/>'>
        <input type="hidden" name="branchoutval" id="branchoutval" value='<s:property value="branchoutval"/>'>
        <input type="hidden" name="delyornval" id="delyornval" value='<s:property value="delyornval"/>'>
        <input type="hidden" name="clientnumbers" id="clientnumbers" value='<s:property value="clientnumbers"/>'>
        <input type="hidden" name="hidedate" id="hidedate" value='<s:property value="hidedate"/>'>
        <input type="hidden" name="hiderefdate" id="hiderefdate" value='<s:property value="hiderefdate"/>'>
        <input type="hidden" name="hideroutdate" id="hideroutdate" value='<s:property value="hideroutdate"/>'>
        <input type="hidden" name="hidertimeout" id="hidertimeout" value='<s:property value="hidertimeout"/>'>
        <input type="hidden" name="rfuelval" id="rfuelval" value='<s:property value="rfuelval"/>'>
        <input type="hidden" name="renttypeval" id="renttypeval" value='<s:property value="renttypeval"/>'>
        <input type="hidden" name="hidcollecteddate" id="hidcollecteddate" value='<s:property value="hidcollecteddate"/>'>
        <input type="hidden" name="hidcollectedTime" id="hidcollectedTime" value='<s:property value="hidcollectedTime"/>'>
        <input type="hidden" name="hidcollectedFuelval" id="hidcollectedFuelval" value='<s:property value="hidcollectedFuelval"/>'>
        <input type="hidden" name="hideIndate" id="hideIndate" value='<s:property value="hideIndate"/>'>
        <input type="hidden" name="hideIntime" id="hideIntime" value='<s:property value="hideIntime"/>'>
        <input type="hidden" name="inFuelval" id="inFuelval" value='<s:property value="inFuelval"/>'>
        <input type="hidden" name="mainbranchid" id="mainbranchid" value='<s:property value="mainbranchid"/>'>
        <input type="hidden" name="mainlocationid" id="mainlocationid" value='<s:property value="mainlocationid"/>'>
        <input type="hidden" name="infleettrancode" id="infleettrancode" value='<s:property value="infleettrancode"/>'>
        <input type="hidden" name="hidebranch" id="hidebranch" value='<s:property value="hidebranch"/>'>
        <input type="hidden" name="hidelocation" id="hidelocation" value='<s:property value="hidelocation"/>'>
        <input type="hidden" name="hidoutdate" id="hidoutdate" value='<s:property value="hidoutdate"/>'>
        <input type="hidden" name="hidouttime" id="hidouttime" value='<s:property value="hidouttime"/>'>
        <input type="hidden" name="outfuelval" id="outfuelval" value='<s:property value="outfuelval"/>'>
        <input type="hidden" name="hiddeldate" id="hiddeldate" value='<s:property value="hiddeldate"/>'>
        <input type="hidden" name="hiddeltime" id="hiddeltime" value='<s:property value="hiddeltime"/>'>
        <input type="hidden" ngit ame="hiddelfuelval" id="hiddelfuelval" value='<s:property value="hiddelfuelval"/>'>
        <input type="hidden" name="colldriverid" id="colldriverid" value='<s:property value="colldriverid"/>'>
        <input type="hidden" name="deldriverid" id="deldriverid" value='<s:property value="deldriverid"/>'>
        <input type="hidden" name="collectintickval" id="collectintickval" value='<s:property value="collectintickval"/>'>
        <input type="hidden" name="delchkval" id="delchkval" value='<s:property value="delchkval"/>'>
        <div hidden="true" id="hidevmovedate" name="hidevmovedate" value='<s:property value="hidevmovedate"/>'></div>
        <div hidden="true" id="hidevmovetime" name="hidevmovetime" value='<s:property value="hidevmovetime"/>'></div>
        <input type="hidden" name="hidevmovekm" id="hidevmovekm" value='<s:property value="hidevmovekm"/>'>
        <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
        <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
        <input type="hidden" name="extramsg" id="extramsg" value='<s:property value="extramsg"/>'>
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>

    </div>
</form>

<div id="collectionwindow"><div></div></div>
<div id="agmtnowindow"><div></div></div>

</body>
</html>