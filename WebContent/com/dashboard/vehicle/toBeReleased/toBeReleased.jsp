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
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
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
    width: 280px; /* Reduced from 330px to give the right panel more width */
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
    padding: 15px 15px 25px; /* Slightly tighter padding to fit the new 280px width */
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
    width: 80px;
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
}

/* Readonly / disabled look */
input[readonly],
input:disabled,
.release-filter-table input[readonly],
.release-filter-table input:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed;
}

/* jqx date/time containers */
.release-filter-table div[id^="dashrelease"] {
    width: 100%;
}

/* Warning text */
#dashfleetwarning {
    color: #dc2626;
    font-size: 12px;
    font-weight: 600;
    text-align: center;
    margin-top: 5px;
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
}

.btn-submit:hover {
    background: #1d4ed8;
}

.btn-submit:disabled {
    background: #9ca3af;
    cursor: not-allowed;
}

/* Action buttons layout */
.release-secondary-actions, .release-actions {
    display: flex;
    gap: 10px;
    justify-content: center;
    margin-top: 15px;
}

.release-actions .btn-submit {
    min-width: 120px;
}

/* ===== RIGHT CONTENT AREA (Dynamically fills screen) ===== */
.main-content-area {
    flex: 1; /* This tells the right side to expand and take up all remaining width */
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
    overflow: auto; /* Allows scrolling inside the grid area if needed */
    box-sizing: border-box;
}
</style>
 
<script type="text/javascript">
$(document).ready(function () {
    
    document.getElementById("dashfleetwarning").style.display="none";
    document.getElementById("dashbtnrelease").disabled=true;
    document.getElementById("btnvehicle").disabled=true;
    document.getElementById("btnattach").disabled=true;
    
    $("#dashreleasedate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    $("#dashreleasetime").jqxDateTimeInput({ width: '100%', height: '24px', formatString: 'HH:mm', showCalendarButton: false ,value: new Date()});

    $('#vehiclewindow').jqxWindow({width: '80%', height: '70%',  maxHeight: '80%' ,maxWidth: '90%' , title: 'Vehicle Details',position: { x: 250, y: 60} , theme: 'energyblue', showCloseButton: true,closeButtonAction:'hide'});
    $('#vehiclewindow').jqxWindow('close');
 
    $('#clientAttachWindow').jqxWindow({autoOpen: false,width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Attach',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
    $('#clientAttachWindow').jqxWindow('close');
    $('input[type=text]').val('');
    $('select').find('option').prop("selected", false);
    $.jqx._jqxDateTimeInput.getDateTime(new Date());
    
    getBrch();  
    getTestLocation(); 
});

function funExportBtn(){
    if(parseInt(window.parent.chkexportdata.value)=="1")
     {
     JSONToCSVCon(datarelease, 'ToBeReleased', true);
     }
    else
     {
       $("#toBeReleasedGrid").jqxGrid('exportdata', 'xls', 'ToBeReleased');
     }
}

function getTestLocation(){
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200)
            {
                items= x.responseText;
                items=items.split('***');
                var locationItems=items[0].split(",");
                var locationidItems=items[1].split(",");
                    var optionslocation = '<option value="">--Select--</option>';
               for ( var i = 0; i < locationItems.length; i++) {
                   optionslocation += '<option value="' + locationidItems[i] + '">' + locationItems[i] + '</option>';
                }
               $("select#dashcmbrlsloc").html(optionslocation);
                if ($('#dashhidcmbrlsloc').val() != null) {
            $('#dashcmbrlsloc').val($('#dashhidcmbrlsloc').val());
        }
            }
        else
            {
            }
    }
    x.open("GET","getTestLocation.jsp",true);
    x.send();
}

function getBrch() {
    var x = new XMLHttpRequest();
    var items, brchItems, currItems;
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            items = x.responseText;
            items = items.split('####');
            brchIdItems = items[0].split(",");
            brchItems = items[1].split(",");
            var optionsbrch = '<option value="">--Select--</option>';
            for (var i = 0; i < brchItems.length; i++) {
                optionsbrch += '<option value="' + brchIdItems[i] + '">'
                        + brchItems[i] + '</option>';
            }
            
            $("select#dashcmbrlsbranch").html(optionsbrch);
            if ($('#dashhidcmbrlsbranch').val() != null) {
                $('#dashcmbrlsbranch').val($('#dashhidcmbrlsbranch').val());
            }
        } else {
        }
    }
    x.open("GET", "getBranch.jsp", true);
    x.send();
}

