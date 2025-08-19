<% String contextPath=request.getContextPath();%>   
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html lang="en">
<head>
<title>WhatsApp Template</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="../../../../vendors/bootstrap-v3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../../../../vendors/bootstrap-v3/css/bootstrap.min.css">
<link rel="stylesheet" href="../../../../vendors/animate/animate.min.css">
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>

<link href="../../../../vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="../../../../vendors/select2/select2.min.css" rel="stylesheet" />
<link href="../../../../vendors/select2/select2.min.js" rel="stylesheet" />
  <style type="text/css">
     
    .custompanel{
      border:1px solid #ccc;
      float: left;
      display: inline-block;
      margin-top: 10px; 
      margin-right: 10px;
      padding-right: 10px;
      padding-left: 10px;
      padding-top: 10px;
      padding-bottom: 10px;
      border-radius: 8px;
    }
    .custompanel2{
      float: left;
      display: inline-block;
      /* margin-top: 10px; 
      padding-top: 10px;
      padding-bottom: 10px; */  
      border-radius: 8px;  
    }
    .badge-notify{
	   position:absolute;right:-5px;top:-8px;z-index:2;background-color:red;
	} 
	.comment{
      background-image: linear-gradient(120deg, #a1c4fd 0%, #c2e9fb 100%);
      color: #000;
      clear:both;
      float: right;
      display: block;
      padding-top: 8px;
      padding-bottom: 2px;
      padding-left: 10px;
      padding-right: 5px;
      border-radius: 12px;
      border-top-right-radius: 0;
      margin-bottom: 8px;
      transition:all 0.5s ease-in;
    }
    .msg-details{
      text-align: right;
    }
    .comments-container{
      height: 400px;
      overflow-y: auto;
      margin-bottom: 8px;
      padding-right: 5px;
    }
    .comments-outer-container{
      width: 100%;
      height: 100%;
    }
    .msg{
    	word-break:break-all;
    }
    .rowgap{
    	margin-bottom:6px;
    }
    .textpanel{
      color: blue;
    } 
    .load-wrapp {
	    float: left;
	    width: 100px;
	    height: 100px;
	    margin: 0 10px 10px 0;
	    padding: 20px 20px 20px;
	    border-radius: 5px;
	    text-align: center;
	    background-color: #fff;
	    position:absolute;
	    z-index:9999;
	    top:50%;
	    left:50%;
	    transform:translate(-50%,-50%);
	    border:1px solid #000;
	}
	.datepanel{
      float: left;
      display: inline-block;
      margin-top: 10px; 
      margin-bottom: 10px;
      padding-right: 10px;
      padding-left: 10px;
    }
	.spinner {
	    position: relative;
	    width: 45px;
	    height: 45px;
	    margin: 0 auto;
	}
	
	.bubble-1,
	.bubble-2 {
	    position: absolute;
	    top: 0;
	    width: 25px;
	    height: 25px;
	    border-radius: 100%;
	    
	    background-color: #000;
	}
	
	.bubble-2 {
	    top: auto;
	    bottom: 0;
	}
	.load-9 .spinner {border:none;animation: loadingI 2s linear infinite;}
	.load-9 .bubble-1, .load-9 .bubble-2 {animation: bounce 2s ease-in-out infinite;}
	.load-9 .bubble-2 {animation-delay: -1.0s;}
	@keyframes loadingI {
	    100% {transform: rotate(360deg);}
	}
	
	@keyframes bounce  {
	  0%, 100% {transform: scale(0.0);}
	  50% {transform: scale(1.0);}
	}
	

    height: 80%;
}

.modal-body {
    /* 100% = dialog height, 120px = header + footer */
    max-height: calc(100% - 120px);
    overflow-y: scroll;
}		 */
  .padtop{
        padding-top: 5px; 
    }
    body{
    overflow:hidden;
    }
    .modal-header{
        padding-bottom:0px;    
    }
    #headermedia, #headermedia:before, #headermedia:after {
	 -webkit-box-sizing: border-box;
	 -moz-box-sizing: border-box;
	 box-sizing: border-box;
}
  </style>
  
  <head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

