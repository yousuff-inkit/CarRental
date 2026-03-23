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
  
.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', Tahoma, sans-serif;
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
    padding-right: 10px;
    font-size: 13px;
    font-weight: 600;
    color: #4e5e71;
    width: 90px;
}

input[type="text"], select {
    width: 100%;
    padding: 7px 10px;
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    font-size: 13px;
}

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
	 /* $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");     */
	    $('#agmtnowindow').jqxWindow({ width: '60%', height: '68%',  maxHeight: '68%' ,maxWidth: '60%' , title: 'Agreement Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#agmtnowindow').jqxWindow('close');
	    $("#periodupto").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#indate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	 $("#intime").jqxDateTimeInput({ width: '80%', height: '17px', formatString: 'HH:mm', showCalendarButton: false ,value:null});
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
	  /*  $('#gridRaSearch').jqxGrid('clear');
	 $("#gridRaSearch").jqxGrid("addrow", null, {}); */
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
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#agmtnowindow').jqxWindow('setContent', data);

}); 
}
function funDisable(){
	/* $('input[type=text],[type=email],[type=hidden],[type=password], textarea').val('');
	$('select').find('option').prop("selected", false); */
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
	//alert("start=="+startkm+"===inkm=="+typekm);
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
	 //$('#agmtdetails').val('');
	 $('#fleet_no').val('');
	 $('#indate').jqxDateTimeInput('setDate',null);
	 $('#intime').jqxDateTimeInput('setDate',null);
	 $('#inkm').val('');
	 $('#cmbinfuel').val('');
	 $('#pickdesc').val('');
	 $('#docno').val('');
	// $('#agmtdetails').innerText('');
	//document.getElementById("agmtdetails").innerText="";
 }
 
</script>
</head>
<body onload="setValues();">
<form id="frmVehiclePickup" action="saveVehiclePickup" method="post" autocomplete="off">

<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<table width="100%">
<tr>

<td width="20%">
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
                            onclick="funpickupadd();">
                        Add
                    </button>

                    <button type="button"
                            class="btn-submit"
                            id="btnpickupsave"
                            hidden="true"
                            onclick="funpickupsave();">
                        Save
                    </button>
                </div>

                <!-- In Details -->
                <div class="filter-card">
                    <fieldset id="pickupfield">
                        <legend><b>In Details</b></legend>

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
                <button type="button"
                        class="btn-submit"
                        id="btnpickupprint"
                        onclick="funPickupPrint();">
                    Print
                </button>

                <button type="button"
                        id="btnpickypdelete"
                        onclick="funPickupDelete();"
                        style="width:100%; padding:11px; margin-top:8px; background:#dc2626; color:#fff; border:none; border-radius:6px; font-weight:600;">
                    Delete
                </button>

                <div class="filter-card">
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