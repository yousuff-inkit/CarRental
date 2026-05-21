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
   1. 100% SCOPED CSS - GUARANTEED NOT TO BREAK HEADER
========================================================= */

/* Validation Errors */
form label.error {
    color: red;
    font-weight: bold;
    font-size: 11px;
}

/* Wrapper to isolate our form layout from the header */
#leavesetup-form-container {
    padding-top: 15px;
    width: 100%;
}

/* Scoped Fieldsets (Replaces the .middle-panel logic cleanly) */
#leavesetup-form-container .master-fieldset {
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 20px 15px 15px 15px;
    margin-bottom: 25px;
    background-color: transparent; 
    box-shadow: 0 1px 3px rgba(0,0,0,0.05);
}

/* The Blue Left-Border Title */
#leavesetup-form-container .master-legend {
    font-size: 15px;
    font-weight: 600;
    color: #0056b3;
    padding: 0 10px;
    border-left: 4px solid #0056b3;
    width: auto;
    margin-bottom: 0;
    border-bottom: none;
    line-height: 1.2;
}

/* Flexbox rows */
#leavesetup-form-container .master-row {
    display: flex;
    align-items: center;
    margin-bottom: 12px;
    gap: 15px;
}

/* Right aligned labels */
#leavesetup-form-container .master-label {
    font-size: 13px;
    font-weight: 600;
    color: #1e293b;
    text-align: right;
    min-width: 80px;
    white-space: nowrap;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

/* Strict custom class for inputs so it NEVER affects the header */
#leavesetup-form-container .master-input {
    height: 26px !important;
    border: 1px solid #cbd5e0;
    border-radius: 4px;
    padding: 2px 8px;
    font-size: 13px;
    box-sizing: border-box;
    color: #333;
    background-color: #fff;
    width: 100%;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

#leavesetup-form-container .master-input:focus {
    border-color: #3b82f6;
    outline: none;
    box-shadow: 0 0 0 1px #3b82f6;
}

#leavesetup-form-container .master-input[readonly],
#leavesetup-form-container .master-input:disabled {
    background-color: #f8f9fa;
    color: #6b7280;
}

/* Search Icon Wrapper */
#leavesetup-form-container .search-wrapper {
    position: relative;
    display: flex;
    flex: 1;
}
#leavesetup-form-container .search-wrapper input {
    padding-right: 28px !important;
}
#leavesetup-form-container .search-wrapper svg {
    position: absolute;
    right: 6px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
#leavesetup-form-container .search-wrapper svg:hover { color: #007bff; }

/* Grid Container */
.grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    overflow: hidden;
    background: #fff;
    margin-top: 10px;
}

/* Custom UI Buttons matching 26px height */
.myButton1, .myButton4 {
    height: 26px !important;
    line-height: 24px !important;
    padding: 0 14px;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    font-size: 12px;
    font-weight: bold;
    border-radius: 4px;
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
		
		// Bulletproof disabling ALL buttons EXCEPT Close and Approval
		$('#btnNew, #btnCreate, #btnSave, #btnEdit, #btnDelete, #btnSearch, #btnExcel, #btnPrint, #btnAttach, #btnAttachment, #attachBtn, #savebtn, #deltbtn').prop('disabled', true)
			.css({'pointer-events': 'none', 'opacity': '0.5'})
			.attr('tabindex', '-1');

		// Keep strictly Close and Approval alive
		$('#btnClose, #btnApprove, #btnApproval').prop('disabled', false)
			.css({'pointer-events': 'auto', 'opacity': '1'})
			.removeAttr('tabindex');
		
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
    		$('#frmleavesetup .master-input').attr('readonly', true);
    		$('#savebtn').attr('disabled', true);
    		$('#deltbtn').attr('disabled', true);
	    } catch(e) { console.error("Error in funReadOnly: ", e); }
	}
	
	/* SAFE REMOVE READONLY FUNCTION */
	function funRemoveReadOnly() {
	    try {
    		$('#frmleavesetup .master-input').attr('readonly', false);
    		$('#category').attr('readonly', true); 
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

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmleavesetup" action="saveLeavesetup" method="post" autocomplete="off"> 

    <jsp:include page="../../../../../header.jsp" />
	
    <div id="leavesetup-form-container">

        <fieldset class="master-fieldset" style="margin-top: 15px;">
            <legend class="master-legend">Leave Setup</legend>
            <div class="master-row" style="margin-bottom: 0;">
                
                <label class="master-label" style="width: 50px;">Ref No</label>
                <div class="search-wrapper" style="max-width: 150px;">
                    <input type="text" class="master-input" placeholder="Press F3 To Search" onKeyDown="gethrsetup(event);" name="refno" id="refno" value='<s:property value="refno"/>'>
                    <svg onclick="$('#refSearchwindow').jqxWindow('open'); refnoSearchContent('refmastersearch.jsp?');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                
                <label class="master-label" style="width: 80px; margin-left: 20px;">Category</label>
                <input type="text" class="master-input" name="category" id="category" value='<s:property value="category"/>' readonly="readonly" style="max-width: 250px;">
                
                <div style="flex: 1; text-align: center;">
                    <label id="showlabel" class="bounce" value='<s:property value="showlabel"/>'></label>
                </div>

            </div>
        </fieldset>
        
        <div style="display: flex; gap: 20px;">
            
            <div style="flex: 6.5; min-width: 600px;">
                <fieldset class="master-fieldset" style="height: 100%; box-sizing: border-box; margin-bottom: 0;">
                    <legend class="master-legend">Leave Details</legend>
                    <div class="grid-container" id="lsetup1" style="margin-top: 10px;"> 
                        <jsp:include page="leavesetupgrid.jsp"></jsp:include>
                    </div>
                </fieldset>
            </div>
            
            <div style="flex: 3.5; min-width: 350px;">
                <fieldset class="master-fieldset" style="height: 100%; box-sizing: border-box; margin-bottom: 0; display: flex; flex-direction: column;">
                    <legend class="master-legend">Leave Conditions</legend>
                    
                    <div class="grid-container" id="lsetup2" style="margin-top: 10px; margin-bottom: 15px; flex: 1;"> 
                        <jsp:include page="condtiongrid.jsp"></jsp:include>
                    </div>
                    
                    <div style="text-align: center; margin-top: auto;">
                        <input type="button" id="savebtn" class="myButton1" onclick="funsave();" value="Save">
                        &nbsp;&nbsp;&nbsp; 
                        <input type="button" id="deltbtn" onclick="fundel()" class="myButton4" value="Delete">
                    </div>
                </fieldset>
            </div>

        </div>
        
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