<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
 <jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
form label.error {
    color: red;
    font-weight: bold;
    font-size: 15px;
}

.hidden-scrollbar {
    overflow: auto;
    height: 100vh;
}

body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 32px 0;
    min-height: 100vh;
    box-sizing: border-box;
    font-size: 15px;
    font-weight: 600;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 10px;
    max-width: 1400px;
    margin: 0 auto;
}

.receipt-header {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    margin-bottom: 16px;
    border-radius: 12px;
    padding: 0px 24px;
    font-size: 16px;
    font-weight: 700;
}

.receipt-header label {
    font-weight: 700;
    color: #333;
    margin-right: 8px;
    font-size: 16px;
}

.receipt-header input[type="text"] {
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 8px 12px;
    font-size: 15px;
    font-weight: 700;
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
    padding: 8px 18px;
    font-weight: 700;
    font-size: 15px;
    cursor: pointer;
    transition: background 0.2s;
}

.receipt-header button:hover {
    background: #0056b3;
}

#txtStatus {
    font-size: 1.5rem;
    font-weight: 700;
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
    font-size: 1.3em;
    font-weight: 700;
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
    font-weight: 700;
    font-size: 15px;
    color: #253858;
}

.section-block input[type="text"],
.section-block select {
    flex: 1;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 8px 12px;
    font-size: 15px;
    font-weight: 700;
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
    font-size: 1.3em;
    font-weight: 700;
}

.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #f9fafb;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 0 0 1px #eef0f6;
}

.cr-table th, 
.cr-table td {
    padding: 12px 14px;
    border-bottom: 1px solid #e4e7ec;
    text-align: left;
    font-size: 15px;
    font-weight: 700;
    vertical-align: middle;
}

.cr-table th {
    background: #eef0f6;
    color: #354B6A;
    font-weight: 700;
    font-size: 16px;
}

.cr-table tr:last-child td {
    border-bottom: none;
}

.cr-table input[type="text"],
.cr-table input[type="number"],
.cr-table select {
    font-size: 15px !important;
    font-weight: 700 !important;
    padding: 8px 10px;
    border: 1px solid #d1d5db;
    border-radius: 4px;
    box-sizing: border-box;
    vertical-align: middle;
}

.cr-table label {
    font-weight: 700 !important;
    font-size: 15px !important;
}

* {
    font-weight: 700 !important;
}

input[type="text"],
input[type="number"],
input[type="date"],
select,
textarea {
    font-size: 15px !important;
    font-weight: 700 !important;
    color: #222 !important;
}

label {
    font-weight: 700 !important;
    font-size: 15px !important;
}

h1, h2, h3, h4, h5, h6 {
    font-weight: 700 !important;
}

button,
input[type="button"],
input[type="submit"] {
    font-weight: 700 !important;
    font-size: 15px !important;
}

select option {
    font-size: 15px !important;
    font-weight: 700 !important;
    padding: 8px;
}

input::placeholder,
textarea::placeholder {
    font-weight: 600 !important;
    color: #666;
}

input[type="checkbox"] + label {
    font-size: 15px !important;
    font-weight: 700 !important;
}

#errormsg {
    font-size: 16px !important;
    font-weight: 700 !important;
    color: red;
}

#formdet {
    font-size: 16px !important;
    font-weight: 700 !important;
}

div, span, p, td, th {
    font-size: 15px !important;
    font-weight: 700 !important;
}

.cr-table td[align="right"] {
    vertical-align: middle;
    padding-right: 8px;
}

.cr-table td[align="left"] {
    vertical-align: middle;
    padding-left: 4px;
}
/* Add this CSS at the end of your <style> section */

/* Consistent table spacing */
.receipt-header table {
    margin-bottom: 2px;
}

/* Ensure all labels have consistent width and alignment */
.cr-table td[align="right"] {
    vertical-align: middle !important;
    padding-right: 10px !important;
    white-space: nowrap;
    min-width: 80px;
}

/* Ensure all input fields have consistent alignment */
.cr-table td[align="left"] {
    vertical-align: middle !important;
    padding-left: 5px !important;
}

