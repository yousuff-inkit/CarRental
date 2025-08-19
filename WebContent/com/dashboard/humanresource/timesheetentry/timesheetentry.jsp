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
.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}

.mySaveButton {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #77d42a), color-stop(1, #5cb811));
	background:-moz-linear-gradient(top, #77d42a 5%, #5cb811 100%);
	background:-webkit-linear-gradient(top, #77d42a 5%, #5cb811 100%);
	background:-o-linear-gradient(top, #77d42a 5%, #5cb811 100%);
	background:-ms-linear-gradient(top, #77d42a 5%, #5cb811 100%);
	background:linear-gradient(to bottom, #77d42a 5%, #5cb811 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#77d42a', endColorstr='#5cb811',GradientType=0);
	background-color:#77d42a;
	-moz-border-radius:6px;
	-webkit-border-radius:6px;
	border-radius:6px;
	border:1px solid #268a16;
	display:inline-block;
	cursor:pointer;
	font-family:Verdana;
	font-size:10px;
	font-weight:bold;
	padding:4px 8px;
	text-decoration:none;
	text-shadow:0px -1px 0px #aade7c;
}
.mySaveButton:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #5cb811), color-stop(1, #77d42a));
	background:-moz-linear-gradient(top, #5cb811 5%, #77d42a 100%);
	background:-webkit-linear-gradient(top, #5cb811 5%, #77d42a 100%);
	background:-o-linear-gradient(top, #5cb811 5%, #77d42a 100%);
	background:-ms-linear-gradient(top, #5cb811 5%, #77d42a 100%);
	background:linear-gradient(to bottom, #5cb811 5%, #77d42a 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#5cb811', endColorstr='#77d42a',GradientType=0);
	background-color:#5cb811;
}
.mySaveButton:active {
	position:relative;
	top:1px;
}

.myConfirmButton {
	-moz-box-shadow: 0px 1px 0px 0px #fff6af;
	-webkit-box-shadow: 0px 1px 0px 0px #fff6af;
	box-shadow: 0px 1px 0px 0px #fff6af;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #ffec64), color-stop(1, #ffab23));
	background:-moz-linear-gradient(top, #ffec64 5%, #ffab23 100%);
	background:-webkit-linear-gradient(top, #ffec64 5%, #ffab23 100%);
	background:-o-linear-gradient(top, #ffec64 5%, #ffab23 100%);
	background:-ms-linear-gradient(top, #ffec64 5%, #ffab23 100%);
	background:linear-gradient(to bottom, #ffec64 5%, #ffab23 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffec64', endColorstr='#ffab23',GradientType=0);
	background-color:#ffec64;
	-moz-border-radius:6px;
	-webkit-border-radius:6px;
	border-radius:6px;
	border:1px solid #ffaa22;
	display:inline-block;
	cursor:pointer;
	font-family:Verdana;
	font-size:10px;
	font-weight:bold;
	padding:4px 8px;
	text-decoration:none;
	text-shadow:0px 1px 0px #ffee66;
}
.myConfirmButton:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #ffab23), color-stop(1, #ffec64));
	background:-moz-linear-gradient(top, #ffab23 5%, #ffec64 100%);
	background:-webkit-linear-gradient(top, #ffab23 5%, #ffec64 100%);
	background:-o-linear-gradient(top, #ffab23 5%, #ffec64 100%);
	background:-ms-linear-gradient(top, #ffab23 5%, #ffec64 100%);
	background:linear-gradient(to bottom, #ffab23 5%, #ffec64 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffab23', endColorstr='#ffec64',GradientType=0);
	background-color:#ffab23;
}
.myConfirmButton:active {
	position:relative;
	top:1px;
}

hr.mystylebetween {
	height: 6px;
	background: url(hr-12.png) repeat-x 0 0;
    border: 0;
}

</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $("#branchlabel").hide();$("#branchdiv").hide();
		 $('#btnSubmit').attr('disabled', true);$('#btnCalculate').attr('disabled', true);
		 
		
		 /* Searching Window */
     	 $('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
  		 $('#employeeDetailsWindow').jqxWindow('close');
  		 
  		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#costTypeSearchGridWindow').jqxWindow('close');
 		 
 		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost ID Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
  		 
		 $('#schserchinfowindow').jqxWindow({ width: '90%', height: '60%',  maxHeight: '70%' ,maxWidth: '95%' ,title: 'Time-Sheet Fill' , position: { x: 70, y: 100 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#schserchinfowindow').jqxWindow('close');
			
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 9999; display: none;"></div>');
		 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 9999;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	      
		 

		  
			$("#timeSheetFillFromDate").jqxDateTimeInput({ width : '100px', height : '15px', formatString : "dd.MM.yyyy" });
			$("#timeSheetFillToDate").jqxDateTimeInput({ width : '100px', height : '15px', formatString : "dd.MM.yyyy" }); 
			$("#timeSheetFillNormalHrs").jqxDateTimeInput({ width : '40px', height : '15px', formatString : "HH:mm",showCalendarButton: false });
			$("#timeSheetFillOTHrs").jqxDateTimeInput({ width : '40px', height : '15px', formatString : "HH:mm",showCalendarButton: false });
			$("#timeSheetFillHOTHrs").jqxDateTimeInput({ width : '40px', height : '15px', formatString : "HH:mm",showCalendarButton: false });
			$("#timeSheetFillInTime").jqxDateTimeInput({ width : '40px', height : '15px', formatString : "HH:mm",showCalendarButton: false });
			$("#timeSheetFillOutTime").jqxDateTimeInput({ width : '40px', height : '15px', formatString : "HH:mm",showCalendarButton: false });
			
			var fromdate = $('#timeSheetFillFromDate').jqxDateTimeInput('getDate');
			   var restrictedFromDate=new Date(new Date(fromdate).setMonth(fromdate.getMonth()-1));
	         $("#timeSheetFillFromDate").jqxDateTimeInput('val', restrictedFromDate);
			
			var todate = $('#timeSheetFillToDate').jqxDateTimeInput('getDate');
			   var restrictedToDate=new Date(new Date(todate).setMonth(todate.getMonth()));
            $("#timeSheetFillToDate").jqxDateTimeInput('val', restrictedToDate);

			
			
			
			$('#txtselectedempids').dblclick(function(){
			  	 employeeSearchContent("employeeDetailsMultiSearch.jsp");
		     });
			
			$('#txtselectedcosttypename').dblclick(function(){
				 $('#txtorgridclick').val('3');
				 costTypeSearchContent("costTypeSearchGrid.jsp");
		     });
			 
			 $('#txtselectedcostid').dblclick(function(){
				 if($('#txtselectedcosttypeid').val()==''){
		   			 	$.messager.show({title:'Message',msg:'Cost Type is Mandatory.',showType:'show',style:{left:27,right:'',top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}});
		   			 	return 0;
		   		 }
				 $('#txtorgridclick').val('3');
				 costCodeSearchContent("costCodeSearchGrid.jsp?costtype="+$('#txtselectedcosttypeid').val());
		     });
			 
			 
		});  
		
	 
	
function funNormalHours(){
		
		var intime=$('#timeSheetFillInTime').jqxDateTimeInput('val');
  		var outtime=$('#timeSheetFillOutTime').jqxDateTimeInput('val');
  		
  		if((typeof(intime) != "undefined" && typeof(intime) != "NaN" && intime != "" && intime != "00:00") && typeof(outtime) != "undefined" && typeof(outtime) != "NaN" && outtime != "" && outtime != "00:00"){
  			
		var startDate = new Date($('#timeSheetFillInTime').jqxDateTimeInput('val', 'date'));
		var endDate = new Date($('#timeSheetFillOutTime').jqxDateTimeInput('val', 'date'));
        
        if(Date.parse(endDate) < Date.parse(startDate)){
        	//endDate = new Date(endDate.setDate(endDate.getDate() + 1));
        }
        
        var hours1 = (endDate.getTime() - startDate.getTime()) / (1000 * 60);
        /* var newhours = parseFloat(hours1/60).toFixed(0); this function rounds to nearest integer ,but we need floor
        var newhours1 = ('0' + newhours).slice(-2);
        var newminutes = parseFloat(hours1%60); reason: one hr extra coming 
        var newminutes1 = ('0' + newminutes).slice(-2); */
        
        var newhours = Math.floor(hours1/60);
        var newhours1 = ('0' + newhours).slice(-2);
        var newminutes1 = hours1-(newhours*60);
        var normalHours = new Date("01/01/2017 " + (newhours1+":"+newminutes1+":00"));
        
        $('#timeSheetFillNormalHrs').jqxDateTimeInput('val', normalHours);
        
  		}
	} 
		 
function getFillEmployeeId(event){
    var x= event.keyCode;
    if(x==114){
    	employeeSearchContent("employeeDetailsMultiSearch.jsp");
    }
    else{}
 }

function getFillProjectType(event){
    var x= event.keyCode;
    if(x==114){
    	$('#txtorgridclick').val('3');
		costTypeSearchContent("costTypeSearchGrid.jsp");
    }
    else{}
 }

	function getFillProjectId(event){
    var x= event.keyCode;
    if(x==114){
    	if($('#txtselectedcosttypeid').val()==''){
    		$.messager.show({title:'Message',msg:'Cost Type is Mandatory.',showType:'show',style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}});
			 	return 0;
		     }
    	 $('#txtorgridclick').val('3');
		 costCodeSearchContent("costCodeSearchGrid.jsp?costtype="+$('#txtselectedcosttypeid').val());
    }
    else{}
 }

function daycheck(){
	  
	  var aid=0;

	 if(document.getElementById("mon").checked){
		 aid=aid+0+",";
	  }
	 if(document.getElementById("tue").checked){
		 aid=aid+1+",";	  
	 }
	 if(document.getElementById("wed").checked){
		 aid=aid+2+",";
	 }
	 if(document.getElementById("thu").checked){
		 aid=aid+3+",";
	 }
	 if(document.getElementById("fri").checked){
		 aid=aid+4+",";
	 }
	 if(document.getElementById("sat").checked){
		 aid=aid+5+",";
	 }
	 if(document.getElementById("sun").checked){
		 aid=aid+6+",";
	 }
	 
	 document.getElementById("txtdaysselected").value=aid;
	  
}
	 
function funSetFillGrid(){
	
	var fillfromdate=$("#timeSheetFillFromDate").val();
	var filltodate=$("#timeSheetFillToDate").val();
	var daysselected=$("#txtdaysselected").val();
	var selectedempdocnos=$("#txtselectedempdocnos").val();
	var selectedcosttypename=$("#txtselectedcosttypename").val();
	var selectedcosttypeid=$("#txtselectedcosttypeid").val();
	var selectedcostid=$("#txtselectedcostid").val();
	var selectedcostiddocno=$("#txtselectedcostiddocno").val();
	var fillnormalhrs=$("#timeSheetFillNormalHrs").val();
	var intime=$('#timeSheetFillInTime').jqxDateTimeInput('val');
		var outtime=$('#timeSheetFillOutTime').jqxDateTimeInput('val');
		var fillothrs=$("#timeSheetFillOTHrs").val();
		var fillhothrs=$("#timeSheetFillHOTHrs").val();
		var db=$("#db").val();
		var empdb=$("#txtselectedempdbs").val();
	//	alert(db+","+empdb+","+costtypedb);

		
			var startDate = new Date($('#timeSheetFillInTime').jqxDateTimeInput('val', 'date'));
			var endDate = new Date($('#timeSheetFillOutTime').jqxDateTimeInput('val', 'date'));
        if(Date.parse(endDate) < Date.parse(startDate)){
        	$.messager.alert('Out time should be greater than in time','warning');
			return 0;
        }
			if(daysselected=="")
				{
				$.messager.alert('Message','Select Days.','warning');
   			 	return 0;
				}
			
			if(selectedcosttypeid=="")
			{
			$.messager.alert('Message','Select Cost Type.','warning');
			 	return 0;
			}
			if(selectedcostiddocno=="")
			{
			$.messager.alert('Message','Select Cost Id.','warning');
			 	return 0;
			}
			if(selectedempdocnos=="")
			{
			$.messager.alert('Message','Select an Employee','warning');
			 	return 0;
			}
			if(intime=='00:00')
			{
			$.messager.alert('Message','Select InTime.','warning');
			 	return 0;
			}
			if(outtime=='00:00')
			{
			$.messager.alert('Message','Select OutTime.','warning');
			 	return 0;
			}
			
			
		
		
	$("#overlay, #PleaseWait").show();
$("#timeSheetDetailsDiv").load("timeSheetFillSearchGrid.jsp?fillfromdate="+fillfromdate+"&filltodate="+filltodate+"&daysselected="+daysselected+"&selectedempdocnos="+selectedempdocnos+"&selectedcosttypename="+selectedcosttypename.replace(/ /g, "%20")+"&selectedcosttypeid="+selectedcosttypeid+"&selectedcostid="+selectedcostid.replace(/ /g, "%20")+"&selectedcostiddocno="+selectedcostiddocno+"&fillintime="+intime+"&fillouttime="+outtime+"&fillnormalhrs="+fillnormalhrs+"&fillothrs="+fillothrs+"&fillhothrs="+fillhothrs+"&db="+db+"&empdb="+empdb+"&gridload=1");

}

function setValues(){
	
	document.getElementById("cmbmonth").value=document.getElementById("hidcmbmonth").value;
  
	  if($('#msg').val()!=""){
		 $.messager.alert('Message',$('#msg').val());
		 $('#gridlength').val('');
		  funreload(event);

	 }
}
		 
function funreload(event)
{	
	

	var fillfromdate=$("#timeSheetFillFromDate").val();
	var filltodate=$("#timeSheetFillToDate").val();
	var daysselected=$("#txtdaysselected").val();
	var selectedempdocnos=$("#txtselectedempdocnos").val();
	var selectedcosttypename=$("#txtselectedcosttypename").val();
	var selectedcosttypeid=$("#txtselectedcosttypeid").val();
	var selectedcostid=$("#txtselectedcostid").val();
	var selectedcostiddocno=$("#txtselectedcostiddocno").val();
	var fillnormalhrs=$("#timeSheetFillNormalHrs").val();
	var intime=$('#timeSheetFillInTime').jqxDateTimeInput('val');
		var outtime=$('#timeSheetFillOutTime').jqxDateTimeInput('val');
		var fillothrs=$("#timeSheetFillOTHrs").val();
		var fillhothrs=$("#timeSheetFillHOTHrs").val();
	
		
//$("#timeSheetDetailsDiv").load("timeSheetFillSearchGrid.jsp?fillfromdate="+fillfromdate+"&filltodate="+filltodate+"&daysselected="+daysselected+"&selectedempdocnos="+selectedempdocnos+"&selectedcosttypename="+selectedcosttypename.replace(/ /g, "%20")+"&selectedcosttypeid="+selectedcosttypeid+"&selectedcostid="+selectedcostid.replace(/ /g, "%20")+"&selectedcostiddocno="+selectedcostiddocno+"&fillintime="+intime+"&fillouttime="+outtime+"&fillnormalhrs="+fillnormalhrs+"&fillothrs="+fillothrs+"&fillhothrs="+fillhothrs+"&gridload=1");

}

	function employeeSearchContent(url) {
	 	$('#employeeDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#employeeDetailsWindow').jqxWindow('setContent', data);
		$('#employeeDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function costTypeSearchContent(url) {
	    $('#costTypeSearchGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costTypeSearchGridWindow').jqxWindow('setContent', data);
		$('#costTypeSearchGridWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function costCodeSearchContent(url) {
	    $('#costCodeSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costCodeSearchWindow').jqxWindow('setContent', data);
		$('#costCodeSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function schSearchContent(url) {
	    $('#schserchinfowindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#schserchinfowindow').jqxWindow('setContent', data);
		$('#schserchinfowindow').jqxWindow('bringToFront');
	}); 
	}

	

	function  funClearInfo(){
		$('#cmbbranch').val('a');$('#cmbyear').val('');$('#cmbmonth').val('');
		
		$('#txtselectedcosttypename').val('');
		$('#txtselectedcostid').val('');
		$('#txtselectedcosttypeid').val('');
		$('#txtselectedcostiddocno').val('');
		$('#txtselectedempids').val('');
		$('#txtselectedempdocnos').val('');
		$('#hidchcknormal').val('');
		$('#timeSheetFillOutTime').val('00:00');
		$('#timeSheetFillInTime').val('00:00');
		document.getElementById("mon").checked=false;
		document.getElementById("tue").checked=false;
		document.getElementById("wed").checked=false;
		document.getElementById("thu").checked=false;
		document.getElementById("fri").checked=false;
		document.getElementById("sat").checked=false;
		document.getElementById("sun").checked=false;

	    $("#timeSheetFillSearchGridId").jqxGrid('clear');$("#timeSheetFillSearchGridId").jqxGrid('addrow', null, {});
	   
	        $('#txtselectedcosttypename').attr('placeholder', 'Press F3 to Search'); 	    
	        $('#txtselectedcostid').attr('placeholder', 'Press F3 to Search');  
	        $('#txtselectedempids').attr('placeholder', 'Press F3 to Search'); 
		
	 }
	
	
	
	
	function funNotify(){	
		
		
		
		  
		  
		   $.messager.confirm('Confirm', 'Do you want to save changes?', function(r){
	 		if (r){
	 				
	 			/* Time Sheet Grid  Saving*/
			 	var rows = $("#timeSheetFillSearchGridId").jqxGrid('getrows');
			 	var length=0;
					 for(var i=0 ; i < rows.length ; i++){	
											newTextBox = $(document.createElement("input"))
										    .attr("type", "dil")
										    .attr("id", "test"+length)
										    .attr("name", "test"+length)
											.attr("hidden", "true");
											length=length+1;
								       		newTextBox.val(rows[i].empdocno+"::"+$('#timeSheetFillSearchGridId').jqxGrid('getcelltext', i, "date")+":: "+rows[i].costtype+":: "+rows[i].costcode+":: "+$('#timeSheetFillSearchGridId').jqxGrid('getcelltext', i, "hrs")+":: "+$('#timeSheetFillSearchGridId').jqxGrid('getcelltext', i, "othrs")+":: "+$('#timeSheetFillSearchGridId').jqxGrid('getcelltext', i, "hothrs")+":: "+$('#timeSheetFillSearchGridId').jqxGrid('getcelltext', i, "intime")+":: "+$('#timeSheetFillSearchGridId').jqxGrid('getcelltext', i, "outtime")+":: "+rows[i].costperhour+":: "+rows[i].costdb+":: "+rows[i].dbemp);
								       		newTextBox.appendTo('form');
								       }
	 		 	$('#gridlength').val(length);
			 	/* Time Sheet Grid  Saving Ends*/
	 		
			 document.getElementById("mode").value='A';
			 $("#overlay, #PleaseWait").show();
			 document.getElementById("frmTimeSheetEntry").submit();
			 
	 		 }
	 		});
		 
		return 1;
	}
	
	
	function funExportBtn(){

		$("#timeSheetDetailsDiv").excelexportjs({
			containerid: "timeSheetDetailsDiv", 
			datatype: 'json', 
			dataset: null, 
			gridId: "timeSheetFillSearchGridId", 
			columns: getColumns("timeSheetFillSearchGridId") , 
			worksheetName:"Time Sheet Entry" 
			});
	
	} 
	
</script>
</head>
<body onload="getBranch();setValues();">
<form id="frmTimeSheetEntry" action="saveTimeSheetEntry" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="23%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
	 <tr hidden="true"><td align="right"><label class="branch">Year</label></td>
     <td align="left"><select id="cmbyear" name="cmbyear" onchange="funChangeDate();" style="width:80%;" value='<s:property value="cmbyear"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbyear" name="hidcmbyear" value='<s:property value="hidcmbyear"/>'/></td></tr>
	<tr hidden="true"><td align="right"><label class="branch">Month</label></td>
     <td align="left"><select id="cmbmonth" name="cmbmonth" style="width:80%;" onchange="funChangeDate();" value='<s:property value="cmbmonth"/>'>
      <option value="">--Select--</option><option value="01">January</option><option value="02">February</option><option value="03">March</option>
      <option value="04">April</option><option value="05">May</option><option value="06">June</option><option value="07">July</option>
      <option value="08">August</option><option value="09">September</option><option value="10">October</option><option value="11">November</option>
      <option value="12">December</option></select>
      <input type="hidden" id="hidcmbmonth" name="hidcmbmonth" value='<s:property value="hidcmbmonth"/>'/></td></tr>
	 
	<tr>
    <td  align="left" style="font-size:9px;">From</td>
    <td width="80%" align="left"><div id="timeSheetFillFromDate" name="timeSheetFillFromDate"   value='<s:property value="timeSheetFillFromDate" />'></div></td>
   </tr><tr>
     <td align="left" style="font-size:9px;">To</td>
    <td width="80%"><div id="timeSheetFillToDate" name="timeSheetFillToDate" style="width:100%;height: 20px;"  value='<s:property value="timeSheetFillToDate" />'></div></td>
 
   </tr>
   
   <tr>
    <td  rowspan="2" colspan="2" align="center">
    <fieldset><legend style="font-size:9px;">Day</legend>
    <table width="100%" >
      <tr>
        <td align="center" style="font-size:9px;"><input type="checkbox" id="mon" name="mon"  value="0"  onclick="$(this).attr('value', this.checked ? 0 : 0);daycheck();">Mon</td>
        <td align="center" style="font-size:9px;"><input type="checkbox" id="wed" name="wed"   value="0" onclick="$(this).attr('value', this.checked ? 2 : 0);daycheck();">Wed</td>
        <td align="center" style="font-size:9px;"><input type="checkbox" id="fri" name="fri"   value="0" onclick="$(this).attr('value', this.checked ? 4 : 0);daycheck();">Fri</td>
         <td align="center" style="font-size:9px;"><input type="checkbox" id="sun" name="sun"  value="0" onclick="$(this).attr('value', this.checked ? 6 : 0);daycheck();">Sun</td>
      </tr>
      <tr>
      <td align="center" style="font-size:9px;"><input type="checkbox" id="tue" name="tue"    value="0" onclick="$(this).attr('value', this.checked ? 1 : 0);daycheck();">Tue</td>
      <td align="center" style="font-size:9px;"><input type="checkbox" id="thu" name="thu"   value="0" onclick="$(this).attr('value', this.checked ? 3 : 0);daycheck();">Thu</td>
        
        <td align="center" style="font-size:9px;"><input type="checkbox" id="sat" name="sat"   value="0" onclick="$(this).attr('value', this.checked ? 5 : 0);daycheck();">Sat</td>
        <td>&nbsp;</td>
      </tr>
      </table>
    </fieldset>
     </td>
   </tr>
   <tr>
    <tr>
     <td width="4%" align="left" style="font-size:9px;">Costtype</td>
    
    <td width="60%"><input type="text" name="txtselectedcosttypename" id="txtselectedcosttypename" placeholder="Press F3 to Search" style="width:100%;height: 20px;" readonly onkeydown="getFillProjectType(event);" value='<s:property value="txtselectedcosttypename"/>'>
    </td> </tr>
    
    <tr>
    <td width="3%" align="left" style="font-size:9px;">CostId</td>
    <td width="40%"><input type="text" name="txtselectedcostid" id="txtselectedcostid" placeholder="Press F3 to Search" style="width:100%;height: 20px;" readonly onkeydown="getFillProjectId(event);" value='<s:property value="txtselectedcostid"/>'>
       <input type="hidden" name="txtselectedcosttypeid" id="txtselectedcosttypeid" style="width:100%;height: 20px;" readonly value='<s:property value="txtselectedcosttypeid"/>'>
      <input type="hidden" name="txtselectedcostiddocno" id="txtselectedcostiddocno" style="width:100%;height: 20px;" readonly value='<s:property value="txtselectedcostiddocno"/>'>
    <input type="hidden" id="txtdaysselected" name="txtdaysselected" style="width:100%;height: 20px;" readonly value='<s:property value="txtdaysselected"/>'/></td>
    </tr>
     <tr>
     <td align="left" style="font-size:9px;">Employee</td>
    <td><input type="text" name="txtselectedempids" id="txtselectedempids" placeholder="Press F3 to Search" style="width:100%;height: 20px;" readonly  onkeydown="getFillEmployeeId(event);" value='<s:property value="txtselectedempids"/>'>
    <input type="hidden" name="txtselectedempdocnos" id="txtselectedempdocnos" style="width:100%;height: 20px;" readonly value='<s:property value="txtselectedempdocnos"/>'></td>
    </tr>
    <tr hidden="true"><td width="6%" align="left" style="font-size:9px;"><input type="checkbox" id="chcknormal" name="chcknormal" value=""  onclick="$(this).attr('value', this.checked ? 1 : 0)" />Normal
    <input type="hidden" id="hidchcknormal" name="hidchcknormal" style="width:100%;height: 20px;" value='<s:property value="hidchcknormal"/>'/>
    </td>
    <td width="9%"><div id="timeSheetFillNormalHrs" name="timeSheetFillNormalHrs" value='<s:property value="timeSheetFillNormalHrs" />'></div></td> 
     </tr>
    
    <tr><td align="left" style="font-size:9px;">In</td>
    <td width="2%"><div id="timeSheetFillInTime" name="timeSheetFillInTime" style="width:10%;" onchange="funNormalHours();" value='<s:property value="timeSheetFillInTime" />'></div></td>
    </tr><tr><td width="2%" align="left" style="font-size:9px;">Out</td>
    <td width="2%"><div id="timeSheetFillOutTime" name="timeSheetFillOutTime"  style="width:10%;" onchange="funNormalHours();" value='<s:property value="timeSheetFillOutTime" />'></div></td>
    </tr>
    <tr hidden="true">
      <td width="2%" align="right" style="font-size:9px;">OT</td>
    <td width="7%"><div id="timeSheetFillOTHrs" name="timeSheetFillOTHrs" value='<s:property value="timeSheetFillOTHrs" />'></div></td>
    <td align="right" style="font-size:9px;">Holiday OT</td>
    <td><div id="timeSheetFillHOTHrs" name="timeSheetFillHOTHrs" value='<s:property value="timeSheetFillHOTHrs" />'></div></td>
  
    </tr>
     
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();">&nbsp;&nbsp;&nbsp;&nbsp;
	 <button class="myButton" type="button" id="btnAdd" name="btnAdd" onclick="funSetFillGrid();">Fill</button>&nbsp;&nbsp;&nbsp;&nbsp;
	 <input type="button" class="mySaveButton" id="btnSaveSalaryPayment" name="btnSaveSalaryPayment" value="Save" onclick="funNotify();"></td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
     <tr><td colspan="2">&nbsp;<input type="hidden" id="gridlength" name="gridlength" style="width:100%;height:20px;" value='<s:property value="gridlength"/>'/>
     <input type="hidden" name="mode" id="mode" style="width:100%;height:20px;" value='<s:property value="mode"/>'>
     <input type="hidden" name="msg" id="msg" style="width:100%;height:20px;" value='<s:property value="msg"/>'>
     <input type="hidden" name="txtorgridclick" id="txtorgridclick" style="width:100%;height:20px;" value='<s:property value="txtorgridclick"/>'>
     <input type="hidden" name="txtfillbtnclick" id="txtfillbtnclick" style="width:100%;height:20px;" value='<s:property value="txtfillbtnclick"/>'>
	      <input type="hidden" name="db" id="db" style="width:100%;height:20px;" value='<s:property value="db"/>'>
	 	  <input type="hidden" name="empdb" id="empdb" style="width:100%;height:20px;" value='<s:property value="empdb"/>'>
	 	  <input type="hidden" name="txtselectedempdbs" id="txtselectedempdbs" style="width:100%;height:20px;" value='<s:property value="txtselectedempdbs"/>'>
	
	 </td></tr>
	 </table>
	 </fieldset>
</td>
<td width="100%">
	<table width="100%">
		<tr><td><div id="timeSheetDetailsDiv"><jsp:include page="timeSheetFillSearchGrid.jsp"></jsp:include></div></td></tr>
	</table>
</td></tr></table>

</div>

<div id="employeeDetailsWindow">
   <div></div>
</div>
<div id="costTypeSearchGridWindow">
	<div></div>
</div> 
<div id="costCodeSearchWindow">
	<div></div>
</div> 
<div id="schserchinfowindow">
   <div></div>
</div>
</div> 
</form>
</body>
