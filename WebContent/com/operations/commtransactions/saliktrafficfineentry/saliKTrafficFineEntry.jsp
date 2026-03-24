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
</head>
<style>
/* ------------------------------
    GLOBAL STYLES (MASTER CRV UI)
------------------------------ */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 32px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 20px;
    max-width: 1450px;
    margin: auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

/* ------------------------------
    COMMON UI ELEMENTS
------------------------------ */
input[type="text"], select {
    height: 32px !important;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    background: #fff;
    transition: border-color 0.2s;
    font-size: 14px;
    box-sizing: border-box;
    width: 100%;
}

input[type="text"]:focus, select:focus {
    border-color: #007bff;
    outline: none;
}

label {
    font: 16px Segoe UI;
    font-weight: 500;
    color: #253858;
    white-space: nowrap;
    line-height: 32px;
    padding: 0px 8px 0px 0px; 
}

/* ------------------------------
    CARD ROWS LAYOUT
------------------------------ */
.section-block {
    flex: 1;
    min-width: 0;
    background: #f6f8fa;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.1);
    margin-bottom: 20px;
}

.section-block h2 {
    font-size: 17.6px;
    font-weight: 600;
    margin: 0 0 20px;
    padding-left: 10px;
    border-left: 4px solid #007bff;
    display: flex;
    align-items: center;
    gap: 10px;
}

.agmt-info-grid {
    display: grid;
    grid-template-columns: auto 1fr auto 1fr auto 1fr; 
    gap: 12px 25px;
    align-items: center;
}

.hidden-scrollbar {
    overflow-y: visible !important; 
    max-height: none !important; 
    min-height: 1px; 
    padding: 10px; 
}
body::-webkit-scrollbar {
	width: 0px;
}
.myButton {
 font-weight: 700;
    font-size: 13px;
    width: 130px;
    height: 38px;
    padding: 8px 12px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 2px 4px rgba(59, 130, 246, 0.2);
    text-transform: uppercase;
    letter-spacing: 0.3px;
    white-space: nowrap;
    text-align: center;
}

.myButton:hover {
  background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%);
  box-shadow: 0 4px 6px rgba(59, 130, 246, 0.3);
  transform: translateY(-1px);
</style>

<body onload="setValues();">

<div id="mainBG" class="homeContent" data-type="background">
    <jsp:include page="../../../../header.jsp" />
    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:10px;">

    <div style="display:flex; align-items:center; gap:8px;">
        <label>Date</label>
        <div id="tsDate" name="tsDate"
             value='<s:property value="tsDate"/>'
             style="width:120px;"></div>
    </div>

    <div style="display:flex; align-items:center; gap:8px;">
        <label>Doc No.</label>
        <input type="text" name="traficdocno" id="traficdocno"
               tabindex="-1"
               value='<s:property value="traficdocno"/>'
               style="width:120px;">
    </div>

</div>
                  
    <br/>

    <form id="frmsalic" action="saveSalik" method="post" autocomplete="off">
        <div class="hidden-scrollbar">
            
            <div class="section-block">
                <h2>Entry Details</h2>
                <div class="agmt-info-grid">
                    <label>Entry Type</label>
                    <select name="entry" id="entry" value='<s:property value="entry"/>' onchange="gridchange()">
                        <option value="traffic">Traffic</option>
                        <option value="salik">Salik</option>
                    </select>

                    
                    
                    <input type="hidden" name="hidtsDate" id="hidtsDate" value='<s:property value="hidtsDate"/>'>
                </div>
            </div>

            <div class="section-block">
                <h2>Record Information</h2>
                
                <div id="trafficdiv">
                    <jsp:include page="traficGrid.jsp"></jsp:include>
                </div> 

                <div id="salikdiv" hidden="true">
                    <jsp:include page="salikmainGrid.jsp"></jsp:include>
                </div>
            </div>

            <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
            <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'>
            <input type="hidden" id="entryval" name="entryval" value='<s:property value="entryval"/>'>
            <input type="hidden" id="salickgridlenght" name="salickgridlenght" value='<s:property value="salickgridlenght"/>'>
            <input type="hidden" id="trafficgridlenght" name="trafficgridlenght" value='<s:property value="trafficgridlenght"/>'>
        </div>
    </form>

    <div id="salickfleetsearchwindow"><div></div></div>
    <div id="tafficfleetsearchwindow"><div></div></div>

</div>

</body>
</html>