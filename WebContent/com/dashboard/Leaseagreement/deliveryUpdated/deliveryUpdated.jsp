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

/* Cards */
.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

/* Tables */
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

/* ===== UNIFORM 24px INPUTS & SELECTS ===== */
input[type="text"], select,
.filter-table input[type="text"],
.filter-table select {
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
.filter-table input[readonly],
.filter-table input:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed;
}

/* jqx date/time containers */
.filter-table div[id^="jqx"] {
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
}

.btn-submit:hover {
    background: #1d4ed8;
}

.btn-submit:disabled {
    background: #9ca3af;
    cursor: not-allowed;
}

/* Action buttons layout */
.sidebar-actions {
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
</style>

<script type="text/javascript">
$(document).ready(function () {
	
	 $("#jqxDeliveryOut").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
	 $("#jqxDelTimeOut").jqxDateTimeInput({ width: '100%', height: '24px', formatString: 'HH:mm', showCalendarButton: false ,value: new Date()});
	 $("#jqxDateOut").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
	 $("#jqxTimeOut").jqxDateTimeInput({ width: '100%', height: '24px', formatString: 'HH:mm', showCalendarButton: false });
	 
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	 
	 $('#chauffeurinfowindow').jqxWindow({ width: '30%', height: '55%', maxHeight: '75%', maxWidth: '50%', title: 'Driver Search', position: { x: 200, y: 70 }, keyboardCloseKey: 27});
	 $('#chauffeurinfowindow').jqxWindow('close');
	 
	 // Added Window Attach dynamically as referenced by attach script
	 $('#windowattach').jqxWindow({ autoOpen: false, width: '51%', height: '58%', maxHeight: '70%', maxWidth: '51%', title: 'Attach', position: { x: 300, y: 87 }, showCloseButton: true });

	 $('#jqxDeliveryOut').on('change', function (event) {
		if( $('#fleetno').val() != "") {
		   var indate1 = new Date($('#jqxDateOut').jqxDateTimeInput('getDate'));
		   var agmtdate1 = new Date($('#jqxDeliveryOut').jqxDateTimeInput('getDate')); 
		   indate1.setHours(0,0,0,0);
		   agmtdate1.setHours(0,0,0,0); 
		   if(indate1 > agmtdate1){
			   $.messager.alert('Message',' Delivery Date Cannot Be Less Than Out Date','warning');   
		       return false;
		   }
		}   
	 });
	 
	 $('#jqxDelTimeOut').on('change', function (event) {
		  if( $('#fleetno').val() != "") {
		      var indate1 = new Date($('#jqxDateOut').jqxDateTimeInput('getDate'));    
		      var agmtdate1 = new Date($('#jqxDeliveryOut').jqxDateTimeInput('getDate')); 
		      var intime1 = new Date($('#jqxTimeOut').jqxDateTimeInput('getDate'));  
		      var agmttime1 = new Date($('#jqxDelTimeOut').jqxDateTimeInput('getDate'));   

		      indate1.setHours(0,0,0,0);
		      agmtdate1.setHours(0,0,0,0); 
		      if(indate1 > agmtdate1){
			      $.messager.alert('Message',' Delivery Date Cannot Be Less Than Out Date','warning');   	   
		          return false;
		      }   
		
		      if(indate1.valueOf() == agmtdate1.valueOf()){
		          var out = intime1.getHours();
		          var del = agmttime1.getHours();
		          if(out > del){
			          $.messager.alert('Message',' Delivery Time Cannot Be Less Than Out Time','warning');   
		              return false;
		          }
		          if(out == del){
		              if(intime1.getMinutes() > agmttime1.getMinutes()){
		    	          $.messager.alert('Message',' Delivery Time Cannot Be Less Than Out Time','warning');   
		                  return false;
		              }
		          }
		      }
		  }
	 });
	  
     $('#del_Driver').dblclick(function(){
    	  if($("#chktype").val() == "VCU") {
	  	      $('#chauffeurinfowindow').jqxWindow('open');
              chauffeurSearchContent('SearchDriver.jsp?', $('#chauffeurinfowindow')); 
    	  }
	 });
});

function getchauffeur(event){
	  if($("#chktype").val() == "VCU") {
  	      var x = event.keyCode;
  	      if(x == 114){
  	          $('#chauffeurinfowindow').jqxWindow('open');
              chauffeurSearchContent('SearchDriver.jsp?', $('#chauffeurinfowindow'));  	 
          }
	  }
}

function chauffeurSearchContent(url) {
    $.get(url).done(function (data) {
        $('#chauffeurinfowindow').jqxWindow('setContent', data);
	}); 
}

function funExportBtn(){
	 if(parseInt(window.parent.chkexportdata.value) == "1") {
		 JSONToCSVCon(datass, 'LAG-Delivery Update', true);
	 } else {
		 $("#delupdategrid").jqxGrid('exportdata', 'xls', 'LAG-Delivery Update');
	 }
}

function funreload(event) {
	 disitems();
	 var barchval = document.getElementById("cmbbranch").value;
	 $("#overlay, #PleaseWait").show();
	 $("#delupdiv").load("delupdateGrid.jsp?barchval="+barchval);
}
	
function funAttachBtn(){
	if ($("#rentaldoc").val() != "" && $("#chktype").val() == "LAG") {
		$("#windowattach").jqxWindow('setTitle',"LAG - "+document.getElementById("rentaldoc").value);
		changeAttachContent("<%=contextPath%>/com/dashboard/Attach.jsp?formCode=LAG&docno="+document.getElementById("rentaldoc").value+"&barchvals="+document.getElementById("branchids").value);		
	} else {
		$.messager.alert('Message','Select a Document....!','warning');
		return;
	}
}

function changeAttachContent(url) {
	$.get(url).done(function (data) {
		$('#windowattach').jqxWindow('open');
		$('#windowattach').jqxWindow('setContent',data);
		$('#windowattach').jqxWindow('bringToFront');
    }); 
}	

function funupdate() {
	 if(document.getElementById("del_Driver").value == "") {
		 $.messager.alert('Message',' Search Driver','warning'); 
		 return 0;
	 }
	
	 if(document.getElementById("del_KM").value == "") {
		 $.messager.alert('Message','Enter KM','warning');   	 
		 return 0;
	 }
	
	 if($('#del_Fuel').val() == "") {
		 $.messager.alert('Message',' Select Fuel ','warning');  
		 return 0;
	 }
	 
	 var outkm = document.getElementById("out_km").value;
	 var delkm = document.getElementById("del_KM").value;
	 if((parseFloat(delkm) < parseFloat(outkm))) {
		 $.messager.alert('Message','Delivery KM Less Than Out KM ','warning');  
		 return 0;
	 }

	 var indate1 = new Date($('#jqxDateOut').jqxDateTimeInput('getDate'));    
	 var agmtdate1 = new Date($('#jqxDeliveryOut').jqxDateTimeInput('getDate')); 
	 var intime1 = new Date($('#jqxTimeOut').jqxDateTimeInput('getDate'));  
	 var agmttime1 = new Date($('#jqxDelTimeOut').jqxDateTimeInput('getDate')); 

	 indate1.setHours(0,0,0,0);
	 agmtdate1.setHours(0,0,0,0); 
	 if(indate1 > agmtdate1){
		 $.messager.alert('Message',' Delivery Date Cannot Be Less Than Out Date ','warning');  
	     return 0;
	 }   
	
	 if(indate1.valueOf() == agmtdate1.valueOf()){
	     var out = intime1.getHours();
	     var del = agmttime1.getHours();
	     if(out > del){
		     $.messager.alert('Message',' Delivery Time Cannot Be Less Than Out Time ','warning');   
	         return 0;
	     }
	     if(out == del){
	         if(intime1.getMinutes() > agmttime1.getMinutes()){
	    	     $.messager.alert('Message',' Delivery Time Cannot Be Less Than Out Time ','warning');   
	             return 0;
	         }
	     }
	 }
		
	var drid = document.getElementById("del_Driverid").value;	
	var rentaldoc = document.getElementById("rentaldoc").value;
	var rentaldate = document.getElementById("rentaldate").value;
	var fleetno = document.getElementById("fleetno").value;
	var del_KM = document.getElementById("del_KM").value;
	var del_Fuel = document.getElementById("del_Fuel").value;
	var jqxDeliveryOut = $('#jqxDeliveryOut').val();
	var jqxDelTimeOut = $('#jqxDelTimeOut').val();
	var group = document.getElementById("group").value;
	var vlocation = document.getElementById("vehloca").value;
	var branchval = document.getElementById("branchids").value;
	var cldocno = document.getElementById("cldocno").value;
	
    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
     	if(r == false) {
     		return false; 
     	} else {
     		delsave(rentaldoc,rentaldate,fleetno,del_KM,del_Fuel,jqxDeliveryOut,jqxDelTimeOut,group,vlocation,branchval,cldocno,drid);
     	}
	});
}

