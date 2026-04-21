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
#compsetup-form-container {
    padding-top: 15px;
    width: 100%;
}

/* Scoped Fieldsets (Replaces the .middle-panel logic cleanly) */
#compsetup-form-container .master-fieldset {
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 20px 15px 15px 15px;
    margin-bottom: 25px;
    background-color: transparent; 
}

/* The Blue Left-Border Title */
#compsetup-form-container .master-legend {
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
#compsetup-form-container .master-row {
    display: flex;
    align-items: center;
    margin-bottom: 12px;
    gap: 15px;
}

/* Right aligned labels */
#compsetup-form-container .master-label {
    font-size: 13px;
    font-weight: 600;
    color: #1e293b;
    text-align: right;
    min-width: 80px;
    white-space: nowrap;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

/* Strict custom class for inputs so it NEVER affects the header */
#compsetup-form-container .master-input {
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

#compsetup-form-container .master-input:focus {
    border-color: #3b82f6;
    outline: none;
    box-shadow: 0 0 0 1px #3b82f6;
}

#compsetup-form-container .master-input[readonly],
#compsetup-form-container .master-input:disabled {
    background-color: #f8f9fa;
    color: #6b7280;
}

/* Search Icon Wrapper */
#compsetup-form-container .search-wrapper {
    position: relative;
    display: flex;
    flex: 1;
}
#compsetup-form-container .search-wrapper input {
    padding-right: 28px !important;
}
#compsetup-form-container .search-wrapper svg {
    position: absolute;
    right: 6px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
#compsetup-form-container .search-wrapper svg:hover { color: #007bff; }

/* Grid Container */
.grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    overflow: hidden;
    background: #fff;
    margin-top: 10px;
}
</style>

<%@page import="com.humanresource.setup.hrsetup.companysetup.ClsCompanysetupDAO"%>
<% ClsCompanysetupDAO DAO = new ClsCompanysetupDAO(); %>

