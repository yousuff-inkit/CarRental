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
		  
		  let det = $('#formdetail').val()?.trim() || "";
		  let code = $('#formdetailcode').val()?.trim() || "";

		  document.getElementById("formdet").innerText = 
		      (det || code) ? `${det} (${code})` : "";

		  
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

/* ===================== GLOBAL PAGE LAYOUT ===================== */
body {
    background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
    font-family: "Segoe UI", sans-serif;
    padding: 32px 0;
    margin: 0;
}

/* ---- DO NOT MODIFY HEADER ---- */
#mainBG > div:first-child,
#mainBG > *:first-child,
header, .header, .pageTitle {
    all: unset !important;
    display: block !important;
}

/* ---- MAIN WRAPPER ---- */
#mainBG {
    background: #fff;
    max-width: 1450px;
    margin: auto;
    padding: 22px;
    border-radius: 16px;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

/* ===================== SCROLL AREA ===================== */
.hidden-scrollbar {
    overflow-y: auto;
    max-height: calc(100vh - 210px);
    padding-right: 10px;
}

.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb {
    background: #b9c3d6;
    border-radius: 6px;
}

/* ===================== INPUT + SELECTS ===================== */
label {
    font-size: 14px;
    font-weight: 600;
    color: #253858;
    white-space: nowrap;
}

input[type="text"], select, textarea {
    height: 30px !important;
    border: 1px solid #d1d5db !important;
    border-radius: 6px !important;
    padding: 4px 10px !important;
    font-size: 14px !important;
    background: white !important;
    width: 100%;
    box-sizing: border-box;
}

input:focus, select:focus {
    border-color: #6a8ed9 !important;
    box-shadow: 0 0 4px rgba(90,132,205,0.25);
    outline: none !important;
}

input::placeholder { opacity: .6; }

/* Fix dropdowns — MUST stay functional */
select {
    appearance: auto !important;
    -webkit-appearance: auto !important;
    -moz-appearance: auto !important;
}

/* ===================== FORM GRID ===================== */
.form-grid {
    display: grid;
    grid-template-columns: 130px 1fr;
    gap: 10px 18px;
    align-items: center;
}

.form-grid.dual {
    grid-template-columns: 130px 1fr 130px 1fr;
}

/* ===================== PANEL/SECTION BOXES ===================== */
.section-row {
    display: flex;
    gap: 22px;
    flex-wrap: wrap;
}

.section-block {
    flex: 1;
    min-width: 600px;
    background: #f6f8fa;
    border: 1px solid #e4e7ec;
    border-radius: 14px;
    padding: 20px;
    margin-top: 20px;
}

.section-block h2 {
    font-size: 15px;
    font-weight: 700;
    padding-left: 8px;
    margin: 0 0 12px 0;
    border-left: 4px solid #187bff;
}

/* ===================== BUTTONS ===================== */
button, .myButton {
    background: linear-gradient(180deg, #ffffffcc 0%, #dfe6f3cc 100%);
    border: 1px solid #cfd8e6;
    border-radius: 10px;
    padding: 8px 22px;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
    color: #2c3e50;
    transition: all .2s ease;
    box-shadow: 0 2px 4px rgba(0,0,0,0.09), inset 0 1px 1px rgba(255,255,255,0.6);
    pointer-events: auto !important;
}

button:hover, .myButton:hover {
    background: linear-gradient(180deg, #f7faff, #d9e4f5);
    transform: translateY(-1px);
}

button:active, .myButton:active {
    transform: scale(.97);
    background: #ccd7e6;
}

/* ===================== JQX FIX ===================== */
.jqx-datetimeinput,
div[id*="date"],
div[id*="time"] {
    height: 30px !important;
    border-radius: 6px !important;
}

/* ===== EMERGENCY FIX: ENABLE ALL INPUT INTERACTIVITY ===== */

button, 
.myButton,
input,
select,
textarea,
.jqx-widget,
.jqx-dropdownlist,
.jqx-input,
.jqx-datetimeinput {
    pointer-events: auto !important;
    z-index: 999 !important;
}

/* Fix invisible overlay blocking clicks */
* {
    user-select: auto !important;
}

/* Fix any accidental overlay container */
div[style*="z-index"],
.modal,
.overlay {
    pointer-events: auto !important;
}
/* ===== LOCK ORIGINAL HEADER ===== */

#mainBG > *:first-child,
header,
.header,
.pageTitle,
#header,
.appHeader {
    all: revert !important;
    pointer-events: auto !important;
}
.jqx-popup, 
.jqx-listbox,
.jqx-calendar,
.jqx-menu {
    visibility: visible !important;
    display: block !important;
    z-index: 999999 !important;
}
/* -------- Restore Page Title / Form Title -------- */
#formdet,
legend,
.page-title {
    display: block !important;
    visibility: visible !important;
    opacity: 1 !important;
    font-size: 20px !important;
    font-weight: 600 !important;
    color: #253858 !important;
    margin-bottom: 18px !important;
    text-align: left !important;
    padding-left: 6px;
    border-left: 4px solid #007bff;
}

/* Fix case where older JSP uses <label id="formdet"> inside header block */
label#formdet {
    width: auto !important;
    white-space: nowrap !important;
}



.HeadIcons {
    display: flex !important;
    align-items: center !important;
    font-size: 20px !important;
    font-weight: 600 !important;
    color: #253858 !important;
    margin-bottom: 18px !important;
}
/* ---- FIX HIDDEN PAGE TITLES ---- */
legend, 
#formdet, 
label#formdet {
    display: block !important;
    visibility: visible !important;
    opacity: 1 !important;
    font-size: 18px !important;
    font-weight: 600 !important;
    margin-top: 12px !important;
    margin-bottom: 12px !important;
    padding: 6px 12px !important;
    color: #253858 !important;
    border-left: 4px solid #3b82f6 !important;
    background: transparent !important;
    height: auto !important;
    line-height: normal !important;
}

