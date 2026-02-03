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
/* ===== MASTER LAYOUT ===== */
.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', Tahoma, sans-serif;
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

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 20px 25px;
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

.label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 13px;
    font-weight: 600;
    color: #4e5e71;
    width: 90px;
}

/* Inputs */
input[type="text"], select {
    width: 100%;
    padding: 7px 10px;
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    font-size: 13px;
}

/* Buttons */
.btn-submit {
    width: 100%;
    padding: 11px;
    margin-top: 10px;
    background: #2563eb;
    color: #fff;
    border: none;
    border-radius: 6px;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
}

.btn-submit:hover {
    background: #1d4ed8;
}

/* Page height fix */
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
/* ================= RELEASE DASHBOARD – FILTER SIDEBAR ================= */

.release-filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.release-filter-table .label-cell {
    text-align: right;
    padding-right: 12px;
    font-size: 13px;
    color: #4e5e71;
    font-weight: 600;
    width: 90px;
}

/* Inputs & selects */
.release-filter-table input[type="text"],
.release-filter-table select {
    width: 100%;
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    padding: 7px 10px;
    font-size: 13px;
    background-color: #ffffff;
    box-sizing: border-box;
}

/* jqx date/time containers */
.release-filter-table div[id^="dashrelease"] {
    width: 100%;
}

/* Readonly / disabled look */
.release-filter-table input[readonly],
.release-filter-table input:disabled {
    background-color: #f3f6f9;
    color: #555;
}

/* Warning text */
#dashfleetwarning {
    color: #dc2626;
    font-size: 12px;
    font-weight: 600;
    text-align: center;
    margin-top: 5px;
}

/* Action buttons */
.release-actions {
    display: flex;
    gap: 10px;
    justify-content: center;
    margin-top: 10px;
}

.release-actions .btn-submit {
    width: auto;
    min-width: 120px;
    padding: 10px 16px;
}

/* Vehicle / Attach buttons */
.release-secondary-actions {
    display: flex;
    gap: 10px;
    justify-content: center;
    margin-top: 5px;
}
</style>
 
<script type="text/javascript">
$(document).ready(function () {
	
	document.getElementById("dashfleetwarning").style.display="none";
	document.getElementById("dashbtnrelease").disabled=true;
	document.getElementById("dashreleasefuel").disabled=true;
	document.getElementById("btnvehicle").disabled=true;
	document.getElementById("btnattach").disabled=true;
	 $("#dashreleasedate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#dashreleasetime").jqxDateTimeInput({ width: '20%', height: '17px', formatString: 'HH:mm', showCalendarButton: false ,value: new Date()});
	/*  $('#vehiclewindow').jqxWindow({ autoOpen: false,width: '80%', height: '70%',  maxHeight: '70%' ,maxWidth: '80%' , title: 'Vehicle Details' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'});
	   $('#vehiclewindow').jqxWindow('close'); */
	 /*   $('#clientWindow').jqxWindow({ autoOpen: false,width: '78%', height: '85%',  maxHeight: '85%' ,maxWidth: '78%' , title: 'Client Details' , theme: 'energyblue', position: { x: 280, y: 10 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'});
	   $('#clientWindow').jqxWindow('close'); */
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
	 //$("#toBeReleasedGrid").jqxGrid('exportdata', 'xls', 'ToBeReleased');

   
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
					//alert(items);
			 	items=items.split('***');
		        var locationItems=items[0].split(",");
		        var locationidItems=items[1].split(",");
		        	var optionslocation = '<option value="">--Select--</option>';
		       for ( var i = 0; i < locationItems.length; i++) {
		    	   optionslocation += '<option value="' + locationidItems[i] + '">' + locationItems[i] + '</option>';
		        }
		       $("select#dashcmbrlsloc").html(optionslocation);
			   //	$('#accno').val($('#accnohidden').val()) ;
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
//document.write(document.getElementById("authname").value);

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
	//alert(here);
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	items= x.responseText;
					//alert(items);
			 	items=items.split('***');
		        var locationItems=items[0].split(",");
		        var locationidItems=items[1].split(",");
		        	var optionslocation = '<option value="">--Select--</option>';
		       for ( var i = 0; i < locationItems.length; i++) {
		    	   optionslocation += '<option value="' + locationidItems[i] + '">' + locationItems[i] + '</option>';
		        }
		       $("select#dashcmbrlsloc").html(optionslocation);
			   //	$('#accno').val($('#accnohidden').val()) ;
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
//document.write(document.getElementById("authname").value);

}
function funReleaseClick(){
	/* alert("Inside"); */
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
			document.getElementById("dashreleasefuel").disabled=false;
		 document.getElementById("frmReleaseDashBoard").submit();
		//funVehRelease(testfleet,testbranch,testloc,testkm,testfuel,testdate,testtime,teststatus);
		
		
	}
	document.getElementById("dashreleasefuel").disabled=true;
}

