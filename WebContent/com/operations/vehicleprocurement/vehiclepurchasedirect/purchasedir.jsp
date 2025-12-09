<%@ taglib prefix="s" uri="/struts-tags"%>
<%@page import="java.util.*" %>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="com.operations.vehicleprocurement.vehiclepurchasedirect.ClspurchaseDirectDAO" %>
<% 
	String contextPath=request.getContextPath();
	ClspurchaseDirectDAO pdao=new ClspurchaseDirectDAO();
	int method=pdao.getTaxMethod();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i) - Vehicle Purchase Direct</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>

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
        max-width: 1450px;
        margin: auto;
        box-shadow: 0 4px 24px rgba(0,0,0,0.06);
        text-align: left !important; 
    }

    /* ------------------------------
       HEADER FIXES (Title & Buttons)
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

    /* ------------------------------
       GRID SYSTEM (FORM LAYOUT)
    ------------------------------ */
    .receipt-header {
        display: grid;
        grid-template-columns: auto 1fr auto 1fr;
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
    
    .section-block {
        background: #f6f8fa;
        border-radius: 12px;
        padding: 20px; 
        box-shadow: 0 1px 8px rgba(160,177,217,0.1);
        margin-bottom: 30px;
    }
    
    .section-block h2 {
        font-size: 1.1rem;
        font-weight: 600;
        margin: 0 0 20px;
        padding-left: 10px;
        border-left: 4px solid #007bff;
        color: #333;
    }
    
    /* Input Group Variations for this page */
    .vendor-inv-row {
        display: grid;
        grid-template-columns: auto 1fr 1fr auto 1fr auto 1fr auto; 
        gap: 15px 20px;
        align-items: center;
        margin-bottom: 12px;
    }
    .description-row {
        display: grid;
        grid-template-columns: 120px 1fr;
        gap: 12px;
        align-items: center;
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
        font-size: 14px;
    }
    
    #docno {
        width: 120px !important;
    }
    
    /* Footer Totals Style */
    .footer-totals {
        display: grid;
        grid-template-columns: 1fr auto auto auto 1fr auto auto; /* Spacing, Tax Label, Tax Box, Net Label, Net Box */
        gap: 10px 15px;
        align-items: center;
        padding: 15px 20px;
        background: #f1f3f6;
        border-radius: 8px;
        margin-top: 20px;
        box-shadow: 0 -2px 5px rgba(0,0,0,0.03);
    }
    .footer-totals label {
        font-weight: 700;
        color: #2c3e50;
        padding: 0;
    }
    .footer-totals input[type="text"] {
        width: 120px !important;
        text-align: right;
        font-weight: 700;
        height: 38px !important;
        font-size: 15px;
        padding: 6px;
    }
    .footer-totals .spacer {
        grid-column: 1 / span 3; /* Spans the first 3 columns to push totals right */
    }


    /* ------------------------------
       TABLES & UTILS
    ------------------------------ */
    .hidden-scrollbar {
        overflow: auto;
        height: 530px;
    }
    .hidden-scrollbar::-webkit-scrollbar {
        width: 0px;
    }
    
    fieldset {
        border: none;
        padding: 0;
        margin: 0;
    }
    
    form label.error {
        color:red;
        font-weight:bold;
        font-size: 12px;
    }
</style>

