<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
 <jsp:include page="../../../../includes.jsp"></jsp:include>

<style>

body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    font-size:14px;
    font-weight:400;
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
    max-width: 100%;
    margin: auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

/* INPUTS */
input[type="text"], select {
    height: 32px !important;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    background: #fff;
    transition: border-color 0.2s;
    font-size: 14px;
    box-sizing: border-box;
    width: auto;
    max-width: 100%;
}

input[type="text"]:focus,
select:focus {
    border-color: #007bff;
    outline: none;
}

/* LABELS */

label {
    font-family:'Segoe UI','Roboto','Arial',sans-serif;
    font-size:16px;
    font-weight:600;
    color:#253858;
    white-space: nowrap;
    line-height: 32px;
    padding: 0px 8px 0px 0px;
    text-align: right;
}

/* SECTION BLOCK */

.section-block {
    flex: 1;
    min-width: 0;
    background: #f6f8fa;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.1);
}

/* SECTION TITLES */

.section-block h2 {
    font-family:'Segoe UI','Roboto','Arial',sans-serif;
    font-size:17.6px;
    font-weight:600;
    margin:0 0 20px;
    padding-left:10px;
    border-left:4px solid #007bff;
}

/* ROW LAYOUT */

.section-row {
    display:flex;
    gap:26px;
    margin-bottom:30px;
}

.form-group {
    display:grid;
    grid-template-columns:120px 1fr;
    align-items:center;
    gap:12px 16px;
    margin-bottom:12px;
}

.form-group label {
    font-size:14px;
}

/* AGREEMENT GRID */

.agmt-info-grid {
    display:grid;
    grid-template-columns:auto 1fr auto 1fr auto 1fr;
    gap:15px 25px;
    align-items:center;
}

/* VEHICLE IN/OUT GRID */

.in-out-info-grid {
    display:grid;
    grid-template-columns:auto 1fr auto 1fr;
    gap:12px 16px;
    align-items:center;
}

.in-out-info-grid label {
    font-weight:500;
    padding-right:8px;
}

/* INPUT GROUP */

.input-group {
    display:flex;
    gap:5px;
    width:100%;
}

.input-group input {
    width:35% !important;
}

.input-group input:nth-child(2) {
    width:65% !important;
}

/* CHECKBOX ALIGN */

.checkbox-label-end {
    display:flex;
    align-items:center;
    justify-content:flex-end;
    gap:5px;
}

/* BUTTON GROUP */

.btn-group-end {
    grid-column:span 4;
    text-align:right;
    display:flex;
    justify-content:flex-end;
    gap:10px;
    margin-top:10px;
}

/* STATUS LABEL */

#lblcancelstatus {
    font-family:'Segoe UI','Roboto','Arial',sans-serif;
    font-size:14px;
    font-weight:600;
    color:#6000FC;
    text-align:center;
    grid-column:span 2;
}

/* DATE PICKER */

.jqx-datetimeinput-widget,
.jqx-datetimeinput {
    height:32px !important;
    line-height:32px !important;
}

/* SCROLL */

.hidden-scrollbar {
    overflow-y:visible !important;
    max-height:none !important;
    min-height:1px;
    padding-right:5px;
}

.hidden-scrollbar::-webkit-scrollbar {
    width:8px;
    background:#f0f0f0;
}

.hidden-scrollbar::-webkit-scrollbar-thumb {
    background:#c0c0c0;
    border-radius:4px;
}

/* FORM TITLE */

#formdet {
    display:block;
    text-align:left !important;
    width:100%;
    margin-left:0;
}

/* Fix header date alignment */
.receipt-header label{
    line-height:32px;
}

.receipt-header .jqx-datetimeinput{
    height:32px !important;
}

/* Fix Doc No width */
#docno{
    width:180px !important;
}

/* Fix agreement grid column widths */
.agmt-info-grid{
    grid-template-columns:120px 1fr 120px 1fr 120px 1fr;
}

/* Fix input group alignment */
.input-group{
    display:flex;
    align-items:center;
    gap:8px;
}

/* Fix Fleet No two inputs */
.input-group input:first-child{
    width:120px !important;
}

.input-group input:nth-child(2){
    flex:1;
}

/* Fix Date Out / Time Out layout */
#dateout,
#timeout{
    width:120px !important;
}

/* Fix KM + Fuel alignment */
#outkm{
    width:100px !important;
}