<script type="text/javascript">

$(document).ready(function () {
	getLang()
	$("#buttonstab").hide()
	//$("#mediaid").hide()
	$('#btnsubmit').click(function(){  
		$('.load-wrapp').show();
		 funload();
	});
	$('#btnexcel').click(function(){  
		$("#detDiv").excelexportjs({
			containerid: "detDiv", 
			datatype: 'json', 
			dataset: null, 
			gridId: "jqxDetailGrid", 
			columns: getColumns("jqxDetailGrid") ,   
			worksheetName:"WhatsApp Template"
			});
	});
	$('#btntemplate').click(function(){
		funclear();
		$("#modalemplate").modal('toggle'); 
	});
	$('#btntemplatesave').click(function(){  
		funTemplate() 
	});
	$('#btnreload').click(function(){ 
		$('.load-wrapp').show();
		checkStatus();
	});
	$('#btndelete').click(function(){  
		funDelete()
	});
});

function funload(){
	 $('.load-wrapp').show();
	 $('#detDiv').load('detailGrid.jsp?id=1');  
}	

function funTemplate(){
	var path = document.getElementById("fileexcelimport").value;
	var name = $("#templatename").val()  
	if(name=="" || name==null){
		$.messager.alert('Warning','Please enter template name!');
		return false;
	}
	
	if (!isValidTemplate(name)) {
		 $.messager.alert('Warning', 'Template name is not valid. It should contain only small letters and underscores.');
		 document.getElementById("templatename").focus();
		 return false;
	}  
	  
	var bodytext = $("#bodytext").val()  
	if(bodytext=="" || bodytext==null){
		$.messager.alert('Warning','Please enter body content!');
		return false;
	}
	$.messager.confirm('Message', 'Do you want to create template?', function(r){
		if(r==false){
			return false; 
		}else{
			$('.load-wrapp').show();
			if(path!=null && path!="" && typeof(path)!="undefined"){
				var fsize = $('#fileexcelimport')[0].files[0].size;
				var extn = path.substring(path.lastIndexOf(".") + 1, path.length);  
				funCheckFormat(extn, fsize);
			}else{
				createTemplate(0);
			}
		}
	});	
}

function createTemplate(attachDoc){  
	 var name = $("#templatename").val() 
	 var bodytext = $("#bodytext").val()
	 var headertext = $("#headertext").val()
	 var footertext = $("#footertext").val()
	 var qrbtext = $("#quickreplybtntext").val()
	 var cabtext = $("#calltoactionbtntext").val()
	 var caburl = $("#calltoactionbtnurl").val()
	 var path = document.getElementById("fileexcelimport").value;
	 var lang = $('#cmblang').val();
	 var extn = "", fsize="";
	 if(path!=null && path!="" && typeof(path)!="undefined"){
	     extn = path.substring(path.lastIndexOf(".") + 1, path.length);
	     fsize = $('#fileexcelimport')[0].files[0].size;
	 }
	 var dtype="WAT";  
	 console.log("IN CREATE TEMPLATE"+fsize)
	 var x=new XMLHttpRequest();
	 x.onreadystatechange=function(){
		 if (x.readyState==4 && x.status==200){
		    var items=x.responseText;
		    $('.load-wrapp').hide();
		    if(parseInt(items)>0){
		      $.messager.alert('Message', ' Successfully Created ');
		      $("#modalemplate").modal('toggle');
		      funclear();
		      funload(); 
		    }else{
			  $.messager.alert('Message', ' Not Created ');  
			}
		} 
	}  
	x.open("GET","createTemplate.jsp?name="+encodeURIComponent(name)+"&headertext="+encodeURIComponent(headertext)+"&footertext="+encodeURIComponent(footertext)+"&bodytext="+encodeURIComponent(bodytext)+"&qrbtext="+encodeURIComponent(qrbtext)+"&cabtext="+encodeURIComponent(cabtext)+"&caburl="+encodeURIComponent(caburl)+"&attachdoc="+attachDoc+"&extn="+extn+"&dtype="+dtype+"&fsize="+fsize+"&lang="+lang,true);    
	x.send();        
}

