<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath(); %>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>

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
#allowance-form-container {
    padding-top: 15px;
    width: 100%;
}

/* Scoped Fieldsets (Replaces the .middle-panel logic cleanly) */
#allowance-form-container .master-fieldset {
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 20px 15px 15px 15px;
    margin-bottom: 25px;
    background-color: transparent; 
}

/* The Blue Left-Border Title */
#allowance-form-container .master-legend {
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
#allowance-form-container .master-row {
    display: flex;
    align-items: center;
    margin-bottom: 12px;
    gap: 15px;
}

/* Right aligned labels */
#allowance-form-container .master-label {
    font-size: 13px;
    font-weight: 600;
    color: #1e293b;
    text-align: right;
    min-width: 80px;
    white-space: nowrap;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

/* Strict custom class for inputs so it NEVER affects the header */
#allowance-form-container .master-input {
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

#allowance-form-container .master-input:focus {
    border-color: #3b82f6;
    outline: none;
    box-shadow: 0 0 0 1px #3b82f6;
}

#allowance-form-container .master-input[readonly],
#allowance-form-container .master-input:disabled {
    background-color: #f8f9fa;
    color: #6b7280;
}

/* Search Icon Wrapper */
#allowance-form-container .search-wrapper {
    position: relative;
    display: flex;
    flex: 1;
}
#allowance-form-container .search-wrapper input {
    padding-right: 28px !important;
}
#allowance-form-container .search-wrapper svg {
    position: absolute;
    right: 6px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
#allowance-form-container .search-wrapper svg:hover { color: #007bff; }

/* Grid Container */
.grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    overflow: hidden;
    background: #fff;
    margin-top: 10px;
}
</style>

<%@page import="com.humanresource.setup.hrsetup.allowances.ClsAllowancesDAO"%>
<% ClsAllowancesDAO showDAO = new ClsAllowancesDAO(); %>  

