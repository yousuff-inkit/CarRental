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
<style type="text/css">

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


</style>

<script type="text/javascript">

	$(document).ready(function () {
		$('#btneditrep').hide();
		$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#canceldate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
		 $("#canceltime").jqxDateTimeInput({width: '25%', height: '17px', formatString: 'HH:mm', showCalendarButton: false ,value:null});
		 $("#outdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
		 $("#outtime").jqxDateTimeInput({width: '80%', height: '17px', formatString: 'HH:mm', showCalendarButton: false ,value:null});
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	});
		function funreload(event){
			var branch=document.getElementById("cmbbranch").value;
			var fromdate=$('#fromdate').jqxDateTimeInput('val');
			var todate=$('#todate').jqxDateTimeInput('val');
			var agmttype=document.getElementById("cmbagmttype").value;
			var agmtno=document.getElementById("txtagmtno").value;
			var fleetno=document.getElementById("txtfleetno").value;
			$("#overlay, #PleaseWait").show();
			$('#replacediv').load('repCancelGrid.jsp?branch='+branch+'&fromdate='+fromdate+'&todate='+todate+'&agmttype='+agmttype+'&agmtno='+agmtno+'&fleetno='+fleetno+'&mode=1&branch='+branch);
		}
	
	function funOpenRep(){
		var docno=document.getElementById("temprepno").value;
		var url=document.URL;
		  var reurl=url.split("com");
		  window.parent.formName.value="Replacement";
		  window.parent.formCode.value="RPL";
		  var detName= "Replacement";
		  var path= "com/operations/vehicletransactions/replacement/saveReplacement.action?mode=view&docno="+docno;
		  top.addTab( detName,reurl[0]+""+path);
	}
	
	function funCancelRep(){
		if(document.getElementById("cmbbranch").value==""){
			$.messager.alert('warning','Branch is Mandatory');
		}
		var canceldate=$('#canceldate').jqxDateTimeInput('getDate');
		var canceltime=$('#canceltime').jqxDateTimeInput('getDate');
		var cancelkm=document.getElementById("cancelkm").value;
		var cancelfuel=document.getElementById("cmbcancelfuel").value;
		var cancelbranch=document.getElementById("cmbcancelbranch").value;
		var cancelloc=document.getElementById("cmbcancelloc").value;
		var fleetno=document.getElementById("txtfleetno").value;
		if(canceldate==null){
			$.messager.alert('warning','Cancel Date is Mandatory');
			return false;
		}
		if(canceltime==null){
			$.messager.alert('warning','Cancel Time is Mandatory');
			return false;
		}
		canceldate=new Date($('#canceldate').jqxDateTimeInput('getDate'));
		canceltime=new Date($('#canceltime').jqxDateTimeInput('getDate'));
		canceldate.setHours(0,0,0,0);
		 	var repno=document.getElementById("temprepno").value;
			var outdate=new Date($('#outdate').jqxDateTimeInput('getDate'));
			var outtime=new Date($('#outtime').jqxDateTimeInput('getDate'));
			var outkm=document.getElementById("outkm").value;
			var outfuel=document.getElementById("outfuel").value;
			var outbranch=document.getElementById("outbrch").value;
			var outlocation=document.getElementById("outloc").value;
		outdate.setHours(0,0,0,0);
		if(repno=="" || repno==null || typeof(repno)=="undefined"){
			$.messager.alert('warning','Please Select a valid Replacement');
			return false;
			
		}
		
		if(canceldate<outdate){
			$.messager.alert('warning','Cancel Date cannnot be less than Out Date');
			return false;
		}
		
		if(canceldate-outdate==0){
			if(canceltime.getHours()<outtime.getHours()){
				$.messager.alert('warning','Cancel Time cannot be less than Out Time');
				return false;
			}
			else if(canceltime.getHours()==outtime.getHours()){
				if(canceltime.getMinutes()<outtime.getMinutes()){
					$.messager.alert('warning','Cancel Time cannot be less than Out Time');
					return false;
				}
			}
		}
		
		if(cancelkm=="" || cancelkm==null || cancelkm=="undefined"){
			$.messager.alert('warning','Cancel Km is Mandatory');
			return false;
		}
		
		if(cancelfuel==""){
			$.messager.alert('warning','Cancel Fuel is Mandatory');
			return false;
			
		}
		if(cancelbranch==""){
			$.messager.alert('warning','Cancel Branch is Mandatory');
			return false;
		}
		if(cancelloc==""){
			$.messager.alert('warning','Cancel Fuel is Mandatory');
			return false;
		}
		if(cancelkm<outkm){
			$.messager.alert('warning','Cancel KM cannot be less than Out KM');
		}
		$("#overlay, #PleaseWait").show(); 
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
		       var items= x.responseText.trim();
		       if(parseInt(items)>0){
					$("#overlay, #PleaseWait").hide(); 
					$.messager.alert('Message','Successfully Saved');
					funClearData();
					funreload("");
		       }
				else{
					$("#overlay, #PleaseWait").hide(); 
					$.messager.alert('Message','Not Saved');
				}
				}
			else{
				
			}
			}
		x.open("GET","saveData.jsp?cancelbranch="+cancelbranch+"&cancelloc="+cancelloc+"&canceldate="+$('#canceldate').jqxDateTimeInput('val')+"&canceltime="+$('#canceltime').jqxDateTimeInput('val')+"&cancelkm="+cancelkm+"&cancelfuel="+cancelfuel+"&repno="+repno+"&fleet_no="+fleetno,true);
		x.send();
	}
	
	
	function getLocation(value)
	{
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
	        items= x.responseText.trim();
	        items=items.split("***");
	        var locItems = items[0].split(",");
			var locIdItems = items[1].split(",");
			var optionsloc = '<option value="">--Select--</option>';
			for (var i = 0; i < locItems.length; i++) {
				optionsloc += '<option value="' + locIdItems[i] + '">'
						+ locItems[i] + '</option>';
			}
			$("select#cmbcancelloc").html(optionsloc);
			
	        }
		else
			{
			}
	}
	x.open("GET","getLocation.jsp?branch="+value,true);
	x.send();
}

	function getBrch()
	{
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			items= x.responseText.trim();
	        items=items.split("***");
	        var BrchItems = items[0].split(",");
			var BrchIdItems = items[1].split(",");
			var optionsBrch = '<option value="">--Select--</option>';
			for (var i = 0; i < BrchItems.length; i++) {
				optionsBrch += '<option value="' + BrchIdItems[i] + '">' + BrchItems[i] + '</option>';
				}
			$("select#cmbcancelbranch").html(optionsBrch);
			
	        }
		else
			{
			}
	}
	x.open("GET","getBrch.jsp",true);
	x.send();
}
	function setValues(){
		getBrch();
		if(document.getElementById("cmbcancelbranch").value!=""){
			getLocation(document.getElementById("cmbcancelbranch").value);	
		}
		
	}
	
	function funClearData(){
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     document.getElementById("cmbagmttype").value="";
	     document.getElementById("txtagmtno").value="";
	     document.getElementById("txtagmtvocno").value="";
	     document.getElementById("txtfleetno").value="";
	     $('#canceldate').jqxDateTimeInput('setDate',null);
	     $('#canceltime').jqxDateTimeInput('setDate',null);
	     document.getElementById("cancelkm").value="";
	     document.getElementById("cmbcancelfuel").value="";
	     document.getElementById("cmbcancelbranch").value="";
	     document.getElementById("cmbcancelloc").value="";
	}
	
	
	function setMode(){
		if(document.getElementById("rdoedit").checked==true){
			/* document.getElementById("btncancelrep").style.display="none";
			document.getElementById("btneditrep").style.display="block"; */
			$('#btncancelrep').hide();
			$('#btneditrep').show();
			document.getElementById("cmbcancelbranch").disabled=true;
		    document.getElementById("cmbcancelloc").disabled=true;
			
		}
		else if(document.getElementById("rdocancel").checked==true){
			/* document.getElementById("btneditrep").style.display="none";
			document.getElementById("btncancelrep").style.display="block"; */
			$('#btneditrep').hide();
			$('#btncancelrep').show();
			document.getElementById("cmbcancelbranch").disabled=false;
		    document.getElementById("cmbcancelloc").disabled=false;
			
		}
	}
	
	function funEditRep(){
		$("#overlay, #PleaseWait").show(); 
	    var cancelkm=document.getElementById("cancelkm").value;
		var cancelfuel=document.getElementById("cmbcancelfuel").value;
		var fleetno=document.getElementById("txtfleetno").value;
		var repno=document.getElementById("temprepno").value;
	    var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				$("#overlay, #PleaseWait").hide(); 
				 items=x.responseText.trim();
		    		if(items==-1){
		    			$.messager.alert('warning','Not Updated');
		    		}
		    		else if(items==1){
		    			$.messager.alert('warning','Date cannot be less than last vehicle date');
		    		}
		    		else if(items==2){
		    			$.messager.alert('warning','Time cannot be less than last vehicle time');
		    		}
		    		else if(items==3){
		    			$.messager.alert('warning','KM cannot be less than last vehicle Km');
		    		}
		    		else if(items==5){
		    			$.messager.alert('warning','Updated Successfully');
		    			funClearData();
						funreload("");
		    			
		    		}
		    		else{
		    			$.messager.alert('warning','Not Updated');
		    		}
				}
			
			else
				{
				}
			}
		x.open("GET","editRep.jsp?canceldate="+$('#canceldate').jqxDateTimeInput('val')+"&canceltime="+$('#canceltime').jqxDateTimeInput('val')+"&cancelkm="+cancelkm+"&cancelfuel="+cancelfuel+"&repno="+repno+"&fleet_no="+fleetno,true);
		x.send();
	}
	
	function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	JSONToCSVCon(data, 'Cancel Replacements', true);
		 } else {
			 $("#repCancelGrid").jqxGrid('exportdata', 'xls', 'Cancel Replacements');
		 }
	 }
