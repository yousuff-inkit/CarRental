<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>GatewayERP(i)</title>
 <jsp:include page="../../../../../includes.jsp"></jsp:include> 


<script type="text/javascript">

 $(document).ready(function () {
	 	document.getElementById("formdet").innerText="HR Setup(HRS)";
		document.getElementById("formdetail").value="HR Setup";
		document.getElementById("formdetailcode").value="HRS";
		window.parent.formCode.value="HRS"; 
		window.parent.formName.value="HR Setup";
		
   	 	$("#masterdate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});    
   	 	$("#validfromdate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});   
	   	$("#lastreviseddate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});   
   	 	$("#workingtime").jqxDateTimeInput({ width: '60%', height: '15px', formatString:'HH:mm', showCalendarButton: false}); 
   	 
     	$('#formulawindow').jqxWindow({ width: '45%', height: '54%',  maxHeight: '75%' ,maxWidth: '60%' , title: 'Salary Calculation Formula' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27,theme: 'energyblue', showCloseButton: true});
	 	$('#formulawindow').jqxWindow('close');
	 	
	 	$('#accountSearchwindow').jqxWindow({ width: '60%', height: '62%',  maxHeight: '75%' ,maxWidth: '60%' , title: 'Account Search' ,position: { x: 150, y: 60 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 	$('#accountSearchwindow').jqxWindow('close');
	 	
	 	$('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#costTypeSearchGridWindow').jqxWindow('close');
		
		$('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#costCodeSearchWindow').jqxWindow('close');
	 
   		getCategory();getleave();
     
	   	$('#convformula').dblclick(function(){
	    	if($('#mode').val()!= "view") {
		  	    $('#formulawindow').jqxWindow('open');
		  		var id="convformula";
		  	    formulaSearchContent('formula.jsp?id='+id);
	    	} 
	    });   
	    
   	
	   $('#normalrate').dblclick(function(){
		  	if($('#mode').val()!= "view") {
			  	    $('#formulawindow').jqxWindow('open');
		    		var id="normalrate";
			  	    formulaSearchContent('formula.jsp?id='+id);
		      } 
		});   
		    
	   $('#ot').dblclick(function(){
		  	if($('#mode').val()!= "view") {
			  	    $('#formulawindow').jqxWindow('open');
		    	    var id="ot";
			  	    formulaSearchContent('formula.jsp?id='+id);
		    	}  
		});   
		    
	    $('#holidayot').dblclick(function(){
		 	if($('#mode').val()!= "view") {
			  	    $('#formulawindow').jqxWindow('open');
		    		var id="holidayot";
			  	    formulaSearchContent('formula.jsp?id='+id);
		      } 
		 });   
	  
	});
       
 	function formulaSearchContent(url) {
    	$.get(url).done(function (data) {
	   		$('#formulawindow').jqxWindow('setContent', data);
	}); 
 	}

	function accountSearchContent(url) {
 		if($('#mode').val()!="view") {      
 			$.get(url).done(function (data) {
	 		$('#accountSearchwindow').jqxWindow('open');
			$('#accountSearchwindow').jqxWindow('setContent', data);
		}); 
  	}
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
 
 	function getconfor(event){
 	 	var x= event.keyCode;
 		if($('#mode').val()!="view") {  
	 	if(x==114){
 		    $('#formulawindow').jqxWindow('open');
		  	var id="convformula";
		  	formulaSearchContent('formula.jsp?id='+id);
 	 } else{}
 		 }  
 	 }
 
 	function getnr(event){
 		var x= event.keyCode;
 		if($('#mode').val()!="view") {  
	 	if(x==114){
 		  $('#formulawindow').jqxWindow('open');
  		  var id="normalrate";
	  	  formulaSearchContent('formula.jsp?id='+id);
 	 } else{}
 	    }  
 	 }
 	
 	function getot(event){
 	 	var x= event.keyCode;
	  	if($('#mode').val()!="view") { 
	 	if(x==114){
 		  $('#formulawindow').jqxWindow('open');
  		  var id="ot";
	  	  formulaSearchContent('formula.jsp?id='+id);
 	 } else{}
 		  }  
 	 }
 
 	function getholyot(event){
 	 	var x= event.keyCode;
   		if($('#mode').val()!="view") {  
 		if(x==114){
 		  $('#formulawindow').jqxWindow('open');
  		  var id="holidayot";
	  	  formulaSearchContent('formula.jsp?id='+id);
 	 } else{}
 		  } 
 	 }
 
    function funReset(){ }
    
	function funReadOnly(){
		//masterdate validfromdate lastreviseddate workingtime
		
		$('#masterdate').jqxDateTimeInput({ disabled: true});
	    $('#validfromdate').jqxDateTimeInput({ disabled: true});
	    $('#lastreviseddate').jqxDateTimeInput({ disabled: true});
	    $('#workingtime').jqxDateTimeInput({ disabled: true});
		$('#frmhrsetups input').attr('readonly', true );
		$('#frmhrsetups select').attr('disabled', true);
	    $('#mon').attr('disabled', true);
	    $('#tue').attr('disabled', true);
	    $('#wed').attr('disabled', true);
	    $('#thu').attr('disabled', true);
	    $('#fri').attr('disabled', true);
	    $('#sat').attr('disabled', true);
	    $('#sun').attr('disabled', true);
	    $('#leaveid').attr('disabled', true);
	    $('#cmbcategory').attr('disabled', true);
	    $('#carryforward').attr('disabled', true);
	    
	//    mon tue wed thu fri sat sun leaveid cmbcategory carryforward
	}
	
	function funRemoveReadOnly(){
		$('#masterdate').jqxDateTimeInput({ disabled: false});
	    $('#validfromdate').jqxDateTimeInput({ disabled: false});
	    $('#lastreviseddate').jqxDateTimeInput({ disabled: false});
	    $('#workingtime').jqxDateTimeInput({ disabled: false});
		$('#frmhrsetups input').attr('readonly', false );
		$('#frmhrsetups select').attr('disabled', false);
	    $('#mon').attr('disabled', false);
	    $('#tue').attr('disabled', false);
	    $('#wed').attr('disabled', false);
	    $('#thu').attr('disabled', false);
	    $('#fri').attr('disabled', false);
	    $('#sat').attr('disabled', false);
	    $('#sun').attr('disabled', false);
	    $('#leaveid').attr('disabled', false);
	    $('#cmbcategory').attr('disabled', false);
	    $('#carryforward').attr('disabled', false);
	    $('#convformula').attr('readonly', true );
	    $('#normalrate').attr('readonly', true );
	    $('#ot').attr('readonly', true );
	    $('#holidayot').attr('readonly', true );
	    
		 if ($("#mode").val() == "A") {
    		  $("#termibeni").load("terminationbenefitcondtiongrid.jsp");
    		  $("#resiggrid").jqxGrid('clear');
		      $("#resiggrid").jqxGrid('addrow', null, {});
		      $("#resiggrid").jqxGrid('addrow', null, {});
		      $("#resiggrid").jqxGrid('addrow', null, {});
		      $("#resiggrid").jqxGrid('addrow', null, {});
		      $("#trmigrid").jqxGrid('clear');
		      $("#trmigrid").jqxGrid('addrow', null, {});
		      $("#trmigrid").jqxGrid('addrow', null, {});
		      $("#trmigrid").jqxGrid('addrow', null, {});
		      $("#trmigrid").jqxGrid('addrow', null, {});
		      $("#resiggrid").jqxGrid({ disabled: false}); 
		      $("#trmigrid").jqxGrid({ disabled: false}); 
    	      $("#accset").load("accountsetupgrid.jsp"); 
		 }
		 
		 if ($("#mode").val() == "E") {
             $("#resiggrid").jqxGrid({ disabled: false}); 
			 $("#trmigrid").jqxGrid({ disabled: false}); 
			 $("#trmigrid").jqxGrid('addrow', null, {});
			 $("#resiggrid").jqxGrid('addrow', null, {});
			  
			 $("#accountsetup").jqxGrid({ disabled: false}); 
			 var docVal1 = document.getElementById("docno").value;
			 $("#termibeni").load("terminationbenefitcondtiongrid.jsp?docno="+docVal1+"&modeval="+"E");
		 }
		 
	   //  normalrate ot holidayot
	}
 
	function funNotify(){	
		  var z=0;
		  var rows = $("#benifitsgrid").jqxGrid('getrows');      
		  var selectedrows=$("#benifitsgrid").jqxGrid('selectedrowindexes');
			 
			$('#benigridlength').val(selectedrows.length);
		    for (var i = 0; i < rows.length; i++) {
			      for(var j=0;j<selectedrows.length;j++){
			       if(selectedrows[j]==i){
			    	   newTextBox = $(document.createElement("input"))
			    	   .attr("type", "dil")
				       .attr("id", "trbenitest"+z)
				       .attr("name", "trbenitest"+z)
				       .attr("hidden", "true");  
				    
				   newTextBox.val(rows[i].allowanceid+" :: ");
				   newTextBox.appendTo('form');
				   z++;
			       }
			      }
			   }
	   
		var rows = $("#trmigrid").jqxGrid('getrows');      
	    $('#trmigridlength').val(rows.length);
	    for(var i=0;i<rows.length;i++){
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "termitest"+i)
		       .attr("name", "termitest"+i)
		       .attr("hidden", "true");  
	    
	   		newTextBox.val(rows[i].hidyears+" :: "+rows[i].days+" :: "); 
	   		newTextBox.appendTo('form');
	   }
	   
		var rows = $("#resiggrid").jqxGrid('getrows');
	    $('#resiggridlength').val(rows.length);
	    for(var i=0;i<rows.length;i++){
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "resigtest"+i)
		       .attr("name", "resigtest"+i)
		       .attr("hidden", "true");  
	    
	    	newTextBox.val(rows[i].hidyears+" :: "+rows[i].days+" :: "); 
	    	newTextBox.appendTo('form');
	   }
	    
		var rows = $("#accountsetup").jqxGrid('getrows');
	    $('#accountsetupgridlength').val(rows.length);
	   	for(var i=0;i<rows.length;i++){
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
		       .attr("id", "acnotest"+i)
		       .attr("name", "acnotest"+i)
		       .attr("hidden", "true");  
	    
	   		newTextBox.val(rows[i].allowanceid+":: "+rows[i].acno+":: "+rows[i].costtype+":: "+rows[i].costcode);
	   		newTextBox.appendTo('form');
	   }
		return 1;
	} 

	function funChkButton() { }

	function funSearchLoad(){
		 changeContent('mastersearch.jsp'); 
	}
     
		
	function funFocus(){
		$('#masterdate').jqxDateTimeInput('focus');		 
	}
	 
	function setValues() {
		   
		if($('#hidmasterdate').val()){
			$("#masterdate").jqxDateTimeInput('val', $('#hidmasterdate').val());
		}
		   
		if($('#hidvalidfromdate').val()){
			$("#validfromdate").jqxDateTimeInput('val', $('#hidvalidfromdate').val());
		}
		   
		if($('#hidlastreviseddate').val()){
			$("#lastreviseddate").jqxDateTimeInput('val', $('#hidlastreviseddate').val());
		}
		   
		if($('#hidworkingtime').val()){
			$("#workingtime").jqxDateTimeInput('val', $('#hidworkingtime').val());
		}
		   
      	if($('#msg').val()!=""){
 		   $.messager.alert('Message',$('#msg').val());
 		  }
      	
    	  var docVal1 = document.getElementById("docno").value;
        	if(docVal1>0) {
        		 $("#termibeni").load("terminationbenefitcondtiongrid.jsp?docno="+docVal1);
        	     $("#trimi").load("terminationdetailsgrid.jsp?docno="+docVal1);
        	     $("#resig").load("resignationdetailsgrid.jsp?docno="+docVal1);
        	     $("#accset").load("accountsetupgrid.jsp?docno="+docVal1);
        		}
      	
      	   var weakoff= document.getElementById("hidweakoff").value; 
      	   	if(weakoff!="") {
           		var arr = weakoff.split(",");
           		for(var i=0;i<=arr.length-1;i++) {
	           		if(arr[i]=='1') {
    		       		 document.getElementById("mon").checked = true;
          				 document.getElementById("mon").value=1;
           			}
	           		if(arr[i]=='2') {
		       			document.getElementById("tue").checked = true;
      					document.getElementById("tue").value=1;
       			    }
	           		if(arr[i]=='3') {
       					document.getElementById("wed").checked = true;
      		  			document.getElementById("wed").value=1;
	       			}
    	       		if(arr[i]=='4') {
		       			document.getElementById("thu").checked = true;
      					document.getElementById("thu").value=1;
       			    }
           			if(arr[i]=='5') {
		       			document.getElementById("fri").checked = true;
      			 	    document.getElementById("fri").value=1;
       			    }
           			if(arr[i]=='6') {
		       			document.getElementById("sat").checked = true;
      				    document.getElementById("sat").value=1;
       			    }
           			if(arr[i]=='7') {
		       			document.getElementById("sun").checked = true;
      				    document.getElementById("sun").value=1;
       				}
           		}
      		 }

      	   	var carryforward=document.getElementById("hidcarryforward").value;
         	if(parseInt(carryforward)==1) {
         	 	document.getElementById("carryforward").checked = true;
    		  	document.getElementById("carryforward").value=1;
         	} else {
        	 	document.getElementById("carryforward").checked = false;
    		  	document.getElementById("carryforward").value=0;
         	}
	}

	function getCategory() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;	
				items = items.split('***');
				var branchItems = items[0].split(",");
				var branchIdItems = items[1].split(",");
				var optionsbranch = '<option value="">--Select--</option>';
				for (var i = 0; i < branchItems.length; i++) {
					optionsbranch += '<option value="' + branchIdItems[i] + '">'
							+ branchItems[i] + '</option>';
				}
				$("select#cmbcategory").html(optionsbranch);
				
				  if ($('#hidcatval').val() != null) {
					$('#cmbcategory').val($('#hidcatval').val());
				  }  
			
			} else {}
		}
		x.open("GET", "getCategory.jsp", true);
		x.send();
	}
	  
 	function getleave() {
	    var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;	
				items = items.split('***');
				var branchItems = items[0].split(",");
				var branchIdItems = items[1].split(",");
				var optionsbranch = '<option value="">--Select--</option>';
				for (var i = 0; i < branchItems.length; i++) {
					optionsbranch += '<option value="' + branchIdItems[i] + '">'
							+ branchItems[i] + '</option>';
				}
				$("select#leaveid").html(optionsbranch);
				
				  if ($('#hidleaveid').val() != null) {
					$('#leaveid').val($('#hidleaveid').val());
				   }  
			} else { }
		}
		x.open("GET", "getleaveid.jsp", true);
		x.send();
     }
 	
 	function isNumber(evt) {
     	var iKeyCode = (evt.which) ? evt.which : evt.keyCode
     	if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
  	   		document.getElementById("errormsg").innerText=" Enter Numbers Only";  
	        return false;
     	}
     	document.getElementById("errormsg").innerText="";  
     	return true;
 	}	
 	
 	function termConfig() {
	    var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;	
				if(parseInt(items)===1){
					$('.hideterm').hide();
					$('#fs3').insertBefore('#fs1');
				}
			} else { 
			}
		}
		x.open("GET", "gettermconfig.jsp", true);
		x.send();
     }
 
	
