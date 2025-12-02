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
 <style>
   .hidden-scrollbar {
  overflow-y: auto;
  height: 530px;
  scrollbar-width: thin;
  scrollbar-color: #4da3ff #eaf3ff;
}
.hidden-scrollbar::-webkit-scrollbar {
  width: 7px;
}
.hidden-scrollbar::-webkit-scrollbar-thumb {
  background-color: #4da3ff;
  border-radius: 8px;
}
.hidden-scrollbar::-webkit-scrollbar-thumb:hover {
  background-color: #1a73e8;
}

body {
  background: linear-gradient(135deg, #e8f1ff 0%, #d1e4ff 100%);
  font-family: "Poppins", "Segoe UI", Arial, sans-serif;
  color: #1f2f46;
  margin: 0;
  padding: 40px 0;
  min-height: 100vh;
  box-sizing: border-box;
}

#mainBG {
  background: #f4f8ff;
  border-radius: 16px;
  box-shadow: 0 4px 25px rgba(50, 110, 255, 0.15);
  padding: 25px 30px;
  max-width: 1250px;
  margin: 0 auto;
  transition: 0.3s ease;
}
#mainBG:hover {
  box-shadow: 0 8px 35px rgba(30, 100, 255, 0.25);
}

.receipt-header {
  background: #edf4ff;
  border: 1px solid #c9dafc;
  border-radius: 14px;
  padding: 20px;
  margin-bottom: 26px;
  box-shadow: 0 2px 10px rgba(132, 168, 255, 0.2);
  font-size: 14px;
}

label {
  font-weight: 600;
  font-size: 15px;
  color: #1a2d4d;
  margin-bottom: 6px;
}

#validrate,
#validrate1 {
  color: #d62828;
  font-weight: 600;
  font-size: 0.9rem;
}

.receipt-header input[type="text"],
.receipt-header select {
  border: 1px solid #b9ccf2;
  border-radius: 8px;
  padding: 6px 12px;
  height: 38px;
  font-size: 0.95rem;
  background: #ffffff;
  color: #1f2f46;
  box-sizing: border-box;
  transition: 0.25s ease;
}
.receipt-header input[type="text"]:focus,
.receipt-header select:focus {
  border-color: #4da3ff;
  box-shadow: 0 0 6px rgba(77, 163, 255, 0.55);
  outline: none;
}

select {
  appearance: none;
  background: #ffffff url("data:image/svg+xml;utf8,<svg fill='%233b82f6' height='20' width='20' viewBox='0 0 20 20'><polygon points='5,7 15,7 10,12' /></svg>") no-repeat right 10px center;
  background-size: 14px;
}
select option {
  font-size: 15px;
}

input[readonly],
select:disabled {
  background-color: #eef3ff;
  color: #6a7ba1;
}

.cr-table {
  width: 100%;
  border-collapse: collapse;
  background: #ffffff;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 2px 12px rgba(100, 140, 255, 0.15);
}
.cr-table th,
.cr-table td {
  padding: 10px 12px;
  border-bottom: 1px solid #d6e1ff;
  text-align: left;
  font-size: 0.95rem;
  color: #1f2f46;
}
.cr-table th {
  background-color: #dcebff;
  color: #1b3f73;
  font-weight: 600;
}
.cr-table tr:hover td {
  background-color: #eef5ff;
  transition: 0.25s;
}

input[type="text"]::selection {
  background: #cfe2ff;
  color: #000000;
}
input[type="text"]::-moz-selection {
  background: #cfe2ff;
  color: #000000;
}

@media (max-width: 900px) {
  .receipt-header {
    padding: 16px;
  }
}
</style>
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

  <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  <link rel="stylesheet" type="text/css" href="rentalrefund.css">
  <title>Rental Refund</title>
</head>
<body onload="setValues();">
  <div id="mainBG" class="homeContent" data-type="background">
    <form id="frmsalic" action="saveSalik" method="post" autocomplete="off">
      <jsp:include page="../../../../header.jsp" /><br/>

      <div class="hidden-scrollbar receipt-header">
        <table class="cr-table" width="100%">
          <tr>
            <td width="20%" align="right">Entry</td>
            <td width="10%" align="left">
              <select name="entry" id="entry" style="width:50%;" value='<s:property value="entry"/>' onchange="gridchange()">
                <option value="traffic">Traffic</option>
                <option value="salik">Salik</option>
              </select>
            </td>
            <td width="4%" align="right">Date</td>
            <td width="5%" align="left">
              <div id="tsDate" name="tsDate" value='<s:property value="tsDate"/>'></div>
              <input type="hidden" name="hidtsDate" id="hidtsDate" value='<s:property value="hidtsDate"/>'>
            </td>
            <td width="4%" align="right">Doc NO</td>
            <td width="5%" align="left">
              <input type="text" name="traficdocno" id="traficdocno" tabindex="-1" value='<s:property value="traficdocno"/>'>
            </td>
            <td width="30%"></td>
          </tr>
        </table>

        <br>
        <div class="cr-table" style="width: 100%;" id="trafficdiv">
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
    </form>

    <div id="salickfleetsearchwindow"><div></div></div>
    <div id="tafficfleetsearchwindow"><div></div></div>
  </div>
</body>


</html>