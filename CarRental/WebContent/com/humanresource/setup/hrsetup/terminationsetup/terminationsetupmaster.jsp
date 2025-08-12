<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath(); %>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../../includes.jsp"></jsp:include>
<style>
form label.error {
 color:red;
 font-weight:bold;

}

.myButton1 {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	-moz-border-radius:4px;
	-webkit-border-radius:4px;
	border-radius:4px;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:12px;
	padding:2px 12px;
	text-decoration:none;
}
.myButton1:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButton1:active {
	position:relative;
	top:1px;
}
 
.myButton4 {
	-moz-box-shadow:inset 0px 0px 0px -24px #e67a73;
	-webkit-box-shadow:inset 0px 0px 0px -24px #e67a73;
	box-shadow:inset 0px 0px 0px -24px #e67a73;
	background-color:#e4685d;
	-moz-border-radius:4px;
	-webkit-border-radius:4px;
	border-radius:4px;
	border:1px solid #ffffff;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:12px;
	padding:3px 12px;
	text-decoration:none;
	text-shadow:0px 1px 0px #b23e35;
}
.myButton4:hover {
	background-color:#eb675e;
}
.myButton4:active {
	position:relative;
	top:1px;
}

.bounce {
	color: #f35626;
    background-image: -webkit-linear-gradient(92deg,#f35626,#feab3a);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    -webkit-animation: hue 60s infinite linear,bounce 2s infinite; 
}

@-webkit-keyframes bounce {
  0%, 20%, 50%, 80%, 100% {
    -moz-transform: translateX(0);
    -ms-transform: translateX(0);
    -webkit-transform: translateX(0);
    transform: translateX(0);
  }
  40% {
    -moz-transform: translateX(-30px);
    -ms-transform: translateX(-30px);
    -webkit-transform: translateX(-30px);
    transform: translateX(-30px);
  }
  60% {
    -moz-transform: translateX(-15px);
    -ms-transform: translateX(-15px);
    -webkit-transform: translateX(-15px);
    transform: translateX(-15px);
  }
} 

@media (min-width: 15px) {
  .mega {
    font-size: 15px;
  }
}

@font-face {
  font-family: 'Roboto',comic sans ms,Tahoma;
  font-style: normal;
  font-weight: 100;
  unicode-range: U+0460-052F, U+20B4, U+2DE0-2DFF, U+A640-A69F;
}
  
@-webkit-keyframes hue {
  from {
    -webkit-filter: hue-rotate(0deg);
  }

  to {
    -webkit-filter: hue-rotate(-360deg);
  }
}

</style>

 
<script type="text/javascript">

	$(document).ready(function () {   
		
	    document.getElementById("formdet").innerText="Termination Setup(TSP)";
		document.getElementById("formdetail").value="Termination Setup";
		document.getElementById("formdetailcode").value="TSP";
		window.parent.formCode.value="TSP";
		window.parent.formName.value="Termination Setup";
		document.getElementById("showlabel").innerText="";
		
		$('#refSearchwindow').jqxWindow({ width: '60%', height: '62%',  maxHeight: '75%' ,maxWidth: '60%' , title: 'Ref No Search' ,position: { x: 150, y: 60 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#refSearchwindow').jqxWindow('close');
		
		$('#btnCreate').attr('disabled', true);
		$('#btnDelete').attr('disabled', true);
		$('#btnSearch').attr('disabled', true);
		$('#btnEdit').attr('disabled', true);
		
		$('#refno').dblclick(function(){
			  $('#refSearchwindow').jqxWindow('open');
			  refnoSearchContent('refmastersearch.jsp?');
		});   
		    
     });
	
	function funSearchLoad(){}

	function refnoSearchContent(url) {
		    $.get(url).done(function (data) {
		    $('#refSearchwindow').jqxWindow('open');
	   		$('#refSearchwindow').jqxWindow('setContent', data);
		}); 
	}
	 
	 
	 function gethrsetup(event){
	 	 var x= event.keyCode;
	 	 if(x==114){
		 	  $('#refSearchwindow').jqxWindow('open');
		 	  refnoSearchContent('refmastersearch.jsp?');    }
	 	 else{}
	 	 }
      
	function funReadOnly() {
		$('#frmleavesetup input').attr('readonly', true);
		//btnCreate btnDelete  btnSearch btnEdit
	
		$('#savebtn').attr('disabled', true);
		$('#deltbtn').attr('disabled', true);
		 
		/* 	$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
	}
	
	function funRemoveReadOnly() {
		$('#frmleavesetup input').attr('readonly', false);
		$('#docno').attr('readonly', true);
	}
 
	function setValues() {
		  /* if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val()); 
			   document.getElementById("newmode").value='Saved';
			  } 
		 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")"; */
			
			  if(document.getElementById("newmode").value=='Saved') {
				   var type = document.getElementById("hidtype").value; 
				   var leaveid=document.getElementById("leaveid").value;
				   var refno= document.getElementById("refno").value;
				   console.log("ENterd load -")
				   $("#lsetup1").load("terminationgrid.jsp?docno="+refno+"&leaveid="+leaveid+"&type="+type);
				   $("#lsetup3").load("resignationgrid.jsp?docno="+refno+"&leaveid="+leaveid+"&type="+type);
				   $("#lsetup4").load("leavegrid.jsp?docno="+refno+"&leaveid="+leaveid+"&type="+type);
				   console.log("ENterd load -1")
				  
				   var disdata="hide";
	        	   $("#lsetup2").load("condtiongrid.jsp?docno="+refno+"&refno="+leaveid+"&disdata="+disdata+"&type="+type);
	        	   document.getElementById("showlabel").innerText=document.getElementById("hidshowlabel").value;
	        	   
	               $.messager.alert('Message', '  Record successfully Updated ');
	        	   	funReadOnly();
				   } else if(document.getElementById("newmode").value=='notSaved') {
				      $.messager.alert('Message', '  Not Updated ');
				  } 
	}
	
	 function funNotify(){}
	 
	 function fundel() {
		 
		 var leaveid="";
		 var type="";
		 var rowst = $("#terminationgrid").jqxGrid('getrows');      
		 var rowsl = $("#leavegrid").jqxGrid('getrows');      
		 var rowsr = $("#jqxresignationgrid").jqxGrid('getrows');      
 		 for(var i=0;i<rowst.length;i++){
		     if(parseInt(rowst[i].checkclick)==1){
		    	 leaveid=rowst[i].srno; 
		    	 type = 'TER';
		     }
 		 }
 		 
 		 
 		for(var i=0;i<rowsl.length;i++){
		     if(parseInt(rowsl[i].checkclick)==1){
		    	 leaveid=rowsl[i].srno; 
		    	 type = 'LEV';
		     }
		 }
 		 
 		for(var i=0;i<rowsr.length;i++){
		     if(parseInt(rowsr[i].checkclick)==1){
		    	leaveid=rowsr[i].srno; 
		    	 type = 'RES'
		     }
		 }
 		
 		var outputmessage = type==='TER'?'Termination ':type==='RES'?'Resignation ':'Leave ';
		 
         $.messager.confirm('Message', 'Do you want to delete all records of '+outputmessage , function(r){
	        	if(r==false) {
	        		return false; 
	        	  } else{
	        		fundeldata(leaveid,type);
	        	}
		     });
	 	  
       }

	   function fundeldata(leaveid,type) {
				 var refno= document.getElementById("refno").value;
				 var x=new XMLHttpRequest();
					x.onreadystatechange=function(){
					if (x.readyState==4 && x.status==200) {
						 	var items= x.responseText;
						 	if(parseInt(items)>0) {
						 		  $.messager.alert('Message', 'Record Successfully Deleted the record');
						          document.getElementById("newmode").value="";
						 		  var leaveid=document.getElementById("leaveid").value;
								  var refno= document.getElementById("refno").value;
								  if(type==='TER'){
									  $("#lsetup1").load("terminationgrid.jsp?docno="+refno+"&leaveid="+leaveid);
									  $("#terminationgrid").jqxGrid('updatebounddata');
								  } else if(type==='RES'){
									  $("#lsetup3").load("resignationgrid.jsp?docno="+refno+"&leaveid="+leaveid);
									  $("#jqxresignationgrid").jqxGrid('updatebounddata');
								  } else if (type=='LEV'){
									  $("#lsetup4").load("leavegrid.jsp?docno="+refno+"&leaveid="+leaveid);
									  $("#leavegrid").jqxGrid('updatebounddata');
								  }
								  
								  var disdata="hide";
					        	  $("#lsetup2").load("condtiongrid.jsp?docno="+refno+"&refno="+leaveid+"&disdata="+disdata+"&type="+type);
						    } else { 
						    	  $.messager.alert('Message', '  Not Deleted'); 
						 	}
				       }
					}
					  x.open("GET","deletedate.jsp?refno="+leaveid+"&docno="+refno+"&type="+type,true);
				     x.send();
			 }
	   
	     function funsave(){
	         $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		        	if(r==false) {
		        		return false; 
		        	 } else{
		        		 if($('#refno').val()==''){
		        			 $.messager.alert('Warning', 'Please select the Category');
		        		 } else {
			        		funsavedata();
		        		 }
		        	}
			     });
	     }
	     
	     function funsavedata(){	 
	    	  var z=0;
			  var rows = $("#condtiongrid").jqxGrid('getrows');      
			  var selectedrows=$("#condtiongrid").jqxGrid('selectedrowindexes');
				 
				$('#algridlength').val(selectedrows.length);
				
			    for (var i = 0; i < rows.length; i++) {
				      for(var j=0;j<selectedrows.length;j++){
				       if(selectedrows[j]==i){
				    	   newTextBox = $(document.createElement("input"))
				    	   .attr("type", "dil")
					       .attr("id", "condtest"+z)
					       .attr("name", "condtest"+z)
					       .attr("hidden", "true");  
					   newTextBox.val(rows[i].allowanceid+" :: ");
					   newTextBox.appendTo('form');
					   z++;
				       }
				      }
                   }
		   
			 //   ldocno, cf,deduct,l1,l2,l3,l1ded,l2ded,l3ded,checkclick
		   
			var rows = $("#terminationgrid").jqxGrid('getrows');      
		    for(var i=0;i<rows.length;i++){
		     if(parseInt(rows[i].checkclick)==1){
			    newTextBox = $(document.createElement("input"))
			       .attr("type", "dil")
			       .attr("id", "terminationtest"+0)
			       .attr("name", "terminationtest"+0)
			       .attr("hidden", "true");  
			   newTextBox.val(rows[i].srno+" :: "+rows[i].years+" :: "+rows[i].days); 
			   newTextBox.appendTo('form');
		     }
		    }
		     
		     var rows = $("#jqxresignationgrid").jqxGrid('getrows');      
			    for(var i=0;i<rows.length;i++){
			     if(parseInt(rows[i].checkclick)==1){
				    newTextBox = $(document.createElement("input"))
				       .attr("type", "dil")
				       .attr("id", "resignationtest"+0)
				       .attr("name", "resignationtest"+0)
				       .attr("hidden", "true");  
				   newTextBox.val(rows[i].srno+" :: "+rows[i].years+" :: "+rows[i].days); 
				   newTextBox.appendTo('form');
			     }
		   }

			    var rows = $("#leavegrid").jqxGrid('getrows');      
			    for(var i=0;i<rows.length;i++){
			     if(parseInt(rows[i].checkclick)==1){
				    newTextBox = $(document.createElement("input"))
				       .attr("type", "dil")
				       .attr("id", "leavetest"+0)
				       .attr("name", "leavetest"+0)
				       .attr("hidden", "true");  
				   newTextBox.val(rows[i].srno+" :: "+rows[i].years+" :: "+rows[i].days); 
				   newTextBox.appendTo('form');
			     }
		   } 
			   
		    document.getElementById("frmTerminationsetup").submit();
	    		/* return 1; */
		} 
	     
	     function funFocus(){}
	  
</script>  
 
</head>
<body onLoad="setValues();" >

<form id="frmTerminationsetup" action="saveTerminationsetup" method="post" autocomplete="off"> 
<jsp:include page="../../../../../header.jsp" /><br/> 
	
<fieldset><legend>Termination Setup</legend>   
<fieldset>
<table width="100%">
		<tr><td width="10%"  align="right">Ref No</td> 
		<td width="15%" align="left"><input type="text" placeholder="Press F3 To Search" onKeyDown="gethrsetup(event);" name="refno" id="refno" style="width:100%;" value='<s:property value="refno"/>' readonly></td>
		<td width="8%" align="right">Category</td>
		<td width="27%" ><input type="text" name="category"  id="category" style="width:99%;" value='<s:property value="category"/>'></td>
		<td width="40%" class="bounce" style="text-align: center;">&nbsp;&nbsp;&nbsp;<b><label id="showlabel" style="font-size: 13px;font-family: Tahoma; color:#6000FC" value='<s:property value="showlabel"/>'></label></b></td></tr> 
</table> 
</fieldset><br/>

<table width="100%">
	 <tr>
	 	<td width="33%">
	 		<fieldset>
	 			<legend>Termination Details</legend>
	 			<div id="lsetup1"> <jsp:include page="terminationgrid.jsp"></jsp:include></div>
	 		</fieldset>
	 	</td>
	 	<td width="33%">
	 		<fieldset>
	 			<legend>Leave Details</legend>
	 			<div id="lsetup4"> <jsp:include page="leavegrid.jsp"></jsp:include></div>
	 		</fieldset>
	 	</td>	
	 	<td width="33%">	
	 		<fieldset>
	 			<legend>Resignation Details</legend>
	 			<div id="lsetup3"> <jsp:include page="resignationgrid.jsp"></jsp:include></div>
	 		</fieldset>
	 	</td>	
	<tr>
	 <td align="center" colspan="3">
	 <fieldset><div id="lsetup2"> <jsp:include page="condtiongrid.jsp"></jsp:include></div></fieldset><br/>
	 <input type="button" id="savebtn" class="myButton1" onclick="funsave();" value="Save"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <input type="button" id="deltbtn" onclick="fundel()"   class="myButton4"  value="Delete"></td>
	 </tr>
</table>
	 
<input type="hidden" id="docno" name="docno" value='<s:property value="docno"/>' />
<input type="hidden" id="hidshowlabel" name="hidshowlabel" value='<s:property value="hidshowlabel"/>' />
<input type="hidden" id="hidtype" name="hidtype" value='<s:property value="hidtype"/>' />
<input type="hidden" id="leaveid" name="leaveid" value='<s:property value="trid"/>' />
<input type="hidden" id="newmode" name="newmode" value='<s:property value="newmode"/>' />
<input type="hidden" id="algridlength" name="algridlength" value='<s:property value="algridlength"/>' />
<input type="hidden" id="catid" name="catid" value='<s:property value="catid"/>' />
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/> 
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 

</fieldset> 
</form><br/>

<div id="refSearchwindow">
   <div></div>
</div>	 

</body>
</html>