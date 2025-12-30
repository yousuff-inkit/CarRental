<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
 <jsp:include page="../../../../includes.jsp"></jsp:include>

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
    min-height: 100vh;
    box-sizing: border-box;
    font-size: 15px;
    font-weight: 700 !important; /* Global Boldness */
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 20px;
    max-width: 100% !important; /* Force 100% width */
    margin: auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
    text-align: left !important;
}

/* Make all text bolder */
* {
    font-weight: 700 !important;
}

/* ------------------------------
    SECTION BLOCKS & HEADERS
------------------------------ */
.section-block {
    background: #f6f8fa;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.1);
    margin-bottom: 20px;
}

/* Blue vertical line for headers */
.section-block h2 {
    font-size: 1.3rem;
    font-weight: 700 !important;
    margin: 0 0 20px;
    padding-left: 12px;
    border-left: 5px solid #007bff;
    color: #253858;
    display: flex;
    align-items: center;
}

/* ------------------------------
    INPUTS & CONTROLS
------------------------------ */
input[type="text"], select, textarea, input[type="email"] {
    height: 38px !important; /* Increased height for bold text */
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 8px 12px;
    background: #fff;
    transition: border-color 0.2s;
    font-size: 15px !important;
    box-sizing: border-box;
    width: 100%;
    color: #222 !important;
}

input[type="text"]:focus, select:focus {
    border-color: #007bff;
    outline: none;
}

label {
    font-weight: 600 !important;
    color: #253858;
    white-space: nowrap;
    font-size: 15px;
}

/* ------------------------------
    TABLES & GRIDS (UNTOUCHED LOGIC)
------------------------------ */
.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #fff;
    border-radius: 8px;
    overflow: hidden;
}

.cr-table td {
    padding: 12px 14px;
    border-bottom: 1px solid #e4e7ec;
    font-size: 15px;
    vertical-align: middle;
}

.cr-table td[align="right"] {
    font-weight: 700 !important;
    text-align: right;
}

.hidden-scrollbar {
    overflow-y: auto;
    height: 100vh;
    overflow-x: hidden;
}

/* Hidden Scrollbar Utility */
.hidden-scrollbar::-webkit-scrollbar {
    width: 0px;
}

/* JQX Widget Overrides */
.jqx-datetimeinput {
    height: 38px !important;
    width: 100% !important;
}

/* Error Message */
form label.error {
    color: red !important;
    font-size: 14px;
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
				 	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
				 	  
				 	   var url=document.URL;

				        var reurl=url.split("saveActionNipurchase");
				        
				        $("#docno").prop("disabled", false);                
				        var dtype=$('#formdetailcode').val();
						 var brhid=<%= session.getAttribute("BRANCHID").toString()%>
				  
				var win= window.open(reurl[0]+"printniphs?docno="+document.getElementById("masterdoc_no").value+"&dtype="+dtype+"&brhid="+brhid,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
				     
				win.focus();
				 	   } 
				 	  
				 	   else {
					    	      $.messager.alert('Message','Select a Document....!','warning');
					    	      return false;
					    	     }
					    	
				 	}
						   
</script>
</head>
<body onLoad="setValues();">

<div id="mainBG" class="hidden-scrollbar homeContent" data-type="background">
<form id="frmNipurchase" action="saveActionNipurchase" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" /> 
    <br/>

    <div class="section-block">
        <h2>Purchase Information</h2>
        <table class="cr-table" width="100%">
            <tr>
                <td width="8%" align="right"><label>Date</label></td>
                <td width="15%">
                    <div id="nipurchasedate" name="nipurchasedate" value='<s:property value="nipurchasedate"/>'></div>
                    <input type="hidden" name="hidnipurchasedate" id="hidnipurchasedate" value='<s:property value="hidnipurchasedate"/>'>
                </td>
                <td align="right" width="10%"><label>Ref Type</label></td>
                <td width="15%">
                    <select name="nireftype" id="nireftype" value='<s:property value="nireftype"/>' onchange="funrefdisslno()">
                        <option value="DIR">DIR</option>
                        <option value="NPO">NPO</option>
                    </select>
                </td>
                <td align="right" width="8%"><label>Ref No</label></td>
                <td>
                    <input type="text" name="refno" id="refno" placeholder="Press F3 To Search" value='<s:property value="refno"/>' onKeyDown="getrefnosearch(event);">
                </td>
            </tr>
            <tr>
                <td align="right"><label>Inv NO</label></td>
                <td><input type="text" id="invno" name="invno" onblur="funchkinv();" value='<s:property value="invno"/>'></td>
                <td align="right"><label>Type</label></td>
                <td>
                    <select name="cmbbilltype" id="cmbbilltype" value='<s:property value="cmbbilltype"/>'>
                        <option value="1">VAT</option>
                        <option value="2">RCM</option>
                    </select>
                    <input type="hidden" id="hidcmbbilltype" name="hidcmbbilltype" value='<s:property value="hidcmbbilltype"/>'/>
                </td>
                <td align="right"><label>Inv Date</label></td>
                <td>
                    <div id="invDate" name="invDate" value='<s:property value="invDate"/>'></div>
                    <input type="hidden" id="hidinvDate" name="hidinvDate" value='<s:property value="hidinvDate"/>'>
                </td>
            </tr>
            <tr>
                <td align="right"><label>Doc No</label></td>
                <td><input type="text" name="docno" id="docno" tabindex="-1" value='<s:property value="docno"/>' readonly="readonly"></td>
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