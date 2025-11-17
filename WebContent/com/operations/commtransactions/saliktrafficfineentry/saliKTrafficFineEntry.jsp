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
            overflow: auto;
            height: 530px;
        }
        #validrate{
            color:red;
        }
        #validrate1{
            color:red;
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
            color: #222;
            margin: 0;
            padding: 32px 0;
            min-height: 100vh;
            box-sizing: border-box;
        }
        #mainBG {
            background: #fff;
            border-radius: 16px;
            /*box-shadow: 0 4px 24px rgba(0,0,0,0.08);*/
            padding: 10px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .receipt-header {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            margin-bottom: 16px;
            border-radius: 12px;
            padding: 0px 24px;
            font-size: 2vh;
        }
        .receipt-header label {
            font-weight: 500;
            color: #333;
            margin-right: 8px;
        }
        .receipt-header input[type="text"] {
            border: 1px solid #d1d5db;
            border-radius: 6px;
            padding: 6px 10px;
            font-size: 1rem;
            width: 120px;
            background: #fff;
            transition: border-color 0.2s;
        }
        .receipt-header input[type="text"]:focus {
            border-color: #007bff;
            outline: none;
        }
        .receipt-header button {
            background: #007bff;
            color: #fff;
            border: none;
            border-radius: 6px;
            padding: 6px 16px;
            font-weight: 500;
            cursor: pointer;
            transition: background 0.2s;
        }
        .receipt-header button:hover {
            background: #0056b3;
        }
        #txtStatus {
            font-size: 1rem;
            font-weight: 600;
            color: #e67e22;
            margin-left: 12px;
        }

        .section-row {
            display: flex;
            gap: 26px;
            margin-bottom: 24px;
        }
        .section-block {
            flex: 1;
            background: #f6f8fa;
            border-radius: 10px;
            padding: 20px 18px;
            box-shadow: 0 1px 8px rgba(160,177,217,0.05);
        }

        .section-block h2 {
            font-size: 1.09em;
            font-weight: 500;
            margin: 0 0 16px 0;
            color: #253858;
        }

        .section-block .form-group {
            display: flex;
            align-items: center;
            gap: 16px;
            margin-bottom: 12px;
        }

        .section-block label {
            min-width: 110px;
            text-align: right;
            font-weight: 500;
            color: #253858;
        }

        .section-block input[type="text"],
        .section-block select {
            flex: 1;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            padding: 6px 10px;
            background: #fff;
            transition: border-color 0.2s;
        }

        .section-block input[type="text"]:focus,
        .section-block select:focus {
            border-color: #007bff;
            outline: none;
        }


        .table-section {
            margin-bottom: 18px;
        }
        .table-section h3 {
            color: #253858;
            font-size: 1.04em;
            font-weight: 600;
        }
        .cr-table {
            width: 100%;
            border-collapse: collapse;
            background: #f9fafb;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 0 0 1px #eef0f6;
        }
        .cr-table th, .cr-table td {
            padding: 9px 10px;
            border-bottom: 1px solid #e4e7ec;
            text-align: left;
            font-size: 1em;
        }
        .cr-table th {
            background: #eef0f6;
            color: #354B6A;
            font-weight: 600;
        }
        .cr-table tr:last-child td {
            border-bottom: none;
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
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmsalic" action="saveSalik" method="post" autocomplete="off" >

<jsp:include page="../../../../header.jsp" /><br/>
<div class="hidden-scrollbar receipt-header">
 <table class="cr-table" width="100%" >
  <tr>
  <td width="20%" align="right">Entry</td>
  <td width="10%" align="left">
  <select name="entry" id="entry" style="width:50%;"  value='<s:property value="entry"/>' onchange="gridchange()">
      <option value="traffic">Traffic</option>
       <option value="salik">Salik</option>
    </select>
  </td>
   
  <td width="4%" align="right" > 
Date
  </td> 
    <td width="5%" align="left"><div id="tsDate" name="tsDate" value='<s:property value="tsDate"/>'></div>
    
    <input type="hidden" name="hidtsDate" id="hidtsDate" value='<s:property value="hidtsDate"/>'>
    </td>
  
  <td width="4%" align="right"> Doc NO </td>
 
  
    <td width="5%" align="left"><input type="text" name="traficdocno" id="traficdocno"  tabindex="-1" value='<s:property value="traficdocno"/>'></td>
 
   
 <td width="30%"></td>
    </tr>
      
</table> 


<br>

 
<div class="cr-table" style="width: 100%;" id="trafficdiv"  ><jsp:include page="traficGrid.jsp"></jsp:include></div>


<div id="salikdiv" hidden="true"><jsp:include page="salikmainGrid.jsp"></jsp:include></div>

</div>

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