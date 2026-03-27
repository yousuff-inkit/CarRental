<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- <link href="../../../../css/main.css" rel="stylesheet" type="text/css" />
<link href="../../../../css/body.css" media="screen" rel="stylesheet" type="text/css" />
 -->
 <jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript">

$(document).ready(function () {     
  $("#tsDate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"}); 
  $('#tafficfleetsearchwindow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Fleet Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
  $('#tafficfleetsearchwindow').jqxWindow('close');
  $('#salickfleetsearchwindow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Fleet Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
  $('#salickfleetsearchwindow').jqxWindow('close');	
      		 });
		 
function salickinfoSearchContent(url) {
 	 //alert(url);
 		 $.get(url).done(function (data) {
 			 
 			 $('#salickfleetsearchwindow').jqxWindow('open');
 		$('#salickfleetsearchwindow').jqxWindow('setContent', data);
 
 	}); 
 	} 
     function trafficinfoSearchContent(url) {
      	 //alert(url);
      		 $.get(url).done(function (data) {
      			 
      			 $('#tafficfleetsearchwindow').jqxWindow('open');
      		$('#tafficfleetsearchwindow').jqxWindow('setContent', data);
      
      	}); 
      	} 

function funFocus(){
	document.getElementById("tsDate").focus();
}
function funReset() {
	
}
function funReadOnly() {
	$('#frmsalic input').attr('readonly', true);
	$('#frmsalic select').attr('disabled', true);
	$('#tsDate').jqxDateTimeInput({ disabled: true});
    $("#salikgrid").jqxGrid({ disabled: true});
    $("#traficgrid").jqxGrid({ disabled: true});
	/* 	$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
}
function funRemoveReadOnly() {
	$('#frmsalic input').attr('readonly', false);
	
	$('#frmsalic select').attr('disabled', false);
	$('#tsDate').jqxDateTimeInput({ disabled: false});
    $("#salikgrid").jqxGrid({ disabled: false});
    $("#traficgrid").jqxGrid({ disabled: false});
    
    $('#traficdocno').attr('readonly', true);
    
    if ($("#mode").val() == "A") {
		
		 $('#tsDate').val(new Date());
	     $("#salikgrid").jqxGrid('clear');
	    $("#salikgrid").jqxGrid('addrow', null, {});
	    $("#traficgrid").jqxGrid('clear');
	    $("#traficgrid").jqxGrid('addrow', null, {});
	    $("#trafficdiv").prop("hidden", false);
		 $("#salikdiv").prop("hidden",true);
	   }
    
					  


    
	
        }

function funNotify(){

	 if($('#entry').val()=="salik")
	 {
		  
		   var rows = $("#salikgrid").jqxGrid('getrows');
	   var minaa;
	
	   for(var i=0;i<rows.length;i++){
     	
     		  if(rows[i].fleetno>0)
		        {
			  
	    		minaa=1;
	    		break;
	    	     }
	    	else{
	    		minaa=0;
	    	     }
	    	
	    if(minaa==0){
	    	
	    	 document.getElementById("errormsg").innerText="Enter Salik Details";  
	    	  return 0;
	            } 
	   
	   }  
	 

	   
	   for(var i=0 ; i < rows.length ; i++){
	    	
		   if(rows[i].fleetno>0)
	        {
		        	
			 
							    if(rows[i].hiddate==""||rows[i].hiddate==null)
								{
							    
								           document.getElementById("errormsg").innerText="Enter Date";  
						    	           return 0;
								}
					} 
				 	     
	 
	         }
	   var rows = $("#salikgrid").jqxGrid('getrows');
	    $('#salickgridlenght').val(rows.length);
	  
	   for(var i=0 ; i < rows.length ; i++){
	
	    newTextBox = $(document.createElement("input"))
	       .attr("type", "dil")
	       .attr("id", "salicktest"+i)
	       .attr("name", "salicktest"+i)
	       .attr("hidden", "true"); 

	   newTextBox.val(rows[i].fleetno+"::"+rows[i].regno+" :: "+rows[i].tagno+" :: "
			   +rows[i].hiddate+" :: "+rows[i].hidtime+" :: "+rows[i].transaction+" :: "+rows[i].direction+" :: "
			   +rows[i].source+" :: "+rows[i].amount+" :: "+rows[i].location+" :: ");
	
	   newTextBox.appendTo('form');
	  
	    
	   } 
	 }
	
	   else
		   {
		   var rows = $("#traficgrid").jqxGrid('getrows');
		   var minaa;
		   for(var i=0;i<rows.length;i++){
	     		
			   if(rows[i].fleetno>0)
		        {
		    		minaa=1;
		    		break;
		    	     }
		    	else{
		    		minaa=0;
		    	     }
		    	
		    if(minaa==0){
		    	
		    	 document.getElementById("errormsg").innerText="Enter Traffic Details";  
		    	  return 0;
		            } 
		   
		   }  
		 
		   var rows = $("#traficgrid").jqxGrid('getrows');
		  
		   for(var i=0 ; i < rows.length ; i++){
		    	
			   if(rows[i].fleetno>0)
		        {
					    if(rows[i].hiddate==null)
						{
					 	    
						           document.getElementById("errormsg").innerText="Enter Date";  
				    	           return 0;
						}
				} 
		 
		       }
		 var rows = $("#traficgrid").jqxGrid('getrows');
		    $('#trafficgridlenght').val(rows.length);
		  
		   for(var i=0 ; i < rows.length ; i++){
		
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "traffictest"+i)
		       .attr("name", "traffictest"+i)
		       .attr("hidden", "true"); 
		 
		   newTextBox.val(rows[i].fleetno+"::"+rows[i].regno+" :: "+rows[i].source+" :: "
				   +rows[i].finesource+" :: "+rows[i].fineno+" :: "+rows[i].hiddate+" :: "+rows[i].hidtime
				   +" :: "+rows[i].amount+" :: "+rows[i].description+" :: "+rows[i].location+" :: "+rows[i].pltid+" :: "+rows[i].tcno+" :: ");
		
		   newTextBox.appendTo('form');
		  
		    
		   } 
		   }
	return 1;
}
function funChkButton() {
	   /* funReset(); */
	  }
	  
function funSearchLoad(){
	changeContent('saltrafficMastersearch.jsp'); 
 }
 
 function gridchange()
 {


	 if($('#entry').val()=="salik")
	 {
		
		 $("#trafficdiv").prop("hidden", true);
		 $("#salikdiv").prop("hidden",false);
	 }
	 else
		 {
		 
		 $("#trafficdiv").prop("hidden", false);
		 $("#salikdiv").prop("hidden",true);
		 }
	 
 }
 function  chkChange()
 {
	 

 
 if($('#entryval').val()!="")
	 {
	 
	 $('#entry').val($('#entryval').val());
	 
	 }


		 var indexVal2 = document.getElementById("traficdocno").value;
		
	  if(indexVal2>0)
		 {
		 if($('#entryval').val()=="traffic")
			 {
			
			 $("#trafficdiv").prop("hidden", false);
			 $("#salikdiv").prop("hidden",true);
             $("#trafficdiv").load("traficGrid.jsp?trafficdocno="+indexVal2);
			 }
		 else
			 {
			 $("#trafficdiv").prop("hidden", true);
			 $("#salikdiv").prop("hidden",false);
			 $("#salikdiv").load("salikmainGrid.jsp?salickdocno="+indexVal2);	 
			 }

   		}
	  var indexVal3 = document.getElementById("traficdocno").value;
		
	  if(indexVal3==0)
		  {
		  if($('#entryval').val()=="traffic")
			 {
			
			 $("#trafficdiv").prop("hidden", false);
			 $("#salikdiv").prop("hidden",true);
        
			 }
		 else
			 {
			 $("#trafficdiv").prop("hidden", true);
			 $("#salikdiv").prop("hidden",false);
			
			 }
		  }
 }
 
	function setValues() {
		if($('#hidtsDate').val()){
			$("#tsDate").jqxDateTimeInput('val', $('#hidtsDate').val());
		}
		
		  
	
   	if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
	
   	
   	 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";		
   	chkChange();
		
	}
 
</script>



<style>
/* =========================================================
   MODERN ERP LAYOUT - EXACT ALIGNMENT & FULL WIDTH GRID 
   (Fuses tight horizontal alignment with modern clean UI)
========================================================= */
body {
    background: #f4f6f9;
    font-family: Arial, sans-serif;
    color: #333;
    font-size: 12px;
    margin: 0;
    padding: 10px;
    box-sizing: border-box;
}

#mainBG {
    background: #fff;
    border-radius: 4px;
    padding: 15px;
    max-width: 100%;
    margin: auto;
    box-shadow: 0 1px 4px rgba(0,0,0,0.1);
    box-sizing: border-box;
}