/* Fix input field alignment */
.cr-table input[type="text"],
.cr-table select {
    vertical-align: middle !important;
    margin: 0 !important;
    display: inline-block;
}

/* Remove any extra spacing from divs */
.cr-table div {
    display: inline-block;
    vertical-align: middle;
}

/* Consistent row height */
.cr-table tr {
    height: 40px;
}

/* Fix for date picker divs */
#nipurchaseorderdate,
#deliverydate {
    display: inline-block !important;
    vertical-align: middle !important;
}

/* Label alignment */
.cr-table label {
    vertical-align: middle !important;
    display: inline-block;
    margin: 0 !important;
}

/* Remove default spacing from table cells */
.cr-table td {
    padding: 8px 10px !important;
}

/* Ensure consistent spacing between tables */
.receipt-header > table + table {
    margin-top: 2px;
}
.cr-table input[type="text"],
.cr-table input[type="number"],
.cr-table select {
    height: 35px !important;
    padding: 10px 12px !important;
    line-height: 1.5 !important;
}

/* Increase height for all input fields globally */
input[type="text"],
input[type="number"],
select,
textarea {
    height: 35px !important;
    padding: 10px 12px !important;
    line-height: 1.5 !important;
}

/* Adjust row height to accommodate taller inputs */
.cr-table tr {
    height: 50px !important;
}

/* Ensure date picker has same height */
.jqx-input {
    height: 35px !important;
    line-height: 35px !important;
}
/* Add this CSS - Specific styling ONLY for date fields */

/* Create a specific class for date container cells */
.date-field-cell {
    vertical-align: middle !important;
    padding: 8px 10px !important;
}

/* Style ONLY the date picker divs by their specific IDs */
#nipurchaseorderdate,
#deliverydate {
    height: 35px !important;
    line-height: 35px !important;
    font-size: 15px !important;
    font-weight: 700 !important;
    display: inline-block !important;
    vertical-align: middle !important;
    width: 125px !important;
}

/* Style jqx date input components */
#nipurchaseorderdate .jqx-input,
#deliverydate .jqx-input,
#nipurchaseorderdate .jqx-widget-content,
#deliverydate .jqx-widget-content {
    height: 35px !important;
    line-height: 35px !important;
    border: 1px solid #d1d5db !important;
    border-radius: 4px !important;
    background: #fff !important;
}

/* Style the input field inside date pickers */
#nipurchaseorderdate input,
#deliverydate input {
    
    font-weight: 500 !important;
    color: #222 !important;
    height: 33px !important;
    line-height: 33px !important;
    padding: 0 5px !important;
}

/* Style the calendar button */
#nipurchaseorderdate .jqx-action-button,
#deliverydate .jqx-action-button {
    height: 35px !important;
    line-height: 35px !important;
}

/* Style the calendar icon */
#nipurchaseorderdate .jqx-icon-calendar,
#deliverydate .jqx-icon-calendar {
    line-height: 35px !important;
}

</style>

<script type="text/javascript">