function delsave(rentaldoc,rentaldate,fleetno,del_KM,del_Fuel,jqxDeliveryOut,jqxDelTimeOut,group,vlocation,branchval,cldocno,drid) {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function(){
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            document.getElementById("rentaldoc").value = "";
            document.getElementById("fleetno").value = "";
            document.getElementById("del_Driverid").value = "";
            document.getElementById("del_Driver").value = "";
            document.getElementById("chktype").value = "";
            $('#del_Driver').attr('placeholder', ''); 
            document.getElementById("del_KM").value = "";
            document.getElementById("del_Fuel").value = "";
            $('#jqxDeliveryOut').val(new Date());
            $('#jqxDelTimeOut').val(new Date());
            document.getElementById("group").value = "";
            document.getElementById("vehloca").value = "";
            document.getElementById("out_km").value = "";
            document.getElementById("out_fuel").value = "";
            document.getElementById("branchids").value = "";
            document.getElementById("cldocno").value = "";
            $('#jqxDateOut').val("");
            $('#jqxTimeOut').val("");
            disitems();
            funreload(event);
            $.messager.alert('Message', 'Record Successfully Updated');
        }
    }
    x.open("GET","savedeldate.jsp?rentaldoc="+rentaldoc+"&rentaldate="+rentaldate+"&fleetno="+fleetno+"&del_KM="+del_KM+"&del_Fuel="+del_Fuel+"&jqxDeliveryOut="+jqxDeliveryOut+"&jqxDelTimeOut="+jqxDelTimeOut+"&group="+group+"&vlocation="+vlocation+"&branchval="+branchval+"&cldocno="+cldocno+"&chktype="+document.getElementById("chktype").value+"&drid="+drid,true);
    x.send();
}
	