/* Master Input Heights - Set to 24px as requested */
input[type="text"], select {
    height: 24px !important;
    border: 1px solid #ccc;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box;
    width: 100%;
    background-color: #fff;
    color: #333;
}

input[type="text"]:focus, select:focus {
    border-color: #007bff;
    outline: none;
}

/* Clean Panels mapping to fieldsets */
fieldset {
    border: 1px solid #e1e4e8;
    background-color: #fff;
    margin-bottom: 10px;
    padding: 12px 10px 10px 10px;
    border-radius: 4px;
}

legend {
    font-size: 13px;
    font-weight: bold;
    color: #0056b3;
    padding: 0 0 0 6px;
    border-left: 3px solid #0056b3;
    margin-bottom: 5px;
}

/* Strict Full-Width CSS Grid for Top Section */
.top-grid {
    display: grid;
    /* 5 strict columns + inputs. Stretches perfectly across. */
    grid-template-columns: 80px minmax(100px, 1fr) 70px minmax(100px, 1fr) 50px minmax(150px, 2fr) 110px minmax(100px, 1fr) 90px minmax(100px, 1fr);
    column-gap: 8px;
    row-gap: 8px;
    align-items: center;
    width: 100%;
    margin-bottom: 15px;
}

.top-grid > label {
    text-align: right;
    color: #444;
    font-size: 12px;
    font-weight: bold;
    white-space: nowrap;
}