function isValidTemplate(inputValue) {
	  var pattern = /^[a-z_0-9]+$/;
	  return pattern.test(inputValue);
}

function funChangeName(){
	var name = $("#templatename").val()  
	if(!isValidTemplate(name) && name!='') {   
		 $.messager.alert('Warning', 'Template name is not valid. It should contain only small letters and underscores.');
		 $("#templatename").val('')
	}else{
		checkTemplate();
	}
}

function checkTemplate(){ 
	 var name = $("#templatename").val() 
	 var bodytext = $("#bodytext").val()
	 var footertext = $("#footertext").val()
	 var x=new XMLHttpRequest();
	 x.onreadystatechange=function(){
		 if (x.readyState==4 && x.status==200){
		    var items=x.responseText.trim();
		    if(parseInt(items)==1){
			      $.messager.alert('Message', ' Template name already exists!!! ');
			      $("#templatename").val('')
		    }else if(parseInt(items)==2){
			      $.messager.alert('Message', ' Body text of template already exists in another template!!!');
			      $("#bodytext").val('')
			}else if(parseInt(items)==3){
			      $.messager.alert('Message', ' Footer text of template already exists in another template!!! ');
			      $("#footertext").val('')
			}else{
			}
		} 
	}  
	x.open("GET","checkTemplate.jsp?name="+encodeURIComponent(name)+"&body="+encodeURIComponent(bodytext)+"&footer="+encodeURIComponent(footertext),true);      
	x.send();        
}

function funclear(){
	$("#templatename").val('') 
	$("#bodytext").val('')
	$("#headertext").val('')
	$("#footertext").val('')
	$("#quickreplybtntext").val('')
	$("#calltoactionbtntext").val('')
	$("#calltoactionbtnurl").val('')
	$("#fileexcelimport").val(null)
}

function checkStatus(){   
	 var x=new XMLHttpRequest();
	 x.onreadystatechange=function(){
		 if (x.readyState==4 && x.status==200){
		    var items=x.responseText.trim();
		    funload(); 
		} 
	}  
	x.open("GET","checkStatus.jsp",true);      
	x.send();        
}

function getAttachDocumentNo(){
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
			var items=x.responseText.trim();
			if(items>0){
				ajaxFileUpload(items);
			}
	  }
	}
x.open("GET","getAttachDocumentNo.jsp?mode=WAT",true);      
x.send();
}

function ajaxFileUpload(docNo) {    
    if (window.File && window.FileReader && window.FileList && window.Blob)
    {
    }else{
    	 $.messager.show({title:'Message',msg:'Please upgrade your browser, because your current browser lacks some new features we need!',showType:'show',
                 style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
             }); 
        return;
    }

console.log("IN AJAX 1");    
$.ajaxFileUpload  
(  
 {  
    url:'fileAttachAction.action?formCode=WAT&doc_no='+docNo+'&descpt=Whatsapp File Upload - Template' ,  
    secureuri:false,  
    fileElementId:'fileexcelimport',    
    dataType: 'json', 
    success: function (data, status)   
    {  
       
       if(status=='success'){
    	   console.log("IN AJAX 2");
    	   createTemplate(docNo)
        }
       
        if(typeof(data.error) != 'undefined')  
        {  
            if(data.error != '')  
            {  
                $.messager.show({title:'Message',msg: data.error,showType:'show',
                      style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                  }); 
            }else  
            {  
                $.messager.show({title:'Message',msg: data.message,showType:'show',
                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
              	          }); 
            }  
        }  
    },  
    error: function (data, status, e){  
        $.messager.alert('Message',e);
    }  
});  
return false;  
}

