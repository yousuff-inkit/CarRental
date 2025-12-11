<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>GatewayERP(i)</title>
	 <jsp:include page="../../../../includes.jsp"></jsp:include> 
	 <style>
    /* ------------------------------
       GLOBAL STYLES & LAYOUT (From Master)
    ------------------------------ */
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
        padding: 20px; /* Increased padding slightly for better look */
        max-width: 1450px; /* Increased max width to accommodate dual columns better */
        margin: auto;
        box-shadow: 0 4px 24px rgba(0,0,0,0.06);
        /* FORCE HEADER LEFT ALIGNMENT */
        text-align: left !important;
    }

    /* ------------------------------
       HEADER FIXES (Title & Buttons) (From Master)
    ------------------------------ */
    center {
        text-align: left !important;
        display: block;
        width: 100%;
        margin-left: 0;
    }

    #formdet {
        font-size: 24px !important;
        font-weight: 700 !important;
        color: #2c3e50;
        margin-bottom: 15px;
        display: block;
        text-align: left !important;
        font-family: 'Segoe UI', sans-serif;
    }
    
    /* Ensure the include content starts aligned */
    .receipt-header {
        display: block;
        padding: 0 0 0 5px;
    }

    /* ------------------------------
       GRID SYSTEM (FORM LAYOUT) (From Master)
    ------------------------------ */
    .form-group {
        display: grid;
        grid-template-columns: 120px 1fr;
        align-items: center;
        gap: 12px;
        margin-bottom: 12px;
    }

    .form-group.dual-input {
        grid-template-columns: 120px 1fr 120px 1fr;
    }

    .form-group.single-label-dual-input {
        grid-template-columns: 120px 1fr 1fr;
    }
    
    .form-group.checkbox-group {
        grid-template-columns: 120px 1fr;
        align-items: center;
    }


    .section-row {
        display: flex;
        gap: 26px;
        margin-bottom: 30px;
        flex-wrap: wrap;
    }

    .section-block {
        flex: 1;
        background: #f6f8fa; /* Uniform background color */
        border-radius: 12px;
        padding: 20px;
        box-shadow: 0 1px 8px rgba(160,177,217,0.1);
        min-width: 45%;
    }

    .full-width-block {
        flex: 1 1 100%;
    }

    .section-block h2, .section-block h3, .fieldset-legend-replacement {
        font-size: 1.1rem;
        font-weight: 600;
        margin: 0 0 20px;
        padding-left: 10px;
        border-left: 4px solid #007bff;
        color: #333;
        display: block;
        border-radius: 0; /* Ensure straight line */
    }
    
    .fieldset-legend-replacement {
        background: none;
        padding: 0 0 0 10px;
        margin-bottom: 10px;
    }


    /* ------------------------------
       INPUTS & CONTROLS (From Master)
    ------------------------------ */
    input[type="text"], input[type="email"], select, textarea {
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

    input[type="text"]:focus, input[type="email"]:focus, select:focus, textarea:focus {
        border-color: #007bff;
        outline: none;
    }

    input[readonly], textarea[readonly] {
        background-color: #f3f4f6;
        color: #6b7280;
    }

    label {
        font : Tahoma;
        font-weight: 600;
        color: #253858;
        white-space: nowrap;
        text-align: right;
        padding-right: 10px;
        font-size: 16px;
    }
    
    /* Specific styling for the checkbox/label inside Depr section */
    .checkbox-label {
        text-align: left !important;
        padding-left: 10px;
        font-weight: 400;
        display: flex;
        align-items: center;
        gap: 5px;
    }
    .checkbox-label input[type="checkbox"] {
        width: auto !important;
        height: auto !important;
        margin: 0;
    }

    /* ------------------------------
       TABLES & UTILS
    ------------------------------ */

    /* SCROLLBAR FIX */
    .hidden-scrollbar { 
        overflow: auto; 
        height: 530px; 
        padding: 0;
    }
    .hidden-scrollbar::-webkit-scrollbar { width: 0px; }

</style>
</head>

<script type="text/javascript">

$(document).ready(function () {
	 //alert(document.getElementById("deleted").value);
  	 $("#masterdate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});    
  	 $("#purchasedate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});  
  	 
	 $("#warexpdate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});  

	 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '60%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#accountDetailsWindow').jqxWindow('close');
	 
	 $('#fixaccountDetailsWindow').jqxWindow({width: '51%', height: '60%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#fixaccountDetailsWindow').jqxWindow('close');
	 
	// $("#btnEdit").attr('disabled', true );
	 
	    $('#supplieraccId').dblclick(function(){
	    	   if($('#mode').val()=="A" || $('#mode').val()=="E" )
		          {
		          
		  	    $('#accountDetailsWindow').jqxWindow('open');
		  	
		  	  accountSearchContent('accountsDetailsSearch.jsp');
		          }
	  }); 
	    
	    $('#masterdate').on('change', function (event) {
	  	  
	        var maindate = $('#masterdate').jqxDateTimeInput('getDate');
	      	 if ($("#mode").val() == "A" || $("#mode").val() == "E") {   
	        funDateInPeriod(maindate);
	      	 }
	       });
	    
	    $('#fixedassetaccId').dblclick(function(){
	    	   if($('#mode').val()=="A" || $('#mode').val()=="E" )
		          {
		        
		  	    $('#fixaccountDetailsWindow').jqxWindow('open');
		  	
		  	  accountSearchContent1('depaccountsDetailsSearch.jsp?value='+1);
		          }
	  }); 
	    $('#accdepraccId').dblclick(function(){
	    	   if($('#mode').val()=="A" || $('#mode').val()=="E" )
		          {
		          
		  	    $('#fixaccountDetailsWindow').jqxWindow('open');
		  	
		  	  accountSearchContent1('depaccountsDetailsSearch.jsp?value='+2);
		          }
	  }); 
	    $('#depraccId').dblclick(function(){
	    	   if($('#mode').val()=="A" || $('#mode').val()=="E" )
		          {
		          
		  	    $('#fixaccountDetailsWindow').jqxWindow('open');
		  	
		  	  accountSearchContent1('depaccountsDetailsSearch.jsp?value='+3);
		          }
	  }); 
	 
		  $('#purchasedate').on('change', function (event) {
		      	 if ($("#mode").val() == "A" || $("#mode").val() == "E") {   
			   var purchsedate=new Date($('#purchasedate').jqxDateTimeInput('getDate'));     // out date
			  var masterdate=new Date($('#masterdate').jqxDateTimeInput('getDate')); //del date
			  
			   if(purchsedate>masterdate){
			   document.getElementById("errormsg").innerText="Purchase Date Cannot be Greater Than Document Date";
			   $('#purchasedate').jqxDateTimeInput('focus'); 
			   return false;
			  }   
			
			   else{
			  
			   document.getElementById("errormsg").innerText="";  
			   }
			  }
		
		       });
  	 
});


function getaccountdetails1(value){
	
	  if($('#mode').val()=="A" || $('#mode').val()=="E" )
    {
	 var x= event.keyCode;
	 if(x==114){
	  $('#fixaccountDetailsWindow').jqxWindow('open');
	 accountSearchContent1('depaccountsDetailsSearch.jsp?value='+value);    }
	 else{
		 }
    }
	 }  
	 
	 
function getaccountdetails(event){
	
	  if($('#mode').val()=="A" || $('#mode').val()=="E" )
  {
	 var x= event.keyCode;
	 if(x==114){
	  $('#accountDetailsWindow').jqxWindow('open');
	
	 accountSearchContent('accountsDetailsSearch.jsp');    }
	 else{
		 }
  }
	 }  
	 
	 
function accountSearchContent1(url) {

    $.get(url).done(function (data) {

  $('#fixaccountDetailsWindow').jqxWindow('setContent', data);

	}); 
	}
	 
function accountSearchContent(url) {

       $.get(url).done(function (data) {

     $('#accountDetailsWindow').jqxWindow('setContent', data);

	}); 
 	}

function funReset(){


}


function funReadOnly(){ 	 
	
	 
	$('#frmassetmastrer input').attr('readonly',true);   
	$('#frmassetmastrer select').attr('disabled',true);  
	$('#warexpdate').jqxDateTimeInput({ disabled: true});
	$('#masterdate').jqxDateTimeInput({ disabled: true});
	$('#purchasedate').jqxDateTimeInput({ disabled: true});
	$('#subgriddis').attr('disabled',true); 
	$('#opening').attr('disabled',true); 
	
	//subgriddis opening
	
}
function funRemoveReadOnly(){
	$('#frmassetmastrer input').attr('readonly',false);  
	$('#frmassetmastrer select').attr('disabled',false); 
	$('#subgriddis').attr('disabled',false); 
	$('#opening').attr('disabled',false); 
	$('#accumdepr').attr('disabled',true); 
	$('#docno').attr('readonly',true);  
	$('#warexpdate').jqxDateTimeInput({ disabled: false});
	$('#masterdate').jqxDateTimeInput({ disabled: false});
	$('#purchasedate').jqxDateTimeInput({ disabled: false});
	
	$('#fixedassetaccId').attr('readonly',true);  
	$('#accdepraccId').attr('readonly',true);  
	$('#depraccId').attr('readonly',true);  
	
	$('#fixedassetaccName').attr('readonly',true);  
	$('#accdepraccIdName').attr('readonly',true);  
	$('#accdepraccIdName').attr('readonly',true); 
	 // accdepraccId depraccId
	
	 $('#supplieraccId').attr('readonly',true);  
	 $('#supplieraccName').attr('readonly',true);  
	   
	
	if ($("#mode").val() == "A") {
		
		
		$('#subdetail').hide();
		$('#freespace').show();
		$('#accumdepr').attr('disabled',true); 
		
		
		 $('#warexpdate').val(new Date());
		 $('#masterdate').val(new Date());
		 $('#purchasedate').val(new Date());
	     $("#jqxsubdetails").jqxGrid('clear');
	    $("#jqxsubdetails").jqxGrid('addrow', null, {});
	    $("#jqxsubdetails").jqxGrid('addrow', null, {});
	    $("#jqxsubdetails").jqxGrid('addrow', null, {});
	    
		document.getElementById("masteredit").value="";
	   }
	
	
	if($('#mode').val()=='E')
	{
				if(document.getElementById("openingval").value==1)
				{
				document.getElementById("opening").checked =true;
				$('#accumdepr').attr('disabled',false); 
				$('#accumdepr').attr('readonly',false);
					
				
				}
			else
				{
				document.getElementById("opening").checked =false;
				$('#accumdepr').attr('disabled',true); 
				
				}
				
				var rows = $('#jqxsubdetails').jqxGrid('getrows');
		         var rowlength= rows.length;
		         if (rowlength == 0) {
		             
		             $("#jqxsubdetails").jqxGrid('addrow', null, {});	
		             $("#jqxsubdetails").jqxGrid('addrow', null, {});	
		             $("#jqxsubdetails").jqxGrid('addrow', null, {});	
		             }	
		         else
		        	 {
		        	 $("#jqxsubdetails").jqxGrid('addrow', null, {});	
		        	 }
				
			funchkforedit(document.getElementById("srno").value);	
				
				
				
	}
	
	
	if($('#mode').val()=='D')
		{
		
		$('#frmassetmastrer input').attr('readonly',false);  
		$('#frmassetmastrer select').attr('disabled',false); 
		$('#warexpdate').jqxDateTimeInput({ disabled: false});
		$('#masterdate').jqxDateTimeInput({ disabled: false});
		$('#purchasedate').jqxDateTimeInput({ disabled: false});
		$('#accumdepr').attr('disabled',false); 
		
		funchkfordel(document.getElementById("srno").value);	
		funReadOnly();
		exit();
	

	
       }
function funchkfordel(srno)
{


	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();	
			if(parseInt(items)>0)
				{
				$.messager.alert('Message',' Transaction Already Exists','warning');  
return 0;
	
				
				}
			else
				{
				$('#frmassetmastrer').submit(); 
				
				
				}
		  
			
			
			
		} else {
			
		}
	}
	x.open("GET", "geteditcasechk.jsp?srno="+document.getElementById("srno").value, true);
	x.send();
	
	}
	


}
function fundeleterestriction()
{
	//alert(1)
var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();	
			if(parseInt(items)>0)
				{
				 $('#btnDelete').attr('disabled',true); 
				
				}
			else
				{
				 $('#btnDelete').attr('disabled',false); 
				}
		 } else {
		}
	}
	x.open("GET", "getdeleterestriction.jsp?srno="+document.getElementById("srno").value, true);
	x.send();
}
function funchkforedit(srno)
    {
	

	
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();	
				if(parseInt(items)>0)
					{
					
					document.getElementById("masteredit").value="master";
					
					 //supplieraccId  totalpuchvalue opening accumdepr  fixedassetaccId accdepraccId depraccId
					 $('#supplieraccId').attr('disabled',true); 
					 $('#totalpuchvalue').attr('disabled',true); 
					 $('#opening').attr('disabled',true); 
					 $('#accumdepr').attr('disabled',true); 
					 $('#fixedassetaccId').attr('disabled',true); 
					 $('#accdepraccId').attr('disabled',true); 
					 $('#depraccId').attr('disabled',true); 
					 
					 
					 
					}
				else
					{
					document.getElementById("masteredit").value="do";
					}
			  
				
				
				
			} else {
			}
		}
		x.open("GET", "geteditcasechk.jsp?srno="+srno, true);
		x.send();
	
	
	}