</script>

<style>

/* scroll area */

.hidden-scrollbar {

    height: 530px;

    overflow-x: hidden;

    overflow-y: auto;

}

/* background + base typography (master) */

body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI','Roboto','Arial',sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    min-height: 100vh;
    box-sizing: border-box;
    font-size: 14px;
    overflow-y: auto !important; /* Forces the main window to handle scrolling */
}



/* main card (master) */

#mainBG {

    background: #fff;

    border-radius: 16px;

    padding: 18px 28px;

    max-width: 100%;

    margin: 0 auto;

}



/* page header strip */

.receipt-header {

    display: flex;

    flex-wrap: wrap;

    align-items: center;

    margin-bottom: 20px;

    border-radius: 12px;

    padding: 0 24px;

    font-size: 14px;

}

.receipt-header label {

    font-weight: 500;

    color: #333;

    margin-right: 8px;

}

.receipt-header input[type="text"] {

    border: 1px solid #d1d5db;

    border-radius: 6px;

    padding: 4px 8px;

    font-size: 13px;

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

    padding: 4px 12px;

    font-weight: 500;

    cursor: pointer;

    transition: background 0.2s;

}

.receipt-header button:hover {

    background: #0056b3;

}

#txtStatus {

    font-size: 14px;

    font-weight: 600;

    color: #e67e22;

    margin-left: 12px;

}