.flex-row {
    display: flex;
    align-items: center;
    gap: 5px;
    width: 100%;
}

.chk-container {
    display: flex;
    align-items: center;
    gap: 4px;
    cursor: pointer;
    color: #444;
    font-size: 12px;
    font-weight: bold;
    white-space: nowrap;
}

.chk-container input {
    margin: 0;
    padding: 0;
}

/* Middle Section Split */
.middle-section {
    display: flex;
    gap: 10px;
    margin-bottom: 10px;
}

.middle-panel {
    border: 1px solid #e1e4e8;
    padding: 15px 10px 10px 10px;
    background: #fff;
    position: relative;
    border-radius: 4px;
}

.middle-panel-title {
    position: absolute;
    top: -10px;
    left: 10px;
    background: #fff;
    padding: 0 5px 0 6px;
    color: #0056b3;
    font-weight: bold;
    font-size: 13px;
    border-left: 3px solid #0056b3;
}

/* Clean Tables mapping requested colors */
.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #fff;
    border: 1px solid #ddd;
}
.cr-table th, .cr-table td {
    padding: 4px 6px;
    border: 1px solid #ddd;
    font-size: 12px;
}
.cr-table th {
    background: #f0f3f5;
    font-weight: bold;
    color: #333;
    text-align: left;
}
.lbl-right {
    text-align: right;
    color: #444;
    font-weight: bold;
    font-size: 12px;
    padding-right: 5px;
}

/* Tabs Override */
#tabs { margin-top: 5px; margin-bottom: 0px; }
#content { padding-top: 10px; }

</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmsalic" action="saveSalik" method="post" autocomplete="off" >

<jsp:include page="../../../../header.jsp" /><br/>
<fieldset>
  <div class="top-grid">

    <label>Date</label>
    <div id="tsDate"></div>

    <label>Entry</label>
    <select name="entry" id="entry" onchange="gridchange()">
      <option value="traffic">Traffic</option>
      <option value="salik">Salik</option>
    </select>

  <label>Doc No</label>
<div style="width:20%;">
  <input type="text" name="traficdocno" id="traficdocno">
</div>

  </div>
</fieldset>
<br>
<fieldset>
 
<div id="trafficdiv"  ><jsp:include page="traficGrid.jsp"></jsp:include></div> 


<div id="salikdiv" hidden="true"><jsp:include page="salikmainGrid.jsp"></jsp:include></div> 




</fieldset> 
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'>
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'>

<input type="hidden" id="entryval" name="entryval" value='<s:property value="entryval"/>'>

<input type="hidden" id="salickgridlenght" name="salickgridlenght" value='<s:property value="salickgridlenght"/>'>
<input type="hidden" id="trafficgridlenght" name="trafficgridlenght" value='<s:property value="trafficgridlenght"/>'>

</form>


<div id="salickfleetsearchwindow">   <div ></div>
</div>




<div id="tafficfleetsearchwindow">    <div ></div></div>



</div>
 
	
</body>
</html>