<script type="text/javascript">
	$(document).ready(function () {   
	    if(document.getElementById("formdet")) document.getElementById("formdet").innerText="Allowance(ALC)";
		if(document.getElementById("formdetail")) document.getElementById("formdetail").value="Allowance";
		if(document.getElementById("formdetailcode")) document.getElementById("formdetailcode").value="ALC";
		if(window.parent && window.parent.formCode) window.parent.formCode.value="ALC";
		if(window.parent && window.parent.formName) window.parent.formName.value="Allowance";
		
        /* FIXED DATE WIDTHS & HEIGHTS (26px) */
	    $("#allowancedate").jqxDateTimeInput({ width: '140px', height: '26px' ,formatString : "dd.MM.yyyy", theme: 'energyblue' });
	    
        /* Force internal alignment AFTER render */
        setTimeout(function () {
            $("#allowancedate").find("input").css({
                "margin-top": "0px", 
                "line-height": "26px", 
                "font-size": "13px", 
                "font-family": "Arial, sans-serif",
                "padding": "0 8px", 
                "box-sizing":"border-box"
            });
            $("#allowancedate").find(".jqx-action-button").css({"top": "0px", "height": "26px"});
        }, 0);
	    
	    $('#accountSearchwindow').jqxWindow({ width: '60%', height: '62%',  maxHeight: '75%' ,maxWidth: '60%' , title: 'Account Search' ,position: { x: 150, y: 60 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#accountSearchwindow').jqxWindow('close');
		   
		$('#acno').dblclick(function(){
		    if($('#mode').val()!= "view") {
			 	 $('#accountSearchwindow').jqxWindow('open');
			 	 accountSearchContent('accountsDetailsSearch.jsp');
		    }
		});   
		   
            var alcdata='<%=showDAO.searchAllowance()%>';
             
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
                          	{name : 'code', type: 'String'  },
     						{name : 'allowance', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                          	{name : 'acno', type: 'String'  },
                         	{name : 'accname', type: 'String'  },
                          	{name : 'remarks', type: 'String'  },
                         	{name : 'accdocno', type: 'String'  },
                 ],
               		localdata: alcdata,

               	 pager: function (pagenum, pagesize, oldpagenum) {
                     // callback called when a page or page size is changed.
                 }
             };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            	$("#allowancegrid").jqxGrid(
                    {
                    	width: '100%',
                        height: 375,
                        source: dataAdapter,
                        selectionmode: 'singlerow',
             			editable: false,
             			columnsresize: true,
             			showfilterrow: true,
                        filterable: true,
                        
                        columns: [
									{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '7%' },
									{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy' },
									{ text: 'Allowance Code',columntype: 'textbox', filtertype: 'input', datafield: 'code', width: '8%' },
									{ text: 'Allowance Name',columntype: 'textbox', filtertype: 'input', datafield: 'allowance', width: '15%' },
									{ text: 'Account',columntype: 'textbox', filtertype: 'input', datafield: 'acno', width: '10%' },
									{ text: 'Account Name',columntype: 'textbox', filtertype: 'input', datafield: 'accname', width: '25%' },
									{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '28%' },
									{ text: 'Account Doc No',columntype: 'textbox', filtertype: 'input', datafield: 'accdocno', width: '10%' ,hidden: true},
            					]
                    });
            	
         $('#allowancegrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#allowancegrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("allowancecode").value = $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "code");
                document.getElementById("allowance").value = $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "allowance");
                $("#allowancedate").jqxDateTimeInput('val', $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("remarks").value = $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "remarks");
                document.getElementById("acno").value = $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "acno");
                document.getElementById("accname").value = $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "accname");
                document.getElementById("accdocno").value = $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "accdocno");
                
            });   
        });

	function funSearchLoad(){
		 changeContent('allowancessearch.jsp'); 
	 }
 
     function accountSearchContent(url) {
          $.get(url).done(function (data) {
          	$('#accountSearchwindow').jqxWindow('setContent', data);
  	      }); 
      	}
  	  
    /* SAFE READONLY FUNCTION */
	function funReadOnly() {
	    try {
    		$('#frmallowance .master-input').attr('readonly', true);
    		$('#allowancedate').jqxDateTimeInput({ disabled: true});
	    } catch(e) { console.error("Error in funReadOnly:", e); }
	}
	
    /* SAFE REMOVE READONLY FUNCTION */
	function funRemoveReadOnly() {
	    try {
    		$('#frmallowance .master-input').attr('readonly', false);
    		$('#docno').attr('readonly', true);
    		$('#acno').attr('readonly', true);
    		$('#accname').attr('readonly', true);
    		$('#allowancedate').jqxDateTimeInput({ disabled: false});
    		
    		if ($("#mode").val() == "A") {
    			 $('#allowancedate').val(new Date());
    		}
	    } catch(e) { console.error("Error in funRemoveReadOnly:", e); }
	}
 
    /* SAFE SET VALUES FUNCTION */
	function setValues() {
	    try {
    		if($('#datehidden').length && $('#datehidden').val()){
    			$("#allowancedate").jqxDateTimeInput('val', $('#datehidden').val());
    		}
    		
    		if($('#msg').length && $('#msg').val()!=""){
    			   $.messager.alert('Message',$('#msg').val());
    		}
    		
            if (document.getElementById("formdet") && $('#formdetail').length && $('#formdetailcode').length) {
                var detailVal = $('#formdetail').val() || "";
                var codeVal = $('#formdetailcode').val() || "";
                document.getElementById("formdet").innerText = detailVal + " (" + codeVal.trim() + ")";
            }
	    } catch(e) { console.error("Error in setValues:", e); }
	}
	
	function getaccountdetails(event){
	 	 var x= event.keyCode;
	   	
	     if($('#mode').val()!="view") {
	 	    if(x==114){
	 	  	   $('#accountSearchwindow').jqxWindow('open');
	 	 	   accountSearchContent('accountsDetailsSearch.jsp');   
	 	    }
	 	 }
	}
 
	     function funNotify(){
	        	if(document.getElementById("allowance").value=="")
        		{
        		document.getElementById("errormsg").innerText=" Enter Allowance";
        		document.getElementById("allowance").focus();
        		return 0;
        		}
	        	
	        	if(document.getElementById("acno").value=="")
        		{
        		document.getElementById("errormsg").innerText=" Search Account";
        		document.getElementById("acno").focus();
        		return 0;
        		}
	    		return 1;
		} 
	     
	     function funFocus(){
	    		$('#allowancedate').jqxDateTimeInput('focus');
	     }
	  