/* section card like User Master (master) */

.table-section {

    margin-bottom: 20px;

    padding-inline: 14px;

    padding-block: 14px;

    border-radius: 10px;

    background: #f6f8fa;

    box-shadow: 0 1px 8px rgba(160,177,217,0.05);

}

.table-section h3 {

    margin: 0 0 12px;

    padding-left: 10px;

    border-left: 4px solid #007bff;  /* blue bar */

    color: #253858;

    font-size: 15px;

    font-weight: 600;

}



/* optional generic blocks – match master card look */

.section-row {

    display: flex;

    gap: 20px;

    margin-bottom: 20px;

}

.section-block {

    flex: 1;

    background: #f6f8fa;

    border-radius: 10px;

    padding: 16px 14px;

    box-shadow: 0 1px 8px rgba(160,177,217,0.05);

}

.section-block h2 {

    font-size: 14px;

    font-weight: 500;

    margin: 0 0 12px 0;

    color: #253858;

}

.section-block .form-group {

    display: flex;

    align-items: center;

    gap: 12px;

    margin-bottom: 10px;

}

.section-block label {

    min-width: 110px;

    text-align: right;

    font-weight: 500;

    color: #253858;

    font-size: 13px;

}

.section-block input[type="text"],

.section-block select {

    flex: 1;

    border: 1px solid #d1d5db;

    border-radius: 6px;

    padding: 4px 8px;

    background: #fff;

    transition: border-color 0.2s;

    font-size: 13px;

}

