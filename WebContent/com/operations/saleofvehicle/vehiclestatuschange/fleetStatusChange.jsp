<%@ taglib prefix="s" uri="/struts-tags" %>
 
<!DOCTYPE html>
<html>
<head>
<s:head/>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
 <jsp:include page="../../../../includes.jsp"></jsp:include>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/globalcss.css">

<style>
    /* --- GLOBAL LAYOUT --- */
    body {
        background-color: #f0f4f8;
        font-family: 'Segoe UI', 'Roboto', Helvetica, Arial, sans-serif;
        margin: 0; padding: 0;
        color: #334155;
        overflow-x: auto; 
    }

    /* --- BACKGROUND WIDTH FIX --- */
    #mainBG, .homeContent {
        width: 100%;
        min-width: 1250px !important; 
        box-sizing: border-box;
        display: block;
    }

    #frmFleetStatusChange {
        width: 98%;
        margin: 20px auto;
        padding: 0 15px;
        box-sizing: border-box;
    }

    /* --- BLUE HEADER CARD SECTION --- */
    .header-card-section {
        background: linear-gradient(to right, #dbeafe, #eff6ff); 
        border-radius: 16px;
        padding: 25px 30px;
        box-shadow: 0 4px 15px rgba(59, 130, 246, 0.1);
        margin-bottom: 25px;
        border: 1px solid #bfdbfe;
    }

    .header-card-section h3 {
        color: #1e3a8a; 
        font-weight: 700;
        font-size: 1.5rem;
        margin-top: 0;
        margin-bottom: 20px;
        padding-bottom: 10px;
        border-bottom: 1px solid rgba(59, 130, 246, 0.2);
    }

    /* --- HEADER TABLE LAYOUT --- */
    .header-table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0 15px; 
        table-layout: fixed; 
    }

    /* Labels */
    .header-table td.label-cell {
        text-align: right;
        color: #1e3a8a;
        font-weight: 700;
        font-size: 15px; 
        white-space: nowrap;
        vertical-align: middle;
        padding-right: 15px; 
    }

    /* Inputs */
    .header-table td.input-cell {
        vertical-align: middle;
        text-align: left;
    }

    /* --- PILL INPUT STYLING --- */
    .header-card-section input[type="text"],
    .header-card-section select,
    .header-card-section textarea,
    .header-card-section .jqxDateTimeInput {
        background-color: #ffffff !important;
        border: 1px solid #94a3b8 !important;
        border-radius: 8px !important; 
        height: 38px !important;
        padding: 0 12px !important;
        box-shadow: 0 1px 2px rgba(0,0,0,0.05) !important;
        color: #334155;
        font-size: 14px;
        font-weight: 500;
        width: 100% !important;
        box-sizing: border-box; 
    }
    
    /* Textarea specific height override */
    .header-card-section textarea {
        height: 80px !important;
        padding-top: 10px !important;
    }

    /* Focus State */
    .header-card-section input[type="text"]:focus,
    .header-card-section select:focus,
    .header-card-section textarea:focus {
        border-color: #2563eb !important;
        box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.2) !important;
        outline: none;
    }

    /* JQX Override */
    .jqx-widget-content {
        border-radius: 8px !important;
        border-color: #94a3b8 !important;
    }
</style>

<script type="text/javascript">
$(document).ready(function() {
    // UPDATED JQX SIZES TO MATCH PILL
    $("#fleetstatusdate").jqxDateTimeInput({
        width : '100%',
        height : '38px',
        formatString : "dd.MM.yyyy"
    });
    $("#hiddate").jqxDateTimeInput({
        width : '125px',
        height : '15px',
        formatString : "dd.MM.yyyy"
    });
    getStatus();
    $('#btnEdit').attr('disabled',true);
     $('#fleetwindow').jqxWindow({ width: '60%', height: '58%',  maxHeight: '58%' ,maxWidth: '50%' , title: 'Fleet Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
       $('#fleetwindow').jqxWindow('close');
    
    // TIME INPUTS ALSO UPDATED
    $("#fleetstatustime").jqxDateTimeInput({ width: '100%', height: '38px', formatString: 'HH:mm', showCalendarButton: false,value:new Date() });
    $("#hidtime").jqxDateTimeInput({ width: '50%', height: '15px', formatString: 'HH:mm', showCalendarButton: false,value:new Date() });
      $('#fleetno').dblclick(function(){
          
          if(document.getElementById("mode").value=="view"){
              return false;
          }
          datereset();
            $('#fleetwindow').jqxWindow('open');
        $('#fleetwindow').jqxWindow('focus');
        fleetnoSearchContent('masterFleetSearch.jsp?', $('#fleetwindow'));
        });
});
function fleetnoSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#fleetwindow').jqxWindow('setContent', data);

}); 
}
function getFleet(event){
       //alert("Here");
     var x= event.keyCode;
     if(x==114){
         if(document.getElementById("mode").value=="view"){
              return false;
          }
         datereset();
           $('#fleetwindow').jqxWindow('open');
        $('#fleetwindow').jqxWindow('focus');
         fleetnoSearchContent('masterFleetSearch.jsp?', $('#fleetwindow'));
     }
     else{
      }
     }