#cmbfuel{
    width:140px !important;
}

/* Fix description field full width */
#description{
    width:100% !important;
}

/* Fix Reference No alignment */
#referenceno{
    width:220px !important;
}

/* Align labels properly */
.agmt-info-grid label{
    text-align:right;
    padding-right:10px;
}

/* Prevent stretched inputs */
.agmt-info-grid input,
.agmt-info-grid select{
    max-width:100%;
}
/* Align Date picker with label */
#date{
    display:inline-block;
    vertical-align:middle;
}

/* Fix jqx date input height */
.jqx-datetimeinput,
.jqx-datetimeinput-widget{
    height:32px !important;
    line-height:32px !important;
}

/* Align internal input */
.jqx-datetimeinput input{
    height:32px !important;
    line-height:32px !important;
    margin-top:0px !important;
}

/* Align label with date */
.receipt-header label{
    line-height:32px;
}
.receipt-header{
    padding-right:20px;
}
.jqx-datetimeinput{
    height:34px !important;
}

.jqx-datetimeinput input{
    line-height:34px !important;
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
  select {
    height: 34px !important;
    line-height: 34px !important;
    padding: 4px 8px !important;
}

select::-ms-expand {
    display: block;
}

.form-group select,
.agmt-info-grid select,
.in-out-info-grid select {
    min-height: 34px;
}
.agmt-info-grid {
    grid-template-columns: 120px 1fr 120px 1fr 120px 1fr;
    align-items: center;
}
.agmt-info-grid select {
    width: 100%;
    min-width: 0;
}
</style>


<script type="text/javascript">

$(document).ready(function () {   
	
	   /* Date */ 	
    $("#nipurchasedate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    $("#deliverydate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    
    $("#invDate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
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
    
    $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 100, y: 60 }, keyboardCloseKey: 27});
    $('#accountSearchwindow').jqxWindow('close');
	$('#accounttypeSearchwindow').jqxWindow({ width: '60%', height: '62%',  maxHeight: '75%' ,maxWidth: '70%' , title: 'Account Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
    $('#accounttypeSearchwindow').jqxWindow('close');
    $('#costtpesearchwndow').jqxWindow({ width: '35%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Cost Type Search' ,position: { x: 700, y:60 }, keyboardCloseKey: 27});
    $('#costtpesearchwndow').jqxWindow('close');   
    $('#costcodesearchwndow').jqxWindow({ width: '35%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Cost code Search' ,position: { x: 800, y: 60 }, keyboardCloseKey: 27});
    $('#costcodesearchwndow').jqxWindow('close');  
    $('#refnosearchwindow').jqxWindow({ width: '50%', height: '59%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Ref No Search' ,position: { x: 450, y: 40 }, keyboardCloseKey: 27});
    $('#refnosearchwindow').jqxWindow('close');  
    $('#nipurchslnosearch').jqxWindow({ width: '50%', height: '59%',  maxHeight: '62%' ,maxWidth: '60%' , title: ' Search' ,position: { x: 200, y: 60}, keyboardCloseKey: 27});
    $('#nipurchslnosearch').jqxWindow('close');
	$('#txtproducttype').dblclick(function(){
		
		typeFormSearchContent('typeFormSearchGrid.jsp'); 
		
	}); 
	
	
    $('#refno').dblclick(function(){
    	
    	if($('#mode').val()!= "view")
		{
	  	    $('#refnosearchwindow').jqxWindow('open');
	 
	
	  	  refnoSearchContent('ordermainsearch.jsp?');
		}
    }); 
	  	 $('#nipuraccid').dblclick(function(){
	  		if($('#mode').val()!= "view")
    		{
		  	    $('#accountSearchwindow').jqxWindow('open');
		 
		
		  	  accountSearchContent('accountsDetailsFromGrid.jsp?dtype='+$('#acctype').val());
    		} 
  });   
});

function typeFormSearchContent(url) {
	 document.getElementById("errormsg").innerText="";
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
				function getrefnosearch(event){
					 var x= event.keyCode;
						if($('#mode').val()!= "view")
			    		{
							 if(x==114){
							  $('#refnosearchwindow').jqxWindow('open');
						
						
							  refnoSearchContent('ordermainsearch.jsp?');   }
							 else{
								 }
			    		}
					 }  
				function refnoSearchContent(url) {
					 //alert(url);
						 $.get(url).done(function (data) {
							 
							 $('#refnosearchwindow').jqxWindow('open');
						$('#refnosearchwindow').jqxWindow('setContent', data);
				
					}); 
					} 
				 function costcodeSearchContent(url) {
					 //alert(url);
						 $.get(url).done(function (data) {
							 
							 $('#costcodesearchwndow').jqxWindow('open');
						$('#costcodesearchwndow').jqxWindow('setContent', data);
				
					}); 
					}  

					function costSearchContent(url) {
						 //alert(url);
							 $.get(url).done(function (data) {
								 
								 $('#costtpesearchwndow').jqxWindow('open');
							$('#costtpesearchwndow').jqxWindow('setContent', data);
					
						}); 
						} 
						
					function CashSearchContent(url) {
						 //alert(url);
							 $.get(url).done(function (data) {
								 
								 $('#accounttypeSearchwindow').jqxWindow('open');
							$('#accounttypeSearchwindow').jqxWindow('setContent', data);
					
						}); 
						} 
					function getaccountdetails(event){
					 	 var x= event.keyCode;
					 	 
					 	if($('#mode').val()!= "view")
			    		{
						 	 if(x==114){
						 	  $('#accountSearchwindow').jqxWindow('open');
						 
						 
						 	 accountSearchContent('accountsDetailsFromGrid.jsp?dtype='+$('#acctype').val());   }
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
						  
					/* 	  function getslno(event){
						  	  	 var x= event.keyCode;
						  	  	 if(x==114){
						  	  	  $('#nipurchslnosearch').jqxWindow('open');
						  	  
						  	  	nipurhsaeslnocontent('nislnosearch.jsp?niorder='+document.getElementById("refno").value, $('#nipurchslnosearch'));   }
						  	  	 else{
						  	  		 }
						  	  	 }  */
						 	/* function searchslno()
							{
						 		
						 		 $('#refslno').dblclick(function(){
						 	  	  
						 	   
						 	  	 nipurhsaeslnocontent('nislnosearch.jsp?niorder='+document.getElementById("refno").value, $('#nipurchslnosearch'));
						 	  	  
						     });  
						 	 
						   		 
							}  */
						 	
						 	  function nipurhsaeslnocontent(url) {
						   	        //alert(url);
						   	           $.get(url).done(function (data) {
						   	 //alert(data);
						   	   $('#nipurchslnosearch').jqxWindow('open');
						   	         $('#nipurchslnosearch').jqxWindow('setContent', data);
					
						   		}); 
						   	     	} 
						  
	  
	  function funFocus(){
			 
		  $('#nipurchasedate').jqxDateTimeInput('focus');  		
		}
		function funNotify(){	
			//alert($('#nettotal').val());$('#nireftype').val()=="NPO"
		 
			/***
			*added by nitin
			*/

			/*   var summaryData= $("#nidescdetailsGrid").jqxGrid('getcolumnaggregateddata', 'taxamount', ['sum'],true);
            alert("ssssss"+summaryData.sum);
            document.getElementById("nettotal").value=summaryData.sum; */
		    var nipurchasedate = $('#nipurchasedate').jqxDateTimeInput('getDate');
			var validdate=funDateInPeriod(nipurchasedate);
			if(validdate==0){
			return 0;	
			}
			
            
			 var txtproducttype= document.getElementById('txtproducttype').value;
			 if(txtproducttype=="")
   			 {
				 var aa=0;
			   		var selectedrows=$("#nidescdetailsGrid").jqxGrid('getrows');	
			   		//selectedrows = selectedrows.sort(function(a,b){return a - b});  
					  for(var i=0 ; i < selectedrows.length ; i++){
						  
						  var tax=$("#nidescdetailsGrid").jqxGrid('getcellvalue',selectedrows[i],'taxper');
						  if(parseFloat(tax)>0.0){
							  $.messager.alert('Message','Select A Bill Type','warning'); 
							  return 0;
						  }
					  }
					  
   			
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
            
            
			
			var rows=$('#nidescdetailsGrid').jqxGrid('getrows');
		     
		     
		     var aa=0;
		     
			 for(var i=0;i<(rows.length);i++){
			   var chk=$('#nidescdetailsGrid').jqxGrid('getcellvalue',i,'headdoc');
			   
			   
			   var qty=$('#nidescdetailsGrid').jqxGrid('getcellvalue',i,'qty');
			   
			   if(parseFloat(qty)>0)
			   {
			   
			      if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != "" && chk != "0"){
			    	  
			    	 aa=1;
			    	 
			      }
			      else 
			    	  {
			    	  aa=0;
			    	  
			    	  }
			   }
			 }
			    
		 
			 if(parseInt(aa)==0) {
				 document.getElementById("errormsg").innerText=" Please Select Account";
				 return false;
			 } 
			 
		if( document.getElementById("nireftype").value=="NPO")
			{
	      var refno= document.getElementById('refno').value;
			 
			 if(refno=="")
			 {
				 document.getElementById("errormsg").innerText=" Select Ref NO";	
				 document.getElementById('refno').focus();
				 return 0;
			 }
			 
			 else
				 {
				 document.getElementById("errormsg").innerText="";
				 }
			 
		 
			}
						var purid= document.getElementById("nipuraccid").value;
						
						if(purid=="")
							{
							 document.getElementById("errormsg").innerText=" Select An Account";
							 document.getElementById("nipuraccid").focus();
							 
							 return 0;
							   }
						else
							   {
							   document.getElementById("errormsg").innerText="";
							   } 
						
						
                   var invno= document.getElementById("invno").value;
						
						if(invno=="")
							{
							 document.getElementById("errormsg").innerText=" Enter Inv NO";
							 document.getElementById("invno").focus();
							 
							 return 0;
							   }
						else
							   {
							   document.getElementById("errormsg").innerText="";
							   } 
							
						
						
						
						
						
						 var refval= document.getElementById("nettotal").value;

						 if(refval=="")
							{
							 document.getElementById("errormsg").innerText="Net Total Empty";
							 return 0;
							   }
						else
							   {
							   document.getElementById("errormsg").innerText="";
							   }
			 var rows = $("#nidescdetailsGrid").jqxGrid('getrows');
			    $('#nidescdetailslenght').val(rows.length);
			   //alert($('#gridlength').val());
			   for(var i=0 ; i < rows.length ; i++){
			   // var myvar = rows[i].tarif; 
			    newTextBox = $(document.createElement("input"))
			       .attr("type", "dil")
			       .attr("id", "desctest"+i)
			       .attr("name", "desctest"+i)
			        .attr("hidden", "true"); 
			   
			   newTextBox.val(rows[i].srno+"::"+rows[i].qty+" :: "+rows[i].description+" :: "
					   +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].nuprice+" :: "
					   +rows[i].costtype+" :: "+rows[i].costcode+" :: "+rows[i].remarks+" :: "+rows[i].headdoc+" :: "+rows[i].taxper+" :: "+rows[i].taxperamt+" :: "+rows[i].taxamount+" :: "+rows[i].rowno+":: ");
			
			//alert(newTextBox.val());    
			   newTextBox.appendTo('form');
			    
			   }   
				var x =new XMLHttpRequest();
				
				x.onreadystatechange=function()
				{
				if(x.readyState==4 && x.status==200)	
				
				{
					var items=x.responseText;
					
					
					
					var chk=items.trim();
					
					
					 
					
				if(parseInt(chk)==1)
					{
					
					document.getElementById("errormsg").innerText="Inv No "+document.getElementById("invno").value+" Already Exists ";  
					document.getElementById("invno").focus();
					
					return 0;
					
					}
				else
					{
					 document.getElementById("errormsg").innerText="";
					 
					 
					 
					 document.getElementById("frmNipurchase").submit();
					}
					
					
				
				}
				}
				
				x.open("GET","checkinvno.jsp?invno="+document.getElementById("invno").value+'&masterdocno='+document.getElementById("masterdoc_no").value+'&accdocno='+document.getElementById("accdocno").value);

				x.send();	
			
				
			
		} 

		function funchkinv()
		{
		var x =new XMLHttpRequest();
		
		x.onreadystatechange=function()
		{
		if(x.readyState==4 && x.status==200)	
		
		{
			var items=x.responseText;
			
			
			
			var chk=items.trim();
			
			
		 
			
		if(parseInt(chk)==1)
			{
			
			document.getElementById("errormsg").innerText="Inv No "+document.getElementById("invno").value+" Already Exists ";  
			document.getElementById("invno").focus();
			
			return 0;
			
			}
		else
			{
			 document.getElementById("errormsg").innerText="";
			 
			 
			 
			 return 1;
			}
			
			
		
		}
		}
		
		x.open("GET","checkinvno.jsp?invno="+document.getElementById("invno").value+'&masterdocno='+document.getElementById("masterdoc_no").value+'&accdocno='+document.getElementById("accdocno").value);

		x.send();
		
		}
		
		
		
		
		   
		   function funchkforedit()
		    {
			

			
				var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
						var items = x.responseText.trim();	
						if(parseInt(items)>0)
							{
							
							 $("#btnEdit").attr('disabled', true );
							 $("#btnDelete").attr('disabled', true ); 
							 
							 
							 
							}
						else
							{
							 
							}
					  
						
						
						
					} else {
					}
				}
				x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
				x.send();    
			
			
			}
		function funChkButton() {
			
			//frmEnquiry.submit();
		}

		function funSearchLoad(){
			 changeContent('nipurchaseMastersearch.jsp'); 
		}

			function funReset(){
				//$('#frmNipurchase')[0].reset(); 
			}
			function funReadOnly(){
				$('#frmNipurchase input').attr('readonly', true );
				$('#frmNipurchase select').attr('disabled', true );
				 $('#nipurchasedate').jqxDateTimeInput({ disabled: true});
				 $('#deliverydate').jqxDateTimeInput({ disabled: true});
				 
				 $('#invDate').jqxDateTimeInput({ disabled: true});
				 
				 $('#interstate').attr('disabled', true);
				 
				 
				 $('#nireftype').attr('disabled', true);
				  $('#cmbcurr').attr('disabled', true);
				 $('#acctype').attr('disabled', true);
				 $('#refno').attr('disabled', true);
				   $('#refslno').attr('disabled', true);
					$("#nidescdetailsGrid").jqxGrid({ disabled: true});
					 $('#txtproducttype').attr('disabled', true);
				   combochange();
					  getCurrencyIds();
				
			}
			function funRemoveReadOnly(){
				  funinterstate();
				$('#frmNipurchase input').attr('readonly', false );
				$('#frmNipurchase select').attr('disabled', false );
				 $('#nipurchasedate').jqxDateTimeInput({ disabled: false});
				 $('#deliverydate').jqxDateTimeInput({ disabled: false});
				 
				 $('#invDate').jqxDateTimeInput({ disabled: false});
				 $('#interstate').attr('disabled', false);
				 
				 
				 
				 $('#txtproducttype').attr('readonly', true);
				 
				 
				 $('#nireftype').attr('disabled', false);
				  $('#cmbcurr').attr('disabled', false);
				 $('#acctype').attr('disabled', false);;
				$('#docno').attr('readonly', true);
				 //$('#currate').attr('readonly', true);
				  $('#nipuraccid').attr('readonly', true);
				  $('#puraccname').attr('readonly', true);
				  $('#refno').attr('disabled', true);
				   $('#refslno').attr('disabled', true);
					  $('#refno').attr('readonly', true);
					  $('#refslno').attr('readonly', true);
			
					$("#nidescdetailsGrid").jqxGrid({ disabled: false});
					if ($("#mode").val() == "A") {
						
						$('#nipurchasedate').val(new Date());
						$('#deliverydate').val(new Date());
						 $("#nidescdetailsGrid").jqxGrid('clear');
						    $("#nidescdetailsGrid").jqxGrid('addrow', null, {});
						    $('#txtproducttype').attr('disabled', true);
						    document.getElementById("validates").value=0;
						    getCurrencyIds();
					   }
				if ($("#mode").val() == "E") {
					getCurrencyIds();
				  if($('#reftypeval').val()=="NPO")
					  {
					
					  $('#refno').attr('disabled', false);
					   $('#refslno').attr('disabled', false);
				  $('#refno').attr('readonly', true);
				   $('#refslno').attr('readonly', true);
					  }
						
					   }
				if($('#mode').val()=='A'){
					$('#cmbbilltype').val('1');
				}
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
				            if($("#mode").val()=="A"){
				            	funRoundRate(currateItems,"currate");
				            }
				            
				            if ($('#cmbcurrval').val() != null && $('#cmbcurrval').val() != "") {
					       		 $('#cmbcurr').val($('#cmbcurrval').val()) ;
					       		getRatevalue1($('#cmbcurrval').val(),$('#nipurchasedate').val());
					         } 
				        }
				   
				          else
				      {
				           optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
				           $("select#cmbcurr").html(optionscurr);
				         //  $("#currate").val(currateItems[0]);
				           
				       if($("#mode").val()=="A"){
				          funRoundRate(currateItems,"currate");
				       }
				      
				          if ($('#cmbcurrval').val() != null && $('#cmbcurrval').val() != "") {
					       		 $('#cmbcurr').val($('#cmbcurrval').val()) ;
					       		getRatevalue1($('#cmbcurrval').val(),$('#nipurchasedate').val());
					         } 
				          //$('#currate').attr('readonly', true);
				       
				      }
				    }
				       }
				   x.open("GET","getCurrencyId.jsp?date="+document.getElementById("nipurchasedate").value ,true);
					x.send();
				        
				      
				        }
				   function getRatevalue1(angel,date)
				   {
					 // alert(angel);
				   var x=new XMLHttpRequest();
				   x.onreadystatechange=function(){
				   if (x.readyState==4 && x.status==200)
				    {
				      var items= x.responseText;
				   /*       $('#currate').val(items) ; */
				         
				   if($("#mode").val()=="A"){
				         funRoundRate(items,"currate");  
				   }
				         
				        }
				          else
				      {
				      }
				       }
				   x.open("GET","getRateFrom.jsp?curr="+angel+"&date="+date,true);
					x.send();
				        
				      
				        }
				   function funrefdisslno()
				   {
					   
						 $("#nidescdetailsGrid").jqxGrid('clear');
						    $("#nidescdetailsGrid").jqxGrid('addrow', null, {});
						 
					   
					   if($('#nireftype').val()=="NPO") 
						  {
						   $('#refno').attr('disabled', false);
						   $('#refslno').attr('disabled', false);
						 
						 
						  } 
					   else
						   {
						   $('#refno').val(" ");
						   $('#refslno').val(" ");
						   $('#refno').attr('disabled', true);
						   $('#refslno').attr('disabled', true);
						   
						   }
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
					   if($('#reftypeval').val()!="")
						  {
						  
						  
						  $('#nireftype').val($('#reftypeval').val());
						  
						  if($('#reftypeval').val()=="NPO")
							  {
							
							  $('#refno').attr('disabled', false);
							   $('#refslno').attr('disabled', false);
						  $('#refno').attr('readonly', true);
						   $('#refslno').attr('readonly', true);
							  }
						  }
					   
					   
				   }
	
				   function setValues() {
					   combochange();
					   getCurrencyIds();
					  
					 //  $('#interstate').attr('disabled', true);
					   
					   
					   if($('#hidnipurchasedate').val()){
							$("#nipurchasedate").jqxDateTimeInput('val', $('#hidnipurchasedate').val());
						}
						
						if($('#hiddeliverydate').val()){
							$("#deliverydate").jqxDateTimeInput('val', $('#hiddeliverydate').val());
						}
						
						
						
						
						
						if($('#hidinvDate').val()){
							$("#invDate").jqxDateTimeInput('val', $('#hidinvDate').val());
						}
						var interstate=document.getElementById("hidinterstate").value;
						
						if(interstate>0){
							document.getElementById("interstate").checked=true;
						}
						else{
							document.getElementById("interstate").checked=false;
						}
						
						
						if($('#hidcmbbilltype').val!=""){
							$("#cmbbilltype").val($('#hidcmbbilltype').val());
							
							
							
						
						}
						
						
					 	var dis=document.getElementById("masterdoc_no").value;
						if(dis>0)
							{     
							funchkforedit();
					 	 var indexval1 = document.getElementById("masterdoc_no").value;   
							
				     	  		 
				     	  	
				     	  		 $("#nipurdetails").load("descgridDetails.jsp?nipurdoc="+indexval1);
				     	  		
							 } 
			
						 if($('#msg').val()!=""){
							   $.messager.alert('Message',$('#msg').val());
							  } 
						 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
						       
					}
				   $(function(){
				        $('#frmNipurchase').validate({
				                rules: { 
				              
				               	delterms:{maxlength:200},
				                	purdesc:{maxlength:200},
				                	payterms:{maxlength:200}
				                   
				                 },
				                 messages: {
				                	 delterms: {maxlength:"  Max 200 chars"},
				                	 purdesc: {maxlength:"  Max 200 chars"},
				                	 payterms: {maxlength:"  Max 200 chars"}
				                	
				                 }
				        });});
				/*    function diserror(){
					   document.getElementById("errormsg").innerText="";
				   } */
				    
				   function funPrintBtn(){

					    if ($("#mode").val() !== "view" || $("#masterdoc_no").val() === "") {
					        $.messager.alert('Message','Select a Document....!','warning');
					        return false;
					    }

					    var baseUrl = document.URL.split("saveActionNipurchase")[0];
					    var dtype   = $('#formdetailcode').val();
					    var brhid   = <%= session.getAttribute("BRANCHID").toString() %>;

					    var printUrl =
					        baseUrl +
					        "printniphs" +
					        "?docno=" + $("#masterdoc_no").val() +
					        "&dtype=" + dtype +
					        "&brhid=" + brhid;

					    openAndPrint(printUrl);
					}

				   function openAndPrint(url) {

					    var win = window.open(
					        url,
					        "_blank",
					        "top=250,left=310,width=900,height=800,scrollbars=yes"
					    );

					    if (win) {
					        setTimeout(function () {
					            win.focus();
					            win.print();
					            win.onafterprint = function () {
					                win.close();
					            };
					        }, 700);
					    } else {
					        $.messager.alert('Message','Popup blocked by browser','warning');
					    }
					}

						   