.section-block input[type="text"]:focus,

.section-block select:focus {

    border-color: #007bff;

    outline: none;

}



/* grid/table layout for fields (master) */

.cr-table {

    width: 100%;

    border-collapse: collapse;

    background: #f9fafb;

    border-radius: 8px;

    overflow: hidden;

    box-shadow: 0 0 0 1px #eef0f6;

    table-layout: fixed;

}

.cr-table th,

.cr-table td {

    padding: 8px 10px;

    border-bottom: 1px solid #e4e7ec;

    text-align: left;

    font-size: 13px;

    vertical-align: middle;

}

.cr-table th {

    background: #eef0f6;

    color: #354B6A;

    font-weight: 600;

}

.cr-table tr:last-child td {

    border-bottom: none;

}

.cr-table td[align="right"] {

    white-space: nowrap;

    font-weight: 500;

    color: #333;

}



/* unified inputs in tables (master) */

.cr-table input[type="text"],

.cr-table select {

    width: 100%;

    border: 1px solid #d1d5db;

    border-radius: 6px;

    padding: 4px 8px;

    height: 30px;

    font-size: 13px;

    box-sizing: border-box;

    background: #fff;

}

.cr-table input[type="text"]:focus,

.cr-table select:focus {

    border-color: #007bff;

    outline: none;

}

