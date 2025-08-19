<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../includes.jsp"></jsp:include>
<script src="../../js/ckeditor/ckeditor.js"></script>   
<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}

.icon {
	width: 2.5em;
	height: 2em;
	border: none;
	background-color: #E0ECF8;
}
</style>                          
<%  
String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");       
String brchid=request.getParameter("brchid")==null?"0":request.getParameter("brchid");
String formcode=request.getParameter("formcode")==null?"NA":request.getParameter("formcode");
%>

<script>    
var docno='<%=docno%>';
var brchid='<%=brchid%>';
var dtypes='<%=formcode%>';   
var formcode="";
var code="";
$(document).ready(function() {
});          
 
  function reload(){
		 $("#attachs").load("Attachgridmaster.jsp?docno="+docno+"&formc="+dtypes+"&brchid="+brchid);  
  }
 
 function setValues(){    
 } 
	 
 function funAttachs(event){                         
   		var url=document.URL;
		var reurl=url.split("/com/");  
 		if(docno!="" && docno!="0"){                
   		    var myWindow= window.open(reurl[0]+"/com/common/Attachmaster.jsp?formCode="+dtypes+"&docno="+docno+"&brchid="+brchid,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
			myWindow.focus();
   		}else{   
			swal({
				icon: 'warning',
				title: 'Warning',
				text: 'Select a Document....!'                                   
			});
			return;
		    }               
	   } 
	
	function getFormats() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var process = items[1].split(",");
				var optionsbranch = '<option value="">-- Select a Format --</option>';
				for (var i = 0; i < process.length; i++) {
					optionsbranch += '<option  value="' + srno[i].trim() +'">'
					+ process[i] + '</option>';
					
				}
				$('#cmbformat').html($.parseHTML(optionsbranch));
			} else {}
		}
		x.open("GET","getFormats.jsp?dtype="+dtypes, true);    
		x.send();
	}
	
	function getFormatLeter(){  
		var formatid=$('#cmbformat').val();
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.trim();  
				CKEDITOR.instances['message'].setData(items);        
			} else {}
		}
		x.open("GET","getFormatLetter.jsp?formatid="+formatid+"&docno="+docno, true);        
		x.send();
	}
	
	function letterPrint() {
	    var editor = CKEDITOR.instances['message'];  
 
	    if (editor) {
	        var editorTextContent = editor.getData();
	        
	        var iframe = document.createElement('iframe');
	        iframe.style.visibility = 'hidden';
	        document.body.appendChild(iframe);

	        iframe.contentDocument.write('<html><head><title>Print Content</title></head><body><div id="content"></div></body></html>');
	        iframe.contentDocument.close();

	        var contentDiv = iframe.contentDocument.getElementById('content');
	        contentDiv.innerHTML = editorTextContent;

	        iframe.contentWindow.print();
	        document.body.removeChild(iframe);  
	    }
	}
	 
</script>
</head>
<body onload="getFormats();reload();setValues();">  
    <div id="mainBG" class="homeContent" data-type="background">
        <form id="frmLetter" action="SendLetter" method="post" autocomplete="off"> 
            <div id='search'>
                <fieldset>
                    <table width="100%">
                        <tr>
                            <td colspan="4" align="center" style="font-size: 18px; font-family: Verdana;"><b>Letter</b></br></br></td>    
                        </tr>
                         <tr>
                            <td width="3%"><label for="format" id="formatlbl">Format</label></td>
                            <td width="10%"><select name="cmbformat" id="cmbformat" style="width:100%" onchange="getFormatLeter();">
                            <option value="">--Select--</option>
                            </select></td>
						    <td align="left">
						        <button type="button" class="icon" type="button" id="btnPrint" title="Print" onclick="letterPrint();">
						            <img alt="Print" src="<%=contextPath%>/icons/icons_print.png" style="width: 20px; height: 20px;">  
						        </button>
						    </td>
						</tr>

                        <tr>
                            <td colspan="4"><textarea id="message" style="height:100px;width:135%;font: 10px Tahoma;resize:none" name="message"><s:property value="message"></s:property></textarea></td>
                        </tr>
                    </table>
                    <table width="100%">
                        <tr>
                            <td width="5%">
                                  <button type="button" class="icon" type="button" id="btnAttach" title="Attachment" onclick="funAttachs(event);">
                                    <img alt="Attachment" src="<%=contextPath%>/icons/icons_attach.png" style="width: 20px; height: 20px;"> </button> 
                                  <button type="button" class="icon" type="button" id="btnReload" title="Reload" onclick="reload();">
						            <img alt="Reload" src="<%=contextPath%>/icons/icons_reloadBox.png" style="width: 20px; height: 20px;"> </button>
						     </td>  
                        </tr>

                    </table>
                    <table width="100%">  
                        <tr>
                            <td width="100%">
                                <div id="attachs">
                                    <jsp:include page="Attachgridmaster.jsp"></jsp:include>
                                </div>
                            </td>
                        </tr>
                    </table>
                </fieldset>
                <input type="hidden" id="trno" name="trno" value='<s:property value="trno"/>' />
                <input type="hidden" id="docno" name="docno" value='<s:property value="docno"/>' />
                <input type="hidden" id="userid" name="userid" value='<s:property value="userid"/>' />
                <input type="hidden" id="brchid" name="brchid" value='<s:property value="brchid"/>' />
                <input type="hidden" id="formcode" name="formcode" value='<s:property value="formcode"/>' />
                <input type="hidden" id="reformcode" name="reformcode" value='<s:property value="reformcode"/>' />
                <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>' />
                <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
                <input type="hidden" id="txtmsg" name="txtmsg" value='<s:property value="txtmsg"/>' />
                <input type="hidden" id="filename" name="filename" value='<s:property value="filename"/>' />
            </div>
        </form>
    </div>
    <script>
        CKEDITOR.replace('message');
    </script>
</body>
</html>