function funCheckFormat(extn, fsize){
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
			var items=x.responseText.trim().split('####');
			if(parseInt(items[0])>0){
				var mediasize = items[2];
				var mediasizeinbyte = items[1];	  
				if(parseInt(fsize) > parseInt(mediasizeinbyte)) {
					  $('.load-wrapp').hide();
					$.messager.alert('Warning',fsize +' bytes too big ! Maximum Size '+mediasize);  
					return false;
		        }else{
		        	getAttachDocumentNo();
		        }
			}else{
				$('.load-wrapp').hide();
				$.messager.alert('Warning','File of '+extn+' Format is not Supported!');  
				return false; 
			}
	  }
	}
	x.open("GET","checkFileFormat.jsp?extn="+extn,true);        
	x.send();
}

function funDelete(){
	var template = $("#templatename").val()  
	if(template == "" || template == null){
		$.messager.alert('Warning','Please select a document!');
		return false;
	}
	$.messager.confirm('Message', 'Do you want to delete template?', function(r){
		if(r==false){
			return false; 
		}else{
			$('.load-wrapp').show();
				deleteTemplate(template); 
		}
	});	
}

function deleteTemplate(name){  
	 var x=new XMLHttpRequest();
	 x.onreadystatechange=function(){
		 if (x.readyState==4 && x.status==200){
		    var items=x.responseText;
		    if(parseInt(items)>0){
		      $('.load-wrapp').hide();
		      $.messager.alert('Message', ' Successfully Deleted ');
		      funload(); 
		    }else{
			  $.messager.alert('Message', ' Not Deleted ');  
			}
		} 
	}  
	x.open("GET","deleteTemplate.jsp?name="+encodeURIComponent(name),true);    
	x.send();        
}

function getLang() {      
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items = items.split('####');
			var Items = items[0].split(",");
			var IdItems = items[1].split(",");
			var options = '<option value="">--Select--</option>'; 
			for (var i = 0; i < Items.length; i++) {
				options += '<option value="' + IdItems[i] + '">'     
						+ Items[i] + '</option>';
			}
			$('#cmblang').html($.parseHTML(options));  
		} else {
		}
	}
	x.open("GET", "getLang.jsp", true);  
	x.send();
}
</script>
<body>
<div class="load-wrapp">
    	<div class="load-9">
        	<div class="spinner">
            	<div class="bubble-1"></div>
                <div class="bubble-2"></div>
            </div>
        </div>
    </div>
