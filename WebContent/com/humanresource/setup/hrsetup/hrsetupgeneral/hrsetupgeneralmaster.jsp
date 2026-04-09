<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath(); %>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
SCOPED UI: Bulletproof Table Layout (Does NOT affect header.jsp)
========================================================= */

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 10px 20px;
    box-sizing: border-box;
}

.modern-ui .erp-form-area {
    background-color: #f4f7fb;
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    padding: 15px 10px;
    margin-bottom: 10px;
    min-width: 1050px; 
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui select { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

.modern-ui td {
    padding: 4px 5px;
    vertical-align: middle;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Split Section Styling */
.modern-ui .section-title {
    font-size: 13px;
    font-weight: bold;
    color: #0056b3;
    margin-bottom: 10px;
    border-bottom: 1px solid #c5d3e0;
    padding-bottom: 3px;
}

/* Checkbox Group Styling */
.modern-ui .checkbox-group {
    display: flex;
    align-items: center;
    gap: 8px;
    background: #fff;
    border: 1px solid #d1d5db;
    border-radius: 4px;
    padding: 3px 8px;
}

.modern-ui .checkbox-group label {
    font-weight: bold;
    color: #444;
    cursor: pointer;
    margin-right: 5px;
}

/* Data Grid Container */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    overflow: hidden;
    background: #fff;
    margin-bottom: 10px;
}

form label.error {
    color: red;
    font-weight: bold;
    font-size: 11px;
}

/* RESTORED: Scrollbar logic strictly for the form content area */
.hidden-scrollbar { 
    overflow-y: auto; 
    height: 80vh; 
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 0px; }
</style>

<script type="text/javascript">

 $(document).ready(function () {
        if(document.getElementById("formdet")) document.getElementById("formdet").innerText="HR Setup(HRS)";
		if(document.getElementById("formdetail")) document.getElementById("formdetail").value="HR Setup";
		if(document.getElementById("formdetailcode")) document.getElementById("formdetailcode").value="HRS";
		if(window.parent && window.parent.formCode) window.parent.formCode.value="HRS"; 
		if(window.parent && window.parent.formName) window.parent.formName.value="HR Setup";
		
        /* COMPACT DATE/TIME SIZING (120px) */
 	 	$("#masterdate").jqxDateTimeInput({ width: '120px', height: '24px', formatString:"dd.MM.yyyy"});   
 	 	$("#validfromdate").jqxDateTimeInput({ width: '120px', height: '24px', formatString:"dd.MM.yyyy"});   
 	    $("#lastreviseddate").jqxDateTimeInput({ width: '120px', height: '24px', formatString:"dd.MM.yyyy"});   
 	 	$("#workingtime").jqxDateTimeInput({ width: '120px', height: '24px', formatString:'HH:mm', showCalendarButton: false}); 
 	 	
        /* Force internal alignment AFTER render */
        setTimeout(function () {
            $(".jqx-datetimeinput").find("input").css({
                "margin-top": "0px", 
                "line-height": "24px", 
                "font-size": "12px", 
                "font-family": "Arial, sans-serif",
                "padding": "0 6px", 
                "box-sizing":"border-box"
            });
            $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
        }, 0);
 	 
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
    
    /* SAFE READONLY FUNCTION */
	function funReadOnly(){
	    try {
    		$('#masterdate').jqxDateTimeInput({ disabled: true});
    	    $('#validfromdate').jqxDateTimeInput({ disabled: true});
    	    $('#lastreviseddate').jqxDateTimeInput({ disabled: true});
    	    $('#workingtime').jqxDateTimeInput({ disabled: true});
    		$('#frmhrsetups input').attr('readonly', true );
    		$('#frmhrsetups select').attr('disabled', true);
    	    $('#mon, #tue, #wed, #thu, #fri, #sat, #sun').attr('disabled', true);
    	    $('#leaveid').attr('disabled', true);
    	    $('#cmbcategory').attr('disabled', true);
    	    $('#carryforward').attr('disabled', true);
	    } catch(e) { console.error("Error in funReadOnly: ", e); }
	}
	
	/* SAFE REMOVE READONLY FUNCTION */
	function funRemoveReadOnly(){
	    try {
    		$('#masterdate').jqxDateTimeInput({ disabled: false});
    	    $('#validfromdate').jqxDateTimeInput({ disabled: false});
    	    $('#lastreviseddate').jqxDateTimeInput({ disabled: false});
    	    $('#workingtime').jqxDateTimeInput({ disabled: false});
    		$('#frmhrsetups input').attr('readonly', false );
    		$('#frmhrsetups select').attr('disabled', false);
    	    $('#mon, #tue, #wed, #thu, #fri, #sat, #sun').attr('disabled', false);
    	    $('#leaveid').attr('disabled', false);
    	    $('#cmbcategory').attr('disabled', false);
    	    $('#carryforward').attr('disabled', false);
    	    $('#convformula').attr('readonly', true );
    	    $('#normalrate').attr('readonly', true );
    	    $('#ot').attr('readonly', true );
    	    $('#holidayot').attr('readonly', true );
    	    
    		 if ($("#mode").val() == "A") {
          		 if($("#termibeni").length) $("#termibeni").load("terminationbenefitcondtiongrid.jsp");
          		 if($("#resiggrid").length) {
          		     $("#resiggrid").jqxGrid('clear');
        		     $("#resiggrid").jqxGrid('addrow', null, {});
        		     $("#resiggrid").jqxGrid('addrow', null, {});
        		     $("#resiggrid").jqxGrid('addrow', null, {});
        		     $("#resiggrid").jqxGrid('addrow', null, {});
        		     $("#resiggrid").jqxGrid({ disabled: false}); 
          		 }
          		 if($("#trmigrid").length) {
        		     $("#trmigrid").jqxGrid('clear');
        		     $("#trmigrid").jqxGrid('addrow', null, {});
        		     $("#trmigrid").jqxGrid('addrow', null, {});
        		     $("#trmigrid").jqxGrid('addrow', null, {});
        		     $("#trmigrid").jqxGrid('addrow', null, {});
        		     $("#trmigrid").jqxGrid({ disabled: false}); 
          		 }
          	     if($("#accset").length) $("#accset").load("accountsetupgrid.jsp"); 
    		 }
    		
    		 if ($("#mode").val() == "E") {
                 if($("#resiggrid").length) {
                     $("#resiggrid").jqxGrid({ disabled: false}); 
                     $("#resiggrid").jqxGrid('addrow', null, {});
                 }
    			 if($("#trmigrid").length) {
    			     $("#trmigrid").jqxGrid({ disabled: false}); 
    			     $("#trmigrid").jqxGrid('addrow', null, {});
    			 }
    			 if($("#accountsetup").length) $("#accountsetup").jqxGrid({ disabled: false}); 
    			 
    			 var docVal1 = document.getElementById("docno") ? document.getElementById("docno").value : 0;
    			 if($("#termibeni").length) $("#termibeni").load("terminationbenefitcondtiongrid.jsp?docno="+docVal1+"&modeval="+"E");
    		 }
	    } catch(e) { console.error("Error in funRemoveReadOnly: ", e); }
	}
 
	function funNotify(){	
		  var z=0;
		  if($("#benifitsgrid").length) {
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
		  }
	   
	    if($("#trmigrid").length) {
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
	    }
	   
	    if($("#resiggrid").length) {
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
	    }
	    
	    if($("#accountsetup").length) {
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
	
	/* SAFE SET VALUES FUNCTION */
	function setValues() {
	    try {
    		if($('#hidmasterdate').length && $('#hidmasterdate').val()){
    			$("#masterdate").jqxDateTimeInput('val', $('#hidmasterdate').val());
    		}
    		   
    		if($('#hidvalidfromdate').length && $('#hidvalidfromdate').val()){
    			$("#validfromdate").jqxDateTimeInput('val', $('#hidvalidfromdate').val());
    		}
    		   
    		if($('#hidlastreviseddate').length && $('#hidlastreviseddate').val()){
    			$("#lastreviseddate").jqxDateTimeInput('val', $('#hidlastreviseddate').val());
    		}
    		   
    		if($('#hidworkingtime').length && $('#hidworkingtime').val()){
    			$("#workingtime").jqxDateTimeInput('val', $('#hidworkingtime').val());
    		}
    		   
         	if($('#msg').length && $('#msg').val()!=""){
        		   $.messager.alert('Message',$('#msg').val());
        	}
         	
         	  var docVal1 = document.getElementById("docno") ? document.getElementById("docno").value : 0;
         	  if(docVal1>0) {
         		 if($("#termibeni").length) $("#termibeni").load("terminationbenefitcondtiongrid.jsp?docno="+docVal1);
         	     if($("#trimi").length) $("#trimi").load("terminationdetailsgrid.jsp?docno="+docVal1);
         	     if($("#resig").length) $("#resig").load("resignationdetailsgrid.jsp?docno="+docVal1);
         	     if($("#accset").length) $("#accset").load("accountsetupgrid.jsp?docno="+docVal1);
         	  }
         	
         	  if(document.getElementById("hidweakoff")) {
             	   var weakoff= document.getElementById("hidweakoff").value; 
             	   if(weakoff!="") {
               		var arr = weakoff.split(",");
               		for(var i=0;i<=arr.length-1;i++) {
        	           		if(arr[i]=='1') { document.getElementById("mon").checked = true; document.getElementById("mon").value=1; }
        	           		if(arr[i]=='2') { document.getElementById("tue").checked = true; document.getElementById("tue").value=1; }
        	           		if(arr[i]=='3') { document.getElementById("wed").checked = true; document.getElementById("wed").value=1; }
            	       		if(arr[i]=='4') { document.getElementById("thu").checked = true; document.getElementById("thu").value=1; }
               			    if(arr[i]=='5') { document.getElementById("fri").checked = true; document.getElementById("fri").value=1; }
               			    if(arr[i]=='6') { document.getElementById("sat").checked = true; document.getElementById("sat").value=1; }
               			    if(arr[i]=='7') { document.getElementById("sun").checked = true; document.getElementById("sun").value=1; }
               		}
             		 }
         	  }
    
         	  if(document.getElementById("hidcarryforward")) {
             	var carryforward=document.getElementById("hidcarryforward").value;
             	if(parseInt(carryforward)==1) {
             	 	document.getElementById("carryforward").checked = true;
            		document.getElementById("carryforward").value=1;
             	} else {
             	 	document.getElementById("carryforward").checked = false;
            		document.getElementById("carryforward").value=0;
             	}
         	  }
         	  
            if (document.getElementById("formdet") && $('#formdetail').length && $('#formdetailcode').length) {
                 var detailVal = $('#formdetail').val() || "";
                 var codeVal = $('#formdetailcode').val() || "";
                 document.getElementById("formdet").innerText = detailVal + " (" + codeVal.trim() + ")";
            }
	    } catch(e) { console.error("Error in setValues: ", e); }
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
				
				  if ($('#hidcatval').length && $('#hidcatval').val() != null) {
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
				
				  if ($('#hidleaveid').length && $('#hidleaveid').val() != null) {
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

</head>
<body onload="termConfig();setValues();">

<div class="homeContent" data-type="background">
<form id="frmhrsetups" action="saveHrsetup" autocomplete="OFF" >
    <jsp:include page="../../../../../header.jsp"></jsp:include>

    <div class="modern-ui hidden-scrollbar">

        <div class="erp-form-area" style="margin-bottom: 10px;">
            <table width="100%" border="0" cellspacing="0" cellpadding="2">
                <tr>
                    <td class="lbl-right" width="8%">Date</td>
                    <td width="15%">
                        <div id='masterdate' name='masterdate' value='<s:property value="masterdate"/>'></div>
                    </td>
                    <td class="lbl-right" width="10%">Doc No</td>
                    <td width="20%">
                        <input type="text" id="docno" name="docno" tabindex="-1" readonly value='<s:property value="docno"/>' style="width: 150px;" />
                    </td>
                    <td width="47%"></td> </tr>
            </table>
        </div>

        <div class="erp-form-area">
            <div class="section-title">For Days in Year</div>
            <table width="100%" border="0" cellspacing="0" cellpadding="2">
                <tr>
                    <td class="lbl-right" width="10%">Valid From</td> 
                    <td width="15%">
                        <div id='validfromdate' name='validfromdate' value='<s:property value="validfromdate"/>'></div>
                    </td>
                    <td class="lbl-right" width="12%">Last Revised On</td>
                    <td width="15%">
                        <div id='lastreviseddate' name='lastreviseddate' value='<s:property value="lastreviseddate"/>'></div>
                    </td>
                    <td class="lbl-right" width="12%">Payroll Category</td>
                    <td width="20%">
                        <select name="cmbcategory" id="cmbcategory" value='<s:property value="cmbcategory"/>'>
                            <option value="">-- select -- </option>
                        </select>
                    </td>
                    <td class="lbl-right" width="12%">Working Hrs/Day</td>
                    <td width="4%">
                        <div id='workingtime' name='workingtime' value='<s:property value="workingtime"/>'></div>
                    </td>
                </tr>

                <tr>
                    <td class="lbl-right">Annual Leave ID</td>
                    <td>
                        <select name="leaveid" id="leaveid" value='<s:property value="leaveid"/>'>
                            <option value="">-- select --</option>
                        </select>
                    </td>
                    <td class="lbl-right">Weekly Off</td>
                    <td colspan="4">
                        <div class="checkbox-group">
                            <input type="checkbox" id="mon" name="mon" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)"><label for="mon">Mon</label>
                            <input type="checkbox" id="tue" name="tue" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)"><label for="tue">Tue</label>
                            <input type="checkbox" id="wed" name="wed" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)"><label for="wed">Wed</label>
                            <input type="checkbox" id="thu" name="thu" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)"><label for="thu">Thu</label>
                            <input type="checkbox" id="fri" name="fri" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)"><label for="fri">Fri</label>
                            <input type="checkbox" id="sat" name="sat" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)"><label for="sat">Sat</label>
                            <input type="checkbox" id="sun" name="sun" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)"><label for="sun">Sun</label>
                        </div>
                    </td>
                    <td align="right"> 
                        <div class="checkbox-group" style="justify-content: center; background: transparent; border: none;">
                            <input type="checkbox" id="carryforward" name="carryforward" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                            <label for="carryforward">Carry Forward</label>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td class="lbl-right">Eligible Days</td>
                    <td>
                        <input type="text" id="eligibledays" name="eligibledays" onkeypress="javascript:return isNumber (event)" value='<s:property value="eligibledays"/>'>
                    </td>
                    <td class="lbl-right">In a Year</td>
                    <td colspan="5">
                        <input type="text" id="forworkingdays" name="forworkingdays" onkeypress="javascript:return isNumber (event)" value='<s:property value="forworkingdays"/>'>
                    </td>
                </tr>
            </table>
        </div>

        <div class="erp-form-area hideterm" id="fs1" style="margin-bottom: 10px;">
            <div class="section-title">Terminal Benefits & Details</div>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="60%" valign="top" style="padding-right: 15px;">
                        <div class="grid-container" id="termibeni"> 
                            <jsp:include page="terminationbenefitcondtiongrid.jsp"></jsp:include>
                        </div>
                    </td>
                    <td width="40%" valign="top">
                        <div class="section-title" style="font-size: 11px; margin-bottom: 5px;">Termination Details</div>
                        <div class="grid-container" id="trimi"> 
                            <jsp:include page="terminationdetailsgrid.jsp"></jsp:include>
                        </div>
                        
                        <div class="section-title" style="font-size: 11px; margin-bottom: 5px; margin-top: 15px;">Resignation Details</div>
                        <div class="grid-container" id="resig"> 
                            <jsp:include page="resignationdetailsgrid.jsp"></jsp:include>
                        </div>
                    </td>
                </tr>
            </table>
        </div>

        <div class="erp-form-area" id="fs2" style="margin-bottom: 10px;">
            <div class="section-title">Salary Calculation Formula (Hrs)</div>
            <table width="100%" border="0" cellspacing="0" cellpadding="2">
                <tr>
                    <td class="lbl-right" width="20%">Conv Formula (Month To Day)</td>
                    <td width="30%">
                        <input type="text" id="convformula" readonly="readonly" placeholder="Press F3 To Search" name="convformula" value='<s:property value="convformula"/>' onkeydown="getconfor(event);">
                    </td> 
                    <td class="lbl-right" width="20%">Rate per Hour</td>
                    <td width="30%">
                        <input type="text" id="normalrate" name="normalrate" readonly="readonly" placeholder="Press F3 To Search" value='<s:property value="normalrate"/>' onkeydown="getnr(event);" > 
                    </td> 
                </tr>
                <tr>
                    <td class="lbl-right">OT</td>
                    <td>
                        <input type="text" id="ot" name="ot" readonly="readonly" placeholder="Press F3 To Search" value='<s:property value="ot"/>' onkeydown="getot(event);" > 
                    </td> 
                    <td class="lbl-right">Holiday OT</td>
                    <td>
                        <input type="text" id="holidayot" name="holidayot" readonly="readonly" placeholder="Press F3 To Search" value='<s:property value="holidayot"/>' onkeydown="getholyot(event);"> 
                    </td> 
                </tr>
            </table>
        </div>
        
        <div class="erp-form-area" id="fs3" style="margin-bottom: 10px;">
            <div class="section-title">Account Setup</div>
            <div class="grid-container" id="accset"> 
                <jsp:include page="accountsetupgrid.jsp"></jsp:include>
            </div>
        </div>

        <div style="display:none;">
            <input type="hidden" id="hidmasterdate" name="hidmasterdate" value='<s:property value="hidmasterdate"/>'/>
            <input type="hidden" id="hidvalidfromdate" name="hidvalidfromdate" value='<s:property value="hidvalidfromdate"/>'/>
            <input type="hidden" id="hidlastreviseddate" name="hidlastreviseddate" value='<s:property value="hidlastreviseddate"/>'/>
            <input type="hidden" id="hidworkingtime" name="hidworkingtime" value='<s:property value="hidworkingtime"/>'/>
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
            
            <input type="hidden" id="formdetail" name="formdetail" value='<s:property value="formdetail"/>'/>
            <input type="hidden" id="formdetailcode" name="formdetailcode" value='<s:property value="formdetailcode"/>'/>
        </div>

    </div>
</form>

<div id="formulawindow"><div></div></div>
<div id="accountSearchwindow"><div></div></div>
<div id="costTypeSearchGridWindow"><div></div></div> 
<div id="costCodeSearchWindow"><div></div></div> 

</div>
</body>
</html>