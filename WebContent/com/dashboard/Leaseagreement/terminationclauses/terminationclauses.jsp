
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
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
	
 
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	  $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");



	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	 $('#todate').on('change', function (event) {
			
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }   
	 });
	  
});

  function funExportBtn(){
	  
	   
	   
		 if(parseInt(window.parent.chkexportdata.value)=="1")
		 {
		 JSONToCSVCon(dat1, 'Termination Clauses', true);
		 }
	 else
		 {
		 $("#leasetermination").jqxGrid('exportdata', 'xls', 'Termination Clauses');
		 }
		
	   
	   
	   
	 }  

	 function change1()
	 { 
	 	
	 	
	    if(document.getElementById("m2").value!="")
	 	   {
	 	document.getElementById("m3").value=parseInt(document.getElementById("m2").value)+1;
	 	   }
	    else
	 	   {
	 	   document.getElementById("m3").value="";
	 	   }
	 }
	 function change2()
	 {
	 	
	 	 if(document.getElementById("m4").value!="")
	 	   {
	 	document.getElementById("m5").value=parseInt(document.getElementById("m4").value)+1;
	 	   }
	 	 else
	 	   {
	 	   document.getElementById("m5").value="";
	 	   }
	 }
	 function change3()
	 {
	 	
	 	 if(document.getElementById("m6").value!="")
	 	   {
	 	
	 	document.getElementById("m7").value=parseInt(document.getElementById("m6").value)+1;
	 	   }
	 	 
	 	 else
	 		 {
	 		 
	 		 document.getElementById("m7").value="";
	 		 }
	 }
	 function change4()
	 {
	 	 if(document.getElementById("m8").value!="")
	 	   {
	 	document.getElementById("m9").value=parseInt(document.getElementById("m8").value)+1;
	 	   }
	 	 else
	 		 {
	 		 
	 		 document.getElementById("m9").value="";
	 		 
	 		 }
	 }
