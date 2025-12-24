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
/* ------------------------------
    GLOBAL STYLES (MASTER CRV UI)
------------------------------ */

body {
    /* Subtle blue gradient background */
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 32px 0;
    box-sizing: border-box;
    overflow-y: auto !important; /* Ensure body scrolling works for all content */
}

#mainBG {
    /* White card container */
    background: #fff;
    border-radius: 16px;
    padding: 20px;
    max-width: 100%;
    margin: auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

/* ------------------------------
    COMMON UI ELEMENTS
------------------------------ */

input[type="text"], select {
    height: 32px !important;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    background: #fff;
    transition: border-color 0.2s;
    font-size: 14px;
    box-sizing: border-box;
    width: 100%; /* Ensure inputs fill their container columns */
}

input[type="text"]:focus,
select:focus {
    border-color: #007bff;
    outline: none;
}

label {
    font: 14px Tahoma;
    color: #253858;
    white-space: nowrap;
    line-height: 32px; /* Aligns with input heights */
    padding: 0px 8px 0px 0px; 
    text-align: right; 
}

/* ------------------------------
    CARD ROWS LAYOUT (CORE MASTER UI)
------------------------------ */

/* The main container for a section, creating the card effect */
.section-block {
    flex: 1;
    min-width: 0;
    background: #f6f8fa; /* Light background for the card */
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.1);
}

.section-block h2 {
    font-size: 1.1rem;
    font-weight: 600;
    margin: 0 0 20px;
    padding-left: 10px;
    border-left: 4px solid #007bff; /* Blue line accent */
}

/* Container for rows that are side-by-side */
.section-row {
    display: flex;
    gap: 26px;
    margin-bottom: 30px;
}

/* Base layout for fields (Label | Input) */
.form-group {
    display: grid;
    grid-template-columns: 120px 1fr;
    align-items: center;
    gap: 12px 16px;
    margin-bottom: 12px;
}

.form-group label {
    font-size: 1rem;
}

/* Specific layout for the main "Vehicle Info As In Agreement" section (3 columns) */
.agmt-info-grid {
    display: grid;
    /* 3 sets of Label(auto) | Input(1fr) per row */
    grid-template-columns: auto 1fr auto 1fr auto 1fr; 
    gap: 15px 25px;
    align-items: center;
}

/* Specific layout for the side-by-side cards (4 columns) */
.in-out-info-grid {
    display: grid;
    /* Label | Input | Label | Input */
    grid-template-columns: auto 1fr auto 1fr; 
    gap: 12px 16px;
    align-items: center;
}
.in-out-info-grid label {
    font-weight: 500; /* Slightly lighter for readability in dense cards */
    padding-right: 8px;
}

.input-group {
    display: flex;
    gap: 5px;
    width: 100%;
}
.input-group input {
    width: 35% !important;
}
.input-group input:nth-child(2) {
    width: 65% !important;
}

/* Specific alignment for checkboxes (like Collection/Delivery) */
.checkbox-label-end {
    display: flex;
    align-items: center;
    justify-content: flex-end;
    gap: 5px;
}

.btn-group-end {
    grid-column: span 4; /* Span full row in Vehicle In Info */
    text-align: right;
    display: flex;
    justify-content: flex-end;
    gap: 10px;
    margin-top: 10px;
}

/* Styling for status label */
#lblcancelstatus {
    font-size: 14px;
    font-weight: 600;
    color: #6000FC; 
    text-align: center;
    grid-column: span 2;
}

/* Date time inputs styling for jQWidgets */
.jqx-datetimeinput-widget, .jqx-datetimeinput {
    height: 32px !important; 
    line-height: 32px !important;
}

/* SCROLLING FIX */
.hidden-scrollbar {
    overflow-y: visible !important; 
    max-height: none !important; 
    min-height: 1px; 
    padding-right: 5px; 
}
.hidden-scrollbar::-webkit-scrollbar {
    width: 8px; 
    background: #f0f0f0;
}
.hidden-scrollbar::-webkit-scrollbar-thumb {
    background: #c0c0c0;
    border-radius: 4px;
}

/* FILE SPECIFIC STYLES (Kept from original or modified for visual consistency) */
form label.error {
    color:red;
    font-weight:bold;
}

/* Converted original buttons to look like the Master UI buttons but kept class names for functionality */
.myButton1, .myButton4 {
    height: 32px; /* Match input height */
    line-height: 1.5;
    text-shadow: none;
    padding: 0 12px;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    font-size: 14px; /* Slightly larger for consistency */
    font-weight: 500;
    transition: background-color 0.2s, box-shadow 0.2s;
    border-radius: 6px;
}

/* Retaining original colors but applying modern button styling */
.myButton1 {
    background-color: #566963; /* Darker base for grey */
    border: 1px solid #566963;
    color: #ffffff;
}
.myButton1:hover {
    background-color: #768d87;
    border-color: #768d87;
}

