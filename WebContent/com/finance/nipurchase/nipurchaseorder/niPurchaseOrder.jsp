<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
 <jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
/* Modern Purchase Order Form Layout */
.purchase-order-wrapper {
    font-family: 'Poppins', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
    min-width: 100%;
    margin: 0 auto;
    padding: 20px;
}

.section-row {
    display: flex;
    gap: 20px;
    margin-bottom: 20px;
}

.section-block {
    flex: 1;
    background: #ffffff;
    border-radius: 12px;
    padding: 20px;
    box-shadow: -2px -2px 8px rgba(255, 255, 255, 0.8),
                2px 2px 8px rgba(0, 0, 0, 0.08);
}

.section-block h2 {
    font-size: 16px;
    font-weight: 700;
    color: #2c3e50;
    margin: 0 0 16px 0;
    padding-bottom: 10px;
    padding-left: 12px;  
    position : relative;
    border-bottom: 2px solid #e2e8f0;
}
.section-block h2::before {
    content: "";
    position: absolute;
    left: 0;
    top: 2px;
    height: 100%;
    width: 4px;
    background-color: #007bff;       /* blue line */
    border-radius: 2px;
}

/* Form Groups */
.form-group {
    display: grid;
    grid-template-columns: auto 1fr;
    gap: 12px;
    align-items: center;
    margin-bottom: 14px;
}

.form-group label {
    font-size: 14px;
    font-weight: 600;
    color: #2c3e50;
    text-align: right;
    padding-right: 8px;
    white-space: nowrap;
}

.form-group input[type="text"],
.form-group select {
    padding: 8px 12px;
    border: 2px solid #e2e8f0;
    border-radius: 8px;
    font-size: 13px;
    font-weight: 500;
    color: #2c3e50;
    background: white;
    transition: all 0.3s ease;
    font-family: 'Poppins', sans-serif;
    width: auto;  /* Allow manual width control */
    max-width: 100%;  /* Don't exceed container */
}

.form-group input[type="text"]:focus,
.form-group select:focus {
    outline: none;
    border-color: #3498db;
    box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
}

.form-group input[readonly] {
    background: #f8f9fa;
    cursor: not-allowed;
}

/* Triple Input in One Row - Date, Ref No, Doc No */
.form-group.triple-input {
    grid-template-columns: auto 1fr auto 1fr auto 1fr;
}

/* Vendor Row - Label + 2 Inputs */
.form-group.vendor-row {
    grid-template-columns: auto 0.25fr 1fr;
}

/* Dual Input in Same Row - Curr & Rate */
.form-group.dual-input {
    grid-template-columns: auto 1fr auto 1fr;
}

/* Date Field Cell */
.date-field-cell {
    position: relative;
}

.date-field-cell > div {
    width: 100%;
}

/* Full Width Input */
.form-group.full-width {
    grid-template-columns: auto 1fr;
}

/* Responsive */
@media (max-width: 1200px) {
    .form-group.triple-input {
        grid-template-columns: auto 1fr auto 1fr;
    }
}

@media (max-width: 768px) {
    .form-group,
    .form-group.dual-input,
    .form-group.triple-input,
    .form-group.vendor-row {
        grid-template-columns: 1fr;
    }
    
    .form-group label {
        text-align: left;
        padding-right: 0;
        margin-bottom: 4px;
    }
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
  transform: translateY(-1px);}




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
<div class="form-group triple-input" style="display:flex; align-items:center; width:100%;">

    <label for="nipurchaseorderdate" style="margin-right:8px;">Date</label>

    <div class="date-field-cell" style="width:130px;">
        <div id="nipurchaseorderdate"
             name="nipurchaseorderdate"
             value='<s:property value="nipurchaseorderdate"/>'></div>

        <input type="hidden"
               name="hidnipurchaseorderdate"
               id="hidnipurchaseorderdate"
               value='<s:property value="hidnipurchaseorderdate"/>'>
    </div>

    <label for="docno" style="margin-left:auto; margin-right:8px;">Doc No</label>

    <input type="text"
           name="docno"
           id="docno"
           tabindex="-1"
           value='<s:property value="docno"/>'
           readonly="readonly"
           style="width:120px;">
</div>
               
	<br/>

    <div class=' receipt-header'>
<div class="purchase-order-wrapper">
    <!-- Single Section with All Fields -->
    <div class="section-row">
        <div class="section-block">
            <h2>Purchase Order Details</h2>
            
            <label for="refno">Ref No</label>
<input type="text" name="refno" id="refno"
       value='<s:property value="refno"/>'>
                
            <!-- Row 2: Vendor (with 2 inputs) -->
            <div class="form-group vendor-row">
                <label for="puraccid">Vendor</label>
                <input type="hidden" name="acctype" id="acctype" value='<s:property value="acctype"/>'>
                <input type="text" name="puraccid" id="puraccid" placeholder="Press F3 To Search" value='<s:property value="puraccid"/>' onKeyDown="getaccountdetails(event);" style="width: 80%;">
                <input type="text" id="puraccname" name="puraccname" value='<s:property value="puraccname"/>' style="width: 92%;">
            </div>
            
            <!-- Row 3: Curr, Rate -->
            <div class="form-group dual-input">
                <label for="cmbcurr">Curr</label>
                <select name="cmbcurr" id="cmbcurr" value='<s:property value="cmbcurr"/>' onload="getRatevalue(this.value);" style="width: 50%;">
                    <option value="-1">--Select--</option>
                </select>
                
                <label for="currate" style="margin-left:-10px;">Rate</label>
                <input type="text" name="currate" id="currate" value='<s:property value="currate"/>' style="width: 87%;">
            </div>
            
            <!-- Row 4: Del Date, Del Terms, Bill Type -->
            <div class="form-group triple-input">
                <label for="deliverydate">Del Date</label>
                <div class="date-field-cell">
                    <div id="deliverydate" name="deliverydate" value='<s:property value="deliverydate"/>'></div>
                    <input type="hidden" name="hiddeliverydate" id="hiddeliverydate" value='<s:property value="hiddeliverydate"/>'>
                </div>
                
                <label for="delterms">Del Terms</label>
                <input type="text" name="delterms" id="delterms" value='<s:property value="delterms"/>' style="width: 80%;">
                
                <label id="billtype">Bill Type</label>
                <input type="text" id="txtproducttype" name="txtproducttype" placeholder="Press F3 for Search" onKeyDown="getProdType(event);" value='<s:property value="txtproducttype"/>' style="width: 78%;"/>
            </div>
            
            <!-- Row 5: Pay Terms -->
            <div class="form-group full-width">
                <label for="payterms">Pay Terms</label>
                <input type="text" name="payterms" id="payterms" value='<s:property value="payterms"/>' style="width: 93%;">
            </div>
            
            <!-- Row 6: Description -->
            <div class="form-group full-width">
                <label for="purdesc">Description</label>
                <input type="text" name="purdesc" id="purdesc" value='<s:property value="purdesc"/>' style="width: 93%;">
            </div>
        </div>
    </div>
</div>


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