function funNotify(){	
	 if(document.getElementById("lifetimeyear").value==0)
	 {
    	document.getElementById("errormsg").innerText="Life time Year cannot be 0";  
    	document.getElementById("lifetimeyear").focus();
    	return 0;
	 }
	 if(document.getElementById("depper").value==0)
	 {
    	document.getElementById("errormsg").innerText="Depreciation % cannot be 0";     
    	document.getElementById("depper").focus();
    	return 0;
	 }
	var maindate = $('#masterdate').jqxDateTimeInput('getDate');
	   var validdate=funDateInPeriod(maindate);
	   if(validdate==0){
	   return 0; 
	   }
	   	   
			 var purchsedate=new Date($('#purchasedate').jqxDateTimeInput('getDate'));    
			 var masterdate=new Date($('#masterdate').jqxDateTimeInput('getDate')); 
					  
			 if(purchsedate>masterdate){
			 document.getElementById("errormsg").innerText="Purchase Date Cannot be Greater Than Document Date";
			 $('#purchasedate').jqxDateTimeInput('focus'); 
			 return false;
					     }   
			
	      else {
	              document.getElementById("errormsg").innerText="";  
			  }
			 
		if($('#mode').val()=='E')
			{
			if(document.getElementById("masteredit").value=="master")
				{
			
		 $('#supplieraccId').attr('disabled',false); 
		 $('#totalpuchvalue').attr('disabled',false); 
		 $('#opening').attr('disabled',false); 
		 $('#accumdepr').attr('disabled',false); 
		 $('#fixedassetaccId').attr('disabled',false); 
		 $('#accdepraccId').attr('disabled',false); 
		 $('#depraccId').attr('disabled',false); 
				}
			
			else
				{
				
				 if(document.getElementById("supplieraccId").value=="")
				 {
			    	document.getElementById("errormsg").innerText="Search Supplier Account";  
			    	document.getElementById("supplieraccId").focus();
			    	return 0;
				 }
			 
					
			 if(document.getElementById("totalpuchvalue").value=="" || parseFloat(document.getElementById("totalpuchvalue").value)==0)
			 {
		    	document.getElementById("errormsg").innerText="Enter Total Purchase Value";  
		    	document.getElementById("totalpuchvalue").focus();
		    	return 0;
			 }
		 
		 
			
			 if(document.getElementById("openingval").value==1)
				{
				 
				 if(document.getElementById("accumdepr").value=="" || parseFloat(document.getElementById("accumdepr").value)==0)
				 {
				 document.getElementById("errormsg").innerText="Enter Accumulated Depreciation";  
				 document.getElementById("accumdepr").focus();
			    	return 0;
					
				 }
				 var total= document.getElementById("totalpuchvalue").value;
				 var accdepn=document.getElementById("accumdepr").value;
				 if(parseFloat(accdepn)>parseFloat(total))
					  {
					 
					 document.getElementById("errormsg").innerText="Accum.Depreciation Canot More Than Purchase Value";  
				      	//document.getElementById("accumdepr").value="";
				    	document.getElementById("accumdepr").focus();
				    	return 0;
					 
					 
					 } 
				}
			 
			 
			 if(document.getElementById("depper").value=="")
			 {
		    	document.getElementById("errormsg").innerText="Enter Depreciation %";  
		    	document.getElementById("depper").focus();
		    	return 0;
			 }
		 
			 
			  
			 
			 
			 if(document.getElementById("fixedassetaccId").value=="")
			 {
		    	document.getElementById("errormsg").innerText="Search Fixed Asset Account";  
		    	 document.getElementById("fixedassetaccId").focus();
		    	return 0;
			 }
			 
			 
			 if(document.getElementById("accdepraccId").value=="")
			 {
		    	document.getElementById("errormsg").innerText="Search Accumulated Depreciation Account";  
		    	 document.getElementById("accdepraccId").focus();
		    	return 0;
			 }
			 if(document.getElementById("depraccId").value=="")
			 {
		    	document.getElementById("errormsg").innerText="Search Depreciation Account";  
		    	 document.getElementById("depraccId").focus();
		    	return 0;
			 }
			 
				
				}
			
			
			
			
			
			
			}
	   
	
	 //supplieraccId fixedassetaccId
	if($('#mode').val()=='A')
	 {
	 if(document.getElementById("supplieraccId").value=="")
		 {
	    	document.getElementById("errormsg").innerText="Search Supplier Account";  
	    	document.getElementById("supplieraccId").focus();
	    	return 0;
		 }
	 
			
	 if(document.getElementById("totalpuchvalue").value=="" || parseFloat(document.getElementById("totalpuchvalue").value)==0)
	 {
    	document.getElementById("errormsg").innerText="Enter Total Purchase Value";  
    	document.getElementById("totalpuchvalue").focus();
    	return 0;
	 }
 
 
	
	 if(document.getElementById("openingval").value==1)
		{
		 
		 if(document.getElementById("accumdepr").value=="" || parseFloat(document.getElementById("accumdepr").value)==0)
		 {
		 document.getElementById("errormsg").innerText="Enter Accumulated Depreciation";  
		 document.getElementById("accumdepr").focus();
	    	return 0;
			
		 }
		 
		 var total= document.getElementById("totalpuchvalue").value;
		 var accdepn=document.getElementById("accumdepr").value;
		 if(parseFloat(accdepn)>parseFloat(total))
			  {
			 
			 document.getElementById("errormsg").innerText="Accum.Depreciation Canot More Than Purchase Value";  
		      	//document.getElementById("accumdepr").value="";
		    	document.getElementById("accumdepr").focus();
		    	return 0;
			 
			 
			 } 
		 
		 
		}
	 
	
 
	 if(document.getElementById("depper").value=="")
	 {
    	document.getElementById("errormsg").innerText="Enter Depreciation %";  
    	document.getElementById("depper").focus();
    	return 0;
	 }
 
	 
		
	 
	 if(document.getElementById("fixedassetaccId").value=="")
	 {
    	document.getElementById("errormsg").innerText="Search Fixed Asset Account";  
    	 document.getElementById("fixedassetaccId").focus();
    	return 0;
	 }
	 
	 
	 if(document.getElementById("accdepraccId").value=="")
	 {
    	document.getElementById("errormsg").innerText="Search Accumulated Depreciation Account";  
    	 document.getElementById("accdepraccId").focus();
    	return 0;
	 }
	 if(document.getElementById("depraccId").value=="")
	 {
    	document.getElementById("errormsg").innerText="Search Depreciation Account";  
    	 document.getElementById("depraccId").focus();
    	return 0;
	 }
	 
	 }
	 //supplieraccId fixedassetaccId
	 
	
	 var rows = $("#jqxsubdetails").jqxGrid('getrows');
	    $('#gridval').val(rows.length);
	  
	   for(var i=0 ; i < rows.length ; i++){
	
	    newTextBox = $(document.createElement("input"))
	       .attr("type", "dil")
	       .attr("id", "paytest"+i)
	       .attr("name", "paytest"+i)
	       .attr("hidden", "true"); 
	 
	   newTextBox.val(rows[i].sr_no+"::"+rows[i].desc1+" :: "+rows[i].qty+" :: ");
	
	   newTextBox.appendTo('form');
	   }
	
	
return 1;
}


