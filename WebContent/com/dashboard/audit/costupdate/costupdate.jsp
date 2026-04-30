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
/* 🔹 Inputs + Dropdowns */
input[type="text"],
select {
    width: 100%;
    height: 24px !important;
    padding: 0 8px !important;
    border: 1px solid #ccd6e0;
    border-radius: 4px;
    font-size: 13px;
    box-sizing: border-box;
    line-height: 24px;
}

/* 🔹 Dropdown text */
select {
    font-size: 13px !important;
}

/* 🔹 Buttons */
.btn-submit,
.myButtons,
.myButton,
input[type="button"],
button {
    width: 100%;
    height: 24px !important;
    padding: 0 10px !important;
    border-radius: 4px;
    font-size: 13px;
    font-weight: 600;
    box-sizing: border-box;
    line-height: 24px;
}

/* 🔹 Fix for any library overriding (like jqx / external CSS) */
.jqx-widget input,
.jqx-widget select {
    height: 24px !important;
    line-height: 24px !important;
}

</style>
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 

<script type="text/javascript">

$(document).ready(function () {
	  // setType(null);
	  
	   $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
	$('#vehdetaildiv').hide();
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $('#costCodeDetailsWindow').jqxWindow({ width: '60%', height: '68%',  maxHeight: '68%' ,maxWidth: '60%' , title: 'Cost Detail Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#costCodeDetailsWindow').jqxWindow('close');
	 
	   var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
       var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
       $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
       
       $('#costmissingdiv').hide();
       document.getElementById("rdodifference").checked=true;
       setCosttype();
       getCostType();
       
       
       
       $('#costcode').dblclick(function(){
			 if(document.getElementById("cmbcosttype").value==""){
						$.messager.alert('warning','Cost Type is Mandatory');
						return false;
				}
		    $('#costCodeDetailsWindow').jqxWindow('open');
		$('#costCodeDetailsWindow').jqxWindow('focus');
		costCodeDetailsContent('costCodeDetailsSearch.jsp?', $('#costCodeDetailsWindow'));
			 
			 });
     });


function getCostCodeKey(event){
	 if(document.getElementById("cmbcosttype").value==""){
			$.messager.alert('warning','Cost Type is Mandatory');
			return false;
	}
	 var x= event.keyCode;
   if(x==114){
	   $('#costCodeDetailsWindow').jqxWindow('open');
		$('#costCodeDetailsWindow').jqxWindow('focus');
		costCodeDetailsContent('costCodeDetailsSearch.jsp?', $('#costCodeDetailsWindow'));
			 
   }
   else{
    }
}

function costCodeDetailsContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#costCodeDetailsWindow').jqxWindow('setContent', data);

}); 
}
function funreload(event)
{
	if(document.getElementById("cmbbranch").value==""){
		$.messager.alert('Warning','Please Select Branch');
		return false;
	}
	var dateval=funDateInPeriod($('#todate').jqxDateTimeInput('getDate'));
	//alert(dateval);
	if(dateval==1){
		 var branch=document.getElementById("cmbbranch").value;
	     var fromdate=$('#fromdate').jqxDateTimeInput('val');
	     var todate=$('#todate').jqxDateTimeInput('val');
	  
	    	 $("#overlay, #PleaseWait").show();
	    	 if(document.getElementById("rdomissing").checked==true){
	    		 $("#costmissingdiv").load("costMissingGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&id=1");
	 		}
	 		else if(document.getElementById("rdodifference").checked==true){

		    	 $("#costupdatediv").load("costupdateGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&id=1");   	 
	 		}
	}
	}
	

	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message',$('#msg').val());
		   $("#overlay, #PleaseWait").hide();
   		  }
		
		 
	}
	function funExportBtn(){
		 $("#vehUtilizeGrid").jqxGrid('exportdata', 'xls', 'Vehicle Utilization');
		
		
	}

	
	function funClearData(){
		$('input[type=text],[type=hidden]').val('');
		
	}

	function funPost(){
		var rows = $("#costupdateGrid").jqxGrid('selectedrowindexes');
		document.getElementById("hidtrno").value="";
		document.getElementById("hidgridacno").value="";
		/* for(var i=0;i<rows.length;i++){
    		var trno=$('#costupdateGrid').jqxGrid('getcellvalue',rows[i],'tr_no');
    		var acno=$('#costupdateGrid').jqxGrid('getcellvalue',rows[i],'acno');
    		if(rows.length==1){
    			document.getElementById("hidtrno").value=dummy+",";
    			document.getElementById("hidgridacno").value=acno+"::"+$('#costupdateGrid').jqxGrid('getcellvalue',rows[i],'tr_no')+",";
    		}
    		else{
    			document.getElementById("hidtrno").value+=acno+",";
    			document.getElementById("hidgridacno").value+=acno+",";
    		}
    	}
		if(document.getElementById("rdodifference").checked==true){
			document.getElementById("mode").value="A";
			$("#overlay, #PleaseWait").show();
			document.getElementById("frmCostUpdate").submit();			
		} */
		for(var i=0;i<rows.length;i++){
			var trno=$('#costupdateGrid').jqxGrid('getcellvalue',rows[i],'tr_no');
    		var acno=$('#costupdateGrid').jqxGrid('getcellvalue',rows[i],'acno');
    		if(i==0){
    			document.getElementById("hidgridacno").value=acno+"::"+trno;
    		}
    		else{
    			document.getElementById("hidgridacno").value+=","+acno+"::"+trno;
    		}
		}
		if(document.getElementById("rdodifference").checked==true){
			document.getElementById("mode").value="A";
			$("#overlay, #PleaseWait").show();
			document.getElementById("frmCostUpdate").submit();			
		}
	}
	
	function setCosttype(){
		if(document.getElementById("rdomissing").checked==true){
			$('#costupdatediv').hide();
			$('#costmissingdiv').show();
			$('#btncostupdate').show();
		}
		else if(document.getElementById("rdodifference").checked==true){
			$('#costmissingdiv').hide();
			$('#costupdatediv').show();
			$('#btncostupdate').hide();
		}
	}
	
	
	function getCostType() {
		  var x = new XMLHttpRequest();
		  x.onreadystatechange = function() {
		   if (x.readyState == 4 && x.status == 200) {
		    var items = x.responseText;
		    items = items.split('####');
		    var srno  = items[0].split(",");
		    var process = items[1].split(",");
		    var optionsbranch = '<option value="" selected>-- Select -- </option>';
		    for (var i = 0; i < process.length; i++) {
		     optionsbranch += '<option value="' + srno[i].trim() + '">'
		       + process[i] + '</option>';
		    }
		    $("select#cmbcosttype").html(optionsbranch);
		    
		   } else {}
		  }
		  x.open("GET","getCostType.jsp", true);
		  x.send();
		 }
	
	
	function funClearCosts(){
		$('#costcode,#costcodename,#hidcostcode').val('');
		$('#costcode').attr('placeholder','Press F3 to Search');
	}
	
	
	function funMissingUpdate(){
		if(document.getElementById("rdomissing").checked==false){
			$.messager.alert('warning','Please Enable the missing option');
			return false;
		}
		if(document.getElementById("cmbcosttype").value==""){
			$.messager.alert('warning','Please choose cost type');
			return false;
		}
		if(document.getElementById("costcode").value==""){
			$.messager.alert('warning','Please choose cost code');
			return false;
		}
		var selectedrows=$('#costMissingGrid').jqxGrid('selectedrowindexes');
		var trno="";
		for( var i=0;i<selectedrows.length;i++){
			if(i==0){
				document.getElementById("missingtrno").value+=$('#costMissingGrid').jqxGrid('getcellvalue',selectedrows[i],'tr_no')+"::"+$('#costMissingGrid').jqxGrid('getcellvalue',selectedrows[i],'acno');
			}
			else{
				document.getElementById("missingtrno").value+=","+$('#costMissingGrid').jqxGrid('getcellvalue',selectedrows[i],'tr_no')+"::"+$('#costMissingGrid').jqxGrid('getcellvalue',selectedrows[i],'acno');
			}
		}
		document.getElementById("mode").value="MU";
		$("#overlay, #PleaseWait").show();
		document.getElementById("frmCostUpdate").submit();		
		
	}
	function funUpdateMissing(trno,costtype,costcode){
		//alert(trno+"::"+costtype+"::"+costcode);
	/* 	  var x = new XMLHttpRequest();
		  x.onreadystatechange = function() {
		   if (x.readyState == 4 && x.status == 200) {
		    var items = x.responseText.trim();
		    if(items=="1"){
		    	$.messager.alert('warning','Updated Successfully');
		    	funreload("");
		    }
		    else{
		    	$.messager.alert('warning','Not Updated');
		    	funreload("");
		    }
		   } else {}
		  }
		  x.open("POST","updateCostMissing.jsp?trno="+trno+"&costtype="+costtype+"&costcode="+costcode, true);
		  x.send();
	 */
	 }
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmCostUpdate" method="post" action="saveCostUpdate">