function disitems() {
    document.getElementById("del_Driverid").value = "";
    document.getElementById("del_Driver").value = "";
    document.getElementById("rentaldoc").value = "";
    document.getElementById("rentaldate").value = "";
    document.getElementById("fleetno").value = "";
    document.getElementById("chktype").value = "";
    $('#del_Driver').attr('placeholder', ''); 
    document.getElementById("del_KM").value = "";
    document.getElementById("del_Fuel").value = "";
    $('#jqxDeliveryOut').val(new Date());
    $('#jqxDelTimeOut').val(new Date());
    document.getElementById("group").value = "";
    document.getElementById("vehloca").value = "";
    document.getElementById("out_km").value = "";
    document.getElementById("out_fuel").value = "";
    document.getElementById("branchids").value = "";
    document.getElementById("cldocno").value = "";
    $('#jqxDateOut').val(new Date());
    $('#jqxTimeOut').val(new Date());
    
    $('#jqxDeliveryOut').jqxDateTimeInput({ disabled: true});
    $('#jqxDelTimeOut').jqxDateTimeInput({ disabled: true});
    
    $('#del_KM').attr("readonly",true);
    $('#del_Fuel').attr("disabled",true);
    $('#driverUpdate').attr("disabled",true);
    $('#attachbtns').attr("disabled",true);
}