function funChkButton() {
	
	//frmEnquiry.submit();
}


function funFocus(){
	
	$('#masterdate').jqxDateTimeInput('focus'); 
	
}

function setValues() {
	
	  // main
	if($('#hidmasterdate').val()){
		$("#masterdate").jqxDateTimeInput('val', $('#hidmasterdate').val());
	}
	  // purchase
	if($('#hidpurchasedate').val()){
		$("#purchasedate").jqxDateTimeInput('val', $('#hidpurchasedate').val());
	}
	  // main
	if($('#hidwarexpdate').val()){
		$("#warexpdate").jqxDateTimeInput('val', $('#hidwarexpdate').val());
	}
	var docnos=document.getElementById("docno").value;
	  if(parseInt(docnos)>0)
	 {
		  if(document.getElementById("subgriddisval").value==1)
			{
		
		    $("#subdetail").load("subdetails.jsp?docno="+docnos);
			}
		  
	 }
	  
 	if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
 	
 	  funSetlabel();  
 	  funsetdatas();
 	 fundeleterestriction()
}

function funsetdatas()
{
	if(document.getElementById("subgriddisval").value==1)
	{
		document.getElementById("subgriddis").checked=true;
		$('#subdetail').show();
		$('#freespace').hide();
	}
	else
		{
		document.getElementById("subgriddis").checked=false;
		$('#subdetail').hide();
		$('#freespace').show();
		}
	
	if(document.getElementById("openingval").value==1)
		{
		document.getElementById("opening").checked =true;
		
		if($('#mode').val()!='view')
			{
		$('#accumdepr').attr('disabled',false); 
		$('#accumdepr').attr('readonly',false);
			}
		
		}
	else
		{
		document.getElementById("opening").checked =false;
		$('#accumdepr').attr('disabled',true); 
		
		}
	
	
	if($('#assetGroupval').val()!=""){
		$("#assetGroup").val($('#assetGroupval').val());
	}
	
	if($('#locationval').val()!=""){
		$("#location").val($('#location').val());
	}
	
	
	
	}