function funreload(event)
{

	  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
	  // out date
	 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	 	 
	   if(fromdates>todates){
		   
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		 
	   return false;
	  } 
	   else
		   {
	 var barchval = document.getElementById("cmbbranch").value;
     var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val();
	
	   $("#overlay, #PleaseWait").show();
	  $("#listdiv").load("terminationlistGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate);
	
		   }
	}
	 function isNumber(evt) {
		    var iKeyCode = (evt.which) ? evt.which : evt.keyCode;
		    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
		     {
		    	  
				   $.messager.alert('Message','Enter Numbers Only ','warning');     	
		   

		        return false;
		     }
		 

		    return true;
		}
	 
	 
	 
 
	 
	 
	 
	 
	 
	 function funupdate()
	 {
	 	
			if(document.getElementById("amt1").value=="")
				{
				 $.messager.alert('Message','Minimum Data Requirement','warning');     	
				   

			        return false;
			
				}
  
	 		
	 	var m1=document.getElementById("m1").value;	
	 	var m2=document.getElementById("m2").value;
		var amt1=document.getElementById("amt1").value;
	 	
	 	
	 	var m3=document.getElementById("m3").value;	
	 	var m4=document.getElementById("m4").value;
	 	var amt2=document.getElementById("amt2").value;
	 	
	 	var m5=document.getElementById("m5").value;	
	 	var m6=document.getElementById("m6").value;
	 	var amt3=document.getElementById("amt3").value;
	 	
	 	var m7=document.getElementById("m7").value;	
	 	var m8=document.getElementById("m8").value;
	 	var amt4=document.getElementById("amt4").value;
	 	
	 	var m9=document.getElementById("m9").value;	
	 	var m10=document.getElementById("m10").value;
	 	var amt5=document.getElementById("amt5").value;
	 	
 
	     $.messager.confirm('Message', 'Do you want to save changes?', function(r){
	    	  
	 	       
	      	if(r==false)
	      	  {
	      		return false; 
	      	  }
	      	else{
	      		
	      //	list.push(m1+"::"+m2+"::"+amt1+"::"+","+m3+"::"+m4+"::"+amt2+"::"+","+m5+"::"+m6+"::"+amt3+"::"+","+m7+"::"+m8+"::"+amt4+"::"+","+m9+"::"+m10+"::"+amt5);
	      		
	      		delsave(m1,m2,amt1,m3,m4,amt2,m5,m6,amt3,m7,m8,amt4,m9,m10,amt5);
	      	}
	 	     });
	 	
	 	
	 }
	 	function delsave(m1,m2,amt1,m3,m4,amt2,m5,m6,amt3,m7,m8,amt4,m9,m10,amt5)
	          {
	 		
	 		var x=new XMLHttpRequest();
	 		x.onreadystatechange=function(){
	 		if (x.readyState==4 && x.status==200)
	 			{
	 		
	 			 	var items= x.responseText;
	 			
	 			 	 document.getElementById("m1").value="";	
	 			 	 document.getElementById("m2").value="";
	 			 	 document.getElementById("amt1").value="";
	 			 	
	 			 	
	 			 	document.getElementById("m3").value="";	
	 			 	document.getElementById("m4").value="";
	 			 	document.getElementById("amt2").value="";
	 			 	
	 			 	document.getElementById("m5").value="";	
	 			 	document.getElementById("m6").value="";
	 			 	document.getElementById("amt3").value="";
	 			 	
	 			 	document.getElementById("m7").value="";	
	 			 	document.getElementById("m8").value="";
	 			 	document.getElementById("amt4").value="";
	 			 	
	 			 	document.getElementById("m9").value="";	
	 			 	document.getElementById("m10").value="";
	 			 	document.getElementById("amt5").value="";
	 			 	
	 			 	
	 			 	document.getElementById("ladocno").value="";
	 			 	document.getElementById("lano").value="";
	 			 	
	 			 	// lano
	 			 	
	 				disitems();
	 			 	funreload(event);
	 			 	$.messager.alert('Message', '  Record Successfully Updated ', function(r){
	 					     
	 				     });
	 	    }
	 		}
	 		  x.open("GET","saveterminationdate.jsp?m1="+m1+"&m2="+m2+"&amt1="+amt1+"&m3="+m3+"&m4="+m4+"&amt2="+amt2+"&m5="+m5+"&m6="+m6+
	 				 "&amt3="+amt3+"&m7="+m7+"&m8="+m8+"&amt4="+amt4+"&m9="+m9+"&m10="+m10+"&amt5="+amt5+"&doc="+document.getElementById("ladocno").value,true);
	 	     x.send();
	 		
	 		}
	 
	 
	 function disitems()
	 {
		 
		 // ladocno lano
		  $('#lano').attr("readonly",true);
		 	
			 $('#m1').attr("readonly",true);
			 $('#m2').attr("readonly",true);
			 $('#amt1').attr("readonly",true);	
		 	
			 $('#m3').attr("readonly",true);
			 $('#m4').attr("readonly",true);
			 $('#amt2').attr("readonly",true);	
			 
			 $('#m5').attr("readonly",true);
			 $('#m6').attr("readonly",true);
			 $('#amt3').attr("readonly",true);	
			 
			 $('#m7').attr("readonly",true);
			 $('#m8').attr("readonly",true);
			 $('#amt4').attr("readonly",true);	
			 
			 $('#m9').attr("readonly",true);
			 $('#m10').attr("readonly",true);
			 $('#amt5').attr("readonly",true);	
			 
			 
			 
			 
			 $('#terUpdate').attr("disabled",true);	
		 	
		 	
		 	
		 	
		 	
		 	
		 
	 }
	 
</script>

<style>
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
.myButtons, .myButton {
    background-color: #2563eb !important;
    color: #ffffff !important;
    border: none !important;
    border-radius: 6px;
    cursor: pointer;
    font-size: 13px;
    font-weight: 600;
    padding: 10px 15px;
    width: 100%;
}

.myButtons:hover, .myButton:hover {
    background-color: #1d4ed8 !important;
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

/* 🔹 Button row (side-by-side) */
.button-row {
    display: flex;
    gap: 6px;
}

/* 🔹 Override full width */
.button-row .myButton {
    width: 50% !important;
    margin: 0 !important;
}
/* 🔹 Inputs smaller width */
.input-cell input {
    width: 160px;   /* adjust: 140px / 160px / 180px */
    height: 24px;
    padding: 0 8px;
    border: 1px solid #ccd6e0;
    border-radius: 4px;
    font-size: 13px;
    box-sizing: border-box;
}

.input-cell select {
    width: 160px;   /* same as your input fields */
    height: 24px;
    padding: 0 6px;
    border: 1px solid #ccd6e0;
    border-radius: 4px;
    font-size: 13px;
    box-sizing: border-box;
}

/* 🔹 inline card (does NOT break layout) */
.inline-card {
    display: inline-block;
    width: 250px; /* 🔥 increased card width */
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 10px;
    padding: 12px 15px;
    margin: 10px 0;
}

/* 🔹 table spacing */
.form-table {
    border-spacing: 0 8px;
}

/* 🔹 labels */
.form-table td:first-child {
    text-align: right;
    padding-right: 10px;
    font-size: 13px;
    font-weight: 600;
    color: #4e5e71;
    width: 90px; /* 🔥 slightly increased for better spacing */
}

/* 🔹 inputs */
.form-table input,
.form-table select {
    width: 100px; /* 🔥 increased field width */
    height: 24px;
    padding: 0 6px;
    border: 1px solid #ccd6e0;
    border-radius: 4px;
    font-size: 13px;
}

/* 🔹 radio row layout */
.radio-row {
    text-align: center;
    padding-top: 6px;
}

/* 🔹 spacing between options */
.radio-row label {
    margin: 0 12px;
    font-size: 13px;
    color: #4e5e71;
    cursor: pointer;
}

/* 🔹 align radio + text nicely */
.radio-row input[type="radio"] {
    margin-right: 4px;
    vertical-align: middle;
}
/* 🔹 label */
.label-cell {
    text-align: right;
    padding-right: 12px;
    font-size: 13px;
    font-weight: 600;
    color: #4e5e71;
    width: 90px;
    vertical-align: middle;
}

/* 🔹 input cell */
.input-cell {
    text-align: left;
}

/* 🔹 fields */
.input-cell input,
.input-cell select {
    width: 180px;
    height: 24px;
    padding: 0 6px;
    border: 1px solid #ccd6e0;
    border-radius: 4px;
    font-size: 13px;
    box-sizing: border-box;
}

/* 🔹 main button style */
.myButtons {
    background-color: #2563eb !important;  /* blue */
    color: #ffffff !important;
    border: none !important;
    border-radius: 4px;
    height: 24px;
    padding: 0 12px;
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
}

/* 🔹 hover */
.myButtons:hover {
    background-color: #1d4ed8 !important;
}/* 🔹 force button style */
input.myButtons {
    background-color: #2563eb !important;
    color: #ffffff !important;
    border: none !important;
    border-radius: 4px !important;
    height: 24px !important;
    padding: 0 12px !important;
    font-size: 13px !important;
    font-weight: 600 !important;
    cursor: pointer !important;
    appearance: none;           /* 🔥 removes browser default grey */
    -webkit-appearance: none;
}

/* 🔹 hover */
input.myButtons:hover {
    background-color: #1d4ed8 !important;
}

/* 🔥 strongest override */
input[type="button"].myButtons,
#clear.myButtons {
    background: #2563eb !important;
    color: #fff !important;
    border: none !important;
    border-radius: 4px !important;
    height: 24px !important;
    padding: 0 12px !important;
    font-size: 13px !important;
    font-weight: 600 !important;
    cursor: pointer !important;
}

/* hover */
input[type="button"].myButtons:hover,
#clear.myButtons:hover {
    background: #1d4ed8 !important;
}