$(document).ready(function () { 
    
	   /* Date */ 	
    $("#nipurchaseorderdate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    $("#deliverydate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
	   $('#accountSearchwindow').jqxWindow('close');
	     
	     
		$('#typesearchwindow').jqxWindow({
			width : '25%',
			height : '58%',
			maxHeight : '70%',
			maxWidth : '45%',
			title : ' Search',
			position : {
				x : 700,
				y : 87
			},
			theme : 'energyblue',
			showCloseButton : true,
			keyboardCloseKey : 27
		});
		$('#typesearchwindow').jqxWindow('close');
		
		
		$('#txtproducttype').dblclick(function(){
			
			typeFormSearchContent('typeFormSearchGrid.jsp'); 
			
		}); 
    $('#puraccid').dblclick(function(){
    	//($("#mode").val() == "view")
    	if($('#mode').val()!= "view")
    		{
    	
    		
	  	    $('#accountSearchwindow').jqxWindow('open');
	  	
	  	  accountSearchContent('accountsDetailsFromGrid.jsp?');
    		}
  });   
    
  
});
function getaccountdetails(event){
 	 var x= event.keyCode;
   	
 	if($('#mode').val()!="view")
 		{
 		
 	 if(x==114){
 	  $('#accountSearchwindow').jqxWindow('open');
 	
 	 accountSearchContent('accountsDetailsFromGrid.jsp?');    }
 	 else{
 		 }
 		}
 	 }  
	  function accountSearchContent(url) {
       //alert(url);
          $.get(url).done(function (data) {
//alert(data);
        $('#accountSearchwindow').jqxWindow('setContent', data);

	}); 
    	}
	  function typeFormSearchContent(url) {
			$('#typesearchwindow').jqxWindow('open');
			$.get(url).done(function(data) {
				$('#typesearchwindow').jqxWindow('setContent', data);
				$('#typesearchwindow').jqxWindow('bringToFront');
			});
		}
		function getProdType(event){
			 var x= event.keyCode;
			 if(x==114){
				 typeFormSearchContent('typeFormSearchGrid.jsp');  	 }
			 else{
				 }
		      	 }
function funReset(){
	//$('#frmNipurchaseOrder')[0].reset(); 
}
function funReadOnly(){
	$('#frmNipurchaseOrder input').attr('readonly', true );
	$('#frmNipurchaseOrder select').attr('disabled', true );
	 $('#nipurchaseorderdate').jqxDateTimeInput({ disabled: true});
	 $('#deliverydate').jqxDateTimeInput({ disabled: true});
		$("#descdetailsGrid").jqxGrid({ disabled: true});
	  $('#cmbcurr').attr('disabled', true);
	 $('#acctype').attr('disabled', true);
	 $('#txtproducttype').attr('disabled', true);
	
}
function funRemoveReadOnly(){
	
	 funinterstate();
	$('#frmNipurchaseOrder input').attr('readonly', false );
	 $('#txtproducttype').attr('readonly', true);
	$('#frmNipurchaseOrder select').attr('disabled', false );
      $('#currate').attr('readonly', true);
	  $('#puraccid').attr('readonly', true);
	  $('#puraccname').attr('readonly', true);
	  
	 $('#nipurchaseorderdate').jqxDateTimeInput({ disabled: false});
	 $('#deliverydate').jqxDateTimeInput({ disabled: false});

	  $('#cmbcurr').attr('disabled', false);
	 $('#acctype').attr('disabled', false);
	 
	$('#docno').attr('readonly', true);
	$("#descdetailsGrid").jqxGrid({ disabled: false});

	
	if ($("#mode").val() == "A") {
		$('#nipurchaseorderdate').val(new Date());
		$('#deliverydate').val(new Date());
		 $("#descdetailsGrid").jqxGrid('clear');
		    $("#descdetailsGrid").jqxGrid('addrow', null, {});
			 $('#txtproducttype').attr('disabled', true);
			  document.getElementById("validates").value=0;
	   }
	
	  if($('#mode').val()=='E')
	   {
	   $("#descdetailsGrid").jqxGrid('addrow', null, {});
	   
	   }
	
	
	getCurrencyIds();
}
function funFocus(){
	 
   	$('#nipurchaseorderdate').jqxDateTimeInput('focus'); 	    		
}
function funNotify(){	
 
	
	
var purid= document.getElementById("puraccid").value;

if(purid=="")
	{
	 document.getElementById("errormsg").innerText=" Select An Account";
	 

	 return 0;
	   }
else
	   {
	   document.getElementById("errormsg").innerText="";
	   }
	   
	   
	   

if(parseInt(document.getElementById("validates").value)==1)
	{
	
    var txtproducttype= document.getElementById('txtproducttype').value;
	 
	 if(txtproducttype=="")
	 {
		 document.getElementById("errormsg").innerText=" Bill Type Is Required ";	
		 document.getElementById('txtproducttype').focus();
		 return 0;
	 }
	 
	
	}

	   
var refval= document.getElementById("nettotal").value;

if(refval=="")
	{
	 document.getElementById("errormsg").innerText="Net Amount Empty";
	 

	 return 0;
	   }
else
	   {
	   document.getElementById("errormsg").innerText="";
	   }

	 var rows = $("#descdetailsGrid").jqxGrid('getrows');
	    $('#descgridlenght').val(rows.length);
	   //alert($('#gridlength').val());
	   for(var i=0 ; i < rows.length ; i++){
	   // var myvar = rows[i].tarif; 
	    newTextBox = $(document.createElement("input"))
	       .attr("type", "dil")
	       .attr("id", "desctest"+i)
	       .attr("name", "desctest"+i)
	       .attr("hidden", "true"); 
	   
	   newTextBox.val(rows[i].srno+"::"+rows[i].qty+" :: "+rows[i].description+" :: "
			   +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].nuprice+" :: "+rows[i].taxper+"::"+rows[i].taxperamt+"::"+rows[i].taxamount+"::");
	
	// alert(newTextBox.val());
	   newTextBox.appendTo('form');
	  
	    //alert("ddddd"+$("#test"+i).val());
	    
	   }   
	
	return 1;
} 