function fundisgrid()
{
				if(document.getElementById("subgriddis").checked == true)
					{
					$('#subdetail').show();
					$('#freespace').hide();
					
					
					document.getElementById("subgriddisval").value=1;
					
					}
				else
					{
				$('#subdetail').hide();
				$('#freespace').show();
				
				document.getElementById("subgriddisval").value=0;
					}
				
				
				
	
	}
	
	function funopening()
	{
		
		if(document.getElementById("opening").checked == true)
		{
			document.getElementById("openingval").value=1;
			$('#accumdepr').attr('disabled',false); 	
			$('#accumdepr').attr('readonly',false); 
		}
		
		else
			{
			document.getElementById("openingval").value=0;
			document.getElementById("accumdepr").value="";
			$('#accumdepr').attr('disabled',true); 	
			$('#accumdepr').attr('readonly',false);
			
			}
		 
		
		
	}
	
	
	function funSearchLoad(){
		changeContent('mastersearch.jsp', $('#window'));
	}
	
	
	function getAssetgp() {
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
				$("select#assetGroup").html(optionsbranch);
				
				if ($('#assetGroupval').val() != null) {
					$('#assetGroup').val($('#assetGroupval').val());
				}
			/* 	if($('#assetGroupval').val()!=""){
					$("#assetGroup").val($('#assetGroupval').val());
				}	 */
			
			} else {
			}
		}
		x.open("GET", "getAssetgp.jsp", true);
		x.send();
	}

	function getloc() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;	
				items = items.split('***');
				var branchItems1 = items[0].split(",");
				var branchIdItems1 = items[1].split(",");
				var optionsbranch1 = '<option value="">--Select--</option>';
				for (var i = 0; i < branchItems1.length; i++) {
					optionsbranch1 += '<option value="' + branchIdItems1[i] + '">'
							+ branchItems1[i] + '</option>';
				}
				$("select#location").html(optionsbranch1);
				
				if ($('#locationval').val() != null) {
					$('#location').val($('#locationval').val());
				}
			/* 	if($('#assetGroupval').val()!=""){
					$("#assetGroup").val($('#assetGroupval').val());
				}	 */
			
			} else {
			}
		}
		x.open("GET", "getLocatons.jsp", true);
		x.send();
	}

	
	function isNumber(evt) {
	    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
	    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
	     {
	    	
	    	document.getElementById("errormsg").innerText="Enter Numbers Only";  

	        return false;
	     }
	    document.getElementById("errormsg").innerText="";  

	    return true;
	}
	
	
	function funcalculatedep()
	{
		
		 if ($("#mode").val() == "A" )
			 {
		 if(document.getElementById("totalpuchvalue").value=="" || parseFloat(document.getElementById("totalpuchvalue").value)==0)
		 {
	    	document.getElementById("errormsg").innerText="Enter Total Purchase Value";  
	    	document.getElementById("lifetimeyear").value="";
	    	document.getElementById("totalpuchvalue").focus();
	    	return 0;
		 }
		 else
		 {
		 document.getElementById("errormsg").innerText="";
		 }
			 }
		 
		 
			if($('#mode').val()=='E')
			{
				if(document.getElementById("masteredit").value=="master")
					{
					 
					}
				
				else
					{
					
							 if(document.getElementById("totalpuchvalue").value=="" || parseFloat(document.getElementById("totalpuchvalue").value)==0)
							 {
						    	document.getElementById("errormsg").innerText="Enter Total Purchase Value";  
						    	document.getElementById("lifetimeyear").value="";
						    	document.getElementById("totalpuchvalue").focus();
						    	return 0;
							 }
							 else
							 {
							 document.getElementById("errormsg").innerText="";
							 }
					
					}
			
			
			}
		 
		 
		 if ($("#mode").val() == "A" || $("#mode").val() == "E") {   
			 
			
			 
		var year=document.getElementById("lifetimeyear").value;
		var depval=((1/parseFloat(year))*100);
		
		funRoundAmt(depval,"depper");
		 }
		
	}
	
	function funcalcuyear()
	{
		
		 if ($("#mode").val() == "A" )
		 {
	 if(document.getElementById("totalpuchvalue").value=="" || parseFloat(document.getElementById("totalpuchvalue").value)==0)
	 {
    	document.getElementById("errormsg").innerText="Enter Total Purchase Value";  
      	document.getElementById("depper").value="";
    	document.getElementById("totalpuchvalue").focus();
    	return 0;
	 }
	 else
	 {
	 document.getElementById("errormsg").innerText="";
	 }
 
		 }
		 
		 
		 
			if($('#mode').val()=='E')
			{
				if(document.getElementById("masteredit").value=="master")
					{
					 
					}
				
				else
					{
					         
					 if(document.getElementById("totalpuchvalue").value=="" || parseFloat(document.getElementById("totalpuchvalue").value)==0)
					 {
				    	document.getElementById("errormsg").innerText="Enter Total Purchase Value";  
				      	document.getElementById("depper").value="";
				    	document.getElementById("totalpuchvalue").focus();
				    	return 0;
					 }
					 else
					 {
					 document.getElementById("errormsg").innerText="";
					 }
					
					
					}
				
			}
		 
		 
		 
		 
		 
		
		 if ($("#mode").val() == "A" || $("#mode").val() == "E") {   
				var dep=document.getElementById("depper").value;
				var yearval=(100/parseFloat(dep));
				
				funRoundAmt(yearval,"lifetimeyear");
				
				 }
	}
	function funchktotal()
	{
		
		 if ($("#mode").val() == "A" )
		 {
			 if(document.getElementById("totalpuchvalue").value=="" || parseFloat(document.getElementById("totalpuchvalue").value)==0)
			 {
		    	document.getElementById("errormsg").innerText="Enter Total Purchase Value";  
		      	//document.getElementById("accumdepr").value="";
		    	document.getElementById("totalpuchvalue").focus();
		    	return 0;
			 }
			 else
				 {
				 document.getElementById("errormsg").innerText="";
				 }
			 
			var total= document.getElementById("totalpuchvalue").value;
			 var accdepn=document.getElementById("accumdepr").value;
			 if(parseFloat(accdepn)>parseFloat(total))
				  {
				 
				 document.getElementById("errormsg").innerText="Accum.Depreciation Canot More Than Purchase Value";  
			      	//document.getElementById("accumdepr").value="";
			    	document.getElementById("accumdepr").focus();
			    	return 0;
				 
				 
				 }
			 else
				 {
				 document.getElementById("errormsg").innerText="";
				 }
	 
 
		 }
		 
		 
			if($('#mode').val()=='E')
			{
				if(document.getElementById("masteredit").value=="master")
					{
				
					}
				else
					{
									 if(document.getElementById("totalpuchvalue").value=="" || parseFloat(document.getElementById("totalpuchvalue").value)==0)
									 {
								    	document.getElementById("errormsg").innerText="Enter Total Purchase Value";  
								      	//document.getElementById("accumdepr").value="";
								    	document.getElementById("totalpuchvalue").focus();
								    	return 0;
									 }
									 else
										 {
										 document.getElementById("errormsg").innerText="";
										 }
									
					 
						var total= document.getElementById("totalpuchvalue").value;
						 var accdepn=document.getElementById("accumdepr").value;
						 if(parseFloat(accdepn)>parseFloat(total))
							  {
							 
							 document.getElementById("errormsg").innerText="Accum.Depreciation Canot More Than Purchase Value";  
						      	//document.getElementById("accumdepr").value="";
						    	document.getElementById("accumdepr").focus();
						    	return 0;
							 
							 
							 }
						 else
							 {
							 document.getElementById("errormsg").innerText="";
							 }
					
					}
			}
		 
		 
		 
		 
		 
		 
		 
		 

	}
	
	
	
	function funchkaccum()
	{
		
		 if ($("#mode").val() == "A" )
		 {
			 
			 
			 if(document.getElementById("openingval").value==1)
				{
				 
					 if(document.getElementById("accumdepr").value=="" || parseFloat(document.getElementById("accumdepr").value)==0)
					 {
					 document.getElementById("errormsg").innerText="Enter Accumulated Depreciation";  
					 document.getElementById("accumdepr").focus();
				    	return 0;
						
					 }
					 
					 var total= document.getElementById("totalpuchvalue").value;
					 var accdepn=document.getElementById("accumdepr").value;
					 if(parseFloat(accdepn)>parseFloat(total))
						  {
						 
						    document.getElementById("errormsg").innerText="Purchase Value Canot Less Than Accum.Depreciation  ";  
					      	//document.getElementById("accumdepr").value="";
					    	document.getElementById("totalpuchvalue").focus();
					    	return 0;
						 
						 
						 } 
					 else
						 {
						 document.getElementById("errormsg").innerText="";
						 }
 
		     }
		 }
			 
			 if($('#mode').val()=='E')
				{
					if(document.getElementById("masteredit").value=="master")
						{
					
						}
					else
						{
						if(document.getElementById("openingval").value==1)
						{
						 
							 if(document.getElementById("accumdepr").value=="" || parseFloat(document.getElementById("accumdepr").value)==0)
							 {
							 document.getElementById("errormsg").innerText="Enter Accumulated Depreciation";  
							 document.getElementById("accumdepr").focus();
						    	return 0;
								
							 }
							 
							 var total= document.getElementById("totalpuchvalue").value;
							 var accdepn=document.getElementById("accumdepr").value;
							 if(parseFloat(accdepn)>parseFloat(total))
								  {
								 
								    document.getElementById("errormsg").innerText="Purchase Value Canot Less Than Accum.Depreciation  ";  
							      	//document.getElementById("accumdepr").value="";
							    	document.getElementById("totalpuchvalue").focus();
							    	return 0;
								 
								 
								 } 
							 else
								 {
								 document.getElementById("errormsg").innerText="";
								 }
		 
				     }
						
						}
				}
			 
		 
		
	}
	 function funPrintBtn() {
			
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
		        var url=document.URL;
		        var reurl=url.split("saveAssetmaster");
		        $("#docno").prop("disabled", false);  
		       var branch=<%=session.getAttribute("BRANCHID").toString()%>
		      // alert(branch);
					
						 var win= window.open(reurl[0]+"printassetmaster?docno="+document.getElementById("docno").value+"&branch="+branch,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					     win.focus();
					 }
					
		    else 
		    {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
   }
    
	
	
	
	
	
	
	
	 // accumdepr Accum.Depreciation
	

</script>

<body onload="setValues();getAssetgp();getloc();">
<div id="mainBG" class="homeContent" data-type="background"> 
<form id="frmassetmastrer" action="saveAssetmaster" autocomplete="OFF" >


<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div class="hidden-scrollbar receipt-header">

    <div class="section-block full-width-block">
        <h3 class="fieldset-legend-replacement">Asset Master</h3>

        <div class="form-group dual-input">
            <label>Date</label>
            <div>
                <div id='masterdate' name='masterdate' value='<s:property value="masterdate"/>'></div>
            </div>
            <input type="hidden" id="hidmasterdate" name="hidmasterdate" value='<s:property value="hidmasterdate"/>'/>

            <label>Ref No</label>
            <input type="text" id="refno" name="refno" value='<s:property value="refno"/>'/>
        </div>
        
        <div class="form-group dual-input">
            <label>Asset Id</label>
            <input type="text" id="assetid" name="assetid" value='<s:property value="assetid"/>'/>
            
            <label>Doc No</label>
            <input type="text" id="docno" name="docno" value='<s:property value="docno"/>'/>
        </div>
        
        <div class="form-group">
            <label>Name</label>
            <input name="assetname" type="text" id="assetname" value='<s:property value="assetname"/>'/>
        </div>

        <div class="form-group">
            <label>Remarks</label>
            <input type="text" id="remarks" name="remarks" value='<s:property value="remarks"/>'/>
        </div>

        <div class="form-group dual-input">
            <label>Asset Group</label>
            <select id="assetGroup" name="assetGroup" value='<s:property value="assetGroup"/>' > 
                <option value="">--Select--</option>
            </select>
            <input type="hidden" name="assetGroupval" id="assetGroupval" value='<s:property value="assetGroupval"/>'/>
            
            <label>Location</label>
            <select id="location" name="location" value='<s:property value="location"/>' > 
                <option value="">--Select--</option>
            </select>
            <input type="hidden" name="locationval" id="locationval" value='<s:property value="locationval"/>'/>
        </div>
    </div>


    <div class="section-row">
        
        <div class="section-block">
            <h3 class="fieldset-legend-replacement">Purchase</h3>
            
            <div class="form-group single-label-dual-input">
                <label>Supplier</label>
                <input type="text" id="supplieraccId" placeholder="Press F3 To Search" name="supplieraccId" value='<s:property value="supplieraccId"/>' onkeydown="getaccountdetails(event)"/>
                <input name="supplieraccName" type="text" id="supplieraccName" value='<s:property value="supplieraccName"/>' readonly/>
                <input name="supaccdocno" type="hidden" id="supaccdocno" value='<s:property value="supaccdocno"/>' />
                <input name="supcmbcurrency" type="hidden" id="supcmbcurrency" value='<s:property value="supcmbcurrency"/>' />
                <input name="suprate" type="hidden" id="suprate" value='<s:property value="suprate"/>' />
                <input name="suphidcurrencytype" type="hidden" id="suphidcurrencytype" value='<s:property value="suphidcurrencytype"/>' />
            </div>

            <div class="form-group dual-input">
                <label>Purchase Ref No</label>
                <input type="text" id="purchrefno" name="purchrefno" value='<s:property value="purchrefno"/>'/>
                
                <label>Purchase Date</label>
                <div>
                    <div id='purchasedate' name='purchasedate' value='<s:property value="purchasedate"/>'></div>
                </div>
                <input type="hidden" id="hidpurchasedate" name="hidpurchasedate" value='<s:property value="hidpurchasedate"/>'/>
            </div>

            <div class="form-group dual-input">
                <label>No Of items</label>
                <input type="text" id="noofitems" name="noofitems" value='<s:property value="noofitems"/>' onkeypress="javascript:return isNumber (event);" />
                
                <label>Total Purchase Value</label>
                <input name="totalpuchvalue" type="text" id="totalpuchvalue" style="text-align: right;" value='<s:property value="totalpuchvalue"/>' onblur="funRoundAmt(this.value,this.id);funchkaccum();" onkeypress="javascript:return isNumber (event);" />
            </div>

            <div class="form-group dual-input">
                <label>WNTY Exp Date</label>
                <div>
                    <div id='warexpdate' name='warexpdate' value='<s:property value="warexpdate"/>'></div> 
                </div>
                <input type="hidden" id="hidwarexpdate" name="hidwarexpdate" value='<s:property value="hidwarexpdate"/>'/>
                
                <label>WNTY DocNo</label>
                <input type="text" name="wntydocno" id="wntydocno" value='<s:property value="wntydocno"/>'/>
            </div>
            
            <div style="height: 24px;"></div> 

        </div>

        <div class="section-block">
            <div class="form-group" style="grid-template-columns: 1fr;">
                 <label class="checkbox-label" for="subgriddis" style="min-width: 0;">
                    <input type="checkbox" id="subgriddis" name="subgriddis" onchange="fundisgrid();">Sub Details
                 </label>
                <input type="hidden" name="subgriddisval" id="subgriddisval" value='<s:property value="subgriddisval"/>'/>
            </div>
            
            <div id="subdetail" hidden="true">
                <jsp:include page="subdetails.jsp"></jsp:include>
            </div>
            <div id="freespace" class="container" style="min-height: 180px;"></div>
        </div>
    </div>


    <div class="section-row">

        <div class="section-block">
            <h3 class="fieldset-legend-replacement">Depreciation</h3>
            
            <div class="form-group">
                <div style="grid-column: 1 / span 2; display: flex; align-items: center; justify-content: flex-start; padding-left: 10px;">
                    <label class="checkbox-label" for="opening" style="min-width: 0; padding-right: 15px;">
                        Opening 
                        <input type="checkbox" id="opening" name="opening" onchange="funopening()">
                    </label>
                    <input type="hidden" id="openingval" name="openingval" value='<s:property value="openingval"/>'/>
                </div>
            </div>

            <div class="form-group dual-input">
                <label>Accum.Depr</label>
                <input type="text" id="accumdepr" style="text-align: right;" name="accumdepr" value='<s:property value="accumdepr"/>' onblur="funRoundAmt(this.value,this.id);funchktotal();" onkeypress="javascript:return isNumber (event);" />

                <label>Life Time (Year)</label>
                <input name="lifetimeyear" type="text" id="lifetimeyear" style="text-align: right;" value='<s:property value="lifetimeyear"/>' onblur="funRoundAmt(this.value,this.id);funcalculatedep();" onkeypress="javascript:return isNumber (event);" />
            </div>
            
            <div class="form-group">
                <label>Depr %</label>
                <input type="text" id="depper" name="depper" style="text-align: right;" value='<s:property value="depper"/>' onblur="funRoundAmt(this.value,this.id);funcalcuyear();" onkeypress="javascript:return isNumber (event);" />
            </div>


            <div class="form-group">
                <label>Notes</label>
                <input type="text" id="depnotes" name="depnotes" value='<s:property value="depnotes"/>'/>
            </div>

        </div>

        <div class="section-block">
            <h3 class="fieldset-legend-replacement">Depreciation Accounts</h3>
            
            <div class="form-group single-label-dual-input">
                <label>Fixed Asset</label>
                <input type="text" id="fixedassetaccId" placeholder="Press F3 To Search" name="fixedassetaccId" value='<s:property value="fixedassetaccId"/>' onkeydown="getaccountdetails1(1)"/>
                <input name="fixedassetaccName" type="text" id="fixedassetaccName" value='<s:property value="fixedassetaccName"/>' readonly/>
                <input name="fixaccDocno" type="hidden" id="fixaccDocno" value='<s:property value="fixaccDocno"/>'/>
                <input name="fixaccCurrid" type="hidden" id="fixaccCurrid" value='<s:property value="fixaccCurrid"/>'/> 
                <input name="fixaccRate" type="hidden" id="fixaccRate" value='<s:property value="fixaccRate"/>'/>
                <input name="fixaccType" type="hidden" id="fixaccType" value='<s:property value="fixaccType"/>'/>
            </div>

            <div class="form-group single-label-dual-input">
                <label>Accu.Depr</label>
                <input type="text" id="accdepraccId" placeholder="Press F3 To Search" name="accdepraccId" value='<s:property value="accdepraccId"/>' onkeydown="getaccountdetails1(2)"/>
                <input name="accdepraccName" type="text" id="accdepraccName" value='<s:property value="accdepraccName"/>' readonly/>
                <input name="accdepraccDocno" type="hidden" id="accdepraccDocno" value='<s:property value="accdepraccDocno"/>'/>
                <input name="accdepraccCurrid" type="hidden" id="accdepraccCurrid" value='<s:property value="accdepraccCurrid"/>'/>
                <input name="accdepraccRate" type="hidden" id="accdepraccRate" value='<s:property value="accdepraccRate"/>'/>
                <input name="accdepraccType" type="hidden" id="accdepraccType" value='<s:property value="accdepraccType"/>'/>
            </div>

            <div class="form-group single-label-dual-input">
                <label>Depreciation</label>
                <input type="text" id="depraccId" placeholder="Press F3 To Search" name="depraccId" value='<s:property value="depraccId"/>' onkeydown="getaccountdetails1(3)"/>
                <input name="depraccName" type="text" id="depraccName" value='<s:property value="depraccName"/>' readonly/>
                <input name="depracDocno" type="hidden" id="depracDocno" value='<s:property value="depracDocno"/>'/>
                <input name="depracCurrid" type="hidden" id="depracCurrid" value='<s:property value="depracCurrid"/>'/>
                <input name="depracRate" type="hidden" id="depracRate" value='<s:property value="depracRate"/>'/>
                <input name="depracType" type="hidden" id="depracType" value='<s:property value="depracType"/>'/>
            </div>
        </div>

    </div>

    <div style="display: none;">
        <input type="hidden" id="masteredit" name="masteredit" value='<s:property value="masteredit"/>' />
        <input type="hidden" id="srno" name="srno" value='<s:property value="srno"/>' />
        <input type="hidden" id="gridval" name="gridval" value='<s:property value="gridval"/>' />
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
    </div>

</div>
</form>

<div id="accountDetailsWindow">
	<div></div></div>
	<div id="fixaccountDetailsWindow">
	<div></div></div>

</div>
</body>
</html>