function getLocation(value)
{
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200)
            {
                items= x.responseText;
                items=items.split('***');
                var locationItems=items[0].split(",");
                var locationidItems=items[1].split(",");
                    var optionslocation = '<option value="">--Select--</option>';
               for ( var i = 0; i < locationItems.length; i++) {
                   optionslocation += '<option value="' + locationidItems[i] + '">' + locationItems[i] + '</option>';
                }
               $("select#dashcmbrlsloc").html(optionslocation);
                if ($('#dashhidcmbrlsloc').val() != null) {
            $('#dashcmbrlsloc').val($('#dashhidcmbrlsloc').val());
        }
            }
        else
            {
            }
    }
    x.open("GET","getLocation.jsp?id="+value,true);
    x.send();
}

function funReleaseClick(){
    document.getElementById("mode").value='R';
    var testfleet=document.getElementById("dashreleasefleet").value;
    var testbranch=document.getElementById("dashcmbrlsbranch").value;
    var testloc=document.getElementById("dashcmbrlsloc").value;
    var testkm=document.getElementById("dashreleasekm").value;
    var testfuel=document.getElementById("dashreleasefuel").value;
    var testdate= $('#dashreleasedate').jqxDateTimeInput('getDate');
    var testtime= $('#dashreleasetime').jqxDateTimeInput('getDate');
    var teststatus=document.getElementById("dashcmbrentalstatus").value;
    
    var testdate=testdate.setHours(0,0,0,0);
    var validdate=funDateInPeriod(testdate);
    if(validdate==0){
        return 0; 
    }
    
    var curdate=new Date();
    var curtime=new Date();
    curdate.setHours(0,0,0,0);
    
    if(testdate-curdate==0){
        if(testtime.getHours()>curtime.getHours()){
            $.messager.alert('Message',"Future Time Not Allowed");
            return false;
        }
        else if(testtime.getHours()==curtime.getHours()){
            if(testtime.getMinutes()>curtime.getMinutes()){
                $.messager.alert('Message',"Future Time Not Allowed");
                return false;
            }
        }
    }
    
    if((testfleet=='')||(testbranch=='')||(testloc=='')||(testkm=='')||(testfuel=='')){
        document.getElementById("dashfleetwarning").style.display="block";
        return false;
    }
    else{
        document.getElementById("dashfleetwarning").style.display="none";
         
         if(document.getElementById("dashreleasefleet").value<=0){
             return false;
         }
         document.getElementById("frmReleaseDashBoard").submit();
    }
}

function setValues(){
     if(($('#msg').val()!="")){
       $.messager.alert('Message',$('#msg').val());
      }
  var brchval = document.getElementById("cmbbranch").value;
    $("#releasediv").load("toBeReleasedGrid.jsp?brchval="+brchval);
}

function funreload(event)
{
  var brchval = document.getElementById("cmbbranch").value;
   $("#releasediv").load("toBeReleasedGrid.jsp?brchval="+brchval);
 }

function getVehicle(){
    if(document.getElementById("dashreleasefleet").value==""){
         $.messager.alert('Message',"Please Select Fleet");
         return false;
    }
    $('#vehiclewindow').jqxWindow('setContent', '');
    $('#vehiclewindow').jqxWindow('open');  
     vehicleSearchContent("<%=contextPath%>/com/controlcentre/masters/vehicle/saveVehicle1.action?mode=view&fleetno="+document.getElementById("dashreleasefleet").value);
}

function vehicleSearchContent(url) {
    $('#vehiclewindow').jqxWindow('focus'); 
    $.get(url).done(function (data) {
$('#vehiclewindow').jqxWindow('setContent', data);
}); 
}

function getAttach(){
    if(document.getElementById("dashreleasefleet").value==""){
         $.messager.alert('Message',"Please Select Fleet");
         return false;
    }
    changeClientAttachContent("<%=contextPath%>/com/common/attachGrid.jsp?formCode=VEH&docno="+document.getElementById("docno").value);  
}