function setValues(){
	/* if($('#dashhidreleasetime').val()){
		$("#dashreleasetime").jqxDateTimeInput('val', $('#dashhidreleasetime').val());
	}
	/*  if (($('#hidcmbrentalstatus').val() != null)||($('#hidcmbrentalstatus').val() != "")) {
		$('#cmbrentalstatus').val($('#hidcmbrentalstatus').val());
	} 
	//alert("AAA"+$('#hidcmbrentalstatus').val()+"BBB");
	 /* if($('#dashhidreleasedate').val()){
			$("#dashreleasedate").jqxDateTimeInput('val', $('#hidreleasedate').val());
		} 
	 if ($('#dashhidreleasefuel').val() != null) {
			$('#dashreleasefuel').val($('#dashhidreleasefuel').val());
		}
	 if ($('#dashhidcmbrlsbranch').val() != null) {
			$('#dashcmbrlsbranch').val($('#dashhidcmbrlsbranch').val());
		} 
	 if ($('#dashhidcmbrlsloc').val() != null) {
			$('#dashcmbrlsloc').val($('#dashhidcmbrlsloc').val());
		}  */
	
	 if(($('#msg').val()!="")){
		   $.messager.alert('Message',$('#msg').val());
		  }
	/*  if(document.getElementById("cmbbranch").value==''){
			document.getElementById("msg").value="Invalid Branch";
			 $.messager.alert('Message',$('#msg').val());
			 return false;
		} */
	
	  var brchval = document.getElementById("cmbbranch").value;
	    $("#releasediv").load("toBeReleasedGrid.jsp?brchval="+brchval);

}
function funreload(event)
{
	
  var brchval = document.getElementById("cmbbranch").value;
 // var exdate = $('#insuexpdate').val();
 
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
	//$('#vehiclewindow').jqxWindow('open');	
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

<div id="mainBG" class="homeContent">
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ================= LEFT SIDEBAR ================= -->
<td width="20%">
<div class="master-container">
<div class="sidebar-filters">

    <!-- Fixed Heading -->
    <div class="sidebar-fixed-top">
        <div class="filter-card">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>
    </div>

    <!-- Scrollable Filters -->
    <div class="sidebar-scroll-content">
        <div class="filter-card">

            <table class="release-filter-table">

                <tr>
                    <td class="label-cell">Fleet No</td>
                    <td><input type="text" id="dashreleasefleet" name="dashreleasefleet"
                               value='<s:property value="dashreleasefleet"/>'></td>
                </tr>

                <tr>
                    <td class="label-cell">Branch</td>
                    <td>
                        <select id="dashcmbrlsbranch" name="dashcmbrlsbranch"
                                onchange="getLocation(this.value);"></select>
                        <input type="hidden" id="dashhidcmbrlsbranch" name="dashhidcmbrlsbranch">
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Location</td>
                    <td>
                        <select id="dashcmbrlsloc" name="dashcmbrlsloc"></select>
                        <input type="hidden" id="dashhidcmbrlsloc" name="dashhidcmbrlsloc">
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Rental</td>
                    <td>
                        <select id="dashcmbrentalstatus" name="dashcmbrentalstatus">
                            <option value="R">Rental</option>
                            <option value="L">Lease</option>
                            <option value="LM">Limousine</option>
                            <option value="A">All</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Date</td>
                    <td><div id="dashreleasedate"></div></td>
                </tr>

                <tr>
                    <td class="label-cell">Time</td>
                    <td><div id="dashreleasetime"></div></td>
                </tr>

                <tr>
                    <td class="label-cell">KM</td>
                    <td><input type="text" id="dashreleasekm" readonly></td>
                </tr>

                <tr>
                    <td class="label-cell">Fuel</td>
                    <td>
                        <select id="dashreleasefuel">
                            <option value="">--Select--</option>
                            <option value="0">Level 0/8</option>
                            <option value="0.125">Level 1/8</option>
                            <option value="0.25">Level 2/8</option>
                            <option value="0.375">Level 3/8</option>
                            <option value="0.5">Level 4/8</option>
                            <option value="0.625">Level 5/8</option>
                            <option value="0.75">Level 6/8</option>
                            <option value="0.875">Level 7/8</option>
                            <option value="1">Level 8/8</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Op. Status</td>
                    <td><input type="text" value="IN" disabled></td>
                </tr>

                <tr>
                    <td class="label-cell">Ast Status</td>
                    <td><input type="text" id="dashaststatus" readonly></td>
                </tr>

                <tr>
                    <td colspan="2">
                        <div id="dashfleetwarning">All fields are Mandatory</div>
                    </td>
                </tr>

            </table>

            <div class="release-secondary-actions">
                <button type="button" class="btn-submit" id="btnvehicle" onclick="getVehicle()">Vehicle</button>
                <button type="button" class="btn-submit" id="btnattach" onclick="getAttach()">Attach</button>
            </div>

            <div class="release-actions">
                <button type="button" class="btn-submit" id="dashbtnrelease"
                        onclick="funReleaseClick()">Release</button>
            </div>

        </div>
    </div>

</div>
</div>
</td>

<!-- ================= RIGHT GRID ================= -->
<td width="80%">
    <div id="releasediv">
        <jsp:include page="toBeReleasedGrid.jsp"></jsp:include>
    </div>

    <input type="hidden" id="mode" name="mode">
    <input type="hidden" id="docno" name="docno">
</td>

</tr>
</table>

</div>

<div id="vehiclewindow"><div></div></div>
<div id="clientAttachWindow"><div></div></div>

</div>
</form>
</body>
</html>