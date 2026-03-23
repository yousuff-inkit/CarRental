<%@ taglib prefix="s" uri="/struts-tags"%>
<%@page import="java.util.logging.Logger" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
  <% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../includes.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/loading.css">
<script type="text/javascript" src="ajaxfileupload.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     	$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../icons/31load.gif'/></div>");
	 	
		funBlackPoints();
		 $("#btnClose").hide();$("#status").hide();$("#btnSave").hide();$("#btnCancel").hide();$("#btnApproval").hide();$("#btnCreate").hide();
		 $("#btnEdit").hide();$("#btnPrint").hide();$("#btnExcel").hide();$("#btnDelete").hide();$("#btnSearch").hide();$("#btnAttach").hide();  
		 $("#btnGuideLine").hide();$("#btnSendmail").hide();
		
		 $("#jqxStartDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd MMM yyyy"});
		 $("#jqxEndDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd MMM yyyy"});
		 
		 $('#unameWindow').jqxWindow({width: '30%', height: '40%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
	     $('#unameWindow').jqxWindow('close');
	     
	     $('#filenameWindow').jqxWindow({width: '30%', height: '40%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
	     $('#filenameWindow').jqxWindow('close');
	     
	     $('#sourceWindow').jqxWindow({width: '30%', height: '50%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
	     $('#sourceWindow').jqxWindow('close');
	     
	     $('#colorWindow').jqxWindow({width: '30%', height: '50%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
	     $('#colorWindow').jqxWindow('close');
	     
	     $('#platenoWindow').jqxWindow({width: '30%', height: '50%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
	     $('#platenoWindow').jqxWindow('close');
	     
	     $('#fleetWindow').jqxWindow({width: '41%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
	     $('#fleetWindow').jqxWindow('close');
	     
	     $('#vehinfowindow').jqxWindow({ width: '60%', height: '67%',  maxHeight: '70%' ,maxWidth: '70%' , title: ' Fleet Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
	     $('#vehinfowindow').jqxWindow('close');
		 
	     $('#loadcaptcha').hide();$('#loadsalikdata').hide();$('#loadtrafficdata').hide();
		 
		 
		 $('#txtusername').dblclick(function(){
			 var site=$('#cmbsaliksite').val();
			 unameSearchContent('satUsernameSearch.jsp?site='+site);
		 });
		 
		 $('#txttrafficplateno').dblclick(function(){
			 var site=document.getElementById("cmbtrafficsite").value;
       	     filenameSearchContent('satfilenameSearch.jsp?site='+site);
		 });
		 
		 $('#txttrafficpsource').dblclick(function(){
			 var site=document.getElementById("cmbtrafficsite").value;
       	  	 filesourceSearchContent('satSourceSearch.jsp?site='+site);
		 });
		 
		 $('#txttrafficpcolor').dblclick(function(){
			 var site=document.getElementById("cmbtrafficsite").value;
       	     var source=document.getElementById("txttrafficpsource").value;
       	     filecolorSearchContent('satColorSearch.jsp?source='+source+'&site='+site);
		 });
		 
		 $('#txtsaliktagno').dblclick(function(){
			 plateNoSearchContent('satPlateNoSearch.jsp');
		 });
		 
		 $('#txtsalikfleetno').dblclick(function(){
			  vehinfoSearchContent('vehinfo.jsp');
		 });
		 
		var currentdate=new Date();
		var yearhtml='<option value="">--Select--</option>';
		for(var i=parseInt(currentdate.getFullYear());i>=parseInt(currentdate.getFullYear())-10;i--){
			yearhtml+='<option value="'+i+'">'+i+'</option>';
		}
		$('#cmbyear').html($.parseHTML(yearhtml));
		
		$('#btnfileupload').click(function(e){
			if(document.getElementById("file").files.length > 0 ){
				$("#overlay, #PleaseWait").show();
	        	$.get('getExcelDoc.jsp',function(data){
	        		data=JSON.parse(data);
	        		var docno=data.exceldocno;
		        	var attachdesc='Excel attachment of SAT#'+docno;
					$.ajaxFileUpload({
	          			url:'appAttachAction.action?formCode=SAT&doc_no='+docno+'&descpt='+attachdesc+'&reftypid=1',
	        			secureuri:false,//false  
	        			fileElementId:'file',//id  <input type="file" id="file" name="file" />  
	        			dataType: 'json',// json  
	        			success: function (data, status){  
	           				if(status=='success'){
	           					
			            		//$.messager.alert('Message','Upload Successfull');
			            		moveProgressBar();
	           					$.post('readExcel.jsp',{exceldocno:docno},function(salikdata,status){
	           						salikdata=JSON.parse(salikdata);
	           						$("#loadsalikdata").load("SATloadDetails.jsp?xdocs="+salikdata.salikdocno);
	           				        $('#loadsalikdata').show();	           						
	           				     	$("#overlay, #PleaseWait").hide();
	           				     	getFinalCount();
	           					});
	              			}
	              			else if(typeof(data.error) != 'undefined'){
	              				$("#overlay, #PleaseWait").hide();
	                  			if(data.error != ''){
	                  				$.messager.alert('Warning',data.error);
	                  			}
	                  			else{
	                  				$("#overlay, #PleaseWait").hide();
	                  				$.messager.alert('Warning',data.message);
	                  			}  
	              			}  
	          			},  
	          			error: function (data, status, e){
	          				$("#overlay, #PleaseWait").hide(); 
	          				$.messager.alert('Warning',e);
	          			}  
	      			}); 	
	        	});
	        	 
  			}
		});
	});
	
	function unameSearchContent(url) {
	    $('#unameWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#unameWindow').jqxWindow('setContent', data);
		$('#unameWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function filenameSearchContent(url) {
	 	$('#filenameWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#filenameWindow').jqxWindow('setContent', data);
		$('#filenameWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function filesourceSearchContent(url) {
	    $('#sourceWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#sourceWindow').jqxWindow('setContent', data);
		$('#sourceWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function filecolorSearchContent(url) {
	    $('#colorWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#colorWindow').jqxWindow('setContent', data);
		$('#colorWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function plateNoSearchContent(url) {
	    $('#platenoWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#platenoWindow').jqxWindow('setContent', data);
		$('#platenoWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function fleetSearchContent(url) {
	    $('#fleetWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#fleetWindow').jqxWindow('setContent', data);
		$('#fleetWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function vehinfoSearchContent(url) {
		$('#vehinfowindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#vehinfowindow').jqxWindow('setContent', data);
		$('#vehinfowindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function getCaptcha() {
		//setTimeout(function() {location.reload();},5000);
		var x=new XMLHttpRequest();
		var uname=document.getElementById("txtusername").value;
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
		            items= x.responseText;
			        var path=items.trim()+"/captcha.png";
		        	
			        isfileexist(path);
		     }
			else
				{
				}
		}
		x.open("GET",'getCaptcha.jsp',true);
		x.send();
 	}
	
	function getRemoveOldCaptchaImgOnLoad() {
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
		            items= x.responseText;
                    var path=items.trim()+"/captcha.png";
		        	
			        isfileexist(path);
		     }
			else
				{
				}
		}
		x.open("GET",'getRemoveOldCaptchaImgOnLoad.jsp',true);
		x.send();
 	}
	
	function fundisable(){
		
		  if (document.getElementById('radio_salik').checked) {
			 getRemoveOldCaptchaImgOnLoad();
			 $("table#traffic input").prop("disabled", true);
			 $("table#traffic select").prop("disabled", true);
			 $('#radio_traffic').attr('disabled', false);
			 $("#chck_salikautomatic").attr("disabled", false);
			 $('#chck_salikautomatic').attr('checked', true);
			 $('#chck_trafficautomatic').attr('checked', false);
			 $("table#salik input").prop("disabled", false);
			 $("table#salik select").prop("disabled", false);
			 $('#jqxStartDate').jqxDateTimeInput({ disabled: true});
			 $('#jqxEndDate').jqxDateTimeInput({ disabled: true}); 
			 document.getElementById("chck_trafficautomatic").checked = false;
			 document.getElementById("chck_trafficfileno").checked = false;
			 
			  if(document.getElementById('chck_salikautomatic').checked) {
				  
				 $("#txtusername").attr("disabled", true);
				 $("table#salik input").prop("disabled", true);
				 $("#cmbsaliksite").attr("disabled", false);
				 $("#chck_salikautomatic").attr("disabled", false);
				 $('#jqxStartDate').jqxDateTimeInput({ disabled: true});
				 $('#jqxEndDate').jqxDateTimeInput({ disabled: true});
			     //$("#txtusername").attr("disabled", false);
				 $("#radio_salik").attr("disabled", false);
				 
			 }
			  
			  if ($("#cmbtype").val() == "customdates") {
				  
				  $('#jqxStartDate').jqxDateTimeInput({ disabled: false});
				  $('#jqxEndDate').jqxDateTimeInput({ disabled: false}); 
			  }
			  
			  /* else{
				  $("#txtsaliktagno").attr("disabled", false);
				  $("#txtsalikfleetno").attr("disabled", true);
			  } */
			  /* if((document.getElementById('cmbtype').value=='lcdays')) {
				  //document.getElementById("errormsg").innerHTML="Sorry,This option is not availble right now";
				  $('#jqxStartDate').jqxDateTimeInput({ disabled: false});
					 $('#jqxEndDate').jqxDateTimeInput({ disabled: false});
					 $("#txtsaliktagno").attr("disabled", true);
					 $("#txtsalikfleetno").attr("disabled", false);
				 }
			   else{
				  document.getElementById("errormsg").innerHTML="";
			  } */ 
			  $('#loadsalikdata').show();
			  $('#loadtrafficdata').hide();
			  
			}
		 else if (document.getElementById('radio_traffic').checked) {
			 getRemoveOldCaptchaImgOnLoad();
			 $("table#salik input").prop("disabled", true);
			 $("table#salik select").prop("disabled", true);
			 $("#chck_salikautomatic").attr("checked", false);
			 $('#chck_trafficautomatic').attr('checked', true);
			 $('#radio_salik').attr('disabled', false);
			 $("table#traffic input").prop("disabled", false);
			 $("table#traffic select").prop("disabled", false);
			 $('#jqxStartDate').jqxDateTimeInput({ disabled: true});
			 $('#jqxEndDate').jqxDateTimeInput({ disabled: true}); 
			 
			  if ((document.getElementById('chck_trafficautomatic').checked)) {
				 $("table#traffic input").prop("disabled", true);
				 $("table#traffic select").prop("disabled", true);
				 $("#cmbtrafficsite").attr("disabled", false);
				 $("#chck_trafficautomatic").attr("disabled", false);
				 $("#radio_traffic").attr("disabled", false);
				 
			 }
			  
			 if (!(document.getElementById('chck_trafficautomatic').checked)) {
				 document.getElementById("chck_trafficfileno").checked = true;
				 $("#txttrafficpsource").attr("disabled", true);
				 $("#txttrafficpcolor").attr("disabled", true);
				 $("#txttrafficptype").attr("disabled", true);
				 $("#txttrafficpno").attr("disabled", true);
			 }
			 
			 if ((document.getElementById('chck_trafficfileno').checked)) {
				 $('#txttrafficplateno').attr('disabled', false); 
			 }

			 if ((document.getElementById('chck_trafficpdata').checked)) {
				 $("#txttrafficpsource").attr("disabled", false);
				 $("#txttrafficpcolor").attr("disabled", false);
				 $("#txttrafficptype").attr("disabled", false);
				 $("#txttrafficpno").attr("disabled", false);
			 }
			 
			  $('#loadsalikdata').hide();
			  $('#loadtrafficdata').show();
			 
			}
		 }
	
	 function funReadOnly(){
		 fundisable();
	 }
	 
	 function funRemoveReadOnly(){}
	 
	 function funSearchLoad(){}
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
//	    	$('#jqxCashPaymentDate').jqxDateTimeInput('focus'); 	    		
	    }
	   
	  function funNotify(){	
	    		return 1;
		} 
	  
	  
	function setValues(){
		if($('#browserstatus').val()=='1'){
			$.messager.alert('Warning','Please make sure Chrome Browser and Chrome driver are same version');
			var browsermsg=$('#browsermsg').val();
			var htmldata='<tr class="browser-tr"><td>'+browsermsg+',Please Visit <a target="_blank" href="https://sites.google.com/chromium.org/driver/home">sites.google.com/chromium.org/driver/home</a></td></tr>';
			//$('#btnuploadchrome').closest('tr').append($.parseHTML(htmldata));
			$(htmldata).insertAfter($('#btnuploadchrome').closest('tr'));
		}
		  if($('#hiddencategory').val()=='salik'){
				
				if($('#hidcmbsaliksite').val()){
		   			$("#cmbsaliksite").val($('#hidcmbsaliksite').val());
		   		}
				
				if($('#hidcmbtype').val()){
		   			$("#cmbtype").val($('#hidcmbtype').val());
		   		}
				
				if($('#hidjqxStartDate').val()){
					 $("#jqxStartDate").jqxDateTimeInput('val', $('#hidjqxStartDate').val());
				  }
				
				if($('#hidjqxEndDate').val()){
					 $("#jqxEndDate").jqxDateTimeInput('val', $('#hidjqxEndDate').val());
				  }
				
				/* if($('#hidcmbtype').val()=='lcdays'){
					
					 $('#jqxStartDate').jqxDateTimeInput({ disabled: false});
					 $('#jqxEndDate').jqxDateTimeInput({ disabled: false});
					 $("#txtsaliktagno").attr("disabled", true);
					 $("#txtsalikfleetno").attr("disabled", false);
					
				} */
			
			/* 	 $('#jqxStartDate').jqxDateTimeInput({ disabled: true});
				 $('#jqxEndDate').jqxDateTimeInput({ disabled: true});
				 $("#txtsaliktagno").attr("disabled", false); */
				 
				 
				 if ((document.getElementById('chck_trafficautomatic').checked)) {
					 //$("#txtsaliktagno").attr("disabled", true);
				 }
				
				 $("table#traffic input").prop("disabled", true);
				 $("table#traffic select").prop("disabled", true);
				document.getElementById("radio_salik").checked = true;
				$('#loadtrafficdata').hide();
				
				var indexVal =document.getElementById("docs").value;
				$("#loadsalikdata").load("SATloadDetails.jsp?xdocs="+indexVal);
		        $('#loadsalikdata').show();
		        // getFinalCount();
		  }
		  
			
			if($('#hiddencategory').val()=='traffic'){
				
				if($('#hidcmbtrafficsite').val()){
		   			$("#cmbtrafficsite").val($('#hidcmbtrafficsite').val());
		   		}
			
				$("table#salik input").prop("disabled", true);
				 $("table#salik select").prop("disabled", true);
				 /* $('#jqxStartDate').jqxDateTimeInput({ disabled: true});
				 $('#jqxEndDate').jqxDateTimeInput({ disabled: true}); */
				document.getElementById("radio_traffic").checked = true;
				$('#loadsalikdata').hide();
				var indexVal =document.getElementById("docs").value;
				var plateno =document.getElementById("txttrafficplateno").value;
				var txttrafficpno=document.getElementById("txttrafficpno").value;
				if(plateno!=""){
					document.getElementById("chck_trafficfileno").checked = true;
					
				}
				if(txttrafficpno!=""){
					document.getElementById("chck_trafficpdata").checked = true;
					
				}
				//alert("indexVal"+indexVal);
				 $("#loadtrafficdata").load("SATTrafficloadDetails.jsp?trxdocs="+indexVal);
				 $('#loadtrafficdata').show();
				 // getFinalCount();
			}
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
		  
		  if(document.getElementById("itemcount").innerHTML==""){
				document.getElementById("itemcount").innerHTML="0";
				document.getElementById("itemtotalcount").innerHTML="0";
				document.getElementById("itemtype").innerHTML="Saliks";
				document.getElementById("gwProgressBar").style.width="0%";

		  }
		}
	  
	 
	  
	  function getUname(event){
          var x= event.keyCode;
          if(x==114){
        	  var site=$('#cmbsaliksite').val();
 			 unameSearchContent('satUsernameSearch.jsp?site='+site);
          }
          else{
           }
          }
	  
	  function getFilename(event){
          var x= event.keyCode;
          if(x==114){
        	  var site=document.getElementById("cmbtrafficsite").value;
        	  filenameSearchContent('satfilenameSearch.jsp?site='+site);
          }
          else{
           }
          }
	  
	  function getSource(event){
          var x= event.keyCode;
          if(x==114){
        	  var site=document.getElementById("cmbtrafficsite").value;
        	  filesourceSearchContent('satSourceSearch.jsp?site='+site);
          }
          else{
           }
          }
	  
	  function getColor(event){
          var x= event.keyCode;
          if(x==114){
        	  var site=document.getElementById("cmbtrafficsite").value;
        	  var source=document.getElementById("txttrafficpsource").value;
        	  filecolorSearchContent('satColorSearch.jsp?source='+source+'&site='+site);
          }
          else{
           }
          }
	  
	  function getPlateNo(event){
          var x= event.keyCode;
          if(x==114){
        	  plateNoSearchContent('satPlateNoSearch.jsp');
          }
          else{
           }
          }
	  
	  function getFleet(event){
          var x= event.keyCode;
          if(x==114){
        	  fleetSearchContent('satFleetSearch.jsp');
          }
          else{
           }
          }
	  
	  function getvehinfo(event){
          var x= event.keyCode;
          if(x==114){
        	  vehinfoSearchContent('vehinfo.jsp');
          }
          else{
           }
          }
	  
	  	window.setInterval(function(){
		    funDivload();
		    }, 5000000);

		function funDivload(){
			var txtcaptcha=document.getElementById("txtcaptcha").value;
			if(txtcaptcha==""){
		
				getCaptcha();
			}
			if(!(txtcaptcha=="")){
				document.getElementById("errormsg").innerHTML="Download under Progress...Please wait...";
			}
		}
	  
		function iscaptcha(){
			
			//document.getElementById("iscaptcha").value=1;
			var iscaptcha=document.getElementById("iscaptcha").value;
			if(iscaptcha==1){
				document.getElementById("errormsg").innerHTML="Please Wait...Loading Captcha...";
				getCaptcha();
				//captchaload();
			}
			else{
				return false;
			}
		}

		function isfileexist(fileURL){
		 	var host = window.location.origin;
		  	//alert("==fileURL===="+fileURL);
		   	var splt = fileURL.split("webapps"); 
		   	//alert("after split"+splt[1]);
		   	var repl = splt[1].replace( /\\/g, "/");
		   	fileURL=host+repl; 
		   
		   $.ajax({
			   
			   url: fileURL, //or your url
			   success: function(data){
				  
			     captchaload();
			   },
			   error: function(data){
			     
			   },
			 })
		   
		}


		function captchaload(){
			$('#loadcaptcha').show();
			$("#loadcaptcha").load("captcha.jsp");
			document.getElementById("errormsg").innerHTML="Please fill the captcha with in 60 seconds";
		}

		function getBrowser(){
			
			 if (document.getElementById('radio_salik').checked) {
				
					if(!(document.getElementById('chck_salikautomatic').checked)) {
								
								if($('#txtusername').val()==''){
									document.getElementById("errormsg").innerHTML="Please select a User Name to continue!!";
									return 0;
									
								}
								
								
							}
							
					/* if((document.getElementById('cmbtype').value=='lcdays')) {
						  document.getElementById("errormsg").innerHTML="Sorry,This option is not availble right now";
						  return false;
					} */
					const today=new Date();
					if($('#cmbtype').val()=='lhrs'){
						//24 hrs
						
						var enddate=new Date(today);
						var startdate=new Date(today);
						startdate=new Date(startdate.setDate(enddate.getDate()-1));
						var formattedStartDate = $.jqx.dataFormat.formatdate(startdate, 'dd/MM/yyyy');
						var formattedEndDate = $.jqx.dataFormat.formatdate(enddate, 'dd/MM/yyyy');
						$('#hidjqxStartDate').val(formattedStartDate);
						$('#hidjqxEndDate').val(formattedEndDate);
					}
					else if($('#cmbtype').val()=='ldays'){
						var enddate=new Date(today);
						var startdate=new Date(today);
						startdate=new Date(startdate.setDate(enddate.getDate()-7));
						var formattedStartDate = $.jqx.dataFormat.formatdate(startdate, 'dd/MM/yyyy');
						var formattedEndDate = $.jqx.dataFormat.formatdate(enddate, 'dd/MM/yyyy');
						$('#hidjqxStartDate').val(formattedStartDate);
						$('#hidjqxEndDate').val(formattedEndDate);
					}
					else if($('#cmbtype').val()=='l30d'){
						var enddate=new Date(today);
						var startdate=new Date(today);
						startdate=new Date(startdate.setDate(enddate.getDate()-30));
						var formattedStartDate = $.jqx.dataFormat.formatdate(startdate, 'dd/MM/yyyy');
						var formattedEndDate = $.jqx.dataFormat.formatdate(enddate, 'dd/MM/yyyy');
						$('#hidjqxStartDate').val(formattedStartDate);
						$('#hidjqxEndDate').val(formattedEndDate);
					}
					else{
						var startdate = $("#jqxStartDate").jqxDateTimeInput('getDate');
						var formattedStartDate = $.jqx.dataFormat.formatdate(startdate, 'dd/MM/yyyy');
						$('#hidjqxStartDate').val(formattedStartDate);
						var enddate = $("#jqxEndDate").jqxDateTimeInput('getDate');
						var formattedEndDate = $.jqx.dataFormat.formatdate(enddate, 'dd/MM/yyyy');
						$('#hidjqxEndDate').val(formattedEndDate);
					}
					
					  
					  
					  
							document.getElementById("frmnewSATdownload").submit();
							document.getElementById("errormsg").innerHTML="Download under Progress...Please wait...";
							setTimeout(function() {iscaptcha();$("#btnGo").attr("disabled", true);},500000);
							moveProgressBar();
		    }
			
			if (document.getElementById('radio_traffic').checked) {
				
				if(!(document.getElementById('chck_trafficautomatic').checked)) {
					if($('#txttrafficplateno').val()==''){
						document.getElementById("errormsg").innerHTML="Please select a Traffic File No";
						return false;
					}
				}
				
				document.getElementById("frmnewSATdownload").submit();
				document.getElementById("errormsg").innerHTML="Download under Progress...Please wait...";
				setTimeout(function() {iscaptcha();$("#btnGo").attr("disabled", true);},500000);
				moveProgressBar();
		   }
			
		}
		
		
		function getFinalCount(){
			var itemtype="";
			if(document.getElementById("radio_salik").checked==true){
				itemtype="Salik";
			}
			else if(document.getElementById("radio_traffic").checked==true){
				itemtype="Traffic";
			}
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
				{
					
	            	var items= x.responseText;
	            	items=JSON.parse(items);
	            	var elm=document.getElementById("gwProgressBar");
	            	var width=(parseInt(items.itemcount)/parseInt(items.totalitemcount))*100;
					width=width.toFixed(2);
					
					elm.style.width=100+'%';
					document.getElementById("gwprogresstext").className="gw-text-green gw-animate-opacity";
					document.getElementById("gwprogresstext").innerHTML="Successfully Downloaded "+items.itemcount+" "+itemtype+"s!";
	     		}
				else
				{
				}
			}
			x.open("GET",'getItemCount.jsp?itemtype='+itemtype+'&finalcount=1',true);
			x.send();
		
		}
		function isNumber(evt,id) {
			//Function to restrict characters and enter number only
			var iKeyCode = (evt.which) ? evt.which : evt.keyCode
			if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
			{
				$.messager.alert('Warning','Enter Numbers Only');
			    $("#"+id+"").focus();
			    return false;
			}
			return true;
		}
		
		function moveProgressBar(){
			var elm=document.getElementById("gwProgressBar");
			var width=0;
			//var interval=setInterval(frame,50);
			var interval=setInterval(function() {frame();},2000);
			function frame(){
				var itemtype="";
				if(document.getElementById("radio_salik").checked==true){
					itemtype="Salik";
				}
				else if(document.getElementById("radio_traffic").checked==true){
					itemtype="Traffic";
				}
				var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
					if (x.readyState==4 && x.status==200)
					{
						
		            	var items= x.responseText;
		            	items=JSON.parse(items);
			    		//console.log(items);
			    		if(width>=100){
							clearInterval(interval);
							document.getElementById("gwprogresstext").className="gw-text-green gw-animate-opacity";
							document.getElementById("gwprogresstext").innerHTML="Successfully downloaded "+totalitemcount+" "+itemtype+"s!";
						}
						else{
							
							var width=(parseInt(items.itemcount)/parseInt(items.totalitemcount))*100;
							width=width.toFixed(2);
							elm.style.width=width+'%';
							document.getElementById("itemcount").innerHTML=items.itemcount;
							document.getElementById("itemtotalcount").innerHTML=items.totalitemcount;
							document.getElementById("itemtype").innerHTML=itemtype;
						}
		     		}
					else
					{
					}
				}
				x.open("GET",'getItemCount.jsp?itemtype='+itemtype,true);
				x.send();
				
			}
		}
		
		function funBlackPoints(){
			if(document.getElementById("chkblackpoints").checked==true){
				document.getElementById("hidchkblackpoints").value=1;
			}
			else{
				document.getElementById("hidchkblackpoints").value=0;
			}
		}
		
		function funCheckClientSide(){
			$("#overlay, #PleaseWait").show();
			var userAgent = navigator.userAgent;
		    var chromeVersion = userAgent.match(/Chrome\/([0-9.]+)/)[1];
			$.post('clientSideScraping.jsp',{'chromeversion':chromeVersion},function(data,status){
				data=JSON.parse(data);
				$("#overlay, #PleaseWait").hide();
				if(data.errorstatus=="0"){
					$.messager.alert('Message','Chrome Driver Updated');
				}
				else{
					$.messager.alert('Message','Not Updated');
					return false;
				}
			});
		}
</script>

<style>
    
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

   
    .receipt-header {
        display: block;
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

    .form-group.triple-input {
        grid-template-columns: 120px 1fr 120px 1fr 120px 1fr;
    }

    .form-group.single-label-dual-input {
        grid-template-columns: 120px 1fr 1fr;
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

    .section-block h2, .section-block legend {
        font-size: 1.1rem;
        font-weight: 600;
        margin: 0 0 20px;
        padding-left: 10px;
        border-left: 4px solid #007bff;
        color: #333;
        display: block;
    }

    .section-block legend {
        border: none;
        padding-left: 0;
    }
    
    .nested-fieldset {
        padding: 15px;
        border: 1px solid #ddd;
        border-radius: 8px;
        margin-bottom: 15px;
        background: #fff;
    }
    
    .nested-fieldset legend {
        font-size: 1rem;
        font-weight: 600;
        color: #333;
        padding: 0 5px;
        margin-bottom: 10px;
    }


    
    input[type="text"], select, textarea {
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

    input[type="text"]:focus, select:focus, textarea:focus {
        border-color: #007bff;
        outline: none;
    }

    input[readonly], textarea[readonly] {
        background-color: #f3f4f6;
        color: #6b7280;
    }

    label {
    font: Tahoma;
        font-weight: 600;
        color: #253858;
        white-space: nowrap;
        text-align: right;
        padding-right: 10px;
        font-size: 16px;
    }
    
    .section-block .form-group label {
        min-width: 110px; /* Custom width for main sections */
    }

   
    .myButton {
        background: #007bff; border: none; padding: 6px 16px; color: #fff;
        border-radius: 6px; cursor: pointer; font-weight: 600;
    }
    .myButton:hover { background: #0056b3; }

    /* SCROLLBAR FIX */
    .hidden-scrollbar { overflow: auto; height: 600px; }
    .hidden-scrollbar::-webkit-scrollbar { width: 0px; }
    
    .button-group {
        display: flex;
        gap: 15px;
        justify-content: center;
        margin-top: 20px;
    }
    
    /* Progress bar styles */
    .gw-container {
        padding: 10px 16px;
    }
    .gw-light-grey {
        background-color: #e4e6eb; /* Light gray for progress bar track */
        border-radius: 6px;
    }
    .gw-green {
        color: #fff;
        background-color: #007bff; /* Use theme blue for progress */
        height: 24px;
        border-radius: 6px;
        text-align: center;
        line-height: 24px;
        transition: width 0.5s ease-in-out;
    }
    #gwprogresstext {
        text-align: center;
        margin-top: 10px;
        font-weight: 500;
    }
    
    .radio-label {
        display: flex;
        align-items: center;
        gap: 5px;
        font-weight: 500;
    }
    .radio-group {
        display: flex;
        align-items: center;
        gap: 20px;
    }

</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmnewSATdownload" action="newSATdownload" method="post" autocomplete="off">
<jsp:include page="../../header.jsp"></jsp:include>

<div class='hidden-scrollbar'>
<div class="section-row">

    <div class="section-block">
<h2>Salik</h2>

        <div class="form-group dual-input">
            <label></label>
            <div class="radio-group">
                <label class="radio-label">
                    <input type="radio" id="radio_salik" name="category" value="salik" onchange="fundisable();">Site
                </label>
                <input type="hidden" id="hiddencategory" name="hiddencategory" value='<s:property value="hiddencategory"/>'>
            </div>
            
            <label>Site</label>
            <div class="radio-group">
                <select id="cmbsaliksite" name="cmbsaliksite" style="width:70%;" value='<s:property value="cmbsaliksite"/>'>
                    <option value="DXB">DXB</option>
                    <option value="AUH">AUH</option>
                </select>
                <input type="hidden" id="hidcmbsaliksite" name="hidcmbsaliksite" value='<s:property value="hidcmbsaliksite"/>'/>
                <label class="radio-label" style="width: auto;">
                    <input type="checkbox" id="chck_salikautomatic" name="chck_salikautomatic" value="salikautomatic" onchange="fundisable();">Automatic
                </label>
            </div>
        </div>

        <div class="nested-fieldset">
            <h2>Time Period Selection</h2>
            <div class="form-group dual-input">
                <label>Time-Period</label>
                <select id="cmbtype" name="cmbtype" value='<s:property value="cmbtype"/>' onchange="fundisable();">
                    <option value="lhrs">Last 24 Hours</option>
                    <option value="ldays">Last 7 Days</option>
                    <option value="l30d">Last 30 Days</option>
                    <option value="customdates">Custom Dates</option>
                </select>
                <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/>
                
                <label>Start Date</label>
                <div>
                    <div id="jqxStartDate" name="jqxStartDate" value='<s:property value="jqxStartDate"/>'></div>
                    <input type="hidden" id="hidjqxStartDate" name="hidjqxStartDate" value='<s:property value="hidjqxStartDate"/>'/>
                </div>
            </div>

            <div class="form-group dual-input">
                <label>End Date</label>
                <div>
                    <div id="jqxEndDate" name="jqxEndDate" value='<s:property value="jqxEndDate"/>'></div>
                    <input type="hidden" id="hidjqxEndDate" name="hidjqxEndDate" value='<s:property value="hidjqxEndDate"/>'/>
                </div>
                
                <label>Username</label>
                <input type="text" id="txtusername" name="txtusername" value='<s:property value="txtusername"/>' onkeydown="getUname(event);" readonly placeholder="Press F3 to Search" />
            </div>
        </div>
        
        <div class="form-group dual-input">
            <label>Fleet No.</label>
            <input type="text" id="txtsalikfleetno" name="txtsalikfleetno" value='<s:property value="txtsalikfleetno"/>' onkeydown="getvehinfo(event);" readonly placeholder="Press F3 to Search" />
            
            <label>Reg No.</label>
            <input type="text" id="txtxslregno" name="txtxslregno" readonly value='<s:property value="txtxslregno"/>'/>
        </div>

        <div class="form-group dual-input">
            <label>Fleet Name</label>
            <input type="text" id="txtsalfleetnme" name="txtsalfleetnme" readonly value='<s:property value="txtsalfleetnme"/>'/>
            
            <label>Plate Code</label>
            <input type="text" id="txtsalplcode" name="txtsalplcode" readonly value='<s:property value="txtsalplcode"/>'/>
        </div>

        <div class="form-group dual-input">
            <label>Salik Tag</label>
            <input type="text" id="txtsaliktagno" name="txtsaliktagno" readonly onkeydown="getPlateNo(event);" value='<s:property value="txtsaliktagno"/>'/>
            
            <label>File Upload</label>
            <div class="radio-group" style="justify-content: space-between;">
                <input type="file" name="file" id="file" style="width: 150px;">
                <button type="button" id="btnfileupload" name="btnfileupload" class="myButton" style="width: auto;">Upload</button>
            </div>
        </div>
        
        <div class="nested-fieldset">
            <h2>Advanced Options</h2>
            <div class="form-group dual-input">
                <label>Start Position</label>
                <input type="text" name="salikcounter" id="salikcounter" value='<s:property value="salikcounter"/>' onKeyPress="javascript:return isNumber (event,id)">
                
                <label>Month</label>
                <div>
                    <select id="cmbmonthname" name="cmbmonthname">
                        <option value="">--Select--</option>
                        <option value="January">January</option><option value="February">February</option><option value="March">March</option>
                        <option value="April">April</option><option value="May">May</option><option value="June">June</option>
                        <option value="July">July</option><option value="August">August</option><option value="September">September</option>
                        <option value="October">October</option><option value="November">November</option><option value="December">December</option>
                    </select>
                    <input type="hidden" name="hidcmbmonthname" id="hidcmbmonthname">
                </div>
            </div>
        </div>
    </div>

    <div class="section-block">
        <h2>Traffic</h2>

        <div class="form-group dual-input">
            <label></label>
            <div class="radio-group">
                <label class="radio-label">
                    <input type="radio" id="radio_traffic" name="category" value="traffic" onchange="fundisable();">Traffic
                </label>
            </div>
            
            <label>Site</label>
            <div class="radio-group">
                <select id="cmbtrafficsite" name="cmbtrafficsite" style="width:50%;" onchange="fundisable();" value='<s:property value="cmbtrafficsite"/>' >
                    <option value="AUH">AUH</option><option value="DXB">DXB</option>
                </select>
                <input type="hidden" id="hidcmbtrafficsite" name="hidcmbtrafficsite" value='<s:property value="hidcmbtrafficsite"/>'/>
                <label class="radio-label" style="width: auto;">
                    <input type="checkbox" id="chck_trafficautomatic" name="chck_trafficautomatic" value="trafficautomatic" onchange="fundisable();">Automatic
                </label>
            </div>
        </div>

        <div class="nested-fieldset">
            <div class="form-group dual-input">
                <label class="radio-label">
                    <input type="checkbox" id="chck_trafficfileno" name="chck_trafficfileno" value="trafficfileno" onchange="fundisable();">&nbsp;Traffic File No.
                </label>
                <label>Traffic File No.</label>
                <input type="text" id="txttrafficplateno" name="txttrafficplateno" placeholder="Press F3 to Search" onkeydown="getFilename(event);" readonly value='<s:property value="txttrafficplateno"/>'/>
            </div>
            
            <div class="form-group">
                <label>Year</label>
                <select name="cmbyear" id="cmbyear">
                    <option value="">--Select--</option>
                </select>
            </div>
        </div>
        
        <div class="form-group triple-input" style="grid-template-columns: 120px auto 120px 1fr;">
            <label></label>
            <div class="radio-group">
                <label class="radio-label">
                    <input type="checkbox" name="chkblackpoints" id="chkblackpoints" onchange="funBlackPoints();">Black Points
                </label>
                <input type="hidden" name="hidchkblackpoints" id="hidchkblackpoints" value='<s:property value="hidchkblackpoints"/>'>
                <label class="radio-label">
                    <input type="checkbox" id="chck_trafficpdata" name="chck_trafficpdata" value="trafficpdata" onchange="fundisable();">Inquiry by plate data
                </label>
            </div>
            
            <label>Go To Page</label>
            <input type="text" id="gotopage" name="gotopage" value='<s:property value="gotopage"/>' />
        </div>
        
        <div class="nested-fieldset">
            <h2>Plate Details</h2>
            <div class="form-group dual-input">
                <label>Plate No.</label>
                <input type="text" id="txttrafficpno" name="txttrafficpno" placeholder="Press F3 to Search" onkeydown="getPlateNo(event);" value='<s:property value="txttrafficpno"/>'/>
                
                <label>Plate Source</label>
                <input type="text" id="txttrafficpsource" name="txttrafficpsource" placeholder="Press F3 to Search" onkeydown="getSource(event);" readonly value='<s:property value="txttrafficpsource"/>'/>
            </div>
            
            <div class="form-group dual-input">
                <label>Plate Color</label>
                <input type="text" id="txttrafficpcolor" name="txttrafficpcolor" placeholder="Press F3 to Search" onkeydown="getColor(event);" readonly value='<s:property value="txttrafficpcolor"/>'/>
                
                <label>Plate Type</label>
                <input type="text" id="txttrafficptype" name="txttrafficptype" readonly value='<s:property value="txttrafficptype"/>'/>
            </div>
        </div>
    </div>
</div>


<div class="full-width-block" style="margin-top: 20px;">
    <div class="gw-container">
        <div class="gw-light-grey">
            <div id="gwProgressBar" class="gw-container gw-green" style="height:24px;width:0%;"></div>
        </div>
        <p id="gwprogresstext">Added <span id="itemcount" name="itemcount"><s:property value="itemcount"/></span> of <span id="itemtotalcount" name="itemtotalcount"><s:property value="itemtotalcount"/></span> <span id="itemtype" name="itemtotalcount"><s:property value="itemtype"/></span></p>
    </div>

    <div class="button-group">
        <button class="myButton" type="button" id="btnGo" name="btnGo" onClick="getBrowser();" >Download Now !!!</button>
        <button class="myButton" type="button" id="btnclientside" name="btnclientside" onclick="funCheckClientSide();">Update Chrome Driver</button>
    </div>
    
    <div style="text-align: center; margin-top: 20px;">
        <div id="loadcaptcha"><jsp:include page="captcha.jsp"></jsp:include></div>
    </div>

    <div style="text-align: center; margin-top: 20px;">
        <div id="loadsalikdata"><jsp:include page="SATloadDetails.jsp"></jsp:include></div>
        <div id="loadtrafficdata"><jsp:include page="SATTrafficloadDetails.jsp"></jsp:include></div>
    </div>
</div>


<input type="hidden" id="docs" name="docs" value='<s:property value="docs"/>'/>
<input type="hidden" id="captcha" name="captcha" value='<s:property value="captcha"/>'/>
<input type="hidden" id="captchacount" name="captchacount" value='<s:property value="captchacount"/>'/>
<input type="hidden" id="iscaptcha" name="iscaptcha" value='<s:property value="iscaptcha"/>'/>
<input type="hidden" id="iscaptchaloaded" name="iscaptchaloaded" value='<s:property value="iscaptchaloaded"/>'/>
<input type="hidden" id="captchapath" name="captchapath" value='<s:property value="captchapath"/>'/>
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
<input type="hidden" id="txtsalikregno" name="txtsalikregno" value='<s:property value="txtsalikregno"/>'/>
<input type="hidden" id="txttrafficpsourceid" name="txttrafficpsourceid" value='<s:property value="txttrafficpsourceid"/>'/>
<input type="hidden" id="txttrafficpcolorid" name="txttrafficpcolorid" value='<s:property value="txttrafficpcolorid"/>'/>
<input type="hidden" id="txttrafficptypeid" name="txttrafficptypeid" value='<s:property value="txttrafficptypeid"/>'/>
<input type="hidden" id="browserstatus" name="browserstatus" value='<s:property value="browserstatus"/>'/>
<input type="hidden" id="browsermsg" name="browsermsg" value='<s:property value="browsermsg"/>'/>

</div>
</form>

<div id="flash"></div>
<div id="display"></div>
<div id="unameWindow">
 <div></div><div></div>
</div>

<div id="filenameWindow">
 <div></div><div></div>
</div>

<div id="sourceWindow">
 <div></div><div></div>
</div>

<div id="colorWindow">
	<div></div><div></div>
</div>

<div id="fleetWindow">
  <div></div><div></div>
</div>

<div id="vehinfowindow">
 <div></div><div></div>
</div>

<div id="platenoWindow">
	<div></div><div></div>
</div>

<div class="modal"></div>

</div>
</body>
</html>