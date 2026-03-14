<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html>
<html>
<%-- <% String contextPath=request.getContextPath();%> --%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i) - Vehicle Purchase Order</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
    /* ------------------------------
       GLOBAL STYLES & LAYOUT (Adopted from Credit Note)
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
        padding: 20px;
        max-width: 100%;
        margin: auto;
        box-shadow: 0 4px 24px rgba(0,0,0,0.06);
        /* FORCE HEADER LEFT ALIGNMENT */
        text-align: left !important; 
    }

    /* ------------------------------
       HEADER FIXES (Title & Buttons)
    ------------------------------ */
    
    /* This overrides any <center> tags coming from header.jsp */
    center {
        text-align: left !important;
        display: block;
        width: 100%;
        margin-left: 0;
    }
    
    /* Force the Title (#formdet) to be Left Aligned and Big */
    #formdet {
        font-size: 24px !important;
        font-weight: 700 !important;
        color: #2c3e50;
        margin-bottom: 15px;
        display: block;
        text-align: left !important;
        font-family: 'Segoe UI', sans-serif;
    }

    /* ------------------------------
       GRID SYSTEM (FORM LAYOUT)
    ------------------------------ */
    .receipt-header {
        display: grid;
        grid-template-columns: auto 1fr auto 1fr; /* Simplified for date/docno */
        gap: 15px 30px;
        align-items: center;
        margin-bottom: 20px;
        padding: 0 0 0 5px; 
    }

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
        grid-template-columns: 120px 1fr 1fr; /* Label + 2 inputs */
    }

    .section-row {
        display: flex;
        gap: 26px;
        margin-bottom: 30px;
    }

    .section-block {
        flex: 1;
        background: #f6f8fa;
        border-radius: 12px;
        padding: 20px; /* Internal padding */
        box-shadow: 0 1px 8px rgba(160,177,217,0.1);
    }

    .section-block.full-width {
        flex-basis: 100%;
    }

    .section-block h2 {
        font-size: 17.6px;
        font-weight: 600;
        margin: 0 0 20px;
        padding-left: 10px;
        border-left: 4px solid #007bff;
        color: #333;
    }

    /* ------------------------------
       INPUTS & CONTROLS
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
    
    input[readonly] {
        background-color: #f3f4f6;
        color: #6b7280;
    }

    label {
        font-weight: 600;
        color: #253858;
        white-space: nowrap;
        text-align: right;
        padding-right: 10px;
        font-size: 16px;
    }
    
    /* Small adjustment for the Doc No. input to not take full grid width */
    #docno {
        width: 120px !important;
    }

    /* ------------------------------
       TABLES & UTILS
    ------------------------------ */
    .table-section { margin: 20px 0; }
    .table-section h3 {
        color: #253858; font-size: 1.05rem; font-weight: 600; margin-bottom: 12px;
    }
    
    .hidden-scrollbar { 
        overflow: auto; 
        /* Adjust height slightly for better fit, as the new layout is more compact */
        max-height: calc(100vh - 100px); 
    }
    .hidden-scrollbar::-webkit-scrollbar { width: 0px; } 

    /* Styles for the Tax/Total Footer */
    #taxtable {
        display: grid;
        grid-template-columns: 1fr repeat(4, auto); /* Aligning label, tax amount, net total */
        gap: 15px;
        align-items: center;
        padding: 15px 20px;
        background: #f1f3f6;
        border-radius: 8px;
        margin-top: 20px;
        box-shadow: 0 -2px 5px rgba(0,0,0,0.03);
    }
    #taxtable td {
        padding: 0;
        border: none;
    }
    #taxtable td:nth-child(2) { /* Tax Amount Label */
        text-align: right;
        font-weight: 600;
        color: #253858;
        white-space: nowrap;
    }
    #taxtable td:nth-child(4) { /* Net Total Label */
        text-align: right;
        font-weight: 700;
        color: #1e3a8a;
        white-space: nowrap;
    }
    #taxtable input[type="text"] {
        width: 120px !important;
        font-weight: 700;
        height: 38px !important;
        font-size: 15px;
    }
    
    /* Override for standard jqx styling in table sections */
    fieldset {
        border: none;
        padding: 0;
        margin: 0;
    }
    
    form label.error {
        color:red;
        font-weight:bold;
        font-size: 12px;
        margin-left: 5px;
        display: inline-block;
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
  }
 