</script>   
 
</head>
<body onload="setValues();">

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmallowance" action="saveAllowance" method="post" autocomplete="off">
    <jsp:include page="../../../../header.jsp" />

    <div id="allowance-form-container">

        <fieldset class="master-fieldset" style="max-width: 1000px; margin-top: 15px;">
            <legend class="master-legend">Allowance Details</legend>
            
            <div class="master-row">
                <label class="master-label" style="width: 50px;">Date</label>
                <div style="width: 140px; flex: none;">
                    <div id="allowancedate" name="allowancedate" value='<s:property value="allowancedate"/>'></div>
                </div>
                
                <label class="master-label" style="width: 110px; margin-left: 20px;">Allowance Code</label>
                <input type="text" class="master-input" name="allowancecode" id="allowancecode" placeholder="Allowance Code" value='<s:property value="allowancecode"/>' style="width: 120px; flex: none;">
                
                <label class="master-label" style="width: 110px; margin-left: 20px;">Allowance Name</label>
                <input type="text" class="master-input" name="allowance" id="allowance" placeholder="Allowance Name" value='<s:property value="allowance"/>' style="flex: 1; max-width: 300px;">
                
                <label class="master-label" style="width: 60px; margin-left: auto;">Doc No</label>
                <input type="text" class="master-input" name="docno" id="docno" value='<s:property value="docno"/>' readonly="readonly" tabindex="-1" style="width: 100px; flex: none;">
            </div>

            <div class="master-row">
                <label class="master-label" style="width: 50px;">Account</label>
                
                <div class="search-wrapper" style="max-width: 180px;">
                    <input type="text" class="master-input" name="acno" id="acno" placeholder="Press F3 To Search" readonly="readonly" onkeydown="getaccountdetails(event);" value='<s:property value="acno"/>'>
                    <svg onclick="$('#accountSearchwindow').jqxWindow('open'); accountSearchContent('accountsDetailsSearch.jsp');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                
                <input type="text" class="master-input" name="accname" id="accname" readonly="readonly" value='<s:property value="accname"/>' style="flex: 1; max-width: 400px; margin-left: 10px;">
            </div>

            <div class="master-row" style="margin-bottom: 0;">
                <label class="master-label" style="width: 50px;">Remarks</label>
                <input type="text" class="master-input" name="remarks" id="remarks" placeholder="Remarks" value='<s:property value="remarks"/>' style="flex: 1;">
            </div>
        </fieldset>

        <div style="display:none;">
            <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/> 
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 
            <input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/> 
            <input type="hidden" name="accdocno" id="accdocno" value='<s:property value="accdocno"/>' >
            
            <input type="hidden" id="formdetail" name="formdetail" value='<s:property value="formdetail"/>'/>
            <input type="hidden" id="formdetailcode" name="formdetailcode" value='<s:property value="formdetailcode"/>'/>
        </div>

        <fieldset class="master-fieldset" style="padding-bottom: 0; overflow: hidden;">
            <legend class="master-legend">Allowance List</legend>
            <div class="grid-container">
                <div id="allowancegrid" style="width: 100%;"></div>
            </div>
        </fieldset>

    </div>
</form>

<div id="accountSearchwindow"><div></div></div>

</div>
</body>
</html>