function changeClientAttachContent(url) {
   $.get(url).done(function (data) {
        $('#clientAttachWindow').jqxWindow('open');
     $('#clientAttachWindow').jqxWindow('setContent',data);
     $('#clientAttachWindow').jqxWindow('bringToFront');
  }); 
}
</script>

</head>
<body onload="getBranch();setValues();">
<form id="frmReleaseDashBoard" action="saveReleaseDashBoard">
<div id="mainBG" class="homeContent" data-type="background"> 

    <div class="master-container">

        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">
                <div class="filter-card">

                    <table class="release-filter-table">
                        <tr>
                            <td class="label-cell">Fleet No</td>
                            <td><input type="text" name="dashreleasefleet" id="dashreleasefleet" value='<s:property value="dashreleasefleet"/>'></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Branch</td>
                            <td>
                                <select name="dashcmbrlsbranch" id="dashcmbrlsbranch" onChange="getLocation(this.value);">
                                    <option value="">--Select--</option>
                                </select>
                                <input type="hidden" name="dashhidcmbrlsbranch" id="dashhidcmbrlsbranch" value='<s:property value="dashhidcmbrlsbranch"/>'>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Location</td>
                            <td>
                                <select name="dashcmbrlsloc" id="dashcmbrlsloc">
                                    <option value="">--Select--</option>
                                </select>
                                <input type="hidden" name="dashhidcmbrlsloc" id="dashhidcmbrlsloc" value='<s:property value="dashhidcmbrlsloc"/>'>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Rental</td>
                            <td>
                                <select name="dashcmbrentalstatus" id="dashcmbrentalstatus">
                                    <option value="R" selected>Rental</option>
                                    <option value="L">Lease</option>
                                    <option value="LM">Limousine</option>
                                    <option value="A">All</option>
                                </select>
                                <input type="hidden" name="dashhidcmbrentalstatus" id="dashhidcmbrentalstatus" value='<s:property value="dashhidcmbrentalstatus"/>'>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Date</td>
                            <td><div id="dashreleasedate" name="dashreleasedate" value='<s:property value="dashreleasedate"/>'></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Time</td>
                            <td><div id="dashreleasetime" name="dashreleasetime" value='<s:property value="dashreleasetime"/>'></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">KM</td>
                            <td><input type="text" name="dashreleasekm" id="dashreleasekm" value='<s:property value="dashreleasekm"/>' tabindex="-1" readonly></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Fuel</td>
                            <td>
                                <select name="dashreleasefuel" id="dashreleasefuel" value='<s:property value="dashreleasefuel"/>' tabindex="-1">
                                    <option value="">--Select--</option>
                                    <option value="0.000" selected>Level 0/8</option>
                                    <option value="0.125">Level 1/8</option>
                                    <option value="0.250">Level 2/8</option>
                                    <option value="0.375">Level 3/8</option>
                                    <option value="0.500">Level 4/8</option>
                                    <option value="0.625">Level 5/8</option>
                                    <option value="0.750">Level 6/8</option>
                                    <option value="0.875">Level 7/8</option>
                                    <option value="1.000">Level 8/8</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Op. Status</td>
                            <td><input type="text" name="dashopstatus" id="dashopstatus" value='IN' tabindex="-1" readonly></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Ast status</td>
                            <td><input type="text" name="dashaststatus" id="dashaststatus" value='<s:property value="dashaststatus"/>' tabindex="-1" readonly></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div id="dashfleetwarning">All fields are Mandatory</div>
                            </td>
                        </tr>
                    </table>

                    <input type="hidden" name="hidclient" id="hidclient" >
                    
                    <div class="release-secondary-actions">
                        <button type="button" class="btn-submit" id="btnvehicle" onclick="getVehicle()">Vehicle</button>
                        <button type="button" class="btn-submit" id="btnattach" onclick="getAttach()">Attach</button>
                    </div>

                    <div class="release-actions">
                        <button type="button" class="btn-submit" id="dashbtnrelease" onclick="funReleaseClick()">Release</button>
                    </div>

                </div>
            </div>
        </div>

        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="releasediv"><jsp:include page="toBeReleasedGrid.jsp"></jsp:include></div>
                <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>' > 
                <input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>' >
            </div>

        </div>

    </div> <div id="vehiclewindow">
        <div></div>
    </div>
    
    <div id="clientAttachWindow">
       <div></div>
    </div>

</div>
</form>
</body>
</html>