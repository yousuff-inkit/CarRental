<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<%
String contextPath=request.getContextPath();
%>
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
    font: 16px;
    color: #253858;
    white-space: nowrap;
    line-height: 32px; /* Aligns with input heights */
    padding: 0px 8px 0px 0px; 
    text-align: right; 
    font-weight: 500;
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

#formdet {
    display: block;
    text-align: left !important;
    width: 100%;
    margin-left: 0;
}

</style>

<%@page import="com.humanresource.setup.hrsetup.bankdetails.ClsBankdetailsDAO"%>
<% ClsBankdetailsDAO DAO = new ClsBankdetailsDAO(); %>
<script type="text/javascript">

	$(document).ready(function () {    
	    document.getElementById("formdet").innerText="Bank Details(BDS)";
		document.getElementById("formdetail").value="Bank Details";
		document.getElementById("formdetailcode").value="BDS";
		window.parent.formCode.value="BDS";
		window.parent.formName.value="Bank Details";
		
		$("#bankdate").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
		 
	    
	    $('#ifsccodeWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '27%' , title: 'IFSC Code Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#ifsccodeWindow').jqxWindow('close');
 		 
	    
	    $('#brchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '30%' , title: 'Branch Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#brchWindow').jqxWindow('close');
  		
 		$('#brchname').dblclick(function(){
 			brchSearchContent("branchdetailsGrid.jsp");
		  });
 		
	    $('#ifsccode').dblclick(function(){
	    	ifsccodeSearchContent("ifsccodedetailsGrid.jsp");
		 });

     
	    var deptdata= '<%=DAO.loadgrid() %>'; 
  
	    var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'ifsccode', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                          	{name : 'brchname', type: 'String'  },
                        	{name : 'remarks', type: 'String'  }
                 ],
               	 localdata: deptdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
	    
	        var dataAdapter = new $.jqx.dataAdapter(source);
    
            $("#bankgrid").jqxGrid(
                  {
                  	width: "100%",
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                        
                    columns: [
	        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
	        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy' },
	        					{ text: 'IFSC Code',columntype: 'textbox', filtertype: 'input', datafield: 'ifsccode', width: '15%' },
	        					{ text: 'Branch Name',columntype: 'textbox', filtertype: 'input', datafield: 'brchname',width:'30%' },
	        					{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks' },
	             	           
	        					]
                    });
	}); 

            
            function getbrchname(event){
     	        var x= event.keyCode;
	        if(x==114){
	        	brchSearchContent("branchdetailsGrid.jsp");
	        }
	        else{}
	        }
	    
		function brchSearchContent(url) {
		 	$('#brchWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#brchWindow').jqxWindow('setContent', data);
			$('#brchWindow').jqxWindow('bringToFront');
		}); 
		}
	  
	    function getifsccode(event){
	          var x= event.keyCode;
	          if(x==114){
	        	  ifsccodeSearchContent("ifsccodedetailsGrid.jsp");
	          }
	          else{}
	          }
	   
	    function ifsccodeSearchContent(url) {
			$('#ifsccodeWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#ifsccodeWindow').jqxWindow('setContent', data);
			$('#ifsccodeWindow').jqxWindow('bringToFront');
		}); 
		}
	    
            function funReadOnly() {
    			$('#frmbankdetails input').attr('readonly', true);
    		 
    		}
    		function funRemoveReadOnly() {
    			$('#frmbankdetails input').attr('readonly', false);
    		}
    	
    		function setValues(){
    			if($('#datehidden').val()){
    				$("#bankdate").jqxDateTimeInput('val', $('#datehidden').val());
    			}
    			
    			if($('#msg').val()!=""){
    				  $.messager.alert('Message',$('#msg').val());
    			}
    		}
    	 
    		function funNotify(){
            	if(document.getElementById("brchname").value=="") {
            		
            		document.getElementById("errormsg").innerText=" Enter Branch Name";
            		document.getElementById("brchname").focus();
            		return 0;
            	}
        		return 1;
    	}
    		 function funFocus(){
    			 
    		 }
    		 
    		 function funSearchLoad(){
    			 changeContent('loadsearchGrid.jsp'); 
    		 }

	
	</script>   
	 
	</head>
	<body onLoad="setValues();" >
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmbankdetails" action="saveBankdetails" method="post" autocomplete="off">
    <jsp:include page="../../../../../header.jsp" /><br/>

    <div class='hidden-scrollbar' style="padding: 10px;">

        <div class="section-block" style="margin-bottom: 20px;">
            <h2>Bank Details</h2> 
            
            <div class="agmt-info-grid">
                
                <label for="bankdate">Date</label>
                <div>
                    <div id="bankdate" name="bankdate" value='<s:property value="bankdate"/>'> </div>
                </div>
                
                <label for="brchname">Branch Name</label>
                <div>
                    <input type="text" name="brchname" id="brchname" placeholder="Press F3 to Search" value='<s:property value="brchname"/>'>
                </div>
                
                <label for="docno">Doc No</label>
                <div>
                    <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly="readonly" tabindex="-1">
                </div>
                
                <label for="ifsccode">IFSC Code</label>
                <div>
                    <input type="text" name="ifsccode" id="ifsccode" placeholder="Press F3 to Search" value='<s:property value="ifsccode"/>'>
                </div>

               

                <label for="remarks">Remarks</label>
                <div style="grid-column: span 3;"> 
                    <input type="text" name="remarks" id="remarks" placeholder="Remarks" value='<s:property value="remarks"/>' >
                </div>
                
            </div>
        </div>

        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/>
        
    </div>
</form>

<table width="100%">
    <tr><td><div id="bankgrid"></div></td></tr>
</table><br/>

<div id="brchWindow">
    <div></div>
</div>	
<div id="ifsccodeWindow">
    <div></div>
</div>
</div>
</body>
</html>