<script type="text/javascript">
	$(document).ready(function() {
		 var meth='<%=method%>'
			 
		 if(meth==0){
			 document.getElementById("txttaxamount").style.display="none";
			 document.getElementById("lbltax").style.display="none";
			 
		 }
		 
		 $("#vehpurorderDate").jqxDateTimeInput({ width: '120px', height: '15px', formatString:"dd.MM.yyyy"});
		
		 $("#vehpurinvDate").jqxDateTimeInput({ width: '120px', height: '15px', formatString:"dd.MM.yyyy"});
		 
	     $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
		 $('#accountSearchwindow').jqxWindow('close');
		     
		     $('#fleetwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' ,title: 'Fleet Search' , position: { x: 150, y: 60 }, keyboardCloseKey: 27});
			 $('#fleetwindow').jqxWindow('close');
				     
			  
			
			    $('#accid').dblclick(function(){
			    	
			    	   if($('#mode').val()!="view")
				          {
				  	    $('#accountSearchwindow').jqxWindow('open');
				  	
				  	  accountSearchContent('accountsDetailsSearch.jsp?');
				          }
			  }); 	   
	 
	 
				 
				 $("#btnEdit").attr('disabled', true );
		  
		    
	    $('#vehpurorderDate').on('change', function (event) {
	        var maindate = $('#vehpurorderDate').jqxDateTimeInput('getDate');
	  	 	 if ($("#mode").val() != "view"  ) {   
	     funDateInPeriod(maindate);
	    	 }
	   });  
		    
	       
		 
	   
	    
	 //   $("#imagedivv").hide(); 

		
	});
			   
			   function commenSearchContent(url) {
				 	 //alert(url);
				 		 $.get(url).done(function (data) {
				 			 
				 			 $('#accountSearchwindow').jqxWindow('open');
				 		$('#accountSearchwindow').jqxWindow('setContent', data);
				 
				 	}); 
				 	} 	
			   
			  
			 //   getfinacc(event)
			function  getfinacc(event){
	 	 var x= event.keyCode;
	 	 if(x==114){
	 		
	 	  $('#accountSearchwindow').jqxWindow('open');
	 	
	 	 commenSearchContent('finaccountSearch.jsp?');
		          }
	 		   
	 	 else{
	 		 }
	 	 }     
			   
 
	function fleetSearchContent(url) {
	 	 //alert(url);
	 		 $.get(url).done(function (data) {
	 			 
	 			 $('#fleetwindow').jqxWindow('open');
	 		$('#fleetwindow').jqxWindow('setContent', data);
	 
	 	}); 
	 	} 
	
	
	function getaccountdetails(event){
	 	 var x= event.keyCode;
	 	 if(x==114){
	 		   if($('#mode').val()!="view")
		          {
	 	  $('#accountSearchwindow').jqxWindow('open');
	 	
	 	 accountSearchContent('accountsDetailsSearch.jsp?'); 
		          }
	 		   }
	 	 else{
	 		 }
	 	 }  
		  function accountSearchContent(url) {
	       //alert(url);
	          $.get(url).done(function (data) {
	//alert(data);
	        $('#accountSearchwindow').jqxWindow('setContent', data);

		}); 
	    	}
   
        
      

	
	 function funReadOnly(){
			$('#frmpurchasedir input').attr('readonly', true );
			$('#frmpurchasedir select').attr('disabled', true);
			
			$('#vehpurorderDate').jqxDateTimeInput({disabled: true});
			$('#vehpurinvDate').jqxDateTimeInput({disabled: true});
			   
	 }
	 function funRemoveReadOnly(){
		 
			$('#frmpurchasedir input').attr('readonly', false );
			$('#frmpurchasedir select').attr('disabled', false);
			$('#vehpurorderDate').jqxDateTimeInput({disabled: false});
			$('#vehpurinvDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$('#accid').attr('readonly', true);
			if ($("#mode").val() == "A") {
				tax();
				$('#vehpurorderDate').val(new Date());
				$('#vehpurinvDate').val(new Date());
			    $("#vehpurchasedirgrid").jqxGrid('clear');
			    $("#vehpurchasedirgrid").jqxGrid('addrow', null, {});
			  
				    
				     
			   }
			
			
		/* if ($("#mode").val() == "E") {
			if($('#vehtype').val()=="VPO")
			  {
			
			  $('#vehrefno').attr('disabled', false);
			  
		  $('#vehrefno').attr('readonly', true);
		
			  }
			} */
			
			
			
			
			if($('#mode').val()=='D')
			{
			
			$('#frmpurchasedir input').attr('readonly',false);  
			$('#frmpurchasedir select').attr('disabled',false); 
			$('#vehpurorderDate').jqxDateTimeInput({disabled: false});
			$('#vehpurinvDate').jqxDateTimeInput({disabled: false});
 
			
			funchkfordel(document.getElementById("masterdoc_no").value);	
			funReadOnly();
			exit();
		
	
		
	       }
	
			
			
	 }
	 
	 
	 
	 function funchkfordel(masterdoc_no)
	 {


	 	var x = new XMLHttpRequest();
	 	x.onreadystatechange = function() {
	 		if (x.readyState == 4 && x.status == 200) {
	 			var items = x.responseText.trim();	
	 		//	alert(items);
	 			if(parseInt(items)>0)
	 				{
	 				$.messager.alert('Message',' Transaction Already Exists','warning');  
	             return 0;
	 	
	 				
	 				}
	 			else
	 				{
	 			
	 				
	 				$('#frmpurchasedir input').attr('readonly',false);  
	 				$('#frmpurchasedir select').attr('disabled',false); 
	 				$('#vehpurorderDate').jqxDateTimeInput({disabled: false});
	 				$('#vehpurinvDate').jqxDateTimeInput({disabled: false});
	 				$('#frmpurchasedir').submit(); 
	 				}
	 		  
	 			
	 			
	 			
	 		} else {
	 			
	 		}
	 	}
	 	x.open("GET", "deletechk.jsp?srno="+document.getElementById("masterdoc_no").value, true);
	 	x.send();
	 	
	 	}
	 	

 
	 
	 
	 
	 function funSearchLoad(){
		changeContent('mastersearch.jsp'); 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus()
	    {
	    	$('#vehpurorderDate').jqxDateTimeInput('focus'); 	    		
	    }
	 function getTaxPer(date){
		   
	     var x = new XMLHttpRequest();
	     x.onreadystatechange = function() {
	       if (x.readyState == 4 && x.status == 200) {
	        var items = x.responseText.trim();
	       	$('#txttaxpercentage').val(items);
	       }
   		 }
	      x.open("GET", "getTaxper.jsp?date="+date, true);
	      x.send();
	  }
	 function tax(){
			var date=$('#vehpurorderDate').val();
		//	alert($('#vehpurorderDate').val());
			getTaxPer(date);
		}
	
	   
	  function funNotify(){
		  
		  var maindate = $('#vehpurorderDate').jqxDateTimeInput('getDate');
		   var validdate=funDateInPeriod(maindate);
		   if(validdate==0){
		   return 0; 
		   }
		  
	 
		//   fleet_no chaseno enginno prch_cost addicost price  brdid modid clrid
	 		
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
		
		
		var invno= document.getElementById("invno").value;

		if(invno=="")
			{
			 document.getElementById("errormsg").innerText=" Enter Invoice No";
			 
			 document.getElementById("invno").focus();
			 return 0;
			   }
		else
			   {
			   document.getElementById("errormsg").innerText="";
			   } 
		
		
 
		  var rows = $("#vehpurchasedirgrid").jqxGrid('getrows');
		    $('#vehpurchasegridlenght').val(rows.length);
		   //alert($('#gridlength').val());
		   for(var i=0 ; i < rows.length ; i++){
		   // var myvar = rows[i].tarif; 
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
           .attr("id", "vehpurchasetest"+i)
		       .attr("name", "vehpurchasetest"+i) 
		           .attr("hidden", "true"); 
		    
		 
		   newTextBox.val(rows[i].fleet_no+"::"+rows[i].brdid+" :: "+rows[i].modid+" :: "
				   +rows[i].clrid+" :: "+rows[i].chaseno+" :: "+rows[i].enginno+" :: "+rows[i].prch_cost+" :: "+rows[i].addicost+" :: "
				   +rows[i].price+" :: ");
	//s	alert(newTextBox.val());
		   newTextBox.appendTo('form');
		  
		    
		   }   
				 /* Applying Invoice Grid Updating Ends*/
				 
	    		return 1;
		} 
	  
    
	  
	  $(function(){
	        $('#frmpurchasedir').validate({
	        	 rules: { 
	        		 vehdesc:{maxlength:200},
	        		 
	        	 },
		                 messages: {
		                	 
		                	 vehdesc: {maxlength:"  Max 250 chars"}
		              
	                 }
	        });});
 
	  
 
	  
	function isNumber(evt) {
	    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
	    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
	    	{
	 	   document.getElementById("errormsg").innerText=" Enter Numbers Only";  
	       
	        return false;
	    	}
	    document.getElementById("errormsg").innerText="";  
	    return true;
	}  
	
	
  function setValues()
  {
	  
	   if($('#hidvehpurorderDate').val()){
			 $("#vehpurorderDate").jqxDateTimeInput('val', $('#hidvehpurorderDate').val());
		  }
	 


	  if($('#hidvehpurinvDate').val()){
			 $("#vehpurinvDate").jqxDateTimeInput('val', $('#hidvehpurinvDate').val());
		  }
	  
		var indexVa5 = document.getElementById("masterdoc_no").value;
		
        if(parseInt(indexVa5)>0){
       	
  	 
        $("#vehpuchase").load("vehpurchaseDetails.jsp?masterdoc="+indexVa5);  
        }
        if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
      	 funSetlabel();	 
  }
	
 
	 function funPrintBtn(){
	  	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	  	  
	  	   var url=document.URL;
	  	 
	         var reurl=url.split("savePurchase");
	         
	         $("#docno").prop("disabled", false);                
	         
	   
	 var win= window.open(reurl[0]+"printPurchaseDir?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	      
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

<form id="frmpurchasedir" action="savePurchaseDir" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>


    <div class='receipt-header'>
        <label>Date</label>
        <div>
            <div id="vehpurorderDate" name="vehpurorderDate" value='<s:property value="vehpurorderDate"/>' onblur="tax()" onchange="tax()"></div>
            <input type="hidden" id="hidvehpurorderDate" name="hidvehpurorderDate" value='<s:property value="hidvehpurorderDate"/>'/>
        </div>

        <label>Doc No.</label>
        <input type="text" id="docno" name="docno" value='<s:property value="docno"/>' tabindex="-1" readonly/>
    </div>

    <div class="section-block">
        <h2>Purchase Details (Direct)</h2>
        
        <div class="vendor-inv-row">
            <label for="accid">Vendor</label>
            <input type="text" id="accid" name="accid" style="width: 100%;" placeholder="Press F3 to Search" value='<s:property value="accid"/>' onkeydown="getaccountdetails(event)"/>
            <input type="text" id="vehpuraccname" name="vehpuraccname" value='<s:property value="vehpuraccname"/>' readonly/>
            
            <label for="invno">Inv No</label>
            <input type="text" id="invno" name="invno" style="width: 100%;" value='<s:property value="invno"/>'/>
            
            <label>Purchase Date</label>
            <div>
                <div id="vehpurinvDate" name="vehpurinvDate" value='<s:property value="vehpurinvDate"/>'></div>
                <input type="hidden" id="hidvehpurinvDate" name="hidvehpurinvDate" value='<s:property value="hidvehpurinvDate"/>'/>
            </div>
            
            <div></div> 
        </div>
        
        <div class="description-row">
            <label for="vehdesc">Description</label>
            <input type="text" id="vehdesc" name="vehdesc" value='<s:property value="vehdesc"/>'/>
        </div>

    </div>

    <div class="section-block" style="padding-top: 5px;">
        <h2>Vehicle Item Details</h2>
        <div id="vehpuchase" style="overflow-x: auto;"><jsp:include page="vehpurchaseDetails.jsp"></jsp:include></div>
    </div>


    <div class="footer-totals">
        <div class="spacer"></div>
        
        <label id="lbltax" style="display: block;">Tax Amount</label>
        <input type="text" name="txttaxamount" id="txttaxamount" value='<s:property value="txttaxamount"/>' style="text-align: right;" />
        
        <label>Net Total</label>
        <input type="text" name="txtnetotal" id="txtnetotal" value='<s:property value="txtnetotal"/>' style="text-align: right;" />
    </div>


    <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/> 
    <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
    <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
    <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
    <input type="hidden" id="headacccode" name="headacccode"  value='<s:property value="headacccode"/>'/>
    <input type="hidden" id="txttaxpercentage" name="txttaxpercentage"  value='<s:property value="txttaxpercentage"/>'/>
    <input type="hidden" id="vehpurchasegridlenght" name="vehpurchasegridlenght"  value='<s:property value="vehpurchasegridlenght"/>'/>

</form>
	<div id="accountSearchwindow">
   <div ></div>
</div>
   
   
   
<div id="fleetwindow"><div></div>
</div>
 
</div>
</div>
 
</body>
</html>