function funChkButton() {
	

}

function funSearchLoad(){
	changeContent('mainsearch.jsp'); 
}
function getCurrencyIds(){
	   var x=new XMLHttpRequest();
	   x.onreadystatechange=function(){
	   if (x.readyState==4 && x.status==200)
	    {
	      items= x.responseText;
	     
	      items=items.trim().split('####');
	           var curidItems=items[0];
	           var curcodeItems=items[1];
	           var currateItems=items[2];
	           var multiItems=items[3];
	           var optionscurr = '';
	           
	           if(curcodeItems.indexOf(",")>=0){
	        	   curidItems=curidItems.split(",");
	            curcodeItems=curcodeItems.split(",");
	            currateItems=currateItems.split(",");
	           
	            for ( var i = 0; i < curcodeItems.length; i++) {
	           optionscurr += '<option value="' + curidItems[i] + '">' + curcodeItems[i] + '</option>';
	           }
	            $("select#cmbcurr").html(optionscurr);
	            //$("#currate").val(currateItems[0]);
	            funRoundRate(currateItems,"currate");
	        }
	   
	          else
	      {
	           optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
	           $("select#cmbcurr").html(optionscurr);
	         //  $("#currate").val(currateItems[0]);
	           
	       
	          funRoundRate(currateItems,"currate");
	        
	      
	          $('#currate').attr('readonly', true);
	       
	      }
	    }
	       }
	   x.open("GET","getCurrencyId.jsp?date="+document.getElementById("nipurchaseorderdate").value ,true);
		x.send();
	        
	      
	        }
	   
	   function getRatevalue(angel)
	   {
	   var x=new XMLHttpRequest();
	   x.onreadystatechange=function(){
	   if (x.readyState==4 && x.status==200)
	    {
	      var items= x.responseText;
	      
	      
	    /*      $('#currate').val(items) ; */
	         funRoundRate(items,"currate"); 
	        }
	          else
	      {
	      }
	       }
	   x.open("GET","getRateTo.jsp?curr="+a,true);
		x.send();
	        
	      
	        }
	   
	   
	   function combochange()
	   {
		   if($('#cmbcurrval').val()!="")
			  {
			  
			  
			  $('#cmbcurr').val($('#cmbcurrval').val());
			  }
		   if($('#acctypeval').val()!="")
			  {
			  
			  
			  $('#acctype').val($('#acctypeval').val());
			  }
			
	   }

	   function setValues() {
			if($('#hidnipurchaseorderdate').val()){
				$("#nipurchaseorderdate").jqxDateTimeInput('val', $('#hidnipurchaseorderdate').val());
			}
			
			if($('#hiddeliverydate').val()){
				$("#deliverydate").jqxDateTimeInput('val', $('#hiddeliverydate').val());
			}
		 	var dis=document.getElementById("masterdoc_no").value;
			if(dis>0)
				{     
				//alert("");
		 	 var indexval1 = document.getElementById("masterdoc_no").value;   
				
	     	  		 
	     	  	
	     	  		 $("#descdetail").load("descgridDetails.jsp?nipurdoc="+indexval1);
	     	  		
				 } 

				 if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  } 
				
    		combochange();
    		document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		    funSetlabel();
				//  getCurrencyId();
		} 
	   function funPrintBtn(){
	 	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	 	  
	 	   var url=document.URL;

	        var reurl=url.split("saveActionNipurOrder");
	        
	        $("#docno").prop("disabled", false);                
	        var brhid=<%= session.getAttribute("BRANCHID").toString()%>
		  	var dtype=$('#formdetailcode').val();
		  	
	  
	var win= window.open(reurl[0]+"printniphOrder?docno="+document.getElementById("masterdoc_no").value+"&brhid="+brhid+"&dtype="+dtype,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	     
	win.focus();
	 	   } 
	 	  
	 	   else {
		    	      $.messager.alert('Message','Select a Document....!','warning');
		    	      return false;
		    	     }
		    	
	 	}
	$(function(){
        $('#frmNipurchaseOrder').validate({
                rules: { 
              
                	delterms:{maxlength:200},
                	purdesc:{maxlength:200},
                	payterms:{maxlength:200},
                	/* refno:{required:true}, */
                	puraccid:{required:true}
                 },
                 messages: {
                	 delterms: {maxlength:"  Max 200 chars"},
                	 purdesc: {maxlength:"  Max 200 chars"},
                	 payterms: {maxlength:"  Max 200 chars"},
               /*  	 refno: {required:" * required"}, */
                	 puraccid: {required:" *"}
                 }
        });});