.myButton4 {
    background-color: #e4685d; /* Red base */
    border: 1px solid #e4685d;
    color: #ffffff;
}
.myButton4:hover {
    background-color: #eb675e;
    border-color: #eb675e;
}
.myButton1:active, .myButton4:active {
    position: relative;
    top: 1px;
}

.bounce {
    color: #f35626;
    background-image: -webkit-linear-gradient(92deg,#f35626,#feab3a);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    -webkit-animation: hue 60s infinite linear,bounce 2s infinite; 
}
/* Other bounce/font-face styles are functional/visual effects and are kept as-is */

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

/* New style for the buttons container in the smaller right block */
.buttons-container {
    padding-top: 15px; /* Add some space above the buttons */
    text-align: center;
}

#formdet {
    display: block;
    text-align: left !important;
    width: 100%;
    margin-left: 0;


</style>
 
<script type="text/javascript">

	$(document).ready(function () {   
		
	    document.getElementById("formdet").innerText="Leave Setup(LSP)";
		document.getElementById("formdetail").value="Leave Setup";
		document.getElementById("formdetailcode").value="LSP";
		window.parent.formCode.value="LSP";
		window.parent.formName.value="Leave Setup";
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
			   $.messager.alert('Message',$('#msg').val()); document.getElementById("newmode").value=='Saved'
			  } */
		 //document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
			
			  if(document.getElementById("newmode").value=='Saved') {
				   var leaveid=document.getElementById("leaveid").value;
				   var refno= document.getElementById("refno").value;
				   $("#lsetup1").load("leavesetupgrid.jsp?docno="+refno);
				  
				   var disdata="hide";
				  
	        	   $("#lsetup2").load("condtiongrid.jsp?docno="+refno+"&leaveid="+leaveid+"&disdata="+disdata);
	        	   document.getElementById("showlabel").innerText=document.getElementById("hidshowlabel").value;
	        	   
	               $.messager.alert('Message', '  Record successfully Updated ');
	        	   	funReadOnly();
				   } else if(document.getElementById("newmode").value=='notSaved') {
				      $.messager.alert('Message', '  Not Updated ');
				  } 
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
								  
								  $("#lsetup1").load("leavesetupgrid.jsp?docno="+refno);
								  var disdata="hide";
					        	  $("#lsetup2").load("condtiongrid.jsp?docno="+refno+"&leaveid="+leaveid+"&disdata="+disdata);
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
	    		/* return 1; */
		} 
	     
	     function funFocus(){}
	  
</script>  
 
</head>
<body onLoad="setValues();" >
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmleavesetup" action="saveLeavesetup" method="post" autocomplete="off"> 
    <jsp:include page="../../../../../header.jsp" />
	
    <div class='hidden-scrollbar' style="padding: 10px;">

        <div class="section-block">
            <h2>Leave Setup</h2> 
            
            <div class="agmt-info-grid">
                
                <label for="refno">Ref No</label> 
                <div style="grid-column: span 1;">
                    <input type="text" placeholder="Press F3 To Search" onKeyDown="gethrsetup(event);" name="refno" id="refno" value='<s:property value="refno"/>'>
                </div>

                <label for="category">Category</label>
                <div style="grid-column: span 1;">
                    <input type="text" name="category" id="category" value='<s:property value="category"/>'>
                </div>

                <div style="grid-column: span 2; text-align: center;">
                    <label id="showlabel" class="bounce" style="font-size: 13px; font-family: Tahoma; color:#6000FC" value='<s:property value="showlabel"/>'></label>
                </div>
            </div>
        </div>
        
        <div class="section-row" style="margin-top: 20px;">
            
            <div class="section-block">
                <h2>Leave Details</h2>
                <div id="lsetup1"> 
                    <jsp:include page="leavesetupgrid.jsp"></jsp:include>
                </div>
            </div>

            <div class="section-block" style="flex-basis: 350px; flex-grow: 0;">
                <h2>Leave Conditions</h2>
                <div id="lsetup2"> 
                    <jsp:include page="condtiongrid.jsp"></jsp:include>
                </div>
                
                <div class="buttons-container">
                    <input type="button" id="savebtn" class="myButton1" onclick="funsave();" value="Save">
                    &nbsp;&nbsp;&nbsp;&nbsp; 
                    <input type="button" id="deltbtn" onclick="fundel()" class="myButton4" value="Delete">
                </div>
            </div>
            
        </div>
        
        <input type="hidden" id="docno" name="docno" value='<s:property value="docno"/>' />
        <input type="hidden" id="hidshowlabel" name="hidshowlabel" value='<s:property value="hidshowlabel"/>' />
        <input type="hidden" id="leaveid" name="leaveid" value='<s:property value="leaveid"/>' />
        <input type="hidden" id="newmode" name="newmode" value='<s:property value="newmode"/>' />
        <input type="hidden" id="algridlength" name="algridlength" value='<s:property value="algridlength"/>' />
        <input type="hidden" id="catid" name="catid" value='<s:property value="catid"/>' />
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/> 
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 

    </div>
</form>

<div id="refSearchwindow">
    <div></div>
</div> 
</div>
</body>
</html>