function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
        $.messager.alert('Message','Enter Numbers Only ','warning');
        return false;
    }
    return true;
}	

function funchkkm() {
    var outkm = document.getElementById("out_km").value;
    var delkm = document.getElementById("del_KM").value;
    if((parseFloat(delkm) < parseFloat(outkm))) {
        $.messager.alert('Message','Delivery KM Less Than Out KM ','warning');
    }
}	
</script>

</head>
<body onload="getBranch();disitems();">

<div id="mainBG" class="homeContent" data-type="background"> 
    <div class="master-container">

        <!-- ===== LEFT SIDEBAR ===== -->
        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">
                <div class="filter-card">
                    
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">Fleet</td>
                            <td><input type="text" name="fleetno" id="fleetno" value='<s:property value="fleetno"/>' readonly="readonly"></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Driver</td>
                            <td><input type="text" name="del_Driver" id="del_Driver" value='<s:property value="del_Driver"/>' readonly="readonly" onkeydown="getchauffeur(event);"></td>
                        </tr>
                        <tr>
                            <td class="label-cell">KM</td>
                            <td><input type="text" name="del_KM" id="del_KM" value='<s:property value="del_KM"/>' onkeypress="return isNumber(event);" onblur="funchkkm();"></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Fuel</td>
                            <td>
                                <select name="del_Fuel" id="del_Fuel">
                                    <option value="">-Select-</option>  
                                    <option value="0.000">Level 0/8</option>
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
                            <td class="label-cell">Date</td>
                            <td>
                                <div id="jqxDeliveryOut"></div>
                                <input type="hidden" id="hidjqxDeliveryOut" name="hidjqxDeliveryOut" value='<s:property value="hidjqxDeliveryOut"/>'>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Time</td>
                            <td>
                                <div id="jqxDelTimeOut"></div>
                                <input type="hidden" id="hidjqxDelTimeOut" name="hidjqxDelTimeOut" value='<s:property value="hidjqxDelTimeOut"/>'>
                            </td>
                        </tr>
                    </table>

                    <div class="sidebar-actions">
                        <button type="button" class="btn-submit" name="driverUpdate" id="driverUpdate" onclick="funupdate()">Update</button>
                        <button type="button" class="btn-submit" name="attachbtns" id="attachbtns" onclick="funAttachBtn()">Attach</button>
                    </div>

                    <!-- Hidden Fields logically kept here -->
                    <input type="hidden" name="chktype" id="chktype" value='<s:property value="chktype"/>'>
                    <input type="hidden" name="del_Driverid" id="del_Driverid" value='<s:property value="del_Driverid"/>'>
                    <input type="hidden" name="rentaldate" id="rentaldate" value='<s:property value="rentaldate"/>'>
                    <input type="hidden" name="rentaldoc" id="rentaldoc" value='<s:property value="rentaldoc"/>'>
                    <input type="hidden" name="out_km" id="out_km" value='<s:property value="out_km"/>'>
                    <input type="hidden" name="out_fuel" id="out_fuel" value='<s:property value="out_fuel"/>'>
                    <input type="hidden" name="branchids" id="branchids" value='<s:property value="branchids"/>'>
                    <input type="hidden" name="group" id="group" value='<s:property value="group"/>'>
                    <input type="hidden" name="vehloca" id="vehloca" value='<s:property value="vehloca"/>'>
                    <input type="hidden" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>'>
                    
                    <div style="display:none;">
                        <div id='jqxDateOut' name='jqxDateOut' value='<s:property value="jqxDateOut"/>'></div>
                        <div id='jqxTimeOut' name='jqxTimeOut' value='<s:property value="jqxTimeOut"/>'></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- ===== RIGHT CONTENT AREA ===== -->
        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="delupdiv">
                    <jsp:include page="delupdateGrid.jsp"></jsp:include>
                </div>
            </div>

        </div>

    </div>

    <!-- POPUP WINDOWS -->
    <div id="chauffeurinfowindow">
       <div></div>
    </div>
    
    <div id="windowattach">
       <div></div>
    </div>

</div>

</body>
</html>