</script>
</head>
<body onLoad="getCurrencyIds();setValues();funinterstate();">


<div id="mainBG" class="homeContent hidden-scrollbar" data-type="background">
<form id="frmNipurchaseOrder" action="saveActionNipurOrder" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" />    
	<br/>

    <div class=' receipt-header'>
<table class="cr-table" width="100%">
  <tr>
   <td width="5%" align="right" style="vertical-align: middle;">Date</td> 
    <td width="10%" align="left" class="date-field-cell">
      <div id="nipurchaseorderdate" name="nipurchaseorderdate" value='<s:property value="nipurchaseorderdate"/>'></div>
      <input type="hidden" name="hidnipurchaseorderdate" id="hidnipurchaseorderdate" value='<s:property value="hidnipurchaseorderdate"/>'>
    </td>
    <td width="6%" align="right" style="vertical-align: middle;">Ref No</td>
    <td width="25%" align="left" style="vertical-align: middle;">
      <input type="text" name="refno" id="refno" value='<s:property value="refno"/>' style="width: 95%;">
    </td>
    <td width="6%" align="right" style="vertical-align: middle;">Doc No</td>
    <td width="15%" align="left" style="vertical-align: middle;">
      <input type="text" name="docno" id="docno" tabindex="-1" value='<s:property value="docno"/>' readonly="readonly" style="width: 95%;">
    </td>
  </tr>
</table>

<!-- Row 2: Vendor, Curr, Rate -->
<table class="cr-table" width="100%">
  <tr>
    <td width="5%" align="right" style="vertical-align: middle;">Vendor</td>
    <td width="35%" align="left" style="vertical-align: middle;"> 
      <input type="hidden" name="acctype" id="acctype" value='<s:property value="acctype"/>'>
      <input type="text" name="puraccid" id="puraccid" placeholder="Press F3 To Search" value='<s:property value="puraccid"/>' style="width:20%; vertical-align: middle;" onKeyDown="getaccountdetails(event);">  
      <input type="text" id="puraccname" name="puraccname" value='<s:property value="puraccname"/>' style="width:78%; vertical-align: middle;">
    </td>
    <td width="5%" align="right" style="vertical-align: middle;">Curr</td>
    <td width="10%" align="left" style="vertical-align: middle;">
      <select name="cmbcurr" id="cmbcurr" style="width:95%; vertical-align: middle;" value='<s:property value="cmbcurr"/>' onload="getRatevalue(this.value);">
        <option value="-1">--Select--</option>
      </select>
    </td>
    <td width="5%" align="right" style="vertical-align: middle;">Rate</td>
    <td width="10%" align="left" style="vertical-align: middle;">
      <input type="text" name="currate" id="currate" value='<s:property value="currate"/>' style="width: 95%; vertical-align: middle;">
    </td>
    <td width="30%" align="left"></td>
  </tr>