<script type="text/javascript"> 

	$(document).ready(function () {   
		
	    if(document.getElementById("formdet")) document.getElementById("formdet").innerText="Company Setup(CMS)";
		if(document.getElementById("formdetail")) document.getElementById("formdetail").value="Company Setup";
		if(document.getElementById("formdetailcode")) document.getElementById("formdetailcode").value="CMS";
		if(window.parent && window.parent.formCode) window.parent.formCode.value="CMS";
		if(window.parent && window.parent.formName) window.parent.formName.value="Company Setup";
			
        /* FIXED DATE WIDTHS & HEIGHTS (26px) */
		$("#compdate").jqxDateTimeInput({ width: '140px', height: '26px' ,formatString : "dd.MM.yyyy", theme: 'energyblue' });
		
        /* Force internal alignment AFTER render */
        setTimeout(function () {
            $("#compdate").find("input").css({
                "margin-top": "0px", 
                "line-height": "26px", 
                "font-size": "13px", 
                "font-family": "Arial, sans-serif",
                "padding": "0 8px", 
                "box-sizing":"border-box"
            });
            $("#compdate").find(".jqx-action-button").css({"top": "0px", "height": "26px"});
        }, 0);
		   
		$('#compWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '27%' , title: 'Company Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 	$('#compWindow').jqxWindow('close');
	 		
		$('#establishedCodeDetailsWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '30%' , title: 'Establishment Code Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 	$('#establishedCodeDetailsWindow').jqxWindow('close');
	 		
	 	$('#company').dblclick(function(){
	 		compSearchContent("companydetailsGrid.jsp");
		});
	 		
		$('#estcode').dblclick(function(){
		    establishedCodeSearchContent("establishmentCodeDetailsSearchGrid.jsp");
		});

		var deptdata= '<%=DAO.loadgrid() %>'; 
	    var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'estcode', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                          	{name : 'company', type: 'String'  },
                        	{name : 'remarks', type: 'String'  }
                 ],
               	 localdata: deptdata,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
	   
	    var dataAdapter = new $.jqx.dataAdapter(source);
    
        $("#companygrid").jqxGrid(
                 {
                 	width: "100%",
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                        
                    columns: [
	        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
	        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy' },
	        					{ text: 'EST Code',columntype: 'textbox', filtertype: 'input', datafield: 'estcode', width: '15%' },
	        					{ text: 'Company',columntype: 'textbox', filtertype: 'input', datafield: 'company',width:'30%' },
	        					{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks' },
	        					]
                    });
	}); 

    function getEstablishmentCode(event){
         var x= event.keyCode;
	     if(x==114){
	        	establishedCodeSearchContent("establishmentCodeDetailsSearchGrid.jsp");
	     }
	     else{}
	}
	   
	function establishedCodeSearchContent(url) {
		$('#establishedCodeDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
			$('#establishedCodeDetailsWindow').jqxWindow('setContent', data);
			$('#establishedCodeDetailsWindow').jqxWindow('bringToFront');
		}); 
	}
	  
	function getcomp(event){
	      var x= event.keyCode;
	      if(x==114){
	        	compSearchContent("companydetailsGrid.jsp");
	      }
	      else{}
	}
	   
	function compSearchContent(url) {
		$('#compWindow').jqxWindow('open');
		$.get(url).done(function (data) {
			$('#compWindow').jqxWindow('setContent', data);
			$('#compWindow').jqxWindow('bringToFront');
		}); 
	}
	    
    /* SAFE READONLY FUNCTION */
	function funReadOnly() {
	    try {
		    $('#frmcompanysetup .master-input').attr('readonly', true);
		    $('#compdate').jqxDateTimeInput({ disabled: true});
	    } catch(e) { console.error("Error in funReadOnly: ", e); }
	}
	
	/* SAFE REMOVE READONLY FUNCTION */
	function funRemoveReadOnly() {
	    try {
		    $('#frmcompanysetup .master-input').attr('readonly', false);
		    $('#compdate').jqxDateTimeInput({ disabled: false});
		    $('#docno').attr('readonly', true);
	    } catch(e) { console.error("Error in funRemoveReadOnly: ", e); }
	}
	
    /* SAFE SET VALUES FUNCTION */
	function setValues(){
	    try {
			if($('#datehidden').length && $('#datehidden').val()){
				$("#compdate").jqxDateTimeInput('val', $('#datehidden').val());
			}
			
			if($('#msg').length && $('#msg').val()!=""){
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
        	if(document.getElementById("company").value=="") {
        		
        		document.getElementById("errormsg").innerText=" Enter Company";
        		document.getElementById("company").focus();
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
<form id="frmcompanysetup" action="saveCompanysetup" method="post" autocomplete="off">
    <jsp:include page="../../../../../header.jsp" />

    <div id="compsetup-form-container">

        <fieldset class="master-fieldset" style="max-width: 1000px; margin-top: 15px;">
            <legend class="master-legend">Company Setup</legend>
            
            <div class="master-row">
                <label class="master-label" style="width: 50px;">Date</label>
                <div style="width: 140px; flex: none;">
                    <div id="compdate" name="compdate" value='<s:property value="compdate"/>'> </div>
                </div>
                
                <label class="master-label" style="width: 80px; margin-left: 20px;">Company</label>
                <div class="search-wrapper" style="flex: 1; max-width: 350px;">
                    <input type="text" class="master-input" name="company" id="company" placeholder="Press F3 to Search" value='<s:property value="company"/>' onkeydown="getcomp(event);">
                    <svg onclick="$('#compWindow').jqxWindow('open'); compSearchContent('companydetailsGrid.jsp');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                
                <label class="master-label" style="width: 60px; margin-left: auto;">Doc No</label>
                <input type="text" class="master-input" name="docno" id="docno" value='<s:property value="docno"/>' readonly="readonly" tabindex="-1" style="width: 120px; flex: none;">
            </div>

            <div class="master-row" style="margin-bottom: 0;">
                <label class="master-label" style="width: 50px;">Est Code</label>
                <div class="search-wrapper" style="max-width: 250px;">
                    <input type="text" class="master-input" name="estcode" id="estcode" placeholder="Press F3 to Search" value='<s:property value="estcode"/>' onkeydown="getEstablishmentCode(event);">
                    <svg onclick="$('#establishedCodeDetailsWindow').jqxWindow('open'); establishedCodeSearchContent('establishmentCodeDetailsSearchGrid.jsp');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
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
            <legend class="master-legend">Company List</legend>
            <div class="grid-container">
                <div id="companygrid"></div>
            </div>
        </fieldset>

    </div>
</form>

<div id="establishedCodeDetailsWindow"><div></div></div>  
<div id="compWindow"><div></div></div>

</div>
</body>
</html>