/* 🔹 center button cleanly */
.button-cell {
    text-align: center;
    padding-top: 8px;
}

/* 🔹 fix button width (not full width) */
.button-cell .myButtons {
    width: 120px !important;
    height: 24px !important;
    padding: 0 10px !important;
    background-color: #2563eb !important;
    color: #fff !important;
    border: none !important;
    border-radius: 4px;
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
}

/* 🔹 hover */
.button-cell .myButtons:hover {
    background-color: #1d4ed8 !important;
}

/* 🔹 reduce legend (title) font */
fieldset legend {
    font-size: 16px;   /* 🔻 reduced */
    font-weight: 600;
    color: #4e5e71;
}

/* 🔹 optional: reduce inside text slightly */
fieldset {
    font-size: 12px;
}

/* 🔹 card */
.simple-card {
    display: inline-block;
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 10px;
    padding: 12px 15px;
    margin: 10px 0;
}

/* 🔹 spacing */
.form-table {
    border-spacing: 0 8px;
}

/* 🔹 labels */
.label-cell {
    text-align: right;
    padding-right: 12px;
    font-size: 13px;
    font-weight: 600;
    color: #4e5e71;
    width: 90px;
}

/* 🔹 inputs */
.input-cell input,
.input-cell select {
    width: 150px;
    height: 24px;
    padding: 0 6px;
    border: 1px solid #ccd6e0;
    border-radius: 4px;
    font-size: 13px;
}

