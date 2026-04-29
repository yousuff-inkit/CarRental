<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<% String contextPath=request.getContextPath();%>
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

/* TEXTAREA STYLING */
textarea {
    width: 100%;
    height: 80px; 
    padding: 8px;         
    border: 1px solid #ccd6e0 !important;
    border-radius: 4px !important;       
    font-size: 12px !important;          
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    background-color: #f3f6f9 !important; 
    box-sizing: border-box;
    color: #555;
    outline: none;
    resize: vertical;
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
    transition: all 0.2s ease;
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
         
         $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
         $("#todate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
         
         $('#vehicleDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Vehicle Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
         $('#vehicleDetailsWindow').jqxWindow('close');
         
         $('#inspectionWindow').jqxWindow({ autoOpen: false,width: '78%', height: '85%',  maxHeight: '85%' ,maxWidth: '78%' , title: 'Inspection Details' , theme: 'energyblue', position: { x: 280, y: 10 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'});
         
         $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
         $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
        
         var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
         var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
         var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
         $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
         
         $('#txtvehicle').dblclick(function(){
              vehicleSearchContent('vehicleDetailsGrid.jsp');
            });
    });
    
    function vehicleSearchContent(url) {
        $('#vehicleDetailsWindow').jqxWindow('open');
        $.get(url).done(function (data) {
        $('#vehicleDetailsWindow').jqxWindow('setContent', data);
        $('#vehicleDetailsWindow').jqxWindow('bringToFront');
    }); 
    }
    
    function inspectionSearchContent(url) {
         $('#inspectionWindow').jqxWindow('focus'); 
         $.get(url).done(function (data) {
         $('#inspectionWindow').jqxWindow('setContent', data);
        }); 
        }
    
    function getVehicle(event){
        var x= event.keyCode;
        if(x==114){
            vehicleSearchContent('vehicleDetailsGrid.jsp');
        }
        else{
         }
        }
    
    function funreload(event){
         var branchval = document.getElementById("cmbbranch").value;
         var type = $('#cmbtype').val();
         var fleetno = $('#txtfleetno').val();
         var fromdate = $('#fromdate').val();
         var todate = $('#todate').val();
         
         if(type==''){
             $.messager.alert('Message','Please Choose a Review Type.','warning');
             return 0;
         }

         $("#overlay, #PleaseWait").show();
         
         if(type==1){
             $("#serviceHistoryDiv").prop("hidden", true);
             $("#accidentHistoryDiv").prop("hidden", false);
             $("#accidentHistoryDiv").load("accidentHistoryGrid.jsp?branchval="+branchval+'&type='+type+'&fromdate='+fromdate+'&todate='+todate+'&fleetno='+fleetno+'&id=1');
         }
         else{  
             $("#accidentHistoryDiv").prop("hidden", true); 
             $("#serviceHistoryDiv").prop("hidden", false);
             $("#serviceHistoryDiv").load("serviceHistoryGrid.jsp?branchval="+branchval+'&type='+type+'&fromdate='+fromdate+'&todate='+todate+'&fleetno='+fleetno+'&id=1');
         }
        }
    
    function funClearInfo(){
         $('#cmbbranch').val('a');
         $('#fromdate').val(new Date());
         var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
         var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
         var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
         $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
         
         $('#todate').val(new Date());
         $("#cmbtype").val('');$("#txtvehicle").val('');$("#txtfleetno").val('');$("#txtvehdocno").val('');
         
         $("#accidentHistory").jqxGrid('clear');$("#serviceHistory").jqxGrid('clear');      
         
         if (document.getElementById("txtvehicle").value == "") {
                $('#txtvehicle').attr('placeholder', 'Press F3 to Search'); 
          }
         document.getElementById("vehinfo").value="";     
        }
    
    function funMaintenancePrint(){
        var fleetno = $('#txtfleetno').val();
        if(fleetno==''){
             $.messager.alert('Message','Please Choose a Fleet.','warning');
             return 0;
         }
        
        if ($("#txtfleetno").val()!="") {
            var url=document.URL;
            var reurl=url.split("maintenanceReview.jsp");
            $("#txtfleetno").prop("disabled", false);
            var win= window.open(reurl[0]+"printMaintenanceReview?&fleetno="+document.getElementById("txtfleetno").value+'&branch='+document.getElementById("cmbbranch").value+'&fromdate='+$("#fromdate").val()+'&todate='+$("#todate").val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
            win.focus();
         }
        else {
            $.messager.alert('Message','Fleet is Mandatory.','warning');
            return;
        }
    }
       
    function funExportBtn(){
         if(parseInt(window.parent.chkexportdata.value)=="1") {
             if(temp1=='1') JSONToCSVCon(data2, 'AccidentHistory', true);
             if(temp1=='2') JSONToCSVCon(data1, 'ServiceHistory', true);
         } else {
             if(temp1=='1') $("#accidentHistory").jqxGrid('exportdata', 'xls', 'AccidentHistory');
             if(temp1=='2') $("#serviceHistory").jqxGrid('exportdata', 'xls', 'ServiceHistory');
         }
    }
</script>
</head>
<body onload="getBranch();">

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
                        <td class="label-cell">Period</td>
                        <td><div id="fromdate"></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">To</td>
                        <td><div id="todate"></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Review</td>
                        <td>
                            <select id="cmbtype" name="cmbtype">
                                <option value="">--Select--</option>
                                <option value="1">Accident History</option>
                                <option value="2">Service History</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Vehicle</td>
                        <td>
                            <input type="text" id="txtvehicle" name="txtvehicle" placeholder="Press F3 to Search" readonly onkeydown="getVehicle(event);">
                            <input type="hidden" id="txtfleetno" name="txtfleetno">
                        </td>
                    </tr>
                </table>
            </div>

            <div class="filter-card">
                <textarea id="vehinfo" name="vehinfo" readonly><s:property value="vehinfo"></s:property></textarea>
                <input type="hidden" id="txtvehdocno" name="txtvehdocno">
            </div>

            <div class="button-group" style="margin-top: 15px;">
                <button type="button" class="myButton" onclick="funClearInfo();" style="margin-top:0;">Clear</button>
                <button type="button" class="myButton" onclick="funMaintenancePrint();" style="margin-top:0;">Print</button>
            </div>
        </div>
    </div>

    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="accidentHistoryDiv">
                <jsp:include page="accidentHistoryGrid.jsp"></jsp:include>
            </div>
            <div id="serviceHistoryDiv" hidden>
                <jsp:include page="serviceHistoryGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>

</div>

<div id="vehicleDetailsWindow"><div></div><div></div></div>
<div id="inspectionWindow"><div></div></div>

</div>
</div>
</body>
</html>