</table>

<!-- Row 3: Del Date, Del Terms, Bill Type -->
<table class="cr-table" width="100%">
  <tr>
   <td width="5%" align="right" style="vertical-align: middle;">Del Date</td>
    <td width="10%" align="left" class="date-field-cell">
      <div id="deliverydate" name="deliverydate" value='<s:property value="deliverydate"/>'></div>
      <input type="hidden" name="hiddeliverydate" id="hiddeliverydate" value='<s:property value="hiddeliverydate"/>'>
    </td>

    <td width="6%" align="right" style="vertical-align: middle;">Del Terms</td>
    <td width="40%" align="left" style="vertical-align: middle;">
      <input type="text" name="delterms" id="delterms" value='<s:property value="delterms"/>' style="width:95%; vertical-align: middle;">
    </td>
    <td width="6%" align="right" style="vertical-align: middle;">
      <label id="billtype">Bill Type</label>
    </td>
    <td width="25%" align="left" style="vertical-align: middle;">
      <input type="text" id="txtproducttype" name="txtproducttype" style="width: 95%; vertical-align: middle;" placeholder="Press F3 for Search" onKeyDown="getProdType(event);" value='<s:property value="txtproducttype"/>'/>
    </td>
  </tr>
</table>

<!-- Row 4: Pay Terms -->
<table class="cr-table" width="100%">
  <tr>
    <td width="5%" align="right" style="vertical-align: middle;">Pay Terms</td>
    <td width="95%" align="left" style="vertical-align: middle;">
      <input type="text" name="payterms" id="payterms" value='<s:property value="payterms"/>' style="width:97%; vertical-align: middle;">
    </td>
  </tr>
</table>

<!-- Row 5: Description -->
<table class="cr-table" width="100%">
  <tr>
    <td width="5%" align="right" style="vertical-align: middle;">Description</td>
    <td width="95%" align="left" style="vertical-align: middle;">
      <input type="text" name="purdesc" id="purdesc" value='<s:property value="purdesc"/>' style="width:97%; vertical-align: middle;">
    </td>
  </tr>
</table>


 <br>

 
    <div class="cr-table" id="descdetail" ><jsp:include page="descgridDetails.jsp"></jsp:include></div>
     

<input type="hidden" id="masterdoc_no" name="masterdoc_no"  value='<s:property value="masterdoc_no"/>'/>
           <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
             <input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>   
             
             <input type="hidden" id="nettotal" name="nettotal"  value='<s:property value="nettotal"/>'/>   
             
              <input type="hidden" id="descgridlenght" name="descgridlenght"  value='<s:property value="descgridlenght"/>'/>    
         <input type="hidden" id="cmbcurrval" name="cmbcurrval"  value='<s:property value="cmbcurrval"/>'/>    
          <input type="hidden" id="acctypeval" name="acctypeval"  value='<s:property value="acctypeval"/>'/>  
           <input type="hidden" id="accdocno" name="accdocno"  value='<s:property value="accdocno"/>'/>    
            <input type="hidden" id="validates" name="validates"  value='<s:property value="validates"/>'/> 
           <input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
           
           
                    <input type="hidden" id="taxpers" name="taxpers"  value='<s:property value="taxpers"/>'/>
                   <input type="hidden" id="taxaccount" name="taxaccount"  value='<s:property value="taxaccount"/>'/>
                     <input type="hidden" id="hideproducttype" name="hideproducttype"  value='<s:property value="hideproducttype"/>'/>
            
            
    </div>
</form>
  <div id="accountSearchwindow">
	   <div ></div>
	</div>
	<div id="typesearchwindow">
			<div></div>
			 
		</div>
</div>
</body>
</html>