<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ================= LEFT PANEL (20%) ================= -->
<td width="20%">

<div class="master-container">
<div class="sidebar-filters">

    <!-- ===== FIXED HEADING ===== -->
    <div class="sidebar-fixed-top">
        <div class="filter-card">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>
    </div>

    <!-- ===== SCROLLABLE CONTENT ===== -->
    <div class="sidebar-scroll-content">

        <!-- ===== DATE RANGE ===== -->
        <div class="filter-card">
            <table class="filter-table">
                <tr>
                    <td class="label-cell">From Date</td>
                    <td><div id="fromdate"></div></td>
                </tr>
                <tr>
                    <td class="label-cell">To Date</td>
                    <td><div id="todate"></div></td>
                </tr>
            </table>
        </div>

        <!-- ===== COST MODE ===== -->
        <div class="filter-card">
            <table class="filter-table">
                <tr>
                    <td colspan="2">
                        <input type="radio" name="rdocosttype" id="rdomissing"
                               onchange="setCosttype();">
                        <label for="rdomissing">Manual</label>
                        &nbsp;&nbsp;
                        <input type="radio" name="rdocosttype" id="rdodifference"
                               onchange="setCosttype();">
                        <label for="rdodifference">Automatic</label>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Cost Type</td>
                    <td>
                        <select id="cmbcosttype" name="cmbcosttype"
                                onchange="funClearCosts();">
                            <option value="">--Select--</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Cost Code</td>
                    <td>
                        <input type="text" id="costcode" name="costcode"
                               placeholder="Press F3 to Search"
                               readonly
                               onkeydown="getCostCodeKey(event);">
                    </td>
                </tr>

                <tr>
                    <td></td>
                    <td>
                        <input type="text" id="costcodename"
                               name="costcodename" readonly>
                    </td>
                </tr>
            </table>
        </div>

        <!-- ===== UPDATE ===== -->
        <button class="btn-submit" type="button"
                id="btncostupdate"
                onclick="funMissingUpdate();">
            Update
        </button>

        <!-- ===== CLEAR / POST ===== -->
        <div class="filter-card" style="border-top:2px solid #DCDDDE;">
            <div style="text-align:center;">
                <button type="button" class="btn-submit"
                        id="btnclear"
                        onclick="funClearData();">
                    Clear
                </button>
                &nbsp;&nbsp;
                <button type="button" class="btn-submit"
                        id="btnpost"
                        onclick="funPost();">
                    Post
                </button>
            </div>
        </div>

    </div>
</div>
</div>

</td>

<!-- ================= RIGHT PANEL (80%) ================= -->
<td width="80%">

<table width="100%">
<tr>
    <td>
        <div id="costupdatediv">
            <jsp:include page="costupdateGrid.jsp"></jsp:include>
        </div>

        <div id="costmissingdiv">
            <jsp:include page="costMissingGrid.jsp"></jsp:include>
        </div>

        <!-- ===== HIDDEN FIELDS ===== -->
        <input type="hidden" id="mode" name="mode"
               value='<s:property value="mode"/>'>
        <input type="hidden" id="msg" name="msg"
               value='<s:property value="msg"/>'>
        <input type="hidden" id="hidtrno" name="hidtrno">
        <input type="hidden" id="hidgridacno" name="hidgridacno">
        <input type="hidden" id="hidcostcode" name="hidcostcode">
        <input type="hidden" id="missingtrno" name="missingtrno"
               value='<s:property value="missingtrno"/>'>
    </td>
</tr>
</table>

</td>

</tr>
</table>

</div>

<!-- ===== POPUP ===== -->
<div id="costCodeDetailsWindow">
    <div></div>
</div>

</div>
</form>
</body>

</html>