/* blue line and padding for all section headings */

.table-section h3,

.section-block h2,

h3.section-title,

h2.section-title {

    margin: 0 0 12px;

    padding: 4px 10px;               /* space around text */

    border-left: 4px solid #007bff;  /* blue line */

    color: #253858;

    font-size: 15px;

    font-weight: 600;

}

/* master UI heading with blue line */

.table-section h3,

.section-block h2,

h3.section-title,

h2.section-title {

    margin: 0 0 12px;

    padding: 4px 10px;               /* padding around the text */

    border-left: 4px solid #007bff;  /* blue line */

    color: #253858;

    font-size: 15px;

    font-weight: 600;

    background: transparent;

}



</style>
 

</head>
<body onload="termConfig();setValues();">

<div id="mainBG" class="homeContent" data-type="background">

<form id="frmhrsetups" action="saveHrsetup" autocomplete="OFF" >



<jsp:include page="../../../../../header.jsp"></jsp:include><br/>

<div class='hidden-scrollbar receipt-header'>



<h3>For Days in Year</h3>

<div class="table-section">

<table class="cr-table" width="99%"  >

  <tr>

    <td width="13%" align="right">Date</td>  

    <td width="12%"><div id='masterdate' name='masterdate' value='<s:property value="masterdate"/>'></div>

                     <input type="hidden" id="hidmasterdate" name="hidmasterdate" value='<s:property value="hidmasterdate"/>'/></td>

    <td colspan="5">&nbsp;</td>

    <td width="4%" align="right">Doc No</td>

    <td width="9%"><input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>'/></td>

  </tr>

  <tr>

    <td align="right">Valid From</td> 

    <td><div id='validfromdate' name='validfromdate' value='<s:property value="validfromdate"/>'></div>

                     <input type="hidden" id="hidvalidfromdate" name="hidvalidfromdate" value='<s:property value="hidvalidfromdate"/>'/></td>

    <td width="10%" align="right">Last Revised On</td>

    <td width="11%"><div id='lastreviseddate' name='lastreviseddate' value='<s:property value="lastreviseddate"/>'></div>

                     <input type="hidden" id="hidlastreviseddate" name="hidlastreviseddate" value='<s:property value="hidlastreviseddate"/>'/></td>

    <td width="9%" align="right">PayRoll Category</td>

    <td width="14%"><select name="cmbcategory" id="cmbcategory" style="width:99%;"  value='<s:property value="cmbcategory"/>'><option value="">-- select -- </option></select></td>

   <td width="14%" align="right">Working Hours/Day</td>
