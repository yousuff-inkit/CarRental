<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includeso.jsp"></jsp:include>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>

<jsp:include page="tab.css"/>
<%@ include file="tab.jsp" %> 

<script type="text/javascript">
      $(document).ready(function () {
    	  getSalesmanConfigs()
    	  /* Date */
    	  $("#jqxClientDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    	  $("#jqxContractDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy" , value:null});
    	  $("#dateOfJoining").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy" , value:null});
    	
    	  /* Searching Window */
    	 $('#nationalityWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Nation Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#nationalityWindow').jqxWindow('close');
 		 
    	 $('#stateWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'State Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#stateWindow').jqxWindow('close');
 		
 		getGroup();getSalesman();getCategory();getNationality();getSalutation();getContractDate();getContract();getIDPDetails();getCRMDriverDetailsVerify();getNonTaxableEntity();getTax();getSeparateServiceChargeAllowed();
      	getConfigs();refdetConfig();getclientSrvChrges();
      	//$('#salikauhpercent,#salikpercent,#trafficpercent').attr('disabled',true);
      	
      	
      	$('#chksalikauhpercent,#chksalikdxbpercent,#chktrafficpercent,#chkparkingpercent').on('click',function(){
      		var target=$(this).attr('id');
      		if($(this).is(':checked')){
      			$('#hid'+target).val('1');
      		}
      		else{
      			$('#hid'+target).val('0');
      		}
      	});
      }); 
    
      
      function getclientSrvChrges(){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText;
	  				//alert("itemsin config---"+parseInt(items))
	  				if(parseInt(items)>0){
	  			    $('#hidclientsrvchrges').val(parseInt(items));
	  			}
	  		}else {
				$('#hidclientsrvchrges').val(0);
			}
	  		}
	  		x.open("GET", "getservicechrgesConfig.jsp", false);
	  		x.send();
	 }
      
      
      function refdetConfig(){
  		var x=new XMLHttpRequest();
  		x.onreadystatechange=function(){
  			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('####');
				//alert(items[0])
				if (items[0]==1) 
				{
					 $("#jqxReferenceDetails2").show();
				     $("#jqxReferenceDetails1").hide();
				     $("#refid").text("ID Details");
				  
					}else{
		  				$("#jqxReferenceDetails1").show();
						$("#jqxReferenceDetails2").hide();
					    $("#refid").text("Reference Details");
		  			}
  			}
     	}
  		
   		x.open("GET", "refdetConfig.jsp",true);   
  		x.send();
  	}
  	
    
      function getConfigs(){
    	$.get('getConfigs.jsp',function(data){
    		data=JSON.parse(data);
    		var htmldata='';
   			if(data.InvQuarterly=="1"){
   				htmldata+='<option value="4">Quarterly</option><option value="5">Half Yearly</option><option value="6">Yearly</option>';
   				$('#cmbinvoicing_method').append($.parseHTML(htmldata));
   				/* $('#invoice').append($('<option></option>').val("4").text("Quarterly"));
   				$('#invoice').append($('<option></option>').val("5").text("Half Yearly"));
   				$('#invoice').append($('<option></option>').val("6").text("Yearly"));*/
   				if($('#hidcmbinvoicing_method').val()!="")
   				{
   					$('#cmbinvoicing_method').val($('#hidcmbinvoicing_method').val());
   				} 
   			}
		});
	}
      function hidedata(){
  		var contract=$('#txtforcontractdiv').val();
  		
  		if(parseInt(contract)==1){
  			   $("#contractDiv").prop("hidden", false);
  			   $("#sponsorDiv").attr("hidden", true);
  			}
  			else{
  				$("#contractDiv").prop("hidden", true);
  				$("#sponsorDiv").attr("hidden", false);
  			}
  		}
      
      function showSingleOrSeparateServiceCharges(){
    		var separateservicechargeallowed=$('#separateservicechargeallowed').val();
    		
    		if(parseInt(separateservicechargeallowed)==1){
    			   $("#singleServiceChargeDiv").prop("hidden", true);
    			   $("#separateServiceChargeDiv").attr("hidden", false);
    		}
    		else{
    			$("#singleServiceChargeDiv").prop("hidden", false);
    			$("#separateServiceChargeDiv").attr("hidden", true);
    		}
    		if(parseInt(separateservicechargeallowed)==2){
    			$('.row-salikpercent').show();
    		}
    		else{
    			$('.row-salikpercent').hide();
    		}
      }
      
      function getContract(){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText;
	  			    $('#txtforcontractdiv').val(items);
	  			    hidedata();
	  		}
	  		}
	  		x.open("GET", "getContract.jsp", true);
	  		x.send();
	 }
	 
	function getIDPDetails(){
    		var x = new XMLHttpRequest();
    		x.onreadystatechange = function() {
    			if (x.readyState == 4 && x.status == 200) {
    				var items = x.responseText;
    			    $('#idpdetailsallowed').val(items);
    		}
    		}
    		x.open("GET", "getIDPDetailsAllowed.jsp", true);
    		x.send();
    }
	
	function getCRMDriverDetailsVerify(){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
			    $('#driverdetailsverifyallowed').val(items);
		}
		}
		x.open("GET", "getCRMDriverDetailsVerifyAllowed.jsp", true);
		x.send();
	}
	
	function getSeparateServiceChargeAllowed(){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
			    $('#separateservicechargeallowed').val(items);
			    showSingleOrSeparateServiceCharges();
			    
			    if(parseInt($('#separateservicechargeallowed').val())==1 && $('#mode').val()=='A'){
		    		 $("#separateServiceChargeGridDiv").load("separateServiceChargesGrid.jsp?check=2&defaultsevicecharge="+$('#hidchckseparatesrvcdefault').val());
		    	}
		}
		}
		x.open("GET", "getSeparateServiceChargeAllowed.jsp", true);
		x.send();
	}
	
	function getCategoryWiseEditEnable(a){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  			    $('#txtcategorywiseedit').val(items);
  			    
  			  if(parseInt($('#txtcategorywiseedit').val())==1){
  				$('#btnEdit').attr('disabled', true );
  			  }
  		}
  		}
  		x.open("GET", "getCategoryWiseEditEnable.jsp?category="+a, true);
  		x.send();
 	}
      
      function getSalutation() {
    		var x = new XMLHttpRequest();
    		x.onreadystatechange = function() {
    			if (x.readyState == 4 && x.status == 200) {
    				var items = x.responseText;
    				items = items.split('####');
    				var salutnItems = items[0].split(",");
    				var salutnIdItems = items[1].split(",");
    				var optionssalutn = '<option value="">--Select--</option>';
    				for (var i = 0; i < salutnItems.length; i++) {
    					optionssalutn += '<option value="' + salutnItems[i] + '">'
    							+ salutnItems[i] + '</option>';
    				}
    				$("select#cmbsalutation").html(optionssalutn);
    				if ($('#hidcmbsalutation').val() != null) {
    					$('#cmbsalutation').val($('#hidcmbsalutation').val());
    				}
    			} else {
    			}
    		}
    		x.open("GET", "getSalutation.jsp", true);
    		x.send();
    	} 
     
      function getGroup() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var groupItems = items[0].split(",");
  				var groupIdItems = items[1].split(",");
  				var optionsgroup = '<option value="">--Select--</option>';
  				for (var i = 0; i < groupItems.length; i++) {
  					optionsgroup += '<option value="' + groupIdItems[i] + '">'
  							+ groupItems[i] + '</option>';
  				}
  				$("select#cmbgroup1").html(optionsgroup);
  				if ($('#hidcmbgroup1').val() != null) {
  					$('#cmbgroup1').val($('#hidcmbgroup1').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getGroup.jsp", true);
  		x.send();
  	} 
	
	function getCategoryAccountGroup(a) {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText.trim();
  			    $('#hidcmbgroup1').val(items);
  				
  				if ($('#hidcmbgroup1').val() != null || $('#hidcmbgroup1').val() != "") {
  					$('#cmbgroup1').val($('#hidcmbgroup1').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getCategoryAccountGroup.jsp?category="+a, true);
  		x.send();
  	} 
     
      function getSalesman() {
    		var x = new XMLHttpRequest();
    		x.onreadystatechange = function() {
    			if (x.readyState == 4 && x.status == 200) {
    				var items = x.responseText;
    				items = items.split('####');
    				var salesagentItems = items[0].split(",");
    				var salesagentIdItems = items[1].split(",");
    				var linkItems = items[2].split(",");
    				
    				var optionssalesagent;
    				for (var i = 0; i < salesagentItems.length; i++) {
    					if(parseInt(linkItems[i])==1) {
	    					optionssalesagent += '<option value="' + salesagentIdItems[i] + '">'
	    							+ salesagentItems[i] + '</option>';
    					} else {
    						if(i==0) {
	    						optionssalesagent = '<option value="">--Select--</option>';
	    						optionssalesagent += '<option value="' + salesagentIdItems[i] + '">'
								+ salesagentItems[i] + '</option>';
    						} else {
    							optionssalesagent += '<option value="' + salesagentIdItems[i] + '">'
								+ salesagentItems[i] + '</option>';
    						}
    					}
    				}
    				$("select#cmbsalesman").html(optionssalesagent);
    				if ($('#hidcmbsalesman').val() != null) {
    					$('#cmbsalesman').val($('#hidcmbsalesman').val());
    				}
    			} else {
    			}
    		}
    		x.open("GET", "getSalesagent.jsp", true);
    		x.send();
    	}
      
      function getCategory() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var categoryItems = items[0].split(",");
  				var categoryIdItems = items[1].split(",");
  				var optionscategory = '<option value="">--Select--</option>';
  				for (var i = 0; i < categoryItems.length; i++) {
  					optionscategory += '<option value="' + categoryIdItems[i] + '">'
  							+ categoryItems[i] + '</option>';
  				}
  				$("select#cmbcategory").html(optionscategory);
  				if ($('#hidcmbcategory').val() != null) {
  					$('#cmbcategory').val($('#hidcmbcategory').val());
  				}
  			} else {
  			}
  		}
  		x.open("GET", "getCategory.jsp", true);
  		x.send();
  	}
      
      function getCurrencyIds(){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
				 	items= x.responseText;
				 	items=items.split('####');
			        var curidItems=items[0];
			        var curcodeItems=items[1];
			        var multiItems=items[2];
			        var optionscurr = '';
			        
			     if(curcodeItems.indexOf(",")>=0){
			        	var currencyid=curidItems.split(",");
			        	var currencycode=curcodeItems.split(",");
			        	multiItems.split(",");
			       
			       for ( var i = 0; i < currencycode.length; i++) {
			    	   optionscurr += '<option value="' + currencyid[i] + '">' + currencycode[i] + '</option>';
			        }
			      
			         $("select#cmbcurrency").html(optionscurr);
			         if ($('#hidcmbcurrency').val() != null && $('#hidcmbcurrency').val() != "") {
			       		 $('#cmbcurrency').val($('#hidcmbcurrency').val()) ;
			         } 
					     
				   }
			
			       else{
			    	   optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
			    	   
				    	 $("select#cmbcurrency").html(optionscurr);
				       
				         if ($('#hidcmbcurrency').val() != null && $('#hidcmbcurrency').val() != "") {
				       		 $('#cmbcurrency').val($('#hidcmbcurrency').val()) ;
				         }
				      }
				}
		     }
		      x.open("GET", "getCurrencyId.jsp",true);
		     x.send();
		    
		   }
     
      function getNationality() {
    		var x = new XMLHttpRequest();
    		x.onreadystatechange = function() {
    			if (x.readyState == 4 && x.status == 200) {
    				var items = x.responseText;
    				items = items.split('####');
    				var nationItems = items[0].split(",");
    				var nationIdItems = items[1].split(",");
    				var optionsnation = '<option value="">--Select--</option>';
    				for (var i = 0; i < nationItems.length; i++) {
    					optionsnation += '<option value="' + nationIdItems[i] + '">'
    							+ nationItems[i] + '</option>';
    				}
    				$("select#cmbnationality").html(optionsnation);
    				if ($('#hidcmbnationality').val() != null) {
    					$('#cmbnationality').val($('#hidcmbnationality').val());
    				}
    			} else {
    			}
    		}
    		x.open("GET", "getNationality.jsp", true);
    		x.send();
    	} 
      
      function taxcheck() {
 		 if($('#cmbtax').val()=='1'){
 			 document.getElementById("chcknontaxableentity").checked=true;
 			 document.getElementById("hidchcknontaxableentity").value = 1;
  		 }
 		 else if($('#cmbtax').val()=='2'){
 			 document.getElementById("chcknontaxableentity").checked=false;
 			 document.getElementById("hidchcknontaxableentity").value = 0;
  		 }
  		 else{
  			 document.getElementById("chcknontaxableentity").checked=false;
  			 document.getElementById("hidchcknontaxableentity").value = 0;
  		 }
 	 }
      
      function getClientAlreadyExists(clientname,salutation,docno,mode){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();

					if(parseInt(items)==1){
	  					 document.getElementById("errormsg").innerText="Client Already Exists.";
	  					 return 0;
	  				 } else {
	  					 
	  					if(parseInt($('#driverdetailsverifyallowed').val())==1){
	  						System.out.println("drivedeteails---------");
		  					 var driverdetails = new Array();
		  					 
		  					 var rowsverify = $("#jqxDriver").jqxGrid('getrows');
		  					 for(var z=0 ; z < rowsverify.length ; z++){
		  						var chkverify=rowsverify[z].name;
		  						if(typeof(chkverify) != "undefined" && typeof(chkverify) != "NaN" && chkverify != ""){
		  							driverdetails.push(rowsverify[z].name+" ::"+rowsverify[z].mobno+" ::"+rowsverify[z].dlno+" ::"+rowsverify[z].dr_id);
		  						}
		  					 }
		  					 
		  				    getDriverDetailsVerification(driverdetails,docno,mode);
	  					
	  					} else {
	  						var rows = $("#jqxDriver").jqxGrid('getrows');
		  				    var length=0;
		  					 for(var i=0 ; i < rows.length ; i++){
		  						var chk=rows[i].name;
		  						if(typeof(chk) != "undefined"){
		  							length=length+1;
		  							newTextBox = $(document.createElement("input"))
		  						    .attr("type", "dil")
		  						    .attr("id", "test"+i)
		  						    .attr("name", "test"+i)
		  						    .attr("hidden", "true");
		  					
		  					newTextBox.val(rows[i].name+" :: "+rows[i].hiddob+":: "+rows[i].nation1+":: "+rows[i].mobno+":: "+rows[i].passport_no+":: "+rows[i].hidpassexp+":: "+rows[i].dlno+":: "+rows[i].hidissdate+":: "+rows[i].issfrm+":: "+rows[i].hidled+":: "+rows[i].ltype+":: "+rows[i].visano+":: "+rows[i].hidvisaexp+"::"+rows[i].dr_id+":: "+rows[i].hcdlno+":: "+rows[i].hidhcissdate+":: "+rows[i].hidhcled);
		  					newTextBox.appendTo('form');
		  					 }
		  					}
		  		 		 $('#gridlength').val(length);
		  		 		 
		  		 		 
		  		 		/* new ref det grid*/
		  		 		 var rows = $("#refdetsearch").jqxGrid('getrows');
		  		 		 var referencelength1=0;
		  		 		 for(var i=0,j=0 ; i < rows.length ; i++){
		  		 			var  chk=rows[i].validupto;
		  		 			var  chks=rows[i].numbr;
		  		 			if((typeof(chk) != "undefined" && chk!==null && chk!==0 && chk!=="" && chk!=="undefined") || (typeof(chks) != "undefined" && chks!==null && chks!==0 && chks!=="" && chks!=="undefined")){
		  						referencelength1=referencelength1+1;
		  						newTextBox = $(document.createElement("input"))
		  					    .attr("type", "dil")
		  					    .attr("id", "iddetail"+j)
		  					    .attr("name", "iddetail"+j)
		  					    .attr("hidden", "true");
		  					var validupto=$('#refdetsearch').jqxGrid('getcelltext',i,'validupto');
		  					
		  					newTextBox.val(rows[i].seqno+" :: "+rows[i].numbr+" :: "+validupto+" :: ");
		  					newTextBox.appendTo('form');
		  					//alert(rows[i].seqno+" :: "+rows[i].numbr+" :: "+validupto+" :: ");
		  					j++;
		  		 			}
		  			      }
		  			      $('#referencelength1').val(referencelength1);
		  			      
		  		 		 
		  		 		 var rows = $("#jqxReferenceDetails").jqxGrid('getrows');
		  		 		 var referencelength=0;
		  		 		 for(var i=0 ; i < rows.length ; i++){
		  		 				var chkd=rows[i].cperson;
		  						if(typeof(chkd) != "undefined"){
		  						referencelength=referencelength+1;
		  						newTextBox = $(document.createElement("input"))
		  					    .attr("type", "dil")
		  					    .attr("id", "txtreference"+i)
		  					    .attr("name", "txtreference"+i)
		  					    .attr("hidden", "true");
		  				
		  					newTextBox.val(rows[i].cperson+" :: "+rows[i].desig+" :: "+rows[i].mob+" :: "+rows[i].email+" ::");
		  					newTextBox.appendTo('form');
		  					}
		  			      }
		  			      $('#referencelength').val(referencelength);
		  		      
		  			      var rows = $("#jqxCreditCardDetails").jqxGrid('getrows');
		  					 var creditcardlength=0;
		  						 for(var i=0 ; i < rows.length ; i++){
		  							var chkng=rows[i].type;
		  							if(typeof(chkng) != "undefined"){
		  								creditcardlength=creditcardlength+1;
		  								newTextBox = $(document.createElement("input"))
		  							    .attr("type", "dil")
		  							    .attr("id", "txtcard"+i)
		  							    .attr("name", "txtcard"+i)
		  							    .attr("hidden", "true");
		  						
		  						newTextBox.val(rows[i].type+" :: "+rows[i].cardno+" :: "+rows[i].hidexpdate+":: "+rows[i].defaultcard+":: "+rows[i].remarks);
		  						newTextBox.appendTo('form');
		  						 }
		  						}
		  			 		 $('#creditcardlength').val(creditcardlength);
		  			 		 
		  			 		 
		  		    		if(parseInt($('#separateservicechargeallowed').val())==1){
		  		    			 
		  		    			var rows = $("#separateServiceChargeGridId").jqxGrid('getrows');
			  					 var separateservicechargelength=0;
			  						 for(var i=0 ; i < rows.length ; i++){
			  							var chked=rows[i].doc_no;
			  							if(typeof(chked) != "undefined"){
			  								separateservicechargelength=separateservicechargelength+1;
			  								newTextBox = $(document.createElement("input"))
			  							    .attr("type", "dil")
			  							    .attr("id", "txtseparateservicecharge"+i)
			  							    .attr("name", "txtseparateservicecharge"+i)
			  							    .attr("hidden", "true");
			  						
			  						newTextBox.val(rows[i].doc_no+" :: "+rows[i].salik+" :: "+rows[i].traffic);
			  						newTextBox.appendTo('form');
			  						 }
			  						}
			  			 		 $('#separateservicechargelength').val(separateservicechargelength);
			  			 		 
		  		    		}
		  		    		
						 //   $('#cmbgroup1').attr('disabled', false);
						    $("#cmbsalesman").attr("disabled",false);
		  					$("#frmClientMaster").submit(); 
		  					
	  					}
	  				 }
	  			   
	  		}
		}
		x.open("GET", "getClientAlreadyExists.jsp?clientname="+clientname+"&salutation="+salutation+"&docno="+docno+"&mode="+mode, true);
		x.send();
   }
      
    function getDriverDetailsVerification(driverdetails,docno,mode) {
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();
	  			    items = items.split('####');
	  			
	  				if(parseInt(items[0])==1){
	  					 document.getElementById("errormsg").innerText="Driver Details is Mandatory.";
	  					 return 0;
	  				 } else if(parseInt(items[0])==2){
	  					 document.getElementById("errormsg").innerText=""+items[1]+" (Driver) Mobile Number Required.";
	  					 return 0;
	  				 } else if(parseInt(items[0])==3){
	  					 document.getElementById("errormsg").innerText=""+items[1]+" (Driver) Mobile Number Already Exists.";
	  					 return 0;
	  				 } else if(parseInt(items[0])==4){
	  					 document.getElementById("errormsg").innerText=""+items[1]+" (Driver) Licence Number Required.";
	  					 return 0;
	  				 } else if(parseInt(items[0])==5){
	  					 document.getElementById("errormsg").innerText=""+items[1]+" (Driver) Licence Number Already Exists.";
	  					 return 0;
	  				 } else {
	  					 
	  					var rows = $("#jqxDriver").jqxGrid('getrows');
	  				    var length=0;
	  					 for(var i=0 ; i < rows.length ; i++){
	  						var chk=rows[i].name;
	  						if(typeof(chk) != "undefined"){
	  							length=length+1;
	  							newTextBox = $(document.createElement("input"))
	  						    .attr("type", "dil")
	  						    .attr("id", "test"+i)
	  						    .attr("name", "test"+i)
	  						    .attr("hidden", "true");
	  					
	  					newTextBox.val(rows[i].name+" :: "+rows[i].hiddob+":: "+rows[i].nation1+":: "+rows[i].mobno+":: "+rows[i].passport_no+":: "+rows[i].hidpassexp+":: "+rows[i].dlno+":: "+rows[i].hidissdate+":: "+rows[i].issfrm+":: "+rows[i].hidled+":: "+rows[i].ltype+":: "+rows[i].visano+":: "+rows[i].hidvisaexp+"::"+rows[i].dr_id+":: "+rows[i].hcdlno+":: "+rows[i].hidhcissdate+":: "+rows[i].hidhcled);
	  					newTextBox.appendTo('form');
	  					 }
	  					}
	  		 		 $('#gridlength').val(length);
	  		 		 
	  		 		 
	  		 		/* new ref det grid*/
	  		 		 var rows = $("#refdetsearch").jqxGrid('getrows');
	  		 		 var referencelength1=0;
	  		 		 for(var i=0,j=0 ; i < rows.length ; i++){
	  		 			var  chk=rows[i].validupto;
	  		 			var  chks=rows[i].numbr;
	  		 			if((typeof(chk) != "undefined" && chk!==null && chk!==0 && chk!=="" && chk!=="undefined") || (typeof(chks) != "undefined" && chks!==null && chks!==0 && chks!=="" && chks!=="undefined")){
	  						referencelength1=referencelength1+1;
	  						newTextBox = $(document.createElement("input"))
	  					    .attr("type", "dil")
	  					    .attr("id", "iddetail"+j)
	  					    .attr("name", "iddetail"+j)
	  					    .attr("hidden", "true");
	  					var validupto=$('#refdetsearch').jqxGrid('getcelltext',i,'validupto');
	  					
	  					newTextBox.val(rows[i].seqno+" :: "+rows[i].numbr+" :: "+validupto+" :: ");
	  					newTextBox.appendTo('form');
	  					//alert(rows[i].seqno+" :: "+rows[i].numbr+" :: "+validupto+" :: ");
	  					j++;
	  		 			}
	  			      }
	  			      $('#referencelength1').val(referencelength1);
	  			      
	  		 		
	  		 		 var rows = $("#jqxReferenceDetails").jqxGrid('getrows');
	  		 		 var referencelength=0;
	  		 		 for(var i=0 ; i < rows.length ; i++){
	  		 				var chkd=rows[i].cperson;
	  						if(typeof(chkd) != "undefined"){
	  						referencelength=referencelength+1;
	  						newTextBox = $(document.createElement("input"))
	  					    .attr("type", "dil")
	  					    .attr("id", "txtreference"+i)
	  					    .attr("name", "txtreference"+i)
	  					    .attr("hidden", "true");
	  				
	  					newTextBox.val(rows[i].cperson+" :: "+rows[i].desig+" :: "+rows[i].mob+" :: "+rows[i].email+" ::");
	  					newTextBox.appendTo('form');
	  					}
	  			      }
	  			      $('#referencelength').val(referencelength);
	  			      
	  			      var rows = $("#jqxCreditCardDetails").jqxGrid('getrows');
	  					 var creditcardlength=0;
	  						 for(var i=0 ; i < rows.length ; i++){
	  							var chkng=rows[i].type;
	  							if(typeof(chkng) != "undefined"){
	  								creditcardlength=creditcardlength+1;
	  								newTextBox = $(document.createElement("input"))
	  							    .attr("type", "dil")
	  							    .attr("id", "txtcard"+i)
	  							    .attr("name", "txtcard"+i)
	  							    .attr("hidden", "true");
	  						
	  						newTextBox.val(rows[i].type+" :: "+rows[i].cardno+" :: "+rows[i].hidexpdate+":: "+rows[i].defaultcard+":: "+rows[i].remarks);
	  						newTextBox.appendTo('form');
	  						 }
	  						}
	  			 		 $('#creditcardlength').val(creditcardlength);
	  			 		 
	  			 		 
	  		    		if(parseInt($('#separateservicechargeallowed').val())==1){
	  		    			 
	  		    			var rows = $("#separateServiceChargeGridId").jqxGrid('getrows');
		  					 var separateservicechargelength=0;
		  						 for(var i=0 ; i < rows.length ; i++){
		  							var chked=rows[i].doc_no;
		  							if(typeof(chked) != "undefined"){
		  								separateservicechargelength=separateservicechargelength+1;
		  								newTextBox = $(document.createElement("input"))
		  							    .attr("type", "dil")
		  							    .attr("id", "txtseparateservicecharge"+i)
		  							    .attr("name", "txtseparateservicecharge"+i)
		  							    .attr("hidden", "true");
		  						
		  						newTextBox.val(rows[i].doc_no+" :: "+rows[i].salik+" :: "+rows[i].traffic);
		  						newTextBox.appendTo('form');
		  						 }
		  						}
		  			 		 $('#separateservicechargelength').val(separateservicechargelength);
		  			 		 
	  		    		}
	  		    		
					    $('#cmbgroup1').attr('disabled', false);
	  					$("#frmClientMaster").submit(); 
	  				 }
	  			   
	  		}
		}
		x.open("GET", "getDriverDetailsVerification.jsp?driverdetails="+driverdetails+"&docno="+docno+"&mode="+mode, true);
		x.send();
     }
	 
	 function getMobileNoAlreadyExists(mobileno,docno,mode){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();

	  				if(parseInt(items)==1){
	  					 $.messager.alert('Message','Personal Mobile No. Already Exists.','warning');
	  					 return 0;
	  				 }
	  		}
		}
		x.open("GET", "getMobileNoAlreadyExists.jsp?mobileno="+mobileno+"&docno="+docno+"&mode="+mode, true);
		x.send();
    }
    
	function getDrivingLicenceNoAlreadyExists(licenceno,docno,mode){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();

	  				if(parseInt(items)==1){
	  					$.messager.alert('Message','Licence# Already Exists.','warning');
	  					 return 0;
	  				 }  			   
	  		}
		}
		x.open("GET", "getDrivingLicenceNoAlreadyExists.jsp?licenceno="+licenceno+"&docno="+docno+"&mode="+mode, true);
		x.send();
    }
	
    function getVisaNoAlreadyExists(visano,docno,mode){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();

	  				if(parseInt(items)==1){
	  					$.messager.alert('Message','ID# Already Exists.','warning');
	  					 return 0;
	  				 }
	  			   
	  		}
		}
		x.open("GET", "getVisaNoAlreadyExists.jsp?visano="+visano+"&docno="+docno+"&mode="+mode, true);
		x.send();
    }
      
    function getPassportNoAlreadyExists(passportno,docno,mode){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();

	  				if(parseInt(items)==1){
	  					$.messager.alert('Message','Passport# Already Exists.','warning');
	  					 return 0;
	  				 }
	  			   
	  		}
		}
		x.open("GET", "getPassportNoAlreadyExists.jsp?passportno="+passportno+"&docno="+docno+"&mode="+mode, true);
		x.send();
    }

      
      function getContractDate(){
		if ($("#mode").val() == "A") {
			var curdate= $('#jqxClientDate').jqxDateTimeInput('getDate');
			var oneyeardate=new Date(new Date(curdate).setMonth(curdate.getMonth()+36));
			var oneyearafterdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
			$('#jqxContractDate ').jqxDateTimeInput('setDate', new Date(oneyearafterdate));
		}
      }
	  
	  function getDefaultService() {
		  
		  var hidclientsrvchrges=$('#hidclientsrvchrges').val();
		 	var x = new XMLHttpRequest();
    		x.onreadystatechange = function() {
    			if (x.readyState == 4 && x.status == 200) {
    				var items = x.responseText;
    				items = items.split('####');
    				var serviceItems = items[0].split(",");
    				var serviceRateItems = items[1].split(",");
    				 $('#txtsalik').val("0");
    				$('#txtsalikauh').val("0");
    				$('#txttraffic').val("0");
    				$('#txtparking').val("0"); 
    				for (var i = 0; i < serviceItems.length; i++) {
      					if(serviceItems[i]=='saliksrv'){
      						if(hidclientsrvchrges==1 || hidclientsrvchrges==2 || hidclientsrvchrges==3 ){
      						$('#txtsalik').val(0);
      						document.getElementById("chksalikdxbpercent").checked=true;
      						document.getElementById("hidchksalikdxbpercent").value = 1;
      						}else{
      						$('#txtsalik').val(serviceRateItems[i]);	
      						}
      						
        				}// saliksrv end
      					else if(serviceItems[i]=='trafficsrv'){
        					$('#txttraffic').val(serviceRateItems[i]);
        				}//trafficsrv end
        				else if(serviceItems[i]=='saliksrvAUH'){
        					$('#txtsalikauh').val(serviceRateItems[i]);
        				} //saliksrvAUH end
        				else if(serviceItems[i]=='InvSalikParking'){
        					if(hidclientsrvchrges==2  || hidclientsrvchrges==3){
        						$('#txtparking').val(0);
        						document.getElementById("chkparkingpercent").checked=true;
        						$('#parkingpercent').val(parseInt(serviceRateItems[i]));
        						 if(document.getElementById("chkparkingpercent").checked){
        							 	document.getElementById("hidchkparkingpercent").value = 1;
        	        					$('#parkingpercent').val(parseInt(serviceRateItems[i]));
        	        				}else if (!document.getElementById("chkparkingpercent").checked) {
        	        					document.getElementById("hidchkparkingpercent").value = 0;
        	                            $('#parkingpercent').val("0"); 
        	        				}
        					}else{
        					$('#txtparking').val(serviceRateItems[i]);
        					 if(document.getElementById("chkparkingpercent").checked){
        						 document.getElementById("hidchkparkingpercent").value = 1;
        						 $('#parkingpercent').val(parseInt(serviceRateItems[i]));
        					 }else if (!document.getElementById("chkparkingpercent").checked) {
        						 document.getElementById("hidchkparkingpercent").value = 0;
                            	 $('#parkingpercent').val("0"); 
        					 }
        					}
        				}  //InvSalikParking end
        				else if(serviceItems[i]=='clientSrvChrges'){
        				
        					if(hidclientsrvchrges==1 || hidclientsrvchrges==2  || hidclientsrvchrges==3){
        				    document.getElementById("chksalikdxbpercent").checked=true;
        					$('#salikpercent').val(parseInt(serviceRateItems[i]));
        					 if(document.getElementById("chksalikdxbpercent").checked){
        						 document.getElementById("hidchksalikdxbpercent").value = 1;
        						$('#salikpercent').val(parseInt(serviceRateItems[i]));
        					 }else if (!document.getElementById("chksalikdxbpercent").checked) {
        						 document.getElementById("hidchksalikdxbpercent").value = 0;
                            $('#salikpercent').val("0"); 
        					 }
        				}
        					if(hidclientsrvchrges==3){
            				    document.getElementById("chktrafficpercent").checked=true;
            				
            					 if(document.getElementById("chktrafficpercent").checked){
            						 	document.getElementById("hidchktrafficpercent").value = 1 ;
            							$('#trafficpercent').val(parseInt("10"));
            					 }else if (!document.getElementById("chktrafficpercent").checked) {
            						 	document.getElementById("hidchktrafficpercent").value = 0 ;
                                		$('#trafficpercent').val("0"); 
            					 }
            				}
        				
      				}//clientSrvChrges end
    				}// loop end
    				
    			} else {
    			}
    		}
    		x.open("GET", "getDefaultServiceCharge.jsp", true);
    		x.send();
    	}
		
	  function getDefaultInvoicingMethod(){
		  		var x = new XMLHttpRequest();
		  		x.onreadystatechange = function() {
		  			if (x.readyState == 4 && x.status == 200) {
		  				var items = x.responseText.trim();
		  			    $('#cmbinvoicing_method').val(items);
		  			    
		  		}
		  		}
		  		x.open("GET", "getDefaultInvoicingMethod.jsp", true);
		  		x.send();
		}
	  
	  function getTax() {
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText;
	  				items = items.split('####');
	  				var taxItems = items[0].split(",");
	  				var taxIdItems = items[1].split(",");
	  				var optionstax ='<option value="">--Select--</option>';
    				
	  				for (var i = 0; i < taxItems.length; i++) {
	  					optionstax += '<option value="' + taxIdItems[i] + '">'
	  							+ taxItems[i] + '</option>';
	  				}
	  				$("select#cmbtax").html(optionstax);
	  				if ($('#hidcmbtax').val() != null) {
	  					$('#cmbtax').val($('#hidcmbtax').val());
	  				}
	  			} else {
	  			}
	  		}
	  		x.open("GET", "getTax.jsp", true);
	  		x.send();
	  	}
	  
	  function getNonTaxableEntity(){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();
	  			    if(parseInt(items)==1) {
	  			    	document.getElementById("lblnontaxableentity").style.display = 'none';
	  			    	$('#chcknontaxableentity').attr('hidden', false);
	  			    	document.getElementById("lbltaxableentity").style.display = 'inline-block';
	  			    	$('#cmbtax').attr('hidden', false);
	  			    	document.getElementById("lbltrnnoentity").style.display = 'inline-block';
	  			    	$('#txtregisteredtrnno').attr('hidden', false);
	  			    	if($('#mode').val()=='A') {
	  			    		$('#hidchcknontaxableentity').val(1);
							document.getElementById("chcknontaxableentity").checked = true;
	  			    	}
	  			    } else {
	  			    	document.getElementById("lblnontaxableentity").style.display = 'none';
	  			    	$('#chcknontaxableentity').attr('hidden', true);
	  			    	document.getElementById("lbltaxableentity").style.display = 'none';
	  			    	$('#cmbtax').attr('hidden', true);
	  			    	document.getElementById("lbltrnnoentity").style.display = 'none';
	  			    	$('#txtregisteredtrnno').attr('hidden', true);
	  			    	if($('#mode').val()=='A') {
	  			    		$('#hidchcknontaxableentity').val(0);
							document.getElementById("chcknontaxableentity").checked = false;
	  			    	}
	  			    }
	  			    
	  		}
	  		}
	  		x.open("GET", "getNonTaxableEntity.jsp", true);
	  		x.send();
	 }
      
      function nationalitySearchContent(url) {
		 	$('#nationalityWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#nationalityWindow').jqxWindow('setContent', data);
			$('#nationalityWindow').jqxWindow('bringToFront');
		}); 
		}
      
      function stateSearchContent(url) {
		 	$('#stateWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#stateWindow').jqxWindow('setContent', data);
			$('#stateWindow').jqxWindow('bringToFront');
		}); 
		}
      
      $(function(){
	        $('#frmClientMaster').validate({
	                rules: {
	                txtclient_name:"required",
	                cmbcategory:"required",
	                //cmbsalesman:"required",
	                //cmbgroup1:"required",
	                //txtmob: {"required":true,digits:true,maxlength:12,minlength:12},
	                 
	                 },
	                 messages: {
	                 txtclient_name:" *",
	                 cmbcategory:" *",
	                 //cmbsalesman:" *",
	                 //cmbgroup1:" *",
	                 //txtmob: {required:" *",digits:" Invalid Mobile Number",maxlength:" Maximum 12 Digits",minlength:" Please Enter 12 Digits"},
	                 }
	        });});
      
     function defaultcheck(){
 		 if(document.getElementById("chckdefault").checked){
 			 document.getElementById("hidchckdefault").value = 1;
 			 $('#txtsalik').attr('readonly', true );
 			 $('#txtsalikauh').attr('readonly', true );
 			 $('#txttraffic').attr('readonly', true );
			 getDefaultService();
 			 
 		 }
 		 else{
 			 document.getElementById("hidchckdefault").value = 0;
 			 $('#txtsalik').attr('readonly', false );
 			 $('#txtsalikauh').attr('readonly', false );
 			 $('#txttraffic').attr('readonly', false );
 			 $('#txtparking').attr('readonly', false );
 			/*  $('#txtsalik').val("0.0");
 			 $('#txtsalikauh').val("0.0");
 			 $('#txttraffic').val("0.0");
 			 $('#txtparking').val("0.0"); */
 		 }
 	 }
     
	function funChangeSalikPercent(){
 		if(document.getElementById("chksalikpercent").checked){
 			document.getElementById("hidchksalikpercent").value = 1;
 			$('#salikpercent').attr('readonly', false);
 			$('#salikauhpercent').attr('readonly',false );
 			$('#trafficpercent').attr('readonly',false );
 			if($('#mode').val()=='A' ){
 				$('#salikpercent,#salikauhpercent,#trafficpercent').val(0);	
 			}
 			
		}
 		else{
 			document.getElementById("hidchksalikpercent").value = 0;
 			$('#salikpercent').attr('readonly', true);
 			$('#salikauhpercent').attr('readonly',true);
 			$('#trafficpercent').attr('readonly',true);
 			if($('#mode').val()!='view' ){
 				$('#salikpercent,#salikauhpercent,#trafficpercent').val(0);	
 			} 
 		}
 	 }
	 function funChangeSalikDARBPercent(){
	 		if(document.getElementById("chksalikauhpercent").checked){
	 			document.getElementById("hidchksalikauhpercent").value = 1;
	 			$('#salikauhpercent').attr('readonly',false );
	 			if($('#mode').val()=='A' ){
	 				$('#salikauhpercent').val(0);	
	 			}
	 			
			}
	 		else{
	 			document.getElementById("hidchksalikauhpercent").value = 0;
	 			$('#salikauhpercent').attr('readonly',true);
	 			if($('#mode').val()!='view' ){
	 				$('#salikauhpercent').val(0);	
	 			} 
	 		}
	 	 }
		
		function funChangeSalikDXBPercent(){
	 		if(document.getElementById("chksalikdxbpercent").checked){
	 			getDefaultService();
	 			document.getElementById("hidchksalikdxbpercent").value = 1;
	 			$('#salikpercent').attr('readonly',false );
	 			if($('#mode').val()=='A' ){
	 				$('#salikpercent').val(0);	
	 			}
	 			
			}
	 		else{
	 			document.getElementById("hidchksalikdxbpercent").value = 0;
	 			$('#salikpercent').attr('readonly',true);
	 			if($('#mode').val()!='view' ){
	 				$('#salikpercent').val(0);	
	 			} 
	 		}
	 	 }
		function funChangeSalikTRAFPercent(){
	 		if(document.getElementById("chktrafficpercent").checked){
	 			document.getElementById("hidchktrafficpercent").value = 1;
	 			$('#trafficpercent').attr('readonly',false );
	 			if($('#mode').val()=='A' ){
	 				$('#trafficpercent').val(0);	
	 			}
	 			
			}
	 		else{
	 			document.getElementById("hidchktrafficpercent").value = 0;
	 			$('#trafficpercent').attr('readonly',true);
	 			if($('#mode').val()!='view' ){
	 				$('#trafficpercent').val(0);	
	 			} 
	 		}
	 	 }
		
		function funChangeSalikPARKFPercent(){
		
	 		if(document.getElementById("chkparkingpercent").checked){
	 			getDefaultService();
	 			document.getElementById("hidchkparkingpercent").value = 1;
	 			$('#parkingpercent').attr('readonly',false );
	 			if($('#mode').val()=='A' ){
	 				$('#parkingpercent').val(0);	
	 			}
	 			
			}
	 		else{
	 			document.getElementById("hidchkparkingpercent").value = 0;
	 			$('#parkingpercent').attr('readonly',true);
	 			if($('#mode').val()!='view' ){
	 				$('#parkingpercent').val(0);	
	 			} 
	 		}
	 	 } 
     function defaultseparateservicecheck(){
 		 if(document.getElementById("chckseparatesrvcdefault").checked){
 			 document.getElementById("hidchckseparatesrvcdefault").value = 1;
 		 }
 		 else{
 			 document.getElementById("hidchckseparatesrvcdefault").value = 0;
 		 }
 		 getDefaultSeparateService();
 	 }
     
     function getDefaultSeparateService(){
    	 if(parseInt($('#separateservicechargeallowed').val())==1){
    		 $("#separateServiceChargeGridDiv").load("separateServiceChargesGrid.jsp?check=2&defaultsevicecharge="+$('#hidchckseparatesrvcdefault').val());
    	 }
     }
     
	 function advancecheck(){
 		 if(document.getElementById("chckadvance").checked){
 			 document.getElementById("hidchckadvance").value = 1;
 		 }
 		 else{
 			 document.getElementById("hidchckadvance").value = 0;
 		 }
 	 }
	 
	 function nontaxableentitycheck() {
		 if(document.getElementById("chcknontaxableentity").checked){
 			 document.getElementById("hidchcknontaxableentity").value = 1;
 		 }
 		 else{
 			 document.getElementById("hidchcknontaxableentity").value = 0;
 		 }
	 }
	 
     function mobileValid(value){
    	   if(value!=""){ 
    	    var phoneno = /^\d{12}$/;  
			if(value.match(phoneno)){
				document.getElementById("errormsg").innerText="";
				$('#txtmobilevalidation').val(0);
				return true;
			}
			else{
				document.getElementById("errormsg").innerText="Invalid Mobile Number";
				$('#txtmobilevalidation').val(1);
				return false;
			}
    	    } 
    	   return true;
     }
 	 
	 function funReadOnly(){
			$('#frmClientMaster input').attr('readonly', true );
			$('#frmClientMaster select').attr('disabled', true);
			$('#jqxClientDate').jqxDateTimeInput({disabled: true});
			$('#jqxContractDate').jqxDateTimeInput({disabled: true});
			$('#dateOfJoining').jqxDateTimeInput({disabled: true});
			$('#chcknontaxableentity').attr('disabled', true);
			$('#chckseparatesrvcdefault').attr('disabled', true);
			$("#separateServiceChargeGridId").jqxGrid({ disabled: true});
			$("#jqxReferenceDetails").jqxGrid({ disabled: true});
			$("#refdetsearch").jqxGrid({ disabled: true});
			$("#jqxCreditCardDetails").jqxGrid({ disabled: true});
	 }
	 
	 function funRemoveReadOnly(){
		    getContract();getIDPDetails();getCRMDriverDetailsVerify();getSeparateServiceChargeAllowed();getNonTaxableEntity();getSalesmanConfigs();getclientSrvChrges();
			$('#frmClientMaster input').attr('readonly', false );
			$('#frmClientMaster select').attr('disabled', false);
			$('#chckdefault').attr('disabled', false);
			$('#chckseparatesrvcdefault').attr('disabled', false);
			// $('#cmbgroup1').attr('disabled', true);
			$('#chcknontaxableentity').attr('disabled', false);
			$('#jqxClientDate').jqxDateTimeInput({disabled: false});
			$('#jqxContractDate').jqxDateTimeInput({disabled: false});
			$('#dateOfJoining').jqxDateTimeInput({disabled: false});
			$('#txtaccount').attr('readonly', true);
			$('#txtcode').attr('readonly', true);
			$('#docno').attr('readonly', true);
			//$("#jqxDriver").jqxGrid({ disabled: false});
			$("#jqxReferenceDetails").jqxGrid({ disabled: false});
			$("#refdetsearch").jqxGrid({ disabled: false});
			$("#jqxCreditCardDetails").jqxGrid({ disabled: false});
			$("#separateServiceChargeGridId").jqxGrid({ disabled: false});
			
			if ($("#mode").val() == "A") {
			     
					getDefaultService();getDefaultInvoicingMethod();
		 			$('#txtsalik').attr('readonly', true );
		 			$('#txtsalikauh').attr('readonly', true );
		 			$('#txttraffic').attr('readonly', true );
		 			$('#hidchckdefault').val(1);
		 			$('#hidchckseparatesrvcdefault').val(1);
					$('#hidchckadvance').val(0);
					//document.getElementById("chckdefault").checked = true;
				 	var hidclientsrvchrges=	$('#hidclientsrvchrges').val();
					if(hidclientsrvchrges==1 ||hidclientsrvchrges==2 ||hidclientsrvchrges==3 ){
						document.getElementById("chckdefault").checked = false;
						document.getElementById("hidchckdefault").value = 0;
						}else{
						document.getElementById("chckdefault").checked = true;
						document.getElementById("hidchckdefault").value = 1;
							
						}
					document.getElementById("chckseparatesrvcdefault").checked = true;
					document.getElementById("chckadvance").checked = false;
					$('#cmbsalesman').prop('selectedIndex',0);
					$('#cmbtax').prop('selectedIndex',0);
					 
					$('#jqxClientDate').val(new Date());
					$('#jqxContractDate').val(null);
					$('#dateOfJoining').val(null);
					
					$("#jqxDriver").jqxGrid('clear'); 
					$("#jqxDriver").jqxGrid('addrow', null, {});
					$("#jqxCreditCardDetails").jqxGrid('clear'); 
					$("#jqxCreditCardDetails").jqxGrid('addrow', null, {});
					$("#jqxReferenceDetails").jqxGrid('clear'); 
					$("#jqxReferenceDetails").jqxGrid('addrow', null, {});
					$("#separateServiceChargeGridId").jqxGrid('clear'); 
					funChangeSalikPercent();
			}
			
			if ($("#mode").val() == "E") {
				$("#jqxDriver").jqxGrid('addrow', null, {});
				$("#jqxDriver").jqxGrid('hidecolumn', 'attachbtn');
				$("#jqxCreditCardDetails").jqxGrid('addrow', null, {});
				$("#jqxReferenceDetails").jqxGrid('addrow', null, {});
				
				if($('#salesmaneditstatus').val()=="1"){
					$("#cmbsalesman").attr("disabled",true);
				}
			}
			funCreditCardValidate();
	 }
	 function funNotify(){	
		 /* Validation */
		 $('#jqxDriver').jqxGrid('clearfilters');  
		 
		 valid=document.getElementById("txtvalidation").value;
		 if(valid==1){
			 document.getElementById("errormsg").innerText="Invalid Values.";
			 return 0;
		 }
		 
		 accgroup=document.getElementById("txtcategoryvalidation").value;
		 if(accgroup==1){
			 document.getElementById("errormsg").innerText="Individual Client should have Retail Client A/C Group.";
			 return 0;
		 }
		 
		 if($('#mode').val()=="A"){
			 if($('#cmbsalesman').val()==""){
				 document.getElementById("errormsg").innerText="Salesman is mandatory.";
				 return 0;
			 }
		 }
		 if($('#mode').val()=="E"){
			 if($('#cmbsalesman').val()=="" && $('#salesmaneditstatus').val()!="1"){
				 document.getElementById("errormsg").innerText="Salesman is mandatory.";
				 return 0;
			 }
		 }
		 if(document.getElementById("chksalikpercent").checked==true){
			 if(document.getElementById("salikpercent").value==""){
				 document.getElementById("errormsg").innerText="Salik Percent Mandatory when percentage selected.";
				 return 0;
			 }
			 if(document.getElementById("salikauhpercent").value==""){
				 document.getElementById("errormsg").innerText="Salik DARB Percent Mandatory when percentage selected.";
				 return 0;
			 }
			 if(document.getElementById("trafficpercent").value==""){
				 document.getElementById("errormsg").innerText="Traffic Percent Mandatory when percentage selected.";
				 return 0;
			 }
		 }
		
		 invoice=document.getElementById("cmbinvoicing_method").value;
		 if(invoice=="" || invoice==0){
			 document.getElementById("errormsg").innerText="Please Select Invoicing Method.";
			 return 0;
		 }
		 
		 chkvalid=document.getElementById("chkvalid").value;
		 if(chkvalid==1){
			 document.getElementById("errormsg").innerText="Invalid Values.";
			 return 0;
		 }
		 
		 chkcardvalid=document.getElementById("chkcardvalid").value;
		 if(chkcardvalid==1){
			 document.getElementById("errormsg").innerText="Invalid Credit Card.";
			 return 0;
		 }
		 
		 if($("#personal_tel2").val()==""){
			/*  document.getElementById("errormsg").innerText="Invalid Mobile Number.";
			 return 0; */
		 }
		 
		 mobilevalid=document.getElementById("txtmobilevalidation").value;
		 if(mobilevalid==1){
			 document.getElementById("errormsg").innerText="Invalid Mobile Number.";
			 return 0;
		 }
		 
		 var tax=document.getElementById("cmbtax").value;
		 if(tax.trim()=='' || tax.trim()=='0'){
			 document.getElementById("errormsg").innerText="Tax is Mandatory.";
			 return 0;
		 }
		 
		 if($('#cmbtax').val()=='1'){
			 var registeredtrnno=document.getElementById("txtregisteredtrnno").value;
			 if(registeredtrnno.trim()==''){
				 document.getElementById("errormsg").innerText="TRN No. is Mandatory for VAT.";
				 return 0;
			 } 
		 }
		// cmbgroup1
		var account=document.getElementById("cmbgroup1").value;
		 if(account=="" || account=="null" || typeof(account)=="NaN" || typeof(account)=="undefined" || account=="0")
			{
			document.getElementById("errormsg").innerText=" Enter Account Group";
			document.getElementById("cmbgroup1").focus();  
			return 0;
			}
			
		 
		 if($('#creditcardstatus').val()=="1"){
		 	//Checking Minimum 1 card is available
		 	
		 	var cardtype=$('#jqxCreditCardDetails').jqxGrid('getcellvalue',0,'type');
		 	var cardno=$('#jqxCreditCardDetails').jqxGrid('getcellvalue',0,'cardno');
		 	var cardexp=$('#jqxCreditCardDetails').jqxGrid('getcellvalue',0,'exp_date');
		 	
		 	if(cardtype==null || cardtype=="" || cardtype=="undefined" || typeof(cardtype)=="undefined"){
		 		var targetid=$('#tabs').find('li').eq(2).attr('id');
		 		if(targetid!="current"){
		 			$('#tabs').find('li').eq(2).trigger('click');
		 		}
		 		document.getElementById("errormsg").innerText="Card Type Required.";
				return 0;
		 	}
		 	var cardmax=0;
		 	if(cardtype=="VISA" || cardtype=="MASTER"){
		 		cardmax=16;
		 	}
		 	else if(cardtype=="AMEX"){
		 		cardmax=15;
		 	}
		 	
		 	if(cardno.length!=cardmax){
		 		var targetid=$('#tabs').find('li').eq(2).attr('id');
		 		if(targetid!="current"){
		 			$('#tabs').find('li').eq(2).trigger('click');
		 		}
		 		document.getElementById("errormsg").innerText="Card Number should be "+cardmax+" digits";
				return 0;
		 	}
		 	
		 	if(cardexp==null || cardexp=="" || cardexp=="undefined" || typeof(cardexp)=="undefined"){
		 		document.getElementById("errormsg").innerText="Card Expiry not valid";
				return 0;
		 	}
		 	var currentdate=new Date();
		 	cardexp=new Date(cardexp);
		 	console.log("Current:"+currentdate);
		 	console.log("Card DAte:"+cardexp);
		 	if(cardexp.getFullYear()<currentdate.getFullYear()){
		 		var targetid=$('#tabs').find('li').eq(2).attr('id');
		 		if(targetid!="current"){
		 			$('#tabs').find('li').eq(2).find('a').trigger('click');
		 		}
		 		document.getElementById("errormsg").innerText="Card Expiry not valid";
				return 0;
		 	}
		 	else if(cardexp.getFullYear()==currentdate.getFullYear()){
		 		if(cardexp.getMonth()<currentdate.getMonth()){
		 			var targetid=$('#tabs').find('li').eq(2).attr('id');
			 		if(targetid!="current"){
			 			$('#tabs').find('li').eq(2).find('a').trigger('click');
			 		}
		 			document.getElementById("errormsg").innerText="Card Expiry not valid";
					return 0;	
		 		}
		 		else if(cardexp.getMonth()==currentdate.getMonth()){
		 			if(cardexp.getDate()<currentdate.getDate()){
		 				var targetid=$('#tabs').find('li').eq(2).attr('id');
				 		if(targetid!="current"){
				 			$('#tabs').find('li').eq(2).find('a').trigger('click');
				 		}
			 			document.getElementById("errormsg").innerText="Card Expiry not valid";
						return 0;	
		 			}
		 		}
		 	}
		 }
		 document.getElementById("errormsg").innerText="";		 
		 /* Validation Ends*/

	 		 clientname=document.getElementById("txtclient_name").value;
			 salutation=document.getElementById("cmbsalutation").value;
			 docno=document.getElementById("docno").value;
			 mode=document.getElementById("mode").value;
			 getClientAlreadyExists(clientname,salutation,docno,mode);
	    	
		} 
	 
	 function funSearchLoad(){
			changeContent('crmMainSearch.jsp'); 
		 }
	 
	 function funFocus(){
	    	$('#jqxClientDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	 /* function funCurrency(){
		 
		 if($('#hidcmbcurrency').val()!=""){
			 $('#cmbcurrency').val($('#hidcmbcurrency').val());
		 }
	 } */
	 
	 function setValues(){
		    getSeparateServiceChargeAllowed();
		    
		    /* Enquiry Form dtype */
		    document.getElementById("formdetail").value="Client";
		    document.getElementById("formdetailcode").value="CRM";
		     // alert($('#hidjqxClientDate').val());
			 if($('#hidjqxClientDate').val()){
				 $("#jqxClientDate").jqxDateTimeInput('val', $('#hidjqxClientDate').val());
			  }
			 
			 if($('#hidjqxContractDate').val()){
				 $("#jqxContractDate").jqxDateTimeInput('val', $('#hidjqxContractDate').val());
			  }
			 
			 if($('#hiddateOfJoining').val()){
				 $("#dateOfJoining").jqxDateTimeInput('val', $('#hiddateOfJoining').val());
			  }
			 
			 if(document.getElementById("hidchckdefault").value==1){
	 			 document.getElementById("chckdefault").checked = true;
	 		 }
	 		 else if(document.getElementById("hidchckdefault").value==0){
	 			document.getElementById("chckdefault").checked = false;
	 		 }
			 
			 if(document.getElementById("hidchckseparatesrvcdefault").value==1){
	 			 document.getElementById("chckseparatesrvcdefault").checked = true;
	 		 }
	 		 else if(document.getElementById("hidchckseparatesrvcdefault").value==0){
	 			document.getElementById("chckseparatesrvcdefault").checked = false;
	 		 }
			 
			 if(document.getElementById("hidchckadvance").value==1){
	 			 document.getElementById("chckadvance").checked = true;
	 		 }
	 		 else if(document.getElementById("hidchckadvance").value==0){
	 			document.getElementById("chckadvance").checked = false;
	 		 }
			 
			 if(document.getElementById("hidchcknontaxableentity").value==1){
	 			 document.getElementById("chcknontaxableentity").checked = true;
	 		 }
	 		 else if(document.getElementById("hidchcknontaxableentity").value==0){
	 			document.getElementById("chcknontaxableentity").checked = false;
	 		 }
			 
			 if($('#hidcmbcurrency').val()!=""){
				 getCurrencyIds();
				 $('#cmbcurrency').val($('#hidcmbcurrency').val());
			 }
			 
			// funCurrency();
			//document.getElementById("cmbcurrency").value=document.getElementById("hidcmbcurrency").value;
			document.getElementById("cmbinvoicing_method").value=document.getElementById("hidcmbinvoicing_method").value;
			$('#cmbdel_charges').val($('#hidcmbdel_charges').val());  
			
			 if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			 
			 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
			 funSetlabel();
            
             var indexVal = document.getElementById("docno").value;
			 if(indexVal> 0){
				 getCategoryWiseEditEnable($('#cmbcategory').val());
				 var check = 1;
				 $("#jqxDriver1").load("driver.jsp?txtclientdocno1="+indexVal+"&check="+check);
				 $("#creditCardDetailsDiv").load("creditCardDetailsGrid.jsp?txtclientdocno2="+indexVal+"&check="+check);
				 $("#jqxReferenceDetails1").load("referenceDetails.jsp?txtclientdocno3="+indexVal+"&check="+check);
				 $("#jqxReferenceDetails2").load("referenceDetailsnew.jsp?txtclientdocno4="+indexVal);
				 $("#separateServiceChargeGridDiv").load("separateServiceChargesGrid.jsp?check=1&txtclientdocno4="+indexVal);
			 	if(document.getElementById("hidchksalikpercent").value=="0"){
			 		document.getElementById("chksalikpercent").checked=false;
			 		funChangeSalikPercent();
			 	}
			 	else if(document.getElementById("hidchksalikpercent").value=="1"){
			 		document.getElementById("chksalikpercent").checked=true;
			 		funChangeSalikPercent();
			 	}
			 	funCreditCardValidate();
			 	
			 	if($('#hidchksalikauhpercent').val()=='1'){
			 		document.getElementById('chksalikauhpercent').checked=true;
			 	}
			 	else{
			 		document.getElementById('chksalikauhpercent').checked=false;
			 	}
			 	
			 	if($('#hidchksalikdxbpercent').val()=='1'){
			 		document.getElementById('chksalikdxbpercent').checked=true;
			 	}
			 	else{
			 		document.getElementById('chksalikdxbpercent').checked=false;
			 	}
			 	
			 	if($('#hidchktrafficpercent').val()=='1'){
			 		document.getElementById('chktrafficpercent').checked=true;
			 	}
			 	else{
			 		document.getElementById('chktrafficpercent').checked=false;
			 	}
			 	
			 	if($('#hidchkparkingpercent').val()=='1'){
			 		document.getElementById('chkparkingpercent').checked=true;
			 	}
			 	else{
			 		document.getElementById('chkparkingpercent').checked=false;
			 	}
			 }
		}
	 function getSalesmanConfigs(){
		  
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();
	  			    $('#salesmaneditstatus').val(items);
	  			  	//alert(items)
	  			  	if(items=="1")   
	  			  	{
	  			  		if($('#mode').val()!="A"){
	  			  			$("#cmbsalesman").attr("disabled",true);	
	  			  		}
			  			
			  			
			  		}else {
			  			$("#cmbsalesman").attr("disabled",false);
			  			
			  		}
			  		}
	  		}
	  		x.open("GET", "getSalesmanConfigs.jsp", true);
	  		x.send();
	 }
	 function funChkButton() {
			/* funReset(); */
		}
	 function funexcelexport(){
	 $("#documentExpiryDiv").excelexportjs({
			containerid: "", 
			datatype: 'json', 
			dataset: null, 
			gridId: "jqxloaddataGrid", 
			columns: getColumns("jqxloaddataGrid") ,   
			worksheetName:"clientMaster"
			});
	 }
	 
	 function funCreditCardValidate(){
		 
		 var catid=$('#cmbcategory').val();
		 $.get('getCreditCardValidate.jsp',{'catid':catid},function(data){
			data=JSON.parse(data);
			$('#creditcardstatus').val(data.creditcardstatus);
		 });
	 }
