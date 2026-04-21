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
#bankdetails-form-container {
    padding-top: 15px;
    width: 100%;
}

/* Scoped Fieldsets (Replaces the .middle-panel logic cleanly) */
#bankdetails-form-container .master-fieldset {
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 20px 15px 15px 15px;
    margin-bottom: 25px;
    background-color: transparent; 
}

/* The Blue Left-Border Title */
#bankdetails-form-container .master-legend {
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
#bankdetails-form-container .master-row {
    display: flex;
    align-items: center;
    margin-bottom: 12px;
    gap: 15px;
}

/* Right aligned labels */
#bankdetails-form-container .master-label {
    font-size: 13px;
    font-weight: 600;
    color: #1e293b;
    text-align: right;
    min-width: 80px;
    white-space: nowrap;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

/* Strict custom class for inputs so it NEVER affects the header */
#bankdetails-form-container .master-input {
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

#bankdetails-form-container .master-input:focus {
    border-color: #3b82f6;
    outline: none;
    box-shadow: 0 0 0 1px #3b82f6;
}

#bankdetails-form-container .master-input[readonly],
#bankdetails-form-container .master-input:disabled {
    background-color: #f8f9fa;
    color: #6b7280;
}

/* Search Icon Wrapper */
#bankdetails-form-container .search-wrapper {
    position: relative;
    display: flex;
    flex: 1;
}
#bankdetails-form-container .search-wrapper input {
    padding-right: 28px !important;
}
#bankdetails-form-container .search-wrapper svg {
    position: absolute;
    right: 6px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
#bankdetails-form-container .search-wrapper svg:hover { color: #007bff; }

/* Grid Container */
.grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    overflow: hidden;
    background: #fff;
    margin-top: 10px;
}
</style>

<%@page import="com.humanresource.setup.hrsetup.bankdetails.ClsBankdetailsDAO"%>
<% ClsBankdetailsDAO DAO = new ClsBankdetailsDAO(); %>