/* Older layout sometimes places title inside table row */
fieldset legend {
    padding-left: 8px !important;
}

/* Prevent fieldsets from collapsing */
fieldset {
    padding-top: 8px !important;
}
/* ---- RESTORE FORM TITLE AT PAGE TOP ---- */
#formdet {
    display: inline-block !important;
    visibility: visible !important;
    opacity: 1 !important;
    font-size: 22px !important;
    font-weight: 700 !important;
    color: #1a2a4f !important;
    margin: 0 0 15px 10px !important;
    padding: 4px 10px !important;
    height: auto !important;
    line-height: normal !important;
}

/* Fix accidental collapse by container */
.HeadIcons {
    display: flex !important;
    align-items: center !important;
}

/* Ensure the container row isn't hidden */
div[id="mainBG"] label#formdet {
    display: inline-block !important;
}


/* ---- RESTORE PAGE TITLE (SAT DOWNLOAD, etc.) ---- */
#formdet {
    display: inline-block !important;
    visibility: visible !important;
    opacity: 1 !important;
    font-size: 20px !important;
    font-weight: 700 !important;
    color: #2c3e50 !important;
    padding: 4px 6px !important;
    margin-left: 10px !important;
    text-transform: uppercase;
}

/* ensure label container stays visible */
.HeadIcons {
    display: flex !important;
    align-items: center !important;
}




</style>

</head>
<body onload="setValues();">

<div id="mainBG">
<form id="frmnewSATdownload" action="newSATdownload" method="post" autocomplete="off">

<!-- 🔹 HEADER MUST REMAIN UNTOUCHED -->
<jsp:include page="../../header.jsp"></jsp:include>

<div class="hidden-scrollbar">

<!-- ========================================================= -->
<!-- ROW 1 (Two Column Layout: Salik | Traffic) -->
<!-- ========================================================= -->