</script>
</head>
<body onLoad="setValues();">

<div id="mainBG" class="hidden-scrollbar homeContent" data-type="background">
<form id="frmNipurchase" action="saveActionNipurchase" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" /> 
     <table width="100%">
<tr>

    <!-- DATE -->
    <td width="8%" align="right">Date</td>
    <td width="15%">
        <div id="nipurchasedate"
             name="nipurchasedate"
             value='<s:property value="nipurchasedate"/>'></div>

        <input type="hidden"
               name="hidnipurchasedate"
               id="hidnipurchasedate"
               value='<s:property value="hidnipurchasedate"/>'>
    </td>

    <!-- SPACE BETWEEN -->
    <td width="60%"></td>

    <!-- DOC NO -->
    <td width="8%" align="right">Doc No</td>
    <td width="9%">
        <input type="text"
               name="docno"
               id="docno"
               value='<s:property value="docno"/>'
               readonly="readonly"
               tabindex="-1"
               style="width:120px;">
    </td>

</tr>
</table>
            
    <br/>

    <div class="section-block">
    <h2>Purchase Information</h2>

    <table class="cr-table" width="100%">

        <!-- ROW 1 -->
        <tr>
           

            <td align="right" width="10%"><label>Ref Type</label></td>
            <td width="15%">
                <select name="nireftype" id="nireftype"
                        value='<s:property value="nireftype"/>'
                        onchange="funrefdisslno()">
                    <option value="DIR">DIR</option>
                    <option value="NPO">NPO</option>
                </select>
            </td>

            
        </tr>

        <!-- ROW 2 -->
        <tr>
            <td align="right"><label>Inv NO</label></td>
            <td>
                <input type="text" id="invno" name="invno"
                       onblur="funchkinv();"
                       value='<s:property value="invno"/>'>
            </td>

            <td align="right"><label>Type</label></td>
            <td>
                <select name="cmbbilltype" id="cmbbilltype"
                        value='<s:property value="cmbbilltype"/>'>
                    <option value="1">VAT</option>
                    <option value="2">RCM</option>
                </select>
                <input type="hidden" id="hidcmbbilltype"
                       name="hidcmbbilltype"
                       value='<s:property value="hidcmbbilltype"/>'/>
            </td>

            <td align="right"><label>Inv Date</label></td>
            <td>
                <div id="invDate" name="invDate"
                     value='<s:property value="invDate"/>'></div>
                <input type="hidden" id="hidinvDate"
                       name="hidinvDate"
                       value='<s:property value="hidinvDate"/>'>
            </td>
        </tr>

        <!-- ROW 3 -->
        <tr>
            <!-- REF NO (MOVED HERE) -->
            <td align="right"><label>Ref No</label></td>
            <td>
                <input type="text" name="refno" id="refno"
                       placeholder="Press F3 To Search"
                       value='<s:property value="refno"/>'
                       onKeyDown="getrefnosearch(event);">
            </td>

            <td colspan="4"></td>
        </tr>

    </table>