<div class="container-fluid">  
	    <div class="row rowgap">
	      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
		   <div class="primarypanel custompanel">
	  			<button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
	          	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
	           	<button type="button" class="btn btn-default" id="btntemplate" data-toggle="tooltip" title="Create Template" data-placement="bottom"><i class="fa fa-book" aria-hidden="true"></i></button>
	           	<button type="button" class="btn btn-default" id="btnreload" data-toggle="tooltip" title="Reload Templates" data-placement="bottom"><i class="fa fa-spinner" aria-hidden="true"></i></button>
	            <button type="button" class="btn btn-default" id="btndelete" data-toggle="tooltip" title="Delete Template" data-placement="bottom"><i class="fa fa-trash" aria-hidden="true"></i></button>
	       </div>
		 </div>  
	     </div>
	      <div class="row">
		      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
		        <div id="detDiv"><jsp:include page="detailGrid.jsp"></jsp:include></div>
		      </div>
	    </div>
	<div id="modalemplate" class="modal fade" role="dialog">
    	<div class="modal-dialog modal-lg">
        	<div class="modal-content">  
          		<div class="modal-header">   
		        	 <div class="row">  
  					     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">        
		        				<div class="form-group">
		        					<h4 class="modal-title">Create Template<span></span></h4>     
	                     	    </div>  
		                   </div> 
		                  <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">      
		        				<div class="form-group">
		        					<label for="template">Template Name:</label> 
		        					<input type="text" id="templatename" name="templatename" class="form-control" style="height:20px;" onchange="funChangeName();"/>              
	                     	    </div>  
		                   </div>
		                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">      
		        				<div class="form-group">
		        					<label for="language">Language:</label> 
		        					<select id="cmblang" name="cmblang" style="width:70%;">  
	  						        <option value="">--Select--</option></select>              
	                     	    </div>  
		                   </div>
		             </div> 
          		</div>
          		<div class="modal-body">  
  					<div class="row">  
  					     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">      
		        				<div class="form-group">
		        					<label for="header">Header(Optional)</label>      
	                     	    </div>  
		                   </div> 
		                  <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">      
		        				<div class="form-group">
		        					<label for="headertext">Text:</label>      
		        					<textarea id="headertext" name="headertext" col="4" class="form-control"></textarea>          
	                     	    </div>  
		                   </div>
		                  <div class="col-xs-12 col-sm-6 col-md-4 col-lg-5" id="mediaid">  
		        			   <div class="form-group">
		        					<label for="headermedia">Media:</label>      
		        					<input type="file" id="fileexcelimport" name="file">            
	                     	    </div>  
		                   </div>   
		             </div>
		             <div class="row">  
		                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">     
	  					     <div class="form-group">
							    <label for="body">Body</label>   
							  </div>
						 </div> 
		                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-9"> 
	  					     <div class="form-group">
							    <label for="bodytext">Text:</label>   
							    <textarea id="bodytext" name="bodytext" col="5" class="form-control" onchange="funChangeName();"></textarea>        
							  </div>
						 </div>    
		             </div>  
		             <div class="row">  
		                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">     
	  					     <div class="form-group">
							    <label for="footer">Footer(Optional)</label>     
							  </div>
						 </div> 
		                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-9"> 
	  					     <div class="form-group">
							    <label for="footertext">Text:</label>   
							    <textarea id="footertext" name="footertext" col="5" class="form-control" onchange="funChangeName();"></textarea>        
							  </div>
						 </div>    
		             </div> 
		             <div class="row" id="buttonstab">  
		                 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">     
	  					     <div class="form-group">
							    <label for="buttons">Buttons(Optional)</label>     
							  </div>
						 </div>   
		                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">    
	  					     <div class="form-group">
							    <label for="quickbutton">Quick Reply</label>   
							    <input id="quickreplybtntext" name="quickreplybtntext" class="form-control" placeholder="Button Text"  style="height:20px;"/>       
							  </div>
						 </div> 
						 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-5">      
							 <div class="row">
								  <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">    
			  					     <div class="form-group">
									    <label for="calltoactionbutton">Call To Action</label>      
									    <input id="calltoactionbtntext" name="calltoactionbtntext" class="form-control" placeholder="Button Text" style="height:20px;"/>       
									  </div>
								  </div> 
								  <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">    
			  					     <div class="form-group">
									    <label for="calltoactionbutton">&nbsp;</label>          
									    <input id="calltoactionbtnurl" name="calltoactionbtnurl" class="form-control" placeholder="Site URL" style="height:20px;"/>          
									  </div>
								  </div>
							 </div>   
						 </div>
		             </div>    
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>      
          			<button type="button" class="btn btn-default btn-primary" id="btntemplatesave">Create Template</button>         
            		
          		</div>
        </div>
      </div>
    </div> 
	<input type="hidden" name="divname" id="divname"> 
	<input type="hidden" id="hidsrno" name="hidsrno">
	<input type="hidden" id="hidbrhid" name="hidbrhid">
	<input type="hidden" id="reftype" name="reftype">
	<input type="hidden" id="templatename" name="templatename">
</div>
</body>