function funReset(){
    //$('#frmFleetStatusChange')[0].reset(); 
}
function datereset(){
    $('#fleetstatusdate').jqxDateTimeInput('setDate', new Date());
       $('#fleetstatustime').jqxDateTimeInput('setDate', new Date());
       
}
function funFocus(){
    document.getElementById("fleetno").focus();
}
function funReadOnly(){
    if($('#docno').val()!='0'){
        $('#frmFleetStatusChange input').attr('readonly', true );
         $('#fleetstatusdate').jqxDateTimeInput({ disabled: true}); 
         $('#fleetstatustime').jqxDateTimeInput({ disabled: true}); 
         $('#frmFleetStatusChange select').attr('disabled', true );
         $('#frmFleetStatusChange textarea').attr('readonly', true );    
    }
    
}
function funRemoveReadOnly(){
    $('#frmFleetStatusChange input').attr('readonly', false );
     $('#fleetstatusdate').jqxDateTimeInput({ disabled: false}); 
     $('#fleetstatustime').jqxDateTimeInput({ disabled: false}); 
     $('#frmFleetStatusChange select').attr('disabled', false );
     $('#frmFleetStatusChange textarea').attr('readonly', false );
    $('#docno').attr('readonly', true);
    $('#fleetno').attr('readonly', true);
    $('#fleetname').attr('readonly', true);
    $('#currentstatus').attr('readonly', true);
    if(document.getElementById("mode").value=="A"){
        datereset();
    }

}
function getStatus() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('***');
            //alert(items);
            var status = items[0].split(",");
            var statusid = items[1].split(",");
            var optionsstatus = '<option value="">--Select--</option>';
            for (var i = 0; i < status.length; i++) {
                optionsstatus += '<option value="' + statusid[i] + '">'
                        + status[i] + '</option>';
            }
            $("select#cmbchangestatus").html(optionsstatus);
            if ($('#hidcmbchangestatus').val() != null) {
                $('#cmbchangestatus').val($('#hidcmbchangestatus').val());
            }
        } else {
        }
    }
    x.open("GET", "getStatus.jsp", true);
    x.send();
}
function setValues()
{
    funSetlabel();

    if($('#hidfleetstatustime').val()){
        $("#fleetstatustime").jqxDateTimeInput('val', $('#hidfleetstatustime').val());
    }
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
        if($('#msg').val()!=$('#extramsg').val()){
            document.getElementById("errormsg").innerText="";
            document.getElementById("errormsg").innerText=$('#extramsg').val();
        }
        else{
            document.getElementById("errormsg").innerText="";
        }
    }
     if ($('#hidcmbchangestatus').val() != null) {
            $('#cmbchangestatus').val($('#hidcmbchangestatus').val());
        }
    

    }
    function funNotify(){
        var temp=document.getElementById("cmbchangestatus").value;
        var statusdate= new Date($('#fleetstatusdate').jqxDateTimeInput('getDate'));
        var statustime= new Date($('#fleetstatustime').jqxDateTimeInput('getDate'));
        var hiddate=$('#hiddate').jqxDateTimeInput('getDate');
        var hidtime=$('#hidtime').jqxDateTimeInput('getDate');
        statusdate.setHours(0,0,0,0);
        hiddate.setHours(0,0,0,0);
        
        var validdate=funDateInPeriod(statusdate);
        if(validdate==0){
            return 0; 
        }
        
        var curdate=new Date();
        var curtime=new Date();
        curdate.setHours(0,0,0,0);
        
        
        if(statusdate-curdate==0){
            if(statustime.getHours()>curtime.getHours()){
                document.getElementById("errormsg").innerText="";
                document.getElementById("errormsg").innerText="Future Time Not Allowed";
                return 0;
            }
            else if(statustime.getHours()==curtime.getHours()){
                if(statustime.getMinutes()>curtime.getMinutes()){
                    document.getElementById("errormsg").innerText="";
                    document.getElementById("errormsg").innerText="Future Time Not Allowed";
                    return 0;
                }
            }
        }
        
        if(document.getElementById("cmbchangestatus").value==""){
            document.getElementById("errormsg").innerText="Select a Status";
            return 0;
        }
        if(document.getElementById("hidcurrentstatus").value==temp){
            document.getElementById("errormsg").innerText="Cannot Select Same Status";
            return 0;
        }
        //checking status change date with last in date
        if(statusdate<hiddate){
             document.getElementById("errormsg").innerText="";
             document.getElementById("errormsg").innerText="Change Date Cannot be less than Last In Date";
             return 0;
        }
        if(statusdate-hiddate==0){
            if(statustime.getHours()<hidtime.getHours()){
                document.getElementById("errormsg").innerText="";
                document.getElementById("errormsg").innerText="Change Time Cannot be less than Last In Time";
                 return 0;  
            }
            if(statustime.getHours()==hidtime.getHours()){
                if(statustime.getMinutes()<hidtime.getMinutes()){
                    document.getElementById("errormsg").innerText="";
                    document.getElementById("errormsg").innerText="Change Time Cannot be less than Last In Time";
                     return 0;      
                }
            }
        }
        document.getElementById("errormsg").innerText="";
        return 1;
    }
    function funSearchLoad(){
         changeContent('masterSearch.jsp', $('#window')); 
    }