</div>
    
    <div class="section-block">
        <h2>Vendor & Financials</h2>
        <table class="cr-table" width="100%">
            <tr>
                <td width="8%" align="right"><label>Vendor</label></td>
                <td width="40%">
                    <div style="display: flex; gap: 8px;">
                        <input type="text" name="nipuraccid" id="nipuraccid" value='<s:property value="nipuraccid"/>' placeholder="Press F3" style="width:30%;" onKeyDown="getaccountdetails(event);" >  
                        <input type="text" id="puraccname" name="puraccname" value='<s:property value="puraccname"/>'>
                    </div>
                    <input type="hidden" name="acctype" id="acctype" value='<s:property value="acctype"/>'>
                </td>
                <td align="right" width="8%"><label>Curr / Rate</label></td>
                <td width="25%">
                    <div style="display: flex; gap: 8px;">
                        <select name="cmbcurr" id="cmbcurr" style="pointer-events:none;" tabindex="-1" value='<s:property value="cmbcurr"/>' onchange="getRatevalue1(this.value,$('#nipurchasedate').val());">
                            <option value="-1">--Select--</option>
                        </select>
                        <input type="text" name="currate" id="currate" value='<s:property value="currate"/>' style="width: 100px;">
                    </div>
                </td>
                <td align="right" width="8%"><label>Bill Type</label></td>
                <td>
                    <input type="text" id="txtproducttype" name="txtproducttype" placeholder="Press F3" onKeyDown="getProdType(event);" value='<s:property value="txtproducttype"/>' />
                </td>
            </tr>
        </table>
    </div>

    <div class="section-block">
        <h2>Terms & Logistics</h2>
        <table class="cr-table" width="100%">
            <tr>
                <td width="10%" align="right"><label>Del Date</label></td>
                <td width="15%">
                    <div id="deliverydate" name="deliverydate" value='<s:property value="deliverydate"/>'></div>
                    <input type="hidden" name="hiddeliverydate" id="hiddeliverydate" value='<s:property value="hiddeliverydate"/>'>
                </td>
                <td width="10%" align="right"><label>Del Terms</label></td>
                <td><input type="text" name="delterms" id="delterms" value='<s:property value="delterms"/>'></td>
            </tr>
            <tr>
                <td align="right"><label>Pay Terms</label></td>
                <td colspan="3"><input type="text" name="payterms" id="payterms" value='<s:property value="payterms"/>'></td>
            </tr>
            <tr>
                <td align="right"><label>Description</label></td>
                <td colspan="3"><input type="text" name="purdesc" id="purdesc" value='<s:property value="purdesc"/>'></td>
            </tr>
        </table>
    </div>

    <div class="section-block">
        <h2>Item Details</h2>
        <div id="nipurdetails">
            <jsp:include page="descgridDetails.jsp"></jsp:include>
        </div>
    </div>

    <div style="display:none;">
        <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/>
        <input type="hidden" id="ordermasterdoc_no" name="ordermasterdoc_no" value='<s:property value="ordermasterdoc_no"/>'/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>   
        <input type="hidden" id="nettotal" name="nettotal" value='<s:property value="nettotal"/>'/>
        <input type="hidden" id="rowval" name="rowval" value='<s:property value="rowval"/>'/>
        <input type="hidden" id="accdocno" name="accdocno" value='<s:property value="accdocno"/>'/>  
        <input type="hidden" id="descgridlenght" name="descgridlenght" value='<s:property value="descgridlenght"/>'/>    
        <input type="hidden" id="cmbcurrval" name="cmbcurrval" value='<s:property value="cmbcurrval"/>'/>    
        <input type="hidden" id="acctypeval" name="acctypeval" value='<s:property value="acctypeval"/>'/>  
        <input type="hidden" id="reftypeval" name="reftypeval" value='<s:property value="reftypeval"/>'/>  
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="taxpers" name="taxpers" value='<s:property value="taxpers"/>'/>
        <input type="hidden" id="taxaccount" name="taxaccount" value='<s:property value="taxaccount"/>'/>
        <input type="hidden" id="refslno" name="refslno" value='<s:property value="refslno"/>' >
    </div>
</form>

    <div id="accountSearchwindow"><div></div></div>
    <div id="accounttypeSearchwindow"><div></div></div>
    <div id="costtpesearchwndow"><div></div></div>
    <div id="costcodesearchwndow"><div></div></div> 
    <div id="refnosearchwindow"><div></div></div> 
    <div id="nipurchslnosearch"><div></div></div> 
    <div id="typesearchwindow"><div></div></div>
</div>
</body>
</html>