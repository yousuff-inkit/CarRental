<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script> 
<style type="text/css">
.textbox {
    border: 0;
    height: 25px;
    width: 20%;
    border-radius: 5px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -moz-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-box-shadow: 1px 1px 0 0 #E0ECF8, 5px 5px 40px 2px #E0ECF8 inset;
    -webkit-background-clip: padding-box;
    outline: 0;
}
 .rowheight{
     /* height: 26px; */   
}
.waButton {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #E0ECF8), color-stop(1, #81BEF7));
	background:-moz-linear-gradient(top, #E0ECF8 5%, #81BEF7 100%);
	background:-webkit-linear-gradient(top, #E0ECF8 5%, #81BEF7 100%);
	background:-o-linear-gradient(top, #E0ECF8 5%, #81BEF7 100%);
	background:-ms-linear-gradient(top, #E0ECF8 5%, #81BEF7 100%);
	background:linear-gradient(to bottom, #E0ECF8 5%, #81BEF7 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#E0ECF8', endColorstr='#81BEF7',GradientType=0);
	background-color: #E0ECF8;
	-moz-border-radius:4px;
	-webkit-border-radius:4px;
	border-radius:4px;
	display:inline-block;
	cursor:pointer;
	font-size:8pt;
	
	padding:3px 22px;
	text-decoration:none;
}
.waButton:active {
	position:relative;
	top:1px;
}
.waButton:hover {
  transform: scale(1.05) rotate(-1deg);
}

#fileexcelimport { 
	visibility: hidden; 
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     $('#groupwindow').jqxWindow({ width: '30%', height: '50%',  maxHeight: '70%' ,maxWidth: '70%' , title: 'Group Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
		 $('#groupwindow').jqxWindow('close');
		   
	     $('#group').dblclick(function(){
			   $('#groupwindow').jqxWindow('open');
			   groupSearchContent('groupsearch.jsp', $('#groupwindow'));    
		 });
	     getTemplates()
	     
	     $('#btnChoosefile').click(function(){
	    	    $('#fileexcelimport').click();
	    	});
	});

	function getgroupinfo(event){
		 var x= event.keyCode;
		if(x==114){
	 		$('#groupwindow').jqxWindow('open');
	 		groupSearchContent('groupsearch.jsp', $('#groupwindow'));    }
		else{}
	} 

	function groupSearchContent(url) {
		 	$.get(url).done(function (data) {
			$('#groupwindow').jqxWindow('open');
			$('#groupwindow').jqxWindow('setContent', data);
	}); 
	}
	
	function funExportBtn(){
		$("#detDiv").excelexportjs({
			containerid: "detDiv", 
			datatype: 'json', 
			dataset: null, 
			gridId: "jqxDetailGrid", 
			columns: getColumns("jqxDetailGrid") ,   
			worksheetName:"WhatsApp Messaging"
			});
	} 
	
	function funreload(event){
			 $("#overlay, #PleaseWait").show(); 
			 var group = $("#group").val();
			 $("#detDiv").load("detailGrid.jsp?group="+encodeURIComponent(group)+"&id=1");     
	}
	
	function funUpdate(type){    
        $('#jqxDetailGrid').jqxGrid('clearfilters');    
		var rows = $("#jqxDetailGrid").jqxGrid('getrows');

		var selectedrows=$("#jqxDetailGrid").jqxGrid('selectedrowindexes');
		selectedrows = selectedrows.sort(function(a,b){return a - b});

		if(selectedrows.length==0){
			$("#overlay, #PleaseWait").hide();
			$.messager.alert('Warning','Please select documents!');
			return false;
		}
		
		var group = document.getElementById("jqxGroupSearch").value;  
		if(group=="" && type=="ADD"){
			$.messager.alert('Warning','Please select a group!');
			return false;
		}
		$.messager.confirm('Message', 'Do you want to save changes?', function(r){
			if(r==false){
				return false; 
			}else{
				$("#overlay, #PleaseWait").show();
		
				var i=0;var temptrno="";
				var j=0, k=0;
				for (i = 0; i < selectedrows.length; i++) {
					if(i==0){
						var srvdetmtrno = $('#jqxDetailGrid').jqxGrid('getcellvalue', selectedrows[i], "cldocno");
						temptrno=srvdetmtrno;
					}
					else{
						var srvdetmtrno = $('#jqxDetailGrid').jqxGrid('getcellvalue', selectedrows[i], "cldocno");
						temptrno=temptrno+","+srvdetmtrno;  
					}
					var stop = $('#jqxDetailGrid').jqxGrid('getcellvalue', selectedrows[i], "status");
					if(parseInt(stop) == 1){
						k = 1;
					}
					temptrno1=temptrno+",";
					j++; 
				}
				$('#cldocnos').val(temptrno1);
				saveData($('#cldocnos').val(),group,type);	
			}   
		});
	}   
	
	function saveData(cldocnos,group,type){
		 var x=new XMLHttpRequest();
		 x.onreadystatechange=function(){
			 if (x.readyState==4 && x.status==200){
			    var items=x.responseText;
			    if(parseInt(items)>=1){
			      $.messager.alert('Message', ' Successfully Saved ');
			      $("#jqxDetailGrid").jqxGrid('clear');
			      $('#cldocnos').val("");   
			      document.getElementById("jqxGroupSearch").value="";   
			      funreload(event); 
			    }else{
				  $.messager.alert('Message', ' Not Saved ');  
				}
			} 
		}  
		x.open("GET","saveData.jsp?cldocnos="+encodeURIComponent(cldocnos)+"&group="+encodeURIComponent(group)+"&type="+type,true);    
		x.send();        
	}
	
	function funSendMessage(attachdoc){    
        $('#jqxDetailGrid').jqxGrid('clearfilters');    
		var rows = $("#jqxDetailGrid").jqxGrid('getrows');

		var selectedrows=$("#jqxDetailGrid").jqxGrid('selectedrowindexes');
		selectedrows = selectedrows.sort(function(a,b){return a - b});

		if(selectedrows.length==0){
			$.messager.alert('Warning','Please select documents!');
			return false;
		}
		var msg = $("#txtmessage").val();
		msg = msg.replace(/\n/g, " ");
		var extn="";   
		if(attachdoc!="" && attachdoc!="0" && attachdoc!=null){
			var path=document.getElementById("fileexcelimport").value;
			extn = path.substring(path.lastIndexOf(".") + 1, path.length);
		}
		$.messager.confirm('Message', 'Do you want to send whatsapp message?', function(r){
			if(r==false){
				return false; 
			}else{
				$("#overlay, #PleaseWait").show();
		
				var i=0;var temptrno="";
				var j=0, k=0;
				for (i = 0; i < selectedrows.length; i++) {
					var chk = $('#jqxDetailGrid').jqxGrid('getcellvalue', selectedrows[i], "status");
					if(i==0){
						var srvdetmtrno= $('#jqxDetailGrid').jqxGrid('getcellvalue', selectedrows[i], "cldocno");
						temptrno=srvdetmtrno;
					}
					else{
						var srvdetmtrno= $('#jqxDetailGrid').jqxGrid('getcellvalue', selectedrows[i], "cldocno");
						temptrno=temptrno+","+srvdetmtrno;  
					}
					if(parseInt(chk)==1){        
						k = 1;            
					}
					temptrno1=temptrno+",";
					j++; 
				}
				
				if(k == 1){
					$("#overlay, #PleaseWait").hide();  
					$.messager.alert('Warning', ' You cannot send messages to clients who opted out of receiving messages. ');
					return false;
				}
				
				$('#cldocnos').val(temptrno1);
				if(attachdoc!="" && attachdoc!="0" && attachdoc!=null){
					ajaxFileUpload($('#cldocnos').val(),msg,attachdoc,extn);
				}else{
					sendMessage($('#cldocnos').val(),msg,attachdoc,extn);
				}
			}   
		});
	}   
	 
	function sendMessage(cldocnos,msg,attachdoc,extn){
		 var x=new XMLHttpRequest();
		 x.onreadystatechange=function(){
			 if (x.readyState==4 && x.status==200){
			    var items=x.responseText.split('####');
			    $("#overlay, #PleaseWait").hide();
			    if(parseInt(items[0].trim())>0){
			      $.messager.alert('Message', ' Successfully Sent ');
			      funClear();  
			      funreload(event);   
			    }else{
				  $.messager.alert('Message', items[1].trim());  
				}
			} 
		}  
		x.open("GET","saveMessage.jsp?cldocnos="+encodeURIComponent(cldocnos)+"&msg="+encodeURIComponent(msg)+"&attachdoc="+attachdoc+"&extn="+extn,true);  
		x.send();        
	}
	
	function whatsappMessage(){  
		var path = document.getElementById("fileexcelimport").value;
		var msg = $("#txtmessage").val();
		if((msg=="" || msg==null|| typeof(msg)=="undefined") && (path==null || path=="" || typeof(path)=="undefined")){
			$.messager.alert('Warning','Please enter a message or select a file to send!');  
			return false;
		}
		if(path!=null && path!="" && typeof(path)!="undefined"){
			var fsize = $('#fileexcelimport')[0].files[0].size;
			var extn = path.substring(path.lastIndexOf(".") + 1, path.length);  
			console.log("extn---"+extn);
			$("#msgtype").val("NORMAL");
			funCheckFormat(extn, fsize);
		}else{
			funSendMessage(0);     
		}
	}
	
	function funCheckFormat(extn, fsize){
		var msgtype = $("#msgtype").val();  
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split('####');
				if(parseInt(items[0])>0){
					var mediasize = items[2];
					var mediasizeinbyte = items[1];	  
					if(parseInt(fsize) > parseInt(mediasizeinbyte)) {  
						$.messager.alert('Warning',fsize +' bytes too big ! Maximum Size '+mediasize);  
						return false;
			        }else{
			        	getAttachDocumentNo();
			        }
				}else{
					$.messager.alert('Warning','File of '+extn+' Format is not Supported!');  
					return false; 
				}
		  }
		}
		x.open("GET","checkFileFormat.jsp?extn="+extn+"&msgtype="+msgtype,true);           
		x.send();
	}
	
	function getAttachDocumentNo(){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				if(items>0){
					var path=document.getElementById("fileexcelimport").value;
					var fsize = $('#fileexcelimport')[0].files[0].size;
					var extn = path.substring(path.lastIndexOf(".") + 1, path.length);
					//ajaxFileUpload(items);
					var msgtype = $("#msgtype").val();
					if(msgtype=="TEMPLATE"){
						whatsappWelcome(items);
					}else{
						funSendMessage(items);  
					}
				}
				
		  }
		}
			
	x.open("GET","getAttachDocumentNo.jsp?mode=WAM",true);      
	x.send();
	}
	
function ajaxFileUpload(cldocnos, msg, docNo, extn) {    
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
        url:'fileAttachAction.action?formCode=WAM&doc_no='+docNo+'&descpt=Whatsapp File Upload' ,  
        secureuri:false,  
        fileElementId:'fileexcelimport',    
        dataType: 'json', 
        success: function (data, status)   
        {  
           
           if(status=='success'){
        	   console.log("IN AJAX 2");
        	   //funSendMessage(docNo);
        	   var msgtype = $("#msgtype").val();  
        	   if(msgtype=="TEMPLATE"){
        		   sendTemplate(cldocnos, msg, docNo, extn);      
        	   }else{
        		   sendMessage(cldocnos,msg,docNo,extn);
        	   }
//                $.messager.show({title:'Message',msg:'Successfully Uploaded',showType:'show',
//                   style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
             // }); 
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

function funClear(){
	$("#txtmessage").val('');
	$("#group").val('');
	$("#cldocnos").val('');
	document.getElementById("jqxGroupSearch").value="";  
	$("#fileexcelimport").val(null);
	$("#jqxDetailGrid").jqxGrid('clear');
	$("#cmbtemplate").val("")
	document.getElementById('filechoosen').innerHTML ="";
}

function whatsappTemplate(){  
   var path = document.getElementById("fileexcelimport").value;
   $('#jqxDetailGrid').jqxGrid('clearfilters');    
   var rows = $("#jqxDetailGrid").jqxGrid('getrows');
   var selectedrows=$("#jqxDetailGrid").jqxGrid('selectedrowindexes');
		selectedrows = selectedrows.sort(function(a,b){return a - b});

   if(selectedrows.length==0){
			$.messager.alert('Warning','Please select documents!');
			return false;
	}
    var template = $("#cmbtemplate").val(); 
    if(template=="" || template==null){
		$.messager.alert('Warning','Please select a template!');
		return false;
    }
	if(path!=null && path!="" && typeof(path)!="undefined"){
		var fsize = $('#fileexcelimport')[0].files[0].size;
		var extn = path.substring(path.lastIndexOf(".") + 1, path.length);  
		console.log("extn---"+extn);
		$("#msgtype").val("TEMPLATE");
		funCheckFormat(extn, fsize);
	}else{
		whatsappWelcome(0);     
	}
}

function whatsappWelcome(attachdoc){
		var rows = $("#jqxDetailGrid").jqxGrid('getrows');
		var selectedrows=$("#jqxDetailGrid").jqxGrid('selectedrowindexes');
		selectedrows = selectedrows.sort(function(a,b){return a - b});
		 
		var extn="";   
		if(attachdoc!="" && attachdoc!="0" && attachdoc!=null){
			var path=document.getElementById("fileexcelimport").value;
			extn = path.substring(path.lastIndexOf(".") + 1, path.length);
		}
	    $.messager.confirm('Message', 'Do you want to send whatsapp template?', function(r){
		if(r==false){
			return false; 
		}else{
			$("#overlay, #PleaseWait").show();
			var i=0;var temptrno="";
			var j=0;
			for (i = 0; i < selectedrows.length; i++) {
				if(i==0){
					var srvdetmtrno= $('#jqxDetailGrid').jqxGrid('getcellvalue', selectedrows[i], "cldocno");
					temptrno=srvdetmtrno;
				}
				else{
					var srvdetmtrno= $('#jqxDetailGrid').jqxGrid('getcellvalue', selectedrows[i], "cldocno");
					temptrno=temptrno+","+srvdetmtrno;  
				}
				temptrno1=temptrno+",";
				j++; 
			}
			
			var msgtype = "Template"; 
			if(attachdoc!="" && attachdoc!="0" && attachdoc!=null){
				ajaxFileUpload(temptrno1, msgtype, attachdoc, extn);
			}else{
				sendTemplate(temptrno1, msgtype, "", "");    
			}
		}
	});   	
}

function sendTemplate(cldocnos, msgtype, attachdoc, extn){
	 var template = $("#cmbtemplate").val(); 
	 var x=new XMLHttpRequest();
	 x.onreadystatechange=function(){
		 if (x.readyState==4 && x.status==200){
		    var items=x.responseText.split('####');
		    $("#overlay, #PleaseWait").hide();
		    if(parseInt(items[0].trim())>0){
		      $.messager.alert('Message', ' Successfully Sent ');
		      funClear();
		      funreload(event); 
		    }else{
			  $.messager.alert('Message', items[1].trim());  
			}
		} 
	}  
	x.open("GET","saveMessage.jsp?cldocnos="+encodeURIComponent(cldocnos)+"&msgtype="+msgtype+"&template="+encodeURIComponent(template)+"&attachdoc="+attachdoc+"&extn="+extn,true);     
	x.send();          
}

function getTemplates() {    
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
			$('#cmbtemplate').html($.parseHTML(options));  
		} else {
		}
	}
	x.open("GET", "getTemplates.jsp", true);  
	x.send();
}

function funchangefile(){
	var file = document.getElementById("fileexcelimport").value; 
	var fs = file.split("fakepath");
	document.getElementById('filechoosen').innerHTML = "Selected File : "+fs[1].slice(1); 
}
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background">   
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
    <tr><td colspan="2">&nbsp;</td></tr>
	<tr><td align="right"><label class="branch">Group</label></td><td align="left"><input type="text" name="group" id="group" placeholder="Press f3 to Search" style="height:20px" readonly onKeyDown="getgroupinfo(event);" value='<s:property value="group"/>'>
	<button class="waButton" type="button" id="btnClear" name="btnClear" onclick="funClear();"><i class="fa fa-times-circle" aria-hidden="true"></i>&nbsp;Clear</button></td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">
			<fieldset><legend class="branch">Add or Remove</legend>      
				<table>
					<tr><td><label class="branch">Group</label></td><td align="left"><div id="txtgroup" onkeydown="return (event.keyCode!=13);"><jsp:include page="groupInputSearch.jsp"></jsp:include></div></td></tr>
					<tr><td align="center" colspan="2"><button class="waButton" type="button" id="btnAdd" name="btnAdd" onclick="funUpdate('ADD');"><i class="fa fa-plus-square-o" aria-hidden="true"></i>&nbsp;Add Group</button>
					<button class="waButton" type="button" id="btnRemove" name="btnRemove" onclick="funUpdate('REMOVE');"><i class="fa fa-minus-circle" aria-hidden="true"></i>&nbsp;Remove Group</button></td></tr>
				</table>
			</fieldset>  
		</td>   
	</tr>  		
	<!-- <tr><td colspan="2">&nbsp;</td></tr>  -->
	<tr><td colspan="2">
			<fieldset><legend class="branch">Send Message</legend>
				<table>   
				    <tr><td align="right"><label class="branch">Template</label></td>
				    <td align="left"><select id="cmbtemplate" name="cmbtemplate" style="width:70%;">    
	  						  <option value="">--Select--</option></select></td></tr>  
					<tr><td align="right"><label class="branch">Message</label></td><td align="left"><textarea id="txtmessage" rows="4"></textarea></td></tr> 
					<tr><td align="center" colspan="2"><button class="waButton" type="button" id="btnChoosefile" name="btnChoosefile"><i class="fa fa-paperclip" aria-hidden="true"></i>&nbsp;Select file</button></td></tr>
					<tr><td colspan="2" align="center"><button class="waButton" type="button" id="btnSend" name="btnSend" onclick="whatsappMessage();"><i class="fa fa-whatsapp" aria-hidden="true"></i>&nbsp;Send</button>
					<button class="waButton" type="button" id="btnWelcome" name="btnWelcome" onclick="whatsappTemplate();"><i class="fa fa-whatsapp" aria-hidden="true"></i>&nbsp;Send Template</button></td></tr>  
				    <tr><td colspan="2"><input type="file" name="file" id="fileexcelimport" onchange="funchangefile();"></td></tr>
				    <tr><td colspan="2" align="center"><label id="filechoosen" class="branch"></label></td></tr>
				</table>
			</fieldset>  
		</td>   
	</tr>  
	<tr><td colspan="2" class="rowheight">&nbsp; 
	<input type="hidden" name="cldocnos" id="cldocnos" value='<s:property value="cldocnos"/>'>
	<input type="hidden" name="msgtype" id="msgtype" value='<s:property value="msgtype"/>'></td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="detDiv"><jsp:include page="detailGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>
<div id="groupwindow">
   <div></div>
</div>
</div> 
</body>
</html>