</script>
</head>
<body onload="funReadOnly();setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmFleetStatusChange" action="saveActionFleetStatusChange" autocomplete="off">

    <jsp:include page="../../../../header.jsp" />
    <br/>
    <div class="hidden-scrollbar receipt-header">
        
        <div class="header-card-section">
            <h3>Fleet Status Change Info</h3>
            
            <table class="header-table">
                <colgroup>
                    <col style="width: 10%;">  <col style="width: 15%;">  <col style="width: 10%;">  <col style="width: 15%;">  <col style="width: 10%;">  <col style="width: 20%;">  <col style="width: auto;"> </colgroup>

                <tr>
                    <td class="label-cell">Date</td>
                    <td class="input-cell">
                        <div id="fleetstatusdate" name="fleetstatusdate" value='<s:property value="fleetstatusdate"/>'></div>
                    </td>
                    <input type="hidden" name="hidcmbsalesman" id="hidcmbsalesman" value='<s:property value="hidcmbsalesman"/>'>
                    
                    <td class="label-cell">Time</td>
                    <td class="input-cell">
                        <div id="fleetstatustime" name="fleetstatustime" value='<s:property value="fleetstatustime"/>'></div>
                    </td>
                    <input type="hidden" name="hidfleetstatusdate" id="hidfleetstatusdate" value='<s:property value="hidfleetstatusdate"/>'>
                    <input type="hidden" name="hidfleetstatustime" id="hidfleetstatustime" value='<s:property value="hidfleetstatustime"/>'>
                    
                    <td class="label-cell">Doc No</td>
                    <td class="input-cell">
                        <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly>
                    </td>
                    <td></td>
                </tr>
                
                <tr>
                    <td class="label-cell">Fleet</td>
                    <td class="input-cell">
                        <input type="text" name="fleetno" id="fleetno" value='<s:property value="fleetno"/>' readonly onkeydown="getFleet(event);"> 
                    </td>
                    
                    <td class="input-cell" colspan="4">
                        <input type="text" name="fleetname" id="fleetname" value='<s:property value="fleetname"/>' readonly>
                    </td>
                    <td></td>
                </tr>
                
                <tr>
                    <td class="label-cell">Current Status</td>
                    <td class="input-cell">
                        <input type="text" name="currentstatus" id="currentstatus" value='<s:property value="currentstatus"/>' readonly>
                    </td>
                    
                    <td class="label-cell">Change To</td>
                    <td class="input-cell">
                        <select name="cmbchangestatus" id="cmbchangestatus" ><option value="">--Select--</option></select>
                    </td>
                    <input type="hidden" name="hidcmbchangestatus" id="hidcmbchangestatus" value='<s:property value="hidcmbchangestatus"/>' readonly>
                    <td colspan="3"></td>
                </tr>
                
                <tr>
                    <td class="label-cell">Reason</td>
                    <td class="input-cell" colspan="5"> 
                       <textarea id="reason" name="reason" style="resize:none;" ><s:property value="reason"/></textarea>
                    </td>
                    <td></td>
                </tr>
            </table>
            
            <div id="errormsg" style="color:red; font-weight:bold; margin-top:10px;"></div>
        </div>

        <input type="hidden" name="hidcurrentstatus" id="hidcurrentstatus" value='<s:property value="hidcurrentstatus"/>'>
        <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
        <input type="hidden" name="extramsg" id="extramsg" value='<s:property value="extramsg"/>'>
        <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
        <div id="hiddate" name="hiddate" hidden="true"></div>
        <div id="hidtime" name="hidtime" hidden="true"></div>
    </div>
</form>

<div id="fleetwindow">
   <div ></div>
</div>

</div>
</body>
</html>