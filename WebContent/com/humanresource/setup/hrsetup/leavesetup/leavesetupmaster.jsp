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
/* =========================================================
SCOPED UI: Bulletproof Table Layout (Does NOT affect header.jsp)
========================================================= */

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 10px 20px;
    box-sizing: border-box;
}

.modern-ui .erp-form-area {
    background-color: #f4f7fb;
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    padding: 15px 10px;
    margin-bottom: 10px;
    min-width: 1050px; 
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui select { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

.modern-ui td {
    padding: 4px 5px;
    vertical-align: middle;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Split Section Styling */
.modern-ui .section-title {
    font-size: 13px;
    font-weight: bold;
    color: #0056b3;
    margin-bottom: 10px;
    border-bottom: 1px solid #c5d3e0;
    padding-bottom: 3px;
}

/* Custom UI Buttons matching 24px height */
.myButton1, .myButton4 {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 12px;
    font-family: Arial, sans-serif;
    font-size: 11px;
    font-weight: bold;
    border-radius: 3px;
    cursor: pointer;
    text-shadow: none;
    transition: all 0.2s;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    border: none;
}

.myButton1 {
    background-color: #566963;
    color: #ffffff;
}
.myButton1:hover { background-color: #768d87; }

.myButton4 {
    background-color: #e4685d;
    color: #ffffff;
}
.myButton4:hover { background-color: #eb675e; }

/* Status Text Bounce Effect */
.bounce {
    color: #f35626;
    background-image: -webkit-linear-gradient(92deg,#f35626,#feab3a);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    -webkit-animation: hue 60s infinite linear,bounce 2s infinite; 
    font-size: 13px;
    font-family: Tahoma;
    font-weight: bold;
}

@-webkit-keyframes hue {
    from { -webkit-filter: hue-rotate(0deg); }
    to { -webkit-filter: hue-rotate(-360deg); }
}

/* Data Grid Container */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    overflow: hidden;
    background: #fff;
    margin-bottom: 10px;
}

.hidden-scrollbar { 
    overflow: auto; 
    height: calc(100vh - 100px);
}
.hidden-scrollbar::-webkit-scrollbar { width: 0px; }
</style>

<script type="text/javascript">

	$(document).ready(function () {   
		
	    if(document.getElementById("formdet")) document.getElementById("formdet").innerText="Leave Setup(LSP)";
		if(document.getElementById("formdetail")) document.getElementById("formdetail").value="Leave Setup";
		if(document.getElementById("formdetailcode")) document.getElementById("formdetailcode").value="LSP";
		if(window.parent && window.parent.formCode) window.parent.formCode.value="LSP";
		if(window.parent && window.parent.formName) window.parent.formName.value="Leave Setup";
		
		if(document.getElementById("showlabel")) document.getElementById("showlabel").innerText="";
		
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
      
    /* SAFE READONLY FUNCTION */
	function funReadOnly() {
	    try {
    		$('#frmleavesetup input[type="text"]').attr('readonly', true);
    		$('#savebtn').attr('disabled', true);
    		$('#deltbtn').attr('disabled', true);
	    } catch(e) { console.error("Error in funReadOnly: ", e); }
	}
	
	/* SAFE REMOVE READONLY FUNCTION */
	function funRemoveReadOnly() {
	    try {
    		$('#frmleavesetup input[type="text"]').attr('readonly', false);
    		$('#docno').attr('readonly', true);
	    } catch(e) { console.error("Error in funRemoveReadOnly: ", e); }
	}
 
    /* SAFE SET VALUES FUNCTION */
	function setValues() {
	    try {
			if(document.getElementById("newmode") && document.getElementById("newmode").value=='Saved') {
			   var leaveid=document.getElementById("leaveid").value;
			   var refno= document.getElementById("refno").value;
			   
			   if($("#lsetup1").length) $("#lsetup1").load("leavesetupgrid.jsp?docno="+refno);
			  
			   var disdata="hide";
			  
    	       if($("#lsetup2").length) $("#lsetup2").load("condtiongrid.jsp?docno="+refno+"&leaveid="+leaveid+"&disdata="+disdata);
    	       
    	       if(document.getElementById("showlabel") && document.getElementById("hidshowlabel")) {
    	           document.getElementById("showlabel").innerText=document.getElementById("hidshowlabel").value;
    	       }
    	       
               $.messager.alert('Message', '  Record successfully Updated ');
    	       funReadOnly();
			} else if(document.getElementById("newmode") && document.getElementById("newmode").value=='notSaved') {
			      $.messager.alert('Message', '  Not Updated ');
			} 
			
            if (document.getElementById("formdet") && $('#formdetail').length && $('#formdetailcode').length) {
                var detailVal = $('#formdetail').val() || "";
                var codeVal = $('#formdetailcode').val() || "";
                document.getElementById("formdet").innerText = detailVal + " (" + codeVal.trim() + ")";
            }
	    } catch(e) { console.error("Error in setValues: ", e); }
	}
	
	 function funNotify(){}
	 
	 function fundel() {
		 var leavetype="";
		 var rows = $("#leavesetupgrid").jqxGrid('getrows');      
 		 for(var i=0;i<rows.length;i++){
		     if(parseInt(rows[i].checkclick)==1){
		    	leavetype=rows[i].leavetype; 
		     }
 		 }
		 
         $.messager.confirm('Message', 'Do you want to delete all records of '+leavetype, function(r){
	        	if(r==false) {
	        		return false; 
	        	  } else{
	        		var leaveid="";
	        		var rows = $("#leavesetupgrid").jqxGrid('getrows');      
	        		for(var i=0;i<rows.length;i++){
	        			if(parseInt(rows[i].checkclick)==1){
	        			  leaveid=rows[i].ldocno; 
	        			 }
	        		}
	        		fundeldata(leaveid,leavetype);
	        	}
		     });
 	  
       }

	   function fundeldata(leaveid,leavetype) {
				 var refno= document.getElementById("refno").value;
				 var x=new XMLHttpRequest();
					x.onreadystatechange=function(){
					if (x.readyState==4 && x.status==200) {
						 	var items= x.responseText;
						 	if(parseInt(items)>0) {
						 		  $.messager.alert('Message', 'Record Successfully Deleted Leave Type - '+leavetype);
						          document.getElementById("newmode").value="";
						 		  var leaveid=document.getElementById("leaveid").value;
								  var refno= document.getElementById("refno").value;
								  
								  if($("#lsetup1").length) $("#lsetup1").load("leavesetupgrid.jsp?docno="+refno);
								  var disdata="hide";
					        	  if($("#lsetup2").length) $("#lsetup2").load("condtiongrid.jsp?docno="+refno+"&leaveid="+leaveid+"&disdata="+disdata);
						    } else { 
						    	  $.messager.alert('Message', '  Not Deleted'); 
						 	}
				       }
					}
					  x.open("GET","deletedate.jsp?leaveid="+leaveid+"&refno="+refno,true);
				     x.send();
			 }
	   
	     function funsave(){
	         $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		        	if(r==false) {
		        		return false; 
		        	 } else{
		        		funsavedata();
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
		   
			var rows = $("#leavesetupgrid").jqxGrid('getrows');      
		    for(var i=0;i<rows.length;i++){
		     if(parseInt(rows[i].checkclick)==1){
			    newTextBox = $(document.createElement("input"))
			       .attr("type", "dil")
			       .attr("id", "leavetest"+0)
			       .attr("name", "leavetest"+0)
			       .attr("hidden", "true");  
			    
			   newTextBox.val(rows[i].ldocno+" :: "+rows[i].cf+" :: "+rows[i].deduct+" :: "+rows[i].l1+" :: "+rows[i].l2+" :: "+rows[i].l3+" :: "+rows[i].l1ded+" :: "+rows[i].l2ded+" :: "+rows[i].l3ded); 
			   newTextBox.appendTo('form');
		     }
		   }

		    document.getElementById("frmleavesetup").submit();
		} 
	     
	     function funFocus(){}
	  
</script>  
 
</head>
<body onLoad="setValues();" >

<div id="mainBG" class="homeContent hidden-scrollbar" data-type="background">
<form id="frmleavesetup" action="saveLeavesetup" method="post" autocomplete="off"> 
    <jsp:include page="../../../../../header.jsp" />
	
    <div class="modern-ui">

        <div class="erp-form-area">
            <div class="section-title">Leave Setup</div>
            <table width="100%" border="0" cellspacing="0" cellpadding="2">
                <tr>
                    <td class="lbl-right" width="5%">Ref No</td> 
                    <td width="20%">
                        <input type="text" placeholder="Press F3 To Search" onKeyDown="gethrsetup(event);" name="refno" id="refno" value='<s:property value="refno"/>'>
                    </td>
                    <td class="lbl-right" width="8%">Category</td>
                    <td width="20%">
                        <input type="text" name="category" id="category" value='<s:property value="category"/>' readonly="readonly">
                    </td>
                    <td width="47%" align="center">
                        <label id="showlabel" class="bounce" value='<s:property value="showlabel"/>'></label>
                    </td>
                </tr>
            </table>
        </div>
        
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="65%" valign="top" style="padding-right: 10px;">
                    <div class="erp-form-area" style="height: 100%;">
                        <div class="section-title">Leave Details</div>
                        <div class="grid-container" id="lsetup1"> 
                            <jsp:include page="leavesetupgrid.jsp"></jsp:include>
                        </div>
                    </div>
                </td>
                
                <td width="35%" valign="top">
                    <div class="erp-form-area" style="height: 100%;">
                        <div class="section-title">Leave Conditions</div>
                        <div class="grid-container" id="lsetup2" style="margin-bottom: 15px;"> 
                            <jsp:include page="condtiongrid.jsp"></jsp:include>
                        </div>
                        
                        <div style="text-align: center;">
                            <input type="button" id="savebtn" class="myButton1" onclick="funsave();" value="Save">
                            &nbsp;&nbsp;&nbsp; 
                            <input type="button" id="deltbtn" onclick="fundel()" class="myButton4" value="Delete">
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        
        <div style="display:none;">
            <input type="hidden" id="docno" name="docno" value='<s:property value="docno"/>' />
            <input type="hidden" id="hidshowlabel" name="hidshowlabel" value='<s:property value="hidshowlabel"/>' />
            <input type="hidden" id="leaveid" name="leaveid" value='<s:property value="leaveid"/>' />
            <input type="hidden" id="newmode" name="newmode" value='<s:property value="newmode"/>' />
            <input type="hidden" id="algridlength" name="algridlength" value='<s:property value="algridlength"/>' />
            <input type="hidden" id="catid" name="catid" value='<s:property value="catid"/>' />
            <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/> 
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 
            
            <input type="hidden" id="formdetail" name="formdetail" value='<s:property value="formdetail"/>'/>
            <input type="hidden" id="formdetailcode" name="formdetailcode" value='<s:property value="formdetailcode"/>'/>
        </div>

    </div>
</form>

<div id="refSearchwindow"><div></div></div> 

</div>
</body>
</html>