<script type="text/javascript">
	$(document).ready(function () {  
	    if(document.getElementById("formdet")) document.getElementById("formdet").innerText="Bank Details(BDS)";
		if(document.getElementById("formdetail")) document.getElementById("formdetail").value="Bank Details";
		if(document.getElementById("formdetailcode")) document.getElementById("formdetailcode").value="BDS";
		if(window.parent && window.parent.formCode) window.parent.formCode.value="BDS";
		if(window.parent && window.parent.formName) window.parent.formName.value="Bank Details";
		
        /* FIXED DATE WIDTHS & HEIGHTS (26px) */
		$("#bankdate").jqxDateTimeInput({ width: '140px', height: '26px' ,formatString : "dd.MM.yyyy", theme: 'energyblue' });
		
        /* Force internal alignment AFTER render */
        setTimeout(function () {
            $("#bankdate").find("input").css({
                "margin-top": "0px", 
                "line-height": "26px", 
                "font-size": "13px", 
                "font-family": "Arial, sans-serif",
                "padding": "0 8px", 
                "box-sizing":"border-box"
            });
            $("#bankdate").find(".jqx-action-button").css({"top": "0px", "height": "26px"});
        }, 0);
		 
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
                    
            $('#bankgrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                
                document.getElementById("docno").value= $('#bankgrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("ifsccode").value = $("#bankgrid").jqxGrid('getcellvalue', rowindex1, "ifsccode");
                $("#bankdate").jqxDateTimeInput('val', $("#bankgrid").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("brchname").value = $("#bankgrid").jqxGrid('getcellvalue', rowindex1, "brchname");
                document.getElementById("remarks").value = $("#bankgrid").jqxGrid('getcellvalue', rowindex1, "remarks");
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
	    
    /* SAFE READONLY FUNCTION */
	function funReadOnly() {
	    try {
		    $('#frmbankdetails .master-input').attr('readonly', true);
		    $('#bankdate').jqxDateTimeInput({ disabled: true});
	    } catch(e) { console.error("Error in funReadOnly: ", e); }
	}
	
	/* SAFE REMOVE READONLY FUNCTION */
	function funRemoveReadOnly() {
	    try {
		    $('#frmbankdetails .master-input').attr('readonly', false);
		    $('#bankdate').jqxDateTimeInput({ disabled: false});
		    $('#docno').attr('readonly', true);
		    
    		if ($("#mode").val() == "A") {
    			 $('#bankdate').val(new Date());
    		}
	    } catch(e) { console.error("Error in funRemoveReadOnly: ", e); }
	}
	
    /* SAFE SET VALUES FUNCTION */
	function setValues(){
	    try {
			if($('#datehidden').val()){
				$("#bankdate").jqxDateTimeInput('val', $('#datehidden').val());
			}
			
			if($('#msg').val()!=""){
				  $.messager.alert('Message',$('#msg').val());
			}
			
            if (document.getElementById("formdet") && $('#formdetail').length && $('#formdetailcode').length) {
                 var detailVal = $('#formdetail').val() || "";
                 var codeVal = $('#formdetailcode').val() || "";
                 document.getElementById("formdet").innerText = detailVal + " (" + codeVal.trim() + ")";
            }
	    } catch(e) { console.error("Error in setValues: ", e); }
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
    <jsp:include page="../../../../../header.jsp" />

    <div id="bankdetails-form-container">

        <fieldset class="master-fieldset" style="max-width: 1000px; margin-top: 15px;">
            <legend class="master-legend">Bank Details</legend>
            
            <div class="master-row">
                <label class="master-label" style="width: 60px;">Date</label>
                <div style="width: 140px; flex: none;">
                    <div id="bankdate" name="bankdate" value='<s:property value="bankdate"/>'> </div>
                </div>
                
                <label class="master-label" style="width: 80px; margin-left: 20px;">Branch Name</label>
                <div class="search-wrapper" style="flex: 1; max-width: 350px;">
                    <input type="text" class="master-input" name="brchname" id="brchname" placeholder="Press F3 to Search" value='<s:property value="brchname"/>'>
                    <svg onclick="$('#brchWindow').jqxWindow('open'); brchSearchContent('branchdetailsGrid.jsp');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                
                <label class="master-label" style="width: 60px; margin-left: auto;">Doc No</label>
                <input type="text" class="master-input" name="docno" id="docno" value='<s:property value="docno"/>' readonly="readonly" tabindex="-1" style="width: 120px; flex: none;">
            </div>

            <div class="master-row" style="margin-bottom: 0;">
                <label class="master-label" style="width: 60px;">IFSC Code</label>
                <div class="search-wrapper" style="max-width: 200px;">
                    <input type="text" class="master-input" name="ifsccode" id="ifsccode" placeholder="Press F3 to Search" value='<s:property value="ifsccode"/>'>
                    <svg onclick="$('#ifsccodeWindow').jqxWindow('open'); ifsccodeSearchContent('ifsccodedetailsGrid.jsp');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                
                <label class="master-label" style="width: 80px; margin-left: 20px;">Remarks</label>
                <input type="text" class="master-input" name="remarks" id="remarks" placeholder="Remarks" value='<s:property value="remarks"/>' style="flex: 1;">
            </div>
        </fieldset>

        <div style="display:none;">
            <input type="hidden" id="mode" name="mode"/>
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            <input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/>
            
            <input type="hidden" id="formdetail" name="formdetail" value='<s:property value="formdetail"/>'/>
            <input type="hidden" id="formdetailcode" name="formdetailcode" value='<s:property value="formdetailcode"/>'/>
        </div>

        <fieldset class="master-fieldset" style="padding-bottom: 0; overflow: hidden;">
            <legend class="master-legend">Bank Details List</legend>
            <div class="grid-container">
                <div id="bankgrid"></div>
            </div>
        </fieldset>

    </div>
</form>

<div id="brchWindow"><div></div></div>  
<div id="ifsccodeWindow"><div></div></div>

</div>
</body>
</html>