<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
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
</style>
<script type="text/javascript">
$(document).ready(function() {
	 $("#date").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	 $('#typeinfowindow').jqxWindow({ width: '35%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: ' Type Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	 $('#typeinfowindow').jqxWindow('close'); 
	 $('#servicetypeinfowindow').jqxWindow({ width: '35%', height: '58%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Service Type Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	 $('#servicetypeinfowindow').jqxWindow('close'); 
	 
	 $('#txttype').dblclick(function(){
		   	 $('#typeinfowindow').jqxWindow('open');
			 typeSearchContent('typesearch.jsp');
		 });
	 $('#servicetype').dblclick(function(){
	   	 $('#servicetypeinfowindow').jqxWindow('open');
		 servicetypeSearchContent('servicetypes.jsp');
	 });
	
});

function gettype(event)
{
	 var x= event.keyCode;
	 if(x==114){
	  $('#typeinfowindow').jqxWindow('open');
	 typeSearchContent('typesearch.jsp');   
	 }
	 
} 
 function typeSearchContent(url) 
 {
           $.get(url).done(function (data) {
           $('#typeinfowindow').jqxWindow('setContent', data);

	}); 
  }
 function getservicetype(event)
 {
 	 var x= event.keyCode;
 	 if(x==114){
 	  $('#servicetypeinfowindow').jqxWindow('open');
 	 servicetypeSearchContent('servicetypes.jsp');   
 	 }
 	 
 } 
  function servicetypeSearchContent(url) 
  {
            $.get(url).done(function (data) {
	           $('#servicetypeinfowindow').jqxWindow('setContent', data);

 	}); 
   }
	 function funReadOnly(){
			$('#frmQuestionnaire input').attr('readonly', true );
			/* $('#txttype').attr('readonly', true );
			$('#servicetype').attr('readonly', true );
			 */$('#frmQuestionnaire select').attr('disabled', true);
			$('#date').jqxDateTimeInput({disabled: true});
			$('#jqxquesgrid').jqxGrid({ disabled: true});
	 }
	 
	 function funRemoveReadOnly(){  
			$('#frmQuestionnaire input').attr('readonly', false );
			/* $('#txttype').attr('readonly', true );
			$('#servicetype').attr('readonly', true );
			 */$('#frmQuestionnaire select').attr('disabled', false);
			$('#jqxquesgrid').jqxGrid({ disabled: false});    
			$('#date').jqxDateTimeInput({disabled: false});
			if ($("#mode").val() == "A") {   
				$('#date').val(new Date());
				$('#jqxquesgrid').jqxGrid('clear');
				$("#jqxquesgrid").jqxGrid('addrow', null, {}); 
				
			}  
			
			$('#docno').attr('readonly', true);
	 }
	 
	 function funSearchLoad(){
		 changeContent('queMastersearch.jsp'); 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#date').jqxDateTimeInput('focus'); 	    		
	    }
	   
	 
			    	 
			
	   function funNotify(){
		   
		  /*  var typeid=document.getElementById("txtdocno").value;
			  if(typeid=="")
				{
				document.getElementById("errormsg").innerText=" Select Type";
				return 0;
				}
			  else{
					 document.getElementById("errormsg").innerText="";
				} */
		   
		 
			  var question=document.getElementById("txtquestion").value;
			  if(question=="")
				{
				document.getElementById("errormsg").innerText="Enter Question";
				return 0;
				}
			  else{
					 document.getElementById("errormsg").innerText="";
				}
		  var rows1 = $("#jqxquesgrid").jqxGrid('getrows');
		  $('#gridlen').val(rows1.length);
		  for(var i=0 ; i < rows1.length ; i++){
  		     newTextBox = $(document.createElement("input"))
  		       .attr("type", "dil")
  		       .attr("id", "mate"+i)
  		       .attr("name", "mate"+i)
  		       .attr("hidden", "true"); 
  		    
  		   newTextBox.val(rows1[i].answer+" :: "+rows1[i].points+" :: ");
  		  // alert(rows1[i].answer+" :: "+rows1[i].points);
  		   newTextBox.appendTo('form');
  		  
  				}	 
		  
		  return 1;
		}  

	  function setValues(){
		  
			var chkamagent=$("#chkcomagent").val();
			
			
			if(chkamagent>0){
				document.getElementById("chkcomagent").checked=true;
				
			}
		  $('#jqxquesgrid').jqxGrid({ disabled: true}); 
		  var docVal1 = document.getElementById("docno").value;
	      	if(docVal1>0)
	      		{
	         $("#inddiv").load("questionnaireGrid.jsp?docno="+docVal1);   
	      		}  
	      	if($('#msg').val()!=""){
	      		$.messager.alert('Message',$('#msg').val());
	      		}  
		}   
	  function funreload(){
		
		  var docVal1 = document.getElementById("docno").value;
	      	if(docVal1>0)
	      		{
	         $("#inddiv").load("questionnaireGrid.jsp?docno="+docVal1);   
	      		}  
	 }              

	  
</script>

<style>
.hidden-scrollbar {
  overflow: auto;  
  height: 530px;  
}
</style>    
        
</head>
<body onload="setValues();">   
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmQuestionnaire" action="savequestionnaire" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div  class='hidden-scrollbar'> 
<br/>
<table width="100%">
<tr><td>  
<fieldset>
<table width="100%">  
<tr>  
    <td width="3%" height="42" align="right">Date</td>
    <td width="11%"><div id="date" name="date" value='<s:property value="date"/>'></div>  
    <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddte"/>'/></td>
    
    <td width="6%" align="right">Doc No.</td>
    <td width="21%"><input type="text" id="docno" name="docno"  value='<s:property value="docno"/>' tabindex="-1"/></td>
  </tr>         
  <tr>   
    <%--  <td align="right">Type</td>
     <td width="14%"><input type="text" id="txttype" name="txttype" style="width:190px;"  readonly placeholder="Press F3 to Search" onKeyDown="gettype(event);" value='<s:property value="txttype"/>'/>
      <input type="hidden" id="txtdocno" name="txtdocno" style="width:190px;"  value='<s:property value="txtdocno"/>'/></td>
     
     <td align="right">Service Type</td>
     <td width="14%"><input type="text" id="servicetype" name="servicetype" style="width:190px;"  readonly placeholder="Press F3 to Search" onKeyDown="getservicetype(event);" value='<s:property value="servicetype"/>'/>
      <input type="hidden" id="servicedocno" name="servicedocno" style="width:190px;"  value='<s:property value="servicedocno"/>'/></td>
    --%>
   <td align="right"><input type="checkbox" name="chkcomagent" id="chkcomagent" value='<s:property value="chkcomagent" />' onclick="$(this).attr('value', this.checked ? 1 : 0);"  onchange="chkagentChange();">
    <label for="chkcomagent" style="height: 25px">Mandatory</label></td>
     <td align="right">Question</td>
     <td width="14%"><input type="text" id="txtquestion" name="txtquestion" style="width:590px;"   value='<s:property value="txtquestion"/>'/></td>
      </tr>     
    </table>   
</fieldset><br/>              
</td>               
</tr></table>   
<table width="100%">   
  <tr>
    <td>
    <div id="inddiv"><jsp:include page="questionnaireGrid.jsp"></jsp:include></div>
  </td>
  </tr>    
</table>
<input type="hidden" id="mode" name="mode"/>  
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="gridlen" name="gridlen"  value='<s:property value="gridlen"/>'/>
</div>
</form>
 	 <div id="typeinfowindow">
   <div ></div>
</div> 
<div id="servicetypeinfowindow">
   <div ></div>
</div> 
</div>
</body>
</html>