</script>

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
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 20px;
    max-width: 1450px;
    margin: auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

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

label {
    font: 14px 'Segoe UI';
    font-weight: 500;
    color: #253858;
    white-space: nowrap;
    line-height: 32px;
}

.section-block {
    flex: 1;
    min-width: 0;
    background: #f6f8fa;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.1);
    margin-bottom: 20px;
}

.section-block h2 {
    font-size: 1.1rem;
    font-weight: 600;
    margin: 0 0 20px;
    padding-left: 10px;
    border-left: 4px solid #007bff;
    display: flex;
    align-items: center;
    gap: 10px;
}

.section-row {
    display: flex;
    gap: 20px;
    margin-bottom: 20px;
}

.trans-info-grid {
    display: grid;
    grid-template-columns: auto 1fr auto 1fr auto 1fr auto 1fr;
    gap: 12px 15px;
    align-items: center;
}

.agmt-info-grid {
    display: grid;
    grid-template-columns: auto 1fr auto 1fr;
    gap: 12px 20px;
    align-items: center;
}

.service-charge-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
    gap: 15px;
    align-items: center;
}

.hidden-scrollbar {
    overflow-y: visible !important;
    max-height: none !important;
    padding: 10px;
}

/* Tabs Styling */
#tabs {
    list-style: none;
    padding: 0;
    display: flex;
    gap: 5px;
    border-bottom: 2px solid #007bff;
    margin-bottom: 20px;
}