</script>

</head>
<body onload="getBranch();setValues();">

<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ================= LEFT PANEL ================= -->
<td width="20%" valign="top">

<div class="master-container">
<div class="sidebar-filters">

    <!-- FIXED HEADER -->
    <div class="sidebar-fixed-top">
        <div class="filter-card">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>
    </div>

    <!-- SCROLLABLE CONTENT -->
    <div class="sidebar-scroll-content">

        <div class="filter-card">
        <table class="filter-table">

            <tr>
                <td class="label-cell">From</td>
                <td><div id="fromdate" name="fromdate"
                     value='<s:property value="fromdate"/>'></div></td>
            </tr>

            <tr>
                <td class="label-cell">To</td>
                <td><div id="todate" name="todate"
                     value='<s:property value="todate"/>'></div></td>
            </tr>

            <tr>
                <td colspan="2" style="text-align:center;">
                    <input type="radio" name="rdomode" id="rdocancel"
                           checked onchange="setMode();">
                    <label class="branch" for="rdocancel">Cancel</label>

                    &nbsp;&nbsp;&nbsp;

                    <input type="radio" name="rdomode" id="rdoedit"
                           onchange="setMode();">
                    <label class="branch" for="rdoedit">Edit</label>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Agmt Type</td>
                <td>
                    <select name="cmbagmttype" id="cmbagmttype">
                        <option value="">--Select--</option>
                        <option value="RAG">Rental</option>
                        <option value="LAG">Lease</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Agmt No</td>
                <td>
                    <input type="hidden" name="txtagmtno" id="txtagmtno">
                    <input type="text" name="txtagmtvocno" id="txtagmtvocno"
                           placeholder="Press F3 to Search" readonly>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Fleet No</td>
                <td>
                    <input type="text" name="txtfleetno" id="txtfleetno"
                           placeholder="Press F3 to Search" readonly>
                </td>
            </tr>

        </table>
        </div>

        <!-- CANCEL DETAILS CARD -->
        <div class="filter-card">
        <table class="filter-table">

            <tr>
                <td class="label-cell">Date</td>
                <td><div id="canceldate"></div></td>
            </tr>

            <tr>
                <td class="label-cell">Time</td>
                <td><div id="canceltime"></div></td>
            </tr>

            <tr>
                <td class="label-cell">KM</td>
                <td><input type="text" id="cancelkm"></td>
            </tr>

            <tr>
                <td class="label-cell">Fuel</td>
                <td>
                    <select id="cmbcancelfuel">
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
                <td class="label-cell">Branch</td>
                <td>
                    <select id="cmbcancelbranch"
                            onchange="getLocation(this.value);">
                        <option value="">--Select--</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Location</td>
                <td>
                    <select id="cmbcancelloc">
                        <option value="">--Select--</option>
                    </select>
                </td>
            </tr>

        </table>
        </div>

        <!-- ACTION BUTTONS -->
        <div style="display:flex;flex-wrap:wrap;gap:8px;justify-content:center;">
            <button class="btn-submit" type="button" onclick="funCancelRep();">
                Cancel Rep
            </button>

            <button class="btn-submit" type="button" onclick="funEditRep();">
                Edit Rep
            </button>

            <button class="btn-submit" type="button" onclick="funOpenRep();">
                Open Rep
            </button>

            <button class="btn-submit" type="button" onclick="funClearData();">
                Clear
            </button>
        </div>

    </div>
</div>
</div>

</td>

<!-- ================= RIGHT PANEL ================= -->
<td width="80%" valign="top">

<table width="100%">
<tr>
    <td>
        <div id="replacediv">
            <jsp:include page="repCancelGrid.jsp"></jsp:include>
        </div>
    </td>
</tr>
</table>

</td>

</tr>
</table>

</div>
</div>

<!-- HIDDEN FIELDS -->
<input type="hidden" id="outkm">
<input type="hidden" id="outfuel">
<input type="hidden" id="outbrch">
<input type="hidden" id="outloc">
<div id="outdate" hidden></div>
<div id="outtime" hidden></div>

</body>

</html>