/* 🔹 button */
.button-cell {
    text-align: center;
    padding-top: 8px;
}


</style>
</head>
<body onload="getBranch();disitems()">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #FFFFFF;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	  <tr>
<td colspan="2" align="center">

    <div class="simple-card">

        <table class="form-table">

            <tr>
                <td class="label-cell">From</td>
                <td class="input-cell">
                    <div id="fromdate"></div>
                </td>
            </tr>

            <tr>
                <td class="label-cell">To</td>
                <td class="input-cell">
                    <div id="todate"></div>
                </td>
            </tr>

        </table>

    </div>

</td>
</tr>
<%-- 	 <table width="100%">
	 <tr>
	<td  align="right"><label class="branch" >From Date</label></td><td><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div></td>
           
	</tr> 
	
	 <tr>
	<td align="right"><label class="branch">To Date</label></td><td><div id='todate' name='todate' value='<s:property value="todate"/>'></div></td>
    </tr>
     </table>
	</td> --%>      
	
	  <tr><td colspan="2">
         
          <tr>
<td colspan="2" align="center">

    <!-- 🔹 CARD WRAPPER -->
    <div style="
        background:#f8fafc;
        border:1px solid #e3e8ee;
        border-radius:12px;
        padding:18px 20px;
        width:320px;
        box-shadow:0 2px 6px rgba(0,0,0,0.05);
    ">

        <!-- 🔹 LA NO -->
        <table style="width:100%; margin-bottom:12px;">
            <tr>
                <td style="text-align:right; padding-right:10px; width:90px;">
                    <label class="branch">LA NO</label>
                </td>
                <td>
                    <input type="text" id="lano" name="lano"
                           value='<s:property value="lano"/>'
                           style="width:160px;height:24px;">
                </td>
            </tr>
        </table>

        <!-- 🔹 RANGE TABLE -->
        <table style="width:100%; border-spacing:0 10px;">

            <!-- ROW 1 -->
            <tr>
                <td>
                    <input type="text" name="m1" id="m1"
                           value='<s:property value="m1"/>'
                           onkeypress="return isNumber(event)"
                           style="width:55px;height:24px;text-align:center;">

                    <span style="margin:0 6px;">to</span>

                    <input type="text" name="m2" id="m2"
                           value='<s:property value="m2"/>'
                           onkeypress="return isNumber(event)"
                           onblur="change1();"
                           style="width:55px;height:24px;text-align:center;">
                </td>

                <td>
                    <input type="text" id="amt1" name="amt1"
                           value='<s:property value="amt1"/>'
                           onblur="funRoundAmt(this.value,this.id);"
                           onkeypress="return isNumber(event)"
                           style="width:120px;height:24px;text-align:right;">
                </td>
            </tr>

            <!-- ROW 2 -->
            <tr>
                <td>
                    <input type="text" name="m3" id="m3"
                           value='<s:property value="m3"/>'
                           readonly
                           style="width:55px;height:24px;text-align:center;">

                    <span style="margin:0 6px;">to</span>

                    <input type="text" name="m4" id="m4"
                           value='<s:property value="m4"/>'
                           onblur="change2();"
                           style="width:55px;height:24px;text-align:center;">
                </td>

                <td>
                    <input type="text" id="amt2" name="amt2"
                           value='<s:property value="amt2"/>'
                           style="width:120px;height:24px;text-align:right;">
                </td>
            </tr>

            <!-- ROW 3 -->
            <tr>
                <td>
                    <input type="text" name="m5" id="m5"
                           value='<s:property value="m5"/>'
                           readonly
                           style="width:55px;height:24px;text-align:center;">

                    <span style="margin:0 6px;">to</span>

                    <input type="text" name="m6" id="m6"
                           value='<s:property value="m6"/>'
                           onblur="change3();"
                           style="width:55px;height:24px;text-align:center;">
                </td>

                <td>
                    <input type="text" id="amt3" name="amt3"
                           value='<s:property value="amt3"/>'
                           style="width:120px;height:24px;text-align:right;">
                </td>
            </tr>

            <!-- ROW 4 -->
            <tr>
                <td>
                    <input type="text" name="m7" id="m7"
                           value='<s:property value="m7"/>'
                           readonly
                           style="width:55px;height:24px;text-align:center;">

                    <span style="margin:0 6px;">to</span>

                    <input type="text" name="m8" id="m8"
                           value='<s:property value="m8"/>'
                           onblur="change4();"
                           style="width:55px;height:24px;text-align:center;">
                </td>

                <td>
                    <input type="text" id="amt4" name="amt4"
                           value='<s:property value="amt4"/>'
                           style="width:120px;height:24px;text-align:right;">
                </td>
            </tr>

            <!-- ROW 5 -->
            <tr>
                <td>
                    <input type="text" name="m9" id="m9"
                           value='<s:property value="m9"/>'
                           readonly
                           style="width:55px;height:24px;text-align:center;">

                    <span style="margin:0 6px;">to</span>

                    <input type="text" name="m10" id="m10"
                           value='<s:property value="m10"/>'
                           style="width:55px;height:24px;text-align:center;">
                </td>

                <td>
                    <input type="text" id="amt5" name="amt5"
                           value='<s:property value="amt5"/>'
                           style="width:120px;height:24px;text-align:right;">
                </td>
            </tr>

        </table>

        <!-- 🔹 BUTTON -->
        <div style="text-align:center; margin-top:15px;">
            <input type="button"
                   class="myButtons"
                   value="Update"
                   onclick="funupdate()"
                   style="width:140px;">
        </div>

    </div>

</td>
</tr>

 

	
</td></tr> 
 	 <tr><td colspan="2">&nbsp;</td></tr> 
	 	 <tr><td colspan="2">&nbsp;</td></tr> 
	 	 	 	 	 <tr><td colspan="2">&nbsp;</td></tr> 
	 	 	 <tr><td colspan="2">&nbsp;</td></tr> 
	</table>
	</fieldset>
	<input type="hidden" id="ladocno" style="height:20px;width:70%;"  name="ladocno">
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="listdiv"><jsp:include page="terminationlistGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>

</div>
<div id="clinfowindow">
   <div ></div>
</div> 
</div>
</body>
</html>