#tabs li a {
    display: block;
    padding: 10px 20px;
    background: #e9ecef;
    text-decoration: none;
    color: #495057;
    border-radius: 8px 8px 0 0;
    font-weight: 600;
}

#tabs li a.current {
    background: #007bff;
    color: #fff;
}

/* Table styling for Tab 2 Communication Grid */
.table1 {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    border: 1px solid #ddd;
    border-radius: 8px;
    overflow: hidden;
}

.table1 th, .table1 td {
    padding: 10px;
    border-bottom: 1px solid #eee;
    border-right: 1px solid #eee;
    text-align: left;
}

.table1 thead th {
    background: #f1f3f5;
    color: #333;
}
</style>
</head>
<body onload="setValues();">

<div id="mainBG" class="homeContent" data-type="background">
    <jsp:include page="../../../../header.jsp"></jsp:include>
    <br>

    <form id="frmClientMaster" action="saveClientMaster" method="post" autocomplete="off">
        <div class="hidden-scrollbar">
            
            <div class="section-block">
                <h2>General Information</h2>
                <div class="trans-info-grid">
                    <label>Date</label>
                    <div id="jqxClientDate" name="jqxClientDate" onchange="getContractDate();" value='<s:property value="jqxClientDate"/>'></div>
                    
                    <label>Code</label>
                    <input type="text" id="txtcode" name="txtcode" tabindex="-1" value='<s:property value="txtcode"/>'/>

                    <label>Name</label>
                    <div style="display: flex; gap: 8px; grid-column: span 3;">
                        <select id="cmbsalutation" name="cmbsalutation" style="width: 100px !important;" value='<s:property value="cmbsalutation"/>'>
                            <option value="">--Select--</option>
                        </select>
                        <input type="text" id="txtclient_name" name="txtclient_name" onfocus="getCurrencyIds();" value='<s:property value="txtclient_name"/>'/>
                    </div>

                    <label>Currency</label>
                    <select id="cmbcurrency" name="cmbcurrency" value='<s:property value="cmbcurrency"/>'>
                        <option value="">--Select--</option>
                    </select>
                    
                    <label>Doc No</label>
                    <input type="text" id="docno" name="txtclientdocno" tabindex="-1" value='<s:property value="txtclientdocno"/>'/>
                </div>
            </div>

            <div class="section-block">
                <h2>Category & Invoicing</h2>
                <div class="trans-info-grid">
                    <label>Category</label>
                    <select id="cmbcategory" name="cmbcategory" onchange="getCategoryAccountGroup(this.value);funCreditCardValidate();" value='<s:property value="cmbcategory"/>'>
                        <option value="">--Select--</option>
                    </select>

                    <label id="lblsalesman">Salesman</label>
                    <select id="cmbsalesman" name="cmbsalesman" value='<s:property value="cmbsalesman"/>'>
                        <option value="">--Select--</option>
                    </select>

                    <label>Invoicing</label>
                    <select id="cmbinvoicing_method" name="cmbinvoicing_method" value='<s:property value="cmbinvoicing_method"/>'>
                        <option value="">--Select--</option>
                        <option value="1">Month End</option>
                        <option value="2">Period</option>
                    </select>

                    <label>Knowledge Fee</label>
                    <select id="cmbdel_charges" name="cmbdel_charges" value='<s:property value="cmbdel_charges"/>'>
                        <option value="">--Select--</option>
                        <option value=1>Yes</option>
                        <option value=0>No</option>
                    </select>

                    <label id="lbltaxableentity">Tax</label>
                    <select id="cmbtax" name="cmbtax" onchange="taxcheck();" value='<s:property value="cmbtax"/>'>
                        <option value="">--Select--</option>
                    </select>

                    <label id="lbltrnnoentity">TRN No.</label>
                    <input type="text" id="txtregisteredtrnno" name="txtregisteredtrnno" value='<s:property value="txtregisteredtrnno"/>'/>

                    <div style="grid-column: span 2; display: flex; gap: 15px;">
                        <span style="display: flex; align-items: center; gap: 5px;">
                            <input type="checkbox" id="chcknontaxableentity" name="chcknontaxableentity" onchange="nontaxableentitycheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                            <label id="lblnontaxableentity">Taxable Entity</label>
                        </span>
                        <span style="display: flex; align-items: center; gap: 5px;">
                            <input type="checkbox" id="chckadvance" name="chckadvance" onchange="advancecheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                            <label>Advance</label>
                        </span>
                    </div>
                </div>
            </div>

            <div class="section-row">
                <div class="section-block">
                    <h2>Account Info</h2>
                    <div class="agmt-info-grid">
                        <label>Account Group</label>
                        <select id="cmbgroup1" name="cmbgroup1" value='<s:property value="cmbgroup1"/>'>
                            <option value="">--Select--</option>
                        </select>

                        <label>Account</label>
                        <input type="text" id="txtaccount" name="txtaccount" tabindex="-1" value='<s:property value="txtaccount"/>'/>

                        <label>Credit Min (Days)</label>
                        <input type="text" id="txtcredit_period_min" name="txtcredit_period_min" style="text-align: right;" value='<s:property value="txtcredit_period_min"/>'/>

                        <label>Max (Days)</label>
                        <input type="text" id="txtcredit_period_max" name="txtcredit_period_max" style="text-align: right;" value='<s:property value="txtcredit_period_max"/>'/>

                        <label>Credit Limit</label>
                        <input type="text" id="txtcredit_limit" name="txtcredit_limit" style="text-align: right;" value='<s:property value="txtcredit_limit"/>'/>
                    </div>
                </div>

                <div class="section-block">
                    <h2>Service Charge</h2>
                    <div id="singleServiceChargeDiv">
                        <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 15px;">
                            <input type="checkbox" id="chckdefault" name="chckdefault" onchange="defaultcheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)"> 
                            <label>Default</label>
                            <input type="checkbox" id="chksalikpercent" name="chksalikpercent" onchange="funChangeSalikPercent();" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                            <label>Percentage Mode</label>
                        </div>
                        
                        <div class="trans-info-grid">
                            <label>DARB</label>
                            <input type="text" id="txtsalikauh" name="txtsalikauh" style="text-align: right;" value='<s:property value="txtsalikauh"/>'/>
                            
                            <label>Salik DXB</label>
                            <input type="text" id="txtsalik" name="txtsalik" style="text-align: right;" value='<s:property value="txtsalik"/>'/>
                            
                            <label>Traffic</label>
                            <input type="text" id="txttraffic" name="txttraffic" style="text-align: right;" value='<s:property value="txttraffic"/>'/>
                            
                            <label>Parking</label>
                            <input type="text" id="txtparking" name="txtparking" style="text-align: right;" value='<s:property value="txtparking"/>'/>
                        </div>

                        <div class="trans-info-grid" style="margin-top: 10px; padding-top: 10px; border-top: 1px dashed #ccc;">
                            <label style="font-size: 11px;">DARB %</label>
                            <div style="display: flex; align-items: center; gap: 4px;">
                                <input type="checkbox" id="chksalikauhpercent" name="chksalikauhpercent" onchange="funChangeSalikDARBPercent();">
                                <input type="text" id="salikauhpercent" name="salikauhpercent" style="text-align: right;" value='<s:property value="salikauhpercent"/>'/>
                            </div>

                            <label style="font-size: 11px;">Salik %</label>
                            <div style="display: flex; align-items: center; gap: 4px;">
                                <input type="checkbox" id="chksalikdxbpercent" name="chksalikdxbpercent" onchange="funChangeSalikDXBPercent();">
                                <input type="text" id="salikpercent" name="salikpercent" style="text-align: right;" value='<s:property value="salikpercent"/>'/>
                            </div>

                            <label style="font-size: 11px;">Traffic %</label>
                            <div style="display: flex; align-items: center; gap: 4px;">
                                <input type="checkbox" id="chktrafficpercent" name="chktrafficpercent" onchange="funChangeSalikTRAFPercent();">
                                <input type="text" id="trafficpercent" name="trafficpercent" style="text-align: right;" value='<s:property value="trafficpercent"/>'/>
                            </div>

                            <label style="font-size: 11px;">Parking %</label>
                            <div style="display: flex; align-items: center; gap: 4px;">
                                <input type="checkbox" id="chkparkingpercent" name="chkparkingpercent" onchange="funChangeSalikPARKFPercent();">
                                <input type="text" id="parkingpercent" name="parkingpercent" style="text-align: right;" value='<s:property value="parkingpercent"/>'/>
                            </div>
                        </div>
                    </div>

                    <div id="separateServiceChargeDiv" hidden="true">
                         <div style="display: flex; align-items: center; gap: 10px;">
                            <input type="checkbox" id="chckseparatesrvcdefault" name="chckseparatesrvcdefault" onchange="defaultseparateservicecheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                            <label>Use Separate Grid</label>
                         </div>
                         <div id="separateServiceChargeGridDiv"><jsp:include page="separateServiceChargesGrid.jsp"></jsp:include></div>
                    </div>
                </div>
            </div>

            <ul id="tabs">
                <li><a href="#" name="tab1" class="current">Driver Details</a></li>
                <li><a href="#" name="tab2">Know Your Customer</a></li>
                <li><a href="#" name="tab3">Banking Details</a></li>
                <li><a href="#" name="tab4">Others</a></li>
            </ul>

            <div id="content">
                <div id="tab1">
                    <div class="section-block">
                        <div id="jqxDriver1"> <jsp:include page="driver.jsp"></jsp:include></div>
                    </div>
                </div>

                <div id="tab2">
                    <div class="section-block">
                        <h2>Communication & Address Details</h2>
                        <table class="table1">
                            <thead>
                                <tr>
                                    <th>Field</th>
                                    <th>Communication</th>
                                    <th>Office</th>
                                    <th>Residence</th>
                                    <th>Home</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><strong>Address 1</strong></td>
                                    <td><input type="text" id="txtpersonal_add1" name="txtpersonal_add1" value='<s:property value="txtpersonal_add1"/>'/></td>
                                    <td><input type="text" id="txtoffice_add1" name="txtoffice_add1" value='<s:property value="txtoffice_add1"/>'/></td>
                                    <td><input type="text" id="txtresidence_add1" name="txtresidence_add1" value='<s:property value="txtresidence_add1"/>'/></td>
                                    <td><input type="text" id="txthome_add1" name="txthome_add1" value='<s:property value="txthome_add1"/>'/></td>
                                </tr>
                                <tr>
                                    <td><strong>Address 2</strong></td>
                                    <td><input type="text" id="txtpersonal_add2" name="txtpersonal_add2" value='<s:property value="txtpersonal_add2"/>'/></td>
                                    <td><input type="text" id="txtoffice_add2" name="txtoffice_add2" value='<s:property value="txtoffice_add2"/>'/></td>
                                    <td><input type="text" id="txtresidence_add2" name="txtresidence_add2" value='<s:property value="txtresidence_add2"/>'/></td>
                                    <td><input type="text" id="txthome_add2" name="txthome_add2" value='<s:property value="txthome_add2"/>'/></td>
                                </tr>
                                <tr>
                                    <td><strong>Telephone</strong></td>
                                    <td><input type="text" id="txtpersonal_tel1" name="txtpersonal_tel1" value='<s:property value="txtpersonal_tel1"/>'/></td>
                                    <td><input type="text" id="txtoffice_tel1" name="txtoffice_tel1" value='<s:property value="txtoffice_tel1"/>'/></td>
                                    <td><input type="text" id="txtresidence_tel1" name="txtresidence_tel1" value='<s:property value="txtresidence_tel1"/>'/></td>
                                    <td><input type="text" id="txthome_tel1" name="txthome_tel1" value='<s:property value="txthome_tel1"/>'/></td>
                                </tr>
                                <tr>
                                    <td><strong>Mobile</strong></td>
                                    <td><input type="text" id="personal_tel2" name="personal_tel2" onblur="mobileValid(this.value);getMobileNoAlreadyExists(this.value,$('#docno').val(),$('#mode').val());" value='<s:property value="personal_tel2"/>'/></td>
                                    <td><input type="text" id="office_tel2" name="office_tel2" onblur="mobileValid(this.value);" value='<s:property value="office_tel2"/>'/></td>
                                    <td><input type="text" id="residence_tel2" name="residence_tel2" onblur="mobileValid(this.value);" value='<s:property value="residence_tel2"/>'/></td>
                                    <td><input type="text" id="home_tel2" name="home_tel2" onblur="mobileValid(this.value);" value='<s:property value="home_tel2"/>'/></td>
                                </tr>
                                <tr>
                                    <td><strong>Email</strong></td>
                                    <td><input type="text" id="txtpersonal_email" name="txtpersonal_email" placeholder="someone@example.com" value='<s:property value="txtpersonal_email"/>'/></td>
                                    <td><input type="text" id="txtoffice_email" name="txtoffice_email" placeholder="someone@example.com" value='<s:property value="txtoffice_email"/>'/></td>
                                    <td><input type="text" id="txtresidence_email" name="txtresidence_email" placeholder="someone@example.com" value='<s:property value="txtresidence_email"/>'/></td>
                                    <td><input type="text" id="txthome_email" name="txthome_email" placeholder="someone@example.com" value='<s:property value="txthome_email"/>'/></td>
                                </tr>
                                <tr>
                                    <td><strong>Makani No.</strong></td>
                                    <td><input type="text" id="txtpersonal_extn_no" name="txtpersonal_extn_no" value='<s:property value="txtpersonal_extn_no"/>'/></td>
                                    <td><input type="text" id="txtoffice_extn_no" name="txtoffice_extn_no" value='<s:property value="txtoffice_extn_no"/>'/></td>
                                    <td><input type="text" id="txtresidence_extn_no" name="txtresidence_extn_no" value='<s:property value="txtresidence_extn_no"/>'/></td>
                                    <td><input type="text" id="txthome_extn_no" name="txthome_extn_no" value='<s:property value="txthome_extn_no"/>'/></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div id="tab3">
                    <div class="section-block">
                        <h2>Credit Card Details</h2>
                        <div id="creditCardDetailsDiv"> <jsp:include page="creditCardDetailsGrid.jsp"></jsp:include></div>
                    </div>
                </div>

                <div id="tab4">
                    <div class="section-row">
                        <div class="section-block">
                            <h2 id="refid">Reference Details</h2>
                            <div id="jqxReferenceDetails1"><jsp:include page="referenceDetails.jsp"></jsp:include></div><br/>
                            <div id="jqxReferenceDetails2"><jsp:include page="referenceDetailsnew.jsp"></jsp:include></div>
                        </div>

                        <div class="section-block">
                            <h2>Sponsor / Company</h2>
                            <div class="agmt-info-grid">
                                <label>Name</label>
                                <input type="text" id="txtname" name="txtname" value='<s:property value="txtname"/>'/>

                                <label>Address</label>
                                <input type="text" id="txtaddress" name="txtaddress" value='<s:property value="txtaddress"/>'/>

                                <label>Telephone</label>
                                <input type="text" id="txttelephone" name="txttelephone" value='<s:property value="txttelephone"/>'/>

                                <label>ID</label>
                                <input type="text" id="txtid" name="txtid" value='<s:property value="txtid"/>'/>

                                <label>Nationality</label>
                                <select id="cmbnationality" name="cmbnationality" value='<s:property value="cmbnationality"/>'>
                                    <option value="">--Select--</option>
                                </select>

                                <label>Security</label>
                                <div style="display: flex; gap: 8px;">
                                    <input type="text" id="txtsecurity" name="txtsecurity" value='<s:property value="txtsecurity"/>'/>
                                    <input type="text" id="txtsecurity1" name="txtsecurity1" value='<s:property value="txtsecurity1"/>'/>
                                </div>

                                <label>Job Title</label>
                                <input type="text" id="txtjobtitle" name="txtjobtitle" value='<s:property value="txtjobtitle"/>'/>

                                <label>Joining Date</label>
                                <div id="dateOfJoining" name="dateOfJoining" value='<s:property value="dateOfJoining"/>'></div>
                                
                                <label>Bank Name</label>
                                <input type="text" id="txtbankname" name="txtbankname" value='<s:property value="txtbankname"/>'/>
                            </div>

                            <div id="contractDiv" hidden="true" style="margin-top: 20px;">
                                <h2 style="font-size: 0.9rem; border-left-color: #ffc107;">Trade License Details</h2>
                                <div class="agmt-info-grid">
                                    <label>License No.</label>
                                    <input type="text" id="txtcontractno" name="txtcontractno" value='<s:property value="txtcontractno"/>'/>
                                    
                                    <label>License Date</label>
                                    <div id="jqxContractDate" name="jqxContractDate" value='<s:property value="jqxContractDate"/>'></div>
                                    
                                    <label>Remarks</label>
                                    <input type="text" id="txtcontractremarks" name="txtcontractremarks" value='<s:property value="txtcontractremarks"/>'/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div> 

            <input type="hidden" id="hidjqxClientDate" name="hidjqxClientDate" value='<s:property value="hidjqxClientDate"/>'/>
            <input type="hidden" id="hidcmbsalutation" name="hidcmbsalutation" value='<s:property value="hidcmbsalutation"/>'/>
            <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency" value='<s:property value="hidcmbcurrency"/>'/>
            <input type="hidden" id="hidcmbcategory" name="hidcmbcategory" value='<s:property value="hidcmbcategory"/>'/>
            <input type="hidden" id="hidcmbsalesman" name="hidcmbsalesman" value='<s:property value="hidcmbsalesman"/>'/>
            <input type="hidden" id="hidcmbinvoicing_method" name="hidcmbinvoicing_method" value='<s:property value="hidcmbinvoicing_method"/>'/>
            <input type="hidden" id="hidcmbdel_charges" name="hidcmbdel_charges" value='<s:property value="hidcmbdel_charges"/>'/>
            <input type="hidden" id="hidcmbtax" name="hidcmbtax" value='<s:property value="hidcmbtax"/>'/>
            <input type="hidden" id="hidchcknontaxableentity" name="hidchcknontaxableentity" value='<s:property value="hidchcknontaxableentity"/>'/>
            <input type="hidden" id="hidchckadvance" name="hidchckadvance" value='<s:property value="hidchckadvance"/>'/>
            <input type="hidden" id="hidcmbgroup1" name="hidcmbgroup1" value='<s:property value="hidcmbgroup1"/>'/>
            <input type="hidden" id="hidchckdefault" name="hidchckdefault" value='<s:property value="hidchckdefault"/>'/>
            <input type="hidden" id="hidchksalikpercent" name="hidchksalikpercent" value='<s:property value="hidchksalikpercent"/>'/>
            <input type="hidden" id="hidchksalikauhpercent" name="hidchksalikauhpercent" value='<s:property value="hidchksalikauhpercent"/>'/>
            <input type="hidden" id="hidchksalikdxbpercent" name="hidchksalikdxbpercent" value='<s:property value="hidchksalikdxbpercent"/>'/>
            <input type="hidden" id="hidchktrafficpercent" name="hidchktrafficpercent" value='<s:property value="hidchktrafficpercent"/>'/>
            <input type="hidden" id="hidchkparkingpercent" name="hidchkparkingpercent" value='<s:property value="hidchkparkingpercent"/>'/>
            <input type="hidden" id="hidchckseparatesrvcdefault" name="hidchckseparatesrvcdefault" value='<s:property value="hidchckseparatesrvcdefault"/>'/>
            <input type="hidden" id="hidcmbnationality" name="hidcmbnationality" value='<s:property value="hidcmbnationality"/>'/>
            <input type="hidden" id="hiddateOfJoining" name="hiddateOfJoining" value='<s:property value="hiddateOfJoining"/>'/>
            <input type="hidden" id="hidjqxContractDate" name="hidjqxContractDate" value='<s:property value="hidjqxContractDate"/>'/>
            
            <input type="hidden" id="mode" name="mode"/>
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            <input type="hidden" id="idpdetailsallowed" name="idpdetailsallowed" value='<s:property value="idpdetailsallowed"/>'/>
            <input type="hidden" id="driverdetailsverifyallowed" name="driverdetailsverifyallowed" value='<s:property value="driverdetailsverifyallowed"/>'/>
            <input type="hidden" id="separateservicechargeallowed" name="separateservicechargeallowed" value='<s:property value="separateservicechargeallowed"/>'/>
            <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
            <input type="hidden" id="txtforcontractdiv" name="txtforcontractdiv"/>
            <input type="hidden" id="txtmobilevalidation" name="txtmobilevalidation" value='<s:property value="txtmobilevalidation"/>'/>
            <input type="hidden" id="txtcategoryvalidation" name="txtcategoryvalidation" value='<s:property value="txtcategoryvalidation"/>'/>
            <input type="hidden" id="txtcategorywiseedit" name="txtcategorywiseedit" value='<s:property value="txtcategorywiseedit"/>'/>
            <input type="hidden" id="gridlength" name="gridlength"/>
            <input type="hidden" id="referencelength" name="referencelength"/>
            <input type="hidden" id="referencelength1" name="referencelength1"/>
            <input type="hidden" id="attachlength" name="attachlength1"/>
            <input type="hidden" id="creditcardlength" name="creditcardlength"/>
            <input type="hidden" id="separateservicechargelength" name="separateservicechargelength"/>
            <input type="hidden" id="salesmaneditstatus" name="salesmaneditstatus"/>
            <input type="hidden" id="creditcardstatus" name="creditcardstatus"/>
            <input type="hidden" id="hidclientsrvchrges" name="hidclientsrvchrges" value='<s:property value="hidclientsrvchrges"/>'/>
        </div>
    </form>

    <div id="nationalityWindow"><div></div></div>
    <div id="stateWindow"><div></div></div>
</div>

</body>
</html>