<td width="11%">
    <div id='workingtime' name='workingtime' style="width:100% !important; min-width:110px;" value='<s:property value="workingtime"/>'></div>
    <input type="hidden" id="hidworkingtime" name="hidworkingtime" value='<s:property value="hidworkingtime"/>'/>
</td>

    <td colspan="2" rowspan="3">&nbsp;</td>

  </tr>

  <tr>

  <td align="right">Annual Leave:Leave ID</td>

    <td><select name="leaveid" id="leaveid" style="width:99%;"  value='<s:property value="leaveid"/>'><option value="">-- select --</option></select>

  </td>

    <td align="right">Weekly Off</td>

    <td colspan="3"><fieldset>

  <input type="checkbox" id="mon" name="mon"  value="0"  onclick="$(this).attr('value', this.checked ? 1 : 0)"  > Mon

  <input type="checkbox" id="tue" name="tue"    value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)"> Tue

  <input type="checkbox" id="wed" name="wed"   value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)"> Wed

  <input type="checkbox" id="thu" name="thu"   value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)"> Thu

  <input type="checkbox" id="fri" name="fri"   value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)"> Fri

  <input type="checkbox" id="sat" name="sat"   value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)"> Sat

  <input type="checkbox" id="sun" name="sun"  value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)"> Sun

  </fieldset></td>

    <td colspan="2" align="left"> 

    <input type="checkbox" id="carryforward" name="carryforward"  value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" >Carry Forward</td>

  </tr>

  <tr>

    <td align="right">Eligible Days</td>

    <td><input type="text" id="eligibledays" name="eligibledays"   onkeypress="javascript:return isNumber (event)"  value='<s:property value="eligibledays"/>' ></td>

    <td align="right">In a Year</td>

    <td colspan="5"><input type="text" id="forworkingdays" name="forworkingdays"  onkeypress="javascript:return isNumber (event)"  value='<s:property value="forworkingdays"/>' ></td>

  </tr>