</style>

<script type="text/javascript">
	// ... (Your existing JavaScript functions remain here, unchanged for styling)
	// funReadOnly(), funRemoveReadOnly(), funtaxchk(), etc.
	$(document).ready(function() {
		
		 $("#vehpurorderDate").jqxDateTimeInput({ width: '120px', height: '15px', formatString:"dd.MM.yyyy"});

		 $("#vehpurorderdelDate").jqxDateTimeInput({ width: '120px', height: '15px', formatString:"dd.MM.yyyy"});
		 $('#brandsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Brand Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	     $('#brandsearchwndow').jqxWindow('close'); 

	     $('#modelsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Model Search' ,position: { x: 250, y:60 }, keyboardCloseKey: 27});
	     $('#modelsearchwndow').jqxWindow('close');
	     $('#colorsearchwndow').jqxWindow({ width: '25%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Color Search' ,position: { x: 800, y:60 }, keyboardCloseKey: 27});
	     $('#colorsearchwndow').jqxWindow('close');
	     $('#groupwindow').jqxWindow({ width: '25%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Group Search' ,position: { x: 800, y:60 }, keyboardCloseKey: 27});
	     $('#groupwindow').jqxWindow('close');
	     $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
		 $('#accountSearchwindow').jqxWindow('close');
		     
		     $('#refnosearchwindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
			   $('#refnosearchwindow').jqxWindow('close'); 
			   
			   
			   
			   $('#vehrefno').dblclick(function(){
				   
				
				   
			  	    $('#refnosearchwindow').jqxWindow('open');
			  	
			  	  refsearchContent('vehreqRefnoSearch.jsp?'); 
			          
		  }); 
			   
			   
		 
	    $('#accid').dblclick(function(){
	    	   if($('#mode').val()=="A" || $('#mode').val()=="E" )
		          {
		          
		  	    $('#accountSearchwindow').jqxWindow('open');
		  	
		  	  accountSearchContent('accountsDetailsSearch.jsp');
		          }
	  }); 
	    
	    $('#vehpurorderDate').on('change', function (event) {
	        var maindate = $('#vehpurorderDate').jqxDateTimeInput('getDate');
	  	 	 if ($("#mode").val() == "A" || $('#mode').val()=="E" ) {   
	     funDateInPeriod(maindate);
	    	 }
	   });
	    
		
	});
	function getrefDetails(event){
	 	 var x= event.keyCode;
	 	 if(x==114){
	 	  $('#refnosearchwindow').jqxWindow('open');
	 	
	 	 refsearchContent('vehreqRefnoSearch.jsp?');  }
	 	 else{
	 		 }
	 	 }  
		  function refsearchContent(url) {
	       //alert(url);
	          $.get(url).done(function (data) {
	//alert(data);
	        $('#refnosearchwindow').jqxWindow('setContent', data);

		}); 
	    	}
	function getaccountdetails(event){
		
		  if($('#mode').val()=="A" || $('#mode').val()=="E" )
          {
	 	 var x= event.keyCode;
	 	 if(x==114){
	 	  $('#accountSearchwindow').jqxWindow('open');
	 	
	 	 accountSearchContent('accountsDetailsSearch.jsp');    }
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
    function brandinfoSearchContent(url) {
     	 //alert(url);
     		 $.get(url).done(function (data) {
     			 
     			 $('#brandsearchwndow').jqxWindow('open');
     		$('#brandsearchwndow').jqxWindow('setContent', data);
     
     	}); 
     	} 
         function modelinfoSearchContent(url) {
          	 //alert(url);
          		 $.get(url).done(function (data) {
          			 
          			 $('#modelsearchwndow').jqxWindow('open');
          		$('#modelsearchwndow').jqxWindow('setContent', data);
          
          	}); 
          	} 
         function colorinfoSearchContent(url) {
           	 //alert(url);
           		 $.get(url).done(function (data) {
           			 
           			 $('#colorsearchwndow').jqxWindow('open');
           		$('#colorsearchwndow').jqxWindow('setContent', data);
           
           	}); 
           	}
         
	function groupSearchContent(url) {
    	$.get(url).done(function (data) {
        	$('#groupwindow').jqxWindow('open');
           	$('#groupwindow').jqxWindow('setContent', data);
		}); 
    } 
           	
        
      

	
	 function funReadOnly(){
		 funtaxchk();
			$('#frmpurorder input').attr('readonly', true );
			$('#frmpurorder select').attr('disabled', true);
			
			$('#vehpurorderDate').jqxDateTimeInput({disabled: true});
			$('#vehpurorderdelDate').jqxDateTimeInput({disabled: true});
			$("#vehoredergrid").jqxGrid({ disabled: true});
			 $('#vehrefno').attr('disabled', true);
			  $('#nettotal').attr('readonly', true);
			  
			  $('#taxamount').attr('readonly', true); 
			  
			  
			 
			 
			 
	 }
	 function funRemoveReadOnly(){
		 funtaxchk();
		  $('#taxamount').attr('readonly', true); 
		 $('#nettotal').attr('readonly', true);
			$('#frmpurorder input').attr('readonly', false );
			$('#frmpurorder select').attr('disabled', false);
			$("#vehoredergrid").jqxGrid({ disabled: false});
			$('#vehpurorderdelDate').jqxDateTimeInput({disabled: false});
			$('#vehpurorderDate').jqxDateTimeInput({disabled: false});
			 $('#vehrefno').attr('disabled', true);
			$('#docno').attr('readonly', true);
			  $('#vehpuraccname').attr('readonly', true);
			  $('#accid').attr('readonly', true);
			  $('#vehrefno').attr('readonly', true);
			  
			  
			if ($("#mode").val() == "A") {
				$('#vehpurorderdelDate').val(new Date());
				$('#vehpurorderDate').val(new Date());
				 $("#vehoredergrid").jqxGrid('clear');
				    $("#vehoredergrid").jqxGrid('addrow', null, {});
			   }
			
			if ($("#mode").val() == "E") {
			if($('#vehtype').val()=="VPR")
			  {
			
			  $('#vehrefno').attr('disabled', false);
		     $('#vehrefno').attr('readonly', true);
		
			  }
			}
			
	 }
	
	 
	 function funtaxchk()
	    {
		
		 			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText.trim();	
					if(parseInt(items)>0)
					{
					 $("#taxtable").show();
					}
				else
					{
					 $("#taxtable").hide();
					}
				  
					
					
					
				} else {
				}
			}
			x.open("GET", "chkconfig.jsp?", true);
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
						 $("#btnEdit").attr('disabled', false);
						 $("#btnDelete").attr('disabled', false);
						}
				  
					
					
					
				} else {
				}
			}
			x.open("GET", "orderlinkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
			x.send();
		
		
		}
	 
	 
	   function funrefdisslno()
	   {
		   if($('#vehtype').val()=="VPR") 
			  {
			   $('#vehrefno').attr('disabled', false);
			 
			 
			 
			  } 
		   else
			   {
			   $('#vehrefno').val("");
			
			   $('#vehrefno').attr('disabled', true);
			  
			   
			   }
	   }
	 
	 function funSearchLoad(){
		 
		changeContent('vehOrederMastersearch.jsp'); 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus()
	    {
	    	$('#vehpurorderDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	 
	
	   
	  function funNotify(){
		  
		  var maindate = $('#vehpurorderDate').jqxDateTimeInput('getDate');
		   var validdate=funDateInPeriod(maindate);
		   if(validdate==0){
		   return 0; 
		   }
			if( document.getElementById("vehtype").value=="VPR")
			{
	           var refno= document.getElementById('masterrefno').value;
			 
			 if(refno=="")
			 {
				 document.getElementById("errormsg").innerText=" Select Ref NO";	
				 document.getElementById('vehrefno').focus();
				 return 0;
			 }
			 
			 else
				 {
				 document.getElementById("errormsg").innerText="";
				 }
			 
		 
			}
			
		var purid= document.getElementById("accid").value;

		if(purid=="")
			{
			 document.getElementById("errormsg").innerText=" Select An Account";
			 document.getElementById("accid").focus();

			 return 0;
			   }
		else
			   {
			   document.getElementById("errormsg").innerText="";
			   } 
		var refval= document.getElementById("nettotal").value;
		  if(refval=="")
			{
			 document.getElementById("errormsg").innerText="Total is Empty";
			 

			 return 0;
			   }
		else
			   {
			   document.getElementById("errormsg").innerText="";
			   }
		  var rows = $("#vehoredergrid").jqxGrid('getrows');
		    $('#vehoredergridlenght').val(rows.length);
		   //alert($('#gridlength').val());
		   for(var i=0 ; i < rows.length ; i++){
		   // var myvar = rows[i].tarif; 
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
               .attr("id", "vehodrtest"+i)
		       .attr("name", "vehodrtest"+i)
		       .attr("hidden", "true");   
		 
		   newTextBox.val(rows[i].sr_no+"::"+rows[i].brdid+" :: "+rows[i].modid+" :: " 
				   +rows[i].specification+" :: "+rows[i].clrid+" :: "+rows[i].qty+" :: "+rows[i].price+" :: "+rows[i].total+" :: "+rows[i].saveqty+" :: "+rows[i].rowno+" :: "+rows[i].qutval+" :: "+rows[i].vehgroupid+" :: ");
		
		   newTextBox.appendTo('form');
		  
		    
		   }   
				 /* Applying Invoice Grid Updating Ends*/
				 
	    		return 1;
		} 
	 function  changeval()
	 {
		 
		 if($('#vehtypeval').val()!="")
		  {
		  
		  
		  $('#vehtype').val($('#vehtypeval').val());
		  }
		 
		 if($('#vehtypeval').val()=="VPR")
		  {
		
		  $('#vehrefno').attr('disabled', false);
		  
	  $('#vehrefno').attr('readonly', true);
	
		  }
	 }
	 function diserror()
	 {
		 
		 document.getElementById("errormsg").innerText=""; 
	 }
	  
	  function setValues(){
		 
		  if($('#hidvehpurorderDate').val()){
				 $("#vehpurorderDate").jqxDateTimeInput('val', $('#hidvehpurorderDate').val());
			  }
		 
		  
		  if($('#hidvehpurorderdelDate').val()){
				 $("#vehpurorderdelDate").jqxDateTimeInput('val', $('#hidvehpurorderdelDate').val());
			  }
		
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
			 
			
			var indexVa5 = document.getElementById("masterdoc_no").value;
		
	         if(indexVa5>0){
	        	 funchkforedit();
	         $("#vehorder").load("vehorderDetails.jsp?masterdoc="+indexVa5);  
	         } 
	         
	         changeval();
	         document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		}
	  
	  $(function(){
	        $('#frmpurorder').validate({
	        	 rules: { 
	        		 vehdesc:{maxlength:200}
	        		
	        	 },
		                 messages: {
		                	
		                	 vehdesc: {maxlength:"  Max 200 chars"}
		              
	                 }
	        });});
	
	    function funPrintBtn(){
	   	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	   	  
	   	   var url=document.URL;

	          var reurl=url.split("savePurchaseorder");
	          
	          $("#docno").prop("disabled", false);                
	          
	    
	  var win= window.open(reurl[0]+"printPurchorder?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	       
	  win.focus();
	   	   } 
	   	  
	   	   else {
	  	    	      $.messager.alert('Message','Select a Document....!','warning');
	  	    	      return false;
	  	    	     }
	  	    	
	   	}
</script>


</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >

<div class='hidden-scrollbar'>
<form id="frmpurorder" action="savePurchaseorder" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

   <div class="receipt-header" style="display:flex; justify-content:space-between; align-items:center;">

    <!-- Date -->
    <div style="display:flex; align-items:center; gap:8px;">
        <label>Date</label>
        <div>
            <div id="vehpurorderDate" name="vehpurorderDate" value='<s:property value="vehpurorderDate"/>'></div>
            <input type="hidden" id="hidvehpurorderDate" name="hidvehpurorderDate"
                   value='<s:property value="hidvehpurorderDate"/>'/>
        </div>
    </div>

    <!-- Doc No -->
    <div style="display:flex; align-items:center; gap:8px;">
        <label>Doc No.</label>
        <input type="text" id="docno" name="docno"
               value='<s:property value="docno"/>'
               tabindex="-1" readonly style="width:120px;">
    </div>

</div>
    <div class="section-row">
        <div class="section-block">
            <h2>Order Details</h2>
            
            <div class="form-group single-label-dual-input">
                <label for="accid">Vendor</label>
                <input type="text" id="accid" name="accid" placeholder="Press F3 to Search" value='<s:property value="accid"/>' onkeydown="getaccountdetails(event)" onblur="diserror()" />
                <input type="text" id="vehpuraccname" name="vehpuraccname" value='<s:property value="vehpuraccname"/>' tabindex="-1" readonly/>
                <input type="hidden" id="headdoc" name="headdoc" value='<s:property value="headdoc"/>'/>
            </div>

            <div class="form-group dual-input">
                <label for="vehtype">Type</label>
                <select id="vehtype" name="vehtype" value='<s:property value="vehtype"/>' onchange="funrefdisslno()">
                    <option value="DIR">DIR</option>
                    <option value="VPR">VPR</option>
                </select>
                
                <label for="vehrefno">Ref. No.</label>
                <input type="text" id="vehrefno" name="vehrefno" placeholder="Press F3 to Search" value='<s:property value="vehrefno"/>' onkeydown="getrefDetails(event)"/>
            </div>
        </div>

        <div class="section-block">
            <h2>Delivery & Description</h2>
            <div class="form-group">
                <label for="vehpurorderdelDate">Exp. Delivery</label>
                <div>
                    <div id="vehpurorderdelDate" name="vehpurorderdelDate" value='<s:property value="vehpurorderdelDate"/>'></div>
                    <input type="hidden" id="hidvehpurorderdelDate" name="hidvehpurorderdelDate" value='<s:property value="hidvehpurorderdelDate"/>'/>
                </div>
            </div>
            
            <div class="form-group">
                <label for="vehdesc">Description</label>
                <input type="text" id="vehdesc" name="vehdesc" value='<s:property value="vehdesc"/>'/>
            </div>
        </div>
    </div>

    <div class="table-section section-block full-width" style="padding: 20px 0;">
        <h2>Vehicle Details</h2>
        <div id="vehorder" style="padding: 0 20px;"><jsp:include page="vehorderDetails.jsp"></jsp:include></div>
    </div>
    
    <div id="taxtable" >
        <div id="taxlabel"></div>
        
        <label id="taxlabel">Tax Amount</label>
        <div><input type="text" id="taxamount" name="taxamount" style="text-align: right;" value='<s:property value="taxamount"/>' readonly></div>
        
        <label>Net Total</label>
        <div><input type="text" id="nettotal" name="nettotal" value='<s:property value="nettotal"/>' style="text-align: right;" readonly/></div>
    </div>


<input type="hidden" id="masterrefno" name="masterrefno" value='<s:property value="masterrefno"/>'/>
<input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/>
<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="brandval" name="brandval" value='<s:property value="brandval"/>'/>
<input type="hidden" id="headacccode" name="headacccode" value='<s:property value="headacccode"/>'/>
<input type="hidden" id="vehoredergridlenght" name="vehoredergridlenght" value='<s:property value="vehoredergridlenght"/>'/>
<input type="hidden" id="vehtypeval" name="vehtypeval" value='<s:property value="vehtypeval"/>'/>
<input type="hidden" id="txtnontaxableentity" name="txtnontaxableentity" value='<s:property value="txtnontaxableentity"/>'/>
<input type="hidden" id="txttaxpercentage" name="txttaxpercentage" value='<s:property value="txttaxpercentage"/>'/>

</form>

</div> </div> <div id="colorsearchwndow">
   <div ></div>
</div>
<div id="groupwindow">
   <div ></div>
</div>
<div id="modelsearchwndow">
   <div ></div>
</div>
<div id="brandsearchwndow">
   <div ></div>
</div>
<div id="accountSearchwindow">
   <div ></div>
</div>
<div id="refnosearchwindow">
   <div ></div>
</div>

</body>
</html>