<div class="section-row">

    <!-- ---------------- SALIK PANEL ---------------- -->
    <div class="section-block">
        <h2>Salik</h2>

        <div class="form-grid">

            <label>Category</label>
            <div><input type="radio" id="radio_salik" name="category" value="salik" onchange="fundisable();"> Site</div>

            <label>Site</label>
            <select id="cmbsaliksite" name="cmbsaliksite">
                <option value="DXB">DXB</option>
                <option value="AUH">AUH</option>
            </select>

            <label>Auto</label>
            <input type="checkbox" id="chck_salikautomatic" name="chck_salikautomatic" onchange="fundisable();">

            <!-- Time Period -->
            <label>Time Period</label>
            <select id="cmbtype" name="cmbtype" onchange="fundisable();">
                <option value="lhrs">Last 24 Hours</option>
                <option value="ldays">Last 7 Days</option>
                <option value="l30d">Last 30 Days</option>
                <option value="customdates">Custom Dates</option>
            </select>

            <!-- Date Range -->
            <label>Start Date</label>
            <div id="jqxStartDate"></div>

            <label>End Date</label>
            <div id="jqxEndDate"></div>

            <!-- Username -->
            <label>Username</label>
            <input type="text" id="txtusername" name="txtusername" readonly placeholder="Press F3 to Search" onkeydown="getUname(event);" />

            <!-- Fleet -->
            <label>Fleet No</label>
            <input type="text" id="txtsalikfleetno" name="txtsalikfleetno" readonly placeholder="Press F3 to Search" onkeydown="getvehinfo(event);" />

            <label>Reg No</label>
            <input type="text" id="txtxslregno" name="txtxslregno" readonly>

            <label>Fleet Name</label>
            <input type="text" id="txtsalfleetnme" name="txtsalfleetnme" readonly>

            <label>Plate Code</label>
            <input type="text" id="txtsalplcode" name="txtsalplcode" readonly>

            <label>Salik Tag</label>
            <input type="text" id="txtsaliktagno" name="txtsaliktagno" readonly onkeydown="getPlateNo(event);" />

            <label>Upload File</label>
            <div style="display:flex; gap:10px;">
                <input type="file" id="file" name="file" style="flex:1;">
                <button type="button" id="btnfileupload" class="myButton">Upload</button>
            </div>

            <!-- Advanced -->
            <label style="font-weight:bold; margin-top:12px;">Start Position</label>
            <input type="text" id="salikcounter" name="salikcounter" onkeypress="javascript:return isNumber (event,id)">

            <label>Month</label>
            <select id="cmbmonthname" name="cmbmonthname">
                <option value="">--Select--</option>
                <option>January</option><option>February</option><option>March</option><option>April</option>
                <option>May</option><option>June</option><option>July</option><option>August</option>
                <option>September</option><option>October</option><option>November</option><option>December</option>
            </select>

        </div>
    </div>


    <!-- --------------- TRAFFIC PANEL ---------------- -->
    <div class="section-block">
        <h2>Traffic</h2>

        <div class="form-grid">

            <label>Category</label>
            <div><input type="radio" id="radio_traffic" name="category" value="traffic" onchange="fundisable();"> Traffic</div>

            <label>Site</label>
            <select id="cmbtrafficsite" name="cmbtrafficsite" onchange="fundisable();">
                <option value="AUH">AUH</option>
                <option value="DXB">DXB</option>
            </select>

            <label>Automatic</label>
            <input type="checkbox" id="chck_trafficautomatic" name="chck_trafficautomatic" onchange="fundisable();">

            <label>Traffic File?</label>
            <input type="checkbox" id="chck_trafficfileno" onchange="fundisable();">

            <label>File No.</label>
            <input type="text" id="txttrafficplateno" placeholder="Press F3 to Search" readonly onkeydown="getFilename(event);">

            <label>Year</label>
            <select id="cmbyear" name="cmbyear"></select>

            <label>Black Points</label>
            <input type="checkbox" id="chkblackpoints" onchange="funBlackPoints();">

            <label>Plate Inquiry</label>
            <input type="checkbox" id="chck_trafficpdata" onchange="fundisable();">

            <label>Go To Page</label>
            <input type="text" id="gotopage">

            <label>Plate No.</label>
            <input type="text" id="txttrafficpno" onkeydown="getPlateNo(event);" placeholder="Press F3 to Search">

            <label>Plate Source</label>
            <input type="text" id="txttrafficpsource" readonly onkeydown="getSource(event);" placeholder="Press F3 to Search">

            <label>Plate Color</label>
            <input type="text" id="txttrafficpcolor" readonly onkeydown="getColor(event);" placeholder="Press F3 to Search">

            <label>Plate Type</label>
            <input type="text" id="txttrafficptype" readonly>

        </div>
    </div>
</div>



<!-- ========================================================= -->
<!-- PROGRESS + ACTIONS -->
<!-- ========================================================= -->

<div class="section-block" style="margin-top:22px;">
    <h2>Progress</h2>

    <div class="gw-container">
        <div class="gw-light-grey">
            <div id="gwProgressBar" class="gw-container gw-green" style="height:24px;width:0%;"></div>
        </div>
        <p id="gwprogresstext">Added <span id="itemcount"></span> of <span id="itemtotalcount"></span></p>
    </div>

    <div style="text-align:center; margin-top:18px; display:flex; justify-content:center; gap:18px;">
        <button class="myButton" type="button" id="btnGo" name="btnGo" onclick="getBrowser();">Download Now</button>
        <button class="myButton" type="button" id="btnclientside" onclick="funCheckClientSide();">Update Chrome Driver</button>
    </div>

    <div style="margin-top:22px; text-align:center;">
        <div id="loadcaptcha"><jsp:include page="captcha.jsp"></jsp:include></div>
    </div>

    <div style="margin-top:22px;">
        <div id="loadsalikdata"><jsp:include page="SATloadDetails.jsp"></jsp:include></div>
        <div id="loadtrafficdata"><jsp:include page="SATTrafficloadDetails.jsp"></jsp:include></div>
    </div>
</div>


<!-- ========================================================= -->
<!-- HIDDEN FIELDS — DO NOT TOUCH -->
<!-- ========================================================= -->



</div>
</form>
</div>


<script>
/* Reinitialize jqx controls after UI rebuild */
function refreshSATInputs(){
    const datePickers=["jqxStartDate","jqxEndDate"];
    datePickers.forEach(id=>{
        if($("#"+id).length){
            try{$("#"+id).jqxDateTimeInput('destroy');}catch(e){}
            $("#"+id).jqxDateTimeInput({
                width:"100%",height:30,formatString:"dd-MM-yyyy",theme:"fresh"
            });
        }
    });
}

$(document).ready(()=>{ setTimeout(refreshSATInputs,400); });
</script>
<script>
(function(){
    // Override messager alert globally
    const originalAlert = $.messager.alert;

    $.messager.alert = function(title, msg, type, callback) {

        // Normalize value
        msg = (msg || "").toString().trim();

        // Stop alerts with empty string, null or undefined text
        if (msg === "" || msg === "undefined" || msg === "null") {
            return;
        }

        originalAlert.call($.messager, title, msg, type, callback);
    };
})();
</script>

</body>
</html>