</table>

</div>

 <table class="cr-table" width="100%">

 <tr>

 <td height="234" width="55%">

  <h3>Terminal Benefits</h3>

   <table class="hideterm cr-table" id="fs1" width="100%">

   <tr>

   <td width="65%">

    <div class="cr-table" id="termibeni"> <jsp:include page="terminationbenefitcondtiongrid.jsp"></jsp:include></div>

 </td>

 <td width="35%">

    <h3>Termination Details</h3>

   <div class="cr-table" id="trimi"> <jsp:include page="terminationdetailsgrid.jsp"></jsp:include></div>



 <h3>Resignation Details</h3>

   <div class="cr-table" id="resig"> <jsp:include page="resignationdetailsgrid.jsp"></jsp:include></div>



  </td>

 </tr>

 </table>







       <td  width="45%">

    <div id="fs2" >

<h3>Salary Calculation Formula (Hrs)</h3>

    <table class="cr-table" width="100%">

    <tr><td width="37%" align="right">Conversion Formula Month To Day</td><td align="left"><input type="text" id="convformula" readonly="readonly"   placeholder="Press F3 To Search" name="convformula" Style="width:99%;" value='<s:property value="convformula"/>' onkeydown="getconfor(event);"></td> </tr>

    <tr><td  width="37%" align="right">Rate per Hour</td><td align="left" ><input type="text" id="normalrate" name="normalrate" readonly="readonly"   placeholder="Press F3 To Search" Style="width:99%;" value='<s:property value="normalrate"/>' onkeydown="getnr(event);" > </td> </tr>

    <tr><td  width="37%" align="right"> OT</td><td  align="left"><input type="text" id="ot" name="ot" Style="width:99%;" readonly="readonly"   placeholder="Press F3 To Search" value='<s:property value="ot"/>'  onkeydown="getot(event);" > </td> </tr>

    <tr><td width="37%" align="right">Holiday OT</td><td  align="left"><input type="text" id="holidayot" name="holidayot" readonly="readonly"   placeholder="Press F3 To Search" Style="width:99%;" value='<s:property value="holidayot"/>'  onkeydown="getholyot(event);"> </td> </tr>

    </table></div>

    <div id="fs3"><h3>Account Setup</h3>

      <div class="cr-table" id="accset"> <jsp:include page="accountsetupgrid.jsp"></jsp:include></div>

    </div>

   </td>

   </tr>

  </table>



 </div>

 

<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />

<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />

<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>

<input type="hidden" id="hidcatval" name="hidcatval"  value='<s:property value="hidcatval"/>'/>

<input type="hidden" id="hidleaveid" name="hidleaveid"  value='<s:property value="hidleaveid"/>'/>

<input type="hidden" id="hidweakoff" name="hidweakoff"  value='<s:property value="hidweakoff"/>'/>

<input type="hidden" id="hidcarryforward" name="hidcarryforward"  value='<s:property value="hidcarryforward"/>'/>

<input type="hidden" id="benigridlength" name="benigridlength"  value='<s:property value="benigridlength"/>'/>

<input type="hidden" id="trmigridlength" name="trmigridlength"  value='<s:property value="trmigridlength"/>'/>

<input type="hidden" id="resiggridlength" name="resiggridlength"  value='<s:property value="resiggridlength"/>'/>

<input type="hidden" id="accountsetupgridlength" name="accountsetupgridlength"  value='<s:property value="accountsetupgridlength"/>'/>

</form>



<div id="formulawindow">

   <div></div>

</div>



<div id="accountSearchwindow">

   <div></div>

</div>

<div id="costTypeSearchGridWindow">

<div></div>

</div> 

<div id="costCodeSearchWindow">

<div></div>

</div> 



</div>

</body>

</html>